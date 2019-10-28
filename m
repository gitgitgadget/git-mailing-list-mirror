Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C79691F4C0
	for <e@80x24.org>; Mon, 28 Oct 2019 00:59:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729124AbfJ1A7j (ORCPT <rfc822;e@80x24.org>);
        Sun, 27 Oct 2019 20:59:39 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:54334 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729096AbfJ1A7i (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 27 Oct 2019 20:59:38 -0400
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 795D362060;
        Mon, 28 Oct 2019 00:59:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1572224377;
        bh=xAwPFCa9jKc9F2OPJiKnOhVwiuwkg/OZ8jdoqr7wNIU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=Wb79OHmnHqdgrrp91KQ0OFKQA3KFPHjbnc4p8Ag47QY6/wKw6ChFwhRq2eoHbjpMN
         3mAb0Tj3sEM24TEkDDk+fDMhjI8jCeFOAIVPpqjaS3GMGBwOHXrODXypLkCZaHXWZ5
         fR1Rhmm/yagrm69TWPrnHC8XuH/m8z3bZFqPFsXay1Iy12JS3h1MSnorMEl9AwmOep
         SI4u5mT7fyQ9bbtY0Z9yIRCWH/mT+uOAzEPp4h9qXbYmke1I07uNDpDCI1Ybg2EPn5
         LBimQbarSalkX14pC6oDL2dTCFu+rqmP3u6fDdDF+12Ok69FXPbgH4iwC3lFtZigxP
         ZXMdZUS+YgHDxjNB5VcKE6v/yk/DQXkiGJPIODvdYggHCMc6yJAr/8iXo20UMntW/a
         jkRC1TOiMlQdzPQ5x/g39KahLLfnhhNJZQ9clNtEFPy8msdA+SMVclYEmp96m9Thu9
         HaUEzMPpZoS6p6wJLCSTT/GWgtp4tdc4UmVo+BHXQbLUtFQFwnN
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     <git@vger.kernel.org>
Cc:     Derrick Stolee <dstolee@microsoft.com>,
        Stefan Beller <stefanbeller@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH v2 14/15] t4045: make hash-size independent
Date:   Mon, 28 Oct 2019 00:59:06 +0000
Message-Id: <20191028005907.24985-15-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.24.0.rc0.303.g954a862665
In-Reply-To: <20191028005907.24985-1-sandals@crustytoothpaste.net>
References: <20191028005907.24985-1-sandals@crustytoothpaste.net>
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
