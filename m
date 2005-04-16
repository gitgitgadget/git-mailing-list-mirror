From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: Re: Re: write-tree is pasky-0.4
Date: Fri, 15 Apr 2005 22:49:46 -0400 (EDT)
Message-ID: <Pine.LNX.4.21.0504152221070.30848-100000@iabervon.org>
References: <Pine.LNX.4.58.0504151913180.7211@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Petr Baudis <pasky@ucw.cz>, Junio C Hamano <junkio@cox.net>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Apr 16 04:46:22 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DMdJy-0005ql-Uq
	for gcvg-git@gmane.org; Sat, 16 Apr 2005 04:46:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262583AbVDPCtp (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 15 Apr 2005 22:49:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262585AbVDPCtp
	(ORCPT <rfc822;git-outgoing>); Fri, 15 Apr 2005 22:49:45 -0400
Received: from iabervon.org ([66.92.72.58]:64004 "EHLO iabervon.org")
	by vger.kernel.org with ESMTP id S262583AbVDPCtn (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 15 Apr 2005 22:49:43 -0400
Received: from barkalow (helo=localhost)
	by iabervon.org with local-esmtp (Exim 2.12 #2)
	id 1DMdNS-00046Y-00; Fri, 15 Apr 2005 22:49:46 -0400
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0504151913180.7211@ppc970.osdl.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Fri, 15 Apr 2005, Linus Torvalds wrote:

> On Fri, 15 Apr 2005, Daniel Barkalow wrote:
> > 
> > Is there some reason you don't commit before merging? All of the current
> > merge theory seems to want to merge two commits, using the information git
> > keeps about them.
> 
> Note that the 3-way merge would _only_ merge the committed state. The 
> thing is, 99% of all merges end up touching files that I never touch 
> myself (ie other architectures), so me being able to merge them even when 
> _I_ am in the middle of something is a good thing.
> 
> So even when I have dirty state, the "merge" would only merge the clean
> state. And then before the merge information is put back into my working
> directory, I'd do a "check-files" on the result, making sure that nothing
> that got changed by the merge isn't up-to-date.

So you want to merge someone else's tree into your committed state, and
then merge the result with your working directory to get the working
directory you continue with, provided that the second merge is trivial?

> > How much do you care about the situation where there is no best common
> > ancestor
> 
> I care. Even if the best common parent is 3 months ago, I care. I'd much 
> rather get a big explicit conflict than a "clean merge" that ends up being 
> debatable because people played games with per-file merging or something 
> questionable like that.

Are you thinking that the best common ancestor is the one that ties up
absolutely all of the chains of commits, or the closest one that the sides
have in common? I have the feeling that the former isn't going to be
useful, because there will be lines you're considering merging which go
back to ancient kernels, where they keep merging in your changes, but
they still have a lineage back to 2.6.0 or something.

For the latter, there are sometimes multiple ancestors which fit this
criterion, and different ones of them are most helpful for different
portions of the merge. I think this primarily happens when a branch you
want to merge has accepted multiple patches that you've also
accepted (and the history identifies this fact); this may or may not be a
situation you want to allow on a regular basis.

	-Daniel
*This .sig left intentionally blank*

