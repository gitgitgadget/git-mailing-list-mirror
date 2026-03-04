Received: from fout-b2-smtp.messagingengine.com (fout-b2-smtp.messagingengine.com [202.12.124.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9EE329994B
	for <git@vger.kernel.org>; Wed,  4 Mar 2026 22:05:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772661912; cv=none; b=ltd/nMhBwzgIDDMcUin1hVdil00sisyXl/hyBnYJc0BIufy5O5vpDU3HsgBw7ajimQ1BexqATdzrlknGMB5R5ar1YjjWcon2lacYzPWRsOcaIZoXsUmgZ0Gee+iP27FubY7he9xg7+PZdzkib80tiF+5PlLdxmwzObJg/whW4G4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772661912; c=relaxed/simple;
	bh=M4uqAx3xrqe3wkB8DcbLwtiMM2G0Ff6lNFVtRZVynug=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=TPadlyiGEOn6fqUaGEKpivnamCtdOF6g8om//mbtD1pLbv7YojgIyfUYYRXvsMdAb+z/EEV5PNYgPamMFcweIPCkk+cSImV9W92+iNb+y6m4XgmC0WjQflfY1A0z84lUiKWVVOlAOYr+zxkS8j7pmspTRfebtrBvlfWVSv8UWHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=Q68tYBGu; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=O3Mk9bLl; arc=none smtp.client-ip=202.12.124.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="Q68tYBGu";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="O3Mk9bLl"
Received: from phl-compute-08.internal (phl-compute-08.internal [10.202.2.48])
	by mailfout.stl.internal (Postfix) with ESMTP id B6D7D1D00043;
	Wed,  4 Mar 2026 17:05:07 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-08.internal (MEProxy); Wed, 04 Mar 2026 17:05:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1772661907; x=1772748307; bh=MDWTvqZwZa
	isyPLNd69rX4Qe7kJBnbiyt4RDKp9eV/s=; b=Q68tYBGuKAYt7Qk5RfnPOttFg2
	SbUmGv3t9hNektwvFUy1wPr+R4wEh4vmez8qBg/NFctgA+i+Zb0ejD1AqXbMJFZZ
	RoV2nZOxz+yoU/zOOentIbSFx7SvWzVv+Fi2RW+GrkDez/dpNBW+5ecRZgWI8f5+
	55vp0LSWsYXf27aYw/xKlsG6660sf+TeomDV0nHW3er3Cqbaz/rSJWylCum4JkZC
	NmT6DPQaGVfPKyHWfUEg/90U2qnInd1EcIfiFAiufuKd90flD5l5Aw/Qol0aNKo5
	awjAmNSzWBnwmVa9san0H+8Ftcb47bObx4i59AZSrl+hM/eSh7GK8zUgGJZw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1772661907; x=1772748307; bh=MDWTvqZwZaisyPLNd69rX4Qe7kJBnbiyt4R
	DKp9eV/s=; b=O3Mk9bLlhORZyDYzFGEm2e/AZLSHdLYXjFGaAvgX1HddCgrThta
	e+dAx/Nf/9Qnxz47lS4PNZbBsUEeH4QpJRo+wocRLbSDqZRz/v8dE0VMC+i3rQ9k
	2iI+jY9BtvfJAZhcwk3HXLBbFqNt5P/4rcpjGF5LdCdCuZHzdFIlaGunthexTZpl
	hlbXjbWZKK59WvYw8gnwjSED1BuuYegFNZVg9uUUniWzwbxecnwX9x9//mYOiud3
	jEbiu3SLLaPwJtl7Geokb5sSG7yY1rYXv4wi6vHW+SSKb3IrkBkK8d1ObmdIHeYD
	625XjjozJsup0M/BYydXRb08PGCivhzVC5Q==
X-ME-Sender: <xms:k6yoaQRJqnyIa0XX-ND881osLglUK1FyyRnXW944Eaz79OFHL9qLjw>
    <xme:k6yoaRfwO9FknqCWEAR6flfpulpJNRB-PnQdgO6ximYzu42MuC9Lk1Lc0681ttf_Q
    9_UN4lIq0NETyKkqygFJMiuBpsFS6LlkvTkJEBdtrWcKW1YuWlv>
X-ME-Received: <xmr:k6yoaXo-MYB9txW__4ObPjIx2hxA1vYzoqwSRSsnwMVf207r5MdTC5XGs67LhemkPg3N9wyYUMsGogyEheSt-pMBII6xHIuD2g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvieegieehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepiedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepphhssehpkhhsrdhimhdprhgtphhtthhopehgihhtse
    hvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepmhhsmhhilhgvhiesghhithhl
    rggsrdgtohhmpdhrtghpthhtohepshgrnhgurghlshestghruhhsthihthhoohhthhhprg
    hsthgvrdhnvghtpdhrtghpthhtohepphgvfhhfsehpvghffhdrnhgvthdprhgtphhtthho
    pehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:k6yoaa-lfhvDWuIpJDHOshqDI4LrFoaLTwCOv5TsHE4U6CfUVGIZEQ>
    <xmx:k6yoabeUkWMpo7hFcU4RESyJJR7OQznX8marWV1MljdqF-zoa44Few>
    <xmx:k6yoacLafIpaw-DXck96HjGXjrdeD_hanLCEjVac69Pn5VbxcV3rbA>
    <xmx:k6yoaTjnkxjKIEW6O99jHkS2bPUT55UwRqpr6ZhNShmPpaUXpP5zAQ>
    <xmx:k6yoaWhK_kxxudvwTC-4fmj71mYKzL4j2xZofwV8DZ7Zs5RAS-YjPU7->
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 4 Mar 2026 17:05:06 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org,  Matt Smiley <msmiley@gitlab.com>,  "brian m.
 carlson" <sandals@crustytoothpaste.net>,  Jeff King <peff@peff.net>
Subject: Re: [PATCH v2 07/10] sideband: use writev(3p) to send pktlines
In-Reply-To: <20260303-pks-upload-pack-write-contention-v2-7-7321830f08fe@pks.im>
	(Patrick Steinhardt's message of "Tue, 03 Mar 2026 16:00:22 +0100")
References: <20260303-pks-upload-pack-write-contention-v2-0-7321830f08fe@pks.im>
	<20260303-pks-upload-pack-write-contention-v2-7-7321830f08fe@pks.im>
Date: Wed, 04 Mar 2026 14:05:05 -0800
Message-ID: <xmqqo6l35jzi.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

> Every pktline that we send out via `send_sideband()` currently requires
> two syscalls: one to write the pktline's length, and one to send its
> data. This typically isn't all that much of a problem, but under extreme
> load the syscalls may cause contention in the kernel.
>
> Refactor the code to instead use the newly introduced writev(3p) infra
> so that we can send out the data with a single syscall. This reduces the
> number of syscalls from around 133,000 calls to write(3p) to around
> 67,000 calls to writev(3p).
>
> Suggested-by: Jeff King <peff@peff.net>
> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
>  sideband.c | 14 +++++++++++---
>  1 file changed, 11 insertions(+), 3 deletions(-)

Quite straight-forward.  Looking good.

> diff --git a/sideband.c b/sideband.c
> index ea7c25211e..1ed6614eaf 100644
> --- a/sideband.c
> +++ b/sideband.c
> @@ -264,6 +264,7 @@ void send_sideband(int fd, int band, const char *data, ssize_t sz, int packet_ma
>  	const char *p = data;
>  
>  	while (sz) {
> +		struct iovec iov[2];
>  		unsigned n;
>  		char hdr[5];
>  
> @@ -273,12 +274,19 @@ void send_sideband(int fd, int band, const char *data, ssize_t sz, int packet_ma
>  		if (0 <= band) {
>  			xsnprintf(hdr, sizeof(hdr), "%04x", n + 5);
>  			hdr[4] = band;
> -			write_or_die(fd, hdr, 5);
> +			iov[0].iov_base = hdr;
> +			iov[0].iov_len = 5;
>  		} else {
>  			xsnprintf(hdr, sizeof(hdr), "%04x", n + 4);
> -			write_or_die(fd, hdr, 4);
> +			iov[0].iov_base = hdr;
> +			iov[0].iov_len = 4;
>  		}
> -		write_or_die(fd, p, n);
> +
> +		iov[1].iov_base = (void *) p;
> +		iov[1].iov_len = n;
> +
> +		writev_or_die(fd, iov, ARRAY_SIZE(iov));
> +
>  		p += n;
>  		sz -= n;
>  	}
