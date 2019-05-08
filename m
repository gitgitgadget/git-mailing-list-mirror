Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 38C901F45F
	for <e@80x24.org>; Wed,  8 May 2019 11:14:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727446AbfEHLOI (ORCPT <rfc822;e@80x24.org>);
        Wed, 8 May 2019 07:14:08 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:33624 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726254AbfEHLOI (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 May 2019 07:14:08 -0400
Received: by mail-pl1-f195.google.com with SMTP id y3so9788224plp.0
        for <git@vger.kernel.org>; Wed, 08 May 2019 04:14:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=i8eF5hnjyNDQU3QvMJCzC3RXps+fCYO0g4ozWxbIOfg=;
        b=tcB6LS3oZij/LDyXhm2uEu+9bjuRavgCYwRkcUJcHBCDxqhRFevH2ChJ0hzjt+nE5O
         20RWvw1W2N5R51mS8VVGYTHGbwuf1GuAjffI2779mscfE/BzIB+glU0FJbew/5T8ueRZ
         hL7QQ3jUrpkbJigy1TjS7pJ5rP454EIxIFjIl0kLRSn6+utEeoSKU2ucPW0IK30wwfxt
         bzucg1QI7QwYENt5KuuM5P6qItfRjz4JUA3ZU3TnL4EDXaL9ZVapU5rZCVP741XWiLxA
         20PvKzC/04Exe5JIff+r4iQECrwltvmioJFr5Di5IcI2tlKojumymPGhHAuAdluzs7FL
         6VwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=i8eF5hnjyNDQU3QvMJCzC3RXps+fCYO0g4ozWxbIOfg=;
        b=CdiL7v6bTBlToJLg2glMnAALCrTb4komdyZX7hycyGZT0eKMPD+bvlwMyhgjeUAD8y
         SkCnadCciBp5XL0iDldwuF1ro+ecZuQLd/nAsKDY8CFJq+JS0VT1t1bslYPJXslUYGNc
         sSQKxyFr3Q9EnOWGg0LwgMwzeEfcixjz6Xz2jhourahdwdLc1aH3b94/vzBkA+KAo4CT
         ZjZhUnRN88sigyyrnU2PjxbVS+Qr3Nm+KFbS4XgI6V4fvWpVB0JqtG1WfOKzFAWqDTBW
         D8amIijXy2ub+diXKtCPMN+K/sHkxNaRC8d0gZLJrndlJ76bNUyYI0/q6yGSWePMh5rf
         mYWA==
X-Gm-Message-State: APjAAAUN/gfOIZwW3zNKSTqcf9SFu52v2u/Hi2CauabQW57tyN8hV1P2
        I7O3QXqfRTBwb/IxZA35FifUT9rJ
X-Google-Smtp-Source: APXvYqxsk1mR/C2j8AGBf332dO8XlNziMD0zTHXzLF1evtMjuYO8rN65MlXEQOGcu7wSHt+Qarx2VA==
X-Received: by 2002:a17:902:8f82:: with SMTP id z2mr47519038plo.51.1557314047204;
        Wed, 08 May 2019 04:14:07 -0700 (PDT)
Received: from ash ([115.72.28.243])
        by smtp.gmail.com with ESMTPSA id w12sm10944680pfj.41.2019.05.08.04.14.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 08 May 2019 04:14:06 -0700 (PDT)
Received: by ash (sSMTP sendmail emulation); Wed, 08 May 2019 18:14:02 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 10/19] rev-parseopt: convert --exclude
Date:   Wed,  8 May 2019 18:12:40 +0700
Message-Id: <20190508111249.15262-11-pclouds@gmail.com>
X-Mailer: git-send-email 2.21.0.1141.gd54ac2cb17
In-Reply-To: <20190508111249.15262-1-pclouds@gmail.com>
References: <20190508111249.15262-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 revision.c | 19 ++++++++++++++-----
 1 file changed, 14 insertions(+), 5 deletions(-)

diff --git a/revision.c b/revision.c
index 013b8ec19f..d34e17984d 100644
--- a/revision.c
+++ b/revision.c
@@ -2428,6 +2428,16 @@ static int rev_opt_branches(const struct option *opt,
 	return 0;
 }
 
+static int rev_opt_exclude(const struct option *opt,
+			   const char *arg, int unset)
+{
+	struct rev_info	*revs  = opt->value;
+
+	BUG_ON_OPT_NEG(unset);
+	add_ref_exclusion(&revs->ref_excludes, arg);
+	return 0;
+}
+
 static int rev_opt_glob(const struct option *opt,
 			const char *arg, int unset)
 {
@@ -2515,6 +2525,9 @@ static void make_pseudo_options(struct rev_info *revs)
 		OPT_REV(0, "glob", N_("<pattern>"),
 			N_("include all refs matching shell glob"),
 			rev_opt_glob),
+		OPT_REV(0, "exclude", N_("<pattern>"),
+			N_("exclude refs matching glob pattern"),
+			rev_opt_exclude),
 		OPT_END()
 	};
 	ALLOC_ARRAY(revs->pseudo_options, ARRAY_SIZE(options));
@@ -2528,7 +2541,6 @@ static int handle_revision_pseudo_opt(const char *submodule,
 	const char *arg = argv[0];
 	const char *optarg;
 	struct ref_store *refs;
-	int argcount;
 
 	if (submodule) {
 		/*
@@ -2555,10 +2567,7 @@ static int handle_revision_pseudo_opt(const char *submodule,
 	if (argc)
 		return argc;
 
-	if ((argcount = parse_long_opt("exclude", argv, &optarg))) {
-		add_ref_exclusion(&revs->ref_excludes, optarg);
-		return argcount;
-	} else if (!strcmp(arg, "--reflog")) {
+	if (!strcmp(arg, "--reflog")) {
 		add_reflogs_to_pending(revs, *flags);
 	} else if (!strcmp(arg, "--indexed-objects")) {
 		add_index_objects_to_pending(revs, *flags);
-- 
2.21.0.1141.gd54ac2cb17

