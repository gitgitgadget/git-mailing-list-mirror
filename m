Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A336C77B7F
	for <git@archiver.kernel.org>; Tue, 16 May 2023 06:34:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230239AbjEPGet (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 16 May 2023 02:34:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230267AbjEPGeg (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 May 2023 02:34:36 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC0092105
        for <git@vger.kernel.org>; Mon, 15 May 2023 23:34:25 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id ffacd0b85a97d-306dbad5182so8997359f8f.1
        for <git@vger.kernel.org>; Mon, 15 May 2023 23:34:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684218864; x=1686810864;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=r3ZZXmcFM6CBF/iLcaTd0os289k46VvC8hhwlWohiJg=;
        b=COblwu+M8rosfjzuE/AQlXiL9FraJnqnX5oaiW/zP0Ln7NYAHy0AlgebmyieyoOCiC
         AuIwuW2AtW1fo/Hx81Vn2DaMo6MWFsx4bkVwu9cP3SDmpq9XWcUpLlGKZkhgqkEaK6kK
         nLmqIqJm5W+5DxgUHKVe27PCCtkyIbiSAKJyDU1WKrLBk3g/yT5qr2G7p8Ul5zoT3sr9
         5yl0BFL2xdOCtu/IeAY6I+UiS38rB5ZkmzIma7L+CoaMLqg4SJ3hU59r6/rbG1UIt0Wp
         mYR0GddH54i/GPG0c4zqCiN0xwcy7w2rVNiSxVPt7cPdbwBMSWgA6vrdnO0mTfyQuX9z
         owPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684218864; x=1686810864;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=r3ZZXmcFM6CBF/iLcaTd0os289k46VvC8hhwlWohiJg=;
        b=gpTMwYPDMzEq/3pqnNWAiujPt+nLVsyJyjpqeRYBsqddVzRMFdCdLd6o0GGO1BuZJf
         j6b3XX/YvFtDCB8YYpY5SQAK3WnGZAPmqX0Jo6FxjBxN9QKrTY47BJLUkTNQu/5LRC4I
         tZtVDiASrpxKJ7cakmlit4177uEoWZQe6820bILWfE4BW0/x+kViQy4F02FFypIQWFgA
         s0cIq2cqOR8it7Coowx2f2LcxmWEUdturZXjGkzn1T70VVnYaJv9/3cx9R+4JzLxUerg
         a4KNt4h6Sp/zCHAlSlRWmqgt9vp/d+9Zxk+zFXjVWM0kbDVjfqUQyGnt/BW0QpLLx8lV
         3/tg==
X-Gm-Message-State: AC+VfDxmQ4ehby3A2Ar/JyXNC5AV246atL/rLWrvW84dNtoOajLGewsh
        64CcE9xYnuYn/rA+tnmjfHzfnCU/wOg=
X-Google-Smtp-Source: ACHHUZ4QXqdIb3NJzftdRuUYPXBK2Dy38Wm1GJhz+sPTOpum8xLYwH72SAWWl0ykdCUKZI6z2IkLGA==
X-Received: by 2002:adf:da48:0:b0:307:9a49:da8a with SMTP id r8-20020adfda48000000b003079a49da8amr18237868wrl.26.1684218863803;
        Mon, 15 May 2023 23:34:23 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id q6-20020adfcd86000000b00307a83ea722sm1403430wrj.58.2023.05.15.23.34.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 May 2023 23:34:23 -0700 (PDT)
Message-Id: <f95d5aebd4acffe1f20aab31be6856cf0e977994.1684218851.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1525.v3.git.1684218848.gitgitgadget@gmail.com>
References: <pull.1525.v2.git.1683875068.gitgitgadget@gmail.com>
        <pull.1525.v3.git.1684218848.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 16 May 2023 06:33:47 +0000
Subject: [PATCH v3 07/28] read-cache: move shared add/checkout/commit code
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Elijah Newren <newren@gmail.com>,
        Calvin Wan <calvinwan@google.com>, Jeff King <peff@peff.net>,
        Glen Choo <chooglen@google.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

The function add_files_to_cache(), plus associated helper functions,
were defined in builtin/add.c, but also shared with builtin/checkout.c
and builtin/commit.c.  Move these shared functions to read-cache.c.

Diff best viewed with `--color-moved`.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 builtin/add.c | 100 -------------------------------------------------
 read-cache.c  | 102 ++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 102 insertions(+), 100 deletions(-)

diff --git a/builtin/add.c b/builtin/add.c
index a526eff734e..36ddbb159bf 100644
--- a/builtin/add.c
+++ b/builtin/add.c
@@ -36,13 +36,6 @@ static int pathspec_file_nul;
 static int include_sparse;
 static const char *pathspec_from_file;
 
-struct update_callback_data {
-	struct index_state *index;
-	int include_sparse;
-	int flags;
-	int add_errors;
-};
-
 static int chmod_pathspec(struct pathspec *pathspec, char flip, int show_only)
 {
 	int i, ret = 0;
@@ -71,99 +64,6 @@ static int chmod_pathspec(struct pathspec *pathspec, char flip, int show_only)
 	return ret;
 }
 
-static int fix_unmerged_status(struct diff_filepair *p,
-			       struct update_callback_data *data)
-{
-	if (p->status != DIFF_STATUS_UNMERGED)
-		return p->status;
-	if (!(data->flags & ADD_CACHE_IGNORE_REMOVAL) && !p->two->mode)
-		/*
-		 * This is not an explicit add request, and the
-		 * path is missing from the working tree (deleted)
-		 */
-		return DIFF_STATUS_DELETED;
-	else
-		/*
-		 * Either an explicit add request, or path exists
-		 * in the working tree.  An attempt to explicitly
-		 * add a path that does not exist in the working tree
-		 * will be caught as an error by the caller immediately.
-		 */
-		return DIFF_STATUS_MODIFIED;
-}
-
-static void update_callback(struct diff_queue_struct *q,
-			    struct diff_options *opt UNUSED, void *cbdata)
-{
-	int i;
-	struct update_callback_data *data = cbdata;
-
-	for (i = 0; i < q->nr; i++) {
-		struct diff_filepair *p = q->queue[i];
-		const char *path = p->one->path;
-
-		if (!data->include_sparse &&
-		    !path_in_sparse_checkout(path, data->index))
-			continue;
-
-		switch (fix_unmerged_status(p, data)) {
-		default:
-			die(_("unexpected diff status %c"), p->status);
-		case DIFF_STATUS_MODIFIED:
-		case DIFF_STATUS_TYPE_CHANGED:
-			if (add_file_to_index(data->index, path, data->flags)) {
-				if (!(data->flags & ADD_CACHE_IGNORE_ERRORS))
-					die(_("updating files failed"));
-				data->add_errors++;
-			}
-			break;
-		case DIFF_STATUS_DELETED:
-			if (data->flags & ADD_CACHE_IGNORE_REMOVAL)
-				break;
-			if (!(data->flags & ADD_CACHE_PRETEND))
-				remove_file_from_index(data->index, path);
-			if (data->flags & (ADD_CACHE_PRETEND|ADD_CACHE_VERBOSE))
-				printf(_("remove '%s'\n"), path);
-			break;
-		}
-	}
-}
-
-int add_files_to_cache(struct repository *repo, const char *prefix,
-		       const struct pathspec *pathspec, int include_sparse,
-		       int flags)
-{
-	struct update_callback_data data;
-	struct rev_info rev;
-
-	memset(&data, 0, sizeof(data));
-	data.index = repo->index;
-	data.include_sparse = include_sparse;
-	data.flags = flags;
-
-	repo_init_revisions(repo, &rev, prefix);
-	setup_revisions(0, NULL, &rev, NULL);
-	if (pathspec)
-		copy_pathspec(&rev.prune_data, pathspec);
-	rev.diffopt.output_format = DIFF_FORMAT_CALLBACK;
-	rev.diffopt.format_callback = update_callback;
-	rev.diffopt.format_callback_data = &data;
-	rev.diffopt.flags.override_submodule_config = 1;
-	rev.max_count = 0; /* do not compare unmerged paths with stage #2 */
-
-	/*
-	 * Use an ODB transaction to optimize adding multiple objects.
-	 * This function is invoked from commands other than 'add', which
-	 * may not have their own transaction active.
-	 */
-	begin_odb_transaction();
-	run_diff_files(&rev, DIFF_RACY_IS_MODIFIED);
-	end_odb_transaction();
-
-	release_revisions(&rev);
-	return !!data.add_errors;
-}
-
 static int renormalize_tracked_files(const struct pathspec *pathspec, int flags)
 {
 	int i, retval = 0;
diff --git a/read-cache.c b/read-cache.c
index c0df4586c9b..bfbd531ea60 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -5,6 +5,7 @@
  */
 #include "cache.h"
 #include "alloc.h"
+#include "bulk-checkin.h"
 #include "config.h"
 #include "date.h"
 #include "diff.h"
@@ -26,6 +27,7 @@
 #include "mem-pool.h"
 #include "object-name.h"
 #include "resolve-undo.h"
+#include "revision.h"
 #include "run-command.h"
 #include "strbuf.h"
 #include "trace2.h"
@@ -3943,3 +3945,103 @@ void overlay_tree_on_index(struct index_state *istate,
 		}
 	}
 }
+
+struct update_callback_data {
+	struct index_state *index;
+	int include_sparse;
+	int flags;
+	int add_errors;
+};
+
+static int fix_unmerged_status(struct diff_filepair *p,
+			       struct update_callback_data *data)
+{
+	if (p->status != DIFF_STATUS_UNMERGED)
+		return p->status;
+	if (!(data->flags & ADD_CACHE_IGNORE_REMOVAL) && !p->two->mode)
+		/*
+		 * This is not an explicit add request, and the
+		 * path is missing from the working tree (deleted)
+		 */
+		return DIFF_STATUS_DELETED;
+	else
+		/*
+		 * Either an explicit add request, or path exists
+		 * in the working tree.  An attempt to explicitly
+		 * add a path that does not exist in the working tree
+		 * will be caught as an error by the caller immediately.
+		 */
+		return DIFF_STATUS_MODIFIED;
+}
+
+static void update_callback(struct diff_queue_struct *q,
+			    struct diff_options *opt UNUSED, void *cbdata)
+{
+	int i;
+	struct update_callback_data *data = cbdata;
+
+	for (i = 0; i < q->nr; i++) {
+		struct diff_filepair *p = q->queue[i];
+		const char *path = p->one->path;
+
+		if (!data->include_sparse &&
+		    !path_in_sparse_checkout(path, data->index))
+			continue;
+
+		switch (fix_unmerged_status(p, data)) {
+		default:
+			die(_("unexpected diff status %c"), p->status);
+		case DIFF_STATUS_MODIFIED:
+		case DIFF_STATUS_TYPE_CHANGED:
+			if (add_file_to_index(data->index, path, data->flags)) {
+				if (!(data->flags & ADD_CACHE_IGNORE_ERRORS))
+					die(_("updating files failed"));
+				data->add_errors++;
+			}
+			break;
+		case DIFF_STATUS_DELETED:
+			if (data->flags & ADD_CACHE_IGNORE_REMOVAL)
+				break;
+			if (!(data->flags & ADD_CACHE_PRETEND))
+				remove_file_from_index(data->index, path);
+			if (data->flags & (ADD_CACHE_PRETEND|ADD_CACHE_VERBOSE))
+				printf(_("remove '%s'\n"), path);
+			break;
+		}
+	}
+}
+
+int add_files_to_cache(struct repository *repo, const char *prefix,
+		       const struct pathspec *pathspec, int include_sparse,
+		       int flags)
+{
+	struct update_callback_data data;
+	struct rev_info rev;
+
+	memset(&data, 0, sizeof(data));
+	data.index = repo->index;
+	data.include_sparse = include_sparse;
+	data.flags = flags;
+
+	repo_init_revisions(repo, &rev, prefix);
+	setup_revisions(0, NULL, &rev, NULL);
+	if (pathspec)
+		copy_pathspec(&rev.prune_data, pathspec);
+	rev.diffopt.output_format = DIFF_FORMAT_CALLBACK;
+	rev.diffopt.format_callback = update_callback;
+	rev.diffopt.format_callback_data = &data;
+	rev.diffopt.flags.override_submodule_config = 1;
+	rev.max_count = 0; /* do not compare unmerged paths with stage #2 */
+
+	/*
+	 * Use an ODB transaction to optimize adding multiple objects.
+	 * This function is invoked from commands other than 'add', which
+	 * may not have their own transaction active.
+	 */
+	begin_odb_transaction();
+	run_diff_files(&rev, DIFF_RACY_IS_MODIFIED);
+	end_odb_transaction();
+
+	release_revisions(&rev);
+	return !!data.add_errors;
+}
-- 
gitgitgadget

