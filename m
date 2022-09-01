Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7982ECAAD1
	for <git@archiver.kernel.org>; Thu,  1 Sep 2022 00:30:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232208AbiIAAas (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 31 Aug 2022 20:30:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231755AbiIAAaW (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 31 Aug 2022 20:30:22 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 270F9AA3D1
        for <git@vger.kernel.org>; Wed, 31 Aug 2022 17:30:17 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id u18so7604107wrq.10
        for <git@vger.kernel.org>; Wed, 31 Aug 2022 17:30:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc;
        bh=vd2juGQY/66EKxbSOpTUM3J+R1Bw2qLH0cP0aKCrEhw=;
        b=MBkxHuIsO7KeYlYD3h9/KGzNR8Mrcl9K+BoPuLNUmR8h3JiBXbu+yylcGPGqnuI7Ob
         Jh0M5U6o0STd9XyJiYqvomrV8V2CP7plN0X3bsMb1GNwriGbcs9Y3auUMDJ8VGALVuIu
         6j0Kg+MkEITNW40jy+hv+XChrqpwPSb/hSFCAqsUKyFrEV8j12YoGni1AUfV0SOZQqb/
         w4FUH68ZxcXIrFhRljwQ2PtUKvj2+3SJjnbLvb5TP1ss6TJa94XqV+GuKCns7gsyCLk+
         KJDbkhHLQoOiofHqShJDZVDbUTNMvszkVRHEH5t+LfZlcCRN0ZV2LmVYkd5syXUqkstp
         3X9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc;
        bh=vd2juGQY/66EKxbSOpTUM3J+R1Bw2qLH0cP0aKCrEhw=;
        b=6h+P1pLxLupKarS1+49DdEmWDzs5bCWByNxp7iVbZwgdwpvHhaJbjsP719n704iS7U
         /EIftBmVZeu63cqtO1kEe4oiKAjYDPHnIoVOGauBlubOgNKAjecmIATLtWFRULEi4fzW
         6cW/n67fGCnY7DiuVF1Yo2TTtcHNOxjCT75Tsr+qivUkjEZmIkzzU0xlJc8QmAqSn1tV
         WFk6tFzVF/GOTI6RwWccKY7bWlYKi6K2/zzl4nlaFIVzFCyP/2lZYYxgDRTOMcoTM0u3
         ApmL8bHvRPwAWGxQ/snYF+aKZx6bPBFcWdo/EtcwnFVhbtlKYFAb+XOERXUq22u5BkXV
         gabQ==
X-Gm-Message-State: ACgBeo2jWKvmKzpnDGfYjjBe7awv3DGI42PPGtFqroDgRWNMrOSy/LVR
        Evu47eWYK0aDjayEzJ1CP/SOTwNhmYs=
X-Google-Smtp-Source: AA6agR701I6AKR3IxZ2pEUvdYkC+CB/fdFwvkbR3nYH8XnjcgdGVdxLAmKSfCszcLQx2MXvAUcrOzA==
X-Received: by 2002:a5d:6b10:0:b0:21e:4bbd:e893 with SMTP id v16-20020a5d6b10000000b0021e4bbde893mr13148874wrw.613.1661992216178;
        Wed, 31 Aug 2022 17:30:16 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id n18-20020a05600c501200b003a32251c3f9sm4250866wmr.5.2022.08.31.17.30.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Aug 2022 17:30:15 -0700 (PDT)
Message-Id: <32992926ba2f3e8682f6dd91819ec66b82365c3b.1661992197.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1322.git.git.1661992197.gitgitgadget@gmail.com>
References: <pull.1322.git.git.1661992197.gitgitgadget@gmail.com>
From:   "Eric Sunshine via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 01 Sep 2022 00:29:53 +0000
Subject: [PATCH 15/18] test-lib: retire "lint harder" optimization hack
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Elijah Newren <newren@gmail.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Fabian Stelzer <fs@gigacodes.de>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Eric Sunshine <sunshine@sunshineco.com>

`test_run_` in test-lib.sh "lints" the body of a test by sending it down
a `sed chainlint.sed | grep` pipeline; this happens once for each test
run by a test script. Although this pipeline may seem relatively cheap
in isolation, it can become expensive when invoked 26800+ times by `make
test`, once for each test run, despite the existence of only 16500+ test
definitions across all tests scripts.

This difference in the number of tests defined in the scripts (16500+)
and the number of tests actually run by `make test` (26800+) is
explained by the fact that some test scripts run a very large number of
small tests, all driven by a series of functions/loops which fill in the
test bodies. This means that certain test definitions are being linted
repeatedly (tens or hundreds of times) unnecessarily. To avoid such
unnecessary work, 2d86a96220 (t: avoid sed-based chain-linting in some
expensive cases, 2021-05-13) added an optimization hack which allows
individual scripts to manually suppress the unnecessary repeated linting
of the same test definition.

However, unlike chainlint.sed which checks a test body as the test is
run, chainlint.pl checks each test definition just once, no matter how
many times the test is run, thus the sort of optimization hack
introduced by 2d86a96220 is no longer needed and can be retired.
Therefore, revert 2d86a96220.

Signed-off-by: Eric Sunshine <sunshine@sunshineco.com>
---
 t/README             | 5 -----
 t/t0027-auto-crlf.sh | 7 +------
 t/t3070-wildmatch.sh | 5 -----
 t/test-lib.sh        | 7 ++-----
 4 files changed, 3 insertions(+), 21 deletions(-)

diff --git a/t/README b/t/README
index 2f439f96589..979b2d4833d 100644
--- a/t/README
+++ b/t/README
@@ -196,11 +196,6 @@ appropriately before running "make". Short options can be bundled, i.e.
 	this feature by setting the GIT_TEST_CHAIN_LINT environment
 	variable to "1" or "0", respectively.
 
-	A few test scripts disable some of the more advanced
-	chain-linting detection in the name of efficiency. You can
-	override this by setting the GIT_TEST_CHAIN_LINT_HARDER
-	environment variable to "1".
-
 --stress::
 	Run the test script repeatedly in multiple parallel jobs until
 	one of them fails.  Useful for reproducing rare failures in
diff --git a/t/t0027-auto-crlf.sh b/t/t0027-auto-crlf.sh
index a22e0e1382c..a94ac1eae37 100755
--- a/t/t0027-auto-crlf.sh
+++ b/t/t0027-auto-crlf.sh
@@ -387,9 +387,7 @@ test_expect_success 'setup main' '
 	test_tick
 '
 
-# Disable extra chain-linting for the next set of tests. There are many
-# auto-generated ones that are not worth checking over and over.
-GIT_TEST_CHAIN_LINT_HARDER_DEFAULT=0
+
 
 warn_LF_CRLF="LF will be replaced by CRLF"
 warn_CRLF_LF="CRLF will be replaced by LF"
@@ -606,9 +604,6 @@ do
 	checkout_files     ""    "$id" "crlf" true    ""       CRLF  CRLF  CRLF         CRLF_mix_CR  CRLF_nul
 done
 
-# The rest of the tests are unique; do the usual linting.
-unset GIT_TEST_CHAIN_LINT_HARDER_DEFAULT
-
 # Should be the last test case: remove some files from the worktree
 test_expect_success 'ls-files --eol -d -z' '
 	rm crlf_false_attr__CRLF.txt crlf_false_attr__CRLF_mix_LF.txt crlf_false_attr__LF.txt .gitattributes &&
diff --git a/t/t3070-wildmatch.sh b/t/t3070-wildmatch.sh
index f9539968e4c..5d871fde960 100755
--- a/t/t3070-wildmatch.sh
+++ b/t/t3070-wildmatch.sh
@@ -5,11 +5,6 @@ test_description='wildmatch tests'
 TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
-# Disable expensive chain-lint tests; all of the tests in this script
-# are variants of a few trivial test-tool invocations, and there are a lot of
-# them.
-GIT_TEST_CHAIN_LINT_HARDER_DEFAULT=0
-
 should_create_test_file() {
 	file=$1
 
diff --git a/t/test-lib.sh b/t/test-lib.sh
index 377cc1c1203..dc0d0591095 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -1091,11 +1091,8 @@ test_run_ () {
 		trace=
 		# 117 is magic because it is unlikely to match the exit
 		# code of other programs
-		if test "OK-117" != "$(test_eval_ "(exit 117) && $1${LF}${LF}echo OK-\$?" 3>&1)" ||
-		   {
-			test "${GIT_TEST_CHAIN_LINT_HARDER:-${GIT_TEST_CHAIN_LINT_HARDER_DEFAULT:-1}}" != 0 &&
-			$(printf '%s\n' "$1" | sed -f "$GIT_BUILD_DIR/t/chainlint.sed" | grep -q '?![A-Z][A-Z]*?!')
-		   }
+		if $(printf '%s\n' "$1" | sed -f "$GIT_BUILD_DIR/t/chainlint.sed" | grep -q '?![A-Z][A-Z]*?!') ||
+			test "OK-117" != "$(test_eval_ "(exit 117) && $1${LF}${LF}echo OK-\$?" 3>&1)"
 		then
 			BUG "broken &&-chain or run-away HERE-DOC: $1"
 		fi
-- 
gitgitgadget

