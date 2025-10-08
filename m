Received: from fhigh-b5-smtp.messagingengine.com (fhigh-b5-smtp.messagingengine.com [202.12.124.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 987CA2F0C73
	for <git@vger.kernel.org>; Wed,  8 Oct 2025 07:14:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759907682; cv=none; b=IV5WB7PnduUD1pMMX4KXS0g/D+5HkhkR2HGIbcMmPfeiP19IhPrKwAvwDibwvmgC1ltuEfdlNNHsOvwNEGjsK8Tm654NNDybLytVFcXaMmEKXHxvcQAJDlMkEYWWHOwa+LBS5zFCmNWZSo7aAY+uigRHey/d1Z0q2qRlS8Jk/xM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759907682; c=relaxed/simple;
	bh=Dp9h6MTAxmCqPzrjKKalCxYvwv7kkG1AF+/PD+KoMAQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EeTdtSHulhE0DWwem/3HHu8v1gvK49AtPo5lzVy9cDJPfoHwyA20ImZqpnqdes3505v7bh6XC62jylR8BfcsvReAKdSFJoP3KJEiXS2RmNQT8qTv/2dmG57mxassAzJMYVPTK6i3bLmLx7Dq7ig4MqnbMS3fqEK/eb6RXcSCWSU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=VaP2FScG; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=q25UbvA7; arc=none smtp.client-ip=202.12.124.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="VaP2FScG";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="q25UbvA7"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.stl.internal (Postfix) with ESMTP id D60B07A078A;
	Wed,  8 Oct 2025 03:14:39 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Wed, 08 Oct 2025 03:14:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1759907679; x=1759994079; bh=zxYDslGlh/
	44VYw1BSFuQxdjwOwexIBxh+K4mKeNbk0=; b=VaP2FScGmgx2USdbhVSnB3wNrE
	syDNVr78qtMN6DxGZfvtZDMuDN1bZG4MVo4eGrhbklHXQD/Z8EmJ+kOtcKaNdNAM
	6q7UBS9PSMayVUWBnv8mIXSoelD2BJF9TtA3+15j2MiKapknILTcYWVzbkKzhbzr
	N0UPpJg7Z1kSZTLguEjbWTFCj/4IRyjIPhQkN6DtjZsvYPgGLkgkbWNmTFzdlnNT
	wKfz6n4KSwH+9X2tNuobHVmuES4nxQ/hJHCVXPiMOsdanQjoPl7JLRQpfVhNm4Xd
	rMpLVUvXBGd8qC/ek+64BL1Ogtzga/wEPZ4kFkbw9/1SWc0nFoCjrwzzFVlA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1759907679; x=1759994079; bh=zxYDslGlh/44VYw1BSFuQxdjwOwexIBxh+K
	4mKeNbk0=; b=q25UbvA7yR0/1mE6fQJ1WspBa7UuV9NPh3aYJMKdEacJlD8N80z
	24i9En1EmcWA1y85FMVfis4Q6jCqkUt6fnJ6zHa1vIY4h+mtnRpvP4YolhtLMw5q
	7TLs1qza+Vepg8/1L+9ExEcc1YTs9qGDNtHe7EjtHA0aV+WyA6Zit+fUiulI5CAq
	uqjUYHAo8FYlNQ4nBdUUWyQVCIdG7CjFYgzvYfh5y0eigt7Ui+uWWVyDBUlcOtZR
	EYjyiswJpykI53Z5WwgahiMQkwDQLlTnp8PhHXw5ApaRac4jB3zfHwg/oSxisgxO
	THxKZn5Fmm0NoXo+jVw9GhlV6xkysQQLJ4w==
X-ME-Sender: <xms:Xw_maERDKreKRgH8jTSDZz2AWI5_TqZvOkIUehvdwldFsUmrF6a29g>
    <xme:Xw_maA23hn4fDsBF2YiUJyRwaQEeSECKE0tFqH5bINk9zQ3xMJRD1u-fFINJFZk3J
    4GGheOvMcES9L01BNPToOXm6bvrVGRKdN4P4F0uUZtXDfWlIzjRtA>
X-ME-Received: <xmr:Xw_maIBcWoGJyMUGyco0UK090YJEhICfWLJJhk6Ef8rnVYA-VNqQ0D5MAMlR76y5fy42jC_bAKCwjGc6ehrPQ_BAtzgQ_qLDAN4FPEEU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddutddvieejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epveekkeffhfeitdeludeigfejtdetvdelvdduhefgueegudfghfeukefhjedvkedtnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimhdpnhgspghrtghpthhtohepkedpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepnhgvfihrvghnsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithhsthgvrhesph
    hosghogidrtghomhdprhgtphhtthhopehpvghffhesphgvfhhfrdhnvghtpdhrtghpthht
    ohepshgrnhgurghlshestghruhhsthihthhoohhthhhprghsthgvrdhnvghtpdhrtghpth
    htohepjhhohhgrnhhnvghsrdhstghhihhnuggvlhhinhesghhmgidruggvpdhrtghpthht
    oheptghhrhhishhtihgrnhdrtghouhguvghrsehgmhgrihhlrdgtohhmpdhrtghpthhtoh
    eptghhrhhishgtohholhesthhugihfrghmihhlhidrohhrghdprhgtphhtthhopehgihht
    sehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:Xw_maEiAff30Ai9N1ukjxz1obCaTmnG83kNFpLqLbbh3gCi6TLFA-Q>
    <xmx:Xw_maCPdTopzH3A0d-eqG5k-leowe6pO7cl3g4J8h3BaomxYfFmeUw>
    <xmx:Xw_maM-XPdU2MzmOOdvHkaD2O8u24o8nUrJXVbj7PTZr9uIPmwT10A>
    <xmx:Xw_maLftNBk4mavTqb6Hs51KMlJx_nGn-0FHcIKpASqpQPp-TtEgAg>
    <xmx:Xw_maAoeEVrShFKq6Isby5CEecXwGiJddBxQgzmptjF5bYQZt0raJCdp>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 8 Oct 2025 03:14:38 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 91629f2d (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Wed, 8 Oct 2025 07:14:37 +0000 (UTC)
Date: Wed, 8 Oct 2025 09:14:34 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Christian Couder <christian.couder@gmail.com>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Elijah Newren <newren@gmail.com>, Jeff King <peff@peff.net>,
	"brian m . carlson" <sandals@crustytoothpaste.net>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH 4/5] fast-export: handle all kinds of tag signatures
Message-ID: <aOYPWvdE4VnL8T7z@pks.im>
References: <20251007122958.1089680-1-christian.couder@gmail.com>
 <20251007122958.1089680-5-christian.couder@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251007122958.1089680-5-christian.couder@gmail.com>

On Tue, Oct 07, 2025 at 02:29:57PM +0200, Christian Couder wrote:
> diff --git a/builtin/fast-export.c b/builtin/fast-export.c
> index dc2486f9a8..7adbc55f0d 100644
> --- a/builtin/fast-export.c
> +++ b/builtin/fast-export.c
> @@ -931,9 +931,8 @@ static void handle_tag(const char *name, struct tag *tag)
>  
>  	/* handle signed tags */
>  	if (message) {
> -		const char *signature = strstr(message,
> -					       "\n-----BEGIN PGP SIGNATURE-----\n");
> -		if (signature)
> +		size_t sig_offset = parse_signed_buffer(message, message_size);
> +		if (sig_offset < message_size)

Yup. The function either returns `message_size` in case there is no
signature, or it returns the offset at which the signature starts.

>  			switch (signed_tag_mode) {
>  			case SIGN_ABORT:
>  				die("encountered signed tag %s; use "

I was afraid at first that we're now open-coding all these different
signature formats. But this implementation makes me quite happy, as we
even remove the existing check instead of using a central function.
Nice.

> @@ -950,7 +949,7 @@ static void handle_tag(const char *name, struct tag *tag)
>  					oid_to_hex(&tag->object.oid));
>  				/* fallthru */
>  			case SIGN_STRIP:
> -				message_size = signature + 1 - message;
> +				message_size = sig_offset;
>  				break;
>  			}
>  	}

Makes sense.

> diff --git a/t/t9350-fast-export.sh b/t/t9350-fast-export.sh
> index 21ff26939c..5a46608f65 100755
> --- a/t/t9350-fast-export.sh
> +++ b/t/t9350-fast-export.sh
> @@ -279,6 +279,54 @@ test_expect_success 'signed-tags=warn-strip' '
>  	test -s err
>  '
>  
> +test_expect_success GPGSM 'setup X.509 signed tag' '
> +
> +	test_config gpg.format x509 &&
> +	test_config user.signingkey $GIT_COMMITTER_EMAIL &&
> +
> +	git tag -s -m "X.509 signed tag" x509-signed $(git rev-parse HEAD) &&
> +	ANNOTATED_TAG_COUNT=$((ANNOTATED_TAG_COUNT + 1))
> +
> +'

Nit for this test and all of the below ones: our modern style does not
have empty lines at the beginning and end of a test case.

Patrick
