Received: from mail-ej2-f12.google.com (mail-ej2-f12.google.com [74.125.228.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F1AA3515E6
	for <git@vger.kernel.org>; Sun, 20 Sep 2026 16:50:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789923044; cv=none; b=FokcoAvHMvDQmHjS5lKTkLHGOR1Y413vNEXlkjtb8ncl3glUeDyJ/AK4/LeLwEPP8Y4yhgXog7f4cKijBg1BOq9J/YcW076zwtDvWvxxEpCFdA6woMsC72O17XsMikTHAi7Ko7gbPblcvGdtinunHGIsh5dqUJU2IcevCEQyKNI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789923044; c=relaxed/simple;
	bh=kg/2TsRvypVqPz3b6h8KzN1UubN3Pbbh3D1xnXXwtY0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=SHZnvNS//ZMOFWkRumVP9FiBUXQW43inWIc/msCb0j6CtzJP0/CqMq/rLIcfoySNmO84T3xRCdCZe65e1EkHt+mw7R+ntMDJ11FEPkUFwqaBXdi5ytbZ672fcGuvA5DIB4eCTCGnkjPSiaGf12atSIiCykd0aqOpjFPprV7HYg8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kFofhj7D; arc=none smtp.client-ip=74.125.228.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kFofhj7D"
Received: by mail-ej2-f12.google.com with SMTP id a640c23a62f3a-c254f70553dso296651466b.0
        for <git@vger.kernel.org>; Sun, 20 Sep 2026 09:50:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789923039; x=1790527839; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=kuPCGKIxy2WEz0e4UjM6r7OKy/Dwux0xUQNa0SqVaW8=;
        b=kFofhj7DOSWaocr07JZxB6UQKnZihJLyR1PqhY7a5ovVEeb/CffElNCfrYyHm/fXwn
         S+Vo1J0yi3mUNhX5liv/qGez1zuGRePZaIatSOM2NWJF1f921CXz/JAGcYGsI1seL9f2
         rPGmJx2aLECb7seiFyQMjVnbVh9AA/F9y3DWtb4MoKB6OOXpJZPHznHwKfFdoppLJbtk
         sRSgXQFQuDfu6/9e9hDQ7bns5HzFP1bESyrfcIdfUAH5cgkvjTjx3tFvbU6zBTbWkaor
         +51D+9Jy5WNUbOG6zyvVcjIpi0TVVcot9i6n9yYH0xGDYWoUV/+R9LGFYISNxVcGBLyf
         ieVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789923039; x=1790527839;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=kuPCGKIxy2WEz0e4UjM6r7OKy/Dwux0xUQNa0SqVaW8=;
        b=Vc50znGyOAJuaVdmLgmUM9XXasmKBKeKjCUFJ4G1xc39V5Q1/2PpHdnlxGZeUIAXZs
         nJV0KS8ZlhK+hcqmfesrrL5IeoN/osVctwaw8FFf+VGXlRCmaBPdv05pSAPveJxGRsYF
         MAHM6DXqRc3twd8FADKDXX9NRGr/GlGQu9SM/tvhS7AtKDGAzuKixSOS4C7ZiqGZPgVj
         a8K7SraIWYNEtcpBvTXwJuk3P/INedk/oaOsjGx/bFh/4KgtB6DC2jMQUKF2AAh3JVWD
         p6e5tnh90aZGz1m7ePibEqxIWtrdGmG2mn7J0xdtQJLlch4gS7UOhPwzwrcoZVQo2BgH
         VEwA==
X-Gm-Message-State: AFuF++kDzPhLn1j26X3T47yrGClGcdTFr6Vcyq5/eU9FhXMgJTdkRT7p
	+J18T27Ug/YfCrohlBM/1C/933A1ph/1VVid+OOEgTNwOYjl1cx/VNOYAvYWlzWr
X-Gm-Gg: AYBFou37dXr8N6+HELvXKlU3EvPseRUoKQNVx4gRxOfmp/DUWsFeGP2qQihSqT4tnlt
	dL8KyNNH4BJZ6fd0HqIGuoAi2teheapVSXRxTL57mwuIwzxWGkCoxz9Ehie8Tle1Rfdcw+1QhIK
	WOTFGZh9RfGrWiBAW5RJlIfxV/h7rQsmpASCo1cqqQNzh3MoDo9vnhE9Abpuha8AC6x2L98p13I
	fC8xsMRLGHv79aNvDp+vDfkJHBuPlRcTa6W/o3qt7gKaeKdY6/wolBQYzEc1KOhAUKlA72EKGI6
	Lr6lBIop8v1LMvwNc9e57xBKiiu+afGO4t+XCq2f805smHASU3XlWKKYRFSOtD8aysLy9KWYpTL
	AL/6JWIhTL3+kx+715uxzxLB8kKQ6KEo8z3xR4GoTmtVXQYxQzRw5Mty/0lQtiYs6BQm5djjH4d
	SDmo2Frbcc1qOtAnOUw6VhOrT9UDoUYj/CbEQsNgz9JrwWwEPQCCmZttd7S0EqdcvWlU3Uxx4ri
	RHXZ8jqqaYIYwHB41GL47c2d6U09snhNWaWfoH/RjDpL+AM30gyqdYJLAsMq/VKQDVohyEaSaS7
	qYTxJZlyt675P9l60nGcLzowGCdh4m8UxCF4R+uDlcWlqMmP
X-Received: by 2002:a17:907:9703:b0:c26:219f:6f74 with SMTP id a640c23a62f3a-c2a15846232mr640177266b.5.1789923039118;
        Sun, 20 Sep 2026 09:50:39 -0700 (PDT)
Received: from localhost.localdomain ([91.236.84.70])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c2a35238839sm196245366b.1.2026.09.20.09.50.38
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 20 Sep 2026 09:50:38 -0700 (PDT)
From: Maciej Ciemborowicz <maciej.ciemborowicz@gmail.com>
To: git@vger.kernel.org
Cc: Maciej Ciemborowicz <maciej.ciemborowicz@gmail.com>,
	Karthik Nayak <karthik.188@gmail.com>
Subject: [PATCH] refs: run copy and rename through transactions
Date: Sun, 20 Sep 2026 18:50:37 +0200
Message-Id: <20260920165037.88524-1-maciej.ciemborowicz@gmail.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
In-Reply-To: <CAOLa=ZTN1TU2A1sgEhiw=ymMYr6Ge11cMEubSaeKqr4WNU=2EQ@mail.gmail.com>
References: <CAOLa=ZTN1TU2A1sgEhiw=ymMYr6Ge11cMEubSaeKqr4WNU=2EQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Reference copy and rename operations currently bypass the transaction API.
Consequently, the reference-transaction hook sees only the source deletion
with the files backend and no useful update with the reftable backend.

Represent both operations as reference transactions containing their
logical updates. A rename is a deletion of the old reference and creation
of the new reference in the same transaction. Retain backend-specific
reflog handling: the files backend stages its existing rename procedure
across prepare, finish and abort, while reftable stages an addition while
holding the stack lock. Suppress hooks for the files backend's nested
deletion transactions so that callers observe one logical transaction.

Record and verify the source and destination values after taking backend
locks. This rejects concurrent changes instead of applying a rename or copy
that differs from the payload shown to the preparing hook. Preserve D/F
renames and restore overwritten references and reflogs when a prepared hook
rejects the operation.

Add coverage for rename, copy, forced updates, both directions of D/F
conflicts, concurrent updates and prepared-hook rollback.

Helped-by: Karthik Nayak <karthik.188@gmail.com>
Signed-off-by: Maciej Ciemborowicz <maciej.ciemborowicz@gmail.com>
---
 refs.c                           | 137 ++++++++++++---
 refs.h                           |   3 +
 refs/debug.c                     |  25 ---
 refs/files-backend.c             | 276 +++++++++++++++++++++++++++----
 refs/packed-backend.c            |   2 -
 refs/refs-internal.h             |  38 +++--
 refs/reftable-backend.c          | 194 ++++++++++++++++------
 t/t1416-ref-transaction-hooks.sh | 142 ++++++++++++++++
 8 files changed, 679 insertions(+), 138 deletions(-)

diff --git a/refs.c b/refs.c
index 92d5df5b7..22c000f7f 100644
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
@@ -1270,6 +1281,10 @@ void ref_transaction_free(struct ref_transaction *transaction)
 
 	string_list_clear(&transaction->refnames, 0);
 	free(transaction->updates);
+	free(transaction->old_refname);
+	free(transaction->new_refname);
+	free(transaction->logmsg);
+	free(transaction->destination_target);
 	free(transaction);
 }
 
@@ -2710,7 +2725,8 @@ int ref_transaction_prepare(struct ref_transaction *transaction,
 		return REF_TRANSACTION_ERROR_GENERIC;
 
 	/* Preparing checks before locking references */
-	ret = run_transaction_hook(transaction, "preparing");
+	ret = transaction->flags & REF_TRANSACTION_FLAG_SKIP_HOOK ? 0 :
+		run_transaction_hook(transaction, "preparing");
 	if (ret) {
 		ref_transaction_abort(transaction, err);
 		die(_(abort_by_ref_transaction_hook), "preparing");
@@ -2720,7 +2736,8 @@ int ref_transaction_prepare(struct ref_transaction *transaction,
 	if (ret)
 		return ret;
 
-	ret = run_transaction_hook(transaction, "prepared");
+	ret = transaction->flags & REF_TRANSACTION_FLAG_SKIP_HOOK ? 0 :
+		run_transaction_hook(transaction, "prepared");
 	if (ret) {
 		ref_transaction_abort(transaction, err);
 		die(_(abort_by_ref_transaction_hook), "prepared");
@@ -2750,7 +2767,8 @@ int ref_transaction_abort(struct ref_transaction *transaction,
 		break;
 	}
 
-	run_transaction_hook(transaction, "aborted");
+	if (!(transaction->flags & REF_TRANSACTION_FLAG_SKIP_HOOK))
+		run_transaction_hook(transaction, "aborted");
 
 	ref_transaction_free(transaction);
 	return ret;
@@ -2781,7 +2799,8 @@ int ref_transaction_commit(struct ref_transaction *transaction,
 	}
 
 	ret = refs->be->transaction_finish(refs, transaction, err);
-	if (!ret && !(transaction->flags & REF_TRANSACTION_FLAG_INITIAL))
+	if (!ret && !(transaction->flags & (REF_TRANSACTION_FLAG_INITIAL |
+					 REF_TRANSACTION_FLAG_SKIP_HOOK)))
 		run_transaction_hook(transaction, "committed");
 	return ret;
 }
@@ -3123,28 +3142,100 @@ int refs_delete_refs(struct ref_store *refs, const char *logmsg,
 	return ret;
 }
 
-int refs_rename_ref(struct ref_store *refs, const char *oldref,
-		    const char *newref, const char *logmsg)
+static int refs_copy_or_rename_ref(struct ref_store *refs, const char *oldref,
+				   const char *newref, const char *logmsg,
+				   int copy)
 {
-	char *msg;
-	int retval;
+	struct ref_transaction *transaction = NULL;
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
+	transaction->type = copy ? REF_TRANSACTION_TYPE_COPY :
+		REF_TRANSACTION_TYPE_RENAME;
+	transaction->old_refname = xstrdup(oldref);
+	transaction->new_refname = xstrdup(newref);
+	transaction->logmsg = xstrdup(msg);
+	oidcpy(&transaction->source_oid, &old_oid);
+
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
+	transaction->destination_exists = new_exists;
+	if (new_flags & REF_ISSYMREF)
+		transaction->destination_target = xstrdup(new_target.buf);
+	else if (transaction->destination_exists)
+		oidcpy(&transaction->destination_oid, &new_oid);
+
+	if (ref_transaction_update(transaction, newref, &old_oid,
+				   (new_flags & REF_ISSYMREF) ? NULL : &new_oid,
+				   NULL,
+				   (new_flags & REF_ISSYMREF) ? new_target.buf : NULL,
+				   REF_NO_DEREF | REF_SKIP_CREATE_REFLOG,
+				   NULL, &err))
+		goto error;
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
diff --git a/refs.h b/refs.h
index 9979446d1..25bb8720f 100644
--- a/refs.h
+++ b/refs.h
@@ -784,6 +784,9 @@ enum ref_transaction_flag {
 	 * while rejecting updates which do not match the expected state.
 	 */
 	REF_TRANSACTION_ALLOW_FAILURE = (1 << 1),
+
+	/* Suppress hooks for an update nested in another transaction. */
+	REF_TRANSACTION_FLAG_SKIP_HOOK = (1 << 2),
 };
 
 /*
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
index 71628550f..92601b5e9 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -1594,6 +1594,7 @@ static int files_optimize_required(struct ref_store *ref_store,
  * live into logs/refs.
  */
 #define TMP_RENAMED_LOG  "refs/.tmp-renamed-log"
+#define TMP_RENAMED_LOG_DESTINATION "refs/.tmp-renamed-log-destination"
 
 struct rename_cb {
 	const char *tmp_renamed_log;
@@ -1685,12 +1686,24 @@ static int refs_rename_ref_available(struct ref_store *refs,
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
 			    const char *oldrefname, const char *newrefname,
-			    const char *logmsg, int copy)
+			    const char *logmsg, int copy,
+			    struct ref_transaction *transaction)
 {
 	struct files_ref_store *refs =
-		files_downcast(ref_store, REF_STORE_WRITE, "rename_ref");
+		files_downcast(ref_store, REF_STORE_WRITE,
+			       "ref_transaction_prepare");
 	struct object_id orig_oid;
 	int flag = 0, logmoved = 0;
 	struct ref_lock *lock;
@@ -1698,12 +1711,19 @@ static int files_copy_or_rename_ref(struct ref_store *ref_store,
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
@@ -1727,11 +1747,67 @@ static int files_copy_or_rename_ref(struct ref_store *ref_store,
 				    oldrefname);
 		goto out;
 	}
+	if (!oideq(&orig_oid, &transaction->source_oid)) {
+		ret = error("refname %s is at %s but expected %s",
+			    oldrefname, oid_to_hex(&orig_oid),
+			    oid_to_hex(&transaction->source_oid));
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
+	if (destination_exists != transaction->destination_exists) {
+		ret = error("refname %s changed while renaming", newrefname);
+		goto out;
+	}
+	if (destination_exists) {
+		if (destination_flags & REF_ISSYMREF) {
+			if (!transaction->destination_target ||
+			    strcmp(destination_target.buf,
+				   transaction->destination_target)) {
+				ret = error("refname %s changed while renaming",
+					    newrefname);
+				goto out;
+			}
+		} else if (transaction->destination_target ||
+			   !oideq(&destination_oid,
+				  &transaction->destination_oid)) {
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
@@ -1744,8 +1820,10 @@ static int files_copy_or_rename_ref(struct ref_store *ref_store,
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
@@ -1760,8 +1838,9 @@ static int files_copy_or_rename_ref(struct ref_store *ref_store,
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
@@ -1796,13 +1875,25 @@ static int files_copy_or_rename_ref(struct ref_store *ref_store,
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
 
@@ -1821,38 +1912,40 @@ static int files_copy_or_rename_ref(struct ref_store *ref_store,
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
@@ -2962,6 +3055,13 @@ static int files_transaction_prepare(struct ref_store *ref_store,
 	struct ref_transaction *packed_transaction = NULL;
 
 	assert(err);
+	if (transaction->type != REF_TRANSACTION_TYPE_NORMAL)
+		return files_copy_or_rename_ref(ref_store,
+				transaction->old_refname,
+				transaction->new_refname,
+				transaction->logmsg,
+				transaction->type == REF_TRANSACTION_TYPE_COPY,
+				transaction);
 
 	if (transaction->flags & REF_TRANSACTION_FLAG_INITIAL)
 		goto cleanup;
@@ -3318,6 +3418,10 @@ static int files_transaction_finish_initial(struct files_ref_store *refs,
 	return ret;
 }
 
+static int files_transaction_abort(struct ref_store *ref_store,
+				   struct ref_transaction *transaction,
+				   struct strbuf *err);
+
 static int files_transaction_finish(struct ref_store *ref_store,
 				    struct ref_transaction *transaction,
 				    struct strbuf *err)
@@ -3333,6 +3437,33 @@ static int files_transaction_finish(struct ref_store *ref_store,
 
 
 	assert(err);
+	if (transaction->type != REF_TRANSACTION_TYPE_NORMAL) {
+		struct files_copy_or_rename_transaction_data *data =
+			transaction->backend_data;
+		int special_ret;
+
+		special_ret = commit_ref_update(refs, data->lock, &data->orig_oid,
+						transaction->logmsg, 0, err);
+		if (special_ret) {
+			error("unable to write current sha1 into %s: %s",
+			      transaction->new_refname, err->buf);
+			data->lock = NULL;
+			files_transaction_abort(ref_store, transaction, err);
+			return special_ret;
+		} else if (data->destination_log_backed_up) {
+			struct strbuf path = STRBUF_INIT;
+
+			files_reflog_path(refs, &path, TMP_RENAMED_LOG_DESTINATION);
+			if (unlink(path.buf) < 0 && errno != ENOENT)
+				warning_errno("unable to remove '%s'", path.buf);
+			strbuf_release(&path);
+		}
+		free(data->destination_target);
+		free(data);
+		transaction->backend_data = NULL;
+		transaction->state = REF_TRANSACTION_CLOSED;
+		return special_ret;
+	}
 
 	if (transaction->flags & REF_TRANSACTION_FLAG_INITIAL)
 		return files_transaction_finish_initial(refs, transaction, err);
@@ -3476,11 +3607,98 @@ static int files_transaction_finish(struct ref_store *ref_store,
 
 static int files_transaction_abort(struct ref_store *ref_store,
 				   struct ref_transaction *transaction,
-				   struct strbuf *err UNUSED)
+				   struct strbuf *err)
 {
 	struct files_ref_store *refs =
 		files_downcast(ref_store, 0, "ref_transaction_abort");
 
+	if (transaction->type != REF_TRANSACTION_TYPE_NORMAL) {
+		struct files_copy_or_rename_transaction_data *data =
+			transaction->backend_data;
+		struct strbuf new_log = STRBUF_INIT;
+		struct strbuf destination_log = STRBUF_INIT;
+		struct strbuf temporary_log = STRBUF_INIT;
+		struct ref_transaction *restore_transaction = NULL;
+		struct ref_lock *lock;
+		int ret = 0;
+
+		if (data->lock)
+			unlock_ref(data->lock);
+		if (transaction->type == REF_TRANSACTION_TYPE_RENAME) {
+			lock = lock_ref_oid_basic(refs, transaction->old_refname, err);
+			if (!lock ||
+			    write_ref_to_lockfile(refs, lock, &data->orig_oid, err) ||
+			    commit_ref_update(refs, lock, &data->orig_oid, NULL,
+					      REF_SKIP_CREATE_REFLOG, err))
+				ret = -1;
+		}
+
+		if (data->logmoved) {
+			files_reflog_path(refs, &new_log, transaction->new_refname);
+			if (transaction->type == REF_TRANSACTION_TYPE_RENAME) {
+				files_reflog_path(refs, &temporary_log, TMP_RENAMED_LOG);
+				if (rename(new_log.buf, temporary_log.buf) < 0) {
+					strbuf_addf(err, "unable to restore logfile %s: %s",
+						    transaction->old_refname, strerror(errno));
+					ret = -1;
+				} else {
+					try_remove_empty_parents(refs,
+							 transaction->new_refname,
+							 REMOVE_EMPTY_PARENTS_REFLOG);
+					if (rename_tmp_log(refs,
+							   transaction->old_refname)) {
+						strbuf_addf(err, "unable to restore logfile %s: %s",
+							    transaction->old_refname,
+							    strerror(errno));
+						ret = -1;
+					}
+				}
+			} else if (unlink(new_log.buf) < 0 && errno != ENOENT) {
+				strbuf_addf(err, "unable to remove logfile %s: %s",
+					    transaction->new_refname, strerror(errno));
+				ret = -1;
+			}
+		}
+		if (data->destination_log_backed_up) {
+			files_reflog_path(refs, &destination_log,
+					   TMP_RENAMED_LOG_DESTINATION);
+			if (rename(destination_log.buf, new_log.buf) < 0) {
+				strbuf_addf(err, "unable to restore logfile %s: %s",
+					    transaction->new_refname, strerror(errno));
+				ret = -1;
+			}
+		}
+
+		if (transaction->type == REF_TRANSACTION_TYPE_RENAME &&
+		    data->destination_exists) {
+			restore_transaction = ref_store_transaction_begin(
+					&refs->base, REF_TRANSACTION_FLAG_SKIP_HOOK, err);
+			if (!restore_transaction ||
+			    ref_transaction_update(restore_transaction,
+						   transaction->new_refname,
+						   data->destination_target ? NULL :
+							&data->destination_oid,
+						   NULL,
+						   data->destination_target,
+						   NULL,
+						   REF_NO_DEREF |
+							REF_SKIP_CREATE_REFLOG,
+						   NULL, err) ||
+			    ref_transaction_commit(restore_transaction, err))
+				ret = -1;
+			ref_transaction_free(restore_transaction);
+		}
+
+		strbuf_release(&destination_log);
+		strbuf_release(&temporary_log);
+		strbuf_release(&new_log);
+		free(data->destination_target);
+		free(data);
+		transaction->backend_data = NULL;
+		transaction->state = REF_TRANSACTION_CLOSED;
+		return ret;
+	}
+
 	files_transaction_cleanup(refs, transaction);
 	return 0;
 }
@@ -4095,8 +4313,6 @@ struct ref_storage_be refs_be_files = {
 
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
index c3ac7b556..406b54b65 100644
--- a/refs/refs-internal.h
+++ b/refs/refs-internal.h
@@ -187,6 +187,13 @@ struct ref_update *ref_transaction_add_update(
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
@@ -212,6 +219,12 @@ enum ref_transaction_state {
 	REF_TRANSACTION_CLOSED   = 2
 };
 
+enum ref_transaction_type {
+	REF_TRANSACTION_TYPE_NORMAL = 0,
+	REF_TRANSACTION_TYPE_RENAME,
+	REF_TRANSACTION_TYPE_COPY,
+};
+
 /*
  * Data structure to hold indices of updates which were rejected, for batched
  * reference updates. While the updates themselves hold the rejection error,
@@ -240,6 +253,21 @@ struct ref_transaction {
 	void *backend_data;
 	unsigned int flags;
 	uint64_t max_index;
+
+	/*
+	 * Rename and copy operations need backend-specific reflog handling.
+	 * Their logical updates still live in `updates`, so hooks see the
+	 * operation like any other reference transaction. The fields below
+	 * retain the state that backends verify after taking their locks.
+	 */
+	enum ref_transaction_type type;
+	char *old_refname;
+	char *new_refname;
+	char *logmsg;
+	struct object_id source_oid;
+	struct object_id destination_oid;
+	char *destination_target;
+	unsigned int destination_exists:1;
 };
 
 /*
@@ -451,13 +479,6 @@ typedef int optimize_required_fn(struct ref_store *ref_store,
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
@@ -577,9 +598,6 @@ struct ref_storage_be {
 
 	optimize_fn *optimize;
 	optimize_required_fn *optimize_required;
-	rename_ref_fn *rename_ref;
-	copy_ref_fn *copy_ref;
-
 	ref_iterator_begin_fn *iterator_begin;
 	read_raw_ref_fn *read_raw_ref;
 
diff --git a/refs/reftable-backend.c b/refs/reftable-backend.c
index 10db03991..cf8a16af5 100644
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
 
+	if (transaction->type != REF_TRANSACTION_TYPE_NORMAL)
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
+	if (transaction->type != REF_TRANSACTION_TYPE_NORMAL) {
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
 
+	if (transaction->type != REF_TRANSACTION_TYPE_NORMAL) {
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
+	struct ref_transaction *transaction;
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
+	if (arg->transaction) {
+		struct object_id oid;
+
+		if (old_ref.value_type == REFTABLE_REF_VAL2)
+			oidread(&oid, old_ref.value.val2.value,
+				arg->refs->base.repo->hash_algo);
+		else
+			oidread(&oid, old_ref.value.val1,
+				arg->refs->base.repo->hash_algo);
+		if (!oideq(&oid, &arg->transaction->source_oid)) {
+			strbuf_addf(arg->err,
+				    _("refname %s is at %s but expected %s"),
+				    arg->oldname, oid_to_hex(&oid),
+				    oid_to_hex(&arg->transaction->source_oid));
+			ret = -1;
+			goto done;
+		}
+
+		ret = reftable_stack_read_ref(arg->be->stack, arg->newname,
+					      &destination_ref);
+		if (ret < 0)
+			goto done;
+		if (arg->transaction->destination_exists != !ret) {
+			strbuf_addf(arg->err,
+				    _("refname %s changed while renaming"),
+				    arg->newname);
+			ret = -1;
+			goto done;
+		}
+		if (!ret) {
+			if (destination_ref.value_type == REFTABLE_REF_SYMREF) {
+				if (!arg->transaction->destination_target ||
+				    strcmp(destination_ref.value.symref,
+					   arg->transaction->destination_target)) {
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
+				if (arg->transaction->destination_target ||
+				    !oideq(&oid, &arg->transaction->destination_oid)) {
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
 
@@ -1980,68 +2088,60 @@ static int write_copy_table(struct reftable_writer *writer, void *cb_data)
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
 	struct write_copy_arg arg = {
 		.refs = refs,
-		.oldname = oldrefname,
-		.newname = newrefname,
-		.logmsg = logmsg,
-		.delete_old = 1,
+		.err = err,
+		.oldname = transaction->old_refname,
+		.newname = transaction->new_refname,
+		.logmsg = transaction->logmsg,
+		.delete_old = transaction->type == REF_TRANSACTION_TYPE_RENAME,
+		.transaction = transaction,
 	};
 	int ret;
 
+	CALLOC_ARRAY(data, 1);
 	ret = refs->err;
 	if (ret < 0)
 		goto done;
-
-	ret = backend_for(&arg.be, refs, newrefname, &newrefname, 1);
+	ret = backend_for(&arg.be, refs, transaction->new_refname,
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
 
@@ -2872,8 +2972,6 @@ struct ref_storage_be refs_be_reftable = {
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

base-commit: d38352cd43ab9745686d697872408bc3249a153f
-- 
2.39.3 (Apple Git-146)

