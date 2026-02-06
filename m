Received: from fhigh-b5-smtp.messagingengine.com (fhigh-b5-smtp.messagingengine.com [202.12.124.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E5DC3451C1
	for <git@vger.kernel.org>; Fri,  6 Feb 2026 07:50:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770364207; cv=none; b=TUmGwKj6me8riBEZHXZoMmXuqvIM93TOCee/oIhyOg+cHGN13h/JgL46mT2RcF7ic3QxAiVHCjSiKh/PCXD1ugOMhfO2aYedQMxVr6NXSznm20zhqO3Ur+V+2ES3DstuxYmT9ojInGiJC7G11y53a4xcyiBstGTRPwvnyUYYypA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770364207; c=relaxed/simple;
	bh=G2OYXtDs2wOcWaOUtBusA/Vl9H6odcx+Iutk4tlnRbw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=DpaajHVPmhoOH0R5j3OEGxYmEBxz4Nuxj7jaBmIpaRj8CsEDhDOgoLWj627lahYnEH8C6SehnCn+2W7+5118tvslD1A/gfTcUOmqDU0d064+hq1B8ba3B9aPtb8qHIxGIAhrihncSRZsXNZOSnFwxT5ayZ5bTO1KpnxBb5O9A+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=nWYh+Jwu; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=FcMvmqe0; arc=none smtp.client-ip=202.12.124.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="nWYh+Jwu";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="FcMvmqe0"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 7A3437A015B;
	Fri,  6 Feb 2026 02:50:06 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Fri, 06 Feb 2026 02:50:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1770364206;
	 x=1770450606; bh=sUoeCX+d4QfdhODUgjgbsC1l10XSJW6WUruicOxMeHo=; b=
	nWYh+JwuhJ/xk/YOAAixeN9AP/Q0Z1/BwsQTRFF52hIfHqcBC5zvP1wAiYcjgiKe
	J5DDl+nvbRkjDi03ge3uA2zqdFJg/see9VnCUUBFiHRxDfw+efar8czmkp6ysAxj
	Sfl34ruG/F/HRuZmjEJtcxZZC4AE+Zxl/crt2Fga4a7+nKWA2lJz7IKUHawA5Q04
	/MDIlxochUxcNzwjha4XosgRh/54htXEK1/rtPtrx2nsdFJ6p9nn9YQ7FCN+gNzb
	T8qD1qUqc7GXHLL1Not1OFQo+SVzapi5VJTHN0twTfy/0PqRKnrtoFPxJ8isqPj2
	W7z3QdgTuPiXSp+bfhqKbw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1770364206; x=
	1770450606; bh=sUoeCX+d4QfdhODUgjgbsC1l10XSJW6WUruicOxMeHo=; b=F
	cMvmqe0HKNCT9lkspNciEArDbWK+Knd5z64PWqBZPKYaoxbgp1MF0WYwcddMzJ1m
	c3ELCoYzlI7OAFGhj19PvEktgP6uvuWM/+l9/h3fcbfS8S101o3aIJM/u9VIZOCR
	JNF8k/3hSWxO3/0wlhqOaXZOKIwwgY1H6ufHlYINJWTU3FJ/B2gTQz/IOOgGs2Et
	ZF/ebMc9K6HkhTEO1Dh/duVmbM9Togl+Who/qKpFclLapYv7Q/AHddIoLIq4T3P6
	gfWXD0q+NE5leW6sukWcQH8ndx3hzYiW+W3ZeYDdYk2L+VBucm9Oe+DsWYUlHT3P
	vXaOuNoT9+zCimN4uRvPg==
X-ME-Sender: <xms:Lp2FafgbtIABmp4yxzUEOXWdTm17uikNYf9dk97BJW-b0aOvVVu16A>
    <xme:Lp2FaTB5n9kBcLutDe4xO4FID8SYuttHwYJ-nbP7TqkYqPeSFESgkAo9VP4bbFMCn
    Qdgx4QyCQrrHMFziZSm_1FYmUAqrg08DYmy201yvkoY_KdxndiK5w>
X-ME-Received: <xmr:Lp2FaUHH8bVe4rSuonI0t0tuPj32jX3ZZEr4htTGVolGdu5AWoRDXQkrZVtbR7uFOv3hnfTN-5cM7H6iIX-ZJ-LFhtLDLqziwpnLqdBkwgs>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddukeejieduucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhfffugggtgffkfhgjvfevofesthejre
    dtredtjeenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehp
    khhsrdhimheqnecuggftrfgrthhtvghrnhepffeuiedujedvkeehuedvkeefffeivdeule
    etkeduheejteekgedvudfgtdfgieelnecuvehluhhsthgvrhfuihiivgeptdenucfrrghr
    rghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepgedpmh
    houggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdr
    ohhrghdprhgtphhtthhopehmvgesthhtrgihlhhorhhrrdgtohhmpdhrtghpthhtohepgh
    hithhsthgvrhesphhosghogidrtghomhdprhgtphhtthhopehpvghffhesphgvfhhfrdhn
    vght
X-ME-Proxy: <xmx:Lp2FabJKApjT2Ol5gRj-XHO8Z7P1fvvorzLGWcQA-cEtw22lvy0cDg>
    <xmx:Lp2FaYnvbq1B9A1S4d1t-lNIc_sqa9GTPINHFY8PILZ-vBpuyzYihQ>
    <xmx:Lp2FaTRhU3JSPNzjh1WtLWPc4M_1LWvmpnr2XHkh1wWOKHsw8_HqCg>
    <xmx:Lp2FaaIusNLHjwZDJmDSObm9zwnmN2CeWmt14ewmnV-YNIWLvF_e8Q>
    <xmx:Lp2Fabko_RNA9AOKeUR2pAkJCtgMj03w6ADVCvEC491wMD_BSBT7bNod>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 6 Feb 2026 02:50:04 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id f1d39757 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 6 Feb 2026 07:50:04 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Fri, 06 Feb 2026 08:49:56 +0100
Subject: [PATCH v3 1/4] pack-bitmap: deduplicate logic to iterate over
 preferred bitmap tips
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260206-b4-pks-fix-for-each-ref-in-misuse-v3-1-1e050c3d6a50@pks.im>
References: <20260206-b4-pks-fix-for-each-ref-in-misuse-v3-0-1e050c3d6a50@pks.im>
In-Reply-To: <20260206-b4-pks-fix-for-each-ref-in-misuse-v3-0-1e050c3d6a50@pks.im>
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
2.53.0.239.g8d8fc8a987.dirty

