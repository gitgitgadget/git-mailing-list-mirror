Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E21A31F51C
	for <e@80x24.org>; Mon, 21 May 2018 02:03:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752697AbeEUCDG (ORCPT <rfc822;e@80x24.org>);
        Sun, 20 May 2018 22:03:06 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:51012 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752645AbeEUCDD (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 20 May 2018 22:03:03 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:fc4d:8d90:22bd:91d8])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 1DAC960751;
        Mon, 21 May 2018 02:03:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1526868181;
        bh=HgZxE5D0+6JfaobdOtxElSsK+uXh9myHMFGd0+ulCkE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=NJKTP0tVkof8SbazuF7NKGljVC7mF64IhI6y2F5Ygkoa/CdqaffSdwlVpc7uX8mE9
         H5bRfbFY+Qyja0LJgbdTJkdDWRAc/g9YZq21D9aFsjHR5VCput63uot3RWBsJnZcHJ
         3sNLhe2a7UmENdYaNvlFAtXmooNb0Rjzxus5mkwRsGH8MKtKDoixNRrx3u8JNhYcAQ
         ZsDd+RIJxBuhJnDIMHYkBDOPwQZOX2opVu9FYFrsoWe3Yw05FmGRhOxGhSXesV+fMF
         yhqjRjOeFVCUPtI4e2MPG9VI0gtDDP/sY7STxaMhQcgXQy/+S7nIoZHEPrqTBoloN7
         tXur2F6lWEiKFy+BQ/7ZCMdp32CSYOhsY9Pc0DyFwj8zGWhA22Y0pu62diMO0oWzfA
         dITeiF6ByQr3irgFaSlY0KjfbfAYhBhRp9hgMJN56d2p62XayqsbnqjA9v/0+XyeU8
         2kB4skd9l9EFCKzOCd3BjyL/g10eWTqk6miEXFXJXyqNT80AxM3
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>,
        =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Johannes Sixt <j6t@kdbg.org>,
        Stefan Beller <sbeller@google.com>
Subject: [PATCH v4 19/28] t4022: abstract away SHA-1-specific constants
Date:   Mon, 21 May 2018 02:01:38 +0000
Message-Id: <20180521020147.648496-20-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.17.0.441.gb46fe60e1d
In-Reply-To: <20180521020147.648496-1-sandals@crustytoothpaste.net>
References: <20180516015630.661349-1-sandals@crustytoothpaste.net>
 <20180521020147.648496-1-sandals@crustytoothpaste.net>
X-Scanned-By: MIMEDefang 2.79 on 127.0.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Adjust the test so that it computes variables for blobs instead of using
hard-coded hashes.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 t/t4022-diff-rewrite.sh | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/t/t4022-diff-rewrite.sh b/t/t4022-diff-rewrite.sh
index cb51d9f9d4..6d1c3d949c 100755
--- a/t/t4022-diff-rewrite.sh
+++ b/t/t4022-diff-rewrite.sh
@@ -13,6 +13,8 @@ test_expect_success setup '
 	  "nopqrstuvwxyzabcdefghijklmNOPQRSTUVWXYZABCDEFGHIJKLM" \
 	  <"$TEST_DIRECTORY"/../COPYING >test &&
 	echo "to be deleted" >test2 &&
+	blob=$(git hash-object test2) &&
+	blob=$(git rev-parse --short $blob) &&
 	git add test2
 
 '
@@ -27,7 +29,7 @@ test_expect_success 'detect rewrite' '
 cat >expect <<EOF
 diff --git a/test2 b/test2
 deleted file mode 100644
-index 4202011..0000000
+index $blob..0000000
 --- a/test2
 +++ /dev/null
 @@ -1 +0,0 @@
@@ -43,7 +45,7 @@ test_expect_success 'show deletion diff without -D' '
 cat >expect <<EOF
 diff --git a/test2 b/test2
 deleted file mode 100644
-index 4202011..0000000
+index $blob..0000000
 EOF
 test_expect_success 'suppress deletion diff with -D' '
 
