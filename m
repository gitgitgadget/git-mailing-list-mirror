Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B3F5F1FADF
	for <e@80x24.org>; Tue,  1 May 2018 21:34:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751287AbeEAVe0 (ORCPT <rfc822;e@80x24.org>);
        Tue, 1 May 2018 17:34:26 -0400
Received: from mail-pg0-f68.google.com ([74.125.83.68]:46124 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750755AbeEAVeX (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 May 2018 17:34:23 -0400
Received: by mail-pg0-f68.google.com with SMTP id z4-v6so9080399pgu.13
        for <git@vger.kernel.org>; Tue, 01 May 2018 14:34:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=CCHQ69Qswgnw1Z084RraOLyvFFiV2CRWRGhp4THpPp0=;
        b=D9LlP378NJ5pH86gzOiNSMUlQR+hImzstAdDJ9rE1IRfqhUK6vTvFg4LpMeNHcryF1
         mNMtCPPk6JFcMGz8X5xsFNiVuR2IOTRcOmBD0h4rAkk+YdTYyLkDtoH4FJS3QwCr4dK2
         wRwsEDiMTZXfEccDMyCkcpDkzGwJz5j+/GMgxVSG9ZCmBNBAgm66yYEUSFPIyPnTZw9Q
         8RaaxpsX7gvktOWaW8nE7yeEYLVuhf9qxiZfcME/6Kfd+TYi1Gy71IbQCAh4KT4xGRgT
         djo4yWV5ShGU7P7UBadLZ8/SFEQB4YQsljeIh8Gsq/IteIV/+8yvxMTO/YzlMDMGDUkk
         p+fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=CCHQ69Qswgnw1Z084RraOLyvFFiV2CRWRGhp4THpPp0=;
        b=cbQXxIGmcS0m1ALYmrsEo3uaQTku3hQ77daRINdOJTab20I7AaqWDlYRw85ME9Zzg8
         xtKvTr0L5dxnHdV/GgxQHQmN4f2mXPjolxmOCP7fcb7sV98tw9dTl8Zl5wbpfVc2a/Fj
         llmL+AwBsda+H6qpNRGG3LbfReKbc+i8sdJTvELR2Lw3yvoTZSfcPJ3eTMjxGxIwDLwd
         vuUf1LzPtwWJkhKMNr7rIFc1Fuf1c11sfy+54ilbG7yS6lq8IYC3M6YsUcAYhf8ThqJ3
         VunevJof1XXn9HS8wuLQRQSpcFZD6IRgkRsnbvqog7T5l6lyrVDEnPIu1MlsjWi+7Ykg
         gFrA==
X-Gm-Message-State: ALQs6tCMn98bP8KItiTK5Hru3XbwI4V0XAEtahZiv53Xvjq5Rj/t6ycA
        AAQRFuoc2yFKhhNorPH7LyGKsr6uWvs=
X-Google-Smtp-Source: AB8JxZrrlcYi2+Px74ysgshWmW7FgNQ3ycMJx7eJxwSjIS1V5yUBSCK0IFrm8DglNIXLFEE22bkQ4g==
X-Received: by 2002:a63:8f16:: with SMTP id n22-v6mr13732936pgd.394.1525210462229;
        Tue, 01 May 2018 14:34:22 -0700 (PDT)
Received: from localhost ([2620:0:100e:422:ea58:fa52:fa77:9b41])
        by smtp.gmail.com with ESMTPSA id k84sm11763455pfh.93.2018.05.01.14.34.21
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 01 May 2018 14:34:21 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     git@vger.kernel.org
Cc:     jamill@microsoft.com, Stefan Beller <sbeller@google.com>
Subject: [PATCH 10/13] alloc: add repository argument to alloc_commit_index
Date:   Tue,  1 May 2018 14:34:00 -0700
Message-Id: <20180501213403.14643-11-sbeller@google.com>
X-Mailer: git-send-email 2.17.0.441.gb46fe60e1d-goog
In-Reply-To: <20180501213403.14643-1-sbeller@google.com>
References: <20180501213403.14643-1-sbeller@google.com>
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
index 28b85b22144..277dadd221b 100644
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
index 01cc207d218..0e6c5dd5639 100644
--- a/cache.h
+++ b/cache.h
@@ -1776,7 +1776,8 @@ extern void *alloc_tag_node_the_repository(void);
 extern void *alloc_object_node_the_repository(void);
 #define alloc_report(r) alloc_report_##r()
 extern void alloc_report_the_repository(void);
-extern unsigned int alloc_commit_index(void);
+#define alloc_commit_index(r) alloc_commit_index_##r()
+extern unsigned int alloc_commit_index_the_repository(void);
 
 /* pkt-line.c */
 void packet_trace_identity(const char *prog);
diff --git a/object.c b/object.c
index 7d36323445b..ddf4b7b196e 100644
--- a/object.c
+++ b/object.c
@@ -162,7 +162,7 @@ void *object_as_type(struct object *obj, enum object_type type, int quiet)
 		return obj;
 	else if (obj->type == OBJ_NONE) {
 		if (type == OBJ_COMMIT)
-			((struct commit *)obj)->index = alloc_commit_index();
+			((struct commit *)obj)->index = alloc_commit_index(the_repository);
 		obj->type = type;
 		return obj;
 	}
-- 
2.17.0.441.gb46fe60e1d-goog

