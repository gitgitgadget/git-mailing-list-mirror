Received: from fout-a3-smtp.messagingengine.com (fout-a3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49F61259C
	for <git@vger.kernel.org>; Thu, 17 Oct 2024 05:09:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729141800; cv=none; b=Fx5Wh3FJctfCqabaPFq+Kq/4c10Djwmp5zVfrWDF5U9oJMwXdVimiwYiTvjUx3SHpuN+yaLa9+87egT2307CU8EORSQRIKLZYR8tLapLjD/SnwIu4Kg0ZMeHBApYhHbpczZX0+y11iGjij423bcJYni9RgeLkLLhiIUqIMZ/Dcw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729141800; c=relaxed/simple;
	bh=OkMdvKWAbOokzU0CnLo/lAXUQoF3O3JILdZg06S+5Y0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XvhLIAIgIes+Jfc13IJo/xBhfLLrEcG7FVuRQu6l24FmvbSM4S8S+fnFvrfQSEvs4AVG+CZW4OK5zTiFzEDMypHZG0P6A/q48a6J7mlcidkK7BdGCtKhWkBR06XwYp6gJwOUeDgrWV20AJFAb9KErNiVQyHzyf/wChFBuML/kPs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=PC62n+fV; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=n+lPrNVa; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="PC62n+fV";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="n+lPrNVa"
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfout.phl.internal (Postfix) with ESMTP id 35F1E13801F7;
	Thu, 17 Oct 2024 01:09:56 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Thu, 17 Oct 2024 01:09:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1729141796;
	 x=1729228196; bh=ql7UPeMvBbpD78xEEPHOJVvBvkyV6PbTPwHvIdUH7cQ=; b=
	PC62n+fVxIIjyr27lHH97mKkfcYNVlJPCzZHHgHr+8LkyAPwi39/a6WLG6DapGPI
	apXWvTelOq9xYLRWnO4/fulvLeCUE563NfhWs22qpRGaP3CcAzEa5yOcXjRHT5G/
	7JkR5tVr9uQg0yNnhCbdQi/VLjS5KjqnbFUte6NyGZaUc5hkugZemLE0k6QBgzI4
	GxrgJLBgU4t6fjOpI4dmUHcWFdh25DcmAae6ml09NdeQ9U4uTvmTyQVdkSxQOw5I
	R0eWQcZMiP6S/HKWohZnSJHDyYd0fFYQHlnCFQpE9pyxf5JCQClMv4Nsgk5NE1CD
	yrUyFoOrn8mlg8YElywz3Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1729141796; x=
	1729228196; bh=ql7UPeMvBbpD78xEEPHOJVvBvkyV6PbTPwHvIdUH7cQ=; b=n
	+lPrNVa4GML/+0u4xAQ6gf2nXJmUMBT9N0AQ8eI0T56fxAdfjPdUVObL9lee5//+
	AUM63ldOj6OY2eNtgBNXBLk1gSPGIipnzT2jUYr6/TGEz+Dsw0KcAwUOzWnV86xc
	yrq0C2Q1gVd8NN5P43HIDXQbPPxyf7DurnVVXwSK11V/G7HhzE98yppc1ctJ4cuA
	tFnERfU/hyxWv5+QQgAsB1DFlhr/MHAaxLO9Hc7D0p1+oelYeRLepBCYfPR45Av/
	UzGJoK3G+9GL4OGlBCGAERZUVTGynE0MVJOUZ/wYfCsVqPgsN7rtJNuSYJKYI7K7
	/zR4IQlwWFgd7RbXy6ZjA==
X-ME-Sender: <xms:I5wQZ70QwFwLQOjoJPXoPlPVKmgzV8W9G3nhLtlPwAO3ePLXUuuMdg>
    <xme:I5wQZ6EKA6ldGCCIQsR4FELvXJR6Ms483_pkxnmswzeH0M5ZW-pgJQN1NpFECxQsr
    rubbF98_d2ydCCxJg>
X-ME-Received: <xmr:I5wQZ76EpBMsyJ7Cq6WOCy6tQ-oqSqoe7xQlyptAyeB1SkArQI2-YHDOtqZcVF1DlGHjI-tjYPQsr1OIaKwjWnprCZ-hSUiCjNFFEBBhJbFpBA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdehtddgleduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvve
    fukfhfgggtugfgjgesthekredttddtjeenucfhrhhomheprfgrthhrihgtkhcuufhtvghi
    nhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnhepvdefjeeitd
    etleehieetkeevfedtfedvheekvdevteffvdevveejjeelgeetvdfgnecuvehluhhsthgv
    rhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnh
    gspghrtghpthhtohepfedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepmhgvseht
    thgrhihlohhrrhdrtghomhdprhgtphhtthhopehpvghffhesphgvfhhfrdhnvghtpdhrtg
    hpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:JJwQZw2lWpRpi7_bStldd09iaREeuWgOtnWqtrC5kLbEvfn9GZDYBQ>
    <xmx:JJwQZ-G4IUXB2vP28OdVXqkiS9v7Li3FtOFeQBvc-agviEBFkMywdw>
    <xmx:JJwQZx96yMn_Dc27qlUSbm24YgZe2hlBEs2LQ_yBU8IlBBcfz41MNg>
    <xmx:JJwQZ7lqRfEe8_VlbJQ4HV66ZM5KAVSOZpXHF4fZqs43X75M_X4zzA>
    <xmx:JJwQZ6Bk1FMrtSR9hrCi2JrQKjU2p24bMcR7H5nHYB_uj1i8rF71s0dz>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 17 Oct 2024 01:09:55 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 34cf2c10 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 17 Oct 2024 05:08:34 +0000 (UTC)
Date: Thu, 17 Oct 2024 07:09:51 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Taylor Blau <me@ttaylorr.com>, Jeff King <peff@peff.net>
Subject: [PATCH v2] ref-filter: format iteratively with lexicographic refname
 sorting
Message-ID: <e0daa6a2eac97c2b18a53399b7c124fc8d3d238d.1729141657.git.ps@pks.im>
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

There's only a single change compared to v1, namely that we don't
disable the optimization with multiple name patterns anymore. See also
the range-diff at the end.

Thanks!

Patrick

 ref-filter.c | 28 +++++++++++++++++++++-------
 1 file changed, 21 insertions(+), 7 deletions(-)

diff --git a/ref-filter.c b/ref-filter.c
index dd195007ce1..424a9cb50ae 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -3244,10 +3244,31 @@ int filter_refs(struct ref_array *array, struct ref_filter *filter, unsigned int
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
@@ -3258,7 +3279,6 @@ static inline int can_do_iterative_format(struct ref_filter *filter,
 	 */
 	return !(filter->reachable_from ||
 		 filter->unreachable_from ||
-		 sorting ||
 		 format->bases.nr ||
 		 format->is_base_tips.nr);
 }
@@ -3316,12 +3336,6 @@ static int memcasecmp(const void *vs1, const void *vs2, size_t n)
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

Range-diff against v1:
1:  93e0b80c990 ! 1:  e0daa6a2eac ref-filter: format iteratively with lexicographic refname sorting
    @@ Commit message
         iterators in lexicographic order. So if the following conditions are all
         true we can do iterative streaming:
     
    -      - The caller uses at most a single name pattern. Otherwise we'd have
    -        to sort results from multiple invocations of the iterator.
    -
           - There must be at most a single sorting specification, as otherwise
             we're not using plain lexicographic ordering.
     
    @@ ref-filter.c: int filter_refs(struct ref_array *array, struct ref_filter *filter
      {
     +	/*
     +	 * Reference backends sort patterns lexicographically by refname, so if
    -+	 * the sorting options ask for exactly that we may be able to do
    -+	 * iterative formatting.
    ++	 * the sorting options ask for exactly that we are able to do iterative
    ++	 * formatting.
    ++	 *
    ++	 * Note that we do not have to worry about multiple name patterns,
    ++	 * either. Those get sorted and deduplicated eventually in
    ++	 * `refs_for_each_fullref_in_prefixes()`, so we return names in the
    ++	 * correct ordering here, too.
     +	 */
    -+	if (sorting) {
    -+		size_t n = 0;
    -+
    -+		/*
    -+		 * There must be a single sorting filter that uses
    -+		 * lexicographic sorting of the refname.
    -+		 */
    -+		if (sorting->next ||
    -+		    sorting->sort_flags ||
    -+		    used_atom[sorting->atom].atom_type != ATOM_REFNAME)
    -+			return 0;
    -+
    -+		/* And there must be at most a single name pattern. */
    -+		while (filter->name_patterns && filter->name_patterns[n] && n < 2)
    -+			n++;
    -+		if (n > 1)
    -+			return 0;
    -+	}
    ++	if (sorting && (sorting->next ||
    ++			sorting->sort_flags ||
    ++			used_atom[sorting->atom].atom_type != ATOM_REFNAME))
    ++		return 0;
     +
      	/*
      	 * Filtering & formatting results within a single ref iteration
-- 
2.47.0.72.gef8ce8f3d4.dirty

