Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B11471F454
	for <e@80x24.org>; Thu, 17 Jan 2019 13:11:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728229AbfAQNL2 (ORCPT <rfc822;e@80x24.org>);
        Thu, 17 Jan 2019 08:11:28 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:40753 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725887AbfAQNL2 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 Jan 2019 08:11:28 -0500
Received: by mail-pl1-f196.google.com with SMTP id u18so4734519plq.7
        for <git@vger.kernel.org>; Thu, 17 Jan 2019 05:11:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=nX1Yi7L1KYibFOwXVBJE5mZGBuxPpjN/V0angi3aYc4=;
        b=Y74NU/Z1DVE8qrDBOyiNfS4WOKvNyiwXiH6FBPHrD6yeIC29PIZcyE7kqrv+HOdzva
         iSv6HVZKYXcWIagSiNfWUUO/wBuNfQJRU3rqQni7283OxK81mTURdq1JUi34I15NBSb7
         knQCCSzBe7XFTww529JLCTFp5RX+UJQLHwJGOFEDI0Hlf/oBTGqcDdKlkgb4ooy1/Fb5
         Ewkxaxqeb1N4TZmY8wmDSQtWuS020MPRpOP8S3EJfwBscAyz+2unx5dsqCCuM7F3lGGz
         4cwWQNkt1MlkjrQzdlJfwgefZXkKRkBKep9Vmr9e1txi41jTmEMbE3FLETE87oVycWDB
         g81w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=nX1Yi7L1KYibFOwXVBJE5mZGBuxPpjN/V0angi3aYc4=;
        b=NBhFXT+f3CYjh4Y++eE+YGir29N68Tc31wtbl1h3QL3375uP9GtLaqDMKLCgev3m9E
         YLeQ9fnRTthE5C+6/oze6v/7SuC+1yfxqj+nKxZ5xmYeFPOp1bcJhB1a4oHLBrK25nEp
         eREZJUX8yfEvVRt1QyHw5/Or1d6l1O0JsQ6oX2M2eHMOoeDUcKczkQ7CDpwtyP3406jS
         K1qtEyxUrFKFehUKEDqECv6GSgwD4uA5/YrEovXVIus/fSXKpWLRnLiMY2gQtnleHkfY
         rw5qdWv4u80yS21WVSOG7Wc/B2d07C9OIfimTKLihMwVbh8boNSjkjK+69APYPsYKOq5
         HWLA==
X-Gm-Message-State: AJcUukcQZ2sCZ8gcJ6lzOPUODAzEX4Wct1QoOi7g6zY56Gla/moNsTtK
        sdHP8/MKp0UnFQoqHxhT080o2iiQ
X-Google-Smtp-Source: ALg8bN6fyOf11AIK1zouINFOBrbU+Ii3sSju06ZoO07M+8E4l7FwmbBCqYwHbrFmipdcXu82JusR9Q==
X-Received: by 2002:a17:902:b707:: with SMTP id d7mr14328616pls.29.1547730687820;
        Thu, 17 Jan 2019 05:11:27 -0800 (PST)
Received: from ash ([115.72.21.220])
        by smtp.gmail.com with ESMTPSA id r4sm4811119pgn.54.2019.01.17.05.11.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 17 Jan 2019 05:11:27 -0800 (PST)
Received: by ash (sSMTP sendmail emulation); Thu, 17 Jan 2019 20:11:23 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 60/76] diff.c: convert -l
Date:   Thu, 17 Jan 2019 20:05:59 +0700
Message-Id: <20190117130615.18732-61-pclouds@gmail.com>
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
 diff.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/diff.c b/diff.c
index e4495194d3..00a56a25e0 100644
--- a/diff.c
+++ b/diff.c
@@ -5287,6 +5287,8 @@ static void prep_parse_options(struct diff_options *options)
 		OPT_CALLBACK_F(0, "follow", options, NULL,
 			       N_("continue listing the history of a file beyond renames"),
 			       PARSE_OPT_NOARG, diff_opt_follow),
+		OPT_INTEGER('l', NULL, &options->rename_limit,
+			    N_("prevent rename/copy detection if the number of rename/copy targets exceeds given limit")),
 
 		OPT_GROUP(N_("Diff algorithm options")),
 		OPT_BIT(0, "minimal", &options->xdl_opts,
@@ -5417,10 +5419,6 @@ int diff_opt_parse(struct diff_options *options,
 	}
 
 	/* misc options */
-	else if ((argcount = short_opt('l', av, &optarg))) {
-		options->rename_limit = strtoul(optarg, NULL, 10);
-		return argcount;
-	}
 	else if ((argcount = short_opt('S', av, &optarg))) {
 		options->pickaxe = optarg;
 		options->pickaxe_opts |= DIFF_PICKAXE_KIND_S;
-- 
2.20.0.482.g66447595a7

