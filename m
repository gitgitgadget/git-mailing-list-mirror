Received: from fhigh4-smtp.messagingengine.com (fhigh4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72F2B1714CC
	for <git@vger.kernel.org>; Thu, 15 Aug 2024 11:22:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723720928; cv=none; b=hkyk+NsVDAwig+hzJDeyFQVcKC6XaAdUYs7qMp8Evp7TKoz9UJZI0OTcPz6rcktH0g+alFXY93WhvzCfthfDleDv5DYhrlWn+WiCD2vTuIfohIy0SNLZlTc46BkGlaD03RjM8/CYa/BYVyIqSu9O0Ddnanvx4eTO0EcruS27JTA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723720928; c=relaxed/simple;
	bh=4Wzv36psV92fF6A3OxDi5LlfStXVgt9cTn++ujBmkMQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=C4iALps6RqQqJSNSuXr5Pl7hgiYVtv16qrWnuCnQZC1K42v/F2iW6XihynYHIyu+bjbKDuyPanvehmANNQU+untZRFPA550ya2pYxkQznH7bzrW5H6Kw2XqIKnQ46Kc/Ay7I45fI4/pBWpQwDoXfx4tfQreAqIIKt0lhOZ5HDeg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=To5vw5HT; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Zd8vzR6S; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="To5vw5HT";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Zd8vzR6S"
Received: from phl-compute-01.internal (phl-compute-01.nyi.internal [10.202.2.41])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 583C5114E848;
	Thu, 15 Aug 2024 05:12:41 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Thu, 15 Aug 2024 05:12:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1723713161; x=1723799561; bh=jX9yp/VkT4
	lRnv0IDOV2dC1huardv/smssO30VI+W9A=; b=To5vw5HT4DPUT6EWLDDKzYycfA
	ZeaIxg4HLiVbSg8qrCDhs8uFSZX92pvZ34ZTgaWHV5KdUyjdq9pGQYykEvxuT/Tj
	XyLUOWery37OM0izGe+N60P4P8XGlX3AKV9EmDmf1M4Un/TgsDswPaSHIQn/jr98
	aghHmqox54tryh5rCGCbIGnpGxYaKph0JLsjIaXzzFw3UD8HFfJtGHCSPqa5gBFY
	goZpFWtskkff7YU5lhcP2EkL5yktpjn0HLRJ/EFuQrIylMm02AooTuEkn6Eb2p7M
	m7KWmr2BF52SOeo7oZN4/yY6P0b13UQL32tDJ494Ytsn5GEuLCHWwP/s/QVw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1723713161; x=1723799561; bh=jX9yp/VkT4lRnv0IDOV2dC1huard
	v/smssO30VI+W9A=; b=Zd8vzR6SZOMEs5lxBmI0vFrvf/IPmiaiIYDHaGdwAhMp
	MUsMSeiNWVIWokvnVSzfOkOXYKcalbObRQ0KjwLBQRCW7vCcLFzX16I6hsFLVKKh
	RQvapoQ4hoSZlx1ZIZRH88MKSbsXALk4mcwJpAxBprFKIytPlFYoE5IcHzT5A5MO
	no6vD37Q2A86RqE9/GnaoezofQxUD8i82kiFqDIzMhWiSkbqWQjSmSdqLiyZKW87
	bwZUuCiiyXRVZfhxu+aqoSHMqgMKEX7I1gkgTtMB48widNVWKk7uEYLtdgjOIfiZ
	cykgs5RahcfeCqeO9PuwUFlGzvE9RPA7aIzP15K12g==
X-ME-Sender: <xms:ica9ZjJ4p-4bm0vWnLpFU103r_l1pI2x0DG7Pu-1Oi1ZXTPPwE22Pg>
    <xme:ica9ZnI1WYUHObx3YE5J8Y4eOutpp_KBBWvGnHgmV8QYdtLT3dgzszajwKEr1Fb5y
    eiuqSnhNMgTB-OxoA>
X-ME-Received: <xmr:ica9ZruFeAUQC69YqFggAfYcGunNg_oajq-9S_LGUi93itdjrRhft-JVHb0dQj46M7BPtTp8JArGNLsz2hqXGZEdwNf8oLVU0v7_pnlLTE8drQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddruddtiedguddvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefgueeg
    udfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepgedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepphhhihhllhhiphdrfihoohguuddvfeesghhmrghilh
    drtghomhdprhgtphhtthhopehphhhilhhlihhprdifohhougesughunhgvlhhmrdhorhhg
    rdhukhdprhgtphhtthhopehjrghmvghssehjrghmvghslhhiuhdrihhopdhrtghpthhtoh
    epghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:ica9ZsZevlOGU3nUOjI26dMRRpjQdfSZQqsUjRu_pHylNyoo0Q9eoQ>
    <xmx:ica9ZqYCAAAXpaIG1GxOIET90EYpaN_q43nbEe_0euOkWR1sQTF57Q>
    <xmx:ica9ZgDhUOhvlUGqkjdvYybDJuAn1-RZ9j1PQolD4MKiBWFP47CeAA>
    <xmx:ica9ZoZeM3Me5NsK4RMGeRteyrIeu8l_YcQk6LcXLK9XO0CMMpfhAA>
    <xmx:ica9ZhX4o_lHV29MHMRb0dei21LJzlY-n98CHBflwsshi0Xvq2YTA2Hv>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 15 Aug 2024 05:12:40 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 1f739d0d (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 15 Aug 2024 09:12:15 +0000 (UTC)
Date: Thu, 15 Aug 2024 11:12:34 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Phillip Wood <phillip.wood123@gmail.com>, phillip.wood@dunelm.org.uk,
	James Liu <james@jamesliu.io>
Subject: [PATCH v2 3/7] builtin/gc: fix leaking config values
Message-ID: <310e361371efc156c3aaac94439bdbeaa965155f.1723712608.git.ps@pks.im>
References: <cover.1723533091.git.ps@pks.im>
 <cover.1723712608.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1723712608.git.ps@pks.im>

We're leaking config values in git-gc(1) when those values are tracked
as strings. Introduce a new `gc_config_release()` function that releases
this memory to plug those leaks and release old values before populating
the config fields via `git_config_string()` et al.

Note that there is one small gotcha here with the "--prune" option. Next
to passing a string, this option also accepts the "--no-prune" option
that overrides the default or configured value. We thus need to discern
between the option not having been passed by the user and the negative
variant of it. This is done by using a simple sentinel value that lets
us discern these cases.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/gc.c     | 108 +++++++++++++++++++++++++++++++++++------------
 t/t5304-prune.sh |   1 +
 2 files changed, 82 insertions(+), 27 deletions(-)

diff --git a/builtin/gc.c b/builtin/gc.c
index eee7401647..a93cfa147e 100644
--- a/builtin/gc.c
+++ b/builtin/gc.c
@@ -139,9 +139,9 @@ struct gc_config {
 	int gc_auto_threshold;
 	int gc_auto_pack_limit;
 	int detach_auto;
-	const char *gc_log_expire;
-	const char *prune_expire;
-	const char *prune_worktrees_expire;
+	char *gc_log_expire;
+	char *prune_expire;
+	char *prune_worktrees_expire;
 	char *repack_filter;
 	char *repack_filter_to;
 	unsigned long big_pack_threshold;
@@ -157,15 +157,25 @@ struct gc_config {
 	.gc_auto_threshold = 6700, \
 	.gc_auto_pack_limit = 50, \
 	.detach_auto = 1, \
-	.gc_log_expire = "1.day.ago", \
-	.prune_expire = "2.weeks.ago", \
-	.prune_worktrees_expire = "3.months.ago", \
+	.gc_log_expire = xstrdup("1.day.ago"), \
+	.prune_expire = xstrdup("2.weeks.ago"), \
+	.prune_worktrees_expire = xstrdup("3.months.ago"), \
 	.max_delta_cache_size = DEFAULT_DELTA_CACHE_SIZE, \
 }
 
+static void gc_config_release(struct gc_config *cfg)
+{
+	free(cfg->gc_log_expire);
+	free(cfg->prune_expire);
+	free(cfg->prune_worktrees_expire);
+	free(cfg->repack_filter);
+	free(cfg->repack_filter_to);
+}
+
 static void gc_config(struct gc_config *cfg)
 {
 	const char *value;
+	char *owned = NULL;
 
 	if (!git_config_get_value("gc.packrefs", &value)) {
 		if (value && !strcmp(value, "notbare"))
@@ -185,15 +195,34 @@ static void gc_config(struct gc_config *cfg)
 	git_config_get_bool("gc.autodetach", &cfg->detach_auto);
 	git_config_get_bool("gc.cruftpacks", &cfg->cruft_packs);
 	git_config_get_ulong("gc.maxcruftsize", &cfg->max_cruft_size);
-	git_config_get_expiry("gc.pruneexpire", (char **) &cfg->prune_expire);
-	git_config_get_expiry("gc.worktreepruneexpire", (char **) &cfg->prune_worktrees_expire);
-	git_config_get_expiry("gc.logexpiry", (char **) &cfg->gc_log_expire);
+
+	if (!git_config_get_expiry("gc.pruneexpire", &owned)) {
+		free(cfg->prune_expire);
+		cfg->prune_expire = owned;
+	}
+
+	if (!git_config_get_expiry("gc.worktreepruneexpire", &owned)) {
+		free(cfg->prune_worktrees_expire);
+		cfg->prune_worktrees_expire = owned;
+	}
+
+	if (!git_config_get_expiry("gc.logexpiry", &owned)) {
+		free(cfg->gc_log_expire);
+		cfg->gc_log_expire = owned;
+	}
 
 	git_config_get_ulong("gc.bigpackthreshold", &cfg->big_pack_threshold);
 	git_config_get_ulong("pack.deltacachesize", &cfg->max_delta_cache_size);
 
-	git_config_get_string("gc.repackfilter", &cfg->repack_filter);
-	git_config_get_string("gc.repackfilterto", &cfg->repack_filter_to);
+	if (!git_config_get_string("gc.repackfilter", &owned)) {
+		free(cfg->repack_filter);
+		cfg->repack_filter = owned;
+	}
+
+	if (!git_config_get_string("gc.repackfilterto", &owned)) {
+		free(cfg->repack_filter_to);
+		cfg->repack_filter_to = owned;
+	}
 
 	git_config(git_default_config, NULL);
 }
@@ -644,12 +673,15 @@ int cmd_gc(int argc, const char **argv, const char *prefix)
 	struct child_process rerere_cmd = CHILD_PROCESS_INIT;
 	struct maintenance_run_opts opts = {0};
 	struct gc_config cfg = GC_CONFIG_INIT;
+	const char *prune_expire_sentinel = "sentinel";
+	const char *prune_expire_arg = prune_expire_sentinel;
+	int ret;
 
 	struct option builtin_gc_options[] = {
 		OPT__QUIET(&quiet, N_("suppress progress reporting")),
-		{ OPTION_STRING, 0, "prune", &cfg.prune_expire, N_("date"),
+		{ OPTION_STRING, 0, "prune", &prune_expire_arg, N_("date"),
 			N_("prune unreferenced objects"),
-			PARSE_OPT_OPTARG, NULL, (intptr_t)cfg.prune_expire },
+			PARSE_OPT_OPTARG, NULL, (intptr_t)prune_expire_arg },
 		OPT_BOOL(0, "cruft", &cfg.cruft_packs, N_("pack unreferenced objects separately")),
 		OPT_MAGNITUDE(0, "max-cruft-size", &cfg.max_cruft_size,
 			      N_("with --cruft, limit the size of new cruft packs")),
@@ -673,8 +705,8 @@ int cmd_gc(int argc, const char **argv, const char *prefix)
 	strvec_pushl(&prune_worktrees, "worktree", "prune", "--expire", NULL);
 	strvec_pushl(&rerere, "rerere", "gc", NULL);
 
-	/* default expiry time, overwritten in gc_config */
 	gc_config(&cfg);
+
 	if (parse_expiry_date(cfg.gc_log_expire, &gc_log_expire_time))
 		die(_("failed to parse gc.logExpiry value %s"), cfg.gc_log_expire);
 
@@ -686,6 +718,10 @@ int cmd_gc(int argc, const char **argv, const char *prefix)
 	if (argc > 0)
 		usage_with_options(builtin_gc_usage, builtin_gc_options);
 
+	if (prune_expire_arg != prune_expire_sentinel) {
+		free(cfg.prune_expire);
+		cfg.prune_expire = xstrdup_or_null(prune_expire_arg);
+	}
 	if (cfg.prune_expire && parse_expiry_date(cfg.prune_expire, &dummy))
 		die(_("failed to parse prune expiry value %s"), cfg.prune_expire);
 
@@ -703,8 +739,11 @@ int cmd_gc(int argc, const char **argv, const char *prefix)
 		/*
 		 * Auto-gc should be least intrusive as possible.
 		 */
-		if (!need_to_gc(&cfg))
-			return 0;
+		if (!need_to_gc(&cfg)) {
+			ret = 0;
+			goto out;
+		}
+
 		if (!quiet) {
 			if (cfg.detach_auto)
 				fprintf(stderr, _("Auto packing the repository in background for optimum performance.\n"));
@@ -713,17 +752,22 @@ int cmd_gc(int argc, const char **argv, const char *prefix)
 			fprintf(stderr, _("See \"git help gc\" for manual housekeeping.\n"));
 		}
 		if (cfg.detach_auto) {
-			int ret = report_last_gc_error();
-
-			if (ret == 1)
+			ret = report_last_gc_error();
+			if (ret == 1) {
 				/* Last gc --auto failed. Skip this one. */
-				return 0;
-			else if (ret)
+				ret = 0;
+				goto out;
+
+			} else if (ret) {
 				/* an I/O error occurred, already reported */
-				return ret;
+				goto out;
+			}
+
+			if (lock_repo_for_gc(force, &pid)) {
+				ret = 0;
+				goto out;
+			}
 
-			if (lock_repo_for_gc(force, &pid))
-				return 0;
 			gc_before_repack(&opts, &cfg); /* dies on failure */
 			delete_tempfile(&pidfile);
 
@@ -749,8 +793,11 @@ int cmd_gc(int argc, const char **argv, const char *prefix)
 
 	name = lock_repo_for_gc(force, &pid);
 	if (name) {
-		if (opts.auto_flag)
-			return 0; /* be quiet on --auto */
+		if (opts.auto_flag) {
+			ret = 0;
+			goto out; /* be quiet on --auto */
+		}
+
 		die(_("gc is already running on machine '%s' pid %"PRIuMAX" (use --force if not)"),
 		    name, (uintmax_t)pid);
 	}
@@ -826,6 +873,8 @@ int cmd_gc(int argc, const char **argv, const char *prefix)
 	if (!daemonized)
 		unlink(git_path("gc.log"));
 
+out:
+	gc_config_release(&cfg);
 	return 0;
 }
 
@@ -1511,6 +1560,8 @@ static int maintenance_run(int argc, const char **argv, const char *prefix)
 			PARSE_OPT_NONEG, task_option_parse),
 		OPT_END()
 	};
+	int ret;
+
 	memset(&opts, 0, sizeof(opts));
 
 	opts.quiet = !isatty(2);
@@ -1532,7 +1583,10 @@ static int maintenance_run(int argc, const char **argv, const char *prefix)
 	if (argc != 0)
 		usage_with_options(builtin_maintenance_run_usage,
 				   builtin_maintenance_run_options);
-	return maintenance_run_tasks(&opts, &cfg);
+
+	ret = maintenance_run_tasks(&opts, &cfg);
+	gc_config_release(&cfg);
+	return ret;
 }
 
 static char *get_maintpath(void)
diff --git a/t/t5304-prune.sh b/t/t5304-prune.sh
index 1f1f664871..e641df0116 100755
--- a/t/t5304-prune.sh
+++ b/t/t5304-prune.sh
@@ -7,6 +7,7 @@ test_description='prune'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 day=$((60*60*24))
-- 
2.46.0.46.g406f326d27.dirty

