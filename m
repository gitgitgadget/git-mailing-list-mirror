Received: from fout-a2-smtp.messagingengine.com (fout-a2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0292A1E3DDB
	for <git@vger.kernel.org>; Mon, 21 Oct 2024 11:33:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729510413; cv=none; b=CgwYgOB4L6dWbdWTJdSAYtgk/bVCtzSWyAsesQkKTcFEBkeE50s7fN2r2pKETP/M9f/QXqL7Nl4dq7PVbTD4yB8fbyf/SSd0SI9M0J8M3lLpW2spc/C12pTtr2HB1qLPR7r2+8J+qarrhU/5JWCDYyfy+0Itr/8l7v2HdWTCgTw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729510413; c=relaxed/simple;
	bh=jRnP9pPLP08yD/LxE3NpALSlHBpoRkt/LANKzKJNvGw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gYxFQPaG1A7HCbxP5/Vntlkc3gERefc3krOzmMq+zS4ZU3g3nfFPQ6r91z0Gwjg3tbyTtS3+uFoGLVB05FYlYD8ePuYjAg6SM4XUbMvL7Vf6xa3RoPNouKgT3aARv0GMM49iPZQGeCbR0Si7NGWGj+jXQtq6wqm+3DIhwLGA3RI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=sznmykfy; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=dpj0Rjr6; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="sznmykfy";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="dpj0Rjr6"
Received: from phl-compute-11.internal (phl-compute-11.phl.internal [10.202.2.51])
	by mailfout.phl.internal (Postfix) with ESMTP id 0F86C1380689;
	Mon, 21 Oct 2024 07:33:30 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-11.internal (MEProxy); Mon, 21 Oct 2024 07:33:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1729510410;
	 x=1729596810; bh=dq1KF64K0vn6dSaFqUD1BdtpzfSGEAb2BL+N365Z9Ts=; b=
	sznmykfyOPbt2v68K5GaDHshe7pMHBa5ZNt+eFt9/ek9rDWpwma/EtJcentccptf
	L8eWotQZ8W+qdRqwPkmzXfNIPcRqmvEaCvgRJ6TKMCkFd3+A9FMzWahlZgs1z0or
	QwVWEASzs8RETr+6XcHE8Y2YVqs1477zgqRexWbhSYolMszPHnr8TFrxPnxGpQ/x
	eaPlskqXQP3TEytiNYt23j4SyLWXRWX9hQwjENOoxT3X8FBmhja//x184mwJwu5q
	s+mxUK+Y/ETp00iq4kLrmdQTE/TzmSxczsRRSAaBFLrBcNUizGCHN+5XqM0CUETp
	RBy7NYMnj4PFuRuQ1wiQcw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1729510410; x=
	1729596810; bh=dq1KF64K0vn6dSaFqUD1BdtpzfSGEAb2BL+N365Z9Ts=; b=d
	pj0Rjr6HydPKC7+oQnvWmXZ6tV5VumoBHbye902rwd9kng/8YqOkqj8/70yxphaH
	7wlOJPNCTW9mN1i85gkl0PenWxL3W3F6D4Kpo2rq5kzD0Mm5WCBDhjsit1iGS79B
	5GZk9jtM4wC16rY5mxRMzHO7KZ/r1xACgpyPlznH2aJdeHevC1yab2uxsW4KGrYn
	VTK4RGPWcOukgEzs6QxpSmnrb+qcjbofb07aEVEC2jUq/GOIpHUh0spjyzWEp4bi
	C4ucXfJmB2JJamk2pJkGa9O3v4Y/gHUPEur1NgoPSxCQApLFsHCtE35Js87uW3jK
	LzjGQO+rC89E3FOUR7RAg==
X-ME-Sender: <xms:CTwWZ4M7hhhvrh_LxvrsZXROxj-Lowo2yqMkchnS9JOmBQxwhilxPw>
    <xme:CTwWZ-8kWclk3lAN_zkwjk7A6fDorj3MbMAlsU0gGrSDfT7-ZcDLK-3xTh-2MnYFy
    gzQOc6Cj785eKvoBQ>
X-ME-Received: <xmr:CTwWZ_TL1xd1TfmkuudYZL587Ga0TQXYxmRPkCvXSrLf_KHGXpZ0IcTW5sxpPo5sf6BVTGDAHxO3GAYEfR90LIdr4v3-n8azJd8-Q_6fAFJY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdehledggedvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggugfgjsehtkeertddttdej
    necuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrih
    hmqeenucggtffrrghtthgvrhhnpedvfeejiedtteelheeiteekveeftdefvdehkedvveet
    ffdvveevjeejleegtedvgfenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmh
    grihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeegpdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopehtohhonhesihhothgtlhdrtghomhdprhgtphhtth
    hopehmvgesthhtrgihlhhorhhrrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhk
    vghrnhgvlhdrohhrghdprhgtphhtthhopehpvghffhesphgvfhhfrdhnvght
X-ME-Proxy: <xmx:CTwWZwt78unQj8o6DXSq2e8z7fus3zCybbm186HcA-KT4VUWFcKXrQ>
    <xmx:CTwWZwcKMquv34h4E_AlYs0ulbXKccKPu77JJyhBnFqgwCIvn5jhuQ>
    <xmx:CTwWZ00rq6qdE4x6fYVEg4hZhvVyeHWDoql2ZisfACXp2PMmmDHS-Q>
    <xmx:CTwWZ08vYpfT1URBLZhQ8miDVS9ArNo9jENPZjxwpCovnCpo7q0k_A>
    <xmx:CjwWZ_64ZrtYjUPY42iJxbALg854PEKKOk9nfNNa0hkmmW3aip2s9b7P>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 21 Oct 2024 07:33:28 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 2f63c2cd (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 21 Oct 2024 11:31:58 +0000 (UTC)
Date: Mon, 21 Oct 2024 13:33:23 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Taylor Blau <me@ttaylorr.com>, Jeff King <peff@peff.net>,
	Toon Claes <toon@iotcl.com>
Subject: [PATCH v3] ref-filter: format iteratively with lexicographic refname
 sorting
Message-ID: <d23c3e3ee7fdb49fcd05b4f2e52dd2a1cfdc10f2.1729510342.git.ps@pks.im>
References: <a873ed828ccae426214cc8f87610df97ff9a269e.1729055871.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <a873ed828ccae426214cc8f87610df97ff9a269e.1729055871.git.ps@pks.im>

In bd98f9774e (ref-filter.c: filter & format refs in the same callback,
2023-11-14), we have introduced logic into the ref-filter subsystem that
determines whether or not we can output references iteratively instead
of first collecting all references, post-processing them and printing
them once done. This has the advantage that we don't have to store all
refs in memory and, when used with e.g. `--count=1`, that we don't have
to read all refs in the first place.

One restriction we have in place for that is that caller must not ask
for sorted refs, because there is no way to sort the refs without first
reading them all into an array. So the benefits can only be reaped when
explicitly asking for output not to be sorted.

But there is one exception here where we _can_ get away with sorting
refs while streaming: ref backends sort references returned by their
iterators in lexicographic order. So if the following conditions are all
true we can do iterative streaming:

  - There must be at most a single sorting specification, as otherwise
    we're not using plain lexicographic ordering.

  - The sorting specification must use the "refname".

  - The sorting specification must not be using any flags, like
    case-insensitive sorting.

Now the resulting logic does feel quite fragile overall, which makes me
a bit uneasy. But after thinking about this for a while I couldn't find
any obvious gaps in my reasoning. Furthermore, given that lexicographic
sorting order is the default in git-for-each-ref(1), this is likely to
benefit a whole lot of usecases out there.

The following benchmark executes git-for-each-ref(1) in a crafted repo
with 1 million references:

  Benchmark 1: git for-each-ref (revision = HEAD~)
    Time (mean ± σ):      6.756 s ±  0.014 s    [User: 3.004 s, System: 3.541 s]
    Range (min … max):    6.738 s …  6.784 s    10 runs

  Benchmark 2: git for-each-ref (revision = HEAD)
    Time (mean ± σ):      6.479 s ±  0.017 s    [User: 2.858 s, System: 3.422 s]
    Range (min … max):    6.450 s …  6.519 s    10 runs

  Summary
    git for-each-ref (revision = HEAD)
      1.04 ± 0.00 times faster than git for-each-ref (revision = HEAD~)

The change results in a slight performance improvement, but nothing that
would really stand out. Something that cannot be seen in the benchmark
though is peak memory usage, which went from 404.5MB to 68.96kB.

A more interesting benchmark is printing a single referenence with
`--count=1`:

  Benchmark 1: git for-each-ref --count=1 (revision = HEAD~)
    Time (mean ± σ):      6.655 s ±  0.018 s    [User: 2.865 s, System: 3.576 s]
    Range (min … max):    6.630 s …  6.680 s    10 runs

  Benchmark 2: git for-each-ref --count=1 (revision = HEAD)
    Time (mean ± σ):       8.6 ms ±   1.3 ms    [User: 2.3 ms, System: 6.1 ms]
    Range (min … max):     6.7 ms …  14.4 ms    266 runs

  Summary
    git git for-each-ref --count=1 (revision = HEAD)
    770.58 ± 116.19 times faster than git for-each-ref --count=1 (revision = HEAD~)

Whereas we scaled with the number of references before, we now print the
first reference and exit immediately, which provides a massive win.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---

There's only a single change compared to v2, namely a fixup for a
now-stale comment. Thanks!

Patrick

 ref-filter.c | 29 +++++++++++++++++++++--------
 1 file changed, 21 insertions(+), 8 deletions(-)

diff --git a/ref-filter.c b/ref-filter.c
index dd195007ce1..84c60361072 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -3244,21 +3244,40 @@ int filter_refs(struct ref_array *array, struct ref_filter *filter, unsigned int
 	return ret;
 }
 
+struct ref_sorting {
+	struct ref_sorting *next;
+	int atom; /* index into used_atom array (internal) */
+	enum ref_sorting_order sort_flags;
+};
+
 static inline int can_do_iterative_format(struct ref_filter *filter,
 					  struct ref_sorting *sorting,
 					  struct ref_format *format)
 {
+	/*
+	 * Reference backends sort patterns lexicographically by refname, so if
+	 * the sorting options ask for exactly that we are able to do iterative
+	 * formatting.
+	 *
+	 * Note that we do not have to worry about multiple name patterns,
+	 * either. Those get sorted and deduplicated eventually in
+	 * `refs_for_each_fullref_in_prefixes()`, so we return names in the
+	 * correct ordering here, too.
+	 */
+	if (sorting && (sorting->next ||
+			sorting->sort_flags ||
+			used_atom[sorting->atom].atom_type != ATOM_REFNAME))
+		return 0;
+
 	/*
 	 * Filtering & formatting results within a single ref iteration
 	 * callback is not compatible with options that require
 	 * post-processing a filtered ref_array. These include:
 	 * - filtering on reachability
-	 * - sorting the filtered results
 	 * - including ahead-behind information in the formatted output
 	 */
 	return !(filter->reachable_from ||
 		 filter->unreachable_from ||
-		 sorting ||
 		 format->bases.nr ||
 		 format->is_base_tips.nr);
 }
@@ -3316,12 +3335,6 @@ static int memcasecmp(const void *vs1, const void *vs2, size_t n)
 	return 0;
 }
 
-struct ref_sorting {
-	struct ref_sorting *next;
-	int atom; /* index into used_atom array (internal) */
-	enum ref_sorting_order sort_flags;
-};
-
 static int cmp_ref_sorting(struct ref_sorting *s, struct ref_array_item *a, struct ref_array_item *b)
 {
 	struct atom_value *va, *vb;

Range-diff against v2:
1:  e0daa6a2eac ! 1:  d23c3e3ee7f ref-filter: format iteratively with lexicographic refname sorting
    @@ ref-filter.c: int filter_refs(struct ref_array *array, struct ref_filter *filter
      	/*
      	 * Filtering & formatting results within a single ref iteration
      	 * callback is not compatible with options that require
    -@@ ref-filter.c: static inline int can_do_iterative_format(struct ref_filter *filter,
    + 	 * post-processing a filtered ref_array. These include:
    + 	 * - filtering on reachability
    +-	 * - sorting the filtered results
    + 	 * - including ahead-behind information in the formatted output
      	 */
      	return !(filter->reachable_from ||
      		 filter->unreachable_from ||
-- 
2.47.0.72.gef8ce8f3d4.dirty

