Received: from fout2-smtp.messagingengine.com (fout2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9528B5DF05
	for <git@vger.kernel.org>; Mon, 15 Apr 2024 11:42:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713181378; cv=none; b=EJrxHFYIkZrIsMMlcxL2K3EVFOrSZGmRp2uLZRtXY+JMXQ+lfwikar7LfWyckRcFPdvhlttersj6+JOsYW5LDwBD9VsPM036RnIzamsDFH/CCC+4TiobsclhYLFufzEUA9Oy0iqFe3NtxVqA6W4hPEu0VPJ4Iw3VeJI+f1DELy8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713181378; c=relaxed/simple;
	bh=KeD18e/QmaQVaVjMJ9BB1ZTAkzqfuILei6rDqXxT/Sc=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QQzZVyxw1qdJv9GJMUzt7kT339sXugE6e2my54df0sJzovtpCVrrHhRJ6TzXFr65hOLUk8brvoGFxLQN3rpAi28sOERDA6ClJUs8XONgHwZVg0tWvHtyXBIPK5N6qqOH6hHxfQwTWVzGo8gKPGhd7y3/9LBrA4X4bdasECWjAvo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=IsQHCbJm; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Hzcx9aam; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="IsQHCbJm";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Hzcx9aam"
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailfout.nyi.internal (Postfix) with ESMTP id A2868138082A
	for <git@vger.kernel.org>; Mon, 15 Apr 2024 07:42:55 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Mon, 15 Apr 2024 07:42:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1713181375; x=1713267775; bh=Z8qvWa+aeU
	zGwDvY62jxMV3DdVu8nyOdJeBCCqgFqiM=; b=IsQHCbJmXfI55ylRnWa07X8WQX
	EHJu5HwFX/ltV+mzpN33Lox3+xhg7j1TDPR1SW6IC2b+MMDmkMot5bUQqhIYeLLP
	/o9ohfjUDHa2bQmjb/ouoin38vRpAp03MaDnc886GRKr/mClxWjNGwLHzTjMzyCw
	lWQIJZ+MGmw0Adve201CsbcL5PVla7f9ZXB5t1LYL9ZYyfyzEOL5TMUobEnKfGRi
	HRyDLvC+3BhPXcSGtf9ZbvBeCQ5qPb4oaRRK9CdgiUwHDo+jKkBdDDqs7LJRIfrB
	Hzp8cib9fPMflQoNDYHh0X9LVjSrXCbS/3c75OUjPr0qmHH6Y1CvSd7QlJ2g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1713181375; x=1713267775; bh=Z8qvWa+aeUzGwDvY62jxMV3DdVu8
	nyOdJeBCCqgFqiM=; b=Hzcx9aamyZtGnsYd3OfmPa3Tb5Sho4PApwjSd+AAUNHa
	fmwFpyXgEKSRhEqZr6sNS/kCEXc2GOeWMP3u2/7N5WfQmSVxvdjYWkXC7zgCBmdm
	Xdk280ej6LN0dcyAJzD9FX3oEWOitqlvgq/WWKwAAzwbv9sAWx7VetHRsLnHQaFo
	mDcDTyflE1QNjLD+sc7V/PYaIvl35fRlIE4V6s5LqUlWgj4yWcve7wsmEevLbnuZ
	ewXjlu438CIGOQFwnwskaBO8fgVwkMRcUXdtLg3XVOOk7SxPOyB/TlRCN33jfIbI
	1ripD4Gf+CKU29GYTlwbMOMj7/2WcFahQvUkN0nXGA==
X-ME-Sender: <xms:vxIdZs_LIXWQvRjnAbr_ly0LUniKWIJPAqccqk5R4s5O0HmJBOwZGg>
    <xme:vxIdZkvdSekxPCJ79ZoSFXRQuPQqRzF6rDaRWehFiH9TcHk-ef7xItNsGtC-SOZSP
    UqaH9Iqryg0C9-GKw>
X-ME-Received: <xmr:vxIdZiDzyLOYdx_2TLM9gtyTtKPXnP2YX-s18Y3Ulv6dpjox7qmnwprKPQS4164FOWUGrJ_5K6Yw8uujsEbp5HAJqVreR7WISyr1EcngKwZpJ7fZcw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrudejvddggeegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvuffkfhggtggujgesghdtre
    ertddtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehp
    khhsrdhimheqnecuggftrfgrthhtvghrnhepheeghfdtfeeuffehkefgffduleffjedthf
    dvjeektdfhhedvlefgtefgvdettdfhnecuvehluhhsthgvrhfuihiivgeptdenucfrrghr
    rghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimh
X-ME-Proxy: <xmx:vxIdZsewYT3U9xOFliaA1VpTSSdwM7DTRvFyuYSlzevLXOtp_vLSAw>
    <xmx:vxIdZhPTIq0Uxq-FtYKNJ6KmyXgC9ztjhSPpUGKzZ77-ysSLeGEXEQ>
    <xmx:vxIdZmmN4ZEI8OYVubv3DiUwogmSDCEdvdHlAXbKPeghr2oHNgQFUA>
    <xmx:vxIdZjsdf58J_jR986l8cltqBRWzEjHwecuhXmiDSPNAubnYPTveGQ>
    <xmx:vxIdZv1tfddET1cxJhMIdB7yR1LZnnntZWaEn2H32kz30why7YXlckF3>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Mon, 15 Apr 2024 07:42:54 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id 2bd552c5 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Mon, 15 Apr 2024 11:42:34 +0000 (UTC)
Date: Mon, 15 Apr 2024 13:42:52 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Subject: [PATCH 3/5] repository: initialize index in `repo_init()`
Message-ID: <96256f9eb30e5aca632942169d5c311b1f245b40.1713180749.git.ps@pks.im>
References: <cover.1713180749.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="IHRgJaYXO+NQk2M8"
Content-Disposition: inline
In-Reply-To: <cover.1713180749.git.ps@pks.im>


--IHRgJaYXO+NQk2M8
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


--IHRgJaYXO+NQk2M8
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmYdErsACgkQVbJhu7ck
PpQP2A/+Lx93SStoc0p2TNuMERg7yo83dQFZ39z7KBAfIW+6oNzNp+e7wEjq/mCq
ejaHFqZyrWonmiblMy4zaOj/CI4xsbVmjHueCXHTH29nCBsYDd/qKuNT925vihP+
nKqesvxiDgmFnZ1Oj0UG2s79VejDqannwR2s/B6QbDBYDTfNvlxAM4IcAt2zU8xI
WVrxlHY1MlxGLO6v2RxG/MG88mLeQoYiTmgdfT/XCCU3vfk2fKn2OpRzu4dsWJOw
khtCT0X1vkTTEFWTmuEIb7NWBtgyFzutiyAREl3lGqUY5l+/zeg7obWDwRgsk2sQ
79y+MbE4a/23JmpDJzftL7jupi2tg31cH32qunuwRSX0h/IOLszaopoiZGEFjxpm
S4xa3n7nUPSoG7GVk2zl9jdbpl/dObHykcV1MfNVEEdxwFnzmC7bTAJJX3xlhaEQ
6DANyJKr+AMtyyfjhnaAtvDUUZVQEY5+qShp4UWYjT7ZA16K+h1zF7oPnw0vZCV4
E3PiXoJ4wT20VgGFd6KikOepvrs7YtutKbBcNQGUcwDd/yhogsrHo2z6r/dtHn1z
bapMesALn/1q4U4KdXxZBr/Q4s3UeeL0mPxUA86p5s7AnnpqBXCz9d3TuJY4oD9P
7XviuvOfgjRKhmeAtNMuzvvgFb/qwH05NAvPoPddIRqVEn8kc9A=
=5p2Q
-----END PGP SIGNATURE-----

--IHRgJaYXO+NQk2M8--
