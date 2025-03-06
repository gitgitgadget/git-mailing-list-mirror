Received: from fout-b4-smtp.messagingengine.com (fout-b4-smtp.messagingengine.com [202.12.124.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE0AA20F097
	for <git@vger.kernel.org>; Thu,  6 Mar 2025 15:10:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741273845; cv=none; b=EI8fRPY89VQTfpfoUDNqs/9QRtfINU4G7MWx+qgdHOclZdjNEg7B8tCdkl1R0Y86l4pzSiGSW7ZVTxOpf/PzJcddOe9awv6TdePAYKLJYSdIcC3y2C1BvLFOTHRRXGHzJ71sL8qzwuwXNTv3STflg6EhvmvQ5n7sNvyF38VY6rA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741273845; c=relaxed/simple;
	bh=3of8JUEkVRK33IyblDiNmkGLwGM9MBgXEwNmmmTpu0Q=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=fRrTY9ZbBALVHJLwf4OftxUu4iZ1ditNrq2WMPnA+lcM95BDHCKnpYaj4ed/AJEbfhvm5Nx/hYimVCBxvSYnfdGCQ67gOqpSNjzASyGaRun1Dp9Qh/zeGj+ikmDb+TfdhEXbqTjqs64xm2aCTc+6J9G/QXwEhw0NbGmLEZvsJ7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=GpFv/r+x; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=L2KP3kue; arc=none smtp.client-ip=202.12.124.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="GpFv/r+x";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="L2KP3kue"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfout.stl.internal (Postfix) with ESMTP id DE55E11401E1;
	Thu,  6 Mar 2025 10:10:42 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Thu, 06 Mar 2025 10:10:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1741273842;
	 x=1741360242; bh=M5vZy8QhSY6wcgKsq518HPXhodFYeHABPkwGp1i7ckc=; b=
	GpFv/r+xDeAdD8Pphm6pOsIVV3YDAcXTGxkeZI9c7EZHO5bQEIwAlg25dyKLhbUN
	uINp6ToSvFEIltqckejXBCoU2ghXHuKX7oQQOjgpf2lsYm8wTq3I9Vj0eWPsavbh
	KxacKVhfqVelQhRc6ARs0l1DEjgkTdHJ8F1HfMnuYRlb4UZm5T5CUFcMmS7dQ4UC
	bcRlDgTU+0A6VYJbn2FaO5kz0+SgRO2+mZyRSnhPfcvibc6NdZx1YJnnA2HxGlf6
	MzHnveWFyoHKJLCfNUOrj6yqwoIQfzQhcfc/smU5F7TAOxSVyufqEeYrQno7UKo+
	PuDEnELXYmJxi6HN9CTTfA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1741273842; x=
	1741360242; bh=M5vZy8QhSY6wcgKsq518HPXhodFYeHABPkwGp1i7ckc=; b=L
	2KP3kue0itVSH2p++qZDkdQhcBCC2qp4iRdgjwY3Fz/eEXK6Hqn4yWlzLAxUTMlY
	J+4ptblTCi+8XvEATbaibDSHDHSLziu/dWyC6JIO3KeaCuI9dBfovMa9QDPkYV0B
	/NurvTSyzl8KJwvClU8Bc5+vyzzAgVYxntj4r1e5rxc8P915bdmyxQYfhWUsBvY/
	8VbG3UgB936pc2bgW+lCSUr95cwz1WMcWuseAWoeMt8oOWEA4ndpO9wQ/h4xMLKF
	o2VH6bDA/ddur81GZkiCIBry6b/M4KgfkCmkasii5+WHQNKsi6jDmiwJ6sP77UB6
	HxEi+5iGm60FHqvtq9aXg==
X-ME-Sender: <xms:8rrJZ_-PwLKLExzOxAKnBsEVm8_kPKfXofnR1VqeDfbokmZzQeOwww>
    <xme:8rrJZ7uFZka2_bJvZIbC08TLLJ6uzI5rrdk9jTlO60bAfROB5kjdNf-INWyO07G3e
    zDDgGhx9pgqc-Wkew>
X-ME-Received: <xmr:8rrJZ9BKkX_o_4cBjH0ux275IlgM-BQjCJzslztZcmfEPF5tEnRPnMkUAezhBgW7VKIx6xXVQMuObP6YM__2JhfQwfnB4zceH_ZFbskmfk0nkg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddutdektdelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertder
    tdejnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhksh
    drihhmqeenucggtffrrghtthgvrhhnpeffueeiudejvdekheeuvdekfeffiedvueelteek
    udehjeetkeegvddugfdtgfeileenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeefpdhmohgu
    vgepshhmthhpohhuthdprhgtphhtthhopehjlhhtohgslhgvrhesghhmrghilhdrtghomh
    dprhgtphhtthhopehkrghrthhhihhkrddukeeksehgmhgrihhlrdgtohhmpdhrtghpthht
    ohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:8rrJZ7cmt3YbGb359ukCNzOg2KXLyFDtIqKZKlgNLZl7hXF8Ub8eBg>
    <xmx:8rrJZ0Oqu7cggQCtYmL-K_dmKlsPwg-A4E3oU9XWfjUMwfqYCeDcWA>
    <xmx:8rrJZ9lMimb6L6aUR4o4RtB0orpTf_B4LlbbZtXztoZSmXaj-cml_g>
    <xmx:8rrJZ-s_l2KWRlQguwYyORmbN0RC7L5wACHAHAdqPTWSNT_2l7JnwA>
    <xmx:8rrJZ5oUlOVAHXYaTGibQt_fhKRd4CTKRu5UhUSc_0ZuAeYcUkwu3zDV>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 6 Mar 2025 10:10:41 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id e1d9bb1d (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 6 Mar 2025 15:10:37 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Thu, 06 Mar 2025 16:10:33 +0100
Subject: [PATCH v2 09/12] delta-islands: stop depending on `the_repository`
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250306-b4-pks-objects-without-the-repository-v2-9-f3465327be69@pks.im>
References: <20250306-b4-pks-objects-without-the-repository-v2-0-f3465327be69@pks.im>
In-Reply-To: <20250306-b4-pks-objects-without-the-repository-v2-0-f3465327be69@pks.im>
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
2.49.0.rc0.416.g627208d89d.dirty

