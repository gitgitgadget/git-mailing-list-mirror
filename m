Received: from fout1-smtp.messagingengine.com (fout1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBB873218B
	for <git@vger.kernel.org>; Tue, 13 Aug 2024 06:24:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723530274; cv=none; b=JVJtq225CyiZvP5q2Vqw5p9zSMmVy6xGvFOI1cIKKldjQ92F42MqCEVAdqXOoYWuXwp9Q8xQ4t84V9LTL+XmKwvJNBFHW7z2PLFZQjJ5iJJYC6F/+JLMp+giILTLHnHUCIuina+kMvIzbfXr5/F3xrUXh+lBDWATY/YDqUOfoe4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723530274; c=relaxed/simple;
	bh=HvovhnfCGEPAzIP0MQ2SlJlew1hTgOdeWRdDGXSyTf4=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FT+2RkhbuLm1xi23a3LBufY6eGr35Wkbz+g0rPSt2uKiDhdN+21shG32/VJ/LYSfSWiuq5vi2c+AHIZAO5Ve3s/Vla25TAeWR/PteP/c/TtrvoH/gdwE3vKtdgtlTzbBdYhTGjOIEdzr4AW0c5fbmKpMEIOxxpNK150kO4+YA4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=IxsnoxHT; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=KrgT2rtT; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="IxsnoxHT";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="KrgT2rtT"
Received: from phl-compute-05.internal (phl-compute-05.nyi.internal [10.202.2.45])
	by mailfout.nyi.internal (Postfix) with ESMTP id 228D9138FCDB
	for <git@vger.kernel.org>; Tue, 13 Aug 2024 02:24:32 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Tue, 13 Aug 2024 02:24:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1723530272; x=1723616672; bh=Hd56cJ62eU
	pl63+Zj/TkVKm/ROVOcmzFH0sX+iuJ5dU=; b=IxsnoxHTTWFCcJDpNf6OPlT640
	BoyLpT2GfyhZBkmio1nbpjlhQ1esVGstPudigpIHYNNqINmuyNeXMANo7VVa+euE
	yWyX0MhER7xPjUXc3spdV0W78Na5KTsCvQMDwRJgG64ZdSEPMzhuDlYz0K/jr7Sz
	Cakdim/8SqzX7Io7rekaFfMHqUaRBX4aF49kM6h1gNPd1uG+3Ol1d8mTKdT9FhMv
	u/cWVmLUxXvFj4ylUCV20DZZLvZCp+8ufe9OG4HnMWhMJPWC5LWKVMga3cUKOMH8
	mnob1oeKPmwvN7o1tCpbpJGnWNvPZ+NG1OKUyrI2JbIpBBO0XpFWfQa7JtiA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1723530272; x=1723616672; bh=Hd56cJ62eUpl63+Zj/TkVKm/ROVO
	cmzFH0sX+iuJ5dU=; b=KrgT2rtT0RxqpXTR1uf5ReOlHZaioSzcJCIM/pCHwSPY
	C8HKEzwI8R7oe6F5Jxl/57f5h0XKmO1rFSnpX00oLxsY/S9sS4HL5frkr3cYEp10
	E32Mn91zSl/OdxJ8r+s0vXfcKvmluwHmD7V3QiJxs9FZS7dnZRr9nzFr/I5OJYh+
	WNQ13N7ZmEwGNf3mTGWNUqFXucnLFucry2oBcBGIFth440FZkiPGWGQ67+MS+HNz
	4R9qQOiDiH2IO3ZU0JbUYGz1G7CW8BmOBEudYTosKZMCv4rAYYMG7YJlc7TrzqsB
	LGhcg1NNsJDtLEQ6U2cYhnZDx3I/56lD+zS6oCrWRw==
X-ME-Sender: <xms:IPy6ZqrFyiPwbdSvchqbL8lwsEVYK1UUVDiVwRmXvA0wSt6DqiT_1Q>
    <xme:IPy6ZooBm1fdZumQVqZSfh1Huxb7AwAsUj1YReyML_GIyoB6Nl5AZGvZBqZpq2M2G
    q380vLmOewSwgqYEA>
X-ME-Received: <xmr:IPy6ZvP7-Z6vuqeJATCbegnAcFKzYxBuUVjegV4qwpUD1iU_uvKYu2kuG4tJ2OJ9np5zUxT6HWkMt_qHUGnT2hxtNbD039zXJqNK8eE5i5GZQw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddruddtuddguddtlecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecunecujfgurhepfffhvf
    fukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhn
    hhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpeehkeeffeegge
    dvgedvfeefheettddtffejuefflefggfehfeelffeljedvfeehieenucevlhhushhtvghr
    ufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsg
    gprhgtphhtthhopedupdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehgihhtsehv
    ghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:IPy6Zp4EtIupSZzaga54g4TLFI8bnvj4X2aIwxSijtHD0xLCuW1zgw>
    <xmx:IPy6Zp6vt7m8DvMmO1jMb6zoZLDnd5--HbirzPr50B-Uc7vgdTBc3Q>
    <xmx:IPy6ZphWjIUCyljMeLbNt_JA_V9QqhGqxUXpfdMlEEqMab5KutxPkw>
    <xmx:IPy6Zj4ASwkvsfv4zzekpz1mv2E-KHc6ZmGjPxhA3WYxf-NfIzn9ug>
    <xmx:IPy6ZrTFP7nk3sazdbmeoutaL8P-7jayWFYo_6o8FW1lCYihzoftQjsX>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Tue, 13 Aug 2024 02:24:31 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id e27cc024 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Tue, 13 Aug 2024 06:24:14 +0000 (UTC)
Date: Tue, 13 Aug 2024 08:24:29 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Subject: [PATCH 06/10] reftable/generic: move generic iterator code into
 iterator interface
Message-ID: <14924604cebe20ac30d291399b0200016fa8b4e3.1723528765.git.ps@pks.im>
References: <cover.1723528765.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1723528765.git.ps@pks.im>

Move functions relating to the reftable iterator from "generic.c" into
"iter.c". This prepares for the removal of the former subsystem.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 reftable/generic.c | 107 +--------------------------------------------
 reftable/generic.h |  10 -----
 reftable/iter.c    | 106 ++++++++++++++++++++++++++++++++++++++++++++
 reftable/iter.h    |  27 ++++++++++++
 4 files changed, 134 insertions(+), 116 deletions(-)

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
index a7484aba60..844853fad2 100644
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
@@ -181,3 +218,72 @@ void iterator_from_indexed_table_ref_iter(struct reftable_iterator *it,
 	it->iter_arg = itr;
 	it->ops = &indexed_table_ref_iter_vtable;
 }
+
+void reftable_iterator_destroy(struct reftable_iterator *it)
+{
+	if (!it->ops) {
+		return;
+	}
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

