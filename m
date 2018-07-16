Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E89CE1F597
	for <e@80x24.org>; Mon, 16 Jul 2018 01:28:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727531AbeGPBxV (ORCPT <rfc822;e@80x24.org>);
        Sun, 15 Jul 2018 21:53:21 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:58960 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727469AbeGPBxS (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 15 Jul 2018 21:53:18 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:78f3:848c:e199:5398])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 31D346077B;
        Mon, 16 Jul 2018 01:28:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1531704501;
        bh=kooRTQrVZbLa+3VM2xFOZ/aF0DSny2EtmdQ1Efx/kSk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=Ja+20c5ZWXqt/5wxLhAqmyCxoYZ0T2sj/rKbDG2Nl7I0UM1Y6ZYYvUgC421wJIfet
         adWhgj6QqURDv0z14o+rNFQEgFrnRXxEkYA2KIbFhk/ieKefXmSkhZgKXX4MsBX7Sm
         WgZd6VFJJo+C58+DRCHcptiE49X4oCehuF7k20AeVZ1I1ao+EXxisuBW74WqqGx5Td
         QUR4u/ueBriUA0buNMFU3pnjETWNlFNm0YH3aQP1XoX/9Q7nLQdndjyQKnWfqqS/Jo
         q+5d3pxUS5WxIrjoPjSPSnnNv8/x8ciDVq7kQen7XTGUequWN5EkY4RY14DNXJKOTl
         yunODik6pHBn2CGFY1l0EfxCgSt2XYfEYBeQRekkaO0smZ3dwxEM/XCTamiLwNiiFA
         ID+uZ+C6ua7TQZnGLR0M2eBN1YvpbH4PacvmlmocyumqBWlrHkEeuIA7tdplVrpHCX
         D6MLTjrBrO4RJMJHkcuBLBcXFrcMRlMLBg9pdSQsXBd+A2tu48z
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Derrick Stolee <stolee@gmail.com>,
        Stefan Beller <sbeller@google.com>,
        Brandon Williams <bmwill@google.com>,
        Jacob Keller <jacob.keller@gmail.com>
Subject: [PATCH v2 04/16] commit: express tree entry constants in terms of the_hash_algo
Date:   Mon, 16 Jul 2018 01:27:56 +0000
Message-Id: <20180716012808.961328-5-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.18.0.399.gad0ab374a1
In-Reply-To: <20180716012808.961328-1-sandals@crustytoothpaste.net>
References: <20180716012808.961328-1-sandals@crustytoothpaste.net>
X-Scanned-By: MIMEDefang 2.79 on 127.0.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Specify these constants in terms of the size of the hash algorithm
currently in use.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 commit.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/commit.c b/commit.c
index 0c3b75aeff..ff05d04570 100644
--- a/commit.c
+++ b/commit.c
@@ -364,8 +364,8 @@ int parse_commit_buffer(struct commit *item, const void *buffer, unsigned long s
 	struct object_id parent;
 	struct commit_list **pptr;
 	struct commit_graft *graft;
-	const int tree_entry_len = GIT_SHA1_HEXSZ + 5;
-	const int parent_entry_len = GIT_SHA1_HEXSZ + 7;
+	const int tree_entry_len = the_hash_algo->hexsz + 5;
+	const int parent_entry_len = the_hash_algo->hexsz + 7;
 
 	if (item->object.parsed)
 		return 0;
