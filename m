Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 53EB120248
	for <e@80x24.org>; Wed, 20 Mar 2019 11:48:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728060AbfCTLsK (ORCPT <rfc822;e@80x24.org>);
        Wed, 20 Mar 2019 07:48:10 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:46106 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728001AbfCTLsK (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 20 Mar 2019 07:48:10 -0400
Received: by mail-pg1-f196.google.com with SMTP id a22so1600969pgg.13
        for <git@vger.kernel.org>; Wed, 20 Mar 2019 04:48:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=q6nHeR93jYKq3cxlL9ndQqi0yjDcun/sOOhJQPnOB7I=;
        b=RoN2KNSM2KeKwXAjUn5S3BIeXk2L6sMbZeWgLtbOLvFXCGvnBsiTq4qp+0rN6GREIB
         Craz5+GEIeZe+OZi4u7Ace6yXz4s3+6R0iXYxSHuejaCREY+/t8d4gpiS7ynpfmAiHul
         6XHSyC+83xZz+x6Ie/HEsmvoOj1ZKmwZCxHz1f3q5KY4FsLxmmczAaFHqEqiQxGSM4TO
         710NmNPmr8tL1GV9nUYCVjDIEf5AG7ZDknHHiBe0zkPM7erBPACXtcrz1pyi6qvbsqp4
         gOUdomM2wAxc8OgIvM/CZrJ6YR2iNfslMXSQOWUpsDPa3rIB+0oJoV7poQwGDN/ajVvV
         H0SQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=q6nHeR93jYKq3cxlL9ndQqi0yjDcun/sOOhJQPnOB7I=;
        b=nfM8Xm3VVPcp1e4ZinPdG7JY+pASjmTr7fbxu0ikugJFM3IR4PcoMNQdf5HkTMsKYP
         SkrPPSDY/dHjUpw8O4V1b21w7xTSn0iCh78TLESkcjcfnv/vgdVVBw01zm85Zb3F5lfK
         mWukmcqDm3O4by2qelmwUB2B2q74iU7/1yEtya3G/jqX3DA7OJc8ZwElGLbxTIC1alC7
         jKB5noi3SPIKbZ04nlUT+oyteEG3zNbelIOBqBvD7tm+u5EP3+QnracY3AS9VJa4Op+a
         ff1wVB1EEVpxIkZ6COtuPo4PvfZ0PQJ8JTEI3fkBgMFlYn5Am/ZiqMc+CiXCXjKqj1AN
         /Aqg==
X-Gm-Message-State: APjAAAXQHTR+0vL2eboJdbpKbE2Ew/QQomaIzHTWYIt9rRMots7OwsKA
        +4GCWjs8D9wK+cc/A0NeDARQ5kw/
X-Google-Smtp-Source: APXvYqwTQZdxnU1erb95Geujdkfw85Gqp0D1camMDCn1iOVbs+A100H12EQfjKmTBZQ9DdOnhOqK3g==
X-Received: by 2002:a65:6656:: with SMTP id z22mr6642924pgv.95.1553082489080;
        Wed, 20 Mar 2019 04:48:09 -0700 (PDT)
Received: from ash ([171.226.148.85])
        by smtp.gmail.com with ESMTPSA id l184sm3091701pfc.41.2019.03.20.04.48.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 20 Mar 2019 04:48:08 -0700 (PDT)
Received: by ash (sSMTP sendmail emulation); Wed, 20 Mar 2019 18:48:04 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 12/20] diff-parseopt: convert --line-prefix
Date:   Wed, 20 Mar 2019 18:46:55 +0700
Message-Id: <20190320114703.18659-13-pclouds@gmail.com>
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
 diff.c | 23 +++++++++++++++--------
 1 file changed, 15 insertions(+), 8 deletions(-)

diff --git a/diff.c b/diff.c
index 2d34dc878e..4ab5b3c06a 100644
--- a/diff.c
+++ b/diff.c
@@ -5010,6 +5010,18 @@ static int diff_opt_ignore_submodules(const struct option *opt,
 	return 0;
 }
 
+static int diff_opt_line_prefix(const struct option *opt,
+				const char *optarg, int unset)
+{
+	struct diff_options *options = opt->value;
+
+	BUG_ON_OPT_NEG(unset);
+	options->line_prefix = optarg;
+	options->line_prefix_length = strlen(options->line_prefix);
+	graph_setup_line_prefix(options);
+	return 0;
+}
+
 static enum parse_opt_result diff_opt_output(struct parse_opt_ctx_t *ctx,
 					     const struct option *opt,
 					     const char *arg, int unset)
@@ -5261,6 +5273,9 @@ static void prep_parse_options(struct diff_options *options)
 		OPT_STRING_F(0, "dst-prefix", &options->b_prefix, N_("<prefix>"),
 			     N_("show the given source prefix instead of \"b/\""),
 			     PARSE_OPT_NONEG),
+		OPT_CALLBACK_F(0, "line-prefix", options, N_("<prefix>"),
+			       N_("prepend an additional prefix to every line of output"),
+			       PARSE_OPT_NONEG, diff_opt_line_prefix),
 		OPT_CALLBACK_F(0, "output-indicator-new",
 			       &options->output_indicators[OUTPUT_INDICATOR_NEW],
 			       N_("<char>"),
@@ -5418,8 +5433,6 @@ int diff_opt_parse(struct diff_options *options,
 		   const char **av, int ac, const char *prefix)
 {
 	const char *arg = av[0];
-	const char *optarg;
-	int argcount;
 
 	if (!prefix)
 		prefix = "";
@@ -5455,12 +5468,6 @@ int diff_opt_parse(struct diff_options *options,
 	}
 
 	/* misc options */
-	else if ((argcount = parse_long_opt("line-prefix", av, &optarg))) {
-		options->line_prefix = optarg;
-		options->line_prefix_length = strlen(options->line_prefix);
-		graph_setup_line_prefix(options);
-		return argcount;
-	}
 	else if (!strcmp(arg, "--no-prefix"))
 		options->a_prefix = options->b_prefix = "";
 	else if (opt_arg(arg, '\0', "inter-hunk-context",
-- 
2.21.0.548.gd3c7d92dc2

