Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 259BF27AC28
	for <git@vger.kernel.org>; Tue, 21 Oct 2025 08:06:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761033975; cv=none; b=jEbEnXt5yGrfFq+874/auWxCqnBgvfdJwxlEWi4sbXMFVymyF7MnBGiVLB1j7a0AEvQZQuUJDcdPgjwE7zAk7gvTqh65sOqLAiyzQ+C3D0g9hTlTJEd0AZPLHIlKQFl28dEMLlzfKVt/q05c3nYEt32duJffW3iKuo9lx8E9ffA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761033975; c=relaxed/simple;
	bh=lt9qbtJ8LPYJPAz+CGnjgwiMy8C4tnRI9fakFK4zUPM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=m+evqwrVsGM8QAfzrlzF+ZW+/hS/nTkBX3GB3aVI26TlciIaNj6ZMb4Yo+weRPygb1pXqkYCiXSEg3AoHj7MC7ZbRoIXJXRRA4HzBRIrqTyX6UmgxkZYKPeBfMWXbuyprLPHiU0rdC7DNHkEcfeCgkFiSSUSfjcWC27F6huWFC0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=LWRKZngE; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=OB2YL+ZY; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="LWRKZngE";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="OB2YL+ZY"
Received: from phl-compute-07.internal (phl-compute-07.internal [10.202.2.47])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 4FAF414000DE;
	Tue, 21 Oct 2025 04:06:13 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-07.internal (MEProxy); Tue, 21 Oct 2025 04:06:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1761033973; x=1761120373; bh=WCRK2JAJOh
	myejbR8iR2ZJs3md9YAv7K3wlhwTxmp1k=; b=LWRKZngEO1qm0nNDw8S4s2ambn
	qamGF8V6Sjw83X9YeQ2mcoYz60yqx09c/iA7zMYifw7jCMtOaBgcOH0HT9D3D9Rj
	lg5ezEn7R0YUsE9Wn++tMnOKW7ffRg3sVusQ5e2RznOJ340ornXWtMmCzIUvPCfQ
	HOn83pFuEVXO1rGehdcisxXbiI8t7xJQdQ/NdTtIXOtGl7Pob7jlen2m+xw7C+N4
	DLE7+VXxhFg7Hd0hiKh0dlN3SVEh6BuTiQwFlYqVDBualDPJveRXgR63Mwz6t1/L
	/opuWQuD+aRx9Kn9Pv6DcZH5MpqEq11KYmgwCkjSGWYEajtA0PJ2tNWRQyZQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1761033973; x=1761120373; bh=WCRK2JAJOhmyejbR8iR2ZJs3md9YAv7K3wl
	hwTxmp1k=; b=OB2YL+ZYwKhZrsMZ0P5CV5QkveGI2De1CElTib7azKiGQugPBN0
	KXjzrDEEThcpchikt9OZTu4oVa2GB9lMu7kQmjXEcPjYSx2lbmH3mK8AM1m0KSfz
	+DZAq9c7iDMJMGYQLdAgJkMBHQRwBiGD5WsPfgPX3MSyKLyLQkGtO89xYtOsAbG/
	JiYgvDbvHcVCCyw5xU8oanRNB/EAmUtoU7Q14eRChPhH7JCRM7Td70a/buG7WulA
	8peLz9HpsEXkTCWIK97sy/QksNwlWL6ou92xLMbaPxrpI3r1ndJMf4zFdrApN35K
	qYyJ5+L3mYi4DId+dcKhLp/IQCLecc//gRg==
X-ME-Sender: <xms:9D73aFQECgMUM_VewJyO5NcazFgTIbvDNenxkGSiVb4R6Av5KhNlzg>
    <xme:9D73aG9gCePCguTRGpcL5rotJzpNByMdk4aBXWMPyZVcq6h6zp-Om4sKULUenxQMo
    BlNoOesGgq7sLgFBehqB-a9w2x8R-24n2ZcC7_O2CyMnpfD51t2IA>
X-ME-Received: <xmr:9D73aGaLcMmhlfLIZTqrJ33rzKa2I-V2vkCAiSMQatzlTOCGgWC5ci0_EeFLY2qTaTZVx1PrRBYgvRIMmfnPoARMX7cutHQOJlTozhhRPj5Xrw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddugedtudekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epveekkeffhfeitdeludeigfejtdetvdelvdduhefgueegudfghfeukefhjedvkedtnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimhdpnhgspghrtghpthhtohepuddupdhmohguvgepshhmthhpohhuthdprhgtphht
    thhopehjrhhnihgvuggvrhesghhmrghilhdrtghomhdprhgtphhtthhopehphhhilhhlih
    hprdifohhougduvdefsehgmhgrihhlrdgtohhmpdhrtghpthhtohepvghmihhlhihshhgr
    fhhfvghrsehgohhoghhlvgdrtghomhdprhgtphhtthhopehgihhtshhtvghrsehpohgsoh
    igrdgtohhmpdhrtghpthhtohepsggvnhdrkhhnohgslhgvsehgmhgrihhlrdgtohhmpdhr
    tghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehpvg
    hffhesphgvfhhfrdhnvghtpdhrtghpthhtoheprggrrhhonhesshgthhhrrggsrdgtohhm
    pdhrtghpthhtoheprhgurghmrgiiihhosehgohhoghhlvgdrtghomh
X-ME-Proxy: <xmx:9D73aHqEqTob5ymR09HfAIziILRfDN3rr4XEL3Bq_AcPDdJto7JBSQ>
    <xmx:9D73aKRH-Sqove0BsNg8js-3s3t21GdiCDigp0PyQxEbbkBXHOuYBA>
    <xmx:9D73aLqrlXyYh8NNeMgJOWOjmj2xknM31sIKX7JbI1q7JbFaAIrN0A>
    <xmx:9D73aE1VRu-j4meB1wiWaLZHJSK40I74je72TT9MaQocCH5HU7CZAQ>
    <xmx:9T73aHCkKM8rNinQNmUpbw5nyaqa_dxjvFrgC2r-kjo-ILT9KaXNaC8j>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 21 Oct 2025 04:06:11 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id debbff87 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Tue, 21 Oct 2025 08:06:10 +0000 (UTC)
Date: Tue, 21 Oct 2025 10:06:07 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Adrian Ratiu <adrian.ratiu@collabora.com>
Cc: git@vger.kernel.org, Emily Shaffer <emilyshaffer@google.com>,
	Rodrigo Damazio Bovendorp <rdamazio@google.com>,
	Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	Aaron Schrab <aaron@schrab.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Josh Steadmon <steadmon@google.com>,
	Ben Knoble <ben.knoble@gmail.com>,
	Phillip Wood <phillip.wood123@gmail.com>
Subject: Re: [PATCH v3 5/5] submodule: error out if gitdir name is too long
Message-ID: <aPc-79_XLyTjA_w0@pks.im>
References: <20250816213642.3517822-1-adrian.ratiu@collabora.com>
 <20251006112518.3764240-1-adrian.ratiu@collabora.com>
 <20251006112518.3764240-6-adrian.ratiu@collabora.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251006112518.3764240-6-adrian.ratiu@collabora.com>

On Mon, Oct 06, 2025 at 02:25:18PM +0300, Adrian Ratiu wrote:
> diff --git a/compat/posix.h b/compat/posix.h
> index 067a00f33b..aa050fd58c 100644
> --- a/compat/posix.h
> +++ b/compat/posix.h
> @@ -250,6 +250,14 @@ char *gitdirname(char *);
>  #define NAME_MAX 255
>  #endif
>  
> +#ifdef NO_PATHCONF
> +#ifndef _PC_NAME_MAX
> +#define _PC_NAME_MAX 1 /* dummy value, only used for git_pathconf */

Are there platforms that have pathconf(3) but not _PC_NAME_MAX?

> +#endif
> +#define pathconf(a,b) git_pathconf(a,b)
> +long git_pathconf(const char *path, int name);
> +#endif
> +
>  typedef uintmax_t timestamp_t;
>  #define PRItime PRIuMAX
>  #define parse_timestamp strtoumax

Let's adapt this to our coding guidelines to make this easier to parse:

 - Nested C preprocessor directives are indented after the hash by one
   space per nesting level.

	#if FOO
	# include <foo.h>
	# if BAR
	#  include <bar.h>
	# endif
	#endif

Patrick
