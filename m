From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: [1/5] Parsing code in revision.h
Date: Sun, 17 Apr 2005 16:22:59 -0400 (EDT)
Message-ID: <Pine.LNX.4.21.0504171608070.30848-100000@iabervon.org>
References: <Pine.LNX.4.58.0504171254500.7211@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Petr Baudis <pasky@ucw.cz>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Apr 17 22:24:01 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DNGJ7-00089D-2g
	for gcvg-git@gmane.org; Sun, 17 Apr 2005 22:23:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261530AbVDQU0r (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 17 Apr 2005 16:26:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261527AbVDQUYw
	(ORCPT <rfc822;git-outgoing>); Sun, 17 Apr 2005 16:24:52 -0400
Received: from iabervon.org ([66.92.72.58]:9991 "EHLO iabervon.org")
	by vger.kernel.org with ESMTP id S261526AbVDQUWs (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 17 Apr 2005 16:22:48 -0400
Received: from barkalow (helo=localhost)
	by iabervon.org with local-esmtp (Exim 2.12 #2)
	id 1DNGIF-0008RM-00; Sun, 17 Apr 2005 16:22:59 -0400
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0504171254500.7211@ppc970.osdl.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Sun, 17 Apr 2005, Linus Torvalds wrote:

> On Sun, 17 Apr 2005, Linus Torvalds wrote:
> > 
> > Yes. I'm not opposed to yours, I was just opposed to some of the things 
> > around it you did, so I wrote mine as a kind of place-holder. I'll happily 
> > take patches to turn it from a rally simple and stupid one into a more 
> > polished version.
> 
> Btw, before I forget - I did have another reason. I actually think that
> the date is potentially a lot more important than "how many parents deep".
> 
> In particular, it's entirely possible that the top of my head might be a
> veru recent merge that merges with a small fix relative to a very old
> parent (making that old parent be just two hops away from the head), while
> the thing I want to merge might also have that old parent (for similar
> reasons) as a relatively "close" parent from a pure link-counting
> standpoint.
> 
> The reason I bring this up is that quite often people end up basing their
> work on a specific release version, so a merge (especially in specialized
> areas) may thus bring such an old parent pretty close to the head, and it
> can actually be quite possible (indeed probable) that such a parent ends
> up being a common parent.
> 
> However, it can easily be a very _bad_ parent.
> 
> In ascii barfic:
> 
> 	        ----------------------- patch ---------
> 	       /                                        \
> 	      /                                          \
> 	- old release -- ... lots of development .. -----HEAD
> 	     \  \                 /
> 	      \  \               /
> 	       \  --------------/------patch-- MERGE-HEAD      
> 	        \              /              /
> 		  .. lots of development ..  /

(I added a merge line so there's another commit to discuss in the picture)

> it looks like "old release" is pretty close to both HEAD and MERGE-HEAD, 
> right?
> 
> But that's just an artifact of the fact that they both had a trivial merge
> against some older code, and if the two "lots of development" things have
> ever done an earlier merge, there's quite possibly a _much_ better common
> parent there somewhere.
> 
> I dunno.

I think you're going to want multiple common ancestors being used in the
merge when this thing starts to happen; otherwise, you're going to have to
fix up conflicts for "patch" for all the trees you pull. (Also, you're
only going to see a parent for patch (that is, the old revision as an
ancestor of the application of patch) if the trees are merging it in via
git, in which case you'll also see a commit for patch, which will have a
recent date. So you'd see "just yesterday, we both merged a tiny 
change; so that tree, which is very much like an ancient one, is more
recent that last weeks major merge".

I dunno either, but I hope we'll have 2+n-way-merge before there's a lot
of complex history to deal with.

	-Daniel
*This .sig left intentionally blank*

