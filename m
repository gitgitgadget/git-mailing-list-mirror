Received: from fhigh4-smtp.messagingengine.com (fhigh4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B3FD1A0722
	for <git@vger.kernel.org>; Thu,  1 Aug 2024 13:37:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722519432; cv=none; b=SGZ4f35pNQs1GZvJK+fg5+dmXsyIYJKLTy49aXdSmQPIKtxEIMxlGZ8NIzMaRwwa2HTgQlv4/LYDllEXUEIj7Ok44Wa81Br7QQw6aN8RPB2CLfu/3lrOkxiT4OEAtVh7/aZAuEUJ86dWO7E5QjKwI3yhnxisGaR6pqdfJ4AwcFc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722519432; c=relaxed/simple;
	bh=XjcdZlfV4W76xSq6gKIdcIXCNv/N/2RuSC9YLqYlIAc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NPVHSS7teSrBphQqYNFt7BTJ9BUA4fhJLtB3pAFhLMpaxj3zriW7QfR0y6ZgNjDtoVtYizjVptc+9EO2zij43pPj6PhrtKnhs20WIvRfHV18XO4YqBwRlVUsZ8/Drpz2QTrCa698GfSPQa+NB8IrYD6gn49m6tyg7BbuRzUXo3Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Tn9CiXVe; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=hdagUjOe; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Tn9CiXVe";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="hdagUjOe"
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id B824B1148174;
	Thu,  1 Aug 2024 09:37:09 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Thu, 01 Aug 2024 09:37:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1722519429; x=1722605829; bh=XjcdZlfV4W
	76xSq6gKIdcIXCNv/N/2RuSC9YLqYlIAc=; b=Tn9CiXVes3ZiGXhF8MJG0jXEiS
	H0+KxAi6KOg/Xn5hNMcLAhL/XBuyylkWKPconcXiDCcKzYNbDbRmiu3eF1RLa/Ys
	L8A23+WPlB0gxz+QdH/FCWch5+OXRap54baNvyqOdPpqLepzPAR0mwkSkFLVaPUU
	7YiNP0Pk5icudrdJ27f2lXyYRm65Et5XSzskf54SziUJmTJxLx//w6p5zJyp4Kb2
	5bX44VmJB9b2OJguXZiNJqre+zt0XOMriqclMuwhbw6PsKBZgwLQXb5ztzGn4gqk
	hUI+t5q/7wdHW6mM7K3MLcXWRUiy38RzmYBAy0r+jDPSqw+bUBaegzxBeDOQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1722519429; x=1722605829; bh=XjcdZlfV4W76xSq6gKIdcIXCNv/N
	/2RuSC9YLqYlIAc=; b=hdagUjOek3k1SL2q5e+gHY5wh+kFjVH0u0LTGTuLFqM9
	OHa8+XjtWuaxsHrATv0qGlgymUNYF/oNdYyGeQWLtVD8DnaSrcNWotqrqbJMu2kS
	hf1oIZqd52mVPfWaYI8af4UXCAQZcyKvT9P9friE/bB0bls5mbMphoCh2IYHSTg3
	x/iNE6KDVItOXyI6C4pC/2h4vbF6tyg1ZF2BXDf25MjLjJ3Fh5TbwsgGD/6yaGSP
	RI+VCG2IzR9j2eC0pyvEq4KHMVQS6s8VxMdqyFwBQceLWF881Z5pwrOMyhW/RxPC
	6yimKLrT3BkJgMDBwRH8VXQW+pw0j7CQGspDUCKv6A==
X-ME-Sender: <xms:hY-rZqE6Y_7zlp_V1X6R2Tb5gsVkX7m7yJ0p5ZLoQD8QCGZMYdK6rw>
    <xme:hY-rZrW4Tmky30XU9Ibk9EJwWy1ktBu489MxFjkpldG3qpkqutjHLbTyO2vXtpeuz
    BpoEE942W_Q6MT10w>
X-ME-Received: <xmr:hY-rZkKbs8RQYwbBLZh_Xz98ksmnHiy9p9Y6LgjgsZpNhMzuTVYaSYildkrin2F5lAj_okqxQMP78wBJ19Y2u67NtxRn5RXdbGvXEZ0MdTMGFSc>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrjeekgdeijecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvvefukfhfgggtuggjsehgtdorredttddvnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeehfefhuedtvedtfeeiteeugefgfeelgeelveehffeukeelfefhieekteevudfhffen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhmpdhnsggprhgtphhtthhopedt
X-ME-Proxy: <xmx:hY-rZkHTsb_GDc5geSgmcaNUDCa11Mpggs0m0WFQ-5nRmH-g5bcgiA>
    <xmx:hY-rZgUds7yB_-0Ocbf5OftjpnQYMJOOW1qmTqD-mKOxEKlPDkfkIA>
    <xmx:hY-rZnN12NsZS9pCd6rpol0it0n-1Q1kFOXYLbodTahlJcbIRI1aOw>
    <xmx:hY-rZn3lUIfKZZb27tqD8MD0vjtcnu0JtfsFDmcws2WsHMBCmp6FKg>
    <xmx:hY-rZjHa295Gc2VTJ0vji4hfRw3eMRGcT7M4EN2zNNS-uO-1FdGC80Fr>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 1 Aug 2024 09:37:07 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id 5b3a69e4 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 1 Aug 2024 13:35:33 +0000 (UTC)
Date: Thu, 1 Aug 2024 15:37:02 +0200
From: Patrick Steinhardt <ps@pks.im>
To: rsbecker@nexbridge.com
Cc: 'Josh Steadmon' <steadmon@google.com>, git@vger.kernel.org,
	=?utf-8?B?J1JlbsOp?= Scharfe' <l.s.r@web.de>,
	'Junio C Hamano' <gitster@pobox.com>,
	'Kyle Lippincott' <spectral@google.com>,
	'Phillip Wood' <phillip.wood@dunelm.org.uk>
Subject: Re: [RFC PATCH 1/3] t: import the clar unit testing framework
Message-ID: <ZquPfiAWgYjIPGRB@tanuki>
References: <cover.1722415748.git.ps@pks.im>
 <b3db953e88ece99b441993c9248223cc0ecc6be8.1722415748.git.ps@pks.im>
 <463oz7j4btei57brq42zlnsydguu74n2n22rhdq7iwjk4y2bei@6r32nghurrmr>
 <00a801dae384$de2780d0$9a768270$@nexbridge.com>
 <ZqtWDtqkXzjz2A8u@tanuki>
 <01c201dae40c$821ab5e0$865021a0$@nexbridge.com>
 <024601dae411$faab2cb0$f0018610$@nexbridge.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="36RY8KdYHlhcSjQb"
Content-Disposition: inline
In-Reply-To: <024601dae411$faab2cb0$f0018610$@nexbridge.com>


--36RY8KdYHlhcSjQb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 01, 2024 at 08:54:36AM -0400, rsbecker@nexbridge.com wrote:
> On Thursday, August 1, 2024 8:15 AM, I wrote:
> >On Thursday, August 1, 2024 5:32 AM, Patrick Steinhardt wrote:
> >>On Wed, Jul 31, 2024 at 04:04:29PM -0400, rsbecker@nexbridge.com wrote:
> >>> On Wednesday, July 31, 2024 2:27 PM, Josh Steadmon wrote:
> >>> >On 2024.07.31 11:04, Patrick Steinhardt wrote:
> >>> >> Import the clar unit testing framework at commit faa8419 (Merge
> >>> >> pull request #93 from clar-test/ethomson/fixtures, 2023-12-14).
> >>> >> The framework will be wired up in subsequent commits.
> >>> >
> >>> >Rather than forking our own copy of clar, could we just add it as a
> >>> submodule
> >>> >instead?
> >>>
> >>> What are the requirements to build/use this?
> >>
> >>In its current form, Python is a dependency due to "generate.py". I
> >mentioned
> >>elsewhere though that I'd be happy to port it to our language of choice.
> >>
> >>Other than that it should only require a C89 compiler.
> >
> >Unfortunately, it needs gcc, but that is just because of its Makefile us=
ing
> cc -Wall
> >(not portable).
>=20
> It looks like clar needs CC=3Dc99 when running generate.py, which is fine=
=2E But
> there is no current way to
> suppress -Wall without hand-modifying clar/test/Makefile. The options like
> that should either be in
> CFLAGS?=3D... instead of CFLAGS=3D... or we could introduce CFLAGS_DBG?=
=3D and put
> -Wall in there - it is
> only for reporting warnings which is done different in the c99 I have.
> Ideally, the CFLAGS should come
> from ./git/config.mak.uname/

As mentioned in another mail, we do not use its Makefile at all. Did you
check whether the version I have proposed here works when running `make
test`?

Patrick

--36RY8KdYHlhcSjQb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmarj3kACgkQVbJhu7ck
PpR+CQ//WH+Iu9GtuiPOZTz514+lZgpZqFz9DpJ+FY4f+uETJU6DUWRMLmfW2YBB
Lb9Xh+9ccRlBS4Bxsr7v1YzDwwhCbl8Hp7kxQtuzi+8x2SskqosMYX51pwYevtTf
wlpkVnTdXDj9PyCsqMMwU12ZkkoxxJYoBwr983DJPnlUbVCxJShl8eKMFGWrF/Ih
R1P391AtjqI+WyAg40L+rKJkLsa5ptO9FQwdAdTI02a7S0uw2JGkgmkgbeXeDsbU
l9KA1jHojZA4aS18T3DAwAEv8VeW3fta8v1cwCJN0KI9tme3JAe70tXZ6a6jj6iX
81MF2sn4mqgQKkR+fliq7rnwuGa/tcYVPO68gfPZr/ztUzqIdFNpNg6/OKVoFboX
XS/4zOjNHC1nqd3+vyQQ3fSz6kpGlDPgaz7A2ANroJV9E7ouXP4TiWfDXAXKZ3Rx
uFL0TDawCpWnO9MLCQDwz/DOgNEz9QGrza1G05qF83Vd48DeP5R8ZdF+3Q5+FOJp
Hz8EyRgV4AjMK4FR55WHR9wRm5F1X9cRR1JYsCvscv4jh55ZFoWHxRNQsxVN1E0v
kCCaQHIZGq6wYZVnlvtvAapu2DckjRo1sRqYTngM7m3oO1UBA6pxVXNwGV1Bl79G
3NiC84cvU4uLdpjzMqgVYSKlPEunTAu1NQeDnYPvvShdBLhkFcg=
=93zZ
-----END PGP SIGNATURE-----

--36RY8KdYHlhcSjQb--
