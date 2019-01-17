Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DB2EC1F453
	for <e@80x24.org>; Thu, 17 Jan 2019 13:10:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728068AbfAQNKa (ORCPT <rfc822;e@80x24.org>);
        Thu, 17 Jan 2019 08:10:30 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:37498 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726065AbfAQNKa (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 Jan 2019 08:10:30 -0500
Received: by mail-pl1-f193.google.com with SMTP id b5so4745753plr.4
        for <git@vger.kernel.org>; Thu, 17 Jan 2019 05:10:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Ifxdlaal2My35kIBSlWdk5XeW6kqXCqZusrthmtqAmo=;
        b=XviWkx1K2Wnf67dCxSQpc02g4jnbEHf85MOMZYM2LPyRQlEebEVXwLYwqQMlfoT2oO
         On1IVGRdr8NdugxyqS5iL67Jcq19BrTCD1p4Du4JWyDYMBvjTUzMVXKHq4LYDmB0Z0wn
         7QG95sRtu9IX3i3htKgtTZPAU7YkVL9gGneYKJnCI2YfRvy/Fv8jJEiYDLSR57SMQ7ar
         KKpHcWhSURYwiBFJGpMRwS9Za3iL1ABAuzUjwUt0VVuetlsK3czfyaFaadsbYMo6vk9m
         0XydRRfQSOgx5O7TeGDbkXdo0JVAtkk0k3mpnrvLM66XLoT/+5ZXRQPULAFFPs5WiBQv
         cinA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Ifxdlaal2My35kIBSlWdk5XeW6kqXCqZusrthmtqAmo=;
        b=WdF1xiUjM26DFcB1o2Ew2cUcQLN96j4vQ1+u9RpNAkYxLnFppTX2U+yHVbUYP9u/41
         oqIni5tmhp1/8ipxd/6Qd40pGJWF59YAZUDEgVe8kFHAcQY3gVowOJ8eY6h/Rw8OiEwC
         bXTztkDpSCsixUzSyqH4v55tK53XxN8+EAFGHSoJA3jyC/0S8+bfgaY+zuYKsuFdjNmE
         kQm4e5mjeoQJShoKh2bd7/7kxZvVXkXUrzKFF6GqjBzHTakX1QCYeO3g4Yb+NzKmspVO
         RncR4zvxpJyg8XFTVF/smY1VhxAiUMnMkFskqku1G5VbbYxNx9On53bmxR+r9BgOhhoK
         hXdA==
X-Gm-Message-State: AJcUukev6eEBOVHitnlKOAXn56T2zN89Dr20WA9yI7MxMIpznUkzDfFb
        uWF+3Reez9SgDuqC51MatGfUF3Hm
X-Google-Smtp-Source: ALg8bN5+LxpuXWh4TO/dX1v84PXcnbx4r16v5E2MqgR7uHK2yxqTFTIQq7KtxxajeER4nActpz9n0A==
X-Received: by 2002:a17:902:720c:: with SMTP id ba12mr14957717plb.79.1547730629921;
        Thu, 17 Jan 2019 05:10:29 -0800 (PST)
Received: from ash ([115.72.21.220])
        by smtp.gmail.com with ESMTPSA id s9sm4186812pgl.88.2019.01.17.05.10.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 17 Jan 2019 05:10:29 -0800 (PST)
Received: by ash (sSMTP sendmail emulation); Thu, 17 Jan 2019 20:10:25 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 48/76] diff.c: convert --word-diff
Date:   Thu, 17 Jan 2019 20:05:47 +0700
Message-Id: <20190117130615.18732-49-pclouds@gmail.com>
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
 diff.c | 47 +++++++++++++++++++++++++++++------------------
 1 file changed, 29 insertions(+), 18 deletions(-)

diff --git a/diff.c b/diff.c
index 0c7a100f84..b80eefe9bc 100644
--- a/diff.c
+++ b/diff.c
@@ -5070,6 +5070,32 @@ static int diff_opt_unified(const struct option *opt,
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
@@ -5232,6 +5258,9 @@ static void prep_parse_options(struct diff_options *options)
 		OPT_CALLBACK_F(0, "anchored", options, N_("<text>"),
 			       N_("generate diff using the \"anchored diff\" algorithm"),
 			       PARSE_OPT_NONEG, diff_opt_anchored),
+		OPT_CALLBACK_F(0, "word-diff", options, N_("<mode>"),
+			       N_("show word diff, using <mode> to delimit changed words"),
+			       PARSE_OPT_NONEG | PARSE_OPT_OPTARG, diff_opt_word_diff),
 
 		OPT_GROUP(N_("Diff other options")),
 		OPT_CALLBACK_F(0, "relative", options, N_("<prefix>"),
@@ -5295,24 +5324,6 @@ int diff_opt_parse(struct diff_options *options,
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
2.20.0.482.g66447595a7

