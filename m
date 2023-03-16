Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E826AC6FD1D
	for <git@archiver.kernel.org>; Thu, 16 Mar 2023 00:11:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233149AbjCPALz (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 15 Mar 2023 20:11:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232817AbjCPALy (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 Mar 2023 20:11:54 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC56F1814C
        for <git@vger.kernel.org>; Wed, 15 Mar 2023 17:11:51 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id h17so2503wrt.8
        for <git@vger.kernel.org>; Wed, 15 Mar 2023 17:11:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678925510;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=h8jXzGIPWtezt7Z4YkMHHcu4NcVGQJtC2dzlOMVrMjk=;
        b=eQS2GPOgZyt/Bz5lUncW9mdTcFmPvg1nsGeai8U9lzeRbhlRxCJ7nu1awIu0jjgnVK
         8WSou6F7yKw32w2hp5SH8Sp98bHBiJaAcUjpZMIEZqnLj1HgQFtNTrxQ+3BmSEQWXz2r
         dc23cLpu7QChBwPom4BE1OOHOrwYnuJPZo+UnVZ4RT9osEg47Pcayn2pbmk3dQnGyk1h
         N7kOYVfo7W1/6N9bdmbwXPsKI75vt7oOn/J81ZD1u/Y7YMRfd3tm16N65xegaZvXtANU
         LJ7kcEYCGFkRQeU5cqkPExzrt7S5BdxpRxRQ9+nLU0ah9d9wUWTA8yg1LHrAeaFksQpX
         APZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678925510;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=h8jXzGIPWtezt7Z4YkMHHcu4NcVGQJtC2dzlOMVrMjk=;
        b=sob7AX8ZDVnF1hD47WsszClqMRpOMQZ8pHp9eGvIbGXHhE5GVvNexENZxaHwgS9D2g
         CxfGX/hDjjnH3LD+wy2iTlp1XImG78kE0VwXMXb4VzVctNw6Vl5RovmhFB+1Xzsv2UyV
         R41JpoWcyjjY/EJEKAQJLnh7nQS4I78jsXmAZjPA990VoyUj/+zOvj1v1lCgqwMoULI8
         JXryZg8qUK5hrYEtdTUhfVTeGyt2+ma+NKdMANUJceZwHAGwHMHFkvE43J0hxvgGrjj8
         Up1Ja50YYUp4IWAdSJhnwxZPU50A2E0361a/DUGXt1e3ksVFBxZqvVA0lXx+74u6YHgQ
         pisQ==
X-Gm-Message-State: AO0yUKXPrjWM4P40A7+Lldon81xKkf0cZInROmkLceQ/dpr8L79IWe4Z
        XkNIA+WOnEHWr+SSH5L1M9FhW3nv9m8=
X-Google-Smtp-Source: AK7set/55CiaIVjI9NtcVpvRP+F8AG3Q0KIoPHLh4QO8+6Mq88gbRzSdvYtS8ta5tJUm32/Y8RH8cg==
X-Received: by 2002:a5d:4c8e:0:b0:2cf:e710:a4b9 with SMTP id z14-20020a5d4c8e000000b002cfe710a4b9mr3325988wrs.32.1678925509732;
        Wed, 15 Mar 2023 17:11:49 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id f10-20020adffcca000000b002cea8f07813sm5916520wrs.81.2023.03.15.17.11.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Mar 2023 17:11:49 -0700 (PDT)
Message-Id: <7555da0b0e012a5fd28ca1a70a4a0897514cd607.1678925506.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1463.v2.git.git.1678925506.gitgitgadget@gmail.com>
References: <pull.1463.git.git.1677631097.gitgitgadget@gmail.com>
        <pull.1463.v2.git.git.1678925506.gitgitgadget@gmail.com>
From:   "Glen Choo via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 16 Mar 2023 00:11:40 +0000
Subject: [PATCH v2 2/8] config.c: don't assign to "cf_global" directly
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>,
        Emily Shaffer <nasamuffin@google.com>,
        Jeff King <peff@peff.net>,
        Derrick Stolee <derrickstolee@github.com>,
        Calvin Wan <calvinwan@google.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Glen Choo <chooglen@google.com>,
        Glen Choo <chooglen@google.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Glen Choo <chooglen@google.com>

To make "cf_global" easier to remove, replace all direct assignments to
it with function calls. This refactor has an additional maintainability
benefit: all of these functions were manually implementing stack
pop/push semantics on "struct config_source", so replacing them with
function calls allows us to only implement this logic once.

In this process, perform some now-obvious clean ups:

- Drop some unnecessary "cf_global" assignments in
  populate_remote_urls(). Since it was introduced in 399b198489 (config:
  include file if remote URL matches a glob, 2022-01-18), it has stored
  and restored the value of "cf_global" to ensure that it doesn't get
  accidentally mutated. However, this was never necessary since
  "do_config_from()" already pushes/pops "cf_global" further down the
  call chain.

- Zero out every "struct config_source" with a dedicated initializer.
  This matters because the "struct config_source" is assigned to
  "cf_global" and we later 'pop the stack' by assigning "cf_global =
  cf_global->prev", but "cf_global->prev" could be pointing to
  uninitialized garbage.

  Fortunately, this has never bothered us since we never try to read
  "cf_global" except while iterating through config, in which case,
  "cf_global" is either set to a sensible value (when parsing a file),
  or it is ignored (when iterating a configset). Later in the series,
  zero-ing out memory will also let us enforce the constraint that
  "cf_global" and "current_config_kvi" are never non-NULL together.

Signed-off-by: Glen Choo <chooglen@google.com>
---
 config.c | 38 +++++++++++++++++++++++++-------------
 1 file changed, 25 insertions(+), 13 deletions(-)

diff --git a/config.c b/config.c
index e4a76739365..517b8f64038 100644
--- a/config.c
+++ b/config.c
@@ -49,6 +49,7 @@ struct config_source {
 	int (*do_ungetc)(int c, struct config_source *conf);
 	long (*do_ftell)(struct config_source *c);
 };
+#define CONFIG_SOURCE_INIT { 0 }
 
 /*
  * These variables record the "current" config source, which
@@ -79,6 +80,23 @@ static struct key_value_info *current_config_kvi;
  */
 static enum config_scope current_parsing_scope;
 
+static inline void config_reader_push_source(struct config_source *top)
+{
+	if (cf_global)
+		top->prev = cf_global;
+	cf_global = top;
+}
+
+static inline struct config_source *config_reader_pop_source()
+{
+	struct config_source *ret;
+	if (!cf_global)
+		BUG("tried to pop config source, but we weren't reading config");
+	ret = cf_global;
+	cf_global = cf_global->prev;
+	return ret;
+}
+
 static int pack_compression_seen;
 static int zlib_compression_seen;
 
@@ -346,14 +364,12 @@ static void populate_remote_urls(struct config_include_data *inc)
 {
 	struct config_options opts;
 
-	struct config_source *store_cf = cf_global;
 	struct key_value_info *store_kvi = current_config_kvi;
 	enum config_scope store_scope = current_parsing_scope;
 
 	opts = *inc->opts;
 	opts.unconditional_remote_url = 1;
 
-	cf_global = NULL;
 	current_config_kvi = NULL;
 	current_parsing_scope = 0;
 
@@ -361,7 +377,6 @@ static void populate_remote_urls(struct config_include_data *inc)
 	string_list_init_dup(inc->remote_urls);
 	config_with_options(add_remote_url, inc->remote_urls, inc->config_source, &opts);
 
-	cf_global = store_cf;
 	current_config_kvi = store_kvi;
 	current_parsing_scope = store_scope;
 }
@@ -715,12 +730,10 @@ int git_config_from_parameters(config_fn_t fn, void *data)
 	struct strvec to_free = STRVEC_INIT;
 	int ret = 0;
 	char *envw = NULL;
-	struct config_source source;
+	struct config_source source = CONFIG_SOURCE_INIT;
 
-	memset(&source, 0, sizeof(source));
-	source.prev = cf_global;
 	source.origin_type = CONFIG_ORIGIN_CMDLINE;
-	cf_global = &source;
+	config_reader_push_source(&source);
 
 	env = getenv(CONFIG_COUNT_ENVIRONMENT);
 	if (env) {
@@ -778,7 +791,7 @@ out:
 	strbuf_release(&envvar);
 	strvec_clear(&to_free);
 	free(envw);
-	cf_global = source.prev;
+	config_reader_pop_source();
 	return ret;
 }
 
@@ -1949,20 +1962,19 @@ static int do_config_from(struct config_source *top, config_fn_t fn, void *data,
 	int ret;
 
 	/* push config-file parsing state stack */
-	top->prev = cf_global;
 	top->linenr = 1;
 	top->eof = 0;
 	top->total_len = 0;
 	strbuf_init(&top->value, 1024);
 	strbuf_init(&top->var, 1024);
-	cf_global = top;
+	config_reader_push_source(top);
 
 	ret = git_parse_source(top, fn, data, opts);
 
 	/* pop config-file parsing state stack */
 	strbuf_release(&top->value);
 	strbuf_release(&top->var);
-	cf_global = top->prev;
+	config_reader_pop_source();
 
 	return ret;
 }
@@ -1972,7 +1984,7 @@ static int do_config_from_file(config_fn_t fn,
 		const char *name, const char *path, FILE *f,
 		void *data, const struct config_options *opts)
 {
-	struct config_source top;
+	struct config_source top = CONFIG_SOURCE_INIT;
 	int ret;
 
 	top.u.file = f;
@@ -2024,7 +2036,7 @@ int git_config_from_mem(config_fn_t fn,
 			const char *name, const char *buf, size_t len,
 			void *data, const struct config_options *opts)
 {
-	struct config_source top;
+	struct config_source top = CONFIG_SOURCE_INIT;
 
 	top.u.buf.buf = buf;
 	top.u.buf.len = len;
-- 
gitgitgadget

