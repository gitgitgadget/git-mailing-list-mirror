Received: from fout-a3-smtp.messagingengine.com (fout-a3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 271F63B775A
	for <git@vger.kernel.org>; Wed,  1 Jul 2026 15:50:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782921053; cv=none; b=r8yxXcTVukkjAiwKX0ZTwD7IfxwfwCOwF0uxJ/k8KCG2tjliQv7JzoxkaP594IWZvELOrJ98y6B8UBqeNtaKBStlRVg8W3l2hkj3g9f1s2Mc2lqfllVq0oKxVW7v8k5l+EKLrOr1SsjdYmoV12Ix48C1oxfHo4jEsZJxBro3yqQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782921053; c=relaxed/simple;
	bh=oSlJ6ipxUQvDkOImQfemI5oYmlRpXZH8u1noq5BpHZw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=gp6aLVi74OGDf0G0pwQCy7rXg9VOCx4TSnLxRTC5TriV03X4INcR/UBw4Ls8p1rkBi49She1R1HHtbHDW4X0pxJh7GRcIoMwv4FbbhQ6BNEZqawrXHrh/qb4pCHpUJ8/8T36m4mjWNWo4SwuRD0hTD22H61wGCpLjy69IchFKms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=X+14AMmF; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=NPXPlJd+; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="X+14AMmF";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="NPXPlJd+"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.phl.internal (Postfix) with ESMTP id 73D94EC0114;
	Wed,  1 Jul 2026 11:50:50 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-02.internal (MEProxy); Wed, 01 Jul 2026 11:50:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1782921050; x=1783007450; bh=IEKFmRl0iO
	H8XTwEYO6NbuxCjnfNrm4PbeeYSgDsQ7U=; b=X+14AMmFG+kTAy4S7vSR8qBZbP
	xrLhOGcDDWvortJulVh4KNVB0f0blhTu9dulSgHfqdww8EKkmqlVP2LoKmQCQku8
	BrkbdIDVmHuOMJfZqP6zGugj2c6/JigG9CGv/T7iay4eHSl4H4FUkOyIRqYUWFE1
	MPfpwevw3KiBiWTZiUEpTbyuRy7nxo4inpKoSrLvTfWt7Ma7J8Yc7LLclgKmO8po
	lI80LBfw9Y62WcUB9jO5+A8ZyrXew4UIWvMls+xCHtQiZfBZysNHVHRHo5ZO082i
	pAdVYD6oBp7YwVizW8diIdwkD3wBjk3FECpnlYtjffk4oUtyAhobbqEkcvDg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1782921050; x=1783007450; bh=IEKFmRl0iOH8XTwEYO6NbuxCjnfNrm4Pbee
	YSgDsQ7U=; b=NPXPlJd+LPtEhdl76jGdqnsQQeIHD2qTmjjmxnqwhEijG6yR1Nn
	mH7FxRXX+94osH0KpPnKk9fNnJR2pgU/DgxFt4AI+74dJQdhUC+e1hUNy+PtNpz2
	IyOmk4yb0yecw6bXs6Jl3I7TSPZ5aoIHLim+90IrnyLK36H0srG2L2YK47kNqLh3
	i4hUl+GyQpslM0OguxwUAlbLEMSJcWm8Jwp8yKPpsaP/3GENu8JFS5Z3N2Nqe6PD
	1O1yxTA/YmVzZgDQuvtd8Mk2+ZA8O0qLSQQl9xP2bVr8Meu7e6JUpMaUiGPY3vkz
	nQLGrLHASPEd1yQqEEGn9fSVB8ou37AjNJg==
X-ME-Sender: <xms:WjdFahL708ZoXqqoMG3n4dnfHAH95MO3Kctc-FwmkFopkiTqZxH2-g>
    <xme:WjdFakLTmo915apTIPw3Xps7N3lhDWbAW2TK109RgywgMnGZBwYyE_FXN6Pke-Jpn
    LigP0UvL2Y3fMsB5VGyWZTdzPBHBNOGxj2vjE1S53ZuID26f3Ie6w>
X-ME-Received: <xmr:WjdFautMe6lVDI-YjhGUma-9__YMorabgaZm_eOaDF_wFqwBGPUSAMuT5pV8Fn9HapdWrVNGXHpTdelx_QlLnvAnhryw9PR5huSBVmU>
X-ME-Proxy-Cause: dmFkZTF7VAArGhZrAygVrSGC/FNNFQxaF620WMmigWLqtqWXEEx57U95UBpcL8Hwuke0Su
    euAnJuFfJX+QlYVtQcN4c3DMAdZpw/vEEqtTQrszV8q3Zea/09D7GYhn0qsdOrU3a9jFrA
    ENlvir2BbIi6h4RYdJxj4Nc+Vc0O+3ijNGirOXfJMEgWqwdTC1TWvWpGyERL2aPdNuFfbq
    ANCuC3v2+MHnLxmZkMYENg5V/MtEDSJHNewcmHryQPkxB0sf7RZUyBfWksGA22wtih6ON+
    6hRae5hweg1CO0+doWKS0zkRCpa0xPfNqSYBcm1vC+9gf8h5x8DOwCy56elCBQOjv6i4AL
    HuH0IGgTaqlScOPD0XpSCQtwi21WJTcTSXGDouTa6HtXqx4ZObEkICzlRygou/1QXbPXE1
    uCYWe4bZnbTs5z7sNqr/lXvbkZpbLs/Z3dhi8aPmEU4MK1uXMC6Y7M7bbCKsBihFIpWe1A
    eCcdlBK3IG1o4nZHRLo5G1uT8ESIHeklLMZ1TAeE9+NYTa6t3nI9jlXG9Y9lDomWinKVSZ
    Yeec4UYjSHUkSYLVH/WgoahYlEJrd9apwL7ZwYW20OsKtlkHNLCgfjvwg6J7aXNazgx81H
    5/w8d31uvVNLdZmr3KMuPUA1X6PxzenZCFgvIGD+4UGWUYWKAX6CYWZmNoFg
X-ME-Proxy: <xmx:WjdFahTwXnzKn3Jyy1FbfoKQvP6un_ful-hibCtIf5PkgoPsIlbLSg>
    <xmx:WjdFakNmz5ckFeT2dbJaMTebXLctKAnxLVM4PL_JnQ-6pWOfdJztyw>
    <xmx:WjdFamYKiadRwykoLRYy0VPhqVOc0SCWfU6uLbegQqgpoYrrCf1Irw>
    <xmx:WjdFauwkpAa8or9frWhe3JB2_8S5O2v_62_Au7VKt1CGAK61pPrABA>
    <xmx:WjdFar3-mCvWqpTHawI-JGLNP-Rg93kCsYrtm5CfLparBZlr4Om-aQjh>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 1 Jul 2026 11:50:49 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
Cc: git@vger.kernel.org,  Patrick Steinhardt <ps@pks.im>
Subject: Re: [PATCH 1/3] bloom: make bloom-filter slab initialization
 idempotent
In-Reply-To: <20260701063942.GA2580331@coredump.intra.peff.net> (Jeff King's
	message of "Wed, 1 Jul 2026 02:39:42 -0400")
References: <20260701063538.GA2579765@coredump.intra.peff.net>
	<20260701063942.GA2580331@coredump.intra.peff.net>
Date: Wed, 01 Jul 2026 08:50:48 -0700
Message-ID: <xmqqqzlmpv3b.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jeff King <peff@peff.net> writes:

> Before using any of the commit-graph bloom-filter code, somebody needs
> to call init_bloom_filters(). This initializes the commit-slab we use
> for storing filter information. But we don't want to call it twice
> (without a matching deinit call in the middle), since it overwrites the
> existing slab pointers, leaking the old values.
>
> Usually this init call is done lazily by parse_commit_graph() when we
> read a graph file that contains bloom data. But this can lead to some
> oddities:
>
>   1. We may call parse_commit_graph() multiple times when we have a
>      split commit graph. I think this doesn't produce any user-visible
>      bug, because we parse all of the files back-to-back. So even though
>      we call init_bloom_filters() multiple times, we never look up any
>      commits in between, so the slab is always empty and initializing it
>      again happens to do nothing. This is a little sketchy to rely on,
>      though.

Yeah, that sounds like an accident waiting to happen.

>
>   2. We call init_bloom_filters() directly in the "test-tool bloom"
>      helper so we can call get_or_compute_bloom_filter(). Normally this
>      is OK, as there is no bloom data in the on-disk graph file. But if
>      you build with SANITIZE=leak and run:
>
>        GIT_TEST_COMMIT_GRAPH=1 \
>        GIT_TEST_COMMIT_GRAPH_CHANGED_PATHS=1 \
>        ./t0095-bloom.sh
>
>      there's a leak that happens like this:
>
>        a. Our direct init_bloom_filters() sets up the slab.
>
>        b. In get_or_compute_bloom_filter() we look in the slab for a
> 	  cached entry. We won't find anything yet, but since we don't
> 	  use the read-only "peek" accessor (since we'll fill in the
> 	  entry if not present), this actually populates the slab with
> 	  an allocated chunk.
>
>        c. Now we look for an entry in the graph files. So we have to
> 	  load them and end up in parse_commit_graph(), which calls
> 	  init_bloom_filters() again. That trashes our existing slab
> 	  allocation, which is now leaked.

Besides, if the test-tool initializes explicitly and the production
code does not and relies on lazy initialization, we are not testing
the production setting, which may hide bugs in lazy initialization.

>   3. There's a similar case in write_commit_graph(), which calls
>      init_bloom_filters() before get_or_compute_bloom_filter(). I think
>      this code path is lucky to avoid the leak because it reads the
>      graph files first, then calls its init_bloom_filters(), and then
>      starts filling in entries. So even though it has the same overwrite
>      problem, we'd never actually allocate any slab entries between
>      overwrites.
>
> The easiest solution here is just to make initialization of the slab
> idempotent using an extra flag.
>
> We could actually get away without using the extra flag, for example by
> checking whether bloom_filters.stride has been set. But it's probably
> better to avoid being too intimate with the commit-slab details.

"bool bloom_filter_slab_initialied()" that is generated by including
commit-slab-impl.h can be as intimate with the implementation as we
want, though ;-)

> Likewise we don't actually need to re-initialize after a deinit call;
> the slab-clearing function leaves things in a usable state. But it
> seemed less surprising to pair the init/deinit calls explicitly.

Good.

> This patch takes a smaller and more direct route to just dealing with
> the potential leak issue.
>
> Signed-off-by: Jeff King <peff@peff.net>
> ---
>  bloom.c | 5 +++++
>  1 file changed, 5 insertions(+)

Looks trivially correct.

> diff --git a/bloom.c b/bloom.c
> index a805ac0c29..c98d1672ad 100644
> --- a/bloom.c
> +++ b/bloom.c
> @@ -16,6 +16,7 @@
>  define_commit_slab(bloom_filter_slab, struct bloom_filter);
>  
>  static struct bloom_filter_slab bloom_filters;
> +static int bloom_filter_slab_initialized;
>  
>  struct pathmap_hash_entry {
>      struct hashmap_entry entry;
> @@ -263,7 +264,10 @@ void add_key_to_filter(const struct bloom_key *key,
>  
>  void init_bloom_filters(void)
>  {
> +	if (bloom_filter_slab_initialized)
> +		return;
>  	init_bloom_filter_slab(&bloom_filters);
> +	bloom_filter_slab_initialized = 1;
>  }
>  
>  static void free_one_bloom_filter(struct bloom_filter *filter)
> @@ -276,6 +280,7 @@ static void free_one_bloom_filter(struct bloom_filter *filter)
>  void deinit_bloom_filters(void)
>  {
>  	deep_clear_bloom_filter_slab(&bloom_filters, free_one_bloom_filter);
> +	bloom_filter_slab_initialized = 0;
>  }
>  
>  struct bloom_keyvec *bloom_keyvec_new(const char *path, size_t len,
