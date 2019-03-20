Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0B19920248
	for <e@80x24.org>; Wed, 20 Mar 2019 11:48:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728063AbfCTLsP (ORCPT <rfc822;e@80x24.org>);
        Wed, 20 Mar 2019 07:48:15 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:33481 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728001AbfCTLsO (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 20 Mar 2019 07:48:14 -0400
Received: by mail-pf1-f195.google.com with SMTP id i19so1780885pfd.0
        for <git@vger.kernel.org>; Wed, 20 Mar 2019 04:48:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=rZPnPdvuhrNvtya1bPytGdmJkP/s5w0ac7YcgyJxi3Q=;
        b=F6v6XzUik9K9lfXVjgM8T+/sjlIDPPyjpSXmDFSDQPRdMeQBBNOajDd64wzlM9GVtJ
         5RUcEdUPa9zbnLG2Nu1S9HUZHwBHXMK01JT9FLRlo3zuwRi2eAkqeMTxBr1sOgMmLc9x
         42as++IEwlwFEG7ehe6H8efkBYwDYrVH9SoS7bw7cizLegEY4vAXz3zzZyXcIyYD5M0s
         qfYm23HKNMiUArZYprnB+J/27DDinK617q4dYyQjq64Qy16h8FB+RCBmmqaKFj7RUz8D
         SmwWgADVEHDFwBfkMSvEJa8Ye0hS/UIfJ2ViYWlTFc760oL033lYidoy1Og5xJAA/w0f
         4MSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=rZPnPdvuhrNvtya1bPytGdmJkP/s5w0ac7YcgyJxi3Q=;
        b=Ahqea8rdGAJv9CGjOjNmOxzX1vlmT8tH5Y/CXBguhGv8XiJUmIW6Gv6J2nJi13Nyry
         hxRuC+svf03VLPqyly3hLq/3mwIm8eOtD8tfpZNKZEgxRRnqmwTN9LcH9EZ7MJqd8KvX
         lqjXjomuKQx4v5rzDvuooZXCMVXcNi3BpuOcXuz7yM3oI6Joraau+uLw7cpSaVH0sK+v
         WA2jw7XjFqFqlxsHJWOcWkdBLd8Gii2dDxImdbcWYa/08B4BDoAovCUtWyhI+y67AHuB
         UVBC5TzoZBw6+LNSHhiZpsUB67fWlQjJVYgpwLuK0QxujM3b4vZ59kD2Q2IsUNDbJGKb
         DaVg==
X-Gm-Message-State: APjAAAWc3fh3niVMLID62bKEHkZgCkfetBrnlF86kEzZ/55fOlr2rlkm
        7cbVFlraisFLTk/xOxL+wiUBfMK1
X-Google-Smtp-Source: APXvYqwnnBbXuEn0mBbhXXUxMWUEYbSxfLa3S3qaKBI0BXG6vM9VTIXI1fykj4cBAPeyDwKIUB9h2w==
X-Received: by 2002:a17:902:d24:: with SMTP id 33mr23325517plu.246.1553082493735;
        Wed, 20 Mar 2019 04:48:13 -0700 (PDT)
Received: from ash ([171.226.148.85])
        by smtp.gmail.com with ESMTPSA id a7sm2337909pfc.45.2019.03.20.04.48.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 20 Mar 2019 04:48:13 -0700 (PDT)
Received: by ash (sSMTP sendmail emulation); Wed, 20 Mar 2019 18:48:09 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 13/20] diff-parseopt: convert --no-prefix
Date:   Wed, 20 Mar 2019 18:46:56 +0700
Message-Id: <20190320114703.18659-14-pclouds@gmail.com>
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
 diff.c | 17 +++++++++++++++--
 1 file changed, 15 insertions(+), 2 deletions(-)

diff --git a/diff.c b/diff.c
index 4ab5b3c06a..045fdbb882 100644
--- a/diff.c
+++ b/diff.c
@@ -5022,6 +5022,18 @@ static int diff_opt_line_prefix(const struct option *opt,
 	return 0;
 }
 
+static int diff_opt_no_prefix(const struct option *opt,
+			      const char *optarg, int unset)
+{
+	struct diff_options *options = opt->value;
+
+	BUG_ON_OPT_NEG(unset);
+	BUG_ON_OPT_ARG(optarg);
+	options->a_prefix = "";
+	options->b_prefix = "";
+	return 0;
+}
+
 static enum parse_opt_result diff_opt_output(struct parse_opt_ctx_t *ctx,
 					     const struct option *opt,
 					     const char *arg, int unset)
@@ -5276,6 +5288,9 @@ static void prep_parse_options(struct diff_options *options)
 		OPT_CALLBACK_F(0, "line-prefix", options, N_("<prefix>"),
 			       N_("prepend an additional prefix to every line of output"),
 			       PARSE_OPT_NONEG, diff_opt_line_prefix),
+		OPT_CALLBACK_F(0, "no-prefix", options, NULL,
+			       N_("no not show any source or destination prefix"),
+			       PARSE_OPT_NONEG | PARSE_OPT_NOARG, diff_opt_no_prefix),
 		OPT_CALLBACK_F(0, "output-indicator-new",
 			       &options->output_indicators[OUTPUT_INDICATOR_NEW],
 			       N_("<char>"),
@@ -5468,8 +5483,6 @@ int diff_opt_parse(struct diff_options *options,
 	}
 
 	/* misc options */
-	else if (!strcmp(arg, "--no-prefix"))
-		options->a_prefix = options->b_prefix = "";
 	else if (opt_arg(arg, '\0', "inter-hunk-context",
 			 &options->interhunkcontext))
 		;
-- 
2.21.0.548.gd3c7d92dc2

