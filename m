Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0116D211B3
	for <e@80x24.org>; Tue,  4 Dec 2018 16:35:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726629AbeLDQfS (ORCPT <rfc822;e@80x24.org>);
        Tue, 4 Dec 2018 11:35:18 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:34559 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726385AbeLDQfS (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 Dec 2018 11:35:18 -0500
Received: by mail-wm1-f66.google.com with SMTP id y185so9806359wmd.1
        for <git@vger.kernel.org>; Tue, 04 Dec 2018 08:35:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=p2KIkqUTPtRpjvB5fttJduXGDa8vyM1BsblFyZte5rw=;
        b=qoYFJorREYn/fNeqpeeuz5eIPdel4tD2wAPpsiLjRITHs7XD9lMmmgB57wypEVflDu
         f9zBaDPXNAOj1BgB+GVG9s5VuzBBcyjctYeb4rRbkyn4AbjFiTdwSdSNWJk8PkWXS7j1
         YYjsAlAvtwo3iHXlRknEaiyPKMq/EzpbpiCYZWYQIFuIABMDpw5ej5fx6WI/Hnz562Zc
         7flhOignDLTaLwk5rxS2bXgVCbfXnZyQtJF3FtfXU3MS90+xSzLYRezWSh4BUTfhsdb4
         n25xeiHgIdW3RJUkIdLZhEv5uvd0brVG1nWj4yyraL80ls3lvMl8iV+81AXz4mlF5RoN
         j6cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=p2KIkqUTPtRpjvB5fttJduXGDa8vyM1BsblFyZte5rw=;
        b=Hjs92mwnTl4iLSsKd5wmI4k4AKGtoWifDHotupId1vvPS68bxb65uQfuCdDqCfubeN
         1oLIV+G874+WbJRRhuyoYFX3XUGwNQdFihe0Mj/ZhxMRhoPpt34To6/yEH360IhA/Txv
         c4D45shMdRS+/jrMMIGYbVlWNMoc1JBiXU2tDlW8/DvojZw7FIRf380d4Yb5K7tcIYDv
         8MTth3eRH/aXBF60LASs0QJtqwh0Njno3QA2StQcgU9bzdzwDOVmdtcOj0JezjvXC+RA
         GUSa6jvXQcadbeHU/4nJutPvIRfaNXfQzB8bAFHQjtJJZCaA1X+Q/6JSZwAtcG1LyIdJ
         1tRg==
X-Gm-Message-State: AA+aEWY8NXVpNx/hP/F8DWu2GscjpRlm63tGxK/wECcF3UTrFVkPrfZF
        MtblaiGkIFugSxoRIduKXmBcGDSp
X-Google-Smtp-Source: AFSGD/UX6hbUof6UXrI98oj6NAVcdAimKfXsUFFHGBk451Ta6+Lrmtv0OYCjJmSMozyvBQoerEOZkw==
X-Received: by 2002:a1c:7306:: with SMTP id d6mr2757455wmb.98.1543941316753;
        Tue, 04 Dec 2018 08:35:16 -0800 (PST)
Received: from localhost.localdomain (x4db19e3e.dyn.telefonica.de. [77.177.158.62])
        by smtp.gmail.com with ESMTPSA id f130sm7911389wme.41.2018.12.04.08.35.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 04 Dec 2018 08:35:16 -0800 (PST)
From:   =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCH 1/3] test-lib: consolidate naming of test-results paths
Date:   Tue,  4 Dec 2018 17:34:55 +0100
Message-Id: <20181204163457.15717-2-szeder.dev@gmail.com>
X-Mailer: git-send-email 2.20.0.rc2.156.g5a9fd2ce9c
In-Reply-To: <20181204163457.15717-1-szeder.dev@gmail.com>
References: <20181204163457.15717-1-szeder.dev@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

There are two places where we strip off any leading path components
and the '.sh' suffix from the test script's pathname, and there are
two places where we construct the filename of test output files in
't/test-results/'.  The last patch in this series will add even more.

Factor these out into helper variables to avoid repeating ourselves.

Signed-off-by: SZEDER Gábor <szeder.dev@gmail.com>
---
 t/test-lib.sh | 21 ++++++++++-----------
 1 file changed, 10 insertions(+), 11 deletions(-)

diff --git a/t/test-lib.sh b/t/test-lib.sh
index 0f1faa24b2..49e4563405 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -71,6 +71,9 @@ then
 	exit 1
 fi
 
+TEST_NAME="$(basename "$0" .sh)"
+TEST_RESULTS_BASE="$TEST_OUTPUT_DIRECTORY/test-results/$TEST_NAME"
+
 # if --tee was passed, write the output not only to the terminal, but
 # additionally to the file test-results/$BASENAME.out, too.
 case "$GIT_TEST_TEE_STARTED, $* " in
@@ -78,12 +81,11 @@ done,*)
 	# do not redirect again
 	;;
 *' --tee '*|*' --va'*|*' -V '*|*' --verbose-log '*)
-	mkdir -p "$TEST_OUTPUT_DIRECTORY/test-results"
-	BASE="$TEST_OUTPUT_DIRECTORY/test-results/$(basename "$0" .sh)"
+	mkdir -p "$(dirname "$TEST_RESULTS_BASE")"
 
 	# Make this filename available to the sub-process in case it is using
 	# --verbose-log.
-	GIT_TEST_TEE_OUTPUT_FILE=$BASE.out
+	GIT_TEST_TEE_OUTPUT_FILE=$TEST_RESULTS_BASE.out
 	export GIT_TEST_TEE_OUTPUT_FILE
 
 	# Truncate before calling "tee -a" to get rid of the results
@@ -91,8 +93,8 @@ done,*)
 	>"$GIT_TEST_TEE_OUTPUT_FILE"
 
 	(GIT_TEST_TEE_STARTED=done ${TEST_SHELL_PATH} "$0" "$@" 2>&1;
-	 echo $? >"$BASE.exit") | tee -a "$GIT_TEST_TEE_OUTPUT_FILE"
-	test "$(cat "$BASE.exit")" = 0
+	 echo $? >"$TEST_RESULTS_BASE.exit") | tee -a "$GIT_TEST_TEE_OUTPUT_FILE"
+	test "$(cat "$TEST_RESULTS_BASE.exit")" = 0
 	exit
 	;;
 esac
@@ -818,12 +820,9 @@ test_done () {
 
 	if test -z "$HARNESS_ACTIVE"
 	then
-		test_results_dir="$TEST_OUTPUT_DIRECTORY/test-results"
-		mkdir -p "$test_results_dir"
-		base=${0##*/}
-		test_results_path="$test_results_dir/${base%.sh}.counts"
+		mkdir -p "$(dirname "$TEST_RESULTS_BASE")"
 
-		cat >"$test_results_path" <<-EOF
+		cat >"$TEST_RESULTS_BASE.counts" <<-EOF
 		total $test_count
 		success $test_success
 		fixed $test_fixed
@@ -1029,7 +1028,7 @@ then
 fi
 
 # Test repository
-TRASH_DIRECTORY="trash directory.$(basename "$0" .sh)"
+TRASH_DIRECTORY="trash directory.$TEST_NAME"
 test -n "$root" && TRASH_DIRECTORY="$root/$TRASH_DIRECTORY"
 case "$TRASH_DIRECTORY" in
 /*) ;; # absolute path is good
-- 
2.20.0.rc2.156.g5a9fd2ce9c

