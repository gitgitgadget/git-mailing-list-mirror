Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 051EE197538
	for <git@vger.kernel.org>; Thu,  6 Jun 2024 17:26:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717694807; cv=none; b=X51NuOR6p5VGYdXS2W/INHuNyyn31EDyytzSPwKRq5bl5V1cxXqLz/u36S6YfJ337SxyKzmhXriB+3GutfjPjrFREoh8HDrzCbU9/xQkmxZYUpWkcOjwHohGmzxkP58mXIfaPvfWm1rC9Hw4A935+P6+AB/5VwpdHFudkV9+uDQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717694807; c=relaxed/simple;
	bh=sSFVVIc1grb+LA0w/9QeneClKrcaKg0yvoKZHTw7VAI=;
	h=Message-Id:From:Date:Subject:Content-Type:MIME-Version:To:Cc; b=cJjALbWOan4B1tEGMx/i/SQLJg6YRP6KOQg3GXpP5yAPpi16Ph2hTkyXowIYbDGrVm76Rf6KGBW48B0FfvUj98WGAB3vJeZlGBmgmx+Hg8fh11vH76lkrMKu3RV+mZWzXfmR9/MAtUM1wxBE/rLpOF8BU1qd7enb18PPEN8VQtg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KjJ45FKB; arc=none smtp.client-ip=209.85.208.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KjJ45FKB"
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-2ead2c6b553so15204811fa.0
        for <git@vger.kernel.org>; Thu, 06 Jun 2024 10:26:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717694804; x=1718299604; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Gzu4xF356YTZvi9rMnyOtmwxserAaU0wUMr6LfBYmZE=;
        b=KjJ45FKBVC83Y3ODKE8icDpb3sFOtXiZPxt4mvOIlpV2s4T0H5y10WPjOupQmnG7Y4
         wUgzSH1n3FT02imJ2n+oSc+9V4zHqBHbvGobb+RIV0xadN0kw4P56mMU6ly1HSOLSnkS
         V0uUtqE/UO/0YENI6CMptXwR7FtxZZ8zjLvhvqHDoFaMcbEbjH+DIaM1OnzSfa9eTBka
         PK1aQv5uHv+e+p5FPdQS5QdSOFFRx5gJaBr+Pk0NpzorHuNG2GYKZVwYm0uoRoiwPS2a
         67k2q6BwhtKfvJRPZd+5uHjogG6kVSp1qyh5NC3U4wrX+wwRunCJALisFcdK4+0x7mXX
         RBEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717694804; x=1718299604;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Gzu4xF356YTZvi9rMnyOtmwxserAaU0wUMr6LfBYmZE=;
        b=ITp3aNF5CCiVZRprIxXGKTg5prSD5i8cZV2R6mkDYsMuICHlWYtDuJcLfTzlW6+J1m
         Xjmv010Q28iMHyjVWLGNqAc2CFcANo8yovhRpSOfewBt4zIduzEXXp+EVjzryBvoBaNa
         pCPMK9ND9aHGwaeXnraxYPBpYw48Mg/pjN+7xExC3SSATWF08HL+znurXV3ltiZMoKdx
         SOBff+s9Bv0zocueRKz3xemBh6Ongb0x0hJauvr7CqDCaub+0J9hE7Kj4D5y29gC0Y6c
         XusfTNVsPcfErsMskmGGeTnFZSoCJiMYD6YKfswtTGFACH/6n4JtKNir5iHcICwi85EP
         VrDw==
X-Gm-Message-State: AOJu0YwWHGz++YrhVDp473PxUYNDcrH014ZsB8TaWt0NzYSNWIuo5dYB
	c4zgkmOfhRCBjTHa6myfLWBLtpw9LVSX01Tts+fSHlyIHFZ68xAEbIRpbw==
X-Google-Smtp-Source: AGHT+IF6B3rSOK8aBZeEcYMGTHT5zE9E3RLbT4YpIxjqUUB+iqsNUIi/lwMpuhdGkTTkHWD9jS/8jQ==
X-Received: by 2002:a2e:a7ce:0:b0:2e9:6d4f:e57 with SMTP id 38308e7fff4ca-2eadce239b6mr3464211fa.11.1717694803416;
        Thu, 06 Jun 2024 10:26:43 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4215c19e57dsm28998185e9.9.2024.06.06.10.26.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Jun 2024 10:26:43 -0700 (PDT)
Message-Id: <pull.1712.git.git.1717694800.gitgitgadget@gmail.com>
From: "John Cai via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 06 Jun 2024 17:26:36 +0000
Subject: [PATCH 0/4] keep track of unresolved value of symbolic-ref in ref iterators
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
Cc: "Phillip Wood [ ]" <phillip.wood123@gmail.com>,
    Kristoffer Haugsbakk <[code@khaugsbakk.name]>,
    "Jeff King [ ]" <peff@peff.net>,
    "Patrick Steinhardt [ ]" <ps@pks.im>,
    "=?UTF-8?Q?Jean-No=C3=ABl?= Avila [ ]" <avila.jn@gmail.com>,
    John Cai <johncai86@gmail.com>

For reftable development, it's useful to be able to print out the direct
value of a symbolic reference before resolution. This is currently possible
with git-for-each-ref, but since the iterators do not keep track of the
value of the symbolic ref, a separate call needs to be made each time making
it inefficient.

Address this inefficiency by keeping track of the value of the symbolic
reference in the ref iterator. This patch series also ends with a commit to
use this value in the iterator through callbacks in ref-filter.c.

This series started with [1] but I decided to send a separate patch series
since it is substantially different.

Benchmarking shows that with these changes, we experience a significant
speedup in git-for-each-ref(1):

$ hyperfine --warmup 5 "git for-each-ref --format='%(refname) %(objectname)
%(symref)'" "~/Projects/git/git for-each-ref --format='%(refname)
%(objectname) %(symref)'"

Benchmark 1: git for-each-ref --format='%(refname) %(objectname) %(symref)'
Time (mean ± σ): 210.0 ms ± 9.1 ms [User: 5.8 ms, System: 11.8 ms] Range
(min … max): 203.4 ms … 228.8 ms 12 runs

Benchmark 2: ~/Projects/git/git for-each-ref --format='%(refname)
%(objectname) %(symref)' Time (mean ± σ): 7.4 ms ± 0.7 ms [User: 2.6 ms,
System: 3.9 ms] Range (min … max): 5.9 ms … 11.7 ms 273 runs

Summary ~/Projects/git/git for-each-ref --format='%(refname) %(objectname)
%(symref)' ran 28.47 ± 2.86 times faster than git for-each-ref
--format='%(refname) %(objectname) %(symref)'

 1. https://lore.kernel.org/git/pull.1684.git.git.1709592718743.gitgitgadget@gmail.com/

John Cai (4):
  refs: add referent parameter to refs_resolve_ref_unsafe
  refs: keep track of unresolved reference value in iterators
  refs: add referent to each_ref_fn
  ref-filter: populate symref from iterator

 add-interactive.c           |  6 +++---
 bisect.c                    |  3 ++-
 blame.c                     |  4 ++--
 builtin/bisect.c            |  6 ++++--
 builtin/blame.c             |  2 +-
 builtin/branch.c            |  2 +-
 builtin/checkout.c          |  2 +-
 builtin/describe.c          |  2 +-
 builtin/fetch.c             |  3 ++-
 builtin/fsck.c              |  6 +++---
 builtin/gc.c                |  1 +
 builtin/log.c               |  1 +
 builtin/name-rev.c          |  2 +-
 builtin/pack-objects.c      |  5 +++--
 builtin/rebase.c            |  6 +++---
 builtin/receive-pack.c      |  4 ++--
 builtin/remote.c            |  6 ++++--
 builtin/repack.c            |  1 +
 builtin/replace.c           |  1 +
 builtin/rev-parse.c         |  4 ++--
 builtin/show-branch.c       |  8 ++++----
 builtin/show-ref.c          |  3 ++-
 builtin/stash.c             |  2 +-
 builtin/submodule--helper.c |  5 +++--
 builtin/symbolic-ref.c      |  2 +-
 builtin/worktree.c          |  1 +
 commit-graph.c              |  1 +
 config.c                    |  2 +-
 delta-islands.c             |  2 +-
 fetch-pack.c                |  2 ++
 help.c                      |  2 +-
 http-backend.c              |  5 +++--
 log-tree.c                  |  4 ++--
 ls-refs.c                   |  7 ++++---
 midx-write.c                |  2 +-
 negotiator/default.c        |  2 +-
 negotiator/skipping.c       |  2 +-
 notes.c                     |  2 +-
 object-name.c               |  2 +-
 reachable.c                 |  2 +-
 ref-filter.c                | 11 ++++++-----
 reflog.c                    |  1 +
 refs.c                      | 32 ++++++++++++++++++--------------
 refs.h                      |  3 ++-
 refs/files-backend.c        | 24 ++++++++++++++----------
 refs/iterator.c             |  5 ++++-
 refs/ref-cache.c            |  6 ++++++
 refs/ref-cache.h            |  2 ++
 refs/refs-internal.h        |  1 +
 refs/reftable-backend.c     |  6 +++---
 remote.c                    | 10 +++++-----
 replace-object.c            |  1 +
 revision.c                  |  4 ++--
 sequencer.c                 |  9 +++++----
 server-info.c               |  2 +-
 shallow.c                   |  2 ++
 submodule.c                 |  2 ++
 t/helper/test-ref-store.c   |  4 ++--
 transport-helper.c          |  1 +
 transport.c                 |  2 +-
 upload-pack.c               | 10 +++++-----
 walker.c                    |  1 +
 worktree.c                  |  6 ++++--
 63 files changed, 161 insertions(+), 109 deletions(-)


base-commit: 7b0defb3915eaa0bd118f0996e8c00b4eb2dc1ca
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1712%2Fjohn-cai%2Fjc%2Fsymbolic-ref-in-iterator-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1712/john-cai/jc/symbolic-ref-in-iterator-v1
Pull-Request: https://github.com/git/git/pull/1712
-- 
gitgitgadget
