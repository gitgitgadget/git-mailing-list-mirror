From: Stephen Kelly <steveire@gmail.com>
Subject: Re: Creating remote branch called HEAD corrupts remote clones
Date: Wed, 27 Apr 2011 13:29:50 +0200
Message-ID: <BANLkTi=DgXrWZ0ObBYi2mgk-+8w8iXM7VQ@mail.gmail.com>
References: <ih1449$ul6$1@dough.gmane.org>
	<7v62tjs66r.fsf@alter.siamese.dyndns.org>
	<20110120203840.GA11468@sigill.intra.peff.net>
	<7vbp3bqmiy.fsf@alter.siamese.dyndns.org>
	<20110120215456.GB11468@sigill.intra.peff.net>
	<AANLkTikBbSt5_WdbuE8a96w1pWBCYLNjMCUCBThjdLdG@mail.gmail.com>
	<7vk4hyp38i.fsf@alter.siamese.dyndns.org>
	<AANLkTikmbWkpjioARZrmySpLM8t7kqCX0v1+NKibk_ar@mail.gmail.com>
	<AANLkTinRcmevXz3zV0wtxd7+Q3F4zcH2AZOQk1XVxYXa@mail.gmail.com>
	<BANLkTim1gW_L-9DKo9p_VFQFUBUGWAPxoA@mail.gmail.com>
	<BANLkTinKDHM-RU2wqZECFcjQEoRWADnTGQ@mail.gmail.com>
	<BANLkTimFas5YLt37RLuCppkQ4ZGhmj56Cg@mail.gmail.com>
	<BANLkTinkR+jEKkno30fiHBZ-PMVvvv7FxQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	git@vger.kernel.org
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Wed Apr 27 13:30:01 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QF2wR-00022N-8m
	for gcvg-git-2@lo.gmane.org; Wed, 27 Apr 2011 13:29:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758690Ab1D0L3y (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Apr 2011 07:29:54 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:36148 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758613Ab1D0L3x (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Apr 2011 07:29:53 -0400
Received: by bwz15 with SMTP id 15so1288377bwz.19
        for <git@vger.kernel.org>; Wed, 27 Apr 2011 04:29:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=hhBC+muEympnD4f4B8Tz0DqXahII1DbjFpXBFVO0jLA=;
        b=xG+58QMGWWHYPoZUoJgMaRUhD5DED4813UseI04Bx4JCpXK/ju2FMbglvslcZElcvE
         0z4iB/iKySE8r+RTakhd3Kfpj2DgGzXioOjeljsHPjvw7Y1VHE2JMTibzhPN0wSOAgUv
         d3+vlnbEO15AhUSf7R1QiJ/HeMFaS946G0aF4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=H8TG0V7A+lv06egCLiK12HEecTJ25AyLyXD2nqS/Cjf6D/pj4hcsVIgwBGaNKAzKU1
         reWKdHI+ecboC3e5EYO8VnwFOPJ+Q0D4BJkn1KQ0hWYD9jPeGtYoghTCQyC9dfDe+P8T
         gbIgzDY+EcEmXGnkM6pyKCE4ZykfQ61NjS8a0=
Received: by 10.204.84.137 with SMTP id j9mr142392bkl.120.1303903791530; Wed,
 27 Apr 2011 04:29:51 -0700 (PDT)
Received: by 10.204.120.195 with HTTP; Wed, 27 Apr 2011 04:29:50 -0700 (PDT)
In-Reply-To: <BANLkTinkR+jEKkno30fiHBZ-PMVvvv7FxQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/172220>

On Wed, Apr 27, 2011 at 11:48 AM, Felipe Contreras
<felipe.contreras@gmail.com> wrote:
> No problems here:

I had another go.

mkdir remote
cd remote/
git init --bare
cd ../
git clone remote/ alice
cd alice/
echo test >> file
git add file
git commit -am w
git push origin master
echo test >> file
git commit -am w
git branch HEAD
git push origin HEAD
git push
cd ..
git clone remote bob
cd bob/
git branch
git pull --rebase
echo test >> file
git commit -am w
git push
git pull
git pull
git pull
echo test >> file
git commit -am w
git push
cd ../alice
git branch
git status
echo test >> file
git commit -am w
git push
echo test2 >> file
git commit -am w
git push
git pull
echo test3 >> file
git commit -am w
git status
git push
gitk


stephen@bishop:/tmp/git$ mkdir remote

stephen@bishop:/tmp/git$ cd remote/

stephen@bishop:/tmp/git/remote$ git init --bare
Initialized empty Git repository in /tmp/git/remote/

stephen@bishop:/tmp/git/remote$ cd ../

stephen@bishop:/tmp/git$ git clone remote/ alice
Cloning into alice...
done.
warning: You appear to have cloned an empty repository.

stephen@bishop:/tmp/git$ cd alice/

stephen@bishop:/tmp/git/alice$ echo test >> file

stephen@bishop:/tmp/git/alice$ git add file

stephen@bishop:/tmp/git/alice$ git commit -am w
[master (root-commit) 072df32] w
 1 files changed, 1 insertions(+), 0 deletions(-)
 create mode 100644 file

stephen@bishop:/tmp/git/alice{master}$ git push origin master
Counting objects: 3, done.
Writing objects: 100% (3/3), 210 bytes, done.
Total 3 (delta 0), reused 0 (delta 0)
Unpacking objects: 100% (3/3), done.
To /tmp/git/remote/
 * [new branch]      master -> master

stephen@bishop:/tmp/git/alice{master}$ echo test >> file

stephen@bishop:/tmp/git/alice{master}$ git commit -am w
[master b39d099] w
 1 files changed, 1 insertions(+), 0 deletions(-)

stephen@bishop:/tmp/git/alice{master}$ git branch HEAD

stephen@bishop:/tmp/git/alice{master}$ git push origin HEAD
Counting objects: 5, done.
Writing objects: 100% (3/3), 242 bytes, done.
Total 3 (delta 0), reused 0 (delta 0)
Unpacking objects: 100% (3/3), done.
To /tmp/git/remote/
 * [new branch]      HEAD -> HEAD

stephen@bishop:/tmp/git/alice{master}$ git push
Everything up-to-date

stephen@bishop:/tmp/git/alice{master}$ cd ..

stephen@bishop:/tmp/git$ git clone remote bob
Cloning into bob...
done.

stephen@bishop:/tmp/git$ cd bob/

stephen@bishop:/tmp/git/bob{master}$ git pull --rebase
From /tmp/git/remote
   072df32..b39d099  HEAD       -> origin/HEAD
Current branch master is up to date.

stephen@bishop:/tmp/git/bob{master}$ echo test >> file

stephen@bishop:/tmp/git/bob{master}$ git commit -am w
[master b39d099] w
 1 files changed, 1 insertions(+), 0 deletions(-)

stephen@bishop:/tmp/git/bob{master}$ git push
Total 0 (delta 0), reused 0 (delta 0)
To /tmp/git/remote
   072df32..b39d099  HEAD -> master

stephen@bishop:/tmp/git/bob{master}$ git pull
Current branch master is up to date.

stephen@bishop:/tmp/git/bob{master}$ git pull
Current branch master is up to date.

stephen@bishop:/tmp/git/bob{master}$ git pull
Current branch master is up to date.

stephen@bishop:/tmp/git/bob{master}$ echo test >> file

stephen@bishop:/tmp/git/bob{master}$ git commit -am w
[master 47699a9] w
 1 files changed, 1 insertions(+), 0 deletions(-)

stephen@bishop:/tmp/git/bob{master}$ git push
Counting objects: 5, done.
Writing objects: 100% (3/3), 240 bytes, done.
Total 3 (delta 0), reused 0 (delta 0)
Unpacking objects: 100% (3/3), done.
To /tmp/git/remote
   b39d099..47699a9  HEAD -> master

stephen@bishop:/tmp/git/bob{master}$ cd ../alice

stephen@bishop:/tmp/git/alice{master}$ git branch
  HEAD
* master

stephen@bishop:/tmp/git/alice{master}$ git status
warning: refname 'HEAD' is ambiguous.
warning: refname 'HEAD' is ambiguous.
# On branch master
# Your branch is ahead of 'origin/master' by 1 commit.
#
nothing to commit (working directory clean)

stephen@bishop:/tmp/git/alice{master}$ echo test >> file

stephen@bishop:/tmp/git/alice{master}$ git commit -am w
warning: refname 'HEAD' is ambiguous.
warning: refname 'HEAD' is ambiguous.
warning: refname 'HEAD' is ambiguous.
[master 7e83bed] w
 1 files changed, 1 insertions(+), 0 deletions(-)

stephen@bishop:/tmp/git/alice{master}$ git push
Everything up-to-date

stephen@bishop:/tmp/git/alice{master}$ echo test2 >> file

stephen@bishop:/tmp/git/alice{master}$ git commit -am w
warning: refname 'HEAD' is ambiguous.
warning: refname 'HEAD' is ambiguous.
warning: refname 'HEAD' is ambiguous.
[master b4f5b5b] w
 1 files changed, 1 insertions(+), 0 deletions(-)

stephen@bishop:/tmp/git/alice{master}$ git push
Everything up-to-date

stephen@bishop:/tmp/git/alice{master}$ git pull
warning: refname 'HEAD' is ambiguous.
warning: refname 'HEAD' is ambiguous.
warning: refname 'HEAD' is ambiguous.
warning: refname 'HEAD' is ambiguous.
remote: Counting objects: 5, done.
remote: Total 3 (delta 0), reused 0 (delta 0)
Unpacking objects: 100% (3/3), done.
From /tmp/git/remote
   072df32..47699a9  master     -> origin/master
warning: refname 'HEAD' is ambiguous.
warning: refname 'HEAD' is ambiguous.
warning: refname 'HEAD' is ambiguous.
First, rewinding head to replay your work on top of it...
warning: refname 'HEAD' is ambiguous.
warning: refname 'HEAD' is ambiguous.
Applying: w
warning: refname 'HEAD' is ambiguous.
warning: refname 'HEAD' is ambiguous.

stephen@bishop:/tmp/git/alice{master}$ echo test3 >> file

stephen@bishop:/tmp/git/alice{master}$ git commit -am w
warning: refname 'HEAD' is ambiguous.
warning: refname 'HEAD' is ambiguous.
warning: refname 'HEAD' is ambiguous.
[master cc2088e] w
 1 files changed, 1 insertions(+), 0 deletions(-)

stephen@bishop:/tmp/git/alice{master}$ git status
warning: refname 'HEAD' is ambiguous.
warning: refname 'HEAD' is ambiguous.
# On branch master
# Your branch is ahead of 'origin/master' by 2 commits.
#
nothing to commit (working directory clean)

stephen@bishop:/tmp/git/alice{master}$ git push
Everything up-to-date

stephen@bishop:/tmp/git/alice{master}$

stephen@bishop:/tmp/git/alice{master}$ git --version
git version 1.7.4.1
