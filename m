Received: from fout8-smtp.messagingengine.com (fout8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A21681ACB
	for <git@vger.kernel.org>; Wed,  8 May 2024 11:04:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715166261; cv=none; b=XOTNMiSU/N3M/SBsatHGDkc2cai+4yhfL/vmyV21j2F1l8BT/BLNpDZH1+EXw6L930iMfpuRMnyx7f0eTSCbY1HVCuoftiu+vxRL2tKHV1K9/pzzCUW9so/FtU64E18EOkPmDJwO6XG3Ojnz96F+k3sPfJzB7PBS7J4VqbSBjw0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715166261; c=relaxed/simple;
	bh=gtIZz0tN0CeD2ACHsJepB10xLPHHvO+MSbgqhtPnfAk=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=APUebXuSUzJq/VTLrryML6uyPHWhzjlCpcZzM4v+zTupKBI/Kq4g23qbs44eb8W2gWFLXwcQAQ+pix/mdxARFIfUvjOv2+iUr9IZga/4ZNGORGDM4eALmmvl5Q7f8TY0uCT1c7PxTOSOFAsM6tnoiy6RxFaE+SuTSFUHz3+aspM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=hRNHK+9b; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=QupnhcTM; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="hRNHK+9b";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="QupnhcTM"
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailfout.nyi.internal (Postfix) with ESMTP id 689E31380FDD
	for <git@vger.kernel.org>; Wed,  8 May 2024 07:04:18 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Wed, 08 May 2024 07:04:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1715166258; x=1715252658; bh=DY4LCbNXgi
	INPrL4LYXaxpZGquKiJ/PjUBZ+FsOZr3c=; b=hRNHK+9bQAmk0WJH47h+dfaktP
	rTMd4CR9aTghCMcSAYOPyk9IoUaJG043hwO+xLKqMTpmHIOUvZ1xzOGHluwH6DQI
	I9L03grj4Qx4LCX6xLDZmro+M0AacA5LTHQjjHbPzI3mtbqJl3Rys+cy5gAhnucY
	gB15e4aXnvLOxzVtUnoXqmfgG3p/KsEkFOXFzkTH5yx64uZe5RGLOMChZreztZyu
	q0td0jGgchiFwU24nWYPT33MVmuF2YJnGzFphZC4l6uWAnCLHKlN9GyFA1/0Mks/
	qLtAXqffluHfQcUi59w/APFgK3i1r6iADbc1UtDINiLKzgAQp7DehAMDQYSg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1715166258; x=1715252658; bh=DY4LCbNXgiINPrL4LYXaxpZGquKi
	J/PjUBZ+FsOZr3c=; b=QupnhcTM5TyUZiPzVyzn1q/ToxPUn0ALiecpwyFAZMHu
	Kx93d8N60OHBjYk3SJYV7V7tnPBrgrxoAlDXIQHwrqdvPXsjgr3MXTuQdfk3m1zb
	VG5h9jle3OvIXlfZp1rN9+i4eCPU8EqJGhins/krIuBJkByxJMozDQyWbgWbfz4M
	RKZKKELwwZiCEO3aUAsF2UZ/P9O6FQuZYfLqZrwwXIWf1oH1QqU3q4EzpyTY9dZ0
	VulkOCSZwBCUZSgA+YIxFRqGB5hPnRAyqp7vVjTQzDiyZoTNUQEY3CmEYm8ZUiXd
	0PWAXVSG8U43GB8qmZ6a3jaOVgfMWhQejDZcJ5jfeA==
X-ME-Sender: <xms:Mlw7ZpjFbAjP6TNZYSR9RH00B0Ga5orzJXaJVXA3-jx-7eouLjjQcQ>
    <xme:Mlw7ZuDN7I_duLT2eNewZ3CZUx9A1GCokZNF-t81AZ3yl3aYb6WixPkUSWUtUHg2r
    v8mZOWVc0DLoeyjRg>
X-ME-Received: <xmr:Mlw7ZpFAqwrKR-WvlNFCEDu2qtsMT2zyN-eVAGEe3VbHqbEZWerhhY_zypYuOXYj3ZwW-zOp65KYWS-0jsWx3pL8g8i6oRfkt13CAciNSNFUKVUyJQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdeftddgfeegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvuffkfhggtggujgesghdtre
    ertddtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehp
    khhsrdhimheqnecuggftrfgrthhtvghrnhepheeghfdtfeeuffehkefgffduleffjedthf
    dvjeektdfhhedvlefgtefgvdettdfhnecuvehluhhsthgvrhfuihiivgepudenucfrrghr
    rghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimh
X-ME-Proxy: <xmx:Mlw7ZuQvfO8tja7fR-FqgBbD-JChGAq_bfyrr8prFh4VWqs5NgQ_eQ>
    <xmx:Mlw7ZmwAW6WmbWl8GGKZe8WJLMFiI8ncv79wSSLa-MUxUhFZSB9VDw>
    <xmx:Mlw7Zk7SlrZZCce8aabHScvNgJ9kdCLvVA1rzU-ZkIxag5LbjkGGbg>
    <xmx:Mlw7ZrwwrzV1HCrAF_Iu0dowqJPDPFcn_A8G3lMIBLlAc7c0Yu4YXg>
    <xmx:Mlw7ZrrTC6RErVQ8h_brcXqnfQBHyajVYzrpL0LBoXiwl3kBBpOqgrbC>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Wed, 8 May 2024 07:04:17 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id 6c928add (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Wed, 8 May 2024 11:04:08 +0000 (UTC)
Date: Wed, 8 May 2024 13:04:15 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Subject: [PATCH 09/13] reftable/generic: move seeking of records into the
 iterator
Message-ID: <859b399e71e92dd7aa0fa7fc9f2d9ca6f389d34a.1715166175.git.ps@pks.im>
References: <cover.1715166175.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="GdfDOH8lgVxFXxBz"
Content-Disposition: inline
In-Reply-To: <cover.1715166175.git.ps@pks.im>


--GdfDOH8lgVxFXxBz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Reftable iterators are created by seeking on the parent structure of a
corresponding record. For example, to create an iterator for the merged
table you would call `reftable_merged_table_seek_ref()`. Most notably,
it is not posible to create an iterator and then seek it afterwards.

While this may be a bit easier to reason about, it comes with two
significant downsides. The first downside is that the logic to find
records is split up between the parent data structure and the iterator
itself. Conceptually, it is more straight forward if all that logic was
contained in a single place, which should be the iterator.

The second and more significant downside is that it is impossible to
reuse iterators for multiple seeks. Whenever you want to look up a
record, you need to re-create the whole infrastructure again, which is
quite a waste of time. Furthermore, it is impossible to for example
optimize seeks, for example when seeking the same record multiple times.

To address this, we essentially split up the concerns properly such that
the parent data structure is responsible for setting up the iterator via
a new `init_iter()` callback, whereas the iterator handles seeks via a
new `seek()` callback. This will eventually allow us to call `seek()` on
the iterator multiple times, where every iterator can potentially
optimize for certain cases.

Note that at this point in time we are not yet ready to reuse the
iterators. This will be left for a future patch series.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 reftable/generic.c |  47 +++++++++++++----
 reftable/generic.h |   9 +++-
 reftable/iter.c    |  15 ++++++
 reftable/merged.c  |  97 +++++++++++++++++-----------------
 reftable/reader.c  | 126 +++++++++++++++++++++++++--------------------
 5 files changed, 177 insertions(+), 117 deletions(-)

diff --git a/reftable/generic.c b/reftable/generic.c
index b9f1c7c18a..1cf68fe124 100644
--- a/reftable/generic.c
+++ b/reftable/generic.c
@@ -12,25 +12,39 @@ license that can be found in the LICENSE file or at
 #include "reftable-iterator.h"
 #include "reftable-generic.h"
=20
+void table_init_iter(struct reftable_table *tab,
+		     struct reftable_iterator *it,
+		     uint8_t typ)
+{
+
+	tab->ops->init_iter(tab->table_arg, it, typ);
+}
+
 int reftable_table_seek_ref(struct reftable_table *tab,
 			    struct reftable_iterator *it, const char *name)
 {
-	struct reftable_record rec =3D { .type =3D BLOCK_TYPE_REF,
-				       .u.ref =3D {
-					       .refname =3D (char *)name,
-				       } };
-	return tab->ops->seek_record(tab->table_arg, it, &rec);
+	struct reftable_record want =3D {
+		.type =3D BLOCK_TYPE_REF,
+		.u.ref =3D {
+			.refname =3D (char *)name,
+		},
+	};
+	table_init_iter(tab, it, BLOCK_TYPE_REF);
+	return it->ops->seek(it->iter_arg, &want);
 }
=20
 int reftable_table_seek_log(struct reftable_table *tab,
 			    struct reftable_iterator *it, const char *name)
 {
-	struct reftable_record rec =3D { .type =3D BLOCK_TYPE_LOG,
-				       .u.log =3D {
-					       .refname =3D (char *)name,
-					       .update_index =3D ~((uint64_t)0),
-				       } };
-	return tab->ops->seek_record(tab->table_arg, it, &rec);
+	struct reftable_record want =3D {
+		.type =3D BLOCK_TYPE_LOG,
+		.u.log =3D {
+			.refname =3D (char *)name,
+			.update_index =3D ~((uint64_t)0),
+		},
+	};
+	table_init_iter(tab, it, BLOCK_TYPE_LOG);
+	return it->ops->seek(it->iter_arg, &want);
 }
=20
 int reftable_table_read_ref(struct reftable_table *tab, const char *name,
@@ -152,11 +166,21 @@ int reftable_iterator_next_log(struct reftable_iterat=
or *it,
 	return err;
 }
=20
+int iterator_seek(struct reftable_iterator *it, struct reftable_record *wa=
nt)
+{
+	return it->ops->seek(it->iter_arg, want);
+}
+
 int iterator_next(struct reftable_iterator *it, struct reftable_record *re=
c)
 {
 	return it->ops->next(it->iter_arg, rec);
 }
=20
+static int empty_iterator_seek(void *arg, struct reftable_record *want)
+{
+	return 0;
+}
+
 static int empty_iterator_next(void *arg, struct reftable_record *rec)
 {
 	return 1;
@@ -167,6 +191,7 @@ static void empty_iterator_close(void *arg)
 }
=20
 static struct reftable_iterator_vtable empty_vtable =3D {
+	.seek =3D &empty_iterator_seek,
 	.next =3D &empty_iterator_next,
 	.close =3D &empty_iterator_close,
 };
diff --git a/reftable/generic.h b/reftable/generic.h
index 98886a0640..8341fa570e 100644
--- a/reftable/generic.h
+++ b/reftable/generic.h
@@ -14,19 +14,24 @@ license that can be found in the LICENSE file or at
=20
 /* generic interface to reftables */
 struct reftable_table_vtable {
-	int (*seek_record)(void *tab, struct reftable_iterator *it,
-			   struct reftable_record *);
+	void (*init_iter)(void *tab, struct reftable_iterator *it, uint8_t typ);
 	uint32_t (*hash_id)(void *tab);
 	uint64_t (*min_update_index)(void *tab);
 	uint64_t (*max_update_index)(void *tab);
 };
=20
+void table_init_iter(struct reftable_table *tab,
+		     struct reftable_iterator *it,
+		     uint8_t typ);
+
 struct reftable_iterator_vtable {
+	int (*seek)(void *iter_arg, struct reftable_record *want);
 	int (*next)(void *iter_arg, struct reftable_record *rec);
 	void (*close)(void *iter_arg);
 };
=20
 void iterator_set_empty(struct reftable_iterator *it);
+int iterator_seek(struct reftable_iterator *it, struct reftable_record *wa=
nt);
 int iterator_next(struct reftable_iterator *it, struct reftable_record *re=
c);
=20
 #endif
diff --git a/reftable/iter.c b/reftable/iter.c
index aa9ac199b1..b4528fab47 100644
--- a/reftable/iter.c
+++ b/reftable/iter.c
@@ -23,6 +23,13 @@ static void filtering_ref_iterator_close(void *iter_arg)
 	reftable_iterator_destroy(&fri->it);
 }
=20
+static int filtering_ref_iterator_seek(void *iter_arg,
+				       struct reftable_record *want)
+{
+	struct filtering_ref_iterator *fri =3D iter_arg;
+	return iterator_seek(&fri->it, want);
+}
+
 static int filtering_ref_iterator_next(void *iter_arg,
 				       struct reftable_record *rec)
 {
@@ -73,6 +80,7 @@ static int filtering_ref_iterator_next(void *iter_arg,
 }
=20
 static struct reftable_iterator_vtable filtering_ref_iterator_vtable =3D {
+	.seek =3D &filtering_ref_iterator_seek,
 	.next =3D &filtering_ref_iterator_next,
 	.close =3D &filtering_ref_iterator_close,
 };
@@ -119,6 +127,12 @@ static int indexed_table_ref_iter_next_block(struct in=
dexed_table_ref_iter *it)
 	return 0;
 }
=20
+static int indexed_table_ref_iter_seek(void *p, struct reftable_record *wa=
nt)
+{
+	BUG("seeking indexed table is not supported");
+	return -1;
+}
+
 static int indexed_table_ref_iter_next(void *p, struct reftable_record *re=
c)
 {
 	struct indexed_table_ref_iter *it =3D p;
@@ -175,6 +189,7 @@ int new_indexed_table_ref_iter(struct indexed_table_ref=
_iter **dest,
 }
=20
 static struct reftable_iterator_vtable indexed_table_ref_iter_vtable =3D {
+	.seek =3D &indexed_table_ref_iter_seek,
 	.next =3D &indexed_table_ref_iter_next,
 	.close =3D &indexed_table_ref_iter_close,
 };
diff --git a/reftable/merged.c b/reftable/merged.c
index 18a2a6f09b..fc7946d90d 100644
--- a/reftable/merged.c
+++ b/reftable/merged.c
@@ -31,12 +31,18 @@ struct merged_iter {
 };
=20
 static void merged_iter_init(struct merged_iter *mi,
-			     struct reftable_merged_table *mt)
+			     struct reftable_merged_table *mt,
+			     uint8_t typ)
 {
 	memset(mi, 0, sizeof(*mi));
 	mi->advance_index =3D -1;
 	mi->suppress_deletions =3D mt->suppress_deletions;
+
 	REFTABLE_CALLOC_ARRAY(mi->subiters, mt->stack_len);
+	for (size_t i =3D 0; i < mt->stack_len; i++) {
+		reftable_record_init(&mi->subiters[i].rec, typ);
+		table_init_iter(&mt->stack[i], &mi->subiters[i].iter, typ);
+	}
 	mi->stack_len =3D mt->stack_len;
 }
=20
@@ -68,6 +74,27 @@ static int merged_iter_advance_subiter(struct merged_ite=
r *mi, size_t idx)
 	return 0;
 }
=20
+static int merged_iter_seek(struct merged_iter *mi, struct reftable_record=
 *want)
+{
+	int err;
+
+	mi->advance_index =3D -1;
+
+	for (size_t i =3D 0; i < mi->stack_len; i++) {
+		err =3D iterator_seek(&mi->subiters[i].iter, want);
+		if (err < 0)
+			return err;
+		if (err > 0)
+			continue;
+
+		err =3D merged_iter_advance_subiter(mi, i);
+		if (err < 0)
+			return err;
+	}
+
+	return 0;
+}
+
 static int merged_iter_next_entry(struct merged_iter *mi,
 				  struct reftable_record *rec)
 {
@@ -133,6 +160,11 @@ static int merged_iter_next_entry(struct merged_iter *=
mi,
 	return 0;
 }
=20
+static int merged_iter_seek_void(void *it, struct reftable_record *want)
+{
+	return merged_iter_seek(it, want);
+}
+
 static int merged_iter_next_void(void *p, struct reftable_record *rec)
 {
 	struct merged_iter *mi =3D p;
@@ -147,6 +179,7 @@ static int merged_iter_next_void(void *p, struct reftab=
le_record *rec)
 }
=20
 static struct reftable_iterator_vtable merged_iter_vtable =3D {
+	.seek =3D merged_iter_seek_void,
 	.next =3D &merged_iter_next_void,
 	.close =3D &merged_iter_close,
 };
@@ -220,47 +253,13 @@ reftable_merged_table_min_update_index(struct reftabl=
e_merged_table *mt)
 	return mt->min;
 }
=20
-static int reftable_table_seek_record(struct reftable_table *tab,
-				      struct reftable_iterator *it,
-				      struct reftable_record *rec)
-{
-	return tab->ops->seek_record(tab->table_arg, it, rec);
-}
-
-static int merged_table_seek_record(struct reftable_merged_table *mt,
-				    struct reftable_iterator *it,
-				    struct reftable_record *rec)
+static void merged_table_init_iter(struct reftable_merged_table *mt,
+				   struct reftable_iterator *it,
+				   uint8_t typ)
 {
-	struct merged_iter merged, *p;
-	int err;
-
-	merged_iter_init(&merged, mt);
-
-	for (size_t i =3D 0; i < mt->stack_len; i++) {
-		reftable_record_init(&merged.subiters[i].rec,
-				     reftable_record_type(rec));
-
-		err =3D reftable_table_seek_record(&mt->stack[i],
-						 &merged.subiters[i].iter, rec);
-		if (err < 0)
-			goto out;
-		if (err > 0)
-			continue;
-
-		err =3D merged_iter_advance_subiter(&merged, i);
-		if (err < 0)
-			goto out;
-	}
-
-	p =3D reftable_malloc(sizeof(*p));
-	*p =3D merged;
-	iterator_from_merged_iter(it, p);
-	err =3D 0;
-
-out:
-	if (err < 0)
-		merged_iter_close(&merged);
-	return err;
+	struct merged_iter *mi =3D reftable_malloc(sizeof(*mi));
+	merged_iter_init(mi, mt, typ);
+	iterator_from_merged_iter(it, mi);
 }
=20
 int reftable_merged_table_seek_ref(struct reftable_merged_table *mt,
@@ -273,7 +272,8 @@ int reftable_merged_table_seek_ref(struct reftable_merg=
ed_table *mt,
 			.refname =3D (char *)name,
 		},
 	};
-	return merged_table_seek_record(mt, it, &rec);
+	merged_table_init_iter(mt, it, BLOCK_TYPE_REF);
+	return iterator_seek(it, &rec);
 }
=20
 int reftable_merged_table_seek_log_at(struct reftable_merged_table *mt,
@@ -285,7 +285,8 @@ int reftable_merged_table_seek_log_at(struct reftable_m=
erged_table *mt,
 					       .refname =3D (char *)name,
 					       .update_index =3D update_index,
 				       } };
-	return merged_table_seek_record(mt, it, &rec);
+	merged_table_init_iter(mt, it, BLOCK_TYPE_LOG);
+	return iterator_seek(it, &rec);
 }
=20
 int reftable_merged_table_seek_log(struct reftable_merged_table *mt,
@@ -301,11 +302,11 @@ uint32_t reftable_merged_table_hash_id(struct reftabl=
e_merged_table *mt)
 	return mt->hash_id;
 }
=20
-static int reftable_merged_table_seek_void(void *tab,
-					   struct reftable_iterator *it,
-					   struct reftable_record *rec)
+static void reftable_merged_table_init_iter_void(void *tab,
+						 struct reftable_iterator *it,
+						 uint8_t typ)
 {
-	return merged_table_seek_record(tab, it, rec);
+	merged_table_init_iter(tab, it, typ);
 }
=20
 static uint32_t reftable_merged_table_hash_id_void(void *tab)
@@ -324,7 +325,7 @@ static uint64_t reftable_merged_table_max_update_index_=
void(void *tab)
 }
=20
 static struct reftable_table_vtable merged_table_vtable =3D {
-	.seek_record =3D reftable_merged_table_seek_void,
+	.init_iter =3D reftable_merged_table_init_iter_void,
 	.hash_id =3D reftable_merged_table_hash_id_void,
 	.min_update_index =3D reftable_merged_table_min_update_index_void,
 	.max_update_index =3D reftable_merged_table_max_update_index_void,
diff --git a/reftable/reader.c b/reftable/reader.c
index 021608f638..a5a13cb0b9 100644
--- a/reftable/reader.c
+++ b/reftable/reader.c
@@ -369,29 +369,6 @@ static int table_iter_next(struct table_iter *ti, stru=
ct reftable_record *rec)
 	}
 }
=20
-static int table_iter_next_void(void *ti, struct reftable_record *rec)
-{
-	return table_iter_next(ti, rec);
-}
-
-static void table_iter_close_void(void *ti)
-{
-	table_iter_close(ti);
-}
-
-static struct reftable_iterator_vtable table_iter_vtable =3D {
-	.next =3D &table_iter_next_void,
-	.close =3D &table_iter_close_void,
-};
-
-static void iterator_from_table_iter(struct reftable_iterator *it,
-				     struct table_iter *ti)
-{
-	assert(!it->ops);
-	it->iter_arg =3D ti;
-	it->ops =3D &table_iter_vtable;
-}
-
 static int table_iter_seek_to(struct table_iter *ti, uint64_t off, uint8_t=
 typ)
 {
 	int err;
@@ -576,43 +553,74 @@ static int table_iter_seek_indexed(struct table_iter =
*ti,
 	return err;
 }
=20
-static int reader_seek(struct reftable_reader *r, struct reftable_iterator=
 *it,
-		       struct reftable_record *rec)
+static int table_iter_seek(struct table_iter *ti,
+			   struct reftable_record *want)
 {
-	uint8_t typ =3D reftable_record_type(rec);
-	struct reftable_reader_offsets *offs =3D reader_offsets_for(r, typ);
-	struct table_iter ti, *p;
+	uint8_t typ =3D reftable_record_type(want);
+	struct reftable_reader_offsets *offs =3D reader_offsets_for(ti->r, typ);
 	int err;
=20
-	if (!offs->is_present) {
-		iterator_set_empty(it);
-		return 0;
-	}
-
-	table_iter_init(&ti, r);
-
-	err =3D table_iter_seek_start(&ti, reftable_record_type(rec),
+	err =3D table_iter_seek_start(ti, reftable_record_type(want),
 				    !!offs->index_offset);
 	if (err < 0)
 		goto out;
=20
 	if (offs->index_offset)
-		err =3D table_iter_seek_indexed(&ti, rec);
+		err =3D table_iter_seek_indexed(ti, want);
 	else
-		err =3D table_iter_seek_linear(&ti, rec);
+		err =3D table_iter_seek_linear(ti, want);
 	if (err)
 		goto out;
=20
-	REFTABLE_ALLOC_ARRAY(p, 1);
-	*p =3D ti;
-	iterator_from_table_iter(it, p);
-
 out:
-	if (err)
-		table_iter_close(&ti);
 	return err;
 }
=20
+static int table_iter_seek_void(void *ti, struct reftable_record *want)
+{
+	return table_iter_seek(ti, want);
+}
+
+static int table_iter_next_void(void *ti, struct reftable_record *rec)
+{
+	return table_iter_next(ti, rec);
+}
+
+static void table_iter_close_void(void *ti)
+{
+	table_iter_close(ti);
+}
+
+static struct reftable_iterator_vtable table_iter_vtable =3D {
+	.seek =3D &table_iter_seek_void,
+	.next =3D &table_iter_next_void,
+	.close =3D &table_iter_close_void,
+};
+
+static void iterator_from_table_iter(struct reftable_iterator *it,
+				     struct table_iter *ti)
+{
+	assert(!it->ops);
+	it->iter_arg =3D ti;
+	it->ops =3D &table_iter_vtable;
+}
+
+static void reader_init_iter(struct reftable_reader *r,
+			     struct reftable_iterator *it,
+			     uint8_t typ)
+{
+	struct reftable_reader_offsets *offs =3D reader_offsets_for(r, typ);
+
+	if (offs->is_present) {
+		struct table_iter *ti;
+		REFTABLE_ALLOC_ARRAY(ti, 1);
+		table_iter_init(ti, r);
+		iterator_from_table_iter(it, ti);
+	} else {
+		iterator_set_empty(it);
+	}
+}
+
 int reftable_reader_seek_ref(struct reftable_reader *r,
 			     struct reftable_iterator *it, const char *name)
 {
@@ -622,19 +630,23 @@ int reftable_reader_seek_ref(struct reftable_reader *=
r,
 			.refname =3D (char *)name,
 		},
 	};
-	return reader_seek(r, it, &rec);
+	reader_init_iter(r, it, BLOCK_TYPE_REF);
+	return iterator_seek(it, &rec);
 }
=20
 int reftable_reader_seek_log_at(struct reftable_reader *r,
 				struct reftable_iterator *it, const char *name,
 				uint64_t update_index)
 {
-	struct reftable_record rec =3D { .type =3D BLOCK_TYPE_LOG,
-				       .u.log =3D {
-					       .refname =3D (char *)name,
-					       .update_index =3D update_index,
-				       } };
-	return reader_seek(r, it, &rec);
+	struct reftable_record rec =3D {
+		.type =3D BLOCK_TYPE_LOG,
+		.u.log =3D {
+			.refname =3D (char *)name,
+			.update_index =3D update_index,
+		},
+	};
+	reader_init_iter(r, it, BLOCK_TYPE_LOG);
+	return iterator_seek(it, &rec);
 }
=20
 int reftable_reader_seek_log(struct reftable_reader *r,
@@ -692,7 +704,8 @@ static int reftable_reader_refs_for_indexed(struct reft=
able_reader *r,
 	struct indexed_table_ref_iter *itr =3D NULL;
=20
 	/* Look through the reverse index. */
-	err =3D reader_seek(r, &oit, &want);
+	reader_init_iter(r, &oit, BLOCK_TYPE_OBJ);
+	err =3D iterator_seek(&oit, &want);
 	if (err !=3D 0)
 		goto done;
=20
@@ -773,10 +786,11 @@ uint64_t reftable_reader_min_update_index(struct reft=
able_reader *r)
=20
 /* generic table interface. */
=20
-static int reftable_reader_seek_void(void *tab, struct reftable_iterator *=
it,
-				     struct reftable_record *rec)
+static void reftable_reader_init_iter_void(void *tab,
+					   struct reftable_iterator *it,
+					   uint8_t typ)
 {
-	return reader_seek(tab, it, rec);
+	reader_init_iter(tab, it, typ);
 }
=20
 static uint32_t reftable_reader_hash_id_void(void *tab)
@@ -795,7 +809,7 @@ static uint64_t reftable_reader_max_update_index_void(v=
oid *tab)
 }
=20
 static struct reftable_table_vtable reader_vtable =3D {
-	.seek_record =3D reftable_reader_seek_void,
+	.init_iter =3D reftable_reader_init_iter_void,
 	.hash_id =3D reftable_reader_hash_id_void,
 	.min_update_index =3D reftable_reader_min_update_index_void,
 	.max_update_index =3D reftable_reader_max_update_index_void,
--=20
2.45.0


--GdfDOH8lgVxFXxBz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmY7XC4ACgkQVbJhu7ck
PpSR0A/+LfDvKJ6wjlPArdn65N17vno3/c+0C7U/ciVcUZK0EUuASY2h3MmcPzl5
+V59iaB0mI6h1cRdP1n/CEjNHHFsLTO8+UPWUZr25pQ+uVMm6iAR0wGRG3PekQhq
KuoIb+jVDckXpVrCenrE1pGFhsstDK1l/3m8sy/LuWJJuYU3OkQEpchn+czGMHHa
QI5fPRQC5LHCHkVaQYIFwXItpILbDpg5Oo0KgKYZ3EIvi6aTtqHo9+lxyB+F10CT
IlNtxwabjY/k0Yff+DUSCVNUryVSY2qKTxmGeGYlXyYXBGDs1oPcBD43LFBvStu4
fjX1ewpHGKYswA/fFZV+uji0We8Q3g7+nfu9wHPqjVitPexod63TCUu8mFR5LaxO
d0NZknIlzoXrYz5Y5nbbS6A3RzYEpaIrCzvdNq5S02e0Ac9r5WITbWIoKAcvWk2h
EIoZ/ZJUhcPR++hRMnv1ZDQEjrmToETMwUfyN1Gk41Cvx/Ysv7jQvaD8ZBpWPwV9
k/Apjygj3XKJuF9qa9AlE4Nq4MG492vA2eaOZnvnLkOPFAxBsgaa/EcrFFPc0wxl
/7DuI/B6Vm/jwy1L0zmQ0B4K1YMwFDQfiC8T+XDjmkIa0I6En/b1SozVgign5LSy
31wKPYif28P8114C2bjSxx8h9M11as+NeEpdBUa4ggwMpabjJec=
=pVRm
-----END PGP SIGNATURE-----

--GdfDOH8lgVxFXxBz--
