Received: from fhigh6-smtp.messagingengine.com (fhigh6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90D7F364AA
	for <git@vger.kernel.org>; Mon, 18 Mar 2024 10:52:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710759176; cv=none; b=OeO06sK2QqzJuuHNafGyeHVxTgc3R6ux2ZnovdIHBprC/CeML0xazc3VIKUi50qhe0yXsET1Rw/Ks7XBIJwJvPiS7J13jLM9xWldW0Y6k4bbJREGq4wpptRc+rzb+no55o/TcxgqLoS6Q9XyxjFrQ2sVKJRaSDQJzmx5eBjjEuM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710759176; c=relaxed/simple;
	bh=oxD9+zAkkIZ48ALDQz1+gdr6QJkrGrsA9j0cYKSn31U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fuxFhJMvFq6NcwlIE//HQbsgHsCxlwLuA19xtgIhApzhEeMzpSqjdz8dEy5NNdu1WoSHyOCvVOVkN+F8llB9XqAACln+AqWTIJmgEck3XD0SlMrw1u8PrwycVJE3zDafWIDxTnZj7ZnxGDwYYbA99+WnBlzuWFRqdkNWQ9XkYo0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=XrH819LF; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=TvKaVX/8; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="XrH819LF";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="TvKaVX/8"
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 98458114009B;
	Mon, 18 Mar 2024 06:52:53 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Mon, 18 Mar 2024 06:52:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1710759173; x=1710845573; bh=EgMyM0noVE
	Nyv7Vhv77Dn0gBi+Jbe78RZ0eKqzXtEZ8=; b=XrH819LFMxQBz+d7SK7+HflMTM
	ff6mQJ8X2gfmmWjQniwxeoM9L2Sa9jLCohMb5JUpu7gS5fdbFuQdwF13qRZwDNQq
	ivfUv1LbwABu93BLvG36NN2FEWi89OH7T9qr+PLCE1Tyhepv6qOQmmbWyr3CwxQR
	LylAoIXNykkBO8nf3VCe1AohMgoiqP5Ff3jcivuTarjYdVG1Zg5V2T2ElaEraVZW
	rKqS/y0mIdbXudoknWTn/4/hRoMumYxTWppuwlNtNrmd5/OQV/cErhPCU4T/AvRB
	zsbDljlio/f5EEsMrSUSMgH3QGx5u2fqEdP+cOntPim7FrMjtg44kUEzCSvQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1710759173; x=1710845573; bh=EgMyM0noVENyv7Vhv77Dn0gBi+Jb
	e78RZ0eKqzXtEZ8=; b=TvKaVX/85PrtD+CNU/84mIr7y8/kTmGhJkalB0Fbztax
	ZfK1mESD+TDYY7zad5Ve/EdyE1SLZOajwymH8rp1yJvnCVaGytrSa/9BhhcRw89R
	fy6+wQLUARivxAjCP6Zxr+zz4+HLiF7176xZI1P6lGYDjZY2aFoFRxuoJI/S8yb5
	Y9QwkS9J5BJEro614OSFSrmSrdrKAhEToa9YztndePReL7NHEKRlDe4d90GKs+s2
	DbcuIERfnfzGuwCiVQlVJof7UX3JhrK2JF0Z/Mk936kbFYMdPUuF8hhHCzmpcolB
	FSqG6mLI0ZLxX5EV776G8nwM1XBq9aKXWBLrWq3m0A==
X-ME-Sender: <xms:BR34Zc6K-8OW56cP84ejcERYyyPkI7F6swDQkXD0HRYo7yJjj0eTlw>
    <xme:BR34Zd5JrVItssdtaJjViACk5_S5IgjFxoJYaKicwMEQjKpDT3gvIEG75_IlNrZw6
    H9QMMw8Kq64wfDG6g>
X-ME-Received: <xmr:BR34Zbc_Lnjxn0ZtllwAA28c_ufcc7dqD3YbwznNiDnr3RoCKjLoR40tE__LZJ6YJL1cmmjJW78vHsBdpjjqI9pESS3AQr9Pkgkof51_3dH8sA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrkeejgddvudcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvvefukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeeukedtvedtffevleejtefgheehieegkeeluddvfeefgeehgfeltddtheejleffteen
    ucevlhhushhtvghrufhiiigvpedunecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhm
X-ME-Proxy: <xmx:BR34ZRL3hmzmqj10kDXSVbgqQoeNtVHfWjjO3AFbjtqb5QUmUzugVA>
    <xmx:BR34ZQIjTRSkB_EZ6xYhCGLB3RU7XQCZcRINH78jzyYmrDowbFoZDg>
    <xmx:BR34ZSxQCnVil64x52SW8FhoIVUK503R5o2SSW2GRsu-L02w2nORQw>
    <xmx:BR34ZUI8mZz9GRx-G746OyzPecKy5yu7sqYuTfAKaf3KV47J35nzWQ>
    <xmx:BR34ZU0PJE6UjlYB2zwJiKka2cy5LV_RAHzLShqKzPEJjNpZ_z0acA>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 18 Mar 2024 06:52:52 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id c5acd902 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 18 Mar 2024 10:48:01 +0000 (UTC)
Date: Mon, 18 Mar 2024 11:52:50 +0100
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Derrick Stolee <stolee@gmail.com>
Subject: [PATCH 06/15] t/helper: drop pack-refs wrapper
Message-ID: <999d0c2bb8fe11766a20d102dcef0f4f38a5fbd4.1710706118.git.ps@pks.im>
References: <cover.1710706118.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="dJ9lgRRF1vVEL5LA"
Content-Disposition: inline
In-Reply-To: <cover.1710706118.git.ps@pks.im>


--dJ9lgRRF1vVEL5LA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

The test helper provides a "ref-store <store> pack-refs" wrapper that
more or less directly invokes `refs_pack_refs()`. This helper is only
used in a single test with the "PACK_REFS_PRUNE" and "PACK_REFS_ALL"
flags. Both of these flags can directly be accessed via git-pack-refs(1)
though via the `--all` and `--prune` flags, which makes the helper
superfluous.

Refactor the test to use git-pack-refs(1) instead of the test helper.
Drop the now-unused test helper command.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 t/helper/test-ref-store.c     | 20 --------------------
 t/t0601-reffiles-pack-refs.sh | 13 +++++++++----
 2 files changed, 9 insertions(+), 24 deletions(-)

diff --git a/t/helper/test-ref-store.c b/t/helper/test-ref-store.c
index 7a0f6cac53..82bbf6e2e6 100644
--- a/t/helper/test-ref-store.c
+++ b/t/helper/test-ref-store.c
@@ -112,25 +112,6 @@ static const char **get_store(const char **argv, struc=
t ref_store **refs)
 	return argv + 1;
 }
=20
-static struct flag_definition pack_flags[] =3D { FLAG_DEF(PACK_REFS_PRUNE),
-					       FLAG_DEF(PACK_REFS_ALL),
-					       { NULL, 0 } };
-
-static int cmd_pack_refs(struct ref_store *refs, const char **argv)
-{
-	unsigned int flags =3D arg_flags(*argv++, "flags", pack_flags);
-	static struct ref_exclusions exclusions =3D REF_EXCLUSIONS_INIT;
-	static struct string_list included_refs =3D STRING_LIST_INIT_NODUP;
-	struct pack_refs_opts pack_opts =3D { .flags =3D flags,
-					    .exclusions =3D &exclusions,
-					    .includes =3D &included_refs };
-
-	if (pack_opts.flags & PACK_REFS_ALL)
-		string_list_append(pack_opts.includes, "*");
-
-	return refs_pack_refs(refs, &pack_opts);
-}
-
 static int cmd_create_symref(struct ref_store *refs, const char **argv)
 {
 	const char *refname =3D notnull(*argv++, "refname");
@@ -326,7 +307,6 @@ struct command {
 };
=20
 static struct command commands[] =3D {
-	{ "pack-refs", cmd_pack_refs },
 	{ "create-symref", cmd_create_symref },
 	{ "delete-refs", cmd_delete_refs },
 	{ "rename-ref", cmd_rename_ref },
diff --git a/t/t0601-reffiles-pack-refs.sh b/t/t0601-reffiles-pack-refs.sh
index c309d2bae8..b1cf587347 100755
--- a/t/t0601-reffiles-pack-refs.sh
+++ b/t/t0601-reffiles-pack-refs.sh
@@ -32,11 +32,16 @@ test_expect_success 'prepare a trivial repository' '
 	HEAD=3D$(git rev-parse --verify HEAD)
 '
=20
-test_expect_success 'pack_refs(PACK_REFS_ALL | PACK_REFS_PRUNE)' '
-	N=3D`find .git/refs -type f | wc -l` &&
+test_expect_success 'pack-refs --prune --all' '
+	test_path_is_missing .git/packed-refs &&
+	git pack-refs --no-prune --all &&
+	test_path_is_file .git/packed-refs &&
+	N=3D$(find .git/refs -type f | wc -l) &&
 	test "$N" !=3D 0 &&
-	test-tool ref-store main pack-refs PACK_REFS_PRUNE,PACK_REFS_ALL &&
-	N=3D`find .git/refs -type f` &&
+
+	git pack-refs --prune --all &&
+	test_path_is_file .git/packed-refs &&
+	N=3D$(find .git/refs -type f) &&
 	test -z "$N"
 '
=20
--=20
2.44.0


--dJ9lgRRF1vVEL5LA
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmX4HQEACgkQVbJhu7ck
PpRQvQ//UeD1xcfXbLcUgC61uFC6c+3cZmTlSSIuxXXZbjg2E8wl2bb0gRRPwANW
rjlxq2wye9soGA8X8qb1r5ZUtbvwsrBojGb/0Q6L73u2AidyqEzrxENG21POiQXn
NFqqeEw2adbu1ojN4MJEdS2Z9RxuZDwiHd+6ek+KVw9jY9ADOnViAa+mj1utljOM
n5oxeX6FgYhfPeOWyuejV5fXXxvCt09v4sjKegp5yxfONMS/ByoE6zOznXGhBdlR
/tBOz45noaXcMrVQjuolHVcle3O5daFStecNVxJeHCTgXn3ttiri07abVyTsYChQ
ofORNr+N4E2mBpjhcGaCKOp7uQrA3qXBXd9PkX1kkEtansq2u4xzneBrKT/9rFR/
JqIS3wYZzGOIihBpdiYQXxyDMnhGu4WEI39g2Q2vq29S55+sk771DTZMrCbahWBv
03M5dZoID43w/iuwpbvBSITsPoQr5NFmd9Mb8pQPoJW+itdeXOw8BoBXqNM8cYr2
VHeNA7IjTuI7/dRrjovwZkroWL4UBgb/Re4Bi8mc0Hx1P5F8hFWanmvhbgVZRZVM
37g/vvvURyhzD4nNG6TznUzAxXVlg7SLgSBPSZb+c3rXYwzYsDzfqrSrYGpVSwe8
nr0PMuTsnBWEj6fLGzRPCrdDGpkjA7dnsVncUmKj7OX4RLcNm5c=
=l0PS
-----END PGP SIGNATURE-----

--dJ9lgRRF1vVEL5LA--
