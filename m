Received: from fout-a4-smtp.messagingengine.com (fout-a4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78886338F35
	for <git@vger.kernel.org>; Wed, 28 Jan 2026 08:49:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769590175; cv=none; b=G4TZ8hX2uppbG2RHsJyof4Ds+c5gIJL9TxVpMBUDIa+aFJzmz7ssFUWWPvyEDwG/T9NekPhesPsEb3gh9YvMaY8wzHrZMu8bltjyuDqG4WIrKfR26nmv7QoH68VG/vZzn3yiH+xBOLLfpu80V60EEqEPWM/pVy9S9YUUnh5K68A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769590175; c=relaxed/simple;
	bh=+N2DtG1iB54WltqchRXXR9AaLaA7LA1utml9njj3mYk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=LZ8sdPmWfmRL+HCIimQFmknswrNoiuanrUjIJdenGRYROjLcQ9CUZxib5S+RijY+dbZ7EcDUtED7HRBvRpBIHZbga7hDam+I8oLm2gGQVrZdM1kl400kjX/j/lQcLfkjEjX+7xJuerhnlNfanXZqLnrY/gctjT1sYJE+HgcgrtE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=VeOVIrZT; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=troZ9Pwh; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="VeOVIrZT";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="troZ9Pwh"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.phl.internal (Postfix) with ESMTP id 80305EC01A3;
	Wed, 28 Jan 2026 03:49:32 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Wed, 28 Jan 2026 03:49:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1769590172;
	 x=1769676572; bh=Q3YqJrtrvE471AlBodGvwozk06ZcfPbGfDXrrNS4SGs=; b=
	VeOVIrZTMNOOElc3SK5Ds9wFcPMMveGWcOoBiWHfYxZrU2HzwE93eMLfjW65aGnT
	LP75NYNq3T4QkCnbwbosO/aIdnzsTolcb/jTAUCUCQcWXmAaqsmvTggnEk4hb4J9
	0SWa1QY61VQ5JcPckur3wePVQ9WC49lwck4ZeAIHGBMuufX3RfJT9+WOzwt1barT
	p0uuVTMA9fgHfCz7Go5L9mYhVQJzFGWPLoaCQs4KtBSIus3qgzfeTTy376IpM0mH
	xaS/ou+9lYygnFnJWbaljNPF0+G7o73dw3vTxVjgDbvYYpSRJifJiS+UGraJcbj9
	O1BACeHTvQ5YDqP6nL6/TQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1769590172; x=
	1769676572; bh=Q3YqJrtrvE471AlBodGvwozk06ZcfPbGfDXrrNS4SGs=; b=t
	roZ9Pwh9FvLTXKSkUuvPBxIksvakPcZikKPK4wcLnBQDRHpgCNlEYmfv7tJG42pw
	MWM56I7feGmY+MVZFX8rkrmSjBcn7yvWNdLrWVBUBMCU9mUpSHeiFMBTheMNzVZR
	PldazTOh5OxZbDnaY8ydOs5XxlOKTmguVm85TeG6Bdbra/txOjRqKv5KP7gk82fW
	KL9BgbA6UlvyziSIRDN1exA+wD5EU/ypGcDrF2S6ZusO9e1/dIAFcvL25U77/iEK
	fhpuKfyogxilLCKWE8SBBntHa3nwlrk6OTyf3e5q4Yl9g6qma5wUitazc0gyEA+8
	yPz0E52GL1g4IdUCo7dNA==
X-ME-Sender: <xms:nM15aY_4sFM-bw05P55PkftRrYqVpV3Q9QKfAutbWpM1DOnbnEX2Uw>
    <xme:nM15aWvuEaBFjLnABGG1Rx5mFccqbFH1HLNO3Xc_gOLEczEh6KIEIeT9UcEzmroQk
    lWXvneL1xnLDfIGxBlK8JEu6H5LPCRmZhSsiLhksgVxUiyK9Jj5SQ>
X-ME-Received: <xmr:nM15abqbwwzhOwGa_IegXvQryyYG9l0n_Eh-AydHbETJSWcFlFqqmsnURVQay6XRCL3pkb8Y_y4JA5kSphtS3_ZYvStu7_MT-bgIImUweAw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdduiedvleefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhfffugggtgffkfhgjvfevofesthejre
    dtredtjeenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehp
    khhsrdhimheqnecuggftrfgrthhtvghrnhepffeuiedujedvkeehuedvkeefffeivdeule
    etkeduheejteekgedvudfgtdfgieelnecuvehluhhsthgvrhfuihiivgeptdenucfrrghr
    rghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepvddpmh
    houggvpehsmhhtphhouhhtpdhrtghpthhtohepmhgvsehtthgrhihlohhrrhdrtghomhdp
    rhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:nM15aTmzhDC-WPn9lXxMB4ps6oZvD_o5f2L3VtS5ek11LcY433oRqw>
    <xmx:nM15afwC2HGWWQUIOXdjHKEaybeW6V7GI11SyXKJJQqlEcczCcNjpw>
    <xmx:nM15abmYj3HCe4mUM_qwI3TZknRmh2a6JApNpVzFW_sZLZdC7sLXCQ>
    <xmx:nM15aYfvenHBC5Lcgwt7bsqtE905oSAt0GuFuzUHLkCcbxsptJhS5Q>
    <xmx:nM15adFLHV2O1jIcDSoP7ZMq9esz1yvtxn9QyrTNvC9K91YN2iFAYYxc>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 28 Jan 2026 03:49:31 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 15529aee (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 28 Jan 2026 08:49:30 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Wed, 28 Jan 2026 09:49:20 +0100
Subject: [PATCH 1/3] pack-bitmap: deduplicate logic to iterate over
 preferred bitmap tips
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260128-b4-pks-fix-for-each-ref-in-misuse-v1-1-deccae3ea725@pks.im>
References: <20260128-b4-pks-fix-for-each-ref-in-misuse-v1-0-deccae3ea725@pks.im>
In-Reply-To: <20260128-b4-pks-fix-for-each-ref-in-misuse-v1-0-deccae3ea725@pks.im>
To: git@vger.kernel.org
Cc: Taylor Blau <me@ttaylorr.com>
X-Mailer: b4 0.14.3

We have two locations that iterate over the preferred bitmap tips as
configured by the user via "pack.preferBitmapTips". Both of these
callsites are subtly wrong and can lead to a `BUG()`, which we'll fix in
a subsequent commit.

Prepare for this fix by unifying the two callsites into a new
`for_each_preferred_bitmap_tip()` function.

This removes the last callsite of `bitmap_preferred_tips()` outside of
"pack-bitmap.c". As such, convert the function to be local to that file
only.

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
2.53.0.rc2.206.g60c1bca835.dirty

