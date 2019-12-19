Return-Path: <SRS0=FxFb=2J=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C53BC2D0D3
	for <git@archiver.kernel.org>; Thu, 19 Dec 2019 18:02:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4CBD224676
	for <git@archiver.kernel.org>; Thu, 19 Dec 2019 18:02:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N/Fq5HJ8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727066AbfLSSCQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 19 Dec 2019 13:02:16 -0500
Received: from mail-ed1-f50.google.com ([209.85.208.50]:42937 "EHLO
        mail-ed1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727031AbfLSSCO (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 19 Dec 2019 13:02:14 -0500
Received: by mail-ed1-f50.google.com with SMTP id e10so5764025edv.9
        for <git@vger.kernel.org>; Thu, 19 Dec 2019 10:02:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=Hebc/sJkecnZEkxOEWO9T5cMHBN6Q7V6uzSoDRnmRyA=;
        b=N/Fq5HJ87hFERXYLPxT97baVNLwqxOiyiaMT0SNpYnX11j7YC0NpFgQ23v2ngdwGEH
         qeN5KzAJX2gkQMSA3leOy7/HVakSez73j4t3YWeYzSV97u0kKA9EccdbYsnroH6UEjYY
         P6avljPW/7AcOwO+uW7hpHbb9dT/ZXpX0PDJXbqcRhiBXqKeUZ5gNAtCNMiOQ/hp5dkA
         GSyz/m7qnl3GRMOiTwCtbIPn3oSfmkZJAPN74fO8TbBx669BRl84TwSpXVvUtOn1JNQU
         HG58uc+GzEuCjbjZmBz13+aVDwL09iHPIz51b9l6HRMEeTmBqwqv3T2b44GlYEq3jdgd
         lxUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=Hebc/sJkecnZEkxOEWO9T5cMHBN6Q7V6uzSoDRnmRyA=;
        b=IvL3h//Oo9847UfSg6HpqGdVgAxieRrohDgC+8qmjWfeMxs4gzVRM52faZrmAUQoz8
         jrfRUqQYtGUREAC+qGM9dcMnb86NQNclfkL/YbTRrDV/UI3m/u9s3afuBnQSXno34Bdp
         eL/uWsQl4f+1qCzO68bMx9f69ldZCEniboRS25B6/g1kHKXa8A4TyjpRH3Ek/QOyV3qR
         u1J7aW5PNvHEe0InzRxsDTHUJg28dxLuzM8Nc11kLKjVNfSKfW+9a9G0udVlodBIMjRE
         Re6n7kuIF1/x869bJVCuu/peBWUbOzOuMlz4pkm/e225H212YBvY+gIuRVYjStIgeL/b
         d9cg==
X-Gm-Message-State: APjAAAWZntQUh+18IGSr0fsgIu/p5/p4o1l9KD0dK+Jvc+HgaI2yWbVh
        LbrBJnwBgzrm/sUF282gFfGYhkTp
X-Google-Smtp-Source: APXvYqyloMAhcmC5QVVxisSUbvuNYAzq47kV29J9LJu3fXwUcRx68gmbmx71yPqAdZbxcvWQRNmKpA==
X-Received: by 2002:a50:f012:: with SMTP id r18mr6816814edl.97.1576778532757;
        Thu, 19 Dec 2019 10:02:12 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id w10sm559491eds.69.2019.12.19.10.02.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 19 Dec 2019 10:02:12 -0800 (PST)
Message-Id: <7989f0c5cf813010d8034e932ee78959c7b39c95.1576778515.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.490.v3.git.1576778515.gitgitgadget@gmail.com>
References: <pull.490.v2.git.1576511287.gitgitgadget@gmail.com>
        <pull.490.v3.git.1576778515.gitgitgadget@gmail.com>
From:   "Alexandr Miloslavskiy via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 19 Dec 2019 18:01:52 +0000
Subject: [PATCH v3 15/18] parse_branchname_arg(): update code comments
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Phillip Wood <phillip.wood123@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Derrick Stolee <stolee@gmail.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>,
        Alexandr Miloslavskiy <alexandr.miloslavskiy@syntevo.com>,
        Junio C Hamano <gitster@pobox.com>,
        Alexandr Miloslavskiy <alexandr.miloslavskiy@syntevo.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Alexandr Miloslavskiy <alexandr.miloslavskiy@syntevo.com>

These parts repeat git documentation:
    ... if <something> is A...B <...>
    ... remote named in checkout.defaultRemote ...

Some parts repeat the code below. With next patch, code will be easier
to understand, so this is no longer needed.

This is a separate patch to reduce the amount of diffs in next patch.

Signed-off-by: Alexandr Miloslavskiy <alexandr.miloslavskiy@syntevo.com>
---
 builtin/checkout.c | 86 +++++++++++-----------------------------------
 1 file changed, 21 insertions(+), 65 deletions(-)

diff --git a/builtin/checkout.c b/builtin/checkout.c
index 63f4bb4da6..95a8e08793 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -1158,45 +1158,21 @@ static int parse_branchname_arg(int argc, const char **argv,
 	int i;
 
 	/*
-	 * case 1: git checkout <ref> -- [<paths>]
-	 *
-	 *   <ref> must be a valid tree, everything after the '--' must be
-	 *   a path.
-	 *
-	 * case 2: git checkout -- [<paths>]
-	 *
-	 *   everything after the '--' must be paths.
-	 *
-	 * case 3: git checkout <something> [--]
-	 *
-	 *   (a) If <something> is a commit, that is to
-	 *       switch to the branch or detach HEAD at it.  As a special case,
-	 *       if <something> is A...B (missing A or B means HEAD but you can
-	 *       omit at most one side), and if there is a unique merge base
-	 *       between A and B, A...B names that merge base.
-	 *
-	 *   (b) If <something> is _not_ a commit, either "--" is present
-	 *       or <something> is not a path, no -t or -b was given, and
-	 *       and there is a tracking branch whose name is <something>
-	 *       in one and only one remote (or if the branch exists on the
-	 *       remote named in checkout.defaultRemote), then this is a
-	 *       short-hand to fork local <something> from that
-	 *       remote-tracking branch.
-	 *
-	 *   (c) Otherwise, if "--" is present, treat it like case (1).
-	 *
-	 *   (d) Otherwise :
-	 *       - if it's a reference, treat it like case (1)
-	 *       - else if it's a path, treat it like case (2)
-	 *       - else: fail.
-	 *
-	 * case 4: git checkout <something> <paths>
-	 *
-	 *   The first argument must not be ambiguous.
-	 *   - If it's *only* a reference, treat it like case (1).
-	 *   - If it's only a path, treat it like case (2).
-	 *   - else: fail.
-	 *
+	 * Resolve ambiguity where argv[0] may be <pathspec> or <commit>.
+	 * High-level approach is:
+	 * 1) Use various things to reduce ambiguity, examples:
+	 *    * '--' is present
+	 *    * command doesn't accept <pathspec>
+	 *    * additional options like '-b' were given
+	 * 2) If ambiguous and matches both existing <commit> and existing
+	 *    file, complain. However, in 1-argument 'git checkout <arg>'
+	 *    treat as <commit> to avoid annoying users.
+	 * 3) Otherwise, if it matches some existing <commit>, treat as
+	 *    <commit>.
+	 * 4) Otherwise, if it matches a remote branch, and it's considered
+	 *    reasonable to DWIM to create a local branch from remote branch,
+	 *    do that and proceed with (2)(3).
+	 * 5) Otherwise, let caller proceed with <pathspec> interpretation.
 	 */
 	if (!argc)
 		return 0;
@@ -1218,9 +1194,9 @@ static int parse_branchname_arg(int argc, const char **argv,
 
 	if (opts->accept_pathspec) {
 		if (dash_dash_pos == 0)
-			return 1; /* case (2) */
+			return 1;
 		else if (dash_dash_pos == 1)
-			arg0_cant_be_pathspec = 1; /* case (3) or (1) */
+			arg0_cant_be_pathspec = 1;
 		else if (dash_dash_pos >= 2)
 			die(_("only one reference expected, %d given."), dash_dash_pos);
 	}
@@ -1231,14 +1207,6 @@ static int parse_branchname_arg(int argc, const char **argv,
 		arg = "@{-1}";
 
 	if (get_oid_mb(arg, rev)) {
-		/*
-		 * Either case (3) or (4), with <something> not being
-		 * a commit, or an attempt to use case (1) with an
-		 * invalid ref.
-		 *
-		 * It's likely an error, but we need to find out if
-		 * we should auto-create the branch, case (3).(b).
-		 */
 		int recover_with_dwim = dwim_new_local_branch_ok;
 
 		int could_be_checkout_paths = !arg0_cant_be_pathspec &&
@@ -1247,10 +1215,6 @@ static int parse_branchname_arg(int argc, const char **argv,
 		if (!arg0_cant_be_pathspec && !no_wildcard(arg))
 			recover_with_dwim = 0;
 
-		/*
-		 * Accept "git checkout foo", "git checkout foo --"
-		 * and "git switch foo" as candidates for dwim.
-		 */
 		if (!(argc == 1 && dash_dash_pos == -1) &&
 		    !(argc == 2 && dash_dash_pos == 1) &&
 		    opts->accept_pathspec)
@@ -1262,7 +1226,7 @@ static int parse_branchname_arg(int argc, const char **argv,
 			if (remote) {
 				*new_branch = arg;
 				arg = remote;
-				/* DWIMmed to create local branch, case (3).(b) */
+				/* DWIMmed to create local branch */
 			} else {
 				recover_with_dwim = 0;
 			}
@@ -1277,19 +1241,11 @@ static int parse_branchname_arg(int argc, const char **argv,
 
 	setup_new_branch_info_and_source_tree(new_branch_info, opts, rev, arg);
 
-	if (!opts->source_tree)                   /* case (1): want a tree */
+	if (!opts->source_tree)
 		die(_("reference is not a tree: %s"), arg);
 
-	if (!arg0_cant_be_pathspec) {	/* case (3).(d) -> (1) */
-		/*
-		 * Do not complain the most common case
-		 *	git checkout branch
-		 * even if there happen to be a file called 'branch';
-		 * it would be extremely annoying.
-		 */
-		if (argc > 1)
-			verify_non_filename(opts->prefix, arg);
-	}
+	if (!arg0_cant_be_pathspec && argc > 1)
+		verify_non_filename(opts->prefix, arg);
 
 	return (opts->accept_pathspec && dash_dash_pos == 1) ? 2 : 1;
 }
-- 
gitgitgadget

