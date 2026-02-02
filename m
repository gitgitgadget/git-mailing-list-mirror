Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 644653644D0
	for <git@vger.kernel.org>; Mon,  2 Feb 2026 12:27:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770035227; cv=none; b=GaqSyq9QLMMc+Lk2ItzZ1GXKCuuCIdM6PZs6825p9LL/VodCPvgsAzpfwdBtkq+dkpai2t7BuQ3T72D+wni8JL+qjFLIsZuVDvcbwq+jeGB8U83BkYu18kV8cfP1GLrma0MHY1xCkrodHjQwbZbFAZ5mdqMVzjbkIHpxbddvLig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770035227; c=relaxed/simple;
	bh=nHSxxUWvFHLTsVGY/FnrlLdeiSbURnIQ/2FE6l1xcbA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=CsnuUJag23txX4ZazyLqvvYymHLKEX4+HWYwr5PfPQCfsWMNAz1qYobYqmDSGxZlhXiNWUesyLVyIJbiZc9WvpIpZ4Gq6+9ArUBqEwpkqx0PcsX3bvf4AOP89nvLWkWqI1k/GOU6DanaFIyLKExIg6VJs5PufdTRspnpsWgWI2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SdgQxYpZ; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SdgQxYpZ"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-481188b7760so28464585e9.0
        for <git@vger.kernel.org>; Mon, 02 Feb 2026 04:27:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770035224; x=1770640024; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MB2B/tFFa2mGE3tNjcUn8zNaLzbED2v/6WYMuxVyyjg=;
        b=SdgQxYpZfo/+8qaQhVwBO6XZq43LU8VtHzM99V7cDDIlyQfTOFdGLoGFE5KcOaqY6/
         X5MMr6mxmW6LRZrR7hZjQ664IWHgixXz0KI788GNK+vdMTzliKX2H2Ba+TDRWn/mBMX0
         /o+x7RC6UYXpyjZmbL3tOkJ/zLI2uUtKSDEbbIdfZstBBmNAROn3k/2Wr3G5iF0tVT78
         bX5EAtkJvWoArupQBHkIJeKdSCwFEvG9XKIRE/cwQOEqxpLSSOjs4s9yueXDAidyknVK
         Mzc1lrQ397QIFQLptko+zoA2tWOi0kmx5jXbt498dV8oN1dzRYSzUDnjj5joLdauOkW1
         jkDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770035224; x=1770640024;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=MB2B/tFFa2mGE3tNjcUn8zNaLzbED2v/6WYMuxVyyjg=;
        b=O8G8cgzARLxa7ZAnh5Mv2QABZ0b85Flo6iXz5Y70iHgihf2zIjGWJ9Unn8YEwJy0v+
         MKwpMlwH7IDnw9sbrEIgX6KgVk757b/rbEe1hBuS3Oqk6uTk+ACQP0RKT/z87w2P78Ye
         nTc5LiZg5gQYx5fom/owW9AgWhAOjBOeuMWhF8shjCN9Tk/w1+QoBLX7WfzVjTzJDkxr
         upZ8uo77h68O4kkOcUP4XLm5W9AN5wuRSftOFchKbnGBAaECtIDuwYsYHBVwLojfpGLA
         4zxqwcT47usbj7z96HWIM1gkQfMOKGX6sLnad/9sXIbVRcbvy7mzsXrDQmrcjlbsPpOF
         sdRw==
X-Gm-Message-State: AOJu0YwAXzMbSGwoMZxKiPdmONDJtpoQJUGs1B+r6ek6+ORK/9/8Wwg9
	zmeND738ZXMpQNWhn58JfN/kbEzJpMaDwprbV6XzLtxLqxpunWWwkanhV7qo9PI+
X-Gm-Gg: AZuq6aJspr1GKEOqWKj0/EY4/0u4ZJyyIUwhUor0/TNUB8JK/qO/PVPHd2fxZzcHlbW
	l82cxJ1i90X8mfXobv1gLoq/AaX/BkClGjcYfUjblzxL88N5BJM/jNFAfw388xFehZ+1DRb9/yC
	eq8zw1Mggtd8v75J16nNEp1hWn9bJ0D6DeuOL2czX8ffxjrfHMO3BLQDJIpT9FFgKZ7HyXs6hxr
	H42IeQKIsSFkxb/CjtACacrRTTw8AtYR9y2ve9Acz84BnC8sjtNgosoURP8NDOHUzpjxZe+lhzm
	4HThHlQ5nODU4VGD+4jU4VsZMybjsH7nP+FiTwViy7/y/HmLvllzFYNirgpPKqzIEg6k1bRgsBf
	KNd2PNoXl1OJvuBbMHCVIW9vDZiH5eboG25t8GqvTVPaWq82I97/Ls29pJ+FbPWZDdEQkwkvAah
	Cf89R2xxMl8l3RqqzpLoUeli9BUVDDxA==
X-Received: by 2002:a05:6000:2dc2:b0:435:b6ab:6c1a with SMTP id ffacd0b85a97d-435f3abb021mr14914162f8f.49.1770035223394;
        Mon, 02 Feb 2026 04:27:03 -0800 (PST)
Received: from [127.0.0.2] ([2a02:8109:d906:4e00:4339:aac1:fb26:43f4])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-435e10e4757sm45245735f8f.5.2026.02.02.04.27.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Feb 2026 04:27:03 -0800 (PST)
From: Karthik Nayak <karthik.188@gmail.com>
Date: Mon, 02 Feb 2026 13:26:30 +0100
Subject: [PATCH v4 1/4] refs: allow reference location in refstorage config
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260202-kn-alternate-ref-dir-v4-1-3b30430411e3@gmail.com>
References: <20260202-kn-alternate-ref-dir-v4-0-3b30430411e3@gmail.com>
In-Reply-To: <20260202-kn-alternate-ref-dir-v4-0-3b30430411e3@gmail.com>
To: git@vger.kernel.org
Cc: gitster@pobox.com, ps@pks.im, Karthik Nayak <karthik.188@gmail.com>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=8595; i=karthik.188@gmail.com;
 h=from:subject:message-id; bh=nHSxxUWvFHLTsVGY/FnrlLdeiSbURnIQ/2FE6l1xcbA=;
 b=owJ4nAHtARL+kA0DAAoBPtWfJI5GjH8ByyZiAGmAmBRT2zDKBJK/wIjKgwWObGK6WRaKVgh36
 igKRPf2V6DUbYkBswQAAQoAHRYhBFfOTH9jdXEPy2XGBj7VnySORox/BQJpgJgUAAoJED7VnySO
 Rox/4wEL/RHlXiQygtn4m0FqU5B6B+KAMJgVViVwy0YapyPzSOE6XaUv3iiUCKr2hoK89cxazw4
 uA+tq+3nnqtHAavRDs93/3hRQe7ztlpCdBKEVBUGhWII+XgVmFaXqirb7PIYBgOnyLmp9acGdMd
 Z/ZyaOZsush0hXxFdF8RFzyc/M6D3qAg3BbxekQYAfmNWHvywgNPCoI9jXyBfUf3Bn0RSbfMmMp
 KfTL2A1t6lzGkJel32uMvWIEshY1Q4XDplHV526sEehYGNsRp0m91ra0YFHdQhzmQNbdrRo7dk1
 7m/32s1yH4BNYxMVQ8BTiJPHai8eWpTbxsr5HPO8P5EuIpGHpqSAUMsU6Rplq6sTF0OABPfM0Af
 WUTOUKkM5F+9hDib6elsLKX2uPooDvX2o83p6RIzX9j758BNEkVRUG+KQv6Ss1efA2b8ZdXzJz9
 lLQdIik3D5xNzODQyhR+a024HOEZD93iWoIh0ma1ACBzdkU6/HpD7Ihs7rHe5DZieSmU1aRbDF5
 ok=
X-Developer-Key: i=karthik.188@gmail.com; a=openpgp;
 fpr=57CE4C7F6375710FCB65C6063ED59F248E468C7F

The 'extensions.refStorage' config is used to specify the reference
backend for a given repository. Both the 'files' and 'reftable' backends
utilize the $GIT_DIR as the reference folder by default in
`get_main_ref_store()`.

Since the reference backends are pluggable, this means that they should
work with out-of-tree reference directories too. Extend the 'refStorage'
config to also support taking an URI input, where users can specify the
reference backend and the location.

Add the required changes to obtain and propagate this value to the
individual backends. A follow up commit will add the required changes on
the backends to parse this value.

Helped-by: Patrick Steinhardt <ps@pks.im>
Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
---
 builtin/clone.c |  3 ++-
 repository.c    |  9 +++++++--
 repository.h    |  5 ++++-
 setup.c         | 39 ++++++++++++++++++++++++++++++++++-----
 setup.h         |  2 ++
 5 files changed, 49 insertions(+), 9 deletions(-)

diff --git a/builtin/clone.c b/builtin/clone.c
index b40cee5968..28412576b3 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -1442,7 +1442,8 @@ int cmd_clone(int argc,
 	hash_algo = hash_algo_by_ptr(transport_get_hash_algo(transport));
 	initialize_repository_version(hash_algo, the_repository->ref_storage_format, 1);
 	repo_set_hash_algo(the_repository, hash_algo);
-	create_reference_database(the_repository->ref_storage_format, NULL, 1);
+	create_reference_database(the_repository->ref_storage_format,
+				  the_repository->ref_storage_payload, NULL, 1);
 
 	/*
 	 * Before fetching from the remote, download and install bundle
diff --git a/repository.c b/repository.c
index c7e75215ac..9815f081ef 100644
--- a/repository.c
+++ b/repository.c
@@ -193,9 +193,12 @@ void repo_set_compat_hash_algo(struct repository *repo, int algo)
 }
 
 void repo_set_ref_storage_format(struct repository *repo,
-				 enum ref_storage_format format)
+				 enum ref_storage_format format,
+				 const char *payload)
 {
 	repo->ref_storage_format = format;
+	free(repo->ref_storage_payload);
+	repo->ref_storage_payload = xstrdup_or_null(payload);
 }
 
 /*
@@ -277,7 +280,8 @@ int repo_init(struct repository *repo,
 
 	repo_set_hash_algo(repo, format.hash_algo);
 	repo_set_compat_hash_algo(repo, format.compat_hash_algo);
-	repo_set_ref_storage_format(repo, format.ref_storage_format);
+	repo_set_ref_storage_format(repo, format.ref_storage_format,
+				    format.ref_storage_payload);
 	repo->repository_format_worktree_config = format.worktree_config;
 	repo->repository_format_relative_worktrees = format.relative_worktrees;
 	repo->repository_format_precious_objects = format.precious_objects;
@@ -369,6 +373,7 @@ void repo_clear(struct repository *repo)
 	FREE_AND_NULL(repo->index_file);
 	FREE_AND_NULL(repo->worktree);
 	FREE_AND_NULL(repo->submodule_prefix);
+	FREE_AND_NULL(repo->ref_storage_payload);
 
 	odb_free(repo->objects);
 	repo->objects = NULL;
diff --git a/repository.h b/repository.h
index 6063c4b846..c648dab196 100644
--- a/repository.h
+++ b/repository.h
@@ -150,6 +150,8 @@ struct repository {
 
 	/* Repository's reference storage format, as serialized on disk. */
 	enum ref_storage_format ref_storage_format;
+	/* Reference storage information as needed for the backend. */
+	char *ref_storage_payload;
 
 	/* A unique-id for tracing purposes. */
 	int trace2_repo_id;
@@ -204,7 +206,8 @@ void repo_set_worktree(struct repository *repo, const char *path);
 void repo_set_hash_algo(struct repository *repo, int algo);
 void repo_set_compat_hash_algo(struct repository *repo, int compat_algo);
 void repo_set_ref_storage_format(struct repository *repo,
-				 enum ref_storage_format format);
+				 enum ref_storage_format format,
+				 const char *payload);
 void initialize_repository(struct repository *repo);
 RESULT_MUST_BE_USED
 int repo_init(struct repository *r, const char *gitdir, const char *worktree);
diff --git a/setup.c b/setup.c
index b723f8b339..44e393c251 100644
--- a/setup.c
+++ b/setup.c
@@ -632,6 +632,21 @@ static enum extension_result handle_extension_v0(const char *var,
 		return EXTENSION_UNKNOWN;
 }
 
+static void parse_reference_uri(const char *value, char **format,
+				char **payload)
+{
+	char *schema_end;
+
+	schema_end = strstr(value, "://");
+	if (!schema_end) {
+		*format = xstrdup(value);
+		*payload = NULL;
+	} else {
+		*format = xstrndup(value, schema_end - value);
+		*payload = xstrdup_or_null(schema_end + 3);
+	}
+}
+
 /*
  * Record any new extensions in this function.
  */
@@ -674,10 +689,17 @@ static enum extension_result handle_extension(const char *var,
 		return EXTENSION_OK;
 	} else if (!strcmp(ext, "refstorage")) {
 		unsigned int format;
+		char *format_str;
 
 		if (!value)
 			return config_error_nonbool(var);
-		format = ref_storage_format_by_name(value);
+
+		parse_reference_uri(value, &format_str,
+				    &data->ref_storage_payload);
+
+		format = ref_storage_format_by_name(format_str);
+		free(format_str);
+
 		if (format == REF_STORAGE_FORMAT_UNKNOWN)
 			return error(_("invalid value for '%s': '%s'"),
 				     "extensions.refstorage", value);
@@ -850,6 +872,7 @@ void clear_repository_format(struct repository_format *format)
 	string_list_clear(&format->v1_only_extensions, 0);
 	free(format->work_tree);
 	free(format->partial_clone);
+	free(format->ref_storage_payload);
 	init_repository_format(format);
 }
 
@@ -1942,7 +1965,8 @@ const char *setup_git_directory_gently(int *nongit_ok)
 			repo_set_compat_hash_algo(the_repository,
 						  repo_fmt.compat_hash_algo);
 			repo_set_ref_storage_format(the_repository,
-						    repo_fmt.ref_storage_format);
+						    repo_fmt.ref_storage_format,
+						    repo_fmt.ref_storage_payload);
 			the_repository->repository_format_worktree_config =
 				repo_fmt.worktree_config;
 			the_repository->repository_format_relative_worktrees =
@@ -2042,7 +2066,8 @@ void check_repository_format(struct repository_format *fmt)
 	repo_set_hash_algo(the_repository, fmt->hash_algo);
 	repo_set_compat_hash_algo(the_repository, fmt->compat_hash_algo);
 	repo_set_ref_storage_format(the_repository,
-				    fmt->ref_storage_format);
+				    fmt->ref_storage_format,
+				    fmt->ref_storage_payload);
 	the_repository->repository_format_worktree_config =
 		fmt->worktree_config;
 	the_repository->repository_format_relative_worktrees =
@@ -2360,13 +2385,15 @@ static int is_reinit(void)
 }
 
 void create_reference_database(enum ref_storage_format ref_storage_format,
+			       const char *ref_storage_payload,
 			       const char *initial_branch, int quiet)
 {
 	struct strbuf err = STRBUF_INIT;
 	char *to_free = NULL;
 	int reinit = is_reinit();
 
-	repo_set_ref_storage_format(the_repository, ref_storage_format);
+	repo_set_ref_storage_format(the_repository, ref_storage_format,
+				    ref_storage_payload);
 	if (ref_store_create_on_disk(get_main_ref_store(the_repository), 0, &err))
 		die("failed to set up refs db: %s", err.buf);
 
@@ -2645,7 +2672,8 @@ static void repository_format_configure(struct repository_format *repo_fmt,
 	} else {
 		repo_fmt->ref_storage_format = REF_STORAGE_FORMAT_DEFAULT;
 	}
-	repo_set_ref_storage_format(the_repository, repo_fmt->ref_storage_format);
+	repo_set_ref_storage_format(the_repository, repo_fmt->ref_storage_format,
+				    repo_fmt->ref_storage_payload);
 }
 
 int init_db(const char *git_dir, const char *real_git_dir,
@@ -2702,6 +2730,7 @@ int init_db(const char *git_dir, const char *real_git_dir,
 
 	if (!(flags & INIT_DB_SKIP_REFDB))
 		create_reference_database(repo_fmt.ref_storage_format,
+					  repo_fmt.ref_storage_payload,
 					  initial_branch, flags & INIT_DB_QUIET);
 	create_object_directory();
 
diff --git a/setup.h b/setup.h
index d55dcc6608..4d25a353ac 100644
--- a/setup.h
+++ b/setup.h
@@ -171,6 +171,7 @@ struct repository_format {
 	int hash_algo;
 	int compat_hash_algo;
 	enum ref_storage_format ref_storage_format;
+	char *ref_storage_payload;
 	int sparse_index;
 	char *work_tree;
 	struct string_list unknown_extensions;
@@ -241,6 +242,7 @@ void initialize_repository_version(int hash_algo,
 				   enum ref_storage_format ref_storage_format,
 				   int reinit);
 void create_reference_database(enum ref_storage_format ref_storage_format,
+			       const char *ref_storage_payload,
 			       const char *initial_branch, int quiet);
 
 /*

-- 
2.52.0

