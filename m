Received: from fhigh-b1-smtp.messagingengine.com (fhigh-b1-smtp.messagingengine.com [202.12.124.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D943E2405EC
	for <git@vger.kernel.org>; Wed, 14 Jan 2026 14:11:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768399884; cv=none; b=Ck05UZe1DcLQqBqL3+z/x0eO2JsA3VFxv8CixA85888dUIgaEXo8dQo3LnSzeqyP1ZbP0/Q+5NuCEL+7NNZv5cbZg5tVY9/Yo8KGvzi0zZsMCcY+4gwUzcVpPjq0RTgijcx/dor0/xEDXCbXSFZIw0R7OyofF6ozBrcg1FHmoNE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768399884; c=relaxed/simple;
	bh=fhqR1G6mRJr89eYbXvl3mg7zWi8BW7qylwpILaiPe64=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=hVpJy4WwJuzgw+SITpyurYR1oVcrsK2HxNoULW3KeG23zOFCA3gvkhx7dP9tdRTsIfp4drabXk1XH8+aE8KiBdJmhUxM5KjQoVPeWIxGElsy0yP6z6qmrHJn4rBn6taaYch5sT4swEbtAcu+jh9CyueUTofOWVRhVbjPRsDrCyk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=YCTjMTlT; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=avgZlx9V; arc=none smtp.client-ip=202.12.124.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="YCTjMTlT";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="avgZlx9V"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 19FA97A0040;
	Wed, 14 Jan 2026 09:11:22 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-04.internal (MEProxy); Wed, 14 Jan 2026 09:11:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1768399881; x=1768486281; bh=UNKukdhGSI
	M/iW/YJcrdaXEjLv+2dAUD8Xj+sb4PUeI=; b=YCTjMTlTsF9tXqsrMIh4uB686u
	kj+cBIrritumD6KRKdnK64AWL9hsZwjm8YIlTIuKcbAcdOAzFWkU0B3vtGNVo1Qh
	4c8iHZJe9ZerpPvAFtX2252JUBAjs8gwH0zlUtVAAQx1CINKwIW1XPOA8q3+qdUG
	PhGCSJf8dQbDnCvM46+xGse3y3TQ3zsRVSdwEv3ns0ezJRb49Geyavru6ca0LsmZ
	dQl0lbVqnzwHosbaCt9iXO+rH8TwJSmpSPd7e64GUjK1YX/y9HEsI7gp1//uFkGy
	e7ZQvnUslLeBGLeYlE7BJnDtMWs6MuJfKqrO7cuuddH4RLDWbVCHPThSdyZw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1768399881; x=1768486281; bh=UNKukdhGSIM/iW/YJcrdaXEjLv+2dAUD8Xj
	+sb4PUeI=; b=avgZlx9Vt6Ezp5Zkh4qIJqYFmox8va6m3x0e915pGSwAkSlP4gK
	UO9EkhAV5ajSFYoGhonCeFXZGi5402tj7Dl7MfQ+8znRF19GJEtMHzLpIWkjHuYp
	gW3VYqLQj5BTpm9f82NhEH/tx3vPDD4HG0RsDEViAFul75u+D6+o325AHGjMaPEk
	wAFPmY0hM0wLIQawYZn0plqIEgWehUY9D9hvIM1XZZi/rIgoJ8dCXfR0WZrXRDwC
	pofz6eWA/rew0FKNyeLEMFnkmHESAihLUxBJAct3Le3Xnsv0FVv2tN0B7P+yHrnp
	LCXCvvaBXIaHofYAGhBZ2/+veU99iV/J9iQ==
X-ME-Sender: <xms:CaRnaU7Ela6Z1Ldaae13-95MtObjocWeRvE7SxpDxZE2JLRtEHqIkQ>
    <xme:CaRnaYKt2H4ZblA-1kRPFxQ_d4Y6m5aqdu03QRKPvVRxWcEa4ip1cgLxWP-kub4X5
    HO58fBhw8teaZPiQhVUg7q9E4GsoGB6dACWoND2tcQzgoiBulqrEQ>
X-ME-Received: <xmr:CaRnaVuIQEkPLiFO4BMQtZH_zQ51zpKTa2U4KkPM-zl4wtlW2duWxIuvQx4zJXYCIUCL42s3k-gR_ZSJp2pLRTV41BY1Rp6IhWQJBo8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdduvdeffeelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepjedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepphgvfhhfsehpvghffhdrnhgvthdprhgtphhtthhope
    grphhlrghtthhnvghrsehnvhhiughirgdrtghomhdprhgtphhtthhopehgihhtsehvghgv
    rhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepphhssehpkhhsrdhimhdprhgtphhtth
    hopehrrhgrmhgvshhhsggrsghusehnvhhiughirgdrtghomhdprhgtphhtthhopeguvghm
    rghrtghhiheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepghhithhsthgvrhesphhosg
    hogidrtghomh
X-ME-Proxy: <xmx:CaRnafI-j1eyE1O8d1N7sCwaDP64gG38G9edxiEddYh64dflMIJglA>
    <xmx:CaRnaW8NWCUXAu7WkuSn6Y8h1r13jLdzekpniF60JYeI_Yj5HPJ3EA>
    <xmx:CaRnaQzSMPnm6gJcMKoc7M9RMIz4sq_yy5Tu73DfvZY-Sn6N-3sLNA>
    <xmx:CaRnab6SanXPew0Oisjck1ykpemTvd1xpRwaa_gRE5s_NrucGDKFsw>
    <xmx:CaRnaapWSuZ_o7bc-YyMCfTkNC1Pz7YFl1kTVhYhlsTpf2UU3okjnr2u>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 14 Jan 2026 09:11:21 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
Cc: Aaron Plattner <aplattner@nvidia.com>,  git@vger.kernel.org,  Patrick
 Steinhardt <ps@pks.im>,  Rahul Rameshbabu <rrameshbabu@nvidia.com>,  Lucas
 De Marchi <demarchi@kernel.org>
Subject: Re: [PATCH v2] remote-curl: Use auth for probe_rpc() requests too
In-Reply-To: <20260114022057.GA858110@coredump.intra.peff.net> (Jeff King's
	message of "Tue, 13 Jan 2026 21:20:57 -0500")
References: <20260113031929.3746753-1-aplattner@nvidia.com>
	<xmqqfr89lkve.fsf@gitster.g>
	<a919f4cf-8355-43dd-a552-df99325e4cc6@nvidia.com>
	<20260114022057.GA858110@coredump.intra.peff.net>
Date: Wed, 14 Jan 2026 06:11:20 -0800
Message-ID: <xmqqikd4gu7r.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jeff King <peff@peff.net> writes:

> test_seq can take a format parameter these days, so just:
>
>   test_seq -f "create refs/heads/branch-%d @" |
>   git update-ref --stdin
>
> is enough, and saves some processes.

Ahh, I forgot about that one.  Good suggestion.

Thanks.
