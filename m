Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B28161DDA15
	for <git@vger.kernel.org>; Tue,  8 Oct 2024 14:12:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728396729; cv=none; b=jSIYyE7Ww90h3btO6XnjM/muUl5LG+MRDSXymtx9J/GYIiKAX785a79DL6oYjT9En0L336ORV98Ah+69f1hNdR2fVRtcryjCqh1J1NlfdSEF/qVHHAlmT57TMbKyknOWUw/RzE7nZ98CzBGJiGPxzYmFoeL1zQQc2dWY7PNLSao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728396729; c=relaxed/simple;
	bh=558prDz9AwkREf4+cYsEhWP0vCnm9VVQVWA27dV0X6k=;
	h=Message-Id:From:Date:Subject:Content-Type:MIME-Version:To:Cc; b=KDxSAX/f/Z6Y4LHkO63IeCi2QFH/32+zDporxiuPG0mM1Q3MEh1nmZK23s9gAQcoI+9aew9mSt8O8uyhLU/eJyz3JSnz6du+3412B7xnR5V72vt7dLgXV7sdAtJwTOGuEiLfk+KVXEQlG91kXt6PTpeRl8iqNFy5CVBZGoHaY7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GdaJbreS; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GdaJbreS"
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-5c5b954c359so6545549a12.1
        for <git@vger.kernel.org>; Tue, 08 Oct 2024 07:12:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728396726; x=1729001526; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=CooXI+xfRr0TWmwMyA/bR+j/kKdg/Zw1delsQWhtodM=;
        b=GdaJbreSAIRXyrC73r0YhLUibbnt360auQMplbgIx6gGVK/pAtt2gLb+GjzlT5yI1E
         fUeNAO/1UBx0zIRmQT6rshxrPAtxa7lgB7mY+jeHLinw7dvnZQePj8NgcxPH9rdDIvHW
         UzrhapQRsW5UVWWCxslG09kS1Q8m8exqg/IOOdNO0hVbI9gKH5nAxWf/qkeTWofZklAy
         kqYoYKjKvk/q/7khBCwHMCwSsSuyF50eb82DeagOSW0flTs2Xmbc6fiAsqo9tyeSy7AQ
         fAj3/PRPfvmohIGp47+eQaguTVVzjYWJkTtdiyCaFqu8/ljYsTnzXKjXwhhydVezxqdS
         Fgnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728396726; x=1729001526;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CooXI+xfRr0TWmwMyA/bR+j/kKdg/Zw1delsQWhtodM=;
        b=MF5EbHUcH/2+snSaAV4rgBASUNMM+9y16BEGhgMxJs7USLBAOVlAu0BJbUSXLhLosw
         abpS7H+53TI5qgOFFJOo1BZi42gvx621sdjjGqa4d8tHCYDHKTSgMs2URUKguUCQ0jRd
         L83L8IUbzj3atkmx4QN06XL0uqVa4RDAw7rpzR8Jo5Rul5IkL9kjldrWRxITFEzrB/Zs
         p3hNYT84hvELAyDQD+4J6vWAOom7Hlszp+zNSB1x/VOVGIO23dpP1Vxvm8IBH7t+H1IJ
         W5RWKQLzmTABWn4MvTuJgFgxsytAlBI1un6KHsdzn8naPFvNFZcoevodkveNndI0X/mG
         hIKA==
X-Gm-Message-State: AOJu0YzkqFEngPnSBxDhXNumxFWt3NrlRrSCz/WRLRSSOGXr+Tuu05zS
	uVxm5p8CyNf+Gg/a8nyF/vgntaXkQ8LpkY8P4gLBQuxv2Gzq7HnEO3iPIw==
X-Google-Smtp-Source: AGHT+IGhyhRjtLnKtbQEhwWSmJHCYYmxssSAj+RwL2bMYxlncdjraDpqMczzkHAAhxbN0zZrGbw9dA==
X-Received: by 2002:a17:907:961d:b0:a8d:3085:a7b1 with SMTP id a640c23a62f3a-a991bd989e0mr1882327766b.38.1728396725407;
        Tue, 08 Oct 2024 07:12:05 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a992e5d0a32sm523981666b.19.2024.10.08.07.12.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Oct 2024 07:12:05 -0700 (PDT)
Message-Id: <pull.1813.git.1728396723.gitgitgadget@gmail.com>
From: "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 08 Oct 2024 14:11:46 +0000
Subject: [PATCH 00/17] pack-objects: add --path-walk option for better deltas
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
Cc: gitster@pobox.com,
    johannes.schindelin@gmx.de,
    peff@peff.net,
    ps@pks.im,
    me@ttaylorr.com,
    johncai86@gmail.com,
    newren@gmail.com,
    christian.couder@gmail.com,
    kristofferhaugsbakk@fastmail.com,
    Derrick Stolee <stolee@gmail.com>

This is a reviewable series introducing the path-walk API and its
application within the 'git pack-objects --path-walk' machinery. This API
was previously discussed in the path-walk RFC [1] and the patch series
around the --full-name-hash option (branch ds/pack-name-hash-tweak) [2].
This series conflicts with ds/pack-name-hash-tweak, but that was on hold
because it did not seem as critical based on community interest.

[1]
https://lore.kernel.org/git/pull.1786.git.1725935335.gitgitgadget@gmail.com

[2]
https://lore.kernel.org/git/pull.1785.git.1725890210.gitgitgadget@gmail.com

The primary motivation for this feature is its use to shrink the packfile
created by 'git push' when there are many name-hash collisions. This need
was discovered in several Javascript repositories that use the beachball
tool [3] to generate CHANGELOG.md and CHANGELOG.json files. When a batch of
these files are created at the same time and pushed to a release branch, the
'git pack-objects' process has many collisions among these files and delta
bases are selected poorly.

[3] https://github.com/microsoft/beachball

In some cases, 'git push' is pushing 60-100 MB when the new path-walk
algorithm will identify better delta bases and pack the same objects into a
thin pack less than 1 MB. This was the most extreme example we could find
and is present in a private monorepo. However, the microsoft/fluentui repo
[4] is a good example for demonstrating similar improvements. The patch
descriptions frequently refer to this repo and which commit should be
checked out to reproduce this behavior.

[4] https://github.com/microsoft/fluentui

The path-walk API is a new way to walk objects. Traditionally, the revision
API walks objects by visiting a commit, then visiting its root tree and
recursing through trees to visit reachable objects that were not previously
visited. The path-walk API visits objects in batches based on the path
walked from a root tree to that object. (Only the first discovered path is
chosen; this avoids certain kinds of Git bombs.)

This has an immediate application to 'git pack-objects'.

When using the traditional revision API to walk objects, each object is
emitted with an associated path. Since this path may appear for many objects
spread across the full list, a heuristic is used: the "name-hash" is stored
for that object instead of the full path name. This name-hash will group
objects at the same path together, but also has a form of "locality" to
group likely-similar objects together. When there are few collisions in the
name-hash function, this helps compress objects that appear at the same path
as well as help compress objects across different paths that have similar
suffixes. When there are many versions of the same path, then finding delta
bases across that family of objects is very important. When there are few
versions of the same path, then finding cross-name delta bases is also
important. The former is important for clones and repacks while the latter
is important for shallow clones. They can both be important for pushes. In
all cases, this approach is fraught when there are many name-hash collisions
as the window size becomes a limiting factor for finding quality delta
bases.

When using the path-walk API to walk objects, we group objects by the same
path from the start. We don't need to store the path name, since we have the
objects already in a group. We can compute deltas within that group and then
use the name-hash approach to resort the object list and look for
opportunistic cross-path deltas. Thus, the path-walk approach allows finding
delta bases at least as good as the traditional revision API approach.
(Caveat: if we assume delta reuse and the existing deltas were computed with
the revision API approach, then the path-walk API approach may result in
slightly worse delta compression. The performance tests in this series use
--no-reuse-delta for this reason.)

Once 'git pack-objects --path-walk' exists, we have a few ways to take
advantage of it in other places:

 * The new 'pack.usePathWalk' config option will assume the --path-walk
   option. This allows 'git push' to assume this value and get the effect we
   want. This is similar to the 'pack.useSparse' config option that uses a
   similar path-based walk to limit the set of boundary objects.

 * 'git repack' learns a '--path-walk' option to pass to its child 'git
   pack-objects' process. This is also implied by 'pack.usePathWalk' but
   allows for testing without modifying repository config.

I'll repeat the following table of repacking results when using 'git repack
-adf [--path-walk]' on a set of repositories with many name-hash collisions.
Only the microsoft/fluentui repository is publicly available for testing, so
the others are left as Repo B/C/D.

| Repo     | Standard Repack | With --path-walk |
|----------|-----------------|------------------|
| fluentui |         438 MB  |          148 MB  |
| Repo B   |       6,255 MB  |          778 MB  |
| Repo C   |      37,737 MB  |        6,158 MB  |
| Repo D   |     130,049 MB  |        4,432 MB  |


While this series is replacing ds/pack-name-hash-tweak and its introduction
of the --full-name-hash option, it is worth comparing that option to the
--path-walk option.

 * The --full-name-hash option is a much smaller code change, as it drops
   into the existing uses of the name-hash function.

 * The --full-name-hash option is more likely to integrate with server-side
   features such as delta islands and reachability bitmaps due to not
   changing the object walk. It was already noted that the .bitmap files
   store name-hash values, so there is some compatibility required to
   integrate with bitmaps. The --path-walk option will be more difficult to
   integrate with those options (at least during a repack), but maybe is not
   impossible; the --path-walk option will not work when reading
   reachability bitmaps, since we are avoiding walking trees entirely.

 * The --full-name-hash option is good when there are many name-hash
   collisions and many versions of the paths with those collisions. When
   creating a shallow clone or certain kinds of pushes, the --full-name-hash
   option is much worse at finding cross-path delta bases since it loses the
   locality of the standard name-hash function. The --path-walk option
   includes a second pass of delta computation using the standard name-hash
   function and thus finds good cross-path delta bases when they improve
   upon the same-path delta bases.

There are a few differences from the RFC version of this series:

 1. The last two patches refactor the approach to perform delta calculations
    by path after the object walk and then allows those delta calculations
    to happen in a threaded manner.

 2. Both 'git pack-objects' and 'git repack' are removed from the t0450
    exclusion list.

 3. The path-walk API has improved technical documentation that is extended
    as its functionality is expanded.

 4. Various bugs have been patched with matching tests. The new 'test-tool
    path-walk' helper allows for careful testing of the API separately from
    its use within other commands.

Thanks, - Stolee

Derrick Stolee (17):
  path-walk: introduce an object walk by path
  t6601: add helper for testing path-walk API
  path-walk: allow consumer to specify object types
  path-walk: allow visiting tags
  revision: create mark_trees_uninteresting_dense()
  path-walk: add prune_all_uninteresting option
  pack-objects: extract should_attempt_deltas()
  pack-objects: add --path-walk option
  pack-objects: update usage to match docs
  p5313: add performance tests for --path-walk
  pack-objects: introduce GIT_TEST_PACK_PATH_WALK
  repack: add --path-walk option
  repack: update usage to match docs
  pack-objects: enable --path-walk via config
  scalar: enable path-walk during push via config
  pack-objects: refactor path-walk delta phase
  pack-objects: thread the path-based compression

 Documentation/config/feature.txt          |   4 +
 Documentation/config/pack.txt             |   8 +
 Documentation/git-pack-objects.txt        |  23 +-
 Documentation/git-repack.txt              |  17 +-
 Documentation/technical/api-path-walk.txt |  73 ++++
 Makefile                                  |   2 +
 builtin/pack-objects.c                    | 410 ++++++++++++++++++++--
 builtin/repack.c                          |   9 +-
 ci/run-build-and-tests.sh                 |   1 +
 pack-objects.h                            |  12 +
 path-walk.c                               | 404 +++++++++++++++++++++
 path-walk.h                               |  64 ++++
 repo-settings.c                           |   3 +
 repo-settings.h                           |   1 +
 revision.c                                |  15 +
 revision.h                                |   1 +
 scalar.c                                  |   1 +
 t/README                                  |   4 +
 t/helper/test-path-walk.c                 | 114 ++++++
 t/helper/test-tool.c                      |   1 +
 t/helper/test-tool.h                      |   1 +
 t/perf/p5313-pack-objects.sh              |  77 ++++
 t/t0411-clone-from-partial.sh             |   6 +
 t/t0450/txt-help-mismatches               |   2 -
 t/t5300-pack-object.sh                    |  21 ++
 t/t5306-pack-nobase.sh                    |   5 +
 t/t5310-pack-bitmaps.sh                   |  13 +-
 t/t5316-pack-delta-depth.sh               |   9 +-
 t/t5332-multi-pack-reuse.sh               |   7 +
 t/t6601-path-walk.sh                      | 301 ++++++++++++++++
 t/t7406-submodule-update.sh               |   4 +
 31 files changed, 1563 insertions(+), 50 deletions(-)
 create mode 100644 Documentation/technical/api-path-walk.txt
 create mode 100644 path-walk.c
 create mode 100644 path-walk.h
 create mode 100644 t/helper/test-path-walk.c
 create mode 100755 t/perf/p5313-pack-objects.sh
 create mode 100755 t/t6601-path-walk.sh


base-commit: e9356ba3ea2a6754281ff7697b3e5a1697b21e24
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1813%2Fderrickstolee%2Fpath-walk-upstream-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1813/derrickstolee/path-walk-upstream-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/1813
-- 
gitgitgadget
