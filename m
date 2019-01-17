Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 93F541F453
	for <e@80x24.org>; Thu, 17 Jan 2019 13:11:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727418AbfAQNLT (ORCPT <rfc822;e@80x24.org>);
        Thu, 17 Jan 2019 08:11:19 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:46435 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725887AbfAQNLT (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 Jan 2019 08:11:19 -0500
Received: by mail-pg1-f195.google.com with SMTP id w7so4416735pgp.13
        for <git@vger.kernel.org>; Thu, 17 Jan 2019 05:11:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=6Kdt2B8M1OWpo78myM6T6ujIos9mAltOkugzu+e6Su8=;
        b=nTu78t0amhN+BsoW15Mhp37ul4/luCL5jQZ+RKoCCkgm2++K3i3ouwn4ft9gnzCKNG
         9KqRtnNUjeGKlMvwIK1kBqpYdz46kVGJTrMjo0vKXSikRQzai413GiTxXZx9PX7w2lEA
         55f+ZgXu+MOrpF3PYMprXrmc1FCDfPgLd/7eBSj/mTUra3QQ/hMmJv6ZAN6ytIBJHj1P
         sIBnmvaFSLcag/wFIrIpDCFuAkzMW5gaQ//w+g2Umx6YhF2wBLrmrWPVOX19QYY7TGs7
         CntB7vH6m+jvgatiBvIpd0f1YKwZgbjReTnuXdc5YKfkz3Q8djl2JmHxmRWWYRPTXcjs
         8IUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6Kdt2B8M1OWpo78myM6T6ujIos9mAltOkugzu+e6Su8=;
        b=gWiSwMR4qRJrFGMP9Iiavwy1LGMy2gZtX0kuD7qHqR8i76JDWnwEvzwisN/DQZ2cTk
         /8anBEgJsQRmfuW6v/V/jRHBj07WJHKhbtozNKFgapMXvJ2nuALl9r1dGwj5UjJHPRXi
         ZNMNBcQuXpjo8I07QhMYTTzfdCnWBw2bfiZTg3WIw9YPLKLewe/JKwbRREbW0FGTWX7o
         34SOxv7+uyprnZ2UefL+AeFCOuJQmLKndbxyr/avm19+VE9HiP2M8+hq26BPPxhp5t12
         4qdYeIBHzOliKmj5pC2oXm5iqhmLfa+AKH8vmIIfGK021u4tMIpMKnMSjL9T4CAPAHon
         wCIQ==
X-Gm-Message-State: AJcUukcp8ExAIASBLaatCwWkvMxbF9/uFFlePTq2egOIJ+T2t/6B/S8S
        vCp8gPm8y0dD+i7LaPAcLbfyO0gy
X-Google-Smtp-Source: ALg8bN7GdGZX36tm9mJs/bqZI5ySt7ok/NwMjArHIH0B3WcIO2Y8J0xr/CKuXVx49UB3peZfGMEi/g==
X-Received: by 2002:a62:4641:: with SMTP id t62mr14675304pfa.141.1547730678013;
        Thu, 17 Jan 2019 05:11:18 -0800 (PST)
Received: from ash ([115.72.21.220])
        by smtp.gmail.com with ESMTPSA id v9sm3074749pfe.49.2019.01.17.05.11.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 17 Jan 2019 05:11:17 -0800 (PST)
Received: by ash (sSMTP sendmail emulation); Thu, 17 Jan 2019 20:11:13 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 58/76] diff.c: convert --ita-[in]visible-in-index
Date:   Thu, 17 Jan 2019 20:05:57 +0700
Message-Id: <20190117130615.18732-59-pclouds@gmail.com>
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
 diff.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/diff.c b/diff.c
index c60cfc80a4..0922937bab 100644
--- a/diff.c
+++ b/diff.c
@@ -5356,6 +5356,12 @@ static void prep_parse_options(struct diff_options *options)
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
@@ -5405,10 +5411,7 @@ int diff_opt_parse(struct diff_options *options,
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
2.20.0.482.g66447595a7

