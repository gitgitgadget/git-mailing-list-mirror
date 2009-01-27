From: Keith Cascio <keith@CS.UCLA.EDU>
Subject: Re: [PATCH v1 0/3] Introduce config variable "diff.primer"
Date: Mon, 26 Jan 2009 17:47:54 -0800 (PST)
Message-ID: <alpine.GSO.2.00.0901261734360.16158@kiwi.cs.ucla.edu>
References: <1232904657-31831-1-git-send-email-keith@cs.ucla.edu> <7vr62rcee5.fsf@gitster.siamese.dyndns.org> <alpine.GSO.2.00.0901251239000.12651@kiwi.cs.ucla.edu> <20090125220756.GA18855@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Jan 27 02:49:37 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LRd51-0002sH-UM
	for gcvg-git-2@gmane.org; Tue, 27 Jan 2009 02:49:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752648AbZA0BsH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 26 Jan 2009 20:48:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751954AbZA0BsF
	(ORCPT <rfc822;git-outgoing>); Mon, 26 Jan 2009 20:48:05 -0500
Received: from Kiwi.CS.UCLA.EDU ([131.179.128.19]:63673 "EHLO kiwi.cs.ucla.edu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750989AbZA0BsE (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Jan 2009 20:48:04 -0500
Received: from kiwi.cs.ucla.edu (localhost.cs.ucla.edu [127.0.0.1])
	by kiwi.cs.ucla.edu (8.13.8+Sun/8.13.8/UCLACS-6.0) with ESMTP id n0R1ltTp022038;
	Mon, 26 Jan 2009 17:47:55 -0800 (PST)
Received: from localhost (keith@localhost)
	by kiwi.cs.ucla.edu (8.13.8+Sun/8.13.8/Submit) with ESMTP id n0R1ls9k022035;
	Mon, 26 Jan 2009 17:47:55 -0800 (PST)
X-Authentication-Warning: kiwi.cs.ucla.edu: keith owned process doing -bs
In-Reply-To: <20090125220756.GA18855@coredump.intra.peff.net>
User-Agent: Alpine 2.00 (GSO 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/107298>

On Sun, 25 Jan 2009, Jeff King wrote:

> let's say I have a gitattributes file like this:
>    *.c diff=c
> and my config says:
>   [diff]
>     opt1 = val1_default
>     opt2 = val2_default
>   [diff "c"]
>     opt1 = val1_c
> 
> Now obviously if I want to use opt1 for my C files, it should be val1_c.
> But if I want to use opt2, what should it use? There are two reasonable
> choices, I think:
>   1. You use val2_default. The rationale is that the "c" diff driver did
>      not define an opt2, so you fall back to the global default.
>   2. It is unset. The rationale is that you are using the "c" diff
>      driver, and it has left the value unset. The default then means "if
>      you have no diff driver setup".

I'm in favor of option (2), because [diff] a.k.a [diff ""] serving as the 
fallback for [diff *] feels like a special case.  If a full system of precedence 
and fallbacks is desired for .git/config, we should adopt explicit grammar that 
lets me define an arbitrary precedence tree over all sections.  Once a powerful 
concept is born, somewhere down the road, some user will desire its 
universalization.
