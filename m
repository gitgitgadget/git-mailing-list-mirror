From: Vasco Almeida <vascomalmeida@sapo.pt>
Subject: [PATCH v4 25/38] i18n: notes: mark strings for translation
Date: Tue,  7 Jun 2016 11:52:24 +0000
Message-ID: <1465300357-7557-26-git-send-email-vascomalmeida@sapo.pt>
References: <1465300357-7557-1-git-send-email-vascomalmeida@sapo.pt>
Cc: Vasco Almeida <vascomalmeida@sapo.pt>,
	Jiang Xin <worldhello.net@gmail.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>, Sunshine <sunshine@sunshineco.com>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jun 07 13:56:32 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1bAFcF-0000Uj-SM
	for gcvg-git-2@plane.gmane.org; Tue, 07 Jun 2016 13:56:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161146AbcFGLz7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 Jun 2016 07:55:59 -0400
Received: from relay5.ptmail.sapo.pt ([212.55.154.25]:58264 "EHLO sapo.pt"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1754057AbcFGLzC (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Jun 2016 07:55:02 -0400
Received: (qmail 1885 invoked from network); 7 Jun 2016 11:55:00 -0000
Received: (qmail 21797 invoked from network); 7 Jun 2016 11:55:00 -0000
Received: from unknown (HELO localhost.localdomain) (vascomalmeida@sapo.pt@[85.246.157.91])
          (envelope-sender <vascomalmeida@sapo.pt>)
          by ptmail-mta-auth02 (qmail-ptmail-1.0.0) with ESMTPA
          for <git@vger.kernel.org>; 7 Jun 2016 11:54:58 -0000
X-PTMail-RemoteIP: 85.246.157.91
X-PTMail-AllowedSender-Action: 
X-PTMail-Service: default
X-Mailer: git-send-email 2.7.3
In-Reply-To: <1465300357-7557-1-git-send-email-vascomalmeida@sapo.pt>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/296665>

Mark strings of messages for the user as translatable.

Update tests t3310-notes-merge-manual-resolve.sh and
t3320-notes-merge-worktrees.sh to reflect new translatable messages.

Tests that grep for .git/NOTES_MERGE_WORKTREE reflect the translatable
string "Automatic notes merge failed. Fix conflicts in %s and [...]".

Signed-off-by: Vasco Almeida <vascomalmeida@sapo.pt>
---
 builtin/notes.c                       | 20 ++++++++++----------
 t/t3310-notes-merge-manual-resolve.sh |  8 ++++----
 t/t3320-notes-merge-worktrees.sh      |  2 +-
 3 files changed, 15 insertions(+), 15 deletions(-)

diff --git a/builtin/notes.c b/builtin/notes.c
index c65b59a..d11e6eb 100644
--- a/builtin/notes.c
+++ b/builtin/notes.c
@@ -749,7 +749,7 @@ static int git_config_get_notes_strategy(const char *key,
 	if (git_config_get_string(key, &value))
 		return 1;
 	if (parse_notes_merge_strategy(value, strategy))
-		git_die_config(key, "unknown notes merge strategy %s", value);
+		git_die_config(key, _("unknown notes merge strategy %s"), value);
 
 	free(value);
 	return 0;
@@ -788,15 +788,15 @@ static int merge(int argc, const char **argv, const char *prefix)
 	if (strategy || do_commit + do_abort == 0)
 		do_merge = 1;
 	if (do_merge + do_commit + do_abort != 1) {
-		error("cannot mix --commit, --abort or -s/--strategy");
+		error(_("cannot mix --commit, --abort or -s/--strategy"));
 		usage_with_options(git_notes_merge_usage, options);
 	}
 
 	if (do_merge && argc != 1) {
-		error("Must specify a notes ref to merge");
+		error(_("Must specify a notes ref to merge"));
 		usage_with_options(git_notes_merge_usage, options);
 	} else if (!do_merge && argc) {
-		error("too many parameters");
+		error(_("too many parameters"));
 		usage_with_options(git_notes_merge_usage, options);
 	}
 
@@ -817,7 +817,7 @@ static int merge(int argc, const char **argv, const char *prefix)
 
 	if (strategy) {
 		if (parse_notes_merge_strategy(strategy, &o.strategy)) {
-			error("Unknown -s/--strategy: %s", strategy);
+			error(_("Unknown -s/--strategy: %s"), strategy);
 			usage_with_options(git_notes_merge_usage, options);
 		}
 	} else {
@@ -857,11 +857,11 @@ static int merge(int argc, const char **argv, const char *prefix)
 			die(_("A notes merge into %s is already in-progress at %s"),
 			    default_notes_ref(), wt->path);
 		if (create_symref("NOTES_MERGE_REF", default_notes_ref(), NULL))
-			die("Failed to store link to current notes ref (%s)",
+			die(_("Failed to store link to current notes ref (%s)"),
 			    default_notes_ref());
-		printf("Automatic notes merge failed. Fix conflicts in %s and "
-		       "commit the result with 'git notes merge --commit', or "
-		       "abort the merge with 'git notes merge --abort'.\n",
+		printf(_("Automatic notes merge failed. Fix conflicts in %s and "
+			 "commit the result with 'git notes merge --commit', or "
+			 "abort the merge with 'git notes merge --abort'.\n"),
 		       git_path(NOTES_MERGE_WORKTREE));
 	}
 
@@ -964,7 +964,7 @@ static int get_ref(int argc, const char **argv, const char *prefix)
 			     git_notes_get_ref_usage, 0);
 
 	if (argc) {
-		error("too many parameters");
+		error(_("too many parameters"));
 		usage_with_options(git_notes_get_ref_usage, options);
 	}
 
diff --git a/t/t3310-notes-merge-manual-resolve.sh b/t/t3310-notes-merge-manual-resolve.sh
index d557212..6967436 100755
--- a/t/t3310-notes-merge-manual-resolve.sh
+++ b/t/t3310-notes-merge-manual-resolve.sh
@@ -178,7 +178,7 @@ test_expect_success 'merge z into m (== y) with default ("manual") resolver => C
 	git config core.notesRef refs/notes/m &&
 	test_must_fail git notes merge z >output &&
 	# Output should point to where to resolve conflicts
-	grep -q "\\.git/NOTES_MERGE_WORKTREE" output &&
+	test_i18ngrep "\\.git/NOTES_MERGE_WORKTREE" output &&
 	# Inspect merge conflicts
 	ls .git/NOTES_MERGE_WORKTREE >output_conflicts &&
 	test_cmp expect_conflicts output_conflicts &&
@@ -381,7 +381,7 @@ test_expect_success 'redo merge of z into m (== y) with default ("manual") resol
 	git config core.notesRef refs/notes/m &&
 	test_must_fail git notes merge z >output &&
 	# Output should point to where to resolve conflicts
-	grep -q "\\.git/NOTES_MERGE_WORKTREE" output &&
+	test_i18ngrep "\\.git/NOTES_MERGE_WORKTREE" output &&
 	# Inspect merge conflicts
 	ls .git/NOTES_MERGE_WORKTREE >output_conflicts &&
 	test_cmp expect_conflicts output_conflicts &&
@@ -415,7 +415,7 @@ git rev-parse refs/notes/z > pre_merge_z
 test_expect_success 'redo merge of z into m (== y) with default ("manual") resolver => Conflicting 3-way merge' '
 	test_must_fail git notes merge z >output &&
 	# Output should point to where to resolve conflicts
-	grep -q "\\.git/NOTES_MERGE_WORKTREE" output &&
+	test_i18ngrep "\\.git/NOTES_MERGE_WORKTREE" output &&
 	# Inspect merge conflicts
 	ls .git/NOTES_MERGE_WORKTREE >output_conflicts &&
 	test_cmp expect_conflicts output_conflicts &&
@@ -496,7 +496,7 @@ test_expect_success 'redo merge of z into m (== y) with default ("manual") resol
 	git update-ref refs/notes/m refs/notes/y &&
 	test_must_fail git notes merge z >output &&
 	# Output should point to where to resolve conflicts
-	grep -q "\\.git/NOTES_MERGE_WORKTREE" output &&
+	test_i18ngrep "\\.git/NOTES_MERGE_WORKTREE" output &&
 	# Inspect merge conflicts
 	ls .git/NOTES_MERGE_WORKTREE >output_conflicts &&
 	test_cmp expect_conflicts output_conflicts &&
diff --git a/t/t3320-notes-merge-worktrees.sh b/t/t3320-notes-merge-worktrees.sh
index 522157b..6e05115 100755
--- a/t/t3320-notes-merge-worktrees.sh
+++ b/t/t3320-notes-merge-worktrees.sh
@@ -62,7 +62,7 @@ test_expect_success 'merge z into x while mid-merge on y succeeds' '
 		cd worktree2 &&
 		git config core.notesRef refs/notes/x &&
 		test_must_fail git notes merge z 2>&1 >out &&
-		grep "Automatic notes merge failed" out &&
+		test_i18ngrep "Automatic notes merge failed" out &&
 		grep -v "A notes merge into refs/notes/x is already in-progress in" out
 	) &&
 	echo "ref: refs/notes/x" >expect &&
-- 
2.7.3
