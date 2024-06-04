Received: from wfout2-smtp.messagingengine.com (wfout2-smtp.messagingengine.com [64.147.123.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B12BB144315
	for <git@vger.kernel.org>; Tue,  4 Jun 2024 07:56:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717487782; cv=none; b=GuPz519/DPWsMWr8Son4lfeqw1nRVNxKa8P9FoS7Xa49ZeAohDlATql13U/Rbm7BUP0zXCeUX3d/kr6v7SCw9KYC6rvVVI7iTlP/lybvpvk3ggS4ckGzAhJZTBx6raHf+lmy9rSlL2kQi+XaoGmJP9jmV6fOmKBJmg5X3CdoHNM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717487782; c=relaxed/simple;
	bh=6YjUohUfQ/kp677TEF9Yf9OxxuNK96Dm1nSiWkAx3sE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=In+XKga8b8fLTvu251jppuxDm2u1lbopwBwf1pX4UOC/DSGRbpSSjhetU0wYaXx89Jpoptsl52EY/l+u3ISqWdA6yspZBHdlNmc7mC25IpRi+9bGDJpw6aGcxCdNmbqQdfoUECsVHjw+TOiSYCr38juyODs0yftVbFQMOJkMk5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Fpz56VLC; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=XCBTWAcE; arc=none smtp.client-ip=64.147.123.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Fpz56VLC";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="XCBTWAcE"
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailfout.west.internal (Postfix) with ESMTP id 59F691C001CB;
	Tue,  4 Jun 2024 03:56:19 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Tue, 04 Jun 2024 03:56:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1717487778; x=1717574178; bh=adz/zz1OBm
	xyImg48MLmjc2CuCYprmiG3d00KOgro5s=; b=Fpz56VLCcDeFCP3cUCJu1lyS6T
	j53nE4We6LtaOEM10dv1b9JF53KpazvedfOyvTJqb7rhubM0fxOHwBBlqAthbm20
	RQzMBLkexV5QgWo0GCyvuu1qQUr3qB2dBeIuIaqmQqe+tro6+DmgWmpOX+DaIv2S
	9f2/krS34zzT4wCJg+YLZhb6dIJ5e9vEnv9+VmRJLuC8axWZ8L7dVltnjUsEwF1B
	fyufmL9ufkvFjl6OiNQ/7Ms7QDSEc6G/9WgpjeLG9B24q55aRO2aBGUz2fbzTnoH
	lVfchqGvPxjCV1mas32wKHORG6OIk3I105/eerg2AIWeiupwOSufph3FykHA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1717487778; x=1717574178; bh=adz/zz1OBmxyImg48MLmjc2CuCYp
	rmiG3d00KOgro5s=; b=XCBTWAcEXrX9g9U9+DaLhrrYeZiGlhxBWq2ypqWp3OOG
	KATiizS05AieC5gdON6FsHnOBKWhlv2JK4LkNLIAyxkLU+RGUi3KrMwwhiXLThCs
	J5CyGaFd/lw+5IQhmTxK1DfUDGvEzjhundl5NHlR3RNKz5bpM2/s8OfT9VIblPwG
	jUBX0EuwKvhdhRFa7pHwQ0EFjMvvg2adWqtg9nQ1A8YKZXt50GLZhPy31Apjj7Tz
	2TRydCSLq2Pb+wWAAg+Aqs4ASt9RXzPVDJar8n+qtqRL1w3QCs9FxDZcjKSGDnnK
	k8SqJWn3wIViK+h+yjdewNJID2MU430vc253Mz3PLQ==
X-ME-Sender: <xms:osheZiw0nDVpl4z0FA4oRIkkfSeSwoQzIdeSV79VgcdmiWXOQgIIng>
    <xme:osheZuTa57LMFvX8QaiqeOhJsKWdKYp6L8ZTkBoFp125omt9aY2B0fMxJjH_hHtAK
    AjzV5aMzbJQNqYTwA>
X-ME-Received: <xmr:osheZkVj8fQ2fqqs_--HK0b6tuPV3NQeZ5jSD6vyzJq0MFVwVUrnyUVtMLEnBzLcpm3nTJJca5RzJag5oPUohS-ftBTVYVGBeTGmkS5S4uxktAmN>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdelfedguddvfecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtuggjsehgtderredttdejnecuhfhrohhmpefrrght
    rhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtth
    gvrhhnpeetueevhffhudefvdegieeuieelgedthfegfedtueevjeejtdfgjeehudejuedt
    udenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpsh
    esphhkshdrihhm
X-ME-Proxy: <xmx:osheZoiudsgi_o3taAm2pakFBZyMXjgjYaTF8vWDbxZ7GfjExZqynQ>
    <xmx:osheZkBE-gyQY64CBZMs_xFhnEKl16HP61CxoOSSjAfney0a8F1e4Q>
    <xmx:osheZpIrx0sE3DnfMw0N6GZIDPCEZjEn2n1AH3qGPCxsSXC3nzll3g>
    <xmx:osheZrBKKG4IAJ4YsuTqJX7Et4FMup3UAlUSTr9pEvsTK_Zriwl58g>
    <xmx:osheZnOxflhzQ6Fc3c47cdXItZ5WrbQO6AJ0sqDa3mkF_5-ggBlwAJzJ>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 4 Jun 2024 03:56:17 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id b1feb0b2 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 4 Jun 2024 07:55:49 +0000 (UTC)
Date: Tue, 4 Jun 2024 09:56:13 +0200
From: Patrick Steinhardt <ps@pks.im>
To: =?utf-8?B?UnViw6lu?= Justo <rjusto@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: [PATCH 0/3] Branches are branches and not heads
Message-ID: <Zl7Ina9Uldi1jyMd@framework>
References: <20240603200539.1473345-1-gitster@pobox.com>
 <511c8bf6-9dea-4bac-9f9b-fd400bbad7b3@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="HI+OH3/qvcn0JApp"
Content-Disposition: inline
In-Reply-To: <511c8bf6-9dea-4bac-9f9b-fd400bbad7b3@gmail.com>


--HI+OH3/qvcn0JApp
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 03, 2024 at 11:32:18PM +0200, Rub=C3=A9n Justo wrote:
> On Mon, Jun 03, 2024 at 01:05:36PM -0700, Junio C Hamano wrote:
> > Back when Git started, we used the word "head" to mean the tip of
> > possibly multiple histories, and that is where the name of the
> > hierarchy .git/refs/heads/ came from.  But these days we call these
> > entities "branches" in human terms, and "head" is still used to refer
> > to the tip of the history each of these branches represent.
> >=20
> > When asking "git ls-remote" or "git show-ref" to limit their output to
> > branches (as opposed to showing any ref), we use "--heads" for
> > historical reasons, but give the option a more human friendly name
> > "--branches", and demote "--heads" to the status of a deprecated
> > synonym.  This would eventually allow us to remove them at the
> > breaking version boundary.
>=20
> All of this sounds like a very sensible step, to me.
>=20
> I've left a couple of nits;  none important.=20

Agreed, I like the direction of this patch series very much. I've got
nothing to add on top of what has already been said.

Thanks!

Patrick

--HI+OH3/qvcn0JApp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmZeyJwACgkQVbJhu7ck
PpTW8g/+O5fZimjpsnbQ4Zwv/jucq7lQtaPi7AoJWonRUR9Vi2/J5RhVG2/aP0f8
GHqOio6DiywBIHYFKLWN/6F2bVine3WULylGwJ6AquntRIllfgm6dtAwYWXvHLGt
S2Z5pFG3jW37wP5A8LDXteN/BgVNqyKAvnT+V4Ynn5FVj0VlWK4YukoBxAU38eus
omY6PGYCp7h4AAWGlCb8vohR6BMnnoVXN8JWVkPrEb5ypO4+JpR3oYq1yFt50dOA
kTeVdmbkMf/dDmHzPjDwjUUpwebUX3lQmCDUlvwPOmf4VWqycvdw54xIfiNq4Zsq
A/bXTCUVLZLCcbYBOkIbuS55eNxCHakobG8QmvNdRxezezl3hAqsLywuBuckj3r6
5I7Mw+57xV2IDbAZw6ao2pSlQRnK/CQAo8QRk443FYtmFMXw4xn6EAGqVu9FGKBP
2D24iaTtZ2NegR3ac9yeLBln4urw531DCu1mI2pFnFr0xsiuI1F9Ood113GgoiXM
+3tx9WYWKONj4DJuA/S1/NSWbPWCfTt569eRt3gH4tpN2vrgecMX5otVnpjwAZrQ
4sNe23N+FpQ6el8Q1kLnac0TQ1H7JDiW6fd5N4QXj0QTpbdJdQoaUXtwkVubANgU
NhCt1Ok1nAb/aEHolPQmmTcFb/z0EYCdEMRhEB/PSJ5yLCUb87Y=
=t3/G
-----END PGP SIGNATURE-----

--HI+OH3/qvcn0JApp--
