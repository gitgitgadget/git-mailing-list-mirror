Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A6B7C77B7D
	for <git@archiver.kernel.org>; Sun,  7 May 2023 03:46:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230402AbjEGDqK (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 6 May 2023 23:46:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230203AbjEGDqB (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 6 May 2023 23:46:01 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA16035AE
        for <git@vger.kernel.org>; Sat,  6 May 2023 20:45:59 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id 5b1f17b1804b1-3f315735514so135931335e9.1
        for <git@vger.kernel.org>; Sat, 06 May 2023 20:45:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683431158; x=1686023158;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cvdDaqrvX/P/PDr79doxRz1qredxSFylEeu3GU+KG6Y=;
        b=EHAIeDaSAn+W1N74qzkcA1dqEcbwkulfkWg/ZrFjtr5gFAqxO0/9b+3eT9r0bgXj1z
         BdBTY+ioYpiqSmgi+DXec0BJP9fBQQPwKMO6ujie6N1ykabRk38gwm577hBfqQ16Pzt2
         Me1mlMqcD9FvFrcQWzwqbr8GBL+BCqda71TIRmM8nCeh1ndKqQQH52svJ+JMhwfX+4WC
         U4eAGtQ9v31SVHougJOQ3ntkQjMWVRB4NqLJKnAExr80dtZGTP0/TCV2DCRo2b0XV9dh
         ZjYNj2MLaoiqk4HaComZ+w3PmjZf4xj1lexMlM88faGFMlQmVgNV1gdxBGx/gBiMRuzo
         RIfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683431158; x=1686023158;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cvdDaqrvX/P/PDr79doxRz1qredxSFylEeu3GU+KG6Y=;
        b=idKIGO5xUnMX0E4shRT8/9/rXg+CbC4JKLDHMnU+jisffFXSzZF3CvE6kK1e6iWeQr
         orQAyK6KwfhyG1fCoOTjLe+9qHsagwD/45lM/TxYe9HtacFWWV3q/YvnkXOR6LUvXVMC
         uLkxAs512ke5JuxBNDVO/VvMmk9lYoNYXQqrKwJe0xvl47ef4GgjYJfvPhPMM3Krjp4M
         HGvbFqFuvuymmsRdC6eVqkkqptmRMRAuPpNf90J4YlgiYQywQr46QStDisllrycotAT2
         Gt331C9T8pyX3A8wVZNFztK2EEkNFeXa3snTdw13yGxmvgEtDUUYLD2tFadSipOIhkm/
         1i1Q==
X-Gm-Message-State: AC+VfDxWfX6yruUp2FFbuEOhJz4LRD7Dcq9bHPtmOTIYjHUgAdZcp0wV
        XD1W8K6qyW5mD0f08ieYX5zNvG7Al+A=
X-Google-Smtp-Source: ACHHUZ5W0gsJgQ3Y3n9zEcSkctjJvTd+L3WsUcq2yHnwyr3kyPattihfr1jyxOuuoqoD0nLFA2SI5w==
X-Received: by 2002:adf:f189:0:b0:306:45ef:9935 with SMTP id h9-20020adff189000000b0030645ef9935mr8189055wro.13.1683431157910;
        Sat, 06 May 2023 20:45:57 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id p4-20020a1c7404000000b003f1739a0116sm12483966wmc.33.2023.05.06.20.45.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 May 2023 20:45:57 -0700 (PDT)
Message-Id: <30989571ac34d9bd7e8402e149ac647939bfba33.1683431151.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1525.git.1683431149.gitgitgadget@gmail.com>
References: <pull.1525.git.1683431149.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sun, 07 May 2023 03:45:30 +0000
Subject: [PATCH 05/24] add: modify add_files_to_cache() to avoid globals
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

The function add_files_to_cache() is used by all three of builtin/{add,
checkout, commit}.c.  That suggests this is common library code, and
should be moved somewhere else, like read-cache.c.  However, the
function and its helpers made use of two global variables that made
straight code movement difficult:
  * the_index
  * include_sparse
The latter was perhaps more problematic since it was only accessible in
builtin/add.c but was still affecting builtin/checkout.c and
builtin/commit.c without this fact being very clear from the code.  I'm
not sure if the other two callers would want to add a `--sparse` flag
similar to add.c to get non-default behavior, but exposing this
dependence will help if we ever decide we do want to add such a flag.

Modify add_files_to_cache() and its helpers to accept the necessary
arguments instead of relying on globals.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 builtin/add.c      | 22 +++++++++++++++-------
 builtin/checkout.c |  2 +-
 builtin/commit.c   |  3 ++-
 cache.h            |  4 +++-
 4 files changed, 21 insertions(+), 10 deletions(-)

diff --git a/builtin/add.c b/builtin/add.c
index 76cc026a68a..a526eff734e 100644
--- a/builtin/add.c
+++ b/builtin/add.c
@@ -37,6 +37,8 @@ static int include_sparse;
 static const char *pathspec_from_file;
 
 struct update_callback_data {
+	struct index_state *index;
+	int include_sparse;
 	int flags;
 	int add_errors;
 };
@@ -100,7 +102,8 @@ static void update_callback(struct diff_queue_struct *q,
 		struct diff_filepair *p = q->queue[i];
 		const char *path = p->one->path;
 
-		if (!include_sparse && !path_in_sparse_checkout(path, &the_index))
+		if (!data->include_sparse &&
+		    !path_in_sparse_checkout(path, data->index))
 			continue;
 
 		switch (fix_unmerged_status(p, data)) {
@@ -108,7 +111,7 @@ static void update_callback(struct diff_queue_struct *q,
 			die(_("unexpected diff status %c"), p->status);
 		case DIFF_STATUS_MODIFIED:
 		case DIFF_STATUS_TYPE_CHANGED:
-			if (add_file_to_index(&the_index, path,	data->flags)) {
+			if (add_file_to_index(data->index, path, data->flags)) {
 				if (!(data->flags & ADD_CACHE_IGNORE_ERRORS))
 					die(_("updating files failed"));
 				data->add_errors++;
@@ -118,7 +121,7 @@ static void update_callback(struct diff_queue_struct *q,
 			if (data->flags & ADD_CACHE_IGNORE_REMOVAL)
 				break;
 			if (!(data->flags & ADD_CACHE_PRETEND))
-				remove_file_from_index(&the_index, path);
+				remove_file_from_index(data->index, path);
 			if (data->flags & (ADD_CACHE_PRETEND|ADD_CACHE_VERBOSE))
 				printf(_("remove '%s'\n"), path);
 			break;
@@ -126,16 +129,19 @@ static void update_callback(struct diff_queue_struct *q,
 	}
 }
 
-int add_files_to_cache(const char *prefix,
-		       const struct pathspec *pathspec, int flags)
+int add_files_to_cache(struct repository *repo, const char *prefix,
+		       const struct pathspec *pathspec, int include_sparse,
+		       int flags)
 {
 	struct update_callback_data data;
 	struct rev_info rev;
 
 	memset(&data, 0, sizeof(data));
+	data.index = repo->index;
+	data.include_sparse = include_sparse;
 	data.flags = flags;
 
-	repo_init_revisions(the_repository, &rev, prefix);
+	repo_init_revisions(repo, &rev, prefix);
 	setup_revisions(0, NULL, &rev, NULL);
 	if (pathspec)
 		copy_pathspec(&rev.prune_data, pathspec);
@@ -640,7 +646,9 @@ int cmd_add(int argc, const char **argv, const char *prefix)
 	if (add_renormalize)
 		exit_status |= renormalize_tracked_files(&pathspec, flags);
 	else
-		exit_status |= add_files_to_cache(prefix, &pathspec, flags);
+		exit_status |= add_files_to_cache(the_repository, prefix,
+						  &pathspec, include_sparse,
+						  flags);
 
 	if (add_new_files)
 		exit_status |= add_files(&dir, flags);
diff --git a/builtin/checkout.c b/builtin/checkout.c
index 715eeb5048f..d6765c9dbd9 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -861,7 +861,7 @@ static int merge_working_tree(const struct checkout_opts *opts,
 			 * entries in the index.
 			 */
 
-			add_files_to_cache(NULL, NULL, 0);
+			add_files_to_cache(the_repository, NULL, NULL, 0, 0);
 			init_merge_options(&o, the_repository);
 			o.verbosity = 0;
 			work = write_in_core_index_as_tree(the_repository);
diff --git a/builtin/commit.c b/builtin/commit.c
index e67c4be2211..bd634ee6ad1 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -447,7 +447,8 @@ static const char *prepare_index(const char **argv, const char *prefix,
 	if (all || (also && pathspec.nr)) {
 		repo_hold_locked_index(the_repository, &index_lock,
 				       LOCK_DIE_ON_ERROR);
-		add_files_to_cache(also ? prefix : NULL, &pathspec, 0);
+		add_files_to_cache(the_repository, also ? prefix : NULL,
+				   &pathspec, 0, 0);
 		refresh_cache_or_die(refresh_flags);
 		cache_tree_update(&the_index, WRITE_TREE_SILENT);
 		if (write_locked_index(&the_index, &index_lock, 0))
diff --git a/cache.h b/cache.h
index 8b2eb52f04e..02d69c24cd6 100644
--- a/cache.h
+++ b/cache.h
@@ -554,7 +554,9 @@ int cmp_cache_name_compare(const void *a_, const void *b_);
  * return 0 if success, 1 - if addition of a file failed and
  * ADD_FILES_IGNORE_ERRORS was specified in flags
  */
-int add_files_to_cache(const char *prefix, const struct pathspec *pathspec, int flags);
+int add_files_to_cache(struct repository *repo, const char *prefix,
+		       const struct pathspec *pathspec, int include_sparse,
+		       int flags);
 
 /* diff.c */
 extern int diff_auto_refresh_index;
-- 
gitgitgadget

