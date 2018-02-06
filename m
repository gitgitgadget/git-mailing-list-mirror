Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3CC8D1F404
	for <e@80x24.org>; Tue,  6 Feb 2018 00:22:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752196AbeBFAWv (ORCPT <rfc822;e@80x24.org>);
        Mon, 5 Feb 2018 19:22:51 -0500
Received: from mail-pg0-f65.google.com ([74.125.83.65]:45338 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752013AbeBFAWs (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Feb 2018 19:22:48 -0500
Received: by mail-pg0-f65.google.com with SMTP id m136so152498pga.12
        for <git@vger.kernel.org>; Mon, 05 Feb 2018 16:22:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=F/ywovUGPd2zwRv8RBLj3aKxLAA9gEDupam+lBe1UYw=;
        b=rJvdfggaXaEY6W/vFzcfb4s9+C8yg+PnEkmfV2IlCqmJGMdKJe3XZntAiGNcymERNs
         HQmqFIno1mxeqwxBLz04LYJ3y/9meFl+IsD0C7GkifdGStlZz6ze+NJmEOOBXjkdwdUp
         1vVxkkzPBXGMYnSJalP8R3gesNcEBYj7zv/NnQGxnpc3UKpCHZM8WQYQ0TJABYrP4w4n
         qYOlFeaf70rPYHuq6VJCmpELbaTZv2PbNFnzz4vy5Uk5hXsOWCNgDrqg2a6CaF5hSnTP
         BGN/eQuT9M3vrfZkKIFgI/1M/WkMcUkgeQJ+C+lD8SlIOXLLf20199xGiiT2ktAEkSFy
         gXSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=F/ywovUGPd2zwRv8RBLj3aKxLAA9gEDupam+lBe1UYw=;
        b=iSP5XH7q35Q5k0ffqetU2tX6RvV7h7z4hPOF57U3BidGRR83z4CsMJ2P5fHIr6HQMH
         nGQ+ioe13ghUWQMcWPVY8SUyZhn1IkyI+/Zxmurfjp9qE33V+lWAgtFsYUa3BGhZkzAP
         +gFCfc197q/mOgWVZ3Erdol6LMFyKdsPbLBXbifoRlRlBqXr/U9z94PvhHjeAJ5jW2fB
         zqj6bpglAW12IwiDr4ewMTsVK+6Tzh44eHgsmY34eKMWoi0yYuUZBzF/i3hG21YC1P7/
         DT4js+TH/s9aFjm5rUOWXGx82h6CwEdMAB3AkcbmmTejXeAQ0xsoBGYF4T3u2Z01JvLL
         i/Yw==
X-Gm-Message-State: APf1xPA4H5XSq1Baiy+0M4N6rJEN2x64czFHHvO2DE1YT5pQgjOoBTJl
        97bxRJqlOpMXVXRRAetkcl1HP6Hp1u0=
X-Google-Smtp-Source: AH8x225T+Eu4TsGOrP8Wy0DSI6qxj+vzLI+660vX1RPCoQFdv6CPrdtEgJ19HwKzV6PxUiGR0JBbPg==
X-Received: by 10.98.5.129 with SMTP id 123mr541480pff.75.1517876567699;
        Mon, 05 Feb 2018 16:22:47 -0800 (PST)
Received: from localhost ([2620:0:100e:422:2d12:5719:3437:fdb7])
        by smtp.gmail.com with ESMTPSA id f8sm4157664pgs.51.2018.02.05.16.22.46
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 05 Feb 2018 16:22:47 -0800 (PST)
From:   Stefan Beller <sbeller@google.com>
To:     git@vger.kernel.org
Cc:     Stefan Beller <sbeller@google.com>
Subject: [PATCH 130/194] alloc: add repository argument to alloc_tree_node
Date:   Mon,  5 Feb 2018 16:16:45 -0800
Message-Id: <20180206001749.218943-32-sbeller@google.com>
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
 cache.h | 3 ++-
 tree.c  | 2 +-
 3 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/alloc.c b/alloc.c
index 6c5c376a25..2c8d143075 100644
--- a/alloc.c
+++ b/alloc.c
@@ -57,7 +57,7 @@ void *alloc_blob_node_the_repository(void)
 }
 
 static struct alloc_state tree_state;
-void *alloc_tree_node(void)
+void *alloc_tree_node_the_repository(void)
 {
 	struct tree *t = alloc_node(&tree_state, sizeof(struct tree));
 	t->object.type = OBJ_TREE;
diff --git a/cache.h b/cache.h
index 6ee415d9f7..6a794aa903 100644
--- a/cache.h
+++ b/cache.h
@@ -1577,7 +1577,8 @@ void encode_85(char *buf, const unsigned char *data, int bytes);
 /* alloc.c */
 #define alloc_blob_node(r) alloc_blob_node_##r()
 extern void *alloc_blob_node_the_repository(void);
-extern void *alloc_tree_node(void);
+#define alloc_tree_node(r) alloc_tree_node_##r()
+extern void *alloc_tree_node_the_repository(void);
 extern void *alloc_commit_node(void);
 extern void *alloc_tag_node(void);
 extern void *alloc_object_node(void);
diff --git a/tree.c b/tree.c
index 37fec8623b..07cea88450 100644
--- a/tree.c
+++ b/tree.c
@@ -199,7 +199,7 @@ struct tree *lookup_tree_the_repository(const struct object_id *oid)
 	struct object *obj = lookup_object(the_repository, oid->hash);
 	if (!obj)
 		return create_object(the_repository, oid->hash,
-				     alloc_tree_node());
+				     alloc_tree_node(the_repository));
 	return object_as_type(the_repository, obj, OBJ_TREE, 0);
 }
 
-- 
2.15.1.433.g936d1b9894.dirty

