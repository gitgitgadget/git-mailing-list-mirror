Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BCDF20D4E3
	for <git@vger.kernel.org>; Thu, 27 Mar 2025 09:44:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743068654; cv=none; b=QQjPCc2Yos6/6tVcTyCJux1lRexfWdBNyrvjGoqn0zwfFQPjTw2wpsAH7XkkCJiPYsvU/KvVna1/QBoZLlbZpa80S2gQ2adtuT4w32ll0rcwT58ZmzeW+NzB6W84AAgFjwZPnLEWE0qtL81+BW54cLhIdZ+Yddyy3nWOhrLh6dw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743068654; c=relaxed/simple;
	bh=1BRmfNWY9JKcw1U+wyhN+W7Q4nS6iEyLJE19tYfiaRI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=mkhzs7CjtErfspncjwmERC6znsPIhTiGimYtwWe3RL9MrOKHksjJCvv8oJU10HpSy4l3sC3tQ588j/8HJeDS8iBKKFrNAh6LVJK2+6gQ5J6962gbgWne+bp8mlwdk7ydpKSfrbwuPoZhnGq2f9nH+Vxd4f5cbFgXvE9GgBql6xA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=sQqeWqj8; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=u0qMwDmj; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="sQqeWqj8";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="u0qMwDmj"
Received: from phl-compute-10.internal (phl-compute-10.phl.internal [10.202.2.50])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 45CBE11401ED;
	Thu, 27 Mar 2025 05:44:11 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-10.internal (MEProxy); Thu, 27 Mar 2025 05:44:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1743068651;
	 x=1743155051; bh=1aX2ymrE8tNilA1SNWzo7d5nLR5fwyMaR5d9x4F1uac=; b=
	sQqeWqj8XYIfam+QEygeWEr7gF9mBNEeq6q+p6T2BmFjTBetU5UhN0R8IQgIZQ75
	PEmeUaGLMSVtFJ5uyxXZTqpopax1ok5/1etx13V5DxP/3keHcl+fY5KjjTXpHQ+a
	Pg4Cc2VFTFivTifQJOyhGF0Wv10ORYKnIk991BwNwGFMcb2cBONqysaiTxFA+kK9
	g+dHeQSIV0miKXy2QBsedHpXxQl6uzZt1+Rfz1djn01As2CR9PL7Bg5x2eI5bQnV
	i3Z33Ki+XYJQU9FOMBDnrkeu2PiGpSSxZFVgHlKWGqvCrxzxrbo2w6F2rVuhqj9k
	EIl3YeffEIXVsLmGm+iESg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1743068651; x=
	1743155051; bh=1aX2ymrE8tNilA1SNWzo7d5nLR5fwyMaR5d9x4F1uac=; b=u
	0qMwDmjl/PKJTlns9V/gpZEnu3cRa1pubHrBE135rphUvaw84O0DXdjISX7yIbrH
	Q548+HZO6O6/+6PNXN00NJht3pyZtrifl3yWYxACrdZsHcTs1sA+V3uucltGS/Ir
	JAo4ZIf4qpaW89A7XZdZ3Oo7kRmKcu3k3yMg0XeMCZy6D1umd0DZbB8gSRR/uw+d
	/zSeaZDQMmOa+qAnEIjnBwABlOalQ+5KfbMF4U24X74QARnuxdkb5QcvwuStabzX
	0hMMbIW41KnOFpu9HgD9DMTygm7B7Vc+0Qqs5LcLhUQQzd495ZnoqwHi0A5RWyeP
	JnEMMgrkQSbMLEAI1T/Ag==
X-ME-Sender: <xms:6x3lZxBATeQShakIJoW6ffklUgFYJLWvzTaZn5D0J8d-qSm4WbDEaw>
    <xme:6x3lZ_jCKNNsW47IQVqxwjW1UIjF28CW6AbuO2OrgxbxHNDEnLD7NJYZ9LLgUexQo
    SY8DYxViZPStZO9-A>
X-ME-Received: <xmr:6x3lZ8krhktfW07BXY9s5puGwl9llWpf9BUH4o4h3VP_atgXdEIUxdgDyr_EHmEgXjl4IE0-RPGSQQWy7UZOciCaN65jBvJh40p8M4ItJiBSAg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdduieektdekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertder
    tdejnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhksh
    drihhmqeenucggtffrrghtthgvrhhnpeffueeiudejvdekheeuvdekfeffiedvueelteek
    udehjeetkeegvddugfdtgfeileenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeehpdhmohgu
    vgepshhmthhpohhuthdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorh
    hgpdhrtghpthhtohepmhgvsehtthgrhihlohhrrhdrtghomhdprhgtphhtthhopehgihht
    shhtvghrsehpohgsohigrdgtohhmpdhrtghpthhtohepthhoohhnsehiohhttghlrdgtoh
    hmpdhrtghpthhtohepkhgrrhhthhhikhdrudekkeesghhmrghilhdrtghomh
X-ME-Proxy: <xmx:6x3lZ7ympqPf1JNjP2uQ9ln1FHyOPmidUdvN2zp7z9-qfckouEo90A>
    <xmx:6x3lZ2SqVWGki_WcMR2YdiZYOes9uZBNIW3R3nE5pbTl-qhdEv82Pg>
    <xmx:6x3lZ-YAprWyDfLOZdnKcDyryWMzHNaTtlP0s7mYWGomxkDA7VVZ5Q>
    <xmx:6x3lZ3SXIjfEDe2LW017u8YJAovzIovvruNX4wx3vyxFwiYon0WS-w>
    <xmx:6x3lZzIbFk1hZyqsSLpMV5oULbt-v-j8Z0FboWl_yKckqbFgC4cga_UI>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 27 Mar 2025 05:44:10 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 2b2272a8 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 27 Mar 2025 09:44:07 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Thu, 27 Mar 2025 10:44:01 +0100
Subject: [PATCH v2 06/10] pack-bitmap: allow passing payloads to
 `show_reachable_fn()`
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250327-pks-cat-file-object-type-filter-v2-6-4bbc7085d7c5@pks.im>
References: <20250327-pks-cat-file-object-type-filter-v2-0-4bbc7085d7c5@pks.im>
In-Reply-To: <20250327-pks-cat-file-object-type-filter-v2-0-4bbc7085d7c5@pks.im>
To: git@vger.kernel.org
Cc: Toon Claes <toon@iotcl.com>, Karthik Nayak <karthik.188@gmail.com>, 
 Taylor Blau <me@ttaylorr.com>, Junio C Hamano <gitster@pobox.com>
X-Mailer: b4 0.14.2

The `show_reachable_fn` callback is used by a couple of functions to
present reachable objects to the caller. The function does not provide a
way for the caller to pass a payload though, which is functionality that
we'll require in a subsequent commit.

Change the callback type to accept a payload and adapt all callsites
accordingly.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/pack-objects.c |  3 ++-
 builtin/rev-list.c     |  3 ++-
 pack-bitmap.c          | 15 ++++++++-------
 pack-bitmap.h          |  3 ++-
 reachable.c            |  3 ++-
 5 files changed, 16 insertions(+), 11 deletions(-)

diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index a7e4bb79049..38784613fc0 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -1736,7 +1736,8 @@ static int add_object_entry(const struct object_id *oid, enum object_type type,
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
index 6f7fd94c36f..d192fb87da9 100644
--- a/pack-bitmap.c
+++ b/pack-bitmap.c
@@ -1625,7 +1625,7 @@ static void show_extended_objects(struct bitmap_index *bitmap_git,
 		    (obj->type == OBJ_TAG && !revs->tag_objects))
 			continue;
 
-		show_reach(&obj->oid, obj->type, 0, eindex->hashes[i], NULL, 0);
+		show_reach(&obj->oid, obj->type, 0, eindex->hashes[i], NULL, 0, NULL);
 	}
 }
 
@@ -1663,7 +1663,8 @@ static void init_type_iterator(struct ewah_or_iterator *it,
 static void show_objects_for_type(
 	struct bitmap_index *bitmap_git,
 	enum object_type object_type,
-	show_reachable_fn show_reach)
+	show_reachable_fn show_reach,
+	void *payload)
 {
 	size_t i = 0;
 	uint32_t offset;
@@ -1715,7 +1716,7 @@ static void show_objects_for_type(
 			if (bitmap_git->hashes)
 				hash = get_be32(bitmap_git->hashes + index_pos);
 
-			show_reach(&oid, object_type, 0, hash, pack, ofs);
+			show_reach(&oid, object_type, 0, hash, pack, ofs, payload);
 		}
 	}
 
@@ -2518,13 +2519,13 @@ void traverse_bitmap_commit_list(struct bitmap_index *bitmap_git,
 {
 	assert(bitmap_git->result);
 
-	show_objects_for_type(bitmap_git, OBJ_COMMIT, show_reachable);
+	show_objects_for_type(bitmap_git, OBJ_COMMIT, show_reachable, NULL);
 	if (revs->tree_objects)
-		show_objects_for_type(bitmap_git, OBJ_TREE, show_reachable);
+		show_objects_for_type(bitmap_git, OBJ_TREE, show_reachable, NULL);
 	if (revs->blob_objects)
-		show_objects_for_type(bitmap_git, OBJ_BLOB, show_reachable);
+		show_objects_for_type(bitmap_git, OBJ_BLOB, show_reachable, NULL);
 	if (revs->tag_objects)
-		show_objects_for_type(bitmap_git, OBJ_TAG, show_reachable);
+		show_objects_for_type(bitmap_git, OBJ_TAG, show_reachable, NULL);
 
 	show_extended_objects(bitmap_git, revs, show_reachable);
 }
diff --git a/pack-bitmap.h b/pack-bitmap.h
index dd0951088f6..de6bf534fef 100644
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
 
diff --git a/reachable.c b/reachable.c
index 9ee04c89ec6..421d354d3b5 100644
--- a/reachable.c
+++ b/reachable.c
@@ -341,7 +341,8 @@ static int mark_object_seen(const struct object_id *oid,
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
2.49.0.472.ge94155a9ec.dirty

