Return-Path: <SRS0=NBeB=5G=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67185C4332B
	for <git@archiver.kernel.org>; Sat, 21 Mar 2020 18:00:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3447C20663
	for <git@archiver.kernel.org>; Sat, 21 Mar 2020 18:00:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YimGAotP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727959AbgCUSA0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 21 Mar 2020 14:00:26 -0400
Received: from mail-ed1-f54.google.com ([209.85.208.54]:41655 "EHLO
        mail-ed1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727915AbgCUSAX (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 21 Mar 2020 14:00:23 -0400
Received: by mail-ed1-f54.google.com with SMTP id v6so11122739edw.8
        for <git@vger.kernel.org>; Sat, 21 Mar 2020 11:00:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=mtzYCeU2Mt3TAgbEj/oCZWxq8i4BGOZaBdSZOkj32kQ=;
        b=YimGAotPGi27/iCSdK9ZWPTUovEGNq/Wt3bHyqXDjc2JbwYsCIZae0XHR5xxzSyWVm
         JF8qJBw1daYRU2NoD+qMpyfsWqlofqASDtSt0HHXGtmWR0nSyes1aooWI91NrMGi7akt
         xzEeL//Qt9Cz+K0JmB/MJjGJqIcNyUfbvPttnt2kU8tjGO8VTw+My4OuaxtqQ/b1OBmh
         VZMuF0/oTZOwGMpoWX0HPOuXI0rLD/xra02DmQGb1HVQHtdSFWVcUIobkPhI7pUgSWiu
         L1f/vHAvTRNi6uFyJ7o+5dk88gFpeOZB7lEYznQlEeuhZCeFI9dYzQn2iXuhTgBDAUhR
         JkYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=mtzYCeU2Mt3TAgbEj/oCZWxq8i4BGOZaBdSZOkj32kQ=;
        b=cipqu5lmC3RjvDytO3gFnn+7yiW0HVAjGZfR+T4G4rJceHkwzDT5tzzizAeRPXdNLq
         L1F0QoWssP7trp1vprMxmlzNIIExc57YYhoM5xfU7aG4M+q4L1WiK/58V/a9dImJAupB
         Aj6hD3wxskSo2F3gMDV0ohKt4PLkjpZYzpb0uuFx7uEyC3ewIUY7JjuVHTMW9g0fyGCo
         cjNmb1i5md0yM5BDf9l0tUbJ/ynurm7NvakfsG4266z9RwElRq7glIHfgKt0lAcUal7Y
         v9f9MUYYcbw2Mve5yLGHoU6XNwNz0n2ntQWzzNA9sOpx3S5uGmDxwxe0ty2bjXIIBi2/
         UixA==
X-Gm-Message-State: ANhLgQ2fV+gpXP+JKKW3EAMRtJ+kLC0Bg1r+lNwQJzu7p/KZLsYrezeW
        fPflNZ4jsZAoRCZD6mdE2p4BpqV4
X-Google-Smtp-Source: ADFU+vs4CSrjrrhVv90NCL4sHcKJMvh3RNOo7Xl/smkw4H/uWz2h/fjUvApF/08/T0jiIZLyQIMz+g==
X-Received: by 2002:a50:cd5a:: with SMTP id d26mr14416590edj.65.1584813620742;
        Sat, 21 Mar 2020 11:00:20 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id g19sm600398ejr.65.2020.03.21.11.00.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Mar 2020 11:00:20 -0700 (PDT)
Message-Id: <57679c8e292ceb58cea2b5b7d893d5f47e1e2de0.1584813609.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.726.v2.git.git.1584813609.gitgitgadget@gmail.com>
References: <pull.726.git.git.1584169893.gitgitgadget@gmail.com>
        <pull.726.v2.git.git.1584813609.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sat, 21 Mar 2020 18:00:05 +0000
Subject: [PATCH v2 14/18] unpack-trees: split display_error_msgs() into two
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Derrick Stolee <dstolee@microsoft.com>,
        Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

display_error_msgs() is never called to show messages of both ERROR_*
and WARNING_* types at the same time; it is instead called multiple
times, separately for each type.  Since we want to display these types
differently, make two slightly different versions of this function.

A subsequent commit will further modify unpack_trees() and how it calls
the new display_warning_msgs().

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 t/t1091-sparse-checkout-builtin.sh |  6 ++--
 unpack-trees.c                     | 50 +++++++++++++++++++++++++-----
 unpack-trees.h                     |  8 +++--
 3 files changed, 50 insertions(+), 14 deletions(-)

diff --git a/t/t1091-sparse-checkout-builtin.sh b/t/t1091-sparse-checkout-builtin.sh
index 93c650ac038..0d93d3983e0 100755
--- a/t/t1091-sparse-checkout-builtin.sh
+++ b/t/t1091-sparse-checkout-builtin.sh
@@ -328,13 +328,13 @@ test_expect_success 'sparse-checkout (init|set|disable) warns with dirty status'
 	echo dirty >dirty/folder1/a &&
 
 	git -C dirty sparse-checkout init 2>err &&
-	test_i18ngrep "error.*Cannot update sparse checkout" err &&
+	test_i18ngrep "warning.*Cannot update sparse checkout" err &&
 
 	git -C dirty sparse-checkout set /folder2/* /deep/deeper1/* &&
-	test_i18ngrep "error.*Cannot update sparse checkout" err &&
+	test_i18ngrep "warning.*Cannot update sparse checkout" err &&
 
 	git -C dirty sparse-checkout disable &&
-	test_i18ngrep "error.*Cannot update sparse checkout" err &&
+	test_i18ngrep "warning.*Cannot update sparse checkout" err &&
 
 	git -C dirty reset --hard &&
 	git -C dirty sparse-checkout init &&
diff --git a/unpack-trees.c b/unpack-trees.c
index 0554842580b..9ee04992ac6 100644
--- a/unpack-trees.c
+++ b/unpack-trees.c
@@ -24,7 +24,7 @@
  * situation better.  See how "git checkout" and "git merge" replaces
  * them using setup_unpack_trees_porcelain(), for example.
  */
-static const char *unpack_plumbing_errors[NB_UNPACK_TREES_ERROR_TYPES] = {
+static const char *unpack_plumbing_errors[NB_UNPACK_TREES_WARNING_TYPES] = {
 	/* ERROR_WOULD_OVERWRITE */
 	"Entry '%s' would be overwritten by merge. Cannot merge.",
 
@@ -46,6 +46,9 @@ static const char *unpack_plumbing_errors[NB_UNPACK_TREES_ERROR_TYPES] = {
 	/* ERROR_WOULD_LOSE_SUBMODULE */
 	"Submodule '%s' cannot checkout new HEAD.",
 
+	/* NB_UNPACK_TREES_ERROR_TYPES; just a meta value */
+	"",
+
 	/* WARNING_SPARSE_NOT_UPTODATE_FILE */
 	"Entry '%s' not uptodate. Cannot update sparse checkout.",
 
@@ -222,7 +225,7 @@ static int add_rejected_path(struct unpack_trees_options *o,
 
 	/*
 	 * Otherwise, insert in a list for future display by
-	 * display_error_msgs()
+	 * display_(error|warning)_msgs()
 	 */
 	string_list_append(&o->unpack_rejects[e], path);
 	return -1;
@@ -233,13 +236,16 @@ static int add_rejected_path(struct unpack_trees_options *o,
  */
 static void display_error_msgs(struct unpack_trees_options *o)
 {
-	int e, i;
-	int something_displayed = 0;
+	int e;
+	unsigned error_displayed = 0;
 	for (e = 0; e < NB_UNPACK_TREES_ERROR_TYPES; e++) {
 		struct string_list *rejects = &o->unpack_rejects[e];
+
 		if (rejects->nr > 0) {
+			int i;
 			struct strbuf path = STRBUF_INIT;
-			something_displayed = 1;
+
+			error_displayed = 1;
 			for (i = 0; i < rejects->nr; i++)
 				strbuf_addf(&path, "\t%s\n", rejects->items[i].string);
 			error(ERRORMSG(o, e), super_prefixed(path.buf));
@@ -247,10 +253,36 @@ static void display_error_msgs(struct unpack_trees_options *o)
 		}
 		string_list_clear(rejects, 0);
 	}
-	if (something_displayed)
+	if (error_displayed)
 		fprintf(stderr, _("Aborting\n"));
 }
 
+/*
+ * display all the warning messages stored in a nice way
+ */
+static void display_warning_msgs(struct unpack_trees_options *o)
+{
+	int e;
+	unsigned warning_displayed = 0;
+	for (e = NB_UNPACK_TREES_ERROR_TYPES+1;
+	     e < NB_UNPACK_TREES_WARNING_TYPES; e++) {
+		struct string_list *rejects = &o->unpack_rejects[e];
+
+		if (rejects->nr > 0) {
+			int i;
+			struct strbuf path = STRBUF_INIT;
+
+			warning_displayed = 1;
+			for (i = 0; i < rejects->nr; i++)
+				strbuf_addf(&path, "\t%s\n", rejects->items[i].string);
+			warning(ERRORMSG(o, e), super_prefixed(path.buf));
+			strbuf_release(&path);
+		}
+		string_list_clear(rejects, 0);
+	}
+	if (warning_displayed)
+		fprintf(stderr, _("After fixing the above paths, you may want to run `git sparse-checkout reapply`.\n"));
+}
 static int check_submodule_move_head(const struct cache_entry *ce,
 				     const char *old_id,
 				     const char *new_id,
@@ -1705,8 +1737,10 @@ int unpack_trees(unsigned len, struct tree_desc *t, struct unpack_trees_options
 	return ret;
 
 return_failed:
-	if (o->show_all_errors)
+	if (o->show_all_errors) {
 		display_error_msgs(o);
+		display_warning_msgs(o);
+	}
 	mark_all_ce_unused(o->src_index);
 	ret = unpack_failed(o, NULL);
 	if (o->exiting_early)
@@ -1784,7 +1818,7 @@ enum update_sparsity_result update_sparsity(struct unpack_trees_options *o)
 		ret = UPDATE_SPARSITY_WORKTREE_UPDATE_FAILURES;
 
 done:
-	display_error_msgs(o);
+	display_warning_msgs(o);
 	o->show_all_errors = old_show_all_errors;
 	if (free_pattern_list)
 		clear_pattern_list(&pl);
diff --git a/unpack-trees.h b/unpack-trees.h
index 3c6452fe9e5..d91c65ae453 100644
--- a/unpack-trees.h
+++ b/unpack-trees.h
@@ -24,10 +24,12 @@ enum unpack_trees_error_types {
 	ERROR_BIND_OVERLAP,
 	ERROR_WOULD_LOSE_SUBMODULE,
 
+	NB_UNPACK_TREES_ERROR_TYPES,
+
 	WARNING_SPARSE_NOT_UPTODATE_FILE,
 	WARNING_SPARSE_ORPHANED_NOT_OVERWRITTEN,
 
-	NB_UNPACK_TREES_ERROR_TYPES,
+	NB_UNPACK_TREES_WARNING_TYPES,
 };
 
 enum update_sparsity_result {
@@ -73,13 +75,13 @@ struct unpack_trees_options {
 	struct dir_struct *dir;
 	struct pathspec *pathspec;
 	merge_fn_t fn;
-	const char *msgs[NB_UNPACK_TREES_ERROR_TYPES];
+	const char *msgs[NB_UNPACK_TREES_WARNING_TYPES];
 	struct argv_array msgs_to_free;
 	/*
 	 * Store error messages in an array, each case
 	 * corresponding to a error message type
 	 */
-	struct string_list unpack_rejects[NB_UNPACK_TREES_ERROR_TYPES];
+	struct string_list unpack_rejects[NB_UNPACK_TREES_WARNING_TYPES];
 
 	int head_idx;
 	int merge_size;
-- 
gitgitgadget

