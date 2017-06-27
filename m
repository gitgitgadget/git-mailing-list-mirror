Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1917D2082F
	for <e@80x24.org>; Tue, 27 Jun 2017 12:10:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753086AbdF0MKq (ORCPT <rfc822;e@80x24.org>);
        Tue, 27 Jun 2017 08:10:46 -0400
Received: from mail-wr0-f194.google.com ([209.85.128.194]:34221 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753071AbdF0MKn (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Jun 2017 08:10:43 -0400
Received: by mail-wr0-f194.google.com with SMTP id k67so31615341wrc.1
        for <git@vger.kernel.org>; Tue, 27 Jun 2017 05:10:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=kMAv7DT/28bx8iZWi1vAKpkG37ACF26UY0QquS0lWY8=;
        b=HxGvwyjp7DwsMEZibEmUZL2Uz7JNSftMeZfSirvDzAULn7og3rjeQ4iUXx3a5b2ccr
         AF9u1kWVPprHRujs5Ev8/SXW17OUJWyUdNQ0UFOU1mT/NobpJgjB1RVidgu5bhA6Hggt
         b+E9X76mwCxT7HidjBlj+aHTJm1E7BOruduQKvwDE7xfYdt+Yz20MIEp8xLYR8I1uZbo
         KZPdZ41tKFFp4Rus5pmSDN2kv61KQIXdVzZeNtom5s/+nRQlu+TZPTLkxQG2nlYhJWmO
         gYo1E+S7WmjBU4IHa+siceJ4F07XoLS+zjnbcu4vDZjIiR+jkFSovRKZnyu7CXfZDceF
         hrnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=kMAv7DT/28bx8iZWi1vAKpkG37ACF26UY0QquS0lWY8=;
        b=ownnpMmf4UzwC0MLO7jMjhQWS3FHKM3oVM+bap03Ay8S9cikRwBRZncP6fY+FPnOCV
         8wBSAAdVhcpQU2W9r1G8bmVMYa8A48kPJZhBH+Q/meKImEsP6nb89xJ+yDtFjCcKFR+Q
         AKLvdnLM09t6WHjkGCHPBeoMeeW+cta0qaKwSap4npoVEl7MpBO8JdwtFEO24vVJeaoQ
         9lXaZk1xh7VYKTzkPv2bJsUDQlxX+C2XphVRFUpxvdezWVVzKvVwZBhgANzm2iqhkT3u
         vqHxpA7OjBd6dUbh4j5zvno4QurTuLVeH9Sg6/SnIAqNq5A8q1dRSwvQMY3IfRPnl+W/
         /hoQ==
X-Gm-Message-State: AKS2vOxySvV+LRFsLAvIQ5aiKa9+IScLw3gwTVD2+Sk8fVwHsPbDnfF7
        I41pkHkYPU4/gL/f
X-Received: by 10.223.155.150 with SMTP id d22mr15459640wrc.193.1498565441267;
        Tue, 27 Jun 2017 05:10:41 -0700 (PDT)
Received: from slxbook4.ads.autodesk.com ([62.159.156.210])
        by smtp.gmail.com with ESMTPSA id 32sm17873976wry.31.2017.06.27.05.10.38
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Tue, 27 Jun 2017 05:10:40 -0700 (PDT)
From:   Lars Schneider <larsxschneider@gmail.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, peff@peff.net, tboegi@web.de, e@80x24.org,
        ttaylorr@github.com, peartben@gmail.com
Subject: [PATCH v7 2/6] t0021: make debug log file name configurable
Date:   Tue, 27 Jun 2017 14:10:23 +0200
Message-Id: <20170627121027.99209-3-larsxschneider@gmail.com>
X-Mailer: git-send-email 2.13.2
In-Reply-To: <20170627121027.99209-1-larsxschneider@gmail.com>
References: <20170627121027.99209-1-larsxschneider@gmail.com>
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
2.13.2

