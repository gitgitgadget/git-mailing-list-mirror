Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED1DA3019C3
	for <git@vger.kernel.org>; Mon,  8 Sep 2025 12:37:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757335063; cv=none; b=C+LW7r3UZggopwb0repVIsHXJFiWbkZ26yccquoguv1fozWlw7tbUOu9tDR3yFLf7+Zk+pctC9DrxIUYxo5+bABP0h3y+Kt9NroquFgnpvmz24qSCDOh4YJqcsoaukeV+gNNik2YwTIOV0ErsNUgenXbLh6CGbJ1+0pokRzIkDE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757335063; c=relaxed/simple;
	bh=JXTrH4Jn+uiVyPwsYq55/GgYoUM2XQdo7bOKR6shmxY=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 In-Reply-To:References:To:Cc; b=k/1PKGXx6JmlEc1H3tvfKdJMQXfbKPGQ0l+rxs3YdZWc/RMT4fCa5UmuF6BzT/1RXMiqtahAxnBSx75zByOaiPk7IDtaRlLXybXlhPFP2vc+qO3/D9jnphanKsGthjjD2vg3NPF172UWFjT852wotgg5boekrr0I/13+cPVt6ps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VUhniF9S; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VUhniF9S"
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-62205eb63f9so4322958a12.3
        for <git@vger.kernel.org>; Mon, 08 Sep 2025 05:37:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757335059; x=1757939859; darn=vger.kernel.org;
        h=cc:to:references:in-reply-to:content-transfer-encoding:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6ZjMPu0d+VjGj9Vh91jZL2rIBh+sOZ5PFfQ8M2yhY+4=;
        b=VUhniF9SqF6HCUHv3GrYoWAKezcA1Cav61KB4nq72O6DVD9y9YIst+uLoLu4cr0y0k
         gZqWxBNxyaiVWm/dbbCBQOm8s3NdMmN23uoEl+xRHD86woJ8Y9WZpJTGjviYJF7vnbXq
         EzE2Tt1VbLmR4vrJ9zEtIifie/szTIr0dtzOy2kz7bsklRzY7qKHahlPFpWOvMVOTx6N
         0M+CeVkR6xTdBfzmliGN9XoWR8rnewU7goItxqsAWGlr7GERUm1yUW7PxevQWqBvLaH3
         wc+/ss0aeNKLR5euwtZ1QdYMalrjqxMQayfzi+9U7G2+Q9CbxUXCGDbsBNIxm96xJfHM
         +ABw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757335059; x=1757939859;
        h=cc:to:references:in-reply-to:content-transfer-encoding:mime-version
         :message-id:date:subject:from:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=6ZjMPu0d+VjGj9Vh91jZL2rIBh+sOZ5PFfQ8M2yhY+4=;
        b=n4VwpSyFHPSHCl7lshZ+hczV0aq8AR91aewK4Yr5utMuF+BhPA24wvGdOv3k+oYizg
         luwo9YX8k0S/2KQ2JZfZziT/+RLo2I0XJTljA5DpM2veu+nKf9n6LXvHTq9hNHU2ruOL
         i+FHG/fK4YWn6mr0DckK7Z+lm63z+qaP5orxS5rBvkehjpkcIKn9d8nuiA4I4qhun1W0
         97NMcvI3DWCviby/f8UVtkIxNVQf830qv9W4WV0gVU+vwi4lx/ZH6FXx7KrPKR3ZAHvl
         RVc1bfQu+mLv55vQsHnnd/aEEtVq9h/V3xCRpeaQgzr88A8hdkDEsTxVsPRAqmkqgBLp
         pbJg==
X-Gm-Message-State: AOJu0YyGYR8ndU0pT+w+iJYTJIQlZnwgrn6ueKXio3QEvCfKWqxl8uCV
	7G1Waem1T40YjuNLp7IHcTr1eIm21HlBFQL1aMuIeVOquThEn8dmVwj6DRif0ffO
X-Gm-Gg: ASbGncs8liWekN5gK9MXMXuywpXbP6CsN8AuXD4VcK5eLcn7eTW4b9KXHLDpWUObR3z
	ZIQINPxGTcojop1aX1mUgvtJPyoJonDX5tkhV3ghGg3BBSv2qp3Av9xMKdLmHZKBXGkH+7iyiYY
	KcihKtOT7PBPt102Q8LituDrLTSFtFxIxH0P2P0OvQZceJ7KmL4VzrS3n0nR+Chcu9HZlAlfJ+s
	IwSKRgSAEKxJ1Vmnq7XDW9arHfrwODxiWaCyTM3nejvq2S//KlSkxW35nCcxUxkvva6G5rkcs3b
	fbnMGVmttSluL+eilbJuAQkbklIhY0pYzngkA2xMci1/sOxuDYvclh5HKzE9VWs+lrK+G7kWCi4
	2/brdZmSY/iTj51+AOZ4utiIFBw50
X-Google-Smtp-Source: AGHT+IELZxVjlPxTyqBZS/x/3dewizvVIT+6d7hgnXf6E+/NkvYcFijU+71upCqwp19/LkGtUoYpow==
X-Received: by 2002:a05:6402:51d0:b0:61d:29c5:9a85 with SMTP id 4fb4d7f45d1cf-623729d5e98mr7293776a12.6.1757335058884;
        Mon, 08 Sep 2025 05:37:38 -0700 (PDT)
Received: from [127.0.0.2] ([2a02:2455:8268:bc00:c9f4:d82a:f11d:d7f9])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-61cfc1c7848sm23257445a12.2.2025.09.08.05.37.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Sep 2025 05:37:38 -0700 (PDT)
From: Karthik Nayak <karthik.188@gmail.com>
Subject: [PATCH v2 0/4] refs/files: fix issues with git-fetch on
 case-insensitive FS
Date: Mon, 08 Sep 2025 14:37:34 +0200
Message-Id: <20250908-587-git-fetch-1-fails-fetches-on-case-insensitive-repositories-v2-0-b2eb2459befb@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAA7OvmgC/6WOQQ6CMBBFr2K6dkxbrYAr72FYlDLAJNKSDmk0h
 Ltb4Aju5k3+zPuLYIyELB6nRURMxBR8Bn0+CTdY3yNQm1loqY0stQZTFtDTDB3ObgAFnaU3H4Q
 MwYOznI88o2eaKSFEnEIew+YBaVVZuMK6m0KRJVPEjj57gVedeSDOye/eJ6lte6gr+bc6KZBwN
 XivmqYxsmif/Zg/XFwYRb2u6w9Ya37xDAEAAA==
X-Change-ID: 20250822-587-git-fetch-1-fails-fetches-on-case-insensitive-repositories-0a187c7ac41e
In-Reply-To: <20250902-587-git-fetch-1-fails-fetches-on-case-insensitive-repositories-v1-0-35e69bbb507d@gmail.com>
References: <20250902-587-git-fetch-1-fails-fetches-on-case-insensitive-repositories-v1-0-35e69bbb507d@gmail.com>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>, 
 Joe Drew <joe.drew@indexexchange.com>, peff@peff.net, ps@pks.im, 
 gitster@pobox.com
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=18139;
 i=karthik.188@gmail.com; h=from:subject:message-id;
 bh=JXTrH4Jn+uiVyPwsYq55/GgYoUM2XQdo7bOKR6shmxY=;
 b=owJ4nAHtARL+kA0DAAoBPtWfJI5GjH8ByyZiAGi+zhEn72Nu+wVD1OlxhvP3rjUuTMEfYOtlb
 APIn6E7h+s8q4kBswQAAQoAHRYhBFfOTH9jdXEPy2XGBj7VnySORox/BQJovs4RAAoJED7VnySO
 Rox/QaIL/iuazNnHMdy5PFp2KV51hd8noogKwIKpArX/MjJycbnCGD0SbnQcO2+3laWY8cMzd8x
 pfhPtfi5xz+EtIdA8ITWEmUQpuarHekwqhotJPk1+EtsC7LOf8LSTHiWMjJdiHGeWhj3a3nvenB
 pKtXcreU3W7bqc4/f86VJiK4A+/wmUMYktsgVnZ04JdMuGUAe9yrHgYNKZR/3O0ShNV7pUM9Pf4
 x5DWJuvztb6ljyUiE0RFdS1+Cxvk417sKNrRbgWga8FqNYsCrWE5RpZagYVzxTtcKIOLTYFRT8G
 V8acBk4PvaiJYnyDdKpw8h1MdoNim0xlLeKKAw7GFbn0R1EAsRw1jFyOWag53g2vzDgMVg1vCZD
 hmbPRt7Fsb0EfRD3wRwnPxEDObLCvdCLpSHzGU353fRE5VaVW/7GPx1sN2+PjEmwMVOkmlz/Vw9
 77cRsghjx+4JiYsn7F6KRpzbZWZavN1jXvw+pkdZOg44Nk7mCnAj2sBJORw7IQXaQlkwrUWLDz5
 VQ=
X-Developer-Key: i=karthik.188@gmail.com; a=openpgp;
 fpr=57CE4C7F6375710FCB65C6063ED59F248E468C7F

Hello!

With Git 2.51 we moved 'git-fetch(1)' and 'git-receive-pack(1)' to use
batched updates while doing reference updates. This provided a nice perf
boost since both commands will now use a single transaction for
reference updates. This removes the overhead of using individual
transaction per reference update and also avoids unnecessary
auto-compaction between reference updates in the reftable backend.

However, in the files-backend it does introduce a few bugs around
conflicts. The reported bug was around case-insensitive filesystems [1],
but we also fix some adjacent issues:

1. When fetching references such as:

   - refs/heads/foo
   - refs/heads/Foo

Earlier we would simply overwrite the first reference with the second
and continue. Since Git 2.51 we simply abort stating a conflict.

This is resolved in the first commit by explicitly categorizing the
error as non-GENERIC. This allows batched updates to reject the
particular update, while updating the rest.

2. When fetching references and a lock for a particular reference
already exits. We treat this is a GENERIC error, which fails the entire
update. By categorizing this error as non-GENERIC, we can reject this
specific update and update the other references.

3. When fetching references such as with F/D conflict:

  - refs/heads/foo
  - refs/heads/Foo/bar

Earlier we would apply the first, while the second would fail due to
conflict. Since Git 2.51, the lock files for both would be created, but
the 'commit' phase would abruptly end leaving the lock files.

The second commit fixes this by ensuring that on case-insensitive
filesystems we lowercase the refnames for availability check to ensure
F/D are caught and reported to the user.

4. When fetching references with D/F conflict:

  - refs/heads/Foo/bar
  - refs/heads/foo

The creation of the second reference's lock in `lock_raw_ref()` catches
the D/F conflict, but we mark this as a GENERIC error. By categorizing
this as non-GENERIC, we can allow the updates to continue while
rejecting this specific error.

- Karthik

[1]: https://lore.kernel.org/all/YQXPR01MB3046197EF39296549EE6DD669A33A@YQXPR01MB3046.CANPRD01.PROD.OUTLOOK.COM/

Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
---
Changes in v2:
- This version fixes two more issues:
  - Fetching while locks already exist in the repository
  - D/F conflicts while fetching
- Add a specific error to the first case, so we can nicely show a
  relevant error. Also check explicitly that the issue is due to
  case-insensitive filesystems.
- Cleanup the commit messages.
- Use `string_list_append_nodup()` with `strbuf_detach`, reducing the
  number of allocations.

---
 builtin/fetch.c       | 21 ++++++++++--
 refs.c                | 10 +++++-
 refs.h                |  2 ++
 refs/files-backend.c  | 51 ++++++++++++++++++++++++-----
 t/t1400-update-ref.sh | 53 +++++++++++++++++++++++++++++++
 t/t5510-fetch.sh      | 88 ++++++++++++++++++++++++++++++++++++++++++++++++++-
 6 files changed, 212 insertions(+), 13 deletions(-)

Karthik Nayak (4):
      refs/files: catch conflicts on case-insensitive file-systems
      refs/files: use correct error type when lock exists
      refs/files: handle F/D conflicts in case-insensitive FS
      refs/files: handle D/F conflicts during locking

Range-diff versus v1:

1:  fe6e2c12e7 ! 1:  bab864e28a refs/files: use correct error type when locking fails
    @@ Metadata
     Author: Karthik Nayak <karthik.188@gmail.com>
     
      ## Commit message ##
    -    refs/files: use correct error type when locking fails
    +    refs/files: catch conflicts on case-insensitive file-systems
     
         During the 'prepare' phase of reference transaction in the files
         backend, we create the lock files for references to be created. When
    -    using batched updates on case-insensitive filesystems, the transactions
    -    would be aborted if there are conflicting names such as:
    +    using batched updates on case-insensitive filesystems, the entire
    +    batched updates would be aborted if there are conflicting names such as:
     
           refs/heads/Foo
           refs/heads/foo
     
         This affects all commands which were migrated to use batched updates in
         Git 2.51, including 'git-fetch(1)' and 'git-receive-pack(1)'. Before
    -    that, references updates would be applied serially with one transaction
    +    that, reference updates would be applied serially with one transaction
         used per update. When users fetched multiple references on
         case-insensitive systems, subsequent references would simply overwrite
         any earlier references. So when fetching:
    @@ Commit message
           refs/heads/foo: ec3053b0977e83d9b67fc32c4527a117953994f3
           refs/heads/sample: 2eefd1150e06d8fca1ddfa684dec016f36bf4e56
     
    -    This is buggy behavior since the user is never intimated about the
    +    This is buggy behavior since the user is never informed about the
         overrides performed and missing references. Nevertheless, the user is
         left with a working repository with a subset of the references. Since
    -    Git 2.51, in such situations fetches would simply fail without applying
    +    Git 2.51, in such situations fetches would simply fail without updating
         any references. Which is also buggy behavior and worse off since the
         user is left without any references.
     
         The error is triggered in `lock_raw_ref()` where the files backend
         attempts to create a lock file. When a lock file already exists the
    -    function returns a 'REF_TRANSACTION_ERROR_GENERIC'. Change this to return
    -    'REF_TRANSACTION_ERROR_CREATE_EXISTS' instead to aid the batched update
    -    mechanism to simply reject such errors.
    +    function returns a 'REF_TRANSACTION_ERROR_GENERIC'. When this happens,
    +    the entire batched updates, not individual operation, is aborted as if
    +    it were in a transaction.
    +
    +    Change this to return 'REF_TRANSACTION_ERROR_CASE_CONFLICT' instead to
    +    aid the batched update mechanism to simply reject such errors. The
    +    change only affects batched updates since batched updates will reject
    +    individual updates with non-generic errors. So specifically this would
    +    only affect:
    +
    +        1. git fetch
    +        2. git receive-pack
    +        3. git update-ref --batch-updates
     
         This bubbles the error type up to `files_transaction_prepare()` which
         tries to lock each reference update. So if the locking fails, we check
         if the rejection type can be ignored, which is done by calling
         `ref_transaction_maybe_set_rejected()`.
     
    -    As the error type is now 'REF_TRANSACTION_ERROR_CREATE_EXISTS', the
    -    specific reference update would simply be rejected, while other updates
    -    in the transaction would continue to be applied. This allows partial
    -    application of references in case-insensitive filesystems when fetching
    -    colliding references.
    +    As the error type is now 'REF_TRANSACTION_ERROR_CASE_CONFLICT',
    +    the specific reference update would simply be rejected, while other
    +    updates in the transaction would continue to be applied. This allows
    +    partial application of references in case-insensitive filesystems when
    +    fetching colliding references.
     
         While the earlier implementation allowed the last reference to be
         applied overriding the initial references, this change would allow the
         first reference to be applied while rejecting consequent collisions.
    -    This should be an OKAY compromise since with the files backend, there is
    +    This should be an okay compromise since with the files backend, there is
         no scenario possible where we would retain all colliding references.
     
    -    The change only affects batched updates since batched updates will
    -    reject individual updates with non-generic errors. So specifically this
    -    would only affect:
    -
    -        1. git fetch
    -        2. git receive-pack
    -        3. git update-ref --batch-updates
    -
         Let's also be more pro-active and notify users on case-insensitive
         filesystems about such problems by providing a brief about the issue
         while also recommending using the reftable backend, which doesn't have
         the same issue.
     
         Reported-by: Joe Drew <joe.drew@indexexchange.com>
    +    Helped-by: Patrick Steinhardt <ps@pks.im>
         Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
     
      ## builtin/fetch.c ##
    @@ builtin/fetch.c: static void ref_transaction_rejection_handler(const char *refna
      	struct ref_rejection_data *data = cb_data;
      
     -	if (err == REF_TRANSACTION_ERROR_NAME_CONFLICT && !data->conflict_msg_shown) {
    -+	if (err == REF_TRANSACTION_ERROR_CREATE_EXISTS && ignore_case &&
    ++	if (err == REF_TRANSACTION_ERROR_CASE_CONFLICT && ignore_case &&
     +	    !data->case_sensitive_msg_shown) {
     +		error(_("You're on a case-insensitive filesystem, and the remote you are\n"
     +			"trying to fetch from has references that only differ in casing. It\n"
    @@ builtin/fetch.c: static void ref_transaction_rejection_handler(const char *refna
      		const char *reason = ref_transaction_error_msg(err);
      
     
    + ## refs.c ##
    +@@ refs.c: const char *ref_transaction_error_msg(enum ref_transaction_error err)
    + 		return "invalid new value provided";
    + 	case REF_TRANSACTION_ERROR_EXPECTED_SYMREF:
    + 		return "expected symref but found regular ref";
    ++	case REF_TRANSACTION_ERROR_CASE_CONFLICT:
    ++		return "reference conflict due to case-insensitive filesystem";
    + 	default:
    + 		return "unknown failure";
    + 	}
    +
    + ## refs.h ##
    +@@ refs.h: enum ref_transaction_error {
    + 	REF_TRANSACTION_ERROR_INVALID_NEW_VALUE = -6,
    + 	/* Expected ref to be symref, but is a regular ref */
    + 	REF_TRANSACTION_ERROR_EXPECTED_SYMREF = -7,
    ++	/* Cannot create ref due to case-insensitive filesystem */
    ++	REF_TRANSACTION_ERROR_CASE_CONFLICT = -8,
    + };
    + 
    + /*
    +
      ## refs/files-backend.c ##
    +@@ refs/files-backend.c: static void unlock_ref(struct ref_lock *lock)
    + 	}
    + }
    + 
    ++static bool duplicate_reference_case_cmp(struct ref_transaction *transaction,
    ++					 struct ref_update *update)
    ++{
    ++	for (size_t i = 0; i < transaction->nr; i++) {
    ++		if (transaction->updates[i] == update)
    ++			break;
    ++
    ++		if (!strcasecmp(transaction->updates[i]->refname, update->refname))
    ++			return true;
    ++	}
    ++	return false;
    ++}
    ++
    + /*
    +  * Lock refname, without following symrefs, and set *lock_p to point
    +  * at a newly-allocated lock object. Fill in lock->old_oid, referent,
    +@@ refs/files-backend.c: static void unlock_ref(struct ref_lock *lock)
    +  * - Generate informative error messages in the case of failure
    +  */
    + static enum ref_transaction_error lock_raw_ref(struct files_ref_store *refs,
    +-					       struct ref_update *update,
    ++					       struct ref_transaction *transaction,
    + 					       size_t update_idx,
    + 					       int mustexist,
    + 					       struct string_list *refnames_to_check,
    +-					       const struct string_list *extras,
    + 					       struct ref_lock **lock_p,
    + 					       struct strbuf *referent,
    + 					       struct strbuf *err)
    + {
    + 	enum ref_transaction_error ret = REF_TRANSACTION_ERROR_GENERIC;
    ++	struct ref_update *update = transaction->updates[update_idx];
    ++	const struct string_list *extras = &transaction->refnames;
    + 	const char *refname = update->refname;
    + 	unsigned int *type = &update->type;
    + 	struct ref_lock *lock;
     @@ refs/files-backend.c: static enum ref_transaction_error lock_raw_ref(struct files_ref_store *refs,
      			goto retry;
      		} else {
      			unable_to_lock_message(ref_file.buf, myerr, err);
    -+			if (myerr == EEXIST)
    -+				ret = REF_TRANSACTION_ERROR_CREATE_EXISTS;
    ++			if (myerr == EEXIST && ignore_case &&
    ++			    duplicate_reference_case_cmp(transaction, update))
    ++				ret = REF_TRANSACTION_ERROR_CASE_CONFLICT;
      			goto error_return;
      		}
      	}
    +@@ refs/files-backend.c: static enum ref_transaction_error lock_ref_for_update(struct files_ref_store *re
    + 	if (lock) {
    + 		lock->count++;
    + 	} else {
    +-		ret = lock_raw_ref(refs, update, update_idx, mustexist,
    +-				   refnames_to_check, &transaction->refnames,
    +-				   &lock, &referent, err);
    ++		ret = lock_raw_ref(refs, transaction, update_idx, mustexist,
    ++				   refnames_to_check, &lock, &referent, err);
    + 		if (ret) {
    + 			char *reason;
    + 
     
      ## t/t1400-update-ref.sh ##
     @@ t/t1400-update-ref.sh: do
    @@ t/t1400-update-ref.sh: do
     +			test_commit two &&
     +			head=$(git rev-parse HEAD) &&
     +
    -+			format_command $type "create refs/heads/foo" "$head" >stdin &&
    -+			format_command $type "create refs/heads/ref" "$old_head" >>stdin &&
    -+			format_command $type "create refs/heads/Foo" "$old_head" >>stdin &&
    ++			{
    ++				format_command $type "create refs/heads/foo" "$head" &&
    ++				format_command $type "create refs/heads/ref" "$old_head" &&
    ++				format_command $type "create refs/heads/Foo" "$old_head"
    ++			} >stdin &&
    ++			git update-ref $type --stdin --batch-updates <stdin >stdout &&
    ++
    ++			echo $head >expect &&
    ++			git rev-parse refs/heads/foo >actual &&
    ++			echo $old_head >expect &&
    ++			git rev-parse refs/heads/ref >actual &&
    ++			test_cmp expect actual &&
    ++			test_grep -q "reference conflict due to case-insensitive filesystem" stdout
    ++		)
    ++	'
    ++
    ++	test_expect_success CASE_INSENSITIVE_FS "stdin $type batch-updates existing reference" '
    ++		git init --ref-format=reftable repo &&
    ++		test_when_finished "rm -fr repo" &&
    ++		(
    ++			cd repo &&
    ++			test_commit one &&
    ++			old_head=$(git rev-parse HEAD) &&
    ++			test_commit two &&
    ++			head=$(git rev-parse HEAD) &&
    ++
    ++			{
    ++				format_command $type "create refs/heads/foo" "$head" &&
    ++				format_command $type "create refs/heads/ref" "$old_head" &&
    ++				format_command $type "create refs/heads/Foo" "$old_head"
    ++			} >stdin &&
     +			git update-ref $type --stdin --batch-updates <stdin >stdout &&
     +
     +			echo $head >expect &&
    @@ t/t1400-update-ref.sh: do
     +			echo $old_head >expect &&
     +			git rev-parse refs/heads/ref >actual &&
     +			test_cmp expect actual &&
    -+			test_grep -q "reference already exists" stdout
    ++			git rev-parse refs/heads/Foo >actual &&
    ++			test_cmp expect actual
     +		)
     +	'
     +
-:  ---------- > 2:  b0ecf6f10d refs/files: use correct error type when lock exists
2:  30a2629ebc ! 3:  1842ddee90 refs/files: handle F/D conflicts in case-insensitive FS
    @@ Metadata
      ## Commit message ##
         refs/files: handle F/D conflicts in case-insensitive FS
     
    -    Similar to the previous commit, when using the files-backend on
    -    case-insensitive filesystems, there is possibility of hitting F/D
    -    conflicts when creating references within a single transaction, such as:
    +    When using the files-backend on case-insensitive filesystems, there is
    +    possibility of hitting F/D conflicts when creating references within a
    +    single transaction, such as:
     
           - 'refs/heads/foo'
           - 'refs/heads/Foo/bar'
    @@ Commit message
         which is responsible for checking F/D conflicts within a given
         transaction. This utility function is shared across the reference
         backends. As such, it doesn't consider the issues of using a
    -    case-insensitive, which only affects the files-backend.
    +    case-insensitive file system, which only affects the files-backend.
     
    -    While one solution would be to make the function aware of such issues.
    -    This feels like leaking implementation details of file-backend specific
    +    While one solution would be to make the function aware of such issues,
    +    this feels like leaking implementation details of file-backend specific
         issues into the utility function. So opt for the more simpler option, of
         lowercasing all references sent to this function when on a
         case-insensitive filesystem and operating on the files-backend.
    @@ refs/files-backend.c: static enum ref_transaction_error lock_raw_ref(struct file
     +			strbuf_addstr(&lower, refname);
     +			strbuf_tolower(&lower);
     +
    -+			item = string_list_append(refnames_to_check, lower.buf);
    -+			strbuf_release(&lower);
    ++			item = string_list_append_nodup(refnames_to_check,
    ++							strbuf_detach(&lower, NULL));
     +		} else {
     +			item = string_list_append(refnames_to_check, refname);
     +		}
    @@ t/t5510-fetch.sh: test_expect_success "clone and setup child repos" '
      	)
      '
      
    -@@ t/t5510-fetch.sh: test_expect_success CASE_INSENSITIVE_FS,REFFILES 'existing references in a case
    +@@ t/t5510-fetch.sh: test_expect_success REFFILES 'existing reference lock in repo' '
      	)
      '
      
-:  ---------- > 4:  81759b0e51 refs/files: handle D/F conflicts during locking


base-commit: c44beea485f0f2feaf460e2ac87fdd5608d63cf0
change-id: 20250822-587-git-fetch-1-fails-fetches-on-case-insensitive-repositories-0a187c7ac41e

Thanks
- Karthik

