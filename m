From: Petr Baudis <pasky@ucw.cz>
Subject: Re: Re: Re: Add "clone" support to lntree
Date: Sat, 16 Apr 2005 13:39:56 +0200
Message-ID: <20050416113955.GB14326@pasky.ji.cz>
References: <Pine.LNX.4.21.0504152142360.30848-100000@iabervon.org> <20050416024755.GX7417@pasky.ji.cz> <20050416025844.GY7417@pasky.ji.cz> <Pine.LNX.4.58.0504152014330.7211@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Daniel Barkalow <barkalow@iabervon.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Apr 16 13:36:54 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DMlbD-0005hl-GW
	for gcvg-git@gmane.org; Sat, 16 Apr 2005 13:36:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262650AbVDPLkF (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 16 Apr 2005 07:40:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262651AbVDPLkE
	(ORCPT <rfc822;git-outgoing>); Sat, 16 Apr 2005 07:40:04 -0400
Received: from w241.dkm.cz ([62.24.88.241]:236 "HELO machine.sinus.cz")
	by vger.kernel.org with SMTP id S262650AbVDPLj6 (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 16 Apr 2005 07:39:58 -0400
Received: (qmail 17842 invoked by uid 2001); 16 Apr 2005 11:39:56 -0000
To: Linus Torvalds <torvalds@osdl.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0504152014330.7211@ppc970.osdl.org>
User-Agent: Mutt/1.4i
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Dear diary, on Sat, Apr 16, 2005 at 05:16:12AM CEST, I got a letter
where Linus Torvalds <torvalds@osdl.org> told me that...
> On Sat, 16 Apr 2005, Petr Baudis wrote:
> > 
> > I'm wondering, whether each tree should be fixed to a certain branch.
> 
> I'm wondering why you talk about "branches" at all.
> 
> No such thing should exist. There are no branches. There are just 
> repositories. You can track somebody elses repository, but you should 
> track it by location, not by any "branch name".
> 
> And you track it by just merging it.
> 
> Yeah, we don't have really usable merges yet, but..

First, this "level" of branches concerns multiple working directories
tied to a single repository. It seems like a sensible thing to do; and
you agreed with it too (IIRC). And when you do that, git-pasky just
saves some work for you. For git-pasky, branch is really just a symbolic
name for a commit ID, which gets updated every time you commit in some
repository. Nothing more.

So the whole point of this is to have a symbolic name for some other
working directory. When you want to merge, you don't need to go over to
the other directory, do commit-id, cut'n'paste, and feed that to git
merge. You just do

		git merge myotherbranch


Now, about remote repositories. When you pull a remote repository, that
does not mean it has to be immediately merged somewhere. It is very
useful to have another branch you do *not* want to merge, but you want
to do diffs to it, or even check it out / export it later to some
separate directory. Again, the "branch" is just a symbolic name for the
head commit ID of what you pulled, and the pointer gets updated every
time you pull again - that's the whole point of it.

The last concept are "tracking" working directories. If you pull the
tracked branch to this directory, it also automerges it. This is useful
when you have a single canonical branch for this directory, which it
should always mirror. That would be the case e.g. for the gazillions of
Linux users who would like to just have the latest bleeding kernel of
your, and they expect to use git just like a "different CVS". Basically,
they will just do

		git pull

instead of

		cvs update

:-).

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
C++: an octopus made by nailing extra legs onto a dog. -- Steve Taylor
