Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9AA6D1F453
	for <e@80x24.org>; Thu, 25 Oct 2018 02:40:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727261AbeJYLK5 (ORCPT <rfc822;e@80x24.org>);
        Thu, 25 Oct 2018 07:10:57 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:52346 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727189AbeJYLK5 (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 25 Oct 2018 07:10:57 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:e0bc:761d:9be1:27bc])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id BC4E861B73;
        Thu, 25 Oct 2018 02:40:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1540435215;
        bh=IVpe+0tMiZrDXXOWLcQmdP7lPOUcFQ8bTzgTDCGq2Kg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=drQ4KWZo1CvhedSB5iWsvD0mNsia0sBYPKu/naDLB/MaM+7Zk7DUeinvsd+ara5/A
         Pd/lgD6bZBrT7irz4zpNK7nxS1gy4bfmvTvzRNM51U6A01NB9ZnJAqKonZ5O5r4lBm
         l7hOvcHKnKmCEkJN3XXlcbPZCLyaXzp8+vS68c1KbqcIW9ObJe7b45GzBgGo2m/r2N
         ciIAYs2i9SSxSh/ssQyM+WPpXoj/Do7GK0gPJDQKq/LrzFZg31nWBE3AUl/rkCta9a
         986ubgrH141R9UnV6gmGpQEhGFDJ/d5qFXPruuLcSs+56oJzkkefSDDXuEZ2JFrlVH
         IUW7XW6YEsiphu7920manbQJA8NW2nxjKr9dJScY0Y6mHlqVnD3XoLMKQfe/4aLaua
         IUVzj8sCwCYSB2uLlTWWN8COz1tsDM7SFUWQciC9z1YS53FR7acgu718SOu2AXB5gB
         u1ckAqJZlIooDMedgYmd7jJKIHSXkmOtCuQnNOuLgtq7WsSq+DK
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     git@vger.kernel.org
Cc:     Derrick Stolee <stolee@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Duy Nguyen <pclouds@gmail.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCH v4 01/12] sha1-file: rename algorithm to "sha1"
Date:   Thu, 25 Oct 2018 02:39:54 +0000
Message-Id: <20181025024005.154208-2-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.19.1.759.g500967bb5e
In-Reply-To: <20181025024005.154208-1-sandals@crustytoothpaste.net>
References: <20181025024005.154208-1-sandals@crustytoothpaste.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 127.0.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The transition plan anticipates us using a syntax such as "^{sha1}" for
disambiguation.  Since this is a syntax some people will be typing a
lot, it makes sense to provide a short, easy-to-type syntax.  Omitting
the dash doesn't create any ambiguity; however, it does make the syntax
shorter and easier to type, especially for touch typists.  In addition,
the transition plan already uses "sha1" in this context.

Rename the name of SHA-1 implementation to "sha1".

Note that this change creates no backwards compatibility concerns, since
we haven't yet used this field in any configuration settings.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 sha1-file.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sha1-file.c b/sha1-file.c
index dd0b6aa873..91311ebb3d 100644
--- a/sha1-file.c
+++ b/sha1-file.c
@@ -97,7 +97,7 @@ const struct git_hash_algo hash_algos[GIT_HASH_NALGOS] = {
 		NULL,
 	},
 	{
-		"sha-1",
+		"sha1",
 		/* "sha1", big-endian */
 		0x73686131,
 		GIT_SHA1_RAWSZ,
