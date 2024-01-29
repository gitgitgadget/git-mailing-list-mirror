Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com [66.111.4.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 122095FDA9
	for <git@vger.kernel.org>; Mon, 29 Jan 2024 11:07:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.111.4.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706526447; cv=none; b=cpGOoYhbWDHe2vu3ysLgcdcowc8+oKPjbx0sFRA4510JZhxn2NspaiZIwINCTP5d4RZJHr+jSPMRJECix8vLptQmcV7eh8ZwZTueL5OZmB7GCzOHAFvg7jloqe14UBDB9nXe0RehBQrXAYYF4uP+zoRamXapC/bY0cCnVmkb6ic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706526447; c=relaxed/simple;
	bh=/L+9fvZitvCxdi+WK1Ra/3kEueZ9tN1D+dl+qpsGVpU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LqhYT/aK4czyZ3H+i5R4DKUg4WL1rJoLmVnvbTbqAQYRuB8yGqPizERQ6qKJCOJmmQzegGQdyAVdIfA6MjtP6P5NAq6lvKlZOkdq/+4kKM3gYb2OhUFcZ95v6SGkZ4aolhGNqLvAyjIdftU8dSP6q3LcRdGPsB0XZQjPX00pSKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=c2H0laM8; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=FyEAgt7G; arc=none smtp.client-ip=66.111.4.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="c2H0laM8";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="FyEAgt7G"
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailout.nyi.internal (Postfix) with ESMTP id 0B2925C0113;
	Mon, 29 Jan 2024 06:07:25 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Mon, 29 Jan 2024 06:07:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1706526445; x=1706612845; bh=HYY2k/I4Vp
	zFhrTLDAKc12qYuc3umrIgWE/z80yKuSA=; b=c2H0laM8O8bACHEmepYrHUELYR
	L9SBsGcfJc7Lv1sUnU6t1VE/WSyzmExWIHEUEZUfkZsk8Q8wa0BRXSi7T/RM11v8
	tmbUuVW70htDPZ1qodN1MAC275k7Jw6krblN4GMotvrVg06zAWgDu6EFzq/qaj7e
	diq0dNTogR3r87ttcT4LpONjV7ZvsYRrWBbOnXAst9UZQKv4/JCounmLZP6sBd71
	banRuOpufq7YUAKTbKratBr3Gv1poVjmCHoEBLwfk7o7C9nQ0UVB/9S+w97XZvHu
	CXFpGGHQMo8zdXKcnwv3IEWoNFZlkZ+GSmNAl1r0MUw7AbhhyVyMixhgiLgw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1706526445; x=1706612845; bh=HYY2k/I4VpzFhrTLDAKc12qYuc3u
	mrIgWE/z80yKuSA=; b=FyEAgt7GJ5r+PpvIbTUGDNzVaBWDpN18LZ/XIcewKMXZ
	tD3+doE1S6hkW2KOPsX9SMHQEwtASCWEEObJzBu0ROyCSI45EKUtiNR5pFgDiHoh
	Rwd4z1apbItqbKP4BRZCQMNiLH2roUo0Ji2pV48BdJq3T9ARppApcqsLcSyMjhSd
	p7N7iBSKcUTPKvjRYqMNqPayahvAEkL4NAXtHr3BKkbPp+bvMaTmuAaVRK9wi9FA
	L3GQdC9FsNG2kBE2SX01J5Nz/2+8VlAhaiulYXMdaPAgGck7YJZrqTs7oiZoodQB
	CaCF8JMvviDIOe/s5EvqnXSzFAK8570prkpO52tOOg==
X-ME-Sender: <xms:7Ia3ZcPK_RKIK6snLpwgZHpwh31CRTETNUqcuw2X4uo8RmqLfS4QCw>
    <xme:7Ia3ZS-j9Gc4Wv96h0osp-rGqz6fpHZbqECCwU9mx5vebNdVIvrumxPAlonnYHbVT
    yivQnGt8k1wZkmNCQ>
X-ME-Received: <xmr:7Ia3ZTQNeja3L7mI_fjrA3D-tL9DgYaird3bhQXH2HxigcMMwk2qATSU0ZBNnuwLP-JrTLgqdZfigUywUwGZ6gHzrEOFq5N7fcLTgwB9PveJ6XRaHw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrfedtgedgvdefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepueektdevtdffveeljeetgfehheeigeekleduvdeffeeghefgledttdehjeelffet
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimh
X-ME-Proxy: <xmx:7Ia3ZUvDp2JX8vsw-Jc6bevnVfJOwzLuN1wZOVqV_gVEPopM_1zHxw>
    <xmx:7Ia3ZUdNSwoMSijdcJtD4KvLh8Xu3N5eO0yfB_7yQiWEs9M3jQ0gKA>
    <xmx:7Ia3ZY1N2FmqvmsZu2HkRybX3air0puHIzLzEFvrX8vcqHtFW16X1g>
    <xmx:7Ya3ZZHCyEopw384Nc3knsuJEnfHbVrnx_zEgizoevddiPwRqLy8Sw>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 29 Jan 2024 06:07:23 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 893a2781 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 29 Jan 2024 11:04:07 +0000 (UTC)
Date: Mon, 29 Jan 2024 12:07:22 +0100
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Taylor Blau <me@ttaylorr.com>, Eric Sunshine <sunshine@sunshineco.com>,
	Toon Claes <toon@iotcl.com>,
	Christian Couder <christian.couder@gmail.com>,
	Justin Tobler <jltobler@gmail.com>
Subject: [PATCH v4 2/6] t1301: mark test for `core.sharedRepository` as
 reffiles specific
Message-ID: <4359d3ffa816541cb68212714fa5d08e51138203.1706525813.git.ps@pks.im>
References: <cover.1704802213.git.ps@pks.im>
 <cover.1706525813.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="AMKyBOYpH1TyUHdL"
Content-Disposition: inline
In-Reply-To: <cover.1706525813.git.ps@pks.im>


--AMKyBOYpH1TyUHdL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

In t1301 we verify whether reflog files written by the "files" ref
backend correctly honor permissions when "core.sharedRepository" is set.
The test logic is thus specific to the reffiles backend and will not
work with any other backends.

Mark the test accordingly with the REFFILES prereq.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 t/t1301-shared-repo.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/t1301-shared-repo.sh b/t/t1301-shared-repo.sh
index e5a0d65caa..8e2c01e760 100755
--- a/t/t1301-shared-repo.sh
+++ b/t/t1301-shared-repo.sh
@@ -137,7 +137,7 @@ test_expect_success POSIXPERM 'info/refs respects umask=
 in unshared repo' '
 	test_cmp expect actual
 '
=20
-test_expect_success POSIXPERM 'git reflog expire honors core.sharedReposit=
ory' '
+test_expect_success REFFILES,POSIXPERM 'git reflog expire honors core.shar=
edRepository' '
 	umask 077 &&
 	git config core.sharedRepository group &&
 	git reflog expire --all &&
--=20
2.43.GIT


--AMKyBOYpH1TyUHdL
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmW3hukACgkQVbJhu7ck
PpTnXQ/+ObmkI2FWK4tRp5aw5gcnUGVkaaM9oh8N6d7NUhuivirYL40WRUx2U4yI
nJks5vaQ0k2zc1WJF1cn6/YZq4o9HGFxqolaBz+4decp4jUVZYYziaEStrFb4rnw
rgSUbolg32LND1r8x7jN6cL8HtvOlB4hQl6L1G7dTOvUM6ulzPA1rCYtuKPjksqN
d6ZpkQv188/qFz6sWOKDQ+kAxBWrhB4G/GBXmrHV9Oen3WsDiWRZyFQ9T+Ki2r2g
OPq77/EIkBpf8K1xeOeHGH4KvhFqGWmxFBxQofpS2c1KzJd9BPpvho7X0W66WtbY
ujAraIpjzo8UIiOrq+a/2EAs80dx1n7VX8JGsPTf9aXlpwGXw8KKMZsqmP+2H8yY
ieePABsv3hdG0NcKeEtVx74+rPo+cza+XNfLp6fVM6byR2ibqGBKLNn3QtlkIPeU
TiS0+ulBk98+ObHjNm62it0S6nFEK+Ubsjnmz3hCGR0GPShaHBmjg3OXpra/Kr3X
/6SAvET0BZdMnq/PzIpcqq6NDwz7vPcJB9LA89sjL+llOnHG/scqckhP8VnB36L6
HEk3qIP8IXtV3aLsQhWFOBBhshZE+l74wWGnkTD9pXE5duQrCwYE+Jf3rdN1me6U
TmsroBoAhwLr8BmcVIAirNHlP82N8ynIfZ3bzfis0C58RIn42z8=
=nG3m
-----END PGP SIGNATURE-----

--AMKyBOYpH1TyUHdL--
