Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1F92C64EC4
	for <git@archiver.kernel.org>; Wed,  1 Mar 2023 00:38:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229850AbjCAAil (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 28 Feb 2023 19:38:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229788AbjCAAib (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Feb 2023 19:38:31 -0500
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D17D23338
        for <git@vger.kernel.org>; Tue, 28 Feb 2023 16:38:25 -0800 (PST)
Received: by mail-wm1-x334.google.com with SMTP id j3so7564158wms.2
        for <git@vger.kernel.org>; Tue, 28 Feb 2023 16:38:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MwAlrsRdQ9AV0+EcvWx/2rheoExK0e6UCtNMmDBBOlg=;
        b=pSYD/zgNE1Gb1HIsK7wT+DO6Ns1Cc8PBDf0bveedPCNZ4RCj9F6ukQr12tpmqtDNFe
         jeTA/wdfoNL4GzW8ivVzQcQXmLE8Dj+odZsyJFelGic4wUXyc3pNJ1AjQ7LGW44IZZ8h
         pxmr7yR6Ptbpc6kqrLSrnUAaMZvdcDS4Kx7TGRqZ+C7MgWbK/An+COnUBu6Zj9GUDnGN
         /eOER5L7lL7o+i6Z4GNps5fKbcTjjCf33VcwzoB4kYldaGyZkE+0h20EeAaZlsbsJJ5R
         Dq1HLBeEho39f/7SduPuSo2Rw2Cht/QgCi3WJ5GIeZtoJ0ylrFYZOU1FWUg9Tegu5MXP
         sVfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MwAlrsRdQ9AV0+EcvWx/2rheoExK0e6UCtNMmDBBOlg=;
        b=HNyAu65FDviKlxv5geSOjQkj5QyOAMrEbCUkqd1RorGJ0Mn2BkRUri6WnrrvMHevZg
         SN7vkVQIuqj3jk6jK+WaC77h6cnQVcO9NDBNac68huQduqM6FyEY0WbbI7dUmG2eisq9
         +YaAUHrux5M5ueVVfHhVb4QFQ6HnYVD2CPzWVgXdkalIJ0IEWOo60uSrMyvpxQ0h2F+t
         hh4L8lYfhAq92l1fUTvWFOiCWJwYmmZ6sDJyWtHbSIu8PsgZ4Pk0Mgz6dYCfVfZEZHUR
         5xi5YsWNQz51NbR1sGspVkfK0SzqLLC6hMOTYWaS9K6Id3bC5nFAsHLeN172+3knKhoR
         Zvgw==
X-Gm-Message-State: AO0yUKUwh6rs0TU3HI1jawpEMhae4NUro4ReQsAbNGssOo+tlKnmNEnd
        rcrw9YoFdQDJK3qf0Eh0engd5Ei4cBI=
X-Google-Smtp-Source: AK7set/KS282ahPF5AQXelQN70zJXzTUAXP5GrGtgMou5xFc0ExJ+6AEZ3cAckhyvttWvYxLOJqDiQ==
X-Received: by 2002:a05:600c:3b99:b0:3ea:fc95:7bf with SMTP id n25-20020a05600c3b9900b003eafc9507bfmr3275873wms.30.1677631103397;
        Tue, 28 Feb 2023 16:38:23 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 13-20020a05600c020d00b003dc1d668866sm17559787wmi.10.2023.02.28.16.38.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Feb 2023 16:38:22 -0800 (PST)
Message-Id: <b1e866f92161a38e255d0d6a6a4640dea880ebe4.1677631097.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1463.git.git.1677631097.gitgitgadget@gmail.com>
References: <pull.1463.git.git.1677631097.gitgitgadget@gmail.com>
From:   "Glen Choo via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 01 Mar 2023 00:38:17 +0000
Subject: [PATCH 6/6] config.c: remove current_parsing_scope
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>,
        Emily Shaffer <nasamuffin@google.com>,
        Jeff King <peff@peff.net>,
        Derrick Stolee <derrickstolee@github.com>,
        Glen Choo <chooglen@google.com>,
        Glen Choo <chooglen@google.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Glen Choo <chooglen@google.com>

Add ".parsing_scope" to "struct config_reader" and replace
"current_parsing_scope" with "the_reader.parsing_scope. Adjust the
comment slightly to make it clearer that the scope applies to the config
source (not the current value), and should only be set when parsing a
config source.

As such, ".parsing_scope" (only set when parsing config sources) and
".config_kvi" (only set when iterating a config set) should not be
set together, so enforce this with a setter function.

Unlike previous commits, "populate_remote_urls()" still needs to store
and restore the 'scope' value because it could have touched
"current_parsing_scope" ("config_with_options()" can set the scope).

Signed-off-by: Glen Choo <chooglen@google.com>
---
 config.c | 62 +++++++++++++++++++++++++++++++++-----------------------
 1 file changed, 37 insertions(+), 25 deletions(-)

diff --git a/config.c b/config.c
index c7995148165..19bab84c47f 100644
--- a/config.c
+++ b/config.c
@@ -70,19 +70,20 @@ struct config_reader {
 	 */
 	struct config_source *source;
 	struct key_value_info *config_kvi;
+	/*
+	 * The "scope" of the current config source being parsed (repo, global,
+	 * etc). Like "source", this is only set when parsing a config source.
+	 * It's not part of "source" because it transcends a single file (i.e.,
+	 * a file included from .git/config is still in "repo" scope).
+	 *
+	 * When iterating through a configset, the equivalent value is
+	 * "config_kvi.scope" (see above).
+	 */
+	enum config_scope parsing_scope;
 };
 /* Only public functions should reference the_reader. */
 static struct config_reader the_reader;
 
-/*
- * Similar to the variables above, this gives access to the "scope" of the
- * current value (repo, global, etc). For cached values, it can be found via
- * the current_config_kvi as above. During parsing, the current value can be
- * found in this variable. It's not part of "cf" because it transcends a single
- * file (i.e., a file included from .git/config is still in "repo" scope).
- */
-static enum config_scope current_parsing_scope;
-
 static inline void config_reader_push_source(struct config_reader *reader,
 					     struct config_source *top)
 {
@@ -106,11 +107,19 @@ static inline struct config_source *config_reader_pop_source(struct config_reade
 static inline void config_reader_set_kvi(struct config_reader *reader,
 					 struct key_value_info *kvi)
 {
-	if (kvi && reader->source)
+	if (kvi && (reader->source || reader->parsing_scope))
 		BUG("kvi should only be set when iterating through configset");
 	reader->config_kvi = kvi;
 }
 
+static inline void config_reader_set_scope(struct config_reader *reader,
+					   enum config_scope scope)
+{
+	if (scope && reader->config_kvi)
+		BUG("scope should only be set when iterating through a config source");
+	reader->parsing_scope = scope;
+}
+
 static int pack_compression_seen;
 static int zlib_compression_seen;
 
@@ -379,18 +388,18 @@ static void populate_remote_urls(struct config_include_data *inc)
 {
 	struct config_options opts;
 
-	enum config_scope store_scope = current_parsing_scope;
+	enum config_scope store_scope = inc->config_reader->parsing_scope;
 
 	opts = *inc->opts;
 	opts.unconditional_remote_url = 1;
 
-	current_parsing_scope = 0;
+	config_reader_set_scope(inc->config_reader, 0);
 
 	inc->remote_urls = xmalloc(sizeof(*inc->remote_urls));
 	string_list_init_dup(inc->remote_urls);
 	config_with_options(add_remote_url, inc->remote_urls, inc->config_source, &opts);
 
-	current_parsing_scope = store_scope;
+	config_reader_set_scope(inc->config_reader, store_scope);
 }
 
 static int forbid_remote_url(const char *var, const char *value UNUSED,
@@ -2155,7 +2164,8 @@ int git_config_system(void)
 	return !git_env_bool("GIT_CONFIG_NOSYSTEM", 0);
 }
 
-static int do_git_config_sequence(const struct config_options *opts,
+static int do_git_config_sequence(struct config_reader *reader,
+				  const struct config_options *opts,
 				  config_fn_t fn, void *data)
 {
 	int ret = 0;
@@ -2163,7 +2173,7 @@ static int do_git_config_sequence(const struct config_options *opts,
 	char *xdg_config = NULL;
 	char *user_config = NULL;
 	char *repo_config;
-	enum config_scope prev_parsing_scope = current_parsing_scope;
+	enum config_scope prev_parsing_scope = reader->parsing_scope;
 
 	if (opts->commondir)
 		repo_config = mkpathdup("%s/config", opts->commondir);
@@ -2172,13 +2182,13 @@ static int do_git_config_sequence(const struct config_options *opts,
 	else
 		repo_config = NULL;
 
-	current_parsing_scope = CONFIG_SCOPE_SYSTEM;
+	config_reader_set_scope(reader, CONFIG_SCOPE_SYSTEM);
 	if (git_config_system() && system_config &&
 	    !access_or_die(system_config, R_OK,
 			   opts->system_gently ? ACCESS_EACCES_OK : 0))
 		ret += git_config_from_file(fn, system_config, data);
 
-	current_parsing_scope = CONFIG_SCOPE_GLOBAL;
+	config_reader_set_scope(reader, CONFIG_SCOPE_GLOBAL);
 	git_global_config(&user_config, &xdg_config);
 
 	if (xdg_config && !access_or_die(xdg_config, R_OK, ACCESS_EACCES_OK))
@@ -2187,12 +2197,12 @@ static int do_git_config_sequence(const struct config_options *opts,
 	if (user_config && !access_or_die(user_config, R_OK, ACCESS_EACCES_OK))
 		ret += git_config_from_file(fn, user_config, data);
 
-	current_parsing_scope = CONFIG_SCOPE_LOCAL;
+	config_reader_set_scope(reader, CONFIG_SCOPE_LOCAL);
 	if (!opts->ignore_repo && repo_config &&
 	    !access_or_die(repo_config, R_OK, 0))
 		ret += git_config_from_file(fn, repo_config, data);
 
-	current_parsing_scope = CONFIG_SCOPE_WORKTREE;
+	config_reader_set_scope(reader, CONFIG_SCOPE_WORKTREE);
 	if (!opts->ignore_worktree && repository_format_worktree_config) {
 		char *path = git_pathdup("config.worktree");
 		if (!access_or_die(path, R_OK, 0))
@@ -2200,11 +2210,11 @@ static int do_git_config_sequence(const struct config_options *opts,
 		free(path);
 	}
 
-	current_parsing_scope = CONFIG_SCOPE_COMMAND;
+	config_reader_set_scope(reader, CONFIG_SCOPE_COMMAND);
 	if (!opts->ignore_cmdline && git_config_from_parameters(fn, data) < 0)
 		die(_("unable to parse command-line config"));
 
-	current_parsing_scope = prev_parsing_scope;
+	config_reader_set_scope(reader, prev_parsing_scope);
 	free(system_config);
 	free(xdg_config);
 	free(user_config);
@@ -2217,6 +2227,7 @@ int config_with_options(config_fn_t fn, void *data,
 			const struct config_options *opts)
 {
 	struct config_include_data inc = CONFIG_INCLUDE_INIT;
+	enum config_scope prev_scope = the_reader.parsing_scope;
 	int ret;
 
 	if (opts->respect_includes) {
@@ -2230,7 +2241,7 @@ int config_with_options(config_fn_t fn, void *data,
 	}
 
 	if (config_source)
-		current_parsing_scope = config_source->scope;
+		config_reader_set_scope(&the_reader, config_source->scope);
 
 	/*
 	 * If we have a specific filename, use it. Otherwise, follow the
@@ -2246,13 +2257,14 @@ int config_with_options(config_fn_t fn, void *data,
 		ret = git_config_from_blob_ref(fn, repo, config_source->blob,
 						data);
 	} else {
-		ret = do_git_config_sequence(opts, fn, data);
+		ret = do_git_config_sequence(&the_reader, opts, fn, data);
 	}
 
 	if (inc.remote_urls) {
 		string_list_clear(inc.remote_urls, 0);
 		FREE_AND_NULL(inc.remote_urls);
 	}
+	config_reader_set_scope(&the_reader, prev_scope);
 	return ret;
 }
 
@@ -2393,7 +2405,7 @@ static int configset_add_value(struct config_reader *reader,
 		kv_info->linenr = -1;
 		kv_info->origin_type = CONFIG_ORIGIN_CMDLINE;
 	}
-	kv_info->scope = current_parsing_scope;
+	kv_info->scope = reader->parsing_scope;
 	si->util = kv_info;
 
 	return 0;
@@ -3902,7 +3914,7 @@ enum config_scope current_config_scope(void)
 	if (the_reader.config_kvi)
 		return the_reader.config_kvi->scope;
 	else
-		return current_parsing_scope;
+		return the_reader.parsing_scope;
 }
 
 int current_config_line(void)
-- 
gitgitgadget
