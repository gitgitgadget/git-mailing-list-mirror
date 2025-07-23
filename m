Received: from fhigh-a4-smtp.messagingengine.com (fhigh-a4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8BD72F547D
	for <git@vger.kernel.org>; Wed, 23 Jul 2025 14:08:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753279741; cv=none; b=pEns6+dGyOckViP8ZuylsGQVYQdMFAUNzT7h6WMpvkBy7brfJp9/j+t3snytcXuzEyb8QCTEIKAovsqQ/XAnPB9hpaoxC3kefAsqiCMWbxbwnph40c3CvHBOnjbJnTySc/eSEhiaSlYAMNbSgOvoEmTgvTNIuH7mIWn0Qhr2KhY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753279741; c=relaxed/simple;
	bh=50ruMDmJucVGCw+fzB1/QDAeiLMLgCdEj0fg8VyFmQk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=egDX8SaaQJUohRcmlATskYaHdLSWD1XvNixfJT5RrTgItZ0Ew2HUGsmuaOBHu5BAm+pxSXlEUKSy5Fic6+lIYGnr0KPFNdpnDUFe0n48hkg5anf+TV/psCZvqaA+JwKhjjrA/Iuyr1dr5gopw4KQCmRS1kf1OcRzS0mXUpRCR8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=m9lWvLlV; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=C5H1QWyN; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="m9lWvLlV";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="C5H1QWyN"
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id C30171401EBD;
	Wed, 23 Jul 2025 10:08:58 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Wed, 23 Jul 2025 10:08:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1753279738;
	 x=1753366138; bh=PVqPTS2YxgyWy7b6rIbapnMvr9Nd50aoCGbvQBypIrU=; b=
	m9lWvLlVL1Vclh7Nlth9VAU1TA5LBNJzR4b7nL51mBN/wfLy2vXUg9+Z+z8eZX/M
	A0I9jDiI97i2opPWqwM3NwbCNwIjJ5kL2QLqE67eL1z5l5p9uEsX0JxboHBgBzMi
	R+/htuFvXz6hpPV8QcCOD7voUbx1rncp+j9xPRXOC/q7ChLTsJaYc4Tfay/tLv7g
	ceOZhWedNNEevx/TjX3MCtxm9PaHsh5T0H5ZUaSacThO1vm3GhRf+Cm+ZQQ/PQIT
	Yqv/dORIRf3v0I4PQ9GUEYYr42SrLF059NhMH8Uqmz1Q73WOLKmwq/wZT87yV83h
	FLUgPE7H4A9kXNuvbyLZ9g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1753279738; x=
	1753366138; bh=PVqPTS2YxgyWy7b6rIbapnMvr9Nd50aoCGbvQBypIrU=; b=C
	5H1QWyNKxclPg8spIY9RtSbGW2zCeWIWr1dQ5WR+Uji+3WizwxfTFjpDxzZGv1bt
	p1HuVLCaAvQu3UZaPKvfVhv+DOyj96amEBXJV57byp29fJzQdg/WO4OVdS0JVoqD
	tFD7Fw9b7YiUF6YPCWFrmslcqB1IhQJ+mVAAGzqURtGZ92yKKsxEeQ3o7Ewaf/bN
	fZPO5AcRM6nr9hDYg00d0ugHuCA2mkh/1dNW1drjkpiCZytXxFLc4io4PPbR/uJV
	1uxS8NnlsBaYFzvljaUEYFbgeY/+fFPLl2HQFFoK6Q0rNaWq0MKXZ3x1Lm1w3MYv
	EHVJ30J2jJqjHnoaw+ALw==
X-ME-Sender: <xms:-uyAaEwmMW5fQJRvIQfVf6Jxf3houhnMZwJlRCti0lv1rFb-_EmZ2A>
    <xme:-uyAaIeMrn2a8g8N5UIRDyp1g4A1L5_NgOaehGX9_bI9U2tDgS1ExjjpzNDmnnT3M
    nrXlrdmpd6ljlrp6w>
X-ME-Received: <xmr:-uyAaIJo4RtC1xCFdObiHd3fFZgFmQc9Q9c87MpXHScUliMxl5oFqASDc5ciYWBB6Z6u4LQWvnAAgwrD_ZUEZyWDHtU1CsHfyAvH4hF3_83b>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdejjeeljecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhfffugggtgffkfhgjvfevofesthejredtredtjeenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epgfeuffdvteduvdejfeeltdehgfffjeeftdffjeffkeegueffieehuedvieevfeetnecu
    ffhomhgrihhnpehinhgtrhgvmhgvnhhtrghlqdhrvghprggtkhdrrghuthhopdhrvghflh
    hoghdqvgigphhirhgvrdgruhhtohdpfihorhhkthhrvggvqdhprhhunhgvrdgruhhtohdp
    rhgvrhgvrhgvqdhgtgdrrghuthhopdgtohhmmhhithdqghhrrghphhdrrghuthhopdhloh
    hoshgvqdhosghjvggtthhsrdgruhhtohenucevlhhushhtvghrufhiiigvpedtnecurfgr
    rhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopedvpd
    hmohguvgepshhmthhpohhuthdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghl
    rdhorhhgpdhrtghpthhtohepphhhihhllhhiphdrfihoohguuddvfeesghhmrghilhdrtg
    homh
X-ME-Proxy: <xmx:-uyAaBHJfGCjr-uZ_RUeZnUS5HELEdPR7EKhuMzS2adl4c5csqyg6A>
    <xmx:-uyAaKrNCumF4GfWLAq-tuYQgwLc20TMfpEQzSRnq2EarRbpmzdJfg>
    <xmx:-uyAaCQArc6XYCQPMsoSlvVhAMjZEZ2TocNPpendeLRjBGqeSgHT_g>
    <xmx:-uyAaPNey3gqr8tMc51QeCVnLmY13Je6iQ0XUGKZ_20rCmNGn_OO7Q>
    <xmx:-uyAaOA37lkNnirrFAemxYcSOMHOHaKqSqMPBkNJPd4BRjn2iyUcdqPv>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 23 Jul 2025 10:08:58 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 95bd3140 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Wed, 23 Jul 2025 14:08:57 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Wed, 23 Jul 2025 16:08:30 +0200
Subject: [PATCH v2 09/21] config: drop `git_config_get_int()` wrapper
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250723-pks-config-wo-the-repository-v2-9-1502d60d3867@pks.im>
References: <20250723-pks-config-wo-the-repository-v2-0-1502d60d3867@pks.im>
In-Reply-To: <20250723-pks-config-wo-the-repository-v2-0-1502d60d3867@pks.im>
To: git@vger.kernel.org
Cc: Phillip Wood <phillip.wood123@gmail.com>
X-Mailer: b4 0.14.2

In 036876a1067 (config: hide functions using `the_repository` by
default, 2024-08-13) we have moved around a bunch of functions in the
config subsystem that depend on `the_repository`. Those function have
been converted into mere wrappers around their equivalent function that
takes in a repository as parameter, and the intent was that we'll
eventually remove those wrappers to make the dependency on the global
repository variable explicit at the callsite.

Follow through with that intent and remove `git_config_get_int()`. All
callsites are adjusted so that they use
`repo_config_get_int(the_repository, ...)` instead. While some callsites
might already have a repository available, this mechanical conversion is
the exact same as the current situation and thus cannot cause any
regression. Those sites should eventually be cleaned up in a later patch
series.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/credential-store.c |  2 +-
 builtin/fast-import.c      |  6 +++---
 builtin/fetch.c            |  4 ++--
 builtin/gc.c               | 26 +++++++++++++-------------
 config.h                   |  5 -----
 fetch-pack.c               |  4 ++--
 fsmonitor.c                |  2 +-
 merge-ort.c                |  6 +++---
 parallel-checkout.c        |  4 ++--
 refs.c                     |  2 +-
 refs/packed-backend.c      |  2 +-
 sequencer.c                |  2 +-
 t/helper/test-config.c     |  2 +-
 13 files changed, 31 insertions(+), 36 deletions(-)

diff --git a/builtin/credential-store.c b/builtin/credential-store.c
index e669e99dbfb..b74e06cc93d 100644
--- a/builtin/credential-store.c
+++ b/builtin/credential-store.c
@@ -66,7 +66,7 @@ static void rewrite_credential_file(const char *fn, struct credential *c,
 {
 	int timeout_ms = 1000;
 
-	git_config_get_int("credentialstore.locktimeoutms", &timeout_ms);
+	repo_config_get_int(the_repository, "credentialstore.locktimeoutms", &timeout_ms);
 	if (hold_lock_file_for_update_timeout(&credential_lock, fn, 0, timeout_ms) < 0)
 		die_errno(_("unable to get credential storage lock in %d ms"), timeout_ms);
 	if (extra)
diff --git a/builtin/fast-import.c b/builtin/fast-import.c
index 607441e921b..9b0ae437148 100644
--- a/builtin/fast-import.c
+++ b/builtin/fast-import.c
@@ -3527,7 +3527,7 @@ static void git_pack_config(void)
 		if (max_depth > MAX_DEPTH)
 			max_depth = MAX_DEPTH;
 	}
-	if (!git_config_get_int("pack.indexversion", &indexversion_value)) {
+	if (!repo_config_get_int(the_repository, "pack.indexversion", &indexversion_value)) {
 		pack_idx_opts.version = indexversion_value;
 		if (pack_idx_opts.version > 2)
 			git_die_config(the_repository, "pack.indexversion",
@@ -3536,9 +3536,9 @@ static void git_pack_config(void)
 	if (!git_config_get_ulong("pack.packsizelimit", &packsizelimit_value))
 		max_packsize = packsizelimit_value;
 
-	if (!git_config_get_int("fastimport.unpacklimit", &limit))
+	if (!repo_config_get_int(the_repository, "fastimport.unpacklimit", &limit))
 		unpack_limit = limit;
-	else if (!git_config_get_int("transfer.unpacklimit", &limit))
+	else if (!repo_config_get_int(the_repository, "transfer.unpacklimit", &limit))
 		unpack_limit = limit;
 
 	repo_config(the_repository, git_default_config, NULL);
diff --git a/builtin/fetch.c b/builtin/fetch.c
index 52eae4b972d..24645c46533 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -2683,12 +2683,12 @@ int cmd_fetch(int argc,
 			 * but respect config settings disabling it.
 			 */
 			int opt_val;
-			if (git_config_get_int("gc.autopacklimit", &opt_val))
+			if (repo_config_get_int(the_repository, "gc.autopacklimit", &opt_val))
 				opt_val = -1;
 			if (opt_val != 0)
 				git_config_push_parameter("gc.autoPackLimit=1");
 
-			if (git_config_get_int("maintenance.incremental-repack.auto", &opt_val))
+			if (repo_config_get_int(the_repository, "maintenance.incremental-repack.auto", &opt_val))
 				opt_val = -1;
 			if (opt_val != 0)
 				git_config_push_parameter("maintenance.incremental-repack.auto=-1");
diff --git a/builtin/gc.c b/builtin/gc.c
index a2b8fbc9f3d..cf175b8f1b7 100644
--- a/builtin/gc.c
+++ b/builtin/gc.c
@@ -189,10 +189,10 @@ static void gc_config(struct gc_config *cfg)
 	    gc_config_is_timestamp_never("gc.reflogexpireunreachable"))
 		cfg->prune_reflogs = 0;
 
-	git_config_get_int("gc.aggressivewindow", &cfg->aggressive_window);
-	git_config_get_int("gc.aggressivedepth", &cfg->aggressive_depth);
-	git_config_get_int("gc.auto", &cfg->gc_auto_threshold);
-	git_config_get_int("gc.autopacklimit", &cfg->gc_auto_pack_limit);
+	repo_config_get_int(the_repository, "gc.aggressivewindow", &cfg->aggressive_window);
+	repo_config_get_int(the_repository, "gc.aggressivedepth", &cfg->aggressive_depth);
+	repo_config_get_int(the_repository, "gc.auto", &cfg->gc_auto_threshold);
+	repo_config_get_int(the_repository, "gc.autopacklimit", &cfg->gc_auto_pack_limit);
 	git_config_get_bool("gc.autodetach", &cfg->detach_auto);
 	git_config_get_bool("gc.cruftpacks", &cfg->cruft_packs);
 	git_config_get_ulong("gc.maxcruftsize", &cfg->max_cruft_size);
@@ -332,7 +332,7 @@ static int reflog_expire_condition(struct gc_config *cfg UNUSED)
 	};
 	int limit = 100;
 
-	git_config_get_int("maintenance.reflog-expire.auto", &limit);
+	repo_config_get_int(the_repository, "maintenance.reflog-expire.auto", &limit);
 	if (!limit)
 		return 0;
 	if (limit < 0)
@@ -378,7 +378,7 @@ static int worktree_prune_condition(struct gc_config *cfg)
 	struct dirent *d;
 	DIR *dir = NULL;
 
-	git_config_get_int("maintenance.worktree-prune.auto", &limit);
+	repo_config_get_int(the_repository, "maintenance.worktree-prune.auto", &limit);
 	if (limit <= 0) {
 		should_prune = limit < 0;
 		goto out;
@@ -423,7 +423,7 @@ static int rerere_gc_condition(struct gc_config *cfg UNUSED)
 	int should_gc = 0, limit = 1;
 	DIR *dir = NULL;
 
-	git_config_get_int("maintenance.rerere-gc.auto", &limit);
+	repo_config_get_int(the_repository, "maintenance.rerere-gc.auto", &limit);
 	if (limit <= 0) {
 		should_gc = limit < 0;
 		goto out;
@@ -1161,8 +1161,8 @@ static int should_write_commit_graph(struct gc_config *cfg UNUSED)
 
 	data.num_not_in_graph = 0;
 	data.limit = 100;
-	git_config_get_int("maintenance.commit-graph.auto",
-			   &data.limit);
+	repo_config_get_int(the_repository, "maintenance.commit-graph.auto",
+			    &data.limit);
 
 	if (!data.limit)
 		return 0;
@@ -1300,8 +1300,8 @@ static int loose_object_auto_condition(struct gc_config *cfg UNUSED)
 {
 	int count = 0;
 
-	git_config_get_int("maintenance.loose-objects.auto",
-			   &loose_object_auto_limit);
+	repo_config_get_int(the_repository, "maintenance.loose-objects.auto",
+			    &loose_object_auto_limit);
 
 	if (!loose_object_auto_limit)
 		return 0;
@@ -1415,8 +1415,8 @@ static int incremental_repack_auto_condition(struct gc_config *cfg UNUSED)
 	if (!the_repository->settings.core_multi_pack_index)
 		return 0;
 
-	git_config_get_int("maintenance.incremental-repack.auto",
-			   &incremental_repack_auto_limit);
+	repo_config_get_int(the_repository, "maintenance.incremental-repack.auto",
+			    &incremental_repack_auto_limit);
 
 	if (!incremental_repack_auto_limit)
 		return 0;
diff --git a/config.h b/config.h
index 89739bee9b0..2490c47daaf 100644
--- a/config.h
+++ b/config.h
@@ -719,11 +719,6 @@ NORETURN void git_die_config_linenr(const char *key, const char *filename, int l
 int lookup_config(const char **mapping, int nr_mapping, const char *var);
 
 # ifdef USE_THE_REPOSITORY_VARIABLE
-static inline int git_config_get_int(const char *key, int *dest)
-{
-	return repo_config_get_int(the_repository, key, dest);
-}
-
 static inline int git_config_get_ulong(const char *key, unsigned long *dest)
 {
 	return repo_config_get_ulong(the_repository, key, dest);
diff --git a/fetch-pack.c b/fetch-pack.c
index 04768087879..1f184efb3c9 100644
--- a/fetch-pack.c
+++ b/fetch-pack.c
@@ -1901,8 +1901,8 @@ static int fetch_pack_config_cb(const char *var, const char *value,
 
 static void fetch_pack_config(void)
 {
-	git_config_get_int("fetch.unpacklimit", &fetch_unpack_limit);
-	git_config_get_int("transfer.unpacklimit", &transfer_unpack_limit);
+	repo_config_get_int(the_repository, "fetch.unpacklimit", &fetch_unpack_limit);
+	repo_config_get_int(the_repository, "transfer.unpacklimit", &transfer_unpack_limit);
 	git_config_get_bool("repack.usedeltabaseoffset", &prefer_ofs_delta);
 	git_config_get_bool("fetch.fsckobjects", &fetch_fsck_objects);
 	git_config_get_bool("transfer.fsckobjects", &transfer_fsck_objects);
diff --git a/fsmonitor.c b/fsmonitor.c
index 98b2b476f08..d07dc18967a 100644
--- a/fsmonitor.c
+++ b/fsmonitor.c
@@ -43,7 +43,7 @@ static int fsmonitor_hook_version(void)
 {
 	int hook_version;
 
-	if (git_config_get_int("core.fsmonitorhookversion", &hook_version))
+	if (repo_config_get_int(the_repository, "core.fsmonitorhookversion", &hook_version))
 		return -1;
 
 	if (hook_version == HOOK_INTERFACE_VERSION1 ||
diff --git a/merge-ort.c b/merge-ort.c
index 29789579c9b..45fd41f8dfd 100644
--- a/merge-ort.c
+++ b/merge-ort.c
@@ -5353,9 +5353,9 @@ static void merge_recursive_config(struct merge_options *opt, int ui)
 {
 	char *value = NULL;
 	int renormalize = 0;
-	git_config_get_int("merge.verbosity", &opt->verbosity);
-	git_config_get_int("diff.renamelimit", &opt->rename_limit);
-	git_config_get_int("merge.renamelimit", &opt->rename_limit);
+	repo_config_get_int(the_repository, "merge.verbosity", &opt->verbosity);
+	repo_config_get_int(the_repository, "diff.renamelimit", &opt->rename_limit);
+	repo_config_get_int(the_repository, "merge.renamelimit", &opt->rename_limit);
 	git_config_get_bool("merge.renormalize", &renormalize);
 	opt->renormalize = renormalize;
 	if (!repo_config_get_string(the_repository, "diff.renames", &value)) {
diff --git a/parallel-checkout.c b/parallel-checkout.c
index 57c2dcaa8f6..fba6aa65a6e 100644
--- a/parallel-checkout.c
+++ b/parallel-checkout.c
@@ -57,12 +57,12 @@ void get_parallel_checkout_configs(int *num_workers, int *threshold)
 		return;
 	}
 
-	if (git_config_get_int("checkout.workers", num_workers))
+	if (repo_config_get_int(the_repository, "checkout.workers", num_workers))
 		*num_workers = DEFAULT_NUM_WORKERS;
 	else if (*num_workers < 1)
 		*num_workers = online_cpus();
 
-	if (git_config_get_int("checkout.thresholdForParallelism", threshold))
+	if (repo_config_get_int(the_repository, "checkout.thresholdForParallelism", threshold))
 		*threshold = DEFAULT_THRESHOLD_FOR_PARALLELISM;
 }
 
diff --git a/refs.c b/refs.c
index 73913b6627b..777cbd34ebc 100644
--- a/refs.c
+++ b/refs.c
@@ -945,7 +945,7 @@ long get_files_ref_lock_timeout_ms(void)
 	static int timeout_ms = 100;
 
 	if (!configured) {
-		git_config_get_int("core.filesreflocktimeout", &timeout_ms);
+		repo_config_get_int(the_repository, "core.filesreflocktimeout", &timeout_ms);
 		configured = 1;
 	}
 
diff --git a/refs/packed-backend.c b/refs/packed-backend.c
index 7fd73a0e6da..7dd26726b1e 100644
--- a/refs/packed-backend.c
+++ b/refs/packed-backend.c
@@ -1228,7 +1228,7 @@ int packed_refs_lock(struct ref_store *ref_store, int flags, struct strbuf *err)
 	static int timeout_value = 1000;
 
 	if (!timeout_configured) {
-		git_config_get_int("core.packedrefstimeout", &timeout_value);
+		repo_config_get_int(the_repository, "core.packedrefstimeout", &timeout_value);
 		timeout_configured = 1;
 	}
 
diff --git a/sequencer.c b/sequencer.c
index f3bada39b40..f8d9bb69df8 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -5834,7 +5834,7 @@ static int make_script_with_merges(struct pretty_print_context *pp,
 		*cmd_reset = abbr ? "t" : "reset",
 		*cmd_merge = abbr ? "m" : "merge";
 
-	git_config_get_int("rebase.maxlabellength", &state.max_label_length);
+	repo_config_get_int(the_repository, "rebase.maxlabellength", &state.max_label_length);
 
 	oidmap_init(&commit2todo, 0);
 	oidmap_init(&state.commit2label, 0);
diff --git a/t/helper/test-config.c b/t/helper/test-config.c
index 30e70f1a6c2..ce1e3330516 100644
--- a/t/helper/test-config.c
+++ b/t/helper/test-config.c
@@ -155,7 +155,7 @@ int cmd__config(int argc, const char **argv)
 			BUG("Key \"%s\" has unknown return %d", argv[2], ret);
 		goto exit1;
 	} else if (argc == 3 && !strcmp(argv[1], "get_int")) {
-		if (!git_config_get_int(argv[2], &val)) {
+		if (!repo_config_get_int(the_repository, argv[2], &val)) {
 			printf("%d\n", val);
 			goto exit0;
 		} else {

-- 
2.50.1.552.g942d659e1b.dirty

