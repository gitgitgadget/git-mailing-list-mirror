Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DB52EB64D8
	for <git@archiver.kernel.org>; Tue, 20 Jun 2023 19:44:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230469AbjFTToF (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 20 Jun 2023 15:44:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230032AbjFTToD (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Jun 2023 15:44:03 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B81F41710
        for <git@vger.kernel.org>; Tue, 20 Jun 2023 12:44:01 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id ffacd0b85a97d-31129591288so3356947f8f.1
        for <git@vger.kernel.org>; Tue, 20 Jun 2023 12:44:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687290240; x=1689882240;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Kcof/63XTVy+UiL45aVYuVZRvod0drN1/iNd+IyshxE=;
        b=nxN+Sgyd9EajBqSQhdYY6yuZAB6w4Jrg3huLWq5j6J0GSQ44Ouf3HT6XidBOUixGtx
         0vO5dOZPk7cNayRarOjVwRI33gHtRi+Nzvn/mhCw75X1cdmscjTd85MRCYA4zzedK5vx
         luKa9EJOML9M5Rbl5fcj6QxAzEGKTI0B4WtAu+FhXPmjx1Jp3sn2BxGUz6i9RnTS8yb0
         M8G5utiu+eJlxgK8W/pYyDV0rxFU8jUxsVfEFLJScedLtozX611PTDxPw8kKU4DxA4DH
         eADWjlsvfHB5H4mUJ4sR+xRz9gEd8C/dAZQJ94ep3JepO7gce9ERsk6ce/Amahfh+eC4
         anNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687290240; x=1689882240;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Kcof/63XTVy+UiL45aVYuVZRvod0drN1/iNd+IyshxE=;
        b=lfKh+PnUyGNnN7gudiOxVmFZUugRllLHEhucNtxPc8enTxcM/ONXsgZIR4rHW1UZDc
         ULXZwNej1GIpI8LijW/slfwz1LjuUISt9vmS5OrdQMYctitC9B8741/5RjO0IEuwAbj9
         gXOmdT6jqaKCOCYkUiC6jU+/4ZA9xElKWc5e5uKpdxnp2xlVao1vAsNbqY2pM/EkTBon
         48c4rpwH7cSDcMmo24/CZhovE43O/flq53Cl8hf/604ICCnL5oe9NwL4cQhw3KtxeHBP
         5CbEohd7R9xt7mSeN98+GmAYSgcfEAklpX47PNz5JcRXUgwWfNYECha0yya+oFvftO2v
         vsuQ==
X-Gm-Message-State: AC+VfDwIibza4UhALn6OyIEM+S0QFYNL8J7cbc1Qk2CJRzITp1TRHKbM
        4ah+iREi1+qyIoGlcMvXEVzoQsnkcOM=
X-Google-Smtp-Source: ACHHUZ7UorvtNtsCI0UvqxmeR33hkFOjC4YJfB5lRC/Tzg74eX+oSnLeRja0LCJPo1lymw06aNXa1Q==
X-Received: by 2002:a5d:45c6:0:b0:30f:c653:b819 with SMTP id b6-20020a5d45c6000000b0030fc653b819mr9407034wrs.14.1687290239794;
        Tue, 20 Jun 2023 12:43:59 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id s6-20020adfea86000000b0030ae3a6be5bsm2634641wrm.78.2023.06.20.12.43.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Jun 2023 12:43:59 -0700 (PDT)
Message-Id: <c5051ddc10dfa9665fbcbed30875369c4e972d17.1687290233.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1497.v3.git.git.1687290231.gitgitgadget@gmail.com>
References: <pull.1497.v2.git.git.1685472132.gitgitgadget@gmail.com>
        <pull.1497.v3.git.git.1687290231.gitgitgadget@gmail.com>
From:   "Glen Choo via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 20 Jun 2023 19:43:43 +0000
Subject: [PATCH v3 04/12] config.c: pass ctx in configsets
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

Pass config_context to config callbacks in configset_iter(), trivially
setting the .kvi member to the cached key_value_info. Then, in config
callbacks that are only used with configsets, use the .kvi member to
replace calls to current_config_*(), and delete current_config_line()
because it has no remaining callers.

This leaves builtin/config.c and config.c as the only remaining users of
current_config_*().

Signed-off-by: Glen Choo <chooglen@google.com>
---
 builtin/remote.c       | 10 ++++++----
 config.c               | 35 ++++++++++++++++-------------------
 config.h               |  2 +-
 remote.c               |  7 ++++---
 t/helper/test-config.c | 11 ++++++-----
 5 files changed, 33 insertions(+), 32 deletions(-)

diff --git a/builtin/remote.c b/builtin/remote.c
index 87de81105e2..d47f9ee21cf 100644
--- a/builtin/remote.c
+++ b/builtin/remote.c
@@ -646,17 +646,19 @@ struct push_default_info
 };
 
 static int config_read_push_default(const char *key, const char *value,
-	const struct config_context *ctx UNUSED, void *cb)
+	const struct config_context *ctx, void *cb)
 {
+	const struct key_value_info *kvi = ctx->kvi;
+
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
index 670d92cd76b..1e146c861b1 100644
--- a/config.c
+++ b/config.c
@@ -2309,6 +2309,7 @@ static void configset_iter(struct config_reader *reader, struct config_set *set,
 	struct string_list *values;
 	struct config_set_element *entry;
 	struct configset_list *list = &set->list;
+	struct config_context ctx = CONFIG_CONTEXT_INIT;
 
 	for (i = 0; i < list->nr; i++) {
 		entry = list->items[i].e;
@@ -2316,12 +2317,11 @@ static void configset_iter(struct config_reader *reader, struct config_set *set,
 		values = &entry->value_list;
 
 		config_reader_set_kvi(reader, values->items[value_index].util);
-
-		if (fn(entry->key, values->items[value_index].string, NULL, data) < 0)
+		ctx.kvi = values->items[value_index].util;
+		if (fn(entry->key, values->items[value_index].string, &ctx, data) < 0)
 			git_die_config_linenr(entry->key,
-					      reader->config_kvi->filename,
-					      reader->config_kvi->linenr);
-
+					      ctx.kvi->filename,
+					      ctx.kvi->linenr);
 		config_reader_set_kvi(reader, NULL);
 	}
 }
@@ -3974,13 +3974,8 @@ static int reader_origin_type(struct config_reader *reader,
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
@@ -3997,6 +3992,16 @@ const char *current_config_origin_type(void)
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
@@ -4044,14 +4049,6 @@ enum config_scope current_config_scope(void)
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
index bc52ceb72f2..b4236e120a8 100644
--- a/config.h
+++ b/config.h
@@ -387,7 +387,7 @@ int git_config_parse_parameter(const char *, config_fn_t fn, void *data);
 enum config_scope current_config_scope(void);
 const char *current_config_origin_type(void);
 const char *current_config_name(void);
-int current_config_line(void);
+const char *config_origin_type_name(enum config_origin_type type);
 
 /*
  * Match and parse a config key of the form:
diff --git a/remote.c b/remote.c
index dafb1acdc38..37d413e7892 100644
--- a/remote.c
+++ b/remote.c
@@ -350,7 +350,7 @@ static void read_branches_file(struct remote_state *remote_state,
 }
 
 static int handle_config(const char *key, const char *value,
-			 const struct config_context *ctx UNUSED, void *cb)
+			 const struct config_context *ctx, void *cb)
 {
 	const char *name;
 	size_t namelen;
@@ -358,6 +358,7 @@ static int handle_config(const char *key, const char *value,
 	struct remote *remote;
 	struct branch *branch;
 	struct remote_state *remote_state = cb;
+	const struct key_value_info *kvi = ctx->kvi;
 
 	if (parse_config_key(key, "branch", &name, &namelen, &subkey) >= 0) {
 		/* There is no subsection. */
@@ -415,8 +416,8 @@ static int handle_config(const char *key, const char *value,
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
index 85ad815358e..3f4c3678318 100644
--- a/t/helper/test-config.c
+++ b/t/helper/test-config.c
@@ -43,9 +43,10 @@
  */
 
 static int iterate_cb(const char *var, const char *value,
-		      const struct config_context *ctx UNUSED,
+		      const struct config_context *ctx,
 		      void *data UNUSED)
 {
+	const struct key_value_info *kvi = ctx->kvi;
 	static int nr;
 
 	if (nr++)
@@ -53,10 +54,10 @@ static int iterate_cb(const char *var, const char *value,
 
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

