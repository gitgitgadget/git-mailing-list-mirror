Return-Path: <SRS0=/qQH=ZU=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CB19C43141
	for <git@archiver.kernel.org>; Thu, 28 Nov 2019 19:32:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D04E921774
	for <git@archiver.kernel.org>; Thu, 28 Nov 2019 19:32:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LuExml/j"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726731AbfK1TcZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 28 Nov 2019 14:32:25 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:37036 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726716AbfK1TcY (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 28 Nov 2019 14:32:24 -0500
Received: by mail-wm1-f67.google.com with SMTP id f129so12747553wmf.2
        for <git@vger.kernel.org>; Thu, 28 Nov 2019 11:32:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=gWm3qRU8/b9EA8Ccj/0mlX2J5PcJaCewLwWdbDLd69A=;
        b=LuExml/jlPXLEYQ5zypqFhyfmwNtdlSm7YqeHLqgLklGEeGjIb31mEjm4lr40oPU9H
         jPykyN4VpxpQxcRxt9xOpjG60l/PaRlXHA97wKBAWbJ5VlBQU1XcWCOpRN5yAST5XiQ2
         F8+3iftzIXPfgECI/zmBQkBrgWhKwNckzjOIYPq+6u24AfXlP5jTzuiIjQe9wMFOyD47
         5PLHdZ2u74qsTlyFV932G1d7t1G3DbXDobimMTAobVjYl6pqb/ApE1GwMXyglH4BSVGl
         Xi6uEJVn7AOQx0pngeyR+aDXR5YT2SaPifRtqv9OS+k1UDqAuqMCRs+FhsJUtgelbjur
         m2Fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=gWm3qRU8/b9EA8Ccj/0mlX2J5PcJaCewLwWdbDLd69A=;
        b=jhhFFNAirfec7YoOX3LRaV+pbbab7UjIjZoDbiMR3UdsArVnuwxR+PWHCmcVs5HuiV
         JJGQY1I2a+BMOqSHURU7kXK7Qaj4jkb6qodsVSeozCilzOzEbDEuSoADWJ7bYe4w8nfU
         iU9bxoZLNYSs5LpEUl/KMuu5xOJXLFUR3cVi8yhyAxEBJjUTZU6VIcFWyPk0/iMErc3c
         vA0T38QPaCB7F87gD6VaWsvLsVCM/xuEW4ILX6PJhdJfwLoyWTSiGXQ2n/11QXc+XDAB
         UUvA4yOnbSxjPw86OZdVS6aJ16Tt+QL3+pwlMuEKKXyeuBlcn4iQxPqi3faVQ2SkEDaC
         HO6w==
X-Gm-Message-State: APjAAAVLIg+sG51096ODpsozR0JnobUhAqBJ22/cZFmv2y4DWMiNiACu
        EM5l4l4V5YGCHnMT9sFEHDA526lg
X-Google-Smtp-Source: APXvYqzYtn+uAO1zNSqGbz8QtJ+Kn9A5Q1a3qqeo7qu+K077pWPwDPzace4aEc7sNs5I34Bt62tzgg==
X-Received: by 2002:a1c:2703:: with SMTP id n3mr11453711wmn.94.1574969542591;
        Thu, 28 Nov 2019 11:32:22 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id q15sm24727237wrs.91.2019.11.28.11.32.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 28 Nov 2019 11:32:22 -0800 (PST)
Message-Id: <45db345304d5771017026a32d96251c5c5c47f11.1574969538.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.479.git.1574969538.gitgitgadget@gmail.com>
References: <pull.479.git.1574969538.gitgitgadget@gmail.com>
From:   "Alexandr Miloslavskiy via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 28 Nov 2019 19:32:17 +0000
Subject: [PATCH 4/5] parse_branchname_arg(): refactor the decision making
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Alexandr Miloslavskiy <alexandr.miloslavskiy@syntevo.com>,
        Junio C Hamano <gitster@pobox.com>,
        Alexandr Miloslavskiy <alexandr.miloslavskiy@syntevo.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Alexandr Miloslavskiy <alexandr.miloslavskiy@syntevo.com>

Make it easier to understand which branches handle which cases.

Drop obfuscated variable `has_dash_dash` which also took
`opts->accept_pathspec` into account, making it pretty hard to reason
about code, especially when used together with `argc` and
`opts->accept_pathspec` here:

	if (!(argc == 1 && !has_dash_dash) &&
		!(argc == 2 && has_dash_dash) &&
		opts->accept_pathspec)
		recover_with_dwim = 0;

Avoid double-negation in the code mentioned above ("it is not OK to
proceed if it's not one of those cases").

Avoid hard-to-understand condition `opts->accept_pathspec` in the code
mentioned above.

There are some minor die() message changes for:
`git switch <commit> <unexpected>`
`git switch <commit> -- <unexpected>`

Signed-off-by: Alexandr Miloslavskiy <alexandr.miloslavskiy@syntevo.com>
---
 builtin/checkout.c | 71 +++++++++++++++++++++++++++-------------------
 1 file changed, 42 insertions(+), 29 deletions(-)

diff --git a/builtin/checkout.c b/builtin/checkout.c
index 723aaca0ef..8f679d1b6a 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -1122,9 +1122,8 @@ static int parse_branchname_arg(int argc, const char **argv,
 {
 	const char **new_branch = &opts->new_branch;
 	const char *arg;
-	int dash_dash_pos;
-	int has_dash_dash = 0, expect_commit_only = 0;
-	int i;
+	int dash_dash_pos, i;
+	int recover_with_dwim, expect_commit_only;
 
 	/*
 	 * Resolve ambiguity where argv[0] may be <pathspec> or <commit>.
@@ -1143,15 +1142,7 @@ static int parse_branchname_arg(int argc, const char **argv,
 	 *    do that and proceed with (2)(3).
 	 * 5) Otherwise, let caller proceed with <pathspec> interpretation.
 	 */
-	if (!argc)
-		return 0;
-
-	if (!opts->accept_pathspec) {
-		if (argc > 1)
-			die(_("only one reference expected"));
-		has_dash_dash = 1; /* helps disambiguate */
-	}
-
+	 
 	arg = argv[0];
 	dash_dash_pos = -1;
 	for (i = 0; i < argc; i++) {
@@ -1161,17 +1152,46 @@ static int parse_branchname_arg(int argc, const char **argv,
 		}
 	}
 
-	if (opts->accept_pathspec) {
-	    if (dash_dash_pos == 0)
-		    return 1;
-	    else if (dash_dash_pos == 1)
-		    has_dash_dash = 1;
-	    else if (dash_dash_pos >= 2)
-		    die(_("only one reference expected, %d given."), dash_dash_pos);
-	}
+	if (dash_dash_pos == -1) {
+		if (argc == 0) {
+			/* 'git checkout/switch/restore' */
+			return 0;
+		} else if (argc == 1) {
+			/* 'git checkout/switch/restore <something>' */
+			recover_with_dwim = dwim_new_local_branch_ok;
+		} else if (!opts->accept_pathspec) {
+			/* 'git switch <commit> <unexpected> [...]' */
+			die(_("only one reference expected, %d given."), argc);
+		} else {
+			/* 'git checkout/restore <something> <pathspec> [...]' */
+			recover_with_dwim = 0;
+		}
+
+		/* Absence of '--' leaves <pathspec>/<commit> ambiguity */
+		expect_commit_only = !opts->accept_pathspec;
+	} else if (dash_dash_pos == 0) {
+		/* 'git checkout/switch/restore -- [...]' */
+		return 1;  /* Eat '--' */
+	} else if (dash_dash_pos == 1) {
+		if (!opts->accept_pathspec) {
+			/* 'git switch <commit> -- [...]' */
+			die(_("incompatible with pathspec arguments"));
+		}
 
-	if (has_dash_dash)
-	    expect_commit_only = 1;
+		if (argc == 2) {
+			/* 'git checkout/restore <commit> --' */
+			recover_with_dwim = dwim_new_local_branch_ok;
+		} else {
+			/* 'git checkout/restore <commit> -- <pathspec> [...]' */
+			recover_with_dwim = 0;
+		}
+
+		/* Presence of '--' makes it certain that arg is <commit> */
+		expect_commit_only = 1;
+	} else {
+		/* 'git checkout/switch/restore <commit> <unxpected> [...] -- [...]' */
+		die(_("only one reference expected, %d given."), dash_dash_pos);
+	}
 
 	opts->count_checkout_paths = !opts->quiet && !expect_commit_only;
 
@@ -1179,19 +1199,12 @@ static int parse_branchname_arg(int argc, const char **argv,
 		arg = "@{-1}";
 
 	if (get_oid_mb(arg, rev)) {
-		int recover_with_dwim = dwim_new_local_branch_ok;
-
 		int could_be_checkout_paths = !expect_commit_only &&
 			check_filename(opts->prefix, arg);
 
 		if (!expect_commit_only && !no_wildcard(arg))
 			recover_with_dwim = 0;
 
-		if (!(argc == 1 && !has_dash_dash) &&
-		    !(argc == 2 && has_dash_dash) &&
-		    opts->accept_pathspec)
-			recover_with_dwim = 0;
-
 		if (recover_with_dwim) {
 			const char *remote = unique_tracking_name(arg, rev,
 								  dwim_remotes_matched);
-- 
gitgitgadget

