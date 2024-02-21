Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com [66.111.4.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BB293EA9F
	for <git@vger.kernel.org>; Wed, 21 Feb 2024 09:52:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.111.4.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708509160; cv=none; b=JTjaJaxTGlbVvpizyVblzVScUPCsRhDTSeRnTO3jutIfj354p5OVQClKW6qOGT/Hc4Sfxl+8KMkwMubPXcJw5vSFAvnXgjoMTG4xfi3Utzw+2xy24zJS+wXz/BpyC34qAay+6H8ET1fmlZL7PCSZWrkb6YmMQbKm7rIIoJknpzk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708509160; c=relaxed/simple;
	bh=/NM9BEfmS7oBVmmEN9BC2wu6j6F21IyH0X4B5+O5xvY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=puHtK18sHS9NuRVO/VJ9vWOoh9FyhmtO1/JtQE0qh705QzqSxKaq/1Ub31lT5fu4LnaKw2kL6WtGUJSQ/KwlOw62/L6WHHU9asnjzNA6lIMIJvytR5H7UfgJD/o2HZzRra6cgK+b9j4gajgZImSLi4G0UOIbSn85T/Amy4dGNfc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=lSItElIl; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=iPE2FPqe; arc=none smtp.client-ip=66.111.4.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="lSItElIl";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="iPE2FPqe"
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailout.nyi.internal (Postfix) with ESMTP id 4471C5C0064;
	Wed, 21 Feb 2024 04:52:36 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Wed, 21 Feb 2024 04:52:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1708509156; x=1708595556; bh=/NM9BEfmS7
	oBVmmEN9BC2wu6j6F21IyH0X4B5+O5xvY=; b=lSItElIlIKm5mgRiDNd+t5C5AN
	4XdiDzyrYhVQZZvfed8pHOg3Zz+7kAA4XIq8EVhm2l8H8VmTdg/CIkQTow/zaL+S
	LFlJMUtO9tlF8vmf60NspcP9YuAn5BIItPuL3LtH5eKvuYlLc8LtUubbRS58usCc
	2r7ngFNRUpsY4mwjKDSugo8aEH0jeqU818f7cZXv7tAy+panIO7S4KlT+4E+rkNs
	WrO178J85upc5pFRsuNYAAehcUHntA22LvnrIU1ao5NOIiE71kkv5Nb3NXNsfYmS
	7E/uBlR8Jx4tVnsTSavsrMl2R3am2rkyBtlDCm167eeeriSMxj5OZSvQqEog==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1708509156; x=1708595556; bh=/NM9BEfmS7oBVmmEN9BC2wu6j6F2
	1IyH0X4B5+O5xvY=; b=iPE2FPqeEVF/UAL1XpOKs3DSbKEt7SKeLGMdCfPFZxnU
	YXWFyqLJeC+1gfOdWs1r04VzRoP1mOLtYXRcGEYTdQwcpUocLed7wsY7x31NIzyu
	hFZlefwN7YncO1QXcCReaoCuHKwHGeNrY/0eIGzZbm2X+R5iAoEViCK8+lJoUD4u
	WxZzfrB0e/rwbAVxRMcx//vO94ybeJtuzUkIdCbX4GzjK3SucuyqZnHd+h2+UWgK
	Cs8AcCknjgz/ZMWsZ5xQ0whk9MAcELi2D+5pXGDl2yJsj26qnMJaqUj9eeYmAYP6
	QhjUJM2Wv/t/jhwCCjbd1xuPEpGVn5FRgHqu16eYag==
X-ME-Sender: <xms:48fVZRILT7SuK4Al4W5rjKPpg4APJ3RWxSuAWKYBSIt11zy27xusKA>
    <xme:48fVZdL-J-KOox-Uky7Knlc7WvGOmfKxjzbI-rfcI1-9ScCc1nktp1JLqcGRur2vB
    8sAfxFt4r4pr1blMA>
X-ME-Received: <xmr:48fVZZuD8DbKZAAQ3swRhG-7LFAYzt5JtGnu8XUfCFbTfNnO5ddDcA3Lu1suSBhmSVPucO7L4tAu1SbD_4yX59i6zdW9ZahmcVyvUq1lkzD6>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrfedvgddtlecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvvefukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeeukedtvedtffevleejtefgheehieegkeeluddvfeefgeehgfeltddtheejleffteen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhm
X-ME-Proxy: <xmx:5MfVZSa3bHysVDbLa6dVLAUPbtLOaHvBfFTtl7GNy-pIaYm3-yr_BA>
    <xmx:5MfVZYbjIa5omscCUQnLh1R4FWoyMX9oOUuX1aZxs8-ZwTwAcFjbjQ>
    <xmx:5MfVZWDgRgvoP6OjHLkoG8rPjVPLTrvvKwlptT2wHoMw4TrwgTMvrQ>
    <xmx:5MfVZTxBmb0htzMJpHmTkb2YK532lcuONROPzLINABfYFtoquHAiQg>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 21 Feb 2024 04:52:35 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id b1bc7b38 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 21 Feb 2024 09:48:28 +0000 (UTC)
Date: Wed, 21 Feb 2024 10:52:31 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Yasushi SHOJI <yasushi.shoji@gmail.com>
Cc: Git Mailing List <git@vger.kernel.org>
Subject: Re: Segfault: git show-branch --reflog refs/pullreqs/1
Message-ID: <ZdXH39p_Bh0mCsj3@tanuki>
References: <CAELBRWK-bZTV0qx6_34HAgpmYwy+5Zo2E0M+4B6yZJJ3CqweTw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="gTK+MmFEYRuDL+CL"
Content-Disposition: inline
In-Reply-To: <CAELBRWK-bZTV0qx6_34HAgpmYwy+5Zo2E0M+4B6yZJJ3CqweTw@mail.gmail.com>


--gTK+MmFEYRuDL+CL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 21, 2024 at 10:48:25AM +0900, Yasushi SHOJI wrote:
> Hi all,
>=20
> Does anyone see a segfault on `git show-branch --reflog refs/pullreqs/1`?

TIL. I didn't even know that git-show-branch(1) is a thing.

By default, no refs but "HEAD" and refs starting with "refs/heads/*"
have a reflog. Thus, your ref "refs/pullreqs/1" won't have a reflog, and
git-show-branch(1) then happily segfaults when it didn't find a reflog
at all. This is of course a bug that needs fixing.

I'll send a patch in a bit, thanks for your report!

Patrick

--gTK+MmFEYRuDL+CL
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmXVx94ACgkQVbJhu7ck
PpSu+w//UucUoMxfb1B1vtafwnRINhy9v76b6ECV3AE2ZeitvC7aXF59B1FoJEEk
1dzJswqKVb4/FuGI/vAr8BKqKgosYdNVpk1eTj44cdU0cgh4O+EYDfD2ejthVNYm
6H2eMXMykzRCQhlQi1r7VaebTZ1A+w7WUtP/D6karRjXs8dgZ8X4Sg6U4DKOXyna
YhbPUlr0lZV0gmk6OSoEWKD+aphoOpGXcs5x9rvVnH2yQTbbAHIa3fLg0gEHudd4
/dS0pFtmfuf4WFHMI1TmwgT/HVd27qPv2mtrBQIvasg9V5XByxrRKVDgLvuQdElz
wB+Gz0revtJHh3Oyh6Ip5SogooR7Tyz2DWOFJcaC8e0HsWP6sF1lHP3pZa/GSXkf
9F/mRTfkQ6wVvb4L4u/QtAtI6t+I3pUnoTnM9k4HDW2I1STq4dQlXYabXVY8QGLU
9H7HT+2Vs753ZfVtYabwdkyL06H+5ZPZQdocz3V0EgrFzBmxVesEZzOYfZsPeLJQ
FanuYoB+KrH/B0rAPRZ1WEcSvcCt/BqtEA9IRyZvS1E7kUf1qw67alWyZv4j+VR3
pl9sV2DySbNXzHsSL8pAEvgnUMF4aCRUDTESucoWXjh4iR1Xz0lcAiT4Ny1c4yv3
uNzQ4KgK9HJeg7WS/liJMNJh7ySabBx+cZPC0hkNCTms40DYt7I=
=aUDV
-----END PGP SIGNATURE-----

--gTK+MmFEYRuDL+CL--
