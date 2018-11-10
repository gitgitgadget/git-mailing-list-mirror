Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A4EE11F453
	for <e@80x24.org>; Sat, 10 Nov 2018 05:47:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728918AbeKJPau (ORCPT <rfc822;e@80x24.org>);
        Sat, 10 Nov 2018 10:30:50 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:35838 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728580AbeKJPau (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 10 Nov 2018 10:30:50 -0500
Received: by mail-lj1-f195.google.com with SMTP id x85-v6so3385741ljb.2
        for <git@vger.kernel.org>; Fri, 09 Nov 2018 21:47:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=T8tkQrHcVan+15UA/mLjWyL0TLA0af4wGSWSp2pIuH8=;
        b=uvowk8inDjtx/0a9ytT0ar+qQYpOPnteHdZEPAyRy8cQI583HjNFnGaEIZ5p8/GHfx
         TJeTnM61hYjq13YdXKBZfISNCFji1H6MZFIBk0kQCvPdhRVrDHzH8YUSgDoLLdA+b9sq
         Ddcjgz4X7ckJHtajvhaakj677ASmXCkAWOpG7tCKLpHxDQqkKKS2FfNo0do4h+MZjJTy
         dYPyluxKprtnw5rudYEnEw6oRc1cFM44Jl1mL47QKF2Jx/lfFhUhDZWdW0+9CPZFrKNB
         DNfInD9YLiPqfaRCYMEgGvyKck7VvvGIqnJOpoMHF4zOiZMfLPICEzx9ufrqeHnHlhPk
         5B6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=T8tkQrHcVan+15UA/mLjWyL0TLA0af4wGSWSp2pIuH8=;
        b=A7znQ/FGfP2opl2zDzqaKkVNpx7HTxFokhphXi8UNMYEZOHAC/qBePb8OsBkq7kx0k
         /EEvoAC2a90neW9E6v9E9K9Lz1WZYQLDgVegFxlafGF31dkwNd3CMSrn6TeRzDz5sZBD
         hKdqYDwr/UApcZafdg094+YIBBd/qYLs9lJWwpbOcj4L14p4iBmghl8Yvy1+dB8wR+tn
         KRqmbM2c46GZbc+qICKgFvWoeOtqa9wHudku0mk0sAoau5oucgv48LekoU8hcl1LOESJ
         w3TQUS0nfcdlJz8bUor7YpRiWFMUAXYXGgBEbSUSK7ljDXjQkoo0VydlFbHfohndqFoa
         va+w==
X-Gm-Message-State: AGRZ1gLVR5QAPDUvilOzulhKjRbI5Rxnd1QUCp8qlntcm21IARnNKKqQ
        pu2XoZEN/9YxjOVLrAZp5W69tZgv
X-Google-Smtp-Source: AJdET5dPL1S2NUkDRRlq6MJxl1aqv2uV144hL015VXSngganzA0hbSwJA7krQA0AKJ8zTtUtFVGU8Q==
X-Received: by 2002:a2e:5418:: with SMTP id i24-v6mr7784542ljb.51.1541826996987;
        Fri, 09 Nov 2018 21:16:36 -0800 (PST)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id g66sm1769663lfe.42.2018.11.09.21.16.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 09 Nov 2018 21:16:36 -0800 (PST)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     pclouds@gmail.com
Cc:     git@vger.kernel.org, gitster@pobox.com, szeder.dev@gmail.com
Subject: [PATCH v3 13/16] parse-options.c: turn some die() to BUG()
Date:   Sat, 10 Nov 2018 06:16:12 +0100
Message-Id: <20181110051615.8641-14-pclouds@gmail.com>
X-Mailer: git-send-email 2.19.1.1231.g84aef82467
In-Reply-To: <20181110051615.8641-1-pclouds@gmail.com>
References: <20181105192059.20303-1-pclouds@gmail.com>
 <20181110051615.8641-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

These two strings are clearly not for the user to see. Reduce the
violence in one string while at there.

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 parse-options.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/parse-options.c b/parse-options.c
index 0bf817193d..3f5f985c1e 100644
--- a/parse-options.c
+++ b/parse-options.c
@@ -197,7 +197,7 @@ static int get_value(struct parse_opt_ctx_t *p,
 		return 0;
 
 	default:
-		die("should not happen, someone must be hit on the forehead");
+		BUG("opt->type %d should not happen", opt->type);
 	}
 }
 
@@ -424,7 +424,7 @@ void parse_options_start(struct parse_opt_ctx_t *ctx,
 	ctx->flags = flags;
 	if ((flags & PARSE_OPT_KEEP_UNKNOWN) &&
 	    (flags & PARSE_OPT_STOP_AT_NON_OPTION))
-		die("STOP_AT_NON_OPTION and KEEP_UNKNOWN don't go together");
+		BUG("STOP_AT_NON_OPTION and KEEP_UNKNOWN don't go together");
 	parse_options_check(options);
 }
 
-- 
2.19.1.1231.g84aef82467

