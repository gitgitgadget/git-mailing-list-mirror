Received: from fhigh4-smtp.messagingengine.com (fhigh4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D32456446
	for <git@vger.kernel.org>; Tue, 13 Aug 2024 07:17:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723533471; cv=none; b=SIQi8U3JYdk9mjI8i9hkdeSQg2ent3+nLReu/+blep7cz/Asmaadogez5gfp5hXhxfXeoGKsvmK14jbARxRcSf0U1a9X+Uoz6EX2TUPpCfOk4KtA040wElhK1QVCuW9xR1pZKmuA3+ch6AGHqKfGcZiU5frkfgzX/LBDNOdCCro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723533471; c=relaxed/simple;
	bh=4Wzv36psV92fF6A3OxDi5LlfStXVgt9cTn++ujBmkMQ=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fDM1HedYBORfF1CZC0NiNA/lDTsrUL4GfSRbH/5o8ljO3rbVx4tsOEo0rrB0QJ3COb3f4btSbWE02QDRBGlp5hQYTprqaOVlYTCICcSaPZqgDTc1du9o37dEDAQupIPYHWU3hK8pOUIf1H7iDgepEnPI6mwgvyxpCCazC2YQoig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Jm1IYRmO; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=vFWYMZ33; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Jm1IYRmO";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="vFWYMZ33"
Received: from phl-compute-03.internal (phl-compute-03.nyi.internal [10.202.2.43])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 6E84E114A9AE
	for <git@vger.kernel.org>; Tue, 13 Aug 2024 03:17:48 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Tue, 13 Aug 2024 03:17:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1723533468; x=1723619868; bh=jX9yp/VkT4
	lRnv0IDOV2dC1huardv/smssO30VI+W9A=; b=Jm1IYRmOzx8pPgOpBXZv5yXZ2r
	8dEFnqon2dbgV+LxUfiI/U0kzsLVuAp4OfMr1o6fUT0LBZ2ifpib9K9rixbBdlat
	zPLpvJszKZ3x/wnfiFdQDJLzaqZksHf86Uf1A2FSYf7MSnBZOXL71zG3hvjV8xOI
	2XIPIsicZ/jIlXdgvLagECfyL+oR8XTAp2UYCdhw2o+E4HXoMqShRQWOHZYq2XQ0
	klRkdjxWNooM5S9YFr19UeLKr5fZWlJluJ9jOM6y4JFIo0oXRWduAs0WtdK/X2+4
	h7xbXw7ps2WuigCVxm70kJ63JRwNRWtsU1vCcLIS2S3B/0qPKWRpvMP+vmOw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1723533468; x=1723619868; bh=jX9yp/VkT4lRnv0IDOV2dC1huard
	v/smssO30VI+W9A=; b=vFWYMZ33X0sH7jqnQNbZY2ZGQ4dhbn/IraiFh3rBe8A6
	sd/Q5QkZ6eWf2Xz5ONKCK/1+Yt8G5XsI1iG/vgP6Jl0yVGrDOERiZ3DZDncodV0f
	qr0oFP9JdlXiVRz5wR24CboMuORX6EUwT4xwOrd72F6T4ow63TPLQYD8c9xD2Ai/
	tJKDJy/goWXCmlxWL/IZs46rT68Uticv5xjs95SzwH6pY0DaXmO/mSLCp1HYuRZU
	ESuMxbnVJztK9wNkD095jbnIWY2vfpho1HIg1FbOtfwm4MFeOSb8+trQthSRro2i
	Pp1u4U5UnRHV2tbrz1clC13KaLTqeD8K+RF9GLrmxA==
X-ME-Sender: <xms:nAi7ZpmdOcx3d_cIgwOZaIBpdxQWs_-C2T8qXxzTa-_OYv_6O9lDrw>
    <xme:nAi7Zk2sIffKtUltmKDvFx5c_ffevbGEvI6Lsq8XK41QOml1faHi6rk8PT4GLeeWp
    -S7gyCLJscachIq1w>
X-ME-Received: <xmr:nAi7Zvrifw5O1Al8Umst-0zg-R1r6i4dalFiJYnvu5_H89uCxdxOfnFAw-mMzLMSgqXMp7MclWCj5MMfTG9nhtxbABlMK6dxxN1MyJI5zy3CrQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddruddtuddguddulecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecunecujfgurhepfffhvf
    fukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhn
    hhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpeehkeeffeegge
    dvgedvfeefheettddtffejuefflefggfehfeelffeljedvfeehieenucevlhhushhtvghr
    ufhiiigvpedunecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsg
    gprhgtphhtthhopedupdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehgihhtsehv
    ghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:nAi7Zpmsu2G0WC43ToaeroPQEsvUZggqJkK4mMTmbDZr0euuLb1l7g>
    <xmx:nAi7Zn23SUHIQHbpgLp11CCLAsJU1QEQs3Zm7uH-7vZ7Hqfb5VvM-g>
    <xmx:nAi7ZosKYBU3QZ3UtULR38-qFUQXifWDFb_9wGTwUt0ov3MM7PlEBg>
    <xmx:nAi7ZrXwHhh_C7pseRP7fX0rVot_b8NcQE8y5BlPWbZW4N-znhLYgg>
    <xmx:nAi7Zg9S2D3CAM2Byy4zkc6sfJdXcGXnQ5zsaKHPif1UL4lcVwPtXzRb>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Tue, 13 Aug 2024 03:17:47 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 8ce95d3b (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Tue, 13 Aug 2024 07:17:31 +0000 (UTC)
Date: Tue, 13 Aug 2024 09:17:46 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Subject: [PATCH 3/7] builtin/gc: fix leaking config values
Message-ID: <310e361371efc156c3aaac94439bdbeaa965155f.1723533091.git.ps@pks.im>
References: <cover.1723533091.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1723533091.git.ps@pks.im>

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

