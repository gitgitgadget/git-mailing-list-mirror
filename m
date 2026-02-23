Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D21B134D4C1
	for <git@vger.kernel.org>; Mon, 23 Feb 2026 08:01:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771833713; cv=none; b=uuvOqiverpakuypxvlMYMAgRyfJ5jJgaYGBkBTG8xaAdHD73lD40HQhW8qGAaNFoZjI8Q7Wa48sAzMUbw0bD6CxhfLHdzG+PIC/iB1DzsPP5WnkCDcM1bnwSyO9KlZ+FHcClSiPIxpKbx/n8qI6LsDsG3yYlxu2CjoPbf8oCbmQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771833713; c=relaxed/simple;
	bh=/IhfHSKVqGbjOFrpcTkrFo9eRkzNkyGpCu0Jv6PAz4U=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=daO88cB2lIZvoKpCkbwBmiWDT1/wP+LGn9ujdHYsIgyzf9MncdvkvUVFiinarOoAhnbuA+fL3y7xcxw+NfqH2PWqMgoFlGCnFLKtxcm3LooSXJmXzPPSDYT/zPOXnmu7oMVfoPD6EiDh1AIx9E/eBzvk1iR0MCJTcu+DGlnoV78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Vj+/R9Wt; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Vj+/R9Wt"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-48379a42f76so30873445e9.0
        for <git@vger.kernel.org>; Mon, 23 Feb 2026 00:01:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771833710; x=1772438510; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WD0HxC/R3Oln8z7yUAhpRRvW+0FHN5oyYwxByV6OdHQ=;
        b=Vj+/R9Wtn1CAAUOlvGHAmq0iFHbYj03aRwvYZD+/s/Yk53lIkSQq3p7WyrCR9Sc1/U
         hAeSk8GZ4Cux/PeLCN1TWiYiAQZHurKcRPm1+j5/0azvSRQrFZG90KY/qmjE4Ia42O5+
         8Bc5k0Q7ruGCmxjfO7Jmdb30g8XZdptmk43077fr/7RjYaYw7fT33pB6vjJ1zddpv9K4
         MQNXROzlgUk9CXv8t5kB48pcekZAnBJ/uK0rhdqxcxUhDX4B2lcHy0ttXMuH4/4x89hc
         dJ37lYZzs0q2W7Ld1k71ELQXeBEQJYuFvd4C/ulvO4mZ6nX8EDBqG/VQY1w4MGL3DtMP
         GM3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771833710; x=1772438510;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=WD0HxC/R3Oln8z7yUAhpRRvW+0FHN5oyYwxByV6OdHQ=;
        b=nGCElllcGSkj5uKBwt3/DMRx1Dgfg5K6Z3jnKJzlPaLJiAxXyQCNFSseH80X9bCJtq
         IbGHpHAfm4wdqPfe+wzGuwxUz8EKkdOwaVhgiutRZv459E7SdWEo2II78i0MU07DFByU
         0YxF0G//uJRIgrxge+1mLh6OTwtEObGqDtl6knJmP2uTW2fd0noQa6zdpNPkSQCxMdrQ
         0Nuhdha+wUtistY602hGWNLJ8BlUK5ccuTvtSTXtwGnzt8cQm2XdNmxLpL2m1OYkvXCu
         9UKnC1uUCZ+FHRynz56+cnRr8IVj1eEsBheaMzyWqaieG8vFWVwZNFaspFybCU551G9j
         1pAg==
X-Gm-Message-State: AOJu0YwThanWZmLwAJBFYJ+x4yqq8U7Hrf0DuRPO1sFWXdGhGnbEdvvk
	vT4vqxJKxiIZQ6ickNI1o3rZ5iiHAmiA6WxbLt/aXN3USQCRPERkp1uj
X-Gm-Gg: AZuq6aIOQVlq0fnJVUrsYXTnYTafZi4m9qQrsxMKnsQ0jNRsKD6Ja1lYJWiAU2xYUEH
	g0hmhS0xgqLZlKQ5l1D6H0GiHvFVDcvnoobGUe2eiUjxw81Czo+p6bheJy4FNK3o7NQZIqDUpDs
	ap1hEzxAHJM2FFB0bX67fX1XecbdYqR072GWYGtVAy6+Vk/Jd4zwmHgvlhbK2t7/Q/HAOJ9cJBg
	qwAfSTP+32PZXBdHrHriwmlI1fCAkRCMMufeJM/bV4J9BNMZw+VYP1y0dzKxSh89BNv+i3bh80b
	JUYK53uaGVPjOBvUcmnDzsT7gNqMvaAwqE0ULiQSFGbzhqyiYmg1Axxr0jGr9dI319miel4Iz/p
	QM9Q99rBadJTy6u8SUKLyBT6Ac942sTtoJXs/igWQRHK02DjzBADyF7uB2gnwmONWLJMXBhP+qM
	W/eFz86qhf7z3RXIxhfk/yXlRKm2hyZTI=
X-Received: by 2002:a05:600c:8717:b0:480:1c10:5633 with SMTP id 5b1f17b1804b1-483a9635abbmr102551765e9.26.1771833710070;
        Mon, 23 Feb 2026 00:01:50 -0800 (PST)
Received: from [127.0.0.2] ([2a02:8109:d906:4e00:f529:6f94:a480:7bd4])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-483a3db3369sm117333775e9.0.2026.02.23.00.01.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Feb 2026 00:01:49 -0800 (PST)
From: Karthik Nayak <karthik.188@gmail.com>
Date: Mon, 23 Feb 2026 09:01:40 +0100
Subject: [PATCH v8 5/6] refs: allow reference location in refstorage config
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260223-kn-alternate-ref-dir-v8-5-0509c132a203@gmail.com>
References: <20260223-kn-alternate-ref-dir-v8-0-0509c132a203@gmail.com>
In-Reply-To: <20260223-kn-alternate-ref-dir-v8-0-0509c132a203@gmail.com>
To: git@vger.kernel.org
Cc: gitster@pobox.com, ps@pks.im, toon@iotcl.com, 
 Karthik Nayak <karthik.188@gmail.com>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=17164;
 i=karthik.188@gmail.com; h=from:subject:message-id;
 bh=/IhfHSKVqGbjOFrpcTkrFo9eRkzNkyGpCu0Jv6PAz4U=;
 b=owJ4nAHtARL+kA0DAAoBPtWfJI5GjH8ByyZiAGmcCWeKLqsafCmd/+VVydwFasXP58KRTHTtJ
 GUkLp0nrQNEt4kBswQAAQoAHRYhBFfOTH9jdXEPy2XGBj7VnySORox/BQJpnAlnAAoJED7VnySO
 Rox/cdYL/ivzx7WH4CKNy9IBVTsk96eiT3s+j3LIHH43KRNY08aDJPtL2CxfTjjKI9nP/06GaGR
 uinqGLHMma69wYwZtMvJBd69TiglWKStNkxImCyXXZRMG3gIhXvgF8t+PqQa6jt1DGlnS3GYE77
 5F2yx3LEAc4F16dVTXJ6FfXd7yhGuzn8Bd9fmqJkyZSZBGlzleptL1SYvJUDPKcRlem7mpGRiBK
 nVAV2YOwqDXf//7p259p5uBdF6znfYnCRNqPo0v9TZ33b+sLRdo6WCKAoSsZQDeX2EWzoKltJSC
 IoDmGAFpFZVGWS6md4VP6qrKWfCGXi0cX9hsgvbLDFzBIEBIOGZIjcQFtNoqiZ4XxpkvaAJ/FKL
 Em3+A/P2p9XbrG6TeC8XPYmDpq/msx2vPslX7qC+ef24tqQxbyI4yKvhk3swBWRuC96KhxARzqW
 LLV7NMw7b9pXfQTa2hea/4SFNiE0sWGm6WdFM6bmaMsOqYpERKNiCL6HyQx6A9z3ikdVX8ccZy5
 DM=
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
individual backends. Add the necessary documentation and tests.

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
 builtin/worktree.c                   |  34 ++++++++
 refs.c                               |   6 +-
 repository.c                         |   9 +-
 repository.h                         |   8 +-
 setup.c                              |  34 +++++++-
 setup.h                              |   1 +
 t/meson.build                        |   1 +
 t/t1423-ref-backend.sh               | 159 +++++++++++++++++++++++++++++++++++
 9 files changed, 259 insertions(+), 9 deletions(-)

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
diff --git a/builtin/worktree.c b/builtin/worktree.c
index fbdaf2eb2e..293e808379 100644
--- a/builtin/worktree.c
+++ b/builtin/worktree.c
@@ -425,6 +425,39 @@ static int make_worktree_orphan(const char * ref, const struct add_opts *opts,
 	return run_command(&cp);
 }
 
+/*
+ * References for worktrees are generally stored in '$GIT_DIR/worktrees/<wt_id>'.
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
+		    path, wt->id);
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
index ba2573eb7a..ef1902e85c 100644
--- a/refs.c
+++ b/refs.c
@@ -2291,7 +2291,11 @@ static struct ref_store *ref_store_init(struct repository *repo,
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
index 1fc9ae3872..d407f3347b 100644
--- a/setup.c
+++ b/setup.c
@@ -632,6 +632,21 @@ static enum extension_result handle_extension_v0(const char *var,
 		return EXTENSION_UNKNOWN;
 }
 
+static void parse_reference_uri(const char *value, char **format,
+				char **payload)
+{
+	const char *schema_end;
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
@@ -2643,7 +2668,8 @@ static void repository_format_configure(struct repository_format *repo_fmt,
 	} else {
 		repo_fmt->ref_storage_format = REF_STORAGE_FORMAT_DEFAULT;
 	}
-	repo_set_ref_storage_format(the_repository, repo_fmt->ref_storage_format);
+	repo_set_ref_storage_format(the_repository, repo_fmt->ref_storage_format,
+				    repo_fmt->ref_storage_payload);
 }
 
 int init_db(const char *git_dir, const char *real_git_dir,
diff --git a/setup.h b/setup.h
index ddb9f6701c..093af39e84 100644
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
index 0000000000..9912433b8c
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
+	for dir in "$(pwd)/repo/.git" "."
+	do
+
+		test_expect_success "read from $to_format backend, $dir dir" '
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
+		test_expect_success "write to $to_format backend, $dir dir" '
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
2.53.GIT

