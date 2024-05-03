Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 777B3153833
	for <git@vger.kernel.org>; Fri,  3 May 2024 12:41:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714740088; cv=none; b=YZ2hPDZpwIkZgcpvF/HCY9aMp9daRh58TXHPxhIJaH/XGsOp1Qeyouc6KvTD5brO17vHKD4nQAyLcvHsSIVNCpHLTyhOnYhnr5ljWc/URu0TZfuwuMIGMJu/J3fd60e4anwCFMunfiPwZM747ny+NMujwbwMjJyYYletWPCoZ24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714740088; c=relaxed/simple;
	bh=To+A7WGp1Q2xlRJXIf5ASSid9HGeRYxmVU7Rh1a7BNQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rldZI2QgzZ+SA9WTVewcx13e2uGlQg/YW40Ou7VIRR/NTIRKpo61QS4QS8CGvGzEYFE0fXiCbWhy7Ym59ZU3/SWMlvRqM4IA1tr2EAycx9EQev5k+z0MbkZwFjv2h+eHkqHk/177BH6jbNElrkEqFzVwMl8FKVaLInA1DoWKA1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AZr140GP; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AZr140GP"
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-a556d22fa93so1127967366b.3
        for <git@vger.kernel.org>; Fri, 03 May 2024 05:41:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714740085; x=1715344885; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=D7qwr5qn8sTHxT7n55xU/sDDCM8q1Eq1oy5LuHFy/+Q=;
        b=AZr140GPvNPnBSbmL86iQyoNpf603oDF32lCGHv6dbaPHhjzBQ7ZgPGe1vU7l4lXCa
         X2fmCdys8LoPMvwR4s0X2Lraox7Qbm15QpdCwiIov/iXXa+iBOf3V3zDQQ71hnSfqPaM
         CYgb/zUAUPGKn9DlQ5svT4MTgvAlN/a97pTVSE40jlZ10wZd8f4HMuq31+7a7Ax09vzM
         1al994FrlKh8ZfITOEUJrGoQIpoxAvc599FhxMgPXKx+snMJWOHPl+zLcmZ495knCrEt
         9MoXpCbL3BWfnDQ2GcKN7dnGNwwP4kKS+qngIK8lyiGB/vGICzsfujqyCxaeJ5rPmGxX
         IH/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714740085; x=1715344885;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=D7qwr5qn8sTHxT7n55xU/sDDCM8q1Eq1oy5LuHFy/+Q=;
        b=YLlCBqINKJp+YaC15R9GtQPZcCGXEtEMkhlPxPWq3TJgr2Ld2s/bDmpRC57IDjgc/b
         O6UsGhqvtLT9ewH2DC6j+TdCm2aPnI5JbOYyrc/bkiQf+D78pIjNZ0kxJnrvDQjKgsdx
         sPLzjSmkkWed9ScpgCFPke24lXV1M6Fg5Gl1wh3WBae2tF+WBWbpI/7ApGI40D2HMPPe
         Tv1NKyCxq/ZsCbFhAlaTSB02uXRNsXLn8/+DVK9Y/mnnRg7j2XuT7sB2en5sW2JYjlLT
         RXI9g8B3iCzo0LZNKNcgHST9RdCmuaDkDIrEDRpBnBUsphnFnk2w+Y1UURTrwewrkZ0T
         ue7Q==
X-Forwarded-Encrypted: i=1; AJvYcCVwPde0+4ar41EP6LhQ/QQYdwgs4TjUzgqNw/0y7YNZto/rT2PNbKP3Tv7k5dcv10DO+DDzLb8hrZhgNXSVM+AuU+bl
X-Gm-Message-State: AOJu0YzuoeD8blMsAzPSWXIUtv83yO8PFu0bdhMJXHmC1NBqjd0Cn/jv
	H7HDdn6RTAXJzxuU97OgTh+3+swWb+kssmvZKTF7GiI1WO85TgyG
X-Google-Smtp-Source: AGHT+IGi3hz4C/Edf4Bv6mR0EV8+5efLP43q2TGk+cjv030D/C8zYZ0VQ10miR20WJIzTA2bsHvjGQ==
X-Received: by 2002:a17:906:1555:b0:a51:8d60:215a with SMTP id c21-20020a170906155500b00a518d60215amr1510128ejd.27.1714740084916;
        Fri, 03 May 2024 05:41:24 -0700 (PDT)
Received: from localhost.localdomain ([185.223.147.210])
        by smtp.gmail.com with ESMTPSA id ot38-20020a170906cce600b00a5994c5c948sm533323ejb.133.2024.05.03.05.41.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 May 2024 05:41:24 -0700 (PDT)
From: Karthik Nayak <karthik.188@gmail.com>
X-Google-Original-From: Karthik Nayak <knayak@gitlab.com>
To: karthik.188@gmail.com
Cc: christian.couder@gmail.com,
	git@vger.kernel.org,
	gitster@pobox.com,
	ps@pks.im
Subject: [PATCH v6 7/7] refs: remove `create_symref` and associated dead code
Date: Fri,  3 May 2024 14:41:15 +0200
Message-ID: <20240503124115.252413-8-knayak@gitlab.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240503124115.252413-1-knayak@gitlab.com>
References: <20240501202229.2695774-1-knayak@gitlab.com>
 <20240503124115.252413-1-knayak@gitlab.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Karthik Nayak <karthik.188@gmail.com>

In the previous commits, we converted `refs_create_symref()` to utilize
transactions to perform symref updates. Earlier `refs_create_symref()`
used `create_symref()` to do the same.

We can now remove `create_symref()` and any code associated with it
which is no longer used. We remove `create_symref()` code from all the
reference backends and also remove it entirely from the `ref_storage_be`
struct.

Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
---
 refs/debug.c            | 13 -------
 refs/files-backend.c    | 67 --------------------------------
 refs/packed-backend.c   |  1 -
 refs/refs-internal.h    |  5 ---
 refs/reftable-backend.c | 86 -----------------------------------------
 5 files changed, 172 deletions(-)

diff --git a/refs/debug.c b/refs/debug.c
index c7531b17f0..8be316bb67 100644
--- a/refs/debug.c
+++ b/refs/debug.c
@@ -131,18 +131,6 @@ static int debug_pack_refs(struct ref_store *ref_store, struct pack_refs_opts *o
 	return res;
 }
 
-static int debug_create_symref(struct ref_store *ref_store,
-			       const char *ref_name, const char *target,
-			       const char *logmsg)
-{
-	struct debug_ref_store *drefs = (struct debug_ref_store *)ref_store;
-	int res = drefs->refs->be->create_symref(drefs->refs, ref_name, target,
-						 logmsg);
-	trace_printf_key(&trace_refs, "create_symref: %s -> %s \"%s\": %d\n", ref_name,
-		target, logmsg, res);
-	return res;
-}
-
 static int debug_rename_ref(struct ref_store *ref_store, const char *oldref,
 			    const char *newref, const char *logmsg)
 {
@@ -441,7 +429,6 @@ struct ref_storage_be refs_be_debug = {
 	.initial_transaction_commit = debug_initial_transaction_commit,
 
 	.pack_refs = debug_pack_refs,
-	.create_symref = debug_create_symref,
 	.rename_ref = debug_rename_ref,
 	.copy_ref = debug_copy_ref,
 
diff --git a/refs/files-backend.c b/refs/files-backend.c
index e1f0ca74c0..3ce260d07d 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -1903,23 +1903,6 @@ static int create_ref_symlink(struct ref_lock *lock, const char *target)
 	return ret;
 }
 
-static void update_symref_reflog(struct files_ref_store *refs,
-				 struct ref_lock *lock, const char *refname,
-				 const char *target, const char *logmsg)
-{
-	struct strbuf err = STRBUF_INIT;
-	struct object_id new_oid;
-
-	if (logmsg &&
-	    refs_resolve_ref_unsafe(&refs->base, target,
-				    RESOLVE_REF_READING, &new_oid, NULL) &&
-	    files_log_ref_write(refs, refname, &lock->old_oid,
-				&new_oid, logmsg, 0, &err)) {
-		error("%s", err.buf);
-		strbuf_release(&err);
-	}
-}
-
 static int create_symref_lock(struct files_ref_store *refs,
 			      struct ref_lock *lock, const char *refname,
 			      const char *target, struct strbuf *err)
@@ -1939,55 +1922,6 @@ static int create_symref_lock(struct files_ref_store *refs,
 	return 0;
 }
 
-static int create_and_commit_symref(struct files_ref_store *refs,
-				    struct ref_lock *lock, const char *refname,
-				    const char *target, const char *logmsg)
-{
-	struct strbuf err = STRBUF_INIT;
-	int ret;
-
-	if (prefer_symlink_refs && !create_ref_symlink(lock, target)) {
-		update_symref_reflog(refs, lock, refname, target, logmsg);
-		return 0;
-	}
-
-	ret = create_symref_lock(refs, lock, refname, target, &err);
-	if (!ret) {
-		update_symref_reflog(refs, lock, refname, target, logmsg);
-
-		if (commit_ref(lock) < 0)
-			return error("unable to write symref for %s: %s", refname,
-				     strerror(errno));
-	} else {
-		return error("%s", err.buf);
-	}
-
-	return ret;
-}
-
-static int files_create_symref(struct ref_store *ref_store,
-			       const char *refname, const char *target,
-			       const char *logmsg)
-{
-	struct files_ref_store *refs =
-		files_downcast(ref_store, REF_STORE_WRITE, "create_symref");
-	struct strbuf err = STRBUF_INIT;
-	struct ref_lock *lock;
-	int ret;
-
-	lock = lock_ref_oid_basic(refs, refname, &err);
-	if (!lock) {
-		error("%s", err.buf);
-		strbuf_release(&err);
-		return -1;
-	}
-
-	ret = create_and_commit_symref(refs, lock, refname, target, logmsg);
-
-	unlock_ref(lock);
-	return ret;
-}
-
 static int files_reflog_exists(struct ref_store *ref_store,
 			       const char *refname)
 {
@@ -3413,7 +3347,6 @@ struct ref_storage_be refs_be_files = {
 	.initial_transaction_commit = files_initial_transaction_commit,
 
 	.pack_refs = files_pack_refs,
-	.create_symref = files_create_symref,
 	.rename_ref = files_rename_ref,
 	.copy_ref = files_copy_ref,
 
diff --git a/refs/packed-backend.c b/refs/packed-backend.c
index 4e826c05ff..a937e7dbfc 100644
--- a/refs/packed-backend.c
+++ b/refs/packed-backend.c
@@ -1714,7 +1714,6 @@ struct ref_storage_be refs_be_packed = {
 	.initial_transaction_commit = packed_initial_transaction_commit,
 
 	.pack_refs = packed_pack_refs,
-	.create_symref = NULL,
 	.rename_ref = NULL,
 	.copy_ref = NULL,
 
diff --git a/refs/refs-internal.h b/refs/refs-internal.h
index 03eda70ea4..0c620d4bce 100644
--- a/refs/refs-internal.h
+++ b/refs/refs-internal.h
@@ -566,10 +566,6 @@ typedef int ref_transaction_commit_fn(struct ref_store *refs,
 
 typedef int pack_refs_fn(struct ref_store *ref_store,
 			 struct pack_refs_opts *opts);
-typedef int create_symref_fn(struct ref_store *ref_store,
-			     const char *ref_target,
-			     const char *refs_heads_master,
-			     const char *logmsg);
 typedef int rename_ref_fn(struct ref_store *ref_store,
 			  const char *oldref, const char *newref,
 			  const char *logmsg);
@@ -690,7 +686,6 @@ struct ref_storage_be {
 	ref_transaction_commit_fn *initial_transaction_commit;
 
 	pack_refs_fn *pack_refs;
-	create_symref_fn *create_symref;
 	rename_ref_fn *rename_ref;
 	copy_ref_fn *copy_ref;
 
diff --git a/refs/reftable-backend.c b/refs/reftable-backend.c
index 54c4d8b771..999b5bca21 100644
--- a/refs/reftable-backend.c
+++ b/refs/reftable-backend.c
@@ -1275,91 +1275,6 @@ struct write_create_symref_arg {
 	const char *logmsg;
 };
 
-static int write_create_symref_table(struct reftable_writer *writer, void *cb_data)
-{
-	struct write_create_symref_arg *create = cb_data;
-	uint64_t ts = reftable_stack_next_update_index(create->stack);
-	struct reftable_ref_record ref = {
-		.refname = (char *)create->refname,
-		.value_type = REFTABLE_REF_SYMREF,
-		.value.symref = (char *)create->target,
-		.update_index = ts,
-	};
-	struct reftable_log_record log = {0};
-	struct object_id new_oid;
-	struct object_id old_oid;
-	int ret;
-
-	reftable_writer_set_limits(writer, ts, ts);
-
-	ret = reftable_writer_add_ref(writer, &ref);
-	if (ret)
-		return ret;
-
-	/*
-	 * Note that it is important to try and resolve the reference before we
-	 * write the log entry. This is because `should_write_log()` will munge
-	 * `core.logAllRefUpdates`, which is undesirable when we create a new
-	 * repository because it would be written into the config. As HEAD will
-	 * not resolve for new repositories this ordering will ensure that this
-	 * never happens.
-	 */
-	if (!create->logmsg ||
-	    !refs_resolve_ref_unsafe(&create->refs->base, create->target,
-				     RESOLVE_REF_READING, &new_oid, NULL) ||
-	    !should_write_log(&create->refs->base, create->refname))
-		return 0;
-
-	fill_reftable_log_record(&log);
-	log.refname = xstrdup(create->refname);
-	log.update_index = ts;
-	log.value.update.message = xstrndup(create->logmsg,
-					    create->refs->write_options.block_size / 2);
-	memcpy(log.value.update.new_hash, new_oid.hash, GIT_MAX_RAWSZ);
-	if (refs_resolve_ref_unsafe(&create->refs->base, create->refname,
-				    RESOLVE_REF_READING, &old_oid, NULL))
-		memcpy(log.value.update.old_hash, old_oid.hash, GIT_MAX_RAWSZ);
-
-	ret = reftable_writer_add_log(writer, &log);
-	reftable_log_record_release(&log);
-	return ret;
-}
-
-static int reftable_be_create_symref(struct ref_store *ref_store,
-				     const char *refname,
-				     const char *target,
-				     const char *logmsg)
-{
-	struct reftable_ref_store *refs =
-		reftable_be_downcast(ref_store, REF_STORE_WRITE, "create_symref");
-	struct reftable_stack *stack = stack_for(refs, refname, &refname);
-	struct write_create_symref_arg arg = {
-		.refs = refs,
-		.stack = stack,
-		.refname = refname,
-		.target = target,
-		.logmsg = logmsg,
-	};
-	int ret;
-
-	ret = refs->err;
-	if (ret < 0)
-		goto done;
-
-	ret = reftable_stack_reload(stack);
-	if (ret)
-		goto done;
-
-	ret = reftable_stack_add(stack, &write_create_symref_table, &arg);
-
-done:
-	assert(ret != REFTABLE_API_ERROR);
-	if (ret)
-		error("unable to write symref for %s: %s", refname,
-		      reftable_error_str(ret));
-	return ret;
-}
-
 struct write_copy_arg {
 	struct reftable_ref_store *refs;
 	struct reftable_stack *stack;
@@ -2267,7 +2182,6 @@ struct ref_storage_be refs_be_reftable = {
 	.initial_transaction_commit = reftable_be_initial_transaction_commit,
 
 	.pack_refs = reftable_be_pack_refs,
-	.create_symref = reftable_be_create_symref,
 	.rename_ref = reftable_be_rename_ref,
 	.copy_ref = reftable_be_copy_ref,
 
-- 
2.43.GIT

