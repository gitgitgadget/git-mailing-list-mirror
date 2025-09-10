Received: from fout-b2-smtp.messagingengine.com (fout-b2-smtp.messagingengine.com [202.12.124.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF5D7245028
	for <git@vger.kernel.org>; Wed, 10 Sep 2025 08:21:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757492516; cv=none; b=rhUBjLqkicqEkayfg5JDVdKieHIpc9/6bED/GI+n8git0hHtWDWbJnifnLf8aP2vzTbJi3tcLzbLP2R0wYyk9gr7G5eMM1LKgP/9+FAhTetHLge7IfAb8AN50dU1SRnqE+gYBNq4p8BOQBrtyK5J8Wcj1xEN4L0oZpV3gm69DVA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757492516; c=relaxed/simple;
	bh=FVPsEIU1HxoPmU09nN4UL/laRpViF4DtVT8uARh7Nng=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mydhtn80Riw8R8qoyHjQCvX3Xx+xsgpLTv3K1Y8KQBoFiGXquSlCT/wVgtSEWhVhkIA2IM5gTeYOTi40Z7nZ//x8ca8oALihItpP5C5N7YixUB2k5bzoYpT4Udcr2nnje/TRzKFHnFRXgbWjHp+uqdHB70J9NTuhZOqB30IA/uA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=pXuersoi; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=FaWQo2y3; arc=none smtp.client-ip=202.12.124.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="pXuersoi";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="FaWQo2y3"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.stl.internal (Postfix) with ESMTP id 83D7B1D0018C;
	Wed, 10 Sep 2025 04:21:53 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Wed, 10 Sep 2025 04:21:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1757492513; x=1757578913; bh=Ci6tDqKRcb
	Mi3j5o0aqllulLWz7jX7c0/T4I8NKWlnI=; b=pXuersoiPTPPfM5FaZPZ+QnGhc
	ZhfwlVZzwrH/RZG41QM7CemajjPTFFTvxQADFUogBVXHX94MAHxqOAaqaFkyj73M
	1SD8/kOxu1b8Erbyx07ThBniA2hYrQqu5YKvtKllqKeQOtQPnmDikPzk6rdp8dnw
	fCl44g/B0SmQO5qwh1fI5ad3TEqkOSKUTUYRZNVO651cXiTDlp2T0mR2nIxUm+OB
	prI5l3iFH8gAWjboXX/TPqPHJ9HOIJ0Fa9qNwUBDc6DsW13SCP1JC/LAnIpOnUm3
	4fbKE0urDU/7rkt9+gnln1HVsToJ0uvvMZpOAe4O/bWpF1d5aaiB3EODPPpA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1757492513; x=1757578913; bh=Ci6tDqKRcbMi3j5o0aqllulLWz7jX7c0/T4
	I8NKWlnI=; b=FaWQo2y3c26WU5eHBy0vMEhfIh67TtgQZzCD/dfK3gpFd14e0KS
	ITn8RMTJvBzoxvJ9oDMTzkdffl0uaiMavxZXTuwldQMxIU/tKqiBKCzdFEA68v7v
	6x8GMsxTdEEP0XSKXlpKcSHIrpTIvlpGQZWrro+M4/noSi12FOp1uRk2VEeZ+Di2
	oDbe+yjX9rv/mBweb7nFQzyA8qjKcYCtmAPoQFNS7viImWpZPD3a7q9KY1rB+oAj
	IjwWEg0dBnoQjRjUA9AT3qW5GJbejcRf2cw/7ZHZ02+0Uaou2WuTnsRqp4wsPLJg
	01BCzv5fH+uw6p4dtXoRAzfAaAStDlIMNBw==
X-ME-Sender: <xms:IDXBaBCJE9tdaJQoYEuXqf8pK3xghmE78yvxXbfDOXcUZa_J1-kE0w>
    <xme:IDXBaLVb_Lt_2epfx8lBNJ5_k0ctky2hYXFMMxyCf0g4irGVnZxbmfHA80jOvG9s1
    0m4zkJTm2FKTTyDIg>
X-ME-Received: <xmr:IDXBaDDOGmEetcsP52KfYWCeeC8on09EUPJB34anEXCmmR4EV_TKcqnBmlxtQWkipaB8mGUVXcOyObo9ob0s0hsixlXXSVIBsXlwdt_hXEo>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvvdektdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpeffhffvuffkfhggtggujgesthdtredttddtvdenucfhrhhomheprfgrthhrihgtkhcu
    ufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnhephe
    ekfeefgeegvdegvdeffeehtedttdffjeeuffelgffgheefleffleejvdefheeinecuvehl
    uhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrd
    himhdpnhgspghrtghpthhtohepudehpdhmohguvgepshhmthhpohhuthdprhgtphhtthho
    pehsrghmsehgvghnthhoohdrohhrghdprhgtphhtthhopehnvgifrhgvnhesghhmrghilh
    drtghomhdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhmpdhrtghpthht
    ohepphhivghrrhgvqdgvmhhmrghnuhgvlhdrphgrthhrhiesvghmsggvtghoshhmrdgtoh
    hmpdhrtghpthhtohepvgiivghkihgvlhhnvgifrhgvnhesghhmrghilhdrtghomhdprhgt
    phhtthhopegsvghnrdhknhhosghlvgesghhmrghilhdrtghomhdprhgtphhtthhopehphh
    hilhhlihhprdifohhougesughunhgvlhhmrdhorhhgrdhukhdprhgtphhtthhopegtohhl
    lhhinhdrfhhunhhkudesghhmrghilhdrtghomhdprhgtphhtthhopegtsgesvdehiegsih
    htrdhorhhg
X-ME-Proxy: <xmx:IDXBaIfvE7YzGwFG-lP6l8dYwAIRhLvUyQduZVgojNIDu5sxlO-Mfw>
    <xmx:IDXBaKq5zoX-OUcHidurbz6ceZPVth4H21hJkxVeBqy9j_o2TjH5Dg>
    <xmx:IDXBaJQ5b6kD29tDf2rVm8xNE4zqeleeOYB27nMDbzSOKkRdqv9u5Q>
    <xmx:IDXBaKVLGNUgap_VQmpLF7WPpYu5VpfHnOyJTm9xaKpd9KTbOLVbuA>
    <xmx:ITXBaAjzGKdIGIS5yLjRUbOwaZFiFjt9NiUDut79mlCLqxLTCpFP5lkc>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 10 Sep 2025 04:21:50 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 3e06aead (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Wed, 10 Sep 2025 08:21:49 +0000 (UTC)
Date: Wed, 10 Sep 2025 10:21:46 +0200
From: Patrick Steinhardt <ps@pks.im>
To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Elijah Newren <newren@gmail.com>, phillip.wood@dunelm.org.uk,
	git@vger.kernel.org,
	"Haelwenn (lanodan) Monnier" <contact@hacktivis.me>,
	Ben Knoble <ben.knoble@gmail.com>,
	Christian Brabandt <cb@256bit.org>,
	Collin Funk <collin.funk1@gmail.com>,
	Eli Schwartz <eschwartz@gentoo.org>,
	Ezekiel Newren <ezekielnewren@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Junio C Hamano <gitster@pobox.com>,
	Pierre-Emmanuel Patry <pierre-emmanuel.patry@embecosm.com>,
	Sam James <sam@gentoo.org>, Taylor Blau <me@ttaylorr.com>
Subject: Re: [PATCH RFC v2 0/7] Introduce Rust and announce that it will
 become mandatorty
Message-ID: <aME1GoS8M8QvkB-B@pks.im>
References: <20250904-b4-pks-rust-breaking-change-v1-0-3af1d25e0be9@pks.im>
 <20250905-b4-pks-rust-breaking-change-v2-0-6939cbf4a0b8@pks.im>
 <8a5394eb-bad4-42e0-82a8-fa73123e205a@gmail.com>
 <aLrzqR2Z9jz5CuJu@pks.im>
 <CABPp-BGpdEP9+CTApknmGNO=b=66bFKVzWL2s3gmgCMtTBTjPA@mail.gmail.com>
 <aL57ONmEKTmqFhIZ@pks.im>
 <aL9gDXNJCGH0eIsY@fruit.crustytoothpaste.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aL9gDXNJCGH0eIsY@fruit.crustytoothpaste.net>

On Mon, Sep 08, 2025 at 11:00:29PM +0000, brian m. carlson wrote:
> I may end up asking for some assistance in polishing and sending in what
> I have.  Most of what I have is reasonably good quality[0] and should be
> bisectable, but I'm up to 81 patches before the Rust part of the code
> (which so far has 12 patches) and I'm worried I won't be able to both
> write it and get it sent in in nice-sized series before 3.0 is likely to
> happen.

Oh, I didn't expect it to be that much work. In any case, I would be
happy to help out with this effort in case there's anything concrete we
can do here.

> Alternatively, we could maybe accept that interoperability is a
> nice-to-have for Git 3.0 and not an essential.  It's not mentioned in
> the BreakingChanges document, so it's perhaps not a requirement.  We
> could also have someone work on this as part of their job to get it
> handled more quickly[1].

I wouldn't mind that outcome, either.

> Finally, I am currently interested in working on the interop code (but
> have no problem handing it off if that works better for the project),
> but I cannot guarantee that I will absolutely have time or inclination
> to continue.

That is very fair indeed. I don't have the intention to force anybody's
hands with the proposed 3.0 timeline.

Patrick
