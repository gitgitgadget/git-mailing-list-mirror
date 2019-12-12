Return-Path: <SRS0=AaZj=2C=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B07AC43603
	for <git@archiver.kernel.org>; Thu, 12 Dec 2019 14:36:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 324AD22B48
	for <git@archiver.kernel.org>; Thu, 12 Dec 2019 14:36:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Vf3rkSkS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729820AbfLLOgr (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 12 Dec 2019 09:36:47 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:52367 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729797AbfLLOgg (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 12 Dec 2019 09:36:36 -0500
Received: by mail-wm1-f67.google.com with SMTP id p9so2624147wmc.2
        for <git@vger.kernel.org>; Thu, 12 Dec 2019 06:36:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=1ZR/EapFp47sLr2IAonDutw8/BPi1HewBBrcBuE2Kfg=;
        b=Vf3rkSkSKYlrWvgoKijddN2HQmfi4TkD+eV8ka/IxVnsk30NZmQRue2WMPXPryb/1Q
         9c+nS5tE0mXfjl7v3uzSnVxi+d/QwqU/7fi14d13ehlgkEMLM8jQz54Yn6r2A0akfplH
         dctfWQ60XN1ix8FwY0S+M69CBbA9yEi1Liyxvzdi++s71aOxL3kqbcZV8vTdaIQBisK0
         q9tMboB7kYDtZyTj8kKJ+iSnMZ39vSCTxIuiUDTQsQ43XPMZrdNi6fS3d8ODkQTHXcq4
         oY1ZMyVeYLVi4LwnFUIlZjZyPYoKGX4SsRtmjlUkCoNV2qSTiyC/lBtT2dxFp2S5TzWw
         0Low==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=1ZR/EapFp47sLr2IAonDutw8/BPi1HewBBrcBuE2Kfg=;
        b=k1u8MHibfez2xgWGmOJm26hcz9ELWdD2AmbGnHw+GcFeP+yHcjvjrl9UhImVZ3vXX7
         dCUn8fo0jxAVi1XxFe60EiXt29B+QYXsbRi87jvfeWS+F0Y/ynVHFdUuFMjqo0/NzeN7
         LaFdLH4potQhE0uMRIux7D0dfwuyBBV6hhLdZzGO+AcApURwZBGzrAtiNVEY5O8yGmhz
         xZWZ0vUjBV/JdTcWbu435T+F7+PBzXVYhCKF74v8QozlDLJYmtfGwXyIxo/DoS2IOuMU
         5siwQnRsvU/jdaID7kTFPkHvW2TSIyiHgLRs/KGjwugQTBDLqR43DjeTKro5PpI40hPA
         Zzyg==
X-Gm-Message-State: APjAAAX8SVGoigC5ugainPw/1bo3GtmLlYxJZSrcGKKH498fVs/RMtX2
        /lGjNrBRPMdMJxESIQRqGESk/MPH
X-Google-Smtp-Source: APXvYqwblaVZdD0/vLbac/LZijanQwBr3tsfmFFbO1AmAV5wNJSbX1ovBkhpujJ3+ng178KQKXSRZg==
X-Received: by 2002:a05:600c:1:: with SMTP id g1mr6712101wmc.131.1576161395021;
        Thu, 12 Dec 2019 06:36:35 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id x11sm6429555wre.68.2019.12.12.06.36.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 12 Dec 2019 06:36:34 -0800 (PST)
Message-Id: <a6b77f9b23c819401c1a066f0895bb465ce5058d.1576161385.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.490.git.1576161385.gitgitgadget@gmail.com>
References: <pull.490.git.1576161385.gitgitgadget@gmail.com>
From:   "Alexandr Miloslavskiy via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 12 Dec 2019 14:36:21 +0000
Subject: [PATCH 12/16] parse_branchname_arg(): introduce expect_commit_only
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

