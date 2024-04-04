Received: from fout8-smtp.messagingengine.com (fout8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8658A1272D3
	for <git@vger.kernel.org>; Thu,  4 Apr 2024 13:25:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712237115; cv=none; b=l3rr4pr7PKY8nJ3SomnFWz64S/BOcoqHQKp7dDaAtBG0DD+eJVUQdMlb5uqpMSJ5tPO+Odsl3CfKsOY0Qs0vghY17oSobAguCRP4vilkeKe536WW93kcYydTPSqtgSTaZy7MmYovVj10nqQpesf6SJCKUxKMyg/gdI+NYzV4pc0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712237115; c=relaxed/simple;
	bh=Z03zjwgAe0mBxcmxNvS0uXQkQrVUufW07lCgGzi+k1M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nJJbf7mHXQ4A8kFJFHkh9Dt1oEtzcJKHXF7SxceEB+r4YBiiGDj6ujVJP2hX4e5gC2NH01tHcgnoHDcQfsaSV0PSaRrYFnTS6bUK35sVKteGGUK65ELs5X+aNWt9rwu+VCufSt0eCNRY7A6G/Of1XPH7kFS09i4R7tgxkrR25ww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=JoU3JTYk; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=pi2RggEK; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="JoU3JTYk";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="pi2RggEK"
Received: from compute7.internal (compute7.nyi.internal [10.202.2.48])
	by mailfout.nyi.internal (Postfix) with ESMTP id 85E27138017B;
	Thu,  4 Apr 2024 09:25:12 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute7.internal (MEProxy); Thu, 04 Apr 2024 09:25:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1712237112; x=1712323512; bh=lLEpdJNBxS
	lxfK3eYG0nbGCPZQPFeqaQtplwuG/fJ04=; b=JoU3JTYkpearn+8+xG725/S1z5
	Hv1YcFYrv3hHTimyyIUHBdc85vqQTGQDOQRySEBbZXlbvYN6LpNI5nPim5VkWVI5
	Fwld5li89DMlRaK5Nl4UqZ8YsS189UnEd1TsMXJaxNDYATAM6TGSxwiqv326FRaM
	q1/iAlSWzhq/A49q08jBUEXWyEenzfp2g5NM8ud2g0iNQZokdByAz9UWczT/LCcr
	vhpSkXts2cflh4irAs05nQMTxgEQkvaEsak95BaUZf5fUkJbUX1hzaW60AQsSTrU
	0S3wqYyPAAOgjfi1jrDOQP4zUm6jojhURwGvpo6Vpkre+fX0atqdM192kqdw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1712237112; x=1712323512; bh=lLEpdJNBxSlxfK3eYG0nbGCPZQPF
	eqaQtplwuG/fJ04=; b=pi2RggEK67U0wYIg0QWdFTik2vNpyti1qBK5Y1Xoyilf
	NnoULztCuCfqmup8adsTPS0RUi7Kh7kQefcUyrBYb3D4NXlDnbq+dOvy5A70Gra3
	tO2a4R+SWv+S2uqb7at0LXFUOaNfXwHOYBDZ8gix6YywgL/HLFm3HUqlPTxlZOAf
	WGj4qKC12tSYrdmnw3K5JS7qdkGcC5KV+OMOiPvYUY6B7zr1CZFO6aQuYii3YXjF
	q0zA2B1YGdvE4nVMQEZXKWf+rlzDn11hdUYzOOVML7wC62V9H+auGwRYDuYsUUJl
	+0ebifSmFEY/DmZkGe4iBs1EXCGtwR+Gm2s5YMXT5g==
X-ME-Sender: <xms:OKoOZgw0wjJ6bQ8Zk0liiOVmyXOL-4HkkVQMdDl6CHLyNTdhTG7scQ>
    <xme:OKoOZkQNecJUf_UaLKxXtu2Owm3ggHAeQfIX-4k2HAUI7KVDzWLmU6iPYYBsF6rIq
    Uqc_IBP2iZgEUT2pA>
X-ME-Received: <xmr:OKoOZiUWhrnU8bS0jaLMl5g6vkxgNQ3Q2fFEH4oo_lFDb7ZF1uwLwyAVddhvBLMqO9NWo-xOgt2PgpQguJ0IK9Qi3v-nXkRNM3nseA5CQbxsYYAU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrudefkedgieehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepueektdevtdffveeljeetgfehheeigeekleduvdeffeeghefgledttdehjeelffet
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimh
X-ME-Proxy: <xmx:OKoOZugX_DpP9sg0o5izLgY80fpCkVSQ8YXNUOZMPj_6oTy4RnQomA>
    <xmx:OKoOZiBi9BB0xorIUoJbbNDbMDEjdtAazb0rZ0iTxWFRynKP2IMQ3g>
    <xmx:OKoOZvIjnX6iAyRp57EvVOh6giDjPHLY20pUxM76bAB79oCHbg8QFw>
    <xmx:OKoOZpBL6YjUcK66d27WKU_mHyQ2qV44NZWMD6sEVvoejWixSvQFuw>
    <xmx:OKoOZk20lCjI2qPhxwxwtvwrkWQUfkrSbW62TlaPLWPJhhbc4EYtsVd5>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 4 Apr 2024 09:25:11 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id 36d68ca8 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 4 Apr 2024 13:25:07 +0000 (UTC)
Date: Thu, 4 Apr 2024 15:25:09 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Han-Wen Nienhuys <hanwenn@gmail.com>,
	Josh Steadmon <steadmon@google.com>,
	Luca Milanesio <luca.milanesio@gmail.com>,
	JGit Developers list <jgit-dev@eclipse.org>
Subject: [PATCH 02/12] ci: expose distro name in dockerized GitHub jobs
Message-ID: <e3e2b7cd503bc769dbe5667c73b51d4612071440.1712235356.git.ps@pks.im>
References: <cover.1712235356.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="LCT9TMk/BipJYxZc"
Content-Disposition: inline
In-Reply-To: <cover.1712235356.git.ps@pks.im>


--LCT9TMk/BipJYxZc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Expose a distro name in dockerized jobs. This will be used in a
subsequent commit where we merge the installation scripts for dockerized
and non-dockerized jobs.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 .github/workflows/main.yml | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/.github/workflows/main.yml b/.github/workflows/main.yml
index 684ef5c00d..71cd4e5486 100644
--- a/.github/workflows/main.yml
+++ b/.github/workflows/main.yml
@@ -342,12 +342,16 @@ jobs:
         vector:
         - jobname: linux-musl
           image: alpine
+          distro: alpine-latest
         - jobname: linux32
           image: daald/ubuntu32:xenial
+          distro: ubuntu32-16.04
         - jobname: pedantic
           image: fedora
+          distro: fedora-latest
     env:
       jobname: ${{matrix.vector.jobname}}
+      distro: ${{matrix.vector.distro}}
     runs-on: ubuntu-latest
     container: ${{matrix.vector.image}}
     steps:
--=20
2.44.GIT


--LCT9TMk/BipJYxZc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmYOqjQACgkQVbJhu7ck
PpQqlQ/+O2INpwAr1M0bOPq3CjrxfcIoheMpbM/zqAApMdk6cAAON0PLpxiqQUWf
JEHPwCz5/ENKYK3oVcmNlWoK+ZqZvrJ3vOrlVmTReTPjOheU0OLG0jTMWzRXdEfa
txgJx76bbmOpFU/BZxYhyHI8UR17lolNz1ybOfDs62O2W1/WUEM1zPLz68ZDnUqo
ZiPxBfd8y+h24CrazgyvJ5A52FDyt7Lm+w6ff7IJd0HuvjzMeg6fV5WHuRyQovYn
YquGTaH6Ya1nOairTE5l00ATq1S7l/dH6193rscQKqg1AgWD+QVK7Tjo0STKLbdn
yEY0G1Be82X20v2Ca8iu7y3BQaUT+fRkSOXe7GMio25UQWW1+FpspYdA+Qt3RrWg
5o5/qZmTjfk1FJ2uVuerpHGOi9U7M2JJWo6WtNRA8o2gGo+zQRcmANFnPEBpvZsz
rOtaEHE/F0t9L5tqsjIAbQhxKnR5YuqJiNd+KLDq+F3eZkBN8eCt8Ddaek0nRJuh
tol8Aqn0zJb9Y8A4DgF1ZPlEIcGbo0XZ6g4xIk1DqxJlGZLKcI8/uBDOumwY+1jH
J4k96/ZiiDcWUBRXQ+m7lW4dIvyImoAGck7AgOSNJf7vOWrnH9Ri7d7h8OKo/Nhw
+3xYXV/gNiTfn7qEC37YuHmGqdGgEPsvwSpcS2NY4MtX2AAHMNc=
=cxpt
-----END PGP SIGNATURE-----

--LCT9TMk/BipJYxZc--
