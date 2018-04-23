Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BF4D41F424
	for <e@80x24.org>; Mon, 23 Apr 2018 23:40:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932699AbeDWXkL (ORCPT <rfc822;e@80x24.org>);
        Mon, 23 Apr 2018 19:40:11 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:60478 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S932672AbeDWXkH (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 23 Apr 2018 19:40:07 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:e6b3:18ff:fe98:41a3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 70A1E6099F;
        Mon, 23 Apr 2018 23:40:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1524526804;
        bh=4cL0vdecJOAlokEEZrYqtYowwzHWcuByFD7sNd0NBYM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=UxKaNqNXMgzyv5Mi1UqsHbzQ3AwrYbpyTwWSgQb2ay+DRljj1XAg1gJ38SPDVlZ/R
         ue2Or468tT9emWxazuAQe8t7q8/IYUKyZzFBcIFZ6BNZZml9kaRCAga7N9o07A/edF
         ydoK1mm+AdmT1IKvrsEFKYcsyHGkeH3WmhQGUqpEjJJ6SaJl+Cpby8b/dWLCZzL7W2
         hU04mzQYM27V74+Bo/TFthPcMIRaoleyWo+pJVQaLSGoPPo1w7naZctUhPjTEOt6MO
         skjSTMXV1vIvzUdFVedRy7H16uI/NKqffkbxMPB/bB3e37WxlqwFzzOiDRXdXM/q6+
         0kqtQl0U7v+YdlUXPii18gG8jWmBSsJvp/fNJjqEz8Fp/BmnlbIYDFjPn5/5x4LFsL
         Z/sOWjLtqw0L6vUNAsoNq+ZwJQwtE/mLjDMw5ErphuIixFcZNHNJqla1aKzNKK+Vzi
         E6Xru5PQRNw0h5AM9Ufirypw2gahyniu3zz4LxZggHGUMjTRwyc
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH 02/41] server-info: remove unused members from struct pack_info
Date:   Mon, 23 Apr 2018 23:39:12 +0000
Message-Id: <20180423233951.276447-3-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.17.0.290.gded63e768a
In-Reply-To: <20180423233951.276447-1-sandals@crustytoothpaste.net>
References: <20180423233951.276447-1-sandals@crustytoothpaste.net>
X-Scanned-By: MIMEDefang 2.79 on 127.0.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The head member of struct pack_info is completely unused and the
nr_heads member is used only in one place, which is an assignment.
Since these structure members are not useful, remove them.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 server-info.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/server-info.c b/server-info.c
index 83460ec0d6..828ec5e538 100644
--- a/server-info.c
+++ b/server-info.c
@@ -92,8 +92,6 @@ static struct pack_info {
 	int old_num;
 	int new_num;
 	int nr_alloc;
-	int nr_heads;
-	unsigned char (*head)[20];
 } **info;
 static int num_pack;
 static const char *objdir;
@@ -228,7 +226,6 @@ static void init_pack_info(const char *infofile, int force)
 	for (i = 0; i < num_pack; i++) {
 		if (stale) {
 			info[i]->old_num = -1;
-			info[i]->nr_heads = 0;
 		}
 	}
 
