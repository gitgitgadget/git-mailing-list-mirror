Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5DCB51F404
	for <e@80x24.org>; Sun, 25 Mar 2018 19:21:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751976AbeCYTVQ (ORCPT <rfc822;e@80x24.org>);
        Sun, 25 Mar 2018 15:21:16 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:42484 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751674AbeCYTVN (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 25 Mar 2018 15:21:13 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:e6b3:18ff:fe98:41a3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 1A4A06099C;
        Sun, 25 Mar 2018 19:21:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1522005672;
        bh=HXDiJn7og3bVadlMUi3ta2x/1k18mmWd+I/0kpN3vaY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=YpgJd7quK1nxSZZgcwL0jp1MxCphD9wKK2y2CFFnqWNMMqsiPNjzIjpMvdnJqmrqy
         qoa1rKqEyM2c0or5GlfGH/TMhlAAjePqR4IFaczVpawIyFo2O49+uAdf22hvjd/CZh
         x2aeXnPBAACDpQKTD9aDEy3JRkuPVTZd0/Ox2gNWaw1gLh/nGA58jHAXMdsQqdqIMR
         CxLGQhAiybAG0QtFZxKwUBoFPm1TuXBLRpC7B+9wid5XjBv/Kuuh6Mz4lCkrbskw8V
         sevayMtDWvrkkKKpx8xJra5zEtjMwh2C0c7tJ4Kdct+08X+b6y/Wkk3wDHAVpD8B4x
         wYcGCXJG+1+1RGmAJUXOTBFt1tLfaldDV5OfJrFBvlP+IO6LFco+07gV5VVMFWfgdW
         WShSHypL8758G8J9lQJ7TomHqd+SwOvVTD//4q/xqFhe2iPX5FHCPn93sWlNcCVuQL
         s1Vv1DNoHzXM5CSehHZ5Vf3S7LIct8ojSURq9r/jPYb9cKfCh38
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Lars Schneider <larsxschneider@gmail.com>
Subject: [PATCH 02/10] t1304: abstract away SHA-1-specific constants
Date:   Sun, 25 Mar 2018 19:20:47 +0000
Message-Id: <20180325192055.841459-3-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.17.0.rc1.317.g4a561d2cc9
In-Reply-To: <20180325192055.841459-1-sandals@crustytoothpaste.net>
References: <20180325192055.841459-1-sandals@crustytoothpaste.net>
X-Scanned-By: MIMEDefang 2.79 on 127.0.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Adjust the test so that it uses the $EMPTY_BLOB value instead of
hard-coding the hash.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 t/t1304-default-acl.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/t1304-default-acl.sh b/t/t1304-default-acl.sh
index f5422f1d33..335d3f3211 100755
--- a/t/t1304-default-acl.sh
+++ b/t/t1304-default-acl.sh
@@ -54,7 +54,7 @@ test_expect_success SETFACL 'Setup test repo' '
 
 test_expect_success SETFACL 'Objects creation does not break ACLs with restrictive umask' '
 	# SHA1 for empty blob
-	check_perms_and_acl .git/objects/e6/9de29bb2d1d6434b8b29ae775ad8c2e48c5391
+	check_perms_and_acl .git/objects/$(echo $EMPTY_BLOB | sed -e "s,^\(..\),\1/,")
 '
 
 test_expect_success SETFACL 'git gc does not break ACLs with restrictive umask' '
