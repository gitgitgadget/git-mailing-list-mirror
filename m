Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 577CC2641FB
	for <git@vger.kernel.org>; Mon, 20 Oct 2025 08:18:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760948322; cv=none; b=f6GZQAdiXcjMRGu1H1Op2KA6VhjKTmjgfjtKNtIqdL6irZuSBXdjMkysLj81HcRdFMVTaLZftcb7y2iuD+RXE032Aejqv90GdaSHmsfglbKo8xxRLkbHxXBKTO6Iown2i/MnH+t+PqhlcQ5e21ON4xTgpIdlZxjWjkLzYhL6PGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760948322; c=relaxed/simple;
	bh=l13bmvGlkSAeXsmmsT7WjlqclyuXNahNp9oLtdUADuY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=gdHBPzDur/fM0Eoqa7jCvsHfSBBhqH5EdOoPWhD+8DKkenQnFy90uYET3272zp/wayWx35IWcDR1fPHJzfuR9EGc4tQ4+kgmbSrq7t7v6fYQb9OqMRvDdlUn6ld0jiG8ZrGC8aqOBmjuEjgCyw4OY28Bd146VPRQPha3FnrZI74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RcuoSoAC; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RcuoSoAC"
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-b5b823b4f3dso793060266b.3
        for <git@vger.kernel.org>; Mon, 20 Oct 2025 01:18:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760948318; x=1761553118; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LDdBtanwqtABHgg+3DvHjy8cpYLbMkG18gV0uSMYBaA=;
        b=RcuoSoAC16VOqrBOfB9SIgf1nj4EsS5z2Iv14UkUitnL7zEHhY4Z9q7D614D0IbG2R
         wdinek7sNlJJNmkYfKQj4BjeXsOwoy8xtEpIqziIASXF25355+5/LSnN1I3yzTkRVbMX
         nrAZm2V+4gOTL/Z/6jfHC+ZqK2Vhd+2GrPDKehChZbCqkC+4FYCg1k1PiHxSDePvPOmB
         Pj8ycodokW92OEfV2yLrYZ9RBVIc3o8+TJvFPPlM+rALQJUPNwzgwEnuJ+bva6cVEtGF
         +FVTDqSkutUgywo8AhKQe08L4F7tmm7IrE6dYV5m84bH3LbTpIQnuPHGtfyIHz+xdddU
         a8vQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760948318; x=1761553118;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LDdBtanwqtABHgg+3DvHjy8cpYLbMkG18gV0uSMYBaA=;
        b=Kfc8cvPpJy2ON4juO9LL2No+2SENj8tWgQ30AG2qedcu2eRwcCvlJc5QRlfKgL9N6B
         ddzjBM328fwoAlraKPPwFGgNidi8yuLiFZO36seuAuvZj/U5BYxluaHSudA3/iWCarB2
         zmeboG7q90khQ3RAIJ8eZHjBJpPIRjRkX+7+ghnzfQBJQYh+yXDNWMWW83xb3loCSQnr
         2JZ/Sm3SiysfUmY3gOzuBS1rfIfezlUEKR32SSs8f6QypbfEHOW22rnI5zDZ+41iR2SW
         i38kQTNkLhAmDNhxm9CbwB6XkTqtNgkgu8/uBMaSPPKyYKPk8QtG2BzOcce9CEWpHa97
         QjuQ==
X-Gm-Message-State: AOJu0Ywuex0y4YFZTWn79bArqq70s9FdgNnyfuTw+WaEJbinxlqpar3f
	jExqkWZPXvV7DGbZFmumf5kryxKMnO8cItRUQ8E1sDiqEbWlD8N+a8xfYkPI+73I
X-Gm-Gg: ASbGncthlsiWCBzy6jzl7x1XZ5f+H4bMBxMwEbxyG1GoGi4jzyKER7OkkLjvUM1M8tv
	EmjD4z8vXGresqWCQ9ZQvNTM+Xa27DbGGB3ijaqClTTH9sliuxf4LbzTUZtWbw6KbVOn0QAzcUB
	d5SkgWiI9VkreiIZgayUX9LXk74SWd3a14vvXVpaG+tE3nF6vz///YM1d4kHXNzhpjq/zgWr4zV
	TCcxLZh4S3F8oVVakOcjpgeLlnZAFLevzrOUL5se4S0RtWtZ3RZgRNWZDCXycAz/p4cS9lfnCs/
	rzZ2yBqxTeRYYQLr6yZsUryW/kI+h2Mk5fHMmHUFPaa/vHUKskUQWkAQn6WjkBtadL73Ol/JD2l
	vJa0LaVIjC5xgDiw16E6hjyM2Tpiwpx/hcUPoU9LDzCxNx7ZxPmv8cFT9yRi+MpVgzmYWg30AcX
	SJyS7mgXX4nZLuXDweHmc=
X-Google-Smtp-Source: AGHT+IHJxSB3k6Y0PaXJgqqMhB3uomgoqxLGLPkWljKLGCN0f5F3NE0lkxyZC3uVoe4A+8J2xb956g==
X-Received: by 2002:a17:907:d1e:b0:b3b:679d:7f4a with SMTP id a640c23a62f3a-b6472d5bb1dmr1270882766b.5.1760948318219;
        Mon, 20 Oct 2025 01:18:38 -0700 (PDT)
Received: from [127.0.0.2] ([2a02:2455:8268:bc00:5fd9:4a3c:9f89:6c65])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b65ebc42bc5sm716186066b.76.2025.10.20.01.18.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Oct 2025 01:18:37 -0700 (PDT)
From: Karthik Nayak <karthik.188@gmail.com>
Date: Mon, 20 Oct 2025 10:18:29 +0200
Subject: [PATCH v2 1/3] refs: move to using the '.optimize' functions
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251020-refs-code-cleanup-v2-1-f5349ed0f6a5@gmail.com>
References: <20251020-refs-code-cleanup-v2-0-f5349ed0f6a5@gmail.com>
In-Reply-To: <20251020-refs-code-cleanup-v2-0-f5349ed0f6a5@gmail.com>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>, ps@pks.im, jltobler@gmail.com
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=7667; i=karthik.188@gmail.com;
 h=from:subject:message-id; bh=l13bmvGlkSAeXsmmsT7WjlqclyuXNahNp9oLtdUADuY=;
 b=owJ4nAHtARL+kA0DAAoBPtWfJI5GjH8ByyZiAGj18FrgiB9OK7kRJPOx0/3tnlgkp6VMnwBRr
 qkZArEaLDspXIkBswQAAQoAHRYhBFfOTH9jdXEPy2XGBj7VnySORox/BQJo9fBaAAoJED7VnySO
 Rox/CEAL/RDGyJf5hsr/XQ9NQ//myujClq9+wZzizw47NOSV3sXTfQWYw/GDUKMvDAeYkICiAOh
 2SJgrZ4iJOx8jTzLew1gsMsrNDyBVDdlMykE2e+Miv72h5KWG5BVzWazt4xgoihIEU481yNHXM9
 LBat7ewFtVO/i7Kjp47fKIz/jugzCcBfL4iXgOJCW6u/kLUsxXEsIiG9ZrL5kFaIdXBMc3J7jgu
 Iz6j4Z/ofL87PGxuWyOVfJMrHvPJb065MzZWVm2xsNQolt85PfemY4AUzy05idhW/h+ebjDMz+U
 6kInF7j4JjT+UmYqXyqDGWx8ACfCVBrHxFP0sKO/wwiDb86PCHqHZiTVIYh7SKg40doPZs1C1WU
 WuXK0P5pPHEawhcgNN4jGoX7eqxI2nrgxEAKgkw6Qr79Unrsmu1s+nhyoE8E7idYCWqJ4qhdwoa
 1zEGggnPLJjYAAuRJ1dRLkkEUiV/RKcw7sdjUk9nNaQZvcLQ84krgxdgtsJlh+RWikyyw8Kfzd5
 ik=
X-Developer-Key: i=karthik.188@gmail.com; a=openpgp;
 fpr=57CE4C7F6375710FCB65C6063ED59F248E468C7F

The `struct ref_store` variable exposes two ways to optimize a reftable
backend:

  1. pack_refs
  2. optimize

The former was specific to the 'files' + 'packed' refs backend. The
latter is more generic and covers all backends. While the naming is
different, both of these functions perform the same functionality.

Consolidate this code to only maintain the 'optimize' functions. Do this
by modifying the backends so that they exclusively implement the
`optimize` callback, only. All users of the refs subsystem already use
the 'optimize' function so there is no changes needed on the callee
side. Finally, cleanup all references to the 'pack_refs' field of the
structure and code around it.

Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
---
 refs.c                  |  6 ------
 refs.h                  |  6 ------
 refs/debug.c            |  8 ++++----
 refs/files-backend.c    | 14 ++------------
 refs/packed-backend.c   |  6 +++---
 refs/refs-internal.h    |  3 ---
 refs/reftable-backend.c | 13 +++----------
 7 files changed, 12 insertions(+), 44 deletions(-)

diff --git a/refs.c b/refs.c
index a41a94ae55..b9a4a60646 100644
--- a/refs.c
+++ b/refs.c
@@ -2313,12 +2313,6 @@ void base_ref_store_init(struct ref_store *refs, struct repository *repo,
 	refs->gitdir = xstrdup(path);
 }
 
-/* backend functions */
-int refs_pack_refs(struct ref_store *refs, struct pack_refs_opts *opts)
-{
-	return refs->be->pack_refs(refs, opts);
-}
-
 int refs_optimize(struct ref_store *refs, struct pack_refs_opts *opts)
 {
 	return refs->be->optimize(refs, opts);
diff --git a/refs.h b/refs.h
index 23437d1220..6edb633eb6 100644
--- a/refs.h
+++ b/refs.h
@@ -514,12 +514,6 @@ struct pack_refs_opts {
 	struct string_list *includes;
 };
 
-/*
- * Write a packed-refs file for the current repository.
- * flags: Combination of the above PACK_REFS_* flags.
- */
-int refs_pack_refs(struct ref_store *refs, struct pack_refs_opts *opts);
-
 /*
  * Optimize the ref store. The exact behavior is up to the backend.
  * For the files backend, this is equivalent to packing refs.
diff --git a/refs/debug.c b/refs/debug.c
index 01499b9033..40cd1d9c15 100644
--- a/refs/debug.c
+++ b/refs/debug.c
@@ -116,11 +116,11 @@ static int debug_transaction_abort(struct ref_store *refs,
 	return res;
 }
 
-static int debug_pack_refs(struct ref_store *ref_store, struct pack_refs_opts *opts)
+static int debug_optimize(struct ref_store *ref_store, struct pack_refs_opts *opts)
 {
 	struct debug_ref_store *drefs = (struct debug_ref_store *)ref_store;
-	int res = drefs->refs->be->pack_refs(drefs->refs, opts);
-	trace_printf_key(&trace_refs, "pack_refs: %d\n", res);
+	int res = drefs->refs->be->optimize(drefs->refs, opts);
+	trace_printf_key(&trace_refs, "optimize: %d\n", res);
 	return res;
 }
 
@@ -430,7 +430,7 @@ struct ref_storage_be refs_be_debug = {
 	.transaction_finish = debug_transaction_finish,
 	.transaction_abort = debug_transaction_abort,
 
-	.pack_refs = debug_pack_refs,
+	.optimize = debug_optimize,
 	.rename_ref = debug_rename_ref,
 	.copy_ref = debug_copy_ref,
 
diff --git a/refs/files-backend.c b/refs/files-backend.c
index ed8a1729d6..92d90fc508 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -1444,8 +1444,8 @@ static int should_pack_refs(struct files_ref_store *refs,
 	return 0;
 }
 
-static int files_pack_refs(struct ref_store *ref_store,
-			   struct pack_refs_opts *opts)
+static int files_optimize(struct ref_store *ref_store,
+			  struct pack_refs_opts *opts)
 {
 	struct files_ref_store *refs =
 		files_downcast(ref_store, REF_STORE_WRITE | REF_STORE_ODB,
@@ -1512,15 +1512,6 @@ static int files_pack_refs(struct ref_store *ref_store,
 	return 0;
 }
 
-static int files_optimize(struct ref_store *ref_store, struct pack_refs_opts *opts)
-{
-	/*
-	 * For the "files" backend, "optimizing" is the same as "packing".
-	 * So, we just call the existing worker function for packing.
-	 */
-	return files_pack_refs(ref_store, opts);
-}
-
 /*
  * People using contrib's git-new-workdir have .git/logs/refs ->
  * /some/other/path/.git/logs/refs, and that may live on another device.
@@ -3969,7 +3960,6 @@ struct ref_storage_be refs_be_files = {
 	.transaction_finish = files_transaction_finish,
 	.transaction_abort = files_transaction_abort,
 
-	.pack_refs = files_pack_refs,
 	.optimize = files_optimize,
 	.rename_ref = files_rename_ref,
 	.copy_ref = files_copy_ref,
diff --git a/refs/packed-backend.c b/refs/packed-backend.c
index 1ab0c50393..20cf9fab18 100644
--- a/refs/packed-backend.c
+++ b/refs/packed-backend.c
@@ -1773,8 +1773,8 @@ static int packed_transaction_finish(struct ref_store *ref_store,
 	return ret;
 }
 
-static int packed_pack_refs(struct ref_store *ref_store UNUSED,
-			    struct pack_refs_opts *pack_opts UNUSED)
+static int packed_optimize(struct ref_store *ref_store UNUSED,
+			   struct pack_refs_opts *pack_opts UNUSED)
 {
 	/*
 	 * Packed refs are already packed. It might be that loose refs
@@ -2129,7 +2129,7 @@ struct ref_storage_be refs_be_packed = {
 	.transaction_finish = packed_transaction_finish,
 	.transaction_abort = packed_transaction_abort,
 
-	.pack_refs = packed_pack_refs,
+	.optimize = packed_optimize,
 	.rename_ref = NULL,
 	.copy_ref = NULL,
 
diff --git a/refs/refs-internal.h b/refs/refs-internal.h
index 4671517dad..fc5149df5b 100644
--- a/refs/refs-internal.h
+++ b/refs/refs-internal.h
@@ -422,8 +422,6 @@ typedef int ref_transaction_commit_fn(struct ref_store *refs,
 				      struct ref_transaction *transaction,
 				      struct strbuf *err);
 
-typedef int pack_refs_fn(struct ref_store *ref_store,
-			 struct pack_refs_opts *opts);
 typedef int optimize_fn(struct ref_store *ref_store,
 			struct pack_refs_opts *opts);
 typedef int rename_ref_fn(struct ref_store *ref_store,
@@ -550,7 +548,6 @@ struct ref_storage_be {
 	ref_transaction_finish_fn *transaction_finish;
 	ref_transaction_abort_fn *transaction_abort;
 
-	pack_refs_fn *pack_refs;
 	optimize_fn *optimize;
 	rename_ref_fn *rename_ref;
 	copy_ref_fn *copy_ref;
diff --git a/refs/reftable-backend.c b/refs/reftable-backend.c
index 6bbfd5618d..43cc66a48e 100644
--- a/refs/reftable-backend.c
+++ b/refs/reftable-backend.c
@@ -1700,11 +1700,11 @@ static int reftable_be_transaction_finish(struct ref_store *ref_store UNUSED,
 	return ret;
 }
 
-static int reftable_be_pack_refs(struct ref_store *ref_store,
-				 struct pack_refs_opts *opts)
+static int reftable_be_optimize(struct ref_store *ref_store,
+				struct pack_refs_opts *opts)
 {
 	struct reftable_ref_store *refs =
-		reftable_be_downcast(ref_store, REF_STORE_WRITE | REF_STORE_ODB, "pack_refs");
+		reftable_be_downcast(ref_store, REF_STORE_WRITE | REF_STORE_ODB, "optimize_refs");
 	struct reftable_stack *stack;
 	int ret;
 
@@ -1733,12 +1733,6 @@ static int reftable_be_pack_refs(struct ref_store *ref_store,
 	return ret;
 }
 
-static int reftable_be_optimize(struct ref_store *ref_store,
-				struct pack_refs_opts *opts)
-{
-	return reftable_be_pack_refs(ref_store, opts);
-}
-
 struct write_create_symref_arg {
 	struct reftable_ref_store *refs;
 	struct reftable_stack *stack;
@@ -2761,7 +2755,6 @@ struct ref_storage_be refs_be_reftable = {
 	.transaction_finish = reftable_be_transaction_finish,
 	.transaction_abort = reftable_be_transaction_abort,
 
-	.pack_refs = reftable_be_pack_refs,
 	.optimize = reftable_be_optimize,
 	.rename_ref = reftable_be_rename_ref,
 	.copy_ref = reftable_be_copy_ref,

-- 
2.51.0

