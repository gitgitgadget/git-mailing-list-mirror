Received: from wfhigh5-smtp.messagingengine.com (wfhigh5-smtp.messagingengine.com [64.147.123.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F24D6146A98
	for <git@vger.kernel.org>; Mon, 13 May 2024 08:48:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715590082; cv=none; b=ZLDI632Cf+LKZWbwYlWNJAVGlUOvHAGQ7GlAhilvPCthI48lcII3v6pG9Zs4XdoIVt78ZdBPBl07YZMcUlwVcKQYAHb6hBfWBepTWlfTDoxCXMxuY7reRtFJm2L8H0akH87h52buSrEFD98HEaxctae2kr7YYp9O0swn/Op9TwM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715590082; c=relaxed/simple;
	bh=qbbNgnBPf8oJ4xbMLZ5l1OdXbo0p1RripaMdjgM+WAM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nUB+hCoo3oB+ytxzF9XGkwlTrp/h9csi2A60j1SxRggvOw/1aFrgmYn2mU9pA5Zx3B3CUpDwmjRAekbF+CSC6qtN0+Ohe0YGQrgYAfZaVqC4abYWwNzRHGu/vCtYKSYrG2ptw5pqfN8EKVqNJT4Y2MkKsclpJxhiKXPib4T+xhI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=GZznd0TB; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=WM7ANPvR; arc=none smtp.client-ip=64.147.123.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="GZznd0TB";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="WM7ANPvR"
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailfhigh.west.internal (Postfix) with ESMTP id 3B17A180013A;
	Mon, 13 May 2024 04:48:00 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Mon, 13 May 2024 04:48:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1715590079; x=1715676479; bh=KAVOa4X+aA
	HRMB4NJ/2vr/1D3jRVHa4GmHXoAKuL7jk=; b=GZznd0TB+pKOBaM1ppim8+0QHi
	e3eNj3PHrHKJ5lPMQ/7TgupnkSFlE5EtGwB1dCPWK5Via+eRU8yV29VC5tmVmsu2
	bn93cxXvzd42JNZRRd8QvkT32FwNyzQWApVgTOuaVzbf7VEqOUZhonXaZJoizGwk
	TgtPys5VdUx5qymseCz9ngTQnFooxEF413APlw4jymbRcKm3trxMpVWz72ka0dkL
	opMwGHRWJGhthb3Un6EpBxr+eBWoYhsFytesUP37WHW0CVO/l05qi6qnpyiImfJP
	kGKYXw0hdKWfAbTbF9cUBH7iGjf/FVlJGPH+ExSKsoTJOpyUoEcp7qRqorBA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1715590079; x=1715676479; bh=KAVOa4X+aAHRMB4NJ/2vr/1D3jRV
	Ha4GmHXoAKuL7jk=; b=WM7ANPvRzP5kw+PsGMIXjOkE5PbPcGeyNfnc1lCaRrfr
	hVuWJ7Vf7fQPkRBZIc1yOktnCzzg6JDZ2ANFOJL2wIokOj55IzqsTLSKKWpYqqK6
	03huvT6hILXkV/s3wkNLcSPdhKDLUtU7TzAtDreC6mRJPS1KNjjzsOvJzLbUc+Cj
	5EcCqj96lI/bHhG7Nkv7Q/5dne0mK7BOt78gD7RwpYRbJTHcwo/uHQ+gaC75G3St
	8RiUiwWRD1UhH3EbqtXcfwq8HtxKRx/6b2pUXLCPpDF3DrCV6fSkiYJZKzEeI+Kj
	G6/f0l6k84QLtq+M9cDkxaS7ZbH9+oPFvt7GqnwzFA==
X-ME-Sender: <xms:v9NBZmuHiYe2iJ7IGAcwFKrRYyLqy8z7QoqJAcEeSb4y5pe1GuKG4w>
    <xme:v9NBZrfm0i3DqTd4RBTCd8dLc5xxXkE7asV0Mo7R2PFU3zZJtKLXPz4C31OjbhhSN
    R3iw2wTD7aeH8ACEw>
X-ME-Received: <xmr:v9NBZhz-KFgwH--q6ksxrFJPWu6zyxBIgpDVThPu7c8p9j7XXxEUVfMC-fTcNjjeFYRnyojIhyk56OCvVgchIlZzzFEe1PdKzwxYK0MLLNh4feM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdeggedgtdejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepueektdevtdffveeljeetgfehheeigeekleduvdeffeeghefgledttdehjeelffet
    necuvehluhhsthgvrhfuihiivgepfeenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimh
X-ME-Proxy: <xmx:v9NBZhPGdCyxom2RxcJM2rlcbBYtYUmT7BmbOhIV8TrZOi0zSGvmvw>
    <xmx:v9NBZm8sdSeda-RiolLOwt5sZN2HDsrvFgwaZbkzwct7z9pOCmHFSQ>
    <xmx:v9NBZpVBCsyIGreM1X6BBjtamHMh_zLGxLOfqzQDkL11gUROqDbNkQ>
    <xmx:v9NBZvdbQzXFpR3NSDVdOiTo7pmqGN1DK7FmlH_2OJ-c18DWfddzNg>
    <xmx:v9NBZtZkP5cKdyaTqDkjG8ZZheT-QMgp-CGqZg_5SyrMIhz0R5kU3ySQ>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 13 May 2024 04:47:58 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id 0d6f608d (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 13 May 2024 08:47:40 +0000 (UTC)
Date: Mon, 13 May 2024 10:47:56 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, Justin Tobler <jltobler@gmail.com>
Subject: [PATCH v2 12/13] reftable/stack: provide convenience functions to
 create iterators
Message-ID: <51480c43287ee3164d108859725ca819b3466df5.1715589670.git.ps@pks.im>
References: <cover.1715166175.git.ps@pks.im>
 <cover.1715589670.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="c3Wku7l6wJb/kN+q"
Content-Disposition: inline
In-Reply-To: <cover.1715589670.git.ps@pks.im>


--c3Wku7l6wJb/kN+q
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
2.45.GIT


--c3Wku7l6wJb/kN+q
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmZB07sACgkQVbJhu7ck
PpRPzw//Ss0ABo+ai335sypXqIiGazJGzSsN55KLj2+Ct4zhkiabZodxiLJgx1ag
lZgjeY4SPrm4ujhyHyQBvb8hP5G8i0sdNKJMxMuSoEIDB8XlklPd4z9AL9YOI3VH
G8kB26il34/su5ZxFWpqqF7ntgt6ZZWvvI8DWVLRBNPBMdnQQO7qZw5lvHmxUU2b
BeWBqFXQWHqz1lhmB1WcM4VRDzO5lNiLYRYG3S77HZ+/gUfJ9aZrS2Do8m4sFRyy
QHa+Fn1fxw2bXa6WGB1l2dXaP45pfl2wxNvNOnzs6UCczMOE+N2yg9KYM2WDyLSL
uxRBlNHgQWA2Q0+uHbVLTAirY+ziBw4oihTHyA+EGBepiSQPXq3ee75paVJGiy7Q
ah614Jjs6reMPVTyjlwlEf07EIa7nftl+ZaD703rmobHKFz05CUzGY33MgH4ao2p
kcdC+BXi8kF4Ao7PLKCCu4KwDBSEIdwaieofKr/ApOJ/deBqdLeyRjTBKNTNKkWU
/O5LK25xYQLeHwaE6NFDt6ML5gxZTfjmP3k2+LRByGWAMJt59OurroYNpA6mMdW5
PMG9jWTOA4XSTmKJhK2kXvUh9X7n29rFTgoMN80Z+XAkCMcYlD8Bj/7WjHnA8ynt
M1yPpEo4l/kQJH9ssym80HiFhytbBdvg3ZGHjmL2gRQYW7+6jxk=
=0MS9
-----END PGP SIGNATURE-----

--c3Wku7l6wJb/kN+q--
