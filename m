Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 401A2C433EF
	for <git@archiver.kernel.org>; Wed, 20 Jul 2022 18:38:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231676AbiGTSih (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 20 Jul 2022 14:38:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230213AbiGTSif (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 20 Jul 2022 14:38:35 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BBB9735BD
        for <git@vger.kernel.org>; Wed, 20 Jul 2022 11:38:28 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id d16so27327253wrv.10
        for <git@vger.kernel.org>; Wed, 20 Jul 2022 11:38:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=t8p5Z8Ch8GQ+HsdfMe0JD9cNGU1lfzYyfo7bS+BFAEE=;
        b=hjTOoEgbBGdstoZtNR91mMA+rGgx5fTh2kHfuUtuy0SqBgH6//hInx1/x0HYs9uCa7
         F8dZWIgXfgfZygHXZslbszZ0qI7rK9ysVF8m2XIAxJkHwCf8i9GTK7X2Pne+hGZ2w2Sz
         Z9WAn1tH6Mk/XnuuTyQ7of3L16BWmpNgRhKp6iXnRtBISjeYrOIiIWViPfUc6oP889xb
         JOqOrzYSWcCkrVki7Opw8RB4z9s00SD+e3lULsGmXyQSsZahIgb6aBDgVpJlB4FvlmxF
         hhaGySwe7zQdaVLmDmz2ETdFzhLz7ebWgMT4PFNoBUyGvv/vSmRNjvq8jrJP0yOOx7X+
         AAZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=t8p5Z8Ch8GQ+HsdfMe0JD9cNGU1lfzYyfo7bS+BFAEE=;
        b=gSWpXlOL2tdzv3Yakb5LNVedLVki1/9PLr4T4IBFNF0iHB2mAK2lG4fvGVSF67XGad
         twd8hWPfGYGMKOzqada+NsQXlg8M627KixcGTzM07QgzGNMD2Ok9yxFMpdbCcaLHWeTa
         S9MWx66zJqMW2B+p303GvnuxbLVvQaNyJx/urCjc1orzHudFTLpMuBljDdCWz0kRmbt7
         QSqcY7NSs41mZBZtGGcKq03i6NTjEe2aMT4Vme5afJEUbELgxmFnVf6bSRKYQG7tweUl
         9jZb8cFtSV5LD5rf859xXTZvUsFfGe4EiCbrDHLx4MujcuwO93wffCMdiNNproVPxP/P
         gxCg==
X-Gm-Message-State: AJIora/YpXlcCli9eEo0a3kUVjnxeytPOs6Gu4nTSefEwtE7jPbLExD8
        kVnpoMhaCfvpPrDyTOnY+XQ5m+u4W+Q=
X-Google-Smtp-Source: AGRyM1uInuuTnIA1pDUVFz2x6TNFIXaN7D1klQ/rgOKYM20wifsGJyOLVbkt27N2cF5IgbxPn4a7+A==
X-Received: by 2002:a05:6000:1090:b0:21e:504b:87cf with SMTP id y16-20020a056000109000b0021e504b87cfmr1283952wrw.279.1658342306266;
        Wed, 20 Jul 2022 11:38:26 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id y11-20020adfc7cb000000b0021d6924b777sm17554459wrg.115.2022.07.20.11.38.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Jul 2022 11:38:25 -0700 (PDT)
Message-Id: <pull.1266.v5.git.1658342304.gitgitgadget@gmail.com>
In-Reply-To: <pull.1266.v4.git.1658325913.gitgitgadget@gmail.com>
References: <pull.1266.v4.git.1658325913.gitgitgadget@gmail.com>
From:   "Abhradeep Chakraborty via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 20 Jul 2022 18:38:18 +0000
Subject: [PATCH v5 0/6] [GSoC] bitmap: integrate a lookup table extension to the bitmap format
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Taylor Blau <me@ttaylorr.com>,
        Kaartic Sivaram <kaartic.sivaraam@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Philip Oakley <philipoakley@iee.email>,
        Martin =?UTF-8?Q?=C3=85gren?= <martin.agren@gmail.com>,
        Abhradeep Chakraborty <chakrabortyabhradeep79@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When parsing the .bitmap file, git loads all the bitmaps one by one even if
some of the bitmaps are not necessary. We can remove this overhead by
loading only the necessary bitmaps. A look up table extension can solve this
issue.

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
  pack-bitmap-write.c: write lookup table extension
  pack-bitmap-write: learn pack.writeBitmapLookupTable and add tests
  pack-bitmap: prepare to read lookup table extension
  p5310-pack-bitmaps.sh: enable `pack.writeReverseIndex`
  bitmap-lookup-table: add performance tests for lookup table

 Documentation/config/pack.txt             |   7 +
 Documentation/technical/bitmap-format.txt |  39 ++
 builtin/multi-pack-index.c                |   7 +
 builtin/pack-objects.c                    |   8 +
 midx.c                                    |   3 +
 midx.h                                    |   1 +
 pack-bitmap-write.c                       | 112 ++-
 pack-bitmap.c                             | 275 +++++++-
 pack-bitmap.h                             |  14 +-
 t/perf/p5310-pack-bitmaps.sh              |  68 +-
 t/perf/p5326-multi-pack-bitmaps.sh        |  95 +--
 t/t5310-pack-bitmaps.sh                   | 786 ++++++++++++----------
 t/t5311-pack-bitmaps-shallow.sh           |  53 +-
 t/t5326-multi-pack-bitmaps.sh             | 421 +++++++-----
 t/t5327-multi-pack-bitmaps-rev.sh         |  24 +-
 15 files changed, 1254 insertions(+), 659 deletions(-)


base-commit: 39c15e485575089eb77c769f6da02f98a55905e0
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1266%2FAbhra303%2Fbitmap-commit-table-v5
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1266/Abhra303/bitmap-commit-table-v5
Pull-Request: https://github.com/gitgitgadget/git/pull/1266

Range-diff vs v4:

 1:  f72bf11e6ef ! 1:  33aca8f3dc8 Documentation/technical: describe bitmap lookup table extension
     @@ Commit message
          even if all the bitmaps are not required. A "bitmap lookup table"
          extension to the bitmap format can reduce the overhead of loading
          bitmaps which stores a list of bitmapped commit id pos (in the midx
     -    or pack, along with their offset and xor offset. This way git can
     +    or pack, along with their offset and xor offset. This way Git can
          load only the necessary bitmaps without loading the previous bitmaps.
      
          Older versions of Git ignore the lookup table extension and don't
 2:  04244fadf5c = 2:  a913e6a2cb3 pack-bitmap-write.c: write lookup table extension
 3:  8bd7639e4b9 ! 3:  59b465e5a78 pack-bitmap-write: learn pack.writeBitmapLookupTable and add tests
     @@ t/t5311-pack-bitmaps-shallow.sh: test_description='check bitmap operation with s
      +}
      +
      +test_shallow_bitmaps
     -+
     ++test_shallow_bitmaps "pack.writeBitmapLookupTable"
       
       test_done
      
     @@ t/t5326-multi-pack-bitmaps.sh: bitmap_reuse_tests() {
       
      
       ## t/t5327-multi-pack-bitmaps-rev.sh ##
     -@@ t/t5327-multi-pack-bitmaps-rev.sh: export GIT_TEST_MIDX_READ_RIDX
     - midx_bitmap_core rev
     - midx_bitmap_partial_tests rev
     +@@ t/t5327-multi-pack-bitmaps-rev.sh: GIT_TEST_MIDX_READ_RIDX=0
     + export GIT_TEST_MIDX_WRITE_REV
     + export GIT_TEST_MIDX_READ_RIDX
     + 
     +-midx_bitmap_core rev
     +-midx_bitmap_partial_tests rev
     ++test_midx_bitmap_rev () {
     ++     writeLookupTable=false
     ++
     ++ 	for i in "$@"
     ++ 	do
     ++ 		case $i in
     ++ 		"pack.writeBitmapLookupTable") writeLookupTable=true;;
     ++ 		esac
     ++ 	done
     ++
     ++     test_expect_success 'setup bitmap config' '
     ++         rm -rf * .git &&
     ++         git init &&
     ++         git config pack.writeBitmapLookupTable '"$writeLookupTable"'
     ++     '
     ++
     ++     midx_bitmap_core rev
     ++     midx_bitmap_partial_tests rev
     ++ }
     ++
     ++ test_midx_bitmap_rev
     ++ test_midx_bitmap_rev "pack.writeBitmapLookupTable"
       
     -+test_expect_success 'reinitialize the repository with lookup table enabled' '
     -+    rm -fr * .git &&
     -+    git init &&
     -+    git config pack.writeBitmapLookupTable true
     -+'
     -+
     -+midx_bitmap_core rev
     -+midx_bitmap_partial_tests rev
     -+
       test_done
 4:  afc8c660ac1 ! 4:  6918f0860ad pack-bitmap: prepare to read lookup table extension
     @@ pack-bitmap.c: struct include_data {
      +	if (xor_row != 0xffffffff) {
      +		int xor_flags;
      +		khiter_t hash_pos;
     -+		uint64_t offset_xor;
      +		struct bitmap_lookup_table_xor_item *xor_item;
      +
      +		while (xor_row != 0xffffffff) {
     @@ pack-bitmap.c: struct include_data {
      +
      +		while (xor_items_nr) {
      +			xor_item = &xor_items[xor_items_nr - 1];
     -+			offset_xor = xor_item->offset;
     -+
     -+			bitmap_git->map_pos = offset_xor;
     ++			bitmap_git->map_pos = xor_item->offset;
      +			if (bitmap_git->map_size - bitmap_git->map_pos < bitmap_header_size) {
      +				error(_("corrupt ewah bitmap: truncated header for bitmap of commit \"%s\""),
      +					oid_to_hex(&xor_item->oid));
 5:  fc69489e395 = 5:  e7ef420f321 p5310-pack-bitmaps.sh: enable `pack.writeReverseIndex`
 6:  52f7d8359ee = 6:  6628001241d bitmap-lookup-table: add performance tests for lookup table

-- 
gitgitgadget
