Return-Path: <SRS0=AzkS=BC=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	LOTS_OF_MONEY,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01508C433E1
	for <git@archiver.kernel.org>; Thu, 23 Jul 2020 01:10:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CD6BC2053B
	for <git@archiver.kernel.org>; Thu, 23 Jul 2020 01:10:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="ZEhDNh0N"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387656AbgGWBKa (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 22 Jul 2020 21:10:30 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:40536 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2387649AbgGWBK2 (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 22 Jul 2020 21:10:28 -0400
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 7F8D36100C
        for <git@vger.kernel.org>; Thu, 23 Jul 2020 01:09:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1595466597;
        bh=Q12wOxJbdk6gJKEFGWWzYzA596jdmVCNFoN+euD0r/w=;
        h=From:To:Subject:Date:In-Reply-To:References:From:Reply-To:Subject:
         Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:
         References:Content-Type:Content-Disposition;
        b=ZEhDNh0NP0nnYydtx2MstFQegrOBjjGY0P4jFAN5Sq+PdYubmWz+EgBH1ApMu/ekL
         hYpzbkuuaGxrOhaV+v/E406uoUKpW6qBtUPGh25okbWErv+YwnhGGnHsDorniySVCH
         LeqJ5xbIeQ9MvNcmcNYeCP3UcXOoENkWU4FKqa4vAMTu677iE2jwkV3PdMxa+dgcR7
         F3ec0voFKmrhIJLq1YY2AEyfKU8d/LHAdcL3/VGYQN5cKTzVaxJfMBVBf0zPzdbd7p
         Zucw7PIfB09zWuN3IrK3OH7BUVUG90njcz9VeneMWWLYrpdPRmjuQ/6CM1jfvdpTSk
         +k4bk5DXS6tSEwQEjcouR0i3gnw+jvxiJQ9kh3hIxM91dGfstO1RjzKsfkJhR2Beku
         xUdid3zE8c7zAAizfCGJWBaA7fhMi9BHW/MY71acTMayFUjgr46XxIDVThEqjZisPp
         ZH9eBiRZHq7kFTBnzAONDiOj/jswiyxUlb0894IEoZVwkygRWKG
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     <git@vger.kernel.org>
Subject: [PATCH v3 17/39] t7508: use $ZERO_OID instead of hard-coded constant
Date:   Thu, 23 Jul 2020 01:09:21 +0000
Message-Id: <20200723010943.2329634-18-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.28.0.rc1.129.ge9626dbbb9f
In-Reply-To: <20200723010943.2329634-1-sandals@crustytoothpaste.net>
References: <20200723010943.2329634-1-sandals@crustytoothpaste.net>
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
