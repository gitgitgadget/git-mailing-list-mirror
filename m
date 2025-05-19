Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 938A21EFFB7
	for <git@vger.kernel.org>; Mon, 19 May 2025 09:58:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747648700; cv=none; b=UpUYJnBx/KGPpS2ZpzKrdaCYwrm+Qzncxwk7lhv6AzsfEZu5LQWlpv4DwvIIAbJvwsuctgeM9D6UbpEVU3I0mmpPmSJ91Fwl1x6f87N2dIirPnEkTfeRKN1myuOm4H0vPIH2SytE3Z1KHKG4XNLZ6HrWD4t5rgHzLIe9eb5g5tQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747648700; c=relaxed/simple;
	bh=As0QnASq1nN/Co+QyKOkZsaQVnRSwn0qpNaNKA252So=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 In-Reply-To:References:To:Cc; b=G/Sw47VWRWLnyvx0cEAQLTV506NqbBB9uKnSPotzSr4OsNEpTD83dnVgRlIHEtPXQHIns8inj45lUSIb3mhqbdGuHORkhJEaH9NrjsibH80js7VyznTpQkyY/7KiLDWyfbo78jS37CttAn99y3YbSllvHoINgQn2b1m9bLJcVXI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BU9kTkLj; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BU9kTkLj"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-43cec5cd73bso27626795e9.3
        for <git@vger.kernel.org>; Mon, 19 May 2025 02:58:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747648696; x=1748253496; darn=vger.kernel.org;
        h=cc:to:references:in-reply-to:content-transfer-encoding:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dW53CjOCvv9ddzqIibV7QJUgzBMaw2L+Y2yw+Jo8eKk=;
        b=BU9kTkLj0kPr+vowmiG6gffz17Xjhh2U1hQe8a+h+HwXSIvQm0oKrOJtDkOnaPNSRH
         FgTmcyvTc5eu7ozVJ2ALUQuY6im3mMIVcfEskh3bLIqGQ6Owe6WUrP4jMtAGbRCsHhkH
         JmgAvJmQoC3uGCaBW8CZ94IZG3sAos2lD4s/ctUBottIJsCXB7nsMwo9HLyfnAMiWhYA
         INU3K4UBT6Y6981uWtEVv1ClNYdtPPe+g/lSTGyB7Qgqkoousf9WvwR+Cwu8KA7dwFls
         VnWsNoMKU1z9UtaxGiYWi/ZHAisn4P0AaBrjYpqmPsjZHfsuixmQd1docuHdjcN+gf4t
         RKcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747648696; x=1748253496;
        h=cc:to:references:in-reply-to:content-transfer-encoding:mime-version
         :message-id:date:subject:from:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=dW53CjOCvv9ddzqIibV7QJUgzBMaw2L+Y2yw+Jo8eKk=;
        b=ADJ8o9hqkDp11KuZF6heTBzgUvnVVTNEMXwRR/yToyjcQ9Lar+ymwbuj6Vy/lAK+bU
         NfUoITncK6Uxo5tOUOmFOFHvaNtJOjUgl5WG8aEpODRqHS8DsS6IEellxICNgu/HnSJ/
         PMHqQVq29vpLXZoQexpOrkWx4PkYAMNqlFW/n2nYB7/Ki2fPBT/kgkI+07ukJCe8HqXw
         hsyk4L7xp1fMEcFWZjsbWBkHp67fKMiZ09Txc3qA6xeDnR00KtGOKC8lR09JCNYmJaRM
         7jrwdhEPUMl/pZCR1jC1F4G/YiV5TW5Y/WGnM/5ovDWIrku4f824bRJ2kgSWrvgs3I85
         CSzQ==
X-Gm-Message-State: AOJu0Yz9xb9pdna6MjF001IeJe9rkTYB6pBjCErXwsXz36pzPYkAnL7p
	+jvfr/xb8jBWeusJoAUzSH/vCiRLkuxGiVDimuErU10aNiFOFi4yEY3C
X-Gm-Gg: ASbGncv5H1v5RpMHGlVa6WUXrYM6aJpV/a7wRiiCyYoBjZe6OPUI1wK2b6ePFl9FFIP
	wz9fRAjbteCnZIu10qt8OqBfka7wUcrZNytVmml8OivOIKIoap50Yp2KAqlW+xhzk0W8fzYSl28
	blBcDteV30/MhcG7eQ7O875jqdJCUbyBu6IBjSxa1RhppOaDO9qE7rZR9u1fCJjgE28vKHDR6D+
	goRVIgIbkX4J50AL3ay+WhfS6R+3pDdj6+jUGF5f2L48OtIHXGPmqvGp7vQN2n1xYOw90iKuZ9V
	vpZGsIJoCjKt3fMS2vsi3yk9cDHmE3PSlzQ=
X-Google-Smtp-Source: AGHT+IFEHVUmL31z9XFtHobQzQvIRsyKnYWRyY4Sl6cWuhKiWGBv1pU7KiFpRDql/gv6knrj0BVXqQ==
X-Received: by 2002:a05:600c:5305:b0:43c:fceb:91a with SMTP id 5b1f17b1804b1-442fd62733amr110780435e9.11.1747648695610;
        Mon, 19 May 2025 02:58:15 -0700 (PDT)
Received: from [127.0.0.2] ([2a02:2455:8268:bc00:b2fc:6161:a86b:8382])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-442fa3e2ce5sm152811285e9.13.2025.05.19.02.58.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 May 2025 02:58:15 -0700 (PDT)
From: Karthik Nayak <karthik.188@gmail.com>
Subject: [PATCH v3 0/4] fetch/receive: use batched reference updates
Date: Mon, 19 May 2025 11:58:05 +0200
Message-Id: <20250519-501-update-git-fetch-1-to-use-partial-transactions-v3-0-6cdfd4f769b9@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAK0AK2gC/53OPQ7CMAyG4augzBjlt6VM3AMxmNRpLUFbJWkFQ
 r07ARZmxtfD9/gpEkWmJA6bp4i0cOJxKGG2G+F7HDoCbksLLbWTVhtwUsE8tZgJOs4QKPseFOQ
 R5kQwYcyMV8gRh4Q+l7UEdbhUlTFNoLoRZXiKFPj+QU/n0j2nPMbH54dFva9fzin7D7cokFD7y
 gVb2ca09tjdkK87P97Em1v0L+H+InQh9tJfENG5VtMvsa7rC3CiS2JXAQAA
X-Change-ID: 20250423-501-update-git-fetch-1-to-use-partial-transactions-7fb66339fe79
In-Reply-To: <20250514-501-update-git-fetch-1-to-use-partial-transactions-v1-0-7c65f46493d4@gmail.com>
References: <20250514-501-update-git-fetch-1-to-use-partial-transactions-v1-0-7c65f46493d4@gmail.com>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>, Patrick Steinhardt <ps@pks.im>, 
 gitster@pobox.com, peff@peff.net
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=10566;
 i=karthik.188@gmail.com; h=from:subject:message-id;
 bh=As0QnASq1nN/Co+QyKOkZsaQVnRSwn0qpNaNKA252So=;
 b=owJ4nAHtARL+kA0DAAoBPtWfJI5GjH8ByyZiAGgrALTwD+f4DyIHM8WTMoTawtvLZqgzWawGp
 cDr3D/Cp7veAYkBswQAAQoAHRYhBFfOTH9jdXEPy2XGBj7VnySORox/BQJoKwC0AAoJED7VnySO
 Rox/HHoL/3IiQ7VI2Ot4yZlqMQCyD2urDEiqDUKWijV/bOYsuuBCdNQ+WU2AmFJeRBznPlc8QlK
 Pw7cviagCLg+XJz2+XdVpaBNi87VrmabK+8JtReW0WB0YQGfHPQUZMFFMnH9G6Eo9Dvv7Y2TCGv
 FBDMswu7IKLHVCPRQOsoB81YrqpgyU4bVY1Bf/oaaG0MoofhEzu2FZwfkhKAR1VEHJRsCy2uRV3
 OF6eNPaC3byaJl3KUuErXYWjg43eUoCeLCPgfpOaji/UroFhjb78/phj38esJgZ18mJ0NlZu6ZS
 l4Fj5VNepjPum2QmROY6SqPKDYcEpbIaTkkU2m4ZLsPTZlzhN1GQXPXzmuUB4a9CZVOAQSYkPzl
 hCbuHufHx5n+2wjP/dhRN4eM6qLjKsf9TuXHBGGvz3UN1/uy7b0PIP5oMLW6cmK4rhBozxnbeDG
 bOPfoQr+mEAEXXjQgvOLXwkftdNUwy819a6r1wfranxZAtyEMFXw4LW9LmaR5+9o6uSul7Fjtj5
 D8=
X-Developer-Key: i=karthik.188@gmail.com; a=openpgp;
 fpr=57CE4C7F6375710FCB65C6063ED59F248E468C7F

The git-fetch(1) and git-receive-pack(1) commands update references as
part of the flow. Each reference update is treated as a single entity
and a transaction is created for each update.

This can be really slow, specifically in reference backends where there
are optimizations which ensure a single transaction with 'N' reference
update perform much faster than 'N' individual transactions. Also having
'N' individual transactions has buildup and teardown costs. These costs
add up in repositories with a large number of references.

Also specifically in the reftable backend, 'N' individual transactions
would also trigger auto-compaction for every transaction.

The reasoning for using individual transactions is because we want to
allow partial updates of references in these commands. Using a single
transaction would be an all-or-nothing scenario.

Recently we introduced an in-between solution called batched reference
updates in 23fc8e4f61 (refs: implement batch reference update support,
2025-04-08). This allows us to batch a set of reference updates, where
individual updates can pass/fail without affecting the batch.

This patch series, modifies both 'git-fetch(1)' and
'git-receive-pack(1)' to use this mechanism. With this, we see a
significant performance boost:

+---------------------+---------------+------------------+
|                     | files backend | reftable backend |
+---------------------+---------------+------------------+
| git-fetch(1)        | 1.25x         | 22x              |
| git-receive-pack(1) | 1.21x         | 18x              |
+---------------------+---------------+------------------+

The first and third patch handle the changes for 'git-fetch(1)' and
'git-receive-pack(1)' respectively. The second patch fixes a small
memory leak I encountered while working on this series.

This is based on top of master: 7a1d2bd0a5 (Merge branch 'master' of
https://github.com/j6t/gitk, 2025-05-09). There were no conflicts
observed with next or seen.

Junio, since the release window for 2.50 is closing in. I would prefer
we mark this for 2.51, so perhaps when/if we merge it to 'next', we let
it bake there till the next release window opens. While all the tests
pass, any bugs here would be high impact and it would be nice to catch
it before it hits a release.

---
Changes in v3:
- Modify `ref_transaction_error_msg()` to no longer provided an
  allocated string, but rather a 'const char *' string literal, this
  cleans up unnecessary allocation/free calls.
- Remove some unnecessary type casts.
- Fix some typos.
- Link to v2: https://lore.kernel.org/r/20250515-501-update-git-fetch-1-to-use-partial-transactions-v2-0-80cbaaa55d2e@gmail.com

Changes in v2:
- Added a new commit to introduce a mapping from 'ref_transaction_error'
  to a human readable string. We now use this to map the errors
  observed.
- Add a TODO regarding handling pruning and creation of refs in the same
  transaction in 'git-fetch(1)'.
- Cleanup commit message typos.
- Fix logic in 'builtin/receive-pack.c' around error reporting to be
  cleaner. Thanks Patrick for the suggestion.
- Link to v1: https://lore.kernel.org/r/20250514-501-update-git-fetch-1-to-use-partial-transactions-v1-0-7c65f46493d4@gmail.com

---
 builtin/fetch.c                  | 127 ++++++++++++++++++++++-----------------
 builtin/receive-pack.c           |  64 +++++++++++++++-----
 builtin/update-ref.c             |  25 +-------
 refs.c                           |  20 ++++++
 refs.h                           |   5 ++
 send-pack.c                      |   7 +++
 t/t1416-ref-transaction-hooks.sh |   2 -
 t/t5408-send-pack-stdin.sh       |  15 ++++-
 8 files changed, 166 insertions(+), 99 deletions(-)

Karthik Nayak (4):
      refs: add function to translate errors to strings
      fetch: use batched reference updates
      send-pack: fix memory leak around duplicate refs
      receive-pack: use batched reference updates

Range-diff versus v2:

1:  5196124be4 ! 1:  5bd1ffe4d2 refs: add function to translate errors to strings
    @@ Commit message
         to 'refs.c' as `ref_transaction_error_msg()` and use the same within the
         'builtin/update-ref.c'.
     
    +    Helped-by: Junio C Hamano <gitster@pobox.com>
         Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
     
      ## builtin/update-ref.c ##
    @@ builtin/update-ref.c: static void print_rejected_refs(const char *refname,
     -	default:
     -		reason = "unkown failure";
     -	}
    -+	char *reason = ref_transaction_error_msg(err);
    ++	const char *reason = ref_transaction_error_msg(err);
      
      	strbuf_addf(&sb, "rejected %s %s %s %s\n", refname,
      		    new_oid ? oid_to_hex(new_oid) : new_target,
    -@@ builtin/update-ref.c: static void print_rejected_refs(const char *refname,
    - 		    reason);
    - 
    - 	fwrite(sb.buf, sb.len, 1, stdout);
    -+	free(reason);
    - 	strbuf_release(&sb);
    - }
    - 
     
      ## refs.c ##
     @@ refs.c: int ref_update_expects_existing_old_ref(struct ref_update *update)
    @@ refs.c: int ref_update_expects_existing_old_ref(struct ref_update *update)
      		(!is_null_oid(&update->old_oid) || update->old_target);
      }
     +
    -+char *ref_transaction_error_msg(enum ref_transaction_error err)
    ++const char *ref_transaction_error_msg(enum ref_transaction_error err)
     +{
    -+	const char *reason = "";
    -+
     +	switch (err) {
     +	case REF_TRANSACTION_ERROR_NAME_CONFLICT:
    -+		reason = "refname conflict";
    -+		break;
    ++		return "refname conflict";
     +	case REF_TRANSACTION_ERROR_CREATE_EXISTS:
    -+		reason = "reference already exists";
    -+		break;
    ++		return "reference already exists";
     +	case REF_TRANSACTION_ERROR_NONEXISTENT_REF:
    -+		reason = "reference does not exist";
    -+		break;
    ++		return "reference does not exist";
     +	case REF_TRANSACTION_ERROR_INCORRECT_OLD_VALUE:
    -+		reason = "incorrect old value provided";
    -+		break;
    ++		return "incorrect old value provided";
     +	case REF_TRANSACTION_ERROR_INVALID_NEW_VALUE:
    -+		reason = "invalid new value provided";
    -+		break;
    ++		return "invalid new value provided";
     +	case REF_TRANSACTION_ERROR_EXPECTED_SYMREF:
    -+		reason = "expected symref but found regular ref";
    -+		break;
    ++		return "expected symref but found regular ref";
     +	default:
    -+		reason = "unkown failure";
    ++		return "unknown failure";
     +	}
    -+
    -+	return xstrdup(reason);
     +}
     
      ## refs.h ##
    @@ refs.h: void ref_transaction_for_each_rejected_update(struct ref_transaction *tr
     +/*
     + * Translate errors to human readable error messages.
     + */
    -+char *ref_transaction_error_msg(enum ref_transaction_error err);
    ++const char *ref_transaction_error_msg(enum ref_transaction_error err);
     +
      /*
       * Free `*transaction` and all associated data.
2:  c2014b959f ! 2:  dadabf1918 fetch: use batched reference updates
    @@ builtin/fetch.c: static int set_head(const struct ref *remote_refs, struct remot
     +					      enum ref_transaction_error err,
     +					      void *cb_data)
     +{
    -+	struct ref_rejection_data *data = (struct ref_rejection_data *)cb_data;
    ++	struct ref_rejection_data *data = cb_data;
     +
     +	if (err == REF_TRANSACTION_ERROR_NAME_CONFLICT && !data->conflict_msg_shown) {
     +		error(_("some local refs could not be updated; try running\n"
    @@ builtin/fetch.c: static int set_head(const struct ref *remote_refs, struct remot
     +			"branches"), data->remote_name);
     +		data->conflict_msg_shown = 1;
     +	} else {
    -+		char *reason = ref_transaction_error_msg(err);
    ++		const char *reason = ref_transaction_error_msg(err);
     +
     +		error(_("fetching ref %s failed: %s"), refname, reason);
    -+		free(reason);
     +	}
     +
     +	*data->retcode = 1;
    @@ builtin/fetch.c: static int do_fetch(struct transport *transport,
     +	 *
     +	 * TODO: if reference transactions gain logical conflict resolution, we
     +	 * can delete and create refs (with F/D conflicts) in the same transaction
    -+	 * and this can be moved about the 'prune_refs()' block.
    ++	 * and this can be moved above the 'prune_refs()' block.
     +	 */
     +	if (!transaction) {
     +		transaction = ref_store_transaction_begin(get_main_ref_store(the_repository),
3:  43f0dd3c31 = 3:  4006905807 send-pack: fix memory leak around duplicate refs
4:  a976afa025 ! 4:  0549b78b48 receive-pack: use batched reference updates
    @@ Commit message
         batch updates use a transaction under the hood. This explains the change
         in 't1416'.
     
    +    Helped-by: Jeff King <peff@peff.net>
         Helped-by: Patrick Steinhardt <ps@pks.im>
         Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
     
    @@ builtin/receive-pack.c: static void BUG_if_skipped_connectivity_check(struct com
     +{
     +	struct strmap *failed_refs = cb_data;
     +
    -+	strmap_put(failed_refs, refname, ref_transaction_error_msg(err));
    ++	strmap_put(failed_refs, refname, (char *)ref_transaction_error_msg(err));
     +}
     +
      static void execute_commands_non_atomic(struct command *commands,
    @@ builtin/receive-pack.c: static void BUG_if_skipped_connectivity_check(struct com
     +		if (reported_error)
     +			cmd->error_string = reported_error;
     +		else if (strmap_contains(&failed_refs, cmd->ref_name))
    -+			cmd->error_string = xstrdup(strmap_get(&failed_refs, cmd->ref_name));
    ++			cmd->error_string = strmap_get(&failed_refs, cmd->ref_name);
      	}
     +
     +cleanup:
     +	ref_transaction_free(transaction);
    -+	strmap_clear(&failed_refs, 1);
    ++	strmap_clear(&failed_refs, 0);
      	strbuf_release(&err);
      }
      
    @@ t/t5408-send-pack-stdin.sh: test_expect_success 'stdin mixed with cmdline' '
      	echo A:foo >input &&
      	test_must_fail git send-pack remote.git --stdin B:foo <input &&
     -	verify_push B foo
    ++	test_grep "multiple updates for ref ${SQ}refs/heads/foo${SQ} not allowed" err &&
     +	test_must_fail git --git-dir=remote.git rev-parse foo
      '
      


base-commit: 7a1d2bd0a596f42a8a7a68d55577967bb454fec0
change-id: 20250423-501-update-git-fetch-1-to-use-partial-transactions-7fb66339fe79

Thanks
- Karthik

