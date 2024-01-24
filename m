Received: from wout3-smtp.messagingengine.com (wout3-smtp.messagingengine.com [64.147.123.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3046A17BA0
	for <git@vger.kernel.org>; Wed, 24 Jan 2024 08:45:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706085933; cv=none; b=Fcmj3xQLRmmwkn51UwZdJwcp2jUgn6hpbecM+j+a5ktGgiCsId16uQCdSzF1E4k91j/5wLckM27FIW/ePQWz3HhtU5BalZrm9TVE1LSxbgOwlSHRgB7TWwI+HGOaOxzusIyMxYabPn78eRsL7I9WaivbVltt/Y1Vyi/jIzKtEPo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706085933; c=relaxed/simple;
	bh=5A/vlKQ12yBgyfhhHzl4d/9BhTLycgXv5TBsAWLKr/s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HCFPyoIHcSodzlo4OO36hd9GwN7cYKfhueLntPs5p6woe6iBtR1vwTttp2sXt8RcD9y6c5rCfpfbJo3L+XWkAOkTzOWe2x9GT/jamTjGl999x59HpefELGvWHiK5u2YQSCDWq2OQV4unqPlwSwzzsrqxBBdZoVkJHtx3OJpfmlc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=KdVRAzSN; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=VfiCDRQ7; arc=none smtp.client-ip=64.147.123.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="KdVRAzSN";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="VfiCDRQ7"
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailout.west.internal (Postfix) with ESMTP id CB6D332003F4;
	Wed, 24 Jan 2024 03:45:30 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Wed, 24 Jan 2024 03:45:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1706085930; x=1706172330; bh=7S+DcTF15S
	zTSYbMSG8VEOEKvM58vGeiUjkx/0Y63zE=; b=KdVRAzSN7QypFVMDCheApuO5Ns
	X5ptEZWhQsftGMYboGEHuu69SVQOtkbTCAl8CLWEGx1M1elRx8e6hH2UWTh+m+j9
	hY1VLpcj2H1oaonquFDHpg56KPDjw92k3RTfBpiy9q3Aw16W138ldfvX/UDbDLQ4
	FPaWs3cNYSjzqZVw7uqZWIM49RKo40mt8hDuZFNHJFmD3vUvZ8ESrOq3y4LJlpv2
	VapDSthoEfn/q4HN6ofCxVBi722D1F4bhV/bSJmsWoZtFnKpkSPQztqcMxY3LDkl
	xMG3DB6hm41c8VmWDN2bMNhdLgP3oCl+W4xJBlnaIxwagJZxktDBhx/qUpag==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1706085930; x=1706172330; bh=7S+DcTF15SzTSYbMSG8VEOEKvM58
	vGeiUjkx/0Y63zE=; b=VfiCDRQ7uoWcitN3ORx+WNph4w7kpgQfGGfOaLGM2IHz
	wz/PUh4DJaNmv0tvXGO4VzxxWLGwGs461tl6mhQijShnqLALNYin6QV+gb/9b090
	Zgr6OrSAQ5AwB70SXsXCsXU1Bv89r4ZlRd76MSRUpG5h6yvgGu8epfJqWoahKYnw
	nEiV1X7HtQHuZrRpin+kpbhusDcExL2wCuyFybuE7FmJmoEkGmgr/vqkrJAi7rkP
	o9IdRfBFWdtVS6Cp9fDMoIyQLylWkymU8K/7whw38RUQlrqMyD2Ixlxw2/W9aqJ7
	0iyMCQU+PcJRwE0r2k4S4rUHHQXJWS6e77UAsKFR6w==
X-ME-Sender: <xms:Ks6wZZOatT1iIATaCeInzAExAk6vKnzWTUVa7VKW-fPxoTwODjjllw>
    <xme:Ks6wZb_-rLCv2kt47mu3hzHTJ9x1EsHLhMUQ0afJ_dAP8uCrBbLL2aWL0NpMuzOuX
    wSTtq0oCn9HQD40WQ>
X-ME-Received: <xmr:Ks6wZYRp_Be8Lf_sTegp3PYnKsN4733_TDO3LWzVIfe57uLfKdVwRd26NqtUehZQCEdtcPzuuO90_7bSHYY58UMJX7A66wHJxAan_BpyYRq1yQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrvdeltddgledtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepueektdevtdffveeljeetgfehheeigeekleduvdeffeeghefgledttdehjeelffet
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimh
X-ME-Proxy: <xmx:Ks6wZVvx2P83Vo-ciVZdLYQYTdthGQrvGO9Oj6m45ee3U5NJmPlZmQ>
    <xmx:Ks6wZRdKXn4zLc0R_6mlPBEBs7m6Nfxd5gXwVAPssYWtB7qdNRTO7Q>
    <xmx:Ks6wZR3S0ESPKgTsF6OO0I0NqatP8xUUvs8PzpNy5W269_47vlLSEQ>
    <xmx:Ks6wZY7h7Xl55sqTC5Ibe1aqc2gFIlK3VIS6OeuLRaTCLrkEnfkwVQ>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 24 Jan 2024 03:45:28 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id d511aff8 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 24 Jan 2024 08:42:22 +0000 (UTC)
Date: Wed, 24 Jan 2024 09:45:26 +0100
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Taylor Blau <me@ttaylorr.com>, Eric Sunshine <sunshine@sunshineco.com>,
	Toon Claes <toon@iotcl.com>,
	Christian Couder <christian.couder@gmail.com>,
	Justin Tobler <jltobler@gmail.com>
Subject: [PATCH v3 6/6] t: mark tests regarding git-pack-refs(1) to be
 backend specific
Message-ID: <7b8921817b14df7fe3346f89c84369df7403ddb0.1706085756.git.ps@pks.im>
References: <cover.1704802213.git.ps@pks.im>
 <cover.1706085756.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="DzvgSgKzIPXHErQd"
Content-Disposition: inline
In-Reply-To: <cover.1706085756.git.ps@pks.im>


--DzvgSgKzIPXHErQd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Both t1409 and t3210 exercise parts of git-pack-refs(1). Given that we
must check the on-disk files to verify whether the backend has indeed
packed refs as expected those test suites are deeply tied to the actual
backend that is in use.

Mark the test suites to depend on the REFFILES backend.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 t/t1409-avoid-packing-refs.sh | 6 ++++++
 t/t3210-pack-refs.sh          | 6 ++++++
 2 files changed, 12 insertions(+)

diff --git a/t/t1409-avoid-packing-refs.sh b/t/t1409-avoid-packing-refs.sh
index f23c0152a8..7748973733 100755
--- a/t/t1409-avoid-packing-refs.sh
+++ b/t/t1409-avoid-packing-refs.sh
@@ -5,6 +5,12 @@ test_description=3D'avoid rewriting packed-refs unnecessar=
ily'
 TEST_PASSES_SANITIZE_LEAK=3Dtrue
 . ./test-lib.sh
=20
+if test_have_prereq !REFFILES
+then
+  skip_all=3D'skipping files-backend specific pack-refs tests'
+  test_done
+fi
+
 # Add an identifying mark to the packed-refs file header line. This
 # shouldn't upset readers, and it should be omitted if the file is
 # ever rewritten.
diff --git a/t/t3210-pack-refs.sh b/t/t3210-pack-refs.sh
index 7f4e98db7d..c0f1f9cfb7 100755
--- a/t/t3210-pack-refs.sh
+++ b/t/t3210-pack-refs.sh
@@ -15,6 +15,12 @@ export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 TEST_PASSES_SANITIZE_LEAK=3Dtrue
 . ./test-lib.sh
=20
+if test_have_prereq !REFFILES
+then
+  skip_all=3D'skipping files-backend specific pack-refs tests'
+  test_done
+fi
+
 test_expect_success 'enable reflogs' '
 	git config core.logallrefupdates true
 '
--=20
2.43.GIT


--DzvgSgKzIPXHErQd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmWwziYACgkQVbJhu7ck
PpSZbBAAqn3/KGPvJIHvBu9lrKZkpYgNjUF9OgUIaYDMOfrTbsP3RqmiowswfB9c
FnX1gwCk0UDP1lyjvXrPtY+uPXwT+eOGsvYOWjE6zQyooYbBgeGtnnQ5hGJZuR+6
2mtH4ekmbjk4jlTFaSspYjB5JzjrPGF3waZvmMEcbrSZfXZiIB2tOe83G89YvB2G
tzjP/9MXtd6ks1PV9XH0osDc+VwcaoGs68AXJFk2juODB3O78rG22IdBn5zndJ1P
wNycOsFENZnn27J73a+5U//Gojd5BvhY7O4AjeZNBC4gM3kZbRW72+2/h1q45HMx
PuVC6XwHM6EeSxYhgAcURgbqkWqFZwLKif7fLNq50sBmyZf8ANmNT2uL0bvZ/6H8
hncnQt29y6H/4I5+5eUBpkE5zEyhIQDpCGFmR8KbhSlHTepjboUSw1TsMIeIR9/8
zIryMHUHrwSilQIlG3ZkWhXYZu6jYvr78Dz1rxw2maApMWhvunY6h5yVzjNQXIw1
DGDE9CvKtgT9ZFgiEA4ooEWZAJzYvk6lXX6qjDKJM6nxAhofIrkzLUvSheF9SrLT
Ttx5j9YJaX7aEN9ciGmKRE4eav5Ops+MJ98d5j+vQSE9sDNJk0dAi3g/ibemi5fz
yy6HCjJvFs72ImoED7bduNwaq70MPGoQ/DS6EWjH4HQ9GezgpqE=
=DiY7
-----END PGP SIGNATURE-----

--DzvgSgKzIPXHErQd--
