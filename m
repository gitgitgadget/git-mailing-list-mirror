From: Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH 7/8] Documentation/cherry-pick: describe passing more than one
	commit
Date: Mon, 31 May 2010 21:42:38 +0200
Message-ID: <20100531194240.28729.50475.chriscool@tuxfamily.org>
References: <20100531193359.28729.55562.chriscool@tuxfamily.org>
Cc: git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jun 01 05:05:08 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OJHmt-0000pF-G9
	for gcvg-git-2@lo.gmane.org; Tue, 01 Jun 2010 05:05:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754052Ab0FADEv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 31 May 2010 23:04:51 -0400
Received: from smtp3-g21.free.fr ([212.27.42.3]:42084 "EHLO smtp3-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753603Ab0FADEg (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 31 May 2010 23:04:36 -0400
Received: from style.boubyland (gre92-7-82-243-130-161.fbx.proxad.net [82.243.130.161])
	by smtp3-g21.free.fr (Postfix) with ESMTP id 68B91818040;
	Tue,  1 Jun 2010 05:04:28 +0200 (CEST)
X-git-sha1: a1443e887ae8952968c0864165f3ae5935413e6d 
X-Mailer: git-mail-commits v0.5.2
In-Reply-To: <20100531193359.28729.55562.chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/148068>

And while at it, add an "Examples" section.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 Documentation/git-cherry-pick.txt |   64 +++++++++++++++++++++++++++++--------
 1 files changed, 50 insertions(+), 14 deletions(-)

diff --git a/Documentation/git-cherry-pick.txt b/Documentation/git-cherry-pick.txt
index d71607a..df2742a 100644
--- a/Documentation/git-cherry-pick.txt
+++ b/Documentation/git-cherry-pick.txt
@@ -3,24 +3,29 @@ git-cherry-pick(1)
 
 NAME
 ----
-git-cherry-pick - Apply the change introduced by an existing commit
+git-cherry-pick - Apply the change introduced by some existing commits
 
 SYNOPSIS
 --------
-'git cherry-pick' [--edit] [-n] [-m parent-number] [-s] [-x] [--ff] <commit>
+'git cherry-pick' [--edit] [-n] [-m parent-number] [-s] [-x] [--ff] <commit>...
 
 DESCRIPTION
 -----------
-Given one existing commit, apply the change the patch introduces, and record a
-new commit that records it.  This requires your working tree to be clean (no
-modifications from the HEAD commit).
+
+Given one or more existing commits, apply the changes that the related
+patches introduce, and record some new commits that record them.  This
+requires your working tree to be clean (no modifications from the HEAD
+commit).
 
 OPTIONS
 -------
-<commit>::
-	Commit to cherry-pick.
+<commit>...::
+	Commits to cherry-pick.
 	For a more complete list of ways to spell commits, see the
 	"SPECIFYING REVISIONS" section in linkgit:git-rev-parse[1].
+	Sets of commits can also be given but no traversal is done
+	by default, see linkgit:git-rev-list[1] and its '--no-walk'
+	option.
 
 -e::
 --edit::
@@ -55,13 +60,12 @@ OPTIONS
 
 -n::
 --no-commit::
-	Usually the command automatically creates a commit.
-	This flag applies the change necessary to cherry-pick
-	the named commit to your working tree and the index,
-	but does not make the commit.  In addition, when this
-	option is used, your index does not have to match the
-	HEAD commit.  The cherry-pick is done against the
-	beginning state of your index.
+	Usually the command automatically creates some commits.  This
+	flag applies the change necessary to cherry-pick the named
+	commits to your working tree and the index, but does not make
+	the commits.  In addition, when this option is used, your
+	index does not have to match the HEAD commit.  The cherry-pick
+	is done against the beginning state of your index.
 +
 This is useful when cherry-picking more than one commits'
 effect to your index in a row.
@@ -75,6 +79,38 @@ effect to your index in a row.
 	cherry-pick'ed commit, then a fast forward to this commit will
 	be performed.
 
+Examples
+--------
+git cherry-pick master::
+
+	Apply the changes specified by the commit pointed to by master
+	and create a new commit with these changes.
+
+git cherry-pick master~3..master::
+git cherry-pick ^master~3 master::
+
+	Apply the changes specified by the last 3 commits pointed to
+	by master and create 3 new commits with these changes.
+
+git cherry-pick master\~3 master~2::
+
+	Apply the changes specified by the fourth and third last
+	commits pointed to by master and create 2 new commits with
+	these changes.
+
+git cherry-pick -n master~1 next::
+
+	Apply to the working tree and the index the changes specified
+	by the second last commit pointed to by master and by the last
+	commit pointed to by next, but do not create any commit with
+	these changes.
+
+git cherry-pick --ff ..next::
+
+	If possible fast forward to the existing commits already in
+	next but not in HEAD, otherwise apply the changes specified by
+	these commits and create new commits with these changes.
+
 Author
 ------
 Written by Junio C Hamano <gitster@pobox.com>
-- 
1.7.1.361.g42de.dirty
