Received: from fhigh-a4-smtp.messagingengine.com (fhigh-a4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9316D2EACE7
	for <git@vger.kernel.org>; Wed, 23 Jul 2025 14:09:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753279747; cv=none; b=K4FnjoeeBebjbci/78/4XCArSRtm07s9pSbIRp7hl4Uqa1t4efPsjNBUW1g0ggrYy655ACG6kk7Yaqr+tf3eTLB4iwW/nXLdZuXgQSomEPCyiCc49Q3nXuuDrmsWPHgIrvQu+U61qDGODGhHz2efst/DdAldTwEnSB5diOkp5HU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753279747; c=relaxed/simple;
	bh=sSaT2oaU3/BEFOWU8/ll9SA6At8nrDdXyhocQD/0EOY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=WGDwZzaWrrfMNzrZxZATsXmOrfG/5XGxBwJd3L4YU29DcZTWltanNylmw0gw7kxLENEc1BOP1gqh28CW5nK0XRLCJ/TQSUcSUiKouQby0S/RUFO+eTf3njtrit6dTvJF7cATLqq8DhMYM3cXZ0KNNxkiVQE7FYcZiv6W8i56egs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=rfOZ0rtt; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=AmJAu1YE; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="rfOZ0rtt";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="AmJAu1YE"
Received: from phl-compute-12.internal (phl-compute-12.phl.internal [10.202.2.52])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 90CBB1401F48;
	Wed, 23 Jul 2025 10:09:04 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-12.internal (MEProxy); Wed, 23 Jul 2025 10:09:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1753279744;
	 x=1753366144; bh=3r2WyLvnyAd6ozy9YAbs+nB8s8x/01jPnjVb8pUH0o8=; b=
	rfOZ0rttMubnE1Y9f7HhVm8nAnNnqZdA4tHVP9ybJ8tr1HNzAegSovQCnAYTg69B
	RGebkysGvI6ieuLlC7glNFy/5gDe0jDe/+4aZNo7XqqFUE18JMIj0MnOoCBDcSAD
	0k/dcPClUpoRvECVdsxIys21cD23JAkgJDJMojnC9MXm7CtTEvpWVef0ky7sFVwc
	5x42h54Q8VAtGuTjMacDLWlhuF0ZhUNP4xc5LyZ/jogQbum1UV6/5YlOpWZjI6um
	TXA/H6BT8fSFX6izLYP1UbHCjZqkppRVnD70/D3Y+duhmOwqTFPZOP5QsQ6oJh1x
	pZD0ComAbGFo88AeFPXjTw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1753279744; x=
	1753366144; bh=3r2WyLvnyAd6ozy9YAbs+nB8s8x/01jPnjVb8pUH0o8=; b=A
	mJAu1YECX/lTgyDPNOeMUuA8FgmESjlWZiGaLh4bPd9ssxa5XjzGSMNZeDCUZW73
	gqD5/wmqIVSRQ53Ukwi5sGQOYD20LoLCh7zEIQLC73UVyxkv9ZQ3B+30HxEHacIK
	0s+i1lbJrBuFwEH/vS9cgfb4tPyK1LtXbLmxbQvMLpoBHDtRj/L3s3wz3kl2rKda
	uSEHGHd0YFLNytRHMn+LQjmDwr/szMtHUXp/zC2OP/mQ78RCnODAE4adT6ImKnby
	3o4jO+7/Un1oXfFZa/YNnBlp9Gj/ej7xZIBoMlXc+smXFvZmHU+to2q/wkBAjAdG
	Qxsy3BC6hmJGbPMQQ/3Ew==
X-ME-Sender: <xms:AO2AaC2hR1e68xKHfZyb5QsKBReSOBaHDcJoqKQhJyMXjsMwfdwLQg>
    <xme:AO2AaFQEE1RfVX5jOXRrQMLQ23iE9-xO-k-J-n-cEYAe0hqQnp3ooNAILGMQcvocQ
    DbeSQzvSqn9lo_V_w>
X-ME-Received: <xmr:AO2AaMuYRt97PhzZfoOXcA5dBTSrlXulLtBo-TdSikVQb2nQo9nQVYq9HlSFqXFWQ-A6787xJjK3rfMbJfwfiPMs4UPLb5PpvA7KmjMCwiAW>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdejjeelkecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhfffugggtgffkfhgjvfevofesthejredtredtjeenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epffeuiedujedvkeehuedvkeefffeivdeuleetkeduheejteekgedvudfgtdfgieelnecu
    vehluhhsthgvrhfuihiivgepvdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimhdpnhgspghrtghpthhtohepvddpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepphhhihhllhhiphdrfihoohguuddvfeesghhmrghilhdrtghomhdprhgtphhtthhope
    hgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:AO2AaCbuP01n4IWZYXhwASl4y_fRCNI_RCcjf8WPNVvneX0sEYzu0Q>
    <xmx:AO2AaJt1znA3bHodCtdAGS4WxyE58T29P4Sf6U1zY4OO0THRSLNhXg>
    <xmx:AO2AaMEHCjbqArRgHBoVeSKOtAcSfP8uSFPxhQD0yX1dUw8ldgXx-g>
    <xmx:AO2AaMyq-jqsD58tBwwe_wFqIg7ufmsUrk55lLkm9IqQkQA7_DxuVQ>
    <xmx:AO2AaNG4MZYl49a2XjOWiS05wsnpYTdV5Pn6vlm8OqPsuk47DvVtVHMg>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 23 Jul 2025 10:09:03 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 5d7fd7ea (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Wed, 23 Jul 2025 14:09:03 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Wed, 23 Jul 2025 16:08:32 +0200
Subject: [PATCH v2 11/21] config: drop `git_config_get_bool()` wrapper
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250723-pks-config-wo-the-repository-v2-11-1502d60d3867@pks.im>
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

Follow through with that intent and remove `git_config_get_bool()`. All
callsites are adjusted so that they use
`repo_config_get_bool(the_repository, ...)` instead. While some
callsites might already have a repository available, this mechanical
conversion is the exact same as the current situation and thus cannot
cause any regression. Those sites should eventually be cleaned up in a
later patch series.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 archive.c                          | 2 +-
 builtin/am.c                       | 8 ++++----
 builtin/checkout.c                 | 2 +-
 builtin/clone.c                    | 2 +-
 builtin/credential-cache--daemon.c | 2 +-
 builtin/gc.c                       | 6 +++---
 builtin/grep.c                     | 2 +-
 builtin/rebase.c                   | 2 +-
 compat/precompose_utf8.c           | 2 +-
 config.h                           | 5 -----
 daemon.c                           | 2 +-
 fetch-pack.c                       | 8 ++++----
 http-backend.c                     | 4 ++--
 merge-ort.c                        | 2 +-
 promisor-remote.c                  | 4 ++--
 read-cache.c                       | 4 ++--
 rerere.c                           | 4 ++--
 run-command.c                      | 6 +++---
 setup.c                            | 2 +-
 t/helper/test-config.c             | 2 +-
 transport.c                        | 2 +-
 21 files changed, 34 insertions(+), 39 deletions(-)

diff --git a/archive.c b/archive.c
index 2dd306a07a7..310672b479a 100644
--- a/archive.c
+++ b/archive.c
@@ -760,7 +760,7 @@ int write_archive(int argc, const char **argv, const char *prefix,
 	const char **argv_copy;
 	int rc;
 
-	git_config_get_bool("uploadarchive.allowunreachable", &remote_allow_unreachable);
+	repo_config_get_bool(the_repository, "uploadarchive.allowunreachable", &remote_allow_unreachable);
 	repo_config(the_repository, git_default_config, NULL);
 
 	describe_status.max_invocations = 1;
diff --git a/builtin/am.c b/builtin/am.c
index a7e7cf1465a..6073d64ae97 100644
--- a/builtin/am.c
+++ b/builtin/am.c
@@ -162,18 +162,18 @@ static void am_state_init(struct am_state *state)
 
 	state->prec = 4;
 
-	git_config_get_bool("am.threeway", &state->threeway);
+	repo_config_get_bool(the_repository, "am.threeway", &state->threeway);
 
 	state->utf8 = 1;
 
-	git_config_get_bool("am.messageid", &state->message_id);
+	repo_config_get_bool(the_repository, "am.messageid", &state->message_id);
 
 	state->scissors = SCISSORS_UNSET;
 	state->quoted_cr = quoted_cr_unset;
 
 	strvec_init(&state->git_apply_opts);
 
-	if (!git_config_get_bool("commit.gpgsign", &gpgsign))
+	if (!repo_config_get_bool(the_repository, "commit.gpgsign", &gpgsign))
 		state->sign_commit = gpgsign ? "" : NULL;
 }
 
@@ -965,7 +965,7 @@ static int split_mail(struct am_state *state, enum patch_format patch_format,
 {
 	if (keep_cr < 0) {
 		keep_cr = 0;
-		git_config_get_bool("am.keepcr", &keep_cr);
+		repo_config_get_bool(the_repository, "am.keepcr", &keep_cr);
 	}
 
 	switch (patch_format) {
diff --git a/builtin/checkout.c b/builtin/checkout.c
index 948ff7bdda7..37efde59898 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -291,7 +291,7 @@ static int checkout_merged(int pos, const struct checkout *state,
 	read_mmblob(&ours, &threeway[1]);
 	read_mmblob(&theirs, &threeway[2]);
 
-	git_config_get_bool("merge.renormalize", &renormalize);
+	repo_config_get_bool(the_repository, "merge.renormalize", &renormalize);
 	ll_opts.renormalize = renormalize;
 	ll_opts.conflict_style = conflict_style;
 	merge_status = ll_merge(&result_buf, path, &ancestor, "base",
diff --git a/builtin/clone.c b/builtin/clone.c
index 3c6d8529b6c..34eea11db4d 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -1150,7 +1150,7 @@ int cmd_clone(int argc,
 			strbuf_reset(&sb);
 		}
 
-		if (!git_config_get_bool("submodule.stickyRecursiveClone", &val) &&
+		if (!repo_config_get_bool(the_repository, "submodule.stickyRecursiveClone", &val) &&
 		    val)
 			string_list_append(&option_config, "submodule.recurse=true");
 
diff --git a/builtin/credential-cache--daemon.c b/builtin/credential-cache--daemon.c
index 5065ff4660b..65cc619bec2 100644
--- a/builtin/credential-cache--daemon.c
+++ b/builtin/credential-cache--daemon.c
@@ -307,7 +307,7 @@ int cmd_credential_cache_daemon(int argc,
 		OPT_END()
 	};
 
-	git_config_get_bool("credentialcache.ignoresighup", &ignore_sighup);
+	repo_config_get_bool(the_repository, "credentialcache.ignoresighup", &ignore_sighup);
 
 	argc = parse_options(argc, argv, prefix, options, usage, 0);
 	socket_path = argv[0];
diff --git a/builtin/gc.c b/builtin/gc.c
index d15daf59625..fa62e4f2627 100644
--- a/builtin/gc.c
+++ b/builtin/gc.c
@@ -193,8 +193,8 @@ static void gc_config(struct gc_config *cfg)
 	repo_config_get_int(the_repository, "gc.aggressivedepth", &cfg->aggressive_depth);
 	repo_config_get_int(the_repository, "gc.auto", &cfg->gc_auto_threshold);
 	repo_config_get_int(the_repository, "gc.autopacklimit", &cfg->gc_auto_pack_limit);
-	git_config_get_bool("gc.autodetach", &cfg->detach_auto);
-	git_config_get_bool("gc.cruftpacks", &cfg->cruft_packs);
+	repo_config_get_bool(the_repository, "gc.autodetach", &cfg->detach_auto);
+	repo_config_get_bool(the_repository, "gc.cruftpacks", &cfg->cruft_packs);
 	repo_config_get_ulong(the_repository, "gc.maxcruftsize", &cfg->max_cruft_size);
 
 	if (!repo_config_get_expiry(the_repository, "gc.pruneexpire", &owned)) {
@@ -1779,7 +1779,7 @@ static void initialize_task_config(struct maintenance_run_opts *opts,
 		strbuf_reset(&config_name);
 		strbuf_addf(&config_name, "maintenance.%s.enabled",
 			    tasks[i].name);
-		if (!git_config_get_bool(config_name.buf, &config_value))
+		if (!repo_config_get_bool(the_repository, config_name.buf, &config_value))
 			strategy.tasks[i].enabled = config_value;
 		if (!strategy.tasks[i].enabled)
 			continue;
diff --git a/builtin/grep.c b/builtin/grep.c
index 7982dda9a3b..8fcb69dbf2c 100644
--- a/builtin/grep.c
+++ b/builtin/grep.c
@@ -1058,7 +1058,7 @@ int cmd_grep(int argc,
 
 	if (use_index && !startup_info->have_repository) {
 		int fallback = 0;
-		git_config_get_bool("grep.fallbacktonoindex", &fallback);
+		repo_config_get_bool(the_repository, "grep.fallbacktonoindex", &fallback);
 		if (fallback)
 			use_index = 0;
 		else
diff --git a/builtin/rebase.c b/builtin/rebase.c
index 0c3daa4b814..72a52bdfb98 100644
--- a/builtin/rebase.c
+++ b/builtin/rebase.c
@@ -340,7 +340,7 @@ static int run_sequencer_rebase(struct rebase_options *opts)
 	unsigned flags = 0;
 	int abbreviate_commands = 0, ret = 0;
 
-	git_config_get_bool("rebase.abbreviatecommands", &abbreviate_commands);
+	repo_config_get_bool(the_repository, "rebase.abbreviatecommands", &abbreviate_commands);
 
 	flags |= opts->keep_empty ? TODO_LIST_KEEP_EMPTY : 0;
 	flags |= abbreviate_commands ? TODO_LIST_ABBREVIATE_CMDS : 0;
diff --git a/compat/precompose_utf8.c b/compat/precompose_utf8.c
index 12e38e0ea3c..3985ed108eb 100644
--- a/compat/precompose_utf8.c
+++ b/compat/precompose_utf8.c
@@ -75,7 +75,7 @@ const char *precompose_string_if_needed(const char *in)
 		iconv_t ic_prec;
 		char *out;
 		if (precomposed_unicode < 0)
-			git_config_get_bool("core.precomposeunicode", &precomposed_unicode);
+			repo_config_get_bool(the_repository, "core.precomposeunicode", &precomposed_unicode);
 		if (precomposed_unicode != 1)
 			return in;
 		ic_prec = iconv_open(repo_encoding, path_encoding);
diff --git a/config.h b/config.h
index e22c07a4488..c9f582c7c55 100644
--- a/config.h
+++ b/config.h
@@ -719,11 +719,6 @@ NORETURN void git_die_config_linenr(const char *key, const char *filename, int l
 int lookup_config(const char **mapping, int nr_mapping, const char *var);
 
 # ifdef USE_THE_REPOSITORY_VARIABLE
-static inline int git_config_get_bool(const char *key, int *dest)
-{
-	return repo_config_get_bool(the_repository, key, dest);
-}
-
 static inline int git_config_get_bool_or_int(const char *key, int *is_bool, int *dest)
 {
 	return repo_config_get_bool_or_int(the_repository, key, is_bool, dest);
diff --git a/daemon.c b/daemon.c
index 61cd50f7200..cb209235557 100644
--- a/daemon.c
+++ b/daemon.c
@@ -402,7 +402,7 @@ static int run_service(const char *dir, struct daemon_service *service,
 
 	if (service->overridable) {
 		strbuf_addf(&var, "daemon.%s", service->config_name);
-		git_config_get_bool(var.buf, &enabled);
+		repo_config_get_bool(the_repository, var.buf, &enabled);
 		strbuf_release(&var);
 	}
 	if (!enabled) {
diff --git a/fetch-pack.c b/fetch-pack.c
index 1f184efb3c9..94b1436c5c2 100644
--- a/fetch-pack.c
+++ b/fetch-pack.c
@@ -1903,10 +1903,10 @@ static void fetch_pack_config(void)
 {
 	repo_config_get_int(the_repository, "fetch.unpacklimit", &fetch_unpack_limit);
 	repo_config_get_int(the_repository, "transfer.unpacklimit", &transfer_unpack_limit);
-	git_config_get_bool("repack.usedeltabaseoffset", &prefer_ofs_delta);
-	git_config_get_bool("fetch.fsckobjects", &fetch_fsck_objects);
-	git_config_get_bool("transfer.fsckobjects", &transfer_fsck_objects);
-	git_config_get_bool("transfer.advertisesid", &advertise_sid);
+	repo_config_get_bool(the_repository, "repack.usedeltabaseoffset", &prefer_ofs_delta);
+	repo_config_get_bool(the_repository, "fetch.fsckobjects", &fetch_fsck_objects);
+	repo_config_get_bool(the_repository, "transfer.fsckobjects", &transfer_fsck_objects);
+	repo_config_get_bool(the_repository, "transfer.advertisesid", &advertise_sid);
 	if (!uri_protocols.nr) {
 		char *str;
 
diff --git a/http-backend.c b/http-backend.c
index 3d5d5a84646..d5dfe762bb5 100644
--- a/http-backend.c
+++ b/http-backend.c
@@ -246,13 +246,13 @@ static void http_config(void)
 	int i, value = 0;
 	struct strbuf var = STRBUF_INIT;
 
-	git_config_get_bool("http.getanyfile", &getanyfile);
+	repo_config_get_bool(the_repository, "http.getanyfile", &getanyfile);
 	repo_config_get_ulong(the_repository, "http.maxrequestbuffer", &max_request_buffer);
 
 	for (i = 0; i < ARRAY_SIZE(rpc_service); i++) {
 		struct rpc_service *svc = &rpc_service[i];
 		strbuf_addf(&var, "http.%s", svc->config_name);
-		if (!git_config_get_bool(var.buf, &value))
+		if (!repo_config_get_bool(the_repository, var.buf, &value))
 			svc->enabled = value;
 		strbuf_reset(&var);
 	}
diff --git a/merge-ort.c b/merge-ort.c
index 45fd41f8dfd..86896ff11b0 100644
--- a/merge-ort.c
+++ b/merge-ort.c
@@ -5356,7 +5356,7 @@ static void merge_recursive_config(struct merge_options *opt, int ui)
 	repo_config_get_int(the_repository, "merge.verbosity", &opt->verbosity);
 	repo_config_get_int(the_repository, "diff.renamelimit", &opt->rename_limit);
 	repo_config_get_int(the_repository, "merge.renamelimit", &opt->rename_limit);
-	git_config_get_bool("merge.renormalize", &renormalize);
+	repo_config_get_bool(the_repository, "merge.renormalize", &renormalize);
 	opt->renormalize = renormalize;
 	if (!repo_config_get_string(the_repository, "diff.renames", &value)) {
 		opt->detect_renames = git_config_rename("diff.renames", value);
diff --git a/promisor-remote.c b/promisor-remote.c
index a9c877d9cfa..08b0da89622 100644
--- a/promisor-remote.c
+++ b/promisor-remote.c
@@ -46,7 +46,7 @@ static int fetch_objects(struct repository *repo,
 		     "fetch", remote_name, "--no-tags",
 		     "--no-write-fetch-head", "--recurse-submodules=no",
 		     "--filter=blob:none", "--stdin", NULL);
-	if (!git_config_get_bool("promisor.quiet", &quiet) && quiet)
+	if (!repo_config_get_bool(the_repository, "promisor.quiet", &quiet) && quiet)
 		strvec_push(&child.args, "--quiet");
 	if (start_command(&child))
 		die(_("promisor-remote: unable to fork off fetch subprocess"));
@@ -343,7 +343,7 @@ char *promisor_remote_info(struct repository *repo)
 	struct strvec names = STRVEC_INIT;
 	struct strvec urls = STRVEC_INIT;
 
-	git_config_get_bool("promisor.advertise", &advertise_promisors);
+	repo_config_get_bool(the_repository, "promisor.advertise", &advertise_promisors);
 
 	if (!advertise_promisors)
 		return NULL;
diff --git a/read-cache.c b/read-cache.c
index 5cf41b81f1f..4fdde758d1b 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -2755,7 +2755,7 @@ static int record_eoie(void)
 {
 	int val;
 
-	if (!git_config_get_bool("index.recordendofindexentries", &val))
+	if (!repo_config_get_bool(the_repository, "index.recordendofindexentries", &val))
 		return val;
 
 	/*
@@ -2770,7 +2770,7 @@ static int record_ieot(void)
 {
 	int val;
 
-	if (!git_config_get_bool("index.recordoffsettable", &val))
+	if (!repo_config_get_bool(the_repository, "index.recordoffsettable", &val))
 		return val;
 
 	/*
diff --git a/rerere.c b/rerere.c
index 1ac2075144c..c7c3e535ce5 100644
--- a/rerere.c
+++ b/rerere.c
@@ -877,8 +877,8 @@ static int do_plain_rerere(struct repository *r,
 
 static void git_rerere_config(void)
 {
-	git_config_get_bool("rerere.enabled", &rerere_enabled);
-	git_config_get_bool("rerere.autoupdate", &rerere_autoupdate);
+	repo_config_get_bool(the_repository, "rerere.enabled", &rerere_enabled);
+	repo_config_get_bool(the_repository, "rerere.autoupdate", &rerere_autoupdate);
 	repo_config(the_repository, git_default_config, NULL);
 }
 
diff --git a/run-command.c b/run-command.c
index 8833b233678..ed9575bd6a8 100644
--- a/run-command.c
+++ b/run-command.c
@@ -1817,7 +1817,7 @@ int prepare_auto_maintenance(int quiet, struct child_process *maint)
 {
 	int enabled, auto_detach;
 
-	if (!git_config_get_bool("maintenance.auto", &enabled) &&
+	if (!repo_config_get_bool(the_repository, "maintenance.auto", &enabled) &&
 	    !enabled)
 		return 0;
 
@@ -1826,8 +1826,8 @@ int prepare_auto_maintenance(int quiet, struct child_process *maint)
 	 * honoring `gc.autoDetach`. This is somewhat weird, but required to
 	 * retain behaviour from when we used to run git-gc(1) here.
 	 */
-	if (git_config_get_bool("maintenance.autodetach", &auto_detach) &&
-	    git_config_get_bool("gc.autodetach", &auto_detach))
+	if (repo_config_get_bool(the_repository, "maintenance.autodetach", &auto_detach) &&
+	    repo_config_get_bool(the_repository, "gc.autodetach", &auto_detach))
 		auto_detach = 1;
 
 	maint->git_cmd = 1;
diff --git a/setup.c b/setup.c
index 9661c5d5d5d..a06bb921b3a 100644
--- a/setup.c
+++ b/setup.c
@@ -1877,7 +1877,7 @@ const char *setup_git_directory_gently(int *nongit_ok)
 	 * the core.precomposeunicode configuration, this
 	 * has to happen after the above block that finds
 	 * out where the repository is, i.e. a preparation
-	 * for calling git_config_get_bool().
+	 * for calling repo_config_get_bool().
 	 */
 	if (prefix) {
 		prefix = precompose_string_if_needed(prefix);
diff --git a/t/helper/test-config.c b/t/helper/test-config.c
index ce1e3330516..9f8cca7c48c 100644
--- a/t/helper/test-config.c
+++ b/t/helper/test-config.c
@@ -163,7 +163,7 @@ int cmd__config(int argc, const char **argv)
 			goto exit1;
 		}
 	} else if (argc == 3 && !strcmp(argv[1], "get_bool")) {
-		if (!git_config_get_bool(argv[2], &val)) {
+		if (!repo_config_get_bool(the_repository, argv[2], &val)) {
 			printf("%d\n", val);
 			goto exit0;
 		} else {
diff --git a/transport.c b/transport.c
index 89e6297ce22..e305d6bd228 100644
--- a/transport.c
+++ b/transport.c
@@ -1602,7 +1602,7 @@ int transport_get_remote_bundle_uri(struct transport *transport)
 	 * Don't request bundle-uri from the server unless configured to
 	 * do so by the transfer.bundleURI=true config option.
 	 */
-	if (git_config_get_bool("transfer.bundleuri", &value) || !value)
+	if (repo_config_get_bool(the_repository, "transfer.bundleuri", &value) || !value)
 		return 0;
 
 	if (!transport->bundles->baseURI)

-- 
2.50.1.552.g942d659e1b.dirty

