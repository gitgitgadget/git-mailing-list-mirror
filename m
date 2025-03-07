Received: from fout-b2-smtp.messagingengine.com (fout-b2-smtp.messagingengine.com [202.12.124.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EDEC21C17B
	for <git@vger.kernel.org>; Fri,  7 Mar 2025 14:19:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741357149; cv=none; b=nyxjI0Ti1NXhyNygX9rA3iJ229P22J8sgEYUSm1n4fDMnb5Bas2M8+0UGIs7Npz6+YTA8trK3Lsa7X1skcIrYjWpDzrc7rdHWrQTPbQYIoJP8qTsIoUBsl2/fmCLB9jxyqlaXDV5cLUNU1u6nDUALBtqm913n2BUdib++GPQjDQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741357149; c=relaxed/simple;
	bh=U0QcKtD2WdFY83c2bWUuqe2WkcIgzACZuaHt2DwwIGE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=jXA0k8nJPOG11cmNQj+OCOHc/vprODXSx1eK4Wk0k3EttXDCO609y1GmvCNJYQ1wgei9r3i3Hq5DRrt+Yh9gJ5eQMMwG1U0aN8cKLyJpa/zl0Y/ZrvTow5ZrCcY6uThkIlyL4oWMNg1hOpJpZvzHyktxnyC5Hx4vDmwboBz9VyI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=d8GUIrrq; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=jDkohkdX; arc=none smtp.client-ip=202.12.124.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="d8GUIrrq";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="jDkohkdX"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfout.stl.internal (Postfix) with ESMTP id 4219F1140148;
	Fri,  7 Mar 2025 09:19:07 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Fri, 07 Mar 2025 09:19:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1741357146;
	 x=1741443546; bh=j8wM8xxqHp3SL2yruZvF/i0o952TBSUUOCa513JA0WI=; b=
	d8GUIrrqnpatzQy/UuxjPKTK5m8kLul02Fl2PadY1g40Q5+XaXoaxY2PysXS/dAX
	QtpZEc2vFltrVvv+wAUzIOWzEp4Qb2abgVCNo4nqy285lk1VouRgWvIKxWm8JoJh
	Xu1lzvj0G8OhNieV1RL5rid0a3tWuyHDudQhMukhSGh68UrHMC00b2KrIV6FnEC6
	UWirdmDpy2Q/LEVVZ07wtC8OyxwIFO8IYvHOCW4qqq647kTttji8p9QztPN1srrj
	0Ucm1ZI5SrdWLXXfY//2lChtTEF0ZVbQBPeeQjKIL02V0DtT6+WDE9OpT4mJmMTV
	2mmdrbQo9PyLGjgTkbQDPQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1741357146; x=
	1741443546; bh=j8wM8xxqHp3SL2yruZvF/i0o952TBSUUOCa513JA0WI=; b=j
	DkohkdXKKALBvZSIwfLTGdbgpwg11MZ4yT00faB/U77njDOKYv6xvXD1p0Uf0ol2
	RdTKmJkEqwvWd3xhAN480BlG/7SiuQ5GwYKtn5xup7nIr0NbAbNHeYmmcXa42RyC
	uQ4ptIlW5jU2xml5Zy7y3dvKCMm6Jv0zGAyHte3CQG31NUiTolQ8PoI7eS0XGUIJ
	88n/IkzAjvwuWIimlnGHri+rZxfC6IxA6wLIQVLXiA32kILJxuQgnqSucPVZBJqE
	1nRlsz4rda7qCjPjK0pmBaTm1qUmtAaji8ESgmO+88YuEYUkoob/CCoeqRsFHMFG
	8zdfDBLs5SPpU8lV/Ck6w==
X-ME-Sender: <xms:WgDLZyHUB6IgBgQDAkF4nhWJ3-w9ZEGK5lNEqU5OdpqRq-DdCCppLw>
    <xme:WgDLZzUUTXp-9-qAhs8qXa52Z8CC1b2RccB3MuaVPnh2N8Yd8VTaq50FCRLJAzwcR
    j3LBHcT9jPD7tEciw>
X-ME-Received: <xmr:WgDLZ8KQNeH3NnypOPjx6Pnec0ISMgTJ-mwJaCwsO8uWJ6YQeGqWSK10oYtZvaA91HJ0eOw4cIijfq5qm_1aW27OeAUbo_AeFPx_Dcv-pCeC>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdduuddtkeelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertder
    tdejnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhksh
    drihhmqeenucggtffrrghtthgvrhhnpeffueeiudejvdekheeuvdekfeffiedvueelteek
    udehjeetkeegvddugfdtgfeileenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeefpdhmohgu
    vgepshhmthhpohhuthdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorh
    hgpdhrtghpthhtohepkhgrrhhthhhikhdrudekkeesghhmrghilhdrtghomhdprhgtphht
    thhopehjlhhtohgslhgvrhesghhmrghilhdrtghomh
X-ME-Proxy: <xmx:WgDLZ8FamPeG10FWgjGrhiyGtORZqHRvIop9jKzyQ6k_MC03pjLmag>
    <xmx:WgDLZ4XOl5HLsYMLgOIEYHpTEmQkSlLPLPsNpS56BYvBi4qzQK2oUg>
    <xmx:WgDLZ_MIsZrKc8aFWbg2vVoYHp4sbxcRALhpOGY74YmJ9N2mUS680A>
    <xmx:WgDLZ_2yDFh8_jLud4hMUvQKGHXlVYrhPyiu2BTCoFWTRmJXMajiWw>
    <xmx:WgDLZ_R5KAPk-T0fSiFrOh4NskbU-Aan8MiBm3-LBfS1qWv-jKXSKedY>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 7 Mar 2025 09:19:06 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id ee662f80 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 7 Mar 2025 14:19:05 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Fri, 07 Mar 2025 15:19:02 +0100
Subject: [PATCH v3 09/12] delta-islands: stop depending on `the_repository`
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250307-b4-pks-objects-without-the-repository-v3-9-7bccf408731e@pks.im>
References: <20250307-b4-pks-objects-without-the-repository-v3-0-7bccf408731e@pks.im>
In-Reply-To: <20250307-b4-pks-objects-without-the-repository-v3-0-7bccf408731e@pks.im>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>, 
 Justin Tobler <jltobler@gmail.com>
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

