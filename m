Return-Path: <SRS0=sJPh=5P=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,LOTS_OF_MONEY,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 418E8C2D0E9
	for <git@archiver.kernel.org>; Mon, 30 Mar 2020 00:31:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 04B4F20780
	for <git@archiver.kernel.org>; Mon, 30 Mar 2020 00:31:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mbqYjEbv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727736AbgC3Abr (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 29 Mar 2020 20:31:47 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:45691 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727134AbgC3Abq (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 29 Mar 2020 20:31:46 -0400
Received: by mail-wr1-f67.google.com with SMTP id t7so19255577wrw.12
        for <git@vger.kernel.org>; Sun, 29 Mar 2020 17:31:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:mime-version
         :content-transfer-encoding:fcc:to:cc;
        bh=BHMA98F2CcjcxxMRbucwEqebQslfgRBA8tm9ok+Ydi0=;
        b=mbqYjEbvwt5YTiFWBZtBbvmOzlnbqnEMMOy+GtkIbXOBTa4oqMzu2CAODlGKRpHpDh
         toCMraNpJ3Uc4zan+B2tvp99NXZ3PoaJuE1b9u60tnA6lLd5ShAzMac9Cneew0bOgAyB
         Snx77V1DZti1jsau+LGRIRMzHy3s0PJcRY8a4Xu0yxoyCVzkfK0kEbeMuSe8UoBiwg7K
         MXxWmsWkqwMpSUCMaDEB3MWSbuzwiE/T5lYC23xTulLWboVZTaRBAru7WEtJoCtApxq0
         q4hEbavRx78zqTAQRcGVv1ZPt7UJ8yiTbrJOoYlsnQxW8cNJyyNnhQfuw2RUxt+7yau6
         40iA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:mime-version:content-transfer-encoding:fcc:to:cc;
        bh=BHMA98F2CcjcxxMRbucwEqebQslfgRBA8tm9ok+Ydi0=;
        b=GG2B9esfQRD+qXS1c5ecudGBIsikN7u89D5IYHUjQ9SBFsLF/SKrxSJixyH3RQ+p75
         rhj6iF85SBZ1qo0Xz1i1ESEXOROAc0OnmXm9yQ+HJxEl07Zewgk7VCG7zhb/K8GaZijZ
         xtP+Sw9g8sxaIlCLPnD29k80/GoBOS9I1YW2z7QGUipBq70tFuHumsd5/+mF8RvrFVfR
         Is2vsguHKgIzdNhFtnxL6NA8y2n6l2qKTJMlX1ch4ymVm9BLdZd5IcH2Iy5Irosc6sx6
         oIUQzVc0PhOjKi6o6/DwB1jDPGQzWzUjPR5AHEQVl42tR4iKBUxM+ke9bNpGRcu+y+lY
         dLTQ==
X-Gm-Message-State: ANhLgQ3d+Ov9O9lxPbclQZSvcbJxLHy/hEvpu7ddL94QWjRb2xA0VO66
        EwFGhuVEK0jkwP387kXOBfNHNmBv
X-Google-Smtp-Source: ADFU+vtqjuFMFjc860M7GLziIJgWfouIsmj4SmmtdCZ3Zm9UPMr8MMDzbb8JeRJaBMl2hUHnKZB/JA==
X-Received: by 2002:adf:d088:: with SMTP id y8mr11770564wrh.36.1585528301295;
        Sun, 29 Mar 2020 17:31:41 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id m5sm18229291wmg.13.2020.03.29.17.31.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 Mar 2020 17:31:40 -0700 (PDT)
Message-Id: <pull.497.v3.git.1585528298.gitgitgadget@gmail.com>
In-Reply-To: <pull.497.v2.git.1580943390.gitgitgadget@gmail.com>
References: <pull.497.v2.git.1580943390.gitgitgadget@gmail.com>
From:   "Garima Singh via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 30 Mar 2020 00:31:22 +0000
Subject: [PATCH v3 00/16] Changed Paths Bloom Filters
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc:    Sent
To:     git@vger.kernel.org
Cc:     stolee@gmail.com, szeder.dev@gmail.com, jonathantanmy@google.com,
        Garima Singh <garima.singh@microsoft.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hey! 

The commit graph feature brought in a lot of performance improvements across
multiple commands. However, file based history continues to be a performance
pain point, especially in large repositories. 

Adopting changed path Bloom filters has been discussed on the list before,
and a prototype version was worked on by SZEDER Gábor, Jonathan Tan and Dr.
Derrick Stolee [1]. This series is based on Dr. Stolee's proof of concept in
[2]

With the changes in this series, git users will be able to choose to write
Bloom filters to the commit-graph using the following command:

'git commit-graph write --changed-paths'

Subsequent 'git log -- path' commands will use these computed Bloom filters
to decided which commits are worth exploring further to produce the history
of the provided path. 

Cost of computing and writing Bloom filters
===========================================

Computing and writing Bloom filters to the commit graph for the first time
implies computing the diffs and the resulting Bloom filters for all the
commits in the repository. This adds a non trivial amount of time to run
time. Every subsequent run is incremental i.e. we reuse the previously
computed Bloom filters. So this is a one time cost. 

Time taken by 'git commit-graph write' with and w/o --changed-paths, speed
up in 'git log -- path' with computed Bloom filters (see a):- 

-------------------------------------------------------------------------
| Repo        | w/o --changed-paths | with --changed-paths | Speed up   |
-------------------------------------------------------------------------
| git [3]     | 0.9 seconds         | 7 seconds            | 2x to 6x   |
| linux [4]   | 16 seconds          | 1 minute 8 seconds   | 2x to 6x   | 
| android [5] | 9 seconds           | 48 seconds           | 2x to 6x   |
| AzDo(see b) | 1 minute            | 5 minutes 2 seconds  | 10x to 30x |
-------------------------------------------------------------------------

a) We tested the performance of git log -- path with randomly chosen paths
of varying depths in each repo. The speed up depends on how deep the files
are in the hierarchy and how often a file has been touched in the commit
history.

b) This internal repository has about 420k commits, 183k files distributed
across 34k folders, the size on disk is about 17 GiB. The most massive gains
on this repository were for files 6-12 levels deep in the tree. 

c) These numbers were collected on a Windows machine, except for the linux
repo which was tested on a Linux machine. 

Future Work (not included in the scope of this series)
======================================================

 1. Supporting multiple path based revision walk
 2. Adopting it in git blame logic. 
 3. Interactions with line log git log -L

Cheers! Garima Singh

[1] https://lore.kernel.org/git/20181009193445.21908-1-szeder.dev@gmail.com/

[2] 
https://lore.kernel.org/git/61559c5b-546e-d61b-d2e1-68de692f5972@gmail.com/

[3] https://github.com/git/git

[4] https://github.com/torvalds/linux

[5] https://android.googlesource.com/platform/frameworks/base/

jeffhost@microsoft.com, me@ttaylorr.com, peff@peff.net, 
garimasigit@gmail.com,jnareb@gmail.com, christian.couder@gmail.com, 
emilyshaffer@gmail.com,gitster@pobox.com

Derrick Stolee (1):
  diff: halt tree-diff early after max_changes

Garima Singh (14):
  commit-graph: define and use MAX_NUM_CHUNKS
  bloom.c: add the murmur3 hash implementation
  bloom.c: introduce core Bloom filter constructs
  bloom.c: core Bloom filter implementation for changed paths.
  commit-graph: compute Bloom filters for changed paths
  commit-graph: examine commits by generation number
  diff: skip batch object download when possible
  commit-graph: write Bloom filters to commit graph file
  commit-graph: reuse existing Bloom filters during write
  commit-graph: add --changed-paths option to write subcommand
  revision.c: use Bloom filters to speed up path based revision walks
  revision.c: add trace2 stats around Bloom filter usage
  t4216: add end to end tests for git log with Bloom filters
  commit-graph: add GIT_TEST_COMMIT_GRAPH_CHANGED_PATHS test flag

Jeff King (1):
  commit-graph: examine changed-path objects in pack order

 Documentation/git-commit-graph.txt            |   5 +
 .../technical/commit-graph-format.txt         |  30 ++
 Makefile                                      |   2 +
 bloom.c                                       | 276 ++++++++++++++++++
 bloom.h                                       |  90 ++++++
 builtin/commit-graph.c                        |  10 +-
 ci/run-build-and-tests.sh                     |   1 +
 commit-graph.c                                | 213 +++++++++++++-
 commit-graph.h                                |   9 +-
 diff.c                                        |   8 +-
 diff.h                                        |   6 +
 revision.c                                    | 126 +++++++-
 revision.h                                    |  11 +
 t/README                                      |   5 +
 t/helper/test-bloom.c                         |  81 +++++
 t/helper/test-read-graph.c                    |   4 +
 t/helper/test-tool.c                          |   1 +
 t/helper/test-tool.h                          |   1 +
 t/t0095-bloom.sh                              | 117 ++++++++
 t/t4216-log-bloom.sh                          | 155 ++++++++++
 t/t5318-commit-graph.sh                       |   2 +
 t/t5324-split-commit-graph.sh                 |   1 +
 tree-diff.c                                   |   6 +
 23 files changed, 1148 insertions(+), 12 deletions(-)
 create mode 100644 bloom.c
 create mode 100644 bloom.h
 create mode 100644 t/helper/test-bloom.c
 create mode 100755 t/t0095-bloom.sh
 create mode 100755 t/t4216-log-bloom.sh


base-commit: 3bab5d56259722843359702bc27111475437ad2a
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-497%2Fgarimasi514%2FcoreGit-bloomFilters-v3
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-497/garimasi514/coreGit-bloomFilters-v3
Pull-Request: https://github.com/gitgitgadget/git/pull/497

Range-diff vs v2:

  1:  bf6b93878af !  1:  c3ffd9820d5 commit-graph: use MAX_NUM_CHUNKS
     @@ -1,10 +1,12 @@
      Author: Garima Singh <garima.singh@microsoft.com>
      
     -    commit-graph: use MAX_NUM_CHUNKS
     +    commit-graph: define and use MAX_NUM_CHUNKS
      
     -    This is a minor cleanup to make it easier to change the
     -    number of chunks being written to the commit-graph in the future.
     +    This is a minor cleanup to make it easier to change
     +    the number of chunks being written to the commit
     +    graph.
      
     +    Reviewed-by: Jakub Narębski <jnareb@gmail.com>
          Signed-off-by: Garima Singh <garima.singh@microsoft.com>
      
       diff --git a/commit-graph.c b/commit-graph.c
  -:  ----------- >  2:  a5aa3415c05 bloom.c: add the murmur3 hash implementation
  -:  ----------- >  3:  a7702c1afde bloom.c: introduce core Bloom filter constructs
  2:  02b16d94227 !  4:  8304c297520 bloom: core Bloom filter implementation for changed paths
     @@ -1,89 +1,33 @@
      Author: Garima Singh <garima.singh@microsoft.com>
      
     -    bloom: core Bloom filter implementation for changed paths
     +    bloom.c: core Bloom filter implementation for changed paths.
      
     -    Add the core Bloom filter logic for computing the paths changed between a
     -    commit and its first parent. For details on what Bloom filters are and how they
     -    work, please refer to Dr. Derrick Stolee's blog post [1]. It provides a concise
     -    explaination of the adoption of Bloom filters as described in [2] and [3]
     +    Add the core implementation for computing Bloom filters for
     +    the paths changed between a commit and it's first parent.
      
     -    1. We currently use 7 and 10 for the number of hashes and the size of each
     -       entry respectively. They served as great starting values, the mathematical
     -       details behind this choice are described in [1] and [4]. The implementation
     -       while not completely open to it at the moment, is flexible enough to allow
     -       for tweaking these settings in the future.
     +    We fill the Bloom filters as (const char *data, int len) pairs
     +    as `struct bloom_filters" within a commit slab.
      
     -       Note: The performance gains we have observed with these values are
     -       significant enough that we did not need to tweak these settings.
     -       The performance numbers are included in the cover letter of this series
     -       and in the message of a subsequent commit where we use Bloom filters in
     -       to speed up `git log -- <path>`.
     -
     -    2. As described in the blog and in [3], we do not need 7 independent hashing
     -       functions. We use the Murmur3 hashing scheme. Seed it twice and then
     -       combine those to procure an arbitrary number of hash values.
     -
     -    3. The filters are sized according to the number of changes in the each commit,
     -       with minimum size of one 64 bit word.
     -
     -    4. We fill the Bloom filters as (const char *data, int len) pairs as
     -       "struct bloom_filter"s in a commit slab.
     -
     -    5. The seed_murmur3 method is implemented as described in [5]. It hashes the
     -       given data using a given seed and produces a uniformly distributed hash
     -       value.
     -
     -    [1] https://devblogs.microsoft.com/devops/super-charging-the-git-commit-graph-iv-Bloom-filters/
     -
     -    [2] Flavio Bonomi, Michael Mitzenmacher, Rina Panigrahy, Sushil Singh, George Varghese
     -        "An Improved Construction for Counting Bloom Filters"
     -        http://theory.stanford.edu/~rinap/papers/esa2006b.pdf
     -        https://doi.org/10.1007/11841036_61
     -
     -    [3] Peter C. Dillinger and Panagiotis Manolios
     -        "Bloom Filters in Probabilistic Verification"
     -        http://www.ccs.neu.edu/home/pete/pub/Bloom-filters-verification.pdf
     -        https://doi.org/10.1007/978-3-540-30494-4_26
     -
     -    [4] Thomas Mueller Graf, Daniel Lemire
     -        "Xor Filters: Faster and Smaller Than Bloom and Cuckoo Filters"
     -        https://arxiv.org/abs/1912.08258
     -
     -    [5] https://en.wikipedia.org/wiki/MurmurHash#Algorithm
     +    Filters for commits with no changes and more than 512 changes,
     +    is represented with a filter of length zero. There is no gain
     +    in distinguishing between a computed filter of length zero for
     +    a commit with no changes, and an uncomputed filter for new commits
     +    or for commits with more than 512 changes. The effect on
     +    `git log -- path` is the same in both cases. We will fall back to
     +    the normal diffing algorithm when we can't benefit from the
     +    existence of Bloom filters.
      
          Helped-by: Jeff King <peff@peff.net>
          Helped-by: Derrick Stolee <dstolee@microsoft.com>
     +    Reviewed-by: Jakub Narębski <jnareb@gmail.com>
          Signed-off-by: Garima Singh <garima.singh@microsoft.com>
      
     - diff --git a/Makefile b/Makefile
     - --- a/Makefile
     - +++ b/Makefile
     -@@
     - 
     - PROGRAMS += $(patsubst %.o,git-%$X,$(PROGRAM_OBJS))
     - 
     -+TEST_BUILTINS_OBJS += test-bloom.o
     - TEST_BUILTINS_OBJS += test-chmtime.o
     - TEST_BUILTINS_OBJS += test-config.o
     - TEST_BUILTINS_OBJS += test-ctype.o
     -@@
     - LIB_OBJS += bisect.o
     - LIB_OBJS += blame.o
     - LIB_OBJS += blob.o
     -+LIB_OBJS += bloom.o
     - LIB_OBJS += branch.o
     - LIB_OBJS += bulk-checkin.o
     - LIB_OBJS += bundle.o
     -
       diff --git a/bloom.c b/bloom.c
     - new file mode 100644
     - --- /dev/null
     + --- a/bloom.c
       +++ b/bloom.c
      @@
     -+#include "git-compat-util.h"
     -+#include "bloom.h"
     -+#include "commit-graph.h"
     -+#include "object-store.h"
     + #include "git-compat-util.h"
     + #include "bloom.h"
      +#include "diff.h"
      +#include "diffcore.h"
      +#include "revision.h"
     @@ -97,118 +41,19 @@
      +    struct hashmap_entry entry;
      +    const char path[FLEX_ARRAY];
      +};
     + 
     + static uint32_t rotate_left(uint32_t value, int32_t count)
     + {
     +@@
     + 		filter->data[block_pos] |= get_bitmask(hash_mod);
     + 	}
     + }
      +
     -+static uint32_t rotate_right(uint32_t value, int32_t count)
     -+{
     -+	uint32_t mask = 8 * sizeof(uint32_t) - 1;
     -+	count &= mask;
     -+	return ((value >> count) | (value << ((-count) & mask)));
     -+}
     -+
     -+/*
     -+ * Calculate a hash value for the given data using the given seed.
     -+ * Produces a uniformly distributed hash value.
     -+ * Not considered to be cryptographically secure.
     -+ * Implemented as described in https://en.wikipedia.org/wiki/MurmurHash#Algorithm
     -+ **/
     -+static uint32_t seed_murmur3(uint32_t seed, const char *data, int len)
     -+{
     -+	const uint32_t c1 = 0xcc9e2d51;
     -+	const uint32_t c2 = 0x1b873593;
     -+	const uint32_t r1 = 15;
     -+	const uint32_t r2 = 13;
     -+	const uint32_t m = 5;
     -+	const uint32_t n = 0xe6546b64;
     -+	int i;
     -+	uint32_t k1 = 0;
     -+	const char *tail;
     -+
     -+	int len4 = len / sizeof(uint32_t);
     -+
     -+	const uint32_t *blocks = (const uint32_t*)data;
     -+
     -+	uint32_t k;
     -+	for (i = 0; i < len4; i++)
     -+	{
     -+		k = blocks[i];
     -+		k *= c1;
     -+		k = rotate_right(k, r1);
     -+		k *= c2;
     -+
     -+		seed ^= k;
     -+		seed = rotate_right(seed, r2) * m + n;
     -+	}
     -+
     -+	tail = (data + len4 * sizeof(uint32_t));
     -+
     -+	switch (len & (sizeof(uint32_t) - 1))
     -+	{
     -+	case 3:
     -+		k1 ^= ((uint32_t)tail[2]) << 16;
     -+		/*-fallthrough*/
     -+	case 2:
     -+		k1 ^= ((uint32_t)tail[1]) << 8;
     -+		/*-fallthrough*/
     -+	case 1:
     -+		k1 ^= ((uint32_t)tail[0]) << 0;
     -+		k1 *= c1;
     -+		k1 = rotate_right(k1, r1);
     -+		k1 *= c2;
     -+		seed ^= k1;
     -+		break;
     -+	}
     -+
     -+	seed ^= (uint32_t)len;
     -+	seed ^= (seed >> 16);
     -+	seed *= 0x85ebca6b;
     -+	seed ^= (seed >> 13);
     -+	seed *= 0xc2b2ae35;
     -+	seed ^= (seed >> 16);
     -+
     -+	return seed;
     -+}
     -+
     -+static inline uint64_t get_bitmask(uint32_t pos)
     -+{
     -+	return ((uint64_t)1) << (pos & (BITS_PER_WORD - 1));
     -+}
     -+
     -+void load_bloom_filters(void)
     ++void init_bloom_filters(void)
      +{
      +	init_bloom_filter_slab(&bloom_filters);
      +}
      +
     -+void fill_bloom_key(const char *data,
     -+					int len,
     -+					struct bloom_key *key,
     -+					struct bloom_filter_settings *settings)
     -+{
     -+	int i;
     -+	const uint32_t seed0 = 0x293ae76f;
     -+	const uint32_t seed1 = 0x7e646e2c;
     -+	const uint32_t hash0 = seed_murmur3(seed0, data, len);
     -+	const uint32_t hash1 = seed_murmur3(seed1, data, len);
     -+
     -+	key->hashes = (uint32_t *)xcalloc(settings->num_hashes, sizeof(uint32_t));
     -+	for (i = 0; i < settings->num_hashes; i++)
     -+		key->hashes[i] = hash0 + i * hash1;
     -+}
     -+
     -+void add_key_to_filter(struct bloom_key *key,
     -+					   struct bloom_filter *filter,
     -+					   struct bloom_filter_settings *settings)
     -+{
     -+	int i;
     -+	uint64_t mod = filter->len * BITS_PER_WORD;
     -+
     -+	for (i = 0; i < settings->num_hashes; i++) {
     -+		uint64_t hash_mod = key->hashes[i] % mod;
     -+		uint64_t block_pos = hash_mod / BITS_PER_WORD;
     -+
     -+		filter->data[block_pos] |= get_bitmask(hash_mod);
     -+	}
     -+}
     -+
      +struct bloom_filter *get_bloom_filter(struct repository *r,
      +				      struct commit *c)
      +{
     @@ -217,7 +62,7 @@
      +	int i;
      +	struct diff_options diffopt;
      +
     -+	if (!bloom_filters.slab_size)
     ++	if (bloom_filters.slab_size == 0)
      +		return NULL;
      +
      +	filter = bloom_filter_slab_at(&bloom_filters, c);
     @@ -234,13 +79,12 @@
      +
      +	if (diff_queued_diff.nr <= 512) {
      +		struct hashmap pathmap;
     -+		struct pathmap_hash_entry* e;
     ++		struct pathmap_hash_entry *e;
      +		struct hashmap_iter iter;
      +		hashmap_init(&pathmap, NULL, NULL, 0);
      +
      +		for (i = 0; i < diff_queued_diff.nr; i++) {
     -+			const char* path = diff_queued_diff.queue[i]->two->path;
     -+			const char* p = path;
     ++			const char *path = diff_queued_diff.queue[i]->two->path;
      +
      +			/*
      +			* Add each leading directory of the changed file, i.e. for
     @@ -251,23 +95,23 @@
      +			* Note that directories are added without the trailing '/'.
      +			*/
      +			do {
     -+				char* last_slash = strrchr(p, '/');
     ++				char *last_slash = strrchr(path, '/');
      +
      +				FLEX_ALLOC_STR(e, path, path);
     -+				hashmap_entry_init(&e->entry, strhash(p));
     ++				hashmap_entry_init(&e->entry, strhash(path));
      +				hashmap_add(&pathmap, &e->entry);
      +
      +				if (!last_slash)
     -+					last_slash = (char*)p;
     ++					last_slash = (char*)path;
      +				*last_slash = '\0';
      +
     -+			} while (*p);
     ++			} while (*path);
      +
      +			diff_free_filepair(diff_queued_diff.queue[i]);
      +		}
      +
      +		filter->len = (hashmap_get_size(&pathmap) * settings.bits_per_entry + BITS_PER_WORD - 1) / BITS_PER_WORD;
     -+		filter->data = xcalloc(filter->len, sizeof(uint64_t));
     ++		filter->data = xcalloc(filter->len, sizeof(unsigned char));
      +
      +		hashmap_for_each_entry(&pathmap, &iter, e, entry) {
      +			struct bloom_key key;
     @@ -287,138 +131,48 @@
      +	DIFF_QUEUE_CLEAR(&diff_queued_diff);
      +
      +	return filter;
     -+}
     -+
     -+int bloom_filter_contains(struct bloom_filter *filter,
     -+			  struct bloom_key *key,
     -+			  struct bloom_filter_settings *settings)
     -+{
     -+	int i;
     -+	uint64_t mod = filter->len * BITS_PER_WORD;
     -+
     -+	if (!mod)
     -+		return -1;
     -+
     -+	for (i = 0; i < settings->num_hashes; i++) {
     -+		uint64_t hash_mod = key->hashes[i] % mod;
     -+		uint64_t block_pos = hash_mod / BITS_PER_WORD;
     -+		if (!(filter->data[block_pos] & get_bitmask(hash_mod)))
     -+			return 0;
     -+	}
     -+
     -+	return 1;
      +}
      
       diff --git a/bloom.h b/bloom.h
     - new file mode 100644
     - --- /dev/null
     + --- a/bloom.h
       +++ b/bloom.h
      @@
     -+#ifndef BLOOM_H
     -+#define BLOOM_H
     -+
     + #ifndef BLOOM_H
     + #define BLOOM_H
     + 
      +struct commit;
      +struct repository;
     -+struct commit_graph;
     -+
     -+struct bloom_filter_settings {
     -+	uint32_t hash_version;
     -+	uint32_t num_hashes;
     -+	uint32_t bits_per_entry;
     -+};
     -+
     -+#define DEFAULT_BLOOM_FILTER_SETTINGS { 1, 7, 10 }
     -+#define BITS_PER_WORD 64
      +
     -+/*
     -+ * A bloom_filter struct represents a data segment to
     -+ * use when testing hash values. The 'len' member
     -+ * dictates how many uint64_t entries are stored in
     -+ * 'data'.
     -+ */
     -+struct bloom_filter {
     -+	uint64_t *data;
     -+	int len;
     -+};
     -+
     -+/*
     -+ * A bloom_key represents the k hash values for a
     -+ * given hash input. These can be precomputed and
     -+ * stored in a bloom_key for re-use when testing
     -+ * against a bloom_filter.
     -+ */
     -+struct bloom_key {
     -+	uint32_t *hashes;
     -+};
     -+
     -+void load_bloom_filters(void);
     -+
     -+void fill_bloom_key(const char *data,
     -+		    int len,
     -+		    struct bloom_key *key,
     -+		    struct bloom_filter_settings *settings);
     -+
     -+void add_key_to_filter(struct bloom_key *key,
     -+					   struct bloom_filter *filter,
     -+					   struct bloom_filter_settings *settings);
     + struct bloom_filter_settings {
     + 	/*
     + 	 * The version of the hashing technique being used.
     +@@
     + 					   struct bloom_filter *filter,
     + 					   const struct bloom_filter_settings *settings);
     + 
     ++void init_bloom_filters(void);
      +
      +struct bloom_filter *get_bloom_filter(struct repository *r,
      +				      struct commit *c);
      +
     -+int bloom_filter_contains(struct bloom_filter *filter,
     -+			  struct bloom_key *key,
     -+			  struct bloom_filter_settings *settings);
     -+
     -+#endif
     + #endif
     + \ No newline at end of file
      
       diff --git a/t/helper/test-bloom.c b/t/helper/test-bloom.c
     - new file mode 100644
     - --- /dev/null
     + --- a/t/helper/test-bloom.c
       +++ b/t/helper/test-bloom.c
      @@
     -+#include "test-tool.h"
     -+#include "git-compat-util.h"
     -+#include "bloom.h"
     -+#include "test-tool.h"
     -+#include "cache.h"
     -+#include "commit-graph.h"
     + #include "git-compat-util.h"
     + #include "bloom.h"
     + #include "test-tool.h"
      +#include "commit.h"
     -+#include "config.h"
     -+#include "object-store.h"
     -+#include "object.h"
     -+#include "repository.h"
     -+#include "tree.h"
     -+
     -+struct bloom_filter_settings settings = DEFAULT_BLOOM_FILTER_SETTINGS;
     -+
     -+static void print_bloom_filter(struct bloom_filter *filter) {
     -+	int i;
     -+
     -+	if (!filter) {
     -+		printf("No filter.\n");
     -+		return;
     -+	}
     -+	printf("Filter_Length:%d\n", filter->len);
     -+	printf("Filter_Data:");
     -+	for (i = 0; i < filter->len; i++){
     -+		printf("%"PRIx64"|", filter->data[i]);
     -+	}
     -+	printf("\n");
     -+}
     -+
     -+static void add_string_to_filter(const char *data, struct bloom_filter *filter) {
     -+		struct bloom_key key;
     -+		int i;
     -+
     -+		fill_bloom_key(data, strlen(data), &key, &settings);
     -+		printf("Hashes:");
     -+		for (i = 0; i < settings.num_hashes; i++){
     -+			printf("%08x|", key.hashes[i]);
     -+		}
     -+		printf("\n");
     -+		add_key_to_filter(&key, filter, &settings);
     -+}
     -+
     + 
     + struct bloom_filter_settings settings = DEFAULT_BLOOM_FILTER_SETTINGS;
     + 
     +@@
     + 	printf("\n");
     + }
     + 
      +static void get_bloom_filter_for_commit(const struct object_id *commit_oid)
      +{
      +	struct commit *c;
     @@ -429,72 +183,33 @@
      +	print_bloom_filter(filter);
      +}
      +
     -+int cmd__bloom(int argc, const char **argv)
     -+{
     -+    if (!strcmp(argv[1], "generate_filter")) {
     -+		struct bloom_filter filter;
     -+		int i = 2;
     -+		filter.len =  (settings.bits_per_entry + BITS_PER_WORD - 1) / BITS_PER_WORD;
     -+		filter.data = xcalloc(filter.len, sizeof(uint64_t));
     -+
     -+		if (!argv[2]){
     -+			die("at least one input string expected");
     -+		}
     -+
     -+		while (argv[i]) {
     -+			add_string_to_filter(argv[i], &filter);
     -+			i++;
     -+		}
     -+
     -+		print_bloom_filter(&filter);
     -+	}
     -+
     -+	if (!strcmp(argv[1], "get_filter_for_commit")) {
     + int cmd__bloom(int argc, const char **argv)
     + {
     + 	if (!strcmp(argv[1], "get_murmur3")) {
     +@@
     + 		print_bloom_filter(&filter);
     + 	}
     + 
     ++    if (!strcmp(argv[1], "get_filter_for_commit")) {
      +		struct object_id oid;
      +		const char *end;
      +		if (parse_oid_hex(argv[2], &oid, &end))
      +			die("cannot parse oid '%s'", argv[2]);
     -+		load_bloom_filters();
     ++		init_bloom_filters();
      +		get_bloom_filter_for_commit(&oid);
      +	}
      +
     -+	return 0;
     -+}
     -
     - diff --git a/t/helper/test-tool.c b/t/helper/test-tool.c
     - --- a/t/helper/test-tool.c
     - +++ b/t/helper/test-tool.c
     -@@
     - };
     - 
     - static struct test_cmd cmds[] = {
     -+	{ "bloom", cmd__bloom },
     - 	{ "chmtime", cmd__chmtime },
     - 	{ "config", cmd__config },
     - 	{ "ctype", cmd__ctype },
     -
     - diff --git a/t/helper/test-tool.h b/t/helper/test-tool.h
     - --- a/t/helper/test-tool.h
     - +++ b/t/helper/test-tool.h
     -@@
     - #define USE_THE_INDEX_COMPATIBILITY_MACROS
     - #include "git-compat-util.h"
     - 
     -+int cmd__bloom(int argc, const char **argv);
     - int cmd__chmtime(int argc, const char **argv);
     - int cmd__config(int argc, const char **argv);
     - int cmd__ctype(int argc, const char **argv);
     + 	return 0;
     + }
     + \ No newline at end of file
      
       diff --git a/t/t0095-bloom.sh b/t/t0095-bloom.sh
     - new file mode 100755
     - --- /dev/null
     + --- a/t/t0095-bloom.sh
       +++ b/t/t0095-bloom.sh
      @@
     -+#!/bin/sh
     -+
     -+test_description='test bloom.c'
     -+. ./test-lib.sh
     -+
     + 	test_cmp expect actual
     + '
     + 
      +test_expect_success 'get bloom filters for commit with no changes' '
      +	git init &&
      +	git commit --allow-empty -m "c0" &&
     @@ -517,8 +232,8 @@
      +	git add smallDir &&
      +	git commit -m "commit with 10 changes" &&
      +	cat >expect <<-\EOF &&
     -+	Filter_Length:4
     -+	Filter_Data:508928809087080a|8a7648210804001|4089824400951000|841ab310098051a8|
     ++	Filter_Length:25
     ++	Filter_Data:82|a0|65|47|0c|92|90|c0|a1|40|02|a0|e2|40|e0|04|0a|9a|66|cf|80|19|85|42|23|
      +	EOF
      +	test-tool bloom get_filter_for_commit "$(git rev-parse HEAD)" >actual &&
      +	test_cmp expect actual
     @@ -542,64 +257,5 @@
      +	test_cmp expect actual
      +'
      +
     -+test_expect_success 'compute bloom key for empty string' '
     -+	cat >expect <<-\EOF &&
     -+	Hashes:5615800c|5b966560|61174ab4|66983008|6c19155c|7199fab0|771ae004|
     -+	Filter_Length:1
     -+	Filter_Data:11000110001110|
     -+	EOF
     -+	test-tool bloom generate_filter "" >actual &&
     -+	test_cmp expect actual
     -+'
     -+
     -+test_expect_success 'compute bloom key for whitespace' '
     -+	cat >expect <<-\EOF &&
     -+	Hashes:1bf014e6|8a91b50b|f9335530|67d4f555|d676957a|4518359f|b3b9d5c4|
     -+	Filter_Length:1
     -+	Filter_Data:401004080200810|
     -+	EOF
     -+	test-tool bloom generate_filter " " >actual &&
     -+	test_cmp expect actual
     -+'
     -+
     -+test_expect_success 'compute bloom key for a root level folder' '
     -+	cat >expect <<-\EOF &&
     -+	Hashes:1a21016f|fff1c06d|e5c27f6b|cb933e69|b163fd67|9734bc65|7d057b63|
     -+	Filter_Length:1
     -+	Filter_Data:aaa800000000|
     -+	EOF
     -+	test-tool bloom generate_filter "A" >actual &&
     -+	test_cmp expect actual
     -+'
     -+
     -+test_expect_success 'compute bloom key for a root level file' '
     -+	cat >expect <<-\EOF &&
     -+	Hashes:e2d51107|30970605|7e58fb03|cc1af001|19dce4ff|679ed9fd|b560cefb|
     -+	Filter_Length:1
     -+	Filter_Data:a8000000000000aa|
     -+	EOF
     -+	test-tool bloom generate_filter "file.txt" >actual &&
     -+	test_cmp expect actual
     -+'
     -+
     -+test_expect_success 'compute bloom key for a deep folder' '
     -+	cat >expect <<-\EOF &&
     -+	Hashes:864cf838|27f055cd|c993b362|6b3710f7|0cda6e8c|ae7dcc21|502129b6|
     -+	Filter_Length:1
     -+	Filter_Data:1c0000600003000|
     -+	EOF
     -+	test-tool bloom generate_filter "A/B/C/D/E" >actual &&
     -+	test_cmp expect actual
     -+'
     -+
     -+test_expect_success 'compute bloom key for a deep file' '
     -+	cat >expect <<-\EOF &&
     -+	Hashes:07cdf850|4af629c7|8e1e5b3e|d1468cb5|146ebe2c|5796efa3|9abf211a|
     -+	Filter_Length:1
     -+	Filter_Data:4020100804010080|
     -+	EOF
     -+	test-tool bloom generate_filter "A/B/C/D/E/file.txt" >actual &&
     -+	test_cmp expect actual
     -+'
     -+
     -+test_done
     + test_done
     + \ No newline at end of file
  3:  a698c04a78c !  5:  2d4c0b2da38 diff: halt tree-diff early after max_changes
     @@ -29,7 +29,7 @@
       	struct diff_options diffopt;
      +	int max_changes = 512;
       
     - 	if (!bloom_filters.slab_size)
     + 	if (bloom_filters.slab_size == 0)
       		return NULL;
      @@
       
     @@ -46,7 +46,7 @@
      -	if (diff_queued_diff.nr <= 512) {
      +	if (diff_queued_diff.nr <= max_changes) {
       		struct hashmap pathmap;
     - 		struct pathmap_hash_entry* e;
     + 		struct pathmap_hash_entry *e;
       		struct hashmap_iter iter;
      
       diff --git a/diff.h b/diff.h
  4:  c17bbcbc66e !  6:  c38b9b386ef commit-graph: compute Bloom filters for changed paths
     @@ -2,11 +2,13 @@
      
          commit-graph: compute Bloom filters for changed paths
      
     -    Compute Bloom filters for the paths that changed between a commit and its
     -    first parent using the implementation in bloom.c, when the
     -    COMMIT_GRAPH_WRITE_CHANGED_PATHS flag is set. This computation is done on a
     -    commit-by-commit basis. We will write these Bloom filters to the commit graph
     -    file in the next change.
     +    Add new COMMIT_GRAPH_WRITE_CHANGED_PATHS flag that makes Git compute
     +    Bloom filters for the paths that changed between a commit and it's
     +    first parent, for each commit in the commit-graph.  This computation
     +    is done on a commit-by-commit basis.
     +
     +    We will write these Bloom filters to the commit-graph file, to store
     +    this data on disk, in the next change in this series.
      
          Helped-by: Derrick Stolee <dstolee@microsoft.com>
          Signed-off-by: Garima Singh <garima.singh@microsoft.com>
     @@ -31,7 +33,7 @@
      +		 changed_paths:1;
       
       	const struct split_commit_graph_opts *split_opts;
     -+	uint32_t total_bloom_filter_data_size;
     ++	size_t total_bloom_filter_data_size;
       };
       
       static void write_graph_chunk_fanout(struct hashfile *f,
     @@ -44,17 +46,17 @@
      +	int i;
      +	struct progress *progress = NULL;
      +
     -+	load_bloom_filters();
     ++	init_bloom_filters();
      +
      +	if (ctx->report_progress)
     -+		progress = start_progress(
     -+			_("Computing commit diff Bloom filters"),
     ++		progress = start_delayed_progress(
     ++			_("Computing commit changed paths Bloom filters"),
      +			ctx->commits.nr);
      +
      +	for (i = 0; i < ctx->commits.nr; i++) {
      +		struct commit *c = ctx->commits.list[i];
      +		struct bloom_filter *filter = get_bloom_filter(ctx->r, c);
     -+		ctx->total_bloom_filter_data_size += sizeof(uint64_t) * filter->len;
     ++		ctx->total_bloom_filter_data_size += sizeof(unsigned char) * filter->len;
      +		display_progress(progress, i + 1);
      +	}
      +
     @@ -93,7 +95,7 @@
       	/* Make sure that each OID in the input is a valid commit OID. */
      -	COMMIT_GRAPH_WRITE_CHECK_OIDS = (1 << 3)
      +	COMMIT_GRAPH_WRITE_CHECK_OIDS = (1 << 3),
     -+	COMMIT_GRAPH_WRITE_BLOOM_FILTERS = (1 << 4)
     ++	COMMIT_GRAPH_WRITE_BLOOM_FILTERS = (1 << 4),
       };
       
       struct split_commit_graph_opts {
  5:  78e8e49c3a1 !  7:  d24c85c54ef commit-graph: examine changed-path objects in pack order
     @@ -39,6 +39,7 @@
       /* Remember to update object flag allocation in object.h */
       #define REACHABLE       (1u<<15)
       
     +-char *get_commit_graph_filename(struct object_directory *odb)
      +/* Keep track of the order in which commits are added to our list. */
      +define_commit_slab(commit_pos, int);
      +static struct commit_pos commit_pos = COMMIT_SLAB_INIT(1, commit_pos);
     @@ -55,16 +56,20 @@
      +}
      +
      +static int commit_pos_cmp(const void *va, const void *vb)
     -+{
     + {
     +-	return xstrfmt("%s/info/commit-graph", odb->path);
      +	const struct commit *a = *(const struct commit **)va;
      +	const struct commit *b = *(const struct commit **)vb;
      +	return commit_pos_at(&commit_pos, a) -
      +	       commit_pos_at(&commit_pos, b);
      +}
      +
     - char *get_commit_graph_filename(const char *obj_dir)
     - {
     - 	char *filename = xstrfmt("%s/info/commit-graph", obj_dir);
     ++char *get_commit_graph_filename(struct object_directory *obj_dir)
     ++{
     ++	return xstrfmt("%s/info/commit-graph", obj_dir->path);
     + }
     + 
     + static char *get_split_graph_filename(struct object_directory *odb,
      @@
       	oidcpy(&(ctx->oids.list[ctx->oids.nr]), oid);
       	ctx->oids.nr++;
     @@ -78,27 +83,27 @@
       {
       	int i;
       	struct progress *progress = NULL;
     -+	struct commit **sorted_by_pos;
     ++	struct commit **sorted_commits;
       
     - 	load_bloom_filters();
     + 	init_bloom_filters();
       
      @@
     - 			_("Computing commit diff Bloom filters"),
     + 			_("Computing commit changed paths Bloom filters"),
       			ctx->commits.nr);
       
     -+	ALLOC_ARRAY(sorted_by_pos, ctx->commits.nr);
     -+	COPY_ARRAY(sorted_by_pos, ctx->commits.list, ctx->commits.nr);
     -+	QSORT(sorted_by_pos, ctx->commits.nr, commit_pos_cmp);
     ++	ALLOC_ARRAY(sorted_commits, ctx->commits.nr);
     ++	COPY_ARRAY(sorted_commits, ctx->commits.list, ctx->commits.nr);
     ++	QSORT(sorted_commits, ctx->commits.nr, commit_pos_cmp);
      +
       	for (i = 0; i < ctx->commits.nr; i++) {
      -		struct commit *c = ctx->commits.list[i];
     -+		struct commit *c = sorted_by_pos[i];
     ++		struct commit *c = sorted_commits[i];
       		struct bloom_filter *filter = get_bloom_filter(ctx->r, c);
     - 		ctx->total_bloom_filter_data_size += sizeof(uint64_t) * filter->len;
     + 		ctx->total_bloom_filter_data_size += sizeof(unsigned char) * filter->len;
       		display_progress(progress, i + 1);
       	}
       
     -+	free(sorted_by_pos);
     ++	free(sorted_commits);
       	stop_progress(&progress);
       }
       
  6:  58704d81b6b !  8:  5ed16f35fed commit-graph: examine commits by generation number
     @@ -1,11 +1,11 @@
     -Author: Derrick Stolee <dstolee@microsoft.com>
     +Author: Garima Singh <garima.singh@microsoft.com>
      
          commit-graph: examine commits by generation number
      
          When running 'git commit-graph write --changed-paths', we sort the
          commits by pack-order to save time when computing the changed-paths
          bloom filters. This does not help when finding the commits via the
     -    --reachable flag.
     +    '--reachable' flag.
      
          If not using pack-order, then sort by generation number before
          examining the diff. Commits with similar generation are more likely
     @@ -45,9 +45,9 @@
      +	return 0;
      +}
      +
     - char *get_commit_graph_filename(const char *obj_dir)
     + char *get_commit_graph_filename(struct object_directory *obj_dir)
       {
     - 	char *filename = xstrfmt("%s/info/commit-graph", obj_dir);
     + 	return xstrfmt("%s/info/commit-graph", obj_dir->path);
      @@
       		 report_progress:1,
       		 split:1,
     @@ -57,20 +57,20 @@
      +		 order_by_pack:1;
       
       	const struct split_commit_graph_opts *split_opts;
     - 	uint32_t total_bloom_filter_data_size;
     + 	size_t total_bloom_filter_data_size;
      @@
       
     - 	ALLOC_ARRAY(sorted_by_pos, ctx->commits.nr);
     - 	COPY_ARRAY(sorted_by_pos, ctx->commits.list, ctx->commits.nr);
     --	QSORT(sorted_by_pos, ctx->commits.nr, commit_pos_cmp);
     + 	ALLOC_ARRAY(sorted_commits, ctx->commits.nr);
     + 	COPY_ARRAY(sorted_commits, ctx->commits.list, ctx->commits.nr);
     +-	QSORT(sorted_commits, ctx->commits.nr, commit_pos_cmp);
      +
      +	if (ctx->order_by_pack)
     -+		QSORT(sorted_by_pos, ctx->commits.nr, commit_pos_cmp);
     ++		QSORT(sorted_commits, ctx->commits.nr, commit_pos_cmp);
      +	else
     -+		QSORT(sorted_by_pos, ctx->commits.nr, commit_gen_cmp);
     ++		QSORT(sorted_commits, ctx->commits.nr, commit_gen_cmp);
       
       	for (i = 0; i < ctx->commits.nr; i++) {
     - 		struct commit *c = sorted_by_pos[i];
     + 		struct commit *c = sorted_commits[i];
      @@
       	}
       
  -:  ----------- >  9:  55824cda89c diff: skip batch object download when possible
  7:  39ee0610800 ! 10:  1e4663523de commit-graph: write Bloom filters to commit graph file
     @@ -2,9 +2,10 @@
      
          commit-graph: write Bloom filters to commit graph file
      
     -    Update the technical documentation for commit-graph-format with the formats for
     -    the Bloom filter index (BIDX) and Bloom filter data (BDAT) chunks. Write the
     -    computed Bloom filters information to the commit graph file using this format.
     +    Update the technical documentation for commit-graph-format with
     +    the formats for the Bloom filter index (BIDX) and Bloom filter
     +    data (BDAT) chunks. Write the computed Bloom filters information
     +    to the commit graph file using this format.
      
          Helped-by: Derrick Stolee <dstolee@microsoft.com>
          Signed-off-by: Garima Singh <garima.singh@microsoft.com>
     @@ -17,7 +18,7 @@
         the graph file.
       
      +- The Bloom filter of the commit carrying the paths that were changed between
     -+  the commit and its first parent.
     ++  the commit and its first parent, if requested.
      +
       These positional references are stored as unsigned 32-bit integers
       corresponding to the array position within the list of commit OIDs. Due
     @@ -36,16 +37,22 @@
      +  Bloom Filter Data (ID: {'B', 'D', 'A', 'T'}) [Optional]
      +    * It starts with header consisting of three unsigned 32-bit integers:
      +      - Version of the hash algorithm being used. We currently only support
     -+	value 1 which implies the murmur3 hash implemented exactly as described
     -+	in https://en.wikipedia.org/wiki/MurmurHash#Algorithm
     ++	value 1 which corresponds to the 32-bit version of the murmur3 hash
     ++	implemented exactly as described in
     ++	https://en.wikipedia.org/wiki/MurmurHash#Algorithm and the double
     ++	hashing technique using seed values 0x293ae76f and 0x7e646e2 as
     ++	described in https://doi.org/10.1007/978-3-540-30494-4_26 "Bloom Filters
     ++	in Probabilistic Verification"
      +      - The number of times a path is hashed and hence the number of bit positions
     -+	that cumulatively determine whether a file is present in the commit.
     ++	      that cumulatively determine whether a file is present in the commit.
      +      - The minimum number of bits 'b' per entry in the Bloom filter. If the filter
     -+	contains 'n' entries, then the filter size is the minimum number of 64-bit
     -+	words that contain n*b bits.
     ++	      contains 'n' entries, then the filter size is the minimum number of 64-bit
     ++	      words that contain n*b bits.
      +    * The rest of the chunk is the concatenation of all the computed Bloom
      +      filters for the commits in lexicographic order.
     -+    * The BDAT chunk is present iff BIDX is present.
     ++    * Note: Commits with no changes or more than 512 changes have Bloom filters
     ++      of length zero.
     ++    * The BDAT chunk is present if and only if BIDX is present.
      +
         Base Graphs List (ID: {'B', 'A', 'S', 'E'}) [Optional]
             This list of H-byte hashes describe a set of B commit-graph files that
     @@ -103,16 +110,14 @@
       		last_chunk_offset = chunk_offset;
       	}
       
     -+	/* We need both the bloom chunks to exist together. Else ignore the data */
     -+	if ((graph->chunk_bloom_indexes && !graph->chunk_bloom_data)
     -+		 || (!graph->chunk_bloom_indexes && graph->chunk_bloom_data)) {
     ++	if (graph->chunk_bloom_indexes && graph->chunk_bloom_data) {
     ++		init_bloom_filters();
     ++	} else {
     ++		/* We need both the bloom chunks to exist together. Else ignore the data */
      +		graph->chunk_bloom_indexes = NULL;
      +		graph->chunk_bloom_data = NULL;
      +		graph->bloom_filter_settings = NULL;
      +	}
     -+
     -+	if (graph->chunk_bloom_indexes && graph->chunk_bloom_data)
     -+		load_bloom_filters();
      +
       	hashcpy(graph->oid.hash, graph->data + graph->data_len - graph->hash_len);
       
     @@ -148,7 +153,7 @@
      +
      +static void write_graph_chunk_bloom_data(struct hashfile *f,
      +					 struct write_commit_graph_context *ctx,
     -+					 struct bloom_filter_settings *settings)
     ++					 const struct bloom_filter_settings *settings)
      +{
      +	struct commit **list = ctx->commits.list;
      +	struct commit **last = ctx->commits.list + ctx->commits.nr;
     @@ -167,7 +172,7 @@
      +	while (list < last) {
      +		struct bloom_filter *filter = get_bloom_filter(ctx->r, *list);
      +		display_progress(progress, ++i);
     -+		hashwrite(f, filter->data, filter->len * sizeof(uint64_t));
     ++		hashwrite(f, filter->data, filter->len * sizeof(unsigned char));
      +		list++;
      +	}
      +
     @@ -177,22 +182,11 @@
       static int oid_compare(const void *_a, const void *_b)
       {
       	const struct object_id *a = (const struct object_id *)_a;
     -@@
     - 	load_bloom_filters();
     - 
     - 	if (ctx->report_progress)
     --		progress = start_progress(
     --			_("Computing commit diff Bloom filters"),
     -+		progress = start_delayed_progress(
     -+			_("Computing changed paths Bloom filters"),
     - 			ctx->commits.nr);
     - 
     - 	ALLOC_ARRAY(sorted_by_pos, ctx->commits.nr);
      @@
       	struct strbuf progress_title = STRBUF_INIT;
       	int num_chunks = 3;
       	struct object_id file_hash;
     -+	struct bloom_filter_settings bloom_settings = DEFAULT_BLOOM_FILTER_SETTINGS;
     ++	const struct bloom_filter_settings bloom_settings = DEFAULT_BLOOM_FILTER_SETTINGS;
       
       	if (ctx->split) {
       		struct strbuf tmp_file = STRBUF_INIT;
     @@ -236,6 +230,14 @@
       	if (ctx->num_commit_graphs_after > 1 &&
       	    write_graph_chunk_base(f, ctx)) {
       		return -1;
     +@@
     + 		close(g->graph_fd);
     + 	}
     + 	free(g->filename);
     ++	free(g->bloom_filter_settings);
     + 	free(g);
     + }
     + 
      
       diff --git a/commit-graph.h b/commit-graph.h
       --- a/commit-graph.h
     @@ -246,7 +248,7 @@
       struct commit;
      +struct bloom_filter_settings;
       
     - char *get_commit_graph_filename(const char *obj_dir);
     + char *get_commit_graph_filename(struct object_directory *odb);
       int open_commit_graph(const char *graph_file, int *fd, struct stat *st);
      @@
       	const unsigned char *chunk_commit_data;
     @@ -258,13 +260,4 @@
      +	struct bloom_filter_settings *bloom_filter_settings;
       };
       
     - struct commit_graph *load_commit_graph_one_fd_st(int fd, struct stat *st);
     -@@
     - 	COMMIT_GRAPH_WRITE_SPLIT      = (1 << 2),
     - 	/* Make sure that each OID in the input is a valid commit OID. */
     - 	COMMIT_GRAPH_WRITE_CHECK_OIDS = (1 << 3),
     --	COMMIT_GRAPH_WRITE_BLOOM_FILTERS = (1 << 4)
     -+	COMMIT_GRAPH_WRITE_BLOOM_FILTERS = (1 << 4),
     - };
     - 
     - struct split_commit_graph_opts {
     + struct commit_graph *load_commit_graph_one_fd_st(int fd, struct stat *st,
  8:  b20c8d2b209 ! 11:  68395d4051b commit-graph: reuse existing Bloom filters during write.
     @@ -1,9 +1,10 @@
      Author: Garima Singh <garima.singh@microsoft.com>
      
     -    commit-graph: reuse existing Bloom filters during write.
     +    commit-graph: reuse existing Bloom filters during write
      
     -    Read previously computed Bloom filters from the commit-graph file if
     -    possible to avoid recomputing during commit-graph write.
     +    Add logic to
     +    a) parse Bloom filter information from the commit graph file and,
     +    b) re-use existing Bloom filters.
      
          See Documentation/technical/commit-graph-format for the format in which
          the Bloom filter information is written to the commit graph file.
     @@ -25,7 +26,7 @@
             commit's filter.
      
          We toggle whether Bloom filters should be recomputed based on the
     -    compute_if_null flag.
     +    compute_if_not_present flag.
      
          Helped-by: Derrick Stolee <dstolee@microsoft.com>
          Signed-off-by: Garima Singh <garima.singh@microsoft.com>
     @@ -34,15 +35,16 @@
       --- a/bloom.c
       +++ b/bloom.c
      @@
     - #include "git-compat-util.h"
     - #include "bloom.h"
     + #include "diffcore.h"
     + #include "revision.h"
     + #include "hashmap.h"
     ++#include "commit-graph.h"
      +#include "commit.h"
     -+#include "commit-slab.h"
     - #include "commit-graph.h"
     - #include "object-store.h"
     - #include "diff.h"
     + 
     + define_commit_slab(bloom_filter_slab, struct bloom_filter);
     + 
      @@
     - 	}
     + 	return ((unsigned char)1) << (pos & (BITS_PER_WORD - 1));
       }
       
      +static int load_bloom_filter_from_graph(struct commit_graph *g,
     @@ -62,23 +64,29 @@
      +
      +	end_index = get_be32(g->chunk_bloom_indexes + 4 * lex_pos);
      +
     -+	if (lex_pos)
     ++	if (lex_pos > 0)
      +		start_index = get_be32(g->chunk_bloom_indexes + 4 * (lex_pos - 1));
      +	else
      +		start_index = 0;
      +
      +	filter->len = end_index - start_index;
     -+	filter->data = (uint64_t *)(g->chunk_bloom_data +
     -+					sizeof(uint64_t) * start_index +
     ++	filter->data = (unsigned char *)(g->chunk_bloom_data +
     ++					sizeof(unsigned char) * start_index +
      +					BLOOMDATA_CHUNK_HEADER_SIZE);
      +
      +	return 1;
      +}
      +
     + /*
     +  * Calculate the murmur3 32-bit hash value for the given data
     +  * using the given seed.
     +@@
     + }
     + 
       struct bloom_filter *get_bloom_filter(struct repository *r,
      -				      struct commit *c)
      +				      struct commit *c,
     -+				      int compute_if_not_present)
     ++					  int compute_if_not_present)
       {
       	struct bloom_filter *filter;
       	struct bloom_filter_settings settings = DEFAULT_BLOOM_FILTER_SETTINGS;
     @@ -102,7 +110,7 @@
      +
       	repo_diff_setup(r, &diffopt);
       	diffopt.flags.recursive = 1;
     - 	diffopt.max_changes = max_changes;
     + 	diffopt.detect_rename = 0;
      
       diff --git a/bloom.h b/bloom.h
       --- a/bloom.h
     @@ -110,21 +118,21 @@
      @@
       
       #define DEFAULT_BLOOM_FILTER_SETTINGS { 1, 7, 10 }
     - #define BITS_PER_WORD 64
     -+#define BLOOMDATA_CHUNK_HEADER_SIZE 3*sizeof(uint32_t)
     + #define BITS_PER_WORD 8
     ++#define BLOOMDATA_CHUNK_HEADER_SIZE 3 * sizeof(uint32_t)
       
       /*
        * A bloom_filter struct represents a data segment to
      @@
     - 					   struct bloom_filter_settings *settings);
     + void init_bloom_filters(void);
       
       struct bloom_filter *get_bloom_filter(struct repository *r,
      -				      struct commit *c);
      +				      struct commit *c,
      +				      int compute_if_not_present);
       
     - int bloom_filter_contains(struct bloom_filter *filter,
     - 			  struct bloom_key *key,
     + #endif
     + \ No newline at end of file
      
       diff --git a/commit-graph.c b/commit-graph.c
       --- a/commit-graph.c
     @@ -145,25 +153,17 @@
      -		struct bloom_filter *filter = get_bloom_filter(ctx->r, *list);
      +		struct bloom_filter *filter = get_bloom_filter(ctx->r, *list, 0);
       		display_progress(progress, ++i);
     - 		hashwrite(f, filter->data, filter->len * sizeof(uint64_t));
     + 		hashwrite(f, filter->data, filter->len * sizeof(unsigned char));
       		list++;
      @@
       
       	for (i = 0; i < ctx->commits.nr; i++) {
     - 		struct commit *c = sorted_by_pos[i];
     + 		struct commit *c = sorted_commits[i];
      -		struct bloom_filter *filter = get_bloom_filter(ctx->r, c);
      +		struct bloom_filter *filter = get_bloom_filter(ctx->r, c, 1);
     - 		ctx->total_bloom_filter_data_size += sizeof(uint64_t) * filter->len;
     + 		ctx->total_bloom_filter_data_size += sizeof(unsigned char) * filter->len;
       		display_progress(progress, i + 1);
       	}
     -@@
     - 		g->data = NULL;
     - 		close(g->graph_fd);
     - 	}
     -+	free(g->bloom_filter_settings);
     - 	free(g->filename);
     - 	free(g);
     - }
      
       diff --git a/t/helper/test-bloom.c b/t/helper/test-bloom.c
       --- a/t/helper/test-bloom.c
  9:  3d7ee0c9695 ! 12:  7e450e45236 commit-graph: add --changed-paths option to write subcommand
     @@ -56,7 +56,7 @@
      +	int enable_changed_paths;
       } opts;
       
     - static int graph_verify(int argc, const char **argv)
     + static struct object_directory *find_odb(struct repository *r,
      @@
       			N_("start walk at commits listed by stdin")),
       		OPT_BOOL(0, "append", &opts.append,
     @@ -74,4 +74,4 @@
      +		flags |= COMMIT_GRAPH_WRITE_BLOOM_FILTERS;
       
       	read_replace_refs = 0;
     - 
     + 	odb = find_odb(the_repository, opts.obj_dir);
 10:  77f1c561e82 ! 13:  b18af58aa3e revision.c: use Bloom filters to speed up path based revision walks
     @@ -2,17 +2,27 @@
      
          revision.c: use Bloom filters to speed up path based revision walks
      
     -    Revision walk will now use Bloom filters for commits to speed up revision
     -    walks for a particular path (for computing history for that path), if they
     -    are present in the commit-graph file.
     +    Revision walk will now use Bloom filters for commits to speed up
     +    revision walks for a particular path (for computing history for
     +    that path), if they are present in the commit-graph file.
      
     -    We load the Bloom filters during the prepare_revision_walk step, but only
     -    when dealing with a single pathspec. While comparing trees in
     -    rev_compare_trees(), if the Bloom filter says that the file is not different
     -    between the two trees, we don't need to compute the expensive diff. This is
     -    where we get our performance gains. The other response of the Bloom filter
     -    is `maybe`, in which case we fall back to the full diff calculation to
     -    determine if the path was changed in the commit.
     +    We load the Bloom filters during the prepare_revision_walk step,
     +    currently only when dealing with a single pathspec. Extending
     +    it to work with multiple pathspecs can be explored and built on
     +    top of this series in the future.
     +
     +    While comparing trees in rev_compare_trees(), if the Bloom filter
     +    says that the file is not different between the two trees, we don't
     +    need to compute the expensive diff. This is where we get our
     +    performance gains. The other response of the Bloom filter is '`:maybe',
     +    in which case we fall back to the full diff calculation to determine
     +    if the path was changed in the commit.
     +
     +    We do not try to use Bloom filters when the '--walk-reflogs' option
     +    is specified. The '--walk-reflogs' option does not walk the commit
     +    ancestry chain like the rest of the options. Incorporating the
     +    performance gains when walking reflog entries would add more
     +    complexity, and can be explored in a later series.
      
          Performance Gains:
          We tested the performance of `git log -- <path>` on the git repo, the linux
     @@ -30,6 +40,49 @@
          Helped-by: Jonathan Tan <jonathantanmy@google.com>
          Signed-off-by: Garima Singh <garima.singh@microsoft.com>
      
     + diff --git a/bloom.c b/bloom.c
     + --- a/bloom.c
     + +++ b/bloom.c
     +@@
     + 
     + 	return filter;
     + }
     ++
     ++int bloom_filter_contains(const struct bloom_filter *filter,
     ++			  const struct bloom_key *key,
     ++			  const struct bloom_filter_settings *settings)
     ++{
     ++	int i;
     ++	uint64_t mod = filter->len * BITS_PER_WORD;
     ++
     ++	if (!mod)
     ++		return -1;
     ++
     ++	for (i = 0; i < settings->num_hashes; i++) {
     ++		uint64_t hash_mod = key->hashes[i] % mod;
     ++		uint64_t block_pos = hash_mod / BITS_PER_WORD;
     ++		if (!(filter->data[block_pos] & get_bitmask(hash_mod)))
     ++			return 0;
     ++	}
     ++
     ++	return 1;
     ++}
     + \ No newline at end of file
     +
     + diff --git a/bloom.h b/bloom.h
     + --- a/bloom.h
     + +++ b/bloom.h
     +@@
     + 				      struct commit *c,
     + 				      int compute_if_not_present);
     + 
     ++int bloom_filter_contains(const struct bloom_filter *filter,
     ++			  const struct bloom_key *key,
     ++			  const struct bloom_filter_settings *settings);
     ++
     + #endif
     + \ No newline at end of file
     +
       diff --git a/revision.c b/revision.c
       --- a/revision.c
       +++ b/revision.c
     @@ -38,7 +91,6 @@
       #include "hashmap.h"
       #include "utf8.h"
      +#include "bloom.h"
     -+#include "json-writer.h"
       
       volatile show_early_output_fn_t show_early_output;
       
     @@ -46,29 +98,6 @@
       	options->flags.has_changes = 1;
       }
       
     -+static int bloom_filter_atexit_registered;
     -+static unsigned int count_bloom_filter_maybe;
     -+static unsigned int count_bloom_filter_definitely_not;
     -+static unsigned int count_bloom_filter_false_positive;
     -+static unsigned int count_bloom_filter_not_present;
     -+static unsigned int count_bloom_filter_length_zero;
     -+
     -+static void trace2_bloom_filter_statistics_atexit(void)
     -+{
     -+	struct json_writer jw = JSON_WRITER_INIT;
     -+
     -+	jw_object_begin(&jw, 0);
     -+	jw_object_intmax(&jw, "filter_not_present", count_bloom_filter_not_present);
     -+	jw_object_intmax(&jw, "zero_length_filter", count_bloom_filter_length_zero);
     -+	jw_object_intmax(&jw, "maybe", count_bloom_filter_maybe);
     -+	jw_object_intmax(&jw, "definitely_not", count_bloom_filter_definitely_not);
     -+	jw_end(&jw);
     -+
     -+	trace2_data_json("bloom", the_repository, "statistics", &jw);
     -+
     -+	jw_release(&jw);
     -+}
     -+
      +static void prepare_to_use_bloom_filter(struct rev_info *revs)
      +{
      +	struct pathspec_item *pi;
     @@ -92,6 +121,7 @@
      +	pi = &revs->pruning.pathspec.items[0];
      +	last_index = pi->len - 1;
      +
     ++	/* remove single trailing slash from path, if needed */
      +	if (pi->match[last_index] == '/') {
      +	    path_alloc = xstrdup(pi->match);
      +	    path_alloc[last_index] = '\0';
     @@ -104,11 +134,6 @@
      +	revs->bloom_key = xmalloc(sizeof(struct bloom_key));
      +	fill_bloom_key(path, len, revs->bloom_key, revs->bloom_filter_settings);
      +
     -+	if (trace2_is_enabled() && !bloom_filter_atexit_registered) {
     -+		atexit(trace2_bloom_filter_statistics_atexit);
     -+		bloom_filter_atexit_registered = 1;
     -+	}
     -+
      +	free(path_alloc);
      +}
      +
     @@ -127,12 +152,10 @@
      +	filter = get_bloom_filter(revs->repo, commit, 0);
      +
      +	if (!filter) {
     -+		count_bloom_filter_not_present++;
      +		return -1;
      +	}
      +
      +	if (!filter->len) {
     -+		count_bloom_filter_length_zero++;
      +		return -1;
      +	}
      +
     @@ -140,11 +163,6 @@
      +				       revs->bloom_key,
      +				       revs->bloom_filter_settings);
      +
     -+	if (result)
     -+		count_bloom_filter_maybe++;
     -+	else
     -+		count_bloom_filter_definitely_not++;
     -+
      +	return result;
      +}
      +
     @@ -162,7 +180,7 @@
       			return REV_TREE_SAME;
       	}
       
     -+	if (revs->pruning.pathspec.nr == 1 && !revs->reflog_info && !nth_parent) {
     ++	if (revs->bloom_key && !nth_parent) {
      +		bloom_ret = check_maybe_different_in_bloom_filter(revs, commit);
      +
      +		if (bloom_ret == 0)
     @@ -174,10 +192,6 @@
       	if (diff_tree_oid(&t1->object.oid, &t2->object.oid, "",
       			   &revs->pruning) < 0)
       		return REV_TREE_DIFFERENT;
     -+
     -+	if (!nth_parent)
     -+		if (bloom_ret == 1 && tree_difference == REV_TREE_SAME)
     -+			count_bloom_filter_false_positive++;
      +
       	return tree_difference;
       }
     @@ -237,164 +251,3 @@
       };
       
       int ref_excluded(struct string_list *, const char *path);
     -
     - diff --git a/t/helper/test-read-graph.c b/t/helper/test-read-graph.c
     - --- a/t/helper/test-read-graph.c
     - +++ b/t/helper/test-read-graph.c
     -@@
     - 		printf(" commit_metadata");
     - 	if (graph->chunk_extra_edges)
     - 		printf(" extra_edges");
     -+	if (graph->chunk_bloom_indexes)
     -+		printf(" bloom_indexes");
     -+	if (graph->chunk_bloom_data)
     -+		printf(" bloom_data");
     - 	printf("\n");
     - 
     - 	UNLEAK(graph);
     -
     - diff --git a/t/t4216-log-bloom.sh b/t/t4216-log-bloom.sh
     - new file mode 100755
     - --- /dev/null
     - +++ b/t/t4216-log-bloom.sh
     -@@
     -+#!/bin/sh
     -+
     -+test_description='git log for a path with bloom filters'
     -+. ./test-lib.sh
     -+
     -+test_expect_success 'setup test - repo, commits, commit graph, log outputs' '
     -+	git init &&
     -+	mkdir A A/B A/B/C &&
     -+	test_commit c1 A/file1 &&
     -+	test_commit c2 A/B/file2 &&
     -+	test_commit c3 A/B/C/file3 &&
     -+	test_commit c4 A/file1 &&
     -+	test_commit c5 A/B/file2 &&
     -+	test_commit c6 A/B/C/file3 &&
     -+	test_commit c7 A/file1 &&
     -+	test_commit c8 A/B/file2 &&
     -+	test_commit c9 A/B/C/file3 &&
     -+	git checkout -b side HEAD~4 &&
     -+	test_commit side-1 file4 &&
     -+	git checkout master &&
     -+	git merge side &&
     -+	test_commit c10 file5 &&
     -+	mv file5 file5_renamed &&
     -+	git add file5_renamed &&
     -+	git commit -m "rename" &&
     -+	git commit-graph write --reachable --changed-paths
     -+'
     -+graph_read_expect() {
     -+	OPTIONAL=""
     -+	NUM_CHUNKS=5
     -+	cat >expect <<- EOF
     -+	header: 43475048 1 1 $NUM_CHUNKS 0
     -+	num_commits: $1
     -+	chunks: oid_fanout oid_lookup commit_metadata bloom_indexes bloom_data
     -+	EOF
     -+	test-tool read-graph >output &&
     -+	test_cmp expect output
     -+}
     -+
     -+test_expect_success 'commit-graph write wrote out the bloom chunks' '
     -+	graph_read_expect 13
     -+'
     -+
     -+setup() {
     -+	rm output
     -+	rm "$TRASH_DIRECTORY/trace.perf"
     -+	git -c core.commitGraph=false log --pretty="format:%s" $1 >log_wo_bloom
     -+	GIT_TRACE2_PERF="$TRASH_DIRECTORY/trace.perf" git -c core.commitGraph=true log --pretty="format:%s" $1 >log_w_bloom
     -+}
     -+
     -+test_bloom_filters_used() {
     -+	log_args=$1
     -+	bloom_trace_prefix="statistics:{\"filter_not_present\":0,\"zero_length_filter\":0,\"maybe\""
     -+	setup "$log_args"
     -+	grep -q "$bloom_trace_prefix" "$TRASH_DIRECTORY/trace.perf" && test_cmp log_wo_bloom log_w_bloom
     -+}
     -+
     -+test_bloom_filters_not_used() {
     -+	log_args=$1
     -+	setup "$log_args"
     -+	!(grep -q "statistics:{\"filter_not_present\":" "$TRASH_DIRECTORY/trace.perf") && test_cmp log_wo_bloom log_w_bloom
     -+}
     -+
     -+for path in A A/B A/B/C A/file1 A/B/file2 A/B/C/file3 file4 file5_renamed
     -+do
     -+	for option in "" \
     -+		      "--full-history" \
     -+		      "--full-history --simplify-merges" \
     -+		      "--simplify-merges" \
     -+		      "--simplify-by-decoration" \
     -+		      "--follow" \
     -+		      "--first-parent" \
     -+		      "--topo-order" \
     -+		      "--date-order" \
     -+		      "--author-date-order" \
     -+		      "--ancestry-path side..master"
     -+	do
     -+		test_expect_success "git log option: $option for path: $path" '
     -+			test_bloom_filters_used "$option -- $path"
     -+		'
     -+	done
     -+done
     -+
     -+test_expect_success 'git log -- folder works with and without the trailing slash' '
     -+	test_bloom_filters_used "-- A" &&
     -+	test_bloom_filters_used "-- A/"
     -+'
     -+
     -+test_expect_success 'git log for path that does not exist. ' '
     -+	test_bloom_filters_used "-- path_does_not_exist"
     -+'
     -+
     -+test_expect_success 'git log with --walk-reflogs does not use bloom filters' '
     -+	test_bloom_filters_not_used "--walk-reflogs -- A"
     -+'
     -+
     -+test_expect_success 'git log -- multiple path specs does not use bloom filters' '
     -+	test_bloom_filters_not_used "-- file4 A/file1"
     -+'
     -+
     -+test_expect_success 'git log with wildcard that resolves to a single path uses bloom filters' '
     -+	test_bloom_filters_used "-- *4" &&
     -+	test_bloom_filters_used "-- *renamed"
     -+'
     -+
     -+test_expect_success 'git log with wildcard that resolves to a multiple paths does not uses bloom filters' '
     -+	test_bloom_filters_not_used "-- *" &&
     -+	test_bloom_filters_not_used "-- file*"
     -+'
     -+
     -+test_expect_success 'setup - add commit-graph to the chain without bloom filters' '
     -+	test_commit c14 A/anotherFile2 &&
     -+	test_commit c15 A/B/anotherFile2 &&
     -+	test_commit c16 A/B/C/anotherFile2 &&
     -+	GIT_TEST_COMMIT_GRAPH_CHANGED_PATHS=0 git commit-graph write --reachable --split &&
     -+	test_line_count = 2 .git/objects/info/commit-graphs/commit-graph-chain
     -+'
     -+
     -+test_expect_success 'git log does not use bloom filters if the latest graph does not have bloom filters.' '
     -+	test_bloom_filters_not_used "-- A/B"
     -+'
     -+
     -+test_expect_success 'setup - add commit-graph to the chain with bloom filters' '
     -+	test_commit c17 A/anotherFile3 &&
     -+	git commit-graph write --reachable --changed-paths --split &&
     -+	test_line_count = 3 .git/objects/info/commit-graphs/commit-graph-chain
     -+'
     -+
     -+test_bloom_filters_used_when_some_filters_are_missing() {
     -+	log_args=$1
     -+	bloom_trace_prefix="statistics:{\"filter_not_present\":3,\"zero_length_filter\":0,\"maybe\":6,\"definitely_not\":6"
     -+	setup "$log_args"
     -+	grep -q "$bloom_trace_prefix" "$TRASH_DIRECTORY/trace.perf" && test_cmp log_wo_bloom log_w_bloom
     -+}
     -+
     -+test_expect_success 'git log uses bloom filters if they exist in the latest but not all commit graphs in the chain.' '
     -+	test_bloom_filters_used_when_some_filters_are_missing "-- A/B"
     -+'
     -+
     -+test_done
  -:  ----------- > 14:  b5eb280178f revision.c: add trace2 stats around Bloom filter usage
  -:  ----------- > 15:  3019ef72881 t4216: add end to end tests for git log with Bloom filters
 11:  e1b076a714d ! 16:  213abb5d895 commit-graph: add GIT_TEST_COMMIT_GRAPH_CHANGED_PATHS test flag
     @@ -37,8 +37,8 @@
       	export GIT_TEST_COMMIT_GRAPH=1
      +	export GIT_TEST_COMMIT_GRAPH_CHANGED_PATHS=1
       	export GIT_TEST_MULTI_PACK_INDEX=1
     + 	export GIT_TEST_ADD_I_USE_BUILTIN=1
       	make test
     - 	;;
      
       diff --git a/commit-graph.h b/commit-graph.h
       --- a/commit-graph.h
     @@ -68,20 +68,6 @@
       code path for utilizing a file system monitor to speed up detecting
       new or changed files.
      
     - diff --git a/t/t4216-log-bloom.sh b/t/t4216-log-bloom.sh
     - --- a/t/t4216-log-bloom.sh
     - +++ b/t/t4216-log-bloom.sh
     -@@
     - test_description='git log for a path with bloom filters'
     - . ./test-lib.sh
     - 
     -+GIT_TEST_COMMIT_GRAPH=0
     -+GIT_TEST_COMMIT_GRAPH_CHANGED_PATHS=0
     -+
     - test_expect_success 'setup test - repo, commits, commit graph, log outputs' '
     - 	git init &&
     - 	mkdir A A/B A/B/C &&
     -
       diff --git a/t/t5318-commit-graph.sh b/t/t5318-commit-graph.sh
       --- a/t/t5318-commit-graph.sh
       +++ b/t/t5318-commit-graph.sh

-- 
gitgitgadget
