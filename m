Received: from fout-b2-smtp.messagingengine.com (fout-b2-smtp.messagingengine.com [202.12.124.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B468221ABAC
	for <git@vger.kernel.org>; Fri,  7 Mar 2025 14:19:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741357145; cv=none; b=I09RZtOB6Z1hUVZ5J3ryOokGQguErKqQ8YLYXG/9NyWM6Cz8B9YT4wYUMqam4KXdtpOoo+8MSjQlGr/AS0kUi4vXQ9yVN1HSmvthFxfAt1EmDurFLQj6yBhnrINEVe42VVA7H37usnPB0H/8J+SLL41+t6aOnpM81lMnPgTVwlw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741357145; c=relaxed/simple;
	bh=ixJsusgz98W9FQq0EvzgXaLfY3j92IcuWjXzNfu6Lyk=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 In-Reply-To:References:To:Cc; b=XjGjvWGgq2B1H7HaI29tSEOmcqTXpyCXhN1Fnnn7MMZ3t91fVV4EY9geACgcPloNm6t1L3xX4r6rgvSggHFM5LrpsFZzq8bq+7bVB/0vbXpI2QUDC9OxFmVC8ytzqXAo7p4cL724uMDRrlpkiZw4e78QAOhBDL4XR1b7db+R7hg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=bf8eEgQT; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=j1jXiVSm; arc=none smtp.client-ip=202.12.124.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="bf8eEgQT";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="j1jXiVSm"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfout.stl.internal (Postfix) with ESMTP id B43D81140125;
	Fri,  7 Mar 2025 09:19:01 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Fri, 07 Mar 2025 09:19:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1741357141;
	 x=1741443541; bh=U9bisS8sDZRMVsHyyRUuYyIYPLhfpqjD9foz8NVb/VE=; b=
	bf8eEgQTq4JOthkwSLxS+Kj+5JqSIFwkc3dUjRFQAE13Tjo0UUc26u2yAq/wlBny
	tvKfNwfHBYHGDuEWiZ8tzuRI+d6NlOw2fvvfUh1sBr72qsKs+4ySdA4TzAsC64KY
	FWxPIdGabDBdnS0rADKTyRixbIUFgktoKtwiq0JyyDkTdk6lLtsMxy9KLT3ctMT1
	GcLigjOm3B0hL4nvVX7dqkAObTXbc6l1Bx7IDUkgRi+wx5nYGtHNQ68bYPqpAS/W
	HwnZnyBxsa1RlBNyL5gVRxaahCvS/kR8lqLVZrkw2V3rq4H/8evC9Pro+zywptCI
	x+QtU5pefNMHm7pjHs95Mw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1741357141; x=
	1741443541; bh=U9bisS8sDZRMVsHyyRUuYyIYPLhfpqjD9foz8NVb/VE=; b=j
	1jXiVSmSaye1TySfQO0zaaKyKAWIlVviuLrwbPLtrnhHVNsSEM92xGRfUNE0v0rz
	kqb3C2N0Ko1SFGf4C5RnXBvK65Gioqj07R7HC8lhGQL140QehhLnovFtsvY3YekT
	hXd4jmEA/rMUNQr60CN3EenCzlWRMO+IYkUopLxy+TXiRdonGN8Sk1aJRR9lsTbC
	gTdY7kyfwkXWFPUpJh+v25eQwq0lF3bEUYmx+JEA/+nt1+fEzq8A0LMb/l6xZjh4
	jd4yaHpOOoanVfWxT0yfJffXS3mTscR18ij7FN4W0cJNYimQuojVWwyXelZA6lhC
	vVmn2tFoG5Lsy7mBPnzcw==
X-ME-Sender: <xms:VQDLZ2Nt2h4xR5SIZUStmW9-4Hs-Hkavo6Es1fZB4BshXCuOJSSKmw>
    <xme:VQDLZ0-hgVoIakxXufjl2Wxyom8z-JcRiE3oTd8cG3eVblKko0Fkc4S3FneZG7BV7
    29AERun4vGvnHN1Hg>
X-ME-Received: <xmr:VQDLZ9QAUy4nHOKIYoMSMoQFNUaJhqQ2zCErx9ZZciQ_IqfP2MHVSDvqFpk1LAM20rdcjwBM4fOclijs_8NvZ7qRWdNhAo_Aq9YgLUluk39b>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdduuddtkeelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephffufffkgggtgfgjfhfvvefosehtjeertder
    tdejnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhksh
    drihhmqeenucggtffrrghtthgvrhhnpeetueeuhefhhfeitdeuhedttdeikeeftdduhedt
    heefhfegffevgeegtdfhheeuvdenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuve
    hluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhs
    rdhimhdpnhgspghrtghpthhtohepfedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtoh
    epjhhlthhosghlvghrsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghr
    rdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehkrghrthhhihhkrddukeeksehgmhgrih
    hlrdgtohhm
X-ME-Proxy: <xmx:VQDLZ2s-aSzUdwdH7VgN9eqgRx64HlYDlC9jOlb2Gu0__z7asTRc2w>
    <xmx:VQDLZ-d5ywf3UxS8SCrhGJWGsLXpu2M6ijw_28q_gScABQQ81E8vpA>
    <xmx:VQDLZ60NA1VtuhDlV7-VS-Gf9YZ4JJC7xeV4nlElbmwxskpqO4aEyw>
    <xmx:VQDLZy_SrwS26eL7toxspQH0115sPNxiSVeUStjFRU_AHenRez1uGw>
    <xmx:VQDLZ-6bjC3IGYVldKG9cAl_q3AlBviGvILQEYAtcxx5wzcJr1c0mBgP>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 7 Mar 2025 09:19:00 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id b9513d38 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 7 Mar 2025 14:18:56 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Subject: [PATCH v3 00/12] Stop depending on `the_repository` in
 object-related subsystems
Date: Fri, 07 Mar 2025 15:18:53 +0100
Message-Id: <20250307-b4-pks-objects-without-the-repository-v3-0-7bccf408731e@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAE0Ay2cC/42NQQ6CMBBFr0K6dkxpoYAr72FcQBlkNFLS1qoh3
 N2CiXHJ8k3mvzcxh5bQsUMyMYuBHJkhgtwlTPf1cEGgNjITXORcpByaDMabA9NcUXsHT/K9eXj
 wPYLF0Tjyxr5BNXUpq7IrtOYsukaLHb3WzukcuSe3/K3ZkC7Xb0FyubEQUuCg87bNZCeyQuExj
 vZ0Z4s+iH+l2qoUUdnJTOVSFA2q6qec5/kDrA6j8yoBAAA=
X-Change-ID: 20250210-b4-pks-objects-without-the-repository-6ba8398f7cc0
In-Reply-To: <20250303-b4-pks-objects-without-the-repository-v1-0-c5dd43f2476e@pks.im>
References: <20250303-b4-pks-objects-without-the-repository-v1-0-c5dd43f2476e@pks.im>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>, 
 Justin Tobler <jltobler@gmail.com>
X-Mailer: b4 0.14.2

Hi,

this patch series is another step to remove our dependency on the global
`the_repository` variable. The series focusses on subsystems related to
objects.

The intent here is to work towards libification of the whole subsystem
so that we can start splitting out something like an object "backend".
It is thus part of a set of refactorings aimed at allowing pluggable
object databases eventually. I'm not discussing that bigger effort yet,
mostly because it's still taking shape. So these patch series contains
things that make sense standalone, even if pluggable ODBs never get to
be a thing.

Note that this patch series stop short of dropping `the_repository` in
"object-file.c". This is a bigger undertaking, so I'm pushing that into
the next patch series.

The series is built on top of cb0ae672aea (A bit more post -rc0,
2025-02-27) with ps/path-sans-the-repository at 028f618658e (path:
adjust last remaining users of `the_repository`, 2025-02-07) merged into
it.

Changes in v2:
  - Point out why t1050 had to be adapted.
  - Drop the rename of `get_max_object_index()` and
    `get_indexed_object()`.
  - Fix a couple of commit message typos.
  - Link to v1: https://lore.kernel.org/r/20250303-b4-pks-objects-without-the-repository-v1-0-c5dd43f2476e@pks.im

Changes in v3:
  - Fix a semantic conflict with an in-flight patch series.
  - Link to v2: https://lore.kernel.org/r/20250306-b4-pks-objects-without-the-repository-v2-0-f3465327be69@pks.im

Thanks!

Patrick

---
Patrick Steinhardt (12):
      csum-file: stop depending on `the_repository`
      object: stop depending on `the_repository`
      pack-write: stop depending on `the_repository` and `the_hash_algo`
      environment: move access to "core.bigFileThreshold" into repo settings
      pack-check: stop depending on `the_repository`
      pack-revindex: stop depending on `the_repository`
      pack-bitmap-write: stop depending on `the_repository`
      object-file-convert: stop depending on `the_repository`
      delta-islands: stop depending on `the_repository`
      object-file: split out logic regarding hash algorithms
      hash: fix "-Wsign-compare" warnings
      hash: stop depending on `the_repository` in `null_oid()`

 Makefile                                     |   1 +
 archive.c                                    |   4 +-
 blame.c                                      |   2 +-
 branch.c                                     |   2 +-
 builtin/checkout.c                           |   6 +-
 builtin/clone.c                              |   2 +-
 builtin/describe.c                           |   2 +-
 builtin/diff.c                               |   5 +-
 builtin/fast-export.c                        |  10 +-
 builtin/fast-import.c                        |   8 +-
 builtin/fsck.c                               |   6 +-
 builtin/grep.c                               |   4 +-
 builtin/index-pack.c                         |  16 +-
 builtin/log.c                                |   2 +-
 builtin/ls-files.c                           |   3 +-
 builtin/name-rev.c                           |   4 +-
 builtin/pack-objects.c                       |  17 +-
 builtin/prune.c                              |   2 +-
 builtin/rebase.c                             |   2 +-
 builtin/receive-pack.c                       |   2 +-
 builtin/submodule--helper.c                  |  36 ++--
 builtin/tag.c                                |   2 +-
 builtin/unpack-objects.c                     |   5 +-
 builtin/update-ref.c                         |   2 +-
 builtin/worktree.c                           |   2 +-
 bulk-checkin.c                               |   4 +-
 combine-diff.c                               |   2 +-
 commit-graph.c                               |   9 +-
 commit.c                                     |   2 +-
 config.c                                     |   5 -
 csum-file.c                                  |  28 +--
 csum-file.h                                  |  12 +-
 delta-islands.c                              |  14 +-
 delta-islands.h                              |   2 +-
 diff-lib.c                                   |  10 +-
 diff-no-index.c                              |  28 +--
 diff.c                                       |  14 +-
 diff.h                                       |   2 +-
 dir.c                                        |   2 +-
 environment.c                                |   1 -
 environment.h                                |   1 -
 grep.c                                       |   2 +-
 hash.c                                       | 277 +++++++++++++++++++++++++
 hash.h                                       |   4 +-
 log-tree.c                                   |   2 +-
 merge-ort.c                                  |  26 +--
 merge-recursive.c                            |  12 +-
 meson.build                                  |   1 +
 midx-write.c                                 |  12 +-
 midx.c                                       |   3 +-
 notes-merge.c                                |   2 +-
 notes.c                                      |   2 +-
 object-file-convert.c                        |  29 +--
 object-file-convert.h                        |   3 +-
 object-file.c                                | 292 +--------------------------
 object.c                                     |  21 +-
 object.h                                     |  10 +-
 pack-bitmap-write.c                          |  36 ++--
 pack-bitmap.c                                |  15 +-
 pack-bitmap.h                                |   1 +
 pack-check.c                                 |  12 +-
 pack-revindex.c                              |  35 ++--
 pack-write.c                                 |  55 +++--
 pack.h                                       |  11 +-
 parse-options-cb.c                           |   2 +-
 range-diff.c                                 |   2 +-
 reachable.c                                  |   6 +-
 read-cache.c                                 |   4 +-
 refs.c                                       |  12 +-
 refs/debug.c                                 |   2 +-
 refs/files-backend.c                         |   2 +-
 repo-settings.c                              |  20 ++
 repo-settings.h                              |   5 +
 reset.c                                      |   2 +-
 revision.c                                   |   3 +-
 sequencer.c                                  |  10 +-
 shallow.c                                    |  10 +-
 streaming.c                                  |   3 +-
 submodule-config.c                           |   2 +-
 submodule.c                                  |  28 +--
 t/helper/test-ref-store.c                    |   2 +-
 t/helper/test-submodule-nested-repo-config.c |   2 +-
 t/t1050-large.sh                             |   3 +-
 tree-diff.c                                  |   4 +-
 upload-pack.c                                |  14 +-
 wt-status.c                                  |   4 +-
 xdiff-interface.c                            |   2 +-
 87 files changed, 677 insertions(+), 613 deletions(-)

Range-diff versus v2:

 1:  94dfdecf59d =  1:  2b8ac989731 csum-file: stop depending on `the_repository`
 2:  c456c1a057b =  2:  f70f85a194b object: stop depending on `the_repository`
 3:  4eb651128e2 =  3:  af03d83d7f0 pack-write: stop depending on `the_repository` and `the_hash_algo`
 4:  0632bc5c186 =  4:  19a8ee01385 environment: move access to "core.bigFileThreshold" into repo settings
 5:  86214482421 =  5:  ec9b0012242 pack-check: stop depending on `the_repository`
 6:  3fda249b16a =  6:  f15148e3aee pack-revindex: stop depending on `the_repository`
 7:  99dbafed649 =  7:  ce1255da4aa pack-bitmap-write: stop depending on `the_repository`
 8:  a3843270ce0 =  8:  2f6d7b93dc9 object-file-convert: stop depending on `the_repository`
 9:  8d141a24804 =  9:  28e2dac294d delta-islands: stop depending on `the_repository`
10:  4671a252952 = 10:  813da442eee object-file: split out logic regarding hash algorithms
11:  2b81a7d91fd = 11:  7432ecb550b hash: fix "-Wsign-compare" warnings
12:  6e8f5f8987b ! 12:  8d88ef2aab7 hash: stop depending on `the_repository` in `null_oid()`
    @@ Commit message
           - "grep.c"
           - "refs/debug.c"
     
    -    There is also a single non-trivial exception with "diff-no-index.c".
    -    Here we know that we may not have a repository initialized at all, so we
    -    cannot rely on `the_repository`. Instead, we adapt `diff_no_index()` to
    -    get a `struct git_hash_algo` as parameter. The only caller is located in
    -    "builtin/diff.c", where we know to call `repo_set_hash_algo()` in case
    -    we're running outside of a Git repository. Consequently, it is fine to
    -    continue passing `the_repository->hash_algo` even in this case.
    +    There are also two non-trivial exceptions:
    +
    +      - "diff-no-index.c": Here we know that we may not have a repository
    +        initialized at all, so we cannot rely on `the_repository`. Instead,
    +        we adapt `diff_no_index()` to get a `struct git_hash_algo` as
    +        parameter. The only caller is located in "builtin/diff.c", where we
    +        know to call `repo_set_hash_algo()` in case we're running outside of
    +        a Git repository. Consequently, it is fine to continue passing
    +        `the_repository->hash_algo` even in this case.
    +
    +      - "builtin/ls-files.c": There is an in-flight patch series that drops
    +        `USE_THE_REPOSITORY_VARIABLE` in this file, which causes a semantic
    +        conflict because we use `null_oid()` in `show_submodule()`. The
    +        value is passed to `repo_submodule_init()`, which may use the object
    +        ID to resolve a tree-ish in the superproject from which we want to
    +        read the submodule config. As such, the object ID should refer to an
    +        object in the superproject, and consequently we need to use its hash
    +        algorithm.
     
         This means that we could in theory just not bother about this edge case
         at all and just use `the_repository` in "diff-no-index.c". But doing so
    @@ builtin/ls-files.c: static void show_submodule(struct repository *superproject,
      	struct repository subrepo;
      
     -	if (repo_submodule_init(&subrepo, superproject, path, null_oid()))
    -+	if (repo_submodule_init(&subrepo, superproject, path, null_oid(the_hash_algo)))
    ++	if (repo_submodule_init(&subrepo, superproject, path,
    ++				null_oid(superproject->hash_algo)))
      		return;
      
      	if (repo_read_index(&subrepo) < 0)

---
base-commit: e2cb568e11f4ceb427ba4205e6b8a4426d26be12
change-id: 20250210-b4-pks-objects-without-the-repository-6ba8398f7cc0

