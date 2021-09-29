Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8302C433EF
	for <git@archiver.kernel.org>; Wed, 29 Sep 2021 23:06:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C0DF76124F
	for <git@archiver.kernel.org>; Wed, 29 Sep 2021 23:06:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347452AbhI2XIO (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 29 Sep 2021 19:08:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347451AbhI2XIN (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 29 Sep 2021 19:08:13 -0400
Received: from mail-qk1-x74a.google.com (mail-qk1-x74a.google.com [IPv6:2607:f8b0:4864:20::74a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89F7FC061768
        for <git@vger.kernel.org>; Wed, 29 Sep 2021 16:06:31 -0700 (PDT)
Received: by mail-qk1-x74a.google.com with SMTP id bk9-20020a05620a1a0900b0045df00f93a9so11524631qkb.1
        for <git@vger.kernel.org>; Wed, 29 Sep 2021 16:06:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=oNARsxwunxm3i0BV/G3hhCHTVLNTDB7s8a3U4sjdq2E=;
        b=efIPC6DBKa/CjHqV6B9xrtRXCrv6qzsmnbZUQJQJ4ZGzBjCwkkRFRK3VygFtcKy8tb
         vabCILWTuCCDWqibG4GXQImSX/w58ZKnHB3NlqW649FwsIRSOA0OFwcZcLtrJC9f1x0j
         S9AknmB5dDflAAMbgNTo/JdEQuHKdnv6OloqZvAC9hwgUA0JANUFt4blKZdSBGt72jyo
         Vp+uUPmOWYxD1nUStTiCEVQpHhqn4L4aE0Ff1vbCijOVxJQppT9livvzYITSWfj5pKjv
         hxSTO4TgefGc2LmR7myloAKmOItopTN4Nux7Mp2/2oICyJcvvf7NquIgG+elXtp5BlK7
         wfTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=oNARsxwunxm3i0BV/G3hhCHTVLNTDB7s8a3U4sjdq2E=;
        b=kYJga8ZTvqOFOUtPVL6Ink2w9Q6LCNZAnhORB/B6G/oEL0eXgGk1htJUtUEsU6ijF8
         P3d1uo+7Ge/YfOqHTEBkEp8YEFX11LWYbTNsJZjBK+r+UjUtlRJ4ZaAedTpHzkXdpaMD
         Pp97TnzqwjpByvVnr8wer9WM/xr4cUYo+ssqThxls+pADMKaKqK2r+eCRPm+t5YiLFLL
         1KOdgUZRqq8yvU4c3q1emkYFvYDr7mswcJ8tBU+U9YWNo6x+u0k2k+IiLl/AnBh4C0MY
         Er19xt/zDEQ5/dR/4AF3KiohFDFG/ye108JSyBdRpUI9UqKRiwVOTk66fiZE5n01+5EC
         Yt9A==
X-Gm-Message-State: AOAM530jbLC3PczdjNC4Rqu7g919pP60asphTWHHXrXpQliAxg8N6DGR
        3p6FFONlrASMak1eWfVGO3dump3Yl9qb5kvWGggCucBPFB7Im1VYjdZ5B2QoXPEVQqLRpvZcEe7
        S+6QaPhkZ0f/TF4tkq2LDb57pvlNnPWN6ILFoqVYzSKKXamrHoRVOYBx7dyrVdxuEXbVrDuY457
        uF
X-Google-Smtp-Source: ABdhPJx9GAjGsdJHLHhcY2brKOjOh/R6mHKoWjA2fys5IEBVR7i0yKCLvHwXwA6n8Q8NziBO+fDg4hP/Hd58EgYnai/L
X-Received: from twelve4.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:437a])
 (user=jonathantanmy job=sendgmr) by 2002:a05:6214:554:: with SMTP id
 ci20mr978508qvb.24.1632956790711; Wed, 29 Sep 2021 16:06:30 -0700 (PDT)
Date:   Wed, 29 Sep 2021 16:06:18 -0700
In-Reply-To: <cover.1632956589.git.jonathantanmy@google.com>
Message-Id: <c8799d408f2a3b4421db14d756540f287e17b3d1.1632956589.git.jonathantanmy@google.com>
Mime-Version: 1.0
References: <cover.1632242495.git.jonathantanmy@google.com> <cover.1632956589.git.jonathantanmy@google.com>
X-Mailer: git-send-email 2.33.0.685.g46640cef36-goog
Subject: [PATCH v3 2/7] refs: teach arbitrary repo support to iterators
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Note that should_pack_ref() is called when writing refs, which is only
supported for the_repository, hence the_repository is hardcoded there.

Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
---
 refs.c                | 3 ++-
 refs/files-backend.c  | 5 ++++-
 refs/packed-backend.c | 6 ++++--
 refs/refs-internal.h  | 1 +
 4 files changed, 11 insertions(+), 4 deletions(-)

diff --git a/refs.c b/refs.c
index 9c4e388153..c07aeff6f4 100644
--- a/refs.c
+++ b/refs.c
@@ -255,12 +255,13 @@ int refname_is_safe(const char *refname)
  * does not exist, emit a warning and return false.
  */
 int ref_resolves_to_object(const char *refname,
+			   struct repository *repo,
 			   const struct object_id *oid,
 			   unsigned int flags)
 {
 	if (flags & REF_ISBROKEN)
 		return 0;
-	if (!has_object_file(oid)) {
+	if (!repo_has_object_file(repo, oid)) {
 		error(_("%s does not point to a valid object!"), refname);
 		return 0;
 	}
diff --git a/refs/files-backend.c b/refs/files-backend.c
index 6a481e968f..3f213d24b0 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -732,6 +732,7 @@ struct files_ref_iterator {
 	struct ref_iterator base;
 
 	struct ref_iterator *iter0;
+	struct repository *repo;
 	unsigned int flags;
 };
 
@@ -753,6 +754,7 @@ static int files_ref_iterator_advance(struct ref_iterator *ref_iterator)
 
 		if (!(iter->flags & DO_FOR_EACH_INCLUDE_BROKEN) &&
 		    !ref_resolves_to_object(iter->iter0->refname,
+					    iter->repo,
 					    iter->iter0->oid,
 					    iter->iter0->flags))
 			continue;
@@ -855,6 +857,7 @@ static struct ref_iterator *files_ref_iterator_begin(
 	base_ref_iterator_init(ref_iterator, &files_ref_iterator_vtable,
 			       overlay_iter->ordered);
 	iter->iter0 = overlay_iter;
+	iter->repo = ref_store->repo;
 	iter->flags = flags;
 
 	return ref_iterator;
@@ -1139,7 +1142,7 @@ static int should_pack_ref(const char *refname,
 		return 0;
 
 	/* Do not pack broken refs: */
-	if (!ref_resolves_to_object(refname, oid, ref_flags))
+	if (!ref_resolves_to_object(refname, the_repository, oid, ref_flags))
 		return 0;
 
 	return 1;
diff --git a/refs/packed-backend.c b/refs/packed-backend.c
index ea3493b24e..63f78bbaea 100644
--- a/refs/packed-backend.c
+++ b/refs/packed-backend.c
@@ -778,6 +778,7 @@ struct packed_ref_iterator {
 	struct object_id oid, peeled;
 	struct strbuf refname_buf;
 
+	struct repository *repo;
 	unsigned int flags;
 };
 
@@ -866,8 +867,8 @@ static int packed_ref_iterator_advance(struct ref_iterator *ref_iterator)
 			continue;
 
 		if (!(iter->flags & DO_FOR_EACH_INCLUDE_BROKEN) &&
-		    !ref_resolves_to_object(iter->base.refname, &iter->oid,
-					    iter->flags))
+		    !ref_resolves_to_object(iter->base.refname, iter->repo,
+					    &iter->oid, iter->flags))
 			continue;
 
 		return ITER_OK;
@@ -956,6 +957,7 @@ static struct ref_iterator *packed_ref_iterator_begin(
 
 	iter->base.oid = &iter->oid;
 
+	iter->repo = ref_store->repo;
 	iter->flags = flags;
 
 	if (prefix && *prefix)
diff --git a/refs/refs-internal.h b/refs/refs-internal.h
index d28440c9cc..500d77864d 100644
--- a/refs/refs-internal.h
+++ b/refs/refs-internal.h
@@ -66,6 +66,7 @@ int refname_is_safe(const char *refname);
  * referred-to object does not exist, emit a warning and return false.
  */
 int ref_resolves_to_object(const char *refname,
+			   struct repository *repo,
 			   const struct object_id *oid,
 			   unsigned int flags);
 
-- 
2.33.0.685.g46640cef36-goog

