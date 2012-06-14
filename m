From: Michael Witten <mfwitten@gmail.com>
Subject: Re: Git rebase basics
Date: Thu, 14 Jun 2012 05:00:22 -0000
Message-ID: <af093eb8bd7c4b39a17807c5cb5723e4-mfwitten@gmail.com>
References: <1339621152946-7561468.post@n2.nabble.com>
            <1339642794317-7561489.post@n2.nabble.com>
Cc: git@vger.kernel.org
To: lancelyons <llyons2@cox.net>
X-From: git-owner@vger.kernel.org Thu Jun 14 07:15:18 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Sf2Op-0001aG-IA
	for gcvg-git-2@plane.gmane.org; Thu, 14 Jun 2012 07:15:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751098Ab2FNFPI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 Jun 2012 01:15:08 -0400
Received: from mail-wi0-f172.google.com ([209.85.212.172]:61524 "EHLO
	mail-wi0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750974Ab2FNFPH (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Jun 2012 01:15:07 -0400
Received: by wibhj8 with SMTP id hj8so6060754wib.1
        for <git@vger.kernel.org>; Wed, 13 Jun 2012 22:15:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=subject:date:from:to:cc:message-id:in-reply-to:references;
        bh=uxsbJBjEOQDRI4BhWJZhaIcrlohSrd7B4zshI5Y+1iE=;
        b=b/n+5mDN2XjpzLJcdqoIzylnbhrdoTkubczguLfJ9zInS5d21UdnTTIxNLmrzRbA8N
         o3g50/Q0w7wri+gmMziRwMrZwZ3AwjfSr3jyYkDSkyFyzWfFn8mbuDnMo1zcPGeNHmGs
         8rJ+WovoZlv0BEUAp+w8D1T7tXh+G1s/ICFeVowE4TVP5eXQUhpgB3D5TYcua6VskE40
         GEiq243If3/h2cg5QAN8uh5DGAc15GB0oyOp/GP6EmkgdhB7u4AYhjNfhP4XKiwNcPhO
         U64pxZavf2N7uMietqtP62MVs4elqfTb0hxQ9TuHu3mNDOlnSp+O4ExQWKmV419eSJvB
         17jQ==
Received: by 10.180.78.161 with SMTP id c1mr2602431wix.1.1339650905301;
        Wed, 13 Jun 2012 22:15:05 -0700 (PDT)
Received: from gmail.com (tor13.anonymizer.ccc.de. [62.113.219.6])
        by mx.google.com with ESMTPS id q6sm16816808wiy.0.2012.06.13.22.15.03
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 13 Jun 2012 22:15:04 -0700 (PDT)
In-Reply-To: <1339642794317-7561489.post@n2.nabble.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/199970>

On Wed, 13 Jun 2012 19:59:54 -0700 (PDT), Lance

> Sorry about that.. I thought I was being pretty descriptive but maybe I
> missed something.
>
> After we setup Git (msysgit) and set it up using Apache with active
> directory authentication, I added a repository using git init --bare then I
> copied my files I wanted to add to the repository and did a git add . and
> git commit -a
>
> So that all worked.   We have done several clones using git clone with this
> remote repo.  We have also done  git push and git pull to verify everything
> is working ok.   Everything was working fine.
>
> So back to my original train of though.
>
> I am trying to learn more about rebase so i have cloned the central repo two
> times  (I call the central repo the origin) doing the following (to help you
> understand)
>
> git clone https://servername:port/repopath c:\clonedrepo1
>
> git clone https://servername:port/repopath c:\clonedrepo2
>
> and then made changes to this cloned copy (clonedrepo1) and pushed two
> commits back to origin.
> (git commit -a  two times)
>
> so now I have the following in the remote repo (origin)   
>
> origin -->  C1 --> C2
>
> (Note to help you understand  C1 = commit 1 and c2 = commit 2, etc)
>
> In the other cloned copy (clonedrepo2), which I consider a branch, I have
> made two more commits  C3 and C4
>
> clonedrepo2 --> C3 -->  C4
>
> I am able to easily pull from origin to get my clonedrepo2 to look like 
> clonerepo2 --> C3 --> C4 --> C1 --> C2 using git pull origin  or git pull
> https://servername:port/repopath
>
> however I was wanting to rebase the clonedrepo2 branch so that it shows   
> clonerepo2 -> C1 --> C2 --> C3 --> C4
>
> In other words I am wanting to rebase clonedrepo2 to the master of the
> origin.
>
>
> I thought the command to do this was   git rebase origin master but that
> doesnt work and I get
>
> C:\clonedrepo2>git rebase origin master
> Switched to branch 'master'
> Your branch is ahead of 'origin/master' by 2 commits.
> Current branch master is up to date.
>
> I know my my branch is ahead by c3 and c4 but it does not have C1 and C2
>
> Thoughts.

This is what I SUPPOSE you mean (using a bash prompt):

  $ git init temp; cd temp
  $ echo 0 > a; git add a; git commit -m C0
  $ cd ..; git clone --bare temp origin; rm -rf temp
  $ git clone origin clonedrepo1
  $ git clone origin clonedrepo2
  $ cd clonedrepo1
  $ echo 1 > a; git commit -am C1
  $ echo 2 > a; git commit -am C2
  $ git push
  $ cd ../clonedrepo2
  $ echo 0 > b; git add b; git commit  -m C3
  $ echo 1 > b;            git commit -am C4
  $ # The following line is essentially `git pull',
  $ # but it would appear that `git pull' is currently
  $ # ignorant of merge's `-m' flag for specifying a
  $ # commit message on the command line.
  $ git fetch; git merge -m C5 origin/master # Essentially `git pull'
  $ git log --format=%s --graph
  *   C5
  |\  
  | * C2
  | * C1
  * | C4
  * | C3
  |/  
  * C0

Notice how the history splits at C0, and then merges back together
at C5; it's not actually the case that C1 has been made a child
of C4 (I'm guessing you have used `git log' to see a linearized
output, which does not reflect the topology of the graph).

The simplest solution would have been to tell `git pull' to perform
a rebase rather than a merge:

  git pull --rebase

We can simulate having done so by resetting our work
and pulling again:

  $ git reset --hard :/C4 # Reset back to C4; see `git help rev-parse'
  $ git branch C4 # Save this original C4 for later reference
  $ git log --format=%s --graph
  * C4
  * C3
  * C0
  $ git pull --rebase
  $ git log --format=%s --graph
  * C4
  * C3
  * C2
  * C1
  * C0

The line:

  git pull --rebase

Is essentially just the same as before, except that a rebase
rather than a merge is performed, essentially equivalent to
the following:

  git fetch; git rebase origin/master

which is something you could certainly do by hand to fix
the problem without performing the additional fetch:

  $ git reset --hard C4 # Go back to the original C4 commit
  $ git rebase origin/master

Sincerely,
Michael Witten
