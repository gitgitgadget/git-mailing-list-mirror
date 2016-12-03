Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4BBDA1FF40
	for <e@80x24.org>; Sat,  3 Dec 2016 19:45:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750888AbcLCTp2 (ORCPT <rfc822;e@80x24.org>);
        Sat, 3 Dec 2016 14:45:28 -0500
Received: from mail-wm0-f43.google.com ([74.125.82.43]:34996 "EHLO
        mail-wm0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750795AbcLCTp1 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 3 Dec 2016 14:45:27 -0500
Received: by mail-wm0-f43.google.com with SMTP id a197so46191038wmd.0
        for <git@vger.kernel.org>; Sat, 03 Dec 2016 11:45:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=ZNEWNKYGXcMrBoEYeQB3aID2ODLz1P0Z31IEjojMpF0=;
        b=Xwztxq86/qSIOOay2jjJb5/mqrHGP9ziHrGXZLZRGZsYs0vIkJhKnm3RK6lFX/Kb84
         QiUmdmifaLzXFfz/Q2OJhAz+28925BTVZHfGfkDFLhLUjNwu7Swti6ulO+CyjM2614fE
         gZDMEDZaEgu62g9TuHZk/MjXUKV3bcsElLE6ItNkx9o1F/fG88oqGKIfGSvqxo2YnuVX
         2O8BJ/1yotZpU758M2zzKRaorJrAx1jeTy5GIc9R67uXcMcCAJ+RhehFpo6nwBsAUskJ
         CVwj5OxqXMPYvivHMELcMZkfaVlhsGP73ia9qprgtnGFNTdaNoKz3LfpZiHIj/tEkX7m
         tzvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=ZNEWNKYGXcMrBoEYeQB3aID2ODLz1P0Z31IEjojMpF0=;
        b=CKHzFMeq2CbpifvaFAgrZwgz3W8oan3WgVdBtrzhvptajQKNJRrDBVjP+QB4gh6UuZ
         wBze/VmQtjqI90csgDiSWrdgFGCfDqagZBfMXhtCYuD68ujZ+73GttUW/58eVGDrnaHT
         QpYMVupuKdDk3OPA2NlneqnqvbQ9864LoGt/VXFVy7aPgTkEUPInvXTidSCDNEg0GnWe
         mM/reXKg0GmTpOVZ9WuPQEqZKgFep+5MwxSvCChn+g/3SHpoAO0IqdV0OVJAZXzngPFx
         M4/+bZuSIOHS/NWPV0nXFR8wVPw2w6uUdclqNTk99kZcX+jo3cYgU4tkmzj/kGFX1lzT
         v1Hg==
X-Gm-Message-State: AKaTC02de2NTQF3EbmNLZrEAfwSS4yxl8L2xvKLatsdN8g6dd/47gsPS/AIiVRD/UjdCZg==
X-Received: by 10.28.23.137 with SMTP id 131mr2853256wmx.121.1480794325979;
        Sat, 03 Dec 2016 11:45:25 -0800 (PST)
Received: from localhost.localdomain (adsknateur.autodesk.com. [132.188.32.100])
        by smtp.gmail.com with ESMTPSA id ab10sm11958479wjc.45.2016.12.03.11.45.24
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Sat, 03 Dec 2016 11:45:25 -0800 (PST)
From:   larsxschneider@gmail.com
To:     git@vger.kernel.org
Cc:     Lars Schneider <larsxschneider@gmail.com>
Subject: [PATCH] docs: warn about possible '=' in clean/smudge filter process values
Date:   Sat,  3 Dec 2016 20:45:16 +0100
Message-Id: <20161203194516.12879-1-larsxschneider@gmail.com>
X-Mailer: git-send-email 2.11.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Lars Schneider <larsxschneider@gmail.com>

A pathname value in a clean/smudge filter process "key=value" pair can
contain the '=' character (introduced in edcc858). Make the user aware
of this issue in the docs, add a corresponding test case, and fix the
issue in filter process value parser of the example implementation in
contrib.

Signed-off-by: Lars Schneider <larsxschneider@gmail.com>
---
 Documentation/gitattributes.txt        |  4 +++-
 contrib/long-running-filter/example.pl |  8 ++++++--
 t/t0021-conversion.sh                  | 20 ++++++++++----------
 t/t0021/rot13-filter.pl                |  8 ++++++--
 4 files changed, 25 insertions(+), 15 deletions(-)

diff --git a/Documentation/gitattributes.txt b/Documentation/gitattributes.txt
index 976243a63e..e0b66c1220 100644
--- a/Documentation/gitattributes.txt
+++ b/Documentation/gitattributes.txt
@@ -435,7 +435,9 @@ to filter relative to the repository root. Right after the flush packet
 Git sends the content split in zero or more pkt-line packets and a
 flush packet to terminate content. Please note, that the filter
 must not send any response before it received the content and the
-final flush packet.
+final flush packet. Also note that the "value" of a "key=value" pair
+can contain the "=" character whereas the key would never contain
+that character.
 ------------------------
 packet:          git> command=smudge
 packet:          git> pathname=path/testfile.dat
diff --git a/contrib/long-running-filter/example.pl b/contrib/long-running-filter/example.pl
index 39457055a5..a677569ddd 100755
--- a/contrib/long-running-filter/example.pl
+++ b/contrib/long-running-filter/example.pl
@@ -81,8 +81,12 @@ packet_txt_write("capability=smudge");
 packet_flush();

 while (1) {
-	my ($command)  = packet_txt_read() =~ /^command=([^=]+)$/;
-	my ($pathname) = packet_txt_read() =~ /^pathname=([^=]+)$/;
+	my ($command)  = packet_txt_read() =~ /^command=(.+)$/;
+	my ($pathname) = packet_txt_read() =~ /^pathname=(.+)$/;
+
+	if ( $pathname eq "" ) {
+		die "bad pathname '$pathname'";
+	}

 	packet_bin_read();

diff --git a/t/t0021-conversion.sh b/t/t0021-conversion.sh
index 4ea534e9fa..f3a0df2add 100755
--- a/t/t0021-conversion.sh
+++ b/t/t0021-conversion.sh
@@ -93,7 +93,7 @@ test_expect_success setup '
 	git checkout -- test test.t test.i &&

 	echo "content-test2" >test2.o &&
-	echo "content-test3 - filename with special characters" >"test3 '\''sq'\'',\$x.o"
+	echo "content-test3 - filename with special characters" >"test3 '\''sq'\'',\$x=.o"
 '

 script='s/^\$Id: \([0-9a-f]*\) \$/\1/p'
@@ -359,12 +359,12 @@ test_expect_success PERL 'required process filter should filter data' '
 		cp "$TEST_ROOT/test.o" test.r &&
 		cp "$TEST_ROOT/test2.o" test2.r &&
 		mkdir testsubdir &&
-		cp "$TEST_ROOT/test3 '\''sq'\'',\$x.o" "testsubdir/test3 '\''sq'\'',\$x.r" &&
+		cp "$TEST_ROOT/test3 '\''sq'\'',\$x=.o" "testsubdir/test3 '\''sq'\'',\$x=.r" &&
 		>test4-empty.r &&

 		S=$(file_size test.r) &&
 		S2=$(file_size test2.r) &&
-		S3=$(file_size "testsubdir/test3 '\''sq'\'',\$x.r") &&
+		S3=$(file_size "testsubdir/test3 '\''sq'\'',\$x=.r") &&

 		filter_git add . &&
 		cat >expected.log <<-EOF &&
@@ -373,7 +373,7 @@ test_expect_success PERL 'required process filter should filter data' '
 			IN: clean test.r $S [OK] -- OUT: $S . [OK]
 			IN: clean test2.r $S2 [OK] -- OUT: $S2 . [OK]
 			IN: clean test4-empty.r 0 [OK] -- OUT: 0  [OK]
-			IN: clean testsubdir/test3 '\''sq'\'',\$x.r $S3 [OK] -- OUT: $S3 . [OK]
+			IN: clean testsubdir/test3 '\''sq'\'',\$x=.r $S3 [OK] -- OUT: $S3 . [OK]
 			STOP
 		EOF
 		test_cmp_count expected.log rot13-filter.log &&
@@ -385,23 +385,23 @@ test_expect_success PERL 'required process filter should filter data' '
 			IN: clean test.r $S [OK] -- OUT: $S . [OK]
 			IN: clean test2.r $S2 [OK] -- OUT: $S2 . [OK]
 			IN: clean test4-empty.r 0 [OK] -- OUT: 0  [OK]
-			IN: clean testsubdir/test3 '\''sq'\'',\$x.r $S3 [OK] -- OUT: $S3 . [OK]
+			IN: clean testsubdir/test3 '\''sq'\'',\$x=.r $S3 [OK] -- OUT: $S3 . [OK]
 			IN: clean test.r $S [OK] -- OUT: $S . [OK]
 			IN: clean test2.r $S2 [OK] -- OUT: $S2 . [OK]
 			IN: clean test4-empty.r 0 [OK] -- OUT: 0  [OK]
-			IN: clean testsubdir/test3 '\''sq'\'',\$x.r $S3 [OK] -- OUT: $S3 . [OK]
+			IN: clean testsubdir/test3 '\''sq'\'',\$x=.r $S3 [OK] -- OUT: $S3 . [OK]
 			STOP
 		EOF
 		test_cmp_count expected.log rot13-filter.log &&

-		rm -f test2.r "testsubdir/test3 '\''sq'\'',\$x.r" &&
+		rm -f test2.r "testsubdir/test3 '\''sq'\'',\$x=.r" &&

 		filter_git checkout --quiet --no-progress . &&
 		cat >expected.log <<-EOF &&
 			START
 			init handshake complete
 			IN: smudge test2.r $S2 [OK] -- OUT: $S2 . [OK]
-			IN: smudge testsubdir/test3 '\''sq'\'',\$x.r $S3 [OK] -- OUT: $S3 . [OK]
+			IN: smudge testsubdir/test3 '\''sq'\'',\$x=.r $S3 [OK] -- OUT: $S3 . [OK]
 			STOP
 		EOF
 		test_cmp_exclude_clean expected.log rot13-filter.log &&
@@ -422,14 +422,14 @@ test_expect_success PERL 'required process filter should filter data' '
 			IN: smudge test.r $S [OK] -- OUT: $S . [OK]
 			IN: smudge test2.r $S2 [OK] -- OUT: $S2 . [OK]
 			IN: smudge test4-empty.r 0 [OK] -- OUT: 0  [OK]
-			IN: smudge testsubdir/test3 '\''sq'\'',\$x.r $S3 [OK] -- OUT: $S3 . [OK]
+			IN: smudge testsubdir/test3 '\''sq'\'',\$x=.r $S3 [OK] -- OUT: $S3 . [OK]
 			STOP
 		EOF
 		test_cmp_exclude_clean expected.log rot13-filter.log &&

 		test_cmp_committed_rot13 "$TEST_ROOT/test.o" test.r &&
 		test_cmp_committed_rot13 "$TEST_ROOT/test2.o" test2.r &&
-		test_cmp_committed_rot13 "$TEST_ROOT/test3 '\''sq'\'',\$x.o" "testsubdir/test3 '\''sq'\'',\$x.r"
+		test_cmp_committed_rot13 "$TEST_ROOT/test3 '\''sq'\'',\$x=.o" "testsubdir/test3 '\''sq'\'',\$x=.r"
 	)
 '

diff --git a/t/t0021/rot13-filter.pl b/t/t0021/rot13-filter.pl
index 4d5697ee51..617f581e56 100644
--- a/t/t0021/rot13-filter.pl
+++ b/t/t0021/rot13-filter.pl
@@ -109,14 +109,18 @@ print $debug "init handshake complete\n";
 $debug->flush();

 while (1) {
-	my ($command) = packet_txt_read() =~ /^command=([^=]+)$/;
+	my ($command) = packet_txt_read() =~ /^command=(.+)$/;
 	print $debug "IN: $command";
 	$debug->flush();

-	my ($pathname) = packet_txt_read() =~ /^pathname=([^=]+)$/;
+	my ($pathname) = packet_txt_read() =~ /^pathname=(.+)$/;
 	print $debug " $pathname";
 	$debug->flush();

+	if ( $pathname eq "" ) {
+		die "bad pathname '$pathname'";
+	}
+
 	# Flush
 	packet_bin_read();

--
2.11.0

