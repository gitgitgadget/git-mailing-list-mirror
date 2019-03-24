Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 42EF320248
	for <e@80x24.org>; Sun, 24 Mar 2019 08:21:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728545AbfCXIVz (ORCPT <rfc822;e@80x24.org>);
        Sun, 24 Mar 2019 04:21:55 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:46509 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727727AbfCXIVy (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 24 Mar 2019 04:21:54 -0400
Received: by mail-pf1-f195.google.com with SMTP id 9so4275908pfj.13
        for <git@vger.kernel.org>; Sun, 24 Mar 2019 01:21:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=fKleG4zI9mc9cJek5uFc0wtkcfCb73Qexrrf6GPCraM=;
        b=PnS7+7ttmWb90Vw8J1niBo6TCV2MGnJZkR7HjDN/ApLsQy7QDQ16SP5WzgipqD6uCq
         KoPj8NYe+EZDvHn0+mRmKkrH4+lJhZXgqcMbJYU3e7Am9CVGskkgpWjqEFoYlQdLWXaK
         Wh8iMSgZedwXmGfn1XYtqKKjY+TL8GEKZKuy6KFzeHdaIfb9XFuHSQsg+iWAl043FyXx
         +hrdY1zuNfCzuwVd0duZ1UW02Kus8EBm2V/2hgSpBHCTesTI4q/99gpTRMnTSn1Yc6j3
         qrL5ztQt4MgtTuq2LSKn3y8/vqDLBsb/GXX8FE95HCUuCGg5AuFwoF+wTDJh7lkfWn1Q
         sthg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=fKleG4zI9mc9cJek5uFc0wtkcfCb73Qexrrf6GPCraM=;
        b=ji+tDTxSmx3xBBJD52AzhmCgyscXn1xUSUo7z75Ui/5hJX06r9T+uqXW+abGo6mPp/
         TJamxydsVYnkbrWiyH3lEje7uHF6H7ZuKvtgZJPzMDBeTZ3NAZMKjiv9gu68w1doXI7Q
         vqmP2sKssu5PFWxzhInVFpmLVrsRVWYUnnbAmS1A2EcTEskLEu/6nbksub7th4z2zclH
         0i/aDPJqICsb8Eu9kE03i1ZZVUdfabC0M2VCywPlXaHRoGqIbMzSlRcSrx5zVbBMpctl
         X9c7PUVv7xgqf3DD43rrQyEVuHavUH/rrGlg57X5eBmrCieBVLUNY8aqvWH/19VGPlsh
         86aA==
X-Gm-Message-State: APjAAAUCATytlnh6nHw/fJuGppMy2PrXbBcgbp2s4RzXpwCXGkKzDpyD
        sH6lb0rlJkcVooRVLJy69L0=
X-Google-Smtp-Source: APXvYqwv1oQQj3pOiLbZ0smaXBu6dqivfeNtZ7uKPPKxYjqDn6d2JbcZe3pSfCpoYlTbEOqt7ItwDA==
X-Received: by 2002:aa7:914f:: with SMTP id 15mr17962692pfi.49.1553415714170;
        Sun, 24 Mar 2019 01:21:54 -0700 (PDT)
Received: from ash ([171.226.148.85])
        by smtp.gmail.com with ESMTPSA id l5sm21233491pfi.97.2019.03.24.01.21.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 24 Mar 2019 01:21:53 -0700 (PDT)
Received: by ash (sSMTP sendmail emulation); Sun, 24 Mar 2019 15:21:49 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     pclouds@gmail.com
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>
Subject: [PATCH v2 08/20] diff-parseopt: convert --find-object
Date:   Sun, 24 Mar 2019 15:20:02 +0700
Message-Id: <20190324082014.2041-9-pclouds@gmail.com>
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

While at it, mark one more string for translation.

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 diff.c | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/diff.c b/diff.c
index 849620aea5..99871d2546 100644
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
 			     N_("control the order in which files appear in the output")),
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

