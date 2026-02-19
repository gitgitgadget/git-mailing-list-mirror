Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BF37334C1D
	for <git@vger.kernel.org>; Thu, 19 Feb 2026 07:58:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771487885; cv=none; b=ZrRjzjty7w9cwX1j6TFZnD5cY4X1kJMdegZ0JwCQ6ewplMxARq6M2oUv6uAKj+creTQbZhAr23PHAlfeCm3ibJpUavN0GiWPAOpt4i+jxY1EyJ0/a6tk3IOpRJlgQVrnEQLgIxZevu8HGvZqh807tkZn2r4jZ5cKeXIWhntS6Ms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771487885; c=relaxed/simple;
	bh=0DFE/UpYITOpgHDBUEYkmW5r67wCmsSZTQCbY0Mdjlc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=oQ+wLY0VEkL/OG6feAeC5ULeLPnEbsthFoCAayrJNFwX3M474vztE9f7O6eUD88hFkLj/iOV0cvbZlK+c+cHsoWPZG8iC73t0TexeSBaanx3M7vmx6c7idyvA6kRFAG3owOQC+ggC6DT91x7bGN0Yja1zcEJw3tlZEO8jStROvE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=qNoCPj+Q; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=S6TtCJXX; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="qNoCPj+Q";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="S6TtCJXX"
Received: from phl-compute-12.internal (phl-compute-12.internal [10.202.2.52])
	by mailfhigh.phl.internal (Postfix) with ESMTP id CE74E1400133;
	Thu, 19 Feb 2026 02:58:02 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-12.internal (MEProxy); Thu, 19 Feb 2026 02:58:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1771487882;
	 x=1771574282; bh=nLXjhLfqjNLCt+Y7SU0VXtuA+8gRJUhC5e7sqLdAGig=; b=
	qNoCPj+QNgR6d/Y7Ga2iBtd5ZB82uc20ArqTB+R14jkVyO1Jv2GCZ26gM0qVUkfg
	4N2655C/AYm1BAz61udbvyzaftt65p+4Sfmv8xFh+EvEXSzz4RUeI339PdGKU8LB
	R8A5tSkNvmLgJ9c5cjNsNxm9OHYalLnLUmUMdDCK3dVoNoswZIdqi8tqc/S698ul
	Lksmsq26Ftjs3YaQ+OezDj3AoHa3DHwMhrUvuG3hKmpR19NuurcJ6x0Yi5w/MBff
	f0eKxP82O3kEp26QIsNWY183Czkj/RB8LVUcVy9YCO3b2MLhX7tVaMMRqumyfANN
	aAss7nH4jjRgyQ/+i8j6EA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1771487882; x=
	1771574282; bh=nLXjhLfqjNLCt+Y7SU0VXtuA+8gRJUhC5e7sqLdAGig=; b=S
	6TtCJXX8WL23ZP+VyT5LyQpSnbLxhIxsU/TDQv06EEUELzKV2uLFKffn7a1B6W/4
	8y0KpQbceOum4nUQg/aGBipFPM3B/Y0CG2Xeqga8kNtED1ps+uFbksHDxf+0LP5E
	6qYC6DcocrXMFLpJZTU0YjjuwBwuk7DUi00ohK4dobOG26Hu3fkYA62DwdqsjW+E
	oQbNbW6QToJoA3m68uyNbbyBh6CId9e8Tf5fTIIRi1EnnzBHjUkxuMoA05dYo5zt
	jI8i9SbDxNh6WbLesW2ZkiJpo3jy1/E1zdLCus005M5/uiWv9B6tOn7wHmzs5TNv
	UBLs6EUHp1BRwRocVKCmA==
X-ME-Sender: <xms:isKWaSfvImK4kD_7bL3X8aqAz_QZ7Zfn851dPIu9JnPDPQ2WQ8PRjw>
    <xme:isKWaTOe39iObda9z22RLDt9BytYhzPVfzEnkD9E3KpobK3M2Qu3ExzJIK4HsUPVH
    2xM3ew0kt28yL-0ItetJBvKT6C5cxRbTxL15Se4E1kLKanBy72aW6Y>
X-ME-Received: <xmr:isKWaYg7Rr4UOc2tAPZSR5k6040EWe8jR5aytvpzeTF5siY45PSOG1eZS0S7tGECAw6usMRGfTG9NvUt9qu4BVTtk4GxvSMzirQEGSmJHg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvvdegleekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhfffugggtgffkfhgjvfevofesthejre
    dtredtjeenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehp
    khhsrdhimheqnecuggftrfgrthhtvghrnhepffeuiedujedvkeehuedvkeefffeivdeule
    etkeduheejteekgedvudfgtdfgieelnecuvehluhhsthgvrhfuihiivgeptdenucfrrghr
    rghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepgedpmh
    houggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtgho
    mhdprhgtphhtthhopehpvghffhesphgvfhhfrdhnvghtpdhrtghpthhtohepghhithesvh
    hgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehmvgesthhtrgihlhhorhhrrdgt
    ohhm
X-ME-Proxy: <xmx:isKWae2W48etJ-4ASlE5oPaUQW-2fnYj7QlZnh1Z30B6gWCDgVzhxw>
    <xmx:isKWaahmPevOSPPZ_kdCEXrv8s51RBIRrUwaZzJhZBFxMXGAS-lRvw>
    <xmx:isKWaWfz1fTzNjSH1HHR3B8_gqnjDNYYgAwfTXU_n5lquED8hS8DWQ>
    <xmx:isKWaVlAprRHtWj4DD-oCF0A2io6w9TTGxyB5Knm72w-C59SMFUxIQ>
    <xmx:isKWacAbLNgch2wFZ5RhcoPO7LlumWnjkwMUNPprdD9Cv5UbA3DmtCTX>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 19 Feb 2026 02:58:01 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id bbc936ee (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 19 Feb 2026 07:58:00 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Thu, 19 Feb 2026 08:57:49 +0100
Subject: [PATCH v4 1/4] pack-bitmap: deduplicate logic to iterate over
 preferred bitmap tips
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260219-b4-pks-fix-for-each-ref-in-misuse-v4-1-57ac30172fae@pks.im>
References: <20260219-b4-pks-fix-for-each-ref-in-misuse-v4-0-57ac30172fae@pks.im>
In-Reply-To: <20260219-b4-pks-fix-for-each-ref-in-misuse-v4-0-57ac30172fae@pks.im>
To: git@vger.kernel.org
Cc: Taylor Blau <me@ttaylorr.com>, Junio C Hamano <gitster@pobox.com>, 
 Jeff King <peff@peff.net>
X-Mailer: b4 0.14.3

We have two locations that iterate over the preferred bitmap tips as
configured by the user via "pack.preferBitmapTips". Both of these
callsites are subtly wrong: when the preferred bitmap tips contain an
exact refname match, then we will hit a `BUG()`.

Prepare for the fix by unifying the two callsites into a new
`for_each_preferred_bitmap_tip()` function.

This removes the last callsite of `bitmap_preferred_tips()` outside of
"pack-bitmap.c". As such, convert the function to be local to that file
only. Note that the function is still used by a second caller, so we
cannot just inline it.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/pack-objects.c | 19 ++-----------------
 pack-bitmap.c          | 18 +++++++++++++++++-
 pack-bitmap.h          |  9 ++++++++-
 repack-midx.c          | 14 +++-----------
 4 files changed, 30 insertions(+), 30 deletions(-)

diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index 5846b6a293..979470e402 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -4554,22 +4554,6 @@ static int mark_bitmap_preferred_tip(const struct reference *ref, void *data UNU
 	return 0;
 }
 
-static void mark_bitmap_preferred_tips(void)
-{
-	struct string_list_item *item;
-	const struct string_list *preferred_tips;
-
-	preferred_tips = bitmap_preferred_tips(the_repository);
-	if (!preferred_tips)
-		return;
-
-	for_each_string_list_item(item, preferred_tips) {
-		refs_for_each_ref_in(get_main_ref_store(the_repository),
-				     item->string, mark_bitmap_preferred_tip,
-				     NULL);
-	}
-}
-
 static inline int is_oid_uninteresting(struct repository *repo,
 				       struct object_id *oid)
 {
@@ -4710,7 +4694,8 @@ static void get_object_list(struct rev_info *revs, struct strvec *argv)
 		load_delta_islands(the_repository, progress);
 
 	if (write_bitmap_index)
-		mark_bitmap_preferred_tips();
+		for_each_preferred_bitmap_tip(the_repository, mark_bitmap_preferred_tip,
+					      NULL);
 
 	if (!fn_show_object)
 		fn_show_object = show_object;
diff --git a/pack-bitmap.c b/pack-bitmap.c
index 972203f12b..2f5cb34009 100644
--- a/pack-bitmap.c
+++ b/pack-bitmap.c
@@ -3314,7 +3314,7 @@ int bitmap_is_midx(struct bitmap_index *bitmap_git)
 	return !!bitmap_git->midx;
 }
 
-const struct string_list *bitmap_preferred_tips(struct repository *r)
+static const struct string_list *bitmap_preferred_tips(struct repository *r)
 {
 	const struct string_list *dest;
 
@@ -3323,6 +3323,22 @@ const struct string_list *bitmap_preferred_tips(struct repository *r)
 	return NULL;
 }
 
+void for_each_preferred_bitmap_tip(struct repository *repo,
+				   each_ref_fn cb, void *cb_data)
+{
+	struct string_list_item *item;
+	const struct string_list *preferred_tips;
+
+	preferred_tips = bitmap_preferred_tips(repo);
+	if (!preferred_tips)
+		return;
+
+	for_each_string_list_item(item, preferred_tips) {
+		refs_for_each_ref_in(get_main_ref_store(repo),
+				     item->string, cb, cb_data);
+	}
+}
+
 int bitmap_is_preferred_refname(struct repository *r, const char *refname)
 {
 	const struct string_list *preferred_tips = bitmap_preferred_tips(r);
diff --git a/pack-bitmap.h b/pack-bitmap.h
index 1bd7a791e2..d0611d0481 100644
--- a/pack-bitmap.h
+++ b/pack-bitmap.h
@@ -5,6 +5,7 @@
 #include "khash.h"
 #include "pack.h"
 #include "pack-objects.h"
+#include "refs.h"
 #include "string-list.h"
 
 struct commit;
@@ -99,6 +100,13 @@ int for_each_bitmapped_object(struct bitmap_index *bitmap_git,
 			      show_reachable_fn show_reach,
 			      void *payload);
 
+/*
+ * Iterate over all references that are configured as preferred bitmap tips via
+ * "pack.preferBitmapTips" and invoke the callback on each function.
+ */
+void for_each_preferred_bitmap_tip(struct repository *repo,
+				   each_ref_fn cb, void *cb_data);
+
 #define GIT_TEST_PACK_USE_BITMAP_BOUNDARY_TRAVERSAL \
 	"GIT_TEST_PACK_USE_BITMAP_BOUNDARY_TRAVERSAL"
 
@@ -182,7 +190,6 @@ char *pack_bitmap_filename(struct packed_git *p);
 
 int bitmap_is_midx(struct bitmap_index *bitmap_git);
 
-const struct string_list *bitmap_preferred_tips(struct repository *r);
 int bitmap_is_preferred_refname(struct repository *r, const char *refname);
 
 int verify_bitmap_files(struct repository *r);
diff --git a/repack-midx.c b/repack-midx.c
index 74bdfa3a6e..0682b80c42 100644
--- a/repack-midx.c
+++ b/repack-midx.c
@@ -40,7 +40,6 @@ static int midx_snapshot_ref_one(const struct reference *ref, void *_data)
 void midx_snapshot_refs(struct repository *repo, struct tempfile *f)
 {
 	struct midx_snapshot_ref_data data;
-	const struct string_list *preferred = bitmap_preferred_tips(repo);
 
 	data.repo = repo;
 	data.f = f;
@@ -51,16 +50,9 @@ void midx_snapshot_refs(struct repository *repo, struct tempfile *f)
 		 die(_("could not open tempfile %s for writing"),
 		     get_tempfile_path(f));
 
-	if (preferred) {
-		struct string_list_item *item;
-
-		data.preferred = 1;
-		for_each_string_list_item(item, preferred)
-			refs_for_each_ref_in(get_main_ref_store(repo),
-					     item->string,
-					     midx_snapshot_ref_one, &data);
-		data.preferred = 0;
-	}
+	data.preferred = 1;
+	for_each_preferred_bitmap_tip(repo, midx_snapshot_ref_one, &data);
+	data.preferred = 0;
 
 	refs_for_each_ref(get_main_ref_store(repo),
 			  midx_snapshot_ref_one, &data);

-- 
2.53.0.414.gf7e9f6c205.dirty

