Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AC723DE44F
	for <git@vger.kernel.org>; Thu, 23 Apr 2026 08:40:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776933644; cv=none; b=slbMKgVltsXppH654dUXbwd3+Zb/N7807kukgoaPNHb37O7yPccOBYV3+KejRU1bGJ9UDQtAE0BwFReWEK+XEGWBmJnf984WAzW9dEcgeDH/7XjA58byzn6FyZgtzT67z8KbkhTL3KlPgPLOHbYTiu6yiawlWpmXE3R7CEHxPQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776933644; c=relaxed/simple;
	bh=xP8MilKwd2WOJ36K9g/fTroJ6hdVEragjQwnj4Gsx6k=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=SZnKteqbO4z+bEm408z53Jv3lsBxCC010LE4JGb4HqJ2Eo+89KziqeGruZm+mOJmdJ2/Zta570wLokLyxd2t815abwAt+ecaP+U7EGn+ENu08KhyOnDXpETYN9UPn5u8fAQ0xdsP96BSucG5JrsjH0fd7n4F0WwZCQ3vkygQgts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VJSmThJt; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VJSmThJt"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4891c0620bcso37390045e9.1
        for <git@vger.kernel.org>; Thu, 23 Apr 2026 01:40:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776933641; x=1777538441; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BOR79qfuh6sgqb8mE3JaK67gE4SujLM6oUurM8MkEc0=;
        b=VJSmThJte9Wx+PsA0dZggjDdIxofQZaisSsr0Czqx8Gktj12vuHpNjTSPqjbVS5l1a
         u334+F7IZfaQ0cR08+9lJTKe5RmVNn2/2hDyWNmwoz6jYiUuNDVgQS3T8LUjZTQE8FZb
         RJjiS2yyEXjrgAi9bREbgUBhVap4Lxbw3MUrVxQ55tLZ4iJPY7RKqlf4kKyNy5gLDsFn
         3uBNKte6YHghvS5mMXkmdquWLiTJR57IQuqUm7SmNzmReKkm8uQVQRflojTp023EbEYG
         1w0B6wecItYASowgX7ChAwMzwMvohcNDMYDCxLfxNycrbRiNFE3s0raPjbS0MIggygWV
         UuVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776933641; x=1777538441;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=BOR79qfuh6sgqb8mE3JaK67gE4SujLM6oUurM8MkEc0=;
        b=UpblGf+TzH9INkMY8JV38WxBQT8dHYf4BcxFKbvTG0rIPP3SqR1CLSNeuXjRp4pMWn
         oHHuUmr2KPXrWSyZ5JtQgD1lKM5IfzLmDDn5PKn6OEWvYNLF8qx7EdHJd52lG/U7FSc5
         zoX+Q86hWpmMq9GfzTTO+IAZ2Ag3cr9T7Rnmp1n54tvvtHGZhafg7nVV2gKglZlDjjVb
         h2y+9bpIVEC2iUVl6PfJSm69jadtKBohVAxttVpbzFdKgYEcbw5agDnWoSBz+sQd3ykd
         QMMtLidpzhl78tNdHn828bEFIrv+HrNhh4SUDfdn27Czp7rZ7YOCocnzXCMCkkJbaIgD
         p+BQ==
X-Gm-Message-State: AOJu0YwJWf29qR0UHggk6jwFKChPMt2Ga25n34Y8xus3tozPtw8uoRuZ
	WfnXIMNrPCk3U9ov8wgggtf8eZvCkm9TvYo4PdrhyzSC7px9eJujxezf7IGqaQ==
X-Gm-Gg: AeBDietb0iLidFivKsHvcWBx+I4lePFfEmTMi8vsoM6orpr6RKMIC5OQy2x+xFhXwrX
	RSg4rJjvq+IEEwcLZ4B3rUxclZp7BBDErCT6GER+2TNXPVI2N6e/Y9d0mxPCMa2wbXaI2wFIkf8
	eCxIu2qZ2GS10f9MfLIiKsS5IvaOK2k1KRQ1XjX9vIuBKpckXlfatT1sNwHnNdz0gfU94HPas8G
	zTaoW1AC/T59lSd9hJSH14ac4l11DkX0PY0E8LPiak6B6xPNkHXHK7zpgdlx5GvYYeQQKUWfj2R
	fZkZGfBLMZYseHCwShLdTQRxjjtrtEgxTy+6AutaXA3uPRWo3GYl03vMw/sEi+HNgI67jNo03c+
	1BW3929UfJqPXyYciiqA7bc+A0P5vH1r1BOztm4pcNWwJI7C6Cw92qja+Y/Qh2DwDrFlXTQWTEq
	9CflrcR3TMz1/PwFo9KwjUWD6borbiJIjLg37aoSCk
X-Received: by 2002:a05:600c:3e17:b0:48a:5565:ec3d with SMTP id 5b1f17b1804b1-48a5565ee64mr162303125e9.22.1776933641231;
        Thu, 23 Apr 2026 01:40:41 -0700 (PDT)
Received: from [127.0.0.2] ([2a02:8109:d906:4e00:1cda:f096:cc8c:a0e2])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-489fec8f7cbsm234286785e9.11.2026.04.23.01.40.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Apr 2026 01:40:40 -0700 (PDT)
From: Karthik Nayak <karthik.188@gmail.com>
Date: Thu, 23 Apr 2026 10:40:31 +0200
Subject: [PATCH v2 2/9] refs: introduce `ref_store_init_options`
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260423-refs-move-to-generic-layer-v2-2-ae5a4f146d7d@gmail.com>
References: <20260423-refs-move-to-generic-layer-v2-0-ae5a4f146d7d@gmail.com>
In-Reply-To: <20260423-refs-move-to-generic-layer-v2-0-ae5a4f146d7d@gmail.com>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>, gitster@pobox.com, ps@pks.im
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=6475; i=karthik.188@gmail.com;
 h=from:subject:message-id; bh=xP8MilKwd2WOJ36K9g/fTroJ6hdVEragjQwnj4Gsx6k=;
 b=owJ4nAHtARL+kA0DAAoBPtWfJI5GjH8ByyZiAGnp2wPfjF1fovhKWeqGE813dn00YEHJuJbHV
 m+9jf5seMs6QokBswQAAQoAHRYhBFfOTH9jdXEPy2XGBj7VnySORox/BQJp6dsDAAoJED7VnySO
 Rox/jOwMAJ4LrjgMSEZ/+mIn/vjrs27g7us9Gldr325E+E04k8sPD8VyNjax+GFrxJhzIJErrGF
 05sfM2U05gcd+pbq/PxLPsiZLjePPDJp0GMUXkiWPKik0B2lheeJY1gFZaQagoFRxcHIO2xgE2j
 lDIGA+cY3V5DL7KS/IJr1daVrCLPQNvrF4QLrBvm1FIjR0kZnNULDil+JAHhME/keykvLs/RC5D
 MYZCZ+fvdj1+8so2zwfwf0geEwG0BipYEWEk27n0O5aCVfT+c6yEbahSk0RLA6rmhBbiGwBzCvy
 ETWH8ssg3H/JBCkv1tc/KcTQ87giv7taYBcV6n0OQ3CRO2mRljKW/97sXxr87y9S6Q4s5zx7mNL
 CuqrMvVbBKWyo4D4zIfx1tFrvpa44M7fSPeac00pLwlndSLL29N72oel621BpcNshdODagbqeMV
 XPrkbZeieKVDdKXZEM2B1pPgJN9l+69clkX0K/bmMJbT6Se+xCRe3I67iVI1dH+QJcRdxqlGPO6
 6U=
X-Developer-Key: i=karthik.188@gmail.com; a=openpgp;
 fpr=57CE4C7F6375710FCB65C6063ED59F248E468C7F

Reference backends are initiated via the `init()` function. When
initiating the function, the backend is also provided flags which denote
the access levels of the initiator. Create a new structure
`ref_store_init_options` to house such options and move the access flags
to this structure.

This allows easier extension of providing further options to the
backends. In the following commit, we'll also provide config around
reflog creation to the backends via the same structure.

Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
---
 refs.c                  |  6 +++++-
 refs/files-backend.c    |  8 +++++---
 refs/packed-backend.c   |  4 ++--
 refs/packed-backend.h   |  3 ++-
 refs/refs-internal.h    | 11 ++++++++++-
 refs/reftable-backend.c |  4 ++--
 6 files changed, 26 insertions(+), 10 deletions(-)

diff --git a/refs.c b/refs.c
index bfcb9c7ac3..8992dd6ae8 100644
--- a/refs.c
+++ b/refs.c
@@ -2295,6 +2295,9 @@ static struct ref_store *ref_store_init(struct repository *repo,
 {
 	const struct ref_storage_be *be;
 	struct ref_store *refs;
+	struct ref_store_init_options opts = {
+		.access_flags = flags,
+	};
 
 	be = find_ref_storage_backend(format);
 	if (!be)
@@ -2304,7 +2307,8 @@ static struct ref_store *ref_store_init(struct repository *repo,
 	 * TODO Send in a 'struct worktree' instead of a 'gitdir', and
 	 * allow the backend to handle how it wants to deal with worktrees.
 	 */
-	refs = be->init(repo, repo->ref_storage_payload, gitdir, flags);
+	refs = be->init(repo, repo->ref_storage_payload, gitdir, &opts);
+
 	return refs;
 }
 
diff --git a/refs/files-backend.c b/refs/files-backend.c
index b3b0c25f84..78150ad209 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -108,7 +108,7 @@ static void clear_loose_ref_cache(struct files_ref_store *refs)
 static struct ref_store *files_ref_store_init(struct repository *repo,
 					      const char *payload,
 					      const char *gitdir,
-					      unsigned int flags)
+					      const struct ref_store_init_options *opts)
 {
 	struct files_ref_store *refs = xcalloc(1, sizeof(*refs));
 	struct ref_store *ref_store = (struct ref_store *)refs;
@@ -120,11 +120,13 @@ static struct ref_store *files_ref_store_init(struct repository *repo,
 					 &ref_common_dir);
 
 	base_ref_store_init(ref_store, repo, refdir.buf, &refs_be_files);
-	refs->store_flags = flags;
+
 	refs->gitcommondir = strbuf_detach(&ref_common_dir, NULL);
 	refs->packed_ref_store =
-		packed_ref_store_init(repo, NULL, refs->gitcommondir, flags);
+		packed_ref_store_init(repo, payload, refs->gitcommondir, opts);
+	refs->store_flags = opts->access_flags;
 	refs->log_all_ref_updates = repo_settings_get_log_all_ref_updates(repo);
+
 	repo_config_get_bool(repo, "core.prefersymlinkrefs", &refs->prefer_symlink_refs);
 
 	chdir_notify_reparent("files-backend $GIT_DIR", &refs->base.gitdir);
diff --git a/refs/packed-backend.c b/refs/packed-backend.c
index 23ed62984b..35a0f32e1c 100644
--- a/refs/packed-backend.c
+++ b/refs/packed-backend.c
@@ -218,14 +218,14 @@ static size_t snapshot_hexsz(const struct snapshot *snapshot)
 struct ref_store *packed_ref_store_init(struct repository *repo,
 					const char *payload UNUSED,
 					const char *gitdir,
-					unsigned int store_flags)
+					const struct ref_store_init_options *opts)
 {
 	struct packed_ref_store *refs = xcalloc(1, sizeof(*refs));
 	struct ref_store *ref_store = (struct ref_store *)refs;
 	struct strbuf sb = STRBUF_INIT;
 
 	base_ref_store_init(ref_store, repo, gitdir, &refs_be_packed);
-	refs->store_flags = store_flags;
+	refs->store_flags = opts->access_flags;
 
 	strbuf_addf(&sb, "%s/packed-refs", gitdir);
 	refs->path = strbuf_detach(&sb, NULL);
diff --git a/refs/packed-backend.h b/refs/packed-backend.h
index 2c2377a356..1db48e801d 100644
--- a/refs/packed-backend.h
+++ b/refs/packed-backend.h
@@ -3,6 +3,7 @@
 
 struct repository;
 struct ref_transaction;
+struct ref_store_init_options;
 
 /*
  * Support for storing references in a `packed-refs` file.
@@ -16,7 +17,7 @@ struct ref_transaction;
 struct ref_store *packed_ref_store_init(struct repository *repo,
 					const char *payload,
 					const char *gitdir,
-					unsigned int store_flags);
+					const struct ref_store_init_options *options);
 
 /*
  * Lock the packed-refs file for writing. Flags is passed to
diff --git a/refs/refs-internal.h b/refs/refs-internal.h
index 2d963cc4f4..f49b3807bf 100644
--- a/refs/refs-internal.h
+++ b/refs/refs-internal.h
@@ -385,6 +385,15 @@ struct ref_store;
 				 REF_STORE_ODB | \
 				 REF_STORE_MAIN)
 
+/*
+ * Options for initializing the ref backend. All backend-agnostic information
+ * which backends required will be held here.
+ */
+struct ref_store_init_options {
+	/* The kind of operations that the ref_store is allowed to perform. */
+	unsigned int access_flags;
+};
+
 /*
  * Initialize the ref_store for the specified gitdir. These functions
  * should call base_ref_store_init() to initialize the shared part of
@@ -393,7 +402,7 @@ struct ref_store;
 typedef struct ref_store *ref_store_init_fn(struct repository *repo,
 					    const char *payload,
 					    const char *gitdir,
-					    unsigned int flags);
+					    const struct ref_store_init_options *opts);
 /*
  * Release all memory and resources associated with the ref store.
  */
diff --git a/refs/reftable-backend.c b/refs/reftable-backend.c
index daea30a5b4..ad4ee2627c 100644
--- a/refs/reftable-backend.c
+++ b/refs/reftable-backend.c
@@ -369,7 +369,7 @@ static int reftable_be_config(const char *var, const char *value,
 static struct ref_store *reftable_be_init(struct repository *repo,
 					  const char *payload,
 					  const char *gitdir,
-					  unsigned int store_flags)
+					  const struct ref_store_init_options *opts)
 {
 	struct reftable_ref_store *refs = xcalloc(1, sizeof(*refs));
 	struct strbuf ref_common_dir = STRBUF_INIT;
@@ -386,8 +386,8 @@ static struct ref_store *reftable_be_init(struct repository *repo,
 
 	base_ref_store_init(&refs->base, repo, refdir.buf, &refs_be_reftable);
 	strmap_init(&refs->worktree_backends);
-	refs->store_flags = store_flags;
 	refs->log_all_ref_updates = repo_settings_get_log_all_ref_updates(repo);
+	refs->store_flags = opts->access_flags;
 
 	switch (repo->hash_algo->format_id) {
 	case GIT_SHA1_FORMAT_ID:

-- 
2.53.GIT

