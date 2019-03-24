Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9CF8A20248
	for <e@80x24.org>; Sun, 24 Mar 2019 08:21:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728510AbfCXIVd (ORCPT <rfc822;e@80x24.org>);
        Sun, 24 Mar 2019 04:21:33 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:34025 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727727AbfCXIVd (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 24 Mar 2019 04:21:33 -0400
Received: by mail-pg1-f194.google.com with SMTP id v12so4372614pgq.1
        for <git@vger.kernel.org>; Sun, 24 Mar 2019 01:21:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=M9L/2RGzOOHTzLOJnp/cHexai2GyZ9XYITXOTJJoRIA=;
        b=e3pKFxS5p+Xzrjo88jdS8evncS26aKugLgb//2v1dBo2wBlM6xNXduZhwFQ7tyst39
         lDdroYvWJh2fEt/Bh2MYW/0B8jFJL3iKNRizVFj/tl/OR2WfSEbV/HQjeMDYdrQfq2B3
         PEhQMvw9mQrcKXwbL6rwN6qCwJp8W+vIygpE7BhUAMh7mu7Ml2CIvRwUPSCpop6SA7pB
         ylLX2Grhgi6AbrbiiueTzIJJztY7IbOyVTk0XlKKC6uE24BJsXcHvWSubqkk0NhthE4d
         qgWkAKHnSCfWYZ+ZBwJuIiukAV9XFg2i3aeh/VZH2cZxURoSPL9Z7NjEO/wbgIRCRnRw
         HR/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=M9L/2RGzOOHTzLOJnp/cHexai2GyZ9XYITXOTJJoRIA=;
        b=cetyO0tlmz131sDWMjBltLCZHtcv98fVcugLzcL01wsGgiIg6Mi5wG/ubxOs22McKd
         0Oi8kj17JP8k70hCf/eyuq6rgPfj/8DIqN6lcshiIchIrbnvq7ouqHeDA89KKQNIJanF
         hr1yBAOWAjisCIKchhG2gMneDvOZi81FS3odkD3h/3a/xl1jH9xLNNTS82HI90P70g2S
         ala20N25g1NeYFUYw3Tki7nyio9Wsr2TFuXGWCv4eN8rEZHs6ICoMZexNLrY8MTIHRbG
         o1adR2S3qnqYLVbOskHJ1cwM0/gPB3DVre9WM/0mIlqcQ3PPDnMyszRzsmmtFJeptJcV
         tghw==
X-Gm-Message-State: APjAAAXM3ebWCU2l4gHfxxzrbV5kZ2rVwlen4MdXobwaOBV/6YYxe1yt
        2DF8GAMpaP7X2RfG4f8ne4c=
X-Google-Smtp-Source: APXvYqxv+uY+IRsAXkW30Z1ZCq3nfXjzn+g+khVX+9ukBQhNNH3awXPX8pS0H1IbMmS1sNuKQfA84w==
X-Received: by 2002:a63:cf0f:: with SMTP id j15mr17549387pgg.329.1553415692892;
        Sun, 24 Mar 2019 01:21:32 -0700 (PDT)
Received: from ash ([171.226.148.85])
        by smtp.gmail.com with ESMTPSA id v19sm15273432pfa.138.2019.03.24.01.21.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 24 Mar 2019 01:21:32 -0700 (PDT)
Received: by ash (sSMTP sendmail emulation); Sun, 24 Mar 2019 15:21:28 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     pclouds@gmail.com
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>
Subject: [PATCH v2 04/20] diff-parseopt: convert -l
Date:   Sun, 24 Mar 2019 15:19:58 +0700
Message-Id: <20190324082014.2041-5-pclouds@gmail.com>
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
 diff.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/diff.c b/diff.c
index 2b1d015553..6b19c97499 100644
--- a/diff.c
+++ b/diff.c
@@ -5283,6 +5283,8 @@ static void prep_parse_options(struct diff_options *options)
 		OPT_CALLBACK_F(0, "follow", options, NULL,
 			       N_("continue listing the history of a file beyond renames"),
 			       PARSE_OPT_NOARG, diff_opt_follow),
+		OPT_INTEGER('l', NULL, &options->rename_limit,
+			    N_("prevent rename/copy detection if the number of rename/copy targets exceeds given limit")),
 
 		OPT_GROUP(N_("Diff algorithm options")),
 		OPT_BIT(0, "minimal", &options->xdl_opts,
@@ -5413,10 +5415,6 @@ int diff_opt_parse(struct diff_options *options,
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
2.21.0.548.gd3c7d92dc2

