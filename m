Received: from fhigh2-smtp.messagingengine.com (fhigh2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A7421B947
	for <git@vger.kernel.org>; Tue, 18 Jun 2024 05:16:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718687810; cv=none; b=OkjDgjIkrS/o0ManyASjoRS8URP9EgCfV84fM47GBoOCxmc9QiR+xJkNkOT5N7POCErrycJVtyfj494MDBSzdi0yopsjsbv5SeCrV63DneW8ufCLfOleuKKE0OTsKc3DpJoI/K6J5HDtOPkXa7NZRHfSq5wgHZtlOpTnUqBDXLs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718687810; c=relaxed/simple;
	bh=zW9amFJXrU8iVQqKhRuSIiod+ZeETVC6XWmIT3f6sCc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dxTY4xuibvAKP/qR3J/GaHxYKz4Gw8/EiIrgsFtO8LpNn5CFVCbLWa8HoNw0UpjHo3hTdiyf74IpaLc928h7gx31mKMG/s0yIRR2RXkMyGNlxQ3jL3siVHZ2sLvDkzXy0B8JFKiCMEOn6EYqTMm5upK/aXImdstIM6j7OIuFSx0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=fDquFuOQ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=hDKw1Dmf; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="fDquFuOQ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="hDKw1Dmf"
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 17F4E11402E8;
	Tue, 18 Jun 2024 01:16:47 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Tue, 18 Jun 2024 01:16:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1718687807; x=1718774207; bh=ZgMxfoS+co
	3eYk8UfLawZbJTskl411My3TQx96wwNWc=; b=fDquFuOQkSpCHQaNpl2Q9vzo9K
	GK5CnOyCKlSairQH+C0mhIIK4Pkz9/INOSCq6DJfVwJbnd30OJ9KY6FIAZJiRHZf
	WPUPYWJf8/q0VKcurCT5Yv6delBR7B2IEctXEJEANs3WfaLOb0DyQdg9fHe25XMd
	O0OHnGZIvIDghQvRJAK4pF7/bXYEjcNO3zN5DphuqyB6mMhmwPmTGoRZ/U+GqZEf
	/QIpx8B/4xT91ksJR7DjbGc0hz97Edj5On8tUH8+N1ZWXrjxUgmq0i6tpoc60YWi
	H73kelRSk6zqtON174Eyf30wBrB4eP+I9MGjk1+Br+99j1343Xf8PDUVYL/A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1718687807; x=1718774207; bh=ZgMxfoS+co3eYk8UfLawZbJTskl4
	11My3TQx96wwNWc=; b=hDKw1DmfZH03TwK0REU5C+/srE+CPREkwUv7ozWBSJ6+
	/EOzDseKKPcXKUCsRhiVXP6RG4u1k1C04/nNWR/sxoJl0iVE0YxvQ0PmgVNaQXqM
	dT1gVSw8JjDFVnv2d4q6xrbd8vF9TkL1dVF64ja38MvGQRJD9ilRyeTUcHbgaibw
	QKWhtMLyTb9j3ikyvYb2NIHspniGR4h8gL24iIneohwBjY2yFZ0Kj2nGijVoRXZT
	ZuUVtuTcKBpQwlrWbKFg5KzBIA5XQQ5OjZdt7jLtazy3BBWsxcH0xcp258NEteUK
	+pipMgmvL1fYCLB/GQwORNbnKZUDRKCJM091zFfYKg==
X-ME-Sender: <xms:PhhxZijuSzAXmxLUslWm4FdYrDDmpQC_b2dVXrw4TOvZygs-gZzDQg>
    <xme:PhhxZjBzIk2M_a5v8MCRK4PVTePH--0QWBHxxsCq7Y9W7JmvQPVargFGAKdb3nVNB
    R7T8j0xhWgRiCAciQ>
X-ME-Received: <xmr:PhhxZqGDyJLaG0Ni3nEYflyy2Q63YNwzcHYZk-FrrlIFAzDNEk77jopm85eETxhKvjOY5OyVx2hUXJTREEEbPQRHEgtyHAhI91vFup2ip1302Kbc>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrfedviedgleehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepueektdevtdffveeljeetgfehheeigeekleduvdeffeeghefgledttdehjeelffet
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimh
X-ME-Proxy: <xmx:PhhxZrQd8uDV38Dn4wPQZ2rJjTQPxrcc8bvJu3ozw7IrrOgSBjuqww>
    <xmx:PhhxZvwh-gPmM-ksZiLkgyiMZ5G5Nefx_i69Wcg9Q2ImXiHltRxyWw>
    <xmx:PhhxZp58P8lN9MBFFSPcvQ7G3a4CUQHF6FfwQQTzm-lGxGxD6bDa7Q>
    <xmx:PhhxZsyUQxLkzuPkEnF-7_lYY7rwvsKuug7OkL68HFwHIGWxyb0AKg>
    <xmx:PxhxZmktsXBLJUDs-L98M4qzBHwZqo4eZeSHsokMEE0U8EWJ1MQEoCK9>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 18 Jun 2024 01:16:44 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id 1d86e073 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 18 Jun 2024 05:16:34 +0000 (UTC)
Date: Tue, 18 Jun 2024 07:16:39 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Karthik Nayak <karthik.188@gmail.com>
Cc: git@vger.kernel.org, Ghanshyam Thakkar <shyamthakkar001@gmail.com>,
	"brian m. carlson" <sandals@crustytoothpaste.net>,
	Phillip Wood <phillip.wood123@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 09/20] global: introduce `USE_THE_REPOSITORY_VARIABLE`
 macro
Message-ID: <ZnEYNzLue3OIK-Ul@framework>
References: <cover.1718106284.git.ps@pks.im>
 <cover.1718347699.git.ps@pks.im>
 <7e023a335f500658b09a0037aee48eff06c668f8.1718347699.git.ps@pks.im>
 <CAOLa=ZTq+sQAtSiQm9xmdLyn=T=u8Ck0oXEBFLnJvH+54O+AHA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="sXAXvYjRbIf6DmEv"
Content-Disposition: inline
In-Reply-To: <CAOLa=ZTq+sQAtSiQm9xmdLyn=T=u8Ck0oXEBFLnJvH+54O+AHA@mail.gmail.com>


--sXAXvYjRbIf6DmEv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 17, 2024 at 05:30:31AM -0400, Karthik Nayak wrote:
> Patrick Steinhardt <ps@pks.im> writes:
> > diff --git a/hash.h b/hash.h
> > index 39a0164be3..cb85d26a2f 100644
> > --- a/hash.h
> > +++ b/hash.h
> > @@ -4,6 +4,8 @@
> >  #include "hash-ll.h"
> >  #include "repository.h"
> >
> > -#define the_hash_algo the_repository->hash_algo
> > +#ifdef USE_THE_REPOSITORY_VARIABLE
> > +# define the_hash_algo the_repository->hash_algo
>=20
> s/# define/#define/

This is in fact intentional. We aren't strictly following this in our
codebase, but when nesting preprocessor macros into ifdefs then we often
indent the inner macros with spaces.

Patrick

--sXAXvYjRbIf6DmEv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmZxGDIACgkQVbJhu7ck
PpSoKhAAonOBr+VtKD3eE6jlqwgCP5GC9eXs9UJSVSxRm1eMXTu78vAQOJIWTh8A
9EY9cvGyZclaR+rgtZjZNtOkyq5qW3qNWDeD3tfY4cZW8yNtPzdRH90ALMiV90eb
O++LAyv+Nrd3ZVVPf7SlrkIVRzbSU6jOcFo5crt0bmyMrdH7v3L362BoLbQXdwrC
K3EQY0czaLEyMpS2OV5k/lS8WRstVggpPkGW7MgAKq5pXNoSCY3b01stv4hDc34k
fDmQXN69Waocd8DzHwi2t5xHCcD/sSmR5WdfFSCtoF0Zkiehe2FwlW45nmWtCm+O
JExDx3PJM8IuM0aUNQzYYuGaMpSsmghl0Xfp1Mmueievo8Z4XOMwaZAZE+ZTkwnr
QQ65+WyqDBk2miLKwIDx41C6rYFaWgJDr2mD4339Zb+kxC66KC2CT+kAYz4TeGIG
ws7wvYNRBt4YQUP+kD7TVOsR/lUVeoNBsmgNAufor5cuUw10QGa/74Fy4g+J7bKg
OqI1LJy3IW+9uf6PVVjHtSIzazdwBOeQkS5mCiindS7dgui27yUCfq1clc/t0beS
MhvXsJQuHxbEoPYGaycVC0+kxowBoIjDzFHI++r/jEOIEjYDk1pRmyXIaF6MVaPA
2E3S28/g6cWvyLmYaxuTpRAgJrhsqmkuBmEU4h7p511gaYDcsUA=
=Rl/H
-----END PGP SIGNATURE-----

--sXAXvYjRbIf6DmEv--
