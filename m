Received: from fhigh-b5-smtp.messagingengine.com (fhigh-b5-smtp.messagingengine.com [202.12.124.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 004C029ACE5
	for <git@vger.kernel.org>; Thu, 17 Jul 2025 10:50:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752749423; cv=none; b=ZYEhY6FlONaprTlDxjQSDO1hxAG6tfS7yBuYQX61OklfOP9IWDKZUnKtqPQETJBQtOXudj/kd8rqzgCdVX/TpwDFBx8bpddA2LX0A+S4Jo/Ox0wK5u+cKnwr848jGERHXiLfNKn6cLYz8WlNiHTq0yy+8oSwbU8in+2lgXRmarY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752749423; c=relaxed/simple;
	bh=6yKu2rbDC+ypcli3THZ4vJNNoePzSZH/wl0GvmbNkkc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=AH4aTcrUOtgSQ+7L3jkLg2BzpjPBLbFKm18TGcbwYmwD7SpMKSh+RnY9bzjgXLIN0z7vE0d/3NJ51FlffWLEVYwa63YZmq9rWKdegqU7YvFwNpka75AyYqopB36vZdEsSkhKrG88+yC1Xw/G5ikPHTxDsaHz+02bnaTLdRlT8NQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=vCEwoX4i; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=KMYGqHiS; arc=none smtp.client-ip=202.12.124.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="vCEwoX4i";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="KMYGqHiS"
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 1B4A87A0200
	for <git@vger.kernel.org>; Thu, 17 Jul 2025 06:50:21 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Thu, 17 Jul 2025 06:50:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1752749420;
	 x=1752835820; bh=ASmoTdCW8LrnqDJamJ8MpEwfqkCO2L6gbUoqq/81tu0=; b=
	vCEwoX4iEAePZjhtSo8M9cj695+bxi5+deUQnFQoRGMP7d6ro69+rvTFtvr2ZPXB
	0TlOhA6Cvf76AcKSXiQ7hXA42NNd/E8R8XfSgqcuptnel3tliAZ0y/tVmYWYkmDG
	o6M83/jHPbRYc4Z23+tXkfcE4gzAOB2sdHrh2No+ezwPfwE7fm1YdbxsO/n98QFU
	rl/6pHGXUMe/ardDtgHvcI2aMbHHwncOmh90ZKrP1sGfiRgafn71gbj87zwBkis0
	d2bHKQ72BuER6UzqLMwbK7vfz0m4lx0X+kPw2KOAUXJmnu83KqsSMcf9ZMFFDVGd
	YUb5wp63d2qV8A6mKrEG+g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1752749420; x=
	1752835820; bh=ASmoTdCW8LrnqDJamJ8MpEwfqkCO2L6gbUoqq/81tu0=; b=K
	MYGqHiSBicdhyTcZyxVaUxpQCDlTDocpdPQdtA+PnAbioC1Do40H3jDyv3HvMkoR
	po8KVJTHKqGgSeqpZ02a8Pc8DYFN/oVhItfQ1MRK6/bYtxWbPtHMxi16xYG2PQuM
	DCAJ/u4CUBuC4I4O81FMJCG+caXnnk1R6l/3LFBHj41rgYB16BV0l71T31A+RcmO
	eWMIbklxdcM3T2rxE3uNfSDq8j+S62nAK+3I/cz2Ega9KYML2s5XDS8KMo/Cblxd
	4rAyMW3e/Nie4bP9vNs3JN6iHdFhy+gd9GjV7sAYJPzEhxfCtjsZDi6sJryWQYHS
	2qfkrJz06CkGXBopjCFZw==
X-ME-Sender: <xms:bNV4aDsj7c66toTR8HOSaHKDEYEkxty8_xeGTYjhnkrfo-0LrFkEoA>
    <xme:bNV4aGdtJUmYM2qGAGiFkTHRVqF7Wb7z6Dl8EWzrgSbgfYdCpGbDOB0vTsk5NUFuH
    LJvqgdKS3cBP3-MAw>
X-ME-Received: <xmr:bNV4aAKgo1oojDa1RI8eAtcQSDpvVUO1juQdULkvqtcEUIX7NwKVc8et823DJMFNnbUnQbYmnhJug579vBC1rgSDcJUizsQie82IiGNa3hPa>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdeitdeflecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecunecujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertd
    ertdejnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhk
    shdrihhmqeenucggtffrrghtthgvrhhnpeffueeiudejvdekheeuvdekfeffiedvueelte
    ekudehjeetkeegvddugfdtgfeileenucevlhhushhtvghrufhiiigvpedunecurfgrrhgr
    mhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopedupdhmoh
    guvgepshhmthhpohhuthdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdho
    rhhg
X-ME-Proxy: <xmx:bNV4aEbiaXikDeMWbafHQdzN58Z3tH-CxqhtEreNrYSdQvIvM8BWkg>
    <xmx:bNV4aLsok3RHq0wl2Uf3ybsrvLTE-4RwH_8qsqv5phmeX2fWr05IBQ>
    <xmx:bNV4aBtjo5580dT_V19Pz0w-_lrb2OKoT0sQnpYAiOkVZJi_3_UROA>
    <xmx:bNV4aAcUE_YAj_jN1dEEh_VJQRRs9PmbNNGP1cpEvoBYrUJp69DvHQ>
    <xmx:bNV4aLUkigCly1uH-FxzNzpxMVZV6pNtL23WJ5JcEH0HTxRRTecmXAKN>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Thu, 17 Jul 2025 06:50:20 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id f1332973 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO)
	for <git@vger.kernel.org>;
	Thu, 17 Jul 2025 10:50:19 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Thu, 17 Jul 2025 12:49:36 +0200
Subject: [PATCH 16/21] config: drop
 `git_config_set_multivar_in_file_gently()` wrapper
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250717-pks-config-wo-the-repository-v1-16-d888e4a17de1@pks.im>
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

Follow through with that intent and remove
`git_config_set_multivar_in_file_gently()`. All callsites are adjusted
so that they use
`repo_config_set_multivar_in_file_gently(the_repository, ...)` instead.
While some callsites might already have a repository available, this
mechanical conversion is the exact same as the current situation and
thus cannot cause any regression. Those sites should eventually be
cleaned up in a later patch series.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/config.c   | 44 ++++++++++++++++++++++----------------------
 builtin/gc.c       |  4 ++--
 builtin/worktree.c |  2 +-
 config.h           | 12 ------------
 sequencer.c        |  2 +-
 5 files changed, 26 insertions(+), 38 deletions(-)

diff --git a/builtin/config.c b/builtin/config.c
index f7e718c6702..59fb113b073 100644
--- a/builtin/config.c
+++ b/builtin/config.c
@@ -966,9 +966,9 @@ static int cmd_config_set(int argc, const char **argv, const char *prefix,
 	value = normalize_value(argv[0], argv[1], type, &default_kvi);
 
 	if ((flags & CONFIG_FLAGS_MULTI_REPLACE) || value_pattern) {
-		ret = git_config_set_multivar_in_file_gently(location_opts.source.file,
-							     argv[0], value, value_pattern,
-							     comment, flags);
+		ret = repo_config_set_multivar_in_file_gently(the_repository, location_opts.source.file,
+							      argv[0], value, value_pattern,
+							      comment, flags);
 	} else {
 		ret = repo_config_set_in_file_gently(the_repository, location_opts.source.file,
 						     argv[0], comment, value);
@@ -1010,9 +1010,9 @@ static int cmd_config_unset(int argc, const char **argv, const char *prefix,
 	check_write(&location_opts.source);
 
 	if ((flags & CONFIG_FLAGS_MULTI_REPLACE) || value_pattern)
-		ret = git_config_set_multivar_in_file_gently(location_opts.source.file,
-							     argv[0], NULL, value_pattern,
-							     NULL, flags);
+		ret = repo_config_set_multivar_in_file_gently(the_repository, location_opts.source.file,
+							      argv[0], NULL, value_pattern,
+							      NULL, flags);
 	else
 		ret = repo_config_set_in_file_gently(the_repository, location_opts.source.file, argv[0],
 						     NULL, NULL);
@@ -1305,26 +1305,26 @@ static int cmd_config_actions(int argc, const char **argv, const char *prefix)
 		check_write(&location_opts.source);
 		check_argc(argc, 2, 3);
 		value = normalize_value(argv[0], argv[1], display_opts.type, &default_kvi);
-		ret = git_config_set_multivar_in_file_gently(location_opts.source.file,
-							     argv[0], value, argv[2],
-							     comment, flags);
+		ret = repo_config_set_multivar_in_file_gently(the_repository, location_opts.source.file,
+							      argv[0], value, argv[2],
+							      comment, flags);
 	}
 	else if (actions == ACTION_ADD) {
 		check_write(&location_opts.source);
 		check_argc(argc, 2, 2);
 		value = normalize_value(argv[0], argv[1], display_opts.type, &default_kvi);
-		ret = git_config_set_multivar_in_file_gently(location_opts.source.file,
-							     argv[0], value,
-							     CONFIG_REGEX_NONE,
-							     comment, flags);
+		ret = repo_config_set_multivar_in_file_gently(the_repository, location_opts.source.file,
+							      argv[0], value,
+							      CONFIG_REGEX_NONE,
+							      comment, flags);
 	}
 	else if (actions == ACTION_REPLACE_ALL) {
 		check_write(&location_opts.source);
 		check_argc(argc, 2, 3);
 		value = normalize_value(argv[0], argv[1], display_opts.type, &default_kvi);
-		ret = git_config_set_multivar_in_file_gently(location_opts.source.file,
-							     argv[0], value, argv[2],
-							     comment, flags | CONFIG_FLAGS_MULTI_REPLACE);
+		ret = repo_config_set_multivar_in_file_gently(the_repository, location_opts.source.file,
+							      argv[0], value, argv[2],
+							      comment, flags | CONFIG_FLAGS_MULTI_REPLACE);
 	}
 	else if (actions == ACTION_GET) {
 		check_argc(argc, 1, 2);
@@ -1350,9 +1350,9 @@ static int cmd_config_actions(int argc, const char **argv, const char *prefix)
 		check_write(&location_opts.source);
 		check_argc(argc, 1, 2);
 		if (argc == 2)
-			ret = git_config_set_multivar_in_file_gently(location_opts.source.file,
-								     argv[0], NULL, argv[1],
-								     NULL, flags);
+			ret = repo_config_set_multivar_in_file_gently(the_repository, location_opts.source.file,
+								      argv[0], NULL, argv[1],
+								      NULL, flags);
 		else
 			ret = repo_config_set_in_file_gently(the_repository, location_opts.source.file,
 							     argv[0], NULL, NULL);
@@ -1360,9 +1360,9 @@ static int cmd_config_actions(int argc, const char **argv, const char *prefix)
 	else if (actions == ACTION_UNSET_ALL) {
 		check_write(&location_opts.source);
 		check_argc(argc, 1, 2);
-		ret = git_config_set_multivar_in_file_gently(location_opts.source.file,
-							     argv[0], NULL, argv[1],
-							     NULL, flags | CONFIG_FLAGS_MULTI_REPLACE);
+		ret = repo_config_set_multivar_in_file_gently(the_repository, location_opts.source.file,
+							      argv[0], NULL, argv[1],
+							      NULL, flags | CONFIG_FLAGS_MULTI_REPLACE);
 	}
 	else if (actions == ACTION_RENAME_SECTION) {
 		check_write(&location_opts.source);
diff --git a/builtin/gc.c b/builtin/gc.c
index c0fe4e73087..183798f0dc9 100644
--- a/builtin/gc.c
+++ b/builtin/gc.c
@@ -1938,7 +1938,7 @@ static int maintenance_register(int argc, const char **argv, const char *prefix,
 		}
 		if (!config_file)
 			die(_("$HOME not set"));
-		rc = git_config_set_multivar_in_file_gently(
+		rc = repo_config_set_multivar_in_file_gently(the_repository,
 			config_file, "maintenance.repo", maintpath,
 			CONFIG_REGEX_NONE, NULL, 0);
 		free(global_config_file);
@@ -2007,7 +2007,7 @@ static int maintenance_unregister(int argc, const char **argv, const char *prefi
 		}
 		if (!config_file)
 			die(_("$HOME not set"));
-		rc = git_config_set_multivar_in_file_gently(
+		rc = repo_config_set_multivar_in_file_gently(the_repository,
 			config_file, key, NULL, maintpath, NULL,
 			CONFIG_FLAGS_MULTI_REPLACE | CONFIG_FLAGS_FIXED_VALUE);
 		free(global_config_file);
diff --git a/builtin/worktree.c b/builtin/worktree.c
index fd517c82c44..812774a5ca9 100644
--- a/builtin/worktree.c
+++ b/builtin/worktree.c
@@ -379,7 +379,7 @@ static void copy_filtered_worktree_config(const char *worktree_git_dir)
 
 		if (!git_configset_get_bool(&cs, "core.bare", &bare) &&
 			bare &&
-			git_config_set_multivar_in_file_gently(
+			repo_config_set_multivar_in_file_gently(the_repository,
 				to_file, "core.bare", NULL, "true", NULL, 0))
 			error(_("failed to unset '%s' in '%s'"),
 				"core.bare", to_file);
diff --git a/config.h b/config.h
index 4e658e47f0a..e69592ada15 100644
--- a/config.h
+++ b/config.h
@@ -734,18 +734,6 @@ static inline int git_config_get_pathname(const char *key, char **dest)
 	return repo_config_get_pathname(the_repository, key, dest);
 }
 
-static inline int git_config_set_multivar_in_file_gently(
-	const char *config_filename,
-	const char *key, const char *value,
-	const char *value_pattern,
-	const char *comment,
-	unsigned flags)
-{
-	return repo_config_set_multivar_in_file_gently(the_repository, config_filename,
-						       key, value, value_pattern,
-						       comment, flags);
-}
-
 static inline void git_config_set_multivar_in_file(
 	const char *config_filename,
 	const char *key,
diff --git a/sequencer.c b/sequencer.c
index 8acb699f4f2..aaf2e4df64e 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -3690,7 +3690,7 @@ static int save_opts(struct replay_opts *opts)
 		res |= repo_config_set_in_file_gently(the_repository, opts_file,
 					"options.gpg-sign", NULL, opts->gpg_sign);
 	for (size_t i = 0; i < opts->xopts.nr; i++)
-		res |= git_config_set_multivar_in_file_gently(opts_file,
+		res |= repo_config_set_multivar_in_file_gently(the_repository, opts_file,
 				"options.strategy-option",
 				opts->xopts.v[i], "^$", NULL, 0);
 	if (opts->allow_rerere_auto)

-- 
2.50.1.465.gcb3da1c9e6.dirty

