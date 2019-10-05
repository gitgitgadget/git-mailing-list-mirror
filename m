Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BECE41F4BD
	for <e@80x24.org>; Sat,  5 Oct 2019 21:12:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726173AbfJEVM1 (ORCPT <rfc822;e@80x24.org>);
        Sat, 5 Oct 2019 17:12:27 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:36352 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725789AbfJEVMX (ORCPT
        <rfc822;git@vger.kernel.org>); Sat, 5 Oct 2019 17:12:23 -0400
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id D7A0C61C70;
        Sat,  5 Oct 2019 21:12:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1570309943;
        bh=xAwPFCa9jKc9F2OPJiKnOhVwiuwkg/OZ8jdoqr7wNIU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=KQPnPaUI7yRXMziQWKGpBCOschX87hAB8mVTN69X/SS8qwHiWw2DZkgrj3cjQ6sel
         bwct4r7HKcCN1qxuhsgVm+adfW1pUafFUDZPTZt65oFnnhZz1JXPia4wxUJgsf6dhI
         Rs9rhuHsz77J9XuU7cXS7awJnxzBQBipOClHXG+ySahi6IS6H47Iu+dlksssf7mbFh
         rvMw+Pqxl5/qAlnCcjqA2fyKC1Lls+vUhFe6oPXLF6FeCtzYDD68r7P7dMSWvv5RU6
         X6U/bze4hzfrfIJjfdsc+GwbiaxnDtWez5hrfmHYYjNNSGEp+vHCXOyN9ahjqsp8v9
         yr+R4MqUmH1l98GmT/3kWVYqnBsLfFSS4KUYJRlzavAcGo6JlEDtDHKYu4s2FjGD5o
         Na8ATf/HwZuWibMKJBiswaIfYD0VIsbBxoj2z3mc4D3G9lvmfA8mgIBCouHEkDcT/G
         /MPJDiczSWYeoW1ZJBd7tJdX+MXybPJLd/utOiif7TygEC2Jffm
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     <git@vger.kernel.org>
Cc:     Stefan Beller <stefanbeller@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH 14/15] t4045: make hash-size independent
Date:   Sat,  5 Oct 2019 21:12:08 +0000
Message-Id: <20191005211209.18237-15-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.23.0.700.g56cf767bdb
In-Reply-To: <20191005211209.18237-1-sandals@crustytoothpaste.net>
References: <20191005211209.18237-1-sandals@crustytoothpaste.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Replace a hard-coded all-zeros object ID with a use of $ZERO_OID.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 t/t4045-diff-relative.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/t4045-diff-relative.sh b/t/t4045-diff-relative.sh
index 36f8ed8a81..258808708e 100755
--- a/t/t4045-diff-relative.sh
+++ b/t/t4045-diff-relative.sh
@@ -70,7 +70,7 @@ check_raw () {
 	expect=$1
 	shift
 	cat >expected <<-EOF
-	:000000 100644 0000000000000000000000000000000000000000 $blob A	$expect
+	:000000 100644 $ZERO_OID $blob A	$expect
 	EOF
 	test_expect_success "--raw $*" "
 		git -C '$dir' diff --no-abbrev --raw $* HEAD^ >actual &&
