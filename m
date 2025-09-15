Received: from fhigh-a5-smtp.messagingengine.com (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC5BB27A907
	for <git@vger.kernel.org>; Mon, 15 Sep 2025 06:16:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757917012; cv=none; b=oZOSPrTyHAoeBim1bSMtUg/lm97AIeiT9Qr1jYNvhnKg31zUDRQLUk1RmIZ0+FuuhOuvadvzrVUBsDgu8fsJeYgFOvVft6hi5hiyLiLJFkVz9+WW6xZMSF0EZLgrQEQWr5/RKneG6tnEGdp+mUnZXVMRvB1f5K3+IQIbbRTW0Ho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757917012; c=relaxed/simple;
	bh=VBCt55eWTaqiBlmj6diMXjPKxNhm53vrqybCvE5hCyQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=V1/C0GNEPDtaEZuPMlvOLcrI6jDvyPsH0M0O85lZ46aSPBiJFQ+s9qiS/sjCFAKT0T4kfLR58JtJ9zxxTxP94qNNS3Q8b9wPx68PFzMxKE37D8jbuf6yOxPiv8AYoSusO5komzjarO7qiMs0bnqTmhLxqvwh4vb0O2gvgELysdk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=iLOl7iIn; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=QLq9Inmm; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="iLOl7iIn";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="QLq9Inmm"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.phl.internal (Postfix) with ESMTP id B30251400045;
	Mon, 15 Sep 2025 02:16:49 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Mon, 15 Sep 2025 02:16:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1757917009;
	 x=1758003409; bh=YeM0omel5skepFrj5CLoQwPfp4BmBhlPiaH6MKBt51A=; b=
	iLOl7iInA/HBmozhzXBi1yneb4/xMxSkYkjvoTwrmn/JnNOhGWyP5eWqUsAAh1Ku
	osoVejl4QA6O7dMv4ObksD4Xx96+AD3mdU1Ag0rfAqoHJ0sBcR0Qm7lBeyIgQvMt
	Ge6rbiu6CU1AnSR0AhM62376fNYKvNR+HRpfzteGbGtElabUoAEtIr9WExjgkr2T
	WxeYYujJzU1tmpWVE71HhESjSVfQsFcCvRTt7PAWHyN5zT8tWtyTdw9QzXXFzWWp
	ve4locxmuF/5ajQg1f/DwdhmhsOK7hayfONqQDSguW4XbatA/62QewzkQw+wkcug
	dOz8tPDWPFjHwQjsoMmEww==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1757917009; x=
	1758003409; bh=YeM0omel5skepFrj5CLoQwPfp4BmBhlPiaH6MKBt51A=; b=Q
	Lq9Inmmdf09h/BxfvbATABB/tT9wfN6ShAXmxpu+8cVmDs1AaZmvCDsgtcj0ILoh
	TrCGBHD2mN9wW1f3irDClzbI76Thb2bcXD4Fk2Joo7ACvCkCmDACJ17yUUuIxK1s
	qBYadtkaR0B6WNrgtz6kD2ZfcCvR+tPF+Iqb9Um7U9S0wCf8tzuft/A3ZIBfKxkK
	TBHbwq2h1NUdy+vStXeAQYsgsSOvXlIaDezsEt+u7pUF2s3uLq1Lu5r4Z4AwrCG5
	eckp6Z9N/Gl65GuwnmnJuFnFgZNJtEockaVN7M5Tz2uSBUAc28q/1nMU7IRQX/hL
	57Itm3RCdMZ67glVjxHTg==
X-ME-Sender: <xms:Ua_HaLGqpd9uSyPcHg0v4eeSMQmJRiJ8NQhU8f7hZNlsEpmQn66SJA>
    <xme:Ua_HaIipWR4Pf-Ez5ifFxY8_aluesTGf4kZuX6Up9kfKXz7F9s4W5LZnYrUp3hn8q
    SeSD_8IFxx6J-eL0A>
X-ME-Received: <xmr:Ua_HaO-nt9vUv3YNpZtUf93P3FQMThVYYBrGHG03YzwTkeT2U97vmfE-eRuFDKYe3Rtwtx4LyZM9Lsp_U0aGzl8scgDToxJiYpN9Wy76xqbpoA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdefieelhecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecunecujfgurhepfffhvfevuffkfhggtggugfgjsehtkeertd
    dttdejnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhk
    shdrihhmqeenucggtffrrghtthgvrhhnpedvfeejiedtteelheeiteekveeftdefvdehke
    dvveetffdvveevjeejleegtedvgfenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgr
    mhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopedvpdhmoh
    guvgepshhmthhpohhuthdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdho
    rhhgpdhrtghpthhtoheplhdrshdrrhesfigvsgdruggv
X-ME-Proxy: <xmx:Ua_HaHq4LYoDBMoFxzI7E7iG7rCNL5x3MrQ9klI02xRAHCz62BndRg>
    <xmx:Ua_HaF8TRWM8LjWsFqvnI6xmwyReYtOQrPmYLdQOLkKhcADEoHy5Qw>
    <xmx:Ua_HaDVM-WxQ_4KXH7pX-sE2-h0BO3a7sKb7R89AKP2IT1QRn_OV4w>
    <xmx:Ua_HaDAIS0nu9jnB0ucQUb98ezuZYJdwRdMwnOdwBkAnQ65OMsxlnQ>
    <xmx:Ua_HaNrSXmG0abxUoVJf2ibrl4D4NWGeB5DyYMOdqILDtko2fZgiFYab>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 15 Sep 2025 02:16:48 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 8d201a3f (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Mon, 15 Sep 2025 06:16:47 +0000 (UTC)
Date: Mon, 15 Sep 2025 08:16:44 +0200
From: Patrick Steinhardt <ps@pks.im>
To: =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Cc: Git List <git@vger.kernel.org>
Subject: Re: [PATCH] use repo_get_oid_with_flags()
Message-ID: <aMevTM6YESMDdWPh@pks.im>
References: <906196ac-2fd7-4c07-9e8f-22d67b0b64f9@web.de>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <906196ac-2fd7-4c07-9e8f-22d67b0b64f9@web.de>

On Wed, Sep 10, 2025 at 07:16:30PM +0200, René Scharfe wrote:

Nit: it would probably make sense to add something like a `treewide: `
prefix to the patch subject.

> get_oid_with_context() allows specifying flags and reports object
> details via a passed-in struct object_context.  Some callers just want
> to specify flags, but don't need any details back.  Convert them to
> repo_get_oid_with_flags(), which provides just that and frees them from
> dealing with the context structure.

Makes sense. `repo_get_oid_with_flags()` is a mere wrapper around
`get_oid_with_context()` with an object context. So these two would be
equivalent to one another.

One thing that is a bit weird though is that `repo_get_oid_with_flags()`
returns an `int` even though it directly returns the result from
`get_oid_with_context()`, which returns an `enum get_oid_result`. That
shouldn't impact correctness though, and it's not a new problem.

> diff --git a/object-name.c b/object-name.c
> index 732056ff5e..52d87348d1 100644
> --- a/object-name.c
> +++ b/object-name.c
> @@ -1858,55 +1858,35 @@ int repo_get_oid_committish(struct repository *r,
>  			    const char *name,
>  			    struct object_id *oid)
>  {
> -	struct object_context unused;
> -	int ret = get_oid_with_context(r, name, GET_OID_COMMITTISH,
> -				       oid, &unused);
> -	object_context_release(&unused);
> -	return ret;
> +	return repo_get_oid_with_flags(r, name, oid, GET_OID_COMMITTISH);
>  }

The same is true for all these functions. It would feel more sensible if
those all returned `enum get_oid_result`. But as said, that's not a new
problem and doesn't need fixing in your patch.

Other than that all the conversions look correct to me, thanks!

Patrick
