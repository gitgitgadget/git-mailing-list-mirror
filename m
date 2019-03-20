Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6A05520248
	for <e@80x24.org>; Wed, 20 Mar 2019 11:47:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728039AbfCTLri (ORCPT <rfc822;e@80x24.org>);
        Wed, 20 Mar 2019 07:47:38 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:40936 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727673AbfCTLrh (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 20 Mar 2019 07:47:37 -0400
Received: by mail-pg1-f193.google.com with SMTP id u9so1624199pgo.7
        for <git@vger.kernel.org>; Wed, 20 Mar 2019 04:47:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=CsU0Amsn1GvYiiTtnCKDAoW2nSbPXGeHv/fXRKd5d4I=;
        b=R6uHzzGqOcehdVdcy3EQxbWWTAKm3YfLmNRZId8eGHpWoIWbD/xDzNyN/Bht2zh6jA
         pqXTszegfMtH/DHnFZZhmY/BqcxWrJqG+7/2zKSyJ6X6gKSyhJzbNCcD4dgGfGpuhjW0
         IncvgTF6bI14Ry0xFSR//7ONZNNUbL2bNwSXzTNwqDKAFdifBJw0EZZfDfN58KMT3rZk
         HRltVb8SdyWrIFG2wblFKiWDfkNWxDnJs0qmx+8Ym298VRIWp1RxMZf7ri+IV5RVpqU+
         a4jex6ouYKA/Pf/ueL3CBMIw6k3aivV8Wd6wZ10rRR/UVlxCBGV+qG3Vi0/+eQ3LadfM
         njDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=CsU0Amsn1GvYiiTtnCKDAoW2nSbPXGeHv/fXRKd5d4I=;
        b=g0OQOFKpw0vSpYotl/WwcCPncotbIY0G9XXCsno7i/+dhgdtt+WtBrtMNcvwk7xCLd
         Eh9KFjLFe3g1dlK/wG5+1ygdLz1N20xkSgt+B/O3ENc+FZ2kkEiiqlPyJmust2n42qbr
         w7yiMPu3lxApF6mEMAvpj8ITc7ez7hP+ENAmaDhU+X0Xgk10e5m8maaqJ2fdr3w8HF3t
         9PRSsaSQf4+HUk5cikhwdt55ykrky0o79iVPhpvAoTi6LS0EwXgjrtGs8RAMjWVJfNU4
         rW9XsW/hNmZ1ITu1Pi+FXErM+2yUQbk+s4ksyPubFLj5j2Wo1P/W2GJLuxgQacgnSeiv
         cArw==
X-Gm-Message-State: APjAAAXzJ7G5CavAmo8yAJSMDDJwSuLvUbiB3nnD55h7j4iUdOmcK4xt
        l52+Hv/cjdEXgWG4QIecJ3lRI/MB
X-Google-Smtp-Source: APXvYqwqPrVVfGjWk7cKYlFV7ZBmiYcwgCUSZm4DvY4ryo0HSyMdMs5P21og3IAZFtd49SCh9GT40Q==
X-Received: by 2002:a17:902:e912:: with SMTP id cs18mr2718173plb.130.1553082456957;
        Wed, 20 Mar 2019 04:47:36 -0700 (PDT)
Received: from ash ([171.226.148.85])
        by smtp.gmail.com with ESMTPSA id r3sm4927369pgb.82.2019.03.20.04.47.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 20 Mar 2019 04:47:36 -0700 (PDT)
Received: by ash (sSMTP sendmail emulation); Wed, 20 Mar 2019 18:47:32 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 05/20] diff-parseopt: convert -S|-G
Date:   Wed, 20 Mar 2019 18:46:48 +0700
Message-Id: <20190320114703.18659-6-pclouds@gmail.com>
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
 diff.c | 37 ++++++++++++++++++++++++++++---------
 1 file changed, 28 insertions(+), 9 deletions(-)

diff --git a/diff.c b/diff.c
index a2abc7e5b0..e198129353 100644
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

