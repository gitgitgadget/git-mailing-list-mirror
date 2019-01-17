Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F289D1F453
	for <e@80x24.org>; Thu, 17 Jan 2019 13:10:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728165AbfAQNKl (ORCPT <rfc822;e@80x24.org>);
        Thu, 17 Jan 2019 08:10:41 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:32934 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725898AbfAQNKk (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 Jan 2019 08:10:40 -0500
Received: by mail-pf1-f196.google.com with SMTP id c123so4836249pfb.0
        for <git@vger.kernel.org>; Thu, 17 Jan 2019 05:10:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=bIfDQso5dwuHQZMga5/+ZKtqfP9W9of/sQSFhZkRJSo=;
        b=LRYBJjFW+deqmvXJLkUi9dsbsN4WKMN8nCqZ2UXvQm7Nno1EpAincrn0csaiKE2U9d
         hizKqsaGnCb1HqLklBnDT7Yxx682OHpaLgtAfCuVGDVdW43R/kd9YBFVW+ggJ7JnWkX8
         OnaSAO/8mDPvk3y2wvITyBJAjtLNdc+5+7PJmrWqBfb3UTnxPykkPgUBQhFdd5hk3eaH
         65so+nYmEt+ZgjaLRHT05LIWlr/3nVwGv46gKdVyPk3/F9gT1od/U3vA3+sbMLIkWRDT
         FRK7SOfZ8DdgGSudOPa7B4XPHjFOIpEUqnA8b+a7zVVlYlcO1AB7QubK4q4KS48WZ8sM
         /FOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=bIfDQso5dwuHQZMga5/+ZKtqfP9W9of/sQSFhZkRJSo=;
        b=eT/8nd8vWiRMhusZQoHf+bMAJXsfHYLYYpMyuseo3H9D9NCbrefFEYicYHWCkkM/r4
         muVO23Jr5FpnPxfYbI2sINLizjxVJF4LBwf2xGbZuYQpywjI9W7ki8fQ7KHxuz3LKOQJ
         +SC3StcITaXtwNApDQaE48wINCuwDhijt3O2A1wx91XHchl761M7J1nwGvL2ose9ve6P
         SpDVc05ZZM8bGgciH1l4WNSCOXaahQ5X2jBIuDGoiwjvsVeI3rSHGbgX5i7fVfB+t3aX
         YiPDzDYGtDP8Gr3WxNzrZuNupiZN9ydC86pWjYfTJDWCKak5Kv8aVEXeb0OPMw3FB5Vc
         N6zA==
X-Gm-Message-State: AJcUukdyoH+jbutyYJfRvs2AdzIeT7GGTh53K2eURY0PERg7AcQx6Bcq
        kY9/xnckSMmlWB6U6qxETo1AmNsC
X-Google-Smtp-Source: ALg8bN5qlvU6kQaxAdOGnJ6IevZTnuVzkkSAFPyBv98eWJdZk7PqHjLhIUdtN87iF2DOY+JAEwgofg==
X-Received: by 2002:a63:6906:: with SMTP id e6mr13194140pgc.144.1547730639722;
        Thu, 17 Jan 2019 05:10:39 -0800 (PST)
Received: from ash ([115.72.21.220])
        by smtp.gmail.com with ESMTPSA id j21sm3281715pfn.175.2019.01.17.05.10.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 17 Jan 2019 05:10:39 -0800 (PST)
Received: by ash (sSMTP sendmail emulation); Thu, 17 Jan 2019 20:10:34 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 50/76] diff.c: convert --color-words
Date:   Thu, 17 Jan 2019 20:05:49 +0700
Message-Id: <20190117130615.18732-51-pclouds@gmail.com>
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

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 diff.c | 21 ++++++++++++++++-----
 1 file changed, 16 insertions(+), 5 deletions(-)

diff --git a/diff.c b/diff.c
index 3e55c2fd1f..49cbf14417 100644
--- a/diff.c
+++ b/diff.c
@@ -4905,6 +4905,18 @@ static int diff_opt_char(const struct option *opt,
 	return 0;
 }
 
+static int diff_opt_color_words(const struct option *opt,
+				const char *arg, int unset)
+{
+	struct diff_options *options = opt->value;
+
+	BUG_ON_OPT_NEG(unset);
+	options->use_color = 1;
+	options->word_diff = DIFF_WORDS_COLOR;
+	options->word_regex = arg;
+	return 0;
+}
+
 static int diff_opt_compact_summary(const struct option *opt,
 				    const char *arg, int unset)
 {
@@ -5276,6 +5288,9 @@ static void prep_parse_options(struct diff_options *options)
 		OPT_CALLBACK_F(0, "word-diff-regex", options, N_("<regex>"),
 			       N_("use <regex> to decide what a word is"),
 			       PARSE_OPT_NONEG, diff_opt_word_diff_regex),
+		OPT_CALLBACK_F(0, "color-words", options, N_("<regex>"),
+			       N_("equivalent to --word-diff=color --word-diff-regex=<regex>"),
+			       PARSE_OPT_NONEG | PARSE_OPT_OPTARG, diff_opt_color_words),
 
 		OPT_GROUP(N_("Diff other options")),
 		OPT_CALLBACK_F(0, "relative", options, N_("<prefix>"),
@@ -5335,11 +5350,7 @@ int diff_opt_parse(struct diff_options *options,
 		if (cm & COLOR_MOVED_WS_ERROR)
 			return -1;
 		options->color_moved_ws_handling = cm;
-	} else if (skip_to_optional_arg_default(arg, "--color-words", &options->word_regex, NULL)) {
-		options->use_color = 1;
-		options->word_diff = DIFF_WORDS_COLOR;
-	}
-	else if (!strcmp(arg, "--exit-code"))
+	} else if (!strcmp(arg, "--exit-code"))
 		options->flags.exit_with_status = 1;
 	else if (!strcmp(arg, "--quiet"))
 		options->flags.quick = 1;
-- 
2.20.0.482.g66447595a7

