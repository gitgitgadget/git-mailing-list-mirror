Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 540A53F1AB9
	for <git@vger.kernel.org>; Mon, 24 Aug 2026 09:31:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787563881; cv=none; b=LVp404vgxTfeyv8Mmjs0Db/FbJRoTUmAI7yoBzpT4IacyhUUGeWesGfFHh7XLBQDzES2EhnZVNiFVZ03t/yFX+XDEN1N94t7UjJ7QfVqrDaECXrG5r6nCWG4lV82rzG2b7r+hBQ07K0rogUD1/5n7IdaPpShBaIJEQgahxX8SvY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787563881; c=relaxed/simple;
	bh=loOGEMPUIc2hkO/I3PFNs/VdFiT+fQt3DKNNMwwP0AI=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 In-Reply-To:References:To:Cc; b=Fmzn/U6Gwb8ujtDAan7y0d4nhdpmLOFQAKMMkGaT88jgT6wqWriULqOstIrvn1MALem3IL6hHvbMMp+D3YTN/EvdgjnuOi+SbtUDULak9I4JuhWV4i/0vlzvx99hDA8p4jyPK5Ea0bfW/9b1bR/KGi61EH+mWxiYuKvYX1pMJks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AiC4LFiR; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AiC4LFiR"
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-c1c26d7e951so476429566b.0
        for <git@vger.kernel.org>; Mon, 24 Aug 2026 02:31:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787563874; x=1788168674; darn=vger.kernel.org;
        h=cc:to:references:in-reply-to:content-transfer-encoding:content-type
         :mime-version:message-id:date:subject:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=snq0n4aS5gdLcZKVXreZe6DNw7Suk7/vme1MNKnppgY=;
        b=AiC4LFiRIJgIcpVAaL6vkuvBFO+q4i4WMdEdT8+U774A9FdTE3pSTSp+2ido4DGXlz
         rmAoEiXjtHiOPofYzBlB+QqJfYqwPMDLdDYtQoP+A/IpdSbCQRJw9pTxOTnjNteFz6kz
         Thwlv8tMNJAqyp7rynFww1tJnZnjdlco4nVH5w/0BF2EPiEOXBonIsp9afNjGaMLUA1d
         XlfUfPUPnRDGyVwf+HzdTih+T9FwHlgdwaVY3b8bASSY5BEq2TFXfMMBF1+vfoo3of5k
         hCUvyY5vDwNLt0UWsP73C7AG0AmknoIoXAawjQjwq4kF2XKNVVp8DwA8PhLhUsUUK49l
         ocyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787563874; x=1788168674;
        h=cc:to:references:in-reply-to:content-transfer-encoding:content-type
         :mime-version:message-id:date:subject:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=snq0n4aS5gdLcZKVXreZe6DNw7Suk7/vme1MNKnppgY=;
        b=TTNqMGIZKlBIO5mSXD6kvw0OcK64ocl0TWEIar+ZrgYdV2vpv1seZ8LOGqsN1pJtKP
         xkstUz6Eoo/aakCp3JwLzGK2POaqJ3+HtdOfswnTvs/rngf7AqNF7lXx4A7iLOdeFdVN
         e7qJe6Xvc+7QYZCpl7PwHWofIE3yH2gZH8KAI+Gc+QmMfp4b/L+w+p4eSoR2OqJxazdE
         dJNTPybha/nWJ8W+kZ8jiRoBbdjy5I+YJkR9xMx2HngB2sKGyDWuF775hAhvy1+VCnG+
         pf207NGvsA2Q8oG6EmX0EqJcYbwhiO90YjPMgUPQbaioGivartYNwPhl5na6StoEU7/y
         8L1g==
X-Gm-Message-State: AFuF++k0g6oWtLqmZfqME6mIzZSjo6y8C9X7slujTR4/pPmCjHhJCvrw
	/bPje4HBNy0YsWruOmT7u2ixeH5HOIebdyNSWtTaGWkmKHWNFmS1X0/4
X-Gm-Gg: AR+sD13wfjWcFHyql6y0jmkiWFQp4C5SsYnKJrD64X15RrR4cslCn0H/F0+mMWO6Xbg
	4JmvgKfZAXyApTE7DTlktZqHJq3BkGYHPsuwmJYMQx7EXaZ1ulYnv6JadSOjbrKgqySpcAtFApJ
	kqCpisN1s1qW7VhmeNSZ1ChxQG6omCOgiewDm5JxN9RX059S5A/7KZ5lzoeIUhxsx3Gb5qITvo1
	nsDVmKSkdUxqseM4uJ6OHfe4qiFIy2gBPlUYGuPY5A8urJoBJpMgTnf4mcW+NtN4Tw0wTqXZaAY
	W2sZtwiYMVOvYrMRniBPxuvn3nwPKqtd4gswCmMHnXSBEfqxX3gThlGyHvv9p76Xovh8BcZdM1U
	9KdeltIBeUDPboGpMww1/w1TeIh4r9TXQlmVNeP8L8VnvBikn+9JRqOWgaovEQKc0ukKxElZIVF
	kWKmuPcaqa9MAATRabHWuzzU28HfmkfMLhoRTKCEg4sQ3Qj8r21uW9ICxbknfMZ327p3beeIsL8
	E/f9gjT8+FodKJ2/wgxB38+fIE3yoku1OaGJg==
X-Received: by 2002:a17:906:9fc4:b0:c16:101d:7afa with SMTP id a640c23a62f3a-c246a6266aemr2698771166b.16.1787563874151;
        Mon, 24 Aug 2026 02:31:14 -0700 (PDT)
Received: from [127.0.0.2] ([2a02:8109:d906:4e00:d6d5:360a:4ee9:3f53])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c24966f9cbcsm1303013566b.29.2026.08.24.02.31.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Aug 2026 02:31:13 -0700 (PDT)
From: Karthik Nayak <karthik.188@gmail.com>
Subject: [PATCH v2 0/4] reftable/stack: avoid reloading the stack when
 locked
Date: Mon, 24 Aug 2026 11:30:58 +0200
Message-Id: <20260824-740-optimize-reloading-the-reftable-stack-v2-0-9c9de2eb0af7@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/5WOTQ6CMBSEr0K69pkCBX9W3sOwKO0rPAVK2kpUw
 t2lGA/g8stM5puZeXSEnp2TmTmcyJMdVsh2CVOtHBoE0iuzjGclP6YCDoKDHQP19EZw2FmpaWg
 gtJFMkHWH4INUdzCFyaU2XHLF2bo3rjk9N9e1+rJ/1DdUIQpioyUfrHttZ6Y09n7e0x/eKQUOZ
 W2KnBdaoMgvTS+p2yvbs2pZlg+a3Sfp9AAAAA==
X-Change-ID: 20260814-740-optimize-reloading-the-reftable-stack-f5f3adf0a0c0
In-Reply-To: <20260819-740-optimize-reloading-the-reftable-stack-v1-0-6bf5305d4e43@gmail.com>
References: <20260819-740-optimize-reloading-the-reftable-stack-v1-0-6bf5305d4e43@gmail.com>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>, ps@pks.im, gitster@pobox.com, 
 jltobler@gmail.com, Jeff King <peff@peff.net>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=9751; i=karthik.188@gmail.com;
 h=from:subject:message-id; bh=loOGEMPUIc2hkO/I3PFNs/VdFiT+fQt3DKNNMwwP0AI=;
 b=owJ4nAHtARL+kA0DAAoBPtWfJI5GjH8ByyZiAGqMD196D7fEVMOUiRRDzpoB6punmcpn8C7AI
 nEvZUAkg2PEHIkBswQAAQoAHRYhBFfOTH9jdXEPy2XGBj7VnySORox/BQJqjA9fAAoJED7VnySO
 Rox/5pQL/iVE7H5AnByH3aL3dAcv3aqUAJWl6Mp3qPTR0zOI/2NB4Yy+DFVlHMiHJW+qQgA0//S
 u6/OV8lbCaZ3IJMWG6P4X8AVHkdTN60J3bMlbehr3UQEdhqwnMj9itb8Xie5mNyBEXWV8+7Gkwo
 HAm9Jj2KwDQ6+V2QA15MwjxrrJoBoL3opyUytP1HP/0T1Hjnuc23j1mK2DikWlMvB7wEnJ4mRSa
 rvJlxaSuO7ULNDtJGR1miHFWGoL6t0Yl01/8/ITCzdhE5PKaQodk3QfG/f9XETO/i7M8S6OqaYW
 iA7NCXpz9ZAtU3/ZGCrzyWWiNJ+V3ffZ0AyTnbxBvy15SvO8XM/5ALh7VrfbcUSv8AsZt3lGSZq
 IGdqMLQ3y2UXKtdkJ1lbp9DdQV7BMKoE6hWkbHYVbQ+ltRWCTOO8i/dNW3cP8EDSia9pi7uDCil
 0KttQEvkTWzuwO4Tdc2Lg9snZ7zLQkGwlGFM8YvMo8M9YDW+JtAdKJsng7LgpL7VTS4gveCKmb7
 fw=
X-Developer-Key: i=karthik.188@gmail.com; a=openpgp;
 fpr=57CE4C7F6375710FCB65C6063ED59F248E468C7F

This patch series is based on the report by Jeff [1], where he noticed
that when creating a lot of refs within a single reference transaction,
the majority of the time was spent on fstat().

The issue stems from the fact that within the reftable library we do not
track Git reference transactions, as such any calls within the library
would potentially reload the stack to ensure that there are no
concurrent updates made to the stack. While this makes sense outside of
a reference transaction, within one, the stack is locked, so reloading
the stack is a no-op. The only time we want to reload the stack is
immediately after locking the list file, which is to catch any
concurrent updates made to the stack.

The first patch in this small series, cleans up the flow of reloading
the stack by providing a flag explicitly. The patch argues that since
all flows reload the stack, the flag can be safely removed. This
simplifies the flow of when to reload the stack.

The next two commits move the lock variable to the reftable_stack
structure and then use this information to decide if reloading of the
stack is necessary.

During benchmarking, I first tried to benchmark adding new references
against HEAD. This kicks in the DWIM ref resolution, and we iterate over
siz difference candidate ref names before settling on a match. Each such
lookup reloads the stack. This happens before the reference transaction
is created. I quickly realized that this would dominate the benchmarks,
so the benchmarks in the third patch are against a static commit OID.

Benchmarking with a fixed, non-symbolic target OID in the 'refs/tags/'
namespace (since it triggers a stack reload when checking if reflog
exists for the given tag name), shows a consistent 15-20% improvement
with these patches:

   refcount   master     patch     speedup
   --------   -------    -------   -------
   2,000       18.5 ms    16.6 ms   1.11x
   20,000     120.7 ms   102.8 ms   1.17x
   50,000     296.5 ms   247.1 ms   1.20x

The syscall counts show that now the calls to `newfstatat()` stay
constant at around 55 calls regardless of the number of refs to be
created. Before this would grow linearly with the number of refs.

[1]: https://lore.kernel.org/git/20260629203527.GA1895313@coredump.intra.peff.net/

Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
---
Changes in v2:
- Fix typos in commit messages and add additional information.
- To prevent multiple `reftable_addition`'s from releasing each others
  list lock, add a bit field to track ownership. Add related unit test.
- Add correct benchmark results in the last commit, my earlier results
  were based on using 'refs/heads' which doesn't check for reflogs when
  using the default config. Use 'refs/tags' as suggested by Peff. This
  shows a good 15-20% improvement.
- Link to v1: https://patch.msgid.link/20260819-740-optimize-reloading-the-reftable-stack-v1-0-6bf5305d4e43@gmail.com

---
Karthik Nayak (4):
      reftable/stack: remove `REFTABLE_STACK_NEW_ADDITION_RELOAD`
      reftable/stack: rename reftable_stack_new_addition()
      reftable/stack: move list lock to `struct reftable_stack`
      reftable/stack: avoid reloading the stack when already locked

 refs/reftable-backend.c         | 22 ++++-----
 reftable/reftable-stack.h       | 19 ++------
 reftable/stack.c                | 82 +++++++++++++++++-----------------
 reftable/stack.h                |  7 ++-
 t/unit-tests/u-reftable-stack.c | 99 +++++++++++++++++++++++++----------------
 5 files changed, 119 insertions(+), 110 deletions(-)

Range-diff versus v1:

1:  63f46a1517 ! 1:  8ec5578141 reftable/stack: remove `REFTABLE_STACK_NEW_ADDITION_RELOAD`
    @@ Commit message
           1. Unit tests, where we explicitly do not propagate the flag. These
              tests are now modified with the new status quo.
     
    -      2. `reftable_stack_clean_locked()`, which was propagating 0 to
    +      2. `reftable_stack_clean()`, which was propagating 0 to
              `reftable_stack_new_addition()` but was then manually reloading the
              stack after. Here the new flow will achieve the same, while also
              allowing us to remove the manual reload.
-:  ---------- > 2:  45d965abd3 reftable/stack: rename reftable_stack_new_addition()
2:  2796229716 ! 3:  434bba1bee reftable/stack: move list lock to `struct reftable_stack`
    @@ Commit message
         on top of `struct reftable_stack`, and we would miss the optimization in
         such paths.
     
    +    Since the lock is now shared across all additions on the same stack, a
    +    second `reftable_addition` that fails to acquire the already held lock
    +    would still call `reftable_addition_close()`, which will release the
    +    `stack->list_lock` which is still held by the first addition. To avoid
    +    this, add a new bit field `locked` to `reftable_addition` that tracks
    +    whether a particular addition is the one holding the lock, and only
    +    release it in that case. Add a unit test to validate this behavior.
    +
         While here, remove an unused header file from 'reftable/stack.h'.
     
         Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
    @@ reftable/stack.c: int reftable_stack_reload(struct reftable_stack *st)
      	struct reftable_stack *stack;
      	struct reftable_write_options opts;
      
    ++	/*
    ++	 * While the list lock is acquired on the stack, we need to distinguish
    ++	 * which 'reftable_addition' is responsible for the lock. This avoids
    ++	 * clearing the lock of another 'reftable_addition'.
    ++	 */
    ++	unsigned int locked : 1;
    ++
    + 	char **new_tables;
    + 	size_t new_tables_len, new_tables_cap;
    + 	uint64_t next_update_index;
     @@ reftable/stack.c: static void reftable_addition_close(struct reftable_addition *add)
      	add->new_tables_len = 0;
      	add->new_tables_cap = 0;
      
     -	flock_release(&add->tables_list_lock);
    -+	flock_release(&add->stack->list_lock);
    ++	if (add->locked)
    ++		flock_release(&add->stack->list_lock);
    ++	add->locked = 0;
      	reftable_buf_release(&nm);
      }
      
    @@ reftable/stack.c: static int reftable_stack_init_addition(struct reftable_additi
      			    add->opts.lock_timeout_ms);
      	if (err < 0)
      		goto done;
    ++	add->locked = 1;
      
      	if (add->opts.default_permissions) {
     -		if (chmod(add->tables_list_lock.path,
    @@ reftable/stack.c: int reftable_addition_commit(struct reftable_addition *add)
      	if (err < 0) {
      		err = REFTABLE_IO_ERROR;
      		goto done;
    + 	}
    ++	add->locked = 0;
    + 
    + 	/* success, no more state to clean up. */
    + 	for (i = 0; i < add->new_tables_len; i++)
     
      ## reftable/stack.h ##
     @@
    @@ reftable/stack.h: struct reftable_stack {
      	char *reftable_dir;
      
      	struct reftable_stack_options opts;
    +
    + ## t/unit-tests/u-reftable-stack.c ##
    +@@ t/unit-tests/u-reftable-stack.c: void test_reftable_stack__invalid_limit_updates(void)
    + 	reftable_stack_destroy(st);
    + 	clear_dir(dir);
    + }
    ++
    ++void test_reftable_stack__two_additions(void)
    ++{
    ++	struct reftable_stack *st = NULL;
    ++	char *dir = get_tmp_dir(__LINE__);
    ++	struct reftable_addition *add1 = NULL;
    ++	struct reftable_addition *add2 = NULL;
    ++
    ++	struct reftable_ref_record ref = {
    ++		.refname = (char *) "HEAD",
    ++		.update_index = 1,
    ++		.value_type = REFTABLE_REF_SYMREF,
    ++		.value.symref = (char *) "master",
    ++	};
    ++
    ++	cl_assert_equal_i(reftable_new_stack(&st, dir, NULL), 0);
    ++
    ++	cl_assert_equal_i(reftable_stack_addition_new(&add1, st, NULL), 0);
    ++	cl_assert_equal_i(reftable_stack_addition_new(&add2, st, NULL), REFTABLE_LOCK_ERROR);
    ++
    ++	cl_assert_equal_i(reftable_addition_add(add1, write_test_ref, &ref), 0);
    ++
    ++	cl_assert_equal_i(reftable_addition_commit(add1), 0);
    ++
    ++	reftable_addition_destroy(add1);
    ++	reftable_stack_destroy(st);
    ++	clear_dir(dir);
    ++}
3:  7d7e4a7a33 ! 4:  bd038809b9 reftable/stack: avoid reloading the stack when already locked
    @@ Commit message
         no-op. Now that the struct has access to the lock file status, simply
         skip reloading if the lock is present.
     
    -    Benchmarking with a fixed, non-symbolic target OID shows a modest but
    -    consistent ~1-2% improvement in clock time for `update-ref` across ref
    -    counts ranging from 2,000 to 100,000.
    +    Benchmarking with a fixed, non-symbolic target OID in the 'refs/tags/'
    +    namespace (since it triggers a stack reload when checking if reflog
    +    exists for the given tag name), shows a consistent 15-20% improvement
    +    with these patches:
     
    -    We can see better improvements in the number of syscall counts. On
    +      refcount   master     patch     speedup
    +      --------   -------    -------   -------
    +      2,000       18.5 ms    16.6 ms   1.11x
    +      20,000     120.7 ms   102.8 ms   1.17x
    +      50,000     296.5 ms   247.1 ms   1.20x
    +
    +    We can also see the improvements in the number of syscall counts. On
         master, the number of calls to `newfstatat()` grows linearly with the
         number of refs created. With this patch, the number is now a constant:
     

---
base-commit: 18e66859d87fb4b76599f73460b54f0848c76b16
change-id: 20260814-740-optimize-reloading-the-reftable-stack-f5f3adf0a0c0


Thanks
- Karthik

