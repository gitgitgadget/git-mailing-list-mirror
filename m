Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CDB5F1F6DC
	for <e@80x24.org>; Wed, 25 Jan 2017 12:51:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751656AbdAYMvi (ORCPT <rfc822;e@80x24.org>);
        Wed, 25 Jan 2017 07:51:38 -0500
Received: from mail-pf0-f195.google.com ([209.85.192.195]:33979 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751645AbdAYMvh (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 25 Jan 2017 07:51:37 -0500
Received: by mail-pf0-f195.google.com with SMTP id y143so14375741pfb.1
        for <git@vger.kernel.org>; Wed, 25 Jan 2017 04:51:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=XB0rlXkki1x96jUhDnGgBdbB0q/YOYhQ2feVNv2dso4=;
        b=K51/CQXntKW+xJLv1oXfIp4DxQ9yME49HKmA02kby9o0U0Ax8ewQ0v/BUZYJQOldAn
         SDYOT+3A55vOwRuWhaf5h9lMP8nF1isiaBRLUFIFJy5mrxB/gNUICRRLPJ7h8KGg2MUA
         S09SVyTGIL7BEap3y8WaFv3pRJc1dBRfB/7xtD9UOJwmjErfkTmatCZ0Oi9RjgCjD37D
         8h0uFVheIbtE27WatasY8LrLjDldw6BkevJRrsLD73GFY+4eriFxXCY+Bg0xssiC2l4t
         Bu4bs4nyIeWpQ7+0aSQDs882iVffWyXG8LYYiAdWKt1Qu/PGRfWVtuvaeut439CXPWU+
         WZ2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=XB0rlXkki1x96jUhDnGgBdbB0q/YOYhQ2feVNv2dso4=;
        b=AjFsnk3lHuMbsux6h+OhtM6nJJwEGf43001QmwvP2/N8FTa72/sUUcE4TsuM5L+i0P
         d0sHp6aT1DLv/CUb+T1ZYhSnpCZXABVgkCSiBXfeu0+Fc/9F4V2eyIYMg5+ZIiaR9FZm
         N/pr33QSvST9dyjLTDi7N7hhTzJM0Cs3ydgZ0bUtTedatnK6P830lBOatUSECIu2eRDw
         6M4zeaaH3HhlUOA3oFFa7SVRU1OmhafkY+Q2ZIkbyFJQityJF9w02xK0xMqGiLLLTKtP
         plncgZeoCOypfABoYrMkYNw2Xoclk6My1WoYrgFfX1INYkiUpTCohotPEMvMJMEesu6k
         fnAg==
X-Gm-Message-State: AIkVDXKuib1lJhLXSLL+KvM5aLi454JDwmAWLTwW75L9aG0By/sqnEQxIudLhUr2Tv7kUA==
X-Received: by 10.84.232.197 with SMTP id x5mr3441941plm.111.1485348691090;
        Wed, 25 Jan 2017 04:51:31 -0800 (PST)
Received: from ash ([115.72.179.24])
        by smtp.gmail.com with ESMTPSA id g70sm1141516pfb.50.2017.01.25.04.51.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 25 Jan 2017 04:51:30 -0800 (PST)
Received: by ash (sSMTP sendmail emulation); Wed, 25 Jan 2017 19:51:26 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, jacob.keller@gmail.com,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 2/5] revision.c: group ref selection options together
Date:   Wed, 25 Jan 2017 19:50:51 +0700
Message-Id: <20170125125054.7422-3-pclouds@gmail.com>
X-Mailer: git-send-email 2.11.0.157.gd943d85
In-Reply-To: <20170125125054.7422-1-pclouds@gmail.com>
References: <20170121140806.tjs6wad3x4srdv3q@sigill.intra.peff.net>
 <20170125125054.7422-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

These options have on thing in common: when specified right after
--exclude, they will de-select refs instead of selecting them by
default.

This change makes it possible to introduce new options that use these
options in the same way as --exclude. Such an option would just
implement something like handle_refs_pseudo_opt().

parse_ref_selector_option() is taken out of handle_refs_pseudo_opt() so
that similar functions like handle_refs_pseudo_opt() are forced to
handle all ref selector options, not skipping some by mistake, which may
revert the option back to default behavior (rev selection).

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 revision.c | 134 +++++++++++++++++++++++++++++++++++++++++++++----------------
 1 file changed, 100 insertions(+), 34 deletions(-)

diff --git a/revision.c b/revision.c
index b37dbec378..6ebd38d1c8 100644
--- a/revision.c
+++ b/revision.c
@@ -2059,6 +2059,103 @@ static int for_each_good_bisect_ref(const char *submodule, each_ref_fn fn, void
 	return for_each_bisect_ref(submodule, fn, cb_data, term_good);
 }
 
+enum ref_selector {
+	REF_SELECT_NONE,
+	REF_SELECT_ALL,
+	REF_SELECT_BRANCHES,
+	REF_SELECT_TAGS,
+	REF_SELECT_REMOTES,
+	REF_SELECT_BY_GLOB
+};
+
+static enum ref_selector parse_ref_selector_option(int argc, const char **argv,
+						   const char **optarg,
+						   int *argcount)
+{
+	const char *arg = argv[0];
+
+	*optarg = NULL;
+
+	if (!strcmp(arg, "--all"))
+		return REF_SELECT_ALL;
+	else if (!strcmp(arg, "--branches") ||
+		 skip_prefix(arg, "--branches=", optarg))
+		return REF_SELECT_BRANCHES;
+	else if (!strcmp(arg, "--tags") ||
+		 skip_prefix(arg, "--tags=", optarg))
+		return REF_SELECT_TAGS;
+	else if (!strcmp(arg, "--remotes") ||
+		 skip_prefix(arg, "--remotes=", optarg))
+		return REF_SELECT_REMOTES;
+	else if ((*argcount = parse_long_opt("glob", argv, optarg)))
+		return REF_SELECT_BY_GLOB;
+
+	return REF_SELECT_NONE;
+}
+
+static int handle_refs_pseudo_opt(const char *submodule,
+				  struct rev_info *revs,
+				  int argc, const char **argv,
+				  int *flags, int *ret)
+{
+	struct all_refs_cb cb;
+	const char *optarg = NULL;
+	int argcount;
+	enum ref_selector selector;
+
+	selector = parse_ref_selector_option(argc, argv, &optarg, &argcount);
+
+	if (optarg)
+		init_all_refs_cb(&cb, revs, *flags);
+	*ret = 1;
+
+	switch (selector) {
+	case REF_SELECT_ALL:
+		handle_refs(submodule, revs, *flags, for_each_ref_submodule);
+		handle_refs(submodule, revs, *flags, head_ref_submodule);
+		break;
+
+	case REF_SELECT_BRANCHES:
+		if (optarg)
+			for_each_glob_ref_in(handle_one_ref, optarg,
+					     "refs/heads/", &cb);
+		else
+			handle_refs(submodule, revs, *flags,
+				    for_each_branch_ref_submodule);
+		break;
+
+	case REF_SELECT_TAGS:
+		if (optarg)
+			for_each_glob_ref_in(handle_one_ref, optarg,
+					     "refs/tags/", &cb);
+		else
+			handle_refs(submodule, revs, *flags,
+				    for_each_tag_ref_submodule);
+		break;
+
+	case REF_SELECT_REMOTES:
+		if (optarg)
+			for_each_glob_ref_in(handle_one_ref, optarg,
+					     "refs/remotes/", &cb);
+		else
+			handle_refs(submodule, revs, *flags,
+				    for_each_remote_ref_submodule);
+		break;
+
+	case REF_SELECT_BY_GLOB:
+		init_all_refs_cb(&cb, revs, *flags);
+		for_each_glob_ref(handle_one_ref, optarg, &cb);
+		*ret = argcount;
+		break;
+
+	case REF_SELECT_NONE:
+		return 0;
+	}
+
+	clear_ref_exclusion(&revs->ref_excludes);
+	return 1;
+}
+
 static int handle_revision_pseudo_opt(const char *submodule,
 				struct rev_info *revs,
 				int argc, const char **argv, int *flags)
@@ -2066,6 +2163,7 @@ static int handle_revision_pseudo_opt(const char *submodule,
 	const char *arg = argv[0];
 	const char *optarg;
 	int argcount;
+	int ret;
 
 	/*
 	 * NOTE!
@@ -2077,48 +2175,16 @@ static int handle_revision_pseudo_opt(const char *submodule,
 	 * When implementing your new pseudo-option, remember to
 	 * register it in the list at the top of handle_revision_opt.
 	 */
-	if (!strcmp(arg, "--all")) {
-		handle_refs(submodule, revs, *flags, for_each_ref_submodule);
-		handle_refs(submodule, revs, *flags, head_ref_submodule);
-		clear_ref_exclusion(&revs->ref_excludes);
-	} else if (!strcmp(arg, "--branches")) {
-		handle_refs(submodule, revs, *flags, for_each_branch_ref_submodule);
-		clear_ref_exclusion(&revs->ref_excludes);
+	if (handle_refs_pseudo_opt(submodule, revs, argc, argv, flags, &ret)) {
+		return ret;
 	} else if (!strcmp(arg, "--bisect")) {
 		read_bisect_terms(&term_bad, &term_good);
 		handle_refs(submodule, revs, *flags, for_each_bad_bisect_ref);
 		handle_refs(submodule, revs, *flags ^ (UNINTERESTING | BOTTOM), for_each_good_bisect_ref);
 		revs->bisect = 1;
-	} else if (!strcmp(arg, "--tags")) {
-		handle_refs(submodule, revs, *flags, for_each_tag_ref_submodule);
-		clear_ref_exclusion(&revs->ref_excludes);
-	} else if (!strcmp(arg, "--remotes")) {
-		handle_refs(submodule, revs, *flags, for_each_remote_ref_submodule);
-		clear_ref_exclusion(&revs->ref_excludes);
-	} else if ((argcount = parse_long_opt("glob", argv, &optarg))) {
-		struct all_refs_cb cb;
-		init_all_refs_cb(&cb, revs, *flags);
-		for_each_glob_ref(handle_one_ref, optarg, &cb);
-		clear_ref_exclusion(&revs->ref_excludes);
-		return argcount;
 	} else if ((argcount = parse_long_opt("exclude", argv, &optarg))) {
 		add_ref_exclusion(&revs->ref_excludes, optarg);
 		return argcount;
-	} else if (starts_with(arg, "--branches=")) {
-		struct all_refs_cb cb;
-		init_all_refs_cb(&cb, revs, *flags);
-		for_each_glob_ref_in(handle_one_ref, arg + 11, "refs/heads/", &cb);
-		clear_ref_exclusion(&revs->ref_excludes);
-	} else if (starts_with(arg, "--tags=")) {
-		struct all_refs_cb cb;
-		init_all_refs_cb(&cb, revs, *flags);
-		for_each_glob_ref_in(handle_one_ref, arg + 7, "refs/tags/", &cb);
-		clear_ref_exclusion(&revs->ref_excludes);
-	} else if (starts_with(arg, "--remotes=")) {
-		struct all_refs_cb cb;
-		init_all_refs_cb(&cb, revs, *flags);
-		for_each_glob_ref_in(handle_one_ref, arg + 10, "refs/remotes/", &cb);
-		clear_ref_exclusion(&revs->ref_excludes);
 	} else if (!strcmp(arg, "--reflog")) {
 		add_reflogs_to_pending(revs, *flags);
 	} else if (!strcmp(arg, "--indexed-objects")) {
-- 
2.11.0.157.gd943d85

