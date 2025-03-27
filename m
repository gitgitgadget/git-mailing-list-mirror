Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BB6E20D4E6
	for <git@vger.kernel.org>; Thu, 27 Mar 2025 09:44:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743068654; cv=none; b=oQ6XWqqtmNvxsJbhZNL0V6nx4od5zE6hCak4eyzcX8sYalTmd1RBpMO0OsZZYQx9zLKzRRiH8Y1IFQlGwwpNKtrBAW23Hjjimi42op+gnRRkQqiWJlbulOkfLUNcABgaeGqZaBRG3hWD+edhBV8lliuVhFvoEWbqado3WGoIPTs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743068654; c=relaxed/simple;
	bh=jnDFT1sgnHxuH7FuYHCoPR49aHUteGD4CGaqjg9cs2U=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=gqE+FtFviJiTJFhmngViw52hSu/zi8RoS/7HIyiaLBUCPNtIsTP0cv9Jy6kzh9BqrsWJM1dh8Gy2VZtFfuDfqC8lgKYuIuWNgkSb/TmoGmx4E4WZ/ThonPko/y04oBb2mVwR/nEZwH0F566+1+D8pu1IF6e90+ApJUanP4U6z6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=le24fIxm; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=A3WxwI3b; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="le24fIxm";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="A3WxwI3b"
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 5121211401EE;
	Thu, 27 Mar 2025 05:44:11 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Thu, 27 Mar 2025 05:44:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1743068651;
	 x=1743155051; bh=yx8XkeBmrGzH0ogcUWyqRp/7NO9VFTjYibRA/WeV9TE=; b=
	le24fIxmuSZVDnPws/4busao+WH8JwbIzZR7Fz+eBJb0Cy+8ruenieV4VT+u3N2a
	gqAxEhRlBkTYOjW9cwbfyqoegwt/bmDoi7rjrg/uPmsRH6U91MZ/NydEO5vWGPMX
	Mt0YoZdvtBIgsCc5y0YPH4xSny0GSiJjsZaceAvz6GXyT/HXm7+UGSI/+XuRGMAy
	2c1WKRwbXdSrx6jSYgAv0XAH3ikz3AfIxOdnvZVblBIMbElyAgT17h/Os+D3lCt7
	EAGQnbVxyCyJTKlS526tqynOke5ujlLE4j/2QVP02xfe2TkvaSQkvGY908f923pP
	VMwrdTaXbvDyA3Y9ySAXeQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1743068651; x=
	1743155051; bh=yx8XkeBmrGzH0ogcUWyqRp/7NO9VFTjYibRA/WeV9TE=; b=A
	3WxwI3biKFTPr358a0h4sVYIKRyf165Djf7qIXyTB/7larqoPBuPD3A/I3zcGkti
	4P9tS9bc9v0HSnvJxXIesMyUBTR6Jy4YbXz6phxKlVBgKBBS8lr20jNBLdAdd2Cd
	R5sm3njRpgqMhzEyDeHTnVoWQzZS4F8Xnmf0bsizzYpzhwC3nWeUc0OBK8uKeQ54
	EgzegSG16wJwLqh2frc8kFoNevmLlxHS4BH+v4kic38kMk7lI4NI08HfBgP49SHO
	qI+vPn1h98Ety6TEt1IYPPSifKS1VWvMau21ELP+7hsTrf1SjvP2L3PQmvo6+JeK
	PVrWaJsP5WJuci9W9VO5g==
X-ME-Sender: <xms:6x3lZ83d8nDEH-bYN77t7pOp-corTDq1r6lp0qC8Fq56dKui7lNxkw>
    <xme:6x3lZ3G6oNGSfXiyQA8wt37MRWjkMy7XmbufuahJ9j7SdJC_vN7SznIAb-X4pOmMz
    qERAJsUZlGdYCzIMg>
X-ME-Received: <xmr:6x3lZ05AfX6Wcr0g8HKGp08SHFz9xuO8RdUHkkYg2hGw1poMXNbHvpsjSP2hlGZeu-gFG27vI6UZp7aFN0qpRNqVknSZwTlBo9rV0isbhBunQg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdduieektdekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertder
    tdejnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhksh
    drihhmqeenucggtffrrghtthgvrhhnpeffueeiudejvdekheeuvdekfeffiedvueelteek
    udehjeetkeegvddugfdtgfeileenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeehpdhmohgu
    vgepshhmthhpohhuthdprhgtphhtthhopehkrghrthhhihhkrddukeeksehgmhgrihhlrd
    gtohhmpdhrtghpthhtohepthhoohhnsehiohhttghlrdgtohhmpdhrtghpthhtohepmhgv
    sehtthgrhihlohhrrhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvg
    hlrdhorhhgpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:6x3lZ13h5ZMPqB-abFBeB-UAXwXTmTnhde-ale1eDnjLxHAfXARwog>
    <xmx:6x3lZ_FGWiWUeaees3S5t06RChCI6vwRan8uBRvRJWPFmN9SKZIilA>
    <xmx:6x3lZ-9WP-js6eQLaBVEybsr6zVeOj6lfuwA4ZHjOqPubVnUlinGew>
    <xmx:6x3lZ0lPBKRVZRmBTOWVuOKJxMTipwDoolc6kcBIeY_E8NV32Bekdw>
    <xmx:6x3lZwMkC7QAygGOhGg5pPrOvHZ0WK9402kAfGHq58ZsIg2x9MMn5ieX>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 27 Mar 2025 05:44:10 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id cbea9d4a (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 27 Mar 2025 09:44:08 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Thu, 27 Mar 2025 10:44:02 +0100
Subject: [PATCH v2 07/10] pack-bitmap: add function to iterate over
 filtered bitmapped objects
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250327-pks-cat-file-object-type-filter-v2-7-4bbc7085d7c5@pks.im>
References: <20250327-pks-cat-file-object-type-filter-v2-0-4bbc7085d7c5@pks.im>
In-Reply-To: <20250327-pks-cat-file-object-type-filter-v2-0-4bbc7085d7c5@pks.im>
To: git@vger.kernel.org
Cc: Toon Claes <toon@iotcl.com>, Karthik Nayak <karthik.188@gmail.com>, 
 Taylor Blau <me@ttaylorr.com>, Junio C Hamano <gitster@pobox.com>
X-Mailer: b4 0.14.2

Introduce a function that allows the caller to iterate over all
bitmapped objects that match a given filter. This mechanism will be used
in a subsequent commit to optimize object filters in git-cat-file(1).

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 pack-bitmap.c | 59 +++++++++++++++++++++++++++++++++++++++++++++++++++++------
 pack-bitmap.h | 12 ++++++++++++
 2 files changed, 65 insertions(+), 6 deletions(-)

diff --git a/pack-bitmap.c b/pack-bitmap.c
index d192fb87da9..6adb8aaa1c2 100644
--- a/pack-bitmap.c
+++ b/pack-bitmap.c
@@ -1662,6 +1662,7 @@ static void init_type_iterator(struct ewah_or_iterator *it,
 
 static void show_objects_for_type(
 	struct bitmap_index *bitmap_git,
+	struct bitmap *objects,
 	enum object_type object_type,
 	show_reachable_fn show_reach,
 	void *payload)
@@ -1672,8 +1673,6 @@ static void show_objects_for_type(
 	struct ewah_or_iterator it;
 	eword_t filter;
 
-	struct bitmap *objects = bitmap_git->result;
-
 	init_type_iterator(&it, bitmap_git, object_type);
 
 	for (i = 0; i < objects->word_alloc &&
@@ -2025,6 +2024,50 @@ static void filter_packed_objects_from_bitmap(struct bitmap_index *bitmap_git,
 	}
 }
 
+int for_each_bitmapped_object(struct bitmap_index *bitmap_git,
+			      struct list_objects_filter_options *filter,
+			      show_reachable_fn show_reach,
+			      void *payload)
+{
+	struct bitmap *filtered_bitmap = NULL;
+	uint32_t objects_nr;
+	size_t full_word_count;
+	int ret;
+
+	if (!can_filter_bitmap(filter)) {
+		ret = -1;
+		goto out;
+	}
+
+	objects_nr = bitmap_num_objects(bitmap_git);
+	full_word_count = objects_nr / BITS_IN_EWORD;
+
+	/* We start from the all-1 bitmap and then filter down from there. */
+	filtered_bitmap = bitmap_word_alloc(full_word_count + !!(objects_nr % BITS_IN_EWORD));
+	memset(filtered_bitmap->words, 0xff, full_word_count * sizeof(*filtered_bitmap->words));
+	for (size_t i = full_word_count * BITS_IN_EWORD; i < objects_nr; i++)
+		bitmap_set(filtered_bitmap, i);
+
+	if (filter_bitmap(bitmap_git, NULL, filtered_bitmap, filter) < 0) {
+		ret = -1;
+		goto out;
+	}
+
+	show_objects_for_type(bitmap_git, filtered_bitmap,
+			      OBJ_COMMIT, show_reach, payload);
+	show_objects_for_type(bitmap_git, filtered_bitmap,
+			      OBJ_TREE, show_reach, payload);
+	show_objects_for_type(bitmap_git, filtered_bitmap,
+			      OBJ_BLOB, show_reach, payload);
+	show_objects_for_type(bitmap_git, filtered_bitmap,
+			      OBJ_TAG, show_reach, payload);
+
+	ret = 0;
+out:
+	bitmap_free(filtered_bitmap);
+	return ret;
+}
+
 struct bitmap_index *prepare_bitmap_walk(struct rev_info *revs,
 					 int filter_provided_objects)
 {
@@ -2519,13 +2562,17 @@ void traverse_bitmap_commit_list(struct bitmap_index *bitmap_git,
 {
 	assert(bitmap_git->result);
 
-	show_objects_for_type(bitmap_git, OBJ_COMMIT, show_reachable, NULL);
+	show_objects_for_type(bitmap_git, bitmap_git->result,
+			      OBJ_COMMIT, show_reachable, NULL);
 	if (revs->tree_objects)
-		show_objects_for_type(bitmap_git, OBJ_TREE, show_reachable, NULL);
+		show_objects_for_type(bitmap_git, bitmap_git->result,
+				      OBJ_TREE, show_reachable, NULL);
 	if (revs->blob_objects)
-		show_objects_for_type(bitmap_git, OBJ_BLOB, show_reachable, NULL);
+		show_objects_for_type(bitmap_git, bitmap_git->result,
+				      OBJ_BLOB, show_reachable, NULL);
 	if (revs->tag_objects)
-		show_objects_for_type(bitmap_git, OBJ_TAG, show_reachable, NULL);
+		show_objects_for_type(bitmap_git, bitmap_git->result,
+				      OBJ_TAG, show_reachable, NULL);
 
 	show_extended_objects(bitmap_git, revs, show_reachable);
 }
diff --git a/pack-bitmap.h b/pack-bitmap.h
index de6bf534fef..079bae32466 100644
--- a/pack-bitmap.h
+++ b/pack-bitmap.h
@@ -79,6 +79,18 @@ int test_bitmap_pseudo_merges(struct repository *r);
 int test_bitmap_pseudo_merge_commits(struct repository *r, uint32_t n);
 int test_bitmap_pseudo_merge_objects(struct repository *r, uint32_t n);
 
+struct list_objects_filter_options;
+
+/*
+ * Filter bitmapped objects and iterate through all resulting objects,
+ * executing `show_reach` for each of them. Returns `-1` in case the filter is
+ * not supported, `0` otherwise.
+ */
+int for_each_bitmapped_object(struct bitmap_index *bitmap_git,
+			      struct list_objects_filter_options *filter,
+			      show_reachable_fn show_reach,
+			      void *payload);
+
 #define GIT_TEST_PACK_USE_BITMAP_BOUNDARY_TRAVERSAL \
 	"GIT_TEST_PACK_USE_BITMAP_BOUNDARY_TRAVERSAL"
 

-- 
2.49.0.472.ge94155a9ec.dirty

