From: Keith Cascio <keith@CS.UCLA.EDU>
Subject: Re: diff.defaultOptions implementation design [was diff.primer]
Date: Mon, 16 Feb 2009 23:24:33 -0800 (PST)
Message-ID: <alpine.GSO.2.00.0902162312030.17111@kiwi.cs.ucla.edu>
References: <1233598855-1088-1-git-send-email-keith@cs.ucla.edu> <1233598855-1088-2-git-send-email-keith@cs.ucla.edu> <20090203071516.GC21367@sigill.intra.peff.net> <alpine.GSO.2.00.0902030833250.5994@kiwi.cs.ucla.edu> <20090206161954.GA18956@coredump.intra.peff.net>
 <alpine.GSO.2.00.0902090921270.719@kiwi.cs.ucla.edu> <20090213222233.GA7424@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Feb 17 08:26:12 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LZKLJ-00055I-MP
	for gcvg-git-2@gmane.org; Tue, 17 Feb 2009 08:26:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751121AbZBQHYl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Feb 2009 02:24:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751110AbZBQHYl
	(ORCPT <rfc822;git-outgoing>); Tue, 17 Feb 2009 02:24:41 -0500
Received: from Kiwi.CS.UCLA.EDU ([131.179.128.19]:41707 "EHLO kiwi.cs.ucla.edu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750848AbZBQHYk (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Feb 2009 02:24:40 -0500
Received: from kiwi.cs.ucla.edu (localhost.cs.ucla.edu [127.0.0.1])
	by kiwi.cs.ucla.edu (8.13.8+Sun/8.13.8/UCLACS-6.0) with ESMTP id n1H7OYfe018100;
	Mon, 16 Feb 2009 23:24:34 -0800 (PST)
Received: from localhost (keith@localhost)
	by kiwi.cs.ucla.edu (8.13.8+Sun/8.13.8/Submit) with ESMTP id n1H7OYWm018097;
	Mon, 16 Feb 2009 23:24:34 -0800 (PST)
X-Authentication-Warning: kiwi.cs.ucla.edu: keith owned process doing -bs
In-Reply-To: <20090213222233.GA7424@coredump.intra.peff.net>
User-Agent: Alpine 2.00 (GSO 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/110320>

Peff,

On Fri, 13 Feb 2009, Jeff King wrote:

> So I think doing it right is a bit more work in the long run, but the extra 
> work is generally improving git.
> 
> All that being said, though, I still think we can do the equivalent of 
> --no-primer. The trick to avoiding multiple passes is for the option to exist 
> outside of the set of primer'd options.

I like the idea of using parse-options to handle diff options and I too would 
like all switches negatable.  I will come back to the other ideas you mention if 
necessary.  You laid it all out nicely.

Assuming we can do away with the switches --[no-]default-options, thereby 
hopefully eliminating the need to accumulate options in any kind of fancy way, 
certainly the right place to "walk" is in diff_setup().  But diff_setup() must 
still ascertain at least one runtime fact: whether or not we are running one of 
the commands that respects default options {diff, log, show}.  Is there an 
elegant way to ascertain that fact from inside diff_setup()?  How do you 
recommend?  (BTW I believe my design achieves this elegantly).

                                       -- Keith
