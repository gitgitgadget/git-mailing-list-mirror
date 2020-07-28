Return-Path: <SRS0=DRt7=BH=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23890C433F7
	for <git@archiver.kernel.org>; Tue, 28 Jul 2020 23:35:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 03889207FC
	for <git@archiver.kernel.org>; Tue, 28 Jul 2020 23:35:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="YKQSqTTR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730260AbgG1XfO (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 28 Jul 2020 19:35:14 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:40852 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730134AbgG1XfH (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 28 Jul 2020 19:35:07 -0400
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 068F761013;
        Tue, 28 Jul 2020 23:35:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1595979305;
        bh=wVbIJyEXfbTnQyZJWmVPDavtLEJRJvrONnd47uNHDFU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=YKQSqTTRkqFAiTkuvt6JDqxKlEn0iyjnziC7BxLOsyUplZUalO2z9txsh5eWRAEc1
         SflOD2Z30F5EyNOLnG8zyNrY1o54Y7o6+dYxcwx92eUu1hwC+HzoESgem34D2stjDY
         +SuRipmZYlF8fxzuChnkT9f4/pEoEPaWgW3CArBJoi0VT3Iuf1+EaQ3TyGt2k7WM2l
         DvlUeJBLWSXO75abPHZ9DJhUH9ruyhNOQF0giKQeK6PZlTVnIxaRQaeLAdLl1uDq9z
         AQhlxBwx/ch8V0bVbtGkVUGTRI9uVbFrNjVjBs0/M2ThEovZ24WUze1ExE6pm0zL7p
         VDsQz4b9cqrkrz3tfaDhxPe6UuNuwKmy7hhMOyVwcvky3DEE1iOuy1W5qTnXMM+VIU
         P4eyD5qujxk6T6f+54JPPXdffuU++665UjCtCUt20TVHa01mtLJmmijjgEDfR0/qi8
         b6eYA58JEpZSPJ6HarZG5PVH1bwyycdK5S4TMUzJfJfAqQefPJE
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     <git@vger.kernel.org>
Cc:     Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v5 22/39] t9300: use $ZERO_OID instead of hard-coded object ID
Date:   Tue, 28 Jul 2020 23:34:29 +0000
Message-Id: <20200728233446.3066485-23-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.28.0.163.g6104cc2f0b6
In-Reply-To: <20200728233446.3066485-1-sandals@crustytoothpaste.net>
References: <20200728233446.3066485-1-sandals@crustytoothpaste.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 t/t9300-fast-import.sh | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/t/t9300-fast-import.sh b/t/t9300-fast-import.sh
index f2d2cb06ad..308c1ef42c 100755
--- a/t/t9300-fast-import.sh
+++ b/t/t9300-fast-import.sh
@@ -92,7 +92,7 @@ test_expect_success 'A: create pack from stdin' '
 	EOF
 
 	reset refs/tags/to-be-deleted
-	from 0000000000000000000000000000000000000000
+	from $ZERO_OID
 
 	tag nested
 	mark :6
@@ -102,7 +102,7 @@ test_expect_success 'A: create pack from stdin' '
 	EOF
 
 	reset refs/tags/nested
-	from 0000000000000000000000000000000000000000
+	from $ZERO_OID
 
 	tag nested
 	mark :7
@@ -286,7 +286,7 @@ test_expect_success 'A: verify pack' '
 test_expect_success 'A: verify diff' '
 	copy=$(git rev-parse --verify master:file2) &&
 	cat >expect <<-EOF &&
-	:000000 100755 0000000000000000000000000000000000000000 $copy A	copy-of-file2
+	:000000 100755 $ZERO_OID $copy A	copy-of-file2
 	EOF
 	git diff-tree -M -r master verify--import-marks >actual &&
 	compare_diff_raw expect actual &&
@@ -365,7 +365,7 @@ test_expect_success 'B: fail on invalid blob sha1' '
 	COMMIT
 
 	from refs/heads/master
-	M 755 0000000000000000000000000000000000000001 zero1
+	M 755 $(echo $ZERO_OID | sed -e "s/0$/1/") zero1
 
 	INPUT_END
 
@@ -620,8 +620,8 @@ test_expect_success 'D: validate new files added' '
 	f5id=$(echo "$file5_data" | git hash-object --stdin) &&
 	f6id=$(echo "$file6_data" | git hash-object --stdin) &&
 	cat >expect <<-EOF &&
-	:000000 100755 0000000000000000000000000000000000000000 $f6id A	newdir/exec.sh
-	:000000 100644 0000000000000000000000000000000000000000 $f5id A	newdir/interesting
+	:000000 100755 $ZERO_OID $f6id A	newdir/exec.sh
+	:000000 100644 $ZERO_OID $f5id A	newdir/interesting
 	EOF
 	git diff-tree -M -r branch^ branch >actual &&
 	compare_diff_raw expect actual
@@ -2733,7 +2733,7 @@ test_expect_success 'R: corrupt lines do not mess marks file' '
 	rm -f io.marks &&
 	blob=$(echo hi | git hash-object --stdin) &&
 	cat >expect <<-EOF &&
-	:3 0000000000000000000000000000000000000000
+	:3 $ZERO_OID
 	:1 $blob
 	:2 $blob
 	EOF
@@ -3084,7 +3084,7 @@ test_expect_success 'T: delete branch' '
 	git branch to-delete &&
 	git fast-import <<-EOF &&
 	reset refs/heads/to-delete
-	from 0000000000000000000000000000000000000000
+	from $ZERO_OID
 	EOF
 	test_must_fail git rev-parse --verify refs/heads/to-delete
 '
