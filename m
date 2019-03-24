Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C147B20248
	for <e@80x24.org>; Sun, 24 Mar 2019 08:21:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728509AbfCXIV2 (ORCPT <rfc822;e@80x24.org>);
        Sun, 24 Mar 2019 04:21:28 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:44215 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727727AbfCXIV2 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 24 Mar 2019 04:21:28 -0400
Received: by mail-pf1-f196.google.com with SMTP id a3so4278325pff.11
        for <git@vger.kernel.org>; Sun, 24 Mar 2019 01:21:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=n8/8INEw9mXjh7augXRGK+u6W5dhTqMFJTxPb9iszv8=;
        b=vboFsmhhG6vVz+IubNZ82kBuZInfjhZI02n/upkp2szUeAnh87Mgnv2NDADhCZZxDY
         4Ic0Jc6yWEAiqCa3DtylKhfBhPcUrMZtcfMh2h3DtxkeWgZ1tls+zsKRt5SBxbPPc4Y+
         LvpZqVj6a1j5QYdQt33eTWBfXk1e1xbI+sDt41rqlVCgXYCHcuxnRMVLkHYcinzpUd/1
         v62u0IClMd1tucoVjO7QgkC521Ne23ztQ3jKVIZEFpoYp3yk8dUukuv2YBMzVVcFjS9A
         CYAWX+14OblsGW0LiR80HkpY/FM4TYTTijNbT5JGflv6+LwNSNlOjHFHlZMMa+e6Y+OL
         9lzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=n8/8INEw9mXjh7augXRGK+u6W5dhTqMFJTxPb9iszv8=;
        b=qKzShcG7PLoeUOD0GHiGPV7XuGl5wy20Bxg+gOZEEygoWPAm7go6ejS/Jg30Ay+i/R
         H9Pi/vL7mbLjKA7Ub9n6k/ogg1U+YlFJEJD7IZEcHm7EWha5Lr27oeoXkHENNz8brqn+
         wKD8+Otnrkkw+VZV8eMGfSZVN6vQDpexdOz5f7PdEmnoWarAWpmBd9YTt6c9io3WcG7e
         7YLsSOH6wK4Tt7R/B9abgW/rujEr3Z+VwzzlYt4twEbkTjp+ePE9uWkkcg0ScVw/mrez
         glBevGY7CM2kHuPkCqWAGQqvzkndK5t6Ryx/ZgB0gd/T70vyzlPxklSE+CO0ngdFErDj
         JNkg==
X-Gm-Message-State: APjAAAXefgWLoF4+VIppdfrJtLU1iyjp0s8VeHHluUPxiMumQrFYrRiW
        8idyUk7E4B25oK78Ff7af88=
X-Google-Smtp-Source: APXvYqzYrtaUixiOxDmtzKFsk6ENfAGs7sfFZasNvIHlx4Lh/K3OLb4Ca6ru7G4HRRUrJKlrDcaAqg==
X-Received: by 2002:a17:902:e3:: with SMTP id a90mr18365247pla.45.1553415687704;
        Sun, 24 Mar 2019 01:21:27 -0700 (PDT)
Received: from ash ([171.226.148.85])
        by smtp.gmail.com with ESMTPSA id k83sm40750898pfj.178.2019.03.24.01.21.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 24 Mar 2019 01:21:27 -0700 (PDT)
Received: by ash (sSMTP sendmail emulation); Sun, 24 Mar 2019 15:21:22 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     pclouds@gmail.com
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>
Subject: [PATCH v2 03/20] diff-parseopt: convert -z
Date:   Sun, 24 Mar 2019 15:19:57 +0700
Message-Id: <20190324082014.2041-4-pclouds@gmail.com>
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
 diff.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/diff.c b/diff.c
index 8255db6966..2b1d015553 100644
--- a/diff.c
+++ b/diff.c
@@ -5238,6 +5238,9 @@ static void prep_parse_options(struct diff_options *options)
 		OPT_CALLBACK_F(0, "ws-error-highlight", options, N_("<kind>"),
 			       N_("highlight whitespace errors in the 'context', 'old' or 'new' lines in the diff"),
 			       PARSE_OPT_NONEG, diff_opt_ws_error_highlight),
+		OPT_SET_INT('z', NULL, &options->line_termination,
+			    N_("do not munge pathnames and use NULs as output field terminators in --raw or --numstat"),
+			    0),
 		OPT_CALLBACK_F(0, "output-indicator-new",
 			       &options->output_indicators[OUTPUT_INDICATOR_NEW],
 			       N_("<char>"),
@@ -5410,8 +5413,6 @@ int diff_opt_parse(struct diff_options *options,
 	}
 
 	/* misc options */
-	else if (!strcmp(arg, "-z"))
-		options->line_termination = 0;
 	else if ((argcount = short_opt('l', av, &optarg))) {
 		options->rename_limit = strtoul(optarg, NULL, 10);
 		return argcount;
-- 
2.21.0.548.gd3c7d92dc2

