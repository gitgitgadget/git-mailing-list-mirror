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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92E48C433FE
	for <git@archiver.kernel.org>; Tue, 21 Sep 2021 16:51:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 729CF611BD
	for <git@archiver.kernel.org>; Tue, 21 Sep 2021 16:51:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229778AbhIUQwr (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 21 Sep 2021 12:52:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229773AbhIUQwq (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Sep 2021 12:52:46 -0400
Received: from mail-qk1-x749.google.com (mail-qk1-x749.google.com [IPv6:2607:f8b0:4864:20::749])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E93E0C061574
        for <git@vger.kernel.org>; Tue, 21 Sep 2021 09:51:17 -0700 (PDT)
Received: by mail-qk1-x749.google.com with SMTP id m10-20020a05620a290a00b004334bcdf1f4so56777402qkp.2
        for <git@vger.kernel.org>; Tue, 21 Sep 2021 09:51:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=wBaTShB5IU0mBEEDbpuS4BpyQQqt78GrIjGwByykJZU=;
        b=YK/UWKCOpwGnurpPP8lbRa3SYXTLkc0M00Z58PxmlitNutWP+eE2mfUpdZgx0J42MJ
         31htW8Ht0w9Di4D3Vq7E871Zxu2U34VRgyvmKLCoOIujjolO17V6/RDIimR1QaWebZD/
         1HIT6x4TqES8Jsr1MQRLbEAHL9M9nPMd85BazxvNdvAG3AwgATPjaPe8HpNqEWKmdaEg
         l3EYu7WWi3ujzJXLR+ao13PYIizq0TJUXE/00aJfLYskvxD2v9yc96lkXqQquqBvs5EK
         GwIs4z8OJ6jE2waXigCiOWKBseFQPiuSXT6g3dRX8iDUyFaC7xVCpNFHU6woRhD1qURE
         8V/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=wBaTShB5IU0mBEEDbpuS4BpyQQqt78GrIjGwByykJZU=;
        b=i3TeTo7UqNhkqi6hKa5S4mAqFuj3RHXGvz/GaDBewvGWWSbVKCzn7bREuIef5TBuwK
         uwt2NsyrU3Qibp2iEIM1ojOc3PzBO9RJbFiWAb7RAIsK2oIuOIfYRYmtI9Px5HN+E7Vc
         9KV2mvLgi0vEx3mHmyNe5Sk9XyGKBJFXraS+BLMd8cG1G+ujRZvt6Ix8Ykoj18+7Y7oT
         p9PO56hsdWPlN5S7WcexmVMtKR62lVjwwXnK4t4/OZ2dRKdzg7cnaNRe8k6pwRbKyecJ
         U4+kS80/eLW6RS576sF/b5jk7t5ahbTmfXKWNLdpXd3t9jVYLKABF53GTmwf3cmpSCXX
         0coQ==
X-Gm-Message-State: AOAM532k1GEQ3DA6JedB0OBBcSsNaZwJCwMT9qK6JloIc0NOgWkpsEVo
        ug9VjOxHSMcZOIpU4clWzM725KZSAtn/OxB85CR5EDWaOs42yibEsAqEA7cWHnoqWjS+UPQCZ28
        EkprAg7KLIkJftOHTQYgl51nmVcZxVZ4k3N60HmXZ9KDIH+XXdDaaqODZ8hvaHpvyiFNAj2UREJ
        3B
X-Google-Smtp-Source: ABdhPJylYjUtZ0+Bo3GptM9N70ExmEOk2QmOO06BtMUdsQHg/H+yKmcxo43yV7t9bNHgoeVZMzGgQea7Pk4zpwAhC+Ip
X-Received: from twelve4.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:437a])
 (user=jonathantanmy job=sendgmr) by 2002:a05:6214:689:: with SMTP id
 r9mr23123350qvz.37.1632243077064; Tue, 21 Sep 2021 09:51:17 -0700 (PDT)
Date:   Tue, 21 Sep 2021 09:51:04 -0700
In-Reply-To: <cover.1632242495.git.jonathantanmy@google.com>
Message-Id: <e404b5eb1a961fcaf4534e4e31f1c45e03d6de3e.1632242495.git.jonathantanmy@google.com>
Mime-Version: 1.0
References: <cover.1632242495.git.jonathantanmy@google.com>
X-Mailer: git-send-email 2.33.0.464.g1972c5931b-goog
Subject: [PATCH 2/9] refs: add repo paramater to _iterator_peel()
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>
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
index 49ddcdac53..3a57893032 100644
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
index 1a7a9e11cf..7592de0a4a 100644
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
index cd145301d0..1faab1cf66 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -757,13 +757,14 @@ static int files_ref_iterator_advance(struct ref_iterator *ref_iterator)
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
@@ -2105,8 +2106,9 @@ static int files_reflog_iterator_advance(struct ref_iterator *ref_iterator)
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
index 5af6554887..ee6b00a7be 100644
--- a/refs/iterator.c
+++ b/refs/iterator.c
@@ -29,10 +29,27 @@ int ref_iterator_advance(struct ref_iterator *ref_iterator)
 	return ok;
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
@@ -67,8 +84,9 @@ static int empty_ref_iterator_advance(struct ref_iterator *ref_iterator)
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
@@ -186,8 +204,9 @@ static int merge_ref_iterator_advance(struct ref_iterator *ref_iterator)
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
@@ -195,7 +214,7 @@ static int merge_ref_iterator_peel(struct ref_iterator *ref_iterator,
 	if (!iter->current) {
 		BUG("peel called before advance for merge iterator");
 	}
-	return ref_iterator_peel(*iter->current, peeled);
+	return ref_iterator_peel_raw(*iter->current, peeled);
 }
 
 static int merge_ref_iterator_abort(struct ref_iterator *ref_iterator)
@@ -371,13 +390,14 @@ static int prefix_ref_iterator_advance(struct ref_iterator *ref_iterator)
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
index f52d5488b8..d258303696 100644
--- a/refs/packed-backend.c
+++ b/refs/packed-backend.c
@@ -872,19 +872,21 @@ static int packed_ref_iterator_advance(struct ref_iterator *ref_iterator)
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
 
@@ -1210,7 +1212,7 @@ static int write_with_updates(struct packed_ref_store *refs,
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
index dc0ed65686..4656ef83a3 100644
--- a/refs/refs-internal.h
+++ b/refs/refs-internal.h
@@ -323,11 +323,26 @@ struct ref_iterator {
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
@@ -461,10 +476,12 @@ void base_ref_iterator_free(struct ref_iterator *iter);
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
2.33.0.464.g1972c5931b-goog

