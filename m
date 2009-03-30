From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: [Q] merging from one (kernel) stable to another?
Date: Mon, 30 Mar 2009 13:31:18 -0400 (EDT)
Message-ID: <alpine.LNX.1.00.0903301311230.19665@iabervon.org>
References: <200903301024.08848.brian.foster@innova-card.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="1547844168-955355923-1238434278=:19665"
Cc: git mailing list <git@vger.kernel.org>
To: Brian Foster <brian.foster@innova-card.com>
X-From: git-owner@vger.kernel.org Mon Mar 30 19:35:53 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LoLM9-00050i-Fb
	for gcvg-git-2@gmane.org; Mon, 30 Mar 2009 19:33:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753811AbZC3RbW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 30 Mar 2009 13:31:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753540AbZC3RbV
	(ORCPT <rfc822;git-outgoing>); Mon, 30 Mar 2009 13:31:21 -0400
Received: from iabervon.org ([66.92.72.58]:56265 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753096AbZC3RbV (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Mar 2009 13:31:21 -0400
Received: (qmail 9054 invoked by uid 1000); 30 Mar 2009 17:31:18 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 30 Mar 2009 17:31:18 -0000
In-Reply-To: <200903301024.08848.brian.foster@innova-card.com>
User-Agent: Alpine 1.00 (LNX 882 2007-12-20)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115176>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--1547844168-955355923-1238434278=:19665
Content-Type: TEXT/PLAIN; charset=utf-8
Content-Transfer-Encoding: 8BIT

On Mon, 30 Mar 2009, Brian Foster wrote:

>   Whilst this question involves linux(-mips) kernel tree,
>  it's a git(-related?) question, not a kernel question ....
> 
>   We are currently in the process of upgrading our embedded
>  system from kernel 2.6.21(-ish) to at least 2.6.26.8;  and
>  later, at some time in the future on to 2.6.3x or something.
>  Going from 2.6.21 to .22 to .23 and so on to .26, then to
>  .26.1 and so on to .26.8 is “easy” in the sense there are
>  very few conflicts with our existing baseline (e.g., just
>  2 or 3 in 2 or 3 files).
> 
>   .21 --> me --> .22 --> .23 ... --> .26 --> .27 --> master
>      \              \       \           \      \
>      .21-stable  .22-stable .23-stable   \     .27-stable
>                                         .26.8
>                                            \
>                                            .26-stable
> 
>   But (using 2.6.21-stable and 2.6.22-stable as proxies),
>  tests indicate that going from .26.8 to .27 or anything
>  later will have numerous conflicts (100s? in more than
>  30 files).  Thinking about it, this isn't too surprising
>  since the -stable branches cherry-pick important/benign
>  fixes from later revisions.

Why are you going from .26.8 to .27? Based on the -stable policy, there 
should be no reason not to skip .26.x between .26 and .27. In fact, it's 
not unlikely that merging both .26.8 and .27 will introduce bugs when the 
same issue was fixed in different places in the two branches: a narrow 
patch to paper over the identified problem in -stable and an intrusive 
patch to change some API to make simpler code correct in the mainline.

That is, the correct way of merging changes from -stable with the latest 
mainline series is always to take the mainline version, even if the 
-stable changes don't conflict at all.

It should actually be ideal to just merge your local changes directly with 
the mainline kernel you want to end up using. But you might want to merge 
first with earlier mainline kernels in order to get fewer or easier 
conflicts per step.

	-Daniel
*This .sig left intentionally blank*
--1547844168-955355923-1238434278=:19665--
