Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06A9C264A82
	for <git@vger.kernel.org>; Tue,  8 Apr 2025 08:51:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744102291; cv=none; b=L6zEg8UfTYEbReFH0+/nzuRoiUQJLdHYTOsdpF3S+xeuRKfF7b7bdayQqrO691XhgV7qTRfAu6K/tuNCZmLUZZbEPyA0ardjPS5UNanruR8yC41SES9WTJ7koTaXVB+FfyixyX2pOnrmdrKfiPRy9BeZ6zYxDDEN4I6KeSCAKAw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744102291; c=relaxed/simple;
	bh=+WB/Bw6Igd6J0BD//TirlqfNMJybOTnGtUS7iedk7H4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TsfHSIOfGPFjRzcO6jcif7q2mVnfe+JOIQieO6pY+cfswl0Go5QFq38w+dX86x1vOvjCoek0ny/PvUcLKQHHHnJiE8enblUPtTvVAl+7aVrUUZbA7Fps+4j14sg76Qq8QrpU/OSBuic+STZWM12fh1dcZfc3Qtlqh9KVPxDj+qo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PkFIjKQD; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PkFIjKQD"
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-ac25520a289so926168666b.3
        for <git@vger.kernel.org>; Tue, 08 Apr 2025 01:51:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744102287; x=1744707087; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vj4Mc/8uMw29Dvk6KujKiRtTmGi8GK6+3mu9BLFJIBM=;
        b=PkFIjKQD5Rdg/UbXCRcLo6+mfvO0Zz3urll9D9I2Jp3/sf3lZcR5MIlulp1Cif5x9/
         A4u4vFJWnc6Nb3wmOLLSSEl0yrRypswfAVpIdCKGzVEWuotbP8qg4lb006dfQLzrDbCK
         NU5vSVHnMMWFRBEECSJljzk5DGuK5S4xljlZ2iGMsQuUY5Uuira6BQ4l9s0x2RX64dsn
         Bzff/N7HXjcx0/ebJSOM5hBELHpMwHcg1nJPhToOZk6p9iwiHgo3FU3jVgfwEKtPF0YT
         C3IW5lMUjVQWEKrz9CNQkK8iftZl87T0mpZ4pVzwAjPHrlev1PvvC5JkxHbsadj6WBLS
         CLrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744102287; x=1744707087;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vj4Mc/8uMw29Dvk6KujKiRtTmGi8GK6+3mu9BLFJIBM=;
        b=E/aZNvxl5n3C3nneztwy9HRyTh9DWN7oRdOLa24hAnTkip8GRPoiAh+8eg+haMx+Jf
         CqV4NPFxfxFKUmoRrZj39avYmpfVvhOiJiHWp8OLxz8c5R6AEsmmfaBeCecQ/ijS6IpG
         PSjMD+DS1JPKCOPzBkGFOKb7a23Cs3BJAM7OtSpvjzjzHeiaNNpnLYk7aWSO/OsHZC2+
         hQMkgdkjw6rm7sI2ZyBJFoaNuH0kIG9UCCz7Z/Tr74uIFvHITmlq4ffOWIWVeTMkike2
         DCCYhdOfxojn2srCXIRXvX7E/FxqxsRVZb4pHc7ZimRqCyOtiegO1XOQdGNgcP6VdnnS
         pvLw==
X-Gm-Message-State: AOJu0Yx/aNWqBDF5Xy/krSjQmURjs+xFD4M9TtTV8NtD06dsNPRO/73a
	AFw0uI/GY8wg45fu7aIE8gejZmeEQZmpq7brgLFCKbaq/ZEIup7J
X-Gm-Gg: ASbGncsbfl0+ZPvHKRI+LHWOrgfdaQy+eW1BMd/nAcrzWuMf+08WPlE9eS7So3FulDE
	olkTU7eqjhMcDQz5xBKTaxroZOOJwq3np+2XWlJpk23UQUg/IgYST3vJUEg+xY05nsPNAjnyRF3
	VUWorOh6NFTnzE7Mqo4WcssnE+GFJoknhVqptJ7YlgGE8HWy5dvpJpMfAVBcLf732rdEX/DTQqM
	J5iwOXZL55zBYGA3Wl3W+BFBSgk2ZbTHOs/0n78MyAuVgHBQIME0K6xBfqsOq37n9Y00w0iaOdG
	gslbPjAg3wFIKuZSLBYE3DLzRZbKtxkNkGkfVpNZGD1FcGKbKwJ0yN1rEg==
X-Google-Smtp-Source: AGHT+IHZqUcnVOi7c6nifnHYsINx9nfiz5fsN01qTFReRv5rTNDWZhSmJmQylJ5fWNVuH2y4hNZJVQ==
X-Received: by 2002:a17:907:944b:b0:ac7:7d3e:7335 with SMTP id a640c23a62f3a-ac7d6c9fde1mr1414104466b.7.1744102286821;
        Tue, 08 Apr 2025 01:51:26 -0700 (PDT)
Received: from localhost.localdomain ([217.110.80.4])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac7bfe5c804sm890801366b.15.2025.04.08.01.51.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Apr 2025 01:51:26 -0700 (PDT)
From: Karthik Nayak <karthik.188@gmail.com>
To: karthik.188@gmail.com
Cc: git@vger.kernel.org,
	jltobler@gmail.com,
	ps@pks.im,
	jn.avila@free.fr,
	gitster@pobox.com
Subject: [PATCH v6 2/8] refs: move duplicate refname update check to generic layer
Date: Tue,  8 Apr 2025 10:51:06 +0200
Message-ID: <20250408085120.614893-3-karthik.188@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250408085120.614893-1-karthik.188@gmail.com>
References: <20250207-245-partially-atomic-ref-updates-v1-0-e6a3690ff23a@gmail.com>
 <20250408085120.614893-1-karthik.188@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Move the tracking of refnames in `affected_refnames` from individual
backends into the generic layer in 'refs.c'. This centralizes the
duplicate refname detection that was previously handled separately by
each backend.

Make some changes to accommodate this move:

  - Add a `string_list` field `refnames` to `ref_transaction` to contain
    all the references in a transaction. This field is updated whenever
    a new update is added via `ref_transaction_add_update`, so manual
    additions in reference backends are dropped.

  - Modify the backends to use this field internally as needed. The
    backends need to check if an update for refname already exists when
    splitting symrefs or adding an update for 'HEAD'.

  - In the reftable backend, within `reftable_be_transaction_prepare()`,
    move the `string_list_has_string()` check above
    `ref_transaction_add_update()`. Since `ref_transaction_add_update()`
    automatically adds the refname to `transaction->refnames`,
    performing the check after will always return true, so we perform
    the check before adding the update.

This helps reduce duplication of functionality between the backends and
makes it easier to make changes in a more centralized manner.

Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
---
 refs.c                  | 17 +++++++++++
 refs/files-backend.c    | 67 +++++++++--------------------------------
 refs/packed-backend.c   | 25 +--------------
 refs/refs-internal.h    |  2 ++
 refs/reftable-backend.c | 54 +++++++++++----------------------
 5 files changed, 51 insertions(+), 114 deletions(-)

diff --git a/refs.c b/refs.c
index 2ac9d8ebd0..504bf2063e 100644
--- a/refs.c
+++ b/refs.c
@@ -1175,6 +1175,7 @@ struct ref_transaction *ref_store_transaction_begin(struct ref_store *refs,
 	CALLOC_ARRAY(tr, 1);
 	tr->ref_store = refs;
 	tr->flags = flags;
+	string_list_init_dup(&tr->refnames);
 	return tr;
 }
 
@@ -1205,6 +1206,7 @@ void ref_transaction_free(struct ref_transaction *transaction)
 		free((char *)transaction->updates[i]->old_target);
 		free(transaction->updates[i]);
 	}
+	string_list_clear(&transaction->refnames, 0);
 	free(transaction->updates);
 	free(transaction);
 }
@@ -1218,6 +1220,7 @@ struct ref_update *ref_transaction_add_update(
 		const char *committer_info,
 		const char *msg)
 {
+	struct string_list_item *item;
 	struct ref_update *update;
 
 	if (transaction->state != REF_TRANSACTION_OPEN)
@@ -1245,6 +1248,16 @@ struct ref_update *ref_transaction_add_update(
 		update->msg = normalize_reflog_message(msg);
 	}
 
+	/*
+	 * This list is generally used by the backends to avoid duplicates.
+	 * But we do support multiple log updates for a given refname within
+	 * a single transaction.
+	 */
+	if (!(update->flags & REF_LOG_ONLY)) {
+		item = string_list_append(&transaction->refnames, refname);
+		item->util = update;
+	}
+
 	return update;
 }
 
@@ -2405,6 +2418,10 @@ int ref_transaction_prepare(struct ref_transaction *transaction,
 		return -1;
 	}
 
+	string_list_sort(&transaction->refnames);
+	if (ref_update_reject_duplicates(&transaction->refnames, err))
+		return TRANSACTION_GENERIC_ERROR;
+
 	ret = refs->be->transaction_prepare(refs, transaction, err);
 	if (ret)
 		return ret;
diff --git a/refs/files-backend.c b/refs/files-backend.c
index 15559a09c5..58f62ea8a3 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -2378,9 +2378,7 @@ static struct ref_iterator *files_reflog_iterator_begin(struct ref_store *ref_st
  */
 static int split_head_update(struct ref_update *update,
 			     struct ref_transaction *transaction,
-			     const char *head_ref,
-			     struct string_list *affected_refnames,
-			     struct strbuf *err)
+			     const char *head_ref, struct strbuf *err)
 {
 	struct ref_update *new_update;
 
@@ -2398,7 +2396,7 @@ static int split_head_update(struct ref_update *update,
 	 * transaction. This check is O(lg N) in the transaction
 	 * size, but it happens at most once per transaction.
 	 */
-	if (string_list_has_string(affected_refnames, "HEAD")) {
+	if (string_list_has_string(&transaction->refnames, "HEAD")) {
 		/* An entry already existed */
 		strbuf_addf(err,
 			    "multiple updates for 'HEAD' (including one "
@@ -2420,7 +2418,6 @@ static int split_head_update(struct ref_update *update,
 	 */
 	if (strcmp(new_update->refname, "HEAD"))
 		BUG("%s unexpectedly not 'HEAD'", new_update->refname);
-	string_list_insert(affected_refnames, new_update->refname);
 
 	return 0;
 }
@@ -2436,7 +2433,6 @@ static int split_head_update(struct ref_update *update,
 static int split_symref_update(struct ref_update *update,
 			       const char *referent,
 			       struct ref_transaction *transaction,
-			       struct string_list *affected_refnames,
 			       struct strbuf *err)
 {
 	struct ref_update *new_update;
@@ -2448,7 +2444,7 @@ static int split_symref_update(struct ref_update *update,
 	 * size, but it happens at most once per symref in a
 	 * transaction.
 	 */
-	if (string_list_has_string(affected_refnames, referent)) {
+	if (string_list_has_string(&transaction->refnames, referent)) {
 		/* An entry already exists */
 		strbuf_addf(err,
 			    "multiple updates for '%s' (including one "
@@ -2486,15 +2482,6 @@ static int split_symref_update(struct ref_update *update,
 	update->flags |= REF_LOG_ONLY | REF_NO_DEREF;
 	update->flags &= ~REF_HAVE_OLD;
 
-	/*
-	 * Add the referent. This insertion is O(N) in the transaction
-	 * size, but it happens at most once per symref in a
-	 * transaction. Make sure to add new_update->refname, which will
-	 * be valid as long as affected_refnames is in use, and NOT
-	 * referent, which might soon be freed by our caller.
-	 */
-	string_list_insert(affected_refnames, new_update->refname);
-
 	return 0;
 }
 
@@ -2558,7 +2545,6 @@ static int lock_ref_for_update(struct files_ref_store *refs,
 			       struct ref_transaction *transaction,
 			       const char *head_ref,
 			       struct string_list *refnames_to_check,
-			       struct string_list *affected_refnames,
 			       struct strbuf *err)
 {
 	struct strbuf referent = STRBUF_INIT;
@@ -2575,8 +2561,7 @@ static int lock_ref_for_update(struct files_ref_store *refs,
 		update->flags |= REF_DELETING;
 
 	if (head_ref) {
-		ret = split_head_update(update, transaction, head_ref,
-					affected_refnames, err);
+		ret = split_head_update(update, transaction, head_ref, err);
 		if (ret)
 			goto out;
 	}
@@ -2586,9 +2571,8 @@ static int lock_ref_for_update(struct files_ref_store *refs,
 		lock->count++;
 	} else {
 		ret = lock_raw_ref(refs, update->refname, mustexist,
-				   refnames_to_check, affected_refnames,
-				   &lock, &referent,
-				   &update->type, err);
+				   refnames_to_check, &transaction->refnames,
+				   &lock, &referent, &update->type, err);
 		if (ret) {
 			char *reason;
 
@@ -2642,9 +2626,8 @@ static int lock_ref_for_update(struct files_ref_store *refs,
 			 * of processing the split-off update, so we
 			 * don't have to do it here.
 			 */
-			ret = split_symref_update(update,
-						  referent.buf, transaction,
-						  affected_refnames, err);
+			ret = split_symref_update(update, referent.buf,
+						  transaction, err);
 			if (ret)
 				goto out;
 		}
@@ -2799,7 +2782,6 @@ static int files_transaction_prepare(struct ref_store *ref_store,
 			       "ref_transaction_prepare");
 	size_t i;
 	int ret = 0;
-	struct string_list affected_refnames = STRING_LIST_INIT_NODUP;
 	struct string_list refnames_to_check = STRING_LIST_INIT_NODUP;
 	char *head_ref = NULL;
 	int head_type;
@@ -2818,12 +2800,7 @@ static int files_transaction_prepare(struct ref_store *ref_store,
 	transaction->backend_data = backend_data;
 
 	/*
-	 * Fail if a refname appears more than once in the
-	 * transaction. (If we end up splitting up any updates using
-	 * split_symref_update() or split_head_update(), those
-	 * functions will check that the new updates don't have the
-	 * same refname as any existing ones.) Also fail if any of the
-	 * updates use REF_IS_PRUNING without REF_NO_DEREF.
+	 * Fail if any of the updates use REF_IS_PRUNING without REF_NO_DEREF.
 	 */
 	for (i = 0; i < transaction->nr; i++) {
 		struct ref_update *update = transaction->updates[i];
@@ -2831,16 +2808,6 @@ static int files_transaction_prepare(struct ref_store *ref_store,
 		if ((update->flags & REF_IS_PRUNING) &&
 		    !(update->flags & REF_NO_DEREF))
 			BUG("REF_IS_PRUNING set without REF_NO_DEREF");
-
-		if (update->flags & REF_LOG_ONLY)
-			continue;
-
-		string_list_append(&affected_refnames, update->refname);
-	}
-	string_list_sort(&affected_refnames);
-	if (ref_update_reject_duplicates(&affected_refnames, err)) {
-		ret = TRANSACTION_GENERIC_ERROR;
-		goto cleanup;
 	}
 
 	/*
@@ -2882,7 +2849,7 @@ static int files_transaction_prepare(struct ref_store *ref_store,
 
 		ret = lock_ref_for_update(refs, update, transaction,
 					  head_ref, &refnames_to_check,
-					  &affected_refnames, err);
+					  err);
 		if (ret)
 			goto cleanup;
 
@@ -2929,7 +2896,7 @@ static int files_transaction_prepare(struct ref_store *ref_store,
 	 * So instead, we accept the race for now.
 	 */
 	if (refs_verify_refnames_available(refs->packed_ref_store, &refnames_to_check,
-					   &affected_refnames, NULL, 0, err)) {
+					   &transaction->refnames, NULL, 0, err)) {
 		ret = TRANSACTION_NAME_CONFLICT;
 		goto cleanup;
 	}
@@ -2975,7 +2942,6 @@ static int files_transaction_prepare(struct ref_store *ref_store,
 
 cleanup:
 	free(head_ref);
-	string_list_clear(&affected_refnames, 0);
 	string_list_clear(&refnames_to_check, 0);
 
 	if (ret)
@@ -3050,13 +3016,8 @@ static int files_transaction_finish_initial(struct files_ref_store *refs,
 	if (transaction->state != REF_TRANSACTION_PREPARED)
 		BUG("commit called for transaction that is not prepared");
 
-	/* Fail if a refname appears more than once in the transaction: */
-	for (i = 0; i < transaction->nr; i++)
-		if (!(transaction->updates[i]->flags & REF_LOG_ONLY))
-			string_list_append(&affected_refnames,
-					   transaction->updates[i]->refname);
-	string_list_sort(&affected_refnames);
-	if (ref_update_reject_duplicates(&affected_refnames, err)) {
+	string_list_sort(&transaction->refnames);
+	if (ref_update_reject_duplicates(&transaction->refnames, err)) {
 		ret = TRANSACTION_GENERIC_ERROR;
 		goto cleanup;
 	}
@@ -3074,7 +3035,7 @@ static int files_transaction_finish_initial(struct files_ref_store *refs,
 	 * that we are creating already exists.
 	 */
 	if (refs_for_each_rawref(&refs->base, ref_present,
-				 &affected_refnames))
+				 &transaction->refnames))
 		BUG("initial ref transaction called with existing refs");
 
 	packed_transaction = ref_store_transaction_begin(refs->packed_ref_store,
diff --git a/refs/packed-backend.c b/refs/packed-backend.c
index f4c82ba2c7..19220d2e99 100644
--- a/refs/packed-backend.c
+++ b/refs/packed-backend.c
@@ -1622,8 +1622,6 @@ int is_packed_transaction_needed(struct ref_store *ref_store,
 struct packed_transaction_backend_data {
 	/* True iff the transaction owns the packed-refs lock. */
 	int own_lock;
-
-	struct string_list updates;
 };
 
 static void packed_transaction_cleanup(struct packed_ref_store *refs,
@@ -1632,8 +1630,6 @@ static void packed_transaction_cleanup(struct packed_ref_store *refs,
 	struct packed_transaction_backend_data *data = transaction->backend_data;
 
 	if (data) {
-		string_list_clear(&data->updates, 0);
-
 		if (is_tempfile_active(refs->tempfile))
 			delete_tempfile(&refs->tempfile);
 
@@ -1658,7 +1654,6 @@ static int packed_transaction_prepare(struct ref_store *ref_store,
 			REF_STORE_READ | REF_STORE_WRITE | REF_STORE_ODB,
 			"ref_transaction_prepare");
 	struct packed_transaction_backend_data *data;
-	size_t i;
 	int ret = TRANSACTION_GENERIC_ERROR;
 
 	/*
@@ -1671,34 +1666,16 @@ static int packed_transaction_prepare(struct ref_store *ref_store,
 	 */
 
 	CALLOC_ARRAY(data, 1);
-	string_list_init_nodup(&data->updates);
 
 	transaction->backend_data = data;
 
-	/*
-	 * Stick the updates in a string list by refname so that we
-	 * can sort them:
-	 */
-	for (i = 0; i < transaction->nr; i++) {
-		struct ref_update *update = transaction->updates[i];
-		struct string_list_item *item =
-			string_list_append(&data->updates, update->refname);
-
-		/* Store a pointer to update in item->util: */
-		item->util = update;
-	}
-	string_list_sort(&data->updates);
-
-	if (ref_update_reject_duplicates(&data->updates, err))
-		goto failure;
-
 	if (!is_lock_file_locked(&refs->lock)) {
 		if (packed_refs_lock(ref_store, 0, err))
 			goto failure;
 		data->own_lock = 1;
 	}
 
-	if (write_with_updates(refs, &data->updates, err))
+	if (write_with_updates(refs, &transaction->refnames, err))
 		goto failure;
 
 	transaction->state = REF_TRANSACTION_PREPARED;
diff --git a/refs/refs-internal.h b/refs/refs-internal.h
index e5862757a7..92db793026 100644
--- a/refs/refs-internal.h
+++ b/refs/refs-internal.h
@@ -3,6 +3,7 @@
 
 #include "refs.h"
 #include "iterator.h"
+#include "string-list.h"
 
 struct fsck_options;
 struct ref_transaction;
@@ -198,6 +199,7 @@ enum ref_transaction_state {
 struct ref_transaction {
 	struct ref_store *ref_store;
 	struct ref_update **updates;
+	struct string_list refnames;
 	size_t alloc;
 	size_t nr;
 	enum ref_transaction_state state;
diff --git a/refs/reftable-backend.c b/refs/reftable-backend.c
index ae434cd248..a92c9a2f4f 100644
--- a/refs/reftable-backend.c
+++ b/refs/reftable-backend.c
@@ -1076,7 +1076,6 @@ static int reftable_be_transaction_prepare(struct ref_store *ref_store,
 	struct reftable_ref_store *refs =
 		reftable_be_downcast(ref_store, REF_STORE_WRITE|REF_STORE_MAIN, "ref_transaction_prepare");
 	struct strbuf referent = STRBUF_INIT, head_referent = STRBUF_INIT;
-	struct string_list affected_refnames = STRING_LIST_INIT_NODUP;
 	struct string_list refnames_to_check = STRING_LIST_INIT_NODUP;
 	struct reftable_transaction_data *tx_data = NULL;
 	struct reftable_backend *be;
@@ -1101,10 +1100,6 @@ static int reftable_be_transaction_prepare(struct ref_store *ref_store,
 						 transaction->updates[i], err);
 		if (ret)
 			goto done;
-
-		if (!(transaction->updates[i]->flags & REF_LOG_ONLY))
-			string_list_append(&affected_refnames,
-					   transaction->updates[i]->refname);
 	}
 
 	/*
@@ -1116,17 +1111,6 @@ static int reftable_be_transaction_prepare(struct ref_store *ref_store,
 		tx_data->args[i].updates_alloc = tx_data->args[i].updates_expected;
 	}
 
-	/*
-	 * Fail if a refname appears more than once in the transaction.
-	 * This code is taken from the files backend and is a good candidate to
-	 * be moved into the generic layer.
-	 */
-	string_list_sort(&affected_refnames);
-	if (ref_update_reject_duplicates(&affected_refnames, err)) {
-		ret = TRANSACTION_GENERIC_ERROR;
-		goto done;
-	}
-
 	/*
 	 * TODO: it's dubious whether we should reload the stack that "HEAD"
 	 * belongs to or not. In theory, it may happen that we only modify
@@ -1194,14 +1178,12 @@ static int reftable_be_transaction_prepare(struct ref_store *ref_store,
 		    !(u->flags & REF_LOG_ONLY) &&
 		    !(u->flags & REF_UPDATE_VIA_HEAD) &&
 		    !strcmp(rewritten_ref, head_referent.buf)) {
-			struct ref_update *new_update;
-
 			/*
 			 * First make sure that HEAD is not already in the
 			 * transaction. This check is O(lg N) in the transaction
 			 * size, but it happens at most once per transaction.
 			 */
-			if (string_list_has_string(&affected_refnames, "HEAD")) {
+			if (string_list_has_string(&transaction->refnames, "HEAD")) {
 				/* An entry already existed */
 				strbuf_addf(err,
 					    _("multiple updates for 'HEAD' (including one "
@@ -1211,12 +1193,11 @@ static int reftable_be_transaction_prepare(struct ref_store *ref_store,
 				goto done;
 			}
 
-			new_update = ref_transaction_add_update(
-					transaction, "HEAD",
-					u->flags | REF_LOG_ONLY | REF_NO_DEREF,
-					&u->new_oid, &u->old_oid, NULL, NULL, NULL,
-					u->msg);
-			string_list_insert(&affected_refnames, new_update->refname);
+			ref_transaction_add_update(
+				transaction, "HEAD",
+				u->flags | REF_LOG_ONLY | REF_NO_DEREF,
+				&u->new_oid, &u->old_oid, NULL, NULL, NULL,
+				u->msg);
 		}
 
 		ret = reftable_backend_read_ref(be, rewritten_ref,
@@ -1281,6 +1262,15 @@ static int reftable_be_transaction_prepare(struct ref_store *ref_store,
 				if (!strcmp(rewritten_ref, "HEAD"))
 					new_flags |= REF_UPDATE_VIA_HEAD;
 
+				if (string_list_has_string(&transaction->refnames, referent.buf)) {
+					strbuf_addf(err,
+						    _("multiple updates for '%s' (including one "
+						    "via symref '%s') are not allowed"),
+						    referent.buf, u->refname);
+					ret = TRANSACTION_NAME_CONFLICT;
+					goto done;
+				}
+
 				/*
 				 * If we are updating a symref (eg. HEAD), we should also
 				 * update the branch that the symref points to.
@@ -1305,16 +1295,6 @@ static int reftable_be_transaction_prepare(struct ref_store *ref_store,
 				 */
 				u->flags |= REF_LOG_ONLY | REF_NO_DEREF;
 				u->flags &= ~REF_HAVE_OLD;
-
-				if (string_list_has_string(&affected_refnames, new_update->refname)) {
-					strbuf_addf(err,
-						    _("multiple updates for '%s' (including one "
-						    "via symref '%s') are not allowed"),
-						    referent.buf, u->refname);
-					ret = TRANSACTION_NAME_CONFLICT;
-					goto done;
-				}
-				string_list_insert(&affected_refnames, new_update->refname);
 			}
 		}
 
@@ -1383,7 +1363,8 @@ static int reftable_be_transaction_prepare(struct ref_store *ref_store,
 		}
 	}
 
-	ret = refs_verify_refnames_available(ref_store, &refnames_to_check, &affected_refnames, NULL,
+	ret = refs_verify_refnames_available(ref_store, &refnames_to_check,
+					     &transaction->refnames, NULL,
 					     transaction->flags & REF_TRANSACTION_FLAG_INITIAL,
 					     err);
 	if (ret < 0)
@@ -1401,7 +1382,6 @@ static int reftable_be_transaction_prepare(struct ref_store *ref_store,
 			strbuf_addf(err, _("reftable: transaction prepare: %s"),
 				    reftable_error_str(ret));
 	}
-	string_list_clear(&affected_refnames, 0);
 	strbuf_release(&referent);
 	strbuf_release(&head_referent);
 	string_list_clear(&refnames_to_check, 0);
-- 
2.48.1

