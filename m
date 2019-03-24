Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A80AD20248
	for <e@80x24.org>; Sun, 24 Mar 2019 08:21:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728511AbfCXIVj (ORCPT <rfc822;e@80x24.org>);
        Sun, 24 Mar 2019 04:21:39 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:33455 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727727AbfCXIVj (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 24 Mar 2019 04:21:39 -0400
Received: by mail-pf1-f193.google.com with SMTP id i19so4314197pfd.0
        for <git@vger.kernel.org>; Sun, 24 Mar 2019 01:21:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/3OALaxX2xlmtRASBKEgcfP/yL0aPFxCvsxPlcT2m7Y=;
        b=oGAGvUSAs4lYf/SujZ2xWH03AlJmvtC0u534WEuyAGK4Y5p499cyPp6i05jabY/e49
         SMZCZKXbzOxsYHdxoO7oKcJ94hzO43KtHODWlsYT7x2MJNQpbGxso4tN3GbYdEOGzjHj
         X70HCrMrMUwPJd7UznPI0BC4M3Q3QSdJxGZ5SiYiUVPTus6sDazs5XnJh59908nPNMJx
         SpPTMZT60PFxWJHJq7hQb/Yf97ZxSGAxUaxwzvw7RJdD+orIvyVPRchwxezvOpKFwGmH
         iUNrVs0YgBUOtP8cTOwEF9BjQV+SDN+eONst9mLbMqIUmBwOKONBm/e5QJ0Mxh2Ulm3b
         K9Hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/3OALaxX2xlmtRASBKEgcfP/yL0aPFxCvsxPlcT2m7Y=;
        b=B0O6rJ4a59I2gdDEDTePvLIj5V8oryZK4ET4Gxc1PoO6qY4WsYnUSKUo4Tb0NNBUfA
         PVQ3naaMJRNfYbLqtJP4qNRuGxsxMLjLltUPtA9EB6ORnztNsY/ewJiySBitVlOtEI9D
         ya9bSFyW0YKutetLXEJtDYlQH112IPcYT6yoa1HygBjInT8Lp3XCQ6P5XPjfqqdEcj2a
         YXRr3qKcy/cJhkF5OmQkqtrCZr/WsQBmE+rDYe1OQZFksG1weS5vjPJt2egi1z4NhZax
         5LmgqlDuppopqIAReppigTmferUu8QWK6iushlOtax8epSEWt9vlN67wjT17K2LDR8Up
         wAlw==
X-Gm-Message-State: APjAAAV4nZ/JBfJRl49rmG6gQp2wgzW7F4f+cUwjYXta8kLI3mHWkcVz
        7hLDeysGjUSqYwGFHb+my2o=
X-Google-Smtp-Source: APXvYqyCWzwFwUBv8wdLT5yG8GZB6evpl/drlZlrLPUm4+cj2fB3QJozRcbxrh8z5t6wQCVHQAXhuw==
X-Received: by 2002:a62:1d8c:: with SMTP id d134mr18080232pfd.185.1553415698487;
        Sun, 24 Mar 2019 01:21:38 -0700 (PDT)
Received: from ash ([171.226.148.85])
        by smtp.gmail.com with ESMTPSA id p3sm21083710pfp.136.2019.03.24.01.21.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 24 Mar 2019 01:21:37 -0700 (PDT)
Received: by ash (sSMTP sendmail emulation); Sun, 24 Mar 2019 15:21:33 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     pclouds@gmail.com
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>
Subject: [PATCH v2 05/20] diff-parseopt: convert -S|-G
Date:   Sun, 24 Mar 2019 15:19:59 +0700
Message-Id: <20190324082014.2041-6-pclouds@gmail.com>
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
 diff.c | 37 ++++++++++++++++++++++++++++---------
 1 file changed, 28 insertions(+), 9 deletions(-)

diff --git a/diff.c b/diff.c
index 6b19c97499..8f01fbc2c1 100644
--- a/diff.c
+++ b/diff.c
@@ -5056,6 +5056,28 @@ static int diff_opt_patience(const struct option *opt,
 	return 0;
 }
 
+static int diff_opt_pickaxe_regex(const struct option *opt,
+				  const char *arg, int unset)
+{
+	struct diff_options *options = opt->value;
+
+	BUG_ON_OPT_NEG(unset);
+	options->pickaxe = arg;
+	options->pickaxe_opts |= DIFF_PICKAXE_KIND_G;
+	return 0;
+}
+
+static int diff_opt_pickaxe_string(const struct option *opt,
+				   const char *arg, int unset)
+{
+	struct diff_options *options = opt->value;
+
+	BUG_ON_OPT_NEG(unset);
+	options->pickaxe = arg;
+	options->pickaxe_opts |= DIFF_PICKAXE_KIND_S;
+	return 0;
+}
+
 static int diff_opt_relative(const struct option *opt,
 			     const char *arg, int unset)
 {
@@ -5363,6 +5385,12 @@ static void prep_parse_options(struct diff_options *options)
 		OPT_SET_INT_F(0, "ita-visible-in-index", &options->ita_invisible_in_index,
 			      N_("treat 'git add -N' entries as real in the index"),
 			      0, PARSE_OPT_NONEG),
+		OPT_CALLBACK_F('S', NULL, options, N_("<string>"),
+			       N_("look for differences that change the number of occurrences of the specified string"),
+			       0, diff_opt_pickaxe_string),
+		OPT_CALLBACK_F('G', NULL, options, N_("<regex>"),
+			       N_("look for differences that change the number of occurrences of the specified regex"),
+			       0, diff_opt_pickaxe_regex),
 		{ OPTION_CALLBACK, 0, "output", options, N_("<file>"),
 		  N_("Output to a specific file"),
 		  PARSE_OPT_NONEG, NULL, 0, diff_opt_output },
@@ -5415,15 +5443,6 @@ int diff_opt_parse(struct diff_options *options,
 	}
 
 	/* misc options */
-	else if ((argcount = short_opt('S', av, &optarg))) {
-		options->pickaxe = optarg;
-		options->pickaxe_opts |= DIFF_PICKAXE_KIND_S;
-		return argcount;
-	} else if ((argcount = short_opt('G', av, &optarg))) {
-		options->pickaxe = optarg;
-		options->pickaxe_opts |= DIFF_PICKAXE_KIND_G;
-		return argcount;
-	}
 	else if (!strcmp(arg, "--pickaxe-all"))
 		options->pickaxe_opts |= DIFF_PICKAXE_ALL;
 	else if (!strcmp(arg, "--pickaxe-regex"))
-- 
2.21.0.548.gd3c7d92dc2

