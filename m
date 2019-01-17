Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2EB501F454
	for <e@80x24.org>; Thu, 17 Jan 2019 13:11:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728206AbfAQNLB (ORCPT <rfc822;e@80x24.org>);
        Thu, 17 Jan 2019 08:11:01 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:40705 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725887AbfAQNK7 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 Jan 2019 08:10:59 -0500
Received: by mail-pl1-f193.google.com with SMTP id u18so4733927plq.7
        for <git@vger.kernel.org>; Thu, 17 Jan 2019 05:10:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Z4jF146RKdjkNHsrGoRRyVsldy5+JC3nzTXZHkRXVuU=;
        b=Y+8J0unHFUKjyUTRgsF72uJc2+wliJloIZlMaN9vV0xp1XBeJTF/9qO8bao3cJVCEN
         MYFphIeYVq7NXk1nxMzYRxXll+NaEY2l3SBsrpN5v4cPndhheDNQFs64sTaf76ZDgmq7
         ydrRMOnj0BlbgnpDTSt0OIXN7WsmmRmLe8Md1nFxMnuiSqUcyVmmq2xBZ9SoemdBtkM0
         n7df9BwKJ/D7DtIThE2u8QTCmNtltR3KaRoNhSGrzXq7DjmLK4szyjjVxCqpGN7SL39W
         NBvhkt76n5ouP/bdxexBh71KSXHodm35G1CWY0ToLhN+ej23uTrGBkHHSALh9riBWcbT
         HWTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Z4jF146RKdjkNHsrGoRRyVsldy5+JC3nzTXZHkRXVuU=;
        b=fqvLVxg6HpfuizuboKKNwxE7zbziZ0iWJMsNHtVzJXr3faNu2XEPEioMGtBhnhnMqe
         zo1hBewOKPfefl/tKK9hHBSCewPDsT70RZtR6IDflriVyqGJQNZgNjayxZWfZB7nnQyr
         zNNnuJr2b/BX4bw2iEF+w/CKlkMKgrdzNlD1kbC097o5ADS7DnzPra6rZ4XAGRli7ErH
         vPO27iP1EDHlvpKb0X/yAFkf3y2V5585S+/1pMLEQGUnN458XHUFoZVUGc/IEFCJu45U
         iUhi3KeNA6ntTSkqp2pnqZhH61cmLrnlEcHA0oSvK9Yum0HKvAqgL1RhZooGrtwIVhJq
         JqtQ==
X-Gm-Message-State: AJcUuke8iB49tGs6BIhDxoVjl6/R/cp5ly9TUzqs3cXUmirN5GaUqwYb
        TrXah8iyLBHmKxup1DmRvVOe6n4A
X-Google-Smtp-Source: ALg8bN5j706cfEyAiXyHlhT9A3I3mVumaaAoEjF5pXIBATS5r6X6k2aj6qGpfq2Tb9pKf8KKl8SfPg==
X-Received: by 2002:a17:902:7107:: with SMTP id a7mr14904292pll.290.1547730658821;
        Thu, 17 Jan 2019 05:10:58 -0800 (PST)
Received: from ash ([115.72.21.220])
        by smtp.gmail.com with ESMTPSA id q75sm5676900pfa.38.2019.01.17.05.10.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 17 Jan 2019 05:10:58 -0800 (PST)
Received: by ash (sSMTP sendmail emulation); Thu, 17 Jan 2019 20:10:54 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 54/76] diff.c: convert --textconv
Date:   Thu, 17 Jan 2019 20:05:53 +0700
Message-Id: <20190117130615.18732-55-pclouds@gmail.com>
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
 diff.c | 25 +++++++++++++++++++------
 1 file changed, 19 insertions(+), 6 deletions(-)

diff --git a/diff.c b/diff.c
index 78b5d93fa5..611b73d06a 100644
--- a/diff.c
+++ b/diff.c
@@ -5066,6 +5066,21 @@ static int diff_opt_relative(const struct option *opt,
 	return 0;
 }
 
+static int diff_opt_textconv(const struct option *opt,
+			     const char *arg, int unset)
+{
+	struct diff_options *options = opt->value;
+
+	BUG_ON_OPT_ARG(arg);
+	if (unset) {
+		options->flags.allow_textconv = 0;
+	} else {
+		options->flags.allow_textconv = 1;
+		options->flags.textconv_set_via_cmdline = 1;
+	}
+	return 0;
+}
+
 static int diff_opt_unified(const struct option *opt,
 			    const char *arg, int unset)
 {
@@ -5307,6 +5322,9 @@ static void prep_parse_options(struct diff_options *options)
 			 N_("disable all output of the program")),
 		OPT_BOOL(0, "ext-diff", &options->flags.allow_external,
 			 N_("allow an external diff helper to be executed")),
+		OPT_CALLBACK_F(0, "textconv", options, NULL,
+			       N_("run external text conversion filters when comparing binary files"),
+			       PARSE_OPT_NOARG, diff_opt_textconv),
 		{ OPTION_CALLBACK, 0, "output", options, N_("<file>"),
 		  N_("Output to a specific file"),
 		  PARSE_OPT_NONEG, NULL, 0, diff_opt_output },
@@ -5356,12 +5374,7 @@ int diff_opt_parse(struct diff_options *options,
 		if (cm & COLOR_MOVED_WS_ERROR)
 			return -1;
 		options->color_moved_ws_handling = cm;
-	} else if (!strcmp(arg, "--textconv")) {
-		options->flags.allow_textconv = 1;
-		options->flags.textconv_set_via_cmdline = 1;
-	} else if (!strcmp(arg, "--no-textconv"))
-		options->flags.allow_textconv = 0;
-	else if (skip_to_optional_arg_default(arg, "--ignore-submodules", &arg, "all")) {
+	} else if (skip_to_optional_arg_default(arg, "--ignore-submodules", &arg, "all")) {
 		options->flags.override_submodule_config = 1;
 		handle_ignore_submodules_arg(options, arg);
 	} else if (skip_to_optional_arg_default(arg, "--submodule", &arg, "log"))
-- 
2.20.0.482.g66447595a7

