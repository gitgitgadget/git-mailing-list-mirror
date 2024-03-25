Received: from fhigh5-smtp.messagingengine.com (fhigh5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE23F182704
	for <git@vger.kernel.org>; Mon, 25 Mar 2024 10:10:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711361435; cv=none; b=M+Nwhm1+R4ofRR0hXMI2aSTNhBdPqhSXMfO+TiGlRer6kvIf8fO/NCNB2srES/C/6IqIiasUY1pcHuwvEitri0LOmEptFcdMQFXXhPgYkCMyT7NR3zw9wwuVnWRJd4okcYc4fxexbAwENy6qX3sK7W2WOwC1j7045eZjckekP2c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711361435; c=relaxed/simple;
	bh=C2PbYd1XQ4sMyxzua9yJDL28ODKbf4MkK/kyh9Uk/+Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WfHtZsgrQzkcPvJ33bWYI6ovAguTBTjPPZ4VXfWR09N6Ap++3S0BUjvBI9Mu5Lucbn7I4yBmMDM78APFB6bIM3cQZ/ZuP6aJFv2vcX4MCOzJPOrVLvizmnjCTrewgZMqshVSu+jUoRU9OO7lR4M1oSPb4cWmrYAYkUPaYPqrfTE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=BotbCSsc; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Zt+h0b3+; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="BotbCSsc";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Zt+h0b3+"
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id D10E11140102;
	Mon, 25 Mar 2024 06:10:32 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Mon, 25 Mar 2024 06:10:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1711361432; x=1711447832; bh=dYT+R4hx9S
	KY2UJTtUReAuBGRh4CIPl9j/U2W4wgIss=; b=BotbCSscNqKbCr59OdLyN9ghhG
	pi1H0OYEIpfr9OtX5QxEvk3Xz4amNiRGgnEcbiSIWWuJ8H+Q4z6AVsLj6HOrh/dh
	s8IjsOFY/6grv3cV41vQQK32ZgCs5AKqN0PzOHgHcTZUo8dkE0tDroZRU8Rt85ls
	8VtQoXFGLpHMJKmHrWAT5bxULmckRuxUXtB+ZlCEjBDXVmsADWTqpB6/lAYKfRbA
	OadXsO/6SNY1AwoeHvbE5TjczqXpRdOcLnEGCdcP/v/UTh4gF/AQDLJ+rRBZJIO9
	0Hy31N7GR5TpuXEzI4vhHFl2iKuV+9beP/nNuE969H+7ti8JqJyTFDu97hHA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1711361432; x=1711447832; bh=dYT+R4hx9SKY2UJTtUReAuBGRh4C
	IPl9j/U2W4wgIss=; b=Zt+h0b3+xSAvbNLdkoaysMHXWn4hwnjC+UCjuSajnStS
	OHqUT1QCrEU+xEO8lwPYmGBj/KHtOyf4wnhZf6Ys0qDCZ0DELH3t2tQCFcq41hMW
	O17tCpSD31YmzAXiu/KFfBrxTv4UahIG8mPcKwKPTGchRVqIrAEGDMpmjnN46kHQ
	q2SGE061nsIQlU9lo9fQffwPMjT5/m1aqFImHIgDsPz4OfNuYu520aIEgp42DmmH
	Kdh6FyDeys+IJW8vAWhpbvgtXBroBjz6DT2nvMIwifj8J4NScvL5UxGrvSbpCHj2
	2kGg1UcPn/hodnuxautpZ5qK57J+oxv8gXeA1gENbA==
X-ME-Sender: <xms:mE0BZuS7_YTecB8soeKxhQLQ-zpWrlXJ_lEOnslmg_ltDiIIpapA1g>
    <xme:mE0BZjz0_cw0daEJkd5LwVWoL6um3wpQ9KBT1gA2R-OPH3jTEV6gGp4gLvf2fM5Fc
    lxTLv1bgtY53SDFEA>
X-ME-Received: <xmr:mE0BZr09P5jq8-woy1VcWoFGuGd3Ocm_TjBan6KKFDfutIW83T1VMrzK-jbHFLPY0AFkVq-mvGBMUxq3yX0Y3KG0nZi-Mpb8ILCXMdf_0L9oXg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledruddtledguddvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepueektdevtdffveeljeetgfehheeigeekleduvdeffeeghefgledttdehjeelffet
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimh
X-ME-Proxy: <xmx:mE0BZqCDhLnsfmkm3pvFDfeEYxGmDzKm75NJXm4OJGGaXoPmsArMLA>
    <xmx:mE0BZniPcV-idyRuz3EntLqXbS9nTbStaygWdqURFdnbZeb-4EQ-Rw>
    <xmx:mE0BZmqCxn0SCpPyconww0UnxJWc60CdFLwbIh6b3181tZzEmcSOHg>
    <xmx:mE0BZqhUBn9Edx5eEkaKKTmIvyUPKFTF0c4c-cnHvEWSu_1YGfJ35g>
    <xmx:mE0BZksLkRY3YwKHqO4xfyuxvB9puab-TMCf7L2YUqcnnTbzOps_Hg>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 25 Mar 2024 06:10:31 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 29380717 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 25 Mar 2024 10:10:22 +0000 (UTC)
Date: Mon, 25 Mar 2024 11:10:30 +0100
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Justin Tobler <jltobler@gmail.com>
Subject: [PATCH v2 1/7] reftable/basics: fix return type of `binsearch()` to
 be `size_t`
Message-ID: <cd82ac6531f87917c736c4b523496ef270be34b5.1711361340.git.ps@pks.im>
References: <cover.1711109214.git.ps@pks.im>
 <cover.1711361340.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="uOAeNx8AUEGqSIHo"
Content-Disposition: inline
In-Reply-To: <cover.1711361340.git.ps@pks.im>


--uOAeNx8AUEGqSIHo
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


--uOAeNx8AUEGqSIHo
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmYBTZUACgkQVbJhu7ck
PpRO2A/8Djaqol6udgljQ7z7SFqki1ztl3ulCZyjPeWriSGTVyD0rgrWC4x2a4Tw
+fwo07kfEBWCrQXjwg2UnP9SSbySHwxzjFIF7DXDIu9bsCDzXzWr/t3mUvV2Gx38
FsBgF5XNYLa+wE+7QwK8qN4AyQb8HU8tZ7mLPQM7HusDbq+4YZCL/d+CNLgqNWTU
WadBAl+I3w/U2KCg97SGwh5H9oZsiqBqPHyJsrgvI1y/Z+IasTrcFBVqrzxOVMBO
oJJAh/o2rM9a3lbAuxfeRIfkwIUNA4+1tQbU6JrDcRJu68TPPxeesZTmAf37mTXk
qdBcITk2q7yaHtFrDmVrcm9HzEkLw+ii2FFSRoYNjR6Zdds3U8gQyUuegfrsh+xQ
45cIfiCEE8WhPiMNkhgvxthxae0bKUqQ+Hpj1ZZRnCPbbZqHms40T5dVWx9IztfB
SagZkPttv+qN9aqXyv0BrpFk7mRsCgkVtA3m85khPKeHb1e2q6Itl3SQfQ/o1Vw8
naF7/MrNXQEf98ZQOzUkvpVvPli9BpxsfvnvAn4cNGS4GjEH9JJ4RSzMoUpyl24U
wLkAJQuo1N+XNuC9xPZfQ8L3lTEYnXYIlCVKHbc4czDcL8odgRbRmt4NvCfJv9q5
SFFhqbAieEbQsgoDfJciVbVUsCIW3ppojhifnfpzxi+354mJpbU=
=OLOB
-----END PGP SIGNATURE-----

--uOAeNx8AUEGqSIHo--
