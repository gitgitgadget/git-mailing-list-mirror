From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: [PATCH 0/4] Writing refs in git-ssh-push
Date: Tue, 7 Jun 2005 01:22:37 -0400 (EDT)
Message-ID: <Pine.LNX.4.21.0506070032410.30848-100000@iabervon.org>
References: <Pine.LNX.4.58.0506062008560.2286@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <junkio@cox.net>,
	Git Mailing List <git@vger.kernel.org>,
	Radoslaw Szkodzinski <astralstorm@gorzow.mm.pl>
X-From: git-owner@vger.kernel.org Tue Jun 07 07:22:48 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DfWXf-0003ly-D7
	for gcvg-git@gmane.org; Tue, 07 Jun 2005 07:22:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261727AbVFGFYj (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 7 Jun 2005 01:24:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261745AbVFGFYg
	(ORCPT <rfc822;git-outgoing>); Tue, 7 Jun 2005 01:24:36 -0400
Received: from iabervon.org ([66.92.72.58]:59654 "EHLO iabervon.org")
	by vger.kernel.org with ESMTP id S261740AbVFGFXr (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 7 Jun 2005 01:23:47 -0400
Received: from barkalow (helo=localhost)
	by iabervon.org with local-esmtp (Exim 2.12 #2)
	id 1DfWXt-0002wI-00; Tue, 7 Jun 2005 01:22:37 -0400
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0506062008560.2286@ppc970.osdl.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Mon, 6 Jun 2005, Linus Torvalds wrote:

> Two comments on git-ssh-push from a quick try-to-use-it-but-fail..
> 
>  - hardcoding the name of the command on the other side kind of sucks. 
>    Especially when the user may end up having to install his own version
>    under his own subdirectory. You really want to have some way of saying 
>    "execute /home/user/bin/git-ssh-pull", and since it will depend on the 
>    site you're pushing to, it should probably be available as a cmd line 
>    option.
> 
>    I have a
> 
> 	PATH=$PATH:~/bin
> 
>    in my .bashrc, but sshd at the other end doesn't end up caring..

sshd is pretty odd that way; I think ~/.ssh/environment might get you your
local path. I thought it was just my sshd that was strange like that, but
it's probably common if yours does it too. I'm not sure if there's a
standard way to pick up a per-user version of the remote program. It seems
like cvs doesn't do anything clever, and sftp makes it a compile-time
option.

I think an environment variable for the directory to find
git-ssh-(other) in would be easiest to script when needed and would also
reduce the chances of specifying the wrong program on the remote side
(which would generate really confusing errors).

>  - the host/path parsing is pretty simplistic and just silly. Nobody I 
>    know uses that ssh://host/path format, people use the shorter host:path 
>    format.

I was going for uniformity between git-http-pull and git-ssh-pull, and
between git-ssh-pull and git-ssh-push. But user@host:path is probably the
right thing, although Radoslaw (cc:ed) will want to propose something for
SSH on a non-standard port.

> Both look pretty simple to fix, but now I'm going to put the kids to bed.

Yeah, they're usability issues, and I'm too willing to put up with my own
programs being awkward.

	-Daniel
*This .sig left intentionally blank*

