Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADD9E210182
	for <git@vger.kernel.org>; Thu, 27 Mar 2025 11:13:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743074017; cv=none; b=c3A+Px9tUNRSwoYDTM4hZUuFAZfrFweLoy9TZgSNoLPu3r2YGQdK/6FwNMf50dE5a2aiVGCNanI748rjgsaGNOu+6BCQrI3x97GoqfIxVzRPjfVYm7oypkpduPEWjiB1kcvSeWx5LXY+vUtSY3Tm2Q86b3e6aZoWw2WkqIDTSE4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743074017; c=relaxed/simple;
	bh=hiHL8d8BBEP9es7ZkYArgA8h8he0YHoVf8T1z1RjTeY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=hybAyyi29fj74SMV+eI8OhIdTbgicudYj1K6FxyiIyRKMW10TFsz0U9xMAKgZAd+sZXI3aucmLJAPRHUZI+0j9pKwMcD3V2A4+zUcX6owyqkSw5Ups+0ZqrmBaFQXn0a40o3vSuOS/JK6s+vaXK6a96cPUFkhiREYO3ekL8tJ/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HLQ4Njhh; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HLQ4Njhh"
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-ac2c663a3daso161037566b.2
        for <git@vger.kernel.org>; Thu, 27 Mar 2025 04:13:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743074013; x=1743678813; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xex57RYlEsGvSpRevntJanMsMffV8Wf2n1O8AcrtwyA=;
        b=HLQ4NjhhPLYvDg8vXvEBmIhYt8BkM3h3TYE7Gnr/ivuQqzBpy+9hPV4a5lWI7UQQHR
         5VrSM0CYjIjMpUS6RzhxsCOD5Nmgm18p/hMHeILUSrN+V53Uy9J2cKRWumi+TpFdU6OV
         M4RPJ6H23cZWMcy2qY2c7R/9yKlhYV2yMRUr5CpLpSCf3uiDzS3peIU/IXF+JDcn72Iv
         sWqedju6Pii7liMQBRC9LeY8/Da2WURf9DqiRzaS8ZMS2x0JwQTE2IoOpc6ndMJ4AYZq
         KETm0BYZtML2l/AEM8b6EHVB3eiBMxuZ9D/R17+PNEvIW3Jb/PoP6AnYxG5MCCIF4tUS
         977A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743074013; x=1743678813;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xex57RYlEsGvSpRevntJanMsMffV8Wf2n1O8AcrtwyA=;
        b=GFq4XOmXraBRBM7HA9x94080riZ6/B8WJdmfeDowmiFuwrSaAtIKQTOwcUPE7tO9cY
         wplWArEZf/ldZ0YJdFpa+JBY1xWyCZl6LV1I7N47d9ggD2Zfy7ZcuLH/0LX+aGTniA/x
         6wtNl0brEyK2wxWLrRI10G4+E8ZJvkQnzGz9oLTqAjwsZtiGAXsJ4Osjh5DavijwR+DP
         ixISHObUwY6Y0UbprU5N5Hf5mc/HFikXLF4vPAopO3CdjYgQTwxz1Y9rMZ33RwU5oE5X
         a79xoLrRDSAlcEGWqB+yboZAzwFSZvY87lj9+nI8Cm/3U2FQPFMtc84S0TfQ+r2Y7wK0
         N24w==
X-Gm-Message-State: AOJu0YzlzhC8VhSMaPMvT3LucMYaPmQLcUPK8XHMctGyWW1S2Pf43HCG
	lSkVf6GGzS+awilX7SUqUY0S4ZfX9P2OJKtT/ktJLlwepqkyQqTc
X-Gm-Gg: ASbGncs3ZQ/WlWKwoLg7nbJWSINN+2GNwepvEzIQ+ZeekHTpkS7Gl5MOTZRIS5hIycE
	ChMK7jc9tTBCcuH8QHFRYvVZTNPOBSUn0wUMj45xka1OtHLHpOOvfyrclklivCUw/aYEQnQ6TPl
	uhJjK+DBVbRYSx/F7KyOKP1FBgHubZ6QzudT4xhHN2H5Qi0wjDy4ZfXpoSWzt4O336WXF6wdA6h
	HRy3ZKuxa4mgmFvp2HsZyluyeivV6c+gLmvTgDvgYsf1Yyy26gJrvhgzLIFpEdyb028YwHAunm/
	Jfo7tkXmjzxkFosGxwZ2pruXgqlxk2RacwfV7apHSvyWl3A=
X-Google-Smtp-Source: AGHT+IG45ueJZnvd+8GuGK7xTnNbtVwnRe4pCqlpZ2scMR4Vp+doLe6szdzvwbFKc7c1GqN3yAarFw==
X-Received: by 2002:a17:907:2d88:b0:ac6:d9fe:a254 with SMTP id a640c23a62f3a-ac6faf197f7mr272289366b.29.1743074012537;
        Thu, 27 Mar 2025 04:13:32 -0700 (PDT)
Received: from [127.0.0.2] ([80.242.170.148])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac3ef86e56dsm1195866866b.37.2025.03.27.04.13.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Mar 2025 04:13:32 -0700 (PDT)
From: Karthik Nayak <karthik.188@gmail.com>
Date: Thu, 27 Mar 2025 12:13:26 +0100
Subject: [PATCH v5 2/8] refs: move duplicate refname update check to
 generic layer
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250327-245-partially-atomic-ref-updates-v5-2-4db2a3e34404@gmail.com>
References: <20250327-245-partially-atomic-ref-updates-v5-0-4db2a3e34404@gmail.com>
In-Reply-To: <20250327-245-partially-atomic-ref-updates-v5-0-4db2a3e34404@gmail.com>
To: git@vger.kernel.org
Cc: jltobler@gmail.com, phillip.wood123@gmail.com, gitster@pobox.com, 
 ps@pks.im, Karthik Nayak <karthik.188@gmail.com>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=18689;
 i=karthik.188@gmail.com; h=from:subject:message-id;
 bh=hiHL8d8BBEP9es7ZkYArgA8h8he0YHoVf8T1z1RjTeY=;
 b=owJ4nAHtARL+kA0DAAoBPtWfJI5GjH8ByyZiAGflMti0i4aG39VcsdhUC5ae9rXhClM/bt4eB
 UIbK9ZPsNIWu4kBswQAAQoAHRYhBFfOTH9jdXEPy2XGBj7VnySORox/BQJn5TLYAAoJED7VnySO
 Rox//g4L/iD3A51y0+CPUKmSVyc+vO38128RZxvV8QUQqkFGW2xZIkxl0A8gIax4wZu84hf0eYU
 +g3EM5UUF1+V6NRarM5+YYLiyFF/u7X+zu5a60J+hGjCcCCRP+j5pUzN2eoeZ3tWafS4DiUcVy9
 9rynuDRlmTDdLMM1CG/FMDardcfO2Dt5ECoq4X8lddWG0CBAziopCiiG0unhJGB9w34HD7y+KF/
 eqBUSmLW613WsbTwTHRaeBEfYsEaKKUN8zgcr/qyh1/N2TOb+oifzIlgM7RYOktJiYsH+0SLnC+
 TwBfficuzSO/VWf/1lfEfpMSernov0LSD3zLu6OXAwA6/GsketpaX5GudGlqGhmkTrFyKlpb6NF
 jIwO9EDGVPmPCXpaqVssFiubiMgdssNt0SWybECpA9I2JiqxVQry+oE32MfeJ40n1l56qGIoj1R
 AqSUeGBOeTTG8zDp7LzZCniNFXyowfPMk+vVeC1hV1IjktkXiqSiYmik9ikgMljly9rGCFBANL4
 XI=
X-Developer-Key: i=karthik.188@gmail.com; a=openpgp;
 fpr=57CE4C7F6375710FCB65C6063ED59F248E468C7F

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
 refs.c                  | 17 +++++++++++++
 refs/files-backend.c    | 67 +++++++++++--------------------------------------
 refs/packed-backend.c   | 25 +-----------------
 refs/refs-internal.h    |  2 ++
 refs/reftable-backend.c | 54 +++++++++++++--------------------------
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

