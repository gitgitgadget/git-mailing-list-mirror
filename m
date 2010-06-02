From: Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v2 8/8] Documentation/revert: describe passing more than one
	commit
Date: Wed, 02 Jun 2010 07:58:41 +0200
Message-ID: <20100602055842.21504.85441.chriscool@tuxfamily.org>
References: <20100602055131.21504.71923.chriscool@tuxfamily.org>
Cc: git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Jeff King <peff@peff.net>,
	Antriksh Pany <antriksh.pany@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jun 02 07:59:57 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OJgzc-00072N-MV
	for gcvg-git-2@lo.gmane.org; Wed, 02 Jun 2010 07:59:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753876Ab0FBF7v (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 Jun 2010 01:59:51 -0400
Received: from smtp3-g21.free.fr ([212.27.42.3]:59258 "EHLO smtp3-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753204Ab0FBF7u (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Jun 2010 01:59:50 -0400
Received: from style.boubyland (gre92-7-82-243-130-161.fbx.proxad.net [82.243.130.161])
	by smtp3-g21.free.fr (Postfix) with ESMTP id 9D5EA818102;
	Wed,  2 Jun 2010 07:59:42 +0200 (CEST)
X-git-sha1: 8d752f059f7c6360fbe0cd30c4f7dd1a5bf2105f 
X-Mailer: git-mail-commits v0.5.2
In-Reply-To: <20100602055131.21504.71923.chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/148216>

And while at it, add an "EXAMPLES" section.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 Documentation/git-revert.txt |   51 ++++++++++++++++++++++++++++++-----------
 1 files changed, 37 insertions(+), 14 deletions(-)

diff --git a/Documentation/git-revert.txt b/Documentation/git-revert.txt
index c66bf80..dea4f53 100644
--- a/Documentation/git-revert.txt
+++ b/Documentation/git-revert.txt
@@ -3,20 +3,22 @@ git-revert(1)
 
 NAME
 ----
-git-revert - Revert an existing commit
+git-revert - Revert some existing commits
 
 SYNOPSIS
 --------
-'git revert' [--edit | --no-edit] [-n] [-m parent-number] [-s] <commit>
+'git revert' [--edit | --no-edit] [-n] [-m parent-number] [-s] <commit>...
 
 DESCRIPTION
 -----------
-Given one existing commit, revert the change the patch introduces, and record a
-new commit that records it.  This requires your working tree to be clean (no
-modifications from the HEAD commit).
 
-Note: 'git revert' is used to record a new commit to reverse the
-effect of an earlier commit (often a faulty one).  If you want to
+Given one or more existing commits, revert the changes that the
+related patches introduce, and record some new commits that record
+them.  This requires your working tree to be clean (no modifications
+from the HEAD commit).
+
+Note: 'git revert' is used to record some new commits to reverse the
+effect of some earlier commits (often only a faulty one).  If you want to
 throw away all uncommitted changes in your working directory, you
 should see linkgit:git-reset[1], particularly the '--hard' option.  If
 you want to extract specific files as they were in another commit, you
@@ -26,10 +28,13 @@ both will discard uncommitted changes in your working directory.
 
 OPTIONS
 -------
-<commit>::
-	Commit to revert.
+<commit>...::
+	Commits to revert.
 	For a more complete list of ways to spell commit names, see
 	"SPECIFYING REVISIONS" section in linkgit:git-rev-parse[1].
+	Sets of commits can also be given but no traversal is done by
+	default, see linkgit:git-rev-list[1] and its '--no-walk'
+	option.
 
 -e::
 --edit::
@@ -59,11 +64,11 @@ more details.
 
 -n::
 --no-commit::
-	Usually the command automatically creates a commit with
-	a commit log message stating which commit was
-	reverted.  This flag applies the change necessary
-	to revert the named commit to your working tree
-	and the index, but does not make the commit.  In addition,
+	Usually the command automatically creates some commits with
+	commit log messages stating which commits were
+	reverted.  This flag applies the changes necessary
+	to revert the named commits to your working tree
+	and the index, but does not make the commits.  In addition,
 	when this option is used, your index does not have to match
 	the HEAD commit.  The revert is done against the
 	beginning state of your index.
@@ -75,6 +80,20 @@ effect to your index in a row.
 --signoff::
 	Add Signed-off-by line at the end of the commit message.
 
+EXAMPLES
+--------
+git revert HEAD~3::
+
+	Revert the changes specified by the fourth last commit in HEAD
+	and create a new commit with the reverted changes.
+
+git revert -n master\~5..master~2::
+
+	Revert the changes done by commits from the fifth last commit
+	in master (included) to the third last commit in master
+	(included), but do not create any commit with the reverted
+	changes. The revert only modifies the working tree and the
+	index.
 
 Author
 ------
@@ -84,6 +103,10 @@ Documentation
 --------------
 Documentation by Junio C Hamano and the git-list <git@vger.kernel.org>.
 
+SEE ALSO
+--------
+linkgit:git-cherry-pick[1]
+
 GIT
 ---
 Part of the linkgit:git[1] suite
-- 
1.7.1.362.g8d752
