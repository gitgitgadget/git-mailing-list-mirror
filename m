Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2F62C1F404
	for <e@80x24.org>; Tue,  6 Feb 2018 00:23:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752201AbeBFAXR (ORCPT <rfc822;e@80x24.org>);
        Mon, 5 Feb 2018 19:23:17 -0500
Received: from mail-pg0-f68.google.com ([74.125.83.68]:45410 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750879AbeBFAXQ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Feb 2018 19:23:16 -0500
Received: by mail-pg0-f68.google.com with SMTP id m136so153476pga.12
        for <git@vger.kernel.org>; Mon, 05 Feb 2018 16:23:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=l19zfMEydWRdfEz6JKLnQGwAr/IynOQ4uq7rnvnTCPw=;
        b=gQ9eZ2nuIGqFlYRdc3Sr2A6NKQWee2B/gJZ9jlFFsaMLP+VrEgptAYmzagaK788jXW
         kfq7NmSbRt2850n43rxPiX91Ujih1I0ZDSOkQ98KixggE61FF0zdHbJGJ5ZILQCk0Oth
         8tQTmp/cNBx3uF374Z+1BzkYZWL/lIFirKYUK0axedSKJ40Ydnbf3kA13vqB01rPUHTr
         wIdIq0aUS4FFZFhkRVjVo7PX8AeehCxgAPQ5D+IL7LmGQE4SC/X9mjxBCw+Ro9IT34uC
         51vo52O809F8DUvce1vrkHZLhfcIUz0qgx3Pv39UEpAmL23RHlVP6uJALYpWFfezx2Jr
         4Uvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=l19zfMEydWRdfEz6JKLnQGwAr/IynOQ4uq7rnvnTCPw=;
        b=RrSV85wNFD71d/Bu3AKAbebDQo++QyqyfzqqCHAciUIS0L778LgPWbzRXDzhfU7+Hw
         oBI0914PYU9M1Qp9uzN/v4znvva706f7pvhs5kcWjqVEdSHjjybiCFZurxwkX7+21GoV
         CWegkZadRsRQRvpb1VvY4t5havkt5EPhn+xsXPP55jnmW24S7kv6vYe6Nm7Yx0oA+PLs
         pfRod51ARksoK60XI2+jQc0dGj6SmeXT16rpEkBtfQo8JCZeYagvQpWlEGOZXaZDhrXH
         4TM72FWvrLrn1JSCe6AIEQFedfqEZ0cqXk6Kpsf8YwIAHwB2p5L3H7zdu7i+2RI3JC6m
         ElPQ==
X-Gm-Message-State: APf1xPAYnYOuncYsC/bi0h6vnwenARauVZs9dGBh8qcvZwduv3YJvPjR
        7s5JTX5ngb+hA/Qx7xXXLcCjeUveUPA=
X-Google-Smtp-Source: AH8x226/eHpfWNxssuYLuPb38XUuH7Fv+EiAwzIUYHlR+WDTR7Zvd6DpPNcR9bi1EHBa5UanlZTYJw==
X-Received: by 10.98.214.7 with SMTP id r7mr566252pfg.24.1517876595223;
        Mon, 05 Feb 2018 16:23:15 -0800 (PST)
Received: from localhost ([2620:0:100e:422:2d12:5719:3437:fdb7])
        by smtp.gmail.com with ESMTPSA id l64sm20592745pfg.62.2018.02.05.16.23.14
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 05 Feb 2018 16:23:14 -0800 (PST)
From:   Stefan Beller <sbeller@google.com>
To:     git@vger.kernel.org
Cc:     Stefan Beller <sbeller@google.com>
Subject: [PATCH 132/194] alloc: add repository argument to alloc_tag_node
Date:   Mon,  5 Feb 2018 16:16:47 -0800
Message-Id: <20180206001749.218943-34-sbeller@google.com>
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
 tag.c   | 2 +-
 3 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/alloc.c b/alloc.c
index 9e2b897ec1..290250e359 100644
--- a/alloc.c
+++ b/alloc.c
@@ -65,7 +65,7 @@ void *alloc_tree_node_the_repository(void)
 }
 
 static struct alloc_state tag_state;
-void *alloc_tag_node(void)
+void *alloc_tag_node_the_repository(void)
 {
 	struct tag *t = alloc_node(&tag_state, sizeof(struct tag));
 	t->object.type = OBJ_TAG;
diff --git a/cache.h b/cache.h
index cb41e22123..36c01bdcf5 100644
--- a/cache.h
+++ b/cache.h
@@ -1581,7 +1581,8 @@ extern void *alloc_blob_node_the_repository(void);
 extern void *alloc_tree_node_the_repository(void);
 #define alloc_commit_node(r) alloc_commit_node_##r()
 extern void *alloc_commit_node_the_repository(void);
-extern void *alloc_tag_node(void);
+#define alloc_tag_node(r) alloc_tag_node_##r()
+extern void *alloc_tag_node_the_repository(void);
 extern void *alloc_object_node(void);
 extern void alloc_report(void);
 extern unsigned int alloc_commit_index(void);
diff --git a/tag.c b/tag.c
index abba1b8d88..e0b695cb60 100644
--- a/tag.c
+++ b/tag.c
@@ -97,7 +97,7 @@ struct tag *lookup_tag_the_repository(const struct object_id *oid)
 	struct object *obj = lookup_object(the_repository, oid->hash);
 	if (!obj)
 		return create_object(the_repository, oid->hash,
-				     alloc_tag_node());
+				     alloc_tag_node(the_repository));
 	return object_as_type(the_repository, obj, OBJ_TAG, 0);
 }
 
-- 
2.15.1.433.g936d1b9894.dirty

