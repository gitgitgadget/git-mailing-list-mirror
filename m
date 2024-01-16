Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A678E208C9
	for <git@vger.kernel.org>; Tue, 16 Jan 2024 22:09:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705442947; cv=none; b=pgRCKd0V7Rk21kxWi7wCM1+t4gPFUC8BDEaSBflg8iHOjqJjUkDbtiVoOAkSfOMXQjy8qmafwKD1UKfmKXuVORtOAhgu4LlQTkZHHolQWEiAqv8Q2qSL3C2AJ0xeBkKQKF2nAhx8fquPg5NQsOtsDO6SPW9TH8x8xudQ5Qm8oZ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705442947; c=relaxed/simple;
	bh=rqd475pZHTCyd37GIuj0vL8XBugeRoJs1Y5air2BRzI=;
	h=Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Google-Smtp-Source:X-Received:Received:Date:
	 From:To:Cc:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:Content-Transfer-Encoding:In-Reply-To; b=EBqRer7Qd/FrRZt1HWyFMf2+X0hlzruAriT1PwjrUQzhbijKBZpdczcPKvnh2PERXSZsqmlxjPrcfpz5pI+jXl/J9IRGpBoSiaVcGs9flkCx1KYZkCdRYEOWboRgMvecTFbwWvYpceXy4SluSJ8gTestni3Q5JpSUiEBs4D7NEo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=none smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=b739ErID; arc=none smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="b739ErID"
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-427ca22a680so71685631cf.3
        for <git@vger.kernel.org>; Tue, 16 Jan 2024 14:09:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1705442944; x=1706047744; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=s2vBTqXM7/SGmptpc3up499wESWf9PBW4OrXpExMd58=;
        b=b739ErIDcNXeZB9IZAPXZXZeArsxA99eePGaV5pkpXmrLj8+p3SvRSEwXhqN2clNfG
         +Np5CbhglY9UhXDCHaPCRdxNx2CbOqzWl0NovvS8zITgxswPEONs9WrexRlIjxYDenD9
         8cSyZkoehSiBvrrlAq05E0VYDpDWROUHXpGC/ek9hdphkGgi6s9IuGxWJpcl8i3rBHM4
         rzhXBudoJqfW4Frag5hy/5PZpPtLnStLY2UM7EbGIa8j4JEljuMYo7vwdmiE/EgodFuP
         r/IXyJQv+Fx7jva3fM7iKKVWYUlizUKPMO7xTWFEQPSibcihWZAi3YgU05yf5agKgK57
         TwhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705442944; x=1706047744;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=s2vBTqXM7/SGmptpc3up499wESWf9PBW4OrXpExMd58=;
        b=WNHVkedn+ZZ7K2CscO9X+4dv4EbcbOOFAdOHLHBTLxmlGxH53Hrbx1/qCpPZGe1OTc
         S6yD3Rq2G0xiFXZfkKxbuR928Nno4yEyPjkSyOThiaoCXg2K2pP8HmYezUACNs9Kyafl
         h9d2zrfaSm3XrL4G3iY7Rm0xngpZf46OzVIVu7vyngV2LkdGKpg/Nhuzi+UFA6vygouA
         Vx1uObcuQ7MPuzQ9B1+5lWjOyTRc+jZvElEbr1Fs4MpQOp4uK7srmWFCK9XXPX9Kvd6x
         pAyJkdO+kW/CrIW9+ZOQSZ4FLrmAjpgNyEPWOogEHaFQ+nGeP//Ai5hiPX127rBY67Rz
         /WBw==
X-Gm-Message-State: AOJu0YwnBO+4wSf3rnESSdNrU4zgv++wxmkTUgbV7tz4/nYxx/OnXM3M
	TdVQQJ8SOqeeZenFfCC7fDCs/wTDWVIAzB0LQvvcDmUK0Trqnw==
X-Google-Smtp-Source: AGHT+IG78ME16YLv+Y9elnUnnTv4hYs3bjHvpKzydLr6Rzx6mE15WLEolqcBsbOzgtF/d7/rOi5lMA==
X-Received: by 2002:ac8:5c85:0:b0:429:9e31:1615 with SMTP id r5-20020ac85c85000000b004299e311615mr10547012qta.123.1705442944063;
        Tue, 16 Jan 2024 14:09:04 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id ay37-20020a05622a22a500b0042a09ce6150sm566900qtb.70.2024.01.16.14.09.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jan 2024 14:09:03 -0800 (PST)
Date: Tue, 16 Jan 2024 17:08:56 -0500
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Elijah Newren <newren@gmail.com>,
	"Eric W. Biederman" <ebiederm@gmail.com>, Jeff King <peff@peff.net>,
	Junio C Hamano <gitster@pobox.com>, Patrick Steinhardt <ps@pks.im>,
	Jonathan Tan <jonathantanmy@google.com>,
	SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
Subject: [PATCH v5 00/17] bloom: changed-path Bloom filters v2 (& sundries)
Message-ID: <cover.1705442923.git.me@ttaylorr.com>
References: <cover.1697653929.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover.1697653929.git.me@ttaylorr.com>

(Rebased onto the tip of 'master', which is d4dbce1db5 (The seventh
batch, 2024-01-12), at the time of writing).

This series is a reroll of the combined efforts of [1] and [2] to
introduce the v2 changed-path Bloom filters, which fixes a bug in our
existing implementation of murmur3 paths with non-ASCII characters (when
the "char" type is signed).

In large part, this is the same as the previous round. Like last time,
this round addresses the remaining additional issues pointed out by
SZEDER Gábor. The remaining issues which have been addressed by this
series are:

  - Incorrectly reading Bloom filters computed with differing hash
    versions. This has been corrected by discarding them when a version
    mismatch is detected.

  - Added a note about the new `commitGraph.changedPathVersion`
    configuration variable which can cause (un-fixable, see [3])
    issues in earlier versions of Git which do not yet understand them.

Thanks to Jonathan, Peff, and SZEDER who have helped a great deal in
assembling these patches. As usual, a range-diff is included below.

Thanks in advance for your review!

[1]: https://lore.kernel.org/git/cover.1684790529.git.jonathantanmy@google.com/
[2]: https://lore.kernel.org/git/cover.1691426160.git.me@ttaylorr.com/
[3]: https://lore.kernel.org/git/Zabr1Glljjgl%2FUUB@nand.local/

Jonathan Tan (1):
  gitformat-commit-graph: describe version 2 of BDAT

Taylor Blau (16):
  t/t4216-log-bloom.sh: harden `test_bloom_filters_not_used()`
  revision.c: consult Bloom filters for root commits
  commit-graph: ensure Bloom filters are read with consistent settings
  t/helper/test-read-graph.c: extract `dump_graph_info()`
  bloom.h: make `load_bloom_filter_from_graph()` public
  t/helper/test-read-graph: implement `bloom-filters` mode
  t4216: test changed path filters with high bit paths
  repo-settings: introduce commitgraph.changedPathsVersion
  commit-graph: new Bloom filter version that fixes murmur3
  bloom: annotate filters with hash version
  bloom: prepare to discard incompatible Bloom filters
  commit-graph.c: unconditionally load Bloom filters
  commit-graph: drop unnecessary `graph_read_bloom_data_context`
  object.h: fix mis-aligned flag bits table
  commit-graph: reuse existing Bloom filters where possible
  bloom: introduce `deinit_bloom_filters()`

 Documentation/config/commitgraph.txt     |  29 ++-
 Documentation/gitformat-commit-graph.txt |   9 +-
 bloom.c                                  | 208 ++++++++++++++-
 bloom.h                                  |  38 ++-
 commit-graph.c                           |  64 ++++-
 object.h                                 |   3 +-
 oss-fuzz/fuzz-commit-graph.c             |   2 +-
 repo-settings.c                          |   6 +-
 repository.h                             |   2 +-
 revision.c                               |  26 +-
 t/helper/test-bloom.c                    |   9 +-
 t/helper/test-read-graph.c               |  67 ++++-
 t/t0095-bloom.sh                         |   8 +
 t/t4216-log-bloom.sh                     | 310 ++++++++++++++++++++++-
 14 files changed, 724 insertions(+), 57 deletions(-)

Range-diff against v4:
 1:  e0fc51c3fb !  1:  c5e1b3e507 t/t4216-log-bloom.sh: harden `test_bloom_filters_not_used()`
    @@ Commit message
         checking for the absence of any data from it from trace2.
     
         In the following commit, it will become possible to load Bloom filters
    -    without using them (e.g., because `commitGraph.changedPathVersion` is
    -    incompatible with the hash version with which the commit-graph's Bloom
    -    filters were written).
    +    without using them (e.g., because the `commitGraph.changedPathVersion`
    +    introduced later in this series is incompatible with the hash version
    +    with which the commit-graph's Bloom filters were written).
     
         When this is the case, it's possible to initialize the Bloom filter
         sub-system, while still not using any Bloom filters. When this is the
 2:  87b09e6266 !  2:  8f32fd5f46 revision.c: consult Bloom filters for root commits
    @@ revision.c: static int rev_compare_tree(struct rev_info *revs,
     +				  int nth_parent)
      {
      	struct tree *t1 = repo_get_commit_tree(the_repository, commit);
    -+	int bloom_ret = 1;
    ++	int bloom_ret = -1;
      
      	if (!t1)
      		return 0;
      
    -+	if (nth_parent == 1 && revs->bloom_keys_nr) {
    ++	if (!nth_parent && revs->bloom_keys_nr) {
     +		bloom_ret = check_maybe_different_in_bloom_filter(revs, commit);
     +		if (!bloom_ret)
     +			return 1;
    @@ revision.c: static void try_to_simplify_commit(struct rev_info *revs, struct com
     +		 * (if one exists) is relative to the empty tree, using Bloom
     +		 * filters is allowed here.
     +		 */
    -+		if (rev_same_tree_as_empty(revs, commit, 1))
    ++		if (rev_same_tree_as_empty(revs, commit, 0))
      			commit->object.flags |= TREESAME;
      		return;
      	}
 3:  46d8a41005 !  3:  285b25f1b7 commit-graph: ensure Bloom filters are read with consistent settings
    @@ t/t4216-log-bloom.sh: test_expect_success 'Bloom generation backfills empty comm
     +	test_must_be_empty err
     +'
     +
    - test_done
    + corrupt_graph () {
    +-	graph=.git/objects/info/commit-graph &&
    + 	test_when_finished "rm -rf $graph" &&
    + 	git commit-graph write --reachable --changed-paths &&
    + 	corrupt_chunk_file $graph "$@"
 4:  4d0190a992 =  4:  0cee8078d4 gitformat-commit-graph: describe version 2 of BDAT
 5:  3c2057c11c =  5:  1fc8d2828d t/helper/test-read-graph.c: extract `dump_graph_info()`
 6:  e002e35004 !  6:  03dd7cf30a bloom.h: make `load_bloom_filter_from_graph()` public
    @@ Commit message
         Signed-off-by: Taylor Blau <me@ttaylorr.com>
     
      ## bloom.c ##
    -@@ bloom.c: static inline unsigned char get_bitmask(uint32_t pos)
    - 	return ((unsigned char)1) << (pos & (BITS_PER_WORD - 1));
    +@@ bloom.c: static int check_bloom_offset(struct commit_graph *g, uint32_t pos,
    + 	return -1;
      }
      
     -static int load_bloom_filter_from_graph(struct commit_graph *g,
 7:  c7016f51cd =  7:  dd9193e404 t/helper/test-read-graph: implement `bloom-filters` mode
 8:  cef2aac8ba !  8:  aa2416795d t4216: test changed path filters with high bit paths
    @@
      ## Metadata ##
    -Author: Jonathan Tan <jonathantanmy@google.com>
    +Author: Taylor Blau <me@ttaylorr.com>
     
      ## Commit message ##
         t4216: test changed path filters with high bit paths
    @@ t/t4216-log-bloom.sh: test_expect_success 'merge graph layers with incompatible
     +	)
     +'
     +
    - test_done
    + corrupt_graph () {
    + 	test_when_finished "rm -rf $graph" &&
    + 	git commit-graph write --reachable --changed-paths &&
 9:  36d4e2202e !  9:  a77dcc99b4 repo-settings: introduce commitgraph.changedPathsVersion
    @@
      ## Metadata ##
    -Author: Jonathan Tan <jonathantanmy@google.com>
    +Author: Taylor Blau <me@ttaylorr.com>
     
      ## Commit message ##
         repo-settings: introduce commitgraph.changedPathsVersion
    @@ Documentation/config/commitgraph.txt: commitGraph.maxNewFilters::
     +
     +commitGraph.changedPathsVersion::
     +	Specifies the version of the changed-path Bloom filters that Git will read and
    -+	write. May be -1, 0 or 1.
    ++	write. May be -1, 0 or 1. Note that values greater than 1 may be
    ++	incompatible with older versions of Git which do not yet understand
    ++	those versions. Use caution when operating in a mixed-version
    ++	environment.
     ++
     +Defaults to -1.
     ++
    @@ commit-graph.c: struct commit_graph *parse_commit_graph(struct repo_settings *s,
      
     -	if (s->commit_graph_read_changed_paths) {
     +	if (s->commit_graph_changed_paths_version) {
    - 		pair_chunk(cf, GRAPH_CHUNKID_BLOOMINDEXES,
    - 			   &graph->chunk_bloom_indexes);
    + 		read_chunk(cf, GRAPH_CHUNKID_BLOOMINDEXES,
    + 			   graph_read_bloom_index, graph);
      		read_chunk(cf, GRAPH_CHUNKID_BLOOMDATA,
    +@@ commit-graph.c: static void validate_mixed_bloom_settings(struct commit_graph *g)
    + 		}
    + 
    + 		if (g->bloom_filter_settings->bits_per_entry != settings->bits_per_entry ||
    +-		    g->bloom_filter_settings->num_hashes != settings->num_hashes) {
    ++		    g->bloom_filter_settings->num_hashes != settings->num_hashes ||
    ++		    g->bloom_filter_settings->hash_version != settings->hash_version) {
    + 			g->chunk_bloom_indexes = NULL;
    + 			g->chunk_bloom_data = NULL;
    + 			FREE_AND_NULL(g->bloom_filter_settings);
     
      ## oss-fuzz/fuzz-commit-graph.c ##
     @@ oss-fuzz/fuzz-commit-graph.c: int LLVMFuzzerTestOneInput(const uint8_t *data, size_t size)
    @@ repository.h: struct repo_settings {
      	int gc_write_commit_graph;
      	int fetch_write_commit_graph;
      	int command_requires_full_index;
    +
    + ## t/t4216-log-bloom.sh ##
    +@@ t/t4216-log-bloom.sh: test_expect_success 'setup for mixed Bloom setting tests' '
    + 	done
    + '
    + 
    +-test_expect_success 'ensure incompatible Bloom filters are ignored' '
    ++test_expect_success 'ensure Bloom filters with incompatible settings are ignored' '
    + 	# Compute Bloom filters with "unusual" settings.
    + 	git -C $repo rev-parse one >in &&
    + 	GIT_TEST_BLOOM_SETTINGS_NUM_HASHES=3 git -C $repo commit-graph write \
    +@@ t/t4216-log-bloom.sh: test_expect_success 'merge graph layers with incompatible Bloom settings' '
    + 	test_must_be_empty err
    + '
    + 
    ++test_expect_success 'ensure Bloom filter with incompatible versions are ignored' '
    ++	rm "$repo/$graph" &&
    ++
    ++	git -C $repo log --oneline --no-decorate -- $CENT >expect &&
    ++
    ++	# Compute v1 Bloom filters for commits at the bottom.
    ++	git -C $repo rev-parse HEAD^ >in &&
    ++	git -C $repo commit-graph write --stdin-commits --changed-paths \
    ++		--split <in &&
    ++
    ++	# Compute v2 Bloomfilters for the rest of the commits at the top.
    ++	git -C $repo rev-parse HEAD >in &&
    ++	git -C $repo -c commitGraph.changedPathsVersion=2 commit-graph write \
    ++		--stdin-commits --changed-paths --split=no-merge <in &&
    ++
    ++	test_line_count = 2 $repo/$chain &&
    ++
    ++	git -C $repo log --oneline --no-decorate -- $CENT >actual 2>err &&
    ++	test_cmp expect actual &&
    ++
    ++	layer="$(head -n 1 $repo/$chain)" &&
    ++	cat >expect.err <<-EOF &&
    ++	warning: disabling Bloom filters for commit-graph layer $SQ$layer$SQ due to incompatible settings
    ++	EOF
    ++	test_cmp expect.err err
    ++'
    ++
    + get_first_changed_path_filter () {
    + 	test-tool read-graph bloom-filters >filters.dat &&
    + 	head -n 1 filters.dat
10:  f6ab427ead ! 10:  f0f22e852c commit-graph: new filter ver. that fixes murmur3
    @@
      ## Metadata ##
    -Author: Jonathan Tan <jonathantanmy@google.com>
    +Author: Taylor Blau <me@ttaylorr.com>
     
      ## Commit message ##
    -    commit-graph: new filter ver. that fixes murmur3
    +    commit-graph: new Bloom filter version that fixes murmur3
     
         The murmur3 implementation in bloom.c has a bug when converting series
         of 4 bytes into network-order integers when char is signed (which is
    @@ Documentation/config/commitgraph.txt: commitGraph.readChangedPaths::
      
      commitGraph.changedPathsVersion::
      	Specifies the version of the changed-path Bloom filters that Git will read and
    --	write. May be -1, 0 or 1.
    -+	write. May be -1, 0, 1, or 2.
    - +
    - Defaults to -1.
    - +
    +-	write. May be -1, 0 or 1. Note that values greater than 1 may be
    ++	write. May be -1, 0, 1, or 2. Note that values greater than 1 may be
    + 	incompatible with older versions of Git which do not yet understand
    + 	those versions. Use caution when operating in a mixed-version
    + 	environment.
     @@ Documentation/config/commitgraph.txt: filters when instructed to write.
      If 1, Git will only read version 1 Bloom filters, and will write version 1
      Bloom filters.
    @@ bloom.h: int load_bloom_filter_from_graph(struct commit_graph *g,
      		    size_t len,
     
      ## commit-graph.c ##
    -@@ commit-graph.c: static int graph_read_oid_lookup(const unsigned char *chunk_start,
    +@@ commit-graph.c: static int graph_read_bloom_index(const unsigned char *chunk_start,
      	return 0;
      }
      
    @@ commit-graph.c: static int graph_read_oid_lookup(const unsigned char *chunk_star
     +	struct graph_read_bloom_data_context *c = data;
     +	struct commit_graph *g = c->g;
      	uint32_t hash_version;
    --	g->chunk_bloom_data = chunk_start;
    - 	hash_version = get_be32(chunk_start);
      
    --	if (hash_version != 1)
    -+	if (*c->commit_graph_changed_paths_version == -1) {
    + 	if (chunk_size < BLOOMDATA_CHUNK_HEADER_SIZE) {
    +@@ commit-graph.c: static int graph_read_bloom_data(const unsigned char *chunk_start,
    + 		return -1;
    + 	}
    + 
    ++	hash_version = get_be32(chunk_start);
    ++
    ++	if (*c->commit_graph_changed_paths_version == -1)
     +		*c->commit_graph_changed_paths_version = hash_version;
    -+	} else if (hash_version != *c->commit_graph_changed_paths_version) {
    - 		return 0;
    -+	}
    - 
    -+	g->chunk_bloom_data = chunk_start;
    ++	else if (hash_version != *c->commit_graph_changed_paths_version)
    ++		return 0;
    ++
    + 	g->chunk_bloom_data = chunk_start;
    + 	g->chunk_bloom_data_size = chunk_size;
    +-	hash_version = get_be32(chunk_start);
    +-
    +-	if (hash_version != 1)
    +-		return 0;
    +-
      	g->bloom_filter_settings = xmalloc(sizeof(struct bloom_filter_settings));
      	g->bloom_filter_settings->hash_version = hash_version;
      	g->bloom_filter_settings->num_hashes = get_be32(chunk_start + 4);
    @@ commit-graph.c: struct commit_graph *parse_commit_graph(struct repo_settings *s,
     +			.g = graph,
     +			.commit_graph_changed_paths_version = &s->commit_graph_changed_paths_version
     +		};
    - 		pair_chunk(cf, GRAPH_CHUNKID_BLOOMINDEXES,
    - 			   &graph->chunk_bloom_indexes);
    + 		read_chunk(cf, GRAPH_CHUNKID_BLOOMINDEXES,
    + 			   graph_read_bloom_index, graph);
      		read_chunk(cf, GRAPH_CHUNKID_BLOOMDATA,
     -			   graph_read_bloom_data, graph);
     +			   graph_read_bloom_data, &context);
    @@ t/t4216-log-bloom.sh: test_expect_success 'version 1 changed-path used when vers
     +	)
     +'
     +
    - test_done
    + corrupt_graph () {
    + 	test_when_finished "rm -rf $graph" &&
    + 	git commit-graph write --reachable --changed-paths &&
11:  dc69b28329 = 11:  b56e94cad7 bloom: annotate filters with hash version
12:  85dbdc4ed2 = 12:  ddfd1ba32a bloom: prepare to discard incompatible Bloom filters
13:  3ff669a622 ! 13:  72aabd289b commit-graph.c: unconditionally load Bloom filters
    @@ Metadata
      ## Commit message ##
         commit-graph.c: unconditionally load Bloom filters
     
    -    In 9e4df4da07 (commit-graph: new filter ver. that fixes murmur3,
    -    2023-08-01), we began ignoring the Bloom data ("BDAT") chunk for
    -    commit-graphs whose Bloom filters were computed using a hash version
    -    incompatible with the value of `commitGraph.changedPathVersion`.
    +    In an earlier commit, we began ignoring the Bloom data ("BDAT") chunk
    +    for commit-graphs whose Bloom filters were computed using a hash version
    +      incompatible with the value of `commitGraph.changedPathVersion`.
     
         Now that the Bloom API has been hardened to discard these incompatible
         filters (with the exception of low-level APIs), we can safely load these
    @@ Commit message
     
      ## commit-graph.c ##
     @@ commit-graph.c: static int graph_read_bloom_data(const unsigned char *chunk_start,
    - 	uint32_t hash_version;
    + 
      	hash_version = get_be32(chunk_start);
      
    --	if (*c->commit_graph_changed_paths_version == -1) {
    +-	if (*c->commit_graph_changed_paths_version == -1)
     -		*c->commit_graph_changed_paths_version = hash_version;
    --	} else if (hash_version != *c->commit_graph_changed_paths_version) {
    +-	else if (hash_version != *c->commit_graph_changed_paths_version)
     -		return 0;
    --	}
     -
      	g->chunk_bloom_data = chunk_start;
    + 	g->chunk_bloom_data_size = chunk_size;
      	g->bloom_filter_settings = xmalloc(sizeof(struct bloom_filter_settings));
    - 	g->bloom_filter_settings->hash_version = hash_version;
     @@ commit-graph.c: int write_commit_graph(struct object_directory *odb,
      	ctx->write_generation_data = (get_configured_generation_version(r) == 2);
      	ctx->num_generation_data_overflows = 0;
14:  1c78e3d178 ! 14:  526beb9766 commit-graph: drop unnecessary `graph_read_bloom_data_context`
    @@ Commit message
         Signed-off-by: Taylor Blau <me@ttaylorr.com>
     
      ## commit-graph.c ##
    -@@ commit-graph.c: static int graph_read_oid_lookup(const unsigned char *chunk_start,
    +@@ commit-graph.c: static int graph_read_bloom_index(const unsigned char *chunk_start,
      	return 0;
      }
      
    @@ commit-graph.c: static int graph_read_oid_lookup(const unsigned char *chunk_star
     -	struct commit_graph *g = c->g;
     +	struct commit_graph *g = data;
      	uint32_t hash_version;
    - 	hash_version = get_be32(chunk_start);
      
    + 	if (chunk_size < BLOOMDATA_CHUNK_HEADER_SIZE) {
     @@ commit-graph.c: struct commit_graph *parse_commit_graph(struct repo_settings *s,
      	}
      
    @@ commit-graph.c: struct commit_graph *parse_commit_graph(struct repo_settings *s,
     -			.g = graph,
     -			.commit_graph_changed_paths_version = &s->commit_graph_changed_paths_version
     -		};
    - 		pair_chunk(cf, GRAPH_CHUNKID_BLOOMINDEXES,
    - 			   &graph->chunk_bloom_indexes);
    + 		read_chunk(cf, GRAPH_CHUNKID_BLOOMINDEXES,
    + 			   graph_read_bloom_index, graph);
      		read_chunk(cf, GRAPH_CHUNKID_BLOOMDATA,
     -			   graph_read_bloom_data, &context);
     +			   graph_read_bloom_data, graph);
15:  a289514faa = 15:  c683697efa object.h: fix mis-aligned flag bits table
16:  6a12e39e7f ! 16:  4bf043be9a commit-graph: reuse existing Bloom filters where possible
    @@ Metadata
      ## Commit message ##
         commit-graph: reuse existing Bloom filters where possible
     
    -    In 9e4df4da07 (commit-graph: new filter ver. that fixes murmur3,
    -    2023-08-01), a bug was described where it's possible for Git to produce
    -    non-murmur3 hashes when the platform's "char" type is signed, and there
    -    are paths with characters whose highest bit is set (i.e. all characters
    -    >= 0x80).
    +    In an earlier commit, a bug was described where it's possible for Git to
    +    produce non-murmur3 hashes when the platform's "char" type is signed,
    +    and there are paths with characters whose highest bit is set (i.e. all
    +    characters >= 0x80).
     
         That patch allows the caller to control which version of Bloom filters
         are read and written. However, even on platforms with a signed "char"
    @@ t/t4216-log-bloom.sh: test_expect_success 'when writing commit graph, do not reu
     +	test_filter_upgraded 1 trace2.txt
     +'
     +
    - test_done
    + corrupt_graph () {
    + 	test_when_finished "rm -rf $graph" &&
    + 	git commit-graph write --reachable --changed-paths &&
17:  8942f205c8 = 17:  7daa0d8833 bloom: introduce `deinit_bloom_filters()`

base-commit: d4dbce1db5cd227a57074bcfc7ec9f0655961bba
-- 
2.43.0.334.gd4dbce1db5.dirty
