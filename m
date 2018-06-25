Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6A9421F516
	for <e@80x24.org>; Mon, 25 Jun 2018 14:35:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934519AbeFYOfk (ORCPT <rfc822;e@80x24.org>);
        Mon, 25 Jun 2018 10:35:40 -0400
Received: from mail-qk0-f193.google.com ([209.85.220.193]:34103 "EHLO
        mail-qk0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934471AbeFYOf3 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Jun 2018 10:35:29 -0400
Received: by mail-qk0-f193.google.com with SMTP id b66-v6so2110427qkj.1
        for <git@vger.kernel.org>; Mon, 25 Jun 2018 07:35:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=HUc/brDgW5PjU6vv3AODST+3mcLnZVMqi7szNVHUun0=;
        b=vFYMipzY35HHdXdDxEEqjikAuDBpDYTQWuHXH28leQ13ztINn59mQb+p16QBPphdFr
         LmzYGNLY+O1tzxapbPIClgRuD3X8Pf4YAYYexBgG6GOw7yZHxYQX0ERbHExi+d5Nx2Vv
         11/RFpP2srXWxqZF36hSN1q62hTQ6KCVRwqvNESgM3NlGUsS5hx1HYNVpQ6gMtCZ4T92
         vKKXesBEOCuL7Bn9yR5NU1qFhlp4tkMc/+yvA8REPk/j3RhWx1+re8mQDS8QbUX7b31Y
         W3qAwNsOKgyl+e0lCua80qNOug7e90OsKtdZ2B42oczXh8o7luFDDJz5y9VFfCDobo9g
         QvSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=HUc/brDgW5PjU6vv3AODST+3mcLnZVMqi7szNVHUun0=;
        b=qUjs1V6L0D6T0vxxylVfrkO0FTuqRz7AtuImU82qpP0Z0lQfVW0WgUNt1iOHEZNrsp
         q2Nv4NjL1EGhPLKuSChgezBbS0DDnVHlr9eM1xas3fMcynjRl8S1nQPXyZ8HzDXoMLwq
         TOsOUdDda3OvTNcnSuj5WL71tqtQDWxGS/ovyz/7YdFWFHfnJfPw7PYGv3YFbUlKDuYF
         wOH9+2x2O/suefrsoXWdrxDVdcm+40MAzWH/cZKN7TY9z5f2HnFeuIle5OKUbIjnx4pv
         YAldyTVZIH0dZflrscUt5Nccv156qAxhVJ1xqCzKcw11XL4emreP8HK8CupSzeY3LEGD
         i9oA==
X-Gm-Message-State: APt69E0YDBJaLkl/bfxCzwgnXRojjPRP0psAlP2tIjyQw+RVseONJaPZ
        B/ZbjP20OtciBRvcWnQhqcaSFEfZ
X-Google-Smtp-Source: ADUXVKJ0+zwHbuRCbKjGxGx6atagMIGV4qOrga3oBv69Da3cP1kwiUjHh3dzLO7O7e/QdWAdpuFUJA==
X-Received: by 2002:a37:8c87:: with SMTP id o129-v6mr11124551qkd.0.1529937327577;
        Mon, 25 Jun 2018 07:35:27 -0700 (PDT)
Received: from stolee-linux-2.corp.microsoft.com ([2001:4898:8010:0:eb4a:5dff:fe0f:730f])
        by smtp.gmail.com with ESMTPSA id w46-v6sm12821713qtw.55.2018.06.25.07.35.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 25 Jun 2018 07:35:26 -0700 (PDT)
From:   Derrick Stolee <stolee@gmail.com>
X-Google-Original-From: Derrick Stolee <dstolee@microsoft.com>
To:     git@vger.kernel.org
Cc:     sbeller@google.com, pclouds@gmail.com, avarab@gmail.com,
        Derrick Stolee <dstolee@microsoft.com>
Subject: [PATCH v2 17/24] midx: prepare midxed_git struct
Date:   Mon, 25 Jun 2018 10:34:27 -0400
Message-Id: <20180625143434.89044-18-dstolee@microsoft.com>
X-Mailer: git-send-email 2.18.0.24.g1b579a2ee9
In-Reply-To: <20180625143434.89044-1-dstolee@microsoft.com>
References: <20180607140338.32440-1-dstolee@microsoft.com>
 <20180625143434.89044-1-dstolee@microsoft.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 midx.c         | 22 ++++++++++++++++++++++
 midx.h         |  3 +++
 object-store.h |  9 +++++++++
 packfile.c     |  6 +++++-
 4 files changed, 39 insertions(+), 1 deletion(-)

diff --git a/midx.c b/midx.c
index 71ca493107..3dd5027dc6 100644
--- a/midx.c
+++ b/midx.c
@@ -176,6 +176,28 @@ struct multi_pack_index *load_multi_pack_index(const char *object_dir)
 	return NULL;
 }
 
+int prepare_multi_pack_index_one(struct repository *r, const char *object_dir)
+{
+	struct multi_pack_index *m = r->objects->multi_pack_index;
+	struct multi_pack_index *m_search;
+
+	if (!core_multi_pack_index)
+		return 0;
+
+	for (m_search = m; m_search; m_search = m_search->next)
+		if (!strcmp(object_dir, m_search->object_dir))
+			return 1;
+
+	r->objects->multi_pack_index = load_multi_pack_index(object_dir);
+
+	if (r->objects->multi_pack_index) {
+		r->objects->multi_pack_index->next = m;
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
index 2d83dd9ec1..731ad6f094 100644
--- a/midx.h
+++ b/midx.h
@@ -1,9 +1,12 @@
 #ifndef __MIDX_H__
 #define __MIDX_H__
 
+#include "repository.h"
+
 struct multi_pack_index;
 
 struct multi_pack_index *load_multi_pack_index(const char *object_dir);
+int prepare_multi_pack_index_one(struct repository *r, const char *object_dir);
 
 int write_midx_file(const char *object_dir);
 
diff --git a/object-store.h b/object-store.h
index 07bcc80e02..7d67ad7aa9 100644
--- a/object-store.h
+++ b/object-store.h
@@ -85,6 +85,8 @@ struct packed_git {
 };
 
 struct multi_pack_index {
+	struct multi_pack_index *next;
+
 	int fd;
 
 	const unsigned char *data;
@@ -126,6 +128,13 @@ struct raw_object_store {
 	 */
 	struct oidmap *replace_map;
 
+	/*
+	 * private data
+	 *
+	 * should only be accessed directly by packfile.c and midx.c
+	 */
+	struct multi_pack_index *multi_pack_index;
+
 	/*
 	 * private data
 	 *
diff --git a/packfile.c b/packfile.c
index 39d6b66337..ff2df22a0b 100644
--- a/packfile.c
+++ b/packfile.c
@@ -15,6 +15,7 @@
 #include "tree-walk.h"
 #include "tree.h"
 #include "object-store.h"
+#include "midx.h"
 
 char *odb_pack_name(struct strbuf *buf,
 		    const unsigned char *sha1,
@@ -937,10 +938,13 @@ static void prepare_packed_git(struct repository *r)
 
 	if (r->objects->packed_git_initialized)
 		return;
+	prepare_multi_pack_index_one(r, r->objects->objectdir);
 	prepare_packed_git_one(r, r->objects->objectdir, 1);
 	prepare_alt_odb(r);
-	for (alt = r->objects->alt_odb_list; alt; alt = alt->next)
+	for (alt = r->objects->alt_odb_list; alt; alt = alt->next) {
+		prepare_multi_pack_index_one(r, alt->path);
 		prepare_packed_git_one(r, alt->path, 0);
+	}
 	rearrange_packed_git(r);
 	prepare_packed_git_mru(r);
 	r->objects->packed_git_initialized = 1;
-- 
2.18.0.24.g1b579a2ee9

