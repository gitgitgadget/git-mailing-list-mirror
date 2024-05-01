Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD1E6168AEE
	for <git@vger.kernel.org>; Wed,  1 May 2024 20:22:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714594966; cv=none; b=OgafiWcRQxxGNSdfreCZSc0gdxZVRcMDrXdDEoh3u1rUp5xBs8zviUQK5bETo/uIvVU750B9A43jSLnJtLnJOB3xKGtu/W9lT1DUJufv2hU3R6/+yQ+WDaiHE+gAgkpLQhk2TZED1krd2n7MH2az7s1XC5VkAZqo1g2eTI+ec60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714594966; c=relaxed/simple;
	bh=7MBlRGjiL4P9ydhF9/k6d50yg3vo4upvs0qO9RmMd78=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DZnOweCj4WZQCaa75L8RurfSHzagvrQl14EHgT9N2vdR4uJR/cTV+ySchTByaR+giErkNKPfC2oP8JltKjw4udbIj+IkCUkEHgFhhzHQrX8NxBRrxvTxYbZuiO2x37dEJy4RwF5yKPjPdBP7bo8XLp0Oe3iK37eIQjpCVenLBZs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BpBWRhMA; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BpBWRhMA"
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-5196c755e82so8871059e87.0
        for <git@vger.kernel.org>; Wed, 01 May 2024 13:22:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714594963; x=1715199763; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+EnBWcyyPww5SNOOV2C33H6dCVjqSaPUD6LA+UaIlxE=;
        b=BpBWRhMALyys+ZtzcF0+CqfEer1dfInKcDs0v3NKx2koLOwIXfwTIEyKQ8ejdG5bLl
         rIFwIO0xNVI//xYHMp5SLf2PvAf2VPsYryiDn+Y1f/yAhTE+cMpvz8G+JZSicfguvpWT
         r8g498AAZw/4Fxi0epHgBlDu83x9uJyb19p9oXlwogkH/9+8IMr6Wph5sO6yrLSwOO5x
         B0KDUaTlqypQZL/5D5CLDiSgS4oKgZDlVrInd6/LOrznC1EVVN/NzYhkL9n4NO8n0r9+
         J00d3J3uGKF515AyWJZdKdgQPNcjZ87GyWrfOoz6LTB7TQnOygHYh95+h5irIBQTIdoR
         nuZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714594963; x=1715199763;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+EnBWcyyPww5SNOOV2C33H6dCVjqSaPUD6LA+UaIlxE=;
        b=s4KOEsJWYEZDfA4pwwCxTQ3v6VbCgTT6rrSMnetuKO5vYj8nUFQQrLsXRnpSDFCkq4
         ritGe+LQ5IFtVU73ipnnrhPOa9io+jamauFGgst8AK4V9RBaJOUKIzWTLOQARgwYzu2S
         w1V+c5f8lL4Ymw2I4eJqQON/EsIH+dALWnSX5U/gYJB6RRjdmN2V4bpjECEnX5r4Qgku
         70FgM0YHfOBkp7o25jT5YvrHVoB2tIAMTiFDTkoA+VsDOUv9JQzVqxrefdHtn+S92WqQ
         ul5Uedce54vFXN9Cg6BNEF6XAKzBKc9ZUAi1W5tTr26zhr8In0Ubviz336gxIfdlMas/
         7+Vg==
X-Forwarded-Encrypted: i=1; AJvYcCWq6zSb3xKNnEnlj1VOVd2wfnCK+rpNjTRKkO+PHTPVSp+a2HX6wVLMnmThcU3gqzBSIdKY9If5C2MxtVXfqQrmnaJV
X-Gm-Message-State: AOJu0YySs8jRAh3/TwVpH7gpZdIgdd0H4VuWEYOSq50of64WYyAXdf5i
	/+Usx5uuxXKNx0/k/LZTJ4g/YRuLm2Guz1s+tKN8V9epKdaJcuCf
X-Google-Smtp-Source: AGHT+IEjjMoWjZ8KBYusubzJWBq6x0DsWj3/ycClNKEuLZhg/nHcpeS9Wf6rrZkycKUxPDd9iLX8oA==
X-Received: by 2002:a19:f818:0:b0:51c:d2df:5cb6 with SMTP id a24-20020a19f818000000b0051cd2df5cb6mr1996257lff.68.1714594962488;
        Wed, 01 May 2024 13:22:42 -0700 (PDT)
Received: from laptop.fritz.box ([2a02:2455:826e:4900:8270:9642:2bfa:e177])
        by smtp.gmail.com with ESMTPSA id hg25-20020a170906f35900b00a58eec6f5acsm5290686ejb.102.2024.05.01.13.22.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 May 2024 13:22:41 -0700 (PDT)
From: Karthik Nayak <karthik.188@gmail.com>
X-Google-Original-From: Karthik Nayak <knayak@gitlab.com>
To: karthik.188@gmail.com
Cc: christian.couder@gmail.com,
	git@vger.kernel.org,
	gitster@pobox.com,
	ps@pks.im
Subject: [PATCH v5 7/7] refs: remove `create_symref` and associated dead code
Date: Wed,  1 May 2024 22:22:29 +0200
Message-ID: <20240501202229.2695774-8-knayak@gitlab.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240501202229.2695774-1-knayak@gitlab.com>
References: <20240426152449.228860-1-knayak@gitlab.com>
 <20240501202229.2695774-1-knayak@gitlab.com>
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

This means, we can now remove `create_symref()` and any code associated
with it which is no longer used. We remove `create_symref()` code from
all the reference backends and also remove it entirely from the
`ref_storage_be` struct.

Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
---
 refs/debug.c            | 13 -------
 refs/files-backend.c    | 64 ------------------------------
 refs/packed-backend.c   |  1 -
 refs/refs-internal.h    |  5 ---
 refs/reftable-backend.c | 86 -----------------------------------------
 5 files changed, 169 deletions(-)

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
index 85c4af7e89..7597760f63 100644
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
 			      const char *target)
@@ -1934,52 +1917,6 @@ static int create_symref_lock(struct files_ref_store *refs,
 	return 0;
 }
 
-static int create_and_commit_symref(struct files_ref_store *refs,
-				    struct ref_lock *lock, const char *refname,
-				    const char *target, const char *logmsg)
-{
-	int ret;
-
-	if (prefer_symlink_refs && !create_ref_symlink(lock, target)) {
-		update_symref_reflog(refs, lock, refname, target, logmsg);
-		return 0;
-	}
-
-	ret = create_symref_lock(refs, lock, refname, target);
-	if (!ret) {
-		update_symref_reflog(refs, lock, refname, target, logmsg);
-
-		if (commit_ref(lock) < 0)
-			return error("unable to write symref for %s: %s", refname,
-				     strerror(errno));
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
@@ -3394,7 +3331,6 @@ struct ref_storage_be refs_be_files = {
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
index 9578665243..fa46548a2f 100644
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
index 5e8a696d40..d4221898e4 100644
--- a/refs/reftable-backend.c
+++ b/refs/reftable-backend.c
@@ -1269,91 +1269,6 @@ struct write_create_symref_arg {
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
@@ -2261,7 +2176,6 @@ struct ref_storage_be refs_be_reftable = {
 	.initial_transaction_commit = reftable_be_initial_transaction_commit,
 
 	.pack_refs = reftable_be_pack_refs,
-	.create_symref = reftable_be_create_symref,
 	.rename_ref = reftable_be_rename_ref,
 	.copy_ref = reftable_be_copy_ref,
 
-- 
2.43.GIT

