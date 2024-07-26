Received: from fhigh1-smtp.messagingengine.com (fhigh1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52A2713A3F7
	for <git@vger.kernel.org>; Fri, 26 Jul 2024 12:17:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721996233; cv=none; b=JF6bS/vayd+AXX2oKIUizU1uoIJ2nBMmeM0mkgh579ToxzXkt5HcaycKVoJLHluiEWVQioDUR9SL81AmuSxuxRHHHlF2/kh15MAZjQi/qxOseCbAEgrbyOC0wb1O0Pe1ZXof+Jp2q9bEgOAHJY/yvSxUnCcERXWFq/wot81Nrz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721996233; c=relaxed/simple;
	bh=y0jbpnxT3zUpcLATAakWVPuz21nDBYhyHHSNUW76sxA=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PUOc3JV78Vn6uRAI6pCb/ZH7+OBKgQsOnD8QFSwWFg0GPHYcbIfRChc34hToqPFiXrL34gKR+V+ED4fkpKITyldnMhuqrwjbJ6Qid1edL+s/XJ4fmoymB8nNKPn+J2KPqw4Sip5r4PZQNpxkse5PeTeLjYKTYngFyDMQq0JV/q8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Oe7P8kew; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=GClJ1fDy; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Oe7P8kew";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="GClJ1fDy"
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 609171140254
	for <git@vger.kernel.org>; Fri, 26 Jul 2024 08:17:11 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Fri, 26 Jul 2024 08:17:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1721996231; x=1722082631; bh=1k1kx29KgK
	Zr6HL5B9zFn4zcX23r0/SWmaYFkUu2VqU=; b=Oe7P8kewiHnGs6gmSXLpHOvnv/
	F3eTt9P2oREo1P/Es1La0ILmzo5NoPCDawM+VlKGY34XB2uCvc/tGevATFN6wxWt
	JkgkymBm9/SlLilKvewjnSwdAD7bRYbMZUhOHVO7e1G2hOcplFSQ92SdPpeUuVDA
	HjGoUKHdYyhsvVHjdRy5tcF+9XUzlDl2+ja9TAib1KaL41XZ1qfIgLZ++1hqhtwL
	VCVut5x8CGaMVe50JpAC4LB3pkEJ85o+M0kZZQqRxzu/uCVkq7j/Wwuv/lbNexHR
	TXHyKWn0atf/QbxqE8w1Apszx/vtzMwERUz+phJEM+IoyFOVj6jv+HLKXuew==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1721996231; x=1722082631; bh=1k1kx29KgKZr6HL5B9zFn4zcX23r
	0/SWmaYFkUu2VqU=; b=GClJ1fDyvO/BAYESMJmFKavrw/mT35og1nHprzIIDZQh
	EPNtuC2Lj2atqiNLBb6Cy3P2QtjU3XHQs81UTt0j0vigV9/PaJZ9G972sPBoEOwn
	oySDiDTgxijgNMGvhkQ/mxwiXE2B+2X9FHFpm4QjnKL6zOhpXn+s/lT7TorHH9O/
	ja4oo137j4y9n/Ruy+3dylvp7erZ2vefVz0PE+Iz6/9Bx9bVn6arnNhKHqpAdOAr
	loPgrKgjf5nWIgujGWtvOLfka8HgemSDGJp6QV9sbPKWcuFR7ysYlwHY4A5p3A/K
	/ePt8zbjfFYylr0WSuHdWHB5ykL5DeVT7RWMHb1yzQ==
X-ME-Sender: <xms:x5OjZnC3lUf5FWyir_FCtsQPjBDAcCr3bzPEeuAzX5I2LzsmwVAkpA>
    <xme:x5OjZtjWw4CzscD2yK2zXz26BV4IKLf0ayzWnYlehzqxVCb7hCD2zD1t85Qvbc4Nj
    6YRjacktcV_LlhtIg>
X-ME-Received: <xmr:x5OjZini6ByW8fxS3Tljww__Y7r0TG4Eob-YjTbAUJ4x7RS4m5ORS9giPSBzQtLypqW-d49AObM6g4GN1lwCvG1gXhWG3Ya0CpIi-8DxUeYR_sCq>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrieehgdehudcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhepfffhvffukfhfgggtuggjsehgtderre
    dttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhk
    shdrihhmqeenucggtffrrghtthgvrhhnpeehgefhtdefueffheekgfffudelffejtdfhvd
    ejkedthfehvdelgfetgfdvtedthfenucevlhhushhtvghrufhiiigvpedvnecurfgrrhgr
    mhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopedt
X-ME-Proxy: <xmx:x5OjZpyNCNs42YSX812uwmD_3xCSZm3uekRd53Xxii_QREp4XZoESQ>
    <xmx:x5OjZsQ38gHac67WMySm57z0rzmMFU895jD9LQB7MTJgbz_syfSPOw>
    <xmx:x5OjZsZy0lM0P-bUYVtlEvMPfnf3cYZ75E_UZr-CJY4MO1eDWsm2kg>
    <xmx:x5OjZtRT3rgaVpURiEM_vQ9We8C6RJBpA8VdrVQ8aJPREd9kM3EzHA>
    <xmx:x5OjZnIw8QJR7M0gVfqyEKeqDlFDhRKqIlSguQ_Og2xJdw-r-wAIMOza>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Fri, 26 Jul 2024 08:17:10 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id 46bd3714 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Fri, 26 Jul 2024 12:15:51 +0000 (UTC)
Date: Fri, 26 Jul 2024 14:17:05 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Subject: [PATCH 14/23] builtin/credential-store: fix leaking credential
Message-ID: <ba4a883ae11a2b98eae499166520d5d3fe453768.1721995576.git.ps@pks.im>
References: <cover.1721995576.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="W/tZTlhndN/blSRl"
Content-Disposition: inline
In-Reply-To: <cover.1721995576.git.ps@pks.im>


--W/tZTlhndN/blSRl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

We never free credentials read by the credential store, leading to a
memory leak. Plug it.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/credential-store.c     | 1 +
 t/t0302-credential-store.sh    | 2 ++
 t/t0303-credential-external.sh | 1 +
 3 files changed, 4 insertions(+)

diff --git a/builtin/credential-store.c b/builtin/credential-store.c
index 494c809332..97968bfa1c 100644
--- a/builtin/credential-store.c
+++ b/builtin/credential-store.c
@@ -218,5 +218,6 @@ int cmd_credential_store(int argc, const char **argv, c=
onst char *prefix)
 		; /* Ignore unknown operation. */
=20
 	string_list_clear(&fns, 0);
+	credential_clear(&c);
 	return 0;
 }
diff --git a/t/t0302-credential-store.sh b/t/t0302-credential-store.sh
index 716bf1af9f..f83db659e2 100755
--- a/t/t0302-credential-store.sh
+++ b/t/t0302-credential-store.sh
@@ -1,6 +1,8 @@
 #!/bin/sh
=20
 test_description=3D'credential-store tests'
+
+TEST_PASSES_SANITIZE_LEAK=3Dtrue
 . ./test-lib.sh
 . "$TEST_DIRECTORY"/lib-credential.sh
=20
diff --git a/t/t0303-credential-external.sh b/t/t0303-credential-external.sh
index 72ae405c3e..8aadbe86c4 100755
--- a/t/t0303-credential-external.sh
+++ b/t/t0303-credential-external.sh
@@ -29,6 +29,7 @@ you can set GIT_TEST_CREDENTIAL_HELPER_SETUP to a sequenc=
e of shell
 commands.
 '
=20
+TEST_PASSES_SANITIZE_LEAK=3Dtrue
 . ./test-lib.sh
 . "$TEST_DIRECTORY"/lib-credential.sh
=20
--=20
2.46.0.rc1.dirty


--W/tZTlhndN/blSRl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmajk8EACgkQVbJhu7ck
PpQ69A/9FYj26riQjdkCwxYOV8HQ/cHzP08rboOA7TQiaoixoLTvQ0ImpbtO220g
KCCXZbiH8inoWjBnvVPu9DiLezfKip2+oW1zghN1AHa8UygbRHDP4ksGcMhAMA8n
N4KmTEtdNtdwPz1kdN//BS41Eo89tcLnZj3vYrvx3UrvHjBbbeXjOGWU7Fe2Z+/o
wTH2D5wbms3zPfxwadsMOTjx6MAU2r7+58NotmXIpeh0WkcnfUP8BTDlffPlKHlf
nBPduwbRJxIK2nrc14S1PGYd3yG5eLvP6jXFU2ZZqy/FS1TyggZfUd65L3uAJ7bZ
7B68R2Ya06Hdx4vkju+oLVbuCRQG/lf/mIVEzabyIwpgYHkq/sA10cnHze7w1dSe
ei8UN7SiiP3oj7GdJfA4+NIOXGbrWy9+vYauyJxIsIcTtTyqJxHP9QVWsKoyHtun
JCCqT0aIJy1fK9385hqcGOOUhH94O3vOHEJq64p4R2aNbMQCCrffw3warWIJDk6A
JiiMlH/hI3ECKnSHRNKOQIU5u/sHTvk76HU8Zpqf83JqdAk5dlXwrN+kpMxF9IRE
vuXukhcXN8fliGYeEWTC8gjAhQv/HQnlhdTHwzDKmZDNtSdlereRhs6muXS8Eix+
mTUVfEmAl+Z2SM6LAgoaypzJzUwXusyV8GNLM1+OKiJmFzAOy8o=
=VjDm
-----END PGP SIGNATURE-----

--W/tZTlhndN/blSRl--
