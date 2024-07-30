Received: from fhigh1-smtp.messagingengine.com (fhigh1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7928B624
	for <git@vger.kernel.org>; Tue, 30 Jul 2024 06:03:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722319410; cv=none; b=MREAVxfHYhGFkv7Akls9JizeSus+yfGg0iQGr2+NMH2y97xjnrGDN0ZgbI91fccxewTXzSRfWY8QCx1JeQFskLUnujOTJT7YcgYaUhWuPiCfPZgz7e5Vi0bcrKR0cCWokIPGj1+Y9oJCj09XEmsdvVhc6XJTk6d3qMKA4XHPZJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722319410; c=relaxed/simple;
	bh=Hm582XWz3piW5CATekwet5aXvoqbzpDwHgSp5NDiAB4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pQW0cCjQTIfTOAVUXV5R1ETcBBobjvRnErKw1Lxz1EgpGfTRgr8DJeAe00q/8ammHDzZO8iEWuM69wS0TM786DKiRL+fYtN6vs6opuolO8xtBC0o6UxWaPXY1rN+vpuB7cbyKovBwvcYAT2Z88x8uDa5EQRTi1gk5/EOxxmZEks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=LABXJHfJ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=pSJMS4MD; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="LABXJHfJ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="pSJMS4MD"
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 7A2471140538;
	Tue, 30 Jul 2024 02:03:28 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Tue, 30 Jul 2024 02:03:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1722319408; x=1722405808; bh=nSRa0dgFhD
	nxue+zvCaox3YI8Jah8w3noDTLyTT7q3g=; b=LABXJHfJ8vREoen8I/ZuPu1eMc
	kywzMCYNM823GoXnzo58SZt/WAqkrFY3gQp8FTpbPBoU4LSorZqmTn7+0vfYRpi3
	5pskoa94+dDUd362E3m2kqXk3sFJ9FPFcJQ5g1V3e6qY5Wu7hAa+XZObASWwNMKD
	bq52KY5GJETU47Ux5yJB7yXQmCvs0JRmk1/F7VK7ijESlIM0Wp1YwGb/Lgyss1Lc
	/YAElxD0BcVD7sdvyU5GHRQ4yKl0/EoW4tnPsYCj7jRBFRXbHVYDOvdYD4VUzLLh
	9eUOi3EnDV4OME/7FP7VTnphYxqRNhJRZyjsIEKta12Xd3ViOesaKnYhVgUA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1722319408; x=1722405808; bh=nSRa0dgFhDnxue+zvCaox3YI8Jah
	8w3noDTLyTT7q3g=; b=pSJMS4MD/B+gQiLnnyIPVpM79txpmJxfPJzFvu/HoqrQ
	6+ONAInaR/9eiAkSIhfhA1b8CG7TBcQppGIUePlh/uVj8sdOi4giJXTGwVokAfy5
	XLK0YFhKg0w55I/FI/Z+EniCzvaGIseIFxs1rwqk91CJt/zUOg4fw2IKe8b3vr3W
	7SNB1I8yqliszQ+nEPAGCmOFXHfR8JI1NSgIQnOqs9/9ENx0gcBvNnW/I5WFUnIs
	pS9jIrQcLozGt24JLKQyQEs+gxjVEROgHlEVKoNlJlLvxbQu76kHIV9DJp7aqwiR
	0wwnkwlVu0wkB2T0FYA55hdG2afEoMRvRGryp+NENQ==
X-ME-Sender: <xms:MIKoZipZU211AQsGCmVKTMznnrdOGRYqj9RqGp37HwOz4zvWBiGbyg>
    <xme:MIKoZgrPRlU1JMPgjOncC0pu-F9C3TuEPc66BQYwv0RljZQ2N15NpCDgbZuxS7CMB
    nX0kXoygSTR6iQ-5w>
X-ME-Received: <xmr:MIKoZnN7wW2LFeoooTIprIbDXnniwdX3nc1tcmsiM9FMTqBvwfEnEvSxG7RtlFuCKOGRIYwE3aRGT3FG7XQZ5S7Zg-sFRzgfHo8OTIo9Z1SGQZY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrjeefgddutdehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepueektdevtdffveeljeetgfehheeigeekleduvdeffeeghefgledttdehjeelffet
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimhdpnhgspghrtghpthhtoheptd
X-ME-Proxy: <xmx:MIKoZh5OMl0tp90BUlYdlEp82-0blmTmg9ysLOStOOUQCZSPqwCkHA>
    <xmx:MIKoZh77hSTnq0693OICse6oK2AKvZqWiXKyGRGzCSymjd4Q6-YyPQ>
    <xmx:MIKoZhh8N_E8aMCfEPRQCKsU1ct3WoTXNC2_DbuXUbS4sZlWCscuWQ>
    <xmx:MIKoZr732jYHbfbwpe8eVneU0SRkOzHdqEtLDMbMCf5EYjXyfGsSlA>
    <xmx:MIKoZrlMWkv2LDpJVIL4RjXhlJS7qjDnUU1H2Ac-mJvzgD0Pf4QP4M40>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 30 Jul 2024 02:03:27 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id 52b52e58 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 30 Jul 2024 06:01:59 +0000 (UTC)
Date: Tue, 30 Jul 2024 08:03:24 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Chandra Pratap <chandrapratap3519@gmail.com>
Cc: git@vger.kernel.org, Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH v6 6/7] t-reftable-pq: add test for index based comparison
Message-ID: <ZqiCLLps7k2i8p2C@tanuki>
References: <20240723143032.4261-1-chandrapratap3519@gmail.com>
 <20240725093855.4201-1-chandrapratap3519@gmail.com>
 <20240725093855.4201-7-chandrapratap3519@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="HcypKZVnBui4CLsB"
Content-Disposition: inline
In-Reply-To: <20240725093855.4201-7-chandrapratap3519@gmail.com>


--HcypKZVnBui4CLsB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 25, 2024 at 02:55:58PM +0530, Chandra Pratap wrote:
> @@ -59,9 +56,49 @@ static void t_pq(void)
>  	merged_iter_pqueue_release(&pq);
>  }
> =20
> +static void t_pq_index(void)
> +{
> +	struct merged_iter_pqueue pq =3D { 0 };
> +	struct reftable_record recs[13];
> +	char *last =3D NULL;
> +	size_t N =3D ARRAY_SIZE(recs), i;
> +
> +	for (i =3D 0; i < N; i++) {
> +		reftable_record_init(&recs[i], BLOCK_TYPE_REF);
> +		recs[i].u.ref.refname =3D (char *) "refs/heads/master";
> +	}
> +
> +	i =3D 1;
> +	do {
> +		struct pq_entry e =3D {
> +			.rec =3D &recs[i],
> +			.index =3D i,
> +		};
> +
> +		merged_iter_pqueue_add(&pq, &e);
> +		merged_iter_pqueue_check(&pq);
> +		i =3D (i * 7) % N;
> +	}
> +	while (i !=3D 1);

Nit: the `while (i !=3D 1)` should go on the same line as the closing
curly brace.

Patrick

--HcypKZVnBui4CLsB
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmaogisACgkQVbJhu7ck
PpQkEA//fWiuC4pQ0z0nHoGfyzn7WVulthqP4bvfGSuJ3mBnz9v37NiMmLNG/5Zx
M7mo7DGswUmijnh8zQYW5vCd2S4e35qgy7YeRx2qJyK6u8K8brtoKR8+K0CJVKb5
pw5yEllmEaBKBKup2vRt18Aaws0OLP/epX+T+eLMT4m8Utizy07sGkJjgJU36hSg
tVLfUyBn4q6jeYS6loN4UGlR9Xx0QcBFL6Jp/8C/c50JWm90S9bdbhBYw7/RzZTf
SvWnQQz+jEZrfG+FbeRX2xrfwTAL9Dbl+J7g6Ct8jGepOLyJ9WzVllhQoS+vpgbC
o51fB1b0DHQcu46dmP2OJGkH5iWCPnWb1gyGWRwCAIj9/dp3n9ZQiUy1I6PpmPEX
JXBCIsneKcM6H3bUr3EeofuSX8AiC9NZMRds7aFb+bdBt3n+lTFvftCS+4V/S5O7
lUxZB6pCA3lzH1KWu8afB8jaai+OGIjZoT5KXyePsHE7GUXfBR1G2ZbjQrmD2SF0
jOa7Pr+/JCsIPXnAqR3jMr8jPR24FT2YIaSUudy3OWc7cBQoB4R0ZIeScIQzKLG2
vCLWxwkrfYy5T/w7aGazdppP3JDrr61I3F5PcE/6b7yUlKYM1O+QD3Eze4dX5I07
zQM4mNimhRv/rtPo/AYJEVZd05aBQ6hthxTHORGjSxlv/lap6AA=
=YFs/
-----END PGP SIGNATURE-----

--HcypKZVnBui4CLsB--
