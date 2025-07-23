Received: from fout-a4-smtp.messagingengine.com (fout-a4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D191D2F532D
	for <git@vger.kernel.org>; Wed, 23 Jul 2025 14:08:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753279735; cv=none; b=ozuNSqS3KclEg5B3ubHkqEMRjKzd6sOEgPY6c/iHBggJl8Eu3Vrj/4X4K0pDTyZdGAH3lTAETWatlZJYztsMlYbKl8euE0QJKAZgsnPMSmnlh6xRJlA3/rtOx6QsYVasFiXwEigmkHHih41BVLQP1rVjGMybv9SC1OOBkpGZcGA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753279735; c=relaxed/simple;
	bh=n88kIfPSHLrG7L9VpPKU8Xe7SZs7A7Ubawskj0Qf8eY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=GwRkBG65j23lDpah8gBkSLL2OppgATx+e2jGic+pPpoG6StcL2L8M6yOOvSXWmTIzus2hSJdgknbsZygbzBF/2jgrHE82X2BJYOwfsUXNba6NFrbJ8b5sNgvq16fzRsPHt4j1AgY8jGF6QeVAck1xBjYhuqKbWzyiwNaMIQPsvU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=rO04+30V; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=V4u5tVKF; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="rO04+30V";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="V4u5tVKF"
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfout.phl.internal (Postfix) with ESMTP id F206AEC19D2;
	Wed, 23 Jul 2025 10:08:51 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Wed, 23 Jul 2025 10:08:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1753279731;
	 x=1753366131; bh=HFQkwgbyqbBk9mSaNi2VPyzEtJh+Wq3V8fhqmE6cVEk=; b=
	rO04+30VNVKvDNT5Rx5hkicMbVvW6GM28Ku9EN48W0cHMAwz8v7mlw33W05iBRmA
	qNpS9id/2PoAD59IRo01vNzDE154pbOTH2Iz/nqHc+BeWeEe20R/J9OhsLuvJuO2
	DhTgp+FVMsQIm6Mgzdx4SdmJSD3JxPtVZPsLi8091586al2ZBpuW+0T53PPxGSNq
	A+K6bww/PVjO9DS6F2M8iWPdO3fcxy4C+w5UzA1+4q1sFWCAOVrLHdvFfuKwHT0D
	MesjGhSrG9SyT8wN0kU/3IxB8P8/5rfYX5R/Pjx2n76RgrL0CyUT4Zl1ohtqqWPa
	8jEsF05DLx3woHYpoJAI8A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1753279731; x=
	1753366131; bh=HFQkwgbyqbBk9mSaNi2VPyzEtJh+Wq3V8fhqmE6cVEk=; b=V
	4u5tVKF4Pu7gwx1/eT/9fl5oW7fIyWkhgiQSs7nOla4KGsOzLqwQScquoNfCRrpM
	beu3z7R+bmGmmlRNecXL2p10CHkzFH6NHZjzt8yU4+VHPBW07gz8IT+OVA07NQcL
	xsP9B2e/oqOG9ZZHe3+dLTsVXZ16AJXGV05uTMWRjjXFnIln58iCQYgCve/uT0Yp
	s5mBoGFTyBwSjGpCHn1tQTgEk/J3fdR9dDCY/avEldfm4eKazbMJLjWthzBl1IeS
	M4ubMNlTBuqDsiHS0UFiY415/uiBPe/xiftHEZF3iApEvWIHLAcWzCZD8+C+ZaUz
	dRS7fBBsvBl61PxzM8AGQ==
X-ME-Sender: <xms:8-yAaKDM5IAH3QPBAl2hFCgy-sCrvbgjubE6sFTul_WHZOS6-Gg3Kw>
    <xme:8-yAaEvWCwlGa1E4-ciQ56wAvErhOswo5YDq0GdfY6y-YNmoRNxasE_Q-o9YHlf9C
    v2dWm88Xdc5_z1WbA>
X-ME-Received: <xmr:8-yAaPbojztv2g4qBxbpUZK8jsVEPuf0Xqsn6a2P-SJPBoUYAp-UoDljI7bl3lYKBHTsuocHEinVor0Ghao-17oV9n5Yx9Ucryp1cmTQSC04>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdejjeeljecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhfffugggtgffkfhgjvfevofesthejredtredtjeenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epffeuiedujedvkeehuedvkeefffeivdeuleetkeduheejteekgedvudfgtdfgieelnecu
    vehluhhsthgvrhfuihiivgepudenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimhdpnhgspghrtghpthhtohepvddpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehphhhilhhlih
    hprdifohhougduvdefsehgmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:8-yAaHWyIaiD-c211yFOLhUEXmqrxn_iHO_bh9MdJgGSXFCQVRFFeQ>
    <xmx:8-yAaD4FInSD8SQY3nHuO6qXo4MlutB8pENtFglDspjf7U1yrkQ5lA>
    <xmx:8-yAaCii7ndD-aDdE5KT8_Qu_P6QnCRqzlOlBMeS43N-oozfRBebUg>
    <xmx:8-yAaKfy_FSFHehQlc51nGCUApTpQeRdeO0RcNOPtJGaSGkUZ8lAVg>
    <xmx:8-yAaHQjqbVB9pXlGYpolDbsDnV5RRmPCG53n-mIubnmyrDq_VUhmri4>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 23 Jul 2025 10:08:51 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id eaae977e (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Wed, 23 Jul 2025 14:08:51 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Wed, 23 Jul 2025 16:08:28 +0200
Subject: [PATCH v2 07/21] config: drop `git_config_get_string()` wrapper
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250723-pks-config-wo-the-repository-v2-7-1502d60d3867@pks.im>
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

Follow through with that intent and remove `git_config_get_string()`.
All callsites are adjusted so that they use
`repo_config_get_string(the_repository, ...)` instead. While some
callsites might already have a repository available, this mechanical
conversion is the exact same as the current situation and thus cannot
cause any regression. Those sites should eventually be cleaned up in a
later patch series.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 apply.c                     |  4 ++--
 branch.c                    |  2 +-
 builtin/gc.c                |  4 ++--
 builtin/log.c               |  2 +-
 builtin/notes.c             |  2 +-
 builtin/submodule--helper.c | 12 ++++++------
 config.h                    |  5 -----
 fetch-pack.c                |  2 +-
 merge-ort.c                 |  8 ++++----
 scalar.c                    |  4 ++--
 sequencer.c                 |  2 +-
 transport.c                 |  8 ++++----
 12 files changed, 25 insertions(+), 30 deletions(-)

diff --git a/apply.c b/apply.c
index d2381a157c0..45eb790d133 100644
--- a/apply.c
+++ b/apply.c
@@ -48,8 +48,8 @@ struct gitdiff_data {
 
 static void git_apply_config(void)
 {
-	git_config_get_string("apply.whitespace", &apply_default_whitespace);
-	git_config_get_string("apply.ignorewhitespace", &apply_default_ignorewhitespace);
+	repo_config_get_string(the_repository, "apply.whitespace", &apply_default_whitespace);
+	repo_config_get_string(the_repository, "apply.ignorewhitespace", &apply_default_ignorewhitespace);
 	repo_config(the_repository, git_xmerge_config, NULL);
 }
 
diff --git a/branch.c b/branch.c
index 93f5b4e8dd9..b4811671fc7 100644
--- a/branch.c
+++ b/branch.c
@@ -355,7 +355,7 @@ int read_branch_desc(struct strbuf *buf, const char *branch_name)
 	char *v = NULL;
 	struct strbuf name = STRBUF_INIT;
 	strbuf_addf(&name, "branch.%s.description", branch_name);
-	if (git_config_get_string(name.buf, &v)) {
+	if (repo_config_get_string(the_repository, name.buf, &v)) {
 		strbuf_release(&name);
 		return -1;
 	}
diff --git a/builtin/gc.c b/builtin/gc.c
index f395cc57a15..d8f7a1858cb 100644
--- a/builtin/gc.c
+++ b/builtin/gc.c
@@ -218,12 +218,12 @@ static void gc_config(struct gc_config *cfg)
 	if (!git_config_get_ulong("core.deltabasecachelimit", &ulongval))
 		cfg->delta_base_cache_limit = ulongval;
 
-	if (!git_config_get_string("gc.repackfilter", &owned)) {
+	if (!repo_config_get_string(the_repository, "gc.repackfilter", &owned)) {
 		free(cfg->repack_filter);
 		cfg->repack_filter = owned;
 	}
 
-	if (!git_config_get_string("gc.repackfilterto", &owned)) {
+	if (!repo_config_get_string(the_repository, "gc.repackfilterto", &owned)) {
 		free(cfg->repack_filter_to);
 		cfg->repack_filter_to = owned;
 	}
diff --git a/builtin/log.c b/builtin/log.c
index b512f12e805..a9969ad00a0 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -235,7 +235,7 @@ static void set_default_decoration_filter(struct decoration_filter *decoration_f
 	 * since the command-line takes precedent.
 	 */
 	if (use_default_decoration_filter &&
-	    !git_config_get_string("log.initialdecorationset", &value) &&
+	    !repo_config_get_string(the_repository, "log.initialdecorationset", &value) &&
 	    !strcmp("all", value))
 		use_default_decoration_filter = 0;
 	free(value);
diff --git a/builtin/notes.c b/builtin/notes.c
index 17004cdb10e..d2252cf5346 100644
--- a/builtin/notes.c
+++ b/builtin/notes.c
@@ -873,7 +873,7 @@ static int git_config_get_notes_strategy(const char *key,
 {
 	char *value;
 
-	if (git_config_get_string(key, &value))
+	if (repo_config_get_string(the_repository, key, &value))
 		return 1;
 	if (parse_notes_merge_strategy(value, strategy))
 		git_die_config(the_repository, key, _("unknown notes merge strategy %s"), value);
diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index 6bcc741a6ac..18aa69f0cae 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -53,7 +53,7 @@ static char *resolve_relative_url(const char *rel_url, const char *up_path, int
 	struct strbuf remotesb = STRBUF_INIT;
 
 	strbuf_addf(&remotesb, "remote.%s.url", remote);
-	if (git_config_get_string(remotesb.buf, &remoteurl)) {
+	if (repo_config_get_string(the_repository, remotesb.buf, &remoteurl)) {
 		if (!quiet)
 			warning(_("could not look up configuration '%s'. "
 				  "Assuming this repository is its own "
@@ -468,7 +468,7 @@ static void init_submodule(const char *path, const char *prefix,
 	 * .gitmodules, so look it up directly.
 	 */
 	strbuf_addf(&sb, "submodule.%s.url", sub->name);
-	if (git_config_get_string(sb.buf, &url)) {
+	if (repo_config_get_string(the_repository, sb.buf, &url)) {
 		if (!sub->url)
 			die(_("No url found for submodule path '%s' in .gitmodules"),
 				displaypath);
@@ -1623,11 +1623,11 @@ static void prepare_possible_alternates(const char *sm_name,
 	char *sm_alternate = NULL, *error_strategy = NULL;
 	struct submodule_alternate_setup sas = SUBMODULE_ALTERNATE_SETUP_INIT;
 
-	git_config_get_string("submodule.alternateLocation", &sm_alternate);
+	repo_config_get_string(the_repository, "submodule.alternateLocation", &sm_alternate);
 	if (!sm_alternate)
 		return;
 
-	git_config_get_string("submodule.alternateErrorStrategy", &error_strategy);
+	repo_config_get_string(the_repository, "submodule.alternateErrorStrategy", &error_strategy);
 
 	if (!error_strategy)
 		error_strategy = xstrdup("die");
@@ -1808,11 +1808,11 @@ static int clone_submodule(const struct module_clone_data *clone_data,
 		die(_("could not get submodule directory for '%s'"), clone_data_path);
 
 	/* setup alternateLocation and alternateErrorStrategy in the cloned submodule if needed */
-	git_config_get_string("submodule.alternateLocation", &sm_alternate);
+	repo_config_get_string(the_repository, "submodule.alternateLocation", &sm_alternate);
 	if (sm_alternate)
 		git_config_set_in_file(p, "submodule.alternateLocation",
 				       sm_alternate);
-	git_config_get_string("submodule.alternateErrorStrategy", &error_strategy);
+	repo_config_get_string(the_repository, "submodule.alternateErrorStrategy", &error_strategy);
 	if (error_strategy)
 		git_config_set_in_file(p, "submodule.alternateErrorStrategy",
 				       error_strategy);
diff --git a/config.h b/config.h
index f6635e48c23..8887ebf62ea 100644
--- a/config.h
+++ b/config.h
@@ -719,11 +719,6 @@ NORETURN void git_die_config_linenr(const char *key, const char *filename, int l
 int lookup_config(const char **mapping, int nr_mapping, const char *var);
 
 # ifdef USE_THE_REPOSITORY_VARIABLE
-static inline int git_config_get_string(const char *key, char **dest)
-{
-	return repo_config_get_string(the_repository, key, dest);
-}
-
 static inline int git_config_get_string_tmp(const char *key, const char **dest)
 {
 	return repo_config_get_string_tmp(the_repository, key, dest);
diff --git a/fetch-pack.c b/fetch-pack.c
index 11344206f73..04768087879 100644
--- a/fetch-pack.c
+++ b/fetch-pack.c
@@ -1910,7 +1910,7 @@ static void fetch_pack_config(void)
 	if (!uri_protocols.nr) {
 		char *str;
 
-		if (!git_config_get_string("fetch.uriprotocols", &str) && str) {
+		if (!repo_config_get_string(the_repository, "fetch.uriprotocols", &str) && str) {
 			string_list_split(&uri_protocols, str, ',', -1);
 			free(str);
 		}
diff --git a/merge-ort.c b/merge-ort.c
index 49aa37a8f23..29789579c9b 100644
--- a/merge-ort.c
+++ b/merge-ort.c
@@ -5358,15 +5358,15 @@ static void merge_recursive_config(struct merge_options *opt, int ui)
 	git_config_get_int("merge.renamelimit", &opt->rename_limit);
 	git_config_get_bool("merge.renormalize", &renormalize);
 	opt->renormalize = renormalize;
-	if (!git_config_get_string("diff.renames", &value)) {
+	if (!repo_config_get_string(the_repository, "diff.renames", &value)) {
 		opt->detect_renames = git_config_rename("diff.renames", value);
 		free(value);
 	}
-	if (!git_config_get_string("merge.renames", &value)) {
+	if (!repo_config_get_string(the_repository, "merge.renames", &value)) {
 		opt->detect_renames = git_config_rename("merge.renames", value);
 		free(value);
 	}
-	if (!git_config_get_string("merge.directoryrenames", &value)) {
+	if (!repo_config_get_string(the_repository, "merge.directoryrenames", &value)) {
 		int boolval = git_parse_maybe_bool(value);
 		if (0 <= boolval) {
 			opt->detect_directory_renames = boolval ?
@@ -5379,7 +5379,7 @@ static void merge_recursive_config(struct merge_options *opt, int ui)
 		free(value);
 	}
 	if (ui) {
-		if (!git_config_get_string("diff.algorithm", &value)) {
+		if (!repo_config_get_string(the_repository, "diff.algorithm", &value)) {
 			long diff_algorithm = parse_algorithm_value(value);
 			if (diff_algorithm < 0)
 				die(_("unknown value for config '%s': %s"), "diff.algorithm", value);
diff --git a/scalar.c b/scalar.c
index 2aaff5aa109..07f855c9913 100644
--- a/scalar.c
+++ b/scalar.c
@@ -101,7 +101,7 @@ static int set_scalar_config(const struct scalar_config *config, int reconfigure
 	int res;
 
 	if ((reconfigure && config->overwrite_on_reconfigure) ||
-	    git_config_get_string(config->key, &value)) {
+	    repo_config_get_string(the_repository, config->key, &value)) {
 		trace2_data_string("scalar", the_repository, config->key, "created");
 		res = git_config_set_gently(config->key, config->value);
 	} else {
@@ -193,7 +193,7 @@ static int set_recommended_config(int reconfigure)
 	 * The `log.excludeDecoration` setting is special because it allows
 	 * for multiple values.
 	 */
-	if (git_config_get_string("log.excludeDecoration", &value)) {
+	if (repo_config_get_string(the_repository, "log.excludeDecoration", &value)) {
 		trace2_data_string("scalar", the_repository,
 				   "log.excludeDecoration", "created");
 		if (git_config_set_multivar_gently("log.excludeDecoration",
diff --git a/sequencer.c b/sequencer.c
index df207f33e07..f3bada39b40 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -6089,7 +6089,7 @@ int sequencer_make_script(struct repository *r, struct strbuf *out, int argc,
 	revs.topo_order = 1;
 
 	revs.pretty_given = 1;
-	git_config_get_string("rebase.instructionFormat", &format);
+	repo_config_get_string(the_repository, "rebase.instructionFormat", &format);
 	if (!format || !*format) {
 		free(format);
 		format = xstrdup("# %s");
diff --git a/transport.c b/transport.c
index a246afd09fa..89e6297ce22 100644
--- a/transport.c
+++ b/transport.c
@@ -54,14 +54,14 @@ static int transport_color_config(void)
 		return 0;
 	initialized = 1;
 
-	if (!git_config_get_string(key, &value))
+	if (!repo_config_get_string(the_repository, key, &value))
 		transport_use_color = git_config_colorbool(key, value);
 
 	if (!want_color_stderr(transport_use_color))
 		return 0;
 
 	for (size_t i = 0; i < ARRAY_SIZE(keys); i++)
-		if (!git_config_get_string(keys[i], &value)) {
+		if (!repo_config_get_string(the_repository, keys[i], &value)) {
 			if (!value)
 				return config_error_nonbool(keys[i]);
 			if (color_parse(value, transport_colors[i]) < 0)
@@ -1078,7 +1078,7 @@ static enum protocol_allow_config get_protocol_config(const char *type)
 	char *value;
 
 	/* first check the per-protocol config */
-	if (!git_config_get_string(key, &value)) {
+	if (!repo_config_get_string(the_repository, key, &value)) {
 		enum protocol_allow_config ret =
 			parse_protocol_config(key, value);
 		free(key);
@@ -1088,7 +1088,7 @@ static enum protocol_allow_config get_protocol_config(const char *type)
 	free(key);
 
 	/* if defined, fallback to user-defined default for unknown protocols */
-	if (!git_config_get_string("protocol.allow", &value)) {
+	if (!repo_config_get_string(the_repository, "protocol.allow", &value)) {
 		enum protocol_allow_config ret =
 			parse_protocol_config("protocol.allow", value);
 		free(value);

-- 
2.50.1.552.g942d659e1b.dirty

