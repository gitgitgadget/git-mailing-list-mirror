Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B44D1A260
	for <git@vger.kernel.org>; Wed,  5 Mar 2025 17:39:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741196362; cv=none; b=DJwklBr367f2PabENRQj8PyDxYY4m6PjNghTVlqMWhkG4O1TGEKpSRFfTW3jYJHkdWunjCIpJ7C3STJJlDQuH27gxVhxDAUxDPaCfSCElmqAtdRuhZtmZRpap8zyVxSVG1ZWHf689XcaLrxkplr/nQzhame1jN/9yhjiOhqXZvM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741196362; c=relaxed/simple;
	bh=eRZl+Qc13VCEghyWl7sXdbnNWHh1y3fWDeowWFk7+GI=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 In-Reply-To:References:To:Cc; b=YtEMAyDbw8hYOa0pKlI+iXhBo5tMvv9QffIQdMrseWvxqNpVKYLw7vlDLCmNdQNLPXKoaJ/RO+i29uzIBIGcwGBks2bQXLeUEYMGpjRhAWIOyGvjpsZH5KCvtwclVmAiMW3Tc/MVy3IPzsHnhYRDqSmlw4+BzH94jYebkCrr9dM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PyWKj8Pz; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PyWKj8Pz"
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-ac0b6e8d96cso525323466b.0
        for <git@vger.kernel.org>; Wed, 05 Mar 2025 09:39:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741196355; x=1741801155; darn=vger.kernel.org;
        h=cc:to:references:in-reply-to:content-transfer-encoding:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hcTUfvh3gh5TaW/p6wjPT4xfAeXOvU1Kt1OXRiftibI=;
        b=PyWKj8Pz/MjmQ9bWzSRHsBTbnW9NevIN213luIZ9Z/ZzvhVZtZwzIy5b+Cejjf4o+8
         QsAErTf5ZAnhDsIVvqzG4fEwfXwIJ/QwgaoqBS9G8wPh6zvOxEtsWptZPhweb6i6vmsq
         fX9xP2qqnrB7OT6W24I72+bTA8pfd5FOnTU8UyDtIpNo9QfO6xkyX3ASBfdPD0tfTN9j
         aC4AMoMpPZvNmEwOEJ2VEUMz22/CXOHYxJj4UlVmjTU0757DsPrfDQrqpBF26YEGox08
         xuHmTg4bV+dDCRR8GgbzX5ktebbrD1N6DgnEv5YAnZzBR56ay7TPQFYNZWWxT04+s9N4
         QZgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741196355; x=1741801155;
        h=cc:to:references:in-reply-to:content-transfer-encoding:mime-version
         :message-id:date:subject:from:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=hcTUfvh3gh5TaW/p6wjPT4xfAeXOvU1Kt1OXRiftibI=;
        b=RDudi4pAYTMIgJOIgK82/iWIUcwdCwn9pgoxucHzrfz5pUnS88xL5Can+Z9heIE0ra
         fNUgTXYdXwKqfwV9Z8uD61JZJnA9jsgitSZbcY5efYhfy1nUJQaOFovOKfPbLLk+TPCv
         OKZrrehTtMw0yz2nWUb+idNuz7GIFO++CYCpLtq+4VCBTMRniQqY11zJkpaLn/Uq6G2X
         rxRJD0w+e6TYgm33Ao4iPKc+6F9wCl1sLskUAziPgc+Py9DyR6ApPWKk9o2DFuZWvN1A
         J5VcYdgWMJVGHFTbtKvYzsGr/BpXemrC9WG+6MjDH23/ZM16A4z+jgc4zYZcKPscThf6
         SDNw==
X-Gm-Message-State: AOJu0YySaMPLmT1veoCA6Ri1mCYemDVbpNgNLYn0itF0G+6Z2YQZeAVQ
	gUln0IhQYPGeD04MrOz4jQxcE62ghTDJziTsG5AgdeH1bXdY73mFex91MOz6
X-Gm-Gg: ASbGncuiu+8sikOCFlvX7LOg0TQ6GhqRzEcb/k+NUW0zCJaDADtJNhvyj52vlB86G2U
	LfqH9ZqoPec3BLufTZ+Vs5vK2ZvPxauBADxZcQJq4ii0qjq09X/4CSpee7Ea7O76Vyz8DkMCUVa
	+7sq8tjMBmCR/D5AF532KIKcmY6JYqwIhugKeqIVdPJkOUmGFi4pz/Y7lBZmivXSdPyeJgAqY5N
	S8rbEpjhS367qux/6bHVOQZdL5eBQaNLoQdjr78wmeHlgpUl8JgN6a2QwgzIq9Zfa1t+Lveet6b
	qJhF9b8Wfza3u6rMOdsvhhMfyKdHPRcElEG4WJvL5J1lmap9xg==
X-Google-Smtp-Source: AGHT+IGAFWfseSTaVzwetjzcE8wyylDjPyF7nJrEqBoIfC5bwaqakr9VKgKQsLMigwmN3xUPvsWnzQ==
X-Received: by 2002:a17:907:3d8b:b0:abf:6eed:3709 with SMTP id a640c23a62f3a-ac20d844308mr386166966b.6.1741196354168;
        Wed, 05 Mar 2025 09:39:14 -0800 (PST)
Received: from [127.0.0.2] ([2a02:2455:8268:bc00:8a90:b290:3a5b:4dd])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-abf3a8e2f53sm946851866b.115.2025.03.05.09.39.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Mar 2025 09:39:13 -0800 (PST)
From: Karthik Nayak <karthik.188@gmail.com>
Subject: [PATCH v3 0/8] refs: introduce support for partial reference
 transactions
Date: Wed, 05 Mar 2025 18:38:55 +0100
Message-Id: <20250305-245-partially-atomic-ref-updates-v3-0-0c64e3052354@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIADCMyGcC/43Nyw6CMBCF4VchXTumTCkXV76HcTGWVifhlhaJh
 PDuFlbsdPnPJN9ZRLCebRCXZBHeThy472KoUyLMi7qnBa5jC5SYpShzwEzDQH5kapoZaOxbNuC
 tg/dQ02gDVM6WD1lKlWkjIjPEJ3/2ids99ovD2Pt5X5xwu264loj6Nz4hSDCOFKq8rHRdXJ8tc
 XM2fSs2fEoPoCz+ANMI2pxUXknnUNERXNf1C/dsSaohAQAA
X-Change-ID: 20241206-245-partially-atomic-ref-updates-9fe8b080345c
In-Reply-To: <20250207-245-partially-atomic-ref-updates-v1-0-e6a3690ff23a@gmail.com>
References: <20250207-245-partially-atomic-ref-updates-v1-0-e6a3690ff23a@gmail.com>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>, ps@pks.im, jltobler@gmail.com, 
 phillip.wood123@gmail.com
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=71274;
 i=karthik.188@gmail.com; h=from:subject:message-id;
 bh=eRZl+Qc13VCEghyWl7sXdbnNWHh1y3fWDeowWFk7+GI=;
 b=owJ4nAHtARL+kA0DAAoBPtWfJI5GjH8ByyZiAGfIjD9p09xxcfTmDtNhEa1J8K1Z/AaxScM1G
 6CbmGWlCD2xyokBswQAAQoAHRYhBFfOTH9jdXEPy2XGBj7VnySORox/BQJnyIw/AAoJED7VnySO
 Rox/5pkL/Ak+CWl4adijKIeA6HbU2ZrFVKCtTJBmhJb6oEWZ81SqNLOOX3hKeFBZrogJtKd8GjV
 FVrL54fOfygSIldFI5ew6FE4nPctvazWC8i8iEsZQbl0JRu4DZKuEmevXboDJZ4m1Ua0ugo/n22
 LNS3kv37DYcGb0Jq0XIOMSH19Oo1M3omzGXV9hDKvzzN9AtEeeVWZ4oQKUM3ICZIjp1/WBx5Qg4
 JAB+EFXganGpH1bj9d/V1PYaBol9h+ch8x7YkoTEZeVxPlMtrQrJ7X03G8Ry7oMUQngpJ6h9r1H
 TgFfpJTTbLx9F925nahGMjUJWFFRNF71WU5vdtbRS/JlttPMkabLQXb0ibskFJZ1F2+nK94x7Tz
 pydZhm35VLSIYjKbtqx6rcnnDfGEOP9PoFeiQROtEZQqd8cpoakWI9riCISmCwyvn7LfkfjLAwU
 VzVm3VyGCAfb/M6/i7WNCd4rDkw6dSEmdz/gixfLMZLf8Z1XqSuoRoIFghgBY8gzM6ihssfXDo7
 QA=
X-Developer-Key: i=karthik.188@gmail.com; a=openpgp;
 fpr=57CE4C7F6375710FCB65C6063ED59F248E468C7F

 Documentation/git-update-ref.adoc |  17 +-
 builtin/fetch.c                   |   2 +-
 builtin/update-ref.c              |  67 ++++-
 refs.c                            | 162 ++++++++++--
 refs.h                            |  76 ++++--
 refs/files-backend.c              | 314 +++++++++++-------------
 refs/packed-backend.c             |  69 +++---
 refs/refs-internal.h              |  51 +++-
 refs/reftable-backend.c           | 502 +++++++++++++++++++-------------------
 t/t1400-update-ref.sh             | 233 ++++++++++++++++++
 10 files changed, 971 insertions(+), 522 deletions(-)

Karthik Nayak (8):
      refs/files: remove redundant check in split_symref_update()
      refs: move duplicate refname update check to generic layer
      refs/files: remove duplicate duplicates check
      refs/reftable: extract code from the transaction preparation
      refs: introduce enum-based transaction error types
      refs: implement partial reference transaction support
      refs: support partial update rejections during F/D checks
      update-ref: add --allow-partial flag for stdin mode

Git's reference updates are traditionally all or nothing - when updating
multiple references in a transaction, either all updates succeed or none
do. While this behavior is generally desirable, it can be limiting in
certain scenarios, particularly with the reftable backend where batching
multiple reference updates is more efficient than performing them
sequentially.

This series introduces support for partial reference transactions,
allowing individual reference updates to fail while letting others
proceed. This capability is exposed through git-update-ref's
`--allow-partial` flag, which can be used in `--stdin` mode to batch
updates and handle failures gracefully.

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

With this groundwork in place, we implement the core partial transaction
support in the refs subsystem. This adds the necessary infrastructure to
track and report rejected updates while allowing transactions to proceed.
All reference backends are modified to support this behavior when enabled.

Finally, we expose this functionality to users through
git-update-ref(1)'s `--allow-partial` flag, complete with test coverage
and documentation. The flag is specifically limited to `--stdin` mode
where batching multiple updates is most relevant.

This enhancement improves Git's flexibility in handling reference
updates while maintaining the safety of atomic transactions by default.
It's particularly valuable for tools and workflows that need to handle
reference update failures gracefully without abandoning the entire batch
of updates.

This series is based on top of b838bf1938 (Merge branch 'master' of
https://github.com/j6t/gitk, 2025-02-20) with Patrick's series 'refs:
batch refname availability checks' [1] merged in.

[1]: https://lore.kernel.org/all/20250217-pks-update-ref-optimization-v1-0-a2b6d87a24af@pks.im/

---
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

Range-diff versus v2:

1:  a7a5f8c752 = 1:  1bd0878fd7 refs/files: remove redundant check in split_symref_update()
2:  61ebc1e133 = 2:  92181469bf refs: move duplicate refname update check to generic layer
3:  f54f3d7722 = 3:  6fb0b6b03d refs/files: remove duplicate duplicates check
4:  463e043cd2 = 4:  07788f97e9 refs/reftable: extract code from the transaction preparation
5:  baa94ddfb6 ! 5:  2f872b650f refs: introduce enum-based transaction error types
    @@ Commit message
         refs: introduce enum-based transaction error types
     
         Replace preprocessor-defined transaction errors with a strongly-typed
    -    enum `transaction_error`. This change:
    +    enum `ref_transaction_error`. This change:
     
           - Improves type safety and function signature clarity.
           - Makes error handling more explicit and discoverable.
    @@ Commit message
     
         Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
     
    + ## builtin/fetch.c ##
    +@@ builtin/fetch.c: static int s_update_ref(const char *action,
    + 		switch (ref_transaction_commit(our_transaction, &err)) {
    + 		case 0:
    + 			break;
    +-		case TRANSACTION_NAME_CONFLICT:
    ++		case REF_TRANSACTION_ERROR_NAME_CONFLICT:
    + 			ret = STORE_REF_ERROR_DF_CONFLICT;
    + 			goto out;
    + 		default:
    +
      ## refs.c ##
    +@@ refs.c: int refs_update_symref_extended(struct ref_store *refs, const char *ref,
    + 					   REF_NO_DEREF, logmsg, &err))
    + 			goto error_return;
    + 		prepret = ref_transaction_prepare(transaction, &err);
    +-		if (prepret && prepret != TRANSACTION_CREATE_EXISTS)
    ++		if (prepret && prepret != REF_TRANSACTION_ERROR_CREATE_EXISTS)
    + 			goto error_return;
    + 	} else {
    + 		if (ref_transaction_update(transaction, ref, NULL, NULL,
    +@@ refs.c: int refs_update_symref_extended(struct ref_store *refs, const char *ref,
    + 		}
    + 	}
    + 
    +-	if (prepret == TRANSACTION_CREATE_EXISTS)
    ++	if (prepret == REF_TRANSACTION_ERROR_CREATE_EXISTS)
    + 		goto cleanup;
    + 
    + 	if (ref_transaction_commit(transaction, &err))
    +@@ refs.c: int ref_transaction_prepare(struct ref_transaction *transaction,
    + 
    + 	string_list_sort(&transaction->refnames);
    + 	if (ref_update_reject_duplicates(&transaction->refnames, err))
    +-		return TRANSACTION_GENERIC_ERROR;
    ++		return REF_TRANSACTION_ERROR_GENERIC;
    + 
    + 	ret = refs->be->transaction_prepare(refs, transaction, err);
    + 	if (ret)
     @@ refs.c: int ref_transaction_commit(struct ref_transaction *transaction,
      	return ret;
      }
    @@ refs.c: int ref_transaction_commit(struct ref_transaction *transaction,
     -				   const struct string_list *skip,
     -				   unsigned int initial_transaction,
     -				   struct strbuf *err)
    -+enum transaction_error refs_verify_refnames_available(struct ref_store *refs,
    -+						      const struct string_list *refnames,
    -+						      const struct string_list *extras,
    -+						      const struct string_list *skip,
    -+						      unsigned int initial_transaction,
    -+						      struct strbuf *err)
    ++enum ref_transaction_error refs_verify_refnames_available(struct ref_store *refs,
    ++					  const struct string_list *refnames,
    ++					  const struct string_list *extras,
    ++					  const struct string_list *skip,
    ++					  unsigned int initial_transaction,
    ++					  struct strbuf *err)
      {
      	struct strbuf dirname = STRBUF_INIT;
      	struct strbuf referent = STRBUF_INIT;
      	struct ref_iterator *iter = NULL;
      	struct strset dirnames;
     -	int ret = -1;
    -+	int ret = TRANSACTION_NAME_CONFLICT;
    ++	int ret = REF_TRANSACTION_ERROR_NAME_CONFLICT;
      
      	/*
      	 * For the sake of comments in this function, suppose that
    @@ refs.c: int refs_verify_refnames_available(struct ref_store *refs,
     -				  const struct string_list *skip,
     -				  unsigned int initial_transaction,
     -				  struct strbuf *err)
    -+enum transaction_error refs_verify_refname_available(struct ref_store *refs,
    -+						     const char *refname,
    -+						     const struct string_list *extras,
    -+						     const struct string_list *skip,
    -+						     unsigned int initial_transaction,
    -+						     struct strbuf *err)
    ++enum ref_transaction_error refs_verify_refname_available(
    ++	struct ref_store *refs,
    ++	const char *refname,
    ++	const struct string_list *extras,
    ++	const struct string_list *skip,
    ++	unsigned int initial_transaction,
    ++	struct strbuf *err)
      {
      	struct string_list_item item = { .string = (char *) refname };
      	struct string_list refnames = {
    @@ refs.c: int ref_update_has_null_new_value(struct ref_update *update)
      
     -int ref_update_check_old_target(const char *referent, struct ref_update *update,
     -				struct strbuf *err)
    -+enum transaction_error ref_update_check_old_target(const char *referent,
    -+					      struct ref_update *update,
    -+					      struct strbuf *err)
    ++enum ref_transaction_error ref_update_check_old_target(const char *referent,
    ++						       struct ref_update *update,
    ++						       struct strbuf *err)
      {
      	if (!update->old_target)
      		BUG("called without old_target set");
    - 
    +@@ refs.c: int ref_update_check_old_target(const char *referent, struct ref_update *update,
      	if (!strcmp(referent, update->old_target))
    --		return 0;
    -+		return TRANSACTION_OK;
    + 		return 0;
      
     -	if (!strcmp(referent, ""))
     +	if (!strcmp(referent, "")) {
    @@ refs.c: int ref_update_has_null_new_value(struct ref_update *update)
     -	else
     -		strbuf_addf(err, "verifying symref target: '%s': "
     -			    "is at %s but expected %s",
    -+		return TRANSACTION_NONEXISTENT_REF;
    ++		return REF_TRANSACTION_ERROR_NONEXISTENT_REF;
     +	}
     +
     +	strbuf_addf(err, "verifying symref target: '%s': is at %s but expected %s",
      			    ref_update_original_update_refname(update),
      			    referent, update->old_target);
     -	return -1;
    -+	return TRANSACTION_INCORRECT_OLD_VALUE;
    ++	return REF_TRANSACTION_ERROR_INCORRECT_OLD_VALUE;
      }
      
      struct migration_data {
    @@ refs.h: struct worktree;
      const char *ref_storage_format_to_name(enum ref_storage_format ref_storage_format);
      
     +/*
    -+ * enum transaction_error represents the following return codes:
    -+ * TRANSACTION_OK: success code.
    -+ * TRANSACTION_GENERIC_ERROR error_code: default error code.
    -+ * TRANSACTION_NAME_CONFLICT error_code: ref name conflict like A vs A/B.
    -+ * TRANSACTION_CREATE_EXISTS error_code: ref to be created already exists.
    -+ * TRANSACTION_NONEXISTENT_REF error_code: ref expected but doesn't exist.
    -+ * TRANSACTION_INCORRECT_OLD_VALUE error_code: provided old_oid or old_target of
    ++ * enum ref_transaction_error represents the following return codes:
    ++ * REF_TRANSACTION_ERROR_GENERIC error_code: default error code.
    ++ * REF_TRANSACTION_ERROR_NAME_CONFLICT error_code: ref name conflict like A vs A/B.
    ++ * REF_TRANSACTION_ERROR_CREATE_EXISTS error_code: ref to be created already exists.
    ++ * REF_TRANSACTION_ERROR_NONEXISTENT_REF error_code: ref expected but doesn't exist.
    ++ * REF_TRANSACTION_ERROR_INCORRECT_OLD_VALUE error_code: provided old_oid or old_target of
     + * reference doesn't match actual.
    -+ * TRANSACTION_INVALID_NEW_VALUE error_code: provided new_oid or new_target is
    ++ * REF_TRANSACTION_ERROR_INVALID_NEW_VALUE error_code: provided new_oid or new_target is
     + * invalid.
    -+ * TRANSACTION_EXPECTED_SYMREF error_code: expected ref to be symref, but is a
    ++ * REF_TRANSACTION_ERROR_EXPECTED_SYMREF error_code: expected ref to be symref, but is a
     + * regular ref.
     + */
    -+enum transaction_error {
    -+	TRANSACTION_OK = 0,
    -+	TRANSACTION_GENERIC_ERROR = -1,
    -+	TRANSACTION_NAME_CONFLICT = -2,
    -+	TRANSACTION_CREATE_EXISTS = -3,
    -+	TRANSACTION_NONEXISTENT_REF = -4,
    -+	TRANSACTION_INCORRECT_OLD_VALUE = -5,
    -+	TRANSACTION_INVALID_NEW_VALUE = -6,
    -+	TRANSACTION_EXPECTED_SYMREF = -7,
    ++enum ref_transaction_error {
    ++	REF_TRANSACTION_ERROR_GENERIC = -1,
    ++	REF_TRANSACTION_ERROR_NAME_CONFLICT = -2,
    ++	REF_TRANSACTION_ERROR_CREATE_EXISTS = -3,
    ++	REF_TRANSACTION_ERROR_NONEXISTENT_REF = -4,
    ++	REF_TRANSACTION_ERROR_INCORRECT_OLD_VALUE = -5,
    ++	REF_TRANSACTION_ERROR_INVALID_NEW_VALUE = -6,
    ++	REF_TRANSACTION_ERROR_EXPECTED_SYMREF = -7,
     +};
     +
      /*
    @@ refs.h: int refs_read_symbolic_ref(struct ref_store *ref_store, const char *refn
     -				  const struct string_list *skip,
     -				  unsigned int initial_transaction,
     -				  struct strbuf *err);
    -+enum transaction_error refs_verify_refname_available(struct ref_store *refs,
    -+						     const char *refname,
    -+						     const struct string_list *extras,
    -+						     const struct string_list *skip,
    -+						     unsigned int initial_transaction,
    -+						     struct strbuf *err);
    ++enum ref_transaction_error refs_verify_refname_available(struct ref_store *refs,
    ++						 const char *refname,
    ++						 const struct string_list *extras,
    ++						 const struct string_list *skip,
    ++						 unsigned int initial_transaction,
    ++						 struct strbuf *err);
      
      /*
       * Same as `refs_verify_refname_available()`, but checking for a list of
    @@ refs.h: int refs_read_symbolic_ref(struct ref_store *ref_store, const char *refn
     -				   const struct string_list *skip,
     -				   unsigned int initial_transaction,
     -				   struct strbuf *err);
    -+enum transaction_error refs_verify_refnames_available(struct ref_store *refs,
    -+						      const struct string_list *refnames,
    -+						      const struct string_list *extras,
    -+						      const struct string_list *skip,
    -+						      unsigned int initial_transaction,
    -+						      struct strbuf *err);
    ++enum ref_transaction_error refs_verify_refnames_available(struct ref_store *refs,
    ++					  const struct string_list *refnames,
    ++					  const struct string_list *extras,
    ++					  const struct string_list *skip,
    ++					  unsigned int initial_transaction,
    ++					  struct strbuf *err);
      
      int refs_ref_exists(struct ref_store *refs, const char *refname);
      
    @@ refs.h: int ref_transaction_verify(struct ref_transaction *transaction,
       * any needed locks, check preconditions, etc.; basically, do as much
     
      ## refs/files-backend.c ##
    +@@ refs/files-backend.c: static void unlock_ref(struct ref_lock *lock)
    +  * broken, lock the reference anyway but clear old_oid.
    +  *
    +  * Return 0 on success. On failure, write an error message to err and
    +- * return TRANSACTION_NAME_CONFLICT or TRANSACTION_GENERIC_ERROR.
    ++ * return REF_TRANSACTION_ERROR_NAME_CONFLICT or REF_TRANSACTION_ERROR_GENERIC.
    +  *
    +  * Implementation note: This function is basically
    +  *
     @@ refs/files-backend.c: static void unlock_ref(struct ref_lock *lock)
       *   avoided, namely if we were successfully able to read the ref
       * - Generate informative error messages in the case of failure
    @@ refs/files-backend.c: static void unlock_ref(struct ref_lock *lock)
     -			struct strbuf *referent,
     -			unsigned int *type,
     -			struct strbuf *err)
    -+static enum transaction_error lock_raw_ref(struct files_ref_store *refs,
    -+					   const char *refname, int mustexist,
    -+					   struct string_list *refnames_to_check,
    -+					   const struct string_list *extras,
    -+					   struct ref_lock **lock_p,
    -+					   struct strbuf *referent,
    -+					   unsigned int *type,
    -+					   struct strbuf *err)
    - {
    -+	enum transaction_error ret = TRANSACTION_GENERIC_ERROR;
    +-{
    ++static enum ref_transaction_error lock_raw_ref(struct files_ref_store *refs,
    ++					       const char *refname,
    ++					       int mustexist,
    ++					       struct string_list *refnames_to_check,
    ++					       const struct string_list *extras,
    ++					       struct ref_lock **lock_p,
    ++					       struct strbuf *referent,
    ++					       unsigned int *type,
    ++					       struct strbuf *err)
    ++{
    ++	enum ref_transaction_error ret = REF_TRANSACTION_ERROR_GENERIC;
      	struct ref_lock *lock;
      	struct strbuf ref_file = STRBUF_INIT;
      	int attempts_remaining = 3;
    @@ refs/files-backend.c: static int lock_raw_ref(struct files_ref_store *refs,
      				strbuf_reset(err);
      				strbuf_addf(err, "unable to resolve reference '%s'",
      					    refname);
    -+				ret = TRANSACTION_NONEXISTENT_REF;
    ++				ret = REF_TRANSACTION_ERROR_NONEXISTENT_REF;
      			} else {
      				/*
      				 * The error message set by
    + 				 * refs_verify_refname_available() is
    + 				 * OK.
    + 				 */
    +-				ret = TRANSACTION_NAME_CONFLICT;
    ++				ret = REF_TRANSACTION_ERROR_NAME_CONFLICT;
    + 			}
    + 		} else {
    + 			/*
     @@ refs/files-backend.c: static int lock_raw_ref(struct files_ref_store *refs,
      				/* Garden variety missing reference. */
      				strbuf_addf(err, "unable to resolve reference '%s'",
      					    refname);
    -+				ret = TRANSACTION_NONEXISTENT_REF;
    ++				ret = REF_TRANSACTION_ERROR_NONEXISTENT_REF;
      				goto error_return;
      			} else {
      				/*
    @@ refs/files-backend.c: static int lock_raw_ref(struct files_ref_store *refs,
      				/* Garden variety missing reference. */
      				strbuf_addf(err, "unable to resolve reference '%s'",
      					    refname);
    -+				ret = TRANSACTION_NONEXISTENT_REF;
    ++				ret = REF_TRANSACTION_ERROR_NONEXISTENT_REF;
      				goto error_return;
      			} else if (remove_dir_recursively(&ref_file,
      							  REMOVE_DIR_EMPTY_ONLY)) {
     @@ refs/files-backend.c: static int lock_raw_ref(struct files_ref_store *refs,
    - 		string_list_insert(refnames_to_check, refname);
    - 	}
    - 
    --	ret = 0;
    -+	ret = TRANSACTION_OK;
    - 	goto out;
    - 
    - error_return:
    + 					 * The error message set by
    + 					 * verify_refname_available() is OK.
    + 					 */
    +-					ret = TRANSACTION_NAME_CONFLICT;
    ++					ret = REF_TRANSACTION_ERROR_NAME_CONFLICT;
    + 					goto error_return;
    + 				} else {
    + 					/*
     @@ refs/files-backend.c: static int rename_tmp_log(struct files_ref_store *refs, const char *newrefname)
      	return ret;
      }
    @@ refs/files-backend.c: static int rename_tmp_log(struct files_ref_store *refs, co
     -				 struct ref_lock *lock,
     -				 const struct object_id *oid,
     -				 int skip_oid_verification, struct strbuf *err);
    -+static enum transaction_error write_ref_to_lockfile(struct files_ref_store *refs,
    -+						    struct ref_lock *lock,
    -+						    const struct object_id *oid,
    -+						    int skip_oid_verification, struct strbuf *err);
    ++static enum ref_transaction_error write_ref_to_lockfile(struct files_ref_store *refs,
    ++							struct ref_lock *lock,
    ++							const struct object_id *oid,
    ++							int skip_oid_verification,
    ++							struct strbuf *err);
      static int commit_ref_update(struct files_ref_store *refs,
      			     struct ref_lock *lock,
      			     const struct object_id *oid, const char *logmsg,
    @@ refs/files-backend.c: static int files_log_ref_write(struct files_ref_store *ref
     -				 struct ref_lock *lock,
     -				 const struct object_id *oid,
     -				 int skip_oid_verification, struct strbuf *err)
    -+static enum transaction_error write_ref_to_lockfile(struct files_ref_store *refs,
    -+						    struct ref_lock *lock,
    -+						    const struct object_id *oid,
    -+						    int skip_oid_verification,
    -+						    struct strbuf *err)
    ++static enum ref_transaction_error write_ref_to_lockfile(struct files_ref_store *refs,
    ++							struct ref_lock *lock,
    ++							const struct object_id *oid,
    ++							int skip_oid_verification,
    ++							struct strbuf *err)
      {
      	static char term = '\n';
      	struct object *o;
    @@ refs/files-backend.c: static int write_ref_to_lockfile(struct files_ref_store *r
      				lock->ref_name, oid_to_hex(oid));
      			unlock_ref(lock);
     -			return -1;
    -+			return TRANSACTION_INVALID_NEW_VALUE;
    ++			return REF_TRANSACTION_ERROR_INVALID_NEW_VALUE;
      		}
      		if (o->type != OBJ_COMMIT && is_branch(lock->ref_name)) {
      			strbuf_addf(
    @@ refs/files-backend.c: static int write_ref_to_lockfile(struct files_ref_store *r
      				oid_to_hex(oid), lock->ref_name);
      			unlock_ref(lock);
     -			return -1;
    -+			return TRANSACTION_INVALID_NEW_VALUE;
    ++			return REF_TRANSACTION_ERROR_INVALID_NEW_VALUE;
      		}
      	}
      	fd = get_lock_file_fd(&lock->lk);
    @@ refs/files-backend.c: static int write_ref_to_lockfile(struct files_ref_store *r
      			    "couldn't write '%s'", get_lock_file_path(&lock->lk));
      		unlock_ref(lock);
     -		return -1;
    -+		return TRANSACTION_GENERIC_ERROR;
    ++		return REF_TRANSACTION_ERROR_GENERIC;
      	}
    --	return 0;
    -+	return TRANSACTION_OK;
    + 	return 0;
      }
    - 
    - /*
     @@ refs/files-backend.c: static struct ref_iterator *files_reflog_iterator_begin(struct ref_store *ref_st
       * If update is a direct update of head_ref (the reference pointed to
       * by HEAD), then add an extra REF_LOG_ONLY update for HEAD.
    @@ refs/files-backend.c: static struct ref_iterator *files_reflog_iterator_begin(st
     -static int split_head_update(struct ref_update *update,
     -			     struct ref_transaction *transaction,
     -			     const char *head_ref, struct strbuf *err)
    -+static enum transaction_error split_head_update(struct ref_update *update,
    -+						struct ref_transaction *transaction,
    -+						const char *head_ref,
    -+						struct strbuf *err)
    ++static enum ref_transaction_error split_head_update(struct ref_update *update,
    ++						    struct ref_transaction *transaction,
    ++						    const char *head_ref,
    ++						    struct strbuf *err)
      {
      	struct ref_update *new_update;
      
     @@ refs/files-backend.c: static int split_head_update(struct ref_update *update,
    - 	    (update->flags & REF_SKIP_CREATE_REFLOG) ||
    - 	    (update->flags & REF_IS_PRUNING) ||
    - 	    (update->flags & REF_UPDATE_VIA_HEAD))
    --		return 0;
    -+		return TRANSACTION_OK;
    - 
    - 	if (strcmp(update->refname, head_ref))
    --		return 0;
    -+		return TRANSACTION_OK;
    - 
    - 	/*
    - 	 * First make sure that HEAD is not already in the
    -@@ refs/files-backend.c: static int split_head_update(struct ref_update *update,
    - 	if (strcmp(new_update->refname, "HEAD"))
    - 		BUG("%s unexpectedly not 'HEAD'", new_update->refname);
    - 
    --	return 0;
    -+	return TRANSACTION_OK;
    - }
    + 			    "multiple updates for 'HEAD' (including one "
    + 			    "via its referent '%s') are not allowed",
    + 			    update->refname);
    +-		return TRANSACTION_NAME_CONFLICT;
    ++		return REF_TRANSACTION_ERROR_NAME_CONFLICT;
    + 	}
      
    - /*
    + 	new_update = ref_transaction_add_update(
     @@ refs/files-backend.c: static int split_head_update(struct ref_update *update,
       * Note that the new update will itself be subject to splitting when
       * the iteration gets to it.
    @@ refs/files-backend.c: static int split_head_update(struct ref_update *update,
     -			       const char *referent,
     -			       struct ref_transaction *transaction,
     -			       struct strbuf *err)
    -+static enum transaction_error split_symref_update(struct ref_update *update,
    -+						  const char *referent,
    -+						  struct ref_transaction *transaction,
    -+						  struct strbuf *err)
    ++static enum ref_transaction_error split_symref_update(struct ref_update *update,
    ++						      const char *referent,
    ++						      struct ref_transaction *transaction,
    ++						      struct strbuf *err)
      {
      	struct ref_update *new_update;
      	unsigned int new_flags;
     @@ refs/files-backend.c: static int split_symref_update(struct ref_update *update,
    - 	update->flags |= REF_LOG_ONLY | REF_NO_DEREF;
    - 	update->flags &= ~REF_HAVE_OLD;
    - 
    --	return 0;
    -+	return TRANSACTION_OK;
    - }
    + 			    "multiple updates for '%s' (including one "
    + 			    "via symref '%s') are not allowed",
    + 			    referent, update->refname);
    +-		return TRANSACTION_NAME_CONFLICT;
    ++		return REF_TRANSACTION_ERROR_NAME_CONFLICT;
    + 	}
      
    - /*
    + 	new_flags = update->flags;
     @@ refs/files-backend.c: static int split_symref_update(struct ref_update *update,
       * everything is OK, return 0; otherwise, write an error message to
       * err and return -1.
       */
     -static int check_old_oid(struct ref_update *update, struct object_id *oid,
     -			 struct strbuf *err)
    -+static enum transaction_error check_old_oid(struct ref_update *update,
    -+					    struct object_id *oid,
    -+					    struct strbuf *err)
    ++static enum ref_transaction_error check_old_oid(struct ref_update *update,
    ++						struct object_id *oid,
    ++						struct strbuf *err)
      {
     -	int ret = TRANSACTION_GENERIC_ERROR;
     -
      	if (!(update->flags & REF_HAVE_OLD) ||
      		   oideq(oid, &update->old_oid))
    --		return 0;
    -+		return TRANSACTION_OK;
    - 
    - 	if (is_null_oid(&update->old_oid)) {
    + 		return 0;
    +@@ refs/files-backend.c: static int check_old_oid(struct ref_update *update, struct object_id *oid,
      		strbuf_addf(err, "cannot lock ref '%s': "
      			    "reference already exists",
      			    ref_update_original_update_refname(update));
     -		ret = TRANSACTION_CREATE_EXISTS;
     -	}
     -	else if (is_null_oid(oid))
    -+		return TRANSACTION_CREATE_EXISTS;
    ++		return REF_TRANSACTION_ERROR_CREATE_EXISTS;
     +	} else if (is_null_oid(oid)) {
      		strbuf_addf(err, "cannot lock ref '%s': "
      			    "reference is missing but expected %s",
    @@ refs/files-backend.c: static int split_symref_update(struct ref_update *update,
     -			    ref_update_original_update_refname(update),
     -			    oid_to_hex(oid),
     -			    oid_to_hex(&update->old_oid));
    -+		return TRANSACTION_NONEXISTENT_REF;
    ++		return REF_TRANSACTION_ERROR_NONEXISTENT_REF;
     +	}
      
     -	return ret;
    @@ refs/files-backend.c: static int split_symref_update(struct ref_update *update,
     +		    ref_update_original_update_refname(update), oid_to_hex(oid),
     +		    oid_to_hex(&update->old_oid));
     +
    -+	return TRANSACTION_INCORRECT_OLD_VALUE;
    ++	return REF_TRANSACTION_ERROR_INCORRECT_OLD_VALUE;
      }
      
      struct files_transaction_backend_data {
    @@ refs/files-backend.c: struct files_transaction_backend_data {
     -			       const char *head_ref,
     -			       struct string_list *refnames_to_check,
     -			       struct strbuf *err)
    -+static enum transaction_error lock_ref_for_update(struct files_ref_store *refs,
    -+						  struct ref_update *update,
    -+						  struct ref_transaction *transaction,
    -+						  const char *head_ref,
    -+						  struct string_list *refnames_to_check,
    -+						  struct strbuf *err)
    ++static enum ref_transaction_error lock_ref_for_update(struct files_ref_store *refs,
    ++						      struct ref_update *update,
    ++						      struct ref_transaction *transaction,
    ++						      const char *head_ref,
    ++						      struct string_list *refnames_to_check,
    ++						      struct strbuf *err)
      {
      	struct strbuf referent = STRBUF_INIT;
      	int mustexist = ref_update_expects_existing_old_ref(update);
      	struct files_transaction_backend_data *backend_data;
     -	int ret = 0;
    -+	enum transaction_error ret = TRANSACTION_OK;
    ++	enum ref_transaction_error ret = 0;
      	struct ref_lock *lock;
      
      	files_assert_main_repository(refs, "lock_ref_for_update");
     @@ refs/files-backend.c: static int lock_ref_for_update(struct files_ref_store *refs,
    + 					strbuf_addf(err, "cannot lock ref '%s': "
    + 						    "error reading reference",
    + 						    ref_update_original_update_refname(update));
    +-					ret = TRANSACTION_GENERIC_ERROR;
    ++					ret = REF_TRANSACTION_ERROR_GENERIC;
    + 					goto out;
      				}
      			}
      
    @@ refs/files-backend.c: static int lock_ref_for_update(struct files_ref_store *ref
     -				if  (ret) {
     -					goto out;
     -				}
    -+			if (ret) {
    +-			}
    ++			if (ret)
     +				goto out;
    - 			}
      		} else {
      			/*
    + 			 * Create a new update for the reference this
     @@ refs/files-backend.c: static int lock_ref_for_update(struct files_ref_store *refs,
      					   "but is a regular ref"),
      				    ref_update_original_update_refname(update),
      				    update->old_target);
     -			ret = TRANSACTION_GENERIC_ERROR;
    -+			ret = TRANSACTION_EXPECTED_SYMREF;
    ++			ret = REF_TRANSACTION_ERROR_EXPECTED_SYMREF;
      			goto out;
      		} else {
      			ret = check_old_oid(update, &lock->old_oid, err);
    +@@ refs/files-backend.c: static int lock_ref_for_update(struct files_ref_store *refs,
    + 
    + 	if (update->new_target && !(update->flags & REF_LOG_ONLY)) {
    + 		if (create_symref_lock(lock, update->new_target, err)) {
    +-			ret = TRANSACTION_GENERIC_ERROR;
    ++			ret = REF_TRANSACTION_ERROR_GENERIC;
    + 			goto out;
    + 		}
    + 
    + 		if (close_ref_gently(lock)) {
    + 			strbuf_addf(err, "couldn't close '%s.lock'",
    + 				    update->refname);
    +-			ret = TRANSACTION_GENERIC_ERROR;
    ++			ret = REF_TRANSACTION_ERROR_GENERIC;
    + 			goto out;
    + 		}
    + 
     @@ refs/files-backend.c: static int lock_ref_for_update(struct files_ref_store *refs,
      			 * The reference already has the desired
      			 * value, so we don't need to write it.
    @@ refs/files-backend.c: static int lock_ref_for_update(struct files_ref_store *ref
      		}
      	}
      	if (!(update->flags & REF_NEEDS_COMMIT)) {
    +@@ refs/files-backend.c: static int lock_ref_for_update(struct files_ref_store *refs,
    + 		if (close_ref_gently(lock)) {
    + 			strbuf_addf(err, "couldn't close '%s.lock'",
    + 				    update->refname);
    +-			ret = TRANSACTION_GENERIC_ERROR;
    ++			ret = REF_TRANSACTION_ERROR_GENERIC;
    + 			goto out;
    + 		}
    + 	}
    +@@ refs/files-backend.c: static int files_transaction_prepare(struct ref_store *ref_store,
    + 						refs->packed_ref_store,
    + 						transaction->flags, err);
    + 				if (!packed_transaction) {
    +-					ret = TRANSACTION_GENERIC_ERROR;
    ++					ret = REF_TRANSACTION_ERROR_GENERIC;
    + 					goto cleanup;
    + 				}
    + 
    +@@ refs/files-backend.c: static int files_transaction_prepare(struct ref_store *ref_store,
    + 	 */
    + 	if (refs_verify_refnames_available(refs->packed_ref_store, &refnames_to_check,
    + 					   &transaction->refnames, NULL, 0, err)) {
    +-		ret = TRANSACTION_NAME_CONFLICT;
    ++		ret = REF_TRANSACTION_ERROR_NAME_CONFLICT;
    + 		goto cleanup;
    + 	}
    + 
    + 	if (packed_transaction) {
    + 		if (packed_refs_lock(refs->packed_ref_store, 0, err)) {
    +-			ret = TRANSACTION_GENERIC_ERROR;
    ++			ret = REF_TRANSACTION_ERROR_GENERIC;
    + 			goto cleanup;
    + 		}
    + 		backend_data->packed_refs_locked = 1;
    +@@ refs/files-backend.c: static int files_transaction_prepare(struct ref_store *ref_store,
    + 			 */
    + 			backend_data->packed_transaction = NULL;
    + 			if (ref_transaction_abort(packed_transaction, err)) {
    +-				ret = TRANSACTION_GENERIC_ERROR;
    ++				ret = REF_TRANSACTION_ERROR_GENERIC;
    + 				goto cleanup;
    + 			}
    + 		}
    +@@ refs/files-backend.c: static int files_transaction_finish_initial(struct files_ref_store *refs,
    + 	packed_transaction = ref_store_transaction_begin(refs->packed_ref_store,
    + 							 transaction->flags, err);
    + 	if (!packed_transaction) {
    +-		ret = TRANSACTION_GENERIC_ERROR;
    ++		ret = REF_TRANSACTION_ERROR_GENERIC;
    + 		goto cleanup;
    + 	}
    + 
    +@@ refs/files-backend.c: static int files_transaction_finish_initial(struct files_ref_store *refs,
    + 			if (!loose_transaction) {
    + 				loose_transaction = ref_store_transaction_begin(&refs->base, 0, err);
    + 				if (!loose_transaction) {
    +-					ret = TRANSACTION_GENERIC_ERROR;
    ++					ret = REF_TRANSACTION_ERROR_GENERIC;
    + 					goto cleanup;
    + 				}
    + 			}
    +@@ refs/files-backend.c: static int files_transaction_finish_initial(struct files_ref_store *refs,
    + 	}
    + 
    + 	if (packed_refs_lock(refs->packed_ref_store, 0, err)) {
    +-		ret = TRANSACTION_GENERIC_ERROR;
    ++		ret = REF_TRANSACTION_ERROR_GENERIC;
    + 		goto cleanup;
    + 	}
    + 
    + 	if (refs_verify_refnames_available(&refs->base, &refnames_to_check,
    + 					   &affected_refnames, NULL, 1, err)) {
    + 		packed_refs_unlock(refs->packed_ref_store);
    +-		ret = TRANSACTION_NAME_CONFLICT;
    ++		ret = REF_TRANSACTION_ERROR_NAME_CONFLICT;
    + 		goto cleanup;
    + 	}
    + 
    + 	if (ref_transaction_commit(packed_transaction, err)) {
    +-		ret = TRANSACTION_GENERIC_ERROR;
    ++		ret = REF_TRANSACTION_ERROR_GENERIC;
    + 		goto cleanup;
    + 	}
    + 	packed_refs_unlock(refs->packed_ref_store);
    +@@ refs/files-backend.c: static int files_transaction_finish_initial(struct files_ref_store *refs,
    + 	if (loose_transaction) {
    + 		if (ref_transaction_prepare(loose_transaction, err) ||
    + 		    ref_transaction_commit(loose_transaction, err)) {
    +-			ret = TRANSACTION_GENERIC_ERROR;
    ++			ret = REF_TRANSACTION_ERROR_GENERIC;
    + 			goto cleanup;
    + 		}
    + 	}
    +@@ refs/files-backend.c: static int files_transaction_finish(struct ref_store *ref_store,
    + 		if (update->flags & REF_NEEDS_COMMIT ||
    + 		    update->flags & REF_LOG_ONLY) {
    + 			if (parse_and_write_reflog(refs, update, lock, err)) {
    +-				ret = TRANSACTION_GENERIC_ERROR;
    ++				ret = REF_TRANSACTION_ERROR_GENERIC;
    + 				goto cleanup;
    + 			}
    + 		}
    +@@ refs/files-backend.c: static int files_transaction_finish(struct ref_store *ref_store,
    + 				strbuf_addf(err, "couldn't set '%s'", lock->ref_name);
    + 				unlock_ref(lock);
    + 				update->backend_data = NULL;
    +-				ret = TRANSACTION_GENERIC_ERROR;
    ++				ret = REF_TRANSACTION_ERROR_GENERIC;
    + 				goto cleanup;
    + 			}
    + 		}
    +@@ refs/files-backend.c: static int files_transaction_finish(struct ref_store *ref_store,
    + 				strbuf_reset(&sb);
    + 				files_ref_path(refs, &sb, lock->ref_name);
    + 				if (unlink_or_msg(sb.buf, err)) {
    +-					ret = TRANSACTION_GENERIC_ERROR;
    ++					ret = REF_TRANSACTION_ERROR_GENERIC;
    + 					goto cleanup;
    + 				}
    + 			}
     
      ## refs/packed-backend.c ##
     @@ refs/packed-backend.c: static int packed_ref_store_remove_on_disk(struct ref_store *ref_store,
    @@ refs/packed-backend.c: static int packed_ref_store_remove_on_disk(struct ref_sto
     -static int write_with_updates(struct packed_ref_store *refs,
     -			      struct string_list *updates,
     -			      struct strbuf *err)
    -+static enum transaction_error write_with_updates(struct packed_ref_store *refs,
    -+						 struct string_list *updates,
    -+						 struct strbuf *err)
    ++static enum ref_transaction_error write_with_updates(struct packed_ref_store *refs,
    ++						     struct string_list *updates,
    ++						     struct strbuf *err)
      {
    -+	enum transaction_error ret = TRANSACTION_GENERIC_ERROR;
    ++	enum ref_transaction_error ret = REF_TRANSACTION_ERROR_GENERIC;
      	struct ref_iterator *iter = NULL;
      	size_t i;
      	int ok;
    @@ refs/packed-backend.c: static int write_with_updates(struct packed_ref_store *re
      			    sb.buf, strerror(errno));
      		strbuf_release(&sb);
     -		return -1;
    -+		return TRANSACTION_GENERIC_ERROR;
    ++		return REF_TRANSACTION_ERROR_GENERIC;
      	}
      	strbuf_release(&sb);
      
    @@ refs/packed-backend.c: static int write_with_updates(struct packed_ref_store *re
      					strbuf_addf(err, "cannot update ref '%s': "
      						    "reference already exists",
      						    update->refname);
    -+					ret = TRANSACTION_CREATE_EXISTS;
    ++					ret = REF_TRANSACTION_ERROR_CREATE_EXISTS;
      					goto error;
      				} else if (!oideq(&update->old_oid, iter->oid)) {
      					strbuf_addf(err, "cannot update ref '%s': "
    @@ refs/packed-backend.c: static int write_with_updates(struct packed_ref_store *re
      						    update->refname,
      						    oid_to_hex(iter->oid),
      						    oid_to_hex(&update->old_oid));
    -+					ret = TRANSACTION_INCORRECT_OLD_VALUE;
    ++					ret = REF_TRANSACTION_ERROR_INCORRECT_OLD_VALUE;
      					goto error;
      				}
      			}
    @@ refs/packed-backend.c: static int write_with_updates(struct packed_ref_store *re
      					    "reference is missing but expected %s",
      					    update->refname,
      					    oid_to_hex(&update->old_oid));
    -+				return TRANSACTION_NONEXISTENT_REF;
    ++				return REF_TRANSACTION_ERROR_NONEXISTENT_REF;
      				goto error;
      			}
      		}
    @@ refs/packed-backend.c: static int write_with_updates(struct packed_ref_store *re
      		strbuf_release(&sb);
      		delete_tempfile(&refs->tempfile);
     -		return -1;
    -+		return TRANSACTION_GENERIC_ERROR;
    ++		return REF_TRANSACTION_ERROR_GENERIC;
      	}
      
    --	return 0;
    -+	return TRANSACTION_OK;
    - 
    - write_error:
    - 	strbuf_addf(err, "error writing to %s: %s",
    + 	return 0;
     @@ refs/packed-backend.c: static int write_with_updates(struct packed_ref_store *refs,
      error:
      	ref_iterator_free(iter);
    @@ refs/packed-backend.c: static int write_with_updates(struct packed_ref_store *re
      }
      
      int is_packed_transaction_needed(struct ref_store *ref_store,
    +@@ refs/packed-backend.c: static int packed_transaction_prepare(struct ref_store *ref_store,
    + 			REF_STORE_READ | REF_STORE_WRITE | REF_STORE_ODB,
    + 			"ref_transaction_prepare");
    + 	struct packed_transaction_backend_data *data;
    +-	int ret = TRANSACTION_GENERIC_ERROR;
    ++	enum ref_transaction_error ret = REF_TRANSACTION_ERROR_GENERIC;
    + 
    + 	/*
    + 	 * Note that we *don't* skip transactions with zero updates,
     @@ refs/packed-backend.c: static int packed_transaction_prepare(struct ref_store *ref_store,
      		data->own_lock = 1;
      	}
    @@ refs/packed-backend.c: static int packed_transaction_prepare(struct ref_store *r
      		goto failure;
      
      	transaction->state = REF_TRANSACTION_PREPARED;
    +@@ refs/packed-backend.c: static int packed_transaction_finish(struct ref_store *ref_store,
    + 			ref_store,
    + 			REF_STORE_READ | REF_STORE_WRITE | REF_STORE_ODB,
    + 			"ref_transaction_finish");
    +-	int ret = TRANSACTION_GENERIC_ERROR;
    ++	int ret = REF_TRANSACTION_ERROR_GENERIC;
    + 	char *packed_refs_path;
    + 
    + 	clear_snapshot(refs);
     
      ## refs/refs-internal.h ##
     @@ refs/refs-internal.h: int ref_update_has_null_new_value(struct ref_update *update);
    @@ refs/refs-internal.h: int ref_update_has_null_new_value(struct ref_update *updat
       */
     -int ref_update_check_old_target(const char *referent, struct ref_update *update,
     -				struct strbuf *err);
    -+enum transaction_error ref_update_check_old_target(const char *referent,
    -+					      struct ref_update *update,
    -+					      struct strbuf *err);
    ++enum ref_transaction_error ref_update_check_old_target(const char *referent,
    ++						       struct ref_update *update,
    ++						       struct strbuf *err);
      
      /*
       * Check if the ref must exist, this means that the old_oid or
    @@ refs/reftable-backend.c: static int queue_transaction_update(struct reftable_ref
     -				 struct strbuf *head_referent,
     -				 struct strbuf *referent,
     -				 struct strbuf *err)
    -+static enum transaction_error prepare_single_update(struct reftable_ref_store *refs,
    -+						    struct reftable_transaction_data *tx_data,
    -+						    struct ref_transaction *transaction,
    -+						    struct reftable_backend *be,
    -+						    struct ref_update *u,
    -+						    struct string_list *refnames_to_check,
    -+						    unsigned int head_type,
    -+						    struct strbuf *head_referent,
    -+						    struct strbuf *referent,
    -+						    struct strbuf *err)
    ++static enum ref_transaction_error prepare_single_update(struct reftable_ref_store *refs,
    ++							struct reftable_transaction_data *tx_data,
    ++							struct ref_transaction *transaction,
    ++							struct reftable_backend *be,
    ++							struct ref_update *u,
    ++							struct string_list *refnames_to_check,
    ++							unsigned int head_type,
    ++							struct strbuf *head_referent,
    ++							struct strbuf *referent,
    ++							struct strbuf *err)
      {
    -+	enum transaction_error ret = TRANSACTION_OK;
    ++	enum ref_transaction_error ret = 0;
      	struct object_id current_oid = {0};
      	const char *rewritten_ref;
     -	int ret = 0;
    @@ refs/reftable-backend.c: static int prepare_single_update(struct reftable_ref_st
      	ret = backend_for(&be, refs, u->refname, &rewritten_ref, 0);
      	if (ret)
     -		return ret;
    -+		return TRANSACTION_GENERIC_ERROR;
    ++		return REF_TRANSACTION_ERROR_GENERIC;
      
      	/* Verify that the new object ID is valid. */
      	if ((u->flags & REF_HAVE_NEW) && !is_null_oid(&u->new_oid) &&
    @@ refs/reftable-backend.c: static int prepare_single_update(struct reftable_ref_st
      				    _("trying to write ref '%s' with nonexistent object %s"),
      				    u->refname, oid_to_hex(&u->new_oid));
     -			return -1;
    -+			return TRANSACTION_INVALID_NEW_VALUE;
    ++			return REF_TRANSACTION_ERROR_INVALID_NEW_VALUE;
      		}
      
      		if (o->type != OBJ_COMMIT && is_branch(u->refname)) {
      			strbuf_addf(err, _("trying to write non-commit object %s to branch '%s'"),
      				    oid_to_hex(&u->new_oid), u->refname);
     -			return -1;
    -+			return TRANSACTION_INVALID_NEW_VALUE;
    ++			return REF_TRANSACTION_ERROR_INVALID_NEW_VALUE;
      		}
      	}
      
    +@@ refs/reftable-backend.c: static int prepare_single_update(struct reftable_ref_store *refs,
    + 				    _("multiple updates for 'HEAD' (including one "
    + 				      "via its referent '%s') are not allowed"),
    + 				    u->refname);
    +-			return TRANSACTION_NAME_CONFLICT;
    ++			return REF_TRANSACTION_ERROR_NAME_CONFLICT;
    + 		}
    + 
    + 		ref_transaction_add_update(
     @@ refs/reftable-backend.c: static int prepare_single_update(struct reftable_ref_store *refs,
      	ret = reftable_backend_read_ref(be, rewritten_ref,
      					&current_oid, referent, &u->type);
      	if (ret < 0)
     -		return ret;
    -+		return TRANSACTION_GENERIC_ERROR;
    ++		return REF_TRANSACTION_ERROR_GENERIC;
      	if (ret > 0 && !ref_update_expects_existing_old_ref(u)) {
      		/*
      		 * The reference does not exist, and we either have no
    @@ refs/reftable-backend.c: static int prepare_single_update(struct reftable_ref_st
      						       &current_oid, err);
      			if (ret)
     -				return ret;
    -+				return TRANSACTION_GENERIC_ERROR;
    ++				return REF_TRANSACTION_ERROR_GENERIC;
      		}
      
      		return 0;
    @@ refs/reftable-backend.c: static int prepare_single_update(struct reftable_ref_st
      				   "unable to resolve reference '%s'"),
      			    ref_update_original_update_refname(u), u->refname);
     -		return -1;
    -+		return TRANSACTION_NONEXISTENT_REF;
    ++		return REF_TRANSACTION_ERROR_NONEXISTENT_REF;
      	}
      
      	if (u->type & REF_ISSYMREF) {
    @@ refs/reftable-backend.c: static int prepare_single_update(struct reftable_ref_st
      				strbuf_addf(err, _("cannot lock ref '%s': "
      						   "error reading reference"), u->refname);
     -				return -1;
    -+				return TRANSACTION_GENERIC_ERROR;
    ++				return REF_TRANSACTION_ERROR_GENERIC;
      			}
      		} else {
      			struct ref_update *new_update;
    +@@ refs/reftable-backend.c: static int prepare_single_update(struct reftable_ref_store *refs,
    + 					    _("multiple updates for '%s' (including one "
    + 					      "via symref '%s') are not allowed"),
    + 					    referent->buf, u->refname);
    +-				return TRANSACTION_NAME_CONFLICT;
    ++				return REF_TRANSACTION_ERROR_NAME_CONFLICT;
    + 			}
    + 
    + 			/*
     @@ refs/reftable-backend.c: static int prepare_single_update(struct reftable_ref_store *refs,
      					   "but is a regular ref"),
      				    ref_update_original_update_refname(u),
      				    u->old_target);
     -			return -1;
    -+			return TRANSACTION_EXPECTED_SYMREF;
    ++			return REF_TRANSACTION_ERROR_EXPECTED_SYMREF;
      		}
      
     -		if (ref_update_check_old_target(referent->buf, u, err)) {
     -			return -1;
    +-		}
     +		ret = ref_update_check_old_target(referent->buf, u, err);
    -+		if (ret) {
    ++		if (ret)
     +			return ret;
    - 		}
      	} else if ((u->flags & REF_HAVE_OLD) && !oideq(&current_oid, &u->old_oid)) {
      		if (is_null_oid(&u->old_oid)) {
    -@@ refs/reftable-backend.c: static int prepare_single_update(struct reftable_ref_store *refs,
    + 			strbuf_addf(err, _("cannot lock ref '%s': "
    + 					   "reference already exists"),
      				    ref_update_original_update_refname(u));
    - 			return TRANSACTION_CREATE_EXISTS;
    - 		}
    +-			return TRANSACTION_CREATE_EXISTS;
    +-		}
     -		else if (is_null_oid(&current_oid))
    -+		else if (is_null_oid(&current_oid)) {
    ++			return REF_TRANSACTION_ERROR_CREATE_EXISTS;
    ++		} else if (is_null_oid(&current_oid)) {
      			strbuf_addf(err, _("cannot lock ref '%s': "
      					   "reference is missing but expected %s"),
      				    ref_update_original_update_refname(u),
      				    oid_to_hex(&u->old_oid));
     -		else
    -+			return TRANSACTION_NONEXISTENT_REF;
    -+
    ++			return REF_TRANSACTION_ERROR_NONEXISTENT_REF;
     +		} else {
      			strbuf_addf(err, _("cannot lock ref '%s': "
      					   "is at %s but expected %s"),
    @@ refs/reftable-backend.c: static int prepare_single_update(struct reftable_ref_st
      				    oid_to_hex(&current_oid),
      				    oid_to_hex(&u->old_oid));
     -		return TRANSACTION_NAME_CONFLICT;
    -+			return TRANSACTION_INCORRECT_OLD_VALUE;
    ++			return REF_TRANSACTION_ERROR_INCORRECT_OLD_VALUE;
     +		}
      	}
      
    @@ refs/reftable-backend.c: static int prepare_single_update(struct reftable_ref_st
     -		return queue_transaction_update(refs, tx_data, u,
     -					       &current_oid, err);
     +		if (queue_transaction_update(refs, tx_data, u, &current_oid, err))
    -+			return TRANSACTION_GENERIC_ERROR;
    ++			return REF_TRANSACTION_ERROR_GENERIC;
      
    --	return 0;
    -+	return TRANSACTION_OK;
    + 	return 0;
      }
    - 
    - static int reftable_be_transaction_prepare(struct ref_store *ref_store,
     @@ refs/reftable-backend.c: static int reftable_be_transaction_prepare(struct ref_store *ref_store,
      	transaction->state = REF_TRANSACTION_PREPARED;
      
6:  49a0e65427 ! 6:  73f8970cb9 refs: implement partial reference transaction support
    @@ Commit message
         'REF_TRANSACTION_ALLOW_PARTIAL'. When enabled, this flag allows
         individual reference updates that would typically cause the entire
         transaction to fail due to non-system-related errors to be marked as
    -    rejected while permitting other updates to proceed. Non-system-related
    -    errors include issues caused by user-provided input values, whereas
    -    system-related errors, such as I/O failures or memory issues, continue
    -    to result in a full transaction failure. This approach enhances
    -    flexibility while preserving transactional integrity where necessary.
    +    rejected while permitting other updates to proceed. System errors
    +    referred by 'REF_TRANSACTION_ERROR_GENERIC' continue to result in the
    +    entire transaction failing. This approach enhances flexibility while
    +    preserving transactional integrity where necessary.
     
         The implementation introduces several key components:
     
           - Add 'rejection_err' field to struct `ref_update` to track failed
             updates with failure reason.
     
    +      - Add a new struct `ref_transaction_rejections` and a field within
    +        `ref_transaction` to this struct to allow quick iteration over
    +        rejected updates.
    +
           - Modify reference backends (files, packed, reftable) to handle
             partial transactions by using `ref_transaction_set_rejected()`
             instead of failing the entire transaction when
    @@ Commit message
             examine which updates were rejected and why.
     
         This foundational change enables partial transaction support throughout
    -    the reference subsystem. The next commit will expose this capability to
    -    users by adding a `--allow-partial` flag to 'git-update-ref(1)',
    +    the reference subsystem. A following commit will expose this capability
    +    to users by adding a `--allow-partial` flag to 'git-update-ref(1)',
         providing both a user-facing feature and a testable implementation.
     
         Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
     
      ## refs.c ##
    +@@ refs.c: struct ref_transaction *ref_store_transaction_begin(struct ref_store *refs,
    + 	tr->ref_store = refs;
    + 	tr->flags = flags;
    + 	string_list_init_dup(&tr->refnames);
    ++
    ++	if (flags & REF_TRANSACTION_ALLOW_PARTIAL)
    ++		CALLOC_ARRAY(tr->rejections, 1);
    ++
    + 	return tr;
    + }
    + 
     @@ refs.c: void ref_transaction_free(struct ref_transaction *transaction)
    + 		free((char *)transaction->updates[i]->old_target);
    + 		free(transaction->updates[i]);
    + 	}
    ++
    ++	if (transaction->rejections)
    ++		free(transaction->rejections->update_indices);
    ++	free(transaction->rejections);
    ++
    + 	string_list_clear(&transaction->refnames, 0);
    + 	free(transaction->updates);
      	free(transaction);
      }
      
    -+void ref_transaction_set_rejected(struct ref_transaction *transaction,
    -+				  size_t update_idx,
    -+				  enum transaction_error err)
    ++int ref_transaction_maybe_set_rejected(struct ref_transaction *transaction,
    ++				       size_t update_idx,
    ++				       enum ref_transaction_error err)
     +{
     +	if (update_idx >= transaction->nr)
     +		BUG("trying to set rejection on invalid update index");
    ++
    ++	if (!(transaction->flags & REF_TRANSACTION_ALLOW_PARTIAL))
    ++		return 0;
    ++
    ++	if (!transaction->rejections)
    ++		BUG("transaction not inititalized with partial support");
    ++
    ++	/*
    ++	 * Don't accept generic errors, since these errors are not user
    ++	 * input related.
    ++	 */
    ++	if (err == REF_TRANSACTION_ERROR_GENERIC)
    ++		return 0;
    ++
     +	transaction->updates[update_idx]->rejection_err = err;
    ++	ALLOC_GROW(transaction->rejections->update_indices,
    ++		   transaction->rejections->nr + 1,
    ++		   transaction->rejections->alloc);
    ++	transaction->rejections->update_indices[transaction->rejections->nr++] = update_idx;
    ++
    ++	return 1;
     +}
     +
      struct ref_update *ref_transaction_add_update(
    @@ refs.c: struct ref_update *ref_transaction_add_update(
      	transaction->updates[transaction->nr++] = update;
      
      	update->flags = flags;
    -+	update->rejection_err = TRANSACTION_OK;
    ++	update->rejection_err = 0;
      
      	update->new_target = xstrdup_or_null(new_target);
      	update->old_target = xstrdup_or_null(old_target);
    @@ refs.c: void ref_transaction_for_each_queued_update(struct ref_transaction *tran
     +					      ref_transaction_for_each_rejected_update_fn cb,
     +					      void *cb_data)
     +{
    -+	if (!(transaction->flags & REF_TRANSACTION_ALLOW_PARTIAL))
    ++	if (!transaction->rejections)
     +		return;
     +
    -+	for (size_t i = 0; i < transaction->nr; i++) {
    -+		struct ref_update *update = transaction->updates[i];
    ++	for (size_t i = 0; i < transaction->rejections->nr; i++) {
    ++		size_t update_index = transaction->rejections->update_indices[i];
    ++		struct ref_update *update = transaction->updates[update_index];
     +
     +		if (!update->rejection_err)
     +			continue;
    @@ refs.h: void ref_transaction_for_each_queued_update(struct ref_transaction *tran
     +							 const struct object_id *new_oid,
     +							 const char *old_target,
     +							 const char *new_target,
    -+							 enum transaction_error err,
    ++							 enum ref_transaction_error err,
     +							 void *cb_data);
     +void ref_transaction_for_each_rejected_update(struct ref_transaction *transaction,
     +					      ref_transaction_for_each_rejected_update_fn cb,
    @@ refs/files-backend.c: static int files_transaction_prepare(struct ref_store *ref
      					  err);
     -		if (ret)
     +		if (ret) {
    -+			if (transaction->flags & REF_TRANSACTION_ALLOW_PARTIAL &&
    -+			    ret != TRANSACTION_GENERIC_ERROR) {
    -+				ref_transaction_set_rejected(transaction, i, ret);
    -+
    ++			if (ref_transaction_maybe_set_rejected(transaction, i, ret)) {
     +				strbuf_setlen(err, 0);
    -+				ret = TRANSACTION_OK;
    ++				ret = 0;
     +
     +				continue;
     +			}
    @@ refs/files-backend.c: static int files_transaction_prepare(struct ref_store *ref
      
      		if (update->flags & REF_DELETING &&
      		    !(update->flags & REF_LOG_ONLY) &&
    +@@ refs/files-backend.c: static int files_transaction_finish(struct ref_store *ref_store,
    + 		struct ref_update *update = transaction->updates[i];
    + 		struct ref_lock *lock = update->backend_data;
    + 
    ++		if (update->rejection_err)
    ++			continue;
    ++
    + 		if (update->flags & REF_NEEDS_COMMIT ||
    + 		    update->flags & REF_LOG_ONLY) {
    + 			if (parse_and_write_reflog(refs, update, lock, err)) {
     
      ## refs/packed-backend.c ##
     @@ refs/packed-backend.c: static int packed_ref_store_remove_on_disk(struct ref_store *ref_store,
       * remain locked when it is done.
       */
    - static enum transaction_error write_with_updates(struct packed_ref_store *refs,
    --						 struct string_list *updates,
    -+						 struct ref_transaction *transaction,
    - 						 struct strbuf *err)
    + static enum ref_transaction_error write_with_updates(struct packed_ref_store *refs,
    +-						     struct string_list *updates,
    ++						     struct ref_transaction *transaction,
    + 						     struct strbuf *err)
      {
    - 	enum transaction_error ret = TRANSACTION_GENERIC_ERROR;
    + 	enum ref_transaction_error ret = REF_TRANSACTION_ERROR_GENERIC;
     +	struct string_list *updates = &transaction->refnames;
      	struct ref_iterator *iter = NULL;
      	size_t i;
      	int ok;
    -@@ refs/packed-backend.c: static enum transaction_error write_with_updates(struct packed_ref_store *refs,
    +@@ refs/packed-backend.c: static enum ref_transaction_error write_with_updates(struct packed_ref_store *re
      						    "reference already exists",
      						    update->refname);
    - 					ret = TRANSACTION_CREATE_EXISTS;
    + 					ret = REF_TRANSACTION_ERROR_CREATE_EXISTS;
     +
    -+					if (transaction->flags & REF_TRANSACTION_ALLOW_PARTIAL) {
    -+						ref_transaction_set_rejected(transaction, i, ret);
    ++					if (ref_transaction_maybe_set_rejected(transaction, i, ret)) {
     +						strbuf_setlen(err, 0);
     +						ret = 0;
     +						continue;
    @@ refs/packed-backend.c: static enum transaction_error write_with_updates(struct p
      					goto error;
      				} else if (!oideq(&update->old_oid, iter->oid)) {
      					strbuf_addf(err, "cannot update ref '%s': "
    -@@ refs/packed-backend.c: static enum transaction_error write_with_updates(struct packed_ref_store *refs,
    +@@ refs/packed-backend.c: static enum ref_transaction_error write_with_updates(struct packed_ref_store *re
      						    oid_to_hex(iter->oid),
      						    oid_to_hex(&update->old_oid));
    - 					ret = TRANSACTION_INCORRECT_OLD_VALUE;
    + 					ret = REF_TRANSACTION_ERROR_INCORRECT_OLD_VALUE;
     +
    -+					if (transaction->flags & REF_TRANSACTION_ALLOW_PARTIAL) {
    -+						ref_transaction_set_rejected(transaction, i, ret);
    ++					if (ref_transaction_maybe_set_rejected(transaction, i, ret)) {
     +						strbuf_setlen(err, 0);
     +						ret = 0;
     +						continue;
    @@ refs/packed-backend.c: static enum transaction_error write_with_updates(struct p
      					goto error;
      				}
      			}
    -@@ refs/packed-backend.c: static enum transaction_error write_with_updates(struct packed_ref_store *refs,
    +@@ refs/packed-backend.c: static enum ref_transaction_error write_with_updates(struct packed_ref_store *re
      					    update->refname,
      					    oid_to_hex(&update->old_oid));
    - 				return TRANSACTION_NONEXISTENT_REF;
    + 				return REF_TRANSACTION_ERROR_NONEXISTENT_REF;
     +
    -+				if (transaction->flags & REF_TRANSACTION_ALLOW_PARTIAL) {
    -+					ref_transaction_set_rejected(transaction, i, ret);
    ++				if (ref_transaction_maybe_set_rejected(transaction, i, ret)) {
     +					strbuf_setlen(err, 0);
     +					ret = 0;
     +					continue;
    @@ refs/packed-backend.c: static enum transaction_error write_with_updates(struct p
      				goto error;
      			}
      		}
    -@@ refs/packed-backend.c: static enum transaction_error write_with_updates(struct packed_ref_store *refs,
    +@@ refs/packed-backend.c: static enum ref_transaction_error write_with_updates(struct packed_ref_store *re
      write_error:
      	strbuf_addf(err, "error writing to %s: %s",
      		    get_tempfile_path(refs->tempfile), strerror(errno));
    -+	ret = TRANSACTION_GENERIC_ERROR;
    ++	ret = REF_TRANSACTION_ERROR_GENERIC;
      
      error:
      	ref_iterator_free(iter);
    @@ refs/refs-internal.h: struct ref_update {
     +	/*
     +	 * Used in partial transactions to mark if a given update was rejected.
     +	 */
    -+	enum transaction_error rejection_err;
    ++	enum ref_transaction_error rejection_err;
     +
      	/*
      	 * If this ref_update was split off of a symref update via
    @@ refs/refs-internal.h: int refs_read_raw_ref(struct ref_store *ref_store, const c
      		      unsigned int *type, int *failure_errno);
      
     +/*
    -+ * Mark a given update as rejected with a given reason. To be used in conjuction
    -+ * with the `REF_TRANSACTION_ALLOW_PARTIAL` flag to allow partial transactions.
    ++ * Mark a given update as rejected with a given reason.
     + */
    -+void ref_transaction_set_rejected(struct ref_transaction *transaction,
    -+				  size_t update_idx,
    -+				  enum transaction_error err);
    ++int ref_transaction_maybe_set_rejected(struct ref_transaction *transaction,
    ++				       size_t update_idx,
    ++				       enum ref_transaction_error err);
     +
      /*
       * Add a ref_update with the specified properties to transaction, and
       * return a pointer to the new object. This function does not verify
    +@@ refs/refs-internal.h: enum ref_transaction_state {
    + 	REF_TRANSACTION_CLOSED   = 2
    + };
    + 
    ++/*
    ++ * Data structure to hold indices of updates which were rejected, when
    ++ * partial transactions where enabled. While the updates themselves hold
    ++ * the rejection error, this structure allows a transaction to iterate
    ++ * only over the rejected updates.
    ++ */
    ++struct ref_transaction_rejections {
    ++	size_t *update_indices;
    ++	size_t alloc;
    ++	size_t nr;
    ++};
    ++
    + /*
    +  * Data structure for holding a reference transaction, which can
    +  * consist of checks and updates to multiple references, carried out
    +@@ refs/refs-internal.h: struct ref_transaction {
    + 	size_t alloc;
    + 	size_t nr;
    + 	enum ref_transaction_state state;
    ++	struct ref_transaction_rejections *rejections;
    + 	void *backend_data;
    + 	unsigned int flags;
    + 	uint64_t max_index;
     
      ## refs/reftable-backend.c ##
     @@ refs/reftable-backend.c: static int reftable_be_transaction_prepare(struct ref_store *ref_store,
    @@ refs/reftable-backend.c: static int reftable_be_transaction_prepare(struct ref_s
      					    &head_referent, &referent, err);
     -		if (ret)
     +		if (ret) {
    -+			if (transaction->flags & REF_TRANSACTION_ALLOW_PARTIAL &&
    -+			    ret != TRANSACTION_GENERIC_ERROR) {
    -+				ref_transaction_set_rejected(transaction, i, ret);
    -+
    ++			if (ref_transaction_maybe_set_rejected(transaction, i, ret)) {
     +				strbuf_setlen(err, 0);
    -+				ret = TRANSACTION_OK;
    ++				ret = 0;
     +
     +				continue;
     +			}
    @@ refs/reftable-backend.c: static int reftable_be_transaction_prepare(struct ref_s
      	}
      
      	string_list_sort(&refnames_to_check);
    +@@ refs/reftable-backend.c: static int write_transaction_table(struct reftable_writer *writer, void *cb_data
    + 		struct reftable_transaction_update *tx_update = &arg->updates[i];
    + 		struct ref_update *u = tx_update->update;
    + 
    ++		if (u->rejection_err)
    ++			continue;
    ++
    + 		/*
    + 		 * Write a reflog entry when updating a ref to point to
    + 		 * something new in either of the following cases:
-:  ---------- > 7:  f0284388ce refs: support partial update rejections during F/D checks
7:  0dc37f87a7 ! 8:  f0e7c44eb7 update-ref: add --allow-partial flag for stdin mode
    @@ Commit message
     
           rejected SP (<old-oid> | <old-target>) SP (<new-oid> | <new-target>) SP <rejection-reason> LF
     
    -    or with `-z`:
    -
    -      rejected NUL (<old-oid> | <old-target>) NUL (<new-oid> | <new-target>) NUL <rejection-reason> NUL
    -
         Update the documentation to reflect this change and also tests to cover
         different scenarios where an update could be rejected.
     
    @@ Documentation/git-update-ref.adoc: performs all modifications together.  Specify
      Quote fields containing whitespace as if they were strings in C source
      code; i.e., surrounded by double-quotes and with backslash escapes.
      Use 40 "0" characters or the empty string to specify a zero value.  To
    -@@ Documentation/git-update-ref.adoc: quoting:
    - In this format, use 40 "0" to specify a zero value, and use the empty
    - string to specify a missing value.
    - 
    -+With `-z`, `--allow-partial` will print rejections in the following form:
    -+
    -+	rejected NUL (<old-oid> | <old-target>) NUL (<new-oid> | <new-target>) NUL <rejection-reason> NUL
    -+
    - In either format, values can be specified in any form that Git
    - recognizes as an object name.  Commands in any other format or a
    - repeated <ref> produce an error.  Command meanings are:
     
      ## builtin/update-ref.c ##
     @@
    @@ builtin/update-ref.c: static void parse_cmd_abort(struct ref_transaction *transa
     +				const struct object_id *new_oid,
     +				const char *old_target,
     +				const char *new_target,
    -+				enum transaction_error err,
    ++				enum ref_transaction_error err,
     +				void *cb_data UNUSED)
     +{
     +	struct strbuf sb = STRBUF_INIT;
    -+	char space = ' ';
     +	const char *reason = "";
     +
     +	switch (err) {
    -+	case TRANSACTION_NAME_CONFLICT:
    -+		reason = _("refname conflict");
    ++	case REF_TRANSACTION_ERROR_NAME_CONFLICT:
    ++		reason = "refname conflict";
     +		break;
    -+	case TRANSACTION_CREATE_EXISTS:
    -+		reason = _("reference already exists");
    ++	case REF_TRANSACTION_ERROR_CREATE_EXISTS:
    ++		reason = "reference already exists";
     +		break;
    -+	case TRANSACTION_NONEXISTENT_REF:
    -+		reason = _("reference does not exist");
    ++	case REF_TRANSACTION_ERROR_NONEXISTENT_REF:
    ++		reason = "reference does not exist";
     +		break;
    -+	case TRANSACTION_INCORRECT_OLD_VALUE:
    -+		reason = _("incorrect old value provided");
    ++	case REF_TRANSACTION_ERROR_INCORRECT_OLD_VALUE:
    ++		reason = "incorrect old value provided";
     +		break;
    -+	case TRANSACTION_INVALID_NEW_VALUE:
    -+		reason = _("invalid new value provided");
    ++	case REF_TRANSACTION_ERROR_INVALID_NEW_VALUE:
    ++		reason = "invalid new value provided";
     +		break;
    -+	case TRANSACTION_EXPECTED_SYMREF:
    -+		reason = _("expected symref but found regular ref");
    ++	case REF_TRANSACTION_ERROR_EXPECTED_SYMREF:
    ++		reason = "expected symref but found regular ref";
     +		break;
     +	default:
    -+		reason = _("unkown failure");
    ++		reason = "unkown failure";
     +	}
     +
    -+	if (!line_termination)
    -+		space = line_termination;
    -+
    -+	strbuf_addf(&sb, "rejected%c%s%c%s%c%c%s%c%s%c", space,
    -+		    refname, space, new_oid ? oid_to_hex(new_oid) : new_target,
    -+		    space, space, old_oid ? oid_to_hex(old_oid) : old_target,
    -+		    space, reason, line_termination);
    ++	strbuf_addf(&sb, "rejected %s %s %s %s\n", refname,
    ++		    new_oid ? oid_to_hex(new_oid) : new_target,
    ++		    old_oid ? oid_to_hex(old_oid) : old_target,
    ++		    reason);
     +
     +	fwrite(sb.buf, sb.len, 1, stdout);
     +	strbuf_release(&sb);
    -+	fflush(stdout);
     +}
     +
      static void parse_cmd_commit(struct ref_transaction *transaction,
    @@ builtin/update-ref.c: static void update_refs_stdin(void)
      		break;
      	case UPDATE_REFS_STARTED:
     @@ builtin/update-ref.c: int cmd_update_ref(int argc,
    - 	const char *refname, *oldval;
      	struct object_id oid, oldoid;
      	int delete = 0, no_deref = 0, read_stdin = 0, end_null = 0;
    --	int create_reflog = 0;
    -+	int create_reflog = 0, allow_partial = 0;
    + 	int create_reflog = 0;
     +	unsigned int flags = 0;
     +
      	struct option options[] = {
    @@ builtin/update-ref.c: int cmd_update_ref(int argc,
     +		update_refs_stdin(flags);
      		return 0;
     -	}
    -+	} else if (allow_partial)
    ++	} else if (flags & REF_TRANSACTION_ALLOW_PARTIAL)
     +		die("--allow-partial can only be used with --stdin");
      
      	if (end_null)
    @@ t/t1400-update-ref.sh: do
     +		)
     +	'
     +
    -+	# F/D conflicts on the files backend are resolved on an individual
    -+	# update level since refs are stored as files. On the reftable backend
    -+	# this check is batched to optimize for performance, so failures cannot
    -+	# be isolated to a single update.
    -+	test_expect_success REFFILES "stdin $type allow-partial refname conflict" '
    ++	test_expect_success "stdin $type allow-partial refname conflict" '
     +		git init repo &&
     +		test_when_finished "rm -fr repo" &&
     +		(
    @@ t/t1400-update-ref.sh: do
     +			test_cmp expect actual &&
     +			test_grep -q "refname conflict" stdout
     +		)
    ++	'
    ++
    ++	test_expect_success "stdin $type allow-partial refname conflict new ref" '
    ++		git init repo &&
    ++		test_when_finished "rm -fr repo" &&
    ++		(
    ++			cd repo &&
    ++			test_commit one &&
    ++			old_head=$(git rev-parse HEAD) &&
    ++			test_commit two &&
    ++			head=$(git rev-parse HEAD) &&
    ++			git update-ref refs/heads/ref/foo $head &&
    ++
    ++			format_command $type "update refs/heads/foo" "$old_head" "" >stdin &&
    ++			format_command $type "update refs/heads/ref" "$old_head" "" >>stdin &&
    ++			git update-ref $type --stdin --allow-partial <stdin >stdout &&
    ++			echo $old_head >expect &&
    ++			git rev-parse refs/heads/foo >actual &&
    ++			test_cmp expect actual &&
    ++			test_grep -q "refname conflict" stdout
    ++		)
     +	'
      done
      


base-commit: f032e4cb6777d229cc1e662e142e99ef71741eb4
change-id: 20241206-245-partially-atomic-ref-updates-9fe8b080345c

Thanks
- Karthik

