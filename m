Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2D60220248
	for <e@80x24.org>; Sun, 24 Mar 2019 08:22:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728592AbfCXIW0 (ORCPT <rfc822;e@80x24.org>);
        Sun, 24 Mar 2019 04:22:26 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:42112 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728582AbfCXIWZ (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 24 Mar 2019 04:22:25 -0400
Received: by mail-pg1-f194.google.com with SMTP id p6so4343809pgh.9
        for <git@vger.kernel.org>; Sun, 24 Mar 2019 01:22:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=kQKJyX6pIH0h0o6032BfFprRW4OqddV5C8R6Ngys9K8=;
        b=LskJUeY3xY4H4j1PazxvSH0ex6Q4oRwab/4EpYykF6ycsdlNRNA8on8Iaj2MGjRkoG
         fSQ85rc5TyYpdiBT7NPX9+pjSeSyTngrTmc+RvyQsuRC3i0Hgxu8NgyPr/7kpDlzNewu
         ASi8b1gNT3jEPQapNnjnt4+mV/eCPE7yxbTLf/FHqfZk4aLYaHUyAEiATnKocaxmgewY
         hlsg8LU/mrivLWvlRIQ5l9pR+Ten2sUjjFxzgKL478hljfqaxe49ZhkoOsGefM8JYTeQ
         hcYyXVfJt24fNqq5oShbEyHGqvAIbRdmBF8U4ExV8tM2JPNonrRbaXC5fIohRR7xbHvS
         UUNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=kQKJyX6pIH0h0o6032BfFprRW4OqddV5C8R6Ngys9K8=;
        b=ps+WUjTzl8nd3CTl7c1abCP7An3JAh19AeCrGD3pGnlWbREv3UWrOzMpT2swPgrDof
         8d4o6CqbOZBeBSYxoBt6YhHlxk0TKc+3d/+KwLnWcAy9nWWKraaTKpGim5H9U342tzJd
         KTELlt8CHcufYp+9nuVenxPvrFrWVoHENSowLM7Ru/x7YuZsLwkE3LyoajVbJaJbjJYV
         BZly7Qa8gGCCsNeK4pTGR0cqXRERiqAPfekOMTGAvLpmhJTLEAMzNuHgTDQ1LLVw0PFE
         bPfEMv3NMQBOfRVMBdvwiSjJscRc8YZ3gF6tr1ScgvbIMyj6GPkCDAgfqVoHRD28eJpx
         +JRQ==
X-Gm-Message-State: APjAAAXzgRfj8oA9+F7kpt1ExRE0i8NPCWSmdzGCc3rLSTKEEG5hdSSA
        lkwQsUHM0QxnAPL15tzSZSQ=
X-Google-Smtp-Source: APXvYqwBYiJc9Q/+8bMCNyBSpuaf3/pcXZEjBghztlSejrAms4rYn+lpITEXamxCf9VOvASDTiaXGA==
X-Received: by 2002:a62:1197:: with SMTP id 23mr17996321pfr.210.1553415745243;
        Sun, 24 Mar 2019 01:22:25 -0700 (PDT)
Received: from ash ([171.226.148.85])
        by smtp.gmail.com with ESMTPSA id i13sm14785369pgq.17.2019.03.24.01.22.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 24 Mar 2019 01:22:24 -0700 (PDT)
Received: by ash (sSMTP sendmail emulation); Sun, 24 Mar 2019 15:22:20 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     pclouds@gmail.com
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>
Subject: [PATCH v2 14/20] diff-parseopt: convert --inter-hunk-context
Date:   Sun, 24 Mar 2019 15:20:08 +0700
Message-Id: <20190324082014.2041-15-pclouds@gmail.com>
X-Mailer: git-send-email 2.21.0.548.gd3c7d92dc2
In-Reply-To: <20190324082014.2041-1-pclouds@gmail.com>
References: <20190320114703.18659-1-pclouds@gmail.com>
 <20190324082014.2041-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 diff.c          | 50 +++----------------------------------------------
 parse-options.h |  3 ++-
 2 files changed, 5 insertions(+), 48 deletions(-)

diff --git a/diff.c b/diff.c
index 6029f8de2d..8b65b03c0d 100644
--- a/diff.c
+++ b/diff.c
@@ -4573,50 +4573,6 @@ void diff_setup_done(struct diff_options *options)
 	FREE_AND_NULL(options->parseopts);
 }
 
-static int opt_arg(const char *arg, int arg_short, const char *arg_long, int *val)
-{
-	char c, *eq;
-	int len;
-
-	if (*arg != '-')
-		return 0;
-	c = *++arg;
-	if (!c)
-		return 0;
-	if (c == arg_short) {
-		c = *++arg;
-		if (!c)
-			return 1;
-		if (val && isdigit(c)) {
-			char *end;
-			int n = strtoul(arg, &end, 10);
-			if (*end)
-				return 0;
-			*val = n;
-			return 1;
-		}
-		return 0;
-	}
-	if (c != '-')
-		return 0;
-	arg++;
-	eq = strchrnul(arg, '=');
-	len = eq - arg;
-	if (!len || strncmp(arg, arg_long, len))
-		return 0;
-	if (*eq) {
-		int n;
-		char *end;
-		if (!isdigit(*++eq))
-			return 0;
-		n = strtoul(eq, &end, 10);
-		if (*end)
-			return 0;
-		*val = n;
-	}
-	return 1;
-}
-
 int parse_long_opt(const char *opt, const char **argv,
 		   const char **optarg)
 {
@@ -5291,6 +5247,9 @@ static void prep_parse_options(struct diff_options *options)
 		OPT_CALLBACK_F(0, "no-prefix", options, NULL,
 			       N_("do not show any source or destination prefix"),
 			       PARSE_OPT_NONEG | PARSE_OPT_NOARG, diff_opt_no_prefix),
+		OPT_INTEGER_F(0, "inter-hunk-context", &options->interhunkcontext,
+			      N_("show context between diff hunks up to the specified number of lines"),
+			      PARSE_OPT_NONEG),
 		OPT_CALLBACK_F(0, "output-indicator-new",
 			       &options->output_indicators[OUTPUT_INDICATOR_NEW],
 			       N_("<char>"),
@@ -5483,9 +5442,6 @@ int diff_opt_parse(struct diff_options *options,
 	}
 
 	/* misc options */
-	else if (opt_arg(arg, '\0', "inter-hunk-context",
-			 &options->interhunkcontext))
-		;
 	else
 		return 0;
 	return 1;
diff --git a/parse-options.h b/parse-options.h
index c95cbe26f0..cca64d04cb 100644
--- a/parse-options.h
+++ b/parse-options.h
@@ -137,6 +137,7 @@ struct option {
 #define OPT_CALLBACK_F(s, l, v, a, h, f, cb)			\
 	{ OPTION_CALLBACK, (s), (l), (v), (a), (h), (f), (cb) }
 #define OPT_STRING_F(s, l, v, a, h, f)   { OPTION_STRING,  (s), (l), (v), (a), (h), (f) }
+#define OPT_INTEGER_F(s, l, v, h, f)     { OPTION_INTEGER, (s), (l), (v), N_("n"), (h), (f) }
 
 #define OPT_END()                   { OPTION_END }
 #define OPT_ARGUMENT(l, h)          { OPTION_ARGUMENT, 0, (l), NULL, NULL, \
@@ -155,7 +156,7 @@ struct option {
 				      (h), PARSE_OPT_NOARG | PARSE_OPT_HIDDEN, NULL, 1}
 #define OPT_CMDMODE(s, l, v, h, i)  { OPTION_CMDMODE, (s), (l), (v), NULL, \
 				      (h), PARSE_OPT_NOARG|PARSE_OPT_NONEG, NULL, (i) }
-#define OPT_INTEGER(s, l, v, h)     { OPTION_INTEGER, (s), (l), (v), N_("n"), (h) }
+#define OPT_INTEGER(s, l, v, h)     OPT_INTEGER_F(s, l, v, h, 0)
 #define OPT_MAGNITUDE(s, l, v, h)   { OPTION_MAGNITUDE, (s), (l), (v), \
 				      N_("n"), (h), PARSE_OPT_NONEG }
 #define OPT_STRING(s, l, v, a, h)   OPT_STRING_F(s, l, v, a, h, 0)
-- 
2.21.0.548.gd3c7d92dc2

