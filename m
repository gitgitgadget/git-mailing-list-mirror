Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E29C6252901
	for <git@vger.kernel.org>; Wed,  5 Mar 2025 17:39:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741196365; cv=none; b=mMFm+WdGeimC6pzjEhtJNwpoUqx30wwytFpf1BHYgFFkZ9hD9rdwIaH63tYlq4fWSDITRTmmKNSGnxEufsTIy3Sx9xjTsk5GFMlPDlN9R5J/X3j+tCVGQJ0H+ks7vHfFwr7jrAjQXaBFJWAzQI8kHRYQTVkRwcovhjZjuJReQjk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741196365; c=relaxed/simple;
	bh=1uVRVC5AK0r3l5poScKiYx9wQtnJFVTfYadriahjgZY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=qVjqQ/nRN720NfhR/D8IMGxHr8LGA6bIzR6u2Ds3F2qcR7y0DsVD1osrlQuhqbDdg2fGLzCs0eUKDGNeJXMIRdPK15kEZgfrrqUPKNRMkbRqXEoJ4/OPZ2lvdMtVyYPd4p0Ps8v+AnG0sgCxsRUBQ6VquxqjB1gThVq/vQCkVZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WOpsa7sc; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WOpsa7sc"
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-5e52c1c3599so6310413a12.2
        for <git@vger.kernel.org>; Wed, 05 Mar 2025 09:39:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741196360; x=1741801160; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qsnuHRtcTbMPDXn4rBYnYEt0A372DK6jcrXME9NQVFI=;
        b=WOpsa7scnKQuVrrTRHPwQhCPnfOXJ9K6bsOgns1bO+QAdaHt25BQIRUmB1C7KG3l0F
         /fE81iuutJ4h+a8udjm4rw0gIm8K5YHaqa02G/BOiQGkq+ZufjSl2a8FSIK4Bko76SUH
         PZhtazdqe9KST6/2tJhvovY2uwVzR+IDljY/Xu/jo9FTrPkb1tSfNfVvLDZ+oOolOShE
         Dqoy/KH2ZvK+4p1dxEjmrOYAD6RP9VHg3DFVpQymmWsSlZnrLZXTeu9aQGmMUnWLDWiS
         K4WGBgUwn2axsYt9XWl5sc1karApH2HwDHA8HrOqLdCpZPpb4QGt8kelNYD2SpX4mz+W
         Lk2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741196360; x=1741801160;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qsnuHRtcTbMPDXn4rBYnYEt0A372DK6jcrXME9NQVFI=;
        b=VNQgDkJbg6ctfW/9wPk+BmNZNvfSkQ3LAV0vwOOUFDwsw7+twfDCgH8Ld29P1y1UR9
         RAlsCYX543Jc32sgYjq/yRWFddqwGBQCvmg7ugg6ymlx7IqCx++Su+ALhPRdFe9wQvTJ
         6iB/B+zEdkSEpdVMWvamcUaN3bd6II13xM2EPwTYg298vPp2fcRgoHVDx1Nu834kT+bT
         Gw+UjaH8a7G0pl37e3cvh/jEAJvRxXawK5rkS3GfsrDWkQbxBQ53BIaeAZBnUDQNdN1M
         PbZN+P7kMJSgvKCJKet8FUkEXHIckJhpPQgelqdPjTvGQVVs2m9U6TdzTO17JeYka/o6
         esjg==
X-Gm-Message-State: AOJu0Yye3ILsLbRn8K7OHPUe8FtLU2fkm1novSPUOYzkRnAtsMx9KAl7
	ObWW04asaU4FGGRNUkNQDcWalZjA+e0RMKzXBN9/qkHZhpgPwbq9ueheG+er
X-Gm-Gg: ASbGncuk+UUkWaoEvXFJqAKWR3oSWg7D7R9tkJB/C3kPIlh2ZK+Ay7hNDi5ugfNs0Y9
	pEClDyedYxUySekb4UAqMM5zFgY1Rjh2kRN3JqXbuQ5UL+2vEq9bbWp1QesuTuFDBMsxZaYIc5D
	P8+UVaWI5a+VI0O9bUfYRd6HnVeH8RrMa4T+5L5r5EUv+ByWMFt9P3OG/FDz/8liJv6EXNchVtB
	iADevcG99TCGdTfnbNbTsDjn2heVgy49rUP2VQ8MVvHb15Zl5hp8vJ99LTkI+4MvIWgkg7s2Zce
	IvfOBSPPO+5Tl+BVE4oYddtq/DJB44AYDMqCvA9PzZLanjDaLQ==
X-Google-Smtp-Source: AGHT+IFTsRKPgLlUibFxcsBOYH6SuSca0iUjNpp4AuQClVI4bHsNp0iaVz4BGIcb+cKDMguiuk1R6A==
X-Received: by 2002:a17:907:d92:b0:abf:4bde:51b1 with SMTP id a640c23a62f3a-ac20d9e8f1cmr364404166b.21.1741196359838;
        Wed, 05 Mar 2025 09:39:19 -0800 (PST)
Received: from [127.0.0.2] ([2a02:2455:8268:bc00:8a90:b290:3a5b:4dd])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-abf3a8e2f53sm946851866b.115.2025.03.05.09.39.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Mar 2025 09:39:19 -0800 (PST)
From: Karthik Nayak <karthik.188@gmail.com>
Date: Wed, 05 Mar 2025 18:39:02 +0100
Subject: [PATCH v3 7/8] refs: support partial update rejections during F/D
 checks
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250305-245-partially-atomic-ref-updates-v3-7-0c64e3052354@gmail.com>
References: <20250305-245-partially-atomic-ref-updates-v3-0-0c64e3052354@gmail.com>
In-Reply-To: <20250305-245-partially-atomic-ref-updates-v3-0-0c64e3052354@gmail.com>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>, ps@pks.im, jltobler@gmail.com, 
 phillip.wood123@gmail.com
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=12730;
 i=karthik.188@gmail.com; h=from:subject:message-id;
 bh=1uVRVC5AK0r3l5poScKiYx9wQtnJFVTfYadriahjgZY=;
 b=owJ4nAHtARL+kA0DAAoBPtWfJI5GjH8ByyZiAGfIjEBEjo0fW14z4o5PUOKZyEUfrm5n3HeHY
 iCpU7uiYbW8tIkBswQAAQoAHRYhBFfOTH9jdXEPy2XGBj7VnySORox/BQJnyIxAAAoJED7VnySO
 Rox/iogL/3JJrH3/u+H3XZYDjzdlu1IDdfwLVWiIby3eDe8zQtG57kixbGxlIKC41zgDCZtKyrz
 QWE1MzGeXX7OwI+uF5NW6/UEX5DNZA3nGpXAFkOXoCUk2Z1vLmljnXm3U4AKbwTu2mZPsfAFZtT
 TRaV3pj8/o8DPxpXxpjioC+2Kg30apRITi9C3hcFVNPkoNyUB7EKrOteFLowv6dm0AVweUE1gc1
 FOi/D25m6da9yOpVKDQxDoCulHQQ4Di5O4B5pFzUKKTxvPQIBiAXov7VSEfah5bxUqUGWINZUAe
 eFhm1EP+zrhBvrZLa7ZuS1bsRMLdNLF9nyVhU4Hv8d4ALSFqwkDU6ZSSN0BXTOEpqV6i7DS50I7
 yBIGl4EGqfsYcvGvqmQX8UAg2e7o0MO4NmseV3oWB2oLMOckyLBHI7kMEQ6Is3D/lGsZsLS0C17
 8EOQNk3bhGTE6qfm/CFIXcbie2GRYUnoQndQ96QDwza08y38WMJ4DxvRXNsZeEUJKNEm9X1WIn5
 t8=
X-Developer-Key: i=karthik.188@gmail.com; a=openpgp;
 fpr=57CE4C7F6375710FCB65C6063ED59F248E468C7F

The `refs_verify_refnames_available()` is used to batch check refnames
for F/D conflicts. While this is the more performant alternative than
its individual version, it does not provide rejection capabilities on a
single update level. For partial transactions, this would mean a
rejection of the entire transaction whenever one reference has a F/D
conflict.

Modify the function to call `ref_transaction_maybe_set_rejected()` to
check if a single update can be rejected. Since this function is only
internally used within 'refs/' and we want to pass in a `struct
ref_transaction *` as a variable. We also move and mark
`refs_verify_refnames_available()` to 'refs-internal.h' to be an
internal function.

Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
---
 refs.c                  | 28 +++++++++++++++++++++++++++-
 refs.h                  | 12 ------------
 refs/files-backend.c    | 27 ++++++++++++++++++---------
 refs/refs-internal.h    | 17 +++++++++++++++++
 refs/reftable-backend.c | 11 ++++++++---
 5 files changed, 70 insertions(+), 25 deletions(-)

diff --git a/refs.c b/refs.c
index b735510c3b..c4dccf9d8b 100644
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
@@ -2559,6 +2560,7 @@ enum ref_transaction_error refs_verify_refnames_available(struct ref_store *refs
 	strset_init(&dirnames);
 
 	for (size_t i = 0; i < refnames->nr; i++) {
+		const size_t *update_idx = (size_t *)refnames->items[i].util;
 		const char *refname = refnames->items[i].string;
 		const char *extra_refname;
 		struct object_id oid;
@@ -2598,12 +2600,26 @@ enum ref_transaction_error refs_verify_refnames_available(struct ref_store *refs
 			if (!initial_transaction &&
 			    !refs_read_raw_ref(refs, dirname.buf, &oid, &referent,
 					       &type, &ignore_errno)) {
+				if (transaction && ref_transaction_maybe_set_rejected(
+					    transaction, *update_idx,
+					    REF_TRANSACTION_ERROR_NAME_CONFLICT)) {
+					strset_remove(&dirnames, dirname.buf);
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
@@ -2636,6 +2652,11 @@ enum ref_transaction_error refs_verify_refnames_available(struct ref_store *refs
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
@@ -2647,6 +2668,11 @@ enum ref_transaction_error refs_verify_refnames_available(struct ref_store *refs
 
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
@@ -2678,7 +2704,7 @@ enum ref_transaction_error refs_verify_refname_available(
 	};
 
 	return refs_verify_refnames_available(refs, &refnames, extras, skip,
-					      initial_transaction, err);
+					      NULL, initial_transaction, err);
 }
 
 struct do_for_each_reflog_help {
diff --git a/refs.h b/refs.h
index 5e5ff9e57d..938420bec4 100644
--- a/refs.h
+++ b/refs.h
@@ -147,18 +147,6 @@ enum ref_transaction_error refs_verify_refname_available(struct ref_store *refs,
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
index c2fdee6013..7525bf75ab 100644
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
-		string_list_insert(refnames_to_check, refname);
+		item = string_list_insert(refnames_to_check, refname);
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
index c417aec217..f0e958dc83 100644
--- a/refs/refs-internal.h
+++ b/refs/refs-internal.h
@@ -805,4 +805,21 @@ enum ref_transaction_error ref_update_check_old_target(const char *referent,
  */
 int ref_update_expects_existing_old_ref(struct ref_update *update);
 
+/*
+ * Same as `refs_verify_refname_available()`, but checking for a list of
+ * refnames instead of only a single item. This is more efficient in the case
+ * where one needs to check multiple refnames.
+ *
+ * If a transaction is provided with partial support, then individual updates
+ * are marked rejected, reference backends are then in charge of not committing
+ * those updates.
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
index dd9912d637..a50e004d96 100644
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
@@ -1385,6 +1389,7 @@ static int reftable_be_transaction_prepare(struct ref_store *ref_store,
 	string_list_sort(&refnames_to_check);
 	ret = refs_verify_refnames_available(ref_store, &refnames_to_check,
 					     &transaction->refnames, NULL,
+					     transaction,
 					     transaction->flags & REF_TRANSACTION_FLAG_INITIAL,
 					     err);
 	if (ret < 0)
@@ -1403,7 +1408,7 @@ static int reftable_be_transaction_prepare(struct ref_store *ref_store,
 	}
 	strbuf_release(&referent);
 	strbuf_release(&head_referent);
-	string_list_clear(&refnames_to_check, 0);
+	string_list_clear(&refnames_to_check, 1);
 
 	return ret;
 }

-- 
2.48.1

