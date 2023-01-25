Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC7DCC54E94
	for <git@archiver.kernel.org>; Wed, 25 Jan 2023 04:04:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233949AbjAYEER (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 24 Jan 2023 23:04:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233732AbjAYEEF (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 Jan 2023 23:04:05 -0500
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B09249425
        for <git@vger.kernel.org>; Tue, 24 Jan 2023 20:04:03 -0800 (PST)
Received: by mail-wm1-x32b.google.com with SMTP id j17so12873810wms.0
        for <git@vger.kernel.org>; Tue, 24 Jan 2023 20:04:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/2fjKp1YFO64r9HSiFlkSpabozzOvEirsTx632yzoAA=;
        b=pSuCHfJSj4CtOGem+ako6P1CZ6DtjiL6qRyKl94zVBpaIeLSpgi4cXefdyIwAY/jrP
         pCCjmyCyyrr6wMRg0UvvbC8YQodmjH5hWOB2idrqk9AkcQe6FugemG0OoFZUbpNNbvLJ
         0d34xd+qSMTWKCMYizGB6vHShzHQ6mxYQIYAjEA+hhaoZCv7PHu04gQnl0stLB5A+dGg
         BLLJ53ITjd10gbrj8m3v2DQtYS1Hp+mgwM2VgL/NQysVOTKd4wEUhbGzvQKKdow2vVjD
         muSNNplJ0A35e3QF0JVbcFJtWXttSoMVOOt+yrbZVNFp0lSAMIxL42zjMqSX2AtCIJXV
         Vluw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/2fjKp1YFO64r9HSiFlkSpabozzOvEirsTx632yzoAA=;
        b=yYCHChJr9LJkH2TbPyy6T61VtuV8LqOcYIvZW10Nu5lti3eWpg3c+6m13gQoj0/2kT
         0Yj7NkGVSR99aizUHBumxrNQcMunZXRqjrpayvNH1V00fzTzMFJNVUmY8cVBennmznmT
         dMptqqmNeY4bj9NE0WPua6jQtgiRr4s8PANhHSg+JqvpcrzfxwbphA0VTGjQedkyYovJ
         sW/1qU/oFxjHEsdgRYQieHg/v2nWkRtF1NEoSdLOfx35piqoi/0pbv20MhnrVXICS7O6
         MvmS7xzH6LxhEcYznpufWzzMy6S7sqFevyR0wRAPoWEWHb6YMU+HBH41M5W9i0n3AyRm
         iUxg==
X-Gm-Message-State: AFqh2kpTYv4MuEUuTO8bSei3DyPLTRn6NZYF6ckpvROTWnLauOe6c4zh
        ZUMNoz+2Wze818Ejr43XxogZY3o2Rmg=
X-Google-Smtp-Source: AMrXdXtKwUitLdfmKEk9vb7N0CMzmA6hB79HneSWjaQRx6dwCmhBpWqnmiuwwM6WDuzoUdI88ZJ0Hw==
X-Received: by 2002:a05:600c:5025:b0:3db:14dc:8cff with SMTP id n37-20020a05600c502500b003db14dc8cffmr25509877wmr.33.1674619441856;
        Tue, 24 Jan 2023 20:04:01 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id o17-20020a05600c511100b003dc0d5b4fa6sm4919274wms.3.2023.01.24.20.04.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Jan 2023 20:04:01 -0800 (PST)
Message-Id: <3a8429f3d2b72d59d0a071d83f6fd9effe6824ed.1674619434.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1466.v5.git.1674619434.gitgitgadget@gmail.com>
References: <pull.1466.v4.git.1674367961.gitgitgadget@gmail.com>
        <pull.1466.v5.git.1674619434.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 25 Jan 2023 04:03:49 +0000
Subject: [PATCH v5 05/10] rebase: fix incompatiblity checks for
 --[no-]reapply-cherry-picks
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Derrick Stolee <derrickstolee@github.com>,
        Elijah Newren <newren@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Martin =?UTF-8?Q?=C3=85gren?= <martin.agren@gmail.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

--[no-]reapply-cherry-picks was traditionally only supported by the
sequencer.  Support was added for the apply backend, when --keep-base is
also specified, in commit ce5238a690 ("rebase --keep-base: imply
--reapply-cherry-picks", 2022-10-17).  Make the code error out when
--[no-]reapply-cherry-picks is specified AND the apply backend is used
AND --keep-base is not specified.  Also, clarify a number of comments
surrounding the interaction of these flags.

Helped-by: Phillip Wood <phillip.wood@dunelm.org.uk>
Signed-off-by: Elijah Newren <newren@gmail.com>
---
 Documentation/git-rebase.txt           |  2 +-
 builtin/rebase.c                       | 34 ++++++++++++++++----------
 t/t3422-rebase-incompatible-options.sh | 10 ++++++++
 3 files changed, 32 insertions(+), 14 deletions(-)

diff --git a/Documentation/git-rebase.txt b/Documentation/git-rebase.txt
index 846aeed1b69..8a09f12d897 100644
--- a/Documentation/git-rebase.txt
+++ b/Documentation/git-rebase.txt
@@ -650,7 +650,7 @@ are incompatible with the following options:
  * --exec
  * --no-keep-empty
  * --empty=
- * --reapply-cherry-picks
+ * --[no-]reapply-cherry-picks when used without --keep-base
  * --edit-todo
  * --update-refs
  * --root when used without --onto
diff --git a/builtin/rebase.c b/builtin/rebase.c
index b742cc8fb5c..05b130bfae5 100644
--- a/builtin/rebase.c
+++ b/builtin/rebase.c
@@ -1224,13 +1224,6 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 		if (options.fork_point < 0)
 			options.fork_point = 0;
 	}
-	/*
-	 * --keep-base defaults to --reapply-cherry-picks to avoid losing
-	 * commits when using this option.
-	 */
-	if (options.reapply_cherry_picks < 0)
-		options.reapply_cherry_picks = keep_base;
-
 	if (options.root && options.fork_point > 0)
 		die(_("options '%s' and '%s' cannot be used together"), "--root", "--fork-point");
 
@@ -1406,12 +1399,27 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 	if (options.empty != EMPTY_UNSPECIFIED)
 		imply_merge(&options, "--empty");
 
-	/*
-	 * --keep-base implements --reapply-cherry-picks by altering upstream so
-	 * it works with both backends.
-	 */
-	if (options.reapply_cherry_picks && !keep_base)
-		imply_merge(&options, "--reapply-cherry-picks");
+	if (options.reapply_cherry_picks < 0)
+		/*
+		 * We default to --no-reapply-cherry-picks unless
+		 * --keep-base is given; when --keep-base is given, we want
+		 * to default to --reapply-cherry-picks.
+		 */
+		options.reapply_cherry_picks = keep_base;
+	else if (!keep_base)
+		/*
+		 * The apply backend always searches for and drops cherry
+		 * picks.  This is often not wanted with --keep-base, so
+		 * --keep-base allows --reapply-cherry-picks to be
+		 * simulated by altering the upstream such that
+		 * cherry-picks cannot be detected and thus all commits are
+		 * reapplied.  Thus, --[no-]reapply-cherry-picks is
+		 * supported when --keep-base is specified, but not when
+		 * --keep-base is left out.
+		 */
+		imply_merge(&options, options.reapply_cherry_picks ?
+					  "--reapply-cherry-picks" :
+					  "--no-reapply-cherry-picks");
 
 	if (gpg_sign)
 		options.gpg_sign_opt = xstrfmt("-S%s", gpg_sign);
diff --git a/t/t3422-rebase-incompatible-options.sh b/t/t3422-rebase-incompatible-options.sh
index f86274990b0..826f3b94ae6 100755
--- a/t/t3422-rebase-incompatible-options.sh
+++ b/t/t3422-rebase-incompatible-options.sh
@@ -60,6 +60,16 @@ test_rebase_am_only () {
 		test_must_fail git rebase $opt --exec 'true' A
 	"
 
+	test_expect_success "$opt incompatible with --no-reapply-cherry-picks" "
+		git checkout B^0 &&
+		test_must_fail git rebase $opt --no-reapply-cherry-picks A
+	"
+
+	test_expect_success "$opt incompatible with --reapply-cherry-picks" "
+		git checkout B^0 &&
+		test_must_fail git rebase $opt --reapply-cherry-picks A
+	"
+
 	test_expect_success "$opt incompatible with --update-refs" "
 		git checkout B^0 &&
 		test_must_fail git rebase $opt --update-refs A
-- 
gitgitgadget

