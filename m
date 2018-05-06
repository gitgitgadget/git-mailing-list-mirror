Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 96586200B9
	for <e@80x24.org>; Sun,  6 May 2018 23:18:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751887AbeEFXSO (ORCPT <rfc822;e@80x24.org>);
        Sun, 6 May 2018 19:18:14 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:41044 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751855AbeEFXSL (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 6 May 2018 19:18:11 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:254c:7dd1:74c7:cde0])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id CEC3F60761;
        Sun,  6 May 2018 23:18:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1525648689;
        bh=IHQ1mhtKA9lPZdP8AMJUizBUZJoCkJ5360LQLFN1asQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=OCZurDmyALBwInyGENTfzQL8A5ai+y0Elt7OHCfOBl63x0N2P2gYpB9HxmMz3EO0g
         nTk7VwQHpuaVqaB5cx/1LFx62c4iP6k4EpnySZS6GqL1nzEceIjxD2pQ0qYT7I5ZcR
         lvlMewtTC8PlxFJMhvfeO8eJ0fttN896GIxj9jGRGdwy6W08CYcZ8gjRtKd/Y3aOhq
         5375wsVo/R8km1gxEDHzBKgCBXaViiViN4xTiEeUGLx+qfl3inn8OO+gSjNih/Hvyj
         CAQ6s93WSrzHgUUgrdRAskBffuRKG9RRX646+mPBTRr8WqkKiMFlY9CUfyA3Ihj0+D
         covx/q9Fxf24wNTa84AHgU5oP39SGBUDalf9X2WPnA56Ag0uXcnI0eaMiWXaGgsxtA
         67yeEb33c/I7xPNXHLRL+frv6AiiJeA/vNKYdvblRYtKhYRxqt33uqEdPleh8Ug2WP
         B+xRecGf/UZ7rI9zGzLhi6QwO8FW12o+bUEIwTmXzi8bI5StP2c
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Lars Schneider <larsxschneider@gmail.com>
Subject: [PATCH 02/28] t/test-lib: introduce ZERO_OID
Date:   Sun,  6 May 2018 23:17:26 +0000
Message-Id: <20180506231752.975110-3-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.17.0.441.gb46fe60e1d
In-Reply-To: <20180506231752.975110-1-sandals@crustytoothpaste.net>
References: <20180506231752.975110-1-sandals@crustytoothpaste.net>
X-Scanned-By: MIMEDefang 2.79 on 127.0.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Currently we have a variable, $_z40, which contains the all-zero object
ID.  However, with NewHash, we'll have an all-zero object ID which is
longer than 40 hex characters.  In such a case, $_z40 will be a
confusing name.  Create a $ZERO_OID variable which will always reflect
the all-zeros object ID, regardless of the length of the current hash.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 t/test-lib.sh | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/t/test-lib.sh b/t/test-lib.sh
index fce728d2ea..58c2ea52c6 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -184,6 +184,7 @@ _x40="$_x35$_x05"
 # Zero SHA-1
 _z40=0000000000000000000000000000000000000000
 
+ZERO_OID=$_z40
 EMPTY_TREE=4b825dc642cb6eb9a060e54bf8d69288fbee4904
 EMPTY_BLOB=e69de29bb2d1d6434b8b29ae775ad8c2e48c5391
 
@@ -195,7 +196,7 @@ LF='
 # when case-folding filenames
 u200c=$(printf '\342\200\214')
 
-export _x05 _x35 _x40 _z40 LF u200c EMPTY_TREE EMPTY_BLOB
+export _x05 _x35 _x40 _z40 LF u200c EMPTY_TREE EMPTY_BLOB ZERO_OID
 
 # Each test should start with something like this, after copyright notices:
 #
