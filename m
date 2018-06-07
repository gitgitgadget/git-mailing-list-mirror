Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8999A1F403
	for <e@80x24.org>; Thu,  7 Jun 2018 14:04:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932870AbeFGOEG (ORCPT <rfc822;e@80x24.org>);
        Thu, 7 Jun 2018 10:04:06 -0400
Received: from mail-qk0-f175.google.com ([209.85.220.175]:33569 "EHLO
        mail-qk0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753220AbeFGOED (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Jun 2018 10:04:03 -0400
Received: by mail-qk0-f175.google.com with SMTP id h7-v6so6622245qkm.0
        for <git@vger.kernel.org>; Thu, 07 Jun 2018 07:04:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=KCo8+xm4VIHKeBudb0YY2IWtVQGpDBLBFwNtrh/AiG8=;
        b=iCoVx/qCDWx1r2ea6uUOWbSnZzCrl1BuEnz7VJeEJtGcBawqAUUN53yebnZbrtTTj6
         9JSvvZwa5huSyuxYij56ZRqTNL1L6x4YgJAxygg1k8nCcBkW4f9vWMrUAjUGSl4YNYCN
         v41MogJUGuELienR4xkiNwPuGE4N+lpZDfPbhh07Dp3Rz9S4Dbg9eCBpY3jsPZh7B/I1
         lMJbuXKOI8ooAUvZhlwRdbrT7l6FqgvPvL981fqP4Ed7UwvHtEQemkxfP8sV9qghGJQ/
         AKNMKYatW57wkAojbXC9+ES6CELvps9UAvQPYPL2q2Hsz99B3yYNfB9z60HEwghkUa5/
         /AuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=KCo8+xm4VIHKeBudb0YY2IWtVQGpDBLBFwNtrh/AiG8=;
        b=nOMCrKjjtY07cDjtOgoSKLj8KgTY3f0nqTLkjRb2mq2iWq6fFi7J5t2h0Miu7YZh29
         hKql7rN0K1fNZDtdyA3e8uxyeU6vOJcNFKfE0jCL+qKagatftgqNnjQh+sARZQXrcu9E
         4CYQVa475q6uhCrd2SgBHaUU5p6pXVrdZOyEO3tLCU9ufIg2yfWzhJMNRMJEm8YiAk8/
         u1/bF+Q0rawmGorEqzkgbd3Lg2XNsja8VXmC1v5UyjD5aO0jRvdWaLg02XnzHq67HqvS
         tQjSGI2a8pYysHXW6TN2zBy3dmmlxCr5sreknFtuYzERzcLqa0BcWDXYaihIaUSQnc17
         9dlQ==
X-Gm-Message-State: APt69E3nK1EX9taTa1GR2VtKGuHAhCdYEE4RaqcNK0vxM2LEXsHA9NnK
        cf/Ye5P+0/4snpXllxdEkHvmVSto
X-Google-Smtp-Source: ADUXVKIu1J4HR6aUR7NIdDwUdQbx5sPZiSwbDTEDow0IWedlHhnBbAAdiL1UWZ2L1I7qec3BQGYHAw==
X-Received: by 2002:ae9:c105:: with SMTP id z5-v6mr1569467qki.320.1528380242327;
        Thu, 07 Jun 2018 07:04:02 -0700 (PDT)
Received: from stolee-linux-2.corp.microsoft.com ([2001:4898:8010:0:eb4a:5dff:fe0f:730f])
        by smtp.gmail.com with ESMTPSA id u74-v6sm12532763qku.55.2018.06.07.07.04.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 07 Jun 2018 07:04:01 -0700 (PDT)
From:   Derrick Stolee <stolee@gmail.com>
X-Google-Original-From: Derrick Stolee <dstolee@microsoft.com>
To:     git@vger.kernel.org
Cc:     sbeller@google.com, dstolee@microsoft.com, avarab@gmail.com,
        jrnieder@gmail.com, jonathantanmy@google.com, mfick@codeaurora.org
Subject: [PATCH 16/23] midx: prepare midxed_git struct
Date:   Thu,  7 Jun 2018 10:03:31 -0400
Message-Id: <20180607140338.32440-17-dstolee@microsoft.com>
X-Mailer: git-send-email 2.18.0.rc1
In-Reply-To: <20180607140338.32440-1-dstolee@microsoft.com>
References: <20180607140338.32440-1-dstolee@microsoft.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 midx.c         | 22 ++++++++++++++++++++++
 midx.h         |  2 ++
 object-store.h |  7 +++++++
 packfile.c     |  6 +++++-
 4 files changed, 36 insertions(+), 1 deletion(-)

diff --git a/midx.c b/midx.c
index a49300bf75..5e9290ca8f 100644
--- a/midx.c
+++ b/midx.c
@@ -175,6 +175,28 @@ struct midxed_git *load_midxed_git(const char *object_dir)
 	exit(1);
 }
 
+int prepare_midxed_git_one(struct repository *r, const char *object_dir)
+{
+	struct midxed_git *m = r->objects->midxed_git;
+	struct midxed_git *m_search;
+
+	if (!core_midx)
+		return 0;
+
+	for (m_search = m; m_search; m_search = m_search->next)
+		if (!strcmp(object_dir, m_search->object_dir))
+			return 1;
+
+	r->objects->midxed_git = load_midxed_git(object_dir);
+
+	if (r->objects->midxed_git) {
+		r->objects->midxed_git->next = m;
+		return 1;
+	}
+
+	return 0;
+}
+
 static size_t write_midx_header(struct hashfile *f,
 				unsigned char num_chunks,
 				uint32_t num_packs)
diff --git a/midx.h b/midx.h
index a1d18ed991..793203fc4a 100644
--- a/midx.h
+++ b/midx.h
@@ -5,8 +5,10 @@
 #include "cache.h"
 #include "object-store.h"
 #include "packfile.h"
+#include "repository.h"
 
 struct midxed_git *load_midxed_git(const char *object_dir);
+int prepare_midxed_git_one(struct repository *r, const char *object_dir);
 
 int write_midx_file(const char *object_dir);
 
diff --git a/object-store.h b/object-store.h
index 9b671f1b0a..7908d46e34 100644
--- a/object-store.h
+++ b/object-store.h
@@ -130,6 +130,13 @@ struct raw_object_store {
 	 */
 	struct oidmap *replace_map;
 
+	/*
+	 * private data
+	 *
+	 * should only be accessed directly by packfile.c and midx.c
+	 */
+	struct midxed_git *midxed_git;
+
 	/*
 	 * private data
 	 *
diff --git a/packfile.c b/packfile.c
index 1a714fbde9..b91ca9b9f5 100644
--- a/packfile.c
+++ b/packfile.c
@@ -15,6 +15,7 @@
 #include "tree-walk.h"
 #include "tree.h"
 #include "object-store.h"
+#include "midx.h"
 
 char *odb_pack_name(struct strbuf *buf,
 		    const unsigned char *sha1,
@@ -893,10 +894,13 @@ static void prepare_packed_git(struct repository *r)
 
 	if (r->objects->packed_git_initialized)
 		return;
+	prepare_midxed_git_one(r, r->objects->objectdir);
 	prepare_packed_git_one(r, r->objects->objectdir, 1);
 	prepare_alt_odb(r);
-	for (alt = r->objects->alt_odb_list; alt; alt = alt->next)
+	for (alt = r->objects->alt_odb_list; alt; alt = alt->next) {
+		prepare_midxed_git_one(r, alt->path);
 		prepare_packed_git_one(r, alt->path, 0);
+	}
 	rearrange_packed_git(r);
 	prepare_packed_git_mru(r);
 	r->objects->packed_git_initialized = 1;
-- 
2.18.0.rc1

