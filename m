Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8256EB64DD
	for <git@archiver.kernel.org>; Mon, 26 Jun 2023 18:12:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231469AbjFZSMF (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 26 Jun 2023 14:12:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231339AbjFZSLt (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Jun 2023 14:11:49 -0400
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9C5410DA
        for <git@vger.kernel.org>; Mon, 26 Jun 2023 11:11:37 -0700 (PDT)
Received: by mail-lj1-x22c.google.com with SMTP id 38308e7fff4ca-2b69a48368fso28479821fa.0
        for <git@vger.kernel.org>; Mon, 26 Jun 2023 11:11:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687803096; x=1690395096;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1wmf3yCKsGuKrO03dBxJBfi54EjTv7IpL8xkOm3bYnQ=;
        b=cCtZPUvuhOTQoESbxN69l3uauSiKm6OX1ZQYsA5NBKIa+E75PZHKE6CQuPmORtwRQL
         A6RypK8B2c/AaMIwNhyU/GytgPeGX0BZ1Gabvc7i4WH8Rpi2N5B8kQZzFTT+8KKb0/FB
         eJfNwcvoMHMVHbwahLZn6cJ9mBjAjChvOAbO2u3SNvzOMz2mOximhY+4aZaI/EGYt/57
         I0YZihQTZyoHbC50zr3JqUhhXI85x0AEQeeHzDduVw3Sdx+8JkEKR5kczpb6vdq/cFXi
         f4pNPvIcr4eH2SDSx9ajviSqSRN7ZjsFmdxXZlqdNOP72/jyEQwtVfQWWQrAXlUGL3Np
         yt7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687803096; x=1690395096;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1wmf3yCKsGuKrO03dBxJBfi54EjTv7IpL8xkOm3bYnQ=;
        b=ikdCMy2KH4QAa8itOQaSAa0Pebxl+gjkzFMw2A20b2+YviOgZ03uS9jyx2wfb9QdCs
         2bbvmfDOF8KUSG+N28FWT57LZ1v1A4JavQkRJUW7OGfDbKOTJEoqXltjbc3PQ6rNyQLf
         pVh/CZoOdE5NnZmDyrObGSef0nXM+a4sTzuOdL7qaJD/EEbJqL57NR+97EJeeJWcZ7ET
         VUS1AeJ5fbcE9ZOmwueeSfnQxgzPgt1CIUE7hTtlzCWNysE3ciBasKSbSH8uJo/tnKND
         FFmQJdwATw/FAYSu8k7JDOVNw/geWP7PsSHZcgLBCCeyAR1aIPrsK+uV2l6d+/LiJ18d
         yBHw==
X-Gm-Message-State: AC+VfDz8jESjKATz6yXzlWxIex08hzGQFEzBMjxj+2rxMAvoMm+xMx+O
        Og/sUiKqWGDdmlKsX1eLo2xa+wNrXXc=
X-Google-Smtp-Source: ACHHUZ6PnFSMzVNc+NfsnTeaXsOdelyug6jeR5OffAoY/MsHuJcM3nGyRtVFI8KR5gr/vrfE7nuobg==
X-Received: by 2002:a05:651c:10c:b0:2b6:a3a4:f7e8 with SMTP id a12-20020a05651c010c00b002b6a3a4f7e8mr1821535ljb.17.1687803095798;
        Mon, 26 Jun 2023 11:11:35 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id o11-20020a05600c378b00b003fa95f328afsm3814732wmr.29.2023.06.26.11.11.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Jun 2023 11:11:35 -0700 (PDT)
Message-Id: <807057b6d7f0f5c77fede1b4d83550965e28d567.1687803086.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1497.v4.git.git.1687803083.gitgitgadget@gmail.com>
References: <pull.1497.v3.git.git.1687290231.gitgitgadget@gmail.com>
        <pull.1497.v4.git.git.1687803083.gitgitgadget@gmail.com>
From:   "Glen Choo via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 26 Jun 2023 18:11:21 +0000
Subject: [PATCH v4 10/12] config.c: remove config_reader from configsets
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Emily Shaffer <nasamuffin@google.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Jeff King <peff@peff.net>, Glen Choo <chooglen@google.com>,
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
 config.c | 43 +++++++++++--------------------------------
 1 file changed, 11 insertions(+), 32 deletions(-)

diff --git a/config.c b/config.c
index a9a45e4ffe0..4782a289363 100644
--- a/config.c
+++ b/config.c
@@ -2311,8 +2311,7 @@ int config_with_options(config_fn_t fn, void *data,
 	return ret;
 }
 
-static void configset_iter(struct config_reader *reader, struct config_set *set,
-			   config_fn_t fn, void *data)
+static void configset_iter(struct config_set *set, config_fn_t fn, void *data)
 {
 	int i, value_index;
 	struct string_list *values;
@@ -2406,7 +2405,6 @@ static int configset_find_element(struct config_set *set, const char *key,
 }
 
 static int configset_add_value(const struct key_value_info *kvi_p,
-			       struct config_reader *reader,
 			       struct config_set *set, const char *key,
 			       const char *value)
 {
@@ -2437,11 +2435,7 @@ static int configset_add_value(const struct key_value_info *kvi_p,
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
@@ -2489,28 +2483,18 @@ void git_configset_clear(struct config_set *set)
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
@@ -2676,7 +2660,6 @@ int git_configset_get_pathname(struct config_set *set, const char *key, const ch
 static void repo_read_config(struct repository *repo)
 {
 	struct config_options opts = { 0 };
-	struct configset_add_data data = CONFIGSET_ADD_INIT;
 
 	opts.respect_includes = 1;
 	opts.commondir = repo->commondir;
@@ -2688,10 +2671,8 @@ static void repo_read_config(struct repository *repo)
 		git_configset_clear(repo->config);
 
 	git_configset_init(repo->config);
-	data.config_set = repo->config;
-	data.config_reader = &the_reader;
-
-	if (config_with_options(config_set_callback, &data, NULL, repo, &opts) < 0)
+	if (config_with_options(config_set_callback, repo->config, NULL,
+				repo, &opts) < 0)
 		/*
 		 * config_with_options() normally returns only
 		 * zero, as most errors are fatal, and
@@ -2723,7 +2704,7 @@ static void repo_config_clear(struct repository *repo)
 void repo_config(struct repository *repo, config_fn_t fn, void *data)
 {
 	git_config_check_init(repo);
-	configset_iter(&the_reader, repo->config, fn, data);
+	configset_iter(repo->config, fn, data);
 }
 
 int repo_config_get(struct repository *repo, const char *key)
@@ -2830,19 +2811,17 @@ static void read_protected_config(void)
 		.ignore_worktree = 1,
 		.system_gently = 1,
 	};
-	struct configset_add_data data = CONFIGSET_ADD_INIT;
 
 	git_configset_init(&protected_config);
-	data.config_set = &protected_config;
-	data.config_reader = &the_reader;
-	config_with_options(config_set_callback, &data, NULL, NULL, &opts);
+	config_with_options(config_set_callback, &protected_config, NULL,
+			    NULL, &opts);
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

