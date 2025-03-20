Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 813B421E0BE
	for <git@vger.kernel.org>; Thu, 20 Mar 2025 11:44:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742471054; cv=none; b=HozB03bRVbI163276G1EvWJPzw3+qZURvxTfOLQiPsFbtalbOIegH+sSO8DLUmZ4zhGBSXqg24TzVkCFcgiRZATevcUvFK5BN3VCJ85xti4WIVNvB214m1+23BXfg1f89mVWmZTZReqSNYAwqghdqY4KeoeAGPWNNMxYzhuToUY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742471054; c=relaxed/simple;
	bh=T6d3eA3+ZhIA4DlAtpTGJcsNQLxsUd9IeDsWPvzCtzE=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 In-Reply-To:References:To:Cc; b=lfuJrsMKmcpPO2GPOG+I31QGoCpBvU68RPPhjHzp5riIviSyEIAhVvLt1G0fInywNdby8fu9G+QcEywtjdlgyGMfjr2GgNhEs00PodTxa+QNVy2RHM6SvxIwbySjtR2Rop4K5N8q+w/F3QyEUi6x1lDeJ96Bs9+JhJemjYe708E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LKnTHc34; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LKnTHc34"
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-ac29fd22163so128988766b.3
        for <git@vger.kernel.org>; Thu, 20 Mar 2025 04:44:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742471050; x=1743075850; darn=vger.kernel.org;
        h=cc:to:references:in-reply-to:content-transfer-encoding:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zDKp8MltbLHo2HKemEflb2TgrUWtfTQ/FaR32tRD58Y=;
        b=LKnTHc34T3LnmTnMsG3tVAyB/uQ2HFg5D/gM8wJCECZi+2mFjyOKIG9oWvo0B9UlsO
         59O8Y7t31l6sBWxJn2NuPw9xZCk4zz+fiLriqe1tbwcDZ2eKvZle6u9RJtTOBHwGlw5L
         ulMfRNdZjtR1ZSjlOy2YB/bq+SmrjKg9/ZYNZa8rVrxI6U2Auf7hdvmzvRpCPtEQ570q
         1wF9PKZgvqOFizz+XS2imsl5Nxxd6HbajzxO3mcJY3akGVksziHu1Hs1R7nv2BspfEfk
         gVKB5YStAMAwQfPETYX8cIeui+khmOBHL429o27nhHwNxipf/4TRdJCA2IfvBeEPp9sq
         aang==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742471050; x=1743075850;
        h=cc:to:references:in-reply-to:content-transfer-encoding:mime-version
         :message-id:date:subject:from:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=zDKp8MltbLHo2HKemEflb2TgrUWtfTQ/FaR32tRD58Y=;
        b=aYZ3jrmdxj5fvBZbrqiXah/CemP2KSw5+NbM6bUEPTj9BZlP/30YrLUpsrZsidC3np
         O9nYWqGvx5r+S90An5oZk9ya+c5lTqwLbUpYH+BZLVgUXeY+VHzOY5baoFkW2qd8mD+o
         bBjHiD319FTWnR/V35fPVafS44eSvjIxnOarVTUycPCZBn+QYfHpm6NejPgkoAZJgxh7
         jmEwTYp29e/DxKjPftW6mOPJ5bvDXeK03Iq+vwAYUjLO4sE3J2eQlvnE/bW5/qsCgls9
         nXNDHLAhh3o850JDGpY5HNfrxYLmUDcnEFYWQGPHp8pU2XNPnpkZ/UyrxnHSC/rnwnD2
         sEAg==
X-Gm-Message-State: AOJu0Yzf8efOqoQY1jyqZCKvkPvUuCEH3vGKD6e6hFZFdU7zAgJOs3M6
	Uu9WwO40lyNy7yyFuhs7Gs7WfL0YK3GBvuzE50y9P/vmwebl4h7s
X-Gm-Gg: ASbGncvrttfBIioZ5BtKG30HyN8izRiTmH9FtYyz6RpEv81WHe4lmD+VttUy2JmhIQB
	UcqEE6oxcBnx367GgHbDk1dOnMMM1GsM6jYtPXFXAaJDDn4xZD+uc6e2qmyu8p2BiiGkhxpb13k
	7Z7aCyqX/Y1seVv77ddfA0RJn6xqICwuXNe9BU7n2h7CwokZnp0tYOOIqfnQ2Z7fkaJOXMJp1GS
	2m1kr3cU1sihEzEPJy+8djS4jev2xnzJrIgDRDP/QQjGzQ1sejW5Sz3XeKGXnBnuXeQ5GR4nLOV
	tjzu1Css5aj5zr7q/IOcuHMGDbH8wgnIPOumfzd4SIHvEM5xsP601BFmfor3XQ==
X-Google-Smtp-Source: AGHT+IHALEaoPOr6H65C+GejnLsoOL7ih+xbzuIwy86ZrbD8ocDtFdg/iBnAsjMGMH0WGh0JGaO1gA==
X-Received: by 2002:a17:907:d15:b0:ac3:422a:76dc with SMTP id a640c23a62f3a-ac3ce075c79mr317327666b.34.1742471049103;
        Thu, 20 Mar 2025 04:44:09 -0700 (PDT)
Received: from [127.0.0.2] ([2a02:2455:8268:bc00:b4f3:1c64:be3f:2632])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac3149d0077sm1167298866b.93.2025.03.20.04.44.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Mar 2025 04:44:08 -0700 (PDT)
From: Karthik Nayak <karthik.188@gmail.com>
Subject: [PATCH v4 0/8] refs: introduce support for batched reference
 updates
Date: Thu, 20 Mar 2025 12:43:55 +0100
Message-Id: <20250320-245-partially-atomic-ref-updates-v4-0-3dcc1b311dc9@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAHz/22cC/43OTY7CMAwF4KugrMfIdX5oWXEPNAtP6kCkllZJq
 UCod5+UzSA2w/LZ1vf8UFlSlKz2m4dKMscch0sJ5muj/JkvJ4HYlqwIyVSEDshYGDlNkbvuDjw
 NffSQJMB1bHmSDE2Q+gdr1MZ6VZixLOPtWXH8Lvkc8zSk+7NxpnW64haJ7P/4TIDgA2vSrm5su
 zuceo7d1g+9WvG5egFx9wFYFVAca9dgCKT5HdR/oMZPPtQFRO+MlHPS1ryCy7L8ArY7ubpyAQA
 A
X-Change-ID: 20241206-245-partially-atomic-ref-updates-9fe8b080345c
In-Reply-To: <20250207-245-partially-atomic-ref-updates-v1-0-e6a3690ff23a@gmail.com>
References: <20250207-245-partially-atomic-ref-updates-v1-0-e6a3690ff23a@gmail.com>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>, ps@pks.im, jltobler@gmail.com, 
 phillip.wood123@gmail.com
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=33385;
 i=karthik.188@gmail.com; h=from:subject:message-id;
 bh=T6d3eA3+ZhIA4DlAtpTGJcsNQLxsUd9IeDsWPvzCtzE=;
 b=owJ4nAHtARL+kA0DAAoBPtWfJI5GjH8ByyZiAGfb/4Ti5uc0Myn6YF2Vq5a0rNn+DSqlVNlie
 J8OjdJQqefG74kBswQAAQoAHRYhBFfOTH9jdXEPy2XGBj7VnySORox/BQJn2/+EAAoJED7VnySO
 Rox/SecL/iGFbU3P/qshKfUouruu2wrU1Iy791uTEV3UquBPIQqHY5L0IVkNsGFWAR/qca+nC03
 RUns757+JLGofbv1LiJwweA08XGoBsbDtfoy/4p+pfi3qKNpODTSmm3uSkvnbrb6JDL+eVkRb8q
 E2zesrhupaOmcRFMOSgMApjcIocka/Fyda5PAX+/tSkZaXNbXJav6WrQXWKNgqaRbZH6XJYe7AC
 EYZPbewRmGI/RTXxpguZAb0/TjNQupMHn4ts2bIt+pVnjPrLxOYGZ6rr0yl5SMA5JSaY3Xf2/i5
 62qnw/UD5RHoGMpi9HTA6iDCfJACAyuW6ejaXOzHSr/Ne+TI+hw2FkE0U/4dmrwu9Mi2mT/aZDw
 tdh3sx4/1ZhS/lVZ/UQ9neqnfJVeharTOXPrXjDqK01G+XzN3iP9WYJ7jiU4IGOq0mvNb1Eip1O
 OS7H5NmlgUclTrrQsF36RkxPyWXmhaCK6rMD7GQrZpqce6ECwnb1eWyq1oUeyt5DA2o7mL4kvV9
 UU=
X-Developer-Key: i=karthik.188@gmail.com; a=openpgp;
 fpr=57CE4C7F6375710FCB65C6063ED59F248E468C7F

Git supports making reference updates with or without transactions.
Updates with transactions are generally better optimized. But
transactions are all or nothing. This means, if a user wants to batch
updates to take advantage of the optimizations without the hard
requirement that all updates must succeed, there is no way currently to
do so. Particularly with the reftable backend where batching multiple
reference updates is more efficient than performing them sequentially.

This series introduces support for batched reference updates without
transactions allowing individual reference updates to fail while letting
others proceed. This capability is exposed through git-update-ref's
`--allow-partial` flag, which can be used in `--stdin` mode to batch
updates and handle failures gracefully. Under the hood, these batched
updates still use the transactions infrastructure, while modifying
sections to allow partial failures.

The changes are structured to carefully build up this functionality:

First, we clean up and consolidate the reference update checking logic.
This includes removing duplicate checks in the files backend and moving
refname tracking to the generic layer, which simplifies the codebase and
prepares it for the new feature.

We then restructure the reftable backend's transaction preparation code,
extracting the update validation logic into a dedicated function. This
not only improves code organization but sets the stage for implementing
partial transaction support.

To ensure we only skip errors which are user-oriented, we introduce
typed errors for transactions with 'enum ref_transaction_error'. We
extend the existing errors to include other scenarios and use this new
errors throughout the refs code.

With this groundwork in place, we implement the core batch update
support in the refs subsystem. This adds the necessary infrastructure to
track and report rejected updates while allowing transactions to
proceed. All reference backends are modified to support this behavior
when enabled.

Finally, we expose this functionality to users through
git-update-ref(1)'s `--allow-partial` flag, complete with test coverage
and documentation. The flag is specifically limited to `--stdin` mode
where batching multiple updates is most relevant.

This enhancement improves Git's flexibility in handling reference
updates while maintaining the safety of atomic transactions by default.
It's particularly valuable for tools and workflows that need to handle
reference update failures gracefully without abandoning the entire batch
of updates.

This series is based on top of 683c54c999 (Git 2.49, 2025-03-14) with
Patrick's series 'refs: batch refname availability checks' [1] merged
in.

[1]: https://lore.kernel.org/all/20250217-pks-update-ref-optimization-v1-0-a2b6d87a24af@pks.im/

---
Changes in v4:
- Rebased on top of 2.49 since there was a long time between the
  previous iteration and we have a new release.
- Changed the naming to say 'batched' updates instead of 'partial
  transactions'. While we still use the transaction infrastructure
  underneath, the new naming causes less ambiguity.
- Clean up some of the commit messages.
- Raise BUG for invalid update index while setting rejections.
- Fix an incorrect early return.
- Link to v3: https://lore.kernel.org/r/20250305-245-partially-atomic-ref-updates-v3-0-0c64e3052354@gmail.com

Changes in v3:
- Changed 'transaction_error' to 'ref_transaction_error' along with the
  error names. Removed 'TRANSACTION_OK' since it can potentially be
  missed instead of simply 'return 0'.
- Rename 'ref_transaction_set_rejected' to
  'ref_transaction_maybe_set_rejected' and move logic around error
  checks to within this function.
- Add a new struct 'ref_transaction_rejections' to track the rejections
  within a transaction. This allows us to only iterate over rejected
  updates.
- Add a new commit to also support partial transactions within the
  batched F/D checks.
- Remove NUL delimited outputs in 'git-update-ref(1)'.
- Remove translations for plumbing outputs.
- Other small cleanups in the commit message and code.

Changes in v2:
- Introduce and use structured errors. This consolidates the errors
  and their handling between the ref backends.
- In the previous version, we skipped over all failures. This include
  system failures such as low memory or IO problems. Let's instead, only
  skip user-oriented failures, such as invalid old OID and so on.
- Change the rejection function name to `ref_transaction_set_rejected()`.
- Modify the commit messages and documentation to be a little more
  verbose.
- Link to v1: https://lore.kernel.org/r/20250207-245-partially-atomic-ref-updates-v1-0-e6a3690ff23a@gmail.com

 Documentation/git-update-ref.adoc |  14 +-
 builtin/fetch.c                   |   2 +-
 builtin/update-ref.c              |  67 ++++-
 refs.c                            | 162 ++++++++++--
 refs.h                            |  76 ++++--
 refs/files-backend.c              | 314 +++++++++++-------------
 refs/packed-backend.c             |  69 +++---
 refs/refs-internal.h              |  51 +++-
 refs/reftable-backend.c           | 502 +++++++++++++++++++-------------------
 t/t1400-update-ref.sh             | 233 ++++++++++++++++++
 10 files changed, 968 insertions(+), 522 deletions(-)

Karthik Nayak (8):
      refs/files: remove redundant check in split_symref_update()
      refs: move duplicate refname update check to generic layer
      refs/files: remove duplicate duplicates check
      refs/reftable: extract code from the transaction preparation
      refs: introduce enum-based transaction error types
      refs: implement batch reference update support
      refs: support rejection in batch updates during F/D checks
      update-ref: add --batch-updates flag for stdin mode

Range-diff versus v3:

1:  c54471c108 ! 1:  0ddde0cb83 refs/files: remove redundant check in split_symref_update()
    @@ Commit message
         The second check is unnecessary because the first one guarantees that
         `string_list_insert()` will never encounter a preexisting entry.
     
    -    Since `item->util` is only used in this context, remove the assignment and
    -    simplify the surrounding code.
    +    The `item->util` field is assigned to validate that a rename doesn't
    +    already exist in the list. The validation is done after the first check.
    +    As this check is removed, clean up the validation and the assignment of
    +    this field in `split_head_update()` and `files_transaction_prepare()`.
     
         Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
     
2:  438ed0b49a ! 2:  4eba9153ff refs: move duplicate refname update check to generic layer
    @@ refs/reftable-backend.c: static int reftable_be_transaction_prepare(struct ref_s
      		}
      
     @@ refs/reftable-backend.c: static int reftable_be_transaction_prepare(struct ref_store *ref_store,
    + 		}
      	}
      
    - 	string_list_sort(&refnames_to_check);
     -	ret = refs_verify_refnames_available(ref_store, &refnames_to_check, &affected_refnames, NULL,
     +	ret = refs_verify_refnames_available(ref_store, &refnames_to_check,
     +					     &transaction->refnames, NULL,
3:  acdaa636d9 = 3:  a06733298d refs/files: remove duplicate duplicates check
4:  fc61deb9c6 ! 4:  707afdb039 refs/reftable: extract code from the transaction preparation
    @@ Commit message
         The refactoring consolidates all reference update validation into a
         single logical block, which improves code maintainability and
         readability. More importantly, this restructuring lays the groundwork
    -    for implementing partial transaction support in the reftable backend,
    -    which will be introduced in the following commit.
    +    for implementing batched reference update support in the reftable
    +    backend, which will be introduced in a followup commit.
     
         No functional changes are included in this commit - it is purely a code
         reorganization to support future enhancements.
    @@ refs/reftable-backend.c: static int reftable_be_transaction_prepare(struct ref_s
     -		}
      	}
      
    - 	string_list_sort(&refnames_to_check);
    + 	ret = refs_verify_refnames_available(ref_store, &refnames_to_check,
5:  c494ff7e99 ! 5:  b93c3f3f9f refs: introduce enum-based transaction error types
    @@ Commit message
             common scenarios.
     
         This refactoring paves the way for more comprehensive error handling
    -    which we will utilize in the upcoming commits to add partial transaction
    -    support.
    +    which we will utilize in the upcoming commits to add batch reference
    +    update support.
     
         Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
     
    @@ refs.c: int ref_transaction_commit(struct ref_transaction *transaction,
      {
      	struct strbuf dirname = STRBUF_INIT;
      	struct strbuf referent = STRBUF_INIT;
    + 	struct string_list_item *item;
      	struct ref_iterator *iter = NULL;
      	struct strset dirnames;
     -	int ret = -1;
    @@ refs/packed-backend.c: static int write_with_updates(struct packed_ref_store *re
      					    "reference is missing but expected %s",
      					    update->refname,
      					    oid_to_hex(&update->old_oid));
    -+				return REF_TRANSACTION_ERROR_NONEXISTENT_REF;
    ++				ret = REF_TRANSACTION_ERROR_NONEXISTENT_REF;
      				goto error;
      			}
      		}
6:  b051e51162 ! 6:  feacd50666 refs: implement partial reference transaction support
    @@ Metadata
     Author: Karthik Nayak <karthik.188@gmail.com>
     
      ## Commit message ##
    -    refs: implement partial reference transaction support
    +    refs: implement batch reference update support
     
    -    Git's reference transactions are all-or-nothing: either all updates
    -    succeed, or none do. While this atomic behavior is generally desirable,
    -    it can be suboptimal especially when using the reftable backend, where
    -    batching multiple reference updates into a single transaction is more
    -    efficient than performing them sequentially.
    +    Git supports making reference updates with or without transactions.
    +    Updates with transactions are generally better optimized. But
    +    transactions are all or nothing. This means, if a user wants to batch
    +    updates to take advantage of the optimizations without the hard
    +    requirement that all updates must succeed, there is no way currently to
    +    do so. Particularly with the reftable backend where batching multiple
    +    reference updates is more efficient than performing them sequentially.
     
    -    Introduce partial transaction support with a new flag,
    -    'REF_TRANSACTION_ALLOW_PARTIAL'. When enabled, this flag allows
    -    individual reference updates that would typically cause the entire
    -    transaction to fail due to non-system-related errors to be marked as
    -    rejected while permitting other updates to proceed. System errors
    -    referred by 'REF_TRANSACTION_ERROR_GENERIC' continue to result in the
    -    entire transaction failing. This approach enhances flexibility while
    -    preserving transactional integrity where necessary.
    +    Introduce batched update support with a new flag,
    +    'REF_TRANSACTION_ALLOW_FAILURE'. Batched updates while different from
    +    transactions, use the transaction infrastructure under the hood. When
    +    enabled, this flag allows individual reference updates that would
    +    typically cause the entire transaction to fail due to non-system-related
    +    errors to be marked as rejected while permitting other updates to
    +    proceed. System errors referred by 'REF_TRANSACTION_ERROR_GENERIC'
    +    continue to result in the entire transaction failing. This approach
    +    enhances flexibility while preserving transactional integrity where
    +    necessary.
     
         The implementation introduces several key components:
     
    @@ Commit message
           - Modify reference backends (files, packed, reftable) to handle
             partial transactions by using `ref_transaction_set_rejected()`
             instead of failing the entire transaction when
    -        `REF_TRANSACTION_ALLOW_PARTIAL` is set.
    +        `REF_TRANSACTION_ALLOW_FAILURE` is set.
     
           - Add `ref_transaction_for_each_rejected_update()` to let callers
             examine which updates were rejected and why.
     
    -    This foundational change enables partial transaction support throughout
    -    the reference subsystem. A following commit will expose this capability
    -    to users by adding a `--allow-partial` flag to 'git-update-ref(1)',
    +    This foundational change enables batched update support throughout the
    +    reference subsystem. A following commit will expose this capability to
    +    users by adding a `--batch-updates` flag to 'git-update-ref(1)',
         providing both a user-facing feature and a testable implementation.
     
         Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
    @@ refs.c: struct ref_transaction *ref_store_transaction_begin(struct ref_store *re
      	tr->flags = flags;
      	string_list_init_dup(&tr->refnames);
     +
    -+	if (flags & REF_TRANSACTION_ALLOW_PARTIAL)
    ++	if (flags & REF_TRANSACTION_ALLOW_FAILURE)
     +		CALLOC_ARRAY(tr->rejections, 1);
     +
      	return tr;
    @@ refs.c: void ref_transaction_free(struct ref_transaction *transaction)
     +	if (update_idx >= transaction->nr)
     +		BUG("trying to set rejection on invalid update index");
     +
    -+	if (!(transaction->flags & REF_TRANSACTION_ALLOW_PARTIAL))
    ++	if (!(transaction->flags & REF_TRANSACTION_ALLOW_FAILURE))
     +		return 0;
     +
     +	if (!transaction->rejections)
    -+		BUG("transaction not inititalized with partial support");
    ++		BUG("transaction not inititalized with failure support");
     +
     +	/*
     +	 * Don't accept generic errors, since these errors are not user
    @@ refs.h: enum ref_transaction_flag {
     +	 * is detected. This flag allows transactions to partially apply updates
     +	 * while rejecting updates which do not match the expected state.
     +	 */
    -+	REF_TRANSACTION_ALLOW_PARTIAL = (1 << 1),
    ++	REF_TRANSACTION_ALLOW_FAILURE = (1 << 1),
      };
      
      /*
    @@ refs/packed-backend.c: static enum ref_transaction_error write_with_updates(stru
     @@ refs/packed-backend.c: static enum ref_transaction_error write_with_updates(struct packed_ref_store *re
      					    update->refname,
      					    oid_to_hex(&update->old_oid));
    - 				return REF_TRANSACTION_ERROR_NONEXISTENT_REF;
    + 				ret = REF_TRANSACTION_ERROR_NONEXISTENT_REF;
     +
     +				if (ref_transaction_maybe_set_rejected(transaction, i, ret)) {
     +					strbuf_setlen(err, 0);
    @@ refs/refs-internal.h: struct ref_update {
      	uint64_t index;
      
     +	/*
    -+	 * Used in partial transactions to mark if a given update was rejected.
    ++	 * Used in batched reference updates to mark if a given update
    ++	 * was rejected.
     +	 */
     +	enum ref_transaction_error rejection_err;
     +
    @@ refs/refs-internal.h: enum ref_transaction_state {
      };
      
     +/*
    -+ * Data structure to hold indices of updates which were rejected, when
    -+ * partial transactions where enabled. While the updates themselves hold
    -+ * the rejection error, this structure allows a transaction to iterate
    -+ * only over the rejected updates.
    ++ * Data structure to hold indices of updates which were rejected, for batched
    ++ * reference updates. While the updates themselves hold the rejection error,
    ++ * this structure allows a transaction to iterate only over the rejected
    ++ * updates.
     + */
     +struct ref_transaction_rejections {
     +	size_t *update_indices;
    @@ refs/reftable-backend.c: static int reftable_be_transaction_prepare(struct ref_s
     +		}
      	}
      
    - 	string_list_sort(&refnames_to_check);
    + 	ret = refs_verify_refnames_available(ref_store, &refnames_to_check,
     @@ refs/reftable-backend.c: static int write_transaction_table(struct reftable_writer *writer, void *cb_data
      		struct reftable_transaction_update *tx_update = &arg->updates[i];
      		struct ref_update *u = tx_update->update;
7:  47d7a64cb4 ! 7:  f20877267d refs: support partial update rejections during F/D checks
    @@ Metadata
     Author: Karthik Nayak <karthik.188@gmail.com>
     
      ## Commit message ##
    -    refs: support partial update rejections during F/D checks
    +    refs: support rejection in batch updates during F/D checks
     
         The `refs_verify_refnames_available()` is used to batch check refnames
         for F/D conflicts. While this is the more performant alternative than
         its individual version, it does not provide rejection capabilities on a
    -    single update level. For partial transactions, this would mean a
    -    rejection of the entire transaction whenever one reference has a F/D
    -    conflict.
    +    single update level. For batched updates, this would mean a rejection of
    +    the entire transaction whenever one reference has a F/D conflict.
     
         Modify the function to call `ref_transaction_maybe_set_rejected()` to
         check if a single update can be rejected. Since this function is only
    @@ refs.c: enum ref_transaction_error refs_verify_refnames_available(struct ref_sto
     @@ refs.c: enum ref_transaction_error refs_verify_refnames_available(struct ref_store *refs
      	strset_init(&dirnames);
      
    - 	for (size_t i = 0; i < refnames->nr; i++) {
    -+		const size_t *update_idx = (size_t *)refnames->items[i].util;
    - 		const char *refname = refnames->items[i].string;
    + 	for_each_string_list_item(item, refnames) {
    ++		const size_t *update_idx = (size_t *)item->util;
    + 		const char *refname = item->string;
      		const char *extra_refname;
      		struct object_id oid;
     @@ refs.c: enum ref_transaction_error refs_verify_refnames_available(struct ref_store *refs
    @@ refs/files-backend.c: static enum ref_transaction_error lock_raw_ref(struct file
      		 * make sure there is no existing packed ref that conflicts
      		 * with refname. This check is deferred so that we can batch it.
      		 */
    --		string_list_insert(refnames_to_check, refname);
    -+		item = string_list_insert(refnames_to_check, refname);
    +-		string_list_append(refnames_to_check, refname);
    ++		item = string_list_append(refnames_to_check, refname);
     +		item->util = xmalloc(sizeof(update_idx));
     +		memcpy(item->util, &update_idx, sizeof(update_idx));
      	}
    @@ refs/refs-internal.h: enum ref_transaction_error ref_update_check_old_target(con
     + * refnames instead of only a single item. This is more efficient in the case
     + * where one needs to check multiple refnames.
     + *
    -+ * If a transaction is provided with partial support, then individual updates
    -+ * are marked rejected, reference backends are then in charge of not committing
    -+ * those updates.
    ++ * If using batched updates, then individual updates are marked rejected,
    ++ * reference backends are then in charge of not committing those updates.
     + */
     +enum ref_transaction_error refs_verify_refnames_available(struct ref_store *refs,
     +					  const struct string_list *refnames,
    @@ refs/reftable-backend.c: static int reftable_be_transaction_prepare(struct ref_s
      					    &head_referent, &referent, err);
      		if (ret) {
     @@ refs/reftable-backend.c: static int reftable_be_transaction_prepare(struct ref_store *ref_store,
    - 	string_list_sort(&refnames_to_check);
    + 
      	ret = refs_verify_refnames_available(ref_store, &refnames_to_check,
      					     &transaction->refnames, NULL,
     +					     transaction,
8:  2237086c65 ! 8:  d6f43d5dce update-ref: add --allow-partial flag for stdin mode
    @@ Metadata
     Author: Karthik Nayak <karthik.188@gmail.com>
     
      ## Commit message ##
    -    update-ref: add --allow-partial flag for stdin mode
    +    update-ref: add --batch-updates flag for stdin mode
     
         When updating multiple references through stdin, Git's update-ref
         command normally aborts the entire transaction if any single update
    -    fails. While this atomic behavior prevents partial updates by default,
    -    there are cases where applying successful updates while reporting
    -    failures is desirable.
    +    fails. This atomic behavior prevents partial updates. Introduce a new
    +    batch update system, where the updates the performed together similar
    +    but individual updates are allowed to fail.
     
    -    Add a new `--allow-partial` flag that allows the transaction to continue
    +    Add a new `--batch-updates` flag that allows the transaction to continue
         even when individual reference updates fail. This flag can only be used
    -    in `--stdin` mode and builds upon the partial transaction support added
    -    to the refs subsystem. When enabled, failed updates are reported in the
    -    following format:
    +    in `--stdin` mode and builds upon the batch update support added to the
    +    refs subsystem in the previous commits. When enabled, failed updates are
    +    reported in the following format:
     
           rejected SP (<old-oid> | <old-target>) SP (<new-oid> | <new-target>) SP <rejection-reason> LF
     
    @@ Documentation/git-update-ref.adoc: git-update-ref - Update the object name store
     +[synopsis]
     +git update-ref [-m <reason>] [--no-deref] -d <ref> [<old-oid>]
     +	       [-m <reason>] [--no-deref] [--create-reflog] <ref> <new-oid> [<old-oid>]
    -+               [-m <reason>] [--no-deref] --stdin [-z] [--allow-partial]
    ++               [-m <reason>] [--no-deref] --stdin [-z] [--batch-updates]
      
      DESCRIPTION
      -----------
    @@ Documentation/git-update-ref.adoc: performs all modifications together.  Specify
      With `--create-reflog`, update-ref will create a reflog for each ref
      even if one would not ordinarily be created.
      
    -+With `--allow-partial`, update-ref continues executing the transaction even if
    -+some updates fail due to invalid or incorrect user input, applying only the
    -+successful updates. Errors resulting from user-provided input are treated as
    -+non-system-related and do not cause the entire transaction to be aborted.
    -+However, system-related errors—such as I/O failures or memory issues—will still
    -+result in a full failure. Additionally, errors like F/D conflicts are batched
    -+for performance optimization and will also cause a full failure. Any failed
    ++With `--batch-updates`, update-ref executes the updates in a batch but allows
    ++individual updates to fail due to invalid or incorrect user input, applying only
    ++the successful updates. However, system-related errors—such as I/O failures or
    ++memory issues—will result in a full failure of all batched updates. Any failed
     +updates will be reported in the following format:
     +
     +	rejected SP (<old-oid> | <old-target>) SP (<new-oid> | <new-target>) SP <rejection-reason> LF
    @@ builtin/update-ref.c
      	N_("git update-ref [<options>] -d <refname> [<old-oid>]"),
      	N_("git update-ref [<options>]    <refname> <new-oid> [<old-oid>]"),
     -	N_("git update-ref [<options>] --stdin [-z]"),
    -+	N_("git update-ref [<options>] --stdin [-z] [--allow-partial]"),
    ++	N_("git update-ref [<options>] --stdin [-z] [--batch-updates]"),
      	NULL
      };
      
    @@ builtin/update-ref.c: int cmd_update_ref(int argc,
      		OPT_BOOL('z', NULL, &end_null, N_("stdin has NUL-terminated arguments")),
      		OPT_BOOL( 0 , "stdin", &read_stdin, N_("read updates from stdin")),
      		OPT_BOOL( 0 , "create-reflog", &create_reflog, N_("create a reflog")),
    -+		OPT_BIT('0', "allow-partial", &flags, N_("allow partial transactions"),
    -+			REF_TRANSACTION_ALLOW_PARTIAL),
    ++		OPT_BIT('0', "batch-updates", &flags, N_("batch reference updates"),
    ++			REF_TRANSACTION_ALLOW_FAILURE),
      		OPT_END(),
      	};
      
    @@ builtin/update-ref.c: int cmd_update_ref(int argc,
     +		update_refs_stdin(flags);
      		return 0;
     -	}
    -+	} else if (flags & REF_TRANSACTION_ALLOW_PARTIAL)
    -+		die("--allow-partial can only be used with --stdin");
    ++	} else if (flags & REF_TRANSACTION_ALLOW_FAILURE)
    ++		die("--batch-updates can only be used with --stdin");
      
      	if (end_null)
      		usage_with_options(git_update_ref_usage, options);
    @@ t/t1400-update-ref.sh: do
      		grep "$(git rev-parse $a) $(git rev-parse $a)" actual
      	'
      
    -+	test_expect_success "stdin $type allow-partial" '
    ++	test_expect_success "stdin $type batch-updates" '
     +		git init repo &&
     +		test_when_finished "rm -fr repo" &&
     +		(
    @@ t/t1400-update-ref.sh: do
     +
     +			format_command $type "update refs/heads/ref1" "$head" "$Z" >stdin &&
     +			format_command $type "update refs/heads/ref2" "$head" "$Z" >>stdin &&
    -+			git update-ref $type --stdin --allow-partial <stdin &&
    ++			git update-ref $type --stdin --batch-updates <stdin &&
     +			echo $head >expect &&
     +			git rev-parse refs/heads/ref1 >actual &&
     +			test_cmp expect actual &&
    @@ t/t1400-update-ref.sh: do
     +		)
     +	'
     +
    -+	test_expect_success "stdin $type allow-partial with invalid new_oid" '
    ++	test_expect_success "stdin $type batch-updates with invalid new_oid" '
     +		git init repo &&
     +		test_when_finished "rm -fr repo" &&
     +		(
    @@ t/t1400-update-ref.sh: do
     +
     +			format_command $type "update refs/heads/ref1" "$old_head" "$head" >stdin &&
     +			format_command $type "update refs/heads/ref2" "$(test_oid 001)" "$head" >>stdin &&
    -+			git update-ref $type --stdin --allow-partial <stdin >stdout &&
    ++			git update-ref $type --stdin --batch-updates <stdin >stdout &&
     +			echo $old_head >expect &&
     +			git rev-parse refs/heads/ref1 >actual &&
     +			test_cmp expect actual &&
    @@ t/t1400-update-ref.sh: do
     +		)
     +	'
     +
    -+	test_expect_success "stdin $type allow-partial with non-commit new_oid" '
    ++	test_expect_success "stdin $type batch-updates with non-commit new_oid" '
     +		git init repo &&
     +		test_when_finished "rm -fr repo" &&
     +		(
    @@ t/t1400-update-ref.sh: do
     +
     +			format_command $type "update refs/heads/ref1" "$old_head" "$head" >stdin &&
     +			format_command $type "update refs/heads/ref2" "$head_tree" "$head" >>stdin &&
    -+			git update-ref $type --stdin --allow-partial <stdin >stdout &&
    ++			git update-ref $type --stdin --batch-updates <stdin >stdout &&
     +			echo $old_head >expect &&
     +			git rev-parse refs/heads/ref1 >actual &&
     +			test_cmp expect actual &&
    @@ t/t1400-update-ref.sh: do
     +		)
     +	'
     +
    -+	test_expect_success "stdin $type allow-partial with non-existent ref" '
    ++	test_expect_success "stdin $type batch-updates with non-existent ref" '
     +		git init repo &&
     +		test_when_finished "rm -fr repo" &&
     +		(
    @@ t/t1400-update-ref.sh: do
     +
     +			format_command $type "update refs/heads/ref1" "$old_head" "$head" >stdin &&
     +			format_command $type "update refs/heads/ref2" "$old_head" "$head" >>stdin &&
    -+			git update-ref $type --stdin --allow-partial <stdin >stdout &&
    ++			git update-ref $type --stdin --batch-updates <stdin >stdout &&
     +			echo $old_head >expect &&
     +			git rev-parse refs/heads/ref1 >actual &&
     +			test_cmp expect actual &&
    @@ t/t1400-update-ref.sh: do
     +		)
     +	'
     +
    -+	test_expect_success "stdin $type allow-partial with dangling symref" '
    ++	test_expect_success "stdin $type batch-updates with dangling symref" '
     +		git init repo &&
     +		test_when_finished "rm -fr repo" &&
     +		(
    @@ t/t1400-update-ref.sh: do
     +
     +			format_command $type "update refs/heads/ref1" "$old_head" "$head" >stdin &&
     +			format_command $type "update refs/heads/ref2" "$old_head" "$head" >>stdin &&
    -+			git update-ref $type --no-deref --stdin --allow-partial <stdin >stdout &&
    ++			git update-ref $type --no-deref --stdin --batch-updates <stdin >stdout &&
     +			echo $old_head >expect &&
     +			git rev-parse refs/heads/ref1 >actual &&
     +			test_cmp expect actual &&
    @@ t/t1400-update-ref.sh: do
     +		)
     +	'
     +
    -+	test_expect_success "stdin $type allow-partial with regular ref as symref" '
    ++	test_expect_success "stdin $type batch-updates with regular ref as symref" '
     +		git init repo &&
     +		test_when_finished "rm -fr repo" &&
     +		(
    @@ t/t1400-update-ref.sh: do
     +
     +			format_command $type "update refs/heads/ref1" "$old_head" "$head" >stdin &&
     +			format_command $type "symref-update refs/heads/ref2" "$old_head" "ref" "refs/heads/nonexistent" >>stdin &&
    -+			git update-ref $type --no-deref --stdin --allow-partial <stdin >stdout &&
    ++			git update-ref $type --no-deref --stdin --batch-updates <stdin >stdout &&
     +			echo $old_head >expect &&
     +			git rev-parse refs/heads/ref1 >actual &&
     +			test_cmp expect actual &&
    @@ t/t1400-update-ref.sh: do
     +		)
     +	'
     +
    -+	test_expect_success "stdin $type allow-partial with invalid old_oid" '
    ++	test_expect_success "stdin $type batch-updates with invalid old_oid" '
     +		git init repo &&
     +		test_when_finished "rm -fr repo" &&
     +		(
    @@ t/t1400-update-ref.sh: do
     +
     +			format_command $type "update refs/heads/ref1" "$old_head" "$head" >stdin &&
     +			format_command $type "update refs/heads/ref2" "$old_head" "$Z" >>stdin &&
    -+			git update-ref $type --stdin --allow-partial <stdin >stdout &&
    ++			git update-ref $type --stdin --batch-updates <stdin >stdout &&
     +			echo $old_head >expect &&
     +			git rev-parse refs/heads/ref1 >actual &&
     +			test_cmp expect actual &&
    @@ t/t1400-update-ref.sh: do
     +		)
     +	'
     +
    -+	test_expect_success "stdin $type allow-partial with incorrect old oid" '
    ++	test_expect_success "stdin $type batch-updates with incorrect old oid" '
     +		git init repo &&
     +		test_when_finished "rm -fr repo" &&
     +		(
    @@ t/t1400-update-ref.sh: do
     +
     +			format_command $type "update refs/heads/ref1" "$old_head" "$head" >stdin &&
     +			format_command $type "update refs/heads/ref2" "$head" "$old_head" >>stdin &&
    -+			git update-ref $type --stdin --allow-partial <stdin >stdout &&
    ++			git update-ref $type --stdin --batch-updates <stdin >stdout &&
     +			echo $old_head >expect &&
     +			git rev-parse refs/heads/ref1 >actual &&
     +			test_cmp expect actual &&
    @@ t/t1400-update-ref.sh: do
     +		)
     +	'
     +
    -+	test_expect_success "stdin $type allow-partial refname conflict" '
    ++	test_expect_success "stdin $type batch-updates refname conflict" '
     +		git init repo &&
     +		test_when_finished "rm -fr repo" &&
     +		(
    @@ t/t1400-update-ref.sh: do
     +
     +			format_command $type "update refs/heads/ref/foo" "$old_head" "$head" >stdin &&
     +			format_command $type "update refs/heads/ref" "$old_head" "" >>stdin &&
    -+			git update-ref $type --stdin --allow-partial <stdin >stdout &&
    ++			git update-ref $type --stdin --batch-updates <stdin >stdout &&
     +			echo $old_head >expect &&
     +			git rev-parse refs/heads/ref/foo >actual &&
     +			test_cmp expect actual &&
    @@ t/t1400-update-ref.sh: do
     +		)
     +	'
     +
    -+	test_expect_success "stdin $type allow-partial refname conflict new ref" '
    ++	test_expect_success "stdin $type batch-updates refname conflict new ref" '
     +		git init repo &&
     +		test_when_finished "rm -fr repo" &&
     +		(
    @@ t/t1400-update-ref.sh: do
     +
     +			format_command $type "update refs/heads/foo" "$old_head" "" >stdin &&
     +			format_command $type "update refs/heads/ref" "$old_head" "" >>stdin &&
    -+			git update-ref $type --stdin --allow-partial <stdin >stdout &&
    ++			git update-ref $type --stdin --batch-updates <stdin >stdout &&
     +			echo $old_head >expect &&
     +			git rev-parse refs/heads/foo >actual &&
     +			test_cmp expect actual &&


base-commit: 679c868f5fffadd1f7e8e49d4d87d745ee36ffb7
change-id: 20241206-245-partially-atomic-ref-updates-9fe8b080345c

Thanks
- Karthik

