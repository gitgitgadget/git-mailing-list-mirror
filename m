Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 448CB3E023F
	for <git@vger.kernel.org>; Fri, 13 Mar 2026 19:36:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773430588; cv=none; b=lt/y+FWOp0oRm3ShOYMuQuE6cGaBm5mMoXp9tijQ1eP7fUKAyfOxBnwaTrWnJBwDPCGKjOli6ZQw/0PJ3UM+RdVZcsBawxP6KTu7fykv21of2ZJz6qyYXc5pCyLZqaOE4x8DPOqeyQjO4dM15h9sX4gnf6mJmEcWIYoxcNnwotc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773430588; c=relaxed/simple;
	bh=/5AaFrRPSFyqXcM7E1EPUpZbQ2qpaGoHnIWe/b92/Fc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=V4JjYicSRffVRnLDZ6sbptvGDCGjjFFYy66mN1vtGFSva9XfLppy8q/Z8DZXaN6fLPqiU29N8t/CtervTz3JshdkAokSBWOMhIOGZ+7TmPpZ6kXa1wHYQWAjEs46kekVm5YELazed5wwAfRqA0IBnrbhB0H3fWPvB7dr5W1hgyM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WhXYYDtP; arc=none smtp.client-ip=209.85.222.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WhXYYDtP"
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-8cd7c372929so258052885a.0
        for <git@vger.kernel.org>; Fri, 13 Mar 2026 12:36:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773430579; x=1774035379; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6RIACouXyxg/AWt54kMBCsfmByo0Gn3fkFc5g2PXQ1c=;
        b=WhXYYDtPqAposFJEsSVWo/bA5puwPCk6A4bO5bxH6ZD0P3h2ey9xd4AdhEqQvywttr
         9Am2L5VNTOcebR5cCNyucRTf7EMzWKh+nObtSJeHVigJmw0tMwT5ctDKHVLzfPgw/XQ4
         dSWmMoqzSDdUejOz+JzLHaGBjPChKFdjxQrJbNXgLwaN+xtV9jcGttVLTSV60gKBPqJI
         svwM7ZrEv9meTRPSrol9uv8ruyl37r9M27efoKaFXmtuP9KEDe5ubXBSomLa3YWgZWoJ
         knfrnvUXKkiD00mTHOmFaWFfcz6F3KCbPLi8mnJJHU9wTrEOjAgQKN5UbCepxUXp/sAx
         2yyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773430579; x=1774035379;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=6RIACouXyxg/AWt54kMBCsfmByo0Gn3fkFc5g2PXQ1c=;
        b=ZJ6J9gmuUTi8iRfc82UraRwHElGOfXuOfUEjC+UWzryXxFB4byN78hlf6KCY7lB4+D
         AfVEU1WAiYom6/00h7qfMJwLsGNEuSs9NbjJ1EWGiWWQ7cF7/aR25rczxcp5ivZ3G4Fp
         hmLQBI0vS7I2QQy9k9tApRFL/rgrsOOR9a3LeVrHcEwzEJebZYMZVMci6DKEg5qOS4jZ
         ZNti6hjorgsHna2OVqgwMQRcYiN79XDQt928VtA/o8+AW77Mvh+m/c7JOjQjSJ/1UNBu
         vbrwiummyRTazcHZtK+TNsJMHKSbSHrdUw+Bgdw7Vu6qjJpXCvQZKee53ZjHMjN3hqCl
         fhsw==
X-Gm-Message-State: AOJu0Yx2frlmvMKRS+BI2LhXSc7OyoY4ScnsS05Mj0gKSQPLw5/9pESn
	xjh/gA0re+GJ7JJcTTH7UiEpPW46vCWYVpqH+D8WcPM3g2ZWh/QB7t8lT81nNg==
X-Gm-Gg: ATEYQzyrUNfYcA9ycYwXmJiICeAT0cs7aQq4Fj+LAUoZzBBRoiHcjkF0hUB/etECdaa
	sw1433cNWLc2P+Vs1/wFzwhDXbegHLjzR/uuHSxy94FvlE8yzSPhirdxP8VDm4z92iAAP56vxr1
	RUL5Cqw0BTTurPb8rW5PsQnTTyg3xUDm3Sy21c5TQIcEuvzhZ5s2jrQsIPlkSQ6+eeRCEXa7UX1
	GrJUrQRU5oqiSyH1a2K3MZHQdMZxmrykG9BpZQsoxGtsAjT4uwWb9bjGlayA1QfLYcCAEKne1gv
	CXDvdPrmOcV8gN0HDuCVqEn5+b8WvB6u+gzQEFT9fWdoaaNPENkUDjg8zwebXriCP3I5cgQtMh/
	6Z8cTObaz+F5lD/P4xF1qvVBRLxUg6+23Xdtt2q7TuBoByMi1tp6FY+jV2rLFP/B/EKyknFMUr5
	9ZL9dzSL12H5LXzFanFfFpmIiiRWkFGLmnLF5Txqs/jfew0yrRLA==
X-Received: by 2002:a05:620a:46ab:b0:8cd:9599:b7cb with SMTP id af79cd13be357-8cdb5a6ae51mr630844085a.25.1773430578676;
        Fri, 13 Mar 2026 12:36:18 -0700 (PDT)
Received: from eju--20230906-5R2TJ ([74.15.89.125])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8cda210daa1sm633711285a.26.2026.03.13.12.36.17
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 13 Mar 2026 12:36:18 -0700 (PDT)
From: eric.peijian@gmail.com
To: git@vger.kernel.org
Cc: ps@pks.im,
	jltobler@gmail.com,
	Eric Ju <eric.peijian@gmail.com>
Subject: [PATCH 1/1] Add preparing state to reference-transaction hook
Date: Fri, 13 Mar 2026 15:35:36 -0400
Message-ID: <20260313193537.62827-2-eric.peijian@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260313193537.62827-1-eric.peijian@gmail.com>
References: <20260313193537.62827-1-eric.peijian@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Eric Ju <eric.peijian@gmail.com>

From: Eric Ju <eju@gitlab.com>

The "reference-transaction" hook is invoked multiple times during a ref
transaction. Each invocation corresponds to a different phase:

- The "prepared" phase indicates that references have been locked.
- The "commit" phase indicates that all updates have been written to disk.
- The "abort" phase indicates that the transaction has been aborted and that
  all changes have been rolled back.

This hook can be used to learn about the updates that Git wants to perform.
For example, forges use it to coordinate reference updates across multiple
nodes.

However, the phases are insufficient for some specific use cases. The earliest
observable phase in the "reference-transaction" hook is "prepared", at which
point Git has already taken exclusive locks on every affected reference. This
makes it suitable for last-chance validation, but not for serialization. So by
the time a hook sees the "prepared" phase, it has no way to defer locking, and
thus it cannot rearrange multiple concurrent ref transactions relative to one
another.

Introduce a new "preparing" phase that runs before the "prepared" phase, that
is before Git acquires any reference lock on disk. This gives callers a
well-defined window to perform validation, enable higher-level ordering of
concurrent transactions, or reject the transaction entirely, all without
interfering with the locking state.

This change is strictly speaking not backwards compatible. Existing hook
scripts that do not know to handle unknown phases handle the "preparing" state
string will encounter an unknown phase, and that might cause them to return an
error now. But the hook is considered to expose internal implementation details
of how Git works, and as such we have been a bit more lenient with changing its
exact semantics, like for example in a8ae923f85 (refs: support symrefs in
'reference-transaction' hook, 2024-05-07).

An alternative would be to introduce a "reference-transaction-v2" hook that
knows about the new phase. This feels like a rather heavy-weight option though,
and was thus discarded.

Helped-by: Patrick Steinhardt <ps@pks.im>
Helped-by: Justin Tobler <jltobler@gmail.com>
Signed-off-by: Eric Ju <eric.peijian@gmail.com>
---
 Documentation/githooks.adoc      | 19 ++++++++++++-------
 refs.c                           |  9 ++++++++-
 t/t1416-ref-transaction-hooks.sh | 30 ++++++++++++++++++++++++++----
 t/t5510-fetch.sh                 |  7 ++++++-
 4 files changed, 52 insertions(+), 13 deletions(-)

diff --git a/Documentation/githooks.adoc b/Documentation/githooks.adoc
index 056553788d..ed045940d1 100644
--- a/Documentation/githooks.adoc
+++ b/Documentation/githooks.adoc
@@ -484,13 +484,16 @@ reference-transaction
 ~~~~~~~~~~~~~~~~~~~~~
 
 This hook is invoked by any Git command that performs reference
-updates. It executes whenever a reference transaction is prepared,
-committed or aborted and may thus get called multiple times. The hook
-also supports symbolic reference updates.
+updates. It executes whenever a reference transaction is preparing,
+prepared, committed or aborted and may thus get called multiple times.
+The hook also supports symbolic reference updates.
 
 The hook takes exactly one argument, which is the current state the
 given reference transaction is in:
 
+    - "preparing": All reference updates have been queued to the
+      transaction but references are not yet locked on disk.
+
     - "prepared": All reference updates have been queued to the
       transaction and references were locked on disk.
 
@@ -511,16 +514,18 @@ ref and `<ref-name>` is the full name of the ref. When force updating
 the reference regardless of its current value or when the reference is
 to be created anew, `<old-value>` is the all-zeroes object name. To
 distinguish these cases, you can inspect the current value of
-`<ref-name>` via `git rev-parse`.
+`<ref-name>` via `git rev-parse`. During the "preparing" state, symbolic
+references are not resolved: `<ref-name>` will reflect the symbolic reference
+itself rather than the object it points to.
 
 For symbolic reference updates the `<old_value>` and `<new-value>`
 fields could denote references instead of objects. A reference will be
 denoted with a 'ref:' prefix, like `ref:<ref-target>`.
 
 The exit status of the hook is ignored for any state except for the
-"prepared" state. In the "prepared" state, a non-zero exit status will
-cause the transaction to be aborted. The hook will not be called with
-"aborted" state in that case.
+"preparing" and "prepared" states. In these states, a non-zero exit
+status will cause the transaction to be aborted. The hook will not be
+called with "aborted" state in that case.
 
 push-to-checkout
 ~~~~~~~~~~~~~~~~
diff --git a/refs.c b/refs.c
index 6fb8f9d10c..f1439476d3 100644
--- a/refs.c
+++ b/refs.c
@@ -2655,6 +2655,13 @@ int ref_transaction_prepare(struct ref_transaction *transaction,
 	if (ref_update_reject_duplicates(&transaction->refnames, err))
 		return REF_TRANSACTION_ERROR_GENERIC;
 
+	/* Preparing checks before locking references */
+	ret = run_transaction_hook(transaction, "preparing");
+	if (ret) {
+		ref_transaction_abort(transaction, err);
+		die(_("ref updates aborted by %s hook"), "preparing");
+	}
+
 	ret = refs->be->transaction_prepare(refs, transaction, err);
 	if (ret)
 		return ret;
@@ -2662,7 +2669,7 @@ int ref_transaction_prepare(struct ref_transaction *transaction,
 	ret = run_transaction_hook(transaction, "prepared");
 	if (ret) {
 		ref_transaction_abort(transaction, err);
-		die(_("ref updates aborted by hook"));
+		die(_("ref updates aborted by %s hook"), "prepared");
 	}
 
 	return 0;
diff --git a/t/t1416-ref-transaction-hooks.sh b/t/t1416-ref-transaction-hooks.sh
index d91dd3a3b5..2f452049c3 100755
--- a/t/t1416-ref-transaction-hooks.sh
+++ b/t/t1416-ref-transaction-hooks.sh
@@ -20,6 +20,7 @@ test_expect_success 'hook allows updating ref if successful' '
 		echo "$*" >>actual
 	EOF
 	cat >expect <<-EOF &&
+		preparing
 		prepared
 		committed
 	EOF
@@ -27,6 +28,18 @@ test_expect_success 'hook allows updating ref if successful' '
 	test_cmp expect actual
 '
 
+test_expect_success 'hook aborts updating ref in preparing state' '
+	git reset --hard PRE &&
+	test_hook reference-transaction <<-\EOF &&
+		if test "$1" = preparing
+		then
+			exit 1
+		fi
+	EOF
+	test_must_fail git update-ref HEAD POST 2>err &&
+	test_grep "ref updates aborted by preparing hook" err
+'
+
 test_expect_success 'hook aborts updating ref in prepared state' '
 	git reset --hard PRE &&
 	test_hook reference-transaction <<-\EOF &&
@@ -36,7 +49,7 @@ test_expect_success 'hook aborts updating ref in prepared state' '
 		fi
 	EOF
 	test_must_fail git update-ref HEAD POST 2>err &&
-	test_grep "ref updates aborted by hook" err
+	test_grep "ref updates aborted by prepared hook" err
 '
 
 test_expect_success 'hook gets all queued updates in prepared state' '
@@ -121,6 +134,7 @@ test_expect_success 'interleaving hook calls succeed' '
 	cat >expect <<-EOF &&
 		hooks/update refs/tags/PRE $ZERO_OID $PRE_OID
 		hooks/update refs/tags/POST $ZERO_OID $POST_OID
+		hooks/reference-transaction preparing
 		hooks/reference-transaction prepared
 		hooks/reference-transaction committed
 	EOF
@@ -143,6 +157,8 @@ test_expect_success 'hook captures git-symbolic-ref updates' '
 	git symbolic-ref refs/heads/symref refs/heads/main &&
 
 	cat >expect <<-EOF &&
+	preparing
+	$ZERO_OID ref:refs/heads/main refs/heads/symref
 	prepared
 	$ZERO_OID ref:refs/heads/main refs/heads/symref
 	committed
@@ -171,14 +187,20 @@ test_expect_success 'hook gets all queued symref updates' '
 	# In the files backend, "delete" also triggers an additional transaction
 	# update on the packed-refs backend, which constitutes additional reflog
 	# entries.
+	cat >expect <<-EOF &&
+	preparing
+	ref:refs/heads/main $ZERO_OID refs/heads/symref
+	ref:refs/heads/main $ZERO_OID refs/heads/symrefd
+	$ZERO_OID ref:refs/heads/main refs/heads/symrefc
+	ref:refs/heads/main ref:refs/heads/branch refs/heads/symrefu
+	EOF
+
 	if test_have_prereq REFFILES
 	then
-		cat >expect <<-EOF
+		cat >>expect <<-EOF
 		aborted
 		$ZERO_OID $ZERO_OID refs/heads/symrefd
 		EOF
-	else
-		>expect
 	fi &&
 
 	cat >>expect <<-EOF &&
diff --git a/t/t5510-fetch.sh b/t/t5510-fetch.sh
index 5dcb4b51a4..6fe21e2b3a 100755
--- a/t/t5510-fetch.sh
+++ b/t/t5510-fetch.sh
@@ -469,12 +469,17 @@ test_expect_success 'fetch --atomic executes a single reference transaction only
 	head_oid=$(git rev-parse HEAD) &&
 
 	cat >expected <<-EOF &&
+		preparing
+		$ZERO_OID $head_oid refs/remotes/origin/atomic-hooks-1
+		$ZERO_OID $head_oid refs/remotes/origin/atomic-hooks-2
 		prepared
 		$ZERO_OID $head_oid refs/remotes/origin/atomic-hooks-1
 		$ZERO_OID $head_oid refs/remotes/origin/atomic-hooks-2
 		committed
 		$ZERO_OID $head_oid refs/remotes/origin/atomic-hooks-1
 		$ZERO_OID $head_oid refs/remotes/origin/atomic-hooks-2
+		preparing
+		$ZERO_OID ref:refs/remotes/origin/main refs/remotes/origin/HEAD
 	EOF
 
 	rm -f atomic/actual &&
@@ -497,7 +502,7 @@ test_expect_success 'fetch --atomic aborts all reference updates if hook aborts'
 	head_oid=$(git rev-parse HEAD) &&
 
 	cat >expected <<-EOF &&
-		prepared
+		preparing
 		$ZERO_OID $head_oid refs/remotes/origin/atomic-hooks-abort-1
 		$ZERO_OID $head_oid refs/remotes/origin/atomic-hooks-abort-2
 		$ZERO_OID $head_oid refs/remotes/origin/atomic-hooks-abort-3
-- 
2.51.0

