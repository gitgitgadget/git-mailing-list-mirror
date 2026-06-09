Received: from fout-b2-smtp.messagingengine.com (fout-b2-smtp.messagingengine.com [202.12.124.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B36893F0756
	for <git@vger.kernel.org>; Tue,  9 Jun 2026 08:51:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780995083; cv=none; b=GWkgOohTSPkZBuzdMPTXIt43kWmOjW6NXi8stN/LlaFUdnRyadGVY3eHF7gZ0w7dvJYXls4inYwlVEdM3t8iCkrr1nqohfnzgkjAOXfRI3BsNracLh4uKFoBkuU1ugtLf96m9qqmPSrmdID5SMtfMTerhcrNmekMLeYGS9/HHb0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780995083; c=relaxed/simple;
	bh=Tz287o4Xtj2ocpVHtewno/uaLXjYu98sD+03qVit0+c=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Ah55RjQCLJmQdlLEqZtMennNydyB4lAmgpFk22svUKDWccl5+Rsuu/y0e4VMLwBb9ElQwVi/CG6TNuxf4igTV/9KzM/Cvw6nkjjCrftf7d9g/CBbrTYtumw1ZJBw1Pl82oxjxTy5poUxSNQl25qbkIUojHKV9y9MryPKxNHSdZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=KTu5DOvk; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=XIMX0ESz; arc=none smtp.client-ip=202.12.124.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="KTu5DOvk";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="XIMX0ESz"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.stl.internal (Postfix) with ESMTP id E946E1D00169;
	Tue,  9 Jun 2026 04:51:20 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Tue, 09 Jun 2026 04:51:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1780995080;
	 x=1781081480; bh=C7I16/HKO8WRqPceTFjPkz/m1UtyCa6TIfYUSbd6qyk=; b=
	KTu5DOvkyOvXVJiX4Tx7afxiWlbiFr6Q5SIUzTgUvLwUEnI9hPWMpTgFwWp3gnf5
	zdLqozb8MM0EXwyo2LxiN/0TNbqXBpxJ+acwcNqezRcGI7RKUF/3ME1Re9j7QXZk
	8YrCdJse3nC+geiyF3r/teuMksROD/pOry5EeumLdRdraa9KD7Z8YDR8evt4vYxs
	Tjqizm+xosp71kJ8Vg8QKPndFwjehShh3VwT7tDrQSMKdpItqetdKUQanHjv/i+y
	S2yNt8vc24ZKjNHZ9fWbvW11Cvc1mMPuYUf+wkQx+TYIR0RkiFgkwODFlWyPS3Ni
	kfVXz3MiBTuz1Mz3r2ZT0Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1780995080; x=
	1781081480; bh=C7I16/HKO8WRqPceTFjPkz/m1UtyCa6TIfYUSbd6qyk=; b=X
	IMX0ESzWsLll3B2kVtt3FZwBMjlslUcch7mg9Aa9qHMUUbM/9Y+bnfP8Qqus3LdN
	3OLQl63WjX5dgL5P6/VN/XA1kKBYfgoSHujBMmv0pjvr8YJvdRpX7CJA6ffoXWwc
	/aMZM4BqFiWKAWspLbVKXcFtDPQ+HzmNshsAEGF28P6sG5Xxt8WzxVA78bEjPe2n
	EWin6seS525oLaPl8qyqR86tuKeumbkwqCUSRxq77r0voGMP4hSFhLUY4qJlu4cN
	CpGS07vSUlyCrDH4ASChYkuPgRdYxA3bYceeYNLc/9DVK5BkKORqAA+Z+7rycHIN
	CRRAMw2NrVc2JB9Lx3RzA==
X-ME-Sender: <xms:CNQnau38dxsgvDETlzntJ0L1Rhw9salLIDbhlMSTLzBclvcnIOjm2Q>
    <xme:CNQnanE-YwjIK4eWETHn3xrhWfkefjmFifOOQ6sK9qoKG0fO0DJXG9tsssDOfOSmf
    qeNeuoiggz-czeVXjh5yp2ewOpzrnEdhelJpEgljBuRz0I_0hrPfQ>
X-ME-Received: <xmr:CNQnakgS0H4oNPB2q3UPKQOXK8ZNXajkx4jhXPEpXKG4LAeg0U9X6VfqUoxuqkufIwZVcnRYEU9_vnwV6W61dnbE9HdwjJ62vAyo6AY55_0>
X-ME-Proxy-Cause: dmFkZTE+8Zf8khlcQ7ey6VJBfKfyb+lVB7beAQVmMwahOpSrDABTfs+UMLNaCSahWLrpqQ
    zIpzWWxzpQcFaZ9RYcuuxPvXig7IMWtRtf/lIJDuGFTgyRu3OE08rjlw5d8Y6B6uE/GK5O
    6Q+bbSs5cLpSSr5PSLEZcZy6lClecQd05RdQbM0bDp0n4dMX1XsQUlkmPNxY61fU+L0cPK
    8E0bQYcYs4ab91xev3Ej3UGfd6PL5MkN2wItUGN/kGCkTEX87Krc84rMz2KQnn+FjekPOI
    q/wfrPLY86EI5YebiFbp3xU/h7BOnK5VreuPPENQMQHJnfqeWFl6iZgBOA1fG/j72WI9Bf
    /Nx8R30IZyrR0p8UO90t111kvw6GX28PZzwHMQ5A+peISBxRQuAUjhZTLGUJKPrOQDp/VX
    40zqxTrApoWFntmRrK3HwE3o9Eo1UL0I0SU5FjnSk9wikF1RnEkpiFxxNoTSzIlJUN5xfI
    KJ9fz0pYoJ4xrXnJ7ZbR1cfU6Ys+9A99Sfo1lxqb5yLed5DqegE8KWfuGNSqB2uyxoDFmJ
    Le4gJE3lMXlH91He2gL34TlqFdVIRJCrJ3v2qm8U/lw71FsgKpmNGujsnxNUtB+kGvwh41
    K5Y84zkjqz7ZKjTT5pCYfIG/oPdFNG2UnVuAVxiiTa/BrC7vlVhm+rURD6VA
X-ME-Proxy: <xmx:CNQnaq_BPmEkAQ-5lgXQfZ9eoq_PXdO7NmKq6pG9EiGRS0w_auha8g>
    <xmx:CNQnajov1gLD-8RYuuH0xEQioQF3Vpyi3S3K-QagMaqy6OUxrHnbAA>
    <xmx:CNQnah8jsBZqK1ISJv-DIbL0lposwW1ALunnh5g4LYDO5GtcZzJIXw>
    <xmx:CNQnavWAtQaxsAoweUUxFhWb0GPE1geJKtFosPzP20kOHqazMLfGrA>
    <xmx:CNQnark-6DpJWFI2fWBnVtzzk9fNz7s-Bqpkm16RA_bWImvgz-W9nhvC>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 9 Jun 2026 04:51:20 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 6a3c0912 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 9 Jun 2026 08:51:19 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Tue, 09 Jun 2026 10:50:58 +0200
Subject: [PATCH v2 05/17] odb/source-packed: start converting to a proper
 `struct odb_source`
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260609-pks-odb-source-packed-v2-5-839089132c8b@pks.im>
References: <20260609-pks-odb-source-packed-v2-0-839089132c8b@pks.im>
In-Reply-To: <20260609-pks-odb-source-packed-v2-0-839089132c8b@pks.im>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>
X-Mailer: b4 0.15.2

Start converting `struct odb_source_packed` into a proper pluggable
`struct odb_source` by embedding the base struct and assigning it the
new `ODB_SOURCE_PACKED` type. Furthermore, wire up lifecycle management
of this source by implementing the `free` callback and taking ownership
of the chdir notifications.

Note that the packed source is not yet functional as a standalone `struct
odb_source`, as it's missing all of the callback implementations. These
will be wired up in subsequent commits.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 odb/source-files.c  |  2 +-
 odb/source-packed.c | 49 ++++++++++++++++++++++++++++++++++++++++++++-----
 odb/source-packed.h | 12 ++++++++++++
 odb/source.h        |  3 +++
 packfile.c          | 10 ----------
 packfile.h          |  6 ------
 6 files changed, 60 insertions(+), 22 deletions(-)

diff --git a/odb/source-files.c b/odb/source-files.c
index e04525fb08..3608808e7c 100644
--- a/odb/source-files.c
+++ b/odb/source-files.c
@@ -29,7 +29,7 @@ static void odb_source_files_free(struct odb_source *source)
 	struct odb_source_files *files = odb_source_files_downcast(source);
 	chdir_notify_unregister(NULL, odb_source_files_reparent, files);
 	odb_source_free(&files->loose->base);
-	packfile_store_free(files->packed);
+	odb_source_free(&files->packed->base);
 	odb_source_release(&files->base);
 	free(files);
 }
diff --git a/odb/source-packed.c b/odb/source-packed.c
index 12e785be48..f81a990cbd 100644
--- a/odb/source-packed.c
+++ b/odb/source-packed.c
@@ -1,11 +1,50 @@
 #include "git-compat-util.h"
+#include "abspath.h"
+#include "chdir-notify.h"
 #include "odb/source-packed.h"
+#include "packfile.h"
+
+static void odb_source_packed_reparent(const char *name UNUSED,
+				       const char *old_cwd,
+				       const char *new_cwd,
+				       void *cb_data)
+{
+	struct odb_source_packed *packed = cb_data;
+	char *path = reparent_relative_path(old_cwd, new_cwd,
+					    packed->base.path);
+	free(packed->base.path);
+	packed->base.path = path;
+}
+
+static void odb_source_packed_free(struct odb_source *source)
+{
+	struct odb_source_packed *packed = odb_source_packed_downcast(source);
+
+	chdir_notify_unregister(NULL, odb_source_packed_reparent, packed);
+
+	for (struct packfile_list_entry *e = packed->packs.head; e; e = e->next)
+		free(e->pack);
+	packfile_list_clear(&packed->packs);
+
+	strmap_clear(&packed->packs_by_path, 0);
+	odb_source_release(&packed->base);
+	free(packed);
+}
 
 struct odb_source_packed *odb_source_packed_new(struct odb_source_files *parent)
 {
-	struct odb_source_packed *store;
-	CALLOC_ARRAY(store, 1);
-	store->files = parent;
-	strmap_init(&store->packs_by_path);
-	return store;
+	struct odb_source_packed *packed;
+
+	CALLOC_ARRAY(packed, 1);
+	odb_source_init(&packed->base, parent->base.odb, ODB_SOURCE_PACKED,
+			parent->base.path, parent->base.local);
+	packed->files = parent;
+	strmap_init(&packed->packs_by_path);
+
+	packed->base.free = odb_source_packed_free;
+
+	if (!is_absolute_path(parent->base.path))
+		chdir_notify_register(NULL, odb_source_packed_reparent, packed);
+
+	return packed;
 }
diff --git a/odb/source-packed.h b/odb/source-packed.h
index 3c2d229a17..68e64cabab 100644
--- a/odb/source-packed.h
+++ b/odb/source-packed.h
@@ -9,6 +9,7 @@
  * A store that manages packfiles for a given object database.
  */
 struct odb_source_packed {
+	struct odb_source base;
 	struct odb_source_files *files;
 
 	/*
@@ -69,4 +70,15 @@ struct odb_source_packed {
  */
 struct odb_source_packed *odb_source_packed_new(struct odb_source_files *parent);
 
+/*
+ * Cast the given object database source to the packed backend. This will cause
+ * a BUG in case the source doesn't use this backend.
+ */
+static inline struct odb_source_packed *odb_source_packed_downcast(struct odb_source *source)
+{
+	if (source->type != ODB_SOURCE_PACKED)
+		BUG("trying to downcast source of type '%d' to packed", source->type);
+	return container_of(source, struct odb_source_packed, base);
+}
+
 #endif
diff --git a/odb/source.h b/odb/source.h
index 8bcb67787e..6865e1f71a 100644
--- a/odb/source.h
+++ b/odb/source.h
@@ -17,6 +17,9 @@ enum odb_source_type {
 	/* The "loose" backend that uses loose objects, only. */
 	ODB_SOURCE_LOOSE,
 
+	/* The "packed" backend that uses packfiles. */
+	ODB_SOURCE_PACKED,
+
 	/* The "in-memory" backend that stores objects in memory. */
 	ODB_SOURCE_INMEMORY,
 };
diff --git a/packfile.c b/packfile.c
index 862a24ad49..6d492216de 100644
--- a/packfile.c
+++ b/packfile.c
@@ -2749,16 +2749,6 @@ int parse_pack_header_option(const char *in, unsigned char *out, unsigned int *l
 	return 0;
 }
 
-void packfile_store_free(struct odb_source_packed *store)
-{
-	for (struct packfile_list_entry *e = store->packs.head; e; e = e->next)
-		free(e->pack);
-	packfile_list_clear(&store->packs);
-
-	strmap_clear(&store->packs_by_path, 0);
-	free(store);
-}
-
 void packfile_store_close(struct odb_source_packed *store)
 {
 	for (struct packfile_list_entry *e = store->packs.head; e; e = e->next) {
diff --git a/packfile.h b/packfile.h
index 2d0bb7adbe..e8bc9349f8 100644
--- a/packfile.h
+++ b/packfile.h
@@ -55,12 +55,6 @@ struct packed_git {
 	char pack_name[FLEX_ARRAY]; /* more */
 };
 
-/*
- * Free the packfile store and all its associated state. All packfiles
- * tracked by the store will be closed.
- */
-void packfile_store_free(struct odb_source_packed *store);
-
 /*
  * Close all packfiles associated with this store. The packfiles won't be
  * free'd, so they can be re-opened at a later point in time.

-- 
2.54.0.1136.gdb2ca164c4.dirty

