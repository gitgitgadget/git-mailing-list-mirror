Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4E1941F51C
	for <e@80x24.org>; Mon, 21 May 2018 02:03:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752716AbeEUCDp (ORCPT <rfc822;e@80x24.org>);
        Sun, 20 May 2018 22:03:45 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:50922 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752661AbeEUCCt (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 20 May 2018 22:02:49 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:fc4d:8d90:22bd:91d8])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 439AD6074D;
        Mon, 21 May 2018 02:02:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1526868168;
        bh=FwO6egZ+eCKAvx75GR6uOmwfnom5OWjZ+5PGENnpuBM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=jy33l9ejpwHCRAz6FcCo9lJUKZMVaFFX5g7QdoaOFEZJGM0q9hfbw7pvnuzXOY8RB
         QqM1qpltsWJEadbGM1w10kXShOX8eQOYW3173Jrt5PQjSGi9b4CjjOdNi1aaS4Dre4
         DVHIKjvXqqJnIRWHtsUnwUTRtkQw0jpiEgeNLWTvqoBfKd134isF5zi/hIVomni0ez
         GXLHHIrHyDTV5l4UEfr59GcsqvM2XzNe4JcKJIkMMu1IUAWAS6OCvJX7sexp/eIIVN
         eTDF6D0uATqBy5YZSTsfFcWNGdNX/1PIDo9GwzxiEzP4I2ZFFFhjyM6tS4UnKbpvSE
         UOhaMNNdGFu2q9SAbBmM6kQzL7+RCw92P/f52uSqdS5ZKwWqFTFlr6D6cSITq9ugva
         vSZbWcuhkMWELDxar83wM5Xbol69/kAvUzh3esTjpzmrYHwqYgfBHGOJvcsMO2JvU1
         RW9D9zBfntvUlyNnyeYZkYd1tgbfxceI5HJPOR6wTNwbFjF2ECx
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>,
        =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Johannes Sixt <j6t@kdbg.org>,
        Stefan Beller <sbeller@google.com>
Subject: [PATCH v4 12/28] t3103: abstract away SHA-1-specific constants
Date:   Mon, 21 May 2018 02:01:31 +0000
Message-Id: <20180521020147.648496-13-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.17.0.441.gb46fe60e1d
In-Reply-To: <20180521020147.648496-1-sandals@crustytoothpaste.net>
References: <20180516015630.661349-1-sandals@crustytoothpaste.net>
 <20180521020147.648496-1-sandals@crustytoothpaste.net>
X-Scanned-By: MIMEDefang 2.79 on 127.0.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Adjust the test so that it uses variables and command substitution for
trees instead of hard-coded hashes.  This also has the benefit of making
it more obvious how the test works.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 t/t3103-ls-tree-misc.sh | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/t/t3103-ls-tree-misc.sh b/t/t3103-ls-tree-misc.sh
index 09dcf043fd..14520913af 100755
--- a/t/t3103-ls-tree-misc.sh
+++ b/t/t3103-ls-tree-misc.sh
@@ -17,7 +17,8 @@ test_expect_success 'setup' '
 '
 
 test_expect_success 'ls-tree fails with non-zero exit code on broken tree' '
-	rm -f .git/objects/5f/cffbd6e4c5c5b8d81f5e9314b20e338e3ffff5 &&
+	tree=$(git rev-parse HEAD:a) &&
+	rm -f .git/objects/$(echo $tree | sed -e "s,^\(..\),\1/,") &&
 	test_must_fail git ls-tree -r HEAD
 '
 
