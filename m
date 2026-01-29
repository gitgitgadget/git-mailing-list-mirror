Received: from fhigh-b1-smtp.messagingengine.com (fhigh-b1-smtp.messagingengine.com [202.12.124.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31E3F239E7D
	for <git@vger.kernel.org>; Thu, 29 Jan 2026 11:24:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769685875; cv=none; b=Qs6QKlTBjICYhnz8D5Fq8vjXFIMoWZNDa2yo4FB1IlVTBWjcCNitvh2q9CFyAZ9/GGRvjFQRmRQ1SnVED7c3WwGwrUgi1OYrRUrKVP6NwZLBSCg+X3/pYkJTenclNw38BCZfpmSDaNu2OI+cohaADfDjaIvSzQUmGLFC5eSUWaw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769685875; c=relaxed/simple;
	bh=4namsN0770lNBkIN0rSbwp07OKEpEjUz0W1+K6n1UrU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bm7hKKV75oJgOOY+4KDUUnVNECIuUR3fcioL0k6WTiakhViRAHIAuDo3NcmV3Do7JQlZtAzpG+T3IR8RSd6p5AD2uMyh6jpPVo8DayEafdBm2JJyo7LzlL6oE063p3AzOja7UiqhJJ9sy7obP8kzKFIEVNH7c4d2kwNY7ThA7zw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=bAKDtXpX; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Rl052W0n; arc=none smtp.client-ip=202.12.124.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="bAKDtXpX";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Rl052W0n"
Received: from phl-compute-07.internal (phl-compute-07.internal [10.202.2.47])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 827C87A00DD;
	Thu, 29 Jan 2026 06:24:33 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-07.internal (MEProxy); Thu, 29 Jan 2026 06:24:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1769685873; x=1769772273; bh=c77RSyl2M/
	m5FqmTRr/et6WYqik2CemR2eTFN3kTloo=; b=bAKDtXpXsr//sP6SWR3Mn4qXCH
	Ny7PcuC7s2+/03OGTvkrriVsBrnBx4nMOCApKKOum2T+31MeQpaS7+3CzvU8sOTB
	oaV+89yI4N/CWvzzWL1VPMUUinpXFJTyokJ1eOYlM30nYWHUYkYFHv7HLN6Hmk0Q
	3FwiR1dEjf+OIDUWe7k4YsxgJF2KWgqYft6taXN5GUxrgOb/a5Er09VaV4uaDlFD
	MWW1XSdzhPjBCZGTxl0iQL7qrESEuiqQbWavaMyN/TA/GERxJ/NJfIfMS6vhw9j+
	vlkKwxgkVJIjc1+Dn2p5bBC8A5qngozdead2ntYUxAeDkzdUc8W7Siw+2rHg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1769685873; x=1769772273; bh=c77RSyl2M/m5FqmTRr/et6WYqik2CemR2eT
	FN3kTloo=; b=Rl052W0nRHU7/2xNA+47aa5MU1eP8MS+pqVhHHsNx7/E8hFm3MJ
	9vJ+c5mF6Brx7bvpKEWYXgrg5YbAPH65HGh+/d0J9HmhiR1kHUOBekG3E5mVeDmD
	T4/r9SDUPyLKfvw40xsJLCrkPNsBjkhPydD1mpWuBxvD/3B2mgBOwDBq6gtrklB2
	qgA5Y6B4cCgjDZjVVFRSDFLPdOyaHssAK4WxAK2ymRw2bum4x2zeXupStsOLhFCx
	2p/KvXTXU7Rxiv27NWWPkqh7gyeJHu1m34qcnkUbEcZjo4kRFu2gdzSegtdtTGX3
	e/bvAnd6gtnMU4mAlqbvVKbFQhT1tWdLUHQ==
X-ME-Sender: <xms:cUN7acY9CVArS1134C3QAqW2AnkHMyWo4fsVtgpTUJCVUS8KonIBXQ>
    <xme:cUN7adbQiuA746W4Ezigxoa46cGdJA2zTK_y0-ZIWWiCio9IJ3c97aez53MYL1akc
    wMMSmgkYka2Jfolq_S_-hGeJ_DyN46btAzn04qgNEeLZQNrz5AO9A>
X-ME-Received: <xmr:cUN7aUklTKDWHYqbe1ep7lqTe-UXExY3a9c4RPD9uXrCSc8qwsYsyeNVxhMtxeIGfCSjZGXyFN1WB2G5OY4MRpYJN4ncEvsh2pkhx2-J>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdduieeitdekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epveekkeffhfeitdeludeigfejtdetvdelvdduhefgueegudfghfeukefhjedvkedtnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimhdpnhgspghrtghpthhtohepvddpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehjlhhtohgslh
    gvrhesghhmrghilhdrtghomh
X-ME-Proxy: <xmx:cUN7aRy_EX_MSv9xYlVh6xhDItiSiTjXNJ7INfpdttVepcJ8vkO5Ug>
    <xmx:cUN7aaME2GsYw0BVMJ3BVL-zlepKASCIqoh5azC9BqFyP6GnIKW3RA>
    <xmx:cUN7adRWAD16vflim9SSF5p9Njx804JxbfdjjCotp9hiyMzaO752dg>
    <xmx:cUN7aQYjLAZwp93Vuu08tzW1DTiupUrCHVKARmw7gAwhekUsiD-fXQ>
    <xmx:cUN7aSIlINo316ed1azFFT9xcpLR14NeoXJWTeRAF7sufMxf_inYAOwK>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 29 Jan 2026 06:24:32 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id ae08e96a (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 29 Jan 2026 11:24:32 +0000 (UTC)
Date: Thu, 29 Jan 2026 12:24:29 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Justin Tobler <jltobler@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 4/4] odb: transparently handle common transaction behavior
Message-ID: <aXtDbTuATmSkWRx_@pks.im>
References: <20260128234519.2721179-1-jltobler@gmail.com>
 <20260128234519.2721179-5-jltobler@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260128234519.2721179-5-jltobler@gmail.com>

On Wed, Jan 28, 2026 at 05:45:19PM -0600, Justin Tobler wrote:
> A new ODB transaction is created and returned via
> `odb_transaction_begin()` and stored in the ODB. Only a single
> transaction may be pending at a time. If the ODB already has a
> transaction, the function is expected to return NULL. Similarly, when
> committing a transaction via `odb_transaction_commit()` the transaction
> being committed must match the pending transaction and upon commit reset
> the ODB transaction to NULL.
> 
> These behaviors apply regardless of the ODB transaction implementation.
> Move the corresponding logic into `odb_transaction_{begin,commit}()`
> accordingly.

Besides deduplicating the logic, it also makes the ODB source only
care about itself, whereas the ODB is responsible for managing the
transaction's lifecycle. Which I think is a good thing.

> diff --git a/odb.c b/odb.c
> index 5b112f2464..332860735e 100644
> --- a/odb.c
> +++ b/odb.c
> @@ -1153,7 +1153,15 @@ void odb_reprepare(struct object_database *o)
>  
>  struct odb_transaction *odb_transaction_begin(struct object_database *odb)
>  {
> -	return odb_transaction_loose_begin(odb->sources);
> +	struct odb_transaction *transaction;
> +
> +	if (odb->transaction)
> +		return NULL;
> +
> +	transaction = odb_transaction_loose_begin(odb->sources);
> +	odb->transaction = transaction;
> +
> +	return transaction;
>  }
>  
>  void odb_transaction_commit(struct odb_transaction *transaction)

Nit: the `transaction` variable seems somewhat pointless to me.

Patrick
