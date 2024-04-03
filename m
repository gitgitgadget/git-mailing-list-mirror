Received: from fhigh3-smtp.messagingengine.com (fhigh3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED93F136674
	for <git@vger.kernel.org>; Wed,  3 Apr 2024 10:47:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712141243; cv=none; b=NKfjlUaKcphAHS4jTOzMpIdSmV/fzY3CU4c+AlcuIZWMQ968hsijn90r5sjwq2nfmAEBU+5rLbRBwYD5p+nuQxPIp3koX7WH37/sfC6MC73rGTVg6tCdDO6tJoNgBlcYUMypLUGXqvgE84+52YAbkXA1lJ4hBtvcFx3lJOoHAM4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712141243; c=relaxed/simple;
	bh=G0IK5j4V7PSqWIvYRAX2UaJmCK7rbVbkM0HP3/VETWA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Hi0Q4KYGjBzRTYyEgRflqgpr2Kmi/NjtslaDZFEXjxHZPDBMI27EGGUds+q0d/fshi/hD5840LRnAWFTvvRIL3fKnDyaO4r2UCutpRImmIrUxx6L5V6RfQ4K2xNk2dOE955S1/jAJBJQNmOCGF4Uw/iSvFUxPXlakL4bkQgTWrU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Er7wkkQY; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=gqndwr0J; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Er7wkkQY";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="gqndwr0J"
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 01DF81140142;
	Wed,  3 Apr 2024 06:47:20 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Wed, 03 Apr 2024 06:47:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1712141239; x=1712227639; bh=VHqD9C2/jk
	/eg1CIfdfTwTJQx7CqqahFD5wu7TT/d8k=; b=Er7wkkQYorYVCm4MFMAYyIOr/O
	N2Tfvf6+ibNjT+EYf5LWaCdGgzlUGnJ8YuhlXwlYLvGVZo93C5VMvcDygy25A7eN
	OuOeqcPSuGZ23L4YzCBB5N4Ue7qbIHihisL3Ujxv+AHVqiF8K1l9HoYSkNRLt+kv
	CSsaccT8gglaMtTPWBjyIS0nZ1wtCuxejREhN/O+qZtdU2OpFqXHNtEeu8ghkY1a
	zcAXRjfgovywqA5KMy6Fm5t0ZFvgolkhLnuanlHLw5f2aGHw5rESnTY5+sHF7sJo
	WbZC/eUvWYwWkQQ3D0J5HSg+cC758KYXoDakPBdd1jeuHx7RCW8XwNNhoFdQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1712141239; x=1712227639; bh=VHqD9C2/jk/eg1CIfdfTwTJQx7Cq
	qahFD5wu7TT/d8k=; b=gqndwr0Ja8mBY9mL5DZ082is26SzqzMiLuPbtUEnzEtr
	eI5NXkEJAP3VcIubCRw9lmS8lZW4yfOOFII/VT8Cz8ULGGe444dtM7dWql+Hzaum
	drJgtTJ7uRI38J2wIxRSveK+nC34Z4ur4qJZTMeuiSoWFUoCmuCZ0TJ+S9UIdMdy
	kNulKGPQzqzbtTUcJtgHOllUdCuadZLG2o2wBU9HUj4ur3rdT08bJc9oQbIf2bcq
	yLJYh6C1uBlBe2P0lIrb88eoWvrRbuGT27stXHjDA7NpofkjzdvJCoebNtef5yW6
	yJkgXYrjxJLHrZWAgq4OybsyXqkP0z00Wp8cy4lhPg==
X-ME-Sender: <xms:tzMNZoXjP1I5W3sgTYPWnhyE_AD4XMslGHLDxCOBkQ5nUy55BHXpLw>
    <xme:tzMNZsl5L8gQ6nm5VoDlsPYqDRIOlbQ_WzpWq6zmrqO9-9jjT2QKGVa-_ZmOyztCh
    Mz40Ac4gzaawv5UdQ>
X-ME-Received: <xmr:tzMNZsbITW5svl0Fe4cpDlJPZbKQxd5uIMewj3kiBcwDNcM10tPX600nfx6i60VA_wuJlgMACBi4mgq8nmEplid9KytEcpftyaXAwQm5ttaA4Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrudefhedgtddvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepueektdevtdffveeljeetgfehheeigeekleduvdeffeeghefgledttdehjeelffet
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimh
X-ME-Proxy: <xmx:tzMNZnXM6-ggDk95ixlo9nZ42cadFYVjbJrUw2CNz67-K1q6zRce6w>
    <xmx:tzMNZinwNjShxn5uFh-bB9D3eueLKvdOhMhl_EZJjpVlbQXrjXe_tA>
    <xmx:tzMNZsez2wu-C8vur_zk2_tgvUU3Hj62hzIhYmg9E1ih_HUqdWhCAw>
    <xmx:tzMNZkHnITCF5RT_7R-pJMkE_hbLjCf-H49bz2jsiepSoi9taAiEGg>
    <xmx:tzMNZjC9VmPOlduYoZ0tZtoNw6fscV8qHcxcPo3M5NA5fDDm3HxFDnEO>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 3 Apr 2024 06:47:18 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 0ecc6b2c (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 3 Apr 2024 10:47:07 +0000 (UTC)
Date: Wed, 3 Apr 2024 12:47:15 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Han-Wen Nienhuys <hanwenn@gmail.com>
Cc: git <git@vger.kernel.org>, Josh Steadmon <steadmon@google.com>
Subject: Re: reftable & jgit compatibility
Message-ID: <Zg0zs2_QLpXv2PwT@tanuki>
References: <CAOw_e7Z_10b73n91ihsaao_S-XPkNqvY7gTcHvqUODKD-SwPSA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="0IxymOLnhm+j069l"
Content-Disposition: inline
In-Reply-To: <CAOw_e7Z_10b73n91ihsaao_S-XPkNqvY7gTcHvqUODKD-SwPSA@mail.gmail.com>


--0IxymOLnhm+j069l
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 03, 2024 at 12:36:04PM +0200, Han-Wen Nienhuys wrote:
> Thanks again for taking up this work.
>=20
> As I'm browsing over your patches (and realizing how much of the
> arcana of the format I've forgotten), I hope that I did not make any
> errors in implementing the spec (and/or that Shawn didn't deviate his
> implementation from the spec). It would be extremely unfortunate if an
> incompatibility between CGit and JGit were discovered after it is
> released.
>=20
> So far I have always been able to read JGit reftables using the C / Go
> code, but it would be good to systematically test this, ie. generate a
>  bunch of tables using JGit and check that passing them through the C
> code (read & write) leaves them unchanged. Or perhaps check in some
> tables as golden reference data.
>=20
> Josh can probably connect you to the right folks to help with this on
> the JGit side.

I very much agree, this thought has crossed my mind multiple times while
working on the whole reftable saga. Ideally, we would have integration
tests that write reftables with one of the implementations and then read
them with the respective other implementation. I wouldn't really know
where to put those though. CGit is very unlikely to pull in JGit as a
test dependency. Does JGit have any tests that already use CGit?

Adding a bunch of reftables pre-generated by JGit might be an okayish
tradeoff, I guess. I also don't really expect the format to evolve
significantly, so these should be reasonably static over the long term.

Patrick

--0IxymOLnhm+j069l
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmYNM7IACgkQVbJhu7ck
PpSLpQ/+L0WLnnEIQ6nY/dK4abXbpTKhrM8ZNuUlP80GAJRrp6hzR6MxpItdTZqQ
KniHcEAS5T/yvqYiOw8IR2VX8EmzLRMFAjZyc2tQSHzw/tz92h/H2J9/vV+UUp5T
ns1nAtDCbz9aq+vJgkAMM8RZLFtVx6z+OMjEQQ44YtpvE3Aap4JoSdncq82EtKLM
pNnn+DoyM9GWPAW+NlTTfyLr/rkIO6x+Q1PULrOQprM8sdJG0MEqj/FuA/yJfrtY
W/TkSDRgLzzPAftlgKDEt1fvlFx0BsO7krqUsSx1iBwmOgo3Z968KhVMMoyCkdm4
K3MRt/tjoDqE0jzDYPii5Vd+aeXGLwXBeFgZvGbT7mU26a/mbnhxH/RSLwovMbk5
pOi+8NgRGIFPJTKMuGLEomjMcau8fp3oMf7rL0tXMJ4uiuJYiAjJpDlFHsEOQC44
laKETxTVjU4uFpsQtZYer4jVOtEyj+OLX7ukFdU+xqLS3VIKcsCrHQcj8Nxbv3E1
A35Y0+67a8sKprZ4kiP/OqZPAKFiSQR5D6HHeuZGyTLguH1lAWnPcxP1Pctb/uYi
2U3Mjr5O7lO/A/Faxi5YORHiZIRJSOVInw+Xp2wJPIkZuJaYzpnvQXsmgG+a4/eg
ydZUOGTNb79nBv2/KlwDggliEoYf+LjDMhPyN7iDcVGLhMbSuNQ=
=QWOb
-----END PGP SIGNATURE-----

--0IxymOLnhm+j069l--
