Received: from fout-b2-smtp.messagingengine.com (fout-b2-smtp.messagingengine.com [202.12.124.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFF0E2E498E
	for <git@vger.kernel.org>; Tue, 22 Jul 2025 11:21:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753183291; cv=none; b=s1b5m+N8kJX81Oweh003s4P7RoFYw+AgtLOPyiV7Mg6+AA+Fel3BbKa/UTc0Ql/lwIph8Zgpht2ut7YmDffFBJCjpbRS32Ybjb7ywnQowl0L5S7RUJ9TSnhzVwleJfrxU5qnkz2BAJyOP6aRoxwxl+RuWL57RiSCfunwK0Ihiuw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753183291; c=relaxed/simple;
	bh=Cf58jLuS5pM78N1qRblgoihsrR89HfLLytmVUVZubiI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=XZ2GQxB11CcRzhNyjotv/SUZrc+BReW75kTlisRD5ax8UpLpXQr8CDR9wq0XsAOQQIDpXq+lRx3uIP9+1BlGWaH0JJdll6CDFpqKk4BmWoxJbFUjOYPZeAIaCcjr01dILRmAbQHInifLNmVTZ5LAARtqAR/mAd6J/2ogV803Xcw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=dCwX7taR; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=HnHIqgHd; arc=none smtp.client-ip=202.12.124.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="dCwX7taR";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="HnHIqgHd"
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfout.stl.internal (Postfix) with ESMTP id CB2621D0020E;
	Tue, 22 Jul 2025 07:21:28 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Tue, 22 Jul 2025 07:21:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1753183288;
	 x=1753269688; bh=/oLn7MVz4X0jWIdHno2XpgCt189NdqlnMWDL5bV4kkE=; b=
	dCwX7taRN4tiJfN3jryGkcMosDc4aNnAjj7KWkeRhkTmuCzrHMf/lFXuR24L2Jv/
	Tc8/eyTqMqKLOF8BI75ehTlo+zWa9BP4FImOfYfLg5rnBaJy2haLMotSyyWc7kUV
	fmdpsWX+XT+r+WZA/WsYTgq8E8+iwoWP4+BkURNGazbKOpJSorVhzZIPatKmqxYO
	CtW0O98R1Y9Pn0dZaF+QFTRCbyAQ5J5hO9lcrpg6N8cCV7imfBhyhCmNnQ220m/4
	BqWft1gmyhLZ6vXhynqSbk9+WbmAB7O/JVu3hv5J+WC+b/1CkdtyUAJe9N1wsq/P
	zVavNsmW2Klmliu7aM1w2A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1753183288; x=
	1753269688; bh=/oLn7MVz4X0jWIdHno2XpgCt189NdqlnMWDL5bV4kkE=; b=H
	nHIqgHdy8OuVQoJlVFhfHw//RFWwjq0RPo4by6lADvfRy8IeMduHd/1ST6yregf1
	Z6KT4EBoNjF8eykQxc5LpEJSmsHG+CjVh8cuXSV8Cc7sC0Xl8RMAp51UFVhR+hBi
	xso97dWle4shQnzWHfYpoLbuOJD4qLZwPVHqp2LgqZSKnPs9HjxteT6IPQSIBZZQ
	AjNZhStIK665XJi7Atu4J3QOusrCArjyc0Vaw9RKgU7+9Bjmw+FHKSEn3IenX49z
	gSnYnsLv0uEO8c3FP1VMdMO3q0m6RHVE1dSf7z9pi8YtSkAMPV+hVXLfJyNhUYZk
	5oHHWNMHWdHgqRLijnTCA==
X-ME-Sender: <xms:OHR_aCSIJW-jLXAmmnyzZbG0VJtn3Lwf-N16fbTiAkdFrUFnoJ3o4w>
    <xme:OHR_aH9FxPhsvk1PpI_7Ph_HliBqDUDn04vw7-xOQoNp0aUrWNbY4PMwI7Che0lAK
    4BQzPlLdAgshh3KCg>
X-ME-Received: <xmr:OHR_aBr675yBf4hL1QSNiflb2s6LZhcDzZ7BMAoB5bwgMswQkT2m4sPp1rNelgezH5ulTgx0SZWoVWCkpgcdremX5EtogrGeNTAKRNq_0Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdejgeejiecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhfffugggtgffkfhgjvfevofesthejredtredtjeenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epffeuiedujedvkeehuedvkeefffeivdeuleetkeduheejteekgedvudfgtdfgieelnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimhdpnhgspghrtghpthhtohepvddpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehkrghrthhhih
    hkrddukeeksehgmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:OHR_aMlWn3KRn4K30OxlbWv0-VMXZzDxvr2no0M4rTucECEdatQJJQ>
    <xmx:OHR_aAJ1tOJN89UwBAYgN0UJTxIyj-n3T9P1ghFPrTzgDobq_AcB0g>
    <xmx:OHR_aJxQYh3HEBBBCOo1BCbQZDLwjWhVa05HCZDavnOrThittlcxPw>
    <xmx:OHR_aAty6iC1j2mF6PWBIRPNo-fcUeS472MIQznW15pXNHZfio1slg>
    <xmx:OHR_aDj3imai1uo6iEWZWTm_MHf8m0c-tDY0X_5fie4uNpS9fx2ll9sL>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 22 Jul 2025 07:21:27 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 1f0f27de (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Tue, 22 Jul 2025 11:21:27 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Tue, 22 Jul 2025 13:20:57 +0200
Subject: [PATCH 8/8] refs: fix invalid old object IDs when migrating
 reflogs
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250722-pks-reflog-append-v1-8-183e5949de16@pks.im>
References: <20250722-pks-reflog-append-v1-0-183e5949de16@pks.im>
In-Reply-To: <20250722-pks-reflog-append-v1-0-183e5949de16@pks.im>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>
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
 t/t1460-refs-migrate.sh | 22 +++++++++++++++-------
 5 files changed, 54 insertions(+), 10 deletions(-)

diff --git a/refs.c b/refs.c
index c78d5be6e20..3d07ead92cb 100644
--- a/refs.c
+++ b/refs.c
@@ -1376,7 +1376,8 @@ int ref_transaction_update_reflog(struct ref_transaction *transaction,
 
 	assert(err);
 
-	flags = REF_HAVE_OLD | REF_HAVE_NEW | REF_LOG_ONLY | REF_FORCE_CREATE_REFLOG | REF_NO_DEREF;
+	flags = REF_HAVE_OLD | REF_HAVE_NEW | REF_LOG_ONLY | REF_FORCE_CREATE_REFLOG | REF_NO_DEREF |
+		REF_LOG_USE_PROVIDED_OIDS;
 
 	if (!transaction_refname_valid(refname, new_oid, flags, err))
 		return -1;
diff --git a/refs.h b/refs.h
index 0faf3bc0422..8e5416178ae 100644
--- a/refs.h
+++ b/refs.h
@@ -759,13 +759,20 @@ struct ref_transaction *ref_store_transaction_begin(struct ref_store *refs,
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
index d519bb615fa..3ebe0323d4e 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -2976,6 +2976,20 @@ static int parse_and_write_reflog(struct files_ref_store *refs,
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
@@ -2993,7 +3007,7 @@ static int parse_and_write_reflog(struct files_ref_store *refs,
 		}
 	}
 
-	if (files_log_ref_write(refs, lock->ref_name, &lock->old_oid,
+	if (files_log_ref_write(refs, lock->ref_name, old_oid,
 				&update->new_oid, update->committer_info,
 				update->msg, update->flags, err)) {
 		char *old_msg = strbuf_detach(err, NULL);
diff --git a/refs/reftable-backend.c b/refs/reftable-backend.c
index 44af58ac50b..99fafd75ebe 100644
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
diff --git a/t/t1460-refs-migrate.sh b/t/t1460-refs-migrate.sh
index 2ab97e1b7df..8191b08a79c 100755
--- a/t/t1460-refs-migrate.sh
+++ b/t/t1460-refs-migrate.sh
@@ -7,6 +7,17 @@ export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
 . ./test-lib.sh
 
+print_all_reflog_entries () {
+	repo=$1 &&
+	test-tool -C "$repo" ref-store main for-each-reflog >reflogs &&
+	cat reflogs | while read reflog
+	do
+		echo "REFLOG: $reflog" &&
+		test-tool -C "$repo" ref-store main for-each-reflog-ent "$reflog" ||
+		return 1
+	done
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
2.50.1.465.gcb3da1c9e6.dirty

