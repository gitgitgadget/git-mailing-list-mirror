Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A4E9EB64D7
	for <git@archiver.kernel.org>; Tue, 20 Jun 2023 19:44:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230499AbjFTToi (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 20 Jun 2023 15:44:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230299AbjFTToL (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Jun 2023 15:44:11 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7B3B1710
        for <git@vger.kernel.org>; Tue, 20 Jun 2023 12:44:05 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id ffacd0b85a97d-3090d3e9c92so5776979f8f.2
        for <git@vger.kernel.org>; Tue, 20 Jun 2023 12:44:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687290244; x=1689882244;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=87IOpaKG/bUtm4On31xA0MX6DRW42+XxCRmWwvXBmg8=;
        b=BIUi1jfZQ1dT+MwDNerqbk0mebvTkqt17SsPtfjK+h+NRWX29arQfGF0jDe/r5CIcj
         yJsRfyU80bG/pvBZFRePGR08in1B64/Vi3wgEYL3Ywq2uoxPO8mi9j0Kt00y6r3UkCLW
         tUem3A+YinmpF6RKNeKS3GOHLYFuVEADtbSJMEoHOP5Xv6WKj+IMEpDbPCJLpr+bKmsN
         /WibD5semXrGeUGfJVybpgNMJf6hr39MiIFDas7A+hCkNYar2S9TOpDy4OWcRh1bF9lO
         yP5zpUeVYi7oJ+IAY5LLIOLd1I/2wtJqY/D9gJO9+/VLszIhAuJfY4P2WrkwmeDTRU00
         hKUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687290244; x=1689882244;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=87IOpaKG/bUtm4On31xA0MX6DRW42+XxCRmWwvXBmg8=;
        b=BvvmCZtlyRSpuhNiFbm44xkijvZfvXZojHOtDrlDag2NQQfr61VaiPJch9YYprtJEa
         XJ02G83xEMNagP0ZgGk3E62sq+jvKpzfX1zDMtfgpXRxR72/F+ozbCdqQtM1x21tbYUe
         hht6b/BxhaICUjhVoh7rMaL8F/A40vKQfoKnS7ctHy4OsHpkVbUfu6nxeLgmbE5+pmG6
         t407Tj9/V+O5f56l3/m5R0tpZUgbcNKZq/CxfDbUoeFhyElsi8IlCr6yFOkTWNDeOQgy
         AzKhWMMxu1dXTUwfDslNeVVP/HM6tGDBRUvvaE7c04UcwGZHgnY7S0SIVoLlFkZo4kdS
         5/zg==
X-Gm-Message-State: AC+VfDwTwr+pFazOtDU/uB1cR7qVO3va5xuAOKla9AWLRDHoe93DiDv1
        3LUfCXcggHEWBoKC4shJOnWfqVTZqEk=
X-Google-Smtp-Source: ACHHUZ5YJLdQah/W/tMY7iJH0G0Oh3SNU1wzhwLYsHh9dxqe48bB7pp7ZvuH5Ko26RlX33j77SRPhw==
X-Received: by 2002:a5d:65c9:0:b0:311:1120:f2a1 with SMTP id e9-20020a5d65c9000000b003111120f2a1mr13003537wrw.46.1687290243750;
        Tue, 20 Jun 2023 12:44:03 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id f12-20020a5d58ec000000b00309382eb047sm2604896wrd.112.2023.06.20.12.44.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Jun 2023 12:44:03 -0700 (PDT)
Message-Id: <8ec24b018e9a8a0767b1811aeb604eb97647bb4e.1687290233.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1497.v3.git.git.1687290231.gitgitgadget@gmail.com>
References: <pull.1497.v2.git.git.1685472132.gitgitgadget@gmail.com>
        <pull.1497.v3.git.git.1687290231.gitgitgadget@gmail.com>
From:   "Glen Choo via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 20 Jun 2023 19:43:49 +0000
Subject: [PATCH v3 10/12] config.c: remove config_reader from configsets
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

Remove the last usage of "struct config_reader" from configsets by
copying the "kvi" arg instead of recomputing "kvi" from
config_reader.source. Since we no longer need to pass both "struct
config_reader" and "struct config_set" in a single "void *cb", remove
"struct configset_add_data" too.

Signed-off-by: Glen Choo <chooglen@google.com>
---
 config.c | 42 ++++++++++--------------------------------
 1 file changed, 10 insertions(+), 32 deletions(-)

diff --git a/config.c b/config.c
index a2887b856aa..958ba166cf9 100644
--- a/config.c
+++ b/config.c
@@ -2303,8 +2303,7 @@ int config_with_options(config_fn_t fn, void *data,
 	return ret;
 }
 
-static void configset_iter(struct config_reader *reader, struct config_set *set,
-			   config_fn_t fn, void *data)
+static void configset_iter(struct config_set *set, config_fn_t fn, void *data)
 {
 	int i, value_index;
 	struct string_list *values;
@@ -2398,7 +2397,6 @@ static int configset_find_element(struct config_set *set, const char *key,
 }
 
 static int configset_add_value(const struct key_value_info *kvi_p,
-			       struct config_reader *reader,
 			       struct config_set *set, const char *key,
 			       const char *value)
 {
@@ -2429,11 +2427,7 @@ static int configset_add_value(const struct key_value_info *kvi_p,
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
@@ -2481,28 +2475,18 @@ void git_configset_clear(struct config_set *set)
 	set->list.items = NULL;
 }
 
-struct configset_add_data {
-	struct config_set *config_set;
-	struct config_reader *config_reader;
-};
-#define CONFIGSET_ADD_INIT { 0 }
-
 static int config_set_callback(const char *key, const char *value,
 			       const struct config_context *ctx,
 			       void *cb)
 {
-	struct configset_add_data *data = cb;
-	configset_add_value(ctx->kvi, data->config_reader, data->config_set,
-			    key, value);
+	struct config_set *set = cb;
+	configset_add_value(ctx->kvi, set, key, value);
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
@@ -2668,7 +2652,6 @@ int git_configset_get_pathname(struct config_set *set, const char *key, const ch
 static void repo_read_config(struct repository *repo)
 {
 	struct config_options opts = { 0 };
-	struct configset_add_data data = CONFIGSET_ADD_INIT;
 
 	opts.respect_includes = 1;
 	opts.commondir = repo->commondir;
@@ -2680,10 +2663,8 @@ static void repo_read_config(struct repository *repo)
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
@@ -2715,7 +2696,7 @@ static void repo_config_clear(struct repository *repo)
 void repo_config(struct repository *repo, config_fn_t fn, void *data)
 {
 	git_config_check_init(repo);
-	configset_iter(&the_reader, repo->config, fn, data);
+	configset_iter(repo->config, fn, data);
 }
 
 int repo_config_get(struct repository *repo, const char *key)
@@ -2822,19 +2803,16 @@ static void read_protected_config(void)
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

