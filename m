Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 229E181749
	for <git@vger.kernel.org>; Sat, 13 Sep 2025 20:54:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757796878; cv=none; b=mB3k41Zyy1Kj5FZU3IrUIsD6jkUmpkA2xJHjCjAQYi4eo7bKDsOiYBmZzf/cnyyZkz1zVHGjtfwoNv1UmSzayN46VXgCyOg6Oo1DYFcE3MIr1DQz5haAtOE728+VDiU9pQyim6s+ivFflAtKu3E0IV4Ea2iCGqQQV7pWeOoYCxE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757796878; c=relaxed/simple;
	bh=09gih4C2/2/XV03ARosVE3r2gqLpD1vFPYvangDyX+k=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 In-Reply-To:References:To:Cc; b=O/IrbjWPRbS+j5Po/Uocqu5KpeLdgV05zy1A4O/DE18j0cznuKFkDVCVjtekAfBOfDbzB2H/aA9LOPciDX88U880zE3xhOHqnA5secWLF9mGju7ltl5QtIPr7lsYIqy8+jbVwa8uNRmPdNu48cv/0J4JwxQzQDGbkCJqGkRucjQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=isazWYzC; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="isazWYzC"
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-b07c081660aso405132466b.0
        for <git@vger.kernel.org>; Sat, 13 Sep 2025 13:54:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757796874; x=1758401674; darn=vger.kernel.org;
        h=cc:to:references:in-reply-to:content-transfer-encoding:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=w9TFiIywqxkFJvCjt1SbfwGoa1ot54OZ7EwAgEuhf54=;
        b=isazWYzCh3iTfF6U2dJp0VF3omtmXznVcuJMkJSkG9Cdg2GY8ZyxHajevX4zsfzK+D
         O/XcGnzLL1ZvVwRf3tT7lVmNY3jHSwnqDP21nPRRSUbW2KvZcY15ce/ZIprePKxzb6nO
         PaCymQHQet/9KQOZDXxQ1Jpy1wMnUaBtS6Fh9MtrOeSGyrkMO1X6AoAbWf+sgz9jdpT5
         YMh8QcxZxE50JslM9i4I9+GNYfC0pNzzPn6swb2xhNAjg6gtNOVGwEy30lLN8XR3mD0U
         L0DycKpncIQE9nRY+X5dirsa5xJTgwW82YRXYhA8W5uG0l2gNmz0+m+RaalbX8f10+jw
         QrQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757796874; x=1758401674;
        h=cc:to:references:in-reply-to:content-transfer-encoding:mime-version
         :message-id:date:subject:from:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=w9TFiIywqxkFJvCjt1SbfwGoa1ot54OZ7EwAgEuhf54=;
        b=jFmQW2gzNCbBlPvp0rULmjjyXBghNPX6eVsarxz86WaB8b4OHYuAxvAiZsXCpOnNKO
         Izz1HBN38ZaRCJwsNEwFEQHFG0t/uexR+RPUVg5W2bQn+LGAOHhs4AkpLNqJE/pkzw7B
         m69RpgAlLRJ3GfqXJFA0jhGVBVMt5KKVDsAzDhsDy5S14VWZL5zRuZbf+QsfagcsjUcv
         HTUuUIohmNQSjFlzgz6sHZwIaUWpTViC1qphlLLqyBwuS3to1UbCN6AnGNFpn3rmAJro
         dRgJLupurAujpTlQ/GMEd3Wy6d5pflb0yNy5dVvVb106rtvjk4oCkXt8nu1sx0Q+tRmu
         k8kw==
X-Gm-Message-State: AOJu0YyI4ob+cqcGP5eHs1/HbO6/0PmynAvEtBO1UowsRjBRk7ino6wc
	zWU9WxirXBCZTXebzlZgr+qOkmsPJsgXbQ5uXl08S1vnm14AchamGjbE
X-Gm-Gg: ASbGncsoQ4GgtgZ6JQS7bPNUw/5NEcB4R5IYrD5pksIXDpqpsCTelq9eE37XB7W8X+1
	cGO5hMODFn8cw1Cwowia7pk207E4JGhxt1GJBqLWKNlbAIgC/In/MsbizN4M/zAdBsjEskHzED0
	EsWcjWDeZInO0Io6SwS/B+882xWMK3evg7dLjMvv18eB9epAoJhNvvbt+Tf6qC3kma/gh/DiQNp
	O31rkwS8e1jmA8TZ56hTkyFjkL11rYBvG0TB/PSkA4ll6dYo2y4nmAPAfD/BIUMz9dvLhx92EOV
	vgrxDr4WHMpiCKkyLaB8gGS3uHYtHlpyJy12/A+VxDSAalCVYKPZLkzETw3kMKEAv3VjAeHI+et
	duVPxGC2fEsmHC41vVQOCjFyAB+90R9ZnAVSYm6yTG3wsWYAiXA==
X-Google-Smtp-Source: AGHT+IFdHrqh92T2AuyMzBHS3u9GBqCRF+oICGM8gkpLvOzn9eyoyDmp91+h0LKdOMaZag2mAxG6RA==
X-Received: by 2002:a17:907:1c11:b0:b04:8420:b6ef with SMTP id a640c23a62f3a-b07c3a8c69cmr683092766b.61.1757796874018;
        Sat, 13 Sep 2025 13:54:34 -0700 (PDT)
Received: from [127.0.0.2] ([2a02:2455:8268:bc00:5b4f:6b96:ff06:27eb])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b07b32ef574sm635383466b.73.2025.09.13.13.54.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 13 Sep 2025 13:54:33 -0700 (PDT)
From: Karthik Nayak <karthik.188@gmail.com>
Subject: [PATCH v3 0/4] refs/files: fix issues with git-fetch on
 case-insensitive FS
Date: Sat, 13 Sep 2025 22:54:28 +0200
Message-Id: <20250913-587-git-fetch-1-fails-fetches-on-case-insensitive-repositories-v3-0-195569740b57@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAATaxWgC/6XOwQ6CMAwG4FcxO1uzTSbgyfcwHrZZoIluhpJFQ
 3h3i168e+vftP06K8aRkNVxM6sRCzHlJGG/3ag4+NQj0FWysto63VgLrqmhpwk6nOIABjpPN/4
 mZMgJomdZSoyJaaKCMOIjS5lXB7Q3TR1rHyuDSpDHiB09Pw+cL5IHYpl8ff4pZu1+6Vb/TRcDG
 vYOD20Iwen6eurvcmEX812tdLG/XPM3Z4ULFoOtXBuwC7/csixvz+3YrnsBAAA=
X-Change-ID: 20250822-587-git-fetch-1-fails-fetches-on-case-insensitive-repositories-0a187c7ac41e
In-Reply-To: <20250902-587-git-fetch-1-fails-fetches-on-case-insensitive-repositories-v1-0-35e69bbb507d@gmail.com>
References: <20250902-587-git-fetch-1-fails-fetches-on-case-insensitive-repositories-v1-0-35e69bbb507d@gmail.com>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>, joe.drew@indexexchange.com, 
 peff@peff.net, ps@pks.im, gitster@pobox.com
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=12052;
 i=karthik.188@gmail.com; h=from:subject:message-id;
 bh=09gih4C2/2/XV03ARosVE3r2gqLpD1vFPYvangDyX+k=;
 b=owJ4nAHtARL+kA0DAAoBPtWfJI5GjH8ByyZiAGjF2ggv8iph9rDTgF0d3yia2vjQj3Yneem87
 /RphsiKpxBJ7YkBswQAAQoAHRYhBFfOTH9jdXEPy2XGBj7VnySORox/BQJoxdoIAAoJED7VnySO
 Rox/VMIMAIQdYkf18ntUArUDE6cb0zKbWLmehhgg8zo4knqOTtAlIqgYZZv3gyEXVd306qFEH4U
 Jx+0Q/BDliPBcCnMLGz8inAqz16v8ggzXCu5QfI7VnE0dttJo3SzXfr2CbsVR06zHaUmG/LNp13
 7NQwJkF5U0o7u1MR2GFKLjGhZg9EMbOwt9pqHhknXpvsPLEWz0yblgKwocFOUcjPo9YXyDhdqo9
 xC2BM56dxg9UBCRmMq4i1/83NUZQDolS9ymL0Wr2ZuHpdYZmYx67burrQGOiswarS6DVrxImr4G
 ojnjhXF5YNpBcH0uvSKTtEKnkgPzOfNrfaChu4hA78/Ws0iTnpo5A06IKJkxpjdwfAc42ySrcb0
 EtHbbI5SipNgvf7SirfKdXy6DC1PxcT+at/Fh+mrjYc1e7KA29fPjK9/wHEAwK4RZRg97bqMK+C
 N8walRMVk5GEN/+uZZp7CWi6LuJJKsrWG2aYFjWZk/Imh/BN/4l7gcSPofm/ENZ5DGvSibFOVp6
 ds=
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

This also applies to D/F conflicts in case-sensitive systems where there
exists a lock in the repo 'refs/heads/foo/bar.lock' causing a conflict
while fetching 'refs/heads/foo'.

- Karthik

[1]: https://lore.kernel.org/all/YQXPR01MB3046197EF39296549EE6DD669A33A@YQXPR01MB3046.CANPRD01.PROD.OUTLOOK.COM/

Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
---
Changes in v3:
- Rename duplicate_reference_case_cmp() to
  transaction_has_case_conflicting_update() and add comments.
- Improve commit messages.
- Add an additional test in the 4th commit to showcase D/F conflicts in
  case-sensistive file systems.
- Link to v2: https://lore.kernel.org/r/20250908-587-git-fetch-1-fails-fetches-on-case-insensitive-repositories-v2-0-b2eb2459befb@gmail.com

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
 builtin/fetch.c       |  21 ++++++++--
 refs.c                |  11 ++++-
 refs.h                |   2 +
 refs/files-backend.c  |  77 ++++++++++++++++++++++++++++------
 t/t1400-update-ref.sh |  53 +++++++++++++++++++++++
 t/t5510-fetch.sh      | 114 +++++++++++++++++++++++++++++++++++++++++++++++++-
 6 files changed, 261 insertions(+), 17 deletions(-)

Karthik Nayak (4):
      refs/files: catch conflicts on case-insensitive file-systems
      refs/files: use correct error type when lock exists
      refs/files: handle F/D conflicts in case-insensitive FS
      refs/files: handle D/F conflicts during locking

Range-diff versus v2:

1:  570b24fc09 ! 1:  1d4ff64d90 refs/files: catch conflicts on case-insensitive file-systems
    @@ refs/files-backend.c: static void unlock_ref(struct ref_lock *lock)
      	}
      }
      
    -+static bool duplicate_reference_case_cmp(struct ref_transaction *transaction,
    -+					 struct ref_update *update)
    ++/*
    ++ * Check if the transaction has another update with a case-insensitive refname
    ++ * match.
    ++ *
    ++ * If the update is part of the transaction, we only check up to that index.
    ++ * Further updates are expected to call this function to match previous indices.
    ++ */
    ++static bool transaction_has_case_conflicting_update(struct ref_transaction *transaction,
    ++						    struct ref_update *update)
     +{
     +	for (size_t i = 0; i < transaction->nr; i++) {
     +		if (transaction->updates[i] == update)
    @@ refs/files-backend.c: static enum ref_transaction_error lock_raw_ref(struct file
      		} else {
      			unable_to_lock_message(ref_file.buf, myerr, err);
     +			if (myerr == EEXIST && ignore_case &&
    -+			    duplicate_reference_case_cmp(transaction, update))
    ++			    transaction_has_case_conflicting_update(transaction, update))
     +				ret = REF_TRANSACTION_ERROR_CASE_CONFLICT;
      			goto error_return;
      		}
2:  10bfb8c1f2 ! 2:  fdc69b233e refs/files: use correct error type when lock exists
    @@ Commit message
         refs/files: use correct error type when lock exists
     
         When fetching references into a repository, if a lock for a particular
    -    reference exists, then `lock_raw_ref()` throws the generic error
    -    'REF_TRANSACTION_ERROR_GENERIC'. This causes the entire set of batched
    -    updates to fail.
    +    reference exists, then `lock_raw_ref()` throws:
    +
    +        - REF_TRANSACTION_ERROR_CASE_CONFLICT: when there is a conflict
    +        because transaction contains conflicting references while being on a
    +        case-insensitive filesystem.
    +
    +        - REF_TRANSACTION_ERROR_GENERIC: for all other errors.
    +
    +    The latter causes the entire set of batched updates to fail, even in
    +    case sensitive filessystems.
     
         Instead, return a 'REF_TRANSACTION_ERROR_CREATE_EXISTS' error. This
         allows batched updates to reject the individual update which conflicts
    @@ refs/files-backend.c: static enum ref_transaction_error lock_raw_ref(struct file
      		} else {
      			unable_to_lock_message(ref_file.buf, myerr, err);
     -			if (myerr == EEXIST && ignore_case &&
    --			    duplicate_reference_case_cmp(transaction, update))
    +-			    transaction_has_case_conflicting_update(transaction, update))
     -				ret = REF_TRANSACTION_ERROR_CASE_CONFLICT;
     +			if (myerr == EEXIST) {
    -+				if (ignore_case && duplicate_reference_case_cmp(transaction, update))
    ++				if (ignore_case &&
    ++				    transaction_has_case_conflicting_update(transaction, update))
    ++					/*
    ++					 * In case-insensitive filesystems, ensure that conflicts within a
    ++					 * given transaction are handled. Pre-existing refs on a
    ++					 * case-insensitive system will be overridden without any issue.
    ++					 */
     +					ret = REF_TRANSACTION_ERROR_CASE_CONFLICT;
     +				else
    ++					/*
    ++					 * Pre-existing case-conflicting reference locks should also be
    ++					 * specially categorized to avoid failing all batched updates.
    ++					 */
     +					ret = REF_TRANSACTION_ERROR_CREATE_EXISTS;
     +			}
     +
3:  23868f2218 = 3:  ff7fb95b66 refs/files: handle F/D conflicts in case-insensitive FS
4:  5af3dc2a27 ! 4:  a610f9478b refs/files: handle D/F conflicts during locking
    @@ Metadata
      ## Commit message ##
         refs/files: handle D/F conflicts during locking
     
    -    The previous commit, added the necessary validation and checks for F/D
    +    The previous commit added the necessary validation and checks for F/D
         conflicts in the files backend when working on case insensitive systems.
     
         There is still a possibility for D/F conflicts. This is a different from
    @@ Commit message
             refs/heads/foo.lock
     
         As in `lock_raw_ref()` after creating the lock, we also check for D/F
    -    conflicts. To fix this, simply categorize the error as a name conflict.
    -    Also remove this reference from the list of valid refnames for
    -    availability checks.
    +    conflicts. This can occur in case-insensitive filesystems when trying to
    +    fetch case-conflicted references like:
     
    +        refs/heads/Foo/new
    +        refs/heads/foo
    +
    +    D/F conflicts can also occur in case-sensitive filesystems, when the
    +    repository already contains a directory with a lock file
    +    'refs/heads/foo/bar.lock' and trying to fetch 'refs/heads/foo'. This
    +    doesn't concern directories containing garbage files as those are
    +    handled on a higher level.
    +
    +    To fix this, simply categorize the error as a name conflict. Also remove
    +    this reference from the list of valid refnames for availability checks.
         By categorizing the error and removing it from the list of valid
         references, batched updates now knows to reject such reference updates
         and apply the other reference updates.
    @@ refs.c: int ref_transaction_maybe_set_rejected(struct ref_transaction *transacti
      		return 0;
      
     +	/*
    -+	 * Remove this refname from the list of refnames used for validation
    ++	 * Rejected refnames shouldn't be considered in the availability
    ++	 * checks, so remove them from the list.
     +	 */
     +	string_list_remove(&transaction->refnames,
     +			   transaction->updates[update_idx]->refname, 0);
    @@ refs/files-backend.c: static enum ref_transaction_error lock_raw_ref(struct file
      					goto error_return;
      				} else {
      					/*
    +-					 * We can't delete the directory,
    +-					 * but we also don't know of any
    +-					 * references that it should
    +-					 * contain.
    ++					 * Directory conflicts can occur if there
    ++					 * is an existing lock file in the directory
    ++					 * or if the filesystem is case-insensitive
    ++					 * and the directory contains a valid reference
    ++					 * but conflicts with the update.
    + 					 */
    + 					strbuf_addf(err, "there is a non-empty directory '%s' "
    + 						    "blocking reference '%s'",
     
      ## t/t5510-fetch.sh ##
     @@ t/t5510-fetch.sh: test_expect_success "clone and setup child repos" '
    @@ t/t5510-fetch.sh: test_expect_success CASE_INSENSITIVE_FS,REFFILES 'F/D conflict
     +		test_cmp expect actual
     +	)
     +'
    ++
    ++test_expect_success REFFILES 'D/F conflict on case sensitive filesystem with lock' '
    ++	(
    ++		git init --ref-format=reftable base &&
    ++		cd base &&
    ++		echo >file update &&
    ++		git add . &&
    ++		git commit -m "updated" &&
    ++		git branch -M main &&
    ++
    ++		git update-ref refs/heads/foo @ &&
    ++		git update-ref refs/heads/branch @ &&
    ++		cd .. &&
    ++
    ++		git init --ref-format=files --bare repo &&
    ++		cd repo &&
    ++		git remote add origin ../base &&
    ++		mkdir refs/heads/foo &&
    ++		touch refs/heads/foo/random.lock &&
    ++		test_must_fail git fetch origin "refs/heads/*:refs/heads/*" 2>err &&
    ++		test_grep "some local refs could not be updated; try running" err &&
    ++		git rev-parse refs/heads/main >expect &&
    ++		git rev-parse refs/heads/branch >actual &&
    ++		test_cmp expect actual
    ++	)
    ++'
     +
      . "$TEST_DIRECTORY"/lib-httpd.sh
      start_httpd


base-commit: c44beea485f0f2feaf460e2ac87fdd5608d63cf0
change-id: 20250822-587-git-fetch-1-fails-fetches-on-case-insensitive-repositories-0a187c7ac41e

Thanks
- Karthik

