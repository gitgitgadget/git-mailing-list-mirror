Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5FFBD20248
	for <e@80x24.org>; Sun, 24 Mar 2019 08:22:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728552AbfCXIWF (ORCPT <rfc822;e@80x24.org>);
        Sun, 24 Mar 2019 04:22:05 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:33273 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727727AbfCXIWE (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 24 Mar 2019 04:22:04 -0400
Received: by mail-pg1-f194.google.com with SMTP id b12so4373434pgk.0
        for <git@vger.kernel.org>; Sun, 24 Mar 2019 01:22:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=XqAkRTK77petW2yXkLM57yAG7ibs7weIzZdYYE8xx4M=;
        b=cPprRfKsURBaUOzRYuqD/lOnavdUiCIG5wfaYbORlXKPIPrNQ/v1O+xq+NUax2LnPZ
         2V2DUzjxjiYgbq6oaopbWwDK2Bs8X9WPAdqfqwyKTWA6gwzULiVMbZbcK4vv8/dlkTIF
         b3lcZhSfRULBQlzSp71dA/UwzvRbxmTaNfg4uKryFXClRggLnXfpg9ihb9olhoB190v7
         XLW0VZQ4XrSoL+/KsuLTIBGFEcDDYPoA45eOzXd8BurxF8MHDi3KaAKAdqRqjuYN3wIg
         bGZ3DiSoevB6tf9w8+1JarIfT4gn9RM0pFmccSxqcTDGMAZ+Vbs0m6g1n07MCujg9cbz
         GsKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=XqAkRTK77petW2yXkLM57yAG7ibs7weIzZdYYE8xx4M=;
        b=aoMCA2tVZrDK/JL1XtN+nFhHDoQY6+/iZ2feOeAnAmA8mUG1t3yk1uU7FwE+CoSlJA
         9i5styvgNqqUg8UJeOJWbKC0GUGeW7WXYdO14s0NKQxtpPL3HP+qw9VJ0ktXHepJSqUa
         vS9juD1Gr6qlf0I0NBVXe2vPsqwRj06fQzMpa/TN4+7T6Hf4RuxXabSAjZsjttTfwjTn
         Hp+vXSG+NJE2F0hHdJ3Gt8D0LQW1Qo/rEylHmrPYxH46oGtQBoNKFk/W9gZiM/9X7diq
         Gr2mYl2RaP6iVoWRoCVMLReJa9qXl+GzlHvQ+W2Lj+4xiLrhCmBMty43SuDWVY9UXKiO
         ogUg==
X-Gm-Message-State: APjAAAWv5I9b40n+8DIG2r+jwQbUa+UJPc4ssxVIV5dolTnVAOiWSmPB
        xFIEOjGTIUPZwXC0rsZHBJr9YEf3
X-Google-Smtp-Source: APXvYqwyb4hWD669IQaaNRrZ2XHUu1/A5VL1wjhILgucKFeXOViIsRMVbJem2mMnRJnsVgQhH+UBqg==
X-Received: by 2002:a17:902:b418:: with SMTP id x24mr12555459plr.323.1553415724408;
        Sun, 24 Mar 2019 01:22:04 -0700 (PDT)
Received: from ash ([171.226.148.85])
        by smtp.gmail.com with ESMTPSA id z124sm31429636pfb.150.2019.03.24.01.22.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 24 Mar 2019 01:22:03 -0700 (PDT)
Received: by ash (sSMTP sendmail emulation); Sun, 24 Mar 2019 15:21:59 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     pclouds@gmail.com
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>
Subject: [PATCH v2 10/20] diff-parseopt: convert --[no-]abbrev
Date:   Sun, 24 Mar 2019 15:20:04 +0700
Message-Id: <20190324082014.2041-11-pclouds@gmail.com>
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

OPT__ABBREV() has the same behavior as the deleted code with one
difference: it does check for valid number and error out if not. And the
'40' change is self explanatory.

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 diff.c             | 12 +-----------
 parse-options-cb.c |  4 ++--
 2 files changed, 3 insertions(+), 13 deletions(-)

diff --git a/diff.c b/diff.c
index 47146c33f5..8d387280a4 100644
--- a/diff.c
+++ b/diff.c
@@ -5254,6 +5254,7 @@ static void prep_parse_options(struct diff_options *options)
 		OPT_SET_INT('z', NULL, &options->line_termination,
 			    N_("do not munge pathnames and use NULs as output field terminators in --raw or --numstat"),
 			    0),
+		OPT__ABBREV(&options->abbrev),
 		OPT_CALLBACK_F(0, "output-indicator-new",
 			       &options->output_indicators[OUTPUT_INDICATOR_NEW],
 			       N_("<char>"),
@@ -5448,17 +5449,6 @@ int diff_opt_parse(struct diff_options *options,
 	}
 
 	/* misc options */
-	else if (!strcmp(arg, "--no-abbrev"))
-		options->abbrev = 0;
-	else if (!strcmp(arg, "--abbrev"))
-		options->abbrev = DEFAULT_ABBREV;
-	else if (skip_prefix(arg, "--abbrev=", &arg)) {
-		options->abbrev = strtoul(arg, NULL, 10);
-		if (options->abbrev < MINIMUM_ABBREV)
-			options->abbrev = MINIMUM_ABBREV;
-		else if (the_hash_algo->hexsz < options->abbrev)
-			options->abbrev = the_hash_algo->hexsz;
-	}
 	else if ((argcount = parse_long_opt("src-prefix", av, &optarg))) {
 		options->a_prefix = optarg;
 		return argcount;
diff --git a/parse-options-cb.c b/parse-options-cb.c
index 2733393546..6e2e8d6273 100644
--- a/parse-options-cb.c
+++ b/parse-options-cb.c
@@ -22,8 +22,8 @@ int parse_opt_abbrev_cb(const struct option *opt, const char *arg, int unset)
 				     opt->long_name);
 		if (v && v < MINIMUM_ABBREV)
 			v = MINIMUM_ABBREV;
-		else if (v > 40)
-			v = 40;
+		else if (v > the_hash_algo->hexsz)
+			v = the_hash_algo->hexsz;
 	}
 	*(int *)(opt->value) = v;
 	return 0;
-- 
2.21.0.548.gd3c7d92dc2

