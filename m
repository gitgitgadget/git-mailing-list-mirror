Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2818220248
	for <e@80x24.org>; Tue,  5 Mar 2019 12:31:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728266AbfCEMbl (ORCPT <rfc822;e@80x24.org>);
        Tue, 5 Mar 2019 07:31:41 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:33885 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728253AbfCEMbk (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 5 Mar 2019 07:31:40 -0500
Received: by mail-pg1-f193.google.com with SMTP id i130so5554912pgd.1
        for <git@vger.kernel.org>; Tue, 05 Mar 2019 04:31:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=gRLUrfek8T3CohfmLzRKJ23g5UrTo3AOMBP2uifJXKc=;
        b=IJ/wm0fKLjybg0D/0qsmKOPH3K+9oosc9rd9WOWN57Nmpu6tcrcRkpPx5MLE/T+RCp
         ztbJhpMozmW3/6m+OW8kFCTG/SpcckT60buxroKn/kiM2UdhLGCXyIz3M2VHjaxEdD/J
         9j7utOQvfNSxg3kfGg+KiM8uEDccBT4R8A97xOPG5G0Hi1WtudB5f3AMsNM0jlDwwmWA
         ZbI1HsjBXicO4Qv/tgidhHHb9uTPOZXeIqAoziTpe9WWFAx+66UfekCCXKbiV7TH+iv5
         bVaeH2YIcEtKdfiy7XziXTRK8RCX2PBczRpnNfLD4JjUTnKWyzobVWALVTaoiThIQxeu
         UKIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gRLUrfek8T3CohfmLzRKJ23g5UrTo3AOMBP2uifJXKc=;
        b=MBN+GvXdezeCAJEk9kVG0vVN0KoH2zWuSywGk3NPoqchMGsHgKPIVaLemLKNfnLA0x
         Ynr3yLPgoi5myn27PXUr6rMTkmwpiqqs4DgHrV+alYMNR85yCtaHLPnEWeQphkQDK7Jc
         APvpZLXLLcjIh77186+j49qd8+LeIXpwGsELAlTonXe2UsLPBKWBA57CLmBcLv1qHv7T
         aesoH0/6Q3PiSDJsJ5fPtanddflMCoQ2DEWIkHzrqUWoYdsubz4enlaFYU3aLgyOKEcH
         /V+H7gLU/Qp25N1tPSuEkjGuGj0btGSJPZANO0bZyFgCXgpwU2eWGBOPxMSxo3uHkj+q
         mjhA==
X-Gm-Message-State: APjAAAU0c3jjmqUbSHm1crAM1saEpIbV2FJenDEkjFnakLKvcGyJ2pQq
        sIkhIpS9Rgxe5V7cIAm6Lmlkw5eM
X-Google-Smtp-Source: APXvYqwmDkRvGWJg0fGPrJzDAbeeas3sD7wDbNoZSKChzd+ANUNdDQyGbGC7ueWZtpY/wUxMqKty/Q==
X-Received: by 2002:a63:f718:: with SMTP id x24mr1214898pgh.107.1551789100088;
        Tue, 05 Mar 2019 04:31:40 -0800 (PST)
Received: from ash ([171.226.148.85])
        by smtp.gmail.com with ESMTPSA id 33sm21174157pgs.81.2019.03.05.04.31.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 05 Mar 2019 04:31:39 -0800 (PST)
Received: by ash (sSMTP sendmail emulation); Tue, 05 Mar 2019 19:31:35 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 12/20] diff-parseopt: convert --word-diff
Date:   Tue,  5 Mar 2019 19:30:18 +0700
Message-Id: <20190305123026.7266-13-pclouds@gmail.com>
X-Mailer: git-send-email 2.21.0.rc1.337.gdf7f8d0522
In-Reply-To: <20190305123026.7266-1-pclouds@gmail.com>
References: <20190305123026.7266-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 diff.c | 47 +++++++++++++++++++++++++++++------------------
 1 file changed, 29 insertions(+), 18 deletions(-)

diff --git a/diff.c b/diff.c
index bb36d507ec..14c057f3df 100644
--- a/diff.c
+++ b/diff.c
@@ -5066,6 +5066,32 @@ static int diff_opt_unified(const struct option *opt,
 	return 0;
 }
 
+static int diff_opt_word_diff(const struct option *opt,
+			      const char *arg, int unset)
+{
+	struct diff_options *options = opt->value;
+
+	BUG_ON_OPT_NEG(unset);
+	if (arg) {
+		if (!strcmp(arg, "plain"))
+			options->word_diff = DIFF_WORDS_PLAIN;
+		else if (!strcmp(arg, "color")) {
+			options->use_color = 1;
+			options->word_diff = DIFF_WORDS_COLOR;
+		}
+		else if (!strcmp(arg, "porcelain"))
+			options->word_diff = DIFF_WORDS_PORCELAIN;
+		else if (!strcmp(arg, "none"))
+			options->word_diff = DIFF_WORDS_NONE;
+		else
+			return error(_("bad --word-diff argument: %s"), arg);
+	} else {
+		if (options->word_diff == DIFF_WORDS_NONE)
+			options->word_diff = DIFF_WORDS_PLAIN;
+	}
+	return 0;
+}
+
 static void prep_parse_options(struct diff_options *options)
 {
 	struct option parseopts[] = {
@@ -5228,6 +5254,9 @@ static void prep_parse_options(struct diff_options *options)
 		OPT_CALLBACK_F(0, "anchored", options, N_("<text>"),
 			       N_("generate diff using the \"anchored diff\" algorithm"),
 			       PARSE_OPT_NONEG, diff_opt_anchored),
+		OPT_CALLBACK_F(0, "word-diff", options, N_("<mode>"),
+			       N_("show word diff, using <mode> to delimit changed words"),
+			       PARSE_OPT_NONEG | PARSE_OPT_OPTARG, diff_opt_word_diff),
 
 		OPT_GROUP(N_("Diff other options")),
 		OPT_CALLBACK_F(0, "relative", options, N_("<prefix>"),
@@ -5291,24 +5320,6 @@ int diff_opt_parse(struct diff_options *options,
 		options->use_color = 1;
 		options->word_diff = DIFF_WORDS_COLOR;
 	}
-	else if (!strcmp(arg, "--word-diff")) {
-		if (options->word_diff == DIFF_WORDS_NONE)
-			options->word_diff = DIFF_WORDS_PLAIN;
-	}
-	else if (skip_prefix(arg, "--word-diff=", &arg)) {
-		if (!strcmp(arg, "plain"))
-			options->word_diff = DIFF_WORDS_PLAIN;
-		else if (!strcmp(arg, "color")) {
-			options->use_color = 1;
-			options->word_diff = DIFF_WORDS_COLOR;
-		}
-		else if (!strcmp(arg, "porcelain"))
-			options->word_diff = DIFF_WORDS_PORCELAIN;
-		else if (!strcmp(arg, "none"))
-			options->word_diff = DIFF_WORDS_NONE;
-		else
-			die("bad --word-diff argument: %s", arg);
-	}
 	else if ((argcount = parse_long_opt("word-diff-regex", av, &optarg))) {
 		if (options->word_diff == DIFF_WORDS_NONE)
 			options->word_diff = DIFF_WORDS_PLAIN;
-- 
2.21.0.rc1.337.gdf7f8d0522

