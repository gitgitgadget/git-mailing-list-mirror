Received: from wfhigh7-smtp.messagingengine.com (wfhigh7-smtp.messagingengine.com [64.147.123.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50D761DFCE
	for <git@vger.kernel.org>; Mon,  6 May 2024 11:53:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714996389; cv=none; b=ilTJUBfy/6xLS2OYm1wejGjJctUB9nz+fMIHxT+7uWQqW1gY60NOFvMiFVLoS4lhTVPD7fM1e9UuAuBeMTyikUXHwubLR3CPW91UMHjg5tcNO9QN4Jh5tWjFxcyEEofvLKC7BnA32Y5TfISdqCnETyJWXJOAdDPSkLdgkU4XVkY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714996389; c=relaxed/simple;
	bh=8w8HVQCrtcBZPGCoSmo+TCRNcOnz5X///Hn9etR2aFc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XEaXgOOwZe9osCq4eZttC48dtuv9RGW7Lz3GsiOPZnVSrWGLoKexeyqPLKk5eGmd9n3z8YgUs7GoaKUKDuVLif2Gp10antjfeokQOtYf6F++jYP3wkos9u3zddY1ft3jNbzhfCZwDEwpA7c5f9pNFLMXRQgxxAM/TdweBIdltfk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=VVTkyckR; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ULrGCHiq; arc=none smtp.client-ip=64.147.123.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="VVTkyckR";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ULrGCHiq"
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailfhigh.west.internal (Postfix) with ESMTP id 3E3AD180010A;
	Mon,  6 May 2024 07:53:06 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Mon, 06 May 2024 07:53:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1714996385; x=1715082785; bh=8H5m7sXK6M
	3PnEUaIgMKrERezai/U32igj9JVHKDSmg=; b=VVTkyckRqh/1U2lgCp4MVtUmW5
	ypGY215uvS4FRrL1kDgaw89SdkJYPXfJDb6bVQEHeAflIBi3teR2LgcIrBtaE2Hd
	KsNfKuGzC5kqwrOffS5MBXP7bzEFYJrG8KvmQDqyGqZAG9EbSWUddQMH1LAIaEb6
	+I/p1eTB+MNU/0y5XyPS9QnbLtcPoGxFGi9B6uj579IwN1nB7T/AnzrlOURuYnKr
	2NXX2SWb4Jdh8LpkSssAwoSdDIBTboCMF9QMSh5R7no1F/xa/Khfj1VrkFUbtaNW
	6PDCLbnWJcWGOGe564lrRYcay9TQnfiO+Sl1kgjvAhIJXxsLJdDvmDXSjgww==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1714996385; x=1715082785; bh=8H5m7sXK6M3PnEUaIgMKrERezai/
	U32igj9JVHKDSmg=; b=ULrGCHiq3Qn+MFQGXocYLVw1smmM8pOCZNb+lRRrc0zK
	afhHNWoAcTkac5iUR2oW4u9F/GJPo0/N1k0m+4t6QyE8Ufn3GNLVjoJtH/t02dN8
	sKOiIir7NXTWugGMSJr3K0l/VPxLZACucN81ny8W/D1PX1oCZWcWeegGd8TBcYtq
	+y2DtePDlo9o2rYNupYl+sG/nVotXNab26U4XHm/QFCZYe0Q7hpmTDxOCA1QmtLT
	FYjb3iwwOXjA79IWNa49E1Su0RvR1Q9yBTZN0dDn5krufdjKgwRJEMh/S1Uq/PS5
	wPUaPTtfUhoGRzlBRtd30d1QxvUd/g1vkJ1KG1Tg/A==
X-ME-Sender: <xms:ocQ4ZlVbiuWwl12vI5unTUlLTLgNMkLeWwLRdeVGgCaD0rzNlbOsZA>
    <xme:ocQ4ZlldSTpB0blUZrsMU6NcKFfeMGbFpc4008G0K-6dJFlYq_Ng9QA3oNgyKFf8y
    7ghDA_0Ka24QVCKYg>
X-ME-Received: <xmr:ocQ4ZhYNh-5gK7kg7fwOyXPNZ2AVWptQroFJXxLMwakVnaUQYYubrKLrx2GFgCpHCiA9N7EY7OlPmuV3aLAB8pogqX-I6tC_nuE6VJZ461V9w-_T>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvddviedggeehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepueektdevtdffveeljeetgfehheeigeekleduvdeffeeghefgledttdehjeelffet
    necuvehluhhsthgvrhfuihiivgepudenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimh
X-ME-Proxy: <xmx:ocQ4ZoXCbU4gvESjgtVfykx0COrGIaySIsZNmt83Bw_SBdCrZ5fwwg>
    <xmx:ocQ4ZvkUX-a76jHguPOviVcKj3YOiEAJMStMNCXI2OS4rVswBKC1Xw>
    <xmx:ocQ4ZldAxkc-GkbM-8MUYNr-d6pDm0MaWuCMcRLV-LSB7E0MdwfF_g>
    <xmx:ocQ4ZpEgCeJ31ECOvCKXxknkzwNy6WZmfdVP5cuZroT-V1SmrAEGZw>
    <xmx:ocQ4Zqu8vc8m2BdhDi5ogNz_RnssjmTtflVKUTBQmLo_HaJ30MEXNs1K>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 6 May 2024 07:53:04 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id a3e9974b (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 6 May 2024 11:52:58 +0000 (UTC)
Date: Mon, 6 May 2024 13:53:01 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Taylor Blau <me@ttaylorr.com>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Elijah Newren <newren@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 09/23] pseudo-merge: implement support for selecting
 pseudo-merge commits
Message-ID: <ZjjEnVukDDpuP6X6@tanuki>
References: <cover.1710972293.git.me@ttaylorr.com>
 <cover.1714422410.git.me@ttaylorr.com>
 <86a1e4b8b9be99563836d1539fbf2ed4c4a6920d.1714422410.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="peK0tKexKUrqz3tA"
Content-Disposition: inline
In-Reply-To: <86a1e4b8b9be99563836d1539fbf2ed4c4a6920d.1714422410.git.me@ttaylorr.com>


--peK0tKexKUrqz3tA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Apr 29, 2024 at 04:43:37PM -0400, Taylor Blau wrote:
[snip]
> +static uint32_t pseudo_merge_group_size(const struct pseudo_merge_group *group,
> +					const struct pseudo_merge_matches *matches,
> +					uint32_t i)
> +{
> +	float C = 0.0f;
> +	uint32_t n;
> +
> +	/*
> +	 * The size of pseudo-merge groups decays according to a power series,
> +	 * which looks like:
> +	 *
> +	 *   f(n) = C * n^-k
> +	 *
> +	 * , where 'n' is the n-th pseudo-merge group, 'f(n)' is its size, 'k'
> +	 * is the decay rate, and 'C' is a scaling value.
> +	 *
> +	 * The value of C depends on the number of groups, decay rate, and total
> +	 * number of commits. It is computed such that if there are M and N
> +	 * total groups and commits, respectively, that:
> +	 *
> +	 *   N = f(0) + f(1) + ... f(M-1)
> +	 *
> +	 * Rearranging to isolate C, we get:
> +	 *
> +	 *   N = \sum_{n=1}^M C / n^k
> +	 *
> +	 *   N / C = \sum_{n=1}^M n^-k
> +	 *
> +	 *   C = N / \sum_{n=1}^M n^-k
> +	 *
> +	 * For example, if we have a decay rate of 'k' being equal to 1.5, 'N'
> +	 * total commits equal to 10,000, and 'M' being equal to 6 groups, then
> +	 * the (rounded) group sizes are:
> +	 *
> +	 *   { 5469, 1934, 1053, 684, 489, 372 }
> +	 *
> +	 * increasing the number of total groups, say to 10, scales the group
> +	 * sizes appropriately:
> +	 *
> +	 *   { 5012, 1772, 964, 626, 448, 341, 271, 221, 186, 158 }
> +	 */
> +	for (n = 0; n < group->max_merges; n++)
> +		C += 1.0f / gitexp(n + 1, group->decay);
> +	C = matches->unstable_nr / C;
> +
> +	return (int)((C / gitexp(i + 1, group->decay)) + 0.5);

Why do we cast the return to `int` when the function returns a
`uint32_t`?

> +}
> +
> +static void init_pseudo_merge_group(struct pseudo_merge_group *group)

Nit: Should't the name rather be `pseudo_merge_group_init()`?

[snip]
> +	} else if (!strcmp(key, "decay")) {
> +		group->decay = git_config_int(var, value, ctx->kvi);
> +		if (group->decay < 0) {
> +			warning(_("%s must be non-negative, using default"), var);
> +			group->decay = DEFAULT_PSEUDO_MERGE_DECAY;
> +		}

The decay is a float, and your decay rate examples mention a rate of
1.5f. It's impossible to specify fractional rates though because we use
`git_config_int()`. Should we introduce a new `git_config_float()`
function to implement this properly?

> +	} else if (!strcmp(key, "samplerate")) {
> +		group->sample_rate = git_config_int(var, value, ctx->kvi);
> +		if (!(0 <= group->sample_rate && group->sample_rate <= 100)) {
> +			warning(_("%s must be between 0 and 100, using default"), var);
> +			group->sample_rate = DEFAULT_PSEUDO_MERGE_SAMPLE_RATE;
> +		}
> +	} else if (!strcmp(key, "threshold")) {
> +		if (git_config_expiry_date(&group->threshold, var, value)) {
> +			strbuf_release(&buf);

Instead of having multiple exit paths where we need to release `buf` we
should likely have a comment exit path.

[snip]
> +static struct commit *push_pseudo_merge(struct pseudo_merge_group *group)
> +{
> +	struct commit *merge;
> +
> +	ALLOC_GROW(group->merges, group->merges_nr + 1, group->merges_alloc);
> +
> +	merge = alloc_commit_node(the_repository);
> +	merge->object.parsed = 1;

Why can we mark the object as parsed here?

> +	merge->object.flags |= BITMAP_PSEUDO_MERGE;
> +
> +	group->merges[group->merges_nr++] = merge;
> +
> +	return merge;
> +}
> +
> +static struct pseudo_merge_commit_idx *pseudo_merge_idx(kh_oid_map_t *pseudo_merge_commits,
> +							const struct object_id *oid)
> +
> +{
> +	struct pseudo_merge_commit_idx *pmc;
> +	khiter_t hash_pos;
> +
> +	hash_pos = kh_get_oid_map(pseudo_merge_commits, *oid);
> +	if (hash_pos == kh_end(pseudo_merge_commits)) {
> +		int hash_ret;
> +		hash_pos = kh_put_oid_map(pseudo_merge_commits, *oid, &hash_ret);
> +		CALLOC_ARRAY(pmc, 1);
> +
> +		kh_value(pseudo_merge_commits, hash_pos) = pmc;
> +	} else {
> +		pmc = kh_value(pseudo_merge_commits, hash_pos);
> +	}
> +
> +	return pmc;
> +}

Can't we simplify this to the following (untested):

static struct pseudo_merge_commit_idx *pseudo_merge_idx(kh_oid_map_t *pseudo_merge_commits,
                                                       const struct object_id *oid)
{
       struct pseudo_merge_commit_idx *pmc;
       khiter_t hash_pos;
       int hash_ret;

       hash_pos = kh_put_oid_map(pseudo_merge_commits, *oid, &hash_ret);
       if (hash_ret) {
               CALLOC_ARRAY(pmc, 1);
               kh_value(pseudo_merge_commits, hash_pos) = pmc;
       } else {
               pmc = kh_value(pseudo_merge_commits, hash_pos);
       }

       return pmc;
}

> +
> +#define MIN_PSEUDO_MERGE_SIZE 8
> +
> +static void select_pseudo_merges_1(struct pseudo_merge_group *group,
> +				   struct pseudo_merge_matches *matches,
> +				   kh_oid_map_t *pseudo_merge_commits,
> +				   uint32_t *pseudo_merges_nr)
> +{
> +	uint32_t i, j;
> +	uint32_t stable_merges_nr;
> +
> +	if (!matches->stable_nr && !matches->unstable_nr)
> +		return; /* all tips in this group already have bitmaps */

It's nice that there are some comments, but there are quite a lot of
non-obvious things going on in this function that would warrant an
explanation that expands a bit more into what exactly it is that we are
doing here.

I may only be speaking for myself, but I basically have no clue what we
do here :) Something something pseudo merges, I guess. But there is no
in-code explanation at all what a "stable" or "unstable" commit is, how
exactly we match commits and other higher-level ideas.

Patrick

--peK0tKexKUrqz3tA
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmY4xJ0ACgkQVbJhu7ck
PpSbJQ/+Oj2eRsRX7bI2QSj3MZ+hPnnJyriY6TmUpCw+zZFET8LAPsKzmvRoO/6E
3BYuaB8mSMBVSFl5XzwetHWaZv05K2UyN9xmfDTsUWbyI1ozFoqQsYi+5GyYWu+q
F27hOveOcVtlKQu3vIDh48VDzpCfPPsxJCFoZk9wJ20H2zMquEl/GXH9Y4Tmd4+U
oJ+JFj8E7uXCU7SxO6w/TWCqgrTPDxBA4WjfX3mwMzNqpDeLSQ32ZJ+ry7/3a/24
AqncQbbg1NbQem+LuIjtKVRijj8eIK9jarqEMoqDHg3Dh4/4D+ZIrcjVPUxObeBF
jyA9lizNfoUa8XL0PRev2C1wBfzhE2JbePJMoJh+tiS6w67PNQcr5KvP0q/Z697/
v45oby6Jc0HQkPpiQBqCL4Qjy/76vg+glFEI+MpeQdQgR8oaE0i260ytxUVfrT6L
NyO5vWSWBpCtyQJMxEggSiJHyifCQoWK5WMC1lJl6rLVHNEEVDImZw0Zyf/D/A9s
gzWWWtAAWu9oJMVa04+cRh0YsxsVRCI2LRDsimdYMCrR4llofMfWJ8NvKx2ZkKkH
JlQH368v5YPRvHHDe90etC7ns/DsD1r1mAsrxfzXPsjiTTZ6/YJ8qiYwATWk/rKz
X3pgcdoYZoRkyt1WD7qjCH5zY4sueeGiC3jA0eD5ABY7QYt1BO4=
=OJ3h
-----END PGP SIGNATURE-----

--peK0tKexKUrqz3tA--
