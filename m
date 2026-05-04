Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 413233E1D1D
	for <git@vger.kernel.org>; Mon,  4 May 2026 17:44:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777916657; cv=none; b=tWbgOVJglIL9wONDIkTGXMsmfdrIxqxiY85RxiPZLZRMPPftB1Rmf0jEk/pDMqwNpS93ZZO4jvC+5JuutftDMvzAwyZib+SEwSzRVt0XfJEBh5I8xmem4Efw24+mcqloG/OqkvQht3pTQr84QjBG9BfUhhIYvMPezLWWe/aZoaM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777916657; c=relaxed/simple;
	bh=msSsZA4AQq4WoKs2tEBzzQ401OVU3CFejk2HumEvxQA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=fLJcOu2hz4TbSPO8QPYhVr3UPY4/L8noliBZZMdiqRST6GJAwJjzsTEXIVjbIg0BvPoy5L3fb/etcfQSAbsU5gvxUg377SlINALYPGwSdbEtUvO4/G8Q7wsm8ToLk3DY8bMJpLV0OIxd38f8w9EaDfr+Cyyh7yuZfGFjWNz11yY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PPqXG9MV; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PPqXG9MV"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-488a8ca4aadso46107055e9.3
        for <git@vger.kernel.org>; Mon, 04 May 2026 10:44:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777916655; x=1778521455; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0kxK0tCkx4Poi406wByxo6s809CGgfPPJuVJY6SwR3s=;
        b=PPqXG9MVX7qbYpWZl5RDpZGZCRPbtkUtU85dyledqSn3tPxsP54dUOnjKo4je1qSYO
         yBHy4ASF/kE6fIYh7HkJ3GDb5CptiEsaAPzr+7knaFmmfTigeLtU0/od2W2f2ZkUddG2
         fUY4JOlBScu4XvuGmPIR22j2NOTuIn56y5HlBupgEkOMLaPbEij+ka7Wj4H1baR20PRf
         I/8dYjeKOCZsrRaWtTDN7M5U2+FNdCdXusk4qyyMKKIBsG6iDGiaQE5rTjy/nmLAEU9d
         nRcMTUeEp2CBFs5qq8O0CxJ1vu/uKe5hElstgybB9RnB046BOkDEAJrD5BeqA6tW+F3P
         HzNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777916655; x=1778521455;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=0kxK0tCkx4Poi406wByxo6s809CGgfPPJuVJY6SwR3s=;
        b=pOrNcVD//fBytgLME+LU+f1Fj7Vs2JnBEW5EYPR+6xrpMQx52XyQgzJY1GyVNMcS4N
         j6z1ltg9K2GAFAN+TdRp8+JdCsfKwFUzq8jtIVmeyzaWSusmnW22x+e0dx539eGKvwCe
         I9DRjGA6T50cpmHj9C8yO2RjSeIfFJt4w1mgzgTYK8QCFXze7qggmG/n9FR8ckIbUD75
         o+vhla/iaqDLUjz55NC2si+fDDY6rguLH/VLowGEqz8Z9PPZEBjP2ZeNVUXOQtPLxb5u
         6QQutM4M0IcWekSkX5B0MoeUl7KZwIXalmUoGwLvvGrdlXDgdbW+No2W2iAAfNyvGM64
         Z0fw==
X-Gm-Message-State: AOJu0YxW21FrIeAX/s4WDhH55PGtlZUE29E+x6Ga3kpDAhMryPAMdJgu
	yFIy58nPic1UlHGJIJsRcNln/CmnEBKOIAt6wJOXTLLUZEDkpAoq4FcZ
X-Gm-Gg: AeBDiesIPfeiUfq7AKLVYJ6uF4sasQBYCR66Pnys8bQOnN8UAzryljP2ck2LpywtoNT
	nhKhz66tyAKGHQG6A4ay4NdBVJ50wmkycwF7NiBInK26+eQEnLbKoSSUdl/FB5ABQMMv35cUr/4
	pZqQKgAszr2q7peLYdOI30zDy64O5umcJ8FfKmz2KoicQ9hBD2liGmDFKk61yCyIzspbszTN4ZC
	3XmwHobobaX1eCDiE7X4iYS4rZUl4o3LCv/GdYdzSKwLl0PHMiZMiSsdTxXFjPXCyDRlRTGZrF2
	EJ5QNIg4/uw6mlZAdgAHGK4xBvT3wVxtniH5spqiIVYL26i8Hoty62FXvQtLV+RsmT5G8tqSnbJ
	EIWkJntnsmDUj8mYyILDbvEtXCZ6N5QpWaasX4r6qZBcKvQDE1Q/5kuCzMwxB+2s5IU8VXiUKZs
	MABmrawz28rlX6ZERpOKu7D4gz7VKTdvZe5VyBmzyJ
X-Received: by 2002:a05:600c:821b:b0:489:1d23:4524 with SMTP id 5b1f17b1804b1-48a9852f4demr172961855e9.5.1777916654468;
        Mon, 04 May 2026 10:44:14 -0700 (PDT)
Received: from [127.0.0.2] ([2a02:8109:d906:4e00:1f8b:93fc:106a:20a3])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48a8eb75fc1sm299297675e9.7.2026.05.04.10.44.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 May 2026 10:44:14 -0700 (PDT)
From: Karthik Nayak <karthik.188@gmail.com>
Date: Mon, 04 May 2026 19:44:06 +0200
Subject: [PATCH v4 2/9] refs: introduce `ref_store_init_options`
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260504-refs-move-to-generic-layer-v4-2-936ac2f0b1a3@gmail.com>
References: <20260504-refs-move-to-generic-layer-v4-0-936ac2f0b1a3@gmail.com>
In-Reply-To: <20260504-refs-move-to-generic-layer-v4-0-936ac2f0b1a3@gmail.com>
To: git@vger.kernel.org
Cc: ps@pks.im, toon@iotcl.com, Karthik Nayak <karthik.188@gmail.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=6472; i=karthik.188@gmail.com;
 h=from:subject:message-id; bh=msSsZA4AQq4WoKs2tEBzzQ401OVU3CFejk2HumEvxQA=;
 b=owJ4nAHtARL+kA0DAAoBPtWfJI5GjH8ByyZiAGn42uhXR+bpe98vXEt3AORDiifx/3Q1c5Rpn
 cdgu0feC4O/VYkBswQAAQoAHRYhBFfOTH9jdXEPy2XGBj7VnySORox/BQJp+NroAAoJED7VnySO
 Rox/OyML/iwU+P2em9RXwSI1EumiUYZOg+0ADM3sqzL+++F7gujP8No6qvvPPEhQ+Cik7NTVPXw
 r0IgpYFpDpUCAsES9fD8KFeInfojOIoG73GQNFjCYxaLzX7lzEDXFu5lxJuQjWwKx8hYqihyWDH
 s7Ot/jumK5x5r8xtRymzhBGpnrsu5AkdH8oXN7BreVSp710eVH0dVKubNbdSqFvYEfE9jf5pnT9
 JoX5SZcTAuE2DKs99DxqIn6FxYd5vCgvyvX/5BEQr0jgs0lG5xfjEQbzJ3gC7cpWRDezAJqZy11
 3lzRtqzVAEBadH5NDP2YZZxSQ533qMEyP1ubmkf6fn7olo1E5+xQgH1hE37I3bc1HYpLyF+t7nf
 NumFw6QyAd3O3lPafOPGSuWb3eOQco1F6Gak9myXZVvffiR4rT3oFfEIKYSlP8WwfrVpisObP1u
 aTxBJIZqZXN9FgdvMa0jowxslwBzFrbLnFo11pj40vTMGlBP6ebJIhjJ6UnfWLuBiq8LXwhDcr9
 GU=
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
index b3b0c25f84..72afe62cee 100644
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
+		packed_ref_store_init(repo, NULL, refs->gitcommondir, opts);
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

