Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4222720248
	for <e@80x24.org>; Wed, 20 Mar 2019 11:47:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728031AbfCTLrd (ORCPT <rfc822;e@80x24.org>);
        Wed, 20 Mar 2019 07:47:33 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:41179 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727673AbfCTLrd (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 20 Mar 2019 07:47:33 -0400
Received: by mail-pg1-f193.google.com with SMTP id k11so1620882pgb.8
        for <git@vger.kernel.org>; Wed, 20 Mar 2019 04:47:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=rgW7cf+TDIhw9W2pz6ltAL4fzzg/Gw3bQuRPnD7TjUo=;
        b=D0uiE4w/FrEFQu9InagcdTOylPmMesXxW6LtEkh46HBPLysazV8iTDCP9PW+tDZwoY
         e3RSFjUQS8WeqmTPErd3H8sc9HeFzqFXzm2aC647TeBkC4kiZ5QHEWjr9IG84G7tLpKm
         86rI0DLmn42f4th6zvfZts66BuHTLZ2629G+UGJGqEU6aVBxxpksJRQjrMowAtnMP30R
         b4ADWlqeofzFUN5XXFIfMozIhlZ81S5bMGq+ViVo5yKn/v2HcYWmo5cRg85naW29+u+M
         c5h7p/VN9WmAH/c0YaSIhhhEN4owMBa08DpG1cHlYC6sg4uDWTmXVWsFURt7eEHWQ28D
         n7hA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=rgW7cf+TDIhw9W2pz6ltAL4fzzg/Gw3bQuRPnD7TjUo=;
        b=Y930O1vxnWBedd6zW+nwvjdFZBLuC9x9mYkoNRSdKtHaYMkGIwxH5ZdUlNXicMd8Jm
         Linl/z11DXtG6uhOdxe2d3rumygGe9lNXtLRGbPyr3rLCVyG3sevnByKDgQm3AwXTSTo
         jwl125Qr4HAVSDAdyr1jAGzmXF5nUlhT7GJ/FXcsn96jjNK14/dnsixrPlDiNnABKX9A
         1bvaTtDfwlGeBZFjvfncFF+Vw1ze8mLJXNE1dWoGRTk3hvxdpU4OIn7yhmFJEgCcxcb1
         Wm2S0VaJkJQL++5+V52SJ6gl3Us7cSb9ZbB4aEJ4JbM2FuS8JJ9yqnIO7Z2xexys2sf9
         dYyQ==
X-Gm-Message-State: APjAAAUnzWKu9prZVe2mNHi26B8KG1JthRZYnIRpOmIi7pebvws8D7SD
        O6mU/yxqWptdj2tqVSMXTo7V356N
X-Google-Smtp-Source: APXvYqyjrmHwZKZpiwMlHTuFQSVl4y6VFfBL6POAuVEH66aNZJoHcKh2RwQooEi3+WJAEbc/8t+ziQ==
X-Received: by 2002:a17:902:e90b:: with SMTP id cs11mr7345209plb.197.1553082452382;
        Wed, 20 Mar 2019 04:47:32 -0700 (PDT)
Received: from ash ([171.226.148.85])
        by smtp.gmail.com with ESMTPSA id 8sm6055935pfs.50.2019.03.20.04.47.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 20 Mar 2019 04:47:31 -0700 (PDT)
Received: by ash (sSMTP sendmail emulation); Wed, 20 Mar 2019 18:47:28 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 04/20] diff-parseopt: convert -l
Date:   Wed, 20 Mar 2019 18:46:47 +0700
Message-Id: <20190320114703.18659-5-pclouds@gmail.com>
X-Mailer: git-send-email 2.21.0.548.gd3c7d92dc2
In-Reply-To: <20190320114703.18659-1-pclouds@gmail.com>
References: <20190320114703.18659-1-pclouds@gmail.com>
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
index f290dfe6be..a2abc7e5b0 100644
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

