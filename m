From: Jeff King <peff@peff.net>
Subject: Re: [3/4] What's not in 1.5.2 (new topics)
Date: Thu, 17 May 2007 13:35:34 -0400
Message-ID: <20070517173534.GA29607@coredump.intra.peff.net>
References: <11793556363795-git-send-email-junkio@cox.net> <11793556371774-git-send-email-junkio@cox.net> <200705170539.11402.andyparkins@gmail.com> <7v4pmcauu3.fsf@assigned-by-dhcp.cox.net> <20070517110225.GA3334@steel.home> <20070517124622.GP4489@pasky.or.cz> <20070517134649.GA20853@coredump.intra.peff.net> <20070517161002.GR4489@pasky.or.cz> <20070517162542.GA28501@coredump.intra.peff.net> <20070517173005.GS4489@pasky.or.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Alex Riesen <raa.lkml@gmail.com>, Junio C Hamano <junkio@cox.net>,
	Andy Parkins <andyparkins@gmail.com>, git@vger.kernel.org
To: Petr Baudis <pasky@suse.cz>
X-From: git-owner@vger.kernel.org Thu May 17 19:35:47 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HojtA-0006Op-SB
	for gcvg-git@gmane.org; Thu, 17 May 2007 19:35:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755487AbXEQRfh (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 17 May 2007 13:35:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756246AbXEQRfh
	(ORCPT <rfc822;git-outgoing>); Thu, 17 May 2007 13:35:37 -0400
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:4286 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755487AbXEQRfh (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 May 2007 13:35:37 -0400
Received: (qmail 20824 invoked from network); 17 May 2007 17:35:37 -0000
Received: from coredump.intra.peff.net (10.0.0.2)
  by peff.net with (DHE-RSA-AES128-SHA encrypted) SMTP; 17 May 2007 17:35:37 -0000
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Thu, 17 May 2007 13:35:34 -0400
Content-Disposition: inline
In-Reply-To: <20070517173005.GS4489@pasky.or.cz>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/47545>

On Thu, May 17, 2007 at 07:30:05PM +0200, Petr Baudis wrote:

> I think Junio's URL keying works fine. Their change of URL will override
> your change, but that is bad thing only when the old upstream's URL
> changed, but the upstream stays the same. Then either the problem is
> clearly visible or it will result only in somewhat suboptimal behaviour.
> 
> OTOH, if the _upstream_ changed and your override scheme is at work, you
> won't notice at all and simply will continue to use the same old
> upstream.

Right. But I think it makes more sense for the error condition to go the
other way (that is, your override might get stale, but it will always be
an _override_). You'll notice eventually anyway when upstream moves to a
commit sha1 that you don't have in your submodule repo (or if they never
do, that means your override tree actually _is_ valid, and didn't need
to be changed anyway; this would be the case if upstream moved to a
different mirror, but you were already using an alternate source
anyway).

> But again - "kernel/" means nothing, only "kernel/ in tree X". kernel/
> might point to linux-2.4 in older trees, linux-2.6 in newer trees, -mm
> in the experimental branch and freebsd tree in the weirdo branch. Such
> an override is _never_ going to work in the general situation, only when
> "kernel/" always in all commits on all branches points to the same
> single project. (You can work that around by at least making the setting
> branch-specific, but that still doens't take into account the history,
> and then newly created branches won't have the override you want, etc.)

My point is that we _already_ have a mechanism that unambiguously points
to the linked commit, and it's _not_ the URL; it's the commit sha1
embedded in the tree.  Everything else is just a hint about where we
might find that commit.

-Peff
