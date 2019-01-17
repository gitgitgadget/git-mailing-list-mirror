Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DDFD81F453
	for <e@80x24.org>; Thu, 17 Jan 2019 13:11:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728209AbfAQNLJ (ORCPT <rfc822;e@80x24.org>);
        Thu, 17 Jan 2019 08:11:09 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:45876 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725887AbfAQNLJ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 Jan 2019 08:11:09 -0500
Received: by mail-pg1-f194.google.com with SMTP id y4so4421600pgc.12
        for <git@vger.kernel.org>; Thu, 17 Jan 2019 05:11:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=QBT59fVr4e2u/eQnLVkCCJ6L2wM9G0NZ3cskf8F4OE8=;
        b=YCpjcWqyfCzuqzLd9hQ9sGCXucnTXDgX78FdxPexZ+BAYLofTH/0oyZC7n/G+7nqed
         aST09Eg0lNb8Evz10mj4LRQnFhoGmak1Kpx10fCP4JimDQovy2GNHl3e9VYJTayENeql
         bfMGrvFTv5aifVtFMgDnKUZ1L/WVKypiYZ6SllVE7Y+PVFQBXq68dZqLmwZMWsNEMDS9
         uhL1z2ef/wTKoTieVoTnGBBmepXd2TWht+WDme8SiZUG/4NxHHHbGElqfXy7jpOm29yF
         1brf2rRe5GHiC3tr3v3lZ27Xh8S5kP7aNPQ3wuLk6xBdPyu4/pSTlyEoZYYw1a+rah2e
         t2Pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=QBT59fVr4e2u/eQnLVkCCJ6L2wM9G0NZ3cskf8F4OE8=;
        b=sd9ekQt8YROcCaVgj7Sbof2HUiyUI0cfwPF2RXIVeOwIktE+SekkH6PcE5sYrePNaV
         3kHDhhwcg4MaUnNK3OzLLTqX8Y3QHpmJkslEgSl/eAp+4XSl++jo685NNeE6zULOLtbW
         h9tPfgBiGYbeToEK1IJEROcLkt/p7xYkQknDPLhYwdItXlXVo3/Co+Zyc0Ko0+HXWCda
         ZGzYRhnuJa9c//MCxMeRVsJ2eYM5njmzhg7w4M17qVK81WnlqbAc8RYDaMiofYpB/nG2
         kLCm7kr6+ECYN62I8VPJqi1Dmsn6yeq7oiIRrgWrO9T+lA26kloUWNOVl7jqTPseHMZD
         QaWw==
X-Gm-Message-State: AJcUukf0XuvbA+KUqAv/LP9KySTGFU21aJOIVzmn5J+kIwDm7rHJRr0C
        C6d39/yMIZNKV0HB7bSkp6LQXzil
X-Google-Smtp-Source: ALg8bN5hyC4XxrrhTR0n8H9G0RRwddetkjpYit3auLJXduHRTpnQkYAvKJlqt4a1kfphWMJmQIr2cg==
X-Received: by 2002:a63:7d06:: with SMTP id y6mr13308501pgc.171.1547730668392;
        Thu, 17 Jan 2019 05:11:08 -0800 (PST)
Received: from ash ([115.72.21.220])
        by smtp.gmail.com with ESMTPSA id h185sm2355726pfg.143.2019.01.17.05.11.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 17 Jan 2019 05:11:07 -0800 (PST)
Received: by ash (sSMTP sendmail emulation); Thu, 17 Jan 2019 20:11:03 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 56/76] diff.c: convert --submodule
Date:   Thu, 17 Jan 2019 20:05:55 +0700
Message-Id: <20190117130615.18732-57-pclouds@gmail.com>
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
 diff.c | 30 +++++++++++++++++++-----------
 1 file changed, 19 insertions(+), 11 deletions(-)

diff --git a/diff.c b/diff.c
index bf7d2afcce..4d3eababe3 100644
--- a/diff.c
+++ b/diff.c
@@ -4725,14 +4725,6 @@ static int parse_dirstat_opt(struct diff_options *options, const char *params)
 	return 1;
 }
 
-static int parse_submodule_opt(struct diff_options *options, const char *value)
-{
-	if (parse_submodule_params(options, value))
-		die(_("Failed to parse --submodule option parameter: '%s'"),
-			value);
-	return 1;
-}
-
 static const char diff_status_letters[] = {
 	DIFF_STATUS_ADDED,
 	DIFF_STATUS_COPIED,
@@ -5079,6 +5071,20 @@ static int diff_opt_relative(const struct option *opt,
 	return 0;
 }
 
+static int diff_opt_submodule(const struct option *opt,
+			      const char *arg, int unset)
+{
+	struct diff_options *options = opt->value;
+
+	BUG_ON_OPT_NEG(unset);
+	if (!arg)
+		arg = "log";
+	if (parse_submodule_params(options, arg))
+		return error(_("failed to parse --submodule option parameter: '%s'"),
+			     arg);
+	return 0;
+}
+
 static int diff_opt_textconv(const struct option *opt,
 			     const char *arg, int unset)
 {
@@ -5342,6 +5348,10 @@ static void prep_parse_options(struct diff_options *options)
 			       N_("ignore changes to submodules in the diff generation"),
 			       PARSE_OPT_NONEG | PARSE_OPT_OPTARG,
 			       diff_opt_ignore_submodules),
+		OPT_CALLBACK_F(0, "submodule", options, N_("<format>"),
+			       N_("specify how differences in submodules are shown"),
+			       PARSE_OPT_NONEG | PARSE_OPT_OPTARG,
+			       diff_opt_submodule),
 		{ OPTION_CALLBACK, 0, "output", options, N_("<file>"),
 		  N_("Output to a specific file"),
 		  PARSE_OPT_NONEG, NULL, 0, diff_opt_output },
@@ -5391,9 +5401,7 @@ int diff_opt_parse(struct diff_options *options,
 		if (cm & COLOR_MOVED_WS_ERROR)
 			return -1;
 		options->color_moved_ws_handling = cm;
-	} else if (skip_to_optional_arg_default(arg, "--submodule", &arg, "log"))
-		return parse_submodule_opt(options, arg);
-	else if (skip_prefix(arg, "--ws-error-highlight=", &arg))
+	} else if (skip_prefix(arg, "--ws-error-highlight=", &arg))
 		return parse_ws_error_highlight_opt(options, arg);
 	else if (!strcmp(arg, "--ita-invisible-in-index"))
 		options->ita_invisible_in_index = 1;
-- 
2.20.0.482.g66447595a7

