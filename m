Received: from fout-b3-smtp.messagingengine.com (fout-b3-smtp.messagingengine.com [202.12.124.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F70824887E
	for <git@vger.kernel.org>; Mon,  4 Aug 2025 09:46:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754300800; cv=none; b=Q3dwkZNw82/OfpQlHen6MgOsH3CCxoeHJanA7sOFZA46ZbKPdqTdwGpMUaCfN/6A3b+sdy2snFnjn7SHAogUVJDBRowlIXFidl2/FPaf+30w7+jOx0XWfOITxhwSbmpBwLW5CS4TQkvgsm1BpldG1pM8pctNnDIuEYDGqZO9hxg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754300800; c=relaxed/simple;
	bh=U3yPgUBg9IKVxrWdhv3cFnbKzepNHJQeuFvKGM0OCJo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=IUc4Z8gDBS8n3rDu+Z1jk0n0XHrVzybYcxfAKxCfxNSom8nBEUxYnhjGZV+1NK9o7vc/+M5P0yCZ6qawShtzx9jVwn/IZLTHSWwagmei4jle7X2AZ4HUY59ONdMnbdb+Jv+uz2pU6/zfdVNJEL7eCv8q6fNo0CPCJdS3rQ/dsyA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=dy4EmwZw; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=gxZOOwIi; arc=none smtp.client-ip=202.12.124.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="dy4EmwZw";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="gxZOOwIi"
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfout.stl.internal (Postfix) with ESMTP id 46B4C1D000D0;
	Mon,  4 Aug 2025 05:46:37 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-03.internal (MEProxy); Mon, 04 Aug 2025 05:46:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1754300797;
	 x=1754387197; bh=k5iQx0MviQn0mB0HEni42lhSkuvRkD6OGMlj44UOZL8=; b=
	dy4EmwZwTsRN1asCOP3mPFrwu0qJbVCawDZNYqI53/AvS2FQQgE4bnoefS74jFTd
	jwft6oE4frvsmYL84EtubNcrIw/NSSSbuqntV/1GBS6ozgIakkecQFz6GTTOUW81
	CDt9ff34dOT0FdvUR85l5MSQy5NCx2E/zafuOfjhoilNZzi+1OuGvspD0zhZH1l5
	9geH/kbEdCGhnRHs/EV6Nv1fstZGtkmTBB7Ny6SDjQM9MT26duUDePHrw1J6lRqw
	qEKL1JAiSPhuyn+Z8+gOrtURBE2i1Ja6q0lAf+lkmnpC112hExxNMnhLyIl3Kc/E
	LnzKINc52p0lPRVcU0H3Bg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1754300797; x=
	1754387197; bh=k5iQx0MviQn0mB0HEni42lhSkuvRkD6OGMlj44UOZL8=; b=g
	xZOOwIiYnFIPLMN3UmyR6ZacTiwtBFf0YnV8WzMPGUsmkh8vt7i01fBnSuNTox38
	fDUZZvU6MQaD13rMJ33vsF9X61cuDXwpOzOO4rf44CKZXBeId3HLSgGi/z7KXJtE
	SYyvhMhgKswOk6jbeaRupvjbGqve3xZkKp9gVkRVefCXgXYvCwgmYGrpDpcXHFve
	1nxJ5rA0gzKGLHIiEKFrn8eAgkK9kaFjKW4KblBO6gLmnjydIbg8KDJiWuL0pHmK
	CiUCW5jkoi/0hnjAjT1oEUeIvM0doUiNzkccY6eT24m2ikiErCe/JE0WYRdqg1F1
	/g7TVzTzqREZJpJcNubZA==
X-ME-Sender: <xms:fYGQaAyPrdNzPHDY0zpb1KqkCroMpAOX7LqfkbR1D8jt1X1DqAjz7A>
    <xme:fYGQaBKFmN0_YWjJ-YMWBr62vWsSSA13tK05TMuR9jbMDzWRwfYrTIs-n5vso80Sg
    EIuXvnpt4rcp_r2AA>
X-ME-Received: <xmr:fYGQaCGKo7cvrttI0iauj_vslX_IaJkiw5ledXzxZgNeXjRuMdCZMneepPmNAeYDMswYsSqLM45_uqnqWC8XLM-ixACb3H-S68VY27vYSN4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdduudduleejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeffueeiudejvdekheeuvdekfeffiedvueelteekudehjeetkeegvddugfdtgfeileen
    ucevlhhushhtvghrufhiiigvpedvnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhmpdhnsggprhgtphhtthhopeelpdhmohguvgepshhmthhpohhuthdprhgtphht
    thhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepkhhrihhsth
    hofhhfvghrhhgruhhgshgsrghkkhesfhgrshhtmhgrihhlrdgtohhmpdhrtghpthhtohep
    khgrrhhthhhikhdrudekkeesghhmrghilhdrtghomhdprhgtphhtthhopehtohhonhesih
    hothgtlhdrtghomhdprhgtphhtthhopegsvghnrdhknhhosghlvgesghhmrghilhdrtgho
    mhdprhgtphhtthhopehsiigvuggvrhdruggvvhesghhmrghilhdrtghomhdprhgtphhtth
    hopehjlhhtohgslhgvrhesghhmrghilhdrtghomhdprhgtphhtthhopehpvghffhesphgv
    fhhfrdhnvghtpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:fYGQaN-lp5SI8WuRceNv0IZRvDO8n8bHe8-1lq-ilfFSQqhCBt_TLQ>
    <xmx:fYGQaCKwnUfUcScDHlbw-1z4Ii3S5zd8_D5dA_GrGTP-z6Hc2mdyYQ>
    <xmx:fYGQaLuGwc5myT1BYNhh-tuPFjpeKwcC7DidlK1csAlO598u8P7G9A>
    <xmx:fYGQaJBGor0ocFtvtkDMSaJDeJ82HZlH7Xend_KogDtDHd5suPxD2A>
    <xmx:fYGQaKMGPEoPS6DGZ07yWiN11hdlc1v4hyhWeffSwsCEuOUsYqZSblf6>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 4 Aug 2025 05:46:35 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 7c6ca02d (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Mon, 4 Aug 2025 09:46:34 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Mon, 04 Aug 2025 11:46:08 +0200
Subject: [PATCH v4 8/9] refs: stop unsetting REF_HAVE_OLD for log-only
 updates
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250804-pks-reflog-append-v4-8-13213fef7200@pks.im>
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

The `REF_HAVE_OLD` flag indicates whether a given ref update has its old
object ID set. If so, the value of that field is used to verify whether
the current state of the reference matches this expected state. It is
thus an important part of mitigating races with a concurrent process
that updates the same set of references.

When writing reflogs though we explicitly unset that flag. This is a
sensible thing to do: the old state of reflog entry updates may not
necessarily match the current on-disk state of its accompanying ref, but
it's only intended to signal what old object ID we want to write into
the new reflog entry. For example when migrating refs we end up writing
many reflog entries for a single reference, and most likely those reflog
entries will have many different old object IDs.

But unsetting this flag also removes a useful signal, namely that the
caller _did_ provide an old object ID for a given reflog entry. This
signal will become useful in a subsequent commit, where we add a new
flag that tells the transaction to use the provided old and new object
IDs to write a reflog entry. The `REF_HAVE_OLD` flag is then used as a
signal to verify that the caller really did provide an old object ID.

Stop unsetting the flag so that we can use it as this described signal
in a subsequent commit. Skip checking the old object ID for log-only
updates so that we don't expect it to match the current on-disk state.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 refs.c                  |  8 +++-----
 refs/files-backend.c    |  9 +++++----
 refs/refs-internal.h    |  3 ++-
 refs/reftable-backend.c | 12 +++---------
 4 files changed, 13 insertions(+), 19 deletions(-)

diff --git a/refs.c b/refs.c
index a5f9ffaa45..f88928de74 100644
--- a/refs.c
+++ b/refs.c
@@ -1393,11 +1393,6 @@ int ref_transaction_update_reflog(struct ref_transaction *transaction,
 	update = ref_transaction_add_update(transaction, refname, flags,
 					    new_oid, old_oid, NULL, NULL,
 					    committer_info, msg);
-	/*
-	 * While we do set the old_oid value, we unset the flag to skip
-	 * old_oid verification which only makes sense for refs.
-	 */
-	update->flags &= ~REF_HAVE_OLD;
 	update->index = index;
 
 	/*
@@ -3318,6 +3313,9 @@ int repo_migrate_ref_storage_format(struct repository *repo,
 
 int ref_update_expects_existing_old_ref(struct ref_update *update)
 {
+	if (update->flags & REF_LOG_ONLY)
+		return 0;
+
 	return (update->flags & REF_HAVE_OLD) &&
 		(!is_null_oid(&update->old_oid) || update->old_target);
 }
diff --git a/refs/files-backend.c b/refs/files-backend.c
index d0baa4e01c..c37fbfd138 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -2502,7 +2502,6 @@ static enum ref_transaction_error split_symref_update(struct ref_update *update,
 	 * done when new_update is processed.
 	 */
 	update->flags |= REF_LOG_ONLY | REF_NO_DEREF;
-	update->flags &= ~REF_HAVE_OLD;
 
 	return 0;
 }
@@ -2517,8 +2516,9 @@ static enum ref_transaction_error check_old_oid(struct ref_update *update,
 						struct object_id *oid,
 						struct strbuf *err)
 {
-	if (!(update->flags & REF_HAVE_OLD) ||
-		   oideq(oid, &update->old_oid))
+	if (update->flags & REF_LOG_ONLY ||
+	    !(update->flags & REF_HAVE_OLD) ||
+	    oideq(oid, &update->old_oid))
 		return 0;
 
 	if (is_null_oid(&update->old_oid)) {
@@ -3111,7 +3111,8 @@ static int files_transaction_finish_initial(struct files_ref_store *refs,
 	for (i = 0; i < transaction->nr; i++) {
 		struct ref_update *update = transaction->updates[i];
 
-		if ((update->flags & REF_HAVE_OLD) &&
+		if (!(update->flags & REF_LOG_ONLY) &&
+		    (update->flags & REF_HAVE_OLD) &&
 		    !is_null_oid(&update->old_oid))
 			BUG("initial ref transaction with old_sha1 set");
 
diff --git a/refs/refs-internal.h b/refs/refs-internal.h
index f868870851..95a4dc3902 100644
--- a/refs/refs-internal.h
+++ b/refs/refs-internal.h
@@ -802,7 +802,8 @@ enum ref_transaction_error ref_update_check_old_target(const char *referent,
 
 /*
  * Check if the ref must exist, this means that the old_oid or
- * old_target is non NULL.
+ * old_target is non NULL. Log-only updates never require the old state to
+ * match.
  */
 int ref_update_expects_existing_old_ref(struct ref_update *update);
 
diff --git a/refs/reftable-backend.c b/refs/reftable-backend.c
index 4c3817f4ec..44af58ac50 100644
--- a/refs/reftable-backend.c
+++ b/refs/reftable-backend.c
@@ -1180,8 +1180,6 @@ static enum ref_transaction_error prepare_single_update(struct reftable_ref_stor
 	if (ret > 0) {
 		/* The reference does not exist, but we expected it to. */
 		strbuf_addf(err, _("cannot lock ref '%s': "
-
-
 				   "unable to resolve reference '%s'"),
 			    ref_update_original_update_refname(u), u->refname);
 		return REF_TRANSACTION_ERROR_NONEXISTENT_REF;
@@ -1235,13 +1233,8 @@ static enum ref_transaction_error prepare_single_update(struct reftable_ref_stor
 
 			new_update->parent_update = u;
 
-			/*
-			 * Change the symbolic ref update to log only. Also, it
-			 * doesn't need to check its old OID value, as that will be
-			 * done when new_update is processed.
-			 */
+			/* Change the symbolic ref update to log only. */
 			u->flags |= REF_LOG_ONLY | REF_NO_DEREF;
-			u->flags &= ~REF_HAVE_OLD;
 		}
 	}
 
@@ -1265,7 +1258,8 @@ static enum ref_transaction_error prepare_single_update(struct reftable_ref_stor
 		ret = ref_update_check_old_target(referent->buf, u, err);
 		if (ret)
 			return ret;
-	} else if ((u->flags & REF_HAVE_OLD) && !oideq(&current_oid, &u->old_oid)) {
+	} else if ((u->flags & (REF_LOG_ONLY | REF_HAVE_OLD)) == REF_HAVE_OLD &&
+		   !oideq(&current_oid, &u->old_oid)) {
 		if (is_null_oid(&u->old_oid)) {
 			strbuf_addf(err, _("cannot lock ref '%s': "
 					   "reference already exists"),

-- 
2.50.1.723.g3e08bea96f.dirty

