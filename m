Received: from fout-a4-smtp.messagingengine.com (fout-a4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1575027A47C
	for <git@vger.kernel.org>; Tue,  5 Aug 2025 15:12:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754406735; cv=none; b=q6KNwEmuMl4vHC6/+c0lHA/0brn1NKD/xb8SSvjAQQRc1T9wSf+zmuJTBgBWIE0oGQ8/L5Qm4lUyA70uZOUiBWADmobQNBgGMy5Uwz74kUVLqYqB8+RtXR4mLdkxaMvk4oK4PyZwIPABa6m9B+3MSItcbTiDfKL3Ymg9A8z3VuI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754406735; c=relaxed/simple;
	bh=yD79l77NIqtKjfv9copX9xjKEQjirsTwGjQm+nyPDqg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=AT9Kqn0M8ZbDGjq8TZuRo+Umj1FnQZHCLOp766qNVRfTJ1HZp2nVhhBxtiO0zNEuGy8M6OqiAor5/rTrsTcWRCM4MESQfIQGjx/6QSQa4eC++lIO50scMyuU2pQtCJ/ftPFH5Q7YtzD2mLgcnfAQUL5lhAt8nt8z2upL1kA8LIo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=LsBldvrU; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=QE1vz119; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="LsBldvrU";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="QE1vz119"
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfout.phl.internal (Postfix) with ESMTP id 464DBEC01FB;
	Tue,  5 Aug 2025 11:12:13 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Tue, 05 Aug 2025 11:12:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1754406733;
	 x=1754493133; bh=S7XON1oFzahfdNgBUR+5baW7iX5ywj2QIOilVOQ0YPw=; b=
	LsBldvrUO58q7G4SC2tqldb00GG2owSk34rz1ogXqn7N6CEYfTl0kbQWjzu03EDx
	US8+lQaoj8FnFelrz/BeCG+Gq3XRXKTJ0GqdQ/sKWhxXFd4klDIgBKAf6Tr1tgrp
	1JnyJ+xAWvNeFEiuYMKmquVdjYcpMRnun+REtzBcRLSgPSO5+51hBn5ry7ZX6Iq9
	eH0+7D68MYMPOROo2VWT8oHK14B6VdC4WWEYieRDQ8mLlgq00FGY2/44+TxzHZ6W
	sy2OD8MsQ2/MZw7qQfAfJUriSbdC+TYhICm+0K0qFH99cQLgvy0Ex3ncc6bHNU1l
	YAQMEBPvBwBdiHoxDap3iw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1754406733; x=
	1754493133; bh=S7XON1oFzahfdNgBUR+5baW7iX5ywj2QIOilVOQ0YPw=; b=Q
	E1vz119se3qNzXbdJzbrofBxkIBXzh1VvdbG4W9TRaj2GtzHQKgzbShUp30kJWWv
	YtGzaUkd35JFfEoRhxjq+iy7e4v3no++H9VgQzW7y8W5Qan4kidKFpEwr2yxP0Fq
	vcLXcEgpGyiW9qBwLpPCaBze4sft9xPjO8y1V8MUWKGl3qb/y+kH7oj80lFKcWTT
	/vzlROqgUrAycqn2vBoJw0pS+Vm51Gt7UYL1AudUb0Kb+v9x0ysmvPo63wWng4Pv
	IzahdSKG+nOaAsEB69BUtrm6Ay7goXeQBB/oJnAMjQYUfXd2480YubwpJFfDjT1R
	P3EIHosiGA7qAm4EfXtWQ==
X-ME-Sender: <xms:TR-SaJXjjjF7FoUjBzZXElvrY26eJX5lIeAA33LclB4rFFagXTbwVw>
    <xme:TR-SaGeZyARbbaOGq0chHced7zU2OUE5sUQ63p6_F_vbxUqhZ4miw6OcySF9zeMtQ
    s1QKacB0duqhqxRlQ>
X-ME-Received: <xmr:TR-SaFKQvA3D2Qpa-NJn7uS5F0wI4ceUHWAU16ACY3epoPHeVOzsO8OjEOH_sDutnxKcNStp5tcfeoCcLAbGI_CK5h2mVoXa29vN2aR_nQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdduudehhedtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeffueeiudejvdekheeuvdekfeffiedvueelteekudehjeetkeegvddugfdtgfeileen
    ucevlhhushhtvghrufhiiigvpedvnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhmpdhnsggprhgtphhtthhopeelpdhmohguvgepshhmthhpohhuthdprhgtphht
    thhopehjlhhtohgslhgvrhesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtshhtvg
    hrsehpohgsohigrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdr
    ohhrghdprhgtphhtthhopehpvghffhesphgvfhhfrdhnvghtpdhrtghpthhtohepkhhrih
    hsthhofhhfvghrhhgruhhgshgsrghkkhesfhgrshhtmhgrihhlrdgtohhmpdhrtghpthht
    ohepthhoohhnsehiohhttghlrdgtohhmpdhrtghpthhtohepkhgrrhhthhhikhdrudekke
    esghhmrghilhdrtghomhdprhgtphhtthhopehsiigvuggvrhdruggvvhesghhmrghilhdr
    tghomhdprhgtphhtthhopegsvghnrdhknhhosghlvgesghhmrghilhdrtghomh
X-ME-Proxy: <xmx:TR-SaLxOC-xGMYVWSRzyUSqiyVR19RuX3PHm1-8DVILtrwnoIniwbg>
    <xmx:TR-SaDskf1gxuMGWbKyRD-mJ7T8t2olUQFPPjEr-RE7C3ZEHu5--3Q>
    <xmx:TR-SaGBrGkLZjN0x2V2MN-XUsQQKvPWPSKv8v-NyyjlBI9gsyMalwg>
    <xmx:TR-SaNHeA5ZPtqrOThuxi8aL8d1PXQ-d94cVoRiTbtoGFK62PGdZ0A>
    <xmx:TR-SaFz2_HG9_SxyMt5Y4e1BX6vQE7CGRQycM-hwZv6xuL3LuczyC32A>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 5 Aug 2025 11:12:11 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id adbc4bb5 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Tue, 5 Aug 2025 15:12:11 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Tue, 05 Aug 2025 17:11:39 +0200
Subject: [PATCH v5 9/9] refs: fix invalid old object IDs when migrating
 reflogs
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250805-pks-reflog-append-v5-9-050997db09d5@pks.im>
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
index 85ab2ef2b9..905555365b 100644
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

