Received: from fhigh-b8-smtp.messagingengine.com (fhigh-b8-smtp.messagingengine.com [202.12.124.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01EA424887E
	for <git@vger.kernel.org>; Mon,  4 Aug 2025 09:46:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754300796; cv=none; b=YtGNihvq7E0nK0Zhf/IYpn3mo7gtuLIBdaxIeiPsExNAHHAGHZfRYspUmmpF3AGVcn0iIDZgMB+0XRs5eDli8uFC/tbcTzbnEe5oY30kvhydZdwBtXDIWFA+WfIlejmLoRZcd6i+XTnw5PkCrMD+8ZQ0hiQGF7qkxyXVcUs8u9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754300796; c=relaxed/simple;
	bh=XRO+ayVByDiUp80wZeNcZ1RV1rX1sDB1pqvjrD+oU40=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=GspOT+yriCguqcSfVd3+ftjbRC3DSdqCJ/Uxon25l7ZgoGsRWAHSGTXFc07RPG28SGHy6BxBxDwrZUD+kSxR/aLmYvKsuWtMjjWKx2UMZfFiy6x4pnpJ4ee/QRAy5ZPc1yJl+gfrs8ke9zDr+pcIMRBWEOsqY4QchtXTcnz2UJI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=ECakCSAv; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=HOOPbHiA; arc=none smtp.client-ip=202.12.124.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="ECakCSAv";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="HOOPbHiA"
Received: from phl-compute-10.internal (phl-compute-10.phl.internal [10.202.2.50])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 394227A002A;
	Mon,  4 Aug 2025 05:46:34 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-10.internal (MEProxy); Mon, 04 Aug 2025 05:46:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1754300794;
	 x=1754387194; bh=AN+7MAmhzKhpBA66QydiKzNjx777sSVwedXZ4d2cKuI=; b=
	ECakCSAvILNHN9aiBpdIly8ozqvsOLYP/jja+0+tYD0+tIg1SZhjfVSwf4wmyzUp
	ifz9JrOMWJvkUIOHOAnGagrkI4GvWsKv2igfVThos+w9tNopgBxDuFRQhitYqQAs
	qSLMPgmRjBzDyRwO6qw5A56e6winvLtb/EpIuClKKPwfqgDnwvukzCR1i0ObCZHF
	8sOC05/fZWLhQvUh1hArOLEpsEBbOn0lxbR6SmZZ7WHtclTbY5g97crnW1/u/LxQ
	cX4Rgz9i3oT9RsuY2G+3pUViFEgKG8t2fMIoxou9PkQEl/lIa/NmwDbAV/2WZl2S
	wZBwMHzcTsBQFWXi2BGAXQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1754300794; x=
	1754387194; bh=AN+7MAmhzKhpBA66QydiKzNjx777sSVwedXZ4d2cKuI=; b=H
	OOPbHiAJ6XddfNwhYSY4wooKGu61AnOvcuxtOtCB1Hd5HRnYs+sSOjc9SY82WLe8
	oYXZiylzWgUysBCABS4ODSpkSlquxLThviAiikd0GejylfxtJLJudSsNapFflzVg
	SWwr/pSbxRCNmSM3sostKE+exSJSnd7wYJfyE/TLRQoO03HVdYkqdIeDIoE/a/NA
	SqKLFGL74f//cpDCwdOv90Cmz95CugVTU6Xf2msgIgNqGu5xuw97vJBx/TT2LNy3
	8BpUC5hcNY9w38scHg6N1y0NbUHP25XC8Oo/qiwWTqo0iqlypDlZCfoR010y5WHe
	J+ndJn4e9k8QXKjngnn/g==
X-ME-Sender: <xms:eYGQaLX9aAdSISYr3Tmyd-3npEECC_PcAyFc1I-5KinCD6oz7BzhqQ>
    <xme:eYGQaAd5ntt9ohB6VhZUDyJJRqUh1slZuALWDVC9t6CEps_oyHGC7Ch-Qct0y9YfI
    Ro88_3XzPbTOG5a9g>
X-ME-Received: <xmr:eYGQaHKHNpWSV1UK8UwbvbfEYCy5_j0ixFSOCCQgtgNzr3FLzf8pw-3YGFcddYZY3TU8pAsGa3h2vRD_n44ZaC9IAECRV7dP0Sa9xQbfngs>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdduudduleejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeffueeiudejvdekheeuvdekfeffiedvueelteekudehjeetkeegvddugfdtgfeileen
    ucevlhhushhtvghrufhiiigvpedvnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhmpdhnsggprhgtphhtthhopeelpdhmohguvgepshhmthhpohhuthdprhgtphht
    thhopehtohhonhesihhothgtlhdrtghomhdprhgtphhtthhopehpvghffhesphgvfhhfrd
    hnvghtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphht
    thhopehsiigvuggvrhdruggvvhesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsh
    htvghrsehpohgsohigrdgtohhmpdhrtghpthhtohepkhhrihhsthhofhhfvghrhhgruhhg
    shgsrghkkhesfhgrshhtmhgrihhlrdgtohhmpdhrtghpthhtohepjhhlthhosghlvghrse
    hgmhgrihhlrdgtohhmpdhrtghpthhtohepsggvnhdrkhhnohgslhgvsehgmhgrihhlrdgt
    ohhmpdhrtghpthhtohepkhgrrhhthhhikhdrudekkeesghhmrghilhdrtghomh
X-ME-Proxy: <xmx:eYGQaFxHgMAq0nskbf2zlPmPrcfHogcrcrs-_9E46ufO3-rtHjMedg>
    <xmx:eYGQaFvALNnBndaKu2ZPZinXXEtKH4qOxN4gOaPoI3zA6XEjHqGcXA>
    <xmx:eYGQaAClyrNaxVQl-l4a4xihSQG2n7qywGF8Vi6R9ZlHVC_OEfrypg>
    <xmx:eYGQaPEnUjHvTn_Wo9QP2kEk-xxh0JD-CXiO0Mh9ay6daY4x-pV-SA>
    <xmx:eoGQaO7mq05y_Gvz_Dy1962VrAXHGSE7kTBtdTekwtsnTVCO2K5dgfsY>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 4 Aug 2025 05:46:32 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 5e70fd3a (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Mon, 4 Aug 2025 09:46:31 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Mon, 04 Aug 2025 11:46:07 +0200
Subject: [PATCH v4 7/9] refs/files: detect race when generating reflog
 entry for HEAD
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250804-pks-reflog-append-v4-7-13213fef7200@pks.im>
References: <20250804-pks-reflog-append-v4-0-13213fef7200@pks.im>
In-Reply-To: <20250804-pks-reflog-append-v4-0-13213fef7200@pks.im>
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

Unfortunately, this change only helps with the second race. We cannot
reliably plug the first race without locking the HEAD reference at the
start of the transaction. Locking HEAD unconditionally would effectively
serialize all writes though, and that doesn't seem like an option. Also,
double checking its value at the end of the transaction is not an option
either, as its target may have flip-flopped during the transaction.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 refs/files-backend.c | 58 +++++++++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 55 insertions(+), 3 deletions(-)

diff --git a/refs/files-backend.c b/refs/files-backend.c
index bf6f89b1d1..d0baa4e01c 100644
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
@@ -637,14 +643,16 @@ int parse_loose_ref_contents(const struct git_hash_algo *algop,
 	return 0;
 }
 
-static void unlock_ref(struct ref_lock *lock)
+static int unlock_ref(struct ref_lock *lock)
 {
 	lock->count--;
 	if (!lock->count) {
 		rollback_lock_file(&lock->lk);
 		free(lock->ref_name);
 		free(lock);
+		return 1;
 	}
+	return 0;
 }
 
 /*
@@ -2420,9 +2428,10 @@ static enum ref_transaction_error split_head_update(struct ref_update *update,
 
 	new_update = ref_transaction_add_update(
 			transaction, "HEAD",
-			update->flags | REF_LOG_ONLY | REF_NO_DEREF,
+			update->flags | REF_LOG_ONLY | REF_NO_DEREF | REF_LOG_VIA_SPLIT,
 			&update->new_oid, &update->old_oid,
 			NULL, NULL, update->committer_info, update->msg);
+	new_update->parent_update = update;
 
 	/*
 	 * Add "HEAD". This insertion is O(N) in the transaction
@@ -2550,6 +2559,9 @@ struct files_transaction_backend_data {
  *   the referent to transaction.
  * - If it is an update of head_ref, add a corresponding REF_LOG_ONLY
  *   update of HEAD.
+ *
+ * Returns 0 on success, 1 in case the update needs to be dropped or a negative
+ * error code otherwise.
  */
 static enum ref_transaction_error lock_ref_for_update(struct files_ref_store *refs,
 						      struct ref_update *update,
@@ -2600,7 +2612,45 @@ static enum ref_transaction_error lock_ref_for_update(struct files_ref_store *re
 
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
+		 * it up. If it did we remove the reflog-only updateg from the
+		 * transaction again.
+		 *
+		 * Note that this does not catch all races: if "HEAD" was
+		 * racily changed to point to one of the refs part of the
+		 * transaction then we would miss writing the split reflog
+		 * entry for "HEAD".
+		 */
+		if (!(update->type & REF_ISSYMREF) ||
+		    strcmp(update->parent_update->refname, referent.buf)) {
+			if (unlock_ref(lock))
+				strmap_remove(&backend_data->ref_locks,
+					      update->refname, 0);
+
+			memmove(transaction->updates + update_idx,
+				transaction->updates + update_idx + 1,
+				(transaction->nr - update_idx - 1) * sizeof(*transaction->updates));
+			transaction->nr--;
+
+			ret = 1;
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
@@ -2860,6 +2910,8 @@ static int files_transaction_prepare(struct ref_store *ref_store,
 					  head_ref, &refnames_to_check,
 					  err);
 		if (ret) {
+			if (ret > 0)
+				continue;
 			if (ref_transaction_maybe_set_rejected(transaction, i, ret)) {
 				strbuf_reset(err);
 				ret = 0;

-- 
2.50.1.723.g3e08bea96f.dirty

