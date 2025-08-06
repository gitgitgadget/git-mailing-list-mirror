Received: from fout-b6-smtp.messagingengine.com (fout-b6-smtp.messagingengine.com [202.12.124.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7B0420C00C
	for <git@vger.kernel.org>; Wed,  6 Aug 2025 05:54:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754459688; cv=none; b=SwC49P9mMolf2GL/8VmQGM9GVQUymIQedhR6qiXl145UP1JtCW521zhq0hsWpxaPX9Yyl79/l6zNfZGVhrSpaHiFZkbxtsnUkZqS/R364EELrz2bc0CNid+TXqfVX0fkTjyo9Ak97WGYIeBvKw/4wTv8WmfHKf0pbtCgLBRI6bk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754459688; c=relaxed/simple;
	bh=uY7BkZnnQIKCTfOXz4YQKUrIGi0Ns/xbAap5wIR52pA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=YWxynkTiD4vXqNcgCcQnDW+1CKCgfFyFl1RYYz3AiPLJntC4lmneTrTqlVeVSFJxeHoS4QCsqAPuWs80n9PJtNU62SaDZ0u/1FvfGcpCvblb4dTsY6iyDXD5cgN9IhOuO+He6FVWvCXbXCmo+I1bCgKtWFzx/Gs7lFkIJH+awbg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=ZmY3T486; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=lO8qV4Ph; arc=none smtp.client-ip=202.12.124.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="ZmY3T486";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="lO8qV4Ph"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.stl.internal (Postfix) with ESMTP id EFB661D00157;
	Wed,  6 Aug 2025 01:54:45 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Wed, 06 Aug 2025 01:54:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1754459685;
	 x=1754546085; bh=UufLI853EfRgh+U20WZ3RHQMdfBaODA/1tDGb6Awt+4=; b=
	ZmY3T486DTHH5TJLy8caGU7gkTdRRRo9tIHdQ29brOOLC+maR5OPZopwFhBV8FBy
	v5grw0Pr28USJe+2Hfe0ESBdDFHx/4p9FdX432TKuuQRY3mHGSAhmGl/AHIq6PSo
	/vqK4WR3TV0IGMQpyL9p/vmKbvGvHuyNlzxDC4x2fuPtLpIaEdXuAwxiHZJSB9XN
	A7DQJajngpYVovuIgDqI99yw2O9/GNKOR1rwQiJZ+1l/Y9/VK8RJTNu25Due8R3f
	c+RrPEWaIHArHCz7L09Qdqxl5Al87Jj/d6l/7TZxZuhh/WsdI84a6U1RDigmjnaD
	hV73l0AiJS6cX3AJmYQU8Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1754459685; x=
	1754546085; bh=UufLI853EfRgh+U20WZ3RHQMdfBaODA/1tDGb6Awt+4=; b=l
	O8qV4PhgYeBY9CNxKbbTALUsx061WfE/ICdTXX33k6unHYWc/KuKeG7a3B2i37Q2
	BD8L1VfN4ggwdXkK8SF1qXzeUP3wj4Wc5KvsEX4wMEEqLtv8soDpjAgqWsJGT4Z9
	4rrM2ebJNkBEiegxYil1amKxpvOsKWZHpccwSfgYgjZd+cOqYkkfavKVtConheq2
	ZVQTFNJz+0eWsWg/+NB+Jn1PbQ78Q69EQawUp3Y+OF8+xraqXsS2Fh6tYjaD1Xvn
	TYdwKic0ka/hS7Cwjx1sKG8R7OkD2pNeVBX/JEeVPYIzfmRXm2v9fHFrw1Fsk1aU
	4LzVoro0WwkKmHHYNdvMA==
X-ME-Sender: <xms:Je6SaBWL6Y5EbqQWN9JuDJZVxUlUmkNV-ZX6k7AyyY2bBURMSSsa-Q>
    <xme:Je6SaNROZ43pS7GjaXiZpY_wZOgqJNwdUj6v-7KM82o5YnvlaVXDOfxedo83bKFcG
    m6fT14yhAnLAbWhcA>
X-ME-Received: <xmr:Je6SaJ0JtLkmsmGAZGNuC9apYBMIcEr5dYC5vX2NAgERK2X1WGDdZi_WB99HG6MPAB_iZASCamZchIF8boujpEshBSs2cfmKjjXxhFVXRg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdduudejvdejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeffueeiudejvdekheeuvdekfeffiedvueelteekudehjeetkeegvddugfdtgfeileen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhmpdhnsggprhgtphhtthhopedutddpmhhouggvpehsmhhtphhouhhtpdhrtghp
    thhtohepshiivgguvghrrdguvghvsehgmhgrihhlrdgtohhmpdhrtghpthhtohepkhhrih
    hsthhofhhfvghrhhgruhhgshgsrghkkhesfhgrshhtmhgrihhlrdgtohhmpdhrtghpthht
    ohepthhoohhnsehiohhttghlrdgtohhmpdhrtghpthhtohepkhgrrhhthhhikhdrudekke
    esghhmrghilhdrtghomhdprhgtphhtthhopehjlhhtohgslhgvrhesghhmrghilhdrtgho
    mhdprhgtphhtthhopegsvghnrdhknhhosghlvgesghhmrghilhdrtghomhdprhgtphhtth
    hopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepjhhnrdgrvhhi
    lhgrsehfrhgvvgdrfhhrpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:Je6SaNf9JDH4HeaSauV2Pt5fzzK0aZfM4z2U1JxgocQGJmSne5MZ1Q>
    <xmx:Je6SaBO2BXZ-8Un-GqixJfM71zAAsjT_ZgGNI9DMIyw5vrJ97Inrgw>
    <xmx:Je6SaBUBSEmaPQoBK4zyRqRzV4ysUuZjKXJxdOiiS2YitJo1yC7mvw>
    <xmx:Je6SaJxkb9z34YQnWBpw8YvrqVJ_ScKpnfZ_eTTCoRxVhcLcNoDDvg>
    <xmx:Je6SaHDZOS4LG9O5NRxIcS6U4ga-PlI4uDrY72c-bTwscqjo4_Wt8POJ>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 6 Aug 2025 01:54:44 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id a985ab3e (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Wed, 6 Aug 2025 05:54:43 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Wed, 06 Aug 2025 07:54:18 +0200
Subject: [PATCH v6 7/9] refs/files: detect race when generating reflog
 entry for HEAD
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250806-pks-reflog-append-v6-7-a50839653766@pks.im>
References: <20250806-pks-reflog-append-v6-0-a50839653766@pks.im>
In-Reply-To: <20250806-pks-reflog-append-v6-0-a50839653766@pks.im>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>, 
 Justin Tobler <jltobler@gmail.com>, Junio C Hamano <gitster@pobox.com>, 
 =?utf-8?q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>, 
 Toon Claes <toon@iotcl.com>, Jeff King <peff@peff.net>, 
 Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>, 
 Ben Knoble <ben.knoble@gmail.com>, 
 =?utf-8?q?Jean-No=C3=ABl_AVILA?= <jn.avila@free.fr>
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
2.51.0.rc0.215.g125493bb4a.dirty

