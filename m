Received: from wfhigh8-smtp.messagingengine.com (wfhigh8-smtp.messagingengine.com [64.147.123.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EA1C1F954
	for <git@vger.kernel.org>; Thu,  6 Jun 2024 04:51:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717649466; cv=none; b=VPiUzWlpWUC7ply/9vLlOfAF7WVfdOObdUYkfaYoxfnmvhH1L1n0U8I8Ms1ySNVCc0GE9yqIDCLbqaT1b5zCw7ZTZGvJfe79VkU27GRSsI5TZ7UAfkcnIetqFNMBf6+eTJsvVjwACm7+IEs8aqvoGy6mWY4onOqKJXibKOFd/PY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717649466; c=relaxed/simple;
	bh=7Lh76PQEYuSWre0reVNavTFQfrhatJpZuAWtbAmo4LM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cu/oKqaNVf+9F1b2wJVdp4o0sM3jjtfNV9MMuzdVxgjMk5ZMQlkdVWxFsDBjQdIlA9KnKZobl1Wr2/ZYJ0osWOEXV88ksWsSSns9rScLLwANtDNHtIY89rxgckfb0ud+/82fhuckI1bQHcsFDmIgnVziQywGrd3QOKVwzyWIy1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=XYbCxxMS; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=GtXsieI0; arc=none smtp.client-ip=64.147.123.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="XYbCxxMS";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="GtXsieI0"
Received: from compute7.internal (compute7.nyi.internal [10.202.2.48])
	by mailfhigh.west.internal (Postfix) with ESMTP id 7A0E01800118;
	Thu,  6 Jun 2024 00:51:03 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute7.internal (MEProxy); Thu, 06 Jun 2024 00:51:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1717649463; x=1717735863; bh=7yNfdvlgHB
	kapDUflDwGXuRCZGw+WlEqv0oYVbaynUw=; b=XYbCxxMSQ5/yMtD/iffVYvN8uP
	KTzpldNPv90xenhlILS2Gj1siEM11qLonPZoO3pr1YtdsfC2pilqm1Pf4jDmSMG9
	crIoVj4jbOGOWiUf5PNKLJ0EJ6jqEOtTbAuiF/2vbXeX9SwIqsWtMCU0qvgM7FZR
	GmPf2AFtVjsvvGd106rwa9l6XtZ8EGGIShE6vg7bz1ACPxtM+g9wtx+W0VYr9/Wy
	wKd2w1JR5cg4q7QgCqRMoDV9Ramo3vggiXUH55Q4SPipeszolsr77KhzEPlOkeYn
	r4qjMuwWjx9h7PTns/49qFqbDNmegle+ezYEV/gQ1ZQf+6flJu7Xcptnrf2w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1717649463; x=1717735863; bh=7yNfdvlgHBkapDUflDwGXuRCZGw+
	WlEqv0oYVbaynUw=; b=GtXsieI0C3n6taivK/O4pb3eJqSIgNQO0Kn6opyj6Xaa
	7T/rHzBTq1DPHtH9Z2mcuwMvhibfrwZ3mInChziMc7Y4Pt4CZXqkDUxb8EiJaLkZ
	4sVxbTineojnXUN4f+NT1zzpD2HgO0sI6RfFMrfA17JkfUmB12kZwN5bJz22n9Ro
	tRb7Owc5Vx5du/oF5JezTOQroQcguE1dZA657jzwRDPedCSlgX7ZB2DzHSEJZDak
	5shqV6MWC4qJPIotbzRq0443oN8s1nqPpWva2T6Cesx1aEP1xl8AXli70RV4QAu+
	m1+3lhg88SMWeLa4RVB04d96B6oMTKQyfCs76tWMHQ==
X-ME-Sender: <xms:NkBhZkq4TZNXtOyqBmwWY2i9EAHlAfXmBlhmkgqMNH_WmVnlZ07ulg>
    <xme:NkBhZqoP2OOX5u97ZoZy1zeFDgdRTJADqlvxWJ7t_sP6U9mvOCKxw12jT0Az1pydK
    x81Yf8fCZwVpNWjmQ>
X-ME-Received: <xmr:NkBhZpO_KfWbBiAqvzOEw4U8wUfPe__zK6Buj8klVe7DlcJMA__e7s4EeGkYGlY6O4nZrr13WusppxYNO2tY6JJKNgWtFqKD12dX_TSS_s0qnnAn>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdeljedgkeelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtroertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepheefhfeutdevtdefieetueeggfefleegleevheffueekleefhfeikeetveduhfff
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimh
X-ME-Proxy: <xmx:NkBhZr4PTD-vBgryyg73q5KvVWZKFsVfSwZfEjyN05goxaz_QMLoRg>
    <xmx:NkBhZj4s88wR35LuDsrupZ5er7d91GCDr2mpdmmeMOxbdYKXTvTa4Q>
    <xmx:NkBhZrgmWMvJu2kH8zWD04TMZbQN19giPpIv1wffV0NrSvgUpfCVgQ>
    <xmx:NkBhZt5dj3sj5EZv4cFGLhdOuqxqa7Kr8oZ-QoZXwRGtNLFrXLD1Dg>
    <xmx:N0BhZgvEIe_dpW63J3wYYqO0Go4yJA7JcLskMG11QT0-nq_su6jlhwtJ>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 6 Jun 2024 00:51:01 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id c3b9deb0 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 6 Jun 2024 04:50:28 +0000 (UTC)
Date: Thu, 6 Jun 2024 06:50:56 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Jeff King <peff@peff.net>
Cc: git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>,
	Junio C Hamano <gitster@pobox.com>,
	Ramsay Jones <ramsay@ramsayjones.plus.com>,
	Justin Tobler <jltobler@gmail.com>
Subject: Re: [PATCH v4 06/12] refs/files: extract function to iterate through
 root refs
Message-ID: <ZmFAMBhkuUQEhgCR@tanuki>
References: <cover.1716451672.git.ps@pks.im>
 <cover.1717402363.git.ps@pks.im>
 <f7577a0ab37988476cdb83e310f96f4841c9364a.1717402363.git.ps@pks.im>
 <20240605100728.GA3440281@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="z7Gymyl1xboUxxBq"
Content-Disposition: inline
In-Reply-To: <20240605100728.GA3440281@coredump.intra.peff.net>


--z7Gymyl1xboUxxBq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 05, 2024 at 06:07:28AM -0400, Jeff King wrote:
> On Mon, Jun 03, 2024 at 11:30:35AM +0200, Patrick Steinhardt wrote:
>=20
> > +static int for_each_root_ref(struct files_ref_store *refs,
> > +			     int (*cb)(const char *refname, void *cb_data),
> > +			     void *cb_data)
> >  {
> >  	struct strbuf path =3D STRBUF_INIT, refname =3D STRBUF_INIT;
> >  	const char *dirname =3D refs->loose->root->name;
> >  	struct dirent *de;
> >  	size_t dirnamelen;
> > +	int ret;
> >  	DIR *d;
>=20
> Should we initialize ret to 0 here?

Yeah, we should. Or rather, I'll set `ret =3D 0;` on the successful path.

Patrick

--z7Gymyl1xboUxxBq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmZhQC8ACgkQVbJhu7ck
PpQ9sw/9FO6z25W0AZ8QOZFQSi9b6slscNn5lSflQ8EscHhpPd3LkjvWqQ4XaN7N
TIInv40OuG2xmFRAadOWeQD5aU1JTYACvtO341IZhg/kWA3tcPR+jGbK9df4bcSY
ggT6UlTFf/Pr+OfxvDy6EkOR57cH9eCGCd0ZSxOoFxAPkqsfkFSvWlSCRFS+7ENE
duaQnwkLBUKJVmjmbVNm33cinL4u0DTvLMguWCGl+/17uSaIAtGc1wYDbMrFnzFF
L6rp0JBOw9A8dfa59/VaNHNaWvnTylXaK3lqnw/xlAMFpt5NXsgNwdERnF3sWT+l
Yhf1iodYmQgTsj7qKFiGAbwK2kX9dondD3pStKKkYNmz0dBV65oQOAr3LunNdiTJ
TLGqQOjoVdxfLPuPYKEkCzwP8OuZsojbese8UL2nzjJeG7wS863VNn/KNhg1m6u6
K7JASozefjGQN31G7PLI6QoiB4sdUhRGf9tRuXPEm+YvoU8MClo87XO85hobyxVH
5KkDtqHAyrbrFdgcaEkLYlgzX7a1r65rt8NESb61xY7LwKuf+NIf/19KZGGFB7Fy
gG61E1sFlLJy0fhFgCJi7dGX1xo3xop9Gv+XpAQ0sU4RXirb8SkoNG35Rxt+bLum
0DJtt8H6Dzbr7DzoSyxgsEwjU2ltvqu93hry9HcsSo+dqGmQ1y0=
=KnQM
-----END PGP SIGNATURE-----

--z7Gymyl1xboUxxBq--
