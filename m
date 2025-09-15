Received: from fout-a8-smtp.messagingengine.com (fout-a8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8803D2F546D
	for <git@vger.kernel.org>; Mon, 15 Sep 2025 08:54:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757926496; cv=none; b=f15iodRxT8AdgcZYX/ZS8JCTUxNvL7NnX2GQndEcV5tKFtSwb0tmC+Z9f2lp13q3uBRl83pxO/fYjvCPle60YXEqI5tyslzX6WQWZcMlLFobHccnq2dKzss5G17lA7QYnEe1W5MlVCAEFLEWorfxzrqHHUR9tcM+SlT0MOCUiHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757926496; c=relaxed/simple;
	bh=oKMEysE6YyoJo/OmzwhPEH0OelXwPH54xaM20lMM/F8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=WuvfDCg4bOTa4DQ+iPL0kTGrmoNu9rL6czTP7vupZWenK3BRW8YDk+CTCa6suvNU+eoyudpJS9QnrzK62pcFLDJJq97pJ9/R54tpCIPWTYW6251TVunKuJy2ndFYWdtvZnATyBxzDo+iYM/2uMWTby/wEiBxNpY0BGuOAJJYWF8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=pQkx1SrI; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=PxYlsSAw; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="pQkx1SrI";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="PxYlsSAw"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.phl.internal (Postfix) with ESMTP id BB879EC0252;
	Mon, 15 Sep 2025 04:54:53 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Mon, 15 Sep 2025 04:54:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1757926493;
	 x=1758012893; bh=RJauYYTPM9ajajAKmgFowWsp4wgy4MQaX9liHi1KK18=; b=
	pQkx1SrIpP3nbBLQucnUgUMPYtJ7AXYMthF8A4T1u1tElWNHapayCJL7TC1li9+N
	C9wjLd7E5bjZX2qaq5tpjVMDzmF9/Vd7JFrzeNtT6cIJ2tvN0kauYj1nSSjKxy66
	IdtvplSfZ+z3Wir9epZ62bN/ANr2OAQrMp8uGho5SiyKqgHg7tAnjU5O2Kb0bDUZ
	r1bRrjWiCXb2m+YC8MBOdj7oRYC9o9jano6JRnHr5XGAuDYED6CYeoRC/76ztaRt
	2H47YAtfpamJe5Ouh5hOrkRunAAi2axuKkATr9YwmQO8yGrfqEgWYxNdSuQiHJL+
	PQAy/gNZy0kMQrUObRCm5g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1757926493; x=
	1758012893; bh=RJauYYTPM9ajajAKmgFowWsp4wgy4MQaX9liHi1KK18=; b=P
	xYlsSAw0rBqt0Do/mKg7I2bwr6Ii0GpOHSsMzDIoUp1LtPw6KIh/8TFfv5yon8n+
	mXZyL74dWPHjq67CZMmLbl3WamP4GJiC/c+Okfr3gkzHV1FFcvlCIBezEHXIX6bG
	OzNfQ61WU56tU4hdmBkESWRjOaN0g7eGfxwi1Y+8eRY3thnwzUYij4aHE5ej4dwA
	THwGxbUml43XSmoU5iJ6qmdatHVSZcCmIfYqbmpFDoPZZqbipbDQe+PFL5OG4yRq
	0GBtxwvjs8xhzDoUEWnqfyjU1AIU36niwlggkpPZg17G80KDGk7+7hbdIhoqXQon
	x9tkQEYPfTVmTvcuQ0aFw==
X-ME-Sender: <xms:XdTHaBbh3yxYRb0YMQAfE-LdOGmW9u1F2Z935NWorrpzIOyTsq0Fpw>
    <xme:XdTHaD4t53ZcfI3j1TDCvupKS_KCfAD_VDF_XmNBg773r34kBELt-ZGP8yUwfhORd
    gy74A5iyRM1JiWq1Q>
X-ME-Received: <xmr:XdTHaKYh3VHp0rYddo_RQPLZ_8mZGpiZuxzXOK-UIYoyMUO0JVD2YO1fFPlk1QH5FjQkzJVGZctMcH2CYaKI4lJMyiY44gzm0lgDDW1cqqwxJQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdefjedviecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhfffugggtgffkfhgjvfevofesthejredtredtjeenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epffeuiedujedvkeehuedvkeefffeivdeuleetkeduheejteekgedvudfgtdfgieelnecu
    vehluhhsthgvrhfuihiivgepfeenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimhdpnhgspghrtghpthhtohephedpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepphgvfhhfsehpvghffhdrnhgvthdprhgtphhtthhopehkrghrthhhihhkrddukeekse
    hgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomhdp
    rhgtphhtthhopehmvgesthhtrgihlhhorhhrrdgtohhmpdhrtghpthhtohepghhithesvh
    hgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:XdTHaKg0gLVJtZrCxwnSWlPKguAxX1Ob0Wvt_XrxqvLyf6d9rUeN3w>
    <xmx:XdTHaD-1wbWIrssnxZJaIC1MFVs9_DYX7cauRmBpabKNeS78ThhgbA>
    <xmx:XdTHaNoNnnqgidxQHoRU9T2SxuImnASe3UHDDQ7C4Pre99NmeCbc6g>
    <xmx:XdTHaDUDJ_6LdTWTsoH6RdivCpvOKJX2_Hl8R2xSWU-XD0P35Ewebw>
    <xmx:XdTHaNvGp3heQnVZKfyIJ4TU5dzKSB54KCSlwVEEbsMvlB-hvmTb4kn4>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 15 Sep 2025 04:54:52 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 503b00f9 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Mon, 15 Sep 2025 08:54:52 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Mon, 15 Sep 2025 10:54:26 +0200
Subject: [PATCH v5 08/15] packfile: refactor `prepare_packed_git()` to work
 on packfile store
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250915-b4-pks-packfiles-store-v5-8-d6340350934f@pks.im>
References: <20250915-b4-pks-packfiles-store-v5-0-d6340350934f@pks.im>
In-Reply-To: <20250915-b4-pks-packfiles-store-v5-0-d6340350934f@pks.im>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>, Jeff King <peff@peff.net>, 
 Taylor Blau <me@ttaylorr.com>, Junio C Hamano <gitster@pobox.com>
X-Mailer: b4 0.14.2

The `prepare_packed_git()` function and its friends are responsible for
loading packfiles as well as the multi-pack index for a given object
database. Refactor these functions to accept a packfile store instead of
a repository to clarify their scope.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 packfile.c | 41 ++++++++++++++++++-----------------------
 1 file changed, 18 insertions(+), 23 deletions(-)

diff --git a/packfile.c b/packfile.c
index 5588a7ad6d..095c85919b 100644
--- a/packfile.c
+++ b/packfile.c
@@ -974,37 +974,32 @@ static int sort_pack(const struct packed_git *a, const struct packed_git *b)
 	return -1;
 }
 
-static void rearrange_packed_git(struct repository *r)
-{
-	sort_packs(&r->objects->packfiles->packs, sort_pack);
-}
-
-static void prepare_packed_git_mru(struct repository *r)
+static void packfile_store_prepare_mru(struct packfile_store *store)
 {
 	struct packed_git *p;
 
-	INIT_LIST_HEAD(&r->objects->packfiles->mru);
+	INIT_LIST_HEAD(&store->mru);
 
-	for (p = r->objects->packfiles->packs; p; p = p->next)
-		list_add_tail(&p->mru, &r->objects->packfiles->mru);
+	for (p = store->packs; p; p = p->next)
+		list_add_tail(&p->mru, &store->mru);
 }
 
-static void prepare_packed_git(struct repository *r)
+static void packfile_store_prepare(struct packfile_store *store)
 {
 	struct odb_source *source;
 
-	if (r->objects->packfiles->initialized)
+	if (store->initialized)
 		return;
 
-	odb_prepare_alternates(r->objects);
-	for (source = r->objects->sources; source; source = source->next) {
+	odb_prepare_alternates(store->odb);
+	for (source = store->odb->sources; source; source = source->next) {
 		prepare_multi_pack_index_one(source);
 		prepare_packed_git_one(source);
 	}
-	rearrange_packed_git(r);
+	sort_packs(&store->packs, sort_pack);
 
-	prepare_packed_git_mru(r);
-	r->objects->packfiles->initialized = true;
+	packfile_store_prepare_mru(store);
+	store->initialized = true;
 }
 
 void reprepare_packed_git(struct repository *r)
@@ -1027,25 +1022,25 @@ void reprepare_packed_git(struct repository *r)
 
 	r->objects->approximate_object_count_valid = 0;
 	r->objects->packfiles->initialized = false;
-	prepare_packed_git(r);
+	packfile_store_prepare(r->objects->packfiles);
 	obj_read_unlock();
 }
 
 struct packed_git *get_packed_git(struct repository *r)
 {
-	prepare_packed_git(r);
+	packfile_store_prepare(r->objects->packfiles);
 	return r->objects->packfiles->packs;
 }
 
 struct multi_pack_index *get_multi_pack_index(struct odb_source *source)
 {
-	prepare_packed_git(source->odb->repo);
+	packfile_store_prepare(source->odb->packfiles);
 	return source->midx;
 }
 
 struct packed_git *get_all_packs(struct repository *r)
 {
-	prepare_packed_git(r);
+	packfile_store_prepare(r->objects->packfiles);
 
 	for (struct odb_source *source = r->objects->sources; source; source = source->next) {
 		struct multi_pack_index *m = source->midx;
@@ -1060,7 +1055,7 @@ struct packed_git *get_all_packs(struct repository *r)
 
 struct list_head *get_packed_git_mru(struct repository *r)
 {
-	prepare_packed_git(r);
+	packfile_store_prepare(r->objects->packfiles);
 	return &r->objects->packfiles->mru;
 }
 
@@ -1078,7 +1073,7 @@ unsigned long repo_approximate_object_count(struct repository *r)
 		unsigned long count = 0;
 		struct packed_git *p;
 
-		prepare_packed_git(r);
+		packfile_store_prepare(r->objects->packfiles);
 
 		for (source = r->objects->sources; source; source = source->next) {
 			struct multi_pack_index *m = get_multi_pack_index(source);
@@ -2068,7 +2063,7 @@ int find_pack_entry(struct repository *r, const struct object_id *oid, struct pa
 {
 	struct list_head *pos;
 
-	prepare_packed_git(r);
+	packfile_store_prepare(r->objects->packfiles);
 
 	for (struct odb_source *source = r->objects->sources; source; source = source->next)
 		if (source->midx && fill_midx_entry(source->midx, oid, e))

-- 
2.51.0.450.g87641ccf93.dirty

