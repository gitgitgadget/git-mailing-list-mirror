Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A3D31E3793
	for <git@vger.kernel.org>; Wed, 23 Apr 2025 07:48:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745394510; cv=none; b=BT0/rf7p25waN2ip+EHZMU4z/xBAKtRdpES0sVQayMOEwwO/fFDjGJVYg7S0LpfUqPmFRCU9ztdMUB5bddqicKjDUc6/2EN4RKbAvFs0P0JmwTm29lGYoqi6TeiEXrmxq2eyBXebx95qfUcGro1EguSdTI5Upc38+iWdunXY8rQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745394510; c=relaxed/simple;
	bh=a3IR4HBQ6EF81bjdABYUMvx8vQcYJZRUZiGzT4yxOsA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=oAlMhrk4rpeFBZNo4kLZo6cAwtD3EdmZrkkxguRpz21D/9+jO0S2F9YgG1/IjpEdoa9QDijAwMCeyX+Htkfjz+MHo3QAUU7xgfpfE0/7avlLIzfwJ8AxLdbe5pjUe/3FA94BMLlX6GWmpjXqYCcPBHQ5eXpCwM8VnI6e6o1z7Dw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Z7q/9kL9; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=pTiE5/Ph; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Z7q/9kL9";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="pTiE5/Ph"
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 5C90D11402A5
	for <git@vger.kernel.org>; Wed, 23 Apr 2025 03:48:26 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Wed, 23 Apr 2025 03:48:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1745394506;
	 x=1745480906; bh=trQrWsCtfDvIFTgHjOC2QLKkazFl1LJ/rvr2zNg8QYc=; b=
	Z7q/9kL9zSpDbdbXPdhb+SX+CySVKEpvJ6zBsCZsxm7jUKJ5hn8JnAJ9mmIWKNjk
	rWOngB1ydXAs2BvdinGSPLRMY3/32nOyoJuVEjClK0JLTlw+dcalaAFqGp6vPLFZ
	CnbPYgAyzp5gfLCmIDX9sYIKveyk0jVQReqH3mFqmdPqx8YUuhiwAZNzc10y4UnM
	B2cyTIHJAPf7e18CAS4pDT5wnrfl79t5f4QmQ6GPTiM1oVMaVbXd3zC22UNB7eYw
	QnLclbay6IK94swJMo3moIDA4utSxAIZ7CmyqPgOUyKW7nGgsGiu5iiYN69yJGpM
	2jKR8seidr46JDvOhH/PUA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1745394506; x=
	1745480906; bh=trQrWsCtfDvIFTgHjOC2QLKkazFl1LJ/rvr2zNg8QYc=; b=p
	TiE5/PhiPQQ4v0iy6/yho7KkCn9y0LxzyTMRjhMjZFBPIOrHEKvI5fBOdsI7PYhz
	Plpnp7M4V67M0RtiyaUAalj+rPBop+g8VwP2EcXGikO64A+sQto+Li2OUj0lMCTa
	KUvfnvaO2TBrEZzqMAEvhVvOdQvHjKzyRcHDv4bwjfMYbOC3eCkU8N+r67fQXoec
	YRNxoKT0GbNRdpDAmJlvri2U9Py+auGc0IXBAs22Bdf436H0YGTnRbCb86KnZJT4
	3/SDCK/W/rwRNxZd39LJkqSyLYohk3v6gUYpY9DUs4Q6F0pXeZ0Zzzm6J9BCtGL9
	Km8l7iP8WyDjhVGkkc/kA==
X-ME-Sender: <xms:SpsIaPvM3idTTeZZ0kCNNULFrhirOSDXyyP2GpEZvCUMSfG7JUI3xg>
    <xme:SpsIaAflYA8Cr0KClZ1pL9Xea--xkOVvbBXoE-sHqFiyOOUNNJAJGw6_3nUi0rEiv
    OYzZ9lWr43rZst-ng>
X-ME-Received: <xmr:SpsIaCwm2sX-GhA2PiXJRoqZuo8rNPdgj7CJE10ovRKC-h61vwzSb8nIViEVMyakH9he6t4D_r8hp8EWqQvH07OuUwFWduumtXHZbBZnRQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvgeeitdegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpefhff
    fugggtgffkfhgjvfevofesthejredtredtjeenucfhrhhomheprfgrthhrihgtkhcuufht
    vghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnhepffeuie
    dujedvkeehuedvkeefffeivdeuleetkeduheejteekgedvudfgtdfgieelnecuvehluhhs
    thgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimh
    dpnhgspghrtghpthhtohepuddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepghhi
    thesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:SpsIaOM0odnEyXww2AtwIvbpwNmt6GNQEjYQZ-Tlofi4YWSmaH5z_w>
    <xmx:SpsIaP86r1bCRuSO8pE3TQRU02DQVjjFolZCUeqmRgzfXz29CdsHcg>
    <xmx:SpsIaOXUl10nQt0VVsc7jeHulrktzOqooI3Pbulou9S11eBmUwue2Q>
    <xmx:SpsIaAf1pI5UTuKBTNQG-nq9VjGETcSIBTkkfgPuJKuau04vBNK8NQ>
    <xmx:SpsIaGZUSbjiUXbFv_yvpCjiym7H1ccwdifkMLHSMILpBOS5v3h2Q1eG>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Wed, 23 Apr 2025 03:48:25 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 99bebbc1 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO)
	for <git@vger.kernel.org>;
	Wed, 23 Apr 2025 07:48:23 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Wed, 23 Apr 2025 09:48:11 +0200
Subject: [PATCH 01/13] object-store: move `struct packed_git` into
 "packfile.h"
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250423-pks-object-store-cleanups-v1-1-81f8411a5d08@pks.im>
References: <20250423-pks-object-store-cleanups-v1-0-81f8411a5d08@pks.im>
In-Reply-To: <20250423-pks-object-store-cleanups-v1-0-81f8411a5d08@pks.im>
To: git@vger.kernel.org
Cc: 
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

