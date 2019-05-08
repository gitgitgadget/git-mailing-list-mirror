Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5CCEB1F45F
	for <e@80x24.org>; Wed,  8 May 2019 11:14:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727457AbfEHLOa (ORCPT <rfc822;e@80x24.org>);
        Wed, 8 May 2019 07:14:30 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:34951 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726254AbfEHLO3 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 May 2019 07:14:29 -0400
Received: by mail-pf1-f193.google.com with SMTP id t87so9758525pfa.2
        for <git@vger.kernel.org>; Wed, 08 May 2019 04:14:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=MhX8QRf4IZ221NRb8RVo0hUIZHfVfrOOAaKEd5BTWCo=;
        b=KHaROa2VFeXkUqQpvyX2t8Pkm2v+7esFQifmJeLehsToPMSG1xS2AJr48vhs6vDPDb
         orP0pEmcOrxvn3E4oSWKkv2AHgJRewN+ri1fMP055ZfIMEMgagAjU3/3pctbRlzwsQ8+
         eD51B3xeQCds/iQkRF+SdHuOQNQaxJ2+6fNZybXCMdjU7vyoFxWIyiuNQUWqUpsOJkpy
         EcbyZM3cWzH04aEFl/cIGOmaFyY1zKRU4OE7V9JhTEd6VVPeUlLGXmd7w0INpkkloKK6
         DJ96yHqu+XEpF1hOTFrrotyUR6AueAYVG5KtdEMVbIRKFDTx2pQDcXp8tIZ3xcH01Bh7
         3Vuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=MhX8QRf4IZ221NRb8RVo0hUIZHfVfrOOAaKEd5BTWCo=;
        b=qhSAHcyfv1+YYWqTlSm381enJ2/Ms1d6j3sTsw68FESfU7/f6chwIXrqX2PZUV8KTl
         zPpoHvVp/7s7gCnTWjwDqA8+1Fp9qJijqZbuTgy0LdnLZEV3TEU1DPBbM2HeW7fK+Alb
         qhx7XrmOp8TreVDL4Aw9lEaDCQOqLeSVRyff1wt0QPYNjaL/mtXS5X+vmK4liEIcdj2E
         17TWxWp9cLWG7Ucq+cLEPIxr57+8af6dbHMt68fHu+85WU+WIDziVTD++ZmvQY5bo5tn
         HNau/Sae1XMAon/J79gG7FeumGiRRrwOXw2HPaQzOXzqWJupZM7SDdS1+g6Dc2xBmGON
         zGUQ==
X-Gm-Message-State: APjAAAUc7hPmmSlgZCc1urilNEsVUonXEnfOImXhkFkDqhbFcU0ljOW3
        LTWxnYfgYyZh3rTqZjQ0mwQDDsEm
X-Google-Smtp-Source: APXvYqyKu/23MFEmbyj6E77v4Q9bv3dGcsODEvAcplhV6ZbvEWiCc3MAyCxnvW8suzBVgwmhhDLyyw==
X-Received: by 2002:a65:56c3:: with SMTP id w3mr27763519pgs.232.1557314068775;
        Wed, 08 May 2019 04:14:28 -0700 (PDT)
Received: from ash ([115.72.28.243])
        by smtp.gmail.com with ESMTPSA id q5sm25873443pfb.51.2019.05.08.04.14.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 08 May 2019 04:14:28 -0700 (PDT)
Received: by ash (sSMTP sendmail emulation); Wed, 08 May 2019 18:14:24 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 15/19] rev-parseopt: convert --single-worktree
Date:   Wed,  8 May 2019 18:12:45 +0700
Message-Id: <20190508111249.15262-16-pclouds@gmail.com>
X-Mailer: git-send-email 2.21.0.1141.gd54ac2cb17
In-Reply-To: <20190508111249.15262-1-pclouds@gmail.com>
References: <20190508111249.15262-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 revision.c | 15 ++++-----------
 1 file changed, 4 insertions(+), 11 deletions(-)

diff --git a/revision.c b/revision.c
index f04eb7f140..dd22ac5c39 100644
--- a/revision.c
+++ b/revision.c
@@ -2601,6 +2601,9 @@ static void make_pseudo_options(struct rev_info *revs)
 		OPT_SET_INT_F(0, "do-walk", &revs->no_walk,
 			      N_("override a previous --no-walk"),
 			      0, PARSE_OPT_NONEG),
+		OPT_BOOL_F(0, "single-worktree", &revs->single_worktree,
+			   N_("only consider refs from the current worktree"),
+			   PARSE_OPT_NONEG),
 		OPT_END()
 	};
 	ALLOC_ARRAY(revs->pseudo_options, ARRAY_SIZE(options));
@@ -2611,7 +2614,6 @@ static int handle_revision_pseudo_opt(const char *submodule,
 				struct rev_info *revs,
 				int argc, const char **argv, int *flags)
 {
-	const char *arg = argv[0];
 	struct ref_store *refs;
 
 	if (submodule) {
@@ -2636,16 +2638,7 @@ static int handle_revision_pseudo_opt(const char *submodule,
 			     PARSE_OPT_NO_INTERNAL_HELP |
 			     PARSE_OPT_ONE_SHOT |
 			     PARSE_OPT_STOP_AT_NON_OPTION);
-	if (argc)
-		return argc;
-
-	if (!strcmp(arg, "--single-worktree")) {
-		revs->single_worktree = 1;
-	} else {
-		return 0;
-	}
-
-	return 1;
+	return argc;
 }
 
 static void NORETURN diagnose_missing_default(const char *def)
-- 
2.21.0.1141.gd54ac2cb17

