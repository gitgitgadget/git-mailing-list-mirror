Received: from fout8-smtp.messagingengine.com (fout8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 647E281ADB
	for <git@vger.kernel.org>; Wed,  8 May 2024 11:04:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715166266; cv=none; b=KMePFKREg4oe2rWk5IDe7E2f38+W1KMvoXGuwNYJWsjhiEWQuX+OhKfhkUjv6CrI+S1NVM9lpk9f8BsKbcv0y80fvnNHdSdKrvXJq4SoGH546fiCgIwmPHOvxOKkkWna9t92ib7xPJDNTrdd74ZKvFRucGXKUe04t6MDzPiIGGA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715166266; c=relaxed/simple;
	bh=dNtgazP3paDLZTolGNwfBTwaqdWc6cO9SSS6XnFC2G8=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pYtdoJmiCh8kW6EjK2EhgNwNMATcAxyabXtAs0hJzmfV4OtzTpznGLKmuO4CGK+1z3/aXJt4HPmVHAj0hl8Xo+WVvoEBIR54q3ulHaecE+9uR0leAhOhGIFzY09v7/jmHkoMV+Enfx0Dn1sq7ElxGwoXcfh/lKhdxIUSVO0IONg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=DTYiHZ1X; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=bLBr4r9b; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="DTYiHZ1X";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="bLBr4r9b"
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfout.nyi.internal (Postfix) with ESMTP id 694F31380FDE
	for <git@vger.kernel.org>; Wed,  8 May 2024 07:04:23 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Wed, 08 May 2024 07:04:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1715166263; x=1715252663; bh=PqJZl9BwNp
	jh/OogDXxKv5delp23NJLgBYeAYwJ5uyY=; b=DTYiHZ1XyvudH2GOy7tnqyPxp+
	VY290PDBkV7he1+TMhpvvt/H20YXOj7+9cFJU2hSlM9QyR2bFY9p8rESV4PdtPjc
	6VGJyZADhrOZWQmvm7C64UV5si/PVuFXjuP4KpRRY5AtDH7p9dp4fuGbdSQmOFxO
	35fNC6IZyuqPVM/CUTtKdZAGb2Aa4c4Iu5hIJfA2ioGglWfmLnIadEMM0HuBjvXC
	I+7Y0KHCXHHXt89m7R2gJ251CWDCIJDwIeLgWCoBqX/cxBMUuPUOHOWVeRdntKPo
	neK51vth3QpICyvDHmiTYv5+BjNW5P1F4xWWKb5bmi3uZtcRT4GylvZwjhjQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1715166263; x=1715252663; bh=PqJZl9BwNpjh/OogDXxKv5delp23
	NJLgBYeAYwJ5uyY=; b=bLBr4r9bgnA/hUgBPf2VFNG11OBkv0VGvaWJHCsJntLd
	cYXRxaYaoQzvMB10MPyr9HGGoBJGhiBmj3ehwYL8z3G1Zul1CoWYLWyu3bFQAWW5
	uHsS4xoqTy66Dsnb3lgkpDEzNNXvnlFeenTDcyXsoC0vAomKxi5/X99YVOUapT3J
	yO5MLE2IZVS21MlilqkbvwguqdSUk4qfCB8ISait14uEuFMtoqq5UGTJ9KoXTsrM
	HV6g1KOqAJFa5YOCsIqwzKsV1azudIPfozYPCN6jRm1KIRQCX0/9fm17Ljs/q6qD
	sHUtntFOuG98/XkOpO7WziJZ1g1h04W124j7qduKeA==
X-ME-Sender: <xms:N1w7ZmSoQehY5MmJgDDxVkxhp94b6GqP_1VtkUFgoJ1ogx85niV05g>
    <xme:N1w7ZrymZB26C8oCHLDVWj3eNndN8hNb04WwiYyce8cNq34AfoJ4gUxyCkIfbjiU5
    Mm-hSJ7TbLV08QhIQ>
X-ME-Received: <xmr:N1w7Zj0-WKZoWB7EcPiXw5FM0FvbWvlEH8TNCqgjV43uxiqAkLMjq7fX75fEe3ADMWEUWOVcb4Dzqu1U11ibVegSj-sR-m5ZiciWOCdMlSWdUoR6Bw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdeftddgfeehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvuffkfhggtggujgesghdtre
    ertddtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehp
    khhsrdhimheqnecuggftrfgrthhtvghrnhepheeghfdtfeeuffehkefgffduleffjedthf
    dvjeektdfhhedvlefgtefgvdettdfhnecuvehluhhsthgvrhfuihiivgepudenucfrrghr
    rghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimh
X-ME-Proxy: <xmx:N1w7ZiC6nKYBuC2a2MCdkwYe1a-lUKrZNf_Lva3EuNhWbE2szC3lSw>
    <xmx:N1w7ZvjDt1HJTpLUCbCqvMzzTCBa9lH8H3Ird5eJyb7uep6xSbIi6g>
    <xmx:N1w7Zurc1R7rlKIzeE_1v9AaYFXnCP6slG19SeX8uS3kVUftqM8JIA>
    <xmx:N1w7Zijd3ktqoK8bMdXa6JX3Qb6qZznz7UyFnwFzV7DAOUi8nlx_lA>
    <xmx:N1w7ZnbpxLMqf8kAqbfq5sGw7LzOJIVkdU4DHm6ZttNT1Ji443VLQ4ck>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Wed, 8 May 2024 07:04:22 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id 880d599d (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Wed, 8 May 2024 11:04:13 +0000 (UTC)
Date: Wed, 8 May 2024 13:04:20 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Subject: [PATCH 10/13] reftable/generic: adapt interface to allow reuse of
 iterators
Message-ID: <727b8fa4327b710aba37b9cc7ca8de0f9bb2efaa.1715166175.git.ps@pks.im>
References: <cover.1715166175.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="FFcwl/GPHZ2X8izb"
Content-Disposition: inline
In-Reply-To: <cover.1715166175.git.ps@pks.im>


--FFcwl/GPHZ2X8izb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Refactor the interfaces exposed by `struct reftable_table` and `struct
reftable_iterator` such that they support iterator reuse. This is done
by separating initialization of the iterator and seeking on it.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 reftable/generic.c           | 53 ++++++++++++++++++++++++++----------
 reftable/iter.c              |  8 +++---
 reftable/reftable-generic.h  |  8 +++---
 reftable/reftable-iterator.h | 21 ++++++++++++++
 4 files changed, 68 insertions(+), 22 deletions(-)

diff --git a/reftable/generic.c b/reftable/generic.c
index 1cf68fe124..28ae26145e 100644
--- a/reftable/generic.c
+++ b/reftable/generic.c
@@ -20,8 +20,20 @@ void table_init_iter(struct reftable_table *tab,
 	tab->ops->init_iter(tab->table_arg, it, typ);
 }
=20
-int reftable_table_seek_ref(struct reftable_table *tab,
-			    struct reftable_iterator *it, const char *name)
+void reftable_table_init_ref_iter(struct reftable_table *tab,
+				  struct reftable_iterator *it)
+{
+	table_init_iter(tab, it, BLOCK_TYPE_REF);
+}
+
+void reftable_table_init_log_iter(struct reftable_table *tab,
+				  struct reftable_iterator *it)
+{
+	table_init_iter(tab, it, BLOCK_TYPE_LOG);
+}
+
+int reftable_iterator_seek_ref(struct reftable_iterator *it,
+			       const char *name)
 {
 	struct reftable_record want =3D {
 		.type =3D BLOCK_TYPE_REF,
@@ -29,29 +41,37 @@ int reftable_table_seek_ref(struct reftable_table *tab,
 			.refname =3D (char *)name,
 		},
 	};
-	table_init_iter(tab, it, BLOCK_TYPE_REF);
 	return it->ops->seek(it->iter_arg, &want);
 }
=20
-int reftable_table_seek_log(struct reftable_table *tab,
-			    struct reftable_iterator *it, const char *name)
+int reftable_iterator_seek_log_at(struct reftable_iterator *it,
+				  const char *name, uint64_t update_index)
 {
 	struct reftable_record want =3D {
 		.type =3D BLOCK_TYPE_LOG,
 		.u.log =3D {
 			.refname =3D (char *)name,
-			.update_index =3D ~((uint64_t)0),
+			.update_index =3D update_index,
 		},
 	};
-	table_init_iter(tab, it, BLOCK_TYPE_LOG);
 	return it->ops->seek(it->iter_arg, &want);
 }
=20
+int reftable_iterator_seek_log(struct reftable_iterator *it,
+			       const char *name)
+{
+	return reftable_iterator_seek_log_at(it, name, ~((uint64_t) 0));
+}
+
 int reftable_table_read_ref(struct reftable_table *tab, const char *name,
 			    struct reftable_ref_record *ref)
 {
 	struct reftable_iterator it =3D { NULL };
-	int err =3D reftable_table_seek_ref(tab, &it, name);
+	int err;
+
+	reftable_table_init_ref_iter(tab, &it);
+
+	err =3D reftable_iterator_seek_ref(&it, name);
 	if (err)
 		goto done;
=20
@@ -76,10 +96,13 @@ int reftable_table_print(struct reftable_table *tab) {
 	struct reftable_ref_record ref =3D { NULL };
 	struct reftable_log_record log =3D { NULL };
 	uint32_t hash_id =3D reftable_table_hash_id(tab);
-	int err =3D reftable_table_seek_ref(tab, &it, "");
-	if (err < 0) {
+	int err;
+
+	reftable_table_init_ref_iter(tab, &it);
+
+	err =3D reftable_iterator_seek_ref(&it, "");
+	if (err < 0)
 		return err;
-	}
=20
 	while (1) {
 		err =3D reftable_iterator_next_ref(&it, &ref);
@@ -94,10 +117,12 @@ int reftable_table_print(struct reftable_table *tab) {
 	reftable_iterator_destroy(&it);
 	reftable_ref_record_release(&ref);
=20
-	err =3D reftable_table_seek_log(tab, &it, "");
-	if (err < 0) {
+	reftable_table_init_log_iter(tab, &it);
+
+	err =3D reftable_iterator_seek_log(&it, "");
+	if (err < 0)
 		return err;
-	}
+
 	while (1) {
 		err =3D reftable_iterator_next_log(&it, &log);
 		if (err > 0) {
diff --git a/reftable/iter.c b/reftable/iter.c
index b4528fab47..fddea31e51 100644
--- a/reftable/iter.c
+++ b/reftable/iter.c
@@ -45,11 +45,11 @@ static int filtering_ref_iterator_next(void *iter_arg,
 		if (fri->double_check) {
 			struct reftable_iterator it =3D { NULL };
=20
-			err =3D reftable_table_seek_ref(&fri->tab, &it,
-						      ref->refname);
-			if (err =3D=3D 0) {
+			reftable_table_init_ref_iter(&fri->tab, &it);
+
+			err =3D reftable_iterator_seek_ref(&it, ref->refname);
+			if (err =3D=3D 0)
 				err =3D reftable_iterator_next_ref(&it, ref);
-			}
=20
 			reftable_iterator_destroy(&it);
=20
diff --git a/reftable/reftable-generic.h b/reftable/reftable-generic.h
index d239751a77..65670ea093 100644
--- a/reftable/reftable-generic.h
+++ b/reftable/reftable-generic.h
@@ -21,11 +21,11 @@ struct reftable_table {
 	void *table_arg;
 };
=20
-int reftable_table_seek_log(struct reftable_table *tab,
-			    struct reftable_iterator *it, const char *name);
+void reftable_table_init_ref_iter(struct reftable_table *tab,
+				  struct reftable_iterator *it);
=20
-int reftable_table_seek_ref(struct reftable_table *tab,
-			    struct reftable_iterator *it, const char *name);
+void reftable_table_init_log_iter(struct reftable_table *tab,
+				  struct reftable_iterator *it);
=20
 /* returns the hash ID from a generic reftable_table */
 uint32_t reftable_table_hash_id(struct reftable_table *tab);
diff --git a/reftable/reftable-iterator.h b/reftable/reftable-iterator.h
index d3eee7af35..e3bf688d53 100644
--- a/reftable/reftable-iterator.h
+++ b/reftable/reftable-iterator.h
@@ -21,12 +21,33 @@ struct reftable_iterator {
 	void *iter_arg;
 };
=20
+/*
+ * Position the iterator at the ref record with given name such that the n=
ext
+ * call to `next_ref()` would yield the record.
+ */
+int reftable_iterator_seek_ref(struct reftable_iterator *it,
+			       const char *name);
+
 /* reads the next reftable_ref_record. Returns < 0 for error, 0 for OK and=
 > 0:
  * end of iteration.
  */
 int reftable_iterator_next_ref(struct reftable_iterator *it,
 			       struct reftable_ref_record *ref);
=20
+/*
+ * Position the iterator at the log record with given name and update index
+ * such that the next call to `next_log()` would yield the record.
+ */
+int reftable_iterator_seek_log_at(struct reftable_iterator *it,
+				  const char *name, uint64_t update_index);
+
+/*
+ * Position the iterator at the newest log record with given name such tha=
t the
+ * next call to `next_log()` would yield the record.
+ */
+int reftable_iterator_seek_log(struct reftable_iterator *it,
+			       const char *name);
+
 /* reads the next reftable_log_record. Returns < 0 for error, 0 for OK and=
 > 0:
  * end of iteration.
  */
--=20
2.45.0


--FFcwl/GPHZ2X8izb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmY7XDMACgkQVbJhu7ck
PpQqqA//aVHaR0AllIb7y7iqI8h7u3kN7WIV8khe2Td3IIaBZ6IBtKXCR9A/xELN
xplAM5QrvmlJmGzluDORTXDNx50TzpRniy3GBIQ/tnK/3T1W/A4H1JniJHhtnxJZ
KAVhBuUbWeDrEXYxpuOaRCVLQm5PXJWI8Z19ZPv/0lmxVof2CYMFjp9B3kuMdFxz
mEVyj0YmEbD4ijwjNANCsmccZN5q7cqvVMu2enn9I7SLLmwwIaRBYV7ffZkpqpNI
3994w+WQ6GvVvWYvp2KJJdoxWopShLiMijY44n3vhdChZbLu1iVxD4thv1qsFH+D
rbIIngV7K2GKw/yDD2L23+g36y6JPKv6O0JmL0lC0clj2en9DJjB+fdmkNEToodJ
ZznwL+Jckfc50oua2pM5OxUPdwsw9/0wL12ffWHvtjVrgoOU97Eqbr7qqc59ClFW
7Ql+EQpi/a5iLAeQUvvNXeYJAppI2noCXeZmwtvv7Cp8FjkxvdoHMUkbK2JkdZ+8
BTrs3QgaPWeMrsSXb2BY6+bqVVFbXKUg7KI9zzpGswI+T4BOEx0qUTI0GponsI9v
d+mbm5DDvzD+/RB4FTShK1m/r+fIdAHFyND9VUKkmz9UetqSjvm5qskBRs1M4Cfy
1Z9c542HWJ49ToyddG6HYeX83LcyzdGkP7VX4BayVW1uD46E3x4=
=IzFC
-----END PGP SIGNATURE-----

--FFcwl/GPHZ2X8izb--
