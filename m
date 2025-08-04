Received: from fhigh-b8-smtp.messagingengine.com (fhigh-b8-smtp.messagingengine.com [202.12.124.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C06D248F63
	for <git@vger.kernel.org>; Mon,  4 Aug 2025 09:46:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754300803; cv=none; b=SaO46KSvq33S51EjZ+WJn591V3AoQI8qZVPXMtOb1Nr/SVm5tEUpFs5MxrzmC41qQAslEsPDHiQRE/N0PLaCaVn0od9jPQa5JcrWrIFp5Wj1y0vs7eHYkqYrqsXTBgSif4ieeia1CuErBWWpFR0ewgn53Z3z9IiLQCAOfKI20wg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754300803; c=relaxed/simple;
	bh=GgLzuHTtzt2RSbZ5LFUVRY9scWEGjmCHQJsJhJhHjPE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=mXLK3rL4/MQz2sPWn0aRgfWWgj6sSlD+94K3hyAN12vac7o4f1AAHzqGVXBHsqndACFSpYPAXTagbM3v0Kl935d6XdF9n0N6HJDnodEgHbkd5gEBcetePEPjPePQOqUp9xOPDCrINtF0seQXFzEoxW2UtIlW/1cFxg75dc9pPIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=KeDIU06O; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=jwahAMCX; arc=none smtp.client-ip=202.12.124.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="KeDIU06O";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="jwahAMCX"
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 5E6157A00C1;
	Mon,  4 Aug 2025 05:46:40 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Mon, 04 Aug 2025 05:46:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1754300800;
	 x=1754387200; bh=FRg6VBSL46UaIBJirtKMimnVgo1kUKEP+2QBPGTSqLI=; b=
	KeDIU06Opd58irFOL53YGueKH/APm4knIcQ3PAhVm2OcPYgTbFdk7qgvQ0qQMiZW
	a9NGk+Sp1Nc6OseWX7QrLbwO+OQ+BUpOOPeT437ofgYpxAKns/nONxbeEkHbQD/+
	3inM5OMlUONJhqHgpDPrPEGNzCy3J6qLWB2pnxoeEslneYMsUUC8uMjV0A2HIXG5
	KpLQkaGfhkCPNBs496bYvoBmD1CwvQTBdFTo2j1Ysl87ZJNR/T5ONq32bXcqfw8d
	Ur/BN0RKmvz77xbAm3mWg20TDyl1GObNRL0PhlBB3VK9lqja8HxHcmVp0vSXo+sH
	gmVZSlWZxGT9Cm5ECSKejA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1754300800; x=
	1754387200; bh=FRg6VBSL46UaIBJirtKMimnVgo1kUKEP+2QBPGTSqLI=; b=j
	wahAMCXZzSa3Rl8egLj6Ggluy7FNnlG6QvhFABVUkg/ZA7dkAdCEvMJw4kp/k5Ku
	uY4JtIO8Uey7sIBm6YpyphmUMHCoVkpnudwwWG+qLFwgxbh4F6A3H2IIG9WPCdUY
	db88Q+htOiXkHI6bRNY6AP0pBSenm7W7vHDoNx09P9FqWzM099ZRhT2auhZ+tFzO
	yO4nZLhO2bmrzWlxgdWy1A8NVME387VHDecwltAfvJ2yawLDlEg7FCztPAaSykR2
	y6EjXXxdNN0sEefs6Y2Od+yPc6/MsuRDUTB718V+WfXifQppoWayHmbvkGccvF69
	whF2BkeM7eD/aCy/8OCYw==
X-ME-Sender: <xms:gIGQaPp0T43DS8_x0RB7Nq77kid_oZAibdfj34ifrJOQdgSsNoETEQ>
    <xme:gIGQaGg_g7f6Ibyx_bgOJKmE9fgIulLqrrzSi47IcACD--6BNDb2Us1ql3XYcl-ml
    4itNY0TpNor0Klxow>
X-ME-Received: <xmr:gIGQaL8kRr-fwUEq8q6lqkbGvNI16JgG3j8almERNrU0fnOfYlFzNYBDeO_c0TEOFx6U1CS5GmpP6wmma8E7vlaZXrGs9rEI8AGaWNeP4Dk>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdduudduleejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeffueeiudejvdekheeuvdekfeffiedvueelteekudehjeetkeegvddugfdtgfeileen
    ucevlhhushhtvghrufhiiigvpedunecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhmpdhnsggprhgtphhtthhopeelpdhmohguvgepshhmthhpohhuthdprhgtphht
    thhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepkhgrrhhthh
    hikhdrudekkeesghhmrghilhdrtghomhdprhgtphhtthhopehsiigvuggvrhdruggvvhes
    ghhmrghilhdrtghomhdprhgtphhtthhopegsvghnrdhknhhosghlvgesghhmrghilhdrtg
    homhdprhgtphhtthhopehtohhonhesihhothgtlhdrtghomhdprhgtphhtthhopehgihht
    shhtvghrsehpohgsohigrdgtohhmpdhrtghpthhtohepjhhlthhosghlvghrsehgmhgrih
    hlrdgtohhmpdhrtghpthhtohepkhhrihhsthhofhhfvghrhhgruhhgshgsrghkkhesfhgr
    shhtmhgrihhlrdgtohhmpdhrtghpthhtohepphgvfhhfsehpvghffhdrnhgvth
X-ME-Proxy: <xmx:gIGQaCVvdXmGWWny1SVNSeZDqXvbx0jDlahrVKO98C_1J0OoFhcyzw>
    <xmx:gIGQaPBGmdZhKhutDQ5U0KN9K4-aRWi_jYmlUAjJImCF3QBiyS8JvQ>
    <xmx:gIGQaHHQRWPhBlve9UOlM9Ve1VI5WwWZSf_kpbEhHMuR4dYbnV_SeA>
    <xmx:gIGQaA4t95uRqg6zehJklIiWsw_oFPrWGkdLY0h3F304pNwZM_19Tg>
    <xmx:gIGQaFcYkQi6QZ9Vpc3S9UOPtXa8t-gwyLzp5rUYTyfASSdC0GbrdaCG>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 4 Aug 2025 05:46:38 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 6e28ab07 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Mon, 4 Aug 2025 09:46:38 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Mon, 04 Aug 2025 11:46:09 +0200
Subject: [PATCH v4 9/9] refs: fix invalid old object IDs when migrating
 reflogs
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250804-pks-reflog-append-v4-9-13213fef7200@pks.im>
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

When migrating reflog entries between different storage formats we end
up with invalid old object IDs for the migrated entries: instead of
writing the old object ID of the to-be-migrated entry, we end up with
the all-zeroes object ID.

The root cause of this issue is that we don't know to use the old object
ID provided by the caller. Instead, we manually resolve the old object
ID by resolving the current value of its matching reference. But as that
reference does not yet exist in the target ref storage we always end up
resolving it to all-zeroes.

This issue got unnoticed as there is no user-facing command that would
even show the old object ID. While `git log -g` knows to show the new
object ID, we don't have any formatting directive to show the old object
ID.

Fix the bug by introducing a new flag `REF_LOG_USE_PROVIDED_OIDS`. If
set, backends are instructed to use the old and new object IDs provided
by the caller, without doing any manual resolving. Set this flag in
`ref_transaction_update_reflog()`.

Amend our tests in t1460-refs-migrate to use our test tool to read
reflog entries. This test tool prints out both old and new object ID of
each reflog entry, which fixes the test gap. Furthermore it also prints
the full identity used to write the reflog, which provides test coverage
for the previous commit in this patch series that fixed the identity for
migrated reflogs.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 refs.c                  |  3 ++-
 refs.h                  |  9 ++++++++-
 refs/files-backend.c    | 16 +++++++++++++++-
 refs/reftable-backend.c | 14 ++++++++++++++
 t/t1421-reflog-write.sh |  4 +---
 t/t1460-refs-migrate.sh | 22 +++++++++++++++-------
 6 files changed, 55 insertions(+), 13 deletions(-)

diff --git a/refs.c b/refs.c
index f88928de74..946eb48941 100644
--- a/refs.c
+++ b/refs.c
@@ -1385,7 +1385,8 @@ int ref_transaction_update_reflog(struct ref_transaction *transaction,
 
 	assert(err);
 
-	flags = REF_HAVE_OLD | REF_HAVE_NEW | REF_LOG_ONLY | REF_FORCE_CREATE_REFLOG | REF_NO_DEREF;
+	flags = REF_HAVE_OLD | REF_HAVE_NEW | REF_LOG_ONLY | REF_FORCE_CREATE_REFLOG | REF_NO_DEREF |
+		REF_LOG_USE_PROVIDED_OIDS;
 
 	if (!transaction_refname_valid(refname, new_oid, flags, err))
 		return -1;
diff --git a/refs.h b/refs.h
index 253dd8f4d5..090b4fdff4 100644
--- a/refs.h
+++ b/refs.h
@@ -760,13 +760,20 @@ struct ref_transaction *ref_store_transaction_begin(struct ref_store *refs,
  */
 #define REF_SKIP_CREATE_REFLOG (1 << 12)
 
+/*
+ * When writing a REF_LOG_ONLY record, use the old and new object IDs provided
+ * in the update instead of resolving the old object ID. The caller must also
+ * set both REF_HAVE_OLD and REF_HAVE_NEW.
+ */
+#define REF_LOG_USE_PROVIDED_OIDS (1 << 13)
+
 /*
  * Bitmask of all of the flags that are allowed to be passed in to
  * ref_transaction_update() and friends:
  */
 #define REF_TRANSACTION_UPDATE_ALLOWED_FLAGS                                  \
 	(REF_NO_DEREF | REF_FORCE_CREATE_REFLOG | REF_SKIP_OID_VERIFICATION | \
-	 REF_SKIP_REFNAME_VERIFICATION | REF_SKIP_CREATE_REFLOG)
+	 REF_SKIP_REFNAME_VERIFICATION | REF_SKIP_CREATE_REFLOG | REF_LOG_USE_PROVIDED_OIDS)
 
 /*
  * Add a reference update to transaction. `new_oid` is the value that
diff --git a/refs/files-backend.c b/refs/files-backend.c
index c37fbfd138..851b1b33f4 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -3026,6 +3026,20 @@ static int parse_and_write_reflog(struct files_ref_store *refs,
 				  struct ref_lock *lock,
 				  struct strbuf *err)
 {
+	struct object_id *old_oid = &lock->old_oid;
+
+	if (update->flags & REF_LOG_USE_PROVIDED_OIDS) {
+		if (!(update->flags & REF_HAVE_OLD) ||
+		    !(update->flags & REF_HAVE_NEW) ||
+		    !(update->flags & REF_LOG_ONLY)) {
+			strbuf_addf(err, _("trying to write reflog for '%s'"
+					   "with incomplete values"), update->refname);
+			return REF_TRANSACTION_ERROR_GENERIC;
+		}
+
+		old_oid = &update->old_oid;
+	}
+
 	if (update->new_target) {
 		/*
 		 * We want to get the resolved OID for the target, to ensure
@@ -3043,7 +3057,7 @@ static int parse_and_write_reflog(struct files_ref_store *refs,
 		}
 	}
 
-	if (files_log_ref_write(refs, lock->ref_name, &lock->old_oid,
+	if (files_log_ref_write(refs, lock->ref_name, old_oid,
 				&update->new_oid, update->committer_info,
 				update->msg, update->flags, err)) {
 		char *old_msg = strbuf_detach(err, NULL);
diff --git a/refs/reftable-backend.c b/refs/reftable-backend.c
index 44af58ac50..99fafd75eb 100644
--- a/refs/reftable-backend.c
+++ b/refs/reftable-backend.c
@@ -1096,6 +1096,20 @@ static enum ref_transaction_error prepare_single_update(struct reftable_ref_stor
 	if (ret)
 		return REF_TRANSACTION_ERROR_GENERIC;
 
+	if (u->flags & REF_LOG_USE_PROVIDED_OIDS) {
+		if (!(u->flags & REF_HAVE_OLD) ||
+		    !(u->flags & REF_HAVE_NEW) ||
+		    !(u->flags & REF_LOG_ONLY)) {
+			strbuf_addf(err, _("trying to write reflog for '%s'"
+					   "with incomplete values"), u->refname);
+			return REF_TRANSACTION_ERROR_GENERIC;
+		}
+
+		if (queue_transaction_update(refs, tx_data, u, &u->old_oid, err))
+			return REF_TRANSACTION_ERROR_GENERIC;
+		return 0;
+	}
+
 	/* Verify that the new object ID is valid. */
 	if ((u->flags & REF_HAVE_NEW) && !is_null_oid(&u->new_oid) &&
 	    !(u->flags & REF_SKIP_OID_VERIFICATION) &&
diff --git a/t/t1421-reflog-write.sh b/t/t1421-reflog-write.sh
index dd7ffa5241..46df64c176 100755
--- a/t/t1421-reflog-write.sh
+++ b/t/t1421-reflog-write.sh
@@ -101,11 +101,9 @@ test_expect_success 'simple writes' '
 		EOF
 
 		git reflog write refs/heads/something $COMMIT_OID $COMMIT_OID second &&
-		# Note: the old object ID of the second reflog entry is broken.
-		# This will be fixed in subsequent commits.
 		test_reflog_matches . refs/heads/something <<-EOF
 		$ZERO_OID $COMMIT_OID $SIGNATURE	first
-		$ZERO_OID $COMMIT_OID $SIGNATURE	second
+		$COMMIT_OID $COMMIT_OID $SIGNATURE	second
 		EOF
 	)
 '
diff --git a/t/t1460-refs-migrate.sh b/t/t1460-refs-migrate.sh
index 2ab97e1b7d..0e1116a319 100755
--- a/t/t1460-refs-migrate.sh
+++ b/t/t1460-refs-migrate.sh
@@ -7,6 +7,17 @@ export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
 . ./test-lib.sh
 
+print_all_reflog_entries () {
+	repo=$1 &&
+	test-tool -C "$repo" ref-store main for-each-reflog >reflogs &&
+	while read reflog
+	do
+		echo "REFLOG: $reflog" &&
+		test-tool -C "$repo" ref-store main for-each-reflog-ent "$reflog" ||
+		return 1
+	done <reflogs
+}
+
 # Migrate the provided repository from one format to the other and
 # verify that the references and logs are migrated over correctly.
 # Usage: test_migration <repo> <format> [<skip_reflog_verify> [<options...>]]
@@ -28,8 +39,7 @@ test_migration () {
 		--format='%(refname) %(objectname) %(symref)' >expect &&
 	if ! $skip_reflog_verify
 	then
-	   git -C "$repo" reflog --all >expect_logs &&
-	   git -C "$repo" reflog list >expect_log_list
+		print_all_reflog_entries "$repo" >expect_logs
 	fi &&
 
 	git -C "$repo" refs migrate --ref-format="$format" "$@" &&
@@ -39,10 +49,8 @@ test_migration () {
 	test_cmp expect actual &&
 	if ! $skip_reflog_verify
 	then
-		git -C "$repo" reflog --all >actual_logs &&
-		git -C "$repo" reflog list >actual_log_list &&
-		test_cmp expect_logs actual_logs &&
-		test_cmp expect_log_list actual_log_list
+		print_all_reflog_entries "$repo" >actual_logs &&
+		test_cmp expect_logs actual_logs
 	fi &&
 
 	git -C "$repo" rev-parse --show-ref-format >actual &&
@@ -273,7 +281,7 @@ test_expect_success 'multiple reftable blocks with multiple entries' '
 	test_commit -C repo second &&
 	printf "update refs/heads/ref-%d HEAD\n" $(test_seq 3000) >stdin &&
 	git -C repo update-ref --stdin <stdin &&
-	test_migration repo reftable
+	test_migration repo reftable true
 '
 
 test_expect_success 'migrating from files format deletes backend files' '

-- 
2.50.1.723.g3e08bea96f.dirty

