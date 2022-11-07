Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D419C4332F
	for <git@archiver.kernel.org>; Mon,  7 Nov 2022 18:36:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233185AbiKGSgf (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 7 Nov 2022 13:36:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233081AbiKGSg0 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Nov 2022 13:36:26 -0500
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A70725E96
        for <git@vger.kernel.org>; Mon,  7 Nov 2022 10:36:13 -0800 (PST)
Received: by mail-wm1-x32d.google.com with SMTP id i132-20020a1c3b8a000000b003cfa97c05cdso215025wma.4
        for <git@vger.kernel.org>; Mon, 07 Nov 2022 10:36:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Q8V34SHaCNfUgksCPhOhYFXWc4a0KY2DM8YhQE9/XcY=;
        b=ZfOV0xPQayPCvreYqemF6ArP7Muw1ixTHd+sTkGUybEHePIZcKEm4409YgvH4KZWzI
         CYLcjz/+6ZIKosTAa6Zq8CegBV2UnH7MkZ6oSOdHiFiFr0DMjQn5X/ofgD/HMvoZCMln
         n2h7p9+XepeWuIryuzV5icfDoKFbLQJvLSLtGk2thV4Sm7OJLD65f/oqouPrybs0eHFh
         lQV0MBWq9XlihVWmoDfHh1uwbaLPG3JJlRbl1oQ8QTIN+WISBPEK3buuteTISknq3SGS
         9MvnZyuRm+Qi1qmkpxLncINCUS47ThlBQMT7kwSJUJwntwdt8qZhQ/AUX0pLq5WO7O2m
         N+mQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Q8V34SHaCNfUgksCPhOhYFXWc4a0KY2DM8YhQE9/XcY=;
        b=a938WwEJXZFYgoowgc+4t/2KL9Fwa7H5y9ysvyHj7ae6miO6wnCvbhZgPWWnq5L2Jw
         DGsuEi80PYQUZdcz/fydQRJ+Slsg/zBfk7q8suqtlRTuATecozp82x5FKPR0bwDXREiv
         hAnwsBW/Ft+QwBeE85O69bbhlHsxnR5QapRgLPI6PA5M4snJW48PWQliKZnR6Djl0lYB
         oBfRKJTer+mRfOzEfhnXcjbjsVqKY+kKaDQzQus9pO3uJd3RNohz9Tnl5XtzAj2xSWpH
         Q+EVUQPVg8ix9qoX/mW8jOGaHD3/k+eD9QoJWiX0R6hO8ZC9utG/yioLALy5wVb5QTuZ
         kK3Q==
X-Gm-Message-State: ANoB5pmXiM67DsRN9GxaUYM+hUYejp1sY/UqPfoR4U6CHOutMzME9J8R
        pB1IjmG3qWczvstkaTppIkzDyI3fTBA=
X-Google-Smtp-Source: AA0mqf4ow7PU/y+Wk0zQS5V9GvUJ9zrmgAYWormMOfw0cNC6mQgON5E2oHVxAevttNPs7tgLOpZT6g==
X-Received: by 2002:a05:600c:1695:b0:3cf:a9b7:81e7 with SMTP id k21-20020a05600c169500b003cfa9b781e7mr5381585wmn.116.1667846171609;
        Mon, 07 Nov 2022 10:36:11 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id bn23-20020a056000061700b002305cfb9f3dsm8068156wrb.89.2022.11.07.10.36.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Nov 2022 10:36:11 -0800 (PST)
Message-Id: <3121334256d8ab9afb2922a389ec22f9faaa08cf.1667846164.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1408.git.1667846164.gitgitgadget@gmail.com>
References: <pull.1408.git.1667846164.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 07 Nov 2022 18:35:39 +0000
Subject: [PATCH 05/30] repository: wire ref extensions to ref backends
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     jrnieder@gmail.com, Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <derrickstolee@github.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <derrickstolee@github.com>

The previous change introduced the extensions.refFormat config option.
It is a multi-valued config option that currently understands "files"
and "packed", with both values assumed by default. If any value is
provided explicitly, this default is ignored and the provided settings
are used instead.

The multi-valued nature of this extension presents a way to allow a user
to specify that they never want a packed-refs file (only use "files") or
that they never want loose reference files (only use "packed"). However,
that functionality is not currently connected.

Before actually modifying the files backend to understand these
extension settings, do the basic wiring that connects the
extensions.refFormat parsing to the creation of the ref backend. A
future change will actually change the ref backend initialization based
on these settings, but this communication of the extension is
sufficiently complicated to be worth an isolated change.

For now, also forbid the setting of only "packed". This is done by
redirecting the choice of backend to the packed backend when that
selection is made. A later change will make the "files"-only extension
value ignore the packed backend.

Signed-off-by: Derrick Stolee <derrickstolee@github.com>
---
 cache.h                |  2 ++
 refs.c                 | 22 ++++++++++++++++++++--
 refs/files-backend.c   |  2 +-
 refs/refs-internal.h   |  3 +++
 repository.c           |  2 ++
 repository.h           |  6 ++++++
 setup.c                | 18 +++++++++++++++++-
 t/t3212-ref-formats.sh | 12 ++++++++++++
 8 files changed, 63 insertions(+), 4 deletions(-)

diff --git a/cache.h b/cache.h
index 26ed03bd6de..13e9c251ac3 100644
--- a/cache.h
+++ b/cache.h
@@ -1155,6 +1155,8 @@ struct repository_format {
 	int hash_algo;
 	int sparse_index;
 	char *work_tree;
+	int ref_format_count;
+	enum ref_format_flags ref_format;
 	struct string_list unknown_extensions;
 	struct string_list v1_only_extensions;
 };
diff --git a/refs.c b/refs.c
index 1491ae937eb..21441ddb162 100644
--- a/refs.c
+++ b/refs.c
@@ -1982,6 +1982,15 @@ static struct ref_store *lookup_ref_store_map(struct hashmap *map,
 	return entry ? entry->refs : NULL;
 }
 
+static int add_ref_format_flags(enum ref_format_flags flags, int caps) {
+	if (flags & REF_FORMAT_FILES)
+		caps |= REF_STORE_FORMAT_FILES;
+	if (flags & REF_FORMAT_PACKED)
+		caps |= REF_STORE_FORMAT_PACKED;
+
+	return caps;
+}
+
 /*
  * Create, record, and return a ref_store instance for the specified
  * gitdir.
@@ -1991,9 +2000,17 @@ static struct ref_store *ref_store_init(struct repository *repo,
 					unsigned int flags)
 {
 	const char *be_name = "files";
-	struct ref_storage_be *be = find_ref_storage_backend(be_name);
+	struct ref_storage_be *be;
 	struct ref_store *refs;
 
+	flags = add_ref_format_flags(repo->ref_format, flags);
+
+	if (!(flags & REF_STORE_FORMAT_FILES) &&
+	    (flags & REF_STORE_FORMAT_PACKED))
+		be_name = "packed";
+
+	be = find_ref_storage_backend(be_name);
+
 	if (!be)
 		BUG("reference backend %s is unknown", be_name);
 
@@ -2009,7 +2026,8 @@ struct ref_store *get_main_ref_store(struct repository *r)
 	if (!r->gitdir)
 		BUG("attempting to get main_ref_store outside of repository");
 
-	r->refs_private = ref_store_init(r, r->gitdir, REF_STORE_ALL_CAPS);
+	r->refs_private = ref_store_init(r, r->gitdir,
+					 REF_STORE_ALL_CAPS);
 	r->refs_private = maybe_debug_wrap_ref_store(r->gitdir, r->refs_private);
 	return r->refs_private;
 }
diff --git a/refs/files-backend.c b/refs/files-backend.c
index b89954355de..db6c8e434c6 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -3274,7 +3274,7 @@ static int files_init_db(struct ref_store *ref_store, struct strbuf *err UNUSED)
 }
 
 struct ref_storage_be refs_be_files = {
-	.next = NULL,
+	.next = &refs_be_packed,
 	.name = "files",
 	.init = files_ref_store_create,
 	.init_db = files_init_db,
diff --git a/refs/refs-internal.h b/refs/refs-internal.h
index 69f93b0e2ac..41520c945e4 100644
--- a/refs/refs-internal.h
+++ b/refs/refs-internal.h
@@ -521,6 +521,9 @@ struct ref_store;
 				 REF_STORE_ODB | \
 				 REF_STORE_MAIN)
 
+#define REF_STORE_FORMAT_FILES		(1 << 8) /* can use loose ref files */
+#define REF_STORE_FORMAT_PACKED		(1 << 9) /* can use packed-refs file */
+
 /*
  * Initialize the ref_store for the specified gitdir. These functions
  * should call base_ref_store_init() to initialize the shared part of
diff --git a/repository.c b/repository.c
index 5d166b692c8..96533fc76be 100644
--- a/repository.c
+++ b/repository.c
@@ -182,6 +182,8 @@ int repo_init(struct repository *repo,
 	repo->repository_format_partial_clone = format.partial_clone;
 	format.partial_clone = NULL;
 
+	repo->ref_format = format.ref_format;
+
 	if (worktree)
 		repo_set_worktree(repo, worktree);
 
diff --git a/repository.h b/repository.h
index 24316ac944e..5cfde4282c5 100644
--- a/repository.h
+++ b/repository.h
@@ -61,6 +61,11 @@ struct repo_path_cache {
 	char *shallow;
 };
 
+enum ref_format_flags {
+	REF_FORMAT_FILES = (1 << 0),
+	REF_FORMAT_PACKED = (1 << 1),
+};
+
 struct repository {
 	/* Environment */
 	/*
@@ -95,6 +100,7 @@ struct repository {
 	 * the ref object.
 	 */
 	struct ref_store *refs_private;
+	enum ref_format_flags ref_format;
 
 	/*
 	 * Contains path to often used file names.
diff --git a/setup.c b/setup.c
index f5eb50c969a..a5e63479558 100644
--- a/setup.c
+++ b/setup.c
@@ -578,9 +578,14 @@ static enum extension_result handle_extension(const char *var,
 		data->hash_algo = format;
 		return EXTENSION_OK;
 	} else if (!strcmp(ext, "refformat")) {
-		if (strcmp(value, "files") && strcmp(value, "packed"))
+		if (!strcmp(value, "files"))
+			data->ref_format |= REF_FORMAT_FILES;
+		else if (!strcmp(value, "packed"))
+			data->ref_format |= REF_FORMAT_PACKED;
+		else
 			return error(_("invalid value for '%s': '%s'"),
 				     "extensions.refFormat", value);
+		data->ref_format_count++;
 		return EXTENSION_OK;
 	}
 	return EXTENSION_UNKNOWN;
@@ -723,6 +728,11 @@ int read_repository_format(struct repository_format *format, const char *path)
 	git_config_from_file(check_repo_format, path, format);
 	if (format->version == -1)
 		clear_repository_format(format);
+
+	/* Set default ref_format if no extensions.refFormat exists. */
+	if (!format->ref_format_count)
+		format->ref_format = REF_FORMAT_FILES | REF_FORMAT_PACKED;
+
 	return format->version;
 }
 
@@ -1425,6 +1435,9 @@ int discover_git_directory(struct strbuf *commondir,
 		candidate.partial_clone;
 	candidate.partial_clone = NULL;
 
+	/* take ownership of candidate.ref_format */
+	the_repository->ref_format = candidate.ref_format;
+
 	clear_repository_format(&candidate);
 	return 0;
 }
@@ -1561,6 +1574,8 @@ const char *setup_git_directory_gently(int *nongit_ok)
 			the_repository->repository_format_partial_clone =
 				repo_fmt.partial_clone;
 			repo_fmt.partial_clone = NULL;
+
+			the_repository->ref_format = repo_fmt.ref_format;
 		}
 	}
 	/*
@@ -1650,6 +1665,7 @@ void check_repository_format(struct repository_format *fmt)
 	repo_set_hash_algo(the_repository, fmt->hash_algo);
 	the_repository->repository_format_partial_clone =
 		xstrdup_or_null(fmt->partial_clone);
+	the_repository->ref_format = fmt->ref_format;
 	clear_repository_format(&repo_fmt);
 }
 
diff --git a/t/t3212-ref-formats.sh b/t/t3212-ref-formats.sh
index bc554e7c701..8c4e70196a0 100755
--- a/t/t3212-ref-formats.sh
+++ b/t/t3212-ref-formats.sh
@@ -24,4 +24,16 @@ test_expect_success 'invalid extensions.refFormat' '
 	grep "invalid value for '\''extensions.refFormat'\'': '\''bogus'\''" err
 '
 
+test_expect_success 'extensions.refFormat=packed only' '
+	git init only-packed &&
+	(
+		cd only-packed &&
+		git config core.repositoryFormatVersion 1 &&
+		git config extensions.refFormat packed &&
+		test_commit A &&
+		test_path_exists .git/packed-refs &&
+		test_path_is_missing .git/refs/tags/A
+	)
+'
+
 test_done
-- 
gitgitgadget

