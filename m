From: Zack Brown <zbrown@tumblerings.org>
Subject: Re: unseeking?
Date: Mon, 25 Apr 2005 09:18:54 -0700
Message-ID: <20050425161854.GE11094@tumblerings.org>
References: <20050424213841.GD11094@tumblerings.org> <Pine.LNX.4.21.0504241742070.30848-100000@iabervon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Petr Baudis <pasky@ucw.cz>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Apr 25 18:22:06 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DQ6KB-0006OH-OJ
	for gcvg-git@gmane.org; Mon, 25 Apr 2005 18:20:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262652AbVDYQWx (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 25 Apr 2005 12:22:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262628AbVDYQVj
	(ORCPT <rfc822;git-outgoing>); Mon, 25 Apr 2005 12:21:39 -0400
Received: from dsl092-000-086.sfo1.dsl.speakeasy.net ([66.92.0.86]:55260 "EHLO
	tumblerings.org") by vger.kernel.org with ESMTP id S262660AbVDYQUd
	(ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Apr 2005 12:20:33 -0400
Received: from zbrown by tumblerings.org with local (Exim 4.50)
	id 1DQ6IQ-0008LV-R6; Mon, 25 Apr 2005 09:18:54 -0700
To: Daniel Barkalow <barkalow@iabervon.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.21.0504241742070.30848-100000@iabervon.org>
User-Agent: Mutt/1.5.6+20040907i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Hi,

Thanks for all the help!

On Sun, Apr 24, 2005 at 06:10:42PM -0400, Daniel Barkalow wrote:
> > but I still don't see its significance. What do you get from a fork that
> > you don't get from a regular old init and pull?
> 
> Primarily, the ability to inspect and build the mainline tree. If you want
> to take a look at what's going on in the mainline without getting it again
> or messing with your working directory or local commits, you can do that. 

OK, I think I understand this so far. So, suppose I want to contribute to
cogito. I would first do a git init on Pasky's cogito tree, to get it on my home
system. This would be my home base, and whenever I wanted to do some work on the
current state of his tree, I would fork off another branch.

So, I want to do this. From inside cogito's root directory, I give the command

git fork mycogito ../mycogito

and ../mycogito is created. In this new directory, the .git directory
contains only symlinks to ../cogito/HEAD, ../cogito/heads, ../cogito/objects,
../cogito/remotes, and ../cogito/tags, and an index file.

Question: when I make changes to mycogito and commit them, is only the index
file in .git/ altered, or are my changes reflected in the cogito/ directory as
well? If I do another fork of cogito, will I see mycogito's changes in the new
fork?

So moving on, I now have this mycogito tree. But I don't do any edits yet. I
just poke around for awhile, reading files. Finally I realize that there have
probably been updates to the upstream sources, and I want to pull those in
before I start my work. So, as I would do in the cogito directory, I give the
command

git pull pasky; git pull linus

this works fine. There are no new updates to be had, and git tells me my tree is
uptodate.

so now I start work. I run aspell on the README file, and it catches some
typos.  I fix them and save the file but don't yet commit it. Now mycogito
has some changes that I would ultimately like to push up to Pasky.

Now I'm unclear what comes next. Do I just do a 'git diff' from the mycogito
directory and post the results to the git list?

Suppose I want to keep working, changing more stuff in mycogito, but I also want
to make sure that mycogito tracks the upstream sources.

Would I just do

git pull pasky; git pull linus

and give that command whenever I wanted to grab the latest changes? What would
happen if there were upstream conflicts with my work on mycogito?

Or do I have that wrong. Instead of a pull, would I now only do

git merge pasky; git merge linus

and give that command to bring the upstream changes into mycogito?

Basically, once I'm editing files in mycogito, what commands to I give to bring
mycogito uptodate WRT the upstream sources? When I'm finally ready, and all my
changes have been committed into mycogito, what command do I give to produce a
patch to send to the git list?

Be well,
Zack

> 
> Also, if you're doing two independant sets of edits, you can share the
> downloads for updates between them. Say I'm working on an ambitious
> project to do block-move cross-file merges in git. I've got a fork that
> I'm working on that in. After I've done a bunch of work there, I notice a
> bug report about some of my other code in the project. I fork off another
> branch from the mainline to fix it in, so that I can ignore the fact that
> I'm a dozen commits into this other thing, fix the bug, and ship off the
> changes.
> 
> With fork, I save having to download the contents of the remote repository
> again, because the object storage is shared. Also, I can merge my bug 
> fixes into my long-term work without waiting for them to show up in the
> mainline (although that makes the later merge potentially trickier) or, in
> general, needing to transfer them between repositories.
> 
> The other main thing is the way that I actually split up patches. I have a
> fork of the mainline. I make a second fork of the mainline. I diff
> "second:first" to get the changes I need to split up, apply some of them,
> commit, and then repeat. In order to diff "second:first", both have to be
> stored in the same repository (because, otherwise, git won't be able to
> find one or the other commit to look at). In the first iteration, when
> second is mainline, it doesn't matter, but in later iterations I want to
> get fewer and fewer changes to include or postpone, which requires using
> commits from the splitting process.
> 
> 	-Daniel
> *This .sig left intentionally blank*
> 
> -
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

-- 
Zack Brown
