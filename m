Received: from fhigh-a4-smtp.messagingengine.com (fhigh-a4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC0C72F5C5F
	for <git@vger.kernel.org>; Wed, 23 Jul 2025 14:09:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753279764; cv=none; b=t4Ghm8J6OdZPXLmx9WLWs5MCVW6+82O21gUujzOH9WRnqK0Zblpcy/0AVVxqWb2DhX+6xZKmFCycivnMQg4S+4Qjhos3D90Y/FXweExmJLZDhCN5SiDp+RY9cgIv34tV7aeQhNM8zOG/OMVYhUMHyTkBosAU3N4izMrXDS0UjjI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753279764; c=relaxed/simple;
	bh=8XaiCpb8v0qzlC9k1OsR1cXU7VAmVyJ/9mUAK9z8HDQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Lq9VWQ8mjsmh2Hq0OI7bUc8JMEoe4YsNiZIny5pj4is40qMIBspO+7lR6PGgj0GYlobgWB3JQLr3C7KL8CIlosIcNdbA64McgnYf2go7AZL1LBuG/OJGrcFfXfnbxD4oNhTBAwsJ4tplKBwtAnhjd4rCwrKIcrxRlruOVcj16XI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Fy1erMwR; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=iHwvpmzl; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Fy1erMwR";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="iHwvpmzl"
Received: from phl-compute-09.internal (phl-compute-09.phl.internal [10.202.2.49])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 1B7E01402046;
	Wed, 23 Jul 2025 10:09:21 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-09.internal (MEProxy); Wed, 23 Jul 2025 10:09:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1753279761;
	 x=1753366161; bh=w6xAyA2uom1kxy2iT1YeYmBKwWszlIRCg1h2E5C6vhc=; b=
	Fy1erMwRHb27IpO3OAqSwPekIL+imvrrjTcTkYwJulQGqT1psMImOdKR/VyRopT2
	+FFxbDgrer2FlNi3BHtxzGbQj2LFiS9mvrBf2dDbKHK1T/kuDp1Tk2QBtPdvnWGX
	1tuIHzEyHiVfkIJYoD6la8JeeK/BCK+OuyWpYE2Bn09HtsueiJt8QVw0eEvmcY0o
	XB+/V2GTGx3DypJFnnNjOgphMyVf2rL2U2iX5g8rmoh9IVUYzH9V+gY1FtblJkRp
	r3tUqBwquH6OigQySk20OxwifzaMfHF3SCA4J1SCxYnJh74cWJEJMnbUivbCgyKk
	G9yie/I8JzKkApnWJ+Adeg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1753279761; x=
	1753366161; bh=w6xAyA2uom1kxy2iT1YeYmBKwWszlIRCg1h2E5C6vhc=; b=i
	HwvpmzlYUTNW7IhRGHBtKE7VieEM6LRQwfGgXVt3CPZ028Y0DG4p+s/j1+1unX4T
	9iVC9+sIwaxfrtRX1CQMgLoFmZvmVhD4Ewo6Ep6XEAA10thcykD8UYUI6C9bX9U6
	6XP5C1oldv6n6wss325JDkHGIUQtVfwdhC8IEwFiq99VteuOoRRUwqWDtQncpPir
	rXOs6pBT+BeEEPZeYDB61/3LbN6blR5EymZEuWQdcmbeF03MelCMzQYU8Rhr7XCY
	EKMSIwr0qo+p/L9QwP+bhDblp28AjqthFY1q5mTVROxlzOXmdSTrXj4ltI4qEIvk
	MqWfOld2SeztXXLBTWBzQ==
X-ME-Sender: <xms:EO2AaDXWdvGy_W9Ucy_JtsFuJcboD8KzsjCHYhQVt88kOR02Jws2Bw>
    <xme:EO2AaLzIMTdAGbiT2EB8XScZOHPbahlr5XK5hUQNaxUxlezfJY-REsPGrc5vJNZRg
    g0ertJwTBHbhXi6LQ>
X-ME-Received: <xmr:EO2AaBOptXco3yYhlJgJ6z35k_vzUATsB7_bSaVOqsutk3iMHkZ8Gi4M0uQrqrgn1j4B2BDFYnq_xkmzjUtOEd1HwkEqimIFVfbocjl4rnf1>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdejjeelkecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhfffugggtgffkfhgjvfevofesthejredtredtjeenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epffeuiedujedvkeehuedvkeefffeivdeuleetkeduheejteekgedvudfgtdfgieelnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimhdpnhgspghrtghpthhtohepvddpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepphhhihhllhhiphdrfihoohguuddvfeesghhmrghilhdrtghomhdprhgtphhtthhope
    hgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:EO2AaM6Mim__86jE3DizwEpPjJuPNd26AFLo4KB90uYeYY8YOvXFEQ>
    <xmx:EO2AaCPz_gdbCQ_QI35JzsFld0cZ-0L6fY3--BT8G59ZVcFV1AF4jQ>
    <xmx:EO2AaKmq18-Ut_jjbm7_0dQsxYBXh4lrQ7NEuT7CHjgvb9AadsW91Q>
    <xmx:EO2AaJR3xdXut2T5o3TMn56-vPDG3BEz7XL-q4xw1u9ZL911klH-qg>
    <xmx:Ee2AaFn-zjnOzWEf05njGDiiqlHk9298gfaAYfEMg6TwzPwEWOWf6_pp>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 23 Jul 2025 10:09:20 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 5a6e34f3 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Wed, 23 Jul 2025 14:09:19 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Wed, 23 Jul 2025 16:08:37 +0200
Subject: [PATCH v2 16/21] config: drop
 `git_config_set_multivar_in_file_gently()` wrapper
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250723-pks-config-wo-the-repository-v2-16-1502d60d3867@pks.im>
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
2.50.1.552.g942d659e1b.dirty

