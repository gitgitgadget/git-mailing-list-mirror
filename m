Received: from fhigh4-smtp.messagingengine.com (fhigh4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1274915FA84
	for <git@vger.kernel.org>; Thu, 18 Apr 2024 12:14:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713442464; cv=none; b=A14WKHIWFwyZ0TTNtcyWz48iyfnNivkgjWEVYGonZzjxEnEBpBEPphx0Akbr/W8SWwWfNoB7obHEw8NdYOOW8eqIjLhvu38ZTlNo2W/CB39Z7cCcMOVhVc14zSkUZ9J23pMPqbuvzaQon/7wnqSrlr7GVjWZhGIfpR29dcNiAy8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713442464; c=relaxed/simple;
	bh=6HFwFL7ECQrniQUr8ZvO6D2hLf1THGA2FFHYc3I6x24=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VVpgByhKWNERliRFU3I5oupmkVeaU2Y6qmP4wlb4pkEAbFBO2jgKjMqgZdMGumQG5nxvANBu/ldC+e2m4/qiCFfrcAb8oDo8wKZO3odBFxYC6vw6XU31TjFrT0Ob4yB9ozzxYQp5WBEEXEWRj0eoF68mdDpCRAjp7gDpt5GHWnE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=d1+52Mlo; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=N6cbN0aI; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="d1+52Mlo";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="N6cbN0aI"
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 2BC2911400E5;
	Thu, 18 Apr 2024 08:14:22 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Thu, 18 Apr 2024 08:14:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1713442462; x=1713528862; bh=jb0t30xIzF
	2bE4pV9COXae/GA8rHO9O/iYCgg15mKeQ=; b=d1+52MlopQPZKjkGQ458lxUOR2
	1RfVUxdWt/SoEfc4GQntCpOms923oYLvbvfD/uietH5ygUgD86tzqOlvsfXuDNgY
	ErFqG4l6qIVl/nOQYgphFU2TPsDmBQjISeRlKARSctpHo3n07RSrTEHAt/hQptjv
	evVbuDaalo5kQ0L3zG1ndS03045KCH8Z1Xgahf7yl4LnzmpEZSgH6bSvT0rfpfow
	XyUc9nsMTxTpLv53N3BrBT5c+AE+Wom0VqNMduUmD6ziBUgSPBkBvxaGmAlrqyIK
	rlTly5Rb1KnRhj/MtZZWwXI5NAGB0SZI/4n0X68GBkqZjhIG62oU9PJZrunQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1713442462; x=1713528862; bh=jb0t30xIzF2bE4pV9COXae/GA8rH
	O9O/iYCgg15mKeQ=; b=N6cbN0aI/GdVIJu2QRVl/6bS87I+LSkSV/SUUrWb5mKT
	N19x2fYLOk3Ic+K5irXH4RS88VrYAY8+f+rVS7WzZ4xvcYPmpIi/1egqvfYl5Abj
	Ku8KUQFfk16QThg2f8MloPMfplqv9YdI7g7luIAEvZVz6nNHDyUFdH26zx67PkKL
	h4DaUaf6/blpYBDK9/cDCatXjoNtXiXNtDd6z57WN9wM9ytRDINST/dlI9EgUBFY
	tc7P3R3rPgE9bJm8NjvrNzgXhVz2xjDwL5JbjBYw/8p0Fd9FoioS0SzhykghlJE+
	BR6rBwqfw4ab1UHjabppoNN9V5+2BxQT7ncmns5ytA==
X-ME-Sender: <xms:nQ4hZh0-TLOBUvie9eTvfhBrO52RxVUzGdxguFmm_yLaPxBIOHBX7A>
    <xme:nQ4hZoGc9odrmONl6ZaZinTdjGi0l3KFB4O38VbNSPFo9UXmTblcYQKWUMc-2Wb2i
    _pV9KHpZpPb0bCOZQ>
X-ME-Received: <xmr:nQ4hZh7h6JD2XsKB4-wCir5oTfpnQgnV4muxEr_aQpz4B7eSQTX5rcum8TWTXpeL9Ul2dSE66fQXQ1Aw7h2cT9OV8w2ewug4w0A8SwAkKP8TrnXTOw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrudektddggeelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepueektdevtdffveeljeetgfehheeigeekleduvdeffeeghefgledttdehjeelffet
    necuvehluhhsthgvrhfuihiivgepudenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimh
X-ME-Proxy: <xmx:nQ4hZu059L3lSxQ-0h2oh1ZDZf3J8Xm3aXWgb8Yb_dt8xEOz25c7Qg>
    <xmx:nQ4hZkFcx3U8MFewWfBnCLlFv6W5wLy91kO1iZkqhZnm3y4tOFhd-A>
    <xmx:nQ4hZv9Jly1aicwxyZKOdP8_d4p8-01VTreatNLRl12I8lL_zs8PsQ>
    <xmx:nQ4hZhktlyF4JQegM46oSQFoMgjWLHlQiX4T0lFuh7ykT0VyUyN52w>
    <xmx:ng4hZgjmDZrOqcnEwPgJYcLmlFK5Gh-YW1cvR2wcCuJTEXTb5nE5oJ3Z>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 18 Apr 2024 08:14:21 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id 15011bc7 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 18 Apr 2024 12:13:56 +0000 (UTC)
Date: Thu, 18 Apr 2024 14:14:19 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>,
	Phillip Wood <phillip.wood123@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 3/6] repository: initialize index in `repo_init()`
Message-ID: <416612e7e31a4b055b3fe17a5cdf78f8d07bd9e2.1713442061.git.ps@pks.im>
References: <cover.1713180749.git.ps@pks.im>
 <cover.1713442061.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="nlA2dELAdBTWwIaq"
Content-Disposition: inline
In-Reply-To: <cover.1713442061.git.ps@pks.im>


--nlA2dELAdBTWwIaq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

When Git starts, one of the first things it will do is to call
`initialize_the_repository()`. This function sets up both the global
`the_repository` and `the_index` variables as required. Part of that
setup is also to set `the_repository.index =3D &the_index` so that the
index can be accessed via the repository.

When calling `repo_init()` on a repository though we set the complete
struct to all-zeroes, which will also cause us to unset the `index`
pointer. And as we don't re-initialize the index in that function, we
will end up with a `NULL` pointer here.

This has been fine until now becaues this function is only used to
create a new repository. git-init(1) does not access the index at all
after initializing the repository, whereas git-checkout(1) only uses
`the_index` directly. We are about to remove `the_index` though, which
will uncover this partially-initialized repository structure.

Refactor the code and create a common `initialize_repository()` function
that gets called from `repo_init()` and `initialize_the_repository()`.
This function sets up both the repository and the index as required.
Like this, we can easily special-case when `repo_init()` gets called
with `the_repository`.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 repository.c | 28 +++++++++++++++++-----------
 1 file changed, 17 insertions(+), 11 deletions(-)

diff --git a/repository.c b/repository.c
index e15b416944..d64d15d952 100644
--- a/repository.c
+++ b/repository.c
@@ -25,17 +25,20 @@ static struct repository the_repo;
 struct repository *the_repository;
 struct index_state the_index;
=20
+static void initialize_repository(struct repository *repo,
+				  struct index_state *index)
+{
+	repo->index =3D index;
+	repo->objects =3D raw_object_store_new();
+	repo->remote_state =3D remote_state_new();
+	repo->parsed_objects =3D parsed_object_pool_new();
+	index_state_init(index, repo);
+}
+
 void initialize_the_repository(void)
 {
 	the_repository =3D &the_repo;
-
-	the_repo.index =3D &the_index;
-	the_repo.objects =3D raw_object_store_new();
-	the_repo.remote_state =3D remote_state_new();
-	the_repo.parsed_objects =3D parsed_object_pool_new();
-
-	index_state_init(&the_index, the_repository);
-
+	initialize_repository(the_repository, &the_index);
 	repo_set_hash_algo(&the_repo, GIT_HASH_SHA1);
 }
=20
@@ -188,9 +191,12 @@ int repo_init(struct repository *repo,
 	struct repository_format format =3D REPOSITORY_FORMAT_INIT;
 	memset(repo, 0, sizeof(*repo));
=20
-	repo->objects =3D raw_object_store_new();
-	repo->parsed_objects =3D parsed_object_pool_new();
-	repo->remote_state =3D remote_state_new();
+	if (repo =3D=3D the_repository) {
+		initialize_repository(the_repository, &the_index);
+	} else {
+		ALLOC_ARRAY(repo->index, 1);
+		initialize_repository(repo, repo->index);
+	}
=20
 	if (repo_init_gitdir(repo, gitdir))
 		goto error;
--=20
2.44.GIT


--nlA2dELAdBTWwIaq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmYhDpoACgkQVbJhu7ck
PpQAWg//c3d/+nFzBdXojeXHSR5hG/gbjL9oA1o4Iaqoa9omXUduuRDLKUFtBQLN
CdTCLplPH7xmD2fa7G/aCJ5xX5DO8Piq4SKRPpSLI7j2CXR3t6J+tLkOcAp6Fv5M
aWz7NlLhaFYuMCOxNwh3mJ7SRe9g4xq3rYHOvpKH21DNv+SS4SPZGwEu51fdGRCc
hOSgdXJqexAGqt9CsROpsOuhSRFnGBo74oSaing3/oKxb0PjTWIXrp1v56SQKU/d
D3Z3sjO2mHVYYFh68NrgJ6iNUXBW1TcX82kAmfgW2pEfnW+14cvJ5b5eNRNUuUrb
rDvsn0haKGMkFvjK0ZAbF9Ifr025UPe60z76MJW7lRG+hQM/VwCHng7WsQV8e16p
udfHJ0Az/y1OGPp2E7+RD1qxforksnskqddXxotJ076T4n+BQd6oXvESHfdP8W0M
eK+kezaAkcdgLnfuLHvYYwSE7T2uMRzKhta3kHf9MTz9w1nB3UpmppBGD+ShNt4o
MGZnQnmloswsLnvrY42J0OODzL5cO+g6GHOwZfuBt0kLmQmG8+h8UkGhAMdaIKy7
nz5usDHYUkBtAMn0LX3v1Qv4JXo6RvunkzO8XDjGI+iP10YqKI6IFqUl8beoBVWZ
JwIKl4IGM1BR07WQkIcaAUAWbLmxm0IbDh/ibaFQjnCSKgn4WRA=
=lFPe
-----END PGP SIGNATURE-----

--nlA2dELAdBTWwIaq--
