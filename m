Received: from fhigh-b1-smtp.messagingengine.com (fhigh-b1-smtp.messagingengine.com [202.12.124.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2292B254AF3
	for <git@vger.kernel.org>; Tue, 27 May 2025 10:40:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748342408; cv=none; b=kE6Yndo4ZZRVOOF1OdGZmN2EbuiSpQ2EqghNfCP53u8wJh2azoRmU5CfFnvlzYLdi1LfNxxKF/jovPSkawZVHMH4aPbnXnPsrwOqzyVoT+Ruu1kAI8njKzO/m+XWwsKz7mGt+ERRakJ39UunfreXI42qSmtwFN9drlWyUmK1cbo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748342408; c=relaxed/simple;
	bh=2u8pdCQEHXHKEb2+0yhKB/dfWo7Rnzl8SKiS0obZXok=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MIFgQbk8KZEZYTa50aOnU+cc5LC+02ale6RtPyEYZppxgxdASB1zvKJoEewH2jzYhvE7p9ORZAGUFzJPNLz+jyO1aZe7YgQnSf0DOJ8iSUobynkwbq+T0ZT4WtCpykQIbueAc7lXPlFiJHp2u3cN1Ff0Mi9MRvbIsze6LXtxQeY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Rd4sL17i; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Blz9LRFq; arc=none smtp.client-ip=202.12.124.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Rd4sL17i";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Blz9LRFq"
Received: from phl-compute-12.internal (phl-compute-12.phl.internal [10.202.2.52])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 1D826254011E;
	Tue, 27 May 2025 06:40:05 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-12.internal (MEProxy); Tue, 27 May 2025 06:40:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1748342404; x=1748428804; bh=uKU1brBBZo
	A1Cx0boyMYJv/R9j4dMeITnyQXn5VgP+U=; b=Rd4sL17i8xuBklhXLH+q8Z/k23
	B6CAxwTMPG28VGOGdKR84PIOPSsVUbg3cfFUv2GCs9xGKAFKeHKw8M4LJ+xXt7E1
	hpVpvPErLrtyoH6iKLH4YLxuaKSdChl3YD4oNNXX0CbZPRqUekidUuKc1v7nyaqO
	7RBQUqYWjubsciMnOYHhFqxPw0Gx//tBWBJJSWHCt+XK+DhRiZXODwTy0cocqJK2
	ykt/1sxGjZf4QU/pFy5lga9+QOmxhFt8w5XqnBM7o5I8m+9tA1aGctpRRnzL/Efa
	dHFEimoCe/bjGSe0b8Do+5TBXHqt2w4qfg6Lqdr8QZ3bWESHhkAYl+1t576A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1748342404; x=1748428804; bh=uKU1brBBZoA1Cx0boyMYJv/R9j4dMeITnyQ
	Xn5VgP+U=; b=Blz9LRFqNsAcrCsXFtW0lbsdPM8cEjHTbjgWTFc6luq9lHry8F8
	BQ89lp9+GgaI6Cn81xSv0PmcVJxQrwuvk4wz3fcSBlxnZGLJ145Fjics05j7FIyf
	oJUTm9mXWmAbM84pQVSVdQdMY/dFFsPfJ12gqURUM/pcKk1T2XYQwwBJtT5ktBic
	mnxFmDRg4kbfrRD7LR2xDzX15BVJrDYb/a0hT8tzIsnx2jBBc84B+3pj5vZaEEA0
	5OFVqVBds0TphF8e46JsjEZBQf+fvEkFQs2SDXlzvdeOAb0VckUoMxuXcb2LtDdQ
	oRMDR5osQLe5mhOxfHVuzxszPxOoWhVEBxw==
X-ME-Sender: <xms:hJY1aAlgGdPT0I5Vv_TlGOm0LZ3Hj8ncA7Y-huxisTjK0wAqwLcq0Q>
    <xme:hJY1aP0VWEzajT4a2j8e5T2r78ro3icAfHrcm9iMg8D8xNFWFxbh2K9PUflVhOfXC
    BgdVtr8IoAy_kogGA>
X-ME-Received: <xmr:hJY1aOoC30dkG4frMslXu0Ar2A-j6BihvGfL53kyvWgXqiJaUmAUTh2jBvH0eVO2DijripJDbX1SXDpI35ofM1It_ScKMgYhwDkcbVBtVu9j0A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddtgddvtddujeculddtuddrgeefvddrtd
    dtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggft
    fghnshhusghstghrihgsvgdpuffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftd
    dtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfhf
    gggtuggjsehttdertddttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrh
    guthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpeevkeekfffhiedtledu
    iefgjedttedvledvudehgfeugedugffhueekhfejvdektdenucevlhhushhtvghrufhiii
    gvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgt
    phhtthhopeeipdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehtohhonhesihhoth
    gtlhdrtghomhdprhgtphhtthhopehsthholhgvvgesghhmrghilhdrtghomhdprhgtphht
    thhopehmvgesthhtrgihlhhorhhrrdgtohhmpdhrtghpthhtoheprghvrghrrggssehgmh
    grihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdp
    rhgtphhtthhopehpvghffhesphgvfhhfrdhnvght
X-ME-Proxy: <xmx:hJY1aMnlLdduiBlLgx1vCd8SI55SXsA5mVaT6VWvD8tiCIL8yu6hYg>
    <xmx:hJY1aO0wjTp4FgijSTRRAFN5zHbdKVLixxk5Bj-kQTmFRUp_Ofc2mA>
    <xmx:hJY1aDtfdekhlImqaHBVxQ-bUjgm7kMnb3cCXEAqlH4pXP_Ywd57HA>
    <xmx:hJY1aKUfikGfSYd10LVOAZn1qBTuxcyEJhfqRH-EmGX8ARJnf9Emmw>
    <xmx:hJY1aC_jwxoRIRTRQp3G-AHrElBzmef1XouY6oyWKXVSP9L1jT7rI7af>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 27 May 2025 06:40:03 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id db3a6e31 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Tue, 27 May 2025 10:40:03 +0000 (UTC)
Date: Tue, 27 May 2025 12:40:02 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Toon Claes <toon@iotcl.com>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Taylor Blau <me@ttaylorr.com>, Derrick Stolee <stolee@gmail.com>,
	=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Subject: Re: [PATCH RFC v2 3/5] last-modified: use Bloom filters when
 available
Message-ID: <aDWWgj8gTS9EM7v6@pks.im>
References: <20250523-toon-new-blame-tree-v2-0-101e4ca4c1c9@iotcl.com>
 <20250523-toon-new-blame-tree-v2-3-101e4ca4c1c9@iotcl.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250523-toon-new-blame-tree-v2-3-101e4ca4c1c9@iotcl.com>

On Fri, May 23, 2025 at 11:33:50AM +0200, Toon Claes wrote:
> Our 'git last-modified' performs a revision walk, and computes a diff at
> each point in the walk to figure out whether a given revision changed
> any of the paths it considers interesting.
> 
> When changed-path Bloom filters are available, we can avoid computing
> many such diffs. Before computing a diff, we first check if any of the
> remaining paths of interest were possibly changed at a given commit by
> consulting its Bloom filter. If any of them are, we are resigned to
> compute the diff.
> 
> If none of those queries returned "maybe", we know that the given commit
> doesn't contain any changed paths which are interesting to us. So, we
> can avoid computing it in this case.
> 
> This results in a substantial performance speed-up in common cases of
> 'git last-modified'. In the kernel, here is the before and after (all
> times computed with best-of-five):
> 
> With commit-graphs (but no Bloom filters):
> 
>     real	0m5.133s
>     user	0m4.942s
>     sys	0m0.180s
> 
> ...and with Bloom filters:
> 
>     real	0m0.936s
>     user	0m0.842s
>     sys	0m0.092s
> 
> These times are with my development-version of Git, so it's compiled
> without optimizations. Compiling instead with `-O3`, the results look
> even better:
> 
>     real	0m0.754s
>     user	0m0.661s
>     sys	0m0.092s

I'm sure that the old state without bloom filters will also improve a
bit?

> Signed-off-by: Toon Claes <toon@iotcl.com>
> ---
>  last-modified.c | 44 ++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 44 insertions(+)
> 
> diff --git a/last-modified.c b/last-modified.c
> index 9283f8fcae..f628434929 100644
> --- a/last-modified.c
> +++ b/last-modified.c
> @@ -92,12 +99,21 @@ void last_modified_init(struct last_modified *lm,
>  	if (setup_revisions(argc, argv, &lm->rev, NULL) > 1)
>  		die(_("unknown last-modified argument: %s"), argv[1]);
>  
> +	(void)generation_numbers_enabled(lm->rev.repo);

Why the `(void)` cast? And why even call this in the first place? This
definitely needs a comment and smells like funky design in our commit
graph subsystem where we rely on side effects of one function to leak
into a different function.

> +	lm->rev.bloom_filter_settings = get_bloom_filter_settings(lm->rev.repo);
> +
>  	if (add_from_revs(lm) < 0)
>  		die(_("unable to setup last-modified"));
>  }
>  
>  void last_modified_release(struct last_modified *lm)
>  {
> +	struct hashmap_iter iter;
> +	struct last_modified_entry *ent;
> +
> +	hashmap_for_each_entry(&lm->paths, &iter, ent, hashent) {
> +		clear_bloom_key(&ent->key);
> +	}

The curly braces shouldn't be needed.

> @@ -180,6 +197,30 @@ static void last_modified_diff(struct diff_queue_struct *q,
>  	}
>  }
>  
> +static int maybe_changed_path(struct last_modified *lm, struct commit *origin)
> +{
> +	struct bloom_filter *filter;
> +	struct last_modified_entry *ent;
> +	struct hashmap_iter iter;
> +
> +	if (!lm->rev.bloom_filter_settings)
> +		return 1;
> +
> +	if (commit_graph_generation(origin) == GENERATION_NUMBER_INFINITY)
> +		return 1;

Hm, okay, so here we require generation numbers to exist. Why is that
though? Shouldn't we only care about bloom filters? I don't quite get
that part yet.

> +	filter = get_bloom_filter(lm->rev.repo, origin);
> +	if (!filter)
> +		return 1;
> +
> +	hashmap_for_each_entry(&lm->paths, &iter, ent, hashent) {
> +		if (bloom_filter_contains(filter, &ent->key,
> +					  lm->rev.bloom_filter_settings))
> +			return 1;
> +	}
> +	return 0;
> +}
> +

Okay, and here we check whether any of our desired paths may be
contained in the bloom filter.

>  int last_modified_run(struct last_modified *lm, last_modified_callback cb, void *cbdata)
>  {
>  	struct last_modified_callback_data data;
> @@ -199,6 +240,9 @@ int last_modified_run(struct last_modified *lm, last_modified_callback cb, void
>  		if (!data.commit)
>  			break;
>  
> +		if (!maybe_changed_path(lm, data.commit))
> +			continue;

If there either are no bloom filters or in case none of them contain our
commit we can safely skip over the commit indeed. Otherwise we'll have
to check whether the commit really is interesting.

Makes sense.

Patrick
