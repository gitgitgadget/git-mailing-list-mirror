Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63EB8265608
	for <git@vger.kernel.org>; Tue,  8 Apr 2025 08:51:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744102294; cv=none; b=fX04IDL+4Yu95OETp7pMpkyAUGABeK6qC44S4egMUP3QQtIwdQG6aUYtp8/t1S7K/3nJbienhlpucnCPwODl5I1pkQWIwjT+rVs6/2D5V+rSWKdTZhI4scLCILr4i5Ijv3v4HahXbVWlP9cux/HSVVO8hCmLf+VD6gTisyWfPYE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744102294; c=relaxed/simple;
	bh=oEmkVbfhUFZm03hzZhIO0tzjvaoWPEW38jDcoELEC+o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=c4W1iL+II5+w3Y4vIfbnuZcm7S7IrEA5m00fFPTQ9uyPd4vZyez07A9oxhDMFZaMVPz1BVu2jFSIPnSLWf5LahkqpVwgpCXcophADOrTUMTYQyIZ/4/ha3IqU6wbTWzcgRqU1TWIh4MwZkHExS27Sc1HReo1xJoiX4Fro+fiZMc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=i3TuyMPC; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i3TuyMPC"
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-5e6f4b3ebe5so9130565a12.0
        for <git@vger.kernel.org>; Tue, 08 Apr 2025 01:51:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744102291; x=1744707091; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=r8RfUC+wYeTunYskZu0yomo414DoVjxMp4Ux45TGoJ4=;
        b=i3TuyMPCjLa8jqmtIZfYxMIEgqfHVv1FtGJMjkdA0JveJW3FzJUYIVpUelN2/8xraX
         fkRiwakNawe5zzWI+GftQCdjlqXCwV9kcCEwh20gzSdaNH4udGOCp3/aANl/kCv57Pde
         YskFq/Jkk3py6BNHrm8dKK+ho+Y5sT9y3l/8uaEx9qHKhR4KtOie4J1E8PfjDLyqvfIx
         IVe6i4E5WLZfgTTnFUBHhMi3KwqQnWTLfktasC/GgMx00H4Yeuj41mKOoTZua0vgPzrq
         OQag17ND9+4lvMUjbwo7cCgKEDzmYnL9CHo9gFEKiP8xVEs01gZfNwHAgby7UjmPt4oP
         5OVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744102291; x=1744707091;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=r8RfUC+wYeTunYskZu0yomo414DoVjxMp4Ux45TGoJ4=;
        b=N3CcTWDK/8+rRTSWHPTF+VR9rFjf+alPLqXlWteQBeSPV5A2L2T6mUC2rIhSGEkfwR
         i7NQy6y5FuTcL4E2CvmeNmJHbY8IwwB7ijiYZo4PW/JBGwjRHcfQDZFBX91/uyrcqQbj
         LCzyhaBj8lsA62PsxA4GFiHkBh9r9tXnf2XtwHpwda0R6aPbJd4gyJuuFAsTZen3uQmO
         nbdYDZHpRsmZ5PyR9hbkVM4YxqpcWJu5GfXlvoh3xbh3vWOlS8+wwAg8RSSPK8V8MpUw
         0K1dYnnWN0nrDTAjvVk2RI0EdnRPX/+Ps4BvqMj/nFqwulPJ6egI9+8yYzL6TQ2Kh5yW
         Ig5g==
X-Gm-Message-State: AOJu0YytGwmvAeSwfO8GOMCizU0ovm/pP7Zkr2UOHEcR7Z6NAhLvPiyb
	cQYGPVx2EbpjRQHo9czD5RWekc0NXEXhAT09RvtnAhtiJF+2S1Hibv6TzCs5
X-Gm-Gg: ASbGncuXssXlGHnEmNx+Jjk61tlHkAJAP763W1+a8Pk855HF3HSGz2NtBsEG09Ir1iF
	I3/u2k6XxmgtkzuRebWPidjwHINsFwjbkorVrDcuPrMOaEZ1gysnNGxLRaGNhFuhY6f5CCe3/sT
	x3SpHgOV/8Wxi02QNZPHftp9mZt0wfbOPDirqEYbOpQNCB3dMIzUlkr2yuc1WeRkOytXFE1CLdG
	U1iqb/Mj3RTco3mb3iNbkRONACqK+TdI3GNHYIC5bo5DvhaKZ9BOkSbnW4RABVoSHYaMiZXUjl9
	R3M+GBTwxbw+XD/agtfsSf06uRsScIGiS41p3x39qVEQJsZzMYcvtLsx2w==
X-Google-Smtp-Source: AGHT+IHgBYlboiT1MhkskLEtXcZ0c2nKiOEnRGP4BJv7T2UE+OTeh/W6yJuNmsCoOw1hWcMglpUfuw==
X-Received: by 2002:a17:907:3da2:b0:ac6:bca0:eb70 with SMTP id a640c23a62f3a-ac7d1b9fe8dmr1497515466b.56.1744102290346;
        Tue, 08 Apr 2025 01:51:30 -0700 (PDT)
Received: from localhost.localdomain ([217.110.80.4])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac7bfe5c804sm890801366b.15.2025.04.08.01.51.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Apr 2025 01:51:29 -0700 (PDT)
From: Karthik Nayak <karthik.188@gmail.com>
To: karthik.188@gmail.com
Cc: git@vger.kernel.org,
	jltobler@gmail.com,
	ps@pks.im,
	jn.avila@free.fr,
	gitster@pobox.com
Subject: [PATCH v6 6/8] refs: implement batch reference update support
Date: Tue,  8 Apr 2025 10:51:10 +0200
Message-ID: <20250408085120.614893-7-karthik.188@gmail.com>
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

Git supports making reference updates with or without transactions.
Updates with transactions are generally better optimized. But
transactions are all or nothing. This means, if a user wants to batch
updates to take advantage of the optimizations without the hard
requirement that all updates must succeed, there is no way currently to
do so. Particularly with the reftable backend where batching multiple
reference updates is more efficient than performing them sequentially.

Introduce batched update support with a new flag,
'REF_TRANSACTION_ALLOW_FAILURE'. Batched updates while different from
transactions, use the transaction infrastructure under the hood. When
enabled, this flag allows individual reference updates that would
typically cause the entire transaction to fail due to non-system-related
errors to be marked as rejected while permitting other updates to
proceed. System errors referred by 'REF_TRANSACTION_ERROR_GENERIC'
continue to result in the entire transaction failing. This approach
enhances flexibility while preserving transactional integrity where
necessary.

The implementation introduces several key components:

  - Add 'rejection_err' field to struct `ref_update` to track failed
    updates with failure reason.

  - Add a new struct `ref_transaction_rejections` and a field within
    `ref_transaction` to this struct to allow quick iteration over
    rejected updates.

  - Modify reference backends (files, packed, reftable) to handle
    partial transactions by using `ref_transaction_set_rejected()`
    instead of failing the entire transaction when
    `REF_TRANSACTION_ALLOW_FAILURE` is set.

  - Add `ref_transaction_for_each_rejected_update()` to let callers
    examine which updates were rejected and why.

This foundational change enables batched update support throughout the
reference subsystem. A following commit will expose this capability to
users by adding a `--batch-updates` flag to 'git-update-ref(1)',
providing both a user-facing feature and a testable implementation.

Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
---
 refs.c                  | 61 +++++++++++++++++++++++++++++++++++++++++
 refs.h                  | 22 +++++++++++++++
 refs/files-backend.c    | 12 +++++++-
 refs/packed-backend.c   | 27 ++++++++++++++++--
 refs/refs-internal.h    | 26 ++++++++++++++++++
 refs/reftable-backend.c | 12 +++++++-
 6 files changed, 156 insertions(+), 4 deletions(-)

diff --git a/refs.c b/refs.c
index 3d0b53d56e..b34ec198f5 100644
--- a/refs.c
+++ b/refs.c
@@ -1176,6 +1176,10 @@ struct ref_transaction *ref_store_transaction_begin(struct ref_store *refs,
 	tr->ref_store = refs;
 	tr->flags = flags;
 	string_list_init_dup(&tr->refnames);
+
+	if (flags & REF_TRANSACTION_ALLOW_FAILURE)
+		CALLOC_ARRAY(tr->rejections, 1);
+
 	return tr;
 }
 
@@ -1206,11 +1210,45 @@ void ref_transaction_free(struct ref_transaction *transaction)
 		free((char *)transaction->updates[i]->old_target);
 		free(transaction->updates[i]);
 	}
+
+	if (transaction->rejections)
+		free(transaction->rejections->update_indices);
+	free(transaction->rejections);
+
 	string_list_clear(&transaction->refnames, 0);
 	free(transaction->updates);
 	free(transaction);
 }
 
+int ref_transaction_maybe_set_rejected(struct ref_transaction *transaction,
+				       size_t update_idx,
+				       enum ref_transaction_error err)
+{
+	if (update_idx >= transaction->nr)
+		BUG("trying to set rejection on invalid update index");
+
+	if (!(transaction->flags & REF_TRANSACTION_ALLOW_FAILURE))
+		return 0;
+
+	if (!transaction->rejections)
+		BUG("transaction not inititalized with failure support");
+
+	/*
+	 * Don't accept generic errors, since these errors are not user
+	 * input related.
+	 */
+	if (err == REF_TRANSACTION_ERROR_GENERIC)
+		return 0;
+
+	transaction->updates[update_idx]->rejection_err = err;
+	ALLOC_GROW(transaction->rejections->update_indices,
+		   transaction->rejections->nr + 1,
+		   transaction->rejections->alloc);
+	transaction->rejections->update_indices[transaction->rejections->nr++] = update_idx;
+
+	return 1;
+}
+
 struct ref_update *ref_transaction_add_update(
 		struct ref_transaction *transaction,
 		const char *refname, unsigned int flags,
@@ -1236,6 +1274,7 @@ struct ref_update *ref_transaction_add_update(
 	transaction->updates[transaction->nr++] = update;
 
 	update->flags = flags;
+	update->rejection_err = 0;
 
 	update->new_target = xstrdup_or_null(new_target);
 	update->old_target = xstrdup_or_null(old_target);
@@ -2728,6 +2767,28 @@ void ref_transaction_for_each_queued_update(struct ref_transaction *transaction,
 	}
 }
 
+void ref_transaction_for_each_rejected_update(struct ref_transaction *transaction,
+					      ref_transaction_for_each_rejected_update_fn cb,
+					      void *cb_data)
+{
+	if (!transaction->rejections)
+		return;
+
+	for (size_t i = 0; i < transaction->rejections->nr; i++) {
+		size_t update_index = transaction->rejections->update_indices[i];
+		struct ref_update *update = transaction->updates[update_index];
+
+		if (!update->rejection_err)
+			continue;
+
+		cb(update->refname,
+		   (update->flags & REF_HAVE_OLD) ? &update->old_oid : NULL,
+		   (update->flags & REF_HAVE_NEW) ? &update->new_oid : NULL,
+		   update->old_target, update->new_target,
+		   update->rejection_err, cb_data);
+	}
+}
+
 int refs_delete_refs(struct ref_store *refs, const char *logmsg,
 		     struct string_list *refnames, unsigned int flags)
 {
diff --git a/refs.h b/refs.h
index f009cdae7d..c48c800478 100644
--- a/refs.h
+++ b/refs.h
@@ -667,6 +667,13 @@ enum ref_transaction_flag {
 	 * either be absent or null_oid.
 	 */
 	REF_TRANSACTION_FLAG_INITIAL = (1 << 0),
+
+	/*
+	 * The transaction mechanism by default fails all updates if any conflict
+	 * is detected. This flag allows transactions to partially apply updates
+	 * while rejecting updates which do not match the expected state.
+	 */
+	REF_TRANSACTION_ALLOW_FAILURE = (1 << 1),
 };
 
 /*
@@ -897,6 +904,21 @@ void ref_transaction_for_each_queued_update(struct ref_transaction *transaction,
 					    ref_transaction_for_each_queued_update_fn cb,
 					    void *cb_data);
 
+/*
+ * Execute the given callback function for each of the reference updates which
+ * have been rejected in the given transaction.
+ */
+typedef void ref_transaction_for_each_rejected_update_fn(const char *refname,
+							 const struct object_id *old_oid,
+							 const struct object_id *new_oid,
+							 const char *old_target,
+							 const char *new_target,
+							 enum ref_transaction_error err,
+							 void *cb_data);
+void ref_transaction_for_each_rejected_update(struct ref_transaction *transaction,
+					      ref_transaction_for_each_rejected_update_fn cb,
+					      void *cb_data);
+
 /*
  * Free `*transaction` and all associated data.
  */
diff --git a/refs/files-backend.c b/refs/files-backend.c
index 4f27f7652c..256c69b942 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -2852,8 +2852,15 @@ static int files_transaction_prepare(struct ref_store *ref_store,
 		ret = lock_ref_for_update(refs, update, transaction,
 					  head_ref, &refnames_to_check,
 					  err);
-		if (ret)
+		if (ret) {
+			if (ref_transaction_maybe_set_rejected(transaction, i, ret)) {
+				strbuf_reset(err);
+				ret = 0;
+
+				continue;
+			}
 			goto cleanup;
+		}
 
 		if (update->flags & REF_DELETING &&
 		    !(update->flags & REF_LOG_ONLY) &&
@@ -3151,6 +3158,9 @@ static int files_transaction_finish(struct ref_store *ref_store,
 		struct ref_update *update = transaction->updates[i];
 		struct ref_lock *lock = update->backend_data;
 
+		if (update->rejection_err)
+			continue;
+
 		if (update->flags & REF_NEEDS_COMMIT ||
 		    update->flags & REF_LOG_ONLY) {
 			if (parse_and_write_reflog(refs, update, lock, err)) {
diff --git a/refs/packed-backend.c b/refs/packed-backend.c
index d90bd815a3..debca86a2b 100644
--- a/refs/packed-backend.c
+++ b/refs/packed-backend.c
@@ -1327,10 +1327,11 @@ static int packed_ref_store_remove_on_disk(struct ref_store *ref_store,
  * remain locked when it is done.
  */
 static enum ref_transaction_error write_with_updates(struct packed_ref_store *refs,
-						     struct string_list *updates,
+						     struct ref_transaction *transaction,
 						     struct strbuf *err)
 {
 	enum ref_transaction_error ret = REF_TRANSACTION_ERROR_GENERIC;
+	struct string_list *updates = &transaction->refnames;
 	struct ref_iterator *iter = NULL;
 	size_t i;
 	int ok;
@@ -1411,6 +1412,13 @@ static enum ref_transaction_error write_with_updates(struct packed_ref_store *re
 						    "reference already exists",
 						    update->refname);
 					ret = REF_TRANSACTION_ERROR_CREATE_EXISTS;
+
+					if (ref_transaction_maybe_set_rejected(transaction, i, ret)) {
+						strbuf_reset(err);
+						ret = 0;
+						continue;
+					}
+
 					goto error;
 				} else if (!oideq(&update->old_oid, iter->oid)) {
 					strbuf_addf(err, "cannot update ref '%s': "
@@ -1419,6 +1427,13 @@ static enum ref_transaction_error write_with_updates(struct packed_ref_store *re
 						    oid_to_hex(iter->oid),
 						    oid_to_hex(&update->old_oid));
 					ret = REF_TRANSACTION_ERROR_INCORRECT_OLD_VALUE;
+
+					if (ref_transaction_maybe_set_rejected(transaction, i, ret)) {
+						strbuf_reset(err);
+						ret = 0;
+						continue;
+					}
+
 					goto error;
 				}
 			}
@@ -1456,6 +1471,13 @@ static enum ref_transaction_error write_with_updates(struct packed_ref_store *re
 					    update->refname,
 					    oid_to_hex(&update->old_oid));
 				ret = REF_TRANSACTION_ERROR_NONEXISTENT_REF;
+
+				if (ref_transaction_maybe_set_rejected(transaction, i, ret)) {
+					strbuf_reset(err);
+					ret = 0;
+					continue;
+				}
+
 				goto error;
 			}
 		}
@@ -1521,6 +1543,7 @@ static enum ref_transaction_error write_with_updates(struct packed_ref_store *re
 write_error:
 	strbuf_addf(err, "error writing to %s: %s",
 		    get_tempfile_path(refs->tempfile), strerror(errno));
+	ret = REF_TRANSACTION_ERROR_GENERIC;
 
 error:
 	ref_iterator_free(iter);
@@ -1679,7 +1702,7 @@ static int packed_transaction_prepare(struct ref_store *ref_store,
 		data->own_lock = 1;
 	}
 
-	ret = write_with_updates(refs, &transaction->refnames, err);
+	ret = write_with_updates(refs, transaction, err);
 	if (ret)
 		goto failure;
 
diff --git a/refs/refs-internal.h b/refs/refs-internal.h
index 3f1d19abd9..73a5379b73 100644
--- a/refs/refs-internal.h
+++ b/refs/refs-internal.h
@@ -123,6 +123,12 @@ struct ref_update {
 	 */
 	uint64_t index;
 
+	/*
+	 * Used in batched reference updates to mark if a given update
+	 * was rejected.
+	 */
+	enum ref_transaction_error rejection_err;
+
 	/*
 	 * If this ref_update was split off of a symref update via
 	 * split_symref_update(), then this member points at that
@@ -142,6 +148,13 @@ int refs_read_raw_ref(struct ref_store *ref_store, const char *refname,
 		      struct object_id *oid, struct strbuf *referent,
 		      unsigned int *type, int *failure_errno);
 
+/*
+ * Mark a given update as rejected with a given reason.
+ */
+int ref_transaction_maybe_set_rejected(struct ref_transaction *transaction,
+				       size_t update_idx,
+				       enum ref_transaction_error err);
+
 /*
  * Add a ref_update with the specified properties to transaction, and
  * return a pointer to the new object. This function does not verify
@@ -183,6 +196,18 @@ enum ref_transaction_state {
 	REF_TRANSACTION_CLOSED   = 2
 };
 
+/*
+ * Data structure to hold indices of updates which were rejected, for batched
+ * reference updates. While the updates themselves hold the rejection error,
+ * this structure allows a transaction to iterate only over the rejected
+ * updates.
+ */
+struct ref_transaction_rejections {
+	size_t *update_indices;
+	size_t alloc;
+	size_t nr;
+};
+
 /*
  * Data structure for holding a reference transaction, which can
  * consist of checks and updates to multiple references, carried out
@@ -195,6 +220,7 @@ struct ref_transaction {
 	size_t alloc;
 	size_t nr;
 	enum ref_transaction_state state;
+	struct ref_transaction_rejections *rejections;
 	void *backend_data;
 	unsigned int flags;
 	uint64_t max_index;
diff --git a/refs/reftable-backend.c b/refs/reftable-backend.c
index bd6b042103..5db4a108b9 100644
--- a/refs/reftable-backend.c
+++ b/refs/reftable-backend.c
@@ -1371,8 +1371,15 @@ static int reftable_be_transaction_prepare(struct ref_store *ref_store,
 					    transaction->updates[i],
 					    &refnames_to_check, head_type,
 					    &head_referent, &referent, err);
-		if (ret)
+		if (ret) {
+			if (ref_transaction_maybe_set_rejected(transaction, i, ret)) {
+				strbuf_reset(err);
+				ret = 0;
+
+				continue;
+			}
 			goto done;
+		}
 	}
 
 	ret = refs_verify_refnames_available(ref_store, &refnames_to_check,
@@ -1454,6 +1461,9 @@ static int write_transaction_table(struct reftable_writer *writer, void *cb_data
 		struct reftable_transaction_update *tx_update = &arg->updates[i];
 		struct ref_update *u = tx_update->update;
 
+		if (u->rejection_err)
+			continue;
+
 		/*
 		 * Write a reflog entry when updating a ref to point to
 		 * something new in either of the following cases:
-- 
2.48.1

