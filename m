Received: from fout-a5-smtp.messagingengine.com (fout-a5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F3E8233707
	for <git@vger.kernel.org>; Fri, 25 Apr 2025 07:08:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745564942; cv=none; b=cJyH902jS+JVAl7EPLOD22B+84d5LgMeP5GYs2SkZtm8thGugctnfbp9Kua/uPtD4rFIXOJtbK3ObVJ4yEojbopkFEwL5Xd1wWhq0TSOkxaLqulMb99KkiOMkluFbemFvG/Oh7gRPlhOgYykoOlhkeK7IMTytFD55KX4nKAH1QY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745564942; c=relaxed/simple;
	bh=a3IR4HBQ6EF81bjdABYUMvx8vQcYJZRUZiGzT4yxOsA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ULssEoeK4rmekkKqJDS/HhSkmtvzhwGeKUKGFkNsMfHW0RIoD//7EI6pKwkfXqq9d9e4sn+e/mts6JoSqjFPgJgVr49pQ9Q6BOy+bsqPG+J+Awka0OkDiNZmg5hz59JV/VapevcPHRyZTAB1HV9SQmEkBobGa74TStMPPB76e6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=G1iXYX40; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=fSgR3bNZ; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="G1iXYX40";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="fSgR3bNZ"
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfout.phl.internal (Postfix) with ESMTP id 3F82A1380209;
	Fri, 25 Apr 2025 03:08:59 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Fri, 25 Apr 2025 03:08:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1745564939;
	 x=1745651339; bh=trQrWsCtfDvIFTgHjOC2QLKkazFl1LJ/rvr2zNg8QYc=; b=
	G1iXYX40CHplJl6pD+zzGirkTxpNz39rvsdqGqvrtVJFBqEBD6i4veF4Y4uhW3b1
	3jQapj7WmzPoXIMnNgJdCBgKAjfbenG11vm5TSxiXuQXQFtNDgAhvg+W9twyV1+1
	7GaQvLNBIXuS02gRmgIHufFslPfA12LXdkT6STRqfezSLyrEmLDeuGSzvAnuFWGF
	5dM6Gn/p52h5nDmobUNoY+Pah4ZhzzaxgqmEj1J/iAIdEOy6bqbI+W+nGJZNCo4p
	ktw4ucN6stTFmRShJ7g2/OhnwcuXsCac8gpfhQFXBMhHe8O2bD1tCy81jkVWG7hI
	sAglr/tDuoVpfV3dEO/ryA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1745564939; x=
	1745651339; bh=trQrWsCtfDvIFTgHjOC2QLKkazFl1LJ/rvr2zNg8QYc=; b=f
	SgR3bNZ5lWMOyvZEjeEg3FesvWsVSRwY7F7JUpGkx5kfXlFx6DuR8u6rs1ntaCNM
	aFsIiDQT//lEMI9BUtqhudF64r8bx3E7tw0jtaQHme1759+NbgwlsvRcW2IpbCH1
	otI6a4zGuR84fsJV+Pqsct331uNp+z3HHNhYaIqFSdaFHRCOVnc2JlO0R3V20WLf
	P4BberJnXlnBwB1Tu9BWuBlJXrsLtGj5bHaf03Jta8d8+myvJdgLunW8KBarvyR0
	vy9b88T6UuzJDny+yQKRFYKBd5cJv9EAJFLLgaFZuPXwQRm1UGiyg4flY16LgN0c
	2H40Betei3M4EgxBwYlMg==
X-ME-Sender: <xms:CzULaOlSfugWNORKjCgIOgR1j9CtpMElnOOSZKyzxJbOS3lE5FbA7g>
    <xme:CzULaF2_CEHgOLYEst1-nzDNxSbnepW8-VQr3QM0yg1p6oEPhOs3qUQw-iflDpeih
    YgByJMpnzJ2YvUK8Q>
X-ME-Received: <xmr:CzULaMpgw5PjXYzlEpe4NmqzpU7WVBjaYiScLGJqfrTKZ7GZkMhhAJkiU8-Mvbcr3Cbev_h-_OEJsBal2jmYNje8Ft7yNZas-c3S4yA3>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvhedujedtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertder
    tdejnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhksh
    drihhmqeenucggtffrrghtthgvrhhnpeffueeiudejvdekheeuvdekfeffiedvueelteek
    udehjeetkeegvddugfdtgfeileenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopedvpdhmohgu
    vgepshhmthhpohhuthdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorh
    hgpdhrtghpthhtohepkhgrrhhthhhikhdrudekkeesghhmrghilhdrtghomh
X-ME-Proxy: <xmx:CzULaCkeQR5_rFjPL6yWyI0IizuJsksamp2jx6RbWbvELX1q67pwKQ>
    <xmx:CzULaM1x4voQM9gjf7P4qwab19jcGWHn55Za-S1IrPk4mGJmEYKrgw>
    <xmx:CzULaJs-i3TVYjshrpBfcpUehOoFngSKqzZe7mbxuslcpEegybjEpA>
    <xmx:CzULaIV7Ck1MNF2ApctME6ModFf3xMNmdIiT_xXDY3hSVNC4bFp2sw>
    <xmx:CzULaERvzWcBvKzDTTzMbKi0yDNsANrSHnEbUzUqDcbitIGlkLqgLsHV>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 25 Apr 2025 03:08:58 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 7321efe2 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Fri, 25 Apr 2025 07:08:57 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Fri, 25 Apr 2025 09:08:52 +0200
Subject: [PATCH v2 01/13] object-store: move `struct packed_git` into
 "packfile.h"
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250425-pks-object-store-cleanups-v2-1-63f1695b7700@pks.im>
References: <20250425-pks-object-store-cleanups-v2-0-63f1695b7700@pks.im>
In-Reply-To: <20250425-pks-object-store-cleanups-v2-0-63f1695b7700@pks.im>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>
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
2.49.0.901.g37484f566f.dirty

