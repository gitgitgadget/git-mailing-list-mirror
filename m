Received: from fout-b6-smtp.messagingengine.com (fout-b6-smtp.messagingengine.com [202.12.124.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB3E3273FE
	for <git@vger.kernel.org>; Wed,  6 Aug 2025 05:53:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754459639; cv=none; b=m/eg6iy8syQtLv88wnx7a1JsxzniC0HsDs9Y6kCQGR89DXVcCDRC3v+j9TjyZB88LNvE6lriReORA5BV3kbeb3EyvwWr6hgDw64lbwECLo1oQdG3y33blyH3/sd8KghZIWnQGtjlFjEr4AumvVR3+RvsEUe3gZeOxTmhYykpGR8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754459639; c=relaxed/simple;
	bh=SjJc0mN/FtoRu7FZNII8Fo6vzm5UzcPCjAo3rfk23eE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GvAuB6WStryxYXJmV2nzcI9plGlTYtq2YykOgvjeuTUxaMgWP/7uIrP+YwN/Ygoms+DjaVVUbWB3f+ZgU5tM5WFui51NXwvT6BRPKRvxJvJ6PqAEARxPZm2WcLRCQEXwPYcH5PlpDLfErka2VwJ1tCUTL6nJ5y9tC0iWDsV4LtM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=bw+vGFw9; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=jlGpNT1z; arc=none smtp.client-ip=202.12.124.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="bw+vGFw9";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="jlGpNT1z"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.stl.internal (Postfix) with ESMTP id A17461D00103;
	Wed,  6 Aug 2025 01:53:56 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Wed, 06 Aug 2025 01:53:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1754459636; x=1754546036; bh=K/4VsbvCEh
	76Ef/JKSgl2N0o28R9aXDNMQV1RgRupbI=; b=bw+vGFw9cm1qHaocj53LuhcGcN
	C+1hv91pZsHa94+WyWxiw0YksGUd6xTSTNbkkV+kcbnkxRAyxBD4kn5H4eqvEF0M
	WthuN6DtvhScFId3Xwblaf6i/PuzAj7rJceCNQ7WJS9D9YZ2JhS/XFE+E81ISNLr
	Z8L2jVzKH06/L5Ef0Aopa7MNIB8l7dDWZ8KHGzHHHNzwllMeQTjzXSJre3qEci0B
	BR1Q/m2FjB/Jhu6wcagQwT3K5Nnf/UIfa18wHkbxXfTZJEu9Jo6PVTgyg8q+8Y20
	5WW82XL0HNjWIlxgaclWvLxykggUWmEJ5bSUHId4/IBYuiJBb/BJf+JU20Sw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1754459636; x=1754546036; bh=K/4VsbvCEh76Ef/JKSgl2N0o28R9aXDNMQV
	1RgRupbI=; b=jlGpNT1zI4T2njYG1Bhs9g6IrunbajGL5zD7JW7RadjzM9m9qOI
	UKPnNqZFhxIDwMSJEO7HcS6i9b6Hs8BLdBMF/vud6XYrzXoWm6qTbRFp9SGrvuZ/
	hm0JK243wg/4ZQ0lHpCjVR9yggQ4qJTA2TX9FALQE4ByYSvi5uKjJ+sGnmzYUQQM
	9Zgh4rrdHc1MZtcOjBf39hiJGQyIF/qXLe9YBpLkeNAgxEid9rbsWBknVYQlwWJK
	KlsneMFZflpWgfI9nSBpUgDvqPWS3sOhf8Ti6KlnUprSimDtaKnih//yvmitAKwq
	+JW92BPyxTLdvXgKQUVKTfy5M3NTPrAUcsg==
X-ME-Sender: <xms:9O2SaBWjadMpZ8cBMFgPqgomN5rWVQqMzanYWvkx_bu6IlLqgzYOkA>
    <xme:9O2SaOci-QBR_2Sj8LRvzr88LQQkSbnFZ4N65wMgqOw_orOSU3YLDMYLQej1BgUYr
    Kz4JE-dpguk2fBhzQ>
X-ME-Received: <xmr:9O2SaNIb8Mu7QrxuQyfxswTbOEglbp61n8iYX6boHm9zNXPFX31a1EagzdnQdRMpJJ_pmRfBtNhLM4VXTs4MsGs0IPI692A0x70Rqp7f_w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdduudejvdeiucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epjeevudeggfffffeigeethffgieekveeffeehvedvgeeiteegueejleeihfeitdeunecu
    ffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpedtnecurf
    grrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeel
    pdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehtohhonhesihhothgtlhdrtghomh
    dprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohep
    phgvfhhfsehpvghffhdrnhgvthdprhgtphhtthhopegsvghnrdhknhhosghlvgesghhmrg
    hilhdrtghomhdprhgtphhtthhopehkrhhishhtohhffhgvrhhhrghughhssggrkhhksehf
    rghsthhmrghilhdrtghomhdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtoh
    hmpdhrtghpthhtohepkhgrrhhthhhikhdrudekkeesghhmrghilhdrtghomhdprhgtphht
    thhopehsiigvuggvrhdruggvvhesghhmrghilhdrtghomhdprhgtphhtthhopehjlhhtoh
    gslhgvrhesghhmrghilhdrtghomh
X-ME-Proxy: <xmx:9O2SaDy0UtESocF3MK1mHCn6vi5BDUC4DLEorLGz_3gRni6ClyzR4g>
    <xmx:9O2SaLtbFq_lDm2BZDg7jqhQcw6MYb2o6xPARd3km65JiQ2_ILrvpA>
    <xmx:9O2SaOAMWiZL3beQzWOII_KvizTbR_EahToSMHXXaR8CP5c9LnwKNQ>
    <xmx:9O2SaFGiNNLHZCWeKp-nuHnc-SiWMa3i8bGZovWXxzgTrc2nM9Sc1A>
    <xmx:9O2SaM7fZLPVV8q5RwMedpf2C9QXD_xQDBdgIS_mU6LncatwLjrQWIus>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 6 Aug 2025 01:53:54 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 8c9e9e0f (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Wed, 6 Aug 2025 05:53:54 +0000 (UTC)
Date: Wed, 6 Aug 2025 07:53:51 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Jeff King <peff@peff.net>
Cc: git@vger.kernel.org, Karthik Nayak <karthik.188@gmail.com>,
	Justin Tobler <jltobler@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>,
	Toon Claes <toon@iotcl.com>,
	Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
	Ben Knoble <ben.knoble@gmail.com>
Subject: Re: [PATCH v5 0/9] refs: fix migration of reflog entries
Message-ID: <aJLt7zK8pZffHAOc@pks.im>
References: <20250722-pks-reflog-append-v1-0-183e5949de16@pks.im>
 <20250805-pks-reflog-append-v5-0-050997db09d5@pks.im>
 <20250805184712.GA1345110@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250805184712.GA1345110@coredump.intra.peff.net>

On Tue, Aug 05, 2025 at 02:47:12PM -0400, Jeff King wrote:
> On Tue, Aug 05, 2025 at 05:11:30PM +0200, Patrick Steinhardt wrote:
> 
> > Changes in v5:
> >   - Revert back to the logic that aborts the transaction if we see a
> >     racy HEAD update. It's the pragmatic thing to do for an edge case
> >     that is very unlikely to ever happen.
> >   - Link to v4: https://lore.kernel.org/r/20250804-pks-reflog-append-v4-0-13213fef7200@pks.im
> 
> Thanks, this makes sense to me. I hadn't reviewed the whole series very
> thoroughly, but I think others did. And certainly this version addresses
> all of the discussion I did participate in.

Thanks for the discussion!

Patrick
