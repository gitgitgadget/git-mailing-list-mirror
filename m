From: Thomas Rast <trast@student.ethz.ch>
Subject: [RFC PATCH 2/5] Documentation/reset: separate options by mode
Date: Fri, 16 Jul 2010 11:44:39 +0200
Message-ID: <0bfc95a7c144ccc811b58321a33caf89d20495e1.1279273256.git.trast@student.ethz.ch>
References: <cover.1279273256.git.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain
To: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Jul 16 11:45:14 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OZhTl-0000Fo-St
	for gcvg-git-2@lo.gmane.org; Fri, 16 Jul 2010 11:45:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964870Ab0GPJpK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 16 Jul 2010 05:45:10 -0400
Received: from gwse.ethz.ch ([129.132.178.237]:43493 "EHLO gwse.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S964854Ab0GPJpF (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 Jul 2010 05:45:05 -0400
Received: from CAS22.d.ethz.ch (172.31.51.112) by gws00.d.ethz.ch
 (129.132.178.237) with Microsoft SMTP Server (TLS) id 8.2.254.0; Fri, 16 Jul
 2010 11:45:03 +0200
Received: from localhost.localdomain (129.132.153.233) by CAS22.d.ethz.ch
 (172.31.51.112) with Microsoft SMTP Server (TLS) id 14.0.702.0; Fri, 16 Jul
 2010 11:44:42 +0200
X-Mailer: git-send-email 1.7.2.rc3.259.g43154
In-Reply-To: <cover.1279273256.git.trast@student.ethz.ch>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/151140>

Remove all but -q from the OPTIONS section, and instead explain the
options separated by usage mode, since they only apply to one each.

Signed-off-by: Thomas Rast <trast@student.ethz.ch>

fixup! Documentation/reset: separate options by mode
---
 Documentation/git-reset.txt |   58 +++++++++++++++++++++++-------------------
 1 files changed, 32 insertions(+), 26 deletions(-)

diff --git a/Documentation/git-reset.txt b/Documentation/git-reset.txt
index dbb810d..46b2d2a 100644
--- a/Documentation/git-reset.txt
+++ b/Documentation/git-reset.txt
@@ -8,29 +8,38 @@ git-reset - Reset current HEAD to the specified state
 SYNOPSIS
 --------
 [verse]
-'git reset' [--soft | --mixed | --hard | --merge | --keep] [-q] [<commit>]
 'git reset' [-q] [<commit>] [--] <paths>...
 'git reset' --patch [<commit>] [--] [<paths>...]
+'git reset' [--soft | --mixed | --hard | --merge | --keep] [-q] [<commit>]
 
 DESCRIPTION
 -----------
-Sets the current head to the specified commit and optionally resets the
-index and working tree to match.
-
-This command is useful if you notice some small error in a recent
-commit (or set of commits) and want to redo that part without showing
-the undo in the history.
-
-If you want to undo a commit other than the latest on a branch,
-linkgit:git-revert[1] is your friend.
-
-The second and third forms with 'paths' and/or --patch are used to
-revert selected paths in the index from a given commit, without moving
-HEAD.
+Sets the current branch to the specified <commit> and optionally
+resets the index and working tree to match.  The <commit> defaults to
+HEAD in all forms.
+
+'git reset' [-q] [<commit>] [--] <paths>...::
+	This form resets the index entries for all <paths> to their
+	state at the <commit>.  (It does not affect the worktree, nor
+	the current branch.)
++
+This means that `git reset <paths>` is the opposite of `git add
+<paths>`, provided that the <paths> were already tracked.
 
+'git reset' --patch|-p [<commit>] [--] [<paths>...]::
+	Interactively select hunks in the difference between the index
+	and <commit> (defaults to HEAD).  The chosen hunks are applied
+	in reverse to the index.
++
+This means that `git reset -p` is the opposite of `git add -p` (see
+linkgit:git-add[1]).
 
-OPTIONS
--------
+'git reset' [--<mode>] [<commit>]::
+	This form points the current branch to <commit> and then
+	updates index and working tree according to <mode>, which must
+	be one of the following:
++
+--
 --soft::
 	Does not touch the index file nor the working tree at all, but
 	requires them to be in a good order. This leaves all your changed
@@ -59,22 +68,19 @@ OPTIONS
 	the given commit.  If a file that is different between the
 	current commit and the given commit has local changes, reset
 	is aborted.
+--
 
--p::
---patch::
-	Interactively select hunks in the difference between the index
-	and <commit> (defaults to HEAD).  The chosen hunks are applied
-	in reverse to the index.
-+
-This means that `git reset -p` is the opposite of `git add -p` (see
-linkgit:git-add[1]).
+If you want to undo a commit other than the latest on a branch,
+linkgit:git-revert[1] is your friend.
+
+
+OPTIONS
+-------
 
 -q::
 --quiet::
 	Be quiet, only report errors.
 
-<commit>::
-	Commit to make the current HEAD. If not given defaults to HEAD.
 
 DISCUSSION
 ----------
-- 
1.7.2.rc3.259.g43154
