Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79B2D41F7F9
	for <git@vger.kernel.org>; Fri, 10 Jul 2026 11:39:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783683598; cv=none; b=mzo/ePCr+2HwK8SaDC9XbpzOpoAyWM+oa5MdDcJ60of0pTkhl8xRTKGmTWMWNGnrSxr1IV+FCHJAdkg4O0SKFwwHaaL/88X6fBxPqEXEax5pyOowkz671FbaZdmE3epyesBZCnrtv+Y+T3kWdTdyBKN3OJ63ww+AQ7uj8kCDotM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783683598; c=relaxed/simple;
	bh=VL8+DLbjg0Lecf29aX7AlkZvQ7mA6aWsJn7uKj5W0zU=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=i0h07jIT0hYOoE4GjLXcZBufslsWcu7yKZh2WHgrDUwDl73311T7TwU114npA7ajY6FLx7ELpZ4V8qHUjj7vk+DlGtx8Wloh+vBEEvECCmM7oI0xdbCE53LFPj6PrLXtDpp96/nT6L03xZuXqWChOribIzuWOEETjgNsXS/XqR0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bxuaLU/e; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bxuaLU/e"
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-8485fad302bso758074b3a.3
        for <git@vger.kernel.org>; Fri, 10 Jul 2026 04:39:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783683580; x=1784288380; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=Im+mbCdvxNdfK80HE6UJ+xm6YgGX2nWjMMk+SWMCX70=;
        b=bxuaLU/e0/3xbt36KJhbkqHcybibJ6RcUCbcy7WgNsIVlcenxszLAQUoD7b2oXyVM3
         pHuLOFdTqqu6I3iDGHghQ2kQGLEpJfjpg8W+FOB2r/KRVjat23ay+CMy4U1lSN4bc3xQ
         /EYlS0BYiuP5nPWdmv3p601oDk4JCrT7j61ntDGK3BfjSZxgwKMINLj85pUkTaK+EquI
         yQim2mEfBQE5aQmxgmGwCsNFJjwY3OViz+oYdfKzQUlhHh5uB/v5oX6meKtG/nHmcoLr
         eWTfyTrCHi07dl2lbn1EXXknWORott5QVUepusprwQXpEIiAtyYHCxYy20SO1ciB6fqw
         TpRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783683580; x=1784288380;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Im+mbCdvxNdfK80HE6UJ+xm6YgGX2nWjMMk+SWMCX70=;
        b=qNPRJ2Ptx9+h35LvTfeVvScll9oRpVFIqaCIVmlfUtjG9ASZr4FqmBD/FbpPyZZH1d
         xvh8FWIyzZuw/4hFFWN3Qc2LZYsryYX/G3eXFqFv3nP2NBjoYMUX0V6AJNy5jw48aoU8
         KglcwYXem9Klzf4DFYwjxEBlwomYnx+f53XODoIbHDUAHaImoRkpLDXfLV+3ROx/da00
         l3STb7oVdY2QoTw7wxgQk/EvVm755+ZCVGwmEUiP0vKYo1ZXtdcwnuiDVmzMV6tSEf/J
         +Qw3W7TTJ//orU5em59WnX9G6cwZZwDy5GjhguRmQEEEatTndBOWCwH8FSWiWTi2f4LR
         qnnw==
X-Gm-Message-State: AOJu0YyCzOatnsQywTwyiYF2VzAP11DQYhdL5Jy0MMSshJgmoLXpXXdT
	g+uILREtwuWX+r3cXOEMBL8h2vnru3ZDVaHF3KJHX80FHZcO2qn7Rc+0Wk3qoQ==
X-Gm-Gg: AfdE7ckoxf27WCQhR0I/KEQY3eqHgRhCjjiKpsJVVzWz+Qc+iVGAI3qN1MdXrsIIik8
	SAmhgTBMybaroUguWY4xK4OyhWT1cZaKBOxqJhls9ic4bpVYVw5OTD/JQ6CS76aA2K5zGd7n035
	i/937lBIKYck+yLel+ON0qkIxul0fU489O9Zs2NfnCmJkOlnzXba1iZedUxFL6H/V7N/4v0tAuO
	2a62FWEmKxTsbO3g0iPbNRffheHlUWEeNLZHxTu2wbBcG6dTpKZTC0klBdvT12WQboQEmVTyDQ0
	fa2XNfyvAzMnz9BCZrX+l1QvGRIJRXYz1AL2Rg3CQ5SHbkCkaRfHOVyWNKjaOEHgqAO+Y7ZJabs
	XKlZ3QA43MNDTS37lBGGGoIviL8gpYzzuRmMrbaZkxxl80SgsrkBVBgacS0J5KAcy2V+ziMyQDn
	MJSEt/n2xz+ExsiVoo
X-Received: by 2002:a05:6a00:17a6:b0:848:6895:b754 with SMTP id d2e1a72fcca58-8486895bbd3mr4764077b3a.28.1783683579413;
        Fri, 10 Jul 2026 04:39:39 -0700 (PDT)
Received: from [127.0.0.1] ([172.185.47.202])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8484519580csm3965875b3a.32.2026.07.10.04.39.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jul 2026 04:39:38 -0700 (PDT)
Message-Id: <pull.2174.v2.git.1783683577.gitgitgadget@gmail.com>
In-Reply-To: <pull.2174.git.1783590159.gitgitgadget@gmail.com>
References: <pull.2174.git.1783590159.gitgitgadget@gmail.com>
From: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 10 Jul 2026 11:39:24 +0000
Subject: [PATCH v2 00/12] coverity: avoid dereferencing NULL
Fcc: Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
To: git@vger.kernel.org
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>

This is a continuation of the effort I started in the patch series that
became js/coverity-fixes. This next batch adds guards to avoid dereferencing
NULL pointers and accessing NULL file descriptors.

Changes since v1:

 * Calling remote_tracking() no longer returns -1 when remote is NULL, but
   instead BUG()s out.
 * bisect_successful() returns with BISECT_FAILED instead of the -1 that
   only worked by happenstance.
 * The commit "revision: avoid dereferencing NULL in add_parents_only()" now
   comes with a regression test.
 * The commit "bisect: ensure non-NULL head before using it" no longer
   claims that the fixed bug can be triggered with the current code base.
 * The missing shallow commit's OID is no longer computed twice.
 * A follow-up commit was folded into this patch series that lets
   write_one_shallow() avoid the rolling buffers of oid_to_hex(), as
   suggested by Junio. It technically does not fit the goal of this patch
   series (fixing issues pointed out by Coverity), but was asked for
   explicitly.

Johannes Schindelin (12):
  diffcore-break: guard against NULLed queue entries in merge loop
  diff: handle NULL return from repo_get_commit_tree()
  remote: guard `remote_tracking()` against NULL remote
  reftable/stack: guard against NULL list_file in stack_destroy
  mailsplit: move NULL check before first use of file handle
  bisect: handle NULL commit in `bisect_successful()`
  replay: die when --onto does not peel to a commit
  revision: avoid dereferencing NULL in `add_parents_only()`
  pack-bitmap: handle missing bitmap for base MIDX
  bisect: ensure non-NULL `head` before using it
  shallow: fix NULL dereference
  shallow: give write_one_shallow() its own hex buffer

 builtin/bisect.c         |  9 ++++++++-
 builtin/diff.c           | 10 +++++++---
 builtin/mailsplit.c      |  6 +++---
 diffcore-break.c         |  2 ++
 pack-bitmap.c            |  4 ++++
 reftable/stack.c         |  3 ++-
 remote.c                 |  2 ++
 replay.c                 |  8 ++++++--
 revision.c               |  9 +++++++--
 shallow.c                |  7 ++++---
 t/t0410-partial-clone.sh | 18 ++++++++++++++++++
 11 files changed, 63 insertions(+), 15 deletions(-)


base-commit: e9019fcafe0040228b8631c30f97ae1adb61bcdc
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-2174%2Fdscho%2Fcoverity-fixes-null-safety-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-2174/dscho/coverity-fixes-null-safety-v2
Pull-Request: https://github.com/gitgitgadget/git/pull/2174

Range-diff vs v1:

  1:  df00334f8b =  1:  df00334f8b diffcore-break: guard against NULLed queue entries in merge loop
  2:  4fdba0542b =  2:  4fdba0542b diff: handle NULL return from repo_get_commit_tree()
  3:  dcaefc5987 !  3:  1398a2f120 remote: guard `remote_tracking()` against NULL remote
     @@ remote.c: static int remote_tracking(struct remote *remote, const char *refname,
       	char *dst;
       
      +	if (!remote)
     -+		return -1; /* no remote to look up tracking ref */
     ++		BUG("remote_tracking() called with NULL remote");
       	dst = apply_refspecs(&remote->fetch, refname);
       	if (!dst)
       		return -1; /* no tracking ref for refname at remote */
  4:  d7bc7fce35 =  4:  285f019fb3 reftable/stack: guard against NULL list_file in stack_destroy
  5:  41eef047ae =  5:  12c2c8450e mailsplit: move NULL check before first use of file handle
  6:  7041375108 !  6:  ca818ee405 bisect: handle NULL commit in `bisect_successful()`
     @@ builtin/bisect.c: static int bisect_successful(struct bisect_terms *terms)
       	refs_read_ref(get_main_ref_store(the_repository), bad_ref, &oid);
       	commit = lookup_commit_reference_by_name(bad_ref);
      +	if (!commit) {
     -+		res = error(_("could not find commit for '%s'"), bad_ref);
     ++		error(_("could not find commit for '%s'"), bad_ref);
      +		free(bad_ref);
     -+		return res;
     ++		return BISECT_FAILED;
      +	}
       	repo_format_commit_message(the_repository, commit, "%s", &commit_name,
       				   &pp);
  7:  a7245cdffa =  7:  8216769be9 replay: die when --onto does not peel to a commit
  8:  0675767797 !  8:  41285dd8e1 revision: avoid dereferencing NULL in `add_parents_only()`
     @@ revision.c: static int add_parents_only(struct rev_info *revs, const char *arg_,
       		if (it->type != OBJ_TAG)
       			break;
       		if (!((struct tag*)it)->tagged)
     +
     + ## t/t0410-partial-clone.sh ##
     +@@ t/t0410-partial-clone.sh: test_expect_success 'rev-list dies for missing objects on cmd line' '
     + 	done
     + '
     + 
     ++test_expect_success '--exclude-promisor-objects with ^@ on missing object' '
     ++	rm -rf repo &&
     ++	test_create_repo repo &&
     ++	test_commit -C repo foo &&
     ++	test_commit -C repo bar &&
     ++
     ++	COMMIT=$(git -C repo rev-parse foo) &&
     ++	promise_and_delete "$COMMIT" &&
     ++
     ++	git -C repo config core.repositoryformatversion 1 &&
     ++	git -C repo config extensions.partialclone "arbitrary string" &&
     ++
     ++	# Ensure that "$COMMIT^@" is handled gracefully even though the
     ++	# actual commits are missing.
     ++	git -C repo rev-list --exclude-promisor-objects "$COMMIT^@" >out &&
     ++	test_must_be_empty out
     ++'
     ++
     + test_expect_success 'single promisor remote can be re-initialized gracefully' '
     + 	# ensure one promisor is in the promisors list
     + 	rm -rf repo &&
  9:  0b27860478 =  9:  cccd36137f pack-bitmap: handle missing bitmap for base MIDX
 10:  428a3a006b ! 10:  376a6581cb bisect: ensure non-NULL `head` before using it
     @@ Commit message
          Later, that variable is passed to `repo_get_oid()` and `starts_with()`,
          both of which would dereference the NULL pointer.
      
     -    The scenario "`refs_resolve_ref_unsafe()` returns NULL but
     -    `repo_get_oid()` succeeds" can happen when HEAD is a detached bare OID
     -    that the ref backend cannot resolve symbolically (a potential edge case
     -    with the reftable backend) but the OID itself is valid. In this case,
     -    the bisect-start file does not yet exist (this is a fresh "git bisect
     -    start"), so the else branch is taken with the NULL `head`.
     -
     -    Simply assign "HEAD" to `head` as a fallback to address this.
     -
     -    Pointed out by Coverity.
     -
     -    Assisted-by: Claude Opus 4.6
     +    A concrete trigger for `refs_resolve_ref_unsafe()` returning NULL while
     +    `repo_get_oid()` succeeds could not be constructed against the ref
     +    backends currently in the tree; the naive case (a symbolic HEAD pointing
     +    at a nonexistent branch, in either the files or the reftable backend)
     +    fails in both calls consistently and returns via the existing
     +    `error(_("bad HEAD - I need a HEAD"))` path.  Coverity, however, flags
     +    the leftover use of `head` after the outer `if (!head)` on a formal
     +    reading: `head` is still NULL at that point, and both `starts_with(head,
     +    ...)` and the second `repo_get_oid(..., head, ...)` in the else-branch
     +    would dereference it if that state were ever reached.
     +
     +    Removing the outer check would risk regressing to a crash if a future
     +    ref backend ever manages to hit the "returns NULL for HEAD but has a
     +    valid OID for HEAD" state.  Assigning the literal string "HEAD" as a
     +    safe fallback documents the intent and satisfies the analyzer without
     +    changing behavior in any code path we can currently reach.
     +
     +    Assisted-by: Claude Opus 4.7
          Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
      
       ## builtin/bisect.c ##
 11:  9f3a239484 ! 11:  e581bc91ee shallow: fix NULL dereference
     @@ Commit message
      
       ## shallow.c ##
      @@ shallow.c: static int write_one_shallow(const struct commit_graft *graft, void *cb_data)
     + 		struct commit *c = lookup_commit(the_repository, &graft->oid);
       		if (!c || !(c->object.flags & SEEN)) {
       			if (data->flags & VERBOSE)
     - 				printf("Removing %s from .git/shallow\n",
     +-				printf("Removing %s from .git/shallow\n",
      -				       oid_to_hex(&c->object.oid));
     -+				       oid_to_hex(&graft->oid));
     ++				printf("Removing %s from .git/shallow\n", hex);
       			return 0;
       		}
       	}
  -:  ---------- > 12:  2ef74b52fa shallow: give write_one_shallow() its own hex buffer

-- 
gitgitgadget
