Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A596CE79D0
	for <git@archiver.kernel.org>; Wed, 20 Sep 2023 13:03:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236373AbjITNDK (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 20 Sep 2023 09:03:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236064AbjITNDD (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 20 Sep 2023 09:03:03 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E1E3A9
        for <git@vger.kernel.org>; Wed, 20 Sep 2023 06:02:56 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id 5b1f17b1804b1-404573e6c8fso69663855e9.1
        for <git@vger.kernel.org>; Wed, 20 Sep 2023 06:02:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695214975; x=1695819775; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TUzcKv7bpzuoZ4WoA1yzcTbJHrG2SeGYPDSilNhxWH0=;
        b=V5o3iPwMCFdGLV7hppmkDeYHzHcWxusudz+n7/ex1tHwPPloNEd8QJH3bpoLFu7QJ9
         YBXa1I+Z9tzO/UBISajefxQAzP9Sv4XgDVmtcjbT0S4zMsgudkHgzB/FjUDejYXw3Bi+
         otqeBlEVogkJUT4bBkA/qmKzaBmMe5ktP7uG75fPeUVLrzQiv7Cp39eE6VN/f4rsT9S5
         /GF7RbfAKBZGNVMyEcwObVeI/0+iGpqMpyhzOr//zJ3zvBu7q24cCpQX5huCPHBT/6GZ
         GO3/kwmuRILWyHYaqB181nsgEw1GWpW2kAeaC/2jMsLosmUvlParQFbY7jqywW/kR1qv
         1nUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695214975; x=1695819775;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TUzcKv7bpzuoZ4WoA1yzcTbJHrG2SeGYPDSilNhxWH0=;
        b=Gpebeocf8AcRrX1F6zT0hrlHfZRZX6DK+ZFuN/a4ZzN0ancD8T2v+bKyW5k9eFgSzL
         E5f1oenZIABNXykEGjFvD8Nw2GeznblGdQDpgcUP4Qb9cxeASNrwkaxo9C3dUmxy2sEN
         +TmfeueFjqM8dKS6jErMZ3tK91yN9FnCN+iXDanKlRpT1qd26xjhhx2YsmltUDSrKKGJ
         0KvrqT7++AtRYo8rjEw8YJggAHBh6ZAwstEszxcjhE513yMoo/tQ3anZmN8jFelNYp34
         2tacDUzgDRnCYX2C5vAijyIWTmrmK6JjCwR6pu/7A+/mMAh5ghIFnvNiQrSRIZuFUk2N
         PiVQ==
X-Gm-Message-State: AOJu0YysAr1OJo4srfHQDyIpW+AUksvvSabjzaE4/L8tny76XibmJCJh
        L4+DeSk0iqiyQJX7yu00Tq3ReXcq1Ws=
X-Google-Smtp-Source: AGHT+IHXXbueFfw0cb3loBz5bDzdMQ1KE2g87pC6ZTrxnHoj4PaYlksHlr4w6Jlw6xQUXajwuBtJkg==
X-Received: by 2002:a05:600c:259:b0:3fb:fa9f:5292 with SMTP id 25-20020a05600c025900b003fbfa9f5292mr2400486wmj.25.1695214973641;
        Wed, 20 Sep 2023 06:02:53 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id g33-20020a05600c4ca100b004051d5b2cf1sm1902423wmp.12.2023.09.20.06.02.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Sep 2023 06:02:53 -0700 (PDT)
Message-ID: <8dedb23eb69493c272dcaaffd98b15a44546c6f9.1695214968.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1574.v2.git.git.1695214968.gitgitgadget@gmail.com>
References: <pull.1574.git.git.1695059978.gitgitgadget@gmail.com>
        <pull.1574.v2.git.git.1695214968.gitgitgadget@gmail.com>
From:   "Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 20 Sep 2023 13:02:45 +0000
Subject: [PATCH v2 3/6] refs: push lock management into packed backend
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Han-Wen Nienhuys <hanwen@google.com>,
        Han-Wen Nienhuys <hanwenn@gmail.com>,
        Han-Wen Nienhuys <hanwen@google.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Han-Wen Nienhuys <hanwen@google.com>

Take packed-refs.lock in the transaction_begin of the packed backend.

This decouples the files backend from the packed backend, allowing the
latter to be swapped out by another ref backend.

Signed-off-by: Han-Wen Nienhuys <hanwen@google.com>
---
 refs.c                |  5 ++-
 refs/files-backend.c  | 78 +++++++++++++++----------------------------
 refs/packed-backend.c | 55 ++++++++++++------------------
 refs/packed-backend.h | 10 ------
 4 files changed, 50 insertions(+), 98 deletions(-)

diff --git a/refs.c b/refs.c
index f7ba3e56284..0611197dc6e 100644
--- a/refs.c
+++ b/refs.c
@@ -2320,10 +2320,9 @@ int ref_transaction_abort(struct ref_transaction *transaction,
 	int ret = 0;
 
 	switch (transaction->state) {
-	case REF_TRANSACTION_OPEN:
-		/* No need to abort explicitly. */
-		break;
 	case REF_TRANSACTION_PREPARED:
+	case REF_TRANSACTION_OPEN:
+		/* an OPEN transactions may have a lock. */
 		ret = refs->be->transaction_abort(refs, transaction, err);
 		break;
 	case REF_TRANSACTION_CLOSED:
diff --git a/refs/files-backend.c b/refs/files-backend.c
index d83eea8b408..43c1882be3c 100644
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
@@ -2811,14 +2801,9 @@ static int files_transaction_prepare(struct ref_store *ref_store,
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
@@ -2830,22 +2815,6 @@ static int files_transaction_prepare(struct ref_store *ref_store,
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
 
@@ -2947,13 +2916,24 @@ static int files_transaction_finish(struct ref_store *ref_store,
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
+
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
@@ -3094,16 +3074,10 @@ static int files_initial_transaction_commit(struct ref_store *ref_store,
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
index 4f5b1025605..f8b27f1afe5 100644
--- a/refs/packed-backend.c
+++ b/refs/packed-backend.c
@@ -1153,7 +1153,7 @@ static int write_packed_entry(FILE *fh, const char *refname,
 	return 0;
 }
 
-int packed_refs_lock(struct ref_store *ref_store, int flags, struct strbuf *err)
+static int packed_refs_lock(struct ref_store *ref_store, int flags, struct strbuf *err)
 {
 	struct packed_ref_store *refs =
 		packed_downcast(ref_store, REF_STORE_WRITE | REF_STORE_MAIN,
@@ -1212,7 +1212,7 @@ int packed_refs_lock(struct ref_store *ref_store, int flags, struct strbuf *err)
 	return 0;
 }
 
-void packed_refs_unlock(struct ref_store *ref_store)
+static void packed_refs_unlock(struct ref_store *ref_store)
 {
 	struct packed_ref_store *refs = packed_downcast(
 			ref_store,
@@ -1224,16 +1224,6 @@ void packed_refs_unlock(struct ref_store *ref_store)
 	rollback_lock_file(&refs->lock);
 }
 
-int packed_refs_is_locked(struct ref_store *ref_store)
-{
-	struct packed_ref_store *refs = packed_downcast(
-			ref_store,
-			REF_STORE_READ | REF_STORE_WRITE,
-			"packed_refs_is_locked");
-
-	return is_lock_file_locked(&refs->lock);
-}
-
 /*
  * The packed-refs header line that we write out. Perhaps other traits
  * will be added later.
@@ -1552,8 +1542,6 @@ int is_packed_transaction_needed(struct ref_store *ref_store,
 
 struct packed_transaction_backend_data {
 	/* True iff the transaction owns the packed-refs lock. */
-	int own_lock;
-
 	struct string_list updates;
 };
 
@@ -1568,9 +1556,8 @@ static void packed_transaction_cleanup(struct packed_ref_store *refs,
 		if (is_tempfile_active(refs->tempfile))
 			delete_tempfile(&refs->tempfile);
 
-		if (data->own_lock && is_lock_file_locked(&refs->lock)) {
+		if (is_lock_file_locked(&refs->lock)) {
 			packed_refs_unlock(&refs->base);
-			data->own_lock = 0;
 		}
 
 		free(data);
@@ -1580,12 +1567,25 @@ static void packed_transaction_cleanup(struct packed_ref_store *refs,
 	transaction->state = REF_TRANSACTION_CLOSED;
 }
 
-
 static struct ref_transaction *packed_transaction_begin(struct ref_store *ref_store,
-							struct strbuf *err) {
-	struct ref_transaction *tr;
-	CALLOC_ARRAY(tr, 1);
-	return tr;
+				    struct strbuf *err)
+{
+	struct packed_ref_store *refs = packed_downcast(
+			ref_store,
+			REF_STORE_READ | REF_STORE_WRITE | REF_STORE_ODB,
+			"ref_transaction_begin");
+	struct packed_transaction_backend_data *data;
+	struct ref_transaction *transaction;
+
+	if (!is_lock_file_locked(&refs->lock)) {
+		if (packed_refs_lock(ref_store, 0, err))
+			return NULL;
+	}
+	CALLOC_ARRAY(transaction, 1);
+	CALLOC_ARRAY(data, 1);
+	string_list_init_nodup(&data->updates);
+	transaction->backend_data = data;
+	return transaction;
 }
 
 static int packed_transaction_prepare(struct ref_store *ref_store,
@@ -1596,7 +1596,7 @@ static int packed_transaction_prepare(struct ref_store *ref_store,
 			ref_store,
 			REF_STORE_READ | REF_STORE_WRITE | REF_STORE_ODB,
 			"ref_transaction_prepare");
-	struct packed_transaction_backend_data *data;
+	struct packed_transaction_backend_data *data = transaction->backend_data;
 	size_t i;
 	int ret = TRANSACTION_GENERIC_ERROR;
 
@@ -1609,11 +1609,6 @@ static int packed_transaction_prepare(struct ref_store *ref_store,
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
@@ -1631,12 +1626,6 @@ static int packed_transaction_prepare(struct ref_store *ref_store,
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
-- 
gitgitgadget

