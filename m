Received: from wfhigh5-smtp.messagingengine.com (wfhigh5-smtp.messagingengine.com [64.147.123.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC3AB1487CD
	for <git@vger.kernel.org>; Mon, 13 May 2024 07:53:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715586839; cv=none; b=b1RsAnKsMP8/UUkTWc1R647yUalfI3zmdhn4WIif7XtgQ2a1+1bNxXVNh4TG9L5Cro/qMZJcd7M5qs5qd/55gBtktUUgR9S/9Kd01VtBT/PKXTlnkgIGZ3+b21A4XYjSuMTa5JvDmGsdbrVYtpdDFzPw3b6p5OYoDPvGH1z+pXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715586839; c=relaxed/simple;
	bh=fopM8gA0Fl/ZSBa1W+dFpr5eNFX80fdFviiweNkPAKY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=u54kLmjmYLMKkkMcuyQ6ty/o6i+im9MAIh+sW1IGvY+Sq1HU57t40jgBrQKrYZwjepdcTh3zOkAoNiPt0WdtN0xp0yhJo34wRQNIGBSSEDw3cILpnc3MpINYFzPDBVmdEgKeWL1H/xENRcLPhygTRQ3CNJ27liS7EOxNWOHxnGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=q0b+OVk0; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=MOKzq8QS; arc=none smtp.client-ip=64.147.123.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="q0b+OVk0";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="MOKzq8QS"
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfhigh.west.internal (Postfix) with ESMTP id A427D180012A;
	Mon, 13 May 2024 03:53:56 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Mon, 13 May 2024 03:53:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1715586836; x=1715673236; bh=KA8lZO3KUU
	LUif3VUu20Y6BAmcTgFKUj2dFQV2oLBn0=; b=q0b+OVk04tJJZ3TOkau7qzMN0e
	X6YNEHou9QzgVpzF9+Ww5WP8s/fACiRXFllYgEPZIJgslavJITWMWCy+CtDWc0wI
	G0k1MFIP+1zc65l4/XkQTIoQan0vJ5DgU41Q8ngfIpg19NehMvPxEUzvYcNiw4ho
	DgMuhiAB7JKbLdf8Yoc2gMSdAjibhhjQfON5CsL842xJ3wK8F8hZojLtaAxsc7Sw
	t0SumElHUEXtZaSP1VEAlXLORol+az3LuzXq2gBn2tZQUimyqQMforOARl5M1wgw
	OMwyGYAL3tUsY4pXjLekx1pCrO/O9CbyZMGYatkFcLvKuvT4qFWC/mv44Tow==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1715586836; x=1715673236; bh=KA8lZO3KUULUif3VUu20Y6BAmcTg
	FKUj2dFQV2oLBn0=; b=MOKzq8QS1XYLhRYzTgzpESfERPrA6YICGD0Nbcl/hk/G
	brSlF+C86QDkTWJJihHm+BlNQW7yMx8eHkjCyG46weiC/pd3jP3VvXhD3teIxtPr
	Fv/w/bCf+78XP28knJHaE1exI0eBANzjbi9BEK/oMBBp8xYlvi9po3zScOH65Esa
	SQ2GxWJVjpEfXRgOfmWcsXRis3pbGDcM7scYDZtZruiKenj1waIUz8BDoSBqePaS
	iWp00x9FL+vaUgkFt+5j313nWo4Txk7HC5j+Z4N/v3zpPv8Gm/ttC8AJfK5sp072
	p1qxU7a2MIVxd2QtA8ILIqbB/bJkEdeVC9QRv5mb9w==
X-ME-Sender: <xms:FMdBZqSwl3Gwa6LM0L7RvY30Q1GRVtyXSLIozZh3V0U_2FuIhM_AMQ>
    <xme:FMdBZvypb_2l_fXKCk5X53AQO2hPRfUIXhl7xN8fGIL2llRHnR_-xZnhCSRtIyB1H
    faeQT6qsnvfmebyWg>
X-ME-Received: <xmr:FMdBZn0g9G4IHsMvhQaw-6iSH4qZWIDY8zHn-JhujaUR5o48oL9wVaam7VsyMLJ5_bpx2EedJElZ3HBd4MBAPpsftFKvsCAf5MfwNT2AMBjs1r0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdegfedguddvfecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrght
    rhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtth
    gvrhhnpeeukedtvedtffevleejtefgheehieegkeeluddvfeefgeehgfeltddtheejleff
    teenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpsh
    esphhkshdrihhm
X-ME-Proxy: <xmx:FMdBZmCPQTHD-Vxjn8i47BZZ-VrZNbBgWYlCiEmJxIH5jlwngqHxSg>
    <xmx:FMdBZjgQfogwfrkp_nhaX-Ytr3N5X70I15LFuBAk1hsShyXvzmz9-Q>
    <xmx:FMdBZirUxWRPLmtXIqRdfPj2jXXenPcBB5Ud0nV2LosixKcK1Ea3PA>
    <xmx:FMdBZmijLhoum65Orx3tbcjc5exwMnx3G3DdlCEPXBwg-MCdj1wxAQ>
    <xmx:FMdBZjc3euJhXNsMVP6H3nGyV4p_V4RYkWdF7rgl6k299bT8rD6qTnJd>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 13 May 2024 03:53:55 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id e88a8b42 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 13 May 2024 07:53:36 +0000 (UTC)
Date: Mon, 13 May 2024 09:53:52 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Karthik Nayak <karthik.188@gmail.com>,
	Justin Tobler <jltobler@gmail.com>
Subject: Re: [PATCH v2 04/11] reftable/writer: improve error when passed an
 invalid block size
Message-ID: <ZkHHEG27YA4EhjU1@tanuki>
References: <cover.1714630191.git.ps@pks.im>
 <cover.1715336797.git.ps@pks.im>
 <5e7cbb7b193c578f7c946a5077a79421b0ac57f2.1715336798.git.ps@pks.im>
 <xmqqo79d2wc7.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="fvJTvNOqf5if7kM3"
Content-Disposition: inline
In-Reply-To: <xmqqo79d2wc7.fsf@gitster.g>


--fvJTvNOqf5if7kM3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 10, 2024 at 02:25:28PM -0700, Junio C Hamano wrote:
> Patrick Steinhardt <ps@pks.im> writes:
>=20
> > The reftable format only supports block sizes up to 16MB. When the
> > writer is being passed a value bigger than that it simply calls
> > abort(3P), which isn't all that helpful due to the lack of a proper
> > error message.
> >
> > Improve this by calling `BUG()` instead.
>=20
> As a "git" person, I do not mind this at all.
>=20
> But doesn't the reftable/ library codebase want to avoid things like
> BUG() that are very much tied to our codebase, for the same reason
> as it avoids things like xmalloc(), xcalloc(), and ALLOC_GROW()?
>=20
> We may have crossed the bridge long time ago, though.  We see a
> handful calls to BUG() already inside reftable/ directory.

Exactly. No matter what, once there will be a second user of the
reftable library we will have to figure out a maintainable way to ensure
that the library can be used by other projects, too. And that will
require some larger refactorings anyway.

I think initially, the intent was to have a "system.h" header that
contains a bunch of wrappers that bridge the gap between reftables and
Git. I feel like this abstraction does not make any sense though in its
current form as it is simply being included by the reftable code, which
then uses the Git functions directly.

I think eventually, we will have to adapt this such that the Git
includes do not leak into the reftable code at all. Instead, we should
have a shim "system.c" that carries the Git-specific includes and then
implements a couple of wrapper functions. "system.h" would then only be
carrying function declarations of those wrappers.

That's a larger topic though, and I think that tackling this now would
be premature without any potential users of the reftable library.

Patrick

--fvJTvNOqf5if7kM3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmZBxw8ACgkQVbJhu7ck
PpS2vg/8Dt+XMrhTsHdfb3paF08Zlhi349nu9aC4NgrM081GwZXPpXe9Djb+XONL
aXlRwu1ycHW0PQP/BM65I0UnaZqJOz9bj8fhdnEpGIfe9D50kA5FHmEXyVY6GVCu
hJe9uV4q0qjV0ceBKqIQMFczVhoM6ivwI2JxKtiC6+Lf+pqmCu8yu8TY8bky6Mdo
Jde+Tqm44sX2Xp3+1kxJdCU8TUfaitKKBHoDwGsiohckPY2kyv8O1lMaueMXfd7B
Nq0hnIHynVuR/dYIHWTBNgG8c4kparP7MDWdOM8N8oUlS+2fAOO8zzBZEtSQIGUB
ijygTQPLvTVvh45izFQ4wl4mlFz7HRXtouERJU2/x2TTFtXlo2jGOyXkiKwujJDP
v+uhfToOy51d0BL5NjbVXxDa4ke0nrhvyouHydzEJ5+jsaQi6uZ4lh3c5Hjl+ter
ORZIQRtBjSybrSsHi7TwwWkG3c/IoK5y0igbQqwtXlitydH//xHIiKKw75LG7r78
z1y1c0R836D4yMNUHf72jtr2VK+Bj7WhNs0YpsBMmAM+BLJVZeg49V3xVdxQ0Dua
gNuK8+uqYtMCa9d8ItsYc6k6G5oYn+4Z8KEzAyzsDwBobF7zffAOMxcUo4fhKgKS
NoyOLJ1ysADoGct2Kyvw404CQQeAH7K31uRBw3Ke+1/wrYaqJ50=
=Tp7e
-----END PGP SIGNATURE-----

--fvJTvNOqf5if7kM3--
