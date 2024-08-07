Received: from fhigh1-smtp.messagingengine.com (fhigh1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0DD71B5821
	for <git@vger.kernel.org>; Wed,  7 Aug 2024 06:40:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723012818; cv=none; b=Vf87ayppXJxzdBSdbsOIEsmmBjBessDdVrXAPQlLn3lu0CO3O1DDB9JcOPrFZLuTjsFuKxxlvHZpNki6YO79QN8aMLFtIlJwXuUD1LnphqIipBw/QkLCF9Bupqiof8rV5oti5Obz+0w5PniPCR3KHVetuiOobWccduUUy0Iy2dQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723012818; c=relaxed/simple;
	bh=wZKROBch2hWwrp3mct6kzWKvD66F1PidesTc7KCtRq8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=vAdJpVINV8VN9zgcj2gJhhCSLtLnvLzp22dHIzyc9YIMx4M+38XTTVsRYxm9cz05A3KllAlL6g+cKhBK4q5bmKT+fi3AXEYqDOD+FMhW+MLMbsZ6va3xFt8O/ktbwPe+2kOk0MrxC1DCofk/MvbC68JGam8RVdF+fl/G7sp2O1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=ENb4p4HV; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=CGUEqvod; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="ENb4p4HV";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="CGUEqvod"
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id C71E1114F5BE;
	Wed,  7 Aug 2024 02:40:15 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Wed, 07 Aug 2024 02:40:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1723012815; x=1723099215; bh=h81DqYHOzg
	qESwNs0aPr36cq3EEdqAka4OIjx5Ds4kw=; b=ENb4p4HVT0RHN9NAP35SG3pjut
	BhZWJzX/BlYWj72sI4bcP10OUZoLeTNC4eHtCCAvAkNJE8+JivOwdTeo0lNjHFHw
	Q7pcGt1UBkFjOyJMsWCChgI8tvG2SUOyM0ZuBWcBV713Gt16CoMWb+YQwbZgBrDY
	KY7ugx8VhfUmRVcT4Q4spLBs3UaInSOtM1jscVaD1+3y8d/wzhxxu5HcKfdHMlZJ
	Io4xPyWIlmYWBIoL6DnbGhUq0roN/KCVnZ7hBJQotVm5TCXIJneABg7QrCXIbY2p
	4PefkCs6b974FcskvpNuD3g385JuAIKu5UGU5or/D9WmkGARzrmsm/zHnD3w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1723012815; x=1723099215; bh=h81DqYHOzgqESwNs0aPr36cq3EEd
	qAka4OIjx5Ds4kw=; b=CGUEqvodTl6e5oV1yudZ1aatqkl9LzJNAKzox2y75f3Q
	OkDqa9ZJc/oSBzNBZGAISeKfSJQUKeTnBhmfkQKz9FLn/4QxeG8EJCn5liBn5Vpj
	hGps9vt48SuTAIAmxGXLS+XY9qNjVgPo4eqpxO+v6NOjAWEBAscBl/4mYMutbugv
	AvHs2C9ERxnZJa7Bk+MykB4quXkVyVDEL5erV5pgj1PdU+g0C17cWwWjO6w3rj3K
	DC0++9ywK2iASKqV48upIyA7u6ZyLlwIryLaaWglhuUgWUWKAjqRvlfPt2RfVQ/o
	r5FuLyNFURtqJO+C61I/7z+WyUKvVHfBxreGNNMWIg==
X-ME-Sender: <xms:zxazZo_h9txgcdNDglGHfC2_is9b30YOWM7Fu4GQ3yBaQlbwImGsCw>
    <xme:zxazZgugjh3lHL4fJREtof2tor5kXgwfdbrxrfUKCupYmJnWeaiEUwPMOSFVPnLwf
    2G9lYOBebeEb6JWpg>
X-ME-Received: <xmr:zxazZuBeCMXjdCqC3Iut7wmqzMckPAFRjwsJwIUDxfDORV7uOqKoxh4js7OTRJQO-jmc8SD_Qb91HeoKCzOun2hOcDkTxbL9viyirzMFG7HLMVKe>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrkeelgdduudegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtjeenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepteeuvefhhfdufedvgeeiueeileegtdfhgeeftdeuveejjedtgfejhedujeeutddu
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimhdpnhgspghrtghpthhtoheptd
X-ME-Proxy: <xmx:zxazZocRMWW4aUOshsUObLtOjpyttYXZBbPbf3AcPdXt9WWbUqytiQ>
    <xmx:zxazZtOEW6KHD0gf6p1wKXc1usLzfOMLcMprSpvWcrJqJLaFruRqlQ>
    <xmx:zxazZim8t0c5AkAtd5t95r0MxSNR4KGqNyL29ovxbn56Cr3oabN0Tg>
    <xmx:zxazZvuEsRLXRC7VAG-GDz7agxNc9StAroCfCFejgyPJvcAyM44IYg>
    <xmx:zxazZuodIut-zRcNiFfZnNMN93Al4jheqz3EvFtTaYKC68M6xqjjxryx>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 7 Aug 2024 02:40:14 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id a30fc051 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 7 Aug 2024 06:40:08 +0000 (UTC)
Date: Wed, 7 Aug 2024 08:40:10 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Eric Sunshine <sunshine@sunshineco.com>
Cc: Jeppe =?utf-8?B?w5hsYW5k?= <joland@gmail.com>, git@vger.kernel.org
Subject: Re: 2.46 submodule breakage
Message-ID: <ZrMWylPWZ8Tm5i45@tanuki>
References: <CA+osTZVApTAMogBDMaPDEVViJHrFT=BOer=Py4fjTvpsifzfKA@mail.gmail.com>
 <CA+osTZX4FBT5za3Nw2Hc=DCNNbFg=xL4b3AhNmN8S2XKb5BXUA@mail.gmail.com>
 <CAPig+cQ05ocHKELovvEhvptAn09DLuitQkdJyFQ=N5qvje-GhQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="J/PVuiUaRARpd7qY"
Content-Disposition: inline
In-Reply-To: <CAPig+cQ05ocHKELovvEhvptAn09DLuitQkdJyFQ=N5qvje-GhQ@mail.gmail.com>


--J/PVuiUaRARpd7qY
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 06, 2024 at 02:26:35PM -0400, Eric Sunshine wrote:
> On Tue, Aug 6, 2024 at 9:21=E2=80=AFAM Jeppe =C3=98land <joland@gmail.com=
> wrote:
> > I did a bunch of testing to narrow down the cause:
> >
> > It is not related to the Windows port - all the testing was done in WSL.
> > It only happens when the clone containing submodules is done with
> > --ref-format=3Dreftable.
> > The commit breaking it is: 129cb1b99d hash: drop (mostly) unused
> > `is_empty_{blob,tree}_sha1()` functions
>=20
> Cc:'ing Patrick, the author of that change.

Thanks for Cc'ing me, and thanks for the report.

I just wanted to say that I couldn't reproduce, but then spotted that
you said that it only happens when using `--ref-format=3Dreftable` during
the git-clone(1) step. And indeed, that causes the following test to
fail:

    test_expect_success 'recursive pull with different non-default ref form=
at' '
        # Set up the initial structure. This is an upstream repository that=
 has
        # a submodule, as well as a downstream clone of the upstream
        # repository.
        git init submodule &&
        test_commit -C submodule submodule-base &&
        git init upstream &&
        test_commit -C upstream upstream-base &&
        git -C upstream submodule add "file://$(pwd)/submodule" &&
        git -C upstream commit -m "upstream submodule" &&
        git clone --ref-format=3Dreftable --recurse-submodules "file://$(pw=
d)/upstream" downstream &&

        # Update the submodule.
        test_commit -C submodule submodule-update &&
        git -C upstream/submodule pull &&
        git -C upstream commit -am "update the submodule" &&

        git -C downstream pull --recurse-submodules
    '

The issue here is that the recursive clone causes a mixture of ref
formats: the parent repository uses the "reftable" backend, whereas the
child repository uses "files". In theory, I think Git should be able to
handle a mixture of ref formats like this, but I'm not surprised that it
actually fails in practice. The question is whether this is sensible, or
whether submodules should use the same ref format as their parent.

So it feels like the commit you have bisected this to only unearths this
issue, but isn't the actual root cause.

I'll investigate further and will try to come up with a patch later this
week.

Patrick

--J/PVuiUaRARpd7qY
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmazFskACgkQVbJhu7ck
PpQfFRAAoPyud4hXRAwA0lkUqfAf9z+D4DgjL4mpc6fBbOXLi4Op7tAthlYlnBTG
irkPY+U+XPCjJasPkXfTGRIGiPcK7vM5LfcPDqMajSCuvpO6tFj5YjgS2HOiVhzw
PjdYg/8TqLbk+9PXH8W9zsxy8Kq6KEk6sVXrgYrbsWXAReNOOps0DA5hkIP8ff8h
vraIxQF/0LOEKkOvrbEPjs1MCX0GVtD/4K44yKoVjGnrIisv5M/1dL0LTjkUQObo
NoFeCblwUcyDq8YBDhNYkM4QNQcB0my+tZkcVTvn1MMoG3EqkgvhuliBVeZK4SzY
MeqTLl8+jjkAanz4ybvGl4Y0XcYGu3B8AOzBXg0HEy28iz59KuFuXZd6m7Qk/VBR
Kc+dRffimVDPOXBSJr2COsU29gPvPdI575rKxYOp4cgAf/lKv9kMr8MZpUxTCIzi
djI7mDeGO2qDQG2kgSaTqGGCi29BwklHb7RC17Al+LrftomDHpFEzWzkjqvuTRF5
/QPVSaMkwvweSEmyqqvLhqyMGmyWcceE/zyh/5ebwYlBVXi/ClsS3hl6KvfBRPxD
HT3/9czASV6XS6jMORIwDkMw+DOsQ1Au2dVj5RJZr2QQ2VrN8/0V5s8p/orcvxn7
FFV43zBQflOlCC3P0RlS2NMaW/Obqj41ekQdJDepuKfhRBHzLZQ=
=7kP9
-----END PGP SIGNATURE-----

--J/PVuiUaRARpd7qY--
