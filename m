Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B65271F406
	for <e@80x24.org>; Sun, 13 May 2018 02:26:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752086AbeEMC0G (ORCPT <rfc822;e@80x24.org>);
        Sat, 12 May 2018 22:26:06 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:45416 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752061AbeEMC0B (ORCPT
        <rfc822;git@vger.kernel.org>); Sat, 12 May 2018 22:26:01 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:64f1:3b3f:8f13:59ed])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 9D10B6074B;
        Sun, 13 May 2018 02:25:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1526178360;
        bh=Nz6IbdxERGl3lIklFZYepT609HYw3CuZ4hjLkeLRsyM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=LDS9KrN/lXoa1o+TR+I5EXKhM1M9jwP/sAjJwlFBAvIAwInY8A0LSgfUyn+ghpGxN
         zACnFOY4CGscMELSw8EHTKQNAm/Yx0uz5thYsWXiEymn78PPzHlwYjw/aiVXZQuwm3
         Q61OtBD87BBPMJwXcnvc46BFI5lWxx1rGtHhRFYzTxxiwyIlZCamObovimjkvZ/8cv
         0sv1+9foL8wj/7TyN64sVldi98RhbK30FPOOdQP56AwrWJJT3WweI3HV1XBYt9Hog2
         8Nxk0srbWIrWJtDs8xq3EmApnY76HXvIaG5OYfbG0+IUn+WJxak0Ir4EXNd+woB94R
         mrl8wt+5nV8fNn2kRtlCIuutj2fdwxm+KaaqhDHWZH7UZPBU6DgADeVCkzRmI6L+/6
         WdNLOE38zQhzT9GVZS1PPOrZnUl+LXiOu87JgSnjP/igyfuQr83U+Z6Xs34hFfhc9F
         znfhysK7R+5axJcrl+uuber7Vk2lW2VcLBguUje77cjh/yFOP6Z
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>,
        =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v2 28/28] t5300: abstract away SHA-1-specific constants
Date:   Sun, 13 May 2018 02:24:38 +0000
Message-Id: <20180513022438.60003-29-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.17.0.441.gb46fe60e1d
In-Reply-To: <20180513022438.60003-1-sandals@crustytoothpaste.net>
References: <20180513022438.60003-1-sandals@crustytoothpaste.net>
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
