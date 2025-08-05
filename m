Received: from fout-a4-smtp.messagingengine.com (fout-a4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 958D527990B
	for <git@vger.kernel.org>; Tue,  5 Aug 2025 15:12:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754406729; cv=none; b=FeoXnDNcEP7V9cAPWuOWQykbF3oy6FXyvErQ/n+8EH9pSVHkyW/KGRqCcTpb5QG4d9rsGVlbAjRfrjSyCXnaw8dFt1ECyQqFN1KXwNcWW9XXnk3SS8BqbCojTPWSJvH9YvxIH5bLQyjTXWOpyiuli3lsXMPbaG5rfmc9gWe50Qk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754406729; c=relaxed/simple;
	bh=cupvziPma0oUb/Oj8gyT6DI/hQlVMdODiRLHgCQTHYI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ReNFny2duiOh+JB8790lS+1skhW1nT6VNETnh4HpR/C4+tqjOUZNd54hZOeXyAxSO8qJ2ATVZAfDvrXm3sgs98xMjemeFp0Z1gZddxk4GleIdBVi5ek6EEcfE7j6YjE6sbszNrudMCFkRKWBGhbPRyJzoSHvZFOOOPZuxSpNiC0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=OqQQ5m8n; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Msy9SC5h; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="OqQQ5m8n";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Msy9SC5h"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id D9137EC024A;
	Tue,  5 Aug 2025 11:12:06 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Tue, 05 Aug 2025 11:12:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1754406726;
	 x=1754493126; bh=HqipG+jFGaxEbcZpCCBKopKzUwe08NkXG1m0bUB9SIs=; b=
	OqQQ5m8nCRpNWIC9U1ufc0hZtkzRobQngf0CN0zjMuBVuK9FXtkG0G/e7bgmE6rf
	sWbkMddA0K5T7J8/KKknGsOwbwAX5sftjV532TfTmIu8juIek1Hgm0v/id1BCm3T
	wU0jxKoFYe5DKGC8cOTlzCb7Kw1iTpBZvWkEKTR2ACFFbGadHBGP9jsbdhI+RE9z
	wqPi9dMXBmVjXVB9DF4P0lHueFP0Fm/i7/BUxkHmjTvBtPQSHeAI/BgQmc0k60Nz
	rOQkSOTEyH/jxx0qlKrlNSGellYogTwh8WnAj80kYMqiqT+r7+gC+iliG7r7sEuI
	5ESBYT46Q/EyzIyl3MSPoQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1754406726; x=
	1754493126; bh=HqipG+jFGaxEbcZpCCBKopKzUwe08NkXG1m0bUB9SIs=; b=M
	sy9SC5heEPtv9W7Yr5/fvdSS1TdLAfmdXPGYO+YZ3ROvAKfjcqyDN0Ctq3M043PU
	QTzGM4pWVjct6bJue7vUAx7/oGyB1C0DLVwFMHySTdtqkxsALAmKsZeYQbBVwghV
	o+tzDezcQnSGgyUpiJ6WBnxSpe93PXVof4MyPKx0fmocHNBF7o4FTcVBo5MDg902
	+QltWeuOl/9RGrttB/y2LbDcLtF5XAa74qPfv5xWq0B04S0BhZFr5j5j7dBccwVl
	Y21RuvIX+rRxyY9+VpRHqHgYbStJZGtB16G+gbz8h37zufQknHxA1BKnC8N3eLqB
	xhkOALFy81uncYKzcIGeg==
X-ME-Sender: <xms:Rh-SaBK3OVk6xVRUMDC1odgBc8b4YLpr1uBIcSjajGG8-5WPGpnahA>
    <xme:Rh-SaKDzwr-3PMguJWB-R0BNK3srHQOTed3PiMpHfLOxdPKoir5fZnml_o6HBuHpf
    10ui5j90rApTDBAoA>
X-ME-Received: <xmr:Rh-SaJcw8DEb1iXiiHtVJRlJ2X-bUqJOOrRBwFr5rWksZiAeOnpHNs9jnDV4b3EgD7uy8B3iXedmHPJP9aJsLVu-2hhYOkBnV7FKVua6Gg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdduudehhedtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeffueeiudejvdekheeuvdekfeffiedvueelteekudehjeetkeegvddugfdtgfeileen
    ucevlhhushhtvghrufhiiigvpedvnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhmpdhnsggprhgtphhtthhopeelpdhmohguvgepshhmthhpohhuthdprhgtphht
    thhopehjlhhtohgslhgvrhesghhmrghilhdrtghomhdprhgtphhtthhopegsvghnrdhknh
    hosghlvgesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhn
    vghlrdhorhhgpdhrtghpthhtohepkhgrrhhthhhikhdrudekkeesghhmrghilhdrtghomh
    dprhgtphhtthhopehsiigvuggvrhdruggvvhesghhmrghilhdrtghomhdprhgtphhtthho
    pehtohhonhesihhothgtlhdrtghomhdprhgtphhtthhopehgihhtshhtvghrsehpohgsoh
    igrdgtohhmpdhrtghpthhtohepphgvfhhfsehpvghffhdrnhgvthdprhgtphhtthhopehk
    rhhishhtohhffhgvrhhhrghughhssggrkhhksehfrghsthhmrghilhdrtghomh
X-ME-Proxy: <xmx:Rh-SaB2KoE0dHLxzZlhFGqNisYayWGFoAJitkVwvvqqHHDTEVKUiWw>
    <xmx:Rh-SaIiSztP8lnkJXTarcSkA8GRxs0LFbL8JkUufCpkw81g6f4a8QQ>
    <xmx:Rh-SaCmQAZXOmO6UM1P-sKjF6mziDZYxCC9uSWOTK19XmZW8iFhjTg>
    <xmx:Rh-SaGYex8SUfjfxHVxfRWNjlnnvIuzKhtJ4SuVWHjpEQilrt5Daqg>
    <xmx:Rh-SaE-u0n76RRdd6xidOIcY7Cgt2qCHAdXpKoB4OZIJGjslBeL8ApyY>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 5 Aug 2025 11:12:05 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id d35953d4 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Tue, 5 Aug 2025 15:12:04 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Tue, 05 Aug 2025 17:11:37 +0200
Subject: [PATCH v5 7/9] refs/files: detect race when generating reflog
 entry for HEAD
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250805-pks-reflog-append-v5-7-050997db09d5@pks.im>
References: <20250805-pks-reflog-append-v5-0-050997db09d5@pks.im>
In-Reply-To: <20250805-pks-reflog-append-v5-0-050997db09d5@pks.im>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>, 
 Justin Tobler <jltobler@gmail.com>, Junio C Hamano <gitster@pobox.com>, 
 =?utf-8?q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>, 
 Toon Claes <toon@iotcl.com>, Jeff King <peff@peff.net>, 
 Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>, 
 Ben Knoble <ben.knoble@gmail.com>
X-Mailer: b4 0.14.2

When updating a reference that is being pointed to HEAD we don't only
write a reflog message for that particular reference, but also generate
one for HEAD. This logic is handled by `split_head_update()`, where we:

  1. Verify that the condition actually triggered. This is done by
     reading HEAD at the start of the transaction so that we can then
     check whether a given reference update refers to its target.

  2. Queue a new log-only update for HEAD in case it did.

But the logic is unfortunately not free of races, as we do not lock the
HEAD reference after we have read its target. This can lead to the
following two scenarios:

  - HEAD gets concurrently updated to point to one of the references we
    have already processed. This causes us not writing a reflog message
    even though we should have done so.

  - HEAD gets concurrently updated to no longer point to a reference
    anymore that we have already processed. This causes us to write a
    reflog message even though we should _not_ have done so.

Improve the situation by introducing a new `REF_LOG_VIA_SPLIT` flag that
is specific to the "files" backend. If set, we will double check that
the HEAD reference still points to the reference that we are creating
the reflog entry for after we have locked HEAD. Furthermore, instead of
manually resolving the old object ID of that entry, we now use the same
old state as for the parent update.

If we detect such a racy update we abort the transaction. This is a bit
heavy-handed: the user didn't even ask us to write a reflog update for
"HEAD", so it might be surprising if we abort the transaction. That
being said:

  - Normal users wouldn't typically hit this case as we only hit the
    relevant code when committing to a branch that is being pointed to
    by "HEAD" directly. Commands like git-commit(1) typically commit to
    "HEAD" itself though.

  - Scripted users that use git-update-ref(1) and related plumbing
    commands are unlikely to hit this case either, as they would have to
    update the pointed-to-branch at the same as "HEAD" is being updated,
    which is an exceedingly rare event.

The alternative would be to instead drop the log-only update completely,
but that would require more logic that is hard to verify without adding
infrastructure specific for such a test. So we rather do the pragmatic
thing and don't worry too much about an edge case that is very unlikely
to happen.

Unfortunately, this change only helps with the second race. We cannot
reliably plug the first race without locking the HEAD reference at the
start of the transaction. Locking HEAD unconditionally would effectively
serialize all writes though, and that doesn't seem like an option. Also,
double checking its value at the end of the transaction is not an option
either, as its target may have flip-flopped during the transaction.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 refs/files-backend.c | 40 ++++++++++++++++++++++++++++++++++++++--
 1 file changed, 38 insertions(+), 2 deletions(-)

diff --git a/refs/files-backend.c b/refs/files-backend.c
index bf6f89b1d1..ba018b0984 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -68,6 +68,12 @@
  */
 #define REF_DELETED_RMDIR (1 << 9)
 
+/*
+ * Used to indicate that the reflog-only update has been created via
+ * `split_head_update()`.
+ */
+#define REF_LOG_VIA_SPLIT (1 << 14)
+
 struct ref_lock {
 	char *ref_name;
 	struct lock_file lk;
@@ -2420,9 +2426,10 @@ static enum ref_transaction_error split_head_update(struct ref_update *update,
 
 	new_update = ref_transaction_add_update(
 			transaction, "HEAD",
-			update->flags | REF_LOG_ONLY | REF_NO_DEREF,
+			update->flags | REF_LOG_ONLY | REF_NO_DEREF | REF_LOG_VIA_SPLIT,
 			&update->new_oid, &update->old_oid,
 			NULL, NULL, update->committer_info, update->msg);
+	new_update->parent_update = update;
 
 	/*
 	 * Add "HEAD". This insertion is O(N) in the transaction
@@ -2600,7 +2607,36 @@ static enum ref_transaction_error lock_ref_for_update(struct files_ref_store *re
 
 	update->backend_data = lock;
 
-	if (update->type & REF_ISSYMREF) {
+	if (update->flags & REF_LOG_VIA_SPLIT) {
+		struct ref_lock *parent_lock;
+
+		if (!update->parent_update)
+			BUG("split update without a parent");
+
+		parent_lock = update->parent_update->backend_data;
+
+		/*
+		 * Check that "HEAD" didn't racily change since we have looked
+		 * it up. If it did we must refuse to write the reflog entry.
+		 *
+		 * Note that this does not catch all races: if "HEAD" was
+		 * racily changed to point to one of the refs part of the
+		 * transaction then we would miss writing the split reflog
+		 * entry for "HEAD".
+		 */
+		if (!(update->type & REF_ISSYMREF) ||
+		    strcmp(update->parent_update->refname, referent.buf)) {
+			strbuf_addstr(err, "HEAD has been racily updated");
+			ret = REF_TRANSACTION_ERROR_GENERIC;
+			goto out;
+		}
+
+		if (update->flags & REF_HAVE_OLD) {
+			oidcpy(&lock->old_oid, &update->old_oid);
+		} else {
+			oidcpy(&lock->old_oid, &parent_lock->old_oid);
+		}
+	} else if (update->type & REF_ISSYMREF) {
 		if (update->flags & REF_NO_DEREF) {
 			/*
 			 * We won't be reading the referent as part of

-- 
2.50.1.723.g3e08bea96f.dirty

