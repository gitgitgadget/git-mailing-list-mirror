Received: from fhigh8-smtp.messagingengine.com (fhigh8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44DFF4D9FD
	for <git@vger.kernel.org>; Wed,  3 Apr 2024 06:03:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712124241; cv=none; b=kNZoxzJCZqaV5fo11sqD1skla0adWUwUDn8Gn6U3dItVfWyYPfheEat585khiBNnq9VDDmR9AGb01cNvDF3BFOf4/aMipK2J6aX23yoF/0KdH2u6lmJ0Q3VUqhtYmI+laP1IjahOyeZ2YLanbPIQjgwynhfkmFBRICM5HW8VYrM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712124241; c=relaxed/simple;
	bh=my8HVEZdECQUEtxPXi9PEoAKZXu8I44tcfXsbF+U2u0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HVr/T0lK8CDqCm5qdCEDuw3lUNFFHardKe1/QPSFV5v4lnI9E4anmDqanXUGZMcu2LbdHeI+KMyfF2yyG5cL+Hvj+wG6mXjV7RZ48VpRq08huSsJRAM+FBxZzm9+HNJLFOgEPjW6fwQIFK62SlRgl3D8RlYNV7MfOUce1x8jnss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=qDScJtJY; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=RofWnYgT; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="qDScJtJY";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="RofWnYgT"
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 46BBC1140101;
	Wed,  3 Apr 2024 02:03:59 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Wed, 03 Apr 2024 02:03:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1712124239; x=1712210639; bh=aARQCZP6RE
	SZ6uNqwqOLS7r7BLUITFVoAqD0a9DOMO4=; b=qDScJtJYQxBnMHDXaM+HOj11UQ
	VkOJkaSgVHwgRGhut1yPmIfrj0uxyQvejwC3oHCrfbsEFdGIScdzAS9Mum4isLpo
	SE81Fiu6YgYYTr5K97h6IZgbiAt1F+7eNy/fc2M7SNwzZeQpJDaN2BxhJ5BrJXrK
	G1NRGAM1lyd89VvsYBgKPWYUSfk/3h09Q/Y2rqvqBon8YrAxtbcY09LXl8aIRgDg
	M2zcNcvzRLfqhPZzBRSnaijYwoaG7qOy1/OYhf8Jk50H7yB6OGPzRpXE0cCdjiuP
	EItLNQnK5wn9ZhGW/7xv1wWjQVMwPkkneIkaHMxLeJjtnlfDdIaBBpmHukXw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1712124239; x=1712210639; bh=aARQCZP6RESZ6uNqwqOLS7r7BLUI
	TFVoAqD0a9DOMO4=; b=RofWnYgThw8NVh54jm4AN1FBDqtqYcaURb2iApz+ihuc
	j/wNhUQvi4Nh0wlzM0haElS8MfBqW/SyorAz3SUJR4Vdfh0Qjc8urSMt0IjoKMIJ
	xi0jV90H37Crf2fczxZpUhN/mGaLlqyRVho/VXxdk3hIBf7KMI9hvbJrMtWopgiK
	UbwMAUs8ESokDAQcxPEj6Pgllgd55JwSg8wTVvuXS81RHDm07qBreeeQk3rNdidJ
	nj29OQRHpnZ/BuVGtYh6/hZt4X4TyeIQ034d2soYZYupQXjzSTtgAaiwyPJlMt0f
	saPi57zM7jAAyHNRk1c429fUCYorkjR41HVWsQdtVQ==
X-ME-Sender: <xms:T_EMZmieYujw1f_3fLdVAYjF-Aj8v6uscEJirlTUQ7wsNZFyNMa_Qw>
    <xme:T_EMZnD-JAyLLZkq8K530N7WosF0UT3wf7IIcVT6JNq_S2qvZVIvW-AUx4yKn_9uf
    qLkb58Dsb0XzgNuuA>
X-ME-Received: <xmr:T_EMZuFN-Q4CCqhWanY5tFdB9yhUv30Armd_AQEjG_zoqsGTXp6Z40iLLGKpWd7kAYYyFQPQyb1ur9JWTDRW5mMm-P8GRJJ8jxnT6lArQ2IzLQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrudeffedguddtudcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrght
    rhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtth
    gvrhhnpeeukedtvedtffevleejtefgheehieegkeeluddvfeefgeehgfeltddtheejleff
    teenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpsh
    esphhkshdrihhm
X-ME-Proxy: <xmx:T_EMZvS6bYrCz2W6GfVB2BYZHJ86JoVUj7XEEunZfWkHWGmYTh4x5Q>
    <xmx:T_EMZjyW47NlqQ6H_6TMKB6wZSFoAi5qqWGVLSv04nbzQR0Di0g4dQ>
    <xmx:T_EMZt57FxlInqJrgAEzuv_PoiTuOUqoAP65QV-P08Eq6VoiTHgTlA>
    <xmx:T_EMZgzDju9IwvUtPZ6Forlgo6_Z7ylDl8rZlK6iLvQ8fLEV2BZpCw>
    <xmx:T_EMZj8_tIBHQVHm5dw7_sm_uSjR3MhvZ6JWmUy9FcjEM4leYSTk5wnk>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 3 Apr 2024 02:03:58 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id d968b735 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 3 Apr 2024 06:03:49 +0000 (UTC)
Date: Wed, 3 Apr 2024 08:03:56 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Justin Tobler <jltobler@gmail.com>
Subject: [PATCH v4 1/7] reftable/basics: fix return type of `binsearch()` to
 be `size_t`
Message-ID: <baa07ef14425ff45296c2eb677c07b085bacafb3.1712123093.git.ps@pks.im>
References: <cover.1711109214.git.ps@pks.im>
 <cover.1712123093.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="o6o2jNHmJwdIlkOo"
Content-Disposition: inline
In-Reply-To: <cover.1712123093.git.ps@pks.im>


--o6o2jNHmJwdIlkOo
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

The `binsearch()` function can be used to find the first element for
which a callback functions returns a truish value. But while the array
size is of type `size_t`, the function in fact returns an `int` that is
supposed to index into that array.

Fix the function signature to return a `size_t`. This conversion does
not change any semantics given that the function would only ever return
a value in the range `[0, sz]` anyway.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 reftable/basics.c      |  2 +-
 reftable/basics.h      |  2 +-
 reftable/basics_test.c |  6 +++---
 reftable/block.c       |  3 ++-
 reftable/refname.c     | 17 +++++++----------
 5 files changed, 14 insertions(+), 16 deletions(-)

diff --git a/reftable/basics.c b/reftable/basics.c
index 0785aff941..2c5f34b39e 100644
--- a/reftable/basics.c
+++ b/reftable/basics.c
@@ -27,7 +27,7 @@ void put_be16(uint8_t *out, uint16_t i)
 	out[1] =3D (uint8_t)(i & 0xff);
 }
=20
-int binsearch(size_t sz, int (*f)(size_t k, void *args), void *args)
+size_t binsearch(size_t sz, int (*f)(size_t k, void *args), void *args)
 {
 	size_t lo =3D 0;
 	size_t hi =3D sz;
diff --git a/reftable/basics.h b/reftable/basics.h
index 91f3533efe..2672520e76 100644
--- a/reftable/basics.h
+++ b/reftable/basics.h
@@ -28,7 +28,7 @@ void put_be16(uint8_t *out, uint16_t i);
  * Contrary to bsearch(3), this returns something useful if the argument i=
s not
  * found.
  */
-int binsearch(size_t sz, int (*f)(size_t k, void *args), void *args);
+size_t binsearch(size_t sz, int (*f)(size_t k, void *args), void *args);
=20
 /*
  * Frees a NULL terminated array of malloced strings. The array itself is =
also
diff --git a/reftable/basics_test.c b/reftable/basics_test.c
index 1fcd229725..dc1c87c5df 100644
--- a/reftable/basics_test.c
+++ b/reftable/basics_test.c
@@ -34,15 +34,15 @@ static void test_binsearch(void)
=20
 	int i =3D 0;
 	for (i =3D 1; i < 11; i++) {
-		int res;
+		size_t res;
+
 		args.key =3D i;
 		res =3D binsearch(sz, &binsearch_func, &args);
=20
 		if (res < sz) {
 			EXPECT(args.key < arr[res]);
-			if (res > 0) {
+			if (res > 0)
 				EXPECT(args.key >=3D arr[res - 1]);
-			}
 		} else {
 			EXPECT(args.key =3D=3D 10 || args.key =3D=3D 11);
 		}
diff --git a/reftable/block.c b/reftable/block.c
index e2a2cee58d..422885bddb 100644
--- a/reftable/block.c
+++ b/reftable/block.c
@@ -382,7 +382,8 @@ int block_reader_seek(struct block_reader *br, struct b=
lock_iter *it,
 	};
 	struct block_iter next =3D BLOCK_ITER_INIT;
 	struct reftable_record rec;
-	int err =3D 0, i;
+	int err =3D 0;
+	size_t i;
=20
 	if (args.error) {
 		err =3D REFTABLE_FORMAT_ERROR;
diff --git a/reftable/refname.c b/reftable/refname.c
index 7570e4acf9..64eba1b886 100644
--- a/reftable/refname.c
+++ b/reftable/refname.c
@@ -33,10 +33,9 @@ static int modification_has_ref(struct modification *mod=
, const char *name)
 			.names =3D mod->add,
 			.want =3D name,
 		};
-		int idx =3D binsearch(mod->add_len, find_name, &arg);
-		if (idx < mod->add_len && !strcmp(mod->add[idx], name)) {
+		size_t idx =3D binsearch(mod->add_len, find_name, &arg);
+		if (idx < mod->add_len && !strcmp(mod->add[idx], name))
 			return 0;
-		}
 	}
=20
 	if (mod->del_len > 0) {
@@ -44,10 +43,9 @@ static int modification_has_ref(struct modification *mod=
, const char *name)
 			.names =3D mod->del,
 			.want =3D name,
 		};
-		int idx =3D binsearch(mod->del_len, find_name, &arg);
-		if (idx < mod->del_len && !strcmp(mod->del[idx], name)) {
+		size_t idx =3D binsearch(mod->del_len, find_name, &arg);
+		if (idx < mod->del_len && !strcmp(mod->del[idx], name))
 			return 1;
-		}
 	}
=20
 	err =3D reftable_table_read_ref(&mod->tab, name, &ref);
@@ -77,7 +75,7 @@ static int modification_has_ref_with_prefix(struct modifi=
cation *mod,
 			.names =3D mod->add,
 			.want =3D prefix,
 		};
-		int idx =3D binsearch(mod->add_len, find_name, &arg);
+		size_t idx =3D binsearch(mod->add_len, find_name, &arg);
 		if (idx < mod->add_len &&
 		    !strncmp(prefix, mod->add[idx], strlen(prefix)))
 			goto done;
@@ -96,11 +94,10 @@ static int modification_has_ref_with_prefix(struct modi=
fication *mod,
 				.names =3D mod->del,
 				.want =3D ref.refname,
 			};
-			int idx =3D binsearch(mod->del_len, find_name, &arg);
+			size_t idx =3D binsearch(mod->del_len, find_name, &arg);
 			if (idx < mod->del_len &&
-			    !strcmp(ref.refname, mod->del[idx])) {
+			    !strcmp(ref.refname, mod->del[idx]))
 				continue;
-			}
 		}
=20
 		if (strncmp(ref.refname, prefix, strlen(prefix))) {
--=20
2.44.GIT


--o6o2jNHmJwdIlkOo
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmYM8UsACgkQVbJhu7ck
PpTfAhAAm7YMKW7WXKOli9XsnWqWa7f6zKjq+/g3yY4mop241uotwYiUyuBUGdh7
T+6/l1r3paf381ZMXBsz3kAWhq7InirOFwUohbTepb+mWh87MZa5fwotxl13tUGE
qaHQUIvobuWvK6zr2Z+Zp2hsMRaBFohO5NdMw9n+h7tnh6a4ty1vnxIlg5JBe9sx
DTTPKxOFGJfdeO9U5ja7FAns/lNPUd0w95YLBLO61jit0DJo3Ku2pcoRfzPH/GCZ
CDtfYeE8ZIt1m7enUTqLC14Mm+dII9iyoXCuZZ1DnCwIQYu7Efys9NGAjtWZThPk
J01JVs2VM0L0oBzLxKyzMb67zQ51LS1frQ+p/zHUV4RA5by9p+E8O7v+7vEVJc9a
xDzrCl7gzhNK5ojG58NAgOWmcXRZvaycx6K2qcERRzG5C/qAZm+45bkIXuJVe0eT
1tfWoXlUKhygtDrTUIIUpQtSvlGQCNiKwpjfs5hCuMs/SQslKDwLgPFBUFy2mwFo
DuxIUHPrmjwAMX5nxxzKUC/wlBcx5Irrcv+wkkMPfCZziDNbKGtZdARTfkMJJNBg
5y0RRg4gIHvDqIijfbGvThvaiBDcNsVw7jDMmkwcT4AONpRBaY/lTDE/aqbSzZM6
txbA46eOGEYjvQSz722OUoSSHv6Yux1WP3WZIzFRo2h7zjJ0BLw=
=S6gC
-----END PGP SIGNATURE-----

--o6o2jNHmJwdIlkOo--
