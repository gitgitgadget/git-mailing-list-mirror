Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 098FC1F6A9
	for <e@80x24.org>; Sat,  5 Jan 2019 01:09:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726289AbfAEBJW (ORCPT <rfc822;e@80x24.org>);
        Fri, 4 Jan 2019 20:09:22 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:40380 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726276AbfAEBJV (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 4 Jan 2019 20:09:21 -0500
Received: by mail-wr1-f67.google.com with SMTP id p4so38039745wrt.7
        for <git@vger.kernel.org>; Fri, 04 Jan 2019 17:09:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=8T2pHMy6FRJhm/bfrHVRkFzlSW7NzISMJha97riL11k=;
        b=mW3lYozm4htmO5mo4hcNeVXD2t/RDz+PPMD5IA51mk1AFuqJ69WQdaHi36itC9JPW9
         LuVWW43EFHVcBsbncLRMV0uvI5zH/mokPhg96jr6hWIwjKgdEUURzryoRaRmg5EoSOqx
         ChPFf/nAq7PPJWkZ0t4uqkpFT7ePBgoNAUBZs8BkYwBtJpdabbzZlKppidVSaKR+bpKv
         eHpA/CK9gNcBeTmeiEPYad2LUMo/mg7JiikzqKUF3YNrd/9DR/DffHxQCVBwC4rLwaMo
         PLSCVu0i1cBk7NTbAjheJgHy6MjB6tQmwtd25HNxm9raXEn8KzKvqkvUTnqBcHHaoG3D
         3xOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8T2pHMy6FRJhm/bfrHVRkFzlSW7NzISMJha97riL11k=;
        b=qgGDubtUDp9kNPOX6lKhvJopdHBvW+pKhCpW2Yvk+L4+cxIJ5CIYqeCpyp2FU7pH8H
         +LfAxpB5CZQH3MfN+0fxF0Am0xUe+dpulv/QcqO8yuxV4Vfa3P23IRe4dBLqH6LzpkWN
         L7BoqH1nmF5mUZlGWQXrVvCNxzUN4UyIVXTY0wNM58iVtYmC2EQ9fi5Nk4NYZrZ43kjP
         KjKTERPn8oRmdNblSsu4bvyDaQcQI+7srj5w1I9Mn1ThxHDjYFGvkf4PELaLA0KKalYd
         ztYe9dTkA5V3cGjzZY/1hSPjb5DGPNxBn2dXTL0A2y8KnXDXNRpnKLSz8eXE94hEf8Jb
         PlAg==
X-Gm-Message-State: AJcUukdZzvMw/YpjrH05IBXBh129cnskAmcccVFfZcGPRWMEbUWkLLC5
        GHPuPFW4vvv2+I5Z1c36GMk=
X-Google-Smtp-Source: ALg8bN65gQi2Rp2bRL7z1ajDOsIrVZQ1F2Y+m5Xr3O/6HKwG6aLP5zP5Is1DbDMXY0aDEysumaXCOA==
X-Received: by 2002:adf:dbcb:: with SMTP id e11mr47671996wrj.58.1546650559316;
        Fri, 04 Jan 2019 17:09:19 -0800 (PST)
Received: from localhost.localdomain (94-21-23-250.pool.digikabel.hu. [94.21.23.250])
        by smtp.gmail.com with ESMTPSA id c15sm1851353wml.27.2019.01.04.17.09.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 04 Jan 2019 17:09:18 -0800 (PST)
From:   =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jeff King <peff@peff.net>, git@vger.kernel.org,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCH v4 5/8] test-lib: consolidate naming of test-results paths
Date:   Sat,  5 Jan 2019 02:08:56 +0100
Message-Id: <20190105010859.11031-6-szeder.dev@gmail.com>
X-Mailer: git-send-email 2.20.1.151.gec613c4b75
In-Reply-To: <20190105010859.11031-1-szeder.dev@gmail.com>
References: <20181230191629.3232-1-szeder.dev@gmail.com>
 <20190105010859.11031-1-szeder.dev@gmail.com>
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
index 14ccb60838..5720292641 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -160,6 +160,10 @@ then
 	test -z "$verbose_log" && verbose=t
 fi
 
+TEST_NAME="$(basename "$0" .sh)"
+TEST_RESULTS_DIR="$TEST_OUTPUT_DIRECTORY/test-results"
+TEST_RESULTS_BASE="$TEST_RESULTS_DIR/$TEST_NAME"
+
 # if --tee was passed, write the output not only to the terminal, but
 # additionally to the file test-results/$BASENAME.out, too.
 if test "$GIT_TEST_TEE_STARTED" = "done"
@@ -167,12 +171,11 @@ then
 	: # do not redirect again
 elif test -n "$tee"
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
@@ -180,8 +183,8 @@ then
 	>"$GIT_TEST_TEE_OUTPUT_FILE"
 
 	(GIT_TEST_TEE_STARTED=done ${TEST_SHELL_PATH} "$0" "$@" 2>&1;
-	 echo $? >"$BASE.exit") | tee -a "$GIT_TEST_TEE_OUTPUT_FILE"
-	test "$(cat "$BASE.exit")" = 0
+	 echo $? >"$TEST_RESULTS_BASE.exit") | tee -a "$GIT_TEST_TEE_OUTPUT_FILE"
+	test "$(cat "$TEST_RESULTS_BASE.exit")" = 0
 	exit
 fi
 
@@ -840,12 +843,9 @@ test_done () {
 
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
@@ -1051,7 +1051,7 @@ then
 fi
 
 # Test repository
-TRASH_DIRECTORY="trash directory.$(basename "$0" .sh)"
+TRASH_DIRECTORY="trash directory.$TEST_NAME"
 test -n "$root" && TRASH_DIRECTORY="$root/$TRASH_DIRECTORY"
 case "$TRASH_DIRECTORY" in
 /*) ;; # absolute path is good
-- 
2.20.1.151.gec613c4b75

