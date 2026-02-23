Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED483364EB2
	for <git@vger.kernel.org>; Mon, 23 Feb 2026 12:00:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771848006; cv=none; b=RibxjiAo6pqNKuQjf+6ZtYrcMSDUtep3aH1t1BH2z0qYuHZqFKWswLngGpgSRiXzz/jl1Xvf9XIke2x19P/m1cwx8vSF67ndjBSvHoWyMxnNEJdcjFVvOhK0DiHwODSsuXojTSsxPBB8+mJ9HWbIasdYJqn2+PlyEE6E2q/QOno=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771848006; c=relaxed/simple;
	bh=u0em2hh/rcRSCK5tTMHrqNPsTxrzsbHGhtzpzJv6yVA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=DljT8zlVL0Wpt02vZd/JufBNtByTD+JNWaf2HGlUpNYxxLplVJcn5MNxlCnTPQcBS1h53uDd60tRMz9HVNJhOgba7JUjR+tKwu64lNDRByydblEw5BlvHugwAs4LC+hMZDMlfG3fsi89dNZFN6YJbYKxpiegcgKZYsgoNeZF4A8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=eCl6rImN; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=lZFiAPji; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="eCl6rImN";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="lZFiAPji"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id F034E140019C;
	Mon, 23 Feb 2026 07:00:02 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Mon, 23 Feb 2026 07:00:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1771848002;
	 x=1771934402; bh=j2h8ZpZ58xuJRv5hpVPpFfIJHnp2bHZFRvBFJcZpscs=; b=
	eCl6rImNpkAzTLMslz8fM1n047NgjmrMPPD/g+WLwqKaCH0c+nmMkkDimc0GpYMQ
	h63XPrQQJODRysTMJoIjY4+25R+qba8AxtCanHqyahz/I1w2iCWYMuXjNyFAf8LB
	3wEDMgUPxhmDYVlyprNVdFtqogjx7K7OiWpbx6hU2WwOTAOHvhm2XN/5D4pRIP2s
	u/KFGOmnZeERKJ9uAnwIzu2H4x1rQ3wOAmRaoUA1sUMdhTzeN5DbdnjW138JszvK
	+l6U8jDhLtX2ao7+k8QgyKqKI1F7fjuHtKUF8QKitzs7K7U2r92UpgkLHFPM89xs
	mX2KS+Xn2MkeWRTFePDAlg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1771848002; x=
	1771934402; bh=j2h8ZpZ58xuJRv5hpVPpFfIJHnp2bHZFRvBFJcZpscs=; b=l
	ZFiAPjitYQK2lVXf5E90c5kEBoOyUu6H/CsnQhHIM1i1AVjKZ5EEIUXUmYryfBK0
	VwGECtZxm43pFNiCLRQE9SWJgL+YOUhdyO3nf3lOiA6xU7LF/x2jqvUIbRycOOKe
	qjx6Wfd6TF2Z1Rl0yFhAwc5A1xDRVSxvOqnlnDrtVRsqD1YZ6F9CoaPoojAY+tg7
	CUN5qcwrPu6rBnZx82PMNG00Cz4QsV44Sl06HaRlfuc8xHqIg9eS8fpxXGFgTbPG
	HAZ8JnQrDTK0zNIXjzqY1HXT2kSQYr29lZLwVFH0w4M6Ql6hklukwgaK2dfoXNr2
	8Wwuuqo1g0eyctB9lMW4g==
X-ME-Sender: <xms:QkGcaWpePS1DBhL2GicqjXa7_pjiryT3u22XoL8Yw-S5wM-tpwxd-A>
    <xme:QkGcacFmfg12JVeh4TMKGgeVmwGPbOzGyYv67go898MYKt-8yet8YXeph9C6UWz0s
    AK2zLHEa8M3K1eCRZ4deshqjyXqY6xnqT0s2yE-KPiQCJRrfdIfKw>
X-ME-Received: <xmr:QkGcaYkujZsjVZek1wGPFVrPY0_ynTu_l_YFLutP4W98BTno-aHC6opdwUKHUZl_pzvFHiYi8hfNj5uPxC7wEHj45JO6JkbnsKwQYKbmMw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvfeejudejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephfffufggtgfgkfhfjgfvvefosehtkeertdertdejnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeefhfeugeelheefjeektdffhedvhfdvteefgfdtudffudevveetgeeuuedtkefhgeen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhmpdhnsggprhgtphhtthhopeefpdhmohguvgepshhmthhpohhuthdprhgtphht
    thhopehoshifrghlugdrsghuugguvghnhhgrghgvnhesghhmgidruggvpdhrtghpthhtoh
    epghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehkrghrthhhihhk
    rddukeeksehgmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:QkGcaflpArDz-BMvUfELeWBcb61y-I6mpN1Pgv3rLnRslJx_ldomzg>
    <xmx:QkGcaZtQKiaPtbUQFRGE8rKG1eW6Ij0ZgNjQZO5ZPRLIxUvYHJIupQ>
    <xmx:QkGcaSkV5QejYFHf4lBgoQQfwy_u_7RJfgWVgb-GdrwTf2STGp_5zA>
    <xmx:QkGcaUviK6tnPWCDTS3rj_dXvTutV-NZKS8WhvehF56UbmjQvxfOug>
    <xmx:QkGcaSk9-VPrpTIrpQ1ebaMD4QcveUSjY3j5ELzA6nGoQ6J0Vu5-i7Zs>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 23 Feb 2026 07:00:00 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id d2f705f7 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 23 Feb 2026 11:59:59 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Mon, 23 Feb 2026 12:59:41 +0100
Subject: [PATCH v2 07/17] refs: speed up `refs_for_each_glob_ref_in()`
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260223-pks-refs-for-each-unification-v2-7-515d48c8087b@pks.im>
References: <20260223-pks-refs-for-each-unification-v2-0-515d48c8087b@pks.im>
In-Reply-To: <20260223-pks-refs-for-each-unification-v2-0-515d48c8087b@pks.im>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>, 
 Oswald Buddenhagen <oswald.buddenhagen@gmx.de>
X-Mailer: b4 0.14.3

The function `refs_for_each_glob_ref_in()` can be used to iterate
through all refs in a specific prefix with globbing. The logic to handle
this is currently hosted by `refs_for_each_glob_ref_in()`, which sets up
a callback function that knows to filter out refs that _don't_ match the
given globbing pattern.

The way we do this is somewhat inefficient though: even though the
function is expected to only yield refs in the given prefix, we still
end up iterating through _all_ references, regardless of whether or not
their name matches the given prefix.

Extend `refs_for_each_ref_ext()` so that it can handle patterns and
adapt `refs_for_each_glob_ref_in()` to use it. This means we continue to
use the same callback-based infrastructure to filter individual refs via
the globbing pattern, but we can now also use the other functionality of
the `_ext()` variant.

Most importantly, this means that we now properly handle the prefix.
This results in a performance improvement when using a prefix where a
significant majority of refs exists outside of the prefix. The following
benchmark is an extreme case, with 1 million refs that exist outside the
prefix and a single ref that exists inside it:

    Benchmark 1: git rev-parse --branches=refs/heads/* (rev = HEAD~)
      Time (mean ± σ):     115.9 ms ±   0.7 ms    [User: 113.0 ms, System: 2.4 ms]
      Range (min … max):   114.9 ms … 117.8 ms    25 runs

    Benchmark 2: git rev-parse --branches=refs/heads/* (rev = HEAD)
      Time (mean ± σ):       1.1 ms ±   0.1 ms    [User: 0.3 ms, System: 0.7 ms]
      Range (min … max):     1.0 ms …   2.3 ms    2092 runs

    Summary
      git rev-parse --branches=refs/heads/* (rev = HEAD) ran
      107.01 ± 6.49 times faster than git rev-parse --branches=refs/heads/* (rev = HEAD~)

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 refs.c | 87 +++++++++++++++++++++++++++++++++++++++++-------------------------
 refs.h | 10 ++++++++
 2 files changed, 64 insertions(+), 33 deletions(-)

diff --git a/refs.c b/refs.c
index ec9e466381..e4402d787f 100644
--- a/refs.c
+++ b/refs.c
@@ -444,7 +444,7 @@ char *refs_resolve_refdup(struct ref_store *refs,
 /* The argument to for_each_filter_refs */
 struct for_each_ref_filter {
 	const char *pattern;
-	const char *prefix;
+	size_t trim_prefix;
 	refs_for_each_cb *fn;
 	void *cb_data;
 };
@@ -475,9 +475,11 @@ static int for_each_filter_refs(const struct reference *ref, void *data)
 
 	if (wildmatch(filter->pattern, ref->name, 0))
 		return 0;
-	if (filter->prefix) {
+	if (filter->trim_prefix) {
 		struct reference skipped = *ref;
-		skip_prefix(skipped.name, filter->prefix, &skipped.name);
+		if (strlen(skipped.name) <= filter->trim_prefix)
+			BUG("attempt to trim too many characters");
+		skipped.name += filter->trim_prefix;
 		return filter->fn(&skipped, filter->cb_data);
 	} else {
 		return filter->fn(ref, filter->cb_data);
@@ -590,40 +592,24 @@ void normalize_glob_ref(struct string_list_item *item, const char *prefix,
 	strbuf_release(&normalized_pattern);
 }
 
-int refs_for_each_glob_ref_in(struct ref_store *refs, refs_for_each_cb fn,
+int refs_for_each_glob_ref_in(struct ref_store *refs, refs_for_each_cb cb,
 			      const char *pattern, const char *prefix, void *cb_data)
 {
-	struct strbuf real_pattern = STRBUF_INIT;
-	struct for_each_ref_filter filter;
-	int ret;
-
-	if (!prefix && !starts_with(pattern, "refs/"))
-		strbuf_addstr(&real_pattern, "refs/");
-	else if (prefix)
-		strbuf_addstr(&real_pattern, prefix);
-	strbuf_addstr(&real_pattern, pattern);
-
-	if (!has_glob_specials(pattern)) {
-		/* Append implied '/' '*' if not present. */
-		strbuf_complete(&real_pattern, '/');
-		/* No need to check for '*', there is none. */
-		strbuf_addch(&real_pattern, '*');
-	}
-
-	filter.pattern = real_pattern.buf;
-	filter.prefix = prefix;
-	filter.fn = fn;
-	filter.cb_data = cb_data;
-	ret = refs_for_each_ref(refs, for_each_filter_refs, &filter);
-
-	strbuf_release(&real_pattern);
-	return ret;
+	struct refs_for_each_ref_options opts = {
+		.pattern = pattern,
+		.prefix = prefix,
+		.trim_prefix = prefix ? strlen(prefix) : 0,
+	};
+	return refs_for_each_ref_ext(refs, cb, cb_data, &opts);
 }
 
-int refs_for_each_glob_ref(struct ref_store *refs, refs_for_each_cb fn,
+int refs_for_each_glob_ref(struct ref_store *refs, refs_for_each_cb cb,
 			   const char *pattern, void *cb_data)
 {
-	return refs_for_each_glob_ref_in(refs, fn, pattern, NULL, cb_data);
+	struct refs_for_each_ref_options opts = {
+		.pattern = pattern,
+	};
+	return refs_for_each_ref_ext(refs, cb, cb_data, &opts);
 }
 
 const char *prettify_refname(const char *name)
@@ -1862,16 +1848,51 @@ int refs_for_each_ref_ext(struct ref_store *refs,
 			  refs_for_each_cb cb, void *cb_data,
 			  const struct refs_for_each_ref_options *opts)
 {
+	struct strbuf real_pattern = STRBUF_INIT;
+	struct for_each_ref_filter filter;
 	struct ref_iterator *iter;
+	size_t trim_prefix = opts->trim_prefix;
+	int ret;
 
 	if (!refs)
 		return 0;
 
+	if (opts->pattern) {
+		if (!opts->prefix && !starts_with(opts->pattern, "refs/"))
+			strbuf_addstr(&real_pattern, "refs/");
+		else if (opts->prefix)
+			strbuf_addstr(&real_pattern, opts->prefix);
+		strbuf_addstr(&real_pattern, opts->pattern);
+
+		if (!has_glob_specials(opts->pattern)) {
+			/* Append implied '/' '*' if not present. */
+			strbuf_complete(&real_pattern, '/');
+			/* No need to check for '*', there is none. */
+			strbuf_addch(&real_pattern, '*');
+		}
+
+		filter.pattern = real_pattern.buf;
+		filter.trim_prefix = opts->trim_prefix;
+		filter.fn = cb;
+		filter.cb_data = cb_data;
+
+		/*
+		 * We need to trim the prefix in the callback function as the
+		 * pattern is expected to match on the full refname.
+		 */
+		trim_prefix = 0;
+
+		cb = for_each_filter_refs;
+		cb_data = &filter;
+	}
+
 	iter = refs_ref_iterator_begin(refs, opts->prefix ? opts->prefix : "",
 				       opts->exclude_patterns,
-				       opts->trim_prefix, opts->flags);
+				       trim_prefix, opts->flags);
 
-	return do_for_each_ref_iterator(iter, cb, cb_data);
+	ret = do_for_each_ref_iterator(iter, cb, cb_data);
+	strbuf_release(&real_pattern);
+	return ret;
 }
 
 int refs_for_each_ref(struct ref_store *refs, refs_for_each_cb cb, void *cb_data)
diff --git a/refs.h b/refs.h
index bb9c64a51c..a66dbf3865 100644
--- a/refs.h
+++ b/refs.h
@@ -458,6 +458,16 @@ struct refs_for_each_ref_options {
 	/* Only iterate over references that have this given prefix. */
 	const char *prefix;
 
+	/*
+	 * A globbing pattern that can be used to only yield refs that match.
+	 * If given, refs will be matched against the pattern with
+	 * `wildmatch()`.
+	 *
+	 * If the pattern doesn't contain any globbing characters then it is
+	 * treated as if it was ending with "/" and "*".
+	 */
+	const char *pattern;
+
 	/*
 	 * Exclude any references that match any of these patterns on a
 	 * best-effort basis. The caller needs to be prepared for the exclude

-- 
2.53.0.536.g309c995771.dirty

