Received: from fhigh2-smtp.messagingengine.com (fhigh2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B33040875
	for <git@vger.kernel.org>; Wed, 15 May 2024 06:59:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715756389; cv=none; b=GJe+jnUBejJx1pBxoRBVna++np9r/nW8L2uF1oUuvteX5gWINzFuKf4a4tfPSD5W90bDPggZnIx35uKXq3cVYa63KUnEQCAPpSBuaWVC+fIN+DPHkhZaPGOewwWi8YhYBeVNAhF7JRUZLy72KCaM1SJ09zfpDt4edlcnZWwnqwg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715756389; c=relaxed/simple;
	bh=QnMXKuZyFj1uDEcQhTQiAOs2jJBmYk0YcoSbzLwrrPk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=j/n3s8emze47aqw1EaE8iIoxOOslcsLZVnAXXNlyitQbDkB6RmtnKGzFf7p5uaJkscBhp3XOUjfGUNVH8ws/lrcOuK9ReObaN+KlA5sB04VyyDtIb0c99Br1ndo6cKX1E8A5TdEmxaTy8FLTcjbFISJMOsu417Byqd6nx38MMTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=m4dUyNQE; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=LAzcvCKQ; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="m4dUyNQE";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="LAzcvCKQ"
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id AE2B011400F6;
	Wed, 15 May 2024 02:59:47 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Wed, 15 May 2024 02:59:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1715756387; x=1715842787; bh=QnMXKuZyFj
	1uDEcQhTQiAOs2jJBmYk0YcoSbzLwrrPk=; b=m4dUyNQE1f+y95sVQyhQ/tb0Ep
	NfX/YBgyinFOnpL0EwDMdtO0s86cYLiMbj7xUajHMc4XOo1sn3J2Ys4wRTIVLoVP
	1q+BBns9McKQmtmWx2c1gFg2VurrnR3DiHCHSbwIvnuqAEiNjtzhKGvoGRNsjAqk
	hhskbAOpyYJmQ+ko1ZDesQUJqVkU18fh3J0/BgEiZaqLTahM5mf0+p2v7DxbE6Z1
	TBCPYEFIrUue3b3KzzNl/JpVeNe7ROWDVYc94snRDbXZH5694c3D2PAffvfM+d8m
	IIVMP34p9+E2GGf6+TacFTvZBTlTh3VbAKIwOHM1Y2d3fvQuwJOs1wGB3GGg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1715756387; x=1715842787; bh=QnMXKuZyFj1uDEcQhTQiAOs2jJBm
	Yk0YcoSbzLwrrPk=; b=LAzcvCKQadOksGbIiPenLuDzZcOYh06bQEN7sqgFVbTj
	ZysLNG8rCf4BwWXeUxpi2ZvKpz8d65H4o35pzV0aBX5AWcj2Ag/koG+JnhcQtgRT
	Y1Mt+5SIEpO4XdGOavOzVT5biaNPZ14g+eGfcDXFDeWRR5EZ963cOtTClmwQKVrp
	gvrpva1KVjAlm9CSYlMUput3B9zlEgEfqwlmlLzwYA3UFsKaYs1vm26jCmS55iAB
	Zw7HHEUD9DiQxqoeS+05+nc9lEVGBDz3d0VWphgwYKap6R9uescVk+oGHu0qG4TA
	YDZ/CmD0wuou8XRj1i25gkr16EzRZmvMjYqmXEDaLA==
X-ME-Sender: <xms:Y11EZl2-5RSJiKB5RO_AT1LfGAmMMTZlRr4dU6hnJMJmDVY1V22imw>
    <xme:Y11EZsG3i7oDUnD0yPexXAqjUqEqQpOScSjC0BoUkN6sSZdk3XpQQThwrYYX74DX2
    GaXNKZPhxYj-7WXHQ>
X-ME-Received: <xmr:Y11EZl774K_uK0dsYVMKKO9Rhe5W8f4M2Lc2wpPhOmebtASTI0l1dsg9XUyhF9p5tTQJsNaYA62_SpqoYiHvZU3IlUvCWjFnxF3GlZJwRRQmgO8v>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdegjedguddtlecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrght
    rhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtth
    gvrhhnpeeukedtvedtffevleejtefgheehieegkeeluddvfeefgeehgfeltddtheejleff
    teenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpsh
    esphhkshdrihhm
X-ME-Proxy: <xmx:Y11EZi3nLIidnO1D1jCfvwwwbm_-NMntlcIluy0q0t9oY20J2JokDw>
    <xmx:Y11EZoGgkLLZ7dFYSRWkJA3CJnN4btvNx-PJJDSfAWfYjDgk7WTveg>
    <xmx:Y11EZj_Zmk3i2Eo7Nv1-18KGX5OQxzWThKBNpcwiAaUUR53RFOLSBA>
    <xmx:Y11EZlmrzoSLOGTpkzwUuwe_W46fumOaTO6M4wErUlrOQKPJPKPbuA>
    <xmx:Y11EZj20xgoy2ju3KwiXSOmRcp99Tj3GFUKbK8Fr9Dt96UeZDzO15xse>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 15 May 2024 02:59:46 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id af1b5110 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 15 May 2024 06:59:20 +0000 (UTC)
Date: Wed, 15 May 2024 08:59:40 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Jeff King <peff@peff.net>
Cc: git@vger.kernel.org, Karthik Nayak <karthik.188@gmail.com>,
	Phillip Wood <phillip.wood123@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Justin Tobler <jltobler@gmail.com>,
	Kristoffer Haugsbakk <code@khaugsbakk.name>
Subject: Re: [PATCH v3 07/10] refs: root refs can be symbolic refs
Message-ID: <ZkRdXC9wv6e4KtAe@tanuki>
References: <cover.1714398019.git.ps@pks.im>
 <cover.1714637671.git.ps@pks.im>
 <92a71222e1067ca4ce9ecaaa555d78d0cce0d9d0.1714637671.git.ps@pks.im>
 <20240503181339.GH3631237@coredump.intra.peff.net>
 <ZkQ3EiL1OY10Y2JP@tanuki>
 <ZkQ8mDrBB2eGg8Ns@tanuki>
 <20240515062220.GC110841@coredump.intra.peff.net>
 <ZkRXyH0dX3At3vDm@tanuki>
 <20240515064912.GF110841@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="fo4jB08h071MTP3P"
Content-Disposition: inline
In-Reply-To: <20240515064912.GF110841@coredump.intra.peff.net>


--fo4jB08h071MTP3P
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, May 15, 2024 at 02:49:12AM -0400, Jeff King wrote:
> On Wed, May 15, 2024 at 08:35:52AM +0200, Patrick Steinhardt wrote:
>=20
> > > Yeah, and I'd expect that the more-strict check_refname_format() that=
 I
> > > proposed elsewhere would be in the same boat. The only reason I used =
the
> > > "_syntax()" variant is that it was obviously wrong to do existence
> > > checks there. Once those are gone, then naturally it should be able to
> > > rely on is_root_ref() itself.
> >=20
> > This series hasn't been queued/merged yet, right? Do you plan to reroll
> > it? I think that the changes in there are a good complementary addition
> > to the clarifications in my patch series.
>=20
> Correct, I don't think Junio picked it up. It needed a re-roll anyway,
> so I'd plan to do it on top of your patches, assuming they are on track
> to get merged (and it sounds like there are no real objections).

That feels sensible. The series needs another thorough review and an Ack
by somebody before Junio wants to merge it, but until now I'm not aware
of any objections, yeah. So it should hopefully land soonish.

Patrick

--fo4jB08h071MTP3P
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmZEXVsACgkQVbJhu7ck
PpQ++A//apk1EB6MIVHJvoBPcJQZKIeHrJUiI9PHaYMqtZLrAb9VwF2cNkBrIY+p
I6kduPPgYLQ0tunS4KV08FLf100Qxk+pnhwoP3DCgFTM4O7CkaljFnTSjgVafKRN
AO/TEYNAB2utk/fJwq5HeV6fJSm1OgJYD/VT/5WbV5sVLd1A2Z3mcQ2fh5u28W2Y
QEMhyf9CiYS/qgtnJTpx+rOpRpabPu1Up6om3FCjOTOSW8BRIb+Hr5wSz+L1dNtd
oTGADlt2oBt7dflwidBcZj1+9PvAe0lvZlRW2vMJqVJTAHZlbImzRPoUKXVq0gZQ
flIR2itW4h+7vWRPr61xNmLEW4phL7Dfq6S7HPfHYpz/NdRDnMni7T/qsJpLJoK8
VGE0MeZSuDueoQqJVAvrlua54liF44eNx5KfHjCDFGbeNx4ZhXIBnk7WyysuvXI7
sI3FLb4T+sdRm3s4e4rg56a0IfTMvarl/VD8jv5yNqGxfmkHVie+jl1C37FiSJB4
f5ek6/SzYCBaReLaFVUd8p8J2wT90yz6/B6PiNq+Zn+SElyzSDyUH6Z2OsE+jdBR
i4eZnWBzgVVpqhPH5mGnZsPsU/jj2cIGo93VIJATZo0EFuYB9eG3O8KVws4BcB8E
abuzQHDUL2t9Bmko3rRcgPOiWQVyxoQ4WayFduq8gnuLx1P+CzE=
=arRq
-----END PGP SIGNATURE-----

--fo4jB08h071MTP3P--
