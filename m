Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A11CB348866
	for <git@vger.kernel.org>; Tue, 17 Mar 2026 02:36:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773714991; cv=none; b=AQ0pQ1dcAL05FZX8ZLg8G1ULCdnqk/eujM3o9v0fWJmHvndWHN3WwZl6CVMWYS3itpKjcm5vc2L4q6KFk2wIAzh+aOYCGsctTHZ77hIOZY/Soyq6FQG8nl2heMDhOp1rcY5P1+2aobQ1yx1BTJmoPwEvonzXyq+vIgeIo0C2mJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773714991; c=relaxed/simple;
	bh=osiVvJhf2xqE4h/lr9jRlMsQzZGzAtrDapThJQ2zwS8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Go34Q/BVABc+aEZnbsH7+rsY0T3xy2ido4ukr2dZQ3rlfAoYDZYPiZmBQ0jC4/E+rJgxZ5Lr2LCGgJTmIIE4iQ70/J8VJ/+U6ovKquxaIKzGM3Eh0IVNG8+7AOStVhiI3uECl1pyHxWePPnxbbXUyC8AryyCo5fyRvBzXNh/lqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RJVCZRAE; arc=none smtp.client-ip=209.85.219.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RJVCZRAE"
Received: by mail-qv1-f48.google.com with SMTP id 6a1803df08f44-89c4bc36053so11871056d6.2
        for <git@vger.kernel.org>; Mon, 16 Mar 2026 19:36:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773714988; x=1774319788; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QGXF+8+7U+ntMgAmDIc8bcFQJWV1yfqVKniDKF6uw88=;
        b=RJVCZRAEIOtSBmkuh5qFD69TIbhy0sfP/vMtFUC8Y11zvgg6joY0tgkvuHhxfQ/FAX
         JA2RQURqQAOCKOhhUFV5QChbN1x0L9uWCXOYOVSekpMGj60X0INON2ouMR8R6VmzyNoH
         Nd/l+IMfUgKItByToiaqUzjBngajT1aFLVnMSaaVv8LsYEGcMfPFR3WDaV5KNkjsNT1N
         To1idCvDExvTc0gjsQ7oRT5fSvz7ktJV9QosNKlLYCGAAHZtyyyjVHyjPPYgxAJxWFR1
         ZvGU7BwkPBj+Au/D8KtH/KmuVEc9C9v4BCpI0fQDcQpDwEJFwQiRpgRbefhtbchWzcQW
         Asnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773714988; x=1774319788;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=QGXF+8+7U+ntMgAmDIc8bcFQJWV1yfqVKniDKF6uw88=;
        b=QPYfIcYRG7aofKilqUrM1pYwnr4hyG/GdImYKGIOSJRBU5HWaskgHuXIj+4PHMX/Uh
         dIYztvkOuv2+s0CqXy63yEe2TbzkrGHw+M4ZWCJSRYmKnu63nEmDH9eATzHDkVfqAdGI
         YIziRg8QaExmCXjQxC1D8LdT+nuqeRFJEHc7N2DURt1Rxks6MbArKOqbqSbKnos/c8o0
         NdDyoEBZaAiPL/Lo6uqy5HB/I2w3WAfS/rbbRQQ7AaqXpe4UC9N9mzjs8idgnVxo5cxf
         SuYOkwX48ViLKL/qin6nAK4ZvIEEJD4/t54UYWgcDJGzFoAr5I0MYI5LDpZYrZ+jJ/dl
         LY7Q==
X-Gm-Message-State: AOJu0YyCOk/KrHi4eQwiVixWnRPd/KvN+9JgAFp9pyvw9n5Uax2J5dLi
	fxrLAWRey9uOlekdLTu/AkFi2bLfLjBrgQu4Kct2CxAkEvACV7u9Dutak9zr2I69
X-Gm-Gg: ATEYQzxQOVVP/WXSNfYbWJFBYkaaTLLhuOcrn3hWow5X9Y/NL7EpBf5t7I8QcXCD1mi
	SdTFN2dHKHw0VBnR1SzrbdpWBlmHo7304mm9K1ZXMUtmDJWBzDO08thS64SAsTf5LYLP5fUlxvj
	S+4f19+2wpd/0GaQJkHBSzqCn0pRM0kjM6QR+2uinj5vJWvXgMSlKVl7kcfZDwzT2n3KT5xzd9L
	VlUOJCzncAkuk/knVgfvrjDfJkrFaGBkxGgrDfm6NQ3Bn+F40I9+HJlvTN7hmjXghbweNO0sFXE
	x1SO+I7NG51sX904jQ8LFYY7WCl8eqftyk94hPggjfVwbR2lqd9ySP0OlfucGI3IY3m1fn4JKuG
	A7bmmuRcRO45VXi7u9fPw85FgW8eDAqAMat94tDxgxpKqFeZH7EQ5fBqCyAVSqlY3uKqQskGOaL
	i4rqa01/SJzfeD0gMNAXHT2I9q9GHbio/+0kKkI/va9GrSmskrfO5g/7Hz63QXjS1RRSOMnEj41
	9sOwi10p8Mg/CEDn2Rg7nAWFino33jF0gOJjmE+ZtSJX98sSss=
X-Received: by 2002:a05:6214:1253:b0:89a:9b1:a224 with SMTP id 6a1803df08f44-89a81ebb617mr242138246d6.34.1773714988361;
        Mon, 16 Mar 2026 19:36:28 -0700 (PDT)
Received: from eju--20230906-5R2TJ (bras-base-qnvlon8302w-grc-18-74-15-89-125.dsl.bell.ca. [74.15.89.125])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-89c463af405sm66918536d6.48.2026.03.16.19.36.27
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 16 Mar 2026 19:36:28 -0700 (PDT)
From: Eric Ju <eric.peijian@gmail.com>
To: git@vger.kernel.org
Cc: ps@pks.im,
	jltobler@gmail.com,
	eric.peijian@gmail.com,
	ericju711@gmail.com
Subject: [PATCH v3 0/1] refs: add 'preparing' phase to the reference-transaction hook
Date: Mon, 16 Mar 2026 22:36:23 -0400
Message-ID: <20260317023624.43070-1-eric.peijian@gmail.com>
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
Changes since v2:

- Shorten and reorder die() message to highlight the phase name early
- Extract the error message into a file-scope static constant to avoid
  duplication across the "preparing" and "prepared" call sites
- Reflow the backwards compatibility paragraph in the commit message

Eric Ju (1):
  refs: add 'preparing' phase to the reference-transaction hook

 Documentation/githooks.adoc      | 19 ++++++++++++-------
 refs.c                           | 12 +++++++++++-
 t/t1416-ref-transaction-hooks.sh | 30 ++++++++++++++++++++++++++----
 t/t5510-fetch.sh                 |  7 ++++++-
 4 files changed, 55 insertions(+), 13 deletions(-)

Range-diff against v2:
1:  4fff10e694 ! 1:  39f7a2bc4b refs: add 'preparing' phase to the reference-transaction hook
    @@ Commit message
         interfering with the locking state.
     
         This change is strictly speaking not backwards compatible. Existing hook
    -    scripts that do not know how to handle unknown phases may treat
    -    'preparing' as an error and return non-zero.
    -    But the hook is considered to expose internal implementation details
    -    of how Git works, and as such we have been a bit more lenient with changing its
    -    exact semantics, like for example in a8ae923f85 (refs: support symrefs in
    -    'reference-transaction' hook, 2024-05-07).
    +    scripts that do not know how to handle unknown phases may treat 'preparing'
    +    as an error and return non-zero. But the hook is considered to expose
    +    internal implementation details of how Git works, and as such we have
    +    been a bit more lenient with changing its exact semantics, like for example
    +    in a8ae923f85 (refs: support symrefs in 'reference-transaction' hook, 2024-05-07).
     
         An alternative would be to introduce a "reference-transaction-v2" hook that
         knows about the new phase. This feels like a rather heavy-weight option though,
    @@ Commit message
     
         Helped-by: Patrick Steinhardt <ps@pks.im>
         Helped-by: Justin Tobler <jltobler@gmail.com>
    +    Helped-by: Karthik Nayak <karthik.188@gmail.com>
         Signed-off-by: Eric Ju <eric.peijian@gmail.com>
     
      ## Documentation/githooks.adoc ##
    @@ Documentation/githooks.adoc: ref and `<ref-name>` is the full name of the ref. W
      ~~~~~~~~~~~~~~~~
     
      ## refs.c ##
    +@@ refs.c: const char *ref_storage_format_to_name(enum ref_storage_format ref_storage_forma
    + 	return be->name;
    + }
    + 
    ++static const char *abort_by_ref_transaction_hook =
    ++	N_("in '%s' phase, update aborted by the reference-transaction hook");
    ++
    + /*
    +  * How to handle various characters in refnames:
    +  * 0: An acceptable character for refs
     @@ refs.c: int ref_transaction_prepare(struct ref_transaction *transaction,
      	if (ref_update_reject_duplicates(&transaction->refnames, err))
      		return REF_TRANSACTION_ERROR_GENERIC;
    @@ refs.c: int ref_transaction_prepare(struct ref_transaction *transaction,
     +	ret = run_transaction_hook(transaction, "preparing");
     +	if (ret) {
     +		ref_transaction_abort(transaction, err);
    -+		die(_("ref updates aborted by the reference-transaction hook at its %s state"), "preparing");
    ++		die(_(abort_by_ref_transaction_hook), "preparing");
     +	}
     +
      	ret = refs->be->transaction_prepare(refs, transaction, err);
    @@ refs.c: int ref_transaction_prepare(struct ref_transaction *transaction,
      	if (ret) {
      		ref_transaction_abort(transaction, err);
     -		die(_("ref updates aborted by hook"));
    -+		die(_("ref updates aborted by the reference-transaction hook at its %s state"), "prepared");
    ++		die(_(abort_by_ref_transaction_hook), "prepared");
      	}
      
      	return 0;
    @@ t/t1416-ref-transaction-hooks.sh: test_expect_success 'hook allows updating ref
     +		fi
     +	EOF
     +	test_must_fail git update-ref HEAD POST 2>err &&
    -+	test_grep "ref updates aborted by the reference-transaction hook at its preparing state" err
    ++	test_grep "in '\''preparing'\'' phase, update aborted by the reference-transaction hook" err
     +'
     +
      test_expect_success 'hook aborts updating ref in prepared state' '
    @@ t/t1416-ref-transaction-hooks.sh: test_expect_success 'hook aborts updating ref
      	EOF
      	test_must_fail git update-ref HEAD POST 2>err &&
     -	test_grep "ref updates aborted by hook" err
    -+	test_grep "ref updates aborted by the reference-transaction hook at its prepared state" err
    ++	test_grep "in '\''prepared'\'' phase, update aborted by the reference-transaction hook" err
      '
      
      test_expect_success 'hook gets all queued updates in prepared state' '
-- 
2.51.0

