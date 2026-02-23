Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A893364EB5
	for <git@vger.kernel.org>; Mon, 23 Feb 2026 12:00:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771848009; cv=none; b=IqYOdhHwk3M6wIW7sH6hsRbjBAZ7YD9F1OsCB2pQDLfI18SQmS+4M/x0rMv5E+KEHelIW4KYWxZxCJAAVTrNC1B1nxUIt8NidRLAw7o8aLCtf+DSnnz/SFOrzO8D4TPgRmZB6w3DDLng+NGHJ98t4iPrMbA/MpXawtIpcIpz+Qo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771848009; c=relaxed/simple;
	bh=n48GUEdxeLI9Cy41t+GuURlsYEtZFcadYIe45Uof7/Y=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=KLSekzAlXobBh+ilLlRcyhDeAKMYFms5JIvq6m8oMYSl/bRiLRJZBC+Z5345289aOySuhmJwHslubIzr8vWAFOXXlXdPijBOHAzh3+SFhNR0icZ6AzMJESnQcBkTEua9okYjjB6zzBi++y0DhpilmVR0QFntjRxQ0oLQY6qB3/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Y/bv4Eub; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=fExyjshL; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Y/bv4Eub";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="fExyjshL"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.phl.internal (Postfix) with ESMTP id C68B814001A3;
	Mon, 23 Feb 2026 07:00:06 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Mon, 23 Feb 2026 07:00:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1771848006;
	 x=1771934406; bh=oztD1AqmmvbPPUyEmyCO28O6JA3qiUbEut2TpofzWcw=; b=
	Y/bv4Eub+bDLtyTqM/ssFr3pmLSaA6LE2r/jAVjGAeIPurH3OPIFTRptwmX9PFQB
	mLvzcVTvZVDAa+qA7Ox98pxw6zrgyXW5zHd4SUT35n/rhw7VHDJfFJvupUvH5NAH
	esQjwHwvwm11H2RzF80FwbgqHvVYmThx37Qmy7AgsSfZCR0CdfJwhCAXtaUkNtLn
	QQbiNi3IdpCLRrXFx18+Qgu2yigFTbPSUXsiACiPYgrArEbVz+QcEnSdMOCLX56Z
	l2BVG4+G6CDcN4OHvSa3lspPIdQLShuT059vMPL2M0bolJpMXbJVlWMftyxOTAEi
	xN2P8i7l26LQ3Ae1t8eeGQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1771848006; x=
	1771934406; bh=oztD1AqmmvbPPUyEmyCO28O6JA3qiUbEut2TpofzWcw=; b=f
	ExyjshLym1u9RNVZ60uYHZLZ9Hc+s+vZxt3q2yu4ESXxGQN2m3c/iYVAivs7r7Fy
	ikSicQ6oPfe55Cs7NuTxFLSlqRlx4pRe+6g6dgK7vP3m7VFNFVvB6QpA59bOx33/
	h4X11lUB86LRORd4IdpggCwKb/76xnIzgZIol41ZToIx3tUVqBlCH0wTocv8bDNh
	qz6wXkcINdiY8nYiDZER3ppVhTZhYhmDLmAN4hNgzQy23j1MQKmXpNTyoa5Q7OrU
	jomKayy2t/gQtyXW2GXrJagm/UNAUhQKp9UwWzUm7t90QSyb1EF6+10QbNLP8DQU
	KoV29IMuZIazyXVOHZnfQ==
X-ME-Sender: <xms:RkGcaYD_9c_hoZsW17lcRb-LSAJDePgA7ZRO1kXwX_pLzowN0bGIkA>
    <xme:RkGcaR_BHMsw6Y2rfwCDfooq5s5wGn3AtQzN-jS-8COgUPb9RjJIl8Oz3ww9uxV2h
    G0IfTsSG6FEnuyWLSm2e4GfS1wUVau5-EVw7ephtsu6i-95c5B-KQ>
X-ME-Received: <xmr:RkGcaY8c0m8ciLwFQHD2UdVAoKzGKxhFnB8xHSW5wUljCKM2mcwQdw-TIkIZUAUcmZ4ecKC846cmeDgKoC_9kilGsS_hoUWLQXxyCGCnmA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvfeejudejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpefhgffgtdelteeuveeugfdvffejtdfhudetieejheekleeikedvfeelffdvieekgfen
    ucffohhmrghinhepphhrvghfihigvghsrdhnrhenucevlhhushhtvghrufhiiigvpedtne
    curfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthho
    peefpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehoshifrghlugdrsghuugguvg
    hnhhgrghgvnhesghhmgidruggvpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgv
    lhdrohhrghdprhgtphhtthhopehkrghrthhhihhkrddukeeksehgmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:RkGcaYcmvaBHWNi6-lTDsgE_DRwWC4IlGhkhcXKVbJDBrnib8h3n1w>
    <xmx:RkGcaREt_GGGzPGnrFRJcKf_rI3V75zcPOSBOKEWcnN240Kx2koMxA>
    <xmx:RkGcaWf3GZ1TG8EcfzUZvLPejW0SlMNx7OX6bUJe2USdfQuu6wCmGQ>
    <xmx:RkGcabHqGwvF4G49lB9C_Mj_HPtjgaZJy9yitUJo4uGUgGkHlfo0PA>
    <xmx:RkGcaecYSqLrQGKxf4iR5PeolERNPf7rfq151Skt9Bk7CXTlHJbxnKc5>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 23 Feb 2026 07:00:05 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 1b47b547 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 23 Feb 2026 12:00:05 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Mon, 23 Feb 2026 12:59:43 +0100
Subject: [PATCH v2 09/17] refs: generalize
 `refs_for_each_fullref_in_prefixes()`
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260223-pks-refs-for-each-unification-v2-9-515d48c8087b@pks.im>
References: <20260223-pks-refs-for-each-unification-v2-0-515d48c8087b@pks.im>
In-Reply-To: <20260223-pks-refs-for-each-unification-v2-0-515d48c8087b@pks.im>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>, 
 Oswald Buddenhagen <oswald.buddenhagen@gmx.de>
X-Mailer: b4 0.14.3

The function `refs_for_each_fullref_in_prefixes()` can be used to
iterate over all references part of any of the user-provided prefixes.
In contrast to the `prefix` parameter of `refs_for_each_ref_ext()` it
knows to handle the case well where multiple of the passed-in prefixes
start with a common prefix by computing longest common prefixes and then
iterating over those.

While we could move this logic into `refs_for_each_ref_ext()`, this one
feels somewhat special as we perform multiple iterations. But what we
_can_ do is to generalize how this function works: instead of accepting
only a small handful of parameters, we can have it accept the full
options structure.

One obvious exception is that the caller must not provide a prefix via
the options. But this case can be easily detected.

Refactor the code accordingly.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 ls-refs.c    | 11 +++++++----
 ref-filter.c | 11 +++++++----
 refs.c       | 39 +++++++++++++++------------------------
 refs.h       | 16 +++++-----------
 4 files changed, 34 insertions(+), 43 deletions(-)

diff --git a/ls-refs.c b/ls-refs.c
index 8641281b86..9759826ca7 100644
--- a/ls-refs.c
+++ b/ls-refs.c
@@ -160,6 +160,7 @@ static int ls_refs_config(const char *var, const char *value,
 
 int ls_refs(struct repository *r, struct packet_reader *request)
 {
+	struct refs_for_each_ref_options opts = { 0 };
 	struct ls_refs_data data;
 
 	memset(&data, 0, sizeof(data));
@@ -201,10 +202,12 @@ int ls_refs(struct repository *r, struct packet_reader *request)
 	send_possibly_unborn_head(&data);
 	if (!data.prefixes.nr)
 		strvec_push(&data.prefixes, "");
-	refs_for_each_fullref_in_prefixes(get_main_ref_store(r),
-					  get_git_namespace(), data.prefixes.v,
-					  hidden_refs_to_excludes(&data.hidden_refs),
-					  send_ref, &data);
+
+	opts.exclude_patterns = hidden_refs_to_excludes(&data.hidden_refs);
+	opts.namespace = get_git_namespace();
+
+	refs_for_each_ref_in_prefixes(get_main_ref_store(r), data.prefixes.v,
+				      &opts, send_ref, &data);
 	packet_fflush(stdout);
 	strvec_clear(&data.prefixes);
 	strbuf_release(&data.buf);
diff --git a/ref-filter.c b/ref-filter.c
index 049e845a19..7c682e0a33 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -2807,6 +2807,10 @@ static int for_each_fullref_in_pattern(struct ref_filter *filter,
 				       refs_for_each_cb cb,
 				       void *cb_data)
 {
+	struct refs_for_each_ref_options opts = {
+		.exclude_patterns = filter->exclude.v,
+	};
+
 	if (filter->kind & FILTER_REFS_ROOT_REFS) {
 		/* In this case, we want to print all refs including root refs. */
 		return for_each_fullref_with_seek(filter, cb, cb_data,
@@ -2836,10 +2840,9 @@ static int for_each_fullref_in_pattern(struct ref_filter *filter,
 		return for_each_fullref_with_seek(filter, cb, cb_data, 0);
 	}
 
-	return refs_for_each_fullref_in_prefixes(get_main_ref_store(the_repository),
-						 NULL, filter->name_patterns,
-						 filter->exclude.v,
-						 cb, cb_data);
+	return refs_for_each_ref_in_prefixes(get_main_ref_store(the_repository),
+					     filter->name_patterns, &opts,
+					     cb, cb_data);
 }
 
 /*
diff --git a/refs.c b/refs.c
index 0d0f0edbfb..0aa3b68dd9 100644
--- a/refs.c
+++ b/refs.c
@@ -2039,40 +2039,31 @@ static void find_longest_prefixes(struct string_list *out,
 	strbuf_release(&prefix);
 }
 
-int refs_for_each_fullref_in_prefixes(struct ref_store *ref_store,
-				      const char *namespace,
-				      const char **patterns,
-				      const char **exclude_patterns,
-				      refs_for_each_cb fn, void *cb_data)
+int refs_for_each_ref_in_prefixes(struct ref_store *ref_store,
+				  const char **prefixes,
+				  const struct refs_for_each_ref_options *opts,
+				  refs_for_each_cb cb, void *cb_data)
 {
-	struct strvec namespaced_exclude_patterns = STRVEC_INIT;
-	struct string_list prefixes = STRING_LIST_INIT_DUP;
+	struct string_list longest_prefixes = STRING_LIST_INIT_DUP;
 	struct string_list_item *prefix;
-	struct strbuf buf = STRBUF_INIT;
-	int ret = 0, namespace_len;
+	int ret = 0;
 
-	find_longest_prefixes(&prefixes, patterns);
+	if (opts->prefix)
+		BUG("refs_for_each_ref_in_prefixes called with specific prefix");
 
-	if (namespace)
-		strbuf_addstr(&buf, namespace);
-	namespace_len = buf.len;
+	find_longest_prefixes(&longest_prefixes, prefixes);
 
-	exclude_patterns = get_namespaced_exclude_patterns(exclude_patterns,
-							   namespace,
-							   &namespaced_exclude_patterns);
+	for_each_string_list_item(prefix, &longest_prefixes) {
+		struct refs_for_each_ref_options prefix_opts = *opts;
+		prefix_opts.prefix = prefix->string;
 
-	for_each_string_list_item(prefix, &prefixes) {
-		strbuf_addstr(&buf, prefix->string);
-		ret = refs_for_each_fullref_in(ref_store, buf.buf,
-					       exclude_patterns, fn, cb_data);
+		ret = refs_for_each_ref_ext(ref_store, cb, cb_data,
+					    &prefix_opts);
 		if (ret)
 			break;
-		strbuf_setlen(&buf, namespace_len);
 	}
 
-	strvec_clear(&namespaced_exclude_patterns);
-	string_list_clear(&prefixes, 0);
-	strbuf_release(&buf);
+	string_list_clear(&longest_prefixes, 0);
 	return ret;
 }
 
diff --git a/refs.h b/refs.h
index 5a5fb4e1e4..faed63aa81 100644
--- a/refs.h
+++ b/refs.h
@@ -521,19 +521,13 @@ int refs_for_each_fullref_in(struct ref_store *refs, const char *prefix,
 			     refs_for_each_cb fn, void *cb_data);
 
 /**
- * iterate all refs in "patterns" by partitioning patterns into disjoint sets
+ * Iterate all refs in "prefixes" by partitioning prefixes into disjoint sets
  * and iterating the longest-common prefix of each set.
- *
- * references matching any pattern in "exclude_patterns" are omitted from the
- * result set on a best-effort basis.
- *
- * callers should be prepared to ignore references that they did not ask for.
  */
-int refs_for_each_fullref_in_prefixes(struct ref_store *refs,
-				      const char *namespace,
-				      const char **patterns,
-				      const char **exclude_patterns,
-				      refs_for_each_cb fn, void *cb_data);
+int refs_for_each_ref_in_prefixes(struct ref_store *refs,
+				  const char **prefixes,
+				  const struct refs_for_each_ref_options *opts,
+				  refs_for_each_cb cb, void *cb_data);
 
 /* iterates all refs that match the specified glob pattern. */
 int refs_for_each_glob_ref(struct ref_store *refs, refs_for_each_cb fn,

-- 
2.53.0.536.g309c995771.dirty

