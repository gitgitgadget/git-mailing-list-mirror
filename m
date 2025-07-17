Received: from fout-b8-smtp.messagingengine.com (fout-b8-smtp.messagingengine.com [202.12.124.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C77029E111
	for <git@vger.kernel.org>; Thu, 17 Jul 2025 10:49:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752749395; cv=none; b=YqR94vM6XMSOehzcD92K5GvAkCLQmXarmVqolH7UiuORHc/pST/mDHMIcTZenA20IWHJlBeIRKnG/m5wOEUAvduMLoIL+JublN4Oqwe/r/dzshujMXgfFoprdKlJInK1/8PDQYujuuDQHFhwK9WJDU7jIV4VaRdlzrYtkvy/OKI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752749395; c=relaxed/simple;
	bh=5b7kJCwaoixL5il0Lgx4Re+7lg1SPkenNtbA9M+G3dc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=OgUB+PGiSrmOyMPb4hhkk6wPz9C7X7mEGbl98DA3T1TqCLowCLx+BJte0jlpzKA7WuX+BYJsu7EipBe4E/vH3Voaj9XF1zn/0fzmzkxkKIDLo5Sh2y2FxNQl/A/M4UJAWP2gB01/gxD4YkV9kS4+CJ2R1e+mo9g8sLDvyPTe+g0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=iiDN9/kQ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=duKp5alM; arc=none smtp.client-ip=202.12.124.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="iiDN9/kQ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="duKp5alM"
Received: from phl-compute-09.internal (phl-compute-09.phl.internal [10.202.2.49])
	by mailfout.stl.internal (Postfix) with ESMTP id 7A3FA1D00166
	for <git@vger.kernel.org>; Thu, 17 Jul 2025 06:49:52 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-09.internal (MEProxy); Thu, 17 Jul 2025 06:49:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1752749392;
	 x=1752835792; bh=U0dZif6071CPIgf8zLnV8Q/XotZlsglrvUrpD44ZAMw=; b=
	iiDN9/kQ0eJWA6W2d2iTCYub+aQVhTZPK0G6yiD+qA6L5z0BSNSbtLTQ6NBHtx1d
	ZTNCM1Graas+qf/5xfQv+18Tzh7KMpi4jdF83976OrNMahfaY+TVoaiewsZdQyDb
	ckWa7ooaUgV6JKdY7rEF/5b/jWRosMVWuSdBoOb3ZXQCaWoV0Dyi9k7TADVQ1eY7
	KEooNz90KOm8hLmFjzYCUlwYMyRgm0hTRlrwA/cp+b9BTY0/rWvjZx+xv45SlpBh
	bJ9qf+cjWmnbtoDm8FAi+FsQBOqBUnYT4EhB5eawk1DAEYM6NdG/b4bTV5D5FXKe
	cIN7PYV08svGJ8ctn3A26w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1752749392; x=
	1752835792; bh=U0dZif6071CPIgf8zLnV8Q/XotZlsglrvUrpD44ZAMw=; b=d
	uKp5alMft5raR3XLgDc3jx3yfi4u09frDutiwtkNc4k5h0dmf5pO+eKUvpoOiNJg
	Ja4p87DNNmGN6+hPobWZIZpqH3BcetIhLZz3ux6exE9E2AIs2igjakyFUY6m0g9Q
	YIgh+cL6g1NlL62k4pUvWpPBjz4Q9R6caxnCzF5jvFdERnkvoWS7cS7cx4CiZyem
	QCNOgLlTCEiv3gQkLKTWzGx2Du///lRpqlFYsQaDek7cCs1cFpBGT+i6v+jfkM3X
	oV/gYPynDDNhNIVa90cMybVtgxVXTXXAAk3HMe64q6JYtflG4ItYpqa4wXKe1wj0
	IavqLb4VPDIZe9c/lyRdA==
X-ME-Sender: <xms:UNV4aBSWeYdFlzkGN8Sx7Esctuljo9GrWsLOxUU5Bu_kYxzxfCVm_Q>
    <xme:UNV4aMxJLRrJLWrSZEZHlmL4RKkqedu29oeMNyoA8jJh3-XG-uvdpRbdnumcDnPUI
    u670KWNbdd6d07iRA>
X-ME-Received: <xmr:UNV4aAM1Gy4yQz5041ikZrCK-_pLKrQI6dGYrYQ0Tz81swVp_mSKZ1emrLQG_Vdubd1P-ZTpxB4f5IS8NvBZXOP0PP25joUyMl35IYn5HciY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdeitdefkecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecunecujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertd
    ertdejnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhk
    shdrihhmqeenucggtffrrghtthgvrhhnpeffueeiudejvdekheeuvdekfeffiedvueelte
    ekudehjeetkeegvddugfdtgfeileenucevlhhushhtvghrufhiiigvpedunecurfgrrhgr
    mhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopedupdhmoh
    guvgepshhmthhpohhuthdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdho
    rhhg
X-ME-Proxy: <xmx:UNV4aLM5Hy3QiHXFx-wM1GmuZfL-GUu4JRmgw307B4DGz7rCmDtlEw>
    <xmx:UNV4aCRQ0XCByqY0-rQns0ARFNelzekO7qH1ctnhT4ANpyy-Mm01OA>
    <xmx:UNV4aNCATj8Z7phfyHJukzMNqrjqlGPGpBbtQ5CUpOK-Nmi6CaKEFg>
    <xmx:UNV4aBhYe3RMzvNeJQ6VD8GEHcYm41htS6SQS34MOpQZ4av3sxlKcw>
    <xmx:UNV4aGIxqMpzSShoRSYF72k-_H2_XiR6nFPxMClkC0ffts0aybPBRBgs>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Thu, 17 Jul 2025 06:49:51 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 66627e43 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO)
	for <git@vger.kernel.org>;
	Thu, 17 Jul 2025 10:49:51 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Thu, 17 Jul 2025 12:49:27 +0200
Subject: [PATCH 07/21] config: drop `git_config_get_string()` wrapper
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250717-pks-config-wo-the-repository-v1-7-d888e4a17de1@pks.im>
References: <20250717-pks-config-wo-the-repository-v1-0-d888e4a17de1@pks.im>
In-Reply-To: <20250717-pks-config-wo-the-repository-v1-0-d888e4a17de1@pks.im>
To: git@vger.kernel.org
Cc: 
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
2.50.1.465.gcb3da1c9e6.dirty

