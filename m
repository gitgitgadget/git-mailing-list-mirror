Received: from fhigh5-smtp.messagingengine.com (fhigh5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C2011DFE8
	for <git@vger.kernel.org>; Mon,  5 Aug 2024 09:11:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722849074; cv=none; b=nisbcBUF059b/RI6HjU1pWnCZfznfLM1iI7wkBa1PZ9Ns6uJKaYvnMlk0wi+OAGYU60mkjou/19+ItswpTkMqZjnVLNx3KEirxBNKyZMkPUrMYHEv+9Vkl/FuEkE6fR1ioq0RETdkRvZA5iGTcktt+/sbzEa52Fe1zHZWshOBTQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722849074; c=relaxed/simple;
	bh=jMK3Z7Y9Zp+8/AKj/cUzoPtItt5VjD3olX7zVcB/4JY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RkjQCpht+rl98vJKDyH3wYzb2FZGSziR9PIhQlzgxnyUV9dnUtzN3Wbgpp3E4sFl3nq0EQD5+Eb9i0lQ2wFjpfIjVsEFM4Kb6adBHJjO8qhSI9WWHGMnbnojDMCdZEuAcLY52ET8QgLN3E5eUFkdKyxjx6PX92exg2Th53AUNeo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=cEKijwmC; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Waglvv9e; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="cEKijwmC";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Waglvv9e"
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id AF8421151CAC;
	Mon,  5 Aug 2024 05:11:11 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Mon, 05 Aug 2024 05:11:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1722849071; x=1722935471; bh=EJjW9QlPk8
	lOWizyeGaP8Bunm4aCansVCFdazyCzyY0=; b=cEKijwmCDrFHu1ea+LcOjcbJh6
	2A7x6YtbryXf2siClxvV7gRMdXLyJRZwk2xY3Qc0Qlu+2HhVutaVON3dETppyYDe
	zff8dy3aGHtJYAU7cuKsoKfDGerpYL9sGEhggeFJXYZM3JPm71V1cApcJIeJkfcv
	Zb/1PQEBFQKiE7i+bM5fIMMh79CbFqwjtKlolHFC7mgGCvYQo8B0tk/UL+NuOOtd
	DBXOR1yq++h1jMX3ZLr2SoZHn9104lCOijw1rTbEv09FqQNkuq4gH8QWcKL4T77V
	02MhBFFf7NHIThUAfkTwj8vMgBR6QWRboOEn/VcnBjfNUZlnclI38RsVBM/w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1722849071; x=1722935471; bh=EJjW9QlPk8lOWizyeGaP8Bunm4aC
	ansVCFdazyCzyY0=; b=Waglvv9ezB6MzgRgP7U9u3nydYw6ESc3fUgsmZ/KXKeo
	Ye8mKLhcCF31xBw8sZqdUfAS5m6m8Xhk5++26owUHkHkvr3X0LhdJtbKeDpogogz
	Nh1TppWcRMr6e+NTCKVePzhvyohkWtRowowGkTdGKKNLlTjTUuKq6P+xtNZLwpVA
	kgyps4jLWBlI4ezRMIiT2uippZ3Ho8XSQS4vdaTYDgjcxXfFuFRbN+BdIcUOQc6L
	OjsFyRNW4CL7Mx5md4k+NKhVlGdQFnbXYVx7nK0DvjyPHiCBWD2swSB2KZKjug0E
	h6Tyki445q/VWTwVp1ERU+dLm0sLBYiVRf2sk8BZVA==
X-ME-Sender: <xms:L5ewZu9QdoUAn55Ve_blAwSQEGP1mOIeArAjTRVNou4tB9HJIS1c8A>
    <xme:L5ewZutLYUYdWLb4gGGJZ01sRUuOerg-BK-5mL2Xnb9rIXkLkUME1op8zgfMBdiUq
    8BGHaglg_-tyFZCww>
X-ME-Received: <xmr:L5ewZkDNph8zmz9Dn2sbijwbTJjVFpXwx_WUbCFWiGol-d6ja93VvU7v9pZ4pElceh4zVxzPI8pONoIrNF6kgq7UUI0Ksu2F59izWHxqqAX9TzQmrA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrkeeigddufecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvvefukfhfgggtuggjsehgtderredttdejnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeetueevhffhudefvdegieeuieelgedthfegfedtueevjeejtdfgjeehudejuedtuden
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhmpdhnsggprhgtphhtthhopedt
X-ME-Proxy: <xmx:L5ewZmdQUFJFE60misY-YV3U4NGAYjr_Sgww5K3yb0qZcd6WDkgKvA>
    <xmx:L5ewZjOKpuHld8hsFTnJXRQQjsFYUwynGd-tupzIIF26BgDKbCgqYQ>
    <xmx:L5ewZglG_dVxPcxyfAkh7SWWUyxquYVHn2Hnfpz-AUDyJGT5iREg7A>
    <xmx:L5ewZlt5rHrxyF6qlxRZZ61dWjkiR2F1_Z25QBFa_9GXTkWikBsR2w>
    <xmx:L5ewZsoDG4DEHbxB10X85Ru89NEgy-OYvcBE-Uds-2lAYLHbGr9ZkdA5>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 5 Aug 2024 05:11:10 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id a8403b37 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 5 Aug 2024 09:11:09 +0000 (UTC)
Date: Mon, 5 Aug 2024 11:11:07 +0200
From: Patrick Steinhardt <ps@pks.im>
To: =?utf-8?Q?Jean-No=C3=ABl?= Avila via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,
	=?utf-8?Q?Jean-No=C3=ABl?= Avila <jn.avila@free.fr>
Subject: Re: [PATCH 1/5] doc: git-diff: apply new documentation guidelines
Message-ID: <ZrCXK8AmGSFwyqI4@tanuki>
References: <pull.1769.git.1722801936.gitgitgadget@gmail.com>
 <515ddbf1dceacc0c186e3d31c13e76a5afc6c45f.1722801936.git.gitgitgadget@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="1BbH31vsjCxCx8hy"
Content-Disposition: inline
In-Reply-To: <515ddbf1dceacc0c186e3d31c13e76a5afc6c45f.1722801936.git.gitgitgadget@gmail.com>


--1BbH31vsjCxCx8hy
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Aug 04, 2024 at 08:05:32PM +0000, Jean-No=C3=ABl Avila via GitGitGa=
dget wrote:
> From: =3D?UTF-8?q?Jean-No=3DC3=3DABl=3D20Avila?=3D <jn.avila@free.fr>
>=20

Nit: please provide a summary of what adaptations you made. It would
certainly help the reviewer to learn about the recently-introduced
`[synopsis]` style and why/since when we use backticks and underscores
for formatting.

The same also applies to subsequent commits, providing some pointers
would certainly help an unknowing reviewer such as myself.

> @@ -225,11 +225,12 @@ CONFIGURATION
> =20
>  include::includes/cmd-config-section-all.txt[]
> =20
> +:git-diff: 1
>  include::config/diff.txt[]
> =20
>  SEE ALSO
>  --------
> -diff(1),
> +`diff`(1),

This one looks curious to me. Why is this item formatted differently
than the next three? I would have expected it to be formatted as
something like linkgit:git-diff[1] instead of `diff`(1)`.

Patrick

>  linkgit:git-difftool[1],
>  linkgit:git-log[1],
>  linkgit:gitdiffcore[7],
> --=20
> gitgitgadget
>=20
>=20

--1BbH31vsjCxCx8hy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmawlyoACgkQVbJhu7ck
PpSlxhAAl1uFry8MrdSkrD3JTrye0BhLEhdPALBzfgCna6kxlKlw90gDHd/VcpOP
erKGJKmUPsHWS7eYc0C3ovYn6n0kONz9JCCq9otE6GUxus3FSRoHd/2F25NElntc
06JD+tNcr/j1UXUEXZWkiSQnQsiEfW5ZpZyDDQxgtxgf9YQY5W0vLar+DUIWOwc/
p0cZT9eYikjt39KW0YkCOwjiZLykVWtYnpj1Wd7RhAYYKFxJZioABHTIBtKxjfip
hauBlHXHH629MMv2/xbwbiFCgX/cOoW4d1RqAJqQbUPtdrDCdONIJmkny/iVI+1E
GMHOKJenoF2IbThTfXVdJvAqqyTojMbAoLwSISD/5TAjVhrdeF7j+Mei9ramBuE+
WVkMUM8joWP7/MdBapXZrOm1gW09iUvNZpptbBbwsjWfe+4nV9bZVhFc0ZI6xFtg
L80bUR8qnQJkUCob3DkNjUclYYC1QxaXgJICbMsH3OjeW/3a40R8ck+B2VCrQR0x
iX8ti2AVaMs5S27ru4vkTKktEITdRZenWh9Yr1gv9L1lofEig1lM2uFn+S6XHYTg
3RtuD6JPikVOi4CLUvmk/9/2isua1NNBf/WnngcHSg0aU5Ssrj4TJcJv70BjqfX1
8xOFsDSqRm/XtVEzIrrI/J1CvVkHCU5Z6oYWonpYYu0OvmHyLp4=
=0LY7
-----END PGP SIGNATURE-----

--1BbH31vsjCxCx8hy--
