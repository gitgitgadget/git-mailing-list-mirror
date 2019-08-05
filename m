Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0E2621F731
	for <e@80x24.org>; Mon,  5 Aug 2019 21:04:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730600AbfHEVE6 (ORCPT <rfc822;e@80x24.org>);
        Mon, 5 Aug 2019 17:04:58 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:43778 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730454AbfHEVE6 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Aug 2019 17:04:58 -0400
Received: by mail-wr1-f67.google.com with SMTP id p13so11176116wru.10
        for <git@vger.kernel.org>; Mon, 05 Aug 2019 14:04:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Eq5NbVE8Hn4WrRT8ss4XT3FI3czb78+sLfqPQKzeQmc=;
        b=uL5n4WppTq/tfplYkU1w0gB/JRE3hT+QrDCjeJut/B5jFNyGe/n6c46HDwBpuhfV8l
         /Vet02NSS7yVbVECIdNxTd1u+QluJKh6apdJuTAumL9aeKFny69NF7ooDuOI6kZJ+Yf9
         Y7I2CwEN07lEYD9cT3RRpG9cj688pxvU9qyQitOFrt9FtvL3qf9s2QYmRdhnIA03F0mN
         lmPddrtb9DuZRIl7KaPoC6Hd0X15efvFtA18ObW9ayPk49kw7/oi63BuP8zM9uDrGMAv
         pQefhP5PuWOQSgIa6gWhOTKjfP7syPHvQcweSe5H2VnlzZeHeEPfKB+ymR81XdfI7XKD
         /74g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Eq5NbVE8Hn4WrRT8ss4XT3FI3czb78+sLfqPQKzeQmc=;
        b=cfTVHYCxCzKnH5mFqLKo2VXNJpdd7eiXQNkjlH3LMjEFgNh3UJVem+6Tn/h05qI3hq
         SIdLkYCqqO/uIMvgGvvnuUF6Vreq8S2NGWbe6HvXrJy/1qCthW+ew9KPavdTNte4tPdI
         xeFDxJU7reD960fEnR4XvuJtaD9VZQxPYn7nFndam6EXHtiPhDj96s3ISMiRxz1vLpZv
         zsvnYQ67jlQU8mjYNtPmmiw4jjRmgEAl8iL0aOgmbwu6Fhw6vdlEjBXCLjZfnHGjum5K
         P7H7WY4GI7ERHZR46mccGIeG11LPmpA2/kcxJ4f39oZSNAlIuo3oMddWMPmC+14P2ZF3
         cKPg==
X-Gm-Message-State: APjAAAUGoWFOh10JR439v6YNHPKh24y2K60m/60yKjljEypht6OLdVQM
        lpIwYbm/wouxafOI1NwTZWk=
X-Google-Smtp-Source: APXvYqxuK0NkYshlc/OzpKgmeb1DriPLmb8PsIr7d2S1mkVpt5IZgRGkU6jRXIXtQOqV78tiS+cNwg==
X-Received: by 2002:a5d:5607:: with SMTP id l7mr59183wrv.228.1565039095784;
        Mon, 05 Aug 2019 14:04:55 -0700 (PDT)
Received: from localhost.localdomain (x4db4a28a.dyn.telefonica.de. [77.180.162.138])
        by smtp.gmail.com with ESMTPSA id s12sm82312179wmh.34.2019.08.05.14.04.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 05 Aug 2019 14:04:55 -0700 (PDT)
From:   =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        git@vger.kernel.org,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCH v2 2/2] tests: show the test name and number at the start of verbose output
Date:   Mon,  5 Aug 2019 23:04:47 +0200
Message-Id: <20190805210447.7169-3-szeder.dev@gmail.com>
X-Mailer: git-send-email 2.23.0.rc1.309.g896d8c5f5f
In-Reply-To: <20190805210447.7169-1-szeder.dev@gmail.com>
References: <20190803080126.29488-1-szeder.dev@gmail.com>
 <20190805210447.7169-1-szeder.dev@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The verbose output of every test looks something like this:

  expecting success:
          echo content >file &&
          git add file &&
          git commit -m "add file"

  [master (root-commit) d1fbfbd] add file
   Author: A U Thor <author@example.com>
   1 file changed, 1 insertion(+)
   create mode 100644 file
  ok 1 - commit works

i.e. first an "expecting success" (or "checking known breakage") line
followed by the commands to be executed, then the output of those
comamnds, and finally an "ok"/"not ok" line containing the test name.
Note that the test's name is only shown at the very end.

With '-x' tracing enabled and/or in longer tests the verbose output
might be several screenfulls long, making it harder than necessary to
find where the output of the test with a given name starts (especially
when the outputs to different file descriptors are racing, and the
"expecting success"/command block arrives earlier than the "ok" line
of the previous test).

Print the test name at the start of the test's verbose output, i.e. at
the end of the "expecting success" and "checking known breakage"
lines, to make the start of a particular test a bit easier to
recognize.  Also print the test script and test case numbers, to help
those poor souls who regularly have to scan through the combined
verbose output of several test scripts.

So the dummy test above would start like this:

  expecting success of 9999.1 'commit works':
          echo content >file &&
  [...]

Signed-off-by: SZEDER Gábor <szeder.dev@gmail.com>
---
 t/t0000-basic.sh        | 8 ++++----
 t/test-lib-functions.sh | 4 ++--
 t/test-lib.sh           | 2 ++
 3 files changed, 8 insertions(+), 6 deletions(-)

diff --git a/t/t0000-basic.sh b/t/t0000-basic.sh
index d2b3dde89e..360eae5348 100755
--- a/t/t0000-basic.sh
+++ b/t/t0000-basic.sh
@@ -285,14 +285,14 @@ test_expect_success C_LOCALE_OUTPUT 'test --verbose' '
 	mv t1234-verbose/out t1234-verbose/out+ &&
 	grep -v "^Initialized empty" t1234-verbose/out+ >t1234-verbose/out &&
 	check_sub_test_lib_test t1234-verbose <<-\EOF
-	> expecting success: true
+	> expecting success of 1234.1 '\''passing test'\'': true
 	> ok 1 - passing test
 	> Z
-	> expecting success: echo foo
+	> expecting success of 1234.2 '\''test with output'\'': echo foo
 	> foo
 	> ok 2 - test with output
 	> Z
-	> expecting success: false
+	> expecting success of 1234.3 '\''failing test'\'': false
 	> not ok 3 - failing test
 	> #	false
 	> Z
@@ -313,7 +313,7 @@ test_expect_success 'test --verbose-only' '
 	check_sub_test_lib_test t2345-verbose-only-2 <<-\EOF
 	> ok 1 - passing test
 	> Z
-	> expecting success: echo foo
+	> expecting success of 2345.2 '\''test with output'\'': echo foo
 	> foo
 	> ok 2 - test with output
 	> Z
diff --git a/t/test-lib-functions.sh b/t/test-lib-functions.sh
index d4f199391f..a3d06899e2 100644
--- a/t/test-lib-functions.sh
+++ b/t/test-lib-functions.sh
@@ -580,7 +580,7 @@ test_expect_failure () {
 	export test_prereq
 	if ! test_skip "$@"
 	then
-		say >&3 "checking known breakage: $2"
+		say >&3 "checking known breakage of $TEST_NUMBER.$test_count '$1': $2"
 		if test_run_ "$2" expecting_failure
 		then
 			test_known_broken_ok_ "$1"
@@ -600,7 +600,7 @@ test_expect_success () {
 	export test_prereq
 	if ! test_skip "$@"
 	then
-		say >&3 "expecting success: $2"
+		say >&3 "expecting success of $TEST_NUMBER.$test_count '$1': $2"
 		if test_run_ "$2"
 		then
 			test_ok_ "$1"
diff --git a/t/test-lib.sh b/t/test-lib.sh
index 30b07e310f..a9d45642a5 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -212,6 +212,8 @@ fi
 
 TEST_STRESS_JOB_SFX="${GIT_TEST_STRESS_JOB_NR:+.stress-$GIT_TEST_STRESS_JOB_NR}"
 TEST_NAME="$(basename "$0" .sh)"
+TEST_NUMBER="${TEST_NAME%%-*}"
+TEST_NUMBER="${TEST_NUMBER#t}"
 TEST_RESULTS_DIR="$TEST_OUTPUT_DIRECTORY/test-results"
 TEST_RESULTS_BASE="$TEST_RESULTS_DIR/$TEST_NAME$TEST_STRESS_JOB_SFX"
 TRASH_DIRECTORY="trash directory.$TEST_NAME$TEST_STRESS_JOB_SFX"
-- 
2.23.0.rc1.309.g896d8c5f5f

