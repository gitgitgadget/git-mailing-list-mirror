Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5AAB211712
	for <git@vger.kernel.org>; Thu, 27 Mar 2025 11:13:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743074021; cv=none; b=dOn0KTL+WLgNCJ613lS+XGuytSrjtTThm0mioZgOADEfq1TMyimpfeAaRKdYdIL6ouLiK9Mje8ogp3rOl2tn+xhbgNLi8ANOZ+p73i1VbsPGtyVeTf0siK666D6gJpCKqO3Ww1P0S2YSTUgxmRrRNW8A7lCQfq1YY0nVPgYEufk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743074021; c=relaxed/simple;
	bh=mm4eiPrb3eNE8MLbs8xUuuq2t6tYC9079tuHNYyPi2E=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Ai+cJY2luTyHgzPE8QEmQNv4PhD2bYkFyksSAZCXl90/TKJnvQ+A2ItwgZqGQvGOFPGHKYCKt90D9nnDoXPRxHlOG5iIyf/msUT5IwzTuHvWlfO3eylSjGNziQq3UxOVbfMWdLJL/gkrrLZHokBlexJd44qmjD6h39fXcfJaT8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ue5erzQz; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ue5erzQz"
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-ab771575040so387130766b.1
        for <git@vger.kernel.org>; Thu, 27 Mar 2025 04:13:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743074018; x=1743678818; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HDxuKWn10x3cqxO0xJbPjSuVwFrTfmRGMYm0dKaUsl8=;
        b=Ue5erzQzUjsjuHprIaOgQDucXKqb+s+eu2rGauP8PPrv8sp5lH23tpacFAQ/MpMbh7
         Ze3CFQtH/2sdx2SIkqEuIJKR8UV3EMvg0ZO/g5kGJS7emiVx0j9WUUq5SCWAvoDo5mXI
         jIOA6aJmW9UlGGXJ67nn8M7ZrR1JsHxAbw9wW4y6zBz5aSumedASqMy46Zx22jif6Phc
         7JqV3mO7BL1hVlxPi2EzbivH8kr3Rpe/9I4Qej3VQbO1SIsOMex9niIUfk5pYObZtqfH
         zNhQIZyGrLXvivR/z/IksMdDYrAsl4YkddngNKQ09C0rHiZvh3O/xpYOFT/b0ok67+P5
         wzBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743074018; x=1743678818;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HDxuKWn10x3cqxO0xJbPjSuVwFrTfmRGMYm0dKaUsl8=;
        b=RefcsO6zFAWc8W4LcGR50dd36RNZVVKu+DI0ysQTMmlgTukcVEnR4INMWqDpwqNCSu
         OsVxtAKg1YXV+bq3ZASDJNiYY8DvEiCVyZopKgDs8FKuBq9bU9MtRn0Cl54HXk7qZdLg
         nWIDqmRgXvqIyMjhLZPjQzZoxwkXQKr9TEwkvChKMGRPvcDTaesHSf63qTmWVEcAmN2o
         xsfZbjg1TDVxKNIqUH/P8mwsFypi7riZeZeUu2852kBGDW8/K5ePC6MhA5oDCVSCWR7G
         vgtGW13MG2RFiUPVUA1UJY3TSbdfqZNnon80HIXedne10skbcPnZwjSesWcEdZMpUebV
         PMwQ==
X-Gm-Message-State: AOJu0Yy9mvKdVX6448OGtq/i4gErZRM7OVffrc/40YSW1Bp/HbnhIJDQ
	pQg19Vzl8lCmDIyDKhmajWH6HYIUe7gA5hrMSqmt2bVaZTY+H1Ec
X-Gm-Gg: ASbGncsYDMs714X77St64CATe+whcvv3hCRhAF2Ygvqd08bj6qS41TJ4X7/30OscalQ
	TfLRhp6Iu7nIp13AwJVz5dO/F7qqqj3auFktjLCj58S9tPoU9ojDDZLJolkgNWkHhHZ+teS5q1q
	We4qVvwwqHwT1uauf9qVxrF3e1Y5ahe8bTVVINDsu4eToGye46Xj05qahDJy+kzt8XMUCkFqWwJ
	g2MWeJ1aCDs/EpXsoAzhD+5SS+UTnplzDFw6+K5SM8LWENW7TEGysRAOHnFb5UALgWM1kkeqesy
	f1Pd0u7Q8zUoDms2UNtnhleHXp7seUeOi/GJTvBOPLd8kiw=
X-Google-Smtp-Source: AGHT+IHK5VmCJQ2vQtUabs15nMtLJ6EEfcSBzx/YUKu9jn3g6tS/l3bLWq2Y0OvukWHaGZQO+O00dw==
X-Received: by 2002:a17:907:7f92:b0:ac3:b50c:c94d with SMTP id a640c23a62f3a-ac6f8ba966amr300660766b.28.1743074017654;
        Thu, 27 Mar 2025 04:13:37 -0700 (PDT)
Received: from [127.0.0.2] ([80.242.170.148])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac3ef86e56dsm1195866866b.37.2025.03.27.04.13.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Mar 2025 04:13:37 -0700 (PDT)
From: Karthik Nayak <karthik.188@gmail.com>
Date: Thu, 27 Mar 2025 12:13:31 +0100
Subject: [PATCH v5 7/8] refs: support rejection in batch updates during F/D
 checks
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250327-245-partially-atomic-ref-updates-v5-7-4db2a3e34404@gmail.com>
References: <20250327-245-partially-atomic-ref-updates-v5-0-4db2a3e34404@gmail.com>
In-Reply-To: <20250327-245-partially-atomic-ref-updates-v5-0-4db2a3e34404@gmail.com>
To: git@vger.kernel.org
Cc: jltobler@gmail.com, phillip.wood123@gmail.com, gitster@pobox.com, 
 ps@pks.im, Karthik Nayak <karthik.188@gmail.com>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=13565;
 i=karthik.188@gmail.com; h=from:subject:message-id;
 bh=mm4eiPrb3eNE8MLbs8xUuuq2t6tYC9079tuHNYyPi2E=;
 b=owJ4nAHtARL+kA0DAAoBPtWfJI5GjH8ByyZiAGflMtk3wgTh8eJ10Sxb+BPDbW5oJ/2ovic5R
 RL5LjyrDFYXP4kBswQAAQoAHRYhBFfOTH9jdXEPy2XGBj7VnySORox/BQJn5TLZAAoJED7VnySO
 Rox/DzMMAJPZeaH+WPxYR2hlZTJo0sFffmd/zUYc5wJNXRi09/YgvlbIKGWkA6VEY9WCqZL8RM7
 1aMi3zcwcgiZxTZdLqfZmQBVc7kHBUkHFv7rV7sQuep0iMNYXHYkfRfTQ5s7TyucYkgx/YA+64d
 tpaXkTGHFthS7RH6McqWLRdVYWjwS7/VYPwRCt/HSnbYK4jPhpUq6fz6HdfEAkDkVXBG17MpQ2Q
 a90zKgqdERQemQWgQkcppl+S6WTPfNu92R1+GiPyujDUIH5nCqhno3dk3FsuMSYCTVi2IxoOVHM
 x+R2N6qXe05bk0JaXsvQpymKWvQuiIfYzVTgfUcrg4OPWZkvnp10qgNX8QQBz/C0L+3WC4mIfUY
 1GHQr+QXebUmtR+4rnijwHFcYoW8CH0N3Nieg/JePx7grcCsM9Z535lJFgMaGEoOzteDjDyFikm
 zZQCVQ68bhelMrxDgtKQYwi0GjfHRMdZ7cw5iF2BwI/rvdYVZW6JYwFGNrnNMTf3aHEyK16/B75
 Gg=
X-Developer-Key: i=karthik.188@gmail.com; a=openpgp;
 fpr=57CE4C7F6375710FCB65C6063ED59F248E468C7F

The `refs_verify_refnames_available()` is used to batch check refnames
for F/D conflicts. While this is the more performant alternative than
its individual version, it does not provide rejection capabilities on a
single update level. For batched updates, this would mean a rejection of
the entire transaction whenever one reference has a F/D conflict.

Modify the function to call `ref_transaction_maybe_set_rejected()` to
check if a single update can be rejected. Since this function is only
internally used within 'refs/' and we want to pass in a `struct
ref_transaction *` as a variable. We also move and mark
`refs_verify_refnames_available()` to 'refs-internal.h' to be an
internal function.

Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
---
 refs.c                  | 37 ++++++++++++++++++++++++++++++++++---
 refs.h                  | 12 ------------
 refs/files-backend.c    | 27 ++++++++++++++++++---------
 refs/refs-internal.h    | 16 ++++++++++++++++
 refs/reftable-backend.c | 11 ++++++++---
 5 files changed, 76 insertions(+), 27 deletions(-)

diff --git a/refs.c b/refs.c
index b34ec198f5..41d6247e70 100644
--- a/refs.c
+++ b/refs.c
@@ -2540,6 +2540,7 @@ enum ref_transaction_error refs_verify_refnames_available(struct ref_store *refs
 					  const struct string_list *refnames,
 					  const struct string_list *extras,
 					  const struct string_list *skip,
+					  struct ref_transaction *transaction,
 					  unsigned int initial_transaction,
 					  struct strbuf *err)
 {
@@ -2547,6 +2548,7 @@ enum ref_transaction_error refs_verify_refnames_available(struct ref_store *refs
 	struct strbuf referent = STRBUF_INIT;
 	struct string_list_item *item;
 	struct ref_iterator *iter = NULL;
+	struct strset conflicting_dirnames;
 	struct strset dirnames;
 	int ret = REF_TRANSACTION_ERROR_NAME_CONFLICT;
 
@@ -2557,9 +2559,11 @@ enum ref_transaction_error refs_verify_refnames_available(struct ref_store *refs
 
 	assert(err);
 
+	strset_init(&conflicting_dirnames);
 	strset_init(&dirnames);
 
 	for_each_string_list_item(item, refnames) {
+		const size_t *update_idx = (size_t *)item->util;
 		const char *refname = item->string;
 		const char *extra_refname;
 		struct object_id oid;
@@ -2597,14 +2601,30 @@ enum ref_transaction_error refs_verify_refnames_available(struct ref_store *refs
 				continue;
 
 			if (!initial_transaction &&
-			    !refs_read_raw_ref(refs, dirname.buf, &oid, &referent,
-					       &type, &ignore_errno)) {
+			    (strset_contains(&conflicting_dirnames, dirname.buf) ||
+			     !refs_read_raw_ref(refs, dirname.buf, &oid, &referent,
+						       &type, &ignore_errno))) {
+				if (transaction && ref_transaction_maybe_set_rejected(
+					    transaction, *update_idx,
+					    REF_TRANSACTION_ERROR_NAME_CONFLICT)) {
+					strset_remove(&dirnames, dirname.buf);
+					strset_add(&conflicting_dirnames, dirname.buf);
+					continue;
+				}
+
 				strbuf_addf(err, _("'%s' exists; cannot create '%s'"),
 					    dirname.buf, refname);
 				goto cleanup;
 			}
 
 			if (extras && string_list_has_string(extras, dirname.buf)) {
+				if (transaction && ref_transaction_maybe_set_rejected(
+					    transaction, *update_idx,
+					    REF_TRANSACTION_ERROR_NAME_CONFLICT)) {
+					strset_remove(&dirnames, dirname.buf);
+					continue;
+				}
+
 				strbuf_addf(err, _("cannot process '%s' and '%s' at the same time"),
 					    refname, dirname.buf);
 				goto cleanup;
@@ -2637,6 +2657,11 @@ enum ref_transaction_error refs_verify_refnames_available(struct ref_store *refs
 				    string_list_has_string(skip, iter->refname))
 					continue;
 
+				if (transaction && ref_transaction_maybe_set_rejected(
+					    transaction, *update_idx,
+					    REF_TRANSACTION_ERROR_NAME_CONFLICT))
+					continue;
+
 				strbuf_addf(err, _("'%s' exists; cannot create '%s'"),
 					    iter->refname, refname);
 				goto cleanup;
@@ -2648,6 +2673,11 @@ enum ref_transaction_error refs_verify_refnames_available(struct ref_store *refs
 
 		extra_refname = find_descendant_ref(dirname.buf, extras, skip);
 		if (extra_refname) {
+			if (transaction && ref_transaction_maybe_set_rejected(
+				    transaction, *update_idx,
+				    REF_TRANSACTION_ERROR_NAME_CONFLICT))
+				continue;
+
 			strbuf_addf(err, _("cannot process '%s' and '%s' at the same time"),
 				    refname, extra_refname);
 			goto cleanup;
@@ -2659,6 +2689,7 @@ enum ref_transaction_error refs_verify_refnames_available(struct ref_store *refs
 cleanup:
 	strbuf_release(&referent);
 	strbuf_release(&dirname);
+	strset_clear(&conflicting_dirnames);
 	strset_clear(&dirnames);
 	ref_iterator_free(iter);
 	return ret;
@@ -2679,7 +2710,7 @@ enum ref_transaction_error refs_verify_refname_available(
 	};
 
 	return refs_verify_refnames_available(refs, &refnames, extras, skip,
-					      initial_transaction, err);
+					      NULL, initial_transaction, err);
 }
 
 struct do_for_each_reflog_help {
diff --git a/refs.h b/refs.h
index c48c800478..46a6008e07 100644
--- a/refs.h
+++ b/refs.h
@@ -141,18 +141,6 @@ enum ref_transaction_error refs_verify_refname_available(struct ref_store *refs,
 						 unsigned int initial_transaction,
 						 struct strbuf *err);
 
-/*
- * Same as `refs_verify_refname_available()`, but checking for a list of
- * refnames instead of only a single item. This is more efficient in the case
- * where one needs to check multiple refnames.
- */
-enum ref_transaction_error refs_verify_refnames_available(struct ref_store *refs,
-					  const struct string_list *refnames,
-					  const struct string_list *extras,
-					  const struct string_list *skip,
-					  unsigned int initial_transaction,
-					  struct strbuf *err);
-
 int refs_ref_exists(struct ref_store *refs, const char *refname);
 
 int should_autocreate_reflog(enum log_refs_config log_all_ref_updates,
diff --git a/refs/files-backend.c b/refs/files-backend.c
index 256c69b942..b96a511977 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -677,16 +677,18 @@ static void unlock_ref(struct ref_lock *lock)
  * - Generate informative error messages in the case of failure
  */
 static enum ref_transaction_error lock_raw_ref(struct files_ref_store *refs,
-					       const char *refname,
+					       struct ref_update *update,
+					       size_t update_idx,
 					       int mustexist,
 					       struct string_list *refnames_to_check,
 					       const struct string_list *extras,
 					       struct ref_lock **lock_p,
 					       struct strbuf *referent,
-					       unsigned int *type,
 					       struct strbuf *err)
 {
 	enum ref_transaction_error ret = REF_TRANSACTION_ERROR_GENERIC;
+	const char *refname = update->refname;
+	unsigned int *type = &update->type;
 	struct ref_lock *lock;
 	struct strbuf ref_file = STRBUF_INIT;
 	int attempts_remaining = 3;
@@ -785,6 +787,8 @@ static enum ref_transaction_error lock_raw_ref(struct files_ref_store *refs,
 
 	if (files_read_raw_ref(&refs->base, refname, &lock->old_oid, referent,
 			       type, &failure_errno)) {
+		struct string_list_item *item;
+
 		if (failure_errno == ENOENT) {
 			if (mustexist) {
 				/* Garden variety missing reference. */
@@ -864,7 +868,9 @@ static enum ref_transaction_error lock_raw_ref(struct files_ref_store *refs,
 		 * make sure there is no existing packed ref that conflicts
 		 * with refname. This check is deferred so that we can batch it.
 		 */
-		string_list_append(refnames_to_check, refname);
+		item = string_list_append(refnames_to_check, refname);
+		item->util = xmalloc(sizeof(update_idx));
+		memcpy(item->util, &update_idx, sizeof(update_idx));
 	}
 
 	ret = 0;
@@ -2547,6 +2553,7 @@ struct files_transaction_backend_data {
  */
 static enum ref_transaction_error lock_ref_for_update(struct files_ref_store *refs,
 						      struct ref_update *update,
+						      size_t update_idx,
 						      struct ref_transaction *transaction,
 						      const char *head_ref,
 						      struct string_list *refnames_to_check,
@@ -2575,9 +2582,9 @@ static enum ref_transaction_error lock_ref_for_update(struct files_ref_store *re
 	if (lock) {
 		lock->count++;
 	} else {
-		ret = lock_raw_ref(refs, update->refname, mustexist,
+		ret = lock_raw_ref(refs, update, update_idx, mustexist,
 				   refnames_to_check, &transaction->refnames,
-				   &lock, &referent, &update->type, err);
+				   &lock, &referent, err);
 		if (ret) {
 			char *reason;
 
@@ -2849,7 +2856,7 @@ static int files_transaction_prepare(struct ref_store *ref_store,
 	for (i = 0; i < transaction->nr; i++) {
 		struct ref_update *update = transaction->updates[i];
 
-		ret = lock_ref_for_update(refs, update, transaction,
+		ret = lock_ref_for_update(refs, update, i, transaction,
 					  head_ref, &refnames_to_check,
 					  err);
 		if (ret) {
@@ -2905,7 +2912,8 @@ static int files_transaction_prepare(struct ref_store *ref_store,
 	 * So instead, we accept the race for now.
 	 */
 	if (refs_verify_refnames_available(refs->packed_ref_store, &refnames_to_check,
-					   &transaction->refnames, NULL, 0, err)) {
+					   &transaction->refnames, NULL, transaction,
+					   0, err)) {
 		ret = REF_TRANSACTION_ERROR_NAME_CONFLICT;
 		goto cleanup;
 	}
@@ -2951,7 +2959,7 @@ static int files_transaction_prepare(struct ref_store *ref_store,
 
 cleanup:
 	free(head_ref);
-	string_list_clear(&refnames_to_check, 0);
+	string_list_clear(&refnames_to_check, 1);
 
 	if (ret)
 		files_transaction_cleanup(refs, transaction);
@@ -3097,7 +3105,8 @@ static int files_transaction_finish_initial(struct files_ref_store *refs,
 	}
 
 	if (refs_verify_refnames_available(&refs->base, &refnames_to_check,
-					   &affected_refnames, NULL, 1, err)) {
+					   &affected_refnames, NULL, transaction,
+					   1, err)) {
 		packed_refs_unlock(refs->packed_ref_store);
 		ret = REF_TRANSACTION_ERROR_NAME_CONFLICT;
 		goto cleanup;
diff --git a/refs/refs-internal.h b/refs/refs-internal.h
index 73a5379b73..f868870851 100644
--- a/refs/refs-internal.h
+++ b/refs/refs-internal.h
@@ -806,4 +806,20 @@ enum ref_transaction_error ref_update_check_old_target(const char *referent,
  */
 int ref_update_expects_existing_old_ref(struct ref_update *update);
 
+/*
+ * Same as `refs_verify_refname_available()`, but checking for a list of
+ * refnames instead of only a single item. This is more efficient in the case
+ * where one needs to check multiple refnames.
+ *
+ * If using batched updates, then individual updates are marked rejected,
+ * reference backends are then in charge of not committing those updates.
+ */
+enum ref_transaction_error refs_verify_refnames_available(struct ref_store *refs,
+					  const struct string_list *refnames,
+					  const struct string_list *extras,
+					  const struct string_list *skip,
+					  struct ref_transaction *transaction,
+					  unsigned int initial_transaction,
+					  struct strbuf *err);
+
 #endif /* REFS_REFS_INTERNAL_H */
diff --git a/refs/reftable-backend.c b/refs/reftable-backend.c
index 5db4a108b9..4c3817f4ec 100644
--- a/refs/reftable-backend.c
+++ b/refs/reftable-backend.c
@@ -1074,6 +1074,7 @@ static enum ref_transaction_error prepare_single_update(struct reftable_ref_stor
 							struct ref_transaction *transaction,
 							struct reftable_backend *be,
 							struct ref_update *u,
+							size_t update_idx,
 							struct string_list *refnames_to_check,
 							unsigned int head_type,
 							struct strbuf *head_referent,
@@ -1149,6 +1150,7 @@ static enum ref_transaction_error prepare_single_update(struct reftable_ref_stor
 	if (ret < 0)
 		return REF_TRANSACTION_ERROR_GENERIC;
 	if (ret > 0 && !ref_update_expects_existing_old_ref(u)) {
+		struct string_list_item *item;
 		/*
 		 * The reference does not exist, and we either have no
 		 * old object ID or expect the reference to not exist.
@@ -1158,7 +1160,9 @@ static enum ref_transaction_error prepare_single_update(struct reftable_ref_stor
 		 * can output a proper error message instead of failing
 		 * at a later point.
 		 */
-		string_list_append(refnames_to_check, u->refname);
+		item = string_list_append(refnames_to_check, u->refname);
+		item->util = xmalloc(sizeof(update_idx));
+		memcpy(item->util, &update_idx, sizeof(update_idx));
 
 		/*
 		 * There is no need to write the reference deletion
@@ -1368,7 +1372,7 @@ static int reftable_be_transaction_prepare(struct ref_store *ref_store,
 
 	for (i = 0; i < transaction->nr; i++) {
 		ret = prepare_single_update(refs, tx_data, transaction, be,
-					    transaction->updates[i],
+					    transaction->updates[i], i,
 					    &refnames_to_check, head_type,
 					    &head_referent, &referent, err);
 		if (ret) {
@@ -1384,6 +1388,7 @@ static int reftable_be_transaction_prepare(struct ref_store *ref_store,
 
 	ret = refs_verify_refnames_available(ref_store, &refnames_to_check,
 					     &transaction->refnames, NULL,
+					     transaction,
 					     transaction->flags & REF_TRANSACTION_FLAG_INITIAL,
 					     err);
 	if (ret < 0)
@@ -1402,7 +1407,7 @@ static int reftable_be_transaction_prepare(struct ref_store *ref_store,
 	}
 	strbuf_release(&referent);
 	strbuf_release(&head_referent);
-	string_list_clear(&refnames_to_check, 0);
+	string_list_clear(&refnames_to_check, 1);
 
 	return ret;
 }

-- 
2.48.1

