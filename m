Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 438C93A1DC
	for <git@vger.kernel.org>; Fri, 29 Mar 2024 04:16:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711685818; cv=none; b=dHt6txsbBvqu9eJCHIZIkAqi0TIynGcAXVB0XVYXo0l88K7fMCV2iJRLjZGacTfxyld0uTK/gma+yZVnwE0P5MqisSrtyLx6Y/UYUqeRwX1OIZvDmg9l+DJ3+8ezMpyehjK2albyzatuM5mSfKWJo/WIX3wdNCBMirrFWDS1imw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711685818; c=relaxed/simple;
	bh=5uiYXQLF6e2y5TfesMqjBsWp/1LlpiafDd8vDUFEfnA=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:MIME-Version:
	 Content-Type:To:Cc; b=X8U8iOsUTizQp7MTrPxwZiu2ATJPjxNd1bW3BWDKsCb3b/H0UhYHPNT+YNSBbOPqhnhUVML63/Cg/+g5jhQcjS+KLI+sB3ERp4tRTF2Li7i98JiuwM2mkW5Slho0UugJfGwwjz75C3X5BrIozXCjOOxN47qc6/EvHDNB8LoAZ/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DsNM+s5f; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DsNM+s5f"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4148c6132b4so15411925e9.1
        for <git@vger.kernel.org>; Thu, 28 Mar 2024 21:16:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711685811; x=1712290611; darn=vger.kernel.org;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TN+XZbzxAns3GFdclWPW9igJmP7JEgkB+wRsk0nyNtI=;
        b=DsNM+s5f4IrJYQD3DVNGTrI7WxV9+IJntyasS5Q4BtYNmZaXie3ipTG2iPQ7HkVQDS
         0AzvL1ZWa3ejkle25MNQ2hwfJRt+CYAC/iv3Xhg4Dw9bdEgfc9UVqUsWjJLKSuWlpZN9
         nZwsjzcLc0TaYaR/y/iEQHZxVmm4ILHwQaPTV9Rkr0IBY7I1jxCktPiV2yj2Us73XhJg
         nG/Qojccewz4qkhC4XD4bNa1bBex3KV/T7foPA3+m0yRa0IULybTFKfLYmDDyg/kgkBW
         G6G7Qtb5tCu7joCuDNtBgpzzoc2ibuUMA2XjsgvE+Pj5fujmAy2f9HdsWL8VSu2pjhHW
         NJOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711685811; x=1712290611;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TN+XZbzxAns3GFdclWPW9igJmP7JEgkB+wRsk0nyNtI=;
        b=XWmk0sAKC4mazfulEVFvu4BKbYmMoABnOH13BDOU7R8kALnqvSDSN31Bf9NjuKzCso
         ICaTGQVzcgq/7avGKJ3pp9890rXNzB9YC6rUBthc4EupqSDmJ0buv/1L+Vz00bRuX/fR
         Xlt2uC8PbtEmUsDKGeeCyScP9y3qaO+IJx1n5o7/2Mp8WuHY/7amw4kj7gjaBvMqMjii
         NjrsmOC/0z/qXN6J0rk/+Z8Zb9VnT5uIA5i0ToIB5sIRmRb5dcUuxdvXqZ86NnopeL5F
         w/Fa0YP1XBBQF2NoAW2FXDkpoC15PfkMtB5AwsU+WnYqrVaiEMROE4BUFsn+D8u+0Sa9
         8fQw==
X-Gm-Message-State: AOJu0YwYVgjcciccq058dzyLhrI7vt0fzELUUKsBJB897gQRQWGfg5yY
	37yxTA4hDwiUq9YI1n26c8DorYtR9chf5htLpLDG4dXVRTyU0m6A5V7t+6Md
X-Google-Smtp-Source: AGHT+IEQQ7BEm/GFzyJiUPaMn4w1wB5aANl1NXw2vJvmPFPIRF2/MqseXiqJ+omSlItC/H0xxf0v5A==
X-Received: by 2002:a05:600c:3516:b0:414:7fcc:7106 with SMTP id h22-20020a05600c351600b004147fcc7106mr1082813wmq.4.1711685810568;
        Thu, 28 Mar 2024 21:16:50 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id l20-20020a05600c1d1400b004146a304863sm7352316wms.34.2024.03.28.21.16.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Mar 2024 21:16:50 -0700 (PDT)
Message-Id: <pull.1683.v3.git.1711685809.gitgitgadget@gmail.com>
In-Reply-To: <pull.1683.v2.git.1711060819.gitgitgadget@gmail.com>
References: <pull.1683.v2.git.1711060819.gitgitgadget@gmail.com>
From: "Justin Tobler via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 29 Mar 2024 04:16:46 +0000
Subject: [PATCH v3 0/3] reftable/stack: use geometric table compaction
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
    Karthik Nayak <karthik.188@gmail.com>,
    Justin Tobler <jltobler@gmail.com>

Hello again,

This is the third version my patch series that refactors the reftable
compaction strategy to instead follow a geometric sequence. Changes compared
to v2:

 * Added test to validate the GIT_TEST_REFTABLE_NO_AUTOCOMPACTION
   environment variable works as expected.
 * Added additional clarifying comments and examples to explain how the new
   compaction strategy works.
 * Removed outdated comment from stack_test.c test

Thanks for taking a look!

-Justin

Justin Tobler (3):
  reftable/stack: add env to disable autocompaction
  reftable/stack: use geometric table compaction
  reftable/stack: make segment end inclusive

 reftable/stack.c           | 124 ++++++++++++++++++-------------------
 reftable/stack.h           |   3 -
 reftable/stack_test.c      |  67 +++++---------------
 reftable/system.h          |   1 +
 t/t0610-reftable-basics.sh |  58 ++++++++++++-----
 5 files changed, 120 insertions(+), 133 deletions(-)


base-commit: c75fd8d8150afdf836b63a8e0534d9b9e3e111ba
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1683%2Fjltobler%2Fjt%2Freftable-geometric-compaction-v3
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1683/jltobler/jt/reftable-geometric-compaction-v3
Pull-Request: https://github.com/gitgitgadget/git/pull/1683

Range-diff vs v2:

 1:  cb6b152e5c8 ! 1:  2fdd8ea1133 reftable/stack: add env to disable autocompaction
     @@ reftable/stack.c: int reftable_addition_commit(struct reftable_addition *add)
      
       ## reftable/system.h ##
      @@ reftable/system.h: license that can be found in the LICENSE file or at
     - #include "strbuf.h"
     + #include "tempfile.h"
       #include "hash-ll.h" /* hash ID, sizes.*/
       #include "dir.h" /* remove_dir_recursively, for tests.*/
      +#include "parse.h"
       
       int hash_size(uint32_t id);
       
     +
     + ## t/t0610-reftable-basics.sh ##
     +@@ t/t0610-reftable-basics.sh: test_expect_success 'ref transaction: writes cause auto-compaction' '
     + 	test_line_count = 1 repo/.git/reftable/tables.list
     + '
     + 
     ++test_expect_success 'ref transaction: environment variable disables auto-compaction' '
     ++	test_when_finished "rm -rf repo" &&
     ++
     ++	git init repo &&
     ++	test_commit -C repo A &&
     ++	for i in $(test_seq 20)
     ++	do
     ++		GIT_TEST_REFTABLE_NO_AUTOCOMPACTION=true git -C repo update-ref branch-$i HEAD || return 1
     ++	done &&
     ++	test_line_count = 23 repo/.git/reftable/tables.list &&
     ++
     ++	git -C repo update-ref foo HEAD &&
     ++	test_line_count = 1 repo/.git/reftable/tables.list
     ++'
     ++
     + check_fsync_events () {
     + 	local trace="$1" &&
     + 	shift &&
 2:  def70084523 ! 2:  7e62c2286ae reftable/stack: use geometric table compaction
     @@ Commit message
      
          Instead, to avoid unbounded growth of the table list, the compaction
          strategy is updated to ensure tables follow a geometric sequence after
     -    each operation. This is done by walking the table list in reverse index
     -    order to identify the compaction segment start and end. The compaction
     -    segment end is found by identifying the first table which has a
     -    preceding table size less than twice the current table. Next, the
     -    compaction segment start is found iterating through the remaining tables
     -    in the list checking if the previous table size is less than twice the
     -    cumulative of tables from the segment end. This ensures the correct
     -    segment start is found and that the newly compacted table does not
     -    violate the geometric sequence.
     +    each operation by individually evaluating each table in reverse index
     +    order. This strategy results in a much simpler and more robust algorithm
     +    compared to the previous one while also maintaining a minimal ordered
     +    set of tables on-disk.
      
          When creating 10 thousand references, the new strategy has no
          performance impact:
     @@ reftable/stack.c: static int segment_size(struct segment *s)
      +	 * they are already valid members of the geometric sequence. Due to the
      +	 * properties of a geometric sequence, it is not possible for the sum of
      +	 * these tables to exceed the value of the ending point table.
     ++	 *
     ++	 * Example table size sequence requiring no compaction:
     ++	 * 	64, 32, 16, 8, 4, 2, 1
     ++	 *
     ++	 * Example compaction segment end set to table with size 3:
     ++	 * 	64, 32, 16, 8, 4, 3, 1
      +	 */
      +	for (i = n - 1; i > 0; i--) {
      +		if (sizes[i - 1] < sizes[i] * 2) {
     @@ reftable/stack.c: static int segment_size(struct segment *s)
       			break;
      +		}
      +	}
     -+
     + 
     +-		min_seg.start = prev;
     +-		min_seg.bytes += sizes[prev];
      +	/*
      +	 * Find the starting table of the compaction segment by iterating
      +	 * through the remaining tables and keeping track of the accumulated
     -+	 * size of all tables seen from the segment end table.
     ++	 * size of all tables seen from the segment end table. The previous
     ++	 * table is compared to the accumulated size because the tables from the
     ++	 * segment end are merged backwards recursively.
      +	 *
      +	 * Note that we keep iterating even after we have found the first
      +	 * starting point. This is because there may be tables in the stack
      +	 * preceding that first starting point which violate the geometric
      +	 * sequence.
     ++	 *
     ++	 * Example compaction segment start set to table with size 32:
     ++	 * 	128, 32, 16, 8, 4, 3, 1
      +	 */
      +	for (; i > 0; i--) {
      +		uint64_t curr = bytes;
      +		bytes += sizes[i - 1];
     - 
     --		min_seg.start = prev;
     --		min_seg.bytes += sizes[prev];
     ++
      +		if (sizes[i - 1] < curr * 2) {
      +			seg.start = i - 1;
      +			seg.bytes = bytes;
     @@ reftable/stack_test.c: static void test_reftable_stack_hash_id(void)
       static void test_suggest_compaction_segment(void)
       {
      -	uint64_t sizes[] = { 128, 64, 17, 16, 9, 9, 9, 16, 16 };
     +-	/* .................0    1    2  3   4  5  6 */
      +	uint64_t sizes[] = { 512, 64, 17, 16, 9, 9, 9, 16, 2, 16 };
     - 	/* .................0    1    2  3   4  5  6 */
       	struct segment min =
       		suggest_compaction_segment(sizes, ARRAY_SIZE(sizes));
      -	EXPECT(min.start == 2);
     @@ t/t0610-reftable-basics.sh: test_expect_success 'ref transaction: writes cause a
       
       	test_commit -C repo --no-tag B &&
       	test_line_count = 1 repo/.git/reftable/tables.list
     +@@ t/t0610-reftable-basics.sh: test_expect_success 'ref transaction: environment variable disables auto-compact
     + 	do
     + 		GIT_TEST_REFTABLE_NO_AUTOCOMPACTION=true git -C repo update-ref branch-$i HEAD || return 1
     + 	done &&
     +-	test_line_count = 23 repo/.git/reftable/tables.list &&
     ++	test_line_count = 22 repo/.git/reftable/tables.list &&
     + 
     + 	git -C repo update-ref foo HEAD &&
     + 	test_line_count = 1 repo/.git/reftable/tables.list
       '
       
      +test_expect_success 'ref transaction: alternating table sizes are compacted' '
 3:  a23e3fc6972 ! 3:  9a33914c852 reftable/segment: make segment end inclusive
     @@ Metadata
      Author: Justin Tobler <jltobler@gmail.com>
      
       ## Commit message ##
     -    reftable/segment: make segment end inclusive
     +    reftable/stack: make segment end inclusive
      
          For a reftable segment, the start of the range is inclusive and the end
          is exclusive. In practice we increment the end when creating the

-- 
gitgitgadget
