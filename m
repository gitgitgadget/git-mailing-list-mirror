Return-Path: <SRS0=lBg5=3Z=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,LOTS_OF_MONEY,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3FC7C352A2
	for <git@archiver.kernel.org>; Wed,  5 Feb 2020 22:56:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 60B5220730
	for <git@archiver.kernel.org>; Wed,  5 Feb 2020 22:56:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QewD44jl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727653AbgBEW4m (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 5 Feb 2020 17:56:42 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:34117 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727562AbgBEW4j (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 Feb 2020 17:56:39 -0500
Received: by mail-wm1-f68.google.com with SMTP id s144so5503715wme.1
        for <git@vger.kernel.org>; Wed, 05 Feb 2020 14:56:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:mime-version
         :content-transfer-encoding:fcc:to:cc;
        bh=7W1VhBwBvVMMMcVqmuCIIRbSYXC/sSzZVzQ5eZsWt74=;
        b=QewD44jllU5OLVCTOFqP1QXnaE8FlKVvsQZzvUOWatLhHo62c11Q9HvNd3u0kr2Z37
         R1zbnlkQihgW5uFlYb7Q01VXq5iUpHGERV4daQOu/yZCrsr+9DaR/QJGGhfENlSRISvq
         m+FREiVTy+csaYXiygMGzRl7lmhiq9Lgqr5W8QPmAu+u0vcmeTxeTQiHzPA78P+xx3Tf
         mVZrO3knJlu/d5MJK823xGggJC9g3BcJmz5lOyKt6lWsJRtTTJj9vIwvziMzPubY3efT
         6Gghky7b9OuEEe2d+IUapX8rJRVoiZ6/wfvkJX/u7+EDRQxmpCd6+paZi86mtMFZmfiA
         IuoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:mime-version:content-transfer-encoding:fcc:to:cc;
        bh=7W1VhBwBvVMMMcVqmuCIIRbSYXC/sSzZVzQ5eZsWt74=;
        b=JoMPwBdcxMLhjR0HUhlZgrDU1m4tS2fSNlcqi6Bmqs1Yil8kvVSlrdKaOLntKDMpk2
         cvj9Z/IOdN2lkYPxtm9Y2ewZT0XzU/llDVx7xtS1g8bpeFWBOgrJMwN6RaPD2CY8A7cr
         l01iT09nyah6+LB6V1z/0iLS2TKurC0mYOagHdr9MSRh3U4C6dOs5Sm2ORDSoh9vxr5T
         Ua6w8lpC+8KGDnkmTfhrmuHGKB0KxpvJczFFkF4RSDXWK5tU+nX8z0pW0KX1zdT298J+
         d7DKgR6AlixbYkDnrUZ9ppBtzHfiVbK4df5RnMlntKgBQbTpk4fM3KUAktNLBCfl+yWz
         X1pg==
X-Gm-Message-State: APjAAAXTOyHkPE24RBYJKM17VqgVvvKKaR+CL+f3isM3HIu22Za5XI4Q
        TeslxI35ljNUgsrN/KGM+KokvKdO
X-Google-Smtp-Source: APXvYqyfzgWHBtdVxY9Yc1261TPu/MguYN4z3ZmE+0Q1eMpAXh9hD2cZNoXkmCgVRd0UOjjjxfVBFA==
X-Received: by 2002:a1c:3204:: with SMTP id y4mr7844002wmy.166.1580943391753;
        Wed, 05 Feb 2020 14:56:31 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 133sm1424415wmd.5.2020.02.05.14.56.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Feb 2020 14:56:31 -0800 (PST)
Message-Id: <pull.497.v2.git.1580943390.gitgitgadget@gmail.com>
In-Reply-To: <pull.497.git.1576879520.gitgitgadget@gmail.com>
References: <pull.497.git.1576879520.gitgitgadget@gmail.com>
From:   "Garima Singh via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 05 Feb 2020 22:56:19 +0000
Subject: [PATCH v2 00/11] Changed Paths Bloom Filters
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc:    Sent
To:     git@vger.kernel.org
Cc:     stolee@gmail.com, szeder.dev@gmail.com, jonathantanmy@google.com,
        jeffhost@microsoft.com, me@ttaylorr.com, peff@peff.net,
        garimasigit@gmail.com, jnareb@gmail.com,
        christian.couder@gmail.com, emilyshaffer@gmail.com,
        gitster@pobox.com, Garima Singh <garima.singh@microsoft.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hey! 

The commit graph feature brought in a lot of performance improvements across
multiple commands. However, file based history continues to be a performance
pain point, especially in large repositories. 

Adopting changed path bloom filters has been discussed on the list before,
and a prototype version was worked on by SZEDER Gábor, Jonathan Tan and Dr.
Derrick Stolee [1]. This series is based on Dr. Stolee's proof of concept in
[2]

Performance Gains: We tested the performance of git log -- path on the git
repo, the linux repo and some internal large repos, with a variety of paths
of varying depths.

On the git and linux repos: We observed a 2x to 5x speed up.

On a large internal repo with files seated 6-10 levels deep in the tree: We
observed 10x to 20x speed ups, with some paths going up to 28 times faster.

Future Work (not included in the scope of this series):

 1. Supporting multiple path based revision walk
 2. Adopting it in git blame logic. 
 3. Interactions with line log git log -L


----------------------------------------------------------------------------

Updates since the last submission

 * Removed all the RFC callouts, this is a ready for full review version
 * Added unit tests for the bloom filter computation layer
 * Added more evolved functional tests for git log
 * Fixed a lot of the bugs found by the tests
 * Reacted to other miscellaneous feedback on the RFC series. 

Cheers! Garima Singh

[1] https://lore.kernel.org/git/20181009193445.21908-1-szeder.dev@gmail.com/
[2] 
https://lore.kernel.org/git/61559c5b-546e-d61b-d2e1-68de692f5972@gmail.com/

Derrick Stolee (2):
  diff: halt tree-diff early after max_changes
  commit-graph: examine commits by generation number

Garima Singh (8):
  commit-graph: use MAX_NUM_CHUNKS
  bloom: core Bloom filter implementation for changed paths
  commit-graph: compute Bloom filters for changed paths
  commit-graph: write Bloom filters to commit graph file
  commit-graph: reuse existing Bloom filters during write.
  commit-graph: add --changed-paths option to write subcommand
  revision.c: use Bloom filters to speed up path based revision walks
  commit-graph: add GIT_TEST_COMMIT_GRAPH_CHANGED_PATHS test flag

Jeff King (1):
  commit-graph: examine changed-path objects in pack order

 Documentation/git-commit-graph.txt            |   5 +
 .../technical/commit-graph-format.txt         |  24 ++
 Makefile                                      |   2 +
 bloom.c                                       | 277 ++++++++++++++++++
 bloom.h                                       |  58 ++++
 builtin/commit-graph.c                        |  10 +-
 ci/run-build-and-tests.sh                     |   1 +
 commit-graph.c                                | 211 ++++++++++++-
 commit-graph.h                                |   9 +-
 diff.h                                        |   5 +
 revision.c                                    | 124 +++++++-
 revision.h                                    |  11 +
 t/README                                      |   5 +
 t/helper/test-bloom.c                         |  84 ++++++
 t/helper/test-read-graph.c                    |   4 +
 t/helper/test-tool.c                          |   1 +
 t/helper/test-tool.h                          |   1 +
 t/t0095-bloom.sh                              | 113 +++++++
 t/t4216-log-bloom.sh                          | 143 +++++++++
 t/t5318-commit-graph.sh                       |   2 +
 t/t5324-split-commit-graph.sh                 |   1 +
 tree-diff.c                                   |   6 +
 22 files changed, 1088 insertions(+), 9 deletions(-)
 create mode 100644 bloom.c
 create mode 100644 bloom.h
 create mode 100644 t/helper/test-bloom.c
 create mode 100755 t/t0095-bloom.sh
 create mode 100755 t/t4216-log-bloom.sh


base-commit: 5b0ca878e008e82f91300091e793427205ce3544
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-497%2Fgarimasi514%2FcoreGit-bloomFilters-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-497/garimasi514/coreGit-bloomFilters-v2
Pull-Request: https://github.com/gitgitgadget/git/pull/497

Range-diff vs v1:

  3:  a15f87fdcb =  1:  bf6b93878a commit-graph: use MAX_NUM_CHUNKS
  2:  e52c7ad37a !  2:  02b16d9422 commit-graph: write changed paths bloom filters
     @@ -1,65 +1,72 @@
      Author: Garima Singh <garima.singh@microsoft.com>
      
     -    commit-graph: write changed paths bloom filters
     +    bloom: core Bloom filter implementation for changed paths
      
     -    The changed path bloom filters help determine which paths changed between a
     -    commit and its first parent. We already have the "--changed-paths" option
     -    for the "git commit-graph write" subcommand, now actually compute them under
     -    that option. The COMMIT_GRAPH_WRITE_BLOOM_FILTERS flag enables this
     -    computation.
     +    Add the core Bloom filter logic for computing the paths changed between a
     +    commit and its first parent. For details on what Bloom filters are and how they
     +    work, please refer to Dr. Derrick Stolee's blog post [1]. It provides a concise
     +    explaination of the adoption of Bloom filters as described in [2] and [3]
      
     -    RFC Notes: Here are some details about the implementation and I would love
     -    to know your thoughts and suggestions for improvements here.
     +    1. We currently use 7 and 10 for the number of hashes and the size of each
     +       entry respectively. They served as great starting values, the mathematical
     +       details behind this choice are described in [1] and [4]. The implementation
     +       while not completely open to it at the moment, is flexible enough to allow
     +       for tweaking these settings in the future.
      
     -    For details on what bloom filters are and how they work, please refer to
     -    Dr. Derrick Stolee's blog post [1].
     -    [1] https://devblogs.microsoft.com/devops/super-charging-the-git-commit-graph-iv-bloom-filters/
     +       Note: The performance gains we have observed with these values are
     +       significant enough that we did not need to tweak these settings.
     +       The performance numbers are included in the cover letter of this series
     +       and in the message of a subsequent commit where we use Bloom filters in
     +       to speed up `git log -- <path>`.
      
     -    1. The implementation sticks to the recommended values of 7 and 10 for the
     -       number of hashes and the size of each entry, as described in the blog.
     -       The implementation while not completely open to it at the moment, is flexible
     -       enough to allow for tweaking these settings in the future.
     -       Note: The performance gains we have observed so far with these values is
     -       significant enough to not that we did not need to tweak these settings.
     -       The cover letter of this series has the details and the commit where we have
     -       git log use bloom filters.
     -
     -    2. As described in the blog and the linked technical paper therin, we do not need
     -       7 independent hashing functions. We use the Murmur3 hashing scheme - seed it
     -       twice and then combine those to procure an arbitrary number of hash values.
     +    2. As described in the blog and in [3], we do not need 7 independent hashing
     +       functions. We use the Murmur3 hashing scheme. Seed it twice and then
     +       combine those to procure an arbitrary number of hash values.
      
          3. The filters are sized according to the number of changes in the each commit,
             with minimum size of one 64 bit word.
      
     -    [Call for advice] We currently cap writing bloom filters for commits with
     -    atmost 512 changed files. In the current implementation, we compute the diff,
     -    and then just throw it away once we see it has more than 512 changes.
     -    Any suggestiongs on how to reduce the work we are doing in this case are more
     -    than welcome.
     +    4. We fill the Bloom filters as (const char *data, int len) pairs as
     +       "struct bloom_filter"s in a commit slab.
      
     -    [Call for advice] Would the git community like this commit to be split up into
     -    more granular commits? This commit could possibly be split out further with the
     -    bloom.c code in its own commit, to be used by the commit-graph in a subsequent
     -    commit. While I prefer it being contained in one commit this way, I am open to
     -    suggestions.
     +    5. The seed_murmur3 method is implemented as described in [5]. It hashes the
     +       given data using a given seed and produces a uniformly distributed hash
     +       value.
      
     -    [Call for advice] Would a technical document explaining the exact details of
     -    the bloom filter implemenation and the hashing calculations be helpful? I will
     -    be adding details into Documentation/technical/commit-graph-format.txt, but the
     -    bloom filter code is an independent subsystem and could be used outside of the
     -    commit-graph feature. Is it worth a separate document, or should we apply "You
     -    Ain't Gonna Need It" principles?
     +    [1] https://devblogs.microsoft.com/devops/super-charging-the-git-commit-graph-iv-Bloom-filters/
      
     -    [Call for advice] I plan to add unit tests for bloom.c, specifically to ensure
     -    that the hash algorithm and bloom key calculations are stable across versions.
     +    [2] Flavio Bonomi, Michael Mitzenmacher, Rina Panigrahy, Sushil Singh, George Varghese
     +        "An Improved Construction for Counting Bloom Filters"
     +        http://theory.stanford.edu/~rinap/papers/esa2006b.pdf
     +        https://doi.org/10.1007/11841036_61
      
     -    Signed-off-by: Garima Singh <garima.singh@microsoft.com>
     +    [3] Peter C. Dillinger and Panagiotis Manolios
     +        "Bloom Filters in Probabilistic Verification"
     +        http://www.ccs.neu.edu/home/pete/pub/Bloom-filters-verification.pdf
     +        https://doi.org/10.1007/978-3-540-30494-4_26
     +
     +    [4] Thomas Mueller Graf, Daniel Lemire
     +        "Xor Filters: Faster and Smaller Than Bloom and Cuckoo Filters"
     +        https://arxiv.org/abs/1912.08258
     +
     +    [5] https://en.wikipedia.org/wiki/MurmurHash#Algorithm
     +
     +    Helped-by: Jeff King <peff@peff.net>
          Helped-by: Derrick Stolee <dstolee@microsoft.com>
     +    Signed-off-by: Garima Singh <garima.singh@microsoft.com>
      
       diff --git a/Makefile b/Makefile
       --- a/Makefile
       +++ b/Makefile
      @@
     + 
     + PROGRAMS += $(patsubst %.o,git-%$X,$(PROGRAM_OBJS))
     + 
     ++TEST_BUILTINS_OBJS += test-bloom.o
     + TEST_BUILTINS_OBJS += test-chmtime.o
     + TEST_BUILTINS_OBJS += test-config.o
     + TEST_BUILTINS_OBJS += test-ctype.o
     +@@
       LIB_OBJS += bisect.o
       LIB_OBJS += blame.o
       LIB_OBJS += blob.o
     @@ -82,8 +89,6 @@
      +#include "revision.h"
      +#include "hashmap.h"
      +
     -+#define BITS_PER_BLOCK 64
     -+
      +define_commit_slab(bloom_filter_slab, struct bloom_filter);
      +
      +struct bloom_filter_slab bloom_filters;
     @@ -100,12 +105,18 @@
      +	return ((value >> count) | (value << ((-count) & mask)));
      +}
      +
     ++/*
     ++ * Calculate a hash value for the given data using the given seed.
     ++ * Produces a uniformly distributed hash value.
     ++ * Not considered to be cryptographically secure.
     ++ * Implemented as described in https://en.wikipedia.org/wiki/MurmurHash#Algorithm
     ++ **/
      +static uint32_t seed_murmur3(uint32_t seed, const char *data, int len)
      +{
      +	const uint32_t c1 = 0xcc9e2d51;
      +	const uint32_t c2 = 0x1b873593;
     -+	const int32_t r1 = 15;
     -+	const int32_t r2 = 13;
     ++	const uint32_t r1 = 15;
     ++	const uint32_t r2 = 13;
      +	const uint32_t m = 5;
      +	const uint32_t n = 0xe6546b64;
      +	int i;
     @@ -159,66 +170,67 @@
      +
      +static inline uint64_t get_bitmask(uint32_t pos)
      +{
     -+	return ((uint64_t)1) << (pos & (BITS_PER_BLOCK - 1));
     ++	return ((uint64_t)1) << (pos & (BITS_PER_WORD - 1));
     ++}
     ++
     ++void load_bloom_filters(void)
     ++{
     ++	init_bloom_filter_slab(&bloom_filters);
      +}
      +
      +void fill_bloom_key(const char *data,
     -+		    int len,
     -+		    struct bloom_key *key,
     -+		    struct bloom_filter_settings *settings)
     ++					int len,
     ++					struct bloom_key *key,
     ++					struct bloom_filter_settings *settings)
      +{
      +	int i;
     -+	uint32_t seed0 = 0x293ae76f;
     -+	uint32_t seed1 = 0x7e646e2c;
     -+
     -+	uint32_t hash0 = seed_murmur3(seed0, data, len);
     -+	uint32_t hash1 = seed_murmur3(seed1, data, len);
     ++	const uint32_t seed0 = 0x293ae76f;
     ++	const uint32_t seed1 = 0x7e646e2c;
     ++	const uint32_t hash0 = seed_murmur3(seed0, data, len);
     ++	const uint32_t hash1 = seed_murmur3(seed1, data, len);
      +
      +	key->hashes = (uint32_t *)xcalloc(settings->num_hashes, sizeof(uint32_t));
      +	for (i = 0; i < settings->num_hashes; i++)
      +		key->hashes[i] = hash0 + i * hash1;
      +}
      +
     -+static void add_key_to_filter(struct bloom_key *key,
     -+			      struct bloom_filter *filter,
     -+			      struct bloom_filter_settings *settings)
     ++void add_key_to_filter(struct bloom_key *key,
     ++					   struct bloom_filter *filter,
     ++					   struct bloom_filter_settings *settings)
      +{
      +	int i;
     -+	uint64_t mod = filter->len * BITS_PER_BLOCK;
     ++	uint64_t mod = filter->len * BITS_PER_WORD;
      +
      +	for (i = 0; i < settings->num_hashes; i++) {
      +		uint64_t hash_mod = key->hashes[i] % mod;
     -+		uint64_t block_pos = hash_mod / BITS_PER_BLOCK;
     ++		uint64_t block_pos = hash_mod / BITS_PER_WORD;
      +
      +		filter->data[block_pos] |= get_bitmask(hash_mod);
      +	}
      +}
      +
     -+void load_bloom_filters(void)
     -+{
     -+	init_bloom_filter_slab(&bloom_filters);
     -+}
     -+
      +struct bloom_filter *get_bloom_filter(struct repository *r,
      +				      struct commit *c)
      +{
      +	struct bloom_filter *filter;
      +	struct bloom_filter_settings settings = DEFAULT_BLOOM_FILTER_SETTINGS;
      +	int i;
     -+	struct rev_info revs;
     -+	const char *revs_argv[] = {NULL, "HEAD", NULL};
     ++	struct diff_options diffopt;
     ++
     ++	if (!bloom_filters.slab_size)
     ++		return NULL;
      +
      +	filter = bloom_filter_slab_at(&bloom_filters, c);
     -+	init_revisions(&revs, NULL);
     -+	revs.diffopt.flags.recursive = 1;
      +
     -+	setup_revisions(2, revs_argv, &revs, NULL);
     ++	repo_diff_setup(r, &diffopt);
     ++	diffopt.flags.recursive = 1;
     ++	diff_setup_done(&diffopt);
      +
      +	if (c->parents)
     -+		diff_tree_oid(&c->parents->item->object.oid, &c->object.oid, "", &revs.diffopt);
     ++		diff_tree_oid(&c->parents->item->object.oid, &c->object.oid, "", &diffopt);
      +	else
     -+		diff_tree_oid(NULL, &c->object.oid, "", &revs.diffopt);
     -+	diffcore_std(&revs.diffopt);
     ++		diff_tree_oid(NULL, &c->object.oid, "", &diffopt);
     ++	diffcore_std(&diffopt);
      +
      +	if (diff_queued_diff.nr <= 512) {
      +		struct hashmap pathmap;
     @@ -227,18 +239,18 @@
      +		hashmap_init(&pathmap, NULL, NULL, 0);
      +
      +		for (i = 0; i < diff_queued_diff.nr; i++) {
     -+		    const char* path = diff_queued_diff.queue[i]->two->path;
     -+		    const char* p = path;
     -+
     -+		    /*
     -+		     * Add each leading directory of the changed file, i.e. for
     -+		     * 'dir/subdir/file' add 'dir' and 'dir/subdir' as well, so
     -+		     * the Bloom filter could be used to speed up commands like
     -+		     * 'git log dir/subdir', too.
     -+		     *
     -+		     * Note that directories are added without the trailing '/'.
     -+		     */
     -+		    do {
     ++			const char* path = diff_queued_diff.queue[i]->two->path;
     ++			const char* p = path;
     ++
     ++			/*
     ++			* Add each leading directory of the changed file, i.e. for
     ++			* 'dir/subdir/file' add 'dir' and 'dir/subdir' as well, so
     ++			* the Bloom filter could be used to speed up commands like
     ++			* 'git log dir/subdir', too.
     ++			*
     ++			* Note that directories are added without the trailing '/'.
     ++			*/
     ++			do {
      +				char* last_slash = strrchr(p, '/');
      +
      +				FLEX_ALLOC_STR(e, path, path);
     @@ -246,25 +258,27 @@
      +				hashmap_add(&pathmap, &e->entry);
      +
      +				if (!last_slash)
     -+				    last_slash = (char*)p;
     ++					last_slash = (char*)p;
      +				*last_slash = '\0';
      +
     -+		    } while (*p);
     ++			} while (*p);
      +
     -+		    diff_free_filepair(diff_queued_diff.queue[i]);
     ++			diff_free_filepair(diff_queued_diff.queue[i]);
      +		}
      +
     -+		filter->len = (hashmap_get_size(&pathmap) * settings.bits_per_entry + BITS_PER_BLOCK - 1) / BITS_PER_BLOCK;
     ++		filter->len = (hashmap_get_size(&pathmap) * settings.bits_per_entry + BITS_PER_WORD - 1) / BITS_PER_WORD;
      +		filter->data = xcalloc(filter->len, sizeof(uint64_t));
      +
      +		hashmap_for_each_entry(&pathmap, &iter, e, entry) {
     -+		    struct bloom_key key;
     -+		    fill_bloom_key(e->path, strlen(e->path), &key, &settings);
     -+		    add_key_to_filter(&key, filter, &settings);
     ++			struct bloom_key key;
     ++			fill_bloom_key(e->path, strlen(e->path), &key, &settings);
     ++			add_key_to_filter(&key, filter, &settings);
      +		}
      +
      +		hashmap_free_entries(&pathmap, struct pathmap_hash_entry, entry);
      +	} else {
     ++		for (i = 0; i < diff_queued_diff.nr; i++)
     ++			diff_free_filepair(diff_queued_diff.queue[i]);
      +		filter->data = NULL;
      +		filter->len = 0;
      +	}
     @@ -274,7 +288,26 @@
      +
      +	return filter;
      +}
     - \ No newline at end of file
     ++
     ++int bloom_filter_contains(struct bloom_filter *filter,
     ++			  struct bloom_key *key,
     ++			  struct bloom_filter_settings *settings)
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
      
       diff --git a/bloom.h b/bloom.h
       new file mode 100644
     @@ -286,6 +319,7 @@
      +
      +struct commit;
      +struct repository;
     ++struct commit_graph;
      +
      +struct bloom_filter_settings {
      +	uint32_t hash_version;
     @@ -294,6 +328,7 @@
      +};
      +
      +#define DEFAULT_BLOOM_FILTER_SETTINGS { 1, 7, 10 }
     ++#define BITS_PER_WORD 64
      +
      +/*
      + * A bloom_filter struct represents a data segment to
     @@ -318,85 +353,253 @@
      +
      +void load_bloom_filters(void);
      +
     -+struct bloom_filter *get_bloom_filter(struct repository *r,
     -+				      struct commit *c);
     -+
      +void fill_bloom_key(const char *data,
      +		    int len,
      +		    struct bloom_key *key,
      +		    struct bloom_filter_settings *settings);
      +
     ++void add_key_to_filter(struct bloom_key *key,
     ++					   struct bloom_filter *filter,
     ++					   struct bloom_filter_settings *settings);
     ++
     ++struct bloom_filter *get_bloom_filter(struct repository *r,
     ++				      struct commit *c);
     ++
     ++int bloom_filter_contains(struct bloom_filter *filter,
     ++			  struct bloom_key *key,
     ++			  struct bloom_filter_settings *settings);
     ++
      +#endif
      
     - diff --git a/commit-graph.c b/commit-graph.c
     - --- a/commit-graph.c
     - +++ b/commit-graph.c
     + diff --git a/t/helper/test-bloom.c b/t/helper/test-bloom.c
     + new file mode 100644
     + --- /dev/null
     + +++ b/t/helper/test-bloom.c
      @@
     - #include "hashmap.h"
     - #include "replace-object.h"
     - #include "progress.h"
     ++#include "test-tool.h"
     ++#include "git-compat-util.h"
      +#include "bloom.h"
     - 
     - #define GRAPH_SIGNATURE 0x43475048 /* "CGPH" */
     - #define GRAPH_CHUNKID_OIDFANOUT 0x4f494446 /* "OIDF" */
     -@@
     - 	unsigned append:1,
     - 		 report_progress:1,
     - 		 split:1,
     --		 check_oids:1;
     -+		 check_oids:1,
     -+		 bloom:1;
     - 
     - 	const struct split_commit_graph_opts *split_opts;
     -+	uint32_t total_bloom_filter_size;
     - };
     - 
     - static void write_graph_chunk_fanout(struct hashfile *f,
     -@@
     - 	stop_progress(&ctx->progress);
     - }
     - 
     -+static void compute_bloom_filters(struct write_commit_graph_context *ctx)
     -+{
     -+	int i;
     -+	struct progress *progress = NULL;
     ++#include "test-tool.h"
     ++#include "cache.h"
     ++#include "commit-graph.h"
     ++#include "commit.h"
     ++#include "config.h"
     ++#include "object-store.h"
     ++#include "object.h"
     ++#include "repository.h"
     ++#include "tree.h"
      +
     -+	load_bloom_filters();
     ++struct bloom_filter_settings settings = DEFAULT_BLOOM_FILTER_SETTINGS;
      +
     -+	if (ctx->report_progress)
     -+		progress = start_progress(
     -+			_("Computing commit diff Bloom filters"),
     -+			ctx->commits.nr);
     ++static void print_bloom_filter(struct bloom_filter *filter) {
     ++	int i;
      +
     -+	for (i = 0; i < ctx->commits.nr; i++) {
     -+		struct commit *c = ctx->commits.list[i];
     -+		struct bloom_filter *filter = get_bloom_filter(ctx->r, c);
     -+		ctx->total_bloom_filter_size += sizeof(uint64_t) * filter->len;
     -+		display_progress(progress, i + 1);
     ++	if (!filter) {
     ++		printf("No filter.\n");
     ++		return;
     ++	}
     ++	printf("Filter_Length:%d\n", filter->len);
     ++	printf("Filter_Data:");
     ++	for (i = 0; i < filter->len; i++){
     ++		printf("%"PRIx64"|", filter->data[i]);
      +	}
     ++	printf("\n");
     ++}
     ++
     ++static void add_string_to_filter(const char *data, struct bloom_filter *filter) {
     ++		struct bloom_key key;
     ++		int i;
     ++
     ++		fill_bloom_key(data, strlen(data), &key, &settings);
     ++		printf("Hashes:");
     ++		for (i = 0; i < settings.num_hashes; i++){
     ++			printf("%08x|", key.hashes[i]);
     ++		}
     ++		printf("\n");
     ++		add_key_to_filter(&key, filter, &settings);
     ++}
      +
     -+	stop_progress(&progress);
     ++static void get_bloom_filter_for_commit(const struct object_id *commit_oid)
     ++{
     ++	struct commit *c;
     ++	struct bloom_filter *filter;
     ++	setup_git_directory();
     ++	c = lookup_commit(the_repository, commit_oid);
     ++	filter = get_bloom_filter(the_repository, c);
     ++	print_bloom_filter(filter);
      +}
      +
     - static int add_ref_to_list(const char *refname,
     - 			   const struct object_id *oid,
     - 			   int flags, void *cb_data)
     ++int cmd__bloom(int argc, const char **argv)
     ++{
     ++    if (!strcmp(argv[1], "generate_filter")) {
     ++		struct bloom_filter filter;
     ++		int i = 2;
     ++		filter.len =  (settings.bits_per_entry + BITS_PER_WORD - 1) / BITS_PER_WORD;
     ++		filter.data = xcalloc(filter.len, sizeof(uint64_t));
     ++
     ++		if (!argv[2]){
     ++			die("at least one input string expected");
     ++		}
     ++
     ++		while (argv[i]) {
     ++			add_string_to_filter(argv[i], &filter);
     ++			i++;
     ++		}
     ++
     ++		print_bloom_filter(&filter);
     ++	}
     ++
     ++	if (!strcmp(argv[1], "get_filter_for_commit")) {
     ++		struct object_id oid;
     ++		const char *end;
     ++		if (parse_oid_hex(argv[2], &oid, &end))
     ++			die("cannot parse oid '%s'", argv[2]);
     ++		load_bloom_filters();
     ++		get_bloom_filter_for_commit(&oid);
     ++	}
     ++
     ++	return 0;
     ++}
     +
     + diff --git a/t/helper/test-tool.c b/t/helper/test-tool.c
     + --- a/t/helper/test-tool.c
     + +++ b/t/helper/test-tool.c
      @@
     - 	ctx->split = flags & COMMIT_GRAPH_WRITE_SPLIT ? 1 : 0;
     - 	ctx->check_oids = flags & COMMIT_GRAPH_WRITE_CHECK_OIDS ? 1 : 0;
     - 	ctx->split_opts = split_opts;
     -+	ctx->bloom = flags & COMMIT_GRAPH_WRITE_BLOOM_FILTERS ? 1 : 0;
     -+	ctx->total_bloom_filter_size = 0;
     + };
       
     - 	if (ctx->split) {
     - 		struct commit_graph *g;
     + static struct test_cmd cmds[] = {
     ++	{ "bloom", cmd__bloom },
     + 	{ "chmtime", cmd__chmtime },
     + 	{ "config", cmd__config },
     + 	{ "ctype", cmd__ctype },
     +
     + diff --git a/t/helper/test-tool.h b/t/helper/test-tool.h
     + --- a/t/helper/test-tool.h
     + +++ b/t/helper/test-tool.h
      @@
     + #define USE_THE_INDEX_COMPATIBILITY_MACROS
     + #include "git-compat-util.h"
       
     - 	compute_generation_numbers(ctx);
     - 
     -+	if (ctx->bloom)
     -+		compute_bloom_filters(ctx);
     -+
     - 	res = write_commit_graph_file(ctx);
     - 
     - 	if (ctx->split)
     ++int cmd__bloom(int argc, const char **argv);
     + int cmd__chmtime(int argc, const char **argv);
     + int cmd__config(int argc, const char **argv);
     + int cmd__ctype(int argc, const char **argv);
     +
     + diff --git a/t/t0095-bloom.sh b/t/t0095-bloom.sh
     + new file mode 100755
     + --- /dev/null
     + +++ b/t/t0095-bloom.sh
     +@@
     ++#!/bin/sh
     ++
     ++test_description='test bloom.c'
     ++. ./test-lib.sh
     ++
     ++test_expect_success 'get bloom filters for commit with no changes' '
     ++	git init &&
     ++	git commit --allow-empty -m "c0" &&
     ++	cat >expect <<-\EOF &&
     ++	Filter_Length:0
     ++	Filter_Data:
     ++	EOF
     ++	test-tool bloom get_filter_for_commit "$(git rev-parse HEAD)" >actual &&
     ++	test_cmp expect actual
     ++'
     ++
     ++test_expect_success 'get bloom filter for commit with 10 changes' '
     ++	rm actual &&
     ++	rm expect &&
     ++	mkdir smallDir &&
     ++	for i in $(test_seq 0 9)
     ++	do
     ++		echo $i >smallDir/$i
     ++	done &&
     ++	git add smallDir &&
     ++	git commit -m "commit with 10 changes" &&
     ++	cat >expect <<-\EOF &&
     ++	Filter_Length:4
     ++	Filter_Data:508928809087080a|8a7648210804001|4089824400951000|841ab310098051a8|
     ++	EOF
     ++	test-tool bloom get_filter_for_commit "$(git rev-parse HEAD)" >actual &&
     ++	test_cmp expect actual
     ++'
     ++
     ++test_expect_success EXPENSIVE 'get bloom filter for commit with 513 changes' '
     ++	rm actual &&
     ++	rm expect &&
     ++	mkdir bigDir &&
     ++	for i in $(test_seq 0 512)
     ++	do
     ++		echo $i >bigDir/$i
     ++	done &&
     ++	git add bigDir &&
     ++	git commit -m "commit with 513 changes" &&
     ++	cat >expect <<-\EOF &&
     ++	Filter_Length:0
     ++	Filter_Data:
     ++	EOF
     ++	test-tool bloom get_filter_for_commit "$(git rev-parse HEAD)" >actual &&
     ++	test_cmp expect actual
     ++'
     ++
     ++test_expect_success 'compute bloom key for empty string' '
     ++	cat >expect <<-\EOF &&
     ++	Hashes:5615800c|5b966560|61174ab4|66983008|6c19155c|7199fab0|771ae004|
     ++	Filter_Length:1
     ++	Filter_Data:11000110001110|
     ++	EOF
     ++	test-tool bloom generate_filter "" >actual &&
     ++	test_cmp expect actual
     ++'
     ++
     ++test_expect_success 'compute bloom key for whitespace' '
     ++	cat >expect <<-\EOF &&
     ++	Hashes:1bf014e6|8a91b50b|f9335530|67d4f555|d676957a|4518359f|b3b9d5c4|
     ++	Filter_Length:1
     ++	Filter_Data:401004080200810|
     ++	EOF
     ++	test-tool bloom generate_filter " " >actual &&
     ++	test_cmp expect actual
     ++'
     ++
     ++test_expect_success 'compute bloom key for a root level folder' '
     ++	cat >expect <<-\EOF &&
     ++	Hashes:1a21016f|fff1c06d|e5c27f6b|cb933e69|b163fd67|9734bc65|7d057b63|
     ++	Filter_Length:1
     ++	Filter_Data:aaa800000000|
     ++	EOF
     ++	test-tool bloom generate_filter "A" >actual &&
     ++	test_cmp expect actual
     ++'
     ++
     ++test_expect_success 'compute bloom key for a root level file' '
     ++	cat >expect <<-\EOF &&
     ++	Hashes:e2d51107|30970605|7e58fb03|cc1af001|19dce4ff|679ed9fd|b560cefb|
     ++	Filter_Length:1
     ++	Filter_Data:a8000000000000aa|
     ++	EOF
     ++	test-tool bloom generate_filter "file.txt" >actual &&
     ++	test_cmp expect actual
     ++'
     ++
     ++test_expect_success 'compute bloom key for a deep folder' '
     ++	cat >expect <<-\EOF &&
     ++	Hashes:864cf838|27f055cd|c993b362|6b3710f7|0cda6e8c|ae7dcc21|502129b6|
     ++	Filter_Length:1
     ++	Filter_Data:1c0000600003000|
     ++	EOF
     ++	test-tool bloom generate_filter "A/B/C/D/E" >actual &&
     ++	test_cmp expect actual
     ++'
     ++
     ++test_expect_success 'compute bloom key for a deep file' '
     ++	cat >expect <<-\EOF &&
     ++	Hashes:07cdf850|4af629c7|8e1e5b3e|d1468cb5|146ebe2c|5796efa3|9abf211a|
     ++	Filter_Length:1
     ++	Filter_Data:4020100804010080|
     ++	EOF
     ++	test-tool bloom generate_filter "A/B/C/D/E/file.txt" >actual &&
     ++	test_cmp expect actual
     ++'
     ++
     ++test_done
  -:  ---------- >  3:  a698c04a78 diff: halt tree-diff early after max_changes
  -:  ---------- >  4:  c17bbcbc66 commit-graph: compute Bloom filters for changed paths
  -:  ---------- >  5:  78e8e49c3a commit-graph: examine changed-path objects in pack order
  -:  ---------- >  6:  58704d81b6 commit-graph: examine commits by generation number
  5:  7648021072 !  7:  39ee061080 commit-graph: write changed path bloom filters to commit-graph file.
     @@ -1,23 +1,67 @@
      Author: Garima Singh <garima.singh@microsoft.com>
      
     -    commit-graph: write changed path bloom filters to commit-graph file.
     +    commit-graph: write Bloom filters to commit graph file
      
     -    Write bloom filters to the commit-graph using the format described in
     -    Documentation/technical/commit-graph-format.txt
     +    Update the technical documentation for commit-graph-format with the formats for
     +    the Bloom filter index (BIDX) and Bloom filter data (BDAT) chunks. Write the
     +    computed Bloom filters information to the commit graph file using this format.
      
          Helped-by: Derrick Stolee <dstolee@microsoft.com>
          Signed-off-by: Garima Singh <garima.singh@microsoft.com>
      
     + diff --git a/Documentation/technical/commit-graph-format.txt b/Documentation/technical/commit-graph-format.txt
     + --- a/Documentation/technical/commit-graph-format.txt
     + +++ b/Documentation/technical/commit-graph-format.txt
     +@@
     + - The parents of the commit, stored using positional references within
     +   the graph file.
     + 
     ++- The Bloom filter of the commit carrying the paths that were changed between
     ++  the commit and its first parent.
     ++
     + These positional references are stored as unsigned 32-bit integers
     + corresponding to the array position within the list of commit OIDs. Due
     + to some special constants we use to track parents, we can store at most
     +@@
     +       positions for the parents until reaching a value with the most-significant
     +       bit on. The other bits correspond to the position of the last parent.
     + 
     ++  Bloom Filter Index (ID: {'B', 'I', 'D', 'X'}) (N * 4 bytes) [Optional]
     ++    * The ith entry, BIDX[i], stores the number of 8-byte word blocks in all
     ++      Bloom filters from commit 0 to commit i (inclusive) in lexicographic
     ++      order. The Bloom filter for the i-th commit spans from BIDX[i-1] to
     ++      BIDX[i] (plus header length), where BIDX[-1] is 0.
     ++    * The BIDX chunk is ignored if the BDAT chunk is not present.
     ++
     ++  Bloom Filter Data (ID: {'B', 'D', 'A', 'T'}) [Optional]
     ++    * It starts with header consisting of three unsigned 32-bit integers:
     ++      - Version of the hash algorithm being used. We currently only support
     ++	value 1 which implies the murmur3 hash implemented exactly as described
     ++	in https://en.wikipedia.org/wiki/MurmurHash#Algorithm
     ++      - The number of times a path is hashed and hence the number of bit positions
     ++	that cumulatively determine whether a file is present in the commit.
     ++      - The minimum number of bits 'b' per entry in the Bloom filter. If the filter
     ++	contains 'n' entries, then the filter size is the minimum number of 64-bit
     ++	words that contain n*b bits.
     ++    * The rest of the chunk is the concatenation of all the computed Bloom
     ++      filters for the commits in lexicographic order.
     ++    * The BDAT chunk is present iff BIDX is present.
     ++
     +   Base Graphs List (ID: {'B', 'A', 'S', 'E'}) [Optional]
     +       This list of H-byte hashes describe a set of B commit-graph files that
     +       form a commit-graph chain. The graph position for the ith commit in this
     +
       diff --git a/commit-graph.c b/commit-graph.c
       --- a/commit-graph.c
       +++ b/commit-graph.c
      @@
     + #define GRAPH_CHUNKID_OIDLOOKUP 0x4f49444c /* "OIDL" */
       #define GRAPH_CHUNKID_DATA 0x43444154 /* "CDAT" */
       #define GRAPH_CHUNKID_EXTRAEDGES 0x45444745 /* "EDGE" */
     - #define GRAPH_CHUNKID_BASE 0x42415345 /* "BASE" */
     --#define MAX_NUM_CHUNKS 5
      +#define GRAPH_CHUNKID_BLOOMINDEXES 0x42494458 /* "BIDX" */
      +#define GRAPH_CHUNKID_BLOOMDATA 0x42444154 /* "BDAT" */
     + #define GRAPH_CHUNKID_BASE 0x42415345 /* "BASE" */
     +-#define MAX_NUM_CHUNKS 5
      +#define MAX_NUM_CHUNKS 7
       
       #define GRAPH_DATA_WIDTH (the_hash_algo->rawsz + 16)
     @@ -46,15 +90,33 @@
      +				if (hash_version != 1)
      +					break;
      +
     -+				graph->settings = xmalloc(sizeof(struct bloom_filter_settings));
     -+				graph->settings->hash_version = hash_version;
     -+				graph->settings->num_hashes = get_be32(data + chunk_offset + 4);
     -+				graph->settings->bits_per_entry = get_be32(data + chunk_offset + 8);
     ++				graph->bloom_filter_settings = xmalloc(sizeof(struct bloom_filter_settings));
     ++				graph->bloom_filter_settings->hash_version = hash_version;
     ++				graph->bloom_filter_settings->num_hashes = get_be32(data + chunk_offset + 4);
     ++				graph->bloom_filter_settings->bits_per_entry = get_be32(data + chunk_offset + 8);
      +			}
      +			break;
       		}
       
       		if (chunk_repeated) {
     +@@
     + 		last_chunk_offset = chunk_offset;
     + 	}
     + 
     ++	/* We need both the bloom chunks to exist together. Else ignore the data */
     ++	if ((graph->chunk_bloom_indexes && !graph->chunk_bloom_data)
     ++		 || (!graph->chunk_bloom_indexes && graph->chunk_bloom_data)) {
     ++		graph->chunk_bloom_indexes = NULL;
     ++		graph->chunk_bloom_data = NULL;
     ++		graph->bloom_filter_settings = NULL;
     ++	}
     ++
     ++	if (graph->chunk_bloom_indexes && graph->chunk_bloom_data)
     ++		load_bloom_filters();
     ++
     + 	hashcpy(graph->oid.hash, graph->data + graph->data_len - graph->hash_len);
     + 
     + 	if (verify_commit_graph_lite(graph)) {
      @@
       	}
       }
     @@ -65,36 +127,67 @@
      +	struct commit **list = ctx->commits.list;
      +	struct commit **last = ctx->commits.list + ctx->commits.nr;
      +	uint32_t cur_pos = 0;
     ++	struct progress *progress = NULL;
     ++	int i = 0;
     ++
     ++	if (ctx->report_progress)
     ++		progress = start_delayed_progress(
     ++			_("Writing changed paths Bloom filters index"),
     ++			ctx->commits.nr);
      +
      +	while (list < last) {
      +		struct bloom_filter *filter = get_bloom_filter(ctx->r, *list);
      +		cur_pos += filter->len;
     ++		display_progress(progress, ++i);
      +		hashwrite_be32(f, cur_pos);
      +		list++;
      +	}
     ++
     ++	stop_progress(&progress);
      +}
      +
      +static void write_graph_chunk_bloom_data(struct hashfile *f,
      +					 struct write_commit_graph_context *ctx,
      +					 struct bloom_filter_settings *settings)
      +{
     -+	struct commit **first = ctx->commits.list;
     ++	struct commit **list = ctx->commits.list;
      +	struct commit **last = ctx->commits.list + ctx->commits.nr;
     ++	struct progress *progress = NULL;
     ++	int i = 0;
     ++
     ++	if (ctx->report_progress)
     ++		progress = start_delayed_progress(
     ++			_("Writing changed paths Bloom filters data"),
     ++			ctx->commits.nr);
      +
      +	hashwrite_be32(f, settings->hash_version);
      +	hashwrite_be32(f, settings->num_hashes);
      +	hashwrite_be32(f, settings->bits_per_entry);
      +
     -+	while (first < last) {
     -+		struct bloom_filter *filter = get_bloom_filter(ctx->r, *first);
     ++	while (list < last) {
     ++		struct bloom_filter *filter = get_bloom_filter(ctx->r, *list);
     ++		display_progress(progress, ++i);
      +		hashwrite(f, filter->data, filter->len * sizeof(uint64_t));
     -+		first++;
     ++		list++;
      +	}
     ++
     ++	stop_progress(&progress);
      +}
      +
       static int oid_compare(const void *_a, const void *_b)
       {
       	const struct object_id *a = (const struct object_id *)_a;
     +@@
     + 	load_bloom_filters();
     + 
     + 	if (ctx->report_progress)
     +-		progress = start_progress(
     +-			_("Computing commit diff Bloom filters"),
     ++		progress = start_delayed_progress(
     ++			_("Computing changed paths Bloom filters"),
     + 			ctx->commits.nr);
     + 
     + 	ALLOC_ARRAY(sorted_by_pos, ctx->commits.nr);
      @@
       	struct strbuf progress_title = STRBUF_INIT;
       	int num_chunks = 3;
     @@ -107,7 +200,7 @@
       		chunk_ids[num_chunks] = GRAPH_CHUNKID_EXTRAEDGES;
       		num_chunks++;
       	}
     -+	if (ctx->bloom) {
     ++	if (ctx->changed_paths) {
      +		chunk_ids[num_chunks] = GRAPH_CHUNKID_BLOOMINDEXES;
      +		num_chunks++;
      +		chunk_ids[num_chunks] = GRAPH_CHUNKID_BLOOMDATA;
     @@ -120,11 +213,13 @@
       						4 * ctx->num_extra_edges;
       		num_chunks++;
       	}
     -+	if (ctx->bloom) {
     -+		chunk_offsets[num_chunks + 1] = chunk_offsets[num_chunks] + sizeof(uint32_t) * ctx->commits.nr;
     ++	if (ctx->changed_paths) {
     ++		chunk_offsets[num_chunks + 1] = chunk_offsets[num_chunks] +
     ++						sizeof(uint32_t) * ctx->commits.nr;
      +		num_chunks++;
      +
     -+		chunk_offsets[num_chunks + 1] = chunk_offsets[num_chunks] + sizeof(uint32_t) * 3 + ctx->total_bloom_filter_size;
     ++		chunk_offsets[num_chunks + 1] = chunk_offsets[num_chunks] +
     ++						sizeof(uint32_t) * 3 + ctx->total_bloom_filter_data_size;
      +		num_chunks++;
      +	}
       	if (ctx->num_commit_graphs_after > 1) {
     @@ -134,7 +229,7 @@
       	write_graph_chunk_data(f, hashsz, ctx);
       	if (ctx->num_extra_edges)
       		write_graph_chunk_extra_edges(f, ctx);
     -+	if (ctx->bloom) {
     ++	if (ctx->changed_paths) {
      +		write_graph_chunk_bloom_indexes(f, ctx);
      +		write_graph_chunk_bloom_data(f, ctx, &bloom_settings);
      +	}
     @@ -160,7 +255,16 @@
      +	const unsigned char *chunk_bloom_indexes;
      +	const unsigned char *chunk_bloom_data;
      +
     -+	struct bloom_filter_settings *settings;
     ++	struct bloom_filter_settings *bloom_filter_settings;
       };
       
       struct commit_graph *load_commit_graph_one_fd_st(int fd, struct stat *st);
     +@@
     + 	COMMIT_GRAPH_WRITE_SPLIT      = (1 << 2),
     + 	/* Make sure that each OID in the input is a valid commit OID. */
     + 	COMMIT_GRAPH_WRITE_CHECK_OIDS = (1 << 3),
     +-	COMMIT_GRAPH_WRITE_BLOOM_FILTERS = (1 << 4)
     ++	COMMIT_GRAPH_WRITE_BLOOM_FILTERS = (1 << 4),
     + };
     + 
     + struct split_commit_graph_opts {
  7:  1e2acb37ad !  8:  b20c8d2b20 commit-graph: reuse existing bloom filters during write.
     @@ -1,27 +1,31 @@
      Author: Garima Singh <garima.singh@microsoft.com>
      
     -    commit-graph: reuse existing bloom filters during write.
     +    commit-graph: reuse existing Bloom filters during write.
      
     -    Read previously computed bloom filters from the commit-graph file if possible
     -    to avoid recomputing during commit-graph write.
     +    Read previously computed Bloom filters from the commit-graph file if
     +    possible to avoid recomputing during commit-graph write.
      
     -    Reading from the commit-graph is based on the format in which bloom filters are
     -    written in the commit graph file. See method `fill_filter_from_graph` in bloom.c
     +    See Documentation/technical/commit-graph-format for the format in which
     +    the Bloom filter information is written to the commit graph file.
      
     -    For reading the bloom filter for commit at lexicographic position i:
     -    1. Read BIDX[i] which essentially gives us the starting index in BDAT for filter
     -       of commit i+1 (called the next_index in the code)
     +    To read Bloom filter for a given commit with lexicographic position
     +    'i' we need to:
     +    1. Read BIDX[i] which essentially gives us the starting index in BDAT for
     +       filter of commit i+1. It is essentially the index past the end
     +       of the filter of commit i. It is called end_index in the code.
      
     -    2. For i>0, read BIDX[i-1] which will give us the starting index in BDAT for
     -       filter of commit i (called the prev_index in the code)
     -       For i = 0, prev_index will be 0. The first lexicographic commit's filter will
     -       start at BDAT.
     +    2. For i>0, read BIDX[i-1] which will give us the starting index in BDAT
     +       for filter of commit i. It is called the start_index in the code.
     +       For the first commit, where i = 0, Bloom filter data starts at the
     +       beginning, just past the header in the BDAT chunk. Hence, start_index
     +       will be 0.
      
     -    3. The length of the filter will be next_index - prev_index, because BIDX[i]
     -       gives the cumulative 8-byte words including the ith commit's filter.
     +    3. The length of the filter will be end_index - start_index, because
     +       BIDX[i] gives the cumulative 8-byte words including the ith
     +       commit's filter.
      
     -    We toggle whether bloom filters should be recomputed based on the compute_if_null
     -    flag.
     +    We toggle whether Bloom filters should be recomputed based on the
     +    compute_if_null flag.
      
          Helped-by: Derrick Stolee <dstolee@microsoft.com>
          Signed-off-by: Garima Singh <garima.singh@microsoft.com>
     @@ -41,107 +45,135 @@
       	}
       }
       
     -+static void fill_filter_from_graph(struct commit_graph *g,
     ++static int load_bloom_filter_from_graph(struct commit_graph *g,
      +				   struct bloom_filter *filter,
      +				   struct commit *c)
      +{
     -+	uint32_t lex_pos, prev_index, next_index;
     ++	uint32_t lex_pos, start_index, end_index;
      +
      +	while (c->graph_pos < g->num_commits_in_base)
      +		g = g->base_graph;
      +
     ++	/* The commit graph commit 'c' lives in doesn't carry bloom filters. */
     ++	if (!g->chunk_bloom_indexes)
     ++		return 0;
     ++
      +	lex_pos = c->graph_pos - g->num_commits_in_base;
      +
     -+	next_index = get_be32(g->chunk_bloom_indexes + 4 * lex_pos);
     ++	end_index = get_be32(g->chunk_bloom_indexes + 4 * lex_pos);
     ++
      +	if (lex_pos)
     -+		prev_index = get_be32(g->chunk_bloom_indexes + 4 * (lex_pos - 1));
     ++		start_index = get_be32(g->chunk_bloom_indexes + 4 * (lex_pos - 1));
      +	else
     -+		prev_index = 0;
     ++		start_index = 0;
      +
     -+	filter->len = next_index - prev_index;
     -+	filter->data = (uint64_t *)(g->chunk_bloom_data + 8 * prev_index + 12);
     ++	filter->len = end_index - start_index;
     ++	filter->data = (uint64_t *)(g->chunk_bloom_data +
     ++					sizeof(uint64_t) * start_index +
     ++					BLOOMDATA_CHUNK_HEADER_SIZE);
     ++
     ++	return 1;
      +}
      +
     - void load_bloom_filters(void)
     - {
     - 	init_bloom_filter_slab(&bloom_filters);
     - }
     - 
       struct bloom_filter *get_bloom_filter(struct repository *r,
      -				      struct commit *c)
      +				      struct commit *c,
     -+				      int compute_if_null)
     ++				      int compute_if_not_present)
       {
       	struct bloom_filter *filter;
       	struct bloom_filter_settings settings = DEFAULT_BLOOM_FILTER_SETTINGS;
      @@
     - 	const char *revs_argv[] = {NULL, "HEAD", NULL};
       
       	filter = bloom_filter_slab_at(&bloom_filters, c);
     -+
     + 
      +	if (!filter->data) {
      +		load_commit_graph_info(r, c);
     -+		if (c->graph_pos != COMMIT_NOT_FROM_GRAPH && r->objects->commit_graph->chunk_bloom_indexes) {
     -+			fill_filter_from_graph(r->objects->commit_graph, filter, c);
     -+			return filter;
     ++		if (c->graph_pos != COMMIT_NOT_FROM_GRAPH &&
     ++			r->objects->commit_graph->chunk_bloom_indexes) {
     ++			if (load_bloom_filter_from_graph(r->objects->commit_graph, filter, c))
     ++				return filter;
     ++			else
     ++				return NULL;
      +		}
      +	}
      +
     -+	if (filter->data || !compute_if_null)
     -+			return filter;
     ++	if (filter->data || !compute_if_not_present)
     ++		return filter;
      +
     - 	init_revisions(&revs, NULL);
     - 	revs.diffopt.flags.recursive = 1;
     - 
     -@@
     - 	DIFF_QUEUE_CLEAR(&diff_queued_diff);
     - 
     - 	return filter;
     --}
     - \ No newline at end of file
     -+}
     + 	repo_diff_setup(r, &diffopt);
     + 	diffopt.flags.recursive = 1;
     + 	diffopt.max_changes = max_changes;
      
       diff --git a/bloom.h b/bloom.h
       --- a/bloom.h
       +++ b/bloom.h
      @@
     - void load_bloom_filters(void);
     + 
     + #define DEFAULT_BLOOM_FILTER_SETTINGS { 1, 7, 10 }
     + #define BITS_PER_WORD 64
     ++#define BLOOMDATA_CHUNK_HEADER_SIZE 3*sizeof(uint32_t)
     + 
     + /*
     +  * A bloom_filter struct represents a data segment to
     +@@
     + 					   struct bloom_filter_settings *settings);
       
       struct bloom_filter *get_bloom_filter(struct repository *r,
      -				      struct commit *c);
      +				      struct commit *c,
     -+				      int compute_if_null);
     ++				      int compute_if_not_present);
       
     - void fill_bloom_key(const char *data,
     - 		    int len,
     + int bloom_filter_contains(struct bloom_filter *filter,
     + 			  struct bloom_key *key,
      
       diff --git a/commit-graph.c b/commit-graph.c
       --- a/commit-graph.c
       +++ b/commit-graph.c
      @@
     - 	uint32_t cur_pos = 0;
     + 			ctx->commits.nr);
       
       	while (list < last) {
      -		struct bloom_filter *filter = get_bloom_filter(ctx->r, *list);
      +		struct bloom_filter *filter = get_bloom_filter(ctx->r, *list, 0);
       		cur_pos += filter->len;
     + 		display_progress(progress, ++i);
       		hashwrite_be32(f, cur_pos);
     - 		list++;
      @@
       	hashwrite_be32(f, settings->bits_per_entry);
       
     - 	while (first < last) {
     --		struct bloom_filter *filter = get_bloom_filter(ctx->r, *first);
     -+		struct bloom_filter *filter = get_bloom_filter(ctx->r, *first, 0);
     + 	while (list < last) {
     +-		struct bloom_filter *filter = get_bloom_filter(ctx->r, *list);
     ++		struct bloom_filter *filter = get_bloom_filter(ctx->r, *list, 0);
     + 		display_progress(progress, ++i);
       		hashwrite(f, filter->data, filter->len * sizeof(uint64_t));
     - 		first++;
     - 	}
     + 		list++;
      @@
       
       	for (i = 0; i < ctx->commits.nr; i++) {
     - 		struct commit *c = ctx->commits.list[i];
     + 		struct commit *c = sorted_by_pos[i];
      -		struct bloom_filter *filter = get_bloom_filter(ctx->r, c);
      +		struct bloom_filter *filter = get_bloom_filter(ctx->r, c, 1);
     - 		ctx->total_bloom_filter_size += sizeof(uint64_t) * filter->len;
     + 		ctx->total_bloom_filter_data_size += sizeof(uint64_t) * filter->len;
       		display_progress(progress, i + 1);
       	}
     +@@
     + 		g->data = NULL;
     + 		close(g->graph_fd);
     + 	}
     ++	free(g->bloom_filter_settings);
     + 	free(g->filename);
     + 	free(g);
     + }
     +
     + diff --git a/t/helper/test-bloom.c b/t/helper/test-bloom.c
     + --- a/t/helper/test-bloom.c
     + +++ b/t/helper/test-bloom.c
     +@@
     + 	struct bloom_filter *filter;
     + 	setup_git_directory();
     + 	c = lookup_commit(the_repository, commit_oid);
     +-	filter = get_bloom_filter(the_repository, c);
     ++	filter = get_bloom_filter(the_repository, c, 1);
     + 	print_bloom_filter(filter);
     + }
     + 
  1:  6bdde5e4f0 !  9:  3d7ee0c969 commit-graph: add --changed-paths option to write
     @@ -1,26 +1,13 @@
      Author: Garima Singh <garima.singh@microsoft.com>
      
     -    commit-graph: add --changed-paths option to write
     +    commit-graph: add --changed-paths option to write subcommand
      
          Add --changed-paths option to git commit-graph write. This option will
     -    soon allow users to compute bloom filters for the paths changed between
     -    a commit and its first significant parent, and write this information
     -    into the commit-graph file.
     -
     -    Note: This commit does not change any behavior. It only introduces
     -    the option and passes down the appropriate flag to the commit-graph.
     -
     -    RFC Notes:
     -    1. We named the option --changed-paths to capture what the option does,
     -       instead of how it does it. The current implementation does this
     -       using bloom filters. We believe using --changed-paths however keeps
     -       the implementation open to other data structures.
     -       All thoughts and suggestions for the name and this approach are
     -       welcome
     -
     -    2. Currently, a subsequent commit in this series will add tests that
     -       exercise this option. I plan to split that test commit across the
     -       series as appropriate.
     +    allow users to compute information about the paths that have changed
     +    between a commit and its first parent, and write it into the commit graph
     +    file. If the option is passed to the write subcommand we set the
     +    COMMIT_GRAPH_WRITE_BLOOM_FILTERS flag and pass it down to the
     +    commit-graph logic.
      
          Helped-by: Derrick Stolee <dstolee@microsoft.com>
          Signed-off-by: Garima Singh <garima.singh@microsoft.com>
     @@ -35,7 +22,7 @@
      +With the `--changed-paths` option, compute and write information about the
      +paths changed between a commit and it's first parent. This operation can
      +take a while on large repositories. It provides significant performance gains
     -+for getting file based history logs with `git log`
     ++for getting history of a directory or a file with `git log -- <path>`.
      ++
       With the `--split` option, write the commit-graph as a chain of multiple
       commit-graph files stored in `<dir>/info/commit-graphs`. The new commits
     @@ -66,7 +53,7 @@
       	int split;
       	int shallow;
       	int progress;
     -+	int enable_bloom_filters;
     ++	int enable_changed_paths;
       } opts;
       
       static int graph_verify(int argc, const char **argv)
     @@ -74,7 +61,7 @@
       			N_("start walk at commits listed by stdin")),
       		OPT_BOOL(0, "append", &opts.append,
       			N_("include all commits already in the commit-graph file")),
     -+		OPT_BOOL(0, "changed-paths", &opts.enable_bloom_filters,
     ++		OPT_BOOL(0, "changed-paths", &opts.enable_changed_paths,
      +			N_("enable computation for changed paths")),
       		OPT_BOOL(0, "progress", &opts.progress, N_("force progress reporting")),
       		OPT_BOOL(0, "split", &opts.split,
     @@ -83,22 +70,8 @@
       		flags |= COMMIT_GRAPH_WRITE_SPLIT;
       	if (opts.progress)
       		flags |= COMMIT_GRAPH_WRITE_PROGRESS;
     -+	if (opts.enable_bloom_filters)
     ++	if (opts.enable_changed_paths)
      +		flags |= COMMIT_GRAPH_WRITE_BLOOM_FILTERS;
       
       	read_replace_refs = 0;
       
     -
     - diff --git a/commit-graph.h b/commit-graph.h
     - --- a/commit-graph.h
     - +++ b/commit-graph.h
     -@@
     - 	COMMIT_GRAPH_WRITE_PROGRESS   = (1 << 1),
     - 	COMMIT_GRAPH_WRITE_SPLIT      = (1 << 2),
     - 	/* Make sure that each OID in the input is a valid commit OID. */
     --	COMMIT_GRAPH_WRITE_CHECK_OIDS = (1 << 3)
     -+	COMMIT_GRAPH_WRITE_CHECK_OIDS = (1 << 3),
     -+	COMMIT_GRAPH_WRITE_BLOOM_FILTERS = (1 << 4)
     - };
     - 
     - struct split_commit_graph_opts {
  4:  3182a11f7c <  -:  ---------- commit-graph: document bloom filter format
  6:  85bfdfa59c <  -:  ---------- commit-graph: test commit-graph write --changed-paths
  8:  72a2bbf676 ! 10:  77f1c561e8 revision.c: use bloom filters to speed up path based revision walks
     @@ -1,83 +1,35 @@
      Author: Garima Singh <garima.singh@microsoft.com>
      
     -    revision.c: use bloom filters to speed up path based revision walks
     +    revision.c: use Bloom filters to speed up path based revision walks
      
     -    If bloom filters have been written to the commit-graph file, revision walk will
     -    use them to speed up revision walks for a particular path.
     -    Note: The current implementation does this in the case of single pathspec
     -    case only.
     +    Revision walk will now use Bloom filters for commits to speed up revision
     +    walks for a particular path (for computing history for that path), if they
     +    are present in the commit-graph file.
      
     -    We load the bloom filters during the prepare_revision_walk step when dealing
     -    with a single pathspec. While comparing trees in rev_compare_trees(), if the
     -    bloom filter says that the file is not different between the two trees, we
     -    don't need to compute the expensive diff. This is where we get our performance
     -    gains.
     +    We load the Bloom filters during the prepare_revision_walk step, but only
     +    when dealing with a single pathspec. While comparing trees in
     +    rev_compare_trees(), if the Bloom filter says that the file is not different
     +    between the two trees, we don't need to compute the expensive diff. This is
     +    where we get our performance gains. The other response of the Bloom filter
     +    is `maybe`, in which case we fall back to the full diff calculation to
     +    determine if the path was changed in the commit.
      
          Performance Gains:
     -    We tested the performance of `git log --path` on the git repo, the linux and
     -    some internal large repos, with a variety of paths of varying depths.
     +    We tested the performance of `git log -- <path>` on the git repo, the linux
     +    and some internal large repos, with a variety of paths of varying depths.
      
          On the git and linux repos:
     -    we observed a 2x to 5x speed up.
     +    - we observed a 2x to 5x speed up.
      
          On a large internal repo with files seated 6-10 levels deep in the tree:
     -    we observed 10x to 20x speed ups, with some paths going up to 28 times faster.
     -
     -    RFC Notes:
     -    I plan to collect the folloowing statistics around this usage of bloom filters
     -    and trace them out using trace2.
     -    - number of bloom filter queries,
     -    - number of "No" responses (file hasn't changed)
     -    - number of "Maybe" responses (file may have changed)
     -    - number of "Commit not parsed" cases (commit had too many changes to have a
     -      bloom filter written out, currently our limit is 512 diffs)
     +    - we observed 10x to 20x speed ups, with some paths going up to 28 times
     +      faster.
      
          Helped-by: Derrick Stolee <dstolee@microsoft.com
          Helped-by: SZEDER Gábor <szeder.dev@gmail.com>
          Helped-by: Jonathan Tan <jonathantanmy@google.com>
          Signed-off-by: Garima Singh <garima.singh@microsoft.com>
      
     - diff --git a/bloom.c b/bloom.c
     - --- a/bloom.c
     - +++ b/bloom.c
     -@@
     - 
     - 	return filter;
     - }
     -+
     -+int bloom_filter_contains(struct bloom_filter *filter,
     -+			  struct bloom_key *key,
     -+			  struct bloom_filter_settings *settings)
     -+{
     -+	int i;
     -+	uint64_t mod = filter->len * BITS_PER_BLOCK;
     -+
     -+	if (!mod)
     -+		return 1;
     -+
     -+	for (i = 0; i < settings->num_hashes; i++) {
     -+		uint64_t hash_mod = key->hashes[i] % mod;
     -+		uint64_t block_pos = hash_mod / BITS_PER_BLOCK;
     -+		if (!(filter->data[block_pos] & get_bitmask(hash_mod)))
     -+			return 0;
     -+	}
     -+
     -+	return 1;
     -+}
     -
     - diff --git a/bloom.h b/bloom.h
     - --- a/bloom.h
     - +++ b/bloom.h
     -@@
     - 		    struct bloom_key *key,
     - 		    struct bloom_filter_settings *settings);
     - 
     -+int bloom_filter_contains(struct bloom_filter *filter,
     -+			  struct bloom_key *key,
     -+			  struct bloom_filter_settings *settings);
     -+
     - #endif
     -
       diff --git a/revision.c b/revision.c
       --- a/revision.c
       +++ b/revision.c
     @@ -86,6 +38,7 @@
       #include "hashmap.h"
       #include "utf8.h"
      +#include "bloom.h"
     ++#include "json-writer.h"
       
       volatile show_early_output_fn_t show_early_output;
       
     @@ -93,26 +46,106 @@
       	options->flags.has_changes = 1;
       }
       
     ++static int bloom_filter_atexit_registered;
     ++static unsigned int count_bloom_filter_maybe;
     ++static unsigned int count_bloom_filter_definitely_not;
     ++static unsigned int count_bloom_filter_false_positive;
     ++static unsigned int count_bloom_filter_not_present;
     ++static unsigned int count_bloom_filter_length_zero;
     ++
     ++static void trace2_bloom_filter_statistics_atexit(void)
     ++{
     ++	struct json_writer jw = JSON_WRITER_INIT;
     ++
     ++	jw_object_begin(&jw, 0);
     ++	jw_object_intmax(&jw, "filter_not_present", count_bloom_filter_not_present);
     ++	jw_object_intmax(&jw, "zero_length_filter", count_bloom_filter_length_zero);
     ++	jw_object_intmax(&jw, "maybe", count_bloom_filter_maybe);
     ++	jw_object_intmax(&jw, "definitely_not", count_bloom_filter_definitely_not);
     ++	jw_end(&jw);
     ++
     ++	trace2_data_json("bloom", the_repository, "statistics", &jw);
     ++
     ++	jw_release(&jw);
     ++}
     ++
     ++static void prepare_to_use_bloom_filter(struct rev_info *revs)
     ++{
     ++	struct pathspec_item *pi;
     ++	char *path_alloc = NULL;
     ++	const char *path;
     ++	int last_index;
     ++	int len;
     ++
     ++	if (!revs->commits)
     ++	    return;
     ++
     ++	repo_parse_commit(revs->repo, revs->commits->item);
     ++
     ++	if (!revs->repo->objects->commit_graph)
     ++		return;
     ++
     ++	revs->bloom_filter_settings = revs->repo->objects->commit_graph->bloom_filter_settings;
     ++	if (!revs->bloom_filter_settings)
     ++		return;
     ++
     ++	pi = &revs->pruning.pathspec.items[0];
     ++	last_index = pi->len - 1;
     ++
     ++	if (pi->match[last_index] == '/') {
     ++	    path_alloc = xstrdup(pi->match);
     ++	    path_alloc[last_index] = '\0';
     ++	    path = path_alloc;
     ++	} else
     ++	    path = pi->match;
     ++
     ++	len = strlen(path);
     ++
     ++	revs->bloom_key = xmalloc(sizeof(struct bloom_key));
     ++	fill_bloom_key(path, len, revs->bloom_key, revs->bloom_filter_settings);
     ++
     ++	if (trace2_is_enabled() && !bloom_filter_atexit_registered) {
     ++		atexit(trace2_bloom_filter_statistics_atexit);
     ++		bloom_filter_atexit_registered = 1;
     ++	}
     ++
     ++	free(path_alloc);
     ++}
     ++
      +static int check_maybe_different_in_bloom_filter(struct rev_info *revs,
     -+						 struct commit *commit,
     -+						 struct bloom_key *key,
     -+						 struct bloom_filter_settings *settings)
     ++						 struct commit *commit)
      +{
      +	struct bloom_filter *filter;
     ++	int result;
      +
      +	if (!revs->repo->objects->commit_graph)
      +		return -1;
     ++
      +	if (commit->generation == GENERATION_NUMBER_INFINITY)
      +		return -1;
     -+	if (!key || !settings)
     -+		return -1;
      +
      +	filter = get_bloom_filter(revs->repo, commit, 0);
      +
     -+	if (!filter || !filter->len)
     -+		return 1;
     ++	if (!filter) {
     ++		count_bloom_filter_not_present++;
     ++		return -1;
     ++	}
      +
     -+	return bloom_filter_contains(filter, key, settings);
     ++	if (!filter->len) {
     ++		count_bloom_filter_length_zero++;
     ++		return -1;
     ++	}
     ++
     ++	result = bloom_filter_contains(filter,
     ++				       revs->bloom_key,
     ++				       revs->bloom_filter_settings);
     ++
     ++	if (result)
     ++		count_bloom_filter_maybe++;
     ++	else
     ++		count_bloom_filter_definitely_not++;
     ++
     ++	return result;
      +}
      +
       static int rev_compare_tree(struct rev_info *revs,
     @@ -129,11 +162,8 @@
       			return REV_TREE_SAME;
       	}
       
     -+	if (revs->pruning.pathspec.nr == 1 && !nth_parent) {
     -+		bloom_ret = check_maybe_different_in_bloom_filter(revs,
     -+								  commit,
     -+								  revs->bloom_key,
     -+								  revs->bloom_filter_settings);
     ++	if (revs->pruning.pathspec.nr == 1 && !revs->reflog_info && !nth_parent) {
     ++		bloom_ret = check_maybe_different_in_bloom_filter(revs, commit);
      +
      +		if (bloom_ret == 0)
      +			return REV_TREE_SAME;
     @@ -142,6 +172,16 @@
       	tree_difference = REV_TREE_SAME;
       	revs->pruning.flags.has_changes = 0;
       	if (diff_tree_oid(&t1->object.oid, &t2->object.oid, "",
     + 			   &revs->pruning) < 0)
     + 		return REV_TREE_DIFFERENT;
     ++
     ++	if (!nth_parent)
     ++		if (bloom_ret == 1 && tree_difference == REV_TREE_SAME)
     ++			count_bloom_filter_false_positive++;
     ++
     + 	return tree_difference;
     + }
     + 
      @@
       			die("cannot simplify commit %s (because of %s)",
       			    oid_to_hex(&commit->object.oid),
     @@ -152,45 +192,19 @@
       			if (!revs->simplify_history || !relevant_commit(p)) {
       				/* Even if a merge with an uninteresting
      @@
     + 				       FOR_EACH_OBJECT_PROMISOR_ONLY);
       	}
     - }
       
     -+static void prepare_to_use_bloom_filter(struct rev_info *revs)
     -+{
     -+	struct pathspec_item *pi;
     -+	const char *path;
     -+	size_t len;
     -+
     -+	if (!revs->commits)
     -+	    return;
     -+
     -+	parse_commit(revs->commits->item);
     -+
     -+	if (!revs->repo->objects->commit_graph)
     -+		return;
     -+
     -+	revs->bloom_filter_settings = revs->repo->objects->commit_graph->settings;
     -+	if (!revs->bloom_filter_settings)
     -+		return;
     -+
     -+	pi = &revs->pruning.pathspec.items[0];
     -+	path = pi->match;
     -+	len = strlen(path);
     -+
     -+	load_bloom_filters();
     -+	revs->bloom_key = xmalloc(sizeof(struct bloom_key));
     -+	fill_bloom_key(path, len, revs->bloom_key, revs->bloom_filter_settings);
     -+}
     -+
     - int prepare_revision_walk(struct rev_info *revs)
     - {
     - 	int i;
     ++	if (revs->pruning.pathspec.nr == 1 && !revs->reflog_info)
     ++		prepare_to_use_bloom_filter(revs);
     + 	if (revs->no_walk != REVISION_WALK_NO_WALK_UNSORTED)
     + 		commit_list_sort_by_date(&revs->commits);
     + 	if (revs->no_walk)
      @@
       		simplify_merges(revs);
       	if (revs->children.name)
       		set_children(revs);
     -+	if (revs->pruning.pathspec.nr == 1)
     -+	    prepare_to_use_bloom_filter(revs);
     ++
       	return 0;
       }
       
     @@ -212,12 +226,33 @@
       
       	struct topo_walk_info *topo_walk_info;
      +
     ++	/* Commit graph bloom filter fields */
     ++	/* The bloom filter key for the pathspec */
      +	struct bloom_key *bloom_key;
     ++	/*
     ++	 * The bloom filter settings used to generate the key.
     ++	 * This is loaded from the commit-graph being used.
     ++	 */
      +	struct bloom_filter_settings *bloom_filter_settings;
       };
       
       int ref_excluded(struct string_list *, const char *path);
      
     + diff --git a/t/helper/test-read-graph.c b/t/helper/test-read-graph.c
     + --- a/t/helper/test-read-graph.c
     + +++ b/t/helper/test-read-graph.c
     +@@
     + 		printf(" commit_metadata");
     + 	if (graph->chunk_extra_edges)
     + 		printf(" extra_edges");
     ++	if (graph->chunk_bloom_indexes)
     ++		printf(" bloom_indexes");
     ++	if (graph->chunk_bloom_data)
     ++		printf(" bloom_data");
     + 	printf("\n");
     + 
     + 	UNLEAK(graph);
     +
       diff --git a/t/t4216-log-bloom.sh b/t/t4216-log-bloom.sh
       new file mode 100755
       --- /dev/null
     @@ -228,72 +263,138 @@
      +test_description='git log for a path with bloom filters'
      +. ./test-lib.sh
      +
     -+test_expect_success 'setup repo' '
     ++test_expect_success 'setup test - repo, commits, commit graph, log outputs' '
      +	git init &&
     -+	git config core.commitGraph true &&
     -+	git config gc.writeCommitGraph false &&
     -+	infodir=".git/objects/info" &&
     -+	graphdir="$infodir/commit-graphs" &&
     -+	test_oid_init
     ++	mkdir A A/B A/B/C &&
     ++	test_commit c1 A/file1 &&
     ++	test_commit c2 A/B/file2 &&
     ++	test_commit c3 A/B/C/file3 &&
     ++	test_commit c4 A/file1 &&
     ++	test_commit c5 A/B/file2 &&
     ++	test_commit c6 A/B/C/file3 &&
     ++	test_commit c7 A/file1 &&
     ++	test_commit c8 A/B/file2 &&
     ++	test_commit c9 A/B/C/file3 &&
     ++	git checkout -b side HEAD~4 &&
     ++	test_commit side-1 file4 &&
     ++	git checkout master &&
     ++	git merge side &&
     ++	test_commit c10 file5 &&
     ++	mv file5 file5_renamed &&
     ++	git add file5_renamed &&
     ++	git commit -m "rename" &&
     ++	git commit-graph write --reachable --changed-paths
      +'
     -+
     -+test_expect_success 'create 9 commits and repack' '
     -+	test_commit c1 file1 &&
     -+	test_commit c2 file2 &&
     -+	test_commit c3 file3 &&
     -+	test_commit c4 file1 &&
     -+	test_commit c5 file2 &&
     -+	test_commit c6 file3 &&
     -+	test_commit c7 file1 &&
     -+	test_commit c8 file2 &&
     -+	test_commit c9 file3
     -+'
     -+
     -+printf "c7\nc4\nc1" > expect_file1
     -+
     -+test_expect_success 'log without bloom filters' '
     -+	git log --pretty="format:%s"  -- file1 > actual &&
     -+	test_cmp expect_file1 actual
     -+'
     -+
     -+printf "c8\nc7\nc5\nc4\nc2\nc1" > expect_file1_file2
     -+
     -+test_expect_success 'multi-path log without bloom filters' '
     -+	git log --pretty="format:%s"  -- file1 file2 > actual &&
     -+	test_cmp expect_file1_file2 actual
     -+'
     -+
      +graph_read_expect() {
      +	OPTIONAL=""
      +	NUM_CHUNKS=5
     -+	if test ! -z $2
     -+	then
     -+		OPTIONAL=" $2"
     -+		NUM_CHUNKS=$((3 + $(echo "$2" | wc -w)))
     -+	fi
      +	cat >expect <<- EOF
      +	header: 43475048 1 1 $NUM_CHUNKS 0
      +	num_commits: $1
     -+	chunks: oid_fanout oid_lookup commit_metadata bloom_indexes bloom_data$OPTIONAL
     ++	chunks: oid_fanout oid_lookup commit_metadata bloom_indexes bloom_data
      +	EOF
      +	test-tool read-graph >output &&
      +	test_cmp expect output
      +}
      +
     -+test_expect_success 'write commit graph with bloom filters' '
     -+	git commit-graph write --reachable --changed-paths &&
     -+	test_path_is_file $infodir/commit-graph &&
     -+	graph_read_expect "9"
     ++test_expect_success 'commit-graph write wrote out the bloom chunks' '
     ++	graph_read_expect 13
     ++'
     ++
     ++setup() {
     ++	rm output
     ++	rm "$TRASH_DIRECTORY/trace.perf"
     ++	git -c core.commitGraph=false log --pretty="format:%s" $1 >log_wo_bloom
     ++	GIT_TRACE2_PERF="$TRASH_DIRECTORY/trace.perf" git -c core.commitGraph=true log --pretty="format:%s" $1 >log_w_bloom
     ++}
     ++
     ++test_bloom_filters_used() {
     ++	log_args=$1
     ++	bloom_trace_prefix="statistics:{\"filter_not_present\":0,\"zero_length_filter\":0,\"maybe\""
     ++	setup "$log_args"
     ++	grep -q "$bloom_trace_prefix" "$TRASH_DIRECTORY/trace.perf" && test_cmp log_wo_bloom log_w_bloom
     ++}
     ++
     ++test_bloom_filters_not_used() {
     ++	log_args=$1
     ++	setup "$log_args"
     ++	!(grep -q "statistics:{\"filter_not_present\":" "$TRASH_DIRECTORY/trace.perf") && test_cmp log_wo_bloom log_w_bloom
     ++}
     ++
     ++for path in A A/B A/B/C A/file1 A/B/file2 A/B/C/file3 file4 file5_renamed
     ++do
     ++	for option in "" \
     ++		      "--full-history" \
     ++		      "--full-history --simplify-merges" \
     ++		      "--simplify-merges" \
     ++		      "--simplify-by-decoration" \
     ++		      "--follow" \
     ++		      "--first-parent" \
     ++		      "--topo-order" \
     ++		      "--date-order" \
     ++		      "--author-date-order" \
     ++		      "--ancestry-path side..master"
     ++	do
     ++		test_expect_success "git log option: $option for path: $path" '
     ++			test_bloom_filters_used "$option -- $path"
     ++		'
     ++	done
     ++done
     ++
     ++test_expect_success 'git log -- folder works with and without the trailing slash' '
     ++	test_bloom_filters_used "-- A" &&
     ++	test_bloom_filters_used "-- A/"
     ++'
     ++
     ++test_expect_success 'git log for path that does not exist. ' '
     ++	test_bloom_filters_used "-- path_does_not_exist"
     ++'
     ++
     ++test_expect_success 'git log with --walk-reflogs does not use bloom filters' '
     ++	test_bloom_filters_not_used "--walk-reflogs -- A"
     ++'
     ++
     ++test_expect_success 'git log -- multiple path specs does not use bloom filters' '
     ++	test_bloom_filters_not_used "-- file4 A/file1"
     ++'
     ++
     ++test_expect_success 'git log with wildcard that resolves to a single path uses bloom filters' '
     ++	test_bloom_filters_used "-- *4" &&
     ++	test_bloom_filters_used "-- *renamed"
      +'
      +
     -+test_expect_success 'log using bloom filters' '
     -+	git log --pretty="format:%s" -- file1 > actual &&
     -+	test_cmp expect_file1 actual
     ++test_expect_success 'git log with wildcard that resolves to a multiple paths does not uses bloom filters' '
     ++	test_bloom_filters_not_used "-- *" &&
     ++	test_bloom_filters_not_used "-- file*"
      +'
      +
     -+test_expect_success 'multi-path log using bloom filters' '
     -+	git log --pretty="format:%s"  -- file1 file2 > actual &&
     -+	test_cmp expect_file1_file2 actual
     ++test_expect_success 'setup - add commit-graph to the chain without bloom filters' '
     ++	test_commit c14 A/anotherFile2 &&
     ++	test_commit c15 A/B/anotherFile2 &&
     ++	test_commit c16 A/B/C/anotherFile2 &&
     ++	GIT_TEST_COMMIT_GRAPH_CHANGED_PATHS=0 git commit-graph write --reachable --split &&
     ++	test_line_count = 2 .git/objects/info/commit-graphs/commit-graph-chain
     ++'
     ++
     ++test_expect_success 'git log does not use bloom filters if the latest graph does not have bloom filters.' '
     ++	test_bloom_filters_not_used "-- A/B"
     ++'
     ++
     ++test_expect_success 'setup - add commit-graph to the chain with bloom filters' '
     ++	test_commit c17 A/anotherFile3 &&
     ++	git commit-graph write --reachable --changed-paths --split &&
     ++	test_line_count = 3 .git/objects/info/commit-graphs/commit-graph-chain
     ++'
     ++
     ++test_bloom_filters_used_when_some_filters_are_missing() {
     ++	log_args=$1
     ++	bloom_trace_prefix="statistics:{\"filter_not_present\":3,\"zero_length_filter\":0,\"maybe\":6,\"definitely_not\":6"
     ++	setup "$log_args"
     ++	grep -q "$bloom_trace_prefix" "$TRASH_DIRECTORY/trace.perf" && test_cmp log_wo_bloom log_w_bloom
     ++}
     ++
     ++test_expect_success 'git log uses bloom filters if they exist in the latest but not all commit graphs in the chain.' '
     ++	test_bloom_filters_used_when_some_filters_are_missing "-- A/B"
      +'
      +
      +test_done
  9:  e1c315d0a7 ! 11:  e1b076a714 commit-graph: add GIT_TEST_COMMIT_GRAPH_BLOOM_FILTERS test flag
     @@ -1,14 +1,15 @@
      Author: Garima Singh <garima.singh@microsoft.com>
      
     -    commit-graph: add GIT_TEST_COMMIT_GRAPH_BLOOM_FILTERS test flag
     +    commit-graph: add GIT_TEST_COMMIT_GRAPH_CHANGED_PATHS test flag
      
     -    Add GIT_TEST_COMMIT_GRAPH_BLOOM_FILTERS test flag to the test setup suite in
     -    order to toggle writing bloom filters when running any of the git tests. If set
     -    to true, we will compute and write bloom filters every time a test calls
     -    `git commit-graph write`.
     +    Add GIT_TEST_COMMIT_GRAPH_CHANGED_PATHS test flag to the test setup suite
     +    in order to toggle writing Bloom filters when running any of the git tests.
     +    If set to true, we will compute and write Bloom filters every time a test
     +    calls `git commit-graph write`, as if the `--changed-paths` option was
     +    passed in.
      
          The test suite passes when GIT_TEST_COMMIT_GRAPH and
     -    GIT_COMMIT_GRAPH_BLOOM_FILTERS are enabled.
     +    GIT_TEST_COMMIT_GRAPH_CHANGED_PATHS are enabled.
      
          Helped-by: Derrick Stolee <dstolee@microsoft.com>
          Signed-off-by: Garima Singh <garima.singh@microsoft.com>
     @@ -20,8 +21,9 @@
       		flags |= COMMIT_GRAPH_WRITE_SPLIT;
       	if (opts.progress)
       		flags |= COMMIT_GRAPH_WRITE_PROGRESS;
     --	if (opts.enable_bloom_filters)
     -+	if (opts.enable_bloom_filters || git_env_bool(GIT_TEST_COMMIT_GRAPH_BLOOM_FILTERS, 0))
     +-	if (opts.enable_changed_paths)
     ++	if (opts.enable_changed_paths ||
     ++	    git_env_bool(GIT_TEST_COMMIT_GRAPH_CHANGED_PATHS, 0))
       		flags |= COMMIT_GRAPH_WRITE_BLOOM_FILTERS;
       
       	read_replace_refs = 0;
     @@ -33,7 +35,7 @@
       	export GIT_TEST_OE_SIZE=10
       	export GIT_TEST_OE_DELTA_SIZE=5
       	export GIT_TEST_COMMIT_GRAPH=1
     -+	export GIT_TEST_COMMIT_GRAPH_BLOOM_FILTERS=1
     ++	export GIT_TEST_COMMIT_GRAPH_CHANGED_PATHS=1
       	export GIT_TEST_MULTI_PACK_INDEX=1
       	make test
       	;;
     @@ -45,7 +47,7 @@
       
       #define GIT_TEST_COMMIT_GRAPH "GIT_TEST_COMMIT_GRAPH"
       #define GIT_TEST_COMMIT_GRAPH_DIE_ON_LOAD "GIT_TEST_COMMIT_GRAPH_DIE_ON_LOAD"
     -+#define GIT_TEST_COMMIT_GRAPH_BLOOM_FILTERS "GIT_TEST_COMMIT_GRAPH_BLOOM_FILTERS"
     ++#define GIT_TEST_COMMIT_GRAPH_CHANGED_PATHS "GIT_TEST_COMMIT_GRAPH_CHANGED_PATHS"
       
       struct commit;
       struct bloom_filter_settings;
     @@ -57,8 +59,10 @@
       be written after every 'git commit' command, and overrides the
       'core.commitGraph' setting to true.
       
     -+GIT_TEST_COMMIT_GRAPH_BLOOM_FILTERS=<boolean>, when true, forces commit-graph
     -+write to compute and write bloom filters for every 'git commit-graph write'
     ++GIT_TEST_COMMIT_GRAPH_CHANGED_PATHS=<boolean>, when true, forces
     ++commit-graph write to compute and write changed path Bloom filters for
     ++every 'git commit-graph write', as if the `--changed-paths` option was
     ++passed in.
      +
       GIT_TEST_FSMONITOR=$PWD/t7519/fsmonitor-all exercises the fsmonitor
       code path for utilizing a file system monitor to speed up detecting
     @@ -72,11 +76,11 @@
       . ./test-lib.sh
       
      +GIT_TEST_COMMIT_GRAPH=0
     -+GIT_TEST_COMMIT_GRAPH_BLOOM_FILTERS=0
     ++GIT_TEST_COMMIT_GRAPH_CHANGED_PATHS=0
      +
     - test_expect_success 'setup repo' '
     + test_expect_success 'setup test - repo, commits, commit graph, log outputs' '
       	git init &&
     - 	git config core.commitGraph true &&
     + 	mkdir A A/B A/B/C &&
      
       diff --git a/t/t5318-commit-graph.sh b/t/t5318-commit-graph.sh
       --- a/t/t5318-commit-graph.sh
     @@ -85,7 +89,7 @@
       test_description='commit graph'
       . ./test-lib.sh
       
     -+GIT_TEST_COMMIT_GRAPH_BLOOM_FILTERS=0
     ++GIT_TEST_COMMIT_GRAPH_CHANGED_PATHS=0
      +
       test_expect_success 'setup full repo' '
       	mkdir full &&
     @@ -98,21 +102,7 @@
       . ./test-lib.sh
       
       GIT_TEST_COMMIT_GRAPH=0
     -+GIT_TEST_COMMIT_GRAPH_BLOOM_FILTERS=0
     ++GIT_TEST_COMMIT_GRAPH_CHANGED_PATHS=0
       
       test_expect_success 'setup repo' '
       	git init &&
     -
     - diff --git a/t/t5325-commit-graph-bloom.sh b/t/t5325-commit-graph-bloom.sh
     - --- a/t/t5325-commit-graph-bloom.sh
     - +++ b/t/t5325-commit-graph-bloom.sh
     -@@
     - test_description='commit graph with bloom filters'
     - . ./test-lib.sh
     - 
     -+GIT_TEST_COMMIT_GRAPH=0
     -+GIT_TEST_COMMIT_GRAPH_BLOOM_FILTERS=0
     -+
     - test_expect_success 'setup repo' '
     - 	git init &&
     - 	git config core.commitGraph true &&

-- 
gitgitgadget
