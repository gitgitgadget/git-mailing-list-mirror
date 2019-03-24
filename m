Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9229720248
	for <e@80x24.org>; Sun, 24 Mar 2019 08:21:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728496AbfCXIVX (ORCPT <rfc822;e@80x24.org>);
        Sun, 24 Mar 2019 04:21:23 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:33223 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727727AbfCXIVX (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 24 Mar 2019 04:21:23 -0400
Received: by mail-pg1-f193.google.com with SMTP id b12so4372834pgk.0
        for <git@vger.kernel.org>; Sun, 24 Mar 2019 01:21:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=fQ9tNOoo1poOm1ZLmNviPon3/Jsxu8PatTIxAKaGdoU=;
        b=cX7PuwIYROXYN+79Y0SmP/jNvB/IqofJXKRK3/SCxwb8TyiO40JUvDwqiv4aGUBaqh
         DlwtRIV2ySah6CRuxVC/0YPQoGX0qmUFIoZvZL0zP0fPuVWJyfVZNAmb9F2xuiQQ912N
         shIAdM7Bzk7Eg18KhrObFD4VSKBuISJkdSsy9jkUnvwQyGy2+R+8KieJFrT6NrIj94hX
         4S6aKFb5D4B2rWm+a3K3vuWe4TbfFQBJvQ99BjXFe2xel6E9zKZsvDFLJeP4dfMBxjtM
         FeksFkhlonC+wMmxFsExQw9tGbaTTKKnUNvqisVk2nNOc5si/V1jU0WHI8bkr64PFFJa
         7W7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=fQ9tNOoo1poOm1ZLmNviPon3/Jsxu8PatTIxAKaGdoU=;
        b=jzuUo9A9a0FUYn9IcPJHEdjMFnprYQyUCQPKjGhEbthOedk3aoSC4x2Ysqy+Wn3tXz
         vw1CXYTFempeRvPuOd7iTVZuCy10rWnvLn19JKTTFf3TA5tUxIz1q3yRb8LytWlJjAE/
         5K1hXK8zVA3/Cj/bBMqsO6FCd80ONPFeEewTQYbpPwSz0bHq8T38CrXfWcvtfNVdRbNL
         Q/G+ftGinS0ZBaUslQ9O3g/a+Eo7c5JxZ7tqIkZHhgsJ/eW2MNJcN2ccQleL4M6k03bF
         sDuCA6rxt541hmPhyyHxIFOzPA/j7L7lOWtqJO3ztVans3uGySwvj//w01cPgoM6lGhf
         afXw==
X-Gm-Message-State: APjAAAWln3CbGWIDx1OsFUI34LSjGltbxGBmBMZEsFleUmxkVvXc0Ou4
        74zCWL35NQenkSdRLhB2gmRs2mqH
X-Google-Smtp-Source: APXvYqwbz9OB/Q5Dx/HkPlCH8fZ+Av4BW+/ec7TieMw3osTYq/gYyJunvoFOinPbO7MW/2pcRjGL/A==
X-Received: by 2002:a62:58c7:: with SMTP id m190mr18106081pfb.4.1553415682534;
        Sun, 24 Mar 2019 01:21:22 -0700 (PDT)
Received: from ash ([171.226.148.85])
        by smtp.gmail.com with ESMTPSA id y14sm16654754pgg.6.2019.03.24.01.21.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 24 Mar 2019 01:21:21 -0700 (PDT)
Received: by ash (sSMTP sendmail emulation); Sun, 24 Mar 2019 15:21:17 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     pclouds@gmail.com
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>
Subject: [PATCH v2 02/20] diff-parseopt: convert --ita-[in]visible-in-index
Date:   Sun, 24 Mar 2019 15:19:56 +0700
Message-Id: <20190324082014.2041-3-pclouds@gmail.com>
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
 diff.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/diff.c b/diff.c
index 7bfdf08137..8255db6966 100644
--- a/diff.c
+++ b/diff.c
@@ -5352,6 +5352,12 @@ static void prep_parse_options(struct diff_options *options)
 			       N_("specify how differences in submodules are shown"),
 			       PARSE_OPT_NONEG | PARSE_OPT_OPTARG,
 			       diff_opt_submodule),
+		OPT_SET_INT_F(0, "ita-invisible-in-index", &options->ita_invisible_in_index,
+			      N_("hide 'git add -N' entries from the index"),
+			      1, PARSE_OPT_NONEG),
+		OPT_SET_INT_F(0, "ita-visible-in-index", &options->ita_invisible_in_index,
+			      N_("treat 'git add -N' entries as real in the index"),
+			      0, PARSE_OPT_NONEG),
 		{ OPTION_CALLBACK, 0, "output", options, N_("<file>"),
 		  N_("Output to a specific file"),
 		  PARSE_OPT_NONEG, NULL, 0, diff_opt_output },
@@ -5401,10 +5407,7 @@ int diff_opt_parse(struct diff_options *options,
 		if (cm & COLOR_MOVED_WS_ERROR)
 			return -1;
 		options->color_moved_ws_handling = cm;
-	} else if (!strcmp(arg, "--ita-invisible-in-index"))
-		options->ita_invisible_in_index = 1;
-	else if (!strcmp(arg, "--ita-visible-in-index"))
-		options->ita_invisible_in_index = 0;
+	}
 
 	/* misc options */
 	else if (!strcmp(arg, "-z"))
-- 
2.21.0.548.gd3c7d92dc2

