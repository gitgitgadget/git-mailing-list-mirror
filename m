Return-Path: <SRS0=AaZj=2C=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91E63C43603
	for <git@archiver.kernel.org>; Thu, 12 Dec 2019 14:36:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 64BD921655
	for <git@archiver.kernel.org>; Thu, 12 Dec 2019 14:36:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FGmRUfVb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729803AbfLLOgh (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 12 Dec 2019 09:36:37 -0500
Received: from mail-wr1-f43.google.com ([209.85.221.43]:44023 "EHLO
        mail-wr1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729792AbfLLOgf (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 12 Dec 2019 09:36:35 -0500
Received: by mail-wr1-f43.google.com with SMTP id d16so2958515wre.10
        for <git@vger.kernel.org>; Thu, 12 Dec 2019 06:36:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=PT+xykgIecQEKrUEpLdmeS0n9SYkZV/dk/Evq5pXETE=;
        b=FGmRUfVbkOKb9buatHKmg54+wdk+TF9aRkDZFHkkZ2bxhhWiZ62uPFBvIxr5IYRQtB
         OLkP9gGCpVqpy0nrHKOjopjt6IeWNLD1oe7fxBs6/wzNow5CHSbYLfcu5VYrI7WpyyIK
         NHE5Xa72u18oUo868sDYZXi0lD8yvkAzES7nbCpk7Jg8oe12z0ZVzczVVkLqK5qaNdLD
         aGTlPJvOJMviD/PtiZmE9Mgsyh67pTFxuulUjrqP/4IVrLaeydcK7RpJ4muV5CZf1+xU
         nQD3iGZ0dBnoQHTQ8FQZVfC3950eURHzTFQsU/xoNQAQfKHaAN6hUaYnXD8FaTWSuhbo
         H9gQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=PT+xykgIecQEKrUEpLdmeS0n9SYkZV/dk/Evq5pXETE=;
        b=M3zwb7n9EBqMhf7YVN9e2c712rDTNqRicELOVV3Lv9gaCidjeuwzul3/0bLGexKYyh
         5lwV7jYGezVNb6TR1kA7LKU/ZtIJzLRnthKSV+WQZNRY7AWCUZ8gbxFB6b5OObNQHunp
         9GFSvpVZ2eUd6evw6uyBXdm+y56naZ3rnUy1+GLiqPPkDshXqmsKTxsPi002ywxXcneB
         kgitfYjCAYvNFnkz8Hcx2+pwj9ucynTgSZHq13mM/ladsAFHOPfegyF+Qu5k4mByZeDL
         PkIiv08YvA2ibWz8Yj8YbKgBQGTjVDanAInFNpJ1mApg7DPxLGD8z5f3Ontk167/Ypg5
         fzQg==
X-Gm-Message-State: APjAAAUPHnBT1jWmV0mCipH+IKIAqOl5iYo92Q+wZjRpi/s/ewvIHGuJ
        3IHLSslH4fCl/oY1e/paXeciu0+I
X-Google-Smtp-Source: APXvYqx1b+oju1TCph2aknjfhUTho+TT++97NmLY2RKmlEEQwIb3XDKwCdu0A5yvdWbnOQCWLqhUCA==
X-Received: by 2002:a5d:5091:: with SMTP id a17mr6656255wrt.362.1576161394266;
        Thu, 12 Dec 2019 06:36:34 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id b16sm6464768wrj.23.2019.12.12.06.36.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 12 Dec 2019 06:36:33 -0800 (PST)
Message-Id: <a0a884b384fd7ebdb824bef90acd6d6366be8cf5.1576161385.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.490.git.1576161385.gitgitgadget@gmail.com>
References: <pull.490.git.1576161385.gitgitgadget@gmail.com>
From:   "Alexandr Miloslavskiy via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 12 Dec 2019 14:36:20 +0000
Subject: [PATCH 11/16] parse_branchname_arg(): easier to understand variables
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     "Phillip Wood <phillip.wood123@gmail.com>, Junio C Hamano" 
        <gitster@pobox.com>, Emily Shaffer <emilyshaffer@google.com>,
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

Simplify the code by dropping `argcount` and useless `argc` / `argv`
manipulations.

This should not change behavior in any way.

Signed-off-by: Alexandr Miloslavskiy <alexandr.miloslavskiy@syntevo.com>
---
 builtin/checkout.c | 34 ++++++++++++++--------------------
 1 file changed, 14 insertions(+), 20 deletions(-)

diff --git a/builtin/checkout.c b/builtin/checkout.c
index b847695d2b..f35fe2cc26 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -1152,7 +1152,6 @@ static int parse_branchname_arg(int argc, const char **argv,
 				struct object_id *rev)
 {
 	const char **new_branch = &opts->new_branch;
-	int argcount = 0;
 	const char *arg;
 	int dash_dash_pos;
 	int has_dash_dash = 0;
@@ -1211,17 +1210,21 @@ static int parse_branchname_arg(int argc, const char **argv,
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
+
+	if (opts->accept_pathspec) {
+	    if (dash_dash_pos == 0)
+		    return 1; /* case (2) */
+	    else if (dash_dash_pos == 1)
+		    has_dash_dash = 1; /* case (3) or (1) */
+	    else if (dash_dash_pos >= 2)
+		    die(_("only one reference expected, %d given."), dash_dash_pos);
+	}
+
 	opts->count_checkout_paths = !opts->quiet && !has_dash_dash;
 
 	if (!strcmp(arg, "-"))
@@ -1268,15 +1271,10 @@ static int parse_branchname_arg(int argc, const char **argv,
 		if (!recover_with_dwim) {
 			if (has_dash_dash)
 				die(_("invalid reference: %s"), arg);
-			return argcount;
+			return 0;
 		}
 	}
 
-	/* we can't end up being in (2) anymore, eat the argument */
-	argcount++;
-	argv++;
-	argc--;
-
 	setup_new_branch_info_and_source_tree(new_branch_info, opts, rev, arg);
 
 	if (!opts->source_tree)                   /* case (1): want a tree */
@@ -1289,15 +1287,11 @@ static int parse_branchname_arg(int argc, const char **argv,
 		 * even if there happen to be a file called 'branch';
 		 * it would be extremely annoying.
 		 */
-		if (argc)
+		if (argc > 1)
 			verify_non_filename(opts->prefix, arg);
-	} else if (opts->accept_pathspec) {
-		argcount++;
-		argv++;
-		argc--;
 	}
 
-	return argcount;
+	return (dash_dash_pos == 1) ? 2 : 1;
 }
 
 static int switch_unborn_to_new_branch(const struct checkout_opts *opts)
-- 
gitgitgadget

