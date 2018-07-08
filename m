Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E075C1F62D
	for <e@80x24.org>; Sun,  8 Jul 2018 23:36:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933056AbeGHXgy (ORCPT <rfc822;e@80x24.org>);
        Sun, 8 Jul 2018 19:36:54 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:54314 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S932799AbeGHXgx (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 8 Jul 2018 19:36:53 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:5996:38d5:9b31:ef84])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id DF2FE60748;
        Sun,  8 Jul 2018 23:36:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1531093012;
        bh=kooRTQrVZbLa+3VM2xFOZ/aF0DSny2EtmdQ1Efx/kSk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=z9QVjsWSMxGbOQDj14oNbghjgtSOqRA8Zrt+1Q7zl5mQBIlf+VCJBxCKSsBhktETy
         aMFubi8fOHHxKVtIOr4pgmnFSkqHpPAX44fo9Xg15qL750cDU5ZedCQdi2jKlntFt8
         lmjZIz13KfR08Kkxojai8BQHgU7k6fsWoTIFJXbZljjgswD+n+XtNael+cS0X4Jyil
         j3UjDPXYdQUBcJEAnaF9DveaqVSqFr3s6DGDIw9qx05dCkHZ26Pa8O8A76uiIbtdJ5
         1JYFnnB/iZ1I8yJ2l0/1M6LDV6DfBE11fPvMGX9Yu7CyWs601vrxUUgSOfcNyWCXPF
         ephLzZ+MOOCMH2oSq3ngJLZOYC4peHQ+uoU1bIl9N2j7KnSPJk8aLxpFBN3EitY6sd
         FbDNGL8j9V+6WdBDVwL4kWyR27VFo4Y8girteomxJZCqKyYH5qMPmcWvPeF4L7VJwV
         xgpXDIEud22RDEluGXgMaoUeSYiYI5hE7RF8bF3m5hjPgZkz7dg
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH 04/17] commit: express tree entry constants in terms of the_hash_algo
Date:   Sun,  8 Jul 2018 23:36:25 +0000
Message-Id: <20180708233638.520172-5-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.18.0.399.gad0ab374a1
In-Reply-To: <20180708233638.520172-1-sandals@crustytoothpaste.net>
References: <20180708233638.520172-1-sandals@crustytoothpaste.net>
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
