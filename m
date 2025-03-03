Received: from fout-b4-smtp.messagingengine.com (fout-b4-smtp.messagingengine.com [202.12.124.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFDC91F3D5D
	for <git@vger.kernel.org>; Mon,  3 Mar 2025 08:47:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740991666; cv=none; b=fNJCbptfHPg5/ArUgQzI/zOfKzPDRVNZ15RRXak474GmsPLx60DzyY2g2z6m34q0oj1jTMQQjWEUJK+XUI+NAhrOangSqukJnkOEr5O0vu9jeMNaQYy62W/2E3oeQlbBn+AagCiwaf9m+ycR7yZzeOHRXSYcDOT8sc6Our1qiNo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740991666; c=relaxed/simple;
	bh=miJ3scMwnjPehLrv/nXiZw3PI3MVNY8g+TDyqYhzJwU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=lvF8S+R+EeP2CGYF6RbYRaQ5lXB/se7aJ/2URjrvLyBRJl2aeBQSoS1GOGcJ+v0aPZZQqjULKzIPsBSV0oqpePo1mWZQQuUbDZsRwxGQg56VMZkV3pz0PafJPNMn/R65bc7DXR2By2aNoUAqqn/WSYYvgEF5YFys17TbrAR8Vho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=kyergz7q; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=QkqfR8D0; arc=none smtp.client-ip=202.12.124.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="kyergz7q";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="QkqfR8D0"
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfout.stl.internal (Postfix) with ESMTP id F1FD011400FC
	for <git@vger.kernel.org>; Mon,  3 Mar 2025 03:47:43 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Mon, 03 Mar 2025 03:47:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1740991663;
	 x=1741078063; bh=znDx6vLkUvyvPocbG7xosQTHV6heKWY41M9mazN3wTY=; b=
	kyergz7qlRRg8n3dIm4QN4LBKr2ZBenuVdZyk8EK5ij7NaCl0X/ApXlZtVcYU+c8
	DKUnqGS+Yx5s5zS1VLfeixsx2IVNGsclinNQdKKl6X3pknUf3sHrGO88dverBnjB
	8sYndhCan0wzQAXiFLv825IZGtdt89gGflQT+0Je/Znd6gSeDjwLyK0f4mR1ZR7H
	rc5/LZqNB0lemh0BIQkwJBXIU74ZXe2AvAdiog112Hzfc0Gk2Z63wropPWibON/x
	mc0DCvuiSZVY5vdG7JrUzNJLzHIlyc4mCA7C6RY4jmXXhN5XBKNmANqp/mIz6was
	vL5YgsMwfN1WVL8mJuGtfw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1740991663; x=
	1741078063; bh=znDx6vLkUvyvPocbG7xosQTHV6heKWY41M9mazN3wTY=; b=Q
	kqfR8D0gTtGyzjjNSBwWBrhwKXhkiy8ZuBeaPWpzQfD7YP+fjSWmkkx4LVVFuwff
	6YOu00OPg0srhdXWh3n40stowCeBMcffXsRcyspoPcOwDXCd2c9wfSSXCkDFfXFJ
	mTyT8H8HiLPmnebJbD4rxgJZi+QgdZatBErSGHINFNzjgFutuBCpkIDqUY917OFz
	uLuqGkBgPsjy+PZ+58P1NfeANyCHlLNIVbg1JUDIuOtYi8lTRxRVprabNjN2C9TF
	X/EmWbMewTm+nfmPheMKjylMztAZ/hADg+j5uAUJDeiwNzc1qiFhnJ7QXAIDWPIh
	o0Xb6IGmVfosW5gXRCFpQ==
X-ME-Sender: <xms:r2zFZ1S3W8MRdDFhUVfz-iAPDo1o8axVhbRymvs97kP6lrcWBCatYg>
    <xme:r2zFZ-yiKLaJxXbyNawAcEiywuLxJJYF-xijmFmmMTWeod1qCxXv4pVLOkgQ_DcUq
    BdrgdrmbaSIQcNDGg>
X-ME-Received: <xmr:r2zFZ62-neJpqtjlCSgG5GpViO13paLd6fLfN_ZCZ2ftOPY4DyHmdtoOaual03j3jJ8IfBg1saQFvhorEBRcLPnJ6bKtSYSjKgZfmOe4pcJH2l8T>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdelkeeikecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecunecujfgurhephfffuf
    ggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpefrrghtrhhitghkucfuthgv
    ihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpeffueeiud
    ejvdekheeuvdekfeffiedvueelteekudehjeetkeegvddugfdtgfeileenucevlhhushht
    vghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpd
    hnsggprhgtphhtthhopedupdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehgihht
    sehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:r2zFZ9AJ2Ugyl5oS9YPBOW21tGxcjWkjUULObLf1zkOVFqYrbIiwjw>
    <xmx:r2zFZ-jRPaukZaVdclu9Mo_fmNfpgezcJroU2Xz4r6vUhlvOuRUCXQ>
    <xmx:r2zFZxpsr6bjmcBaYPgr8j7T7o8s99mYsy_d5yaedcN_FoqYrOhD2A>
    <xmx:r2zFZ5j0ZTpk51jCe_X7Nj8YZU4qKUnGvn2wyqDXRduAw6RBvp7LLw>
    <xmx:r2zFZyZ_eecTAtilfNqzuu3aM-cIzUYwcyaon0ItymwNIKc1ZY48U5aq>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Mon, 3 Mar 2025 03:47:43 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 51938be6 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Mon, 3 Mar 2025 08:47:42 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Mon, 03 Mar 2025 09:47:38 +0100
Subject: [PATCH 09/12] delta-islands: stop depending on `the_repository`
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250303-b4-pks-objects-without-the-repository-v1-9-c5dd43f2476e@pks.im>
References: <20250303-b4-pks-objects-without-the-repository-v1-0-c5dd43f2476e@pks.im>
In-Reply-To: <20250303-b4-pks-objects-without-the-repository-v1-0-c5dd43f2476e@pks.im>
To: git@vger.kernel.org
Cc: 
X-Mailer: b4 0.14.2

There are multiple sites in "delta-islands.c" where we use the
global `the_repository` variable, either explicitly or implicitly by
using `the_hash_algo`.

Refactor the code to stop using `the_repository`. In most cases this is
trivial because we already had a repository availabe in the calling
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
2.49.0.rc0.375.gae4b89d849.dirty

