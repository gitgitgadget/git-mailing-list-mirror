Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 604E91F6C1
	for <e@80x24.org>; Fri, 19 Aug 2016 02:01:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754269AbcHSAyU (ORCPT <rfc822;e@80x24.org>);
        Thu, 18 Aug 2016 20:54:20 -0400
Received: from mga11.intel.com ([192.55.52.93]:55818 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754004AbcHSAyQ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 Aug 2016 20:54:16 -0400
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga102.fm.intel.com with ESMTP; 18 Aug 2016 17:00:46 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.28,542,1464678000"; 
   d="scan'208";a="867906884"
Received: from jekeller-desk.amr.corp.intel.com (HELO jekeller-desk.jekeller.internal) ([134.134.3.116])
  by orsmga003.jf.intel.com with ESMTP; 18 Aug 2016 17:00:40 -0700
From:   Jacob Keller <jacob.e.keller@intel.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Stefan Beller <stefanbeller@gmail.com>,
        Jeff King <peff@peff.net>, Johannes Sixt <j6t@kdbg.org>,
        Jacob Keller <jacob.keller@gmail.com>
Subject: [PATCH v8 7/8] cache: add empty_tree_oid object
Date:   Thu, 18 Aug 2016 17:00:30 -0700
Message-Id: <20160819000031.24854-8-jacob.e.keller@intel.com>
X-Mailer: git-send-email 2.10.0.rc0.217.g609f9e8.dirty
In-Reply-To: <20160819000031.24854-1-jacob.e.keller@intel.com>
References: <20160819000031.24854-1-jacob.e.keller@intel.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jacob Keller <jacob.keller@gmail.com>

Add an empty_tree_oid object which can be used in place of
EMPTY_TREE_SHA1_BIN_LITERAL for code which is being converted to struct
object_id.

Signed-off-by: Jacob Keller <jacob.keller@gmail.com>
---
 cache.h     | 2 ++
 sha1_file.c | 3 +++
 2 files changed, 5 insertions(+)

diff --git a/cache.h b/cache.h
index f30a4417efdf..da9f0be67d7b 100644
--- a/cache.h
+++ b/cache.h
@@ -964,6 +964,8 @@ static inline void oidclr(struct object_id *oid)
 #define EMPTY_BLOB_SHA1_BIN \
 	((const unsigned char *) EMPTY_BLOB_SHA1_BIN_LITERAL)
 
+extern const struct object_id empty_tree_oid;
+
 static inline int is_empty_blob_sha1(const unsigned char *sha1)
 {
 	return !hashcmp(sha1, EMPTY_BLOB_SHA1_BIN);
diff --git a/sha1_file.c b/sha1_file.c
index 1e23fc186a02..10883d56a600 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -38,6 +38,9 @@ static inline uintmax_t sz_fmt(size_t s) { return s; }
 
 const unsigned char null_sha1[20];
 const struct object_id null_oid;
+const struct object_id empty_tree_oid = {
+	.hash = EMPTY_TREE_SHA1_BIN_LITERAL
+};
 
 /*
  * This is meant to hold a *small* number of objects that you would
-- 
2.10.0.rc0.217.g609f9e8.dirty

