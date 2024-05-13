Received: from wfhigh5-smtp.messagingengine.com (wfhigh5-smtp.messagingengine.com [64.147.123.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5861146A98
	for <git@vger.kernel.org>; Mon, 13 May 2024 08:48:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715590088; cv=none; b=af2/daydwUF044wtZbGmCslXDrblrOqxZsbI8P+YlaIG+trq4bCZfbIh2svxBYiN7yWo9zMZwMq7K2IcSfH6+FK6ag9RF0moVK+eAcGntuzKoOwTnv8ci+p9CY0X3IsH2Nk1+HEbHFrVB7U8QLIafd/SWMqh+0B2fqSKZMpHIh0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715590088; c=relaxed/simple;
	bh=QtjfV7V6NdXsRv6YoAtrU4ClCr6LLIowABt20MWHtow=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nFoPZWFX6AZMo9viaDux28ienH/qiZcJYyHB/wN+oO0RLRaPf7AVA/cAplJ1jfG/vh0zXiWGuNBA32MnrVknWqB8Lq7cVhLHVD5K/9X8g3slCppwHnWALR+dfq+SAzYxCNanZvuWKEwjgepLC7AmBwBGsNnI4gzWN/9iYq2MI7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=lsjQeSBk; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=T565MZBe; arc=none smtp.client-ip=64.147.123.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="lsjQeSBk";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="T565MZBe"
Received: from compute7.internal (compute7.nyi.internal [10.202.2.48])
	by mailfhigh.west.internal (Postfix) with ESMTP id 0E6F71800080;
	Mon, 13 May 2024 04:48:05 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute7.internal (MEProxy); Mon, 13 May 2024 04:48:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1715590085; x=1715676485; bh=rVWkdb9tcW
	iNoEPv0KKrWd5SlqWtdfPc10uR6zVEQdM=; b=lsjQeSBk/IW135B+4231k+0QzH
	fdtOwFLRs+8zOPDFbhspraTxaqGxWIioKghiiV0qtMNLbi05xN0N0YAy18kWSLUR
	EfyG/oonYGR/AOKtO6BLQBdm+oksQPDzR3GxirJGy8DeMgyvQ0Cvsphvodwpq7WW
	F/7nCzX3G8UesuEErRbYyxUdsjjSvgRXVjMnjDqMlywmcA7Ku6IogWuKix/wPp44
	ZoPs/jPTEB/7HmVPSCI5CTFV0D5OAvK+vSh4Sun60XfMRL+/o+dz2nSu6KtDd0Ah
	RdLX+cjrHfNXgZ5EfrwtN4hhcd0goj2kZQadzRh2iRUVtjee06/9qmWAG4tw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1715590085; x=1715676485; bh=rVWkdb9tcWiNoEPv0KKrWd5SlqWt
	dfPc10uR6zVEQdM=; b=T565MZBe06fkLIjKA66ZHSa9DANUBa4OxbL3qHosCRAP
	CHabEBaDgJrTdfLKqURkz/L8VBodgTH8PmAbVDSm4oMCaymkT3TYfPTq87HjzXZS
	mpcqpvmEtocp9UWaWKleVL4N2EidEBN11CnCASLU8k1hqqxEuW4A24TTS1endqTu
	h0thT2i1TJjotQc0X7d+6cor93Sld5krhtlUBny+B/o8sq2eHjcLtI+Puj3sZuG8
	gyfDuRh27cexvOuq03eAOnvXu8aWriCAVuJ4SXPA7UscKSfImVUMY1K7vfAkDzY7
	TDUGq/TRDiboWx0zTd4VesdYUBybXxNxXiaz9LGwzw==
X-ME-Sender: <xms:xdNBZi1ILSVL1S1-XLl_mGmt7Ckz91_Zqh-D91Y_xK_pg31qe_ovnw>
    <xme:xdNBZlFFklqF6ALnk3migZxEn7bjt7ARM7KzEHnz2JhVH8V3ub99YZe9IZ6vXdbIn
    NvZyW6XMIcnyVWb-A>
X-ME-Received: <xmr:xdNBZq6hmhYbCW4aCe46osDeUkPdsD2hduK281270M8Ze15rdm-LXKqsiHXNYDGbeeqiEd_tgq66v93mIA2hfeE8qSWWJy8kf9aul17YJaPpJc8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdeggedgtdejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepueektdevtdffveeljeetgfehheeigeekleduvdeffeeghefgledttdehjeelffet
    necuvehluhhsthgvrhfuihiivgepudenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimh
X-ME-Proxy: <xmx:xdNBZj2XZMKrU0fYMa-yo29I1E5ovTN6u8-WHy59DHpENa10uWDq5g>
    <xmx:xdNBZlH3NLOq6ekeU9sx0EZ6HSnIEOkHhwg-GIpZ588_ecEPLq59XA>
    <xmx:xdNBZs-vUqH4O8R35yKl9n4WWHoAH2nZLRi__NYRpWZh6zLmfYWrtQ>
    <xmx:xdNBZqlmmgGz2hnQ3oHNinDm1I17Y__leKo6IGw5Hf6b1vZ1OpvLEA>
    <xmx:xdNBZlCgbQbTqOjujQ-XmFPK-7Q3WX87hQlvCO4EV3Fc2KwELzgSnVUq>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 13 May 2024 04:48:04 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id 38b09d1a (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 13 May 2024 08:47:45 +0000 (UTC)
Date: Mon, 13 May 2024 10:48:01 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, Justin Tobler <jltobler@gmail.com>
Subject: [PATCH v2 13/13] reftable/merged: adapt interface to allow reuse of
 iterators
Message-ID: <2586e93c448e5df2fab51ba231e413c12e522f0e.1715589670.git.ps@pks.im>
References: <cover.1715166175.git.ps@pks.im>
 <cover.1715589670.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="3Z9mbsZxUBxaaPMS"
Content-Disposition: inline
In-Reply-To: <cover.1715589670.git.ps@pks.im>


--3Z9mbsZxUBxaaPMS
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
2.45.GIT


--3Z9mbsZxUBxaaPMS
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmZB08AACgkQVbJhu7ck
PpQz2w//WUkHroLuKBWTv1ojKRYS0A5bWkJ52bfUYQ8/xtRwqoZgr70wIIaNC/aE
0slLdUhmh0biqPlDNXH/BIQYoqHdIALmj0NN4XZwkwkpBNkx/qnjNac6V1IHKTV3
zqjrPT/LQ254eZ0DrIzDutQ+rzvNd6Rs+70VM7mg59gBMl8kVA9VNR6jRiZFZ8Jv
FeN6whlyoBrxqEr/bgTEndcK3e32a7wolPpmLMCrQrjLkpHc0CWw+mkz4p4s8njr
PRJ2zyVw28LECf3gFSH8aGmS4L8SALLNVyV+u/HFtrUUrQE6A9+CBqUeLXfY+9Mc
HOLwfnu67hPpcPqKVkRWvxUNCXW3qdIdQ4Y9Vbbbaai8Jtt7BFowFK94QzeOeunD
Yqp0CNkB+nwTXy5f9R9d2qbgzEvH7JWXFUG0z+aYP5YppkZaZyRpVUw5Fl4KGWer
xV8jrTRsWrIWEE4azpnrDKN0Kds0dbHlD25VKwUTIz6iHbHqW+IAP0YQ/jtKLN7a
15AKvTMf0IR4Lj8sBpJaSKDp7e4yNAIuxP9f8V0N6P1upOD6GBlJr1L0Vj52mOoj
jt1CN5iztmvk72qGyQ6qn1933GYB35/E2ksjWrsq9oMDfUSMGRDYAXxBNDJRp/o2
Sr3x4h7XULQiEomRX0p0qQTxb2XTtgwWuOsU/DBCDxQNU/aWTYQ=
=YkTJ
-----END PGP SIGNATURE-----

--3Z9mbsZxUBxaaPMS--
