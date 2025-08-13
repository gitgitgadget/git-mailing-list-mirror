Received: from fhigh-b1-smtp.messagingengine.com (fhigh-b1-smtp.messagingengine.com [202.12.124.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C07C5223DF5
	for <git@vger.kernel.org>; Wed, 13 Aug 2025 06:12:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755065536; cv=none; b=SS7MK8JVr4eGuwt79xES2lzQNFYJ/NdQl2O1jDCmVR89FAc2nFDqrWGmEoAoUfx4oSOJlQIIQZmzH7DVFlWI1N17vj6zbcFAXlWgjkYgmwUNl9IKuso5AHFUtTs4fiOv1Jkvmqvs8zG5ihGZQgV9SGJhmFHwjiPtEROlC3QQ6rM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755065536; c=relaxed/simple;
	bh=sOQp/uRfXqTc8szWWIhJJeIe9wSlmX9YeykSinxvhJ0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BjXJSYLwrmDEPCcvlDpfHas0aZtnf1DZERzl5Acfm2ZF+fvJobH9h0qUVSDz6tPB1BlM40IRqJctoXslH4/4KIQIv6GIuOwq00RdLLWN2qEPNqE2n33sc8s5Y/0gRE98XJNXmy1mrlnqMKCX7JTrrxq2JakFG2BYfgNiMpwMryY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=lgPylwFF; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=LQ//2MZy; arc=none smtp.client-ip=202.12.124.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="lgPylwFF";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="LQ//2MZy"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.stl.internal (Postfix) with ESMTP id A296C7A0108;
	Wed, 13 Aug 2025 02:12:13 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Wed, 13 Aug 2025 02:12:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1755065533; x=1755151933; bh=q8WMxPeCs2
	GbpzfMq9IO+UnX1N20b6uTqpx+FEbiPuU=; b=lgPylwFFh0uhhxS7jm0lg02BrV
	i1brelZfNGOVUDbcQK9xyr3cdADi11uDLF4KNkr2j7Tm+s3yBSNSRm4b5tArRV0e
	Tp1BlmkAtYSFkNfeQXnjZgrUjGihI9hqvQEZi9yQDPIzSLGtV/8be6VnRPJy/COP
	onYZKc4Hlb9LcgKMX1IpWms56jsAsg1VJZpM5GrbPNL0BjfSymLY7njmrwC+Cpud
	n8v8HFbd9GxmiBddH6GQFzeK0MDtnIbBwI+JKrqnCwXXMnLe84xGzFSrIlQXLLQa
	KOlZP5pjEVUMEhc7+pNzWFr6UD3c/xbtx6BsTAwPuwm4Eqm7cSe3PWsNdPiA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1755065533; x=1755151933; bh=q8WMxPeCs2GbpzfMq9IO+UnX1N20b6uTqpx
	+FEbiPuU=; b=LQ//2MZyIrXjNnnKVNBAKiFaLNk6DXQo6bKCu6fIWOg+jOPy5qr
	iGAR+3Mj6oPQfc8I5/MwGOod+bLsE/wunOHT1/4b6tvo+d6kmCS9CWKsaUrzaRI3
	vuCahtl5xjNU1mCYQmeX3ba/UjPc10h4x9zrKbWgdvQMeJHSLVhYsfcRfXrd1oBb
	W5WXO1NcI8ofnKDcKmERjHwW/1jyUtQ7htkN95R8Hn5/4GB1BhmVlhqbKQ+yCrlb
	U/vJ++t2oNZmHr53w3DkhRmBj4IeGbYXn7w4S9Y0JxmCPPionIu/i5flSB5CDRes
	8+hNX8Es0qt1kB8kwzwT7IVFUOxRicmucBg==
X-ME-Sender: <xms:vSycaD6dLc9iqSlycA4pm8FfoaSP0HncLiJUi1QrEBZ_AkYyaONL0w>
    <xme:vSycaEY67I2pM-_BopCTxCrJ2_cL7bLqfwdcZEzOlcVtSUhFSlY7RarRmt0F3d3jN
    JJnxBNlXH8EkY88rQ>
X-ME-Received: <xmr:vSycaA7eGJzYzZ97GyJx4bVUfd_E5cpf-Rse73K6qElvuL4RfdqZcaJJ8kVZjxZWbEIEfCnALAzkOJjV5ZrCN-UNcVPx-CH9XojJgDalVQU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgddufeejgeeiucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epveekkeffhfeitdeludeigfejtdetvdelvdduhefgueegudfghfeukefhjedvkedtnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimhdpnhgspghrtghpthhtohephedpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepshhunhhshhhinhgvsehsuhhnshhhihhnvggtohdrtghomhdprhgtphhtthhopehgih
    htshhtvghrsehpohgsohigrdgtohhmpdhrtghpthhtohepjhhlthhosghlvghrsehgmhgr
    ihhlrdgtohhmpdhrtghpthhtoheptggrrhgvnhgrshesghhmrghilhdrtghomhdprhgtph
    htthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:vSycaPDcFNzpxg8wYHmi7VcPAW5HafUs1BJfrzN1_AjG7Xa_FWjf_g>
    <xmx:vSycaOcLnkQ8og9B7uRBJGGFAkt8NMKIT2INmzqcwapAjgmWNZkEYw>
    <xmx:vSycaGLjKdeqGUYFlbYWuzN5aBYNZT_gTwXr8ZXSd7eWX4e9c6rNsQ>
    <xmx:vSycaB0e6dC5272QaXNvCy16ceVUv121CNQx5M73xLcRMc7pLnsoew>
    <xmx:vSycaEUQjgc9rJGPK3B0Z4Ot6yQ6r69uieuQaW8_VMy9LJ5Keb1OO72g>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 13 Aug 2025 02:12:12 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 939d36fa (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Wed, 13 Aug 2025 06:12:11 +0000 (UTC)
Date: Wed, 13 Aug 2025 08:12:08 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Justin Tobler <jltobler@gmail.com>
Cc: git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>,
	Junio C Hamano <gitster@pobox.com>,
	Carlo Arenas <carenas@gmail.com>
Subject: Re: [PATCH v3 5/8] reftable/stack: allow passing flags to
 `reftable_stack_add()`
Message-ID: <aJwsuC8ZUgcfO1zP@pks.im>
References: <20250812-pks-reftable-fixes-for-libgit2-v3-0-cf3b2267867e@pks.im>
 <20250812-pks-reftable-fixes-for-libgit2-v3-5-cf3b2267867e@pks.im>
 <dlqh2lcmz4kh7pvwwwfj2cewaqqrdnmixfwxey7u6xxqjy35yx@apdcts2rtyc4>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dlqh2lcmz4kh7pvwwwfj2cewaqqrdnmixfwxey7u6xxqjy35yx@apdcts2rtyc4>

On Tue, Aug 12, 2025 at 11:59:03AM -0500, Justin Tobler wrote:
> On 25/08/12 11:54AM, Patrick Steinhardt wrote:
> > The `reftable_stack_add()` function is a simple wrapper to lock the
> > stack, add records to it via a callback and then commit the
> > result. One problem with it though is that it doesn't accept any flags
> > for creating the addition. This makes it impossible to automatically
> > reload the stack in case it was modified before we managed to lock the
> > stack.
> > 
> > Add a `flags` field to plug this gap and pass it through accordingly.
> > For now this new flag won't be used by us, but it will be used by
> > libgit2.
> 
> It looks like we will use the new `flags` field for
> `reftable-stack-add()` later in the series though.

Good point, this is definitely stale now. Will adjust.

Patrick
