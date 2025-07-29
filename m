Received: from fhigh-b8-smtp.messagingengine.com (fhigh-b8-smtp.messagingengine.com [202.12.124.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C0B4285C98
	for <git@vger.kernel.org>; Tue, 29 Jul 2025 08:55:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753779352; cv=none; b=nogIpOx4YM4DLGgH8pC/HndFpX/tRmYRPM/iS4lBr/ySITN7qLIL6srfJlZfKRcqYw7KcAmvNXCmPvbHM4PPT9eaSVhFZ4WsQe2BOpYdsBKarUENLZw1PG9BI69Gu6pf0H+b7REO7L//LVpivtaMxAL52ZWtb3nacN1qJVvOQFQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753779352; c=relaxed/simple;
	bh=KRW8QNFoneDjdRe6iWczxeISu5SWioEEryyYzWukosc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=XK97riGD3hkWEi7RwFv79viJy323A9tF/KkQ6RuIMiKOHR06imVwdRp8mqXfG/TM4ptrhCHTBvNLMKGr5KERvREWoMxT3tRT9lwxCn46wtQEmpPFaodEirYHovbhmgbzg7BUUnvRHkghAMI3slkQ4KYylVwEOhim6VsRkrN9uB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=g/+FIzof; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=iiWBg050; arc=none smtp.client-ip=202.12.124.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="g/+FIzof";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="iiWBg050"
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfhigh.stl.internal (Postfix) with ESMTP id A195B7A0454;
	Tue, 29 Jul 2025 04:55:49 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Tue, 29 Jul 2025 04:55:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1753779349;
	 x=1753865749; bh=VuxdkOOFmI/ahrYchFMLPC5sCjLr34T1VtKfAoPbW5w=; b=
	g/+FIzofpUV21H06M94Sz6AfwE70A4r5WQG6vsi3UxyWkMMv9ghTYvXrfofGfTLe
	UCKnvCCGkduVoSjcKc+y61WdVQpW5bxVPThxYTe6dMrlGyogsi90tI5bErJRxp6F
	Cxq6Jvvn3fqVBn7Eo+rtoj+LD4Xaqy7+mM+bXc7qJsRf3Ze9m6BZqL5pswzNJTQT
	JGXxid4eJe8Pvahk0HttWdMMCD/E6mMGXrfBH1u7fUKNaxkdUIG9AyRbX7/x+/E8
	qVi4vUflHJgPVqZ9PhqJJL45ySVMrhaO1Yrd/+7GCXgGsK3zsZyyZblpfgLZ235q
	RaHPCyDDRS87Nu6JTOLi/Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1753779349; x=
	1753865749; bh=VuxdkOOFmI/ahrYchFMLPC5sCjLr34T1VtKfAoPbW5w=; b=i
	iWBg0503PsvyJzEa7jtjZuSj31MBnao6wk5HOnnhOQOyYSYKMy2jo9MbbefCLpp7
	RJw1BBIq7DmmElo8bhYpumNg6bgpfVmYWtTpQyfWByDin4LB2IG2qgHI3NOe3hs7
	mpVah3i5PNgA2bRE/iSl0KmhXqyq+kXtZBF2iDWQ3FF4d2w6EQrg1knwJQIoKfRy
	FkaHA4aLHmKm3O+hY1JrZ1iSTHvqYegQ5+9k4klw1EAgp0nXYtTv3fLvh8B70qJJ
	tY7h4lfFF0LvXID5S1WvOE8L3e2kfIffLGrFItgyzGiHyKSRKQcW/Yj/tUuDJOVg
	WVAfJ6Sliaw0J4GXOHPoQ==
X-ME-Sender: <xms:lYyIaFIKsQ_AEY5Q7t86CXleN4D_TvEhnZ6kShxkkz4DCUuE1o2-HQ>
    <xme:lYyIaODlXOTJYJskLWOjRoS09xJDLaQvtvyXzwQvh_rOJNgHFddj0yqNKg3Tj8T-W
    vRj0xdaDNaD_i_HMQ>
X-ME-Received: <xmr:lYyIaNfVIeq40QUH5EF1EkRMSkpLLKnCdCcnAv-CQDKjhQWLrqUREYEW3xCoABGDef3EEr6uXGLhlkz_xYe72Tz9AbnnsPJbB6neHlKMD70>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdelgeeifecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhfffugggtgffkfhgjvfevofesthejredtredtjeenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epffeuiedujedvkeehuedvkeefffeivdeuleetkeduheejteekgedvudfgtdfgieelnecu
    vehluhhsthgvrhfuihiivgepvdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimhdpnhgspghrtghpthhtohepledpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepjhhlthhosghlvghrsehgmhgrihhlrdgtohhmpdhrtghpthhtohepshiivgguvghrrd
    guvghvsehgmhgrihhlrdgtohhmpdhrtghpthhtohepkhgrrhhthhhikhdrudekkeesghhm
    rghilhdrtghomhdprhgtphhtthhopehtohhonhesihhothgtlhdrtghomhdprhgtphhtth
    hopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepphgvfhhfsehp
    vghffhdrnhgvthdprhgtphhtthhopehkrhhishhtohhffhgvrhhhrghughhssggrkhhkse
    hfrghsthhmrghilhdrtghomhdprhgtphhtthhopegsvghnrdhknhhosghlvgesghhmrghi
    lhdrtghomhdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:lYyIaF1mOyxZFFbhbwnsCe59f9N5rPiwX9SNCVBDon4CltC6NMhM-g>
    <xmx:lYyIaMjZn0h_l59grv1H6iIGPLZ0IpW48FS-f4PH24uDrb-qkwmV5Q>
    <xmx:lYyIaGlmIIdiqFTfxWs3DWem6xnMzSKROmlM3vcdTYZOrp_ZqzlCnw>
    <xmx:lYyIaKbXZZM5FiDG6YKW3h04GX8ML5G3MgPVwdUwgEQ-9w1dTYFnMg>
    <xmx:lYyIaI8yerRoGFELiU_zu2xZ-dixAgH9WwuTf64ZsEPd1TcuFB4ifhoC>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 29 Jul 2025 04:55:47 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 717a31ee (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Tue, 29 Jul 2025 08:55:47 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Tue, 29 Jul 2025 10:55:25 +0200
Subject: [PATCH v3 7/9] refs/files: detect race when generating reflog
 entry for HEAD
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250729-pks-reflog-append-v3-7-9614d310f073@pks.im>
References: <20250729-pks-reflog-append-v3-0-9614d310f073@pks.im>
In-Reply-To: <20250729-pks-reflog-append-v3-0-9614d310f073@pks.im>
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

  - HEAD gets concurrently updated to point to not point to a reference
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
 refs/files-backend.c | 40 ++++++++++++++++++++++++++++++++++++++--
 1 file changed, 38 insertions(+), 2 deletions(-)

diff --git a/refs/files-backend.c b/refs/files-backend.c
index bf6f89b1d19..ba018b0984a 100644
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
2.50.1.619.g074bbf1d35.dirty

