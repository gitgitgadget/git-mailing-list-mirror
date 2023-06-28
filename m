Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50BAAEB64D7
	for <git@archiver.kernel.org>; Wed, 28 Jun 2023 19:26:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231903AbjF1T0x (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 28 Jun 2023 15:26:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229939AbjF1T0m (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Jun 2023 15:26:42 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A2AA1BD4
        for <git@vger.kernel.org>; Wed, 28 Jun 2023 12:26:41 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id ffacd0b85a97d-313df030ccaso212394f8f.1
        for <git@vger.kernel.org>; Wed, 28 Jun 2023 12:26:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687980399; x=1690572399;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HoUNGFp0HiayMWP2wM+yeSmJO3gqaXxhgJPNmDBa7hU=;
        b=dmkRwU1jcsBpubKY/8NFHqNE5jpA0F0z/hhXIvILMN454NDKiPKbGfFalVsevOawi1
         dv76gA4CX5UKyDRXk9crpCN4iZtDo8txu7c2VtE9EoSuar4oLcIAUDwyptKkKER3BQL7
         Waj1EAzzbxT7ZVIZONje5P0flW6hbv3lJxAyuAHyZ2S1kPtqc9lT9s3abqMz/WvAVLfk
         DghbIZsbBFVi8Y1i6gD5DbwNfkzikFAMrqdn6kGuXbNep7D4d3dzbia+J84RTqvGaAMj
         9f7nyPyWkwFRO9fwAbcaFJKHoVug7I4S9toK3J6AqyvuEITlunj1RhTbElLf/3zx5Usl
         D5Nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687980399; x=1690572399;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HoUNGFp0HiayMWP2wM+yeSmJO3gqaXxhgJPNmDBa7hU=;
        b=VCgVkGblg4Lm23O6z/mQJZsJcmuy/Zz/0yML9p+hcDAQhlhozh/TmUMdfGI9A3LvjN
         C5UiLJly1iDIcGWWoAdrYZ+AgDhR7CAJxFVsHEa2W1n49qIHD7Oi5veJvKTihL3gg8ka
         EGiAMi5ZHWOCD6Y9cqjIYHAUHFnz8RU2Da77Toln/EBrXto1Eoi/4ZNERd9rRcp6V2Zg
         RcGBBiWWfqTSt+q4vAi3TQCBqD2TlaLNQPHvQHNeoOJeGbwu5vazdSec+YlG4IAQF9NC
         Ym8pefAhkNZckb7XuymZA+GWAGxSE/zTDD7fhnNjC2s3RVxQlYivbLiXpUCpW51N3UuE
         /o6A==
X-Gm-Message-State: AC+VfDyodh/DuvbIhOzmSyC8MIXN03NKonEsec8862yL60lwx1saHhQ5
        RoQefNUuLrCiH12poMNWXAVKs8p40jE=
X-Google-Smtp-Source: ACHHUZ4RBjhpu4rL8yoqBsRVFKYfSV3p9UkSW+2YoveJH+s12yQ8omp+keaQwMHvg+BE4h0pm36E3g==
X-Received: by 2002:a5d:6a8a:0:b0:313:f9e7:a456 with SMTP id s10-20020a5d6a8a000000b00313f9e7a456mr6360398wru.11.1687980399223;
        Wed, 28 Jun 2023 12:26:39 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id k22-20020a05600c0b5600b003fb40f5f553sm7548358wmr.31.2023.06.28.12.26.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Jun 2023 12:26:39 -0700 (PDT)
Message-Id: <39b2e291f8669e1d77725619d6b3c2b34b2acecc.1687980393.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1497.v5.git.git.1687980390.gitgitgadget@gmail.com>
References: <pull.1497.v4.git.git.1687803083.gitgitgadget@gmail.com>
        <pull.1497.v5.git.git.1687980390.gitgitgadget@gmail.com>
From:   "Glen Choo via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 28 Jun 2023 19:26:23 +0000
Subject: [PATCH v5 04/11] config.c: pass ctx in configsets
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
index 850e432e301..662d406ac1e 100644
--- a/config.c
+++ b/config.c
@@ -2317,6 +2317,7 @@ static void configset_iter(struct config_reader *reader, struct config_set *set,
 	struct string_list *values;
 	struct config_set_element *entry;
 	struct configset_list *list = &set->list;
+	struct config_context ctx = CONFIG_CONTEXT_INIT;
 
 	for (i = 0; i < list->nr; i++) {
 		entry = list->items[i].e;
@@ -2324,12 +2325,11 @@ static void configset_iter(struct config_reader *reader, struct config_set *set,
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
@@ -3984,13 +3984,8 @@ static int reader_origin_type(struct config_reader *reader,
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
@@ -4007,6 +4002,16 @@ const char *current_config_origin_type(void)
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
@@ -4054,14 +4059,6 @@ enum config_scope current_config_scope(void)
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
index cd30125a8a4..ddf147bb2d1 100644
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
index 241999c2842..1dab860141b 100644
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

