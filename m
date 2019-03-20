Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7A71020248
	for <e@80x24.org>; Wed, 20 Mar 2019 11:47:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728048AbfCTLrv (ORCPT <rfc822;e@80x24.org>);
        Wed, 20 Mar 2019 07:47:51 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:34451 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727673AbfCTLrv (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 20 Mar 2019 07:47:51 -0400
Received: by mail-pg1-f196.google.com with SMTP id v12so1645544pgq.1
        for <git@vger.kernel.org>; Wed, 20 Mar 2019 04:47:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Ny69466qpbMAXTND/J7eWaOTrxbSRgVmKce5SmOTcz4=;
        b=PuojoGt6sx1P34P5gdO8ZgrVK+ZeUE/mj1xvq+P8k/i9r160XLcT/KdEDadIvEh/Si
         45yL9yAOX7nTW4oV907ohKeSPNTydlxtK35KE9AVZeWKRCxxwaQf6cyIX3XeclYobpOx
         plVKxkJBn9tcstFHIUlNY3A519RA2UpbOPXA9cU50aorRiQifxA3XKd9vbh4zzOmRlhg
         N4G2BY2wkaY/hRmIJ/WRZDs/MM7TeOZFCPD22PpOZpJ/mgtzFISYpqBrlZtRAZBcvGy9
         Bmvt4ocX+MM98TMUIxrytRaGdfH7SZmb+zT7q44y9D9VTsXL6VmRaoxnvryqrABg3dDx
         060w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Ny69466qpbMAXTND/J7eWaOTrxbSRgVmKce5SmOTcz4=;
        b=HhJ9LLUgrIh6RA5Z5UdqB+OjRRv2/SxxfgAXjAPdk7C+8l24XWfpVAltRR6lw3U84u
         ENyTZMr607lkDYbS6ioywHr0MV3OvkirBY2fcHhPiHJMrXtmOMN5lMVhAgMiAey93M37
         /Ga+ocm5CjCXkG5Ugw/8Yf+r2RwMxouVcewLoWjN4SxI2wjXd8qBwJ6c2Jz1tBgVKqIK
         Bn1spqOXOorsDmCes1pUHA13Kv4MsAdVilHoUyZquvm1nlLknWyRO8z9t2Ctf5tprGmu
         5LjxxE4TCnz5BzvRrq48Vzf/oOvo6pCgu+GvV/lU8vubyIfYaoOAgxGSlYJGPylTgkAD
         VnHA==
X-Gm-Message-State: APjAAAVZmfIlyvQNSlNHKu6ni2DVVlmpYApBaqNFXWTOZdlrKJkufwEe
        7THOAd1cYG7kVHqHbSGsnDESSJeq
X-Google-Smtp-Source: APXvYqwkzI34rsjJv1IusTHyGVMYpGbxgcjxvGTm4PU1h1AOJStSkFth30E3DQtkI1nEIJ0biB1oxw==
X-Received: by 2002:a62:3585:: with SMTP id c127mr7543181pfa.71.1553082470691;
        Wed, 20 Mar 2019 04:47:50 -0700 (PDT)
Received: from ash ([171.226.148.85])
        by smtp.gmail.com with ESMTPSA id n15sm6025694pgc.92.2019.03.20.04.47.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 20 Mar 2019 04:47:50 -0700 (PDT)
Received: by ash (sSMTP sendmail emulation); Wed, 20 Mar 2019 18:47:46 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 08/20] diff-parseopt: convert --find-object
Date:   Wed, 20 Mar 2019 18:46:51 +0700
Message-Id: <20190320114703.18659-9-pclouds@gmail.com>
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

while at it, mark one more string for translation.

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 diff.c | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/diff.c b/diff.c
index 21c7a6b1a1..694f32148c 100644
--- a/diff.c
+++ b/diff.c
@@ -4799,12 +4799,15 @@ static int diff_opt_ws_error_highlight(const struct option *option,
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
@@ -4813,7 +4816,7 @@ static int parse_objfind_opt(struct diff_options *opt, const char *arg)
 	opt->flags.recursive = 1;
 	opt->flags.tree_in_recursive = 1;
 	oidset_insert(opt->objfind, &oid);
-	return 1;
+	return 0;
 }
 
 static int diff_opt_anchored(const struct option *opt,
@@ -5383,6 +5386,9 @@ static void prep_parse_options(struct diff_options *options)
 			  DIFF_PICKAXE_REGEX, PARSE_OPT_NONEG),
 		OPT_FILENAME('O', NULL, &options->orderfile,
 			     N_("override diff.orderFile configuration variable")),
+		OPT_CALLBACK_F(0, "find-object", options, N_("<object-id>"),
+			       N_("look for differences that change the number of occurrences of the specified object"),
+			       PARSE_OPT_NONEG, diff_opt_find_object),
 		{ OPTION_CALLBACK, 0, "output", options, N_("<file>"),
 		  N_("Output to a specific file"),
 		  PARSE_OPT_NONEG, NULL, 0, diff_opt_output },
@@ -5435,8 +5441,6 @@ int diff_opt_parse(struct diff_options *options,
 	}
 
 	/* misc options */
-	else if (skip_prefix(arg, "--find-object=", &arg))
-		return parse_objfind_opt(options, arg);
 	else if ((argcount = parse_long_opt("diff-filter", av, &optarg))) {
 		int offending = parse_diff_filter_opt(optarg, options);
 		if (offending)
-- 
2.21.0.548.gd3c7d92dc2

