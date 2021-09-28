Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2786C433F5
	for <git@archiver.kernel.org>; Tue, 28 Sep 2021 20:11:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B3CFC611C3
	for <git@archiver.kernel.org>; Tue, 28 Sep 2021 20:11:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242618AbhI1UMw (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 28 Sep 2021 16:12:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242625AbhI1UMs (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Sep 2021 16:12:48 -0400
Received: from mail-pf1-x44a.google.com (mail-pf1-x44a.google.com [IPv6:2607:f8b0:4864:20::44a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D823C061745
        for <git@vger.kernel.org>; Tue, 28 Sep 2021 13:11:09 -0700 (PDT)
Received: by mail-pf1-x44a.google.com with SMTP id z24-20020aa79f98000000b004463f2f0277so15260963pfr.23
        for <git@vger.kernel.org>; Tue, 28 Sep 2021 13:11:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=4ooikbujL/FbFPkGOXKemlcmwuOOciQiq1oPUQ7+nZs=;
        b=sXeFk8474+M7NQEgK+p3+SjP+b9w5F4oqnoMygPxFjVQvqnCiEtO/iniUar7dyqfp0
         Jc7YdQl0VwKvLfaKlYAKjWxBFa4xLfJBb2BYGAjbTKBdYLyR9hCCMLQYI+SQMybK/V9q
         UbvlZGs1CjxmL8xREBR+Sei9/qPWEs3cXf+NSD1hc6oh7G/xOlKh7LxwaeBIGwWx060M
         lnXCO+DjfD/19x/mYU/wIh/ieiEzdksCvdz5RpnDvGGbx/jnUJKwClEanJydrr1U7GWp
         0iL/ccB+vqPwhvSICY8Sac3Of4zurA9hFdQ1H6Kzhk4Zcs2GZ10rTHBfkUzf5wWjlCC9
         5MWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=4ooikbujL/FbFPkGOXKemlcmwuOOciQiq1oPUQ7+nZs=;
        b=VNC+ocCnTv1MF6dbeKdiXmnBT9CF13TP3MyMQ+7a2ngE6lG93xdnN8tV1khWcRHybz
         VROGwjTMmQmLMlT+LVoeA8PDHKsKbG9YDPuF5uuPQQYh/TC7NjPoJvwmw7ivC1VWPoEV
         9HAWVOEa+GEt51uBfKmX324DXlTy5O5nXeaD+KV/VAq8vnvH+5hfk1xdfsZnlzh/PKkJ
         ouYKgoqWx8mXN2M5SHPl6dnEbiJhyPosd0kJzfJzdmoExCiNb/P2guO9KRi5DGNwh1Jz
         wN4myic+9MEHojl3IAvaRAAEGdd3zldjz2SFnGlUQqkfcyUD3T3lmc49pFFwI5XmVgnh
         8Bww==
X-Gm-Message-State: AOAM53071UMcNkeZuikWd/HdmkuYRnn/3Gh2jIkHyHxFBDjFHaQnYj1M
        4OtcgsIo4SfAGUcIFN4xLqRYjSHLOwIu1wiPoUfslelSj8Sew1mVWgFQwYWWbgQXzcOgVAzXRuw
        5Cj6iPzbedLEdNjr3C9vPHflB/iqUAdyHHFhPIwHawgYyk9HhncjtKXqQcuiRufUjNg+fW+0VvN
        VM
X-Google-Smtp-Source: ABdhPJwSbL2jzljH9HUauqcze+VFviI2e7goaRqXRHKFueeOb600KMMDS4l7Zh2yGqw1gxqVlSpsPJKvmEoiGzlSSbaS
X-Received: from twelve4.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:437a])
 (user=jonathantanmy job=sendgmr) by 2002:aa7:9816:0:b0:447:bdf9:eac2 with
 SMTP id e22-20020aa79816000000b00447bdf9eac2mr7420409pfl.31.1632859868258;
 Tue, 28 Sep 2021 13:11:08 -0700 (PDT)
Date:   Tue, 28 Sep 2021 13:10:49 -0700
In-Reply-To: <cover.1632859147.git.jonathantanmy@google.com>
Message-Id: <dd1a8871f42f76bb7a29e18d811028ad17325c31.1632859148.git.jonathantanmy@google.com>
Mime-Version: 1.0
References: <cover.1632242495.git.jonathantanmy@google.com> <cover.1632859147.git.jonathantanmy@google.com>
X-Mailer: git-send-email 2.33.0.685.g46640cef36-goog
Subject: [PATCH v2 3/9] refs: peeling non-the_repository iterators is BUG
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>, peff@peff.net,
        newren@gmail.com
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
index 4d883d9a89..3289beb03e 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -831,7 +831,7 @@ static struct ref_iterator *files_ref_iterator_begin(
 	 */
 
 	loose_iter = cache_ref_iterator_begin(get_loose_ref_cache(refs),
-					      prefix, 1);
+					      prefix, repo, 1);
 
 	/*
 	 * The packed-refs file might contain broken references, for
@@ -1164,7 +1164,8 @@ static int files_pack_refs(struct ref_store *ref_store, unsigned int flags)
 
 	packed_refs_lock(refs->packed_ref_store, LOCK_DIE_ON_ERROR, &err);
 
-	iter = cache_ref_iterator_begin(get_loose_ref_cache(refs), NULL, 0);
+	iter = cache_ref_iterator_begin(get_loose_ref_cache(refs), NULL,
+					the_repository, 0);
 	while ((ok = ref_iterator_advance(iter)) == ITER_OK) {
 		/*
 		 * If the loose reference can be packed, add an entry
diff --git a/refs/packed-backend.c b/refs/packed-backend.c
index 55c8bd3081..e2f57a013e 100644
--- a/refs/packed-backend.c
+++ b/refs/packed-backend.c
@@ -884,6 +884,9 @@ static int packed_ref_iterator_peel(struct ref_iterator *ref_iterator,
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

