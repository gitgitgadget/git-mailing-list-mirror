Received: from wfhigh4-smtp.messagingengine.com (wfhigh4-smtp.messagingengine.com [64.147.123.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8015F16C6AE
	for <git@vger.kernel.org>; Wed, 29 May 2024 09:30:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716975010; cv=none; b=O9V3XgzEKw0neYe9yDY4QxexOC08avRbu/iqkmr+ag4E/N0RTZOxHtM4aWhwYAzpxs6/jAgK1Aoi5akDocisj+lT9uIU8LjBN9q6YtyKJFGDe6VrRYlC2B4VQLIFYoQ6jU3io27KQCnUAHU8zeB7ycBj7GxfB+T+JV/GpYKqXsg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716975010; c=relaxed/simple;
	bh=6pjnrMZqZe8C2Zx2+wISD9/aXPJWUWhNGy5XAAZuamo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Lzyj/R0UqEzx17mcF4IYQAmdyF39iEIL4t+XDgQdDuzCn9U0f8G5Jk9jbxN+3qycd6sYhtMQ6USRDItpVeCZ3EN+UhOqefeibAjdj6BxfLORNdtGWTVU+qKz2rxsC/NSsxZVbm9PXio+xXmYoJWzEWGcktTjK3grMzjwMO64ljY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=ndVSPBry; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=m6c+DH23; arc=none smtp.client-ip=64.147.123.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="ndVSPBry";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="m6c+DH23"
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailfhigh.west.internal (Postfix) with ESMTP id ABE00180011C;
	Wed, 29 May 2024 05:30:07 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Wed, 29 May 2024 05:30:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1716975007; x=1717061407; bh=6TqXIdd55m
	TT4vNG6m7m3Mm+cxoGZOmIFrhkHLpwvdE=; b=ndVSPBryxeU3ukbTzA4UWv4tle
	P3xZleyiJxS4ckF8gRVNf6tanpYyOOcexaie9e2U6nZ+b2KPHAlsf0wxi5JMcZAb
	f7ZnPmiTEC6jhU9kAXA1R8FKGxt/fHt/SXhEpdph32HH6gJMBawkX+1hrMGT4xkt
	xRL+ZbCGbteJcTGkzaj9TV8uY2NEuo4/9vMvZU3gTW6PRnUeDx4MEc7gBC3krRgE
	s15p8EDuwKGt0kYk7Jh0Of2QlsN8whIE5NsPQ/7khZlSTUejsRaRcZe8rWwPnGcn
	TpTYibBJHCdynRz8K7mcGzGM/EnZyV+RCepnSRDNNMen2nmqYQxnck94WDjw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1716975007; x=1717061407; bh=6TqXIdd55mTT4vNG6m7m3Mm+cxoG
	ZOmIFrhkHLpwvdE=; b=m6c+DH23TF3rGd14G2wTXxGjmoU+qYhvtpsHI5z4Rxlj
	UgujadnhjfgaieUJ6ZKz7uEIi0mGQQ6m+JD/sNrHFrr5BfMP1CmRioO/RpzvlQTw
	DReUXfroFV/Jzjb5XIXhc5DQeTtyVSx47AC7UERiM1de8X8lpAHjlK7HLml5nHLM
	r1OK0ZfwOBA9EiFDb5knns9j+vyIn3wnBbRmVuh7kIe+b2eBgkshvXRETPwHcfL/
	Fi1jQkCSiXJXzyV+Ogls81yYpMpcUCCWsATrqLP/pOUmjQ4NMeQzyZo3rMyHlbWk
	zAsGGtxZ6HAK13Y/BwmEF1JluMMo7jUSDdz3ETyqQA==
X-ME-Sender: <xms:n_VWZgC1KKEnmozMdweh5LxKdXjRXIXHYO7hmxF3BMerv2juJDSkkA>
    <xme:n_VWZigt6VQN2K_eZtxMqw5ttUzjB91vNLtaQDrrRi4BkJ5y0ousLR-jEIV9R16fi
    sx9GHjKWkbtGumnTA>
X-ME-Received: <xmr:n_VWZjmCGu7zKYOhrfC0Wkx2ILuyiQqvYGCDyymkPuaqqAyJtdLYYSw2c8BcuI7tNlJ8mE8cWBdoJn5zz8YWOF4-Z19TJAb_9zLSIgtVPRI1iC2l>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdekuddgudehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepueektdevtdffveeljeetgfehheeigeekleduvdeffeeghefgledttdehjeelffet
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimh
X-ME-Proxy: <xmx:n_VWZmwUuPH8Ey72AZasgUzUka4DzSRkAmZcidRJBdAPRRaEOsIjOQ>
    <xmx:n_VWZlR-jQUnCNORVF7HBbu8ZL4eMNe9oTcdlvjUY67ez4Q4mxMf_Q>
    <xmx:n_VWZhbeFEs1KDtou8T3PB0hzSEr8PwVacgGnKZlINkwgk18FAioUQ>
    <xmx:n_VWZuTkT_rUGoMidmNwuB1WqFNhIV5bl8bKwXf9ZAB6WU2G9i7jEQ>
    <xmx:n_VWZnewdkxHWuyYGmv7x_irL1ELX-bO4MlAkBpvD4mPBqlAQ8x0yqsN>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 29 May 2024 05:30:06 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id 3e411087 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 29 May 2024 09:29:52 +0000 (UTC)
Date: Wed, 29 May 2024 11:30:03 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Chandra Pratap <chandrapratap3519@gmail.com>
Cc: git@vger.kernel.org, Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [GSoC][PATCH v2 3/4] t: move tests from reftable/record_test.c
 to the new unit test
Message-ID: <Zlb1m5cwhW_R5EzP@tanuki>
References: <--in-reply-to=20240528113856.8348-1-chandrapratap3519@gmail.com>
 <20240529070341.4248-1-chandrapratap3519@gmail.com>
 <20240529070341.4248-4-chandrapratap3519@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="irys/pehJrL/D6WK"
Content-Disposition: inline
In-Reply-To: <20240529070341.4248-4-chandrapratap3519@gmail.com>


--irys/pehJrL/D6WK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, May 29, 2024 at 12:25:11PM +0530, Chandra Pratap wrote:
[snip]
> diff --git a/t/unit-tests/t-reftable-basics.c b/t/unit-tests/t-reftable-b=
asics.c
> index 55fcff12d9..b02ca02040 100644
> --- a/t/unit-tests/t-reftable-basics.c
> +++ b/t/unit-tests/t-reftable-basics.c
> @@ -99,13 +99,38 @@ static void test_parse_names_drop_empty(void)
> =20
>  static void test_common_prefix(void)
>  {
> -	struct strbuf s1 =3D STRBUF_INIT;
> -	struct strbuf s2 =3D STRBUF_INIT;
> -	strbuf_addstr(&s1, "abcdef");
> -	strbuf_addstr(&s2, "abc");
> -	check_int(common_prefix_size(&s1, &s2), =3D=3D, 3);
> -	strbuf_release(&s1);
> -	strbuf_release(&s2);
> +	struct strbuf a =3D STRBUF_INIT;
> +	struct strbuf b =3D STRBUF_INIT;
> +	struct {
> +		const char *a, *b;
> +		int want;
> +	} cases[] =3D {
> +		{"abcdef", "abc", 3},
> +		{ "abc", "ab", 2 },
> +		{ "", "abc", 0 },
> +		{ "abc", "abd", 2 },
> +		{ "abc", "pqr", 0 },
> +	};
> +
> +	for (size_t i =3D 0; i < ARRAY_SIZE(cases); i++) {
> +		strbuf_addstr(&a, cases[i].a);
> +		strbuf_addstr(&b, cases[i].b);
> +		check_int(common_prefix_size(&a, &b), =3D=3D, cases[i].want);
> +		strbuf_reset(&a);
> +		strbuf_reset(&b);
> +	}
> +	strbuf_release(&a);
> +	strbuf_release(&b);
> +}

Oh, so this test was even duplicated. It may make sense to point out
details like this in the commit message to prepare the reader. But
that's probably not worth a reroll.

Patrick

--irys/pehJrL/D6WK
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmZW9ZsACgkQVbJhu7ck
PpQN8Q/+LD8Kc372/8FirSDmliHE3rVh/zQkrTS2kmrnNdBU5dV2/pAg7X+YDjwo
9T5c3JZUjnDXBVEb/0pwQhd7WS/7uDu49WVb0CN3j8zWhRhKXcSdsnfAKwkhN19l
fLDe6a/L0ZRlLnBJP3Hwb2baYtjZJC7YBEJ/RkTKSbpr1PyMwnnKj8kg/hKW/STc
YHoDXknnXC6d2NY2XOWkB0M7BArkftoGyBE3Db9QIy8X35cEiW4hcCM1z/LS2e1a
WsacO+43XlDP+TCF5Itlfz91PR4+BE4HcsLfTKBhbWXfnfxD6eJMzlLwk/3JY57s
5RhGsIZblsy/Heu4x7LIWbABZmiDaf0xjaINI6xwM4MC4dk7elserdyTelj04ev5
x8hAZaml/ejZOvb6NsiKB1YR0BV+R7guX2SKEjGzZ49hbfKVxUnlqHq6bdyzNVtV
7qrF0YSlgpF08TWiJ0R5i8c4mx4CGAIu3gbZJ2rpHZAxFHGNRbcobED4AaeqRF2Z
3A1nxGWDKQQiFcRVi8r0HJI+P84SdcJxqo/1w26W5Acq9sPTrKyFEFchWarE7I2j
ntlVtwwGlGxKS9ibDkD2SsxZw5Zu56Dvmb+LfraE8k87jXiAUqkSnWpPGpttJI9U
1lLlSh4z9JWkUmokkY6yRczQfGXgchcpRVA5uT+CSh5qWSMXFwY=
=xjqK
-----END PGP SIGNATURE-----

--irys/pehJrL/D6WK--
