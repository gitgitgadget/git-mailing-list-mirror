Return-Path: <SRS0=B2P3=AY=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	LOTS_OF_MONEY,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CF81C433E7
	for <git@archiver.kernel.org>; Mon, 13 Jul 2020 02:49:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5D654206D9
	for <git@archiver.kernel.org>; Mon, 13 Jul 2020 02:49:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="jiGsghhT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728449AbgGMCth (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 12 Jul 2020 22:49:37 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:40638 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728048AbgGMCtc (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 12 Jul 2020 22:49:32 -0400
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 0D60460A6A;
        Mon, 13 Jul 2020 02:49:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1594608571;
        bh=Q12wOxJbdk6gJKEFGWWzYzA596jdmVCNFoN+euD0r/w=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=jiGsghhThbp3kMPUs5xfEY8sY90N/1xIXCRVw8zBwW1xWo42fl8EcjSrXMqUphzhq
         jRg5veMH9X6Nm7EOHDO2J7bVkRYGALtPKhXznNz2hWgenVdoiM4m5emhd7sO88nZB9
         cyD3RNLsB+0XzXv9GTO3AYD1sAdzgHJmyrbxRRXIvg6Ssot0M0fVCyurqEo1Ybsr1d
         z7huPL16mNy3CQ3fyZCrUBWWgIkOKnzT+JGHFvJjRNqr0J/2fkaU5L9SKYr8flCNg8
         QUGQZKFomUUQmVVmRfituGyZyCqDQCkuAkjd6zuhcQiA6VEmyee3BMzGPzSeNO6DVr
         F5vXbHZFQUy6O5o8WC5xXHDweNMBazOVsAPVNhLVA7631Jy1I+SEUe1Zpp3be8yK9a
         WkAdkAc8DpVCEabeZKkxcl+P9QWCnGH82zqE/Gkvq2io7Pombo7FdYNfoqktWPZIOH
         azpyTYgaXTs7zOQeqPX4NZZnfRwBSag//0j7Yo3gejWoAc1IOkm
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     <git@vger.kernel.org>
Cc:     Denton Liu <liu.denton@gmail.com>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: [PATCH v2 17/39] t7508: use $ZERO_OID instead of hard-coded constant
Date:   Mon, 13 Jul 2020 02:48:47 +0000
Message-Id: <20200713024909.3714837-18-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.27.0.353.gb9a2d1a020
In-Reply-To: <20200713024909.3714837-1-sandals@crustytoothpaste.net>
References: <20200713024909.3714837-1-sandals@crustytoothpaste.net>
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
