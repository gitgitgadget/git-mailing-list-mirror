Received: from fout-b1-smtp.messagingengine.com (fout-b1-smtp.messagingengine.com [202.12.124.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D396F37C92A
	for <git@vger.kernel.org>; Fri, 19 Jun 2026 11:28:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781868503; cv=none; b=ttN0n/rv1pvvruG+dXKtqcI79u/GQs5k+R8tQmXeqrVez8ETQuq2qNp6NaA5EMUvwZ8MGoArd40b84FHAgEz/+4yIDjYB1w58yNVXbHvYN1fqqiOuN9StODq/Z13ZT9UHiT8lXbj+zjsPW46tOmg1C8o+0oySiSgbeEwE/7D7IQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781868503; c=relaxed/simple;
	bh=6W6tN/kIRBbYhDREqdKGE8Y+WlWq6J4Cf2/0Utzsz4Q=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=lNfiC3bdgtPWv8fmWdy9mQOXKAPLlxSLHP4UjXEK7M6sAm++6T/2TZsyzsBlsJAykuULWSTssWRzpBtl77/nLpo9GWAUm4CWx+MJvWM1CggUlh5Lw78k2q2HLD/2cOBUgpOrMiRYSXF/Bq4+wl1METzDNda84eJuDFrMcjrokSQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=f4C2xvk+; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=JIdFPbeD; arc=none smtp.client-ip=202.12.124.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="f4C2xvk+";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="JIdFPbeD"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.stl.internal (Postfix) with ESMTP id 4453F1D00158;
	Fri, 19 Jun 2026 07:28:21 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Fri, 19 Jun 2026 07:28:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1781868501;
	 x=1781954901; bh=4891tVqt8yUvdWbl4mpY8lXGL1Cyy3AnKsSL00DLNU4=; b=
	f4C2xvk+FMTG+VGSFooPyDH33H2Lzy2MHGfknPDikHhmL2w1My3LGgVIu51nKPG/
	ivePSnNyan6XV14sCNxg131pZEVHxZUxEKHi2pcC4BAKUsF8ERoamHTa/Qh7sra7
	JVy9c67jhFv/DbIB/BmEnDpB/pix+GeNIo0mevbPQWYyHvNCnBcrx5JFaLkrFRlM
	qof6s9jS7L7TMtoiXjq9kmzgI3/nk9y+A2hEak4YUZU42qRkTev/jIHmx3UB7+nu
	bBBOnfIolr8Pk4w879tMcZkU7beSFzDUcsa2ygumCEY5gKKDCwfviN+skwISHYft
	3vTeaKtABXWL7bpnq/4Vfw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1781868501; x=
	1781954901; bh=4891tVqt8yUvdWbl4mpY8lXGL1Cyy3AnKsSL00DLNU4=; b=J
	IdFPbeDFpnU5vcV2zK5POWPNZ+5cMCdacSseu6cYtb7r9s1SZCWo29eG/lkhFQH3
	JKSx/oQFRqM2FgdvHqKLVZpd7nhxA8iiik2mxutXQNPBqIM89HvoJESKsiT6fd4k
	I3wVmABx32icsjZ2ZfAhtRRLBbvjpL5xnTvuG7UbXV49FkWYvRu3l4qK25hrTujZ
	d/l4ePB87him4u0SyV9mtlBoDArSthxsUiAu57q/eaSiqutIfphQeeF3igDz6ynU
	PHf2oEcFfnN6HytUSkSyJGWxtuHyg9hGtyCbFuCOJGlXkuhI3Y090bpG4D9rjZd7
	uTtPixVUyn3+SOt0QMsMw==
X-ME-Sender: <xms:1Sc1avFimCog92Ap1o6I1jIs1Y4SWgr9-exsjuBgbMt99na2Zm9Gqg>
    <xme:1Sc1ajVnIaPQa1xXKW43mPy86uxCdLvKRYI4ApJonCNaT-NyEENmfWmWS6kLRJ4ca
    Wh8dkIg2JgZY-wempkKd8BbLLhNrzLCTpPXVqZyX9tAWgOgHgYr8Hc>
X-ME-Received: <xmr:1Sc1amKduABV1rW2OmZwqIZB7Bw1M2ingNllQaXaH7YLMatrBvFmnkXXEfgRZXisCo78zv3W0t5ZZfi_0J19b60Qzfopo07uedzf_z4R7h8>
X-ME-Proxy-Cause: dmFkZTEEz0jJV3BUqZ22JwAI7D9uHiEPDxZ3vLnvEZXM9T8OpWSVa1HWw2itOBwfgT5xwI
    oDB5I8HIlgjolSDFzop07mdpcpU+JIEYQ3M8MNyQcigJWThk3aYKE9SsUIGSxqKTHmSY6c
    XQSVkPoOfT0di60IcMmTWMNd8RwaR4l2yF1xWTIZzF6b1+D+OL7kLE/XwpkQVLsxbZpATq
    dsCwv9I6WciHRwsy/7t416MoQWe1w5Tho1xsdJ+mkjUlMGNC+FcBo+YbLUEG3fGySsMk4M
    AXL5OSbkt21WGHW//hoU4mKgLuV4d4eb3Lay+RsjPCSIDwpeoO6FCdLXaC/izVw81+NUA8
    4BTNxNDV5NCgYwo7z/gt6+KRAcj0n71ebGJthtl5gZtJkeS3OMAfYgImdlRTszU5aTd1JS
    py7SaRN+gKHCdBgCCvtPuGAsOSJ3tiXJE3l4Jq37OoDF8R+7mf8bpS3RkYnBbsjN5dQSgW
    mXP6RUvvtMOb6W+Jc+YnX0SVtBvrZ7f0sHMRRnd7tbnVbMF0Zwek0SErebu1cREZ1RmVON
    At1cSHtwS6GLtn1ha5CaBBG+j2xAE4zv3Mav5qYW5yrLLXA4IgEiMNtFMBSIyi7ez6JP2m
    jHKfWRWSk9+zcMtaIlF+eaO7MYtpK6FV+j3XRcB6O2jIXGYNt2MqLoMzoKaA
X-ME-Proxy: <xmx:1Sc1ar8ceRdSeF_TAsMuXYVhADxvXZVT1sFwmciKZPvmm008ayyJcQ>
    <xmx:1Sc1ahINup2RzlSoJGqGH28C9POecVRAzCA0RXN7bGkWCx2RyZZ_dA>
    <xmx:1Sc1aokKJEcqQme--HQ2BWymGAsUKqiaztqo9cE2kf6BEsJbfHvH7A>
    <xmx:1Sc1atOlBrgSzJgJJaoLMUCVHy69W6GYM0JEM5T9Gykg8ByvV4WRMw>
    <xmx:1Sc1ahPKk5H1UmfaJpoi7rCjQvGtyJK7c30kdKt1Cn8DcwHQw9t_GyY3>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 19 Jun 2026 07:28:20 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 93e2281a (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 19 Jun 2026 11:28:19 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Fri, 19 Jun 2026 13:27:55 +0200
Subject: [PATCH v4 07/10] refs: move parsing of "core.logAllRefUpdates"
 back into ref stores
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260619-b4-pks-refs-avoid-chdir-notify-reparent-v4-7-a6472be7acc4@pks.im>
References: <20260619-b4-pks-refs-avoid-chdir-notify-reparent-v4-0-a6472be7acc4@pks.im>
In-Reply-To: <20260619-b4-pks-refs-avoid-chdir-notify-reparent-v4-0-a6472be7acc4@pks.im>
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
 setup.c                 |  7 ++++++-
 9 files changed, 57 insertions(+), 47 deletions(-)

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
index 79125db565..0c6efb0560 100644
--- a/setup.c
+++ b/setup.c
@@ -2584,10 +2584,15 @@ static int create_default_files(struct repository *repo,
 	if (is_bare_repository())
 		repo_config_set(repo, "core.bare", "true");
 	else {
+		const char *value;
+
 		repo_config_set(repo, "core.bare", "false");
+
 		/* allow template config file to override the default */
-		if (repo_settings_get_log_all_ref_updates(repo) == LOG_REFS_UNSET)
+		if (repo_config_get_string_tmp(repo, "core.logallrefupdates", &value) ||
+		    refs_parse_log_all_ref_updates_config(value) == LOG_REFS_UNSET)
 			repo_config_set(repo, "core.logallrefupdates", "true");
+
 		if (needs_work_tree_config(original_git_dir, work_tree))
 			repo_config_set(repo, "core.worktree", work_tree);
 	}

-- 
2.55.0.rc1.722.g2b3ac350e6.dirty

