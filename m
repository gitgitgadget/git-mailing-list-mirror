Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5058BC433EF
	for <git@archiver.kernel.org>; Thu, 30 Jun 2022 18:14:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236640AbiF3SO0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 30 Jun 2022 14:14:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236604AbiF3SOI (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 30 Jun 2022 14:14:08 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD2313D1E6
        for <git@vger.kernel.org>; Thu, 30 Jun 2022 11:14:06 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id r20so28486438wra.1
        for <git@vger.kernel.org>; Thu, 30 Jun 2022 11:14:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=BuAOV0ZU7Afp2grKZb5gtV5C/rUTELHJYczDClikMtA=;
        b=hhg3kytvX92pMJnfQaUONUL52GrCsHCmbZDiw5xN7Tu1WpXzlHyQLif0siD5QB+uIL
         eRZdxwDr+KnyOk39EdFiGmEcmW84jbU+p4nwFHa/VgjZYwcz0fxr4BLNZK+d4xvNrM/q
         76iNUdPZ2x+Mboy7sIoHy27ZPcdg8vUoglaxcOw9pwa9vfwgXBA325G4HwWVpXBDGjpK
         swx1h4JIChOHQzy6yXeuDwifblylrFA/2+40fXXtm8TdkEtb5xJZbFnq5LQdwAAyDImc
         kHhJyqw8L69tjBNgyL9vEwq6j0+gcu46dfK/ByFdPlPcS4ccMZ0sbgJoXJW/bU449uUo
         x7dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=BuAOV0ZU7Afp2grKZb5gtV5C/rUTELHJYczDClikMtA=;
        b=SIgP/56sH7lxClhIXItzxiTeweie3dguKqfVR53mDbMMk5YmWlNkpjwJbH5hjgL8Yw
         08J4RZR86aZv7e7lC96t8008BjjFxfifboSqYiHOTQHQ+OQtZMF1XlgkwGKiwbR9MAJV
         QggV2q/zRoM9WjQcZ1lz3atJvhY7XHL3gM0yp22aj391pINLnQvVFXBV0izICy7P9cca
         yBOS3m5AAg6Og5v7FtAS0VNTMKRWYfhCN/38TPQgc/Inx7T41Hh8Z1C9i8mQCdXYqxVZ
         PMtoS/d7hRq9itc+7RnmVJZQnrPPqe9CK79ckEBNPqa+zTBqAjb0m1e3sNkAesiAslyg
         T3fg==
X-Gm-Message-State: AJIora+Q3clvxizzbUaokrZuHxGOqBP8tUVFOnI+NIAbs86jX3qFhwfK
        HpSdW4HJfb8Zsjfhp4T24GhJo616Ho4=
X-Google-Smtp-Source: AGRyM1soc3EspeF61OM7mEUwSGCv+3Sn6adwvAwjQNjCmGu0DZ7UxEiTH/wnxqXwOuXh1lu0eviGDQ==
X-Received: by 2002:a5d:5405:0:b0:21b:b8a4:2482 with SMTP id g5-20020a5d5405000000b0021bb8a42482mr10158593wrv.452.1656612844919;
        Thu, 30 Jun 2022 11:14:04 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id u20-20020a05600c19d400b0039c4f53c4fdsm4332061wmq.45.2022.06.30.11.14.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jun 2022 11:14:04 -0700 (PDT)
Message-Id: <3efe282e6b94c3daed77590c5f601fad34137c9c.1656612839.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1261.v6.git.git.1656612839.gitgitgadget@gmail.com>
References: <pull.1261.v5.git.git.1656354994.gitgitgadget@gmail.com>
        <pull.1261.v6.git.git.1656612839.gitgitgadget@gmail.com>
From:   "Glen Choo via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 30 Jun 2022 18:13:57 +0000
Subject: [PATCH v6 3/5] config: learn `git_protected_config()`
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Taylor Blau <me@ttaylorr.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Derrick Stolee <derrickstolee@github.com>,
        Junio C Hamano <gitster@pobox.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Glen Choo <chooglen@google.com>,
        Glen Choo <chooglen@google.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Glen Choo <chooglen@google.com>

`uploadpack.packObjectsHook` is the only 'protected configuration only'
variable today, but we've noted that `safe.directory` and the upcoming
`discovery.bare` should also be 'protected configuration only'. So, for
consistency, we'd like to have a single implementation for protected
config.

The primary constraints are:

1. Reading from protected configuration should be as fast as possible.
   Nearly all "git" commands inside a bare repository will read both
   `safe.directory` and `discovery.bare`, so we cannot afford to be
   slow.

2. Protected config must be readable when the gitdir is not known.
   `safe.directory` and `discovery.bare` both affect repository
   discovery and the gitdir is not known at that point [1].

The chosen implementation in this commit is to read protected
configuration and cache the values in a global configset. This is
similar to the caching behavior we get with the_repository->config.

Introduce git_protected_config(), which reads protected configuration
and caches them in the global configset protected_config. Then, refactor
`uploadpack.packObjectsHook` to use git_protected_config().

The protected configuration functions are named similarly to their
non-protected counterparts, e.g. git_protected_config_check_init() vs
git_config_check_init().

In light of constraint 1, this implementation can still be improved
since git_protected_config() iterates through every variable in
protected_config, which may still be too expensive. There exist constant
time lookup functions for non-protected configuration
(repo_config_get_*()), but for simplicity, this commit does not
implement similar functions for protected configuration.

An alternative that avoids introducing another configset is to continue
to read all config using git_config(), but only accept values that have
the correct config scope [2]. This technically fulfills constraint 2,
because git_config() simply ignores the local and worktree config when
the gitdir is not known. However, this would read incomplete config into
the_repository->config, which would need to be reset when the gitdir is
known and git_config() needs to read the local and worktree config.
Resetting the_repository->config might be reasonable while we only have
these 'protected configuration only' variables, but it's not clear
whether this extends well to future variables.

[1] In this case, we do have a candidate gitdir though, so with a little
refactoring, it might be possible to provide a gitdir.
[2] This is how `uploadpack.packObjectsHook` was implemented prior to
this commit.

Signed-off-by: Glen Choo <chooglen@google.com>
---
 config.c                     | 51 ++++++++++++++++++++++++++++++++++++
 config.h                     | 17 ++++++++++++
 t/t5544-pack-objects-hook.sh |  7 ++++-
 upload-pack.c                | 27 ++++++++++++-------
 4 files changed, 91 insertions(+), 11 deletions(-)

diff --git a/config.c b/config.c
index 9b0e9c93285..29e62f5d0ed 100644
--- a/config.c
+++ b/config.c
@@ -81,6 +81,18 @@ static enum config_scope current_parsing_scope;
 static int pack_compression_seen;
 static int zlib_compression_seen;
 
+/*
+ * Config that comes from trusted sources, namely:
+ * - system config files (e.g. /etc/gitconfig)
+ * - global config files (e.g. $HOME/.gitconfig,
+ *   $XDG_CONFIG_HOME/git)
+ * - the command line.
+ *
+ * This is declared here for code cleanliness, but unlike the other
+ * static variables, this does not hold config parser state.
+ */
+static struct config_set protected_config;
+
 static int config_file_fgetc(struct config_source *conf)
 {
 	return getc_unlocked(conf->u.file);
@@ -2378,6 +2390,11 @@ int git_configset_add_file(struct config_set *cs, const char *filename)
 	return git_config_from_file(config_set_callback, filename, cs);
 }
 
+int git_configset_add_parameters(struct config_set *cs)
+{
+	return git_config_from_parameters(config_set_callback, cs);
+}
+
 int git_configset_get_value(struct config_set *cs, const char *key, const char **value)
 {
 	const struct string_list *values = NULL;
@@ -2619,6 +2636,40 @@ int repo_config_get_pathname(struct repository *repo,
 	return ret;
 }
 
+/* Read values into protected_config. */
+static void read_protected_config(void)
+{
+	char *xdg_config = NULL, *user_config = NULL, *system_config = NULL;
+
+	git_configset_init(&protected_config);
+
+	system_config = git_system_config();
+	git_global_config(&user_config, &xdg_config);
+
+	git_configset_add_file(&protected_config, system_config);
+	git_configset_add_file(&protected_config, xdg_config);
+	git_configset_add_file(&protected_config, user_config);
+	git_configset_add_parameters(&protected_config);
+
+	free(system_config);
+	free(xdg_config);
+	free(user_config);
+}
+
+/* Ensure that protected_config has been initialized. */
+static void git_protected_config_check_init(void)
+{
+	if (protected_config.hash_initialized)
+		return;
+	read_protected_config();
+}
+
+void git_protected_config(config_fn_t fn, void *data)
+{
+	git_protected_config_check_init();
+	configset_iter(&protected_config, fn, data);
+}
+
 /* Functions used historically to read configuration from 'the_repository' */
 void git_config(config_fn_t fn, void *data)
 {
diff --git a/config.h b/config.h
index 7654f61c634..e3ff1fcf683 100644
--- a/config.h
+++ b/config.h
@@ -446,6 +446,15 @@ void git_configset_init(struct config_set *cs);
  */
 int git_configset_add_file(struct config_set *cs, const char *filename);
 
+/**
+ * Parses command line options and environment variables, and adds the
+ * variable-value pairs to the `config_set`. Returns 0 on success, or -1
+ * if there is an error in parsing. The caller decides whether to free
+ * the incomplete configset or continue using it when the function
+ * returns -1.
+ */
+int git_configset_add_parameters(struct config_set *cs);
+
 /**
  * Finds and returns the value list, sorted in order of increasing priority
  * for the configuration variable `key` and config set `cs`. When the
@@ -505,6 +514,14 @@ int repo_config_get_maybe_bool(struct repository *repo,
 int repo_config_get_pathname(struct repository *repo,
 			     const char *key, const char **dest);
 
+/*
+ * Functions for reading protected config. By definition, protected
+ * config ignores repository config, so it is unnecessary to read
+ * protected config from any `struct repository` other than
+ * the_repository.
+ */
+void git_protected_config(config_fn_t fn, void *data);
+
 /**
  * Querying For Specific Variables
  * -------------------------------
diff --git a/t/t5544-pack-objects-hook.sh b/t/t5544-pack-objects-hook.sh
index dd5f44d986f..54f54f8d2eb 100755
--- a/t/t5544-pack-objects-hook.sh
+++ b/t/t5544-pack-objects-hook.sh
@@ -56,7 +56,12 @@ test_expect_success 'hook does not run from repo config' '
 	! grep "hook running" stderr &&
 	test_path_is_missing .git/hook.args &&
 	test_path_is_missing .git/hook.stdin &&
-	test_path_is_missing .git/hook.stdout
+	test_path_is_missing .git/hook.stdout &&
+
+	# check that global config is used instead
+	test_config_global uploadpack.packObjectsHook ./hook &&
+	git clone --no-local . dst2.git 2>stderr &&
+	grep "hook running" stderr
 '
 
 test_expect_success 'hook works with partial clone' '
diff --git a/upload-pack.c b/upload-pack.c
index 3a851b36066..09f48317b02 100644
--- a/upload-pack.c
+++ b/upload-pack.c
@@ -1321,18 +1321,27 @@ static int upload_pack_config(const char *var, const char *value, void *cb_data)
 		data->advertise_sid = git_config_bool(var, value);
 	}
 
-	if (current_config_scope() != CONFIG_SCOPE_LOCAL &&
-	    current_config_scope() != CONFIG_SCOPE_WORKTREE) {
-		if (!strcmp("uploadpack.packobjectshook", var))
-			return git_config_string(&data->pack_objects_hook, var, value);
-	}
-
 	if (parse_object_filter_config(var, value, data) < 0)
 		return -1;
 
 	return parse_hide_refs_config(var, value, "uploadpack");
 }
 
+static int upload_pack_protected_config(const char *var, const char *value, void *cb_data)
+{
+	struct upload_pack_data *data = cb_data;
+
+	if (!strcmp("uploadpack.packobjectshook", var))
+		return git_config_string(&data->pack_objects_hook, var, value);
+	return 0;
+}
+
+static void get_upload_pack_config(struct upload_pack_data *data)
+{
+	git_config(upload_pack_config, data);
+	git_protected_config(upload_pack_protected_config, data);
+}
+
 void upload_pack(const int advertise_refs, const int stateless_rpc,
 		 const int timeout)
 {
@@ -1340,8 +1349,7 @@ void upload_pack(const int advertise_refs, const int stateless_rpc,
 	struct upload_pack_data data;
 
 	upload_pack_data_init(&data);
-
-	git_config(upload_pack_config, &data);
+	get_upload_pack_config(&data);
 
 	data.stateless_rpc = stateless_rpc;
 	data.timeout = timeout;
@@ -1695,8 +1703,7 @@ int upload_pack_v2(struct repository *r, struct packet_reader *request)
 
 	upload_pack_data_init(&data);
 	data.use_sideband = LARGE_PACKET_MAX;
-
-	git_config(upload_pack_config, &data);
+	get_upload_pack_config(&data);
 
 	while (state != FETCH_DONE) {
 		switch (state) {
-- 
gitgitgadget

