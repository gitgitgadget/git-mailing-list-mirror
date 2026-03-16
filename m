Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F9D53254A9
	for <git@vger.kernel.org>; Mon, 16 Mar 2026 04:51:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773636679; cv=none; b=TskuJf1zTG7Z+DyHXIYx8+gz7vg3ZPOGpkbKeD+qTMeWvGtMW4v+BJ5yEb9dGLSZGBKbIlIkwsaN8kOEnpnGY6D7SX6oox76VfvwESJseWEmVI2F1HMkyIS8cLKzNoQZbgsuY5GT0T681dWHJS+gdLvd8SpNGsF/KYt9+Rrvfjc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773636679; c=relaxed/simple;
	bh=MUnonsZy6u/VArTaLMMYTvud7O2xkJ1lwaZBgIeBfsA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eiRYV3VNnDwUd02t3RnBnNjdo6XJojOMNa+oVzNNmbz1ADBMeql+X7T698lxO/vp+nz60RMJR/q7jdCrIXPf9JjPIEfMta8sOZom0j+gx1/ZPohWFtcsB8UJfintD/JE+q2osWWeTdB2gzEnRdVGFXmsY8Jq7v/czk4pCcYsPhA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lYHm5vqN; arc=none smtp.client-ip=209.85.222.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lYHm5vqN"
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-8cd751a4e93so235978085a.0
        for <git@vger.kernel.org>; Sun, 15 Mar 2026 21:51:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773636677; x=1774241477; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ayByTfsdQiy6sEa+GcQBEWE2nZ+G4jGWuB/X9ZsQGK0=;
        b=lYHm5vqNwunA3MRzoswP/EyAFw266gxCgccyC/s0E+mEHKnbGyvswXQC3sd4si4zjg
         cPOvEi2rJsbifJrmc25P4U5Hup98KaGiY/W+O2dOuG+y5PuqKVnIcQHz7DJSggFHUTJr
         09vsu2s+EEjg5RlTtKXwHEdZZDlAYuJqrefB0YSo+gWzkJbVv9sMZsJBgJh45SD6XQO3
         r2doVWJxQnNPAs2SVS3sWQT/bSLpvGlbwE0V6GMkNPvdUC65ZTerPZWnYDszGk53uXHD
         8yZa9AcoGIRwWJenV/uXahOO40FOBzI7Fq+eSPfMHjfOyHEfiKcdFDJkUv0G8JYzQpOj
         7swg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773636677; x=1774241477;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ayByTfsdQiy6sEa+GcQBEWE2nZ+G4jGWuB/X9ZsQGK0=;
        b=GVFPZFWenq0rkoA1xdg98TzCqaGBi8xoG/Y7adUUcoB47arsv9MURJSu7X1ry3kC4Q
         8HTKHXFiYoOuhs1Vr0dCIbNXplAQxfWFDeeDsdPBlwnbvKCLv/NYxxE/L8JrC9yTTNNn
         lW78FKvwuaQwr7ch5jnae1g1Sx1U9peoA9pBAHEc6g4lCu+AAkJaX6yqDVMquTHp9LU0
         VakaB5lNmcrTijCyloMUTUbJTm6jZO4luG1C43NPenVc1LtkdQPrcmtWd1e/NTMlkAuw
         qXUZQ2dISZMpswEqcD/CYU/aUM1UuOqz+xC5PBZkkMk3dXNB9kNLopjyKnPqyKhq3LfW
         rYQA==
X-Gm-Message-State: AOJu0Yzr4WUjyswiHZ/SZh/PbDosNniKrWyJAGRD3hh+Td3/gi6m2yMJ
	GdHkxveD4xiiN0WhhP1vjwT47TeKaFib13RnKwiFANZvrI3HoVXZ6Zm4/T1DlA==
X-Gm-Gg: ATEYQzyH7J8mhPQ+pnqw8iXjzrYYeEaxTou+4xEsnPcU2/e5rg30XOMOGgB/tVtTqDo
	TuxibOXVTJiKh3uthMIN3o/8lQh0hkofvBb3hd9b3M6Wz16KmtPDXZnWFzj3Ou5aAjaKg1gkMEk
	bTVtiZJni/8FwUR0zVW7j+SkJ6P6poblP0FiOP/md5tCAlnQt635RJE5+DRJsLgYzEbhZ82G8f3
	H4ZzIeI2YUI9ohPbkc/axgFxWZ+xwSyP1T+50U9gJodUyCRWc/27ZShdF+/oDnPKXOWWE/LcNar
	kOYp/1+1KsRo14DxCNuNrbzwqgDWjq1kDbRp2Kti1IRxtvTlAnBOGgm3YrEJ9VTxRIJz6h78sqB
	h94eSx3yhrh3CN2ciYYs6vBbce+Ki+YtAvoxIN3O9KuA+SySyWg3ucZnC31+noO+N5TzT7J2KYB
	4rxXUZNNwBR+HPOI5Xwahh+qEquxBNqplo9L3Mg0WRK85GG5Bct9rH05KpMl2B
X-Received: by 2002:a05:620a:444f:b0:8cd:827a:2ab3 with SMTP id af79cd13be357-8cdb5b309d6mr1564837685a.55.1773636676874;
        Sun, 15 Mar 2026 21:51:16 -0700 (PDT)
Received: from eju--20230906-5R2TJ ([74.15.89.125])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8cda210daa1sm1147606385a.26.2026.03.15.21.51.15
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 15 Mar 2026 21:51:16 -0700 (PDT)
From: Eric Ju <eric.peijian@gmail.com>
To: git@vger.kernel.org
Cc: ps@pks.im,
	jltobler@gmail.com,
	eric.peijian@gmail.com,
	ericju711@gmail.com
Subject: [PATCH v2 0/1] refs: add 'preparing' phase to the reference-transaction hook
Date: Mon, 16 Mar 2026 00:51:01 -0400
Message-ID: <20260316045102.70551-1-eric.peijian@gmail.com>
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


The "reference-transaction" hook currently exposes three phases to callers:
"prepared", "committed", and "aborted". The earliest of these, "prepared",
fires after Git has already acquired exclusive locks on every affected
reference. This is well-suited for last-chance validation, but it arrives
too late for any use case that requires coordination before locking, such
as serializing concurrent transactions across distributed storage nodes.

This series introduces a new "preparing" phase that fires before
refs->be->transaction_prepare() is called, that is, before Git takes any
reference lock on disk. Hook scripts that handle this phase receive the full
list of proposed updates and may reject the transaction by returning a
non-zero exit status, causing Git to abort cleanly before any locks are
acquired.

The motivating use case is Gitaly/Praefect, GitLab's distributed Git storage
layer. Praefect must serialize concurrent writes that target the same
references across replicas. With only the "prepared" phase available, by the
time Praefect can observe a transaction the locks are already held, making
reordering impossible. The "preparing" phase provides the necessary
pre-lock window.

Compatibility note: this change is not strictly backwards compatible. Hook
scripts that do not expect unknown phase strings may return an error when
they encounter "preparing". We consider this acceptable for the same reasons
cited when symref support was added to the hook in a8ae923f85 (refs: support
symrefs in 'reference-transaction' hook, 2024-05-07): the hook is documented
as exposing internal implementation details, and its semantics have been
adjusted before. An alternative of introducing a "reference-transaction-v2"
hook was considered but rejected as unnecessarily heavyweight.

---
Changes since v1:

- Fix commit title to follow "area: description" convention
  ("refs: add 'preparing' phase to reference-transaction hook")
- Correct phase names in documentation to past tense
  ("committed", "aborted")
- Fix the sentence about backwards compatibility with unknown phases
- Update die() messages to identify the hook by full name and phase
  ("ref updates rejected by the reference-transaction hook at its
  preparing/prepared phase")
- Consolidate author identity to eric.peijian@gmail.com
- Add clarification in reply to the question about how to use the preparing
  phase for write serialization

Eric Ju (1):
  refs: add 'preparing' phase to the reference-transaction hook

 Documentation/githooks.adoc      | 19 ++++++++++++-------
 refs.c                           |  9 ++++++++-
 t/t1416-ref-transaction-hooks.sh | 30 ++++++++++++++++++++++++++----
 t/t5510-fetch.sh                 |  7 ++++++-
 4 files changed, 52 insertions(+), 13 deletions(-)

Range-diff against v1:
1:  5f9f13a84d ! 1:  fb74f21d98 Add preparing state to reference-transaction hook
    @@
      ## Metadata ##
    -Author: Eric Ju <eju@gitlab.com>
    +Author: Eric Ju <eric.peijian@gmail.com>
     
      ## Commit message ##
    -    Add preparing state to reference-transaction hook
    +    refs: add 'preparing' phase to the reference-transaction hook
     
         The "reference-transaction" hook is invoked multiple times during a ref
         transaction. Each invocation corresponds to a different phase:
     
         - The "prepared" phase indicates that references have been locked.
    -    - The "commit" phase indicates that all updates have been written to disk.
    -    - The "abort" phase indicates that the transaction has been aborted and that
    +    - The "committed" phase indicates that all updates have been written to disk.
    +    - The "aborted" phase indicates that the transaction has been aborted and that
           all changes have been rolled back.
     
         This hook can be used to learn about the updates that Git wants to perform.
    @@ Commit message
         interfering with the locking state.
     
         This change is strictly speaking not backwards compatible. Existing hook
    -    scripts that do not know to handle unknown phases handle the "preparing" state
    -    string will encounter an unknown phase, and that might cause them to return an
    -    error now. But the hook is considered to expose internal implementation details
    +    scripts that do not know how to handle unknown phases may treat
    +    'preparing' as an error and return non-zero.
    +    But the hook is considered to expose internal implementation details
         of how Git works, and as such we have been a bit more lenient with changing its
         exact semantics, like for example in a8ae923f85 (refs: support symrefs in
         'reference-transaction' hook, 2024-05-07).
    @@ Commit message
     
         Helped-by: Patrick Steinhardt <ps@pks.im>
         Helped-by: Justin Tobler <jltobler@gmail.com>
    +    Helped-by: Karthik Nayak <karthik.188@gmail.com>
         Signed-off-by: Eric Ju <eric.peijian@gmail.com>
     
      ## Documentation/githooks.adoc ##
    @@ refs.c: int ref_transaction_prepare(struct ref_transaction *transaction,
     +	ret = run_transaction_hook(transaction, "preparing");
     +	if (ret) {
     +		ref_transaction_abort(transaction, err);
    -+		die(_("ref updates aborted by %s hook"), "preparing");
    ++		die(_("ref updates aborted by the reference-transaction hook at its %s state"), "preparing");
     +	}
     +
      	ret = refs->be->transaction_prepare(refs, transaction, err);
    @@ refs.c: int ref_transaction_prepare(struct ref_transaction *transaction,
      	if (ret) {
      		ref_transaction_abort(transaction, err);
     -		die(_("ref updates aborted by hook"));
    -+		die(_("ref updates aborted by %s hook"), "prepared");
    ++		die(_("ref updates aborted by the reference-transaction hook at its %s state"), "prepared");
      	}
      
      	return 0;
    @@ t/t1416-ref-transaction-hooks.sh: test_expect_success 'hook allows updating ref
     +		fi
     +	EOF
     +	test_must_fail git update-ref HEAD POST 2>err &&
    -+	test_grep "ref updates aborted by preparing hook" err
    ++	test_grep "ref updates aborted by the reference-transaction hook at its preparing state" err
     +'
     +
      test_expect_success 'hook aborts updating ref in prepared state' '
    @@ t/t1416-ref-transaction-hooks.sh: test_expect_success 'hook aborts updating ref
      	EOF
      	test_must_fail git update-ref HEAD POST 2>err &&
     -	test_grep "ref updates aborted by hook" err
    -+	test_grep "ref updates aborted by prepared hook" err
    ++	test_grep "ref updates aborted by the reference-transaction hook at its prepared state" err
      '
      
      test_expect_success 'hook gets all queued updates in prepared state' '
-- 
2.51.0

