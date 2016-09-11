Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.6 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E083A207DF
	for <e@80x24.org>; Sun, 11 Sep 2016 08:02:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754653AbcIKICz (ORCPT <rfc822;e@80x24.org>);
        Sun, 11 Sep 2016 04:02:55 -0400
Received: from mout.gmx.net ([212.227.17.20]:57399 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753808AbcIKICw (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 11 Sep 2016 04:02:52 -0400
Received: from virtualbox ([37.24.141.250]) by mail.gmx.com (mrgmx102) with
 ESMTPSA (Nemesis) id 0MFR2O-1bmLEq4BPQ-00EIpO; Sun, 11 Sep 2016 10:02:49
 +0200
Date:   Sun, 11 Sep 2016 10:02:47 +0200 (CEST)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 3/5] Make the require_clean_work_tree() function truly
 reusable
In-Reply-To: <cover.1473580914.git.johannes.schindelin@gmx.de>
Message-ID: <0e1ec34e45fea5bae60e65f316072cb2c89b024a.1473580914.git.johannes.schindelin@gmx.de>
References: <cover.1472137582.git.johannes.schindelin@gmx.de> <cover.1473580914.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:yRhUL0NwXJU2kJzYJZ8ZrhER4nIJqMImXxU8N24vAq/HVv5Tis0
 CBb0AtoPguK6vTwPOd/ke04gaqJ49ukXwgTG43r/+sZ+bRr0CYHXnMNT6GHQTB49M/21Cmh
 +YboWTNUpDiVGb+v2F83AZeXahoCeUU6TLmO75X+xVrIBCEN2xxLcaL4p1YglZk3aCSR5uq
 U9tehPBztI1qCwoYiNwKQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:A1pXVfmowHw=:ZKesfO5skb8JzJtLu8m8Jt
 W74H2Jh9s7Tb45fh2HJuDFoUxKh9pgcRIjkLajhFNCM8QywMb/vjucco+D34glwSSnHrYTTWD
 RB5oWwY8oTwtddI34j2K30R24Gvk/8t4v16ld4M4eKzkQl50rFz16wCNMkdc/6PLxLjQaiEBA
 +WP6JGA/JvJiIWq+eZbfDLlEIfCo67k6f/WncipgQYutn+Fb3QLX7lJqMIIj8xJGbxSM6hAVN
 WTp7TG8OeX/OpXoR2PPu13264QIMxOz6kmMUOpITauQQDVEx+emS8FUMp8zbYEJe2fA4NESd7
 1PDsMNdhpa2g6QrspGktIuJhegJJmdfkHiS2JAs0l0kdEAGvdgyMRryg13pgqyhLWWDN6EonW
 uj1G4DaBRRuexzMyU6nSCfLQBWbGy1g2f3cxWtC/ghgu5+Q6GjB2XRBy7uFVkKYK8L964/qxU
 E7IrcF1A0J3hISvyCbvK+yIRPT4IMmHkWlhDehd4Vx/cTpB2gn/yCq5sm3leNrJQSyJ6PdGE0
 1cOCQMbdA1XqXwFIVcLcDFQLXS9t4KqL6nel/J6G/ruvL3YoejMuJZUyz+MdKPO+T6k/s4boo
 0Zf6kA/wFcPf2sglYz+H91fsLwWbe7+lHdGCisGbfEdGYatKkH2uOJZc+S+YgpeDLWKskBdaa
 +sWFALEFdIyzduSvcO7exHu2koWy4/nmIPphY2VEkD3Tx2R0ZrCYRcP1MzGeaA/c1p9d/sJFN
 1iPnPiHm7jfLiQNdKWbvgJ6pYBZxMf3b4SjtYo0Zm6xN1QJNJ/R5lXaN6Rc0pWAobecLKnEjp
 2TQ4zOa
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

It is remarkable that libgit.a did not sport this function yet... Let's
move it into a more prominent (and into an actually reusable) spot:
wt-status.[ch].

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 builtin/pull.c | 76 +---------------------------------------------------------
 wt-status.c    | 75 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 wt-status.h    |  3 +++
 3 files changed, 79 insertions(+), 75 deletions(-)

diff --git a/builtin/pull.c b/builtin/pull.c
index a3ed054..14ef8b5 100644
--- a/builtin/pull.c
+++ b/builtin/pull.c
@@ -17,6 +17,7 @@
 #include "revision.h"
 #include "tempfile.h"
 #include "lockfile.h"
+#include "wt-status.h"
 
 enum rebase_type {
 	REBASE_INVALID = -1,
@@ -326,81 +327,6 @@ static int git_pull_config(const char *var, const char *value, void *cb)
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
index 539aac1..9ab9adc 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -16,6 +16,7 @@
 #include "strbuf.h"
 #include "utf8.h"
 #include "worktree.h"
+#include "lockfile.h"
 
 static const char cut_line[] =
 "------------------------ >8 ------------------------\n";
@@ -2209,3 +2210,77 @@ void wt_status_print(struct wt_status *s)
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
2.10.0.windows.1.10.g803177d


