Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A685DC77B7A
	for <git@archiver.kernel.org>; Tue, 30 May 2023 18:43:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233514AbjE3SnI (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 30 May 2023 14:43:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232890AbjE3Sme (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 30 May 2023 14:42:34 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 484A111B
        for <git@vger.kernel.org>; Tue, 30 May 2023 11:42:28 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id ffacd0b85a97d-30a1fdde3d6so4864191f8f.0
        for <git@vger.kernel.org>; Tue, 30 May 2023 11:42:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685472146; x=1688064146;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FStdSaKaUJJlzPIwzZ5jL3eYjO9dGulT31OgN6r0Grw=;
        b=Cua2kZQQFxCcJfzf/FnBwBP3APX0ckSVLINa+ajgZ1VQHejtUVA+5WECD7SoygxW6e
         4giAXLcl8kJZlSiBvcAVKu0GXFjGXwdco+B/haweX1LPVWHuRh0nZ6IvX/GWEjQDMCYY
         VnZ284TluIJufE7qxHDtKeaQ5YWq/jwAAeMzh95H/ijUGt9c5pxTM93Fq3EInSmA+P1Y
         iOjLSEZLj75Rx1YYozcf73CuUDXQ5z4yuAfEDzFhDCrGUdHt6STuNM3TIGWql4iLme+A
         ZxFgqLKNbrejeOAIoM4XVMEciHv08Vi1IsfOeTkAAY7gm8d/SdXht9WeBQIKq7kIFBjB
         gc9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685472146; x=1688064146;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FStdSaKaUJJlzPIwzZ5jL3eYjO9dGulT31OgN6r0Grw=;
        b=YQDoPPqCpXay8/v6loZQtjjB+CelRO8guwt4Eip1BNA6X1G29YQfzzoy3ZB/M7Zc5m
         yFOL4BQTcLQ+rewVyeVaWvKqjwWMNXq0x/OKLDRw8Sbbte7FVE0a4rpJx2XGaPrk/6d4
         CkzmN8pTiNkLHrhsQusQ5+OlYxSfjg5M1cv/MnU+VYGHWhjVG7tAe1/gAYr//pDirZHi
         V6VXGWdPuI1gdbcCWPsl02gQrmmbYGMfLvPrJVvJpfNN51QmMse8nOJlNJWy2NTk32kN
         ltjJCCm8ikE7+QW3Rqpy+9B3uUBkgifXS7x+h0yQf/XZQBig9Q6TMtUdMi3Yvs2GyHJt
         Wopg==
X-Gm-Message-State: AC+VfDwEty40H7N6bOhpkNGSA7mvyKUL0zfO/wbvpW6A1mjleBe+rAHc
        VXlHzRqEjlyOGtoLUINsPiz00hg63YY=
X-Google-Smtp-Source: ACHHUZ4nmnRWMpvKtg985+srLZI0bDKBcmQUQpJC5LmDsfo7D6MniNpxTqW6wbshE2jxPpKTmrQdQQ==
X-Received: by 2002:adf:dc84:0:b0:307:9702:dfc8 with SMTP id r4-20020adfdc84000000b003079702dfc8mr2275209wrj.48.1685472146191;
        Tue, 30 May 2023 11:42:26 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id t13-20020a5d690d000000b003062675d4c9sm4073690wru.39.2023.05.30.11.42.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 May 2023 11:42:25 -0700 (PDT)
Message-Id: <52db0d3be828e9a410bd3535419d756ecc247c33.1685472134.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1497.v2.git.git.1685472132.gitgitgadget@gmail.com>
References: <pull.1497.git.git.1682104398.gitgitgadget@gmail.com>
        <pull.1497.v2.git.git.1685472132.gitgitgadget@gmail.com>
From:   "Glen Choo via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 30 May 2023 18:42:10 +0000
Subject: [PATCH v2 12/14] config.c: remove config_reader from configsets
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

Remove the last usage of "struct config_reader" from configsets by
copying the "kvi" arg instead of recomputing "kvi" from
config_reader.source. Since we no longer need to pass both "struct
config_reader" and "struct config_set" in a single "void *cb", remove
"struct configset_add_data" too.

Signed-off-by: Glen Choo <chooglen@google.com>
---
 config.c | 41 ++++++++++-------------------------------
 1 file changed, 10 insertions(+), 31 deletions(-)

diff --git a/config.c b/config.c
index 34a111b2e1c..4d381f93bcc 100644
--- a/config.c
+++ b/config.c
@@ -2285,8 +2285,7 @@ int config_with_options(config_fn_t fn, void *data,
 	return ret;
 }
 
-static void configset_iter(struct config_reader *reader, struct config_set *set,
-			   config_fn_t fn, void *data)
+static void configset_iter(struct config_set *set, config_fn_t fn, void *data)
 {
 	int i, value_index;
 	struct string_list *values;
@@ -2378,7 +2377,6 @@ static int configset_find_element(struct config_set *set, const char *key,
 }
 
 static int configset_add_value(struct key_value_info *kvi_p,
-			       struct config_reader *reader,
 			       struct config_set *set, const char *key,
 			       const char *value)
 {
@@ -2409,11 +2407,7 @@ static int configset_add_value(struct key_value_info *kvi_p,
 	l_item->e = e;
 	l_item->value_index = e->value_list.nr - 1;
 
-	if (reader->source->name) {
-		kvi_from_source(reader->source, kvi_p->scope, kv_info);
-	} else {
-		kvi_from_param(kv_info);
-	}
+	memcpy(kv_info, kvi_p, sizeof(struct key_value_info));
 	si->util = kv_info;
 
 	return 0;
@@ -2461,26 +2455,17 @@ void git_configset_clear(struct config_set *set)
 	set->list.items = NULL;
 }
 
-struct configset_add_data {
-	struct config_set *config_set;
-	struct config_reader *config_reader;
-};
-#define CONFIGSET_ADD_INIT { 0 }
-
 static int config_set_callback(const char *key, const char *value,
 			       struct key_value_info *kvi, void *cb)
 {
-	struct configset_add_data *data = cb;
-	configset_add_value(kvi, data->config_reader, data->config_set, key, value);
+	struct config_set *set = cb;
+	configset_add_value(kvi, set, key, value);
 	return 0;
 }
 
 int git_configset_add_file(struct config_set *set, const char *filename)
 {
-	struct configset_add_data data = CONFIGSET_ADD_INIT;
-	data.config_reader = &the_reader;
-	data.config_set = set;
-	return git_config_from_file(config_set_callback, filename, &data);
+	return git_config_from_file(config_set_callback, filename, set);
 }
 
 int git_configset_get_value(struct config_set *set, const char *key,
@@ -2646,7 +2631,6 @@ int git_configset_get_pathname(struct config_set *set, const char *key, const ch
 static void repo_read_config(struct repository *repo)
 {
 	struct config_options opts = { 0 };
-	struct configset_add_data data = CONFIGSET_ADD_INIT;
 
 	opts.respect_includes = 1;
 	opts.commondir = repo->commondir;
@@ -2658,10 +2642,8 @@ static void repo_read_config(struct repository *repo)
 		git_configset_clear(repo->config);
 
 	git_configset_init(repo->config);
-	data.config_set = repo->config;
-	data.config_reader = &the_reader;
-
-	if (config_with_options(config_set_callback, &data, NULL, &opts) < 0)
+	if (config_with_options(config_set_callback, repo->config, NULL,
+				&opts) < 0)
 		/*
 		 * config_with_options() normally returns only
 		 * zero, as most errors are fatal, and
@@ -2693,7 +2675,7 @@ static void repo_config_clear(struct repository *repo)
 void repo_config(struct repository *repo, config_fn_t fn, void *data)
 {
 	git_config_check_init(repo);
-	configset_iter(&the_reader, repo->config, fn, data);
+	configset_iter(repo->config, fn, data);
 }
 
 int repo_config_get(struct repository *repo, const char *key)
@@ -2800,19 +2782,16 @@ static void read_protected_config(void)
 		.ignore_worktree = 1,
 		.system_gently = 1,
 	};
-	struct configset_add_data data = CONFIGSET_ADD_INIT;
 
 	git_configset_init(&protected_config);
-	data.config_set = &protected_config;
-	data.config_reader = &the_reader;
-	config_with_options(config_set_callback, &data, NULL, &opts);
+	config_with_options(config_set_callback, &protected_config, NULL, &opts);
 }
 
 void git_protected_config(config_fn_t fn, void *data)
 {
 	if (!protected_config.hash_initialized)
 		read_protected_config();
-	configset_iter(&the_reader, &protected_config, fn, data);
+	configset_iter(&protected_config, fn, data);
 }
 
 /* Functions used historically to read configuration from 'the_repository' */
-- 
gitgitgadget

