Received: from fhigh1-smtp.messagingengine.com (fhigh1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D1331C6B4
	for <git@vger.kernel.org>; Wed, 24 Jul 2024 09:01:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721811700; cv=none; b=E8734u25WIc3+j94yR+srCWX+PXKeI9wWykaXifffCaXZw7tXH+GwsDWzwkgA3bMG+2SIgl8iuiBPx6nLCocmrILnFMGqp4k8Gy0nEZ2LBHRxTpDRoZz+TyzZMk3MUcbRWDSKVlHlva21r4FEZvqQShyfy8uWE4XP7DgvmQyDtM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721811700; c=relaxed/simple;
	bh=lb43UvfpEvrF19XMyiYCDsFlfevgPEBS6UXMpa1dz7A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qnxXrMY/qABvMIO2C8Zsos/dun0CmjAjYWD1NOcRj0l8GFbRdHbml55ijjQJQx1NqlKgoaKjFaaDluPEvOYQwTIu5+JyzUqSX7lj68qWseOcBF8lekSFynvMZjfGlKu6lNcBZ7uWkG8v19iVt3vyhfAM0m5zXvq356iOF6U2ZnY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=DcByk9+e; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=uIpHbs2S; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="DcByk9+e";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="uIpHbs2S"
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id E415D11402A2;
	Wed, 24 Jul 2024 05:01:36 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute1.internal (MEProxy); Wed, 24 Jul 2024 05:01:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1721811696; x=1721898096; bh=/JIS/ipYcS
	I6sABXOJf90hnk6QrnN2nqsUhYtucKO2I=; b=DcByk9+e4BnvK5Xq3xKML1R7hs
	qN1NDrwe5Z53NnbS8n7kiRFOXDht4E8JOb27omeHZwZECbjxxFyiBu6m0S+q4Bnu
	HopcyJOEdGH0bVuEOPf7Dl/b85WZDB6B3OgXGtvBdrvJz8c2tsYdPJgsgIWmJbDK
	/jHIJfLEKgL9d36zfGoEi/OqSWbbrpEi0jjSby3lMSqjFQSnRaBwvwa5B5P7yguj
	1YB5oI5a3t9ipBkjQAMxamTJsebJD1cg3S555skArZa0O+po8uv4ye3HtpPNXaJw
	UZ+Jk/qqb9GGT1sr35ancfaa+MfWnwGZ8ypvEyKZ3LKE4lHASC3tqI2/tkKw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1721811696; x=1721898096; bh=/JIS/ipYcSI6sABXOJf90hnk6Qrn
	N2nqsUhYtucKO2I=; b=uIpHbs2Sw5qwkb1Gg8hhmX3LuugcUtcifm4/Cv3IMb5h
	87lN2qm/YD4E2bDfBSKqn6xQBQ209Z9DTePShLws/FKbwTuDEcHRhPm7Rbv9gDgg
	bsFqqWRih6aw/OkYMWiwpOwhyNiWPMiXcCeaPEZVPl0z14Es7NOAaVlJ72HuDqeP
	AMquq/mdxBL/Ka+6VSj9Bzg75+lEoLBF8uOdQkcpn+jhaFsGHia9Mzsbwl9gpEd6
	XsQTM6eawbbOWq+MyJi1Le0rsuelG57tB+NhSN7dMnBDQ0nQYiKHmWZ1uGcYX9/P
	Civj7xOIzJFoVlNe8jz3L41s+rc44MSHpo7I7rRZBA==
X-ME-Sender: <xms:8MKgZldVoOWTKWjmwijNBcvzIH62kM9z6D17yQcuKDc2HxeHisTQZA>
    <xme:8MKgZjOcGjiZVU9lEqARwiIlzH3YT30N5g9--X4eYt742oGdIgkijTvadXRLt7QBn
    fs359KlfmClag2fuA>
X-ME-Received: <xmr:8MKgZuirDvzyvvyGLdl2tCAr7uxk1FrTNoeA3kyjY7MutKt77er7uF_chFaQ7Rl3JZRiv5B5Hdk4DfSOOcesLHWwz-S4f_Z7M9yz5NOntR76I6NK>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddriedugdduudcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvvefukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeefhefhhedtgefghfeghefgudfgtdelfefhheeiteeitefhhfegvdektdefhfduueen
    ucffohhmrghinhepkhgvrhhnvghlrdhorhhgpdhgihhthhhusgdrtghomhenucevlhhush
    htvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhm
    pdhnsggprhgtphhtthhopedt
X-ME-Proxy: <xmx:8MKgZu8NdW97fyhd_f2YiVjcr4Ke0XQ8gXpI6LAcGYXog4plUfpP8g>
    <xmx:8MKgZhtt8_XpsyDMpXGIM4ZHh8Au8xJChs4gJdPo81r2M13qQQ3rDg>
    <xmx:8MKgZtFSduwrkPcabdC2-0WO5gAGlrEFLg8RHxrmmBzcGkdwSro3sQ>
    <xmx:8MKgZoOaEgbfYnTLYFCLZITTTgc_f9WUztVVXe1uMbnAttv7R3zd0A>
    <xmx:8MKgZq7i1ivRLsP3QAB5uUoaNmAbfCJ9zIg31H-YoisJFIX6K9G6jumk>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 24 Jul 2024 05:01:36 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id 1ecd2aaf (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 24 Jul 2024 09:00:19 +0000 (UTC)
Date: Wed, 24 Jul 2024 11:01:32 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 2/3] ci: update Perforce version to r23.2
Message-ID: <ZqDC7O985AUUg3Pd@tanuki>
References: <cover.1721740612.git.ps@pks.im>
 <ee5d836b779087890acdad061ef6995642942479.1721740612.git.ps@pks.im>
 <da9c4d1e-0fce-3bf3-c35b-32704a8a2129@gmx.de>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="pllEGJivZBbgxaSE"
Content-Disposition: inline
In-Reply-To: <da9c4d1e-0fce-3bf3-c35b-32704a8a2129@gmx.de>


--pllEGJivZBbgxaSE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 24, 2024 at 10:39:54AM +0200, Johannes Schindelin wrote:
> Hi Patrick,
>=20
> On Tue, 23 Jul 2024, Patrick Steinhardt wrote:
>=20
> > Update our Perforce version from r21.2 to r23.2. Note that the updated
> > version is not the newest version. Instead, it is the last version where
> > the way that Perforce is being distributed remains the same as in r21.2.
> > Newer releases stopped distributing p4 and p4d executablesas well as the
> > macOS archives directly and would thus require more work.
>=20
> An alternative would be to simply stop installing `p4` in CI. I would
> actually be in favor of that, for multiple reasons:
>=20
> - The pace of reviews and integration of `git-p4` patches has slowed down
>   over the couple of years. For example,
>   https://lore.kernel.org/git/20210510183638.156a6b1d@ado-tr/ has not seen
>   any traction in over three years (most likely because we no longer have
>   any active contributor with a vested interest in `git-p4`), and
>   https://github.com/gitgitgadget/git/pull/1028 and
>   https://github.com/gitgitgadget/git/pull/1070 have not even been
>   submitted to the Git mailing list (most likely because of the hurdles to
>   contribute).
>=20
> - Over the years, it has been made harder and harder to install Perforce
>   in CI. I spent a good deal of time trying to keep the Homebrew taps up
>   to date (which was hard because Perforce kept replacing the archive
>   behind that URL with newer versions, which always broke Homebrew's SHA
>   check until it was adjusted accordingly).
>=20
> - The `git-p4` tests use quite a bit of time and electricity in all those
>   CI builds. Therefore, it seems desirable to me to stop running these
>   tests as part of the CI builds.

I don't think that is a good idea. If we stop installing p4, the result
is that _nobody_ will ever run the tests at all. The tests, and by
extension git-p4 itself, would start to bitrot and we wouldn't notice
any kind of regressions at all anymore.

If we want to consider going down that route, I'd rather say we should
do it all or nothing: either we rip out git-p4 and the tests, or we
leave both of them in. I couldn't care less about git-p4 itself, so I
would not mind ripping it out altogether. But there may be users of this
script out there that do care, so I don't want to make that decision
unilaterally.

Patrick

--pllEGJivZBbgxaSE
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmagwusACgkQVbJhu7ck
PpQLcw/+LX8qfhKt9kSrHy0BNdiecNLvxIUaspl85mGkR3p+ahTfOIf1ZJRUnnde
1KCqAb31n/H45januZOxxOUya1LNWKPFErPTewvW0irdMmxrmHy1dViU0VS2aMmd
IovHhEi4BZXpHKDvxuOGRXDQfMZL5nAAYsI9ct7pLxxV5pL7b73V8/SIwbeFh23z
BX6vTMuaZfDOhHf8oujM7yvUFJyigQ0iYBZIku4xO8KbBFNXG26CcIrGf1efcJ+X
eKG4w/IrIbX2I8lS/iMqvYHH36cVqz760k21E0KHq9QD6M0slhD0UC9+Dj4ygOG1
qHaxFXTdKxbC8/shbyM1aOIf44tpRGDreOsTxN1EW8A1smt/B8mxna2Xj6+J3Qhr
YepaHgBRHb5mN6XwMQ+yYzbZAAVuqZpjVPZEsSkq5ZzrjYvcAkm5U/yx7vSzk/X+
O5bNJd+cmxA/hUZY6mGl6m13nE+nlPg04gD8Rd/dSzEVkxDpuhT8LcdE+k1UWgzd
fMYr+jHj9VpNaQ7Q3mnP+S0pFFecDBWB6JuESgMuuMSTVxUIDS/YTRhBjkLWgFEn
Z3aMlj1E8fdEBjM2J2YsjFehjrq7HHPthq6pu8KcPj+pmtEYads70UI7Cw7B59pk
zgw2ZCKlk/W/IdkgNJ8d5WgmgKb5t1FsHphkMnBnBacQe6z4eCU=
=Z9ea
-----END PGP SIGNATURE-----

--pllEGJivZBbgxaSE--
