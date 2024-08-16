Received: from fout8-smtp.messagingengine.com (fout8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33E681922D6
	for <git@vger.kernel.org>; Fri, 16 Aug 2024 10:45:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723805117; cv=none; b=ArGvYUOH7LD4qhbO4hL+Bnvo64tI7Ph3yyH0wjaUBJK/HxFTlu2mfvGXfmRuWakJgua9mqm5B5WT/k6srkQdi3h8sDMI2O+Lw1FGMqHRElYbHhpQJptbhS/2VxQuwJ0/13CUcmMQ7CjpZrk4B5edl2qtnvPmrHxQb8k/s/vUVx0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723805117; c=relaxed/simple;
	bh=xl2Q4Xzqx/ofjO32pNNvVUe73vXl2KDIYZa91QhQJv0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QlRCkDG6ikWN3bRZXN3/3UHiV+BDIqp6Ee9uOYKdiRPpX8mWnm68wDYl6XmqbJdD8k8bpqEuoxXs2PYiYXztcq+nKmNvWqKMEMcj4RmH1xCc8WNs14hWt1UcftiUGgCtTNWxT35L4GySWgjH2wMtALPM/a0dEO6C7iPsHpjA49E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=bAu+oYoM; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=fHeVtQS3; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="bAu+oYoM";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="fHeVtQS3"
Received: from phl-compute-03.internal (phl-compute-03.nyi.internal [10.202.2.43])
	by mailfout.nyi.internal (Postfix) with ESMTP id 46B0C138FF9D;
	Fri, 16 Aug 2024 06:45:15 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Fri, 16 Aug 2024 06:45:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1723805115; x=1723891515; bh=R9MhfufrW3
	MyBfp8JOpMiCQ1QiXUwzbYdOupl+IX0LA=; b=bAu+oYoM7asiAMs77dT2KVsxie
	WoPSE67UPlX0i0+buDgUZ5UgHU+p9fq+0k/Il+H5asowMFQGLCsoWB9VafEqiQLi
	Z6bIKr/C+eJmJZzRQskEy5vUdlDV2+Wx5PC4WbH7ORKf/U6p5yDubXphHZGZN4Tl
	lMNGgoMXfV7dyd1Jug+AYAoAtsiXFDqj/BLNA4j7kh/m9/1FzdkiOmyh+mY8uxwY
	BGrzDpnCCq1ImZ1qDdGqz+cleZPMKeU8aGO808mWTvI+HnonDNJv0RZGqWRUE+t7
	3zUQtcLmSbz/Irm5nyAy7mFxaMIzcxt+D6Z4sWPWeeU/64l42jAe6I4mTzZA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1723805115; x=1723891515; bh=R9MhfufrW3MyBfp8JOpMiCQ1QiXU
	wzbYdOupl+IX0LA=; b=fHeVtQS30Q7hkAt+HD8caJMRvZpvdCOmPIZEKuUP/AL2
	lIfc4g06sZTIVB0KI0k+hQi88Ug/Cy2TZ8T7htAUBc6hYDySL7neh4nTt10RMCpd
	ZTIwEzYSqDCLQWPIP813Z2rl8ml3E4o3cCJm3KYgXlFkoIJIgXcaZcfTyJeI3RTw
	jW7puuI8Oa+c4gtfydWUDV0GJXLtvoZT+4Ww+8M2GB6eh9CI3c3w/OWPsy6qUjSW
	WBZMC0uZDbyIrcIA9nSl9XDv2eMjtUlGha3B9x1s8sYANDrl6O4UL9fS4njzrKrp
	Y/ZeGuaKlE91eDnRxNhOmlJt5nGvY3ncG9upkZzmyw==
X-ME-Sender: <xms:uy2_Zt6EzMis6xj4yucYxuBSb3S_on9LrgXcvbPkAsstZozvkAv2wg>
    <xme:uy2_Zq4iEoeRqVIUxNrqUuutHeVhYEPzathjoXjL-YpQue0KMIsRnYMEVTZbvpAY4
    f3luQ5Ks0gOluIYSA>
X-ME-Received: <xmr:uy2_ZkdwqaGolHNZU-tpX8Sxv9YeZlEJthY5-_GBg8lnkV18b19baC9UIK6Y8ZoZrakcKSnqP608AlJxBCtMMBrHKRkvvdiAVSQlaX4BwEIICWc>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddruddtkedgfedtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefgueeg
    udfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgepudenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepiedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepjhgrmhgvshesjhgrmhgvshhlihhurdhiohdprhgtph
    htthhopehsthholhgvvgesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgv
    rhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepphhhihhllhhiphdrfihoohguuddvfe
    esghhmrghilhdrtghomhdprhgtphhtthhopehphhhilhhlihhprdifohhougesughunhgv
    lhhmrdhorhhgrdhukhdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:uy2_ZmIEXGiocJfmAXbAib2QJZ45hK8e4P7xKl0pg6efRNO4D-CGtg>
    <xmx:uy2_ZhKuuV0n69U3cbeRFq4eqn88vfj6CRMT2kNzOhynMSAN8HH_jQ>
    <xmx:uy2_Zvzl8U_ORxB1W27IozkkP2NeREKCyrAGJniOTGXFPY_buUDXbA>
    <xmx:uy2_ZtLljF2nQhDakc12jmDExsHXAuusB0yvWnCYIVeoN446nCHGPA>
    <xmx:uy2_Zp_d_LTVHgos8adJQ48cMkIGyzDCyRnHqwuds58DtrgGzn6NJaSy>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 16 Aug 2024 06:45:13 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 47a5c405 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 16 Aug 2024 10:44:50 +0000 (UTC)
Date: Fri, 16 Aug 2024 12:45:11 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Phillip Wood <phillip.wood123@gmail.com>, phillip.wood@dunelm.org.uk,
	James Liu <james@jamesliu.io>, Derrick Stolee <stolee@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v3 5/7] builtin/gc: add a `--detach` flag
Message-ID: <b934b238897c55595de4735dcfec5425b6ab22af.1723804990.git.ps@pks.im>
References: <cover.1723533091.git.ps@pks.im>
 <cover.1723804990.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1723804990.git.ps@pks.im>

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
 t/t6500-gc.sh            | 45 +++++++++++++++++++++++---
 3 files changed, 84 insertions(+), 36 deletions(-)

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
index 1b5909d1b7..5378455968 100755
--- a/t/t6500-gc.sh
+++ b/t/t6500-gc.sh
@@ -338,14 +338,14 @@ test_expect_success 'gc.maxCruftSize sets appropriate repack options' '
 	test_subcommand $cruft_max_size_opts --max-cruft-size=3145728 <trace2.txt
 '
 
-run_and_wait_for_auto_gc () {
+run_and_wait_for_gc () {
 	# We read stdout from gc for the side effect of waiting until the
 	# background gc process exits, closing its fd 9.  Furthermore, the
 	# variable assignment from a command substitution preserves the
 	# exit status of the main gc process.
 	# Note: this fd trickery doesn't work on Windows, but there is no
 	# need to, because on Win the auto gc always runs in the foreground.
-	doesnt_matter=$(git gc --auto 9>&1)
+	doesnt_matter=$(git gc "$@" 9>&1)
 }
 
 test_expect_success 'background auto gc does not run if gc.log is present and recent but does if it is old' '
@@ -361,7 +361,7 @@ test_expect_success 'background auto gc does not run if gc.log is present and re
 	test-tool chmtime =-345600 .git/gc.log &&
 	git gc --auto &&
 	test_config gc.logexpiry 2.days &&
-	run_and_wait_for_auto_gc &&
+	run_and_wait_for_gc --auto &&
 	ls .git/objects/pack/pack-*.pack >packs &&
 	test_line_count = 1 packs
 '
@@ -391,11 +391,48 @@ test_expect_success 'background auto gc respects lock for all operations' '
 	printf "%d %s" "$shell_pid" "$hostname" >.git/gc.pid &&
 
 	# our gc should exit zero without doing anything
-	run_and_wait_for_auto_gc &&
+	run_and_wait_for_gc --auto &&
 	(ls -1 .git/refs/heads .git/reftable >actual || true) &&
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
+		# Note that we cannot use `test_cmp` here to compare stderr
+		# because it may contain output from `set -x`.
+		run_and_wait_for_gc --auto --detach 2>actual &&
+		test_grep "Auto packing the repository in background for optimum performance." actual
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

