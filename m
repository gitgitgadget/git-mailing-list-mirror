Received: from fout-b4-smtp.messagingengine.com (fout-b4-smtp.messagingengine.com [202.12.124.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 391071E9B12
	for <git@vger.kernel.org>; Fri, 20 Feb 2026 08:24:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771575884; cv=none; b=a9z1ERymDHSMhaStmPMlCTvelW7ebvcMHCUkbiogmCCDBya5CWFasy0dDsv9Oue1m/T0e9DK43pYPy460Foo+TdRD5qPeeVywgoGX289SapL4tng79aZ7p+QMme1IwVt1f0gAlGWghWSPM17Q3fETfTjON2AlWHWCluBsUSJ23o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771575884; c=relaxed/simple;
	bh=+NOp0aXoU3j0MoYtOI6/NbXcVuCpehOBbqGQ03kvmOA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=i46YW8NBqWtFKTsrsECekIctRjgYHk21B04yKNhfIMuHFfC+L74pQQKRmc3lbed/hbXOrufexpmZaiEDRoWfy55rcxZkhq7W6igYan9h+w4ZyD8o4RYMD8ULk2Zi88lVbtjJF14sUbD6emEJOPHKDcerQp2AkmAKb1Yye9TLNLs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=jbmPP4RT; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=LvZs7T4K; arc=none smtp.client-ip=202.12.124.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="jbmPP4RT";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="LvZs7T4K"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.stl.internal (Postfix) with ESMTP id 3E1D11D00045;
	Fri, 20 Feb 2026 03:24:42 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Fri, 20 Feb 2026 03:24:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1771575882;
	 x=1771662282; bh=w7DEvT971dpasBtGaf/2sjoqQeY/xKiCyEMpTAcWeMo=; b=
	jbmPP4RTdrB7uWAcclPzVVqdf2uGe0umNjADzMw3bLAsNVUanfRhwCvlaHduRXRy
	0DmZb1bvBdSCDUqro+8TvBzYDEE1fa166CDRTYMMpKXY7p+TzMAPGgaA6oz2QqVe
	FxQpFZwL5kDuGgsZPO13j0nnJ1yET+knetaVlzhAV4vcjg2wexTEMNtaDttFhf9S
	d/nB4vVi7h4NneJijiFYVt88EstEBoe3zx9vLyWj9MMtfsWYS0Ou7whIVlxkR/2L
	NNWPSA0g8jHTLk5uXbAYylH1uOdBvVhpLowu9PSfDtRV5NAN7YsppjfgXYccOGl4
	q35au1s1CAmL8Z5xq8GJ0w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1771575882; x=
	1771662282; bh=w7DEvT971dpasBtGaf/2sjoqQeY/xKiCyEMpTAcWeMo=; b=L
	vZs7T4KhZY/S9nE7Clwjvlf4Qf7wH3/Cta/TxQj59kOPxRdT5QUL8Db9nXtwAapp
	+cDPEZKAq3DBzKf0Sc9YECjR7qFuAGW9yLqoYMetheH1ulSsLc0PnJ9kHroDM+H6
	t+Gs4rr6Rgx/IO5ApefHJF7vJsxHmJsscsnuYtReRX2iWkQ0eMcq7HFHREcyi8eW
	P3cxWioihzbZ2QZaIx1I6yn3HFWhlTI8yvwuUedlV9muqy6eGdsOjlaIb4M4F1Vd
	k/KBycTO+50TYUImSBtMVcKYSQPVe/1BF0Q9drvjhAlHsnIkzYuulSGKfeiQ0qls
	bVS8NUt9VdcAtt+IUTPsg==
X-ME-Sender: <xms:ShqYaQoVUQHXB1GSkYvQP6VOiFaYgIebVwYiHs_3NJsANFd10G7D-A>
    <xme:ShqYacqQOFJm7MUfPE8IeoRDK6udUkT0muK-CiwW_q6nw8ZBk4uqyN9jt5hIEdkJK
    6TgEEmCbj9bfL9GamJF25NRzFI98JMi7KsJLjLjNP29hYqcHrgkrw>
X-ME-Received: <xmr:ShqYaS0YrK425-W4L5PjHsyt78J1z98YNH2AIV8jHAKpKFGraLJ6kgD0Z3Uoss0cL7uzzatznP4I7ovOsGasZcmcS9vt5q2iMcDCmiJGMD4P>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvvdejleegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeffueeiudejvdekheeuvdekfeffiedvueelteekudehjeetkeegvddugfdtgfeileen
    ucevlhhushhtvghrufhiiigvpedunecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhmpdhnsggprhgtphhtthhopedvpdhmohguvgepshhmthhpohhuthdprhgtphht
    thhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepkhgrrhhthh
    hikhdrudekkeesghhmrghilhdrtghomh
X-ME-Proxy: <xmx:ShqYaTACVXStXcwwJjAkcAOa0PE1smkik3uIOfrgHCq6Xev6CwmJLQ>
    <xmx:ShqYaSeML3agXFQsu5F_gzxaq6xdmya2yYBCLuomSgcgLWfXzhXhvA>
    <xmx:ShqYaQiita2vHfLOR0DXklWCzJhn-i1t2q2QtQ3ekm9PUYyzcc7H3g>
    <xmx:ShqYaSrg3VC2quLgaKoD_O8iZHXFe5ReAwen3LC_1PUKgo8uXdBABQ>
    <xmx:ShqYaabQBK7ULMS53rA5ezGnrgd-LGIZKzcT_Z5mwPPZJJz5hoRMEy3w>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 20 Feb 2026 03:24:41 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 16fed361 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 20 Feb 2026 08:24:40 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Fri, 20 Feb 2026 09:24:10 +0100
Subject: [PATCH 06/17] refs: introduce `refs_for_each_ref_ext`
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260220-pks-refs-for-each-unification-v1-6-17170bd99de1@pks.im>
References: <20260220-pks-refs-for-each-unification-v1-0-17170bd99de1@pks.im>
In-Reply-To: <20260220-pks-refs-for-each-unification-v1-0-17170bd99de1@pks.im>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>
X-Mailer: b4 0.14.3

In the refs subsystem we have a proliferation of functions that all
iterate through references. (Almost) all of these functions internally
call `do_for_each_ref()` and provide slightly different arguments so
that one can control different aspects of its behaviour. This approach
doesn't really scale: every time there is a slightly different use case
for iterating through refs we create another new function.

This combinatorial explosion doesn't make a lot of sense: it leads to
confusing interfaces and heightens the maintenance burden.

Refactor the code to become more composable by:

  - Exposing `do_for_each_ref()` as `refs_for_each_ref_ext()`.

  - Introducing an options structure that lets the caller control
    individual options.

This gives us a much better foundation to build on going forward.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 refs.c | 78 ++++++++++++++++++++++++++++++++++++++++--------------------------
 refs.h | 29 +++++++++++++++++++++++++
 2 files changed, 77 insertions(+), 30 deletions(-)

diff --git a/refs.c b/refs.c
index a45cc61211..ec9e466381 100644
--- a/refs.c
+++ b/refs.c
@@ -1858,62 +1858,76 @@ struct ref_iterator *refs_ref_iterator_begin(
 	return iter;
 }
 
-static int do_for_each_ref(struct ref_store *refs, const char *prefix,
-			   const char **exclude_patterns,
-			   refs_for_each_cb fn, int trim,
-			   enum refs_for_each_flag flags, void *cb_data)
+int refs_for_each_ref_ext(struct ref_store *refs,
+			  refs_for_each_cb cb, void *cb_data,
+			  const struct refs_for_each_ref_options *opts)
 {
 	struct ref_iterator *iter;
 
 	if (!refs)
 		return 0;
 
-	iter = refs_ref_iterator_begin(refs, prefix, exclude_patterns, trim,
-				       flags);
+	iter = refs_ref_iterator_begin(refs, opts->prefix ? opts->prefix : "",
+				       opts->exclude_patterns,
+				       opts->trim_prefix, opts->flags);
 
-	return do_for_each_ref_iterator(iter, fn, cb_data);
+	return do_for_each_ref_iterator(iter, cb, cb_data);
 }
 
-int refs_for_each_ref(struct ref_store *refs, refs_for_each_cb fn, void *cb_data)
+int refs_for_each_ref(struct ref_store *refs, refs_for_each_cb cb, void *cb_data)
 {
-	return do_for_each_ref(refs, "", NULL, fn, 0, 0, cb_data);
+	struct refs_for_each_ref_options opts = { 0 };
+	return refs_for_each_ref_ext(refs, cb, cb_data, &opts);
 }
 
 int refs_for_each_ref_in(struct ref_store *refs, const char *prefix,
-			 refs_for_each_cb fn, void *cb_data)
+			 refs_for_each_cb cb, void *cb_data)
 {
-	return do_for_each_ref(refs, prefix, NULL, fn, strlen(prefix), 0, cb_data);
+	struct refs_for_each_ref_options opts = {
+		.prefix = prefix,
+		.trim_prefix = strlen(prefix),
+	};
+	return refs_for_each_ref_ext(refs, cb, cb_data, &opts);
 }
 
 int refs_for_each_fullref_in(struct ref_store *refs, const char *prefix,
 			     const char **exclude_patterns,
-			     refs_for_each_cb fn, void *cb_data)
+			     refs_for_each_cb cb, void *cb_data)
 {
-	return do_for_each_ref(refs, prefix, exclude_patterns, fn, 0, 0, cb_data);
+	struct refs_for_each_ref_options opts = {
+		.prefix = prefix,
+		.exclude_patterns = exclude_patterns,
+	};
+	return refs_for_each_ref_ext(refs, cb, cb_data, &opts);
 }
 
-int refs_for_each_replace_ref(struct ref_store *refs, refs_for_each_cb fn, void *cb_data)
+int refs_for_each_replace_ref(struct ref_store *refs, refs_for_each_cb cb, void *cb_data)
 {
 	const char *git_replace_ref_base = ref_namespace[NAMESPACE_REPLACE].ref;
-	return do_for_each_ref(refs, git_replace_ref_base, NULL, fn,
-			       strlen(git_replace_ref_base),
-			       REFS_FOR_EACH_INCLUDE_BROKEN, cb_data);
+	struct refs_for_each_ref_options opts = {
+		.prefix = git_replace_ref_base,
+		.trim_prefix = strlen(git_replace_ref_base),
+		.flags = REFS_FOR_EACH_INCLUDE_BROKEN,
+	};
+	return refs_for_each_ref_ext(refs, cb, cb_data, &opts);
 }
 
 int refs_for_each_namespaced_ref(struct ref_store *refs,
 				 const char **exclude_patterns,
-				 refs_for_each_cb fn, void *cb_data)
+				 refs_for_each_cb cb, void *cb_data)
 {
+	struct refs_for_each_ref_options opts = { 0 };
 	struct strvec namespaced_exclude_patterns = STRVEC_INIT;
 	struct strbuf prefix = STRBUF_INIT;
 	int ret;
 
-	exclude_patterns = get_namespaced_exclude_patterns(exclude_patterns,
-							   get_git_namespace(),
-							   &namespaced_exclude_patterns);
-
+	opts.exclude_patterns = get_namespaced_exclude_patterns(exclude_patterns,
+								get_git_namespace(),
+								&namespaced_exclude_patterns);
 	strbuf_addf(&prefix, "%srefs/", get_git_namespace());
-	ret = do_for_each_ref(refs, prefix.buf, exclude_patterns, fn, 0, 0, cb_data);
+	opts.prefix = prefix.buf;
+
+	ret = refs_for_each_ref_ext(refs, cb, cb_data, &opts);
 
 	strvec_clear(&namespaced_exclude_patterns);
 	strbuf_release(&prefix);
@@ -1926,10 +1940,13 @@ int refs_for_each_rawref(struct ref_store *refs, refs_for_each_cb fn, void *cb_d
 }
 
 int refs_for_each_rawref_in(struct ref_store *refs, const char *prefix,
-			    refs_for_each_cb fn, void *cb_data)
+			    refs_for_each_cb cb, void *cb_data)
 {
-	return do_for_each_ref(refs, prefix, NULL, fn, 0,
-			       REFS_FOR_EACH_INCLUDE_BROKEN, cb_data);
+	struct refs_for_each_ref_options opts = {
+		.prefix = prefix,
+		.flags = REFS_FOR_EACH_INCLUDE_BROKEN,
+	};
+	return refs_for_each_ref_ext(refs, cb, cb_data, &opts);
 }
 
 static int qsort_strcmp(const void *va, const void *vb)
@@ -3187,6 +3204,9 @@ int repo_migrate_ref_storage_format(struct repository *repo,
 				    struct strbuf *errbuf)
 {
 	struct ref_store *old_refs = NULL, *new_refs = NULL;
+	struct refs_for_each_ref_options for_each_ref_opts = {
+		.flags = REFS_FOR_EACH_INCLUDE_ROOT_REFS | REFS_FOR_EACH_INCLUDE_BROKEN,
+	};
 	struct ref_transaction *transaction = NULL;
 	struct strbuf new_gitdir = STRBUF_INIT;
 	struct migration_data data = {
@@ -3270,7 +3290,7 @@ int repo_migrate_ref_storage_format(struct repository *repo,
 	data.errbuf = errbuf;
 
 	/*
-	 * We need to use the internal `do_for_each_ref()` here so that we can
+	 * We need to use `refs_for_each_ref_ext()` here so that we can
 	 * also include broken refs and symrefs. These would otherwise be
 	 * skipped silently.
 	 *
@@ -3280,9 +3300,7 @@ int repo_migrate_ref_storage_format(struct repository *repo,
 	 * allow for a central lock due to its design. It's thus on the user to
 	 * ensure that there are no concurrent writes.
 	 */
-	ret = do_for_each_ref(old_refs, "", NULL, migrate_one_ref, 0,
-			      REFS_FOR_EACH_INCLUDE_ROOT_REFS | REFS_FOR_EACH_INCLUDE_BROKEN,
-			      &data);
+	ret = refs_for_each_ref_ext(old_refs, migrate_one_ref, &data, &for_each_ref_opts);
 	if (ret < 0)
 		goto done;
 
diff --git a/refs.h b/refs.h
index 5190e98b2c..bb9c64a51c 100644
--- a/refs.h
+++ b/refs.h
@@ -453,8 +453,37 @@ int refs_head_ref(struct ref_store *refs,
 int refs_head_ref_namespaced(struct ref_store *refs,
 			     refs_for_each_cb fn, void *cb_data);
 
+
+struct refs_for_each_ref_options {
+	/* Only iterate over references that have this given prefix. */
+	const char *prefix;
+
+	/*
+	 * Exclude any references that match any of these patterns on a
+	 * best-effort basis. The caller needs to be prepared for the exclude
+	 * patterns to be ignored.
+	 *
+	 * The array must be terminated with a NULL sentinel value.
+	 */
+	const char **exclude_patterns;
+
+	/*
+	 * The number of bytes to trim from the refname. Note that the trimmed
+	 * bytes must not cause the reference to become empty. As such, this
+	 * field should typically only be set when one uses a `prefix` ending
+	 * in a slash.
+	 */
+	size_t trim_prefix;
+
+	/* Flags that change which refs will be included. */
+	enum refs_for_each_flag flags;
+};
+
 int refs_for_each_ref(struct ref_store *refs,
 		      refs_for_each_cb fn, void *cb_data);
+int refs_for_each_ref_ext(struct ref_store *refs,
+			  refs_for_each_cb cb, void *cb_data,
+			  const struct refs_for_each_ref_options *opts);
 int refs_for_each_ref_in(struct ref_store *refs, const char *prefix,
 			 refs_for_each_cb fn, void *cb_data);
 int refs_for_each_tag_ref(struct ref_store *refs,

-- 
2.53.0.414.gf7e9f6c205.dirty

