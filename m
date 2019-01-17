Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 415061F453
	for <e@80x24.org>; Thu, 17 Jan 2019 13:07:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727423AbfAQNHJ (ORCPT <rfc822;e@80x24.org>);
        Thu, 17 Jan 2019 08:07:09 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:33099 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725926AbfAQNHJ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 Jan 2019 08:07:09 -0500
Received: by mail-pg1-f195.google.com with SMTP id z11so4446018pgu.0
        for <git@vger.kernel.org>; Thu, 17 Jan 2019 05:07:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=DIImD/l4+BNOB3O8DnZ9M35Gz1/TSu1nluLaEHTlgXU=;
        b=ECG3Gjc/4TUpLsVf6v0YiBIAYSGnFMdGRK1/V8wGlNBnW/+H3NXDOfEvnZpc09TDex
         vwfwbgozh/4N0F00qby+gI+cpvO6hheczOJbydVyQebWCg0WlH5mlsfFdLxiGataVbYS
         ztdi9fbwshidob1Di2+4/j35BFgUnroA6+3SfxPNCIIsN+eaf810Mp6rkVaQXZ0dg3SF
         qYYJwtWgJl+K1AgJC/wjbPx2FtTDU48Mf7V0YGuBQVSmQZEyYtS26qb17U5iJ/3SqHci
         5jt2h73w4j6poJjnSidZO0a+MqOc0zKh+hVDv50qe+OBJSVqLQToF/fmW8CQucH/66A+
         GGgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=DIImD/l4+BNOB3O8DnZ9M35Gz1/TSu1nluLaEHTlgXU=;
        b=NN6Yb1VIDr67LutwqHAjhLuD+aq7Dkr9pw1d6v3fzIvdcCcC92DC+KhJM1M+ICQm96
         bJpWOK22k/BdMouDz/4QulV2XwnJ/4UhpQ3XSREnG7/8lKzW5WVpjsvEQjtvus19PVfD
         H6konF2HlrTr2D9+JP/ahIMGwwG0GYyY9Etlw/QxvFaYTTGgLO1VowA8uGynLunqeBeq
         ByRPdgyyoc4dAtIttjnDLrQi5RiBvPfQZsmFkWo66E0cg73hX1OvS24ejMnnofYKIfnK
         jK6Ma1g6AM5n38sc1wNWXwrGFAtNQn2Lav6CsySUFBuIUozMsj/0cEw6fCWvMBShhIsR
         BMJA==
X-Gm-Message-State: AJcUukdvHFze/GTQhkRxT/PlRBYiNmIZ41ZP/f5SvoJWhWm2uaUkt8RG
        mFm6ZcVu/N0cqXS0BvDqEjSZbEbW
X-Google-Smtp-Source: ALg8bN6nRkLtX9alxhf3TpUZlhEPPahAFrDnLByyYJE71BPR6qu9g3H0hJ4w/HTB016cplaHqG+6uQ==
X-Received: by 2002:a63:4566:: with SMTP id u38mr13386585pgk.4.1547730427681;
        Thu, 17 Jan 2019 05:07:07 -0800 (PST)
Received: from ash ([115.72.21.220])
        by smtp.gmail.com with ESMTPSA id g3sm3063431pfe.37.2019.01.17.05.07.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 17 Jan 2019 05:07:07 -0800 (PST)
Received: by ash (sSMTP sendmail emulation); Thu, 17 Jan 2019 20:07:03 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 07/76] parse-options: avoid magic return codes
Date:   Thu, 17 Jan 2019 20:05:06 +0700
Message-Id: <20190117130615.18732-8-pclouds@gmail.com>
X-Mailer: git-send-email 2.20.0.482.g66447595a7
In-Reply-To: <20190117130615.18732-1-pclouds@gmail.com>
References: <20190117130615.18732-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Give names to these magic negative numbers. Make parse_opt_ll_cb
return an enum to make clear it can actually control parse_options()
with different return values (parse_opt_cb can too, but nobody needs
it).

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 builtin/merge.c        |  5 +--
 builtin/update-index.c | 20 ++++++------
 parse-options-cb.c     |  6 ++--
 parse-options.c        | 69 +++++++++++++++++++++++++++---------------
 parse-options.h        | 14 ++++-----
 5 files changed, 68 insertions(+), 46 deletions(-)

diff --git a/builtin/merge.c b/builtin/merge.c
index 07839b0bb8..de64d7850e 100644
--- a/builtin/merge.c
+++ b/builtin/merge.c
@@ -112,8 +112,9 @@ static int option_parse_message(const struct option *opt,
 	return 0;
 }
 
-static int option_read_message(struct parse_opt_ctx_t *ctx,
-			       const struct option *opt, int unset)
+static enum parse_opt_result option_read_message(struct parse_opt_ctx_t *ctx,
+						 const struct option *opt,
+						 int unset)
 {
 	struct strbuf *buf = opt->value;
 	const char *arg;
diff --git a/builtin/update-index.c b/builtin/update-index.c
index 727a8118b8..21c84e5590 100644
--- a/builtin/update-index.c
+++ b/builtin/update-index.c
@@ -847,8 +847,8 @@ static int parse_new_style_cacheinfo(const char *arg,
 	return 0;
 }
 
-static int cacheinfo_callback(struct parse_opt_ctx_t *ctx,
-				const struct option *opt, int unset)
+static enum parse_opt_result cacheinfo_callback(
+	struct parse_opt_ctx_t *ctx, const struct option *opt, int unset)
 {
 	struct object_id oid;
 	unsigned int mode;
@@ -873,8 +873,8 @@ static int cacheinfo_callback(struct parse_opt_ctx_t *ctx,
 	return 0;
 }
 
-static int stdin_cacheinfo_callback(struct parse_opt_ctx_t *ctx,
-			      const struct option *opt, int unset)
+static enum parse_opt_result stdin_cacheinfo_callback(
+	struct parse_opt_ctx_t *ctx, const struct option *opt, int unset)
 {
 	int *nul_term_line = opt->value;
 
@@ -887,8 +887,8 @@ static int stdin_cacheinfo_callback(struct parse_opt_ctx_t *ctx,
 	return 0;
 }
 
-static int stdin_callback(struct parse_opt_ctx_t *ctx,
-				const struct option *opt, int unset)
+static enum parse_opt_result stdin_callback(
+	struct parse_opt_ctx_t *ctx, const struct option *opt, int unset)
 {
 	int *read_from_stdin = opt->value;
 
@@ -900,8 +900,8 @@ static int stdin_callback(struct parse_opt_ctx_t *ctx,
 	return 0;
 }
 
-static int unresolve_callback(struct parse_opt_ctx_t *ctx,
-				const struct option *opt, int unset)
+static enum parse_opt_result unresolve_callback(
+	struct parse_opt_ctx_t *ctx, const struct option *opt, int unset)
 {
 	int *has_errors = opt->value;
 	const char *prefix = startup_info->prefix;
@@ -919,8 +919,8 @@ static int unresolve_callback(struct parse_opt_ctx_t *ctx,
 	return 0;
 }
 
-static int reupdate_callback(struct parse_opt_ctx_t *ctx,
-				const struct option *opt, int unset)
+static enum parse_opt_result reupdate_callback(
+	struct parse_opt_ctx_t *ctx, const struct option *opt, int unset)
 {
 	int *has_errors = opt->value;
 	const char *prefix = startup_info->prefix;
diff --git a/parse-options-cb.c b/parse-options-cb.c
index e05bcea809..ec01ef722b 100644
--- a/parse-options-cb.c
+++ b/parse-options-cb.c
@@ -170,10 +170,10 @@ int parse_opt_noop_cb(const struct option *opt, const char *arg, int unset)
  * "-h" output even if it's not being handled directly by
  * parse_options().
  */
-int parse_opt_unknown_cb(struct parse_opt_ctx_t *ctx,
-			 const struct option *opt, int unset)
+enum parse_opt_result parse_opt_unknown_cb(struct parse_opt_ctx_t *ctx,
+					   const struct option *opt, int unset)
 {
-	return -2;
+	return PARSE_OPT_UNKNOWN;
 }
 
 /**
diff --git a/parse-options.c b/parse-options.c
index ac109e11e9..372f5cede4 100644
--- a/parse-options.c
+++ b/parse-options.c
@@ -20,8 +20,9 @@ int optbug(const struct option *opt, const char *reason)
 	return error("BUG: switch '%c' %s", opt->short_name, reason);
 }
 
-static int get_arg(struct parse_opt_ctx_t *p, const struct option *opt,
-		   int flags, const char **arg)
+static enum parse_opt_result get_arg(struct parse_opt_ctx_t *p,
+				     const struct option *opt,
+				     int flags, const char **arg)
 {
 	if (p->opt) {
 		*arg = p->opt;
@@ -44,9 +45,10 @@ static void fix_filename(const char *prefix, const char **file)
 	*file = prefix_filename(prefix, *file);
 }
 
-static int opt_command_mode_error(const struct option *opt,
-				  const struct option *all_opts,
-				  int flags)
+static enum parse_opt_result opt_command_mode_error(
+	const struct option *opt,
+	const struct option *all_opts,
+	int flags)
 {
 	const struct option *that;
 	struct strbuf that_name = STRBUF_INIT;
@@ -69,16 +71,16 @@ static int opt_command_mode_error(const struct option *opt,
 		error(_("%s is incompatible with %s"),
 		      optname(opt, flags), that_name.buf);
 		strbuf_release(&that_name);
-		return -1;
+		return PARSE_OPT_ERROR;
 	}
 	return error(_("%s : incompatible with something else"),
 		     optname(opt, flags));
 }
 
-static int get_value(struct parse_opt_ctx_t *p,
-		     const struct option *opt,
-		     const struct option *all_opts,
-		     int flags)
+static enum parse_opt_result get_value(struct parse_opt_ctx_t *p,
+				       const struct option *opt,
+				       const struct option *all_opts,
+				       int flags)
 {
 	const char *s, *arg;
 	const int unset = flags & OPT_UNSET;
@@ -208,7 +210,8 @@ static int get_value(struct parse_opt_ctx_t *p,
 	}
 }
 
-static int parse_short_opt(struct parse_opt_ctx_t *p, const struct option *options)
+static enum parse_opt_result parse_short_opt(struct parse_opt_ctx_t *p,
+					     const struct option *options)
 {
 	const struct option *all_opts = options;
 	const struct option *numopt = NULL;
@@ -239,11 +242,12 @@ static int parse_short_opt(struct parse_opt_ctx_t *p, const struct option *optio
 		free(arg);
 		return rc;
 	}
-	return -2;
+	return PARSE_OPT_UNKNOWN;
 }
 
-static int parse_long_opt(struct parse_opt_ctx_t *p, const char *arg,
-			  const struct option *options)
+static enum parse_opt_result parse_long_opt(
+	struct parse_opt_ctx_t *p, const char *arg,
+	const struct option *options)
 {
 	const struct option *all_opts = options;
 	const char *arg_end = strchrnul(arg, '=');
@@ -269,7 +273,7 @@ static int parse_long_opt(struct parse_opt_ctx_t *p, const char *arg,
 			if (*rest)
 				continue;
 			p->out[p->cpidx++] = arg - 2;
-			return 0;
+			return PARSE_OPT_DONE;
 		}
 		if (!rest) {
 			/* abbreviated? */
@@ -334,11 +338,11 @@ static int parse_long_opt(struct parse_opt_ctx_t *p, const char *arg,
 			ambiguous_option->long_name,
 			(abbrev_flags & OPT_UNSET) ?  "no-" : "",
 			abbrev_option->long_name);
-		return -3;
+		return PARSE_OPT_HELP;
 	}
 	if (abbrev_option)
 		return get_value(p, abbrev_option, all_opts, abbrev_flags);
-	return -2;
+	return PARSE_OPT_UNKNOWN;
 }
 
 static int parse_nodash_opt(struct parse_opt_ctx_t *p, const char *arg,
@@ -586,22 +590,28 @@ int parse_options_step(struct parse_opt_ctx_t *ctx,
 		if (arg[1] != '-') {
 			ctx->opt = arg + 1;
 			switch (parse_short_opt(ctx, options)) {
-			case -1:
+			case PARSE_OPT_ERROR:
 				return PARSE_OPT_ERROR;
-			case -2:
+			case PARSE_OPT_UNKNOWN:
 				if (ctx->opt)
 					check_typos(arg + 1, options);
 				if (internal_help && *ctx->opt == 'h')
 					goto show_usage;
 				goto unknown;
+			case PARSE_OPT_NON_OPTION:
+			case PARSE_OPT_HELP:
+			case PARSE_OPT_COMPLETE:
+				BUG("parse_short_opt() cannot return these");
+			case PARSE_OPT_DONE:
+				break;
 			}
 			if (ctx->opt)
 				check_typos(arg + 1, options);
 			while (ctx->opt) {
 				switch (parse_short_opt(ctx, options)) {
-				case -1:
+				case PARSE_OPT_ERROR:
 					return PARSE_OPT_ERROR;
-				case -2:
+				case PARSE_OPT_UNKNOWN:
 					if (internal_help && *ctx->opt == 'h')
 						goto show_usage;
 
@@ -613,6 +623,12 @@ int parse_options_step(struct parse_opt_ctx_t *ctx,
 					ctx->argv[0] = xstrdup(ctx->opt - 1);
 					*(char *)ctx->argv[0] = '-';
 					goto unknown;
+				case PARSE_OPT_NON_OPTION:
+				case PARSE_OPT_COMPLETE:
+				case PARSE_OPT_HELP:
+					BUG("parse_short_opt() cannot return these");
+				case PARSE_OPT_DONE:
+					break;
 				}
 			}
 			continue;
@@ -631,12 +647,17 @@ int parse_options_step(struct parse_opt_ctx_t *ctx,
 		if (internal_help && !strcmp(arg + 2, "help"))
 			goto show_usage;
 		switch (parse_long_opt(ctx, arg + 2, options)) {
-		case -1:
+		case PARSE_OPT_ERROR:
 			return PARSE_OPT_ERROR;
-		case -2:
+		case PARSE_OPT_UNKNOWN:
 			goto unknown;
-		case -3:
+		case PARSE_OPT_HELP:
 			goto show_usage;
+		case PARSE_OPT_NON_OPTION:
+		case PARSE_OPT_COMPLETE:
+			BUG("parse_long_opt() cannot return these");
+		case PARSE_OPT_DONE:
+			break;
 		}
 		continue;
 unknown:
diff --git a/parse-options.h b/parse-options.h
index f1f246387c..4e49185027 100644
--- a/parse-options.h
+++ b/parse-options.h
@@ -49,8 +49,8 @@ struct option;
 typedef int parse_opt_cb(const struct option *, const char *arg, int unset);
 
 struct parse_opt_ctx_t;
-typedef int parse_opt_ll_cb(struct parse_opt_ctx_t *ctx,
-				const struct option *opt, int unset);
+typedef enum parse_opt_result parse_opt_ll_cb(struct parse_opt_ctx_t *ctx,
+					      const struct option *opt, int unset);
 
 /*
  * `type`::
@@ -222,12 +222,12 @@ const char *optname(const struct option *opt, int flags);
 
 /*----- incremental advanced APIs -----*/
 
-enum {
-	PARSE_OPT_COMPLETE = -2,
-	PARSE_OPT_HELP = -1,
-	PARSE_OPT_DONE,
+enum parse_opt_result {
+	PARSE_OPT_COMPLETE = -3,
+	PARSE_OPT_HELP = -2,
+	PARSE_OPT_ERROR = -1,	/* must be the same as error() */
+	PARSE_OPT_DONE = 0,	/* fixed so that "return 0" works */
 	PARSE_OPT_NON_OPTION,
-	PARSE_OPT_ERROR,
 	PARSE_OPT_UNKNOWN
 };
 
-- 
2.20.0.482.g66447595a7

