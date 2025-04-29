Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0329727816D
	for <git@vger.kernel.org>; Tue, 29 Apr 2025 07:52:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745913148; cv=none; b=ZXY439RpENpAWlDd2PwGumXIoCrnQ3adbNHur5Hes/yB5qbvtChdDRZLuH76UhcfgPMkyHj239ZhYMqGpfOnjgKpQPCvz99rU61FT/TG5sBrvY49MH8H6GDsPGvRw281cztFwBhcWGT8asgOQ+kT6of9v3NA9yyGVd/B5WzZt2U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745913148; c=relaxed/simple;
	bh=vXM8orh2dA1/zyVrLtEmMOKpm1nT27tYsWuOsAYJ2nw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ca+ZpPqCX5yqHAfeFfOyeNYpVx09oiSq+PFPwPBINn3hOFSASruANqt03s7qpeMKwXOpHxnd71E0OVYGRw5KQfNfN4w8tLcQhNlO03De4d4+JMksiEcAUqYCLqRx4M14MM3LnP9wC5RItlawgSOUU/OeuddYVoYFvSRMbmoFHiA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=gijH8KB+; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=QROrmh3l; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="gijH8KB+";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="QROrmh3l"
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 155F31140110;
	Tue, 29 Apr 2025 03:52:25 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Tue, 29 Apr 2025 03:52:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1745913145;
	 x=1745999545; bh=JhbTR5FvSMUzu1DPWJg2L5pb2a3AcJEgcr17ckJcrdw=; b=
	gijH8KB+V2XOqQpLnQ1/Y6L3qKrc5ROC56Vu3fm5OIXdy0NK1IHTZMNfGjRYG7Ag
	eZNIuP+55S+qVuEXLWs0VXlgKNuYh+f3as3JmkLMXr5vpyUmTERSP82BATCKmFh4
	PdM77gWh8S5WsTRx5s2eplJVJIfonwWXtN+9vNF87Ci8b+s7u/KsDQyyZPzwxmfm
	0lnq5Zczsa+A+JXklDRViKq81UMyfAhwTdtrUM+Xt2VmJS0el/7ggZoXBXdBjVfy
	rru3Hk0i07rZUcJxv/+cLypIL9lNZTD7LUjsngw0KVczNjSs56glpcf9rNxacgU+
	lGH4HGmOncfr4wdEyACxWA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1745913145; x=
	1745999545; bh=JhbTR5FvSMUzu1DPWJg2L5pb2a3AcJEgcr17ckJcrdw=; b=Q
	ROrmh3lU/LO/MklsY1bIbLYVKIe2dW3Zox2jUzidBsHbVaImtsLPwiZ7FnApRxPp
	JlHYZoLfNg+/WYFuzJIeWdVZ4fL1Adl16KJj8TnofpJT7g4VTq1IdzUUu3hoX6AH
	Q5vOo39lyG9+0zHIkNokPv3dFD2aSRAZpoIyum03N1lFpd0OMornAmBCY0sfiQXx
	vqenTYHd3Jt+Cpq96DU+K7M6QEM6nFigyBzELS+N+1q41erurFKW1ZDOaVjabkIF
	pT0a4vFK7MHt/Tr+BYH0SWCk7+p313ORfEGnV/tQIS9XdA+ltciwm+FQg+QL5QYT
	CEhluj337nOp4p8tKroGg==
X-ME-Sender: <xms:OIUQaNw-9GJY3bFHjzX6aW5eLkcis99iYYMybCkjH_odJZl34LgtEw>
    <xme:OIUQaNSHPpVYeYfznjl7jpayw2AVvqW-FbhI1hJ1juzAlp07FReYRwptauopOTzcx
    _D0ul0wQx976PPqvQ>
X-ME-Received: <xmr:OIUQaHWleMBOZfMuN0kLB5ozN4Qm_0JbPuSACSzlnlmjHOdwgKSbIkGegQdkTmPsl9ZQ0Nr2EiAva9_WDVE1fZ9-LQknCd9aS_iov9BiyuY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvieefvdeiucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertder
    tdejnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhksh
    drihhmqeenucggtffrrghtthgvrhhnpeffueeiudejvdekheeuvdekfeffiedvueelteek
    udehjeetkeegvddugfdtgfeileenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeefpdhmohgu
    vgepshhmthhpohhuthdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorh
    hgpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomhdprhgtphhtthhopehk
    rghrthhhihhkrddukeeksehgmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:OIUQaPj8xJp0a24UgRuPviMaibCMp-oTQBUm6doR0reT2LADaqrMPg>
    <xmx:OIUQaPBJCmLgcoSb7cqf-C_2KT_uzP9LTkDqph_c9fbSxdSH4kL7mQ>
    <xmx:OIUQaIK39cbFEmaxuBmLVsObJjm0pfmyKrEGDhXRGKjeOlLVYbqH8Q>
    <xmx:OIUQaOB_89PMYGtcKQ2OaYqhMaA9-eNpoy5be57y4A9lMPYtwwJ7uw>
    <xmx:OYUQaI-EPgvy049b9T-D5GJpQijkhR1A6y4uBMZRSiGwh4ORAKUs1cJL>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 29 Apr 2025 03:52:24 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 72adf817 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Tue, 29 Apr 2025 07:52:17 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Tue, 29 Apr 2025 09:52:15 +0200
Subject: [PATCH v3 1/7] object-store: move `struct packed_git` into
 "packfile.h"
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250429-pks-object-store-cleanups-v3-1-42902bad09a1@pks.im>
References: <20250429-pks-object-store-cleanups-v3-0-42902bad09a1@pks.im>
In-Reply-To: <20250429-pks-object-store-cleanups-v3-0-42902bad09a1@pks.im>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>, 
 Junio C Hamano <gitster@pobox.com>
X-Mailer: b4 0.14.2

The "object-store.h" header contains the definition of `struct
packed_git`. As this structure hosts all kind of information about a
specific packfile it is arguably a bit out of place in a generic place
like "object-store.h".

Move the structure as well as `pack_map_entry_cmp()` into "packfile.h".

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 object-store.h | 59 +---------------------------------------------------------
 pack-objects.h |  1 +
 packfile.h     | 59 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++-
 3 files changed, 60 insertions(+), 59 deletions(-)

diff --git a/object-store.h b/object-store.h
index 46961dc9542..e04469a85fb 100644
--- a/object-store.h
+++ b/object-store.h
@@ -92,65 +92,8 @@ struct oidtree *odb_loose_cache(struct object_directory *odb,
 /* Empty the loose object cache for the specified object directory. */
 void odb_clear_loose_cache(struct object_directory *odb);
 
-struct packed_git {
-	struct hashmap_entry packmap_ent;
-	struct packed_git *next;
-	struct list_head mru;
-	struct pack_window *windows;
-	off_t pack_size;
-	const void *index_data;
-	size_t index_size;
-	uint32_t num_objects;
-	size_t crc_offset;
-	struct oidset bad_objects;
-	int index_version;
-	time_t mtime;
-	int pack_fd;
-	int index;              /* for builtin/pack-objects.c */
-	unsigned pack_local:1,
-		 pack_keep:1,
-		 pack_keep_in_core:1,
-		 freshened:1,
-		 do_not_close:1,
-		 pack_promisor:1,
-		 multi_pack_index:1,
-		 is_cruft:1;
-	unsigned char hash[GIT_MAX_RAWSZ];
-	struct revindex_entry *revindex;
-	const uint32_t *revindex_data;
-	const uint32_t *revindex_map;
-	size_t revindex_size;
-	/*
-	 * mtimes_map points at the beginning of the memory mapped region of
-	 * this pack's corresponding .mtimes file, and mtimes_size is the size
-	 * of that .mtimes file
-	 */
-	const uint32_t *mtimes_map;
-	size_t mtimes_size;
-
-	/* repo denotes the repository this packfile belongs to */
-	struct repository *repo;
-
-	/* something like ".git/objects/pack/xxxxx.pack" */
-	char pack_name[FLEX_ARRAY]; /* more */
-};
-
+struct packed_git;
 struct multi_pack_index;
-
-static inline int pack_map_entry_cmp(const void *cmp_data UNUSED,
-				     const struct hashmap_entry *entry,
-				     const struct hashmap_entry *entry2,
-				     const void *keydata)
-{
-	const char *key = keydata;
-	const struct packed_git *pg1, *pg2;
-
-	pg1 = container_of(entry, const struct packed_git, packmap_ent);
-	pg2 = container_of(entry2, const struct packed_git, packmap_ent);
-
-	return strcmp(pg1->pack_name, key ? key : pg2->pack_name);
-}
-
 struct cached_object_entry;
 
 struct raw_object_store {
diff --git a/pack-objects.h b/pack-objects.h
index d1c4ae7f9b6..475a2d67ce3 100644
--- a/pack-objects.h
+++ b/pack-objects.h
@@ -4,6 +4,7 @@
 #include "object-store.h"
 #include "thread-utils.h"
 #include "pack.h"
+#include "packfile.h"
 
 struct repository;
 
diff --git a/packfile.h b/packfile.h
index 25097213d06..05499382397 100644
--- a/packfile.h
+++ b/packfile.h
@@ -1,13 +1,70 @@
 #ifndef PACKFILE_H
 #define PACKFILE_H
 
+#include "list.h"
 #include "object.h"
 #include "oidset.h"
 
 /* in object-store.h */
-struct packed_git;
 struct object_info;
 
+struct packed_git {
+	struct hashmap_entry packmap_ent;
+	struct packed_git *next;
+	struct list_head mru;
+	struct pack_window *windows;
+	off_t pack_size;
+	const void *index_data;
+	size_t index_size;
+	uint32_t num_objects;
+	size_t crc_offset;
+	struct oidset bad_objects;
+	int index_version;
+	time_t mtime;
+	int pack_fd;
+	int index;              /* for builtin/pack-objects.c */
+	unsigned pack_local:1,
+		 pack_keep:1,
+		 pack_keep_in_core:1,
+		 freshened:1,
+		 do_not_close:1,
+		 pack_promisor:1,
+		 multi_pack_index:1,
+		 is_cruft:1;
+	unsigned char hash[GIT_MAX_RAWSZ];
+	struct revindex_entry *revindex;
+	const uint32_t *revindex_data;
+	const uint32_t *revindex_map;
+	size_t revindex_size;
+	/*
+	 * mtimes_map points at the beginning of the memory mapped region of
+	 * this pack's corresponding .mtimes file, and mtimes_size is the size
+	 * of that .mtimes file
+	 */
+	const uint32_t *mtimes_map;
+	size_t mtimes_size;
+
+	/* repo denotes the repository this packfile belongs to */
+	struct repository *repo;
+
+	/* something like ".git/objects/pack/xxxxx.pack" */
+	char pack_name[FLEX_ARRAY]; /* more */
+};
+
+static inline int pack_map_entry_cmp(const void *cmp_data UNUSED,
+				     const struct hashmap_entry *entry,
+				     const struct hashmap_entry *entry2,
+				     const void *keydata)
+{
+	const char *key = keydata;
+	const struct packed_git *pg1, *pg2;
+
+	pg1 = container_of(entry, const struct packed_git, packmap_ent);
+	pg2 = container_of(entry2, const struct packed_git, packmap_ent);
+
+	return strcmp(pg1->pack_name, key ? key : pg2->pack_name);
+}
+
 struct pack_window {
 	struct pack_window *next;
 	unsigned char *base;

-- 
2.49.0.967.g6a0df3ecc3.dirty

