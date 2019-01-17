Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9D4081F453
	for <e@80x24.org>; Thu, 17 Jan 2019 13:08:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727760AbfAQNIJ (ORCPT <rfc822;e@80x24.org>);
        Thu, 17 Jan 2019 08:08:09 -0500
Received: from mail-pf1-f174.google.com ([209.85.210.174]:46588 "EHLO
        mail-pf1-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725887AbfAQNIJ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 Jan 2019 08:08:09 -0500
Received: by mail-pf1-f174.google.com with SMTP id c73so4795188pfe.13
        for <git@vger.kernel.org>; Thu, 17 Jan 2019 05:08:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=f2TOiIHPTsyND5viKB4k1dBMT673LCfCz/qVLmukGNQ=;
        b=E1cB84bVwI0hvUx8+nqoyl9jGMau3VX6mAUsMSSbxe3DSgPkyIu3AFcTgiHKpIMim1
         wd4igJcg+WXr/b0lmIS2pAYeEImH7QOynzcLIFs5ExaHmqy6Odq89Qc9nYEjIE9ZDx/x
         V+g3rc5YMKxJOMB0W94WfMXa2pH7/tN4DHvjNVExPeRFSuXmZ7a/8KObAyK2rC+cQaDS
         4jALgL4eD9yyXMPvs4gQV2aaVYgshibpns+Cz+CYTbX4JqZF4cGgmxChBZSsH0zMAFaa
         2auNfj3wPhXDMWX7iYQ4KJcS+1SG6RT7ncOM3NNdBiFrt500Yd6wx+MFspRKlBPYneMU
         q72g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=f2TOiIHPTsyND5viKB4k1dBMT673LCfCz/qVLmukGNQ=;
        b=kaHoPVpST+qmM+/Gg9RMCwjxAxpANxkIJ1v2fZuqn8n0YVNc9PUbwnSkFF/57Arq89
         OMbF/Yd7Pu2YU+mrN7wDxQ1Q+y0gJ7pCMfMMkFou0Jc5alsetrz31l9r0zPQTpE62irV
         JxE8t0G23DgwZlWCXHrAOXLONPQE81nJXkgWgyw0ObSH5uclo/CKROplgarMIeSb/k3w
         8i2S5ZWd1762JNxlvz5Bp/u845UVufQywRs4vbJ0tpjmyKjCiOx82NmY4+cMJIKPbinT
         YjsgcCOZSl5J8J65SLGIhXx/4FCe2s2ZiZqV4K/gFdLtUpvnPh/b/MLGdWEhHzRokWbW
         1rOw==
X-Gm-Message-State: AJcUukd0G5rCmG5QlmXnBUMGQHUitizYDC6JJ+a9VMExfZqIuq+YXguc
        m0trLkEhE46XE6Ldb4lMWyJQK0ga
X-Google-Smtp-Source: ALg8bN6j/LpZzuU4PLoR3Q5D3ieo+lnJsL4YuqZZE1Hw3Ma9SgkAJmUlKcpTpjEvudNFxsTO5lArqQ==
X-Received: by 2002:a63:1904:: with SMTP id z4mr6674825pgl.135.1547730488681;
        Thu, 17 Jan 2019 05:08:08 -0800 (PST)
Received: from ash ([115.72.21.220])
        by smtp.gmail.com with ESMTPSA id z191sm1878571pgd.74.2019.01.17.05.08.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 17 Jan 2019 05:08:08 -0800 (PST)
Received: by ash (sSMTP sendmail emulation); Thu, 17 Jan 2019 20:08:04 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 19/76] diff.c: convert --check
Date:   Thu, 17 Jan 2019 20:05:18 +0700
Message-Id: <20190117130615.18732-20-pclouds@gmail.com>
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
 diff.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/diff.c b/diff.c
index 1cb410ed3a..07b495b686 100644
--- a/diff.c
+++ b/diff.c
@@ -4937,6 +4937,9 @@ static void prep_parse_options(struct diff_options *options)
 			       N_("synonym for --dirstat=files,param1,param2..."),
 			       PARSE_OPT_NONEG | PARSE_OPT_OPTARG,
 			       diff_opt_dirstat),
+		OPT_BIT_F(0, "check", &options->output_format,
+			  N_("warn if changes introduce conflict markers or whitespace errors"),
+			  DIFF_FORMAT_CHECKDIFF, PARSE_OPT_NONEG),
 		OPT_END()
 	};
 
@@ -4965,9 +4968,7 @@ int diff_opt_parse(struct diff_options *options,
 		return ac;
 
 	/* Output format options */
-	if (!strcmp(arg, "--check"))
-		options->output_format |= DIFF_FORMAT_CHECKDIFF;
-	else if (!strcmp(arg, "--summary"))
+	if (!strcmp(arg, "--summary"))
 		options->output_format |= DIFF_FORMAT_SUMMARY;
 	else if (!strcmp(arg, "--patch-with-stat")) {
 		enable_patch_output(&options->output_format);
-- 
2.20.0.482.g66447595a7

