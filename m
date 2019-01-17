Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3BE501F453
	for <e@80x24.org>; Thu, 17 Jan 2019 13:11:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728215AbfAQNLY (ORCPT <rfc822;e@80x24.org>);
        Thu, 17 Jan 2019 08:11:24 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:35441 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725887AbfAQNLY (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 Jan 2019 08:11:24 -0500
Received: by mail-pl1-f196.google.com with SMTP id p8so4749147plo.2
        for <git@vger.kernel.org>; Thu, 17 Jan 2019 05:11:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=AIdlGKWwQDajvZkJSHUnv515Kg2HAkxTmpPjKvDvClA=;
        b=IZAM83EBMtr411os6gKSAnbTs1k2wCEC+CHOoIsleazozifdu1mLtRzbk3VpcS5n25
         W8/KgQP1RkbTInX+V2lOmLC1BtXlSqEv+YHUq6AlSEHtiJSER7geohPmyxKtFVtHU5SP
         6ImDcoyO+RiVA77TR0Ye8teZ+R5NgSH2cA3Gz7dEdzbsCGgUeUV64gpEbkS0WQUizebW
         l37+sSY96XglfYYenRg/AVEtg37w2r2BM5aVedwG3UleNyMICcFB8017/e8LaqczcjcA
         677YtnmGs6kG24zV1R0uh7gFtwXnGe3KD/8SwG6ZXAFOFd7ElMXPIxMaD2qbCAecaD4q
         Vr0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=AIdlGKWwQDajvZkJSHUnv515Kg2HAkxTmpPjKvDvClA=;
        b=QCgJgmn9Cl08TmIXIrZUVslSD+6/xqnRNNzi/zsIUOyCkZkRPiwTEbTX0/pUy9p7Dv
         pdKtD5Adtlk/JffCcwctCSsBif+03hyfX1dqfbK+1FtPaGnO8GVl7oIUhbNWiX2vYolt
         9lerE9p/OQco7RBRUA50IqInAbgISkqVWbLe/T7muER5UR/RLIn9eAuThOqV2n+6wQ0s
         mIr88WyWoIq9phk1AiPvZ0IDOtoD2F2ct37L9NRR9UqcIwlkMu7VEX+Ds4OgnA7bj8Ft
         qWcGC/R3ZqZka12IhDtn3BQRRhjKMTEQr7Ndg1IBuaGB534ERrud3j8QOzz/zSfbnPBs
         rylg==
X-Gm-Message-State: AJcUuke9Eunv09XfemT9HcYWZtodv2YxbEp/xQR4Rj3VtqL2Bui/0AQW
        tuEVSjdHOAkCrzpbUtDFThILbOEH
X-Google-Smtp-Source: ALg8bN64QZCoJ524DS9pnLdlwuNeiQI5Duy2lsd0FAEqHBckGUzis1ttymt9/rh2JLAJ0HgVdTVBiA==
X-Received: by 2002:a17:902:c5:: with SMTP id a63mr15131282pla.267.1547730683084;
        Thu, 17 Jan 2019 05:11:23 -0800 (PST)
Received: from ash ([115.72.21.220])
        by smtp.gmail.com with ESMTPSA id s130sm2139255pgc.60.2019.01.17.05.11.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 17 Jan 2019 05:11:22 -0800 (PST)
Received: by ash (sSMTP sendmail emulation); Thu, 17 Jan 2019 20:11:18 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 59/76] diff.c: convert -z
Date:   Thu, 17 Jan 2019 20:05:58 +0700
Message-Id: <20190117130615.18732-60-pclouds@gmail.com>
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
 diff.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/diff.c b/diff.c
index 0922937bab..e4495194d3 100644
--- a/diff.c
+++ b/diff.c
@@ -5242,6 +5242,9 @@ static void prep_parse_options(struct diff_options *options)
 		OPT_CALLBACK_F(0, "ws-error-highlight", options, N_("<kind>"),
 			       N_("highlight whitespaces errors in the context, old or new lines in the diff"),
 			       PARSE_OPT_NONEG, diff_opt_ws_error_highlight),
+		OPT_SET_INT('z', NULL, &options->line_termination,
+			    N_("do not munge pathnames and use NULs as output field terminators in --raw or --numstat"),
+			    0),
 		OPT_CALLBACK_F(0, "output-indicator-new",
 			       &options->output_indicators[OUTPUT_INDICATOR_NEW],
 			       N_("<char>"),
@@ -5414,8 +5417,6 @@ int diff_opt_parse(struct diff_options *options,
 	}
 
 	/* misc options */
-	else if (!strcmp(arg, "-z"))
-		options->line_termination = 0;
 	else if ((argcount = short_opt('l', av, &optarg))) {
 		options->rename_limit = strtoul(optarg, NULL, 10);
 		return argcount;
-- 
2.20.0.482.g66447595a7

