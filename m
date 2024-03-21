Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02E5115CB
	for <git@vger.kernel.org>; Thu, 21 Mar 2024 22:40:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711060826; cv=none; b=coNrwZu3dFmo9Js7x7Ms1sKmazzd4XGWCPLtS8fOwPVH/PPbvAnwTYoqXQbM6FR1zZG1NWZK0osvrYadm1fxG4rJFKcgsj1LmJ8ag8eBhwN12YC/FNbQ8J5TLtivUD5jsThkznVChygRhj+SPoKeTN7VxbQ2d20qjd9DuVJRhmE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711060826; c=relaxed/simple;
	bh=LkwcRwYthynB9shmUtHbNHAAqm/WFGah4oIPAWPrCPQ=;
	h=Message-ID:In-Reply-To:References:From:Date:Subject:MIME-Version:
	 Content-Type:To:Cc; b=Lmx4O0Yh8dWoX7nUD9S1obRxZo/IDQnwXtdpTHIwLzvazDIJwP2eRab75am4FL0tq6C7EgkJDx1raFp8cowyX2yR78tF29NjjHCt1cU7skKA/WIirQG//RaCfJ1ibgHt4+z9DoBE3Q2k4zM7MkVaoSN6DpdVaA29ADhf+dgquyk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IoZO2Mqb; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IoZO2Mqb"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-414689ba80eso12225415e9.2
        for <git@vger.kernel.org>; Thu, 21 Mar 2024 15:40:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711060821; x=1711665621; darn=vger.kernel.org;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RpT0XL5P3moBw0tPkt9+2efD2fxyuixvxWpGAQKH05U=;
        b=IoZO2MqbDyYescAZrCVtokeyJYPCwHUgDb1xi6MGjI+mS7SVywe9u6nhGceiTr8uBM
         6ggR2xFiPrtzWQTS3htpYrE+1ZsJtbJRXL+DkU4l6/bBIgIUXUTCRYKse8gqKoUgvCc4
         S/m0aP0E50aZH8JHJR6YSm5Rts2ltMTVZVmilWkFFFdZuOTiZyxbv7MD57nXnUY3SIl+
         pCm35ZumZRKMeE9SKPwywpCRZadfzT2EWUMlifJeYyE6kmHUhUtr0qQ4r0kJRINvU/IF
         NvU9eKfbxJfkKjMywxXdNc0vJf1ZasgCZJbuz/ShoQSjLzwHJuGSvuwAscGCAaJQ8zQ5
         du2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711060821; x=1711665621;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RpT0XL5P3moBw0tPkt9+2efD2fxyuixvxWpGAQKH05U=;
        b=vw8FTXEhEzCZbTFcFmsq+hI8d3Y/hhJS3UTSD9ZkAdYgMB2UApjzgbP2iwiUA+seVt
         ZOIfBcrNV/+iN3wGNz38xf54EWPr2b4pJ45xGEpGW+s1iSOEyQGS4a95LWBYYj35cBdl
         VFOsSow68NN4rwUC1DOy+erjES1kZn8ojkMLqIGaIfONNYbzgojAVk2NzFBDVNsNQ7Xn
         FvH9sYSapsuVMmsYerhd1LXibo6p9br53MQPhCPtVG4cVL7fCZTvOB0JPSR/+ktOKBpR
         vvowmt4wAKrl0WOtlfuTZaYGjwQHKk/isKYYI4p+DC9Rxbh8y6GBLhmkji7H8R1m3eOQ
         JpZA==
X-Gm-Message-State: AOJu0YxWopziPIaBAxkyThE7NFySPC1GKjxpKX2yEH9rRclzbOG2s7nK
	81djRIPhTtTX2wqZMJEdMp8RGDg7ZuTStgD52mYE25eEACjaAJy2s6ZYfRsg
X-Google-Smtp-Source: AGHT+IHY8FK+21Tjd0XKylJCbVxhH8w718iXJMRLQLa7TWlORe0ly0w//nnyB/rztqQXL2yHGDSAGQ==
X-Received: by 2002:a5d:6d45:0:b0:33e:c522:a071 with SMTP id k5-20020a5d6d45000000b0033ec522a071mr372090wri.51.1711060821366;
        Thu, 21 Mar 2024 15:40:21 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id bn21-20020a056000061500b0033e0dd83be1sm610965wrb.91.2024.03.21.15.40.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Mar 2024 15:40:20 -0700 (PDT)
Message-ID: <pull.1683.v2.git.1711060819.gitgitgadget@gmail.com>
In-Reply-To: <pull.1683.git.1709669025722.gitgitgadget@gmail.com>
References: <pull.1683.git.1709669025722.gitgitgadget@gmail.com>
From: "Justin Tobler via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 21 Mar 2024 22:40:16 +0000
Subject: [PATCH v2 0/3] reftable/stack: use geometric table compaction
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc: Sent
To: git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>,
    Justin Tobler <jltobler@gmail.com>

Hello again,

This is the second version my patch series that refactors the reftable
compaction strategy to instead follow a geometric sequence. Changes compared
to v1:

 * Added GIT_TEST_REFTABLE_NO_AUTOCOMPACTION environment variable to disable
   reftable compaction when testing.
 * Refactored worktree tests in t0610-reftable-basics.sh to properly assert
   git-pack-refs(1) works as expected.
 * Added test to validate that alternating table sizes are compacted.
 * Added benchmark to compare compaction strategies.
 * Moved change that made compaction segment end inclusive to its own
   commit.
 * Added additional explanation in commits and comments and fixed typos.

Thanks for taking a look!

Justin

Justin Tobler (3):
  reftable/stack: add env to disable autocompaction
  reftable/stack: use geometric table compaction
  reftable/segment: make segment end inclusive

 reftable/stack.c           | 113 ++++++++++++++++---------------------
 reftable/stack.h           |   3 -
 reftable/stack_test.c      |  66 +++++-----------------
 reftable/system.h          |   1 +
 t/t0610-reftable-basics.sh |  43 +++++++++-----
 5 files changed, 94 insertions(+), 132 deletions(-)


base-commit: 3bd955d26919e149552f34aacf8a4e6368c26cec
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1683%2Fjltobler%2Fjt%2Freftable-geometric-compaction-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1683/jltobler/jt/reftable-geometric-compaction-v2
Pull-Request: https://github.com/gitgitgadget/git/pull/1683

Range-diff vs v1:

 -:  ----------- > 1:  cb6b152e5c8 reftable/stack: add env to disable autocompaction
 1:  7a518853a10 ! 2:  def70084523 reftable/stack: use geometric table compaction
     @@ Commit message
          occurring until a separate operation produces a table matching the
          previous table log value.
      
     -    To avoid unbounded growth of the table list, walk through each table and
     -    evaluate if it needs to be included in the compaction segment to restore
     -    a geometric sequence.
     +    Instead, to avoid unbounded growth of the table list, the compaction
     +    strategy is updated to ensure tables follow a geometric sequence after
     +    each operation. This is done by walking the table list in reverse index
     +    order to identify the compaction segment start and end. The compaction
     +    segment end is found by identifying the first table which has a
     +    preceding table size less than twice the current table. Next, the
     +    compaction segment start is found iterating through the remaining tables
     +    in the list checking if the previous table size is less than twice the
     +    cumulative of tables from the segment end. This ensures the correct
     +    segment start is found and that the newly compacted table does not
     +    violate the geometric sequence.
     +
     +    When creating 10 thousand references, the new strategy has no
     +    performance impact:
     +
     +    Benchmark 1: update-ref: create refs sequentially (revision = HEAD~)
     +      Time (mean ± σ):     26.516 s ±  0.047 s    [User: 17.864 s, System: 8.491 s]
     +      Range (min … max):   26.447 s … 26.569 s    10 runs
     +
     +    Benchmark 2: update-ref: create refs sequentially (revision = HEAD)
     +      Time (mean ± σ):     26.417 s ±  0.028 s    [User: 17.738 s, System: 8.500 s]
     +      Range (min … max):   26.366 s … 26.444 s    10 runs
     +
     +    Summary
     +      update-ref: create refs sequentially (revision = HEAD) ran
     +        1.00 ± 0.00 times faster than update-ref: create refs sequentially (revision = HEAD~)
      
          Some tests in `t0610-reftable-basics.sh` assert the on-disk state of
          tables and are therefore updated to specify the correct new table count.
     @@ reftable/stack.c: static int segment_size(struct segment *s)
      +	 * until a valid segment end is found. If the preceding table is smaller
      +	 * than the current table multiplied by the geometric factor (2), the
      +	 * current table is set as the compaction segment end.
     ++	 *
     ++	 * Tables after the ending point are not added to the byte count because
     ++	 * they are already valid members of the geometric sequence. Due to the
     ++	 * properties of a geometric sequence, it is not possible for the sum of
     ++	 * these tables to exceed the value of the ending point table.
      +	 */
      +	for (i = n - 1; i > 0; i--) {
      +		if (sizes[i - 1] < sizes[i] * 2) {
     -+			seg.end = i;
     ++			seg.end = i + 1;
      +			bytes = sizes[i];
       			break;
      +		}
     @@ reftable/stack.c: static int segment_size(struct segment *s)
      +
      +	/*
      +	 * Find the starting table of the compaction segment by iterating
     -+	 * through the remaing tables and keeping track of the accumulated size
     -+	 * of all tables seen from the segment end table.
     ++	 * through the remaining tables and keeping track of the accumulated
     ++	 * size of all tables seen from the segment end table.
      +	 *
      +	 * Note that we keep iterating even after we have found the first
     -+	 * first starting point. This is because there may be tables in the
     -+	 * stack preceding that first starting point which violate the geometric
     ++	 * starting point. This is because there may be tables in the stack
     ++	 * preceding that first starting point which violate the geometric
      +	 * sequence.
      +	 */
      +	for (; i > 0; i--) {
     @@ reftable/stack.c: static int segment_size(struct segment *s)
       }
       
       static uint64_t *stack_table_sizes_for_compaction(struct reftable_stack *st)
     -@@ reftable/stack.c: int reftable_stack_auto_compact(struct reftable_stack *st)
     - 		suggest_compaction_segment(sizes, st->merged->stack_len);
     - 	reftable_free(sizes);
     - 	if (segment_size(&seg) > 0)
     --		return stack_compact_range_stats(st, seg.start, seg.end - 1,
     -+		return stack_compact_range_stats(st, seg.start, seg.end,
     - 						 NULL);
     - 
     - 	return 0;
      
       ## reftable/stack.h ##
      @@ reftable/stack.h: int read_lines(const char *filename, char ***lines);
     @@ reftable/stack_test.c: static void test_reftable_stack_hash_id(void)
      -	EXPECT(min.start == 2);
      -	EXPECT(min.end == 7);
      +	EXPECT(min.start == 1);
     -+	EXPECT(min.end == 9);
     ++	EXPECT(min.end == 10);
       }
       
       static void test_suggest_compaction_segment_nothing(void)
     @@ t/t0610-reftable-basics.sh: test_expect_success 'ref transaction: writes cause a
       
       	test_commit -C repo --no-tag B &&
       	test_line_count = 1 repo/.git/reftable/tables.list
     + '
     + 
     ++test_expect_success 'ref transaction: alternating table sizes are compacted' '
     ++	test_when_finished "rm -rf repo" &&
     ++	git init repo &&
     ++	test_commit -C repo A &&
     ++	for i in $(test_seq 20)
     ++	do
     ++		git -C repo branch -f foo &&
     ++		git -C repo branch -d foo || return 1
     ++	done &&
     ++	test_line_count = 2 repo/.git/reftable/tables.list
     ++'
     ++
     + check_fsync_events () {
     + 	local trace="$1" &&
     + 	shift &&
      @@ t/t0610-reftable-basics.sh: test_expect_success 'ref transaction: writes are synced' '
       		git -C repo -c core.fsync=reference \
       		-c core.fsyncMethod=fsync update-ref refs/heads/branch HEAD &&
     @@ t/t0610-reftable-basics.sh: do
       		git -C repo pack-refs &&
       		test_expect_perms "-rw-rw-r--" repo/.git/reftable/tables.list &&
      @@ t/t0610-reftable-basics.sh: test_expect_success 'worktree: pack-refs in main repo packs main refs' '
     + 	test_when_finished "rm -rf repo worktree" &&
     + 	git init repo &&
       	test_commit -C repo A &&
     - 	git -C repo worktree add ../worktree &&
     +-	git -C repo worktree add ../worktree &&
     ++	GIT_TEST_REFTABLE_NO_AUTOCOMPACTION=true git -C repo worktree add ../worktree &&
     ++	GIT_TEST_REFTABLE_NO_AUTOCOMPACTION=true git -C worktree update-ref refs/worktree/per-worktree HEAD &&
       
      -	test_line_count = 3 repo/.git/worktrees/worktree/reftable/tables.list &&
      -	test_line_count = 4 repo/.git/reftable/tables.list &&
     -+	test_line_count = 1 repo/.git/worktrees/worktree/reftable/tables.list &&
     -+	test_line_count = 1 repo/.git/reftable/tables.list &&
     ++	test_line_count = 4 repo/.git/worktrees/worktree/reftable/tables.list &&
     ++	test_line_count = 3 repo/.git/reftable/tables.list &&
       	git -C repo pack-refs &&
      -	test_line_count = 3 repo/.git/worktrees/worktree/reftable/tables.list &&
     -+	test_line_count = 1 repo/.git/worktrees/worktree/reftable/tables.list &&
     ++	test_line_count = 4 repo/.git/worktrees/worktree/reftable/tables.list &&
       	test_line_count = 1 repo/.git/reftable/tables.list
       '
       
      @@ t/t0610-reftable-basics.sh: test_expect_success 'worktree: pack-refs in worktree packs worktree refs' '
     + 	test_when_finished "rm -rf repo worktree" &&
     + 	git init repo &&
       	test_commit -C repo A &&
     - 	git -C repo worktree add ../worktree &&
     +-	git -C repo worktree add ../worktree &&
     ++	GIT_TEST_REFTABLE_NO_AUTOCOMPACTION=true git -C repo worktree add ../worktree &&
     ++	GIT_TEST_REFTABLE_NO_AUTOCOMPACTION=true git -C worktree update-ref refs/worktree/per-worktree HEAD &&
       
      -	test_line_count = 3 repo/.git/worktrees/worktree/reftable/tables.list &&
      -	test_line_count = 4 repo/.git/reftable/tables.list &&
     -+	test_line_count = 1 repo/.git/worktrees/worktree/reftable/tables.list &&
     -+	test_line_count = 1 repo/.git/reftable/tables.list &&
     ++	test_line_count = 4 repo/.git/worktrees/worktree/reftable/tables.list &&
     ++	test_line_count = 3 repo/.git/reftable/tables.list &&
       	git -C worktree pack-refs &&
       	test_line_count = 1 repo/.git/worktrees/worktree/reftable/tables.list &&
      -	test_line_count = 4 repo/.git/reftable/tables.list
     -+	test_line_count = 1 repo/.git/reftable/tables.list
     ++	test_line_count = 3 repo/.git/reftable/tables.list
       '
       
       test_expect_success 'worktree: creating shared ref updates main stack' '
     + 	test_when_finished "rm -rf repo worktree" &&
     + 	git init repo &&
     + 	test_commit -C repo A &&
     ++	test_commit -C repo B &&
     + 
     + 	git -C repo worktree add ../worktree &&
     + 	git -C repo pack-refs &&
      @@ t/t0610-reftable-basics.sh: test_expect_success 'worktree: creating shared ref updates main stack' '
     + 	test_line_count = 1 repo/.git/worktrees/worktree/reftable/tables.list &&
     + 	test_line_count = 1 repo/.git/reftable/tables.list &&
       
     - 	git -C worktree update-ref refs/heads/shared HEAD &&
     +-	git -C worktree update-ref refs/heads/shared HEAD &&
     ++	GIT_TEST_REFTABLE_NO_AUTOCOMPACTION=true git -C worktree update-ref refs/heads/shared HEAD &&
       	test_line_count = 1 repo/.git/worktrees/worktree/reftable/tables.list &&
     --	test_line_count = 2 repo/.git/reftable/tables.list
     -+	test_line_count = 1 repo/.git/reftable/tables.list
     + 	test_line_count = 2 repo/.git/reftable/tables.list
       '
     - 
     - test_expect_success 'worktree: creating per-worktree ref updates worktree stack' '
 -:  ----------- > 3:  a23e3fc6972 reftable/segment: make segment end inclusive

-- 
gitgitgadget
