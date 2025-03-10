Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2264914F9E2
	for <git@vger.kernel.org>; Mon, 10 Mar 2025 01:50:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741571461; cv=none; b=V/nZ5J2qj5bo3v/iecnY5DuEVQoA/vgDv8/Qj9w6APV8lX5qfq3L8HsgrqO1Suf4Pxj3MS6bWQIU+R/3wQolC8bdOZj3IjP0nobOE99BFZgktsnl2UekTVcG+rPo/eK5o6qyUHi3UWFrFWbZ3648ValgKJLCML7W4dW/Nmm+Jf0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741571461; c=relaxed/simple;
	bh=NjUHN0WsGUhwFkzd/1D5GdLOJv8zjw6jicGXoudirA4=;
	h=Message-Id:From:Date:Subject:Content-Type:MIME-Version:To:Cc; b=l1Q2zDeox37H7OF6KmCvZ6kUnsOy5tBBByVHQjwD1cBQoq28E2lLH31nHpINpeYMhiVWUOD0shMDVAMNy02poXbb6rOYSGYUb3ZICZZQg0VP5LmwE7Mx3vAYdypKLjlQb5uqUE4ILIZohccQC4NMEonfVh3pCfzocV/6s1YWpsY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AOYzN3Q3; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AOYzN3Q3"
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-ac29fd22163so71714266b.3
        for <git@vger.kernel.org>; Sun, 09 Mar 2025 18:50:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741571457; x=1742176257; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Io63N3SNTeIjv2MyaFEGCTCf4l0VkvuhgbYvTFPSUhY=;
        b=AOYzN3Q3SavhVatUZfY7wlcLMXvZs3qa4Tql7YWS/ElaBZSEw8TVcgdFaq8zjShNIg
         2onVh2NWS5RA0hXSJrZnYLOEnjRKBkUPxdsmjwInySr8Jsl0svyXRjgV5M/1dqkZpGys
         AIv8dxfEiA1JGobu9sEz5on3gTE4dMJWT8rZdvcgKejykQeRtrbf/lIgU88xMi7nF7nb
         ajAfSf/pTOuvyu4cX/wwV9JQ9uFSzcjsGYerHU9rOzohYQWjHnV2LC/tFfFB0GJIUM4x
         GdSqtn7E1Y+pcHt1dszPjuOOkAfXwf7f1pZQltOEv3Gs2opKcY+I4VfG9s5krc2J+kEP
         yZUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741571457; x=1742176257;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Io63N3SNTeIjv2MyaFEGCTCf4l0VkvuhgbYvTFPSUhY=;
        b=a5IgMfHjgHnRh61N9cVqwFM40YVF800xWEpMsgqJ3rToGZROyt7zpiljn7NnN9G41P
         FFwmyp2hp+DYSXqcB3I8rxkX/Z5mQH1PF072aeU2zE3rBwL1PD0+DV+HyxWyA5bIlD+g
         WWxl7H5FBcBNY74lQMZx7rqnnSuElsqZ4nDRWsaRT6/JpGM378AKHuvkYWiNAe1x7p71
         2YB3OYWHUX+gBsvDN2yqBzn0mlyRzAK5LxADO4N2ztz4OkQc1d/w3NCDptDum+ODjuE9
         PJwzJPJ6YQp/5I3lqYNEwL+ISZSrV5lNuw8DT5FzM1GF4luDALCNz3dQOHPnmtSSMp8M
         IFDQ==
X-Gm-Message-State: AOJu0Yz3YNlUNNHwjdl4UDCSxkBlPdMq1D70lFv1jlDsrmnFO5B0q4t5
	VI3QjWAHoLvu/5w4rqb5O+0vxxqHKjmftFX6iCKjsLAr/A/wo9O528CDkA==
X-Gm-Gg: ASbGncsK4mNPcM0BEPeNMY65vjJ9woR37iUzo++Km3/OBQL/2GRBAHeZ8J6RL+ygi1d
	9HY2jxbazdr7hKuDinBqNcLCB+Gl4ihDAFaCjnVDLBwc3EGjXdobeQplmvIneYW6Ei6JnpNlSiI
	2FEH3y70LUTYTnStxLUXuuRLOyOD88JU4TDECCmvlTXClRqwp/AI4XjTAIrCKTJu66X4FjyiuO8
	KIWHLJuD0EgSks++zlRRDsbPGH58DAJmeRgaazYhYZ1TKJ9hGg3ALYChAv6Tz6BeuMIMczbo3xM
	nhs1k91HinWHqqjFLfirn2mpD5gJTS85AsW5+ZUlPqSiyA==
X-Google-Smtp-Source: AGHT+IHjf9rTyyZRQzbFkbhwQJwqy7lnxULO80+kG1VmmVMQS8maJz10XBuIJ7TYGQbBP/smru35jg==
X-Received: by 2002:a17:907:94c7:b0:ac1:e53c:d149 with SMTP id a640c23a62f3a-ac252a88c93mr1226625666b.13.1741571456737;
        Sun, 09 Mar 2025 18:50:56 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac2856445b1sm252332366b.60.2025.03.09.18.50.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Mar 2025 18:50:56 -0700 (PDT)
Message-Id: <pull.1819.git.1741571455.gitgitgadget@gmail.com>
From: "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date: Mon, 10 Mar 2025 01:50:42 +0000
Subject: [PATCH 00/13] PATH WALK II: Add --path-walk option to 'git pack-objects'
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
Cc: christian.couder@gmail.com,
    gitster@pobox.com,
    johannes.schindelin@gmx.de,
    johncai86@gmail.com,
    jonathantanmy@google.com,
    karthik.188@gmail.com,
    kristofferhaugsbakk@fastmail.com,
    me@ttaylorr.com,
    newren@gmail.com,
    peff@peff.net,
    ps@pks.im,
    Derrick Stolee <stolee@gmail.com>

Here is a full submission of the --path-walk feature for 'git pack-objects'
and 'git repack'. It's been discussed in an RFC [1], as a future application
for the path walk API [2], and is updated now that --name-hash-version=2
exists (as a replacement for the --full-name-hash option from the RFC) [3].

[1]
https://lore.kernel.org/git/pull.1813.v2.git.1729431810.gitgitgadget@gmail.com/

[2]
https://lore.kernel.org/git/pull.1818.git.1730356023.gitgitgadget@gmail.com

[3]
https://lore.kernel.org/git/pull.1813.git.1728396723.gitgitgadget@gmail.com

This patch series does the following:

 1. Add a new '--path-walk' option to 'git pack-objects' that uses the
    path-walk API instead of the revision API to collect objects for delta
    compression.

 2. Add a new '--path-walk' option to 'git repack' to pass this option along
    to 'git pack-objects'.

 3. Add a new 'pack.usePathWalk' config option to opt into this option
    implicitly, such as in 'git push'.

 4. Optimize the '--path-walk' option using threading so it better competes
    with the existing multi-threaded delta compression mechanism.

 5. Update the path-walk API with a new 'edge_aggressive' option that pairs
    close to the --edge-aggressive option in the revision API. This is
    useful when creating thin packs inside shallow clones.

This feature works by using the path-walk API to emit groups of objects that
appear at the same path. These groups are tracked so they can be tested for
delta compression with each other, and then after those groups are tested a
second pass using the name-hash attempts to find better (or first time)
deltas across path boundaries. This second pass is much faster than a fresh
pass since the existing deltas are used as a limit for the size of
potentially new deltas, short-circuiting the checks when the delta size
exceeds the current-best.

The benefits of the --path-walk feature first come into play when the name
hash functions have many collisions, so sorting by name hash value leads to
unhelpful groupings of objects. Many of these benefits are improved by
--name-hash-version=2, but collisions still exist with any hash-based
approach. There are also performance benefits in some cases due to the
isolation of delta compression testing within path groups.

All of the benefits of the --path-walk feature are less dramatic when
compared to --name-hash-version=2, but they can still exist in many cases. I
have also seen some cases where --name-hash-version=2 compresses better than
--path-walk with --name-hash-version=1, but these options can be combined to
get the best of both worlds.

Detailed statistics are provided within patch messages, but a few are
highlighted here:

The microsoft/fluentui is a public Javascript repo that suffers from many of
the name hash collisions as internal repositories I've worked with. Here is
a comparison of the compressed size and end-to-end time of the repack:

Repack Method    Pack Size       Time
---------------------------------------
Hash v1             439.4M      87.24s
Hash v2             161.7M      21.51s
Path Walk           142.5M      28.16s


Less dramatic, but perhaps more standardly structured is the nodejs/node
repository, with these stats:

Repack Method       Pack Size       Time
------------------------------------------
Hash v1                739.9M      71.18s
Hash v2                764.6M      67.82s
Path Walk              698.0M      75.10s


Even the Linux kernel repository gains some benefits, even though the number
of hash collisions is relatively low due to a preference for short
filenames:

Repack Method       Pack Size       Time
------------------------------------------
Hash v1                  2.5G     554.41s
Hash v2                  2.5G     549.62s
Path Walk                2.2G     559.00s


The drawbacks of the --path-walk feature is that it will be harder to
integrate it with bitmap features, specifically delta islands. This is not
insurmountable, but would require more work, such as a revision walk to
paint objects with reachability information before using that during delta
computations.

However, there should still be significant benefits to Git clients trying to
save space and improve local performance.

This feature was shipped with similar features in microsoft/git as of
v2.47.0.vfs.0.3 [4]. This was used in CI machines for an internal monorepo
that had significant repository growth due to constructing a batch of
beachball [5] CHANGELOG.[md|json] files and pushing them to a release
branch. These pushes were frequently 70-200 MB due to poor delta
compression. Using the 'pack.usePathWalk=true' config, these pushes dropped
in size by 100x while improving performance. Since these CI machines were
working with a shallow clone, the 'edge_aggressive' changes were required to
enable the path-walk option.

[4] https://github.com/microsoft/git/releases/tag/v2.47.0.vfs.0.3

[5] https://github.com/microsoft/beachball

This version incorporates feedback from previous RFCs and reviewed patch
series whenever possible. It also benefits from learned experience, much of
which was already applied in the original path-walk API submission.

Thanks, -Stolee

Derrick Stolee (13):
  pack-objects: extract should_attempt_deltas()
  pack-objects: add --path-walk option
  pack-objects: update usage to match docs
  p5313: add performance tests for --path-walk
  pack-objects: introduce GIT_TEST_PACK_PATH_WALK
  t5538: add tests to confirm deltas in shallow pushes
  repack: add --path-walk option
  pack-objects: enable --path-walk via config
  scalar: enable path-walk during push via config
  pack-objects: refactor path-walk delta phase
  pack-objects: thread the path-based compression
  path-walk: add new 'edge_aggressive' option
  pack-objects: allow --shallow and --path-walk

 Documentation/config/feature.adoc          |   4 +
 Documentation/config/pack.adoc             |   8 +
 Documentation/git-pack-objects.adoc        |  25 +-
 Documentation/git-repack.adoc              |  14 +-
 Documentation/technical/api-path-walk.adoc |   9 +
 builtin/pack-objects.c                     | 411 +++++++++++++++++++--
 builtin/repack.c                           |   7 +-
 pack-objects.h                             |  12 +
 path-walk.c                                |   6 +-
 path-walk.h                                |   7 +
 repo-settings.c                            |   3 +
 repo-settings.h                            |   1 +
 scalar.c                                   |   1 +
 t/README                                   |   4 +
 t/helper/test-path-walk.c                  |   2 +
 t/perf/p5313-pack-objects.sh               |  37 +-
 t/t0411-clone-from-partial.sh              |   6 +
 t/t0450/adoc-help-mismatches               |   1 -
 t/t5300-pack-object.sh                     |  19 +
 t/t5306-pack-nobase.sh                     |   5 +
 t/t5310-pack-bitmaps.sh                    |  13 +-
 t/t5316-pack-delta-depth.sh                |   9 +-
 t/t5332-multi-pack-reuse.sh                |   7 +
 t/t5538-push-shallow.sh                    |  34 ++
 t/t6601-path-walk.sh                       |  20 +
 t/t7406-submodule-update.sh                |   3 +
 26 files changed, 601 insertions(+), 67 deletions(-)


base-commit: a36e024e989f4d35f35987a60e3af8022cac3420
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1819%2Fderrickstolee%2Fpath-walk-upstream-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1819/derrickstolee/path-walk-upstream-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/1819
-- 
gitgitgadget
