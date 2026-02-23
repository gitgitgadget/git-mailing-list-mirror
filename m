Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26E7135B64E
	for <git@vger.kernel.org>; Mon, 23 Feb 2026 11:59:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771848000; cv=none; b=ni76BZwbR9W8i4LC/9nOEoe19aHIZWV94YKL83gpwyh8f9oknTKXqgHUurpFJVNRBAH7R02kTMfBQ28Prp/DTmYZ9O3pW1ILbS3GpYwgMwZkjdxv4Mu+qcJvcHUC/iAwMCCGkkfdF/LQoaw0GHDyJzxwkY9Qa1iH/6QJGsaBLd8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771848000; c=relaxed/simple;
	bh=z4eNgeoLn1J7s6UXwQ2PVIeZOiucSdbGpEqMwchWesg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ZFc3N+V7waUonvl/nReuvwqF4NdyW6HcnHb6iwcjNCsYf5wHKWjrL8us950WGpTWbCEXvNlO4rhEsGHw7H7TvGr1Hdf3368yqMDJAnR/bY6DIipkGuUcSZ/6S2Ct3TR5ZHiu/uKW+QK2KHz1XlBvGWzwwqMVZEDeRfVnoPsCVMM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=DT4hioUg; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=a+rkAAmd; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="DT4hioUg";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="a+rkAAmd"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 5CAD9140019B;
	Mon, 23 Feb 2026 06:59:58 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Mon, 23 Feb 2026 06:59:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1771847998;
	 x=1771934398; bh=LR/WO5Rz06brezWPNGpv2EbrKTpjzQv6L6wE2IHk0LA=; b=
	DT4hioUg9TesYtLhCMB8Ckv+HY8bpwIXd/6xYjM4PKEe/9EMLmPLmUZi3/1Y3RUi
	4MrukaP3YZJZM94S3dsZBmGRT+DSVfwh+DAfeysML7919oLm64N509QaY48dQK0q
	KI1SKNmbnukJvoMZiIJiD8fkAnNXbsYzpwW34ofMTlONScTkMLKaR+31T9kZyKZB
	iXe6lcQ/LhV0orD9N24J/hP5C2Bw+RoA2APUj7iL52S//Am2Oxvnoz9FUT/jE8vG
	l3lv71xgrtse+TsJOGP34D2kEwVfGDXY6aerntHsan1mj1+pviMcD7NqumN0HiuY
	aMzzHvKez2A0eZXYVTJopA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1771847998; x=
	1771934398; bh=LR/WO5Rz06brezWPNGpv2EbrKTpjzQv6L6wE2IHk0LA=; b=a
	+rkAAmdthbi+7jidf4cJFbDzmK2tK2xcTTH5ZiqZZMrU0Bw5wiJhheg3MN8irVA8
	REf1XSZNweez/AfzfDXHeUS3SH6SjT5vka1/B5r339XZ2OUwkjwzLqdTvsgnujuM
	02blESQPMT9+UcMAWEab8wiGCu1KqzGwDmgqBHM8QAEoAdkQBPav/L+xplU+JGRu
	ZE6OvTnsGB8F1JM4Jf6+6gqayq7WUp9NtyPjtPcGtjKPRXYHCOzLeqe0tEWER4We
	zXXZxoVwHpJLZAQlO+FMdrR7p8uh0eHnMyEzvVUUi8Dm1Ic9uxN7gnRZn6HSRD5X
	VnCp4cvriiySEYU6wQCPA==
X-ME-Sender: <xms:PkGcafCKnY-YTggyEg2D3rBwe4zhiKuEcTyHfbnkGb960HfkdWYW5w>
    <xme:PkGcac-_-ZfYwx15sS-7ad7dJjBGiL0DtjAQ1tCSWzORRJdQ5E5egkfHamS20cWe9
    aFOdOCInkD1pQsbgmPi6wgwVezHM0_5dIww6VsTBOTAiYvf-U7t>
X-ME-Received: <xmr:PkGcaX-t_KAsJTFHpyvnTI3ro-EMw6yjPCdvhsb4D0CW1X4jyUsT1fmWMzY4Wm7gnq5yZ72kx0dH_bYjjFVEXr-QXdfG7QRcryhNi5hPig>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvfeejudejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeffueeiudejvdekheeuvdekfeffiedvueelteekudehjeetkeegvddugfdtgfeileen
    ucevlhhushhtvghrufhiiigvpedunecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhmpdhnsggprhgtphhtthhopeefpdhmohguvgepshhmthhpohhuthdprhgtphht
    thhopehoshifrghlugdrsghuugguvghnhhgrghgvnhesghhmgidruggvpdhrtghpthhtoh
    epkhgrrhhthhhikhdrudekkeesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehv
    ghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:PkGcabd8VItiEjvXmVcChNB-RSgDwu3rTmhmaogkKNxQq7feW7xZ6w>
    <xmx:PkGcaYH_GlCTUP47VEExIZNei1H4ejarblGwMm_NQoRTDxm6gHQEBQ>
    <xmx:PkGcaRcxitBKyrh74YKqy9MhQthZbA7YuRESUSXwtDkB3GqZ2rBuDw>
    <xmx:PkGcaaGa-JPbzj-HwpD4Pgj7WMHilLGDb3rV1i5ro0jQmy98qxciQA>
    <xmx:PkGcaZdO8cYt9fJbmcDZDyX6SUvjHSsHCSRdcxq_0BvFLGigN38Ebt8m>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 23 Feb 2026 06:59:57 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 3199b90d (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 23 Feb 2026 11:59:56 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Mon, 23 Feb 2026 12:59:40 +0100
Subject: [PATCH v2 06/17] refs: introduce `refs_for_each_ref_ext`
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260223-pks-refs-for-each-unification-v2-6-515d48c8087b@pks.im>
References: <20260223-pks-refs-for-each-unification-v2-0-515d48c8087b@pks.im>
In-Reply-To: <20260223-pks-refs-for-each-unification-v2-0-515d48c8087b@pks.im>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>, 
 Oswald Buddenhagen <oswald.buddenhagen@gmx.de>
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
2.53.0.536.g309c995771.dirty

