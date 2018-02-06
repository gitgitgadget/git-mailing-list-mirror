Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B4F641F404
	for <e@80x24.org>; Tue,  6 Feb 2018 00:23:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752180AbeBFAXs (ORCPT <rfc822;e@80x24.org>);
        Mon, 5 Feb 2018 19:23:48 -0500
Received: from mail-pl0-f66.google.com ([209.85.160.66]:44063 "EHLO
        mail-pl0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751837AbeBFAXq (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Feb 2018 19:23:46 -0500
Received: by mail-pl0-f66.google.com with SMTP id f8so120273plk.11
        for <git@vger.kernel.org>; Mon, 05 Feb 2018 16:23:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=TKmJWvBdw9HU0oTvqCkhqdmC2p9dLpfNi298U6rx3Sc=;
        b=JoYoDLWkIsH7VG3cpvLfatPSfLDOBUGFBSEJa9M46uGxuy0+S6LMkSxhByhHh5biZs
         DsoCsLIktLcBb5ead73YXkv8C9E9lQDAZO7kpDt6ZwOkE6oGwAVaaN24r6ZdUUSFb/OA
         0jN3Jl3opdKoAQvclgcnYh7VB5TxdGScN2e/hz14Y01JXPJ2WMj/RiRIXAYs2Yb4pR9f
         UP3m0LnxrpMoeSXXz3hzReNAatEanaswRm+pKrPWT+hfEKUQkxxnZ4WkA4EfJpWjMmw6
         onp1wAGvXafRfH7gBaELUI4/WY63Q7TlF4I/0QQW6EHmNhT3+fE4Ym2XlBpR9PPzprJb
         oCCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=TKmJWvBdw9HU0oTvqCkhqdmC2p9dLpfNi298U6rx3Sc=;
        b=DYUhDdCM4Z+HHLE9NAU6pUBQ8juHjqJ9+GyhYihXR5BlYEE3KwKNlw5Rvm0pwMo6Sc
         TNG5hwLHrv5cClJncWBT9IdDfttxANxCre7EEpSyfIiibRyVhEgb6rPlJ8NkoXRvPoPi
         o6S7E7VLVu47/VuQgvLRX0Qe3Q7RrGinqxZDMGG9y48p/lqhfEtbsVv8b7z41QmZKohv
         BJ0i5jwpuY5JcWNbbOt+yH0B5RIM3VTrcdgNTShDhsrv3KWPQMf4Rud4Aer4NQ+lTkIr
         exCEE6yWNoRy2xXOQ5c4qGFvsea/7b+rpM2RbUTizmf3iW4DeB3gaaOIKu1lbNsmrytP
         imCQ==
X-Gm-Message-State: APf1xPAr/DbKUhuqgtM3SZCiZym2PakQdlDUnLxVpx/rei9zxK0wp71i
        mKUZs1JGZaw0KoHpyEGkjGlbqbiu9gg=
X-Google-Smtp-Source: AH8x2260Rr3Y/RQ4YPyZNJvpA/whgEhDE+9cNTUYfNRU58NUfGpxMerKdu24y1lks3QIglWcF9p2Ig==
X-Received: by 2002:a17:902:8307:: with SMTP id bd7-v6mr522384plb.369.1517876625773;
        Mon, 05 Feb 2018 16:23:45 -0800 (PST)
Received: from localhost ([2620:0:100e:422:2d12:5719:3437:fdb7])
        by smtp.gmail.com with ESMTPSA id a28sm17750771pfe.70.2018.02.05.16.23.45
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 05 Feb 2018 16:23:45 -0800 (PST)
From:   Stefan Beller <sbeller@google.com>
To:     git@vger.kernel.org
Cc:     Stefan Beller <sbeller@google.com>
Subject: [PATCH 135/194] alloc: add repository argument to alloc_commit_index
Date:   Mon,  5 Feb 2018 16:16:50 -0800
Message-Id: <20180206001749.218943-37-sbeller@google.com>
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
 alloc.c  | 4 ++--
 cache.h  | 3 ++-
 object.c | 2 +-
 3 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/alloc.c b/alloc.c
index 28b85b2214..277dadd221 100644
--- a/alloc.c
+++ b/alloc.c
@@ -82,7 +82,7 @@ void *alloc_object_node_the_repository(void)
 
 static struct alloc_state commit_state;
 
-unsigned int alloc_commit_index(void)
+unsigned int alloc_commit_index_the_repository(void)
 {
 	static unsigned int count;
 	return count++;
@@ -92,7 +92,7 @@ void *alloc_commit_node_the_repository(void)
 {
 	struct commit *c = alloc_node(&commit_state, sizeof(struct commit));
 	c->object.type = OBJ_COMMIT;
-	c->index = alloc_commit_index();
+	c->index = alloc_commit_index(the_repository);
 	return c;
 }
 
diff --git a/cache.h b/cache.h
index 5c9807fa8f..40aa3f25aa 100644
--- a/cache.h
+++ b/cache.h
@@ -1587,7 +1587,8 @@ extern void *alloc_tag_node_the_repository(void);
 extern void *alloc_object_node_the_repository(void);
 #define alloc_report(r) alloc_report_##r()
 extern void alloc_report_the_repository(void);
-extern unsigned int alloc_commit_index(void);
+#define alloc_commit_index(r) alloc_commit_index_##r()
+extern unsigned int alloc_commit_index_the_repository(void);
 
 /* pkt-line.c */
 void packet_trace_identity(const char *prog);
diff --git a/object.c b/object.c
index cd73d41d87..e84447f229 100644
--- a/object.c
+++ b/object.c
@@ -161,7 +161,7 @@ void *object_as_type_the_repository(struct object *obj, enum object_type type, i
 		return obj;
 	else if (obj->type == OBJ_NONE) {
 		if (type == OBJ_COMMIT)
-			((struct commit *)obj)->index = alloc_commit_index();
+			((struct commit *)obj)->index = alloc_commit_index(the_repository);
 		obj->type = type;
 		return obj;
 	}
-- 
2.15.1.433.g936d1b9894.dirty

