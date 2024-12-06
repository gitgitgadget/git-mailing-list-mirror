Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B07371C5490
	for <git@vger.kernel.org>; Fri,  6 Dec 2024 19:46:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733514367; cv=none; b=pulizZftxnn13gxD3VTYrPriW+49PjAgLXPbu9M7aoIhLQDu9aGcmjBlFq6/I0F7MuKfKnvHi/ha+1rGh/Vz2+hVcUyJ12WARv/qy6RTEqThxWDG0KzrCwTgeKpZlXFKiXITg0gB/bItj+mFBo5zyJiBMWXbEDWTydpF/Y1kMEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733514367; c=relaxed/simple;
	bh=GS5WRGrT1udDuYG38GL4Lf1xxy6rVrq3EDlVqZD/TYE=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=C6OT3+8wDHvAc4/66DH9iv7cSZkcz3FpYF7QZ+NQcFjQ+9FJZfPLR5MaPqZEYiXeYZrBetJxZz0DyY4ZSoxToGgJkmAC+wrlUl4UxuoFXOMuUHX1VFiIjem9Nuwt9vacqt+tBjUFu0X6y8MbAzchaswzsBdenfuhQ0/BwiTR6UE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ke3yamPU; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ke3yamPU"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-434a0fd9778so23964775e9.0
        for <git@vger.kernel.org>; Fri, 06 Dec 2024 11:46:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733514362; x=1734119162; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Sq5BFnk9l5XwhWoUbDiVf9oRDLc1I6pNEnspxQWbgZ8=;
        b=Ke3yamPUKFZmlFlmloNh0duZ4BFcbIdamcy4HEnzepQYCgKqf+7A1APh+ALAef0MGz
         sAd/RP41C0ovxA18I3h3kV7CNmsq5MUOnoZ46nYdq4OzwtO5CPjuwCy4Klkdzx6Mn90M
         mDj4vs3IK0ziE9/HXZLwDzzesrJzdDpbFktzGO4IhGsSRvGWF1tf4pn3XlindtKlc0AO
         TsR2gqIasyN+pjR4glysimk4I833VavnFhe1LgOwQPKBFuDOQGoSqU+rMv41dsXzGlos
         p+8JDbpuVnsEMpzSPtwHC0raiUWlHXV5PHyDbq8sqmgK/p1I5Yp3Ovtv3G2UILBOS4hD
         6RgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733514362; x=1734119162;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Sq5BFnk9l5XwhWoUbDiVf9oRDLc1I6pNEnspxQWbgZ8=;
        b=VpW9W4KhEcom2on/i43JwqIiVmnn6fGkpvL+DdeeD/DsCFxS1D0ghCWqabArEac0YA
         1mw/+ikzwQaymbPji6fWUbjHMU6z3dbf67jaXMQHQBFiMAt9f/oRpZJkxVzz3GWQy/pX
         747v1MCWMQBX5NHAzF53HIuPix6OXNCALFIyYJQGxV0EINmCfxgeOqRirWQNIDoNAq0h
         bPgdySLUZsU96Poq1a+P9hGicnmHI5E5M3adPFfXAt0htzM3Kkdc813OzzKdHlkFw3bS
         +N4RyGg6EsSFmPSeJu8Z9TWGlGJAadhS9spNI/+61w8xJiQpyebXj5fTmSKI8WmKCp4B
         dwKA==
X-Gm-Message-State: AOJu0YwWyyzDdykENwbPPtoS/TugFIWC+PWZDVcPcWmy9i7LwBcv0A9/
	xpDniWF8jkxXtw0Q07wBgqFc+PO1otl5lIb36x4086WkdRo1dgv9mzJLuw==
X-Gm-Gg: ASbGnctTBttwhyOaiPYaHKCMjSOgLeUJXLB73J+9f2N3dsevy308AVBrFllkzuNoPFG
	ZqkSMkKKMn2aYS5ji5eQbUqRO8/fkhFyGfj7jpmjctE7sF4nCa2Oq7YpZ0EYCp2f7hTFtnMc3Iu
	vRpIAI0Qk4KWbMETGFTmQWe7oV4IVcIgd48WnYgbCRLgRQBn3cA7t6y86xvlX8PaTpJ79a0/BDY
	ENKfgxnvsox3mteVIidnoDIaGvIaPVdKUYvCT1uGBmzq+k+5Ic=
X-Google-Smtp-Source: AGHT+IEseWZKiu/A+vTE+4n5/CoC3LK46idv1XRSQ4pfUWjJ+bbQ6pw9Zxm6C4VHle9qEYyXsDCA2g==
X-Received: by 2002:a05:600c:5107:b0:434:a1d3:a306 with SMTP id 5b1f17b1804b1-434ddead1c5mr37097395e9.5.1733514360871;
        Fri, 06 Dec 2024 11:46:00 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-434d52cbd16sm100798565e9.41.2024.12.06.11.45.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Dec 2024 11:46:00 -0800 (PST)
Message-Id: <pull.1818.v3.git.1733514358.gitgitgadget@gmail.com>
In-Reply-To: <pull.1818.v2.git.1731181272.gitgitgadget@gmail.com>
References: <pull.1818.v2.git.1731181272.gitgitgadget@gmail.com>
From: "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 06 Dec 2024 19:45:51 +0000
Subject: [PATCH v3 0/7] PATH WALK I: The path-walk API
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
    jonathantanmy@google.com,
    karthik nayak <karthik.188@gmail.com>,
    Derrick Stolee <stolee@gmail.com>


Introduction and relation to prior series
=========================================

This is a new series that rerolls the initial "path-walk API" patches of my
RFC [1] "Path-walk API and applications". This new API (in path-walk.c and
path-walk.h) presents a new way to walk objects such that trees and blobs
are walked in batches according to their path.

This also replaces the previous version of ds/path-walk that was being
reviewed in [2]. The consensus was that the series was too long/dense and
could use some reduction in size. This series takes the first few patches,
but also makes some updates (which will be described later).

[1]
https://lore.kernel.org/git/pull.1786.git.1725935335.gitgitgadget@gmail.com/
[RFC] Path-walk API and applications

[2]
https://lore.kernel.org/git/pull.1813.v2.git.1729431810.gitgitgadget@gmail.com/
[PATCH v2 00/17] pack-objects: add --path-walk option for better deltas

This series only introduces the path-walk API, but does so to the full
complexity required to later add the integration with git pack-objects to
improve packing compression in both time and space for repositories with
many name hash collisions. The compression also at least improves for other
repositories, but may not always have an improvement in time.

Some of the changes that are present in this series that differ from the
previous version are motivated directly by discoveries made by testing the
feature in Git for Windows and microsoft/git forks that shipped these
features for fast delivery of these improvements to users who needed them.
That testing across many environments informed some things that needed to be
changed, and in this series those changes are checked by tests in the
t6601-path-walk.sh test script and the test-tool path-walk test helper.
Thus, the code being introduced in this series is covered by tests even
though it is not integrated into the git executable.


Discussion of follow-up applications
====================================

By splitting this series out into its own, I was able to reorganize the
patches such that each application can be build independently off of this
series. These are available as pending PRs in gitgitgadget/git:

 * Better delta compression with 'git pack-objects' [3]: This application
   allows an option in 'git pack-objects' to change how objects are walked
   in order to group objects with the same path for early delta compression
   before using the name hash sort to look for cross-path deltas. This helps
   significantly in repositories with many name-hash collisions. This
   reduces the size of 'git push' pacifies via a config option and reduces
   the total repo size in 'git repack'.

 * The 'git backfill' command [4]: This command downloads missing blobs in a
   bloodless partial clone. In order to save space and network bandwidth, it
   assumes that objects at a common path are likely to delta well with each
   other, so it downloads missing blobs in batches via the path-walk API.
   This presents a way to use blobless clones as a pseudo-resumable clone,
   since the initial clone of commits and trees is a smaller initial
   download and the batch size allows downloading blobs incrementally. When
   pairing this command with the sparse-checkout feature, the path-walk API
   is adjusted to focus on the paths within the sparse-checkout. This allows
   the user to only download the files they are likely to need when
   inspecting history within their scope without downloading the entire
   repository history.

 * The 'git survey' command [5]. This application begins the work to mimic
   the behavior of git-sizer, but to use internal data structures for better
   performance and careful understanding of how objects are stored. Using
   the path-walk API, paths with many versions can be considered in a batch
   and sorted into a list to report the paths that contribute most to the
   size of the repository. A version of this command was used to help
   confirm the issues with the name hash collisions. It was also used to
   diagnose why some repacks using the --path-walk option were taking more
   space than without for some repositories. (More on this later.)

Question for reviewers: I am prepped to send these three applications to the
mailing list, but I'll refrain for now to avoid causing too much noise for
folks. Would you like to see them on-list while this series is under review?
Or would you prefer to explore the PRs ([3] [4] and [5])?

[3] https://github.com/gitgitgadget/git/pull/1819
PATH WALK II: Add --path-walk option to 'git pack-objects'

[4] https://github.com/gitgitgadget/git/pull/1820
PATH WALK III: Add 'git backfill' command

[5] https://github.com/gitgitgadget/git/pull/1821
PATH WALK IV: Add 'git survey' command


Structure of the Patch Series
=============================

This patch series attempts to create the simplest version of the API in
patch 1, then build functionality incrementally. During the process, each
change will introduce an update to:

 * The path-walk API itself in path-walk.c and path-walk.h.
 * The documentation of the API in
   Documentation/technical/api-path-walk.txt.
 * The test script t/t6601-path-walk.sh.

The core of the API relies on using a 'struct rev_info' to define an initial
set of objects and some form of a commit walk to define what range of
objects to visit. Initially, only a subset of 'struct rev_info' options work
as expected. For example:

 * Patch 1 assumes that only commit objects are starting positions, but the
   focus is on exploring trees and blobs.
 * Patch 3 allows users to specify object types, which includes outputting
   the visited commits in a batch.
 * Annotated tags and indexed objects are considered in Patch 4. These are
   grouped because they both exist within the 'pending' object list.
 * UNINTERESTING objects are not considered until Patch 5.


Changes in v1 (since previous version)
======================================

There are a few hard-won learnings from previous versions of this series due
to testing this in the wild with many different repositories.

 * Initially, the 'git pack-objects --path-walk' feature was not tested with
   the '--shallow' option because it was expected that this option was for
   servers creating a pack containing shallow commits. However, this option
   is also used when pushing from a shallow clone, and this was a critical
   feature that we needed to reduce the size of commits pushed from
   automated environments that were bootstrapped by shallow clones. The crux
   of the change is in Patch 5 and how UNINTERESTING objects are handled. We
   no longer need to push the UNINTERESTING flag around the objects
   ourselves and can use existing logic in list-objects.c to do so. This
   allows using the --objects-edge-aggressive option when necessary to
   reduce the object count when pushing from a shallow clone. (The
   pack-objects series expands on tests to cover this integration point.)

 * When looking into cases where 'git repack -adf' outperformed 'git repack
   -adf --path-walk', I discovered that the issue did not reproduce in a
   bare repository. This is due to 'git repack' iterating over all indexed
   objects before walking commits. I had inadvertently put all indexed
   objects in their own category, leading to no good deltas with previous
   versions of those files; I had also not used the 'path' option from the
   pending list, so these objects had invalid name hash values. You will see
   in patch 4 that the pending list is handled quite differently and the
   '--indexed-objects' option is tested directly within t6601.

 * I added a new 'test_cmp_sorted' helper because I wanted to simplify some
   repeated sections of t6601.

 * Patch 1 has significantly more context than it did before.

 * Annotated tags are given a name of "/tags" to differentiate them slightly
   from root trees and commits.


Changes in v2
=============

 * Updated the test helper to output the batch number, allowing us to
   confirm that OIDs are grouped appropriately. This also signaled a few
   cases where the callback function was being called on an empty set.

 * This change has resulted in significant changes to the test data,
   including reordered lines and prepended batch numbers.

 * Thanks to Patrick for providing a recommended change to remove memory
   leaks from the test helper.


Changes in v3
=============

 * Updated test helper to use type_string(), which leads to a change to use
   lowercase strings in the test scripts. That will lead to the range-diff
   looking pretty terrible.

 * Added a new patch that changes the visit order of the path-walk API. The
   intention is to reduce memory pressure by emitting blob paths before
   recursing into tree paths. This also has the effect of visiting blobs and
   trees in lexicographic order instead of the reverse.

Thanks, -Stolee

Derrick Stolee (7):
  path-walk: introduce an object walk by path
  test-lib-functions: add test_cmp_sorted
  t6601: add helper for testing path-walk API
  path-walk: allow consumer to specify object types
  path-walk: visit tags and cached objects
  path-walk: mark trees and blobs as UNINTERESTING
  path-walk: reorder object visits

 Documentation/technical/api-path-walk.txt |  63 +++
 Makefile                                  |   2 +
 path-walk.c                               | 567 ++++++++++++++++++++++
 path-walk.h                               |  65 +++
 t/helper/test-path-walk.c                 | 112 +++++
 t/helper/test-tool.c                      |   1 +
 t/helper/test-tool.h                      |   1 +
 t/t6601-path-walk.sh                      | 368 ++++++++++++++
 t/test-lib-functions.sh                   |  10 +
 9 files changed, 1189 insertions(+)
 create mode 100644 Documentation/technical/api-path-walk.txt
 create mode 100644 path-walk.c
 create mode 100644 path-walk.h
 create mode 100644 t/helper/test-path-walk.c
 create mode 100755 t/t6601-path-walk.sh


base-commit: e9356ba3ea2a6754281ff7697b3e5a1697b21e24
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1818%2Fderrickstolee%2Fapi-upstream-v3
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1818/derrickstolee/api-upstream-v3
Pull-Request: https://github.com/gitgitgadget/git/pull/1818

Range-diff vs v2:

 1:  b7e9b81e8b3 = 1:  b7e9b81e8b3 path-walk: introduce an object walk by path
 2:  cf2ed61b324 = 2:  cf2ed61b324 test-lib-functions: add test_cmp_sorted
 3:  a3c754d93cc ! 3:  54886fcb081 t6601: add helper for testing path-walk API
     @@ t/helper/test-path-walk.c (new)
      +	struct path_walk_test_data *tdata = data;
      +	const char *typestr;
      +
     -+	switch (type) {
     -+	case OBJ_TREE:
     -+		typestr = "TREE";
     ++	if (type == OBJ_TREE)
      +		tdata->tree_nr += oids->nr;
     -+		break;
     -+
     -+	case OBJ_BLOB:
     -+		typestr = "BLOB";
     ++	else if (type == OBJ_BLOB)
      +		tdata->blob_nr += oids->nr;
     -+		break;
     -+
     -+	default:
     ++	else
      +		BUG("we do not understand this type");
     -+	}
     ++
     ++	typestr = type_name(type);
      +
      +	for (size_t i = 0; i < oids->nr; i++)
      +		printf("%"PRIuMAX":%s:%s:%s\n",
     @@ t/t6601-path-walk.sh (new)
      +	test-tool path-walk -- --all >out &&
      +
      +	cat >expect <<-EOF &&
     -+	0:TREE::$(git rev-parse topic^{tree})
     -+	0:TREE::$(git rev-parse base^{tree})
     -+	0:TREE::$(git rev-parse base~1^{tree})
     -+	0:TREE::$(git rev-parse base~2^{tree})
     -+	1:TREE:right/:$(git rev-parse topic:right)
     -+	1:TREE:right/:$(git rev-parse base~1:right)
     -+	1:TREE:right/:$(git rev-parse base~2:right)
     -+	2:BLOB:right/d:$(git rev-parse base~1:right/d)
     -+	3:BLOB:right/c:$(git rev-parse base~2:right/c)
     -+	3:BLOB:right/c:$(git rev-parse topic:right/c)
     -+	4:TREE:left/:$(git rev-parse base:left)
     -+	4:TREE:left/:$(git rev-parse base~2:left)
     -+	5:BLOB:left/b:$(git rev-parse base~2:left/b)
     -+	5:BLOB:left/b:$(git rev-parse base:left/b)
     -+	6:BLOB:a:$(git rev-parse base~2:a)
     ++	0:tree::$(git rev-parse topic^{tree})
     ++	0:tree::$(git rev-parse base^{tree})
     ++	0:tree::$(git rev-parse base~1^{tree})
     ++	0:tree::$(git rev-parse base~2^{tree})
     ++	1:tree:right/:$(git rev-parse topic:right)
     ++	1:tree:right/:$(git rev-parse base~1:right)
     ++	1:tree:right/:$(git rev-parse base~2:right)
     ++	2:blob:right/d:$(git rev-parse base~1:right/d)
     ++	3:blob:right/c:$(git rev-parse base~2:right/c)
     ++	3:blob:right/c:$(git rev-parse topic:right/c)
     ++	4:tree:left/:$(git rev-parse base:left)
     ++	4:tree:left/:$(git rev-parse base~2:left)
     ++	5:blob:left/b:$(git rev-parse base~2:left/b)
     ++	5:blob:left/b:$(git rev-parse base:left/b)
     ++	6:blob:a:$(git rev-parse base~2:a)
      +	blobs:6
      +	trees:9
      +	EOF
     @@ t/t6601-path-walk.sh (new)
      +	test-tool path-walk -- topic >out &&
      +
      +	cat >expect <<-EOF &&
     -+	0:TREE::$(git rev-parse topic^{tree})
     -+	0:TREE::$(git rev-parse base~1^{tree})
     -+	0:TREE::$(git rev-parse base~2^{tree})
     -+	1:TREE:right/:$(git rev-parse topic:right)
     -+	1:TREE:right/:$(git rev-parse base~1:right)
     -+	1:TREE:right/:$(git rev-parse base~2:right)
     -+	2:BLOB:right/d:$(git rev-parse base~1:right/d)
     -+	3:BLOB:right/c:$(git rev-parse base~2:right/c)
     -+	3:BLOB:right/c:$(git rev-parse topic:right/c)
     -+	4:TREE:left/:$(git rev-parse base~2:left)
     -+	5:BLOB:left/b:$(git rev-parse base~2:left/b)
     -+	6:BLOB:a:$(git rev-parse base~2:a)
     ++	0:tree::$(git rev-parse topic^{tree})
     ++	0:tree::$(git rev-parse base~1^{tree})
     ++	0:tree::$(git rev-parse base~2^{tree})
     ++	1:tree:right/:$(git rev-parse topic:right)
     ++	1:tree:right/:$(git rev-parse base~1:right)
     ++	1:tree:right/:$(git rev-parse base~2:right)
     ++	2:blob:right/d:$(git rev-parse base~1:right/d)
     ++	3:blob:right/c:$(git rev-parse base~2:right/c)
     ++	3:blob:right/c:$(git rev-parse topic:right/c)
     ++	4:tree:left/:$(git rev-parse base~2:left)
     ++	5:blob:left/b:$(git rev-parse base~2:left/b)
     ++	6:blob:a:$(git rev-parse base~2:a)
      +	blobs:5
      +	trees:7
      +	EOF
     @@ t/t6601-path-walk.sh (new)
      +	test-tool path-walk -- topic --not base >out &&
      +
      +	cat >expect <<-EOF &&
     -+	0:TREE::$(git rev-parse topic^{tree})
     -+	1:TREE:right/:$(git rev-parse topic:right)
     -+	2:BLOB:right/d:$(git rev-parse topic:right/d)
     -+	3:BLOB:right/c:$(git rev-parse topic:right/c)
     -+	4:TREE:left/:$(git rev-parse topic:left)
     -+	5:BLOB:left/b:$(git rev-parse topic:left/b)
     -+	6:BLOB:a:$(git rev-parse topic:a)
     ++	0:tree::$(git rev-parse topic^{tree})
     ++	1:tree:right/:$(git rev-parse topic:right)
     ++	2:blob:right/d:$(git rev-parse topic:right/d)
     ++	3:blob:right/c:$(git rev-parse topic:right/c)
     ++	4:tree:left/:$(git rev-parse topic:left)
     ++	5:blob:left/b:$(git rev-parse topic:left/b)
     ++	6:blob:a:$(git rev-parse topic:a)
      +	blobs:4
      +	trees:3
      +	EOF
     @@ t/t6601-path-walk.sh (new)
      +	test-tool path-walk -- --boundary topic --not base >out &&
      +
      +	cat >expect <<-EOF &&
     -+	0:TREE::$(git rev-parse topic^{tree})
     -+	0:TREE::$(git rev-parse base~1^{tree})
     -+	1:TREE:right/:$(git rev-parse topic:right)
     -+	1:TREE:right/:$(git rev-parse base~1:right)
     -+	2:BLOB:right/d:$(git rev-parse base~1:right/d)
     -+	3:BLOB:right/c:$(git rev-parse base~1:right/c)
     -+	3:BLOB:right/c:$(git rev-parse topic:right/c)
     -+	4:TREE:left/:$(git rev-parse base~1:left)
     -+	5:BLOB:left/b:$(git rev-parse base~1:left/b)
     -+	6:BLOB:a:$(git rev-parse base~1:a)
     ++	0:tree::$(git rev-parse topic^{tree})
     ++	0:tree::$(git rev-parse base~1^{tree})
     ++	1:tree:right/:$(git rev-parse topic:right)
     ++	1:tree:right/:$(git rev-parse base~1:right)
     ++	2:blob:right/d:$(git rev-parse base~1:right/d)
     ++	3:blob:right/c:$(git rev-parse base~1:right/c)
     ++	3:blob:right/c:$(git rev-parse topic:right/c)
     ++	4:tree:left/:$(git rev-parse base~1:left)
     ++	5:blob:left/b:$(git rev-parse base~1:left/b)
     ++	6:blob:a:$(git rev-parse base~1:a)
      +	blobs:5
      +	trees:5
      +	EOF
 4:  83b746f569d ! 4:  42e71e6285f path-walk: allow consumer to specify object types
     @@ t/helper/test-path-walk.c: static const char * const path_walk_usage[] = {
       	uintmax_t blob_nr;
       };
      @@ t/helper/test-path-walk.c: static int emit_block(const char *path, struct oid_array *oids,
     - 	const char *typestr;
     - 
     - 	switch (type) {
     -+	case OBJ_COMMIT:
     -+		typestr = "COMMIT";
     -+		tdata->commit_nr += oids->nr;
     -+		break;
     -+
     - 	case OBJ_TREE:
     - 		typestr = "TREE";
       		tdata->tree_nr += oids->nr;
     + 	else if (type == OBJ_BLOB)
     + 		tdata->blob_nr += oids->nr;
     ++	else if (type == OBJ_COMMIT)
     ++		tdata->commit_nr += oids->nr;
     + 	else
     + 		BUG("we do not understand this type");
     + 
      @@ t/helper/test-path-walk.c: int cmd__path_walk(int argc, const char **argv)
       	struct path_walk_info info = PATH_WALK_INFO_INIT;
       	struct path_walk_test_data data = { 0 };
     @@ t/t6601-path-walk.sh: test_expect_success 'all' '
       	test-tool path-walk -- --all >out &&
       
       	cat >expect <<-EOF &&
     --	0:TREE::$(git rev-parse topic^{tree})
     --	0:TREE::$(git rev-parse base^{tree})
     --	0:TREE::$(git rev-parse base~1^{tree})
     --	0:TREE::$(git rev-parse base~2^{tree})
     --	1:TREE:right/:$(git rev-parse topic:right)
     --	1:TREE:right/:$(git rev-parse base~1:right)
     --	1:TREE:right/:$(git rev-parse base~2:right)
     --	2:BLOB:right/d:$(git rev-parse base~1:right/d)
     --	3:BLOB:right/c:$(git rev-parse base~2:right/c)
     --	3:BLOB:right/c:$(git rev-parse topic:right/c)
     --	4:TREE:left/:$(git rev-parse base:left)
     --	4:TREE:left/:$(git rev-parse base~2:left)
     --	5:BLOB:left/b:$(git rev-parse base~2:left/b)
     --	5:BLOB:left/b:$(git rev-parse base:left/b)
     --	6:BLOB:a:$(git rev-parse base~2:a)
     -+	0:COMMIT::$(git rev-parse topic)
     -+	0:COMMIT::$(git rev-parse base)
     -+	0:COMMIT::$(git rev-parse base~1)
     -+	0:COMMIT::$(git rev-parse base~2)
     -+	1:TREE::$(git rev-parse topic^{tree})
     -+	1:TREE::$(git rev-parse base^{tree})
     -+	1:TREE::$(git rev-parse base~1^{tree})
     -+	1:TREE::$(git rev-parse base~2^{tree})
     -+	2:TREE:right/:$(git rev-parse topic:right)
     -+	2:TREE:right/:$(git rev-parse base~1:right)
     -+	2:TREE:right/:$(git rev-parse base~2:right)
     -+	3:BLOB:right/d:$(git rev-parse base~1:right/d)
     -+	4:BLOB:right/c:$(git rev-parse base~2:right/c)
     -+	4:BLOB:right/c:$(git rev-parse topic:right/c)
     -+	5:TREE:left/:$(git rev-parse base:left)
     -+	5:TREE:left/:$(git rev-parse base~2:left)
     -+	6:BLOB:left/b:$(git rev-parse base~2:left/b)
     -+	6:BLOB:left/b:$(git rev-parse base:left/b)
     -+	7:BLOB:a:$(git rev-parse base~2:a)
     +-	0:tree::$(git rev-parse topic^{tree})
     +-	0:tree::$(git rev-parse base^{tree})
     +-	0:tree::$(git rev-parse base~1^{tree})
     +-	0:tree::$(git rev-parse base~2^{tree})
     +-	1:tree:right/:$(git rev-parse topic:right)
     +-	1:tree:right/:$(git rev-parse base~1:right)
     +-	1:tree:right/:$(git rev-parse base~2:right)
     +-	2:blob:right/d:$(git rev-parse base~1:right/d)
     +-	3:blob:right/c:$(git rev-parse base~2:right/c)
     +-	3:blob:right/c:$(git rev-parse topic:right/c)
     +-	4:tree:left/:$(git rev-parse base:left)
     +-	4:tree:left/:$(git rev-parse base~2:left)
     +-	5:blob:left/b:$(git rev-parse base~2:left/b)
     +-	5:blob:left/b:$(git rev-parse base:left/b)
     +-	6:blob:a:$(git rev-parse base~2:a)
     ++	0:commit::$(git rev-parse topic)
     ++	0:commit::$(git rev-parse base)
     ++	0:commit::$(git rev-parse base~1)
     ++	0:commit::$(git rev-parse base~2)
     ++	1:tree::$(git rev-parse topic^{tree})
     ++	1:tree::$(git rev-parse base^{tree})
     ++	1:tree::$(git rev-parse base~1^{tree})
     ++	1:tree::$(git rev-parse base~2^{tree})
     ++	2:tree:right/:$(git rev-parse topic:right)
     ++	2:tree:right/:$(git rev-parse base~1:right)
     ++	2:tree:right/:$(git rev-parse base~2:right)
     ++	3:blob:right/d:$(git rev-parse base~1:right/d)
     ++	4:blob:right/c:$(git rev-parse base~2:right/c)
     ++	4:blob:right/c:$(git rev-parse topic:right/c)
     ++	5:tree:left/:$(git rev-parse base:left)
     ++	5:tree:left/:$(git rev-parse base~2:left)
     ++	6:blob:left/b:$(git rev-parse base~2:left/b)
     ++	6:blob:left/b:$(git rev-parse base:left/b)
     ++	7:blob:a:$(git rev-parse base~2:a)
       	blobs:6
      +	commits:4
       	trees:9
     @@ t/t6601-path-walk.sh: test_expect_success 'topic only' '
       	test-tool path-walk -- topic >out &&
       
       	cat >expect <<-EOF &&
     --	0:TREE::$(git rev-parse topic^{tree})
     --	0:TREE::$(git rev-parse base~1^{tree})
     --	0:TREE::$(git rev-parse base~2^{tree})
     --	1:TREE:right/:$(git rev-parse topic:right)
     --	1:TREE:right/:$(git rev-parse base~1:right)
     --	1:TREE:right/:$(git rev-parse base~2:right)
     --	2:BLOB:right/d:$(git rev-parse base~1:right/d)
     --	3:BLOB:right/c:$(git rev-parse base~2:right/c)
     --	3:BLOB:right/c:$(git rev-parse topic:right/c)
     --	4:TREE:left/:$(git rev-parse base~2:left)
     --	5:BLOB:left/b:$(git rev-parse base~2:left/b)
     --	6:BLOB:a:$(git rev-parse base~2:a)
     -+	0:COMMIT::$(git rev-parse topic)
     -+	0:COMMIT::$(git rev-parse base~1)
     -+	0:COMMIT::$(git rev-parse base~2)
     -+	1:TREE::$(git rev-parse topic^{tree})
     -+	1:TREE::$(git rev-parse base~1^{tree})
     -+	1:TREE::$(git rev-parse base~2^{tree})
     -+	2:TREE:right/:$(git rev-parse topic:right)
     -+	2:TREE:right/:$(git rev-parse base~1:right)
     -+	2:TREE:right/:$(git rev-parse base~2:right)
     -+	3:BLOB:right/d:$(git rev-parse base~1:right/d)
     -+	4:BLOB:right/c:$(git rev-parse base~2:right/c)
     -+	4:BLOB:right/c:$(git rev-parse topic:right/c)
     -+	5:TREE:left/:$(git rev-parse base~2:left)
     -+	6:BLOB:left/b:$(git rev-parse base~2:left/b)
     -+	7:BLOB:a:$(git rev-parse base~2:a)
     +-	0:tree::$(git rev-parse topic^{tree})
     +-	0:tree::$(git rev-parse base~1^{tree})
     +-	0:tree::$(git rev-parse base~2^{tree})
     +-	1:tree:right/:$(git rev-parse topic:right)
     +-	1:tree:right/:$(git rev-parse base~1:right)
     +-	1:tree:right/:$(git rev-parse base~2:right)
     +-	2:blob:right/d:$(git rev-parse base~1:right/d)
     +-	3:blob:right/c:$(git rev-parse base~2:right/c)
     +-	3:blob:right/c:$(git rev-parse topic:right/c)
     +-	4:tree:left/:$(git rev-parse base~2:left)
     +-	5:blob:left/b:$(git rev-parse base~2:left/b)
     +-	6:blob:a:$(git rev-parse base~2:a)
     ++	0:commit::$(git rev-parse topic)
     ++	0:commit::$(git rev-parse base~1)
     ++	0:commit::$(git rev-parse base~2)
     ++	1:tree::$(git rev-parse topic^{tree})
     ++	1:tree::$(git rev-parse base~1^{tree})
     ++	1:tree::$(git rev-parse base~2^{tree})
     ++	2:tree:right/:$(git rev-parse topic:right)
     ++	2:tree:right/:$(git rev-parse base~1:right)
     ++	2:tree:right/:$(git rev-parse base~2:right)
     ++	3:blob:right/d:$(git rev-parse base~1:right/d)
     ++	4:blob:right/c:$(git rev-parse base~2:right/c)
     ++	4:blob:right/c:$(git rev-parse topic:right/c)
     ++	5:tree:left/:$(git rev-parse base~2:left)
     ++	6:blob:left/b:$(git rev-parse base~2:left/b)
     ++	7:blob:a:$(git rev-parse base~2:a)
       	blobs:5
      +	commits:3
       	trees:7
     @@ t/t6601-path-walk.sh: test_expect_success 'topic, not base' '
       	test-tool path-walk -- topic --not base >out &&
       
       	cat >expect <<-EOF &&
     -+	0:COMMIT::$(git rev-parse topic)
     -+	1:TREE::$(git rev-parse topic^{tree})
     -+	2:TREE:right/:$(git rev-parse topic:right)
     -+	3:BLOB:right/d:$(git rev-parse topic:right/d)
     -+	4:BLOB:right/c:$(git rev-parse topic:right/c)
     -+	5:TREE:left/:$(git rev-parse topic:left)
     -+	6:BLOB:left/b:$(git rev-parse topic:left/b)
     -+	7:BLOB:a:$(git rev-parse topic:a)
     ++	0:commit::$(git rev-parse topic)
     ++	1:tree::$(git rev-parse topic^{tree})
     ++	2:tree:right/:$(git rev-parse topic:right)
     ++	3:blob:right/d:$(git rev-parse topic:right/d)
     ++	4:blob:right/c:$(git rev-parse topic:right/c)
     ++	5:tree:left/:$(git rev-parse topic:left)
     ++	6:blob:left/b:$(git rev-parse topic:left/b)
     ++	7:blob:a:$(git rev-parse topic:a)
      +	blobs:4
      +	commits:1
      +	trees:3
     @@ t/t6601-path-walk.sh: test_expect_success 'topic, not base' '
      +	cat >expect <<-EOF &&
      +	commits:0
      +	trees:0
     -+	0:BLOB:right/d:$(git rev-parse topic:right/d)
     -+	1:BLOB:right/c:$(git rev-parse topic:right/c)
     -+	2:BLOB:left/b:$(git rev-parse topic:left/b)
     -+	3:BLOB:a:$(git rev-parse topic:a)
     ++	0:blob:right/d:$(git rev-parse topic:right/d)
     ++	1:blob:right/c:$(git rev-parse topic:right/c)
     ++	2:blob:left/b:$(git rev-parse topic:left/b)
     ++	3:blob:a:$(git rev-parse topic:a)
      +	blobs:4
      +	EOF
      +
     @@ t/t6601-path-walk.sh: test_expect_success 'topic, not base' '
      +		-- topic --not base >out &&
      +
      +	cat >expect <<-EOF &&
     -+	0:COMMIT::$(git rev-parse topic)
     ++	0:commit::$(git rev-parse topic)
      +	commits:1
      +	trees:0
      +	blobs:0
     @@ t/t6601-path-walk.sh: test_expect_success 'topic, not base' '
      +
      +	cat >expect <<-EOF &&
      +	commits:0
     - 	0:TREE::$(git rev-parse topic^{tree})
     - 	1:TREE:right/:$(git rev-parse topic:right)
     --	2:BLOB:right/d:$(git rev-parse topic:right/d)
     --	3:BLOB:right/c:$(git rev-parse topic:right/c)
     --	4:TREE:left/:$(git rev-parse topic:left)
     --	5:BLOB:left/b:$(git rev-parse topic:left/b)
     --	6:BLOB:a:$(git rev-parse topic:a)
     + 	0:tree::$(git rev-parse topic^{tree})
     + 	1:tree:right/:$(git rev-parse topic:right)
     +-	2:blob:right/d:$(git rev-parse topic:right/d)
     +-	3:blob:right/c:$(git rev-parse topic:right/c)
     +-	4:tree:left/:$(git rev-parse topic:left)
     +-	5:blob:left/b:$(git rev-parse topic:left/b)
     +-	6:blob:a:$(git rev-parse topic:a)
      -	blobs:4
     -+	2:TREE:left/:$(git rev-parse topic:left)
     ++	2:tree:left/:$(git rev-parse topic:left)
       	trees:3
      +	blobs:0
       	EOF
     @@ t/t6601-path-walk.sh: test_expect_success 'topic, not base, boundary' '
       	test-tool path-walk -- --boundary topic --not base >out &&
       
       	cat >expect <<-EOF &&
     --	0:TREE::$(git rev-parse topic^{tree})
     --	0:TREE::$(git rev-parse base~1^{tree})
     --	1:TREE:right/:$(git rev-parse topic:right)
     --	1:TREE:right/:$(git rev-parse base~1:right)
     --	2:BLOB:right/d:$(git rev-parse base~1:right/d)
     --	3:BLOB:right/c:$(git rev-parse base~1:right/c)
     --	3:BLOB:right/c:$(git rev-parse topic:right/c)
     --	4:TREE:left/:$(git rev-parse base~1:left)
     --	5:BLOB:left/b:$(git rev-parse base~1:left/b)
     --	6:BLOB:a:$(git rev-parse base~1:a)
     -+	0:COMMIT::$(git rev-parse topic)
     -+	0:COMMIT::$(git rev-parse base~1)
     -+	1:TREE::$(git rev-parse topic^{tree})
     -+	1:TREE::$(git rev-parse base~1^{tree})
     -+	2:TREE:right/:$(git rev-parse topic:right)
     -+	2:TREE:right/:$(git rev-parse base~1:right)
     -+	3:BLOB:right/d:$(git rev-parse base~1:right/d)
     -+	4:BLOB:right/c:$(git rev-parse base~1:right/c)
     -+	4:BLOB:right/c:$(git rev-parse topic:right/c)
     -+	5:TREE:left/:$(git rev-parse base~1:left)
     -+	6:BLOB:left/b:$(git rev-parse base~1:left/b)
     -+	7:BLOB:a:$(git rev-parse base~1:a)
     +-	0:tree::$(git rev-parse topic^{tree})
     +-	0:tree::$(git rev-parse base~1^{tree})
     +-	1:tree:right/:$(git rev-parse topic:right)
     +-	1:tree:right/:$(git rev-parse base~1:right)
     +-	2:blob:right/d:$(git rev-parse base~1:right/d)
     +-	3:blob:right/c:$(git rev-parse base~1:right/c)
     +-	3:blob:right/c:$(git rev-parse topic:right/c)
     +-	4:tree:left/:$(git rev-parse base~1:left)
     +-	5:blob:left/b:$(git rev-parse base~1:left/b)
     +-	6:blob:a:$(git rev-parse base~1:a)
     ++	0:commit::$(git rev-parse topic)
     ++	0:commit::$(git rev-parse base~1)
     ++	1:tree::$(git rev-parse topic^{tree})
     ++	1:tree::$(git rev-parse base~1^{tree})
     ++	2:tree:right/:$(git rev-parse topic:right)
     ++	2:tree:right/:$(git rev-parse base~1:right)
     ++	3:blob:right/d:$(git rev-parse base~1:right/d)
     ++	4:blob:right/c:$(git rev-parse base~1:right/c)
     ++	4:blob:right/c:$(git rev-parse topic:right/c)
     ++	5:tree:left/:$(git rev-parse base~1:left)
     ++	6:blob:left/b:$(git rev-parse base~1:left/b)
     ++	7:blob:a:$(git rev-parse base~1:a)
       	blobs:5
      +	commits:2
       	trees:5
 5:  97765aa04c2 ! 5:  a41f53f7ced path-walk: visit tags and cached objects
     @@ t/helper/test-path-walk.c: struct path_walk_test_data {
       static int emit_block(const char *path, struct oid_array *oids,
      @@ t/helper/test-path-walk.c: static int emit_block(const char *path, struct oid_array *oids,
       		tdata->blob_nr += oids->nr;
     - 		break;
     - 
     -+	case OBJ_TAG:
     -+		typestr = "TAG";
     + 	else if (type == OBJ_COMMIT)
     + 		tdata->commit_nr += oids->nr;
     ++	else if (type == OBJ_TAG)
      +		tdata->tag_nr += oids->nr;
     -+		break;
     -+
     - 	default:
     + 	else
       		BUG("we do not understand this type");
     - 	}
     + 
     + 	typestr = type_name(type);
       
      +	/* This should never be output during tests. */
      +	if (!oids->nr)
     @@ t/t6601-path-walk.sh: test_description='direct path-walk API tests'
       	test-tool path-walk -- --all >out &&
       
      +	cat >expect <<-EOF &&
     -+	0:COMMIT::$(git rev-parse topic)
     -+	0:COMMIT::$(git rev-parse base)
     -+	0:COMMIT::$(git rev-parse base~1)
     -+	0:COMMIT::$(git rev-parse base~2)
     -+	1:TAG:/tags:$(git rev-parse refs/tags/first)
     -+	1:TAG:/tags:$(git rev-parse refs/tags/second.1)
     -+	1:TAG:/tags:$(git rev-parse refs/tags/second.2)
     -+	1:TAG:/tags:$(git rev-parse refs/tags/third)
     -+	1:TAG:/tags:$(git rev-parse refs/tags/fourth)
     -+	1:TAG:/tags:$(git rev-parse refs/tags/tree-tag)
     -+	1:TAG:/tags:$(git rev-parse refs/tags/blob-tag)
     -+	2:BLOB:/tagged-blobs:$(git rev-parse refs/tags/blob-tag^{})
     -+	2:BLOB:/tagged-blobs:$(git rev-parse refs/tags/blob-tag2^{})
     -+	3:TREE::$(git rev-parse topic^{tree})
     -+	3:TREE::$(git rev-parse base^{tree})
     -+	3:TREE::$(git rev-parse base~1^{tree})
     -+	3:TREE::$(git rev-parse base~2^{tree})
     -+	3:TREE::$(git rev-parse refs/tags/tree-tag^{})
     -+	3:TREE::$(git rev-parse refs/tags/tree-tag2^{})
     -+	4:BLOB:a:$(git rev-parse base~2:a)
     -+	5:TREE:right/:$(git rev-parse topic:right)
     -+	5:TREE:right/:$(git rev-parse base~1:right)
     -+	5:TREE:right/:$(git rev-parse base~2:right)
     -+	6:BLOB:right/d:$(git rev-parse base~1:right/d)
     -+	7:BLOB:right/c:$(git rev-parse base~2:right/c)
     -+	7:BLOB:right/c:$(git rev-parse topic:right/c)
     -+	8:TREE:left/:$(git rev-parse base:left)
     -+	8:TREE:left/:$(git rev-parse base~2:left)
     -+	9:BLOB:left/b:$(git rev-parse base~2:left/b)
     -+	9:BLOB:left/b:$(git rev-parse base:left/b)
     -+	10:TREE:a/:$(git rev-parse base:a)
     -+	11:BLOB:file2:$(git rev-parse refs/tags/tree-tag2^{}:file2)
     -+	12:TREE:child/:$(git rev-parse refs/tags/tree-tag:child)
     -+	13:BLOB:child/file:$(git rev-parse refs/tags/tree-tag:child/file)
     ++	0:commit::$(git rev-parse topic)
     ++	0:commit::$(git rev-parse base)
     ++	0:commit::$(git rev-parse base~1)
     ++	0:commit::$(git rev-parse base~2)
     ++	1:tag:/tags:$(git rev-parse refs/tags/first)
     ++	1:tag:/tags:$(git rev-parse refs/tags/second.1)
     ++	1:tag:/tags:$(git rev-parse refs/tags/second.2)
     ++	1:tag:/tags:$(git rev-parse refs/tags/third)
     ++	1:tag:/tags:$(git rev-parse refs/tags/fourth)
     ++	1:tag:/tags:$(git rev-parse refs/tags/tree-tag)
     ++	1:tag:/tags:$(git rev-parse refs/tags/blob-tag)
     ++	2:blob:/tagged-blobs:$(git rev-parse refs/tags/blob-tag^{})
     ++	2:blob:/tagged-blobs:$(git rev-parse refs/tags/blob-tag2^{})
     ++	3:tree::$(git rev-parse topic^{tree})
     ++	3:tree::$(git rev-parse base^{tree})
     ++	3:tree::$(git rev-parse base~1^{tree})
     ++	3:tree::$(git rev-parse base~2^{tree})
     ++	3:tree::$(git rev-parse refs/tags/tree-tag^{})
     ++	3:tree::$(git rev-parse refs/tags/tree-tag2^{})
     ++	4:blob:a:$(git rev-parse base~2:a)
     ++	5:tree:right/:$(git rev-parse topic:right)
     ++	5:tree:right/:$(git rev-parse base~1:right)
     ++	5:tree:right/:$(git rev-parse base~2:right)
     ++	6:blob:right/d:$(git rev-parse base~1:right/d)
     ++	7:blob:right/c:$(git rev-parse base~2:right/c)
     ++	7:blob:right/c:$(git rev-parse topic:right/c)
     ++	8:tree:left/:$(git rev-parse base:left)
     ++	8:tree:left/:$(git rev-parse base~2:left)
     ++	9:blob:left/b:$(git rev-parse base~2:left/b)
     ++	9:blob:left/b:$(git rev-parse base:left/b)
     ++	10:tree:a/:$(git rev-parse base:a)
     ++	11:blob:file2:$(git rev-parse refs/tags/tree-tag2^{}:file2)
     ++	12:tree:child/:$(git rev-parse refs/tags/tree-tag:child)
     ++	13:blob:child/file:$(git rev-parse refs/tags/tree-tag:child/file)
      +	blobs:10
      +	commits:4
      +	tags:7
     @@ t/t6601-path-walk.sh: test_description='direct path-walk API tests'
      +	test-tool path-walk -- --indexed-objects >out &&
      +
      +	cat >expect <<-EOF &&
     -+	0:BLOB:a:$(git rev-parse HEAD:a)
     -+	1:BLOB:left/b:$(git rev-parse HEAD:left/b)
     -+	2:BLOB:left/c:$(git rev-parse :left/c)
     -+	3:BLOB:right/c:$(git rev-parse HEAD:right/c)
     -+	4:BLOB:right/d:$(git rev-parse HEAD:right/d)
     -+	5:TREE:right/:$(git rev-parse topic:right)
     ++	0:blob:a:$(git rev-parse HEAD:a)
     ++	1:blob:left/b:$(git rev-parse HEAD:left/b)
     ++	2:blob:left/c:$(git rev-parse :left/c)
     ++	3:blob:right/c:$(git rev-parse HEAD:right/c)
     ++	4:blob:right/d:$(git rev-parse HEAD:right/d)
     ++	5:tree:right/:$(git rev-parse topic:right)
      +	blobs:5
      +	commits:0
      +	tags:0
     @@ t/t6601-path-walk.sh: test_description='direct path-walk API tests'
      +	test-tool path-walk -- --indexed-objects --branches >out &&
      +
       	cat >expect <<-EOF &&
     - 	0:COMMIT::$(git rev-parse topic)
     - 	0:COMMIT::$(git rev-parse base)
     + 	0:commit::$(git rev-parse topic)
     + 	0:commit::$(git rev-parse base)
      @@ t/t6601-path-walk.sh: test_expect_success 'all' '
     - 	1:TREE::$(git rev-parse base^{tree})
     - 	1:TREE::$(git rev-parse base~1^{tree})
     - 	1:TREE::$(git rev-parse base~2^{tree})
     --	2:TREE:right/:$(git rev-parse topic:right)
     --	2:TREE:right/:$(git rev-parse base~1:right)
     --	2:TREE:right/:$(git rev-parse base~2:right)
     --	3:BLOB:right/d:$(git rev-parse base~1:right/d)
     --	4:BLOB:right/c:$(git rev-parse base~2:right/c)
     --	4:BLOB:right/c:$(git rev-parse topic:right/c)
     --	5:TREE:left/:$(git rev-parse base:left)
     --	5:TREE:left/:$(git rev-parse base~2:left)
     --	6:BLOB:left/b:$(git rev-parse base~2:left/b)
     --	6:BLOB:left/b:$(git rev-parse base:left/b)
     --	7:BLOB:a:$(git rev-parse base~2:a)
     + 	1:tree::$(git rev-parse base^{tree})
     + 	1:tree::$(git rev-parse base~1^{tree})
     + 	1:tree::$(git rev-parse base~2^{tree})
     +-	2:tree:right/:$(git rev-parse topic:right)
     +-	2:tree:right/:$(git rev-parse base~1:right)
     +-	2:tree:right/:$(git rev-parse base~2:right)
     +-	3:blob:right/d:$(git rev-parse base~1:right/d)
     +-	4:blob:right/c:$(git rev-parse base~2:right/c)
     +-	4:blob:right/c:$(git rev-parse topic:right/c)
     +-	5:tree:left/:$(git rev-parse base:left)
     +-	5:tree:left/:$(git rev-parse base~2:left)
     +-	6:blob:left/b:$(git rev-parse base~2:left/b)
     +-	6:blob:left/b:$(git rev-parse base:left/b)
     +-	7:blob:a:$(git rev-parse base~2:a)
      -	blobs:6
     -+	2:BLOB:a:$(git rev-parse base~2:a)
     -+	3:TREE:right/:$(git rev-parse topic:right)
     -+	3:TREE:right/:$(git rev-parse base~1:right)
     -+	3:TREE:right/:$(git rev-parse base~2:right)
     -+	4:BLOB:right/d:$(git rev-parse base~1:right/d)
     -+	4:BLOB:right/d:$(git rev-parse :right/d)
     -+	5:BLOB:right/c:$(git rev-parse base~2:right/c)
     -+	5:BLOB:right/c:$(git rev-parse topic:right/c)
     -+	6:TREE:left/:$(git rev-parse base:left)
     -+	6:TREE:left/:$(git rev-parse base~2:left)
     -+	7:BLOB:left/b:$(git rev-parse base:left/b)
     -+	7:BLOB:left/b:$(git rev-parse base~2:left/b)
     -+	8:TREE:a/:$(git rev-parse refs/tags/third:a)
     ++	2:blob:a:$(git rev-parse base~2:a)
     ++	3:tree:right/:$(git rev-parse topic:right)
     ++	3:tree:right/:$(git rev-parse base~1:right)
     ++	3:tree:right/:$(git rev-parse base~2:right)
     ++	4:blob:right/d:$(git rev-parse base~1:right/d)
     ++	4:blob:right/d:$(git rev-parse :right/d)
     ++	5:blob:right/c:$(git rev-parse base~2:right/c)
     ++	5:blob:right/c:$(git rev-parse topic:right/c)
     ++	6:tree:left/:$(git rev-parse base:left)
     ++	6:tree:left/:$(git rev-parse base~2:left)
     ++	7:blob:left/b:$(git rev-parse base:left/b)
     ++	7:blob:left/b:$(git rev-parse base~2:left/b)
     ++	8:tree:a/:$(git rev-parse refs/tags/third:a)
      +	blobs:7
       	commits:4
      -	trees:9
     @@ t/t6601-path-walk.sh: test_expect_success 'all' '
       
       	test_cmp_sorted expect out
      @@ t/t6601-path-walk.sh: test_expect_success 'topic only' '
     - 	7:BLOB:a:$(git rev-parse base~2:a)
     + 	7:blob:a:$(git rev-parse base~2:a)
       	blobs:5
       	commits:3
      +	tags:0
     @@ t/t6601-path-walk.sh: test_expect_success 'topic only' '
       	EOF
       
      @@ t/t6601-path-walk.sh: test_expect_success 'topic, not base' '
     - 	7:BLOB:a:$(git rev-parse topic:a)
     + 	7:blob:a:$(git rev-parse topic:a)
       	blobs:4
       	commits:1
      +	tags:0
     @@ t/t6601-path-walk.sh: test_expect_success 'topic, not base, only blobs' '
       	cat >expect <<-EOF &&
      -	commits:0
      -	trees:0
     - 	0:BLOB:right/d:$(git rev-parse topic:right/d)
     - 	1:BLOB:right/c:$(git rev-parse topic:right/c)
     - 	2:BLOB:left/b:$(git rev-parse topic:left/b)
     - 	3:BLOB:a:$(git rev-parse topic:a)
     + 	0:blob:right/d:$(git rev-parse topic:right/d)
     + 	1:blob:right/c:$(git rev-parse topic:right/c)
     + 	2:blob:left/b:$(git rev-parse topic:left/b)
     + 	3:blob:a:$(git rev-parse topic:a)
       	blobs:4
      +	commits:0
      +	tags:0
     @@ t/t6601-path-walk.sh: test_expect_success 'topic, not base, only blobs' '
       	test_cmp_sorted expect out
      @@ t/t6601-path-walk.sh: test_expect_success 'topic, not base, only commits' '
       	cat >expect <<-EOF &&
     - 	0:COMMIT::$(git rev-parse topic)
     + 	0:commit::$(git rev-parse topic)
       	commits:1
      -	trees:0
       	blobs:0
     @@ t/t6601-path-walk.sh: test_expect_success 'topic, not base, only trees' '
       
       	cat >expect <<-EOF &&
      -	commits:0
     - 	0:TREE::$(git rev-parse topic^{tree})
     - 	1:TREE:right/:$(git rev-parse topic:right)
     - 	2:TREE:left/:$(git rev-parse topic:left)
     + 	0:tree::$(git rev-parse topic^{tree})
     + 	1:tree:right/:$(git rev-parse topic:right)
     + 	2:tree:left/:$(git rev-parse topic:left)
      -	trees:3
      +	commits:0
       	blobs:0
     @@ t/t6601-path-walk.sh: test_expect_success 'topic, not base, only trees' '
       
       	test_cmp_sorted expect out
      @@ t/t6601-path-walk.sh: test_expect_success 'topic, not base, boundary' '
     - 	7:BLOB:a:$(git rev-parse base~1:a)
     + 	7:blob:a:$(git rev-parse base~1:a)
       	blobs:5
       	commits:2
      +	tags:0
 6:  a4aaa3b001b ! 6:  0f1e6c51b2c path-walk: mark trees and blobs as UNINTERESTING
     @@ t/helper/test-path-walk.c: int cmd__path_walk(int argc, const char **argv)
      
       ## t/t6601-path-walk.sh ##
      @@ t/t6601-path-walk.sh: test_expect_success 'topic, not base' '
     - 	0:COMMIT::$(git rev-parse topic)
     - 	1:TREE::$(git rev-parse topic^{tree})
     - 	2:TREE:right/:$(git rev-parse topic:right)
     --	3:BLOB:right/d:$(git rev-parse topic:right/d)
     -+	3:BLOB:right/d:$(git rev-parse topic:right/d):UNINTERESTING
     - 	4:BLOB:right/c:$(git rev-parse topic:right/c)
     --	5:TREE:left/:$(git rev-parse topic:left)
     --	6:BLOB:left/b:$(git rev-parse topic:left/b)
     --	7:BLOB:a:$(git rev-parse topic:a)
     -+	5:TREE:left/:$(git rev-parse topic:left):UNINTERESTING
     -+	6:BLOB:left/b:$(git rev-parse topic:left/b):UNINTERESTING
     -+	7:BLOB:a:$(git rev-parse topic:a):UNINTERESTING
     + 	0:commit::$(git rev-parse topic)
     + 	1:tree::$(git rev-parse topic^{tree})
     + 	2:tree:right/:$(git rev-parse topic:right)
     +-	3:blob:right/d:$(git rev-parse topic:right/d)
     ++	3:blob:right/d:$(git rev-parse topic:right/d):UNINTERESTING
     + 	4:blob:right/c:$(git rev-parse topic:right/c)
     +-	5:tree:left/:$(git rev-parse topic:left)
     +-	6:blob:left/b:$(git rev-parse topic:left/b)
     +-	7:blob:a:$(git rev-parse topic:a)
     ++	5:tree:left/:$(git rev-parse topic:left):UNINTERESTING
     ++	6:blob:left/b:$(git rev-parse topic:left/b):UNINTERESTING
     ++	7:blob:a:$(git rev-parse topic:a):UNINTERESTING
       	blobs:4
       	commits:1
       	tags:0
     @@ t/t6601-path-walk.sh: test_expect_success 'topic, not base' '
      +	test-tool path-walk -- fourth blob-tag2 --not base >out &&
      +
      +	cat >expect <<-EOF &&
     -+	0:COMMIT::$(git rev-parse topic)
     -+	1:TAG:/tags:$(git rev-parse fourth)
     -+	2:BLOB:/tagged-blobs:$(git rev-parse refs/tags/blob-tag2^{})
     -+	3:TREE::$(git rev-parse topic^{tree})
     -+	4:TREE:right/:$(git rev-parse topic:right)
     -+	5:BLOB:right/d:$(git rev-parse base~1:right/d):UNINTERESTING
     -+	6:BLOB:right/c:$(git rev-parse topic:right/c)
     -+	7:TREE:left/:$(git rev-parse base~1:left):UNINTERESTING
     -+	8:BLOB:left/b:$(git rev-parse base~1:left/b):UNINTERESTING
     -+	9:BLOB:a:$(git rev-parse base~1:a):UNINTERESTING
     ++	0:commit::$(git rev-parse topic)
     ++	1:tag:/tags:$(git rev-parse fourth)
     ++	2:blob:/tagged-blobs:$(git rev-parse refs/tags/blob-tag2^{})
     ++	3:tree::$(git rev-parse topic^{tree})
     ++	4:tree:right/:$(git rev-parse topic:right)
     ++	5:blob:right/d:$(git rev-parse base~1:right/d):UNINTERESTING
     ++	6:blob:right/c:$(git rev-parse topic:right/c)
     ++	7:tree:left/:$(git rev-parse base~1:left):UNINTERESTING
     ++	8:blob:left/b:$(git rev-parse base~1:left/b):UNINTERESTING
     ++	9:blob:a:$(git rev-parse base~1:a):UNINTERESTING
      +	blobs:5
      +	commits:1
      +	tags:1
     @@ t/t6601-path-walk.sh: test_expect_success 'topic, not base' '
       		-- topic --not base >out &&
       
       	cat >expect <<-EOF &&
     --	0:BLOB:right/d:$(git rev-parse topic:right/d)
     -+	0:BLOB:right/d:$(git rev-parse topic:right/d):UNINTERESTING
     - 	1:BLOB:right/c:$(git rev-parse topic:right/c)
     --	2:BLOB:left/b:$(git rev-parse topic:left/b)
     --	3:BLOB:a:$(git rev-parse topic:a)
     -+	2:BLOB:left/b:$(git rev-parse topic:left/b):UNINTERESTING
     -+	3:BLOB:a:$(git rev-parse topic:a):UNINTERESTING
     +-	0:blob:right/d:$(git rev-parse topic:right/d)
     ++	0:blob:right/d:$(git rev-parse topic:right/d):UNINTERESTING
     + 	1:blob:right/c:$(git rev-parse topic:right/c)
     +-	2:blob:left/b:$(git rev-parse topic:left/b)
     +-	3:blob:a:$(git rev-parse topic:a)
     ++	2:blob:left/b:$(git rev-parse topic:left/b):UNINTERESTING
     ++	3:blob:a:$(git rev-parse topic:a):UNINTERESTING
       	blobs:4
       	commits:0
       	tags:0
      @@ t/t6601-path-walk.sh: test_expect_success 'topic, not base, only trees' '
       	cat >expect <<-EOF &&
     - 	0:TREE::$(git rev-parse topic^{tree})
     - 	1:TREE:right/:$(git rev-parse topic:right)
     --	2:TREE:left/:$(git rev-parse topic:left)
     -+	2:TREE:left/:$(git rev-parse topic:left):UNINTERESTING
     + 	0:tree::$(git rev-parse topic^{tree})
     + 	1:tree:right/:$(git rev-parse topic:right)
     +-	2:tree:left/:$(git rev-parse topic:left)
     ++	2:tree:left/:$(git rev-parse topic:left):UNINTERESTING
       	commits:0
       	blobs:0
       	tags:0
      @@ t/t6601-path-walk.sh: test_expect_success 'topic, not base, boundary' '
       
       	cat >expect <<-EOF &&
     - 	0:COMMIT::$(git rev-parse topic)
     --	0:COMMIT::$(git rev-parse base~1)
     -+	0:COMMIT::$(git rev-parse base~1):UNINTERESTING
     - 	1:TREE::$(git rev-parse topic^{tree})
     --	1:TREE::$(git rev-parse base~1^{tree})
     -+	1:TREE::$(git rev-parse base~1^{tree}):UNINTERESTING
     - 	2:TREE:right/:$(git rev-parse topic:right)
     --	2:TREE:right/:$(git rev-parse base~1:right)
     --	3:BLOB:right/d:$(git rev-parse base~1:right/d)
     --	4:BLOB:right/c:$(git rev-parse base~1:right/c)
     -+	2:TREE:right/:$(git rev-parse base~1:right):UNINTERESTING
     -+	3:BLOB:right/d:$(git rev-parse base~1:right/d):UNINTERESTING
     -+	4:BLOB:right/c:$(git rev-parse base~1:right/c):UNINTERESTING
     - 	4:BLOB:right/c:$(git rev-parse topic:right/c)
     --	5:TREE:left/:$(git rev-parse base~1:left)
     --	6:BLOB:left/b:$(git rev-parse base~1:left/b)
     --	7:BLOB:a:$(git rev-parse base~1:a)
     -+	5:TREE:left/:$(git rev-parse base~1:left):UNINTERESTING
     -+	6:BLOB:left/b:$(git rev-parse base~1:left/b):UNINTERESTING
     -+	7:BLOB:a:$(git rev-parse base~1:a):UNINTERESTING
     + 	0:commit::$(git rev-parse topic)
     +-	0:commit::$(git rev-parse base~1)
     ++	0:commit::$(git rev-parse base~1):UNINTERESTING
     + 	1:tree::$(git rev-parse topic^{tree})
     +-	1:tree::$(git rev-parse base~1^{tree})
     ++	1:tree::$(git rev-parse base~1^{tree}):UNINTERESTING
     + 	2:tree:right/:$(git rev-parse topic:right)
     +-	2:tree:right/:$(git rev-parse base~1:right)
     +-	3:blob:right/d:$(git rev-parse base~1:right/d)
     +-	4:blob:right/c:$(git rev-parse base~1:right/c)
     ++	2:tree:right/:$(git rev-parse base~1:right):UNINTERESTING
     ++	3:blob:right/d:$(git rev-parse base~1:right/d):UNINTERESTING
     ++	4:blob:right/c:$(git rev-parse base~1:right/c):UNINTERESTING
     + 	4:blob:right/c:$(git rev-parse topic:right/c)
     +-	5:tree:left/:$(git rev-parse base~1:left)
     +-	6:blob:left/b:$(git rev-parse base~1:left/b)
     +-	7:blob:a:$(git rev-parse base~1:a)
     ++	5:tree:left/:$(git rev-parse base~1:left):UNINTERESTING
     ++	6:blob:left/b:$(git rev-parse base~1:left/b):UNINTERESTING
     ++	7:blob:a:$(git rev-parse base~1:a):UNINTERESTING
       	blobs:5
       	commits:2
       	tags:0
     @@ t/t6601-path-walk.sh: test_expect_success 'topic, not base, boundary' '
      +	test-tool path-walk --prune -- --boundary topic --not base >out &&
      +
      +	cat >expect <<-EOF &&
     -+	0:COMMIT::$(git rev-parse topic)
     -+	0:COMMIT::$(git rev-parse base~1):UNINTERESTING
     -+	1:TREE::$(git rev-parse topic^{tree})
     -+	1:TREE::$(git rev-parse base~1^{tree}):UNINTERESTING
     -+	2:TREE:right/:$(git rev-parse topic:right)
     -+	2:TREE:right/:$(git rev-parse base~1:right):UNINTERESTING
     -+	3:BLOB:right/c:$(git rev-parse base~1:right/c):UNINTERESTING
     -+	3:BLOB:right/c:$(git rev-parse topic:right/c)
     ++	0:commit::$(git rev-parse topic)
     ++	0:commit::$(git rev-parse base~1):UNINTERESTING
     ++	1:tree::$(git rev-parse topic^{tree})
     ++	1:tree::$(git rev-parse base~1^{tree}):UNINTERESTING
     ++	2:tree:right/:$(git rev-parse topic:right)
     ++	2:tree:right/:$(git rev-parse base~1:right):UNINTERESTING
     ++	3:blob:right/c:$(git rev-parse base~1:right/c):UNINTERESTING
     ++	3:blob:right/c:$(git rev-parse topic:right/c)
      +	blobs:2
      +	commits:2
      +	tags:0
 -:  ----------- > 7:  e716672c041 path-walk: reorder object visits

-- 
gitgitgadget
