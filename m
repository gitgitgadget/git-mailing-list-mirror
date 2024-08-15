Received: from fhigh4-smtp.messagingengine.com (fhigh4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99F321714D3
	for <git@vger.kernel.org>; Thu, 15 Aug 2024 11:22:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723720927; cv=none; b=BL7qW3KnkkyfEdeiP+Yy9FHskKCNNFvpp3UWuLdkuCBjVwrH5BJEM9sWDEj6HPnEr9uY4r8vOKwGw0VJISB7vtT5t7KuSttZj1RY44o7ui0k5kQvfusxjuVZbD8vdxIWXO+k5yeI8vJ2ldM2XZ3r4JmgDtq2Ak5nFgCVQY4T8cs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723720927; c=relaxed/simple;
	bh=WPAAluaiQj7YEJUW1cNHXbKHSd1fuz/VNoT+JWyIXMA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=f6nIQ54suVLGrJ57MLNQW1WAvdB9im+de6zryNVhBpZRXEdjc2q0k//8fUOAAl9LjN97Xzb6nlBHBuXK9M6/6OQh2V7BtB+z+JqBIMDkgnOMJHMl/GFAJRIbSFt0WVJGNPhcciWzhb6HRaEVCxAa73fu7tWjejvQk3NZkk4bJD4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=XsWr/zHI; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Gvtg8vFY; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="XsWr/zHI";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Gvtg8vFY"
Received: from phl-compute-06.internal (phl-compute-06.nyi.internal [10.202.2.46])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 0EA7B114E9FC;
	Thu, 15 Aug 2024 05:12:46 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Thu, 15 Aug 2024 05:12:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1723713166; x=1723799566; bh=ilepCAlZep
	xCFjxzgNOOiaeY5PvWNUb0+Nn5ApcbBIg=; b=XsWr/zHIisWI0cW7p25jR+m4xe
	smb9gFe/NqJ3VS4fKvuEseQzb83SRsAEhYBtOI6u2GU9/doMUIIvYuqA7hBKz9yZ
	7MT0D657CkIl6byze2WsXTaTiiliO9NCuVhFKYZF7btgCTiE0675EWtFKBQX4c+n
	TTEd6OYpncw6wu7ZcX49n7VeD2zuR0GztyWnGgFgcNR3xmSliMJDU4vi4r+xVxaH
	xrOimipt2HxxNlCF/SOn+8uMabvdUXsQqdfbFc6zgC3ps8vRfydfhmfPGSbJzfm1
	sgJwNl8NPB4oNh/vLr5jkpcDncdahmsFCtrpkaYxA4SEE/A41N6QBkCxaNNg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1723713166; x=1723799566; bh=ilepCAlZepxCFjxzgNOOiaeY5PvW
	NUb0+Nn5ApcbBIg=; b=Gvtg8vFYdIudSAjys6mYb9ZgKCjirN2L/jW41zhvGDdS
	9ZVj0IgqNr4nOyBkqOWxSyjthqM9OFsZ/TPIYvLxI8J6sgZk32yyTV2Z+zuMh9AY
	38wxzn89d6oOFfYvVX/lFv+6FUIQ5HBH9eTxzsQTMUg89YTCNsOLK/Sb/4SA347z
	4/9ZOKOSBraPJcwKIt4Xs4TSDx1mLsSYkWkPQzxdR9Vl6/L/OUNw/V2oYIijcqaO
	RWXbrPYkHEGan7NpM04QnAPFYLU+mQ9CFqrwcCjjNtoRsr8jDhuF8Q8EbFiAWXjW
	TCdoTc6v21ZlMorzyGF6nt8El2pcBSqqD+pKyQrB7g==
X-ME-Sender: <xms:jca9ZvNOFvagRHFh8C9G6QvBPkxmWN6cLRCU5jIH4WdEBefZmCOmaA>
    <xme:jca9Zp8LaJw7L-MClvli2Kps9j3swUD2usp50H7EqOXDcFReIJ68Djx_0crMe4uHR
    HiHDP0VXznbIwYrrA>
X-ME-Received: <xmr:jca9ZuQksqLum1S7a6P0qpTWmBmU3rI7iCzVwDfJ4MQSv9iW6L4xoS23mgmGyz8Zv7zYT-rZedOicpdk7G_IjGE8T35a2uQNCH8yP2hplCy9SA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddruddtiedguddvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefgueeg
    udfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgepudenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepgedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepphhhihhllhhiphdrfihoohguuddvfeesghhmrghilh
    drtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghp
    thhtohepjhgrmhgvshesjhgrmhgvshhlihhurdhiohdprhgtphhtthhopehphhhilhhlih
    hprdifohhougesughunhgvlhhmrdhorhhgrdhukh
X-ME-Proxy: <xmx:jca9Zjv5EVIXcYArGDa46NzMqg9is1jhAb-f-sKQxacho2DxjBp05A>
    <xmx:jca9ZnfkOUDRm4k551fcFq1UGpGsb9UrmSywAfYYr5cz4yWujoZXMA>
    <xmx:jca9Zv3Mg6yKrWBfz-ea0Ikj4HruG5dTxYEwULQ73IozrX-ei4sYgw>
    <xmx:jca9Zj8nI7BsDWevo7KoesoIboJQRY-cDneJZg7aZJU9fZMWLHHcRw>
    <xmx:jsa9Zu6-9KtWoYpMu_CHr9aZqckGD-WynvFS1FWl0OViDRYa4XXX8W1m>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 15 Aug 2024 05:12:44 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id afcd4eae (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 15 Aug 2024 09:12:23 +0000 (UTC)
Date: Thu, 15 Aug 2024 11:12:43 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Phillip Wood <phillip.wood123@gmail.com>, phillip.wood@dunelm.org.uk,
	James Liu <james@jamesliu.io>
Subject: [PATCH v2 5/7] builtin/gc: add a `--detach` flag
Message-ID: <ca78d3dc7c0270b434ee4ca4ef618212c7dc1d5b.1723712608.git.ps@pks.im>
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

When running `git gc --auto`, the command will by default detach and
continue running in the background. This behaviour can be tweaked via
the `gc.autoDetach` config, but not via a command line switch. We need
that in a subsequent commit though, where git-maintenance(1) will want
to ask its git-gc(1) child process to not detach anymore.

Add a `--[no-]detach` flag that does this for us.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 Documentation/git-gc.txt |  5 ++-
 builtin/gc.c             | 70 ++++++++++++++++++++++------------------
 t/t6500-gc.sh            | 39 ++++++++++++++++++++++
 3 files changed, 82 insertions(+), 32 deletions(-)

diff --git a/Documentation/git-gc.txt b/Documentation/git-gc.txt
index b5561c458a..370e22faae 100644
--- a/Documentation/git-gc.txt
+++ b/Documentation/git-gc.txt
@@ -9,7 +9,7 @@ git-gc - Cleanup unnecessary files and optimize the local repository
 SYNOPSIS
 --------
 [verse]
-'git gc' [--aggressive] [--auto] [--quiet] [--prune=<date> | --no-prune] [--force] [--keep-largest-pack]
+'git gc' [--aggressive] [--auto] [--[no-]detach] [--quiet] [--prune=<date> | --no-prune] [--force] [--keep-largest-pack]
 
 DESCRIPTION
 -----------
@@ -53,6 +53,9 @@ configuration options such as `gc.auto` and `gc.autoPackLimit`, all
 other housekeeping tasks (e.g. rerere, working trees, reflog...) will
 be performed as well.
 
+--[no-]detach::
+	Run in the background if the system supports it. This option overrides
+	the `gc.autoDetach` config.
 
 --[no-]cruft::
 	When expiring unreachable objects, pack them separately into a
diff --git a/builtin/gc.c b/builtin/gc.c
index f815557081..269a77960f 100644
--- a/builtin/gc.c
+++ b/builtin/gc.c
@@ -242,9 +242,13 @@ static enum schedule_priority parse_schedule(const char *value)
 
 struct maintenance_run_opts {
 	int auto_flag;
+	int detach;
 	int quiet;
 	enum schedule_priority schedule;
 };
+#define MAINTENANCE_RUN_OPTS_INIT { \
+	.detach = -1, \
+}
 
 static int pack_refs_condition(UNUSED struct gc_config *cfg)
 {
@@ -664,7 +668,7 @@ int cmd_gc(int argc, const char **argv, const char *prefix)
 	int keep_largest_pack = -1;
 	timestamp_t dummy;
 	struct child_process rerere_cmd = CHILD_PROCESS_INIT;
-	struct maintenance_run_opts opts = {0};
+	struct maintenance_run_opts opts = MAINTENANCE_RUN_OPTS_INIT;
 	struct gc_config cfg = GC_CONFIG_INIT;
 	const char *prune_expire_sentinel = "sentinel";
 	const char *prune_expire_arg = prune_expire_sentinel;
@@ -681,6 +685,8 @@ int cmd_gc(int argc, const char **argv, const char *prefix)
 		OPT_BOOL(0, "aggressive", &aggressive, N_("be more thorough (increased runtime)")),
 		OPT_BOOL_F(0, "auto", &opts.auto_flag, N_("enable auto-gc mode"),
 			   PARSE_OPT_NOCOMPLETE),
+		OPT_BOOL(0, "detach", &opts.detach,
+			 N_("perform garbage collection in the background")),
 		OPT_BOOL_F(0, "force", &force,
 			   N_("force running gc even if there may be another gc running"),
 			   PARSE_OPT_NOCOMPLETE),
@@ -729,6 +735,9 @@ int cmd_gc(int argc, const char **argv, const char *prefix)
 		strvec_push(&repack, "-q");
 
 	if (opts.auto_flag) {
+		if (cfg.detach_auto && opts.detach < 0)
+			opts.detach = 1;
+
 		/*
 		 * Auto-gc should be least intrusive as possible.
 		 */
@@ -738,38 +747,12 @@ int cmd_gc(int argc, const char **argv, const char *prefix)
 		}
 
 		if (!quiet) {
-			if (cfg.detach_auto)
+			if (opts.detach > 0)
 				fprintf(stderr, _("Auto packing the repository in background for optimum performance.\n"));
 			else
 				fprintf(stderr, _("Auto packing the repository for optimum performance.\n"));
 			fprintf(stderr, _("See \"git help gc\" for manual housekeeping.\n"));
 		}
-		if (cfg.detach_auto) {
-			ret = report_last_gc_error();
-			if (ret == 1) {
-				/* Last gc --auto failed. Skip this one. */
-				ret = 0;
-				goto out;
-
-			} else if (ret) {
-				/* an I/O error occurred, already reported */
-				goto out;
-			}
-
-			if (lock_repo_for_gc(force, &pid)) {
-				ret = 0;
-				goto out;
-			}
-
-			gc_before_repack(&opts, &cfg); /* dies on failure */
-			delete_tempfile(&pidfile);
-
-			/*
-			 * failure to daemonize is ok, we'll continue
-			 * in foreground
-			 */
-			daemonized = !daemonize();
-		}
 	} else {
 		struct string_list keep_pack = STRING_LIST_INIT_NODUP;
 
@@ -784,6 +767,33 @@ int cmd_gc(int argc, const char **argv, const char *prefix)
 		string_list_clear(&keep_pack, 0);
 	}
 
+	if (opts.detach > 0) {
+		ret = report_last_gc_error();
+		if (ret == 1) {
+			/* Last gc --auto failed. Skip this one. */
+			ret = 0;
+			goto out;
+
+		} else if (ret) {
+			/* an I/O error occurred, already reported */
+			goto out;
+		}
+
+		if (lock_repo_for_gc(force, &pid)) {
+			ret = 0;
+			goto out;
+		}
+
+		gc_before_repack(&opts, &cfg); /* dies on failure */
+		delete_tempfile(&pidfile);
+
+		/*
+		 * failure to daemonize is ok, we'll continue
+		 * in foreground
+		 */
+		daemonized = !daemonize();
+	}
+
 	name = lock_repo_for_gc(force, &pid);
 	if (name) {
 		if (opts.auto_flag) {
@@ -1537,7 +1547,7 @@ static int task_option_parse(const struct option *opt UNUSED,
 static int maintenance_run(int argc, const char **argv, const char *prefix)
 {
 	int i;
-	struct maintenance_run_opts opts;
+	struct maintenance_run_opts opts = MAINTENANCE_RUN_OPTS_INIT;
 	struct gc_config cfg = GC_CONFIG_INIT;
 	struct option builtin_maintenance_run_options[] = {
 		OPT_BOOL(0, "auto", &opts.auto_flag,
@@ -1554,8 +1564,6 @@ static int maintenance_run(int argc, const char **argv, const char *prefix)
 	};
 	int ret;
 
-	memset(&opts, 0, sizeof(opts));
-
 	opts.quiet = !isatty(2);
 
 	for (i = 0; i < TASK__COUNT; i++)
diff --git a/t/t6500-gc.sh b/t/t6500-gc.sh
index 1b5909d1b7..737c99e0f8 100755
--- a/t/t6500-gc.sh
+++ b/t/t6500-gc.sh
@@ -396,6 +396,45 @@ test_expect_success 'background auto gc respects lock for all operations' '
 	test_cmp expect actual
 '
 
+test_expect_success '--detach overrides gc.autoDetach=false' '
+	test_when_finished "rm -rf repo" &&
+	git init repo &&
+	(
+		cd repo &&
+
+		# Prepare the repository such that git-gc(1) ends up repacking.
+		test_commit "$(test_oid blob17_1)" &&
+		test_commit "$(test_oid blob17_2)" &&
+		git config gc.autodetach false &&
+		git config gc.auto 2 &&
+
+		cat >expect <<-EOF &&
+		Auto packing the repository in background for optimum performance.
+		See "git help gc" for manual housekeeping.
+		EOF
+		GIT_PROGRESS_DELAY=0 git gc --auto --detach 2>actual &&
+		test_cmp expect actual
+	)
+'
+
+test_expect_success '--no-detach overrides gc.autoDetach=true' '
+	test_when_finished "rm -rf repo" &&
+	git init repo &&
+	(
+		cd repo &&
+
+		# Prepare the repository such that git-gc(1) ends up repacking.
+		test_commit "$(test_oid blob17_1)" &&
+		test_commit "$(test_oid blob17_2)" &&
+		git config gc.autodetach true &&
+		git config gc.auto 2 &&
+
+		GIT_PROGRESS_DELAY=0 git gc --auto --no-detach 2>output &&
+		test_grep "Auto packing the repository for optimum performance." output &&
+		test_grep "Collecting referenced commits: 2, done." output
+	)
+'
+
 # DO NOT leave a detached auto gc process running near the end of the
 # test script: it can run long enough in the background to racily
 # interfere with the cleanup in 'test_done'.
-- 
2.46.0.46.g406f326d27.dirty

