Received: from fout-b6-smtp.messagingengine.com (fout-b6-smtp.messagingengine.com [202.12.124.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65EC3386C17
	for <git@vger.kernel.org>; Thu, 25 Jun 2026 09:20:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782379237; cv=none; b=qcYELY/V1Cd+zRibj/0aSIZ7LVf21w6mY9ULdZNAb3kd+E4+vRcCjTbu3OdCLs3gupQqnBkkOtsmGU3sUf0aCtuTg1y8j3ud7WF43gdomxdWxlHnqIrWSdYG3JXO9rLjCa8p8pubbDSRmf+y+WEbgW0QAsAojaXNaK8f392S/U4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782379237; c=relaxed/simple;
	bh=cEBAAQg5PXUGIRwkZJy6XebIhymYErt9kGizinOAaa4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=r7UxGUpAycsQsycDh1Q0tY+ethdhOSNG2OYKaHuZ2g4tH4uHpIBKn4JX78kOswpwMt0Kk3LdycbdWytNEC5hQvK1Kg3Y9HmF8ZOUG+8tW8AeGgaRMh0G0S5GYYHmSgN15j4ExI7AKp2TFM/sE9yde/MzOk7fyuzNmbWrICg/BLI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=j5xGxz+1; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=cv5VN9hI; arc=none smtp.client-ip=202.12.124.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="j5xGxz+1";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="cv5VN9hI"
Received: from phl-compute-08.internal (phl-compute-08.internal [10.202.2.48])
	by mailfout.stl.internal (Postfix) with ESMTP id D87A41D0012D;
	Thu, 25 Jun 2026 05:20:34 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-08.internal (MEProxy); Thu, 25 Jun 2026 05:20:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1782379234;
	 x=1782465634; bh=Jpzxcep/lA5khozByRS9myfD/lu18p0UUFD+hRrduCs=; b=
	j5xGxz+1uUFuYLRbbDGQ7Ww7BbJIj+jsXzXHOHhAeQESaxxGI+T3LCAr8aSk0F3s
	ZPjj5UceTQvnqe/dy0j+o9oRUaqGgBrZdFDPEvJ8DADF/sHOdjm9Kg/1NtDIWaZk
	nRVUY35bZbe582aNT1HatECjuUX6BV3XdInLwo1d9Pvx+gDNwa455SZAuJHh3YrM
	mFErwBOlei0qT7KuSCE/it2ZsNYnYYZ1jwz3GdbfHj8eOhWLTqT4fBYmjsaSrCQ7
	d97HL+g7YF9st6sNvrWCNhJfLG7sKjsWNFPRSpuXbGLcNk0R9ImYmiaAvShvJtFf
	QIBYCOq0mogyxfWJugDNtQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1782379234; x=
	1782465634; bh=Jpzxcep/lA5khozByRS9myfD/lu18p0UUFD+hRrduCs=; b=c
	v5VN9hI0OR4OogFzKv1jmIViCL81PpAp4X/UUdcRn/m18E6gO4udfbAmE/f+Kne2
	bcVwnaSazzSbw0CnYX2yIXl37OjgDFHiv9Rgpwpy6dGFFiraoW8AyODdeC4a1q0/
	PvQRFI3vLMgqd5HwmQHjayZY9isbaaxdyPraMbShZ4UFsM1dJ3sw/Gm+JZxv/3iR
	inXlpC5p61JI2uqLlV0QRskUy+FWvk1qhUPmuQ13bIGTppvTQYRkEEobadlJECHI
	6cmZzckzdX792Ap3a12MJcyQsgd1G5wYZzH8y8eUd3OFr7/XUai0nfDn2+4JP4UJ
	sD0QH7vCrEeZFGTrkk8sA==
X-ME-Sender: <xms:4vI8ajwOLYE7PMs4i3Yutn8FTa72G24ukQyTSvTCMkN-h6VOM-QGcg>
    <xme:4vI8aiS4dwWHNZ_niDdh1v0KrRlFKkjkLMyBQyFMKxYdVBLllpWy3O0zxyRUgcmh0
    tWgzWba-xIw8htCai6hWIoMJ-uNDUa2I9bKwH_q_Li5wwIWMrDwZQ>
X-ME-Received: <xmr:4vI8aiXNg0rZ3huFsn8rvxHE_2TKYjyXKmmPv8T3GHs9cWxAakIq4d7ZFGb5A3EmNqRJ_domgabNYr4HKikQYkCjg-Y_eVLIzJ6MzPWChA>
X-ME-Proxy-Cause: dmFkZTE9vx1XWCZgGirAFAHrRqU2+w+1nAlmTaYF6U+GgAWWi6YoULBQAbasmBWrKFkfNJ
    nw3OH4+XAYnD2MZns1z9mfmMUl/TDFHAd1MdLNJ8kY1bQHFiMvmB25EuCBrX8Ollofb/RD
    uD/Kna4wLQarX6/nDdpXtpGLHskBMWyEVFxPxsViBXZ5zITL36QfworxU++PwwweM6xcw7
    7pCCaH+2lk/7Fq/wY2eMkHM/8ork1gn8G3bh8lcf47QagKBFS9khwDBXDes8PqLdRVq+Ja
    9q7oF6jBMF2aTwPATRVuBw0/56g/5lXLgMj9Gsl7jx7ASz8K+mvY1eOw+1EGrkfnbkApX7
    sF7bRj0DW7KrVnZf0BrfpOQeD8RA1aFlE62fZd2i/lPb4YjnGpZbLbst8m4p1UuyTkc6Xm
    xRNrSGCXcwBFFOHOztR07o8et/Ip6yLHxPWNL4y8hZM/Jl6V5Q1mdaXvwwPoFcji7dQ96x
    00KrWFJ1Giicv9eyO/PDj3j/lQ/jq5voqBGlSi65NXDdN0WfQCaKnocWUMNBnr1G8NGpVy
    DfBYz/x+uHmT6Z9P4ff7dn/JChegZp1T+MblhjrxiSmGJIiPq6cNoTGLf2EcDgoEVKsT+i
    YAZvk+LMrElDDiKEPtPnkcXcTYgO6fOcDDcvHx+jc/s+ynctef/fUQW6tAPg
X-ME-Proxy: <xmx:4vI8asakqTESbuECGUweAlL-4Vz_81YHgAmlYY-6VGXn3BIkIuVeSA>
    <xmx:4vI8ag1CDtcFX-MacuovBLW2H8llNQ4bWW01mNlQ9rk2eM-3-XQicQ>
    <xmx:4vI8amgb_NhQXRrQ4ePUv4_njeei2c4P0Hs-wwJ97uvUda6pFkgsEQ>
    <xmx:4vI8asYuwt9nZlY1EArS2xZqAVIwNcJs1JVp8jFCg2kIkO-2UN3SLQ>
    <xmx:4vI8amZpnm7zJllPw0FFLEplrYZpKQZi7VWNZ8-GUscy5BBW9e3GriCQ>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 25 Jun 2026 05:20:33 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id d8f87c15 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 25 Jun 2026 09:20:33 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Thu, 25 Jun 2026 11:20:08 +0200
Subject: [PATCH v6 10/11] refs/reftable: lazy-load configuration to fix
 chicken-and-egg
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260625-b4-pks-refs-avoid-chdir-notify-reparent-v6-10-41fbca3cf5e3@pks.im>
References: <20260625-b4-pks-refs-avoid-chdir-notify-reparent-v6-0-41fbca3cf5e3@pks.im>
In-Reply-To: <20260625-b4-pks-refs-avoid-chdir-notify-reparent-v6-0-41fbca3cf5e3@pks.im>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>, Jeff King <peff@peff.net>, 
 Justin Tobler <jltobler@gmail.com>
X-Mailer: b4 0.15.2

Same as with the "files" backend, the "reftable" backend also has a
chicken-and-egg problem with "onbranch" conditions. Fix this issue the
same as we did with the "files" backend by lazy-loading configuration.

Now that both the "files" and the "reftable" backend handle this
properly, add a generic test to t1400 that verifies that the user can
configure "core.logAllRefUpdates" via an "onbranch" condition. This is
mostly a nonsensical thing to do in the first place, but it serves as a
good sanity check.

Note that we had to move `should_write_log()` around so that it can
access the new `reftable_be_write_options()` function.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 refs/reftable-backend.c           | 146 ++++++++++++++++++++++----------------
 t/t0613-reftable-write-options.sh |  19 +++++
 t/t1400-update-ref.sh             |  12 ++++
 3 files changed, 116 insertions(+), 61 deletions(-)

diff --git a/refs/reftable-backend.c b/refs/reftable-backend.c
index 608d71cf10..d74131a5ae 100644
--- a/refs/reftable-backend.c
+++ b/refs/reftable-backend.c
@@ -141,10 +141,21 @@ struct reftable_ref_store {
 	 */
 	struct strmap worktree_backends;
 	struct reftable_stack_options stack_options;
-	struct reftable_write_options write_options;
+
+	/*
+	 * Options used when writing to or compacting the reftable stacks.
+	 * These are parsed from the configuration lazily on first use via
+	 * `reftable_be_write_options()` so that we don't have to access the
+	 * configuration when initializing the ref store. Do not access these
+	 * fields directly, but use the accessor instead.
+	 */
+	struct reftable_be_write_options {
+		struct reftable_write_options opts;
+		enum log_refs_config log_all_ref_updates;
+		bool initialized;
+	} write_opts_lazy_loaded;
 
 	unsigned int store_flags;
-	enum log_refs_config log_all_ref_updates;
 	int err;
 };
 
@@ -285,26 +296,6 @@ static int backend_for(struct reftable_backend **out,
 	return ret;
 }
 
-static int should_write_log(struct reftable_ref_store *refs, const char *refname)
-{
-	enum log_refs_config log_refs_cfg = refs->log_all_ref_updates;
-	if (log_refs_cfg == LOG_REFS_UNSET)
-		log_refs_cfg = is_bare_repository() ? LOG_REFS_NONE : LOG_REFS_NORMAL;
-
-	switch (log_refs_cfg) {
-	case LOG_REFS_NONE:
-		return refs_reflog_exists(&refs->base, refname);
-	case LOG_REFS_ALWAYS:
-		return 1;
-	case LOG_REFS_NORMAL:
-		if (should_autocreate_reflog(log_refs_cfg, refname))
-			return 1;
-		return refs_reflog_exists(&refs->base, refname);
-	default:
-		BUG("unhandled core.logAllRefUpdates value %d", log_refs_cfg);
-	}
-}
-
 static void fill_reftable_log_record(struct reftable_log_record *log, const struct ident_split *split)
 {
 	const char *tz_begin;
@@ -336,38 +327,72 @@ static int reftable_be_config(const char *var, const char *value,
 			      void *payload)
 {
 	struct reftable_ref_store *refs = payload;
+	struct reftable_be_write_options *opts = &refs->write_opts_lazy_loaded;
 
 	if (!strcmp(var, "reftable.blocksize")) {
 		unsigned long block_size = git_config_ulong(var, value, ctx->kvi);
 		if (block_size > 16777215)
 			die("reftable block size cannot exceed 16MB");
-		refs->write_options.block_size = block_size;
+		opts->opts.block_size = block_size;
 	} else if (!strcmp(var, "reftable.restartinterval")) {
 		unsigned long restart_interval = git_config_ulong(var, value, ctx->kvi);
 		if (restart_interval > UINT16_MAX)
 			die("reftable block size cannot exceed %u", (unsigned)UINT16_MAX);
-		refs->write_options.restart_interval = restart_interval;
+		opts->opts.restart_interval = restart_interval;
 	} else if (!strcmp(var, "reftable.indexobjects")) {
-		refs->write_options.skip_index_objects = !git_config_bool(var, value);
+		opts->opts.skip_index_objects = !git_config_bool(var, value);
 	} else if (!strcmp(var, "reftable.geometricfactor")) {
 		unsigned long factor = git_config_ulong(var, value, ctx->kvi);
 		if (factor > UINT8_MAX)
 			die("reftable geometric factor cannot exceed %u", (unsigned)UINT8_MAX);
-		refs->write_options.auto_compaction_factor = factor;
+		opts->opts.auto_compaction_factor = factor;
 	} else if (!strcmp(var, "reftable.locktimeout")) {
 		int64_t lock_timeout = git_config_int64(var, value, ctx->kvi);
 		if (lock_timeout > LONG_MAX)
 			die("reftable lock timeout cannot exceed %"PRIdMAX, (intmax_t)LONG_MAX);
 		if (lock_timeout < 0 && lock_timeout != -1)
 			die("reftable lock timeout does not support negative values other than -1");
-		refs->write_options.lock_timeout_ms = lock_timeout;
+		opts->opts.lock_timeout_ms = lock_timeout;
 	} else if (!strcmp(var, "core.logallrefupdates")) {
-		refs->log_all_ref_updates = refs_parse_log_all_ref_updates_config(value);
+		opts->log_all_ref_updates = refs_parse_log_all_ref_updates_config(value);
 	}
 
 	return 0;
 }
 
+static const struct reftable_be_write_options *reftable_be_write_options(struct reftable_ref_store *refs)
+{
+	struct reftable_be_write_options *opts = &refs->write_opts_lazy_loaded;
+	mode_t mask;
+
+	if (opts->initialized)
+		return opts;
+
+	mask = umask(0);
+	umask(mask);
+
+	opts->opts.default_permissions = calc_shared_perm(refs->base.repo, 0666 & ~mask);
+	opts->opts.disable_auto_compact =
+		!git_env_bool("GIT_TEST_REFTABLE_AUTOCOMPACTION", 1);
+	opts->opts.lock_timeout_ms = 100;
+	opts->log_all_ref_updates = LOG_REFS_UNSET;
+
+	repo_config(refs->base.repo, reftable_be_config, refs);
+
+	/*
+	 * It is somewhat unfortunate that we have to mirror the default block
+	 * size of the reftable library here. But given that the write options
+	 * wouldn't be updated by the library here, and given that we require
+	 * the proper block size to trim reflog message so that they fit, we
+	 * must set up a proper value here.
+	 */
+	if (!opts->opts.block_size)
+		opts->opts.block_size = 4096;
+
+	opts->initialized = true;
+	return opts;
+}
+
 static void reftable_be_reparent(const char *name UNUSED,
 				 const char *old_cwd,
 				 const char *new_cwd,
@@ -391,10 +416,6 @@ static struct ref_store *reftable_be_init(struct repository *repo,
 	struct strbuf refdir = STRBUF_INIT;
 	struct strbuf path = STRBUF_INIT;
 	bool is_worktree;
-	mode_t mask;
-
-	mask = umask(0);
-	umask(mask);
 
 	refs_compute_filesystem_location(gitdir, payload, &is_worktree, &refdir,
 					 &ref_common_dir);
@@ -413,23 +434,6 @@ static struct ref_store *reftable_be_init(struct repository *repo,
 	default:
 		BUG("unknown hash algorithm %d", repo->hash_algo->format_id);
 	}
-	refs->write_options.default_permissions = calc_shared_perm(repo, 0666 & ~mask);
-	refs->write_options.disable_auto_compact =
-		!git_env_bool("GIT_TEST_REFTABLE_AUTOCOMPACTION", 1);
-	refs->write_options.lock_timeout_ms = 100;
-	refs->log_all_ref_updates = LOG_REFS_UNSET;
-
-	repo_config(repo, reftable_be_config, refs);
-
-	/*
-	 * It is somewhat unfortunate that we have to mirror the default block
-	 * size of the reftable library here. But given that the write options
-	 * wouldn't be updated by the library here, and given that we require
-	 * the proper block size to trim reflog message so that they fit, we
-	 * must set up a proper value here.
-	 */
-	if (!refs->write_options.block_size)
-		refs->write_options.block_size = 4096;
 
 	/*
 	 * Set up the main reftable stack that is hosted in GIT_COMMON_DIR.
@@ -998,7 +1002,7 @@ static int prepare_transaction_update(struct write_transaction_table_arg **out,
 		struct reftable_addition *addition;
 
 		ret = reftable_stack_new_addition(&addition, be->stack,
-						  &refs->write_options,
+						  &reftable_be_write_options(refs)->opts,
 						  REFTABLE_STACK_NEW_ADDITION_RELOAD);
 		if (ret) {
 			if (ret == REFTABLE_LOCK_ERROR)
@@ -1437,6 +1441,26 @@ static int transaction_update_cmp(const void *a, const void *b)
 	return strcmp(update_a->update->refname, update_b->update->refname);
 }
 
+static int should_write_log(struct reftable_ref_store *refs, const char *refname)
+{
+	enum log_refs_config log_refs_cfg = reftable_be_write_options(refs)->log_all_ref_updates;
+	if (log_refs_cfg == LOG_REFS_UNSET)
+		log_refs_cfg = is_bare_repository() ? LOG_REFS_NONE : LOG_REFS_NORMAL;
+
+	switch (log_refs_cfg) {
+	case LOG_REFS_NONE:
+		return refs_reflog_exists(&refs->base, refname);
+	case LOG_REFS_ALWAYS:
+		return 1;
+	case LOG_REFS_NORMAL:
+		if (should_autocreate_reflog(log_refs_cfg, refname))
+			return 1;
+		return refs_reflog_exists(&refs->base, refname);
+	default:
+		BUG("unhandled core.logAllRefUpdates value %d", log_refs_cfg);
+	}
+}
+
 static int write_transaction_table(struct reftable_writer *writer, void *cb_data)
 {
 	struct write_transaction_table_arg *arg = cb_data;
@@ -1571,7 +1595,7 @@ static int write_transaction_table(struct reftable_writer *writer, void *cb_data
 				memcpy(log->value.update.old_hash,
 				       tx_update->current_oid.hash, GIT_MAX_RAWSZ);
 				log->value.update.message =
-					xstrndup(u->msg, arg->refs->write_options.block_size / 2);
+					xstrndup(u->msg, reftable_be_write_options(arg->refs)->opts.block_size / 2);
 			}
 		}
 
@@ -1687,9 +1711,9 @@ static int reftable_be_optimize(struct ref_store *ref_store,
 		stack = refs->main_backend.stack;
 
 	if (opts->flags & REFS_OPTIMIZE_AUTO)
-		ret = reftable_stack_auto_compact(stack, &refs->write_options);
+		ret = reftable_stack_auto_compact(stack, &reftable_be_write_options(refs)->opts);
 	else
-		ret = reftable_stack_compact_all(stack, &refs->write_options, NULL);
+		ret = reftable_stack_compact_all(stack, &reftable_be_write_options(refs)->opts, NULL);
 	if (ret < 0) {
 		ret = error(_("unable to compact stack: %s"),
 			    reftable_error_str(ret));
@@ -1723,7 +1747,7 @@ static int reftable_be_optimize_required(struct ref_store *ref_store,
 	if (opts->flags & REFS_OPTIMIZE_AUTO)
 		use_heuristics = true;
 
-	return reftable_stack_compaction_required(stack, &refs->write_options,
+	return reftable_stack_compaction_required(stack, &reftable_be_write_options(refs)->opts,
 						  use_heuristics, required);
 }
 
@@ -1843,7 +1867,7 @@ static int write_copy_table(struct reftable_writer *writer, void *cb_data)
 		logs[logs_nr].refname = xstrdup(arg->newname);
 		logs[logs_nr].update_index = deletion_ts;
 		logs[logs_nr].value.update.message =
-			xstrndup(arg->logmsg, arg->refs->write_options.block_size / 2);
+			xstrndup(arg->logmsg, reftable_be_write_options(arg->refs)->opts.block_size / 2);
 		memcpy(logs[logs_nr].value.update.old_hash, old_ref.value.val1, GIT_MAX_RAWSZ);
 		logs_nr++;
 
@@ -1882,7 +1906,7 @@ static int write_copy_table(struct reftable_writer *writer, void *cb_data)
 	logs[logs_nr].refname = xstrdup(arg->newname);
 	logs[logs_nr].update_index = creation_ts;
 	logs[logs_nr].value.update.message =
-		xstrndup(arg->logmsg, arg->refs->write_options.block_size / 2);
+		xstrndup(arg->logmsg, reftable_be_write_options(arg->refs)->opts.block_size / 2);
 	memcpy(logs[logs_nr].value.update.new_hash, old_ref.value.val1, GIT_MAX_RAWSZ);
 	logs_nr++;
 
@@ -1981,7 +2005,7 @@ static int reftable_be_rename_ref(struct ref_store *ref_store,
 	if (ret)
 		goto done;
 	ret = reftable_stack_add(arg.be->stack, &write_copy_table, &arg,
-				 &refs->write_options,
+				 &reftable_be_write_options(refs)->opts,
 				 REFTABLE_STACK_NEW_ADDITION_RELOAD);
 
 done:
@@ -2012,7 +2036,7 @@ static int reftable_be_copy_ref(struct ref_store *ref_store,
 	if (ret)
 		goto done;
 	ret = reftable_stack_add(arg.be->stack, &write_copy_table, &arg,
-				 &refs->write_options,
+				 &reftable_be_write_options(refs)->opts,
 				 REFTABLE_STACK_NEW_ADDITION_RELOAD);
 
 done:
@@ -2378,7 +2402,7 @@ static int reftable_be_create_reflog(struct ref_store *ref_store,
 	arg.stack = be->stack;
 
 	ret = reftable_stack_add(be->stack, &write_reflog_existence_table, &arg,
-				 &refs->write_options,
+				 &reftable_be_write_options(refs)->opts,
 				 REFTABLE_STACK_NEW_ADDITION_RELOAD);
 
 done:
@@ -2451,7 +2475,7 @@ static int reftable_be_delete_reflog(struct ref_store *ref_store,
 	arg.stack = be->stack;
 
 	ret = reftable_stack_add(be->stack, &write_reflog_delete_table, &arg,
-				 &refs->write_options,
+				 &reftable_be_write_options(refs)->opts,
 				 REFTABLE_STACK_NEW_ADDITION_RELOAD);
 
 	assert(ret != REFTABLE_API_ERROR);
@@ -2574,7 +2598,7 @@ static int reftable_be_reflog_expire(struct ref_store *ref_store,
 		goto done;
 
 	ret = reftable_stack_new_addition(&add, be->stack,
-					  &refs->write_options,
+					  &reftable_be_write_options(refs)->opts,
 					  REFTABLE_STACK_NEW_ADDITION_RELOAD);
 	if (ret < 0)
 		goto done;
diff --git a/t/t0613-reftable-write-options.sh b/t/t0613-reftable-write-options.sh
index 26b716c75f..a65960d048 100755
--- a/t/t0613-reftable-write-options.sh
+++ b/t/t0613-reftable-write-options.sh
@@ -278,4 +278,23 @@ test_expect_success 'object index can be disabled' '
 	)
 '
 
+test_expect_success 'write options can be set up via onbranch condition' '
+	test_config_global core.logAllRefUpdates false &&
+	test_when_finished "rm -rf repo" &&
+	init_repo &&
+	(
+		cd repo &&
+		test_commit A &&
+		test_commit B &&
+		cat >.git/include <<-\EOF &&
+		[reftable]
+			blockSize = 123
+		EOF
+		git config includeIf.onbranch:master.path "$(pwd)/.git/include" &&
+		git refs optimize &&
+		test-tool dump-reftable -b .git/reftable/*.ref >stats &&
+		test_grep "block_size: 123" stats
+	)
+'
+
 test_done
diff --git a/t/t1400-update-ref.sh b/t/t1400-update-ref.sh
index 1015f335e3..b8c3be6631 100755
--- a/t/t1400-update-ref.sh
+++ b/t/t1400-update-ref.sh
@@ -178,6 +178,18 @@ test_expect_success '--no-create-reflog overrides core.logAllRefUpdates=always'
 	test_must_fail git reflog exists $outside
 '
 
+test_expect_success 'core.logAllRefUpdates can be set up via onbranch condition' '
+	test_when_finished "git update-ref -d $outside" &&
+	test_when_finished "rm -f .git/include" &&
+	cat >.git/include <<-\EOF &&
+	[core]
+		logAllRefUpdates = always
+	EOF
+	test_config includeIf.onbranch:main.path "$(pwd)/.git/include" &&
+	git update-ref $outside $A &&
+	git reflog exists $outside
+'
+
 test_expect_success "create $m (by HEAD)" '
 	git update-ref HEAD $A &&
 	test $A = $(git show-ref -s --verify $m)

-- 
2.55.0.rc1.745.g43192e7977.dirty

