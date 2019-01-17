Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9E20A1F453
	for <e@80x24.org>; Thu, 17 Jan 2019 13:08:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727855AbfAQNId (ORCPT <rfc822;e@80x24.org>);
        Thu, 17 Jan 2019 08:08:33 -0500
Received: from mail-pl1-f182.google.com ([209.85.214.182]:40458 "EHLO
        mail-pl1-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725887AbfAQNId (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 Jan 2019 08:08:33 -0500
Received: by mail-pl1-f182.google.com with SMTP id u18so4731119plq.7
        for <git@vger.kernel.org>; Thu, 17 Jan 2019 05:08:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=FX8XurVW7WKuCCwKN7YfUSdJvk1rNEFIeDdGYUolrQQ=;
        b=kXRgczYyTz7gkjQL9w7JzV5ckgd0f7ChAgE4dGtZfuSV7LXnUUL/Kuhsy37jsNOKRb
         FtTMjQhhGMbFhQizgCqmvRmxXRlFXn/oSMD3EKN57ikpVC9PBM/tvWg9CdXO8o4lCwaz
         yTbh7ObsFm5V3dK7YxBDVJJfnQL8rTCyJScRf2VtuIpnGs8CeUYbCUMJd9FuLIMyz1B1
         qhzS1+1s8gSczOM0llRRUQTzvbINS+wk7BL4a1W9+w+UhGbfLxDQTXOoI6uE9l0GanU3
         hg43z6QqNLoupSvTdQT0KErE1bXy8DXF1TamVJzCj7R/NeYkErjOADTxgQ1K3j0NjNqw
         4ZlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=FX8XurVW7WKuCCwKN7YfUSdJvk1rNEFIeDdGYUolrQQ=;
        b=TXnl2oSTLot/+v/wmcv3RvBlBlXOAK6/jVl+wW/IWLNgz4Qp3GH51DJJfi8VvE1YKF
         hyhIIS/u/o1oXQovJdO/K3r/tyyDelI12Ms8tNeAb5wf5mMb5w90Iee8vGx0PahpqbXr
         JfopvRTvN45tdpJURoolmNf/X/WaKN+1xKhYJEpcvT+x4aTGXxce3QN1FUdEbm5tR4BO
         iLjNsB13sRtWHhzl125kFCyCs9+vzr/zLNUgNlW+ZqoTpx8laHj6BLmDLOd1Tu/a12Ng
         ZMUCMSZgWyjYoSW4vVDJ5ldcOBuScCBEam++1okO1FugwKqYRtY7gTbsCIAbyGqbx98V
         FIDA==
X-Gm-Message-State: AJcUukfpY9iLeAhgowWJLwziLXE8mTQcYSi4nNmaqHtIpyScvP810x/y
        ZqGyzl3oHQzozB1VleSC+xwTXpt9
X-Google-Smtp-Source: ALg8bN40AyfwO3Z9cFO2d23cXoClQb/f896ZaVHcObzY1vnyqTuplBD42KS5qMFRZxGlVBk1u2vWzQ==
X-Received: by 2002:a17:902:a58a:: with SMTP id az10mr15170013plb.10.1547730512787;
        Thu, 17 Jan 2019 05:08:32 -0800 (PST)
Received: from ash ([115.72.21.220])
        by smtp.gmail.com with ESMTPSA id r12sm1661420pgv.83.2019.01.17.05.08.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 17 Jan 2019 05:08:32 -0800 (PST)
Received: by ash (sSMTP sendmail emulation); Thu, 17 Jan 2019 20:08:28 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 24/76] diff.c: convert -s|--no-patch
Date:   Thu, 17 Jan 2019 20:05:23 +0700
Message-Id: <20190117130615.18732-25-pclouds@gmail.com>
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
 diff.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/diff.c b/diff.c
index e685356e3e..4398b30f47 100644
--- a/diff.c
+++ b/diff.c
@@ -4904,6 +4904,9 @@ static void prep_parse_options(struct diff_options *options)
 		OPT_BITOP('p', "patch", &options->output_format,
 			  N_("generate patch"),
 			  DIFF_FORMAT_PATCH, DIFF_FORMAT_NO_OUTPUT),
+		OPT_BIT_F('s', "no-patch", &options->output_format,
+			  N_("suppress diff output"),
+			  DIFF_FORMAT_NO_OUTPUT, PARSE_OPT_NONEG),
 		OPT_BITOP('u', NULL, &options->output_format,
 			  N_("generate patch"),
 			  DIFF_FORMAT_PATCH, DIFF_FORMAT_NO_OUTPUT),
@@ -4981,9 +4984,7 @@ int diff_opt_parse(struct diff_options *options,
 		return ac;
 
 	/* Output format options */
-	if (!strcmp(arg, "-s") || !strcmp(arg, "--no-patch"))
-		options->output_format |= DIFF_FORMAT_NO_OUTPUT;
-	else if (starts_with(arg, "--stat"))
+	if (starts_with(arg, "--stat"))
 		/* --stat, --stat-width, --stat-name-width, or --stat-count */
 		return stat_opt(options, av);
 	else if (!strcmp(arg, "--compact-summary")) {
-- 
2.20.0.482.g66447595a7

