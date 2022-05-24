Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABF80C433EF
	for <git@archiver.kernel.org>; Tue, 24 May 2022 13:02:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237520AbiEXNCD (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 24 May 2022 09:02:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231294AbiEXNCA (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 May 2022 09:02:00 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 834DD4C41B
        for <git@vger.kernel.org>; Tue, 24 May 2022 06:01:58 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id z15so1780561wrg.11
        for <git@vger.kernel.org>; Tue, 24 May 2022 06:01:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=7ZTFG+cVMNsrd9+GzwysUGzrlGBSUBq8MjM/Du//I8I=;
        b=VWI3sY5KZIoCBPsf7zgchXMX/hs76GaKxSOVSPEPBxcC/xCGghkjlwgR6LVAZaXsgC
         FzwliHIKXyrlgKSvX7NLEJOdZVbIPhsRo9dgfSgXmjsBG8e5lz+TPajsSoq7viM8Znjg
         +L62ucAcrYkRPcSe/b64y8lbGhHYynJ/whLcb7Mlw4Eqvd0/ng5VEZiPmRVkGtsCwjq2
         GrmYhAuIslwL//PcvtP62D99VF19QmA38xtKN0dwUr0e4rUuRpP6OamGBi1GqfUHnFqO
         +/78bpaFUBl4/05sfAaITEbzG2oDuFTFxuA3n13IL0lt2bYOy7oflbaHMMr/BU+fkUBV
         xZsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=7ZTFG+cVMNsrd9+GzwysUGzrlGBSUBq8MjM/Du//I8I=;
        b=XS9+huwEtIViAQoRTK2G15eOql+WTuUjvHtz66nF4u3RRLpnb2U8CZJys5hfg2XyTj
         MPZqkcrkQnzqeF31C+kJFTfIQax0hyASmtAegnKtibUpC/W2jQO0/6AuqQ81U46vVKgZ
         NCC94e8WIy5xEHKdFvu/dFCibJ9uyNQe3x9OKOxl9ekN+humywzMG07XZg7nUvFKwiQv
         bk56T6lNprsUs8Jhegd1cyxQHowYc3a796d2+Jadj9OLXk169CjRPD6HKlk7llp8jNXn
         awZtcRfF68QwIJhVzQSHHl3eOK6Jfan1v004gaKoMUSAy/y1lCj1tCgfIbpUIiSZHaIC
         bPdw==
X-Gm-Message-State: AOAM533u1HGaUux6W3jb7jvriZ/xLUtJWLVuWc9We2nmHKbYYJCb114w
        RXr48r5WZoJRCMAyiMkDDsivawXZkVc=
X-Google-Smtp-Source: ABdhPJxxk32EKMPylLHW/2YE2qM9DpLT4YxdLDZtC+B65Z/SrE9vWCD+qaioRrx7zJEgdohUT7A46g==
X-Received: by 2002:a05:6000:15c2:b0:20f:cf0a:4282 with SMTP id y2-20020a05600015c200b0020fcf0a4282mr12316071wry.248.1653397316643;
        Tue, 24 May 2022 06:01:56 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id l15-20020adfbd8f000000b0020e65d7d36asm13167860wrh.11.2022.05.24.06.01.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 May 2022 06:01:56 -0700 (PDT)
Message-Id: <pull.1236.v2.git.1653397315122.gitgitgadget@gmail.com>
In-Reply-To: <pull.1236.git.1653310466062.gitgitgadget@gmail.com>
References: <pull.1236.git.1653310466062.gitgitgadget@gmail.com>
From:   "Carl Smedstad via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 24 May 2022 13:01:54 +0000
Subject: [PATCH v2] check-ignore: --non-matching without --verbose
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
      git check-ignore --verbose --non-matching --stdin |
      grep $'^::\t' |
      sed -e 's/.*\t//'

Signed-off-by: Carl Smedstad <carl.smedstad@protonmail.com>
---
    check-ignore: --non-matching without --verbose
    
    Changes since v1:
    
     * Rewrote description for --non-matching.
     * Simplified the logic.

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1236%2Fcarlsmedstad%2Fcheck-ignore-non-matching-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1236/carlsmedstad/check-ignore-non-matching-v2
Pull-Request: https://github.com/gitgitgadget/git/pull/1236

Range-diff vs v1:

 1:  de794d0af18 ! 1:  350a3cfea1b check-ignore: --non-matching without --verbose
     @@ Commit message
          achieved by:
      
              find . |
     -          git check-ignore --verbose --non-matching |
     +          git check-ignore --verbose --non-matching --stdin |
                grep $'^::\t' |
                sed -e 's/.*\t//'
      
     @@ Documentation/git-check-ignore.txt: linkgit:gitignore[5].
      -	makes sense when `--verbose` is enabled, otherwise it would
      -	not be possible to distinguish between paths which match a
      -	pattern and those which don't.
     -+	Only show given paths which don't match any pattern. If `--verbose` is
     -+	enabled, show both paths that match a pattern and those which don't.
     ++	If `--verbose` is enabled, list both matching and non-matching
     ++	paths (non-matching paths along with the indicator `::`). Without
     ++	`--verbose`, list only the paths that do not match any pattern.
       
       --no-index::
       	Don't look in the index when undertaking the checks. This can
     @@ builtin/check-ignore.c: static int check_ignore(struct dir_struct *dir,
       				pattern = NULL;
       		}
      -		if (!quiet && (pattern || show_non_matching))
     --			output_pattern(pathspec.items[i].original, pattern);
     -+		if (!quiet) {
     -+			if (verbose) {
     -+				if (show_non_matching || pattern)
     -+					output_pattern(pathspec.items[i].original, pattern);
     -+			} else {
     -+				if (show_non_matching && !pattern)
     -+					output_pattern(pathspec.items[i].original, pattern);
     -+				if (!show_non_matching && pattern)
     -+					output_pattern(pathspec.items[i].original, pattern);
     -+			}
     -+		}
     ++
     ++		/* If --non-matching, then show if verbose or the pattern is missing. */
     ++		if (!quiet && show_non_matching && (verbose || !pattern))
     ++			output_pattern(pathspec.items[i].original, pattern);
     ++
     ++		/* If not --non-matching, then show if the pattern exists. */
     ++		if (!quiet && !show_non_matching && pattern)
     + 			output_pattern(pathspec.items[i].original, pattern);
     ++
       		if (pattern)
       			num_ignored++;
       	}


 Documentation/git-check-ignore.txt |  7 +++----
 builtin/check-ignore.c             | 11 ++++++++---
 t/t0008-ignores.sh                 | 17 +++++++++++++++--
 3 files changed, 26 insertions(+), 9 deletions(-)

diff --git a/Documentation/git-check-ignore.txt b/Documentation/git-check-ignore.txt
index 2892799e32f..bb096875ca3 100644
--- a/Documentation/git-check-ignore.txt
+++ b/Documentation/git-check-ignore.txt
@@ -50,10 +50,9 @@ linkgit:gitignore[5].
 	with a NUL character instead of a linefeed character.
 
 -n, --non-matching::
-	Show given paths which don't match any pattern.	 This only
-	makes sense when `--verbose` is enabled, otherwise it would
-	not be possible to distinguish between paths which match a
-	pattern and those which don't.
+	If `--verbose` is enabled, list both matching and non-matching
+	paths (non-matching paths along with the indicator `::`). Without
+	`--verbose`, list only the paths that do not match any pattern.
 
 --no-index::
 	Don't look in the index when undertaking the checks. This can
diff --git a/builtin/check-ignore.c b/builtin/check-ignore.c
index 21912569650..46108ac8593 100644
--- a/builtin/check-ignore.c
+++ b/builtin/check-ignore.c
@@ -113,8 +113,15 @@ static int check_ignore(struct dir_struct *dir,
 			    pattern->flags & PATTERN_FLAG_NEGATIVE)
 				pattern = NULL;
 		}
-		if (!quiet && (pattern || show_non_matching))
+
+		/* If --non-matching, then show if verbose or the pattern is missing. */
+		if (!quiet && show_non_matching && (verbose || !pattern))
+			output_pattern(pathspec.items[i].original, pattern);
+
+		/* If not --non-matching, then show if the pattern exists. */
+		if (!quiet && !show_non_matching && pattern)
 			output_pattern(pathspec.items[i].original, pattern);
+
 		if (pattern)
 			num_ignored++;
 	}
@@ -175,8 +182,6 @@ int cmd_check_ignore(int argc, const char **argv, const char *prefix)
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
