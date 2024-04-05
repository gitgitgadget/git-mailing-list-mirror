Received: from wout3-smtp.messagingengine.com (wout3-smtp.messagingengine.com [64.147.123.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09943171665
	for <git@vger.kernel.org>; Fri,  5 Apr 2024 16:44:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712335477; cv=none; b=lLpQ5LtDdK3qr6+ICs5MTMiyZL46qxamRX/PBAy9HzruDDiQDrxp/rENQ0vFdNLCTcS7KTk7dbSPozMkGK2HJtdQOw50vwOspFCBZQKNo6ihqgi1moTOz3f3g/z3Swhk/6b4ncvqSKurfuTJxsyaYJEQON3vwxO0Ixq7Ev9VdB0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712335477; c=relaxed/simple;
	bh=7XlnpZ6E6jSLnXWoDYpb+VjjQufBK2hPRuQHHWJr0o0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=q4FrDbVEr+1icqenj4AzJozeeWNt1OcZBo8FOLu7ZMFOQTUtl7De4QDsG5H+ubsJy6w98WIxTxJs47dpHkKzryL+gT6HvxuUyv5chOoM+SdeS3DBMv8SadBbMq7Kmd01qvD7nb/GTTUdbJZzGIl+WdIOFUN4z/Bylz+DyPtN7j8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=FWbj7f7Q; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=pvZiEndC; arc=none smtp.client-ip=64.147.123.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="FWbj7f7Q";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="pvZiEndC"
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailout.west.internal (Postfix) with ESMTP id 72AE53200A0A;
	Fri,  5 Apr 2024 12:44:33 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Fri, 05 Apr 2024 12:44:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1712335472; x=1712421872; bh=9dJYvZBj4d
	MVeiaMAP8Xey/wyErGr/8GO+W7wC4fV6A=; b=FWbj7f7Qfh+UXCY87DdZo9mGhx
	xxVAbP9+S9dMs5yYqc/FNkmNHgquMyCHmkpCoY7t73mqqgcUu/AijIURO9cgCmP0
	WpSt8u+NicVu3yHbDLfmsRkCXXDEqgcWqO2TxBINwn1OHPB7rj4IDet25u3JmDl1
	EDsO2nkX+4p0f2SsJW2opq8cKfHCdP9bZ61G0qB2JuUQFhbqEgCFFJ48IT9KraX2
	5/cp1xhHLR6296qMfpKaLCFgYwRWMRqSbgsQp0TXlNUpbD4Uq6jtR6UG/4gcrRbl
	abvFoicRpA76M4aRxETlVhuJa7B1yFuejJ00W2Imk+7FsiXN6K4U3/MAbNoQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1712335472; x=1712421872; bh=9dJYvZBj4dMVeiaMAP8Xey/wyErG
	r/8GO+W7wC4fV6A=; b=pvZiEndCIh3DsqOV/wioo2AdJyUBfVhm0sBwlfrN1Chy
	CReW0ZGMSNg3nAyoI78tMch7mvwNAz11GJXL8cwa2+bNoe56UWPL4108ZCrlEAZS
	XpOM+oDu8jnyTZViEl8qYWFH5iXwlgSigwVOJNHvK18ck4C33A1wySYcVr9/T8Uf
	WFAWANoQbbKb4XSu6PNCrj+95luGMzq6tiWuHktTnb5BbWWtK3EDO0mAWX4+SDtG
	PqysxNHEx3urVxaK1onzpaqdpvpUiJ7DI9v7dZbeTEtU/XDzsJpNs7zXcIB7aOYj
	UbyB7kbVTEFT6B1AiGihLZDHUVHsMG0jrsIa+PYATA==
X-ME-Sender: <xms:cCoQZuqZgl1ccFKbHFJqKOxL2-smzVepseZBOnsQfpQUJXrul5STVg>
    <xme:cCoQZsrgkT6H2jfla5xewy_LrtU_r9jjeAeN6_tBLgpoSNVq8sHYr0lAYnmtw_cSF
    _j7TAf0FsXWZQ976Q>
X-ME-Received: <xmr:cCoQZjOKqhHEuk87ieRfqj96t-Pv7CsM003yC7sknm228yrhvAuHEDMfGaFS_Iz2El2XtzjW-r514cVQ0yB4dXiMkjVP8hWhOhEdNfYm435Z8A25Fg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrudegtddguddthecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtuggjsehgtdorredttddvnecuhfhrohhmpefrrght
    rhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtth
    gvrhhnpeehfefhuedtvedtfeeiteeugefgfeelgeelveehffeukeelfefhieekteevudfh
    ffenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpsh
    esphhkshdrihhm
X-ME-Proxy: <xmx:cCoQZt4VrqP6a_p19DU_qOvD2ARssYIQL9Jrc4vudsKe2Gi2rftY_g>
    <xmx:cCoQZt6HsAHCuWMW3gdYbO_JQBr3Wcuk7v3ye2J3SxnrbsxzGrZR1A>
    <xmx:cCoQZtjpyZduG8VXe1Elg3KDx9EiBs3lkyM7xXAxBdvCkM6XN5nA5A>
    <xmx:cCoQZn4yzl79KBWztpQjjBxOHvPllFOeVXh42gdkFFcGr7Q-DHWZTQ>
    <xmx:cCoQZoYxvZTe6dY0KmRJuoykyV2XqQlcX1F8IFFT9rdIUsCbTt6toJJNT3On>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 5 Apr 2024 12:44:31 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id aa9e12d2 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 5 Apr 2024 16:44:24 +0000 (UTC)
Date: Fri, 5 Apr 2024 18:44:26 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Han-Wen Nienhuys <hanwenn@gmail.com>,
	Josh Steadmon <steadmon@google.com>,
	Luca Milanesio <luca.milanesio@gmail.com>,
	JGit Developers list <jgit-dev@eclipse.org>
Subject: Re: [PATCH 11/12] t0610: fix non-portable variable assignment
Message-ID: <ZhAqamxWZNlMKxWJ@ncase>
References: <cover.1712235356.git.ps@pks.im>
 <c2c2747ff57f68ccad8b509af037e1fc4a524fa1.1712235356.git.ps@pks.im>
 <xmqqmsq7yezc.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ZRVL2gX4b/Qgz4XN"
Content-Disposition: inline
In-Reply-To: <xmqqmsq7yezc.fsf@gitster.g>


--ZRVL2gX4b/Qgz4XN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 05, 2024 at 09:02:47AM -0700, Junio C Hamano wrote:
> Patrick Steinhardt <ps@pks.im> writes:
>=20
> >  test_expect_perms () {
> >  	local perms=3D"$1"
> >  	local file=3D"$2"
> > -	local actual=3D$(ls -l "$file") &&
> > +	local actual
> > =20
> > +	actual=3D$(ls -l "$file") &&
>=20
> Isn't this the same as what ebee5580 (parallel-checkout: avoid dash
> local bug in tests, 2021-06-06) fixed?
>=20
> The rule for variable assignment is mishandled when local is
> involved by some shells.
>=20
> 	perms=3D$1
> 	file=3D$2
> 	actual=3D$(ls -l "$file")
>=20
> would be perfectly fine, and should be fine with "local" prefixed on
> these lines, but the last one with local without "" qround $(...)
> incorrectly makes the substitution subject to field splitting.
>=20
> I think the right fix should look rather like this, instead.

Ah, interesting, thanks for the pointer! I'll send v2 of this series
early next week.

Patrick

>  t/t0610-reftable-basics.sh | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>=20
> diff --git i/t/t0610-reftable-basics.sh w/t/t0610-reftable-basics.sh
> index 686781192e..894896933e 100755
> --- i/t/t0610-reftable-basics.sh
> +++ w/t/t0610-reftable-basics.sh
> @@ -81,9 +81,9 @@ test_expect_success 'init: reinitializing reftable with=
 files backend fails' '
>  '
> =20
>  test_expect_perms () {
> -	local perms=3D"$1"
> -	local file=3D"$2"
> -	local actual=3D$(ls -l "$file") &&
> +	local perms=3D"$1" &&
> +	local file=3D"$2" &&
> +	local actual=3D"$(ls -l "$file")" &&
> =20
>  	case "$actual" in
>  	$perms*)
>=20

--ZRVL2gX4b/Qgz4XN
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmYQKmQACgkQVbJhu7ck
PpTXJA/+MBMVgWGd1vboN+8iLVF7qp5moHqbN7SuDZdg6z8rOAmR9tK4d9JffbGd
oFodBkpvgDM71MNHzUVujfUloNA78xVjfQcvOvy8d5SihM6vZf4Abjw3J31K8S6d
oglCTwT6DwJokBwZSy2ptS04zCJzbJulTolyOHQoOitGRWMIoP9WXYtbr+s2hqS7
dY3hJVbofBu4VGP1iio7PeYV9hB2PgUrkbYbLxv7u9IUlwfAeCByb9b2y2alZEo1
fh/J8Sp1N1sbWKKMc8Yc6vnEy3je9goW0mB9gmibq60b/Vkl84A2tOfWLdt1Lq/x
fNx9IyOxouXKWOLAV9StDTKt4tVAzjvCQlaancsEhy0ANsdacID/fyFHiII21c6p
55vPiG0wakJYiJexfzI3DvH6cZW6ncSqA8wBB2CMYOKC/IaIsJ4I//IHxcwAzk2X
5VzHn1v4/vOjuWD1+uNOLj8Szr0o9Ei6qTgfGVHGnKK2PX752EIH3/Rq3q+exIM2
cTp1uWQDaW1KlsfUukgiE6kFlUAcgdSxAWTWiCGIyTJ+9CGK8/oL9SEbbkxdhr+o
uYgnjZvMGhmA6WyzyNAD8hcHKs64WeJ166gbEO+eZ1ugrArC+oUix+X1qNOQjbri
N+xXpUrLOPUYHl7vg4ode6uPHlAFJCPljDDDWyOTbzntWSNanrY=
=dNey
-----END PGP SIGNATURE-----

--ZRVL2gX4b/Qgz4XN--
