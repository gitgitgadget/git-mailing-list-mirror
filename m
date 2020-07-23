Return-Path: <SRS0=AzkS=BC=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D56CC433E8
	for <git@archiver.kernel.org>; Thu, 23 Jul 2020 01:10:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2B09F2080D
	for <git@archiver.kernel.org>; Thu, 23 Jul 2020 01:10:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="HU4FdVvt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387593AbgGWBKB (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 22 Jul 2020 21:10:01 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:40490 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2387572AbgGWBKA (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 22 Jul 2020 21:10:00 -0400
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 6DE7A61011
        for <git@vger.kernel.org>; Thu, 23 Jul 2020 01:09:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1595466599;
        bh=6IiTjepVMmW78lRHg0aX51WFBl7W5fj6oZtc81uw/dY=;
        h=From:To:Subject:Date:In-Reply-To:References:From:Reply-To:Subject:
         Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:
         References:Content-Type:Content-Disposition;
        b=HU4FdVvtCo+2DMLciXDEYcts63W676BZ3O0xVH0ZhJBsGPv9CbTDbId73cNbHgJaI
         bPFicrzio/h0ueLuTSppZR/5BJWYvjt+VI85xLojDn/4Ow6vO4TvsX9Yhyi/NVfnVF
         FYOUwTdey2dgc8Q/qWDTFYq+oBYWU70vdS2nkuGykC5o4c9BDyqqX0iER8DwHg4DoN
         jcgitk/lJjQRyQtNCtJJdaU4VV3TqAPXKj51nXmUdAItuaWc0zDIxZho7cEGGnDNUN
         iGKEEDCSs/M7zJb1tHRdTba6TjrqGUFcxQLiquV9ordcsgSplsw7kfY9c68Q53SQtS
         lof4cmu+2Pi+3aXhpfaA4wyRjzjP7eusAIRTN+2OzBFDfPZpUdeiQuhWHltt8fT3ky
         wt+5S37tLtROM9wVy1tLnn10n8slx61EsPrJxOi9aZsF2NjBeoonPLrEGj3XPtzn00
         X3kQKGT9gzcSt6s0rvyE3vm2BdJJoUFgT0Efdk5mn8tZzCSEi6g
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     <git@vger.kernel.org>
Subject: [PATCH v3 22/39] t9300: use $ZERO_OID instead of hard-coded object ID
Date:   Thu, 23 Jul 2020 01:09:26 +0000
Message-Id: <20200723010943.2329634-23-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.28.0.rc1.129.ge9626dbbb9f
In-Reply-To: <20200723010943.2329634-1-sandals@crustytoothpaste.net>
References: <20200723010943.2329634-1-sandals@crustytoothpaste.net>
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
index 69d6fa4127..f4b3f5eaf9 100755
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
@@ -285,7 +285,7 @@ test_expect_success 'A: verify pack' '
 
 test_expect_success 'A: verify diff' '
 	cat >expect <<-EOF &&
-	:000000 100755 0000000000000000000000000000000000000000 $(git rev-parse --verify master:file2) A	copy-of-file2
+	:000000 100755 $ZERO_OID $(git rev-parse --verify master:file2) A	copy-of-file2
 	EOF
 	git diff-tree -M -r master verify--import-marks >actual &&
 	compare_diff_raw expect actual &&
@@ -364,7 +364,7 @@ test_expect_success 'B: fail on invalid blob sha1' '
 	COMMIT
 
 	from refs/heads/master
-	M 755 0000000000000000000000000000000000000001 zero1
+	M 755 $(echo $ZERO_OID | sed -e "s/0$/1/") zero1
 
 	INPUT_END
 
@@ -619,8 +619,8 @@ test_expect_success 'D: validate new files added' '
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
@@ -2732,7 +2732,7 @@ test_expect_success 'R: corrupt lines do not mess marks file' '
 	rm -f io.marks &&
 	blob=$(echo hi | git hash-object --stdin) &&
 	cat >expect <<-EOF &&
-	:3 0000000000000000000000000000000000000000
+	:3 $ZERO_OID
 	:1 $blob
 	:2 $blob
 	EOF
@@ -3083,7 +3083,7 @@ test_expect_success 'T: delete branch' '
 	git branch to-delete &&
 	git fast-import <<-EOF &&
 	reset refs/heads/to-delete
-	from 0000000000000000000000000000000000000000
+	from $ZERO_OID
 	EOF
 	test_must_fail git rev-parse --verify refs/heads/to-delete
 '
