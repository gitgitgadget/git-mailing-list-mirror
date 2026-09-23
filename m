Received: from mail-lf2-f13.google.com (mail-lf2-f13.google.com [74.125.229.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E271B36604B
	for <git@vger.kernel.org>; Wed, 23 Sep 2026 13:36:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.229.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790170621; cv=none; b=IF4GDthd3p/zHEa+T9nZZM6bxkf6703VFqJZ0GfScNdjn1+oDINlRAC3/XRFreWpI7Bl9MCgVedq3j4rdoBmrFIjx4M1AywRt9SaOsSli/nlKAz8mT+i2nFiWNEpQ260QIwuSnsiywdqR6ALcuGUWtru1u1vz2QDilJu3bCaiVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790170621; c=relaxed/simple;
	bh=PoVOdP9iLXmvCws6LSsBTvChhG3UnvDKlQ+kRMKpAGA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Zpp67Ki/9IQa6ICdobk0W4wUFrj5B4bfr2Gp8csFGEgrNDoXp8gNiwdKb84eWzpordOyxfe+P7jkgs6G+VZpFAUgWwf2nMfdoySFIZorGXqfUOqf9nbIDrr/QjskbXdXWCOKqrcDkL9TG5xTXdeHSa2MWLI6ARei7SXnXaEteV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PdPD4WYb; arc=none smtp.client-ip=74.125.229.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PdPD4WYb"
Received: by mail-lf2-f13.google.com with SMTP id 2adb3069b0e04-5b5e4f17452so760195e87.3
        for <git@vger.kernel.org>; Wed, 23 Sep 2026 06:36:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790170615; x=1790775415; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Q5g7+7/9z1hzId+bIOlckvsZ9FKwtkBr95bnA97B82g=;
        b=PdPD4WYb34zIQwKwcluE26M31DpFipWipJM60N6xhb9vGOd01SB5MLpDGs7XNnMr9r
         eT7comq6u5c1NuI0F+u9wyLjr8YNcKZ11P+djwSIGB9MapEs9Re/NFe+VLcCUB9IKCZ+
         PlbBB0F8EDd/X2UvAPQPpzAaNsQkzQnuanowb+Gd3mZOsLoV+M5PN5A3fQgpyQ0/HnXA
         QbLpCpyq1rJRD8DU73rp3LoBX56fp2oypyRj9znJKna5njFsPFuXy9vMzNYympwCaV7t
         CQK11B1Cu6IBye4koKZuxCQ4MogiAtxms7hoi/lT+p/EnMf7xxC+YupfFccXtepmr6lt
         6bEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790170615; x=1790775415;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Q5g7+7/9z1hzId+bIOlckvsZ9FKwtkBr95bnA97B82g=;
        b=ZnA8iGCVM8Po8Ht1R79GtmYTSIVUo/Wwx5ooY1CV6OYlLw20cZKqEoKKvnJTZUlyv7
         wBsLu4VaeeAao02sENouVExoczhXmxAzJ+CuOdPNWaWcz1thrWKB2t261kcbt57DOyVA
         gjuNztc1JG1+/ROCpoxzOZFADFWSpdYhDD3wNzt4qm3cfDYpFlK/bXdZ6ozYnn+y6cBz
         e5VFYsSYulBG04UWJXWcNgz/wYS8rtDo9J0/MFn5OXkZade03omRColjcU2xXX0KC8vm
         Ko5fRUY3qh2r1Ivdx57NsbVvEwFM7MGFJlsr44L3tCt/e+gpUmpfAI73qg1oT5v2GbtB
         NNIA==
X-Gm-Message-State: AFuF++mfK8ORcD5PhXpE09CcdlTtRbBWEJ/Kt0rYaSpR1uEvp3FUxSqM
	5ECgWdplLBj4nmUB3ZQXSz/iZmtpFyxJLBf52w1fARJn+x6BtgGP8FKZ7GYEDIvK
X-Gm-Gg: AYBFou10bIcsKcQliaP0+YJz8//QHe5T+vHIf7VxhPhqNsLc2djdRYCjiaLx1wJ1uMC
	SZ6rfVQU6DtK4C8qykKXeWU3kbd+3W46NTNzWCYJAuykLyVKcF/YVTKGAIBXm3GoRUTlIkrkeE7
	IWHBQAVs0QtY2XeH2iWRy9wV3wE947Td5lS2UtmtFsgQzMREg/vjHCN6WMOPBuEys2HZzD5vghj
	StKUoAY8pJFwNF41uQvjN+hbzY+ICMJHga3EpajV0SB3ZRzUyGN3h1wBncWWAJI/+X6LWbocUyN
	uT9GSC8k2u9RhBVSHnrgDGmP98fe8P7KpziGmuFRhH3WvZ4+ZkO+3mNLoKFvHPZ9v33ApbgDGmD
	B9Obs7vxYTwLxVFdWBhkUnWI8wuGrKQ6TKi2xqltbpiIfod5dqZW1ZUUdM96NMn/0LuIsdibtCA
	ZanQp3p27dFzcJyx8ylRVCPDyNQ3xACrK0DQKLGJ/hP13ZNzY/XtVGAgFS00b2NyBDYuBUesaBU
	sPSHPDuGu0x8H+IwZBJtfBj+r5WoVDB+C045MrQDH/GqKW7LGVAJgEGM1JuU0r/+WhoDqsUNOfb
	qbl3+nMo64R4c8LLrJwhkwmKV1LoAKSCdks9/tDJctmKJ4lEtXqX3ft7/8o=
X-Received: by 2002:a05:6512:134c:b0:5b7:de2d:191a with SMTP id 2adb3069b0e04-5b8d896843dmr856595e87.23.1790170614156;
        Wed, 23 Sep 2026 06:36:54 -0700 (PDT)
Received: from localhost.localdomain ([91.236.84.70])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5b8d8580568sm622531e87.34.2026.09.23.06.36.53
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 23 Sep 2026 06:36:53 -0700 (PDT)
From: Maciej Ciemborowicz <maciej.ciemborowicz@gmail.com>
To: git@vger.kernel.org
Cc: Maciej Ciemborowicz <maciej.ciemborowicz@gmail.com>,
	gitster@pobox.com,
	karthik.188@gmail.com
Subject: [PATCH v2] refs: run copy and rename through transactions
Date: Wed, 23 Sep 2026 15:36:51 +0200
Message-Id: <20260923133651.74120-1-maciej.ciemborowicz@gmail.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
In-Reply-To: <20260920165037.88524-1-maciej.ciemborowicz@gmail.com>
References: <20260920165037.88524-1-maciej.ciemborowicz@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Reference copy and rename operations bypass the transaction API.
Consequently, the reference-transaction hook sees only the source deletion
with the files backend and no useful update with the reftable backend.

Represent both operations as reference transactions containing their
logical updates. A rename is a deletion of the old reference and creation
of the new reference in the same transaction. Attach operation-specific
state to the destination update instead of making copy or rename a property
of the entire transaction.

Retain backend-specific reflog handling: the files backend stages its
existing rename procedure across prepare, finish and abort, while reftable
stages an addition while holding the stack lock. Suppress hooks for the
files backend's nested deletion transactions so that callers observe one
logical transaction.

Record and verify the source and destination values after taking backend
locks. This rejects concurrent changes instead of applying a rename or copy
that differs from the payload shown to the preparing hook. Preserve D/F
renames and restore overwritten references and reflogs when a prepared hook
rejects the operation.

Add tests covering rename, copy, forced updates, both directions of D/F
conflicts, concurrent updates and prepared-hook rollback.

Helped-by: Karthik Nayak <karthik.188@gmail.com>
Signed-off-by: Maciej Ciemborowicz <maciej.ciemborowicz@gmail.com>
---
Apologies for the unrelated Subject header on my earlier reply. This
reroll incorporates the points discussed there.

Changes since v1:

 * Keep copy/rename state on the destination ref update instead of the
   generic transaction, so the operation is no longer a transaction-wide
   property.
 * Keep REF_TRANSACTION_FLAG_SKIP_HOOK private to the refs implementation.
 * Use bool for the two-state copy parameter.
 * Apply Junio's commit-message wording suggestions.

Range-diff against v1:
1:  de0a5a9f7 ! 1:  d852537d8 refs: run copy and rename through transactions
    @@ Metadata
      ## Commit message ##
         refs: run copy and rename through transactions
     
    -    Reference copy and rename operations currently bypass the transaction API.
    +    Reference copy and rename operations bypass the transaction API.
         Consequently, the reference-transaction hook sees only the source deletion
         with the files backend and no useful update with the reftable backend.
     
         Represent both operations as reference transactions containing their
         logical updates. A rename is a deletion of the old reference and creation
    -    of the new reference in the same transaction. Retain backend-specific
    -    reflog handling: the files backend stages its existing rename procedure
    -    across prepare, finish and abort, while reftable stages an addition while
    -    holding the stack lock. Suppress hooks for the files backend's nested
    -    deletion transactions so that callers observe one logical transaction.
    +    of the new reference in the same transaction. Attach operation-specific
    +    state to the destination update instead of making copy or rename a property
    +    of the entire transaction.
    +
    +    Retain backend-specific reflog handling: the files backend stages its
    +    existing rename procedure across prepare, finish and abort, while reftable
    +    stages an addition while holding the stack lock. Suppress hooks for the
    +    files backend's nested deletion transactions so that callers observe one
    +    logical transaction.
     
         Record and verify the source and destination values after taking backend
         locks. This rejects concurrent changes instead of applying a rename or copy
    @@ Commit message
         renames and restore overwritten references and reflogs when a prepared hook
         rejects the operation.
     
    -    Add coverage for rename, copy, forced updates, both directions of D/F
    +    Add tests covering rename, copy, forced updates, both directions of D/F
         conflicts, concurrent updates and prepared-hook rollback.
     
         Helped-by: Karthik Nayak <karthik.188@gmail.com>
    @@ refs.c: int refs_delete_ref(struct ref_store *refs, const char *msg,
      {
      	char c;
     @@ refs.c: void ref_transaction_free(struct ref_transaction *transaction)
    + 	}
    + 
    + 	for (i = 0; i < transaction->nr; i++) {
    ++		struct ref_copy_or_rename_update *operation =
    ++			transaction->updates[i]->copy_or_rename;
    ++
    + 		free(transaction->updates[i]->msg);
    + 		free(transaction->updates[i]->committer_info);
    + 		free((char *)transaction->updates[i]->new_target);
    + 		free((char *)transaction->updates[i]->old_target);
    + 		free((char *)transaction->updates[i]->rejection_details);
    ++		if (operation) {
    ++			free(operation->old_refname);
    ++			free(operation->logmsg);
    ++			free(operation->destination_target);
    ++			free(operation);
    ++		}
    + 		free(transaction->updates[i]);
    + 	}
      
    - 	string_list_clear(&transaction->refnames, 0);
    - 	free(transaction->updates);
    -+	free(transaction->old_refname);
    -+	free(transaction->new_refname);
    -+	free(transaction->logmsg);
    -+	free(transaction->destination_target);
    +@@ refs.c: void ref_transaction_free(struct ref_transaction *transaction)
      	free(transaction);
      }
      
    ++struct ref_update *ref_transaction_copy_or_rename_update(
    ++	struct ref_transaction *transaction)
    ++{
    ++	struct ref_update *operation = NULL;
    ++	size_t i;
    ++
    ++	for (i = 0; i < transaction->nr; i++) {
    ++		if (!transaction->updates[i]->copy_or_rename)
    ++			continue;
    ++		if (operation)
    ++			BUG("multiple copy or rename updates in one transaction");
    ++		operation = transaction->updates[i];
    ++	}
    ++
    ++	return operation;
    ++}
    ++
    + int ref_transaction_maybe_set_rejected(struct ref_transaction *transaction,
    + 				       size_t update_idx,
    + 				       enum ref_transaction_error err,
     @@ refs.c: int ref_transaction_prepare(struct ref_transaction *transaction,
      		return REF_TRANSACTION_ERROR_GENERIC;
      
    @@ refs.c: int refs_delete_refs(struct ref_store *refs, const char *logmsg,
     -		    const char *newref, const char *logmsg)
     +static int refs_copy_or_rename_ref(struct ref_store *refs, const char *oldref,
     +				   const char *newref, const char *logmsg,
    -+				   int copy)
    ++				   bool copy)
      {
     -	char *msg;
     -	int retval;
     +	struct ref_transaction *transaction = NULL;
    ++	struct ref_copy_or_rename_update *operation = NULL;
    ++	struct ref_update *destination_update;
     +	struct object_id old_oid, new_oid;
     +	struct strbuf new_target = STRBUF_INIT;
     +	struct strbuf err = STRBUF_INIT;
    @@ refs.c: int refs_delete_refs(struct ref_store *refs, const char *logmsg,
     +	transaction = ref_store_transaction_begin(refs, 0, &err);
     +	if (!transaction)
     +		goto error;
    -+	transaction->type = copy ? REF_TRANSACTION_TYPE_COPY :
    -+		REF_TRANSACTION_TYPE_RENAME;
    -+	transaction->old_refname = xstrdup(oldref);
    -+	transaction->new_refname = xstrdup(newref);
    -+	transaction->logmsg = xstrdup(msg);
    -+	oidcpy(&transaction->source_oid, &old_oid);
    -+
     +	if (!copy && ref_transaction_delete(transaction, oldref, &old_oid, NULL,
     +					    REF_NO_DEREF, msg, &err))
     +		goto error;
    @@ refs.c: int refs_delete_refs(struct ref_store *refs, const char *logmsg,
     +	} else {
     +		oidclr(&new_oid, refs->repo->hash_algo);
     +	}
    -+	transaction->destination_exists = new_exists;
    -+	if (new_flags & REF_ISSYMREF)
    -+		transaction->destination_target = xstrdup(new_target.buf);
    -+	else if (transaction->destination_exists)
    -+		oidcpy(&transaction->destination_oid, &new_oid);
    -+
     +	if (ref_transaction_update(transaction, newref, &old_oid,
     +				   (new_flags & REF_ISSYMREF) ? NULL : &new_oid,
     +				   NULL,
    @@ refs.c: int refs_delete_refs(struct ref_store *refs, const char *logmsg,
     +				   NULL, &err))
     +		goto error;
     +
    ++	destination_update = transaction->updates[transaction->nr - 1];
    ++	CALLOC_ARRAY(operation, 1);
    ++	operation->type = copy ? REF_UPDATE_COPY : REF_UPDATE_RENAME;
    ++	operation->old_refname = xstrdup(oldref);
    ++	operation->logmsg = xstrdup(msg);
    ++	oidcpy(&operation->source_oid, &old_oid);
    ++	operation->destination_exists = new_exists;
    ++	if (new_flags & REF_ISSYMREF)
    ++		operation->destination_target = xstrdup(new_target.buf);
    ++	else if (operation->destination_exists)
    ++		oidcpy(&operation->destination_oid, &new_oid);
    ++	destination_update->copy_or_rename = operation;
    ++
     +	if (ref_transaction_commit(transaction, &err))
     +		goto error;
     +
    @@ refs.c: int refs_delete_refs(struct ref_store *refs, const char *logmsg,
      
      const char *ref_update_original_update_refname(struct ref_update *update)
     
    - ## refs.h ##
    -@@ refs.h: enum ref_transaction_flag {
    - 	 * while rejecting updates which do not match the expected state.
    - 	 */
    - 	REF_TRANSACTION_ALLOW_FAILURE = (1 << 1),
    -+
    -+	/* Suppress hooks for an update nested in another transaction. */
    -+	REF_TRANSACTION_FLAG_SKIP_HOOK = (1 << 2),
    - };
    - 
    - /*
    -
      ## refs/debug.c ##
     @@ refs/debug.c: static int debug_optimize_required(struct ref_store *ref_store,
      	return res;
    @@ refs/files-backend.c: static int refs_rename_ref_available(struct ref_store *ref
     +};
     +
      static int files_copy_or_rename_ref(struct ref_store *ref_store,
    - 			    const char *oldrefname, const char *newrefname,
    +-			    const char *oldrefname, const char *newrefname,
     -			    const char *logmsg, int copy)
    -+			    const char *logmsg, int copy,
    -+			    struct ref_transaction *transaction)
    ++				    struct ref_update *update,
    ++				    struct ref_transaction *transaction)
      {
      	struct files_ref_store *refs =
     -		files_downcast(ref_store, REF_STORE_WRITE, "rename_ref");
     +		files_downcast(ref_store, REF_STORE_WRITE,
     +			       "ref_transaction_prepare");
    ++	struct ref_copy_or_rename_update *operation = update->copy_or_rename;
    ++	const char *oldrefname = operation->old_refname;
    ++	const char *newrefname = update->refname;
    ++	const char *logmsg = operation->logmsg;
    ++	bool copy = operation->type == REF_UPDATE_COPY;
      	struct object_id orig_oid;
      	int flag = 0, logmoved = 0;
      	struct ref_lock *lock;
    @@ refs/files-backend.c: static int files_copy_or_rename_ref(struct ref_store *ref_
      				    oldrefname);
      		goto out;
      	}
    -+	if (!oideq(&orig_oid, &transaction->source_oid)) {
    ++	if (!oideq(&orig_oid, &operation->source_oid)) {
     +		ret = error("refname %s is at %s but expected %s",
     +			    oldrefname, oid_to_hex(&orig_oid),
    -+			    oid_to_hex(&transaction->source_oid));
    ++			    oid_to_hex(&operation->source_oid));
     +		goto out;
     +	}
      	if (!refs_rename_ref_available(&refs->base, oldrefname, newrefname)) {
    @@ refs/files-backend.c: static int files_copy_or_rename_ref(struct ref_store *ref_
     +			goto out;
     +		}
     +	}
    -+	if (destination_exists != transaction->destination_exists) {
    ++	if (destination_exists != operation->destination_exists) {
     +		ret = error("refname %s changed while renaming", newrefname);
     +		goto out;
     +	}
     +	if (destination_exists) {
     +		if (destination_flags & REF_ISSYMREF) {
    -+			if (!transaction->destination_target ||
    ++			if (!operation->destination_target ||
     +			    strcmp(destination_target.buf,
    -+				   transaction->destination_target)) {
    ++				   operation->destination_target)) {
     +				ret = error("refname %s changed while renaming",
     +					    newrefname);
     +				goto out;
     +			}
    -+		} else if (transaction->destination_target ||
    ++		} else if (operation->destination_target ||
     +			   !oideq(&destination_oid,
    -+				  &transaction->destination_oid)) {
    ++				  &operation->destination_oid)) {
     +			ret = error("refname %s changed while renaming", newrefname);
     +			goto out;
     +		}
    @@ refs/files-backend.c: static int files_transaction_prepare(struct ref_store *ref
      	struct ref_transaction *packed_transaction = NULL;
      
      	assert(err);
    -+	if (transaction->type != REF_TRANSACTION_TYPE_NORMAL)
    -+		return files_copy_or_rename_ref(ref_store,
    -+				transaction->old_refname,
    -+				transaction->new_refname,
    -+				transaction->logmsg,
    -+				transaction->type == REF_TRANSACTION_TYPE_COPY,
    -+				transaction);
    ++	{
    ++		struct ref_update *operation =
    ++			ref_transaction_copy_or_rename_update(transaction);
    ++
    ++		if (operation)
    ++			return files_copy_or_rename_ref(ref_store, operation,
    ++							transaction);
    ++	}
      
      	if (transaction->flags & REF_TRANSACTION_FLAG_INITIAL)
      		goto cleanup;
    @@ refs/files-backend.c: static int files_transaction_finish(struct ref_store *ref_
      
      
      	assert(err);
    -+	if (transaction->type != REF_TRANSACTION_TYPE_NORMAL) {
    -+		struct files_copy_or_rename_transaction_data *data =
    -+			transaction->backend_data;
    -+		int special_ret;
    ++	{
    ++		struct ref_update *update =
    ++			ref_transaction_copy_or_rename_update(transaction);
     +
    -+		special_ret = commit_ref_update(refs, data->lock, &data->orig_oid,
    -+						transaction->logmsg, 0, err);
    -+		if (special_ret) {
    -+			error("unable to write current sha1 into %s: %s",
    -+			      transaction->new_refname, err->buf);
    -+			data->lock = NULL;
    -+			files_transaction_abort(ref_store, transaction, err);
    -+			return special_ret;
    -+		} else if (data->destination_log_backed_up) {
    -+			struct strbuf path = STRBUF_INIT;
    ++		if (update) {
    ++			struct ref_copy_or_rename_update *operation =
    ++				update->copy_or_rename;
    ++			struct files_copy_or_rename_transaction_data *data =
    ++				transaction->backend_data;
    ++			int special_ret;
    ++
    ++			special_ret = commit_ref_update(refs, data->lock, &data->orig_oid,
    ++							operation->logmsg, 0, err);
    ++			if (special_ret) {
    ++				error("unable to write current sha1 into %s: %s",
    ++				      update->refname, err->buf);
    ++				data->lock = NULL;
    ++				files_transaction_abort(ref_store, transaction, err);
    ++				return special_ret;
    ++			} else if (data->destination_log_backed_up) {
    ++				struct strbuf path = STRBUF_INIT;
     +
    -+			files_reflog_path(refs, &path, TMP_RENAMED_LOG_DESTINATION);
    -+			if (unlink(path.buf) < 0 && errno != ENOENT)
    -+				warning_errno("unable to remove '%s'", path.buf);
    -+			strbuf_release(&path);
    ++				files_reflog_path(refs, &path, TMP_RENAMED_LOG_DESTINATION);
    ++				if (unlink(path.buf) < 0 && errno != ENOENT)
    ++					warning_errno("unable to remove '%s'", path.buf);
    ++				strbuf_release(&path);
    ++			}
    ++			free(data->destination_target);
    ++			free(data);
    ++			transaction->backend_data = NULL;
    ++			transaction->state = REF_TRANSACTION_CLOSED;
    ++			return special_ret;
     +		}
    -+		free(data->destination_target);
    -+		free(data);
    -+		transaction->backend_data = NULL;
    -+		transaction->state = REF_TRANSACTION_CLOSED;
    -+		return special_ret;
     +	}
      
      	if (transaction->flags & REF_TRANSACTION_FLAG_INITIAL)
    @@ refs/files-backend.c: static int files_transaction_finish(struct ref_store *ref_
      	struct files_ref_store *refs =
      		files_downcast(ref_store, 0, "ref_transaction_abort");
      
    -+	if (transaction->type != REF_TRANSACTION_TYPE_NORMAL) {
    -+		struct files_copy_or_rename_transaction_data *data =
    -+			transaction->backend_data;
    -+		struct strbuf new_log = STRBUF_INIT;
    -+		struct strbuf destination_log = STRBUF_INIT;
    -+		struct strbuf temporary_log = STRBUF_INIT;
    -+		struct ref_transaction *restore_transaction = NULL;
    -+		struct ref_lock *lock;
    -+		int ret = 0;
    ++	{
    ++		struct ref_update *update =
    ++			ref_transaction_copy_or_rename_update(transaction);
     +
    -+		if (data->lock)
    -+			unlock_ref(data->lock);
    -+		if (transaction->type == REF_TRANSACTION_TYPE_RENAME) {
    -+			lock = lock_ref_oid_basic(refs, transaction->old_refname, err);
    -+			if (!lock ||
    -+			    write_ref_to_lockfile(refs, lock, &data->orig_oid, err) ||
    -+			    commit_ref_update(refs, lock, &data->orig_oid, NULL,
    -+					      REF_SKIP_CREATE_REFLOG, err))
    -+				ret = -1;
    -+		}
    ++		if (update) {
    ++			struct ref_copy_or_rename_update *operation =
    ++				update->copy_or_rename;
    ++			struct files_copy_or_rename_transaction_data *data =
    ++				transaction->backend_data;
    ++			struct strbuf new_log = STRBUF_INIT;
    ++			struct strbuf destination_log = STRBUF_INIT;
    ++			struct strbuf temporary_log = STRBUF_INIT;
    ++			struct ref_transaction *restore_transaction = NULL;
    ++			struct ref_lock *lock;
    ++			int ret = 0;
     +
    -+		if (data->logmoved) {
    -+			files_reflog_path(refs, &new_log, transaction->new_refname);
    -+			if (transaction->type == REF_TRANSACTION_TYPE_RENAME) {
    -+				files_reflog_path(refs, &temporary_log, TMP_RENAMED_LOG);
    -+				if (rename(new_log.buf, temporary_log.buf) < 0) {
    -+					strbuf_addf(err, "unable to restore logfile %s: %s",
    -+						    transaction->old_refname, strerror(errno));
    ++			if (data->lock)
    ++				unlock_ref(data->lock);
    ++			if (operation->type == REF_UPDATE_RENAME) {
    ++				lock = lock_ref_oid_basic(refs, operation->old_refname, err);
    ++				if (!lock ||
    ++				    write_ref_to_lockfile(refs, lock, &data->orig_oid, err) ||
    ++				    commit_ref_update(refs, lock, &data->orig_oid, NULL,
    ++						      REF_SKIP_CREATE_REFLOG, err))
     +					ret = -1;
    -+				} else {
    -+					try_remove_empty_parents(refs,
    -+							 transaction->new_refname,
    -+							 REMOVE_EMPTY_PARENTS_REFLOG);
    -+					if (rename_tmp_log(refs,
    -+							   transaction->old_refname)) {
    ++			}
    ++
    ++			if (data->logmoved) {
    ++				files_reflog_path(refs, &new_log, update->refname);
    ++				if (operation->type == REF_UPDATE_RENAME) {
    ++					files_reflog_path(refs, &temporary_log, TMP_RENAMED_LOG);
    ++					if (rename(new_log.buf, temporary_log.buf) < 0) {
     +						strbuf_addf(err, "unable to restore logfile %s: %s",
    -+							    transaction->old_refname,
    -+							    strerror(errno));
    ++							    operation->old_refname, strerror(errno));
     +						ret = -1;
    ++					} else {
    ++						try_remove_empty_parents(refs,
    ++									 update->refname,
    ++									 REMOVE_EMPTY_PARENTS_REFLOG);
    ++						if (rename_tmp_log(refs,
    ++								   operation->old_refname)) {
    ++							strbuf_addf(err, "unable to restore logfile %s: %s",
    ++								    operation->old_refname,
    ++								    strerror(errno));
    ++							ret = -1;
    ++						}
     +					}
    ++				} else if (unlink(new_log.buf) < 0 && errno != ENOENT) {
    ++					strbuf_addf(err, "unable to remove logfile %s: %s",
    ++						    update->refname, strerror(errno));
    ++					ret = -1;
     +				}
    -+			} else if (unlink(new_log.buf) < 0 && errno != ENOENT) {
    -+				strbuf_addf(err, "unable to remove logfile %s: %s",
    -+					    transaction->new_refname, strerror(errno));
    -+				ret = -1;
     +			}
    -+		}
    -+		if (data->destination_log_backed_up) {
    -+			files_reflog_path(refs, &destination_log,
    -+					   TMP_RENAMED_LOG_DESTINATION);
    -+			if (rename(destination_log.buf, new_log.buf) < 0) {
    -+				strbuf_addf(err, "unable to restore logfile %s: %s",
    -+					    transaction->new_refname, strerror(errno));
    -+				ret = -1;
    ++			if (data->destination_log_backed_up) {
    ++				files_reflog_path(refs, &destination_log,
    ++						  TMP_RENAMED_LOG_DESTINATION);
    ++				if (rename(destination_log.buf, new_log.buf) < 0) {
    ++					strbuf_addf(err, "unable to restore logfile %s: %s",
    ++						    update->refname, strerror(errno));
    ++					ret = -1;
    ++				}
     +			}
    -+		}
     +
    -+		if (transaction->type == REF_TRANSACTION_TYPE_RENAME &&
    -+		    data->destination_exists) {
    -+			restore_transaction = ref_store_transaction_begin(
    ++			if (operation->type == REF_UPDATE_RENAME &&
    ++			    data->destination_exists) {
    ++				restore_transaction = ref_store_transaction_begin(
     +					&refs->base, REF_TRANSACTION_FLAG_SKIP_HOOK, err);
    -+			if (!restore_transaction ||
    -+			    ref_transaction_update(restore_transaction,
    -+						   transaction->new_refname,
    -+						   data->destination_target ? NULL :
    -+							&data->destination_oid,
    -+						   NULL,
    -+						   data->destination_target,
    -+						   NULL,
    -+						   REF_NO_DEREF |
    -+							REF_SKIP_CREATE_REFLOG,
    -+						   NULL, err) ||
    -+			    ref_transaction_commit(restore_transaction, err))
    -+				ret = -1;
    -+			ref_transaction_free(restore_transaction);
    -+		}
    ++				if (!restore_transaction ||
    ++				    ref_transaction_update(restore_transaction,
    ++							   update->refname,
    ++							   data->destination_target ? NULL :
    ++										      &data->destination_oid,
    ++							   NULL,
    ++							   data->destination_target,
    ++							   NULL,
    ++							   REF_NO_DEREF |
    ++								   REF_SKIP_CREATE_REFLOG,
    ++							   NULL, err) ||
    ++				    ref_transaction_commit(restore_transaction, err))
    ++					ret = -1;
    ++				ref_transaction_free(restore_transaction);
    ++			}
     +
    -+		strbuf_release(&destination_log);
    -+		strbuf_release(&temporary_log);
    -+		strbuf_release(&new_log);
    -+		free(data->destination_target);
    -+		free(data);
    -+		transaction->backend_data = NULL;
    -+		transaction->state = REF_TRANSACTION_CLOSED;
    -+		return ret;
    ++			strbuf_release(&destination_log);
    ++			strbuf_release(&temporary_log);
    ++			strbuf_release(&new_log);
    ++			free(data->destination_target);
    ++			free(data);
    ++			transaction->backend_data = NULL;
    ++			transaction->state = REF_TRANSACTION_CLOSED;
    ++			return ret;
    ++		}
     +	}
     +
      	files_transaction_cleanup(refs, transaction);
    @@ refs/packed-backend.c: struct ref_storage_be refs_be_packed = {
      	.read_raw_ref = packed_read_raw_ref,
     
      ## refs/refs-internal.h ##
    +@@ refs/refs-internal.h: struct ref_update {
    + 	 */
    + 	struct ref_update *parent_update;
    + 
    ++	/*
    ++	 * Copy and rename operations require backend-specific handling while
    ++	 * still exposing their logical updates to transaction hooks. Keep that
    ++	 * state on the destination update so it composes with other updates in
    ++	 * the transaction instead of making copy or rename a transaction-wide
    ++	 * property.
    ++	 */
    ++	struct ref_copy_or_rename_update *copy_or_rename;
    ++
    + 	const char refname[FLEX_ARRAY];
    + };
    + 
    ++enum ref_copy_or_rename_type {
    ++	REF_UPDATE_RENAME,
    ++	REF_UPDATE_COPY,
    ++};
    ++
    ++struct ref_copy_or_rename_update {
    ++	enum ref_copy_or_rename_type type;
    ++	char *old_refname;
    ++	char *logmsg;
    ++	struct object_id source_oid;
    ++	struct object_id destination_oid;
    ++	char *destination_target;
    ++	unsigned int destination_exists:1;
    ++};
    ++
    + int refs_read_raw_ref(struct ref_store *ref_store, const char *refname,
    + 		      struct object_id *oid, struct strbuf *referent,
    + 		      unsigned int *type, int *failure_errno);
     @@ refs/refs-internal.h: struct ref_update *ref_transaction_add_update(
      		const char *committer_info,
      		const char *msg);
    @@ refs/refs-internal.h: struct ref_update *ref_transaction_add_update(
      /*
       * Transaction states.
       *
    -@@ refs/refs-internal.h: enum ref_transaction_state {
    - 	REF_TRANSACTION_CLOSED   = 2
    - };
    - 
    -+enum ref_transaction_type {
    -+	REF_TRANSACTION_TYPE_NORMAL = 0,
    -+	REF_TRANSACTION_TYPE_RENAME,
    -+	REF_TRANSACTION_TYPE_COPY,
    -+};
    -+
    - /*
    -  * Data structure to hold indices of updates which were rejected, for batched
    -  * reference updates. While the updates themselves hold the rejection error,
     @@ refs/refs-internal.h: struct ref_transaction {
    - 	void *backend_data;
    - 	unsigned int flags;
      	uint64_t max_index;
    -+
    -+	/*
    -+	 * Rename and copy operations need backend-specific reflog handling.
    -+	 * Their logical updates still live in `updates`, so hooks see the
    -+	 * operation like any other reference transaction. The fields below
    -+	 * retain the state that backends verify after taking their locks.
    -+	 */
    -+	enum ref_transaction_type type;
    -+	char *old_refname;
    -+	char *new_refname;
    -+	char *logmsg;
    -+	struct object_id source_oid;
    -+	struct object_id destination_oid;
    -+	char *destination_target;
    -+	unsigned int destination_exists:1;
      };
      
    ++/* Suppress hooks for a transaction nested inside another refs operation. */
    ++#define REF_TRANSACTION_FLAG_SKIP_HOOK (1 << 2)
    ++
    ++struct ref_update *ref_transaction_copy_or_rename_update(
    ++	struct ref_transaction *transaction);
    ++
      /*
    +  * Check for entries in extras that are within the specified
    +  * directory, where dirname is a reference directory name including
     @@ refs/refs-internal.h: typedef int optimize_required_fn(struct ref_store *ref_store,
      				 struct refs_optimize_opts *opts,
      				 bool *required);
    @@ refs/reftable-backend.c: static int reftable_be_transaction_prepare(struct ref_s
      	size_t i;
      	int ret;
      
    -+	if (transaction->type != REF_TRANSACTION_TYPE_NORMAL)
    ++	if (ref_transaction_copy_or_rename_update(transaction))
     +		return reftable_be_copy_or_rename_prepare(ref_store, transaction,
     +							   err);
     +
    @@ refs/reftable-backend.c: static int reftable_be_transaction_abort(struct ref_sto
     -	struct reftable_transaction_data *tx_data = transaction->backend_data;
     +	struct reftable_transaction_data *tx_data;
     +
    -+	if (transaction->type != REF_TRANSACTION_TYPE_NORMAL) {
    ++	if (ref_transaction_copy_or_rename_update(transaction)) {
     +		struct reftable_copy_or_rename_transaction_data *data =
     +			transaction->backend_data;
     +
    @@ refs/reftable-backend.c: static int reftable_be_transaction_finish(struct ref_st
     +	struct reftable_transaction_data *tx_data;
      	int ret = 0;
      
    -+	if (transaction->type != REF_TRANSACTION_TYPE_NORMAL) {
    ++	if (ref_transaction_copy_or_rename_update(transaction)) {
     +		struct reftable_copy_or_rename_transaction_data *data =
     +			transaction->backend_data;
     +		int special_ret = reftable_addition_commit(data->addition);
    @@ refs/reftable-backend.c: struct write_create_symref_arg {
      	const char *newname;
      	const char *logmsg;
      	int delete_old;
    -+	struct ref_transaction *transaction;
    ++	struct ref_copy_or_rename_update *operation;
      };
      
      static int write_copy_table(struct reftable_writer *writer, void *cb_data)
    @@ refs/reftable-backend.c: static int write_copy_table(struct reftable_writer *wri
     +		ret = -1;
      		goto done;
      	}
    -+	if (arg->transaction) {
    ++	if (arg->operation) {
     +		struct object_id oid;
     +
     +		if (old_ref.value_type == REFTABLE_REF_VAL2)
    @@ refs/reftable-backend.c: static int write_copy_table(struct reftable_writer *wri
     +		else
     +			oidread(&oid, old_ref.value.val1,
     +				arg->refs->base.repo->hash_algo);
    -+		if (!oideq(&oid, &arg->transaction->source_oid)) {
    ++		if (!oideq(&oid, &arg->operation->source_oid)) {
     +			strbuf_addf(arg->err,
     +				    _("refname %s is at %s but expected %s"),
     +				    arg->oldname, oid_to_hex(&oid),
    -+				    oid_to_hex(&arg->transaction->source_oid));
    ++				    oid_to_hex(&arg->operation->source_oid));
     +			ret = -1;
     +			goto done;
     +		}
    @@ refs/reftable-backend.c: static int write_copy_table(struct reftable_writer *wri
     +					      &destination_ref);
     +		if (ret < 0)
     +			goto done;
    -+		if (arg->transaction->destination_exists != !ret) {
    ++		if (arg->operation->destination_exists != !ret) {
     +			strbuf_addf(arg->err,
     +				    _("refname %s changed while renaming"),
     +				    arg->newname);
    @@ refs/reftable-backend.c: static int write_copy_table(struct reftable_writer *wri
     +		}
     +		if (!ret) {
     +			if (destination_ref.value_type == REFTABLE_REF_SYMREF) {
    -+				if (!arg->transaction->destination_target ||
    ++				if (!arg->operation->destination_target ||
     +				    strcmp(destination_ref.value.symref,
    -+					   arg->transaction->destination_target)) {
    ++					   arg->operation->destination_target)) {
     +					strbuf_addf(arg->err,
     +						    _("refname %s changed while renaming"),
     +						    arg->newname);
    @@ refs/reftable-backend.c: static int write_copy_table(struct reftable_writer *wri
     +				else
     +					oidread(&oid, destination_ref.value.val1,
     +						arg->refs->base.repo->hash_algo);
    -+				if (arg->transaction->destination_target ||
    -+				    !oideq(&oid, &arg->transaction->destination_oid)) {
    ++				if (arg->operation->destination_target ||
    ++				    !oideq(&oid, &arg->operation->destination_oid)) {
     +					strbuf_addf(arg->err,
     +						    _("refname %s changed while renaming"),
     +						    arg->newname);
    @@ refs/reftable-backend.c: static int write_copy_table(struct reftable_writer *wri
     +		reftable_be_downcast(ref_store, REF_STORE_WRITE,
     +				     "ref_transaction_prepare");
     +	struct reftable_copy_or_rename_transaction_data *data = NULL;
    ++	struct ref_update *update =
    ++		ref_transaction_copy_or_rename_update(transaction);
    ++	struct ref_copy_or_rename_update *operation = update->copy_or_rename;
      	struct write_copy_arg arg = {
      		.refs = refs,
     -		.oldname = oldrefname,
    @@ refs/reftable-backend.c: static int write_copy_table(struct reftable_writer *wri
     -		.logmsg = logmsg,
     -		.delete_old = 1,
     +		.err = err,
    -+		.oldname = transaction->old_refname,
    -+		.newname = transaction->new_refname,
    -+		.logmsg = transaction->logmsg,
    -+		.delete_old = transaction->type == REF_TRANSACTION_TYPE_RENAME,
    -+		.transaction = transaction,
    ++		.oldname = operation->old_refname,
    ++		.newname = update->refname,
    ++		.logmsg = operation->logmsg,
    ++		.delete_old = operation->type == REF_UPDATE_RENAME,
    ++		.operation = operation,
      	};
      	int ret;
      
    @@ refs/reftable-backend.c: static int write_copy_table(struct reftable_writer *wri
      		goto done;
     -
     -	ret = backend_for(&arg.be, refs, newrefname, &newrefname, 1);
    -+	ret = backend_for(&arg.be, refs, transaction->new_refname,
    ++	ret = backend_for(&arg.be, refs, update->refname,
     +			  &arg.newname, 1);
      	if (ret)
      		goto done;

 refs.c                           | 161 ++++++++++++++---
 refs/debug.c                     |  25 ---
 refs/files-backend.c             | 297 +++++++++++++++++++++++++++----
 refs/packed-backend.c            |   2 -
 refs/refs-internal.h             |  47 +++--
 refs/reftable-backend.c          | 197 +++++++++++++++-----
 t/t1416-ref-transaction-hooks.sh | 142 +++++++++++++++
 7 files changed, 732 insertions(+), 139 deletions(-)

diff --git a/refs.c b/refs.c
index 92d5df5b7..f036ae4b9 100644
--- a/refs.c
+++ b/refs.c
@@ -1004,15 +1004,17 @@ long get_files_ref_lock_timeout_ms(struct repository *repo)
 	return timeout_ms;
 }
 
-int refs_delete_ref(struct ref_store *refs, const char *msg,
-		    const char *refname,
-		    const struct object_id *old_oid,
-		    unsigned int flags)
+int refs_delete_ref_with_transaction_flags(struct ref_store *refs,
+					   const char *msg,
+					   const char *refname,
+					   const struct object_id *old_oid,
+					   unsigned int flags,
+					   unsigned int transaction_flags)
 {
 	struct ref_transaction *transaction;
 	struct strbuf err = STRBUF_INIT;
 
-	transaction = ref_store_transaction_begin(refs, 0, &err);
+	transaction = ref_store_transaction_begin(refs, transaction_flags, &err);
 	if (!transaction ||
 	    ref_transaction_delete(transaction, refname, old_oid,
 				   NULL, flags, msg, &err) ||
@@ -1027,6 +1029,15 @@ int refs_delete_ref(struct ref_store *refs, const char *msg,
 	return 0;
 }
 
+int refs_delete_ref(struct ref_store *refs, const char *msg,
+		    const char *refname,
+		    const struct object_id *old_oid,
+		    unsigned int flags)
+{
+	return refs_delete_ref_with_transaction_flags(refs, msg, refname,
+						      old_oid, flags, 0);
+}
+
 static void copy_reflog_msg(struct strbuf *sb, const char *msg)
 {
 	char c;
@@ -1256,11 +1267,20 @@ void ref_transaction_free(struct ref_transaction *transaction)
 	}
 
 	for (i = 0; i < transaction->nr; i++) {
+		struct ref_copy_or_rename_update *operation =
+			transaction->updates[i]->copy_or_rename;
+
 		free(transaction->updates[i]->msg);
 		free(transaction->updates[i]->committer_info);
 		free((char *)transaction->updates[i]->new_target);
 		free((char *)transaction->updates[i]->old_target);
 		free((char *)transaction->updates[i]->rejection_details);
+		if (operation) {
+			free(operation->old_refname);
+			free(operation->logmsg);
+			free(operation->destination_target);
+			free(operation);
+		}
 		free(transaction->updates[i]);
 	}
 
@@ -1273,6 +1293,23 @@ void ref_transaction_free(struct ref_transaction *transaction)
 	free(transaction);
 }
 
+struct ref_update *ref_transaction_copy_or_rename_update(
+	struct ref_transaction *transaction)
+{
+	struct ref_update *operation = NULL;
+	size_t i;
+
+	for (i = 0; i < transaction->nr; i++) {
+		if (!transaction->updates[i]->copy_or_rename)
+			continue;
+		if (operation)
+			BUG("multiple copy or rename updates in one transaction");
+		operation = transaction->updates[i];
+	}
+
+	return operation;
+}
+
 int ref_transaction_maybe_set_rejected(struct ref_transaction *transaction,
 				       size_t update_idx,
 				       enum ref_transaction_error err,
@@ -2710,7 +2747,8 @@ int ref_transaction_prepare(struct ref_transaction *transaction,
 		return REF_TRANSACTION_ERROR_GENERIC;
 
 	/* Preparing checks before locking references */
-	ret = run_transaction_hook(transaction, "preparing");
+	ret = transaction->flags & REF_TRANSACTION_FLAG_SKIP_HOOK ? 0 :
+		run_transaction_hook(transaction, "preparing");
 	if (ret) {
 		ref_transaction_abort(transaction, err);
 		die(_(abort_by_ref_transaction_hook), "preparing");
@@ -2720,7 +2758,8 @@ int ref_transaction_prepare(struct ref_transaction *transaction,
 	if (ret)
 		return ret;
 
-	ret = run_transaction_hook(transaction, "prepared");
+	ret = transaction->flags & REF_TRANSACTION_FLAG_SKIP_HOOK ? 0 :
+		run_transaction_hook(transaction, "prepared");
 	if (ret) {
 		ref_transaction_abort(transaction, err);
 		die(_(abort_by_ref_transaction_hook), "prepared");
@@ -2750,7 +2789,8 @@ int ref_transaction_abort(struct ref_transaction *transaction,
 		break;
 	}
 
-	run_transaction_hook(transaction, "aborted");
+	if (!(transaction->flags & REF_TRANSACTION_FLAG_SKIP_HOOK))
+		run_transaction_hook(transaction, "aborted");
 
 	ref_transaction_free(transaction);
 	return ret;
@@ -2781,7 +2821,8 @@ int ref_transaction_commit(struct ref_transaction *transaction,
 	}
 
 	ret = refs->be->transaction_finish(refs, transaction, err);
-	if (!ret && !(transaction->flags & REF_TRANSACTION_FLAG_INITIAL))
+	if (!ret && !(transaction->flags & (REF_TRANSACTION_FLAG_INITIAL |
+					 REF_TRANSACTION_FLAG_SKIP_HOOK)))
 		run_transaction_hook(transaction, "committed");
 	return ret;
 }
@@ -3123,28 +3164,102 @@ int refs_delete_refs(struct ref_store *refs, const char *logmsg,
 	return ret;
 }
 
-int refs_rename_ref(struct ref_store *refs, const char *oldref,
-		    const char *newref, const char *logmsg)
+static int refs_copy_or_rename_ref(struct ref_store *refs, const char *oldref,
+				   const char *newref, const char *logmsg,
+				   bool copy)
 {
-	char *msg;
-	int retval;
+	struct ref_transaction *transaction = NULL;
+	struct ref_copy_or_rename_update *operation = NULL;
+	struct ref_update *destination_update;
+	struct object_id old_oid, new_oid;
+	struct strbuf new_target = STRBUF_INIT;
+	struct strbuf err = STRBUF_INIT;
+	char *msg = normalize_reflog_message(logmsg);
+	int old_flags, new_flags = 0, new_exists = 0, ret = 1;
 
-	msg = normalize_reflog_message(logmsg);
-	retval = refs->be->rename_ref(refs, oldref, newref, msg);
+	if (!strcmp(oldref, newref)) {
+		ret = 0;
+		goto out;
+	}
+
+	if (!refs_resolve_ref_unsafe(refs, oldref,
+				     RESOLVE_REF_READING | RESOLVE_REF_NO_RECURSE,
+				     &old_oid, &old_flags)) {
+		error("refname %s not found", oldref);
+		goto out;
+	}
+	if (old_flags & REF_ISSYMREF) {
+		error("refname %s is a symbolic ref, %s it is not supported",
+		      oldref, copy ? "copying" : "renaming");
+		goto out;
+	}
+
+	transaction = ref_store_transaction_begin(refs, 0, &err);
+	if (!transaction)
+		goto error;
+	if (!copy && ref_transaction_delete(transaction, oldref, &old_oid, NULL,
+					    REF_NO_DEREF, msg, &err))
+		goto error;
+
+	if (refs_resolve_ref_unsafe(refs, newref,
+				    RESOLVE_REF_READING | RESOLVE_REF_NO_RECURSE,
+				    &new_oid, &new_flags)) {
+		new_exists = 1;
+		if ((new_flags & REF_ISSYMREF) &&
+		    refs_read_symbolic_ref(refs, newref, &new_target) < 0) {
+			strbuf_addf(&err, "unable to read symbolic ref %s", newref);
+			goto error;
+		}
+	} else {
+		oidclr(&new_oid, refs->repo->hash_algo);
+	}
+	if (ref_transaction_update(transaction, newref, &old_oid,
+				   (new_flags & REF_ISSYMREF) ? NULL : &new_oid,
+				   NULL,
+				   (new_flags & REF_ISSYMREF) ? new_target.buf : NULL,
+				   REF_NO_DEREF | REF_SKIP_CREATE_REFLOG,
+				   NULL, &err))
+		goto error;
+
+	destination_update = transaction->updates[transaction->nr - 1];
+	CALLOC_ARRAY(operation, 1);
+	operation->type = copy ? REF_UPDATE_COPY : REF_UPDATE_RENAME;
+	operation->old_refname = xstrdup(oldref);
+	operation->logmsg = xstrdup(msg);
+	oidcpy(&operation->source_oid, &old_oid);
+	operation->destination_exists = new_exists;
+	if (new_flags & REF_ISSYMREF)
+		operation->destination_target = xstrdup(new_target.buf);
+	else if (operation->destination_exists)
+		oidcpy(&operation->destination_oid, &new_oid);
+	destination_update->copy_or_rename = operation;
+
+	if (ref_transaction_commit(transaction, &err))
+		goto error;
+
+	ret = 0;
+	goto out;
+
+error:
+	error("%s", err.buf);
+out:
+	ref_transaction_free(transaction);
+	strbuf_release(&new_target);
+	strbuf_release(&err);
 	free(msg);
-	return retval;
+	return ret;
 }
 
-int refs_copy_existing_ref(struct ref_store *refs, const char *oldref,
+int refs_rename_ref(struct ref_store *refs, const char *oldref,
 		    const char *newref, const char *logmsg)
 {
-	char *msg;
-	int retval;
+	return refs_copy_or_rename_ref(refs, oldref, newref, logmsg, 0);
+}
 
-	msg = normalize_reflog_message(logmsg);
-	retval = refs->be->copy_ref(refs, oldref, newref, msg);
-	free(msg);
-	return retval;
+int refs_copy_existing_ref(struct ref_store *refs, const char *oldref,
+		    const char *newref, const char *logmsg)
+{
+	return refs_copy_or_rename_ref(refs, oldref, newref, logmsg, 1);
 }
 
 const char *ref_update_original_update_refname(struct ref_update *update)
diff --git a/refs/debug.c b/refs/debug.c
index 639db0f26..87b84e767 100644
--- a/refs/debug.c
+++ b/refs/debug.c
@@ -143,28 +143,6 @@ static int debug_optimize_required(struct ref_store *ref_store,
 	return res;
 }
 
-static int debug_rename_ref(struct ref_store *ref_store, const char *oldref,
-			    const char *newref, const char *logmsg)
-{
-	struct debug_ref_store *drefs = (struct debug_ref_store *)ref_store;
-	int res = drefs->refs->be->rename_ref(drefs->refs, oldref, newref,
-					      logmsg);
-	trace_printf_key(&trace_refs, "rename_ref: %s -> %s \"%s\": %d\n", oldref, newref,
-		logmsg, res);
-	return res;
-}
-
-static int debug_copy_ref(struct ref_store *ref_store, const char *oldref,
-			  const char *newref, const char *logmsg)
-{
-	struct debug_ref_store *drefs = (struct debug_ref_store *)ref_store;
-	int res =
-		drefs->refs->be->copy_ref(drefs->refs, oldref, newref, logmsg);
-	trace_printf_key(&trace_refs, "copy_ref: %s -> %s \"%s\": %d\n", oldref, newref,
-		logmsg, res);
-	return res;
-}
-
 struct debug_ref_iterator {
 	struct ref_iterator base;
 	struct ref_iterator *iter;
@@ -453,9 +431,6 @@ struct ref_storage_be refs_be_debug = {
 	.optimize = debug_optimize,
 	.optimize_required = debug_optimize_required,
 
-	.rename_ref = debug_rename_ref,
-	.copy_ref = debug_copy_ref,
-
 	.iterator_begin = debug_ref_iterator_begin,
 	.read_raw_ref = debug_read_raw_ref,
 	.read_symbolic_ref = debug_read_symbolic_ref,
diff --git a/refs/files-backend.c b/refs/files-backend.c
index 71628550f..c28228116 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -1594,6 +1594,7 @@ static int files_optimize_required(struct ref_store *ref_store,
  * live into logs/refs.
  */
 #define TMP_RENAMED_LOG  "refs/.tmp-renamed-log"
+#define TMP_RENAMED_LOG_DESTINATION "refs/.tmp-renamed-log-destination"
 
 struct rename_cb {
 	const char *tmp_renamed_log;
@@ -1685,12 +1686,28 @@ static int refs_rename_ref_available(struct ref_store *refs,
 	return ok;
 }
 
+struct files_copy_or_rename_transaction_data {
+	struct ref_lock *lock;
+	struct object_id orig_oid;
+	struct object_id destination_oid;
+	char *destination_target;
+	int logmoved;
+	int destination_exists;
+	int destination_log_backed_up;
+};
+
 static int files_copy_or_rename_ref(struct ref_store *ref_store,
-			    const char *oldrefname, const char *newrefname,
-			    const char *logmsg, int copy)
+				    struct ref_update *update,
+				    struct ref_transaction *transaction)
 {
 	struct files_ref_store *refs =
-		files_downcast(ref_store, REF_STORE_WRITE, "rename_ref");
+		files_downcast(ref_store, REF_STORE_WRITE,
+			       "ref_transaction_prepare");
+	struct ref_copy_or_rename_update *operation = update->copy_or_rename;
+	const char *oldrefname = operation->old_refname;
+	const char *newrefname = update->refname;
+	const char *logmsg = operation->logmsg;
+	bool copy = operation->type == REF_UPDATE_COPY;
 	struct object_id orig_oid;
 	int flag = 0, logmoved = 0;
 	struct ref_lock *lock;
@@ -1698,12 +1715,19 @@ static int files_copy_or_rename_ref(struct ref_store *ref_store,
 	struct strbuf sb_oldref = STRBUF_INIT;
 	struct strbuf sb_newref = STRBUF_INIT;
 	struct strbuf tmp_renamed_log = STRBUF_INIT;
+	struct strbuf tmp_destination_log = STRBUF_INIT;
+	struct strbuf destination_target = STRBUF_INIT;
 	int log, ret;
+	int destination_exists = 0, destination_flags = 0;
+	int destination_log_backed_up = 0;
+	struct object_id destination_oid;
+	struct files_copy_or_rename_transaction_data *data;
 	struct strbuf err = STRBUF_INIT;
 
 	files_reflog_path(refs, &sb_oldref, oldrefname);
 	files_reflog_path(refs, &sb_newref, newrefname);
 	files_reflog_path(refs, &tmp_renamed_log, TMP_RENAMED_LOG);
+	files_reflog_path(refs, &tmp_destination_log, TMP_RENAMED_LOG_DESTINATION);
 
 	log = !lstat(sb_oldref.buf, &loginfo);
 	if (log && S_ISLNK(loginfo.st_mode)) {
@@ -1727,11 +1751,67 @@ static int files_copy_or_rename_ref(struct ref_store *ref_store,
 				    oldrefname);
 		goto out;
 	}
+	if (!oideq(&orig_oid, &operation->source_oid)) {
+		ret = error("refname %s is at %s but expected %s",
+			    oldrefname, oid_to_hex(&orig_oid),
+			    oid_to_hex(&operation->source_oid));
+		goto out;
+	}
 	if (!refs_rename_ref_available(&refs->base, oldrefname, newrefname)) {
 		ret = 1;
 		goto out;
 	}
 
+	if (refs_resolve_ref_unsafe(&refs->base, newrefname,
+				    RESOLVE_REF_READING | RESOLVE_REF_NO_RECURSE,
+				    &destination_oid, &destination_flags)) {
+		destination_exists = 1;
+		if ((destination_flags & REF_ISSYMREF) &&
+		    refs_read_symbolic_ref(&refs->base, newrefname,
+					   &destination_target) < 0) {
+			ret = error("unable to read symbolic ref %s", newrefname);
+			goto out;
+		}
+	}
+	if (destination_exists != operation->destination_exists) {
+		ret = error("refname %s changed while renaming", newrefname);
+		goto out;
+	}
+	if (destination_exists) {
+		if (destination_flags & REF_ISSYMREF) {
+			if (!operation->destination_target ||
+			    strcmp(destination_target.buf,
+				   operation->destination_target)) {
+				ret = error("refname %s changed while renaming",
+					    newrefname);
+				goto out;
+			}
+		} else if (operation->destination_target ||
+			   !oideq(&destination_oid,
+				  &operation->destination_oid)) {
+			ret = error("refname %s changed while renaming", newrefname);
+			goto out;
+		}
+	}
+
+	if (!lstat(sb_newref.buf, &loginfo)) {
+		if (S_ISLNK(loginfo.st_mode)) {
+			ret = error("reflog for %s is a symlink", newrefname);
+			goto out;
+		}
+		if (S_ISREG(loginfo.st_mode)) {
+			if (copy_file(refs->base.repo, tmp_destination_log.buf,
+				      sb_newref.buf, 0644)) {
+				if (errno != EEXIST)
+					unlink(tmp_destination_log.buf);
+				ret = error("unable to back up logfile logs/%s: %s",
+					    newrefname, strerror(errno));
+				goto out;
+			}
+			destination_log_backed_up = 1;
+		}
+	}
+
 	if (!copy && log && rename(sb_oldref.buf, tmp_renamed_log.buf)) {
 		ret = error("unable to move logfile logs/%s to logs/"TMP_RENAMED_LOG": %s",
 			    oldrefname, strerror(errno));
@@ -1744,8 +1824,10 @@ static int files_copy_or_rename_ref(struct ref_store *ref_store,
 		goto out;
 	}
 
-	if (!copy && refs_delete_ref(&refs->base, logmsg, oldrefname,
-			    &orig_oid, REF_NO_DEREF)) {
+	if (!copy && refs_delete_ref_with_transaction_flags(&refs->base, logmsg,
+							 oldrefname, &orig_oid,
+							 REF_NO_DEREF,
+							 REF_TRANSACTION_FLAG_SKIP_HOOK)) {
 		error("unable to delete old %s", oldrefname);
 		goto rollback;
 	}
@@ -1760,8 +1842,9 @@ static int files_copy_or_rename_ref(struct ref_store *ref_store,
 	if (!copy && refs_resolve_ref_unsafe(&refs->base, newrefname,
 					     RESOLVE_REF_READING | RESOLVE_REF_NO_RECURSE,
 					     NULL, NULL) &&
-	    refs_delete_ref(&refs->base, NULL, newrefname,
-			    NULL, REF_NO_DEREF)) {
+	    refs_delete_ref_with_transaction_flags(&refs->base, NULL, newrefname,
+						     NULL, REF_NO_DEREF,
+						     REF_TRANSACTION_FLAG_SKIP_HOOK)) {
 		if (errno == EISDIR) {
 			struct strbuf path = STRBUF_INIT;
 			int result;
@@ -1796,13 +1879,25 @@ static int files_copy_or_rename_ref(struct ref_store *ref_store,
 	}
 	oidcpy(&lock->old_oid, &orig_oid);
 
-	if (write_ref_to_lockfile(refs, lock, &orig_oid, &err) ||
-	    commit_ref_update(refs, lock, &orig_oid, logmsg, 0, &err)) {
+	if (write_ref_to_lockfile(refs, lock, &orig_oid, &err)) {
 		error("unable to write current sha1 into %s: %s", newrefname, err.buf);
 		strbuf_release(&err);
 		goto rollback;
 	}
 
+	CALLOC_ARRAY(data, 1);
+	data->lock = lock;
+	oidcpy(&data->orig_oid, &orig_oid);
+	data->logmoved = logmoved;
+	data->destination_exists = destination_exists;
+	data->destination_log_backed_up = destination_log_backed_up;
+	if (destination_exists && !(destination_flags & REF_ISSYMREF))
+		oidcpy(&data->destination_oid, &destination_oid);
+	if (destination_flags & REF_ISSYMREF)
+		data->destination_target = strbuf_detach(&destination_target, NULL);
+	transaction->backend_data = data;
+	transaction->state = REF_TRANSACTION_PREPARED;
+
 	ret = 0;
 	goto out;
 
@@ -1821,38 +1916,40 @@ static int files_copy_or_rename_ref(struct ref_store *ref_store,
 	}
 
  rollbacklog:
-	if (logmoved && rename(sb_newref.buf, sb_oldref.buf))
-		error("unable to restore logfile %s from %s: %s",
-			oldrefname, newrefname, strerror(errno));
+	if (logmoved) {
+		if (rename(sb_newref.buf, tmp_renamed_log.buf)) {
+			error("unable to restore logfile %s from %s: %s",
+			      oldrefname, newrefname, strerror(errno));
+		} else {
+			try_remove_empty_parents(refs, newrefname,
+						 REMOVE_EMPTY_PARENTS_REFLOG);
+			if (rename_tmp_log(refs, oldrefname))
+				error("unable to restore logfile %s from logs/"
+				      TMP_RENAMED_LOG ": %s",
+				      oldrefname, strerror(errno));
+		}
+	}
 	if (!logmoved && log &&
 	    rename(tmp_renamed_log.buf, sb_oldref.buf))
 		error("unable to restore logfile %s from logs/"TMP_RENAMED_LOG": %s",
 			oldrefname, strerror(errno));
+	if (destination_log_backed_up &&
+	    rename(tmp_destination_log.buf, sb_newref.buf))
+		error("unable to restore logfile %s: %s",
+		      newrefname, strerror(errno));
 	ret = 1;
  out:
+	if (ret && destination_log_backed_up)
+		unlink(tmp_destination_log.buf);
 	strbuf_release(&sb_newref);
 	strbuf_release(&sb_oldref);
 	strbuf_release(&tmp_renamed_log);
+	strbuf_release(&tmp_destination_log);
+	strbuf_release(&destination_target);
 
 	return ret;
 }
 
-static int files_rename_ref(struct ref_store *ref_store,
-			    const char *oldrefname, const char *newrefname,
-			    const char *logmsg)
-{
-	return files_copy_or_rename_ref(ref_store, oldrefname,
-				 newrefname, logmsg, 0);
-}
-
-static int files_copy_ref(struct ref_store *ref_store,
-			    const char *oldrefname, const char *newrefname,
-			    const char *logmsg)
-{
-	return files_copy_or_rename_ref(ref_store, oldrefname,
-				 newrefname, logmsg, 1);
-}
-
 static int close_ref_gently(struct ref_lock *lock)
 {
 	if (close_lock_file_gently(&lock->lk))
@@ -2962,6 +3059,14 @@ static int files_transaction_prepare(struct ref_store *ref_store,
 	struct ref_transaction *packed_transaction = NULL;
 
 	assert(err);
+	{
+		struct ref_update *operation =
+			ref_transaction_copy_or_rename_update(transaction);
+
+		if (operation)
+			return files_copy_or_rename_ref(ref_store, operation,
+							transaction);
+	}
 
 	if (transaction->flags & REF_TRANSACTION_FLAG_INITIAL)
 		goto cleanup;
@@ -3318,6 +3423,10 @@ static int files_transaction_finish_initial(struct files_ref_store *refs,
 	return ret;
 }
 
+static int files_transaction_abort(struct ref_store *ref_store,
+				   struct ref_transaction *transaction,
+				   struct strbuf *err);
+
 static int files_transaction_finish(struct ref_store *ref_store,
 				    struct ref_transaction *transaction,
 				    struct strbuf *err)
@@ -3333,6 +3442,40 @@ static int files_transaction_finish(struct ref_store *ref_store,
 
 
 	assert(err);
+	{
+		struct ref_update *update =
+			ref_transaction_copy_or_rename_update(transaction);
+
+		if (update) {
+			struct ref_copy_or_rename_update *operation =
+				update->copy_or_rename;
+			struct files_copy_or_rename_transaction_data *data =
+				transaction->backend_data;
+			int special_ret;
+
+			special_ret = commit_ref_update(refs, data->lock, &data->orig_oid,
+							operation->logmsg, 0, err);
+			if (special_ret) {
+				error("unable to write current sha1 into %s: %s",
+				      update->refname, err->buf);
+				data->lock = NULL;
+				files_transaction_abort(ref_store, transaction, err);
+				return special_ret;
+			} else if (data->destination_log_backed_up) {
+				struct strbuf path = STRBUF_INIT;
+
+				files_reflog_path(refs, &path, TMP_RENAMED_LOG_DESTINATION);
+				if (unlink(path.buf) < 0 && errno != ENOENT)
+					warning_errno("unable to remove '%s'", path.buf);
+				strbuf_release(&path);
+			}
+			free(data->destination_target);
+			free(data);
+			transaction->backend_data = NULL;
+			transaction->state = REF_TRANSACTION_CLOSED;
+			return special_ret;
+		}
+	}
 
 	if (transaction->flags & REF_TRANSACTION_FLAG_INITIAL)
 		return files_transaction_finish_initial(refs, transaction, err);
@@ -3476,11 +3619,105 @@ static int files_transaction_finish(struct ref_store *ref_store,
 
 static int files_transaction_abort(struct ref_store *ref_store,
 				   struct ref_transaction *transaction,
-				   struct strbuf *err UNUSED)
+				   struct strbuf *err)
 {
 	struct files_ref_store *refs =
 		files_downcast(ref_store, 0, "ref_transaction_abort");
 
+	{
+		struct ref_update *update =
+			ref_transaction_copy_or_rename_update(transaction);
+
+		if (update) {
+			struct ref_copy_or_rename_update *operation =
+				update->copy_or_rename;
+			struct files_copy_or_rename_transaction_data *data =
+				transaction->backend_data;
+			struct strbuf new_log = STRBUF_INIT;
+			struct strbuf destination_log = STRBUF_INIT;
+			struct strbuf temporary_log = STRBUF_INIT;
+			struct ref_transaction *restore_transaction = NULL;
+			struct ref_lock *lock;
+			int ret = 0;
+
+			if (data->lock)
+				unlock_ref(data->lock);
+			if (operation->type == REF_UPDATE_RENAME) {
+				lock = lock_ref_oid_basic(refs, operation->old_refname, err);
+				if (!lock ||
+				    write_ref_to_lockfile(refs, lock, &data->orig_oid, err) ||
+				    commit_ref_update(refs, lock, &data->orig_oid, NULL,
+						      REF_SKIP_CREATE_REFLOG, err))
+					ret = -1;
+			}
+
+			if (data->logmoved) {
+				files_reflog_path(refs, &new_log, update->refname);
+				if (operation->type == REF_UPDATE_RENAME) {
+					files_reflog_path(refs, &temporary_log, TMP_RENAMED_LOG);
+					if (rename(new_log.buf, temporary_log.buf) < 0) {
+						strbuf_addf(err, "unable to restore logfile %s: %s",
+							    operation->old_refname, strerror(errno));
+						ret = -1;
+					} else {
+						try_remove_empty_parents(refs,
+									 update->refname,
+									 REMOVE_EMPTY_PARENTS_REFLOG);
+						if (rename_tmp_log(refs,
+								   operation->old_refname)) {
+							strbuf_addf(err, "unable to restore logfile %s: %s",
+								    operation->old_refname,
+								    strerror(errno));
+							ret = -1;
+						}
+					}
+				} else if (unlink(new_log.buf) < 0 && errno != ENOENT) {
+					strbuf_addf(err, "unable to remove logfile %s: %s",
+						    update->refname, strerror(errno));
+					ret = -1;
+				}
+			}
+			if (data->destination_log_backed_up) {
+				files_reflog_path(refs, &destination_log,
+						  TMP_RENAMED_LOG_DESTINATION);
+				if (rename(destination_log.buf, new_log.buf) < 0) {
+					strbuf_addf(err, "unable to restore logfile %s: %s",
+						    update->refname, strerror(errno));
+					ret = -1;
+				}
+			}
+
+			if (operation->type == REF_UPDATE_RENAME &&
+			    data->destination_exists) {
+				restore_transaction = ref_store_transaction_begin(
+					&refs->base, REF_TRANSACTION_FLAG_SKIP_HOOK, err);
+				if (!restore_transaction ||
+				    ref_transaction_update(restore_transaction,
+							   update->refname,
+							   data->destination_target ? NULL :
+										      &data->destination_oid,
+							   NULL,
+							   data->destination_target,
+							   NULL,
+							   REF_NO_DEREF |
+								   REF_SKIP_CREATE_REFLOG,
+							   NULL, err) ||
+				    ref_transaction_commit(restore_transaction, err))
+					ret = -1;
+				ref_transaction_free(restore_transaction);
+			}
+
+			strbuf_release(&destination_log);
+			strbuf_release(&temporary_log);
+			strbuf_release(&new_log);
+			free(data->destination_target);
+			free(data);
+			transaction->backend_data = NULL;
+			transaction->state = REF_TRANSACTION_CLOSED;
+			return ret;
+		}
+	}
+
 	files_transaction_cleanup(refs, transaction);
 	return 0;
 }
@@ -4095,8 +4332,6 @@ struct ref_storage_be refs_be_files = {
 
 	.optimize = files_optimize,
 	.optimize_required = files_optimize_required,
-	.rename_ref = files_rename_ref,
-	.copy_ref = files_copy_ref,
 
 	.iterator_begin = files_ref_iterator_begin,
 	.read_raw_ref = files_read_raw_ref,
diff --git a/refs/packed-backend.c b/refs/packed-backend.c
index a73fc6aca..364a91291 100644
--- a/refs/packed-backend.c
+++ b/refs/packed-backend.c
@@ -2164,8 +2164,6 @@ struct ref_storage_be refs_be_packed = {
 	.optimize = packed_optimize,
 	.optimize_required = packed_optimize_required,
 
-	.rename_ref = NULL,
-	.copy_ref = NULL,
 
 	.iterator_begin = packed_ref_iterator_begin,
 	.read_raw_ref = packed_read_raw_ref,
diff --git a/refs/refs-internal.h b/refs/refs-internal.h
index c3ac7b556..5d4dc0171 100644
--- a/refs/refs-internal.h
+++ b/refs/refs-internal.h
@@ -155,9 +155,33 @@ struct ref_update {
 	 */
 	struct ref_update *parent_update;
 
+	/*
+	 * Copy and rename operations require backend-specific handling while
+	 * still exposing their logical updates to transaction hooks. Keep that
+	 * state on the destination update so it composes with other updates in
+	 * the transaction instead of making copy or rename a transaction-wide
+	 * property.
+	 */
+	struct ref_copy_or_rename_update *copy_or_rename;
+
 	const char refname[FLEX_ARRAY];
 };
 
+enum ref_copy_or_rename_type {
+	REF_UPDATE_RENAME,
+	REF_UPDATE_COPY,
+};
+
+struct ref_copy_or_rename_update {
+	enum ref_copy_or_rename_type type;
+	char *old_refname;
+	char *logmsg;
+	struct object_id source_oid;
+	struct object_id destination_oid;
+	char *destination_target;
+	unsigned int destination_exists:1;
+};
+
 int refs_read_raw_ref(struct ref_store *ref_store, const char *refname,
 		      struct object_id *oid, struct strbuf *referent,
 		      unsigned int *type, int *failure_errno);
@@ -187,6 +211,13 @@ struct ref_update *ref_transaction_add_update(
 		const char *committer_info,
 		const char *msg);
 
+int refs_delete_ref_with_transaction_flags(struct ref_store *refs,
+					   const char *msg,
+					   const char *refname,
+					   const struct object_id *old_oid,
+					   unsigned int flags,
+					   unsigned int transaction_flags);
+
 /*
  * Transaction states.
  *
@@ -242,6 +273,12 @@ struct ref_transaction {
 	uint64_t max_index;
 };
 
+/* Suppress hooks for a transaction nested inside another refs operation. */
+#define REF_TRANSACTION_FLAG_SKIP_HOOK (1 << 2)
+
+struct ref_update *ref_transaction_copy_or_rename_update(
+	struct ref_transaction *transaction);
+
 /*
  * Check for entries in extras that are within the specified
  * directory, where dirname is a reference directory name including
@@ -451,13 +488,6 @@ typedef int optimize_required_fn(struct ref_store *ref_store,
 				 struct refs_optimize_opts *opts,
 				 bool *required);
 
-typedef int rename_ref_fn(struct ref_store *ref_store,
-			  const char *oldref, const char *newref,
-			  const char *logmsg);
-typedef int copy_ref_fn(struct ref_store *ref_store,
-			  const char *oldref, const char *newref,
-			  const char *logmsg);
-
 /*
  * Iterate over the references in `ref_store` whose names start with
  * `prefix`. `prefix` is matched as a literal string, without regard
@@ -577,9 +607,6 @@ struct ref_storage_be {
 
 	optimize_fn *optimize;
 	optimize_required_fn *optimize_required;
-	rename_ref_fn *rename_ref;
-	copy_ref_fn *copy_ref;
-
 	ref_iterator_begin_fn *iterator_begin;
 	read_raw_ref_fn *read_raw_ref;
 
diff --git a/refs/reftable-backend.c b/refs/reftable-backend.c
index 10db03991..589fcc998 100644
--- a/refs/reftable-backend.c
+++ b/refs/reftable-backend.c
@@ -953,6 +953,14 @@ struct reftable_transaction_data {
 	size_t args_nr, args_alloc;
 };
 
+struct reftable_copy_or_rename_transaction_data {
+	struct reftable_addition *addition;
+};
+
+static int reftable_be_copy_or_rename_prepare(struct ref_store *ref_store,
+					       struct ref_transaction *transaction,
+					       struct strbuf *err);
+
 static void free_transaction_data(struct reftable_transaction_data *tx_data)
 {
 	if (!tx_data)
@@ -1326,6 +1334,10 @@ static int reftable_be_transaction_prepare(struct ref_store *ref_store,
 	size_t i;
 	int ret;
 
+	if (ref_transaction_copy_or_rename_update(transaction))
+		return reftable_be_copy_or_rename_prepare(ref_store, transaction,
+							   err);
+
 	ret = refs->err;
 	if (ret < 0)
 		goto done;
@@ -1419,7 +1431,20 @@ static int reftable_be_transaction_abort(struct ref_store *ref_store UNUSED,
 					 struct ref_transaction *transaction,
 					 struct strbuf *err UNUSED)
 {
-	struct reftable_transaction_data *tx_data = transaction->backend_data;
+	struct reftable_transaction_data *tx_data;
+
+	if (ref_transaction_copy_or_rename_update(transaction)) {
+		struct reftable_copy_or_rename_transaction_data *data =
+			transaction->backend_data;
+
+		reftable_addition_destroy(data->addition);
+		free(data);
+		transaction->backend_data = NULL;
+		transaction->state = REF_TRANSACTION_CLOSED;
+		return 0;
+	}
+
+	tx_data = transaction->backend_data;
 	free_transaction_data(tx_data);
 	transaction->state = REF_TRANSACTION_CLOSED;
 	return 0;
@@ -1667,9 +1692,28 @@ static int reftable_be_transaction_finish(struct ref_store *ref_store UNUSED,
 					  struct ref_transaction *transaction,
 					  struct strbuf *err)
 {
-	struct reftable_transaction_data *tx_data = transaction->backend_data;
+	struct reftable_transaction_data *tx_data;
 	int ret = 0;
 
+	if (ref_transaction_copy_or_rename_update(transaction)) {
+		struct reftable_copy_or_rename_transaction_data *data =
+			transaction->backend_data;
+		int special_ret = reftable_addition_commit(data->addition);
+
+		reftable_addition_destroy(data->addition);
+		free(data);
+		transaction->backend_data = NULL;
+		transaction->state = REF_TRANSACTION_CLOSED;
+		if (special_ret < 0) {
+			strbuf_addf(err, _("reftable: transaction failure: %s"),
+				    reftable_error_str(special_ret));
+			return -1;
+		}
+		return 0;
+	}
+
+	tx_data = transaction->backend_data;
+
 	for (size_t i = 0; i < tx_data->args_nr; i++) {
 		tx_data->args[i].max_index = transaction->max_index;
 
@@ -1764,17 +1808,20 @@ struct write_create_symref_arg {
 struct write_copy_arg {
 	struct reftable_ref_store *refs;
 	struct reftable_backend *be;
+	struct strbuf *err;
 	const char *oldname;
 	const char *newname;
 	const char *logmsg;
 	int delete_old;
+	struct ref_copy_or_rename_update *operation;
 };
 
 static int write_copy_table(struct reftable_writer *writer, void *cb_data)
 {
 	struct write_copy_arg *arg = cb_data;
 	uint64_t deletion_ts, creation_ts;
-	struct reftable_ref_record old_ref = {0}, refs[2] = {0};
+	struct reftable_ref_record old_ref = {0}, destination_ref = {0};
+	struct reftable_ref_record refs[2] = {0};
 	struct reftable_log_record old_log = {0}, *logs = NULL;
 	struct reftable_iterator it = {0};
 	struct string_list skip = STRING_LIST_INIT_NODUP;
@@ -1789,14 +1836,75 @@ static int write_copy_table(struct reftable_writer *writer, void *cb_data)
 		BUG("failed splitting committer info");
 
 	if (reftable_stack_read_ref(arg->be->stack, arg->oldname, &old_ref)) {
-		ret = error(_("refname %s not found"), arg->oldname);
+		strbuf_addf(arg->err, _("refname %s not found"), arg->oldname);
+		ret = -1;
 		goto done;
 	}
 	if (old_ref.value_type == REFTABLE_REF_SYMREF) {
-		ret = error(_("refname %s is a symbolic ref, copying it is not supported"),
+		strbuf_addf(arg->err,
+			    _("refname %s is a symbolic ref, copying it is not supported"),
 			    arg->oldname);
+		ret = -1;
 		goto done;
 	}
+	if (arg->operation) {
+		struct object_id oid;
+
+		if (old_ref.value_type == REFTABLE_REF_VAL2)
+			oidread(&oid, old_ref.value.val2.value,
+				arg->refs->base.repo->hash_algo);
+		else
+			oidread(&oid, old_ref.value.val1,
+				arg->refs->base.repo->hash_algo);
+		if (!oideq(&oid, &arg->operation->source_oid)) {
+			strbuf_addf(arg->err,
+				    _("refname %s is at %s but expected %s"),
+				    arg->oldname, oid_to_hex(&oid),
+				    oid_to_hex(&arg->operation->source_oid));
+			ret = -1;
+			goto done;
+		}
+
+		ret = reftable_stack_read_ref(arg->be->stack, arg->newname,
+					      &destination_ref);
+		if (ret < 0)
+			goto done;
+		if (arg->operation->destination_exists != !ret) {
+			strbuf_addf(arg->err,
+				    _("refname %s changed while renaming"),
+				    arg->newname);
+			ret = -1;
+			goto done;
+		}
+		if (!ret) {
+			if (destination_ref.value_type == REFTABLE_REF_SYMREF) {
+				if (!arg->operation->destination_target ||
+				    strcmp(destination_ref.value.symref,
+					   arg->operation->destination_target)) {
+					strbuf_addf(arg->err,
+						    _("refname %s changed while renaming"),
+						    arg->newname);
+					ret = -1;
+					goto done;
+				}
+			} else {
+				if (destination_ref.value_type == REFTABLE_REF_VAL2)
+					oidread(&oid, destination_ref.value.val2.value,
+						arg->refs->base.repo->hash_algo);
+				else
+					oidread(&oid, destination_ref.value.val1,
+						arg->refs->base.repo->hash_algo);
+				if (arg->operation->destination_target ||
+				    !oideq(&oid, &arg->operation->destination_oid)) {
+					strbuf_addf(arg->err,
+						    _("refname %s changed while renaming"),
+						    arg->newname);
+					ret = -1;
+					goto done;
+				}
+			}
+		}
+	}
 
 	/*
 	 * There's nothing to do in case the old and new name are the same, so
@@ -1815,7 +1923,7 @@ static int write_copy_table(struct reftable_writer *writer, void *cb_data)
 	ret = refs_verify_refname_available(&arg->refs->base, arg->newname,
 					    NULL, &skip, 0, &errbuf);
 	if (ret < 0) {
-		error("%s", errbuf.buf);
+		strbuf_addbuf(arg->err, &errbuf);
 		goto done;
 	}
 
@@ -1980,68 +2088,63 @@ static int write_copy_table(struct reftable_writer *writer, void *cb_data)
 	for (i = 0; i < ARRAY_SIZE(refs); i++)
 		reftable_ref_record_release(&refs[i]);
 	reftable_ref_record_release(&old_ref);
+	reftable_ref_record_release(&destination_ref);
 	reftable_log_record_release(&old_log);
 	return ret;
 }
 
-static int reftable_be_rename_ref(struct ref_store *ref_store,
-				  const char *oldrefname,
-				  const char *newrefname,
-				  const char *logmsg)
+static int reftable_be_copy_or_rename_prepare(struct ref_store *ref_store,
+					       struct ref_transaction *transaction,
+					       struct strbuf *err)
 {
 	struct reftable_ref_store *refs =
-		reftable_be_downcast(ref_store, REF_STORE_WRITE, "rename_ref");
+		reftable_be_downcast(ref_store, REF_STORE_WRITE,
+				     "ref_transaction_prepare");
+	struct reftable_copy_or_rename_transaction_data *data = NULL;
+	struct ref_update *update =
+		ref_transaction_copy_or_rename_update(transaction);
+	struct ref_copy_or_rename_update *operation = update->copy_or_rename;
 	struct write_copy_arg arg = {
 		.refs = refs,
-		.oldname = oldrefname,
-		.newname = newrefname,
-		.logmsg = logmsg,
-		.delete_old = 1,
+		.err = err,
+		.oldname = operation->old_refname,
+		.newname = update->refname,
+		.logmsg = operation->logmsg,
+		.delete_old = operation->type == REF_UPDATE_RENAME,
+		.operation = operation,
 	};
 	int ret;
 
+	CALLOC_ARRAY(data, 1);
 	ret = refs->err;
 	if (ret < 0)
 		goto done;
-
-	ret = backend_for(&arg.be, refs, newrefname, &newrefname, 1);
+	ret = backend_for(&arg.be, refs, update->refname,
+			  &arg.newname, 1);
 	if (ret)
 		goto done;
-	ret = reftable_stack_add(arg.be->stack, &write_copy_table, &arg,
-				 &reftable_be_write_options(refs)->opts);
-
-done:
-	assert(ret != REFTABLE_API_ERROR);
-	return ret;
-}
-
-static int reftable_be_copy_ref(struct ref_store *ref_store,
-				const char *oldrefname,
-				const char *newrefname,
-				const char *logmsg)
-{
-	struct reftable_ref_store *refs =
-		reftable_be_downcast(ref_store, REF_STORE_WRITE, "copy_ref");
-	struct write_copy_arg arg = {
-		.refs = refs,
-		.oldname = oldrefname,
-		.newname = newrefname,
-		.logmsg = logmsg,
-	};
-	int ret;
-
-	ret = refs->err;
-	if (ret < 0)
+	ret = reftable_stack_addition_new(&data->addition, arg.be->stack,
+					  &reftable_be_write_options(refs)->opts);
+	if (ret)
 		goto done;
-
-	ret = backend_for(&arg.be, refs, newrefname, &newrefname, 1);
+	ret = reftable_addition_add(data->addition, &write_copy_table, &arg);
 	if (ret)
 		goto done;
-	ret = reftable_stack_add(arg.be->stack, &write_copy_table, &arg,
-				 &reftable_be_write_options(refs)->opts);
+
+	transaction->backend_data = data;
+	transaction->state = REF_TRANSACTION_PREPARED;
+	return 0;
 
 done:
 	assert(ret != REFTABLE_API_ERROR);
+	if (data) {
+		reftable_addition_destroy(data->addition);
+		free(data);
+	}
+	transaction->state = REF_TRANSACTION_CLOSED;
+	if (ret && !err->len)
+		strbuf_addf(err, _("reftable: transaction prepare: %s"),
+			    reftable_error_str(ret));
 	return ret;
 }
 
@@ -2872,8 +2975,6 @@ struct ref_storage_be refs_be_reftable = {
 	.optimize = reftable_be_optimize,
 	.optimize_required = reftable_be_optimize_required,
 
-	.rename_ref = reftable_be_rename_ref,
-	.copy_ref = reftable_be_copy_ref,
 
 	.iterator_begin = reftable_be_iterator_begin,
 	.read_raw_ref = reftable_be_read_raw_ref,
diff --git a/t/t1416-ref-transaction-hooks.sh b/t/t1416-ref-transaction-hooks.sh
index 4fe9d9b23..116b2ff07 100755
--- a/t/t1416-ref-transaction-hooks.sh
+++ b/t/t1416-ref-transaction-hooks.sh
@@ -93,6 +93,148 @@ test_expect_success 'hook gets all queued updates in committed state' '
 	test_cmp expect actual
 '
 
+test_expect_success 'hook gets both updates when renaming a branch' '
+	test_when_finished "rm -f actual" &&
+	git branch old PRE &&
+	test_hook reference-transaction <<-\EOF &&
+		echo "$1" >>actual &&
+		cat >>actual
+	EOF
+	cat >expect <<-EOF &&
+	preparing
+	$PRE_OID $ZERO_OID refs/heads/old
+	$ZERO_OID $PRE_OID refs/heads/new
+	prepared
+	$PRE_OID $ZERO_OID refs/heads/old
+	$ZERO_OID $PRE_OID refs/heads/new
+	committed
+	$PRE_OID $ZERO_OID refs/heads/old
+	$ZERO_OID $PRE_OID refs/heads/new
+	EOF
+	git branch -m old new &&
+	test_cmp expect actual &&
+	test_must_fail git rev-parse --verify refs/heads/old &&
+	test_cmp_rev PRE refs/heads/new
+'
+
+test_expect_success 'hook gets destination update when copying a branch' '
+	test_when_finished "rm -f actual" &&
+	git branch copy-source PRE &&
+	test_hook reference-transaction <<-\EOF &&
+		echo "$1" >>actual &&
+		cat >>actual
+	EOF
+	cat >expect <<-EOF &&
+	preparing
+	$ZERO_OID $PRE_OID refs/heads/copy-destination
+	prepared
+	$ZERO_OID $PRE_OID refs/heads/copy-destination
+	committed
+	$ZERO_OID $PRE_OID refs/heads/copy-destination
+	EOF
+	git branch -c copy-source copy-destination &&
+	test_cmp expect actual &&
+	test_cmp_rev PRE refs/heads/copy-source &&
+	test_cmp_rev PRE refs/heads/copy-destination
+'
+
+test_expect_success 'hook gets overwritten values for forced rename and copy' '
+	git branch force-old PRE &&
+	git branch force-new POST &&
+	git branch force-copy-source PRE &&
+	git branch force-copy-destination POST &&
+	test_hook reference-transaction <<-\EOF &&
+		if test "$1" = committed
+		then
+			cat >>actual
+		fi
+	EOF
+	git branch -M force-old force-new &&
+	git branch -C force-copy-source force-copy-destination &&
+	cat >expect <<-EOF &&
+	$PRE_OID $ZERO_OID refs/heads/force-old
+	$POST_OID $PRE_OID refs/heads/force-new
+	$POST_OID $PRE_OID refs/heads/force-copy-destination
+	EOF
+	test_cmp expect actual
+'
+
+test_expect_success 'hook can abort a branch rename after preparation' '
+	git branch abort-old PRE &&
+	git branch abort-new POST &&
+	git reflog show --format=%gs abort-old >old-log &&
+	git reflog show --format=%gs abort-new >new-log &&
+	test_hook reference-transaction <<-\EOF &&
+		test "$1" != prepared
+	EOF
+	test_must_fail git branch -M abort-old abort-new &&
+	test_cmp_rev PRE refs/heads/abort-old &&
+	test_cmp_rev POST refs/heads/abort-new &&
+	git reflog show --format=%gs abort-old >old-log-after &&
+	git reflog show --format=%gs abort-new >new-log-after &&
+	test_cmp old-log old-log-after &&
+	test_cmp new-log new-log-after
+'
+
+test_expect_success 'hook can abort a D/F branch rename after preparation' '
+	git branch df-old PRE &&
+	git reflog show --format=%gs df-old >df-log &&
+	test_hook reference-transaction <<-\EOF &&
+		test "$1" != prepared
+	EOF
+	test_must_fail git branch -m df-old df-old/child &&
+	test_cmp_rev PRE refs/heads/df-old &&
+	test_must_fail git rev-parse --verify refs/heads/df-old/child &&
+	git reflog show --format=%gs df-old >df-log-after &&
+	test_cmp df-log df-log-after
+'
+
+test_expect_success 'hook can abort a reverse D/F rename after preparation' '
+	git branch reverse/old PRE &&
+	git reflog show --format=%gs reverse/old >reverse-log &&
+	test_hook reference-transaction <<-\EOF &&
+		test "$1" != prepared
+	EOF
+	test_must_fail git branch -m reverse/old reverse &&
+	test_cmp_rev PRE refs/heads/reverse/old &&
+	test_must_fail git rev-parse --verify refs/heads/reverse &&
+	git reflog show --format=%gs reverse/old >reverse-log-after &&
+	test_cmp reverse-log reverse-log-after
+'
+
+test_expect_success 'hook can abort a forced branch copy after preparation' '
+	git branch copy-abort-old PRE &&
+	git branch copy-abort-new POST &&
+	git reflog show --format=%gs copy-abort-old >copy-old-log &&
+	git reflog show --format=%gs copy-abort-new >copy-new-log &&
+	test_hook reference-transaction <<-\EOF &&
+		test "$1" != prepared
+	EOF
+	test_must_fail git branch -C copy-abort-old copy-abort-new &&
+	test_cmp_rev PRE refs/heads/copy-abort-old &&
+	test_cmp_rev POST refs/heads/copy-abort-new &&
+	git reflog show --format=%gs copy-abort-old >copy-old-log-after &&
+	git reflog show --format=%gs copy-abort-new >copy-new-log-after &&
+	test_cmp copy-old-log copy-old-log-after &&
+	test_cmp copy-new-log copy-new-log-after
+'
+
+test_expect_success 'branch rename detects an update during preparing hook' '
+	git branch race-old PRE &&
+	git branch race-new POST &&
+	test_hook reference-transaction <<-\EOF &&
+		marker=$(git rev-parse --git-path rename-race-once)
+		if test "$1" = preparing && test ! -e "$marker"
+		then
+			>"$marker" &&
+			git update-ref refs/heads/race-old POST
+		fi
+	EOF
+	test_must_fail git branch -M race-old race-new &&
+	test_cmp_rev POST refs/heads/race-old &&
+	test_cmp_rev POST refs/heads/race-new
+'
+
 test_expect_success 'hook gets all queued updates in aborted state' '
 	test_when_finished "rm actual" &&
 	git reset --hard PRE &&
-- 
2.39.3 (Apple Git-146)
