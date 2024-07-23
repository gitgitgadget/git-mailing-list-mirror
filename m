Received: from fout1-smtp.messagingengine.com (fout1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F00F8814
	for <git@vger.kernel.org>; Tue, 23 Jul 2024 14:00:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721743238; cv=none; b=NKl2ufOZvTjnM535X9SZgNdUZR5HatFAQxqomXH0/pUJTvV2ji6vJaiO6t4GxPgTH4gYOFY9aPs2U/mKHCoIFNlIK127L3SL6ZeOUIfNhCsG3S4qBtQbdP5WscDbqBTbiX7cgMTBODvQyY4YH2XzSLYEOCzUnXqW/6P7Zw/cNXs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721743238; c=relaxed/simple;
	bh=C5AvEllAS7qEljjwIMlhkfHsSWnU+GZ0OhC72LlykTA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FEw64U/CUac+WALTxyLJKAk5M+J6YNTy3RLlsHHjQdRVFkc2mp2OGex1qgwy57MhWTYEAUWkgU1xg/PgRjBguHyylkSQtDMosB/BTShd+2WC7Rhx/s4tPWzz8wOk2Nj9sTwp6AOtWv0CN1pXCEzgh0DxiZtj0oqVYJUjYPeWzvQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=bSzpRNDT; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=XGu2rhLA; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="bSzpRNDT";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="XGu2rhLA"
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailfout.nyi.internal (Postfix) with ESMTP id D9B791380625;
	Tue, 23 Jul 2024 10:00:34 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Tue, 23 Jul 2024 10:00:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1721743234; x=1721829634; bh=hl5Jg+LcGJ
	hkcAwkEx3wkDb8N7PPoZKtgjGNOpHnbco=; b=bSzpRNDTLPHSgxgdpZON3+OA9g
	KgpCf9ECepTO4qpd3su97Gh3bKjI1g4K5496VLeSLhDhmhrlyev66i86oGpwc20C
	ZK6mm4GFMAMB7Zy/d7hUekhbpp95BN5tnYc68LimabGiq4zOb/SZ75C6bA4hBwMP
	EcO+1fimq5T26o0K49kYN7HK5kkDiebYAkRlGQYU/Rn6k1hoO+sgxJ2FcC+rxaT7
	sARU2xQm+cW7j5CVH8BXtQt0yTFd54h0lTom9FcTIqM9CQ0Fuehe1k4pBsWsRurp
	HAzjzxSnpp9M5j9gzbDKKDFqZ99CZxq2QWfhxMp/gebGExo33hw0dJXxLpnA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1721743234; x=1721829634; bh=hl5Jg+LcGJhkcAwkEx3wkDb8N7PP
	oZKtgjGNOpHnbco=; b=XGu2rhLAq+OLDF1Yfer71K9HAnNtcVxyCT2Fb/qdl+nl
	nliiQWepa1ArZE8A6X1n9NVr32Cxa/gLqDaf/2iGIJs0o5KcpA9d2s8VZbAJwOiL
	Dy2u6JhCqwtwve3ZMwECnQTK+ViV2AM9Y+XDQlHGlhmQEyIDCxYDlGnpQvU4vQc3
	LdRfL/fOo7rRuvCTnPQqeQwKZKlK38pvS6F1CCI5dlJUrkE0xjE5BDZ34rv4unKN
	DxV+Rwi4Any8BumGblPIcKKmWqBnLiHE4sjvGmOd8Cq5bgBxg2Cg0IGpeBcu57Yx
	XsirybRXRazq6Wa0XOK7VO6YAAsov+WCsiqG6V7v8A==
X-ME-Sender: <xms:grefZtosYVgNWis_lwlFsadq66vXIQuskle9RQ8588pyHSKfaZWA9g>
    <xme:grefZvoQmpy-0TnHaQHrZYeyD9wY2XeNFboQX1zzZTj0V8_nNrQLxEdym4Bl_4JB1
    85QxdngAc5_THGkIg>
X-ME-Received: <xmr:grefZqMusoIPRKoxvT7aA8g-VXcs-VvH_OA43svL7NoMJtIeg2anfCB4GNkIBx1rwCyQ_combnEC9qQnjmZXEMmIz0yG6YNwedXs1KRcScp3Q7kN>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrheelgdejudcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvvefukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeeukedtvedtffevleejtefgheehieegkeeluddvfeefgeehgfeltddtheejleffteen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhmpdhnsggprhgtphhtthhopedt
X-ME-Proxy: <xmx:grefZo6561jyRhfF1-o-5q4ncbpj2zv3Vj4NtR_t9IC2qcSHzssYgg>
    <xmx:grefZs5ZPxRf4f6MkXkLkqby4AKnlMPuCvyfsPJVA_8ymq4HMKSbMQ>
    <xmx:grefZgjtdnigZY5slw_QstGzvstJ2b-no37oDlR0A-wX3k9N0AwW5A>
    <xmx:grefZu6tlQm9txPyOi4Bx3_tjHvFN_YwGoIXZRf3FqzEN5lJ_0qXBA>
    <xmx:grefZpt8O_GQ9K_57MwMsok0oE5nviUDR-DhQ-vnke9uAG8lSrjwFnLQ>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 23 Jul 2024 10:00:32 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id 90193329 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 23 Jul 2024 13:59:15 +0000 (UTC)
Date: Tue, 23 Jul 2024 16:00:27 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Ghanshyam Thakkar <shyamthakkar001@gmail.com>
Cc: git@vger.kernel.org, Christian Couder <christian.couder@gmail.com>,
	Phillip Wood <phillip.wood123@gmail.com>,
	Christian Couder <chriscool@tuxfamily.org>,
	Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
Subject: Re: [GSoC][PATCH] t: migrate helper/test-urlmatch-normalization to
 unit tests
Message-ID: <Zp-3e6VV5bl8dWvR@tanuki>
References: <20240628125632.45603-1-shyamthakkar001@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ZTk7oBbCzDQNZC3g"
Content-Disposition: inline
In-Reply-To: <20240628125632.45603-1-shyamthakkar001@gmail.com>


--ZTk7oBbCzDQNZC3g
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Jun 28, 2024 at 06:26:24PM +0530, Ghanshyam Thakkar wrote:
> +static void compare_normalized_urls(const char *url1, const char *url2,
> +				    size_t equal)
> +{
> +	char *url1_norm = url_normalize(url1, NULL);
> +	char *url2_norm = url_normalize(url2, NULL);
> +
> +	if (equal) {
> +		if (!check_str(url1_norm, url2_norm))
> +			test_msg("input url1: %s\n  input url2: %s", url1,
> +				 url2);
> +	} else if (!check_int(strcmp(url1_norm, url2_norm), !=, 0))
> +		test_msg(" url1_norm: %s\n   url2_norm: %s\n"
> +			 "  input url1: %s\n  input url2: %s",
> +			 url1_norm, url2_norm, url1, url2);

Nit: this is missing braces around the `else if` branch. If one of the
conditional bodies has braces, then all should have according to our
style guide.

> +	free(url1_norm);
> +	free(url2_norm);
> +}
> +
> +static void check_normalized_url_from_file(const char *file, const char *expect)
> +{
> +	struct strbuf content = STRBUF_INIT, path = STRBUF_INIT;
> +
> +	strbuf_getcwd(&path);
> +	strbuf_strip_suffix(&path, "/unit-tests/bin"); /* because 'unit-tests-test-tool' is run from 'bin' directory */

Curious: is this a new requirement or do other tests have the same
requirement? I was under the impression that I could execude the
resulting unit test binaries from whatever directory I wanted to, but
didn't verify.

In any case, the line should probably be wrapped as it is overly long.

Other than that this looks good to me. I've gave a cursory read to the
testcases themselves and they do look like a faithful conversion to me.

Thanks!

Patrick

--ZTk7oBbCzDQNZC3g
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmaft3oACgkQVbJhu7ck
PpQ9UQ//YCeoC41wh4ZdAy7EWrECrMEszoC4irE/+cXam58sPBewnYRPmXWhcgdn
s00nnLacbZ3d18CeJGuhsDCfI9DJWd9yYVSYVtFS+SpVOJhSDyJaAdDSQXfonQfn
k8j/xDOxj2N7NZKh0E0UcOphXVK9PhwBBRx/HAKKAyqVFSgiZXQpp62Skdsz7uQY
78zFLJ0iHjU1cO3rYXBu0AKpHwKLTvuxK60kmVsdkzL6C6Z1ohlfeA1UfKu4wG97
pqPapYxoVSgIU3ovrgBPYGDJJey7GRrQQ4FA3aQKAm/JrocuXlz9SP97x/r/bp8e
/TkCNC1lQlNXqcV0Br9IZ1pCc3u1jg2jk4ZsCuuUQBIeCL3qHfG0+pbauiY46QYv
+MBAD2AFvmt7wEDPvRJ8BFZIDHsuQraPx5iCyiJqicIvKC/qNodQCaVVo7LnZi7+
FF5zHAd6FARZgm4KtSxX6Wz0GlB5C0onBVcIoJVR4QA+JOEJcoIxNx5XsVhjw+g3
yvSfiadXVeTYY739X6r0tjiId3SKch40L+CR1F9wGvBcZvfkolXAnZLT9gUlbTAu
g22LM502dDXB094Z0ORXAeDcOgQVtLRdJgTvSmfrQnDM8z8at5Am9vjzgNe4UFSF
MHH+AMAMZtgxNj56Jzg2nQ7I9Ana202abrDVFu/+GZuvoVHj4iY=
=/U+a
-----END PGP SIGNATURE-----

--ZTk7oBbCzDQNZC3g--
