Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DFE0D1FADF
	for <e@80x24.org>; Tue,  1 May 2018 21:34:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751229AbeEAVeV (ORCPT <rfc822;e@80x24.org>);
        Tue, 1 May 2018 17:34:21 -0400
Received: from mail-pf0-f195.google.com ([209.85.192.195]:36768 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751175AbeEAVeS (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 May 2018 17:34:18 -0400
Received: by mail-pf0-f195.google.com with SMTP id w129so4547338pfd.3
        for <git@vger.kernel.org>; Tue, 01 May 2018 14:34:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=LyJiZpHLptnnpAkVbOO6xcnoi5abmiof7/C1PeHoDz8=;
        b=obTWnWxYFf47wFZPPfjJsraZfRjmpprj0fOsUDIAAxdx/kUJIqVAyYzukgpi+4uUQ9
         0S+PqIvuFNcuRoBAvRikMxpkDZYC7qhH/DlwnDYBcqNvtf96a/KYS8SHkkgnnYmsVyfo
         sOPJOlIsvG1zvvIhv/kVUAgnUgtpNUIIoWGxkLLPCHcZAL8AKjyxviz816DI0pcrhZ8X
         kiTE80jWGyd178T7lproQhpNT/ikhl8r0ghiYZrTT00zcFsTl6KpE0Ud0iW2YBCimNe1
         tvCIkIoe8UyM2Oxhscmi79AEug8LT+8h9f370hL09pgUtAimCOqeDjwQB4mnWEZhT+9H
         2uKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=LyJiZpHLptnnpAkVbOO6xcnoi5abmiof7/C1PeHoDz8=;
        b=GiEHtpiDXwYXqPdKw1ZrXTaeyIAKsr07getRnm/zQ4phLuN44UkibRkM1g8QbmnxYw
         jvI88hzsW3Pitm8qQiwnztuSn7q/wk79BM4O4mMGxMAiryI4y8MPX5uPt90UEohD/XUY
         N2M5PHMYhAo1o1NJNn2wXF2Vq5WWoX0IZ3x2EqXhsrYBZzpSICoqHEi8aO6uGE7D6wcd
         RS+vLWX1Y/OgN+pu73VxkvcgC7WXKx6Q17Td8O9BQeZCXN7GHCmUKvq51cVHHlQgVbpQ
         meb6ThJALfp9Y1Vu2PkNLa3heWrMsY1UrbUqyRKk2dUfsTW9Kgg9fKQ//qZ95iTzYS7y
         ZWvQ==
X-Gm-Message-State: ALQs6tBIkSu8j6/5hPgk87VppkVjTpbubgUixreQNol9qgd048/Hvzwa
        sZv9bJAHxAgBWIS3jJnuzMoaOwUmdQs=
X-Google-Smtp-Source: AB8JxZoHWxdxjzXE417dSJYoP7VmY3zGugQEkDYq9lP2CqZR76nVUSku4vkMB9HQXZgf0Sq3aWRNCQ==
X-Received: by 2002:a17:902:7c94:: with SMTP id y20-v6mr17817313pll.56.1525210457826;
        Tue, 01 May 2018 14:34:17 -0700 (PDT)
Received: from localhost ([2620:0:100e:422:ea58:fa52:fa77:9b41])
        by smtp.gmail.com with ESMTPSA id v23sm18298569pfe.166.2018.05.01.14.34.17
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 01 May 2018 14:34:17 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     git@vger.kernel.org
Cc:     jamill@microsoft.com, Stefan Beller <sbeller@google.com>
Subject: [PATCH 07/13] alloc: add repository argument to alloc_tag_node
Date:   Tue,  1 May 2018 14:33:57 -0700
Message-Id: <20180501213403.14643-8-sbeller@google.com>
X-Mailer: git-send-email 2.17.0.441.gb46fe60e1d-goog
In-Reply-To: <20180501213403.14643-1-sbeller@google.com>
References: <20180501213403.14643-1-sbeller@google.com>
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
index 9e2b897ec1d..290250e3595 100644
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
index bf6e8c87d83..32f340cde59 100644
--- a/cache.h
+++ b/cache.h
@@ -1770,7 +1770,8 @@ extern void *alloc_blob_node_the_repository(void);
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
index 7150b759d66..02ef4eaafc0 100644
--- a/tag.c
+++ b/tag.c
@@ -94,7 +94,7 @@ struct tag *lookup_tag(const struct object_id *oid)
 	struct object *obj = lookup_object(oid->hash);
 	if (!obj)
 		return create_object(the_repository, oid->hash,
-				     alloc_tag_node());
+				     alloc_tag_node(the_repository));
 	return object_as_type(obj, OBJ_TAG, 0);
 }
 
-- 
2.17.0.441.gb46fe60e1d-goog

