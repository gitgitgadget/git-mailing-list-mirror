Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A10B6C433EF
	for <git@archiver.kernel.org>; Fri,  8 Oct 2021 21:08:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8600060F9E
	for <git@archiver.kernel.org>; Fri,  8 Oct 2021 21:08:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243394AbhJHVK2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 8 Oct 2021 17:10:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243387AbhJHVKZ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 8 Oct 2021 17:10:25 -0400
Received: from mail-pg1-x549.google.com (mail-pg1-x549.google.com [IPv6:2607:f8b0:4864:20::549])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49052C061570
        for <git@vger.kernel.org>; Fri,  8 Oct 2021 14:08:30 -0700 (PDT)
Received: by mail-pg1-x549.google.com with SMTP id c2-20020a63d5020000b029023ae853b72cso2243766pgg.18
        for <git@vger.kernel.org>; Fri, 08 Oct 2021 14:08:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=Ok1Nf2VKN1RPSMBn6FVTM8yVEK3rvC5LKnZeXent7sE=;
        b=EdVfjl+4e2jq+gMWH+62dPvl+lK30Wv4o1vzHIkhPadU1yh8UP21bemeLeFQZuSXKD
         ihfD4Ozt58LFmfXgybysNrQLKe9t0BoKZiKXPc1+wnUiLwaecQpHjBcDEX2Mh6l+MhZy
         P2FX/zhjNYHQPyd+y+nWLIpaqi6kwQgukQTTZtXztk0+o/I2Cr3Gkc919zP7DauPwCsx
         Oe3FmGEairM72bUWq/8b/4B2xfMPwV46RN9g00/PbHCF+Ee4NY6tRiPPCibJ36G8WCzj
         Lr0ZSoDsfSTPpuh8iMRoRoNZioL+QwK6jtbckk+HSLOuFbxFeeyAw/5LS5vF7AC/j16x
         j8Lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=Ok1Nf2VKN1RPSMBn6FVTM8yVEK3rvC5LKnZeXent7sE=;
        b=gCpGgJYo0ik6LF6sl5K6UaTLciqy34uoFWX8DxGwrueDA14TNhue1dPU6mAU6f3Vd5
         XvOhf9IKFJGrsQsVtt7rDZelFvyPjeV5kE7YjZN+tXASelxBTHKz6Pr3vk0Iyh2tBIYA
         YkBcwrRtKTWX3xsJp003lhuspp1L8DGGWYd6P1mu9ZF4DG9NoXzr3nDbiLwDVA8gKbmn
         3hZNBIwnEbrG4TUfn+f2S2gtsxGNIK8lQl2z+qrMTtx8ymS6rNQ31TrYM8jJXY87Ihzp
         vbQtxbHr9b0z6cOpC6CX0P18XW6mtmXgBK6l7MjG4S6ETy9DlMBl+hsiKvLRSHDwWJkv
         jxEg==
X-Gm-Message-State: AOAM531F7Y1I4Z0Z+Y1ahW/GeOsNv2Tbs/goc/Ak8YHLmeKuc9mwB0Ni
        dfdMjRZfCWbWrNDtd7UFkgYWeSZDN2S32IDCvwFBDS0pMmQc9F73fPFfKV1oKh45LAKJNaTyYBw
        qrX933XgsbLQuiK6Ll5gjrS3pa2hL47d/GSLCC3iIgJeqnjPUxDisniWbc+nM8D1KKbn0H6JaXR
        rw
X-Google-Smtp-Source: ABdhPJwG0dUNkeXSnGHK7VcNdggtc/c79QGOmXNhgDQ82exBbvI/UdPRlOxxMRFl4/+E01R7x3VjsyyghiATPZj2hMe2
X-Received: from twelve4.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:437a])
 (user=jonathantanmy job=sendgmr) by 2002:a17:902:708b:b0:13e:1a20:f1b0 with
 SMTP id z11-20020a170902708b00b0013e1a20f1b0mr11497221plk.51.1633727309707;
 Fri, 08 Oct 2021 14:08:29 -0700 (PDT)
Date:   Fri,  8 Oct 2021 14:08:16 -0700
In-Reply-To: <cover.1633727270.git.jonathantanmy@google.com>
Message-Id: <d624c198d6e33c9da7701758d17a678fdecf5b1c.1633727270.git.jonathantanmy@google.com>
Mime-Version: 1.0
References: <cover.1632242495.git.jonathantanmy@google.com> <cover.1633727270.git.jonathantanmy@google.com>
X-Mailer: git-send-email 2.33.0.882.g93a45727a2-goog
Subject: [PATCH v4 3/7] refs: peeling non-the_repository iterators is BUG
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>, carenas@gmail.com,
        chooglen@google.com, steadmon@google.com,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

There is currently no support for peeling the current ref of an iterator
iterating over a non-the_repository ref store, and none is needed. Thus,
for now, BUG() if that happens.

Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
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
2.33.0.882.g93a45727a2-goog

