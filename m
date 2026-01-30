Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AB482DB79E
	for <git@vger.kernel.org>; Fri, 30 Jan 2026 13:28:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769779688; cv=none; b=ScbzWYP/tfK1cugaiCL1Uf2lCvkmD1zgl9VSpcz/z3RDV9z0NvfXlBsYDpUPg4a1SF30MhbywDD1sneHWbbFwhlkx9pwmRH3Vkgtk3FA5nSs7Y7QxMEUslGp+ZRSE8QJ3gZW82xboPbZ4MlGcz8dp53DxQ2aEbxlRkKo+xmzAOI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769779688; c=relaxed/simple;
	bh=1I5ejJ4p8Ysv1EYJcXQaY5xwedwz+SSZKIhv90OGUHU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=V3wfBGzr12Paglg+7NZP2LBj4SzwRZc11y62pm4I8BQ3jvgW0aZgpnnlDzmnSbyW5hp4tvOL+NozHxuTbO/orrmM5hass/F4rRKkJAyjFlVqLqGVWrUAJHV3qg7M8RkLeAADUAEh2Z3al+ixei304UZEIMzdkslqyIUILK2yR1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=NTzs+bLY; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=AoW/m7UI; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="NTzs+bLY";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="AoW/m7UI"
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfout.phl.internal (Postfix) with ESMTP id 466E1EC0562;
	Fri, 30 Jan 2026 08:28:06 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-10.internal (MEProxy); Fri, 30 Jan 2026 08:28:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1769779686;
	 x=1769866086; bh=6rbh9q7f1+Th/KRi7BOKW6hhpNGNLjPNdGwNKJ6jtp8=; b=
	NTzs+bLYwYSheY1fObfF8noWT52RpkQcngTdTUnl1HqIkpggz1MlmlH7D6X2F0Hz
	HHyD+4QnZZIovJWT881fcLIliumllP7yKGhrBtXOvK2IQfkFgZYQv7F9B5XLVdgh
	v3itNCHYfjltuDfuqZDZeUsjM+3SN/09yEYaX9xG/DmkJ2vIrzzezwbrwsx38nE4
	aYj1Nc5O1k0gP9BEvWAvSX310MY1yk3rWV6QwahPqyeeHPJfeljLKxcMNdplIc8o
	DQ4q5oxxvwiisv4kueuwUnzJ2q0S4xnHFSdBMKJo3XvUkyMtlUelub+/RwaTA4nu
	frYyDsZ+v5QNqcJe6L6i5w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1769779686; x=
	1769866086; bh=6rbh9q7f1+Th/KRi7BOKW6hhpNGNLjPNdGwNKJ6jtp8=; b=A
	oW/m7UIHWbV83QDAjG5pQwiwVpCyfPH9BqJ2fpTXJOB019YVKS8gXe3hH7ZwU2X4
	4/xuNYTPYiPrOPPcqyvPPkT/Nxg9EmvLzSpotYAcWGhLol8/SVTjejWRdwxp2oyO
	7Y24SpdzXiGFp9vVZenb085ZEEUBZIuUPmWL8nb9Jr26/VbMVIdHc2chGfMwyVlv
	NjABPH9xF3XqxZsF56DK4lNaoWvREHCFwQV4fqxeSuFjwKvAqJCcGjUPCTXXkDY3
	4oN3mZXrZS/9M4HPY1BiveXsQUzsNELDp2Zuy/AcSF2AnFIAEhDhjGfJ7Wb3K05F
	Ec0sJG1BRoh3ok2P8fXNg==
X-ME-Sender: <xms:5rF8adqsuvNxsoaBSxhmrs29brY99YkJ4rGq5XpoYSp_CbSFYJsc4A>
    <xme:5rF8aVoUU7uYIFhGYUGhyk3fFq6CTrXZsMbgz6K7gy0ZvDHCfC961C2o48UUTIQLu
    QrD1eV8QnGjH_K21wrvt8I4axG39lbmttwc9hRZ-6PxHl18JzndSg>
X-ME-Received: <xmr:5rF8aX186WnE-FECxAfRUTIe5XnQZlQjUI17GCMAlpn2sAJqt5Qbb1dkaDxHvOQkpbjUc2X8fZTNNwpJpvYh0ylrKR_J3C6pgrzMCDugmw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdduieeludehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhfffugggtgffkfhgjvfevofesthejre
    dtredtjeenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehp
    khhsrdhimheqnecuggftrfgrthhtvghrnhepffeuiedujedvkeehuedvkeefffeivdeule
    etkeduheejteekgedvudfgtdfgieelnecuvehluhhsthgvrhfuihiivgeptdenucfrrghr
    rghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepvddpmh
    houggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdr
    ohhrghdprhgtphhtthhopehmvgesthhtrgihlhhorhhrrdgtohhm
X-ME-Proxy: <xmx:5rF8aUCYWC-0rq3Ff7D5blKncMiH9cjJhdVJObzTmLAN5HmAIN0C4w>
    <xmx:5rF8affQSIZx8t2yNmpQPq91Vae8bLsice4qEr9cfB4B406N_JhwpA>
    <xmx:5rF8aZjOCgyyfxggnL3pi4Q7HUhxdN8JgaIgNqO99pUs1AtBrxr0QQ>
    <xmx:5rF8aXo56_X3RAOTITtQxdyb3h5W5FAksmSiz3Wq-pswdZU6GsGKvg>
    <xmx:5rF8aWy05-c1fralrfYHegp43IchVn0kX7B-M0m4SMfeUqyERaJLazfM>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 30 Jan 2026 08:28:05 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id d433876c (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 30 Jan 2026 13:28:05 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Fri, 30 Jan 2026 14:27:42 +0100
Subject: [PATCH v2 1/4] pack-bitmap: deduplicate logic to iterate over
 preferred bitmap tips
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260130-b4-pks-fix-for-each-ref-in-misuse-v2-1-0449b198a681@pks.im>
References: <20260130-b4-pks-fix-for-each-ref-in-misuse-v2-0-0449b198a681@pks.im>
In-Reply-To: <20260130-b4-pks-fix-for-each-ref-in-misuse-v2-0-0449b198a681@pks.im>
To: git@vger.kernel.org
Cc: Taylor Blau <me@ttaylorr.com>
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
2.53.0.rc2.206.g60c1bca835.dirty

