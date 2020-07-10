Return-Path: <SRS0=TxkB=AV=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17AF0C433E0
	for <git@archiver.kernel.org>; Fri, 10 Jul 2020 02:49:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EB3E120663
	for <git@archiver.kernel.org>; Fri, 10 Jul 2020 02:49:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="GPfJFKL0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727899AbgGJCtM (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 9 Jul 2020 22:49:12 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:40430 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727005AbgGJCsg (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 9 Jul 2020 22:48:36 -0400
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 3C85160A6E;
        Fri, 10 Jul 2020 02:48:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1594349313;
        bh=6IiTjepVMmW78lRHg0aX51WFBl7W5fj6oZtc81uw/dY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=GPfJFKL0nAYRD9jqChzlmxlBkIMqs7SDijIDTEcRjKODpJZIt1eohXtovGT6t7/vC
         LlS2dbq6N6WSRIBIOBzQbdw8U5i0h7eUgccPGf+ScC0w/82/LDvoViSPAp5O3eFR/f
         7wn2oALhCGPIT/+oltS+rpdUbLsll6/6woer9tNMQV21V3GO0UTN08WO5GW9TYA3bW
         YH8XSl11hzaTm1x9LZmLw9zbMY0TF9/6ZveYlbqr6BQrHUAXkdqfcIkfk3k3r9Y8vL
         dVJDlIwv9wH3DJ9FVSKXouMw3AyODjVzoVHpxgpL+449LINjFukBvrFiVVHjKVWzgi
         cJ3C8j3Rp5YTlH8DL99c+w8oDDsYA59F4wSxTTXH6ZJcWrBw5LZwTACh/58QkTsOVj
         ygN4aMcYO8Xg+Zl9ZD1qKgvrEBGe8TlekjYd1F59CADeNTz4IAQ/CJfveKswkung/k
         zRHcId2oCjBbBWeFZrWmDJ84momOsVZ5iEseoLaT/o9TXIqT92o
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     <git@vger.kernel.org>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH 22/38] t9300: use $ZERO_OID instead of hard-coded object ID
Date:   Fri, 10 Jul 2020 02:47:12 +0000
Message-Id: <20200710024728.3100527-23-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.27.0.353.gb9a2d1a020
In-Reply-To: <20200710024728.3100527-1-sandals@crustytoothpaste.net>
References: <20200710024728.3100527-1-sandals@crustytoothpaste.net>
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
