Return-Path: <SRS0=PvcO=2G=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5020AC43603
	for <git@archiver.kernel.org>; Mon, 16 Dec 2019 15:48:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 20CBD20725
	for <git@archiver.kernel.org>; Mon, 16 Dec 2019 15:48:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mdSYCqj9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728556AbfLPPsW (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 16 Dec 2019 10:48:22 -0500
Received: from mail-wm1-f43.google.com ([209.85.128.43]:34984 "EHLO
        mail-wm1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728534AbfLPPsS (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 16 Dec 2019 10:48:18 -0500
Received: by mail-wm1-f43.google.com with SMTP id p17so7251586wmb.0
        for <git@vger.kernel.org>; Mon, 16 Dec 2019 07:48:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=PT+xykgIecQEKrUEpLdmeS0n9SYkZV/dk/Evq5pXETE=;
        b=mdSYCqj9fpWLDb6nLbz8IV0CrgaQz0eEnEGm74D3OF9JqdvGetTentVAFCdWLJwC40
         duIcCJOrwyX5oKYyniUZNMgaP2CiLSEE+UesK2KDJcj3le0R4/zlTSGPt/sfQxgMHEXb
         QMAVcNlAz9GmfnMCKKIgH4OS6gOVVS70uLqBV4Vh4cyKI3FNFXPWVPk3EcGS+B6HcROG
         YU79jF2H+9aTa1vtE/6+7yYo8u8gZHlGIDXKWbDFdFwlLvTLzdNokUfx//Vza3CuUOwO
         peF6jILV5TlxRJQcbBhak6v+/nHM1/UWXhBDdMIx0wx3LP0DmIuJ20TlyqkadIasFOjZ
         OUvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=PT+xykgIecQEKrUEpLdmeS0n9SYkZV/dk/Evq5pXETE=;
        b=OKkr/3gn6AIMzx6urhez7khP0+KNJts1J9SwnaWOmKPCA308bjaPgK6bzTOMwe0cW8
         n/bppQkq2FWLHF/ILdVRtbuEtyVCbJ8nx3EHCPxgq2nfD8xC1FUpi/5fHeRrnrDVEDQg
         Jgl+hREQjWCtObL30Xm/S7I706DboRJF+m2rNUPiwDJgyIOIm4W8Vt9KBgW8VODrvpeJ
         zjy08vl1/x2RR9/edvu7geuPNSi43UejrJDxBrmxM2mw6dWgOv2+Uy311LpDiNm3EPqn
         K5u2ZUth3kgzEYo1QIZupsBSFaT3XyMwuaCEYlYi9TGs51hRXTBr8ZvKejNmJyK6NWzQ
         z1ew==
X-Gm-Message-State: APjAAAX1EejZZaUTfEDV69r7EWH4PZY/94UgVcvBxDRmnDJqvPuYRy/x
        dv14nUqM7z5vrSQk0UV94fu2VaBT
X-Google-Smtp-Source: APXvYqxNCZTLMruAGj10zKJIaIIfwOY8GdJnqkb9mJGAZUHoPVqPjd4Mvl1pK/Sin4p8cSZTxaH0/A==
X-Received: by 2002:a1c:48c1:: with SMTP id v184mr32210037wma.5.1576511296853;
        Mon, 16 Dec 2019 07:48:16 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id d8sm21904571wre.13.2019.12.16.07.48.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 16 Dec 2019 07:48:16 -0800 (PST)
Message-Id: <24988252302780577b27e636237319724848a47a.1576511287.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.490.v2.git.1576511287.gitgitgadget@gmail.com>
References: <pull.490.git.1576161385.gitgitgadget@gmail.com>
        <pull.490.v2.git.1576511287.gitgitgadget@gmail.com>
From:   "Alexandr Miloslavskiy via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 16 Dec 2019 15:48:01 +0000
Subject: [PATCH v2 13/18] parse_branchname_arg(): easier to understand
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

