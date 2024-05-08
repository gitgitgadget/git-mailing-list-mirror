Received: from fhigh4-smtp.messagingengine.com (fhigh4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 296AB81AC6
	for <git@vger.kernel.org>; Wed,  8 May 2024 11:04:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715166280; cv=none; b=IXV6KaSdLGxzFUZ3w7wWKadAZLUxWMAd+T9qLoDP0ufPRsjYPKIX/OvAl6uEBpIAI0F5mIdIL3wZtX4fiv6VIS1+FqXSAZ3dBtPvv0B+pu5zEUAkc71xZ1uwlMlrP+RfRFLCJ2RObNjoWprsQ8aOh2zPbC1eZz6dI3MfVfI7Jg8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715166280; c=relaxed/simple;
	bh=eBoySqkf27Q0KWpaAlTybHhiojZ8sWDJLk4dR73cTQo=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DyPxeuKEeLkTZ1nQ0hB7+WAqwXj7bmxAYzhbQ924KkKL7wgtnNYnF+2mAdcaB+20qcr/iNADp4ZlwP2d+ywMIZnhtv45rz/TIMboa5IjT/gGcBu558GE7hQaGoxyz0wKRAz8/8BdJ2VppNGr3B6wUdz6iBy2wwn7THi6DYLqogk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=fn6cda0u; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=UnLDqm1p; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="fn6cda0u";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="UnLDqm1p"
Received: from compute7.internal (compute7.nyi.internal [10.202.2.48])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 4E3551140244
	for <git@vger.kernel.org>; Wed,  8 May 2024 07:04:38 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute7.internal (MEProxy); Wed, 08 May 2024 07:04:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1715166278; x=1715252678; bh=8KRbM0X1TB
	akb6vLHYqsNjMIfYVGHEpO08cuEXrclYw=; b=fn6cda0u036WO+iKYEK6UiQVSE
	DG0/hemyyxuKd+6TO9bnmRY8mP/QVFD4/LwAdz/O7hyD/NRF4++0Lj6Btn7jFYun
	rlhuuH46bwb7h5lcvGyAxhB9PZm/lIbm4wPXalt23aUhqstE1j2RmtIme7erwNCK
	QUDIDRoKFDQddhFhmoEx6yhHjh+/GMD9XsM+2OaWPxd3vLxT70s0mfBrnmxIVO8V
	wHPpGc2VjNlwPeIAHwz8/19MudCaOjYTGMapeBQ5COkj55YwzpO/zqCOdD9l3pjo
	RZ/z3hTp7U2+8Qrln9LoT0ES3ODZILY9YGDsiTJc94GdOiHn6uIfn+vfEsXQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1715166278; x=1715252678; bh=8KRbM0X1TBakb6vLHYqsNjMIfYVG
	HEpO08cuEXrclYw=; b=UnLDqm1p27+T7/Hw+5Ky8VlgRJyCiDnv6TRmDMh/ToJt
	uR+yhomFI6e19PnG1/OzFiLAA1yzC2PhwMk41E4OpfFDUlPSRGhBvgMO4nFPeFZk
	ddilnVQN4nv38vYWhgSL6ZgXF96eaZjLkcvY9TtTdOsuOGx6/pSELxGXbXpPqQ4p
	EBf3DsrdFCtK2jWQMbsgGnecLC1i+flR+Bv2G8zpSaD2x/FNANbfMvCJa/ZIum7y
	0V0/E7+ILkkOYxJOhliJGgq/fSM91XbNNqAiy/ZKI4PN1DHRFFr3+3Z7fsMpDZ3A
	l0yLPC4tZk/x1vlsXIwrKZkY+gvIlxVt4I00detsXg==
X-ME-Sender: <xms:Rlw7Zn3Sl7q1pekoaoEJr30S_tRn6hwsii-HCQZUaFgfTO0PvnnJCg>
    <xme:Rlw7ZmEJ85JV9r-IAXdwnkPzEvO2KEHo4NeHwwtMywbpQFVpAh61Be1A9i4GRDKC0
    JM2ftrKX74QY90mCA>
X-ME-Received: <xmr:Rlw7Zn58tKYS4DgqYmmGItwgKjA9R6Tq8Sezj4rae13tT9HAMuEOygDx6LnZ5wn5mBrZNUeMaAE-8NVm-bLIhkqN9ma0TrJGxVW6V3Sl_lNWrQnCyQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdeftddgfeehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvuffkfhggtggujgesghdtre
    ertddtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehp
    khhsrdhimheqnecuggftrfgrthhtvghrnhepheeghfdtfeeuffehkefgffduleffjedthf
    dvjeektdfhhedvlefgtefgvdettdfhnecuvehluhhsthgvrhfuihiivgeptdenucfrrghr
    rghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimh
X-ME-Proxy: <xmx:Rlw7Zs2hvW8TEcthuA4lKR7lhApK6VygncuAXIjQW-FkRvty0zgfPw>
    <xmx:Rlw7ZqHWWx4mr8WcIvSBYlBIbGVDKxIkqkrbyTiWmQlEuviizlEbFw>
    <xmx:Rlw7Zt-kQWuD18jzdhlo2aLHQepawBJ6aEIjCopPXzRt9l3DYKztag>
    <xmx:Rlw7ZnkeRXdO7EaU0ZP9dwQ4sJa9ceMa2dwu9-fIizr-YpDOU34TGA>
    <xmx:Rlw7ZsM56P-ns_-IqILwBCBnPEJplCoGraS0KJqFxhugs-lnW4gkpqHv>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Wed, 8 May 2024 07:04:37 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id 50e1c715 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Wed, 8 May 2024 11:04:27 +0000 (UTC)
Date: Wed, 8 May 2024 13:04:35 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Subject: [PATCH 13/13] reftable/merged: adapt interface to allow reuse of
 iterators
Message-ID: <be4da295c6a716dd56604101828a3d38b6fcf067.1715166175.git.ps@pks.im>
References: <cover.1715166175.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="3Wj/k0XwDEYjEVhd"
Content-Disposition: inline
In-Reply-To: <cover.1715166175.git.ps@pks.im>


--3Wj/k0XwDEYjEVhd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Refactor the interfaces exposed by `struct reftable_merged_table` and
`struct merged_iter` such that they support iterator reuse. This is done
by separating initialization of the iterator and seeking on it.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 reftable/merged.c          | 35 -----------------------------------
 reftable/merged_test.c     | 19 +++++++++++++------
 reftable/reftable-merged.h | 15 ---------------
 reftable/stack.c           | 14 +++++++++-----
 4 files changed, 22 insertions(+), 61 deletions(-)

diff --git a/reftable/merged.c b/reftable/merged.c
index d127f99360..0da9dba265 100644
--- a/reftable/merged.c
+++ b/reftable/merged.c
@@ -262,41 +262,6 @@ void merged_table_init_iter(struct reftable_merged_tab=
le *mt,
 	iterator_from_merged_iter(it, mi);
 }
=20
-int reftable_merged_table_seek_ref(struct reftable_merged_table *mt,
-				   struct reftable_iterator *it,
-				   const char *name)
-{
-	struct reftable_record rec =3D {
-		.type =3D BLOCK_TYPE_REF,
-		.u.ref =3D {
-			.refname =3D (char *)name,
-		},
-	};
-	merged_table_init_iter(mt, it, BLOCK_TYPE_REF);
-	return iterator_seek(it, &rec);
-}
-
-int reftable_merged_table_seek_log_at(struct reftable_merged_table *mt,
-				      struct reftable_iterator *it,
-				      const char *name, uint64_t update_index)
-{
-	struct reftable_record rec =3D { .type =3D BLOCK_TYPE_LOG,
-				       .u.log =3D {
-					       .refname =3D (char *)name,
-					       .update_index =3D update_index,
-				       } };
-	merged_table_init_iter(mt, it, BLOCK_TYPE_LOG);
-	return iterator_seek(it, &rec);
-}
-
-int reftable_merged_table_seek_log(struct reftable_merged_table *mt,
-				   struct reftable_iterator *it,
-				   const char *name)
-{
-	uint64_t max =3D ~((uint64_t)0);
-	return reftable_merged_table_seek_log_at(mt, it, name, max);
-}
-
 uint32_t reftable_merged_table_hash_id(struct reftable_merged_table *mt)
 {
 	return mt->hash_id;
diff --git a/reftable/merged_test.c b/reftable/merged_test.c
index 530fc82d1c..33a17efcde 100644
--- a/reftable/merged_test.c
+++ b/reftable/merged_test.c
@@ -12,6 +12,7 @@ license that can be found in the LICENSE file or at
=20
 #include "basics.h"
 #include "blocksource.h"
+#include "constants.h"
 #include "reader.h"
 #include "record.h"
 #include "test_framework.h"
@@ -145,7 +146,10 @@ static void test_merged_between(void)
 	int i;
 	struct reftable_ref_record ref =3D { NULL };
 	struct reftable_iterator it =3D { NULL };
-	int err =3D reftable_merged_table_seek_ref(mt, &it, "a");
+	int err;
+
+	merged_table_init_iter(mt, &it, BLOCK_TYPE_REF);
+	err =3D reftable_iterator_seek_ref(&it, "a");
 	EXPECT_ERR(err);
=20
 	err =3D reftable_iterator_next_ref(&it, &ref);
@@ -217,14 +221,15 @@ static void test_merged(void)
 	struct reftable_reader **readers =3D NULL;
 	struct reftable_merged_table *mt =3D
 		merged_table_from_records(refs, &bs, &readers, sizes, bufs, 3);
-
 	struct reftable_iterator it =3D { NULL };
-	int err =3D reftable_merged_table_seek_ref(mt, &it, "a");
+	int err;
 	struct reftable_ref_record *out =3D NULL;
 	size_t len =3D 0;
 	size_t cap =3D 0;
 	int i =3D 0;
=20
+	merged_table_init_iter(mt, &it, BLOCK_TYPE_REF);
+	err =3D reftable_iterator_seek_ref(&it, "a");
 	EXPECT_ERR(err);
 	EXPECT(reftable_merged_table_hash_id(mt) =3D=3D GIT_SHA1_FORMAT_ID);
 	EXPECT(reftable_merged_table_min_update_index(mt) =3D=3D 1);
@@ -348,14 +353,15 @@ static void test_merged_logs(void)
 	struct reftable_reader **readers =3D NULL;
 	struct reftable_merged_table *mt =3D merged_table_from_log_records(
 		logs, &bs, &readers, sizes, bufs, 3);
-
 	struct reftable_iterator it =3D { NULL };
-	int err =3D reftable_merged_table_seek_log(mt, &it, "a");
+	int err;
 	struct reftable_log_record *out =3D NULL;
 	size_t len =3D 0;
 	size_t cap =3D 0;
 	int i =3D 0;
=20
+	merged_table_init_iter(mt, &it, BLOCK_TYPE_LOG);
+	err =3D reftable_iterator_seek_log(&it, "a");
 	EXPECT_ERR(err);
 	EXPECT(reftable_merged_table_hash_id(mt) =3D=3D GIT_SHA1_FORMAT_ID);
 	EXPECT(reftable_merged_table_min_update_index(mt) =3D=3D 1);
@@ -377,7 +383,8 @@ static void test_merged_logs(void)
 						 GIT_SHA1_RAWSZ));
 	}
=20
-	err =3D reftable_merged_table_seek_log_at(mt, &it, "a", 2);
+	merged_table_init_iter(mt, &it, BLOCK_TYPE_LOG);
+	err =3D reftable_iterator_seek_log_at(&it, "a", 2);
 	EXPECT_ERR(err);
 	reftable_log_record_release(&out[0]);
 	err =3D reftable_iterator_next_log(&it, &out[0]);
diff --git a/reftable/reftable-merged.h b/reftable/reftable-merged.h
index c91a2d83a2..14d5fc9f05 100644
--- a/reftable/reftable-merged.h
+++ b/reftable/reftable-merged.h
@@ -36,21 +36,6 @@ int reftable_new_merged_table(struct reftable_merged_tab=
le **dest,
 			      struct reftable_table *stack, size_t n,
 			      uint32_t hash_id);
=20
-/* returns an iterator positioned just before 'name' */
-int reftable_merged_table_seek_ref(struct reftable_merged_table *mt,
-				   struct reftable_iterator *it,
-				   const char *name);
-
-/* returns an iterator for log entry, at given update_index */
-int reftable_merged_table_seek_log_at(struct reftable_merged_table *mt,
-				      struct reftable_iterator *it,
-				      const char *name, uint64_t update_index);
-
-/* like reftable_merged_table_seek_log_at but look for the newest entry. */
-int reftable_merged_table_seek_log(struct reftable_merged_table *mt,
-				   struct reftable_iterator *it,
-				   const char *name);
-
 /* returns the max update_index covered by this merged table. */
 uint64_t
 reftable_merged_table_max_update_index(struct reftable_merged_table *mt);
diff --git a/reftable/stack.c b/reftable/stack.c
index 03f95935e1..7af4c3fd66 100644
--- a/reftable/stack.c
+++ b/reftable/stack.c
@@ -925,7 +925,8 @@ static int stack_write_compact(struct reftable_stack *s=
t,
 		goto done;
 	}
=20
-	err =3D reftable_merged_table_seek_ref(mt, &it, "");
+	merged_table_init_iter(mt, &it, BLOCK_TYPE_REF);
+	err =3D reftable_iterator_seek_ref(&it, "");
 	if (err < 0)
 		goto done;
=20
@@ -949,7 +950,8 @@ static int stack_write_compact(struct reftable_stack *s=
t,
 	}
 	reftable_iterator_destroy(&it);
=20
-	err =3D reftable_merged_table_seek_log(mt, &it, "");
+	merged_table_init_iter(mt, &it, BLOCK_TYPE_LOG);
+	err =3D reftable_iterator_seek_log(&it, "");
 	if (err < 0)
 		goto done;
=20
@@ -1340,9 +1342,11 @@ int reftable_stack_read_ref(struct reftable_stack *s=
t, const char *refname,
 int reftable_stack_read_log(struct reftable_stack *st, const char *refname,
 			    struct reftable_log_record *log)
 {
-	struct reftable_iterator it =3D { NULL };
-	struct reftable_merged_table *mt =3D reftable_stack_merged_table(st);
-	int err =3D reftable_merged_table_seek_log(mt, &it, refname);
+	struct reftable_iterator it =3D {0};
+	int err;
+
+	reftable_stack_init_log_iterator(st, &it);
+	err =3D reftable_iterator_seek_log(&it, refname);
 	if (err)
 		goto done;
=20
--=20
2.45.0


--3Wj/k0XwDEYjEVhd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmY7XEIACgkQVbJhu7ck
PpRl/xAAikhUBXfo/u+qlP2szdm5BXdnuIyTCueTEQWby6AMeuRz5eR4Z+39c8kX
y2uCUse1HQG05BxLm+sHdrhu8Z4Z6fVg8To8pmdIQ+s6O6rqiUphoDIIlLYPKwsB
NoDFxv4AgqkseLvk4vnO0jANai+E8lZ/QNBeSQcdiaYHY9+Pvj2hrIgwhGf9xXuK
/1Q+2Am5IUncfwSHG+7GpqNEKsa7Inu/DOfrkeO4szrEplZgKNBZ/oEC8me+Kx1v
mkQqDaGmqoVGT8/to12hAalrBafi5owHjf0ED+Wh4D31XRvqJrmJo4a6M9UOzgGb
0F9SC74E8EFnyY8ZG4mvfPvky5Cz0jdRlKuuyuNFDacl1NOLe+CaSxaVnFPZE3Ka
a0hCWFIRamqS2F1NfKEkl9NoI9LaSHVyosc6cl/vZcuglsbwYEx6HhBlYfOdPih6
sTj+CcVvy0HzqERjwUcf1OGme4AAV5vLSzSSmUJOAFH2K1lJMjS1GJtQ6dcVxoP3
Bp2ZrOZJRpzF6l5cwQrZglDwh2Hd6xY1nQnz/KPNYXuaMcoB0Txc2EIDAjohj6DJ
+bCLw17uKNuNA3lf2Voe0+gHtb69x/Y9iY73LeV+0HbZlwFtH1J73/AXwQ62uyEp
h9hrvM1miYIObzANztNmQ6nu/wbUFbNK8kx4REcYPtqAEGjvsgE=
=RBWs
-----END PGP SIGNATURE-----

--3Wj/k0XwDEYjEVhd--
