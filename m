From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [DOC BUG] branch.autosetupmerge defaults to true, not false
Date: Mon, 11 Feb 2008 11:27:20 +0000 (GMT)
Message-ID: <alpine.LSU.1.00.0802111125100.3870@racer.site>
References: <87bq6nc22l.fsf@Astalo.kon.iki.fi> <7vejbjam9g.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Kalle Olavi Niemitalo <kon@iki.fi>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Feb 11 12:28:05 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JOWpD-0008JG-1i
	for gcvg-git-2@gmane.org; Mon, 11 Feb 2008 12:27:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751110AbYBKL1N (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Feb 2008 06:27:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751093AbYBKL1N
	(ORCPT <rfc822;git-outgoing>); Mon, 11 Feb 2008 06:27:13 -0500
Received: from mail.gmx.net ([213.165.64.20]:39188 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750994AbYBKL1M (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Feb 2008 06:27:12 -0500
Received: (qmail invoked by alias); 11 Feb 2008 11:27:10 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp015) with SMTP; 11 Feb 2008 12:27:10 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19z+r08xR5zrlP3CsmSZmnGR4htQSuufNZQijatbK
	+wEfzFCT89aTZ6
X-X-Sender: gene099@racer.site
In-Reply-To: <7vejbjam9g.fsf@gitster.siamese.dyndns.org>
User-Agent: Alpine 1.00 (LSU 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73518>

[PATCH] Document that the default of branch.autosetupmerge is true

In 34a3e69 (git-branch: default to --track) the default was changed to
true, to help new git users.  But yours truly forgot to update the
documentation.  This fixes it.

Noticed by Kalle Olavi Niemitalo.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---

	On Mon, 11 Feb 2008, Junio C Hamano wrote:

	> Kalle Olavi Niemitalo <kon@iki.fi> writes:
	> 
	> > In Git v1.5.4.1, Documentation/config.txt describes:
	> >
	> >> branch.autosetupmerge::
	> >> Tells `git-branch` and `git-checkout` to setup new branches
	> >> so that linkgit:git-pull[1] will appropriately merge from 
	> >> that remote branch.  Note that even if this option is not 
	> >> set, this behavior can be chosen per-branch using the 
	> >> `--track` and `--no-track` options.  This option defaults to 
	> >> false.
	> >
	> > However, in builtin-branch.c:
	> >
	> >> static int branch_track = 1;
	> > ...
	> >> if (!strcmp(var, "branch.autosetupmerge"))
	> >> branch_track = git_config_bool(var, value);
	> >
	> > So if the option is not listed in .git/config, then it actually
	> > defaults to true.  A demonstration with a bit older version:
	> 
	> Correct.  34a3e69 (git-branch: default to --track) did it
	> without updating the documentation.

	Yeah, sorry.  I had hoped that Jakub or some other documentation 
	fan would step up to it.

	Hopefully I did catch all places.

 Documentation/config.txt       |    2 +-
 Documentation/git-branch.txt   |   15 ++++++++-------
 Documentation/git-checkout.txt |    7 ++++---
 3 files changed, 13 insertions(+), 11 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 59305a3..b5d682e 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -382,7 +382,7 @@ branch.autosetupmerge::
 	so that linkgit:git-pull[1] will appropriately merge from that
 	remote branch.  Note that even if this option is not set,
 	this behavior can be chosen per-branch using the `--track`
-	and `--no-track` options.  This option defaults to false.
+	and `--no-track` options.  This option defaults to true.
 
 branch.<name>.remote::
 	When in branch <name>, it tells `git fetch` which remote to fetch.
diff --git a/Documentation/git-branch.txt b/Documentation/git-branch.txt
index 9ea9249..f1de846 100644
--- a/Documentation/git-branch.txt
+++ b/Documentation/git-branch.txt
@@ -35,11 +35,11 @@ Note that this will create the new branch, but it will not switch the
 working tree to it; use "git checkout <newbranch>" to switch to the
 new branch.
 
-When a local branch is started off a remote branch, git can setup the
+When a local branch is started off a remote branch, git sets up the
 branch so that linkgit:git-pull[1] will appropriately merge from that
-remote branch.  If this behavior is desired, it is possible to make it
-the default using the global `branch.autosetupmerge` configuration
-flag.  Otherwise, it can be chosen per-branch using the `--track`
+remote branch.  If this behavior is not desired, it is possible to
+disable it using the global `branch.autosetupmerge` configuration
+flag.  That setting can be overridden by using the `--track`
 and `--no-track` options.
 
 With a '-m' or '-M' option, <oldbranch> will be renamed to <newbranch>.
@@ -109,10 +109,11 @@ OPTIONS
 	Set up configuration so that git-pull will automatically
 	retrieve data from the remote branch.  Use this if you always
 	pull from the same remote branch into the new branch, or if you
-	don't want to use "git pull <repository> <refspec>" explicitly.  Set the
-	branch.autosetupmerge configuration variable to true if you
+	don't want to use "git pull <repository> <refspec>" explicitly.
+	This behavior is the default.  Set the
+	branch.autosetupmerge configuration variable to false if you
 	want git-checkout and git-branch to always behave as if
-	'--track' were given.
+	'--no-track' were given.
 
 --no-track::
 	When a branch is created off a remote branch,
diff --git a/Documentation/git-checkout.txt b/Documentation/git-checkout.txt
index 584359f..b4cfa04 100644
--- a/Documentation/git-checkout.txt
+++ b/Documentation/git-checkout.txt
@@ -52,10 +52,11 @@ OPTIONS
 	set up configuration so that git-pull will automatically
 	retrieve data from the remote branch.  Use this if you always
 	pull from the same remote branch into the new branch, or if you
-	don't want to use "git pull <repository> <refspec>" explicitly.  Set the
-	branch.autosetupmerge configuration variable to true if you
+	don't want to use "git pull <repository> <refspec>" explicitly.
+	This behavior is the default.  Set the
+	branch.autosetupmerge configuration variable to false if you
 	want git-checkout and git-branch to always behave as if
-	'--track' were given.
+	'--no-track' were given.
 
 --no-track::
 	When -b is given and a branch is created off a remote branch,
-- 
1.5.4.1264.gb53928
