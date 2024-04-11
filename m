Received: from fout5-smtp.messagingengine.com (fout5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0620613C3CA
	for <git@vger.kernel.org>; Thu, 11 Apr 2024 09:10:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712826609; cv=none; b=U/yxRxS629fXF8OCGF8pyxQPYcGCZWWV+t2TIrlIkxLjjLnAmgoUag8bH5J6GhsqgeVssvcaI4GRHd2dC7vxPR43zKmaDZVQKIyPJBhsXe6fik9f5h4bM9OwwKcfCDIX5Mkvu0UURNcQd+T9p/qo00DM9bSoimvs39CjhXbR/Pw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712826609; c=relaxed/simple;
	bh=3Fl/Xwd3ydRsKJpbSQyDCPG1S72fW+4gbfuCEz3QEdw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=U98Nx1q1IXH9/78bVh8/Sb/7VEdoXEg0WXQ6nNQaoKhTYgFzb67FtM2GjPu7kZxXEBCOyg2AoNWsjpniCAeqYKvO4dpSkBCkuUOIyusMtsIJkKCU/MBYgiR2WxHODDQbRPTRW4NjCt0DqIcaBuqLCLQ0LH/vAkK2bE8q5uG/RAA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=imZOeWza; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=MXgf5u92; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="imZOeWza";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="MXgf5u92"
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfout.nyi.internal (Postfix) with ESMTP id 04CCB1380158;
	Thu, 11 Apr 2024 05:10:07 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Thu, 11 Apr 2024 05:10:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1712826607; x=1712913007; bh=VNk9eX6SCC
	34Yl2veA58Ou5H/atOotM4dWMXN3mJ40w=; b=imZOeWzab0Eni2Ac5vTmyba6Go
	F/mjbExEcyDajMX7P+w2pT2LsPHSs8BlBJDlJhRH7kPtMoluhzAsroNCNW0IAbll
	vD2PSriSxdKhsn6g9iYMVzPGus4kBQnz78qNdQEP4prrt9eU8qhT9Bwc/cAOXiXZ
	wf4xPwMQfKu9gSG/+6mxYtZrDofWBFaa1gcEA+xZO+JqJrNawBmp+zjV4TPiuzfM
	uoEvJG5x6afsRE2cCxF3z/8IKSnht8+kyGIar5t0MXvDY8EXUMSSqyM3DCC9VFdk
	vtFFhINqft9kFH0ZSaYY5zkNYcd0C12yUG8C1kxzYCAtbvWCDrntbGYBaW3w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1712826607; x=1712913007; bh=VNk9eX6SCC34Yl2veA58Ou5H/atO
	otM4dWMXN3mJ40w=; b=MXgf5u92uMAY897jBbrvQQ119wrv758Sm/PK972xuVCc
	z22hGMEVirj4QyXZhBVYLjUBXpYIS8hEl0LrlXEi7Jiap/+HHSun/yen7VvgywhU
	Ky4/S676xTtFTRYR/bZAV8ixoC/H/2pz9/wZ0h7GTAQYPqe2Q5rlS2TIWWfuqNAk
	63jIE65LtKBK/YytT2iLpQPSl7bMtXK4i7pwnYugRWjqaSXHiqPz4rfSSAgFmged
	sW+RgNHr43VAIJLCYFJ1UwjtOcA00ynWFJqxSJT9DjlVNU1bSTGpj9dCZMmm54v/
	v0nhQiCvrqspGoUcaNT6C7j6zVRC5rONuviBjOqQsQ==
X-ME-Sender: <xms:7qgXZj83zTfNU-_kFngYKd6pHQ-ML3PDQM2XL9053HeatXhukpWMNQ>
    <xme:7qgXZvs7DfoLa4SqioQzS00UxAkP5LT8Oq4oS73EC7B8ckKYSNsG4owWYH_QhFWrg
    7szuTtoZZuZUd8PWw>
X-ME-Received: <xmr:7qgXZhBkSki9x-PITdBN-BWWgqvWNT85lbf1_bo5KVk2P9h913ABUVQMkHCh9DvgBPYUnhVGOx98y6TXD0eyflobV0R0XEpTLaQI7reBl8c9v280>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrudehkedgudefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepueektdevtdffveeljeetgfehheeigeekleduvdeffeeghefgledttdehjeelffet
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimh
X-ME-Proxy: <xmx:7qgXZvdmNgHRIlhD5QEPXrIOIElpH-ckSC6mnTZwH3RS_qEnSgcLhw>
    <xmx:7qgXZoOFo76yPce9JT0AOM9HnQVAYP0ltreFaPyUTSpe74KkTtksRQ>
    <xmx:7qgXZhknPkXY4uZRxgF-Iej5WHfVfxL6Pi7eUSy_98_y78YcGId_YQ>
    <xmx:7qgXZiutQH4gD29GGp34kmTW2uhbH2M7Oxy5bJlMEnEc57rwI6WrJA>
    <xmx:7qgXZve6-dfHs_K1Q_6q6v12VR-msX9vYs7KpYdEIXDWUrwpHxihRVuq>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 11 Apr 2024 05:10:05 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id a1de307b (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 11 Apr 2024 09:09:53 +0000 (UTC)
Date: Thu, 11 Apr 2024 11:10:03 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Han-Wen Nienhuys <hanwenn@gmail.com>,
	Josh Steadmon <steadmon@google.com>,
	Luca Milanesio <luca.milanesio@gmail.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Toon Claes <toon@iotcl.com>, Justin Tobler <jltobler@gmail.com>
Subject: [PATCH v3 02/13] ci: expose distro name in dockerized GitHub jobs
Message-ID: <d076ed9857635bcb29d3ac0717d3b5a3cc8f425c.1712825204.git.ps@pks.im>
References: <cover.1712235356.git.ps@pks.im>
 <cover.1712825204.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="lyqaJ5y6Lh1Uksdc"
Content-Disposition: inline
In-Reply-To: <cover.1712825204.git.ps@pks.im>


--lyqaJ5y6Lh1Uksdc
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


--lyqaJ5y6Lh1Uksdc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmYXqOoACgkQVbJhu7ck
PpS6+Q//WTNvCRwFKHb5lApYjqu3R1UcOkeHQm6Eft4B/ma70cMGOET5Cfb4EFQH
0qrSC3X9phnbT88z/H6cUbH1W6S7K2SDZvJHSH2aBD0ItEbsmb+KT8hqeCPssn5h
qtRPar2MRnq1WWsT9VJCUM0LqpJ5qK/PDPZ+ucoHROYgy8tAkl2kk3NeygE/3bVl
HdpZgbT7tfQkb2b1joZkJxOP1HgMPMhKs9lX312DKXELFCedHvJzcIlSTxbboL6D
HtdHXTsn9sr9VyweWhULXt814Bi71Njah1Gi9Wcyasvd0VkxfY8ycmY9UGzP71tM
9cjrSZOabHx15c+uLsDUV2uklXY6YuF7kIyO1KvCnCZcqB2qV28W7kfBQRmWIqLR
eKVTEiVm42H6NcjAHLNV/o+ywggvGL85HmG3opbnvESlHf+im5In5UDDUcKeKGhL
q3zLtAHjqM2PbSHQ9usbv+s4R//jV9SFftKBSu4Eoj1TVNnXb3w+oqmNntuToAW0
JtbHAXyo3J8a/lX7p9XQm8VgD8iVnJhNHur9oPCBSu5MmocDyCA+8AhoNeX8oyyK
zj5RACPHUSjVAQE8202U4i6u9NSDO6Sg8P+pWLO8BYJCFasfFOJj4FyHer8xev13
dcCaInT8iGb0MtFgExiadZkBsSS5ptE3bmcaGLrdtrQQa8/iO+I=
=7bj+
-----END PGP SIGNATURE-----

--lyqaJ5y6Lh1Uksdc--
