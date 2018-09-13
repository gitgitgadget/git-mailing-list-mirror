Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BF7251F404
	for <e@80x24.org>; Thu, 13 Sep 2018 05:18:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727560AbeIMK0X (ORCPT <rfc822;e@80x24.org>);
        Thu, 13 Sep 2018 06:26:23 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:54510 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726317AbeIMK0W (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 13 Sep 2018 06:26:22 -0400
Received: from genre.crustytoothpaste.net (108-60-118-130.static.wiline.com [108.60.118.130])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 6A45B6075B;
        Thu, 13 Sep 2018 05:18:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1536815910;
        bh=4dNved9Giv5HuzINQy2XTv7c4dl/8S67uvpPNcu/AbA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=L/LB8hEHqLAE06U09CuuMEIbQ3Sdpf7wI4qjS4Taw9XGIu91/caoV2yRV/X9jRdcI
         IFk03K88sHKwaTC++/dwz+IkNYZslGixnoYc4KHS2f3pzAGU0F7TK/xvwRvmuYw9gQ
         IdM/IrrnvalzJTS/JRHnQ+T0HYEeebtLYbE5+blwsOrjHYNnjUpfMSSNmCejvzMlOq
         WTFh36MhzPvORYVj84/aZOQ2VL+VYwsWrjGA75f7WngdZPZxW7zVyMaNoPt+Bfszki
         Ny4soEwJAwz8YrY+TP0Tu0YAgRsGLb5HeRurKseHKHbuPSZpUh9REyt0vi23PDHJG9
         pQwMzzYeZNLTPNhEQCXemtPcbnsjk4Df24xwaFZoxIm8awQp94s2zHhzIj45BUJjNC
         rZ3EM4/zrPtNvK+Q7L0r8xKpP7MaUTD+s2QQ7WhEPAck6/vDjo8YG+vzTaoIL1gzTb
         mzo7kUV9aTae75bvchE5xRI3dG5wH4ufg1i7nOjJChKcsFkyhxZ
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>,
        =?UTF-8?q?Torsten=20B=C3=B6gershausen?= <tboegi@web.de>,
        Derrick Stolee <stolee@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v5 12/12] t5318: use test_oid for HASH_LEN
Date:   Thu, 13 Sep 2018 05:17:42 +0000
Message-Id: <20180913051742.252276-13-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.19.0.397.gdd90340f6a
In-Reply-To: <20180913051742.252276-1-sandals@crustytoothpaste.net>
References: <20180913051742.252276-1-sandals@crustytoothpaste.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 127.0.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <stolee@gmail.com>

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 t/t5318-commit-graph.sh | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/t/t5318-commit-graph.sh b/t/t5318-commit-graph.sh
index 0c500f7ca2..75fe09521f 100755
--- a/t/t5318-commit-graph.sh
+++ b/t/t5318-commit-graph.sh
@@ -8,7 +8,8 @@ test_expect_success 'setup full repo' '
 	cd "$TRASH_DIRECTORY/full" &&
 	git init &&
 	git config core.commitGraph true &&
-	objdir=".git/objects"
+	objdir=".git/objects" &&
+	test_oid_init
 '
 
 test_expect_success 'verify graph with no graph file' '
@@ -273,7 +274,7 @@ test_expect_success 'git commit-graph verify' '
 
 NUM_COMMITS=9
 NUM_OCTOPUS_EDGES=2
-HASH_LEN=20
+HASH_LEN="$(test_oid rawsz)"
 GRAPH_BYTE_VERSION=4
 GRAPH_BYTE_HASH=5
 GRAPH_BYTE_CHUNK_COUNT=6
