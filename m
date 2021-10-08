Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8725C433F5
	for <git@archiver.kernel.org>; Fri,  8 Oct 2021 21:08:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A856160F9E
	for <git@archiver.kernel.org>; Fri,  8 Oct 2021 21:08:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243391AbhJHVK1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 8 Oct 2021 17:10:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243252AbhJHVKY (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 8 Oct 2021 17:10:24 -0400
Received: from mail-pg1-x54a.google.com (mail-pg1-x54a.google.com [IPv6:2607:f8b0:4864:20::54a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF3FCC061570
        for <git@vger.kernel.org>; Fri,  8 Oct 2021 14:08:28 -0700 (PDT)
Received: by mail-pg1-x54a.google.com with SMTP id 15-20020a630d4f000000b00287c5b3f77bso2257750pgn.11
        for <git@vger.kernel.org>; Fri, 08 Oct 2021 14:08:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=fu8w6CAhroCUMXcDEpc3UT4XMkPw+h1Y0PFI8YGUXWU=;
        b=FyhYRYek9pVerLdbVok/Mc7e/Yk4XMl2xkUqx2soT9cgp221+y3tAPwQi0YaCIKNwx
         c4l+DkH7akxcClV+hkI2VmPRsKGnF8WNpfzyC6foh8aez6E9mBMLndY8wOmrVgP+nHUz
         egOMP+tlqVx0b53Knv61AI1sRbtCvAYPPpcdT6AjRuz7GR8kieHVNLtF8Z9LJjtpyndy
         X8efLWmXo8b/IeFmDxgdHsQhRWJEvGqhu7g2vT9gvZpYYa0PAWXMeJCCKeSE8z4Juf4t
         k88a4ufFd5r+vFWHn1LPM5v8ccEiEEHSANAaCFSujTtOH8AjhJ+I+CxS1g+s8DsZLYUJ
         b5eA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=fu8w6CAhroCUMXcDEpc3UT4XMkPw+h1Y0PFI8YGUXWU=;
        b=L7XEsFWPmkAJxB4cr994++kcsGzGcAmR/AZgad2QMpwbK7eCxq7w4cUnbTjELPotbU
         7qYgGP0nrqazckjgH/zJF820m0LPlb57zbNLzK6EyNrvfDfiihNUqrm4tGoU5RCwok6R
         T2sh09sxj0In476LiGFW8xLwXrOi+h3duyAII2DCvFM8vkT8N0Jvlqoidm1KelOJSprL
         qL27SMga9QUaYJ47e+t3KN+2t8bJCpixf3M6DJ8waS8ImdlQBcBjJd47Bh6yqYjvy2ue
         JmcKCjvh3QRaQOGT9TmdIMHFC/rocudlClcM4LIVVBRCR9JVnLkOnFTM5Q0uv0z7WVIF
         VH6g==
X-Gm-Message-State: AOAM533pLrre03hezmpVXufR16ukJ7LwN493aHJcuFC6uKrJOzi4GVMZ
        MV41fhFhZ+9jcNCtHmxaWTCowOl9fBJ4LUu+sAWnCS5JqV1ZHLnq3Kz6K9UiituwbJSPVMph8AA
        zCDU0//6xkygxetBsZm21LWoYkQIsTEDdWefw3M6k246e8q6DdF2DBem2LvAXzBh7gjnbnbissk
        vz
X-Google-Smtp-Source: ABdhPJyLbR1KrhHyGGCkDi9Os3QTvL7UDS09I//LwKB3dGikT8F3VVeIwyCo476wFQ2vE57/5ephqnlequn+IRhf1nXX
X-Received: from twelve4.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:437a])
 (user=jonathantanmy job=sendgmr) by 2002:a17:902:654d:b0:13e:a097:208e with
 SMTP id d13-20020a170902654d00b0013ea097208emr11575763pln.31.1633727308195;
 Fri, 08 Oct 2021 14:08:28 -0700 (PDT)
Date:   Fri,  8 Oct 2021 14:08:15 -0700
In-Reply-To: <cover.1633727270.git.jonathantanmy@google.com>
Message-Id: <64182569199f89642051fd7b5a2e756d0e082ff7.1633727270.git.jonathantanmy@google.com>
Mime-Version: 1.0
References: <cover.1632242495.git.jonathantanmy@google.com> <cover.1633727270.git.jonathantanmy@google.com>
X-Mailer: git-send-email 2.33.0.882.g93a45727a2-goog
Subject: [PATCH v4 2/7] refs: teach arbitrary repo support to iterators
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>, carenas@gmail.com,
        chooglen@google.com, steadmon@google.com,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Note that should_pack_ref() is called when writing refs, which is only
supported for the_repository, hence the_repository is hardcoded there.

Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
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
2.33.0.882.g93a45727a2-goog

