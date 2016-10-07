Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.3 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0E68320986
	for <e@80x24.org>; Fri,  7 Oct 2016 16:09:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S938948AbcJGQI7 (ORCPT <rfc822;e@80x24.org>);
        Fri, 7 Oct 2016 12:08:59 -0400
Received: from mout.gmx.net ([212.227.17.22]:53868 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S936461AbcJGQI6 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 7 Oct 2016 12:08:58 -0400
Received: from virtualbox ([37.24.142.40]) by mail.gmx.com (mrgmx103) with
 ESMTPSA (Nemesis) id 0Lp3Qu-1bDjEX11yG-00ew0P; Fri, 07 Oct 2016 18:08:53
 +0200
Date:   Fri, 7 Oct 2016 18:08:38 +0200 (CEST)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v4 3/6] wt-status: make the require_clean_work_tree() function
 reusable
In-Reply-To: <cover.1475856491.git.johannes.schindelin@gmx.de>
Message-ID: <fc1ff20fe6a6b5bc43adc1c72a29960e1e303528.1475856491.git.johannes.schindelin@gmx.de>
References: <cover.1475586229.git.johannes.schindelin@gmx.de> <cover.1475856491.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:XYelGmdLwwtyYiIU3JkCrlPk7vXuBLuQK9XrglSexXojOiy18oV
 J19fYcvjWVKEC/monXUqoY7+U7PFCqzDpQkGLHf0dspGX3aGvGMmiyrOR1RGjcD0N8Iqim0
 2fmVqF0TMaOte4VFXBRHCegxOulgkedaZu18OiFpn8+shsQzsM1CSkURACyxTifS8RTambJ
 DcmyhpvxHRNcj70EodlBg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:sNdsYw7cmHU=:QVrVpj1ptNl9KPmOITIWQh
 /moE10PBoAAYFZng+jYLQDcUu4WM5iyokieEvR8FEf3ogouU1oFoek3hL+wBE3kI8SAjjiCSE
 woNP/VMFTzwppqREILyAi8456IFyzS0t/QFjnzG+nuYWTEpuV9sPjXA4uKESGAAmAk7c9gF6O
 m7cSQt+Zg7b8r86pxpdLHXLK3bQ+6Q6GeJCLNO/ObgD8UpMGG00FMznjDBd3YQDX0ffP1XhWF
 ZumI+f4M5UI4/2HoopcUKbqqW1mCLK/bIYNtmW33NT1ll0gOF5HeY+dnpNHfIxwQkGVMo1enT
 Pc9k3Pv8p8Lwk1vmiXBQ5PA1ni+yC5Bpl//b0oBL07s8IhJrgHN/Rss/hUhT9vs8rsdMqrgTy
 So5GoC+On3eAN0KMTAyYWGYFzOpu7qjul7OXSFaSNRBS6qWCEkZj0xML5X+M0O6Pd+HQj3qD2
 zhoZxuwMtxGaEc24ckxMlosYpt0HEJuB+FwFBcEkj+JNC95UpR75pU1gYLcClDUW3r7C4ht2Z
 wJyzmUFVrgkRG4PfOX/SJFyB1oVxEvrtp1q13F736dURPqejp6pKy94gbTffUe4+nuw8ziquv
 ATkwXI6hSsKp7BAuqMO9pLZbgB/iFfslMPjQYv5qLSefMNlqBStS7mACLdvIBUvORypLnE10d
 69srB+u2rrwbAOIiBPILNQSd+3C+jjTyaHJ5gqca/GtQyQ59OmO3e1u6Zag+jdWykquTeao51
 vWOe/LXjlLbXiov4DynZdqxpHizkhesd0F2EQX2eTmn+UrvCtLwdBSctqi4mCZFvILHsWG/6z
 vcYANY2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The function used by "git pull" to stop the user when the working
tree has changes is useful in other places.

Let's move it into a more prominent (and into an actually reusable)
spot: wt-status.[ch].

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 builtin/pull.c | 77 +---------------------------------------------------------
 wt-status.c    | 76 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 wt-status.h    |  3 +++
 3 files changed, 80 insertions(+), 76 deletions(-)

diff --git a/builtin/pull.c b/builtin/pull.c
index 58fc176..01b6465 100644
--- a/builtin/pull.c
+++ b/builtin/pull.c
@@ -17,6 +17,7 @@
 #include "revision.h"
 #include "tempfile.h"
 #include "lockfile.h"
+#include "wt-status.h"
 
 enum rebase_type {
 	REBASE_INVALID = -1,
@@ -326,82 +327,6 @@ static int git_pull_config(const char *var, const char *value, void *cb)
 }
 
 /**
- * Returns 1 if there are unstaged changes, 0 otherwise.
- */
-static int has_unstaged_changes(void)
-{
-	struct rev_info rev_info;
-	int result;
-
-	init_revisions(&rev_info, NULL);
-	DIFF_OPT_SET(&rev_info.diffopt, IGNORE_SUBMODULES);
-	DIFF_OPT_SET(&rev_info.diffopt, QUICK);
-	diff_setup_done(&rev_info.diffopt);
-	result = run_diff_files(&rev_info, 0);
-	return diff_result_code(&rev_info.diffopt, result);
-}
-
-/**
- * Returns 1 if there are uncommitted changes, 0 otherwise.
- */
-static int has_uncommitted_changes(void)
-{
-	struct rev_info rev_info;
-	int result;
-
-	if (is_cache_unborn())
-		return 0;
-
-	init_revisions(&rev_info, NULL);
-	DIFF_OPT_SET(&rev_info.diffopt, IGNORE_SUBMODULES);
-	DIFF_OPT_SET(&rev_info.diffopt, QUICK);
-	add_head_to_pending(&rev_info);
-	diff_setup_done(&rev_info.diffopt);
-	result = run_diff_index(&rev_info, 1);
-	return diff_result_code(&rev_info.diffopt, result);
-}
-
-/**
- * If the work tree has unstaged or uncommitted changes, dies with the
- * appropriate message.
- */
-static int require_clean_work_tree(const char *action, const char *hint,
-		int gently)
-{
-	struct lock_file *lock_file = xcalloc(1, sizeof(*lock_file));
-	int err = 0;
-
-	hold_locked_index(lock_file, 0);
-	refresh_cache(REFRESH_QUIET);
-	update_index_if_able(&the_index, lock_file);
-	rollback_lock_file(lock_file);
-
-	if (has_unstaged_changes()) {
-		/* TRANSLATORS: the action is e.g. "pull with rebase" */
-		error(_("Cannot %s: You have unstaged changes."), _(action));
-		err = 1;
-	}
-
-	if (has_uncommitted_changes()) {
-		if (err)
-			error(_("Additionally, your index contains uncommitted changes."));
-		else
-			error(_("Cannot %s: Your index contains uncommitted changes."),
-			      _(action));
-		err = 1;
-	}
-
-	if (err) {
-		if (hint)
-			error("%s", hint);
-		if (!gently)
-			exit(128);
-	}
-
-	return err;
-}
-
-/**
  * Appends merge candidates from FETCH_HEAD that are not marked not-for-merge
  * into merge_heads.
  */
diff --git a/wt-status.c b/wt-status.c
index 99d1b0a..89475f1 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -16,6 +16,7 @@
 #include "strbuf.h"
 #include "utf8.h"
 #include "worktree.h"
+#include "lockfile.h"
 
 static const char cut_line[] =
 "------------------------ >8 ------------------------\n";
@@ -2208,3 +2209,78 @@ void wt_status_print(struct wt_status *s)
 		break;
 	}
 }
+
+/**
+ * Returns 1 if there are unstaged changes, 0 otherwise.
+ */
+static int has_unstaged_changes(void)
+{
+	struct rev_info rev_info;
+	int result;
+
+	init_revisions(&rev_info, NULL);
+	DIFF_OPT_SET(&rev_info.diffopt, IGNORE_SUBMODULES);
+	DIFF_OPT_SET(&rev_info.diffopt, QUICK);
+	diff_setup_done(&rev_info.diffopt);
+	result = run_diff_files(&rev_info, 0);
+	return diff_result_code(&rev_info.diffopt, result);
+}
+
+/**
+ * Returns 1 if there are uncommitted changes, 0 otherwise.
+ */
+static int has_uncommitted_changes(void)
+{
+	struct rev_info rev_info;
+	int result;
+
+	if (is_cache_unborn())
+		return 0;
+
+	init_revisions(&rev_info, NULL);
+	DIFF_OPT_SET(&rev_info.diffopt, IGNORE_SUBMODULES);
+	DIFF_OPT_SET(&rev_info.diffopt, QUICK);
+	add_head_to_pending(&rev_info);
+	diff_setup_done(&rev_info.diffopt);
+	result = run_diff_index(&rev_info, 1);
+	return diff_result_code(&rev_info.diffopt, result);
+}
+
+/**
+ * If the work tree has unstaged or uncommitted changes, dies with the
+ * appropriate message.
+ */
+int require_clean_work_tree(const char *action, const char *hint, int gently)
+{
+	struct lock_file *lock_file = xcalloc(1, sizeof(*lock_file));
+	int err = 0;
+
+	hold_locked_index(lock_file, 0);
+	refresh_cache(REFRESH_QUIET);
+	update_index_if_able(&the_index, lock_file);
+	rollback_lock_file(lock_file);
+
+	if (has_unstaged_changes()) {
+		/* TRANSLATORS: the action is e.g. "pull with rebase" */
+		error(_("Cannot %s: You have unstaged changes."), _(action));
+		err = 1;
+	}
+
+	if (has_uncommitted_changes()) {
+		if (err)
+			error(_("Additionally, your index contains uncommitted changes."));
+		else
+			error(_("Cannot %s: Your index contains uncommitted changes."),
+			      _(action));
+		err = 1;
+	}
+
+	if (err) {
+		if (hint)
+			error("%s", hint);
+		if (!gently)
+			exit(128);
+	}
+
+	return err;
+}
diff --git a/wt-status.h b/wt-status.h
index e401837..68b4709 100644
--- a/wt-status.h
+++ b/wt-status.h
@@ -128,4 +128,7 @@ void status_printf_ln(struct wt_status *s, const char *color, const char *fmt, .
 __attribute__((format (printf, 3, 4)))
 void status_printf(struct wt_status *s, const char *color, const char *fmt, ...);
 
+/* The following function expects that the caller took care of reading the index. */
+int require_clean_work_tree(const char *action, const char *hint, int gently);
+
 #endif /* STATUS_H */
-- 
2.10.0.windows.1.325.ge6089c1


