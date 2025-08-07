Received: from fhigh-a4-smtp.messagingengine.com (fhigh-a4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C63CD201266
	for <git@vger.kernel.org>; Thu,  7 Aug 2025 06:49:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754549362; cv=none; b=mMlzyNnA4zRmllMDc3nBGevEbXflFm4T6J0VE8uGGKfkTw8x5oWOnFrzdn3Ac8QeEqsTIDQl+EmOnC7KadB+FnwOooAzBESeaE7BO+LDOL8JJ4i4kR9YW0JdD6gSNfsJ5oSKluSA2fvXSj2WzzdyUNBUyEkQG+LzKhfAkiB6k8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754549362; c=relaxed/simple;
	bh=+LFsKLDAdSU0/IH647BDNqqSZNU1pHo7pTLx9m8kJz4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iEcG3EC6fvXN5PnZFFo6Bl/gUCubj0JaF9TqhhPkvX+rDJ4vXtZTEuTU1HcBIvZ/8GI2BYdgeFiMocJf9/B8Nc8B0n5LthN8wLBTBRZxOsWlkwtSeDS3NgcG19KgSiLaCaU1d2ubMpe1OKxCgdNXevHyV3MDMTuI99TJ7zNN4I8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=a7ayHhjk; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=R8Xo/uEt; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="a7ayHhjk";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="R8Xo/uEt"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id E5E8114001ED;
	Thu,  7 Aug 2025 02:49:19 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Thu, 07 Aug 2025 02:49:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1754549359; x=1754635759; bh=i81vAi+p/J
	43E0gwhDDe7gHIcXtL36g1gWcNjpRq6t0=; b=a7ayHhjk1jYIAwbLsdZa7DO+nG
	+67JnLuBo7n+Ob/Wmi7zfKyecNvaOMlpImLyRaR4gKOC73cCCHiOp6SmWCYjc3Zx
	G7Mna+kCQ7cZhNkvSwJ1W1JAHEzdVJvMz6ICoB5Tt9ZVabAKf5T6yofkGrGI2FwM
	xJhsVQz/Z6kKmvMSQnr7jR1ewKFST/aUtM9wLcVMro1/m4++ViS/qxBPcjN2+CQa
	GgseWD0EyoKLo/I8GnrH6Je13NYay3i9wWNkxm0/2FTc7Rhas16aSMPq9Jh58Box
	qRRCE+ZeEyjdNfUfRb1cC8qKfKZ48an5XxYKZQ48oZlED7bvZ+7owb2U9opQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1754549359; x=1754635759; bh=i81vAi+p/J43E0gwhDDe7gHIcXtL36g1gWc
	NjpRq6t0=; b=R8Xo/uEtWEDCf9pkbkCmG75t2oRqXmEH7YG0jf71yhymLpVS9W0
	l/yXPhgn9kdKL/tmGTmRl0i2F+EO3dCkIx9xgDfTxXN86p//f2FUaDjSIARHLJuC
	sf4kRwZAd+3iaX/u641cLtFrLNT++HCh0p9KIf8cwncsYmryRUjkMFf+B6l/OQZ6
	5JQfOffuLWlO3z/p0FhHJ6h/LXl+hvjM4CGfZau9MFGeybggWXXPUoDt6l/2Elat
	+hDVwy0SqLzFzPtzEYVcAv38POb0l9XuiU66mLqH41N5VctBK0bGps7pzrk1p4AG
	tEFugsPD1wt0YQHzhFJoc+DpJVOTVxrtpew==
X-ME-Sender: <xms:b0yUaOg9Nu9KzDsxYbPIpZ12CMA7mwv5h4_2OaPo7yrStpohqvmXXQ>
    <xme:b0yUaKheqXpkSmABQVaql3-Inaxps6r57BUM16cWxdilZDxUYwTmAuQh4goaAWkTg
    P0zWAoGpPdk2xjFMQ>
X-ME-Received: <xmr:b0yUaMhnqd0iBgfE6ftdqwOMm2DUStyzjJg5lnKoOOMK4dOe_msoQXm23QnWM1qz5P5cop0y3EQx4W2kx2m5BeNSE4tC-OeU9SSQaa4mNw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdduvddtvdehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpeffhffvvefukfhfgggtuggjsehttdertd
    dttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhk
    shdrihhmqeenucggtffrrghtthgvrhhnpeevkeekfffhiedtleduiefgjedttedvledvud
    ehgfeugedugffhueekhfejvdektdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgr
    mhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeehpdhmoh
    guvgepshhmthhpohhuthdprhgtphhtthhopeihlhguhhhomhgvvdguvdesghhmrghilhdr
    tghomhdprhgtphhtthhopehtthgrhihlohhrrhesghhithhhuhgsrdgtohhmpdhrtghpth
    htohepshhtohhlvggvsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithhsthgvrhes
    phhosghogidrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorh
    hg
X-ME-Proxy: <xmx:b0yUaCKd1OXz9pKbum5kkb5fwnlhR8Zq2T1QKSVdjVogRtzWqV2iPw>
    <xmx:b0yUaDHNBzz2P_keOZaYnUo0OwtUIlYQMgJt9jSTWFAt175VKj6w8A>
    <xmx:b0yUaOSrEY_QAHJzNF9gkd1qZK11SVtvri5EnXxMSqWLEggZCD9oDg>
    <xmx:b0yUaHdJlvB2V5pHwb7X9tj-SOF8DC5N1dsqu8nmpxuvIb4e4Oxt1g>
    <xmx:b0yUaFeIE_YWBtQxO6mFoBIMZEee289EpvEqNTHz1nnF3GYQEqWkwNiV>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 7 Aug 2025 02:49:18 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 00aa4337 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Thu, 7 Aug 2025 06:49:16 +0000 (UTC)
Date: Thu, 7 Aug 2025 08:49:13 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Lidong Yan <yldhome2d2@gmail.com>
Cc: git@vger.kernel.org, stolee@gmail.com, gitster@pobox.com,
	ttaylorr@github.com
Subject: Re: [PATCH] bloom: enable bloom filter with wildcard pathspec in
 revision traversal
Message-ID: <aJRMaYfMd3PlRtoz@pks.im>
References: <20250807051243.96884-1-yldhome2d2@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250807051243.96884-1-yldhome2d2@gmail.com>

On Thu, Aug 07, 2025 at 01:12:43PM +0800, Lidong Yan wrote:

In the subject it should be s/enable bloom/enable Bloom.

> When traversing commits, a pathspec item can be used to limit the
> traversal to commits that modify the specified paths. And the
> commit-graph includes a Bloom filter to exclude commits that definitely
> did not modify a given pathspec item. During commit traversal, the
> Bloom filter can significantly improve performance. However, it is
> disabled if the specified pathspec item contains wildcard characters
> or magic signatures.

Let's add a paragraph here, as we now switch into the "what is being
done mode".

> Enable Bloom filter even if a pathspec item contains wildcard
> characters by filter only the non-wildcard part of the pathspec item.

s/by filter/by filtering/

> Also Enable Bloom filter if magic signature is not "exclude" or
> "icase".

This explains what is done, but not why this is safe to do.

> With this optimization, we get some improvements for pathspec with
> wildcard and magic signature. First, in the Git repository we see these

"for pathspecs with wildcards or magic signatures".

> diff --git a/revision.c b/revision.c
> index 18f300d455..ef8c0b6eca 100644
> --- a/revision.c
> +++ b/revision.c
> @@ -671,12 +671,13 @@ static void trace2_bloom_filter_statistics_atexit(void)
>  
>  static int forbid_bloom_filters(struct pathspec *spec)
>  {
> -	if (spec->has_wildcard)
> -		return 1;
> -	if (spec->magic & ~PATHSPEC_LITERAL)
> +	int forbid_mask =

The mask should be `unsigned`.

> +		PATHSPEC_EXCLUDE | PATHSPEC_ICASE;

I think instead of a forbid-mask we should use an allow-mask. Otherwise
it can happen quite easily that we add new magic that isn't compatible
with Bloom filters but forget to update this part here. I'd rather be
slow but correct than fast but incorrect.

> +	if (spec->magic & forbid_mask)
>  		return 1;
>  	for (size_t nr = 0; nr < spec->nr; nr++)
> -		if (spec->items[nr].magic & ~PATHSPEC_LITERAL)
> +		if (spec->items[nr].magic & forbid_mask)
>  			return 1;
>  
>  	return 0;
> @@ -693,9 +694,22 @@ static int convert_pathspec_to_bloom_keyvec(struct bloom_keyvec **out,
>  	size_t len;
>  	int res = 0;
>  
> +	len = pi->nowildcard_len;
>  	/* remove single trailing slash from path, if needed */
> -	if (pi->len > 0 && pi->match[pi->len - 1] == '/') {
> -		path_alloc = xmemdupz(pi->match, pi->len - 1);
> +	if (len > 0 && pi->match[len - 1] == '/')
> +		len--;
> +	else if (len != pi->len) {
> +		/*
> +		 * for path like "/dir/file*", nowildcard part would be
> +		 * "/dir/file", but only "/dir" should be used for the
> +		 * bloom filter
> +		 */
> +		while (len > 0 && pi->match[len - 1] != '/')
> +			len--;
> +	}
> +
> +	if (len != pi->len) {
> +		path_alloc = xmemdupz(pi->match, len);
>  		path = path_alloc;
>  	} else
>  		path = pi->match;

Okay, this matches what I've expected: if we have a wildcard we cannot
match on the component that contains the wildcard itself. But what we
_can_ do is to match on all the components leading to that wildcard
component.

One thing I did wonder though: what happens if the first component
contains the wildcard? We cannot really make any use of the Bloom filter
in that case as the path we match against becomes empty. I expect that
we'll handle this just fine. But is it still more performant than not
even trying Bloom filters in the first place?

> diff --git a/t/t4216-log-bloom.sh b/t/t4216-log-bloom.sh
> index 639868ac56..d8200e4dcb 100755
> --- a/t/t4216-log-bloom.sh
> +++ b/t/t4216-log-bloom.sh
> @@ -154,11 +154,34 @@ test_expect_success 'git log with multiple literal paths uses Bloom filter' '
>  	test_bloom_filters_used "-- file*"
>  '
>  
> -test_expect_success 'git log with path contains a wildcard does not use Bloom filter' '
> +test_expect_success 'git log with paths all contain non-wildcard part uses Bloom filter' '
> +	test_bloom_filters_used "-- A/\* file4" &&
> +	test_bloom_filters_used "-- file4 A/\*" &&
> +	test_bloom_filters_used "-- * A/\*"
> +'
> +
> +test_expect_success 'git log with path only contains wildcard part does not use Bloom filter' '
>  	test_bloom_filters_not_used "-- file\*" &&
> -	test_bloom_filters_not_used "-- A/\* file4" &&
> -	test_bloom_filters_not_used "-- file4 A/\*" &&
> -	test_bloom_filters_not_used "-- * A/\*"
> +	test_bloom_filters_not_used "-- file\* A/\*" &&
> +	test_bloom_filters_not_used "-- file\* *" &&
> +	test_bloom_filters_not_used "-- \*"
> +'
> +
> +test_expect_success 'git log with path contains various magic signatures' '
> +	cd A &&
> +	test_bloom_filters_used "-- \:\(top\)B" &&
> +	cd .. &&
> +
> +	test_bloom_filters_used "-- \:\(glob\)A/\*\*/C" &&
> +	test_bloom_filters_not_used "-- \:\(icase\)FILE4" &&
> +	test_bloom_filters_not_used "-- \:\(exclude\)A/B/C" &&
> +
> +	cat >.gitattributes <<-EOF &&
> +		A/file1 text
> +		A/B/file2 -text

We typically indent the heredoc text to the same level as the command.

> +	EOF
> +	test_bloom_filters_used "-- \:\(attr\:text\)A" &&
> +	rm .gitattributes

You can use `test_when_finished" instead to clean up after yourself even
in case the test fails.
