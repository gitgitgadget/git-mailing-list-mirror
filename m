Received: from fout8-smtp.messagingengine.com (fout8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F28742ABC
	for <git@vger.kernel.org>; Wed,  8 May 2024 11:04:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715166276; cv=none; b=A/q4zCxovIvaMx8lEYuSd+Wb7YuL+ZXL/0RTN8YFR8OLR3Rifawhgqkr3wlWDvttwqMer6KTkPPif6y/mfdsSgRG3M31SE/gmAPgFCrVTDdaZ23h56t2D5VV9rL5PfV1Oxqc9SqCZLJlmPNtkj9NE/2agEr2wGH0GaV2kV0zuO4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715166276; c=relaxed/simple;
	bh=kbslnTR2rnsx3ROqhP2Nuh3E2T9M6TnbC0vvaYq/P0Q=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=szenRq7K6IH6gjlybKZh5tSgQrIphD7fUzCz4cSY3O8zw6mrHmghHckbgqkYbhCgWZiMCzXABR1XczOgzAldTyPjth7Zzch3EpnWWZyixkTDe9jGzKCvMa5GPkKz/gjoigNHz1LRMuc8D5b+1RMt4wDH6YKeNnyYDHOi6Z4AS6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=bl9I4sb6; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=DgGiBlq9; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="bl9I4sb6";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="DgGiBlq9"
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfout.nyi.internal (Postfix) with ESMTP id 505D61380FF3
	for <git@vger.kernel.org>; Wed,  8 May 2024 07:04:33 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Wed, 08 May 2024 07:04:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1715166273; x=1715252673; bh=4o1C+ZlHjR
	f+cbcuKg80Sf9bqrWmOM2UQHWELDODf7A=; b=bl9I4sb6DZylqGdNEuM/2LEbka
	cLeC+XHbhm822kSIJZePfCQFLylc8MLrdpuG9ZpK+LloEQbmpv1cVFZMBfcsLEJO
	fjZ0Rfp0NXs8WAI4nPDoQo0QzclE8hlTzV2R83QrC49PC/dM6wsm1OOYcgGKxtZU
	GyUZ4FDTM8UKxBaS8jQEsWdsyerh2CSzgVvYVqVlYL1fQ9EZR3yT752IXNIRvdZ4
	sYMLhrCa6ryJG4tLV1kyRPa6iRwB/I0jyqTtnM1l7cil04Y5n/43GLkSan0CnozW
	rT4wtp2+yiew2O04M73lvAZJYChcM0hRKKejC/cCRVYohv7XFJK1+NDLll8Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1715166273; x=1715252673; bh=4o1C+ZlHjRf+cbcuKg80Sf9bqrWm
	OM2UQHWELDODf7A=; b=DgGiBlq9EJg3iYmjXszhba4yvECrWG5+HDeywtMv0FaX
	3VvkK0TULONPtuleu1S0zmTQ6fT8mQz+bdbGVv5hscn0z92+izlyzngjP8naTz/2
	quHQ6+LFY8EWOQq8e6cEiX1kB1uh7j+F732crdMlQ/C1STmdkb72wDLFkJBsM5/m
	hlK3XoHM1QCIR8xITOMY3bH2v7UYsUKkYs/JPNia8ukmlS3UEEzaLj3JxM2P1Evk
	F0tO0ZkLzKAx+cRkfeku21UO+MGrBtph1Q/WC9Q+QYKsxOd/sfi37KUZs/faa/PH
	c+lArN6v3oB+uVu/4URRAZ2YGONbKhH9ad8NxoIMbA==
X-ME-Sender: <xms:QVw7Zs1HRxRFQD-NcIeY8kitSDdhaTU8pppFlBYuMx43H02ierihmw>
    <xme:QVw7ZnHczevVjGLS5OSg4amk2Rf_7tFKcaXCMoB9rmJd3tKU1-L8VfyoVENPPSahO
    HDy1qmropzSEb1exg>
X-ME-Received: <xmr:QVw7Zk66QIhlnu7sTtLUcujTVIOwp6a053WMUruoKPGuS9zOT1V6K5o0EPOPnaPHW87qerl7MkrQu1PVERDXCgT5aDo8KAyHZSMRPPCvfEc93Juukw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdeftddgfeehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvuffkfhggtggujgesghdtre
    ertddtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehp
    khhsrdhimheqnecuggftrfgrthhtvghrnhepheeghfdtfeeuffehkefgffduleffjedthf
    dvjeektdfhhedvlefgtefgvdettdfhnecuvehluhhsthgvrhfuihiivgepvdenucfrrghr
    rghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimh
X-ME-Proxy: <xmx:QVw7Zl3TvNMd63jMhNzznb3lU27WnM_jp2n1ks1bGq_UBah67ZCdpA>
    <xmx:QVw7ZvFQS4l_O52W2fIFyCKRRnph3XYSHwZol0oizGDUb4O3i9jIRA>
    <xmx:QVw7Zu-Y3DzcKSuTNrrU9JBJhujexe0Ugpp1CT9clcF3niCY5ZjquA>
    <xmx:QVw7ZklpRcw0wh3Z-JwTqwS02YayryJdhahY2j9Ib6BeEBVU4K9Z3A>
    <xmx:QVw7ZlMNZv0kD5zVDBZWnZURhcFQ-nfCZAjqYDxTUT9RoT1J_J1QFeqe>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Wed, 8 May 2024 07:04:32 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id b8edb45c (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Wed, 8 May 2024 11:04:23 +0000 (UTC)
Date: Wed, 8 May 2024 13:04:30 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Subject: [PATCH 12/13] reftable/stack: provide convenience functions to
 create iterators
Message-ID: <68cc35919b9e3c232c4ab725b6249c2e543ad1ae.1715166175.git.ps@pks.im>
References: <cover.1715166175.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="G661CKv6Gc8n2OlU"
Content-Disposition: inline
In-Reply-To: <cover.1715166175.git.ps@pks.im>


--G661CKv6Gc8n2OlU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

There exist a bunch of call sites in the reftable backend that want to
create iterators for a reftable stack. This is rather convoluted right
now, where you always have to go via the merged table. And it is about
to become even more convoluted when we split up iterator initialization
and seeking in the next commit.

Introduce convenience functions that allow the caller to create an
iterator from a reftable stack directly without going through the merged
table. Adapt callers accordingly.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 refs/reftable-backend.c   | 48 +++++++++++++++++----------------------
 reftable/merged.c         |  6 ++---
 reftable/merged.h         |  6 +++++
 reftable/reftable-stack.h | 18 +++++++++++++++
 reftable/stack.c          | 15 ++++++++++++
 5 files changed, 63 insertions(+), 30 deletions(-)

diff --git a/refs/reftable-backend.c b/refs/reftable-backend.c
index 010ef811b6..7ac2772bcb 100644
--- a/refs/reftable-backend.c
+++ b/refs/reftable-backend.c
@@ -15,7 +15,6 @@
 #include "../reftable/reftable-record.h"
 #include "../reftable/reftable-error.h"
 #include "../reftable/reftable-iterator.h"
-#include "../reftable/reftable-merged.h"
 #include "../setup.h"
 #include "../strmap.h"
 #include "parse.h"
@@ -462,7 +461,6 @@ static struct reftable_ref_iterator *ref_iterator_for_s=
tack(struct reftable_ref_
 							    const char *prefix,
 							    int flags)
 {
-	struct reftable_merged_table *merged_table;
 	struct reftable_ref_iterator *iter;
 	int ret;
=20
@@ -482,9 +480,8 @@ static struct reftable_ref_iterator *ref_iterator_for_s=
tack(struct reftable_ref_
 	if (ret)
 		goto done;
=20
-	merged_table =3D reftable_stack_merged_table(stack);
-
-	ret =3D reftable_merged_table_seek_ref(merged_table, &iter->iter, prefix);
+	reftable_stack_init_ref_iterator(stack, &iter->iter);
+	ret =3D reftable_iterator_seek_ref(&iter->iter, prefix);
 	if (ret)
 		goto done;
=20
@@ -1015,8 +1012,6 @@ static int transaction_update_cmp(const void *a, cons=
t void *b)
 static int write_transaction_table(struct reftable_writer *writer, void *c=
b_data)
 {
 	struct write_transaction_table_arg *arg =3D cb_data;
-	struct reftable_merged_table *mt =3D
-		reftable_stack_merged_table(arg->stack);
 	uint64_t ts =3D reftable_stack_next_update_index(arg->stack);
 	struct reftable_log_record *logs =3D NULL;
 	struct ident_split committer_ident =3D {0};
@@ -1051,6 +1046,8 @@ static int write_transaction_table(struct reftable_wr=
iter *writer, void *cb_data
 			struct reftable_log_record log =3D {0};
 			struct reftable_iterator it =3D {0};
=20
+			reftable_stack_init_log_iterator(arg->stack, &it);
+
 			/*
 			 * When deleting refs we also delete all reflog entries
 			 * with them. While it is not strictly required to
@@ -1060,7 +1057,7 @@ static int write_transaction_table(struct reftable_wr=
iter *writer, void *cb_data
 			 * Unfortunately, we have no better way than to delete
 			 * all reflog entries one by one.
 			 */
-			ret =3D reftable_merged_table_seek_log(mt, &it, u->refname);
+			ret =3D reftable_iterator_seek_log(&it, u->refname);
 			while (ret =3D=3D 0) {
 				struct reftable_log_record *tombstone;
=20
@@ -1354,7 +1351,6 @@ static int write_copy_table(struct reftable_writer *w=
riter, void *cb_data)
 {
 	struct write_copy_arg *arg =3D cb_data;
 	uint64_t deletion_ts, creation_ts;
-	struct reftable_merged_table *mt =3D reftable_stack_merged_table(arg->sta=
ck);
 	struct reftable_ref_record old_ref =3D {0}, refs[2] =3D {0};
 	struct reftable_log_record old_log =3D {0}, *logs =3D NULL;
 	struct reftable_iterator it =3D {0};
@@ -1488,7 +1484,8 @@ static int write_copy_table(struct reftable_writer *w=
riter, void *cb_data)
 	 * copy over all log entries from the old reflog. Last but not least,
 	 * when renaming we also have to delete all the old reflog entries.
 	 */
-	ret =3D reftable_merged_table_seek_log(mt, &it, arg->oldname);
+	reftable_stack_init_log_iterator(arg->stack, &it);
+	ret =3D reftable_iterator_seek_log(&it, arg->oldname);
 	if (ret < 0)
 		goto done;
=20
@@ -1694,7 +1691,6 @@ static struct ref_iterator_vtable reftable_reflog_ite=
rator_vtable =3D {
 static struct reftable_reflog_iterator *reflog_iterator_for_stack(struct r=
eftable_ref_store *refs,
 								  struct reftable_stack *stack)
 {
-	struct reftable_merged_table *merged_table;
 	struct reftable_reflog_iterator *iter;
 	int ret;
=20
@@ -1711,9 +1707,8 @@ static struct reftable_reflog_iterator *reflog_iterat=
or_for_stack(struct reftabl
 	if (ret < 0)
 		goto done;
=20
-	merged_table =3D reftable_stack_merged_table(stack);
-
-	ret =3D reftable_merged_table_seek_log(merged_table, &iter->iter, "");
+	reftable_stack_init_log_iterator(stack, &iter->iter);
+	ret =3D reftable_iterator_seek_log(&iter->iter, "");
 	if (ret < 0)
 		goto done;
=20
@@ -1771,7 +1766,6 @@ static int reftable_be_for_each_reflog_ent_reverse(st=
ruct ref_store *ref_store,
 	struct reftable_ref_store *refs =3D
 		reftable_be_downcast(ref_store, REF_STORE_READ, "for_each_reflog_ent_rev=
erse");
 	struct reftable_stack *stack =3D stack_for(refs, refname, &refname);
-	struct reftable_merged_table *mt =3D NULL;
 	struct reftable_log_record log =3D {0};
 	struct reftable_iterator it =3D {0};
 	int ret;
@@ -1779,8 +1773,8 @@ static int reftable_be_for_each_reflog_ent_reverse(st=
ruct ref_store *ref_store,
 	if (refs->err < 0)
 		return refs->err;
=20
-	mt =3D reftable_stack_merged_table(stack);
-	ret =3D reftable_merged_table_seek_log(mt, &it, refname);
+	reftable_stack_init_log_iterator(stack, &it);
+	ret =3D reftable_iterator_seek_log(&it, refname);
 	while (!ret) {
 		ret =3D reftable_iterator_next_log(&it, &log);
 		if (ret < 0)
@@ -1808,7 +1802,6 @@ static int reftable_be_for_each_reflog_ent(struct ref=
_store *ref_store,
 	struct reftable_ref_store *refs =3D
 		reftable_be_downcast(ref_store, REF_STORE_READ, "for_each_reflog_ent");
 	struct reftable_stack *stack =3D stack_for(refs, refname, &refname);
-	struct reftable_merged_table *mt =3D NULL;
 	struct reftable_log_record *logs =3D NULL;
 	struct reftable_iterator it =3D {0};
 	size_t logs_alloc =3D 0, logs_nr =3D 0, i;
@@ -1817,8 +1810,8 @@ static int reftable_be_for_each_reflog_ent(struct ref=
_store *ref_store,
 	if (refs->err < 0)
 		return refs->err;
=20
-	mt =3D reftable_stack_merged_table(stack);
-	ret =3D reftable_merged_table_seek_log(mt, &it, refname);
+	reftable_stack_init_log_iterator(stack, &it);
+	ret =3D reftable_iterator_seek_log(&it, refname);
 	while (!ret) {
 		struct reftable_log_record log =3D {0};
=20
@@ -1855,7 +1848,6 @@ static int reftable_be_reflog_exists(struct ref_store=
 *ref_store,
 	struct reftable_ref_store *refs =3D
 		reftable_be_downcast(ref_store, REF_STORE_READ, "reflog_exists");
 	struct reftable_stack *stack =3D stack_for(refs, refname, &refname);
-	struct reftable_merged_table *mt =3D reftable_stack_merged_table(stack);
 	struct reftable_log_record log =3D {0};
 	struct reftable_iterator it =3D {0};
 	int ret;
@@ -1868,7 +1860,8 @@ static int reftable_be_reflog_exists(struct ref_store=
 *ref_store,
 	if (ret < 0)
 		goto done;
=20
-	ret =3D reftable_merged_table_seek_log(mt, &it, refname);
+	reftable_stack_init_log_iterator(stack, &it);
+	ret =3D reftable_iterator_seek_log(&it, refname);
 	if (ret < 0)
 		goto done;
=20
@@ -1966,8 +1959,6 @@ struct write_reflog_delete_arg {
 static int write_reflog_delete_table(struct reftable_writer *writer, void =
*cb_data)
 {
 	struct write_reflog_delete_arg *arg =3D cb_data;
-	struct reftable_merged_table *mt =3D
-		reftable_stack_merged_table(arg->stack);
 	struct reftable_log_record log =3D {0}, tombstone =3D {0};
 	struct reftable_iterator it =3D {0};
 	uint64_t ts =3D reftable_stack_next_update_index(arg->stack);
@@ -1975,12 +1966,14 @@ static int write_reflog_delete_table(struct reftabl=
e_writer *writer, void *cb_da
=20
 	reftable_writer_set_limits(writer, ts, ts);
=20
+	reftable_stack_init_log_iterator(arg->stack, &it);
+
 	/*
 	 * In order to delete a table we need to delete all reflog entries one
 	 * by one. This is inefficient, but the reftable format does not have a
 	 * better marker right now.
 	 */
-	ret =3D reftable_merged_table_seek_log(mt, &it, arg->refname);
+	ret =3D reftable_iterator_seek_log(&it, arg->refname);
 	while (ret =3D=3D 0) {
 		ret =3D reftable_iterator_next_log(&it, &log);
 		if (ret < 0)
@@ -2116,7 +2109,6 @@ static int reftable_be_reflog_expire(struct ref_store=
 *ref_store,
 	struct reftable_ref_store *refs =3D
 		reftable_be_downcast(ref_store, REF_STORE_WRITE, "reflog_expire");
 	struct reftable_stack *stack =3D stack_for(refs, refname, &refname);
-	struct reftable_merged_table *mt =3D reftable_stack_merged_table(stack);
 	struct reftable_log_record *logs =3D NULL;
 	struct reftable_log_record *rewritten =3D NULL;
 	struct reftable_ref_record ref_record =3D {0};
@@ -2135,7 +2127,9 @@ static int reftable_be_reflog_expire(struct ref_store=
 *ref_store,
 	if (ret < 0)
 		goto done;
=20
-	ret =3D reftable_merged_table_seek_log(mt, &it, refname);
+	reftable_stack_init_log_iterator(stack, &it);
+
+	ret =3D reftable_iterator_seek_log(&it, refname);
 	if (ret < 0)
 		goto done;
=20
diff --git a/reftable/merged.c b/reftable/merged.c
index fc7946d90d..d127f99360 100644
--- a/reftable/merged.c
+++ b/reftable/merged.c
@@ -253,9 +253,9 @@ reftable_merged_table_min_update_index(struct reftable_=
merged_table *mt)
 	return mt->min;
 }
=20
-static void merged_table_init_iter(struct reftable_merged_table *mt,
-				   struct reftable_iterator *it,
-				   uint8_t typ)
+void merged_table_init_iter(struct reftable_merged_table *mt,
+			    struct reftable_iterator *it,
+			    uint8_t typ)
 {
 	struct merged_iter *mi =3D reftable_malloc(sizeof(*mi));
 	merged_iter_init(mi, mt, typ);
diff --git a/reftable/merged.h b/reftable/merged.h
index a2571dbc99..a10469f58e 100644
--- a/reftable/merged.h
+++ b/reftable/merged.h
@@ -26,4 +26,10 @@ struct reftable_merged_table {
=20
 void merged_table_release(struct reftable_merged_table *mt);
=20
+struct reftable_iterator;
+
+void merged_table_init_iter(struct reftable_merged_table *mt,
+			    struct reftable_iterator *it,
+			    uint8_t typ);
+
 #endif
diff --git a/reftable/reftable-stack.h b/reftable/reftable-stack.h
index 1b602dda58..26740e6073 100644
--- a/reftable/reftable-stack.h
+++ b/reftable/reftable-stack.h
@@ -66,6 +66,24 @@ int reftable_stack_add(struct reftable_stack *st,
 					  void *write_arg),
 		       void *write_arg);
=20
+struct reftable_iterator;
+
+/*
+ * Initialize an iterator for the merged tables contained in the stack tha=
t can
+ * be used to iterate through refs. The iterator is valid until the next r=
eload
+ * or write.
+ */
+void reftable_stack_init_ref_iterator(struct reftable_stack *st,
+				      struct reftable_iterator *it);
+
+/*
+ * Initialize an iterator for the merged tables contained in the stack tha=
t can
+ * be used to iterate through logs. The iterator is valid until the next r=
eload
+ * or write.
+ */
+void reftable_stack_init_log_iterator(struct reftable_stack *st,
+				      struct reftable_iterator *it);
+
 /* returns the merged_table for seeking. This table is valid until the
  * next write or reload, and should not be closed or deleted.
  */
diff --git a/reftable/stack.c b/reftable/stack.c
index a59ebe038d..03f95935e1 100644
--- a/reftable/stack.c
+++ b/reftable/stack.c
@@ -10,6 +10,7 @@ license that can be found in the LICENSE file or at
=20
 #include "../write-or-die.h"
 #include "system.h"
+#include "constants.h"
 #include "merged.h"
 #include "reader.h"
 #include "reftable-error.h"
@@ -130,6 +131,20 @@ int read_lines(const char *filename, char ***namesp)
 	return err;
 }
=20
+void reftable_stack_init_ref_iterator(struct reftable_stack *st,
+				      struct reftable_iterator *it)
+{
+	merged_table_init_iter(reftable_stack_merged_table(st),
+			       it, BLOCK_TYPE_REF);
+}
+
+void reftable_stack_init_log_iterator(struct reftable_stack *st,
+				      struct reftable_iterator *it)
+{
+	merged_table_init_iter(reftable_stack_merged_table(st),
+			       it, BLOCK_TYPE_LOG);
+}
+
 struct reftable_merged_table *
 reftable_stack_merged_table(struct reftable_stack *st)
 {
--=20
2.45.0


--G661CKv6Gc8n2OlU
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmY7XD0ACgkQVbJhu7ck
PpRHqA/+OMyRIMuA3xTy4fq3S4c0d+rbkf6u7eIelxZlWnUPcCDxXjGOwFQAqoOp
WcPFqottHKP/r+7cFtBIo88VbaQtpHMxnJHKdvW/E41NwwsoRtiInrUxjNhNBxpQ
+Nw1jnAeiPkpdhsvLx7tqOLL7Cbpuhzg0dK4lmf00rvDAsPnYd4OgZiswFq9J+bq
lmr8FHGz2CRi9EINKBDgazLnRsJv36b43ptmIM69q/4NOL5kbNWIOMeEDurSht4P
7wOjQywN7RkrslfwrhSm4BAZXJbkot9eCAQHbfsyQnVRTQjTnh/1WUtJWm/qWXKe
cFfOMUBjY1y5dFJUBJCAWkdgJw38KUdOgbysOTTzdlnl92KKoq3+q6ivqsF9rXeV
QWuo9upsGDF8/e0GK0rw+PzA3L7/BeDWH/9xWQYousYf8w00IIYKaQY5BMD1vl61
P96N0TeQOmUP7TVkFTa3dVL2ptksIwI7TXmD3Bsg1vS2mJeYebFRCkGF6AL2i+B1
/s/HAdmelQtTNCmN2uZHR7EHHrnX+BvjA+FTLqPVPk1KRSjkQT9w5vybViv9dIrP
8wucObFMvzfXiaT4N+odI6hH0uBXWKLHUW1tvPgujmWbL/rRjcEUVg6jmvuOmn8/
Vqgk6tk9iidCJz/yYm0lEMrx3KmOBFTO6je1dBa+H7EpryRTbE8=
=uhMn
-----END PGP SIGNATURE-----

--G661CKv6Gc8n2OlU--
