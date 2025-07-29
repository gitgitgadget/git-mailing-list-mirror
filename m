Received: from fout-b3-smtp.messagingengine.com (fout-b3-smtp.messagingengine.com [202.12.124.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E08CD28724F
	for <git@vger.kernel.org>; Tue, 29 Jul 2025 08:55:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753779359; cv=none; b=EVUwD4PBKi+c7Xync8buGzLanIu6uMTYJ9FZQ0sXToDGvPwF1z3sZVQ9Hg2kvvV31o6iGFHSBm1syuZQY4K0AdtTKY2c2aoLNDCErnC8CGCNccd5nFYoV/m0ajz3yabeE7ym8YLIsaf29X4XN17UJa+4zAwo3MqLQYPygBfLySE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753779359; c=relaxed/simple;
	bh=8Z8AH62XsjCftMy/wK+Ai7ycKWr7X685X1ylmkIebqI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=AGgpmqJ0IrhgHdpPVFUmjaYuHZhAwThuCx1USShgk6nsxYdhiZPMBLt0JDcvjKA2mSYKmYwPoSr55DqHMiDEKwQ0YYuEM5ySlC7iGuE6NCp06frMoelby/4RMs7UeKAvgc64MxpdUK9ob88EMqSZdEB9tBMWu0vxSvGI0jwqZ6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=avPoRgzi; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=cdYP3Dib; arc=none smtp.client-ip=202.12.124.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="avPoRgzi";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="cdYP3Dib"
Received: from phl-compute-10.internal (phl-compute-10.phl.internal [10.202.2.50])
	by mailfout.stl.internal (Postfix) with ESMTP id F00601D005AF;
	Tue, 29 Jul 2025 04:55:56 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-10.internal (MEProxy); Tue, 29 Jul 2025 04:55:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1753779356;
	 x=1753865756; bh=8QVbC6hTmgALBQlnUZ21MHeymu9fGN4LNK1xwIVsgoY=; b=
	avPoRgzi+hvKo381m2nji0xeF1zPbh9M3ezVV7Q3FIqVxrI82c1y/L/DlnFXAFVG
	JzyCvCj30jw16ArC1w1rbHtIV/G/mw8pEyKnAeTUDSkAoa5cwmM85xxgLo9JD9+9
	2PSjUMbAoWDoRX8FTRA7AJ7YSITHt76V8iHGjtnb3irOyAsCGcDRdWozXfqbEHPh
	vVoZkH0hX/gM2jViHwO+I9Yr1/IA9ZrI706vZ3RpiHtJ+/UNj4TCUj9MYHfPS7pb
	G+dkzkvN5I8GOSFJwsO+BImsDeywDZlN3KzQx1xmryk0ckjPk4nIeCWoWgZ74bR1
	CJC5FABEB17cWtBN5dMqKg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1753779356; x=
	1753865756; bh=8QVbC6hTmgALBQlnUZ21MHeymu9fGN4LNK1xwIVsgoY=; b=c
	dYP3DibIzRPV81meFdqL9FqqA0m3nXP/ObmwzvisP0jSZDIMtcQj2Rq5OBCmoDmS
	Kff7VKJ4muzIeJjx86DIOk4CgVFOkwp5YaCU+BJAxgfwpTQPo6owXcsHW99Bt7Rf
	gCFnDQgZoBOIV03k7edIxaV5MGau/fYVr8Uk5XDEy6sNircToy3eI8xNnLLZvbLT
	+mloqmqDVIcdPC8NgrmodxywWhSLQHc3FWf1y+1XsaQ29XUZyFILMaQkKOkIJ1gO
	d4gn1Cyx4EN+iM5EG24ffIT64uK5QeMpUyl7MFja9tvWQwd9wUHXrCy9+oZb5/EQ
	1esugK1iIskWu3/STncSQ==
X-ME-Sender: <xms:nIyIaHR-p5tGhSAaNtQxJVHXBnrr_BpwNAGZftV7f2I2MmFpWjwRcQ>
    <xme:nIyIaFrk-nN0lHkOmSlBJZaXPjP758DXN-qzMwDZsdv3_VhITIlww5RugLWQ7T3dG
    JfNl9OjdKDrV0_r9g>
X-ME-Received: <xmr:nIyIaMnLgGf6IFqcKFhRKDFekoV-BNWhR4Z7lB71xljTi_NkZ22bZ-r2kjlDIFuGc6se1v23CCVamy6F1EOMrX1ylTh95FGIOSHEX5Q3jPU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdelgeeivdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhfffugggtgffkfhgjvfevofesthejredtredtjeenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epffeuiedujedvkeehuedvkeefffeivdeuleetkeduheejteekgedvudfgtdfgieelnecu
    vehluhhsthgvrhfuihiivgepudenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimhdpnhgspghrtghpthhtohepledpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepkhhrihhsthhofhhfvghrhhgruhhgshgsrghkkhesfhgrshhtmhgrihhlrdgtohhmpd
    hrtghpthhtohepshiivgguvghrrdguvghvsehgmhgrihhlrdgtohhmpdhrtghpthhtohep
    ghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehkrghrthhhihhkrd
    dukeeksehgmhgrihhlrdgtohhmpdhrtghpthhtohepphgvfhhfsehpvghffhdrnhgvthdp
    rhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhmpdhrtghpthhtohepsggvnh
    drkhhnohgslhgvsehgmhgrihhlrdgtohhmpdhrtghpthhtohepthhoohhnsehiohhttghl
    rdgtohhmpdhrtghpthhtohepjhhlthhosghlvghrsehgmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:nIyIaGeKuXVBhDKQU5idFyak7YyYqD9XqMIUMivXDty69p13jDc9tw>
    <xmx:nIyIaAou7szn34Rqrl_DjtYwT8MROY_G57vnQExBiMOcKnG-ZE5eIw>
    <xmx:nIyIaIOSBSUiXuYIAdpHno1wr_L82BF9Ep-3uexurpZ_q5MdlMNp1A>
    <xmx:nIyIaLj6kOdkTM0x1d6d6KWTMTbRJvtCVat_LCuICRfHYUuZ53SJMA>
    <xmx:nIyIaNnUtD_384tiIiWdceOchdkgvzn_5IVfEIaBj_J5SBpCd1L1pes2>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 29 Jul 2025 04:55:55 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 7e529cb5 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Tue, 29 Jul 2025 08:55:54 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Tue, 29 Jul 2025 10:55:27 +0200
Subject: [PATCH v3 9/9] refs: fix invalid old object IDs when migrating
 reflogs
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250729-pks-reflog-append-v3-9-9614d310f073@pks.im>
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
index f88928de746..946eb48941b 100644
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
index 253dd8f4d5d..090b4fdff4f 100644
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
index 85ab2ef2b94..905555365b8 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -3010,6 +3010,20 @@ static int parse_and_write_reflog(struct files_ref_store *refs,
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
@@ -3027,7 +3041,7 @@ static int parse_and_write_reflog(struct files_ref_store *refs,
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
diff --git a/t/t1421-reflog-write.sh b/t/t1421-reflog-write.sh
index 6cad64f40ab..d4e41838f8f 100755
--- a/t/t1421-reflog-write.sh
+++ b/t/t1421-reflog-write.sh
@@ -99,11 +99,9 @@ test_expect_success 'simple writes' '
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
index 2ab97e1b7df..0e1116a319d 100755
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
2.50.1.619.g074bbf1d35.dirty

