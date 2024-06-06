Received: from fhigh2-smtp.messagingengine.com (fhigh2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 356B42260C
	for <git@vger.kernel.org>; Thu,  6 Jun 2024 07:42:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717659725; cv=none; b=pl6PjOb3RYQdCMgCliRexQrOdD277p617ltd6phHvyrpsF+EKw5paToAR70QUOzw9GYiMBgER9FO3XQsQ9q57E4FUB7HCY+V+2feJ19fBESYVgm80gcVeySwRYEwK2W0q3VbnEVswjP9LwVYYeajRAu7GUYY9fUXoYyy4hPkrnI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717659725; c=relaxed/simple;
	bh=Tg3CFImGIlD6YZN/3NvWTkZydl1u1w5gMaJRxGtAdCU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=n+9zMvL5ubswV74Zf2y8dquIY42HDZaN5THFpiB/GfDEw9Ut+iniCjIyefLreOL04tqHlj329NfVZchw2WNy3bw9JgoVUbNE/XwpalJS4bJplTUYSRyqNwTxZkjFSR3fZaHRYWZl7X137iFQQHSeTga6b6OnUCm1YyCbaVLDG5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=iVrRxQUC; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ClieNxx/; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="iVrRxQUC";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ClieNxx/"
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 5966E1140155;
	Thu,  6 Jun 2024 03:42:02 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Thu, 06 Jun 2024 03:42:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1717659722; x=1717746122; bh=29YAHlsAwe
	hTdRLKNTGPSri7uKtevLOTMpOR0rarXJ8=; b=iVrRxQUCYuDyfIYVxUFV5CovRv
	+bY1MkB9HLUyklnL3SIaPd4JMuLdbLoTct2YX6IOhzst/cLtyHrMmUZfRBqh4Sdz
	C18esxJhhQpFEz5wpkNESCyZOjcu3yaGcVraCbQf0GVgWK037A93Ocqk6J+jeOpG
	wzD/5y9VVt2mTTPMvTDBe/KKGUOXWWptHOwc3Rpz0dOenhEDXm91IxWS2Txf+f1E
	BBaDOP2LTctSqRwE4Kw/gjRYVPNwCKuow1WJkw+k5vT+WfPcuvDLolgJMflIZ1Zu
	jNMraXRwfIzYFHzInHcSdTrXbI/oAIuhMHn9DisVnjjl9d0bE1aA3bBYLm7A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1717659722; x=1717746122; bh=29YAHlsAwehTdRLKNTGPSri7uKte
	vLOTMpOR0rarXJ8=; b=ClieNxx/aKJWvlAoJP3gqg4h6uzVxi8BRQR4+MMPdo90
	bgBM8xdYUr7+MjcNZu9jtZ4KsYpQ4WwHFY4ym4p58z7xFadUp6CPG/2tMF3mWgV9
	c2EhEM8gkrZtQKZ2cqwYUCkAwL50usR1P08XJkzHR5+Yus4ogQYxiOVDoStaXo+h
	9XuejKHeudOXCZo6d8bS2wUdnaaBohKuYA/8fsLBKrBUMPwj55aSF3DpxuXO/Wqd
	Gfvop6gwh/jUjogCM6TEEIODsnkq1biVvWqrUkFSJ1ouwLUo/b5dJmI14fHrew3R
	TnH3HOMaWzii7AkTMln82ESNwRAL9fqjkmKqumuEUA==
X-ME-Sender: <xms:SmhhZrAJDhx8mzRMlo-3yr47Za7WeEdPZx_eu0UJuVfbxWGAzNR_5A>
    <xme:SmhhZhhc5GRap_7sWyfmMjzLdlTk0_MS9HHMKM1h3Tb8Oc3seai5Y_BQy0CmWFacl
    mv6Cd1LJ1xcCHxi8g>
X-ME-Received: <xmr:SmhhZmkeec0MwvnQcdJu62Mq1O1yNsChsE0o74Uo2ELL8K4eprkrP5TkjkOK2qHKzkJaSXi8LOY_GTIQwMOi4dnax1VYfTX7KxxMYjU_ri4PEkHv>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdeljedguddvfecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecunecujfgurhepfffhvfevuffkfhggtggujgesgh
    dtreertddtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhs
    sehpkhhsrdhimheqnecuggftrfgrthhtvghrnhepueektdevtdffveeljeetgfehheeige
    ekleduvdeffeeghefgledttdehjeelffetnecuvehluhhsthgvrhfuihiivgeptdenucfr
    rghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimh
X-ME-Proxy: <xmx:SmhhZty0k6mg8pTt5roQ4bpReZYOmDfm2uQi6dYOYQZNKH1rdHO9hw>
    <xmx:SmhhZgRudadEmGEj0oqvMA973iSLCwefG_Z6P_l0RNo_Wf2pWTaGJA>
    <xmx:SmhhZgYMbjLdkGmRmx9bLFoMCA0FQ3_brLPcta2iGJu2U_8KKU4Nwg>
    <xmx:SmhhZhQUzhMSEW5STJWDi5y7yB7H3ihCH-yL0Uli1sXZSwUfkUIyLw>
    <xmx:SmhhZmesLTbBWv3g8mSrrUd9rd7V7ZdqBRbV1DmV-fZxW6sP4BWV2IPs>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 6 Jun 2024 03:42:01 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id 327e6bf2 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 6 Jun 2024 07:41:28 +0000 (UTC)
Date: Thu, 6 Jun 2024 09:41:56 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Jeff King <peff@peff.net>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] ci: let pedantic job compile with -Og
Message-ID: <ZmFoRPd52iqxbOTJ@tanuki>
References: <cover.1717655210.git.ps@pks.im>
 <351dec4a4d5a5619e7627e11a8e674e32125125e.1717655210.git.ps@pks.im>
 <20240606065236.GA646308@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="XliT5eWEfuGcjjEr"
Content-Disposition: inline
In-Reply-To: <20240606065236.GA646308@coredump.intra.peff.net>


--XliT5eWEfuGcjjEr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 06, 2024 at 02:52:36AM -0400, Jeff King wrote:
> On Thu, Jun 06, 2024 at 08:30:34AM +0200, Patrick Steinhardt wrote:
>=20
> > We have recently noticed that our CI does not always notice variables
> > that may be used uninitialized. While it is expected that compiler
> > warnings aren't perfect, this one was a but puzzling because it was
> > rather obvious that the variable can be uninitialized.
> >=20
> > Many compiler warnings unfortunately depend on the optimization level
> > used by the compiler. While `-O0` for example will disable a lot of
> > warnings altogether because optimization passes go away, `-O2`, which is
> > our default optimization level used in CI, may optimize specific code
> > away or even double down on undefined behaviour. Interestingly, this
> > specific instance that triggered the investigation does get noted by GCC
> > when using `-Og`.
> >=20
> > While we could adapt all jobs to compile with `-Og` now, that would
> > potentially mask other warnings that only get diagnosed with `-O2`.
> > Instead, only adapt the "pedantic" job to compile with `-Og`.
>=20
> Hmm. This is the first time I've ever seen lower optimization levels
> produce more warnings. It is almost always the opposite case in my
> experience. So it's not clear to me that moving to "-Og" will generally
> find more warning spots, and that this isn't a bit of a fluke.
>=20
> As you note, we'll still compile with -O2 in other jobs. But isn't the
> point of the pedantic job to enable a bunch of extra warnings that
> aren't available elsewhere? We wouldn't have any coverage of those.
>=20
> So for the pedantic warnings, we're left with a guess as to whether -Og
> or -O2 will yield more results. And in my experience it is probably -O2.
>=20
> If we want to get coverage of -Og, I'd suggest doing it in a job that is
> otherwise overlapping with another (maybe linux-TEST-vars, which I think
> is otherwise a duplicate build?).

I don't think linux-TEST-vars would be a good candidate for this because
it uses Ubuntu 20.04. Ideally, we'd want to have a test run with an
up-to-date version of Ubuntu so that we also get a recent version of the
compiler toolchain.

I kind of wonder whether we should revamp this pedantic job in the first
place. The consequence of that job is that our codebase needs to be
compile cleanly with `-Wpedantic`. So if that is a requirement anyway,
why don't we run all jobs with `DEVOPTS=3Dpedantic` and just drop this job
altogether? This may surface some additional warnings on platforms where
we currently don't set that, but is that a bad thing?

The only downside I can think of is that we stop compiling on Fedora,
which may have a more up-to-date GCC version than Ubuntu. But if the
goal of this job was to _really_ get an up-to-date compiler toolchain,
then we should rather pick a rolling release distro like Arch. Otherwise
I find this to be of dubious benefit.

If we merge it into the other jobs, then I'd just pick any random job
that uses "ubuntu:latest" like "linux-gcc-default" to compile with
`-Og`.

> > diff --git a/ci/run-build-and-tests.sh b/ci/run-build-and-tests.sh
> > index 98dda42045..e78e19e4a6 100755
> > --- a/ci/run-build-and-tests.sh
> > +++ b/ci/run-build-and-tests.sh
> > @@ -44,6 +44,15 @@ pedantic)
> >  	# Don't run the tests; we only care about whether Git can be
> >  	# built.
> >  	export DEVOPTS=3Dpedantic
> > +	# Warnings generated by compilers are unfortunately specific to the
> > +	# optimization level. With `-O0`, many warnings won't be shown at all,
> > +	# whereas the optimizations performed by our default optimization lev=
el
> > +	# `-O2` will mask others. We thus use `-Og` here just so that we have
> > +	# at least one job with a different optimization level so that we can
> > +	# overall surface more warnings.
> > +	cat >config.mak <<-EOF
> > +	export CFLAGS=3D-Og
> > +	EOF
>=20
> Writing config.mak is unusual, though I guess just setting CFLAGS in the
> environment isn't enough, because we set it unconditionally in the
> Makefile. Doing "make CFLAGS=3D-Og" would work, but we'd need help from
> the code that actually runs "make".

Yeah, I went the easy route because setting it via the environment is
not enough, as you correctly mention.

> I do suspect the "export" is unnecessary; it should just be used by the
> Makefile recipes themselves.
>=20
> Your command above also loses the "-g" and "-Wall" from the default
> CFLAGS. Maybe OK, since DEVELOPER=3D1 implies -Wall anyway, and "-g" isn't
> important. But one thing I've done for a long time in my config.mak is:
>=20
>   O ?=3D 2
>   CFLAGS =3D -g -Wall -O$(O)
>=20
> Then you can "make O=3D0" or "make O=3Dg" if you want. And I think that
> setting O=3Dg in the environment (exported) would work, as well.

Sure, I can do something along these lines.

Patrick

--XliT5eWEfuGcjjEr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmZhaEMACgkQVbJhu7ck
PpQxQA//apwCmGyDKuPpYLeZt5JhDb1gLyUaFN3MyZtxqzDJacb12vtqFw5MNy+Q
QiPK8s7KYY6TSFurw93Wvn0NC+cyojiBKdHlZSl58oU2C9IGTtmxlyiu/rygD7v4
4uPSkN9+dNRZWQr997Hqnk0a/2Ni1QL57av6vyj9I9/WiIsZcFMhYV8cKd7jL1y+
Mral3YsS535QbBCiWjqtb4zKQlLsJZ2ldt6eXkB9rq3aBx04nOBgeOpZxoUOrGc5
Bv3GC+4dG/nvEzn7mHxurxqokHzMnb1xiekkVIAzvEBInRa8lKHtd8GEogk8e+qD
THUv8N0SOTQNOc+WWjAqaCEiwlRgaobDxaL2BVqHYAZV9GSP4u0KoHv/+Y3j7N2o
hRwicSj9BmbaAqUEOvinnOMXKyha+rhCBI4uxMggye2uzNx0BITjwS0qIUy97tnj
uRBcWFLrFXdEwbAF1DMjczOxTt7GZo5hJ7FlQ5GxWlsiEyTtN8YX9+YhZXhnB1tR
C8DvpZAUAaKgxEPKO1L2+kzr5Prj/sN4to7FIfkl6MoqaYVQAfzbRb+VmNeH13o6
QdWc9jFFGoQTO9SeWIJyh8s7aF+zPt2Cjxr9E9VN0xUppC70Cc+13bm8R+aBER0X
Q74fd+vZkqNpPULTs8VRgLhCWjSMx4dFhcFVqeofYaLKwFNP8HY=
=Xhp/
-----END PGP SIGNATURE-----

--XliT5eWEfuGcjjEr--
