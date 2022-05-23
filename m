Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4CBEC433EF
	for <git@archiver.kernel.org>; Mon, 23 May 2022 12:54:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235764AbiEWMyq (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 23 May 2022 08:54:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235812AbiEWMyd (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 May 2022 08:54:33 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EC644D269
        for <git@vger.kernel.org>; Mon, 23 May 2022 05:54:29 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id r23so21268956wrr.2
        for <git@vger.kernel.org>; Mon, 23 May 2022 05:54:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:from:date:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=jXTm12HxJDBih8/jfOkGAZ95MUi1N+FhU9h7FNvGoFg=;
        b=Y6Oi3rkQIzMiCU8kxCJhkvl7ENI5NQPp5KJ1RT29F4zGzQu4Sg2We3VNYfR43B6HDe
         VPDSDqybWTfcO9tuAYomPFWwuI2mpdnoikwHd7ail1RRm4wBEIaRMmn6TAhM672+W9LJ
         j0lMlPis084+3dPCQZcMS/6dKJLz9I7MIPuQNZ12ZcTCNkLGzJRpTNnTERncLY1UVkSo
         cDAjG7EjrZymkHnvAB46CV4oSNdZ1Da86GLSgTpNaxnaUQL2mP/3rCBEQqZuSzI3BEWJ
         RlJ0txtB15g6LSle/YEQo6/CscS+wNtL5XKEdYkILaY8ofkTEdK47b14EDSgLDTSKJbn
         R/tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=jXTm12HxJDBih8/jfOkGAZ95MUi1N+FhU9h7FNvGoFg=;
        b=lUQZxsJ26LWkNNTVBSaXx11q+W2FYqtYCbS23YPy/lBs9CZN/4L5BAD1PLCDUAgbyE
         tQZDth2uypybrXXDIdoMakFTx7K35WiqVHKT3EyZOlOVYDwkbPf9s+KoGfuKrr5Gi6jQ
         Oo5C/CmYgkl0dywbJ0zpfz1q1yvMHLHcx3lO/05s4FcpXmUgxFWF1wGnoICT+lHA2R2q
         uJN6uD8JiFKXs1/N2lfZA4fCyiTf3gIqflf0AvkM9h9ExuB9YuBNYwN4JTegy874NIjS
         B75yI0D8nf0kWnyrEWBYkznUQ+MmdJjbT/hqcn0b1dR35ulquKtmlL8kbfnmSDqp8QjM
         Fgrw==
X-Gm-Message-State: AOAM531jat10EVgMLfRq1XOGFzZo2QDqeqv8gcnrO6z2aqZaibGS8NI8
        otTtW33wB50b7y22+M3PpjXkj+MNRL4=
X-Google-Smtp-Source: ABdhPJwISQdO7yxF6WYpHYlcSrd85kf6HFlCNqkmnOzOLEf85ddSV9eVI/2mFGssoV2IPmvUJFq6kA==
X-Received: by 2002:a5d:4302:0:b0:20e:66db:b8f5 with SMTP id h2-20020a5d4302000000b0020e66dbb8f5mr18033364wrq.320.1653310467321;
        Mon, 23 May 2022 05:54:27 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id m4-20020a05600c4f4400b003972c672859sm9004089wmq.21.2022.05.23.05.54.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 May 2022 05:54:26 -0700 (PDT)
Message-Id: <pull.1236.git.1653310466062.gitgitgadget@gmail.com>
From:   "Carl Smedstad via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 23 May 2022 12:54:25 +0000
Subject: [PATCH] check-ignore: --non-matching without --verbose
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Carl Smedstad <carl.smedstad@protonmail.com>,
        Carl Smedstad <carl.smedstad@protonmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Carl Smedstad <carl.smedstad@protonmail.com>

Allow --non-matching to be specified without the --verbose flag to make
git only list files that are not matching any pattern. The behaviour
when specifying both --non-matching and --verbose is unchanged.

The motivation for this is to use the underutilized invocation of
--non-matching without --verbose to create a shorthand for what could be
achieved by:

    find . |
      git check-ignore --verbose --non-matching |
      grep $'^::\t' |
      sed -e 's/.*\t//'

Signed-off-by: Carl Smedstad <carl.smedstad@protonmail.com>
---
    check-ignore: --non-matching without --verbose
    
    Allow --non-matching to be specified without the --verbose flag to make
    git only list files that are not matching any pattern. The behaviour
    when specifying both --non-matching and --verbose is unchanged.
    
    The motivation for this is to use the underutilized invocation of
    --non-matching without --verbose to create a shorthand for what could be
    achieved by:
    
    find . |
      git check-ignore --verbose --non-matching |
      grep $'^::\t' |
      sed -e 's/.*\t//'
    
    
    Signed-off-by: Carl Smedstad carl.smedstad@protonmail.com

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1236%2Fcarlsmedstad%2Fcheck-ignore-non-matching-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1236/carlsmedstad/check-ignore-non-matching-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/1236

 Documentation/git-check-ignore.txt |  6 ++----
 builtin/check-ignore.c             | 15 +++++++++++----
 t/t0008-ignores.sh                 | 17 +++++++++++++++--
 3 files changed, 28 insertions(+), 10 deletions(-)

diff --git a/Documentation/git-check-ignore.txt b/Documentation/git-check-ignore.txt
index 2892799e32f..69d12fd22e1 100644
--- a/Documentation/git-check-ignore.txt
+++ b/Documentation/git-check-ignore.txt
@@ -50,10 +50,8 @@ linkgit:gitignore[5].
 	with a NUL character instead of a linefeed character.
 
 -n, --non-matching::
-	Show given paths which don't match any pattern.	 This only
-	makes sense when `--verbose` is enabled, otherwise it would
-	not be possible to distinguish between paths which match a
-	pattern and those which don't.
+	Only show given paths which don't match any pattern. If `--verbose` is
+	enabled, show both paths that match a pattern and those which don't.
 
 --no-index::
 	Don't look in the index when undertaking the checks. This can
diff --git a/builtin/check-ignore.c b/builtin/check-ignore.c
index 21912569650..10e8bba1057 100644
--- a/builtin/check-ignore.c
+++ b/builtin/check-ignore.c
@@ -113,8 +113,17 @@ static int check_ignore(struct dir_struct *dir,
 			    pattern->flags & PATTERN_FLAG_NEGATIVE)
 				pattern = NULL;
 		}
-		if (!quiet && (pattern || show_non_matching))
-			output_pattern(pathspec.items[i].original, pattern);
+		if (!quiet) {
+			if (verbose) {
+				if (show_non_matching || pattern)
+					output_pattern(pathspec.items[i].original, pattern);
+			} else {
+				if (show_non_matching && !pattern)
+					output_pattern(pathspec.items[i].original, pattern);
+				if (!show_non_matching && pattern)
+					output_pattern(pathspec.items[i].original, pattern);
+			}
+		}
 		if (pattern)
 			num_ignored++;
 	}
@@ -175,8 +184,6 @@ int cmd_check_ignore(int argc, const char **argv, const char *prefix)
 		if (verbose)
 			die(_("cannot have both --quiet and --verbose"));
 	}
-	if (show_non_matching && !verbose)
-		die(_("--non-matching is only valid with --verbose"));
 
 	/* read_cache() is only necessary so we can watch out for submodules. */
 	if (!no_index && read_cache() < 0)
diff --git a/t/t0008-ignores.sh b/t/t0008-ignores.sh
index 5575dade8ee..2ea178797bc 100755
--- a/t/t0008-ignores.sh
+++ b/t/t0008-ignores.sh
@@ -90,7 +90,8 @@ test_check_ignore () {
 #   1. with -q / --quiet
 #   2. with default verbosity
 #   3. with -v / --verbose
-#   4. with -v / --verbose, *and* -n / --non-matching
+#   4. with -n / --non-matching
+#   5. with -v / --verbose, *and* -n / --non-matching
 #
 # expecting success each time.  Takes advantage of the fact that
 # check-ignore --verbose output is the same as normal output except
@@ -102,7 +103,7 @@ test_check_ignore () {
 # Arguments:
 #   - (optional) prereqs for this test, e.g. 'SYMLINKS'
 #   - test name
-#   - output to expect from the fourth verbosity mode (the output
+#   - output to expect from the fifth verbosity mode (the output
 #     from the other verbosity modes is automatically inferred
 #     from this value)
 #   - code to run (should invoke test_check_ignore)
@@ -124,6 +125,7 @@ test_expect_success_multiple () {
 
 	expect_verbose=$( echo "$expect_all" | grep -v '^::	' )
 	expect=$( echo "$expect_verbose" | sed -e 's/.*	//' )
+	expect_non_matching=$( echo "$expect_all" | grep '^::	' | sed -e 's/.*	//')
 
 	test_expect_success $prereq "$testname${no_index_opt:+ with $no_index_opt}" '
 		expect "$expect" &&
@@ -144,6 +146,17 @@ test_expect_success_multiple () {
 		quiet_opt=
 	fi
 
+	for non_matching_opt in '-n' '--non-matching'
+	do
+		test_code="
+			expect '$expect_non_matching' &&
+			$code
+		"
+		opts="${no_index_opt:+$no_index_opt }$non_matching_opt"
+		test_expect_success $prereq "$testname${opts:+ with $opts}" "$test_code"
+	done
+	non_matching_opt=
+
 	for verbose_opt in '-v' '--verbose'
 	do
 		for non_matching_opt in '' '-n' '--non-matching'

base-commit: f9b95943b68b6b8ca5a6072f50a08411c6449b55
-- 
gitgitgadget
