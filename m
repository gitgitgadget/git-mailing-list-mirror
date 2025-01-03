Received: from fout-a2-smtp.messagingengine.com (fout-a2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9587117597
	for <git@vger.kernel.org>; Fri,  3 Jan 2025 13:08:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735909690; cv=none; b=PFY4OWVnD9e3NKo67cEGKycHnhD8C3OV0dQvxiOiJwvC7/iIBlAlT4cK5Xct7K8LEPM8bXOOcH0bLCEyYT5zWcXO5zSTp091wtgZU3dPEzZpXZ/6jZMLHUp6hkVb+HnYVIz+fZuhFhAxh4EmEFs2zWm2Ig+VrgVEmbJD2vDakvk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735909690; c=relaxed/simple;
	bh=+j8vSdVrO/rx3UBGxvkJzzX1C3tLZ5xUvY1PMtxjAoU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=afiT44idnKyT+gdGpHRs8uDkiH8NT6ln/KcnTPplOh3iFdGIkhWBB2sO7RkT0NOygvwTQ+jpsr7JMlieiYpF8OKZsaHsSCq4Cz6QYZVOm4Ub7lKLLQTvqc5WODCbwSwjwpmgpMacloF+lfNqDW6kbAZDOaZlieIFp4isApbgXKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=KHlnfEWq; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=b1jHIY5S; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="KHlnfEWq";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="b1jHIY5S"
Received: from phl-compute-12.internal (phl-compute-12.phl.internal [10.202.2.52])
	by mailfout.phl.internal (Postfix) with ESMTP id 99B37138077D;
	Fri,  3 Jan 2025 08:08:06 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-12.internal (MEProxy); Fri, 03 Jan 2025 08:08:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1735909686; x=1735996086; bh=iiKUWHRy4I
	gLmdnAiHZ4OxWbFKuFn8sngg4u+hwIGYQ=; b=KHlnfEWq+TjPWR9EMA/MeO0YL4
	pwhapUbsQIk2FODvrUQkRE74njXyjuPhWtApeSv07SUaQtJTY9W+A17zJvz0e19j
	MZNWUlZMc3xU6fSuo+/MfOEarlCtT3FA9KQcvqi0wY4P9+mXzL9bEOI90G1Gt0x+
	Pq1TRL/xgKWURd9Y46iCkxoNzL/InOB/XGzBJ6+B0mxDcIj6p2NNSYRoU9C02VSQ
	zqcpyRRJrT451sz4gHOmMVL4YTiBaB5Szv0qpZQli5Yi3owzgfzRRH70WFLZnKow
	TOJAim2yttjCivAIHnKUPoYgjnHWw1MQRa6DkFws6dxQ53eyRZnvQLe0zV9w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1735909686; x=1735996086; bh=iiKUWHRy4IgLmdnAiHZ4OxWbFKuFn8sngg4
	u+hwIGYQ=; b=b1jHIY5SrcGzFZkXw/3m5K8LB/FkDi6aVZ0luVlp6Pd1mWFTbn1
	ZCdO3R0CnurUZ2Eof2US21TRYfQ8n9bhlHw+pOk6K0tBCbomk1jnbQL9Eq2SvlH9
	1wPeaQOpBOGPZGjQHZkmeryCp2IYwIhR42LjCwgcrH8Q1fxTQkjpEESbwNa6bTe+
	eIN/8fmixfSaY9b5sWWvmdhfpeYXK6u3+Za5Mm7Al4SpteLA8ci1L+7LH4T9Cluf
	QXBs6MUbQh8g/MjYMfqYuIzJYBiT4ziqeSbYvAARUXrGEYzRuLjMsYSRO71jcor4
	SRgkUcE6awu1HVUmPgwPrZB0Qxvuq+mU/PQ==
X-ME-Sender: <xms:NuF3Z7isYg2itWJ5aTIatIGRajeU7tUWn9ITIDreGr1ozgBs1VNgTA>
    <xme:NuF3Z4D2xmswkckKOMSFSFs7xKkmKUjd5NxDRObL8Of-lVIcC2ci2xhfcCf5o6IU0
    fPFW51ZG1qh_CUnRA>
X-ME-Received: <xmr:NuF3Z7FMjtrax3btJVhK9jSmaD3bEeILpYZ8WSTzaMqSuOqQetwi6KfqMhhusg1KjwUrtRynY6aCG3k1xUJZX6ZQXFsFG04g61XqrGF5BvwnJlo>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudefgedggeekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvve
    fukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhn
    hhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpeevkeekfffhie
    dtleduiefgjedttedvledvudehgfeugedugffhueekhfejvdektdenucevlhhushhtvghr
    ufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsg
    gprhgtphhtthhopeefpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehmvgesthht
    rgihlhhorhhrrdgtohhmpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
    dprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:NuF3Z4QZjV2Y9Md3M6rDxgjUqsCenLOSOURh26bJRBx1T33ISVEeWw>
    <xmx:NuF3Z4w59NMkjFgjN9nMin5aONeHwn9xBNyor6KrU23lYfv_7bozXw>
    <xmx:NuF3Z-7kpqAkBVfGB7R7XPp3aSnLM8cw0TvpwIyjeE47ziM-_xBrqQ>
    <xmx:NuF3Z9zewjo9AxyxgaRC91ODBHow4ZhlcU0BGvX-w_HpjBdHJu8dWg>
    <xmx:NuF3Z0-6wSviL0F2DBir6NEVWtMK9lTcJtR_0BjF2LBmVf4UqQtjZxiN>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 3 Jan 2025 08:08:05 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id bc9c7dc6 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 3 Jan 2025 13:08:02 +0000 (UTC)
Date: Fri, 3 Jan 2025 14:08:01 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Taylor Blau <me@ttaylorr.com>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 02/10] builtin/fast-import: fix segfault with unsafe SHA1
Message-ID: <Z3fhK1ACzJfVehM2@pks.im>
References: <20241230-pks-meson-sha1-unsafe-v1-0-efb276e171f5@pks.im>
 <20241230-pks-meson-sha1-unsafe-v1-2-efb276e171f5@pks.im>
 <Z3LNVzw9UlS7SWqe@nand.local>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z3LNVzw9UlS7SWqe@nand.local>

On Mon, Dec 30, 2024 at 12:22:34PM -0500, Taylor Blau wrote:
> On Mon, Dec 30, 2024 at 03:24:02PM +0100, Patrick Steinhardt wrote:
> > diff --git a/builtin/fast-import.c b/builtin/fast-import.c
> > index 1fa2929a01b7dfee52b653248bba802884f6be6a..0f86392761abbe6acb217fef7f4fe7c3ff5ac1fa 100644
> > --- a/builtin/fast-import.c
> > +++ b/builtin/fast-import.c
> > @@ -1106,7 +1106,7 @@ static void stream_blob(uintmax_t len, struct object_id *oidout, uintmax_t mark)
> >  		|| (pack_size + PACK_SIZE_THRESHOLD + len) < pack_size)
> >  		cycle_packfile();
> >
> > -	the_hash_algo->init_fn(&checkpoint.ctx);
> > +	the_hash_algo->unsafe_init_fn(&checkpoint.ctx);
> 
> This will obviously fix the issue at hand, but I don't think this is any
> less brittle than before. The hash function implementation here needs to
> agree with that used in the hashfile API. This change makes that
> happen, but only using side information that the hashfile API uses the
> unsafe variants.

Yup, I only cared about fixing the segfault because we're close to the
v2.48 release. I agree that the overall state is still extremely brittle
right now.

[snip]
> I think we should perhaps combine forces here. My ideal end-state is to
> have the unsafe_hash_algo() stuff land from my earlier series, then have
> these two fixes (adjusted to the new world order as above), and finally
> the Meson fixes after that.
> 
> Does that seem like a plan to you? If so, I can put everything together
> and send it out (if you're OK with me forging your s-o-b).

I think the ideal state would be if the hashing function used was stored
as part of `struct git_hash_ctx`. So the flow basically becomes for
example:

    ```
    struct git_hash_ctx ctx;
    struct object_id oid;

    git_hash_sha1_init(&ctx);
    git_hash_update(&ctx, data);
    git_hash_final_oid(&oid, &ctx);
    ```

Note how the intermediate calls don't need to know which hash function
you used to initialize the `struct git_hash_ctx` -- the structure itself
should remember what it has been initilized with and do the right thing.

Patrick
