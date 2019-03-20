Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6E22220248
	for <e@80x24.org>; Wed, 20 Mar 2019 11:48:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728058AbfCTLsF (ORCPT <rfc822;e@80x24.org>);
        Wed, 20 Mar 2019 07:48:05 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:32768 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728053AbfCTLsF (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 20 Mar 2019 07:48:05 -0400
Received: by mail-pg1-f195.google.com with SMTP id b12so1655618pgk.0
        for <git@vger.kernel.org>; Wed, 20 Mar 2019 04:48:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=6lui7fnu0IRlrp71D2hv/7mB2c92uRxIs2duLtUJCr4=;
        b=FQyDIy/3Qy7+WAByBOD0lNoBY6Nz+6v9RvzkYzh70jGvA4hGeWH7MH8Hgvs6EWJAoC
         yOQaEvFaPUGniGqyCPDmGHzVn5E6ipT0+BKPuE+dVXz3n1dlb3nkUWFv8tiswIQWwQKD
         QYi+1zoh+8/lS6dAmNeRZgCszc7j0nse4SR87rwGoYSzvART8qYuksDcjPCnYkY8VtRV
         r6HB6vIkTf3L2qDcZfJ5Zv2J/pO3tJtTuWKgu8GsPo2vq5DnxNO9xiU16Vjkt17qtZ/g
         N/YbNIRuzBz1J8jiGol1xOy1PHOfbQgiO0N4sddQPUE4nhB9fybXi+uekFO4bZLrGpmb
         drFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6lui7fnu0IRlrp71D2hv/7mB2c92uRxIs2duLtUJCr4=;
        b=muVyJpxfVpke7FgoG0XHRAmFZfXwbZxyW0X8o5RO2+2NL6iyf5vx878EeRlzTHpHeW
         w0pQadwbsOmhsXnyLcjnKOV+HdmxUnSxvvmJTbQRKwQPBy6/++wiaSoQb9p5tY0FiCwK
         hWqyBmenLXHM3UDf8exB3l1OlwDRS3d8COfQB/Af3B8qwOP20Q1iaAqM34+91+iSn+HE
         RX/EdDzfWNPaXCSaCC4d8hhrwbpCLvkrCVUMLrgzLGQHtFMsB9qSi5b+0yYL2nVd6PnF
         Uf2cYDt9JxQ0drMZs6sa5wTzUDODW3NAP7Juj2cU7QGPuBs4/EEO7Gniax5HmlNorgj5
         ltRw==
X-Gm-Message-State: APjAAAXINSulzU05slLz0SSEw3QQnP9LhidPTx2HBRNdCom2XOplh4yW
        EZonweW5i7dMBJXrRLl7R0toRB/m
X-Google-Smtp-Source: APXvYqzHgWqY9k0adCl/Vvhtrnhf1oJO8DrbmmigGvJr2zN4EVM/BCCbfeioo2Nw0N1ceb+oJ/QiMg==
X-Received: by 2002:a62:b25d:: with SMTP id x90mr11856284pfe.102.1553082484503;
        Wed, 20 Mar 2019 04:48:04 -0700 (PDT)
Received: from ash ([171.226.148.85])
        by smtp.gmail.com with ESMTPSA id f4sm2085392pgq.94.2019.03.20.04.48.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 20 Mar 2019 04:48:03 -0700 (PDT)
Received: by ash (sSMTP sendmail emulation); Wed, 20 Mar 2019 18:48:00 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 11/20] diff-parseopt: convert --[src|dst]-prefix
Date:   Wed, 20 Mar 2019 18:46:54 +0700
Message-Id: <20190320114703.18659-12-pclouds@gmail.com>
X-Mailer: git-send-email 2.21.0.548.gd3c7d92dc2
In-Reply-To: <20190320114703.18659-1-pclouds@gmail.com>
References: <20190320114703.18659-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 diff.c          | 14 ++++++--------
 parse-options.h |  3 ++-
 2 files changed, 8 insertions(+), 9 deletions(-)

diff --git a/diff.c b/diff.c
index 30baf21021..2d34dc878e 100644
--- a/diff.c
+++ b/diff.c
@@ -5255,6 +5255,12 @@ static void prep_parse_options(struct diff_options *options)
 			    N_("do not munge pathnames and use NULs as output field terminators in --raw or --numstat"),
 			    0),
 		OPT__ABBREV(&options->abbrev),
+		OPT_STRING_F(0, "src-prefix", &options->a_prefix, N_("<prefix>"),
+			     N_("show the given source prefix instead of \"a/\""),
+			     PARSE_OPT_NONEG),
+		OPT_STRING_F(0, "dst-prefix", &options->b_prefix, N_("<prefix>"),
+			     N_("show the given source prefix instead of \"b/\""),
+			     PARSE_OPT_NONEG),
 		OPT_CALLBACK_F(0, "output-indicator-new",
 			       &options->output_indicators[OUTPUT_INDICATOR_NEW],
 			       N_("<char>"),
@@ -5449,20 +5455,12 @@ int diff_opt_parse(struct diff_options *options,
 	}
 
 	/* misc options */
-	else if ((argcount = parse_long_opt("src-prefix", av, &optarg))) {
-		options->a_prefix = optarg;
-		return argcount;
-	}
 	else if ((argcount = parse_long_opt("line-prefix", av, &optarg))) {
 		options->line_prefix = optarg;
 		options->line_prefix_length = strlen(options->line_prefix);
 		graph_setup_line_prefix(options);
 		return argcount;
 	}
-	else if ((argcount = parse_long_opt("dst-prefix", av, &optarg))) {
-		options->b_prefix = optarg;
-		return argcount;
-	}
 	else if (!strcmp(arg, "--no-prefix"))
 		options->a_prefix = options->b_prefix = "";
 	else if (opt_arg(arg, '\0', "inter-hunk-context",
diff --git a/parse-options.h b/parse-options.h
index 7d83e2971d..c95cbe26f0 100644
--- a/parse-options.h
+++ b/parse-options.h
@@ -136,6 +136,7 @@ struct option {
 #define OPT_BOOL_F(s, l, v, h, f)   OPT_SET_INT_F(s, l, v, h, 1, f)
 #define OPT_CALLBACK_F(s, l, v, a, h, f, cb)			\
 	{ OPTION_CALLBACK, (s), (l), (v), (a), (h), (f), (cb) }
+#define OPT_STRING_F(s, l, v, a, h, f)   { OPTION_STRING,  (s), (l), (v), (a), (h), (f) }
 
 #define OPT_END()                   { OPTION_END }
 #define OPT_ARGUMENT(l, h)          { OPTION_ARGUMENT, 0, (l), NULL, NULL, \
@@ -157,7 +158,7 @@ struct option {
 #define OPT_INTEGER(s, l, v, h)     { OPTION_INTEGER, (s), (l), (v), N_("n"), (h) }
 #define OPT_MAGNITUDE(s, l, v, h)   { OPTION_MAGNITUDE, (s), (l), (v), \
 				      N_("n"), (h), PARSE_OPT_NONEG }
-#define OPT_STRING(s, l, v, a, h)   { OPTION_STRING,  (s), (l), (v), (a), (h) }
+#define OPT_STRING(s, l, v, a, h)   OPT_STRING_F(s, l, v, a, h, 0)
 #define OPT_STRING_LIST(s, l, v, a, h) \
 				    { OPTION_CALLBACK, (s), (l), (v), (a), \
 				      (h), 0, &parse_opt_string_list }
-- 
2.21.0.548.gd3c7d92dc2

