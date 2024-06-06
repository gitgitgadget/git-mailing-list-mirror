Received: from wfout6-smtp.messagingengine.com (wfout6-smtp.messagingengine.com [64.147.123.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F4DB1754B
	for <git@vger.kernel.org>; Thu,  6 Jun 2024 05:15:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717650948; cv=none; b=GsPz8rnHRRm/wSAZ/qE5u9wd0uCh/DHDE+O/ObyiYdvVJgegcQ+Cz6KsLsKsrX4ulBy93/9BaOFXlj8CgAPBWC4M+6CVjYhjFw8SoqFnfgV+gjFRHiQO4qwqj74TuHoNE/QOApVECqa5X9H3Ixu0pZw+pj0WdRDr+8J2kjuCh/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717650948; c=relaxed/simple;
	bh=UYxIItkiRb7H2vG8yqGQ/POOKvlHCS7XGz1xcHah7OY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BA2zXwZTbn9osLqWXR84R1sUC0/KM01H7nMkYAlHdPEBHfRS7RexC3RIqD9rx388kZYFoxlKCaXbD8xrIwMRWs64swUxg4KGAeeIzAUNkAzIQyg1DngHxpGQRWjfmm/wx6wzwwvdgelkfgK/ckBttcH7u9WU6dciEtVjNNG/kqM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=UpayXJzT; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=c3QjQj3N; arc=none smtp.client-ip=64.147.123.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="UpayXJzT";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="c3QjQj3N"
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailfout.west.internal (Postfix) with ESMTP id A0DF01C001A5;
	Thu,  6 Jun 2024 01:15:44 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute1.internal (MEProxy); Thu, 06 Jun 2024 01:15:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1717650944; x=1717737344; bh=vGp+zU/NrG
	hfR2NZiaHsEycEV7vw5BehiKL7t+/eJcg=; b=UpayXJzTmaHbndtS5Ft6MRqmXO
	E4UwaHk2tm7MJrBpTSSY4UhQavbSJrtcdm0Cy3KvKGV1oLNLRO0BHUOWGl2aRw3M
	55xnDKfd0G1fpmICsGuXD8eNwes/+jDwr0tUTlyj7POeeSsepC1GWDXwKMeicKM5
	BGVFzCIH0Zcs/r9p/xmWlHkyWBCDMh9AofxB9YbEuFm155n5DeLcVL0SfRV6tP9H
	C3sj9dabyEXxOX1tD8n5XUu3tR2voe+IMji1dEKRULJHg1AWdHW6hVrOS8ITowMg
	WddtJWPEPf6P3BI7I1PPpBFAJwzxgyWQ8s94yuLUF6EUli5QN42y09JcN1fw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1717650944; x=1717737344; bh=vGp+zU/NrGhfR2NZiaHsEycEV7vw
	5BehiKL7t+/eJcg=; b=c3QjQj3NWzAkR4OFMnWIVbn7TEQpNyli+/+dV4vQjDT7
	zYf2GjAKCgkNXwDDk09XUvJ0od7D6lOcBCwbg2vuFSh8I/fCulksAKnkQC4UmvuO
	QtSz7r4JPQ876/7Mnv6mLePLi+bfRC41qTBCVaE2ySHgDGZ0IkZWtL7f1yS0BU9N
	FAl23diJfwlF2n4IWL4yLXiueqbY1/M5RbaMEETGZsaW6t+FU8HMjHJoE9mv3CQr
	fUjNjpJsvikHFAbWUUygOV/fHxOA7vsApVmtn+rDzYdKywEXOXhGIUrAMNGDETb+
	4xGDSmzYkFnuLhKkW+vUHfBGhEJcufUm1SjGlDnYQw==
X-ME-Sender: <xms:_0VhZuoVv8P4h22_2Cv8yDWkbzO41rLQGBscx2Ejk8M3ERbcFj7FEQ>
    <xme:_0VhZsqsum2S9Kpj6kzDg_Rq93yMoN5BW6T3x6RcbJ1E9XsaHBqfjmbgns0xz0aWJ
    v6yM7nKzRknel_jQw>
X-ME-Received: <xmr:_0VhZjNmUd2zE0PJwgYZz4MgxCy76V4iMhdA5yuQnblDW9hMNFIQKquK7oL9GLLF0nYUBzv77soB7Q_Z3X5X-Mp8E71MIKpl4VXk2yX8Qm7BAmpC>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdeljedgleefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtjeenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepteeuvefhhfdufedvgeeiueeileegtdfhgeeftdeuveejjedtgfejhedujeeutddu
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimh
X-ME-Proxy: <xmx:_0VhZt7BYRNThuxjuU45FfjVmeu1YAY4hN2Xx2Pv3eugJ7R8Tu-e1Q>
    <xmx:_0VhZt7DuI2gCI0cvEqt83X4seJiwpugMoaAFzcwDy_63t_3BqxlLA>
    <xmx:_0VhZth1M-1aWGE5ZSqieihZzs60yzCPB030FLxh-HY2pfrbdwhKhA>
    <xmx:_0VhZn7OhqChZHGOUGKGOtHV2xWLd0cjKPFeUDJazmtSl8w9cqw9Tw>
    <xmx:AEZhZqvJJYswm7HB-zw2JEGDnh8O7G5rf5OjQF4BXbKv0PJb4USrhqwf>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 6 Jun 2024 01:15:42 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id eeafdd52 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 6 Jun 2024 05:15:10 +0000 (UTC)
Date: Thu, 6 Jun 2024 07:15:38 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Jeff King <peff@peff.net>
Cc: git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>,
	Junio C Hamano <gitster@pobox.com>,
	Ramsay Jones <ramsay@ramsayjones.plus.com>,
	Justin Tobler <jltobler@gmail.com>
Subject: Re: [PATCH v4 06/12] refs/files: extract function to iterate through
 root refs
Message-ID: <ZmFF-kgZSlB6O7Gs@tanuki>
References: <cover.1716451672.git.ps@pks.im>
 <cover.1717402363.git.ps@pks.im>
 <f7577a0ab37988476cdb83e310f96f4841c9364a.1717402363.git.ps@pks.im>
 <20240605100728.GA3440281@coredump.intra.peff.net>
 <ZmFAMBhkuUQEhgCR@tanuki>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="LyKGinUk9vEyyav7"
Content-Disposition: inline
In-Reply-To: <ZmFAMBhkuUQEhgCR@tanuki>


--LyKGinUk9vEyyav7
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 06, 2024 at 06:50:56AM +0200, Patrick Steinhardt wrote:
> On Wed, Jun 05, 2024 at 06:07:28AM -0400, Jeff King wrote:
> > On Mon, Jun 03, 2024 at 11:30:35AM +0200, Patrick Steinhardt wrote:
> >=20
> > > +static int for_each_root_ref(struct files_ref_store *refs,
> > > +			     int (*cb)(const char *refname, void *cb_data),
> > > +			     void *cb_data)
> > >  {
> > >  	struct strbuf path =3D STRBUF_INIT, refname =3D STRBUF_INIT;
> > >  	const char *dirname =3D refs->loose->root->name;
> > >  	struct dirent *de;
> > >  	size_t dirnamelen;
> > > +	int ret;
> > >  	DIR *d;
> >=20
> > Should we initialize ret to 0 here?
>=20
> Yeah, we should. Or rather, I'll set `ret =3D 0;` on the successful path.
>=20
> Patrick

I was wondering why the compiler didn't flag it, because I know that GCC
has `-Wmaybe-uninitialized`. Turns out that this warning only works when
having optimizations enabled, but if we do then it correctly flags this
use:

     (git) ~/Development/git:HEAD $ make refs/files-backend.o
        * new build flags
        CC refs/files-backend.o
    refs/files-backend.c: In function =E2=80=98for_each_root_ref=E2=80=99:
    refs/files-backend.c:371:16: error: =E2=80=98ret=E2=80=99 may be used u=
ninitialized [-Werror=3Dmaybe-uninitialized]
      371 |         return ret;
          |                ^~~
    refs/files-backend.c:334:13: note: =E2=80=98ret=E2=80=99 was declared h=
ere
      334 |         int ret;
          |             ^~~
    cc1: all warnings being treated as errors

I'll have a look at our CI jobs and adapt my own config.mak to include
`-Og`.

Patrick

--LyKGinUk9vEyyav7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmZhRfkACgkQVbJhu7ck
PpRbYxAAoUaL/lExoj+NKgq8e6XgvK0DfhrwrlDat/P/qdtKlRN4i8Mzf3IQkd7F
DIv3vS31LqIS/WOHGni77NirmVuwaTibmXwqAmfroSw0qEagz19Y7vvJwq0wj8Vt
9lllKi+YKeRofV6WfFZqic4J6zqoA73ozuH5S5M5W9ZR9HHZBN6eXcrU+X7Mxo3f
d+CkiETXgBa1/pFD6XFfKXHdOwhuL2qvRGZVD5YtW5WVkJiZ4jAs+LSW5y+oejYU
xZPm4YTHbrUmBkni4rdyV+aSSKFuPKDEeEqCkW1lGQ+Ky8LHXBF0XNkvzvyGgTgc
hfaUatRvpC02S+v+FlGiwNwANq0ZDB8ihyCFiJ35ow02OM6uLjHx8vegNVmux2Xf
Ic+Wh0Iz6ydShxebzWciZO5fiaKh7Livf3eMhJprh/R5cvCBPtAvEJoGb50tr0Hs
mlRowRnYJSUwKQY1yfUUOUEmebi38ct6qt3yrzK06w+tY7HLA+swu2N5QS16TnVf
pAnMznwtlyxEtCL/BMabjluno62dYaaIZIRZOxOKS6g83rj4Cr1LWWr8c01NJm0V
pWOjsoyhMAJTk2nSeWEzC4TXJWRB7UPrLkDGVtqBqyoE7rqiUFM03qWyOgqb9ORb
7XiyjmBDCPsqmISZP4JoBIf/ncj5SPaiBEV19+QLwhF0qyuJjO8=
=aSmM
-----END PGP SIGNATURE-----

--LyKGinUk9vEyyav7--
