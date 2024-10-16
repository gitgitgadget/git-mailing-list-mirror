Received: from fhigh-a2-smtp.messagingengine.com (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD6B8156E4
	for <git@vger.kernel.org>; Wed, 16 Oct 2024 06:00:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729058440; cv=none; b=GAcjZTAozAT2n7LWUvEQlK4U8PmLg4lYq+t5IRkHBuzt7deVNAOrbv7YvQ4Q9XhTK7Zx03AJfKebGvpxQmpQxwoewwLncAshYNaCNuVJmsGDm2JmkyuQ2iHQ0AuxoKLJ5riQZIMhhXgIxAlTHv4JnUoyZLeskgZ+8Q5DaPiKweg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729058440; c=relaxed/simple;
	bh=gSK+BrI9a8CebRtqAWTH+10ehNEQLbdR1GaduJNyWtU=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=cLRYFTqpp+07LM5UUsWhaQhR4JvXCzNp1WxngkfDn48DFcMkRJER+mQpsHDTPLLX2gtYjKwkxX9/lxJNXg2YY/HA3zAcoq68Pw7KwbHoruRyt2kjcsJH0iSySMRHpdsyCU/jCBnSTJNrc4hehH6hPAOJax6Mksmz3rFjLLuLvRg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=aMySBvfn; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=QQkvByhV; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="aMySBvfn";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="QQkvByhV"
Received: from phl-compute-07.internal (phl-compute-07.phl.internal [10.202.2.47])
	by mailfhigh.phl.internal (Postfix) with ESMTP id EB8951140092;
	Wed, 16 Oct 2024 02:00:36 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-07.internal (MEProxy); Wed, 16 Oct 2024 02:00:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to; s=fm2; t=1729058436; x=1729144836; bh=abI66jknaQ
	/2HHzBlVg8uOll+bYYs4GDvxBz8KS4w8Y=; b=aMySBvfnMPe48BbcPI1JtlCgTb
	D5gqageqtpi5KCYkX+cWgqLrYShHMDHEtTRezMDARFvixAxVA6r0aVSwTCGCDb2K
	ildaKw7CfvfMmF7HBh9rhKO99YcJ0nB7coy4afjIG+d6E6WzUma+zOAf79s+qqGU
	aNmF0qlB5m1JKJNY9o962zQApifqS+gu1nWk6SBDwOd3yO9gNCxOreqnZWamex6R
	VxE05KNVc04Uq3b80Xqj3K6V5KG9x1ntMclmfpaS5ENckzlE12U0YPEQxT30ZT20
	v2oToC8BVrXe871jcQuwyWcdahtUrvS351PNhGB6qDTMK47UmUm3LX8Jhutg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
	:x-sasl-enc; s=fm2; t=1729058436; x=1729144836; bh=abI66jknaQ/2H
	HzBlVg8uOll+bYYs4GDvxBz8KS4w8Y=; b=QQkvByhVFpCOhNM1E/TaHurgnYqUx
	zKg1zR6qERpYqWQ5cS/i1E1J7blpry8f0tPfW5CijrjHAjEnidxIP9ZAzwSsoa3E
	OVmAOwOLtBqsGcoJ+4Qrue8lJdsmVUTsXjWIN7W+yyrCtM6LTnpgFBhWvI3y5nLO
	MUksxkO+pDtW4Z2E9Ifp1VqiyTHrXMbKSQnEikmmJWw+edCROwhDfkwxIRuv+7RD
	8vzfrui40thRDK8/EkqBfJCdPhT/Zo36qq/kg7YL4MF9xOaqfpOm0wL8tb+Lg+Xa
	tVAc/W7bCZfbWQPQ0qcpGerlw43+5A/riVi42c3p4J2yPQ/OWkEk3EDww==
X-ME-Sender: <xms:hFYPZwaOai0M0jGb5loZB5SURaPy7JB1obx_KG3YwsZ_7Q46Kypmlg>
    <xme:hFYPZ7b4dXsJYwwz50-irzfSYRwp8B6_XdUuCuKsl0n4jH1sj2UQbrKfJXD5w6JMf
    6o0NVcitQ-MvbP6NA>
X-ME-Received: <xmr:hFYPZ6_B1qEJYSno-Mqv9yPzxQ3tBJTAUlw9nH6BW_XBpjzV1nb-XA00s38Xu0OTclSvp35TYmW5MV9Ts6Hmd7m6IORaWsiFlpxKPa4k-mxA_g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdegkedguddtvdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfggtggugfesthekredttddtjeen
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepfefggfdvteekleekhffgfeejieeffeefleethfdtgeev
    ffdvhefggfdtleethfehnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepfedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprh
    gtphhtthhopehvugihvgesghhithhhuhgsrdgtohhmpdhrtghpthhtohepshhtohhlvggv
    sehgmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:hFYPZ6odq24gDc5yCM7uecBDJ0B_cQvN0NAH8ib7K8X_KwyUwZtwrA>
    <xmx:hFYPZ7ohfty0ksCx0bv0Hz0KWZgSrf090DEehNfhshKxil6AcZbYag>
    <xmx:hFYPZ4QUYBi7M2AGSUWfptNsxd5BAW33VeB8HUTeBXyMKsYGczvCxA>
    <xmx:hFYPZ7rlpIehKnmDWcvIBshaCRI-eeBF2EvOUIDHA6fBqOjuda-7_Q>
    <xmx:hFYPZ6UG3amPn4tT0loaxfX5ql1h-bRI-qF97U0MtQ6f8uVhHQcbB45n>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 16 Oct 2024 02:00:35 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 3614c50c (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 16 Oct 2024 05:59:15 +0000 (UTC)
Date: Wed, 16 Oct 2024 08:00:30 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Victoria Dye <vdye@github.com>, Derrick Stolee <stolee@gmail.com>
Subject: [PATCH] ref-filter: format iteratively with lexicographic refname
 sorting
Message-ID: <a873ed828ccae426214cc8f87610df97ff9a269e.1729055871.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

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

  - The caller uses at most a single name pattern. Otherwise we'd have
    to sort results from multiple invocations of the iterator.

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

I'm honestly not quite sure whether I think that this change is fine, or
whether it is getting too fragile. I decided to send the patch anyway so
that we can discuss on the mailing list, mostly because I think that the
results speak for themselves.

Ultimately, this very much feels like a tradeoff to me.

Thanks!

Patrick

 ref-filter.c | 37 ++++++++++++++++++++++++++++++-------
 1 file changed, 30 insertions(+), 7 deletions(-)

diff --git a/ref-filter.c b/ref-filter.c
index dd195007ce1..e075ca21d8e 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -3244,10 +3244,40 @@ int filter_refs(struct ref_array *array, struct ref_filter *filter, unsigned int
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
+	 * the sorting options ask for exactly that we may be able to do
+	 * iterative formatting.
+	 */
+	if (sorting) {
+		size_t n = 0;
+
+		/*
+		 * There must be a single sorting filter that uses
+		 * lexicographic sorting of the refname.
+		 */
+		if (sorting->next ||
+		    sorting->sort_flags ||
+		    used_atom[sorting->atom].atom_type != ATOM_REFNAME)
+			return 0;
+
+		/* And there must be at most a single name pattern. */
+		while (filter->name_patterns && filter->name_patterns[n] && n < 2)
+			n++;
+		if (n > 1)
+			return 0;
+	}
+
 	/*
 	 * Filtering & formatting results within a single ref iteration
 	 * callback is not compatible with options that require
@@ -3258,7 +3288,6 @@ static inline int can_do_iterative_format(struct ref_filter *filter,
 	 */
 	return !(filter->reachable_from ||
 		 filter->unreachable_from ||
-		 sorting ||
 		 format->bases.nr ||
 		 format->is_base_tips.nr);
 }
@@ -3316,12 +3345,6 @@ static int memcasecmp(const void *vs1, const void *vs2, size_t n)
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
-- 
2.47.0.72.gef8ce8f3d4.dirty

