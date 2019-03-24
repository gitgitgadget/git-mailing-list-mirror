Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A6B1020248
	for <e@80x24.org>; Sun, 24 Mar 2019 08:21:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728531AbfCXIVo (ORCPT <rfc822;e@80x24.org>);
        Sun, 24 Mar 2019 04:21:44 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:35046 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727727AbfCXIVo (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 24 Mar 2019 04:21:44 -0400
Received: by mail-pg1-f196.google.com with SMTP id g8so4363974pgf.2
        for <git@vger.kernel.org>; Sun, 24 Mar 2019 01:21:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=iPqpPFaXEZAtaXXl1NlV+brp1RzRiSk31O39auBSgXo=;
        b=cVJl7LMex8qtZmJ6uEOU1IGJKknVlf1aLWOtrj3G8MSw3uIBgSFjz9Vlh+RRooN/Oj
         7CAk/c4UHZjWK3B9Vj8wb55azneXIeVb4nIbFzAmCaFSBFW4DmhnlKvdYonC2DJ8T0BP
         rmmpowOzBG3xcg1LWEMNSX5cctGtQpZM8QwRwmjBIIZmscjdNEPVfo98rlBQElm929W2
         zOuKTvENt2mvCq5fpAEWtpnucONoK23Yd0vHXgOfNNk+zCOZsvg9JvKzNKzdF2JFCj1r
         so5ZEkr+gCkPSqZ1uiGgmxzI3ahRf1L4daAqoZP+h/uienHZ95XXbaP6c7AWXUiyKxni
         HvuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=iPqpPFaXEZAtaXXl1NlV+brp1RzRiSk31O39auBSgXo=;
        b=XeHUt3JLc7eGH+dS+cURD1Gree2FYA03a4YNxtMon98YBGkQ5GLJh/3H/TEaxhwBP4
         4O3hABvDuQnxB8HvTNtGPWg8PHyRJE99iAIaUoOo5QGwbwFtvrqUWSPeT84nvh2UOcVR
         S2BZE1WpPBYR+E0Pfu1WB9dn3Wf3vtklrxBQ+ijDK66Mlr/jGAx+2BTUCghUNUpuRcb/
         R27BYdTuA2uehxH3YJQT/tB7zYogOhmf9hNz+/fgdaX3ijaP2dbGz5uU0I0BIntG7SSA
         W+roWR7DivwPp423n/ncVpjjrcwLE+luWUt7HgPP8dUwe5jVZwQd5HXbejtSC8PvH3by
         X81g==
X-Gm-Message-State: APjAAAUbfvnJRH1xzfcTRs+Bs/TC0SEl1acKrq7cLEaqZIPZxIeSJF+E
        5RXvvo08DuLEOGVAc6SdNuX5S7Nd
X-Google-Smtp-Source: APXvYqx6HqoIZrFuOZHnqFYezPk4eLOpO8Jp8HFXzgXzC7DwFeTfxneoUjZiroHCOd72KHMyUhXU4w==
X-Received: by 2002:a17:902:4101:: with SMTP id e1mr19330713pld.25.1553415703715;
        Sun, 24 Mar 2019 01:21:43 -0700 (PDT)
Received: from ash ([171.226.148.85])
        by smtp.gmail.com with ESMTPSA id i79sm25621398pfj.28.2019.03.24.01.21.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 24 Mar 2019 01:21:42 -0700 (PDT)
Received: by ash (sSMTP sendmail emulation); Sun, 24 Mar 2019 15:21:38 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     pclouds@gmail.com
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>
Subject: [PATCH v2 06/20] diff-parseopt: convert --pickaxe-all|--pickaxe-regex
Date:   Sun, 24 Mar 2019 15:20:00 +0700
Message-Id: <20190324082014.2041-7-pclouds@gmail.com>
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
 diff.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/diff.c b/diff.c
index 8f01fbc2c1..699f8605d0 100644
--- a/diff.c
+++ b/diff.c
@@ -5391,6 +5391,12 @@ static void prep_parse_options(struct diff_options *options)
 		OPT_CALLBACK_F('G', NULL, options, N_("<regex>"),
 			       N_("look for differences that change the number of occurrences of the specified regex"),
 			       0, diff_opt_pickaxe_regex),
+		OPT_BIT_F(0, "pickaxe-all", &options->pickaxe_opts,
+			  N_("show all changes in the changeset with -S or -G"),
+			  DIFF_PICKAXE_ALL, PARSE_OPT_NONEG),
+		OPT_BIT_F(0, "pickaxe-regex", &options->pickaxe_opts,
+			  N_("treat <string> in -S as extended POSIX regular expression"),
+			  DIFF_PICKAXE_REGEX, PARSE_OPT_NONEG),
 		{ OPTION_CALLBACK, 0, "output", options, N_("<file>"),
 		  N_("Output to a specific file"),
 		  PARSE_OPT_NONEG, NULL, 0, diff_opt_output },
@@ -5443,10 +5449,6 @@ int diff_opt_parse(struct diff_options *options,
 	}
 
 	/* misc options */
-	else if (!strcmp(arg, "--pickaxe-all"))
-		options->pickaxe_opts |= DIFF_PICKAXE_ALL;
-	else if (!strcmp(arg, "--pickaxe-regex"))
-		options->pickaxe_opts |= DIFF_PICKAXE_REGEX;
 	else if ((argcount = short_opt('O', av, &optarg))) {
 		options->orderfile = prefix_filename(prefix, optarg);
 		return argcount;
-- 
2.21.0.548.gd3c7d92dc2

