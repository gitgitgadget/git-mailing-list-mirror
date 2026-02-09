Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 047383803C8
	for <git@vger.kernel.org>; Mon,  9 Feb 2026 15:58:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770652709; cv=none; b=JOz3VxmR4wwEfRtaD94vKqD4ueUTAJMR/4Voj1OBUkmMWbaKYfBMsGtGBjyIiMsbLpUCzd/O5BOpFxsbUCmtKrtoYkaHCHYLMq9VbQILFWWhMpndmEcW8XSF3jN2vlDL+h7cBQ8TwqC98tJeaisdpIPsV0s5Rjhb8pecDTDwQtQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770652709; c=relaxed/simple;
	bh=ycYg8CudwvQBqX9+9ccByIyY+oiLCdJJtEzcm98G/Vk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=VH+NzbOrY4BU7IFJhAsxr90br7hjRQQE8nmLIbutQ91WkleBPfk24LiBT8EL9L4oOpM5CHJhZ5WdIo2JfdnJOTss8Ca/k1fM/QnTXad1v/VIMUK7NavsMKSObVFCAExjx3WR51Rh8iS/P0i1YnPv3scuiPQW0Jq4qiAFyepjKYQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=H34TEtbq; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H34TEtbq"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-48327b8350dso26150805e9.1
        for <git@vger.kernel.org>; Mon, 09 Feb 2026 07:58:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770652707; x=1771257507; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ba/hhG9+kuzoPMKBRJACJDa2hab2r9yai9sCVYl+qVU=;
        b=H34TEtbq3AF3XBqF4jO8RVC/Ac1K8dHR+4nQGj2lXNtJkYuUQDdCidIkak9VyW+vYS
         yzSzQsfWOqj6sAen57n8HePqZxBQNmdWcx5s3Na6mXINTYfq6pD+3peFMPKOTobXppho
         uFzhAnNhxgxaWynmlvakU/Mgrhdqa7TCG+6NtPDY+t4ccjN1wLXZb77fYnwLgoPF9Por
         tOczKp6f4G6fLGLE6WdWRfrm2lMDIq7rnFewdrDNRZ7JnTrNMFnlDnIDdXgVhs4esIZI
         gw2dyAPMxHbRQT+LKmNgNfagGe+KyYIY4mBq/skNj0xuK3mZz3QAFzjzLa+9bF1XMTv7
         mk+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770652707; x=1771257507;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Ba/hhG9+kuzoPMKBRJACJDa2hab2r9yai9sCVYl+qVU=;
        b=CW2ugOwMRNlXRB5vhPKi24Dy3QDyBZc8ruGY8c8OrzNhf3mb26njpQQ1HzVe10qOhj
         o4lu071Fipd9jSpqwxE0Qr2x6WGSlcmgX3ZlC++3NXp543yIFQWB+J5FNFPtxgqDOCev
         boWGA+8GnnwwzcPsngaAAoMbgoTcI3Uv5c9OI5FoaN/eRwq/XMr9DmB+KSM3SRcpnDj3
         yCO4T3VeKcmE750pc7bIDbI/cNZ9oNX3OUbKUyRJ+iDgNQHsuLwf64Hodfe/Ji0BbUhN
         KuqYSqgX9ueuZR9VnO1NcyErg3WW8y0B7pFxGdEs4HFakGGjRr7AU+sFo/owNqNJnTIr
         sKRA==
X-Gm-Message-State: AOJu0YzKbtrTp4BTxx9Hv0ZCGH3YCeeodWEi8uOTN69hLgt9sA/S6AOi
	slqkFNQ/zVUrUZKJBkqGuiAQxAqgNoVnnii6dAu1zZEYkWr4hUsIIWl8
X-Gm-Gg: AZuq6aJ7y+De5zHN9x7hGyYFj0UfFYUIZ6n0IceL+dzqManq2J/FtjlYTwEa6Yec2Hl
	1HSxjCVPz+p7STmYdW94grRpVUH3sAIKmg53lTAMAr9+k7xMvlL1U0Vbsg8iz+pysaxCUn/0pHh
	g0tmGvp4AA41HQnQvLq7ui2I2LoKCUECdq2NK2IR5v5Zr9Nsuys3MFe2vIV7KBbEqXXk+vzvekz
	FabdCFyoJBHy9vr5fjzhmDwygYGeaWbRQ5FRhhElZdbi8hOGccFTjSwE2jrDtnPf5axsEJf5tq+
	VwUE/UXFWqvzRMc1p6YGDcrMa4F6dY526yUsqQhM2FpBxZGiDQ4qDhwV7KHUxlAXU4lw0348Za6
	8YFqZPcUUN/UD6G0FXyVU0CLVSUUjzyuJDLukIPV3JcGh2qzrdQE4FN8YrHTcsTqUEEY9DwztRj
	CQYoAwnRxfCSpymT+ocik=
X-Received: by 2002:a05:600c:34c5:b0:480:1c69:9d36 with SMTP id 5b1f17b1804b1-48320212e11mr210072295e9.17.1770652707231;
        Mon, 09 Feb 2026 07:58:27 -0800 (PST)
Received: from [127.0.0.2] ([2a02:8109:d906:4e00:9616:5969:7cd9:8b71])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4832096f127sm128163635e9.6.2026.02.09.07.58.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Feb 2026 07:58:26 -0800 (PST)
From: Karthik Nayak <karthik.188@gmail.com>
Date: Mon, 09 Feb 2026 16:58:20 +0100
Subject: [PATCH v5 3/4] refs: allow reference location in refstorage config
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260209-kn-alternate-ref-dir-v5-3-740899834ceb@gmail.com>
References: <20260209-kn-alternate-ref-dir-v5-0-740899834ceb@gmail.com>
In-Reply-To: <20260209-kn-alternate-ref-dir-v5-0-740899834ceb@gmail.com>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>, Patrick Steinhardt <ps@pks.im>, 
 =?utf-8?q?Jean-No=C3=ABl_Avila?= <jn.avila@free.fr>, gitster@pobox.com
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=19123;
 i=karthik.188@gmail.com; h=from:subject:message-id;
 bh=ycYg8CudwvQBqX9+9ccByIyY+oiLCdJJtEzcm98G/Vk=;
 b=owJ4nAHtARL+kA0DAAoBPtWfJI5GjH8ByyZiAGmKBBz+Rz1207GjzLb3wb8VzSklWKus03P3Q
 oeQVWI5cMsKRYkBswQAAQoAHRYhBFfOTH9jdXEPy2XGBj7VnySORox/BQJpigQcAAoJED7VnySO
 Rox/ZBIL+gObgduKr+gwRkoqgpMWn09SNQSHP0b67ApCaLlgYjagHg1st14J6wMhWb3PLZFSHgf
 w4cXPFKEW9/sAT0M9OCwRj7Yq/OY77LQf0+AOjZlLeloomRvdrNR/awItFqQ0o8qZ6kYdSETUTm
 31bQzakeew7ippsMo0kMt+MaDeQ4blEtUOQGO68OixDUWdcNz9u598o+fUQ2ST91P4ASpJ0zo3Q
 9qTDLTzloXNr1IqUY3N5FqCWcxUzC9qEnGB09FFUwUSRDka+401RDSx5Na9bejlk3YxTNRxd+Aj
 1rXggCLjrnsQR+iP0S6fV03UlCjnhXmtajTsnPEPCjZlGQ4npBCwwaqAfHjMF4RPJsHu+Teg5jd
 8F33ICBXMDeQa2VuXEBnNGYcC9vDXrhJHzkKVrdYvxGpDsfbYqo4eeI9O9rv+61x6v/bq/xxpyJ
 BXWi36uGm6BvgZxQglhItoa0LlTSiuiL7lqIDc1KCeLc+ZlHSErPblC9baGGrCosN18umUfSvV6
 xo=
X-Developer-Key: i=karthik.188@gmail.com; a=openpgp;
 fpr=57CE4C7F6375710FCB65C6063ED59F248E468C7F

The 'extensions.refStorage' config is used to specify the reference
backend for a given repository. Both the 'files' and 'reftable' backends
utilize the $GIT_DIR as the reference folder by default in
`get_main_ref_store()`.

Since the reference backends are pluggable, this means that they could
work with out-of-tree reference directories too. Extend the 'refStorage'
config to also support taking an URI input, where users can specify the
reference backend and the location.

Add the required changes to obtain and propagate this value to the
individual backends also add the necessary documentation and tests.

Traditionally, for linked worktrees, references were stored in the
'$GIT_DIR/worktrees/<wt_id>' path. But when using an alternate reference
storage path, it doesn't make sense to store the main worktree
references in the new path, and the linked worktree references in the
$GIT_DIR. So, let's store linked worktree references in
'$ALTERNATE_REFERENCE_DIR/worktrees/<wt_id>'. To do this, create the
necessary files and folders while also adding stubs in the $GIT_DIR path
to ensure that it is still considered a Git directory.

Ideally, we would want to pass in a `struct worktree *` to individual
backends, instead of passing the `gitdir`. This allows them to handle
worktree specific logic. Currently, that is not possible since the
worktree code is:

  - Tied to using the global `the_repository` variable.

  - Is not setup before the reference database during initialization of
    the repository.

Add a TODO in 'refs.c' to ensure we can eventually make that change.

Helped-by: Patrick Steinhardt <ps@pks.im>
Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
---
 Documentation/config/extensions.adoc |  16 +++-
 builtin/clone.c                      |   3 +-
 builtin/worktree.c                   |  34 ++++++++
 refs.c                               |   6 +-
 repository.c                         |   9 +-
 repository.h                         |   8 +-
 setup.c                              |  39 +++++++--
 setup.h                              |   2 +
 t/meson.build                        |   1 +
 t/t1423-ref-backend.sh               | 159 +++++++++++++++++++++++++++++++++++
 10 files changed, 266 insertions(+), 11 deletions(-)

diff --git a/Documentation/config/extensions.adoc b/Documentation/config/extensions.adoc
index 532456644b..3e51da36d3 100644
--- a/Documentation/config/extensions.adoc
+++ b/Documentation/config/extensions.adoc
@@ -57,10 +57,24 @@ For historical reasons, this extension is respected regardless of the
 `core.repositoryFormatVersion` setting.
 
 refStorage:::
-	Specify the ref storage format to use. The acceptable values are:
+	Specify the ref storage format and a corresponding payload. The value
+	can be either a format name or a URI:
 +
 --
+* A format name alone (e.g., `reftable` or `files`).
+
+* A URI format `<format>://<payload>` explicitly specifies both the
+  format and payload (e.g., `reftable:///foo/bar`).
+
+Supported format names are:
++
 include::../ref-storage-format.adoc[]
++
+The payload is passed directly to the reference backend. For the files and
+reftable backends, this must be a filesystem path where the references will
+be stored. Defaulting to the commondir when no payload is provided. Relative
+paths are resolved relative to the $GIT_DIR. Future backends may support
+other payload schemes, e.g., postgres://127.0.0.1:5432?database=myrepo.
 --
 +
 Note that this setting should only be set by linkgit:git-init[1] or
diff --git a/builtin/clone.c b/builtin/clone.c
index 535a257b10..11854894d3 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -1437,7 +1437,8 @@ int cmd_clone(int argc,
 	hash_algo = hash_algo_by_ptr(transport_get_hash_algo(transport));
 	initialize_repository_version(hash_algo, the_repository->ref_storage_format, 1);
 	repo_set_hash_algo(the_repository, hash_algo);
-	create_reference_database(the_repository->ref_storage_format, NULL, 1);
+	create_reference_database(the_repository->ref_storage_format,
+				  the_repository->ref_storage_payload, NULL, 1);
 
 	/*
 	 * Before fetching from the remote, download and install bundle
diff --git a/builtin/worktree.c b/builtin/worktree.c
index fbdaf2eb2e..94480be5c4 100644
--- a/builtin/worktree.c
+++ b/builtin/worktree.c
@@ -425,6 +425,39 @@ static int make_worktree_orphan(const char * ref, const struct add_opts *opts,
 	return run_command(&cp);
 }
 
+/*
+ * References for worktress are generally stored in '$GIT_DIR/worktrees/<wt_id>'.
+ * But when using alternate reference directories, we want to store the worktree
+ * references in '$ALTERNATE_REFERENCE_DIR/worktrees/<wt_id>'.
+ *
+ * Create the necessary folder structure to facilitate the same. But to ensure
+ * that the former path is still considered a Git directory, add stubs.
+ */
+static void setup_alternate_ref_dir(struct worktree *wt, const char *wt_git_path)
+{
+	struct strbuf sb = STRBUF_INIT;
+	char *path;
+
+	path = wt->repo->ref_storage_payload;
+	if (!path)
+		return;
+
+	if (!is_absolute_path(path))
+		strbuf_addf(&sb, "%s/", wt->repo->commondir);
+
+	strbuf_addf(&sb, "%s/worktrees", path);
+	safe_create_dir(wt->repo, sb.buf, 1);
+	strbuf_addf(&sb, "/%s", wt->id);
+	safe_create_dir(wt->repo, sb.buf, 1);
+	strbuf_reset(&sb);
+
+	strbuf_addf(&sb, "this worktree stores references in %s/worktrees/%s",
+		   path, wt->id);
+	refs_create_refdir_stubs(wt->repo, wt_git_path, sb.buf);
+
+	strbuf_release(&sb);
+}
+
 static int add_worktree(const char *path, const char *refname,
 			const struct add_opts *opts)
 {
@@ -518,6 +551,7 @@ static int add_worktree(const char *path, const char *refname,
 		ret = error(_("could not find created worktree '%s'"), name);
 		goto done;
 	}
+	setup_alternate_ref_dir(wt, sb_repo.buf);
 	wt_refs = get_worktree_ref_store(wt);
 
 	ret = ref_store_create_on_disk(wt_refs, REF_STORE_CREATE_ON_DISK_IS_WORKTREE, &sb);
diff --git a/refs.c b/refs.c
index d9df25d7c0..f520d64a9d 100644
--- a/refs.c
+++ b/refs.c
@@ -2225,7 +2225,11 @@ static struct ref_store *ref_store_init(struct repository *repo,
 	if (!be)
 		BUG("reference backend is unknown");
 
-	refs = be->init(repo, NULL, gitdir, flags);
+	/*
+	 * TODO Send in a 'struct worktree' instead of a 'gitdir', and
+	 * allow the backend to handle how it wants to deal with worktrees.
+	 */
+	refs = be->init(repo, repo->ref_storage_payload, gitdir, flags);
 	return refs;
 }
 
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
index 6063c4b846..95e2333bad 100644
--- a/repository.h
+++ b/repository.h
@@ -150,6 +150,11 @@ struct repository {
 
 	/* Repository's reference storage format, as serialized on disk. */
 	enum ref_storage_format ref_storage_format;
+	/*
+	 * Reference storage information as needed for the backend. This contains
+	 * only the payload from the reference URI without the schema.
+	 */
+	char *ref_storage_payload;
 
 	/* A unique-id for tracing purposes. */
 	int trace2_repo_id;
@@ -204,7 +209,8 @@ void repo_set_worktree(struct repository *repo, const char *path);
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
diff --git a/t/meson.build b/t/meson.build
index 459c52a489..11fc5a49ee 100644
--- a/t/meson.build
+++ b/t/meson.build
@@ -210,6 +210,7 @@ integration_tests = [
   't1420-lost-found.sh',
   't1421-reflog-write.sh',
   't1422-show-ref-exists.sh',
+  't1423-ref-backend.sh',
   't1430-bad-ref-name.sh',
   't1450-fsck.sh',
   't1451-fsck-buffer.sh',
diff --git a/t/t1423-ref-backend.sh b/t/t1423-ref-backend.sh
new file mode 100755
index 0000000000..9c777b79f3
--- /dev/null
+++ b/t/t1423-ref-backend.sh
@@ -0,0 +1,159 @@
+#!/bin/sh
+
+test_description='Test reference backend URIs'
+
+. ./test-lib.sh
+
+# Run a git command with the provided reference storage. Reset the backend
+# post running the command.
+# Usage: run_with_uri <repo> <backend> <uri> <cmd>
+#   <repo> is the relative path to the repo to run the command in.
+#   <backend> is the original ref storage of the repo.
+#   <uri> is the new URI to be set for the ref storage.
+#   <cmd> is the git subcommand to be run in the repository.
+run_with_uri() {
+	repo=$1 &&
+	backend=$2 &&
+	uri=$3 &&
+	cmd=$4 &&
+
+	git -C "$repo" config set core.repositoryformatversion 1
+	git -C "$repo" config set extensions.refStorage "$uri" &&
+	git -C "$repo" $cmd &&
+	git -C "$repo" config set extensions.refStorage "$backend"
+}
+
+# Test a repository with a given reference storage by running and comparing
+# 'git refs list' before and after setting the new reference backend. If
+# err_msg is set, expect the command to fail and grep for the provided err_msg.
+# Usage: run_with_uri <repo> <backend> <uri> <cmd>
+#   <repo> is the relative path to the repo to run the command in.
+#   <backend> is the original ref storage of the repo.
+#   <uri> is the new URI to be set for the ref storage.
+#   <err_msg> (optional) if set, check if 'git-refs(1)' failed with the provided msg.
+test_refs_backend() {
+	repo=$1 &&
+	backend=$2 &&
+	uri=$3 &&
+	err_msg=$4 &&
+
+	git -C "$repo" config set core.repositoryformatversion 1 &&
+	if test -n "$err_msg";
+	then
+		git -C "$repo" config set extensions.refStorage "$uri" &&
+		test_must_fail git -C "$repo" refs list 2>err &&
+		test_grep "$err_msg" err
+	else
+		git -C "$repo" refs list >expect &&
+		run_with_uri "$repo" "$backend" "$uri" "refs list" >actual &&
+		test_cmp expect actual
+	fi
+}
+
+test_expect_success 'URI is invalid' '
+	test_when_finished "rm -rf repo" &&
+	git init repo &&
+	test_refs_backend repo files "reftable@/home/reftable" \
+		"invalid value for ${SQ}extensions.refstorage${SQ}"
+'
+
+test_expect_success 'URI ends with colon' '
+	test_when_finished "rm -rf repo" &&
+	git init repo &&
+	test_refs_backend repo files "reftable:" \
+		"invalid value for ${SQ}extensions.refstorage${SQ}"
+'
+
+test_expect_success 'unknown reference backend' '
+	test_when_finished "rm -rf repo" &&
+	git init repo &&
+	test_refs_backend repo files "db://.git" \
+		"invalid value for ${SQ}extensions.refstorage${SQ}"
+'
+
+ref_formats="files reftable"
+for from_format in $ref_formats
+do
+
+for to_format in $ref_formats
+do
+	if test "$from_format" = "$to_format"
+	then
+		continue
+	fi
+
+
+	for dir in "$(pwd)/repo/.git" "./"
+	do
+
+		test_expect_success "$read from $to_format backend, $dir dir" '
+			test_when_finished "rm -rf repo" &&
+			git init --ref-format=$from_format repo &&
+			(
+				cd repo &&
+				test_commit 1 &&
+				test_commit 2 &&
+				test_commit 3 &&
+
+				git refs migrate --dry-run --ref-format=$to_format >out &&
+				BACKEND_PATH="$dir/$(sed "s/.* ${SQ}.git\/\(.*\)${SQ}/\1/" out)" &&
+				test_refs_backend . $from_format "$to_format://$BACKEND_PATH" "$method"
+			)
+		'
+
+		test_expect_success "$write to $to_format backend, $dir dir" '
+			test_when_finished "rm -rf repo" &&
+			git init --ref-format=$from_format repo &&
+			(
+				cd repo &&
+				test_commit 1 &&
+				test_commit 2 &&
+				test_commit 3 &&
+
+				git refs migrate --dry-run --ref-format=$to_format >out &&
+				BACKEND_PATH="$dir/$(sed "s/.* ${SQ}.git\/\(.*\)${SQ}/\1/" out)" &&
+
+				test_refs_backend . $from_format "$to_format://$BACKEND_PATH" &&
+
+				git refs list >expect &&
+				run_with_uri . "$from_format" "$to_format://$BACKEND_PATH" "tag -d 1" &&
+				git refs list >actual &&
+				test_cmp expect actual &&
+
+				git refs list | grep -v "refs/tags/1" >expect &&
+				run_with_uri . "$from_format" "$to_format://$BACKEND_PATH" "refs list" >actual &&
+				test_cmp expect actual
+			)
+		'
+
+		test_expect_success "with worktree and $to_format backend, $dir dir" '
+			test_when_finished "rm -rf repo wt" &&
+			git init --ref-format=$from_format repo &&
+			(
+				cd repo &&
+				test_commit 1 &&
+				test_commit 2 &&
+				test_commit 3 &&
+
+				git refs migrate --dry-run --ref-format=$to_format >out &&
+				BACKEND_PATH="$dir/$(sed "s/.* ${SQ}.git\/\(.*\)${SQ}/\1/" out)" &&
+
+				git config set core.repositoryformatversion 1 &&
+				git config set extensions.refStorage "$to_format://$BACKEND_PATH" &&
+
+				git worktree add ../wt 2
+			) &&
+
+			git -C repo for-each-ref --include-root-refs >expect &&
+			git -C wt for-each-ref --include-root-refs >expect &&
+			! test_cmp expect actual &&
+
+			git -C wt rev-parse 2 >expect &&
+			git -C wt rev-parse HEAD >actual &&
+			test_cmp expect actual
+		'
+	done # closes dir
+done # closes to_format
+done # closes from_format
+
+test_done

-- 
2.52.0

