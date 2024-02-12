Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com [66.111.4.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0CBD101C2
	for <git@vger.kernel.org>; Mon, 12 Feb 2024 08:32:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.111.4.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707726752; cv=none; b=dES2ZrvPBHoFrgeju3CUF2AJQPpCAHqIMNtwuW3T3U4iiJf5Tx4JLdTsuXCDhuOVQhzFUthndB03T2yCn+dmtefKJow9Ga5s/+CTW91quc6ap63t3NY8Was5ab60KtQq6/1QXvVy124dJD4ellgiaTKtogdBukveeSP7QnSkE3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707726752; c=relaxed/simple;
	bh=wZGXdH52xM95KgSbzJKgABV3bjmkO3A24LPFqC7IqsE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=K7LPQmY9f5cXYEVKDVqDi/3HisAHS9h/GpC2uxp2ZZZ0du1BPw22ohnRmZeOqQQqDmEglOEGBsi4AfYh5RQEJHK5abIZTpMKclewRZcQZzktwZ72GD/WlYL51qr7WwmlAZUvtKkAwYkPPKMVXnnxicLu1BlMKzQR7Et7N1Yqfic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=gkmjpJcz; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=LE23OfMo; arc=none smtp.client-ip=66.111.4.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="gkmjpJcz";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="LE23OfMo"
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailout.nyi.internal (Postfix) with ESMTP id 9548D5C0090;
	Mon, 12 Feb 2024 03:32:28 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Mon, 12 Feb 2024 03:32:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1707726748; x=1707813148; bh=z6a+ohGe6f
	291QgPQTdPn9UzOYrWCmNWHa2agK/dR6U=; b=gkmjpJczA99EnAFgHa9l8EBGkz
	6SFZmPxRZ4ZGtYFTa/+qVTsjar+xTRnc2As8ujqWk2tLpXeHH2+fiOeGiAPuorNO
	OG95b3K4SlZe/Xvpb5kUrjXvP7y2ygzreT0BZhek55S5fdQt0Yf//E/BxwsJ9wlD
	sLoVahZ1QZ0JOW/xA0yAINEJuInGBpvuG3lr6ELWpcpgCUni5PWH4OevLNyEgCJj
	tauWAff7rE4A+KoHTImGUTft+7rVh5AwPVu96KCyE+WjpoH5w7D1T9I4+BIDk3NR
	FKN/QsAOIySmxsnh+9iLA3T38JuwsDArntabgHvJ5wWignPboFwYhFF+Ognw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1707726748; x=1707813148; bh=z6a+ohGe6f291QgPQTdPn9UzOYrW
	CmNWHa2agK/dR6U=; b=LE23OfMoFUCbS0fsDoGhahyFXCjELbtTnUzXGnYffjkS
	QQry1jC4cyn/tAgpADsSEyIu+B9dis0oCDMmf5Hndxv3RlypvqZo1eT8RLSWtXqF
	N9BeNXbOaQCOc0soIBWEIP9fjp8TQGtKLOJkeSm8VltIMxOjrCCf8WWuToAmz/z2
	f2P4Uuv3xbN9boc85/5mCx4BRiZx3cad7bzeZP9eIDVCFL5pv6rxXwvUw4oqKAu8
	+gEXwIkmpGBY+DxJKirk0LU51NZ8RqnDX2CMooMlm15byM2LFuu0Q6wx3QTopit8
	z90bbJPI2f3DLK7FzvjA8yrupEQtboZnim+y07nvkA==
X-ME-Sender: <xms:nNfJZW39bdeYCM3oE-UOq4CUq3T6LlvxSpbHeI7NR366XgqU-XpE2Q>
    <xme:nNfJZZHx9vm4rKZ4wp3O_dIEMz-gXrzhKTwjEEoiBOzhP8T5JU3czSJgOwtslP3He
    wyIDtiXeluKtgdCvQ>
X-ME-Received: <xmr:nNfJZe54ObKlr0RreHnXzKPfRLuUNLPnlx601vbMEO0yqW3aYhgs3VqJ53-ic6BbpltX2a4mqniDQJqyv_LwhuD5pXj3VQL8pFH5BV4GkRpgWNI>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledruddvgdduvdefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepueektdevtdffveeljeetgfehheeigeekleduvdeffeeghefgledttdehjeelffet
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimh
X-ME-Proxy: <xmx:nNfJZX29aalIbaFGi9IpDsQRhdyIkmkdDiFFoxzzJUH84CXLa2Nb1A>
    <xmx:nNfJZZHAw3OG2mScgiYBNEoE4HHeduI-s9IdsaPvF8cLZmvXTGNhKw>
    <xmx:nNfJZQ_g7e06dRfg2-Stu81WosDxSQBiuYIThoHiXnaFINC3jRj1Lw>
    <xmx:nNfJZeTulSE_UMqiPj9GQobWaOfaDVNWoFb414OV9MW8b7RE3_fpfw>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 12 Feb 2024 03:32:27 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 95ce38b1 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 12 Feb 2024 08:28:41 +0000 (UTC)
Date: Mon, 12 Feb 2024 09:32:25 +0100
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Eric Sunshine <sunshine@sunshineco.com>, John Cai <johncai86@gmail.com>
Subject: [PATCH v2 1/7] reftable/record: introduce function to compare
 records by key
Message-ID: <bcdb5a2bf0acb5cc25756df10845a60197868db8.1707726654.git.ps@pks.im>
References: <cover.1706782841.git.ps@pks.im>
 <cover.1707726654.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="Yn/ju/WDGxBxechc"
Content-Disposition: inline
In-Reply-To: <cover.1707726654.git.ps@pks.im>


--Yn/ju/WDGxBxechc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

In some places we need to sort reftable records by their keys to
determine their ordering. This is done by first formatting the keys into
a `struct strbuf` and then using `strbuf_cmp()` to compare them. This
logic is needlessly roundabout and can end up costing quite a bit of CPU
cycles, both due to the allocation and formatting logic.

Introduce a new `reftable_record_cmp()` function that knows how to
compare two records with each other without requiring allocations.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 reftable/record.c | 62 ++++++++++++++++++++++++++++++++++++++++++++++-
 reftable/record.h |  7 ++++++
 2 files changed, 68 insertions(+), 1 deletion(-)

diff --git a/reftable/record.c b/reftable/record.c
index 5c3fbb7b2a..f1b6a5eac9 100644
--- a/reftable/record.c
+++ b/reftable/record.c
@@ -430,7 +430,6 @@ static int reftable_ref_record_is_deletion_void(const v=
oid *p)
 		(const struct reftable_ref_record *)p);
 }
=20
-
 static int reftable_ref_record_equal_void(const void *a,
 					  const void *b, int hash_size)
 {
@@ -439,6 +438,13 @@ static int reftable_ref_record_equal_void(const void *=
a,
 	return reftable_ref_record_equal(ra, rb, hash_size);
 }
=20
+static int reftable_ref_record_cmp_void(const void *_a, const void *_b)
+{
+	const struct reftable_ref_record *a =3D _a;
+	const struct reftable_ref_record *b =3D _b;
+	return strcmp(a->refname, b->refname);
+}
+
 static void reftable_ref_record_print_void(const void *rec,
 					   int hash_size)
 {
@@ -455,6 +461,7 @@ static struct reftable_record_vtable reftable_ref_recor=
d_vtable =3D {
 	.release =3D &reftable_ref_record_release_void,
 	.is_deletion =3D &reftable_ref_record_is_deletion_void,
 	.equal =3D &reftable_ref_record_equal_void,
+	.cmp =3D &reftable_ref_record_cmp_void,
 	.print =3D &reftable_ref_record_print_void,
 };
=20
@@ -625,6 +632,25 @@ static int reftable_obj_record_equal_void(const void *=
a, const void *b, int hash
 	return 1;
 }
=20
+static int reftable_obj_record_cmp_void(const void *_a, const void *_b)
+{
+	const struct reftable_obj_record *a =3D _a;
+	const struct reftable_obj_record *b =3D _b;
+	int cmp;
+
+	cmp =3D memcmp(a->hash_prefix, b->hash_prefix,
+		     a->hash_prefix_len > b->hash_prefix_len ?
+		     a->hash_prefix_len : b->hash_prefix_len);
+	if (cmp)
+		return cmp;
+
+	/*
+	 * When the prefix is the same then the object record that is longer is
+	 * considered to be bigger.
+	 */
+	return a->hash_prefix_len - b->hash_prefix_len;
+}
+
 static struct reftable_record_vtable reftable_obj_record_vtable =3D {
 	.key =3D &reftable_obj_record_key,
 	.type =3D BLOCK_TYPE_OBJ,
@@ -635,6 +661,7 @@ static struct reftable_record_vtable reftable_obj_recor=
d_vtable =3D {
 	.release =3D &reftable_obj_record_release,
 	.is_deletion =3D &not_a_deletion,
 	.equal =3D &reftable_obj_record_equal_void,
+	.cmp =3D &reftable_obj_record_cmp_void,
 	.print =3D &reftable_obj_record_print,
 };
=20
@@ -953,6 +980,22 @@ static int reftable_log_record_equal_void(const void *=
a,
 					 hash_size);
 }
=20
+static int reftable_log_record_cmp_void(const void *_a, const void *_b)
+{
+	const struct reftable_log_record *a =3D _a;
+	const struct reftable_log_record *b =3D _b;
+	int cmp =3D strcmp(a->refname, b->refname);
+	if (cmp)
+		return cmp;
+
+	/*
+	 * Note that the comparison here is reversed. This is because the
+	 * update index is reversed when comparing keys. For reference, see how
+	 * we handle this in reftable_log_record_key()`.
+	 */
+	return b->update_index - a->update_index;
+}
+
 int reftable_log_record_equal(const struct reftable_log_record *a,
 			      const struct reftable_log_record *b, int hash_size)
 {
@@ -1002,6 +1045,7 @@ static struct reftable_record_vtable reftable_log_rec=
ord_vtable =3D {
 	.release =3D &reftable_log_record_release_void,
 	.is_deletion =3D &reftable_log_record_is_deletion_void,
 	.equal =3D &reftable_log_record_equal_void,
+	.cmp =3D &reftable_log_record_cmp_void,
 	.print =3D &reftable_log_record_print_void,
 };
=20
@@ -1077,6 +1121,13 @@ static int reftable_index_record_equal(const void *a=
, const void *b, int hash_si
 	return ia->offset =3D=3D ib->offset && !strbuf_cmp(&ia->last_key, &ib->la=
st_key);
 }
=20
+static int reftable_index_record_cmp(const void *_a, const void *_b)
+{
+	const struct reftable_index_record *a =3D _a;
+	const struct reftable_index_record *b =3D _b;
+	return strbuf_cmp(&a->last_key, &b->last_key);
+}
+
 static void reftable_index_record_print(const void *rec, int hash_size)
 {
 	const struct reftable_index_record *idx =3D rec;
@@ -1094,6 +1145,7 @@ static struct reftable_record_vtable reftable_index_r=
ecord_vtable =3D {
 	.release =3D &reftable_index_record_release,
 	.is_deletion =3D &not_a_deletion,
 	.equal =3D &reftable_index_record_equal,
+	.cmp =3D &reftable_index_record_cmp,
 	.print =3D &reftable_index_record_print,
 };
=20
@@ -1147,6 +1199,14 @@ int reftable_record_is_deletion(struct reftable_reco=
rd *rec)
 		reftable_record_data(rec));
 }
=20
+int reftable_record_cmp(struct reftable_record *a, struct reftable_record =
*b)
+{
+	if (a->type !=3D b->type)
+		BUG("cannot compare reftable records of different type");
+	return reftable_record_vtable(a)->cmp(
+		reftable_record_data(a), reftable_record_data(b));
+}
+
 int reftable_record_equal(struct reftable_record *a, struct reftable_recor=
d *b, int hash_size)
 {
 	if (a->type !=3D b->type)
diff --git a/reftable/record.h b/reftable/record.h
index fd80cd451d..0d96fbfd1b 100644
--- a/reftable/record.h
+++ b/reftable/record.h
@@ -62,6 +62,12 @@ struct reftable_record_vtable {
 	/* Are two records equal? This assumes they have the same type. Returns 0=
 for non-equal. */
 	int (*equal)(const void *a, const void *b, int hash_size);
=20
+	/*
+	 * Compare keys of two records with each other. The records must have
+	 * the same type.
+	 */
+	int (*cmp)(const void *a, const void *b);
+
 	/* Print on stdout, for debugging. */
 	void (*print)(const void *rec, int hash_size);
 };
@@ -114,6 +120,7 @@ struct reftable_record {
 };
=20
 /* see struct record_vtable */
+int reftable_record_cmp(struct reftable_record *a, struct reftable_record =
*b);
 int reftable_record_equal(struct reftable_record *a, struct reftable_recor=
d *b, int hash_size);
 void reftable_record_print(struct reftable_record *rec, int hash_size);
 void reftable_record_key(struct reftable_record *rec, struct strbuf *dest);
--=20
2.43.GIT


--Yn/ju/WDGxBxechc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmXJ15gACgkQVbJhu7ck
PpSU4xAAriMwYi6aI+lBrZQZ7xZRi9Sfh662/5KEGdaqFoYN51N+x5/mmXWd6iZ/
KOxKNdcULWwOU+jW6i6rUGqTtXDCUw8bWWyczjYqUtU82xbZsvX7XbG2CwLQTG7w
OdkHlbquTwnxPhpy3fv4OGa7T33jC0XfIJFc0Pv7dS0EyhqHeS04YITCZP5sSL/M
P8+qIm90oNF9LjrjSR2JbUNB9dmnQTUGZGvSsJwxtXZ1TDDIG9LnP1hYRhCUfDiy
oN8dunXd4Mr+6sW1RRfkEjTQlKXSTClOt15dnmPmMJVe+1D8oXSsPDtmcpDqzc3n
t7wxB0YISkJWQjdjW9SSAiykto+rNaFBq4Y0BO49eNroDmaYW+CJ5uCf1K/fbd6t
draKQm1gIQiCr1Qxyr+bZlp6dUtSx2NQfAs44J2xubSgi2tVawJiu7KoCdfYepH+
+JSH4X5V30nwzQozfHvpFNQzNqLz8tlLVi+iUtXFIIGXmEqE9EW31EWghFOAoy8O
tFE0mwOpY7XfZHNxAMrhgqfxK+SLNM6wwFeqRKduiiqi8ytf7+q+2uMyZcRELd4D
D3zPSLpq4b23ooEDUPxRAJD+4IbOonrfE2+rPBHiKfBUV6WZ9Xe+KHAmKNndYBq7
AxfdUHcdz5AEi0Qxj7Wd0UzGkdhfLLmGw9tLgdnByvyRmVUCMdo=
=F2wr
-----END PGP SIGNATURE-----

--Yn/ju/WDGxBxechc--
