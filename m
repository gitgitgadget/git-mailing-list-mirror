Received: from fhigh-b3-smtp.messagingengine.com (fhigh-b3-smtp.messagingengine.com [202.12.124.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BC543C060F
	for <git@vger.kernel.org>; Mon,  6 Jul 2026 06:16:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783318568; cv=none; b=hAKG5Ir/fz8KyKCH/HbGhbG0JAKz14rhwN9m6r7NqBhxn1LIRgHhtxIy7DqlTC0Asd76zsOi8J8uEq2S8IOKmbGvyLJsEe6TwySwzoKRj0ubjEBIb9tOzjv/No+5ma/J5WzhNn06RNwTGmD1nBCrokuhLWc0UAdKQnBiYW5m9hY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783318568; c=relaxed/simple;
	bh=+XuIW7dSIoaCqmjg6G8oDPqXhnNtsAchs4ueZgAzWVI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kpU4IY/Wlrxu2Zz5QlNERp8SYff5f+opruWvgLBXTVx93tdsVTCcCdQ8nvaq4Ce9cDDAjhjFgHM+b5ViuegaBqnP3cdN3HJeONPrJArBbjUvLyodh/3cYTCmvKmgA5QC/e8dD38yLTXX2y0kMKRvLNax3iJU/BlDczagXOsDKc4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=EEbxexQS; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=lSBBMmwM; arc=none smtp.client-ip=202.12.124.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="EEbxexQS";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="lSBBMmwM"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 9D9697A00A3;
	Mon,  6 Jul 2026 02:16:06 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Mon, 06 Jul 2026 02:16:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1783318566; x=1783404966; bh=Fz+rIJWAt0
	q7Rwlaf38n7qtUIc+n3JDsxGIugll+bWk=; b=EEbxexQSvgDCSc7BPX8n3fnnQX
	PHd+OleetKun3R2vj7UISx2i5tzxKSmOKwCuJtw/kHex3vhUa17zok9GFMQbBK3B
	CEfyA8oB7UVVj+jeROeYmOuGPMNQHbbp9k7/HeLD6z9o131zGDpivOL8Y0IeJhND
	ws4fG672srM10JM+uXlWwy7TyVyOyCEskwzr+9jfUKOA5IM3j64J2CjAIcNUyDtn
	I+fkSaAUQCUlwSTKR8epvb0hLOWsgO7tAmPtW7AaQO+dmJR4WgiDn7uLvSls0wCa
	i8Zq9+uP+BYLesRYApo5WYOEEDAxezcqSW5sKvGuxN/r4Ed4k8fqaf+V1BCg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1783318566; x=1783404966; bh=Fz+rIJWAt0q7Rwlaf38n7qtUIc+n3JDsxGI
	ugll+bWk=; b=lSBBMmwMoIFdQkzjG5eszOEVqwiAyEXOQi4k6P3GnRsQ9PwiWi8
	whd35DDK1186xcF7zygQYPc+PKXwwC7ndKJwRkR7W7dM6Vp0ONDqfIPUGm+bgXHm
	pOcT5O3tXeTebFJYdFYIcixYfxPJ7z4vT7Hrf//0zsFcnN8XUj6BFbcJxBUuFbFg
	Krm04hDuMCFHP2oRijAQeZYItQA7N0jOn/cYsHMbQxZSxBTLg6qYjCEe2zEvSNzT
	qByUJNHnM8n47Tkr4pRyQC5+soTezr45P2RyIBW5vsBlZ4BhmucRVCohs3BAObap
	KROjsjEeJadNMiTrzxH6P9e57Br9hguUbJw==
X-ME-Sender: <xms:JkhLal5YfLjnbxiWSJOWMMs9NxoDyiz3ead5uA0mfngazdxA3s7Pbg>
    <xme:JkhLaqUL0PAc98c58JvVSFP19sNgppAYuCyTBJVQT6Uxi__HVX2g5vjpySBTF6mRP
    YeU0-Fq6VfHyBU-Mo5a5nCXrM-8uruXblN428LI-r8JWT6Vs7NOGg>
X-ME-Received: <xmr:JkhLap07pXnV9GiaqDvilKRE5pB0bHkelK3IDDEiuKotN0qucjwNnL6mOf_ae02nKiVUZ5k9Kwq7bsiy0VHusus0RrMTtQUUnxD8EpS5jts>
X-ME-Proxy-Cause: dmFkZTFU799QJVittf0RWk9R+cJqRTTBNVj+bmdoWR+QQ8CeIQdc8+JFKtDovsVUVco7ij
    ekU55hSuHvlpcyNQOQxNG7OAawrAS4/dbAFDzwj+9ayJO9lNqcGNFGvWuht9xbywF9A5Im
    +kqkxMwZ3m3Kj2nvqI5h4qJ19o77UatDbjOvPxB6us++Z3Ks4zpxuvTSmd2lcgs6TPbrNl
    Y4LhLo9Fxo1061ZRwUzBB429ZDz8GohAKlcWZsHeEt8EWIoxFvqm1ewuP7yDWaBsZYetlf
    NIBmLJcDINpH7wJTKXh0Kmlajsub0TOeAxqkWWJciB8vblv19bH8dxlRDeH35nmCvM0lJs
    IeRMbrtd2UImq6z2MVaUDXN4cX9t9R5Xo37bubaBaKKWiyC0c2W4ht7nxf/NX9/BQYvdGu
    5t27ytyco4XM75hPYnvbXxS9Ez05E3uu7fPBOJEFBmrd8qj7HDEIFfuBq28C2+0KcRpy+6
    p0LnhemE44YlgDPO9jYHYxdPZ9jsWrOTBFKO9lKXdLiBWGzL7DkF2RiBCL/7gO5UvbHzis
    Z6mMIrGa2cUrbr04jpPgbRpCsgjjodvsIDNL33ACYbV8RE0AY7wGVib0REDOp1CN4o+hxL
    061L/nqKpQMFUuXQT1ToZ8wPtqskE9TIr1g85qdAoAZYn2uubbnDZ9kr/Nqw
X-ME-Proxy: <xmx:JkhLan3zb0KkbniEW6FfQ7aIRSGrGMtg812ajbbLkjvcb7TVlqphUQ>
    <xmx:JkhLas91CiZvL-0kTVCYu3K23HGH1pOdeVFa1zDTMZk4IZiCQ2DqMQ>
    <xmx:JkhLak2ksb82fMRwI6SDRezmpPGPIFuOj2iUzK4Bu7_Q9A8N-JA52Q>
    <xmx:JkhLap8sD-OmLPBKLhxWHWkyE6xgsy_lREEj3Ri876fPr-8p9oRQ7g>
    <xmx:JkhLakZwCeEL2u46VDMo95Q5rNeNk6p0bzO4wEVRPdgAOGK3L2b7gAwS>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 6 Jul 2026 02:16:05 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id a4093a2f (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 6 Jul 2026 06:16:03 +0000 (UTC)
Date: Mon, 6 Jul 2026 08:16:00 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Jeff King <peff@peff.net>
Cc: "brian m. carlson" <sandals@crustytoothpaste.net>, git@vger.kernel.org
Subject: Re: [PATCH 7/9] http: discard hash in dumb-http http_object_request
Message-ID: <aktIIKuReMxJmDsi@pks.im>
References: <20260702075234.GA1548258@coredump.intra.peff.net>
 <20260702080707.GG2029434@coredump.intra.peff.net>
 <akecqPq4F702E8Cq@pks.im>
 <20260706000105.GA2301945@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260706000105.GA2301945@coredump.intra.peff.net>

On Sun, Jul 05, 2026 at 08:01:05PM -0400, Jeff King wrote:
> On Fri, Jul 03, 2026 at 01:27:36PM +0200, Patrick Steinhardt wrote:
> > On Thu, Jul 02, 2026 at 04:07:07AM -0400, Jeff King wrote:
[snip]
> The second issue is related: what should we do in other functions when
> the active flag is not set? For example, what should this do:
> 
>   algo->init_fn(&ctx);
> 
>   git_hash_update(&ctx, ...);
>   git_hash_final(out, &ctx);
> 
>   git_hash_update(&ctx, ...);
>   git_hash_final(out, &ctx);
> 
> In the second git_hash_update() call, there are two obvious options:
> 
>   1. It should do nothing; there is no active context to add to.
> 
>   2. It should automatically re-init the context (using the algo from
>      the previous init) and add the data.

Or 3rd: we `BUG()` when any of the functions is called on an
uninitialized context. That to me feels like the most sensible solution.

> The second final() call has the added bonus that it returns data, but I
> think there are two matching options:
> 
>   1. It should do nothing, and hashclr() the output (leaving it
>      uninitialized just seems insane).
> 
>   2. It should automatically re-init the context (assuming there was not
>      already an update() call that did so). And then I guess return
>      whatever hash that particular algo generates for the empty string?
> 
> Those all seem reasonable-ish to me and give a defined output at every
> moment (which is better than crashing). But it kind of feels like they'd
> be papering over potential bugs. Maybe crashing _is_ better (we don't do
> so reliably now, but a BUG() could make sense).

Yes, agreed.

> And the third is related: do we check the active flag when initializing?
> Right now the answer must be "no", because the point of the init
> function is that the input is potentially garbage. But that means
> something like:
> 
>   struct git_hash_ctx ctx;
>   algo->init_fn(&ctx);
>   algo->init_fn(&ctx);
> 
> leaks. That's maybe OK in practice. We could do something more like:
> 
>   struct git_hash_ctx = HASH_CTX_INIT;
>   git_hash_start(&ctx, algo);
> 
> where the INIT step doesn't actually allocate anything, and start() is
> the moment where you must promise to call final() or discard(). And then
> it would be OK for start() to BUG() when the active flag is already set.

I'd say being as strict as possible is the best way to go until we find
a case where it makes sense to be less strict.

> That was maybe more than you wanted to read about the topic. But if the
> request is for safer object lifetimes in general, then I think there are
> a lot of details about what that means.
> 
> If we are going to do anything, I'd be inclined to stop mostly after the
> diff I showed above. That's the only thing I've seen that would simplify
> existing code. The rest are mostly hypotheticals, but since Rust was
> mentioned, I wondered if you're trying to shoot for something safer.
> 
> At any rate, I would prefer to do any of this on top of the series I
> posted. I took care there to avoid double-calling final()/discard(),
> which could now be simplified away. But I think I'd rather see that
> simplification its own step.

Fully agreed.

Thanks!

Patrick
