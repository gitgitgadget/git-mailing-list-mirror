Return-Path: <SRS0=PvcO=2G=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C6FBC2D0CD
	for <git@archiver.kernel.org>; Mon, 16 Dec 2019 15:48:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4DCDF20717
	for <git@archiver.kernel.org>; Mon, 16 Dec 2019 15:48:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LpD2eCq0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728553AbfLPPsV (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 16 Dec 2019 10:48:21 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:53776 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728482AbfLPPsT (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 16 Dec 2019 10:48:19 -0500
Received: by mail-wm1-f66.google.com with SMTP id m24so5873313wmc.3
        for <git@vger.kernel.org>; Mon, 16 Dec 2019 07:48:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=1ZR/EapFp47sLr2IAonDutw8/BPi1HewBBrcBuE2Kfg=;
        b=LpD2eCq0El7fK7fpILnHJCLHNKP1gmbrR4r8IllL3AagPEVYEQ+CLR4bEutUqncQOE
         j/bGQu3QgAJ/Y6EkKWxPOu++cZ0ak1iA6s2qNZgcGlTEJVGngW0PDOWwNyO5pxtc3B6p
         7dixFagtFE+Rp9rApiws1aNLQ0gaWWCbYTjXr5IgZssi250QTpY/oFccJwYkDrdoHy9c
         dk6h4MKICy51OjRtTEk91cdgnyDXecKo/gPCAWYwxg8VJEEVsx4Al1s0X2lHE5D8xC17
         7x+E+LDZzzI7vzUI83AClBW71eLN7xTAQlRgM9XmWWuyIEVGYnlIWxbtImDoiO0KidGp
         supg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=1ZR/EapFp47sLr2IAonDutw8/BPi1HewBBrcBuE2Kfg=;
        b=SI9pKIgVhHCvEITDW1XEBOXxB909To0ehwYPF0mL/NTzOKw8C/PEVelBth4eBTCoBn
         aprMOhjZrntWsE4ULz5Ep/vIKIxZ37JZOc1/7CbVa43vlhNMbYECnxmWN5xWZntRsucY
         Uk4ve8XC1dWV0vJwV1ote3cyLdRJZR+BHv1kY4dGWF4y9hZAOSodq2Uh3xZg3rDH7BxJ
         X079b1jo7HKyJMY4H0Qin84hOpjC8M9IDHj3yJWzC5PYUx0t/xkm/cr06r7b4vMa2bxD
         6KUDYSS+DBHL4hrgCMXapodwMh7MViThL6FnynEdhawwnfIi2mXC0wn7Hh8V11hKb/qM
         STOw==
X-Gm-Message-State: APjAAAUkqpFxR/3GiuIRFBXo+FM0CPHLq4nGDzGu/pDEX2P6tuhMZcaM
        wWPiCbpjnuQi//WlUJmLPJIWle6u
X-Google-Smtp-Source: APXvYqxf/Tbf9t9GUHveWVYYCryjLmwJ3ScA/6xPju+wcQDE0VwlzngQdfa1NImKtpTmdpOztIPmxg==
X-Received: by 2002:a1c:e909:: with SMTP id q9mr32294835wmc.30.1576511297587;
        Mon, 16 Dec 2019 07:48:17 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id t190sm13038037wmt.44.2019.12.16.07.48.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 16 Dec 2019 07:48:17 -0800 (PST)
Message-Id: <2350dc282e15f42afaf582cbf1551d72aa17da05.1576511287.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.490.v2.git.1576511287.gitgitgadget@gmail.com>
References: <pull.490.git.1576161385.gitgitgadget@gmail.com>
        <pull.490.v2.git.1576511287.gitgitgadget@gmail.com>
From:   "Alexandr Miloslavskiy via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 16 Dec 2019 15:48:02 +0000
Subject: [PATCH v2 14/18] parse_branchname_arg(): introduce expect_commit_only
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

`has_dash_dash` unexpectedly takes `opts->accept_pathspec` into account.
While this may sound clever at first sight, it becomes pretty hard to
reason (and not be a victim) about code, especially in combination with
`argc` here:

	if (!(argc == 1 && !has_dash_dash) &&
	    !(argc == 2 && has_dash_dash) &&
	    opts->accept_pathspec)
		recover_with_dwim = 0;

Introduce a new non-obfuscated variable to reduce the amount of diffs in
next patch.

This should not change behavior in any way.

Signed-off-by: Alexandr Miloslavskiy <alexandr.miloslavskiy@syntevo.com>
---
 builtin/checkout.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/builtin/checkout.c b/builtin/checkout.c
index f35fe2cc26..bd0efa9140 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -1154,7 +1154,7 @@ static int parse_branchname_arg(int argc, const char **argv,
 	const char **new_branch = &opts->new_branch;
 	const char *arg;
 	int dash_dash_pos;
-	int has_dash_dash = 0;
+	int has_dash_dash = 0, expect_commit_only = 0;
 	int i;
 
 	/*
@@ -1225,7 +1225,10 @@ static int parse_branchname_arg(int argc, const char **argv,
 		    die(_("only one reference expected, %d given."), dash_dash_pos);
 	}
 
-	opts->count_checkout_paths = !opts->quiet && !has_dash_dash;
+	if (has_dash_dash)
+	    expect_commit_only = 1;
+
+	opts->count_checkout_paths = !opts->quiet && !expect_commit_only;
 
 	if (!strcmp(arg, "-"))
 		arg = "@{-1}";
@@ -1241,10 +1244,10 @@ static int parse_branchname_arg(int argc, const char **argv,
 		 */
 		int recover_with_dwim = dwim_new_local_branch_ok;
 
-		int could_be_checkout_paths = !has_dash_dash &&
+		int could_be_checkout_paths = !expect_commit_only &&
 			check_filename(opts->prefix, arg);
 
-		if (!has_dash_dash && !no_wildcard(arg))
+		if (!expect_commit_only && !no_wildcard(arg))
 			recover_with_dwim = 0;
 
 		/*
@@ -1269,7 +1272,7 @@ static int parse_branchname_arg(int argc, const char **argv,
 		}
 
 		if (!recover_with_dwim) {
-			if (has_dash_dash)
+			if (expect_commit_only)
 				die(_("invalid reference: %s"), arg);
 			return 0;
 		}
@@ -1280,7 +1283,7 @@ static int parse_branchname_arg(int argc, const char **argv,
 	if (!opts->source_tree)                   /* case (1): want a tree */
 		die(_("reference is not a tree: %s"), arg);
 
-	if (!has_dash_dash) {	/* case (3).(d) -> (1) */
+	if (!expect_commit_only) {	/* case (3).(d) -> (1) */
 		/*
 		 * Do not complain the most common case
 		 *	git checkout branch
-- 
gitgitgadget

