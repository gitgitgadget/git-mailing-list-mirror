Return-Path: <SRS0=FxFb=2J=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BF64C2D0C1
	for <git@archiver.kernel.org>; Thu, 19 Dec 2019 18:02:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E155820716
	for <git@archiver.kernel.org>; Thu, 19 Dec 2019 18:02:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nG3oKBug"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727083AbfLSSCR (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 19 Dec 2019 13:02:17 -0500
Received: from mail-ed1-f50.google.com ([209.85.208.50]:46501 "EHLO
        mail-ed1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727024AbfLSSCN (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 19 Dec 2019 13:02:13 -0500
Received: by mail-ed1-f50.google.com with SMTP id m8so5747843edi.13
        for <git@vger.kernel.org>; Thu, 19 Dec 2019 10:02:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=3GRmCyf+uKkl57ZYwIW/lK7wuKjEqv6YODr0zquS4f8=;
        b=nG3oKBugSPGlKIQM8fiRnoaOEsYyDiRp2gRdulPPeRBggYOgX3pzgYyPGKHCVsmcaE
         uwxiU0asN0vQsidVEEgtxfaEUtT2sSBgxtQw/rOUe/6IgQ/znjMhAejjG0ccy712Pfcw
         1Y0oO2S/xAh62B0xykP/MpLVcY2Df7eV/32UP8hPT+7p/+TXmRxVOczMhSkET80hDpvf
         bsM2tZV861rMYXO4blvrYrokK+bYAQvrUs1J6dQPPyaRxV2ix8Nfq9FsKlGOt7+0UcIq
         DmqRB66X3yon9al4xWyTUHlnWzugYWUzZqiNGuKMF/E7ms7bb1dDufNKl7xIA6sauTSa
         6gzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=3GRmCyf+uKkl57ZYwIW/lK7wuKjEqv6YODr0zquS4f8=;
        b=KG8y/WqY/OfxIG+kHTct+wu/Aj2AWN++i54MeEjQ9cpw92cErrl7HUpeoQG1t6jStn
         arELNjspaMN7s49kXT5RwIxtdTkm7se7/HIRw4WMSTvIDF+HS4d/ltEsu2vCUdA0adza
         pY6FIjQGnPgconRH/WD7ToSzr2hQ+qP+x4/E4mL5a/oKOCXmJBPL992wZrLQYZ8obCwU
         BN4kUxA/m6HpqrbxV33Un9ZQ6vgy813oRXEVxm4sP1D/4Mzr/PkcGQb/v04ERNaytr+n
         0PPJuL7rMdfs0HyPBM0tJ2PbZnTKzzYkoko4Pv7iDJDhY342LepebVmB+a7sPYwJMO1k
         MbAQ==
X-Gm-Message-State: APjAAAWezY4skKDAHNk4iUqWonGoGUAQsD3Geedd9AG9B8ViC+6UXufz
        ALbBZApoR22brA91a93p6/JWl2eD
X-Google-Smtp-Source: APXvYqyq7nh6dx8fTddIL0lFHv26K3/jvhhKH43z2iOr5KnEqLhNY1QIvn4P8zwtUF/MPY7MCVrJuw==
X-Received: by 2002:a17:906:8486:: with SMTP id m6mr11061612ejx.194.1576778530536;
        Thu, 19 Dec 2019 10:02:10 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id e24sm561417edy.93.2019.12.19.10.02.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 19 Dec 2019 10:02:09 -0800 (PST)
Message-Id: <dd35cad0d9ff9a0247d0a99bb4cdc294ef46ba96.1576778515.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.490.v3.git.1576778515.gitgitgadget@gmail.com>
References: <pull.490.v2.git.1576511287.gitgitgadget@gmail.com>
        <pull.490.v3.git.1576778515.gitgitgadget@gmail.com>
From:   "Alexandr Miloslavskiy via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 19 Dec 2019 18:01:50 +0000
Subject: [PATCH v3 13/18] parse_branchname_arg(): easier to understand
 variables
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

`dash_dash_pos` was only calculated under `opts->accept_pathspec`. This
is unexpected to readers and made it harder to reason about the code.

Fix this by restoring the expected meaning.

`has_dash_dash` also takes `opts->accept_pathspec` into account.
While this may sound clever at first sight, it becomes pretty hard to
reason (and not be a victim) about code, especially in combination with
`argc` here:

	if (!(argc == 1 && !has_dash_dash) &&
	    !(argc == 2 && has_dash_dash) &&
	    opts->accept_pathspec)
		recover_with_dwim = 0;

Fix this by giving variable a better name and rewriting the above
mentioned condition (it's easier to verify if you notice that it only
holds when `opts->accept_pathspec` is true).

This patch is not expected to change behavior in any way.

Signed-off-by: Alexandr Miloslavskiy <alexandr.miloslavskiy@syntevo.com>
---
 builtin/checkout.c | 36 ++++++++++++++++++++----------------
 1 file changed, 20 insertions(+), 16 deletions(-)

diff --git a/builtin/checkout.c b/builtin/checkout.c
index b847695d2b..9144770b21 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -1155,7 +1155,7 @@ static int parse_branchname_arg(int argc, const char **argv,
 	int argcount = 0;
 	const char *arg;
 	int dash_dash_pos;
-	int has_dash_dash = 0;
+	int arg0_cant_be_pathspec = 0;
 	int i;
 
 	/*
@@ -1205,24 +1205,28 @@ static int parse_branchname_arg(int argc, const char **argv,
 	if (!opts->accept_pathspec) {
 		if (argc > 1)
 			die(_("only one reference expected"));
-		has_dash_dash = 1; /* helps disambiguate */
+		arg0_cant_be_pathspec = 1;
 	}
 
 	arg = argv[0];
 	dash_dash_pos = -1;
 	for (i = 0; i < argc; i++) {
-		if (opts->accept_pathspec && !strcmp(argv[i], "--")) {
+		if (!strcmp(argv[i], "--")) {
 			dash_dash_pos = i;
 			break;
 		}
 	}
-	if (dash_dash_pos == 0)
-		return 1; /* case (2) */
-	else if (dash_dash_pos == 1)
-		has_dash_dash = 1; /* case (3) or (1) */
-	else if (dash_dash_pos >= 2)
-		die(_("only one reference expected, %d given."), dash_dash_pos);
-	opts->count_checkout_paths = !opts->quiet && !has_dash_dash;
+
+	if (opts->accept_pathspec) {
+		if (dash_dash_pos == 0)
+			return 1; /* case (2) */
+		else if (dash_dash_pos == 1)
+			arg0_cant_be_pathspec = 1; /* case (3) or (1) */
+		else if (dash_dash_pos >= 2)
+			die(_("only one reference expected, %d given."), dash_dash_pos);
+	}
+
+	opts->count_checkout_paths = !opts->quiet && !arg0_cant_be_pathspec;
 
 	if (!strcmp(arg, "-"))
 		arg = "@{-1}";
@@ -1238,18 +1242,18 @@ static int parse_branchname_arg(int argc, const char **argv,
 		 */
 		int recover_with_dwim = dwim_new_local_branch_ok;
 
-		int could_be_checkout_paths = !has_dash_dash &&
+		int could_be_checkout_paths = !arg0_cant_be_pathspec &&
 			check_filename(opts->prefix, arg);
 
-		if (!has_dash_dash && !no_wildcard(arg))
+		if (!arg0_cant_be_pathspec && !no_wildcard(arg))
 			recover_with_dwim = 0;
 
 		/*
 		 * Accept "git checkout foo", "git checkout foo --"
 		 * and "git switch foo" as candidates for dwim.
 		 */
-		if (!(argc == 1 && !has_dash_dash) &&
-		    !(argc == 2 && has_dash_dash) &&
+		if (!(argc == 1 && dash_dash_pos == -1) &&
+		    !(argc == 2 && dash_dash_pos == 1) &&
 		    opts->accept_pathspec)
 			recover_with_dwim = 0;
 
@@ -1266,7 +1270,7 @@ static int parse_branchname_arg(int argc, const char **argv,
 		}
 
 		if (!recover_with_dwim) {
-			if (has_dash_dash)
+			if (arg0_cant_be_pathspec)
 				die(_("invalid reference: %s"), arg);
 			return argcount;
 		}
@@ -1282,7 +1286,7 @@ static int parse_branchname_arg(int argc, const char **argv,
 	if (!opts->source_tree)                   /* case (1): want a tree */
 		die(_("reference is not a tree: %s"), arg);
 
-	if (!has_dash_dash) {	/* case (3).(d) -> (1) */
+	if (!arg0_cant_be_pathspec) {	/* case (3).(d) -> (1) */
 		/*
 		 * Do not complain the most common case
 		 *	git checkout branch
-- 
gitgitgadget

