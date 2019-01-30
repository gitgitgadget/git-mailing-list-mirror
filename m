Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C7E0E1F453
	for <e@80x24.org>; Wed, 30 Jan 2019 09:48:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730137AbfA3Js5 (ORCPT <rfc822;e@80x24.org>);
        Wed, 30 Jan 2019 04:48:57 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:45901 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726406AbfA3Js5 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 30 Jan 2019 04:48:57 -0500
Received: by mail-pl1-f196.google.com with SMTP id a14so10799703plm.12
        for <git@vger.kernel.org>; Wed, 30 Jan 2019 01:48:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=sQk9AT2smGrSAzGg2LXGB/pZY5NLA2Xrmm1iKFp6AOE=;
        b=X37XSIW2Nay+ysrXfsWmntS/n7JpGjSVbJxFqn9UDFh8oeFB6p8MYGU3cYVlfjYPVi
         AFvyh29loG6qpPTMHTEGya/fvHx9KcP603Fla9wwjL0j8L/c1AtKnjOI8NGrxE4fJ+jy
         dDub95JNpicBcNNrMxPdc0xCG73XWVk1E9X+j5kz4GqhpcPDSHlaqjP+MY7PW7O3WUuv
         Asr1ykMAxgTZ0RFBf0z6Z1BjYm2HHBjPmM+FsI7hQe3GdCiRQXg75uFIPRXEnQzSzuMX
         MtHLZudoGsZBtPhnoqmlEx5wvPeh7HoPod37nKhgfQPWazhafsHNV59m6f7+fCoV0zGW
         e4JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=sQk9AT2smGrSAzGg2LXGB/pZY5NLA2Xrmm1iKFp6AOE=;
        b=ZfN61bAzLAsgan2Ut9RMm11bRQPosdTNj8Hlx7l8ZqctaBogqKKcDY5IUTvyDn+qcW
         uIXT5z4b01nMqc9d2VokA27NYINayX4bfPbNRuW1Uk0KNlimAwGty3YrHjSAfaVfJ55K
         wdQoESAGn+dCZOg+WDkdTAasHO9HuaZ/Pu4+2vgJNb/h2k5vRY4mqXnheLHJ/kaIPUd4
         Jw3kJfQ0v4pQT0wU1N4e08D9cqqxEOcJ4j3vNECTbdspaN2x0V/l1YkDOIH4AHa+sjIi
         4hXQy16eRXOVO3wGqEAOdU+sYhd4q9fWmVtTBff7ekNbwaXB1qxaP/aTcaEPHpi0DKGJ
         3jRw==
X-Gm-Message-State: AJcUuke7a8q1Cs3hG1D8SSpm6oJ9opdt/yzQQTxnBpLZl+vK49EPmYLP
        6y4m4Rwa8zzZEJ78Ev0Sgqsl0Bci
X-Google-Smtp-Source: ALg8bN6jqRHbgo34cEqTpH9Do7imfeIEprCfELJt+8TSKuamVDqZ7Zp8BGiShbVc/98nU3obzzXnqg==
X-Received: by 2002:a17:902:f24:: with SMTP id 33mr29979548ply.65.1548841736794;
        Wed, 30 Jan 2019 01:48:56 -0800 (PST)
Received: from ash ([115.72.21.220])
        by smtp.gmail.com with ESMTPSA id s15sm1458144pgv.59.2019.01.30.01.48.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 30 Jan 2019 01:48:56 -0800 (PST)
Received: by ash (sSMTP sendmail emulation); Wed, 30 Jan 2019 16:48:52 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 04/19] checkout: factor out some code in parse_branchname_arg()
Date:   Wed, 30 Jan 2019 16:48:16 +0700
Message-Id: <20190130094831.10420-5-pclouds@gmail.com>
X-Mailer: git-send-email 2.20.1.682.gd5861c6d90
In-Reply-To: <20190130094831.10420-1-pclouds@gmail.com>
References: <20190130094831.10420-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is in preparation for the new command restore, which also
needs to parse opts->source_tree but does not need all the
disambiguation logic.

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 builtin/checkout.c | 51 ++++++++++++++++++++++++++++------------------
 1 file changed, 31 insertions(+), 20 deletions(-)

diff --git a/builtin/checkout.c b/builtin/checkout.c
index f63d864a91..12b7e08d4e 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -1068,6 +1068,34 @@ static int git_checkout_config(const char *var, const char *value, void *cb)
 	return git_xmerge_config(var, value, NULL);
 }
 
+static void setup_new_branch_info_and_source_tree(
+	struct branch_info *new_branch_info,
+	struct checkout_opts *opts,
+	struct object_id *rev,
+	const char *arg)
+{
+	struct tree **source_tree = &opts->source_tree;
+	struct object_id branch_rev;
+
+	new_branch_info->name = arg;
+	setup_branch_path(new_branch_info);
+
+	if (!check_refname_format(new_branch_info->path, 0) &&
+	    !read_ref(new_branch_info->path, &branch_rev))
+		oidcpy(rev, &branch_rev);
+	else
+		new_branch_info->path = NULL; /* not an existing branch */
+
+	new_branch_info->commit = lookup_commit_reference_gently(the_repository, rev, 1);
+	if (!new_branch_info->commit) {
+		/* not a commit */
+		*source_tree = parse_tree_indirect(rev);
+	} else {
+		parse_commit_or_die(new_branch_info->commit);
+		*source_tree = get_commit_tree(new_branch_info->commit);
+	}
+}
+
 static int parse_branchname_arg(int argc, const char **argv,
 				int dwim_new_local_branch_ok,
 				struct branch_info *new_branch_info,
@@ -1075,10 +1103,8 @@ static int parse_branchname_arg(int argc, const char **argv,
 				struct object_id *rev,
 				int *dwim_remotes_matched)
 {
-	struct tree **source_tree = &opts->source_tree;
 	const char **new_branch = &opts->new_branch;
 	int argcount = 0;
-	struct object_id branch_rev;
 	const char *arg;
 	int dash_dash_pos;
 	int has_dash_dash = 0;
@@ -1200,26 +1226,11 @@ static int parse_branchname_arg(int argc, const char **argv,
 	argv++;
 	argc--;
 
-	new_branch_info->name = arg;
-	setup_branch_path(new_branch_info);
-
-	if (!check_refname_format(new_branch_info->path, 0) &&
-	    !read_ref(new_branch_info->path, &branch_rev))
-		oidcpy(rev, &branch_rev);
-	else
-		new_branch_info->path = NULL; /* not an existing branch */
+	setup_new_branch_info_and_source_tree(new_branch_info, opts, rev, arg);
 
-	new_branch_info->commit = lookup_commit_reference_gently(the_repository, rev, 1);
-	if (!new_branch_info->commit) {
-		/* not a commit */
-		*source_tree = parse_tree_indirect(rev);
-	} else {
-		parse_commit_or_die(new_branch_info->commit);
-		*source_tree = get_commit_tree(new_branch_info->commit);
-	}
-
-	if (!*source_tree)                   /* case (1): want a tree */
+	if (!opts->source_tree)                   /* case (1): want a tree */
 		die(_("reference is not a tree: %s"), arg);
+
 	if (!has_dash_dash) {	/* case (3).(d) -> (1) */
 		/*
 		 * Do not complain the most common case
-- 
2.20.1.682.gd5861c6d90

