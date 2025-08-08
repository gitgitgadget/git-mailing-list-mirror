Received: from fout-a3-smtp.messagingengine.com (fout-a3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE3F81361
	for <git@vger.kernel.org>; Fri,  8 Aug 2025 05:48:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754632101; cv=none; b=GRDYS0wOcbblmX6tqgsthMZoPobm7ou5VKvD+nrxtP0b/nv1a0u3+Q0FoHdmT6bX5uSi4GKF3RTAk8SxJOSb87+P0Fwg2pMBJcsxB8h2jYqCwMUmNwbGKnGlc7BdUQcbSclKrNn+E3aOCLht0gh9WA4vql8Ax9YAzdZgazYVtKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754632101; c=relaxed/simple;
	bh=rdlIl/sdqm72H+zjHquXEVub1d/5bE/XvYiGCGtuckc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=D7ja7cGOmLjf5qJ4hSQU00tfjlPg0YmNV/FMws1lA8leFRTEAE9E/fl8NPgP8ZfIgoc9vCh1DzvqWK2w/stbq9tgJexmvd99yUiCSCnhBXhJeZHEP9oc7CzJSy5O/RM3RUZzoQkKq/ypOvbNTbYgmnoBRI4/is8H+B6Vd1Nk0JI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=DB/vcHbk; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=NWuCLb6s; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="DB/vcHbk";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="NWuCLb6s"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id AADC8EC00DA;
	Fri,  8 Aug 2025 01:48:16 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Fri, 08 Aug 2025 01:48:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1754632096; x=1754718496; bh=QaWKsbJw+u
	1TjCXSnUKlLUfR1FUuB3K1SIFvB/R/g70=; b=DB/vcHbk83OfPvfpnFcBbfmi0u
	lKNvHPsz7LbuXFMYBCSsCZwYxlYWWMSEp/6Iy9GhF0OA0x2ZCEfH7mi5ab0Fttc9
	uLQwDi0p/DBjWrHaEZN9F9+WKUjHu/xs/EwocsBpXEARvWlK0eT+s6G86CPnsvlg
	Oqs7F2dD56xCcmvsmQdQmvoEaj8TtiEb+y1WBOTIXtwLsbm8LCPmI/KB7vpHLyhi
	JwFQ7njuuNjfntNdYtHWNBGwKKJf+4Ab+g+JH9/oZjftjxhmKHahnQoTDIA+GI1w
	ACyUIdMr96fZY04zLBBxtFPdJSOtbog0goVViQN9dwQnt7Fol9vAfYDy3veQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1754632096; x=1754718496; bh=QaWKsbJw+u1TjCXSnUKlLUfR1FUuB3K1SIF
	vB/R/g70=; b=NWuCLb6s+iMjEQJPnaNUNr/xzmzbz1dZPBXUwnTN77bT3JLKvUD
	+jQqESwEDtXJGJIytSvaLMa3+XB3aiuMhnmaJwg8halKV4o7REn2CIM5/KvTFlh3
	q5J4jHupyGWnjLWLD4p0iw11WqF+Twdgogk15OyWOEP9voCJzSKp8CCg+ddHAxt4
	BAXH/uWzo7DwbD6y4Cf7Ygxs4Gw5Pgl/AX6pxK8TLx7CO9Wk/eH20hsm2ZhDyqgo
	kArm80Or8jZ1rnk/KfI8KDYwIP2iCxl4pckLSj176OFZZaPUZoDi81v9lbz1lhUa
	6CFct2UWQvjLKNf1I/c0fzhIkB5F2SCOLoA==
X-ME-Sender: <xms:n4-VaCSBtYs1sllgDoHoURRmhhPb_SPDGmV8dUpxvgCdVE6Zw1Eo6Q>
    <xme:n4-VaCViaEF4swsjDufAijIMrhTvfRu5eCCYUQggil8_5aXIAEFUqdBekj5cqU7Mp
    w4NWLmADPW4YNdZlw>
X-ME-Received: <xmr:n4-VaMYV2wpbUnLEhadurZgXz4LRSANtzuD5PKp7bOXfxEkXDaF6EMyHYf4EJzvJZkxkb-uX2zfvhDO5XKnhhbMAsSqPB0x6zAFib8GYBg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdduvdeftdduucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    ephfeigfdvffdvtdeuhfelgfelhefgfeevueetffdugfehtefgveelhfeuueevuedvnecu
    ffhomhgrihhnpehgihhthhhusgdrtghomhenucevlhhushhtvghrufhiiigvpedtnecurf
    grrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeeg
    pdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrd
    gtohhmpdhrtghpthhtohepphgvfhhfsehpvghffhdrnhgvthdprhgtphhtthhopehlihhu
    rdguvghnthhonhesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkh
    gvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:n4-VaA1foejw_oAO3DA78P-TUAp96-LniOC_udSkrQKDnmk8zAV6aw>
    <xmx:n4-VaGh0rTxh9xrQuFgKFp35PYdsTWKTx7EwzAdTdnfoV4hxY0prWQ>
    <xmx:n4-VaMYTO7T4bCGuoRkqTNnGfBYslOLYcLmG11S02xhoNe4DGyATiw>
    <xmx:n4-VaOQ1oNpmnzVM9FFBzTwX0D3oSTvoY1amPAb6ye9RlbS5x9suiA>
    <xmx:oI-VaIuJJQh0SCKa7Lg2JYwsF3NmwWTzEtNKKRFsiWbt5Uhu0LbWYlVV>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 8 Aug 2025 01:48:14 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id fb44cef7 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Fri, 8 Aug 2025 05:48:13 +0000 (UTC)
Date: Fri, 8 Aug 2025 07:48:10 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Denton Liu <liu.denton@gmail.com>
Cc: Git Mailing List <git@vger.kernel.org>, Jeff King <peff@peff.net>,
	Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 2/2] t/unit-tests/clar: fix -Wmaybe-uninitialized with
 -Og
Message-ID: <aJWPmo6oGCuQvqMG@pks.im>
References: <d03308e9474f5e26fd4a5494ec243a278e971443.1754302009.git.liu.denton@gmail.com>
 <cover.1754371649.git.liu.denton@gmail.com>
 <8ed0ac14092e7ec979e53d2a3da84dfe884d6b3f.1754371650.git.liu.denton@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8ed0ac14092e7ec979e53d2a3da84dfe884d6b3f.1754371650.git.liu.denton@gmail.com>

On Mon, Aug 04, 2025 at 10:31:16PM -0700, Denton Liu wrote:
> When building with -Og on gcc 15.1.1, the build produces a warning. In
> practice, though, this cannot be hit because `exact` acts as a guard and
> that variable can only be set after `matchlen` is already initialized
> 
> Assign a default value to `matchlen` so that the warning is silenced.

Would you mind creating a PR against upstream [1] so that we also have it
over there? Thanks!

Patrick

[1]: https://github.com/clar-test/clar
