Received: from fout-b2-smtp.messagingengine.com (fout-b2-smtp.messagingengine.com [202.12.124.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 947121D6199
	for <git@vger.kernel.org>; Mon, 10 Mar 2025 07:13:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741590821; cv=none; b=W7o/5L1U+wl0HH0Ya/OL1scqxhY9CogCn4ryKRgA4bsQvxbTy4qCWChA8AW9tC2pH/GUPQkHsMGfNZhndSxEpzSB2+JYRp8Tk9+XEy01iGKl9BP9nM9zvc2IBELYbmvucvxZKwW3W44kAuA8weHy4Wmbp385b5ZKQHcc+aBnxkA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741590821; c=relaxed/simple;
	bh=U0QcKtD2WdFY83c2bWUuqe2WkcIgzACZuaHt2DwwIGE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=K+vl3QeA8YzzJe93odPloDaeACI441bkwjCvWC6lLjUZ69++sn+NYpFfrnImifHWEgoDqI7HdtflEcLpOZd73vIA0EPYrf1h0oVbumDxejYjwxLHZxZjxAMnQ2p7ia3u2Fr8ERXC2BaPPBCtKUKZ84KYwxi0Rnul3wdcnXo/jAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=o0Gpn0YF; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=GAHZB/WZ; arc=none smtp.client-ip=202.12.124.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="o0Gpn0YF";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="GAHZB/WZ"
Received: from phl-compute-10.internal (phl-compute-10.phl.internal [10.202.2.50])
	by mailfout.stl.internal (Postfix) with ESMTP id 9F2EA11400F5;
	Mon, 10 Mar 2025 03:13:38 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-10.internal (MEProxy); Mon, 10 Mar 2025 03:13:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1741590818;
	 x=1741677218; bh=j8wM8xxqHp3SL2yruZvF/i0o952TBSUUOCa513JA0WI=; b=
	o0Gpn0YFFWODO1uu0SSKoXaWh7eDDQBYtrjSUPjp3jimnZzwCZSpTVQw5IbnYpz/
	SZWVXM2UYrGSQKYJZs1ER8NxZLUHr61CyKRYlCFcMKP/E8xVEzpwRQJ94/SeuZ8T
	LUppFoR6Wd3m5/AenP0nTLDjXr9dhC4JG58sEaY++Cx3l/XU3L/VAksLxt3UDXsB
	2c3SP2aSDWLa5ALbmrsTxwpf7nTLhWKnaqhrGJFIO64ykpVjLJ7iWonJxaycWY7Q
	M/mFBHa/cDi35SEEzBdYghOU8n8cAbedQEloa3L2qLq8p7rIheXgwvXI6pEUU0OJ
	JxJuvbdGDI5pTkhaqrXweQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1741590818; x=
	1741677218; bh=j8wM8xxqHp3SL2yruZvF/i0o952TBSUUOCa513JA0WI=; b=G
	AHZB/WZWFsjevXOjn01MfVGadQGgdhuCOXV91WCu3u9MR4XHnH/jmep2yzYcNfyt
	XxBVJD3w0qoar0fphHJ0BtpYEluDFzWzvvejXKwgwxgy4lNHCtbCwzziR5WNNeWl
	7qwEx+JQEf/Lu9UjfsxFxEZvDqNx4US9Zhvxzf+k6bx0DYoohZiqqTt7XOaPpOA7
	/zdsSKeGdmQnYClABYrG+f26IE0fYV9y2TuuHqliY3JuDNpaNpKT3SLKSQd+LppX
	RQItgCxOFZTMZcmHHxPjHNidoY5QiJWsWYA3qSRqbhj+NMF1bSFw8yTC97XCM6p2
	9nrfYNRKwjN23Dv5KPK2g==
X-ME-Sender: <xms:IpHOZ_vJZytMQZZ1sYWkOQiLqhCyi14VoxqUD57jwJuBrt6dfzgv4A>
    <xme:IpHOZweeAuBuGPtYd1C5Gi3xWxPn2C0CanUnGe5mYamHQDIvCAMMhAVEaBQKTPrhu
    9QnJV8bWYYfANtbYg>
X-ME-Received: <xmr:IpHOZyzr63KwNQ2pt42GNHu_0QumSkrdHldoxVl6Zp3mLBUDuDXdZmdL-h0lFFNGdZQfWJaRDsfZ9XAu2kAtgyZBN6v36Gb9cTgmDFu3sR8hKQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdduudekjeduucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertder
    tdejnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhksh
    drihhmqeenucggtffrrghtthgvrhhnpeffueeiudejvdekheeuvdekfeffiedvueelteek
    udehjeetkeegvddugfdtgfeileenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeegpdhmohgu
    vgepshhmthhpohhuthdprhgtphhtthhopehjlhhtohgslhgvrhesghhmrghilhdrtghomh
    dprhgtphhtthhopehnvgifrhgvnhesghhmrghilhdrtghomhdprhgtphhtthhopehkrghr
    thhhihhkrddukeeksehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrd
    hkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:IpHOZ-MVMB2290tSrTQv8ipFKwQYgADPNN6avNZUeiBZXwPOnvi4Vg>
    <xmx:IpHOZ_8Hq-Sf-GjBYiAeLr2hJ1S9HpezhQ1QeRn15y_uwsA5dz1Enw>
    <xmx:IpHOZ-Ud_AcQopbORkn9ssynBofCeYOEZ1F-9y4b0aiC76VaRs1u2w>
    <xmx:IpHOZwcK7oDz5Wo8DyMJaTU7srXTputltfWCr0JnKMR3PnwZhxWhTA>
    <xmx:IpHOZ7Yy3pdH5EVNd1g9231QokKpIyp3juNdg1FezDNORXpwcilSwd7g>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 10 Mar 2025 03:13:37 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 18a3d52c (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 10 Mar 2025 07:13:32 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Mon, 10 Mar 2025 08:13:28 +0100
Subject: [PATCH v4 09/12] delta-islands: stop depending on `the_repository`
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250310-b4-pks-objects-without-the-repository-v4-9-f201b8ec57ba@pks.im>
References: <20250310-b4-pks-objects-without-the-repository-v4-0-f201b8ec57ba@pks.im>
In-Reply-To: <20250310-b4-pks-objects-without-the-repository-v4-0-f201b8ec57ba@pks.im>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>, 
 Justin Tobler <jltobler@gmail.com>, Elijah Newren <newren@gmail.com>
X-Mailer: b4 0.14.2

There are multiple sites in "delta-islands.c" where we use the
global `the_repository` variable, either explicitly or implicitly by
using `the_hash_algo`.

Refactor the code to stop using `the_repository`. In most cases this is
trivial because we already had a repository available in the calling
context, with the only exception being `propagate_island_marks()`. Adapt
it so that the repository gets passed in via a parameter.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/pack-objects.c |  2 +-
 delta-islands.c        | 14 ++++++--------
 delta-islands.h        |  2 +-
 3 files changed, 8 insertions(+), 10 deletions(-)

diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index eefc6c78096..fba5db74656 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -3847,7 +3847,7 @@ static void show_commit(struct commit *commit, void *data UNUSED)
 		index_commit_for_bitmap(commit);
 
 	if (use_delta_islands)
-		propagate_island_marks(commit);
+		propagate_island_marks(the_repository, commit);
 }
 
 static void show_object(struct object *obj, const char *name,
diff --git a/delta-islands.c b/delta-islands.c
index 3aec43fada3..36c94799d69 100644
--- a/delta-islands.c
+++ b/delta-islands.c
@@ -1,4 +1,3 @@
-#define USE_THE_REPOSITORY_VARIABLE
 #define DISABLE_SIGN_COMPARE_WARNINGS
 
 #include "git-compat-util.h"
@@ -267,8 +266,7 @@ void resolve_tree_islands(struct repository *r,
 	QSORT(todo, nr, tree_depth_compare);
 
 	if (progress)
-		progress_state = start_progress(the_repository,
-						_("Propagating island marks"), nr);
+		progress_state = start_progress(r, _("Propagating island marks"), nr);
 
 	for (i = 0; i < nr; i++) {
 		struct object_entry *ent = todo[i].entry;
@@ -490,9 +488,9 @@ void load_delta_islands(struct repository *r, int progress)
 
 	island_marks = kh_init_oid_map();
 
-	git_config(island_config_callback, &ild);
+	repo_config(r, island_config_callback, &ild);
 	ild.remote_islands = kh_init_str();
-	refs_for_each_ref(get_main_ref_store(the_repository),
+	refs_for_each_ref(get_main_ref_store(r),
 			  find_island_for_ref, &ild);
 	free_config_regexes(&ild);
 	deduplicate_islands(ild.remote_islands, r);
@@ -502,7 +500,7 @@ void load_delta_islands(struct repository *r, int progress)
 		fprintf(stderr, _("Marked %d islands, done.\n"), island_counter);
 }
 
-void propagate_island_marks(struct commit *commit)
+void propagate_island_marks(struct repository *r, struct commit *commit)
 {
 	khiter_t pos = kh_get_oid_map(island_marks, commit->object.oid);
 
@@ -510,8 +508,8 @@ void propagate_island_marks(struct commit *commit)
 		struct commit_list *p;
 		struct island_bitmap *root_marks = kh_value(island_marks, pos);
 
-		repo_parse_commit(the_repository, commit);
-		set_island_marks(&repo_get_commit_tree(the_repository, commit)->object,
+		repo_parse_commit(r, commit);
+		set_island_marks(&repo_get_commit_tree(r, commit)->object,
 				 root_marks);
 		for (p = commit->parents; p; p = p->next)
 			set_island_marks(&p->item->object, root_marks);
diff --git a/delta-islands.h b/delta-islands.h
index 8d1591ae28b..6107660306b 100644
--- a/delta-islands.h
+++ b/delta-islands.h
@@ -12,7 +12,7 @@ void resolve_tree_islands(struct repository *r,
 			  int progress,
 			  struct packing_data *to_pack);
 void load_delta_islands(struct repository *r, int progress);
-void propagate_island_marks(struct commit *commit);
+void propagate_island_marks(struct repository *r, struct commit *commit);
 int compute_pack_layers(struct packing_data *to_pack);
 void free_island_marks(void);
 

-- 
2.49.0.rc1.455.g4cd33545ba.dirty

