Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 119A7265610
	for <git@vger.kernel.org>; Tue,  8 Apr 2025 08:51:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744102295; cv=none; b=VeLVr/sOzGkfVyi3wNGsiSUfxUPW7Jyfw0hZSX+zY9RTpJCg+TOmrQFJ2F2xCRPnH7DhHjxDa3wZZ2ZnNguNx+wLgnG+xr6VC4PWQzFmpVDQ/pT1qql1CzZpuLWFCcH4OvF0YRKrxNQP7OrtXNQLd5Dlw3MI5y8Lj8BP9n3jJIY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744102295; c=relaxed/simple;
	bh=khsMaY8AYMlA48aIyKUpps67xA+Ue+8n+aygdHUT7OU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ed7JL2gX8v9FEW+zNUgJ9vTwe8edM7VpujBt9gtSjpM7POAsrEQD2JAmyXupbNo+s2CQxbqfQ+MxnV0lJEj85sbtSFlar4yzDIXNzOLXw1r8PiNQ7KOZ/i6ihReXHSMRPiZnFC+iPtfEte1Dw4zisejaI0DHYBEs8NU66d9kY58=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GtHaxLRj; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GtHaxLRj"
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-ac297cbe017so1174935566b.0
        for <git@vger.kernel.org>; Tue, 08 Apr 2025 01:51:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744102291; x=1744707091; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=z83N98H+UPWBbiYnEmoKthmPM+V23SZ9xtvF0mN90WU=;
        b=GtHaxLRj2YFyQJqgY2hPqdxdddMlQHMVMoWjlVxEtMxBH+QKnXujO78BXCCn9clVuZ
         g0py0y1lt00uuD8deUo8e7xpnUaKBGAOWKjgGgAxkYfm/KVDY8Zv3HZwZiNEO1/ExF/g
         BITHjYZoTUyTmJT8G07mm+1xK5dPo7Qt/apIOXH66740A8fzGhGYQXiFWWacGXoofuwY
         y62Y5j/DRnqhKmSt0SKid7JergcRUqtVlVpQNUgf37eWQ/wfHxV1gcSp2OT/z6wv9+GU
         YseBoV4zB8TLKhtIy/qJgOH2948iQ+4jgmb5/eExpGzIoIfa1D4WWnue+P/5dmqtB47+
         xtQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744102291; x=1744707091;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=z83N98H+UPWBbiYnEmoKthmPM+V23SZ9xtvF0mN90WU=;
        b=Xl66griaFfgi58leSaz9/MgjtGw9LS0YhF/l1ae7ykJBIlbdNKLqf6U51igNtf/Ixr
         GGlV/tZRognG92gkU8nJo5GDnj7ALp1mzFS7E+4qskRzPYZ+Lea3m/pZW1FuxpDpw2bE
         sw9s2XNSs95HKBNfWAGG/4ZSaSEzBhjH/vGkIC1WHKpUsoQL5AfdsiTghOyfv14Eei0S
         mqpSgxUbrZYLt5+Ymrc8QZA+R820TUozagEziedUHdXVEAu3gZtw1gm2I6YAPF/2bJA5
         87UqFNGdIfo+qNM8VPuEv0gZo6UZiY4Bsy+RsL3i/nDXZgyg/kIw3n8oy87SoZ5Wn0a7
         H4Ew==
X-Gm-Message-State: AOJu0Yzz/c/J3oFBrCDm1uQh/CAd+GLB75AowXHOprdh1Do7TKImdVeT
	MKGC6bYkBKZREgqGLwso1QLY+R3IorwlcMD3SFD5Z9bl/RkmVlFc
X-Gm-Gg: ASbGncs6Z6neTAmkK4bIca5wOLkP8Er6tadcmv984Eiw0jSrn47fTw8xRXXKva8zc1n
	sqpiFc5PpInBnoATHKgNoAjBjzEmK96n2e6evSWbaKFGTaluwy/B6ozOwp1jLpQJHEwW+aoSDVh
	gp9qRRE05LPs0KHVmgjZjGURUiUbMnFhMPbHQH6lwNwDGXL37pVJebR1LP7SEqurOFYEMQAZKIy
	Iz7pU5W0xqH7IrpAjlt3pkjOjbrgrTeu7rmv4v0oASpnSiCe8dEZTOH9tOY6oGgR9XF8sfWRIfS
	8XV7Zlw+mLlQVupiGmnDBd+zuPllV7hHpAC6Ad0pdSiJ00aLrbJbILFyAg==
X-Google-Smtp-Source: AGHT+IGXqop0CAYIItLfFY49sf3YknsZ5zWZwbXXvUn0YfK1NM+A/kXCfKPNDI0bXYgRAsYSqPcTMA==
X-Received: by 2002:a17:907:7da2:b0:ac2:4f30:5033 with SMTP id a640c23a62f3a-ac81a655237mr201742266b.15.1744102291199;
        Tue, 08 Apr 2025 01:51:31 -0700 (PDT)
Received: from localhost.localdomain ([217.110.80.4])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac7bfe5c804sm890801366b.15.2025.04.08.01.51.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Apr 2025 01:51:30 -0700 (PDT)
From: Karthik Nayak <karthik.188@gmail.com>
To: karthik.188@gmail.com
Cc: git@vger.kernel.org,
	jltobler@gmail.com,
	ps@pks.im,
	jn.avila@free.fr,
	gitster@pobox.com
Subject: [PATCH v6 7/8] refs: support rejection in batch updates during F/D checks
Date: Tue,  8 Apr 2025 10:51:11 +0200
Message-ID: <20250408085120.614893-8-karthik.188@gmail.com>
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

