Received: from fhigh1-smtp.messagingengine.com (fhigh1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3EFAE57E
	for <git@vger.kernel.org>; Fri, 26 Jul 2024 12:19:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721996375; cv=none; b=IKIA339hOvS3dZ8qlZ2JjJm/p64IlE3UF94JU6cbICOS2+SdO+HZz8YiJgeF4rM611HuKCnN09T0eqddzi83orWUK1E7gicf6EkneEz4lXnUGMpJhoChY7bFVPxRLU/N98tamajK6BwpxdLgfvqDjljvhr10WSJD5qbJHV1W+u0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721996375; c=relaxed/simple;
	bh=SLWgMdu0Xw6GNQwQ9l8xZr9EO8TIWCQOsQ1weYPE384=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cNU68rK0daZu965xevARA3oI7t8IfAELFuUSa1istok+Fi+hnLPwg0N3Knti9OHiPiB2MbeIMhhEILDYSg1ZrERbFusabPKAk9vZdgryzJhlWXv26pYRKi20kCd7fAVU6srYIjkk0vyi7APFy7Nq9Ex4N7P3KlsiIn/xi1EVhz0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=XxoKkgYm; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=tJHwFigd; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="XxoKkgYm";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="tJHwFigd"
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 65079114020E
	for <git@vger.kernel.org>; Fri, 26 Jul 2024 08:19:32 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Fri, 26 Jul 2024 08:19:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1721996372; x=1722082772; bh=Qk3A039ivy
	zhONKQghmlPyCFKQHuELNJHfjZWLcVy5s=; b=XxoKkgYmk6ysExX+xFCNJEGST6
	F8BMpin47P4IzSgZLtoFS0tl4g27n/IY0Z7Gw9sC9eMCMjivWZnhv1ktSVf2RwjR
	eoes0DCix35d0eOd8mBcXlrqjnAsFKRUv/fa/cpLrwPscic8QAXrtvF4GZUHLubR
	CQ4PwREYlArErP8J/A7sv1RywxIW6x6Z6+CVhhFlbbiki7K6CEgaHhz4o5snftqV
	7+jLxzlRYK4l0DmKOgdC1ACHEF+wNnPbpQDoK6aCH+rDmsmRlKjxiZVk8A1gPGFh
	HFKk7rXP5pjQhSFEIb0YE6TNB5zN0px/5wIfHf5hObZfoD68CPJ5VTw85OJw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1721996372; x=1722082772; bh=Qk3A039ivyzhONKQghmlPyCFKQHu
	ELNJHfjZWLcVy5s=; b=tJHwFigdNrPHL4HZPjRUCHqGCtogtbcOzfcOL920n4gH
	0dPTYIz93xwhz7S+PVlcS2pXl/Fv9LIz0iI4Qgpfu3wx6snuKXEtlKJF7DRSzN7i
	hCLeCBK5ImEkPoXBvr0Bmeq8/LgijPJpojL62vjLNPFWf+t2icHTYN2pfoJHY0rR
	1KsDVmYkhBfbTP/SOT/7TwSGpx9xE6qPHwOSvo8L9BZKP7MahQyfgc1aFyb5qMSU
	5tnJnAgpHBY3j59+Fl+jhzInfjYBbydVJ/NWQI5RzoSlzqrUyoyVWGCqsBiB69uu
	ckoqgDzhsptdTKSLQfZ9IROizHkqJzpLmNAb7w5IKA==
X-ME-Sender: <xms:VJSjZm4PokUW-qbRXG2IpBe0C7hr9eW5ZiIxbsAz1GxKg8vIUnXBNQ>
    <xme:VJSjZv6BOyVA9JLoWPuwTr3ieo_tJnvf6IYwIkVGjXFAyqJ9e0w7tdbyvF-NOyQis
    2e2OGQB1Lpss5km9A>
X-ME-Received: <xmr:VJSjZlflqGIXkS124G0XfDCzqCiNLay54aNGObpJNO84hpih16u1n2m7AcGOBBBEqhQ9EZCN8waGgLjXW_bi2qQ-7ShcGecdfk1vpfxNVJdj3YQ0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrieehgdehvdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhepfffhvffukfhfgggtuggjsehgtderre
    dttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhk
    shdrihhmqeenucggtffrrghtthgvrhhnpeehgefhtdefueffheekgfffudelffejtdfhvd
    ejkedthfehvdelgfetgfdvtedthfenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgr
    mhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopedt
X-ME-Proxy: <xmx:VJSjZjI8DeMSNUMO__rcEjXTEL4D-mJnaa8DFB3WnmOkoU0OsyZGpA>
    <xmx:VJSjZqJRE6fzvh2Xx2mm8lTEj_RZs61EKHdH1viF1i3MoD6_cfOdEQ>
    <xmx:VJSjZkzqz7yCDprzI4hl_fHfZgktMWvBfSPnazUZCsR_htgHSJvuNw>
    <xmx:VJSjZuKbtInhUtyUmZ9CfPXeUvx0TXeJNExduZfgUp2t5z3PKLdFug>
    <xmx:VJSjZsjbqFkSV8kpL8E246YpUO_HihEUu_h1a2-qcKNYxeEtdSWU0vnO>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Fri, 26 Jul 2024 08:19:31 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id 9516ce33 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Fri, 26 Jul 2024 12:18:11 +0000 (UTC)
Date: Fri, 26 Jul 2024 14:19:22 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Subject: [PATCH 23/23] commit-reach: fix trivial memory leak when computing
 reachability
Message-ID: <60aef16aef5e5733d449b3e9fd1a8816b5d82c27.1721995576.git.ps@pks.im>
References: <cover.1721995576.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="FztY/6PJ9ZhMIo3h"
Content-Disposition: inline
In-Reply-To: <cover.1721995576.git.ps@pks.im>


--FztY/6PJ9ZhMIo3h
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

We don't free the local `stack` commit list that we use to compute
reachability of multiple commits at once. Do so.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 commit-reach.c             | 1 +
 t/t3201-branch-contains.sh | 1 +
 2 files changed, 2 insertions(+)

diff --git a/commit-reach.c b/commit-reach.c
index dabc2972e4..02f8218b8e 100644
--- a/commit-reach.c
+++ b/commit-reach.c
@@ -1227,4 +1227,5 @@ void tips_reachable_from_bases(struct repository *r,
 done:
 	free(commits);
 	repo_clear_commit_marks(r, SEEN);
+	free_commit_list(stack);
 }
diff --git a/t/t3201-branch-contains.sh b/t/t3201-branch-contains.sh
index 800fc33165..6e587d27d7 100755
--- a/t/t3201-branch-contains.sh
+++ b/t/t3201-branch-contains.sh
@@ -2,6 +2,7 @@
=20
 test_description=3D'branch --contains <commit>, --no-contains <commit> --m=
erged, and --no-merged'
=20
+TEST_PASSES_SANITIZE_LEAK=3Dtrue
 . ./test-lib.sh
=20
 test_expect_success setup '
--=20
2.46.0.rc1.dirty


--FztY/6PJ9ZhMIo3h
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmajlEkACgkQVbJhu7ck
PpS4IQ/+IqQVZnRsA57Pbq5njmiDpVSqF4on5ZW3QFXlKvMRU1nNaz74mlNk6BIT
w3ezVcoYZZEDpdo6wQoYVzPsi8FRFqvWzj9vTMhx7meTKIzvXHpqgBRlD29tskwl
w8v/18OBURpl2bDLTgH9WAy4UQAVUZVsGpIt7DIArchPq01bwt8Bo2I75vT4pqEU
p2LEnkfFasHhzSkPCLTKDvwc8ayONKTF1MM7SBMkbIrbO/qMh+arekeFRx+WgwXR
9FNDfTTF2vBqeyqqZm75XYRjjWO4+I33RAc9/pRLIvPiN5OgwoJ636Z8+xujQ6hh
0fk/S5pdwGoBTZq1S0B+S3wCgYZ4D5c5h865Dv4NUa2Q68L3Eh7LTcYCICkYRUKR
/URTbPyiL68bTFqg2jEbfW3MwUEK7DbdhpDRZfznx5thgROll4+fFIBi4GUNch+W
xAgL5ve6VhqAEhoW+ISudmLHzD02XP3foP+e+O7IAkBGLaHiNtgtLus4T/LBxIbF
XUmObAdEaAkWic2DLekpeis6d5FtWvf9b/6Irn8ZYHgvSAId5M6aEUbNRHYwkREY
+FkRgNyRP2Qp+OnczqSepkctBJ7ih4M1mUiHYO2MFxt6P4qhv+TEiLiIjDmNcVPR
4ThOzKl48EevGoZplK/GL9qTZrjSqogb7msLNCoZnFB4d5j54RI=
=3HHh
-----END PGP SIGNATURE-----

--FztY/6PJ9ZhMIo3h--
