Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7A92E1FAFB
	for <e@80x24.org>; Sun,  9 Apr 2017 19:11:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752524AbdDITLP (ORCPT <rfc822;e@80x24.org>);
        Sun, 9 Apr 2017 15:11:15 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:35117 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752427AbdDITLN (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 9 Apr 2017 15:11:13 -0400
Received: by mail-wm0-f68.google.com with SMTP id d79so6334809wmi.2
        for <git@vger.kernel.org>; Sun, 09 Apr 2017 12:11:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=HJUUNPCQoSQZQb4NEmE3C/HHdMDlROziyip61rEZoHc=;
        b=cN+5/LKo3fqB4A28KDGIfDQ1bQURuX9xXniTlpNem0+cqDJ9xojU9RiRJJ0/jv20L+
         wg79M9VPt75EqTYtwzhdypT/Y1k/hq8rv+D25N+jVbrlW9gckWznDnaYWmpXPkP0j++1
         oFtF8GgqtgV6LYsOGEk5SPyh33PgvVJrWXnqzWP8bOLfZjcUpTV4BaLvb/pmHY2lDGbo
         yLom0hjfP6FNWt21ivbFOT3pLiawtqcalR283s5GJ6xEGOuPrA31+bPn8LY+gq13mo47
         ffvKL6DE+Q3EOP6Qk4MMKbahwlTW7xxEMCrIRIPSP+yJzRmrk9Io/2tRljYNu3fQdXwr
         5cew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=HJUUNPCQoSQZQb4NEmE3C/HHdMDlROziyip61rEZoHc=;
        b=q7NdO+S8LlXnDwvH/TSV/o9//MV7IiE/CCu/FjwW9lxQB8AOzY8fjYdY7FJTcFLgTg
         lLiMH2FFBSexiQFiXnNU/GrxoS7nHDjA+BlLzAyHHSt0Vok2vw1dMMkaROOCfSE4OiFl
         QssGTSA72ARCIrolZnP7MbNOt6hyupXdT07fhgSCARu7JGoAdBf9tRVJjmV3fSYnpT0K
         F4IhDd3906f0zb4rletkfHd9NcEpk6VWCfRkI6tW0KiFqgkgi6CfhrTTy4wpE9X3c5YK
         OYqVJSNZPKnjBpEgslDBOabsSLBH+syNAobwrMQymAzzM5bUPGlE2SVdE1gD1uvaoRJ0
         rlMA==
X-Gm-Message-State: AN3rC/7KYaPimUVMzYAQTNVUQxWS/nqHrkXKybTHMEbZNS2rl3BXJUvA
        dSDDeADGnlQvHsqM
X-Received: by 10.28.107.129 with SMTP id a1mr7581640wmi.47.1491765071850;
        Sun, 09 Apr 2017 12:11:11 -0700 (PDT)
Received: from slxBook4.fritz.box (p5DDB5F77.dip0.t-ipconnect.de. [93.219.95.119])
        by smtp.gmail.com with ESMTPSA id k13sm7319675wmi.28.2017.04.09.12.11.10
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Sun, 09 Apr 2017 12:11:11 -0700 (PDT)
From:   Lars Schneider <larsxschneider@gmail.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, peff@peff.net, tboegi@web.de, e@80x24.org,
        ttaylorr@github.com
Subject: [PATCH v3 2/4] t0021: make debug log file name configurable
Date:   Sun,  9 Apr 2017 21:11:05 +0200
Message-Id: <20170409191107.20547-3-larsxschneider@gmail.com>
X-Mailer: git-send-email 2.12.2
In-Reply-To: <20170409191107.20547-1-larsxschneider@gmail.com>
References: <20170409191107.20547-1-larsxschneider@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The "rot13-filter.pl" helper wrote its debug logs always to "rot13-filter.log".
Make this configurable by defining the log file as first parameter of
"rot13-filter.pl".

This is useful if "rot13-filter.pl" is configured multiple times similar to the
subsequent patch 'convert: add "status=delayed" to filter process protocol'.

Signed-off-by: Lars Schneider <larsxschneider@gmail.com>
---
 t/t0021-conversion.sh   | 44 ++++++++++++++++++++++----------------------
 t/t0021/rot13-filter.pl |  8 +++++---
 2 files changed, 27 insertions(+), 25 deletions(-)

diff --git a/t/t0021-conversion.sh b/t/t0021-conversion.sh
index ff2424225b..0139b460e7 100755
--- a/t/t0021-conversion.sh
+++ b/t/t0021-conversion.sh
@@ -28,7 +28,7 @@ file_size () {
 }
 
 filter_git () {
-	rm -f rot13-filter.log &&
+	rm -f *.log &&
 	git "$@"
 }
 
@@ -342,7 +342,7 @@ test_expect_success 'diff does not reuse worktree files that need cleaning' '
 '
 
 test_expect_success PERL 'required process filter should filter data' '
-	test_config_global filter.protocol.process "rot13-filter.pl clean smudge" &&
+	test_config_global filter.protocol.process "rot13-filter.pl debug.log clean smudge" &&
 	test_config_global filter.protocol.required true &&
 	rm -rf repo &&
 	mkdir repo &&
@@ -375,7 +375,7 @@ test_expect_success PERL 'required process filter should filter data' '
 			IN: clean testsubdir/test3 '\''sq'\'',\$x=.r $S3 [OK] -- OUT: $S3 . [OK]
 			STOP
 		EOF
-		test_cmp_count expected.log rot13-filter.log &&
+		test_cmp_count expected.log debug.log &&
 
 		git commit -m "test commit 2" &&
 		rm -f test2.r "testsubdir/test3 '\''sq'\'',\$x=.r" &&
@@ -388,7 +388,7 @@ test_expect_success PERL 'required process filter should filter data' '
 			IN: smudge testsubdir/test3 '\''sq'\'',\$x=.r $S3 [OK] -- OUT: $S3 . [OK]
 			STOP
 		EOF
-		test_cmp_exclude_clean expected.log rot13-filter.log &&
+		test_cmp_exclude_clean expected.log debug.log &&
 
 		filter_git checkout --quiet --no-progress empty-branch &&
 		cat >expected.log <<-EOF &&
@@ -397,7 +397,7 @@ test_expect_success PERL 'required process filter should filter data' '
 			IN: clean test.r $S [OK] -- OUT: $S . [OK]
 			STOP
 		EOF
-		test_cmp_exclude_clean expected.log rot13-filter.log &&
+		test_cmp_exclude_clean expected.log debug.log &&
 
 		filter_git checkout --quiet --no-progress master &&
 		cat >expected.log <<-EOF &&
@@ -409,7 +409,7 @@ test_expect_success PERL 'required process filter should filter data' '
 			IN: smudge testsubdir/test3 '\''sq'\'',\$x=.r $S3 [OK] -- OUT: $S3 . [OK]
 			STOP
 		EOF
-		test_cmp_exclude_clean expected.log rot13-filter.log &&
+		test_cmp_exclude_clean expected.log debug.log &&
 
 		test_cmp_committed_rot13 "$TEST_ROOT/test.o" test.r &&
 		test_cmp_committed_rot13 "$TEST_ROOT/test2.o" test2.r &&
@@ -419,7 +419,7 @@ test_expect_success PERL 'required process filter should filter data' '
 
 test_expect_success PERL 'required process filter takes precedence' '
 	test_config_global filter.protocol.clean false &&
-	test_config_global filter.protocol.process "rot13-filter.pl clean" &&
+	test_config_global filter.protocol.process "rot13-filter.pl debug.log clean" &&
 	test_config_global filter.protocol.required true &&
 	rm -rf repo &&
 	mkdir repo &&
@@ -439,12 +439,12 @@ test_expect_success PERL 'required process filter takes precedence' '
 			IN: clean test.r $S [OK] -- OUT: $S . [OK]
 			STOP
 		EOF
-		test_cmp_count expected.log rot13-filter.log
+		test_cmp_count expected.log debug.log
 	)
 '
 
 test_expect_success PERL 'required process filter should be used only for "clean" operation only' '
-	test_config_global filter.protocol.process "rot13-filter.pl clean" &&
+	test_config_global filter.protocol.process "rot13-filter.pl debug.log clean" &&
 	rm -rf repo &&
 	mkdir repo &&
 	(
@@ -462,7 +462,7 @@ test_expect_success PERL 'required process filter should be used only for "clean
 			IN: clean test.r $S [OK] -- OUT: $S . [OK]
 			STOP
 		EOF
-		test_cmp_count expected.log rot13-filter.log &&
+		test_cmp_count expected.log debug.log &&
 
 		rm test.r &&
 
@@ -474,12 +474,12 @@ test_expect_success PERL 'required process filter should be used only for "clean
 			init handshake complete
 			STOP
 		EOF
-		test_cmp_exclude_clean expected.log rot13-filter.log
+		test_cmp_exclude_clean expected.log debug.log
 	)
 '
 
 test_expect_success PERL 'required process filter should process multiple packets' '
-	test_config_global filter.protocol.process "rot13-filter.pl clean smudge" &&
+	test_config_global filter.protocol.process "rot13-filter.pl debug.log clean smudge" &&
 	test_config_global filter.protocol.required true &&
 
 	rm -rf repo &&
@@ -514,7 +514,7 @@ test_expect_success PERL 'required process filter should process multiple packet
 			IN: clean 3pkt_2+1.file $(($S*2+1)) [OK] -- OUT: $(($S*2+1)) ... [OK]
 			STOP
 		EOF
-		test_cmp_count expected.log rot13-filter.log &&
+		test_cmp_count expected.log debug.log &&
 
 		rm -f *.file &&
 
@@ -529,7 +529,7 @@ test_expect_success PERL 'required process filter should process multiple packet
 			IN: smudge 3pkt_2+1.file $(($S*2+1)) [OK] -- OUT: $(($S*2+1)) ... [OK]
 			STOP
 		EOF
-		test_cmp_exclude_clean expected.log rot13-filter.log &&
+		test_cmp_exclude_clean expected.log debug.log &&
 
 		for FILE in *.file
 		do
@@ -539,7 +539,7 @@ test_expect_success PERL 'required process filter should process multiple packet
 '
 
 test_expect_success PERL 'required process filter with clean error should fail' '
-	test_config_global filter.protocol.process "rot13-filter.pl clean smudge" &&
+	test_config_global filter.protocol.process "rot13-filter.pl debug.log clean smudge" &&
 	test_config_global filter.protocol.required true &&
 	rm -rf repo &&
 	mkdir repo &&
@@ -558,7 +558,7 @@ test_expect_success PERL 'required process filter with clean error should fail'
 '
 
 test_expect_success PERL 'process filter should restart after unexpected write failure' '
-	test_config_global filter.protocol.process "rot13-filter.pl clean smudge" &&
+	test_config_global filter.protocol.process "rot13-filter.pl debug.log clean smudge" &&
 	rm -rf repo &&
 	mkdir repo &&
 	(
@@ -579,7 +579,7 @@ test_expect_success PERL 'process filter should restart after unexpected write f
 		git add . &&
 		rm -f *.r &&
 
-		rm -f rot13-filter.log &&
+		rm -f debug.log &&
 		git checkout --quiet --no-progress . 2>git-stderr.log &&
 
 		grep "smudge write error at" git-stderr.log &&
@@ -595,7 +595,7 @@ test_expect_success PERL 'process filter should restart after unexpected write f
 			IN: smudge test2.r $S2 [OK] -- OUT: $S2 . [OK]
 			STOP
 		EOF
-		test_cmp_exclude_clean expected.log rot13-filter.log &&
+		test_cmp_exclude_clean expected.log debug.log &&
 
 		test_cmp_committed_rot13 "$TEST_ROOT/test.o" test.r &&
 		test_cmp_committed_rot13 "$TEST_ROOT/test2.o" test2.r &&
@@ -609,7 +609,7 @@ test_expect_success PERL 'process filter should restart after unexpected write f
 '
 
 test_expect_success PERL 'process filter should not be restarted if it signals an error' '
-	test_config_global filter.protocol.process "rot13-filter.pl clean smudge" &&
+	test_config_global filter.protocol.process "rot13-filter.pl debug.log clean smudge" &&
 	rm -rf repo &&
 	mkdir repo &&
 	(
@@ -639,7 +639,7 @@ test_expect_success PERL 'process filter should not be restarted if it signals a
 			IN: smudge test2.r $S2 [OK] -- OUT: $S2 . [OK]
 			STOP
 		EOF
-		test_cmp_exclude_clean expected.log rot13-filter.log &&
+		test_cmp_exclude_clean expected.log debug.log &&
 
 		test_cmp_committed_rot13 "$TEST_ROOT/test.o" test.r &&
 		test_cmp_committed_rot13 "$TEST_ROOT/test2.o" test2.r &&
@@ -648,7 +648,7 @@ test_expect_success PERL 'process filter should not be restarted if it signals a
 '
 
 test_expect_success PERL 'process filter abort stops processing of all further files' '
-	test_config_global filter.protocol.process "rot13-filter.pl clean smudge" &&
+	test_config_global filter.protocol.process "rot13-filter.pl debug.log clean smudge" &&
 	rm -rf repo &&
 	mkdir repo &&
 	(
@@ -676,7 +676,7 @@ test_expect_success PERL 'process filter abort stops processing of all further f
 			IN: smudge abort.r $SA [OK] -- OUT: 0 [ABORT]
 			STOP
 		EOF
-		test_cmp_exclude_clean expected.log rot13-filter.log &&
+		test_cmp_exclude_clean expected.log debug.log &&
 
 		test_cmp "$TEST_ROOT/test.o" test.r &&
 		test_cmp "$TEST_ROOT/test2.o" test2.r &&
diff --git a/t/t0021/rot13-filter.pl b/t/t0021/rot13-filter.pl
index 617f581e56..0b943bb377 100644
--- a/t/t0021/rot13-filter.pl
+++ b/t/t0021/rot13-filter.pl
@@ -2,8 +2,9 @@
 # Example implementation for the Git filter protocol version 2
 # See Documentation/gitattributes.txt, section "Filter Protocol"
 #
-# The script takes the list of supported protocol capabilities as
-# arguments ("clean", "smudge", etc).
+# The first argument defines a debug log file that the script write to.
+# All remaining arguments define a list of supported protocol
+# capabilities ("clean", "smudge", etc).
 #
 # This implementation supports special test cases:
 # (1) If data with the pathname "clean-write-fail.r" is processed with
@@ -24,9 +25,10 @@ use warnings;
 use IO::File;
 
 my $MAX_PACKET_CONTENT_SIZE = 65516;
+my $log_file                = shift @ARGV;
 my @capabilities            = @ARGV;
 
-open my $debug, ">>", "rot13-filter.log" or die "cannot open log file: $!";
+open my $debug, ">>", $log_file or die "cannot open log file: $!";
 
 sub rot13 {
 	my $str = shift;
-- 
2.12.2

