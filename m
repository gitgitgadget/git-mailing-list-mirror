Return-Path: <SRS0=QOHA=BI=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	LOTS_OF_MONEY,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0D52C433E1
	for <git@archiver.kernel.org>; Wed, 29 Jul 2020 23:14:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 95EC62067D
	for <git@archiver.kernel.org>; Wed, 29 Jul 2020 23:14:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="aCC+qxu5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728072AbgG2XO6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 29 Jul 2020 19:14:58 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:41044 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728057AbgG2XO4 (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 29 Jul 2020 19:14:56 -0400
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 7B29361016;
        Wed, 29 Jul 2020 23:14:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1596064493;
        bh=Q12wOxJbdk6gJKEFGWWzYzA596jdmVCNFoN+euD0r/w=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=aCC+qxu5Ci17BPrRlGoJ3Hmp6gRqWwO2IiwAMXXmeV9gjpfsU6H8U61URQLJXA1wQ
         vsHSWK4nGpCC1ROvrqUoieh8sXRT0M94UhQZOjfYK/UXpIhTXMJY8E5HaeVT16byeV
         1tPvPAcxvY2370IG8c8SQeR/1V5SuNmm198TAv5sW84qUY6DGE1xaK4TOMXy1B4TZo
         sS4KkSD1yYs5TVu0yWkWgkI9dlv4Xy/ICjgacl8Qmjuh8ERS05smhr/k0qkLxrLyWT
         FU2uB3nM3RtkV5ZrlQkk721o/Gu0MsLmgyGJjNTd5lmjC32mo81lIDD12G/dBXZEmD
         nIQF/JcNtv0uRDvvqz6BSaA12y8716mhLj+RVZJgDLSGxnYR98osJArFpCgZWclZkW
         v8KhT+4GIWr2f0VwvHwHRNw+Xdz4MHOiLSTnb+BFMZJqJix0izo0Wr/EQ26Odjbpua
         BPUA18oAPzOqM/Tx5eItDFREWarKtWRssLd/D8/4NpXtg2iT+aV
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     <git@vger.kernel.org>
Cc:     Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v6 17/39] t7508: use $ZERO_OID instead of hard-coded constant
Date:   Wed, 29 Jul 2020 23:14:06 +0000
Message-Id: <20200729231428.3658647-18-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.28.0.163.g6104cc2f0b6
In-Reply-To: <20200729231428.3658647-1-sandals@crustytoothpaste.net>
References: <20200728233446.3066485-1-sandals@crustytoothpaste.net>
 <20200729231428.3658647-1-sandals@crustytoothpaste.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Use the ZERO_OID variable to abbreviate the all-zeros object ID for
maintainability and to avoid depending on a specific size for the hash.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 t/t7508-status.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/t7508-status.sh b/t/t7508-status.sh
index 8e969f3e36..e81759319f 100755
--- a/t/t7508-status.sh
+++ b/t/t7508-status.sh
@@ -837,7 +837,7 @@ EOF
 '
 
 cat >expect <<EOF
-:100644 100644 $EMPTY_BLOB 0000000000000000000000000000000000000000 M	dir1/modified
+:100644 100644 $EMPTY_BLOB $ZERO_OID M	dir1/modified
 EOF
 test_expect_success 'status refreshes the index' '
 	touch dir2/added &&
