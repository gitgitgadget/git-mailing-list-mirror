Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 970B71F404
	for <e@80x24.org>; Wed, 12 Sep 2018 18:38:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727873AbeILXns (ORCPT <rfc822;e@80x24.org>);
        Wed, 12 Sep 2018 19:43:48 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:40633 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727651AbeILXns (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Sep 2018 19:43:48 -0400
Received: by mail-pg1-f196.google.com with SMTP id l63-v6so1489331pga.7
        for <git@vger.kernel.org>; Wed, 12 Sep 2018 11:38:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=PgiUStnVmKb4M8dSzY7UGEOPkr8sDxV3Yr3Kmm4D6Po=;
        b=hVNxUm1pQD0kIh1GmgiyYEL61G3BrYR2ZSfteA+c5SC90+QBTyqCQix/CNPJ1/Lw8X
         +t5WY1+MzvcHZpZtsnm9JtykqICdBr7/EuaSM9dusN+Iwk6gRTozJZW38koOD6OIavNM
         gMsiEGJgVhPhuplEITiodfXU1wSyOKw1/drAmSlOsv26VRXcYCxtjghOQUVpm5Hz0tbd
         33UkKMJ3i7zJLNUx8aWVM8LI4icXg8IFdYZqeHvV9AKUpUA4PNVnlyqlbdPz3+OuMc0r
         ydf/ZBxoMHUclS2tRrWcqSyqAtSI6sECdHrPxLkx8KP5+f8azuPY25iWut4ac1jEW10l
         6i4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=PgiUStnVmKb4M8dSzY7UGEOPkr8sDxV3Yr3Kmm4D6Po=;
        b=mtOlYI3EkFjRXzJTjA2qVn8NfB1cKoGqQyVGrL6xvP3CfmboDzEXpK3AmvRscLn6Hg
         oaxKvppFRnm+Jn3IEJy72KKKbA/ckAMcGyxyMA6Ti+bbRk88Y01oXxc8duD10+SpHm7M
         3okJL1x1uHt6o5R+inHSujobteJawI0A3fNb6jlGmFU2yr6nxY8Xfbbwnz1nkDoGWUhe
         OgyYR14pucyxnSYuxLh7GBGtg8l/yZskCeFGpffzqZLHI/jIzRocOE7qDZpBum734yOJ
         gcC/bKw27nsL5bnZ+CRcTRR08h/dixBFxVdcLAzhf4Pp41pI3cXv+/Elz9PHUuR+Kmoh
         Fa5g==
X-Gm-Message-State: APzg51CuLIEUqzP4Y1EqdPkS6ZlEIGU38BGh5RRWxxRE3mmiu4tCtPxz
        7yJmR+JnhQrPlve/7SsR4vVefdYk
X-Google-Smtp-Source: ANB0VdaVaB6uCvi4DfDYcSZnRa5fKtI7mzwkLq2LnE39YgkdJYrzcRW+/PWKKChOuontRL+wxrm7Yg==
X-Received: by 2002:a63:1750:: with SMTP id 16-v6mr177808pgx.31.1536777481008;
        Wed, 12 Sep 2018 11:38:01 -0700 (PDT)
Received: from localhost.localdomain (c-76-102-118-240.hsd1.ca.comcast.net. [76.102.118.240])
        by smtp.gmail.com with ESMTPSA id x4-v6sm2292172pfm.119.2018.09.12.11.38.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 12 Sep 2018 11:38:00 -0700 (PDT)
From:   William Chargin <wchargin@gmail.com>
To:     git@vger.kernel.org, sunshine@sunshineco.com
Cc:     William Chargin <wchargin@gmail.com>, jrnieder@gmail.com,
        peff@peff.net
Subject: [PATCH v4] test_dir_is_empty: fix edge cases with newlines and hyphens
Date:   Wed, 12 Sep 2018 11:37:55 -0700
Message-Id: <20180912183755.7875-1-wchargin@gmail.com>
X-Mailer: git-send-email 2.18.0.549.gd66323a05
In-Reply-To: <CAPig+cQSg-t6KGj3s0LJi+FU7LSQMNTmSHhMJJH=PgMUU9GWOA@mail.gmail.com>
References: <CAPig+cQSg-t6KGj3s0LJi+FU7LSQMNTmSHhMJJH=PgMUU9GWOA@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

While the `test_dir_is_empty` function appears correct in most normal
use cases, it can improperly pass if a directory contains a filename
with a newline, and can improperly fail if an empty directory looks like
an argument to `ls`. This patch changes the implementation to check that
the output of `ls -a` has at most two lines (for `.` and `..`), which
should be better behaved, and adds the `--` delimiter before the
directory name when invoking `ls`.

The newly added unit test fails before this change and passes after it.

Signed-off-by: William Chargin <wchargin@gmail.com>
---
This patch depends on "t: factor out FUNNYNAMES as shared lazy prereq"
(2018-08-06), which is now in master.

I originally wrote this patch for the standalone Sharness library, but
that library advises that such patches be sent to the Git mailing list
first.

Tested on GNU/Linux (Mint 18.2) and macOS (10.13).

 t/t0000-basic.sh        | 43 +++++++++++++++++++++++++++++++++++++++++
 t/test-lib-functions.sh |  2 +-
 2 files changed, 44 insertions(+), 1 deletion(-)

diff --git a/t/t0000-basic.sh b/t/t0000-basic.sh
index 850f651e4e..a5c57c6aa5 100755
--- a/t/t0000-basic.sh
+++ b/t/t0000-basic.sh
@@ -821,6 +821,49 @@ test_expect_success 'tests clean up even on failures' "
 	EOF
 "
 
+test_expect_success FUNNYNAMES \
+	'test_dir_is_empty behaves even in pathological cases' "
+	run_sub_test_lib_test \
+		dir-empty 'behavior of test_dir_is_empty' <<-\\EOF &&
+	test_expect_success 'should pass with actually empty directory' '
+		mkdir empty_dir &&
+		test_dir_is_empty empty_dir
+	'
+	test_expect_success 'should fail with a normal filename' '
+		mkdir nonempty_dir &&
+		>nonempty_dir/some_file &&
+		! test_dir_is_empty nonempty_dir
+	'
+	test_expect_success 'should fail with dot-newline-dot filename' '
+		mkdir pathological_dir &&
+		>\"pathological_dir/.
+	.\" &&
+		! test_dir_is_empty pathological_dir
+	'
+	test_expect_success 'should pass with an empty directory \"-l\"' '
+		mkdir -- -l &&
+		test_dir_is_empty -l &&
+		rmdir -- -l
+	'
+	test_expect_success 'should pass with an empty directory \"--wat\"' '
+		mkdir -- --wat &&
+		test_dir_is_empty --wat &&
+		rmdir -- --wat
+	'
+	test_done
+	EOF
+	check_sub_test_lib_test dir-empty <<-\\EOF
+	> ok 1 - should pass with actually empty directory
+	> ok 2 - should fail with a normal filename
+	> ok 3 - should fail with dot-newline-dot filename
+	> ok 4 - should pass with an empty directory \"-l\"
+	> ok 5 - should pass with an empty directory \"--wat\"
+	> # passed all 5 test(s)
+	> 1..5
+	EOF
+"
+
+
 ################################################################
 # Basics of the basics
 
diff --git a/t/test-lib-functions.sh b/t/test-lib-functions.sh
index 4207af4077..3df6b8027f 100644
--- a/t/test-lib-functions.sh
+++ b/t/test-lib-functions.sh
@@ -576,7 +576,7 @@ test_path_exists () {
 # Check if the directory exists and is empty as expected, barf otherwise.
 test_dir_is_empty () {
 	test_path_is_dir "$1" &&
-	if test -n "$(ls -a1 "$1" | egrep -v '^\.\.?$')"
+	if test "$(ls -a1 -- "$1" | wc -l)" -gt 2
 	then
 		echo "Directory '$1' is not empty, it contains:"
 		ls -la "$1"
-- 
2.18.0.549.gd66323a05

