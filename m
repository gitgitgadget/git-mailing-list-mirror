Received: from fhigh1-smtp.messagingengine.com (fhigh1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE3FA178378
	for <git@vger.kernel.org>; Fri, 26 Jul 2024 12:18:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721996311; cv=none; b=cXi6sox1xueZuws+eZZeO4V20Ad+VXOaseAsQxDN7q3m09sLXwlHxRIbY+f6KyS0y8r6lTiGSTr/8GhLvFvWOT8gqKghBRdVuv+je0UccSrZpMOE1FOjUPf08Tu6sfyJqfEjVDp+/Ne+ojQ6oVgpUKUu0abaXglbx1APUfwtiLU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721996311; c=relaxed/simple;
	bh=VSMVoLaOwb4c7TqovyHrWoMNA+yjYsrwsrq7jnbHqs4=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LsYN97d74C2D9f7Tlk3vX+fmIwrDivf8ehWb8L1pr5kvjy5yZWnihbavkTFskpCAe4c6qgduAv0SY9ao6GyaryP8D0oLCTbkIiuB+Qkk0NxM9dXFaOzoeFAa3iFm4pRBSB/Zpd1GR3VaAWuGArHd9CXfCMzW0B0qib6Q3QYALQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=hpJlDCdo; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=krfrDc01; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="hpJlDCdo";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="krfrDc01"
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 3A8D91140205
	for <git@vger.kernel.org>; Fri, 26 Jul 2024 08:18:27 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Fri, 26 Jul 2024 08:18:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1721996307; x=1722082707; bh=+jvOCnjYNP
	IiMupll4cxgNbJsKoHW0mYAcAEiEZfWwU=; b=hpJlDCdojktQTEW5KNbKAWzOJT
	7CZTXvkZBkIFZYNPXzJzJhWbjRhEQ8A41ioF/7Lc8/EMWI694NHA1PY6dbLCM/cF
	/kJPQH7sFsqJDabMrVCRQuI9UdajKDURMziSPZoIutjM4VSv0xhgZfKUYIjOkJ/5
	o4pUK0gOZ+uUgUSRNbjWg7v8L5U3kYVx7goNOZqgeKkURO0JHcsc8SqgAqqKc93u
	+BqBA+8zKWcJPcXPBXbeUz9waGBuRvUZVXIUa6TrbqbcW3J5G50g/ydfc6EYlfwx
	xit1ZiuZzgt1o0pn+EuJ57ik/JSNIcqpb0PG+COH9kx6rHgC4sJZNAWov6Ag==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1721996307; x=1722082707; bh=+jvOCnjYNPIiMupll4cxgNbJsKoH
	W0mYAcAEiEZfWwU=; b=krfrDc01fAe8ftcMsRuEYIik5Jj7g2Cmtp7PiNqqMjkN
	KVmzi6rjL0wvI7b3I1sejnBiEV0DS9Tr1rjj53YseihJwo6v+cWLFfA8DpeQPILR
	0RLYu2Ca2F/4/xfGm3CDummzd8qA+KjwR8q2N8guYRQndKh/svMwItwp00Zh+8pl
	VxcqM/Nh/vRZDfB+Ls8lflIwYuP4Ga6IKWWLGBoXmoWolGyQjI6Odtnk01WmRdX9
	MEOF3WYczyyt/ZN7K0UH5ALNz0uEfm36pITYbRurcAaB8GL86tM5MU9CGuJ0L3b3
	OrblenUbKqY2H/JWaEibxVEFP7y9ZM/F5oYkyjEvaw==
X-ME-Sender: <xms:E5SjZmez64wOvDfVDNi2bTQGrvYG-miH4utSIxNpcZtqkOaeTeXpYA>
    <xme:E5SjZgMJdMCfc17oXgurzv3QGokCzEGSgry7Wis6MJrUyyCEA4eR21Ro1CO_LKLei
    m2B5NcnkbCV0U-_4Q>
X-ME-Received: <xmr:E5SjZnjgpBEPbltG0f7THZ52pbbMoO3yZ_6o2Rj5hUlGbf2tF2_ihQjdELbv1f7JXsEV5Theg4atMvHkUNIvBw5UnB-0IpVWkpAdyZ1FwmFxiLyz>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrieehgdehudcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhepfffhvffukfhfgggtuggjsehgtderre
    dttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhk
    shdrihhmqeenucggtffrrghtthgvrhhnpeehgefhtdefueffheekgfffudelffejtdfhvd
    ejkedthfehvdelgfetgfdvtedthfenucevlhhushhtvghrufhiiigvpedunecurfgrrhgr
    mhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopedt
X-ME-Proxy: <xmx:E5SjZj_PYugF9mn1D8GIBVBRVi9j1loHoUo14XoZZ1s-BsCsgbzN8A>
    <xmx:E5SjZiucnKTSs3hd-Xlwo_tn1aAJdbBcVFIvJHa0SF5rtD08-bsh6Q>
    <xmx:E5SjZqG8h43eZdvIYFASzFQslAVNxv-HZVoJ_aFTzTc0ibfQFGoXDg>
    <xmx:E5SjZhOITSvSZ1pmxWsNRUcbAooLuz5SkhkwirPLfnacJgj6AfWUsg>
    <xmx:E5SjZnXj5oMjiXOCcMOQyCQBc2OJ4ufHJn5NGF8uWEo-4MLPZyoVIuX3>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Fri, 26 Jul 2024 08:18:26 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id 6e0b7603 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Fri, 26 Jul 2024 12:17:04 +0000 (UTC)
Date: Fri, 26 Jul 2024 14:18:14 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Subject: [PATCH 19/23] t/test-repository: fix leaking repository
Message-ID: <7564911d2ad5332ea1f70b51868585819e895b06.1721995576.git.ps@pks.im>
References: <cover.1721995576.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="mmXbK2gcNBd/bfFC"
Content-Disposition: inline
In-Reply-To: <cover.1721995576.git.ps@pks.im>


--mmXbK2gcNBd/bfFC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

The test-repository test helper zeroes out `the_repository` such that it
can be sure that our codebase only ends up using the supplied repository
that we initialize in the respective helper functions. This does cause
memory leaks though as the data that `the_repository` has been holding
onto is not referenced anymore.

Fix this by calling `repo_clear()` instead.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 t/helper/test-repository.c | 4 ++--
 t/t5318-commit-graph.sh    | 2 ++
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/t/helper/test-repository.c b/t/helper/test-repository.c
index c6a074df3d..63c37de33d 100644
--- a/t/helper/test-repository.c
+++ b/t/helper/test-repository.c
@@ -19,7 +19,7 @@ static void test_parse_commit_in_graph(const char *gitdir=
, const char *worktree,
=20
 	setup_git_env(gitdir);
=20
-	memset(the_repository, 0, sizeof(*the_repository));
+	repo_clear(the_repository);
=20
 	if (repo_init(&r, gitdir, worktree))
 		die("Couldn't init repo");
@@ -49,7 +49,7 @@ static void test_get_commit_tree_in_graph(const char *git=
dir,
=20
 	setup_git_env(gitdir);
=20
-	memset(the_repository, 0, sizeof(*the_repository));
+	repo_clear(the_repository);
=20
 	if (repo_init(&r, gitdir, worktree))
 		die("Couldn't init repo");
diff --git a/t/t5318-commit-graph.sh b/t/t5318-commit-graph.sh
index a2b4442660..2916c07e3c 100755
--- a/t/t5318-commit-graph.sh
+++ b/t/t5318-commit-graph.sh
@@ -1,6 +1,8 @@
 #!/bin/sh
=20
 test_description=3D'commit graph'
+
+TEST_PASSES_SANITIZE_LEAK=3Dtrue
 . ./test-lib.sh
 . "$TEST_DIRECTORY"/lib-chunk.sh
=20
--=20
2.46.0.rc1.dirty


--mmXbK2gcNBd/bfFC
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmajlAUACgkQVbJhu7ck
PpRd+w/9H6cJjHPh2T7SYMvbFnsMUhah33tsssKR5FFRp6D6dMnPNw1M4UEE9RMA
EJEpqlmLrIb8FM7d/PWGEO0lkaOhKoxCcDnb0WntMbPQva/KyyC/l+y7MtpzcUc1
CmXH5ZkHknyEwhCHIvs69vViYWRWTd6j45HZcEZ78gDUDdUpyD3aqW1k6Du3QQW0
QxjrcLHv/QgJ2l0jJRU6mn6C0dTkqkQ2z3Z+gHGddoB/p9ozluSr/ElZHKPjmc8O
Yx6570IiKRqYLmc6hzUULk43wYtWEH2R6k17TxsXbepN0Mh2Nc6ZWhePwsEQFblP
8ZZ3uaWPgh1bo2OaOBzWCSeAcVe//3nbVgYf6O4vGMCWcQmcvPfdEE/zyI0KLJ2k
k5hl1JoUflQARzPfIntYvyKwTdmIlqKlqakFfxT5nSEWQzGigvzjFT+DIoFbl4bG
ZkLMPqw5r66tPceskqLSsa/jCYMlciJ2ZzWBzk0N3fBjIjjqQiOe4Au/c6VgG6xk
6ytxBqTOhOPhi6PD7laNEeI1hh9NI8fD7NVAE1KF+o8E6Ns3QY6J70+eDxNHDGa8
j4Exprl8MF9ZI27CY5pbjQTlr1uG0BnkUCyKeuVhYjB5wSLC+iMPVRhJpeCbGIFo
jqyjsU3XOQCDfxkhwtklfZZyH0BA4bbLhtoj07h2wKa3ah0A8Hk=
=4q//
-----END PGP SIGNATURE-----

--mmXbK2gcNBd/bfFC--
