Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1718B1F576
	for <e@80x24.org>; Wed, 31 Jan 2018 11:06:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753299AbeAaLGI (ORCPT <rfc822;e@80x24.org>);
        Wed, 31 Jan 2018 06:06:08 -0500
Received: from mail-pg0-f66.google.com ([74.125.83.66]:46110 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752373AbeAaLGH (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 31 Jan 2018 06:06:07 -0500
Received: by mail-pg0-f66.google.com with SMTP id s9so9746393pgq.13
        for <git@vger.kernel.org>; Wed, 31 Jan 2018 03:06:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=qILe/efE3QughUiLPyJueRg0PkdBkpG1NbVhFT4TDHs=;
        b=COE1f7KhK7DRvHmpukiINQIsyZpoGnZTBG7J3VVSk2JPoRBIe4XeyGMBHnJV5mdpr7
         53IwK8IJLeET5faGMrRLswLXD/hKPqeO7E5suqGF6QnIhUr6GLDhlHWytOUKJ+4Z1ymO
         VcWP0HnZ0++chNLu72C/0JNLf7HV5Ox+doYpvbmhbM7d/qygm/f+FpfKggRxmmcqWGzn
         XDsYTG/lm7dMVAlxltAywRYX2fL0pGjDhoNUreGnOksg++hgHfUMy4Jvnl8YmW83GC41
         9O5HOSck1YR8yebUhJDy9EUlFLbYn51B1cjfiu7wzizQXBc+LQRnU8On++p9I0wt9NiF
         a6uA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qILe/efE3QughUiLPyJueRg0PkdBkpG1NbVhFT4TDHs=;
        b=meA1P8FQI5lZjZoMuZTdwFKgMQ6gv+2dJTk5qwst5KUQjRBRNIi8aGcC+zQnHHlZ+R
         TN9VD34x9JdNNUxos9IhPGqgUChHTD+x3fvVrBjLNjM/AZX/FnOAHBktxe1fnAWkbpyl
         v29iNxWWdEq6uZ4gucErn3x5x2RIslzyHUDMikbXQDU29MwDu3GIt7pEzhseoFbJn4Qd
         9aXH1g3M7qU4yM/2eqw6e72TJYykaoWRlufv3tbkWchUcQXPaqo34md1KQaBkEjEQiYJ
         ibUR3E/1onx0wrqA8f42f9WNyK1+znBx7fnY8ZXgvQX06EXnuzlTxjVnPSG7DsU3bsK+
         Gdbw==
X-Gm-Message-State: AKwxytcDkDR3qGXTta2Gj4e3svvu9etx6Pj/f9a9l9W6szxX89QlXSWl
        sXmlGRwGfqMhGrgHF3t/nwEx1A==
X-Google-Smtp-Source: AH8x226607slLBdvaI9v6Ii3dMzx/R4w6Gd80RbmbrXR+TbNXGMPQuRArB9WFB1o2FHqFpkv2460lA==
X-Received: by 10.99.6.72 with SMTP id 69mr25797872pgg.50.1517396766448;
        Wed, 31 Jan 2018 03:06:06 -0800 (PST)
Received: from ash ([171.232.97.171])
        by smtp.gmail.com with ESMTPSA id u195sm24984748pgb.64.2018.01.31.03.06.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 31 Jan 2018 03:06:05 -0800 (PST)
Received: by ash (sSMTP sendmail emulation); Wed, 31 Jan 2018 18:06:01 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH v2 01/41] parse-options: support --git-completion-helper
Date:   Wed, 31 Jan 2018 18:05:07 +0700
Message-Id: <20180131110547.20577-2-pclouds@gmail.com>
X-Mailer: git-send-email 2.16.1.205.g271f633410
In-Reply-To: <20180131110547.20577-1-pclouds@gmail.com>
References: <20180131110547.20577-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This option is designed to be used by git-completion.bash. For many
simple cases, what we do in there is usually

    __gitcomp "lots of completion options"

which has to be manually updated when a new user-visible option is
added. With support from parse-options, we can write

    __gitcomp "$(git command --git-completion-helper)"

and get that list directly from the parser for free. Dangerous/Unpopular
options could be hidden with the new "NOCOMPLETE" flag.

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 parse-options.c | 44 ++++++++++++++++++++++++++++++++++++++++++++
 parse-options.h |  5 ++++-
 2 files changed, 48 insertions(+), 1 deletion(-)

diff --git a/parse-options.c b/parse-options.c
index fca7159646..29f4defdd6 100644
--- a/parse-options.c
+++ b/parse-options.c
@@ -425,6 +425,46 @@ void parse_options_start(struct parse_opt_ctx_t *ctx,
 	parse_options_check(options);
 }
 
+/*
+ * TODO: we are not completing the --no-XXX form yet because there are
+ * many options that do not suppress it properly.
+ */
+static int show_gitcomp(struct parse_opt_ctx_t *ctx,
+			const struct option *opts)
+{
+	for (; opts->type != OPTION_END; opts++) {
+		const char *suffix = "";
+
+		if (!opts->long_name)
+			continue;
+		if (opts->flags & (PARSE_OPT_HIDDEN | PARSE_OPT_NOCOMPLETE))
+			continue;
+
+		switch (opts->type) {
+		case OPTION_GROUP:
+			continue;
+		case OPTION_STRING:
+		case OPTION_FILENAME:
+		case OPTION_INTEGER:
+		case OPTION_MAGNITUDE:
+		case OPTION_CALLBACK:
+			if (opts->flags & PARSE_OPT_NOARG)
+				break;
+			if (opts->flags & PARSE_OPT_OPTARG)
+				break;
+			if (opts->flags & PARSE_OPT_LASTARG_DEFAULT)
+				break;
+			suffix = "=";
+			break;
+		default:
+			break;
+		}
+		printf(" --%s%s", opts->long_name, suffix);
+	}
+	fputc('\n', stdout);
+	exit(0);
+}
+
 static int usage_with_options_internal(struct parse_opt_ctx_t *,
 				       const char * const *,
 				       const struct option *, int, int);
@@ -455,6 +495,10 @@ int parse_options_step(struct parse_opt_ctx_t *ctx,
 		if (internal_help && ctx->total == 1 && !strcmp(arg + 1, "h"))
 			goto show_usage;
 
+		/* lone --git-completion-helper is asked by git-completion.bash */
+		if (ctx->total == 1 && !strcmp(arg + 1, "-git-completion-helper"))
+			return show_gitcomp(ctx, options);
+
 		if (arg[1] != '-') {
 			ctx->opt = arg + 1;
 			switch (parse_short_opt(ctx, options)) {
diff --git a/parse-options.h b/parse-options.h
index af711227ae..983de27cf0 100644
--- a/parse-options.h
+++ b/parse-options.h
@@ -38,7 +38,8 @@ enum parse_opt_option_flags {
 	PARSE_OPT_LASTARG_DEFAULT = 16,
 	PARSE_OPT_NODASH = 32,
 	PARSE_OPT_LITERAL_ARGHELP = 64,
-	PARSE_OPT_SHELL_EVAL = 256
+	PARSE_OPT_SHELL_EVAL = 256,
+	PARSE_OPT_NOCOMPLETE = 512
 };
 
 struct option;
@@ -89,6 +90,8 @@ typedef int parse_opt_ll_cb(struct parse_opt_ctx_t *ctx,
  *   PARSE_OPT_LITERAL_ARGHELP: says that argh shouldn't be enclosed in brackets
  *				(i.e. '<argh>') in the help message.
  *				Useful for options with multiple parameters.
+ *   PARSE_OPT_NOCOMPLETE: by default all visible options are completable
+ *			   git-completion.bash. This option suppresses that.
  *
  * `callback`::
  *   pointer to the callback to use for OPTION_CALLBACK or
-- 
2.16.1.205.g271f633410

