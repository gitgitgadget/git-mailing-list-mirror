Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC12DC433F5
	for <git@archiver.kernel.org>; Wed, 29 Sep 2021 23:06:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 93A256124F
	for <git@archiver.kernel.org>; Wed, 29 Sep 2021 23:06:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347464AbhI2XIP (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 29 Sep 2021 19:08:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347454AbhI2XIO (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 29 Sep 2021 19:08:14 -0400
Received: from mail-pf1-x449.google.com (mail-pf1-x449.google.com [IPv6:2607:f8b0:4864:20::449])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBA09C06161C
        for <git@vger.kernel.org>; Wed, 29 Sep 2021 16:06:32 -0700 (PDT)
Received: by mail-pf1-x449.google.com with SMTP id j12-20020aa783cc000000b0044b702424b7so2611744pfn.6
        for <git@vger.kernel.org>; Wed, 29 Sep 2021 16:06:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=J5IF8WHEpUl0KHMxcFONFF9km0BkxA8oJECpMW1QgKo=;
        b=kKgMyqEa8k1ZCGbHXE5nFXgBcdQTfus5op8XNKded6902ahV2DXB54jdt2T2BVyCeG
         dBshaGss/5od3x666WhoJ69J7agoopH4g9LZ2PK4Zmrarvt5l85LSPIA+9NX+cdiN0SE
         WLUq9Y1xcdyCy+P1Wv+20iWGBwRkRB1mU0xXR7DBW5Qcg2GzBS6+jGhxR0L7u15n0u4W
         KXGC/uOCfqnOx4hLzFyziqMcSmLnH6SolD4+IUu9eVHvJH7/B8wu4Vh87sVMuA8WrYLc
         dxEAN3yskfGaHuProZ54S5yXXQnnPUeEvN+6KOcHNlsPrfYDGZlbFZQ47ErCJs/AF+KH
         6rYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=J5IF8WHEpUl0KHMxcFONFF9km0BkxA8oJECpMW1QgKo=;
        b=BBQb6ByxPmFyoCLlHCOSw0R9YQQz4ktf3Lts+QtRG0cYn5dMZ5tpCmX+Yg/QRoBL2Q
         543nBUQAh8pjXQgUMZoRT+qn+VS6MZctfoWcwYEnd3RnW9MpvJdCOhYqO4PCRrUUn+5s
         8qZBWRGTvhF2NMZwbA8Gw6M6MrLVNeAZH3a7vJ0o1/wZfcmzuZfVfg6WF1O1wtcLqn0l
         jegI+CUa0xL/uGXfJN1/t8v9BaGjireunvnnKGBSlxLDAHO6+migclbyn7xNHvZOw2Vp
         BvabM2kDlkK90q9TVyEFEbR7iQO03/7/+J89Np1niV2+cCgxqHGDOfB0pKrDmDujxgp2
         dLIg==
X-Gm-Message-State: AOAM531HMmyxB38nyJhJ4CHCBu1A5ib/k3dbyuKCUCTZfX/MJKbZ1j+R
        dwb4uehi6vk0u2DuCfNBbB53VY0FWzCZXAVPpEaos0yRGIzdrawmwm7XwNE+uZhM0EEL+zjSS7D
        23UfOTUUxaEGkCmPIttzWkUjnQ6AjokOb5P1h5xOFxcjian3nzBaYUN7jAxtlRlTEDToCimcp3+
        HK
X-Google-Smtp-Source: ABdhPJzJX+fpLPGfAAsx+EtzQ7+Md1W+60AfTGg0uQRVnbhnYMWtEHiOrs7O/BzOrt3MjyZpWTdL1ca0C6w6glY+vePl
X-Received: from twelve4.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:437a])
 (user=jonathantanmy job=sendgmr) by 2002:a05:6a00:ac6:b029:374:a33b:a74 with
 SMTP id c6-20020a056a000ac6b0290374a33b0a74mr2291614pfl.51.1632956792091;
 Wed, 29 Sep 2021 16:06:32 -0700 (PDT)
Date:   Wed, 29 Sep 2021 16:06:19 -0700
In-Reply-To: <cover.1632956589.git.jonathantanmy@google.com>
Message-Id: <e7fb60b7e7d73ecaee9867172fb919f4c877be38.1632956589.git.jonathantanmy@google.com>
Mime-Version: 1.0
References: <cover.1632242495.git.jonathantanmy@google.com> <cover.1632956589.git.jonathantanmy@google.com>
X-Mailer: git-send-email 2.33.0.685.g46640cef36-goog
Subject: [PATCH v3 3/7] refs: peeling non-the_repository iterators is BUG
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

There is currently no support for peeling the current ref of an iterator
iterating over a non-the_repository ref store, and none is needed. Thus,
for now, BUG() if that happens.

Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
---
 refs/files-backend.c  |  5 +++--
 refs/packed-backend.c |  3 +++
 refs/ref-cache.c      | 10 ++++++++++
 refs/ref-cache.h      |  1 +
 4 files changed, 17 insertions(+), 2 deletions(-)

diff --git a/refs/files-backend.c b/refs/files-backend.c
index 3f213d24b0..8ee6ac2103 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -833,7 +833,7 @@ static struct ref_iterator *files_ref_iterator_begin(
 	 */
 
 	loose_iter = cache_ref_iterator_begin(get_loose_ref_cache(refs),
-					      prefix, 1);
+					      prefix, ref_store->repo, 1);
 
 	/*
 	 * The packed-refs file might contain broken references, for
@@ -1165,7 +1165,8 @@ static int files_pack_refs(struct ref_store *ref_store, unsigned int flags)
 
 	packed_refs_lock(refs->packed_ref_store, LOCK_DIE_ON_ERROR, &err);
 
-	iter = cache_ref_iterator_begin(get_loose_ref_cache(refs), NULL, 0);
+	iter = cache_ref_iterator_begin(get_loose_ref_cache(refs), NULL,
+					the_repository, 0);
 	while ((ok = ref_iterator_advance(iter)) == ITER_OK) {
 		/*
 		 * If the loose reference can be packed, add an entry
diff --git a/refs/packed-backend.c b/refs/packed-backend.c
index 63f78bbaea..2161218719 100644
--- a/refs/packed-backend.c
+++ b/refs/packed-backend.c
@@ -886,6 +886,9 @@ static int packed_ref_iterator_peel(struct ref_iterator *ref_iterator,
 	struct packed_ref_iterator *iter =
 		(struct packed_ref_iterator *)ref_iterator;
 
+	if (iter->repo != the_repository)
+		BUG("peeling for non-the_repository is not supported");
+
 	if ((iter->base.flags & REF_KNOWS_PEELED)) {
 		oidcpy(peeled, &iter->peeled);
 		return is_null_oid(&iter->peeled) ? -1 : 0;
diff --git a/refs/ref-cache.c b/refs/ref-cache.c
index 49d732f6db..97a6ac349e 100644
--- a/refs/ref-cache.c
+++ b/refs/ref-cache.c
@@ -435,6 +435,8 @@ struct cache_ref_iterator {
 	 * on from there.)
 	 */
 	struct cache_ref_iterator_level *levels;
+
+	struct repository *repo;
 };
 
 static int cache_ref_iterator_advance(struct ref_iterator *ref_iterator)
@@ -491,6 +493,11 @@ static int cache_ref_iterator_advance(struct ref_iterator *ref_iterator)
 static int cache_ref_iterator_peel(struct ref_iterator *ref_iterator,
 				   struct object_id *peeled)
 {
+	struct cache_ref_iterator *iter =
+		(struct cache_ref_iterator *)ref_iterator;
+
+	if (iter->repo != the_repository)
+		BUG("peeling for non-the_repository is not supported");
 	return peel_object(ref_iterator->oid, peeled) ? -1 : 0;
 }
 
@@ -513,6 +520,7 @@ static struct ref_iterator_vtable cache_ref_iterator_vtable = {
 
 struct ref_iterator *cache_ref_iterator_begin(struct ref_cache *cache,
 					      const char *prefix,
+					      struct repository *repo,
 					      int prime_dir)
 {
 	struct ref_dir *dir;
@@ -547,5 +555,7 @@ struct ref_iterator *cache_ref_iterator_begin(struct ref_cache *cache,
 		level->prefix_state = PREFIX_CONTAINS_DIR;
 	}
 
+	iter->repo = repo;
+
 	return ref_iterator;
 }
diff --git a/refs/ref-cache.h b/refs/ref-cache.h
index 3bfb89d2b3..7877bf86ed 100644
--- a/refs/ref-cache.h
+++ b/refs/ref-cache.h
@@ -238,6 +238,7 @@ struct ref_entry *find_ref_entry(struct ref_dir *dir, const char *refname);
  */
 struct ref_iterator *cache_ref_iterator_begin(struct ref_cache *cache,
 					      const char *prefix,
+					      struct repository *repo,
 					      int prime_dir);
 
 #endif /* REFS_REF_CACHE_H */
-- 
2.33.0.685.g46640cef36-goog

