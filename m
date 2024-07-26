Received: from fhigh1-smtp.messagingengine.com (fhigh1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7FC813A3F7
	for <git@vger.kernel.org>; Fri, 26 Jul 2024 12:17:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721996251; cv=none; b=MKCjeAGVd2jYFr/hN3jVCdQQEud+PMle+2vYMzUyEAWe9u6CKZ1MZOVqJK8V0a3NMwSXbha/Vyg0HkF8cdfmT4ODQEmgWIkYf13lM2kflT9Wa6g/QpkmWuZrAKNVL/xNqp2M+c1WDrS1W5PxUAJT0GqwiTMrnhn6cGpc0UlNU4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721996251; c=relaxed/simple;
	bh=azKWkYdVqF00t5KYj4MiWzSIbHKMmXsNteULm2hBAFM=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=g48P7eGaRcPuyF+oAz24AlbN/kAcl1HdU3ZVQrGxBJts1+UWllsj8VmTOzbYLKddJs36OWavErf+ADTlzzgqYI8H+4NfZryOutksy3iQiNfI9B5yy9KaRqkx/3kI1FbJdTGCKGSaCtjnGvwfhnpcaYHolM6fq95MzFgEMoyY+pM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=b776kiFe; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=UU9OzDl9; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="b776kiFe";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="UU9OzDl9"
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id A777911401F7
	for <git@vger.kernel.org>; Fri, 26 Jul 2024 08:17:27 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Fri, 26 Jul 2024 08:17:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1721996247; x=1722082647; bh=Igr5CR98E5
	ah2ppCkz6NIEDJMXMPQaj0XlyJqtEe/dQ=; b=b776kiFeeuIEYAF58wAn7y2OLU
	Udv7sAsu6D+tqoOlzQuEprfgaQpX2sAGwvG7951p33hqlgc7SGNcDI5TibMoNFO5
	uZQsAJaygSbefQH4JQkDiNIhK9s9fcPNhagzYTENSvvkh8U1OKYQdsDZ9rKOaHhf
	kFuAwPR6wtOU8yy4A/3sK6o+rfVDi6yi3XwWELd4sBbNNKyF4u+85WoqGNTVLq4q
	QAueMCuONiEQJQaV9p6HYpDs8vijxIWeyNsFItKFB0XC+51k4Ar6WalPKMIuKcF5
	dnrDpU1VrForp2SnQ8HoDs/h1f/14T/DyEWbmfdm6mY00DTfDBoahbuwVxjQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1721996247; x=1722082647; bh=Igr5CR98E5ah2ppCkz6NIEDJMXMP
	Qaj0XlyJqtEe/dQ=; b=UU9OzDl9+BMykyY8JbmfebtthUEL0zg4Hb2+d1oXfSIM
	+nF9c+osKT/IPOTnOh5tykAWFbRkUYS9J/d+Q4dBu9yKB9uAX5Dv3SB58o+dUfu4
	6aepXC8PylRVM5drM24sDt0AinaV8gojkpd/bJa9xM1nDVrKM2NUsPOToXhGOUXZ
	1+bzRVdaCeb6fuaH0hoHMqVgJNA5VdpLZD522O3u8avRNgXdWJyYg6WlFt6IaaTw
	qtuTgbO0vfIPopzVz9d0bXMnvZV5Cd4NwToTbEjhGwd/gAajAlm6VyHDHyR2m2Qf
	D2z+UHACxLdJNRBkV5jOvTZb6tBmVpreIESrsOIb8g==
X-ME-Sender: <xms:15OjZtxzpcA7vuyVTe6ISIagC3uicGpFSLKW8xCFRI3EA2NI0LSbDw>
    <xme:15OjZtQYUItVEqlLri_AQn414ZMuSeBDUBBKOyLJexfqGqNaxMp0qTN6Pbfg8HaYJ
    Tz1p1cTIWO7aZdMgQ>
X-ME-Received: <xmr:15OjZnViOfqRta0WIzHL9-RHicmJABAi8QZ8u9ZGN8HkFIE3Nn0TmA__jbTY7REqF3RRbqRp04WzkK4GsVr73koWE7cRNMG-hKgdfetZjVd7TZoY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrieehgdehudcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhepfffhvffukfhfgggtuggjsehgtderre
    dttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhk
    shdrihhmqeenucggtffrrghtthgvrhhnpeehgefhtdefueffheekgfffudelffejtdfhvd
    ejkedthfehvdelgfetgfdvtedthfenucevlhhushhtvghrufhiiigvpeefnecurfgrrhgr
    mhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopedt
X-ME-Proxy: <xmx:15OjZvh1o5cbGWHMupJf_vpwr4olrnt4PGiunmOuPD_1MO3XzjaPrw>
    <xmx:15OjZvDOeXmaZK2-mpqYNyNEik88HunxA-ZNUUXAPEXHRe7uWJsC_Q>
    <xmx:15OjZoJY747QfAzBeWnfY1sIxBvFkeWsIKeyrWOT_hM-nSAcNx4p_Q>
    <xmx:15OjZuAM46ufm1KsAQrgGl2axn_z51TGovoPVSCRmXub0Qy6IjXx7g>
    <xmx:15OjZk5IhkLvW6bzROLz3p3RlIbXr6Ns_lUN31ZxUjUhFgX7wss8QBDi>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Fri, 26 Jul 2024 08:17:27 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id e56b563b (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Fri, 26 Jul 2024 12:16:04 +0000 (UTC)
Date: Fri, 26 Jul 2024 14:17:15 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Subject: [PATCH 15/23] builtin/rerere: fix various trivial memory leaks
Message-ID: <6d49645c0f82420388a8ca3522b48982fc2fe92e.1721995576.git.ps@pks.im>
References: <cover.1721995576.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="a6LTOWm/sgAqFCLu"
Content-Disposition: inline
In-Reply-To: <cover.1721995576.git.ps@pks.im>


--a6LTOWm/sgAqFCLu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

There are multiple trivial memory leaks in git-rerere(1). Fix those.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/rerere.c          | 8 +++++++-
 rerere.c                  | 9 +++++++--
 t/t2030-unresolve-info.sh | 1 +
 t/t4200-rerere.sh         | 1 +
 4 files changed, 16 insertions(+), 3 deletions(-)

diff --git a/builtin/rerere.c b/builtin/rerere.c
index b2efc6f640..81b65ffa39 100644
--- a/builtin/rerere.c
+++ b/builtin/rerere.c
@@ -73,11 +73,17 @@ int cmd_rerere(int argc, const char **argv, const char =
*prefix)
=20
 	if (!strcmp(argv[0], "forget")) {
 		struct pathspec pathspec;
+		int ret;
+
 		if (argc < 2)
 			warning(_("'git rerere forget' without paths is deprecated"));
 		parse_pathspec(&pathspec, 0, PATHSPEC_PREFER_CWD,
 			       prefix, argv + 1);
-		return rerere_forget(the_repository, &pathspec);
+
+		ret =3D rerere_forget(the_repository, &pathspec);
+
+		clear_pathspec(&pathspec);
+		return ret;
 	}
=20
 	if (!strcmp(argv[0], "clear")) {
diff --git a/rerere.c b/rerere.c
index 3a3888cce2..525ed6cc1e 100644
--- a/rerere.c
+++ b/rerere.c
@@ -1107,7 +1107,7 @@ static int rerere_forget_one_path(struct index_state =
*istate,
=20
 int rerere_forget(struct repository *r, struct pathspec *pathspec)
 {
-	int i, fd;
+	int i, fd, ret;
 	struct string_list conflict =3D STRING_LIST_INIT_DUP;
 	struct string_list merge_rr =3D STRING_LIST_INIT_DUP;
=20
@@ -1132,7 +1132,12 @@ int rerere_forget(struct repository *r, struct paths=
pec *pathspec)
 			continue;
 		rerere_forget_one_path(r->index, it->string, &merge_rr);
 	}
-	return write_rr(&merge_rr, fd);
+
+	ret =3D write_rr(&merge_rr, fd);
+
+	string_list_clear(&conflict, 0);
+	string_list_clear(&merge_rr, 1);
+	return ret;
 }
=20
 /*
diff --git a/t/t2030-unresolve-info.sh b/t/t2030-unresolve-info.sh
index be3fcdde07..b3f6bc97b5 100755
--- a/t/t2030-unresolve-info.sh
+++ b/t/t2030-unresolve-info.sh
@@ -5,6 +5,7 @@ test_description=3D'undoing resolution'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=3Dmain
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
=20
+TEST_PASSES_SANITIZE_LEAK=3Dtrue
 . ./test-lib.sh
=20
 check_resolve_undo () {
diff --git a/t/t4200-rerere.sh b/t/t4200-rerere.sh
index b0a3e84984..213b36fb96 100755
--- a/t/t4200-rerere.sh
+++ b/t/t4200-rerere.sh
@@ -25,6 +25,7 @@ test_description=3D'git rerere
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=3Dmain
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
=20
+TEST_PASSES_SANITIZE_LEAK=3Dtrue
 . ./test-lib.sh
=20
 test_expect_success 'setup' '
--=20
2.46.0.rc1.dirty


--a6LTOWm/sgAqFCLu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmajk8oACgkQVbJhu7ck
PpT9SBAAl0aPKMeFVO6O/Xz8d+nkcLbNzike2D58e53yBbs3b2aztB+qe5lJBAt1
nYskA4qPfrSt4akCrY8+75EWjwccpZIm1Im4hTf/9aAKp4GIaSU+BjbVGoicHlNf
qTAMI3hqfQ4BTmJTW1fa8Tsv8dZhT20lnUMT37pWyBzDBMqYmydXJzT14Sd7+o3n
BuVHV++qBiqTDB8Wo+tfQE0/5X70wyxvTV+te+1nMAobpAtegO7lMGL/Zs3iiSWv
xcu3E51LBTEvQhSGUuS+M0csaw3uZEI5kOpoNo4dwHgTz7nT4BvhbM2LK2uBS0o9
GEb+RHsBbTQGp39DSVkpq5nzjSglxauaFbkrmta+272FBhUHSu2gK5jivzP8CfsN
ADSdRaov27yaftdhAmFJTHTURNA3MqQEHf3aBNpflnStNednnx7sdXLdX3ay3rKS
qMaHcygEYYyBLYb76yQyl089+l6cpQRFRniLUIfBYr5PNAbdfsoUZx8aE6t+oGAt
XE0WEYAWpw36Hs80rR2xT6sCqfyAKgCHBUfwm16SlGUxJQyK1Chz1QLanEZnwKbX
S7IVf1IcKt8qkBhSZ+ymIVff/L0OxapP6caOAJ79MZJDU74WXoL1YcUEclhJd7WN
uWqpSl2DKsZLcfOIi9htNvuAMGh98xbyzgjPIlxpYmJEhyhyr1I=
=Y19i
-----END PGP SIGNATURE-----

--a6LTOWm/sgAqFCLu--
