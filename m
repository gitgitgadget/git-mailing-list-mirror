Received: from fhigh-b7-smtp.messagingengine.com (fhigh-b7-smtp.messagingengine.com [202.12.124.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 864781FF1D0
	for <git@vger.kernel.org>; Fri, 21 Feb 2025 07:47:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740124062; cv=none; b=hKRvXdgmoHMd04jutksyLSFiA14Qp+mtvbLJhFyVd7doe3gt3h3eaidYvs/hfMfEILYXycKze0kW+E061B2F82LV7rwO1MBuqN464xJso5QSIWS0IJnPFbbOwH9Lt+YgY3TxBtg4+OMAp9RctrmcPNeKKF4cub7lP6NHNW9K1/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740124062; c=relaxed/simple;
	bh=rGzXzm0qIu7cp8YM8FB+sP2LdLROFhMDLCO1GxiHwEE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=hGtw8va/cjnBRUWDWQKURS/latQAortsDUaT5xI7bEpm2zstCUUfLzk7Kv8QejmpNmvNLps334pOOq5GmGtPiF+ZlHg8mVa8fW1gOPZ2udtIhtDl7iKs5XaM9fwf06BckXBT6jybKlTyly6VaB6YmV1Cbe32qEPISynPueN1Lto=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=A7gbrXAW; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=SDwhDc0l; arc=none smtp.client-ip=202.12.124.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="A7gbrXAW";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="SDwhDc0l"
Received: from phl-compute-09.internal (phl-compute-09.phl.internal [10.202.2.49])
	by mailfhigh.stl.internal (Postfix) with ESMTP id AA5362540219
	for <git@vger.kernel.org>; Fri, 21 Feb 2025 02:47:39 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-09.internal (MEProxy); Fri, 21 Feb 2025 02:47:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1740124059;
	 x=1740210459; bh=4CrZrDa6evDE4E9DdPSyYoRCnbE+sxwB27n8WtimNC4=; b=
	A7gbrXAWcEZecGubrZeqIqzCSRDTYy/KH46z8IHSJ33XGCa7bGsmf0SYZsGQCRQC
	s/+yOXEHvSL/HLFgh54EOB0NSFhJ5FaXp+AlC57EaKWF6MmlnCdnZm5lg/OeZrtU
	YB1Ux9NDe/N81rbkwBe3GtEJLNLV8dX4I4RGBkmsOKLQdD70x92MUJkKvt3Ukt/N
	Div0U8A+m8JXre2JT/wBrCpMA38SqYJlgGlv7uMStCzcrCYQbyZGc899ZxwZAfJT
	na+w1IBLELZ+cq6+3rKTVrNUdPFn0y4kureJL68QdViyYshNlvjYRPInwIG0vOZY
	9of76OmQ0iYq4SSaB/z2vA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1740124059; x=
	1740210459; bh=4CrZrDa6evDE4E9DdPSyYoRCnbE+sxwB27n8WtimNC4=; b=S
	DwhDc0ld40y9q+g+LsRd7K1QjkGwqjIqLmcolvS6eVAtGkuGblTUXVCDVGENE8Uo
	IG5FUthdQvJKGVEBDHG9IUMhX+vWXV69ELlo7A/UA0o1P4R1c5SUrSwvkfxo8skt
	huwZ8dSXIHbkE1HraHhYPacJEZlnCwgTdsOy5Odg+DRHa3/TrE88lGAyTrFcJvGr
	iqEWp2oIIOSwVCxjBeOOfAOJ//yB4UXZfoCH9eMaWktRFhF1T4yBVCxjfBpruMpH
	cLujSwnpxUR+ZnobYN/dIs5lFDc087ap2w7IbKr8wkfA5cmOhH+xgYzJx8DGD8ir
	UJqkwe6HKwn5kW3eMxQMA==
X-ME-Sender: <xms:my-4Z77Gii5sl4luHjrbwDEeZcPx8oqW6l4tFwvZja8H3ukAVtrM6Q>
    <xme:my-4Zw5vw8LKRiUgxtw25zrbXAn6afSw1MvvKhx7LO46diRJxLsn2mZ8wIJfSrJjP
    ZbyVGu2ZndNScoswQ>
X-ME-Received: <xmr:my-4Zyc1Rf9LPHr_tPi24l1ObFjE0TX9I4_RFfMsIy1MfLI6nXAsVDXUSx16lu4ErZEvFZiLP76Ydnaa_uP1K8pmyR3V_pLtMWYvDq_-snKrdg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdeileegjecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecunecujfgurhephfffuf
    ggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpefrrghtrhhitghkucfuthgv
    ihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpeffueeiud
    ejvdekheeuvdekfeffiedvueelteekudehjeetkeegvddugfdtgfeileenucevlhhushht
    vghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpd
    hnsggprhgtphhtthhopedupdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehgihht
    sehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:my-4Z8IXEPWZG8Z5bNy7-h2hkQqE8ewE_3-v7mDJmPPNdlXMd5wnZQ>
    <xmx:my-4Z_ItTiydWpzC6DH0OfHXILv9G2tJz1f5i9wwmsDtz8a-JjkOLg>
    <xmx:my-4Z1yYj9JLXhg0aU6mVm9_m8h51XOzhRglndYDx_6ZafP7jf5ysg>
    <xmx:my-4Z7IYdFlx8udrhLuYry5FINQTIa7ilMor-V6dulirS9yk04Pwhg>
    <xmx:my-4Z1iZNZ66M4TkUdsx-iV5HB3XL7iKkMrfTbsoapcBcyL16HiCLlUH>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Fri, 21 Feb 2025 02:47:38 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id f1affcbb (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Fri, 21 Feb 2025 07:47:36 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Fri, 21 Feb 2025 08:47:31 +0100
Subject: [PATCH 6/9] pack-bitmap: expose function to iterate over bitmapped
 objects
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250221-pks-cat-file-object-type-filter-v1-6-0852530888e2@pks.im>
References: <20250221-pks-cat-file-object-type-filter-v1-0-0852530888e2@pks.im>
In-Reply-To: <20250221-pks-cat-file-object-type-filter-v1-0-0852530888e2@pks.im>
To: git@vger.kernel.org
Cc: 
X-Mailer: b4 0.14.2

Expose a function that allows the caller to iterate over all bitmapped
objects of a specific type. This mechanism allows us to use the object
type-specific bitmaps to enumerate all objects of that type without
having to scan through a complete packfile.

This functionality will be used in a subsequent commit.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/pack-objects.c |  3 ++-
 builtin/rev-list.c     |  3 ++-
 pack-bitmap.c          | 65 +++++++++++++++++++++++++++++++-------------------
 pack-bitmap.h          | 12 +++++++++-
 reachable.c            |  3 ++-
 5 files changed, 57 insertions(+), 29 deletions(-)

diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index 58a9b161262..8f99e2b4fa8 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -1735,7 +1735,8 @@ static int add_object_entry(const struct object_id *oid, enum object_type type,
 static int add_object_entry_from_bitmap(const struct object_id *oid,
 					enum object_type type,
 					int flags UNUSED, uint32_t name_hash,
-					struct packed_git *pack, off_t offset)
+					struct packed_git *pack, off_t offset,
+					void *payload UNUSED)
 {
 	display_progress(progress_state, ++nr_seen);
 
diff --git a/builtin/rev-list.c b/builtin/rev-list.c
index bb26bee0d45..1100dd2abe7 100644
--- a/builtin/rev-list.c
+++ b/builtin/rev-list.c
@@ -429,7 +429,8 @@ static int show_object_fast(
 	int exclude UNUSED,
 	uint32_t name_hash UNUSED,
 	struct packed_git *found_pack UNUSED,
-	off_t found_offset UNUSED)
+	off_t found_offset UNUSED,
+	void *payload UNUSED)
 {
 	fprintf(stdout, "%s\n", oid_to_hex(oid));
 	return 1;
diff --git a/pack-bitmap.c b/pack-bitmap.c
index 6406953d322..fc92e0aae65 100644
--- a/pack-bitmap.c
+++ b/pack-bitmap.c
@@ -1509,50 +1509,45 @@ static void show_extended_objects(struct bitmap_index *bitmap_git,
 		    (obj->type == OBJ_TAG && !revs->tag_objects))
 			continue;
 
-		show_reach(&obj->oid, obj->type, 0, eindex->hashes[i], NULL, 0);
+		show_reach(&obj->oid, obj->type, 0, eindex->hashes[i], NULL, 0, NULL);
 	}
 }
 
-static void init_type_iterator(struct ewah_iterator *it,
-			       struct bitmap_index *bitmap_git,
-			       enum object_type type)
+static struct ewah_bitmap *ewah_for_type(struct bitmap_index *bitmap_git,
+					 enum object_type type)
 {
 	switch (type) {
 	case OBJ_COMMIT:
-		ewah_iterator_init(it, bitmap_git->commits);
-		break;
-
+		return bitmap_git->commits;
 	case OBJ_TREE:
-		ewah_iterator_init(it, bitmap_git->trees);
-		break;
-
+		return bitmap_git->trees;
 	case OBJ_BLOB:
-		ewah_iterator_init(it, bitmap_git->blobs);
-		break;
-
+		return bitmap_git->blobs;
 	case OBJ_TAG:
-		ewah_iterator_init(it, bitmap_git->tags);
-		break;
-
+		return bitmap_git->tags;
 	default:
 		BUG("object type %d not stored by bitmap type index", type);
-		break;
 	}
 }
 
-static void show_objects_for_type(
-	struct bitmap_index *bitmap_git,
-	enum object_type object_type,
-	show_reachable_fn show_reach)
+static void init_type_iterator(struct ewah_iterator *it,
+			       struct bitmap_index *bitmap_git,
+			       enum object_type type)
+{
+	ewah_iterator_init(it, ewah_for_type(bitmap_git, type));
+}
+
+static void for_each_bitmapped_object_internal(struct bitmap_index *bitmap_git,
+					       struct bitmap *objects,
+					       enum object_type object_type,
+					       show_reachable_fn show_reach,
+					       void *payload)
 {
 	size_t i = 0;
 	uint32_t offset;
-
 	struct ewah_iterator it;
 	eword_t filter;
 
-	struct bitmap *objects = bitmap_git->result;
-
 	init_type_iterator(&it, bitmap_git, object_type);
 
 	for (i = 0; i < objects->word_alloc &&
@@ -1595,11 +1590,31 @@ static void show_objects_for_type(
 			if (bitmap_git->hashes)
 				hash = get_be32(bitmap_git->hashes + index_pos);
 
-			show_reach(&oid, object_type, 0, hash, pack, ofs);
+			show_reach(&oid, object_type, 0, hash, pack, ofs, payload);
 		}
 	}
 }
 
+static void show_objects_for_type(
+	struct bitmap_index *bitmap_git,
+	enum object_type object_type,
+	show_reachable_fn show_reach)
+{
+	for_each_bitmapped_object_internal(bitmap_git, bitmap_git->result,
+					   object_type, show_reach, NULL);
+}
+
+void for_each_bitmapped_object(struct bitmap_index *bitmap_git,
+			       enum object_type object_type,
+			       show_reachable_fn show_reach,
+			       void *payload)
+{
+	struct bitmap *bitmap = ewah_to_bitmap(ewah_for_type(bitmap_git, object_type));
+	for_each_bitmapped_object_internal(bitmap_git, bitmap,
+					   object_type, show_reach, payload);
+	bitmap_free(bitmap);
+}
+
 static int in_bitmapped_pack(struct bitmap_index *bitmap_git,
 			     struct object_list *roots)
 {
diff --git a/pack-bitmap.h b/pack-bitmap.h
index d7f4b8b8e95..3368e79ed5a 100644
--- a/pack-bitmap.h
+++ b/pack-bitmap.h
@@ -50,7 +50,8 @@ typedef int (*show_reachable_fn)(
 	int flags,
 	uint32_t hash,
 	struct packed_git *found_pack,
-	off_t found_offset);
+	off_t found_offset,
+	void *payload);
 
 struct bitmap_index;
 
@@ -78,6 +79,15 @@ int test_bitmap_pseudo_merges(struct repository *r);
 int test_bitmap_pseudo_merge_commits(struct repository *r, uint32_t n);
 int test_bitmap_pseudo_merge_objects(struct repository *r, uint32_t n);
 
+/*
+ * Iterate through all bitmapped objects of the given type and execute the
+ * `show_reach` for each of them.
+ */
+ void for_each_bitmapped_object(struct bitmap_index *bitmap_git,
+			       enum object_type object_type,
+			       show_reachable_fn show_reach,
+			       void *payload);
+
 #define GIT_TEST_PACK_USE_BITMAP_BOUNDARY_TRAVERSAL \
 	"GIT_TEST_PACK_USE_BITMAP_BOUNDARY_TRAVERSAL"
 
diff --git a/reachable.c b/reachable.c
index ecf7ccf5041..dd33c7f07dd 100644
--- a/reachable.c
+++ b/reachable.c
@@ -337,7 +337,8 @@ static int mark_object_seen(const struct object_id *oid,
 			     int exclude UNUSED,
 			     uint32_t name_hash UNUSED,
 			     struct packed_git *found_pack UNUSED,
-			     off_t found_offset UNUSED)
+			     off_t found_offset UNUSED,
+			     void *payload UNUSED)
 {
 	struct object *obj = lookup_object_by_type(the_repository, oid, type);
 	if (!obj)

-- 
2.48.1.683.gf705b3209c.dirty

