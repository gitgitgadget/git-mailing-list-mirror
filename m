Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B063EC7618E
	for <git@archiver.kernel.org>; Fri, 21 Apr 2023 19:14:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233293AbjDUTOD (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 21 Apr 2023 15:14:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233470AbjDUTNu (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 Apr 2023 15:13:50 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3A3D30C0
        for <git@vger.kernel.org>; Fri, 21 Apr 2023 12:13:30 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id ffacd0b85a97d-2f86ee42669so2020670f8f.2
        for <git@vger.kernel.org>; Fri, 21 Apr 2023 12:13:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682104410; x=1684696410;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KCS8EuGOJ+3i8Nh6ql6erR2ZLU3MRiOjA+7OQ098TTc=;
        b=NlHKWshFInaDEit334a37tWz8oE/fnr9rdtLkG53ZbHLbQ1LC279qyuV7CgQX/bFgY
         nxG0IloGiJM7TS+ZmDUR4eKgfhJjUphPLR9GZ7i3obuHUaCy/4WGwzJZrKcKewulPFns
         Rz/tWC6NLDydtpMYH5wf5CbzwhjNI9lKQKEyhFaGCMFMZICaVXtdRf9odBMeDsHp9DLL
         yuZqBmw9YkrHic1ARqSVSjnI+gBmbcSkJQbbXskIr5GO/3wbpEMzngurJjLZ7l1rullV
         ySlPMg9VNATc5iS+wCXu1HhnOv7IQGa7VZ1oh0IQYGxwvMHdhNZ2BnNIYJyLnFkAqZn6
         0mNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682104410; x=1684696410;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KCS8EuGOJ+3i8Nh6ql6erR2ZLU3MRiOjA+7OQ098TTc=;
        b=FsFSZhESGEfxTnpwhsnxIPVnv/Xf/nfhj+A5zisk7pBd3ZjGebUHL7O92K3NjiV3H0
         48y7k97Nw96SEDRtzuoVhxdc/1S0QMMKXEn+wkC0JZ+CvKH/xuM7+iD1mPcipaQSdB8F
         P/y9dozstJCDS0AIBIX0hArmSLGZpHjTejhyxS9sNE9ItVGUQXu4IN3SQC78BTqerzx3
         5uZxeotpYuxfs/FxSP+LX27W0/SPQPMP0yZ6xJ8B8jNC0PgiA/S9siS3OCAp0UgY2h9m
         q8l7dqh84Jl27nqpEBymgc7f7bgUYL29brXVzr/nDoRPJ0f4tWZZ6dJC2V229MOIgm/P
         05Ig==
X-Gm-Message-State: AAQBX9cRNvO0HF5CRfjjWTAxvVgNyuSF/NDw+FAA8Lsy2JC3JeGBNo4T
        ksoe5h+/1qDx1P6JEdHAJLV5EP9cY0A=
X-Google-Smtp-Source: AKy350bKXnCbAbeCySOgZmnXbZu09B0KnmEsZzpOwDv9NnMoVO7hRMm/PZwbIdms1Bqpk8gb0/eYgg==
X-Received: by 2002:a5d:55cf:0:b0:2ff:613c:af5d with SMTP id i15-20020a5d55cf000000b002ff613caf5dmr4361194wrw.36.1682104409820;
        Fri, 21 Apr 2023 12:13:29 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id u8-20020a7bc048000000b003f1952a4bdesm1764737wmc.26.2023.04.21.12.13.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Apr 2023 12:13:29 -0700 (PDT)
Message-Id: <33e59152293136e6430cc47e311c1167da167e37.1682104399.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1497.git.git.1682104398.gitgitgadget@gmail.com>
References: <pull.1497.git.git.1682104398.gitgitgadget@gmail.com>
From:   "Glen Choo via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 21 Apr 2023 19:13:18 +0000
Subject: [PATCH 14/14] config: remove config_reader from configset_add_value
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

Since we now get "kvi" from the config callback, we can stop passing it
via "*data". Now "struct config_reader" has no more references, so get
rid of it.

Signed-off-by: Glen Choo <chooglen@google.com>
---
 config.c | 81 ++++++++++----------------------------------------------
 1 file changed, 14 insertions(+), 67 deletions(-)

diff --git a/config.c b/config.c
index e78de67c452..fbb4aab46cf 100644
--- a/config.c
+++ b/config.c
@@ -59,33 +59,6 @@ struct config_source {
 };
 #define CONFIG_SOURCE_INIT { 0 }
 
-struct config_reader {
-	struct key_value_info *config_kvi;
-};
-/*
- * Where possible, prefer to accept "struct config_reader" as an arg than to use
- * "the_reader". "the_reader" should only be used if that is infeasible, e.g. in
- * a public function.
- */
-static struct config_reader the_reader;
-
-static inline void config_reader_push_kvi(struct config_reader *reader,
-					  struct key_value_info *kvi)
-{
-	kvi->prev = reader->config_kvi;
-	reader->config_kvi = kvi;
-}
-
-static inline struct key_value_info *config_reader_pop_kvi(struct config_reader *reader)
-{
-	struct key_value_info *ret;
-	if (!reader->config_kvi)
-		BUG("tried to pop config_kvi, but we weren't reading config");
-	ret = reader->config_kvi;
-	reader->config_kvi = reader->config_kvi->prev;
-	return ret;
-}
-
 static int pack_compression_seen;
 static int zlib_compression_seen;
 
@@ -429,8 +402,6 @@ static int include_condition_is_true(struct key_value_info *kvi,
 	return 0;
 }
 
-static int kvi_fn(config_fn_t fn, const char *key, const char *value,
-		  struct key_value_info *kvi, void *data);
 static int git_config_include(const char *var, const char *value,
 			      struct key_value_info *kvi, void *data)
 {
@@ -443,7 +414,7 @@ static int git_config_include(const char *var, const char *value,
 	 * Pass along all values, including "include" directives; this makes it
 	 * possible to query information on the includes themselves.
 	 */
-	ret = kvi_fn(inc->fn, var, value, kvi, inc->data);
+	ret = inc->fn(var, value, kvi, inc->data);
 	if (ret < 0)
 		return ret;
 
@@ -614,16 +585,6 @@ out_free_ret_1:
 	return -CONFIG_INVALID_KEY;
 }
 
-static int kvi_fn(config_fn_t fn, const char *key, const char *value,
-		  struct key_value_info *kvi, void *data)
-{
-	int ret;
-	config_reader_push_kvi(&the_reader, kvi);
-	ret = fn(key, value, kvi, data);
-	config_reader_pop_kvi(&the_reader);
-	return ret;
-}
-
 static int config_parse_pair(const char *key, const char *value,
 			     struct key_value_info *kvi,
 			     config_fn_t fn, void *data)
@@ -636,7 +597,7 @@ static int config_parse_pair(const char *key, const char *value,
 	if (git_config_parse_key(key, &canonical_name, NULL))
 		return -1;
 
-	ret = (kvi_fn(fn, canonical_name, value, kvi, data) < 0) ? -1 : 0;
+	ret = (fn(canonical_name, value, kvi, data) < 0) ? -1 : 0;
 	free(canonical_name);
 	return ret;
 }
@@ -937,7 +898,7 @@ static int get_value(struct config_source *cs, struct key_value_info *kvi,
 	 */
 	cs->linenr--;
 	kvi->linenr = cs->linenr;
-	ret = kvi_fn(fn, name->buf, value, kvi, data);
+	ret = fn(name->buf, value, kvi, data);
 	if (ret >= 0)
 		cs->linenr++;
 	return ret;
@@ -2289,8 +2250,8 @@ static void configset_iter(struct config_set *set, config_fn_t fn, void *data)
 		values = &entry->value_list;
 		kvi = values->items[value_index].util;
 
-		if (kvi_fn(fn, entry->key, values->items[value_index].string,
-			   kvi, data) < 0)
+		if (fn(entry->key, values->items[value_index].string, kvi,
+		       data) < 0)
 			git_die_config_linenr(entry->key, kvi->filename,
 					      kvi->linenr);
 	}
@@ -2368,9 +2329,8 @@ static int configset_find_element(struct config_set *set, const char *key,
 	return 0;
 }
 
-static int configset_add_value(struct config_reader *reader,
-			       struct config_set *set, const char *key,
-			       const char *value)
+static int configset_add_value(struct config_set *set, const char *key,
+			       const char *value, struct key_value_info *kvi_p)
 {
 	struct config_set_element *e;
 	struct string_list_item *si;
@@ -2399,7 +2359,7 @@ static int configset_add_value(struct config_reader *reader,
 	l_item->e = e;
 	l_item->value_index = e->value_list.nr - 1;
 
-	memcpy(kv_info, reader->config_kvi, sizeof(struct key_value_info));
+	memcpy(kv_info, kvi_p, sizeof(struct key_value_info));
 	si->util = kv_info;
 
 	return 0;
@@ -2447,26 +2407,19 @@ void git_configset_clear(struct config_set *set)
 	set->list.items = NULL;
 }
 
-struct configset_add_data {
-	struct config_set *config_set;
-	struct config_reader *config_reader;
-};
 #define CONFIGSET_ADD_INIT { 0 }
 
 static int config_set_callback(const char *key, const char *value,
-			       struct key_value_info *kvi UNUSED, void *cb)
+			       struct key_value_info *kvi, void *cb)
 {
-	struct configset_add_data *data = cb;
-	configset_add_value(data->config_reader, data->config_set, key, value);
+	struct config_set *set = cb;
+	configset_add_value(set, key, value, kvi);
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
@@ -2632,7 +2585,6 @@ int git_configset_get_pathname(struct config_set *set, const char *key, const ch
 static void repo_read_config(struct repository *repo)
 {
 	struct config_options opts = { 0 };
-	struct configset_add_data data = CONFIGSET_ADD_INIT;
 
 	opts.respect_includes = 1;
 	opts.commondir = repo->commondir;
@@ -2644,10 +2596,8 @@ static void repo_read_config(struct repository *repo)
 		git_configset_clear(repo->config);
 
 	git_configset_init(repo->config);
-	data.config_set = repo->config;
-	data.config_reader = &the_reader;
 
-	if (config_with_options(config_set_callback, &data, NULL, &opts) < 0)
+	if (config_with_options(config_set_callback, repo->config, NULL, &opts) < 0)
 		/*
 		 * config_with_options() normally returns only
 		 * zero, as most errors are fatal, and
@@ -2786,12 +2736,9 @@ static void read_protected_config(void)
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
-- 
gitgitgadget
