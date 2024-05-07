Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41E3815EFD6
	for <git@vger.kernel.org>; Tue,  7 May 2024 12:59:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715086761; cv=none; b=RnDUbAvgAucFEzgzY8x7h073WDgur+ZIJVIk3HwU8jhVPN6MO6jdkg5GqsLGbujihLIaJVoE8+8Ll5QH5B36rqCfkGzR/7xfrtFj4tZaUv7HOaXSmnzPKihU+Y6HYryMF2pSoQRd2iX8G+j+a8eGj/xR4lXUjVHdexUPAi2twU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715086761; c=relaxed/simple;
	bh=bia740WODso5CjT21nvi4lziR6AOv1jIHUqkhjK7jHI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=W7+Mtk6Obt+6+Rre2oojF3MAi2fAiq/MLUI4Mxl6dV7sthiYc+Kohco/BeBi7rglWl+pREe8uQZF++/c6uuGJRPrBmuKiVF7Y9rnQVJjcAWi4e+nxN2XQsTEpL0M+n/kLoIOKY5BVMpQZ+NS90zLOpt2F8KWGXbmALz1RZMORKY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hMeSV+m6; arc=none smtp.client-ip=209.85.208.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hMeSV+m6"
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-2df9af57b5eso41679531fa.2
        for <git@vger.kernel.org>; Tue, 07 May 2024 05:59:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715086757; x=1715691557; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4gm0OfFtAEMwoiaEqhr1BtGSq+gf0fQ58bgPycntrTA=;
        b=hMeSV+m6NrUzu2UWmAqvMJ6rrRyURZ3FqsYulKTqglIfVrYah1UE5/jNAub82WD2Dz
         7xfv76CNMpTFp8wmhWWjph7kDanWl9F8KKCIMS1zNNk7VlEZIrN77XbnisRx8qmmNV5U
         BtHfiAuJzGUqWjchfwb5MmbfbqE78j8d3lhQTjwekT+3wSUQQ/k0dRCGWAjdezAoHbIM
         q8MExvuMX/oIq/m9uWCWFzKEnrokKdea4wJftB+7pTd5jjUyYH4klx9mQnYZH9xpwTFf
         jMpBdpKohsoxRCZIAKgx4nKKQsdXMhnn0lX9SxaKe4dsFqy6KBbhU3kq5NJ4x7Ieb8IT
         x/1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715086757; x=1715691557;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4gm0OfFtAEMwoiaEqhr1BtGSq+gf0fQ58bgPycntrTA=;
        b=NanGlm9g+lV3DehM19uOIGEddKlrgyn74gbrow1FdnYDB/eIahhIZpdYKYhpY/DIRm
         /Lfu1ivURCz9nwRRc/kkC3g7aPF3Vd/lWxIO9tOl2hPTuuEytn1QK0ZJxn+ieqew8ba/
         UXrQsfQ3vshs4x/bZVesBWbMNjsTGhEPNAnE8zovCI5nm8glN5+XkUuoBSLw3BBbQnBl
         eEVRyGAL+BHgwvoPu5TzL23EAdmod1pEtB1cetRjoD5uak1UulJ9DO8Nh84R1qcCVlNa
         UPRXLWjch9Hgw881egdrol4vCF8IS9LiMQtRC7GW1qBDY6XWJkPTsQbBpm+UgBg/2HwT
         wJ1g==
X-Gm-Message-State: AOJu0Ywq0Un97iyF7l4nNq9kBIatCif3wwMll32D2EymGDRXiCOsiSgP
	GW6/wztY8d8iDr4rTOedvnUat9c9l2BqJl3Hz3oJiuvCz//ryOod
X-Google-Smtp-Source: AGHT+IE4pfaYjXLAAY2XhwsQK+WMhG/fO+bUJbsL62yXNJ8X1kddg/Fp5Is3yTQ8GawxmsEYjq0cjw==
X-Received: by 2002:a2e:9214:0:b0:2e0:e7a5:7209 with SMTP id k20-20020a2e9214000000b002e0e7a57209mr9981055ljg.26.1715086756929;
        Tue, 07 May 2024 05:59:16 -0700 (PDT)
Received: from laptop.fritz.box ([2a02:2455:826e:4900:e6d6:a83d:4d4b:8baa])
        by smtp.gmail.com with ESMTPSA id q5-20020adff945000000b0034f5925edacsm3507566wrr.30.2024.05.07.05.59.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 May 2024 05:59:16 -0700 (PDT)
From: Karthik Nayak <karthik.188@gmail.com>
X-Google-Original-From: Karthik Nayak <knayak@gitlab.com>
To: karthik.188@gmail.com
Cc: git@vger.kernel.org,
	gitster@pobox.com,
	ps@pks.im,
	phillip.wood123@gmail.com
Subject: [PATCH v8 8/8] refs: remove `create_symref` and associated dead code
Date: Tue,  7 May 2024 14:58:59 +0200
Message-ID: <20240507125859.132116-9-knayak@gitlab.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240507125859.132116-1-knayak@gitlab.com>
References: <20240507060035.28602-1-knayak@gitlab.com>
 <20240507125859.132116-1-knayak@gitlab.com>
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
index 2d1525b240..3957bfa579 100644
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
@@ -3374,7 +3308,6 @@ struct ref_storage_be refs_be_files = {
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
index 819157256e..53a6c5d842 100644
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
index 3eab57cf95..1b92c396b6 100644
--- a/refs/reftable-backend.c
+++ b/refs/reftable-backend.c
@@ -1259,91 +1259,6 @@ struct write_create_symref_arg {
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
@@ -2251,7 +2166,6 @@ struct ref_storage_be refs_be_reftable = {
 	.initial_transaction_commit = reftable_be_initial_transaction_commit,
 
 	.pack_refs = reftable_be_pack_refs,
-	.create_symref = reftable_be_create_symref,
 	.rename_ref = reftable_be_rename_ref,
 	.copy_ref = reftable_be_copy_ref,
 
-- 
2.43.GIT

