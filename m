Return-Path: <SRS0=TxkB=AV=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,LOTS_OF_MONEY,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0D07C433DF
	for <git@archiver.kernel.org>; Fri, 10 Jul 2020 02:49:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 979E120663
	for <git@archiver.kernel.org>; Fri, 10 Jul 2020 02:49:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="ceoYDDX9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727935AbgGJCt3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 9 Jul 2020 22:49:29 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:40398 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726962AbgGJCse (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 9 Jul 2020 22:48:34 -0400
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id F361560A6B;
        Fri, 10 Jul 2020 02:48:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1594349311;
        bh=Q12wOxJbdk6gJKEFGWWzYzA596jdmVCNFoN+euD0r/w=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=ceoYDDX94JsYXe3gobKI+QVbcU1/SmlxVOYK9JzADmEfc9AX7nBRb9yhROg8VPagj
         6PX7yaJ6Tkt5HV9/mgfSFVAXTN0Sn/EEsmp5y550YwSDHfFB0zQT+H49OLE8gqebp8
         RkmQZJmihYp+hzSNvKPs8sBypd6W9g/wLWa8wpP/DCpABtQgoj7zEqBSEcuXQFG4RT
         3PRTcBOni5NfHr5qFrdGKz3gQaIpS5pwsH1bm8HxY+YiC5dmbd0ZywpiW6vR36ejB4
         JR/+sh+9U7ihRyAGwAt7zKP68NfKCgjghIl0knpMl7vEJ7oiSEueTZIB1LqEhXVTbQ
         Zbh8N716a1ZaaYCXOYaK8pjhpu+n7hkF3V9sHKyIV7axuWd9wtaeDCZeLPmPni7s/R
         vWpyS9NyWSubpytirOYMNxqOTU8vQwlvU/BhdCcepXrnT8oU7LqlCsXCBe2siEZrkv
         sbldh242Wuiaoq9B/15u79EmTbZK22ZKTko+fnQmDL59acA/PbU
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     <git@vger.kernel.org>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH 17/38] t7508: use $ZERO_OID instead of hard-coded constant
Date:   Fri, 10 Jul 2020 02:47:07 +0000
Message-Id: <20200710024728.3100527-18-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.27.0.353.gb9a2d1a020
In-Reply-To: <20200710024728.3100527-1-sandals@crustytoothpaste.net>
References: <20200710024728.3100527-1-sandals@crustytoothpaste.net>
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
