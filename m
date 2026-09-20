Received: from mail-ej2-f12.google.com (mail-ej2-f12.google.com [74.125.228.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A99D36729C
	for <git@vger.kernel.org>; Sun, 20 Sep 2026 10:54:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789901668; cv=none; b=YxiUMhyUOxn7gQ2nPoZyieXYBCGnoDAmCXIqqhqCreqziDBlxCUVNKywRWh461TFyziMhKvpXJnZSAcTE3mxkGug+denqUt0QESQDD1ilxWtyIu+qhw+2Nsrcowra/BhL2v79JMqH3kXhgnY3nfG0Y6EU1lcQnINqm74iHOIqtQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789901668; c=relaxed/simple;
	bh=gP5lGTjSyDdgqTs4jsuvuu+gEYmhnx2bKc6rq5ALXx0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=bCSgIOo9wmZA+t79AaVON95MjOrfZ7BqyR564TDcZSQTOIbVqVeATZgkNlHsmJ276Ri4pi4vvYNuMx4U3jxu+OQ5NKWx+eye0Y6UxZX7YNVG3Q7yF2wNQm4BNvNCnKp+1UBjqi8wsJRiXM4L/ADVLYxNU6srRUaqBU/2tTcoDt4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cz3JV7e2; arc=none smtp.client-ip=74.125.228.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cz3JV7e2"
Received: by mail-ej2-f12.google.com with SMTP id a640c23a62f3a-c254fa663bfso322545566b.1
        for <git@vger.kernel.org>; Sun, 20 Sep 2026 03:54:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789901664; x=1790506464; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=JiJGnnuWw6GJes7oDoNrpm+xUElm+O7SAEAVRk8KvVA=;
        b=cz3JV7e2HJ0hdNMTj4kqfTFec1+cTXM0YVjENBT52bIei2PxQtt2pnn1LTSG3YZC7x
         mVsgegAyZVW+0F500w5X9dsryyFStu+IY66uiiiYP8Ls9ReNXKKH+F2StFmmgPtZRTQj
         c3KzzUOxE9bHetDcQLBTnD3OXddJgZnnsMushMs7yeBynMxNz3QI2oBxGWn33Qfvwc6r
         XenBF2DjR1FDL1OTxEISlc43gPt7NTLRej1wwjdLcNRWFA29uoPiFGisBs3nAeJIPN55
         11FdBcZzv5IeIWfxwvjozsIkaD/LZ3eYCSl+AwQRfsPoPhnwtmVKk/zCelu3vAlYwmoC
         jHsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789901664; x=1790506464;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=JiJGnnuWw6GJes7oDoNrpm+xUElm+O7SAEAVRk8KvVA=;
        b=UviryfyudLsL9uoomXbp3p+xjbMtG6u7s3t3vcY5mZfCB8my/TUesbxgq2qRNmtlkW
         kCItotYZH5WKBGsCOQdWX4AIsrUL+psj/i4fPKlVpldFnC+7tt4zvb3sBumUNY/D4R0t
         QFsrKy8NYfxolz30MP6sHDA+xZyX1qQ1ZrRVqXVMEeufGM1F6zWPDukpYiZaz5fC2Bqk
         eogslKF9HQ7w4v2jJYtQWKcVHXrkRIP7KZTlpFTE3SKTkuRd3F+NAx2xmQY+4ExIWdC+
         /mE2k5ip4SzqcwH2RMhP/x9SxGF/ItrCktRs19saRHmnCE3drEANRwWIloSHlmcTchfP
         kJzg==
X-Gm-Message-State: AFuF++lq7VPtFPZoPCxe+KuYn29++7VoD4J8o9u+jR/Def4l784QmmrR
	D3xoj2ClSI2Spzho2V9FQSxCiuMzJYuW106POBk4CTxLUMdmqL/JqtmbSWiPUgND
X-Gm-Gg: AYBFou36jisvIbhI7EyrMXyj8cTxsas0PWTzgcw+VS+ms7HXhsVau+NBZFDTXmfqOKh
	cIE9yJUiW+aDBIfN0kQT+EAfu+rNZyRhQMV7imTdX6eJqG6vsrnnCMCj2UmtDykkn/hETN13lxw
	IQ34+0Fq2NnoPqgH5/Y+/mPW6Qs569gXBZE4Px4ZEhcYmCxHTRQ/Ypx4asTiORauAzMbL97U58X
	qERx/Li2jjydB2kqC8HdXVZ95dH1A7ifPtKoCDKvid8gYNBYXCrFD9ERqi6gEX14wr6dueqerV7
	PBUDOOxg5BPIDYvsCpsko4SCsmtaDHIk0RmBlNsUX82YNGCCuAHQpeQwxvn4Vn5ki+GmzKdxG8O
	FoQfZaTfcSP1k22X5EeZ9MGfNakZ5BxfZuz62B86vHBZlZQvKSXXh59ZuXzHM5rAeQDNKMTlkg1
	cbawjX6yAI6glKo6R4DZ5zVvA+VyZCg16z3e8oHigywadoyM2n6t2CYUz72l/obaeDPGiL3COon
	PX7iytyYugtuFruTRp7uT5ye0DMesBIZ63d40nwxVMLS43mRp3it4Rov4Jg03ZQg1Cuaz4kWJrn
	v8WZbH8wWr0hpZJ4eGnU7afn1hAODUAk3luM6N9SJ5jLI/BBpqNmo91z43UP1jyVHmex
X-Received: by 2002:a17:907:d08d:b0:c25:2e93:289e with SMTP id a640c23a62f3a-c2a156d8c65mr617261666b.16.1789901664166;
        Sun, 20 Sep 2026 03:54:24 -0700 (PDT)
Received: from localhost.localdomain (138.54.classcom.pl. [195.150.54.138])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c2a35239469sm170989666b.6.2026.09.20.03.54.23
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 20 Sep 2026 03:54:23 -0700 (PDT)
From: Maciej Ciemborowicz <maciej.ciemborowicz@gmail.com>
To: git@vger.kernel.org
Cc: Maciej Ciemborowicz <maciej.ciemborowicz@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Patrick Steinhardt <ps@pks.im>,
	Phil Hord <phil.hord@gmail.com>,
	Elijah Newren <newren@gmail.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= <avarab@gmail.com>,
	"D . Ben Knoble" <ben.knoble@gmail.com>,
	Karthik Nayak <karthik.188@gmail.com>
Subject: [PATCH v2 0/3] refs: report old OIDs for batched deletions
Date: Sun, 20 Sep 2026 12:54:19 +0200
Message-Id: <cover.1789901584.git.maciej.ciemborowicz@gmail.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
In-Reply-To: <CAOLa=ZTWGJZCmZnPLt5az_w-6YkGuQhQUKyJq6X=VFQL1T_6ZQ@mail.gmail.com>
References: <CAOLa=ZTWGJZCmZnPLt5az_w-6YkGuQhQUKyJq6X=VFQL1T_6ZQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The reference-transaction hook receives zero as both the old and new OID
when branch, tag, fetch, and remote delete refs through refs_delete_refs().
Those callers already know the values that they selected for deletion.

Teach refs_delete_refs() to accept aligned old OIDs and pass them into the
transaction. Besides making the hook records useful, this makes the selected
callers reject concurrent changes instead of deleting values that they did
not inspect. For branch and tag, this restores the compare-and-delete
behavior that existed before 8198907795 converted them to batched deletion.
For pruning, it prevents a stale scan from deleting a ref updated by another
process.

The values are already available at every updated call site, so the series
adds no ref reads and retains batched performance.

Changes since v1:

 * Document the conditional deletion behavior and its race protection.
 * Add tests that update refs from the hook's preparing phase and verify that
   branch deletion and remote pruning preserve the concurrent update.
 * Avoid printing deletion status when a non-atomic prune fails.
 * Use a local string_list_item in refs_delete_refs(), as suggested by
   Karthik.

Based on maint at e9019fcafe (Git 2.55).

Tests:

 * t1416-ref-transaction-hooks.sh (files and reftable)
 * t3200-branch.sh
 * t7004-tag.sh
 * t5510-fetch.sh
 * t5505-remote.sh

Maciej Ciemborowicz (3):
  refs: allow callers to supply old OIDs for batch deletion
  branch, tag: retain old OIDs in batched deletions
  fetch, remote: retain old OIDs when pruning refs

 bisect.c                         |   2 +-
 builtin/branch.c                 |   7 +-
 builtin/fetch.c                  |  13 +++-
 builtin/remote.c                 |  39 +++++++++--
 builtin/tag.c                    |   7 +-
 refs.c                           |  23 ++++---
 refs.h                           |  12 +++-
 t/helper/test-ref-store.c        |   2 +-
 t/t1416-ref-transaction-hooks.sh | 110 +++++++++++++++++++++++++++++++
 9 files changed, 190 insertions(+), 25 deletions(-)

Range-diff against v1:
1:  e1c72cfba ! 1:  5c96a5a1e refs: allow callers to supply old OIDs for batch deletion
    @@ Commit message
         reference-transaction hooks consequently see a null old OID.
     
         Add an optional oid_array whose entries correspond to the refnames. Pass each
    -    non-null OID to ref_transaction_delete(). Existing callers retain the
    -    unconditional behavior for now.
    +    non-null OID to ref_transaction_delete(). Supplying an OID makes the deletion
    +    conditional: if the ref changed after the caller resolved it, the transaction
    +    fails instead of deleting the new value. Existing callers that pass NULL
    +    retain the unconditional behavior.
     
         Signed-off-by: Maciej Ciemborowicz <maciej.ciemborowicz@gmail.com>
     
    @@ refs.c: void ref_transaction_for_each_rejected_update(struct ref_transaction *tr
      	}
      
     -	for_each_string_list_item(item, refnames) {
    --		ret = ref_transaction_delete(transaction, item->string,
    --					     NULL, NULL, flags, msg, &err);
     +	for (i = 0; i < refnames->nr; i++) {
    ++		struct string_list_item *item = &refnames->items[i];
     +		const struct object_id *old_oid = old_oids ? &old_oids->oid[i] : NULL;
     +
     +		if (old_oid && is_null_oid(old_oid))
     +			old_oid = NULL;
    -+		ret = ref_transaction_delete(transaction, refnames->items[i].string,
    + 		ret = ref_transaction_delete(transaction, item->string,
    +-					     NULL, NULL, flags, msg, &err);
     +					     old_oid, NULL, flags, msg, &err);
      		if (ret) {
      			warning(_("could not delete reference %s: %s"),
    --				item->string, err.buf);
    -+				refnames->items[i].string, err.buf);
    - 			strbuf_reset(&err);
    - 			failures = 1;
    - 		}
    + 				item->string, err.buf);
     
      ## refs.h ##
     @@
2:  09e0b8557 ! 2:  d00fdeba2 branch, tag: retain old OIDs in batched deletions
    @@ Metadata
      ## Commit message ##
         branch, tag: retain old OIDs in batched deletions
     
    -    Since 8198907795 (use delete_refs when deleting tags or branches,
    -    2021-01-21), branch and tag deletion pass no old OIDs to the ref transaction.
    -    As a result, reference-transaction hooks report zero as both the old and new
    -    OID.
    +    Before 8198907795 (use delete_refs when deleting tags or branches,
    +    2021-01-21), branch and tag deletion passed each resolved old OID to
    +    delete_ref(). This prevented the command from deleting a ref that another
    +    process had changed after it was inspected.
     
    -    Both commands already resolve the old OIDs before starting the deletion. Pass
    -    those values to refs_delete_refs() so hooks receive useful old values without
    -    adding any ref reads.
    +    The conversion to batched deletion dropped those old OIDs. Besides making the
    +    deletions unconditional, this causes reference-transaction hooks to report
    +    zero as both the old and new OID.
    +
    +    Both commands still resolve the old OIDs before starting the deletion. Pass
    +    those values to refs_delete_refs(). This restores the old race protection and
    +    lets hooks receive useful old values without adding any ref reads. If a ref
    +    changes concurrently, the transaction fails and preserves the new value.
     
         Signed-off-by: Maciej Ciemborowicz <maciej.ciemborowicz@gmail.com>
     
    @@ t/t1416-ref-transaction-hooks.sh: test_expect_success setup '
     +	git tag -d delete-tag &&
     +	test_cmp expect actual
     +'
    ++
    ++test_expect_success 'branch deletion rejects a concurrent update' '
    ++	git branch delete-race PRE &&
    ++	test_hook reference-transaction <<-\EOF &&
    ++		marker=$(git rev-parse --git-path delete-race-once)
    ++		if test "$1" = preparing && test ! -e "$marker"
    ++		then
    ++			>"$marker"
    ++			git update-ref refs/heads/delete-race POST
    ++		fi
    ++		exit 0
    ++	EOF
    ++	test_must_fail git branch -D delete-race 2>err &&
    ++	test_grep "is at $POST_OID but expected $PRE_OID" err &&
    ++	test_cmp_rev POST refs/heads/delete-race
    ++'
     +
      test_expect_success 'hook allows updating ref if successful' '
      	git reset --hard PRE &&
3:  95c8abce3 ! 3:  461c36ccd fetch, remote: retain old OIDs when pruning refs
    @@ Commit message
         new_oid member. The pruning paths discard that value and request unconditional
         deletion, so reference-transaction hooks receive a null old OID.
     
    -    Carry the recorded values into the deletion transactions. This reuses data
    -    collected while finding stale refs and therefore requires no additional ref
    -    reads.
    +    Carry the recorded values into the deletion transactions. Besides giving the
    +    hooks useful values, this stops a stale scan from deleting a ref that another
    +    process updated before the transaction acquired its locks. A concurrent
    +    change now makes the prune fail and preserves the new value.
    +
    +    This reuses data collected while finding stale refs and therefore requires no
    +    additional ref reads. Do not print deletion status when a non-atomic prune
    +    fails its old-OID check.
     
         Signed-off-by: Maciej Ciemborowicz <maciej.ciemborowicz@gmail.com>
     
    @@ builtin/fetch.c: static int prune_refs(struct display_state *display_state,
     -						  NULL, 0);
     +						  &old_oids, 0);
      		}
    ++		if (result)
    ++			goto cleanup;
      	}
      
    + 	if (verbosity >= 0) {
     @@ builtin/fetch.c: static int prune_refs(struct display_state *display_state,
      
      cleanup:
    @@ builtin/remote.c: static int prune_remote(const char *remote, int dry_run)
     +	for_each_string_list_item(item, &refs_to_prune)
     +		oid_array_append(&old_oids, item->util);
      
    - 	if (!dry_run)
    +-	if (!dry_run)
    ++	if (!dry_run) {
      		result |= refs_delete_refs(get_main_ref_store(the_repository),
      					   "remote: prune", &refs_to_prune,
     -					   NULL, 0);
     +					   &old_oids, 0);
    ++		if (result)
    ++			goto cleanup;
    ++	}
      
      	for_each_string_list_item(item, &states.stale) {
     -		const char *refname = item->util;
    @@ builtin/remote.c: static int prune_remote(const char *remote, int dry_run)
      		if (dry_run)
      			printf_ln(_(" * [would prune] %s"),
     @@ builtin/remote.c: static int prune_remote(const char *remote, int dry_run)
    + 	refs_warn_dangling_symrefs(get_main_ref_store(the_repository),
      				   stdout, " ", dry_run, &refs_to_prune);
      
    ++cleanup:
      	string_list_clear(&refs_to_prune, 0);
     +	oid_array_clear(&old_oids);
      	free_remote_ref_states(&states);
    @@ builtin/remote.c: static int prune_remote(const char *remote, int dry_run)
      }
     
      ## t/t1416-ref-transaction-hooks.sh ##
    -@@ t/t1416-ref-transaction-hooks.sh: test_expect_success 'hook gets old values for batched branch/tag deletion' '
    - 	test_cmp expect actual
    +@@ t/t1416-ref-transaction-hooks.sh: test_expect_success 'branch deletion rejects a concurrent update' '
    + 	test_cmp_rev POST refs/heads/delete-race
      '
      
     +test_expect_success 'hook gets old values when pruning remote refs' '
    @@ t/t1416-ref-transaction-hooks.sh: test_expect_success 'hook gets old values for
     +		test_cmp expect actual
     +	)
     +'
    ++
    ++test_expect_success 'remote prune rejects a concurrent update' '
    ++	test_when_finished "rm -rf race-empty.git race-prune" &&
    ++	test_create_repo race-empty.git --bare &&
    ++	test_create_repo race-prune &&
    ++	test_commit -C race-prune one &&
    ++	one=$(git -C race-prune rev-parse HEAD) &&
    ++	test_commit -C race-prune two &&
    ++	two=$(git -C race-prune rev-parse HEAD) &&
    ++	git -C race-prune remote add origin ../race-empty.git &&
    ++	git -C race-prune update-ref refs/remotes/origin/race "$one" &&
    ++	test_hook -C race-prune reference-transaction <<-\EOF &&
    ++		marker=$(git rev-parse --git-path prune-race-once)
    ++		if test "$1" = preparing && test ! -e "$marker"
    ++		then
    ++			>"$marker"
    ++			git update-ref refs/remotes/origin/race HEAD
    ++		fi
    ++		exit 0
    ++	EOF
    ++	test_must_fail git -C race-prune remote prune origin >out 2>err &&
    ++	test "$two" = "$(git -C race-prune rev-parse refs/remotes/origin/race)" &&
    ++	! grep "\[pruned\]" out
    ++'
     +
      test_expect_success 'hook allows updating ref if successful' '
      	git reset --hard PRE &&
-- 
2.39.3 (Apple Git-146)

