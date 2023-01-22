Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17636C54EAA
	for <git@archiver.kernel.org>; Sun, 22 Jan 2023 06:13:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229760AbjAVGM4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 22 Jan 2023 01:12:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229667AbjAVGMu (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 22 Jan 2023 01:12:50 -0500
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E0BBE042
        for <git@vger.kernel.org>; Sat, 21 Jan 2023 22:12:48 -0800 (PST)
Received: by mail-wr1-x433.google.com with SMTP id h16so8090335wrz.12
        for <git@vger.kernel.org>; Sat, 21 Jan 2023 22:12:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VFvzF6UR03HbaAWyeb/n/Q2ty+F5DZ4Dij7qzifqrfI=;
        b=FNhIFuHKuXSfhHvL1z4itAzUzd1pGAw2/mtWJQ5S5CJuysLNci11rJ5Dkn30Ho/EXR
         I/qIns+q3rJsUdxItXMDTsTrXgg8mAdg51zbj28MYUmh5nV6cwiZI+qRMs8jogdSLlxt
         b8wsl/dE/3NNQacuWlfz7ir+7vJGdCXRe6J5fv6ClBT/d1v686WBpy7XvHcbZUZWOmie
         brP1XZVCwIkJhXi1RTLW/543+rJexNkmQgEbpjcxyQdQzEQaVPEk4IUGau6hKOqOobxl
         i7/oGtL/gQ/87SrUntlgGUsjhK6o9yFxCK4zxG2/u+8j+OiTMTmEA1USSeshta+GWGTX
         U4/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VFvzF6UR03HbaAWyeb/n/Q2ty+F5DZ4Dij7qzifqrfI=;
        b=fsvAy013+yGeFRXlbFeNJEyw9zQNgxMADy2V5cVgjZ6uVXIJelS+uxaFhBt/AKCPRJ
         6y7ROMhmuPO5qSKscwz3T0tJk6t3BlyxLCkQ7TYrAr91GBZIS+XavS3WYc5e+BlPFvC5
         bWeBOxjJroCyPhpBEE39M1GK2Sd2wDygToi0qg43ivA5jlr5UjXoHoHaXRhurltnFNI3
         n7GxNHxSVmKTB+6mOmOkWvKrQ8yBsN0N1p2GaPEKJtjEeJpRN78M9k/JcwlNccZJAvUP
         A1WFLfVvwPBLrCw64CJu6fa5VmhpkufFNaW85rcjIozEnIOMgsbKdRbSZsiNDXJ/6aAf
         Qg2g==
X-Gm-Message-State: AFqh2krhcrDDyrIZPpOY4xXKHXsO7t/yi9Pl9s2Hhy1N+KN7Ib1uhZ1m
        yeNU6jZ7ou9Pt7RfWLrfUiOXHnvtKjw=
X-Google-Smtp-Source: AMrXdXsaRQlMnGEZnpnUrapAVfyi5xmQM5lz+cWHRtfLxQJyhm7u4CejiflYWBGE+o++NW1a7rB4vA==
X-Received: by 2002:a5d:5182:0:b0:242:4697:d826 with SMTP id k2-20020a5d5182000000b002424697d826mr17568146wrv.29.1674367966540;
        Sat, 21 Jan 2023 22:12:46 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id w4-20020adfee44000000b002ba2646fd30sm2371089wro.36.2023.01.21.22.12.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Jan 2023 22:12:46 -0800 (PST)
Message-Id: <5e4851e611ee18112bd71939ee900e02a8d590c5.1674367961.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1466.v4.git.1674367961.gitgitgadget@gmail.com>
References: <pull.1466.v3.git.1674266126.gitgitgadget@gmail.com>
        <pull.1466.v4.git.1674367961.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sun, 22 Jan 2023 06:12:36 +0000
Subject: [PATCH v4 5/9] rebase: add coverage of other incompatible options
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

The git-rebase manual noted several sets of incompatible options, but
we were missing tests for a few of these.  Further, we were missing
code checks for some of these, which could result in command line
options being silently ignored.

Also, note that adding a check for autosquash means that using
--whitespace=fix together with the config setting rebase.autosquash=true
will trigger an error.  A subsequent commit will improve the error
message.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 Documentation/git-rebase.txt           |  2 +-
 builtin/rebase.c                       | 30 ++++++++++++++++++++------
 t/t3422-rebase-incompatible-options.sh | 25 +++++++++++++++++++++
 3 files changed, 49 insertions(+), 8 deletions(-)

diff --git a/Documentation/git-rebase.txt b/Documentation/git-rebase.txt
index 846aeed1b69..8cb075b2bdb 100644
--- a/Documentation/git-rebase.txt
+++ b/Documentation/git-rebase.txt
@@ -650,7 +650,7 @@ are incompatible with the following options:
  * --exec
  * --no-keep-empty
  * --empty=
- * --reapply-cherry-picks
+ * --[no-]reapply-cherry-picks
  * --edit-todo
  * --update-refs
  * --root when used without --onto
diff --git a/builtin/rebase.c b/builtin/rebase.c
index b742cc8fb5c..ed7475804cb 100644
--- a/builtin/rebase.c
+++ b/builtin/rebase.c
@@ -1224,6 +1224,26 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 		if (options.fork_point < 0)
 			options.fork_point = 0;
 	}
+	/*
+	 * The apply backend does not support --[no-]reapply-cherry-picks.
+	 * The behavior it implements by default is equivalent to
+	 * --no-reapply-cherry-picks (due to passing --cherry-picks to
+	 * format-patch), but --keep-base alters the upstream such that no
+	 * cherry-picks can be found (effectively making it act like
+	 * --reapply-cherry-picks).
+	 *
+	 * Now, if the user does specify --[no-]reapply-cherry-picks, but
+	 * does so in such a way that options.reapply_cherry_picks ==
+	 * keep_base, then the behavior they get will match what they
+	 * expect despite options.reapply_cherry_picks being ignored.  We
+	 * could just allow the flag in that case, but it seems better to
+	 * just alert the user that they've specified a flag that the
+	 * backend ignores.
+	 */
+	if (options.reapply_cherry_picks >= 0)
+		imply_merge(&options, options.reapply_cherry_picks ? "--reapply-cherry-picks" :
+								     "--no-reapply-cherry-picks");
+
 	/*
 	 * --keep-base defaults to --reapply-cherry-picks to avoid losing
 	 * commits when using this option.
@@ -1406,13 +1426,6 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 	if (options.empty != EMPTY_UNSPECIFIED)
 		imply_merge(&options, "--empty");
 
-	/*
-	 * --keep-base implements --reapply-cherry-picks by altering upstream so
-	 * it works with both backends.
-	 */
-	if (options.reapply_cherry_picks && !keep_base)
-		imply_merge(&options, "--reapply-cherry-picks");
-
 	if (gpg_sign)
 		options.gpg_sign_opt = xstrfmt("-S%s", gpg_sign);
 
@@ -1503,6 +1516,9 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 	if (options.update_refs)
 		imply_merge(&options, "--update-refs");
 
+	if (options.autosquash)
+		imply_merge(&options, "--autosquash");
+
 	if (options.type == REBASE_UNSPECIFIED) {
 		if (!strcmp(options.default_backend, "merge"))
 			imply_merge(&options, "--merge");
diff --git a/t/t3422-rebase-incompatible-options.sh b/t/t3422-rebase-incompatible-options.sh
index f86274990b0..6a17b571ec7 100755
--- a/t/t3422-rebase-incompatible-options.sh
+++ b/t/t3422-rebase-incompatible-options.sh
@@ -50,6 +50,11 @@ test_rebase_am_only () {
 		test_must_fail git rebase $opt --strategy-option=ours A
 	"
 
+	test_expect_success "$opt incompatible with --autosquash" "
+		git checkout B^0 &&
+		test_must_fail git rebase $opt --autosquash A
+	"
+
 	test_expect_success "$opt incompatible with --interactive" "
 		git checkout B^0 &&
 		test_must_fail git rebase $opt --interactive A
@@ -60,6 +65,26 @@ test_rebase_am_only () {
 		test_must_fail git rebase $opt --exec 'true' A
 	"
 
+	test_expect_success "$opt incompatible with --keep-empty" "
+		git checkout B^0 &&
+		test_must_fail git rebase $opt --keep-empty A
+	"
+
+	test_expect_success "$opt incompatible with --empty=..." "
+		git checkout B^0 &&
+		test_must_fail git rebase $opt --empty=ask A
+	"
+
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

