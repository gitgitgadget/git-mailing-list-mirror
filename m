From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: unseeking?
Date: Sun, 24 Apr 2005 18:10:42 -0400 (EDT)
Message-ID: <Pine.LNX.4.21.0504241742070.30848-100000@iabervon.org>
References: <20050424213841.GD11094@tumblerings.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Petr Baudis <pasky@ucw.cz>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Apr 25 00:06:01 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DPpEk-0005I4-V2
	for gcvg-git@gmane.org; Mon, 25 Apr 2005 00:05:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262456AbVDXWKt (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 24 Apr 2005 18:10:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262459AbVDXWKt
	(ORCPT <rfc822;git-outgoing>); Sun, 24 Apr 2005 18:10:49 -0400
Received: from iabervon.org ([66.92.72.58]:29446 "EHLO iabervon.org")
	by vger.kernel.org with ESMTP id S262456AbVDXWKl (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 24 Apr 2005 18:10:41 -0400
Received: from barkalow (helo=localhost)
	by iabervon.org with local-esmtp (Exim 2.12 #2)
	id 1DPpJK-0005W9-00; Sun, 24 Apr 2005 18:10:42 -0400
To: Zack Brown <zbrown@tumblerings.org>
In-Reply-To: <20050424213841.GD11094@tumblerings.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Sun, 24 Apr 2005, Zack Brown wrote:

> On Sun, Apr 24, 2005 at 02:47:30PM -0400, Daniel Barkalow wrote:
> 
> So why not just do 'git init URL' to get the upstream sources, make your
> edits, do 'git pull' to track the upstream sources every once in
> awhile, and do 'git diff' when you're ready to send your changes to the
> upstream maintainer.
> 
> I think I've understood your explanation of what's actually happening,
> but I still don't see its significance. What do you get from a fork that
> you don't get from a regular old init and pull?

Primarily, the ability to inspect and build the mainline tree. If you want
to take a look at what's going on in the mainline without getting it again
or messing with your working directory or local commits, you can do that. 

Also, if you're doing two independant sets of edits, you can share the
downloads for updates between them. Say I'm working on an ambitious
project to do block-move cross-file merges in git. I've got a fork that
I'm working on that in. After I've done a bunch of work there, I notice a
bug report about some of my other code in the project. I fork off another
branch from the mainline to fix it in, so that I can ignore the fact that
I'm a dozen commits into this other thing, fix the bug, and ship off the
changes.

With fork, I save having to download the contents of the remote repository
again, because the object storage is shared. Also, I can merge my bug 
fixes into my long-term work without waiting for them to show up in the
mainline (although that makes the later merge potentially trickier) or, in
general, needing to transfer them between repositories.

The other main thing is the way that I actually split up patches. I have a
fork of the mainline. I make a second fork of the mainline. I diff
"second:first" to get the changes I need to split up, apply some of them,
commit, and then repeat. In order to diff "second:first", both have to be
stored in the same repository (because, otherwise, git won't be able to
find one or the other commit to look at). In the first iteration, when
second is mainline, it doesn't matter, but in later iterations I want to
get fewer and fewer changes to include or postpone, which requires using
commits from the splitting process.

	-Daniel
*This .sig left intentionally blank*

