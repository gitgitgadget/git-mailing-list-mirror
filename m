Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5955A211BB
	for <e@80x24.org>; Thu, 27 Dec 2018 16:26:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729450AbeL0Q0B (ORCPT <rfc822;e@80x24.org>);
        Thu, 27 Dec 2018 11:26:01 -0500
Received: from mail-lf1-f67.google.com ([209.85.167.67]:41661 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729380AbeL0QZ7 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 Dec 2018 11:25:59 -0500
Received: by mail-lf1-f67.google.com with SMTP id c16so12992024lfj.8
        for <git@vger.kernel.org>; Thu, 27 Dec 2018 08:25:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=kgeYg2Mzo+RasZEaKeGNtSEiAZsG5HFH56NEs5fU0Vk=;
        b=KUQv8WEd4Mfw3tUzO1Bv/ytfiLSPUQneujdeAX+pHUUVAslyT4EwhUp61izQuQj+Yg
         M+5Y9XluTPmeMdAtem3c+o54i4UpFsCcdAFAFAABjh3uNWVMx6o2PLvEu8qCwZGKueMr
         P+Ni3toz1BBoeA3STVu02D0lYav3Z4KYucK4HwW0BG8cBDxkr5vfNfl4ztI7nXQQZEf0
         T0+O/Bf9G/zBdqe8mL83h0+mw9cYiRZZbaBYl/as6mLQ6RzawN9f0JXNRTFvibXDfxLd
         IwSoP+clUopkgxwHTSNM+bC16snSjUmgHamTzABsmmBelEZTBPNYM+vornBlG/jBdNR5
         POQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=kgeYg2Mzo+RasZEaKeGNtSEiAZsG5HFH56NEs5fU0Vk=;
        b=OdG3CGTj7NRgGUYlHKHmqj5e7FSS8OQ79aHOkD7UumIgiHvlV91xcx/jCUmfBPmVyl
         hjchgC2ypFOlmAtTClA/m6L3cglBNsabY8Of/x/pCAkGzPszwV5oAP7UDuRwXohB/1S1
         eG9RtHDKSRlRDHNs9OqcfPoPdv9uB2I5/f/baFxDxzwImu/WR22QkHWCwLewrU6c1Z9a
         J56uqr7cOR1xWgbUS5zvBtrhfCk9twWHi3m7tfF0uxN3cJRfyakpOLR8Zm+Ol6yTpzqy
         qG9euksuaGuNyatjBttSbfMoJ5G8NrgIURFMBRKOP+t7l1K9GPQk2QRigfG7FJ539X84
         1xVg==
X-Gm-Message-State: AA+aEWYa1egTtKke6Bh7ZqTdCNG6NR/2y2ylDd/+A5ZqVc6Lm1fHkhVL
        xSLOl0y8966DzPF3GF2JdsHvVvJb
X-Google-Smtp-Source: AFSGD/XI+0hvLT9mUnO9Swp1X9KT8G4z8iT9TbI86s8EPjv6bfbJAeJhAP8nEalKL/aIS3zmDymdGQ==
X-Received: by 2002:a19:5349:: with SMTP id h70mr11972611lfb.50.1545927954537;
        Thu, 27 Dec 2018 08:25:54 -0800 (PST)
Received: from localhost.localdomain (c80-216-2-165.bredband.comhem.se. [80.216.2.165])
        by smtp.gmail.com with ESMTPSA id a127sm7643106lfe.73.2018.12.27.08.25.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 27 Dec 2018 08:25:53 -0800 (PST)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 08/75] parse-options: allow ll_callback with OPTION_CALLBACK
Date:   Thu, 27 Dec 2018 17:25:29 +0100
Message-Id: <20181227162536.15895-9-pclouds@gmail.com>
X-Mailer: git-send-email 2.20.0.482.g66447595a7
In-Reply-To: <20181227162536.15895-1-pclouds@gmail.com>
References: <20181227162536.15895-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

OPTION_CALLBACK is much simpler/safer to use, but parse_opt_cb does
not allow access to parse_opt_ctx_t, which sometimes is useful
(e.g. to obtain the prefix).

Extending parse_opt_cb to take parse_opt_cb could result in a lot of
changes. Instead let's just allow ll_callback to be used with
OPTION_CALLBACK. The user will have to be careful, not to change
anything in ctx, or return wrong result code. But that's the price for
ll_callback.

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 builtin/merge.c        |  2 ++
 builtin/update-index.c | 20 +++++++++++++++-----
 parse-options-cb.c     |  4 +++-
 parse-options.c        | 42 ++++++++++++++++++++++++++++--------------
 parse-options.h        |  5 +++--
 5 files changed, 51 insertions(+), 22 deletions(-)

diff --git a/builtin/merge.c b/builtin/merge.c
index 1c8652e455..b4f4b401eb 100644
--- a/builtin/merge.c
+++ b/builtin/merge.c
@@ -114,11 +114,13 @@ static int option_parse_message(const struct option *opt,
 
 static enum parse_opt_result option_read_message(struct parse_opt_ctx_t *ctx,
 						 const struct option *opt,
+						 const char *arg_not_used,
 						 int unset)
 {
 	struct strbuf *buf = opt->value;
 	const char *arg;
 
+	BUG_ON_OPT_ARG(arg_not_used);
 	if (unset)
 		BUG("-F cannot be negated");
 
diff --git a/builtin/update-index.c b/builtin/update-index.c
index 21c84e5590..7abde20169 100644
--- a/builtin/update-index.c
+++ b/builtin/update-index.c
@@ -848,13 +848,15 @@ static int parse_new_style_cacheinfo(const char *arg,
 }
 
 static enum parse_opt_result cacheinfo_callback(
-	struct parse_opt_ctx_t *ctx, const struct option *opt, int unset)
+	struct parse_opt_ctx_t *ctx, const struct option *opt,
+	const char *arg, int unset)
 {
 	struct object_id oid;
 	unsigned int mode;
 	const char *path;
 
 	BUG_ON_OPT_NEG(unset);
+	BUG_ON_OPT_ARG(arg);
 
 	if (!parse_new_style_cacheinfo(ctx->argv[1], &mode, &oid, &path)) {
 		if (add_cacheinfo(mode, &oid, path, 0))
@@ -874,11 +876,13 @@ static enum parse_opt_result cacheinfo_callback(
 }
 
 static enum parse_opt_result stdin_cacheinfo_callback(
-	struct parse_opt_ctx_t *ctx, const struct option *opt, int unset)
+	struct parse_opt_ctx_t *ctx, const struct option *opt,
+	const char *arg, int unset)
 {
 	int *nul_term_line = opt->value;
 
 	BUG_ON_OPT_NEG(unset);
+	BUG_ON_OPT_ARG(arg);
 
 	if (ctx->argc != 1)
 		return error("option '%s' must be the last argument", opt->long_name);
@@ -888,11 +892,13 @@ static enum parse_opt_result stdin_cacheinfo_callback(
 }
 
 static enum parse_opt_result stdin_callback(
-	struct parse_opt_ctx_t *ctx, const struct option *opt, int unset)
+	struct parse_opt_ctx_t *ctx, const struct option *opt,
+	const char *arg, int unset)
 {
 	int *read_from_stdin = opt->value;
 
 	BUG_ON_OPT_NEG(unset);
+	BUG_ON_OPT_ARG(arg);
 
 	if (ctx->argc != 1)
 		return error("option '%s' must be the last argument", opt->long_name);
@@ -901,12 +907,14 @@ static enum parse_opt_result stdin_callback(
 }
 
 static enum parse_opt_result unresolve_callback(
-	struct parse_opt_ctx_t *ctx, const struct option *opt, int unset)
+	struct parse_opt_ctx_t *ctx, const struct option *opt,
+	const char *arg, int unset)
 {
 	int *has_errors = opt->value;
 	const char *prefix = startup_info->prefix;
 
 	BUG_ON_OPT_NEG(unset);
+	BUG_ON_OPT_ARG(arg);
 
 	/* consume remaining arguments. */
 	*has_errors = do_unresolve(ctx->argc, ctx->argv,
@@ -920,12 +928,14 @@ static enum parse_opt_result unresolve_callback(
 }
 
 static enum parse_opt_result reupdate_callback(
-	struct parse_opt_ctx_t *ctx, const struct option *opt, int unset)
+	struct parse_opt_ctx_t *ctx, const struct option *opt,
+	const char *arg, int unset)
 {
 	int *has_errors = opt->value;
 	const char *prefix = startup_info->prefix;
 
 	BUG_ON_OPT_NEG(unset);
+	BUG_ON_OPT_ARG(arg);
 
 	/* consume remaining arguments. */
 	setup_work_tree();
diff --git a/parse-options-cb.c b/parse-options-cb.c
index 720a8663eb..b336b4fa97 100644
--- a/parse-options-cb.c
+++ b/parse-options-cb.c
@@ -170,8 +170,10 @@ int parse_opt_noop_cb(const struct option *opt, const char *arg, int unset)
  * parse_options().
  */
 enum parse_opt_result parse_opt_unknown_cb(struct parse_opt_ctx_t *ctx,
-					   const struct option *opt, int unset)
+					   const struct option *opt,
+					   const char *arg, int unset)
 {
+	BUG_ON_OPT_ARG(arg);
 	return PARSE_OPT_UNKNOWN;
 }
 
diff --git a/parse-options.c b/parse-options.c
index 634484d8f0..8e0aefe86b 100644
--- a/parse-options.c
+++ b/parse-options.c
@@ -96,7 +96,7 @@ static enum parse_opt_result get_value(struct parse_opt_ctx_t *p,
 
 	switch (opt->type) {
 	case OPTION_LOWLEVEL_CALLBACK:
-		return opt->ll_callback(p, opt, unset);
+		return opt->ll_callback(p, opt, NULL, unset);
 
 	case OPTION_BIT:
 		if (unset)
@@ -162,16 +162,27 @@ static enum parse_opt_result get_value(struct parse_opt_ctx_t *p,
 		return err;
 
 	case OPTION_CALLBACK:
+	{
+		const char *p_arg = NULL;
+		int p_unset;
+
 		if (unset)
-			return (*opt->callback)(opt, NULL, 1) ? (-1) : 0;
-		if (opt->flags & PARSE_OPT_NOARG)
-			return (*opt->callback)(opt, NULL, 0) ? (-1) : 0;
-		if (opt->flags & PARSE_OPT_OPTARG && !p->opt)
-			return (*opt->callback)(opt, NULL, 0) ? (-1) : 0;
-		if (get_arg(p, opt, flags, &arg))
+			p_unset = 1;
+		else if (opt->flags & PARSE_OPT_NOARG)
+			p_unset = 0;
+		else if (opt->flags & PARSE_OPT_OPTARG && !p->opt)
+			p_unset = 0;
+		else if (get_arg(p, opt, flags, &arg))
 			return -1;
-		return (*opt->callback)(opt, arg, 0) ? (-1) : 0;
-
+		else {
+			p_unset = 0;
+			p_arg = arg;
+		}
+		if (opt->callback)
+			return (*opt->callback)(opt, p_arg, p_unset) ? (-1) : 0;
+		else
+			return (*opt->ll_callback)(p, opt, p_arg, p_unset);
+	}
 	case OPTION_INTEGER:
 		if (unset) {
 			*(int *)opt->value = 0;
@@ -238,7 +249,10 @@ static enum parse_opt_result parse_short_opt(struct parse_opt_ctx_t *p,
 			len++;
 		arg = xmemdupz(p->opt, len);
 		p->opt = p->opt[len] ? p->opt + len : NULL;
-		rc = (*numopt->callback)(numopt, arg, 0) ? (-1) : 0;
+		if (numopt->callback)
+			rc = (*numopt->callback)(numopt, arg, 0) ? (-1) : 0;
+		else
+			rc = (*numopt->ll_callback)(p, numopt, arg, 0);
 		free(arg);
 		return rc;
 	}
@@ -413,10 +427,10 @@ static void parse_options_check(const struct option *opts)
 				err |= optbug(opts, "should not accept an argument");
 			break;
 		case OPTION_CALLBACK:
-			if (!opts->callback)
-				BUG("OPTION_CALLBACK needs a callback");
-			if (opts->ll_callback)
-				BUG("OPTION_CALLBACK needs no ll_callback");
+			if (!opts->callback && !opts->ll_callback)
+				BUG("OPTION_CALLBACK needs one callback");
+			if (opts->callback && opts->ll_callback)
+				BUG("OPTION_CALLBACK can't have two callbacks");
 			break;
 		case OPTION_LOWLEVEL_CALLBACK:
 			if (!opts->ll_callback)
diff --git a/parse-options.h b/parse-options.h
index 617bca8efe..75c953a887 100644
--- a/parse-options.h
+++ b/parse-options.h
@@ -50,7 +50,8 @@ typedef int parse_opt_cb(const struct option *, const char *arg, int unset);
 
 struct parse_opt_ctx_t;
 typedef enum parse_opt_result parse_opt_ll_cb(struct parse_opt_ctx_t *ctx,
-					      const struct option *opt, int unset);
+					      const struct option *opt,
+					      const char *arg, int unset);
 
 /*
  * `type`::
@@ -270,7 +271,7 @@ int parse_opt_commits(const struct option *, const char *, int);
 int parse_opt_tertiary(const struct option *, const char *, int);
 int parse_opt_string_list(const struct option *, const char *, int);
 int parse_opt_noop_cb(const struct option *, const char *, int);
-int parse_opt_unknown_cb(struct parse_opt_ctx_t *ctx, const struct option *, int);
+int parse_opt_unknown_cb(struct parse_opt_ctx_t *ctx, const struct option *, const char *, int);
 int parse_opt_passthru(const struct option *, const char *, int);
 int parse_opt_passthru_argv(const struct option *, const char *, int);
 
-- 
2.20.0.482.g66447595a7

