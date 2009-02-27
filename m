From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
	<u.kleine-koenig@pengutronix.de>
Subject: Re: [TopGit] aborting tg create leafs deleted .top* files in index
Date: Fri, 27 Feb 2009 09:32:11 +0100
Message-ID: <20090227083211.GA10326@pengutronix.de>
References: <36ca99e90902061103u24d4f38eua52d9259cb8d34d1@mail.gmail.com> <36ca99e90902262247q783f8ce1j20bdc971cfc22948@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Petr Baudis <pasky@suse.cz>,
	Git Mailing List <git@vger.kernel.org>,
	martin f krafft <madduck@debian.org>
To: Bert Wesarg <bert.wesarg@googlemail.com>
X-From: git-owner@vger.kernel.org Fri Feb 27 09:33:45 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LcyAC-0001N3-8o
	for gcvg-git-2@gmane.org; Fri, 27 Feb 2009 09:33:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754444AbZB0IcQ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 27 Feb 2009 03:32:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754316AbZB0IcQ
	(ORCPT <rfc822;git-outgoing>); Fri, 27 Feb 2009 03:32:16 -0500
Received: from metis.ext.pengutronix.de ([92.198.50.35]:53378 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752457AbZB0IcP (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 Feb 2009 03:32:15 -0500
Received: from octopus.hi.pengutronix.de ([2001:6f8:1178:2:215:17ff:fe12:23b0])
	by metis.ext.pengutronix.de with esmtp (Exim 4.63)
	(envelope-from <ukl@pengutronix.de>)
	id 1Lcy8i-0004oI-P4; Fri, 27 Feb 2009 09:32:12 +0100
Received: from ukl by octopus.hi.pengutronix.de with local (Exim 4.69)
	(envelope-from <ukl@pengutronix.de>)
	id 1Lcy8h-00080K-I5; Fri, 27 Feb 2009 09:32:11 +0100
Content-Disposition: inline
In-Reply-To: <36ca99e90902262247q783f8ce1j20bdc971cfc22948@mail.gmail.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
X-SA-Exim-Connect-IP: 2001:6f8:1178:2:215:17ff:fe12:23b0
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/111645>

Hi Bert,

On Fri, Feb 27, 2009 at 07:47:15AM +0100, Bert Wesarg wrote:
> On Fri, Feb 6, 2009 at 20:03, Bert Wesarg <bert.wesarg@googlemail.com=
> wrote:
> > Hi,
> >
> > after executing the abort commands to remove a just created new top=
ic
> > branch, the .top* files from the previous branch are markes as
> > deleted.
> >
> > To reproduce:
> >
> > $ md g
> > $ cd g
> > $ git --version
> > git version 1.6.1.rc4
> > $ git init
> > Initialized empty Git repository in /home/bertw/tmp/g/.git/
> > $ touch file
> > $ git add file
> > $ git commit -m init
> > [master (root-commit)]: created 2155efd: "init"
> > =A00 files changed, 0 insertions(+), 0 deletions(-)
> > =A0create mode 100644 file
> > $ tg create t/test1
> > tg: Automatically marking dependency on master
> > tg: Creating t/test1 base from master...
> > Switched to a new branch "t/test1"
> > tg: Topic branch t/test1 set up. Please fill .topmsg now and make
> > initial commit.
> > tg: To abort: git rm -f .top* && git checkout master && tg delete t=
/test1
> > $ git commit -m "topic test1"
> > [t/test1]: created 3cb4fbf: "topic test1"
> > =A02 files changed, 7 insertions(+), 0 deletions(-)
> > =A0create mode 100644 .topdeps
> > =A0create mode 100644 .topmsg
> > $ tg create t/test2
> > tg: Automatically marking dependency on t/test1
> > tg: Creating t/test2 base from t/test1...
> > Switched to a new branch "t/test2"
> > tg: Topic branch t/test2 set up. Please fill .topmsg now and make
> > initial commit.
> > tg: To abort: git rm -f .top* && git checkout t/test1 && tg delete =
t/test2
> > $ git rm -f .top* && git checkout t/test1 && tg delete t/test2
> > rm '.topdeps'
> > rm '.topmsg'
> > D =A0 =A0 =A0 .topdeps
> > D =A0 =A0 =A0 .topmsg
> > Switched to branch "t/test1"
> > $ git status
> > # On branch t/test1
> > # Changes to be committed:
> > # =A0 (use "git reset HEAD <file>..." to unstage)
> > #
> > # =A0 =A0 =A0 deleted: =A0 =A0.topdeps
> > # =A0 =A0 =A0 deleted: =A0 =A0.topmsg
> > #
> > $
> Anyone?
I have git version 1.5.6.5 and for me your recipe[1] ends in

	$ git status
	# On branch t/test1
	nothing to commit (working directory clean)

With git 1.6.1.3 I can reproduce it though.

Here comes a git only test case:

	git init
	touch file
	git add file
	git commit -m 'initial commit'
	git checkout -b next
	echo next > file
	git add file
	git rm -f file
	git checkout master
	git status
=09
What about the patch below?  It seems git-checkout from 1.6.x merges th=
e
changes done to the newly checked out branch.

Best regards
Uwe

[1] I had to use mkdir where you wrote md ;-)

=46rom e5b1a979cb22285134c5b7da942984f70a1a3059 Mon Sep 17 00:00:00 200=
1
=46rom: =3D?utf-8?q?Uwe=3D20Kleine-K=3DC3=3DB6nig?=3D <u.kleine-koenig@=
pengutronix.de>
Date: Fri, 27 Feb 2009 09:22:46 +0100
Subject: [PATCH] suggest checkout -f to abort the creation of a branch

git checkout behaves differently for different versions of git (here
1.5.6.5 and 1.6.1.3) when the index and working copy don't match HEAD.

git checkout -f does the right thing for both versions.

Signed-off-by: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>
---
 tg-create.sh |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/tg-create.sh b/tg-create.sh
index 6e84907..45bb79b 100644
--- a/tg-create.sh
+++ b/tg-create.sh
@@ -140,6 +140,6 @@ git add -f "$root_dir/.topmsg"
=20
=20
 info "Topic branch $name set up. Please fill .topmsg now and make init=
ial commit."
-info "To abort: git rm -f .top* && git checkout ${deps%% *} && $tg del=
ete $name"
+info "To abort: git checkout -f ${deps%% *} && $tg delete $name"
=20
 # vim:noet
--=20
1.5.6.5

--=20
Pengutronix e.K.                              | Uwe Kleine-K=F6nig     =
       |
Industrial Linux Solutions                    | http://www.pengutronix.=
de/  |
