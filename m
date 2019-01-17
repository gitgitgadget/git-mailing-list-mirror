Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2BA471F453
	for <e@80x24.org>; Thu, 17 Jan 2019 13:10:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725997AbfAQNKz (ORCPT <rfc822;e@80x24.org>);
        Thu, 17 Jan 2019 08:10:55 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:40700 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725887AbfAQNKy (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 Jan 2019 08:10:54 -0500
Received: by mail-pl1-f194.google.com with SMTP id u18so4733829plq.7
        for <git@vger.kernel.org>; Thu, 17 Jan 2019 05:10:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=MeKap7p9J23a1SRSu8Plh5aGkBCOKFB/2xYgPcVhY/4=;
        b=jKCn8U+ABya2topq2NBAxv3Fv/0QjR9XJ6q1fVhMK/50a1oA2JJezv6tesGMr/2M8B
         FzYqUFIZOKuIP0ZHwyDg3x1j64Nv2AG0nHJ4E9SL6tVHyHBh1fUPcwvP945Phmv78BKE
         kxdFO6ZfNx2/TEi/TXtwR1rB2Z8tW2PfmVegChlKKIgEn8INsHuG7/l179ZhZVyIRTk0
         W8ScNXFssgPEjbwCWOwkMx3BMCp5lgP8hXrrTfeafIbNzbROgPfjR7LIYckutAEaLHXC
         TfvnRxQOMhMFXT5WyC/O2o/w5Ae0V3DMjitZFd+Pww8R/bceDM/NX3DUcbcoShEYkWae
         76hA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=MeKap7p9J23a1SRSu8Plh5aGkBCOKFB/2xYgPcVhY/4=;
        b=T06d7RDCGvK9DluJVrSColQDu5s9UWumIVxjzY+kmsbt9NtVIiSZUicP02VInKbdHU
         1oaUXt0z3ULY51l1J41tsqeIm1fe64/Jos0QJkfzroGl2yhg0dLjzxeWaKnO4a3qG6WQ
         6rEePhAr3WV4DzLjuoF8bZiElQLZYpA7rkZxSDPctIHOFga6uUA3wi8EpL52UW9zWzRR
         zB3lmfxd7aR0skGQgrZi/TPgzDH1TWpAbnhWVEMu4S1pEf5X2XiL9NeZL1ACsTnWCCic
         s7aHKqqRWrmgo34XuKRX/wPXYi4/2xuzTc+tSEoRu07kspTxJVfctZcipJQNMaVpRU6Y
         CfOw==
X-Gm-Message-State: AJcUukfPBHAQ5O++0dU8Ar2fIovByLuODP2ZZhKdoBGi3cHItC7+piLs
        w43O0Klp4ZEFTcADk3ESu4/I0bGq
X-Google-Smtp-Source: ALg8bN5Fx/e3LeJUOjTxQez2oq49i16bOCdxYKB6GANhgR+41ghBV98527ThEdmO8upvZbaKtOKv9w==
X-Received: by 2002:a17:902:8306:: with SMTP id bd6mr14956689plb.217.1547730654075;
        Thu, 17 Jan 2019 05:10:54 -0800 (PST)
Received: from ash ([115.72.21.220])
        by smtp.gmail.com with ESMTPSA id j21sm3283837pfn.175.2019.01.17.05.10.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 17 Jan 2019 05:10:53 -0800 (PST)
Received: by ash (sSMTP sendmail emulation); Thu, 17 Jan 2019 20:10:49 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 53/76] diff.c: convert --ext-diff
Date:   Thu, 17 Jan 2019 20:05:52 +0700
Message-Id: <20190117130615.18732-54-pclouds@gmail.com>
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
 diff.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/diff.c b/diff.c
index eb81a95e89..78b5d93fa5 100644
--- a/diff.c
+++ b/diff.c
@@ -5305,6 +5305,8 @@ static void prep_parse_options(struct diff_options *options)
 			 N_("exit with 1 if there were differences, 0 otherwise")),
 		OPT_BOOL(0, "quiet", &options->flags.quick,
 			 N_("disable all output of the program")),
+		OPT_BOOL(0, "ext-diff", &options->flags.allow_external,
+			 N_("allow an external diff helper to be executed")),
 		{ OPTION_CALLBACK, 0, "output", options, N_("<file>"),
 		  N_("Output to a specific file"),
 		  PARSE_OPT_NONEG, NULL, 0, diff_opt_output },
@@ -5354,11 +5356,7 @@ int diff_opt_parse(struct diff_options *options,
 		if (cm & COLOR_MOVED_WS_ERROR)
 			return -1;
 		options->color_moved_ws_handling = cm;
-	} else if (!strcmp(arg, "--ext-diff"))
-		options->flags.allow_external = 1;
-	else if (!strcmp(arg, "--no-ext-diff"))
-		options->flags.allow_external = 0;
-	else if (!strcmp(arg, "--textconv")) {
+	} else if (!strcmp(arg, "--textconv")) {
 		options->flags.allow_textconv = 1;
 		options->flags.textconv_set_via_cmdline = 1;
 	} else if (!strcmp(arg, "--no-textconv"))
-- 
2.20.0.482.g66447595a7

