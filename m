Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 957CF1F453
	for <e@80x24.org>; Thu, 17 Jan 2019 13:11:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728085AbfAQNLu (ORCPT <rfc822;e@80x24.org>);
        Thu, 17 Jan 2019 08:11:50 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:42531 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725887AbfAQNLu (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 Jan 2019 08:11:50 -0500
Received: by mail-pg1-f195.google.com with SMTP id d72so4430775pga.9
        for <git@vger.kernel.org>; Thu, 17 Jan 2019 05:11:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=TmVPZWsq6PHtCeaHeaGmwKta8CKelkpUf+7j6AHnmvI=;
        b=bFxh8v41/gb5pUUKBiIbbL9Xj2ySrfAlVzATlTTU8DmcyP1a8A1kZ7otoBNbkkQ433
         oD7DTre6hc4oetAXkO/KeVHm1q/2Wz52q6GemX0VZPY9jhxmcLSFKr61hKor83mGFaDj
         u353myFzNVKD3F7m8h5oq0GAYnhm/aZ99CGDkihf687UnawSzfCDkIv7v1e75M556ip5
         8pr1MRUR+fc6/nUsesB7zUPpX6D1MfGNdJI2OZsR0xDt7z79hwriCnN8zuxtyUzQbDJl
         wWti7gRrT9dAMoBY0OElCPrzz6bk9/J3B8Renl2z7e/rRTIybJfAxr3TASfJjTYJfegG
         f16g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=TmVPZWsq6PHtCeaHeaGmwKta8CKelkpUf+7j6AHnmvI=;
        b=ihOU/o7WhtE5rwNkchNiEW5r4TxPRsSRTmD5q7C3YVSCB/ZHNCEpiqOamgwt1R7jks
         wJ1j/NMUExCwUIf3802np+AEFrBFoKzz+owvx3S9s8aLDvYs25J/tTkSve+7x6280rkp
         2Or60KBqiqckl0cIsPP8X2TxmRSM2P30sP6TsGa7BlbcK/R6pTYMCKBU3vwbKpiqXZyw
         /qEVaYxusSDWCfwIIm7PvNFefZzn9q/OBKfjAWTR7JsfpZjDm6AoA2ANefcqD7sqVV3R
         WQZiQ+/TbEe0VIKIG5BCQsCbmpMBwXrKMAImZEL9tgA0vd7tx/D41KQwEsLAiNDP4o9E
         yfWQ==
X-Gm-Message-State: AJcUukdjYJZBrdiFTdylZBnFo5GFtit7rR36dxo76y8EQldS3Cc88OQX
        ynUysyBX2eeZbJvFj+PcaPeSW0mc
X-Google-Smtp-Source: ALg8bN4apnV59B4sI3YJDMlE+8sBBYwmseySoQuQLwwjtMRMELlPrkjU3b49Y+Z0g7cNW+0+XCjnsg==
X-Received: by 2002:a65:60c2:: with SMTP id r2mr13601054pgv.393.1547730709157;
        Thu, 17 Jan 2019 05:11:49 -0800 (PST)
Received: from ash ([115.72.21.220])
        by smtp.gmail.com with ESMTPSA id i193sm7559102pgc.22.2019.01.17.05.11.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 17 Jan 2019 05:11:48 -0800 (PST)
Received: by ash (sSMTP sendmail emulation); Thu, 17 Jan 2019 20:11:43 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 64/76] diff.c: convert --find-object
Date:   Thu, 17 Jan 2019 20:06:03 +0700
Message-Id: <20190117130615.18732-65-pclouds@gmail.com>
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
 diff.c | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/diff.c b/diff.c
index 4e004a2195..2a943d47fd 100644
--- a/diff.c
+++ b/diff.c
@@ -4818,12 +4818,15 @@ static int diff_opt_ws_error_highlight(const struct option *option,
 	return 0;
 }
 
-static int parse_objfind_opt(struct diff_options *opt, const char *arg)
+static int diff_opt_find_object(const struct option *option,
+				const char *arg, int unset)
 {
+	struct diff_options *opt = option->value;
 	struct object_id oid;
 
+	BUG_ON_OPT_NEG(unset);
 	if (get_oid(arg, &oid))
-		return error("unable to resolve '%s'", arg);
+		return error(_("unable to resolve '%s'"), arg);
 
 	if (!opt->objfind)
 		opt->objfind = xcalloc(1, sizeof(*opt->objfind));
@@ -4832,7 +4835,7 @@ static int parse_objfind_opt(struct diff_options *opt, const char *arg)
 	opt->flags.recursive = 1;
 	opt->flags.tree_in_recursive = 1;
 	oidset_insert(opt->objfind, &oid);
-	return 1;
+	return 0;
 }
 
 static int diff_opt_anchored(const struct option *opt,
@@ -5403,6 +5406,9 @@ static void prep_parse_options(struct diff_options *options)
 			  DIFF_PICKAXE_REGEX, PARSE_OPT_NONEG),
 		OPT_FILENAME('O', NULL, &options->orderfile,
 			     N_("override diff.orderFile configuration variable")),
+		OPT_CALLBACK_F(0, "find-object", options, N_("<object-id>"),
+			       N_("look for differences that change the number of occurrences of the specified object"),
+			       PARSE_OPT_NONEG, diff_opt_find_object),
 		{ OPTION_CALLBACK, 0, "output", options, N_("<file>"),
 		  N_("Output to a specific file"),
 		  PARSE_OPT_NONEG, NULL, 0, diff_opt_output },
@@ -5455,8 +5461,6 @@ int diff_opt_parse(struct diff_options *options,
 	}
 
 	/* misc options */
-	else if (skip_prefix(arg, "--find-object=", &arg))
-		return parse_objfind_opt(options, arg);
 	else if ((argcount = parse_long_opt("diff-filter", av, &optarg))) {
 		int offending = parse_diff_filter_opt(optarg, options);
 		if (offending)
-- 
2.20.0.482.g66447595a7

