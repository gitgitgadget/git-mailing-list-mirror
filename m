Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40367C77B7A
	for <git@archiver.kernel.org>; Tue, 30 May 2023 18:42:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231346AbjE3Smh (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 30 May 2023 14:42:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230255AbjE3Sm1 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 30 May 2023 14:42:27 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AE0110A
        for <git@vger.kernel.org>; Tue, 30 May 2023 11:42:23 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id 5b1f17b1804b1-3f6a6b9c079so34716435e9.1
        for <git@vger.kernel.org>; Tue, 30 May 2023 11:42:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685472142; x=1688064142;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NwdY4aGS3GND8VMsPLCB1Mh7TgltBjBVwlNjPvA0zh0=;
        b=LYGwXZs9UsV4re960KS0HXDmAptaLLllBYUPkDcT9Gp21tckLBUMJhQ7RQjWdsV14c
         Ll3o6Wcs1NtIxlcAvw8Dux90socsJmIEst+OiJdPrtCVyL2kXmfq7aTmcOKv2qGmTYur
         Lfkv/OU9oatgwv2GYoQsJDC2U6vp0GI2+Lq7op0HNK1hHKDM/Pjn0kjI7sfcKK7HLoSr
         4hhTarNIoDuFNb/danNEKyNY6mP6Z605jp470ICk/i8TozZjdwz2QvDeUhXKNBnQTyHA
         z47eBMV3D/PSbDKeV70mxM3/9X4RVGAPEtGe3DDQu2zQ1O4xxF7bsXBOGbbt4mSme0Th
         JOuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685472142; x=1688064142;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NwdY4aGS3GND8VMsPLCB1Mh7TgltBjBVwlNjPvA0zh0=;
        b=a6TA6yblhqQ6W4RSSc+0yHTCLsDGaO3NXnt+qdXv5xq1siCIPzCbvDr2yi7js4lIPo
         /nPPBHihCwoB3Zoa/bbtp7O+lz07utA7obo0QwCVDjJIPH1psSkxFM3nkDnI4oCvPZN9
         Evd2b8dWT0WvxxuWhxss+SC8GtRvS862/9LEMYPlAGR2iEX5AeeO1J4lZfqo00vuX/BI
         svpSsMSxoWc26hec0DqTqF7J3Kkj95IzWB3S5ydQdvOfA81DaObBKlh6Zvbny5u6Xv/N
         CTamNbgq2kcMGrvjyp9UvGj1TFIEmzUTfa1gOLo52ZWikB+H9g3Lki0uZro+rLM0Czy1
         1itQ==
X-Gm-Message-State: AC+VfDxFXo7YRkr5kZMh8aZ4eK0nXGOGk66Dh9QhJOxAelivmFs5MWB7
        9dPHmiQWe0fl50dvW8mGcWwvPxZXugE=
X-Google-Smtp-Source: ACHHUZ4dUgYRoHvJTMRqmaDZCXfKSwkxZfKvi6/efiOJ1f9E6uIz5ueHCPJ9k8Zj6Aibuaj+ROxH4w==
X-Received: by 2002:a1c:f60b:0:b0:3f6:8ea:3830 with SMTP id w11-20020a1cf60b000000b003f608ea3830mr2142361wmc.5.1685472141943;
        Tue, 30 May 2023 11:42:21 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id o11-20020a05600c378b00b003f195d540d9sm21828550wmr.14.2023.05.30.11.42.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 May 2023 11:42:21 -0700 (PDT)
Message-Id: <f57c1007cad106a6387c77ac4d06208d39bfb9f8.1685472133.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1497.v2.git.git.1685472132.gitgitgadget@gmail.com>
References: <pull.1497.git.git.1682104398.gitgitgadget@gmail.com>
        <pull.1497.v2.git.git.1685472132.gitgitgadget@gmail.com>
From:   "Glen Choo via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 30 May 2023 18:42:04 +0000
Subject: [PATCH v2 06/14] config.c: pass kvi in configsets
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

Trivially pass "struct key_value_info" to config callbacks in
configset_iter(). Then, in config callbacks that are only used with
configsets, use the "kvi" arg to replace calls to current_config_*(),
and delete current_config_line() because it has no remaining callers.

This leaves builtin/config.c and config.c as the only remaining users of
current_config_*().

Signed-off-by: Glen Choo <chooglen@google.com>
---
 builtin/remote.c       |  8 ++++----
 config.c               | 34 +++++++++++++++-------------------
 config.h               |  2 +-
 remote.c               |  6 +++---
 t/helper/test-config.c | 10 +++++-----
 5 files changed, 28 insertions(+), 32 deletions(-)

diff --git a/builtin/remote.c b/builtin/remote.c
index edb4a9ddd7f..0a18c49f1f8 100644
--- a/builtin/remote.c
+++ b/builtin/remote.c
@@ -646,17 +646,17 @@ struct push_default_info
 };
 
 static int config_read_push_default(const char *key, const char *value,
-	struct key_value_info *kvi UNUSED, void *cb)
+	struct key_value_info *kvi, void *cb)
 {
 	struct push_default_info* info = cb;
 	if (strcmp(key, "remote.pushdefault") ||
 	    !value || strcmp(value, info->old_name))
 		return 0;
 
-	info->scope = current_config_scope();
+	info->scope = kvi->scope;
 	strbuf_reset(&info->origin);
-	strbuf_addstr(&info->origin, current_config_name());
-	info->linenr = current_config_line();
+	strbuf_addstr(&info->origin, config_origin_type_name(kvi->origin_type));
+	info->linenr = kvi->linenr;
 
 	return 0;
 }
diff --git a/config.c b/config.c
index 1bc2e35a3e0..66078b22eef 100644
--- a/config.c
+++ b/config.c
@@ -2301,19 +2301,18 @@ static void configset_iter(struct config_reader *reader, struct config_set *set,
 	struct string_list *values;
 	struct config_set_element *entry;
 	struct configset_list *list = &set->list;
+	struct key_value_info *kvi;
 
 	for (i = 0; i < list->nr; i++) {
 		entry = list->items[i].e;
 		value_index = list->items[i].value_index;
 		values = &entry->value_list;
+		kvi = values->items[value_index].util;
 
 		config_reader_set_kvi(reader, values->items[value_index].util);
 
-		if (fn(entry->key, values->items[value_index].string, NULL, data) < 0)
-			git_die_config_linenr(entry->key,
-					      reader->config_kvi->filename,
-					      reader->config_kvi->linenr);
-
+		if (fn(entry->key, values->items[value_index].string, kvi, data) < 0)
+			git_die_config_linenr(entry->key, kvi->filename, kvi->linenr);
 		config_reader_set_kvi(reader, NULL);
 	}
 }
@@ -3951,13 +3950,8 @@ static int reader_origin_type(struct config_reader *reader,
 	return 0;
 }
 
-const char *current_config_origin_type(void)
+const char *config_origin_type_name(enum config_origin_type type)
 {
-	enum config_origin_type type = CONFIG_ORIGIN_UNKNOWN;
-
-	if (reader_origin_type(&the_reader, &type))
-		BUG("current_config_origin_type called outside config callback");
-
 	switch (type) {
 	case CONFIG_ORIGIN_BLOB:
 		return "blob";
@@ -3974,6 +3968,16 @@ const char *current_config_origin_type(void)
 	}
 }
 
+const char *current_config_origin_type(void)
+{
+	enum config_origin_type type = CONFIG_ORIGIN_UNKNOWN;
+
+	if (reader_origin_type(&the_reader, &type))
+		BUG("current_config_origin_type called outside config callback");
+
+	return config_origin_type_name(type);
+}
+
 const char *config_scope_name(enum config_scope scope)
 {
 	switch (scope) {
@@ -4021,14 +4025,6 @@ enum config_scope current_config_scope(void)
 		return the_reader.parsing_scope;
 }
 
-int current_config_line(void)
-{
-	if (the_reader.config_kvi)
-		return the_reader.config_kvi->linenr;
-	else
-		return the_reader.source->linenr;
-}
-
 int lookup_config(const char **mapping, int nr_mapping, const char *var)
 {
 	int i;
diff --git a/config.h b/config.h
index 9e0c1f12165..ea4ffe37a55 100644
--- a/config.h
+++ b/config.h
@@ -367,7 +367,7 @@ int git_config_parse_parameter(const char *, config_fn_t fn, void *data);
 enum config_scope current_config_scope(void);
 const char *current_config_origin_type(void);
 const char *current_config_name(void);
-int current_config_line(void);
+const char *config_origin_type_name(enum config_origin_type type);
 
 /*
  * Match and parse a config key of the form:
diff --git a/remote.c b/remote.c
index 10868a963f2..266601157e3 100644
--- a/remote.c
+++ b/remote.c
@@ -349,7 +349,7 @@ static void read_branches_file(struct remote_state *remote_state,
 }
 
 static int handle_config(const char *key, const char *value,
-			 struct key_value_info *kvi UNUSED, void *cb)
+			 struct key_value_info *kvi, void *cb)
 {
 	const char *name;
 	size_t namelen;
@@ -414,8 +414,8 @@ static int handle_config(const char *key, const char *value,
 	}
 	remote = make_remote(remote_state, name, namelen);
 	remote->origin = REMOTE_CONFIG;
-	if (current_config_scope() == CONFIG_SCOPE_LOCAL ||
-	    current_config_scope() == CONFIG_SCOPE_WORKTREE)
+	if (kvi->scope == CONFIG_SCOPE_LOCAL ||
+	    kvi->scope == CONFIG_SCOPE_WORKTREE)
 		remote->configured_in_repo = 1;
 	if (!strcmp(subkey, "mirror"))
 		remote->mirror = git_config_bool(key, value);
diff --git a/t/helper/test-config.c b/t/helper/test-config.c
index 00cd49e5145..7027ffa187f 100644
--- a/t/helper/test-config.c
+++ b/t/helper/test-config.c
@@ -43,7 +43,7 @@
  */
 
 static int iterate_cb(const char *var, const char *value,
-		      struct key_value_info *kvi UNUSED, void *data UNUSED)
+		      struct key_value_info *kvi, void *data UNUSED)
 {
 	static int nr;
 
@@ -52,10 +52,10 @@ static int iterate_cb(const char *var, const char *value,
 
 	printf("key=%s\n", var);
 	printf("value=%s\n", value ? value : "(null)");
-	printf("origin=%s\n", current_config_origin_type());
-	printf("name=%s\n", current_config_name());
-	printf("lno=%d\n", current_config_line());
-	printf("scope=%s\n", config_scope_name(current_config_scope()));
+	printf("origin=%s\n", config_origin_type_name(kvi->origin_type));
+	printf("name=%s\n", kvi->filename ? kvi->filename : "");
+	printf("lno=%d\n", kvi->linenr);
+	printf("scope=%s\n", config_scope_name(kvi->scope));
 
 	return 0;
 }
-- 
gitgitgadget

