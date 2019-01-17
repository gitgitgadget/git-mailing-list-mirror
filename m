Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7A23F1F453
	for <e@80x24.org>; Thu, 17 Jan 2019 13:09:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728073AbfAQNJ5 (ORCPT <rfc822;e@80x24.org>);
        Thu, 17 Jan 2019 08:09:57 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:43670 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725878AbfAQNJ4 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 Jan 2019 08:09:56 -0500
Received: by mail-pf1-f193.google.com with SMTP id w73so4804532pfk.10
        for <git@vger.kernel.org>; Thu, 17 Jan 2019 05:09:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=qGnOqaEF65XpSzFmJvROWrXp28vdiwIcOhHbQMCh+hA=;
        b=Rto+OtpQ8mOjmLPWYf5TXSANw4e0xj9cC34lDesXeiFKxuN2IUP3mUrJDeGPrBzUgU
         JL0hvaipk00eCMAZcsitu1AqFhxoHJdcSIa4KeZRI3z+vNGrYoSxOdi4Gb8MmvXZExWt
         V3dQjIfPWQ6mqTq+gekT+Cs1Ze0do0iEMpV7yMpO7Mr+w9G1YBT0GFy1BUyPknHLFia2
         EaZa/X2OdKHiOiCtaDXfPwJXhlIwaJNz43cMBa8vDZOCQ0vjVzGCbn2m3tiUb4MsAhoL
         hGOVwNkTiVMLeUq7L57MjttXpBObOslwyWYlJ21ksRP59JNkqMQsvtJY8YSqyaxOBGIm
         ZgEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qGnOqaEF65XpSzFmJvROWrXp28vdiwIcOhHbQMCh+hA=;
        b=rQLr9LLeUt6dTq3ml9GWA9hE5QpuXFgeML37nPQQ6b0F/r2XotI6u+tnBbqylrMBbu
         kYmIqjFXPC/eFizXaNLkIXbzSb716ET7OYvsoaPLxadryZwuk9UYU2CV525N8g2fbNjZ
         tf0MeaCVOHoaNN3IRdJFJGoOdTI+YIpOj2dvaOPXalDHcUirzsnMaKNZsZMHynUbHdkR
         kkWMM7oqfI+2xnRNtJmgCKTTDcsFrgXPZVYfJVAkpJwUdd44vm9xjA9KdUVcH1LpSApX
         OTbQSrqM0bdlOcTpCjM0GDSh8a+YG4cHvjN+QR0RK479CvumGOSOMCJQSLcY8MbSrpwQ
         Cs3w==
X-Gm-Message-State: AJcUuketRTkbHvK1NVQ9WjmKRla0jFw2Nbr46XyRfcxeEqWEuToiidJx
        jUlnyF7QbMQ3NY4lSsNVejl5gxnw
X-Google-Smtp-Source: ALg8bN4dwSSthhcDs3uGN7Y0k6/Nbopm3pH1Ue2yqyiQexV8TW5rOCdC5wke5RWbf5BkpXUmvb9lXw==
X-Received: by 2002:a65:60c2:: with SMTP id r2mr13594662pgv.393.1547730595703;
        Thu, 17 Jan 2019 05:09:55 -0800 (PST)
Received: from ash ([115.72.21.220])
        by smtp.gmail.com with ESMTPSA id v70sm2637945pfa.152.2019.01.17.05.09.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 17 Jan 2019 05:09:55 -0800 (PST)
Received: by ash (sSMTP sendmail emulation); Thu, 17 Jan 2019 20:09:51 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 41/76] diff.c: convert --anchored
Date:   Thu, 17 Jan 2019 20:05:40 +0700
Message-Id: <20190117130615.18732-42-pclouds@gmail.com>
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
 diff.c | 26 +++++++++++++++++---------
 1 file changed, 17 insertions(+), 9 deletions(-)

diff --git a/diff.c b/diff.c
index 2b93f08958..bee36fb276 100644
--- a/diff.c
+++ b/diff.c
@@ -4842,6 +4842,19 @@ static int parse_objfind_opt(struct diff_options *opt, const char *arg)
 	return 1;
 }
 
+static int diff_opt_anchored(const struct option *opt,
+			     const char *arg, int unset)
+{
+	struct diff_options *options = opt->value;
+
+	BUG_ON_OPT_NEG(unset);
+	options->xdl_opts = DIFF_WITH_ALG(options, PATIENCE_DIFF);
+	ALLOC_GROW(options->anchors, options->anchors_nr + 1,
+		   options->anchors_alloc);
+	options->anchors[options->anchors_nr++] = xstrdup(arg);
+	return 0;
+}
+
 static int diff_opt_break_rewrites(const struct option *opt,
 				   const char *arg, int unset)
 {
@@ -5179,6 +5192,9 @@ static void prep_parse_options(struct diff_options *options)
 		OPT_CALLBACK_F(0, "diff-algorithm", options, N_("<algorithm>"),
 			       N_("choose a diff algorithm"),
 			       PARSE_OPT_NONEG, diff_opt_diff_algorithm),
+		OPT_CALLBACK_F(0, "anchored", options, N_("<text>"),
+			       N_("generate diff using the \"anchored diff\" algorithm"),
+			       PARSE_OPT_NONEG, diff_opt_anchored),
 
 		OPT_GROUP(N_("Diff other options")),
 		OPT_CALLBACK_F(0, "relative", options, N_("<prefix>"),
@@ -5216,16 +5232,8 @@ int diff_opt_parse(struct diff_options *options,
 	if (ac)
 		return ac;
 
-	/* xdiff options */
-	if (skip_prefix(arg, "--anchored=", &arg)) {
-		options->xdl_opts = DIFF_WITH_ALG(options, PATIENCE_DIFF);
-		ALLOC_GROW(options->anchors, options->anchors_nr + 1,
-			   options->anchors_alloc);
-		options->anchors[options->anchors_nr++] = xstrdup(arg);
-	}
-
 	/* flags options */
-	else if (!strcmp(arg, "--binary")) {
+	if (!strcmp(arg, "--binary")) {
 		enable_patch_output(&options->output_format);
 		options->flags.binary = 1;
 	}
-- 
2.20.0.482.g66447595a7

