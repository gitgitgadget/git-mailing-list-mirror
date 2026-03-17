Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81223243376
	for <git@vger.kernel.org>; Tue, 17 Mar 2026 02:36:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773714992; cv=none; b=e23HAY7w4uQBs8vOwdfUSYFAYL00N9wjOIQKKVMykr0DRsbTdMTkmhVn0p3Fudac4jlPwTLZAUKkrtSz6jT4tx28Ix+QkpLXcrT0d9m4fNvS21uGuTC26QscdGNLvw3wTiFiuIZzTMQZfjjakpTc3NGDTq1+C0J32caN0FGRrWQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773714992; c=relaxed/simple;
	bh=rCHYTBqS4Ydrw5UP6eZK6TysCL2Jszjb4rHSXWft9TA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ijx+IGHCe1HQS2XRtRrsEoRDHo2im3zp8uZ0w8KF9xkEW6AdlZdjv3110RkSItRB4YvYXMJnhWGObnRVypUnRXHQ1wqmU3+AUeMEJ/KoEh/Tm6heSAyfhBK2kwPonlMwoLl+9vgOEkuFIfCAyw696hhC0X1VBXzqrfVUCS3jTvk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=goF3stW1; arc=none smtp.client-ip=209.85.219.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="goF3stW1"
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-89c55a0a470so16466756d6.0
        for <git@vger.kernel.org>; Mon, 16 Mar 2026 19:36:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773714989; x=1774319789; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3wB1BZd9oL6dqR7aIZpfSNkemBws9cJ95UlwibtpB8s=;
        b=goF3stW1FxHs03YhCMnyvFS5ih3mhvrdEa+GY4RhsIp5HXbD7+IBR7R9ssOiZoQy0j
         MFeY/V56q6Tal1owbfN/Qu80dKuHUX9HKWUB76ObA65EMkqK9R9QzbS9qusiEPoxjWq1
         OTgBEwj4nj+RwTPDlzbsxxYK90rz777LdGIZlnbjymmF3KQWvfNpMoLsFmOA+vuSo3aG
         SZkbEJK4MweDT9QyKBJ2mAmBi5/PKPN9HE3bKMFc+PyXp9zmxmw5pfnpjemyZT7cl04T
         8fEdoGGtch1R2yRR8fBlDwF+ngg963LS3xMvoxzhqfMXVPybk9jsRRxnroVd8k5F8Nqj
         qyUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773714989; x=1774319789;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=3wB1BZd9oL6dqR7aIZpfSNkemBws9cJ95UlwibtpB8s=;
        b=aM18FklDaP2EwNzfuZc+ZglkjMHBJNJVGsX9P1Wv8qA4RhW7bvYYgjjgEpgsnayxiN
         l7x7LdM4GhPOGnj2fp9oCKgbzMUfIl914dStKID8R1DOU15+UEZy4x2o2Ys6nTGJmMQx
         Su2A9sw3eojk+IZ6zKO3/SoUj1TddVnhyOly0x7cBZFQwO+KZy/ZnAj+Czit68hzkdC7
         qR1wRhmvtTLBPBNmr7KixRJypgeoiX4tB3r/lKMS4/GGGAVc6sQfOh0/V9GZ8nsGh7dq
         zVKgSWkSfivEHpEiEf3cRtiJkeXVvnReakHT4hAKWL8DowNw6CdWCqPuAxLf5wh1n2Dy
         b5iA==
X-Gm-Message-State: AOJu0YzaO5ulkUX43fS6e1LL2esJbC9Yy9t2mX2hXkQt9KVE6fGe/wYB
	kWac7KEA1SiDuZ4lxWdyVbcxVQe93IObozPsgsyhgR1AETp2tjIspuQNOkPoKJL5
X-Gm-Gg: ATEYQzylK0Jy+lyggCf1H8YbRTmTAJruN94MiyYdDQJHOtoBKxaQ+gJBdOaJvwhMq/2
	9o0zqnuus5sce4FhytTi7A9ZY9q17wGGgx0/AueHkGz6SbOWSIY+/pS07ktOYBifBF4RjaUtsp8
	HQaGJb+KGBITw3KT5DrQsv0trksBtDoDwN3zZb9ZiPfkZKkvUOyVWWtbMx2Z+nvxq7r+EffVbti
	6MfG4Jbw6pcjBQq9oZVr7uqkUU0nv9suZAujHuwhw40Vxdf+6GbxCIx+SlqzUMyE/K9BMNei0+9
	ZdYSkur6oBCrJ/BM4BhSmf5mG3u1tVaqJqT9pXK4Q8omFoZTd1QRKGRFIJhIPV2lGJ/AbVDMYpk
	5fbYX6QkZzUsNFWnWFN71PtkLQ+QtynXtD3Q+Ul1/UwghPY0ZXtHV7CYyFQTk1ItqHFUhIHiUHq
	sYnRsQ7TH6GLcaP4JRFIyGfopgckwQtNtBcc53fx/MHilTgrgB2adtyJyBCPWIKCr5GAc4720yc
	fBYGYvJoibH/o425pLx082K+aK39ivy/eCZe3vN
X-Received: by 2002:ad4:5ce8:0:b0:89c:4f7f:8479 with SMTP id 6a1803df08f44-89c4f7f86d6mr97753706d6.6.1773714989193;
        Mon, 16 Mar 2026 19:36:29 -0700 (PDT)
Received: from eju--20230906-5R2TJ (bras-base-qnvlon8302w-grc-18-74-15-89-125.dsl.bell.ca. [74.15.89.125])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-89c463af405sm66918536d6.48.2026.03.16.19.36.28
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 16 Mar 2026 19:36:28 -0700 (PDT)
From: Eric Ju <eric.peijian@gmail.com>
To: git@vger.kernel.org
Cc: ps@pks.im,
	jltobler@gmail.com,
	eric.peijian@gmail.com,
	ericju711@gmail.com,
	Karthik Nayak <karthik.188@gmail.com>
Subject: [PATCH v3 1/1] refs: add 'preparing' phase to the reference-transaction hook
Date: Mon, 16 Mar 2026 22:36:24 -0400
Message-ID: <20260317023624.43070-2-eric.peijian@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260317023624.43070-1-eric.peijian@gmail.com>
References: <20260313193537.62827-1-eric.peijian@gmail.com>
 <20260317023624.43070-1-eric.peijian@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The "reference-transaction" hook is invoked multiple times during a ref
transaction. Each invocation corresponds to a different phase:

- The "prepared" phase indicates that references have been locked.
- The "committed" phase indicates that all updates have been written to disk.
- The "aborted" phase indicates that the transaction has been aborted and that
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
scripts that do not know how to handle unknown phases may treat 'preparing'
as an error and return non-zero. But the hook is considered to expose
internal implementation details of how Git works, and as such we have
been a bit more lenient with changing its exact semantics, like for example
in a8ae923f85 (refs: support symrefs in 'reference-transaction' hook, 2024-05-07).

An alternative would be to introduce a "reference-transaction-v2" hook that
knows about the new phase. This feels like a rather heavy-weight option though,
and was thus discarded.

Helped-by: Patrick Steinhardt <ps@pks.im>
Helped-by: Justin Tobler <jltobler@gmail.com>
Helped-by: Karthik Nayak <karthik.188@gmail.com>
Signed-off-by: Eric Ju <eric.peijian@gmail.com>
---
 Documentation/githooks.adoc      | 19 ++++++++++++-------
 refs.c                           | 12 +++++++++++-
 t/t1416-ref-transaction-hooks.sh | 30 ++++++++++++++++++++++++++----
 t/t5510-fetch.sh                 |  7 ++++++-
 4 files changed, 55 insertions(+), 13 deletions(-)

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
index 6fb8f9d10c..e66cf4861d 100644
--- a/refs.c
+++ b/refs.c
@@ -64,6 +64,9 @@ const char *ref_storage_format_to_name(enum ref_storage_format ref_storage_forma
 	return be->name;
 }
 
+static const char *abort_by_ref_transaction_hook =
+	N_("in '%s' phase, update aborted by the reference-transaction hook");
+
 /*
  * How to handle various characters in refnames:
  * 0: An acceptable character for refs
@@ -2655,6 +2658,13 @@ int ref_transaction_prepare(struct ref_transaction *transaction,
 	if (ref_update_reject_duplicates(&transaction->refnames, err))
 		return REF_TRANSACTION_ERROR_GENERIC;
 
+	/* Preparing checks before locking references */
+	ret = run_transaction_hook(transaction, "preparing");
+	if (ret) {
+		ref_transaction_abort(transaction, err);
+		die(_(abort_by_ref_transaction_hook), "preparing");
+	}
+
 	ret = refs->be->transaction_prepare(refs, transaction, err);
 	if (ret)
 		return ret;
@@ -2662,7 +2672,7 @@ int ref_transaction_prepare(struct ref_transaction *transaction,
 	ret = run_transaction_hook(transaction, "prepared");
 	if (ret) {
 		ref_transaction_abort(transaction, err);
-		die(_("ref updates aborted by hook"));
+		die(_(abort_by_ref_transaction_hook), "prepared");
 	}
 
 	return 0;
diff --git a/t/t1416-ref-transaction-hooks.sh b/t/t1416-ref-transaction-hooks.sh
index d91dd3a3b5..4fe9d9b234 100755
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
+	test_grep "in '\''preparing'\'' phase, update aborted by the reference-transaction hook" err
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
+	test_grep "in '\''prepared'\'' phase, update aborted by the reference-transaction hook" err
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

