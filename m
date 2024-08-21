Received: from fhigh5-smtp.messagingengine.com (fhigh5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 327431C1AB7
	for <git@vger.kernel.org>; Wed, 21 Aug 2024 10:23:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724235835; cv=none; b=h9nVNrReEnhV55l9trXqf6IVOT/RsAuYdvj8Nrd0IW8yZrBW2hhNkarB2GJvtPiqXWQwFxxAzT9JuhsZ7mtDuKAfdguceb0Qjd5pBkGoHNh7RYeEcqZV/3hdIBwlqHZlsK5LHr7HQw07YI9nVZsFCcCYHsVFK9df6zW5aq1JPgM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724235835; c=relaxed/simple;
	bh=6f18zF9nFlv6nojyxPrCLuI9LH6E0/PfPigNUsifp9M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GHI7+xiqVrImr89O34l6GhH9L8GmzW515+iXZvVXUyM03fsEIKZ3qu0td5T/UJh2YQBV1Z7bc8zT8a8A/583Wo4tPuv8BpnD76E/krw2Y6ceo6Id4y7YiOkaoeuEz+Yf+iziphQeyf1dXRMqa/YyxtdmZocAOAG1bDYpFTDNKQM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=hZPQnRMV; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=CD4PBk0n; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="hZPQnRMV";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="CD4PBk0n"
Received: from phl-compute-07.internal (phl-compute-07.nyi.internal [10.202.2.47])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 409041151BA2;
	Wed, 21 Aug 2024 03:28:39 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-07.internal (MEProxy); Wed, 21 Aug 2024 03:28:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1724225319; x=1724311719; bh=agpmT5i/H4
	I9CpFwP+ZgZCDHnOLEswww+MqSwwzRYZ8=; b=hZPQnRMVHiW1b7Xtj7UEBI9hl+
	P1XnIZPpSKf21j77CfqGF3BxUsMyQMMaMnKpYrB6txHSAvP71WLkWMJUFm3Ccuu9
	f+H85VCClu9eMIXSAkeakJclxp+g66zMhR/SA4uRsActrCVnJjl62QxJPNMDv/dk
	k0ODlB3WrD1zqdU57Oj+XTIao7v2jNXhGpLgwhNYXF8jXaB6i+QrbXzoG5uvgQZD
	dqb1x85rWFpNqTV4Y2DTFAiz7ndvzrzTBDf/Vz4QPGV6lCaKW8ulBgaGjqZHIsBC
	adrThhDeQQ4+eQFYWgvXhIvWxb/fRIyn7R+M1JZiyFLatKjp75ksKlWlcnCw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1724225319; x=1724311719; bh=agpmT5i/H4I9CpFwP+ZgZCDHnOLE
	swww+MqSwwzRYZ8=; b=CD4PBk0nTfEcwRmSTLb00LxyTke0e9h96K3pvtM/vQuT
	nUj/T55rENl2EObR4RKtXVr7XtTYhdotS1bqc5G+vTwVO1x/36CkoRXU1bb9wfI6
	jcb3OjwbdWGv0AKMTsqlnnM23OEhVnCWp2QxCCjYBRyLkHybRsc/mmnMhP/p98Zd
	gXEr6dae2ZptpAhmcN0v9AnB79ns5uzVy4zsLdEvnkdIH/042yvVKJQm/dds7QS4
	wjloC1wYQmfLVXz1H8C/3i9c69pWfNagPv9/I44Lk5lQg9pKYlVaMmJWL4Dda/sm
	gfmjOZ4VsXw+HYjoCHbdsQ0sCFgjymCa0yZ04/cp2A==
X-ME-Sender: <xms:J5fFZviCwPo5hpGJY_IfGHEpW4UFiseQFqHTJdA3V9PNVcp9m7aKow>
    <xme:J5fFZsCvOM50C-nTKMjXjWkUUe3tH7MrybnlNcUd0zsOg8tE-HtA8Q2QobKkWsjCf
    5BmHIqYi84MT3z4tA>
X-ME-Received: <xmr:J5fFZvGsaTgDUEUriVUh7g275NXeWteRY0GQl8-urjoX5oV0aEcaLxZ_-8b6tSskUtHz8bCeEjT_Hgj0xkGzCIfgv50FM8p8H_OeYHmVsy7KNQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddruddujedguddulecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddv
    necuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrih
    hmqeenucggtffrrghtthgvrhhnpeejffffveehtedukeegjedtuefhjeeghedtffetgfeg
    feeljeefhffgueehjefhvdenucffohhmrghinhepphhkshdrihhmnecuvehluhhsthgvrh
    fuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgs
    pghrtghpthhtohepfedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtoheptghhrhhish
    gtohholhesthhugihfrghmihhlhidrohhrghdprhgtphhtthhopegthhgrnhgurhgrphhr
    rghtrghpfeehudelsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrd
    hkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:J5fFZsSUbqfrrPSzAMtt2HvKGzP8pv9-yah9htoMy28HUR_vQLcFwQ>
    <xmx:J5fFZswzsfxlqdAkPQXbuj7gdRrDuAROnUTQNOOk3i8pGdZUF1bqsQ>
    <xmx:J5fFZi7y8vQB1bWzzbKkNn81iAV8HDAg7LG4uJG5ohumr3JRWMm7Lw>
    <xmx:J5fFZhwDDCoYQ49MawbH53_DDlTXyi_fA6bCSbJnxDhWkgynsJvZpQ>
    <xmx:J5fFZo8vCvBGymBhXgQDyGcaoeXyL6qLj2PctA68XiSulIdMoQ9i1Axf>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 21 Aug 2024 03:28:38 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 3eb569dc (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 21 Aug 2024 07:28:04 +0000 (UTC)
Date: Wed, 21 Aug 2024 09:28:34 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Chandra Pratap <chandrapratap3519@gmail.com>
Cc: git@vger.kernel.org, Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH v2 09/11] t-reftable-block: add tests for log blocks
Message-ID: <ZsWXF_zJTIsp8XOE@tanuki>
References: <20240814121122.4642-1-chandrapratap3519@gmail.com>
 <20240816175414.5169-1-chandrapratap3519@gmail.com>
 <20240816175414.5169-10-chandrapratap3519@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240816175414.5169-10-chandrapratap3519@gmail.com>

On Fri, Aug 16, 2024 at 10:55:32PM +0530, Chandra Pratap wrote:
> @@ -103,9 +103,97 @@ static void t_block_read_write(void)
>  		reftable_record_release(&recs[i]);
>  }
>  
> +static void t_log_block_read_write(void)
> +{
> +	const int header_off = 21;
> +	struct reftable_record recs[30];
> +	const size_t N = ARRAY_SIZE(recs);
> +	const size_t block_size = 2048;
> +	struct reftable_block block = { 0 };
> +	struct block_writer bw = {
> +		.last_key = STRBUF_INIT,
> +	};
> +	struct reftable_record rec = {
> +		.type = BLOCK_TYPE_LOG,
> +	};
> +	size_t i = 0;
> +	int ret;
> +	struct block_reader br = { 0 };
> +	struct block_iter it = BLOCK_ITER_INIT;
> +	struct strbuf want = STRBUF_INIT;
> +
> +	REFTABLE_CALLOC_ARRAY(block.data, block_size);
> +	block.len = block_size;
> +	block.source = malloc_block_source();
> +	block_writer_init(&bw, BLOCK_TYPE_LOG, block.data, block_size,
> +			  header_off, hash_size(GIT_SHA1_FORMAT_ID));

Nit: instead of a `malloc_block_source()`, you may use
`block_source_from_strbuf()`. The former will go away with the patch
series at [1].

I'm also happy to rebase my patch series once yours lands and do this
myself. Guess yours will land faster anyway, and there are conflicts
regardless of whether you do or don't update the test here. The same
applies to the subsequent patches which use a `malloc_block_source()`.

So this isn't really worth a reroll by itself, and other than that this
patch looks good to me.

Patrick

[1]: <cover.1724080006.git.ps@pks.im>
