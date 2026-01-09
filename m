Received: from fout-a4-smtp.messagingengine.com (fout-a4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FC5034AB1C
	for <git@vger.kernel.org>; Fri,  9 Jan 2026 08:33:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767947614; cv=none; b=q/aZiM7uNUpn/bppoapl8mPrqhtiqL/8iyRcFMArEjQ2xsfnrrr37Q9UAPGMA7/NXE3/Qxx8oZ4G/wFjVlrTYIHM8eqj2wA+xU+MZIl5s5b5n6xZJTg53uPKtumx9WASHZp8mYQUMS645zJ4yuhv43Dr2HEcNb/w7vO8Ylo+S+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767947614; c=relaxed/simple;
	bh=2SjrsXgSF06esbl9h7O8Oe/aoy1fXrOaucE9MWiXNTg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=IdDmSif81SvqwdY+bEX92hB2lHXSnSKgS6sTtJ2Ba1OX4ZtM0rla/nQsWUATFcyhwgmq64ekZadtG+vtdpkjNP8j+pKHq9eSpiK3T2dtknr8U2l3mh4tUzNwYFvU6apX8dkTBNTn2CV2usjxjDMGdaszaKxDGNFR9B1V53yI9F0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Kp8x4eZD; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=pA1IOyMZ; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Kp8x4eZD";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="pA1IOyMZ"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.phl.internal (Postfix) with ESMTP id 8351CEC00BE;
	Fri,  9 Jan 2026 03:33:32 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-03.internal (MEProxy); Fri, 09 Jan 2026 03:33:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1767947612;
	 x=1768034012; bh=WJOBnMdoV/b+iHUFQngd1CuPg9CNJHu0PZSYLmCb10g=; b=
	Kp8x4eZDZoeTzFVhPGWxdmjAgwhsIJ3TcgwWNUE7cg5s17qQy+RCiQPvjUqUuSv6
	va75Kjgb/vjw2c6/+dUts3tPnNjdIzTtBSz28IVFu280sQZlapWJxqbRsv0w3wLP
	3PuBgx/r4leLz16nw2aty815vG7dhQru6mUJoEjFxmuXzkSb5FGSqXjV3L3bbV2D
	UHbFkxyBGuypEgUIBED5qZq0Xm7MZTygme2BNwKUn3TNylpEz/lCewTeTLuIFyVj
	v+B2IzlxkKy6BypAh4YFuCIH3X6Nr7J9rJXe5zGb5b6C6hZ2ya40S76nlR94L4vT
	TQrav8V0zwfModerMhe0mQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1767947612; x=
	1768034012; bh=WJOBnMdoV/b+iHUFQngd1CuPg9CNJHu0PZSYLmCb10g=; b=p
	A1IOyMZS7lEri7xv/bax1CNiNtQKW1fK4TPlvjVgJ9NXH4E42qooW42SwuSsIoWj
	fpzEmtshxqvXllQJWe3XHz2+mlE7hAsyP656Mz/Ijwxgr2hx5/xHlofzPRACLmCQ
	kzpG22cU2cLIfUcEQRa3SgE2Pc8ulidfef5lBdJn3WF7Wu8I1KNP/hMSu1sbgLSw
	Z+k+SfUiDAlcFADRxTghdPl0vRicA/FDBNVKa2gsCUtNjoh+rTADGkILCDbCoe/B
	PbhkMmbWH1byHhQ026eYASxFwXECwDmv0aBJxmE9pC9tlLw3pGcPVYyFe1QJV2ON
	qYLCH8sATWlnH8SwSD7CA==
X-ME-Sender: <xms:XL1gaXhvFrwbOi6x06vC1NowYIf6TwL3Y6ZrAFzHx_w217VZwQJGZA>
    <xme:XL1gabAGgnPm3LbO7UNjGLL2GUZvPuFUODddwS5aJ2lTrnboclzuwMOTNGhT0XFc5
    zjvvp_rxDgtKeNWCUgbllhoUy69eJlS9K46gDj70PhRr6VvdeUQtA>
X-ME-Received: <xmr:XL1gacEGiTgGsUC4fCdAgjV7I3tSS7NKyce-Mc0t_Uy7cQSeejphTlSdXvs1FLQIShWrboKOVDOJ2rGWoQWbF4_I7-qwFb-rg6nPyfQDvw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddutdekfeegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeffueeiudejvdekheeuvdekfeffiedvueelteekudehjeetkeegvddugfdtgfeileen
    ucevlhhushhtvghrufhiiigvpedunecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhmpdhnsggprhgtphhtthhopeegpdhmohguvgepshhmthhpohhuthdprhgtphht
    thhopehkrhhishhtohhffhgvrhhhrghughhssggrkhhksehfrghsthhmrghilhdrtghomh
    dprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohep
    thhoohhnsehiohhttghlrdgtohhmpdhrtghpthhtohepjhhlthhosghlvghrsehgmhgrih
    hlrdgtohhm
X-ME-Proxy: <xmx:XL1gaTJUdZ_JTWaZFnOsSiXxHZvJPQ8MGjsghU-XIZVJUK0iKYu4ug>
    <xmx:XL1gaQn78vUe9BqRuQhhyoh-FjDcsNMRTiGNPf-OpflEfk8XMxcCEg>
    <xmx:XL1gabRG4Y6qjVkFKToDxZV-Y649OBwufNhQNxmS0rW26Gudt3dMPg>
    <xmx:XL1gaSLmSwmJRy5OxzlJ9HAURK4_t2luVNzT5CF-R_EUZjcO_QSoSA>
    <xmx:XL1gafF4CouhcEvnKfzwqMy1x82zo8_RcmkHIoNYXNmmDh-7f4cGwV2H>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 9 Jan 2026 03:33:31 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id ea025aee (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 9 Jan 2026 08:33:31 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Fri, 09 Jan 2026 09:33:15 +0100
Subject: [PATCH v3 07/10] packfile: only prepare owning store in
 `packfile_store_prepare()`
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260109-b4-pks-pack-store-via-source-v3-7-877fd7b7bf81@pks.im>
References: <20260109-b4-pks-pack-store-via-source-v3-0-877fd7b7bf81@pks.im>
In-Reply-To: <20260109-b4-pks-pack-store-via-source-v3-0-877fd7b7bf81@pks.im>
To: git@vger.kernel.org
Cc: Justin Tobler <jltobler@gmail.com>, Toon Claes <toon@iotcl.com>, 
 Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>
X-Mailer: b4 0.14.3

When calling `packfile_store_prepare()` we prepare not only the provided
packfile store, but also all those of all other sources part of the same
object database. This was required when the store was still sitting on
the object database level. But now that it sits on the source level it's
not anymore.

Refactor the code so that we only prepare the single packfile store
passed by the caller. Adapt callers accordingly.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/grep.c | 14 ++++++++------
 packfile.c     | 19 +++++--------------
 2 files changed, 13 insertions(+), 20 deletions(-)

diff --git a/builtin/grep.c b/builtin/grep.c
index 4855b871dd..5b8b87b1ac 100644
--- a/builtin/grep.c
+++ b/builtin/grep.c
@@ -1213,12 +1213,14 @@ int cmd_grep(int argc,
 		 */
 		if (recurse_submodules)
 			repo_read_gitmodules(the_repository, 1);
-		/*
-		 * Note: `packfile_store_prepare()` prepares stores from all
-		 * sources. This will be fixed in a subsequent commit.
-		 */
-		if (startup_info->have_repository)
-			packfile_store_prepare(the_repository->objects->sources->packfiles);
+
+		if (startup_info->have_repository) {
+			struct odb_source *source;
+
+			odb_prepare_alternates(the_repository->objects);
+			for (source = the_repository->objects->sources; source; source = source->next)
+				packfile_store_prepare(source->packfiles);
+		}
 
 		start_threads(&opt);
 	} else {
diff --git a/packfile.c b/packfile.c
index c46d53b75d..23d8f7cb93 100644
--- a/packfile.c
+++ b/packfile.c
@@ -1063,16 +1063,11 @@ static int sort_pack(const struct packfile_list_entry *a,
 
 void packfile_store_prepare(struct packfile_store *store)
 {
-	struct odb_source *source;
-
 	if (store->initialized)
 		return;
 
-	odb_prepare_alternates(store->source->odb);
-	for (source = store->source->odb->sources; source; source = source->next) {
-		prepare_multi_pack_index_one(source);
-		prepare_packed_git_one(source);
-	}
+	prepare_multi_pack_index_one(store->source);
+	prepare_packed_git_one(store->source);
 
 	sort_packs(&store->packs.head, sort_pack);
 	for (struct packfile_list_entry *e = store->packs.head; e; e = e->next)
@@ -2098,15 +2093,11 @@ static int find_pack_entry(struct repository *r,
 {
 	struct odb_source *source;
 
-	/*
-	 * Note: `packfile_store_prepare()` prepares stores from all sources.
-	 * This will be fixed in a subsequent commit.
-	 */
-	packfile_store_prepare(r->objects->sources->packfiles);
-
-	for (source = r->objects->sources; source; source = source->next)
+	for (source = r->objects->sources; source; source = source->next) {
+		packfile_store_prepare(r->objects->sources->packfiles);
 		if (source->midx && fill_midx_entry(source->midx, oid, e))
 			return 1;
+	}
 
 	for (source = r->objects->sources; source; source = source->next) {
 		struct packfile_list_entry *l;

-- 
2.52.0.542.g9473a8513b.dirty

