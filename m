Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7883F20248
	for <e@80x24.org>; Sun, 24 Mar 2019 08:21:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728540AbfCXIVt (ORCPT <rfc822;e@80x24.org>);
        Sun, 24 Mar 2019 04:21:49 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:38220 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727727AbfCXIVt (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 24 Mar 2019 04:21:49 -0400
Received: by mail-pf1-f193.google.com with SMTP id 10so4299628pfo.5
        for <git@vger.kernel.org>; Sun, 24 Mar 2019 01:21:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=dzh3J9V9o03cihS3oPoLWWVcPoW/ZQfztAUdyR1NAYg=;
        b=IOOR2qkrfGRWkehZKMg1xlZLUkDHSpD80MA+E6NSvpfrmjw6wU//2HMPMpRehw0jkO
         yuWtRqhQlUDVqmAYc2MAkUaF5nyie5hRmLuXN/CbstuxNhW4Db9NuCDKM0pXUWMhrQqH
         +aD8h6PXc6ACIkkFboIFPEy67bevQhH1/SZkODb10BAu4TVGeR5A12hTmK8OUhmeJu+Y
         1Q1hPc2aW6oIoNxjgQKGsO/2upNX8b4xRSQ49UlJMkBWlEpDoiOmI3tfGT4U+HaeBxFW
         4rjZlh8l6P59hSz5/SmgXdL5j1TXU1tuTVMj9xwjl81OkRhLKvx3gibWhvAqP9987i8T
         Fsfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=dzh3J9V9o03cihS3oPoLWWVcPoW/ZQfztAUdyR1NAYg=;
        b=HRZTwt22bSCxuPmG3A+6Nii0KDZQ1110KeUyMKXeGgU4TnDOTSUVLWVny4neYxEwyK
         9Oz28rRqd+aVTOCUGsoemRLqVBKLbfgKLa9lo7juSjqtTrhpxUn4PkBTHYUS1ziMRWxM
         wvBDWXTLtP4ntuLHBIizq7wo7pVWCd+xaBY4yEOznnijLVh5ytMTT5fGP1aLqtulf1JH
         GAmYxxj1R66M4kcvn8OUavSy2hxmA4iyCXf50p2iLWHfLhIItaB54/MepMBffMN09DPu
         f24DsLfM//w3kcR/b2E8F/ICxnzGk88sDSkvsQHe9XKxKSg6wt4WyX1G6JfnmW+xqQ7V
         DTUA==
X-Gm-Message-State: APjAAAVjnaCdmNtuDa7H7uiEuwEOrk2mJvLofnH1oOdSqxQFQKmSs1va
        azhCpjGQCDN2tfelZYyTQ/KWIB/Z
X-Google-Smtp-Source: APXvYqxCIUez7ulIbtxlmrtAE4vN8Yp9UhO5DZw9JMUahKntamKDLaGEGU9N+8NwKmp7lQq8kBJHog==
X-Received: by 2002:a17:902:2aca:: with SMTP id j68mr18916946plb.233.1553415708797;
        Sun, 24 Mar 2019 01:21:48 -0700 (PDT)
Received: from ash ([171.226.148.85])
        by smtp.gmail.com with ESMTPSA id f3sm15228205pfn.100.2019.03.24.01.21.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 24 Mar 2019 01:21:47 -0700 (PDT)
Received: by ash (sSMTP sendmail emulation); Sun, 24 Mar 2019 15:21:44 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     pclouds@gmail.com
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>
Subject: [PATCH v2 07/20] diff-parseopt: convert -O
Date:   Sun, 24 Mar 2019 15:20:01 +0700
Message-Id: <20190324082014.2041-8-pclouds@gmail.com>
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
 diff.c | 23 +++--------------------
 1 file changed, 3 insertions(+), 20 deletions(-)

diff --git a/diff.c b/diff.c
index 699f8605d0..849620aea5 100644
--- a/diff.c
+++ b/diff.c
@@ -4617,22 +4617,6 @@ static int opt_arg(const char *arg, int arg_short, const char *arg_long, int *va
 	return 1;
 }
 
-static inline int short_opt(char opt, const char **argv,
-			    const char **optarg)
-{
-	const char *arg = argv[0];
-	if (arg[0] != '-' || arg[1] != opt)
-		return 0;
-	if (arg[2] != '\0') {
-		*optarg = arg + 2;
-		return 1;
-	}
-	if (!argv[1])
-		die("Option '%c' requires a value", opt);
-	*optarg = argv[1];
-	return 2;
-}
-
 int parse_long_opt(const char *opt, const char **argv,
 		   const char **optarg)
 {
@@ -5397,6 +5381,8 @@ static void prep_parse_options(struct diff_options *options)
 		OPT_BIT_F(0, "pickaxe-regex", &options->pickaxe_opts,
 			  N_("treat <string> in -S as extended POSIX regular expression"),
 			  DIFF_PICKAXE_REGEX, PARSE_OPT_NONEG),
+		OPT_FILENAME('O', NULL, &options->orderfile,
+			     N_("control the order in which files appear in the output")),
 		{ OPTION_CALLBACK, 0, "output", options, N_("<file>"),
 		  N_("Output to a specific file"),
 		  PARSE_OPT_NONEG, NULL, 0, diff_opt_output },
@@ -5449,10 +5435,7 @@ int diff_opt_parse(struct diff_options *options,
 	}
 
 	/* misc options */
-	else if ((argcount = short_opt('O', av, &optarg))) {
-		options->orderfile = prefix_filename(prefix, optarg);
-		return argcount;
-	} else if (skip_prefix(arg, "--find-object=", &arg))
+	else if (skip_prefix(arg, "--find-object=", &arg))
 		return parse_objfind_opt(options, arg);
 	else if ((argcount = parse_long_opt("diff-filter", av, &optarg))) {
 		int offending = parse_diff_filter_opt(optarg, options);
-- 
2.21.0.548.gd3c7d92dc2

