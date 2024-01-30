Received: from wout1-smtp.messagingengine.com (wout1-smtp.messagingengine.com [64.147.123.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81D795DF1E
	for <git@vger.kernel.org>; Tue, 30 Jan 2024 09:09:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.24
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706605744; cv=none; b=OTV93uPH9mvuMofOZ/ceMLaUM1z2TeKBsNFdXqLJbvQR1cc+4n0M8zOWzE+PaxTBOXa/Im3kamNzE41mpYn0Y1W2SLheqp2gzwChBs6lLC971LTmmbzKoxfoqjBCx9MoN6whqrStZrOqnQZWEtwntYm++PeD05ZcpVBIGrGNAr0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706605744; c=relaxed/simple;
	bh=h/pw1/l5pWreWytYTuj1Ro1yvyza59SqtXgCeaRk7XQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cxtPE1xxhfNjzMUKK4C2E/2CvCnW0YD7QycreZw1y6x7SKCKuvEjU54/p4Wgxl+ZMpp9kWTwFAAT7gw4svRcsFR31vGzfx+4dzsahaRyFT5dgA1mxSALDMyUToWCK46LcPexXrpbqanfMZ9xAtC+pgBspYcvdnE+EMgI6vo9FVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=FMDrAXOs; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=RSDY12/h; arc=none smtp.client-ip=64.147.123.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="FMDrAXOs";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="RSDY12/h"
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
	by mailout.west.internal (Postfix) with ESMTP id E390B3200AAA;
	Tue, 30 Jan 2024 04:08:59 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Tue, 30 Jan 2024 04:09:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1706605739; x=1706692139; bh=h/pw1/l5pW
	reWytYTuj1Ro1yvyza59SqtXgCeaRk7XQ=; b=FMDrAXOsTx7PGCEP8cuorgbUGl
	SwhCPZHykCWwrPDbLJpA65OBVphvqgAUjBHCtASII7o9HjFyHM6RIg//1+C8HOVS
	EzYaTN9XnxFybXcovqQgMbADGFRvSFYRJIyk5Sn8AS7Pyt9Dg6WuRYyiRFswGHlE
	/FfHKBSmNYbDUHxPLaA4dqs14UfGaGYmGxUr+mAjjTTyN2rhg1+85xXcxZD2dLAv
	zOEpHdQOCPzuQs6CyKTGectRmzlPI1m8vOYDmCUQWDdrTWziQ1La6TizUoo7haII
	Q6zNU26y7L4BZW0FGRBv/7qcjyphWUOnlzGo0LAHZiO6nXLb6D3/CzDE5C4A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1706605739; x=1706692139; bh=h/pw1/l5pWreWytYTuj1Ro1yvyza
	59SqtXgCeaRk7XQ=; b=RSDY12/hQhVmFua2z9uGiSlHZVBbSbzr/xsSyqkvElJ4
	YXEeKnm5GhDeaW6JPFT/P+h9j6Ea2WYSGl2ehvO5/dXvOY+V9RJ2zbdlq9G9dPFT
	iVUhtecZJ+wZ9KYwkpvDpYXdxT0xWg1p203B3cbfFMkM7jP4ZXZOMhk6On6oEBmi
	e89iT618t70q6ng1eqkhqjRzcKkslYEutDEcRaXiH5KxRZuecg8rVoDqdA3CAZbp
	Lqxl9Ooj2sqFP22rPbVmP4mU3AFIcGrAiP5IxZ0s/UnbGKmOZZPB4x3dCmpomj+e
	xkAOyKB3OdW5ABm11yeH7mI7RJXtkr0MGuPGyDv3KQ==
X-ME-Sender: <xms:q7y4ZcwwWoftX3aIquGcl3EZVczhQFcnE79GRcgAwjxcIVW4Rm21uw>
    <xme:q7y4ZQQrRNUT35pW3fYxEplLu7SpwT6UZW88gtFvDKfJN4pPiI_PMLJP6vCj_1rAG
    r0OPMR7ZpP1jahWFA>
X-ME-Received: <xmr:q7y4ZeVAvCP6NSGRp3XtXtHB4aADiRTG0USWBeaPO4YIzfKu93AFHD6geeSb3ZAPE23abP3ivSy8U1igc8a66LUjcCRBbImFwcjm7Q1UJFTUIa4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrfedtiecutefuodetggdotefrodftvfcurf
    hrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenogfuuh
    hsphgvtghtffhomhgrihhnucdlgeelmdenucfjughrpeffhffvvefukfhfgggtuggjsehg
    tderredttdejnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpsh
    esphhkshdrihhmqeenucggtffrrghtthgvrhhnpedtfeelvdekleeufeevffejieejfeeh
    ieejkeeftdeljefhteevudfgfeejgfejheenucffohhmrghinhepghhithhhuhgsrdhioh
    enucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshes
    phhkshdrihhm
X-ME-Proxy: <xmx:q7y4ZajLdAfj76MopZ9PTnY0REDJTQAqKXJmBG73faTzR354Mhxm-Q>
    <xmx:q7y4ZeBq18bylTFWRb0QZKaOFOXkHjAn9VOHErsgHL2pkl-fVOuP6Q>
    <xmx:q7y4ZbJdJHuKNrTpOW_vRmayv0kmd9JsN2FaXwtdLpTpRXN5YnMXSA>
    <xmx:q7y4ZV7sKplibmfzBw6riX4w2GKGvnBzTdI0i3wIWtvyLtGv91YO-g>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 30 Jan 2024 04:08:57 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 0f510941 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 30 Jan 2024 09:05:37 +0000 (UTC)
Date: Tue, 30 Jan 2024 10:08:53 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Christian Couder <christian.couder@gmail.com>
Cc: Kaartic Sivaraam <kaartic.sivaraam@gmail.com>,
	git <git@vger.kernel.org>, Taylor Blau <me@ttaylorr.com>,
	Junio C Hamano <gitster@pobox.com>, Victoria Dye <vdye@github.com>
Subject: Re: Git in GSoC 2024
Message-ID: <Zbi8pfvGpYrlZXAu@tanuki>
References: <1de82b27-116a-450e-98c0-52eb65a8f608@gmail.com>
 <CAP8UFD1VAvnkM6afZvtpdXhA4csDBDwMnF9yUzSx_ut-Ypf+eA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="uVz2gc6BX/qmEklP"
Content-Disposition: inline
In-Reply-To: <CAP8UFD1VAvnkM6afZvtpdXhA4csDBDwMnF9yUzSx_ut-Ypf+eA@mail.gmail.com>


--uVz2gc6BX/qmEklP
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 30, 2024 at 09:38:48AM +0100, Christian Couder wrote:
> On Mon, Jan 29, 2024 at 7:16=E2=80=AFPM Kaartic Sivaraam
> <kaartic.sivaraam@gmail.com> wrote:
[snip]
> > The GSoC contributor application deadline is April 2 - 18:00 UTC, so
> > (co-)mentors and org admins are already welcome to volunteer. As usual,
> > we also need project ideas to refresh our idea page from last year
> > (https://git.github.io/SoC-2023-Ideas/). Feel free to share your
> > thoughts and discuss.
>=20
> I am volunteering as both an Org Admin and a mentor too.
>=20
> I am not sure how many tests there are left to be ported to the new
> unit test framework. Patrick told me about porting some reftable unit
> tests to the new unit test framework though. So it might still work as
> a GSoC project.

Yes, the tests in t0032-reftable-unittest.sh should be ported over to
the new unit test framework eventually, and I think that this might be a
good GSoC project indeed.

If there is interest I'd also be happy to draft up some more topics in
the context of refs and the reftable backend. I'm sure there should be
some topics here that would be a good fit for the GSoC project, and I'd
be happy to mentor any such project in this context.

Patrick

--uVz2gc6BX/qmEklP
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmW4vKQACgkQVbJhu7ck
PpRhlg//bZB9og3AuQhAdLYZvVRxczPRio5g2yvRqKsUlRjMTuapz2VFowpLi61p
TtPjT8OeaP5h3f3P+1JuERaKIdnGJbvOjG9X+BCXMgFszIZ3FDQ5M8Fw/BHxI4Jh
b9LyvSfzAjQNdfj9Fi2Rs0CPwL87hachEFbHdWgRDNW9g0MKI5ib0Z/r/P3fvK2k
0vNo9hRsSPvEKMYT0ZrrAE1qWNPy5zu4IXEgrBPibH11xyvu5iZ/PgzbfNaJb1J4
jGzxsM36eCrlzKGLx0kugw609m+6a8E4eVxu5b9QkSG6hGcqqR8DUqNxuZ8wv8nh
Gy4M0gwJsxWviYSsUzFXkZnUjte6h9xDk7GgmjGCTU9vedkqs1+Lt0WIAzGQScdb
dLozSvfsPhTYukI3Sez69yoh7KLVNV9FGfcKcTuekadHmAAZqo1qk+pkdjb6RLck
yEi8fTwTUY0qNI5fhTbbaKUiM1QytlD4KFMfU9+n0/2vkmaZ+60mmWaJNYjOhUP/
sqpmwbjPKis0zYdkMUsQObYFEGH3kGdc2T4zMyBQITywSkTM30ox6TXR6ujO07u8
uAFSKbAVuqPggBjcUFQFjeHxe7u7iE03nGJZDbY8BmQIK83Io406jlaRiq+ggWFO
GfGK/a1746TOGay8StUFIKnuoU9dMrby6zoL+dLgX2tBzdOGfSs=
=7v3P
-----END PGP SIGNATURE-----

--uVz2gc6BX/qmEklP--
