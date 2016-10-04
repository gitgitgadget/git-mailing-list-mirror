Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.2 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1B1F020986
	for <e@80x24.org>; Tue,  4 Oct 2016 13:05:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753899AbcJDNFb (ORCPT <rfc822;e@80x24.org>);
        Tue, 4 Oct 2016 09:05:31 -0400
Received: from mout.gmx.net ([212.227.17.22]:56254 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753807AbcJDNFa (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 Oct 2016 09:05:30 -0400
Received: from virtualbox ([37.24.142.40]) by mail.gmx.com (mrgmx102) with
 ESMTPSA (Nemesis) id 0LmeGF-1bHFZt1J9H-00aDDD; Tue, 04 Oct 2016 15:05:26
 +0200
Date:   Tue, 4 Oct 2016 15:05:25 +0200 (CEST)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v3 3/6] Make the require_clean_work_tree() function
 reusable
In-Reply-To: <cover.1475586229.git.johannes.schindelin@gmx.de>
Message-ID: <3b4f46b761589d84b7713c869d00d3231ab346fd.1475586229.git.johannes.schindelin@gmx.de>
References: <cover.1473580914.git.johannes.schindelin@gmx.de> <cover.1475586229.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:dVh4LyQeteU0/eUKipQxTP/0fugAEVHZ/GVvY5QrRgO5d8iGLM0
 5xwWBE0ZLlkENxri/+CdJGodMlyky8LX46qvukCpAIIGiNfETsVy68DQEjmwm+LGJxDU/GC
 S5QMns8EwEiP9gUFf3r0X4Yz5y34HA2KXn8m+11ezUzVi4CgC2Tr2FEzF/TxSr8xyX8DtYl
 TtDsKz/uHM6wEuAa395Dw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:FQnTJPS9oPQ=:vWsR9B4n/KSRic0LFOkk+X
 MjN+KnmXfJ/BbTCz7G3ihU83gjIRKh3K7qiinwjlzJMDGFGEtR5FZfTg/ieG9bLb6BdHKxOkl
 0pi4ai0J+qx+BLCu6sk1hY1EO7VxizhFjSBy14/36xLQHq4ltOkBvgfQgTkEu2ltF9vZCPQri
 n0+YDbDxn54iYXJ1NX8LZ6t3F+jkNN7JuUu0zA2pxcUxAK1Mz3Ob2+T/w7PnwyXXPntElHoPr
 wnJaXb56+QBbyVvGHkOqDVWAtG6o8h3KAI8bdwxX9wXTVsAp3AgCqVzoratRtjdz1wv32PUOd
 u4ibxA5uBfha2IG/OMD+R52ziCinR8S8B2iEnWVDhce6htFMZ64HSwH7seugz/NOnT0I6l9mI
 5Egi90gJAxMFusSoTZ3GuWyu1vr3pDF1IYPJFP4H5OujnfCOZCyFR9j2AKOCTt7FTHPC/4UPQ
 6MlWc7e17UsYr0R9gGsfOVhNSgo1QTF/SfwgkI4xndKojvE641K/SMpxdvUnW/4n5Ggb6Qrjn
 x3j0x4wP+7rJ5nxsYBkP3u7TknXmCZBO1wXH56EdzcJrBCLxRaT/65BUGvV9+itRkZ3PFK9L+
 3eG9F66MCx86NEXcruZB8ff/LzonBFNLZCa9KWiiFikdoG8VFHt8sSa6RVl+fTuh+YES3+dX7
 kRuEA/qhJjGc8WW/f6+HESMIZj6EZze618DxVMC/rIpKmcDjK4Sz4X9L3yKew+igCRueIfBTc
 GyN/P1vu4MOI3DfJ/4qgv20KCkmkb6ZI0c2zNSTFtazeE47GRCJDxKR4rtaA2349O2RPVCREC
 eDUhz3M
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

It is remarkable that libgit.a did not sport this function yet... Let's
move it into a more prominent (and into an actually reusable) spot:
wt-status.[ch].

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 builtin/pull.c | 77 +---------------------------------------------------------
 wt-status.c    | 76 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 wt-status.h    |  3 +++
 3 files changed, 80 insertions(+), 76 deletions(-)

diff --git a/builtin/pull.c b/builtin/pull.c
index d1e093c..14ef8b5 100644
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
-			exit(err);
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
index 9628c1d..b92c54d 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -16,6 +16,7 @@
 #include "strbuf.h"
 #include "utf8.h"
 #include "worktree.h"
+#include "lockfile.h"
 
 static const char cut_line[] =
 "------------------------ >8 ------------------------\n";
@@ -2209,3 +2210,78 @@ void wt_status_print(struct wt_status *s)
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
+			exit(err);
+	}
+
+	return err;
+}
diff --git a/wt-status.h b/wt-status.h
index e401837..03ecf53 100644
--- a/wt-status.h
+++ b/wt-status.h
@@ -128,4 +128,7 @@ void status_printf_ln(struct wt_status *s, const char *color, const char *fmt, .
 __attribute__((format (printf, 3, 4)))
 void status_printf(struct wt_status *s, const char *color, const char *fmt, ...);
 
+/* The following function expect that the caller took care of reading the index. */
+int require_clean_work_tree(const char *action, const char *hint, int gently);
+
 #endif /* STATUS_H */
-- 
2.10.0.windows.1.325.ge6089c1


