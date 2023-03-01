Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5868C64EC4
	for <git@archiver.kernel.org>; Wed,  1 Mar 2023 00:38:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229775AbjCAAiZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 28 Feb 2023 19:38:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229582AbjCAAiX (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Feb 2023 19:38:23 -0500
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15A28B765
        for <git@vger.kernel.org>; Tue, 28 Feb 2023 16:38:22 -0800 (PST)
Received: by mail-wm1-x331.google.com with SMTP id l7-20020a05600c4f0700b003e79fa98ce1so6919018wmq.2
        for <git@vger.kernel.org>; Tue, 28 Feb 2023 16:38:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=J/IwQTJmndKxRu4J2lk4OcPkcSdZ0ZcfzN15S5g41xg=;
        b=VKeciw4AlKmWv1pMLf0Wx2DG826vfaz8+eiToblE9Zcmmpfda6CbCrsOOI926hzWB9
         L1JCTsQu44Y2CF7wPdf45J5tPPfwzDsLuSNGfhX5dZWbocXkHOigqvRTTZIcNM7M7a/B
         ONyBNkt3XpVAbn9MgsYzHvBlhfj3f02XgMAsUFuqN63ARIHoP3QJiAcra7iSa4zMkfnq
         ATJQx/gAvR9Zwb2Sxp44GAglG1kbTSQEtbr/LZy5irMzD8U3zS7dYpIXBax90zAfh9ze
         y+S2xRbCFk9Pd509N5H/FGH3e71Fo/rZdoXKjNWN7TYckZLZjn3yqnq/9SAxxQKVjIdd
         xhgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=J/IwQTJmndKxRu4J2lk4OcPkcSdZ0ZcfzN15S5g41xg=;
        b=OMokRl0MMmDKwvQc5vYUHH5ldgC+RM9YpcUiH0UI6qZopGq0ld0rRwjV8tUFYnN6T6
         8EozHbromut305nqC5ONukqmc0qvnyHlRODqkuMBLglnzAO91wF2Kqh/q5g6BKHjgEmV
         vhJxKovj3DhAICDfy7LegS+HTfsyfMdH6RJMXHPJZQX6GlA7tzIKe4uo5mUfVyvvJ+s4
         xMuiaFY3LgNH1+VD4o36w5ye2bLqZOf6UgtV3JMqirQRMF0WkQhj4tv3mchXVDGH3N6S
         Y06ujUI5c6IEnZawWaMEs2+ihFZxRg3Hc7s7XPnaF+8lOuEnDBC4chGeyNFuR/2+7PeA
         pV5A==
X-Gm-Message-State: AO0yUKVdxHRs3WFXGwMpxuSvvwdL2pBx9NzwPdac0yOPxQFRbcDAR8Xo
        0tJYIf6TYGrR/TlX9fjz/KRFTE6G4vM=
X-Google-Smtp-Source: AK7set/mShRpKGejCK5/zxiriKkEla2uMiuzY9mksWk+mAAucI61RvtUtcaAdnnWihPcHlGmI7l8RQ==
X-Received: by 2002:a05:600c:4e12:b0:3eb:3998:8bca with SMTP id b18-20020a05600c4e1200b003eb39988bcamr8572423wmq.17.1677631100425;
        Tue, 28 Feb 2023 16:38:20 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id v7-20020a05600c470700b003eb3933ef10sm12492618wmo.46.2023.02.28.16.38.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Feb 2023 16:38:19 -0800 (PST)
Message-Id: <9f72cbb8d78265c85c3e6405a5a61cf35db5ebca.1677631097.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1463.git.git.1677631097.gitgitgadget@gmail.com>
References: <pull.1463.git.git.1677631097.gitgitgadget@gmail.com>
From:   "Glen Choo via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 01 Mar 2023 00:38:13 +0000
Subject: [PATCH 2/6] config.c: don't assign to "cf" directly
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>,
        Emily Shaffer <nasamuffin@google.com>,
        Jeff King <peff@peff.net>,
        Derrick Stolee <derrickstolee@github.com>,
        Glen Choo <chooglen@google.com>,
        Glen Choo <chooglen@google.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Glen Choo <chooglen@google.com>

To make "cf" easier to remove, replace all direct assignments to it with
function calls. This refactor has an additional maintainability benefit:
all of these functions were manually implementing stack pop/push
semantics on "struct config_source", so replacing them with function
calls allows us to only implement this logic once.

In this process, perform some now-obvious clean ups:

- Drop some unnecessary "cf" assignments in populate_remote_urls().
  Since it was introduced in 399b198489 (config: include file if remote
  URL matches a glob, 2022-01-18), it has stored and restored the value
  of "cf" to ensure that it doesn't get accidentally mutated. However,
  this was never necessary since "do_config_from()" already pushes/pops
  "cf" further down the call chain.

- Zero out every "struct config_source" with a dedicated initializer.
  This matters because the "struct config_source" is assigned to "cf"
  and we later 'pop the stack' by assigning "cf = cf->prev", but
  "cf->prev" could be pointing to uninitialized garbage.

  Fortunately, this has never bothered us since we never try to read
  "cf" except while iterating through config, in which case, "cf" is
  either set to a sensible value (when parsing a file), or it is ignored
  (when iterating a configset). Later in the series, zero-ing out memory
  will also let us enforce the constraint that "cf" and
  "current_config_kvi" are never non-NULL together.

Signed-off-by: Glen Choo <chooglen@google.com>
---
 config.c | 40 ++++++++++++++++++++++++++--------------
 1 file changed, 26 insertions(+), 14 deletions(-)

diff --git a/config.c b/config.c
index 84ae97741ac..1f89addc771 100644
--- a/config.c
+++ b/config.c
@@ -49,6 +49,7 @@ struct config_source {
 	int (*do_ungetc)(int c, struct config_source *conf);
 	long (*do_ftell)(struct config_source *c);
 };
+#define CONFIG_SOURCE_INIT { 0 }
 
 /*
  * These variables record the "current" config source, which
@@ -78,6 +79,23 @@ static struct key_value_info *current_config_kvi;
  */
 static enum config_scope current_parsing_scope;
 
+static inline void config_state_push_source(struct config_source *top)
+{
+	if (cf)
+		top->prev = cf;
+	cf = top;
+}
+
+static inline struct config_source *config_state_pop_source()
+{
+	struct config_source *ret;
+	if (!cf)
+		BUG("tried to pop config source, but we weren't reading config");
+	ret = cf;
+	cf = cf->prev;
+	return ret;
+}
+
 static int pack_compression_seen;
 static int zlib_compression_seen;
 
@@ -345,14 +363,12 @@ static void populate_remote_urls(struct config_include_data *inc)
 {
 	struct config_options opts;
 
-	struct config_source *store_cf = cf;
 	struct key_value_info *store_kvi = current_config_kvi;
 	enum config_scope store_scope = current_parsing_scope;
 
 	opts = *inc->opts;
 	opts.unconditional_remote_url = 1;
 
-	cf = NULL;
 	current_config_kvi = NULL;
 	current_parsing_scope = 0;
 
@@ -360,7 +376,6 @@ static void populate_remote_urls(struct config_include_data *inc)
 	string_list_init_dup(inc->remote_urls);
 	config_with_options(add_remote_url, inc->remote_urls, inc->config_source, &opts);
 
-	cf = store_cf;
 	current_config_kvi = store_kvi;
 	current_parsing_scope = store_scope;
 }
@@ -714,12 +729,10 @@ int git_config_from_parameters(config_fn_t fn, void *data)
 	struct strvec to_free = STRVEC_INIT;
 	int ret = 0;
 	char *envw = NULL;
-	struct config_source source;
+	struct config_source source = CONFIG_SOURCE_INIT;
 
-	memset(&source, 0, sizeof(source));
-	source.prev = cf;
 	source.origin_type = CONFIG_ORIGIN_CMDLINE;
-	cf = &source;
+	config_state_push_source(&source);
 
 	env = getenv(CONFIG_COUNT_ENVIRONMENT);
 	if (env) {
@@ -777,7 +790,7 @@ out:
 	strbuf_release(&envvar);
 	strvec_clear(&to_free);
 	free(envw);
-	cf = source.prev;
+	config_state_pop_source();
 	return ret;
 }
 
@@ -1948,20 +1961,19 @@ static int do_config_from(struct config_source *top, config_fn_t fn, void *data,
 	int ret;
 
 	/* push config-file parsing state stack */
-	top->prev = cf;
 	top->linenr = 1;
 	top->eof = 0;
 	top->total_len = 0;
 	strbuf_init(&top->value, 1024);
 	strbuf_init(&top->var, 1024);
-	cf = top;
+	config_state_push_source(top);
 
-	ret = git_parse_source(cf, fn, data, opts);
+	ret = git_parse_source(top, fn, data, opts);
 
 	/* pop config-file parsing state stack */
 	strbuf_release(&top->value);
 	strbuf_release(&top->var);
-	cf = top->prev;
+	config_state_pop_source();
 
 	return ret;
 }
@@ -1971,7 +1983,7 @@ static int do_config_from_file(config_fn_t fn,
 		const char *name, const char *path, FILE *f,
 		void *data, const struct config_options *opts)
 {
-	struct config_source top;
+	struct config_source top = CONFIG_SOURCE_INIT;
 	int ret;
 
 	top.u.file = f;
@@ -2023,7 +2035,7 @@ int git_config_from_mem(config_fn_t fn,
 			const char *name, const char *buf, size_t len,
 			void *data, const struct config_options *opts)
 {
-	struct config_source top;
+	struct config_source top = CONFIG_SOURCE_INIT;
 
 	top.u.buf.buf = buf;
 	top.u.buf.len = len;
-- 
gitgitgadget

