Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 13D7E1F45F
	for <e@80x24.org>; Wed,  8 May 2019 11:14:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727452AbfEHLOZ (ORCPT <rfc822;e@80x24.org>);
        Wed, 8 May 2019 07:14:25 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:37007 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726254AbfEHLOZ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 May 2019 07:14:25 -0400
Received: by mail-pl1-f195.google.com with SMTP id p15so2584542pll.4
        for <git@vger.kernel.org>; Wed, 08 May 2019 04:14:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=15zT0c/TSUSpr+b5xfPQNS4RPhjdXk5JhY0jhLmkIxo=;
        b=VtTMDSIekS8kn1NOJa2CMGsOmg2Zuf84wkwI9LRilWYw7CnqcTRqbR7sh+Zck4vC6a
         jWcs5nQkw+cQPdoVejCTix6rp4J30dnjOyCp8PiaezEdFstzLO+/ylX9V8VAYEdYcf5J
         DImWAdXVDY4a0h/wIHvRpCnAldyBbKCor4cGtFPzbzj9ChNCM05eJlgYtgqy8YZXlwzX
         yZLax85eTRQ6I680Za0Pjx5FAi7+Q+42MYqiLtGOZoJbbFQt0KzRpnF9EXbPxevQoZqX
         YJBe0zgbEtZ9+4oJvLbjXCCPiyy/BWcBVvpzmPgvbgJtNgJvRDB9tHCLa9zWXvTlecDP
         6hrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=15zT0c/TSUSpr+b5xfPQNS4RPhjdXk5JhY0jhLmkIxo=;
        b=lXdiRq/myoOj8tAPv0h5ENKdrE0y8K7V39eY8ty4M6pIUyV/QYuQZ9PH/aWFbF3KZ1
         Af22BAf/1YFZn+W9+PHraScu+lu8grecTnccnPmsHewEmiclYF88VluSwmrILB6j4pT8
         SxCll660klhKLzHQvvqw+yBGCc0CZxiLQSD/4B+Y5WhhnwPMtcxWeriPgCnQU1ipeK+y
         GZYLCXj4H3FDuDpviZ1E8jsjl9huRAY2p8vuPPjFcD28hk5zqUZo11GXbs54X2hLTS5V
         f6lM1tx2YmBhzUsu2mSXwAHhm2X8Xsh0C2/RhWzC8Yehy8ZOg6jxQg12SQv6eU4Ue0lU
         OpWw==
X-Gm-Message-State: APjAAAVQ0GUISU2vMmDwKQe68ma/tAo5WDY2eCrpwRsG/C3Z3QGSVc5a
        rh7L69u6gSImyQAxZFglPKMBk+/A
X-Google-Smtp-Source: APXvYqymN/3jVOsDmbxhUbXMJ3C9e6LIrt5hE/rs7fxDky/bDN8yXqa3J4/XDA/hOqSCJpKLlgSETQ==
X-Received: by 2002:a17:902:1d4a:: with SMTP id u10mr41151428plu.272.1557314064371;
        Wed, 08 May 2019 04:14:24 -0700 (PDT)
Received: from ash ([115.72.28.243])
        by smtp.gmail.com with ESMTPSA id 2sm11320763pgc.49.2019.05.08.04.14.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 08 May 2019 04:14:23 -0700 (PDT)
Received: by ash (sSMTP sendmail emulation); Wed, 08 May 2019 18:14:20 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 14/19] rev-parseopt: convert --no-walk and --do-walk
Date:   Wed,  8 May 2019 18:12:44 +0700
Message-Id: <20190508111249.15262-15-pclouds@gmail.com>
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
 revision.c | 47 ++++++++++++++++++++++++++++++-----------------
 1 file changed, 30 insertions(+), 17 deletions(-)

diff --git a/revision.c b/revision.c
index b02cb4660b..f04eb7f140 100644
--- a/revision.c
+++ b/revision.c
@@ -2464,6 +2464,29 @@ static int rev_opt_glob(const struct option *opt,
 	return 0;
 }
 
+static int rev_opt_no_walk(const struct option *opt,
+			   const char *arg, int unset)
+{
+	struct rev_info *revs  = opt->value;
+
+	BUG_ON_OPT_NEG(unset);
+	if (!arg) {
+		revs->no_walk = REVISION_WALK_NO_WALK_SORTED;
+	} else {
+		/*
+		 * Detached form ("--no-walk X" as opposed to "--no-walk=X")
+		 * not allowed, since the argument is optional.
+		 */
+		if (!strcmp(arg, "sorted"))
+			revs->no_walk = REVISION_WALK_NO_WALK_SORTED;
+		else if (!strcmp(arg, "unsorted"))
+			revs->no_walk = REVISION_WALK_NO_WALK_UNSORTED;
+		else
+			return error(_("invalid argument to --no-walk"));
+	}
+	return 0;
+}
+
 static int rev_opt_not(const struct option *opt,
 		       const char *arg, int unset)
 {
@@ -2572,6 +2595,12 @@ static void make_pseudo_options(struct rev_info *revs)
 		OPT_REV_NOARG(0, "not",
 			      N_("reverse the meaning of '^' for all following revisions"),
 			      rev_opt_not),
+		OPT_REV_OPTARG(0, "no-walk", N_("(sorted|unsorted)"),
+			       N_("only show given commits but do not traverse their ancestors"),
+			       rev_opt_no_walk),
+		OPT_SET_INT_F(0, "do-walk", &revs->no_walk,
+			      N_("override a previous --no-walk"),
+			      0, PARSE_OPT_NONEG),
 		OPT_END()
 	};
 	ALLOC_ARRAY(revs->pseudo_options, ARRAY_SIZE(options));
@@ -2583,7 +2612,6 @@ static int handle_revision_pseudo_opt(const char *submodule,
 				int argc, const char **argv, int *flags)
 {
 	const char *arg = argv[0];
-	const char *optarg;
 	struct ref_store *refs;
 
 	if (submodule) {
@@ -2611,22 +2639,7 @@ static int handle_revision_pseudo_opt(const char *submodule,
 	if (argc)
 		return argc;
 
-	if (!strcmp(arg, "--no-walk")) {
-		revs->no_walk = REVISION_WALK_NO_WALK_SORTED;
-	} else if (skip_prefix(arg, "--no-walk=", &optarg)) {
-		/*
-		 * Detached form ("--no-walk X" as opposed to "--no-walk=X")
-		 * not allowed, since the argument is optional.
-		 */
-		if (!strcmp(optarg, "sorted"))
-			revs->no_walk = REVISION_WALK_NO_WALK_SORTED;
-		else if (!strcmp(optarg, "unsorted"))
-			revs->no_walk = REVISION_WALK_NO_WALK_UNSORTED;
-		else
-			return error("invalid argument to --no-walk");
-	} else if (!strcmp(arg, "--do-walk")) {
-		revs->no_walk = 0;
-	} else if (!strcmp(arg, "--single-worktree")) {
+	if (!strcmp(arg, "--single-worktree")) {
 		revs->single_worktree = 1;
 	} else {
 		return 0;
-- 
2.21.0.1141.gd54ac2cb17

