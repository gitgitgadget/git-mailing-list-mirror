Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CACFC43334
	for <git@archiver.kernel.org>; Mon,  4 Jul 2022 08:46:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233116AbiGDIqe (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 4 Jul 2022 04:46:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232901AbiGDIq3 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 4 Jul 2022 04:46:29 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B938B845
        for <git@vger.kernel.org>; Mon,  4 Jul 2022 01:46:22 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id f2so7034658wrr.6
        for <git@vger.kernel.org>; Mon, 04 Jul 2022 01:46:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=3WVDjhtDeju/rbH2fz/dLXs62WLvbKYkdu17hQFjd84=;
        b=DcxGN1Iu/d2KpY5Vn5oynZe0zn+4UVm7J1342l4hcm5Tliqj9O7RkKLsiwsKHJGN7v
         TEumYOeTaR+OyXEozyLxYMvAEM4nxyqraks5VDTwW/fNZXJ6P+3ySjhfr57g/uhKPlNU
         bdkMSXNNEVB4LkwgN2jOZbXzcJTpzxvCHtoBXut2ernG7rcJLHyXoHIU3E8Wwb8DJ9F5
         SAiqmCXD0S0SutKI6VVyaKYVV3ggWaybiVR4dPoxNSuvKDUnFT+L2pyPBPEnSVah9Pmf
         rv/lk7qYeQCRH2kD2QauDatYEJodgaVsVSWb7AkakEUQQWO6U4hW+tALTEYF+QtWBWJC
         pUqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=3WVDjhtDeju/rbH2fz/dLXs62WLvbKYkdu17hQFjd84=;
        b=gfOJfts0MD9NkImYGm/jCwqsnm6aXlyrPGOzPHuaPpPXb3fwOpNiwI9YgINEdex6e+
         i/E3OPgfqgBJfaOvCrqt+8VwwptJUrkJsuSEDZe1wmzZHMfqTwLH5uU3LkIborBXGkw9
         2/B/CTp/skcu05C64FvgmKQtJfZTQuOIvgrvlBJ7LrEMRSx/PdaKSzXovb1FbqkJzYJg
         Rne6BBxv+IuPcrZaI+0rqPGSpdJ2NhZjrb92SBYhgCFLAcurSHnt3XoQdSdZ+j4qz3py
         gePjqJUR1wOCKUVplgB7esNOp9SYDjk/ptcBP560qqwbFWY3lxLUjkN13DZqIhDRSf36
         V0+w==
X-Gm-Message-State: AJIora/bl0FkEgaHxc+oLZa71WlK6mddTe11d5k6fEZt/8VcKaQpY0Ti
        TL7j/dEvGRBTNH2VIB4bgCiqs+jPopY=
X-Google-Smtp-Source: AGRyM1sq6n7XTCo17cnKQQzDL0TQ4vbFYX2ZtLK56wNV6wwZeM1pfkkw7PJf/EvrUA8MFDSKlXgudg==
X-Received: by 2002:adf:dbcd:0:b0:21b:868a:4cbe with SMTP id e13-20020adfdbcd000000b0021b868a4cbemr25077112wrj.522.1656924379291;
        Mon, 04 Jul 2022 01:46:19 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id o9-20020a05600c510900b003a02c21b7easm19406634wms.11.2022.07.04.01.46.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Jul 2022 01:46:17 -0700 (PDT)
Message-Id: <pull.1266.v3.git.1656924376.gitgitgadget@gmail.com>
In-Reply-To: <pull.1266.v2.git.1656249017.gitgitgadget@gmail.com>
References: <pull.1266.v2.git.1656249017.gitgitgadget@gmail.com>
From:   "Abhradeep Chakraborty via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 04 Jul 2022 08:46:10 +0000
Subject: [PATCH v3 0/6] [GSoC] bitmap: integrate a lookup table extension to the bitmap format
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Taylor Blau <me@ttaylorr.com>,
        Kaartic Sivaram <kaartic.sivaraam@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Abhradeep Chakraborty <chakrabortyabhradeep79@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When parsing the .bitmap file, git loads all the bitmaps one by one even if
some of the bitmaps are not necessary. We can remove this overhead by
loading only the necessary bitmaps. A look up table extension can solve this
issue.

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
  pack-bitmap-write.c: write lookup table extension
  pack-bitmap-write: learn pack.writeBitmapLookupTable and add tests
  pack-bitmap: prepare to read lookup table extension
  bitmap-lookup-table: add performance tests for lookup table
  p5310-pack-bitmaps.sh: remove pack.writeReverseIndex

 Documentation/config/pack.txt             |   7 +
 Documentation/technical/bitmap-format.txt |  39 ++
 builtin/multi-pack-index.c                |   7 +
 builtin/pack-objects.c                    |   8 +
 midx.c                                    |   3 +
 midx.h                                    |   1 +
 pack-bitmap-write.c                       | 112 ++-
 pack-bitmap.c                             | 266 +++++++-
 pack-bitmap.h                             |  14 +-
 t/perf/p5310-pack-bitmaps.sh              |  77 ++-
 t/perf/p5326-multi-pack-bitmaps.sh        |  93 +--
 t/t5310-pack-bitmaps.sh                   | 786 ++++++++++++----------
 t/t5311-pack-bitmaps-shallow.sh           |  53 +-
 t/t5326-multi-pack-bitmaps.sh             | 421 +++++++-----
 t/t5327-multi-pack-bitmaps-rev.sh         |   9 +
 15 files changed, 1238 insertions(+), 658 deletions(-)


base-commit: 39c15e485575089eb77c769f6da02f98a55905e0
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1266%2FAbhra303%2Fbitmap-commit-table-v3
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1266/Abhra303/bitmap-commit-table-v3
Pull-Request: https://github.com/gitgitgadget/git/pull/1266

Range-diff vs v2:

 1:  4d11be66cfa ! 1:  f72bf11e6ef Documentation/technical: describe bitmap lookup table extension
     @@ Metadata
       ## Commit message ##
          Documentation/technical: describe bitmap lookup table extension
      
     -    When reading bitmap file, git loads each and every bitmap one by one
     +    When reading bitmap file, Git loads each and every bitmap one by one
          even if all the bitmaps are not required. A "bitmap lookup table"
          extension to the bitmap format can reduce the overhead of loading
          bitmaps which stores a list of bitmapped commit id pos (in the midx
          or pack, along with their offset and xor offset. This way git can
     -    load only the neccesary bitmaps without loading the previous bitmaps.
     +    load only the necessary bitmaps without loading the previous bitmaps.
      
     -    The older version of Git ignores the lookup table extension and doesn't
     +    Older versions of Git ignore the lookup table extension and don't
          throw any kind of warning or error while parsing the bitmap file.
      
          Add some information for the new "bitmap lookup table" extension in the
          bitmap-format documentation.
      
     -    Co-Authored-by: Taylor Blau <me@ttaylorr.com>
          Mentored-by: Taylor Blau <me@ttaylorr.com>
          Co-Mentored-by: Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
     +    Co-Authored-by: Taylor Blau <me@ttaylorr.com>
          Signed-off-by: Abhradeep Chakraborty <chakrabortyabhradeep79@gmail.com>
      
       ## Documentation/technical/bitmap-format.txt ##
     @@ Documentation/technical/bitmap-format.txt: MIDXs, both the bit-cache and rev-cac
      +			** {empty}
      +			BITMAP_OPT_LOOKUP_TABLE (0x10): :::
      +			If present, the end of the bitmap file contains a table
     -+			containing a list of `N` <commit pos, offset, xor offset>
     ++			containing a list of `N` <commit_pos, offset, xor_row>
      +			triplets. The format and meaning of the table is described
      +			below.
      ++
     -+NOTE: This xor_offset is different from the bitmap's xor_offset.
     -+Bitmap's xor_offset is relative i.e. it tells how many bitmaps we have
     -+to go back from the current bitmap. Lookup table's xor_offset tells the
     -+position of the triplet in the list whose bitmap the current commit's
     -+bitmap have to xor with.
     ++NOTE: Unlike the xor_offset used to compress an individual bitmap,
     ++`xor_row` stores an *absolute* index into the lookup table, not a location
     ++relative to the current entry.
      +
       		4-byte entry count (network byte order)
       
     @@ Documentation/technical/bitmap-format.txt: Note that this hashing scheme is tied
      +-------------------
      +
      +If the BITMAP_OPT_LOOKUP_TABLE flag is set, the last `N * (4 + 8 + 4)`
     -+(preceding the name-hash cache and trailing hash) of the `.bitmap` file
     -+contains a lookup table specifying the information needed to get the
     -+desired bitmap from the entries without parsing previous unnecessary
     ++bytes (preceding the name-hash cache and trailing hash) of the `.bitmap`
     ++file contains a lookup table specifying the information needed to get
     ++the desired bitmap from the entries without parsing previous unnecessary
      +bitmaps.
      +
      +For a `.bitmap` containing `nr_entries` reachability bitmaps, the table
     -+contains a list of `nr_entries` <commit pos, offset, xor offset> triplets.
     -+The content of i'th triplet is -
     ++contains a list of `nr_entries` <commit_pos, offset, xor_row> triplets
     ++(sorted in the ascending order of `commit_pos`). The content of i'th
     ++triplet is -
      +
      +	* {empty}
     -+	commit pos (4 byte integer, network byte order): ::
     -+	It stores the object position of the commit (in the midx or pack index)
     -+	to which the i'th bitmap in the bitmap entries belongs.
     ++	commit_pos (4 byte integer, network byte order): ::
     ++	It stores the object position of a commit (in the midx or pack
     ++	index).
      +
      +	* {empty}
      +	offset (8 byte integer, network byte order): ::
      +	The offset from which that commit's bitmap can be read.
      +
      +	* {empty}
     -+	xor offset (4 byte integer, network byte order): ::
     -+	It holds the position of the triplet with whose bitmap the
     -+	current bitmap need to xor. If the current triplet's bitmap
     -+	do not have any xor bitmap, it defaults to 0xffffffff.
     ++	xor_row (4 byte integer, network byte order): ::
     ++	The position of the triplet whose bitmap is used to compress
     ++	this one, or `0xffffffff` if no such bitmap exists.
 2:  d118f1d45e6 ! 2:  5e9b985e39b pack-bitmap-write.c: write lookup table extension
     @@ Metadata
       ## Commit message ##
          pack-bitmap-write.c: write lookup table extension
      
     -    The bitmap lookup table extension was documentated by an earlier
     -    change, but Git does not yet knowhow to write that extension.
     +    The bitmap lookup table extension was documented by an earlier
     +    change, but Git does not yet know how to write that extension.
      
     -    Teach git to write bitmap lookup table extension. The table contains
     -    the list of `N` <commit pos, offset, xor offset>` triplets. These
     +    Teach Git to write bitmap lookup table extension. The table contains
     +    the list of `N` <commit_pos, offset, xor_row>` triplets. These
          triplets are sorted according to their commit pos (ascending order).
          The meaning of each data in the i'th triplet is given below:
      
     -      - Commit pos is the position of the commit in the pack-index
     -        (or midx) to which the i'th bitmap belongs. It is a 4 byte
     -        network byte order integer.
     +      - commit_pos stores commit position (in the pack-index or midx).
     +        It is a 4 byte network byte order unsigned integer.
      
     -      - offset is the position of the i'th bitmap.
     +      - offset is the position (in the bitmap file) from which that
     +        commit's bitmap can be read.
      
     -      - xor offset denotes the position of the triplet with whose
     -        bitmap the current triplet's bitmap need to xor with.
     +      - xor_row is the position of the triplet in the lookup table
     +        whose bitmap is used to compress this bitmap, or `0xffffffff`
     +        if no such bitmap exists.
      
     -    Co-authored-by: Taylor Blau <me@ttaylorr.com>
          Mentored-by: Taylor Blau <me@ttaylorr.com>
          Co-mentored-by: Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
     +    Co-authored-by: Taylor Blau <me@ttaylorr.com>
          Signed-off-by: Abhradeep Chakraborty <chakrabortyabhradeep79@gmail.com>
      
       ## pack-bitmap-write.c ##
      @@ pack-bitmap-write.c: static const struct object_id *oid_access(size_t pos, const void *table)
     + 	return &index[pos]->oid;
     + }
       
     ++static int commit_bitmap_writer_pos(struct object_id *oid,
     ++				    struct pack_idx_entry **index,
     ++				    uint32_t index_nr)
     ++{
     ++	return oid_pos(oid, index, index_nr, oid_access);
     ++}
     ++
       static void write_selected_commits_v1(struct hashfile *f,
       				      struct pack_idx_entry **index,
      -				      uint32_t index_nr)
      +				      uint32_t index_nr,
     -+				      uint64_t *offsets,
     -+				      uint32_t *commit_positions)
     ++				      off_t *offsets)
       {
       	int i;
       
      @@ pack-bitmap-write.c: static void write_selected_commits_v1(struct hashfile *f,
     + 		struct bitmapped_commit *stored = &writer.selected[i];
     + 
     + 		int commit_pos =
     +-			oid_pos(&stored->commit->object.oid, index, index_nr, oid_access);
     ++			commit_bitmap_writer_pos(&stored->commit->object.oid, index, index_nr);
     + 
       		if (commit_pos < 0)
       			BUG("trying to write commit not in index");
       
      +		if (offsets)
      +			offsets[i] = hashfile_total(f);
     -+		if (commit_positions)
     -+			commit_positions[i] = commit_pos;
      +
       		hashwrite_be32(f, commit_pos);
       		hashwrite_u8(f, stored->xor_offset);
     @@ pack-bitmap-write.c: static void write_selected_commits_v1(struct hashfile *f,
       	}
       }
       
     -+static int table_cmp(const void *_va, const void *_vb, void *commit_positions)
     ++static int table_cmp(const void *_va, const void *_vb, void *_data)
      +{
     -+	int8_t result = 0;
     -+	uint32_t *positions = (uint32_t *) commit_positions;
     -+	uint32_t a = positions[*(uint32_t *)_va];
     -+	uint32_t b = positions[*(uint32_t *)_vb];
     ++	uint32_t *commit_positions = _data;
     ++	uint32_t a = commit_positions[*(uint32_t *)_va];
     ++	uint32_t b = commit_positions[*(uint32_t *)_vb];
      +
      +	if (a > b)
     -+		result = 1;
     ++		return 1;
      +	else if (a < b)
     -+		result = -1;
     -+	else
     -+		result = 0;
     ++		return -1;
      +
     -+	return result;
     ++	return 0;
      +}
      +
      +static void write_lookup_table(struct hashfile *f,
     -+			       uint64_t *offsets,
     -+			       uint32_t *commit_positions)
     ++			       struct pack_idx_entry **index,
     ++			       uint32_t index_nr,
     ++			       off_t *offsets)
      +{
      +	uint32_t i;
     -+	uint32_t *table, *table_inv;
     ++	uint32_t *table, *table_inv, *commit_positions;
      +
      +	ALLOC_ARRAY(table, writer.selected_nr);
      +	ALLOC_ARRAY(table_inv, writer.selected_nr);
     ++	ALLOC_ARRAY(commit_positions, writer.selected_nr);
     ++
     ++	/* store the index positions of the commits */
     ++	for (i = 0; i < writer.selected_nr; i++) {
     ++		int pos = commit_bitmap_writer_pos(&writer.selected[i].commit->object.oid,
     ++						   index, index_nr);
     ++		if (pos < 0)
     ++			BUG(_("trying to write commit not in index"));
     ++
     ++		commit_positions[i] = pos;
     ++	}
      +
      +	for (i = 0; i < writer.selected_nr; i++)
      +		table[i] = i;
      +
     ++	/*
     ++	 * At the end of this sort table[j] = i means that the i'th
     ++	 * bitmap corresponds to j'th bitmapped commit in lex order of
     ++	 * OIDs.
     ++	 */
      +	QSORT_S(table, writer.selected_nr, table_cmp, commit_positions);
      +
     ++	/* table_inv helps us discover that relationship (i'th bitmap
     ++	 * to j'th commit by j = table_inv[i])
     ++	 */
      +	for (i = 0; i < writer.selected_nr; i++)
      +		table_inv[table[i]] = i;
      +
     ++	trace2_region_enter("pack-bitmap-write", "writing_lookup_table", the_repository);
      +	for (i = 0; i < writer.selected_nr; i++) {
      +		struct bitmapped_commit *selected = &writer.selected[table[i]];
      +		uint32_t xor_offset = selected->xor_offset;
     ++		uint32_t xor_row;
     ++
     ++		if (xor_offset) {
     ++			/*
     ++			 * xor_index stores the index (in the bitmap entries)
     ++			 * of the corresponding xor bitmap. But we need to convert
     ++			 * this index into lookup table's index. So, table_inv[xor_index]
     ++			 * gives us the index position w.r.t. the lookup table.
     ++			 *
     ++			 * If "k = table[i] - xor_offset" then the xor base is the k'th
     ++			 * bitmap. `table_inv[k]` gives us the position of that bitmap
     ++			 * in the lookup table.
     ++			 */
     ++			uint32_t xor_index = table[i] - xor_offset;
     ++			xor_row = table_inv[xor_index];
     ++		} else {
     ++			xor_row = 0xffffffff;
     ++		}
      +
      +		hashwrite_be32(f, commit_positions[table[i]]);
     -+		hashwrite_be64(f, offsets[table[i]]);
     -+		hashwrite_be32(f, xor_offset ?
     -+				table_inv[table[i] - xor_offset]: 0xffffffff);
     ++		hashwrite_be64(f, (uint64_t)offsets[table[i]]);
     ++		hashwrite_be32(f, xor_row);
      +	}
     ++	trace2_region_leave("pack-bitmap-write", "writing_lookup_table", the_repository);
      +
      +	free(table);
      +	free(table_inv);
     ++	free(commit_positions);
      +}
      +
       static void write_hash_cache(struct hashfile *f,
     @@ pack-bitmap-write.c: void bitmap_writer_finish(struct pack_idx_entry **index,
       {
       	static uint16_t default_version = 1;
       	static uint16_t flags = BITMAP_OPT_FULL_DAG;
     -+	uint64_t *offsets = NULL;
     -+	uint32_t *commit_positions = NULL;
     ++	off_t *offsets = NULL;
       	struct strbuf tmp_file = STRBUF_INIT;
       	struct hashfile *f;
       
     @@ pack-bitmap-write.c: void bitmap_writer_finish(struct pack_idx_entry **index,
       	dump_bitmap(f, writer.blobs);
       	dump_bitmap(f, writer.tags);
      -	write_selected_commits_v1(f, index, index_nr);
     - 
     -+	if (options & BITMAP_OPT_LOOKUP_TABLE) {
     ++
     ++	if (options & BITMAP_OPT_LOOKUP_TABLE)
      +		CALLOC_ARRAY(offsets, index_nr);
     -+		CALLOC_ARRAY(commit_positions, index_nr);
     -+	}
      +
     -+	write_selected_commits_v1(f, index, index_nr, offsets, commit_positions);
     ++	write_selected_commits_v1(f, index, index_nr, offsets);
      +
      +	if (options & BITMAP_OPT_LOOKUP_TABLE)
     -+		write_lookup_table(f, offsets, commit_positions);
     ++		write_lookup_table(f, index, index_nr, offsets);
     + 
       	if (options & BITMAP_OPT_HASH_CACHE)
       		write_hash_cache(f, index, index_nr);
     - 
      @@ pack-bitmap-write.c: void bitmap_writer_finish(struct pack_idx_entry **index,
       		die_errno("unable to rename temporary bitmap file to '%s'", filename);
       
       	strbuf_release(&tmp_file);
      +	free(offsets);
     -+	free(commit_positions);
       }
      
       ## pack-bitmap.h ##
 3:  7786dc879f0 ! 3:  3dc40cc7f73 pack-bitmap-write: learn pack.writeBitmapLookupTable and add tests
     @@ Metadata
       ## Commit message ##
          pack-bitmap-write: learn pack.writeBitmapLookupTable and add tests
      
     -    Teach git to provide a way for users to enable/disable bitmap lookup
     +    Teach Git to provide a way for users to enable/disable bitmap lookup
          table extension by providing a config option named 'writeBitmapLookupTable'.
     -    Default is true.
     +    Default is false.
      
          Also add test to verify writting of lookup table.
      
     -    Co-Authored-by: Taylor Blau <me@ttaylorr.com>
     -    Signed-off-by: Abhradeep Chakraborty <chakrabortyabhradeep79@gmail.com>
          Mentored-by: Taylor Blau <me@ttaylorr.com>
          Co-Mentored-by: Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
     +    Co-Authored-by: Taylor Blau <me@ttaylorr.com>
     +    Signed-off-by: Abhradeep Chakraborty <chakrabortyabhradeep79@gmail.com>
      
       ## Documentation/config/pack.txt ##
      @@ Documentation/config/pack.txt: When writing a multi-pack reachability bitmap, no new namehashes are
     @@ Documentation/config/pack.txt: When writing a multi-pack reachability bitmap, no
       permuted into their appropriate location when writing a new bitmap.
       
      +pack.writeBitmapLookupTable::
     -+	When true, git will include a "lookup table" section in the
     ++	When true, Git will include a "lookup table" section in the
      +	bitmap index (if one is written). This table is used to defer
      +	loading individual bitmaps as late as possible. This can be
     -+	beneficial in repositories which have relatively large bitmap
     -+	indexes. Defaults to true.
     ++	beneficial in repositories that have relatively large bitmap
     ++	indexes. Defaults to false.
      +
       pack.writeReverseIndex::
       	When true, git will write a corresponding .rev file (see:
     @@ builtin/multi-pack-index.c: static int git_multi_pack_index_write_config(const c
       	/*
       	 * We should never make a fall-back call to 'git_default_config', since
       	 * this was already called in 'cmd_multi_pack_index()'.
     -@@ builtin/multi-pack-index.c: static int cmd_multi_pack_index_write(int argc, const char **argv)
     - 	};
     - 
     - 	opts.flags |= MIDX_WRITE_BITMAP_HASH_CACHE;
     -+	opts.flags |= MIDX_WRITE_BITMAP_LOOKUP_TABLE;
     - 
     - 	git_config(git_multi_pack_index_write_config, NULL);
     - 
      
       ## builtin/pack-objects.c ##
     -@@ builtin/pack-objects.c: static enum {
     - 	WRITE_BITMAP_QUIET,
     - 	WRITE_BITMAP_TRUE,
     - } write_bitmap_index;
     --static uint16_t write_bitmap_options = BITMAP_OPT_HASH_CACHE;
     -+static uint16_t write_bitmap_options = BITMAP_OPT_HASH_CACHE | BITMAP_OPT_LOOKUP_TABLE;
     - 
     - static int exclude_promisor_objects;
     - 
      @@ builtin/pack-objects.c: static int git_pack_config(const char *k, const char *v, void *cb)
       		else
       			write_bitmap_options &= ~BITMAP_OPT_HASH_CACHE;
     @@ midx.h: struct multi_pack_index {
       const unsigned char *get_midx_checksum(struct multi_pack_index *m);
       void get_midx_filename(struct strbuf *out, const char *object_dir);
      
     - ## pack-bitmap-write.c ##
     -@@ pack-bitmap-write.c: static void write_lookup_table(struct hashfile *f,
     - 	for (i = 0; i < writer.selected_nr; i++)
     - 		table_inv[table[i]] = i;
     - 
     -+	trace2_region_enter("pack-bitmap-write", "writing_lookup_table", the_repository);
     - 	for (i = 0; i < writer.selected_nr; i++) {
     - 		struct bitmapped_commit *selected = &writer.selected[table[i]];
     - 		uint32_t xor_offset = selected->xor_offset;
     -@@ pack-bitmap-write.c: static void write_lookup_table(struct hashfile *f,
     - 
     - 	free(table);
     - 	free(table_inv);
     -+	trace2_region_leave("pack-bitmap-write", "writing_lookup_table", the_repository);
     + ## t/t5310-pack-bitmaps.sh ##
     +@@ t/t5310-pack-bitmaps.sh: has_any () {
     + 	grep -Ff "$1" "$2"
       }
       
     - static void write_hash_cache(struct hashfile *f,
     -
     - ## t/t5310-pack-bitmaps.sh ##
     -@@ t/t5310-pack-bitmaps.sh: test_expect_success 'full repack creates bitmaps' '
     - 	ls .git/objects/pack/ | grep bitmap >output &&
     - 	test_line_count = 1 output &&
     - 	grep "\"key\":\"num_selected_commits\",\"value\":\"106\"" trace &&
     +-setup_bitmap_history
     +-
     +-test_expect_success 'setup writing bitmaps during repack' '
     +-	git config repack.writeBitmaps true
     +-'
     +-
     +-test_expect_success 'full repack creates bitmaps' '
     +-	GIT_TRACE2_EVENT="$(pwd)/trace" \
     ++test_bitmap_cases () {
     ++	writeLookupTable=false
     ++	for i in "$@"
     ++	do
     ++		case "$i" in
     ++		"pack.writeBitmapLookupTable") writeLookupTable=true;;
     ++		esac
     ++	done
     ++
     ++	test_expect_success 'setup test repository' '
     ++		rm -fr * .git &&
     ++		git init &&
     ++		git config pack.writeBitmapLookupTable '"$writeLookupTable"'
     ++	'
     ++	setup_bitmap_history
     ++
     ++	test_expect_success 'setup writing bitmaps during repack' '
     ++		git config repack.writeBitmaps true
     ++	'
     ++
     ++	test_expect_success 'full repack creates bitmaps' '
     ++		GIT_TRACE2_EVENT="$(pwd)/trace" \
     ++			git repack -ad &&
     ++		ls .git/objects/pack/ | grep bitmap >output &&
     ++		test_line_count = 1 output &&
     ++		grep "\"key\":\"num_selected_commits\",\"value\":\"106\"" trace &&
     ++		grep "\"key\":\"num_maximal_commits\",\"value\":\"107\"" trace
     ++	'
     ++
     ++	basic_bitmap_tests
     ++
     ++	test_expect_success 'pack-objects respects --local (non-local loose)' '
     ++		git init --bare alt.git &&
     ++		echo $(pwd)/alt.git/objects >.git/objects/info/alternates &&
     ++		echo content1 >file1 &&
     ++		# non-local loose object which is not present in bitmapped pack
     ++		altblob=$(GIT_DIR=alt.git git hash-object -w file1) &&
     ++		# non-local loose object which is also present in bitmapped pack
     ++		git cat-file blob $blob | GIT_DIR=alt.git git hash-object -w --stdin &&
     ++		git add file1 &&
     ++		test_tick &&
     ++		git commit -m commit_file1 &&
     ++		echo HEAD | git pack-objects --local --stdout --revs >1.pack &&
     ++		git index-pack 1.pack &&
     ++		list_packed_objects 1.idx >1.objects &&
     ++		printf "%s\n" "$altblob" "$blob" >nonlocal-loose &&
     ++		! has_any nonlocal-loose 1.objects
     ++	'
     ++
     ++	test_expect_success 'pack-objects respects --honor-pack-keep (local non-bitmapped pack)' '
     ++		echo content2 >file2 &&
     ++		blob2=$(git hash-object -w file2) &&
     ++		git add file2 &&
     ++		test_tick &&
     ++		git commit -m commit_file2 &&
     ++		printf "%s\n" "$blob2" "$bitmaptip" >keepobjects &&
     ++		pack2=$(git pack-objects pack2 <keepobjects) &&
     ++		mv pack2-$pack2.* .git/objects/pack/ &&
     ++		>.git/objects/pack/pack2-$pack2.keep &&
     ++		rm $(objpath $blob2) &&
     ++		echo HEAD | git pack-objects --honor-pack-keep --stdout --revs >2a.pack &&
     ++		git index-pack 2a.pack &&
     ++		list_packed_objects 2a.idx >2a.objects &&
     ++		! has_any keepobjects 2a.objects
     ++	'
     ++
     ++	test_expect_success 'pack-objects respects --local (non-local pack)' '
     ++		mv .git/objects/pack/pack2-$pack2.* alt.git/objects/pack/ &&
     ++		echo HEAD | git pack-objects --local --stdout --revs >2b.pack &&
     ++		git index-pack 2b.pack &&
     ++		list_packed_objects 2b.idx >2b.objects &&
     ++		! has_any keepobjects 2b.objects
     ++	'
     ++
     ++	test_expect_success 'pack-objects respects --honor-pack-keep (local bitmapped pack)' '
     ++		ls .git/objects/pack/ | grep bitmap >output &&
     ++		test_line_count = 1 output &&
     ++		packbitmap=$(basename $(cat output) .bitmap) &&
     ++		list_packed_objects .git/objects/pack/$packbitmap.idx >packbitmap.objects &&
     ++		test_when_finished "rm -f .git/objects/pack/$packbitmap.keep" &&
     ++		>.git/objects/pack/$packbitmap.keep &&
     ++		echo HEAD | git pack-objects --honor-pack-keep --stdout --revs >3a.pack &&
     ++		git index-pack 3a.pack &&
     ++		list_packed_objects 3a.idx >3a.objects &&
     ++		! has_any packbitmap.objects 3a.objects
     ++	'
     ++
     ++	test_expect_success 'pack-objects respects --local (non-local bitmapped pack)' '
     ++		mv .git/objects/pack/$packbitmap.* alt.git/objects/pack/ &&
     ++		rm -f .git/objects/pack/multi-pack-index &&
     ++		test_when_finished "mv alt.git/objects/pack/$packbitmap.* .git/objects/pack/" &&
     ++		echo HEAD | git pack-objects --local --stdout --revs >3b.pack &&
     ++		git index-pack 3b.pack &&
     ++		list_packed_objects 3b.idx >3b.objects &&
     ++		! has_any packbitmap.objects 3b.objects
     ++	'
     ++
     ++	test_expect_success 'pack-objects to file can use bitmap' '
     ++		# make sure we still have 1 bitmap index from previous tests
     ++		ls .git/objects/pack/ | grep bitmap >output &&
     ++		test_line_count = 1 output &&
     ++		# verify equivalent packs are generated with/without using bitmap index
     ++		packasha1=$(git pack-objects --no-use-bitmap-index --all packa </dev/null) &&
     ++		packbsha1=$(git pack-objects --use-bitmap-index --all packb </dev/null) &&
     ++		list_packed_objects packa-$packasha1.idx >packa.objects &&
     ++		list_packed_objects packb-$packbsha1.idx >packb.objects &&
     ++		test_cmp packa.objects packb.objects
     ++	'
     ++
     ++	test_expect_success 'full repack, reusing previous bitmaps' '
     + 		git repack -ad &&
     +-	ls .git/objects/pack/ | grep bitmap >output &&
     +-	test_line_count = 1 output &&
     +-	grep "\"key\":\"num_selected_commits\",\"value\":\"106\"" trace &&
      -	grep "\"key\":\"num_maximal_commits\",\"value\":\"107\"" trace
     -+	grep "\"key\":\"num_maximal_commits\",\"value\":\"107\"" trace &&
     -+	grep "\"label\":\"writing_lookup_table\"" trace
     +-'
     ++		ls .git/objects/pack/ | grep bitmap >output &&
     ++		test_line_count = 1 output
     ++	'
     ++
     ++	test_expect_success 'fetch (full bitmap)' '
     ++		git --git-dir=clone.git fetch origin second:second &&
     ++		git rev-parse HEAD >expect &&
     ++		git --git-dir=clone.git rev-parse HEAD >actual &&
     ++		test_cmp expect actual
     ++	'
     ++
     ++	test_expect_success 'create objects for missing-HAVE tests' '
     ++		blob=$(echo "missing have" | git hash-object -w --stdin) &&
     ++		tree=$(printf "100644 blob $blob\tfile\n" | git mktree) &&
     ++		parent=$(echo parent | git commit-tree $tree) &&
     ++		commit=$(echo commit | git commit-tree $tree -p $parent) &&
     ++		cat >revs <<-EOF
     ++		HEAD
     ++		^HEAD^
     ++		^$commit
     ++		EOF
     ++	'
     ++
     ++	test_expect_success 'pack-objects respects --incremental' '
     ++		cat >revs2 <<-EOF &&
     ++		HEAD
     ++		$commit
     ++		EOF
     ++		git pack-objects --incremental --stdout --revs <revs2 >4.pack &&
     ++		git index-pack 4.pack &&
     ++		list_packed_objects 4.idx >4.objects &&
     ++		test_line_count = 4 4.objects &&
     ++		git rev-list --objects $commit >revlist &&
     ++		cut -d" " -f1 revlist |sort >objects &&
     ++		test_cmp 4.objects objects
     ++	'
     ++
     ++	test_expect_success 'pack with missing blob' '
     ++		rm $(objpath $blob) &&
     ++		git pack-objects --stdout --revs <revs >/dev/null
     ++	'
     ++
     ++	test_expect_success 'pack with missing tree' '
     ++		rm $(objpath $tree) &&
     ++		git pack-objects --stdout --revs <revs >/dev/null
     ++	'
     ++
     ++	test_expect_success 'pack with missing parent' '
     ++		rm $(objpath $parent) &&
     ++		git pack-objects --stdout --revs <revs >/dev/null
     ++	'
     ++
     ++	test_expect_success JGIT,SHA1 'we can read jgit bitmaps' '
     ++		git clone --bare . compat-jgit.git &&
     ++		(
     ++			cd compat-jgit.git &&
     ++			rm -f objects/pack/*.bitmap &&
     ++			jgit gc &&
     ++			git rev-list --test-bitmap HEAD
     ++		)
     ++	'
     ++
     ++	test_expect_success JGIT,SHA1 'jgit can read our bitmaps' '
     ++		git clone --bare . compat-us.git &&
     ++		(
     ++			cd compat-us.git &&
     ++			git config pack.writeBitmapLookupTable '"$writeLookupTable"' &&
     ++			git repack -adb &&
     ++			# jgit gc will barf if it does not like our bitmaps
     ++			jgit gc
     ++		)
     ++	'
     ++
     ++	test_expect_success 'splitting packs does not generate bogus bitmaps' '
     ++		test-tool genrandom foo $((1024 * 1024)) >rand &&
     ++		git add rand &&
     ++		git commit -m "commit with big file" &&
     ++		git -c pack.packSizeLimit=500k repack -adb &&
     ++		git init --bare no-bitmaps.git &&
     ++		git -C no-bitmaps.git fetch .. HEAD
     ++	'
     ++
     ++	test_expect_success 'set up reusable pack' '
     ++		rm -f .git/objects/pack/*.keep &&
     ++		git repack -adb &&
     ++		reusable_pack () {
     ++			git for-each-ref --format="%(objectname)" |
     ++			git pack-objects --delta-base-offset --revs --stdout "$@"
     ++		}
     ++	'
     ++
     ++	test_expect_success 'pack reuse respects --honor-pack-keep' '
     ++		test_when_finished "rm -f .git/objects/pack/*.keep" &&
     ++		for i in .git/objects/pack/*.pack
     ++		do
     ++			>${i%.pack}.keep || return 1
     ++		done &&
     ++		reusable_pack --honor-pack-keep >empty.pack &&
     ++		git index-pack empty.pack &&
     ++		git show-index <empty.idx >actual &&
     ++		test_must_be_empty actual
     ++	'
     ++
     ++	test_expect_success 'pack reuse respects --local' '
     ++		mv .git/objects/pack/* alt.git/objects/pack/ &&
     ++		test_when_finished "mv alt.git/objects/pack/* .git/objects/pack/" &&
     ++		reusable_pack --local >empty.pack &&
     ++		git index-pack empty.pack &&
     ++		git show-index <empty.idx >actual &&
     ++		test_must_be_empty actual
     ++	'
     ++
     ++	test_expect_success 'pack reuse respects --incremental' '
     ++		reusable_pack --incremental >empty.pack &&
     ++		git index-pack empty.pack &&
     ++		git show-index <empty.idx >actual &&
     ++		test_must_be_empty actual
     ++	'
     ++
     ++	test_expect_success 'truncated bitmap fails gracefully (ewah)' '
     ++		test_config pack.writebitmaphashcache false &&
     ++		git repack -ad &&
     ++		git rev-list --use-bitmap-index --count --all >expect &&
     ++		bitmap=$(ls .git/objects/pack/*.bitmap) &&
     ++		test_when_finished "rm -f $bitmap" &&
     ++		test_copy_bytes 256 <$bitmap >$bitmap.tmp &&
     ++		mv -f $bitmap.tmp $bitmap &&
     ++		git rev-list --use-bitmap-index --count --all >actual 2>stderr &&
     ++		test_cmp expect actual &&
     ++		test_i18ngrep corrupt.ewah.bitmap stderr
     ++	'
     ++
     ++	test_expect_success 'truncated bitmap fails gracefully (cache)' '
     ++		git repack -ad &&
     ++		git rev-list --use-bitmap-index --count --all >expect &&
     ++		bitmap=$(ls .git/objects/pack/*.bitmap) &&
     ++		test_when_finished "rm -f $bitmap" &&
     ++		test_copy_bytes 512 <$bitmap >$bitmap.tmp &&
     ++		mv -f $bitmap.tmp $bitmap &&
     ++		git rev-list --use-bitmap-index --count --all >actual 2>stderr &&
     ++		test_cmp expect actual &&
     ++		test_i18ngrep corrupted.bitmap.index stderr
     ++	'
     ++
     ++	# Create a state of history with these properties:
     ++	#
     ++	#  - refs that allow a client to fetch some new history, while sharing some old
     ++	#    history with the server; we use branches delta-reuse-old and
     ++	#    delta-reuse-new here
     ++	#
     ++	#  - the new history contains an object that is stored on the server as a delta
     ++	#    against a base that is in the old history
     ++	#
     ++	#  - the base object is not immediately reachable from the tip of the old
     ++	#    history; finding it would involve digging down through history we know the
     ++	#    other side has
     ++	#
     ++	# This should result in a state where fetching from old->new would not
     ++	# traditionally reuse the on-disk delta (because we'd have to dig to realize
     ++	# that the client has it), but we will do so if bitmaps can tell us cheaply
     ++	# that the other side has it.
     ++	test_expect_success 'set up thin delta-reuse parent' '
     ++		# This first commit contains the buried base object.
     ++		test-tool genrandom delta 16384 >file &&
     ++		git add file &&
     ++		git commit -m "delta base" &&
     ++		base=$(git rev-parse --verify HEAD:file) &&
     ++
     ++		# These intermediate commits bury the base back in history.
     ++		# This becomes the "old" state.
     ++		for i in 1 2 3 4 5
     ++		do
     ++			echo $i >file &&
     ++			git commit -am "intermediate $i" || return 1
     ++		done &&
     ++		git branch delta-reuse-old &&
     ++
     ++		# And now our new history has a delta against the buried base. Note
     ++		# that this must be smaller than the original file, since pack-objects
     ++		# prefers to create deltas from smaller objects to larger.
     ++		test-tool genrandom delta 16300 >file &&
     ++		git commit -am "delta result" &&
     ++		delta=$(git rev-parse --verify HEAD:file) &&
     ++		git branch delta-reuse-new &&
     ++
     ++		# Repack with bitmaps and double check that we have the expected delta
     ++		# relationship.
     ++		git repack -adb &&
     ++		have_delta $delta $base
     ++	'
     ++
     ++	# Now we can sanity-check the non-bitmap behavior (that the server is not able
     ++	# to reuse the delta). This isn't strictly something we care about, so this
     ++	# test could be scrapped in the future. But it makes sure that the next test is
     ++	# actually triggering the feature we want.
     ++	#
     ++	# Note that our tools for working with on-the-wire "thin" packs are limited. So
     ++	# we actually perform the fetch, retain the resulting pack, and inspect the
     ++	# result.
     ++	test_expect_success 'fetch without bitmaps ignores delta against old base' '
     ++		test_config pack.usebitmaps false &&
     ++		test_when_finished "rm -rf client.git" &&
     ++		git init --bare client.git &&
     ++		(
     ++			cd client.git &&
     ++			git config transfer.unpackLimit 1 &&
     ++			git fetch .. delta-reuse-old:delta-reuse-old &&
     ++			git fetch .. delta-reuse-new:delta-reuse-new &&
     ++			have_delta $delta $ZERO_OID
     ++		)
     ++	'
     ++
     ++	# And do the same for the bitmap case, where we do expect to find the delta.
     ++	test_expect_success 'fetch with bitmaps can reuse old base' '
     ++		test_config pack.usebitmaps true &&
     ++		test_when_finished "rm -rf client.git" &&
     ++		git init --bare client.git &&
     ++		(
     ++			cd client.git &&
     ++			git config transfer.unpackLimit 1 &&
     ++			git fetch .. delta-reuse-old:delta-reuse-old &&
     ++			git fetch .. delta-reuse-new:delta-reuse-new &&
     ++			have_delta $delta $base
     ++		)
     ++	'
     ++
     ++	test_expect_success 'pack.preferBitmapTips' '
     ++		git init repo &&
     ++		test_when_finished "rm -fr repo" &&
     ++		(
     ++			cd repo &&
     ++			git config pack.writeBitmapLookupTable '"$writeLookupTable"' &&
     ++
     ++			# create enough commits that not all are receive bitmap
     ++			# coverage even if they are all at the tip of some reference.
     ++			test_commit_bulk --message="%s" 103 &&
     ++
     ++			git rev-list HEAD >commits.raw &&
     ++			sort <commits.raw >commits &&
     ++
     ++			git log --format="create refs/tags/%s %H" HEAD >refs &&
     ++			git update-ref --stdin <refs &&
     ++
     ++			git repack -adb &&
     ++			test-tool bitmap list-commits | sort >bitmaps &&
     ++
     ++			# remember which commits did not receive bitmaps
     ++			comm -13 bitmaps commits >before &&
     ++			test_file_not_empty before &&
     ++
     ++			# mark the commits which did not receive bitmaps as preferred,
     ++			# and generate the bitmap again
     ++			perl -pe "s{^}{create refs/tags/include/$. }" <before |
     ++				git update-ref --stdin &&
     ++			git -c pack.preferBitmapTips=refs/tags/include repack -adb &&
     ++
     ++			# finally, check that the commit(s) without bitmap coverage
     ++			# are not the same ones as before
     ++			test-tool bitmap list-commits | sort >bitmaps &&
     ++			comm -13 bitmaps commits >after &&
     ++
     ++			! test_cmp before after
     ++		)
     ++	'
     ++
     ++	test_expect_success 'complains about multiple pack bitmaps' '
     ++		rm -fr repo &&
     ++		git init repo &&
     ++		test_when_finished "rm -fr repo" &&
     ++		(
     ++			cd repo &&
     ++			git config pack.writeBitmapLookupTable '"$writeLookupTable"' &&
     ++
     ++			test_commit base &&
     ++
     ++			git repack -adb &&
     ++			bitmap="$(ls .git/objects/pack/pack-*.bitmap)" &&
     ++			mv "$bitmap" "$bitmap.bak" &&
     ++
     ++			test_commit other &&
     ++			git repack -ab &&
     ++
     ++			mv "$bitmap.bak" "$bitmap" &&
     ++
     ++			find .git/objects/pack -type f -name "*.pack" >packs &&
     ++			find .git/objects/pack -type f -name "*.bitmap" >bitmaps &&
     ++			test_line_count = 2 packs &&
     ++			test_line_count = 2 bitmaps &&
     ++
     ++			git rev-list --use-bitmap-index HEAD 2>err &&
     ++			grep "ignoring extra bitmap file" err
     ++		)
     ++	'
     ++}
     + 
     +-basic_bitmap_tests
     ++test_bitmap_cases
     + 
     + test_expect_success 'incremental repack fails when bitmaps are requested' '
     + 	test_commit more-1 &&
     +@@ t/t5310-pack-bitmaps.sh: test_expect_success 'incremental repack can disable bitmaps' '
     + 	git repack -d --no-write-bitmap-index
     + '
     + 
     +-test_expect_success 'pack-objects respects --local (non-local loose)' '
     +-	git init --bare alt.git &&
     +-	echo $(pwd)/alt.git/objects >.git/objects/info/alternates &&
     +-	echo content1 >file1 &&
     +-	# non-local loose object which is not present in bitmapped pack
     +-	altblob=$(GIT_DIR=alt.git git hash-object -w file1) &&
     +-	# non-local loose object which is also present in bitmapped pack
     +-	git cat-file blob $blob | GIT_DIR=alt.git git hash-object -w --stdin &&
     +-	git add file1 &&
     +-	test_tick &&
     +-	git commit -m commit_file1 &&
     +-	echo HEAD | git pack-objects --local --stdout --revs >1.pack &&
     +-	git index-pack 1.pack &&
     +-	list_packed_objects 1.idx >1.objects &&
     +-	printf "%s\n" "$altblob" "$blob" >nonlocal-loose &&
     +-	! has_any nonlocal-loose 1.objects
     +-'
     +-
     +-test_expect_success 'pack-objects respects --honor-pack-keep (local non-bitmapped pack)' '
     +-	echo content2 >file2 &&
     +-	blob2=$(git hash-object -w file2) &&
     +-	git add file2 &&
     +-	test_tick &&
     +-	git commit -m commit_file2 &&
     +-	printf "%s\n" "$blob2" "$bitmaptip" >keepobjects &&
     +-	pack2=$(git pack-objects pack2 <keepobjects) &&
     +-	mv pack2-$pack2.* .git/objects/pack/ &&
     +-	>.git/objects/pack/pack2-$pack2.keep &&
     +-	rm $(objpath $blob2) &&
     +-	echo HEAD | git pack-objects --honor-pack-keep --stdout --revs >2a.pack &&
     +-	git index-pack 2a.pack &&
     +-	list_packed_objects 2a.idx >2a.objects &&
     +-	! has_any keepobjects 2a.objects
     +-'
     +-
     +-test_expect_success 'pack-objects respects --local (non-local pack)' '
     +-	mv .git/objects/pack/pack2-$pack2.* alt.git/objects/pack/ &&
     +-	echo HEAD | git pack-objects --local --stdout --revs >2b.pack &&
     +-	git index-pack 2b.pack &&
     +-	list_packed_objects 2b.idx >2b.objects &&
     +-	! has_any keepobjects 2b.objects
     +-'
     +-
     +-test_expect_success 'pack-objects respects --honor-pack-keep (local bitmapped pack)' '
     +-	ls .git/objects/pack/ | grep bitmap >output &&
     +-	test_line_count = 1 output &&
     +-	packbitmap=$(basename $(cat output) .bitmap) &&
     +-	list_packed_objects .git/objects/pack/$packbitmap.idx >packbitmap.objects &&
     +-	test_when_finished "rm -f .git/objects/pack/$packbitmap.keep" &&
     +-	>.git/objects/pack/$packbitmap.keep &&
     +-	echo HEAD | git pack-objects --honor-pack-keep --stdout --revs >3a.pack &&
     +-	git index-pack 3a.pack &&
     +-	list_packed_objects 3a.idx >3a.objects &&
     +-	! has_any packbitmap.objects 3a.objects
     +-'
     +-
     +-test_expect_success 'pack-objects respects --local (non-local bitmapped pack)' '
     +-	mv .git/objects/pack/$packbitmap.* alt.git/objects/pack/ &&
     +-	rm -f .git/objects/pack/multi-pack-index &&
     +-	test_when_finished "mv alt.git/objects/pack/$packbitmap.* .git/objects/pack/" &&
     +-	echo HEAD | git pack-objects --local --stdout --revs >3b.pack &&
     +-	git index-pack 3b.pack &&
     +-	list_packed_objects 3b.idx >3b.objects &&
     +-	! has_any packbitmap.objects 3b.objects
     +-'
     +-
     +-test_expect_success 'pack-objects to file can use bitmap' '
     +-	# make sure we still have 1 bitmap index from previous tests
     +-	ls .git/objects/pack/ | grep bitmap >output &&
     +-	test_line_count = 1 output &&
     +-	# verify equivalent packs are generated with/without using bitmap index
     +-	packasha1=$(git pack-objects --no-use-bitmap-index --all packa </dev/null) &&
     +-	packbsha1=$(git pack-objects --use-bitmap-index --all packb </dev/null) &&
     +-	list_packed_objects packa-$packasha1.idx >packa.objects &&
     +-	list_packed_objects packb-$packbsha1.idx >packb.objects &&
     +-	test_cmp packa.objects packb.objects
     +-'
     +-
     +-test_expect_success 'full repack, reusing previous bitmaps' '
     +-	git repack -ad &&
     +-	ls .git/objects/pack/ | grep bitmap >output &&
     +-	test_line_count = 1 output
     +-'
     +-
     +-test_expect_success 'fetch (full bitmap)' '
     +-	git --git-dir=clone.git fetch origin second:second &&
     +-	git rev-parse HEAD >expect &&
     +-	git --git-dir=clone.git rev-parse HEAD >actual &&
     +-	test_cmp expect actual
     +-'
     +-
     +-test_expect_success 'create objects for missing-HAVE tests' '
     +-	blob=$(echo "missing have" | git hash-object -w --stdin) &&
     +-	tree=$(printf "100644 blob $blob\tfile\n" | git mktree) &&
     +-	parent=$(echo parent | git commit-tree $tree) &&
     +-	commit=$(echo commit | git commit-tree $tree -p $parent) &&
     +-	cat >revs <<-EOF
     +-	HEAD
     +-	^HEAD^
     +-	^$commit
     +-	EOF
     +-'
     +-
     +-test_expect_success 'pack-objects respects --incremental' '
     +-	cat >revs2 <<-EOF &&
     +-	HEAD
     +-	$commit
     +-	EOF
     +-	git pack-objects --incremental --stdout --revs <revs2 >4.pack &&
     +-	git index-pack 4.pack &&
     +-	list_packed_objects 4.idx >4.objects &&
     +-	test_line_count = 4 4.objects &&
     +-	git rev-list --objects $commit >revlist &&
     +-	cut -d" " -f1 revlist |sort >objects &&
     +-	test_cmp 4.objects objects
     +-'
     +-
     +-test_expect_success 'pack with missing blob' '
     +-	rm $(objpath $blob) &&
     +-	git pack-objects --stdout --revs <revs >/dev/null
     +-'
     ++test_bitmap_cases "pack.writeBitmapLookupTable"
     + 
     +-test_expect_success 'pack with missing tree' '
     +-	rm $(objpath $tree) &&
     +-	git pack-objects --stdout --revs <revs >/dev/null
     +-'
     +-
     +-test_expect_success 'pack with missing parent' '
     +-	rm $(objpath $parent) &&
     +-	git pack-objects --stdout --revs <revs >/dev/null
     +-'
     +-
     +-test_expect_success JGIT,SHA1 'we can read jgit bitmaps' '
     +-	git clone --bare . compat-jgit.git &&
     +-	(
     +-		cd compat-jgit.git &&
     +-		rm -f objects/pack/*.bitmap &&
     +-		jgit gc &&
     +-		git rev-list --test-bitmap HEAD
     +-	)
     +-'
     +-
     +-test_expect_success JGIT,SHA1 'jgit can read our bitmaps' '
     +-	git clone --bare . compat-us.git &&
     +-	(
     +-		cd compat-us.git &&
     +-		git repack -adb &&
     +-		# jgit gc will barf if it does not like our bitmaps
     +-		jgit gc
     +-	)
     +-'
     +-
     +-test_expect_success 'splitting packs does not generate bogus bitmaps' '
     +-	test-tool genrandom foo $((1024 * 1024)) >rand &&
     +-	git add rand &&
     +-	git commit -m "commit with big file" &&
     +-	git -c pack.packSizeLimit=500k repack -adb &&
     +-	git init --bare no-bitmaps.git &&
     +-	git -C no-bitmaps.git fetch .. HEAD
     +-'
     +-
     +-test_expect_success 'set up reusable pack' '
     +-	rm -f .git/objects/pack/*.keep &&
     +-	git repack -adb &&
     +-	reusable_pack () {
     +-		git for-each-ref --format="%(objectname)" |
     +-		git pack-objects --delta-base-offset --revs --stdout "$@"
     +-	}
     +-'
     +-
     +-test_expect_success 'pack reuse respects --honor-pack-keep' '
     +-	test_when_finished "rm -f .git/objects/pack/*.keep" &&
     +-	for i in .git/objects/pack/*.pack
     +-	do
     +-		>${i%.pack}.keep || return 1
     +-	done &&
     +-	reusable_pack --honor-pack-keep >empty.pack &&
     +-	git index-pack empty.pack &&
     +-	git show-index <empty.idx >actual &&
     +-	test_must_be_empty actual
     +-'
     +-
     +-test_expect_success 'pack reuse respects --local' '
     +-	mv .git/objects/pack/* alt.git/objects/pack/ &&
     +-	test_when_finished "mv alt.git/objects/pack/* .git/objects/pack/" &&
     +-	reusable_pack --local >empty.pack &&
     +-	git index-pack empty.pack &&
     +-	git show-index <empty.idx >actual &&
     +-	test_must_be_empty actual
     +-'
     +-
     +-test_expect_success 'pack reuse respects --incremental' '
     +-	reusable_pack --incremental >empty.pack &&
     +-	git index-pack empty.pack &&
     +-	git show-index <empty.idx >actual &&
     +-	test_must_be_empty actual
     +-'
     +-
     +-test_expect_success 'truncated bitmap fails gracefully (ewah)' '
     +-	test_config pack.writebitmaphashcache false &&
     +-	git repack -ad &&
     +-	git rev-list --use-bitmap-index --count --all >expect &&
     +-	bitmap=$(ls .git/objects/pack/*.bitmap) &&
     +-	test_when_finished "rm -f $bitmap" &&
     +-	test_copy_bytes 256 <$bitmap >$bitmap.tmp &&
     +-	mv -f $bitmap.tmp $bitmap &&
     +-	git rev-list --use-bitmap-index --count --all >actual 2>stderr &&
     +-	test_cmp expect actual &&
     +-	test_i18ngrep corrupt.ewah.bitmap stderr
     +-'
     +-
     +-test_expect_success 'truncated bitmap fails gracefully (cache)' '
     +-	git repack -ad &&
     +-	git rev-list --use-bitmap-index --count --all >expect &&
     +-	bitmap=$(ls .git/objects/pack/*.bitmap) &&
     +-	test_when_finished "rm -f $bitmap" &&
     +-	test_copy_bytes 512 <$bitmap >$bitmap.tmp &&
     +-	mv -f $bitmap.tmp $bitmap &&
     +-	git rev-list --use-bitmap-index --count --all >actual 2>stderr &&
     +-	test_cmp expect actual &&
     +-	test_i18ngrep corrupted.bitmap.index stderr
     +-'
     +-
     +-# Create a state of history with these properties:
     +-#
     +-#  - refs that allow a client to fetch some new history, while sharing some old
     +-#    history with the server; we use branches delta-reuse-old and
     +-#    delta-reuse-new here
     +-#
     +-#  - the new history contains an object that is stored on the server as a delta
     +-#    against a base that is in the old history
     +-#
     +-#  - the base object is not immediately reachable from the tip of the old
     +-#    history; finding it would involve digging down through history we know the
     +-#    other side has
     +-#
     +-# This should result in a state where fetching from old->new would not
     +-# traditionally reuse the on-disk delta (because we'd have to dig to realize
     +-# that the client has it), but we will do so if bitmaps can tell us cheaply
     +-# that the other side has it.
     +-test_expect_success 'set up thin delta-reuse parent' '
     +-	# This first commit contains the buried base object.
     +-	test-tool genrandom delta 16384 >file &&
     +-	git add file &&
     +-	git commit -m "delta base" &&
     +-	base=$(git rev-parse --verify HEAD:file) &&
     +-
     +-	# These intermediate commits bury the base back in history.
     +-	# This becomes the "old" state.
     +-	for i in 1 2 3 4 5
     +-	do
     +-		echo $i >file &&
     +-		git commit -am "intermediate $i" || return 1
     +-	done &&
     +-	git branch delta-reuse-old &&
     +-
     +-	# And now our new history has a delta against the buried base. Note
     +-	# that this must be smaller than the original file, since pack-objects
     +-	# prefers to create deltas from smaller objects to larger.
     +-	test-tool genrandom delta 16300 >file &&
     +-	git commit -am "delta result" &&
     +-	delta=$(git rev-parse --verify HEAD:file) &&
     +-	git branch delta-reuse-new &&
     +-
     +-	# Repack with bitmaps and double check that we have the expected delta
     +-	# relationship.
     +-	git repack -adb &&
     +-	have_delta $delta $base
     +-'
     +-
     +-# Now we can sanity-check the non-bitmap behavior (that the server is not able
     +-# to reuse the delta). This isn't strictly something we care about, so this
     +-# test could be scrapped in the future. But it makes sure that the next test is
     +-# actually triggering the feature we want.
     +-#
     +-# Note that our tools for working with on-the-wire "thin" packs are limited. So
     +-# we actually perform the fetch, retain the resulting pack, and inspect the
     +-# result.
     +-test_expect_success 'fetch without bitmaps ignores delta against old base' '
     +-	test_config pack.usebitmaps false &&
     +-	test_when_finished "rm -rf client.git" &&
     +-	git init --bare client.git &&
     +-	(
     +-		cd client.git &&
     +-		git config transfer.unpackLimit 1 &&
     +-		git fetch .. delta-reuse-old:delta-reuse-old &&
     +-		git fetch .. delta-reuse-new:delta-reuse-new &&
     +-		have_delta $delta $ZERO_OID
     +-	)
     +-'
     +-
     +-# And do the same for the bitmap case, where we do expect to find the delta.
     +-test_expect_success 'fetch with bitmaps can reuse old base' '
     +-	test_config pack.usebitmaps true &&
     +-	test_when_finished "rm -rf client.git" &&
     +-	git init --bare client.git &&
     +-	(
     +-		cd client.git &&
     +-		git config transfer.unpackLimit 1 &&
     +-		git fetch .. delta-reuse-old:delta-reuse-old &&
     +-		git fetch .. delta-reuse-new:delta-reuse-new &&
     +-		have_delta $delta $base
     +-	)
     +-'
     +-
     +-test_expect_success 'pack.preferBitmapTips' '
     +-	git init repo &&
     +-	test_when_finished "rm -fr repo" &&
     +-	(
     +-		cd repo &&
     +-
     +-		# create enough commits that not all are receive bitmap
     +-		# coverage even if they are all at the tip of some reference.
     +-		test_commit_bulk --message="%s" 103 &&
     +-
     +-		git rev-list HEAD >commits.raw &&
     +-		sort <commits.raw >commits &&
     +-
     +-		git log --format="create refs/tags/%s %H" HEAD >refs &&
     +-		git update-ref --stdin <refs &&
     +-
     +-		git repack -adb &&
     +-		test-tool bitmap list-commits | sort >bitmaps &&
     +-
     +-		# remember which commits did not receive bitmaps
     +-		comm -13 bitmaps commits >before &&
     +-		test_file_not_empty before &&
     +-
     +-		# mark the commits which did not receive bitmaps as preferred,
     +-		# and generate the bitmap again
     +-		perl -pe "s{^}{create refs/tags/include/$. }" <before |
     +-			git update-ref --stdin &&
     +-		git -c pack.preferBitmapTips=refs/tags/include repack -adb &&
     +-
     +-		# finally, check that the commit(s) without bitmap coverage
     +-		# are not the same ones as before
     +-		test-tool bitmap list-commits | sort >bitmaps &&
     +-		comm -13 bitmaps commits >after &&
     +-
     +-		! test_cmp before after
     +-	)
     +-'
     +-
     +-test_expect_success 'complains about multiple pack bitmaps' '
     +-	rm -fr repo &&
     +-	git init repo &&
     +-	test_when_finished "rm -fr repo" &&
     +-	(
     +-		cd repo &&
     +-
     +-		test_commit base &&
     +-
     +-		git repack -adb &&
     +-		bitmap="$(ls .git/objects/pack/pack-*.bitmap)" &&
     +-		mv "$bitmap" "$bitmap.bak" &&
     +-
     +-		test_commit other &&
     +-		git repack -ab &&
     +-
     +-		mv "$bitmap.bak" "$bitmap" &&
     +-
     +-		find .git/objects/pack -type f -name "*.pack" >packs &&
     +-		find .git/objects/pack -type f -name "*.bitmap" >bitmaps &&
     +-		test_line_count = 2 packs &&
     +-		test_line_count = 2 bitmaps &&
     +-
     +-		git rev-list --use-bitmap-index HEAD 2>err &&
     +-		grep "ignoring extra bitmap file" err
     +-	)
     ++test_expect_success 'verify writing bitmap lookup table when enabled' '
     ++	GIT_TRACE2_EVENT="$(pwd)/trace2" \
     ++		git repack -ad &&
     ++	grep "\"label\":\"writing_lookup_table\"" trace2
       '
       
     - basic_bitmap_tests
     + test_done
     +
     + ## t/t5311-pack-bitmaps-shallow.sh ##
     +@@ t/t5311-pack-bitmaps-shallow.sh: test_description='check bitmap operation with shallow repositories'
     + # the tree for A. But in a shallow one, we've grafted away
     + # A, and fetching A to B requires that the other side send
     + # us the tree for file=1.
     +-test_expect_success 'setup shallow repo' '
     +-	echo 1 >file &&
     +-	git add file &&
     +-	git commit -m orig &&
     +-	echo 2 >file &&
     +-	git commit -a -m update &&
     +-	git clone --no-local --bare --depth=1 . shallow.git &&
     +-	echo 1 >file &&
     +-	git commit -a -m repeat
     +-'
     +-
     +-test_expect_success 'turn on bitmaps in the parent' '
     +-	git repack -adb
     +-'
     +-
     +-test_expect_success 'shallow fetch from bitmapped repo' '
     +-	(cd shallow.git && git fetch)
     +-'
     ++test_shallow_bitmaps () {
     ++	writeLookupTable=false
     ++
     ++	for i in "$@"
     ++	do
     ++		case $i in
     ++		"pack.writeBitmapLookupTable") writeLookupTable=true;;
     ++		esac
     ++	done
     ++
     ++	test_expect_success 'setup shallow repo' '
     ++		rm -rf * .git &&
     ++		git init &&
     ++		git config pack.writeBitmapLookupTable '"$writeLookupTable"' &&
     ++		echo 1 >file &&
     ++		git add file &&
     ++		git commit -m orig &&
     ++		echo 2 >file &&
     ++		git commit -a -m update &&
     ++		git clone --no-local --bare --depth=1 . shallow.git &&
     ++		echo 1 >file &&
     ++		git commit -a -m repeat
     ++	'
     ++
     ++	test_expect_success 'turn on bitmaps in the parent' '
     ++		git repack -adb
     ++	'
     ++
     ++	test_expect_success 'shallow fetch from bitmapped repo' '
     ++		(cd shallow.git && git fetch)
     ++	'
     ++}
     ++
     ++test_shallow_bitmaps
     ++
     + 
     + test_done
      
       ## t/t5326-multi-pack-bitmaps.sh ##
     -@@ t/t5326-multi-pack-bitmaps.sh: test_expect_success 'graceful fallback when missing reverse index' '
     - 	)
     - '
     +@@ t/t5326-multi-pack-bitmaps.sh: GIT_TEST_MULTI_PACK_INDEX_WRITE_BITMAP=0
     + sane_unset GIT_TEST_MIDX_WRITE_REV
     + sane_unset GIT_TEST_MIDX_READ_RIDX
       
     +-midx_bitmap_core
     +-
     + bitmap_reuse_tests() {
     + 	from=$1
     + 	to=$2
     ++	writeLookupTable=false
     ++
     ++	for i in $3-${$#}
     ++	do
     ++		case $i in
     ++		"pack.writeBitmapLookupTable") writeLookupTable=true;;
     ++		esac
     ++	done
     + 
     + 	test_expect_success "setup pack reuse tests ($from -> $to)" '
     + 		rm -fr repo &&
     + 		git init repo &&
     + 		(
     + 			cd repo &&
     ++			git config pack.writeBitmapLookupTable '"$writeLookupTable"' &&
     + 			test_commit_bulk 16 &&
     + 			git tag old-tip &&
     + 
     +@@ t/t5326-multi-pack-bitmaps.sh: bitmap_reuse_tests() {
     + 	test_expect_success "build bitmap from existing ($from -> $to)" '
     + 		(
     + 			cd repo &&
     ++			git config pack.writeBitmapLookupTable '"$writeLookupTable"' &&
     + 			test_commit_bulk --id=further 16 &&
     + 			git tag new-tip &&
     + 
     +@@ t/t5326-multi-pack-bitmaps.sh: bitmap_reuse_tests() {
     + 	test_expect_success "verify resulting bitmaps ($from -> $to)" '
     + 		(
     + 			cd repo &&
     ++			git config pack.writeBitmapLookupTable '"$writeLookupTable"' &&
     + 			git for-each-ref &&
     + 			git rev-list --test-bitmap refs/tags/old-tip &&
     + 			git rev-list --test-bitmap refs/tags/new-tip
     +@@ t/t5326-multi-pack-bitmaps.sh: bitmap_reuse_tests() {
     + 	'
     + }
     + 
     +-bitmap_reuse_tests 'pack' 'MIDX'
     +-bitmap_reuse_tests 'MIDX' 'pack'
     +-bitmap_reuse_tests 'MIDX' 'MIDX'
     ++test_midx_bitmap_cases () {
     ++	writeLookupTable=false
     ++	writeBitmapLookupTable=
     ++
     ++	for i in "$@"
     ++	do
     ++		case $i in
     ++		"pack.writeBitmapLookupTable")
     ++			writeLookupTable=true
     ++			writeBitmapLookupTable="$i"
     ++			;;
     ++		esac
     ++	done
     ++
     ++	test_expect_success 'setup test_repository' '
     ++		rm -rf * .git &&
     ++		git init &&
     ++		git config pack.writeBitmapLookupTable '"$writeLookupTable"'
     ++	'
     + 
     +-test_expect_success 'missing object closure fails gracefully' '
     +-	rm -fr repo &&
     +-	git init repo &&
     +-	test_when_finished "rm -fr repo" &&
     +-	(
     +-		cd repo &&
     ++	midx_bitmap_core
     + 
     +-		test_commit loose &&
     +-		test_commit packed &&
     ++	bitmap_reuse_tests 'pack' 'MIDX' "$writeBitmapLookupTable"
     ++	bitmap_reuse_tests 'MIDX' 'pack' "$writeBitmapLookupTable"
     ++	bitmap_reuse_tests 'MIDX' 'MIDX' "$writeBitmapLookupTable"
     + 
     +-		# Do not pass "--revs"; we want a pack without the "loose"
     +-		# commit.
     +-		git pack-objects $objdir/pack/pack <<-EOF &&
     +-		$(git rev-parse packed)
     +-		EOF
     ++	test_expect_success 'missing object closure fails gracefully' '
     ++		rm -fr repo &&
     ++		git init repo &&
     ++		test_when_finished "rm -fr repo" &&
     ++		(
     ++			cd repo &&
     ++			git config pack.writeBitmapLookupTable '"$writeLookupTable"' &&
     + 
     +-		test_must_fail git multi-pack-index write --bitmap 2>err &&
     +-		grep "doesn.t have full closure" err &&
     +-		test_path_is_missing $midx
     +-	)
     +-'
     ++			test_commit loose &&
     ++			test_commit packed &&
     + 
     +-midx_bitmap_partial_tests
     ++			# Do not pass "--revs"; we want a pack without the "loose"
     ++			# commit.
     ++			git pack-objects $objdir/pack/pack <<-EOF &&
     ++			$(git rev-parse packed)
     ++			EOF
     + 
     +-test_expect_success 'removing a MIDX clears stale bitmaps' '
     +-	rm -fr repo &&
     +-	git init repo &&
     +-	test_when_finished "rm -fr repo" &&
     +-	(
     +-		cd repo &&
     +-		test_commit base &&
     +-		git repack &&
     +-		git multi-pack-index write --bitmap &&
     ++			test_must_fail git multi-pack-index write --bitmap 2>err &&
     ++			grep "doesn.t have full closure" err &&
     ++			test_path_is_missing $midx
     ++		)
     ++	'
     + 
     +-		# Write a MIDX and bitmap; remove the MIDX but leave the bitmap.
     +-		stale_bitmap=$midx-$(midx_checksum $objdir).bitmap &&
     +-		rm $midx &&
     ++	midx_bitmap_partial_tests
     + 
     +-		# Then write a new MIDX.
     +-		test_commit new &&
     +-		git repack &&
     +-		git multi-pack-index write --bitmap &&
     ++	test_expect_success 'removing a MIDX clears stale bitmaps' '
     ++		rm -fr repo &&
     ++		git init repo &&
     ++		test_when_finished "rm -fr repo" &&
     ++		(
     ++			cd repo &&
     ++			git config pack.writeBitmapLookupTable '"$writeLookupTable"' &&
     ++			test_commit base &&
     ++			git repack &&
     ++			git multi-pack-index write --bitmap &&
     ++
     ++			# Write a MIDX and bitmap; remove the MIDX but leave the bitmap.
     ++			stale_bitmap=$midx-$(midx_checksum $objdir).bitmap &&
     ++			rm $midx &&
     ++
     ++			# Then write a new MIDX.
     ++			test_commit new &&
     ++			git repack &&
     ++			git multi-pack-index write --bitmap &&
     ++
     ++			test_path_is_file $midx &&
     ++			test_path_is_file $midx-$(midx_checksum $objdir).bitmap &&
     ++			test_path_is_missing $stale_bitmap
     ++		)
     ++	'
     + 
     +-		test_path_is_file $midx &&
     +-		test_path_is_file $midx-$(midx_checksum $objdir).bitmap &&
     +-		test_path_is_missing $stale_bitmap
     +-	)
     +-'
     ++	test_expect_success 'pack.preferBitmapTips' '
     ++		git init repo &&
     ++		test_when_finished "rm -fr repo" &&
     ++		(
     ++			cd repo &&
     ++			git config pack.writeBitmapLookupTable '"$writeLookupTable"' &&
     + 
     +-test_expect_success 'pack.preferBitmapTips' '
     +-	git init repo &&
     +-	test_when_finished "rm -fr repo" &&
     +-	(
     +-		cd repo &&
     ++			test_commit_bulk --message="%s" 103 &&
     + 
     +-		test_commit_bulk --message="%s" 103 &&
     ++			git log --format="%H" >commits.raw &&
     ++			sort <commits.raw >commits &&
     + 
     +-		git log --format="%H" >commits.raw &&
     +-		sort <commits.raw >commits &&
     ++			git log --format="create refs/tags/%s %H" HEAD >refs &&
     ++			git update-ref --stdin <refs &&
     + 
     +-		git log --format="create refs/tags/%s %H" HEAD >refs &&
     +-		git update-ref --stdin <refs &&
     ++			git multi-pack-index write --bitmap &&
     ++			test_path_is_file $midx &&
     ++			test_path_is_file $midx-$(midx_checksum $objdir).bitmap &&
     + 
     +-		git multi-pack-index write --bitmap &&
     +-		test_path_is_file $midx &&
     +-		test_path_is_file $midx-$(midx_checksum $objdir).bitmap &&
     ++			test-tool bitmap list-commits | sort >bitmaps &&
     ++			comm -13 bitmaps commits >before &&
     ++			test_line_count = 1 before &&
     + 
     +-		test-tool bitmap list-commits | sort >bitmaps &&
     +-		comm -13 bitmaps commits >before &&
     +-		test_line_count = 1 before &&
     ++			perl -ne "printf(\"create refs/tags/include/%d \", $.); print" \
     ++				<before | git update-ref --stdin &&
     + 
     +-		perl -ne "printf(\"create refs/tags/include/%d \", $.); print" \
     +-			<before | git update-ref --stdin &&
     ++			rm -fr $midx-$(midx_checksum $objdir).bitmap &&
     ++			rm -fr $midx &&
     + 
     +-		rm -fr $midx-$(midx_checksum $objdir).bitmap &&
     +-		rm -fr $midx &&
     ++			git -c pack.preferBitmapTips=refs/tags/include \
     ++				multi-pack-index write --bitmap &&
     ++			test-tool bitmap list-commits | sort >bitmaps &&
     ++			comm -13 bitmaps commits >after &&
     + 
     +-		git -c pack.preferBitmapTips=refs/tags/include \
     +-			multi-pack-index write --bitmap &&
     +-		test-tool bitmap list-commits | sort >bitmaps &&
     +-		comm -13 bitmaps commits >after &&
     ++			! test_cmp before after
     ++		)
     ++	'
     + 
     +-		! test_cmp before after
     +-	)
     +-'
     ++	test_expect_success 'writing a bitmap with --refs-snapshot' '
     ++		git init repo &&
     ++		test_when_finished "rm -fr repo" &&
     ++		(
     ++			cd repo &&
     ++			git config pack.writeBitmapLookupTable '"$writeLookupTable"' &&
     + 
     +-test_expect_success 'writing a bitmap with --refs-snapshot' '
     +-	git init repo &&
     +-	test_when_finished "rm -fr repo" &&
     +-	(
     +-		cd repo &&
     ++			test_commit one &&
     ++			test_commit two &&
     + 
     +-		test_commit one &&
     +-		test_commit two &&
     ++			git rev-parse one >snapshot &&
     + 
     +-		git rev-parse one >snapshot &&
     ++			git repack -ad &&
     + 
     +-		git repack -ad &&
     ++			# First, write a MIDX which see both refs/tags/one and
     ++			# refs/tags/two (causing both of those commits to receive
     ++			# bitmaps).
     ++			git multi-pack-index write --bitmap &&
     + 
     +-		# First, write a MIDX which see both refs/tags/one and
     +-		# refs/tags/two (causing both of those commits to receive
     +-		# bitmaps).
     +-		git multi-pack-index write --bitmap &&
     ++			test_path_is_file $midx &&
     ++			test_path_is_file $midx-$(midx_checksum $objdir).bitmap &&
     + 
     +-		test_path_is_file $midx &&
     +-		test_path_is_file $midx-$(midx_checksum $objdir).bitmap &&
     ++			test-tool bitmap list-commits | sort >bitmaps &&
     ++			grep "$(git rev-parse one)" bitmaps &&
     ++			grep "$(git rev-parse two)" bitmaps &&
     + 
     +-		test-tool bitmap list-commits | sort >bitmaps &&
     +-		grep "$(git rev-parse one)" bitmaps &&
     +-		grep "$(git rev-parse two)" bitmaps &&
     ++			rm -fr $midx-$(midx_checksum $objdir).bitmap &&
     ++			rm -fr $midx &&
     + 
     +-		rm -fr $midx-$(midx_checksum $objdir).bitmap &&
     +-		rm -fr $midx &&
     ++			# Then again, but with a refs snapshot which only sees
     ++			# refs/tags/one.
     ++			git multi-pack-index write --bitmap --refs-snapshot=snapshot &&
     + 
     +-		# Then again, but with a refs snapshot which only sees
     +-		# refs/tags/one.
     +-		git multi-pack-index write --bitmap --refs-snapshot=snapshot &&
     ++			test_path_is_file $midx &&
     ++			test_path_is_file $midx-$(midx_checksum $objdir).bitmap &&
     + 
     +-		test_path_is_file $midx &&
     +-		test_path_is_file $midx-$(midx_checksum $objdir).bitmap &&
     ++			test-tool bitmap list-commits | sort >bitmaps &&
     ++			grep "$(git rev-parse one)" bitmaps &&
     ++			! grep "$(git rev-parse two)" bitmaps
     ++		)
     ++	'
     + 
     +-		test-tool bitmap list-commits | sort >bitmaps &&
     +-		grep "$(git rev-parse one)" bitmaps &&
     +-		! grep "$(git rev-parse two)" bitmaps
     +-	)
     +-'
     ++	test_expect_success 'write a bitmap with --refs-snapshot (preferred tips)' '
     ++		git init repo &&
     ++		test_when_finished "rm -fr repo" &&
     ++		(
     ++			cd repo &&
     ++			git config pack.writeBitmapLookupTable '"$writeLookupTable"' &&
     + 
     +-test_expect_success 'write a bitmap with --refs-snapshot (preferred tips)' '
     +-	git init repo &&
     +-	test_when_finished "rm -fr repo" &&
     +-	(
     +-		cd repo &&
     ++			test_commit_bulk --message="%s" 103 &&
     + 
     +-		test_commit_bulk --message="%s" 103 &&
     ++			git log --format="%H" >commits.raw &&
     ++			sort <commits.raw >commits &&
     + 
     +-		git log --format="%H" >commits.raw &&
     +-		sort <commits.raw >commits &&
     ++			git log --format="create refs/tags/%s %H" HEAD >refs &&
     ++			git update-ref --stdin <refs &&
     + 
     +-		git log --format="create refs/tags/%s %H" HEAD >refs &&
     +-		git update-ref --stdin <refs &&
     ++			git multi-pack-index write --bitmap &&
     ++			test_path_is_file $midx &&
     ++			test_path_is_file $midx-$(midx_checksum $objdir).bitmap &&
     + 
     +-		git multi-pack-index write --bitmap &&
     +-		test_path_is_file $midx &&
     +-		test_path_is_file $midx-$(midx_checksum $objdir).bitmap &&
     ++			test-tool bitmap list-commits | sort >bitmaps &&
     ++			comm -13 bitmaps commits >before &&
     ++			test_line_count = 1 before &&
     + 
     +-		test-tool bitmap list-commits | sort >bitmaps &&
     +-		comm -13 bitmaps commits >before &&
     +-		test_line_count = 1 before &&
     ++			(
     ++				grep -vf before commits.raw &&
     ++				# mark missing commits as preferred
     ++				sed "s/^/+/" before
     ++			) >snapshot &&
     + 
     ++			rm -fr $midx-$(midx_checksum $objdir).bitmap &&
     ++			rm -fr $midx &&
     ++
     ++			git multi-pack-index write --bitmap --refs-snapshot=snapshot &&
     ++			test-tool bitmap list-commits | sort >bitmaps &&
     ++			comm -13 bitmaps commits >after &&
     ++
     ++			! test_cmp before after
     ++		)
     ++	'
     ++
     ++	test_expect_success 'hash-cache values are propagated from pack bitmaps' '
     ++		rm -fr repo &&
     ++		git init repo &&
     ++		test_when_finished "rm -fr repo" &&
     + 		(
     +-			grep -vf before commits.raw &&
     +-			# mark missing commits as preferred
     +-			sed "s/^/+/" before
     +-		) >snapshot &&
     ++			cd repo &&
     ++			git config pack.writeBitmapLookupTable '"$writeLookupTable"' &&
     + 
     +-		rm -fr $midx-$(midx_checksum $objdir).bitmap &&
     +-		rm -fr $midx &&
     ++			test_commit base &&
     ++			test_commit base2 &&
     ++			git repack -adb &&
     + 
     +-		git multi-pack-index write --bitmap --refs-snapshot=snapshot &&
     +-		test-tool bitmap list-commits | sort >bitmaps &&
     +-		comm -13 bitmaps commits >after &&
     ++			test-tool bitmap dump-hashes >pack.raw &&
     ++			test_file_not_empty pack.raw &&
     ++			sort pack.raw >pack.hashes &&
     + 
     +-		! test_cmp before after
     +-	)
     +-'
     ++			test_commit new &&
     ++			git repack &&
     ++			git multi-pack-index write --bitmap &&
     + 
     +-test_expect_success 'hash-cache values are propagated from pack bitmaps' '
     +-	rm -fr repo &&
     +-	git init repo &&
     +-	test_when_finished "rm -fr repo" &&
     +-	(
     +-		cd repo &&
     ++			test-tool bitmap dump-hashes >midx.raw &&
     ++			sort midx.raw >midx.hashes &&
     + 
     +-		test_commit base &&
     +-		test_commit base2 &&
     +-		git repack -adb &&
     ++			# ensure that every namehash in the pack bitmap can be found in
     ++			# the midx bitmap (i.e., that there are no oid-namehash pairs
     ++			# unique to the pack bitmap).
     ++			comm -23 pack.hashes midx.hashes >dropped.hashes &&
     ++			test_must_be_empty dropped.hashes
     ++		)
     ++	'
     + 
     +-		test-tool bitmap dump-hashes >pack.raw &&
     +-		test_file_not_empty pack.raw &&
     +-		sort pack.raw >pack.hashes &&
     ++	test_expect_success 'no .bitmap is written without any objects' '
     ++		rm -fr repo &&
     ++		git init repo &&
     ++		test_when_finished "rm -fr repo" &&
     ++		(
     ++			cd repo &&
     ++			git config pack.writeBitmapLookupTable '"$writeLookupTable"' &&
     + 
     +-		test_commit new &&
     +-		git repack &&
     +-		git multi-pack-index write --bitmap &&
     ++			empty="$(git pack-objects $objdir/pack/pack </dev/null)" &&
     ++			cat >packs <<-EOF &&
     ++			pack-$empty.idx
     ++			EOF
     + 
     +-		test-tool bitmap dump-hashes >midx.raw &&
     +-		sort midx.raw >midx.hashes &&
     ++			git multi-pack-index write --bitmap --stdin-packs \
     ++				<packs 2>err &&
     + 
     +-		# ensure that every namehash in the pack bitmap can be found in
     +-		# the midx bitmap (i.e., that there are no oid-namehash pairs
     +-		# unique to the pack bitmap).
     +-		comm -23 pack.hashes midx.hashes >dropped.hashes &&
     +-		test_must_be_empty dropped.hashes
     +-	)
     +-'
     ++			grep "bitmap without any objects" err &&
     + 
     +-test_expect_success 'no .bitmap is written without any objects' '
     +-	rm -fr repo &&
     +-	git init repo &&
     +-	test_when_finished "rm -fr repo" &&
     +-	(
     +-		cd repo &&
     ++			test_path_is_file $midx &&
     ++			test_path_is_missing $midx-$(midx_checksum $objdir).bitmap
     ++		)
     ++	'
     ++
     ++	test_expect_success 'graceful fallback when missing reverse index' '
     ++		rm -fr repo &&
     ++		git init repo &&
     ++		test_when_finished "rm -fr repo" &&
     ++		(
     ++			cd repo &&
     ++			git config pack.writeBitmapLookupTable '"$writeLookupTable"' &&
     + 
     +-		empty="$(git pack-objects $objdir/pack/pack </dev/null)" &&
     +-		cat >packs <<-EOF &&
     +-		pack-$empty.idx
     +-		EOF
     ++			test_commit base &&
     + 
     +-		git multi-pack-index write --bitmap --stdin-packs \
     +-			<packs 2>err &&
     ++			# write a pack and MIDX bitmap containing base
     ++			git repack -adb &&
     ++			git multi-pack-index write --bitmap &&
     + 
     +-		grep "bitmap without any objects" err &&
     ++			GIT_TEST_MIDX_READ_RIDX=0 \
     ++				git rev-list --use-bitmap-index HEAD 2>err &&
     ++			! grep "ignoring extra bitmap file" err
     ++		)
     ++	'
     ++}
     + 
     +-		test_path_is_file $midx &&
     +-		test_path_is_missing $midx-$(midx_checksum $objdir).bitmap
     +-	)
     +-'
     ++test_midx_bitmap_cases
     ++
     ++test_midx_bitmap_cases "pack.writeBitmapLookupTable"
     + 
     +-test_expect_success 'graceful fallback when missing reverse index' '
      +test_expect_success 'multi-pack-index write writes lookup table if enabled' '
     -+	rm -fr repo &&
     -+	git init repo &&
     -+	test_when_finished "rm -fr repo" &&
     -+	(
     -+		cd repo &&
     -+		test_commit base &&
     + 	rm -fr repo &&
     + 	git init repo &&
     + 	test_when_finished "rm -fr repo" &&
     + 	(
     + 		cd repo &&
     +-
     + 		test_commit base &&
     +-
     +-		# write a pack and MIDX bitmap containing base
     +-		git repack -adb &&
     +-		git multi-pack-index write --bitmap &&
     +-
     +-		GIT_TEST_MIDX_READ_RIDX=0 \
     +-			git rev-list --use-bitmap-index HEAD 2>err &&
     +-		! grep "ignoring extra bitmap file" err
     ++		git config pack.writeBitmapLookupTable true &&
      +		git repack -ad &&
      +		GIT_TRACE2_EVENT="$(pwd)/trace" \
      +			git multi-pack-index write --bitmap &&
      +		grep "\"label\":\"writing_lookup_table\"" trace
     -+	)
     + 	)
     + '
     + 
     +
     + ## t/t5327-multi-pack-bitmaps-rev.sh ##
     +@@ t/t5327-multi-pack-bitmaps-rev.sh: export GIT_TEST_MIDX_READ_RIDX
     + midx_bitmap_core rev
     + midx_bitmap_partial_tests rev
     + 
     ++test_expect_success 'reinitialize the repository with lookup table enabled' '
     ++    rm -fr * .git &&
     ++    git init &&
     ++    git config pack.writeBitmapLookupTable true
      +'
     ++
     ++midx_bitmap_core rev
     ++midx_bitmap_partial_tests rev
     ++
       test_done
 4:  4fbfcff8a20 ! 4:  e64362621d2 pack-bitmap: prepare to read lookup table extension
     @@ Commit message
          does not know how to parse them.
      
          Teach Git to parse the existing bitmap lookup table. The older
     -    versions of git are not affected by it. Those versions ignore the
     +    versions of Git are not affected by it. Those versions ignore the
          lookup table.
      
     -    Signed-off-by: Abhradeep Chakraborty <chakrabortyabhradeep79@gmail.com>
          Mentored-by: Taylor Blau <me@ttaylorr.com>
          Co-Mentored-by: Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
     +    Signed-off-by: Abhradeep Chakraborty <chakrabortyabhradeep79@gmail.com>
      
       ## pack-bitmap.c ##
      @@ pack-bitmap.c: struct bitmap_index {
     @@ pack-bitmap.c: struct bitmap_index {
       
      +	/*
      +	 * If not NULL, this point into the commit table extension
     -+	 * (within map).
     ++	 * (within the memory mapped region `map`).
      +	 */
      +	unsigned char *table_lookup;
      +
     @@ pack-bitmap.c: static int load_bitmap_header(struct bitmap_index *index)
       			index_end -= cache_size;
       		}
      +
     -+		if (flags & BITMAP_OPT_LOOKUP_TABLE &&
     -+			git_env_bool("GIT_TEST_READ_COMMIT_TABLE", 1)) {
     -+			size_t table_size = 0;
     -+			size_t triplet_sz = st_add3(sizeof(uint32_t),    /* commit position */
     -+							sizeof(uint64_t),    /* offset */
     -+							sizeof(uint32_t));    /* xor offset */
     -+
     -+			table_size = st_add(table_size,
     -+					st_mult(ntohl(header->entry_count),
     -+						triplet_sz));
     ++		if (flags & BITMAP_OPT_LOOKUP_TABLE) {
     ++			size_t table_size = st_mult(ntohl(header->entry_count),
     ++						    BITMAP_LOOKUP_TABLE_TRIPLET_WIDTH);
      +			if (table_size > index_end - index->map - header_size)
     -+				return error("corrupted bitmap index file (too short to fit lookup table)");
     -+			index->table_lookup = (void *)(index_end - table_size);
     ++				return error(_("corrupted bitmap index file (too short to fit lookup table)"));
     ++			if (git_env_bool("GIT_TEST_READ_COMMIT_TABLE", 1))
     ++				index->table_lookup = (void *)(index_end - table_size);
      +			index_end -= table_size;
      +		}
       	}
     @@ pack-bitmap.c: static struct stored_bitmap *store_bitmap(struct bitmap_index *in
      -	/* a 0 return code means the insertion succeeded with no changes,
      -	 * because the SHA1 already existed on the map. this is bad, there
      -	 * shouldn't be duplicated commits in the index */
     -+	/* A 0 return code means the insertion succeeded with no changes,
     -+	 * because the SHA1 already existed on the map. If lookup table
     -+	 * is NULL, this is bad, there shouldn't be duplicated commits
     -+	 * in the index.
     -+	 *
     -+	 * If table_lookup exists, that means the desired bitmap is already
     -+	 * loaded. Either this bitmap has been stored directly or another
     -+	 * bitmap has a direct or indirect xor relation with it. */
     ++	/*
     ++	 * A 0 return code means the insertion succeeded with no changes,
     ++	 * because the SHA1 already existed on the map. This is bad, there
     ++	 * shouldn't be duplicated commits in the index.
     ++	 */
       	if (ret == 0) {
      -		error("Duplicate entry in bitmap index: %s", oid_to_hex(oid));
     --		return NULL;
     -+		if (!index->table_lookup) {
     -+			error("Duplicate entry in bitmap index: %s", oid_to_hex(oid));
     -+			return NULL;
     -+		}
     -+		return kh_value(index->bitmaps, hash_pos);
     ++		error(_("duplicate entry in bitmap index: %s"), oid_to_hex(oid));
     + 		return NULL;
       	}
       
     - 	kh_value(index->bitmaps, hash_pos) = stored;
      @@ pack-bitmap.c: static int load_bitmap(struct bitmap_index *bitmap_git)
       		!(bitmap_git->tags = read_bitmap_1(bitmap_git)))
       		goto failed;
     @@ pack-bitmap.c: struct include_data {
       	struct bitmap *seen;
       };
       
     -+static inline const void *bitmap_get_triplet(struct bitmap_index *bitmap_git, uint32_t xor_pos)
     -+{
     -+	size_t triplet_sz = st_add3(sizeof(uint32_t), sizeof(uint64_t), sizeof(uint32_t));
     -+	const void *p = bitmap_git->table_lookup + st_mult(xor_pos, triplet_sz);
     -+	return p;
     -+}
     -+
     -+static uint64_t triplet_get_offset(const void *triplet)
     -+{
     -+	const void *p = (unsigned char*) triplet + sizeof(uint32_t);
     -+	return get_be64(p);
     -+}
     ++struct bitmap_lookup_table_triplet {
     ++	uint32_t commit_pos;
     ++	uint64_t offset;
     ++	uint32_t xor_row;
     ++};
      +
     -+static uint32_t triplet_get_xor_pos(const void *triplet)
     ++struct bitmap_lookup_table_xor_item {
     ++	struct object_id oid;
     ++	uint64_t offset;
     ++};
     ++
     ++/*
     ++ * This function gets the raw triplet from `row`'th row in the
     ++ * lookup table and fills that data to the `triplet`.
     ++ */
     ++static int lookup_table_get_triplet(struct bitmap_index *bitmap_git,
     ++				    uint32_t pos,
     ++				    struct bitmap_lookup_table_triplet *triplet)
      +{
     -+	const void *p = (unsigned char*) triplet + st_add(sizeof(uint32_t), sizeof(uint64_t));
     -+	return get_be32(p);
     ++	unsigned char *p = NULL;
     ++	if (pos >= bitmap_git->entry_count)
     ++		return error(_("corrupt bitmap lookup table: triplet position out of index"));
     ++
     ++	p = bitmap_git->table_lookup + st_mult(pos, BITMAP_LOOKUP_TABLE_TRIPLET_WIDTH);
     ++
     ++	triplet->commit_pos = get_be32(p);
     ++	p += sizeof(uint32_t);
     ++	triplet->offset = get_be64(p);
     ++	p += sizeof(uint64_t);
     ++	triplet->xor_row = get_be32(p);
     ++	return 0;
      +}
      +
     ++/*
     ++ * Searches for a matching triplet. `va` is a pointer
     ++ * to the wanted commit position value. `vb` points to
     ++ * a triplet in lookup table. The first 4 bytes of each
     ++ * triplet (pointed by `vb`) are compared with `*va`.
     ++ */
      +static int triplet_cmp(const void *va, const void *vb)
      +{
     -+	int result = 0;
     -+	uint32_t *a = (uint32_t *) va;
     ++
     ++	uint32_t a = *(uint32_t *)va;
      +	uint32_t b = get_be32(vb);
     -+	if (*a > b)
     -+		result = 1;
     -+	else if (*a < b)
     -+		result = -1;
     -+	else
     -+		result = 0;
     ++	if (a > b)
     ++		return 1;
     ++	else if (a < b)
     ++		return -1;
      +
     -+	return result;
     ++	return 0;
      +}
      +
     -+static uint32_t bsearch_pos(struct bitmap_index *bitmap_git, struct object_id *oid,
     -+						uint32_t *result)
     ++static uint32_t bsearch_pos(struct bitmap_index *bitmap_git,
     ++			    struct object_id *oid,
     ++			    uint32_t *result)
      +{
      +	int found;
      +
     -+	if (bitmap_git->midx)
     ++	if (bitmap_is_midx(bitmap_git))
      +		found = bsearch_midx(oid, bitmap_git->midx, result);
      +	else
      +		found = bsearch_pack(oid, bitmap_git->pack, result);
     @@ pack-bitmap.c: struct include_data {
      +	return found;
      +}
      +
     ++/*
     ++ * `bsearch_triplet` function searches for the raw triplet having
     ++ * commit position same as `commit_pos` and fills `triplet`
     ++ * object from the raw triplet. Returns 1 on success and 0
     ++ * on failure.
     ++ */
     ++static int bsearch_triplet(uint32_t *commit_pos,
     ++			   struct bitmap_index *bitmap_git,
     ++			   struct bitmap_lookup_table_triplet *triplet)
     ++{
     ++	unsigned char *p = bsearch(commit_pos, bitmap_git->table_lookup, bitmap_git->entry_count,
     ++				   BITMAP_LOOKUP_TABLE_TRIPLET_WIDTH, triplet_cmp);
     ++
     ++	if (!p)
     ++		return 0;
     ++	triplet->commit_pos = get_be32(p);
     ++	p += sizeof(uint32_t);
     ++	triplet->offset = get_be64(p);
     ++	p += sizeof(uint64_t);
     ++	triplet->xor_row = get_be32(p);
     ++	return 1;
     ++}
     ++
      +static struct stored_bitmap *lazy_bitmap_for_commit(struct bitmap_index *bitmap_git,
      +					  struct commit *commit)
      +{
     -+	uint32_t commit_pos, xor_pos;
     ++	uint32_t commit_pos, xor_row;
      +	uint64_t offset;
      +	int flags;
     -+	const void *triplet = NULL;
     ++	struct bitmap_lookup_table_triplet triplet;
      +	struct object_id *oid = &commit->object.oid;
      +	struct ewah_bitmap *bitmap;
      +	struct stored_bitmap *xor_bitmap = NULL;
     -+	size_t triplet_sz = st_add3(sizeof(uint32_t), sizeof(uint64_t), sizeof(uint32_t));
      +
      +	int found = bsearch_pos(bitmap_git, oid, &commit_pos);
      +
      +	if (!found)
      +		return NULL;
      +
     -+	triplet = bsearch(&commit_pos, bitmap_git->table_lookup, bitmap_git->entry_count,
     -+						triplet_sz, triplet_cmp);
     -+	if (!triplet)
     ++	if (!bsearch_triplet(&commit_pos, bitmap_git, &triplet))
      +		return NULL;
      +
     -+	offset = triplet_get_offset(triplet);
     -+	xor_pos = triplet_get_xor_pos(triplet);
     ++	offset = triplet.offset;
     ++	xor_row = triplet.xor_row;
      +
     -+	if (xor_pos != 0xffffffff) {
     ++	if (xor_row != 0xffffffff) {
      +		int xor_flags;
     ++		khiter_t hash_pos;
      +		uint64_t offset_xor;
     -+		uint32_t *xor_positions;
     -+		struct object_id xor_oid;
     -+		size_t size = 0;
     -+
     -+		ALLOC_ARRAY(xor_positions, bitmap_git->entry_count);
     -+		while (xor_pos != 0xffffffff) {
     -+			xor_positions[size++] = xor_pos;
     -+			triplet = bitmap_get_triplet(bitmap_git, xor_pos);
     -+			xor_pos = triplet_get_xor_pos(triplet);
     ++		struct bitmap_lookup_table_xor_item *xor_items;
     ++		struct bitmap_lookup_table_xor_item xor_item;
     ++		size_t xor_items_nr = 0, xor_items_alloc = 64;
     ++
     ++		ALLOC_ARRAY(xor_items, xor_items_alloc);
     ++		while (xor_row != 0xffffffff) {
     ++			struct object_id xor_oid;
     ++
     ++			if (xor_items_nr + 1 >= bitmap_git->entry_count) {
     ++				free(xor_items);
     ++				error(_("corrupt bitmap lookup table: xor chain exceed entry count"));
     ++				return NULL;
     ++			}
     ++
     ++			if (lookup_table_get_triplet(bitmap_git, xor_row, &triplet) < 0)
     ++				return NULL;
     ++
     ++			offset_xor = triplet.offset;
     ++
     ++			if (nth_bitmap_object_oid(bitmap_git, &xor_oid, triplet.commit_pos) < 0) {
     ++				free(xor_items);
     ++				error(_("corrupt bitmap lookup table: commit index %u out of range"),
     ++					triplet.commit_pos);
     ++				return NULL;
     ++			}
     ++
     ++			hash_pos = kh_get_oid_map(bitmap_git->bitmaps, xor_oid);
     ++
     ++			/*
     ++			 * If desired bitmap is already stored, we don't need
     ++			 * to iterate further. Because we know that bitmaps
     ++			 * that are needed to be parsed to parse this bitmap
     ++			 * has already been stored. So, assign this stored bitmap
     ++			 * to the xor_bitmap.
     ++			 */
     ++			if (hash_pos < kh_end(bitmap_git->bitmaps) &&
     ++			    (xor_bitmap = kh_value(bitmap_git->bitmaps, hash_pos)))
     ++				break;
     ++
     ++			ALLOC_GROW(xor_items, xor_items_nr + 1, xor_items_alloc);
     ++			xor_items[xor_items_nr++] = (struct bitmap_lookup_table_xor_item) {.oid = xor_oid,
     ++											   .offset = offset_xor};
     ++			xor_row = triplet.xor_row;
      +		}
      +
     -+		while (size){
     -+			xor_pos = xor_positions[size - 1];
     -+			triplet = bitmap_get_triplet(bitmap_git, xor_pos);
     -+			commit_pos = get_be32(triplet);
     -+			offset_xor = triplet_get_offset(triplet);
     ++		while (xor_items_nr) {
     ++			xor_item = xor_items[xor_items_nr - 1];
     ++			offset_xor = xor_item.offset;
      +
     -+			if (nth_bitmap_object_oid(bitmap_git, &xor_oid, commit_pos) < 0) {
     -+				free(xor_positions);
     ++			bitmap_git->map_pos = offset_xor;
     ++			if (bitmap_git->map_size - bitmap_git->map_pos < 6) {
     ++				error(_("corrupt ewah bitmap: truncated header for bitmap of commit \"%s\""),
     ++					oid_to_hex(&xor_item.oid));
     ++				free(xor_items);
      +				return NULL;
      +			}
      +
     -+			bitmap_git->map_pos = offset_xor + sizeof(uint32_t) + sizeof(uint8_t);
     ++			bitmap_git->map_pos = bitmap_git->map_pos + sizeof(uint32_t) + sizeof(uint8_t);
      +			xor_flags = read_u8(bitmap_git->map, &bitmap_git->map_pos);
      +			bitmap = read_bitmap_1(bitmap_git);
      +
     -+			if (!bitmap){
     -+				free(xor_positions);
     ++			if (!bitmap) {
     ++				free(xor_items);
      +				return NULL;
      +			}
      +
     -+			xor_bitmap = store_bitmap(bitmap_git, bitmap, &xor_oid, xor_bitmap, xor_flags);
     -+			size--;
     ++			xor_bitmap = store_bitmap(bitmap_git, bitmap, &xor_item.oid, xor_bitmap, xor_flags);
     ++			xor_items_nr--;
      +		}
      +
     -+		free(xor_positions);
     ++		free(xor_items);
      +	}
      +
     -+	bitmap_git->map_pos = offset + sizeof(uint32_t) + sizeof(uint8_t);
     ++	bitmap_git->map_pos = offset;
     ++	if (bitmap_git->map_size - bitmap_git->map_pos < 6) {
     ++		error(_("corrupt ewah bitmap: truncated header for bitmap of commit \"%s\""),
     ++			oid_to_hex(oid));
     ++		return NULL;
     ++	}
     ++
     ++	bitmap_git->map_pos = bitmap_git->map_pos + sizeof(uint32_t) + sizeof(uint8_t);
      +	flags = read_u8(bitmap_git->map, &bitmap_git->map_pos);
      +	bitmap = read_bitmap_1(bitmap_git);
      +
     @@ pack-bitmap.c: struct include_data {
      +		if (!bitmap_git->table_lookup)
      +			return NULL;
      +
     ++		trace2_region_enter("pack-bitmap", "reading_lookup_table", the_repository);
      +		/* NEEDSWORK: cache misses aren't recorded */
      +		bitmap = lazy_bitmap_for_commit(bitmap_git, commit);
     -+		if(!bitmap)
     ++		trace2_region_leave("pack-bitmap", "reading_lookup_table", the_repository);
     ++		if (!bitmap)
      +			return NULL;
      +		return lookup_stored_bitmap(bitmap);
      +	}
     @@ pack-bitmap.c: void test_bitmap_walk(struct rev_info *revs)
       		die("you must specify exactly one commit to test");
       
      -	fprintf(stderr, "Bitmap v%d test (%d entries loaded)\n",
     -+	fprintf(stderr, "Bitmap v%d test (%d entries)\n",
     - 		bitmap_git->version, bitmap_git->entry_count);
     +-		bitmap_git->version, bitmap_git->entry_count);
     ++	fprintf(stderr, "Bitmap v%d test (%d entries%s)",
     ++		bitmap_git->version,
     ++		bitmap_git->entry_count,
     ++		bitmap_git->table_lookup ? "" : " loaded");
       
     -+	if (!bitmap_git->table_lookup)
     -+		fprintf(stderr, "Bitmap v%d test (%d entries loaded)\n",
     -+			bitmap_git->version, bitmap_git->entry_count);
     -+
       	root = revs->pending.objects[0].item;
       	bm = bitmap_for_commit(bitmap_git, (struct commit *)root);
     - 
      @@ pack-bitmap.c: void test_bitmap_walk(struct rev_info *revs)
       
       int test_bitmap_commits(struct repository *r)
       {
      -	struct bitmap_index *bitmap_git = prepare_bitmap_git(r);
     -+	struct bitmap_index *bitmap_git = NULL;
       	struct object_id oid;
       	MAYBE_UNUSED void *value;
     - 
     -+	/* As this function is only used to print bitmap selected
     ++	struct bitmap_index *bitmap_git = prepare_bitmap_git(r);
     ++
     ++	/*
     ++	 * As this function is only used to print bitmap selected
      +	 * commits, we don't have to read the commit table.
      +	 */
     -+	setenv("GIT_TEST_READ_COMMIT_TABLE", "0", 1);
     -+
     -+	bitmap_git = prepare_bitmap_git(r);
     + 
       	if (!bitmap_git)
       		die("failed to load bitmap indexes");
       
     -@@ pack-bitmap.c: int test_bitmap_commits(struct repository *r)
     ++	if (bitmap_git->table_lookup) {
     ++		if (load_bitmap_entries_v1(bitmap_git) < 0)
     ++			die(_("failed to load bitmap indexes"));
     ++	}
     ++
     + 	kh_foreach(bitmap_git->bitmaps, oid, value, {
       		printf("%s\n", oid_to_hex(&oid));
       	});
     +
     + ## pack-bitmap.h ##
     +@@ pack-bitmap.h: struct bitmap_disk_header {
       
     -+	setenv("GIT_TEST_READ_COMMIT_TABLE", "1", 1);
     - 	free_bitmap_index(bitmap_git);
     + #define NEEDS_BITMAP (1u<<22)
       
     - 	return 0;
     ++/*
     ++ * The width in bytes of a single triplet in the lookup table
     ++ * extension:
     ++ *     (commit_pos, offset, xor_row)
     ++ *
     ++ * whose fields ar 32-, 64-, 32- bits wide, respectively.
     ++ */
     ++#define BITMAP_LOOKUP_TABLE_TRIPLET_WIDTH (16)
     ++
     + enum pack_bitmap_opts {
     + 	BITMAP_OPT_FULL_DAG = 0x1,
     + 	BITMAP_OPT_HASH_CACHE = 0x4,
      
       ## t/t5310-pack-bitmaps.sh ##
     -@@ t/t5310-pack-bitmaps.sh: test_expect_success 'full repack creates bitmaps' '
     - 	grep "\"label\":\"writing_lookup_table\"" trace
     +@@ t/t5310-pack-bitmaps.sh: test_bitmap_cases () {
     + 
     + 	test_expect_success 'truncated bitmap fails gracefully (ewah)' '
     + 		test_config pack.writebitmaphashcache false &&
     ++		test_config pack.writebitmaplookuptable false &&
     + 		git repack -ad &&
     + 		git rev-list --use-bitmap-index --count --all >expect &&
     + 		bitmap=$(ls .git/objects/pack/*.bitmap) &&
     +@@ t/t5310-pack-bitmaps.sh: test_bitmap_cases () {
     + 	'
     + 
     + 	test_expect_success 'truncated bitmap fails gracefully (cache)' '
     ++		git config pack.writeBitmapLookupTable '"$writeLookupTable"' &&
     + 		git repack -ad &&
     + 		git rev-list --use-bitmap-index --count --all >expect &&
     + 		bitmap=$(ls .git/objects/pack/*.bitmap) &&
     +@@ t/t5310-pack-bitmaps.sh: test_expect_success 'verify writing bitmap lookup table when enabled' '
     + 	grep "\"label\":\"writing_lookup_table\"" trace2
       '
       
     -+test_expect_success 'using lookup table loads only necessary bitmaps' '
     -+	git rev-list --test-bitmap HEAD 2>out &&
     -+	! grep "Bitmap v1 test (106 entries loaded)" out &&
     -+	grep "Found bitmap for" out
     ++test_expect_success 'lookup table is actually used to traverse objects' '
     ++	git repack -adb &&
     ++	GIT_TRACE2_EVENT="$(pwd)/trace3" \
     ++		git rev-list --use-bitmap-index --count --all &&
     ++	grep "\"label\":\"reading_lookup_table\"" trace3
      +'
      +
     - basic_bitmap_tests
     - 
     - test_expect_success 'incremental repack fails when bitmaps are requested' '
     -@@ t/t5310-pack-bitmaps.sh: test_expect_success 'pack reuse respects --incremental' '
     - 
     - test_expect_success 'truncated bitmap fails gracefully (ewah)' '
     - 	test_config pack.writebitmaphashcache false &&
     -+	test_config pack.writebitmaplookuptable false &&
     - 	git repack -ad &&
     - 	git rev-list --use-bitmap-index --count --all >expect &&
     - 	bitmap=$(ls .git/objects/pack/*.bitmap) &&
     -
     - ## t/t5326-multi-pack-bitmaps.sh ##
     -@@ t/t5326-multi-pack-bitmaps.sh: test_expect_success 'multi-pack-index write writes lookup table if enabled' '
     - 		grep "\"label\":\"writing_lookup_table\"" trace
     - 	)
     - '
     ++test_expect_success 'truncated bitmap fails gracefully (lookup table)' '
     ++	test_config pack.writebitmaphashcache false &&
     ++	git repack -adb &&
     ++	git rev-list --use-bitmap-index --count --all >expect &&
     ++	bitmap=$(ls .git/objects/pack/*.bitmap) &&
     ++	test_when_finished "rm -f $bitmap" &&
     ++	test_copy_bytes 512 <$bitmap >$bitmap.tmp &&
     ++	mv -f $bitmap.tmp $bitmap &&
     ++	git rev-list --use-bitmap-index --count --all >actual 2>stderr &&
     ++	test_cmp expect actual &&
     ++	test_i18ngrep corrupted.bitmap.index stderr
     ++'
      +
       test_done
 5:  96c0041688f ! 5:  a155c1e2eba bitmap-lookup-table: add performance tests for lookup table
     @@ Metadata
       ## Commit message ##
          bitmap-lookup-table: add performance tests for lookup table
      
     -    Add performance tests to verify the performance of lookup table.
     +    Add performance tests to verify the performance of lookup table with
     +    `pack.writeReverseIndex` enabled. This is to check the performance
     +    when the above configuration is set.
      
          Lookup table makes Git run faster in most of the cases. Below is the
          result of `t/perf/p5310-pack-bitmaps.sh`.`perf/p5326-multi-pack-bitmaps.sh`
          gives similar result. The repository used in the test is linux kernel.
      
          Test                                                      this tree
     -    --------------------------------------------------------------------------
     -    5310.4: repack to disk (lookup=false)                   295.94(250.45+15.24)
     -    5310.5: simulated clone                                 12.52(5.07+1.40)
     -    5310.6: simulated fetch                                 1.89(2.94+0.24)
     -    5310.7: pack to file (bitmap)                           41.39(20.33+7.20)
     -    5310.8: rev-list (commits)                              0.98(0.59+0.12)
     -    5310.9: rev-list (objects)                              3.40(3.27+0.10)
     +    ---------------------------------------------------------------------------
     +    5310.4: repack to disk (lookup=false)                   296.55(256.53+14.52)
     +    5310.5: simulated clone                                 15.64(8.88+1.39)
     +    5310.6: simulated fetch                                 1.65(2.75+0.20)
     +    5310.7: pack to file (bitmap)                           48.71(30.20+7.58)
     +    5310.8: rev-list (commits)                              0.61(0.41+0.08)
     +    5310.9: rev-list (objects)                              4.38(4.26+0.09)
          5310.10: rev-list with tag negated via --not            0.07(0.02+0.04)
                   --all (objects)
     -    5310.11: rev-list with negative tag (objects)           0.23(0.16+0.06)
     -    5310.12: rev-list count with blob:none                  0.26(0.18+0.07)
     -    5310.13: rev-list count with blob:limit=1k              6.45(5.94+0.37)
     -    5310.14: rev-list count with tree:0                     0.26(0.18+0.07)
     -    5310.15: simulated partial clone                        4.99(3.19+0.45)
     -    5310.19: repack to disk (lookup=true)                   269.67(174.70+21.33)
     -    5310.20: simulated clone                                11.03(5.07+1.11)
     -    5310.21: simulated fetch                                0.79(0.79+0.17)
     -    5310.22: pack to file (bitmap)                          43.03(20.28+7.43)
     -    5310.23: rev-list (commits)                             0.86(0.54+0.09)
     -    5310.24: rev-list (objects)                             3.35(3.26+0.07)
     -    5310.25: rev-list with tag negated via --not            0.05(0.00+0.03)
     +    5310.11: rev-list with negative tag (objects)           0.05(0.01+0.03)
     +    5310.12: rev-list count with blob:none                  0.08(0.03+0.04)
     +    5310.13: rev-list count with blob:limit=1k              7.29(6.92+0.30)
     +    5310.14: rev-list count with tree:0                     0.08(0.03+0.04)
     +    5310.15: simulated partial clone                        9.45(8.12+0.41)
     +    5310.19: repack to disk (lookup=true)                   255.92(188.13+20.47)
     +    5310.20: simulated clone                                13.78(8.84+1.09)
     +    5310.21: simulated fetch                                0.52(0.63+0.14)
     +    5310.22: pack to file (bitmap)                          44.34(28.94+6.84)
     +    5310.23: rev-list (commits)                             0.48(0.31+0.06)
     +    5310.24: rev-list (objects)                             4.02(3.93+0.07)
     +    5310.25: rev-list with tag negated via --not            0.04(0.00+0.03)
                   --all (objects)
     -    5310.26: rev-list with negative tag (objects)           0.22(0.16+0.05)
     -    5310.27: rev-list count with blob:none                  0.22(0.16+0.05)
     -    5310.28: rev-list count with blob:limit=1k              6.45(5.87+0.31)
     -    5310.29: rev-list count with tree:0                     0.22(0.16+0.05)
     -    5310.30: simulated partial clone                        5.17(3.12+0.48)
     +    5310.26: rev-list with negative tag (objects)           0.04(0.00+0.03)
     +    5310.27: rev-list count with blob:none                  0.04(0.01+0.03)
     +    5310.28: rev-list count with blob:limit=1k              6.48(6.23+0.22)
     +    5310.29: rev-list count with tree:0                     0.04(0.01+0.03)
     +    5310.30: simulated partial clone                        8.30(7.21+0.36)
      
          Test 4-15 are tested without using lookup table. Same tests are
          repeated in 16-30 (using lookup table).
      
     -    Signed-off-by: Abhradeep Chakraborty <chakrabortyabhradeep79@gmail.com>
          Mentored-by: Taylor Blau <me@ttaylorr.com>
          Co-Mentored-by: Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
     +    Signed-off-by: Abhradeep Chakraborty <chakrabortyabhradeep79@gmail.com>
      
       ## t/perf/p5310-pack-bitmaps.sh ##
     -@@ t/perf/p5310-pack-bitmaps.sh: test_expect_success 'setup bitmap config' '
     - 	git config pack.writebitmaps true
     +@@ t/perf/p5310-pack-bitmaps.sh: test_perf_large_repo
     + # We intentionally use the deprecated pack.writebitmaps
     + # config so that we can test against older versions of git.
     + test_expect_success 'setup bitmap config' '
     +-	git config pack.writebitmaps true
     ++	git config pack.writebitmaps true &&
     ++	git config pack.writeReverseIndex true
       '
       
      -# we need to create the tag up front such that it is covered by the repack and
     @@ t/perf/p5310-pack-bitmaps.sh: test_expect_success 'setup bitmap config' '
      -test_expect_success 'create tags' '
      -	git tag --message="tag pointing to HEAD" perf-tag HEAD
      -'
     --
     ++test_bitmap () {
     ++	local enabled="$1"
     + 
      -test_perf 'repack to disk' '
      -	git repack -ad
      -'
     --
     ++	# we need to create the tag up front such that it is covered by the repack and
     ++	# thus by generated bitmaps.
     ++	test_expect_success 'create tags' '
     ++		git tag --message="tag pointing to HEAD" perf-tag HEAD
     ++	'
     + 
      -test_full_bitmap
     --
     ++	test_expect_success "use lookup table: $enabled" '
     ++		git config pack.writeBitmapLookupTable '"$enabled"'
     ++	'
     + 
      -test_expect_success 'create partial bitmap state' '
      -	# pick a commit to represent the repo tip in the past
      -	cutoff=$(git rev-list HEAD~100 -1) &&
      -	orig_tip=$(git rev-parse HEAD) &&
     --
     ++	test_perf "repack to disk (lookup=$enabled)" '
     ++		git repack -ad
     ++	'
     + 
      -	# now kill off all of the refs and pretend we had
      -	# just the one tip
      -	rm -rf .git/logs .git/refs/* .git/packed-refs &&
      -	git update-ref HEAD $cutoff &&
     --
     ++	test_full_bitmap
     + 
      -	# and then repack, which will leave us with a nice
      -	# big bitmap pack of the "old" history, and all of
      -	# the new history will be loose, as if it had been pushed
      -	# up incrementally and exploded via unpack-objects
      -	git repack -Ad &&
     --
     ++	test_expect_success "create partial bitmap state (lookup=$enabled)" '
     ++		# pick a commit to represent the repo tip in the past
     ++		cutoff=$(git rev-list HEAD~100 -1) &&
     ++		orig_tip=$(git rev-parse HEAD) &&
     + 
      -	# and now restore our original tip, as if the pushes
      -	# had happened
      -	git update-ref HEAD $orig_tip
      -'
     --
     --test_partial_bitmap
     -+test_bitmap () {
     -+    local enabled="$1"
     -+
     -+	# we need to create the tag up front such that it is covered by the repack and
     -+	# thus by generated bitmaps.
     -+	test_expect_success 'create tags' '
     -+		git tag --message="tag pointing to HEAD" perf-tag HEAD
     -+	'
     -+
     -+	test_expect_success "use lookup table: $enabled" '
     -+		git config pack.writeBitmapLookupTable '"$enabled"'
     -+	'
     -+
     -+	test_perf "repack to disk (lookup=$enabled)" '
     -+		git repack -ad
     -+	'
     -+
     -+	test_full_bitmap
     -+
     -+    test_expect_success "create partial bitmap state (lookup=$enabled)" '
     -+		# pick a commit to represent the repo tip in the past
     -+		cutoff=$(git rev-list HEAD~100 -1) &&
     -+		orig_tip=$(git rev-parse HEAD) &&
     -+
      +		# now kill off all of the refs and pretend we had
      +		# just the one tip
      +		rm -rf .git/logs .git/refs/* .git/packed-refs &&
     @@ t/perf/p5310-pack-bitmaps.sh: test_expect_success 'setup bitmap config' '
      +		# and now restore our original tip, as if the pushes
      +		# had happened
      +		git update-ref HEAD $orig_tip
     -+    '
     ++	'
      +}
     -+
     + 
     +-test_partial_bitmap
      +test_bitmap false
      +test_bitmap true
       
     @@ t/perf/p5326-multi-pack-bitmaps.sh: test_description='Tests performance using mi
      -
      -test_partial_bitmap
      +test_bitmap () {
     -+    local enabled="$1"
     ++	local enabled="$1"
      +
      +	# we need to create the tag up front such that it is covered by the repack and
      +	# thus by generated bitmaps.
     @@ t/perf/p5326-multi-pack-bitmaps.sh: test_description='Tests performance using mi
      +
      +	test_full_bitmap
      +
     -+    test_expect_success "create partial bitmap state (lookup=$enabled)" '
     ++	test_expect_success "create partial bitmap state (lookup=$enabled)" '
      +		# pick a commit to represent the repo tip in the past
      +		cutoff=$(git rev-list HEAD~100 -1) &&
      +		orig_tip=$(git rev-parse HEAD) &&
     @@ t/perf/p5326-multi-pack-bitmaps.sh: test_description='Tests performance using mi
      +		# and now restore our original tip, as if the pushes
      +		# had happened
      +		git update-ref HEAD $orig_tip
     -+    '
     ++	'
      +}
      +
      +test_bitmap false
 6:  fe556b58814 ! 6:  4f9f1049485 p5310-pack-bitmaps.sh: enable pack.writeReverseIndex for testing
     @@ Metadata
      Author: Abhradeep Chakraborty <chakrabortyabhradeep79@gmail.com>
      
       ## Commit message ##
     -    p5310-pack-bitmaps.sh: enable pack.writeReverseIndex for testing
     +    p5310-pack-bitmaps.sh: remove pack.writeReverseIndex
      
     -    Enable pack.writeReverseIndex to true to see the effect of writing
     -    the reverse index in the existing bitmap tests (with and without
     -    lookup table).
     +    The previous change enables the `pack.writereverseindex` to see
     +    the effect of writing reverse index in the performance test.
     +
     +    Remove the `pack.writeReverseIndex` configuration.
      
          Below is the result of performance test. Output format is in
          seconds.
      
     -    Test                                             this tree
     -    -------------------------------------------------------------------
     -    5310.4: repack to disk (lookup=false)           294.92(257.60+14.29)
     -    5310.5: simulated clone                         14.97(8.95+1.31)
     -    5310.6: simulated fetch                         1.64(2.77+0.20)
     -    5310.7: pack to file (bitmap)                   41.76(29.33+6.77)
     -    5310.8: rev-list (commits)                      0.71(0.49+0.09)
     -    5310.9: rev-list (objects)                      4.65(4.55+0.09)
     -    5310.10: rev-list with tag negated via --not    0.08(0.02+0.05)
     +    Test                                                  this tree
     +    ------------------------------------------------------------------------
     +    5310.4: repack to disk (lookup=false)               293.80(251.30+14.30)
     +    5310.5: simulated clone                             12.50(5.15+1.36)
     +    5310.6: simulated fetch                             1.83(2.90+0.23)
     +    5310.7: pack to file (bitmap)                       39.70(20.25+7.14)
     +    5310.8: rev-list (commits)                          1.00(0.60+0.13)
     +    5310.9: rev-list (objects)                          4.11(4.00+0.10)
     +    5310.10: rev-list with tag negated via --not        0.07(0.02+0.05)
                   --all (objects)
     -    5310.11: rev-list with negative tag (objects)   0.06(0.01+0.04)
     -    5310.12: rev-list count with blob:none          0.09(0.03+0.05)
     -    5310.13: rev-list count with blob:limit=1k      7.58(7.06+0.33)
     -    5310.14: rev-list count with tree:0             0.09(0.03+0.06)
     -    5310.15: simulated partial clone                8.64(8.04+0.35)
     -    5310.19: repack to disk (lookup=true)           249.86(191.57+19.50)
     -    5310.20: simulated clone                        13.67(8.83+1.06)
     -    5310.21: simulated fetch                        0.50(0.63+0.13)
     -    5310.22: pack to file (bitmap)                  41.24(28.99+6.67)
     -    5310.23: rev-list (commits)                     0.67(0.50+0.07)
     -    5310.24: rev-list (objects)                     4.88(4.79+0.08)
     -    5310.25: rev-list with tag negated via --not    0.04(0.00+0.03)
     +    5310.11: rev-list with negative tag (objects)       0.23(0.16+0.06)
     +    5310.12: rev-list count with blob:none              0.27(0.18+0.08)
     +    5310.13: rev-list count with blob:limit=1k          6.41(5.98+0.41)
     +    5310.14: rev-list count with tree:0                 0.26(0.18+0.07)
     +    5310.15: simulated partial clone                    4.34(3.29+0.37)
     +    5310.19: repack to disk (lookup=true)               250.93(171.97+20.78)
     +    5310.20: simulated clone                            10.80(5.14+1.06)
     +    5310.21: simulated fetch                            0.71(0.79+0.16)
     +    5310.22: pack to file (bitmap)                      39.49(20.19+6.98)
     +    5310.23: rev-list (commits)                         0.81(0.48+0.09)
     +    5310.24: rev-list (objects)                         3.48(3.38+0.09)
     +    5310.25: rev-list with tag negated via --not        0.04(0.00+0.03)
                   --all (objects)
     -    5310.26: rev-list with negative tag (objects)   0.05(0.00+0.04)
     -    5310.27: rev-list count with blob:none          0.05(0.01+0.03)
     -    5310.28: rev-list count with blob:limit=1k      8.02(7.16+0.34)
     -    5310.29: rev-list count with tree:0             0.05(0.01+0.04)
     -    5310.30: simulated partial clone                8.57(8.16+0.32)
     +    5310.26: rev-list with negative tag (objects)       0.22(0.16+0.05)
     +    5310.27: rev-list count with blob:none              0.22(0.16+0.05)
     +    5310.28: rev-list count with blob:limit=1k          6.21(5.76+0.29)
     +    5310.29: rev-list count with tree:0                 0.23(0.16+0.06)
     +    5310.30: simulated partial clone                    4.53(3.14+0.39)
      
          Tests 4-15 are without the use of lookup table. The rests are
          repeatation of the previous tests but using lookup table.
      
     -    Signed-off-by: Abhradeep Chakraborty <chakrabortyabhradeep79@gmail.com>
          Mentored-by: Taylor Blau <me@ttaylorr.com>
          Co-Mentored-by: Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
     +    Signed-off-by: Abhradeep Chakraborty <chakrabortyabhradeep79@gmail.com>
      
       ## t/perf/p5310-pack-bitmaps.sh ##
      @@ t/perf/p5310-pack-bitmaps.sh: test_perf_large_repo
       # We intentionally use the deprecated pack.writebitmaps
       # config so that we can test against older versions of git.
       test_expect_success 'setup bitmap config' '
     --	git config pack.writebitmaps true
     -+	git config pack.writebitmaps true &&
     -+	git config pack.writeReverseIndex true
     +-	git config pack.writebitmaps true &&
     +-	git config pack.writeReverseIndex true
     ++	git config pack.writebitmaps true
       '
       
       test_bitmap () {

-- 
gitgitgadget
