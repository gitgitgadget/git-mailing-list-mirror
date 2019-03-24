Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 783D420248
	for <e@80x24.org>; Sun, 24 Mar 2019 08:22:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728550AbfCXIWA (ORCPT <rfc822;e@80x24.org>);
        Sun, 24 Mar 2019 04:22:00 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:43472 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727727AbfCXIWA (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 24 Mar 2019 04:22:00 -0400
Received: by mail-pg1-f193.google.com with SMTP id l11so4335385pgq.10
        for <git@vger.kernel.org>; Sun, 24 Mar 2019 01:21:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=19J41iR97i/mP6yPwyBsWOHUZPfo+bimifdbVSzfPJI=;
        b=Nn264d+LWt9qT++HtsIoI9XLz1LF8kvdgkApfFWe4JiLkzQAwTVt9I5YyM1PijIFXA
         pu6JRI1cUc9hz/FndULC8+qaPLGveUTCeOvQdBeire8dMoSNeB4FV1+uiJ3nL1nN9d4G
         mvSeT7hF675v2j5nE45wvfZx8X9OFTpYWulEyKXuN6s7a8nSpOgOUPNLPWa3pMciXNy3
         2shWRgtiuIR6Ne0183qSfWS8FHMGrQrkH9RLsOVB2F5xEs2CRHAiVakBflYvhfxA8GAY
         vmnfoGDMQAh9jd9L8gg2koG3raj0sUFHJ6j1jNunGo2EaIGwMo3sPJ6c9lvCVzGCRZRv
         D/ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=19J41iR97i/mP6yPwyBsWOHUZPfo+bimifdbVSzfPJI=;
        b=KzEGCnCWp8S0JYMYRflqdh2BIuWKtOadEe0Vyb13DeeXqOCvvzZFFDchPZ9IzJ+5ww
         BUr5ykm+MQe5XMnOM01Xck5SaGwaTrnlcBHcMqu9DX7LuPv7A7MbkPkST+f7EEYNVQBd
         dfdmkwp3TnL/LF4hluSTN3UxXQzRryM7lBSIx25Hq2fmGhLSRqTiNOZfye0HMTPPh/Fm
         qz2L4IFv8eyHqfOeCjOQlShJ4AHTePP8m0AvCDoZloA5RGES3Fo2aygLXCyuZ7FmP7v9
         QNNE07Irrayf9cFPdjydGkM5vjhS/iyOzPo479Gke3jKU0ZVvzguWtZpZpODng3q+keV
         PdiA==
X-Gm-Message-State: APjAAAXY7q4548pPUCmfeQksQ/jGUk8sScRKRNtELNbf/uS+G9bQ/bDF
        YmbnluxJuxUdb7GubG0lrqxenp95
X-Google-Smtp-Source: APXvYqzRM85Mcf5tZJHjixnBu+xwT3aYQyYnCZufyj+C8FSFEKKhKqx6fTSfjpgqKOqe+X7XcmCa6g==
X-Received: by 2002:a63:fe0a:: with SMTP id p10mr13101503pgh.86.1553415719296;
        Sun, 24 Mar 2019 01:21:59 -0700 (PDT)
Received: from ash ([171.226.148.85])
        by smtp.gmail.com with ESMTPSA id h19sm12967213pfd.130.2019.03.24.01.21.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 24 Mar 2019 01:21:58 -0700 (PDT)
Received: by ash (sSMTP sendmail emulation); Sun, 24 Mar 2019 15:21:54 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     pclouds@gmail.com
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>
Subject: [PATCH v2 09/20] diff-parseopt: convert --diff-filter
Date:   Sun, 24 Mar 2019 15:20:03 +0700
Message-Id: <20190324082014.2041-10-pclouds@gmail.com>
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

While at it, mark one more string for translation

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 diff.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/diff.c b/diff.c
index 99871d2546..47146c33f5 100644
--- a/diff.c
+++ b/diff.c
@@ -4736,10 +4736,13 @@ static unsigned filter_bit_tst(char status, const struct diff_options *opt)
 	return opt->filter & filter_bit[(int) status];
 }
 
-static int parse_diff_filter_opt(const char *optarg, struct diff_options *opt)
+static int diff_opt_diff_filter(const struct option *option,
+				const char *optarg, int unset)
 {
+	struct diff_options *opt = option->value;
 	int i, optch;
 
+	BUG_ON_OPT_NEG(unset);
 	prepare_filter_bits();
 
 	/*
@@ -4770,7 +4773,8 @@ static int parse_diff_filter_opt(const char *optarg, struct diff_options *opt)
 
 		bit = (0 <= optch && optch <= 'Z') ? filter_bit[optch] : 0;
 		if (!bit)
-			return optarg[i];
+			return error(_("unknown change class '%c' in --diff-filter=%s"),
+				     optarg[i], optarg);
 		if (negate)
 			opt->filter &= ~bit;
 		else
@@ -5389,6 +5393,9 @@ static void prep_parse_options(struct diff_options *options)
 		OPT_CALLBACK_F(0, "find-object", options, N_("<object-id>"),
 			       N_("look for differences that change the number of occurrences of the specified object"),
 			       PARSE_OPT_NONEG, diff_opt_find_object),
+		OPT_CALLBACK_F(0, "diff-filter", options, N_("[(A|C|D|M|R|T|U|X|B)...[*]]"),
+			       N_("select files by diff type"),
+			       PARSE_OPT_NONEG, diff_opt_diff_filter),
 		{ OPTION_CALLBACK, 0, "output", options, N_("<file>"),
 		  N_("Output to a specific file"),
 		  PARSE_OPT_NONEG, NULL, 0, diff_opt_output },
@@ -5441,13 +5448,6 @@ int diff_opt_parse(struct diff_options *options,
 	}
 
 	/* misc options */
-	else if ((argcount = parse_long_opt("diff-filter", av, &optarg))) {
-		int offending = parse_diff_filter_opt(optarg, options);
-		if (offending)
-			die("unknown change class '%c' in --diff-filter=%s",
-			    offending, optarg);
-		return argcount;
-	}
 	else if (!strcmp(arg, "--no-abbrev"))
 		options->abbrev = 0;
 	else if (!strcmp(arg, "--abbrev"))
-- 
2.21.0.548.gd3c7d92dc2

