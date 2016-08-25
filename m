Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3E9011F859
	for <e@80x24.org>; Thu, 25 Aug 2016 15:08:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934264AbcHYPIk (ORCPT <rfc822;e@80x24.org>);
        Thu, 25 Aug 2016 11:08:40 -0400
Received: from mout.gmx.net ([212.227.17.21]:61750 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933709AbcHYPIa (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 25 Aug 2016 11:08:30 -0400
Received: from virtualbox ([37.24.141.250]) by mail.gmx.com (mrgmx101) with
 ESMTPSA (Nemesis) id 0LsxuQ-1bA1ZS0jsY-012Vp2; Thu, 25 Aug 2016 17:06:56
 +0200
Date:   Thu, 25 Aug 2016 17:06:55 +0200 (CEST)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 3/6] Make the require_clean_work_tree() function truly
 reusable
In-Reply-To: <cover.1472137582.git.johannes.schindelin@gmx.de>
Message-ID: <414e6a5bf8472a3bfb99a8fed8971fb73d63d82b.1472137582.git.johannes.schindelin@gmx.de>
References: <cover.1472137582.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:hhztIhuxiP6PDyWeHhb1ilDTK8KgkOjC9GQE9ZR69sPfpu2u1Af
 naZX/vZMg+UAPWWiMjLzJ6PGkb+xMrV+1JXsuiOGxznPVvMBSEwB47Johxijv2VmKvZlW45
 wvsebfuozO8mWZOdtrfU4Gz01ZHO/855gq7hdd8RifabeXtnVaCTg/y6jn9QByr9WCDrTS5
 yQh1/Lty5CYW40ZXsTpDw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:E2zqEDsTGas=:mM5wuaz20SCokgr4HLhfVy
 Jerzy01pMkADAx8ejbtgcKWcURX3HMjRZne1Xp8hk2cb615gGZVuQUQkAdd6j6zpYjUQrZH41
 Jy0WDdS+w2D1u2fpKlELJUyvfnDlYFtD/M7a6y2zME8FsNBH0opJFEc6TymzzsscKkg8ArL4S
 yQ0cFJNvfnDHDDRVSY57iIZZD3He+rd8FYajEvHYKyTQbmYxCUnv/Ha4dUcORyq86RcVV9w5j
 Es3D7BRCfg8HFdSUYkyo57CfiUZuep3zGalZ94SPF0HoHxT2y8NTlkm314+CUhZzkfDQob5MS
 wEy/Ypl3vNRsvpbRnWpiC60azveKQrx6G92MNQ/xniTfrq5jhwQFwv0OzBr9ErRDPfnwvQB7w
 g4pnljBQihynOM+89lBJaOMGzYjQ9zuNGosiOIzBCqmHOE1P0q1mdG9AoBNGaO2LMRFxyWjy9
 r838CrN4xYW3cOHS2nocVqTnbcRzm33waSFjK6k9+Q8KhJB0KITYDyjL4BtYq9Sq0sKJxeeLJ
 A+btEp8/VtJPsog4+gyGSGvwzvEAjMZXVzytXCwAG7ETFrOC+zLZIhIZf0bBYJMCwnCUdTQcM
 ELkCIJEa5R+7jC3fHXNpBePZm5Q+/DpbXdOG+HujPvtJiHW3BBW+QhWQFFPW0vyeRiMqdf/uH
 +HblfAhY4s31Labs4wSncpaP6DKbA1r1OLdI1jyCej1YRL+3q4h/RkkWGinrMv8nkjNxo5Bsj
 sa7O+pvEAYRr8DsKm450yOnRxqkzoX+8B67UT89725tvN+JMEya2uoFiIrjTvACc2SiNmg+2p
 s2H1IO7
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

It is remarkable that libgit.a did not sport this function yet... Let's
move it into a more prominent (and into an actually reusable) spot:
wt-status.[ch].

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 builtin/pull.c | 75 +---------------------------------------------------------
 wt-status.c    | 74 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 wt-status.h    |  2 ++
 3 files changed, 77 insertions(+), 74 deletions(-)

diff --git a/builtin/pull.c b/builtin/pull.c
index 4d1f9c8..c35c6e8 100644
--- a/builtin/pull.c
+++ b/builtin/pull.c
@@ -17,6 +17,7 @@
 #include "revision.h"
 #include "tempfile.h"
 #include "lockfile.h"
+#include "wt-status.h"
 
 enum rebase_type {
 	REBASE_INVALID = -1,
@@ -326,80 +327,6 @@ static int git_pull_config(const char *var, const char *value, void *cb)
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
-		error(_("Cannot %s: You have unstaged changes."), action);
-		err = 1;
-	}
-
-	if (has_uncommitted_changes()) {
-		if (err)
-			error(_("Additionally, your index contains uncommitted changes."));
-		else
-			error(_("Cannot %s: Your index contains uncommitted changes."), action);
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
index 6225a2d..792dda9 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -16,6 +16,7 @@
 #include "strbuf.h"
 #include "utf8.h"
 #include "worktree.h"
+#include "lockfile.h"
 
 static const char cut_line[] =
 "------------------------ >8 ------------------------\n";
@@ -1757,3 +1758,76 @@ void wt_porcelain_print(struct wt_status *s)
 	s->no_gettext = 1;
 	wt_shortstatus_print(s);
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
+		error(_("Cannot %s: You have unstaged changes."), action);
+		err = 1;
+	}
+
+	if (has_uncommitted_changes()) {
+		if (err)
+			error(_("Additionally, your index contains uncommitted changes."));
+		else
+			error(_("Cannot %s: Your index contains uncommitted changes."), action);
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
index 2ca93f6..cc4e5a3 100644
--- a/wt-status.h
+++ b/wt-status.h
@@ -115,4 +115,6 @@ void status_printf_ln(struct wt_status *s, const char *color, const char *fmt, .
 __attribute__((format (printf, 3, 4)))
 void status_printf(struct wt_status *s, const char *color, const char *fmt, ...);
 
+int require_clean_work_tree(const char *action, const char *hint, int gently);
+
 #endif /* STATUS_H */
-- 
2.10.0.rc1.99.gcd66998


