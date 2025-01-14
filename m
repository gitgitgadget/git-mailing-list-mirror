Received: from fhigh-a2-smtp.messagingengine.com (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F67E146A7B
	for <git@vger.kernel.org>; Tue, 14 Jan 2025 14:26:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736864800; cv=none; b=G+wStPAezuTp8W0lI34fzEu9FBS7ZzP1O4d2dUrlrJLPkE9ytSwX8vOTXRhVWETYEKDzuTsmocO+whrKFLzccNGqnbtJ43b0of4NagvwbF7QBKmtBIoAX6aJkL43HW3g+FlL4jPJfqrYzplSI6lVjd3laGQuSJuXLr+0xrvKjxk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736864800; c=relaxed/simple;
	bh=7xdNHHK6OVjWDBf3P58VcklwlF6H5LoksfxIzQB6IUY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cy8HgM3Kbd0EPwgdWqEVHihkVIcEBUWFFo2b39oPJ8YLc6NfnsaMPi3venEA9bkUao54vHiyGs2esfvDYto0g4Yqz8O12SDGr3bT7NQDV+2c1/LHd5RwZTzzbuEkxoOMGa69KvBWixyf6eK7ml4D8NHP+RnFDH6VNFVtTdCBgKE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=OJdvTUfN; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=xYGWTbvK; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="OJdvTUfN";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="xYGWTbvK"
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 1A87E1140177;
	Tue, 14 Jan 2025 09:26:37 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Tue, 14 Jan 2025 09:26:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1736864797; x=1736951197; bh=aLYlO7vOZS
	oPKlY2WsEoFr1CCqq7aSA0u1BlO8Hsy2I=; b=OJdvTUfN5N1TakJQv3i2kZo63l
	d+aF8x7AZvjPnYQIqoidOGSfag+w3pkUbHh0JWf4X0Ht08YH2X/zAbwTRlQHutGa
	C7Zq33wfoE3OqMLQpu1pFpDl6r81Fk+hGokIZ7fqXrGD4QNLrZifDBwfAYyi8x0w
	MUkQrA+YQMG/7dWvuCbOLHUmAHKtQdgxB0awcQtgizKZA6XUwSCmilQj4NwJd3Sc
	jdHLncUB0SHA/le4Z2JAdXovyJGi79mVooFGQ7eO5kEFETLieeVGfexWaGZIlgi6
	xA8hQsPxfHzCxjHWXzwJQuSIqjIMOLmMUkHmj56iIyEtsjw+K328YJIu/2Qw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1736864797; x=1736951197; bh=aLYlO7vOZSoPKlY2WsEoFr1CCqq7aSA0u1B
	lO8Hsy2I=; b=xYGWTbvKKOMtGfGt90RKWaAhJ86Xk3xKxc4Cm/Qhl4z3OIC0+DK
	3/2deJBxFvQcWyu2UYd9LllkQnpRjydRAR+1m04CioT8W1k5/APjGewoY1i2mAle
	sznr3YP21OHelFMaWjqbM+xCMWKbbVpJQZ2OLYV5IX2A6KmlkWWVNKGrryQYu7R6
	C5mo81/dS84gwnIdN9fxJq0u7zxbZo5i2gNORDug8bAn58ZveE9v0lRY0kBFpgaG
	sW4QwXOBdym58aWUG4Spmwid/gQEXYeMACMcMW4At0M0Fbdf5wTHDi3aSKpqE/Fr
	sD+dkMuBBUfqyNQo/Dhz8plMD9l7FGwfDfw==
X-ME-Sender: <xms:HHSGZ9wHVly17_t5BweZ4bEn6mVToJNmNp06t-V1RIbhqJhjwO20ig>
    <xme:HHSGZ9Qcd-qLpKTfCImDfHX9O2Ub4aji9BtsDRT_C73BaBcOFNK1sGEYFvdy_NAqe
    Dqrwi4aUxzVXv9UqA>
X-ME-Received: <xmr:HHSGZ3UWbjskwEKooq4k6YnNUuRJ1bj9FVhF3vb8Rh-0EwtSAI2HpeP2Iphx7YTYkccD13k4scum9mVrES1wWhXaIlKE9JI9ta8jMn6cn5TrZg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudehiedgieegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefgueeg
    udfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepfedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprh
    gtphhtthhopegvshgthhifrghrthiisehgvghnthhoohdrohhrghdprhgtphhtthhopehs
    rghmsehgvghnthhoohdrohhrgh
X-ME-Proxy: <xmx:HHSGZ_gZzKQSx8tFP_nlg7PmRpJE7jmP_x33a0yixKK4kM8cHhDufQ>
    <xmx:HHSGZ_CiH8dFYlnMgnbBMIJldlv4XV4ITPVf6u9cynHBw0GNw7tY3w>
    <xmx:HHSGZ4KcAguHkgjFoe7if5afDD3BZVp_WAnbIUcr9hfnZ5V8HOQjYQ>
    <xmx:HHSGZ-AAL396iNhFTQotWlwtA-k9ZCKYVXBRXp5OuutQDiv8BDN7CQ>
    <xmx:HXSGZ2NQ_Uz6vqC6BhJZUq5u7QR_93ZVR0QkhPKqVdL7-0EkMCTKEnNA>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 14 Jan 2025 09:26:36 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id f3a88bc3 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 14 Jan 2025 14:26:32 +0000 (UTC)
Date: Tue, 14 Jan 2025 15:26:31 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Sam James <sam@gentoo.org>
Cc: git@vger.kernel.org, Eli Schwartz <eschwartz@gentoo.org>
Subject: Re: [PATCH v2] meson: fix perl dependencies for Documentation
Message-ID: <Z4Z0Fxj87XrqdZl7@pks.im>
References: <5114dc9a00377826a55f6bab007d2ad1a4de8bc5.1736863427.git.sam@gentoo.org>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5114dc9a00377826a55f6bab007d2ad1a4de8bc5.1736863427.git.sam@gentoo.org>

On Tue, Jan 14, 2025 at 02:03:47PM +0000, Sam James wrote:
> We need an explicit `depends: documentation_deps` so that all of our
> Documentation targets know they require asciidoc.conf. This shows up
> as parallel build failures with it not yet being available.
> 
> Other targets look OK already.
> 
> Signed-off-by: Sam James <sam@gentoo.org>
> ---
> v2: Drop incorrect dep I'd added for api-index.sh as pointed out by Patrick.
> 
>  Documentation/technical/meson.build | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/technical/meson.build b/Documentation/technical/meson.build
> index 21dfb8b5c9..3a65ee59b3 100644
> --- a/Documentation/technical/meson.build
> +++ b/Documentation/technical/meson.build
> @@ -60,6 +60,7 @@ foreach article : api_docs + articles
>      command: asciidoc_html_options,
>      input: article,
>      output: fs.stem(article) + '.html',
> +    depends: documentation_deps,
>      install: true,
>      install_dir: get_option('datadir') / 'doc/git-doc/technical',
>    )

Okay, this looks good to me now, thanks. One last nit on the subject
though: as far as I can see the change doesn't have anything to do with
Perl, so it is somewhat confusing. How about:

   meson: fix missing deps for technical articles

Thanks!

Patrick
