Received: from fout-b6-smtp.messagingengine.com (fout-b6-smtp.messagingengine.com [202.12.124.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF65938AC8B
	for <git@vger.kernel.org>; Thu, 25 Jun 2026 09:20:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782379229; cv=none; b=dF1wsmmUPgowe8kuqhhh7QgVk33/JRgxSqzeAeEmJNALFd37WVz0NFxv2aw+OtVlJH4xPWWtgMehi4xIfijGURHk/z2/YUsS79XL1Dp6iMnNwe9ndcfn7UAe/snXk7dX5QsQ7IZJsW2oQ8tyEEuVn6ncXJgnv/fmO060VlvCEnU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782379229; c=relaxed/simple;
	bh=f5t1lBBG3PfRBtDtIKXdNtVoC6xtLSXPI4E5opgHx4o=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ZdcHZdBO4uEbI0mRTq7mh64fAt1USxkXECCTXWFr6q8fZkwAMYSf6zvbIK3rapvL+raqD+x0LlpxTUOz/xOsGwikXXIXSPFLBIYyCqSnDmc4PIwtffFpge9QRqZrCA5Uu6vaLXok0Yh8XvHWHnDnADieYRduuiME/cSmBXNXnCs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Me8l6oiQ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=AF/mEqu1; arc=none smtp.client-ip=202.12.124.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Me8l6oiQ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="AF/mEqu1"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.stl.internal (Postfix) with ESMTP id 5BE5F1D0007A;
	Thu, 25 Jun 2026 05:20:27 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Thu, 25 Jun 2026 05:20:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1782379227;
	 x=1782465627; bh=FoTQsA0/6UeIB8O/KMlTs1oGWtkf38umAVxhAvmLD2M=; b=
	Me8l6oiQO+n6E5bRRkQqObD8CLmGEJMAUXmWAD1le5QWWaXUiRXcrMXcTxDpfYXY
	Ts7Z6LjlvLcUDbVW5T+vtrz1Toad2NXJVAjfwMwOYfHv7c58LuAHycFx7n5ihWgk
	xQy/EejGEsHAxicxPjHdWvLBee5Cc8GSIL03ZRnbxuh+b0bHdH7yp5KqRIf+T8pj
	jTtheyzQKZ3bKg0SR12jt8pt/pbASYLxctekFr/hANcGmoQaxSw8usFuVUmWj3mH
	lQDLMofI1FOal4uXWvynvL2KwBZSLxHTQRcVNl2RzJTtZvsKS5HSdC3+OVIhwNBm
	OYh39nBPkA9YMnlrk77JHQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1782379227; x=
	1782465627; bh=FoTQsA0/6UeIB8O/KMlTs1oGWtkf38umAVxhAvmLD2M=; b=A
	F/mEqu12nFeLh1QHLFVnPAqhEsfPsJj3GnFyToO2aCT0pWamYwsXNjau+HYO1tBz
	HFzt3QR9yS5T4BiiBTq+BEeFtoqWjZX9YivtQsj38FAEtDUIcROjhhclgvB3qZKF
	xEy/j2EBz/Xk+LyAZtUIyUYtOsIBZHpOUDMh7BZUYwc1VPncrt7OFeMIzTE13VkE
	2mvX8PGZQfhmLRgnSOyfpzysmKHRyI+XlPxfHM3vDDLFAql2vyWilykBSsGePQ0+
	wEtIp2qvUr6qtA5GBsb4tlZr/4Mrf5dfBp07ILzD/njTp4kBYbUhxdQxKyTQFMHQ
	q06XSTltOOgD7afoHJYkg==
X-ME-Sender: <xms:2_I8aoDLpcYPDW6nBiEjIeKSqr0YVpbkoVoezTMiw2NjDvUMhMahDA>
    <xme:2_I8alGzVpE4kQiWvdVZGTz9T-gRNBULCg054VsA9GoQ22sStp1EMZDkQlWenhSiy
    gYCBch74ZYv1h_aFXp2GwnZ14V_xuVOti-JZPyE3Ws_ifqzz7GeWPo>
X-ME-Received: <xmr:2_I8aoIt0SyqKvXMYnkYLDBKxxkr1xmhjcnz7vBxD6087My8tWimHz0rQYTsoIDPxf1d-s5xZNUQmoR_Spovb87usKNZUhhUcsL-HoMKJQ>
X-ME-Proxy-Cause: dmFkZTECiehFbCBCaGIdqyHp0fxull32Sn6ApFsfzczKzR7ErCFV6PjBpOS9ucae9/IubB
    vDibQtpUyzue6Jru9M0WbxqrF31f5PO8hW7N1W0zurOKPciSGyW4g2KTgn0S9LvlOSv/xQ
    AGw+Rc9aI83+OJaCR1BYmI+FfJrvGFwP5HFSOtrP702cc967DBOmv6ycdjM7HT1HcOzTSn
    +GqX5MNybndKRgZp+6Jv2qfjWsY8LvSKO/c15oEEKND8nIcuLDwmISN/wcBehOrx+4bRCI
    8V+ztwuWqhHdOqyngrCh+aqBmbthLPycYQCcscGa53Gc16Gpb/FGo9ocV3fImN81ngvZo1
    q2wrFE0nWkapPrFicInAisIxjKKDpzZub8jaJ+fDN6VmSHJSSoZdYNdqzhQp0z9TGWEFnN
    ktFJV9ARYn4CbuiHPOm66XPj+k0+kXuXK2nLRWuppsfr3x3w2UutPjDWqDV0yEvFNFCpRj
    k4RmlmKp82slufAIIO+Voqt+FOqgv69pTn1T3pDtBUn0SazUkkHKjqlKAyj4OMYZhp0xgn
    E8kwmm8NA+C/QsVrMCVWCRQ0rRcA4ouoe41H/32e7I9S7KYM4yRrk5XNOoAcCirw8H41Lk
    4XQu3t7HPuz4u9mvloxVGKsB1FDTgwO9u6HSx0uLoVztxcbGkoPClpAg/Iuw
X-ME-Proxy: <xmx:2_I8ahliDGEUFgySyrfVnzbjYfxR5HPRLsaG4g0dY5BBp_8TS354JQ>
    <xmx:2_I8aoSICt666FZeilrQtQJC_YSQ-uHZtRdR7n3H9Fj1lAzN268qbA>
    <xmx:2_I8arLLvdpMapb2nfOf4ea7Dd8hsJRnJaUhm1R1h15ZR9_8kurwPg>
    <xmx:2_I8amCNFucS0077mqEpMJfVl5tdl2-3bwN-rlMGZgJaFsfmISjE3Q>
    <xmx:2_I8anoKT-y68bq2rGz4uAdM0Ne5Le1WP-4aPwPr4SPnLYbKj54ZQOtT>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 25 Jun 2026 05:20:26 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 033b9074 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 25 Jun 2026 09:20:25 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Thu, 25 Jun 2026 11:20:05 +0200
Subject: [PATCH v6 07/11] refs: move parsing of "core.logAllRefUpdates"
 back into ref stores
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260625-b4-pks-refs-avoid-chdir-notify-reparent-v6-7-41fbca3cf5e3@pks.im>
References: <20260625-b4-pks-refs-avoid-chdir-notify-reparent-v6-0-41fbca3cf5e3@pks.im>
In-Reply-To: <20260625-b4-pks-refs-avoid-chdir-notify-reparent-v6-0-41fbca3cf5e3@pks.im>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>, Jeff King <peff@peff.net>, 
 Justin Tobler <jltobler@gmail.com>
X-Mailer: b4 0.15.2

In cc42c88945 (refs: extract out reflog config to generic layer,
2026-05-04) we have refactored how we parse "core.logAllRefUpdates" so
that it happens in the generic layer. Unfortunately, this has worsened a
preexisting issue where we may recurse when creating the reference store
because of a chicken-and-egg problem between parsing the configuration
and evaluating "onbranch" conditions.

Prepare for a fix by essentially reverting that change so that we handle
this setting in the respective backends again. The backends are already
parsing other configuration anyway, so by moving the logic back in there
we can ensure that all backend configuration is parsed the same way.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/checkout.c      |  7 +++++--
 refs.c                  | 10 +++++++++-
 refs.h                  |  9 +++++++++
 refs/files-backend.c    | 20 +++++++++++++++++---
 refs/refs-internal.h    |  6 ------
 refs/reftable-backend.c | 20 +++++++++++---------
 repo-settings.c         | 16 ----------------
 repo-settings.h         |  9 ---------
 setup.c                 |  6 +++++-
 9 files changed, 56 insertions(+), 47 deletions(-)

diff --git a/builtin/checkout.c b/builtin/checkout.c
index b78b3a1d16..aee84ca897 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -952,10 +952,13 @@ static void update_refs_for_switch(const struct checkout_opts *opts,
 	const char *old_desc, *reflog_msg;
 	if (opts->new_branch) {
 		if (opts->new_orphan_branch) {
-			enum log_refs_config log_all_ref_updates =
-				repo_settings_get_log_all_ref_updates(the_repository);
+			enum log_refs_config log_all_ref_updates = LOG_REFS_UNSET;
+			const char *value;
 			char *refname;
 
+			if (!repo_config_get_string_tmp(the_repository, "core.logallrefupdates", &value))
+				log_all_ref_updates = refs_parse_log_all_ref_updates_config(value);
+
 			refname = mkpathdup("refs/heads/%s", opts->new_orphan_branch);
 			if (opts->new_branch_log &&
 			    !should_autocreate_reflog(log_all_ref_updates, refname)) {
diff --git a/refs.c b/refs.c
index d3caa9a633..5b773b1c15 100644
--- a/refs.c
+++ b/refs.c
@@ -1053,6 +1053,15 @@ static char *normalize_reflog_message(const char *msg)
 	return strbuf_detach(&sb, NULL);
 }
 
+enum log_refs_config refs_parse_log_all_ref_updates_config(const char *value)
+{
+	if (value && !strcasecmp(value, "always"))
+		return LOG_REFS_ALWAYS;
+	else if (git_config_bool("core.logallrefupdates", value))
+		return LOG_REFS_NORMAL;
+	return LOG_REFS_NONE;
+}
+
 int should_autocreate_reflog(enum log_refs_config log_all_ref_updates,
 			     const char *refname)
 {
@@ -2327,7 +2336,6 @@ static struct ref_store *ref_store_init(struct repository *repo,
 	struct ref_store *refs;
 	struct ref_store_init_options opts = {
 		.access_flags = flags,
-		.log_all_ref_updates = repo_settings_get_log_all_ref_updates(repo),
 	};
 
 	be = find_ref_storage_backend(format);
diff --git a/refs.h b/refs.h
index 71d5c186d0..a381022c77 100644
--- a/refs.h
+++ b/refs.h
@@ -146,6 +146,15 @@ enum ref_transaction_error refs_verify_refname_available(struct ref_store *refs,
 
 int refs_ref_exists(struct ref_store *refs, const char *refname);
 
+enum log_refs_config {
+	LOG_REFS_UNSET = -1,
+	LOG_REFS_NONE = 0,
+	LOG_REFS_NORMAL,
+	LOG_REFS_ALWAYS
+};
+
+enum log_refs_config refs_parse_log_all_ref_updates_config(const char *value);
+
 int should_autocreate_reflog(enum log_refs_config log_all_ref_updates,
 			     const char *refname);
 
diff --git a/refs/files-backend.c b/refs/files-backend.c
index 296981584b..79fb6735e1 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -117,6 +117,21 @@ static void files_ref_store_reparent(const char *name UNUSED,
 	refs->gitcommondir = tmp;
 }
 
+static int files_ref_store_config(const char *var, const char *value,
+				  const struct config_context *ctx UNUSED,
+				  void *payload)
+{
+	struct files_ref_store *refs = payload;
+
+	if (!strcmp(var, "core.prefersymlinkrefs")) {
+		refs->prefer_symlink_refs = git_config_bool(var, value);
+	} else if (!strcmp(var, "core.logallrefupdates")) {
+		refs->log_all_ref_updates = refs_parse_log_all_ref_updates_config(value);
+	}
+
+	return 0;
+}
+
 /*
  * Create a new submodule ref cache and add it to the internal
  * set of caches.
@@ -141,10 +156,9 @@ static struct ref_store *files_ref_store_init(struct repository *repo,
 	refs->packed_ref_store =
 		packed_ref_store_init(repo, NULL, refs->gitcommondir, opts);
 	refs->store_flags = opts->access_flags;
-	refs->log_all_ref_updates = opts->log_all_ref_updates;
-
-	repo_config_get_bool(repo, "core.prefersymlinkrefs", &refs->prefer_symlink_refs);
+	refs->log_all_ref_updates = LOG_REFS_UNSET;
 
+	repo_config(repo, files_ref_store_config, refs);
 	chdir_notify_register(NULL, files_ref_store_reparent, refs);
 
 	strbuf_release(&refdir);
diff --git a/refs/refs-internal.h b/refs/refs-internal.h
index a08d58900e..c3ac7b556f 100644
--- a/refs/refs-internal.h
+++ b/refs/refs-internal.h
@@ -406,12 +406,6 @@ struct ref_store;
 struct ref_store_init_options {
 	/* The kind of operations that the ref_store is allowed to perform. */
 	unsigned int access_flags;
-
-	/*
-	 * Denotes under what conditions reflogs should be created when updating
-	 * references.
-	 */
-	enum log_refs_config log_all_ref_updates;
 };
 
 /*
diff --git a/refs/reftable-backend.c b/refs/reftable-backend.c
index 8c93070677..5115a3f4ce 100644
--- a/refs/reftable-backend.c
+++ b/refs/reftable-backend.c
@@ -332,34 +332,36 @@ static void fill_reftable_log_record(struct reftable_log_record *log, const stru
 
 static int reftable_be_config(const char *var, const char *value,
 			      const struct config_context *ctx,
-			      void *_opts)
+			      void *payload)
 {
-	struct reftable_write_options *opts = _opts;
+	struct reftable_ref_store *refs = payload;
 
 	if (!strcmp(var, "reftable.blocksize")) {
 		unsigned long block_size = git_config_ulong(var, value, ctx->kvi);
 		if (block_size > 16777215)
 			die("reftable block size cannot exceed 16MB");
-		opts->block_size = block_size;
+		refs->write_options.block_size = block_size;
 	} else if (!strcmp(var, "reftable.restartinterval")) {
 		unsigned long restart_interval = git_config_ulong(var, value, ctx->kvi);
 		if (restart_interval > UINT16_MAX)
 			die("reftable block size cannot exceed %u", (unsigned)UINT16_MAX);
-		opts->restart_interval = restart_interval;
+		refs->write_options.restart_interval = restart_interval;
 	} else if (!strcmp(var, "reftable.indexobjects")) {
-		opts->skip_index_objects = !git_config_bool(var, value);
+		refs->write_options.skip_index_objects = !git_config_bool(var, value);
 	} else if (!strcmp(var, "reftable.geometricfactor")) {
 		unsigned long factor = git_config_ulong(var, value, ctx->kvi);
 		if (factor > UINT8_MAX)
 			die("reftable geometric factor cannot exceed %u", (unsigned)UINT8_MAX);
-		opts->auto_compaction_factor = factor;
+		refs->write_options.auto_compaction_factor = factor;
 	} else if (!strcmp(var, "reftable.locktimeout")) {
 		int64_t lock_timeout = git_config_int64(var, value, ctx->kvi);
 		if (lock_timeout > LONG_MAX)
 			die("reftable lock timeout cannot exceed %"PRIdMAX, (intmax_t)LONG_MAX);
 		if (lock_timeout < 0 && lock_timeout != -1)
 			die("reftable lock timeout does not support negative values other than -1");
-		opts->lock_timeout_ms = lock_timeout;
+		refs->write_options.lock_timeout_ms = lock_timeout;
+	} else if (!strcmp(var, "core.logallrefupdates")) {
+		refs->log_all_ref_updates = refs_parse_log_all_ref_updates_config(value);
 	}
 
 	return 0;
@@ -398,7 +400,6 @@ static struct ref_store *reftable_be_init(struct repository *repo,
 
 	base_ref_store_init(&refs->base, repo, refdir.buf, &refs_be_reftable);
 	strmap_init(&refs->worktree_backends);
-	refs->log_all_ref_updates = opts->log_all_ref_updates;
 	refs->store_flags = opts->access_flags;
 
 	switch (repo->hash_algo->format_id) {
@@ -415,8 +416,9 @@ static struct ref_store *reftable_be_init(struct repository *repo,
 	refs->write_options.disable_auto_compact =
 		!git_env_bool("GIT_TEST_REFTABLE_AUTOCOMPACTION", 1);
 	refs->write_options.lock_timeout_ms = 100;
+	refs->log_all_ref_updates = LOG_REFS_UNSET;
 
-	repo_config(repo, reftable_be_config, &refs->write_options);
+	repo_config(repo, reftable_be_config, refs);
 
 	/*
 	 * It is somewhat unfortunate that we have to mirror the default block
diff --git a/repo-settings.c b/repo-settings.c
index 208e09ff17..f3be3b8c5a 100644
--- a/repo-settings.c
+++ b/repo-settings.c
@@ -177,22 +177,6 @@ void repo_settings_set_big_file_threshold(struct repository *repo, unsigned long
 	repo->settings.big_file_threshold = value;
 }
 
-enum log_refs_config repo_settings_get_log_all_ref_updates(struct repository *repo)
-{
-	const char *value;
-
-	if (!repo_config_get_string_tmp(repo, "core.logallrefupdates", &value)) {
-		if (value && !strcasecmp(value, "always"))
-			return LOG_REFS_ALWAYS;
-		else if (git_config_bool("core.logallrefupdates", value))
-			return LOG_REFS_NORMAL;
-		else
-			return LOG_REFS_NONE;
-	}
-
-	return LOG_REFS_UNSET;
-}
-
 int repo_settings_get_warn_ambiguous_refs(struct repository *repo)
 {
 	prepare_repo_settings(repo);
diff --git a/repo-settings.h b/repo-settings.h
index cad9c3f0cc..e5253ead02 100644
--- a/repo-settings.h
+++ b/repo-settings.h
@@ -16,13 +16,6 @@ enum fetch_negotiation_setting {
 	FETCH_NEGOTIATION_NOOP,
 };
 
-enum log_refs_config {
-	LOG_REFS_UNSET = -1,
-	LOG_REFS_NONE = 0,
-	LOG_REFS_NORMAL,
-	LOG_REFS_ALWAYS
-};
-
 struct repo_settings {
 	int initialized;
 
@@ -86,8 +79,6 @@ struct repo_settings {
 void prepare_repo_settings(struct repository *r);
 void repo_settings_clear(struct repository *r);
 
-/* Read the value for "core.logAllRefUpdates". */
-enum log_refs_config repo_settings_get_log_all_ref_updates(struct repository *repo);
 /* Read the value for "core.warnAmbiguousRefs". */
 int repo_settings_get_warn_ambiguous_refs(struct repository *repo);
 /* Read the value for "core.hooksPath". */
diff --git a/setup.c b/setup.c
index 79125db565..592753457c 100644
--- a/setup.c
+++ b/setup.c
@@ -2584,10 +2584,14 @@ static int create_default_files(struct repository *repo,
 	if (is_bare_repository())
 		repo_config_set(repo, "core.bare", "true");
 	else {
+		const char *value;
+
 		repo_config_set(repo, "core.bare", "false");
+
 		/* allow template config file to override the default */
-		if (repo_settings_get_log_all_ref_updates(repo) == LOG_REFS_UNSET)
+		if (repo_config_get_string_tmp(repo, "core.logallrefupdates", &value))
 			repo_config_set(repo, "core.logallrefupdates", "true");
+
 		if (needs_work_tree_config(original_git_dir, work_tree))
 			repo_config_set(repo, "core.worktree", work_tree);
 	}

-- 
2.55.0.rc1.745.g43192e7977.dirty

