Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4F8631F404
	for <e@80x24.org>; Tue,  6 Feb 2018 00:22:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752177AbeBFAWs (ORCPT <rfc822;e@80x24.org>);
        Mon, 5 Feb 2018 19:22:48 -0500
Received: from mail-pg0-f67.google.com ([74.125.83.67]:37159 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751872AbeBFAWr (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Feb 2018 19:22:47 -0500
Received: by mail-pg0-f67.google.com with SMTP id o1so169137pgn.4
        for <git@vger.kernel.org>; Mon, 05 Feb 2018 16:22:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=1ZcRl4gj1wPi2pWwGz8eFb0oz71au4IU4OGNbz+OiBA=;
        b=ebPzTgmlCCvQ50UVpIBFE4W9GuY6btawAdcASHtMtxW2b9+cOxxNzYV79jwzaQKLto
         MdQw1QCJ5ok/O7oUtTS2AD46ygRpK2vWw4ib1S044zxpHxCqEheZSBEtWVPFj1QLECrs
         oi2AVNtIhtVMzChl8ND1BvZDZfULfB/s5srBmuO+4SdDEz4wfK3dkWScI7Bh2BD49Dzs
         i+usgYoCzD/i1ytMPP+By8OYXJBm07IiSqqKHUt9ZM6ES8ns63ycOljTsNcv5+1N1FTu
         K7zncFfh4jAWKg83f2fANV4bS9ZYV+nCJkQVjJEi7NofKcClPYjxhcSzGhYsFha3wqQL
         77rA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=1ZcRl4gj1wPi2pWwGz8eFb0oz71au4IU4OGNbz+OiBA=;
        b=dhEHoU2UrcbGykGLbLRjFlUVNy0WwZjo+71rPV9tnxE2A9notCTINdPmUdpZ46rrw5
         UkxAdP0MUPg7B+5e0lqXafgRZz4nvkXJILebYZy8NJ+HRZ2c49dcMfz4Pod1lj7Q6Bj3
         ztdrF/HCDuaAsE4hzekpQ4nOUYYNiv86RU6qaeYWNbb46I5iSJQps8ifJp7jcnkQRT4e
         E7pgEQl+9qP1xdIE5Oqa1SLoNnPOUUODLcCjnx2UKSCNAv2NVR1cS6wK0SjD/7hGZJra
         WKtgffXXlxvZALpbWacWPmrsXy53lYTolvlZgsAGCwWqKnTrLtmtZ1MgkUaNhWjsdk4k
         CqaA==
X-Gm-Message-State: APf1xPAcvtliG4jdKc26IYAtYipjhWoxzmg0ibVprfXfinwKRa11xy5T
        CXg+ATwHGW7sleROJR3fSl9/NIasxnw=
X-Google-Smtp-Source: AH8x2251+i+LYXT60U2jUZhfeKDJXWVo3LwJ9UYK/59EiaViwfTeXoO/Xk4H3EgxtGXCfhgbmEPdAw==
X-Received: by 10.101.86.73 with SMTP id m9mr453994pgs.70.1517876566426;
        Mon, 05 Feb 2018 16:22:46 -0800 (PST)
Received: from localhost ([2620:0:100e:422:2d12:5719:3437:fdb7])
        by smtp.gmail.com with ESMTPSA id f80sm17607219pfa.1.2018.02.05.16.22.45
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 05 Feb 2018 16:22:45 -0800 (PST)
From:   Stefan Beller <sbeller@google.com>
To:     git@vger.kernel.org
Cc:     Stefan Beller <sbeller@google.com>
Subject: [PATCH 129/194] alloc: add repository argument to alloc_blob_node
Date:   Mon,  5 Feb 2018 16:16:44 -0800
Message-Id: <20180206001749.218943-31-sbeller@google.com>
X-Mailer: git-send-email 2.15.1.433.g936d1b9894.dirty
In-Reply-To: <20180206001749.218943-1-sbeller@google.com>
References: <20180205235508.216277-1-sbeller@google.com>
 <20180206001749.218943-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 alloc.c | 2 +-
 blob.c  | 2 +-
 cache.h | 3 ++-
 3 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/alloc.c b/alloc.c
index 12afadfacd..6c5c376a25 100644
--- a/alloc.c
+++ b/alloc.c
@@ -49,7 +49,7 @@ static inline void *alloc_node(struct alloc_state *s, size_t node_size)
 }
 
 static struct alloc_state blob_state;
-void *alloc_blob_node(void)
+void *alloc_blob_node_the_repository(void)
 {
 	struct blob *b = alloc_node(&blob_state, sizeof(struct blob));
 	b->object.type = OBJ_BLOB;
diff --git a/blob.c b/blob.c
index 0c53cfce45..7c661f178a 100644
--- a/blob.c
+++ b/blob.c
@@ -9,7 +9,7 @@ struct blob *lookup_blob_the_repository(const struct object_id *oid)
 	struct object *obj = lookup_object(the_repository, oid->hash);
 	if (!obj)
 		return create_object(the_repository, oid->hash,
-				     alloc_blob_node());
+				     alloc_blob_node(the_repository));
 	return object_as_type(the_repository, obj, OBJ_BLOB, 0);
 }
 
diff --git a/cache.h b/cache.h
index 89422e7976..6ee415d9f7 100644
--- a/cache.h
+++ b/cache.h
@@ -1575,7 +1575,8 @@ int decode_85(char *dst, const char *line, int linelen);
 void encode_85(char *buf, const unsigned char *data, int bytes);
 
 /* alloc.c */
-extern void *alloc_blob_node(void);
+#define alloc_blob_node(r) alloc_blob_node_##r()
+extern void *alloc_blob_node_the_repository(void);
 extern void *alloc_tree_node(void);
 extern void *alloc_commit_node(void);
 extern void *alloc_tag_node(void);
-- 
2.15.1.433.g936d1b9894.dirty

