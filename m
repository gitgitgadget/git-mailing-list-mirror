Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEB38C433EF
	for <git@archiver.kernel.org>; Tue, 28 Sep 2021 20:11:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 978CE611BD
	for <git@archiver.kernel.org>; Tue, 28 Sep 2021 20:11:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242616AbhI1UMq (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 28 Sep 2021 16:12:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242568AbhI1UMp (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Sep 2021 16:12:45 -0400
Received: from mail-qt1-x84a.google.com (mail-qt1-x84a.google.com [IPv6:2607:f8b0:4864:20::84a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2ACB5C06161C
        for <git@vger.kernel.org>; Tue, 28 Sep 2021 13:11:06 -0700 (PDT)
Received: by mail-qt1-x84a.google.com with SMTP id 61-20020aed2143000000b002a6a0f52ce7so295314qtc.0
        for <git@vger.kernel.org>; Tue, 28 Sep 2021 13:11:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=+RUX9pV133In8vfTVdole7ux6JBRSaJseZcig1ALGJ8=;
        b=pQA7ePOPRuLr3+Zeg3u+KOBApu+cIiKtWhbEITkVOxYmleRgelWgTId2FSMkyp7o6J
         RDgkCNtKqeHo2ItlAz34v/DdlyDomsTnsqCgCLoqjgpuyGvfbQpzuNDiXKzCV/kP9MeA
         O0F6797Pbky497OKq0aM1SzX+i7RPczIoMeza2fvwsCzdyXpVp+zXhkUZuGBL7c97gtX
         fJKeyyogw6kzaNobOjUhyPxBivJOQWhGLzQ277K/fbpkKQrhXXxeeJEZV+dZlyW/svtr
         qhIta7C20aA/an4/l5hGzMx2+TvmKytjpaz6dmcFF25HmcLjsQejMOswjONwgcXVBxSu
         Zk6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=+RUX9pV133In8vfTVdole7ux6JBRSaJseZcig1ALGJ8=;
        b=LtyRoj6lYLOx1Bev9KpLclyeIW8FTYzAetO3ey1l5ZtOrwBruv/2YEuGuZRlm+9+Sf
         6RmmLxnlHZdKw6Xa9B1dn3ETJ2Km02wiasjSDzA8acTmNzbr/wLTgDMQgMEBbnBnSyZi
         PYA3yeQ+p2cEMLws57JMBgltI0v9VQ/lzqg2wRJYng6pTjGsgqCrNBlUKwDxPqoxkUYe
         dhuAbJMTwnsHDNl95EuDr5ONBTYb6OZsVC5L7VpM3SGsDs8jEemTtRgn2HqrOyQvD8a0
         nXzLsmuZex8njue6Rc7Bkag2AnmfJyv4SUcocxsVvHXCdF2Bx51dyVANGxJuC9voBplm
         P2aQ==
X-Gm-Message-State: AOAM530SH8+zIWAcClXIIDI8HBafoKUb6TBpFUGISEQuMtPbHZEgzItJ
        F1dqyelA8uet7VjdO74wbsYzNW8UAuop/gteb6PV5oBTtqM9WllSfz/UGAGOCLHIFpq2Dntsf7J
        RCFie0pUjF2uyHg40FFtn2k88Nk5wDrTv/qfpvbqxiQ/6Dzyx21DkBaxJ7FZLjEp+2jQjoSjOhb
        yu
X-Google-Smtp-Source: ABdhPJx4FNY+F0oE7Ts1/9vu/zlpu1ylTu6fiVhHUuQMv4JJ66TDGpnnb8kxGBnhvuW514sTJ3hS8lVjQWxAAJsLT/QK
X-Received: from twelve4.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:437a])
 (user=jonathantanmy job=sendgmr) by 2002:a05:6214:6aa:: with SMTP id
 s10mr7481235qvz.56.1632859864865; Tue, 28 Sep 2021 13:11:04 -0700 (PDT)
Date:   Tue, 28 Sep 2021 13:10:47 -0700
In-Reply-To: <cover.1632859147.git.jonathantanmy@google.com>
Message-Id: <e364b13a3772da761fc8a4d1ab574cdbdfbc8aa0.1632859148.git.jonathantanmy@google.com>
Mime-Version: 1.0
References: <cover.1632242495.git.jonathantanmy@google.com> <cover.1632859147.git.jonathantanmy@google.com>
X-Mailer: git-send-email 2.33.0.685.g46640cef36-goog
Subject: [PATCH v2 1/9] refs: plumb repo param in begin-iterator functions
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>, peff@peff.net,
        newren@gmail.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In preparation for the next 2 patches that adds (partial) support for
arbitrary repositories, plumb a repository parameter in all functions
that create iterators. There are no changes to program logic.

Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
---
 refs.c                | 9 +++++----
 refs/debug.c          | 4 ++--
 refs/files-backend.c  | 3 ++-
 refs/packed-backend.c | 8 +++++++-
 refs/refs-internal.h  | 3 ++-
 5 files changed, 18 insertions(+), 9 deletions(-)

diff --git a/refs.c b/refs.c
index 2be0d0f057..6f7b3447a7 100644
--- a/refs.c
+++ b/refs.c
@@ -1414,6 +1414,7 @@ int head_ref(each_ref_fn fn, void *cb_data)
 struct ref_iterator *refs_ref_iterator_begin(
 		struct ref_store *refs,
 		const char *prefix, int trim,
+		struct repository *repo,
 		enum do_for_each_ref_flags flags)
 {
 	struct ref_iterator *iter;
@@ -1429,7 +1430,7 @@ struct ref_iterator *refs_ref_iterator_begin(
 		}
 	}
 
-	iter = refs->be->iterator_begin(refs, prefix, flags);
+	iter = refs->be->iterator_begin(refs, prefix, repo, flags);
 
 	/*
 	 * `iterator_begin()` already takes care of prefix, but we
@@ -1464,7 +1465,7 @@ static int do_for_each_repo_ref(struct repository *r, const char *prefix,
 	if (!refs)
 		return 0;
 
-	iter = refs_ref_iterator_begin(refs, prefix, trim, flags);
+	iter = refs_ref_iterator_begin(refs, prefix, trim, r, flags);
 
 	return do_for_each_repo_ref_iterator(r, iter, fn, cb_data);
 }
@@ -1495,7 +1496,7 @@ static int do_for_each_ref(struct ref_store *refs, const char *prefix,
 	if (!refs)
 		return 0;
 
-	iter = refs_ref_iterator_begin(refs, prefix, trim, flags);
+	iter = refs_ref_iterator_begin(refs, prefix, trim, the_repository, flags);
 
 	return do_for_each_repo_ref_iterator(the_repository, iter,
 					do_for_each_ref_helper, &hp);
@@ -2260,7 +2261,7 @@ int refs_verify_refname_available(struct ref_store *refs,
 	strbuf_addstr(&dirname, refname + dirname.len);
 	strbuf_addch(&dirname, '/');
 
-	iter = refs_ref_iterator_begin(refs, dirname.buf, 0,
+	iter = refs_ref_iterator_begin(refs, dirname.buf, 0, the_repository,
 				       DO_FOR_EACH_INCLUDE_BROKEN);
 	while ((ok = ref_iterator_advance(iter)) == ITER_OK) {
 		if (skip &&
diff --git a/refs/debug.c b/refs/debug.c
index 1a7a9e11cf..753d5da893 100644
--- a/refs/debug.c
+++ b/refs/debug.c
@@ -224,11 +224,11 @@ static struct ref_iterator_vtable debug_ref_iterator_vtable = {
 
 static struct ref_iterator *
 debug_ref_iterator_begin(struct ref_store *ref_store, const char *prefix,
-			 unsigned int flags)
+			 struct repository *repo, unsigned int flags)
 {
 	struct debug_ref_store *drefs = (struct debug_ref_store *)ref_store;
 	struct ref_iterator *res =
-		drefs->refs->be->iterator_begin(drefs->refs, prefix, flags);
+		drefs->refs->be->iterator_begin(drefs->refs, prefix, repo, flags);
 	struct debug_ref_iterator *diter = xcalloc(1, sizeof(*diter));
 	base_ref_iterator_init(&diter->base, &debug_ref_iterator_vtable, 1);
 	diter->iter = res;
diff --git a/refs/files-backend.c b/refs/files-backend.c
index 1148c0cf09..f0cbea41c9 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -798,7 +798,7 @@ static struct ref_iterator_vtable files_ref_iterator_vtable = {
 
 static struct ref_iterator *files_ref_iterator_begin(
 		struct ref_store *ref_store,
-		const char *prefix, unsigned int flags)
+		const char *prefix, struct repository *repo, unsigned int flags)
 {
 	struct files_ref_store *refs;
 	struct ref_iterator *loose_iter, *packed_iter, *overlay_iter;
@@ -844,6 +844,7 @@ static struct ref_iterator *files_ref_iterator_begin(
 	 */
 	packed_iter = refs_ref_iterator_begin(
 			refs->packed_ref_store, prefix, 0,
+			repo,
 			DO_FOR_EACH_INCLUDE_BROKEN);
 
 	overlay_iter = overlay_ref_iterator_begin(loose_iter, packed_iter);
diff --git a/refs/packed-backend.c b/refs/packed-backend.c
index f8aa97d799..94fb1042a2 100644
--- a/refs/packed-backend.c
+++ b/refs/packed-backend.c
@@ -913,7 +913,7 @@ static struct ref_iterator_vtable packed_ref_iterator_vtable = {
 
 static struct ref_iterator *packed_ref_iterator_begin(
 		struct ref_store *ref_store,
-		const char *prefix, unsigned int flags)
+		const char *prefix, struct repository *repo, unsigned int flags)
 {
 	struct packed_ref_store *refs;
 	struct snapshot *snapshot;
@@ -1135,8 +1135,14 @@ static int write_with_updates(struct packed_ref_store *refs,
 	 * of the lists each time through the loop. When the current
 	 * list of refs is exhausted, set iter to NULL. When the list
 	 * of updates is exhausted, leave i set to updates->nr.
+	 *
+	 * Note that the repository does not matter since
+	 * DO_FOR_EACH_INCLUDE_BROKEN means that we do not access any objects,
+	 * but the_repository here makes the most sense because we only support
+	 * writing refs to the main repository.
 	 */
 	iter = packed_ref_iterator_begin(&refs->base, "",
+					 the_repository,
 					 DO_FOR_EACH_INCLUDE_BROKEN);
 	if ((ok = ref_iterator_advance(iter)) != ITER_OK)
 		iter = NULL;
diff --git a/refs/refs-internal.h b/refs/refs-internal.h
index 96911fb26e..9440be51da 100644
--- a/refs/refs-internal.h
+++ b/refs/refs-internal.h
@@ -382,6 +382,7 @@ int is_empty_ref_iterator(struct ref_iterator *ref_iterator);
 struct ref_iterator *refs_ref_iterator_begin(
 		struct ref_store *refs,
 		const char *prefix, int trim,
+		struct repository *repo,
 		enum do_for_each_ref_flags flags);
 
 /*
@@ -583,7 +584,7 @@ typedef int copy_ref_fn(struct ref_store *ref_store,
  */
 typedef struct ref_iterator *ref_iterator_begin_fn(
 		struct ref_store *ref_store,
-		const char *prefix, unsigned int flags);
+		const char *prefix, struct repository *repo, unsigned int flags);
 
 /* reflog functions */
 
-- 
2.33.0.685.g46640cef36-goog

