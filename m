From: Petr Baudis <pasky@suse.cz>
Subject: Re: [3/4] What's not in 1.5.2 (new topics)
Date: Thu, 17 May 2007 19:30:05 +0200
Message-ID: <20070517173005.GS4489@pasky.or.cz>
References: <11793556363795-git-send-email-junkio@cox.net> <11793556371774-git-send-email-junkio@cox.net> <200705170539.11402.andyparkins@gmail.com> <7v4pmcauu3.fsf@assigned-by-dhcp.cox.net> <20070517110225.GA3334@steel.home> <20070517124622.GP4489@pasky.or.cz> <20070517134649.GA20853@coredump.intra.peff.net> <20070517161002.GR4489@pasky.or.cz> <20070517162542.GA28501@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Alex Riesen <raa.lkml@gmail.com>, Junio C Hamano <junkio@cox.net>,
	Andy Parkins <andyparkins@gmail.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu May 17 19:30:24 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hojo0-00053S-1o
	for gcvg-git@gmane.org; Thu, 17 May 2007 19:30:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755850AbXEQRaJ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 17 May 2007 13:30:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756247AbXEQRaI
	(ORCPT <rfc822;git-outgoing>); Thu, 17 May 2007 13:30:08 -0400
Received: from w241.dkm.cz ([62.24.88.241]:34608 "EHLO machine.or.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755850AbXEQRaH (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 May 2007 13:30:07 -0400
Received: (qmail 3707 invoked by uid 2001); 17 May 2007 19:30:05 +0200
Content-Disposition: inline
In-Reply-To: <20070517162542.GA28501@coredump.intra.peff.net>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/47544>

On Thu, May 17, 2007 at 06:25:42PM CEST, Jeff King wrote:
> However, I think we _must_ have an override mechanism, since I don't
> necessarily use the same URLs that you do. I propose that such overrides
> should go into the local repo config. The only difference between what I
> have proposed and what Junio mentioned is that I would base the config
> override key on the directory name, not the URL. This means that if
> upstream changes their pointer to the URL, yours will change with it
> _unless you have an override_. With Junio's, their change of URL will
> override your change (since the key will no longer match your config).
> 
> How do you propose to handle overrides?

I think Junio's URL keying works fine. Their change of URL will override
your change, but that is bad thing only when the old upstream's URL
changed, but the upstream stays the same. Then either the problem is
clearly visible or it will result only in somewhat suboptimal behaviour.

OTOH, if the _upstream_ changed and your override scheme is at work, you
won't notice at all and simply will continue to use the same old
upstream.

> > "kernel/" has _no_ meaning. Only a (treeid,"kernel/") pair has meaning,
> > nothing less - a particular tree contains a submodule in given subtree.
> > Different trees can have different submodules in different subtrees.
> 
> Right. In my proposal (unlike Alex's), it _is_ tied to the tree, since
> that tree has a particular .gitmodules. But I also think you should be
> able to override the submodule URL for kernel/ _for all time_ if you
> want.

But again - "kernel/" means nothing, only "kernel/ in tree X". kernel/
might point to linux-2.4 in older trees, linux-2.6 in newer trees, -mm
in the experimental branch and freebsd tree in the weirdo branch. Such
an override is _never_ going to work in the general situation, only when
"kernel/" always in all commits on all branches points to the same
single project. (You can work that around by at least making the setting
branch-specific, but that still doens't take into account the history,
and then newly created branches won't have the override you want, etc.)

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
Ever try. Ever fail. No matter. // Try again. Fail again. Fail better.
		-- Samuel Beckett
