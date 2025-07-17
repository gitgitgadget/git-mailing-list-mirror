Received: from fhigh-b5-smtp.messagingengine.com (fhigh-b5-smtp.messagingengine.com [202.12.124.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DF422BCF46
	for <git@vger.kernel.org>; Thu, 17 Jul 2025 10:49:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752749398; cv=none; b=O+CR3aNjKNE062o1Lo5tRds1iuq8sNT6s2r4G8Dq2m5Y8zVPCi4zYLvsrE6FvE6xFTm4pjL6FbXAir6VJr86Xaqmo7EHo/PVqgfuT6XiOIpj4mL9bdtWpN+BDYzJpMreCoNc7W4hRp6mSrFyK+R39naI1Jettx12kB+fwfizfi8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752749398; c=relaxed/simple;
	bh=6tNEOTCaVNywOOtkyoYLCAGafC4NRje/IL6HBF7g/WQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=en606kP879Z3pw97C9HhsjaIrlb+MhefvnD4tp3MW5P9Ge6vwupS/lVnYvJxlJDgehMb6el0hSWvDsXBn3BUbcRr5/hvORxiQQkoOuFNbuph/bgPUiTCAY8tf15KkoAT++i3WYkbKE5V0xZkA04e36cQhHpLRGmXtFhtj7hz2lc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=FJnuFFkI; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=bJl/ou3l; arc=none smtp.client-ip=202.12.124.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="FJnuFFkI";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="bJl/ou3l"
Received: from phl-compute-08.internal (phl-compute-08.phl.internal [10.202.2.48])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 82FC77A021D
	for <git@vger.kernel.org>; Thu, 17 Jul 2025 06:49:55 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-08.internal (MEProxy); Thu, 17 Jul 2025 06:49:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1752749395;
	 x=1752835795; bh=OqQ9nsYfgVrhK3rwwFS8ew1edWrxX8x8GMz9EWZVIcU=; b=
	FJnuFFkInb/LfOa7CRKN0E6V32Hx2XLO93j+sGHYir+DV2nQgShOLCd0890Gv5Hh
	cwoWqacN+uSWWWDaDBlI32mkNImnuN4F1y75fKyadT2Bfi0PZQtL1RRdM/EXT5HM
	useFd6KaDLo8sBqnB7v+2spAOgww/ilzpQDww2MpchDERLXno5CUiSlMfyv2/cpX
	RxHzQ1zL4dZ6uV/9hwBY5qOGoaLmc8+2EfFSzcd6HuOUeJAjLkhOFRL6nRYQTML+
	gUliTCai1DxmTfa5hBUrHcO+Id3QFtl9oFHVg9NsibtzHHVjMyDyJGTZ4e40IBFD
	QyPMsrwlwXRItDNcw3j4Ag==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1752749395; x=
	1752835795; bh=OqQ9nsYfgVrhK3rwwFS8ew1edWrxX8x8GMz9EWZVIcU=; b=b
	Jl/ou3l0yaaVnsSm4yQQu9N3Tq3V+Oa/MFlnvT1CGOCA5ovOE3qlFHa6TdTlxqWY
	0qQUJcNQ0yrQQPJOIqMvF587FFHfJ68IOJkqeeeXM75mdh8QTUl48qEOuyCx00+x
	rBZqNm97Q2QXj2OrkisVaiF8xU5rC9hzHoCgiDw3uTp3oGs/xHrsKC7KIwXZSd6r
	WFaCQ2GF3EmBhWBlF6nyBen/7qPz1V+2Zu+ZV9sPXmRilX0nS3xYpFw6xdUOljo9
	/aL5GDZyHHjoiTMkDCu4d5EcTDycWmQzjyjRttBrDFwq6/K4/7ewZMJ0kUJiPHvp
	HmdfOY+gnL9pGH0XUf55Q==
X-ME-Sender: <xms:U9V4aHN6i7DO3SSelsJ8ISfP38nSVrx-1wpNW3sTVLzdnQCSQhmX1Q>
    <xme:U9V4aD_gjJOS_KuM6NVtgVvjfCIw-OJ_R5GqXfd5cOfiFciO87hNnIxsyLM7tJBi3
    teo39FOVyzYwOfipQ>
X-ME-Received: <xmr:U9V4aPqV_Siczd8YOSgFhfZewTBJOq5iR7ZqROYwTSkfVHDmJvrGTuIoxlDf7kWA9uPPOxMZIzZYy_c8vw9ZXhcOnPObZAuYLCnGo6yEn1O1>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdeitdefkecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecunecujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertd
    ertdejnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhk
    shdrihhmqeenucggtffrrghtthgvrhhnpeffueeiudejvdekheeuvdekfeffiedvueelte
    ekudehjeetkeegvddugfdtgfeileenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgr
    mhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopedupdhmoh
    guvgepshhmthhpohhuthdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdho
    rhhg
X-ME-Proxy: <xmx:U9V4aN5sVPigCASZraSjROtJ4vFHG2gp7ucySxOxeKKqBZppuDzk6Q>
    <xmx:U9V4aHO7FDinz-IgLEjLV2qO7Q8m7TKfLOjQDK8oJOX1dcdooYV8LA>
    <xmx:U9V4aHMrQBgtkIgPHiSZA2fVpt66U5gQMtfuXLiwrMSUG2FBIPcWiw>
    <xmx:U9V4aH9x85rJcs8bCwTxx8FTwy02-WNITmXDgakqMYr12hoXnkV3YQ>
    <xmx:U9V4aE2FDB16bvy6JtwIr8tgg_TAbvUqgxN0_ImXGZ4WJqb8gcJoO9bQ>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Thu, 17 Jul 2025 06:49:54 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 22fcaf7d (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO)
	for <git@vger.kernel.org>;
	Thu, 17 Jul 2025 10:49:54 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Thu, 17 Jul 2025 12:49:28 +0200
Subject: [PATCH 08/21] config: drop `git_config_get_string()` wrapper
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250717-pks-config-wo-the-repository-v1-8-d888e4a17de1@pks.im>
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
 builtin/fetch.c             | 2 +-
 builtin/gc.c                | 4 ++--
 builtin/remote.c            | 2 +-
 builtin/submodule--helper.c | 4 ++--
 checkout.c                  | 2 +-
 config.h                    | 5 -----
 connect.c                   | 4 ++--
 editor.c                    | 2 +-
 help.c                      | 2 +-
 promisor-remote.c           | 4 ++--
 protocol.c                  | 2 +-
 remote.c                    | 2 +-
 sideband.c                  | 6 +++---
 t/helper/test-config.c      | 2 +-
 14 files changed, 19 insertions(+), 24 deletions(-)

diff --git a/builtin/fetch.c b/builtin/fetch.c
index ea447c453d1..52eae4b972d 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -2508,7 +2508,7 @@ int cmd_fetch(int argc,
 	if (!max_jobs)
 		max_jobs = online_cpus();
 
-	if (!git_config_get_string_tmp("fetch.bundleuri", &bundle_uri) &&
+	if (!repo_config_get_string_tmp(the_repository, "fetch.bundleuri", &bundle_uri) &&
 	    fetch_bundle_uri(the_repository, bundle_uri, NULL))
 		warning(_("failed to fetch bundles from '%s'"), bundle_uri);
 
diff --git a/builtin/gc.c b/builtin/gc.c
index d8f7a1858cb..a2b8fbc9f3d 100644
--- a/builtin/gc.c
+++ b/builtin/gc.c
@@ -1765,7 +1765,7 @@ static void initialize_task_config(struct maintenance_run_opts *opts,
 	if (opts->schedule) {
 		strategy = none_strategy;
 
-		if (!git_config_get_string_tmp("maintenance.strategy", &config_str)) {
+		if (!repo_config_get_string_tmp(the_repository, "maintenance.strategy", &config_str)) {
 			if (!strcasecmp(config_str, "incremental"))
 				strategy = incremental_strategy;
 		}
@@ -1788,7 +1788,7 @@ static void initialize_task_config(struct maintenance_run_opts *opts,
 			strbuf_reset(&config_name);
 			strbuf_addf(&config_name, "maintenance.%s.schedule",
 				    tasks[i].name);
-			if (!git_config_get_string_tmp(config_name.buf, &config_str))
+			if (!repo_config_get_string_tmp(the_repository, config_name.buf, &config_str))
 				strategy.tasks[i].schedule = parse_schedule(config_str);
 			if (strategy.tasks[i].schedule < opts->schedule)
 				continue;
diff --git a/builtin/remote.c b/builtin/remote.c
index ebd70bea3a1..826b2dcfd04 100644
--- a/builtin/remote.c
+++ b/builtin/remote.c
@@ -1268,7 +1268,7 @@ static int get_one_entry(struct remote *remote, void *priv)
 
 		strbuf_addf(&promisor_config, "remote.%s.partialclonefilter", remote->name);
 		strbuf_addf(&remote_info_buf, "%s (fetch)", remote->url.v[0]);
-		if (!git_config_get_string_tmp(promisor_config.buf, &partial_clone_filter))
+		if (!repo_config_get_string_tmp(the_repository, promisor_config.buf, &partial_clone_filter))
 			strbuf_addf(&remote_info_buf, " [%s]", partial_clone_filter);
 
 		strbuf_release(&promisor_config);
diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index 18aa69f0cae..d2ab31835b5 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -496,7 +496,7 @@ static void init_submodule(const char *path, const char *prefix,
 
 	/* Copy "update" setting when it is not set yet */
 	strbuf_addf(&sb, "submodule.%s.update", sub->name);
-	if (git_config_get_string_tmp(sb.buf, &upd) &&
+	if (repo_config_get_string_tmp(the_repository, sb.buf, &upd) &&
 	    sub->update_strategy.type != SM_UPDATE_UNSPECIFIED) {
 		if (sub->update_strategy.type == SM_UPDATE_COMMAND) {
 			fprintf(stderr, _("warning: command update mode suggested for submodule '%s'\n"),
@@ -1034,7 +1034,7 @@ static void prepare_submodule_summary(struct summary_cb *info,
 
 			config_key = xstrfmt("submodule.%s.ignore",
 					     sub->name);
-			if (!git_config_get_string_tmp(config_key, &value))
+			if (!repo_config_get_string_tmp(the_repository, config_key, &value))
 				ignore_all = !strcmp(value, "all");
 			else if (sub->ignore)
 				ignore_all = !strcmp(sub->ignore, "all");
diff --git a/checkout.c b/checkout.c
index 0b1cf8b40b7..1588b116eed 100644
--- a/checkout.c
+++ b/checkout.c
@@ -52,7 +52,7 @@ char *unique_tracking_name(const char *name, struct object_id *oid,
 {
 	struct tracking_name_data cb_data = TRACKING_NAME_DATA_INIT;
 	const char *default_remote = NULL;
-	if (!git_config_get_string_tmp("checkout.defaultremote", &default_remote))
+	if (!repo_config_get_string_tmp(the_repository, "checkout.defaultremote", &default_remote))
 		cb_data.default_remote = default_remote;
 	cb_data.src_ref = xstrfmt("refs/heads/%s", name);
 	cb_data.dst_oid = oid;
diff --git a/config.h b/config.h
index 8887ebf62ea..89739bee9b0 100644
--- a/config.h
+++ b/config.h
@@ -719,11 +719,6 @@ NORETURN void git_die_config_linenr(const char *key, const char *filename, int l
 int lookup_config(const char **mapping, int nr_mapping, const char *var);
 
 # ifdef USE_THE_REPOSITORY_VARIABLE
-static inline int git_config_get_string_tmp(const char *key, const char **dest)
-{
-	return repo_config_get_string_tmp(the_repository, key, dest);
-}
-
 static inline int git_config_get_int(const char *key, int *dest)
 {
 	return repo_config_get_int(the_repository, key, dest);
diff --git a/connect.c b/connect.c
index 4b1dc65e5ce..34cac24d54c 100644
--- a/connect.c
+++ b/connect.c
@@ -1154,7 +1154,7 @@ static const char *get_ssh_command(void)
 	if ((ssh = getenv("GIT_SSH_COMMAND")))
 		return ssh;
 
-	if (!git_config_get_string_tmp("core.sshcommand", &ssh))
+	if (!repo_config_get_string_tmp(the_repository, "core.sshcommand", &ssh))
 		return ssh;
 
 	return NULL;
@@ -1173,7 +1173,7 @@ static void override_ssh_variant(enum ssh_variant *ssh_variant)
 {
 	const char *variant = getenv("GIT_SSH_VARIANT");
 
-	if (!variant && git_config_get_string_tmp("ssh.variant", &variant))
+	if (!variant && repo_config_get_string_tmp(the_repository, "ssh.variant", &variant))
 		return;
 
 	if (!strcmp(variant, "auto"))
diff --git a/editor.c b/editor.c
index b79d97b0e72..fd174e6a034 100644
--- a/editor.c
+++ b/editor.c
@@ -50,7 +50,7 @@ const char *git_sequence_editor(void)
 	const char *editor = getenv("GIT_SEQUENCE_EDITOR");
 
 	if (!editor)
-		git_config_get_string_tmp("sequence.editor", &editor);
+		repo_config_get_string_tmp(the_repository, "sequence.editor", &editor);
 	if (!editor)
 		editor = git_editor();
 
diff --git a/help.c b/help.c
index db62cda4442..bb20498cfd0 100644
--- a/help.c
+++ b/help.c
@@ -417,7 +417,7 @@ void list_cmds_by_config(struct string_list *list)
 {
 	const char *cmd_list;
 
-	if (git_config_get_string_tmp("completion.commands", &cmd_list))
+	if (repo_config_get_string_tmp(the_repository, "completion.commands", &cmd_list))
 		return;
 
 	string_list_sort(list);
diff --git a/promisor-remote.c b/promisor-remote.c
index be6f82d12f8..a9c877d9cfa 100644
--- a/promisor-remote.c
+++ b/promisor-remote.c
@@ -327,7 +327,7 @@ static void promisor_info_vecs(struct repository *repo,
 		char *url_key = xstrfmt("remote.%s.url", r->name);
 
 		/* Only add remotes with a non empty URL */
-		if (!git_config_get_string_tmp(url_key, &url) && *url) {
+		if (!repo_config_get_string_tmp(the_repository, url_key, &url) && *url) {
 			strvec_push(names, r->name);
 			strvec_push(urls, url);
 		}
@@ -433,7 +433,7 @@ static void filter_promisor_remote(struct repository *repo,
 	struct strvec names = STRVEC_INIT;
 	struct strvec urls = STRVEC_INIT;
 
-	if (!git_config_get_string_tmp("promisor.acceptfromserver", &accept_str)) {
+	if (!repo_config_get_string_tmp(the_repository, "promisor.acceptfromserver", &accept_str)) {
 		if (!*accept_str || !strcasecmp("None", accept_str))
 			accept = ACCEPT_NONE;
 		else if (!strcasecmp("KnownUrl", accept_str))
diff --git a/protocol.c b/protocol.c
index bae7226ff40..65f66217021 100644
--- a/protocol.c
+++ b/protocol.c
@@ -24,7 +24,7 @@ enum protocol_version get_protocol_version_config(void)
 	const char *git_test_k = "GIT_TEST_PROTOCOL_VERSION";
 	const char *git_test_v;
 
-	if (!git_config_get_string_tmp("protocol.version", &value)) {
+	if (!repo_config_get_string_tmp(the_repository, "protocol.version", &value)) {
 		enum protocol_version version = parse_protocol_version(value);
 
 		if (version == protocol_unknown_version)
diff --git a/remote.c b/remote.c
index e965f022f12..88f991795b2 100644
--- a/remote.c
+++ b/remote.c
@@ -734,7 +734,7 @@ static void validate_remote_url(struct remote *remote)
 	struct strbuf redacted = STRBUF_INIT;
 	int warn_not_die;
 
-	if (git_config_get_string_tmp("transfer.credentialsinurl", &value))
+	if (repo_config_get_string_tmp(the_repository, "transfer.credentialsinurl", &value))
 		return;
 
 	if (!strcmp("warn", value))
diff --git a/sideband.c b/sideband.c
index 251e9615ed0..8f15b98a654 100644
--- a/sideband.c
+++ b/sideband.c
@@ -39,9 +39,9 @@ static int use_sideband_colors(void)
 	if (use_sideband_colors_cached >= 0)
 		return use_sideband_colors_cached;
 
-	if (!git_config_get_string_tmp(key, &value))
+	if (!repo_config_get_string_tmp(the_repository, key, &value))
 		use_sideband_colors_cached = git_config_colorbool(key, value);
-	else if (!git_config_get_string_tmp("color.ui", &value))
+	else if (!repo_config_get_string_tmp(the_repository, "color.ui", &value))
 		use_sideband_colors_cached = git_config_colorbool("color.ui", value);
 	else
 		use_sideband_colors_cached = GIT_COLOR_AUTO;
@@ -49,7 +49,7 @@ static int use_sideband_colors(void)
 	for (i = 0; i < ARRAY_SIZE(keywords); i++) {
 		strbuf_reset(&sb);
 		strbuf_addf(&sb, "%s.%s", key, keywords[i].keyword);
-		if (git_config_get_string_tmp(sb.buf, &value))
+		if (repo_config_get_string_tmp(the_repository, sb.buf, &value))
 			continue;
 		color_parse(value, keywords[i].color);
 	}
diff --git a/t/helper/test-config.c b/t/helper/test-config.c
index 1953ab846e4..30e70f1a6c2 100644
--- a/t/helper/test-config.c
+++ b/t/helper/test-config.c
@@ -171,7 +171,7 @@ int cmd__config(int argc, const char **argv)
 			goto exit1;
 		}
 	} else if (argc == 3 && !strcmp(argv[1], "get_string")) {
-		if (!git_config_get_string_tmp(argv[2], &v)) {
+		if (!repo_config_get_string_tmp(the_repository, argv[2], &v)) {
 			printf("%s\n", v);
 			goto exit0;
 		} else {

-- 
2.50.1.465.gcb3da1c9e6.dirty

