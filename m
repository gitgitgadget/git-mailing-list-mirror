Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2D2A1537C9
	for <git@vger.kernel.org>; Sat,  9 Nov 2024 19:41:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731181281; cv=none; b=EAGO06DxJ15SId+BMwyLgvRo3qtls2GQ+RIScZdMxkjPcDkx6NJwF/bkw/7P0gV56ZsFNat8/H0mIRXQcw+oRL55Ng662zJdmRRFhD35aU/gxPSyM2zkgpCxBaSeE2tC2VROKTgjrMG6IejAaGFJtATebOL1JBrPvIVyqDLpsqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731181281; c=relaxed/simple;
	bh=A+OoHMKVlW3GEm2YNVcxOUWS0ODw1oEohbSmHB4eRyQ=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=U6sHQZlIq61Cr2ZC5GbJxgCnu8jfG2WOB4RABa+SUhfoBYc+7TyBOvGnTmgGRzqdh/IaSBkdfURjqOJ86ClO0ZUqRjO0j4t3KN7eWq4g7SbFy9skEsBSkSm9vU2o20r1wo6O7zqD7X6nkzCDwZSrSJQT9EDw5dVa9C6jb9Eka8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FniLz8I9; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FniLz8I9"
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-37d4b0943c7so1975429f8f.1
        for <git@vger.kernel.org>; Sat, 09 Nov 2024 11:41:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731181276; x=1731786076; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=a5LLOJJYKZ0cgzjbwY4IPCdNR4NSmbxuSgok1d4KQn0=;
        b=FniLz8I9w/KZgtsT37l6yMXd0VzB04EmmApDj2KRCRCbqAOKrlnaDHEOskrOE9xq9m
         Q+3hOeLxEPI5UR7GyO4i8ZcNYA9yJ4I2qRQWcM/j+G+IhK3C5BGUdzAzvzo0Xs4nBC9F
         BP+X2Vlnntdwxh6Iyvev8nQoWOpplQVvm7EVMezgq89zCKtKwXJxfRjh+XEW2ytyt7OK
         KR+UGwijGTXPKrsM1+P1hdpgeNA8eXFAhAcOJFGhx/b41FvVZa1wWmKzuux9aVE+4yUx
         J99vQnXC9tvjyh7ckuTpVBjlcz4gFRn7nhKZGaU1mjKeklOD2nXS0AgNYZdNW78RFbUd
         gLmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731181276; x=1731786076;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=a5LLOJJYKZ0cgzjbwY4IPCdNR4NSmbxuSgok1d4KQn0=;
        b=V2S8OM9OunKmMoL7gmFpMOU0eC0P4GoG52ttS+qLMQiCWYPwLdaCoH5sVxEajs54wO
         cy4Lk9+mV8Pyyo0U82gX4eb4czZy5ZnnaZIVOg1ceo0hYSMSQU5LC6/kIgaDu+roMOLk
         yAzpMBR3iJlDegNy3ge4KozddvGmivNHTFM2qo1U9zK4y9gWF/ni8aAfIKdCYLqfxvjV
         O9DaRWfeMa3JwwsvvJT76RH6Q+q+hjF42wF0y9aIzxcURf0eOCZb3lzXfuJ3KqMTflwX
         ApMuyyucU5KXRrkiUdo/QSXqjUKbplNXT2vVvU+AQ/Vd4YEYdHUnJslsMrI3hi1jHhZU
         8MQw==
X-Gm-Message-State: AOJu0YwFqeyBbMFZsDTw17Q5ZfbUgCYE6ijh0kr5ZD4SLDZPu9sdThRx
	KteDgkZSNtuBEg3KXGCc7w9W9jqwfqGd+FrqLhbmo+XfvS4kuL/34X42ow==
X-Google-Smtp-Source: AGHT+IH+zwS44jOZB/Wol30zxqZXSUQ7k0Q7pPmeEelE/zkYCACXjPiyIcjxopi1paEzBk34syb6bQ==
X-Received: by 2002:a5d:598c:0:b0:378:fe6e:50ef with SMTP id ffacd0b85a97d-381f1867151mr6411136f8f.5.1731181275022;
        Sat, 09 Nov 2024 11:41:15 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-432b05c1c81sm118667405e9.32.2024.11.09.11.41.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 09 Nov 2024 11:41:14 -0800 (PST)
Message-Id: <pull.1818.v2.git.1731181272.gitgitgadget@gmail.com>
In-Reply-To: <pull.1818.git.1730356023.gitgitgadget@gmail.com>
References: <pull.1818.git.1730356023.gitgitgadget@gmail.com>
From: "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sat, 09 Nov 2024 19:41:06 +0000
Subject: [PATCH v2 0/6] PATH WALK I: The path-walk API
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

Thanks, -Stolee

Derrick Stolee (6):
  path-walk: introduce an object walk by path
  test-lib-functions: add test_cmp_sorted
  t6601: add helper for testing path-walk API
  path-walk: allow consumer to specify object types
  path-walk: visit tags and cached objects
  path-walk: mark trees and blobs as UNINTERESTING

 Documentation/technical/api-path-walk.txt |  63 +++
 Makefile                                  |   2 +
 path-walk.c                               | 531 ++++++++++++++++++++++
 path-walk.h                               |  65 +++
 t/helper/test-path-walk.c                 | 124 +++++
 t/helper/test-tool.c                      |   1 +
 t/helper/test-tool.h                      |   1 +
 t/t6601-path-walk.sh                      | 368 +++++++++++++++
 t/test-lib-functions.sh                   |  10 +
 9 files changed, 1165 insertions(+)
 create mode 100644 Documentation/technical/api-path-walk.txt
 create mode 100644 path-walk.c
 create mode 100644 path-walk.h
 create mode 100644 t/helper/test-path-walk.c
 create mode 100755 t/t6601-path-walk.sh


base-commit: e9356ba3ea2a6754281ff7697b3e5a1697b21e24
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1818%2Fderrickstolee%2Fapi-upstream-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1818/derrickstolee/api-upstream-v2
Pull-Request: https://github.com/gitgitgadget/git/pull/1818

Range-diff vs v1:

 1:  c71f0a0e361 ! 1:  b7e9b81e8b3 path-walk: introduce an object walk by path
     @@ path-walk.c (new)
      +
      +	list = strmap_get(&ctx->paths_to_lists, path);
      +
     ++	if (!list->oids.nr)
     ++		return 0;
     ++
      +	/* Evaluate function pointer on this data. */
      +	ret = ctx->info->path_fn(path, &list->oids, list->type,
      +				 ctx->info->path_fn_data);
 2:  4f9f898fec1 = 2:  cf2ed61b324 test-lib-functions: add test_cmp_sorted
 3:  6f93dff88e7 ! 3:  a3c754d93cc t6601: add helper for testing path-walk API
     @@ Commit message
          sets a baseline for the behavior and we can extend it as new options are
          introduced.
      
     +    Store and output a 'batch_nr' value so we can demonstrate that the paths are
     +    grouped together in a batch and not following some other ordering. This
     +    allows us to test the depth-first behavior of the path-walk API. However, we
     +    purposefully do not test the order of the objects in the batch, so the
     +    output is compared to the expected output through a sort.
     +
          It is important to mention that the behavior of the API will change soon as
          we start to handle UNINTERESTING objects differently, but these tests will
          demonstrate the change in behavior.
     @@ t/helper/test-path-walk.c (new)
      +};
      +
      +struct path_walk_test_data {
     ++	uintmax_t batch_nr;
      +	uintmax_t tree_nr;
      +	uintmax_t blob_nr;
      +};
     @@ t/helper/test-path-walk.c (new)
      +	}
      +
      +	for (size_t i = 0; i < oids->nr; i++)
     -+		printf("%s:%s:%s\n", typestr, path, oid_to_hex(&oids->oid[i]));
     ++		printf("%"PRIuMAX":%s:%s:%s\n",
     ++		       tdata->batch_nr, typestr, path,
     ++		       oid_to_hex(&oids->oid[i]));
      +
     ++	tdata->batch_nr++;
      +	return 0;
      +}
      +
     @@ t/helper/test-path-walk.c (new)
      +		OPT_END(),
      +	};
      +
     -+	initialize_repository(the_repository);
      +	setup_git_directory();
      +	revs.repo = the_repository;
      +
     @@ t/helper/test-path-walk.c (new)
      +	       "blobs:%" PRIuMAX "\n",
      +	       data.tree_nr, data.blob_nr);
      +
     ++	release_revisions(&revs);
      +	return res;
      +}
      
     @@ t/t6601-path-walk.sh (new)
      @@
      +#!/bin/sh
      +
     ++TEST_PASSES_SANITIZE_LEAK=true
     ++
      +test_description='direct path-walk API tests'
      +
      +. ./test-lib.sh
     @@ t/t6601-path-walk.sh (new)
      +	test-tool path-walk -- --all >out &&
      +
      +	cat >expect <<-EOF &&
     -+	TREE::$(git rev-parse topic^{tree})
     -+	TREE::$(git rev-parse base^{tree})
     -+	TREE::$(git rev-parse base~1^{tree})
     -+	TREE::$(git rev-parse base~2^{tree})
     -+	TREE:left/:$(git rev-parse base:left)
     -+	TREE:left/:$(git rev-parse base~2:left)
     -+	TREE:right/:$(git rev-parse topic:right)
     -+	TREE:right/:$(git rev-parse base~1:right)
     -+	TREE:right/:$(git rev-parse base~2:right)
     -+	trees:9
     -+	BLOB:a:$(git rev-parse base~2:a)
     -+	BLOB:left/b:$(git rev-parse base~2:left/b)
     -+	BLOB:left/b:$(git rev-parse base:left/b)
     -+	BLOB:right/c:$(git rev-parse base~2:right/c)
     -+	BLOB:right/c:$(git rev-parse topic:right/c)
     -+	BLOB:right/d:$(git rev-parse base~1:right/d)
     ++	0:TREE::$(git rev-parse topic^{tree})
     ++	0:TREE::$(git rev-parse base^{tree})
     ++	0:TREE::$(git rev-parse base~1^{tree})
     ++	0:TREE::$(git rev-parse base~2^{tree})
     ++	1:TREE:right/:$(git rev-parse topic:right)
     ++	1:TREE:right/:$(git rev-parse base~1:right)
     ++	1:TREE:right/:$(git rev-parse base~2:right)
     ++	2:BLOB:right/d:$(git rev-parse base~1:right/d)
     ++	3:BLOB:right/c:$(git rev-parse base~2:right/c)
     ++	3:BLOB:right/c:$(git rev-parse topic:right/c)
     ++	4:TREE:left/:$(git rev-parse base:left)
     ++	4:TREE:left/:$(git rev-parse base~2:left)
     ++	5:BLOB:left/b:$(git rev-parse base~2:left/b)
     ++	5:BLOB:left/b:$(git rev-parse base:left/b)
     ++	6:BLOB:a:$(git rev-parse base~2:a)
      +	blobs:6
     ++	trees:9
      +	EOF
      +
      +	test_cmp_sorted expect out
     @@ t/t6601-path-walk.sh (new)
      +	test-tool path-walk -- topic >out &&
      +
      +	cat >expect <<-EOF &&
     -+	TREE::$(git rev-parse topic^{tree})
     -+	TREE::$(git rev-parse base~1^{tree})
     -+	TREE::$(git rev-parse base~2^{tree})
     -+	TREE:left/:$(git rev-parse base~2:left)
     -+	TREE:right/:$(git rev-parse topic:right)
     -+	TREE:right/:$(git rev-parse base~1:right)
     -+	TREE:right/:$(git rev-parse base~2:right)
     -+	trees:7
     -+	BLOB:a:$(git rev-parse base~2:a)
     -+	BLOB:left/b:$(git rev-parse base~2:left/b)
     -+	BLOB:right/c:$(git rev-parse base~2:right/c)
     -+	BLOB:right/c:$(git rev-parse topic:right/c)
     -+	BLOB:right/d:$(git rev-parse base~1:right/d)
     ++	0:TREE::$(git rev-parse topic^{tree})
     ++	0:TREE::$(git rev-parse base~1^{tree})
     ++	0:TREE::$(git rev-parse base~2^{tree})
     ++	1:TREE:right/:$(git rev-parse topic:right)
     ++	1:TREE:right/:$(git rev-parse base~1:right)
     ++	1:TREE:right/:$(git rev-parse base~2:right)
     ++	2:BLOB:right/d:$(git rev-parse base~1:right/d)
     ++	3:BLOB:right/c:$(git rev-parse base~2:right/c)
     ++	3:BLOB:right/c:$(git rev-parse topic:right/c)
     ++	4:TREE:left/:$(git rev-parse base~2:left)
     ++	5:BLOB:left/b:$(git rev-parse base~2:left/b)
     ++	6:BLOB:a:$(git rev-parse base~2:a)
      +	blobs:5
     ++	trees:7
      +	EOF
      +
      +	test_cmp_sorted expect out
     @@ t/t6601-path-walk.sh (new)
      +	test-tool path-walk -- topic --not base >out &&
      +
      +	cat >expect <<-EOF &&
     -+	TREE::$(git rev-parse topic^{tree})
     -+	TREE:left/:$(git rev-parse topic:left)
     -+	TREE:right/:$(git rev-parse topic:right)
     -+	trees:3
     -+	BLOB:a:$(git rev-parse topic:a)
     -+	BLOB:left/b:$(git rev-parse topic:left/b)
     -+	BLOB:right/c:$(git rev-parse topic:right/c)
     -+	BLOB:right/d:$(git rev-parse topic:right/d)
     ++	0:TREE::$(git rev-parse topic^{tree})
     ++	1:TREE:right/:$(git rev-parse topic:right)
     ++	2:BLOB:right/d:$(git rev-parse topic:right/d)
     ++	3:BLOB:right/c:$(git rev-parse topic:right/c)
     ++	4:TREE:left/:$(git rev-parse topic:left)
     ++	5:BLOB:left/b:$(git rev-parse topic:left/b)
     ++	6:BLOB:a:$(git rev-parse topic:a)
      +	blobs:4
     ++	trees:3
      +	EOF
      +
      +	test_cmp_sorted expect out
     @@ t/t6601-path-walk.sh (new)
      +	test-tool path-walk -- --boundary topic --not base >out &&
      +
      +	cat >expect <<-EOF &&
     -+	TREE::$(git rev-parse topic^{tree})
     -+	TREE::$(git rev-parse base~1^{tree})
     -+	TREE:left/:$(git rev-parse base~1:left)
     -+	TREE:right/:$(git rev-parse topic:right)
     -+	TREE:right/:$(git rev-parse base~1:right)
     -+	trees:5
     -+	BLOB:a:$(git rev-parse base~1:a)
     -+	BLOB:left/b:$(git rev-parse base~1:left/b)
     -+	BLOB:right/c:$(git rev-parse base~1:right/c)
     -+	BLOB:right/c:$(git rev-parse topic:right/c)
     -+	BLOB:right/d:$(git rev-parse base~1:right/d)
     ++	0:TREE::$(git rev-parse topic^{tree})
     ++	0:TREE::$(git rev-parse base~1^{tree})
     ++	1:TREE:right/:$(git rev-parse topic:right)
     ++	1:TREE:right/:$(git rev-parse base~1:right)
     ++	2:BLOB:right/d:$(git rev-parse base~1:right/d)
     ++	3:BLOB:right/c:$(git rev-parse base~1:right/c)
     ++	3:BLOB:right/c:$(git rev-parse topic:right/c)
     ++	4:TREE:left/:$(git rev-parse base~1:left)
     ++	5:BLOB:left/b:$(git rev-parse base~1:left/b)
     ++	6:BLOB:a:$(git rev-parse base~1:a)
      +	blobs:5
     ++	trees:5
      +	EOF
      +
      +	test_cmp_sorted expect out
 4:  f4bf8be30b5 ! 4:  83b746f569d path-walk: allow consumer to specify object types
     @@ path-walk.c: static int add_children(struct path_walk_context *ctx,
       			struct tree *child = lookup_tree(ctx->repo, &entry.oid);
       			o = child ? &child->object : NULL;
      @@ path-walk.c: static int walk_path(struct path_walk_context *ctx,
     - 
     - 	list = strmap_get(&ctx->paths_to_lists, path);
     + 	if (!list->oids.nr)
     + 		return 0;
       
      -	/* Evaluate function pointer on this data. */
      -	ret = ctx->info->path_fn(path, &list->oids, list->type,
     @@ path-walk.c: int walk_objects_by_path(struct path_walk_info *info)
       	trace2_region_leave("path-walk", "commit-walk", info->revs->repo);
       
      +	/* Track all commits. */
     -+	if (info->commits)
     ++	if (info->commits && commit_list->oids.nr)
      +		ret = info->path_fn("", &commit_list->oids, OBJ_COMMIT,
      +				    info->path_fn_data);
      +	oid_array_clear(&commit_list->oids);
     @@ path-walk.h: struct path_walk_info {
      
       ## t/helper/test-path-walk.c ##
      @@ t/helper/test-path-walk.c: static const char * const path_walk_usage[] = {
     - };
       
       struct path_walk_test_data {
     + 	uintmax_t batch_nr;
     ++
      +	uintmax_t commit_nr;
       	uintmax_t tree_nr;
       	uintmax_t blob_nr;
     @@ t/helper/test-path-walk.c: int cmd__path_walk(int argc, const char **argv)
      -	       data.tree_nr, data.blob_nr);
      +	       data.commit_nr, data.tree_nr, data.blob_nr);
       
     + 	release_revisions(&revs);
       	return res;
     - }
      
       ## t/t6601-path-walk.sh ##
      @@ t/t6601-path-walk.sh: test_expect_success 'all' '
       	test-tool path-walk -- --all >out &&
       
       	cat >expect <<-EOF &&
     -+	COMMIT::$(git rev-parse topic)
     -+	COMMIT::$(git rev-parse base)
     -+	COMMIT::$(git rev-parse base~1)
     -+	COMMIT::$(git rev-parse base~2)
     +-	0:TREE::$(git rev-parse topic^{tree})
     +-	0:TREE::$(git rev-parse base^{tree})
     +-	0:TREE::$(git rev-parse base~1^{tree})
     +-	0:TREE::$(git rev-parse base~2^{tree})
     +-	1:TREE:right/:$(git rev-parse topic:right)
     +-	1:TREE:right/:$(git rev-parse base~1:right)
     +-	1:TREE:right/:$(git rev-parse base~2:right)
     +-	2:BLOB:right/d:$(git rev-parse base~1:right/d)
     +-	3:BLOB:right/c:$(git rev-parse base~2:right/c)
     +-	3:BLOB:right/c:$(git rev-parse topic:right/c)
     +-	4:TREE:left/:$(git rev-parse base:left)
     +-	4:TREE:left/:$(git rev-parse base~2:left)
     +-	5:BLOB:left/b:$(git rev-parse base~2:left/b)
     +-	5:BLOB:left/b:$(git rev-parse base:left/b)
     +-	6:BLOB:a:$(git rev-parse base~2:a)
     ++	0:COMMIT::$(git rev-parse topic)
     ++	0:COMMIT::$(git rev-parse base)
     ++	0:COMMIT::$(git rev-parse base~1)
     ++	0:COMMIT::$(git rev-parse base~2)
     ++	1:TREE::$(git rev-parse topic^{tree})
     ++	1:TREE::$(git rev-parse base^{tree})
     ++	1:TREE::$(git rev-parse base~1^{tree})
     ++	1:TREE::$(git rev-parse base~2^{tree})
     ++	2:TREE:right/:$(git rev-parse topic:right)
     ++	2:TREE:right/:$(git rev-parse base~1:right)
     ++	2:TREE:right/:$(git rev-parse base~2:right)
     ++	3:BLOB:right/d:$(git rev-parse base~1:right/d)
     ++	4:BLOB:right/c:$(git rev-parse base~2:right/c)
     ++	4:BLOB:right/c:$(git rev-parse topic:right/c)
     ++	5:TREE:left/:$(git rev-parse base:left)
     ++	5:TREE:left/:$(git rev-parse base~2:left)
     ++	6:BLOB:left/b:$(git rev-parse base~2:left/b)
     ++	6:BLOB:left/b:$(git rev-parse base:left/b)
     ++	7:BLOB:a:$(git rev-parse base~2:a)
     + 	blobs:6
      +	commits:4
     - 	TREE::$(git rev-parse topic^{tree})
     - 	TREE::$(git rev-parse base^{tree})
     - 	TREE::$(git rev-parse base~1^{tree})
     + 	trees:9
     + 	EOF
     + 
      @@ t/t6601-path-walk.sh: test_expect_success 'topic only' '
       	test-tool path-walk -- topic >out &&
       
       	cat >expect <<-EOF &&
     -+	COMMIT::$(git rev-parse topic)
     -+	COMMIT::$(git rev-parse base~1)
     -+	COMMIT::$(git rev-parse base~2)
     +-	0:TREE::$(git rev-parse topic^{tree})
     +-	0:TREE::$(git rev-parse base~1^{tree})
     +-	0:TREE::$(git rev-parse base~2^{tree})
     +-	1:TREE:right/:$(git rev-parse topic:right)
     +-	1:TREE:right/:$(git rev-parse base~1:right)
     +-	1:TREE:right/:$(git rev-parse base~2:right)
     +-	2:BLOB:right/d:$(git rev-parse base~1:right/d)
     +-	3:BLOB:right/c:$(git rev-parse base~2:right/c)
     +-	3:BLOB:right/c:$(git rev-parse topic:right/c)
     +-	4:TREE:left/:$(git rev-parse base~2:left)
     +-	5:BLOB:left/b:$(git rev-parse base~2:left/b)
     +-	6:BLOB:a:$(git rev-parse base~2:a)
     ++	0:COMMIT::$(git rev-parse topic)
     ++	0:COMMIT::$(git rev-parse base~1)
     ++	0:COMMIT::$(git rev-parse base~2)
     ++	1:TREE::$(git rev-parse topic^{tree})
     ++	1:TREE::$(git rev-parse base~1^{tree})
     ++	1:TREE::$(git rev-parse base~2^{tree})
     ++	2:TREE:right/:$(git rev-parse topic:right)
     ++	2:TREE:right/:$(git rev-parse base~1:right)
     ++	2:TREE:right/:$(git rev-parse base~2:right)
     ++	3:BLOB:right/d:$(git rev-parse base~1:right/d)
     ++	4:BLOB:right/c:$(git rev-parse base~2:right/c)
     ++	4:BLOB:right/c:$(git rev-parse topic:right/c)
     ++	5:TREE:left/:$(git rev-parse base~2:left)
     ++	6:BLOB:left/b:$(git rev-parse base~2:left/b)
     ++	7:BLOB:a:$(git rev-parse base~2:a)
     + 	blobs:5
      +	commits:3
     - 	TREE::$(git rev-parse topic^{tree})
     - 	TREE::$(git rev-parse base~1^{tree})
     - 	TREE::$(git rev-parse base~2^{tree})
     + 	trees:7
     + 	EOF
     + 
      @@ t/t6601-path-walk.sh: test_expect_success 'topic, not base' '
       	test-tool path-walk -- topic --not base >out &&
       
       	cat >expect <<-EOF &&
     -+	COMMIT::$(git rev-parse topic)
     ++	0:COMMIT::$(git rev-parse topic)
     ++	1:TREE::$(git rev-parse topic^{tree})
     ++	2:TREE:right/:$(git rev-parse topic:right)
     ++	3:BLOB:right/d:$(git rev-parse topic:right/d)
     ++	4:BLOB:right/c:$(git rev-parse topic:right/c)
     ++	5:TREE:left/:$(git rev-parse topic:left)
     ++	6:BLOB:left/b:$(git rev-parse topic:left/b)
     ++	7:BLOB:a:$(git rev-parse topic:a)
     ++	blobs:4
      +	commits:1
     - 	TREE::$(git rev-parse topic^{tree})
     - 	TREE:left/:$(git rev-parse topic:left)
     - 	TREE:right/:$(git rev-parse topic:right)
     -@@ t/t6601-path-walk.sh: test_expect_success 'topic, not base' '
     - 	test_cmp_sorted expect out
     - '
     - 
     ++	trees:3
     ++	EOF
     ++
     ++	test_cmp_sorted expect out
     ++'
     ++
      +test_expect_success 'topic, not base, only blobs' '
      +	test-tool path-walk --no-trees --no-commits \
      +		-- topic --not base >out &&
     @@ t/t6601-path-walk.sh: test_expect_success 'topic, not base' '
      +	cat >expect <<-EOF &&
      +	commits:0
      +	trees:0
     -+	BLOB:a:$(git rev-parse topic:a)
     -+	BLOB:left/b:$(git rev-parse topic:left/b)
     -+	BLOB:right/c:$(git rev-parse topic:right/c)
     -+	BLOB:right/d:$(git rev-parse topic:right/d)
     ++	0:BLOB:right/d:$(git rev-parse topic:right/d)
     ++	1:BLOB:right/c:$(git rev-parse topic:right/c)
     ++	2:BLOB:left/b:$(git rev-parse topic:left/b)
     ++	3:BLOB:a:$(git rev-parse topic:a)
      +	blobs:4
      +	EOF
      +
     @@ t/t6601-path-walk.sh: test_expect_success 'topic, not base' '
      +		-- topic --not base >out &&
      +
      +	cat >expect <<-EOF &&
     -+	COMMIT::$(git rev-parse topic)
     ++	0:COMMIT::$(git rev-parse topic)
      +	commits:1
      +	trees:0
      +	blobs:0
     @@ t/t6601-path-walk.sh: test_expect_success 'topic, not base' '
      +
      +	cat >expect <<-EOF &&
      +	commits:0
     -+	TREE::$(git rev-parse topic^{tree})
     -+	TREE:left/:$(git rev-parse topic:left)
     -+	TREE:right/:$(git rev-parse topic:right)
     -+	trees:3
     + 	0:TREE::$(git rev-parse topic^{tree})
     + 	1:TREE:right/:$(git rev-parse topic:right)
     +-	2:BLOB:right/d:$(git rev-parse topic:right/d)
     +-	3:BLOB:right/c:$(git rev-parse topic:right/c)
     +-	4:TREE:left/:$(git rev-parse topic:left)
     +-	5:BLOB:left/b:$(git rev-parse topic:left/b)
     +-	6:BLOB:a:$(git rev-parse topic:a)
     +-	blobs:4
     ++	2:TREE:left/:$(git rev-parse topic:left)
     + 	trees:3
      +	blobs:0
     -+	EOF
     -+
     -+	test_cmp_sorted expect out
     -+'
     -+
     - test_expect_success 'topic, not base, boundary' '
     + 	EOF
     + 
     + 	test_cmp_sorted expect out
     +@@ t/t6601-path-walk.sh: test_expect_success 'topic, not base, boundary' '
       	test-tool path-walk -- --boundary topic --not base >out &&
       
       	cat >expect <<-EOF &&
     -+	COMMIT::$(git rev-parse topic)
     -+	COMMIT::$(git rev-parse base~1)
     +-	0:TREE::$(git rev-parse topic^{tree})
     +-	0:TREE::$(git rev-parse base~1^{tree})
     +-	1:TREE:right/:$(git rev-parse topic:right)
     +-	1:TREE:right/:$(git rev-parse base~1:right)
     +-	2:BLOB:right/d:$(git rev-parse base~1:right/d)
     +-	3:BLOB:right/c:$(git rev-parse base~1:right/c)
     +-	3:BLOB:right/c:$(git rev-parse topic:right/c)
     +-	4:TREE:left/:$(git rev-parse base~1:left)
     +-	5:BLOB:left/b:$(git rev-parse base~1:left/b)
     +-	6:BLOB:a:$(git rev-parse base~1:a)
     ++	0:COMMIT::$(git rev-parse topic)
     ++	0:COMMIT::$(git rev-parse base~1)
     ++	1:TREE::$(git rev-parse topic^{tree})
     ++	1:TREE::$(git rev-parse base~1^{tree})
     ++	2:TREE:right/:$(git rev-parse topic:right)
     ++	2:TREE:right/:$(git rev-parse base~1:right)
     ++	3:BLOB:right/d:$(git rev-parse base~1:right/d)
     ++	4:BLOB:right/c:$(git rev-parse base~1:right/c)
     ++	4:BLOB:right/c:$(git rev-parse topic:right/c)
     ++	5:TREE:left/:$(git rev-parse base~1:left)
     ++	6:BLOB:left/b:$(git rev-parse base~1:left/b)
     ++	7:BLOB:a:$(git rev-parse base~1:a)
     + 	blobs:5
      +	commits:2
     - 	TREE::$(git rev-parse topic^{tree})
     - 	TREE::$(git rev-parse base~1^{tree})
     - 	TREE:left/:$(git rev-parse base~1:left)
     + 	trees:5
     + 	EOF
     + 
 5:  3dc27658526 ! 5:  97765aa04c2 path-walk: visit tags and cached objects
     @@ path-walk.c: static int walk_path(struct path_walk_context *ctx,
      +	if (!list)
      +		BUG("provided path '%s' that had no associated list", path);
      +
     + 	if (!list->oids.nr)
     + 		return 0;
     + 
       	/* Evaluate function pointer on this data, if requested. */
       	if ((list->type == OBJ_TREE && ctx->info->trees) ||
      -	    (list->type == OBJ_BLOB && ctx->info->blobs))
     @@ path-walk.c: int walk_objects_by_path(struct path_walk_info *info)
      +		struct hashmap_iter iter;
      +		struct strmap_entry *entry;
      +
     -+		strmap_for_each_entry(&ctx.paths_to_lists, &iter, entry) {
     ++		strmap_for_each_entry(&ctx.paths_to_lists, &iter, entry)
      +			push_to_stack(&ctx, entry->key);
     -+		}
      +
      +		while (!ret && ctx.path_stack.nr) {
      +			char *path = ctx.path_stack.items[ctx.path_stack.nr - 1].string;
     @@ t/helper/test-path-walk.c: static int emit_block(const char *path, struct oid_ar
       	default:
       		BUG("we do not understand this type");
       	}
     + 
     ++	/* This should never be output during tests. */
     ++	if (!oids->nr)
     ++		printf("%"PRIuMAX":%s:%s:EMPTY\n",
     ++		       tdata->batch_nr, typestr, path);
     ++
     + 	for (size_t i = 0; i < oids->nr; i++)
     + 		printf("%"PRIuMAX":%s:%s:%s\n",
     + 		       tdata->batch_nr, typestr, path,
      @@ t/helper/test-path-walk.c: int cmd__path_walk(int argc, const char **argv)
       			 N_("toggle inclusion of blob objects")),
       		OPT_BOOL(0, "commits", &info.commits,
     @@ t/helper/test-path-walk.c: int cmd__path_walk(int argc, const char **argv)
      +	       "tags:%" PRIuMAX "\n",
      +	       data.commit_nr, data.tree_nr, data.blob_nr, data.tag_nr);
       
     + 	release_revisions(&revs);
       	return res;
     - }
      
       ## t/t6601-path-walk.sh ##
      @@ t/t6601-path-walk.sh: test_description='direct path-walk API tests'
     @@ t/t6601-path-walk.sh: test_description='direct path-walk API tests'
       '
       
       test_expect_success 'all' '
     -@@ t/t6601-path-walk.sh: test_expect_success 'all' '
     - 	TREE::$(git rev-parse base^{tree})
     - 	TREE::$(git rev-parse base~1^{tree})
     - 	TREE::$(git rev-parse base~2^{tree})
     -+	TREE::$(git rev-parse refs/tags/tree-tag^{})
     -+	TREE::$(git rev-parse refs/tags/tree-tag2^{})
     -+	TREE:a/:$(git rev-parse base:a)
     - 	TREE:left/:$(git rev-parse base:left)
     - 	TREE:left/:$(git rev-parse base~2:left)
     - 	TREE:right/:$(git rev-parse topic:right)
     - 	TREE:right/:$(git rev-parse base~1:right)
     - 	TREE:right/:$(git rev-parse base~2:right)
     --	trees:9
     -+	TREE:child/:$(git rev-parse refs/tags/tree-tag^{}:child)
     -+	trees:13
     - 	BLOB:a:$(git rev-parse base~2:a)
     -+	BLOB:file2:$(git rev-parse refs/tags/tree-tag2^{}:file2)
     - 	BLOB:left/b:$(git rev-parse base~2:left/b)
     - 	BLOB:left/b:$(git rev-parse base:left/b)
     - 	BLOB:right/c:$(git rev-parse base~2:right/c)
     - 	BLOB:right/c:$(git rev-parse topic:right/c)
     - 	BLOB:right/d:$(git rev-parse base~1:right/d)
     --	blobs:6
     -+	BLOB:/tagged-blobs:$(git rev-parse refs/tags/blob-tag^{})
     -+	BLOB:/tagged-blobs:$(git rev-parse refs/tags/blob-tag2^{})
     -+	BLOB:child/file:$(git rev-parse refs/tags/tree-tag^{}:child/file)
     + 	test-tool path-walk -- --all >out &&
     + 
     ++	cat >expect <<-EOF &&
     ++	0:COMMIT::$(git rev-parse topic)
     ++	0:COMMIT::$(git rev-parse base)
     ++	0:COMMIT::$(git rev-parse base~1)
     ++	0:COMMIT::$(git rev-parse base~2)
     ++	1:TAG:/tags:$(git rev-parse refs/tags/first)
     ++	1:TAG:/tags:$(git rev-parse refs/tags/second.1)
     ++	1:TAG:/tags:$(git rev-parse refs/tags/second.2)
     ++	1:TAG:/tags:$(git rev-parse refs/tags/third)
     ++	1:TAG:/tags:$(git rev-parse refs/tags/fourth)
     ++	1:TAG:/tags:$(git rev-parse refs/tags/tree-tag)
     ++	1:TAG:/tags:$(git rev-parse refs/tags/blob-tag)
     ++	2:BLOB:/tagged-blobs:$(git rev-parse refs/tags/blob-tag^{})
     ++	2:BLOB:/tagged-blobs:$(git rev-parse refs/tags/blob-tag2^{})
     ++	3:TREE::$(git rev-parse topic^{tree})
     ++	3:TREE::$(git rev-parse base^{tree})
     ++	3:TREE::$(git rev-parse base~1^{tree})
     ++	3:TREE::$(git rev-parse base~2^{tree})
     ++	3:TREE::$(git rev-parse refs/tags/tree-tag^{})
     ++	3:TREE::$(git rev-parse refs/tags/tree-tag2^{})
     ++	4:BLOB:a:$(git rev-parse base~2:a)
     ++	5:TREE:right/:$(git rev-parse topic:right)
     ++	5:TREE:right/:$(git rev-parse base~1:right)
     ++	5:TREE:right/:$(git rev-parse base~2:right)
     ++	6:BLOB:right/d:$(git rev-parse base~1:right/d)
     ++	7:BLOB:right/c:$(git rev-parse base~2:right/c)
     ++	7:BLOB:right/c:$(git rev-parse topic:right/c)
     ++	8:TREE:left/:$(git rev-parse base:left)
     ++	8:TREE:left/:$(git rev-parse base~2:left)
     ++	9:BLOB:left/b:$(git rev-parse base~2:left/b)
     ++	9:BLOB:left/b:$(git rev-parse base:left/b)
     ++	10:TREE:a/:$(git rev-parse base:a)
     ++	11:BLOB:file2:$(git rev-parse refs/tags/tree-tag2^{}:file2)
     ++	12:TREE:child/:$(git rev-parse refs/tags/tree-tag:child)
     ++	13:BLOB:child/file:$(git rev-parse refs/tags/tree-tag:child/file)
      +	blobs:10
     -+	TAG:/tags:$(git rev-parse refs/tags/first)
     -+	TAG:/tags:$(git rev-parse refs/tags/second.1)
     -+	TAG:/tags:$(git rev-parse refs/tags/second.2)
     -+	TAG:/tags:$(git rev-parse refs/tags/third)
     -+	TAG:/tags:$(git rev-parse refs/tags/fourth)
     -+	TAG:/tags:$(git rev-parse refs/tags/tree-tag)
     -+	TAG:/tags:$(git rev-parse refs/tags/blob-tag)
     ++	commits:4
      +	tags:7
     ++	trees:13
      +	EOF
      +
      +	test_cmp_sorted expect out
     @@ t/t6601-path-walk.sh: test_expect_success 'all' '
      +	test-tool path-walk -- --indexed-objects >out &&
      +
      +	cat >expect <<-EOF &&
     -+	commits:0
     -+	TREE:right/:$(git rev-parse topic:right)
     -+	trees:1
     -+	BLOB:a:$(git rev-parse HEAD:a)
     -+	BLOB:left/b:$(git rev-parse HEAD:left/b)
     -+	BLOB:left/c:$(git rev-parse :left/c)
     -+	BLOB:right/c:$(git rev-parse HEAD:right/c)
     -+	BLOB:right/d:$(git rev-parse HEAD:right/d)
     ++	0:BLOB:a:$(git rev-parse HEAD:a)
     ++	1:BLOB:left/b:$(git rev-parse HEAD:left/b)
     ++	2:BLOB:left/c:$(git rev-parse :left/c)
     ++	3:BLOB:right/c:$(git rev-parse HEAD:right/c)
     ++	4:BLOB:right/d:$(git rev-parse HEAD:right/d)
     ++	5:TREE:right/:$(git rev-parse topic:right)
      +	blobs:5
     ++	commits:0
      +	tags:0
     ++	trees:1
      +	EOF
      +
      +	test_cmp_sorted expect out
     @@ t/t6601-path-walk.sh: test_expect_success 'all' '
      +
      +	test-tool path-walk -- --indexed-objects --branches >out &&
      +
     -+	cat >expect <<-EOF &&
     -+	COMMIT::$(git rev-parse topic)
     -+	COMMIT::$(git rev-parse base)
     -+	COMMIT::$(git rev-parse base~1)
     -+	COMMIT::$(git rev-parse base~2)
     -+	commits:4
     -+	TREE::$(git rev-parse topic^{tree})
     -+	TREE::$(git rev-parse base^{tree})
     -+	TREE::$(git rev-parse base~1^{tree})
     -+	TREE::$(git rev-parse base~2^{tree})
     -+	TREE:a/:$(git rev-parse base:a)
     -+	TREE:left/:$(git rev-parse base:left)
     -+	TREE:left/:$(git rev-parse base~2:left)
     -+	TREE:right/:$(git rev-parse topic:right)
     -+	TREE:right/:$(git rev-parse base~1:right)
     -+	TREE:right/:$(git rev-parse base~2:right)
     -+	trees:10
     -+	BLOB:a:$(git rev-parse base~2:a)
     -+	BLOB:left/b:$(git rev-parse base:left/b)
     -+	BLOB:left/b:$(git rev-parse base~2:left/b)
     -+	BLOB:right/c:$(git rev-parse base~2:right/c)
     -+	BLOB:right/c:$(git rev-parse topic:right/c)
     -+	BLOB:right/d:$(git rev-parse base~1:right/d)
     -+	BLOB:right/d:$(git rev-parse :right/d)
     + 	cat >expect <<-EOF &&
     + 	0:COMMIT::$(git rev-parse topic)
     + 	0:COMMIT::$(git rev-parse base)
     +@@ t/t6601-path-walk.sh: test_expect_success 'all' '
     + 	1:TREE::$(git rev-parse base^{tree})
     + 	1:TREE::$(git rev-parse base~1^{tree})
     + 	1:TREE::$(git rev-parse base~2^{tree})
     +-	2:TREE:right/:$(git rev-parse topic:right)
     +-	2:TREE:right/:$(git rev-parse base~1:right)
     +-	2:TREE:right/:$(git rev-parse base~2:right)
     +-	3:BLOB:right/d:$(git rev-parse base~1:right/d)
     +-	4:BLOB:right/c:$(git rev-parse base~2:right/c)
     +-	4:BLOB:right/c:$(git rev-parse topic:right/c)
     +-	5:TREE:left/:$(git rev-parse base:left)
     +-	5:TREE:left/:$(git rev-parse base~2:left)
     +-	6:BLOB:left/b:$(git rev-parse base~2:left/b)
     +-	6:BLOB:left/b:$(git rev-parse base:left/b)
     +-	7:BLOB:a:$(git rev-parse base~2:a)
     +-	blobs:6
     ++	2:BLOB:a:$(git rev-parse base~2:a)
     ++	3:TREE:right/:$(git rev-parse topic:right)
     ++	3:TREE:right/:$(git rev-parse base~1:right)
     ++	3:TREE:right/:$(git rev-parse base~2:right)
     ++	4:BLOB:right/d:$(git rev-parse base~1:right/d)
     ++	4:BLOB:right/d:$(git rev-parse :right/d)
     ++	5:BLOB:right/c:$(git rev-parse base~2:right/c)
     ++	5:BLOB:right/c:$(git rev-parse topic:right/c)
     ++	6:TREE:left/:$(git rev-parse base:left)
     ++	6:TREE:left/:$(git rev-parse base~2:left)
     ++	7:BLOB:left/b:$(git rev-parse base:left/b)
     ++	7:BLOB:left/b:$(git rev-parse base~2:left/b)
     ++	8:TREE:a/:$(git rev-parse refs/tags/third:a)
      +	blobs:7
     + 	commits:4
     +-	trees:9
      +	tags:0
     ++	trees:10
       	EOF
       
       	test_cmp_sorted expect out
      @@ t/t6601-path-walk.sh: test_expect_success 'topic only' '
     - 	BLOB:right/c:$(git rev-parse topic:right/c)
     - 	BLOB:right/d:$(git rev-parse base~1:right/d)
     + 	7:BLOB:a:$(git rev-parse base~2:a)
       	blobs:5
     + 	commits:3
      +	tags:0
     + 	trees:7
       	EOF
       
     - 	test_cmp_sorted expect out
      @@ t/t6601-path-walk.sh: test_expect_success 'topic, not base' '
     - 	BLOB:right/c:$(git rev-parse topic:right/c)
     - 	BLOB:right/d:$(git rev-parse topic:right/d)
     + 	7:BLOB:a:$(git rev-parse topic:a)
       	blobs:4
     + 	commits:1
      +	tags:0
     + 	trees:3
       	EOF
       
     - 	test_cmp_sorted expect out
      @@ t/t6601-path-walk.sh: test_expect_success 'topic, not base, only blobs' '
     - 	BLOB:right/c:$(git rev-parse topic:right/c)
     - 	BLOB:right/d:$(git rev-parse topic:right/d)
     + 		-- topic --not base >out &&
     + 
     + 	cat >expect <<-EOF &&
     +-	commits:0
     +-	trees:0
     + 	0:BLOB:right/d:$(git rev-parse topic:right/d)
     + 	1:BLOB:right/c:$(git rev-parse topic:right/c)
     + 	2:BLOB:left/b:$(git rev-parse topic:left/b)
     + 	3:BLOB:a:$(git rev-parse topic:a)
       	blobs:4
     ++	commits:0
      +	tags:0
     ++	trees:0
       	EOF
       
       	test_cmp_sorted expect out
      @@ t/t6601-path-walk.sh: test_expect_success 'topic, not base, only commits' '
     + 	cat >expect <<-EOF &&
     + 	0:COMMIT::$(git rev-parse topic)
       	commits:1
     - 	trees:0
     +-	trees:0
       	blobs:0
      +	tags:0
     ++	trees:0
       	EOF
       
       	test_cmp_sorted expect out
      @@ t/t6601-path-walk.sh: test_expect_success 'topic, not base, only trees' '
     - 	TREE:right/:$(git rev-parse topic:right)
     - 	trees:3
     + 		-- topic --not base >out &&
     + 
     + 	cat >expect <<-EOF &&
     +-	commits:0
     + 	0:TREE::$(git rev-parse topic^{tree})
     + 	1:TREE:right/:$(git rev-parse topic:right)
     + 	2:TREE:left/:$(git rev-parse topic:left)
     +-	trees:3
     ++	commits:0
       	blobs:0
      +	tags:0
     ++	trees:3
       	EOF
       
       	test_cmp_sorted expect out
      @@ t/t6601-path-walk.sh: test_expect_success 'topic, not base, boundary' '
     - 	BLOB:right/c:$(git rev-parse topic:right/c)
     - 	BLOB:right/d:$(git rev-parse base~1:right/d)
     + 	7:BLOB:a:$(git rev-parse base~1:a)
       	blobs:5
     + 	commits:2
      +	tags:0
     + 	trees:5
       	EOF
       
       	test_cmp_sorted expect out
 6:  0bb607e1fd3 ! 6:  a4aaa3b001b path-walk: mark trees and blobs as UNINTERESTING
     @@ path-walk.c: static int add_children(struct path_walk_context *ctx,
       	}
       
      @@ path-walk.c: static int walk_path(struct path_walk_context *ctx,
     - 	if (!list)
     - 		BUG("provided path '%s' that had no associated list", path);
     + 	if (!list->oids.nr)
     + 		return 0;
       
      +	if (ctx->info->prune_all_uninteresting) {
      +		/*
     @@ path-walk.h: struct path_walk_info {
      
       ## t/helper/test-path-walk.c ##
      @@ t/helper/test-path-walk.c: static int emit_block(const char *path, struct oid_array *oids,
     - 		BUG("we do not understand this type");
     - 	}
     + 		printf("%"PRIuMAX":%s:%s:EMPTY\n",
     + 		       tdata->batch_nr, typestr, path);
       
      -	for (size_t i = 0; i < oids->nr; i++)
     --		printf("%s:%s:%s\n", typestr, path, oid_to_hex(&oids->oid[i]));
     +-		printf("%"PRIuMAX":%s:%s:%s\n",
      +	for (size_t i = 0; i < oids->nr; i++) {
      +		struct object *o = lookup_unknown_object(the_repository,
      +							 &oids->oid[i]);
     -+		printf("%s:%s:%s%s\n", typestr, path, oid_to_hex(&oids->oid[i]),
     ++		printf("%"PRIuMAX":%s:%s:%s%s\n",
     + 		       tdata->batch_nr, typestr, path,
     +-		       oid_to_hex(&oids->oid[i]));
     ++		       oid_to_hex(&oids->oid[i]),
      +		       o->flags & UNINTERESTING ? ":UNINTERESTING" : "");
      +	}
       
     + 	tdata->batch_nr++;
       	return 0;
     - }
      @@ t/helper/test-path-walk.c: int cmd__path_walk(int argc, const char **argv)
       			 N_("toggle inclusion of tag objects")),
       		OPT_BOOL(0, "trees", &info.trees,
     @@ t/helper/test-path-walk.c: int cmd__path_walk(int argc, const char **argv)
      
       ## t/t6601-path-walk.sh ##
      @@ t/t6601-path-walk.sh: test_expect_success 'topic, not base' '
     - 	COMMIT::$(git rev-parse topic)
     - 	commits:1
     - 	TREE::$(git rev-parse topic^{tree})
     --	TREE:left/:$(git rev-parse topic:left)
     -+	TREE:left/:$(git rev-parse base~1:left):UNINTERESTING
     - 	TREE:right/:$(git rev-parse topic:right)
     - 	trees:3
     --	BLOB:a:$(git rev-parse topic:a)
     --	BLOB:left/b:$(git rev-parse topic:left/b)
     -+	BLOB:a:$(git rev-parse base~1:a):UNINTERESTING
     -+	BLOB:left/b:$(git rev-parse base~1:left/b):UNINTERESTING
     - 	BLOB:right/c:$(git rev-parse topic:right/c)
     --	BLOB:right/d:$(git rev-parse topic:right/d)
     -+	BLOB:right/d:$(git rev-parse base~1:right/d):UNINTERESTING
     + 	0:COMMIT::$(git rev-parse topic)
     + 	1:TREE::$(git rev-parse topic^{tree})
     + 	2:TREE:right/:$(git rev-parse topic:right)
     +-	3:BLOB:right/d:$(git rev-parse topic:right/d)
     ++	3:BLOB:right/d:$(git rev-parse topic:right/d):UNINTERESTING
     + 	4:BLOB:right/c:$(git rev-parse topic:right/c)
     +-	5:TREE:left/:$(git rev-parse topic:left)
     +-	6:BLOB:left/b:$(git rev-parse topic:left/b)
     +-	7:BLOB:a:$(git rev-parse topic:a)
     ++	5:TREE:left/:$(git rev-parse topic:left):UNINTERESTING
     ++	6:BLOB:left/b:$(git rev-parse topic:left/b):UNINTERESTING
     ++	7:BLOB:a:$(git rev-parse topic:a):UNINTERESTING
       	blobs:4
     + 	commits:1
       	tags:0
     - 	EOF
      @@ t/t6601-path-walk.sh: test_expect_success 'topic, not base' '
       	test_cmp_sorted expect out
       '
     @@ t/t6601-path-walk.sh: test_expect_success 'topic, not base' '
      +	test-tool path-walk -- fourth blob-tag2 --not base >out &&
      +
      +	cat >expect <<-EOF &&
     -+	COMMIT::$(git rev-parse topic)
     -+	commits:1
     -+	TREE::$(git rev-parse topic^{tree})
     -+	TREE:left/:$(git rev-parse base~1:left):UNINTERESTING
     -+	TREE:right/:$(git rev-parse topic:right)
     -+	trees:3
     -+	BLOB:a:$(git rev-parse base~1:a):UNINTERESTING
     -+	BLOB:left/b:$(git rev-parse base~1:left/b):UNINTERESTING
     -+	BLOB:right/c:$(git rev-parse topic:right/c)
     -+	BLOB:right/d:$(git rev-parse base~1:right/d):UNINTERESTING
     -+	BLOB:/tagged-blobs:$(git rev-parse refs/tags/blob-tag2^{})
     ++	0:COMMIT::$(git rev-parse topic)
     ++	1:TAG:/tags:$(git rev-parse fourth)
     ++	2:BLOB:/tagged-blobs:$(git rev-parse refs/tags/blob-tag2^{})
     ++	3:TREE::$(git rev-parse topic^{tree})
     ++	4:TREE:right/:$(git rev-parse topic:right)
     ++	5:BLOB:right/d:$(git rev-parse base~1:right/d):UNINTERESTING
     ++	6:BLOB:right/c:$(git rev-parse topic:right/c)
     ++	7:TREE:left/:$(git rev-parse base~1:left):UNINTERESTING
     ++	8:BLOB:left/b:$(git rev-parse base~1:left/b):UNINTERESTING
     ++	9:BLOB:a:$(git rev-parse base~1:a):UNINTERESTING
      +	blobs:5
     -+	TAG:/tags:$(git rev-parse fourth)
     ++	commits:1
      +	tags:1
     ++	trees:3
      +	EOF
      +
      +	test_cmp_sorted expect out
     @@ t/t6601-path-walk.sh: test_expect_success 'topic, not base' '
       test_expect_success 'topic, not base, only blobs' '
       	test-tool path-walk --no-trees --no-commits \
       		-- topic --not base >out &&
     -@@ t/t6601-path-walk.sh: test_expect_success 'topic, not base, only blobs' '
     + 
       	cat >expect <<-EOF &&
     - 	commits:0
     - 	trees:0
     --	BLOB:a:$(git rev-parse topic:a)
     --	BLOB:left/b:$(git rev-parse topic:left/b)
     -+	BLOB:a:$(git rev-parse base~1:a):UNINTERESTING
     -+	BLOB:left/b:$(git rev-parse base~1:left/b):UNINTERESTING
     - 	BLOB:right/c:$(git rev-parse topic:right/c)
     --	BLOB:right/d:$(git rev-parse topic:right/d)
     -+	BLOB:right/d:$(git rev-parse base~1:right/d):UNINTERESTING
     +-	0:BLOB:right/d:$(git rev-parse topic:right/d)
     ++	0:BLOB:right/d:$(git rev-parse topic:right/d):UNINTERESTING
     + 	1:BLOB:right/c:$(git rev-parse topic:right/c)
     +-	2:BLOB:left/b:$(git rev-parse topic:left/b)
     +-	3:BLOB:a:$(git rev-parse topic:a)
     ++	2:BLOB:left/b:$(git rev-parse topic:left/b):UNINTERESTING
     ++	3:BLOB:a:$(git rev-parse topic:a):UNINTERESTING
       	blobs:4
     + 	commits:0
       	tags:0
     - 	EOF
      @@ t/t6601-path-walk.sh: test_expect_success 'topic, not base, only trees' '
       	cat >expect <<-EOF &&
     + 	0:TREE::$(git rev-parse topic^{tree})
     + 	1:TREE:right/:$(git rev-parse topic:right)
     +-	2:TREE:left/:$(git rev-parse topic:left)
     ++	2:TREE:left/:$(git rev-parse topic:left):UNINTERESTING
       	commits:0
     - 	TREE::$(git rev-parse topic^{tree})
     --	TREE:left/:$(git rev-parse topic:left)
     -+	TREE:left/:$(git rev-parse base~1:left):UNINTERESTING
     - 	TREE:right/:$(git rev-parse topic:right)
     - 	trees:3
       	blobs:0
     + 	tags:0
      @@ t/t6601-path-walk.sh: test_expect_success 'topic, not base, boundary' '
       
       	cat >expect <<-EOF &&
     - 	COMMIT::$(git rev-parse topic)
     --	COMMIT::$(git rev-parse base~1)
     -+	COMMIT::$(git rev-parse base~1):UNINTERESTING
     - 	commits:2
     - 	TREE::$(git rev-parse topic^{tree})
     --	TREE::$(git rev-parse base~1^{tree})
     --	TREE:left/:$(git rev-parse base~1:left)
     -+	TREE::$(git rev-parse base~1^{tree}):UNINTERESTING
     -+	TREE:left/:$(git rev-parse base~1:left):UNINTERESTING
     - 	TREE:right/:$(git rev-parse topic:right)
     --	TREE:right/:$(git rev-parse base~1:right)
     -+	TREE:right/:$(git rev-parse base~1:right):UNINTERESTING
     - 	trees:5
     --	BLOB:a:$(git rev-parse base~1:a)
     --	BLOB:left/b:$(git rev-parse base~1:left/b)
     --	BLOB:right/c:$(git rev-parse base~1:right/c)
     -+	BLOB:a:$(git rev-parse base~1:a):UNINTERESTING
     -+	BLOB:left/b:$(git rev-parse base~1:left/b):UNINTERESTING
     -+	BLOB:right/c:$(git rev-parse base~1:right/c):UNINTERESTING
     - 	BLOB:right/c:$(git rev-parse topic:right/c)
     --	BLOB:right/d:$(git rev-parse base~1:right/d)
     -+	BLOB:right/d:$(git rev-parse base~1:right/d):UNINTERESTING
     + 	0:COMMIT::$(git rev-parse topic)
     +-	0:COMMIT::$(git rev-parse base~1)
     ++	0:COMMIT::$(git rev-parse base~1):UNINTERESTING
     + 	1:TREE::$(git rev-parse topic^{tree})
     +-	1:TREE::$(git rev-parse base~1^{tree})
     ++	1:TREE::$(git rev-parse base~1^{tree}):UNINTERESTING
     + 	2:TREE:right/:$(git rev-parse topic:right)
     +-	2:TREE:right/:$(git rev-parse base~1:right)
     +-	3:BLOB:right/d:$(git rev-parse base~1:right/d)
     +-	4:BLOB:right/c:$(git rev-parse base~1:right/c)
     ++	2:TREE:right/:$(git rev-parse base~1:right):UNINTERESTING
     ++	3:BLOB:right/d:$(git rev-parse base~1:right/d):UNINTERESTING
     ++	4:BLOB:right/c:$(git rev-parse base~1:right/c):UNINTERESTING
     + 	4:BLOB:right/c:$(git rev-parse topic:right/c)
     +-	5:TREE:left/:$(git rev-parse base~1:left)
     +-	6:BLOB:left/b:$(git rev-parse base~1:left/b)
     +-	7:BLOB:a:$(git rev-parse base~1:a)
     ++	5:TREE:left/:$(git rev-parse base~1:left):UNINTERESTING
     ++	6:BLOB:left/b:$(git rev-parse base~1:left/b):UNINTERESTING
     ++	7:BLOB:a:$(git rev-parse base~1:a):UNINTERESTING
       	blobs:5
     + 	commits:2
       	tags:0
     - 	EOF
      @@ t/t6601-path-walk.sh: test_expect_success 'topic, not base, boundary' '
       	test_cmp_sorted expect out
       '
     @@ t/t6601-path-walk.sh: test_expect_success 'topic, not base, boundary' '
      +	test-tool path-walk --prune -- --boundary topic --not base >out &&
      +
      +	cat >expect <<-EOF &&
     -+	COMMIT::$(git rev-parse topic)
     -+	COMMIT::$(git rev-parse base~1):UNINTERESTING
     -+	commits:2
     -+	TREE::$(git rev-parse topic^{tree})
     -+	TREE::$(git rev-parse base~1^{tree}):UNINTERESTING
     -+	TREE:right/:$(git rev-parse topic:right)
     -+	TREE:right/:$(git rev-parse base~1:right):UNINTERESTING
     -+	trees:4
     -+	BLOB:right/c:$(git rev-parse base~1:right/c):UNINTERESTING
     -+	BLOB:right/c:$(git rev-parse topic:right/c)
     ++	0:COMMIT::$(git rev-parse topic)
     ++	0:COMMIT::$(git rev-parse base~1):UNINTERESTING
     ++	1:TREE::$(git rev-parse topic^{tree})
     ++	1:TREE::$(git rev-parse base~1^{tree}):UNINTERESTING
     ++	2:TREE:right/:$(git rev-parse topic:right)
     ++	2:TREE:right/:$(git rev-parse base~1:right):UNINTERESTING
     ++	3:BLOB:right/c:$(git rev-parse base~1:right/c):UNINTERESTING
     ++	3:BLOB:right/c:$(git rev-parse topic:right/c)
      +	blobs:2
     ++	commits:2
      +	tags:0
     ++	trees:4
      +	EOF
      +
      +	test_cmp_sorted expect out

-- 
gitgitgadget
