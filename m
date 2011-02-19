From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [RFC/PATCH 4/4] inexact rename detection eye candy
Date: Sat, 19 Feb 2011 07:57:57 -0800
Message-ID: <AANLkTik=pd3vVMERz=H3sp835Ft8OvrOzBE4PUS7vrO7@mail.gmail.com>
References: <20110219101936.GB20577@sigill.intra.peff.net> <20110219102533.GD22508@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Junio C Hamano <gitster@pobox.com>,
	Martin Langhoff <martin.langhoff@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sat Feb 19 16:58:53 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PqpCt-0005j9-Te
	for gcvg-git-2@lo.gmane.org; Sat, 19 Feb 2011 16:58:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751458Ab1BSP6r (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 19 Feb 2011 10:58:47 -0500
Received: from smtp1.linux-foundation.org ([140.211.169.13]:38027 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750952Ab1BSP6r (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 19 Feb 2011 10:58:47 -0500
Received: from mail-iw0-f174.google.com (mail-iw0-f174.google.com [209.85.214.174])
	(authenticated bits=0)
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id p1JFwHHb004206
	(version=TLSv1/SSLv3 cipher=RC4-SHA bits=128 verify=FAIL)
	for <git@vger.kernel.org>; Sat, 19 Feb 2011 07:58:17 -0800
Received: by iwn8 with SMTP id 8so442881iwn.19
        for <git@vger.kernel.org>; Sat, 19 Feb 2011 07:58:17 -0800 (PST)
Received: by 10.231.19.136 with SMTP id a8mr1489988ibb.73.1298131097080; Sat,
 19 Feb 2011 07:58:17 -0800 (PST)
Received: by 10.231.16.129 with HTTP; Sat, 19 Feb 2011 07:57:57 -0800 (PST)
In-Reply-To: <20110219102533.GD22508@sigill.intra.peff.net>
X-Spam-Status: No, hits=-103.461 required=5 tests=AWL,BAYES_00,OSDL_HEADER_SUBJECT_BRACKETED,USER_IN_WHITELIST
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167294>

On Sat, Feb 19, 2011 at 2:25 AM, Jeff King <peff@peff.net> wrote:
>
> This feels wrong because it's in such a deep library function. At the
> very least we probably need some way to turn it off, so callers can pass
> along any --quiet or --no-progress indicators.

Yeah.

> I made it update progress for each of the rename_src * rename_dst
> similarity estimates. We could just as easily count rename_dst items we
> look at, but hey, it's eye candy, and obviously bigger numbers are
> better.

Uhh. My only big reaction to your patch was literally "why don't you
just do it on the 'dst' items". I really don't think bigger numbers
are better, and if you have _so_ many sources that each dst takes so
long that you'd want updates at that granularity, you're too screwed
anyway.

Don't make the "update progress" be part of the O(n^2) problem.

                  Linus
