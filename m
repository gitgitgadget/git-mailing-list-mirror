Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2ADA9C352A1
	for <git@archiver.kernel.org>; Tue,  6 Dec 2022 15:11:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235351AbiLFPLS (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 6 Dec 2022 10:11:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235166AbiLFPKz (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 6 Dec 2022 10:10:55 -0500
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E1482FFF9
        for <git@vger.kernel.org>; Tue,  6 Dec 2022 07:07:55 -0800 (PST)
Received: by mail-wr1-x42d.google.com with SMTP id h10so14338960wrx.3
        for <git@vger.kernel.org>; Tue, 06 Dec 2022 07:07:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EjLyL3xAtTDMbX3MbLiqHpJtf5at+fryDXk2uUIKFCs=;
        b=E+gvErxbRY73jAsGrdhRJEclzz1UmJDyYabLyCaBJBv6+WDzP/A0omXWesRngAL+wm
         czWkiL1Kb4yNenIe5NIVcX4osptEvHfJtM+KRNnKkk7a9La+qidLep8wn9qXvUtDRzr+
         0WQ505Te0HA2eRXBVsRBM02EqZf20qkykEy2treA5UTzLsC/S+6wsQiaWNrh/SNI/TvX
         FJtA6fZZYbbIxH72mmLVaxh3L+xynzCmp3y9mo08s3EFrZ80+Xoibbs1yLs+mvh8QHOf
         PC7pOtaII0wDs+u+/tJR49LMZFXx2hr7PQfbH4rWzq5eACvsyE2HoB3XfOkIz7rx6Sjz
         0SDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EjLyL3xAtTDMbX3MbLiqHpJtf5at+fryDXk2uUIKFCs=;
        b=KZOBXrwqMZnQat1XeKZHUrBawEiOXyItDXrQRuCUcHfIOk6lVou7H+M8qI2QDSDoj9
         5BQDzhPhTK3e5tu1j1H0RPMdBf3pJqnaXXXhNMn22BZOpCiykhjuWglJpVQ7vUaRebyG
         m0kagOX5S/1GXz9sejW6j5cReHXFPKrdjlCh9R8nipXMcFtIPXjt/Puz3mbynUb33MKr
         aKS+sKRPK4Y8b5fwwt27gk8tVUKfYpjGXqYMHqK6nIu1YriGoPf5yoLl/D+JFjefkI9E
         BtZraEMSjXd0pN+bZflaXrsNzaU81HH5jsq3E0FlERjVw5Dv1VDu9RHxKgynCi6IMDKw
         zItw==
X-Gm-Message-State: ANoB5pnKllbAVpIGkOOuRtTruitm3CCVGbmSeE64LTYx6yjFdjf1pM/1
        OJQvVCG24mZBfry748mTb4CbNugmv4I=
X-Google-Smtp-Source: AA0mqf6vvZUP3w37zjO2N9v1EYJoiTUHMH91PO8eDujINVsi/yhvWAPXo3BLVbcbK91hQOeBVpex/Q==
X-Received: by 2002:adf:cf0c:0:b0:242:3b03:66da with SMTP id o12-20020adfcf0c000000b002423b0366damr13513987wrj.368.1670339272289;
        Tue, 06 Dec 2022 07:07:52 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id i2-20020adff302000000b002421a8f4fa6sm16837131wro.92.2022.12.06.07.07.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Dec 2022 07:07:51 -0800 (PST)
Message-Id: <6a80fab7e3936ec56e1583d6136d47487327e907.1670339267.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1309.v5.git.1670339267.gitgitgadget@gmail.com>
References: <pull.1309.v4.git.1668434812.gitgitgadget@gmail.com>
        <pull.1309.v5.git.1670339267.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 06 Dec 2022 15:07:47 +0000
Subject: [PATCH v5 2/2] tests(mingw): avoid very slow `mingw_test_cmp`
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     =?UTF-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

When Git's test suite uses `test_cmp`, it is not actually trying to
compare binary files as the name `cmp` would suggest to users familiar
with Unix' tools, but the tests instead verify that actual output
matches the expected text.

On Unix, `cmp` works well enough for Git's purposes because only Line
Feed characters are used as line endings. However, on Windows, while
most tools accept Line Feeds as line endings, many tools produce
Carriage Return + Line Feed line endings, including some of the tools
used by the test suite (which are therefore provided via Git for Windows
SDK). Therefore, `cmp` would frequently fail merely due to different
line endings.

To accommodate for that, the `mingw_test_cmp` function was introduced
into Git's test suite to perform a line-by-line comparison that ignores
line endings. This function is a Bash function that is only used on
Windows, everywhere else `cmp` is used.

This is a double whammy because `cmp` is fast, and `mingw_test_cmp` is
slow, even more so on Windows because it is a Bash script function, and
Bash scripts are known to run particularly slowly on Windows due to
Bash's need for the POSIX emulation layer provided by the MSYS2 runtime.

The commit message of 32ed3314c104 (t5351: avoid using `test_cmp` for
binary data, 2022-07-29) provides an illuminating account of the
consequences: On Windows, the platform on which Git could really use all
the help it can get to improve its performance, the time spent on one
entire test script was reduced from half an hour to less than half a
minute merely by avoiding a single call to `mingw_test_cmp` in but a
single test case.

Learning the lesson to avoid shell scripting wherever possible, the Git
for Windows project implemented a minimal replacement for
`mingw_test_cmp` in the form of a `test-tool` subcommand that parses the
input files line by line, ignoring line endings, and compares them.
Essentially the same thing as `mingw_test_cmp`, but implemented in
C instead of Bash. This solution served the Git for Windows project
well, over years.

However, when this solution was finally upstreamed, the conclusion was
reached that a change to use `git diff --no-index` instead of
`mingw_test_cmp` was more easily reviewed and hence should be used
instead.

The reason why this approach was not even considered in Git for Windows
is that in 2007, there was already a motion on the table to use Git's
own diff machinery to perform comparisons in Git's test suite, but it
was dismissed in https://lore.kernel.org/git/xmqqbkrpo9or.fsf@gitster.g/
as undesirable because tests might potentially succeed due to bugs in
the diff machinery when they should not succeed, and those bugs could
therefore hide regressions that the tests try to prevent.

By the time Git for Windows' `mingw-test-cmp` in C was finally
contributed to the Git mailing list, reviewers agreed that the diff
machinery had matured enough and should be used instead.

When the concern was raised that the diff machinery, due to its
complexity, would perform substantially worse than the test helper
originally implemented in the Git for Windows project, a test
demonstrated that these performance differences are well lost within the
100+ minutes it takes to run Git's test suite on Windows.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 t/test-lib-functions.sh | 66 -----------------------------------------
 t/test-lib.sh           |  2 +-
 2 files changed, 1 insertion(+), 67 deletions(-)

diff --git a/t/test-lib-functions.sh b/t/test-lib-functions.sh
index 8c44856eaec..452fe9bc8aa 100644
--- a/t/test-lib-functions.sh
+++ b/t/test-lib-functions.sh
@@ -1541,72 +1541,6 @@ test_skip_or_die () {
 	error "$2"
 }
 
-# The following mingw_* functions obey POSIX shell syntax, but are actually
-# bash scripts, and are meant to be used only with bash on Windows.
-
-# A test_cmp function that treats LF and CRLF equal and avoids to fork
-# diff when possible.
-mingw_test_cmp () {
-	# Read text into shell variables and compare them. If the results
-	# are different, use regular diff to report the difference.
-	local test_cmp_a= test_cmp_b=
-
-	# When text came from stdin (one argument is '-') we must feed it
-	# to diff.
-	local stdin_for_diff=
-
-	# Since it is difficult to detect the difference between an
-	# empty input file and a failure to read the files, we go straight
-	# to diff if one of the inputs is empty.
-	if test -s "$1" && test -s "$2"
-	then
-		# regular case: both files non-empty
-		mingw_read_file_strip_cr_ test_cmp_a <"$1"
-		mingw_read_file_strip_cr_ test_cmp_b <"$2"
-	elif test -s "$1" && test "$2" = -
-	then
-		# read 2nd file from stdin
-		mingw_read_file_strip_cr_ test_cmp_a <"$1"
-		mingw_read_file_strip_cr_ test_cmp_b
-		stdin_for_diff='<<<"$test_cmp_b"'
-	elif test "$1" = - && test -s "$2"
-	then
-		# read 1st file from stdin
-		mingw_read_file_strip_cr_ test_cmp_a
-		mingw_read_file_strip_cr_ test_cmp_b <"$2"
-		stdin_for_diff='<<<"$test_cmp_a"'
-	fi
-	test -n "$test_cmp_a" &&
-	test -n "$test_cmp_b" &&
-	test "$test_cmp_a" = "$test_cmp_b" ||
-	eval "diff -u \"\$@\" $stdin_for_diff"
-}
-
-# $1 is the name of the shell variable to fill in
-mingw_read_file_strip_cr_ () {
-	# Read line-wise using LF as the line separator
-	# and use IFS to strip CR.
-	local line
-	while :
-	do
-		if IFS=$'\r' read -r -d $'\n' line
-		then
-			# good
-			line=$line$'\n'
-		else
-			# we get here at EOF, but also if the last line
-			# was not terminated by LF; in the latter case,
-			# some text was read
-			if test -z "$line"
-			then
-				# EOF, really
-				break
-			fi
-		fi
-		eval "$1=\$$1\$line"
-	done
-}
-
 # Like "env FOO=BAR some-program", but run inside a subshell, which means
 # it also works for shell functions (though those functions cannot impact
 # the environment outside of the test_env invocation).
diff --git a/t/test-lib.sh b/t/test-lib.sh
index 7726d1da88a..f8c6205e08f 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -1546,7 +1546,7 @@ case $uname_s in
 	test_set_prereq SED_STRIPS_CR
 	test_set_prereq GREP_STRIPS_CR
 	test_set_prereq WINDOWS
-	GIT_TEST_CMP=mingw_test_cmp
+	GIT_TEST_CMP="GIT_DIR=/dev/null git diff --no-index --ignore-cr-at-eol --"
 	;;
 *CYGWIN*)
 	test_set_prereq POSIXPERM
-- 
gitgitgadget
