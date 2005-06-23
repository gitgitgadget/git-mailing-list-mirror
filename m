From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: Patch (apply) vs. Pull
Date: Thu, 23 Jun 2005 15:59:15 -0400 (EDT)
Message-ID: <Pine.LNX.4.21.0506231522080.30848-100000@iabervon.org>
References: <Pine.LNX.4.58.0506231137440.11175@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 23 22:03:08 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DlXuW-0000Gv-Fg
	for gcvg-git@gmane.org; Thu, 23 Jun 2005 22:02:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263069AbVFWUHm (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 23 Jun 2005 16:07:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263066AbVFWUCf
	(ORCPT <rfc822;git-outgoing>); Thu, 23 Jun 2005 16:02:35 -0400
Received: from iabervon.org ([66.92.72.58]:12037 "EHLO iabervon.org")
	by vger.kernel.org with ESMTP id S262920AbVFWUA5 (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 23 Jun 2005 16:00:57 -0400
Received: from barkalow (helo=localhost)
	by iabervon.org with local-esmtp (Exim 2.12 #2)
	id 1DlXr1-00009Q-00; Thu, 23 Jun 2005 15:59:15 -0400
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0506231137440.11175@ppc970.osdl.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Thu, 23 Jun 2005, Linus Torvalds wrote:

> Right, that would mean that we don't control the hash generation at both 
> points, and would make it fundamentally harder. But since the whole point 
> is that we should be able to generate the ID _without_ it actually being 
> stored away anywhere, this hash approach should work fine.

("We" in this case being the developer checking whether the patch went in,
not the maintainer)

We'll need to see if the performance is okay this way, both in terms of
time spent searching for the patch you're checking on and in terms of
recognizing the patch as being the same. No point in designing anything
more complex until we determine if we can't just recognize it already.

> > I think that the whole-chain case is sufficiently common to make special
> > and extra smooth; developers will be making their history forwards every
> > day, and only cherry-picking on occasion.
> 
> I'm not convinced. I think a _lot_ of people would want to do re-ordering 
> of patches, combining them, and cherry-picking them if they just had a 
> good way to do that.

Oh, I think they'd want to do that. I just don't think they'd want to do
it as often as they want to update their tree for changes in mainline,
just because no one developer will do more work than the rest of the
developers combined. And it's worthwhile, because you need to use
diff/patch for the complex cases, and can use diff3 for the simple case,
and you need diff3 if you want the system to treat "everything in patch 5
is already in the new base" as success rather than conflict.

(This is, incidentally, the case that drives me crazy about arch: if I
make a change in one working directory, copy that change into another
working directory, commit it from one of those directories, and update in
the other, I get a reject, and I then have to figure out if the changes 
were actually the same or if one of them has further modifications.)

	-Daniel
*This .sig left intentionally blank*

