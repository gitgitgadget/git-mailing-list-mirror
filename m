Received: from fout-b5-smtp.messagingengine.com (fout-b5-smtp.messagingengine.com [202.12.124.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50DDE23959B
	for <git@vger.kernel.org>; Wed,  2 Apr 2025 11:13:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743592435; cv=none; b=gHnII3cEGeNCPnX1SfDKP6f2S2eOFNESvGyzD+m/REOtOWbBIAdoI+5H+aOSLtUj7OWnMj2vFyecnjX7+V6wMo8XSgRzeDQyXicZBRAMc9cUMDhOQ/1x61gaVfa2zY20xuIIWPz7HNzn9CnRQOp47p8xPhAXcxuseG+XWAtgOrg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743592435; c=relaxed/simple;
	bh=DDTStAhHiIfKBbwVsnYIbstSzugT6FLgryJDsP0Tkcw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=CddZtgMNE6KV5cA6f9sa0w6lrZH+uy5bZLVFDKYzq4XGR3jgzuwWGcc3qz00s3CScZSxXtZvoX7wuIXknClEfKiRUERlxYdR9ce/V3u4Nkgr9+N1MwgtH5AjGv8cyENU8xR+EkmHcCBpQpFinHG3PnC4XVSbtL6am4pkufppPi0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=QzaNiRNM; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=CI8uIgnt; arc=none smtp.client-ip=202.12.124.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="QzaNiRNM";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="CI8uIgnt"
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfout.stl.internal (Postfix) with ESMTP id 462B111401E8;
	Wed,  2 Apr 2025 07:13:52 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Wed, 02 Apr 2025 07:13:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1743592432;
	 x=1743678832; bh=Hgxa/nKepZ5hUx8hukMrdwlAHAGmttUhcBgrnpwqEoA=; b=
	QzaNiRNMRXqueqqvMDVFBLcq5gru74DwZxDvQWyLjbJhm57OeY1fYFeW0yTgVmoC
	L8nGSHblkU6yF5+P4z21rcRPTtEhTBhIJEMcHzDaclfNcdJcPx7a4SnJ67QaxHro
	t8u3XN4amnt75RPFg6vw48c8XPMzAuoD2D3wk0J72Wq1Mxn8ZZESUyQM++zCHUT7
	1WLZKj/cWTP/Y6QUpmHLFAL29pP5ag+Y6Ilw2CFOCwvj7/tbkLs6KmHgAy7vh9uE
	K3XYN2U+fgsqfmrQgr+n9wXD5J1vPVgXzlVk6ZlLyZkgKF9hJ2BYyjcFaIqlRePp
	Z1SOB6Sjx449maJyOLlZSg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1743592432; x=
	1743678832; bh=Hgxa/nKepZ5hUx8hukMrdwlAHAGmttUhcBgrnpwqEoA=; b=C
	I8uIgnt2xmzyQXwgAD8sMCWsjxzDhZEXekinHPBhOhOgUTtW1nyuMko/lRU20u6W
	DvYtPE68zmWff6PzFpxw7iSgl0b4NEQy7B7zGvlFxLPvK0JfxCUSaM3UPcSRMDMh
	o89FPeZLwdff73Gsq5E46yG9QpwweOb8c2KFakOOZjyciyX6MGcPzf2GISy0oDV/
	LwVnmryS0vijHJk45Fr/aiOU3rrcs17l+jfo9l1KkhXxIlGcfJSpS6Q4c7123aa1
	2oPYIb4y413eg1zrXeiBhttM6MNwib0Tihvgki5/kC8xbFWl2scHKFZfF0w+6ghR
	lj4y8+nz92VpVaQgCUbHQ==
X-ME-Sender: <xms:8BvtZ3FetCpGDT1S7gIUxSf4XXaHlMRdNR5X1JWb2VAFYznOzgntFQ>
    <xme:8BvtZ0XYx5EP_7WYeGjXTwaysYzguQ8X56RCKOmeDrOwwJa-vGxOPNNjP9kt4skwK
    MVWY9hYCvSb-Tt0-Q>
X-ME-Received: <xmr:8BvtZ5JrYctg6ZCkLg0r4pK86OeLh1RYfiKQWe3CEOFLw-U5pd27ikH7QOwQ5_eM5GmUJb0xcBt42_4Nll8tSDcZNHzstN5AbpwWcJe69A2UDg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddukeehhedvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertder
    tdejnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhksh
    drihhmqeenucggtffrrghtthgvrhhnpeffueeiudejvdekheeuvdekfeffiedvueelteek
    udehjeetkeegvddugfdtgfeileenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeehpdhmohgu
    vgepshhmthhpohhuthdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorh
    hgpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomhdprhgtphhtthhopehk
    rghrthhhihhkrddukeeksehgmhgrihhlrdgtohhmpdhrtghpthhtohepmhgvsehtthgrhi
    hlohhrrhdrtghomhdprhgtphhtthhopehtohhonhesihhothgtlhdrtghomh
X-ME-Proxy: <xmx:8BvtZ1FlmyrAXS_UTfVJYC5xghydKhd5oNG5lA-ypk2ep2d2T9VEMA>
    <xmx:8BvtZ9WtIKLRsuccLNbxjLmmaWXH2U2dNnEggwfRqMcrNMti_AEokA>
    <xmx:8BvtZwP-WdttAGACiIKifgNfksoCCcvT1Gqx0O-nHTDI7ieUJmbHsg>
    <xmx:8BvtZ81q6XY3dNdHtT1MGK0cIe8mUlYdtXC05BF5SdfNSehcAwiuDQ>
    <xmx:8BvtZzWPqvRRhIMM09C4x2JKmGaFdATqeNg4rKWndZXuGP-kEaYflrI2>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 2 Apr 2025 07:13:51 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 5437c1be (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 2 Apr 2025 11:13:47 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Wed, 02 Apr 2025 13:13:43 +0200
Subject: [PATCH v3 08/11] pack-bitmap: add function to iterate over
 filtered bitmapped objects
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250402-pks-cat-file-object-type-filter-v3-8-4da6bb21871c@pks.im>
References: <20250402-pks-cat-file-object-type-filter-v3-0-4da6bb21871c@pks.im>
In-Reply-To: <20250402-pks-cat-file-object-type-filter-v3-0-4da6bb21871c@pks.im>
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
2.49.0.604.gff1f9ca942.dirty

