Received: from fout2-smtp.messagingengine.com (fout2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8060718D62C
	for <git@vger.kernel.org>; Tue,  6 Aug 2024 14:14:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722953696; cv=none; b=AotJxBJyx3oQF4QZDHHBYDbN1b2uZWjzh4dyL4KQrJl3o9x48XyhtXxwXbcLWG4mP/BJp8w5sii91S7/busJ4xCHDczBqwdh3DI8WwnXj8GqXG9vzRn9VsCXfSYZq0kBphvSV7VxtaeXeJ02jPNXIDLXDhiHxPW2xRGYFCQDptw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722953696; c=relaxed/simple;
	bh=wsF7PVn00BcSVPCEooOmXCE6B8t4DxEocZZTXcIy290=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IBWTAV8fWWVdyuOtQ+EmqD8JhU9tGj5N5ZgNyz7l9Y/IxsiemHjVz7DDmAo5UZP5mhfgLdcpzrGq/rvXuNduAPnYsBC17b/RI9/E6clIF/RJGVRlhPeaakKoKHUEii9fzCPC+bFiJSmtG+/s38EtoSUtSxs8hA8+1Sd1LmRU4yw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=p/tNlSyY; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=nToBxEX8; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="p/tNlSyY";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="nToBxEX8"
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfout.nyi.internal (Postfix) with ESMTP id 8B28C1382D21;
	Tue,  6 Aug 2024 10:14:53 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Tue, 06 Aug 2024 10:14:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1722953693; x=1723040093; bh=lgOQccew/D
	NitWId2ZO0G3ICO4ojH8B+qPq0aI1j+Oo=; b=p/tNlSyYp1OUf0O1gktm8tIWp7
	594YEFDCIVmmukDPxqLWOvRGe3PKgfT/CkBvr+ZRhi96CPRMpD6H+N/9Fcsz7Kwt
	j045zCjVzyooNXBhbB65ppXF3d7LDF591VNzXfSs6+YUe/FNCCiGGoy13w3Ked9r
	jay7kVU/eldNdGnDRkqHUto6n+atDenoEeCAFuZ4Nf1euSIhza3rIeFGZXh+M5CF
	9nqxPOjSJgeEsw01aaIsHINNh4xqC3g5EQWzmIw2i6kMwtMuXLJenEEmhkK6uBaB
	vk3kUaH8Rtl1OHIPDvWB1Gp6YHN6gRYYs33pwT/mvsIVMhPk4qdyoBNtx8Iw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1722953693; x=1723040093; bh=lgOQccew/DNitWId2ZO0G3ICO4oj
	H8B+qPq0aI1j+Oo=; b=nToBxEX8riQ957rY/Pf5IVIGYCJik/6opTaURDZjywE1
	a67N0IuAyQZjRD9/IkYn2rh+Al/sPXNs8h+aZ9BsExPh7nl/V5U3ynYIaCNFcOoq
	bDfbJj7ezVgsPL4GnCHk4Iyx/sO6QkX6+ZPJp7BPOy99WdKEoNIj1zlK+ScJZYTQ
	no7W5zIzrkQwPyB1uEYXtotTJ8Odksj2sb7ZT6+lkH4dWjBosHgC8M2vt4wqqw27
	7JAiIgOq8P98+vLsjTmlPfizbYmphHTd8YP2wJ+dnHf1Th0c2G/+pOz3ENscf9sn
	wWvHgjEB2RzStrxCHho3YNnk+nDR4N7KRux9y+sm4Q==
X-ME-Sender: <xms:3S-yZv-UcpxW0YjhuBz0zTaek5rybvYzVxyZMcmFpu-zEG4VXS3S4A>
    <xme:3S-yZrumsFM3EgjeqG5zlD29U4g4CWWwPBPst5JDbEUXHehyfSxoTXD5OITKaXCVR
    SF7BacbWD44zfNUcg>
X-ME-Received: <xmr:3S-yZtBXxy32nNTaq2TfTPU4fubtmqISjdmcbZKfHauSL1uU1Ohpx2WoABOUBODTJvtPTH8cB-F-bJlp8HKZom_DH920f1FQ2XvRNhNCIyac>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrkeekgdejgecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvvefukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeeljeetffevheeggeetkeetieduieeiieegieegtdffheegkefhjeehfeekhfevleen
    ucffohhmrghinhepghhithhhuhgsrdgtohhmnecuvehluhhsthgvrhfuihiivgeptdenuc
    frrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohep
    td
X-ME-Proxy: <xmx:3S-yZrevaC87wl1Y0lO6KHLG0xBJ0vPMQi_JVDcnAIwO80a7kvBnEQ>
    <xmx:3S-yZkP_aCh4CtCg5g2xo666d474XZlxg993_mjsIa65hhG0wePgIA>
    <xmx:3S-yZtl9tXaTm9aoBaKveQQSBIkBBqlRlMU5uH8pZNNPkSBVcP_qcw>
    <xmx:3S-yZuscAT9icIROs9s1TW2NIXHZcdB70nKMGCyBEeGvvQhEha5KoQ>
    <xmx:3S-yZljUOzBYnRalso2AQeUoM29HBpw4ROlmAkWaPXl2zzONQuB_tE7w>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 6 Aug 2024 10:14:51 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id e4675967 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 6 Aug 2024 14:14:48 +0000 (UTC)
Date: Tue, 6 Aug 2024 16:14:49 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>,
	Junio C Hamano <gitster@pobox.com>,
	Kyle Lippincott <spectral@google.com>,
	Phillip Wood <phillip.wood@dunelm.org.uk>,
	Josh Steadmon <steadmon@google.com>, rsbecker@nexbridge.com,
	Edward Thomson <ethomson@edwardthomson.com>
Subject: [RFC PATCH v2 4/7] t/clar: fix compatibility with NonStop
Message-ID: <02fb86dfbcb4abb61d12c5f286bd2c3f5e0cdc66.1722952908.git.ps@pks.im>
References: <cover.1722415748.git.ps@pks.im>
 <cover.1722952908.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="bHp7PCc+KOdxrQLw"
Content-Disposition: inline
In-Reply-To: <cover.1722952908.git.ps@pks.im>


--bHp7PCc+KOdxrQLw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

The NonStop platform does not have `mkdtemp()` available, which we rely
on in `build_sandbox_path()`. Fix this issue by using `mktemp()` and
`mkdir()` instead on this platform.

This has been cherry-picked from the upstream pull request at [1].

[1]: https://github.com/clar-test/clar/pull/96

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 t/unit-tests/clar/clar/sandbox.h | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/t/unit-tests/clar/clar/sandbox.h b/t/unit-tests/clar/clar/sand=
box.h
index 7c177f3525..e25057b7c4 100644
--- a/t/unit-tests/clar/clar/sandbox.h
+++ b/t/unit-tests/clar/clar/sandbox.h
@@ -120,6 +120,12 @@ static int build_sandbox_path(void)
 	if (_mktemp(_clar_path) =3D=3D NULL)
 		return -1;
=20
+	if (mkdir(_clar_path, 0700) !=3D 0)
+		return -1;
+#elif defined(__TANDEM)
+	if (mktemp(_clar_path) =3D=3D NULL)
+		return -1;
+
 	if (mkdir(_clar_path, 0700) !=3D 0)
 		return -1;
 #elif defined(_WIN32)
--=20
2.46.0.dirty


--bHp7PCc+KOdxrQLw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmayL9gACgkQVbJhu7ck
PpT6uBAAjHNcMR7Xa45tknpPygtCx/79WWw1oO+S58fmlSGQ46eJXY46Iqw4I2DO
sVqrZAU08J2JyCCJAP/LpobQ7baz16s1Ef3ODrEgFhPhi9gbTY+popKHY/sm94Vz
NL3NUeUnWTOAY02u6JgZdN5Qt0CP0onW/9VIGfV7PTbyCLUbZcR2SsQZiwinqjXZ
jAp7lq3jYiR+Tf0rq8Pp4iPromMuasnCjSeja0D32o68e8W5hZqZ4BsibuFFMlYC
xLNLd41jzTy2P+ilL0ruIwiXRqlxAxDbPCNL/1Tefqh0rifYprF/zt6VZf3RNV6d
gEBE2yz51PAj9d/qw8kF8k65GzMNk+SWzbPF5wjPSvxAan/mqjWtfd/sNWmJpu1B
0fw+7y/n8NbZ7Rhh+og0mipofuu9f0DG/qnhcYHl4PIwp+3YwbieqmczWDw9oFCm
Qc+9URIuzWVoYt3OelIwGPAWUY3nCn3wC7FbBJLsYv/fFR/4TAtpy/FfjlpoifPB
JgXkoN55oNgu2kjEw100xDejp6+42qHqlm4JTkecmypQ/51ljfP8zm6WHiH7qTPR
8hHSyek2tKnRHBA2OtMzruINE0p2HBSZLoT/+VsogWFjUquhD0Y3RMDi86dns3Eg
XC+nXSlNvpSUOGgyoE7EMR/fvEaBYiCe8vGrkb4+g+hm7N3PzDI=
=ZlA8
-----END PGP SIGNATURE-----

--bHp7PCc+KOdxrQLw--
