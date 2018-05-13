Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E07B01F406
	for <e@80x24.org>; Sun, 13 May 2018 02:25:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751969AbeEMCZE (ORCPT <rfc822;e@80x24.org>);
        Sat, 12 May 2018 22:25:04 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:45200 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751851AbeEMCZB (ORCPT
        <rfc822;git@vger.kernel.org>); Sat, 12 May 2018 22:25:01 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:64f1:3b3f:8f13:59ed])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id C423E60737;
        Sun, 13 May 2018 02:24:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1526178300;
        bh=IHQ1mhtKA9lPZdP8AMJUizBUZJoCkJ5360LQLFN1asQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=vLy0myutrC6Ye41nG1dsBUdh6pyEcwXtahFEV1EVUHA8N7SiacKs1SAQUejS+FwIa
         13rd2ixpfWstk01EPhuF7r1sCfRkfvjMVmwviYyGhs4yxEnu6YNujwbkkVYMC1L7mx
         CqxfFlzk9lDCy0C6ICFw8rib8kqX4oUQPNsoPpRUhLyDQF1zQFKXky9dcat9Zqv4vk
         frAhMDCDshXCCpCL1gYDq+S7yOkf4cQ+Ki/tZ9rM/UBp+6K3TCVPGI0uZ8uk1LWYUL
         VMHNGqqfoTuwywI2+MB/t2UMpZA7FMzYbk3APwqEvPhthJ8gHChFYXushMoCCmbTGj
         nnlEVIDDC+kdxTVFxM6HqpGKxW4/V9wSY6xRWqvNaUdzmSJCxDbq+IhKeQABjDABpY
         doCo94Z6s+huhhyillpuc8d9Y95u9hBfAK1PRhKcKepRwDE/W6KGw70D55tY1xQaCe
         zKXhAAvDBsueYOWax1XuP0exBqnNarE2+EYHnlWEjYBBY2ilgVA
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>,
        =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v2 02/28] t/test-lib: introduce ZERO_OID
Date:   Sun, 13 May 2018 02:24:12 +0000
Message-Id: <20180513022438.60003-3-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.17.0.441.gb46fe60e1d
In-Reply-To: <20180513022438.60003-1-sandals@crustytoothpaste.net>
References: <20180513022438.60003-1-sandals@crustytoothpaste.net>
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
