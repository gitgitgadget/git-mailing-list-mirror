From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: Complete http-pull; where should it go?
Date: Sun, 1 May 2005 16:30:01 -0400 (EDT)
Message-ID: <Pine.LNX.4.21.0505011544120.30848-100000@iabervon.org>
References: <Pine.LNX.4.58.0505011237410.2296@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, Petr Baudis <pasky@ucw.cz>
X-From: git-owner@vger.kernel.org Sun May 01 22:24:43 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DSKzU-0007s9-Tf
	for gcvg-git@gmane.org; Sun, 01 May 2005 22:24:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262664AbVEAUa2 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 1 May 2005 16:30:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262665AbVEAUaV
	(ORCPT <rfc822;git-outgoing>); Sun, 1 May 2005 16:30:21 -0400
Received: from iabervon.org ([66.92.72.58]:1540 "EHLO iabervon.org")
	by vger.kernel.org with ESMTP id S262664AbVEAUaI (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 1 May 2005 16:30:08 -0400
Received: from barkalow (helo=localhost)
	by iabervon.org with local-esmtp (Exim 2.12 #2)
	id 1DSL4j-00088z-00; Sun, 1 May 2005 16:30:01 -0400
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0505011237410.2296@ppc970.osdl.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Sun, 1 May 2005, Linus Torvalds wrote:

> For example, if I want to know what objects I have in my object directory 
> that are needed for a release, I want to be able to tell fsck to list the 
> objects that are extraneous for that release _regardless_ of the fact that 
> I may have .git/refs/*/* files that point to other things.
>
> So if fsck-cache automatically looks up references in .git/refs/ like in
> one of your earlier patches, then instead of adding value to the program,
> you actually _remove_ value from it by making it less flexible, and
> enforcing a world-view that is not necessarily the only view.

It's true that you might not want to include all of the refs; but doesn't
it make more sense to support the standard arrangement of refs (i.e.,
they're in .git/refs/kind/name) for the ones you want to include, rather
than having to pull out the hex to pass in yourself?

> This is why I want the true _plumbing_ to not care about these things, and 
> if you include references to trees, you _list_ them explicitly. 

Right; what I want to make programs able to do is take explicit
references, instead of only taking the objects they reference. So you say
heads/master or heads/linus instead of
"198b0fb635ed8a007bac0c16eab112c5e2c7995c".

The part that makes this important is that the user may be trying to look
up a reference on a remote machine using the same connection that the
objects will come over, and this is impractical without having the program
know how to handle reference files.

> And if you want to have a command that takes implied references, then just 
> make a script that does that for you, rather than making the core plumbing 
> understand it.

Agreed; which references to use are up to either the power user or the
script, not the core. I'm just interested in having a core implementation
for using them when specified.

	-Daniel
*This .sig left intentionally blank*

