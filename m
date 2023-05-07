Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B723AC77B7C
	for <git@archiver.kernel.org>; Sun,  7 May 2023 03:46:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230428AbjEGDqR (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 6 May 2023 23:46:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230283AbjEGDqC (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 6 May 2023 23:46:02 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87F869014
        for <git@vger.kernel.org>; Sat,  6 May 2023 20:46:00 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id 5b1f17b1804b1-3f315735514so135931435e9.1
        for <git@vger.kernel.org>; Sat, 06 May 2023 20:46:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683431159; x=1686023159;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=r3ZZXmcFM6CBF/iLcaTd0os289k46VvC8hhwlWohiJg=;
        b=oYTBQ2NVoSqp8nxIv1Mqoz72U3x2Xg3z7YYnUkHzvvXAJDK7ybp8HF4TzS4/kTUViQ
         vAxBWFhWeh7MlKgKT1UDVnL3tvvXOSSvXfLFPIZQ+owGjWX7aa7a+hsYy+DtFpP9mHAh
         AzujRyc7yozaCcO/HrcSj/7nSFQdU+PHzMkRkaUwwJFzgwtw6cWO8TUhGarSZS4laV3x
         LE6QinR0kA4XJkWoEO0fwxQ1t1YsphnEf59i6A5vVfVLVXn+egUkjtJYq9HtHOxWFKDE
         wmfB2hPBdL5tUZD7cVa8di+wM6ajVWE4nBjkK2jsd+paOXMX1pRbiGpyqHFfp8y/XMeA
         SYFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683431159; x=1686023159;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=r3ZZXmcFM6CBF/iLcaTd0os289k46VvC8hhwlWohiJg=;
        b=ewZnVCKvl8KOuphSNYMI0CyRp4EtsD6iTH4sIio1hrz535uV2mXo2wo2L67ZAyWDaK
         57RWBGipd86Ddu+3aiLQ8rbo1pEQb/ajjUChusbUzvdTqccrMAHTgD8OpaYdGVX8gvni
         13MsuKD/WsL25SBkdngbKOAa0s/BbaDKxGc1JmukK85afhr5X8Wduk1A4F8XOnpUZIHf
         LqNQVOzYz4vzhaQMNUAhgCreODeUXvktol3vHBXABCIWj1m2nMsrpATIMaAhqumi6RIb
         19kgvqV8d4rN1hQ4DtbGrMk6UZ+UuuWli7qwEXB/vJUKWb+zKDbkbrHIHXKzj9DuCeR2
         svDw==
X-Gm-Message-State: AC+VfDyCEYNd8uG16IKtxg2wU0HYh1vwgwTYyPuRnZLq272hf12NA3Kh
        w0GFpHCORE1kc4Z1KWpW2hgBtLnmvUc=
X-Google-Smtp-Source: ACHHUZ7uBQkn9F+1ujuT/yDsYwBB4r/LA6RAIHkv0SHLbYkdR2XtWMc4S/CmDQwyFb1dOwMtl5Ej/w==
X-Received: by 2002:a7b:c7ca:0:b0:3ee:1084:aa79 with SMTP id z10-20020a7bc7ca000000b003ee1084aa79mr3714185wmk.20.1683431158676;
        Sat, 06 May 2023 20:45:58 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id l2-20020a1c7902000000b003f195d540d9sm12418541wme.14.2023.05.06.20.45.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 May 2023 20:45:58 -0700 (PDT)
Message-Id: <0205f716a5ab322c8bede9ba383bdce3d5f014d1.1683431151.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1525.git.1683431149.gitgitgadget@gmail.com>
References: <pull.1525.git.1683431149.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sun, 07 May 2023 03:45:31 +0000
Subject: [PATCH 06/24] read-cache: move shared add/checkout/commit code
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Elijah Newren <newren@gmail.com>, Elijah Newren <newren@gmail.com>
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

