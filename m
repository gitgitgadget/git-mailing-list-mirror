Received: from fhigh8-smtp.messagingengine.com (fhigh8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4ED60381C2
	for <git@vger.kernel.org>; Thu,  1 Aug 2024 08:20:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722500408; cv=none; b=N+XfdGHHhPenLFaBAp4oeKAbJMobxZNiRSf7Dxro7EFATsO0yEiBJylNBSZrRyjBBSQHQQJFhY7gBHON7A8jdZKp2AD4xFM3BaJfEbJOrjr0J5m1r/l8vN3FyljoMm4xjeGHF7yGANPJPDwnijmisDRBGEERHkYRBjlD4r6h1TE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722500408; c=relaxed/simple;
	bh=U4C0iGUiUEXWdTvfzeS2th07TUEaFblv7z40cPTD5Mk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jPX2jI13AXjRqMdSKMGdOkiOuwpy3hAWLJ+CbYnCtdzYiNfMrSYaWj6IuibMABnq67Wr+CKe9qbDXXvxCp9hVNljmAmCDQlpMoVtKet62MbSfV3+zQ3XIkKSQE6AXqAVDXT9pmWkFdBWMPgnsFaWVoXvMuKVFZLr0PkXRekHUbc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=jgy0rqCt; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=EWI1w3Zi; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="jgy0rqCt";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="EWI1w3Zi"
Received: from compute8.internal (compute8.nyi.internal [10.202.2.227])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 64DF5114AB9C;
	Thu,  1 Aug 2024 04:20:05 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute8.internal (MEProxy); Thu, 01 Aug 2024 04:20:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1722500405; x=1722586805; bh=H7muKU6xPx
	iiC574MVyXY2tW6nwEw1V6twVarQakp4U=; b=jgy0rqCta6J+7gED8KqLhc6Cwl
	3x8wgGTLzhYYTEz+3JXleSr0WMTkmEECSR2u8yx0ab3/PDlQlFCaWyjefNy1npfs
	UgPJQamyjCIXImrkPFGyqUnjskkufHPJKOPv3J0JnzXjhO+sIppFOwWp7XX60WON
	VC4Wpe0+MHiNYNRjajdVv3GrYkgQVZToxJ7McY7oYC7V5dv/kzVbYZq+pYzYxL66
	62wYW4ALVdiZDiA2tEw+X4270IPC9r5r1PrJa6dZ3YwkeDBbo3AiMI6VutL/p7iB
	AV9e4txgdMrFpdXQOgMJT3P9afMYYDFSszuqqy/ZkkJMjld9xzsXseOXdLVA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1722500405; x=1722586805; bh=H7muKU6xPxiiC574MVyXY2tW6nwE
	w1V6twVarQakp4U=; b=EWI1w3Zin93d/pE13EKYqaAXDVZ9rU0Azylf93gs0JOI
	+DjDUWQ+GjNtumSzju+vCD8w+4X6vxw0x5r2WftGX6f10Y2slEFC2EYdcf5gBDLW
	UGJKnNXnMR/YFCgH0Qq1GYu3MOKDofa7ZNr0AxdUMWkqgqMMnANFv7ZZ82r30dja
	BlSM8SxzbUHwGuwP7FpFKjmSyK6b7ISazYEEi/fgwn4wQ7cuYzp5ckbYhcMUFc1L
	JgwWAA7c37eBKoINmHglFf8zr8WM7mmxgb47Phb9N+eidSW9E6MAQLnWNUPclSJA
	NveUoR+DaB/REqixtO2C2cFIbKWJHqb/ceIRSVMozg==
X-ME-Sender: <xms:NUWrZjRY_YQ8YHJYvVBhPeDpVok19lZ74UepEPxk2th4eel73wEXVw>
    <xme:NUWrZkxiA-0rQmYeyD-o6xP70f8RdeFZDCbasM1RD8yQqRoUypSEKcasN3pHgrxGF
    K88CXK-sHGUUFewqQ>
X-ME-Received: <xmr:NUWrZo16MXLBbH77P1A6rO8EgiV4am-474i-zwCIQlPbOdvbJ9OWG3WddPFcPsS9qqOfQu870XCKOWER2QaDy-aCO-tfvSHKWnEeUGtBiZBOMIo>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrjeekgddtvdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvvefukfhfgggtuggjsehgtderredttdejnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeetueevhffhudefvdegieeuieelgedthfegfedtueevjeejtdfgjeehudejuedtuden
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhmpdhnsggprhgtphhtthhopedt
X-ME-Proxy: <xmx:NUWrZjBIC5hQDLmG0aKz_iuFZg_KJGK4WxWn50CmEhuJnNpWOMH8tw>
    <xmx:NUWrZsigLEhbYezmQrflhJ9i-g4eOoCg-zC_sZjEI2_XSVu01IPDhw>
    <xmx:NUWrZnrBuvw1MsSdxodvTqMcvMXxrspHArKekXyXppGxxUuPoVWJvg>
    <xmx:NUWrZniObQC1uhAmW8tgTQxsZQWSTzApebB5n9q2StJvy_KbmyVzBQ>
    <xmx:NUWrZvv-TzeknhdJREioaO0cFeRqLpJEdcq0h9qfiVK64J-zAXqgwX0p>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 1 Aug 2024 04:20:04 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id ca11dfd2 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 1 Aug 2024 08:18:32 +0000 (UTC)
Date: Thu, 1 Aug 2024 10:20:01 +0200
From: Patrick Steinhardt <ps@pks.im>
To: =?utf-8?B?UnViw6lu?= Justo <rjusto@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 07/23] builtin/submodule--helper: fix various trivial
 memory leaks
Message-ID: <ZqtFMYEGuKRu1amZ@tanuki>
References: <cover.1721995576.git.ps@pks.im>
 <5220c91bda7bc766368c2925499e5d244a03697b.1721995576.git.ps@pks.im>
 <82f4bef1-57d9-4427-8316-5e63b573931d@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="vmNML8P3q3qnHSWU"
Content-Disposition: inline
In-Reply-To: <82f4bef1-57d9-4427-8316-5e63b573931d@gmail.com>


--vmNML8P3q3qnHSWU
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 31, 2024 at 11:52:26PM +0200, Rub=C3=A9n Justo wrote:
> On Fri, Jul 26, 2024 at 02:15:09PM +0200, Patrick Steinhardt wrote:
>=20
> > There are multiple trivial memory leaks in the submodule helper. Fix
> > those.
> >=20
> > Signed-off-by: Patrick Steinhardt <ps@pks.im>
>=20
> Hi Patrick,
>=20
> While working on another series, I fixed some leaks.  But, I haven't
> sent any patches.
>=20
> The series this message belongs to fixes all the leaks that my unsent
> series addresses.  So, I won't bother sending my patches.
>=20
> However, I think we can do better for the second leak solved in this
> patch.  I leave my patch at the end of this message in case you want
> to take a look.

Agreed, your patch looks way neater. I'll massage the patch a bit and
then add it to the series with an "Original-patch-by" trailer.

Patrick

--vmNML8P3q3qnHSWU
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmarRTAACgkQVbJhu7ck
PpQMXQ/5AWLV47RqUGwrW1+bsBqa/XL6h6S9V/oWATN7DG6swPqdS9PNA3OukQdZ
xgBxLaFQyrxi3Dmqq+WivaoRD1pC9vWW2uMgfUea38F0CcZuUVn3sDZziqp0piuO
jQX2O1tW3TD/70ToTw1sHP75EiLMSn+xM/oHpv5FFcd0/WT9yjrWbZGTqg+jrcjf
lM84qkr6JMpHr+UUOpzq1I6SLk/caalryYWZKxaBWBx2+Mu7HpzxAe0BhlG9bYYw
MlZwiPFBIqU18AmVJXFJgGsqmO2iVHoBJ+lc12j1TXV/m+GsSLfyaEq9n5zZp8cI
BfGwS32ldVSEhNZV7B5K0ZSBwBnq6k3q11CKffqio+SZQzLX+JkdHcPI6ghpAqNM
zGYtd121nHztsd6R3SAXF2aSV964zbyZWcntIq+jepf+P5f7N8kiQoDCYxLhlUxg
MwC+G4HIJoRrQCZBVgBq8H+77h+NROyjasUHeDmKjGvZbY0PbYmqt+I+T4a9goYa
Axihq6n3idqkX28SuLP+uQFY5JTVyBqNp5I5CV0iKjRzyTZwL+5irzKWhRmb4eOA
mjrra8OMa5DMQw/NdIwdg9cwy6hI9ukBvl408p4YddInaiJjclMUGM1t5eg95iW2
i1JPKsGSErC2CGC+K/aNUtA2MHb25LAt4n8uLyQz+ublf8I9ws8=
=OVk2
-----END PGP SIGNATURE-----

--vmNML8P3q3qnHSWU--
