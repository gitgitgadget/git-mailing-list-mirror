Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-26.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A94DC432BE
	for <git@archiver.kernel.org>; Wed, 25 Aug 2021 23:23:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D800A610C7
	for <git@archiver.kernel.org>; Wed, 25 Aug 2021 23:23:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233583AbhHYXYb (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 25 Aug 2021 19:24:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233577AbhHYXY2 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 25 Aug 2021 19:24:28 -0400
Received: from mail-qv1-xf4a.google.com (mail-qv1-xf4a.google.com [IPv6:2607:f8b0:4864:20::f4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23637C061757
        for <git@vger.kernel.org>; Wed, 25 Aug 2021 16:23:42 -0700 (PDT)
Received: by mail-qv1-xf4a.google.com with SMTP id n14-20020a0c9d4e0000b0290354a5f8c800so1082787qvf.17
        for <git@vger.kernel.org>; Wed, 25 Aug 2021 16:23:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=PBZtc4qU2+YG4WwZoeOjaFOGr7BOZZc2AQZ28FoVr9U=;
        b=Ka+ZSDmkH+7wD8Hyogeyd4u0B9F8r5RHgVqbQSdtfMTsOTJ5kIMZm4WIHeRdq6q/bQ
         GNnl5o+E33Z5A+ivfLSKAYLMhclXrTArMZ0fz7WWovhmMfLcNpmMN6ajXwjKLtCaBF1r
         jNlVN5RFYVQ4qFLSz/YCpAU/7bpnNf2hJJYjQRfcxDPkINNgi5dAjcPTPHF+KRFajRUU
         SvsgvwZE8cuMxYcw5pH56V3rTZv7JS/isqBaeIt2s6WxDUnpI18XQVip4ECup1mdE1TR
         AyweHjfRqv34jFLgmfdZKiSnZJfSATDDWPudfCCMAyu88F9VtDnmNuVCuNPjcsCmT9jI
         3fSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=PBZtc4qU2+YG4WwZoeOjaFOGr7BOZZc2AQZ28FoVr9U=;
        b=XqFEQCJgZR1reTuIzffMvjS9xnH1hQku0Hcw9gIHW3yHQfQuQhQgOx1xvJfCsBmkUV
         VD+n1L5tk8mLopFVBVD5/rlDp9nJlSlpJA4DrMycfKJXQk/IZEae9SPVQIDfW77C6X4P
         O54TSDpHSDGwmJi/rpAKA+OLZoSgD5g6tHXdzAeySKd+IiExaFaEK2ysntDYp3Bg5Aps
         2EJAtUtJ8hQsJYHo5l8qnu58Mf/yNQnd+wo7WTY2I7phfQnbuG3L4UBFGJh6NYetORsF
         fmRw0WOGndoLHi56tQ8/6DVEDCsTff527ceR7Tve8klFWLg0uV2AqVU7lShVMvKoMyy/
         ZVWg==
X-Gm-Message-State: AOAM532MHLAFlYBz+HMq/edgNSBt6AubaMAIhrOWK6SzjvMJi/wbtKfp
        fBAbwjf6878OxxBBu1kX4j61zUG53EZJEpi9furqwNDW/fcMt2MuYODkt0lvxIJ6K32N8X+JFif
        lMThVgL7dSBcitQqYX7EDt0NJGUGqpL/nLmkjpSFKeXuqrWCIiSlESy4xASUuwvsZQcsItNkdVm
        5n
X-Google-Smtp-Source: ABdhPJzyCRu9g2TP9rTZZdUBjtEI6M4i6R1f1s5UDy0C/05ttPWB/itZGLhuAnGJJy28vInXSi/rLRcUD9cSTaguZv+X
X-Received: from twelve4.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:437a])
 (user=jonathantanmy job=sendgmr) by 2002:ad4:55eb:: with SMTP id
 bu11mr1190749qvb.57.1629933821190; Wed, 25 Aug 2021 16:23:41 -0700 (PDT)
Date:   Wed, 25 Aug 2021 16:23:31 -0700
In-Reply-To: <cover.1629933380.git.jonathantanmy@google.com>
Message-Id: <2e93cc60e959d18909405a1d22c650228bf2fcb9.1629933380.git.jonathantanmy@google.com>
Mime-Version: 1.0
References: <cover.1629933380.git.jonathantanmy@google.com>
X-Mailer: git-send-email 2.33.0.rc2.250.ged5fa647cd-goog
Subject: [RFC PATCH 2/2] refs: add repo paramater to _iterator_peel()
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>, hanwen@google.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Split the ref_iterator_peel() function into two functions: one that
returns information solely based on what the ref store contains
(success, failure, inconclusive), and one that takes a repo parameter
and accesses the object store if need be. Update the ref store's
callbacks to not access the object store, and to return
success/failure/inconclusive instead of a binary success/failure.

This makes it explicit whether a peel attempt may access the object
store of a repository.

The approach taken in this commit for peeling is different from the
approach taken in the parent commit for advancing:

- It is complicated to reuse the repo field (which determines if an
  object store is ever accessed during advancing, and if yes, which
  object store) added to ref stores in the parent commit; the files ref
  store wraps the packed ref store, and it does not want the packed ref
  store to access any object store during advancing (as described in
  files_ref_iterator_begin()) - thus repo is NULL - but it wants packed
  ref store peeling.

- Having the repo handy when peeling is not as cumbersome as it is when
  advancing. Firstly, the repo in this case is always non-NULL, and
  secondly, peeling is typically followed by reading the object, which
  requires the repo anyway.

Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
---
 refs.c                |  2 +-
 refs/debug.c          |  9 +++++----
 refs/files-backend.c  | 12 +++++++-----
 refs/iterator.c       | 38 +++++++++++++++++++++++++++++---------
 refs/packed-backend.c | 14 ++++++++------
 refs/ref-cache.c      |  7 ++++---
 refs/refs-internal.h  | 27 ++++++++++++++++++++++-----
 7 files changed, 76 insertions(+), 33 deletions(-)

diff --git a/refs.c b/refs.c
index 35b85f3e79..7bc23bcc3f 100644
--- a/refs.c
+++ b/refs.c
@@ -2012,7 +2012,7 @@ int peel_iterated_oid(const struct object_id *base, struct object_id *peeled)
 	if (current_ref_iter &&
 	    (current_ref_iter->oid == base ||
 	     oideq(current_ref_iter->oid, base)))
-		return ref_iterator_peel(current_ref_iter, peeled);
+		return ref_iterator_peel(current_ref_iter, the_repository, peeled);
 
 	return peel_object(base, peeled) ? -1 : 0;
 }
diff --git a/refs/debug.c b/refs/debug.c
index 753d5da893..7291a1a4fb 100644
--- a/refs/debug.c
+++ b/refs/debug.c
@@ -198,13 +198,14 @@ static int debug_ref_iterator_advance(struct ref_iterator *ref_iterator)
 	return res;
 }
 
-static int debug_ref_iterator_peel(struct ref_iterator *ref_iterator,
-				   struct object_id *peeled)
+static enum ref_iterator_peel_result debug_ref_iterator_peel(
+		struct ref_iterator *ref_iterator,
+		struct object_id *peeled)
 {
 	struct debug_ref_iterator *diter =
 		(struct debug_ref_iterator *)ref_iterator;
-	int res = diter->iter->vtable->peel(diter->iter, peeled);
-	trace_printf_key(&trace_refs, "iterator_peel: %s: %d\n", diter->iter->refname, res);
+	enum ref_iterator_peel_result res = diter->iter->vtable->peel(diter->iter, peeled);
+	trace_printf_key(&trace_refs, "iterator_peel: %s: %d\n", diter->iter->refname, (int) res);
 	return res;
 }
 
diff --git a/refs/files-backend.c b/refs/files-backend.c
index 4c42db1092..e1930848b1 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -770,13 +770,14 @@ static int files_ref_iterator_advance(struct ref_iterator *ref_iterator)
 	return ok;
 }
 
-static int files_ref_iterator_peel(struct ref_iterator *ref_iterator,
-				   struct object_id *peeled)
+static enum ref_iterator_peel_result files_ref_iterator_peel(
+		struct ref_iterator *ref_iterator,
+		struct object_id *peeled)
 {
 	struct files_ref_iterator *iter =
 		(struct files_ref_iterator *)ref_iterator;
 
-	return ref_iterator_peel(iter->iter0, peeled);
+	return ref_iterator_peel_raw(iter->iter0, peeled);
 }
 
 static int files_ref_iterator_abort(struct ref_iterator *ref_iterator)
@@ -2122,8 +2123,9 @@ static int files_reflog_iterator_advance(struct ref_iterator *ref_iterator)
 	return ok;
 }
 
-static int files_reflog_iterator_peel(struct ref_iterator *ref_iterator,
-				   struct object_id *peeled)
+static enum ref_iterator_peel_result files_reflog_iterator_peel(
+		struct ref_iterator *ref_iterator,
+		struct object_id *peeled)
 {
 	BUG("ref_iterator_peel() called for reflog_iterator");
 }
diff --git a/refs/iterator.c b/refs/iterator.c
index a89d132d4f..386e6310ed 100644
--- a/refs/iterator.c
+++ b/refs/iterator.c
@@ -13,10 +13,27 @@ int ref_iterator_advance(struct ref_iterator *ref_iterator)
 	return ref_iterator->vtable->advance(ref_iterator);
 }
 
+enum ref_iterator_peel_result ref_iterator_peel_raw(
+		struct ref_iterator *ref_iterator,
+		struct object_id *peeled)
+{
+	return ref_iterator->vtable->peel(ref_iterator, peeled);
+}
+
 int ref_iterator_peel(struct ref_iterator *ref_iterator,
+		      struct repository *repo,
 		      struct object_id *peeled)
 {
-	return ref_iterator->vtable->peel(ref_iterator, peeled);
+	enum ref_iterator_peel_result result =
+		ref_iterator_peel_raw(ref_iterator, peeled);
+
+	if (repo != the_repository)
+		/* NEEDSWORK: make peel_object() work with all repositories */
+		BUG("ref_iterator_peel() can only be used with the_repository");
+	if (result == REF_ITERATOR_PEEL_INCONCLUSIVE)
+		return peel_object(ref_iterator->oid, peeled) == PEEL_PEELED ?
+			0 : -1;
+	return result == REF_ITERATOR_PEEL_SUCCESS ? 0 : -1;
 }
 
 int ref_iterator_abort(struct ref_iterator *ref_iterator)
@@ -51,8 +68,9 @@ static int empty_ref_iterator_advance(struct ref_iterator *ref_iterator)
 	return ref_iterator_abort(ref_iterator);
 }
 
-static int empty_ref_iterator_peel(struct ref_iterator *ref_iterator,
-				   struct object_id *peeled)
+static enum ref_iterator_peel_result empty_ref_iterator_peel(
+		struct ref_iterator *ref_iterator,
+		struct object_id *peeled)
 {
 	BUG("peel called for empty iterator");
 }
@@ -170,8 +188,9 @@ static int merge_ref_iterator_advance(struct ref_iterator *ref_iterator)
 	return ITER_ERROR;
 }
 
-static int merge_ref_iterator_peel(struct ref_iterator *ref_iterator,
-				   struct object_id *peeled)
+static enum ref_iterator_peel_result merge_ref_iterator_peel(
+		struct ref_iterator *ref_iterator,
+		struct object_id *peeled)
 {
 	struct merge_ref_iterator *iter =
 		(struct merge_ref_iterator *)ref_iterator;
@@ -179,7 +198,7 @@ static int merge_ref_iterator_peel(struct ref_iterator *ref_iterator,
 	if (!iter->current) {
 		BUG("peel called before advance for merge iterator");
 	}
-	return ref_iterator_peel(*iter->current, peeled);
+	return ref_iterator_peel_raw(*iter->current, peeled);
 }
 
 static int merge_ref_iterator_abort(struct ref_iterator *ref_iterator)
@@ -355,13 +374,14 @@ static int prefix_ref_iterator_advance(struct ref_iterator *ref_iterator)
 	return ok;
 }
 
-static int prefix_ref_iterator_peel(struct ref_iterator *ref_iterator,
-				    struct object_id *peeled)
+static enum ref_iterator_peel_result prefix_ref_iterator_peel(
+		struct ref_iterator *ref_iterator,
+		struct object_id *peeled)
 {
 	struct prefix_ref_iterator *iter =
 		(struct prefix_ref_iterator *)ref_iterator;
 
-	return ref_iterator_peel(iter->iter0, peeled);
+	return ref_iterator_peel_raw(iter->iter0, peeled);
 }
 
 static int prefix_ref_iterator_abort(struct ref_iterator *ref_iterator)
diff --git a/refs/packed-backend.c b/refs/packed-backend.c
index bc2302a6e0..ef14390043 100644
--- a/refs/packed-backend.c
+++ b/refs/packed-backend.c
@@ -884,19 +884,21 @@ static int packed_ref_iterator_advance(struct ref_iterator *ref_iterator)
 	return ok;
 }
 
-static int packed_ref_iterator_peel(struct ref_iterator *ref_iterator,
-				   struct object_id *peeled)
+static enum ref_iterator_peel_result packed_ref_iterator_peel(
+		struct ref_iterator *ref_iterator,
+		struct object_id *peeled)
 {
 	struct packed_ref_iterator *iter =
 		(struct packed_ref_iterator *)ref_iterator;
 
 	if ((iter->base.flags & REF_KNOWS_PEELED)) {
 		oidcpy(peeled, &iter->peeled);
-		return is_null_oid(&iter->peeled) ? -1 : 0;
+		return is_null_oid(&iter->peeled) ?
+			REF_ITERATOR_PEEL_FAILURE : REF_ITERATOR_PEEL_SUCCESS;
 	} else if ((iter->base.flags & (REF_ISBROKEN | REF_ISSYMREF))) {
-		return -1;
+		return REF_ITERATOR_PEEL_FAILURE;
 	} else {
-		return peel_object(&iter->oid, peeled) ? -1 : 0;
+		return REF_ITERATOR_PEEL_INCONCLUSIVE;
 	}
 }
 
@@ -1226,7 +1228,7 @@ static int write_with_updates(struct packed_ref_store *refs,
 			/* Pass the old reference through. */
 
 			struct object_id peeled;
-			int peel_error = ref_iterator_peel(iter, &peeled);
+			int peel_error = ref_iterator_peel(iter, the_repository, &peeled);
 
 			if (write_packed_entry(out, iter->refname,
 					       iter->oid,
diff --git a/refs/ref-cache.c b/refs/ref-cache.c
index 49d732f6db..031b613bb2 100644
--- a/refs/ref-cache.c
+++ b/refs/ref-cache.c
@@ -488,10 +488,11 @@ static int cache_ref_iterator_advance(struct ref_iterator *ref_iterator)
 	}
 }
 
-static int cache_ref_iterator_peel(struct ref_iterator *ref_iterator,
-				   struct object_id *peeled)
+static enum ref_iterator_peel_result cache_ref_iterator_peel(
+		struct ref_iterator *ref_iterator,
+		struct object_id *peeled)
 {
-	return peel_object(ref_iterator->oid, peeled) ? -1 : 0;
+	return REF_ITERATOR_PEEL_INCONCLUSIVE;
 }
 
 static int cache_ref_iterator_abort(struct ref_iterator *ref_iterator)
diff --git a/refs/refs-internal.h b/refs/refs-internal.h
index b20fa1f5cd..aea8b0844f 100644
--- a/refs/refs-internal.h
+++ b/refs/refs-internal.h
@@ -317,11 +317,26 @@ struct ref_iterator {
  */
 int ref_iterator_advance(struct ref_iterator *ref_iterator);
 
+enum ref_iterator_peel_result {
+	REF_ITERATOR_PEEL_SUCCESS,
+	REF_ITERATOR_PEEL_FAILURE,
+	REF_ITERATOR_PEEL_INCONCLUSIVE
+};
+
+/*
+ * Peel the reference currently being viewed by the iterator without
+ * using any information from any object store.
+ */
+enum ref_iterator_peel_result ref_iterator_peel_raw(
+		struct ref_iterator *ref_iterator,
+		struct object_id *peeled);
+
 /*
- * If possible, peel the reference currently being viewed by the
- * iterator. Return 0 on success.
+ * Peel the reference currently being viewed by the iterator, using the object
+ * store if the ref store has insufficient information. Returns 0 upon success.
  */
 int ref_iterator_peel(struct ref_iterator *ref_iterator,
+		      struct repository *repo,
 		      struct object_id *peeled);
 
 /*
@@ -455,10 +470,12 @@ void base_ref_iterator_free(struct ref_iterator *iter);
 typedef int ref_iterator_advance_fn(struct ref_iterator *ref_iterator);
 
 /*
- * Peels the current ref, returning 0 for success or -1 for failure.
+ * Peels the current ref using only information from the ref store. If there is
+ * not enough information, returns REF_ITERATOR_PEEL_INCONCLUSIVE.
  */
-typedef int ref_iterator_peel_fn(struct ref_iterator *ref_iterator,
-				 struct object_id *peeled);
+typedef enum ref_iterator_peel_result ref_iterator_peel_fn(
+		struct ref_iterator *ref_iterator,
+		struct object_id *peeled);
 
 /*
  * Implementations of this function should free any resources specific
-- 
2.33.0.rc2.250.ged5fa647cd-goog

