Received: from wout4-smtp.messagingengine.com (wout4-smtp.messagingengine.com [64.147.123.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27DDF8004A
	for <git@vger.kernel.org>; Tue,  6 Feb 2024 06:03:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707199406; cv=none; b=UN0kETchdY7LNBgzlXaUoYJPdgGdNnxSemcAd9hd+yurKuf+al4a783vw5J8nEMRo+53HTN5uwGHj536z/XjLHnHetk5DfjM22pBrIx3rzXGaHyV/pgLSwfPJ3ZnPtUsemex2+nK71VY0pxbZ/5ZuR7/b9vMGW953s3CfMU8ZGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707199406; c=relaxed/simple;
	bh=2/iaVl+DXqc9cg/LRWMT9wXT9lGeE6ITHWSZvvzGB/4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=h2CwC+T9C5Plnm+e3av6lhlvkq6O0pvgK4QtO1RwdiJi/LvAIJmEGJf+OYFNcX0eexp+w3peACCt49XcalQQRtEi+xqTFQOGwJ3UOb+BIZbkyPZbK0A2q/EC3mBjjkRUgNbGwZHu9omCrwEQynjpqclfaObBZcMpWTM5mOdScVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=YrWQxgRr; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=zGy539cH; arc=none smtp.client-ip=64.147.123.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="YrWQxgRr";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="zGy539cH"
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailout.west.internal (Postfix) with ESMTP id 056D93200A7D;
	Tue,  6 Feb 2024 01:03:23 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Tue, 06 Feb 2024 01:03:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1707199403; x=1707285803; bh=jDYI0q2SOx
	imDNVTxXkEzVELynJJZf+t2GmK+bFGT4k=; b=YrWQxgRrJfDdud72BdNwacYWg9
	P0L6stGauMqlerhJFXDBf1RcT17D5lMd4QUb4NSaxttozWPuBOcDDQO5TnYou732
	+sp6kJSgJMIDcIMd4IRZM4VGlIf5GXq5LkHG4QaI1TH0+ZEItuwdwq5ZN+rVyUui
	Gvwr6XAmNfY3AlcPyclN6Wpdf70nuBX7gwzS5kjdWNNIc7BEdEYqJpPkmHq/rNX9
	rwKzvN8dSESl838JyUKi05hMSZNpGwEohg60iskhxgSqDNk6CylZcJZP9XkWMA6N
	neUwf/ceRgICsqt/0iOx1Lm1rNloyQ7S+1F+RPGlfNsxo2t2wFU5NGUDlPWw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1707199403; x=1707285803; bh=jDYI0q2SOximDNVTxXkEzVELynJJ
	Zf+t2GmK+bFGT4k=; b=zGy539cHY5SCkrPfFls4bFEJIQCFheqUaevdgxhev8nd
	dXaZnoSmwRMxxtFUn5uh7J6SPYbb/Vsdr7INpnd7KhjOf/uS8thL+eSmJWKKHgN/
	Qn692tPQ58jwpkUWXObekVqd4NTBdZn4l4k9cxkltkargES9R0Ux4O5wPu+g4a42
	pRVWKikd3b74++ThffAOSONd79+VrQFjg+076MuWXtGuHFe81qB6KXxLI+jtvIpl
	8K4eaj+QvKhMOLfzECDiMyyR131DRHZJ0tD/2j9W5spq4VkO9oOPEMadu7aXP8AQ
	BV0jYP1j1/Oi4c2Ze4soS57N3Resuznd6ndKEUs0zw==
X-ME-Sender: <xms:q8vBZb5IeLLGEDkhVxW0SRHGJwh-sgdkxSHJJ55l5_M_5PuRLq1qRw>
    <xme:q8vBZQ7JrykCdorYC57qUaC1vdu5Sq5QgC3N0pVFo0Sa222m0Q8ZL4GY5AsfT6y2_
    gWhdKinhufYkVfB8g>
X-ME-Received: <xmr:q8vBZSeHwyLIm8Trw8Y52Kt9XO-Ir9IslJY_0NvuTXxv69xakYni6Duf-QtvQtQchteJZjBwQ4mrMq8IsXgGkS3FbgjFzQEAuzD3_WS7oX13VW93>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrfedvvddgleefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtjeenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepteeuvefhhfdufedvgeeiueeileegtdfhgeeftdeuveejjedtgfejhedujeeutddu
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimh
X-ME-Proxy: <xmx:q8vBZcIBhSdIlAkWAj3jxOAsTa6cg96L1YGC5c_2oa--uCvhjKfgAA>
    <xmx:q8vBZfLPUWpNlYz3vmepxWPEIueDYfxIVGDnpzdc5BduGpjmENYHHg>
    <xmx:q8vBZVySp9UVBWTySoJRxJeKXdVOHWW74Jo3GIZMB9qpZlJ0AwmF0Q>
    <xmx:q8vBZX1ndc-WkuhBv7qtUq-9GNOlsTHgUm8L976mNSSrXwgPMJH0tQ>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 6 Feb 2024 01:03:22 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 8f2b2e4e (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 6 Feb 2024 05:59:51 +0000 (UTC)
Date: Tue, 6 Feb 2024 07:03:18 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Karthik Nayak <karthik.188@gmail.com>
Cc: git@vger.kernel.org, Han-Wen Nienhuys <hanwenn@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 5/8] reftable/record: store "val1" hashes as static
 arrays
Message-ID: <ZcHLpkrIG07U4Ep2@tanuki>
References: <cover.1703063544.git.ps@pks.im>
 <cover.1704262787.git.ps@pks.im>
 <f1d21904892153c74d22e4fc814aedfafcb28f41.1704262787.git.ps@pks.im>
 <CAOLa=ZQk_SocUWkoTgJuKyyGWVU85gtw+=8o1ffgBQmh5dQnqQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="4vOmmLhInOf3xSvA"
Content-Disposition: inline
In-Reply-To: <CAOLa=ZQk_SocUWkoTgJuKyyGWVU85gtw+=8o1ffgBQmh5dQnqQ@mail.gmail.com>


--4vOmmLhInOf3xSvA
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 05, 2024 at 03:39:31AM -0800, Karthik Nayak wrote:
> Patrick Steinhardt <ps@pks.im> writes:
>=20
> > When reading ref records of type "val1", we store its object ID in an
> > allocated array. This results in an additional allocation for every
> > single ref record we read, which is rather inefficient especially when
> > iterating over refs.
> >
> > Refactor the code to instead use an embedded array of `GIT_MAX_RAWSZ`
> > bytes. While this means that `struct ref_record` is bigger now, we
> > typically do not store all refs in an array anyway and instead only
> > handle a limited number of records at the same point in time.
> >
> > Using `git show-ref --quiet` in a repository with ~350k refs this leads
> > to a significant drop in allocations. Before:
> >
> >     HEAP SUMMARY:
> >         in use at exit: 21,098 bytes in 192 blocks
> >       total heap usage: 2,116,683 allocs, 2,116,491 frees, 76,098,060 b=
ytes allocated
> >
> > After:
> >
> >     HEAP SUMMARY:
> >         in use at exit: 21,098 bytes in 192 blocks
> >       total heap usage: 1,419,031 allocs, 1,418,839 frees, 62,145,036 b=
ytes allocated
>=20
> Curious, did you also do perf benchmarking on this?

I didn't back then, but here you go. The following test shows a single
ref matching a specific pattern out of 1 million refs:

    Benchmark 1: show-ref: single matching ref (revision =3D HEAD~)
      Time (mean =C2=B1 =CF=83):     191.1 ms =C2=B1   5.2 ms    [User: 188=
=2E1 ms, System: 2.8 ms]
      Range (min =E2=80=A6 max):   186.2 ms =E2=80=A6 214.5 ms    100 runs

    Benchmark 2: show-ref: single matching ref (revision =3D HEAD)
      Time (mean =C2=B1 =CF=83):     189.7 ms =C2=B1   5.3 ms    [User: 186=
=2E7 ms, System: 2.8 ms]
      Range (min =E2=80=A6 max):   184.1 ms =E2=80=A6 213.4 ms    100 runs

    Summary
      show-ref: single matching ref (revision =3D HEAD) ran
        1.01 =C2=B1 0.04 times faster than show-ref: single matching ref (r=
evision =3D HEAD~)

Not much of a win here, which is probably expected. On glibc the
allocator seems to be really efficient churning out many small blocks of
memory, which is also something I have noticed in other contexts. I do
expect that other platorms might see more significant results.

Patrick

--4vOmmLhInOf3xSvA
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmXBy6YACgkQVbJhu7ck
PpQoERAApsqcCPGNiBpDyAGGbmg6AyGmA5voNOpq7HPpbDVI0dKdGhz3sBTfCQEU
sxFgYcm9zajjT/x9Lepsr2r3QQSAv3tBd2QEUMzYSNoMabnwPlxgk84p+clFog47
FwEMKfK/eekRztx7bP4gdJJJ/qfU8WCWjFfzujfbvKPUmY1Zzt7nKhzQlXE7+L81
OIsoxqAwDKgB5c4dLHdayQJpfqN1uCX2ckh3pKN01DAOYP8+ClLHEjWpzGtcWoeg
SidKiJzv/ynZNrEyEboO7PGjavZRh1LbPmmwjgG1EpdqpfhjH4orjHbkzzTjlJG4
IXIFb+4AiHi3s7ECNn8u6VYbj81a9xllIRY+vRP34FA1Ed2U1Mq7x4CEruvFkclB
+InRQRoMlvg423i74sQ2I9I0SeWmgFbd8mvCt4s98k+p4JNqj1HmzzvKjQN9gsDL
DyTjsTiXNSWGlWMTCkCOdNRaaPeNjupdjUKydNy2sDSX6qHYgkbxHY98TcroOQHB
avkzFcoxxafxHxei24O05q6F3l1kl+CsNrLmu31arwRsNtuMTSN49YDSqOTxq4om
bPYDMtyIEDucX69nfHWXRglo4KF+p0twG6eRS9iqPp5NF2j5z//qk2fwl3NFqIBW
rK5x0nTP6cf/Ws2UQEEz+DxqEmJAQdloTBam4FsmP9rjMbWVtO0=
=m0pA
-----END PGP SIGNATURE-----

--4vOmmLhInOf3xSvA--
