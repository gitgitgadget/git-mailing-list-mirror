Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32FA4C77B78
	for <git@archiver.kernel.org>; Fri, 21 Apr 2023 19:13:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229871AbjDUTN2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 21 Apr 2023 15:13:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233403AbjDUTNY (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 Apr 2023 15:13:24 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 420A810E9
        for <git@vger.kernel.org>; Fri, 21 Apr 2023 12:13:23 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id ffacd0b85a97d-2f86ee42669so2020563f8f.2
        for <git@vger.kernel.org>; Fri, 21 Apr 2023 12:13:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682104401; x=1684696401;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zrB7DkhcGDIQa2I5QGxbVfIiBVj5aGBTnaOP9rGwy/4=;
        b=dRCgNBaiTkq1Qy0L29g92xzTSJfiKdVZU0TGqJZOAOUCeIw5mQ87rvzSBmpaZfsHmT
         1LckU0H7M+OAaxX0j2JeVtaRGXBviPpW3PEQTyuTOG6ZPM5M8SdiKS1mE9JrxxoVq7w1
         kmvo2cTqmg4+UHvElJ4CfxOufTilfkbc2evTHtCNNuINTASLqL1Cz7z3g97v0m/5eBZN
         /UOUZqGSEYht22EXbcJ6E+li1b5ccFTA4Lw+G5cO1SPEE3J/NTwT+bnAkK8Dir7yBAh6
         eRP89lt50Eoq664ioZwaK4no6Fo1I+iOe/RjgDRtzkqaQZTtntD005GiZwfO2AUlBRFt
         RA7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682104401; x=1684696401;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zrB7DkhcGDIQa2I5QGxbVfIiBVj5aGBTnaOP9rGwy/4=;
        b=Y4N6cia2A8LoKUSgsu4FfheX7tLjaNhU1HSpsas8fYZPBf5ddym37nDyfuTGRnLqhK
         u19+tJraobWP0XAzPw5qYgEFYYZ1X0W85NmC53rbFhqw4A0sWBGvZ1aCJ/p/UdwsKAQe
         NLurt5Z3dU9IlZturcs6uEeUWeEpZjhl09/9t3E+iFt0XqTzHLFy2hdYefbEUitY/iDM
         TOimvXtdS2E2O/YF/7EVDXZXTHANLGsvi01fawPsexOtZ/7NgPXnICEXO+prRDE+yqmB
         AHeg7YFCsSfMcfi90d8DIzuLHafJFQkN3d0wU7D/qk4VeNwP3iuVqY++m8/VRnH1l3ZI
         mpAg==
X-Gm-Message-State: AAQBX9cLN2/EYk4nAArVNH9BMHlOsO/wOROGHI0cW72xeMZ2IqmmgtjO
        ZFHds6pjIdWpkydU1nXF5OSG7w65CEM=
X-Google-Smtp-Source: AKy350YwvBuM3FR6Pfsfp9dpRe+Nw+OQ0VPW37gbqVakjtHsvvj4U/OE1CwDmJKyJYBGhqXlvy2FCA==
X-Received: by 2002:a05:6000:cd:b0:2f4:e580:a72f with SMTP id q13-20020a05600000cd00b002f4e580a72fmr4953411wrx.45.1682104401632;
        Fri, 21 Apr 2023 12:13:21 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id b5-20020a056000054500b002e5ff05765esm5013440wrf.73.2023.04.21.12.13.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Apr 2023 12:13:21 -0700 (PDT)
Message-Id: <a682612cff23449e682023303f17a8be1d73fc31.1682104398.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1497.git.git.1682104398.gitgitgadget@gmail.com>
References: <pull.1497.git.git.1682104398.gitgitgadget@gmail.com>
From:   "Glen Choo via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 21 Apr 2023 19:13:06 +0000
Subject: [PATCH 02/14] config.c: use kvi for CLI config
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

Plumb "struct key_value_info" and use "kvi_fn()" when parsing CLI
config. Do this by refactoring out and reusing the logic that sets the
"struct key_value_info" members when caching CLI config in a configset.

This lets us get rid of the fake "struct config_source" in
"git_config_from_parameters()", so we now only have to maintain one
implementation. Additionally, this plumbing also reveals that
"git_config_parse_parameter()" hasn't been setting either
"the_reader.source" or "the_reader.config_kvi", so any calls to
"current_*" would either BUG() or return *_UNKNOWN values.

Also, get rid of the BUG() checks that forbid setting ".config_kvi" and
".source" at the same time, since we will run afoul of that check. They
will soon be unnecessary when we remove ".source".

Signed-off-by: Glen Choo <chooglen@google.com>
---
 config.c | 58 ++++++++++++++++++++++++++++----------------------------
 1 file changed, 29 insertions(+), 29 deletions(-)

diff --git a/config.c b/config.c
index daad892e4fd..4e9e8e7abb9 100644
--- a/config.c
+++ b/config.c
@@ -99,8 +99,6 @@ static struct config_reader the_reader;
 static inline void config_reader_push_source(struct config_reader *reader,
 					     struct config_source *top)
 {
-	if (reader->config_kvi)
-		BUG("source should not be set while iterating a config set");
 	top->prev = reader->source;
 	reader->source = top;
 }
@@ -118,16 +116,12 @@ static inline struct config_source *config_reader_pop_source(struct config_reade
 static inline void config_reader_set_kvi(struct config_reader *reader,
 					 struct key_value_info *kvi)
 {
-	if (kvi && (reader->source || reader->parsing_scope))
-		BUG("kvi should not be set while parsing a config source");
 	reader->config_kvi = kvi;
 }
 
 static inline void config_reader_set_scope(struct config_reader *reader,
 					   enum config_scope scope)
 {
-	if (scope && reader->config_kvi)
-		BUG("scope should only be set when iterating through a config source");
 	reader->parsing_scope = scope;
 }
 
@@ -672,7 +666,8 @@ static int kvi_fn(config_fn_t fn, const char *key, const char *value,
 }
 
 static int config_parse_pair(const char *key, const char *value,
-			  config_fn_t fn, void *data)
+			     struct key_value_info *kvi,
+			     config_fn_t fn, void *data)
 {
 	char *canonical_name;
 	int ret;
@@ -682,17 +677,30 @@ static int config_parse_pair(const char *key, const char *value,
 	if (git_config_parse_key(key, &canonical_name, NULL))
 		return -1;
 
-	ret = (fn(canonical_name, value, data) < 0) ? -1 : 0;
+	ret = (kvi_fn(fn, canonical_name, value, kvi, data) < 0) ? -1 : 0;
 	free(canonical_name);
 	return ret;
 }
 
+
+/* for values read from `git_config_from_parameters()` */
+static void kvi_from_param(struct key_value_info *out)
+{
+	out->filename = NULL;
+	out->linenr = -1;
+	out->origin_type = CONFIG_ORIGIN_CMDLINE;
+	out->scope = CONFIG_SCOPE_COMMAND;
+}
+
 int git_config_parse_parameter(const char *text,
 			       config_fn_t fn, void *data)
 {
 	const char *value;
 	struct strbuf **pair;
 	int ret;
+	struct key_value_info kvi = { 0 };
+
+	kvi_from_param(&kvi);
 
 	pair = strbuf_split_str(text, '=', 2);
 	if (!pair[0])
@@ -711,12 +719,13 @@ int git_config_parse_parameter(const char *text,
 		return error(_("bogus config parameter: %s"), text);
 	}
 
-	ret = config_parse_pair(pair[0]->buf, value, fn, data);
+	ret = config_parse_pair(pair[0]->buf, value, &kvi, fn, data);
 	strbuf_list_free(pair);
 	return ret;
 }
 
-static int parse_config_env_list(char *env, config_fn_t fn, void *data)
+static int parse_config_env_list(char *env, struct key_value_info *kvi,
+				 config_fn_t fn, void *data)
 {
 	char *cur = env;
 	while (cur && *cur) {
@@ -750,7 +759,7 @@ static int parse_config_env_list(char *env, config_fn_t fn, void *data)
 					     CONFIG_DATA_ENVIRONMENT);
 			}
 
-			if (config_parse_pair(key, value, fn, data) < 0)
+			if (config_parse_pair(key, value, kvi, fn, data) < 0)
 				return -1;
 		}
 		else {
@@ -774,11 +783,9 @@ int git_config_from_parameters(config_fn_t fn, void *data)
 	struct strvec to_free = STRVEC_INIT;
 	int ret = 0;
 	char *envw = NULL;
-	struct config_source source = CONFIG_SOURCE_INIT;
-
-	source.origin_type = CONFIG_ORIGIN_CMDLINE;
-	config_reader_push_source(&the_reader, &source);
+	struct key_value_info kvi = { 0 };
 
+	kvi_from_param(&kvi);
 	env = getenv(CONFIG_COUNT_ENVIRONMENT);
 	if (env) {
 		unsigned long count;
@@ -814,7 +821,7 @@ int git_config_from_parameters(config_fn_t fn, void *data)
 			}
 			strbuf_reset(&envvar);
 
-			if (config_parse_pair(key, value, fn, data) < 0) {
+			if (config_parse_pair(key, value, &kvi, fn, data) < 0) {
 				ret = -1;
 				goto out;
 			}
@@ -825,7 +832,7 @@ int git_config_from_parameters(config_fn_t fn, void *data)
 	if (env) {
 		/* sq_dequote will write over it */
 		envw = xstrdup(env);
-		if (parse_config_env_list(envw, fn, data) < 0) {
+		if (parse_config_env_list(envw, &kvi, fn, data) < 0) {
 			ret = -1;
 			goto out;
 		}
@@ -835,7 +842,6 @@ out:
 	strbuf_release(&envvar);
 	strvec_clear(&to_free);
 	free(envw);
-	config_reader_pop_source(&the_reader);
 	return ret;
 }
 
@@ -2241,7 +2247,7 @@ static int do_git_config_sequence(struct config_reader *reader,
 		free(path);
 	}
 
-	config_reader_set_scope(reader, CONFIG_SCOPE_COMMAND);
+	config_reader_set_scope(reader, 0);
 	if (!opts->ignore_cmdline && git_config_from_parameters(fn, data) < 0)
 		die(_("unable to parse command-line config"));
 
@@ -2423,19 +2429,13 @@ static int configset_add_value(struct config_reader *reader,
 	l_item->e = e;
 	l_item->value_index = e->value_list.nr - 1;
 
-	if (!reader->source)
-		BUG("configset_add_value has no source");
-	if (reader->source->name) {
+	if (reader->source && reader->source->name) {
 		kv_info->filename = strintern(reader->source->name);
 		kv_info->linenr = reader->source->linenr;
 		kv_info->origin_type = reader->source->origin_type;
-	} else {
-		/* for values read from `git_config_from_parameters()` */
-		kv_info->filename = NULL;
-		kv_info->linenr = -1;
-		kv_info->origin_type = CONFIG_ORIGIN_CMDLINE;
-	}
-	kv_info->scope = reader->parsing_scope;
+		kv_info->scope = reader->parsing_scope;
+	} else
+		kvi_from_param(kv_info);
 	si->util = kv_info;
 
 	return 0;
-- 
gitgitgadget

