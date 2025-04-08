Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EC1522A7F0
	for <git@vger.kernel.org>; Tue,  8 Apr 2025 15:48:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744127329; cv=none; b=uKCg2dmh9hhCd7gc4hlw49ErNlY8qw1wnvAIEapMWj7YW2Dx9bdZve9UZkrkTpKwewJA0QJio2RrIUwwuepYs/m2B1gaOyKDrnmX5uDb4l8RTyJaOW24809EbP4MwNMjR4UVNUgFWe8g9pBmFVpwKIA7UsQPIlG4HCg8AkyTMsk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744127329; c=relaxed/simple;
	bh=1iy9xMCyQprJCKpNXSPet4bo5ATa29NBrhZXOxLW0PI=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=AKzihpPMgSpbCmk+B2IWMz5wCvHaMte/NMhuQ5n5uWqHgqPm2VnMepcrs6t3FAwzAKqzgr13EFeDUV+T6fm+VGKL3i/vPLbqYidgQ0Eh5gsSebzevLxFGHKRFIu9ZrcsQcViGdcloBn+WVbgufGYPMsyXafi5qN8pMWnqg5x9j8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=a5tzKF0W; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a5tzKF0W"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4394a823036so53324095e9.0
        for <git@vger.kernel.org>; Tue, 08 Apr 2025 08:48:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744127325; x=1744732125; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KcsPVJWwo3hNZwNrHWIIlSNKZed0r4WnDotK/UbDhrk=;
        b=a5tzKF0W4lxOmiolvB2zT4LwO9KM911KhnOJqACrZYFD9S6dcL+UgDtp2qa5eSUAx2
         9PdBwGHi66q9bvPDA3+cbu5eLvdaAsykXVa2ePz7ICmGIOEARAFfTCfQQieBYcqBG6Aa
         AT87WzZ/b8mMeyssj3zIaGot/DHzxixUJ4FZH70GmxjM2FO6A0+FKJpXC/2fTf+zTPWj
         ivouMSJOzHY0tTFyclE7fev4lcCFD4UCpVK78mvDWk/iMu9DhPo0Sf/PQPf6FyvCdqV+
         sOy6U7KE2eoSkac9BVMyIPDXT297UkiGZxksba0vFlD6Zs6sR6dYkpi2X07ow360rDZV
         7QWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744127325; x=1744732125;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KcsPVJWwo3hNZwNrHWIIlSNKZed0r4WnDotK/UbDhrk=;
        b=Wg3FU6HBHRCXzpdjY9maFcQfdNxHtX/w0Y3XqYArT6kNNk92DjxyGRFy+85Wa1KS5y
         KTX0gescT6XTKA9RaysmljPwN84vAgoCVA90uuCM4xIJKStuAC2UQ2eBqqTFl7ZRZYyR
         BvON4KaSOS6pgcntD0jmzDV/5Rc7+D7v+vzv/XC25KPymjQszPQouSPT7MErQPCTDFU4
         GwmxA7eSxWoTOImk0GfwUmYL9kq7tfssYZYA0bG+Rxknbf2nywKq+TeZtqB8vQ1TYTOn
         4ZUn3i1wYsx9D0f1prbuRSoXK9v87DMoc9OP6FEHe8WJ7PMnk18RK1U5AOOAXCVAX7aa
         Di3Q==
X-Gm-Message-State: AOJu0YwdlGTpIX7l0y32f4Hek4VURR6mpSjajK568I/03SnGP27ZiDlY
	emKO+ylPSAOv7WV3XqShcT7F4bS53LACzZ4zTSWJR6Vfvwg3c/lb92yTMw==
X-Gm-Gg: ASbGnctaXAgLdWp3/bHKCYL9NzCVqca587JtscgQVQsQBpMgkjkDlyXinD7N4oirzT0
	8USk9tsRmhoH/vCml35YRyXDdb5WAxLZam+KeDV0i+mSep8gjX4yP/C8BUS5lnBRklK8qaE92Kh
	Qnd3uurS5+MrpFh7Pb3ONomeeA7UTIipZ2AcrfnHP66W0tx80ngS8sFNdVRtjNqkZkiNHuQ0rtD
	4mn3srr1OJMFvXj0KAyZe2r98c39bARnm2IpjI++VAWmYMEIzpSzrWnuIQz9UoE0NwQNtE/GvNf
	Ae0dyUz4GfJiwTiKsQPVrFtOfFlnq17ujDHzKIDMXJuK3Q==
X-Google-Smtp-Source: AGHT+IFjhI2BNBtRufrmX2SXAFll8J7kJshHMDS3JF4uyEnes2NoiUCg4BIHAkjD4OaWKAIEj8q+Kg==
X-Received: by 2002:a5d:64ee:0:b0:391:487f:2828 with SMTP id ffacd0b85a97d-39d6fc0c2e6mr11414628f8f.10.1744127324686;
        Tue, 08 Apr 2025 08:48:44 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-39c30226959sm15005293f8f.82.2025.04.08.08.48.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Apr 2025 08:48:44 -0700 (PDT)
Message-Id: <pull.1898.v3.git.1744127322.gitgitgadget@gmail.com>
In-Reply-To: <pull.1898.v2.git.1743891374.gitgitgadget@gmail.com>
References: <pull.1898.v2.git.1743891374.gitgitgadget@gmail.com>
From: "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 08 Apr 2025 15:48:34 +0000
Subject: [PATCH v3 0/8] Debug merge-recursive.[ch]
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
Cc: Eric Sunshine <sunshine@sunshineco.com>,
    Elijah Newren <newren@gmail.com>,
    Elijah Newren <newren@gmail.com>

Changes since v1:

 * fixed a couple of typos in commit messages

Changes since v2.

 * clarified the commit message for patch 6, and the cover letter

Clarified cover letter:

As a wise man once told me, "Deleted code is debugged code!"

This series does some preparation, then moves the code shared between
merge-recursive and merge-ort from the former to the latter, and then
"debugs" the remainder of merge-recursive.[ch].

Joking aside, merge-ort was always intended to replace merge-recursive. It
did replace it as the default years ago in commit 6a5fb966720f (Change
default merge backend from recursive to ort, 2021-08-04), and was noted to
be better on correctness, extensibility, and performance issues. In this
series, we convert the remaining callers of merge-recursive over to
merge-ort equivalents, move the shared code between merge-recursive and
merge-ort from the former to the latter, and then delete the remainder of
merge-recursive.[ch] as it has now been fully replaced. We then clean up
some test framework scaffolding that was put into place to allow us to reuse
the recursive tests as ort tests.

Series overview:

 * Patches 1-5: Preparation; switch remaining callers of
   merge-recursive.[ch] functions to merge-ort equivalents, and add sole
   remaining missing feature (diff-algorithm selection)
 * Patch 6: Nuke merge-recursive.[ch]
 * Patch 7-8: Cleanup testsuite; we don't need GIT_TEST_MERGE_ALGORITHM
   anymore

While the diffstat might look large, the non-test code changes are actually
pretty small. The drivers of the big diffstat are:

 * We move a significant chunk of shared code from merge-recursive.[ch] to
   merge-ort.[ch], without modifying it
 * We delete (the remainder of) merge-recursive.[ch]
 * We rip out all the temporary GIT_TEST_MERGE_ALGORITHM stuff designed to
   let us reuse tests between recursive and ort

Elijah Newren (8):
  checkout: replace merge_trees() with merge_ort_nonrecursive()
  builtin/merge-recursive: switch to using merge_ort_generic()
  merge-ort: enable diff-algorithms other than histogram
  sequencer: switch non-recursive merges over to ort
  merge, sequencer: switch recursive merges over to ort
  merge-recursive.[ch]: thoroughly debug these
  tests: remove GIT_TEST_MERGE_ALGORITHM and test_expect_merge_algorithm
  builtin/{merge,rebase,revert}: remove GIT_TEST_MERGE_ALGORITHM

 Documentation/merge-strategies.adoc           |   51 +-
 Documentation/technical/sparse-checkout.adoc  |    2 -
 Makefile                                      |    1 -
 builtin/checkout.c                            |   10 +-
 builtin/merge-recursive.c                     |    4 +-
 builtin/merge.c                               |   23 +-
 builtin/rebase.c                              |    5 -
 builtin/revert.c                              |    2 -
 ci/run-build-and-tests.sh                     |    1 -
 merge-ort-wrappers.h                          |    2 +-
 merge-ort.c                                   |  162 +-
 merge-ort.h                                   |   60 +-
 merge-recursive.c                             | 4079 -----------------
 merge-recursive.h                             |  132 -
 meson.build                                   |    1 -
 sequencer.c                                   |   58 +-
 t/lib-merge.sh                                |   13 -
 t/t1092-sparse-checkout-compatibility.sh      |    2 -
 t/t2501-cwd-empty.sh                          |    2 -
 t/t3512-cherry-pick-submodule.sh              |    5 -
 t/t3513-revert-submodule.sh                   |    4 -
 t/t4069-remerge-diff.sh                       |    7 -
 t/t4301-merge-tree-write-tree.sh              |    7 -
 t/t5572-pull-submodule.sh                     |    5 -
 t/t6400-merge-df.sh                           |   14 +-
 t/t6402-merge-rename.sh                       |  125 +-
 t/t6404-recursive-merge.sh                    |   21 +-
 t/t6406-merge-attr.sh                         |    7 +-
 t/t6416-recursive-corner-cases.sh             |  194 +-
 t/t6421-merge-partial-clone.sh                |    7 +-
 t/t6422-merge-rename-corner-cases.sh          |   31 +-
 t/t6423-merge-rename-directories.sh           |  517 +--
 t/t6424-merge-unrelated-index-changes.sh      |    8 +-
 t/t6426-merge-skip-unneeded-updates.sh        |    4 +-
 t/t6428-merge-conflicts-sparse.sh             |    2 -
 t/t6430-merge-recursive.sh                    |   46 +-
 t/t6434-merge-recursive-rename-options.sh     |   16 +-
 t/t6436-merge-overwrite.sh                    |   17 +-
 t/t6437-submodule-merge.sh                    |   65 +-
 t/t6438-submodule-directory-file-conflicts.sh |    5 -
 t/t6439-merge-co-error-msgs.sh                |    2 +-
 t/t7402-submodule-rebase.sh                   |    7 +-
 t/t7602-merge-octopus-many.sh                 |    9 +-
 t/t7610-mergetool.sh                          |   40 +-
 t/t7615-diff-algo-with-mergy-operations.sh    |    2 -
 t/test-lib.sh                                 |    2 -
 46 files changed, 538 insertions(+), 5241 deletions(-)
 delete mode 100644 merge-recursive.c
 delete mode 100644 merge-recursive.h
 delete mode 100644 t/lib-merge.sh


base-commit: 5b97a56fa0e7d580dc8865b73107407c9b3f0eff
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1898%2Fnewren%2Fendit-quote-debugging-unquote-v3
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1898/newren/endit-quote-debugging-unquote-v3
Pull-Request: https://github.com/gitgitgadget/git/pull/1898

Range-diff vs v2:

 1:  0e150ee9065 = 1:  0e150ee9065 checkout: replace merge_trees() with merge_ort_nonrecursive()
 2:  b093d74968b = 2:  b093d74968b builtin/merge-recursive: switch to using merge_ort_generic()
 3:  cf774437123 = 3:  cf774437123 merge-ort: enable diff-algorithms other than histogram
 4:  6203589ac17 = 4:  6203589ac17 sequencer: switch non-recursive merges over to ort
 5:  8821f22d5ea = 5:  8821f22d5ea merge, sequencer: switch recursive merges over to ort
 6:  770f611c2b6 ! 6:  e696cb472bd merge-recursive.[ch]: thoroughly debug these
     @@ Commit message
          the former to the latter, and then debug the remainder of
          merge-recursive.[ch].
      
     +    Joking aside, merge-ort was always intended to replace merge-recursive.
     +    It has numerous advantages over merge-recursive (operates much faster,
     +    can operate without a worktree or index, and fixes a number of known
     +    bugs and suboptimal merges).  Since we have now replaced all callers of
     +    merge-recursive with equivalent functions from merge-ort, move the
     +    shared functions from the former to the latter, and delete the remainder
     +    of merge-recursive.[ch].
     +
          Signed-off-by: Elijah Newren <newren@gmail.com>
      
       ## Documentation/merge-strategies.adoc ##
 7:  a6501ee85fa = 7:  5dce9096e23 tests: remove GIT_TEST_MERGE_ALGORITHM and test_expect_merge_algorithm
 8:  d1dea986646 = 8:  bf2d462c4e5 builtin/{merge,rebase,revert}: remove GIT_TEST_MERGE_ALGORITHM

-- 
gitgitgadget
