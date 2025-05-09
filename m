Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 291E7228C99
	for <git@vger.kernel.org>; Fri,  9 May 2025 11:25:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746789934; cv=none; b=e6zOiWytVX+5Bgt8D+wCj6a35rWVpuPmm3vZvHknq9Qso/ElY7pFTGeWWpuZDRtK+9/+NbJXKgmHuLcIxT0bNCNsmz08twH9HCHODo9Y6Cp5JnTH757vb8gRGWy6lIOrBkJMitkgyPhGNKeqa2bjJqIUaFY079WzMkZW0qAVoRE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746789934; c=relaxed/simple;
	bh=wI8KNLa7HL0m9Vu57sMVoAlPaxWHn0B5IFvvN8eihs0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=maLqeBja87fUyimTzR4uVpBjfUKsDOHVgaDm6NG5gR2mXodOFlIvpGCx7qkO3hdD7k+AgEz0gYeYFhOXJe4yuAq7JKUj+VzJHO+FRg3Idup8CfrFJNVDjn6Dkfzg0fourQWXSsoN1lSl7CDm6RK6WK80SxDUsSMEo+6npHSsZiQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=oN7gCIgQ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=AjOvRTF8; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="oN7gCIgQ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="AjOvRTF8"
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 348C6114016F;
	Fri,  9 May 2025 07:25:31 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Fri, 09 May 2025 07:25:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1746789931; x=1746876331; bh=5rf1CHlOgF
	9C2qPmN7XLLAQDiivS0DEV7BOLNQ8Nydc=; b=oN7gCIgQ+6nTlE664bR8clkGwM
	AW6CFeCWtfPK4dW1rNNmgU+TDbD6Z9CWE8nxlYmfBIgdwwaXI2xIqPtbVulgV0An
	TOMKgD24kyhzMxKeLqAYotKRIWGQzwwrynWyVBfoVFU1W4yiX4Mnv6+HyVM8ho0v
	xVszPN/4JmDWKiCoJO/ArWfZm1WvUt+m0PajB0sXecWci/IUqjESsEfCOpzZrbTo
	N67ZL8sLMgtVgRuBWSx/eeo9zoLrQGZXOPevPN0dFcnTD1ra8c5UVEFOy+tWqn8D
	bDLT/Ep6lFqvFu2Q7GDLdTYed0k6GQRATHhFZ941sAPorM3xGaUpNuX1qblg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1746789931; x=1746876331; bh=5rf1CHlOgF9C2qPmN7XLLAQDiivS0DEV7BO
	LNQ8Nydc=; b=AjOvRTF8fFrR2XCe1Ud7Y/ZMG4mkK42FcRZ8TDQQTrsczMaKV6U
	aTe0URfa092eNJkb19nt7z3DEVPRLdbZ1KLqlyVuLrRgVY9xwGiK2zJ38bFekZPy
	WF6xNHxtuWSJ0d4KdtyBYJxSOxoGcjgKK6uRgVR+izGt5xMryteI4DkZWkHfN410
	ovHBSJX0HXx6y7WXBcnHzLReE46HcSRtlDq/Y3OPxdyiCahqldy5b809akkfu5Fd
	IS4K675LorxRPtldcsV3eN5ELbgAxbgOWixABtRjk9x1No9LIfB2UbVdHZ6HzBZi
	ff/tovp5KBS/vuQOSDYth4Ydij8fvywkDHA==
X-ME-Sender: <xms:K-YdaFmfmyS9e7QQT9sch9FG6RmYBLHvb9d70yjdRzn2YWQUiwjhKg>
    <xme:K-YdaA3rbsPNEnh36MuxuTRLecMgw77UVwg38MsdJ3UKpydlBBoGSmtHKCfqYHkcz
    3NQOiyxVvclFgmEUQ>
X-ME-Received: <xmr:K-YdaLoaxMoiz1U7k8PrLP9TU_Leypf2l0EMK1XKS6iAI8VvA6NcuFvcIroahvMLKLGWRJHlY8JvZ3VX1uELbJVljR-JyoVcm0_mHURlzA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvledvgeelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddt
    vdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrd
    himheqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefg
    ueegudfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpe
    hmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepvddpmhhouggv
    pehsmhhtphhouhhtpdhrtghpthhtohepshhtohhlvggvsehgmhgrihhlrdgtohhmpdhrtg
    hpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:K-YdaFnp3bkXn0rKcbL4Ep0v8VSOl1w8KOsMltKX-VkFJ0otl85hoQ>
    <xmx:K-YdaD0VcgsAip7x-JAYUPhdfY7KJr9ZF498KDq4z7b_d8JG9UKfGw>
    <xmx:K-YdaEt1ylk86FSW9RH36NqEqO1qJWQDu_sKDs_vAANW1GXdmCvHNQ>
    <xmx:K-YdaHXkVr6Q2WajPShs3plJPKhPP1lJ22S3-j2ZzYzSne1szCBVlA>
    <xmx:K-YdaLQChhNm8SI5w3M9d4fn85GY0FBiyOeBfW95JCNhpAYiVW7ty_rK>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 9 May 2025 07:25:30 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 24e20e1d (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Fri, 9 May 2025 11:25:29 +0000 (UTC)
Date: Fri, 9 May 2025 13:25:29 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Derrick Stolee <stolee@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 09/17] odb: get rid of `the_repository` in `for_each()`
 functions
Message-ID: <aB3mKS2aSQMKB0xo@pks.im>
References: <20250506-pks-object-store-wo-the-repository-v1-0-c05b82e7b126@pks.im>
 <20250506-pks-object-store-wo-the-repository-v1-9-c05b82e7b126@pks.im>
 <d3524839-a982-4be3-93ba-c35fdde3726f@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d3524839-a982-4be3-93ba-c35fdde3726f@gmail.com>

On Tue, May 06, 2025 at 09:21:15PM -0400, Derrick Stolee wrote:
> On 5/6/25 7:09 AM, Patrick Steinhardt wrote:
> > There are a couple of iterator-style functions that execute a callback
> > for each instance of a given set, all of which currently depend on
> > `the_repository`. Refactor them to instead take an object database as
> > parameter so that we can get rid of this dependency.
> ...
> > +/*
> > + * Iterate through all backends of the database and execute the provided
> > + * callback function for each of them. Stop iterating once the callback
> > + * function returns a non-zero value, in which case the value is bubbled up
> > + * from the callback.
> > + */
> > +typedef int odb_for_each_backend_fn(struct odb_backend *, void *);
> > +int odb_for_each_backend(struct object_database *odb,
> > +			 odb_for_each_backend_fn cb, void *payload);
> > +
> > +/*
> > + * Iterate through all alternative object backends of the database and yield
> > + * their respective references.
> > + */
> > +typedef void odb_for_each_alternate_ref_fn(const struct object_id *oid, void *);
> > +void odb_for_each_alternate_ref(struct object_database *odb,
> > +				odb_for_each_alternate_ref_fn cb, void *payload);
> > +
> 
> Here's another occasion where we should be careful about how we rename
> an "alternate odb". What is an "alternate ref" if we have different 'odb
> backend's (or slices/shards/odbs etc.). Should we be updating the term
> "alternate ref" here?
> 
> Changing 'alternate ref' would be quite difficult seeing how it is based
> on the 'core.alternateRefsCommand' and 'core.alternateRefsPrefix' config
> keys.
> 
> Perhaps this is motivation to keep the word 'alternate' but as a way to
> differentiate the repo's odb from ones it is borrowing.

Yeah, the next iteration will call things `odb_alternate` instead of
`odb_backend`, which I think makes a lot of the terminology fall out
naturally. The only thing that may be confusing at first is that we also
have a "primary alternate" now, but I think that's bearable.

> I'm sorry to nitpick so much here, but your thorough series is helping
> to bring to mind all of the different aspects that are being conflated
> by our current nomenclature that grew organically and is now being
> carefully designed for the better.

I very much invite this nitpicking on this series, so please don't be
sorry.

Patrick
