Received: from fhigh-b1-smtp.messagingengine.com (fhigh-b1-smtp.messagingengine.com [202.12.124.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 007AF23315B
	for <git@vger.kernel.org>; Mon, 17 Feb 2025 15:50:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739807436; cv=none; b=F+42kdQQBQollKYcECzCVyYKjsnEUpHT7u2JEz1y7j/HjetT6acax4sowWeOm/ix3S3KKntW+KeAkQkQQ4gWxJPxEUHxPmN7/pRGMv97d9YvlxHa0ytoy3aHrgLRE3YPSeXK7CyISP9VfglCmmRuDTnHeWK1cIQa341bI+LmvSQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739807436; c=relaxed/simple;
	bh=gdA+WOjGzMKsx83TECNZjsl4DzTcmeKGyqOJfH698LQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=l0Le9hnsOCDUptQvqvfOIUYhIzPR34BteHSbgR8oah4WKPNNGnLMcgvgFHASqVTsshjk3n9vxw4vQMkh8DrDUX62XvIZ5Z/+478wfHOS9uR51AmBJcz59WrdaTeoLU8GmEB25whT1z4s5rUWtjIOr2Z/WmDtTnRipExwkfu5m8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Rg9bFnLA; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=btJYKCfU; arc=none smtp.client-ip=202.12.124.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Rg9bFnLA";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="btJYKCfU"
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfhigh.stl.internal (Postfix) with ESMTP id EA79B25400E0;
	Mon, 17 Feb 2025 10:50:32 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Mon, 17 Feb 2025 10:50:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1739807432;
	 x=1739893832; bh=sWC5e/9NKpAfQZZb+W0cLHtoB3fIAMQvEYtkkYPFhy4=; b=
	Rg9bFnLAYyl62r9GMc8fDu9LM8LuzicfNUSKpbAZn13iIyOo+TrhovX+tvBOn89O
	MQF/OPdppimvw+gSKxR6dQmG5dfsiU9oqaWXTA9EABngAH32kCHbtmPnmQATXT5c
	Og7Td6nTpWlD5RIAHtkLEZASTUHgsnJHfl8fVZlylnQ2YhQSi6Yv14Ipno3XpIvR
	/B8hcqd5mWfMEFw4VOw3Q/XFyYT16+2ZBt8K45U60AmkQHNCQSv66TdIUeqocMmi
	RuU0UjQR5xl7uKEFqdLb3398zswAs/wMtSWzPZzlyEaxwwJkHTDnlhn0FOjqMDfO
	1OLOwsszt89EV79HVlgXnA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1739807432; x=
	1739893832; bh=sWC5e/9NKpAfQZZb+W0cLHtoB3fIAMQvEYtkkYPFhy4=; b=b
	tJYKCfUUXc4JSYp4RsK44KSXZ3YiHMcTVbbIXiWnZqwI+Gdxq7+ZGuIJDuBkavCI
	nvrrU1Dx70SZeOn+AujqSAnYiZrSCXRjp9OJzzSk3dofV+h5gICRifEL6rfzP0qy
	4s8Be9TsNsczCi8ox5Y7mrFQPNNjRMyUdKJcFV8mhS330Gm9K1B2+YPQ2GCBcwZy
	0hlSt+5qahbCO3uUC1hL6vnPql/eTtYCh3a3wakPdc2daUx5Gzd1eP+9xXEcKOgo
	E+J6m7zUh8W98BJlbyt1Ag/vFn15+mlV0NygeomCmhK5x7Auni/Jwlhxbzwoiv3d
	ec/ZIGOozD1f5tZlATuDQ==
X-ME-Sender: <xms:yFqzZxocmNxyUP12GXxPOtGdvXuMyxvUSD9rv3bnV0HncNLsG6EugQ>
    <xme:yFqzZzpv8VEkdxHvWoSCtATotw2GVG5YTC5sjH1FQzlASg_0wry5gW_u2n02YBftO
    KSlCTzkk_flFysBIw>
X-ME-Received: <xmr:yFqzZ-PPkppOFH8HfwFW7e6spVT28wJ92HV2bvgiRfwNcd4d33JypbrnJcGnt6uO5QKwWGlfiD4v_ZS9GPFIgHTkCImhDKQPrfRX4b93sojXjPc>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdehkeektdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhfffugggtgffkfhgjvfevofesthejredtredt
    jeenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrd
    himheqnecuggftrfgrthhtvghrnhepffeuiedujedvkeehuedvkeefffeivdeuleetkedu
    heejteekgedvudfgtdfgieelnecuvehluhhsthgvrhfuihiivgepvdenucfrrghrrghmpe
    hmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepiedpmhhouggv
    pehsmhhtphhouhhtpdhrtghpthhtohepshgrnhgurghlshestghruhhsthihthhoohhthh
    hprghsthgvrdhnvghtpdhrtghpthhtoheptghhrhhishgtohholhesthhugihfrghmihhl
    hidrohhrghdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhmpdhrtghpth
    htohepkhgrrhhthhhikhdrudekkeesghhmrghilhdrtghomhdprhgtphhtthhopehgihht
    sehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepphgvfhhfsehpvghffhdrnh
    gvth
X-ME-Proxy: <xmx:yFqzZ87hb3u0jF-ys5GZPRG_DtRuIzM7NYXncDRx7IXQry4bLbJ1nQ>
    <xmx:yFqzZw79rR05zzhTpexDjBr-nJU1gdOuzAt9T5z4eTYWVW44fwLq_Q>
    <xmx:yFqzZ0jvPeLrBL9usnYzrAZtA1wWOe82dCc_JaS2FJG_q3JCz2D3DA>
    <xmx:yFqzZy4jV3JvtLaTrXmYVKBDd4CHrrxZkUISACSPhP8XO7QPyBMK3A>
    <xmx:yFqzZ9u7DFpb6nP6zHPZ6nxFjvHPB18pP60NFxH4ZBm6edzbAnhT1fav>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 17 Feb 2025 10:50:31 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id d10bc3d3 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 17 Feb 2025 15:50:29 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Mon, 17 Feb 2025 16:50:21 +0100
Subject: [PATCH 07/14] refs/iterator: separate lifecycle from iteration
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250217-pks-update-ref-optimization-v1-7-a2b6d87a24af@pks.im>
References: <20250217-pks-update-ref-optimization-v1-0-a2b6d87a24af@pks.im>
In-Reply-To: <20250217-pks-update-ref-optimization-v1-0-a2b6d87a24af@pks.im>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>, 
 "brian m. carlson" <sandals@crustytoothpaste.net>, 
 Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>, 
 Christian Couder <chriscool@tuxfamily.org>
X-Mailer: b4 0.14.2

The ref and reflog iterators have their lifecycle attached to iteration:
once the iterator reaches its end, it is automatically released and the
caller doesn't have to care about that anymore. When the iterator should
be released before it has been exhausted, callers must explicitly abort
the iterator via `ref_iterator_abort()`.

This lifecycle is somewhat unusual in the Git codebase and creates two
problems:

  - Callsites need to be very careful about when exactly they call
    `ref_iterator_abort()`, as calling the function is only valid when
    the iterator itself still is. This leads to somewhat awkward calling
    patterns in some situations.

  - It is impossible to reuse iterators and re-seek them to a different
    prefix. This feature isn't supported by any iterator implementation
    except for the reftable iterators anyway, but if it was implemented
    it would allow us to optimize cases where we need to search for
    specific references repeatedly by reusing internal state.

Detangle the lifecycle from iteration so that we don't deallocate the
iterator anymore once it is exhausted. Instead, callers are now expected
to always call a newly introduce `ref_iterator_free()` function that
deallocates the iterator and its internal state.

While at it, drop the return value of `ref_iterator_abort()`, which
wasn't really required by any of the iterator implementations anyway.
Furthermore, stop calling `base_ref_iterator_free()` in any of the
backends, but instead call it in `ref_iterator_free()`.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/clone.c              |  2 +
 dir-iterator.c               | 24 +++++------
 dir-iterator.h               | 13 ++----
 refs.c                       |  7 +++-
 refs/debug.c                 |  9 ++---
 refs/files-backend.c         | 36 +++++------------
 refs/iterator.c              | 95 ++++++++++++++------------------------------
 refs/packed-backend.c        | 27 ++++++-------
 refs/ref-cache.c             |  9 ++---
 refs/refs-internal.h         | 31 +++++----------
 refs/reftable-backend.c      | 34 ++++------------
 t/helper/test-dir-iterator.c |  1 +
 12 files changed, 99 insertions(+), 189 deletions(-)

diff --git a/builtin/clone.c b/builtin/clone.c
index fd001d800c6..ac3e84b2b18 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -426,6 +426,8 @@ static void copy_or_link_directory(struct strbuf *src, struct strbuf *dest,
 		strbuf_setlen(src, src_len);
 		die(_("failed to iterate over '%s'"), src->buf);
 	}
+
+	dir_iterator_free(iter);
 }
 
 static void clone_local(const char *src_repo, const char *dest_repo)
diff --git a/dir-iterator.c b/dir-iterator.c
index de619846f29..857e1d9bdaf 100644
--- a/dir-iterator.c
+++ b/dir-iterator.c
@@ -193,9 +193,9 @@ int dir_iterator_advance(struct dir_iterator *dir_iterator)
 
 	if (S_ISDIR(iter->base.st.st_mode) && push_level(iter)) {
 		if (errno != ENOENT && iter->flags & DIR_ITERATOR_PEDANTIC)
-			goto error_out;
+			return ITER_ERROR;
 		if (iter->levels_nr == 0)
-			goto error_out;
+			return ITER_ERROR;
 	}
 
 	/* Loop until we find an entry that we can give back to the caller. */
@@ -211,11 +211,11 @@ int dir_iterator_advance(struct dir_iterator *dir_iterator)
 			int ret = next_directory_entry(level->dir, iter->base.path.buf, &de);
 			if (ret < 0) {
 				if (iter->flags & DIR_ITERATOR_PEDANTIC)
-					goto error_out;
+					return ITER_ERROR;
 				continue;
 			} else if (ret > 0) {
 				if (pop_level(iter) == 0)
-					return dir_iterator_abort(dir_iterator);
+					return ITER_DONE;
 				continue;
 			}
 
@@ -223,7 +223,7 @@ int dir_iterator_advance(struct dir_iterator *dir_iterator)
 		} else {
 			if (level->entries_idx >= level->entries.nr) {
 				if (pop_level(iter) == 0)
-					return dir_iterator_abort(dir_iterator);
+					return ITER_DONE;
 				continue;
 			}
 
@@ -232,22 +232,21 @@ int dir_iterator_advance(struct dir_iterator *dir_iterator)
 
 		if (prepare_next_entry_data(iter, name)) {
 			if (errno != ENOENT && iter->flags & DIR_ITERATOR_PEDANTIC)
-				goto error_out;
+				return ITER_ERROR;
 			continue;
 		}
 
 		return ITER_OK;
 	}
-
-error_out:
-	dir_iterator_abort(dir_iterator);
-	return ITER_ERROR;
 }
 
-int dir_iterator_abort(struct dir_iterator *dir_iterator)
+void dir_iterator_free(struct dir_iterator *dir_iterator)
 {
 	struct dir_iterator_int *iter = (struct dir_iterator_int *)dir_iterator;
 
+	if (!iter)
+		return;
+
 	for (; iter->levels_nr; iter->levels_nr--) {
 		struct dir_iterator_level *level =
 			&iter->levels[iter->levels_nr - 1];
@@ -266,7 +265,6 @@ int dir_iterator_abort(struct dir_iterator *dir_iterator)
 	free(iter->levels);
 	strbuf_release(&iter->base.path);
 	free(iter);
-	return ITER_DONE;
 }
 
 struct dir_iterator *dir_iterator_begin(const char *path, unsigned int flags)
@@ -301,7 +299,7 @@ struct dir_iterator *dir_iterator_begin(const char *path, unsigned int flags)
 	return dir_iterator;
 
 error_out:
-	dir_iterator_abort(dir_iterator);
+	dir_iterator_free(dir_iterator);
 	errno = saved_errno;
 	return NULL;
 }
diff --git a/dir-iterator.h b/dir-iterator.h
index 6d438809b6e..01f51f6bac1 100644
--- a/dir-iterator.h
+++ b/dir-iterator.h
@@ -27,10 +27,8 @@
  *             goto error_handler;
  *
  *     while ((ok = dir_iterator_advance(iter)) == ITER_OK) {
- *             if (want_to_stop_iteration()) {
- *                     ok = dir_iterator_abort(iter);
+ *             if (want_to_stop_iteration())
  *                     break;
- *             }
  *
  *             // Access information about the current path:
  *             if (S_ISDIR(iter->st.st_mode))
@@ -39,6 +37,7 @@
  *
  *     if (ok != ITER_DONE)
  *             handle_error();
+ *     dir_iterator_release(iter);
  *
  * Callers are allowed to modify iter->path while they are working,
  * but they must restore it to its original contents before calling
@@ -107,11 +106,7 @@ struct dir_iterator *dir_iterator_begin(const char *path, unsigned int flags);
  */
 int dir_iterator_advance(struct dir_iterator *iterator);
 
-/*
- * End the iteration before it has been exhausted. Free the
- * dir_iterator and any associated resources and return ITER_DONE. On
- * error, free the dir_iterator and return ITER_ERROR.
- */
-int dir_iterator_abort(struct dir_iterator *iterator);
+/* Free the dir_iterator and any associated resources. */
+void dir_iterator_free(struct dir_iterator *iterator);
 
 #endif
diff --git a/refs.c b/refs.c
index eaf41421f50..8eff60a2186 100644
--- a/refs.c
+++ b/refs.c
@@ -2476,6 +2476,7 @@ int refs_verify_refnames_available(struct ref_store *refs,
 {
 	struct strbuf dirname = STRBUF_INIT;
 	struct strbuf referent = STRBUF_INIT;
+	struct ref_iterator *iter = NULL;
 	struct strset dirnames;
 	int ret = -1;
 
@@ -2552,7 +2553,6 @@ int refs_verify_refnames_available(struct ref_store *refs,
 		strbuf_addch(&dirname, '/');
 
 		if (!initial_transaction) {
-			struct ref_iterator *iter;
 			int ok;
 
 			iter = refs_ref_iterator_begin(refs, dirname.buf, NULL, 0,
@@ -2564,12 +2564,14 @@ int refs_verify_refnames_available(struct ref_store *refs,
 
 				strbuf_addf(err, _("'%s' exists; cannot create '%s'"),
 					    iter->refname, refname);
-				ref_iterator_abort(iter);
 				goto cleanup;
 			}
 
 			if (ok != ITER_DONE)
 				BUG("error while iterating over references");
+
+			ref_iterator_free(iter);
+			iter = NULL;
 		}
 
 		extra_refname = find_descendant_ref(dirname.buf, extras, skip);
@@ -2586,6 +2588,7 @@ int refs_verify_refnames_available(struct ref_store *refs,
 	strbuf_release(&referent);
 	strbuf_release(&dirname);
 	strset_clear(&dirnames);
+	ref_iterator_free(iter);
 	return ret;
 }
 
diff --git a/refs/debug.c b/refs/debug.c
index fbc4df08b43..a9786da4ba1 100644
--- a/refs/debug.c
+++ b/refs/debug.c
@@ -179,19 +179,18 @@ static int debug_ref_iterator_peel(struct ref_iterator *ref_iterator,
 	return res;
 }
 
-static int debug_ref_iterator_abort(struct ref_iterator *ref_iterator)
+static void debug_ref_iterator_release(struct ref_iterator *ref_iterator)
 {
 	struct debug_ref_iterator *diter =
 		(struct debug_ref_iterator *)ref_iterator;
-	int res = diter->iter->vtable->abort(diter->iter);
-	trace_printf_key(&trace_refs, "iterator_abort: %d\n", res);
-	return res;
+	diter->iter->vtable->release(diter->iter);
+	trace_printf_key(&trace_refs, "iterator_abort\n");
 }
 
 static struct ref_iterator_vtable debug_ref_iterator_vtable = {
 	.advance = debug_ref_iterator_advance,
 	.peel = debug_ref_iterator_peel,
-	.abort = debug_ref_iterator_abort,
+	.release = debug_ref_iterator_release,
 };
 
 static struct ref_iterator *
diff --git a/refs/files-backend.c b/refs/files-backend.c
index 29f08dced40..9511b6f3448 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -919,10 +919,6 @@ static int files_ref_iterator_advance(struct ref_iterator *ref_iterator)
 		return ITER_OK;
 	}
 
-	iter->iter0 = NULL;
-	if (ref_iterator_abort(ref_iterator) != ITER_DONE)
-		ok = ITER_ERROR;
-
 	return ok;
 }
 
@@ -935,23 +931,17 @@ static int files_ref_iterator_peel(struct ref_iterator *ref_iterator,
 	return ref_iterator_peel(iter->iter0, peeled);
 }
 
-static int files_ref_iterator_abort(struct ref_iterator *ref_iterator)
+static void files_ref_iterator_release(struct ref_iterator *ref_iterator)
 {
 	struct files_ref_iterator *iter =
 		(struct files_ref_iterator *)ref_iterator;
-	int ok = ITER_DONE;
-
-	if (iter->iter0)
-		ok = ref_iterator_abort(iter->iter0);
-
-	base_ref_iterator_free(ref_iterator);
-	return ok;
+	ref_iterator_free(iter->iter0);
 }
 
 static struct ref_iterator_vtable files_ref_iterator_vtable = {
 	.advance = files_ref_iterator_advance,
 	.peel = files_ref_iterator_peel,
-	.abort = files_ref_iterator_abort,
+	.release = files_ref_iterator_release,
 };
 
 static struct ref_iterator *files_ref_iterator_begin(
@@ -1382,7 +1372,7 @@ static int should_pack_refs(struct files_ref_store *refs,
 				    iter->flags, opts))
 			refcount++;
 		if (refcount >= limit) {
-			ref_iterator_abort(iter);
+			ref_iterator_free(iter);
 			return 1;
 		}
 	}
@@ -1390,6 +1380,7 @@ static int should_pack_refs(struct files_ref_store *refs,
 	if (ret != ITER_DONE)
 		die("error while iterating over references");
 
+	ref_iterator_free(iter);
 	return 0;
 }
 
@@ -1456,6 +1447,7 @@ static int files_pack_refs(struct ref_store *ref_store,
 	packed_refs_unlock(refs->packed_ref_store);
 
 	prune_refs(refs, &refs_to_prune);
+	ref_iterator_free(iter);
 	strbuf_release(&err);
 	return 0;
 }
@@ -2303,9 +2295,6 @@ static int files_reflog_iterator_advance(struct ref_iterator *ref_iterator)
 		return ITER_OK;
 	}
 
-	iter->dir_iterator = NULL;
-	if (ref_iterator_abort(ref_iterator) == ITER_ERROR)
-		ok = ITER_ERROR;
 	return ok;
 }
 
@@ -2315,23 +2304,17 @@ static int files_reflog_iterator_peel(struct ref_iterator *ref_iterator UNUSED,
 	BUG("ref_iterator_peel() called for reflog_iterator");
 }
 
-static int files_reflog_iterator_abort(struct ref_iterator *ref_iterator)
+static void files_reflog_iterator_release(struct ref_iterator *ref_iterator)
 {
 	struct files_reflog_iterator *iter =
 		(struct files_reflog_iterator *)ref_iterator;
-	int ok = ITER_DONE;
-
-	if (iter->dir_iterator)
-		ok = dir_iterator_abort(iter->dir_iterator);
-
-	base_ref_iterator_free(ref_iterator);
-	return ok;
+	dir_iterator_free(iter->dir_iterator);
 }
 
 static struct ref_iterator_vtable files_reflog_iterator_vtable = {
 	.advance = files_reflog_iterator_advance,
 	.peel = files_reflog_iterator_peel,
-	.abort = files_reflog_iterator_abort,
+	.release = files_reflog_iterator_release,
 };
 
 static struct ref_iterator *reflog_iterator_begin(struct ref_store *ref_store,
@@ -3808,6 +3791,7 @@ static int files_fsck_refs_dir(struct ref_store *ref_store,
 		ret = error(_("failed to iterate over '%s'"), sb.buf);
 
 out:
+	dir_iterator_free(iter);
 	strbuf_release(&sb);
 	strbuf_release(&refname);
 	return ret;
diff --git a/refs/iterator.c b/refs/iterator.c
index d25e568bf0b..aaeff270437 100644
--- a/refs/iterator.c
+++ b/refs/iterator.c
@@ -21,9 +21,14 @@ int ref_iterator_peel(struct ref_iterator *ref_iterator,
 	return ref_iterator->vtable->peel(ref_iterator, peeled);
 }
 
-int ref_iterator_abort(struct ref_iterator *ref_iterator)
+void ref_iterator_free(struct ref_iterator *ref_iterator)
 {
-	return ref_iterator->vtable->abort(ref_iterator);
+	if (ref_iterator) {
+		ref_iterator->vtable->release(ref_iterator);
+		/* Help make use-after-free bugs fail quickly: */
+		ref_iterator->vtable = NULL;
+		free(ref_iterator);
+	}
 }
 
 void base_ref_iterator_init(struct ref_iterator *iter,
@@ -36,20 +41,13 @@ void base_ref_iterator_init(struct ref_iterator *iter,
 	iter->flags = 0;
 }
 
-void base_ref_iterator_free(struct ref_iterator *iter)
-{
-	/* Help make use-after-free bugs fail quickly: */
-	iter->vtable = NULL;
-	free(iter);
-}
-
 struct empty_ref_iterator {
 	struct ref_iterator base;
 };
 
-static int empty_ref_iterator_advance(struct ref_iterator *ref_iterator)
+static int empty_ref_iterator_advance(struct ref_iterator *ref_iterator UNUSED)
 {
-	return ref_iterator_abort(ref_iterator);
+	return ITER_DONE;
 }
 
 static int empty_ref_iterator_peel(struct ref_iterator *ref_iterator UNUSED,
@@ -58,16 +56,14 @@ static int empty_ref_iterator_peel(struct ref_iterator *ref_iterator UNUSED,
 	BUG("peel called for empty iterator");
 }
 
-static int empty_ref_iterator_abort(struct ref_iterator *ref_iterator)
+static void empty_ref_iterator_release(struct ref_iterator *ref_iterator UNUSED)
 {
-	base_ref_iterator_free(ref_iterator);
-	return ITER_DONE;
 }
 
 static struct ref_iterator_vtable empty_ref_iterator_vtable = {
 	.advance = empty_ref_iterator_advance,
 	.peel = empty_ref_iterator_peel,
-	.abort = empty_ref_iterator_abort,
+	.release = empty_ref_iterator_release,
 };
 
 struct ref_iterator *empty_ref_iterator_begin(void)
@@ -151,11 +147,13 @@ static int merge_ref_iterator_advance(struct ref_iterator *ref_iterator)
 	if (!iter->current) {
 		/* Initialize: advance both iterators to their first entries */
 		if ((ok = ref_iterator_advance(iter->iter0)) != ITER_OK) {
+			ref_iterator_free(iter->iter0);
 			iter->iter0 = NULL;
 			if (ok == ITER_ERROR)
 				goto error;
 		}
 		if ((ok = ref_iterator_advance(iter->iter1)) != ITER_OK) {
+			ref_iterator_free(iter->iter1);
 			iter->iter1 = NULL;
 			if (ok == ITER_ERROR)
 				goto error;
@@ -166,6 +164,7 @@ static int merge_ref_iterator_advance(struct ref_iterator *ref_iterator)
 		 * entry:
 		 */
 		if ((ok = ref_iterator_advance(*iter->current)) != ITER_OK) {
+			ref_iterator_free(*iter->current);
 			*iter->current = NULL;
 			if (ok == ITER_ERROR)
 				goto error;
@@ -179,9 +178,8 @@ static int merge_ref_iterator_advance(struct ref_iterator *ref_iterator)
 			iter->select(iter->iter0, iter->iter1, iter->cb_data);
 
 		if (selection == ITER_SELECT_DONE) {
-			return ref_iterator_abort(ref_iterator);
+			return ITER_DONE;
 		} else if (selection == ITER_SELECT_ERROR) {
-			ref_iterator_abort(ref_iterator);
 			return ITER_ERROR;
 		}
 
@@ -195,6 +193,7 @@ static int merge_ref_iterator_advance(struct ref_iterator *ref_iterator)
 
 		if (selection & ITER_SKIP_SECONDARY) {
 			if ((ok = ref_iterator_advance(*secondary)) != ITER_OK) {
+				ref_iterator_free(*secondary);
 				*secondary = NULL;
 				if (ok == ITER_ERROR)
 					goto error;
@@ -211,7 +210,6 @@ static int merge_ref_iterator_advance(struct ref_iterator *ref_iterator)
 	}
 
 error:
-	ref_iterator_abort(ref_iterator);
 	return ITER_ERROR;
 }
 
@@ -227,28 +225,18 @@ static int merge_ref_iterator_peel(struct ref_iterator *ref_iterator,
 	return ref_iterator_peel(*iter->current, peeled);
 }
 
-static int merge_ref_iterator_abort(struct ref_iterator *ref_iterator)
+static void merge_ref_iterator_release(struct ref_iterator *ref_iterator)
 {
 	struct merge_ref_iterator *iter =
 		(struct merge_ref_iterator *)ref_iterator;
-	int ok = ITER_DONE;
-
-	if (iter->iter0) {
-		if (ref_iterator_abort(iter->iter0) != ITER_DONE)
-			ok = ITER_ERROR;
-	}
-	if (iter->iter1) {
-		if (ref_iterator_abort(iter->iter1) != ITER_DONE)
-			ok = ITER_ERROR;
-	}
-	base_ref_iterator_free(ref_iterator);
-	return ok;
+	ref_iterator_free(iter->iter0);
+	ref_iterator_free(iter->iter1);
 }
 
 static struct ref_iterator_vtable merge_ref_iterator_vtable = {
 	.advance = merge_ref_iterator_advance,
 	.peel = merge_ref_iterator_peel,
-	.abort = merge_ref_iterator_abort,
+	.release = merge_ref_iterator_release,
 };
 
 struct ref_iterator *merge_ref_iterator_begin(
@@ -310,10 +298,10 @@ struct ref_iterator *overlay_ref_iterator_begin(
 	 * them.
 	 */
 	if (is_empty_ref_iterator(front)) {
-		ref_iterator_abort(front);
+		ref_iterator_free(front);
 		return back;
 	} else if (is_empty_ref_iterator(back)) {
-		ref_iterator_abort(back);
+		ref_iterator_free(back);
 		return front;
 	}
 
@@ -350,19 +338,10 @@ static int prefix_ref_iterator_advance(struct ref_iterator *ref_iterator)
 
 	while ((ok = ref_iterator_advance(iter->iter0)) == ITER_OK) {
 		int cmp = compare_prefix(iter->iter0->refname, iter->prefix);
-
 		if (cmp < 0)
 			continue;
-
-		if (cmp > 0) {
-			/*
-			 * As the source iterator is ordered, we
-			 * can stop the iteration as soon as we see a
-			 * refname that comes after the prefix:
-			 */
-			ok = ref_iterator_abort(iter->iter0);
-			break;
-		}
+		if (cmp > 0)
+			return ITER_DONE;
 
 		if (iter->trim) {
 			/*
@@ -386,9 +365,6 @@ static int prefix_ref_iterator_advance(struct ref_iterator *ref_iterator)
 		return ITER_OK;
 	}
 
-	iter->iter0 = NULL;
-	if (ref_iterator_abort(ref_iterator) != ITER_DONE)
-		return ITER_ERROR;
 	return ok;
 }
 
@@ -401,23 +377,18 @@ static int prefix_ref_iterator_peel(struct ref_iterator *ref_iterator,
 	return ref_iterator_peel(iter->iter0, peeled);
 }
 
-static int prefix_ref_iterator_abort(struct ref_iterator *ref_iterator)
+static void prefix_ref_iterator_release(struct ref_iterator *ref_iterator)
 {
 	struct prefix_ref_iterator *iter =
 		(struct prefix_ref_iterator *)ref_iterator;
-	int ok = ITER_DONE;
-
-	if (iter->iter0)
-		ok = ref_iterator_abort(iter->iter0);
+	ref_iterator_free(iter->iter0);
 	free(iter->prefix);
-	base_ref_iterator_free(ref_iterator);
-	return ok;
 }
 
 static struct ref_iterator_vtable prefix_ref_iterator_vtable = {
 	.advance = prefix_ref_iterator_advance,
 	.peel = prefix_ref_iterator_peel,
-	.abort = prefix_ref_iterator_abort,
+	.release = prefix_ref_iterator_release,
 };
 
 struct ref_iterator *prefix_ref_iterator_begin(struct ref_iterator *iter0,
@@ -453,20 +424,14 @@ int do_for_each_ref_iterator(struct ref_iterator *iter,
 	current_ref_iter = iter;
 	while ((ok = ref_iterator_advance(iter)) == ITER_OK) {
 		retval = fn(iter->refname, iter->referent, iter->oid, iter->flags, cb_data);
-		if (retval) {
-			/*
-			 * If ref_iterator_abort() returns ITER_ERROR,
-			 * we ignore that error in deference to the
-			 * callback function's return value.
-			 */
-			ref_iterator_abort(iter);
+		if (retval)
 			goto out;
-		}
 	}
 
 out:
 	current_ref_iter = old_ref_iter;
 	if (ok == ITER_ERROR)
-		return -1;
+		retval = -1;
+	ref_iterator_free(iter);
 	return retval;
 }
diff --git a/refs/packed-backend.c b/refs/packed-backend.c
index a7b6f74b6e3..38a1956d1a8 100644
--- a/refs/packed-backend.c
+++ b/refs/packed-backend.c
@@ -954,9 +954,6 @@ static int packed_ref_iterator_advance(struct ref_iterator *ref_iterator)
 		return ITER_OK;
 	}
 
-	if (ref_iterator_abort(ref_iterator) != ITER_DONE)
-		ok = ITER_ERROR;
-
 	return ok;
 }
 
@@ -976,23 +973,19 @@ static int packed_ref_iterator_peel(struct ref_iterator *ref_iterator,
 	}
 }
 
-static int packed_ref_iterator_abort(struct ref_iterator *ref_iterator)
+static void packed_ref_iterator_release(struct ref_iterator *ref_iterator)
 {
 	struct packed_ref_iterator *iter =
 		(struct packed_ref_iterator *)ref_iterator;
-	int ok = ITER_DONE;
-
 	strbuf_release(&iter->refname_buf);
 	free(iter->jump);
 	release_snapshot(iter->snapshot);
-	base_ref_iterator_free(ref_iterator);
-	return ok;
 }
 
 static struct ref_iterator_vtable packed_ref_iterator_vtable = {
 	.advance = packed_ref_iterator_advance,
 	.peel = packed_ref_iterator_peel,
-	.abort = packed_ref_iterator_abort
+	.release = packed_ref_iterator_release,
 };
 
 static int jump_list_entry_cmp(const void *va, const void *vb)
@@ -1362,8 +1355,10 @@ static int write_with_updates(struct packed_ref_store *refs,
 	 */
 	iter = packed_ref_iterator_begin(&refs->base, "", NULL,
 					 DO_FOR_EACH_INCLUDE_BROKEN);
-	if ((ok = ref_iterator_advance(iter)) != ITER_OK)
+	if ((ok = ref_iterator_advance(iter)) != ITER_OK) {
+		ref_iterator_free(iter);
 		iter = NULL;
+	}
 
 	i = 0;
 
@@ -1411,8 +1406,10 @@ static int write_with_updates(struct packed_ref_store *refs,
 				 * the iterator over the unneeded
 				 * value.
 				 */
-				if ((ok = ref_iterator_advance(iter)) != ITER_OK)
+				if ((ok = ref_iterator_advance(iter)) != ITER_OK) {
+					ref_iterator_free(iter);
 					iter = NULL;
+				}
 				cmp = +1;
 			} else {
 				/*
@@ -1449,8 +1446,10 @@ static int write_with_updates(struct packed_ref_store *refs,
 					       peel_error ? NULL : &peeled))
 				goto write_error;
 
-			if ((ok = ref_iterator_advance(iter)) != ITER_OK)
+			if ((ok = ref_iterator_advance(iter)) != ITER_OK) {
+				ref_iterator_free(iter);
 				iter = NULL;
+			}
 		} else if (is_null_oid(&update->new_oid)) {
 			/*
 			 * The update wants to delete the reference,
@@ -1499,9 +1498,7 @@ static int write_with_updates(struct packed_ref_store *refs,
 		    get_tempfile_path(refs->tempfile), strerror(errno));
 
 error:
-	if (iter)
-		ref_iterator_abort(iter);
-
+	ref_iterator_free(iter);
 	delete_tempfile(&refs->tempfile);
 	return -1;
 }
diff --git a/refs/ref-cache.c b/refs/ref-cache.c
index 02f09e4df88..6457e02c1ea 100644
--- a/refs/ref-cache.c
+++ b/refs/ref-cache.c
@@ -409,7 +409,7 @@ static int cache_ref_iterator_advance(struct ref_iterator *ref_iterator)
 		if (++level->index == level->dir->nr) {
 			/* This level is exhausted; pop up a level */
 			if (--iter->levels_nr == 0)
-				return ref_iterator_abort(ref_iterator);
+				return ITER_DONE;
 
 			continue;
 		}
@@ -452,21 +452,18 @@ static int cache_ref_iterator_peel(struct ref_iterator *ref_iterator,
 	return peel_object(iter->repo, ref_iterator->oid, peeled) ? -1 : 0;
 }
 
-static int cache_ref_iterator_abort(struct ref_iterator *ref_iterator)
+static void cache_ref_iterator_release(struct ref_iterator *ref_iterator)
 {
 	struct cache_ref_iterator *iter =
 		(struct cache_ref_iterator *)ref_iterator;
-
 	free((char *)iter->prefix);
 	free(iter->levels);
-	base_ref_iterator_free(ref_iterator);
-	return ITER_DONE;
 }
 
 static struct ref_iterator_vtable cache_ref_iterator_vtable = {
 	.advance = cache_ref_iterator_advance,
 	.peel = cache_ref_iterator_peel,
-	.abort = cache_ref_iterator_abort
+	.release = cache_ref_iterator_release,
 };
 
 struct ref_iterator *cache_ref_iterator_begin(struct ref_cache *cache,
diff --git a/refs/refs-internal.h b/refs/refs-internal.h
index aaab711bb96..27ff822cf43 100644
--- a/refs/refs-internal.h
+++ b/refs/refs-internal.h
@@ -273,11 +273,11 @@ enum do_for_each_ref_flags {
  * the next reference and returns ITER_OK. The data pointed at by
  * refname and oid belong to the iterator; if you want to retain them
  * after calling ref_iterator_advance() again or calling
- * ref_iterator_abort(), you must make a copy. When the iteration has
+ * ref_iterator_free(), you must make a copy. When the iteration has
  * been exhausted, ref_iterator_advance() releases any resources
  * associated with the iteration, frees the ref_iterator object, and
  * returns ITER_DONE. If you want to abort the iteration early, call
- * ref_iterator_abort(), which also frees the ref_iterator object and
+ * ref_iterator_free(), which also frees the ref_iterator object and
  * any associated resources. If there was an internal error advancing
  * to the next entry, ref_iterator_advance() aborts the iteration,
  * frees the ref_iterator, and returns ITER_ERROR.
@@ -292,10 +292,8 @@ enum do_for_each_ref_flags {
  *     struct ref_iterator *iter = ...;
  *
  *     while ((ok = ref_iterator_advance(iter)) == ITER_OK) {
- *             if (want_to_stop_iteration()) {
- *                     ok = ref_iterator_abort(iter);
+ *             if (want_to_stop_iteration())
  *                     break;
- *             }
  *
  *             // Access information about the current reference:
  *             if (!(iter->flags & REF_ISSYMREF))
@@ -307,6 +305,7 @@ enum do_for_each_ref_flags {
  *
  *     if (ok != ITER_DONE)
  *             handle_error();
+ *     ref_iterator_free(iter);
  */
 struct ref_iterator {
 	struct ref_iterator_vtable *vtable;
@@ -333,12 +332,8 @@ int ref_iterator_advance(struct ref_iterator *ref_iterator);
 int ref_iterator_peel(struct ref_iterator *ref_iterator,
 		      struct object_id *peeled);
 
-/*
- * End the iteration before it has been exhausted, freeing the
- * reference iterator and any associated resources and returning
- * ITER_DONE. If the abort itself failed, return ITER_ERROR.
- */
-int ref_iterator_abort(struct ref_iterator *ref_iterator);
+/* Free the reference iterator and any associated resources. */
+void ref_iterator_free(struct ref_iterator *ref_iterator);
 
 /*
  * An iterator over nothing (its first ref_iterator_advance() call
@@ -438,13 +433,6 @@ struct ref_iterator *prefix_ref_iterator_begin(struct ref_iterator *iter0,
 void base_ref_iterator_init(struct ref_iterator *iter,
 			    struct ref_iterator_vtable *vtable);
 
-/*
- * Base class destructor for ref_iterators. Destroy the ref_iterator
- * part of iter and shallow-free the object. This is meant to be
- * called only by the destructors of derived classes.
- */
-void base_ref_iterator_free(struct ref_iterator *iter);
-
 /* Virtual function declarations for ref_iterators: */
 
 /*
@@ -463,15 +451,14 @@ typedef int ref_iterator_peel_fn(struct ref_iterator *ref_iterator,
 
 /*
  * Implementations of this function should free any resources specific
- * to the derived class, then call base_ref_iterator_free() to clean
- * up and free the ref_iterator object.
+ * to the derived class.
  */
-typedef int ref_iterator_abort_fn(struct ref_iterator *ref_iterator);
+typedef void ref_iterator_release_fn(struct ref_iterator *ref_iterator);
 
 struct ref_iterator_vtable {
 	ref_iterator_advance_fn *advance;
 	ref_iterator_peel_fn *peel;
-	ref_iterator_abort_fn *abort;
+	ref_iterator_release_fn *release;
 };
 
 /*
diff --git a/refs/reftable-backend.c b/refs/reftable-backend.c
index 2a90e7cb391..06543f79c64 100644
--- a/refs/reftable-backend.c
+++ b/refs/reftable-backend.c
@@ -711,17 +711,10 @@ static int reftable_ref_iterator_advance(struct ref_iterator *ref_iterator)
 		break;
 	}
 
-	if (iter->err > 0) {
-		if (ref_iterator_abort(ref_iterator) != ITER_DONE)
-			return ITER_ERROR;
+	if (iter->err > 0)
 		return ITER_DONE;
-	}
-
-	if (iter->err < 0) {
-		ref_iterator_abort(ref_iterator);
+	if (iter->err < 0)
 		return ITER_ERROR;
-	}
-
 	return ITER_OK;
 }
 
@@ -740,7 +733,7 @@ static int reftable_ref_iterator_peel(struct ref_iterator *ref_iterator,
 	return -1;
 }
 
-static int reftable_ref_iterator_abort(struct ref_iterator *ref_iterator)
+static void reftable_ref_iterator_release(struct ref_iterator *ref_iterator)
 {
 	struct reftable_ref_iterator *iter =
 		(struct reftable_ref_iterator *)ref_iterator;
@@ -751,14 +744,12 @@ static int reftable_ref_iterator_abort(struct ref_iterator *ref_iterator)
 			free(iter->exclude_patterns[i]);
 		free(iter->exclude_patterns);
 	}
-	free(iter);
-	return ITER_DONE;
 }
 
 static struct ref_iterator_vtable reftable_ref_iterator_vtable = {
 	.advance = reftable_ref_iterator_advance,
 	.peel = reftable_ref_iterator_peel,
-	.abort = reftable_ref_iterator_abort
+	.release = reftable_ref_iterator_release,
 };
 
 static int qsort_strcmp(const void *va, const void *vb)
@@ -2017,17 +2008,10 @@ static int reftable_reflog_iterator_advance(struct ref_iterator *ref_iterator)
 		break;
 	}
 
-	if (iter->err > 0) {
-		if (ref_iterator_abort(ref_iterator) != ITER_DONE)
-			return ITER_ERROR;
+	if (iter->err > 0)
 		return ITER_DONE;
-	}
-
-	if (iter->err < 0) {
-		ref_iterator_abort(ref_iterator);
+	if (iter->err < 0)
 		return ITER_ERROR;
-	}
-
 	return ITER_OK;
 }
 
@@ -2038,21 +2022,19 @@ static int reftable_reflog_iterator_peel(struct ref_iterator *ref_iterator UNUSE
 	return -1;
 }
 
-static int reftable_reflog_iterator_abort(struct ref_iterator *ref_iterator)
+static void reftable_reflog_iterator_release(struct ref_iterator *ref_iterator)
 {
 	struct reftable_reflog_iterator *iter =
 		(struct reftable_reflog_iterator *)ref_iterator;
 	reftable_log_record_release(&iter->log);
 	reftable_iterator_destroy(&iter->iter);
 	strbuf_release(&iter->last_name);
-	free(iter);
-	return ITER_DONE;
 }
 
 static struct ref_iterator_vtable reftable_reflog_iterator_vtable = {
 	.advance = reftable_reflog_iterator_advance,
 	.peel = reftable_reflog_iterator_peel,
-	.abort = reftable_reflog_iterator_abort
+	.release = reftable_reflog_iterator_release,
 };
 
 static struct reftable_reflog_iterator *reflog_iterator_for_stack(struct reftable_ref_store *refs,
diff --git a/t/helper/test-dir-iterator.c b/t/helper/test-dir-iterator.c
index 6b297bd7536..8d46e8ba409 100644
--- a/t/helper/test-dir-iterator.c
+++ b/t/helper/test-dir-iterator.c
@@ -53,6 +53,7 @@ int cmd__dir_iterator(int argc, const char **argv)
 		printf("(%s) [%s] %s\n", diter->relative_path, diter->basename,
 		       diter->path.buf);
 	}
+	dir_iterator_free(diter);
 
 	if (iter_status != ITER_DONE) {
 		printf("dir_iterator_advance failure\n");

-- 
2.48.1.666.gff9fcf71b7.dirty

