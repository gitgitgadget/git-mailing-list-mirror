Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2491FC43217
	for <git@archiver.kernel.org>; Mon, 14 Nov 2022 14:07:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236750AbiKNOHX (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 14 Nov 2022 09:07:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236720AbiKNOHN (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 14 Nov 2022 09:07:13 -0500
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CE072A94C
        for <git@vger.kernel.org>; Mon, 14 Nov 2022 06:07:09 -0800 (PST)
Received: by mail-wm1-x332.google.com with SMTP id ja4-20020a05600c556400b003cf6e77f89cso9403041wmb.0
        for <git@vger.kernel.org>; Mon, 14 Nov 2022 06:07:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=A2uzC6AxoPD3JDmvkYxpTZtVxlyNvAr+A++4Xb/sDvo=;
        b=e/pYpfPr2RxmrNs1jiUAIgZALZsLeXG/OQ+aYCIp/DVzjP0cfznYjUP4VzUD1xOy6+
         t8KZUCgbDmOGd8LqLdvEt7igFQLi0gA31HnmTNEhyKmblzC241utpeHv4DUjWVPi9SOk
         OB8c6HsxhEc6GtPktdO4eg34O+kN9QEh/X3M+LlkVHVEPUxjYun9mlfs7/9+21q3JsF6
         MxExaMk/SixdZb6S7o+1IbhCIas6IC2rm2opaygNRzeL+eROmCONYMw/cO27RnU7EjTK
         cCKHt9A//6IyigUOL819hSEKSWaPrtwst22EUkawoc6RmxrO90mPobQDYJJNc3lWzKXL
         RuFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=A2uzC6AxoPD3JDmvkYxpTZtVxlyNvAr+A++4Xb/sDvo=;
        b=4EO+eu9kqPFGRXLMRvCPLhk15tNiEu3pdDCUPfw3mM0sbiMRjMwVyZca6PgRSlR5zt
         Ov17k0ZUU/C712sEcHt08JEocFX8U49ws6laQb6vjVzJwLX6mqQ0upR6JaYE2qmo22q5
         KbrAFjbznCZfQjvgo60P4WaHwcaZOqpDlHI2CKWP17NEcXNxsP2dD0DuNCF/pNKuy9D4
         n/nw3xuKqbXezDrUrC5ZP1IOQA6BWKny5D/co3HpoqxXiRKjZnL7CYYYe2R6VecF+v2z
         Anp8aiQWwWWVjZYMPEiqV9cjsBB++hdZ1Q8cYCykOe7ScnLPVqLFIyPn7vVtNEv+1lJF
         udLQ==
X-Gm-Message-State: ANoB5pkCGizDFP3yNTNIZETuzoO1LNojoU0DnjAiv1so+wusc02/zYOC
        O30xswEkS7MSEWvUPl/j1n2pU5xptss=
X-Google-Smtp-Source: AA0mqf7UhopauCDZ/RjaCbm9IlUHwy7tgKOE6q6NnUMGDEUJqpylR/zHjtL25AWKmwg6Nb8wBG/uWw==
X-Received: by 2002:a05:600c:2255:b0:3cf:77c0:48ea with SMTP id a21-20020a05600c225500b003cf77c048eamr7917729wmm.130.1668434818747;
        Mon, 14 Nov 2022 06:06:58 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id m23-20020a05600c3b1700b003cf47556f21sm19710189wms.2.2022.11.14.06.06.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Nov 2022 06:06:57 -0800 (PST)
Message-Id: <128b1f348d8fad730cac1c36d3082fab49904b2c.1668434812.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1309.v4.git.1668434812.gitgitgadget@gmail.com>
References: <pull.1309.v3.git.1668290855.gitgitgadget@gmail.com>
        <pull.1309.v4.git.1668434812.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 14 Nov 2022 14:06:52 +0000
Subject: [PATCH v4 2/2] tests(mingw): avoid very slow `mingw_test_cmp`
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

It is more performant to run `git diff --no-index` than running the
`mingw_test_cmp` code with MSYS2's Bash, i.e. the Bash that Git for
Windows uses. And a lot more readable.

The original reason why Git's test suite needs the `mingw_test_cmp`
function at all (and why `cmp` is not good enough) is that Git's test
suite is not actually trying to compare binary files when it calls
`test_cmp`, but it compares text files. And those text files can contain
CR/LF line endings depending on the circumstances.

Note: The original fix in the Git for Windows project implemented a test
helper that avoids the overhead of the diff machinery, in favor of
implementing a behavior that is more in line with what `mingw_test_cmp`
does now. This was done to minimize the risk in using something as
complex as the diff machinery to perform something as simple as
determining whether text output is identical to the expected output or
not. This approach has served Git for Windows well for years, but the
attempt to upstream this saw a lot of backlash and distractions during
the review, was disliked by the Git maintainer and was therefore
abandoned. For full details, see the thread at
https://lore.kernel.org/git/pull.1309.git.1659106382128.gitgitgadget@gmail.com/t

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
