Received: from fhigh-a4-smtp.messagingengine.com (fhigh-a4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED4412F5C5C
	for <git@vger.kernel.org>; Wed, 23 Jul 2025 14:09:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753279761; cv=none; b=cua3ImlYEc9Mm2n+3avqkrw7HjvMkOJW06smF810sarzqgyy6IUplwpzcsb6fom0GmpSYyHX5MpZ3FyZTIDTtAXT2BDmOpTE9KGj1Mc6Mq+xz25M8umvzFTkvcVFcexozlcC7R1zJ5l6CLj78lNnbtC8gw518YH/DsxcSefXfMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753279761; c=relaxed/simple;
	bh=VsfXG5MkTz1Xu0xVRf3RZ1iTJwqtVdQUxO76aYENGUQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=h9je/OVAgNFZ9IHXbVAcqcpnuQLMYMHpK1U5wZVQXKGn5lQyOg0N5njZ1YFnXYsk7nhMpi+NnXGv5gejRozQ/q49vLCZ8ArFIfuvW/Cx1Ivwsp9hGK10QJWkRBbj6AD1x49hT4e2il8wLJNarCim8WnyBYcg9lO6AVc7g1qZF08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=YH2Hy57d; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=lxD/2xxW; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="YH2Hy57d";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="lxD/2xxW"
Received: from phl-compute-12.internal (phl-compute-12.phl.internal [10.202.2.52])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 28E3C1402004;
	Wed, 23 Jul 2025 10:09:18 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-12.internal (MEProxy); Wed, 23 Jul 2025 10:09:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1753279758;
	 x=1753366158; bh=t+QJvtOT7IBmjJUUZodnscsCTfg/SUVUfqwiB3xH2bs=; b=
	YH2Hy57dUl8ynNm50klbPtK5FuggkSdmrBlxUEKKtnKIwu3ds2/BnylBluX5QM+G
	3iRfZOoF8ctNcd4UitldpY+QJxN1DcB50i1Tcs2QnzjHrBH87NFck+e60RID1GXF
	agoC6icrwEkRPLwZxcu+k326eTNm3Us4DhnSCpT6EP1T1sy/vPpioMb8VFkl12Lo
	/vAg2lLmywhufNwk/nxzlXhJgi258jghB18GYuBb+nPvZss3ejFUkCuAzrAgSpfj
	Ef5M9uwgQ9+7FNzUNNC/W38nQ9gXeseWtvo9aYWMSWv8Lx9hNSx8saUrWHjv0o3b
	VgGtRCmomQrOPE6brVEEyQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1753279758; x=
	1753366158; bh=t+QJvtOT7IBmjJUUZodnscsCTfg/SUVUfqwiB3xH2bs=; b=l
	xD/2xxWFx0xj1vg5joHtzuWXfnaVojVdXfTkz0u5fqX5NJGpYFs4vuB1XNkhU1Dq
	renwEV6wwmLjqiRKldAmcy4xT4kYaEBo145iLOLo8iFNEOwNS3raawfQGlcvudFT
	bUbNqZeSDMN7mZOSattxZ+RnbeZmINd1weOHR4b62VS6pZm0Nmjaerrobk82PvIo
	HRo3pQoR99bRkdia7zcsWGwrnA+vvMJkbxW49mOvvUvxJ13k44imS++LpuHHszdA
	ZXKz0RgiiBqR6XF/SRT92z5/APeRV6kfnEQxpB+WCoHJnot1qIZEzp2gA9NDdnMF
	RmQR/dcpzocpUTvBSIEAA==
X-ME-Sender: <xms:De2AaEHapKWPO4gr38yqbjBWF4t5y_7XHyadL_ftjdCSp38PzGlZ6Q>
    <xme:De2AaNhJfGlVxdgq1DjJNNI9u7F1XI0iajHoPGAWhKWrFe23k6tcVoPzMawrp2gmy
    Z7wkVueK3cNn46Jeg>
X-ME-Received: <xmr:De2AaP_JPR8HP1-k5RahOzOJULcovvj94FkaIje7wuJjn89t0yqiNwW_ouGyOKay7TJhznknrQJVPeC1KuCpSC3bTkoBSiTizUgI7oPcFOkj>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdejjeelkecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhfffugggtgffkfhgjvfevofesthejredtredtjeenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epffeuiedujedvkeehuedvkeefffeivdeuleetkeduheejteekgedvudfgtdfgieelnecu
    vehluhhsthgvrhfuihiivgepfeenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimhdpnhgspghrtghpthhtohepvddpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehphhhilhhlih
    hprdifohhougduvdefsehgmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:Du2AaEqZpBMEbxbDSYY6eN8GnpzaurG02ugF4PFK9I1oQ3IvilOzaQ>
    <xmx:Du2AaO-rnVjwvPIX8fFj1Mpe9pWjjYueIX8SK464RE6s9zjIazOTgw>
    <xmx:Du2AaIWhgwFd3oP-o90K0dsHsHBeY7jC4J3B__3HeNWsT-87FUpkjw>
    <xmx:Du2AaEA7l9Yp-OiBi7t0Gn5mZ5h09R1YQHzt3Ck-Pc6Uqb_OE26hWw>
    <xmx:Du2AaCVjoSibJf_eXep6Gm7rwX0b4tfDz1iYWOPb0yNy8u0OsKR1OucS>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 23 Jul 2025 10:09:17 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 0916b9e6 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Wed, 23 Jul 2025 14:09:16 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Wed, 23 Jul 2025 16:08:36 +0200
Subject: [PATCH v2 15/21] config: drop `git_config_set_in_file_gently()`
 wrapper
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250723-pks-config-wo-the-repository-v2-15-1502d60d3867@pks.im>
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

Follow through with that intent and remove
`git_config_set_in_file_gently()`. All callsites are adjusted so that
they use `repo_config_set_in_file_gently(the_repository, ...)` instead.
While some callsites might already have a repository available, this
mechanical conversion is the exact same as the current situation and
thus cannot cause any regression. Those sites should eventually be
cleaned up in a later patch series.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/config.c            | 14 +++++++-------
 builtin/submodule--helper.c |  2 +-
 builtin/worktree.c          |  4 ++--
 config.h                    | 10 ----------
 sequencer.c                 | 28 ++++++++++++++--------------
 submodule-config.c          |  2 +-
 submodule.c                 |  2 +-
 worktree.c                  |  4 ++--
 8 files changed, 28 insertions(+), 38 deletions(-)

diff --git a/builtin/config.c b/builtin/config.c
index af5d79eadc0..f7e718c6702 100644
--- a/builtin/config.c
+++ b/builtin/config.c
@@ -970,8 +970,8 @@ static int cmd_config_set(int argc, const char **argv, const char *prefix,
 							     argv[0], value, value_pattern,
 							     comment, flags);
 	} else {
-		ret = git_config_set_in_file_gently(location_opts.source.file,
-						    argv[0], comment, value);
+		ret = repo_config_set_in_file_gently(the_repository, location_opts.source.file,
+						     argv[0], comment, value);
 		if (ret == CONFIG_NOTHING_SET)
 			error(_("cannot overwrite multiple values with a single value\n"
 			"       Use a regexp, --add or --replace-all to change %s."), argv[0]);
@@ -1014,8 +1014,8 @@ static int cmd_config_unset(int argc, const char **argv, const char *prefix,
 							     argv[0], NULL, value_pattern,
 							     NULL, flags);
 	else
-		ret = git_config_set_in_file_gently(location_opts.source.file, argv[0],
-						    NULL, NULL);
+		ret = repo_config_set_in_file_gently(the_repository, location_opts.source.file, argv[0],
+						     NULL, NULL);
 
 	location_options_release(&location_opts);
 	return ret;
@@ -1296,7 +1296,7 @@ static int cmd_config_actions(int argc, const char **argv, const char *prefix)
 		check_write(&location_opts.source);
 		check_argc(argc, 2, 2);
 		value = normalize_value(argv[0], argv[1], display_opts.type, &default_kvi);
-		ret = git_config_set_in_file_gently(location_opts.source.file, argv[0], comment, value);
+		ret = repo_config_set_in_file_gently(the_repository, location_opts.source.file, argv[0], comment, value);
 		if (ret == CONFIG_NOTHING_SET)
 			error(_("cannot overwrite multiple values with a single value\n"
 			"       Use a regexp, --add or --replace-all to change %s."), argv[0]);
@@ -1354,8 +1354,8 @@ static int cmd_config_actions(int argc, const char **argv, const char *prefix)
 								     argv[0], NULL, argv[1],
 								     NULL, flags);
 		else
-			ret = git_config_set_in_file_gently(location_opts.source.file,
-							    argv[0], NULL, NULL);
+			ret = repo_config_set_in_file_gently(the_repository, location_opts.source.file,
+							     argv[0], NULL, NULL);
 	}
 	else if (actions == ACTION_UNSET_ALL) {
 		check_write(&location_opts.source);
diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index 710a2a2004e..28f34f7bc18 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -1280,7 +1280,7 @@ static void sync_submodule(const char *path, const char *prefix,
 	submodule_to_gitdir(the_repository, &sb, path);
 	strbuf_addstr(&sb, "/config");
 
-	if (git_config_set_in_file_gently(sb.buf, remote_key, NULL, sub_origin_url))
+	if (repo_config_set_in_file_gently(the_repository, sb.buf, remote_key, NULL, sub_origin_url))
 		die(_("failed to update remote for submodule '%s'"),
 		      path);
 
diff --git a/builtin/worktree.c b/builtin/worktree.c
index b1306248dec..fd517c82c44 100644
--- a/builtin/worktree.c
+++ b/builtin/worktree.c
@@ -384,8 +384,8 @@ static void copy_filtered_worktree_config(const char *worktree_git_dir)
 			error(_("failed to unset '%s' in '%s'"),
 				"core.bare", to_file);
 		if (!git_configset_get(&cs, "core.worktree") &&
-			git_config_set_in_file_gently(to_file,
-							"core.worktree", NULL, NULL))
+			repo_config_set_in_file_gently(the_repository, to_file,
+						       "core.worktree", NULL, NULL))
 			error(_("failed to unset '%s' in '%s'"),
 				"core.worktree", to_file);
 
diff --git a/config.h b/config.h
index 43d06c279e3..4e658e47f0a 100644
--- a/config.h
+++ b/config.h
@@ -734,16 +734,6 @@ static inline int git_config_get_pathname(const char *key, char **dest)
 	return repo_config_get_pathname(the_repository, key, dest);
 }
 
-static inline int git_config_set_in_file_gently(
-	const char *config_filename,
-	const char *key,
-	const char *comment,
-	const char *value)
-{
-	return repo_config_set_in_file_gently(the_repository, config_filename,
-					      key, comment, value);
-}
-
 static inline int git_config_set_multivar_in_file_gently(
 	const char *config_filename,
 	const char *key, const char *value,
diff --git a/sequencer.c b/sequencer.c
index f8d9bb69df8..8acb699f4f2 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -3650,57 +3650,57 @@ static int save_opts(struct replay_opts *opts)
 	int res = 0;
 
 	if (opts->no_commit)
-		res |= git_config_set_in_file_gently(opts_file,
+		res |= repo_config_set_in_file_gently(the_repository, opts_file,
 					"options.no-commit", NULL, "true");
 	if (opts->edit >= 0)
-		res |= git_config_set_in_file_gently(opts_file, "options.edit", NULL,
+		res |= repo_config_set_in_file_gently(the_repository, opts_file, "options.edit", NULL,
 						     opts->edit ? "true" : "false");
 	if (opts->allow_empty)
-		res |= git_config_set_in_file_gently(opts_file,
+		res |= repo_config_set_in_file_gently(the_repository, opts_file,
 					"options.allow-empty", NULL, "true");
 	if (opts->allow_empty_message)
-		res |= git_config_set_in_file_gently(opts_file,
+		res |= repo_config_set_in_file_gently(the_repository, opts_file,
 				"options.allow-empty-message", NULL, "true");
 	if (opts->drop_redundant_commits)
-		res |= git_config_set_in_file_gently(opts_file,
+		res |= repo_config_set_in_file_gently(the_repository, opts_file,
 				"options.drop-redundant-commits", NULL, "true");
 	if (opts->keep_redundant_commits)
-		res |= git_config_set_in_file_gently(opts_file,
+		res |= repo_config_set_in_file_gently(the_repository, opts_file,
 				"options.keep-redundant-commits", NULL, "true");
 	if (opts->signoff)
-		res |= git_config_set_in_file_gently(opts_file,
+		res |= repo_config_set_in_file_gently(the_repository, opts_file,
 					"options.signoff", NULL, "true");
 	if (opts->record_origin)
-		res |= git_config_set_in_file_gently(opts_file,
+		res |= repo_config_set_in_file_gently(the_repository, opts_file,
 					"options.record-origin", NULL, "true");
 	if (opts->allow_ff)
-		res |= git_config_set_in_file_gently(opts_file,
+		res |= repo_config_set_in_file_gently(the_repository, opts_file,
 					"options.allow-ff", NULL, "true");
 	if (opts->mainline) {
 		struct strbuf buf = STRBUF_INIT;
 		strbuf_addf(&buf, "%d", opts->mainline);
-		res |= git_config_set_in_file_gently(opts_file,
+		res |= repo_config_set_in_file_gently(the_repository, opts_file,
 					"options.mainline", NULL, buf.buf);
 		strbuf_release(&buf);
 	}
 	if (opts->strategy)
-		res |= git_config_set_in_file_gently(opts_file,
+		res |= repo_config_set_in_file_gently(the_repository, opts_file,
 					"options.strategy", NULL, opts->strategy);
 	if (opts->gpg_sign)
-		res |= git_config_set_in_file_gently(opts_file,
+		res |= repo_config_set_in_file_gently(the_repository, opts_file,
 					"options.gpg-sign", NULL, opts->gpg_sign);
 	for (size_t i = 0; i < opts->xopts.nr; i++)
 		res |= git_config_set_multivar_in_file_gently(opts_file,
 				"options.strategy-option",
 				opts->xopts.v[i], "^$", NULL, 0);
 	if (opts->allow_rerere_auto)
-		res |= git_config_set_in_file_gently(opts_file,
+		res |= repo_config_set_in_file_gently(the_repository, opts_file,
 				"options.allow-rerere-auto", NULL,
 				opts->allow_rerere_auto == RERERE_AUTOUPDATE ?
 				"true" : "false");
 
 	if (opts->explicit_cleanup)
-		res |= git_config_set_in_file_gently(opts_file,
+		res |= repo_config_set_in_file_gently(the_repository, opts_file,
 				"options.default-msg-cleanup", NULL,
 				describe_cleanup_mode(opts->default_msg_cleanup));
 	return res;
diff --git a/submodule-config.c b/submodule-config.c
index 70324da3830..1f19fe20774 100644
--- a/submodule-config.c
+++ b/submodule-config.c
@@ -983,7 +983,7 @@ int config_set_in_gitmodules_file_gently(const char *key, const char *value)
 {
 	int ret;
 
-	ret = git_config_set_in_file_gently(GITMODULES_FILE, key, NULL, value);
+	ret = repo_config_set_in_file_gently(the_repository, GITMODULES_FILE, key, NULL, value);
 	if (ret < 0)
 		/* Maybe the user already did that, don't error out here */
 		warning(_("Could not update .gitmodules entry %s"), key);
diff --git a/submodule.c b/submodule.c
index f8373a9ea7d..fff3c755703 100644
--- a/submodule.c
+++ b/submodule.c
@@ -2058,7 +2058,7 @@ void submodule_unset_core_worktree(const struct submodule *sub)
 	submodule_name_to_gitdir(&config_path, the_repository, sub->name);
 	strbuf_addstr(&config_path, "/config");
 
-	if (git_config_set_in_file_gently(config_path.buf, "core.worktree", NULL, NULL))
+	if (repo_config_set_in_file_gently(the_repository, config_path.buf, "core.worktree", NULL, NULL))
 		warning(_("Could not unset core.worktree setting in submodule '%s'"),
 			  sub->path);
 
diff --git a/worktree.c b/worktree.c
index 981a2713374..a2a5f51f29f 100644
--- a/worktree.c
+++ b/worktree.c
@@ -991,9 +991,9 @@ int should_prune_worktree(const char *id, struct strbuf *reason, char **wtpath,
 static int move_config_setting(const char *key, const char *value,
 			       const char *from_file, const char *to_file)
 {
-	if (git_config_set_in_file_gently(to_file, key, NULL, value))
+	if (repo_config_set_in_file_gently(the_repository, to_file, key, NULL, value))
 		return error(_("unable to set %s in '%s'"), key, to_file);
-	if (git_config_set_in_file_gently(from_file, key, NULL, NULL))
+	if (repo_config_set_in_file_gently(the_repository, from_file, key, NULL, NULL))
 		return error(_("unable to unset %s in '%s'"), key, from_file);
 	return 0;
 }

-- 
2.50.1.552.g942d659e1b.dirty

