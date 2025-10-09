Received: from fout-a7-smtp.messagingengine.com (fout-a7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03C9F23909F
	for <git@vger.kernel.org>; Thu,  9 Oct 2025 05:57:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759989431; cv=none; b=hqReOfLT8Hj7487eubkZmvKzjjK68vjtqiP07yJ1dIl5ipKfQG6iIYMFelBuEpYCXGVObOm7svulpCekSbN2N5wTjY7kXQ48sAJB1gnHVRVU/IcZi91H/JV2Jq9DXVSOSkx+2h/HU4d/80wlKUb8B+zv5uXPCnXUERa07tP+h80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759989431; c=relaxed/simple;
	bh=oDJMRKoxcJgNMiCUmJXNvsc0m28/g/eTfMCeMytAqd8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nbRe811VOP03HhXuDtbabkk0F+t1s5qztN2LXE3rUNljp/gXJFsuic1JzqwugKjKTLVSXhM2q8zF7YHcQBq0ki6Ea+grSqLvHDoZtmfT9cD0dqDGBuqnN+pscorV1w0X+0eqiMzQI0kgFUjIfGSLpr8Kbr5NM58fdNrZr+weN+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=GSEG4ndw; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Wq+0rEzU; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="GSEG4ndw";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Wq+0rEzU"
Received: from phl-compute-12.internal (phl-compute-12.internal [10.202.2.52])
	by mailfout.phl.internal (Postfix) with ESMTP id 1C25FEC00A9;
	Thu,  9 Oct 2025 01:57:09 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-12.internal (MEProxy); Thu, 09 Oct 2025 01:57:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1759989429;
	 x=1760075829; bh=CH2yFhsbABueNmu5/ftBzsZd3cymL24Yjw+sc6aQgl8=; b=
	GSEG4ndwriQ2tEfbn+EKr0o0LI57Bp7Xhs7459ZRPFNn4kB8Dx/cnTYz9KHUMwvM
	89Gyn6NvgYNFQlxbLwrwWf/faD8RcAEzbtbrY0bXFCEgsd0vqYH7BZp/9NjpCDb2
	rin2pCkp5YKhdO/5/alOHD/hx4XhtMu8jByQH/KDnuADjrZYgMRrPV6o2Cm/mt3e
	RVIVNQonYfWnWFKhASMVesionXKVQEUI9M7Wi91fPqQ7SBzus9wx6DKVwyFXjgTt
	zwr+b45qVcCg2C2FoTcBzA9AqeIJpjYFOau0sVEka4xcHsSHtR3uWBmdwXnpJ/yW
	ydUXSX5JGYUi8BFgUN8aIg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1759989429; x=
	1760075829; bh=CH2yFhsbABueNmu5/ftBzsZd3cymL24Yjw+sc6aQgl8=; b=W
	q+0rEzUHg+pcT1ZOjchR3ZJFBDPOiltCzmI5WPCpsou18QhvlKI46WbmED3DjsE4
	H4bByiIThLw84BRXJybGcWUwmzyA98MMqx6mAgMFhK11fwN/0UOIx6DsX2Gj8eUo
	U2w/hMqCaDOLKBluYNavrlYi6J7F02Izzd5vsQVU/PHP1vsfbE77PViZ7RJgLbHs
	TWdYleHxQ27uWFdd71A/4j84iRdmN0JFbHlqNVjLFtbuYIuGVHT54a2SvpPBMLvK
	sJaQjLhNLQz2Uv+Odc/dVk8GbNU9iI8JP6nEhYUXA62Nwv/8prWT0S4DPn2rbuk0
	B24cJAwfHRYlIPELRJ02w==
X-ME-Sender: <xms:tE7naJyaeinxmHYECu9nPgC0Jd5JUGioLDdeyppbB646sJND5_atUQ>
    <xme:tE7naM89XZcbQeo9v9n4J7gEh3MDF6wX4gfWRbpayczjvfSmlofDASXsPhLKAVwXA
    goBUvu-bKAOyblveHF3FrqczH5krxjk1wkRJRZgYQ3dUFEnClMI8Q>
X-ME-Received: <xmr:tE7naNKl0v06zU5PMI0zC6WydzEasDm4XuTSXD-LzdUVsf9J2NEBMztcVO9WV3Xc8UOHqWZY-HKmqPqgTaIz5S2hvyMPTRNgqTG0cwquWX8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddutdehgedtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggugfgjsehtkeertddttdejnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpedvfeejiedtteelheeiteekveeftdefvdehkedvveetffdvveevjeejleegtedvgfen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhmpdhnsggprhgtphhtthhopeeipdhmohguvgepshhmthhpohhuthdprhgtphht
    thhopehluhgtrgdrmhhilhgrnhgvshhiohesghhmrghilhdrtghomhdprhgtphhtthhope
    hmvgesthhtrgihlhhorhhrrdgtohhmpdhrtghpthhtohepmhhsuhgthhgrnhgvkhesshhu
    shgvrdguvgdprhgtphhtthhopehsiigvuggvrhdruggvvhesghhmrghilhdrtghomhdprh
    gtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhmpdhrtghpthhtohepghhithes
    vhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:tE7naCe2MDEy6-KNP0lyAfS11jM2wy8vQD0u86DWtldBLvZ-7ugXQQ>
    <xmx:tE7naM9nztlxIGy5tDpArK1Dxox2bo9hondrDK8H99viQdtkJDgiTg>
    <xmx:tE7naPpLKvL_vO_uPEdT2NAq-w6EBHzUAkah2RIacSCJSLWJCpKW4g>
    <xmx:tE7naBBsxQAHHGQiNBpLWThliLP1qswYKDQKxcSn7R60LxEmUQtTeg>
    <xmx:tU7naFjoZTwl2NZrBnCFWMjuvseCHjmePmHFxW5AiCwqpcD9bMrQTbUJ>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 9 Oct 2025 01:57:07 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id ae60f2e6 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Thu, 9 Oct 2025 05:57:06 +0000 (UTC)
Date: Thu, 9 Oct 2025 07:56:57 +0200
From: Patrick Steinhardt <ps@pks.im>
To: SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
Cc: Michal =?utf-8?B?U3VjaMOhbmVr?= <msuchanek@suse.de>,
	Junio C Hamano <gitster@pobox.com>, Taylor Blau <me@ttaylorr.com>,
	Luca Milanesio <luca.milanesio@gmail.com>, git@vger.kernel.org
Subject: Re: When should we release Git 3.0?
Message-ID: <aOdOqX45_uvsDXTL@pks.im>
References: <aNxivuJEnSHbQNdr@fruit.crustytoothpaste.net>
 <E03F997F-1738-4CF6-B7D5-206183FA5BD1@gmail.com>
 <aN1RFvz7uGPnepxe@nand.local>
 <aN5-n_ArhQqaQZgt@pks.im>
 <xmqqfrc1xqsp.fsf@gitster.g>
 <aN6j7giOosGreKUW@kitsune.suse.cz>
 <aOTrC8CRZm5hERgr@pks.im>
 <aObNPk8ily0EFNxM@szeder.dev>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aObNPk8ily0EFNxM@szeder.dev>

On Wed, Oct 08, 2025 at 10:44:46PM +0200, SZEDER Gábor wrote:
> On Tue, Oct 07, 2025 at 12:27:23PM +0200, Patrick Steinhardt wrote:
> > The question of course is how to get such roadmaps. The easiest way to
> > do it is probably to gather a list of known projects that would be
> > impacted and just shoot maintainers or representatives of those an
> > email? From the top of my head, that would include:
> > 
> >   - Implementations
> >       - libgit2
> >       - JGit
> >       - Gitoxide
> >       - go-git
> >   - Forges
> >       - GitHub
> >       - GitLab
> >       - Bitbucket
> >       - Forgejo
> >       - SourceHut
> 
> codeberg.org

Isn't Codeberg essentially the one driving Forgejo? They (or a
representative of them) would have been my primary contact point there.

Thanks!

Patrick
