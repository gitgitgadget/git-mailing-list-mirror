Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D231FC77B7A
	for <git@archiver.kernel.org>; Tue, 30 May 2023 18:43:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232890AbjE3SnM (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 30 May 2023 14:43:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233252AbjE3Smy (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 30 May 2023 14:42:54 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67F3911D
        for <git@vger.kernel.org>; Tue, 30 May 2023 11:42:28 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id 5b1f17b1804b1-3f6d38a140bso1244695e9.1
        for <git@vger.kernel.org>; Tue, 30 May 2023 11:42:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685472146; x=1688064146;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MF5NV5oPX8To7OpLDkhXZ2gY6IfeNa5jueQTphspkRQ=;
        b=BkKsnHXDQf9oZCMpB3tAatRjjc6l9h7JgkHAwMe6Iy23IupOJJJQwakOarMbRn5x8a
         VP+yGzidJ7vHOBwjZh5/DcteTAyc73qPt5ZGmHJ6egR7ukPJEtqBktVkRahbaFUn0mlF
         xblrQ9NYevfpCpmSWH7DdCfG3XjfzYbPizg0X6c/B32iMBJ7MFWnxuju6WW1Hmvfs0CN
         ZIPmTAn7JqSq2vkRl+q9SN/SnYtl3NkUXKPbN5Wy17ErkGQ9teLr3FnMZ9A/6sPNMPks
         aYWAwV4UaigLCwb1Z6IH1VW2zyPGLF/13//nb770yZIBcE62Wh2hqTFeJNBGWK2Kf2O4
         mXTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685472146; x=1688064146;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MF5NV5oPX8To7OpLDkhXZ2gY6IfeNa5jueQTphspkRQ=;
        b=AX5qFiNSDCWTeGcQV6pavypAmzQh1CTXZMqlTwQtIDTwS/xi2dOYQvCguCp55iLlTt
         ph+i90bHu4xgAZe49CasQKC1teL97C79p9VcjX1JRKyq12TuPfeUeAI/qGnkxcQKM+ny
         q1cCbxCnuphizSvQmGbBvVCHq8gtZLVFLHi0v3zeiLpSsolnGqzdRF1ZsUUtQvvY8Vw/
         NC95BVDMlSuvxEi1+mZZSg6ZT1qJF2kwzhXlUut+Q7Xq3IyjqpV/jm870bXFJHgSK9aj
         lAM+Wyox6Jlxlzm7qe2CFsKhcOhlMuwh1Dhr4e9rXd9aWS176rD5H7DKSiZBo6qHqvFO
         MwSA==
X-Gm-Message-State: AC+VfDzaLJvNpJHUQ+5550020sH6J88ypX2mkfc+0nN9jUjhvv2skhtk
        Ky+V9i6N0doiYOftQs0EwEDBvN+PUqg=
X-Google-Smtp-Source: ACHHUZ6kvdrTTGVzIu4ThXLo6evQns8lGbIrYz6sfe5HMssqI6F5umIc85JoPyd1YhMOJSMYr/Am4g==
X-Received: by 2002:a1c:6a0a:0:b0:3f6:3486:1391 with SMTP id f10-20020a1c6a0a000000b003f634861391mr2574566wmc.13.1685472146673;
        Tue, 30 May 2023 11:42:26 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id v7-20020a05600c214700b003f4f89bc48dsm21863069wml.15.2023.05.30.11.42.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 May 2023 11:42:26 -0700 (PDT)
Message-Id: <7d9b9eefc7860959dbb6ed86d8c3d165a978a0b5.1685472134.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1497.v2.git.git.1685472132.gitgitgadget@gmail.com>
References: <pull.1497.git.git.1682104398.gitgitgadget@gmail.com>
        <pull.1497.v2.git.git.1685472132.gitgitgadget@gmail.com>
From:   "Glen Choo via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 30 May 2023 18:42:11 +0000
Subject: [PATCH v2 13/14] config: add kvi.path, use it to evaluate includes
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Emily Shaffer <nasamuffin@google.com>,
        Glen Choo <chooglen@google.com>,
        Glen Choo <chooglen@google.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Glen Choo <chooglen@google.com>

Include directives are evaluated using the path of the config file. To
reduce the dependence on "config_reader.source", add a new
"key_value_info.path" member and use that instead of
"config_source.path".

Signed-off-by: Glen Choo <chooglen@google.com>
---
 config.c | 41 +++++++++++++++++++----------------------
 config.h |  1 +
 2 files changed, 20 insertions(+), 22 deletions(-)

diff --git a/config.c b/config.c
index 4d381f93bcc..09950b46127 100644
--- a/config.c
+++ b/config.c
@@ -154,7 +154,6 @@ struct config_include_data {
 	void *data;
 	const struct config_options *opts;
 	struct git_config_source *config_source;
-	struct config_reader *config_reader;
 
 	/*
 	 * All remote URLs discovered when reading all config files.
@@ -173,9 +172,7 @@ static const char include_depth_advice[] = N_(
 "from\n"
 "	%s\n"
 "This might be due to circular includes.");
-static int handle_path_include(struct config_source *cs,
-			       struct key_value_info *kvi,
-			       const char *path,
+static int handle_path_include(struct key_value_info *kvi, const char *path,
 			       struct config_include_data *inc)
 {
 	int ret = 0;
@@ -197,14 +194,14 @@ static int handle_path_include(struct config_source *cs,
 	if (!is_absolute_path(path)) {
 		char *slash;
 
-		if (!cs || !cs->path) {
+		if (!kvi || !kvi->path) {
 			ret = error(_("relative config includes must come from files"));
 			goto cleanup;
 		}
 
-		slash = find_last_dir_sep(cs->path);
+		slash = find_last_dir_sep(kvi->path);
 		if (slash)
-			strbuf_add(&buf, cs->path, slash - cs->path + 1);
+			strbuf_add(&buf, kvi->path, slash - kvi->path + 1);
 		strbuf_addstr(&buf, path);
 		path = buf.buf;
 	}
@@ -212,8 +209,8 @@ static int handle_path_include(struct config_source *cs,
 	if (!access_or_die(path, R_OK, 0)) {
 		if (++inc->depth > MAX_INCLUDE_DEPTH)
 			die(_(include_depth_advice), MAX_INCLUDE_DEPTH, path,
-			    !cs ? "<unknown>" :
-			    cs->name ? cs->name :
+			    !kvi ? "<unknown>" :
+			    kvi->filename ? kvi->filename :
 			    "the command line");
 		ret = git_config_from_file_with_options(git_config_include, path, inc,
 							kvi->scope, NULL);
@@ -231,7 +228,7 @@ static void add_trailing_starstar_for_dir(struct strbuf *pat)
 		strbuf_addstr(pat, "**");
 }
 
-static int prepare_include_condition_pattern(struct config_source *cs,
+static int prepare_include_condition_pattern(struct key_value_info *kvi,
 					     struct strbuf *pat)
 {
 	struct strbuf path = STRBUF_INIT;
@@ -248,11 +245,11 @@ static int prepare_include_condition_pattern(struct config_source *cs,
 	if (pat->buf[0] == '.' && is_dir_sep(pat->buf[1])) {
 		const char *slash;
 
-		if (!cs || !cs->path)
+		if (!kvi || !kvi->path)
 			return error(_("relative config include "
 				       "conditionals must come from files"));
 
-		strbuf_realpath(&path, cs->path, 1);
+		strbuf_realpath(&path, kvi->path, 1);
 		slash = find_last_dir_sep(path.buf);
 		if (!slash)
 			BUG("how is this possible?");
@@ -267,7 +264,7 @@ static int prepare_include_condition_pattern(struct config_source *cs,
 	return prefix;
 }
 
-static int include_by_gitdir(struct config_source *cs,
+static int include_by_gitdir(struct key_value_info *kvi,
 			     const struct config_options *opts,
 			     const char *cond, size_t cond_len, int icase)
 {
@@ -284,7 +281,7 @@ static int include_by_gitdir(struct config_source *cs,
 
 	strbuf_realpath(&text, git_dir, 1);
 	strbuf_add(&pattern, cond, cond_len);
-	prefix = prepare_include_condition_pattern(cs, &pattern);
+	prefix = prepare_include_condition_pattern(kvi, &pattern);
 
 again:
 	if (prefix < 0)
@@ -419,16 +416,16 @@ static int include_by_remote_url(struct config_include_data *inc,
 					     inc->remote_urls);
 }
 
-static int include_condition_is_true(struct config_source *cs,
+static int include_condition_is_true(struct key_value_info *kvi,
 				     struct config_include_data *inc,
 				     const char *cond, size_t cond_len)
 {
 	const struct config_options *opts = inc->opts;
 
 	if (skip_prefix_mem(cond, cond_len, "gitdir:", &cond, &cond_len))
-		return include_by_gitdir(cs, opts, cond, cond_len, 0);
+		return include_by_gitdir(kvi, opts, cond, cond_len, 0);
 	else if (skip_prefix_mem(cond, cond_len, "gitdir/i:", &cond, &cond_len))
-		return include_by_gitdir(cs, opts, cond, cond_len, 1);
+		return include_by_gitdir(kvi, opts, cond, cond_len, 1);
 	else if (skip_prefix_mem(cond, cond_len, "onbranch:", &cond, &cond_len))
 		return include_by_branch(cond, cond_len);
 	else if (skip_prefix_mem(cond, cond_len, "hasconfig:remote.*.url:", &cond,
@@ -443,7 +440,6 @@ static int git_config_include(const char *var, const char *value,
 			      struct key_value_info *kvi, void *data)
 {
 	struct config_include_data *inc = data;
-	struct config_source *cs = inc->config_reader->source;
 	const char *cond, *key;
 	size_t cond_len;
 	int ret;
@@ -457,16 +453,16 @@ static int git_config_include(const char *var, const char *value,
 		return ret;
 
 	if (!strcmp(var, "include.path"))
-		ret = handle_path_include(cs, kvi, value, inc);
+		ret = handle_path_include(kvi, value, inc);
 
 	if (!parse_config_key(var, "includeif", &cond, &cond_len, &key) &&
-	    cond && include_condition_is_true(cs, inc, cond, cond_len) &&
+	    cond && include_condition_is_true(kvi, inc, cond, cond_len) &&
 	    !strcmp(key, "path")) {
 		config_fn_t old_fn = inc->fn;
 
 		if (inc->opts->unconditional_remote_url)
 			inc->fn = forbid_remote_url;
-		ret = handle_path_include(cs, kvi, value, inc);
+		ret = handle_path_include(kvi, value, inc);
 		inc->fn = old_fn;
 	}
 
@@ -648,6 +644,7 @@ void kvi_from_param(struct key_value_info *out)
 	out->linenr = -1;
 	out->origin_type = CONFIG_ORIGIN_CMDLINE;
 	out->scope = CONFIG_SCOPE_COMMAND;
+	out->path = NULL;
 }
 
 int git_config_parse_parameter(const char *text,
@@ -1048,6 +1045,7 @@ static void kvi_from_source(struct config_source *cs,
 	out->origin_type = cs->origin_type;
 	out->linenr = cs->linenr;
 	out->scope = scope;
+	out->path = cs->path;
 }
 
 static int git_parse_source(struct config_source *cs, config_fn_t fn,
@@ -2254,7 +2252,6 @@ int config_with_options(config_fn_t fn, void *data,
 		inc.data = data;
 		inc.opts = opts;
 		inc.config_source = config_source;
-		inc.config_reader = &the_reader;
 		fn = git_config_include;
 		data = &inc;
 	}
diff --git a/config.h b/config.h
index 0fe56a4d650..123917d1b0a 100644
--- a/config.h
+++ b/config.h
@@ -116,6 +116,7 @@ struct key_value_info {
 	int linenr;
 	enum config_origin_type origin_type;
 	enum config_scope scope;
+	const char *path;
 };
 
 /**
-- 
gitgitgadget

