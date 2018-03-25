Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1EB651F404
	for <e@80x24.org>; Sun, 25 Mar 2018 19:21:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752043AbeCYTVd (ORCPT <rfc822;e@80x24.org>);
        Sun, 25 Mar 2018 15:21:33 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:42544 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751874AbeCYTVZ (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 25 Mar 2018 15:21:25 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:e6b3:18ff:fe98:41a3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id BADE96099D;
        Sun, 25 Mar 2018 19:21:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1522005684;
        bh=/E/zG4fJH6855ke8RLPz9n/JTJnqVKkmjtjmAkfab6k=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=0Kxy2wvvthPzrGiGGJUi5hOT+HmLt5ah78JRidQkzQii0zgOhYH80H8eR6pnh3PS2
         ++zSJ3sPWweFYLCDjngKFGR+fgHdVbDPT5c9e6vch7IDtMtZ1wILYLryzRS7wRcugn
         WHvc+jDi3DpL65G/qVYD6JwkxeCRq2xVLL3Bjrn8ZxPPoBwck73CBeUZqyZZGIyy2w
         hKj6F3GNcWX4FLMc3nXVWEQK7EW0lKYmLCgQ00+tlveLIPiL0HpaLy2ZdzzZU+HaXr
         jRN1+nlp4X7KOiE4D0W4LQi6rtFtKlny5TggTxEx8xMjBTBJ0mNfzNxCa4mw+GCfYL
         /WjC8m0Wk7D78XkV0OUsdopMgPNXknHgGvGfdocX009glFPkxdfKVtaqg21fUru0EO
         4mJU7uMEmCWskuFyjc5sKXszMw4ePyZbsGCpjWOkD3A7HNQ1hopOTn/uZdNRS8soVR
         cfXacI1FkXPDQCadUDx5DcZyMjP0j62FUXldgYil+XYuUoa+P3U
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Lars Schneider <larsxschneider@gmail.com>
Subject: [PATCH 10/10] t2107: abstract away SHA-1-specific constants
Date:   Sun, 25 Mar 2018 19:20:55 +0000
Message-Id: <20180325192055.841459-11-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.17.0.rc1.317.g4a561d2cc9
In-Reply-To: <20180325192055.841459-1-sandals@crustytoothpaste.net>
References: <20180325192055.841459-1-sandals@crustytoothpaste.net>
X-Scanned-By: MIMEDefang 2.79 on 127.0.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Use the $EMPTY_BLOB variable instead of hard-coding a hash.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 t/t2107-update-index-basic.sh | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/t/t2107-update-index-basic.sh b/t/t2107-update-index-basic.sh
index 32ac6e09bd..1db7e6a1ab 100755
--- a/t/t2107-update-index-basic.sh
+++ b/t/t2107-update-index-basic.sh
@@ -85,9 +85,9 @@ test_expect_success '--chmod=+x and chmod=-x in the same argument list' '
 	>B &&
 	git add A B &&
 	git update-index --chmod=+x A --chmod=-x B &&
-	cat >expect <<-\EOF &&
-	100755 e69de29bb2d1d6434b8b29ae775ad8c2e48c5391 0	A
-	100644 e69de29bb2d1d6434b8b29ae775ad8c2e48c5391 0	B
+	cat >expect <<-EOF &&
+	100755 $EMPTY_BLOB 0	A
+	100644 $EMPTY_BLOB 0	B
 	EOF
 	git ls-files --stage A B >actual &&
 	test_cmp expect actual
