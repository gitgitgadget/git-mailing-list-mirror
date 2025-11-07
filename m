Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D39B28E0F
	for <git@vger.kernel.org>; Fri,  7 Nov 2025 06:19:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762496371; cv=none; b=QqBWcKCoyDI58UPSmbsK1iBN/aKzYpvFCrjYw42USZyhBD4ne7Gw4BaJ5u+eLt4oic2hkqInvRMVTl0+uduOLU2nAhW98vaAaZJwy9+gBc3sYFYk+2GoDaxajWbgziVeh7UZuIolO2EpOOWZiC2K6P0FOaqyJUla8mKHNovdsb4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762496371; c=relaxed/simple;
	bh=dmMwM7DEIjTinevDpoZ8A9+S7J8zdoylo2rVJIJkBBk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PQPDuY3vQxjNfp/Oj+tUguODR1xwADN7hDFZxR9JUHIUXe+0Nd+Bq9l0mf2zRzU5xSMh4VCaSrjHYBVdDYwUBsSz8IFYS13z83GZn9VAwZ1EYwYcgWx0d5rBfOGjxLRdQH2tUYQowQ3FDy2Q2KpaxeGOsnHXH7NeEkCJrR8FnkA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=gDnkj6+1; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Xl3KhaqX; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="gDnkj6+1";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Xl3KhaqX"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 3D20D14001AD;
	Fri,  7 Nov 2025 01:19:28 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Fri, 07 Nov 2025 01:19:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1762496368; x=1762582768; bh=s9aG7N+mHw
	Vh7Vqp08qDzU3IlKoe/Rf7AQS+nR0mSXE=; b=gDnkj6+19Sg6Rn6SQmDhnnuGLn
	mEx6yO/2GsywGW+inlGS5qxPFEDeq2+4+UI8MZhiXLr44LxN5twYWEzbP0exDNdn
	1gX0h5XgIky8wOgPynaYKzsJpwq/f0nJo39ueXrmzj5kyJuo73T3WnKsuh1hkwKw
	jlXaKbEebBD2JGl6I3TzJ8zciHfIkcghpQSdLNwme6mdVcZ7p35sXZQbjBYguLW6
	DwYXts2rSvV1N3X8M6Xt8jl1ORp4SY8I4ngZP0fa4z/n148cl1E60BTQWSEucf0W
	KcAmgMF4HF1QTMkmPjvK0RDFz/ueA0Cb9nKt7RxbEK7N/mVOlFKfqrbX1fnw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1762496368; x=1762582768; bh=s9aG7N+mHwVh7Vqp08qDzU3IlKoe/Rf7AQS
	+nR0mSXE=; b=Xl3KhaqXvKDih8DSIu7zGHBTqGwyxby2OURVbdxl9wBS2Nh6XaI
	hnvd3PTr864oxvFG+yzluJDVBRXfLgQrLgF4cduZn84NTKQsMGh9T0eIGHGVLh9/
	KjUN9PdvIAU2lvAkciV937fS9taxVL2GeQnXgMtVPCEBN59MdKAicnip8O8hOlEz
	/m3MfhV+qG7dtM7JTsHEF8hoBOXDhmPn+iBttXo4VKR+adICOCm1DMpDbyg5OCC8
	yhAWzmgKTh+JyMCkbXo3XbmJVnK84L0+KXOC2ahs8iwgjrPHuocl5Mq5H5shhwvR
	ItG0uRTBfFzJ2/RkGYSxywakpB5//Qjs34g==
X-ME-Sender: <xms:cI8NabIM6PXzD37aS_e5dNqUfrqfyiK52efxo-s__kStTbwLAxXBhA>
    <xme:cI8NaVLz4BcIYRwNTWoBjR-4SPTXSUQ05YWvfcPtshxE397hvyXE7OsiuKGeROfS0
    RRbKvqZQTHDGzW_MjPUOwtpaqDpnT5IaIUzPC6cXpxXHuN_p_nq>
X-ME-Received: <xmr:cI8NaRU8ROWPzrXXTA5L2axj8UmCSOcjos0pj47bfb6cW77PbDimzZKvVY_0_cAR6rwI_WeJg20DT4yz6agdPc_XHcV6ucngFBXL29q4g5rrOA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddukeekledvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpeffhffvvefukfhfgggtuggjsehttdertd
    dttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhk
    shdrihhmqeenucggtffrrghtthgvrhhnpeevkeekfffhiedtleduiefgjedttedvledvud
    ehgfeugedugffhueekhfejvdektdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgr
    mhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopedvpdhmoh
    guvgepshhmthhpohhuthdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
    pdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:cI8Nafi7Pq1d6rqBnkuwG-Hwv9sgkE9RvkhPG_Toptc1_4ZnIINrzA>
    <xmx:cI8NaU9W_WL_Cx5ysYU2bmmXdjFr7YjIDjoXxaxQ4OQ1eVf28UH1hw>
    <xmx:cI8NaRCl1HESNrsx8GRFxhDSD038haCjTkuz7cwC3l6xkj_0BPYyRw>
    <xmx:cI8NaZJaK2pvb499GLu9NicNRWsJPO594vBLMDw96crb6N_AcD4Ulw>
    <xmx:cI8NaehbC-Z56mg_0V3jZS8S23fC1G98zL8UFkuYasg9ll2knUAFqtXT>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 7 Nov 2025 01:19:27 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 335d0b27 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Fri, 7 Nov 2025 06:19:25 +0000 (UTC)
Date: Fri, 7 Nov 2025 07:19:21 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH] object: fix performance regression when peeling tags
Message-ID: <aQ2Paa7pDTtbTRpC@pks.im>
References: <20251106-b4-pks-peel-object-performance-regression-v1-1-a386147750b0@pks.im>
 <xmqqy0ojjkmv.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqy0ojjkmv.fsf@gitster.g>

On Thu, Nov 06, 2025 at 06:33:44AM -0800, Junio C Hamano wrote:
> Patrick Steinhardt <ps@pks.im> writes:
> 
> > Bisecting the issue lands us at 6ec4c0b45b (refs: don't store peeled
> > object IDs for invalid tags, 2025-10-23). The gist of the commit is that
> > we may end up storing peeled objects in both reftables and packed-refs
> > for corrupted tags, where the claimed tagged object type is different
> > than the actual tagged object type. This will then cause us to create
> > the `struct object *` with a wrong type, as well, and obviously nothing
> > good comes out of that.
> 
> So does the flow of the logic, which led to the original "validation
> while recording peeled tags", go like this?
> 
>  - It is handy to be able to get peeled object cheaply, let's cache
>    it, because the same tag peels to the same object every time.
> 
>  - Usually when we see an object we make sure that is what we
>    expect.  Not having to do this validation costs us less, so why
>    not validate when caching peeled object?  It would amortise the
>    cost of validating the peeled object at runtime every time we use
>    it into a one-time cost when we cache.
> 
> But of course we do not really get rid of the type checking at
> runtime, so we certainly should notice, no?

Yeah, that's basically it. It's only the ref backends that cause us to
cache the peeled values, so the fix was to adapt them so that they know
to never cache data for corrupted tags. Otherwise we can end up in all
kinds of different situations where we may end up with an invalid
in-memory representation of the tagged object.

So the performance hit we have is on the writing side, and that should
amortize the cost somewhat. For the "files" backend that's mostly fine,
as we only pay that cost when packing refs. But for the "reftable"
backend it's less so because we basically pay the cost every time we
update a ref.

During runtime we (in most cases) don't verify the tagged object type.
We could, but that would make the added overhead that we now see as a
performance regression visible on every single read of a cached peeled
tag value. And I don't really think we should go there, doubly so
because the issue can only manifest in a corrupt repository.

One could of course argue that it's corrupt anyway, so why even bother
on the writing side? But such corrupted tags can be served to us by a
remote, and clients do not perform fsck by default. So it is possible
for such broken tags to end up in user repositories, and I'm not sure
about all the consequences it can have. So I'd rather put clients into a
position where they can at least detect the corruption at runtime, and
not caching the values is part of that mitigation.

Patrick
