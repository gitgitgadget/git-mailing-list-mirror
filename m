Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7099C433EF
	for <git@archiver.kernel.org>; Tue, 28 Sep 2021 20:11:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B6557611C3
	for <git@archiver.kernel.org>; Tue, 28 Sep 2021 20:11:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242623AbhI1UMs (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 28 Sep 2021 16:12:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242618AbhI1UMq (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Sep 2021 16:12:46 -0400
Received: from mail-pf1-x449.google.com (mail-pf1-x449.google.com [IPv6:2607:f8b0:4864:20::449])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2295EC06161C
        for <git@vger.kernel.org>; Tue, 28 Sep 2021 13:11:07 -0700 (PDT)
Received: by mail-pf1-x449.google.com with SMTP id j12-20020aa783cc000000b0044b702424b7so8380277pfn.6
        for <git@vger.kernel.org>; Tue, 28 Sep 2021 13:11:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=aGoXUhGWjtwWe92po6Rtl/aLT+nNtXai3nLWXr/8a+c=;
        b=VDijicMIFJsRzjEAWDGxMs+sHKoFhOK0Pa+ZEtVnsKtZJ4KEdtMbM1kQaoaY7blWeI
         QS7Q5i5kwRpdAgROCdLfj7/29vsxVRv0Et6DaxhK+Weilp7P7g5SjeBNR4Wb/48ERv0p
         wn2YLcWfawf3l5Ay83D7jHPuhoj6Ji8CI+t0SlMPn1HqUp6EpsFZvaRbGZZL838am0Ty
         +YZM2J2yAkgsofn5OBu+HfxsbUWFNILKXCa9H3X3R3lVMWI208XpMHoSOO7kok87bAdZ
         Far1v6eO4zb6VtMUhBWr+WkYFdIZW/QoyH4/Rx8FsXtmOV9gyfd1dDTuHdYQSobe0cEa
         xSUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=aGoXUhGWjtwWe92po6Rtl/aLT+nNtXai3nLWXr/8a+c=;
        b=CX1P4dZ0UY0CbNemSp33jYAq+qUr9kj5S7goao/jOSzY08/04+fLmBRO28UtWIigoy
         SlHV0UNnpvbD0fxEUdqiIG4hSEQ5+OcjyjQaVp/UIUYWgewES4hy/yElRys2XFOJ3Sg2
         w7KCUQNx+aDntnNacAAYe+aMAQdbjbWQES9QLjRSQhI8QOX96DHu8OUgVq/abjJ0bXe+
         AcRDAkFHm6r/wwpSFKLcAz0tD+ni/JKRUieRfoTtldpt//vvUc6FpZ6dX6/x2Q9vPUhr
         DSFBi2iiG7igG1+JEpQds0BaIe3QbPOdiIZuN0QNTyVcBegisDHPlJ4VNeCOkGABwn68
         TZxQ==
X-Gm-Message-State: AOAM530qx3LQtoQtLd2hsz6RpHTHKhThKqR0FP30oWvtV/m4K1TL+Y+o
        I3j4OpmRxQtlbobZlguNvW0ZoVXGRWl4kFLDz0ZsebHQ3f2o/SbQpPBu8AnDpgS+U7G2Ej8p0MK
        JqI4GlURZLd1OPOtiRYb9gLrkA2sUMYAg7C/SMlda5LkU4a1R3TE+JfXa56xtTTj+cNHl5Qpc1E
        Gn
X-Google-Smtp-Source: ABdhPJxyY1IuEBwjLMXproM3kD6D8tpG5aJ3SUD56WJGvMcORHvyRinM0MhAKygemqyjA26wAgw2F2hw86I3JSglPdWn
X-Received: from twelve4.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:437a])
 (user=jonathantanmy job=sendgmr) by 2002:a17:90a:2a4b:: with SMTP id
 d11mr1936981pjg.172.1632859866436; Tue, 28 Sep 2021 13:11:06 -0700 (PDT)
Date:   Tue, 28 Sep 2021 13:10:48 -0700
In-Reply-To: <cover.1632859147.git.jonathantanmy@google.com>
Message-Id: <ec153eff7b0d5ca3188ec6f43bc40c38609f6a80.1632859148.git.jonathantanmy@google.com>
Mime-Version: 1.0
References: <cover.1632242495.git.jonathantanmy@google.com> <cover.1632859147.git.jonathantanmy@google.com>
X-Mailer: git-send-email 2.33.0.685.g46640cef36-goog
Subject: [PATCH v2 2/9] refs: teach arbitrary repo support to iterators
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>, peff@peff.net,
        newren@gmail.com
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
index 6f7b3447a7..5163e064ae 100644
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
index f0cbea41c9..4d883d9a89 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -730,6 +730,7 @@ struct files_ref_iterator {
 	struct ref_iterator base;
 
 	struct ref_iterator *iter0;
+	struct repository *repo;
 	unsigned int flags;
 };
 
@@ -751,6 +752,7 @@ static int files_ref_iterator_advance(struct ref_iterator *ref_iterator)
 
 		if (!(iter->flags & DO_FOR_EACH_INCLUDE_BROKEN) &&
 		    !ref_resolves_to_object(iter->iter0->refname,
+					    iter->repo,
 					    iter->iter0->oid,
 					    iter->iter0->flags))
 			continue;
@@ -854,6 +856,7 @@ static struct ref_iterator *files_ref_iterator_begin(
 	base_ref_iterator_init(ref_iterator, &files_ref_iterator_vtable,
 			       overlay_iter->ordered);
 	iter->iter0 = overlay_iter;
+	iter->repo = repo;
 	iter->flags = flags;
 
 	return ref_iterator;
@@ -1138,7 +1141,7 @@ static int should_pack_ref(const char *refname,
 		return 0;
 
 	/* Do not pack broken refs: */
-	if (!ref_resolves_to_object(refname, oid, ref_flags))
+	if (!ref_resolves_to_object(refname, the_repository, oid, ref_flags))
 		return 0;
 
 	return 1;
diff --git a/refs/packed-backend.c b/refs/packed-backend.c
index 94fb1042a2..55c8bd3081 100644
--- a/refs/packed-backend.c
+++ b/refs/packed-backend.c
@@ -776,6 +776,7 @@ struct packed_ref_iterator {
 	struct object_id oid, peeled;
 	struct strbuf refname_buf;
 
+	struct repository *repo;
 	unsigned int flags;
 };
 
@@ -864,8 +865,8 @@ static int packed_ref_iterator_advance(struct ref_iterator *ref_iterator)
 			continue;
 
 		if (!(iter->flags & DO_FOR_EACH_INCLUDE_BROKEN) &&
-		    !ref_resolves_to_object(iter->base.refname, &iter->oid,
-					    iter->flags))
+		    !ref_resolves_to_object(iter->base.refname, iter->repo,
+					    &iter->oid, iter->flags))
 			continue;
 
 		return ITER_OK;
@@ -954,6 +955,7 @@ static struct ref_iterator *packed_ref_iterator_begin(
 
 	iter->base.oid = &iter->oid;
 
+	iter->repo = repo;
 	iter->flags = flags;
 
 	if (prefix && *prefix)
diff --git a/refs/refs-internal.h b/refs/refs-internal.h
index 9440be51da..e7b0a0a658 100644
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

