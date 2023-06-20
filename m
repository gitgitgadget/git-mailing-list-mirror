Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA91BEB64DD
	for <git@archiver.kernel.org>; Tue, 20 Jun 2023 19:44:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230507AbjFTTon (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 20 Jun 2023 15:44:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230493AbjFTToR (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Jun 2023 15:44:17 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85A6F198B
        for <git@vger.kernel.org>; Tue, 20 Jun 2023 12:44:06 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id 5b1f17b1804b1-3f904dcc1e2so41127025e9.3
        for <git@vger.kernel.org>; Tue, 20 Jun 2023 12:44:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687290245; x=1689882245;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4k4thj2ZIiI+QLZVVcULC98mddiq7+5cMGG8fe489WE=;
        b=WcY6CIYkR9nwGU7/9SG7VTUffxdImT+WyU20GqOLomsR2L1YHsQycgenHen5hQXb/V
         nuSS8Xd9hhSnOkshTgunhmCEjXsJ869LMH+DNV9TOxCVmhQCU1aoJaXbyTRH8yol6yzH
         csSqSxUzySiTOnE8UoUuS13XWQ9wA6606K6UaFstN1oQ76Mtn2ir0XtOMbC0GKwKkhwb
         MYH0Bg4AS+C2LvuGlFir/JsvWP3nShnKYkrbuQVnKdTHOiIQ1w89tbaUHMg4DCJG1CPF
         PrkFGOptqb8e/qRAbd6UVsHzKk4qZMKpzxvDy2Yjp1RdkceKKGpR64Wj/UYQlO533vg1
         Iysw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687290245; x=1689882245;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4k4thj2ZIiI+QLZVVcULC98mddiq7+5cMGG8fe489WE=;
        b=Qu7D/FNLe7LIBo003Y4exVj5gC/gdsnV0ewc4RYm4RjdmVahsQDCFz5GRz00T1m+wZ
         /z/xoUyiEkMOUO54jvG7Oj8Pkg0LNAmEkh57PZHIuMpjRN4ZAG5QhD3IZajiScWngJrp
         pCyxb8cMs8Xby+e6K+3DpwnIQoyiTifUiMzjMf7hrJDXl5mBrx7hfvTCILTD9pfZpBI9
         CWA6hSWZ9HG/r3p6LTz/2PVLc2YYYwJxqVOJKAC6KEBoPk6KDEfxg8QXzPXF/6BdgxKC
         kbg03RcMvjbnnrJog2sPBS0v3V3d8sNLNTQfrR2AujCctTwhKMtv/piQoX1cdAbFiZd9
         sfNg==
X-Gm-Message-State: AC+VfDyiLBgaoBol+y+mtotTIzKW5PA79BSIV+zeueJxcpZCqCswAFb2
        /hlU0glN3vOlYNu4M6Y8fU9GLGpAzpE=
X-Google-Smtp-Source: ACHHUZ6X2cn3XrPHGFwrIyJ3laLFO59fQmADmgdcwKOAv5wyS7PCSqlZCbo80tDwV24IPAnvTPRZFQ==
X-Received: by 2002:a5d:63c5:0:b0:30f:cf93:4bb8 with SMTP id c5-20020a5d63c5000000b0030fcf934bb8mr9776610wrw.57.1687290244593;
        Tue, 20 Jun 2023 12:44:04 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id n11-20020a5d4c4b000000b003113ccbf388sm2690868wrt.13.2023.06.20.12.44.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Jun 2023 12:44:04 -0700 (PDT)
Message-Id: <8ae115cff8855368f1410eb73ff618a69c20072b.1687290233.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1497.v3.git.git.1687290231.gitgitgadget@gmail.com>
References: <pull.1497.v2.git.git.1685472132.gitgitgadget@gmail.com>
        <pull.1497.v3.git.git.1687290231.gitgitgadget@gmail.com>
From:   "Glen Choo via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 20 Jun 2023 19:43:50 +0000
Subject: [PATCH v3 11/12] config: add kvi.path, use it to evaluate includes
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Emily Shaffer <nasamuffin@google.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Glen Choo <chooglen@google.com>,
        Glen Choo <chooglen@google.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Glen Choo <chooglen@google.com>

Include directives are evaluated using the path of the config file. To
reduce the dependence on "config_reader.source", add a new
"key_value_info.path" member and use that instead of
"config_source.path". This allows us to remove a "struct config_reader
*" field from "struct config_include_data", which will subsequently
allow us to remove "struct config_reader" entirely.

Signed-off-by: Glen Choo <chooglen@google.com>
---
 config.c | 40 +++++++++++++++++++---------------------
 config.h |  2 ++
 2 files changed, 21 insertions(+), 21 deletions(-)

diff --git a/config.c b/config.c
index 958ba166cf9..04c7db6f1be 100644
--- a/config.c
+++ b/config.c
@@ -161,7 +161,6 @@ struct config_include_data {
 	void *data;
 	const struct config_options *opts;
 	struct git_config_source *config_source;
-	struct config_reader *config_reader;
 
 	/*
 	 * All remote URLs discovered when reading all config files.
@@ -180,8 +179,7 @@ static const char include_depth_advice[] = N_(
 "from\n"
 "	%s\n"
 "This might be due to circular includes.");
-static int handle_path_include(struct config_source *cs,
-			       const struct key_value_info *kvi,
+static int handle_path_include(const struct key_value_info *kvi,
 			       const char *path,
 			       struct config_include_data *inc)
 {
@@ -204,14 +202,14 @@ static int handle_path_include(struct config_source *cs,
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
@@ -219,8 +217,8 @@ static int handle_path_include(struct config_source *cs,
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
@@ -238,7 +236,7 @@ static void add_trailing_starstar_for_dir(struct strbuf *pat)
 		strbuf_addstr(pat, "**");
 }
 
-static int prepare_include_condition_pattern(struct config_source *cs,
+static int prepare_include_condition_pattern(const struct key_value_info *kvi,
 					     struct strbuf *pat)
 {
 	struct strbuf path = STRBUF_INIT;
@@ -255,11 +253,11 @@ static int prepare_include_condition_pattern(struct config_source *cs,
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
@@ -274,7 +272,7 @@ static int prepare_include_condition_pattern(struct config_source *cs,
 	return prefix;
 }
 
-static int include_by_gitdir(struct config_source *cs,
+static int include_by_gitdir(const struct key_value_info *kvi,
 			     const struct config_options *opts,
 			     const char *cond, size_t cond_len, int icase)
 {
@@ -291,7 +289,7 @@ static int include_by_gitdir(struct config_source *cs,
 
 	strbuf_realpath(&text, git_dir, 1);
 	strbuf_add(&pattern, cond, cond_len);
-	prefix = prepare_include_condition_pattern(cs, &pattern);
+	prefix = prepare_include_condition_pattern(kvi, &pattern);
 
 again:
 	if (prefix < 0)
@@ -426,16 +424,16 @@ static int include_by_remote_url(struct config_include_data *inc,
 					     inc->remote_urls);
 }
 
-static int include_condition_is_true(struct config_source *cs,
+static int include_condition_is_true(const struct key_value_info *kvi,
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
@@ -451,7 +449,6 @@ static int git_config_include(const char *var, const char *value,
 			      void *data)
 {
 	struct config_include_data *inc = data;
-	struct config_source *cs = inc->config_reader->source;
 	const char *cond, *key;
 	size_t cond_len;
 	int ret;
@@ -465,16 +462,16 @@ static int git_config_include(const char *var, const char *value,
 		return ret;
 
 	if (!strcmp(var, "include.path"))
-		ret = handle_path_include(cs, ctx->kvi, value, inc);
+		ret = handle_path_include(ctx->kvi, value, inc);
 
 	if (!parse_config_key(var, "includeif", &cond, &cond_len, &key) &&
-	    cond && include_condition_is_true(cs, inc, cond, cond_len) &&
+	    cond && include_condition_is_true(ctx->kvi, inc, cond, cond_len) &&
 	    !strcmp(key, "path")) {
 		config_fn_t old_fn = inc->fn;
 
 		if (inc->opts->unconditional_remote_url)
 			inc->fn = forbid_remote_url;
-		ret = handle_path_include(cs, ctx->kvi, value, inc);
+		ret = handle_path_include(ctx->kvi, value, inc);
 		inc->fn = old_fn;
 	}
 
@@ -659,6 +656,7 @@ void kvi_from_param(struct key_value_info *out)
 	out->linenr = -1;
 	out->origin_type = CONFIG_ORIGIN_CMDLINE;
 	out->scope = CONFIG_SCOPE_COMMAND;
+	out->path = NULL;
 }
 
 int git_config_parse_parameter(const char *text,
@@ -1062,6 +1060,7 @@ static void kvi_from_source(struct config_source *cs,
 	out->origin_type = cs->origin_type;
 	out->linenr = cs->linenr;
 	out->scope = scope;
+	out->path = cs->path;
 }
 
 static int git_parse_source(struct config_source *cs, config_fn_t fn,
@@ -2272,7 +2271,6 @@ int config_with_options(config_fn_t fn, void *data,
 		inc.data = data;
 		inc.opts = opts;
 		inc.config_source = config_source;
-		inc.config_reader = &the_reader;
 		fn = git_config_include;
 		data = &inc;
 	}
diff --git a/config.h b/config.h
index a8f41c59e6c..8841b7a1cf6 100644
--- a/config.h
+++ b/config.h
@@ -117,12 +117,14 @@ struct key_value_info {
 	int linenr;
 	enum config_origin_type origin_type;
 	enum config_scope scope;
+	const char *path;
 };
 #define KVI_INIT { \
 	.filename = NULL, \
 	.linenr = -1, \
 	.origin_type = CONFIG_ORIGIN_UNKNOWN, \
 	.scope = CONFIG_SCOPE_UNKNOWN, \
+	.path = NULL, \
 }
 
 /* Captures additional information that a config callback can use. */
-- 
gitgitgadget

