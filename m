Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 81FF1200B9
	for <e@80x24.org>; Sun,  6 May 2018 23:19:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752093AbeEFXTW (ORCPT <rfc822;e@80x24.org>);
        Sun, 6 May 2018 19:19:22 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:41262 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752015AbeEFXTH (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 6 May 2018 19:19:07 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:254c:7dd1:74c7:cde0])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 0BE746076E;
        Sun,  6 May 2018 23:19:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1525648745;
        bh=Nz6IbdxERGl3lIklFZYepT609HYw3CuZ4hjLkeLRsyM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=tSqCHKgXGYQvSTUSlDiulVmVCSYItepJscIIG6RNNKPn1iyK1gmZING3OXmvognRS
         LVi2O9p5ss+b04JDzHdwWf9Rl6xErwE2Mo/ZflQx8SkVnjGbkjOkqy3toU2ls57aRD
         8kCc18uq6yPpCTy87vp7z9vCoskGlysGssk9oKPHXnOiIFE+piXzuI5DivoRKoYBPa
         IQLf02MafKId9GemqGDqaNgFfy0Q94WTo9Pkl9h/jSeYTC0f9uMg8+a3y4AyUhjruD
         to0A1rk+RSqjYR68LhSHCrUanYZLY2PJyL+fRoSl4C+5A5xW0t2Ih/OUyN8qWfXdS7
         OQytdgWoqz2T9SVNlAfG+5lXpZA2jkftpO32wgR7l2nB/XbbiH8CGTmRsY/vTII+Ip
         FKM+09NRWymdyiButnYjFfGhjeU75F03zrR/y4ySZNwvj9GEGyD6FX/ZMzug8CHCXT
         FNHc/4zAMdOY4ZTqOCGdYRiRPGBAimQNvgR+i0m/HgxpY7kUNrH
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Lars Schneider <larsxschneider@gmail.com>
Subject: [PATCH 28/28] t5300: abstract away SHA-1-specific constants
Date:   Sun,  6 May 2018 23:17:52 +0000
Message-Id: <20180506231752.975110-29-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.17.0.441.gb46fe60e1d
In-Reply-To: <20180506231752.975110-1-sandals@crustytoothpaste.net>
References: <20180506231752.975110-1-sandals@crustytoothpaste.net>
X-Scanned-By: MIMEDefang 2.79 on 127.0.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Adjust the test so that it computes variables for object IDs instead of
using hard-coded hashes.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 t/t5300-pack-object.sh | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/t/t5300-pack-object.sh b/t/t5300-pack-object.sh
index 65ff60f2ee..9e66637a19 100755
--- a/t/t5300-pack-object.sh
+++ b/t/t5300-pack-object.sh
@@ -466,9 +466,11 @@ test_expect_success !PTHREADS,C_LOCALE_OUTPUT 'pack-objects --threads=N or pack.
 
 test_expect_success \
     'fake a SHA1 hash collision' \
-    'test -f	.git/objects/c8/2de19312b6c3695c0c18f70709a6c535682a67 &&
-     cp -f	.git/objects/9d/235ed07cd19811a6ceb342de82f190e49c9f68 \
-		.git/objects/c8/2de19312b6c3695c0c18f70709a6c535682a67'
+    'long_a=$(git hash-object a | sed -e "s!^..!&/!") &&
+     long_b=$(git hash-object b | sed -e "s!^..!&/!") &&
+     test -f	.git/objects/$long_b &&
+     cp -f	.git/objects/$long_a \
+		.git/objects/$long_b'
 
 test_expect_success \
     'make sure index-pack detects the SHA1 collision' \
