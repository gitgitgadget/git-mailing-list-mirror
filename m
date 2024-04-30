Received: from fout8-smtp.messagingengine.com (fout8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 490FD1292CE
	for <git@vger.kernel.org>; Tue, 30 Apr 2024 10:05:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714471553; cv=none; b=MWPYDCay1JcxabRWSGXuudcEQXHGDAojZ3B0LLaU0IMOhcLTBpYHVywJQ0J5kHzsZ80BPuIbYyl0YAjhn2x/jS/kyxWuGRvW7cGQUl2U3XIAcb6yCy7piSnZbIJPjM/rDSYZCvjobwgIPMQRpIu7Rl/MdgHMZ6FnKpLRdqgbSxc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714471553; c=relaxed/simple;
	bh=y8a2x5W+xtiI4igivKv6ao6xoobCLuF84T9kL5trDkE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=l2zDhLsNMxkWxhCJoAbQe/8U+DZ+R+GBKC5vMDS16nyZqAg8oZqfanwVYLYs2eygl/skMljva+xmr5nmbsM34QIYdX8mYYocA3X/C8ZqBbaRDwzvCIkA6tobi3FpLMEYzE3/xHKYvxwrzyKDILsTqyfDWlOAkmPc3dEb3Hgspf0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=CdsaqoOi; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Ht+9xZC6; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="CdsaqoOi";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Ht+9xZC6"
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfout.nyi.internal (Postfix) with ESMTP id 29E461380EB9;
	Tue, 30 Apr 2024 06:05:50 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Tue, 30 Apr 2024 06:05:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1714471550; x=1714557950; bh=y8a2x5W+xt
	iI4igivKv6ao6xoobCLuF84T9kL5trDkE=; b=CdsaqoOiVMpzOfkXNFpdfr32DY
	nUTvKsQ5r4n6VJy9Dq+MvsPfHW7BglJ0nwgXAU8uL4kowiwXmsIaylkqahDJsQWM
	eqCqW5t+jhp6facsvrTD8fgfcXP11r1S1K2/ptKVd0ObV1VLAqALy7qFUHJK+pnl
	ThO/p9rC4iYMz5n0Df3Ir+lUIZuWysp5z/Ut0QEiAeK/6QKQBQvX4Ppo9fM0AlDq
	5Qs/RkkwuQBLtRn+1DdV1tQSg9hB57YlG/p2TDH1/ENN2jY+ldjCEB84Kl0n6kJT
	3rI3Jp1J3Jz8t8IB7bu8qkbPNWFfbRgeukTMzrZD47L7QBcUT5C8k69l/Zpw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1714471550; x=1714557950; bh=y8a2x5W+xtiI4igivKv6ao6xoobC
	LuF84T9kL5trDkE=; b=Ht+9xZC6lsYMp8GvKPQGQHk6d/BcqYIlqj8d8qopX7FV
	z29HouBZZ234/5OGYI5rfmwws8bkqYJQST4zXL579CpBUQXjoZvVKps64o7FcanU
	cTuqJEsCjTChKqSpzAFZa8VHTaIoAYA38FokZMS+2qKxGk+2uZxGbHpDPzQT736/
	pmrpfndF4o33q+whJE7mSpn8BAsnb2+7zpYy3w3dnYgV3UR43IJ4Qyo8bwFNpAp8
	e8gPnGN+idb+KeQFKjaJmPu8aa150pnQCSQA1NXPql7BroGnHYG0LlIG8vVPpz8y
	RCHzZ2ckctO5VTImKLZfQMVkWD2YBegeb8PT2gr6kg==
X-ME-Sender: <xms:fcIwZmgkKxFNPwWb7Xuc-C3YuhJuIdUVkotx1UaN1rFKyh_6Uk9emg>
    <xme:fcIwZnAM6hlZf1m5kfeYiAOAcokvWlliiL5rkgGvfJQswucw7qJB7UkK7whb34Hq4
    6Klv7Fys0SBPQJJow>
X-ME-Received: <xmr:fcIwZuFDdN4wlWv9Fu21qsT-H7SV_QF9hrXuudaI2TXrlBo5TKH5xGg7cwvDfsFYibYC36myWdj43BSt4uGwP_wkuUbQ3BO0wh3VZyB_lNUsXQ_Vj_FX>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvddufedgvdegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepueektdevtdffveeljeetgfehheeigeekleduvdeffeeghefgledttdehjeelffet
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimh
X-ME-Proxy: <xmx:fcIwZvR4zCKu_tbvDsyiaWXNO62cHgHVVkYqRDREMx8GA-PqKBLJpA>
    <xmx:fcIwZjx87tpvWDLBEG4OHZ6QotFPHw8s0Vc1cOSbkPgoBf4k357B3g>
    <xmx:fcIwZt5pX4v15VA8GGw3ZmoocSKpk6WrqVe3kLFKj_S6hKvMjr-U_g>
    <xmx:fcIwZgwZA6Dixz9Yq5WdUNJUQ7EQB0o7-WiIcbgxWuaSAgPEYWYv2w>
    <xmx:fsIwZj_ty04UteWroYSbu-ezcTkEGVBtHbOzz2uQouS8ltoAHj4Xuw8x>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 30 Apr 2024 06:05:48 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id 3b0dda36 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 30 Apr 2024 10:05:24 +0000 (UTC)
Date: Tue, 30 Apr 2024 12:05:43 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Jeff King <peff@peff.net>
Cc: Karthik Nayak <karthik.188@gmail.com>, git@vger.kernel.org
Subject: Re: [PATCH 6/8] check_refname_format(): add FULLY_QUALIFIED flag
Message-ID: <ZjDCd3z1MeFlvh7Q@tanuki>
References: <20240429083325.GE233423@coredump.intra.peff.net>
 <CAOLa=ZR+nunNg8_LMTzwoHzbBU2EboMSsZRodswLP9bMLhtCpg@mail.gmail.com>
 <20240430094738.GA1279403@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="edyErQADgdVVtTMU"
Content-Disposition: inline
In-Reply-To: <20240430094738.GA1279403@coredump.intra.peff.net>


--edyErQADgdVVtTMU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 30, 2024 at 05:47:38AM -0400, Jeff King wrote:
> On Mon, Apr 29, 2024 at 09:01:52AM -0700, Karthik Nayak wrote:
>=20
> > Jeff King <peff@peff.net> writes:
> >=20
> > > Before operating on a refname we get from a user, we usually check th=
at
> > > it's syntactically valid. As a general rule, refs should be in the
> > > "refs/" namespace, the exception being HEAD and pseudorefs like
> > > FETCH_HEAD, etc. Those pseudorefs should consist only of all-caps and
> > > dash. But the syntactic rules are not enforced by check_refname_forma=
t().
> >=20
> > Nit: s/dash/underscore
>=20
> Oops, yes. Will fix (and the same mistake in patch 8). Thanks.
>=20
> > Also FETCH_HEAD is a special_ref, this confusion should however be
> > resolved with Patrick's patches [1].
>=20
> Hmph, I guess I was not paying attention and missed that the distinction
> even existed. But yeah, I think for the purposes here it is not at all
> important. This is purely about the syntax rules, which are the same for
> HEAD, pseudorefs, and special refs.

Agreed. I'll send out a complete rewrite of that patch series in a bit
where I drop the distinction of special and pseudo refs completely. From
thereon, pseudo refs return to their original meaning, which is a file
that is not a ref, but that can be parsed as a ref via git-rev-parse(1).

I think that the current state of refs, special refs, root refs, pseudo
refs and head refs is not something that anybody can reasonably
understand without studying our ref code for months. And I did study it
for months now and still feel like I don't always get the full picture.

Patrick

--edyErQADgdVVtTMU
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmYwwnYACgkQVbJhu7ck
PpRvgg/+LzO5h4vYGUNzWZKYzXZx+Wvfcn+TUSs1fJo432crb0Zj9aOlSwga4w3B
tX7zWoyEK5YejmauIoyaMaW73lc8s1ZFjMmXa1v1qWW7wl+4TLbZkTOBFyCAEDd7
/tXG8hirircbqSSd8uO9ZWg6N9Oi7hcnvupWzOBmHyfA0TF4SOAMa0VCmV+tlq+z
EQiGwW8bAIlDIEYuCkxIyCp7C2cRBOO4TzfC3sA4bCP/E3c3YCWzAnJJTqQ/eWtl
AySG7VG13YCKHGwbu5ilR2PvZPKvHvdXaj/AdnOvcKbiM9GKJ7Lu+ghjb49HuBIA
YDmfEJMzRlS4P8a99Ap6vwunZmVbCm6woy8QxRPaJgkV6zlLNjkAjIr6n0XYO1oQ
CWNUtWS5n1keNSSgbiN5Iw8TIhk/L3fgpbSlhDpD2FApSwGMTW9CVED5t0rKPYoT
3Kf3nlCCpNFMVl9qN14dvh91YTIFcE/tRVnLSD0x5We17Rhk9IeZ7x/XdDmabiIZ
ipKf3ATEhiHpQP/6+LtyLz0Q8ja5BdG7PwSBFw0ujcR++jHZEGwWVXF1fLiHdGIM
v3wpHpw8hXS9rYAuIouygpLLCt4aWdjBZvydrHW7PTxZ1XE3IwXgz8WVyuWwrVAr
k4P28T+Jfnb/DhizeAV6vCqDcSM5kpu6yUvnsVWUdPzpEXOjAlg=
=/evo
-----END PGP SIGNATURE-----

--edyErQADgdVVtTMU--
