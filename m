Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E51181635B6
	for <git@vger.kernel.org>; Wed,  1 May 2024 20:22:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714594956; cv=none; b=MbJpyUtgvsi9ZDiN6qcBEftSReKeagHyB9ybEJIdz+4aH7MXoZehmI+IrBPROGrFv0oDgPHThrjzACnG1/VErZ0NgCCON8gWHITCWKq4xsAfBAAqV8mgN+xbIocUNadFqPG6x7g/q25sQ/GMchEHQLl9KfZiNSan60ayrMgi5a4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714594956; c=relaxed/simple;
	bh=HvAZNHrnk/4YpX2mC8yG+16FqAFWukJRhfleqHGMl+I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=o9eIFKpgNjRxS8Dos4sbcqHMQmUf84U7XCOUC/XypNYHNs9ZwJfxDeAVdDaqaLKP3t8byOI1aMUYAsfpjBPVZ9o3uutNGkanBfPgME19ztul+ddYL1CzMaeP8znkJ58uNfivbLdg6wVZ2XDfDv2axVpOjF+Vpn1V/3rMGmd0rUs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Eo8fPil0; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Eo8fPil0"
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-a58fbbcd77aso473291266b.2
        for <git@vger.kernel.org>; Wed, 01 May 2024 13:22:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714594953; x=1715199753; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jYLhP6SdFLt3CFge7hf6+0AcUYCh/Uln3lPJE/vnVSE=;
        b=Eo8fPil08BTyTJq+e6wYtCIpREtbkIefI5SvYaBn5YCzwio7F9YF1ciXvUGD7zONFK
         GdwTSraFsJ4zO5thTUU1ZTKoO+gEyQm4a6H7AV1v6O/IHZ9WFa8GXbtN6jxeuueJ1eZ4
         4kRJCJh5R1pFhuk8R1b4It46eb7X87bZCaIY5a9FxalpAaHk9mQerQDlVi9efnyx8RNz
         Bf8+S5p53pJqRisn5hOgu6TjrigaX/HKz9WkyNwglofPxzgNfHWwV21SLuEAA/gJJXTi
         yrsyE1Q6MfN/p4t7zGAh2d1w4bFyaMX7rAyS8oDu5DibPcBPeCgT5oSU1AyChRa6+TKg
         u7AA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714594953; x=1715199753;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jYLhP6SdFLt3CFge7hf6+0AcUYCh/Uln3lPJE/vnVSE=;
        b=ab/qUArxwfP6igSrDVoS5TCve1y6VTNJP73V7I2RW30O0HlamiyCiRKMF0xBm1NmQo
         SFFKA5ijbj3gFoPyxIkyEW7dyj2fnojHKMKPVQw/EVTONhx3WaC0SttwikW9T5F5DmAY
         PfQcqXmIbNehGCGht7gtx0Vd74KYVvNEj0CQcDgv7/Zr1ucmlks46oSlzAX3MLFSn0fQ
         1t05KqzLGtRiiJ7B0flGtrnwbpBo0R/OFVqQOw1osmViQ+RV+nvMgubA/wi8eRRna1M1
         Jdo6h1H28YSCzyLzJGvxE6mMH+aK9oxwu7aWuZ3ZLnPbOmRMKCrYOPl4Xh7lAS/5plms
         8eXw==
X-Forwarded-Encrypted: i=1; AJvYcCUz/PNZfAd0OrnVxupWmVsswQJnvKL203hNhYHtoiLNye5DDSTwQdlJAgV+qxNBSxX/t/bRImm5c3wO5rcJXY9VTQgM
X-Gm-Message-State: AOJu0YwDCUaFGriTtWq74RR/X9Dx5RMhjpSLSJ+WkwRyPpTG5u+93GZv
	r0pzjdvITLHQIJ3/swsFLQODg39A6rCu7yB/W3QwRZw9q8v+JtiDgEimag==
X-Google-Smtp-Source: AGHT+IGFSY3VNRiFw/l6RXWLdkDkfkABcyQsCRs9DF+rMMlH9DFv/aYi4M/71Igq7XMXtgVmmj3hdg==
X-Received: by 2002:a17:906:d105:b0:a46:cef3:4aba with SMTP id b5-20020a170906d10500b00a46cef34abamr2327867ejz.75.1714594952895;
        Wed, 01 May 2024 13:22:32 -0700 (PDT)
Received: from laptop.fritz.box ([2a02:2455:826e:4900:8270:9642:2bfa:e177])
        by smtp.gmail.com with ESMTPSA id hg25-20020a170906f35900b00a58eec6f5acsm5290686ejb.102.2024.05.01.13.22.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 May 2024 13:22:32 -0700 (PDT)
From: Karthik Nayak <karthik.188@gmail.com>
X-Google-Original-From: Karthik Nayak <knayak@gitlab.com>
To: karthik.188@gmail.com
Cc: christian.couder@gmail.com,
	git@vger.kernel.org,
	gitster@pobox.com,
	ps@pks.im
Subject: [PATCH v5 0/7] refs: add support for transactional symref updates
Date: Wed,  1 May 2024 22:22:22 +0200
Message-ID: <20240501202229.2695774-1-knayak@gitlab.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240426152449.228860-1-knayak@gitlab.com>
References: <20240426152449.228860-1-knayak@gitlab.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Karthik Nayak <karthik.188@gmail.com>

The patch series takes over from the existing patch series, wherein we
introduced symref-* commands to git-update-ref. Since there was a ton of
discussions on the UX of the patch series and its application, I thought it
would be best to shorten the series and split it into multiple smaller series.

This series adds transactional support for symrefs in the reference db. Then
we switch refs_create_symref() to start using transactions for symref updates.
This allows us to deprecate the create_symref code in the ref_storage_be
interface and remove all associated code which is no longer used.

The split was primarily done so we can merge the non-user facing parts of the
previous series. While pertaining the user facing components into another set
of patches wherein deeper discussion on the UX can be held without worrying
about the internal implementation. Also by using this new functionality in a
pre-existing command, we can leverage the existing tests to catch any
inconsistencies. One of which was how 'git-symbolic-ref' doesn't add reflog for
dangling symrefs, which I've modified my patch to do the same.

We also modify the reference transaction hook to support symrefs. For any symref
update the reference transaction hook will output the value with a 'ref:' prefix.

Previous versions:
V1: https://lore.kernel.org/git/20240330224623.579457-1-knayak@gitlab.com/
V2: https://lore.kernel.org/git/20240412095908.1134387-1-knayak@gitlab.com/
V3: https://lore.kernel.org/git/20240423212818.574123-1-knayak@gitlab.com/
V4: https://lore.kernel.org/r/20240426152449.228860-1-knayak@gitlab.com

Changes over v4 are:
- Dropped the patches for adding support in git-update-ref.
- Added changes to use transaction in 'refs_create_symref()' and
  deprecate 'create_symref'.
- Cleaned up the commit messages, documentation and comments.
- Added better handling, like if 'old_target' is set, the value of the
  reference is checked, irrelevant of its type.

Range diff:

1:  4a56e3ede4 ! 1:  a354190905 refs: accept symref values in `ref_transaction[_add]_update`
    @@ Metadata
     Author: Karthik Nayak <karthik.188@gmail.com>
     
      ## Commit message ##
    -    refs: accept symref values in `ref_transaction[_add]_update`
    +    refs: accept symref values in `ref_transaction_update()`
     
    -    The `ref_transaction[_add]_update` functions obtain ref information and
    -    flags to create a `ref_update` and add it to the transaction at hand.
    +    The function `ref_transaction_update()` obtains ref information and
    +    flags to create a `ref_update` and add them to the transaction at hand.
     
         To extend symref support in transactions, we need to also accept the
    -    old and new ref targets and process it. In this commit, let's add the
    -    required parameters to the function and modify all call sites.
    +    old and new ref targets and process it. This commit adds the required
    +    parameters to the function and modifies all call sites.
     
         The two parameters added are `new_target` and `old_target`. The
         `new_target` is used to denote what the reference should point to when
    -    the transaction is applied.
    +    the transaction is applied. Some functions allow this parameter to be
    +    NULL, meaning that the reference is not changed.
     
         The `old_target` denotes the value the reference must have before the
         update. Some functions allow this parameter to be NULL, meaning that the
         old value of the reference is not checked.
     
    -    The handling logic of these parameters will be added in consequent
    -    commits as we add symref commands to the '--stdin' mode of
    -    'git-update-ref'.
    +    We also update the internal function `ref_transaction_add_update()`
    +    similarly to take the two new parameters.
     
         Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
     
    @@ refs.c: struct ref_update *ref_transaction_add_update(
      		BUG("update called for transaction that is not open");
      
     +	if (old_oid && !is_null_oid(old_oid) && old_target)
    -+		BUG("Only one of old_oid and old_target should be non NULL");
    ++		BUG("only one of old_oid and old_target should be non NULL");
     +	if (new_oid && !is_null_oid(new_oid) && new_target)
    -+		BUG("Only one of new_oid and new_target should be non NULL");
    ++		BUG("only one of new_oid and new_target should be non NULL");
     +
      	FLEX_ALLOC_STR(update, refname, refname);
      	ALLOC_GROW(transaction->updates, transaction->nr + 1, transaction->alloc);
    @@ refs.h: struct ref_transaction *ref_transaction_begin(struct strbuf *err);
       *         transaction.
       *
     + *     new_target -- the target reference that the reference will be
    -+ *         update to point to. This takes precedence over new_oid when
    -+ *         set. If the reference is a regular reference, it will be
    -+ *         converted to a symbolic reference.
    ++ *         updated to point to. If the reference is a regular reference,
    ++ *         it will be converted to a symbolic reference. Cannot be set
    ++ *         together with `new_oid`. A copy of this value is made in the
    ++ *         transaction.
     + *
     + *     old_target -- the reference that the reference must be pointing to.
    -+ *         Will only be taken into account when the reference is a symbolic
    -+ *         reference.
    ++ *         Canont be set together with `old_oid`. A copy of this value is
    ++ *         made in the transaction.
     + *
       *     flags -- flags affecting the update, passed to
       *         update_ref_lock(). Possible flags: REF_NO_DEREF,
    @@ refs/refs-internal.h: struct ref_update {
     +	/*
     +	 * If set, point the reference to this value. This can also be
     +	 * used to convert regular references to become symbolic refs.
    ++	 * Cannot be set together with `new_oid`.
     +	 */
     +	const char *new_target;
     +
     +	/*
    -+	 * If set and the reference is a symbolic ref, check that the
    -+	 * reference previously pointed to this value.
    ++	 * If set, check that the reference previously pointed to this
    ++	 * value. Cannot be set together with `old_oid`.
     +	 */
     +	const char *old_target;
     +
2:  496bf14f28 ! 2:  7dff21dbef files-backend: extract out `create_symref_lock`
    @@ Metadata
     Author: Karthik Nayak <karthik.188@gmail.com>
     
      ## Commit message ##
    -    files-backend: extract out `create_symref_lock`
    +    files-backend: extract out `create_symref_lock()`
     
    -    The function `create_symref_locked` creates a symref by creating a
    +    The function `create_symref_locked()` creates a symref by creating a
         '<symref>.lock' file and then committing the symref lock, which creates
         the final symref.
     
    -    Split this into two individual functions `create_and_commit_symref` and
    -    `create_symref_locked`. This way we can create the symref lock and
    -    commit it at different times. This will be used to provide symref
    -    support in `git-update-ref(1)`.
    +    Extract the early half of `create_symref_locked()` into a new helper
    +    function `create_symref_lock()`. Because the name of the new function is
    +    too similar to the original, rename the original to
    +    `create_and_commit_symref()` to avoid confusion.
    +
    +    The new function `create_symref_locked()` can be used to create the
    +    symref lock in a separate step from that of committing it. This allows
    +    to add transactional support for symrefs, where the lock would be
    +    created in the preparation step and the lock would be committed in the
    +    finish step.
     
         Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
     
    @@ refs/files-backend.c: static void update_symref_reflog(struct files_ref_store *r
     +		return error("unable to fdopen %s: %s",
     +			     get_lock_file_path(&lock->lk), strerror(errno));
     +
    -+	/* no error check; commit_ref will check ferror */
    -+	fprintf(get_lock_file_fp(&lock->lk), "ref: %s\n", target);
    ++	if (fprintf(get_lock_file_fp(&lock->lk), "ref: %s\n", target) < 0)
    ++		return error("unable to fprintf %s: %s",
    ++			     get_lock_file_path(&lock->lk), strerror(errno));
     +	return 0;
     +}
     +
    @@ refs/files-backend.c: static void update_symref_reflog(struct files_ref_store *r
     -	if (commit_ref(lock) < 0)
     -		return error("unable to write symref for %s: %s", refname,
     -			     strerror(errno));
    - 	return 0;
    +-	return 0;
    ++	return ret;
      }
      
    + static int files_create_symref(struct ref_store *ref_store,
     @@ refs/files-backend.c: static int files_create_symref(struct ref_store *ref_store,
      		return -1;
      	}
3:  6337859cbb < -:  ---------- update-ref: add support for 'symref-verify' command
4:  e611cb5a8c < -:  ---------- update-ref: add support for 'symref-delete' command
5:  37f8be2f3f < -:  ---------- update-ref: add support for 'symref-create' command
6:  b385f4d0d7 < -:  ---------- update-ref: add support for 'symref-update' command
7:  ef335e47d1 < -:  ---------- ref: support symrefs in 'reference-transaction' hook
-:  ---------- > 3:  901a586683 refs: support symrefs in 'reference-transaction' hook
-:  ---------- > 4:  6c97f6a660 refs: add support for transactional symref updates
-:  ---------- > 5:  5b55406430 refs: use transaction in `refs_create_symref()`
-:  ---------- > 6:  9e25816e68 refs: rename `refs_create_symref()` to `refs_update_symref()`
-:  ---------- > 7:  3836e25932 refs: remove `create_symref` and associated dead code


Karthik Nayak (7):
  refs: accept symref values in `ref_transaction_update()`
  files-backend: extract out `create_symref_lock()`
  refs: support symrefs in 'reference-transaction' hook
  refs: add support for transactional symref updates
  refs: use transaction in `refs_create_symref()`
  refs: rename `refs_create_symref()` to `refs_update_symref()`
  refs: remove `create_symref` and associated dead code

 Documentation/githooks.txt       |  14 ++-
 branch.c                         |   2 +-
 builtin/branch.c                 |   2 +-
 builtin/fast-import.c            |   5 +-
 builtin/fetch.c                  |   2 +-
 builtin/receive-pack.c           |   1 +
 builtin/replace.c                |   2 +-
 builtin/tag.c                    |   1 +
 builtin/update-ref.c             |   1 +
 builtin/worktree.c               |   2 +-
 refs.c                           |  87 +++++++++++----
 refs.h                           |  20 +++-
 refs/debug.c                     |  13 ---
 refs/files-backend.c             | 185 +++++++++++++++++++------------
 refs/packed-backend.c            |   1 -
 refs/refs-internal.h             |  26 ++++-
 refs/reftable-backend.c          | 159 +++++++++-----------------
 sequencer.c                      |   9 +-
 t/helper/test-ref-store.c        |   2 +-
 t/t0610-reftable-basics.sh       |   2 +-
 t/t1416-ref-transaction-hooks.sh |  23 ++++
 walker.c                         |   2 +-
 22 files changed, 321 insertions(+), 240 deletions(-)

-- 
2.43.GIT

