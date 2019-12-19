Return-Path: <SRS0=FxFb=2J=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26F2EC43603
	for <git@archiver.kernel.org>; Thu, 19 Dec 2019 18:02:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EB1782465E
	for <git@archiver.kernel.org>; Thu, 19 Dec 2019 18:02:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LbyM6enL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727102AbfLSSCT (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 19 Dec 2019 13:02:19 -0500
Received: from mail-ed1-f65.google.com ([209.85.208.65]:40439 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726996AbfLSSCQ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 19 Dec 2019 13:02:16 -0500
Received: by mail-ed1-f65.google.com with SMTP id b8so5760905edx.7
        for <git@vger.kernel.org>; Thu, 19 Dec 2019 10:02:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=j+CNFyWcvi0OltNZ12lEEejSSYNm3CEUrqp/dKPVLBM=;
        b=LbyM6enLxQbza79IoTladNfbK26bM+oz4VfEynrYvMmzgGH/lMlgFVwGM+TC1mnQ25
         HIOAcLUnSn7QezqC5/nTFr0f1YDxv6fkemkcR5cuJEDqeTMVLQjhzH9zLXOXweZRWdtT
         HoDU5CGW3u5d8klgoJZvGXuGEPEFANZKPVc0cjkrvlaM0xlB/jHTExJqU5ABA0VsnoFh
         nsRi+J/o6WCC65m4qWruNOT7iParuVIUD2YlB7LCtg93rFzkD2HoaC68vU/i1HOSANR7
         w22/lMsrJxeoC7lwUM6qEyRAzW15bqCpVsu0Rd4Yiehk5SbQP5NxcbtVOkdzTz+AwVot
         xEOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=j+CNFyWcvi0OltNZ12lEEejSSYNm3CEUrqp/dKPVLBM=;
        b=KhIcfDxyTIaJ4nLCWHtl+VdB6CitHt0zloeAnvWYsM8lThvlx8bsslCrkkV+lnvquw
         az4dhnaZuY7lQzrtYgLLlz2DInYQfh/DIMYH6DCnOZLuUyFeOBgkoTLKYQoGize0GwYr
         WupYrNr3i0ATIgzcG03Q9ssH+Vbt5qKL/+hCElaIhL55j/dMybVY5pLbwcJk8whKJQKB
         TduFhhScfz0xTV1CZnaNbOrFWrsfKv8/hgRyPUOsiSNnDCI0iaRqWKvc6sb19SxP7iTL
         wdeICfJq9tJapdHAmRxdVeNbq2oU8ufv6TIBVD5lkfILpG0nKZ6pW1DZi6n7SUkgxztH
         myDg==
X-Gm-Message-State: APjAAAWEE65Kka3iRXJ9ywewSnAvdzOepWI3eVt68MAzx9w4/Zab7ZH3
        aJfdvkzfApegnYdGa+8Rcb8wKuAc
X-Google-Smtp-Source: APXvYqzkd24jPGxrwnWhua257QYNXqdQjDeMlCcsiNXcB4eeCah4bpKRYDp8aj9Y2BZ9GYWe5ghkBw==
X-Received: by 2002:a17:906:c299:: with SMTP id r25mr10824981ejz.272.1576778533670;
        Thu, 19 Dec 2019 10:02:13 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id m23sm625100ejd.21.2019.12.19.10.02.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 19 Dec 2019 10:02:13 -0800 (PST)
Message-Id: <e0bdd5bd1e156e68ec8e8a1a6c1376d7e69150be.1576778515.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.490.v3.git.1576778515.gitgitgadget@gmail.com>
References: <pull.490.v2.git.1576511287.gitgitgadget@gmail.com>
        <pull.490.v3.git.1576778515.gitgitgadget@gmail.com>
From:   "Alexandr Miloslavskiy via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 19 Dec 2019 18:01:53 +0000
Subject: [PATCH v3 16/18] parse_branchname_arg(): refactor the decision making
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
 builtin/checkout.c | 69 +++++++++++++++++++++++++++++-----------------
 1 file changed, 44 insertions(+), 25 deletions(-)

diff --git a/builtin/checkout.c b/builtin/checkout.c
index 95a8e08793..9a85a3e4dc 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -1153,9 +1153,8 @@ static int parse_branchname_arg(int argc, const char **argv,
 {
 	const char **new_branch = &opts->new_branch;
 	const char *arg;
-	int dash_dash_pos;
-	int arg0_cant_be_pathspec = 0;
-	int i;
+	int dash_dash_pos, i;
+	int recover_with_dwim, arg0_cant_be_pathspec;
 
 	/*
 	 * Resolve ambiguity where argv[0] may be <pathspec> or <commit>.
@@ -1174,14 +1173,6 @@ static int parse_branchname_arg(int argc, const char **argv,
 	 *    do that and proceed with (2)(3).
 	 * 5) Otherwise, let caller proceed with <pathspec> interpretation.
 	 */
-	if (!argc)
-		return 0;
-
-	if (!opts->accept_pathspec) {
-		if (argc > 1)
-			die(_("only one reference expected"));
-		arg0_cant_be_pathspec = 1;
-	}
 
 	arg = argv[0];
 	dash_dash_pos = -1;
@@ -1192,13 +1183,48 @@ static int parse_branchname_arg(int argc, const char **argv,
 		}
 	}
 
-	if (opts->accept_pathspec) {
-		if (dash_dash_pos == 0)
-			return 1;
-		else if (dash_dash_pos == 1)
-			arg0_cant_be_pathspec = 1;
-		else if (dash_dash_pos >= 2)
-			die(_("only one reference expected, %d given."), dash_dash_pos);
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
+		/*
+		 * Absence of '--' leaves <pathspec>/<commit> ambiguity.
+		 * Try to resolve it with additional knowledge about pathspec args.
+		 */
+		arg0_cant_be_pathspec = !opts->accept_pathspec;
+	} else if (dash_dash_pos == 0) {
+		/* 'git checkout/switch/restore -- [...]' */
+		return 1;  /* Eat '--' */
+	} else if (dash_dash_pos == 1) {
+		if (!opts->accept_pathspec) {
+			/* 'git switch <commit> -- [...]' */
+			die(_("incompatible with pathspec arguments"));
+		}
+
+		if (argc == 2) {
+			/* 'git checkout/restore <commit> --' */
+			recover_with_dwim = dwim_new_local_branch_ok;
+		} else {
+			/* 'git checkout/restore <commit> -- <pathspec> [...]' */
+			recover_with_dwim = 0;
+		}
+
+		/* Presence of '--' makes it certain that arg is <commit> */
+		arg0_cant_be_pathspec = 1;
+	} else {
+		/* 'git checkout/switch/restore <commit> <unxpected> [...] -- [...]' */
+		die(_("only one reference expected, %d given."), dash_dash_pos);
 	}
 
 	opts->count_checkout_paths = !opts->quiet && !arg0_cant_be_pathspec;
@@ -1207,19 +1233,12 @@ static int parse_branchname_arg(int argc, const char **argv,
 		arg = "@{-1}";
 
 	if (get_oid_mb(arg, rev)) {
-		int recover_with_dwim = dwim_new_local_branch_ok;
-
 		int could_be_checkout_paths = !arg0_cant_be_pathspec &&
 			check_filename(opts->prefix, arg);
 
 		if (!arg0_cant_be_pathspec && !no_wildcard(arg))
 			recover_with_dwim = 0;
 
-		if (!(argc == 1 && dash_dash_pos == -1) &&
-		    !(argc == 2 && dash_dash_pos == 1) &&
-		    opts->accept_pathspec)
-			recover_with_dwim = 0;
-
 		if (recover_with_dwim) {
 			const char *remote = parse_remote_branch(arg, rev,
 								 could_be_checkout_paths);
-- 
gitgitgadget

