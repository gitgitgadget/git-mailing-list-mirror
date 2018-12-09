Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 28D4620A1E
	for <e@80x24.org>; Sun,  9 Dec 2018 22:56:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726545AbeLIW4o (ORCPT <rfc822;e@80x24.org>);
        Sun, 9 Dec 2018 17:56:44 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:54291 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726475AbeLIW4n (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 9 Dec 2018 17:56:43 -0500
Received: by mail-wm1-f65.google.com with SMTP id a62so1692060wmh.4
        for <git@vger.kernel.org>; Sun, 09 Dec 2018 14:56:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=y8W7fYQ59mfqZOWf6bxorMVaxPQd3x7Do5LuVpmLLgo=;
        b=Cuk4ht922A9t4nwJVXZaoIdf4kisD4YrFnm6uZ5djjqdSDfZU8LtfRgoerpzFiEr0+
         rl+rspeUV1Uk6QuR4DqUbfFqfFZHFTJ765LjuaEeSaWh0431+RBj04Xi3IB9LPjBMiPA
         mVMAK8r7FNUhLhjBThEFADWKqSTe/80SLaoz3I4DDFvHXjorIj0aDOJroOM+O7WkgQzy
         cDw89efhfdylgAnOPKW4z3s5Sgl1N9LJVtbINTWAFKfAqZvG8iQbwg89HM3NBd/CxOmR
         x26owrNcdVYyfWpp9rNI8DQO2Um8/PbuH2rCm7MTwpDCDurisjL90Dx8jfT5x0AFUAlT
         CSvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=y8W7fYQ59mfqZOWf6bxorMVaxPQd3x7Do5LuVpmLLgo=;
        b=dE4bEoxTxsYWPdOwhBGlZlJbk81c7LeNFPporo4Pe929BjkmgY9lfsdZSieSWS0B7u
         2sfbfPjXEvrmem8JOr0YyS4x1J7IGnhSEHjSw7fXa15noIErLEP6XbriNzMcSDN/0nWo
         2rzNTuGKm1sttd3WnmhdHqn94DcRshfKudS5ZYatjxJ2Y3RsHiYfbX2KB/9D6D2hDapm
         YVEJkspXGtli3rAzalLmxs0ulTs9oHx8OzTs5nhrC/uq4hB/5+kjAeg3B16xNbrdw+BF
         J5cRVB81Sq5NnC3P/pEhqPK8ceYjKeiSWmliiSMf+K0qzKQA+izJuT1jDhF8IvddM1ap
         4XBw==
X-Gm-Message-State: AA+aEWaiPyFdjzTL4EwhcmeBkDcL9p0wvdpj9Xxxj1supq0ofJphZTrW
        hwK5t6KE8NST+hFVrDYXzFgs1kv9
X-Google-Smtp-Source: AFSGD/X3eXO654HP4MEEcxWeDY15/1SQu2n4IcOCV7Aza2y6ibXWmUK4Sn7sv2A53dde3I+A3/Z1fw==
X-Received: by 2002:a1c:d988:: with SMTP id q130mr9126909wmg.41.1544396199743;
        Sun, 09 Dec 2018 14:56:39 -0800 (PST)
Received: from localhost.localdomain (x4db97970.dyn.telefonica.de. [77.185.121.112])
        by smtp.gmail.com with ESMTPSA id w6sm12581807wme.46.2018.12.09.14.56.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 09 Dec 2018 14:56:39 -0800 (PST)
From:   =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCH v2 3/7] test-lib: consolidate naming of test-results paths
Date:   Sun,  9 Dec 2018 23:56:24 +0100
Message-Id: <20181209225628.22216-4-szeder.dev@gmail.com>
X-Mailer: git-send-email 2.20.0.rc2.156.g5a9fd2ce9c
In-Reply-To: <20181209225628.22216-1-szeder.dev@gmail.com>
References: <20181204163457.15717-1-szeder.dev@gmail.com>
 <20181209225628.22216-1-szeder.dev@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

There are two places where we strip off any leading path components
and the '.sh' suffix from the test script's pathname, and there are
four places where we construct the name of the 't/test-results'
directory or the name of various test-specific files in there.  The
last patch in this series will add even more.

Factor these out into helper variables to avoid repeating ourselves.

Signed-off-by: SZEDER Gábor <szeder.dev@gmail.com>
---
 t/test-lib.sh | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/t/test-lib.sh b/t/test-lib.sh
index 5577d9dc5a..09c77cbd1b 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -90,6 +90,10 @@ do
 	esac
 done
 
+TEST_NAME="$(basename "$0" .sh)"
+TEST_RESULTS_DIR="$TEST_OUTPUT_DIRECTORY/test-results"
+TEST_RESULTS_BASE="$TEST_RESULTS_DIR/$TEST_NAME"
+
 # if --tee was passed, write the output not only to the terminal, but
 # additionally to the file test-results/$BASENAME.out, too.
 if test "$GIT_TEST_TEE_STARTED" = "done"
@@ -98,12 +102,11 @@ then
 elif test -n "$tee" || test -n "$verbose_log" ||
      test -n "$valgrind" || test -n "$valgrind_only"
 then
-	mkdir -p "$TEST_OUTPUT_DIRECTORY/test-results"
-	BASE="$TEST_OUTPUT_DIRECTORY/test-results/$(basename "$0" .sh)"
+	mkdir -p "$TEST_RESULTS_DIR"
 
 	# Make this filename available to the sub-process in case it is using
 	# --verbose-log.
-	GIT_TEST_TEE_OUTPUT_FILE=$BASE.out
+	GIT_TEST_TEE_OUTPUT_FILE=$TEST_RESULTS_BASE.out
 	export GIT_TEST_TEE_OUTPUT_FILE
 
 	# Truncate before calling "tee -a" to get rid of the results
@@ -111,8 +114,8 @@ then
 	>"$GIT_TEST_TEE_OUTPUT_FILE"
 
 	(GIT_TEST_TEE_STARTED=done ${TEST_SHELL_PATH} "$0" "$@" 2>&1;
-	 echo $? >"$BASE.exit") | tee -a "$GIT_TEST_TEE_OUTPUT_FILE"
-	test "$(cat "$BASE.exit")" = 0
+	 echo $? >"$TEST_RESULTS_BASE.exit") | tee -a "$GIT_TEST_TEE_OUTPUT_FILE"
+	test "$(cat "$TEST_RESULTS_BASE.exit")" = 0
 	exit
 fi
 
@@ -829,12 +832,9 @@ test_done () {
 
 	if test -z "$HARNESS_ACTIVE"
 	then
-		test_results_dir="$TEST_OUTPUT_DIRECTORY/test-results"
-		mkdir -p "$test_results_dir"
-		base=${0##*/}
-		test_results_path="$test_results_dir/${base%.sh}.counts"
+		mkdir -p "$TEST_RESULTS_DIR"
 
-		cat >"$test_results_path" <<-EOF
+		cat >"$TEST_RESULTS_BASE.counts" <<-EOF
 		total $test_count
 		success $test_success
 		fixed $test_fixed
@@ -1040,7 +1040,7 @@ then
 fi
 
 # Test repository
-TRASH_DIRECTORY="trash directory.$(basename "$0" .sh)"
+TRASH_DIRECTORY="trash directory.$TEST_NAME"
 test -n "$root" && TRASH_DIRECTORY="$root/$TRASH_DIRECTORY"
 case "$TRASH_DIRECTORY" in
 /*) ;; # absolute path is good
-- 
2.20.0.rc2.156.g5a9fd2ce9c

