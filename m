Received: from wfout4-smtp.messagingengine.com (wfout4-smtp.messagingengine.com [64.147.123.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC00484A35
	for <git@vger.kernel.org>; Mon,  3 Jun 2024 09:48:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717408100; cv=none; b=c9Yt+9XzwV+Pmz8VF5Frc8l1mrj0v6Zg9poPNwmzEvmHjwt+1Cc5Jm00lecs8dEFOfHrM8oiAiTHK5SJ3+sSGIyUGn2Hjq1MZZzpnmwkrDwMraDz5FG+N5CT6ZajV8Yvy+M3NvZIKX3SL/5lz+HewiLzpxIvWM6ccjMdjrRdR/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717408100; c=relaxed/simple;
	bh=IHm77aFN4FeX5bkZ0/eN6uIqM+fGojn2qSto8OjhrWQ=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QJD78S3kn1gCKmk5D+Rkdtrdw2hrvpSmIbpag35rl5WvZiCdBSdb9BsTdLfrEIlYVYNDXNuP/gF4sCEkPtBa5y1+di20FBxMFT44Ia5w1MeQKK0RL6kqJfjW2o/trFQC0hbNFOOLbPO9pkwu9uG5EZgRTR5K1/RxNS+to8aPZQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=NxDOd3S+; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=SAZvxx+e; arc=none smtp.client-ip=64.147.123.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="NxDOd3S+";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="SAZvxx+e"
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
	by mailfout.west.internal (Postfix) with ESMTP id 31FE91C000D7
	for <git@vger.kernel.org>; Mon,  3 Jun 2024 05:48:18 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Mon, 03 Jun 2024 05:48:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1717408097; x=1717494497; bh=rPC8aN3Rms
	6KP0sK6BsgjBmYuJE4Na+tk93oD8ge3KI=; b=NxDOd3S+ZYJuliC9/rpzmwue0N
	Yz3M2A1f9fclfkZUQjgSYUr7MnFuK7g3Tj3GL8J4K9fx5JzdFzzD2LEGbhvgd+ru
	svhE+D6Ub3vFwZs0MHWrG5c5FIDbuhMvrhy46r/hlHwEJ360YeQIRSwtKOm1Wy5z
	5nxg0qZQJrum5pZamQGvaJN7Ufv2vYsuEGeNVcrB40tFM52A0vQ0/Hi1eQtn+O2N
	ZhsW97hwi07uTJHT5+0H8jLc4OfADqlmqzNfE1FEnx+RRNyly7LesMQT8lVZVdGl
	Ewc7xdQtUrSckF4UIduDQGBTpCvhoEt8esvwtHxqmn2iBEO/cZ/UNhh0GXzg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1717408097; x=1717494497; bh=rPC8aN3Rms6KP0sK6BsgjBmYuJE4
	Na+tk93oD8ge3KI=; b=SAZvxx+e+H6qeCEMUEfpPrfylSC83XtkeG9qXVFk65mX
	nA9vzvBILrVYmIvZlRbdZTvDDIC9PSmRzTl8OeiluCgh9/0/HnEBJhU1LyhB8gEy
	EMbCdkU44Z9L2yp0rWPBXehCnGQLD2EhZ5bUnQITasGs0RBOFV0prub/cf/Yy6Ab
	loPlpsvBMck7iG9G+EVL6gwLYLhcnNlU2bqRCbYdPSXF+qakOBGulWR+SdOrXh+b
	ynXMeJgh6xEZijd/NpJCIjd89c1P2yvzSdspn2ODPJqJbgJ5wADWiYia7rLVCOEt
	8yL7IWna3r0KWx6qfO3SR2E8XVwuBmOXrPssii9tCg==
X-ME-Sender: <xms:YZFdZgu2YbiLgecrV16JkDegjeejrcH4DsawQYQTgVrsNdNtuTUgHg>
    <xme:YZFdZteAQu8sTTDeKPUT4HlLnVae0N4w_ZhdEUz_cGUdoV8yXRt6ptvEP0G8aO3t6
    aEA8PQY22KCr481PQ>
X-ME-Received: <xmr:YZFdZrxdps5EO0ERr4XjMPOfwfn383lAD6jAf5r_h48OY2yS51enCyc-uUe7HySMkRrykogOacWsnMqRztdiI4uy4lNQthVx4JmlMjxP5K_D0HtB>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdelvddgvddtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvuffkfhggtggujgesghdtre
    ertddtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehp
    khhsrdhimheqnecuggftrfgrthhtvghrnhepheeghfdtfeeuffehkefgffduleffjedthf
    dvjeektdfhhedvlefgtefgvdettdfhnecuvehluhhsthgvrhfuihiivgepvdenucfrrghr
    rghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimh
X-ME-Proxy: <xmx:YZFdZjM9QCuaGmJk8LY4DlUv-HcemE-nTiV1YBqSIRVDAZCfiVkGSw>
    <xmx:YZFdZg-lnQKqoe8pXZJezRn-d0g1UISB5uHcfXkEI-7493_bQO810Q>
    <xmx:YZFdZrVdJWy8iu_Og2ay6usBfP1qxFZZzw6nHQMSpxMJyGDnvKTK3Q>
    <xmx:YZFdZpcVk2lRKhb9fb7qoQt6fc60QYdqzJeH7iX4JJ1bWPc8Eq25IA>
    <xmx:YZFdZumbABrAr4K1_NZ_Q5M0jQ9CvhPnHpKs94MlAH7RZ1LZz_BKcEdc>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Mon, 3 Jun 2024 05:48:17 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id 648ef0d3 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Mon, 3 Jun 2024 09:47:53 +0000 (UTC)
Date: Mon, 3 Jun 2024 11:48:15 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Subject: [PATCH 23/29] sequencer: fix memory leaks in
 `make_script_with_merges()`
Message-ID: <713531c6f18a8456b34061a49abd76ec5c61d8c1.1717402439.git.ps@pks.im>
References: <cover.1717402439.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="+qhxYF5DjWRq3AN8"
Content-Disposition: inline
In-Reply-To: <cover.1717402439.git.ps@pks.im>


--+qhxYF5DjWRq3AN8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Fix some trivial memory leaks in `make_script_with_merges()`.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 sequencer.c                       | 3 +++
 t/t3418-rebase-continue.sh        | 1 +
 t/t3421-rebase-topology-linear.sh | 2 ++
 t/t3434-rebase-i18n.sh            | 1 +
 4 files changed, 7 insertions(+)

diff --git a/sequencer.c b/sequencer.c
index 2ce807533f..1a54f18b43 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -5951,6 +5951,9 @@ static int make_script_with_merges(struct pretty_prin=
t_context *pp,
 	strbuf_release(&oneline);
 	strbuf_release(&buf);
=20
+	oidset_clear(&interesting);
+	oidset_clear(&child_seen);
+	oidset_clear(&shown);
 	oidmap_free(&commit2todo, 1);
 	oidmap_free(&state.commit2label, 1);
 	hashmap_clear_and_free(&state.labels, struct labels_entry, entry);
diff --git a/t/t3418-rebase-continue.sh b/t/t3418-rebase-continue.sh
index 127216f722..c0d29c2154 100755
--- a/t/t3418-rebase-continue.sh
+++ b/t/t3418-rebase-continue.sh
@@ -5,6 +5,7 @@ test_description=3D'git rebase --continue tests'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=3Dmain
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
=20
+TEST_PASSES_SANITIZE_LEAK=3Dtrue
 . ./test-lib.sh
=20
 . "$TEST_DIRECTORY"/lib-rebase.sh
diff --git a/t/t3421-rebase-topology-linear.sh b/t/t3421-rebase-topology-li=
near.sh
index 62d86d557d..737af80bb3 100755
--- a/t/t3421-rebase-topology-linear.sh
+++ b/t/t3421-rebase-topology-linear.sh
@@ -1,6 +1,8 @@
 #!/bin/sh
=20
 test_description=3D'basic rebase topology tests'
+
+TEST_PASSES_SANITIZE_LEAK=3Dtrue
 . ./test-lib.sh
 . "$TEST_DIRECTORY"/lib-rebase.sh
=20
diff --git a/t/t3434-rebase-i18n.sh b/t/t3434-rebase-i18n.sh
index a4e482d2cd..26a48d6b10 100755
--- a/t/t3434-rebase-i18n.sh
+++ b/t/t3434-rebase-i18n.sh
@@ -17,6 +17,7 @@ Initial setup:
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=3Dmain
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
=20
+TEST_PASSES_SANITIZE_LEAK=3Dtrue
 . ./test-lib.sh
=20
 compare_msg () {
--=20
2.45.1.410.g58bac47f8e.dirty


--+qhxYF5DjWRq3AN8
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmZdkV4ACgkQVbJhu7ck
PpRWtg/8CypUEn9ioQcYXMIMGUMYCHsghh6ePWJulnaz8ggc+WurlrUs2s+9uXF+
wVKC8RrGhzfdUXKYLis+AE0y0dPtzhkzTDRrIv0D23jsP98sAehGOfIwoyOn8c4B
f6CO3y7U4DAgk6y0uroAgKRTqpxx8i/s7HNqjzI1nDcsw4KqVqKbgnRYeZfGPtEK
iPWBp0T+8gxjb5Omv8S0gktFZAL/0MoWDHLRj1lMa3i+A6NAZAx8Xlu4u5DtShvi
oZ6oXEVxPxxhuVHKEKWqtpi4N2H/xQIuCX8Cix9iBjQU9qEzbDc1XPoFttOanvsJ
5rescGM1PW34WgINxRTEIAhOwckpBD0JFB3gLqDR5h8d/jXdds0YGwWFVVQP/Dfk
GZr3OEC5NN+YOH1MRoKpDJIrZqBHjWUV+MXaO7v6CgDbQbaMDa9Q980uOCl0yJQe
PF2uT3/zabcC7vy8Nuupx8Cx72RRjGgJPr9kGEbs9bO9Crgz39fdmW9Jwqwp1f3U
BH0RtddMjUA7GtsyDngyhyqXVqbuJmhZ+aVdgnpVyga4dMM2VOW/muUFsH367JXI
aJt3II7l1NRM8RGvqbTdbkzXvKhZZnm4TmIB+aVlGyeDz4XrkguTomOLJoxAsUbY
nSwy3wQc0PZDpmTE3Bz8NBsgF6UHDM35iPuKb8GKASniKOLfr0c=
=slLq
-----END PGP SIGNATURE-----

--+qhxYF5DjWRq3AN8--
