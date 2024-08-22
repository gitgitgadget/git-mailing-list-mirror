Received: from fout6-smtp.messagingengine.com (fout6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9E0F14A4CC
	for <git@vger.kernel.org>; Thu, 22 Aug 2024 06:35:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724308502; cv=none; b=CI0EMUkYltlCs2VbIFEoyyJ96RHOi+8ZPV7gSuXdgudHrDiL8zr79eqTB9wz88HA+F/ddYJIIW0Xqvf/sYtYs4GTitzOn8Tiwh0aw5ZDTT0z0seGAeEBjyi9hpyW8EeYD6CKd4Ylfd+Zb1b6cxG+idUW8cmj8YSjC7geNcxYqc0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724308502; c=relaxed/simple;
	bh=kNis1eq4lla1BL/F/4PHkaIFD4umzOpCq9Rr08cp8NY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iKnuwnAGOLBkvYL66q/EovlA50ZXboINqGJDjYcloZil90sy9f9N0oVoJ4Zq1iiKn2tsQ4QvIe33hmjxcVuKO5SsDhOr8NBgDyGzXUM8bSmZ9ZU2+dKTi5zb26RWS+cBdDSMfdRRnff6Z7ZOoMajaM2Vc/s/k125oEF1AGwfypM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=GT2iUV6r; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Pscb/fCk; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="GT2iUV6r";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Pscb/fCk"
Received: from phl-compute-04.internal (phl-compute-04.nyi.internal [10.202.2.44])
	by mailfout.nyi.internal (Postfix) with ESMTP id 08A9E138FFC3;
	Thu, 22 Aug 2024 02:35:00 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Thu, 22 Aug 2024 02:35:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1724308500; x=1724394900; bh=uZrnfNthAt
	0jsomMgF5TCKHZ2DQlZyVc9uGsjk32CJA=; b=GT2iUV6ryYndxzHNtBKuvLWy8F
	pAhdoEUSDm7JDeuaXx0t+c+snEozsb46gUZzf31tlHelGk2n3mh6EL6hanh+b59t
	2pW2eZ6fmpHDNmGe9S96XkuE8UNQG9EGd7enNdbCfLIwOSKOrcRK+exq8cXg2MWH
	kHWTf5aGtNmTFEg0a86POEDGV9wMaqtizacVeLiZTEnIfN6crICIqRQFs9CaEdq2
	ZOzqL30HYl6j5d2cg8N1R1BeGKNXfSCowkLiYE6zZaCOgIIih1kM/PNmfNB0TapT
	/ad/MBC8WgRMNEAVwl0ZCC5kZ/jp8lp5g61uMqy32YePX2+UmC/myMu49HVQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1724308500; x=1724394900; bh=uZrnfNthAt0jsomMgF5TCKHZ2DQl
	ZyVc9uGsjk32CJA=; b=Pscb/fCkg7C6eMoq5vQ3ODK/+h52Zt6d/fRjdPzBsTqt
	KohO6HN8f5tKNKNoXlWAnnNPXx06+TbiYOWmMP+yCW+LHuBVsLb7Q4NDJHFiUYtB
	gKQpukHYH5X/ZAqjl0MGkoDatEeVZh3pVv9CklKnIZRWE3GBkDrv++GHG2utuF4F
	gT4BrL3jQiV86lYC3ZOyMZU57gesmUL3TqwcePXowKAdAEfpAa9OydZUIDC446yl
	0en2CrFWeQ3uxyGPhp78MUclJNXDI2cPUrbirGCny5NhXn2jNWcjmzSA8BmYF3jh
	lHJyh4FS0L28Rd3QkZXwQPWZKkGctetopP84+60aWw==
X-ME-Sender: <xms:E9zGZqRc4xmk3zLPUTjOfkf0h32tQWsq9dWE7DlW30U2WANKYQ2sVg>
    <xme:E9zGZvzlLzITn4R08RIhu2uUcEaQyLjPBoOfI8Oy_ZrSauPShLKR8M9-L8v8SYFZu
    eWVTOfIrlQai04pBA>
X-ME-Received: <xmr:E9zGZn2steq2AYtHcI70RalurXZ6weh-K0IXc7k__r4eUWIJfgu1vJWoOnNfKol7I0w7ouVanJ9D8dHgz5CK0AxM1xRq5rAYZnkpvK5tUo95P7k>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrudduledguddutdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddv
    necuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrih
    hmqeenucggtffrrghtthgvrhhnpeevkeekfffhiedtleduiefgjedttedvledvudehgfeu
    gedugffhueekhfejvdektdenucevlhhushhtvghrufhiiigvpedvnecurfgrrhgrmhepmh
    grihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeefpdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopehkrghrthhhihhkrddukeeksehgmhgrihhlrdgtoh
    hmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthho
    pehjlhhtohgslhgvrhesghhmrghilhdrtghomh
X-ME-Proxy: <xmx:E9zGZmArctZVOLUkK4ltMdXO0sz-BrxoqEay6hHx7Iut_PpEzTb8cQ>
    <xmx:E9zGZjh8WFpxRlyo1i48Ia1HNctABYN6eh0-AJwOBh2HzDpew9x63w>
    <xmx:E9zGZirQzYsrGdbqS9zdDYeqmdELmFWteLcFjG9D-ztdmWs3A69nBQ>
    <xmx:E9zGZmjv_DSvOWSozGQwdJBaqT8T5rQMLRnHU2xavuMuT9qNq5Vm4w>
    <xmx:FNzGZgtRjOtF-CNV7LqDdBx3_nP6uSSoUpC7HgzGA62Pi8O4vyz_j60F>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 22 Aug 2024 02:34:58 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 4fb5befe (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 22 Aug 2024 06:34:24 +0000 (UTC)
Date: Thu, 22 Aug 2024 08:34:57 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: karthik nayak <karthik.188@gmail.com>,
	Justin Tobler <jltobler@gmail.com>
Subject: [PATCH v3 06/15] reftable/generic: move generic iterator code into
 iterator interface
Message-ID: <103262dc79c300c861c677437e036ca904bfc7ef.1724308389.git.ps@pks.im>
References: <cover.1723640107.git.ps@pks.im>
 <cover.1724308389.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1724308389.git.ps@pks.im>

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
index 28ae26145e6..6ecf9b880f7 100644
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
index 8341fa570e0..837fbb8df20 100644
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
index a7484aba60d..225feb78714 100644
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
index b75d7ac2ac0..3b401f12590 100644
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
2.46.0.164.g477ce5ccd6.dirty

