Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4AF101F45F
	for <e@80x24.org>; Wed,  8 May 2019 11:14:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727444AbfEHLOD (ORCPT <rfc822;e@80x24.org>);
        Wed, 8 May 2019 07:14:03 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:34585 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726254AbfEHLOD (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 May 2019 07:14:03 -0400
Received: by mail-pg1-f193.google.com with SMTP id c13so9961636pgt.1
        for <git@vger.kernel.org>; Wed, 08 May 2019 04:14:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=eGWRSgE5cBrb3UWIyEsygESHpzpNpNpwWZfwDvI8Tuk=;
        b=f1hWHAzIdzfjHDt4GmlZKROkD7PkJGd+ak2K+o9SHbcs/fdjF0Zh7Dk++U/9BXWoHk
         F46ed4bEdOj935HQsi8GZDTuPLNIgZOPirMebM6qexVHa33+OU7tMOKp2saxa92nWtZh
         wkLU5tSRMx3osSlMejaHVi/HlyENznvN81LL/Gf2xV/GckDRMpyrpvdp8EP4RHb2lO8O
         MOI4zYfh7R0IsXCA88t9Uyq6Pdco/kDrQIYjlRAvssFZaRylotfyiquvvAn36ElPzZ3y
         LAJP0ktrGwpGl3pDykIfeHUnOvUh10kKy1dsxX/9Jyn2T5noIfj/Gf5yYoXPQ6a8OjFV
         5+jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=eGWRSgE5cBrb3UWIyEsygESHpzpNpNpwWZfwDvI8Tuk=;
        b=I41Pz0S9gl6v+GEhKnfXIUaIHPwssiBtWxqXy6Mb6rw8CW7Of6wDWMIXRKVezGDXqN
         HypBc99UiqyfwwGFSwvqnP0wqZ74i9uRhUL/PJzl6hPo4lSFmDnGb+fd3H9GySHQRgbT
         qI/bwUoIidFheixCNqaK+CnPfEFEcAx1vHWDLV+FqgNuemGhXcDo41dln5o18pTE5YuS
         oaC5XrnGMycnKYePFefrECCJkQUKqgBhAimO0K3dFIrHhy/0cXwnsLZHsSy9yHXvoUve
         WxSVovvjtC5XPEKD0H6jkOzZ1uFwrYuCWG1vJJ4dGXLkOTyKGSbcxgYq8AXv0yhAlRQ0
         ZNRw==
X-Gm-Message-State: APjAAAXudXrokYt4RbuVxoMxDevnIWLRp8aADCYGaSQfPwEQmzHJ6AQQ
        0VCXTjr1/x+rLxv77QBfLHB5vb1w
X-Google-Smtp-Source: APXvYqy/cFqe2P6ICZ6a6TfuS5pUrFmUKgrezBibX4NkUqf16BRwcBe0gLB3LjtOmahFuelZhm+rbg==
X-Received: by 2002:a63:88c7:: with SMTP id l190mr8736635pgd.244.1557314042528;
        Wed, 08 May 2019 04:14:02 -0700 (PDT)
Received: from ash ([115.72.28.243])
        by smtp.gmail.com with ESMTPSA id s9sm21318220pfe.183.2019.05.08.04.14.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 08 May 2019 04:14:01 -0700 (PDT)
Received: by ash (sSMTP sendmail emulation); Wed, 08 May 2019 18:13:58 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 09/19] rev-parseopt: convert --glob
Date:   Wed,  8 May 2019 18:12:39 +0700
Message-Id: <20190508111249.15262-10-pclouds@gmail.com>
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
 revision.c | 28 +++++++++++++++++++++-------
 1 file changed, 21 insertions(+), 7 deletions(-)

diff --git a/revision.c b/revision.c
index bcfca8856f..013b8ec19f 100644
--- a/revision.c
+++ b/revision.c
@@ -30,6 +30,9 @@
 #include "prio-queue.h"
 #include "hashmap.h"
 
+#define OPT_REV(s, l, a, h, cb)		 \
+	OPT_CALLBACK_F(s, l, revs, a, h, PARSE_OPT_NONEG, cb)
+
 #define OPT_REV_NOARG(s, l, h, cb) \
 	OPT_CALLBACK_F(s, l, revs, NULL, h, \
 		       PARSE_OPT_NONEG | PARSE_OPT_NOARG, cb)
@@ -2425,6 +2428,20 @@ static int rev_opt_branches(const struct option *opt,
 	return 0;
 }
 
+static int rev_opt_glob(const struct option *opt,
+			const char *arg, int unset)
+{
+	struct rev_info	*revs  = opt->value;
+	int flags = *revs->pseudo_flags;
+	struct all_refs_cb cb;
+
+	BUG_ON_OPT_NEG(unset);
+	init_all_refs_cb(&cb, revs, flags);
+	for_each_glob_ref(handle_one_ref, arg, &cb);
+	clear_ref_exclusion(&revs->ref_excludes);
+	return 0;
+}
+
 static int rev_opt_remotes(const struct option *opt,
 			   const char *arg, int unset)
 {
@@ -2495,6 +2512,9 @@ static void make_pseudo_options(struct rev_info *revs)
 		OPT_REV_OPTARG(0, "remotes", N_("<pattern>"),
 			       N_("include all refs in refs/remotes (optionally matches pattern)"),
 			       rev_opt_remotes),
+		OPT_REV(0, "glob", N_("<pattern>"),
+			N_("include all refs matching shell glob"),
+			rev_opt_glob),
 		OPT_END()
 	};
 	ALLOC_ARRAY(revs->pseudo_options, ARRAY_SIZE(options));
@@ -2535,13 +2555,7 @@ static int handle_revision_pseudo_opt(const char *submodule,
 	if (argc)
 		return argc;
 
-	if ((argcount = parse_long_opt("glob", argv, &optarg))) {
-		struct all_refs_cb cb;
-		init_all_refs_cb(&cb, revs, *flags);
-		for_each_glob_ref(handle_one_ref, optarg, &cb);
-		clear_ref_exclusion(&revs->ref_excludes);
-		return argcount;
-	} else if ((argcount = parse_long_opt("exclude", argv, &optarg))) {
+	if ((argcount = parse_long_opt("exclude", argv, &optarg))) {
 		add_ref_exclusion(&revs->ref_excludes, optarg);
 		return argcount;
 	} else if (!strcmp(arg, "--reflog")) {
-- 
2.21.0.1141.gd54ac2cb17

