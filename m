Received: from wfhigh8-smtp.messagingengine.com (wfhigh8-smtp.messagingengine.com [64.147.123.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47A59152DF2
	for <git@vger.kernel.org>; Mon, 27 May 2024 11:46:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716810420; cv=none; b=MEZOjyq3XTMu65DpdkmPWWU8WFcGHXX01K9rzXeI9ZxeF28TsxUWsBVNK/SN7cBhZCjNOchgYP/+df73lWJssGpxIegDwBNKr2jmlyHIOvLDh06xlvSm69ufEtaavx42KZ5V6NJoVW2T65hxPXNooBQqOoTEuZdOH19levdc6Dk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716810420; c=relaxed/simple;
	bh=25OWtudykoFW6FginvwK+AkqS/6JMn9cV1tmksr63oo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nYIg8QckEJN5JawSlFd0l+52tvgh6HVlP7GUXo1WMaMIiRCx1a4LQShPELMgNj4vjCBBXAvyHhccryRqmKR0LlNd0VyvaHXZnh3XWjQMaW2bGMDAiFRrX1g0Kriw17Dp4V2SgIerjsrQ2UIDMbHt82ZKapMYk18nBBuFaGr13/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=mKVJ2oU9; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Eew416w6; arc=none smtp.client-ip=64.147.123.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="mKVJ2oU9";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Eew416w6"
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfhigh.west.internal (Postfix) with ESMTP id 6032B180009D;
	Mon, 27 May 2024 07:46:58 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Mon, 27 May 2024 07:46:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1716810418; x=1716896818; bh=Wwmx38uv0I
	OGM2/l3KO+mPGzb3zGvLTPlOmg9a7V20w=; b=mKVJ2oU9qKVZhq+gqDJ2oZWRND
	DvLsdLcwyApPRZvzSOAEl/aE/c3+UOm1jLr8f0oJMwAArv6hf0m5Ts4hnk3EMfgm
	Q0gSJtRaLY6x18pNnLbwERzFy5OHJGWMWlDdDZBUP9KILd2O4XzTxrJRGLEZogEE
	xoEAskSyp465LWW5/VO0UQCykhS9PQEjFwKLH1OGrVk4QHDUMY9O0pwHLZYRc0KO
	ZSkiDqmUFdI/W4KU2mphz4fLgJoZuw30WN3QaMSoaIto54g1gF17EtaDpq9Iwfxi
	skee9qopUkNUSvx07Uto42sK7sSixBNuLngdxK22JcYmL7DW/OMGv/KRC2Pg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1716810418; x=1716896818; bh=Wwmx38uv0IOGM2/l3KO+mPGzb3zG
	vLTPlOmg9a7V20w=; b=Eew416w6uktW3rVQZm/6XBxMeaCpDCDk+RO/3H/vSl4M
	dJKTmex00oSMRnuauug7mPnkuDnfwjwHBivDT8LcD7ukJ/x2RdcjwkPZfyDkj2Qw
	AiHdmqj9CdrsyUHeJN0arua3v4t/tb8RKhRmDhZi+XIUtbPEmcTJ/OkURjnNFDJH
	Ow2ONDu1G8vpHHdZfwWTXieZVQj5JkBNyJ4TgspX9uPWdkZTs70EvesJxMpIjLJM
	JXMsY+9ydUVo/XDiqBHLe454MZTll6DatgBLGSituREtrx4Th+moMogqB1HOvbQL
	fixg2o+sOy0lHBhola969GskJDWkMu+q43I6x4+4uQ==
X-ME-Sender: <xms:sXJUZkVVsV3m4yolDdc2OMxGd83AwqDWcng3ktm4I-FLoQa019Xyng>
    <xme:sXJUZolor_C51tEthEEiCANcUOZtHBKOaDgSobfeMKXd9bwAaNxovsTIJa6wjMxzQ
    dwsDiBK_m1bRqpD0g>
X-ME-Received: <xmr:sXJUZobwRjYfx4wgsQBl4nKjTrUBOMx3RUyjDtTmLs9cPWaqYNny5tmuhFSpsb-71jiWQCgLl_HAS68knCXZGW2PygZronlKzeoVOr8wMwJ4l5c8QI0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdejgedggeefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepueektdevtdffveeljeetgfehheeigeekleduvdeffeeghefgledttdehjeelffet
    necuvehluhhsthgvrhfuihiivgepudenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimh
X-ME-Proxy: <xmx:sXJUZjU5uAytEzRHDlP113aG3tSZb8QxdUy5_703tzrSkUCZeDBOZQ>
    <xmx:sXJUZum99dzxX7n0xzYR1KuRXFYLGlNixqDmYDRDoTraymuuEyrIEg>
    <xmx:sXJUZofO834lpGsZyfmj2lQXXAuYRxeikt-Bo7iEUrMjAGqE_QORoQ>
    <xmx:sXJUZgHLbQJt-1Xdwey2vP-5N84lSUf4ICIDiwYMV8wPvyLD9MDO-Q>
    <xmx:snJUZlt07TIRMDGpOErh6hqMzalj6SdGBPkjs8F_yJ9NXYqOAatFA3uZ>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 27 May 2024 07:46:56 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id 68661363 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 27 May 2024 11:46:46 +0000 (UTC)
Date: Mon, 27 May 2024 13:46:54 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	Junio C Hamano <gitster@pobox.com>,
	Karthik Nayak <karthik.188@gmail.com>, Jeff King <peff@peff.net>
Subject: [PATCH v3 15/21] commit-reach: fix memory leak in `ahead_behind()`
Message-ID: <b315a5bb5cbf03180965e79f129f44ec7deb0eb5.1716810168.git.ps@pks.im>
References: <cover.1716465556.git.ps@pks.im>
 <cover.1716810168.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="HipnyZmlIa3Olyeb"
Content-Disposition: inline
In-Reply-To: <cover.1716810168.git.ps@pks.im>


--HipnyZmlIa3Olyeb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

We use a priority queue in `ahead_behind()` to compute the ahead/behind
count for commits. We may not iterate through all commits part of that
queue though in case all of its entries are stale. Consequently, as we
never make the effort to release the remaining commits, we end up
leaking bit arrays that we have allocated for each of the contained
commits.

Plug this leak and mark the corresponding test as leak free.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 commit-reach.c           | 4 ++++
 t/t3203-branch-output.sh | 2 ++
 2 files changed, 6 insertions(+)

diff --git a/commit-reach.c b/commit-reach.c
index 8f9b008f87..384aee1ab3 100644
--- a/commit-reach.c
+++ b/commit-reach.c
@@ -1106,6 +1106,10 @@ void ahead_behind(struct repository *r,
=20
 	/* STALE is used here, PARENT2 is used by insert_no_dup(). */
 	repo_clear_commit_marks(r, PARENT2 | STALE);
+	while (prio_queue_peek(&queue)) {
+		struct commit *c =3D prio_queue_get(&queue);
+		free_bit_array(c);
+	}
 	clear_bit_arrays(&bit_arrays);
 	clear_prio_queue(&queue);
 }
diff --git a/t/t3203-branch-output.sh b/t/t3203-branch-output.sh
index 758963b189..e627f08a17 100755
--- a/t/t3203-branch-output.sh
+++ b/t/t3203-branch-output.sh
@@ -1,6 +1,8 @@
 #!/bin/sh
=20
 test_description=3D'git branch display tests'
+
+TEST_PASSES_SANITIZE_LEAK=3Dtrue
 . ./test-lib.sh
 . "$TEST_DIRECTORY"/lib-terminal.sh
=20
--=20
2.45.1.246.gb9cfe4845c.dirty


--HipnyZmlIa3Olyeb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmZUcq0ACgkQVbJhu7ck
PpQpLA/+JfLumk30jPRNRw8TcnmtijTogbR/XQRSXbENsRmMzsD8P+6ZA/e+vf92
XHqQC1FqX6ABLpSQaC4pW81q81QInRIDB3QllL+gusjNNHwirz0qyewyP6LmWq1N
4ZVcvSiuFRNMkGQ+pkV4AEI4xYiqqrqvyNpBYw74PSyxJdEbmzkLbRBNXKaiqpft
KdYnhVfsKgWG6jO7F8STHyCFBFIdGRnANHRFRz+NfOWKjwmIm/ETT84qVDSgZb1z
EzQwvc7f9zdjZDT8LUPTLoCnHdluT15p1ORXHnJyQ3go/ZRd4RMWMi3Ut49B7kd5
Fi/2+aw6Iy9KsF0O2EhiuZe6f7z9at5ZDA8HANPvJYAlGv2+K2V4N+OMz2OvA/1r
Ti54Sz0CrsAPXPyPvOR/3dg4yHiMDiDDKX1JXHtjADRlzd/4Ye+aCOf0omX6/uw0
e6KjAYj2+0wtIrbQkm+GsqAe4D+QpGG4P0pAy70uXuQu2k8Q8NM8Ae422prQPJq3
WO0jPb3jLbLsAgh9ZXtnEX9yTM5FJEtGAHCOowOSuG1xP+DGqier11XZjhcjddo8
wa4K8tYd3HZKqPeE9/q49+0AYh1T9xr8YDj4Aixhlo4qs5U4Jd6sJbvw415bFPXe
GGnn261zCS44zq7CvLAeQQG5Ix9HeXAyCFaO0q6KiqknWvb4BB4=
=B0KZ
-----END PGP SIGNATURE-----

--HipnyZmlIa3Olyeb--
