From: Thomas Rast <trast@student.ethz.ch>
Subject: [PATCH v2 2/5] Documentation/reset: separate options by mode
Date: Sun, 18 Jul 2010 20:23:23 +0200
Message-ID: <975d0001acbaf4f33fa9b51ce878a9247b8a9e5f.1279477130.git.trast@student.ethz.ch>
References: <cover.1279477130.git.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Junio C Hamano <gitster@pobox.com>
To: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Jul 18 20:24:07 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OaYWz-0002SZ-D6
	for gcvg-git-2@lo.gmane.org; Sun, 18 Jul 2010 20:24:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756944Ab0GRSXh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 18 Jul 2010 14:23:37 -0400
Received: from gwse.ethz.ch ([129.132.178.237]:54307 "EHLO gwse.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756934Ab0GRSXg (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 18 Jul 2010 14:23:36 -0400
Received: from CAS12.d.ethz.ch (172.31.38.212) by gws00.d.ethz.ch
 (129.132.178.237) with Microsoft SMTP Server (TLS) id 8.2.254.0; Sun, 18 Jul
 2010 20:23:34 +0200
Received: from localhost.localdomain (129.132.209.162) by CAS12.d.ethz.ch
 (172.31.38.212) with Microsoft SMTP Server (TLS) id 14.0.702.0; Sun, 18 Jul
 2010 20:23:33 +0200
X-Mailer: git-send-email 1.7.2.rc3.317.gc287
In-Reply-To: <cover.1279477130.git.trast@student.ethz.ch>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/151233>

Remove all but -q from the OPTIONS section, and instead explain the
options separated by usage mode, since they only apply to one each.

Signed-off-by: Thomas Rast <trast@student.ethz.ch>
---
 Documentation/git-reset.txt |   59 ++++++++++++++++++++++++-------------------
 1 files changed, 33 insertions(+), 26 deletions(-)

diff --git a/Documentation/git-reset.txt b/Documentation/git-reset.txt
index dbb810d..dca75b3 100644
--- a/Documentation/git-reset.txt
+++ b/Documentation/git-reset.txt
@@ -8,29 +8,39 @@ git-reset - Reset current HEAD to the specified state
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
+In the first and second form, copy entries from <commit> to the index.
+In the third form, set the current branch to <commit>, optionally
+modifying index and worktree to match.  The <commit> defaults to HEAD
+in all forms.
+
+'git reset' [-q] [<commit>] [--] <paths>...::
+	This form resets the index entries for all <paths> to their
+	state at the <commit>.  (It does not affect the worktree, nor
+	the current branch.)
++
+This means that `git reset <paths>` is the opposite of `git add
+<paths>`.
 
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
@@ -59,22 +69,19 @@ OPTIONS
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
1.7.2.rc3.317.gc287
