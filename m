Received: from fout-b3-smtp.messagingengine.com (fout-b3-smtp.messagingengine.com [202.12.124.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E8F72627E7
	for <git@vger.kernel.org>; Tue, 25 Feb 2025 08:56:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740473768; cv=none; b=bIKP5mUteKIQczDhW4IxWasnxHxhJZOgLPmyNzrmCujPZ7WBuRwWmyda56ryl5V0pXH+FrV+i5PiFip8aGnew/v7dVGpqnBk0wgkqmtHIzs/KCbM6z0SNTiCa6uk4Jr/3gHaL+aNutoAwqEs7xxZ9zW76/rhAprzv7f1N1RO9Ac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740473768; c=relaxed/simple;
	bh=KGTDvgzWCy7V387a7wy3u8LPigTMU8ilVO1TKMlmgU8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=AMa/BXVyoYdI6LAhx9ORt4OT3oT4UEf4RsJrPsjq7jeJHdNw+85LBY814g9CK5JNlQh2go0OLhMoIqD1y2MjGGqGzbmPHRgU1PIBuTe9XgbNHhY3iinChvqcQOTkgRvXDAc0z6a8DBW+t+/tK0o55Iz6E9QP0kJuwoK1ok486KU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=ahV9vr4o; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=zl96Jb0x; arc=none smtp.client-ip=202.12.124.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="ahV9vr4o";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="zl96Jb0x"
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfout.stl.internal (Postfix) with ESMTP id B801A114018B;
	Tue, 25 Feb 2025 03:56:05 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Tue, 25 Feb 2025 03:56:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1740473765;
	 x=1740560165; bh=xDmwmr6/7jhpS/UjG+ExVyaJO2nAf5QK1uRkK0aZvQI=; b=
	ahV9vr4o7+vGxz0IvPchkBRan0YbT9r3edurjC4gFPBF8RHmhJRy2tIom0fCJvsw
	40smyWMV1kTMiIOuNxtgWTgMRa+Hl7m9HFbsnrlBPnenJ9eYWKcFsX+JKqJBuGiW
	RpEGgVpM1Xqb/FIGFfCoW5HGieXpiuHEqaqeKn8RzHY5sROipaGPvdC18QiEpmy0
	4cXy99thGYrcro4YDyqYRvz4FIg428QeGW303K0E9S58ibuXcAtcL90YxinGlrsl
	PqWTQIm4MQ7sDhR5a0fCef90X+7jm9A/Jh11bKrMxdW/IGmI68Y+8m3YkumlhE7q
	cECuUVWbA3C87wc9C8jOxw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1740473765; x=
	1740560165; bh=xDmwmr6/7jhpS/UjG+ExVyaJO2nAf5QK1uRkK0aZvQI=; b=z
	l96Jb0xPG6sQ0D+v8ql4BSavrdfGiDAYQBXCpO2ggnlwiluJ3VS854PTO1Hiwb0W
	PvuQQkjb0u7jdYWmhI6iAaY0N5p1TsdX3AwiEfmHBOzl7Wb4WLeTDY1+d/17/3AK
	r9V0gKttnECin2Dn/QVUq3DhaS9S00UR06Gl4wDl456AGDtmlG4Lw89CGKkAPDOp
	pvJ1M0BejM+3tUu2nWIjY75ixgK3I1lPbAG30Hzu4SVgzLJBLn7XwAB7+xffhLjq
	gpz7MWKf7/m5sQ+nwwqi4XnWymMgarHmUAfaEm9MR1Hz5+ILNXVlVOhjerjENVzy
	G5UJ23CJz1TF115DCpU0g==
X-ME-Sender: <xms:pYW9Z3TjCuT2cHFkGR4U-Qk4rlGuEu4Sj8DnAqPN8r4_OG6Ygywm1Q>
    <xme:pYW9Z4ws42_FlaM-oDdYvryij4Ng7wd64w7U6-peV1tWzKTv4wfig81Vjza5S9qeb
    b8lW9xO-HiyApzOOQ>
X-ME-Received: <xmr:pYW9Z80XMC5L340Fkcy8qfHKK3At7hJh7wePxOKCAlnBU065qnhFyeDH56il3TxttqCXw6p4lx8nF0zEpXbGOiVTu3BHbB16ZwVSNFmJNJguzg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdekuddvkecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhfffugggtgffkfhgjvfevofesthejredtredt
    jeenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrd
    himheqnecuggftrfgrthhtvghrnhepffeuiedujedvkeehuedvkeefffeivdeuleetkedu
    heejteekgedvudfgtdfgieelnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpe
    hmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepjedpmhhouggv
    pehsmhhtphhouhhtpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomhdprh
    gtphhtthhopehpvghffhesphgvfhhfrdhnvghtpdhrtghpthhtoheptghhrhhishgtohho
    lhesthhugihfrghmihhlhidrohhrghdprhgtphhtthhopehkrghrthhhihhkrddukeekse
    hgmhgrihhlrdgtohhmpdhrtghpthhtohepshgrnhgurghlshestghruhhsthihthhoohht
    hhhprghsthgvrdhnvghtpdhrtghpthhtohepshhhvghjihgrlhhuohesghhmrghilhdrtg
    homhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:pYW9Z3C8u9uAC3qZ0EQX_xhz2Jbkn69qcvu4PbcGYWnKjjgoFwrg4g>
    <xmx:pYW9Zwigv03zK1ivrHVQe1dnrQICe0mv_Ruxi-zN2I8ImmDK9S9mcA>
    <xmx:pYW9Z7rvpDwj1GDugmWAgm16nh0vMW3TJmeUi0cQGBlb-eRSzqRSnQ>
    <xmx:pYW9Z7i_sL87lohCu7Kok2LHQaRPlfJD0QAYa2abLF8FLH_d_W9Ksw>
    <xmx:pYW9Z8jx4NDah30RfrtEyUaMEpv5uqOIjq93tkHwk6DM7SuS7qt-yOYk>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 25 Feb 2025 03:56:03 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 4c456794 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 25 Feb 2025 08:56:01 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Tue, 25 Feb 2025 09:55:52 +0100
Subject: [PATCH v3 06/16] refs/files: batch refname availability checks for
 normal transactions
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250225-pks-update-ref-optimization-v3-6-77c3687cda75@pks.im>
References: <20250225-pks-update-ref-optimization-v3-0-77c3687cda75@pks.im>
In-Reply-To: <20250225-pks-update-ref-optimization-v3-0-77c3687cda75@pks.im>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>, 
 "brian m. carlson" <sandals@crustytoothpaste.net>, 
 Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>, 
 shejialuo <shejialuo@gmail.com>, Christian Couder <chriscool@tuxfamily.org>
X-Mailer: b4 0.14.2

Same as the "reftable" backend that we have adapted in the preceding
commit to use batched refname availability checks we can also do so for
the "files" backend. Things are a bit more intricate here though, as we
call `refs_verify_refname_available()` in a set of different contexts:

  1. `lock_raw_ref()` when it hits either EEXISTS or EISDIR when creating
     a new reference, mostly to create a nice, user-readable error
     message. This is nothing we have to care about too much, as we only
     hit this code path at most once when we hit a conflict.

  2. `lock_raw_ref()` when it _could_ create the lockfile to check
     whether it is conflicting with any packed refs. In the general case,
     this code path will be hit once for every (successful) reference
     update.

  3. `lock_ref_oid_basic()`, but it is only executed when copying or
     renaming references or when expiring reflogs. It will thus not be
     called in contexts where we have many references queued up.

  4. `refs_refname_ref_available()`, but again only when copying or
     renaming references. It is thus not interesting due to the same
     reason as the previous case.

  5. `files_transaction_finish_initial()`, which is only executed when
     creating a new repository or migrating references.

So out of these, only (2) and (5) are viable candidates to use the
batched checks.

Adapt `lock_raw_ref()` accordingly by queueing up reference names that
need to be checked for availability and then checking them after we have
processed all updates. This check is done before we (optionally) lock
the `packed-refs` file, which is somewhat flawed because it means that
the `packed-refs` could still change after the availability check and
thus create an undetected conflict. But unconditionally locking the file
would change semantics that users are likely to rely on, so we keep the
current locking sequence intact, even if it's suboptmial.

The refactoring of `files_transaction_finish_initial()` will be done in
the next commit.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 refs/files-backend.c | 42 +++++++++++++++++++++++++++++++-----------
 1 file changed, 31 insertions(+), 11 deletions(-)

diff --git a/refs/files-backend.c b/refs/files-backend.c
index 29f08dced40..6ce79cf0791 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -678,6 +678,7 @@ static void unlock_ref(struct ref_lock *lock)
  */
 static int lock_raw_ref(struct files_ref_store *refs,
 			const char *refname, int mustexist,
+			struct string_list *refnames_to_check,
 			const struct string_list *extras,
 			struct ref_lock **lock_p,
 			struct strbuf *referent,
@@ -855,16 +856,11 @@ static int lock_raw_ref(struct files_ref_store *refs,
 		}
 
 		/*
-		 * If the ref did not exist and we are creating it,
-		 * make sure there is no existing packed ref that
-		 * conflicts with refname:
+		 * If the ref did not exist and we are creating it, we have to
+		 * make sure there is no existing packed ref that conflicts
+		 * with refname. This check is deferred so that we can batch it.
 		 */
-		if (refs_verify_refname_available(
-				    refs->packed_ref_store, refname,
-				    extras, NULL, 0, err)) {
-			ret = TRANSACTION_NAME_CONFLICT;
-			goto error_return;
-		}
+		string_list_insert(refnames_to_check, refname);
 	}
 
 	ret = 0;
@@ -2569,6 +2565,7 @@ static int lock_ref_for_update(struct files_ref_store *refs,
 			       struct ref_update *update,
 			       struct ref_transaction *transaction,
 			       const char *head_ref,
+			       struct string_list *refnames_to_check,
 			       struct string_list *affected_refnames,
 			       struct strbuf *err)
 {
@@ -2597,7 +2594,7 @@ static int lock_ref_for_update(struct files_ref_store *refs,
 		lock->count++;
 	} else {
 		ret = lock_raw_ref(refs, update->refname, mustexist,
-				   affected_refnames,
+				   refnames_to_check, affected_refnames,
 				   &lock, &referent,
 				   &update->type, err);
 		if (ret) {
@@ -2811,6 +2808,7 @@ static int files_transaction_prepare(struct ref_store *ref_store,
 	size_t i;
 	int ret = 0;
 	struct string_list affected_refnames = STRING_LIST_INIT_NODUP;
+	struct string_list refnames_to_check = STRING_LIST_INIT_NODUP;
 	char *head_ref = NULL;
 	int head_type;
 	struct files_transaction_backend_data *backend_data;
@@ -2898,7 +2896,8 @@ static int files_transaction_prepare(struct ref_store *ref_store,
 		struct ref_update *update = transaction->updates[i];
 
 		ret = lock_ref_for_update(refs, update, transaction,
-					  head_ref, &affected_refnames, err);
+					  head_ref, &refnames_to_check,
+					  &affected_refnames, err);
 		if (ret)
 			goto cleanup;
 
@@ -2930,6 +2929,26 @@ static int files_transaction_prepare(struct ref_store *ref_store,
 		}
 	}
 
+	/*
+	 * Verify that none of the loose reference that we're about to write
+	 * conflict with any existing packed references. Ideally, we'd do this
+	 * check after the packed-refs are locked so that the file cannot
+	 * change underneath our feet. But introducing such a lock now would
+	 * probably do more harm than good as users rely on there not being a
+	 * global lock with the "files" backend.
+	 *
+	 * Another alternative would be to do the check after the (optional)
+	 * lock, but that would extend the time we spend in the globally-locked
+	 * state.
+	 *
+	 * So instead, we accept the race for now.
+	 */
+	if (refs_verify_refnames_available(refs->packed_ref_store, &refnames_to_check,
+					   &affected_refnames, NULL, 0, err)) {
+		ret = TRANSACTION_NAME_CONFLICT;
+		goto cleanup;
+	}
+
 	if (packed_transaction) {
 		if (packed_refs_lock(refs->packed_ref_store, 0, err)) {
 			ret = TRANSACTION_GENERIC_ERROR;
@@ -2972,6 +2991,7 @@ static int files_transaction_prepare(struct ref_store *ref_store,
 cleanup:
 	free(head_ref);
 	string_list_clear(&affected_refnames, 0);
+	string_list_clear(&refnames_to_check, 0);
 
 	if (ret)
 		files_transaction_cleanup(refs, transaction);

-- 
2.48.1.683.gf705b3209c.dirty

