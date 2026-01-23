Received: from fhigh-b5-smtp.messagingengine.com (fhigh-b5-smtp.messagingengine.com [202.12.124.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46B1B3624AF
	for <git@vger.kernel.org>; Fri, 23 Jan 2026 09:43:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769161396; cv=none; b=osMj/rV4vFDax/1Cifqk/vQaPVFPO1waaEfFmRz0Ea2kzuim0YjTKcXb4VEuaADtpBtyIGTmglJpoHqN23Cvf8nVNyREhF1SyXq4ZEOkNyVuYUMEjgxTfI0PLe5G1Qq2h/0xUUGC28lL3jrVDN1ewz3hgNF/ocUJmDe+wQ0wk0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769161396; c=relaxed/simple;
	bh=cVqYEC9hmGMAMhhbyRNJxumSKYmNgH2pf+4BJC1sM7w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=maJDo7/m9LWtckNLs9b2TREjJZi5Hpr5sjdKY0a3sTGbTw3Cx2JK8Q7Ahn338wisu8hkWmwpmUBuBYGD77ZfjPGHHiW6AduRkhiT7dgzUcdxASty6n319NG3YGMcm5F22W5kS6inAlszno+EIelg5d7NhFZusEosNbbZShD3R84=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=XVRNL5UW; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=XKWmq8cs; arc=none smtp.client-ip=202.12.124.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="XVRNL5UW";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="XKWmq8cs"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 63D957A00EF;
	Fri, 23 Jan 2026 04:43:05 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Fri, 23 Jan 2026 04:43:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1769161385; x=1769247785; bh=PGuNWwsuyE
	EnoPVaH2VscMiHpYiRLpCVWFJKRcIYNRs=; b=XVRNL5UWmp943QjV8XOJfWkMEm
	qVwj2wN9zm1WAZiTAHfmuFWVW9fetxa/jPJO9nMG9RTFTWvY0bBBZVE8We+oGIPb
	TIeWrRe+JFozCZT46h2lQ/BcC9oZOi+FSxAKevZNFTJC4KJvtJfy8fXC9Rz0Aplk
	GTOI+TTrRe3/GiSSihFkEFJdP5qp5h5GGHm9IPs1J+f9h0yNEnociA1FpZ14gQj2
	pdFWPkUCZMPSl7gUjPD08zT03sfyJ8lXl3LNk059W9C1wyAORCppUzNjOWnLoRlr
	qtRA95etO7v9QNJ36nXFiRj+xIuz9UATNOEaxiSOE5nTxLzkLxPjQ/b4xvHg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1769161385; x=1769247785; bh=PGuNWwsuyEEnoPVaH2VscMiHpYiRLpCVWFJ
	KRcIYNRs=; b=XKWmq8csIOv/J+lGPYcZitRSqlquxJiGzHxftKAulaFdvwe3gdA
	cYRNKt0AlmJ11BFP/TMtKXuovmnc8Dlg2sQKtoQ9ib1TCMCpChlGpg9GxJ/1TelF
	fdZ4H6fK0guLYj3DRTXX4PWAZFyEsRVJJJCm8vg4yT197NSsnISzWRZNG+0ldImB
	n0luJqq+DmM6SJ53mOZ9N6yw/6hJHGfiUzyIbpjvsXNPaJA7pnlBKlZVs0/9sn11
	NyFadd996tVGcaPRNp8Hl1d1DYxjyN6F7ve6h5btpPfcCirIESKAIRzGlYGV0RO0
	eehMbV7Uyj1FkBPzI2S9ovl3hL+Bs2cochQ==
X-ME-Sender: <xms:qUJzaTkRlFwsoH3CJcsTIDGknO5ava46KpnA6rM-XDgAmaKDLCNLcQ>
    <xme:qUJzadtxPdz0uBFR0lMo0FWKJ_Ai0OTSwLY7pZOEf0-nskn5AFWydWLnyBHQreLdh
    NEuCs-eeJxua1hNdPk1I5SONBxFqAKLBKrFUijYDfdk14sFxQWe0A>
X-ME-Received: <xmr:qUJzaR_Pan3gllJ_SJFEqaOPZH7NL30Cd-LmPE3YWYF7sJWweHuFI_TgDPWlwzPlKAlk5gEI7Pt0f8xJFhIn0Gk1hRGAwi6ISKBNWFG4wHyJ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddugeekjeduucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epveekkeffhfeitdeludeigfejtdetvdelvdduhefgueegudfghfeukefhjedvkedtnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimhdpnhgspghrtghpthhtohephedpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepkhgrrhhthhhikhdrudekkeesghhmrghilhdrtghomhdprhgtphhtthhopehjlhhtoh
    gslhgvrhesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtshhtvghrsehpohgsohig
    rdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtph
    htthhopehmvgesthhtrgihlhhorhhrrdgtohhm
X-ME-Proxy: <xmx:qUJzaXM0xbRIrEqi-om4Qqd0zRZNv9R1nNimu7WDtlnNzQpxG56X0w>
    <xmx:qUJzafFjMG6vF1EU1WavfnAGL1CIU5ZZQz_K2eQBAhgu7w4Jev-8qw>
    <xmx:qUJzaVRtjYhn5G3JqWrx6R86e6Q4riqnWyKWFMRn8CFzyiLqFL42hQ>
    <xmx:qUJzactMGiwGVFXcrt94c_Me7YFLzknmOUHMyVWkweFv-fPKYV3q7A>
    <xmx:qUJzadmcnIUr-7cgetW3cwuRrfXHwxM9IsLOAKvfHgo4AUQklPJM-P0l>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 23 Jan 2026 04:43:04 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 5b954291 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 23 Jan 2026 09:43:03 +0000 (UTC)
Date: Fri, 23 Jan 2026 10:43:00 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Taylor Blau <me@ttaylorr.com>
Cc: git@vger.kernel.org, Karthik Nayak <karthik.188@gmail.com>,
	Justin Tobler <jltobler@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 10/14] treewide: drop uses of
 `for_each_{loose,packed}_object()`
Message-ID: <aXNCpJ6q3HwcwhPG@pks.im>
References: <20260121-pks-odb-for-each-object-v3-0-12c4dfd24227@pks.im>
 <20260121-pks-odb-for-each-object-v3-10-12c4dfd24227@pks.im>
 <aXLEzAnNRTf5A6bt@nand.local>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aXLEzAnNRTf5A6bt@nand.local>

On Thu, Jan 22, 2026 at 07:46:04PM -0500, Taylor Blau wrote:
> On Wed, Jan 21, 2026 at 01:50:26PM +0100, Patrick Steinhardt wrote:
> > diff --git a/builtin/cat-file.c b/builtin/cat-file.c
> > index 6964a5a52c..7d16fbc1b8 100644
> > --- a/builtin/cat-file.c
> > +++ b/builtin/cat-file.c
> > @@ -846,8 +849,15 @@ static void batch_each_object(struct batch_options *opt,
> >  		.payload = _payload,
> >  	};
> >  	struct bitmap_index *bitmap = prepare_bitmap_git(the_repository);
> > +	struct odb_source *source;
> >
> > -	for_each_loose_object(the_repository->objects, batch_one_object_loose, &payload, 0);
> > +	odb_prepare_alternates(the_repository->objects);
> > +	for (source = the_repository->objects->sources; source; source = source->next) {
> > +		int ret = odb_source_loose_for_each_object(source, NULL, batch_one_object_oi,
> > +							   &payload, flags);
> > +		if (ret)
> > +			break;
> > +	}
> 
> OK, I'm guessing that this is one such case where we can't yet use
> odb_for_each_object() function directly because of the refactoring which
> you alluded to in the commit message. That seems reasonable, though I
> wonder if it's worth adding a /* TODO */ comment here to that effect.

Sure, I can add a comment.

> Just out of curiosity, what does that refactoring entail? I'm curious
> because I wonder whether the caller is just written in such a way that
> it makes it hard to immediately plug into the new API, or whether there
> are more fundamental issues at play that make the refactoring less than
> straightforward. If the latter, those could potentially help inform the
> direction here.
> 
> (To be clear, I figure that this is likely work that you have already
> done, I'm just curious to see if the details would yield any benefit to
> the immediate patch series under discussion.)

What this code here intends to do is to filter objects via an object
filter (e.g. "--filter=blobs:none"). The way I intend do introduce this
functinoality in a subsequent series is to introduce a `struct
odb_for_each_object_options` that contains optional parameters:

  - An object ID prefix that can be used to iterate over all objects
    that have a certain matching prefix. This will be used for example
    in "object-name.c".

  - An object filter that can be used to filter objects like we do here.

  - Potentially more things that I haven't discovered yet?

Once we have that, the filtering can then happen on the source level.
For the packfile store it would mean that we can try to filter via the
bitmap, if available, and that would allow us to move the logic that we
have here into the backend.

Patrick
