Received: from fout4-smtp.messagingengine.com (fout4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 349481B1510
	for <git@vger.kernel.org>; Wed, 14 Aug 2024 13:23:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723641786; cv=none; b=k4D1zF22CVM/6LJEmCV2/knQz76fWJBUZO8mf695Tyo1ABporyRYbE/L+oULJvKfVl0Bsb/xxcwsnSfjA2AlO84+xu0w5BcHbF3O9B1iTqhQml/rVbSdowNP8NoHpu+1gkT7mr1iMyKpmM2Mv8NS0KsQk/rGPdZF4N+e8aQY3Ms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723641786; c=relaxed/simple;
	bh=uXxCfkCxNhwJ7qmJTH0b8MuuiJhPQUI7Mht6eDb516I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Th9xWOCx9bs6g8nZ+c1ClVdmwgexRIpuqmwkMLjBCUKt7XIzZtYZh5kFsejfgwHgGpERQjfXretpGpu3CCCiOie4INLC+catcH7PfDr97NRcCPRVGqBvp8FD6Z/ZyEI1M2U5CVy33txLeZ6PWLRuZPcac5DKSDtSrcoKMVaqJ4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=E0OY5KJV; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=sPyeM9i2; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="E0OY5KJV";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="sPyeM9i2"
Received: from phl-compute-06.internal (phl-compute-06.nyi.internal [10.202.2.46])
	by mailfout.nyi.internal (Postfix) with ESMTP id 601FA138FC58;
	Wed, 14 Aug 2024 09:23:04 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Wed, 14 Aug 2024 09:23:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1723641784; x=1723728184; bh=X5dImPvxaB
	r1OEmFBFFUbv+Y5ljaOCiGMjwVBWYOCFk=; b=E0OY5KJV0b5c21SfI/PbcPM2Cs
	EVKxTReS19sztKG+BWKdK3dVctyFZUBPTGrzUCrsOCtvb0/2hVz8cBRJhGf+r0YB
	UnDLaJJuU1SaF1ASjZkDMF0Jdv5TlDNzTHYQ3xQpQSFpGrRctIGwoLcLIUJK6CbU
	nvXtUoLlcfBcwftNnWpY+53+7h9zoNFE/YWtCcB2SqM99L5lS5NOhhNpDfSDb2fd
	TiueRudIxHianqpnvlPkvAar+k+hpikxqrS8+Qfz1fdYQXQvX33QjyoVLlrr8kzW
	Sq/sdGCmbcv/N4g4AX5kU42s+UOiQaJckK+yL8Daa3TkjF4PB3rRdDFYGlpA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1723641784; x=1723728184; bh=X5dImPvxaBr1OEmFBFFUbv+Y5lja
	OCiGMjwVBWYOCFk=; b=sPyeM9i2lUAzHCqFoM19frJhve3r7SOCbLA67WxyMfJb
	KplxWxhaJrJRn8fcD8HksnfbDxLuBg+EQw9nh0vGV1i6z+RSNcj9935xcW0hmJFm
	lOaeIERb5/jTTUz47huWdAjewCVZxS/Y/ELIgjEL9OZzY+Nqm4/ye6crAB9TdQnX
	0eMvvEVcu3YiKsB/gpZdtCBtCEY/8X0HUkIU7YUk/CSZiv0PSkzRjm8W8dl1uyeL
	qC/YM2sOYG1wUyTCc3wfCoSRu244U9Ai6q0pPhm2ciuSMy/xO6NmiQE8EIcp77NS
	30jC9ravv+WReyexnJV1ZFpIB6pp2KRxsJWhO/tSzg==
X-ME-Sender: <xms:uK-8ZjTwRgea0UQqUmjHwwsrwTUrlcwOaglRTpYVcSkmFK_le33fRQ>
    <xme:uK-8Zkwa6aRopPkxumMylCZgZvFL2R79X8ICF0cLFVpr0ASfuCyUEXj0s6sABPlQF
    SwcAVCv4r7Gj4YoxA>
X-ME-Received: <xmr:uK-8Zo3SUMIvChUa1phJXe3jDEfjyAumD0FfvT0O9xp0jhJGtWzkMBs6TnYvrFoc_VLDhoVgcP5HU62zX96VVNcQMQjmbtDV6PTkD4lr6VmQog>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddruddtgedgieehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefgueeg
    udfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepvddpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepkhgrrhhthhhikhdrudekkeesghhmrghilhdrtghomh
    dprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:uK-8ZjDAc_6SkT68Sql5_i1rlpt91wSJpvS-vSzXXCatMzFPJ7qXsg>
    <xmx:uK-8Zsi4d17ZenKsa9uqpv5lSSNQfoQmWitMvNwvvl6Er-MOQWOkRw>
    <xmx:uK-8Znr5QxIOpV2V1xyy--wiyVEd1dKf28KoLdj0IICBOyoQ4zIyRQ>
    <xmx:uK-8ZnhmKhQ7rnHwsXqB7KQ__DPff0vkQM5eoSvFumEVCG4Qp1KlYA>
    <xmx:uK-8ZvsW5jLKbxOdGaGQO0pmgNMxdy-a26leAd6q9VLgXJEji8w0nHbt>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 14 Aug 2024 09:23:03 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 42923f80 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 14 Aug 2024 13:22:44 +0000 (UTC)
Date: Wed, 14 Aug 2024 15:23:01 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: karthik nayak <karthik.188@gmail.com>
Subject: [PATCH v2 06/15] reftable/generic: move generic iterator code into
 iterator interface
Message-ID: <103262dc79c300c861c677437e036ca904bfc7ef.1723640107.git.ps@pks.im>
References: <cover.1723640107.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1723640107.git.ps@pks.im>

Move functions relating to the reftable iterator from "generic.c" into
"iter.c". This prepares for the removal of the former subsystem.

While at it, remove some unneeded braces to conform to our coding style.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 reftable/generic.c | 107 +--------------------------------------------
 reftable/generic.h |  10 -----
 reftable/iter.c    | 105 ++++++++++++++++++++++++++++++++++++++++++++
 reftable/iter.h    |  27 ++++++++++++
 4 files changed, 133 insertions(+), 116 deletions(-)

diff --git a/reftable/generic.c b/reftable/generic.c
index 28ae26145e..6ecf9b880f 100644
--- a/reftable/generic.c
+++ b/reftable/generic.c
@@ -9,6 +9,7 @@ license that can be found in the LICENSE file or at
 #include "constants.h"
 #include "record.h"
 #include "generic.h"
+#include "iter.h"
 #include "reftable-iterator.h"
 #include "reftable-generic.h"
 
@@ -32,37 +33,6 @@ void reftable_table_init_log_iter(struct reftable_table *tab,
 	table_init_iter(tab, it, BLOCK_TYPE_LOG);
 }
 
-int reftable_iterator_seek_ref(struct reftable_iterator *it,
-			       const char *name)
-{
-	struct reftable_record want = {
-		.type = BLOCK_TYPE_REF,
-		.u.ref = {
-			.refname = (char *)name,
-		},
-	};
-	return it->ops->seek(it->iter_arg, &want);
-}
-
-int reftable_iterator_seek_log_at(struct reftable_iterator *it,
-				  const char *name, uint64_t update_index)
-{
-	struct reftable_record want = {
-		.type = BLOCK_TYPE_LOG,
-		.u.log = {
-			.refname = (char *)name,
-			.update_index = update_index,
-		},
-	};
-	return it->ops->seek(it->iter_arg, &want);
-}
-
-int reftable_iterator_seek_log(struct reftable_iterator *it,
-			       const char *name)
-{
-	return reftable_iterator_seek_log_at(it, name, ~((uint64_t) 0));
-}
-
 int reftable_table_read_ref(struct reftable_table *tab, const char *name,
 			    struct reftable_ref_record *ref)
 {
@@ -152,78 +122,3 @@ uint32_t reftable_table_hash_id(struct reftable_table *tab)
 {
 	return tab->ops->hash_id(tab->table_arg);
 }
-
-void reftable_iterator_destroy(struct reftable_iterator *it)
-{
-	if (!it->ops) {
-		return;
-	}
-	it->ops->close(it->iter_arg);
-	it->ops = NULL;
-	FREE_AND_NULL(it->iter_arg);
-}
-
-int reftable_iterator_next_ref(struct reftable_iterator *it,
-			       struct reftable_ref_record *ref)
-{
-	struct reftable_record rec = {
-		.type = BLOCK_TYPE_REF,
-		.u = {
-			.ref = *ref
-		},
-	};
-	int err = iterator_next(it, &rec);
-	*ref = rec.u.ref;
-	return err;
-}
-
-int reftable_iterator_next_log(struct reftable_iterator *it,
-			       struct reftable_log_record *log)
-{
-	struct reftable_record rec = {
-		.type = BLOCK_TYPE_LOG,
-		.u = {
-			.log = *log,
-		},
-	};
-	int err = iterator_next(it, &rec);
-	*log = rec.u.log;
-	return err;
-}
-
-int iterator_seek(struct reftable_iterator *it, struct reftable_record *want)
-{
-	return it->ops->seek(it->iter_arg, want);
-}
-
-int iterator_next(struct reftable_iterator *it, struct reftable_record *rec)
-{
-	return it->ops->next(it->iter_arg, rec);
-}
-
-static int empty_iterator_seek(void *arg, struct reftable_record *want)
-{
-	return 0;
-}
-
-static int empty_iterator_next(void *arg, struct reftable_record *rec)
-{
-	return 1;
-}
-
-static void empty_iterator_close(void *arg)
-{
-}
-
-static struct reftable_iterator_vtable empty_vtable = {
-	.seek = &empty_iterator_seek,
-	.next = &empty_iterator_next,
-	.close = &empty_iterator_close,
-};
-
-void iterator_set_empty(struct reftable_iterator *it)
-{
-	assert(!it->ops);
-	it->iter_arg = NULL;
-	it->ops = &empty_vtable;
-}
diff --git a/reftable/generic.h b/reftable/generic.h
index 8341fa570e..837fbb8df2 100644
--- a/reftable/generic.h
+++ b/reftable/generic.h
@@ -24,14 +24,4 @@ void table_init_iter(struct reftable_table *tab,
 		     struct reftable_iterator *it,
 		     uint8_t typ);
 
-struct reftable_iterator_vtable {
-	int (*seek)(void *iter_arg, struct reftable_record *want);
-	int (*next)(void *iter_arg, struct reftable_record *rec);
-	void (*close)(void *iter_arg);
-};
-
-void iterator_set_empty(struct reftable_iterator *it);
-int iterator_seek(struct reftable_iterator *it, struct reftable_record *want);
-int iterator_next(struct reftable_iterator *it, struct reftable_record *rec);
-
 #endif
diff --git a/reftable/iter.c b/reftable/iter.c
index a7484aba60..225feb7871 100644
--- a/reftable/iter.c
+++ b/reftable/iter.c
@@ -16,6 +16,43 @@ license that can be found in the LICENSE file or at
 #include "reader.h"
 #include "reftable-error.h"
 
+int iterator_seek(struct reftable_iterator *it, struct reftable_record *want)
+{
+	return it->ops->seek(it->iter_arg, want);
+}
+
+int iterator_next(struct reftable_iterator *it, struct reftable_record *rec)
+{
+	return it->ops->next(it->iter_arg, rec);
+}
+
+static int empty_iterator_seek(void *arg, struct reftable_record *want)
+{
+	return 0;
+}
+
+static int empty_iterator_next(void *arg, struct reftable_record *rec)
+{
+	return 1;
+}
+
+static void empty_iterator_close(void *arg)
+{
+}
+
+static struct reftable_iterator_vtable empty_vtable = {
+	.seek = &empty_iterator_seek,
+	.next = &empty_iterator_next,
+	.close = &empty_iterator_close,
+};
+
+void iterator_set_empty(struct reftable_iterator *it)
+{
+	assert(!it->ops);
+	it->iter_arg = NULL;
+	it->ops = &empty_vtable;
+}
+
 static void filtering_ref_iterator_close(void *iter_arg)
 {
 	struct filtering_ref_iterator *fri = iter_arg;
@@ -181,3 +218,71 @@ void iterator_from_indexed_table_ref_iter(struct reftable_iterator *it,
 	it->iter_arg = itr;
 	it->ops = &indexed_table_ref_iter_vtable;
 }
+
+void reftable_iterator_destroy(struct reftable_iterator *it)
+{
+	if (!it->ops)
+		return;
+	it->ops->close(it->iter_arg);
+	it->ops = NULL;
+	FREE_AND_NULL(it->iter_arg);
+}
+
+int reftable_iterator_seek_ref(struct reftable_iterator *it,
+			       const char *name)
+{
+	struct reftable_record want = {
+		.type = BLOCK_TYPE_REF,
+		.u.ref = {
+			.refname = (char *)name,
+		},
+	};
+	return it->ops->seek(it->iter_arg, &want);
+}
+
+int reftable_iterator_next_ref(struct reftable_iterator *it,
+			       struct reftable_ref_record *ref)
+{
+	struct reftable_record rec = {
+		.type = BLOCK_TYPE_REF,
+		.u = {
+			.ref = *ref
+		},
+	};
+	int err = iterator_next(it, &rec);
+	*ref = rec.u.ref;
+	return err;
+}
+
+int reftable_iterator_seek_log_at(struct reftable_iterator *it,
+				  const char *name, uint64_t update_index)
+{
+	struct reftable_record want = {
+		.type = BLOCK_TYPE_LOG,
+		.u.log = {
+			.refname = (char *)name,
+			.update_index = update_index,
+		},
+	};
+	return it->ops->seek(it->iter_arg, &want);
+}
+
+int reftable_iterator_seek_log(struct reftable_iterator *it,
+			       const char *name)
+{
+	return reftable_iterator_seek_log_at(it, name, ~((uint64_t) 0));
+}
+
+int reftable_iterator_next_log(struct reftable_iterator *it,
+			       struct reftable_log_record *log)
+{
+	struct reftable_record rec = {
+		.type = BLOCK_TYPE_LOG,
+		.u = {
+			.log = *log,
+		},
+	};
+	int err = iterator_next(it, &rec);
+	*log = rec.u.log;
+	return err;
+}
diff --git a/reftable/iter.h b/reftable/iter.h
index b75d7ac2ac..3b401f1259 100644
--- a/reftable/iter.h
+++ b/reftable/iter.h
@@ -16,6 +16,33 @@ license that can be found in the LICENSE file or at
 #include "reftable-iterator.h"
 #include "reftable-generic.h"
 
+/*
+ * The virtual function table for implementing generic reftable iterators.
+ */
+struct reftable_iterator_vtable {
+	int (*seek)(void *iter_arg, struct reftable_record *want);
+	int (*next)(void *iter_arg, struct reftable_record *rec);
+	void (*close)(void *iter_arg);
+};
+
+/*
+ * Position the iterator at the wanted record such that a call to
+ * `iterator_next()` would return that record, if it exists.
+ */
+int iterator_seek(struct reftable_iterator *it, struct reftable_record *want);
+
+/*
+ * Yield the next record and advance the iterator. Returns <0 on error, 0 when
+ * a record was yielded, and >0 when the iterator hit an error.
+ */
+int iterator_next(struct reftable_iterator *it, struct reftable_record *rec);
+
+/*
+ * Set up the iterator such that it behaves the same as an iterator with no
+ * entries.
+ */
+void iterator_set_empty(struct reftable_iterator *it);
+
 /* iterator that produces only ref records that point to `oid` */
 struct filtering_ref_iterator {
 	struct strbuf oid;
-- 
2.46.0.46.g406f326d27.dirty

