Received: from fout-b8-smtp.messagingengine.com (fout-b8-smtp.messagingengine.com [202.12.124.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C72C41FF61E
	for <git@vger.kernel.org>; Wed,  8 Oct 2025 13:45:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759931117; cv=none; b=MO62nnREUftInW45kXYnw6CxruxKSusqf2oKgvS/yIL8tmMOCOlA9FvyGJ/J/eQ57BxAelPgUXHQH86dFGB9WXr5b3yQ6MtaCVErMKhzGvXMQVpDv4+/IzU8IVAAdYtmqB8K8rLnzMXXCqfIXI5y0GydE7wTmhGLgkaiNQUYEv8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759931117; c=relaxed/simple;
	bh=bdiqnBsHNAIZrnaEKIkVj5obsz/f4W83hTns3vPRKmA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EU97ue69MpC2NZvCupOFMOv3b66ZTn0sYdv3+vHw5o4O4TAJXm2gncMTChXGoZj5JCqeDwnko1t6MXKUxezNGuX/b+9j+puv8rqWGJf4HI43NeghB5jJV7JiHX2jzd1wk42eAqHHKKs4sDSdo7EO6a2Pzy8JYD4T0qulZb1OOTE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=CqhKM8x8; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ZeUQsP6n; arc=none smtp.client-ip=202.12.124.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="CqhKM8x8";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ZeUQsP6n"
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfout.stl.internal (Postfix) with ESMTP id 094131D000A1;
	Wed,  8 Oct 2025 09:45:14 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-09.internal (MEProxy); Wed, 08 Oct 2025 09:45:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1759931113; x=1760017513; bh=CFNqQUFDGt
	8WpL3OHLQ2Qfwc5wd7rPi4JOHWopjSYO0=; b=CqhKM8x8zo9VpaWQIJU7iFoFXl
	iqQQ4Dw188/XWB3QHSRbOn90AS7Hr4/R4o3T1doA0BrZhhzNTl44z7aWl9cPCaFW
	ZKmPZR1Md1vbD4Yr7CquEgDeieQmu751AW3UwmmXIMrNFq6oxKV3JRNgnK94yrV+
	w9+5+Zj1dWoShyq2WaSLvqhxierb38GT+V1dh5NY6mMi/N9QcENy8VtSr5uplVAO
	jQGBvg/TFw0IGHKgyoiOSpTW7jg9mehSjRZIrVoiVhvzA2T/vJI+hIEG4BSfmD77
	LSBL8/TQqIg1PZTlJy4JE7iRLpAdIbgiL92qKGhQ8pWAh2Cf54usDInRSF9Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1759931113; x=1760017513; bh=CFNqQUFDGt8WpL3OHLQ2Qfwc5wd7rPi4JOH
	WopjSYO0=; b=ZeUQsP6nyb0/ed/w72fOEzxvV4NnjRIwmVFMBysJH3tlm6NW/ck
	rKAzeJShTjW/Kn3klnJdofFi1zjFZYIJqVPWtk++Yv6RIp7ZQID3oCOJHIkAHhCB
	rdlewnLTJWmxD39kDCoo/Qf+L8EKLtxW1gHW+XCj6aEMfQfFocKFeuSGqR6aaC74
	KW6j6r+MhWOmwgWmwNsGSrcmo66MiYaf/QeyDnaIGi9UJOEtgGKFWlYYB8xpnSba
	38eH+5ZHMSJlGO1YsSKASB5KujThWIQL2PAKnmFXqMyt4szT2BPsiDfCk5sfZLRH
	wcN3TeZ2+5FG3GVz0wbyRtmGXGZAKVDmyyQ==
X-ME-Sender: <xms:6WrmaAxNewgjI9UXTlr5sTiMEf-TSl2Hjg4WSvEH_GDGqDHyD8r7XA>
    <xme:6WrmaKQ1XKsq-_rfLs_6UrxknD8INQTfEyp2FMrLpC_cs6tcpii6X_tPRq8ef52A3
    XPrWAs_c4TS0eaN7kmmFH3BLcmya4dl_mAp_NXlur5YBzi8_rib-g>
X-ME-Received: <xmr:6WrmaP8k7a0Oxqo0Km0ii2PDWEswOcJsz-usmeJ55SGIBgFMRVOFsSE7k4fdOULy3vVWjaRkYPh3BzWydbXkRE2dYKAdKyKSOlw_SlCI>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddutdefgeehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epveekkeffhfeitdeludeigfejtdetvdelvdduhefgueegudfghfeukefhjedvkedtnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimhdpnhgspghrtghpthhtohepvddpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehkrghrthhhih
    hkrddukeeksehgmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:6WrmaJojJIJ0AVGE9o1stsxiNyV0G8Sq3SWzlFIww8OzGBZz8EiYGw>
    <xmx:6WrmaEkCHinIVyxkRo_HbQeNe5JJcpJJ7KL8o0w588Wp-lcqKREwPA>
    <xmx:6WrmaIJ6uH5Y649e9qcemE9tuTUIUsvwrgS87cwBwcFaJg4jlh7EGA>
    <xmx:6WrmaByoCTqZAOEDdcjn1Y8GlibLm6ePgqvzD-1-CNZJGo2ud9SzOA>
    <xmx:6WrmaMg4I-yp7u2XfCj73HBR-zxtHhdmo61xz7EyfiYZcpXS5HQCxGYE>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 8 Oct 2025 09:45:13 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 4a7b16fd (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Wed, 8 Oct 2025 13:45:12 +0000 (UTC)
Date: Wed, 8 Oct 2025 15:45:09 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Karthik Nayak <karthik.188@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 05/13] upload-pack: convert to use
 `reference_get_peeled_oid()`
Message-ID: <aOZq5UtJglYQhD26@pks.im>
References: <20251007-b4-pks-ref-filter-skip-parsing-objects-v1-0-916cc7c6886b@pks.im>
 <20251007-b4-pks-ref-filter-skip-parsing-objects-v1-5-916cc7c6886b@pks.im>
 <CAOLa=ZRdcXUQLXK1s1JLgZAcEYx=kT-eS6CMzCocJ9Oenia_Jw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOLa=ZRdcXUQLXK1s1JLgZAcEYx=kT-eS6CMzCocJ9Oenia_Jw@mail.gmail.com>

On Tue, Oct 07, 2025 at 09:18:52AM -0700, Karthik Nayak wrote:
> Patrick Steinhardt <ps@pks.im> writes:
> 
> > The `write_v0_ref()` callback is invoked from two callsites:
> >
> 
> Okay so this function does multiple things based on whether the
> capabilities are already advertised or not.
> 
> - If not, we propagate the capabilities and set the static variable
>   `capabilities` to NULL and also set `data->sent_capabilities = 1;`.
>   - We receive `ref->oid` as a zero oid for the hash algorithm being
>     used, we convert it to the hex format with `oid_to_hex()`.
> - If already advertised, we simply propagate the reference and if it can
>   be peeled, also propagate the peeled reference.
> 
> Not for your series: but this feels like the capabilities should be an
> independent function.

Yeah, agreed, it's a bit of a weird design choice that should be cleaned
up eventually.

Patrick
