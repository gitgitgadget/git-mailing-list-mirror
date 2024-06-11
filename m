Received: from wfout3-smtp.messagingengine.com (wfout3-smtp.messagingengine.com [64.147.123.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57C3D176FA7
	for <git@vger.kernel.org>; Tue, 11 Jun 2024 09:20:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718097644; cv=none; b=fJrnJkCqmMGBVxkXLqCcRcAsGShpSPbwPh9toWOMj+ZT0Jpvc8I/IS9CGvRVibp02u1TdiQGXlK7ycrGZABewcLp54thOs/hiQ0sfbwbnIp8nzti4Rx0WFU/39a7wzSh+G2tdZms3cJYNVrxjjSVLjxODVk12dFlXB1HuAh/3cY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718097644; c=relaxed/simple;
	bh=dwYNc4dV5R+PAKUfX3RIC78n7lPKjuJ8CJXOuEPP6ic=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qrchnNmPIjZS3I91dxwaJ4daAg5/0g4T+E5iaZDzuycmnYJrGH421+Suxslrx/dKLyhaEFokSP+PPJfky7rn3cnQK967ZxulTQMJstVt7F+8q1fgJZyWlKnwYenhO8cxhumWjvJcU1dWKwQ7I4c10ShCjMMHlH6eaQGhf5mAYok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=hKlbwbmY; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=gU3FLqoP; arc=none smtp.client-ip=64.147.123.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="hKlbwbmY";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="gU3FLqoP"
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailfout.west.internal (Postfix) with ESMTP id 861791C00133;
	Tue, 11 Jun 2024 05:20:42 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Tue, 11 Jun 2024 05:20:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1718097642; x=1718184042; bh=LmPVacGUQP
	E3uoWA+rp9OaoARj5bi6mXGw7o89jVOlA=; b=hKlbwbmYRqRiKq8EyH/9XMnQLV
	c66TNgcZryi38/T1Wc25xfguIdczHvrjtfCWxEoHS9E9z1KsV1GVFLAt3U1jV7TO
	dFojq5lk4exd1w6h3NJ9IdZhYUuGXjz1iC+rE1sqtPaQjRlRZu3YofdBpKLc9STv
	H2JWTJ/iBcHEebEzcHb9+m/x1vDWsdP5RbfqFAthS3po0Js5AgOjc2tJQHaVK1iW
	x2+vgxspite6jr5fhWThZ6y8qiU6ZO4xft3euVf/6/mWuq1Gomw48hQbSd09raDg
	vnzj+Egxhmyz6/+4QqYQ1vVecqstsmcORrpkJbTbQyWnQwL7ayV0xLm3/smw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1718097642; x=1718184042; bh=LmPVacGUQPE3uoWA+rp9OaoARj5b
	i6mXGw7o89jVOlA=; b=gU3FLqoPYhgQl5aE/DozKqrnTp6NbmdfGRHM9yxJZJek
	1KHZCTP9zI637V3n6W3ISqbW0hX25G7t/kBCB65GdI4MBwWH16yaHHTm3qq4Lu9V
	va1nFZbi4dguusraaBOzOOzeTi9XymxHxa5gCwIDg9BuO5praFyby5+VaNjZW+5J
	crrg4aL5czM6Ryo5eLmCfJeNv9R6Li8oFLXDTTF8QsIG4gf2ONGGHp8/YoEDvo5g
	4OxMEpCuk6K7en/1zmAEiW3UXADwA0ustMxo3THH8nR2y2A4nNaLKl0DSlSLiSZ6
	gEJYANWDTSx4L3SqTwjifRdJrNx0ipN9OAIcSllf0Q==
X-ME-Sender: <xms:6RZoZruSHUhMHMaBdyMyfHUQ83d85eoP2yjLXduLYeWrOnettn9d2A>
    <xme:6RZoZseXxfzkpOLB92NNT-yR7h_VlHJ6RjTAWtcpldebtLs54dkW7OkqtzMA-4wzY
    MXnaYYvSVkhHnW39Q>
X-ME-Received: <xmr:6RZoZuzBUpvMuBwkyuzplcJqF6TShzQBeM0xqIBzQa-dY734lzNHO-Mxpnu6tvASZwV84ax0Xy7zfdM1woDRNRyUp8HjLIQ4YRz8XkaWRynZ13txeKzM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrfeduvddgudegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepueektdevtdffveeljeetgfehheeigeekleduvdeffeeghefgledttdehjeelffet
    necuvehluhhsthgvrhfuihiivgepgeenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimh
X-ME-Proxy: <xmx:6hZoZqMF6i6vZeAlgOkvjIYe9DbaRkDz6hIJ5eX4nZTcJNPlSUNOrw>
    <xmx:6hZoZr-cPANEGl7ZYR9Cp6OkdsrTWulfyi4HtunxU7_xruIbjlehoQ>
    <xmx:6hZoZqXznHiHLTToUiZSEsrc7LwOaP5xDHWFVb3ZeYxUZDXq0RoFEw>
    <xmx:6hZoZseMc4IlZOEcVzYEQ1K4qTxiRpimc2fx1fuh8YRcISw5X7I6Ow>
    <xmx:6hZoZuZIEJ-2K93_yucQlk_azlmsWWv-E23s2QfafjEUY4yzNKMViwMo>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 11 Jun 2024 05:20:40 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id 79c560e1 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 11 Jun 2024 09:20:31 +0000 (UTC)
Date: Tue, 11 Jun 2024 11:20:38 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Phillip Wood <phillip.wood123@gmail.com>,
	Karthik Nayak <karthik.188@gmail.com>
Subject: [PATCH v2 18/29] config: fix leaking "core.notesref" variable
Message-ID: <1700ec8d215d244ad6787880cb25b9acb83fcddd.1718095906.git.ps@pks.im>
References: <cover.1717402439.git.ps@pks.im>
 <cover.1718095906.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="j597majUko7RABSM"
Content-Disposition: inline
In-Reply-To: <cover.1718095906.git.ps@pks.im>


--j597majUko7RABSM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

The variable used to track the "core.notesref" config is not getting
freed before we assign to it and thus leaks. Fix this.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 config.c                            | 1 +
 t/t3308-notes-merge.sh              | 1 +
 t/t3309-notes-merge-auto-resolve.sh | 1 +
 3 files changed, 3 insertions(+)

diff --git a/config.c b/config.c
index abce05b774..742175c130 100644
--- a/config.c
+++ b/config.c
@@ -1565,6 +1565,7 @@ static int git_default_core_config(const char *var, c=
onst char *value,
 	if (!strcmp(var, "core.notesref")) {
 		if (!value)
 			return config_error_nonbool(var);
+		free(notes_ref_name);
 		notes_ref_name =3D xstrdup(value);
 		return 0;
 	}
diff --git a/t/t3308-notes-merge.sh b/t/t3308-notes-merge.sh
index 202702be1a..e1d05ff6bc 100755
--- a/t/t3308-notes-merge.sh
+++ b/t/t3308-notes-merge.sh
@@ -5,6 +5,7 @@
=20
 test_description=3D'Test merging of notes trees'
=20
+TEST_PASSES_SANITIZE_LEAK=3Dtrue
 . ./test-lib.sh
=20
 test_expect_success setup '
diff --git a/t/t3309-notes-merge-auto-resolve.sh b/t/t3309-notes-merge-auto=
-resolve.sh
index 9bd5dbf341..f55277f499 100755
--- a/t/t3309-notes-merge-auto-resolve.sh
+++ b/t/t3309-notes-merge-auto-resolve.sh
@@ -5,6 +5,7 @@
=20
 test_description=3D'Test notes merging with auto-resolving strategies'
=20
+TEST_PASSES_SANITIZE_LEAK=3Dtrue
 . ./test-lib.sh
=20
 # Set up a notes merge scenario with all kinds of potential conflicts
--=20
2.45.2.436.gcd77e87115.dirty


--j597majUko7RABSM
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmZoFuUACgkQVbJhu7ck
PpQiwg/8CW19GJVu8QqRDTQLqj/41OxZ2loXBH8n/ZnX2OK+pbH9ahBjIqmDyOpf
nXp4Qs45dwG3muk4KEp4ZKTYLgigQI116MpJikMwUTRLAxWyL87KhnenDox6s8wt
kbcModBBXglV4z1SaTylpK4T8bQ+XUEGdtrZP4iL2PLEHwVLiCXe3Miv4vLY6nZc
3HbVFhxlmpTYJ1+KLmBdxz6SK0BPS7qxZj8znWfWnUhGT50Wv+82XLAZZfpDUCJB
P6qQd+asAfjGxT15pBG/BMpVqfbsMLuMVOwwE88M0ePMkq8aFwVx4lFo2E/bwvTa
oouFHfeXAHKJ24QwXpzERUVhrMv+DAQj8GKb+RnSU8XCe81WGeSJfjpiEd9JRqol
8gCGpShPTLFLSTaWU7tHKLo1IxQa1sg0hqS8GVTQzgHBhHbcSR2kPpPKnosf20WQ
v9KiaDQvA1VMYkirmnSVI9T/mEWjB2vZmF2ELDgrNVkzehcDnvG2EvrYpIF6RNNS
vX7Fc6+Wppb0DzRl5LdWcf+3ntBGyUXO8NgFEhWvduNaRjHgaGdeYVHw4GNu/VYm
69RIrynEo67HKf1rTuTo5z8/5FRYwPPc3sMhkAlDwE0v8SGi5yENqecdRSSIki0w
c9AlZJqaIIdGlO3/k9ebL1cpNE4j9eqn2/KZGYZnSN94dnPo+/k=
=nIAm
-----END PGP SIGNATURE-----

--j597majUko7RABSM--
