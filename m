Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89611C433FE
	for <git@archiver.kernel.org>; Tue,  8 Dec 2020 00:05:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3F3DF23A04
	for <git@archiver.kernel.org>; Tue,  8 Dec 2020 00:05:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727431AbgLHAEw (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 7 Dec 2020 19:04:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726207AbgLHAEw (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Dec 2020 19:04:52 -0500
Received: from mail-oi1-x236.google.com (mail-oi1-x236.google.com [IPv6:2607:f8b0:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD1D3C061749
        for <git@vger.kernel.org>; Mon,  7 Dec 2020 16:04:11 -0800 (PST)
Received: by mail-oi1-x236.google.com with SMTP id y74so17504602oia.11
        for <git@vger.kernel.org>; Mon, 07 Dec 2020 16:04:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=G/NJ/AiMhQfqnDfkgdKsSqrHtOlg78I0B684hwJJ4qc=;
        b=RbgAxF1pQglSB6KTdyRQg+2JY9LwFuAwIsbsNFLJuGLWnr+aJThJ4TmwNszNfEIo42
         iujCMkeK9kTICU/bQWbwOoEqCLtom3qYbvWHvx15MvqKrAV7TJSMi8HY6JC2oHGb9RJv
         ioVfeLsNQUIRNYmzVetXFoInj6po6w33kZxspf44BbNCqOiE7G+MTOlueLBWJct8qviG
         9X+XnRpQe08SeWSHm2a91PMsew1ElBycQWxVb4uaOilrKL5MYAdpfJa0eFAKBnHIPMMZ
         kxlRvGrJDLOu0tRFx+WAqch9dBFWyX3L3/t9UjANT2LGMyRixvcbJcIfSJpFPop9jzIX
         pvpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=G/NJ/AiMhQfqnDfkgdKsSqrHtOlg78I0B684hwJJ4qc=;
        b=ty3D7M74ZdaWZHIF27/2ojzzvTPyRWA6MSQ/d6qzIGo8yEbHWL+EbpiarWC0o98RjA
         moiLJtlBculXb/O7JmWO7y2JOuBxD/gtvw4zh7nVqPlhriAnmTQ0pGv9hzRNe2abY9B6
         +PhDPIRik5tsA5+XKPvWw78/jOQSV8zwR+Qi8TgRXTe50DJA5+9PcoXR7P8eLNcjtnbj
         SwGaq+urci5japW4bRhah7Yj9Qw1j93mMlGmEQjhSdaHoqtFjzl96O3WpXlB83rJ+Rwr
         TdfhKL7+g9Q5M/vNNwhgxJH0b/0TT5cLUDAKCYwo59BxiKx3pjbAxpIBOqpUNoErBQaW
         IJTw==
X-Gm-Message-State: AOAM531rdQJLkmaZPHhsk89Vjj5qlsNBCxQfXEeyMQFV9y4vKOT08u1H
        59gdem51mWKkFQcLFrJj7ZRU1Ho35FRnLGin
X-Google-Smtp-Source: ABdhPJyn1JZQ7YSmULOXDi86jYWPsq6GgNA0flq9gn4PkcbkVXjwHdDljk/bj5YHCxdQVQ86WPwmMg==
X-Received: by 2002:aca:c057:: with SMTP id q84mr990455oif.86.1607385850456;
        Mon, 07 Dec 2020 16:04:10 -0800 (PST)
Received: from localhost ([8.44.146.30])
        by smtp.gmail.com with ESMTPSA id 6sm3020568otc.19.2020.12.07.16.04.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Dec 2020 16:04:09 -0800 (PST)
Date:   Mon, 7 Dec 2020 19:04:06 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     peff@peff.net, jonathantanmy@google.com, dstolee@microsoft.com,
        gitster@pobox.com
Subject: [PATCH v3 00/24] pack-bitmap: bitmap generation improvements
Message-ID: <cover.1607385833.git.me@ttaylorr.com>
References: <cover.1605123652.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1605123652.git.me@ttaylorr.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Here's an updated v3 of mine, Stolee, and Peff's series to improve the
CPU performance of generating reachability bitmaps.

Not a great deal has changed since last time, though this version does
incorporate feedback from Jonathan Tan and Junio (thanks, both, for your
review!). A range-diff is below for convenience, but the major
highlights are:

  - ALLOC_GROW() is now used in more places (this didn't measurably
    affect peak-heap usage, so it's a pure nicetie to avoid duplicating
    that logic throughout the ewah code)

  - Some later commits have been reworded to add additional clarity

  - bitmap_diff_nonzero() was replaced with bitmap_is_subset(), and the
    implementation amended to follow Junio's suggestion

  - The final patches have been slightly modified to avoid allocating
    extra bits in the bitmasks for cases where reachability bitmaps have
    already been generated for those patches (suggestion courtesy of
    Jonathan Tan)

I'm hopeful that this will be in good shape for queuing up, since
Jonathan had a chance to review the whole series. Thanks!

Derrick Stolee (9):
  pack-bitmap-write: fill bitmap with commit history
  bitmap: implement bitmap_is_subset()
  commit: implement commit_list_contains()
  t5310: add branch-based checks
  pack-bitmap-write: rename children to reverse_edges
  pack-bitmap-write: build fewer intermediate bitmaps
  pack-bitmap-write: use existing bitmaps
  pack-bitmap-write: relax unique rewalk condition
  pack-bitmap-write: better reuse bitmaps

Jeff King (11):
  pack-bitmap: fix header size check
  pack-bitmap: bounds-check size of cache extension
  t5310: drop size of truncated ewah bitmap
  rev-list: die when --test-bitmap detects a mismatch
  ewah: factor out bitmap growth
  ewah: make bitmap growth less aggressive
  ewah: implement bitmap_or()
  ewah: add bitmap_dup() function
  pack-bitmap-write: reimplement bitmap writing
  pack-bitmap-write: pass ownership of intermediate bitmaps
  pack-bitmap-write: ignore BITMAP_FLAG_REUSE

Taylor Blau (4):
  ewah/ewah_bitmap.c: avoid open-coding ALLOC_GROW()
  pack-bitmap.c: check reads more aggressively when loading
  pack-bitmap: factor out 'bitmap_for_commit()'
  pack-bitmap: factor out 'add_commit_to_bitmap()'

 builtin/pack-objects.c  |   1 -
 commit.c                |  11 +
 commit.h                |   2 +
 ewah/bitmap.c           |  54 ++++-
 ewah/ewah_bitmap.c      |  15 +-
 ewah/ewok.h             |   3 +-
 pack-bitmap-write.c     | 474 ++++++++++++++++++++++++++--------------
 pack-bitmap.c           | 139 ++++++------
 pack-bitmap.h           |   8 +-
 t/t5310-pack-bitmaps.sh | 164 +++++++++++---
 10 files changed, 576 insertions(+), 295 deletions(-)

Range-diff against v2:
 1:  07054ff8ee <  -:  ---------- ewah/ewah_bitmap.c: grow buffer past 1
 -:  ---------- >  1:  0b25ba4ca7 ewah/ewah_bitmap.c: avoid open-coding ALLOC_GROW()
 2:  74a13b4a6e =  2:  b455b248e4 pack-bitmap: fix header size check
 3:  db11116dac =  3:  7322427444 pack-bitmap: bounds-check size of cache extension
 4:  f779e76f82 =  4:  055bc1fe66 t5310: drop size of truncated ewah bitmap
 5:  1a9ac1c4ae =  5:  c99cacea67 rev-list: die when --test-bitmap detects a mismatch
 6:  9bb1ea3b19 =  6:  b79360383e ewah: factor out bitmap growth
 7:  f8426c7e8b <  -:  ---------- ewah: make bitmap growth less aggressive
 -:  ---------- >  7:  4b56f12932 ewah: make bitmap growth less aggressive
 8:  674e31f98e !  8:  34137a7f35 ewah: implement bitmap_or()
    @@ Commit message

         Interestingly, we have a public header declaration going back to
         e1273106f6 (ewah: compressed bitmap implementation, 2013-11-14), but the
    -    function was never implemented.
    +    function was never implemented. That was all OK since there were no
    +    users of 'bitmap_or()', but a first caller will be added in a couple of
    +    patches.

         Signed-off-by: Jeff King <peff@peff.net>
         Signed-off-by: Taylor Blau <me@ttaylorr.com>
 9:  a903c949d8 !  9:  fe89f87716 ewah: add bitmap_dup() function
    @@ ewah/bitmap.c: struct bitmap *bitmap_new(void)
     +
      static void bitmap_grow(struct bitmap *self, size_t word_alloc)
      {
    - 	if (word_alloc > self->word_alloc) {
    + 	size_t old_size = self->word_alloc;

      ## ewah/ewok.h ##
     @@ ewah/ewok.h: struct bitmap {
10:  c951206729 ! 10:  91cd8b1a49 pack-bitmap-write: reimplement bitmap writing
    @@ pack-bitmap-write.c: static void compute_xor_offsets(void)
     -		kh_value(writer.bitmaps, hash_pos) = stored;
     -		display_progress(writer.progress, writer.selected_nr - i);
     +	trace2_region_enter("pack-bitmap-write", "building_bitmaps_total",
    -+		the_repository);
    ++			    the_repository);
     +
     +	bitmap_builder_init(&bb, &writer);
     +	for (i = bb.commits_nr; i > 0; i--) {
    @@ pack-bitmap-write.c: static void compute_xor_offsets(void)
     +		ent->bitmap = NULL;
      	}
     +	bitmap_builder_clear(&bb);
    ++
    ++	trace2_region_leave("pack-bitmap-write", "building_bitmaps_total",
    ++			    the_repository);

     -	bitmap_free(base);
      	stop_progress(&writer.progress);
11:  466dd3036a = 11:  64598024ec pack-bitmap-write: pass ownership of intermediate bitmaps
12:  8e5607929d ! 12:  93fc437a3c pack-bitmap-write: fill bitmap with commit history
    @@ Metadata
      ## Commit message ##
         pack-bitmap-write: fill bitmap with commit history

    -    The fill_bitmap_commit() method assumes that every parent of the given
    -    commit is already part of the current bitmap. Instead of making that
    -    assumption, let's walk parents until we reach commits already part of
    -    the bitmap. Set the value for that parent immediately after querying to
    -    save time doing double calls to find_object_pos() and to avoid inserting
    -    the parent into the queue multiple times.
    +    The current implementation of bitmap_writer_build() creates a
    +    reachability bitmap for every walked commit. After computing a bitmap
    +    for a commit, those bits are pushed to an in-progress bitmap for its
    +    children.
    +
    +    fill_bitmap_commit() assumes the bits corresponding to objects
    +    reachable from the parents of a commit are already set. This means that
    +    when visiting a new commit, we only have to walk the objects reachable
    +    between it and any of its parents.
    +
    +    A future change to bitmap_writer_build() will relax this condition so
    +    not all parents have their bits set. Prepare for that by having
    +    'fill_bitmap_commit()' walk parents until reaching commits whose bits
    +    are already set. Then, walk the trees for these commits as well.
    +
    +    This has no functional change with the current implementation of
    +    bitmap_writer_build().

         Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
         Signed-off-by: Taylor Blau <me@ttaylorr.com>
    @@ pack-bitmap-write.c: void bitmap_writer_build(struct packing_data *to_pack)
     +	clear_prio_queue(&queue);
      	bitmap_builder_clear(&bb);

    - 	stop_progress(&writer.progress);
    + 	trace2_region_leave("pack-bitmap-write", "building_bitmaps_total",
13:  4840c64c51 ! 13:  0d5213ba44 bitmap: add bitmap_diff_nonzero()
    @@ Metadata
     Author: Derrick Stolee <dstolee@microsoft.com>

      ## Commit message ##
    -    bitmap: add bitmap_diff_nonzero()
    +    bitmap: implement bitmap_is_subset()

    -    The bitmap_diff_nonzero() checks if the 'self' bitmap contains any bits
    -    that are not on in the 'other' bitmap.
    -
    -    Also, delete the declaration of bitmap_is_subset() as it is not used or
    -    implemented.
    +    The bitmap_is_subset() function checks if the 'self' bitmap contains any
    +    bitmaps that are not on in the 'other' bitmap. Up until this patch, it
    +    had a declaration, but no implementation or callers. A subsequent patch
    +    will want this function, so implement it here.

    +    Helped-by: Junio C Hamano <gitster@pobox.com>
         Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
         Signed-off-by: Taylor Blau <me@ttaylorr.com>

    @@ ewah/bitmap.c: int bitmap_equals(struct bitmap *self, struct bitmap *other)
      	return 1;
      }

    -+int bitmap_diff_nonzero(struct bitmap *self, struct bitmap *other)
    ++int bitmap_is_subset(struct bitmap *self, struct bitmap *other)
     +{
    -+	struct bitmap *small;
    -+	size_t i;
    ++	size_t common_size, i;
     +
    -+	if (self->word_alloc < other->word_alloc) {
    -+		small = self;
    -+	} else {
    -+		small = other;
    -+
    -+		for (i = other->word_alloc; i < self->word_alloc; i++) {
    -+			if (self->words[i] != 0)
    ++	if (self->word_alloc < other->word_alloc)
    ++		common_size = self->word_alloc;
    ++	else {
    ++		common_size = other->word_alloc;
    ++		for (i = common_size; i < self->word_alloc; i++) {
    ++			if (self->words[i])
     +				return 1;
     +		}
     +	}
     +
    -+	for (i = 0; i < small->word_alloc; i++) {
    -+		if ((self->words[i] & ~other->words[i]))
    ++	for (i = 0; i < common_size; i++) {
    ++		if (self->words[i] & ~other->words[i])
     +			return 1;
     +	}
    -+
     +	return 0;
     +}
     +
    @@ ewah/ewok.h: int bitmap_get(struct bitmap *self, size_t pos);
      void bitmap_free(struct bitmap *self);
      int bitmap_equals(struct bitmap *self, struct bitmap *other);
     -int bitmap_is_subset(struct bitmap *self, struct bitmap *super);
    -+int bitmap_diff_nonzero(struct bitmap *self, struct bitmap *other);
    ++int bitmap_is_subset(struct bitmap *self, struct bitmap *other);

      struct ewah_bitmap * bitmap_to_ewah(struct bitmap *bitmap);
      struct bitmap *ewah_to_bitmap(struct ewah_bitmap *ewah);
14:  63e846f4e8 = 14:  72e745fed8 commit: implement commit_list_contains()
15:  8b5d239333 = 15:  c2cae4a8d0 t5310: add branch-based checks
16:  60a46091bb = 16:  c0e2b6f5d9 pack-bitmap-write: rename children to reverse_edges
17:  8f7bb2dd2e = 17:  37f9636098 pack-bitmap.c: check reads more aggressively when loading
18:  5262daa330 ! 18:  e520c8fdc4 pack-bitmap-write: build fewer intermediate bitmaps
    @@ pack-bitmap-write.c: static void bitmap_builder_init(struct bitmap_builder *bb,
     +				c_not_p = 1;
     +				p_not_c = 0;
     +			} else {
    -+				c_not_p = bitmap_diff_nonzero(c_ent->commit_mask, p_ent->commit_mask);
    -+				p_not_c = bitmap_diff_nonzero(p_ent->commit_mask, c_ent->commit_mask);
    ++				c_not_p = bitmap_is_subset(c_ent->commit_mask, p_ent->commit_mask);
    ++				p_not_c = bitmap_is_subset(p_ent->commit_mask, c_ent->commit_mask);
     +			}
     +
     +			if (!c_not_p)
    @@ t/t5310-pack-bitmaps.sh: has_any () {
     +#      | / \________________________ |
     +#      |/                           \|
     +# (l2) *                             * (r2)
    -+#       \____________...____________ |
    ++#       \___________________________ |
     +#                                   \|
     +#                                    * (base)
     +#
    @@ t/t5310-pack-bitmaps.sh: test_expect_success 'setup repo with moderate-sized his
      '

      test_expect_success 'rev-list --test-bitmap verifies bitmaps' '
    -@@ t/t5310-pack-bitmaps.sh: test_expect_success 'truncated bitmap fails gracefully (ewah)' '
    - 	git rev-list --use-bitmap-index --count --all >expect &&
    - 	bitmap=$(ls .git/objects/pack/*.bitmap) &&
    - 	test_when_finished "rm -f $bitmap" &&
    --	test_copy_bytes 256 <$bitmap >$bitmap.tmp &&
    -+	test_copy_bytes 270 <$bitmap >$bitmap.tmp &&
    - 	mv -f $bitmap.tmp $bitmap &&
    - 	git rev-list --use-bitmap-index --count --all >actual 2>stderr &&
    - 	test_cmp expect actual &&
19:  a206f48614 = 19:  c3975fcf78 pack-bitmap-write: ignore BITMAP_FLAG_REUSE
20:  9928b3c7da = 20:  d5ef2c7f81 pack-bitmap: factor out 'bitmap_for_commit()'
21:  f40a39a48a = 21:  f0500190f0 pack-bitmap: factor out 'add_commit_to_bitmap()'
22:  4bf5e78a54 ! 22:  c6fde2b0c4 pack-bitmap-write: use existing bitmaps
    @@ Commit message
         In fill_bitmap_commit(), we must reorder thing somewhat. The priority
         queue walks commits from newest-to-oldest, which means we correctly stop
         walking when reaching a commit with a bitmap. However, if we walk trees
    -    from top to bottom, then we might be parsing trees that are actually
    -    part of a re-used bitmap. To avoid over-walking trees, add them to a
    -    LIFO queue and walk them from bottom-to-top after exploring commits
    -    completely.
    +    interleaved with the commits, then we might be parsing trees that are
    +    actually part of a re-used bitmap. To avoid over-walking trees, add them
    +    to a LIFO queue and walk them after exploring commits completely.

         On git.git, this reduces a second immediate bitmap computation from 2.0s
         to 1.0s. On linux.git, we go from 32s to 22s. On chromium's fork
    @@ pack-bitmap-write.c: static void fill_bitmap_tree(struct bitmap *bitmap,
      		struct commit_list *p;
      		struct commit *c = prio_queue_get(queue);

    -+		/*
    -+		 * If this commit has an old bitmap, then translate that
    -+		 * bitmap and add its bits to this one. No need to walk
    -+		 * parents or the tree for this commit.
    -+		 */
     +		if (old_bitmap && mapping) {
    -+			struct ewah_bitmap *old;
    -+
    -+			old = bitmap_for_commit(old_bitmap, c);
    ++			struct ewah_bitmap *old = bitmap_for_commit(old_bitmap, c);
    ++			/*
    ++			 * If this commit has an old bitmap, then translate that
    ++			 * bitmap and add its bits to this one. No need to walk
    ++			 * parents or the tree for this commit.
    ++			 */
     +			if (old && !rebuild_bitmap(mapping, old, ent->bitmap))
     +				continue;
     +		}
    @@ pack-bitmap-write.c: void bitmap_writer_build(struct packing_data *to_pack)
      	writer.to_pack = to_pack;
     @@ pack-bitmap-write.c: void bitmap_writer_build(struct packing_data *to_pack)
      	trace2_region_enter("pack-bitmap-write", "building_bitmaps_total",
    - 		the_repository);
    + 			    the_repository);

     +	old_bitmap = prepare_bitmap_git(to_pack->repo);
     +	if (old_bitmap)
    @@ pack-bitmap-write.c: void bitmap_writer_build(struct packing_data *to_pack)
      	bitmap_builder_clear(&bb);
     +	free(mapping);

    - 	stop_progress(&writer.progress);
    -
    + 	trace2_region_leave("pack-bitmap-write", "building_bitmaps_total",
    + 			    the_repository);
23:  1da4fa0fb8 ! 23:  50d2031deb pack-bitmap-write: relax unique rewalk condition
    @@ Commit message
                      | scratch | existing | scratch | existing |
           -----------+---------+----------+---------+-----------
             original |  64.044 |   83.241 |   2.088 |    2.194 |
    -      last patch |  44.811 |   27.828 |   2.289 |    2.358 |
    -      this patch | 100.641 |   35.560 |   2.152 |    2.224 |
    +      last patch |  45.049 |   37.624 |   2.267 |    2.334 |
    +      this patch |  88.478 |   53.218 |   2.157 |    2.224 |

         Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
         Signed-off-by: Taylor Blau <me@ttaylorr.com>
24:  42399a1c2e <  -:  ---------- pack-bitmap-write: better reuse bitmaps
 -:  ---------- > 24:  6b9950771e pack-bitmap-write: better reuse bitmaps
--
2.29.2.533.g07db1f5344
