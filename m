Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63BD5C46CA1
	for <git@archiver.kernel.org>; Mon, 18 Sep 2023 17:59:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229823AbjIRR7v (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 18 Sep 2023 13:59:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229718AbjIRR7t (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 18 Sep 2023 13:59:49 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C269EFA
        for <git@vger.kernel.org>; Mon, 18 Sep 2023 10:59:41 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id 5b1f17b1804b1-402d499580dso51852175e9.1
        for <git@vger.kernel.org>; Mon, 18 Sep 2023 10:59:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695059980; x=1695664780; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YQOX0wOVyb8g/uytJrbNM6EdRI3k1zLw75GkauMR7Pg=;
        b=PhOqVvmL5cMvF1+0I1FO9pbgI4+20gH4NoW4+nM5e1RCS243njLaUms1QM4c4YDUnE
         Y8k/D1VawPnLneBQ2ODonVeRM74/bTeCaOi09JumnVvOJ00tTHDbzbIBfpaf2AclrLp+
         /kE6Hi6RosX1V0DpBmHWB3/gZvzlay/51iJ4+6FVpWRwJc13NgNxiQYSVYDHhl/rcxm9
         74Ziz5dFyY+UXn54pc/a9z9NXUtfkTfRGdDR270VT9MSfM4HFw+g26aGWxWJ3GqZkVD3
         krpNdpIkXjpWQuU6Jf6IaXHrlH4E2BZFOCHYaD43rC+u/heJ+T973Pb/YajhUWSu8cTU
         q+Ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695059980; x=1695664780;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YQOX0wOVyb8g/uytJrbNM6EdRI3k1zLw75GkauMR7Pg=;
        b=v5iVRRDIq3JErjnwzOJfrGbgzV/OzgH33Kj2InC+ZLKCN10dmFPGAnt9Ko68OZYcKn
         Um3uqDwbui8odXSEt4UBE0ocwwdrWl3O5Lyw72dwUBL0nA/GP60vM3ITSF6p1Hc2evhO
         cGd9lZ+yXMTKj2ossT9cCtL3o+xx3di+C6qjHJtsEPV9TNpqGRGVIm4znrQwZGWLYzBx
         QBMBS3zpo6iAE3kJvDiNfF6xLE5LYhnNURQoVt3TxZm8Vw7tuh6MSSBDz2T0dXYNveUJ
         1/woye/3OT1opiwyGbCGl+QMiFL2mCA7ij+H7wRueHhldiE1SpYctyN17w5Ehy88u7Kl
         V0Gg==
X-Gm-Message-State: AOJu0YyQ1c54IxDRXxUXoETEBTzEsBLm9DuUle/p+CZj5N68szWlD4fU
        6kZQfZw3JlPYqjDsbobsQoz2DU/n5GE=
X-Google-Smtp-Source: AGHT+IHeBV6PQteeRJ5fZOmOigT77ToklKA3KJS/zwSq0QoST9hBY0XhJtz/EmFXZzdhk3enGUjq3w==
X-Received: by 2002:a05:600c:11ce:b0:403:be16:baa with SMTP id b14-20020a05600c11ce00b00403be160baamr9994297wmi.29.1695059979877;
        Mon, 18 Sep 2023 10:59:39 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id f13-20020a5d568d000000b0031fd849e797sm13111441wrv.105.2023.09.18.10.59.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Sep 2023 10:59:39 -0700 (PDT)
Message-ID: <dea0fbb139a82fe449a7edab6a8f445ce763d0c0.1695059978.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1574.git.git.1695059978.gitgitgadget@gmail.com>
References: <pull.1574.git.git.1695059978.gitgitgadget@gmail.com>
From:   "Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 18 Sep 2023 17:59:36 +0000
Subject: [PATCH 1/3] refs: push lock management into packed backend
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Han-Wen Nienhuys <hanwenn@gmail.com>,
        Han-Wen Nienhuys <hanwen@google.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Han-Wen Nienhuys <hanwen@google.com>

Introduces a ref backend method transaction_begin, which for the
packed backend takes packed-refs.lock.

This decouples the files backend from the packed backend, allowing the
latter to be swapped out by another ref backend.

Signed-off-by: Han-Wen Nienhuys <hanwen@google.com>
---
 refs.c                |  8 +++++
 refs/debug.c          | 15 +++++++++
 refs/files-backend.c  | 78 +++++++++++++++----------------------------
 refs/packed-backend.c | 41 ++++++++++++++---------
 refs/packed-backend.h | 10 ------
 refs/refs-internal.h  |  5 +++
 6 files changed, 79 insertions(+), 78 deletions(-)

diff --git a/refs.c b/refs.c
index fcae5dddc60..a2d1012520e 100644
--- a/refs.c
+++ b/refs.c
@@ -1130,10 +1130,18 @@ struct ref_transaction *ref_store_transaction_begin(struct ref_store *refs,
 						    struct strbuf *err)
 {
 	struct ref_transaction *tr;
+	int ret = 0;
 	assert(err);
 
 	CALLOC_ARRAY(tr, 1);
 	tr->ref_store = refs;
+
+	if (refs->be->transaction_begin)
+		ret = refs->be->transaction_begin(refs, tr, err);
+	if (ret) {
+		free(tr);
+		return NULL;
+	}
 	return tr;
 }
 
diff --git a/refs/debug.c b/refs/debug.c
index b7ffc4ce67e..964806e9301 100644
--- a/refs/debug.c
+++ b/refs/debug.c
@@ -41,6 +41,20 @@ static int debug_init_db(struct ref_store *refs, struct strbuf *err)
 	return res;
 }
 
+static int debug_transaction_begin(struct ref_store *refs,
+				   struct ref_transaction *transaction,
+				   struct strbuf *err)
+{
+	struct debug_ref_store *drefs = (struct debug_ref_store *)refs;
+	int res;
+	transaction->ref_store = drefs->refs;
+	res = drefs->refs->be->transaction_begin(drefs->refs, transaction,
+						   err);
+	trace_printf_key(&trace_refs, "transaction_begin: %d \"%s\"\n", res,
+			 err->buf);
+	return res;
+}
+
 static int debug_transaction_prepare(struct ref_store *refs,
 				     struct ref_transaction *transaction,
 				     struct strbuf *err)
@@ -451,6 +465,7 @@ struct ref_storage_be refs_be_debug = {
 	 * has a function we should also have a wrapper for it here.
 	 * Test the output with "GIT_TRACE_REFS=1".
 	 */
+	.transaction_begin = debug_transaction_begin,
 	.transaction_prepare = debug_transaction_prepare,
 	.transaction_finish = debug_transaction_finish,
 	.transaction_abort = debug_transaction_abort,
diff --git a/refs/files-backend.c b/refs/files-backend.c
index 341354182bb..4a6781af783 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -1219,10 +1219,10 @@ static int files_pack_refs(struct ref_store *ref_store,
 	struct ref_transaction *transaction;
 
 	transaction = ref_store_transaction_begin(refs->packed_ref_store, &err);
-	if (!transaction)
+	if (!transaction) {
+		die("could not start transaction: %s", err.buf);
 		return -1;
-
-	packed_refs_lock(refs->packed_ref_store, LOCK_DIE_ON_ERROR, &err);
+	}
 
 	iter = cache_ref_iterator_begin(get_loose_ref_cache(refs), NULL,
 					the_repository, 0);
@@ -1262,8 +1262,6 @@ static int files_pack_refs(struct ref_store *ref_store,
 
 	ref_transaction_free(transaction);
 
-	packed_refs_unlock(refs->packed_ref_store);
-
 	prune_refs(refs, &refs_to_prune);
 	strbuf_release(&err);
 	return 0;
@@ -1280,16 +1278,10 @@ static int files_delete_refs(struct ref_store *ref_store, const char *msg,
 	if (!refnames->nr)
 		return 0;
 
-	if (packed_refs_lock(refs->packed_ref_store, 0, &err))
-		goto error;
-
 	if (refs_delete_refs(refs->packed_ref_store, msg, refnames, flags)) {
-		packed_refs_unlock(refs->packed_ref_store);
 		goto error;
 	}
 
-	packed_refs_unlock(refs->packed_ref_store);
-
 	for (i = 0; i < refnames->nr; i++) {
 		const char *refname = refnames->items[i].string;
 
@@ -2640,7 +2632,7 @@ out:
 
 struct files_transaction_backend_data {
 	struct ref_transaction *packed_transaction;
-	int packed_refs_locked;
+	int packed_transaction_needed;
 };
 
 /*
@@ -2672,10 +2664,8 @@ static void files_transaction_cleanup(struct files_ref_store *refs,
 			strbuf_release(&err);
 		}
 
-		if (backend_data->packed_refs_locked)
-			packed_refs_unlock(refs->packed_ref_store);
-
 		free(backend_data);
+		transaction->backend_data = NULL;
 	}
 
 	transaction->state = REF_TRANSACTION_CLOSED;
@@ -2804,14 +2794,9 @@ static int files_transaction_prepare(struct ref_store *ref_store,
 	}
 
 	if (packed_transaction) {
-		if (packed_refs_lock(refs->packed_ref_store, 0, err)) {
-			ret = TRANSACTION_GENERIC_ERROR;
-			goto cleanup;
-		}
-		backend_data->packed_refs_locked = 1;
-
-		if (is_packed_transaction_needed(refs->packed_ref_store,
-						 packed_transaction)) {
+		backend_data->packed_transaction_needed = is_packed_transaction_needed(refs->packed_ref_store,
+										       packed_transaction);
+		if (backend_data->packed_transaction_needed) {
 			ret = ref_transaction_prepare(packed_transaction, err);
 			/*
 			 * A failure during the prepare step will abort
@@ -2823,22 +2808,6 @@ static int files_transaction_prepare(struct ref_store *ref_store,
 				ref_transaction_free(packed_transaction);
 				backend_data->packed_transaction = NULL;
 			}
-		} else {
-			/*
-			 * We can skip rewriting the `packed-refs`
-			 * file. But we do need to leave it locked, so
-			 * that somebody else doesn't pack a reference
-			 * that we are trying to delete.
-			 *
-			 * We need to disconnect our transaction from
-			 * backend_data, since the abort (whether successful or
-			 * not) will free it.
-			 */
-			backend_data->packed_transaction = NULL;
-			if (ref_transaction_abort(packed_transaction, err)) {
-				ret = TRANSACTION_GENERIC_ERROR;
-				goto cleanup;
-			}
 		}
 	}
 
@@ -2940,13 +2909,24 @@ static int files_transaction_finish(struct ref_store *ref_store,
 	 * First delete any packed versions of the references, while
 	 * retaining the packed-refs lock:
 	 */
-	if (packed_transaction) {
-		ret = ref_transaction_commit(packed_transaction, err);
-		ref_transaction_free(packed_transaction);
-		packed_transaction = NULL;
-		backend_data->packed_transaction = NULL;
-		if (ret)
-			goto cleanup;
+	if (backend_data->packed_transaction) { 
+		if (backend_data->packed_transaction_needed) {
+			ret = ref_transaction_commit(packed_transaction, err);
+			if (ret)
+				goto cleanup;
+			/* TODO: leaks on error path. */
+			ref_transaction_free(packed_transaction);
+			packed_transaction = NULL;
+			backend_data->packed_transaction = NULL;
+		} else {
+			ret = ref_transaction_abort(packed_transaction, err);
+			if (ret)
+				goto cleanup;
+
+			/* transaction_commit doesn't free the data, but transaction_abort does. Go figure. */
+			packed_transaction = NULL;
+			backend_data->packed_transaction = NULL;
+		}
 	}
 
 	/* Now delete the loose versions of the references: */
@@ -3087,16 +3067,10 @@ static int files_initial_transaction_commit(struct ref_store *ref_store,
 					   NULL);
 	}
 
-	if (packed_refs_lock(refs->packed_ref_store, 0, err)) {
-		ret = TRANSACTION_GENERIC_ERROR;
-		goto cleanup;
-	}
-
 	if (initial_ref_transaction_commit(packed_transaction, err)) {
 		ret = TRANSACTION_GENERIC_ERROR;
 	}
 
-	packed_refs_unlock(refs->packed_ref_store);
 cleanup:
 	if (packed_transaction)
 		ref_transaction_free(packed_transaction);
diff --git a/refs/packed-backend.c b/refs/packed-backend.c
index 59c78d7941f..5df7fa8004f 100644
--- a/refs/packed-backend.c
+++ b/refs/packed-backend.c
@@ -1552,8 +1552,6 @@ int is_packed_transaction_needed(struct ref_store *ref_store,
 
 struct packed_transaction_backend_data {
 	/* True iff the transaction owns the packed-refs lock. */
-	int own_lock;
-
 	struct string_list updates;
 };
 
@@ -1568,9 +1566,8 @@ static void packed_transaction_cleanup(struct packed_ref_store *refs,
 		if (is_tempfile_active(refs->tempfile))
 			delete_tempfile(&refs->tempfile);
 
-		if (data->own_lock && is_lock_file_locked(&refs->lock)) {
+		if (is_lock_file_locked(&refs->lock)) {
 			packed_refs_unlock(&refs->base);
-			data->own_lock = 0;
 		}
 
 		free(data);
@@ -1580,6 +1577,28 @@ static void packed_transaction_cleanup(struct packed_ref_store *refs,
 	transaction->state = REF_TRANSACTION_CLOSED;
 }
 
+static int packed_transaction_begin(struct ref_store *ref_store,
+				    struct ref_transaction *transaction,
+				    struct strbuf *err)
+{
+	struct packed_ref_store *refs = packed_downcast(
+			ref_store,
+			REF_STORE_READ | REF_STORE_WRITE | REF_STORE_ODB,
+			"ref_transaction_begin");
+	struct packed_transaction_backend_data *data;
+
+	CALLOC_ARRAY(data, 1);
+	string_list_init_nodup(&data->updates);
+
+	if (!is_lock_file_locked(&refs->lock)) {
+		if (packed_refs_lock(ref_store, 0, err))
+			/* todo: leaking data */
+			return -1;
+	}
+	transaction->backend_data = data;
+	return 0;
+}
+
 static int packed_transaction_prepare(struct ref_store *ref_store,
 				      struct ref_transaction *transaction,
 				      struct strbuf *err)
@@ -1588,7 +1607,7 @@ static int packed_transaction_prepare(struct ref_store *ref_store,
 			ref_store,
 			REF_STORE_READ | REF_STORE_WRITE | REF_STORE_ODB,
 			"ref_transaction_prepare");
-	struct packed_transaction_backend_data *data;
+	struct packed_transaction_backend_data *data = transaction->backend_data;
 	size_t i;
 	int ret = TRANSACTION_GENERIC_ERROR;
 
@@ -1601,11 +1620,6 @@ static int packed_transaction_prepare(struct ref_store *ref_store,
 	 * do so itself.
 	 */
 
-	CALLOC_ARRAY(data, 1);
-	string_list_init_nodup(&data->updates);
-
-	transaction->backend_data = data;
-
 	/*
 	 * Stick the updates in a string list by refname so that we
 	 * can sort them:
@@ -1623,12 +1637,6 @@ static int packed_transaction_prepare(struct ref_store *ref_store,
 	if (ref_update_reject_duplicates(&data->updates, err))
 		goto failure;
 
-	if (!is_lock_file_locked(&refs->lock)) {
-		if (packed_refs_lock(ref_store, 0, err))
-			goto failure;
-		data->own_lock = 1;
-	}
-
 	if (write_with_updates(refs, &data->updates, err))
 		goto failure;
 
@@ -1758,6 +1766,7 @@ struct ref_storage_be refs_be_packed = {
 	.name = "packed",
 	.init = packed_ref_store_create,
 	.init_db = packed_init_db,
+	.transaction_begin = packed_transaction_begin,
 	.transaction_prepare = packed_transaction_prepare,
 	.transaction_finish = packed_transaction_finish,
 	.transaction_abort = packed_transaction_abort,
diff --git a/refs/packed-backend.h b/refs/packed-backend.h
index 9dd8a344c34..ade3c8a5ac4 100644
--- a/refs/packed-backend.h
+++ b/refs/packed-backend.h
@@ -17,16 +17,6 @@ struct ref_store *packed_ref_store_create(struct repository *repo,
 					  const char *gitdir,
 					  unsigned int store_flags);
 
-/*
- * Lock the packed-refs file for writing. Flags is passed to
- * hold_lock_file_for_update(). Return 0 on success. On errors, write
- * an error message to `err` and return a nonzero value.
- */
-int packed_refs_lock(struct ref_store *ref_store, int flags, struct strbuf *err);
-
-void packed_refs_unlock(struct ref_store *ref_store);
-int packed_refs_is_locked(struct ref_store *ref_store);
-
 /*
  * Return true if `transaction` really needs to be carried out against
  * the specified packed_ref_store, or false if it can be skipped
diff --git a/refs/refs-internal.h b/refs/refs-internal.h
index 9db8aec4da8..87f8e8b51d6 100644
--- a/refs/refs-internal.h
+++ b/refs/refs-internal.h
@@ -531,6 +531,10 @@ typedef struct ref_store *ref_store_init_fn(struct repository *repo,
 
 typedef int ref_init_db_fn(struct ref_store *refs, struct strbuf *err);
 
+typedef int ref_transaction_begin_fn(struct ref_store *refs,
+				     struct ref_transaction *transaction,
+				     struct strbuf *err);
+
 typedef int ref_transaction_prepare_fn(struct ref_store *refs,
 				       struct ref_transaction *transaction,
 				       struct strbuf *err);
@@ -670,6 +674,7 @@ struct ref_storage_be {
 	ref_store_init_fn *init;
 	ref_init_db_fn *init_db;
 
+	ref_transaction_begin_fn *transaction_begin;
 	ref_transaction_prepare_fn *transaction_prepare;
 	ref_transaction_finish_fn *transaction_finish;
 	ref_transaction_abort_fn *transaction_abort;
-- 
gitgitgadget

