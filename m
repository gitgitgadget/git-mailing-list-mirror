Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9C43C433FE
	for <git@archiver.kernel.org>; Sat, 12 Nov 2022 22:07:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235158AbiKLWH5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 12 Nov 2022 17:07:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231972AbiKLWHu (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 12 Nov 2022 17:07:50 -0500
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC3C213D33
        for <git@vger.kernel.org>; Sat, 12 Nov 2022 14:07:49 -0800 (PST)
Received: by mail-wm1-x329.google.com with SMTP id ja4-20020a05600c556400b003cf6e77f89cso7223555wmb.0
        for <git@vger.kernel.org>; Sat, 12 Nov 2022 14:07:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7AYV+OX/ncoFLENZfBOfEv2ozgMlkwWFwBJhAQRzEHc=;
        b=mGj70GHE8sPxzWYSN1IbkLn3NFTsPTNTa//ZNYVAF5baDt/ghExfkMiz+EWavef5qI
         l0JKV0Ct3v2qEfu5L6l/dXbK8I53G8W6GfhSmjWmJCaF0RINnn00tZQgHvVLdNLZKnxV
         h4tm810pWPku2vNbKYYl1b1rGYMXYaKPFzpJ0qQqYq+O6ScG6rDAdK86f4YgpDUDcdXI
         1IRrvQG4X4R6qCjOOcoPI7bJFbzanMnXLHyYyMwPmiDQOsAzkfdTW7LKufLFhDJLOBc/
         q+NzHapzDsXpaxwminRp8FPgDMw5UB2P/LOQXubfQhuScPYz7Gy4U9/twKscCfRWRUOU
         wCfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7AYV+OX/ncoFLENZfBOfEv2ozgMlkwWFwBJhAQRzEHc=;
        b=RFHZCF8z2OU3GIEC4oD3cJoT1bYzYh/EL0wKfgd2UnZU/Dh8mK00mlrQL7iPFVtbc3
         w9fLPjD75jfy1HUPiKaq6mKNCZ5qYkAbECrBz26wYjUPRswbMiRBQeghNZQW1AUBYpRB
         Bq2L7m5YIEE5zBxnC22UqEBg+xXl9mNjdpR8P6eVIwsLVEYkZhXJNgY4x5HFTJUnJriw
         Pz+MlIooPFt4FPwvEc89jRhCBe+lIrzABFVX++WBEVTZ84n0mxjHNIeGzs7jTk/1Puxz
         31HvMbCq0McjHRVXTLVCOxMWhEUnSSDWX+1xZwN1muGtMKqQHd91GCPicYKic3+488Sj
         EsWQ==
X-Gm-Message-State: ANoB5pl5irFN4RWxCmZZe47PKePTLaNx1SUB567pbAHvjZaRaVb+1XMY
        TpVcXVz+/TW0y3ybF82rn2MHGNZ0/OY=
X-Google-Smtp-Source: AA0mqf5GaIgQuBhzExBenOjzkpW1K9V4AsafwdBEX4e+CyDRJNfTh2mmLMckrhT9J19M//H3L9JpXg==
X-Received: by 2002:a05:600c:2195:b0:3cf:6c2f:950c with SMTP id e21-20020a05600c219500b003cf6c2f950cmr4724557wme.146.1668290868053;
        Sat, 12 Nov 2022 14:07:48 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id o7-20020a05600c4fc700b003a6125562e1sm8286720wmq.46.2022.11.12.14.07.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 12 Nov 2022 14:07:46 -0800 (PST)
Message-Id: <a7f4265ceb26c6dd9d347ef4cbef2aac7d60bf13.1668290855.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1309.v3.git.1668290855.gitgitgadget@gmail.com>
References: <pull.1309.v2.git.1662469859.gitgitgadget@gmail.com>
        <pull.1309.v3.git.1668290855.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sat, 12 Nov 2022 22:07:34 +0000
Subject: [PATCH v3 2/2] tests(mingw): avoid very slow `mingw_test_cmp`
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

Note: Earlier attempts at fixing this involved a test helper that avoids
the overhead of the diff machinery, in favor of implementing a behavior
that is more in line with what `mingw_test_cmp` does now, but that
attempt saw a lot of backlash and distractions during review and was
therefore abandoned.

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
