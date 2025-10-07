Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CE872DFF0D
	for <git@vger.kernel.org>; Tue,  7 Oct 2025 12:41:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759840892; cv=none; b=o7nBPJ+qdgD9wnl4HN6rOlqht5W5iyViTbc8VwNSoJZ7ykhQ5SF1bcka65YueAkYjhuzBjw9eToDWlVT6JeHbfaGeF4b0xT8gfHuiVE6WHIUpZffIe2Qh+rlo5oxqSzRVgNB4mcglJt4Ywf7wArhSt2sKBjLgmNrchINOWunuCs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759840892; c=relaxed/simple;
	bh=JFibFpD2mbw4QITtTKfpkprmCMGVV+LKFwbiq7GDO7I=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=b+r/uo8e5XZ1C6ro7T14uj+PzD+IwfxsHHkNKWTISl3aH2Y0gB1DyiaHuskxRrDsjgBeyZru9KZCWlMYIM5ZfX3NEnysSZiP+Dj0lD+sTM8jncKSSwu2Ytm8rnK4SBT/DU3KBISkOWDBLwIcZBkzr2zcwGw6iMNpdNx9ncpZzyQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=QdMkw3KE; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=x51hQU/5; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="QdMkw3KE";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="x51hQU/5"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.phl.internal (Postfix) with ESMTP id 56E77EC003D;
	Tue,  7 Oct 2025 08:41:30 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Tue, 07 Oct 2025 08:41:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1759840890;
	 x=1759927290; bh=E5I97HohJMIbUSXemQ35lAqvKb4ShNH+0R4zuNcI06I=; b=
	QdMkw3KEp6yV2iWWY8V8i4Y2m9uTAsIfe2qOk6kc5/0XKaPO+WKWEdy1aMsuy0mp
	DOyOpkszXjoYw4YTlfuOrAei4/sB0w2ye5/y84l9sAKlmf4U92wdoGoFoggclXd1
	GNDX6paIOo0AQ+tdYyBMy+qsYqXPfbmMuKhX4eXMpL6DZIbT5zvgFZsoNIadR12z
	eFFA+jwQOr3ffjPwg8J9nCDtjPuuCYWLZ/iHxX5FGQfSRodCYMu6CQtNJC3ScMZv
	rHYRh+4LoGLjVczG2Hpr/figp/6JRt62+Z7UY3bhF5L/xYnU815IFVJ73NkkHpjP
	AvpvQDYrj4z1DFHO/ZywXA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1759840890; x=
	1759927290; bh=E5I97HohJMIbUSXemQ35lAqvKb4ShNH+0R4zuNcI06I=; b=x
	51hQU/5uowqmQSbHxCgYlyVSk7Fo2kTZLipbGDm8O5vkBAMp6u0uheUZDt28s5qv
	N+F4bPQgIGdwypD9S391gmRKo86xUuy04YtKHawzqWGOEtUzsHXFxFw/xkSPB1V5
	vorkS7aLcEPzMtaEm1dxjslcX04LxJ70hBN7pkGPmLlRgatKq9PaGI63Jl87O6PF
	dqb2tcavVJN+Nlhv5xwiFer5A7CJeqIDdneb08c4hfXarMk7MTMDf2qQhpxKNbdj
	uReZp2nXcQxU6HiF2DoTsjYYs6mu1UbhTBDilBpHPYyc2dhl7BTUjHb/UIEWIhnA
	IJfU9HYZAkFGSpdtmipSQ==
X-ME-Sender: <xms:egrlaBKEj6z_DqfbFZODg5lUyff0I3dI4-0xz_zhY54ASvUporGL2w>
    <xme:egrlaDIH756Yv81ACMxWV0F7_OcVH6YWgAKofqobyz-T_1Cos3SgwEIuHloW1KOFT
    QGutzu_J6iJnuQg85uW-Uqe7Xc25yzDRXhrr5KkDj2mxQBGwefJ>
X-ME-Received: <xmr:egrlaHXynZ6sYnlBIN3hQ3QC7W12B7x-l1tBbnGeQxfMdFIZSosr2WLiMeskw4-7yIoJ--O3vJV3_jSbqIKUjBFig11MW_Ue5DRUjsHpPG4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddutddtgeegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhfffugggtgffkfhgjvfevofesthejre
    dtredtjeenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehp
    khhsrdhimheqnecuggftrfgrthhtvghrnhepffeuiedujedvkeehuedvkeefffeivdeule
    etkeduheejteekgedvudfgtdfgieelnecuvehluhhsthgvrhfuihiivgeptdenucfrrghr
    rghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepvddpmh
    houggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdr
    ohhrghdprhgtphhtthhopehmvgesthhtrgihlhhorhhrrdgtohhm
X-ME-Proxy: <xmx:egrlaNiiy5LrDKJZW3GSd0uxEWfUv9GeBEqea0kU76kKHfe1ucM0OA>
    <xmx:egrlaK_j6M2Uu_uJumsGW4tKTEl0wRyTWZN2GEVvFWb4vGmF797fxA>
    <xmx:egrlaPAWpC1XiCJx5cE77ONemtv-QuCOuTEyDCfxMezdnvmRCBH8oQ>
    <xmx:egrlaPIWTvyyCs1c9qYrgtzuYcRWv4VqZ44ndTUEiNoPR-rEPQL1iw>
    <xmx:egrlaCSADHUYNA8z50mg0io1rFR8b3OSfy7jyVoGKQkaCTswdBtW6yue>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 7 Oct 2025 08:41:29 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 1b73761f (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Tue, 7 Oct 2025 12:41:29 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Tue, 07 Oct 2025 14:41:12 +0200
Subject: [PATCH 6/6] packfile: rename `packfile_store_get_all_packs()`
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251007-pks-packfiles-convert-get-all-v1-6-428227657a89@pks.im>
References: <20251007-pks-packfiles-convert-get-all-v1-0-428227657a89@pks.im>
In-Reply-To: <20251007-pks-packfiles-convert-get-all-v1-0-428227657a89@pks.im>
To: git@vger.kernel.org
Cc: Taylor Blau <me@ttaylorr.com>
X-Mailer: b4 0.14.3

In a preceding commit we have removed `packfile_store_get_packs()`. With
this function removed it's somewhat useless to still have the "all"
infix in `packfile_store_get_all_packs()`. Rename the latter to drop
that infix.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/fast-import.c  | 4 ++--
 builtin/pack-objects.c | 4 ++--
 packfile.c             | 2 +-
 packfile.h             | 4 ++--
 4 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/builtin/fast-import.c b/builtin/fast-import.c
index b1d5549815..fea914cf9e 100644
--- a/builtin/fast-import.c
+++ b/builtin/fast-import.c
@@ -976,7 +976,7 @@ static int store_object(
 	if (e->idx.offset) {
 		duplicate_count_by_type[type]++;
 		return 1;
-	} else if (find_oid_pack(&oid, packfile_store_get_all_packs(packs))) {
+	} else if (find_oid_pack(&oid, packfile_store_get_packs(packs))) {
 		e->type = type;
 		e->pack_id = MAX_PACK_ID;
 		e->idx.offset = 1; /* just not zero! */
@@ -1177,7 +1177,7 @@ static void stream_blob(uintmax_t len, struct object_id *oidout, uintmax_t mark)
 		duplicate_count_by_type[OBJ_BLOB]++;
 		truncate_pack(&checkpoint);
 
-	} else if (find_oid_pack(&oid, packfile_store_get_all_packs(packs))) {
+	} else if (find_oid_pack(&oid, packfile_store_get_packs(packs))) {
 		e->type = OBJ_BLOB;
 		e->pack_id = MAX_PACK_ID;
 		e->idx.offset = 1; /* just not zero! */
diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index 65fb70f806..821598c261 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -4398,7 +4398,7 @@ static int has_sha1_pack_kept_or_nonlocal(const struct object_id *oid)
 	struct packed_git *p;
 
 	p = (last_found != (void *)1) ? last_found :
-					packfile_store_get_all_packs(packs);
+					packfile_store_get_packs(packs);
 
 	while (p) {
 		if ((!p->pack_local || p->pack_keep ||
@@ -4408,7 +4408,7 @@ static int has_sha1_pack_kept_or_nonlocal(const struct object_id *oid)
 			return 1;
 		}
 		if (p == last_found)
-			p = packfile_store_get_all_packs(packs);
+			p = packfile_store_get_packs(packs);
 		else
 			p = p->next;
 		if (p == last_found)
diff --git a/packfile.c b/packfile.c
index 00abb058db..45a75c0307 100644
--- a/packfile.c
+++ b/packfile.c
@@ -1027,7 +1027,7 @@ void packfile_store_reprepare(struct packfile_store *store)
 	packfile_store_prepare(store);
 }
 
-struct packed_git *packfile_store_get_all_packs(struct packfile_store *store)
+struct packed_git *packfile_store_get_packs(struct packfile_store *store)
 {
 	packfile_store_prepare(store);
 
diff --git a/packfile.h b/packfile.h
index b80f79c9aa..a8f96b1459 100644
--- a/packfile.h
+++ b/packfile.h
@@ -140,13 +140,13 @@ void packfile_store_add_pack(struct packfile_store *store,
  * Load and iterate through all packs of the given packfile store.
  */
 #define packfile_store_for_each_pack(store, p) \
-	for (p = packfile_store_get_all_packs(store); p; p = p->next)
+	for (p = packfile_store_get_packs(store); p; p = p->next)
 
 /*
  * Get all packs managed by the given store, including packfiles that are
  * referenced by multi-pack indices.
  */
-struct packed_git *packfile_store_get_all_packs(struct packfile_store *store);
+struct packed_git *packfile_store_get_packs(struct packfile_store *store);
 
 /*
  * Get all packs in most-recently-used order.

-- 
2.51.0.764.g787ff6f08a.dirty

