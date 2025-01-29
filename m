Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C23D19340B
	for <git@vger.kernel.org>; Wed, 29 Jan 2025 07:29:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738135771; cv=none; b=hmAEqGe6iybKr2txdeKR7f+WW66jtHXqQ3mGV1ejBysqhap61euMAWewieIOFHFyITRctW7gmfxRvc4kg8t1T7KYkqMWWfznzXPsoKWW298cK1pCZJeA/OodwDSFZgHJOCquMxQKSn7diJd49YQr2uxxL8oX3r4pKitAj13E90Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738135771; c=relaxed/simple;
	bh=cT7ND4h0yZouwvM4hq9GjW22p5QuGg/Na4bStncxvNk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FvEC4YEWDpwh8/EJ5Z8hOlJSkeDFbMDlR5305VaojmWq4A3o3Q/ofgiw8wkeQYDpGmamjLTq+B9jAj4gCVzDLEQ58/3UpqpZelKz16Ew1E8NUnBzWFxT5DYI86NxVHaNsjKqHozZJzEDSfzBx+w6RI17LVAGVNPCHGnvT6sDBE8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=iCMhZ59v; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Sm+oiATF; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="iCMhZ59v";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Sm+oiATF"
Received: from phl-compute-02.internal (phl-compute-02.phl.internal [10.202.2.42])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 2EA5D11401F4;
	Wed, 29 Jan 2025 02:29:29 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Wed, 29 Jan 2025 02:29:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1738135769; x=1738222169; bh=Dbo1PwG2tO
	sCKRK80sq5GWW5Getb6LwAFE5QTnQSxEI=; b=iCMhZ59vYRYrIiFBcENkfrngAe
	UlL9Fp9FNKR9U47+SJyhwVORkoEpuPb88uQ2pZDGCBfV9FJ+cTySX9Ipbz5QHBex
	62XMqJY3PVfWt9qnIUxpAD/Fg8imFr8LkDcNQksZRhbBKaCFOTva25zbMZEw88oI
	m3bCMq741STBEl7HGlrnv7NeuH5Qkd4diIf+rTj7Vz19qRcVl5JB8yv+wGZL729k
	Cs3Z4jqGGFrLYnNKxXK7gAsh6xo8aRLDq6fXQ+hSBzMX+2fzTJrqwNXywM2MUYs/
	Xj+3jFeQeQp4WuGqe13avKWhdWwDMK0+gJDOiHxE/MM1DA2zoLhdmmXlOUWw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1738135769; x=1738222169; bh=Dbo1PwG2tOsCKRK80sq5GWW5Getb6LwAFE5
	QTnQSxEI=; b=Sm+oiATFSb16tEhkPs5q5+Zg6Nb8dyILSUnzdh7cEQScNt8dxCd
	1t9ZsUERk/WXvvRPR++w1xLwhp8XUfJvrTN+Shz/HCJH5TjoSN5kzTKHhDhSaVEG
	fe3Q30vO/BHQ8jNe71FXS6Li5U8dMtBj3u+TabEeLL+cdBLfMlTp11E9cbttU4Ol
	ZwdXnsEvW4RWNED+zdktTiHo+5tTbTVR2T8YPVzKZNc/f0H0qBXLTRPHNrZSv88y
	/+jFPELRSdc9S8fOw7FDFHzh4LnK+MThK4a0dMHBwFIMm1SXCHaxWgT6uTMrZdv6
	FzoUHV8f7pszrOit/j5OUGAmjWckVl1o86A==
X-ME-Sender: <xms:2diZZ6SeNrh-OuQTvXLYw9O4SsGn2hIeW_8nMPkBBn_beR2ak50icw>
    <xme:2diZZ_z_7kDs3aYHqMKDjbsfq7bgbAtvsdBv8Jy-dn0ANhpfANnm8X0_cuXhPOJUK
    r0bYGza6LTisNeglw>
X-ME-Received: <xmr:2diZZ32-b9vUVCkL7VLMhsA-9ghKmoL1Mven1dmr8S4nFBw-GBEkliSLVe-Y4DXm_RQheXNmVW_JE048Dkecte0jWiHn2zSJ8B1hhxf5-IWgRz7jnw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvgedtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefgueeg
    udfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepgedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomhdprhgtph
    htthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepjhhlthho
    sghlvghrsehgmhgrihhlrdgtohhmpdhrtghpthhtohepvghthhhomhhsohhnsegvugifrg
    hrughthhhomhhsohhnrdgtohhm
X-ME-Proxy: <xmx:2diZZ2DV1xl2HIwR9w0oTPmfOo2IXF53MKWTttEVhwEddu9yjR_5CQ>
    <xmx:2diZZzjeXRumuXLgw4jZPD5PmcPsLDgI5TwrHYAVHBdzuXXLBRKLtQ>
    <xmx:2diZZyqKJOmpdHsWrcfiiM5DFM3RNL_BvBmu09EeAKSRUVr-0EC0FA>
    <xmx:2diZZ2ghBlYkcZohjzEFrxV-_MwA-1g5E2nS2nFMF8MQ7gwRACgSIQ>
    <xmx:2diZZzd1g6b5OrhVZvu40vWXQkV7RBca_qexzBynLl7jNSnlOmIKUSmO>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 29 Jan 2025 02:29:28 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 2ae10f65 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 29 Jan 2025 07:29:27 +0000 (UTC)
Date: Wed, 29 Jan 2025 08:29:26 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: Justin Tobler <jltobler@gmail.com>, git@vger.kernel.org,
	Edward Thomson <ethomson@edwardthomson.com>
Subject: Re: [PATCH 01/19] reftable/stack: stop using `read_in_full()`
Message-ID: <Z5nY1ryenuFuNpM6@pks.im>
References: <20250127-pks-reftable-drop-git-compat-util-v1-0-6e280a564877@pks.im>
 <20250127-pks-reftable-drop-git-compat-util-v1-1-6e280a564877@pks.im>
 <u7hbqd6at3owgka4pitd4vgzc5emgipnx3w4dat5ofpiv5hxxo@lbfj36uhqtsr>
 <Z5iQH4C2JqazaJUl@pks.im>
 <xmqqsep2oolz.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqsep2oolz.fsf@gitster.g>

On Tue, Jan 28, 2025 at 09:05:44AM -0800, Junio C Hamano wrote:
> Patrick Steinhardt <ps@pks.im> writes:
> 
> >> The cast from off_t -> size_t matches the currect behavior, but is it
> >> always safe to do this? In `git-compat-util.h` it looks like we have
> >> `xsize_t()` to safely handle these conversions. Since this series is
> >> moving away from `git-compat-util.h` should ideally something similar be
> >> implemented?
> >
> > It is safe, because a couple lines further up we check for `size < 0`
> > and error out if that is the case. So we know it's a positive integer,
> > and thus it can be represented via `size_t`.
> 
> Even where off_t (which measures on-disk file in bytes) may be wider
> than size_t (which measures in-core piece of memory in bytes)?

Wait, can that actually happen? Hm. I assume it can, for example on 32
bit systems with large-file support enabled. There I assume that `off_t`
would be a 64 bit signed integer, whereas `size_t` may be a 32 bit
unsigned integer.

Will address in v3.

Patrick
