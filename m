Received: from wfout3-smtp.messagingengine.com (wfout3-smtp.messagingengine.com [64.147.123.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20D98176FB3
	for <git@vger.kernel.org>; Tue, 11 Jun 2024 09:20:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718097639; cv=none; b=KmGhdahcaQxpfSHH9Hj8jJyh1X1IfkBhIC3UO7q+IuLs13MSeDDkZ95vJPrNqAB8UHVrgWcALyQWa2At6zLuaw9jB9c7JZr/U0ca65XON60f4zWQMa37HSMkh8FSjar+faVDDBaquGsbrrPE8fKJ3HymnA7SdMSxTcSEs8V2wPI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718097639; c=relaxed/simple;
	bh=IgpK8VnNAoedFHPRMwn8/FOOxyfIWiBrr8sNvKEPFJU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hC0fgEdys/Y9JO1qHh46KrjOG/FYCZMerEBxpQDB9UaRmkt9tkjxFofK0Vf9dQ+kPo0wFiV7vmH96a3XzRHJD8FEDk0pOunobPYt3271N12YwBrQwo+aoZewfc+uFe95R3jfyHOy1tdCXFqKdF39pG5POMiFi9ppBTHNGiyey3A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=ca62qwzl; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=U6iP5GGI; arc=none smtp.client-ip=64.147.123.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="ca62qwzl";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="U6iP5GGI"
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailfout.west.internal (Postfix) with ESMTP id 4F3D31C00124;
	Tue, 11 Jun 2024 05:20:37 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Tue, 11 Jun 2024 05:20:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1718097636; x=1718184036; bh=sG9aqnVpt5
	O3dwsinqouyK5rweO4fHbY4Uh5BOYIhas=; b=ca62qwzlXEwUehdYtvmKBdOY94
	W/sG5JPmXZsC+LwYM6krCJrM00P6rqyi2kl16NrvWpKganZ+BJBQjpA1ippybdI6
	y+GOk0JolgU8OqzKwBe18wJI9kS5jWefXf/cMF0gbzuLCD2FXQmOW5ADrob5fNxI
	u0U94sOQ2dNjKv/U2wbqg9Eo77Cml+OCbGAT6GH/CXUNCy4Fz9aWg7AExuQX/O3/
	8Fbpm5o56LPV/HKTpiO3IEGAeQu/ir4J3v9rie9sJGdbMuxFheeX3jz/1dSZ7YDq
	OkS6W/ZQ7epzEvwHn45M82o4BiXZjH1SGw+Zd1gsTN2XxcEd7CbmP1bPOamg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1718097636; x=1718184036; bh=sG9aqnVpt5O3dwsinqouyK5rweO4
	fHbY4Uh5BOYIhas=; b=U6iP5GGI9haj6U5xQTHem7o+NVxbPkVwa11cFSCq3mZ1
	KFpxcp4VpU7WdtAwiGEAuzzYbyQI0cwnxQFoIyUiE5bZPHevWyYyOcujo0vZyFmT
	NxzVpSiRyAu0OBbsd7yiEQLRmy3kREHBORJyjqpSMBeMlE13IaIjbtRc0++NIU1/
	aYuHalsISPXH0RKof/T1g6dVnFic6CpjSK4ugQmhgB6cB2vDFR0FdrkCOlXl5p1E
	DDLY8bR79xe5o9fU3T4coX3CAUTURwXIHn05tyZgMd/90nItZjgYB3DufcpCTJN/
	948QgyysyL/sv7oei8dGz8DJTsZkm93HN7HrVkHnrA==
X-ME-Sender: <xms:5BZoZgg0EHHEDhF3_GE5FXIiGt5ch9ZlHUXxpzAFcONTnejYYckx8A>
    <xme:5BZoZpBz--H0iLZLzwtKVXgZ1BsVtR9fEIlbO1P9WpFgCzgUaq7Uwy1vUuvSCt1SJ
    dOkAvdvU_Mh6FFe7g>
X-ME-Received: <xmr:5BZoZoHsA4IRhYS78MtbiRZQkvVdbvmchJDANvlAmWJ_XvnPFTiCGj677SSr6nQ_O18846S0kARYY4pFE2zTIQGwzcqaz7wZqEAzNNxso11bfTtLJc4q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrfeduvddgudegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepueektdevtdffveeljeetgfehheeigeekleduvdeffeeghefgledttdehjeelffet
    necuvehluhhsthgvrhfuihiivgepfeenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimh
X-ME-Proxy: <xmx:5BZoZhQF9wsAuZjIUXTBa8yTFqbGA3EfSxcyUT-ZX-dq13KPKmDLWA>
    <xmx:5BZoZtzlcEmsrMpNFGUPG7rwFQeshTLsyeBuZTTGLKF6Rjer4eXdYw>
    <xmx:5BZoZv4iTONuLoLoKSnoJ0TeuVeMfF3Dxa7gl30cAyddEbmwHBtGsw>
    <xmx:5BZoZqyroCf7WowKsYio797d2cT8HCSwFcleyM8K3kTMr9kIUaPCcQ>
    <xmx:5BZoZl-q6kxIBiE8CwjJgAY1U-27o1yj6_hunu8QSPUYy9HwwHtCEQvZ>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 11 Jun 2024 05:20:35 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id 6d6221d2 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 11 Jun 2024 09:20:27 +0000 (UTC)
Date: Tue, 11 Jun 2024 11:20:33 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Phillip Wood <phillip.wood123@gmail.com>,
	Karthik Nayak <karthik.188@gmail.com>
Subject: [PATCH v2 17/29] rerere: fix various trivial leaks
Message-ID: <7d73c50872bbc080689b983312879af77312a708.1718095906.git.ps@pks.im>
References: <cover.1717402439.git.ps@pks.im>
 <cover.1718095906.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="lHDyafbFJ6UwAtBY"
Content-Disposition: inline
In-Reply-To: <cover.1718095906.git.ps@pks.im>


--lHDyafbFJ6UwAtBY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

We leak various different string lists in the rerere code. Free those to
plug them.

Note that the `merge_rr` variable is intentionally being free'd with the
`free_util` parameter set to 1. The `util` field is used there to store
the IDs of every rerere item and thus needs to be freed, as well.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 rerere.c                      | 3 +++
 t/t1021-rerere-in-workdir.sh  | 1 +
 t/t3504-cherry-pick-rerere.sh | 1 +
 t/t7600-merge.sh              | 1 +
 4 files changed, 6 insertions(+)

diff --git a/rerere.c b/rerere.c
index c7e1f8fd25..10382da55c 100644
--- a/rerere.c
+++ b/rerere.c
@@ -849,6 +849,8 @@ static int do_plain_rerere(struct repository *r,
 	if (update.nr)
 		update_paths(r, &update);
=20
+	string_list_clear(&conflict, 0);
+	string_list_clear(&update, 0);
 	return write_rr(rr, fd);
 }
=20
@@ -912,6 +914,7 @@ int repo_rerere(struct repository *r, int flags)
 		return 0;
 	status =3D do_plain_rerere(r, &merge_rr, fd);
 	free_rerere_dirs();
+	string_list_clear(&merge_rr, 1);
 	return status;
 }
=20
diff --git a/t/t1021-rerere-in-workdir.sh b/t/t1021-rerere-in-workdir.sh
index 0b892894eb..69bf9476cb 100755
--- a/t/t1021-rerere-in-workdir.sh
+++ b/t/t1021-rerere-in-workdir.sh
@@ -4,6 +4,7 @@ test_description=3D'rerere run in a workdir'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=3Dmain
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
=20
+TEST_PASSES_SANITIZE_LEAK=3Dtrue
 . ./test-lib.sh
=20
 test_expect_success SYMLINKS setup '
diff --git a/t/t3504-cherry-pick-rerere.sh b/t/t3504-cherry-pick-rerere.sh
index 4581ae98b8..597c98e9c5 100755
--- a/t/t3504-cherry-pick-rerere.sh
+++ b/t/t3504-cherry-pick-rerere.sh
@@ -5,6 +5,7 @@ test_description=3D'cherry-pick should rerere for conflicts'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=3Dmain
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
=20
+TEST_PASSES_SANITIZE_LEAK=3Dtrue
 . ./test-lib.sh
=20
 test_expect_success setup '
diff --git a/t/t7600-merge.sh b/t/t7600-merge.sh
index e5ff073099..041f1077b0 100755
--- a/t/t7600-merge.sh
+++ b/t/t7600-merge.sh
@@ -29,6 +29,7 @@ Testing basic merge operations/option parsing.
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=3Dmain
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
=20
+TEST_PASSES_SANITIZE_LEAK=3Dtrue
 . ./test-lib.sh
 . "$TEST_DIRECTORY"/lib-gpg.sh
=20
--=20
2.45.2.436.gcd77e87115.dirty


--lHDyafbFJ6UwAtBY
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmZoFuAACgkQVbJhu7ck
PpRHCA//RBw5QbFehyy1PPZ9Efd4QohAy3e6m36DYsAj01tFfkF2ke7j1lMusVy2
9vnqI8A/jG5MRXxdGcPYzYkbSJrJ8oddodlTH7BrsJWFDQF4LG+npP1VVJt2aSbo
u2gHA4sH7frxLjc+3HXCBfKskFyT03k9EW711V/WG5/rUCrxuj8euG5qYvWVim/x
p98IGX5nSiYzdDKUIouaDjtLDCv8xiCjcQnSpmulAY9+Wg6s++Iiq7EsXJQy/x3U
qqi/rTnY3kJsbMKYIrR/S+DV+2vW5pR+zhUi+ReKkhpTO5Lu0MDH/Lwhq4vqfnJZ
ur34EKSNFxFz1jbNer46J7k9HhuyrdtIA+KvgWp/LMDKwxCX00B3vMaKXGqC1qN3
xfOHQ6u+iw+DVt9IaJtBhXLmg+GKiyqxKPS6uA7n7k2o9aFBZ9osEpMVLTiNLtEK
iBKvyMYj8SHOF8++aLMGJG548Rh82SsOTc/grBdiOLjeWIIfzU9U+g5QG2yxfafK
MZYomRGyn6AWexf+nsgpgn2F+AbsTtsjx2XDI2tbtikR183Dhc7HwPFeb+y3m480
JvXmuYFKijLL8rvuOWgtcec/Jzlr474eTYUOrKAwqWLt0vMsl6hZPRnW7p880FSz
b/fKX85wqWI3beK84j2CCw9IhekoLyzi2Srhg8cCUeXi4wbeFpI=
=Cfgy
-----END PGP SIGNATURE-----

--lHDyafbFJ6UwAtBY--
