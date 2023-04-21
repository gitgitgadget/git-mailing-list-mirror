Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 897A0C7618E
	for <git@archiver.kernel.org>; Fri, 21 Apr 2023 19:14:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233514AbjDUTOA (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 21 Apr 2023 15:14:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233494AbjDUTNt (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 Apr 2023 15:13:49 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7107C1BD1
        for <git@vger.kernel.org>; Fri, 21 Apr 2023 12:13:29 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id 5b1f17b1804b1-3f191c1a8a7so7406165e9.1
        for <git@vger.kernel.org>; Fri, 21 Apr 2023 12:13:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682104407; x=1684696407;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xZQcx+cDrstRj9pw3MXO5SVaKI/uKYBh/IIvYQUmAaM=;
        b=qLhGNvpXr4gJWuScx+TNv+RQhTvzuEOi2SZpP8rtjj51Y+AQinsb23vTrC44lfqXWO
         lj641+8konnomc1xcz4gtCfvTXe1YjnOuSjLB265YlnQgIQa+51DyKr3rj2ockUlncYk
         nBkeLIHBDAPJwFHeF4PJBv6DWq/SS6woQDQklgsOcaXkXY/x9U5D7yolrrDlG7RU+ona
         i53wYRS/tqfIHgaLrThEV+d77KxdLXpBTalmlsvKa0SzI7eE5y5vrmLJVbjtw6ZaKFOS
         MdA8TtVhQ15ecb6gLm2BhAAgP3Sl68cq3ijpC+zPycQ1Z+kdObtKpoh4lREOQDX1W9ML
         nTQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682104407; x=1684696407;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xZQcx+cDrstRj9pw3MXO5SVaKI/uKYBh/IIvYQUmAaM=;
        b=HRGL3HP7WLRSuspr5N9gh9TbgP44bwIxHgb7VeADHHRZF664hOG3aNKqd/UzQxgTue
         pvt5EGeUdyMamWv1H2RZ1WyHgXVKeLiZLsZYDJIaGsH0Gfz3nyxIjU5FMuZ96q4pPT0M
         5d8DZkE+Rixho4+rhvWGiCEt0vpfB8I/v/V+/IufXr5mnNn0M7xbqwYkO0d83cc1ieJR
         KF/sv63KO4vcV+RKMoWz/Yas+82kisc1HQ4OLRUnBBSHdzwmRoYjgs7vPSjhASJ7auWM
         cCfQfttpWRStE6ZNU0YZQ8f3BlImP+eWDNZAKD2RjoTkBOiXRuP2UOo8uF+tVKY2Ztdd
         2EPQ==
X-Gm-Message-State: AAQBX9foBnOTtVoA7zvX+jrVUP7AffC+A2/iSjUpb4Did0hkKS0Q3uGC
        m39mVgO1vmGyIkPPqNZzK4NfNsj4ujU=
X-Google-Smtp-Source: AKy350Z48uUBgTE8WLO4PKE7+GyRHnid3fAIFYVX1LQQS1JQi6Ep0X6IuJoLMywgr8WE/Z4nH7nDrw==
X-Received: by 2002:a7b:c3d8:0:b0:3f1:7972:429d with SMTP id t24-20020a7bc3d8000000b003f17972429dmr2714522wmj.18.1682104407613;
        Fri, 21 Apr 2023 12:13:27 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id p8-20020a05600c358800b003f1738d0d13sm12360248wmq.1.2023.04.21.12.13.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Apr 2023 12:13:27 -0700 (PDT)
Message-Id: <b38653477c75685af9d74b0d9b5605c41659c939.1682104399.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1497.git.git.1682104398.gitgitgadget@gmail.com>
References: <pull.1497.git.git.1682104398.gitgitgadget@gmail.com>
From:   "Glen Choo via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 21 Apr 2023 19:13:15 +0000
Subject: [PATCH 11/14] config: remove current_config_(line|name|origin_type)
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

Trivially replace current_config_(line|name|origin_type) by reading the
corresponding values from "struct key_value_info". This includes some
light "kvi" plumbing for builtin/config.c, and for *origin_type,
splitting out a function that turns "enum config_origin_type" into the
human-readable string that callbacks actually want.

Signed-off-by: Glen Choo <chooglen@google.com>
---
 builtin/config.c       | 25 +++++++++++++------------
 builtin/remote.c       |  6 +++---
 config.c               | 23 +----------------------
 config.h               |  4 +---
 t/helper/test-config.c |  8 ++++----
 5 files changed, 22 insertions(+), 44 deletions(-)

diff --git a/builtin/config.c b/builtin/config.c
index b2ad7351d0a..2ffa25139c6 100644
--- a/builtin/config.c
+++ b/builtin/config.c
@@ -191,16 +191,16 @@ static void check_argc(int argc, int min, int max)
 	usage_builtin_config();
 }
 
-static void show_config_origin(struct strbuf *buf)
+static void show_config_origin(struct key_value_info *kvi, struct strbuf *buf)
 {
 	const char term = end_nul ? '\0' : '\t';
 
-	strbuf_addstr(buf, current_config_origin_type());
+	strbuf_addstr(buf, config_origin_type_name(kvi->origin_type));
 	strbuf_addch(buf, ':');
 	if (end_nul)
-		strbuf_addstr(buf, current_config_name());
+		strbuf_addstr(buf, kvi->filename ? kvi->filename : "");
 	else
-		quote_c_style(current_config_name(), buf, NULL, 0);
+		quote_c_style(kvi->filename ? kvi->filename : "", buf, NULL, 0);
 	strbuf_addch(buf, term);
 }
 
@@ -214,14 +214,14 @@ static void show_config_scope(struct strbuf *buf)
 }
 
 static int show_all_config(const char *key_, const char *value_,
-			   struct key_value_info *kvi UNUSED, void *cb UNUSED)
+			   struct key_value_info *kvi, void *cb UNUSED)
 {
 	if (show_origin || show_scope) {
 		struct strbuf buf = STRBUF_INIT;
 		if (show_scope)
 			show_config_scope(&buf);
 		if (show_origin)
-			show_config_origin(&buf);
+			show_config_origin(kvi, &buf);
 		/* Use fwrite as "buf" can contain \0's if "end_null" is set. */
 		fwrite(buf.buf, 1, buf.len, stdout);
 		strbuf_release(&buf);
@@ -239,12 +239,13 @@ struct strbuf_list {
 	int alloc;
 };
 
-static int format_config(struct strbuf *buf, const char *key_, const char *value_)
+static int format_config(struct strbuf *buf, const char *key_, const char *value_,
+			 struct key_value_info *kvi)
 {
 	if (show_scope)
 		show_config_scope(buf);
 	if (show_origin)
-		show_config_origin(buf);
+		show_config_origin(kvi, buf);
 	if (show_keys)
 		strbuf_addstr(buf, key_);
 	if (!omit_values) {
@@ -299,7 +300,7 @@ static int format_config(struct strbuf *buf, const char *key_, const char *value
 }
 
 static int collect_config(const char *key_, const char *value_,
-			  struct key_value_info *kvi UNUSED, void *cb)
+			  struct key_value_info *kvi, void *cb)
 {
 	struct strbuf_list *values = cb;
 
@@ -316,7 +317,7 @@ static int collect_config(const char *key_, const char *value_,
 	ALLOC_GROW(values->items, values->nr + 1, values->alloc);
 	strbuf_init(&values->items[values->nr], 0);
 
-	return format_config(&values->items[values->nr++], key_, value_);
+	return format_config(&values->items[values->nr++], key_, value_, kvi);
 }
 
 static int get_value(const char *key_, const char *regex_, unsigned flags)
@@ -381,7 +382,7 @@ static int get_value(const char *key_, const char *regex_, unsigned flags)
 		ALLOC_GROW(values.items, values.nr + 1, values.alloc);
 		item = &values.items[values.nr++];
 		strbuf_init(item, 0);
-		if (format_config(item, key_, default_value) < 0)
+		if (format_config(item, key_, default_value, NULL) < 0)
 			die(_("failed to format default config value: %s"),
 				default_value);
 	}
@@ -618,7 +619,7 @@ static int get_urlmatch(const char *var, const char *url)
 		struct strbuf buf = STRBUF_INIT;
 
 		format_config(&buf, item->string,
-			      matched->value_is_null ? NULL : matched->value.buf);
+			      matched->value_is_null ? NULL : matched->value.buf, NULL);
 		fwrite(buf.buf, 1, buf.len, stdout);
 		strbuf_release(&buf);
 
diff --git a/builtin/remote.c b/builtin/remote.c
index edb4a9ddd7f..fc4ea993ebb 100644
--- a/builtin/remote.c
+++ b/builtin/remote.c
@@ -646,7 +646,7 @@ struct push_default_info
 };
 
 static int config_read_push_default(const char *key, const char *value,
-	struct key_value_info *kvi UNUSED, void *cb)
+	struct key_value_info *kvi, void *cb)
 {
 	struct push_default_info* info = cb;
 	if (strcmp(key, "remote.pushdefault") ||
@@ -655,8 +655,8 @@ static int config_read_push_default(const char *key, const char *value,
 
 	info->scope = current_config_scope();
 	strbuf_reset(&info->origin);
-	strbuf_addstr(&info->origin, current_config_name());
-	info->linenr = current_config_line();
+	strbuf_addstr(&info->origin, kvi->filename);
+	info->linenr = kvi->linenr;
 
 	return 0;
 }
diff --git a/config.c b/config.c
index aa183f6f244..0a5443243dc 100644
--- a/config.c
+++ b/config.c
@@ -3917,13 +3917,8 @@ static int reader_origin_type(struct config_reader *reader,
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
@@ -3969,14 +3964,6 @@ static int reader_config_name(struct config_reader *reader, const char **out)
 	return 0;
 }
 
-const char *current_config_name(void)
-{
-	const char *name;
-	if (reader_config_name(&the_reader, &name))
-		BUG("current_config_name called outside config callback");
-	return name ? name : "";
-}
-
 enum config_scope current_config_scope(void)
 {
 	if (the_reader.config_kvi)
@@ -3991,14 +3978,6 @@ enum config_scope current_config_scope(void)
 		return CONFIG_SCOPE_UNKNOWN;
 }
 
-int current_config_line(void)
-{
-	if (the_reader.config_kvi)
-		return the_reader.config_kvi->linenr;
-	else
-		BUG("current_config_line called outside config callback");
-}
-
 int lookup_config(const char **mapping, int nr_mapping, const char *var)
 {
 	int i;
diff --git a/config.h b/config.h
index e4893e237e1..fb16c4aca77 100644
--- a/config.h
+++ b/config.h
@@ -375,9 +375,7 @@ void git_global_config(char **user, char **xdg);
 int git_config_parse_parameter(const char *, config_fn_t fn, void *data);
 
 enum config_scope current_config_scope(void);
-const char *current_config_origin_type(void);
-const char *current_config_name(void);
-int current_config_line(void);
+const char *config_origin_type_name(enum config_origin_type type);
 
 /*
  * Match and parse a config key of the form:
diff --git a/t/helper/test-config.c b/t/helper/test-config.c
index 00cd49e5145..337587df41d 100644
--- a/t/helper/test-config.c
+++ b/t/helper/test-config.c
@@ -43,7 +43,7 @@
  */
 
 static int iterate_cb(const char *var, const char *value,
-		      struct key_value_info *kvi UNUSED, void *data UNUSED)
+		      struct key_value_info *kvi, void *data UNUSED)
 {
 	static int nr;
 
@@ -52,9 +52,9 @@ static int iterate_cb(const char *var, const char *value,
 
 	printf("key=%s\n", var);
 	printf("value=%s\n", value ? value : "(null)");
-	printf("origin=%s\n", current_config_origin_type());
-	printf("name=%s\n", current_config_name());
-	printf("lno=%d\n", current_config_line());
+	printf("origin=%s\n", config_origin_type_name(kvi->origin_type));
+	printf("name=%s\n", kvi->filename ? kvi->filename : "");
+	printf("lno=%d\n", kvi->linenr);
 	printf("scope=%s\n", config_scope_name(current_config_scope()));
 
 	return 0;
-- 
gitgitgadget

