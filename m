From: Sean <seanlkml@sympatico.ca>
Subject: Re: VCS comparison table
Date: Tue, 17 Oct 2006 08:57:23 -0400
Message-ID: <BAYC1-PASMTP10E107E5EB0F7E69167F41AE0E0@CEZ.ICE>
References: <9e4733910610140807p633f5660q49dd2d2111c9f5fe@mail.gmail.com>
	<Pine.LNX.4.64.0610161625370.3962@g5.osdl.org>
	<45345AEF.6070107@utoronto.ca>
	<200610171030.35854.jnareb@gmail.com>
	<vpqejt76vgz.fsf@ecrins.imag.fr>
	<BAYC1-PASMTP02ADC5BEF688E61583283CAE0E0@CEZ.ICE>
	<vpqbqob5euu.fsf@ecrins.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: Jakub Narebski <jnareb@gmail.com>,
	Aaron Bentley <aaron.bentley@utoronto.ca>,
	Linus Torvalds <torvalds@osdl.org>,
	bazaar-ng@lists.canonical.com, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Oct 17 14:57:37 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GZoVd-00082O-J5
	for gcvg-git@gmane.org; Tue, 17 Oct 2006 14:57:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750855AbWJQM51 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 17 Oct 2006 08:57:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750856AbWJQM51
	(ORCPT <rfc822;git-outgoing>); Tue, 17 Oct 2006 08:57:27 -0400
Received: from bayc1-pasmtp10.bayc1.hotmail.com ([65.54.191.170]:19197 "EHLO
	BAYC1-PASMTP10.bayc1.hotmail.com") by vger.kernel.org with ESMTP
	id S1750851AbWJQM50 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Oct 2006 08:57:26 -0400
X-Originating-IP: [65.93.43.81]
X-Originating-Email: [seanlkml@sympatico.ca]
Received: from linux1.attic.local ([65.93.43.81]) by BAYC1-PASMTP10.bayc1.hotmail.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.1830);
	 Tue, 17 Oct 2006 06:01:04 -0700
Received: from guru.attic.local ([10.10.10.28])
	by linux1.attic.local with esmtp (Exim 4.43)
	id 1GZnZU-0005fs-2h; Tue, 17 Oct 2006 07:57:24 -0400
To: Matthieu Moy <Matthieu.Moy@imag.fr>
Message-Id: <20061017085723.7542ee6c.seanlkml@sympatico.ca>
In-Reply-To: <vpqbqob5euu.fsf@ecrins.imag.fr>
X-Mailer: Sylpheed version 2.2.9 (GTK+ 2.10.4; i386-redhat-linux-gnu)
X-OriginalArrivalTime: 17 Oct 2006 13:01:04.0656 (UTC) FILETIME=[4DCE0100:01C6F1EC]
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Tue, 17 Oct 2006 14:03:21 +0200
Matthieu Moy <Matthieu.Moy@imag.fr> wrote:

> Anyway, given the price of disk space today, this only makes sense if
> you have a fast access to the repository (otherwise, you consider your
> local repository as a cache, and you're ready to pay the disk space
> price to save your bandwidth). In this case, it's often in your
> filesystem (local or NFS).

This is most likely the reason that people using Git don't clammor
more for the ability to work without a local repository.  Disk is cheap
and it just makes sense the vast majority of the time to have a complete
copy of the repository yourself.  There are a lot of powerful things
you can do once you have all that information in your repo.  Not the least
of which is performing any and all operations while flying on a plane
or sitting on a park bench.

> I should have said "by default" ... but you have "commit --local" if
> you want to have a local commit on a bound branch (at this point, I
> should remind that not all branches are "bound branches". "bzr branch"
> creates branches similar to git ones).

Well, with Git the default is to only commit locally.  Of course, you
could set your post commit hook to always push it to a remote if
you wanted to.

> Will, take the example of my bzr setup.
> 
> I have one repository, say, $repo.
> 
> In it, I have one branch "$repo/bzr.dev" which is an exact mirror of
> http://bazaar-vcs.org's branch.
> 
> I also have branches for patches (occasional in my case) that I'll
> send to upstream. Say $repo/feature1, $repo/feature2, ...
> 
> If, by mistake, I start hacking on bzr.dev itself, I'll be warned at
> commit time, create a branch, and commit in this new branch. I believe
> git manages this in a different way, allowing you to commit in this
> branch, and creating the branch next time you pull. But you know this
> better than I ;-), I never got time to give a real try to git.

Well, it's just a slight difference in perspective rather than any
big issue here.  Git treats all repositories as peers, so it would never
assume that just because one other particular repo has a branch marked
as read only that it should be marked read only locally.  It lets you
commit to it, and then push to say a third and fourth repo that are
writable as well.  In practice this doesn't really cause any
insurmountable problems.

> Yes, but you will have to do a merge at some point, right ? While I'm
> keeping a purely linear history (not that it is good in the general
> case, but for "projects" on which I'm the only developper, I find it
> good. For example, my ${HOME}/etc/).

Well if you're committing changes from multiple different machines,
how is that different from having say 3 different developers committing
changes to the central repo?  How does bzr avoid a merge when you're
pushing changes from 3 separate machines? 

You mentioned that if you try to push and you're not up to date you'll
be prompted to update (ie. pull from the upstream repo).  When you do such
a pull do your local changes get rebased on top or is there a merge?   By
your comments I guess you're saying they're rebased rather than merged, and
this is how you keep a linear history.  Git can do this easily, but it's
not done by default.

Sean
