From: Thomas Rast <trast@student.ethz.ch>
Subject: [PATCH v2 1/4] Documentation/git-merge: reword references to "remote" and "pull"
Date: Sun, 10 Jan 2010 01:02:39 +0100
Message-ID: <57bddb115331a23816af772172531fb56fceace4.1263081032.git.trast@student.ethz.ch>
References: <cover.1263081032.git.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>
To: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Jan 10 01:03:14 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NTlGy-0004Qp-TI
	for gcvg-git-2@lo.gmane.org; Sun, 10 Jan 2010 01:03:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753256Ab0AJADH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 9 Jan 2010 19:03:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752967Ab0AJADG
	(ORCPT <rfc822;git-outgoing>); Sat, 9 Jan 2010 19:03:06 -0500
Received: from gwse.ethz.ch ([129.132.178.237]:17336 "EHLO gwse.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752837Ab0AJADF (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 9 Jan 2010 19:03:05 -0500
Received: from CAS00.d.ethz.ch (129.132.178.234) by gws00.d.ethz.ch
 (129.132.178.237) with Microsoft SMTP Server (TLS) id 8.2.213.0; Sun, 10 Jan
 2010 01:03:04 +0100
Received: from localhost.localdomain (217.162.250.31) by mail.ethz.ch
 (129.132.178.227) with Microsoft SMTP Server (TLS) id 8.2.213.0; Sun, 10 Jan
 2010 01:02:42 +0100
X-Mailer: git-send-email 1.6.6.218.g502b0
In-Reply-To: <cover.1263081032.git.trast@student.ethz.ch>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/136542>

The git-merge manpage was written in terms of merging a "remote",
which is no longer the case: you merge local or remote-tracking
branches; pull is for actual remotes.

Adjust the manpage accordingly.  We refer to the arguments as
"commits", and change instances of "remote" to "other" (where branches
are concerned) or "theirs" (where conflict sides are concerned).
Remove the single reference to "pulling".

Signed-off-by: Thomas Rast <trast@student.ethz.ch>
---
 Documentation/git-merge.txt |   34 +++++++++++++++++-----------------
 1 files changed, 17 insertions(+), 17 deletions(-)

diff --git a/Documentation/git-merge.txt b/Documentation/git-merge.txt
index e886c2e..4896587 100644
--- a/Documentation/git-merge.txt
+++ b/Documentation/git-merge.txt
@@ -10,17 +10,17 @@ SYNOPSIS
 --------
 [verse]
 'git merge' [-n] [--stat] [--no-commit] [--squash] [-s <strategy>]...
-	[-m <msg>] <remote>...
-'git merge' <msg> HEAD <remote>...
+	[-m <msg>] <commit>...
+'git merge' <msg> HEAD <commit>...
 
 DESCRIPTION
 -----------
-This is the top-level interface to the merge machinery
-which drives multiple merge strategy scripts.
+Merges the history specified by <commit> into HEAD, optionally using a
+specific merge strategy.
 
-The second syntax (<msg> `HEAD` <remote>) is supported for
+The second syntax (<msg> `HEAD` <commit>...) is supported for
 historical reasons.  Do not use it from the command line or in
-new scripts.  It is the same as `git merge -m <msg> <remote>`.
+new scripts.  It is the same as `git merge -m <msg> <commit>...`.
 
 
 OPTIONS
@@ -33,10 +33,10 @@ include::merge-options.txt[]
 	used to give a good default for automated 'git merge'
 	invocations.
 
-<remote>...::
-	Other branch heads to merge into our branch.  You need at
-	least one <remote>.  Specifying more than one <remote>
-	obviously means you are trying an Octopus.
+<commit>...::
+	Commits, usually other branch heads, to merge into our branch.
+	You need at least one <commit>.  Specifying more than one
+	<commit> obviously means you are trying an Octopus.
 
 include::merge-strategies.txt[]
 
@@ -96,8 +96,8 @@ file matches exactly the current `HEAD` commit; otherwise we
 will write out your local changes already registered in your
 index file along with the merge result, which is not good.
 Because 1. involves only those paths differing between your
-branch and the remote branch you are pulling from during the
-merge (which is typically a fraction of the whole tree), you can
+branch and the branch you are merging
+(which is typically a fraction of the whole tree), you can
 have local modifications in your working tree as long as they do
 not overlap with what the merge updates.
 
@@ -110,7 +110,7 @@ When there are conflicts, the following happens:
 
 3. For conflicting paths, the index file records up to three
    versions; stage1 stores the version from the common ancestor,
-   stage2 from `HEAD`, and stage3 from the remote branch (you
+   stage2 from `HEAD`, and stage3 from the other branch (you
    can inspect the stages with `git ls-files -u`).  The working
    tree files contain the result of the "merge" program; i.e. 3-way
    merge results with familiar conflict markers `<<< === >>>`.
@@ -202,15 +202,15 @@ You can work through the conflict with a number of tools:
    mergetool which will work you through the merge.
 
  * Look at the diffs.  'git diff' will show a three-way diff,
-   highlighting changes from both the HEAD and remote versions.
+   highlighting changes from both the HEAD and their versions.
 
  * Look at the diffs on their own. 'git log --merge -p <path>'
-   will show diffs first for the HEAD version and then the
-   remote version.
+   will show diffs first for the HEAD version and then
+   their version.
 
  * Look at the originals.  'git show :1:filename' shows the
    common ancestor, 'git show :2:filename' shows the HEAD
-   version and 'git show :3:filename' shows the remote version.
+   version and 'git show :3:filename' shows their version.
 
 
 EXAMPLES
-- 
1.6.6.218.g502b0
