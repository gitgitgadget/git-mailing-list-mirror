Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B84CC25B0F
	for <git@archiver.kernel.org>; Sun, 14 Aug 2022 17:00:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240889AbiHNRAL (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 14 Aug 2022 13:00:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240660AbiHNQ7p (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 14 Aug 2022 12:59:45 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D8DB55BF
        for <git@vger.kernel.org>; Sun, 14 Aug 2022 09:55:16 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id bs25so6649319wrb.2
        for <git@vger.kernel.org>; Sun, 14 Aug 2022 09:55:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc;
        bh=PWgk6asrBuS0YeWotYpcD2pvSVdbvyM8IU2/lbHUJ+o=;
        b=mRzwd7o2+hAuaabGKo35RsB71zLEweeiM+cnM60PFsA+nCc64txLAl3kMjMwZWkUL7
         sXMWX6PBTckblT11RVlpeAKb1nN/ov+k3/0fxgsZKeNiCldHCtCMcdDAbFDKKdUZYvsL
         vAzWcIKebLJW++CuqjfUJss6p4kMDLvCVpQWkb/msQnClRmalogrvlGb2WBP1eiIep2K
         OXUaNYbn1slbxMl/HqM7hbdQ+YI9vmhPzX0OjvnVA5CLwuOlj3aAuuZ9clHWBJlU8/bR
         6xeJaPCdtXruG2x+CdWAFatiDd9YLOIK31EcTIGNn97VbzPAX9+gCFs739TjicmZOagi
         FaAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc;
        bh=PWgk6asrBuS0YeWotYpcD2pvSVdbvyM8IU2/lbHUJ+o=;
        b=swenq+jr0KpvGD044SiS92NrZ6xGDfGS4zESbxSg3XVqINDqZyO3KAHgJcYgVikodt
         JysT2gGvCyU9mp8a6ghsgc5lqWK21gc/RACJ92fTzix4EPyU9wZZpa1Krw2zNhkJ8f56
         QaItfOnpsOfCfxROgmpjIbFx7c6lgDwlWQgRVjePuzY6ud5oRUc9ap/VuDNk5HaWZE46
         m4Uc2txhMoh7abSRZepV9K2POEJVf/P3PHZw5pqMshDWPxIWWYZCk06WcR0sETP5MovA
         D70+O7yeDgWPTL8y92bDY2yQ8RL6Aaa08tq8FDh/gQHk8VX5mfcBsj5/bp6PC3Ri+RhV
         ikrA==
X-Gm-Message-State: ACgBeo2jvZ5LRbqk7sgpnlDTIRagOqSznAgjLWlGXeLv+IHBi0g1nCSe
        f6kzsGImIBZRuAXbjDkol3syAWFh/Gc=
X-Google-Smtp-Source: AA6agR6VfqDf1CTWy3SrxDVFqTL31N/Qu2PgTR9ykL1Vh9PU2ChV1obLp/OvNKeeCG1I/nugn41QmA==
X-Received: by 2002:a05:6000:184d:b0:220:8235:132 with SMTP id c13-20020a056000184d00b0022082350132mr6806160wri.178.1660496114346;
        Sun, 14 Aug 2022 09:55:14 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id v8-20020a05600c214800b003a5c244fc13sm7160130wml.2.2022.08.14.09.55.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Aug 2022 09:55:13 -0700 (PDT)
Message-Id: <pull.1266.v6.git.1660496112.gitgitgadget@gmail.com>
In-Reply-To: <pull.1266.v5.git.1658342304.gitgitgadget@gmail.com>
References: <pull.1266.v5.git.1658342304.gitgitgadget@gmail.com>
From:   "Abhradeep Chakraborty via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sun, 14 Aug 2022 16:55:05 +0000
Subject: [PATCH v6 0/6] [GSoC] bitmap: integrate a lookup table extension to the bitmap format
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Taylor Blau <me@ttaylorr.com>,
        Kaartic Sivaram <kaartic.sivaraam@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Philip Oakley <philipoakley@iee.email>,
        Martin =?UTF-8?Q?=C3=85gren?= <martin.agren@gmail.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Eric Sunshine <sunshine@sunshineco.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Abhradeep Chakraborty <chakrabortyabhradeep79@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When parsing the .bitmap file, git loads all the bitmaps one by one even if
some of the bitmaps are not necessary. We can remove this overhead by
loading only the necessary bitmaps. A look up table extension can solve this
issue.

Changes since v5:

As the failure in the test case is not due to this code, I think it makes no
sense to delay the patch further.

 * The performance test changes were not accurate as the second
   test_bitmap_cases call using the repo built for the previous call. This
   version fixes that.
 * Taylor suggested some minor changes. Those are addressed in this version.

Changes since v4:

 * There was a CI failing test for linux-sha256 in the previous version.
   Fixed now.

Changes since v3:

 * The common code from both lookup_table_get_triplet() and
   bsearch_triplet_by_pos are moved to lookup_table_get_triplet_by_pointer
   function
 * parameter names of triplet_cmp function is changes (as suggested by
   Martin)
 * xor_items array is now work as reusable static buffer.
 * I moved the filling commit_positions array part (from
   pack-bitmap-write.c) to bitmap_writer_finish function. Because we had to
   iterate two times for commit positions - one in write_selected_commits_v1
   and another in write_lookup_table function. Hope this is acceptable :)
 * changes in performance tests (as suggested by Taylor)

Changes since v2:

 * Log messages related issues are fixed.
 * pack.writeBitmapLookupTable is now by default disabled.
 * Documentations are improved.
 * xor_row is used instead of xor_pos in triplets.
 * In pack-bitmap-write.c, off_t * is used for offsets array (Instead of
   uint64_t *).
 * struct bitmap_lookup_table_triplet is introduced and functions Like
   triplet_get_offset() and triplet_get_xor_pos() are removed.
 * table_size is getting subtracted from index_end irrespective of the value
   of GIT_TEST_READ_COMMIT_TABLE.
 * xor stack filling loop will stop iterating if a xor bitmap is already
   stored/parsed.
 * The stack will now store bitmap_lookup_table_xor_item items Of plain
   xor_row.
 * bitmap related test files are reformatted to allow repeating of tests
   with bitmap extension enabled.
 * comments are added.

Changes since v1:

This is the second version which addressed all (I think) the reviews. Please
notify me if some reviews are not addressed :)

 * The table size is decreased and the format has also changed. It now
   contains nr_entries triplets of size 4+8+4 bytes. Each triplet contains
   the following things - (1) 4 byte commit position (in the pack-index or
   midx) (2) 8 byte offset and (3) 4 byte xor triplet (i.e. with whose
   bitmap the current triplet's bitmap has to xor) position.
 * Performance tests are splitted into two commits. First contains the
   actual performance tests and second enables the pack.writeReverseIndex
   (as suggested by Taylor).
 * st_*() functions are used.
 * commit order is changed according to Derrick's suggestion.
 * Iterative approach is used instead of recursive approach to parse xor
   bitmaps. (As suggested by Derrick).
 * Some minor bug fixes of previous version.

Initial version:

The proposed table has:

 * a list of nr_entries object ids. These objects are commits that has
   bitmaps. Ids are stored in lexicographic order (for better searching).
 * a list of <offset, xor-offset> pairs (4-byte integers, network-byte
   order). The i'th pair denotes the offset and xor-offset(respectively) of
   the bitmap of i'th commit in the previous list. These two informations
   are necessary because only in this way bitmaps can be found without
   parsing all the bitmap.
 * a 4-byte integer for table specific flags (none exists currently).

Whenever git want to parse the bitmap for a specific commit, it will first
refer to the table and will look for the offset and xor-offset for that
commit. Git will then try to parse the bitmap located at the offset
position. The xor-offset can be used to find the xor-bitmap for the
bitmap(if any).

Abhradeep Chakraborty (6):
  Documentation/technical: describe bitmap lookup table extension
  bitmap: move `get commit positions` code to `bitmap_writer_finish`
  pack-bitmap-write.c: write lookup table extension
  pack-bitmap-write: learn pack.writeBitmapLookupTable and add tests
  pack-bitmap: prepare to read lookup table extension
  bitmap-lookup-table: add performance tests for lookup table

 Documentation/config/pack.txt             |   7 +
 Documentation/technical/bitmap-format.txt |  39 ++
 builtin/multi-pack-index.c                |   7 +
 builtin/pack-objects.c                    |   8 +
 midx.c                                    |   3 +
 midx.h                                    |   1 +
 pack-bitmap-write.c                       | 114 +++-
 pack-bitmap.c                             | 290 +++++++-
 pack-bitmap.h                             |  14 +-
 t/perf/lib-bitmap.sh                      |  31 +
 t/perf/p5310-pack-bitmaps.sh              |  78 +--
 t/perf/p5311-pack-bitmaps-fetch.sh        |  74 +-
 t/perf/p5312-pack-bitmaps-revs.sh         |  35 +
 t/perf/p5326-multi-pack-bitmaps.sh        | 103 +--
 t/t5310-pack-bitmaps.sh                   | 786 ++++++++++++----------
 t/t5311-pack-bitmaps-shallow.sh           |  53 +-
 t/t5326-multi-pack-bitmaps.sh             | 421 +++++++-----
 t/t5327-multi-pack-bitmaps-rev.sh         |  24 +-
 18 files changed, 1378 insertions(+), 710 deletions(-)
 create mode 100755 t/perf/p5312-pack-bitmaps-revs.sh


base-commit: afa70145a25e81faa685dc0b465e52b45d2444bd
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1266%2FAbhra303%2Fbitmap-commit-table-v6
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1266/Abhra303/bitmap-commit-table-v6
Pull-Request: https://github.com/gitgitgadget/git/pull/1266

Range-diff vs v5:

 1:  33aca8f3dc8 ! 1:  67b71be8c85 Documentation/technical: describe bitmap lookup table extension
     @@ Commit message
      
       ## Documentation/technical/bitmap-format.txt ##
      @@ Documentation/technical/bitmap-format.txt: MIDXs, both the bit-cache and rev-cache extensions are required.
     - 			pack/MIDX. The format and meaning of the name-hash is
     - 			described below.
     + 	    pack/MIDX. The format and meaning of the name-hash is
     + 	    described below.
       
     -+			** {empty}
     -+			BITMAP_OPT_LOOKUP_TABLE (0x10): :::
     -+			If present, the end of the bitmap file contains a table
     -+			containing a list of `N` <commit_pos, offset, xor_row>
     -+			triplets. The format and meaning of the table is described
     -+			below.
     ++		** {empty}
     ++		BITMAP_OPT_LOOKUP_TABLE (0x10): :::
     ++		If present, the end of the bitmap file contains a table
     ++		containing a list of `N` <commit_pos, offset, xor_row>
     ++		triplets. The format and meaning of the table is described
     ++		below.
      ++
      +NOTE: Unlike the xor_offset used to compress an individual bitmap,
      +`xor_row` stores an *absolute* index into the lookup table, not a location
      +relative to the current entry.
      +
     - 		4-byte entry count (network byte order)
     + 	4-byte entry count (network byte order): ::
     + 	    The total count of entries (bitmapped commits) in this bitmap index.
       
     - 			The total count of entries (bitmapped commits) in this bitmap index.
      @@ Documentation/technical/bitmap-format.txt: Note that this hashing scheme is tied to the BITMAP_OPT_HASH_CACHE flag.
       If implementations want to choose a different hashing scheme, they are
       free to do so, but MUST allocate a new header flag (because comparing
 -:  ----------- > 2:  92ca58fbeeb bitmap: move `get commit positions` code to `bitmap_writer_finish`
 2:  a913e6a2cb3 ! 3:  090becaabe0 pack-bitmap-write.c: write lookup table extension
     @@ Commit message
      
       ## pack-bitmap-write.c ##
      @@ pack-bitmap-write.c: static const struct object_id *oid_access(size_t pos, const void *table)
     - 
       static void write_selected_commits_v1(struct hashfile *f,
       				      struct pack_idx_entry **index,
     --				      uint32_t index_nr)
     -+				      uint32_t index_nr,
     -+				      off_t *offsets,
     -+				      uint32_t *commit_positions)
     + 				      uint32_t index_nr,
     +-				      uint32_t *commit_positions)
     ++				      uint32_t *commit_positions,
     ++				      off_t *offsets)
       {
       	int i;
       
       	for (i = 0; i < writer.selected_nr; ++i) {
       		struct bitmapped_commit *stored = &writer.selected[i];
       
     --		int commit_pos =
     --			oid_pos(&stored->commit->object.oid, index, index_nr, oid_access);
      +		if (offsets)
      +			offsets[i] = hashfile_total(f);
     - 
     --		if (commit_pos < 0)
     --			BUG("trying to write commit not in index");
     --
     --		hashwrite_be32(f, commit_pos);
     -+		hashwrite_be32(f, commit_positions[i]);
     ++
     + 		hashwrite_be32(f, commit_positions[i]);
       		hashwrite_u8(f, stored->xor_offset);
       		hashwrite_u8(f, stored->flags);
     - 
      @@ pack-bitmap-write.c: static void write_selected_commits_v1(struct hashfile *f,
       	}
       }
     @@ pack-bitmap-write.c: static void write_selected_commits_v1(struct hashfile *f,
      +static void write_lookup_table(struct hashfile *f,
      +			       struct pack_idx_entry **index,
      +			       uint32_t index_nr,
     -+			       off_t *offsets,
     -+			       uint32_t *commit_positions)
     ++			       uint32_t *commit_positions,
     ++			       off_t *offsets)
      +{
      +	uint32_t i;
      +	uint32_t *table, *table_inv;
     @@ pack-bitmap-write.c: static void write_selected_commits_v1(struct hashfile *f,
       			     struct pack_idx_entry **index,
       			     uint32_t index_nr)
      @@ pack-bitmap-write.c: void bitmap_writer_finish(struct pack_idx_entry **index,
     - {
     - 	static uint16_t default_version = 1;
     - 	static uint16_t flags = BITMAP_OPT_FULL_DAG;
     -+	off_t *offsets = NULL;
       	struct strbuf tmp_file = STRBUF_INIT;
       	struct hashfile *f;
     -+	uint32_t *commit_positions = NULL;
     + 	uint32_t *commit_positions = NULL;
     ++	off_t *offsets = NULL;
     + 	uint32_t i;
       
       	struct bitmap_disk_header header;
     - 
      @@ pack-bitmap-write.c: void bitmap_writer_finish(struct pack_idx_entry **index,
     - 	dump_bitmap(f, writer.trees);
       	dump_bitmap(f, writer.blobs);
       	dump_bitmap(f, writer.tags);
     --	write_selected_commits_v1(f, index, index_nr);
     -+
     -+	ALLOC_ARRAY(commit_positions, writer.selected_nr);
     -+	for (uint32_t i = 0; i < writer.selected_nr; ++i) {
     -+		struct bitmapped_commit *stored = &writer.selected[i];
     -+		int commit_pos = oid_pos(&stored->commit->object.oid, index, index_nr, oid_access);
     -+
     -+		if (commit_pos < 0)
     -+			BUG(_("trying to write commit not in index"));
     -+
     -+		commit_positions[i] = commit_pos;
     -+	}
     -+
     + 
      +	if (options & BITMAP_OPT_LOOKUP_TABLE)
      +		CALLOC_ARRAY(offsets, index_nr);
      +
     -+	write_selected_commits_v1(f, index, index_nr, offsets, commit_positions);
     + 	ALLOC_ARRAY(commit_positions, writer.selected_nr);
     + 
     + 	for (i = 0; i < writer.selected_nr; i++) {
     +@@ pack-bitmap-write.c: void bitmap_writer_finish(struct pack_idx_entry **index,
     + 		commit_positions[i] = commit_pos;
     + 	}
     + 
     +-	write_selected_commits_v1(f, index, index_nr, commit_positions);
     ++	write_selected_commits_v1(f, index, index_nr, commit_positions, offsets);
      +
      +	if (options & BITMAP_OPT_LOOKUP_TABLE)
     -+		write_lookup_table(f, index, index_nr, offsets, commit_positions);
     ++		write_lookup_table(f, index, index_nr, commit_positions, offsets);
       
       	if (options & BITMAP_OPT_HASH_CACHE)
       		write_hash_cache(f, index, index_nr);
      @@ pack-bitmap-write.c: void bitmap_writer_finish(struct pack_idx_entry **index,
     - 		die_errno("unable to rename temporary bitmap file to '%s'", filename);
       
       	strbuf_release(&tmp_file);
     + 	free(commit_positions);
      +	free(offsets);
     -+	free(commit_positions);
       }
      
       ## pack-bitmap.h ##
 3:  59b465e5a78 ! 4:  b2b7c5c1703 pack-bitmap-write: learn pack.writeBitmapLookupTable and add tests
     @@ builtin/pack-objects.c: static int git_pack_config(const char *k, const char *v,
       		return 0;
      
       ## midx.c ##
     -@@ midx.c: static int write_midx_bitmap(char *midx_name, unsigned char *midx_hash,
     +@@ midx.c: static int write_midx_bitmap(const char *midx_name,
       	if (flags & MIDX_WRITE_BITMAP_HASH_CACHE)
       		options |= BITMAP_OPT_HASH_CACHE;
       
      +	if (flags & MIDX_WRITE_BITMAP_LOOKUP_TABLE)
      +		options |= BITMAP_OPT_LOOKUP_TABLE;
      +
     - 	prepare_midx_packing_data(&pdata, ctx);
     - 
     - 	commits = find_commits_for_midx_bitmap(&commits_nr, refs_snapshot, ctx);
     + 	/*
     + 	 * Build the MIDX-order index based on pdata.objects (which is already
     + 	 * in MIDX order; c.f., 'midx_pack_order_cmp()' for the definition of
      
       ## midx.h ##
      @@ midx.h: struct multi_pack_index {
     @@ t/t5327-multi-pack-bitmaps-rev.sh: GIT_TEST_MIDX_READ_RIDX=0
      -midx_bitmap_core rev
      -midx_bitmap_partial_tests rev
      +test_midx_bitmap_rev () {
     -+     writeLookupTable=false
     -+
     -+ 	for i in "$@"
     -+ 	do
     -+ 		case $i in
     -+ 		"pack.writeBitmapLookupTable") writeLookupTable=true;;
     -+ 		esac
     -+ 	done
     -+
     -+     test_expect_success 'setup bitmap config' '
     -+         rm -rf * .git &&
     -+         git init &&
     -+         git config pack.writeBitmapLookupTable '"$writeLookupTable"'
     -+     '
     -+
     -+     midx_bitmap_core rev
     -+     midx_bitmap_partial_tests rev
     -+ }
     -+
     -+ test_midx_bitmap_rev
     -+ test_midx_bitmap_rev "pack.writeBitmapLookupTable"
     ++	writeLookupTable=false
     ++
     ++	for i in "$@"
     ++	do
     ++		case $i in
     ++		"pack.writeBitmapLookupTable") writeLookupTable=true;;
     ++		esac
     ++	done
     ++
     ++	test_expect_success 'setup bitmap config' '
     ++		rm -rf * .git &&
     ++		git init &&
     ++		git config pack.writeBitmapLookupTable '"$writeLookupTable"'
     ++	'
     ++
     ++	midx_bitmap_core rev
     ++	midx_bitmap_partial_tests rev
     ++}
     ++
     ++test_midx_bitmap_rev
     ++test_midx_bitmap_rev "pack.writeBitmapLookupTable"
       
       test_done
 4:  6918f0860ad ! 5:  79842ca590c pack-bitmap: prepare to read lookup table extension
     @@ pack-bitmap.c: static struct stored_bitmap *store_bitmap(struct bitmap_index *in
      +	 * shouldn't be duplicated commits in the index.
      +	 */
       	if (ret == 0) {
     --		error("Duplicate entry in bitmap index: %s", oid_to_hex(oid));
     -+		error(_("duplicate entry in bitmap index: %s"), oid_to_hex(oid));
     + 		error(_("duplicate entry in bitmap index: '%s'"), oid_to_hex(oid));
       		return NULL;
     - 	}
     - 
      @@ pack-bitmap.c: static int load_bitmap(struct bitmap_index *bitmap_git)
       		!(bitmap_git->tags = read_bitmap_1(bitmap_git)))
       		goto failed;
     @@ pack-bitmap.c: struct include_data {
      + * Note that this function assumes that there is enough memory
      + * left for filling the `triplet` struct from `p`.
      + */
     -+static int lookup_table_get_triplet_by_pointer(struct bitmap_lookup_table_triplet *triplet,
     -+					       const unsigned char *p)
     ++static int bitmap_lookup_table_get_triplet_by_pointer(struct bitmap_lookup_table_triplet *triplet,
     ++						      const unsigned char *p)
      +{
      +	if (!triplet)
      +		return -1;
     @@ pack-bitmap.c: struct include_data {
      + * This function gets the raw triplet from `row`'th row in the
      + * lookup table and fills that data to the `triplet`.
      + */
     -+static int lookup_table_get_triplet(struct bitmap_index *bitmap_git,
     -+				    uint32_t pos,
     -+				    struct bitmap_lookup_table_triplet *triplet)
     ++static int bitmap_lookup_table_get_triplet(struct bitmap_index *bitmap_git,
     ++					   uint32_t pos,
     ++					   struct bitmap_lookup_table_triplet *triplet)
      +{
      +	unsigned char *p = NULL;
      +	if (pos >= bitmap_git->entry_count)
     @@ pack-bitmap.c: struct include_data {
      +
      +	p = bitmap_git->table_lookup + st_mult(pos, BITMAP_LOOKUP_TABLE_TRIPLET_WIDTH);
      +
     -+	return lookup_table_get_triplet_by_pointer(triplet, p);
     ++	return bitmap_lookup_table_get_triplet_by_pointer(triplet, p);
      +}
      +
      +/*
     @@ pack-bitmap.c: struct include_data {
      +	return 0;
      +}
      +
     -+static uint32_t bsearch_pos(struct bitmap_index *bitmap_git,
     ++static uint32_t bitmap_bsearch_pos(struct bitmap_index *bitmap_git,
      +			    struct object_id *oid,
      +			    uint32_t *result)
      +{
     @@ pack-bitmap.c: struct include_data {
      + * object from the raw triplet. Returns 1 on success and 0 on
      + * failure.
      + */
     -+static int bsearch_triplet_by_pos(uint32_t commit_pos,
     ++static int bitmap_bsearch_triplet_by_pos(uint32_t commit_pos,
      +				  struct bitmap_index *bitmap_git,
      +				  struct bitmap_lookup_table_triplet *triplet)
      +{
     @@ pack-bitmap.c: struct include_data {
      +	if (!p)
      +		return -1;
      +
     -+	return lookup_table_get_triplet_by_pointer(triplet, p);
     ++	return bitmap_lookup_table_get_triplet_by_pointer(triplet, p);
      +}
      +
      +static struct stored_bitmap *lazy_bitmap_for_commit(struct bitmap_index *bitmap_git,
     -+					  struct commit *commit)
     ++						    struct commit *commit)
      +{
      +	uint32_t commit_pos, xor_row;
      +	uint64_t offset;
     -+	int flags, found;
     ++	int flags;
      +	struct bitmap_lookup_table_triplet triplet;
      +	struct object_id *oid = &commit->object.oid;
      +	struct ewah_bitmap *bitmap;
     @@ pack-bitmap.c: struct include_data {
      +	static struct bitmap_lookup_table_xor_item *xor_items = NULL;
      +	static size_t xor_items_nr = 0, xor_items_alloc = 0;
      +	static int is_corrupt = 0;
     ++	int xor_flags;
     ++	khiter_t hash_pos;
     ++	struct bitmap_lookup_table_xor_item *xor_item;
      +
      +	if (is_corrupt)
      +		return NULL;
      +
     -+	found = bsearch_pos(bitmap_git, oid, &commit_pos);
     -+
     -+	if (!found)
     ++	if (!bitmap_bsearch_pos(bitmap_git, oid, &commit_pos))
      +		return NULL;
      +
     -+	if (bsearch_triplet_by_pos(commit_pos, bitmap_git, &triplet) < 0)
     ++	if (bitmap_bsearch_triplet_by_pos(commit_pos, bitmap_git, &triplet) < 0)
      +		return NULL;
      +
      +	xor_items_nr = 0;
      +	offset = triplet.offset;
      +	xor_row = triplet.xor_row;
      +
     -+	if (xor_row != 0xffffffff) {
     -+		int xor_flags;
     -+		khiter_t hash_pos;
     -+		struct bitmap_lookup_table_xor_item *xor_item;
     -+
     -+		while (xor_row != 0xffffffff) {
     -+			ALLOC_GROW(xor_items, xor_items_nr + 1, xor_items_alloc);
     -+
     -+			if (xor_items_nr + 1 >= bitmap_git->entry_count) {
     -+				error(_("corrupt bitmap lookup table: xor chain exceed entry count"));
     -+				goto corrupt;
     -+			}
     -+
     -+			if (lookup_table_get_triplet(bitmap_git, xor_row, &triplet) < 0)
     -+				goto corrupt;
     -+
     -+			xor_item = &xor_items[xor_items_nr];
     -+			xor_item->offset = triplet.offset;
     -+
     -+			if (nth_bitmap_object_oid(bitmap_git, &xor_item->oid, triplet.commit_pos) < 0) {
     -+				error(_("corrupt bitmap lookup table: commit index %u out of range"),
     -+					triplet.commit_pos);
     -+				goto corrupt;
     -+			}
     -+
     -+			hash_pos = kh_get_oid_map(bitmap_git->bitmaps, xor_item->oid);
     -+
     -+			/*
     -+			 * If desired bitmap is already stored, we don't need
     -+			 * to iterate further. Because we know that bitmaps
     -+			 * that are needed to be parsed to parse this bitmap
     -+			 * has already been stored. So, assign this stored bitmap
     -+			 * to the xor_bitmap.
     -+			 */
     -+			if (hash_pos < kh_end(bitmap_git->bitmaps) &&
     -+			    (xor_bitmap = kh_value(bitmap_git->bitmaps, hash_pos)))
     -+				break;
     -+			xor_items_nr++;
     -+			xor_row = triplet.xor_row;
     ++	while (xor_row != 0xffffffff) {
     ++		ALLOC_GROW(xor_items, xor_items_nr + 1, xor_items_alloc);
     ++
     ++		if (xor_items_nr + 1 >= bitmap_git->entry_count) {
     ++			error(_("corrupt bitmap lookup table: xor chain exceed entry count"));
     ++			goto corrupt;
      +		}
      +
     -+		while (xor_items_nr) {
     -+			xor_item = &xor_items[xor_items_nr - 1];
     -+			bitmap_git->map_pos = xor_item->offset;
     -+			if (bitmap_git->map_size - bitmap_git->map_pos < bitmap_header_size) {
     -+				error(_("corrupt ewah bitmap: truncated header for bitmap of commit \"%s\""),
     -+					oid_to_hex(&xor_item->oid));
     -+				goto corrupt;
     -+			}
     ++		if (bitmap_lookup_table_get_triplet(bitmap_git, xor_row, &triplet) < 0)
     ++			goto corrupt;
     ++
     ++		xor_item = &xor_items[xor_items_nr];
     ++		xor_item->offset = triplet.offset;
      +
     -+			bitmap_git->map_pos = bitmap_git->map_pos + sizeof(uint32_t) + sizeof(uint8_t);
     -+			xor_flags = read_u8(bitmap_git->map, &bitmap_git->map_pos);
     -+			bitmap = read_bitmap_1(bitmap_git);
     ++		if (nth_bitmap_object_oid(bitmap_git, &xor_item->oid, triplet.commit_pos) < 0) {
     ++			error(_("corrupt bitmap lookup table: commit index %u out of range"),
     ++				triplet.commit_pos);
     ++			goto corrupt;
     ++		}
      +
     -+			if (!bitmap)
     -+				goto corrupt;
     ++		hash_pos = kh_get_oid_map(bitmap_git->bitmaps, xor_item->oid);
     ++
     ++		/*
     ++		 * If desired bitmap is already stored, we don't need
     ++		 * to iterate further. Because we know that bitmaps
     ++		 * that are needed to be parsed to parse this bitmap
     ++		 * has already been stored. So, assign this stored bitmap
     ++		 * to the xor_bitmap.
     ++		 */
     ++		if (hash_pos < kh_end(bitmap_git->bitmaps) &&
     ++			(xor_bitmap = kh_value(bitmap_git->bitmaps, hash_pos)))
     ++			break;
     ++		xor_items_nr++;
     ++		xor_row = triplet.xor_row;
     ++	}
      +
     -+			xor_bitmap = store_bitmap(bitmap_git, bitmap, &xor_item->oid, xor_bitmap, xor_flags);
     -+			xor_items_nr--;
     ++	while (xor_items_nr) {
     ++		xor_item = &xor_items[xor_items_nr - 1];
     ++		bitmap_git->map_pos = xor_item->offset;
     ++		if (bitmap_git->map_size - bitmap_git->map_pos < bitmap_header_size) {
     ++			error(_("corrupt ewah bitmap: truncated header for bitmap of commit \"%s\""),
     ++				oid_to_hex(&xor_item->oid));
     ++			goto corrupt;
      +		}
     ++
     ++		bitmap_git->map_pos += sizeof(uint32_t) + sizeof(uint8_t);
     ++		xor_flags = read_u8(bitmap_git->map, &bitmap_git->map_pos);
     ++		bitmap = read_bitmap_1(bitmap_git);
     ++
     ++		if (!bitmap)
     ++			goto corrupt;
     ++
     ++		xor_bitmap = store_bitmap(bitmap_git, bitmap, &xor_item->oid, xor_bitmap, xor_flags);
     ++		xor_items_nr--;
      +	}
      +
      +	bitmap_git->map_pos = offset;
     @@ pack-bitmap.c: struct include_data {
      +		goto corrupt;
      +	}
      +
     -+	bitmap_git->map_pos = bitmap_git->map_pos + sizeof(uint32_t) + sizeof(uint8_t);
     ++	/*
     ++	 * Don't bother reading the commit's index position or its xor
     ++	 * offset:
     ++	 *
     ++	 *   - The commit's index position is irrelevant to us, since
     ++	 *     load_bitmap_entries_v1 only uses it to learn the object
     ++	 *     id which is used to compute the hashmap's key. We already
     ++	 *     have an object id, so no need to look it up again.
     ++	 *
     ++	 *   - The xor_offset is unusable for us, since it specifies how
     ++	 *     many entries previous to ours we should look at. This
     ++	 *     makes sense when reading the bitmaps sequentially (as in
     ++	 *     load_bitmap_entries_v1()), since we can keep track of
     ++	 *     each bitmap as we read them.
     ++	 *
     ++	 *     But it can't work for us, since the bitmap's don't have a
     ++	 *     fixed size. So we learn the position of the xor'd bitmap
     ++	 *     from the commit table (and resolve it to a bitmap in the
     ++	 *     above if-statement).
     ++	 *
     ++	 * Instead, we can skip ahead and immediately read the flags and
     ++	 * ewah bitmap.
     ++	 */
     ++	bitmap_git->map_pos += sizeof(uint32_t) + sizeof(uint8_t);
      +	flags = read_u8(bitmap_git->map, &bitmap_git->map_pos);
      +	bitmap = read_bitmap_1(bitmap_git);
      +
     @@ pack-bitmap.c: struct include_data {
       
      @@ pack-bitmap.c: void test_bitmap_walk(struct rev_info *revs)
       	if (revs->pending.nr != 1)
     - 		die("you must specify exactly one commit to test");
     + 		die(_("you must specify exactly one commit to test"));
       
     --	fprintf(stderr, "Bitmap v%d test (%d entries loaded)\n",
     +-	fprintf_ln(stderr, "Bitmap v%d test (%d entries loaded)",
      -		bitmap_git->version, bitmap_git->entry_count);
     -+	fprintf(stderr, "Bitmap v%d test (%d entries%s)",
     ++	fprintf_ln(stderr, "Bitmap v%d test (%d entries%s)",
      +		bitmap_git->version,
      +		bitmap_git->entry_count,
      +		bitmap_git->table_lookup ? "" : " loaded");
     @@ pack-bitmap.c: void test_bitmap_walk(struct rev_info *revs)
       	struct object_id oid;
       	MAYBE_UNUSED void *value;
      +	struct bitmap_index *bitmap_git = prepare_bitmap_git(r);
     -+
     + 
     + 	if (!bitmap_git)
     + 		die(_("failed to load bitmap indexes"));
     + 
      +	/*
      +	 * As this function is only used to print bitmap selected
      +	 * commits, we don't have to read the commit table.
      +	 */
     - 
     - 	if (!bitmap_git)
     - 		die("failed to load bitmap indexes");
     - 
      +	if (bitmap_git->table_lookup) {
      +		if (load_bitmap_entries_v1(bitmap_git) < 0)
      +			die(_("failed to load bitmap indexes"));
      +	}
      +
       	kh_foreach(bitmap_git->bitmaps, oid, value, {
     - 		printf("%s\n", oid_to_hex(&oid));
     + 		printf_ln("%s", oid_to_hex(&oid));
       	});
      
       ## pack-bitmap.h ##
 5:  e7ef420f321 < -:  ----------- p5310-pack-bitmaps.sh: enable `pack.writeReverseIndex`
 6:  6628001241d ! 6:  b460516b306 bitmap-lookup-table: add performance tests for lookup table
     @@ Metadata
       ## Commit message ##
          bitmap-lookup-table: add performance tests for lookup table
      
     -    Add performance tests to verify the performance of lookup table with
     -    `pack.writeReverseIndex` enabled. This is to check the performance
     -    when the above configuration is set.
     +    Add performance tests to verify the performance of lookup table.
     +    `p5310-pack-bitmaps.sh` contain tests with and without lookup table.
     +    `p5312-pack-bitmaps-revs.sh` contain same tests with and without
     +    lookup table but with `pack.writeReverseIndex` enabled.
      
          Lookup table makes Git run faster in most of the cases. Below is the
          result of `t/perf/p5310-pack-bitmaps.sh`.`perf/p5326-multi-pack-bitmaps.sh`
          gives similar result. The repository used in the test is linux kernel.
      
     -    Test                                                      this tree
     -    ---------------------------------------------------------------------------
     -    5310.4: repack to disk (lookup=false)                   296.55(256.53+14.52)
     -    5310.5: simulated clone                                 15.64(8.88+1.39)
     -    5310.6: simulated fetch                                 1.65(2.75+0.20)
     -    5310.7: pack to file (bitmap)                           48.71(30.20+7.58)
     -    5310.8: rev-list (commits)                              0.61(0.41+0.08)
     -    5310.9: rev-list (objects)                              4.38(4.26+0.09)
     -    5310.10: rev-list with tag negated via --not            0.07(0.02+0.04)
     +    Test                                                    this tree
     +    -----------------------------------------------------------------------
     +    5310.4: enable lookup table: false                    0.01(0.00+0.00)
     +    5310.5: repack to disk                                320.89(230.20+23.45)
     +    5310.6: simulated clone                               14.04(5.78+1.79)
     +    5310.7: simulated fetch                               1.95(3.05+0.20)
     +    5310.8: pack to file (bitmap)                         44.73(20.55+7.45)
     +    5310.9: rev-list (commits)                            0.78(0.46+0.10)
     +    5310.10: rev-list (objects)                           4.07(3.97+0.08)
     +    5310.11: rev-list with tag negated via --not          0.06(0.02+0.03)
                   --all (objects)
     -    5310.11: rev-list with negative tag (objects)           0.05(0.01+0.03)
     -    5310.12: rev-list count with blob:none                  0.08(0.03+0.04)
     -    5310.13: rev-list count with blob:limit=1k              7.29(6.92+0.30)
     -    5310.14: rev-list count with tree:0                     0.08(0.03+0.04)
     -    5310.15: simulated partial clone                        9.45(8.12+0.41)
     -    5310.17: clone (partial bitmap)                         21.00(15.04+2.39)
     -    5310.18: pack to file (partial bitmap)                  47.98(38.13+5.23)
     -    5310.19: rev-list with tree filter (partial bitmap)     0.70(0.07+0.20)
     -    5310.22: repack to disk (lookup=true)                   255.92(188.13+20.47)
     -    5310.23: simulated clone                                13.78(8.84+1.09)
     -    5310.24: simulated fetch                                0.52(0.63+0.14)
     -    5310.25: pack to file (bitmap)                          44.34(28.94+6.84)
     -    5310.26: rev-list (commits)                             0.48(0.31+0.06)
     -    5310.27: rev-list (objects)                             4.02(3.93+0.07)
     -    5310.28: rev-list with tag negated via --not            0.04(0.00+0.03)
     +    5310.12: rev-list with negative tag (objects)         0.21(0.15+0.05)
     +    5310.13: rev-list count with blob:none                0.24(0.17+0.06)
     +    5310.14: rev-list count with blob:limit=1k            7.07(5.92+0.48)
     +    5310.15: rev-list count with tree:0                   0.25(0.17+0.07)
     +    5310.16: simulated partial clone                      5.67(3.28+0.64)
     +    5310.18: clone (partial bitmap)                       16.05(8.34+1.86)
     +    5310.19: pack to file (partial bitmap)                59.76(27.22+7.43)
     +    5310.20: rev-list with tree filter (partial bitmap)   0.90(0.18+0.16)
     +    5310.24: enable lookup table: true                    0.01(0.00+0.00)
     +    5310.25: repack to disk                               319.73(229.30+23.01)
     +    5310.26: simulated clone                              13.69(5.72+1.78)
     +    5310.27: simulated fetch                              1.84(3.02+0.16)
     +    5310.28: pack to file (bitmap)                        45.63(20.67+7.50)
     +    5310.29: rev-list (commits)                           0.56(0.39+0.8)
     +    5310.30: rev-list (objects)                           3.77(3.74+0.08)
     +    5310.31: rev-list with tag negated via --not          0.05(0.02+0.03)
                   --all (objects)
     -    5310.29: rev-list with negative tag (objects)           0.04(0.00+0.03)
     -    5310.30: rev-list count with blob:none                  0.04(0.01+0.03)
     -    5310.31: rev-list count with blob:limit=1k              6.48(6.23+0.22)
     -    5310.32: rev-list count with tree:0                     0.04(0.01+0.03)
     -    5310.33: simulated partial clone                        8.30(7.21+0.36)
     -    5310.35: clone (partial bitmap)                         20.34(15.00+2.41)
     -    5310.36: pack to file (partial bitmap)                  46.45(38.05+5.20)
     -    5310.37: rev-list with tree filter (partial bitmap)     0.61(0.06+0.20)
     +    5310.32: rev-list with negative tag (objects)         0.21(0.15+0.05)
     +    5310.33: rev-list count with blob:none                0.23(0.17+0.05)
     +    5310.34: rev-list count with blob:limit=1k            6.65(5.72+0.40)
     +    5310.35: rev-list count with tree:0                   0.23(0.16+0.06)
     +    5310.36: simulated partial clone                      5.57(3.26+0.59)
     +    5310.38: clone (partial bitmap)                       15.89(8.39+1.84)
     +    5310.39: pack to file (partial bitmap)                58.32(27.55+7.47)
     +    5310.40: rev-list with tree filter (partial bitmap)   0.73(0.18+0.15)
      
          Test 4-15 are tested without using lookup table. Same tests are
          repeated in 16-30 (using lookup table).
     @@ Commit message
          Co-Mentored-by: Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
          Signed-off-by: Abhradeep Chakraborty <chakrabortyabhradeep79@gmail.com>
      
     + ## t/perf/lib-bitmap.sh ##
     +@@ t/perf/lib-bitmap.sh: test_partial_bitmap () {
     + 			--filter=tree:0 >/dev/null
     + 	'
     + }
     ++
     ++test_pack_bitmap () {
     ++	test_perf "repack to disk" '
     ++		git repack -ad
     ++	'
     ++
     ++	test_full_bitmap
     ++
     ++	test_expect_success "create partial bitmap state" '
     ++		# pick a commit to represent the repo tip in the past
     ++		cutoff=$(git rev-list HEAD~100 -1) &&
     ++		orig_tip=$(git rev-parse HEAD) &&
     ++
     ++		# now kill off all of the refs and pretend we had
     ++		# just the one tip
     ++		rm -rf .git/logs .git/refs/* .git/packed-refs &&
     ++		git update-ref HEAD $cutoff &&
     ++
     ++		# and then repack, which will leave us with a nice
     ++		# big bitmap pack of the "old" history, and all of
     ++		# the new history will be loose, as if it had been pushed
     ++		# up incrementally and exploded via unpack-objects
     ++		git repack -Ad &&
     ++
     ++		# and now restore our original tip, as if the pushes
     ++		# had happened
     ++		git update-ref HEAD $orig_tip
     ++	'
     ++
     ++	test_partial_bitmap
     ++}
     +
       ## t/perf/p5310-pack-bitmaps.sh ##
     -@@ t/perf/p5310-pack-bitmaps.sh: test_expect_success 'setup bitmap config' '
     - 	git config pack.writeReverseIndex true
     - '
     +@@ t/perf/p5310-pack-bitmaps.sh: test_description='Tests pack performance using bitmaps'
     + . ./perf-lib.sh
     + . "${TEST_DIRECTORY}/perf/lib-bitmap.sh"
       
     +-test_perf_large_repo
     +-
     +-# note that we do everything through config,
     +-# since we want to be able to compare bitmap-aware
     +-# git versus non-bitmap git
     +-#
     +-# We intentionally use the deprecated pack.writebitmaps
     +-# config so that we can test against older versions of git.
     +-test_expect_success 'setup bitmap config' '
     +-	git config pack.writebitmaps true
     +-'
     +-
      -# we need to create the tag up front such that it is covered by the repack and
      -# thus by generated bitmaps.
      -test_expect_success 'create tags' '
      -	git tag --message="tag pointing to HEAD" perf-tag HEAD
      -'
     -+test_bitmap () {
     -+	local enabled="$1"
     - 
     +-
      -test_perf 'repack to disk' '
      -	git repack -ad
      -'
     -+	# we need to create the tag up front such that it is covered by the repack and
     -+	# thus by generated bitmaps.
     -+	test_expect_success 'create tags' '
     -+		git tag --message="tag pointing to HEAD" perf-tag HEAD
     -+	'
     - 
     +-
      -test_full_bitmap
     -+	test_expect_success "use lookup table: $enabled" '
     -+		git config pack.writeBitmapLookupTable '"$enabled"'
     -+	'
     - 
     +-
      -test_expect_success 'create partial bitmap state' '
      -	# pick a commit to represent the repo tip in the past
      -	cutoff=$(git rev-list HEAD~100 -1) &&
      -	orig_tip=$(git rev-parse HEAD) &&
     -+	test_perf "repack to disk (lookup=$enabled)" '
     -+		git repack -ad
     -+	'
     - 
     +-
      -	# now kill off all of the refs and pretend we had
      -	# just the one tip
      -	rm -rf .git/logs .git/refs/* .git/packed-refs &&
      -	git update-ref HEAD $cutoff &&
     -+	test_full_bitmap
     - 
     +-
      -	# and then repack, which will leave us with a nice
      -	# big bitmap pack of the "old" history, and all of
      -	# the new history will be loose, as if it had been pushed
      -	# up incrementally and exploded via unpack-objects
      -	git repack -Ad &&
     -+	test_expect_success "create partial bitmap state (lookup=$enabled)" '
     -+		# pick a commit to represent the repo tip in the past
     -+		cutoff=$(git rev-list HEAD~100 -1) &&
     -+		orig_tip=$(git rev-parse HEAD) &&
     - 
     +-
      -	# and now restore our original tip, as if the pushes
      -	# had happened
      -	git update-ref HEAD $orig_tip
      -'
     -+		# now kill off all of the refs and pretend we had
     -+		# just the one tip
     -+		rm -rf .git/logs .git/refs/* .git/packed-refs &&
     -+		git update-ref HEAD $cutoff &&
     +-
     +-test_partial_bitmap
     ++test_lookup_pack_bitmap () {
     ++	test_expect_success 'start the test from scratch' '
     ++		rm -rf * .git
     ++	'
      +
     -+		# and then repack, which will leave us with a nice
     -+		# big bitmap pack of the "old" history, and all of
     -+		# the new history will be loose, as if it had been pushed
     -+		# up incrementally and exploded via unpack-objects
     -+		git repack -Ad &&
     ++	test_perf_large_repo
      +
     -+		# and now restore our original tip, as if the pushes
     -+		# had happened
     -+		git update-ref HEAD $orig_tip
     ++	# note that we do everything through config,
     ++	# since we want to be able to compare bitmap-aware
     ++	# git versus non-bitmap git
     ++	#
     ++	# We intentionally use the deprecated pack.writebitmaps
     ++	# config so that we can test against older versions of git.
     ++	test_expect_success 'setup bitmap config' '
     ++		git config pack.writebitmaps true
      +	'
      +
     -+	test_partial_bitmap
     ++	# we need to create the tag up front such that it is covered by the repack and
     ++	# thus by generated bitmaps.
     ++	test_expect_success 'create tags' '
     ++		git tag --message="tag pointing to HEAD" perf-tag HEAD
     ++	'
     ++
     ++	test_perf "enable lookup table: $1" '
     ++		git config pack.writeBitmapLookupTable '"$1"'
     ++	'
     ++
     ++	test_pack_bitmap
      +}
     ++
     ++test_lookup_pack_bitmap false
     ++test_lookup_pack_bitmap true
       
     --test_partial_bitmap
     -+test_bitmap false
     -+test_bitmap true
     + test_done
     +
     + ## t/perf/p5311-pack-bitmaps-fetch.sh ##
     +@@
     + test_description='performance of fetches from bitmapped packs'
     + . ./perf-lib.sh
     + 
     +-test_perf_default_repo
     +-
     +-test_expect_success 'create bitmapped server repo' '
     +-	git config pack.writebitmaps true &&
     +-	git repack -ad
     +-'
     +-
     +-# simulate a fetch from a repository that last fetched N days ago, for
     +-# various values of N. We do so by following the first-parent chain,
     +-# and assume the first entry in the chain that is N days older than the current
     +-# HEAD is where the HEAD would have been then.
     +-for days in 1 2 4 8 16 32 64 128; do
     +-	title=$(printf '%10s' "($days days)")
     +-	test_expect_success "setup revs from $days days ago" '
     +-		now=$(git log -1 --format=%ct HEAD) &&
     +-		then=$(($now - ($days * 86400))) &&
     +-		tip=$(git rev-list -1 --first-parent --until=$then HEAD) &&
     +-		{
     +-			echo HEAD &&
     +-			echo ^$tip
     +-		} >revs
     ++test_fetch_bitmaps () {
     ++	test_expect_success 'setup test directory' '
     ++		rm -fr * .git
     + 	'
     + 
     +-	test_perf "server $title" '
     +-		git pack-objects --stdout --revs \
     +-				 --thin --delta-base-offset \
     +-				 <revs >tmp.pack
     +-	'
     ++	test_perf_default_repo
     + 
     +-	test_size "size   $title" '
     +-		wc -c <tmp.pack
     ++	test_expect_success 'create bitmapped server repo' '
     ++		git config pack.writebitmaps true &&
     ++		git config pack.writeBitmapLookupTable '"$1"' &&
     ++		git repack -ad
     + 	'
     + 
     +-	test_perf "client $title" '
     +-		git index-pack --stdin --fix-thin <tmp.pack
     +-	'
     +-done
     ++	# simulate a fetch from a repository that last fetched N days ago, for
     ++	# various values of N. We do so by following the first-parent chain,
     ++	# and assume the first entry in the chain that is N days older than the current
     ++	# HEAD is where the HEAD would have been then.
     ++	for days in 1 2 4 8 16 32 64 128; do
     ++		title=$(printf '%10s' "($days days)")
     ++		test_expect_success "setup revs from $days days ago" '
     ++			now=$(git log -1 --format=%ct HEAD) &&
     ++			then=$(($now - ($days * 86400))) &&
     ++			tip=$(git rev-list -1 --first-parent --until=$then HEAD) &&
     ++			{
     ++				echo HEAD &&
     ++				echo ^$tip
     ++			} >revs
     ++		'
     ++
     ++		test_perf "server $title (lookup=$1)" '
     ++			git pack-objects --stdout --revs \
     ++					--thin --delta-base-offset \
     ++					<revs >tmp.pack
     ++		'
     ++
     ++		test_size "size   $title" '
     ++			wc -c <tmp.pack
     ++		'
     ++
     ++		test_perf "client $title (lookup=$1)" '
     ++			git index-pack --stdin --fix-thin <tmp.pack
     ++		'
     ++	done
     ++}
     ++
     ++test_fetch_bitmaps true
     ++test_fetch_bitmaps false
       
       test_done
      
     + ## t/perf/p5312-pack-bitmaps-revs.sh (new) ##
     +@@
     ++#!/bin/sh
     ++
     ++test_description='Tests pack performance using bitmaps (rev index enabled)'
     ++. ./perf-lib.sh
     ++. "${TEST_DIRECTORY}/perf/lib-bitmap.sh"
     ++
     ++test_lookup_pack_bitmap () {
     ++	test_expect_success 'start the test from scratch' '
     ++		rm -rf * .git
     ++	'
     ++
     ++	test_perf_large_repo
     ++
     ++	test_expect_success 'setup bitmap config' '
     ++		git config pack.writebitmaps true &&
     ++		git config pack.writeReverseIndex true
     ++	'
     ++
     ++	# we need to create the tag up front such that it is covered by the repack and
     ++	# thus by generated bitmaps.
     ++	test_expect_success 'create tags' '
     ++		git tag --message="tag pointing to HEAD" perf-tag HEAD
     ++	'
     ++
     ++	test_perf "enable lookup table: $1" '
     ++		git config pack.writeBitmapLookupTable '"$1"'
     ++	'
     ++
     ++	test_pack_bitmap
     ++}
     ++
     ++test_lookup_pack_bitmap false
     ++test_lookup_pack_bitmap true
     ++
     ++test_done
     +
       ## t/perf/p5326-multi-pack-bitmaps.sh ##
      @@ t/perf/p5326-multi-pack-bitmaps.sh: test_description='Tests performance using midx bitmaps'
     + . ./perf-lib.sh
     + . "${TEST_DIRECTORY}/perf/lib-bitmap.sh"
       
     - test_perf_large_repo
     - 
     +-test_perf_large_repo
     +-
      -# we need to create the tag up front such that it is covered by the repack and
      -# thus by generated bitmaps.
      -test_expect_success 'create tags' '
     @@ t/perf/p5326-multi-pack-bitmaps.sh: test_description='Tests performance using mi
      +test_bitmap () {
      +	local enabled="$1"
      +
     ++	test_expect_success "remove existing repo (lookup=$enabled)" '
     ++		rm -fr * .git
     ++	'
     ++
     ++	test_perf_large_repo
     ++
      +	# we need to create the tag up front such that it is covered by the repack and
      +	# thus by generated bitmaps.
      +	test_expect_success 'create tags' '

-- 
gitgitgadget
