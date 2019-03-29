Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.7 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E03FF20248
	for <e@80x24.org>; Fri, 29 Mar 2019 21:39:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730112AbfC2Vjg (ORCPT <rfc822;e@80x24.org>);
        Fri, 29 Mar 2019 17:39:36 -0400
Received: from mail-qt1-f201.google.com ([209.85.160.201]:48599 "EHLO
        mail-qt1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729771AbfC2Vjf (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 29 Mar 2019 17:39:35 -0400
Received: by mail-qt1-f201.google.com with SMTP id 54so3652326qtn.15
        for <git@vger.kernel.org>; Fri, 29 Mar 2019 14:39:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=UGaeHy2mebNCfWClC4a9txQDeOlf69FpZRBVczCrEp4=;
        b=HEm9SdGOTesAX7F7UPKUwxQ1LZ3G9fEex60BmECs1LPUNLVi0Eoj6VDYfB2RdEO/e5
         ahOtQh5LEIy7Fsdq5nMEIdnUltfvc+jEtD/mOQwToWRONjZolc7ckS7HPaH4033Zovhe
         jyjw+d+jPtSHnvJOejuXPoCF6JafeAMKRSQwSdIcUpA3PbBGX4b7Ig+NfJTTm/Exf0Vz
         duA8X14yYxluhCdAFQ79kduToMYXLT62Y+3MlOEeOkv4MoXDIaecPO1I8bG22t703zWA
         0xsn5XDH43mnSgA/E002KyMctDkk0sF0PEfYrCYX77lPcQKuU9REGEFZkMiORjTHTR7W
         Rkdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=UGaeHy2mebNCfWClC4a9txQDeOlf69FpZRBVczCrEp4=;
        b=R0oj7OHDBZW2uzOBlE3ibjO3kV4lArw4lf8mEqTh/pkyexo6jL7pXEuwDeQTh1LeiJ
         iAsPIJ6ujEmyMjjHQiTTuu23SpqLD0281CMGx5P6u6qOEW1wWgK4k0sunmgdvPB0ReE/
         UCBu7krDNGOe82ktiD64KvQw0MmwCgMvE2Urd5t3MoWzByXM+LMCxyR4drRQ/ie/JC5U
         gMuTZcB8z+Wwtpry35crldchf5Wh6YtchuMKZmFYrML9J0XZT5wZMY59eRzfLwdMJTFw
         q/Qmc1MxgCnhPsrwsGsq6gMCFsPGgEFhPDb4DwNH1JKmYlfsruP3o7zN5ydXX27r7N73
         Zu7A==
X-Gm-Message-State: APjAAAWQvLohWtP7q/vwb2imIzoBVaHjwgqf1KRhm6D/NvPFiwlzi0ks
        94F5MXY5reP2b3PxruJRyJLUYow+Ovn25gWlWjih3fxMYj1yCYYT+wlCj1aGD3AxGeEC5y3e3yN
        /OygnU6Q6RVm4T/klRwUkKRh9MSEexv4CwSAVyZQeBNCZgF3VRoIAYj8Q6FXehKslNa32+uCUua
        ic
X-Google-Smtp-Source: APXvYqxbETs3NOuk88dwtQsX1S+qBRQxI5c3A6lmfjsPGXwfwbQKAowy4JIE7cwjEWBNiCHvWUR6OXPNCbHt7GKWiiCa
X-Received: by 2002:a37:a48d:: with SMTP id n135mr3987611qke.6.1553895574794;
 Fri, 29 Mar 2019 14:39:34 -0700 (PDT)
Date:   Fri, 29 Mar 2019 14:39:27 -0700
In-Reply-To: <cover.1553895166.git.jonathantanmy@google.com>
Message-Id: <068861632b85179d2a5a5ceb966e951a78b27141.1553895166.git.jonathantanmy@google.com>
Mime-Version: 1.0
References: <20190326220906.111879-1-jonathantanmy@google.com> <cover.1553895166.git.jonathantanmy@google.com>
X-Mailer: git-send-email 2.21.0.197.gd478713db0
Subject: [PATCH v2 1/2] sha1-file: support OBJECT_INFO_FOR_PREFETCH
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>, peff@peff.net,
        Johannes.Schindelin@gmx.de, szeder.dev@gmail.com
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Teach oid_object_info_extended() to support a new flag that inhibits
fetching of missing objects. This is equivalent to setting
fetch_is_missing to 0, calling oid_object_info_extended(), then setting
fetch_if_missing to whatever it was before. Update unpack-trees.c to use
this new flag instead of repeatedly setting fetch_if_missing.

This new flag complicates things slightly in that there are now 2 ways
to do the same thing. But this eliminates the need to repeatedly set a
global variable, and more importantly, allows prefetching to be done in
parallel (in the future); hence, this patch.

Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
---
 object-store.h |  6 ++++++
 sha1-file.c    |  3 ++-
 unpack-trees.c | 17 +++++++++--------
 3 files changed, 17 insertions(+), 9 deletions(-)

diff --git a/object-store.h b/object-store.h
index 14fc935bd1..dd3f9b75f0 100644
--- a/object-store.h
+++ b/object-store.h
@@ -280,6 +280,12 @@ struct object_info {
 #define OBJECT_INFO_QUICK 8
 /* Do not check loose object */
 #define OBJECT_INFO_IGNORE_LOOSE 16
+/*
+ * Do not attempt to fetch the object if missing (even if fetch_is_missing is
+ * nonzero). This is meant for bulk prefetching of missing blobs in a partial
+ * clone. Implies OBJECT_INFO_QUICK.
+ */
+#define OBJECT_INFO_FOR_PREFETCH (32 + OBJECT_INFO_QUICK)
 
 int oid_object_info_extended(struct repository *r,
 			     const struct object_id *,
diff --git a/sha1-file.c b/sha1-file.c
index 494606f771..ad02649124 100644
--- a/sha1-file.c
+++ b/sha1-file.c
@@ -1370,7 +1370,8 @@ int oid_object_info_extended(struct repository *r, const struct object_id *oid,
 
 		/* Check if it is a missing object */
 		if (fetch_if_missing && repository_format_partial_clone &&
-		    !already_retried && r == the_repository) {
+		    !already_retried && r == the_repository &&
+		    !(flags & OBJECT_INFO_FOR_PREFETCH)) {
 			/*
 			 * TODO Investigate having fetch_object() return
 			 * TODO error/success and stopping the music here.
diff --git a/unpack-trees.c b/unpack-trees.c
index 22c41a3ba8..381b0cd65e 100644
--- a/unpack-trees.c
+++ b/unpack-trees.c
@@ -404,20 +404,21 @@ static int check_updates(struct unpack_trees_options *o)
 		 * below.
 		 */
 		struct oid_array to_fetch = OID_ARRAY_INIT;
-		int fetch_if_missing_store = fetch_if_missing;
-		fetch_if_missing = 0;
 		for (i = 0; i < index->cache_nr; i++) {
 			struct cache_entry *ce = index->cache[i];
-			if ((ce->ce_flags & CE_UPDATE) &&
-			    !S_ISGITLINK(ce->ce_mode)) {
-				if (!has_object_file(&ce->oid))
-					oid_array_append(&to_fetch, &ce->oid);
-			}
+
+			if (!(ce->ce_flags & CE_UPDATE) ||
+			    S_ISGITLINK(ce->ce_mode))
+				continue;
+			if (!oid_object_info_extended(the_repository, &ce->oid,
+						      NULL,
+						      OBJECT_INFO_FOR_PREFETCH))
+				continue;
+			oid_array_append(&to_fetch, &ce->oid);
 		}
 		if (to_fetch.nr)
 			fetch_objects(repository_format_partial_clone,
 				      to_fetch.oid, to_fetch.nr);
-		fetch_if_missing = fetch_if_missing_store;
 		oid_array_clear(&to_fetch);
 	}
 	for (i = 0; i < index->cache_nr; i++) {
-- 
2.21.0.197.gd478713db0

