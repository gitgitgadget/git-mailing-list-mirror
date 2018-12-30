Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A67081F770
	for <e@80x24.org>; Sun, 30 Dec 2018 19:17:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726722AbeL3TRA (ORCPT <rfc822;e@80x24.org>);
        Sun, 30 Dec 2018 14:17:00 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:53002 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726432AbeL3TQ5 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 30 Dec 2018 14:16:57 -0500
Received: by mail-wm1-f66.google.com with SMTP id m1so22374765wml.2
        for <git@vger.kernel.org>; Sun, 30 Dec 2018 11:16:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=PTT3+cx2wgGX7JG24QBqYkK5kyTyhNCQHB1sb5ffYhM=;
        b=SbFvtFTAhpZXSScUR1YNM1Z2a5o0/aMkMHSjBq1Ao5lovXB1fLQG5YvTy04btXdFIl
         jBfhdU5llLIVHXWvRT3KTdXuEAVEs/DrOuX/PJuVpbeI2qg4Nr1VOpmSj8rs3JTykPdZ
         VkpDhld36lN1URauoLDgIyXz/gicxewk39/W5PWeZ7dryKeB8iQKfOLABQqWqLwnL4iI
         3/4TZTlK8fe/WX+iRhpxw+9eY1kwlN1jC4lBLygrSHSMHmiCMmC5PNxbfTJn20WGvu5n
         CFJzk2hHaDuXLnzUfX27yvWh167vdIXcYXs8rmoHOSrL9UsQft+rMrg2fZogEiYW3IRZ
         q1Og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=PTT3+cx2wgGX7JG24QBqYkK5kyTyhNCQHB1sb5ffYhM=;
        b=KUJRR/2g/2Pnv0lzSc7gOShSrPAQoVJRwUq779DAo6Ngi3mabt4XVS0WqSHlX50WL7
         j1KhO+ZzW668u2br+fZV1FBMJvRynBo1wtgNibp5R2FiDphlfoPYk5nygLiKTKgXie2C
         pkQoIHDWGwPm+A0yJivhubHdWDG0/3QAlGpwZh37C6mrcpUxnm+KUpbLABdvPmR8hcGk
         TC1O+XiIoS6msfGSGKPidsURbmLsmGHpSbgwpG6nciEyMQPKHAJQ1OgPzjVv8itA6MEd
         1xv5I5qKJqaakWdyM4lhdrrt+/h2lQc9VXH6JWbzbo1SVYNUxaMk7436bKR/hdliM1R2
         el8g==
X-Gm-Message-State: AJcUukfme0r0l3jO97jeD93ZaaYw1iu7tHIPTJmxwApJlfpUB0MptCd7
        oeRdhmRTHk2OpePXieDJ2nY=
X-Google-Smtp-Source: AFSGD/V7cX4gyj3qKhXAeWI5aT5cmY+q7tpzGrkWcxKIIUIiRXgYqz4QI8TGBu3GDbJmQbj7Irajeg==
X-Received: by 2002:a1c:8b09:: with SMTP id n9mr29252004wmd.38.1546197415730;
        Sun, 30 Dec 2018 11:16:55 -0800 (PST)
Received: from localhost.localdomain (84-236-109-65.pool.digikabel.hu. [84.236.109.65])
        by smtp.gmail.com with ESMTPSA id h62sm28954226wmf.11.2018.12.30.11.16.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 30 Dec 2018 11:16:54 -0800 (PST)
From:   =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jeff King <peff@peff.net>, git@vger.kernel.org,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCH v3 4/8] test-lib: consolidate naming of test-results paths
Date:   Sun, 30 Dec 2018 20:16:25 +0100
Message-Id: <20181230191629.3232-5-szeder.dev@gmail.com>
X-Mailer: git-send-email 2.20.1.151.gec613c4b75
In-Reply-To: <20181230191629.3232-1-szeder.dev@gmail.com>
References: <20181209225628.22216-1-szeder.dev@gmail.com>
 <20181230191629.3232-1-szeder.dev@gmail.com>
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
index fcc04afdff..41457d1dcf 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -183,6 +183,10 @@ then
 	verbose=t
 fi
 
+TEST_NAME="$(basename "$0" .sh)"
+TEST_RESULTS_DIR="$TEST_OUTPUT_DIRECTORY/test-results"
+TEST_RESULTS_BASE="$TEST_RESULTS_DIR/$TEST_NAME"
+
 # if --tee was passed, write the output not only to the terminal, but
 # additionally to the file test-results/$BASENAME.out, too.
 if test "$GIT_TEST_TEE_STARTED" = "done"
@@ -190,12 +194,11 @@ then
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
@@ -203,8 +206,8 @@ then
 	>"$GIT_TEST_TEE_OUTPUT_FILE"
 
 	(GIT_TEST_TEE_STARTED=done ${TEST_SHELL_PATH} "$0" "$@" 2>&1;
-	 echo $? >"$BASE.exit") | tee -a "$GIT_TEST_TEE_OUTPUT_FILE"
-	test "$(cat "$BASE.exit")" = 0
+	 echo $? >"$TEST_RESULTS_BASE.exit") | tee -a "$GIT_TEST_TEE_OUTPUT_FILE"
+	test "$(cat "$TEST_RESULTS_BASE.exit")" = 0
 	exit
 fi
 
@@ -835,12 +838,9 @@ test_done () {
 
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
@@ -1046,7 +1046,7 @@ then
 fi
 
 # Test repository
-TRASH_DIRECTORY="trash directory.$(basename "$0" .sh)"
+TRASH_DIRECTORY="trash directory.$TEST_NAME"
 test -n "$root" && TRASH_DIRECTORY="$root/$TRASH_DIRECTORY"
 case "$TRASH_DIRECTORY" in
 /*) ;; # absolute path is good
-- 
2.20.1.151.gec613c4b75

