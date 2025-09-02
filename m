Received: from fout-a7-smtp.messagingengine.com (fout-a7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8E692F60C7
	for <git@vger.kernel.org>; Tue,  2 Sep 2025 10:49:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756810150; cv=none; b=HKWLi/nn71q8HA1Hwu6U/KSCAclYaPAYMX/fljGPBTwi2z3MqAMcqxtFPrK3QuQlFNlnARacdfZ0bX3pu2Y1Dp3lLPgl4n/TJdbg7zIxKN3sQNGoojQVrBFTaNPPgzbWwEihrJJtwbJIryan8IopAShyGEBRKaKBiwYiMclaWDA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756810150; c=relaxed/simple;
	bh=8AT/ALqFxoNQy9tmuw/NS0XcIVEpNQjxcVeZofsWPQ8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=GEgA+poJHEBwPT4WZeoicDM4hm9dmT7aI66o0ZjbCIV0Z+0t4lvx2qdDzhYR7keszfO/wBoy6ZMbqnFUy9t+4uggfJh4eSt1kf6atuu1/Fsb+sJQEUAojPZnCcYh9GRneQ7vLd+ewCfpO2Fu0J6olCIikkPeGD4hXGgfrGe/8NE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Zq37XgrU; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=TaG1aVqZ; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Zq37XgrU";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="TaG1aVqZ"
Received: from phl-compute-11.internal (phl-compute-11.internal [10.202.2.51])
	by mailfout.phl.internal (Postfix) with ESMTP id 1CCCBEC047F;
	Tue,  2 Sep 2025 06:49:08 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-11.internal (MEProxy); Tue, 02 Sep 2025 06:49:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1756810148;
	 x=1756896548; bh=7IEDOT4W/7WfHU//lFGMbFI5nxg28nwhxh/1F/EFl5I=; b=
	Zq37XgrUVEhH22M+BvVrnPEmsDIkUMzkzSe+eNvuqC8JVkue0PpugRefOWhRb7zT
	njVgYmkDv3abgGfP8KSWPrIAhjNXDYi5S68yPQRvrE7wFbql1pkWVRtEhSG1+Oju
	JHXhEGFcFCyMBSSywqEw3ArMiycYoorgtxVqLGgm4sxDimAcVWZlMWdo43bL1zyA
	mL+p4hikhAuvNUrh7obr5OQqtB6g9VyUvbrdOouUoWo8lOcFVzafimagIYfI3aUw
	kHQcVnX0ZCW6J4ERbLvF4IZFO582WycFK8eo0QEC7LlKc1fOtDPvMPu297N87ogQ
	adbQo0BnCumEDB/huDyOsw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1756810148; x=
	1756896548; bh=7IEDOT4W/7WfHU//lFGMbFI5nxg28nwhxh/1F/EFl5I=; b=T
	aG1aVqZ3c6uTRvKCI/xUSA96OJ/yRT2EVZMya+iLL9KPj2umcy5kPyNlC1OkSE2T
	O80Mi8Q4RdeyPDk8gxTiY73mV9Jlt5rp81WAOFtkLotxbmmghD2hC3XuSaHBS9l2
	eW+oknC7AcgjGDbPaGildZFZD8DEhAMzbSpwLgMhTlXtdcmJh8tcssbimNlsLYQT
	J4ZKBRV6K/07fJmPU+A5BZO3DSaxIhQ3qLbwU+wZysIbqyYI44j6D1v7RKR9iGcb
	4smD2rZKH4HVL9bKq/EiEUCUKwfBld4I5qKygvFLYji7hxhN3fHKM5asASVOU1nE
	y9I2xN9ex29SZbWgbPSKQ==
X-ME-Sender: <xms:o8u2aI9OWcUYECxyxrjxAzFXEt_DLa1v3vArKvrlkQxUyEtmMSXLTw>
    <xme:o8u2aMN_gVSOqo3VLKMSVW314VUjxYSNzINZrJFYJ-Jshr80_j5NEsjW5BhD0Mtu0
    0PqxPoUknGvrYvN9g>
X-ME-Received: <xmr:o8u2aEfCUbsr5kk6gJTC7KrfdpEczlpaXughiiP7l8zvYW1rlIiJ2Q5FPhYTcM6zL-3xzphVBwZBLqndPaY7uCp4hQhxhsCI8Wuqvx5FeBrlOA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddtjecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegrihhl
    ohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpe
    fhfffugggtgffkfhgjvfevofesthejredtredtjeenucfhrhhomheprfgrthhrihgtkhcu
    ufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnhepff
    euiedujedvkeehuedvkeefffeivdeuleetkeduheejteekgedvudfgtdfgieelnecuvehl
    uhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrd
    himhdpnhgspghrtghpthhtohephedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohep
    mhgvsehtthgrhihlohhrrhdrtghomhdprhgtphhtthhopehkrghrthhhihhkrddukeekse
    hgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhr
    ghdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhmpdhrtghpthhtohepph
    gvfhhfsehpvghffhdrnhgvth
X-ME-Proxy: <xmx:o8u2aDU_5RbuyexA8yopCa4PI2m_gs7bsCM8R4T4bg7lcqlYMVf0CA>
    <xmx:o8u2aEjhPfUtrkJ8KDit1HYtwN-mClppjDc4xRB6x_48nzcg7VdnMA>
    <xmx:o8u2aK_jWHh3MAefG-dNKQaHvXzHay3j7jBb47PeJCv1M-yV2IhdHQ>
    <xmx:o8u2aOZsLbnJmYkQrXjbq8ccYzBwAe6WJ1nU628vi7pmnA8JXS88bg>
    <xmx:pMu2aGh73WW1navHXU7OACeN4quBFMytYIhWPv-5U15E4pDYzwC5kZVp>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 2 Sep 2025 06:49:06 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id c8057c29 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Tue, 2 Sep 2025 10:49:06 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Tue, 02 Sep 2025 12:48:33 +0200
Subject: [PATCH v3 08/15] packfile: refactor `prepare_packed_git()` to work
 on packfile store
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250902-b4-pks-packfiles-store-v3-8-6925278efeda@pks.im>
References: <20250902-b4-pks-packfiles-store-v3-0-6925278efeda@pks.im>
In-Reply-To: <20250902-b4-pks-packfiles-store-v3-0-6925278efeda@pks.im>
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
index 771b58df8b..4564026658 100644
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
2.51.0.384.g4c02a37b29.dirty

