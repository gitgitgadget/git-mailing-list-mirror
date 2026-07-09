Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B396C394785
	for <git@vger.kernel.org>; Thu,  9 Jul 2026 12:08:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783598916; cv=none; b=AAIF38S5RNO7doyOTaZKCr75jb+cKGSjGM0LoO+1u4++U5ZvJtXc9zDa4DzSnRvX1Zs2fiAd/up0YCxNhRJ9psDFLT+R+JdFIn6yjTn+FMQ0GfnqZyDZQTOwgSYmu1fYjT9blm7eP3jQKSZVG3NVzE1CdgGqmZ8au/E3fucDQNc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783598916; c=relaxed/simple;
	bh=p+Z/9Lzeu5dQ8MlDHJOXy093GdO9Y+xVSNbtUP+64Ys=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=Dt5nDcSX1ogq0AAjmVIyMnaAG0+gedMgw1kDuo7CvGQ1LRNgf9zdfKFsvxe6MXkztGD/hqPwNzNxFTrSpmcEvilF6oVZC7ivB7uU1LLdCUW+V05nJ/2oiNEt0Jgz8Z4wf+CgRAOAT1I8YDPy5xkeB7ExLHNzuviWfQjah2BRJwA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=REoQ5iZ7; arc=none smtp.client-ip=209.85.222.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="REoQ5iZ7"
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-92e54f8c051so39811685a.3
        for <git@vger.kernel.org>; Thu, 09 Jul 2026 05:08:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783598914; x=1784203714; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=UNJSdgd93LCK/My8KlR7r4WWtOWmRf/ViY6TteBBc7c=;
        b=REoQ5iZ7AeKxki4GxH6co8vAHuOrhd6tYTfRvJlBU2nIshSofGMBWuIJmNqgUEk4Ek
         s5PYP8SAa0L9Lnnw7ZWpx6DwExllJL7ErLIgDaf24WItHN2SFDJjZaSBBR+KVf+9c+sI
         xwMeW9dnOcqIVsIe9GjDEPU3JzzJ0ke8q3EOBuJA8CZB2xDZqh0d2UiFWANMWCM943lb
         +oFdCBSdDToDZC70wPhDY2Kxd7VNK0IvrUZ/qy/zPDfJ9PpmOEa3LPWo671Lzo+Eu8Mx
         Z06cknRQkOx9E28wo3Tpcn4CyKFFyb65CUapABl30uAk0WM0cfiJ/KngQdYwHMFxaEv6
         SGSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783598914; x=1784203714;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=UNJSdgd93LCK/My8KlR7r4WWtOWmRf/ViY6TteBBc7c=;
        b=LjPfFKFPst1PMwQYjzaUDGp4fglc+9y7eAgNiyM16w3A1mp3lyOmR2HFSUwUdEKC0w
         duOI8LyDG5esurCyzVb2oMjYbMDsrmFoXcPjSuI4W0KT0xP9o/slErcVasuzjfi9WFKU
         KG97nHYAYho0EsbvLk+Xri4mb/ri7q5R3SJTJ7c3u2Z9NjK5V/i6kyvTy3W+d/mmJZPl
         bI/nXvViPPaIS++ya+ur/8lNMFrkwiEDrDwqg9f3ErhfrUTphgAWCbp1eP5pe3dO99tK
         ElCjDhb8rX0pjYF3qsKAIA8rFFK+oCoO/rOmgQA6WHF3nG6b42gv+z+wregEwOqcFY4V
         W0TA==
X-Gm-Message-State: AOJu0YxkqukYYrXijYuAiWewf0iL7Q1t7O9jUBrBEgEyJmV93Z5oirlX
	LcW5rSy9hJ2QIGoXmUfxGOQYcok/RAfRsYMW/QQrEHLfT9c9pOyQaw/Jl55R07oy
X-Gm-Gg: AfdE7ckFQEeXNg1kEcXPl3iFIuOJ4V7KxXJ6OfGIc6tquX198geuMCsXWAhG/ShpFPs
	0V0mqsiI1o8ZiFpy0c4bU8UnvhjIEr9hN9ALWDpZYibfQwu53y8a5bdVXtS0RxJ1hJWOtre4eCP
	jmWthk50FjMqUFDr/N+irsD1OLihr/EX3S7dxeo64bTWwPMPMff9wu3ZBADyZDzlzGaVt6Wh39/
	P+gltkpmv8To4Ak+eZkmCP7iLy631uiHt7+KU1aldTrZWOmkAUdSKzqYGvxYJ7Y9EK4vnOiDO7w
	A93oo4kZltR33jKY0u//Y3VNWQC4gEPrxhhsTTrgZEMqXkCTudRSwkryP6LHeFfIFzKgbTCUSTT
	uCqDDRWcY87XgLWwgyy396nd4ySQC/vI9wmAOuoDX7R1HcoaklVv5oZq25jRpeD+plfrMIfkYb4
	rMDi68i1ddCC2z3w==
X-Received: by 2002:a05:620a:450a:b0:92e:7b45:7690 with SMTP id af79cd13be357-92ecf611c3cmr709484785a.69.1783598913490;
        Thu, 09 Jul 2026 05:08:33 -0700 (PDT)
Received: from [127.0.0.1] ([40.79.247.66])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-92e90b7fc3asm1603104885a.9.2026.07.09.05.08.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jul 2026 05:08:32 -0700 (PDT)
Message-Id: <pull.2166.v2.git.1783598912.gitgitgadget@gmail.com>
In-Reply-To: <pull.2166.git.1783344957.gitgitgadget@gmail.com>
References: <pull.2166.git.1783344957.gitgitgadget@gmail.com>
From: "Kristofer Karlsson via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 09 Jul 2026 12:08:29 +0000
Subject: [PATCH v2 0/2] reftable: fix quadratic behavior when re-creating deleted refs
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
Cc: Kristofer Karlsson <krka@spotify.com>

This series fixes quadratic behavior in the reftable backend when many
tombstones are present. Any operation that seeks into a range containing
tombstones is affected, including ref lookups and D/F conflict checks.

The root cause is the merged iterator's suppress_deletions flag, which
silently consumes tombstone records in a tight internal loop. This prevents
higher-level code from checking iteration bounds until after all tombstones
have been scanned, making both refs_verify_refnames_available() and
reftable_backend_read_ref() O(n) per call in the presence of tombstones.

The fix stops setting suppress_deletions on the stack's merged table and
instead handles deletion records at each call site in the reftable backend,
where prefix and refname bounds are available. This lets existing bounds
checks terminate iteration early when encountering tombstones past the
relevant bound.

The suppress_deletions flag and its logic are retained in the merged
iterator for downstream users of the reftable library (e.g. libgit2).

The first patch adds a perf test (p1401) exercising two tombstone scenarios
with 8000 refs. The second patch is the optimization. Both p1401 tests go
from ~13s to ~0.2s with the fix.

Note that auto-compaction typically merges tombstones before they accumulate
to this degree, so the quadratic behavior may not show up in every workflow.
But the fix ensures correct time complexity regardless of compaction state,
and the change is fairly contained.

Changes since v1:

 * Keep suppress_deletions in the reftable library for downstream users;
   only stop setting it in stack.c
 * Broaden scope description to cover all readers, not just ref creation
 * Use separate repositories in perf test to avoid cross-scenario state
 * Drop correctness test (implicitly covered by t1400)

Previous discussion:
https://lore.kernel.org/git/20260701080014.GA3748390@coredump.intra.peff.net/

Kristofer Karlsson (2):
  t/perf: add perf test for ref tombstone scenarios
  reftable: fix quadratic behavior in the presence of tombstones

 refs/reftable-backend.c              | 54 ++++++++++++++++++++++------
 reftable/stack.c                     |  1 -
 t/perf/p1401-ref-store-tombstones.sh | 46 ++++++++++++++++++++++++
 3 files changed, 89 insertions(+), 12 deletions(-)
 create mode 100755 t/perf/p1401-ref-store-tombstones.sh


base-commit: f85a7e662054a7b0d9070e432508831afa214b47
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-2166%2Fspkrka%2Freftable-tombstone-perf-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-2166/spkrka/reftable-tombstone-perf-v2
Pull-Request: https://github.com/gitgitgadget/git/pull/2166

Range-diff vs v1:

 1:  d8ffdcb4f8 ! 1:  889d0d38bc t: add tests for ref tombstone scenarios
     @@ Metadata
      Author: Kristofer Karlsson <krka@spotify.com>
      
       ## Commit message ##
     -    t: add tests for ref tombstone scenarios
     +    t/perf: add perf test for ref tombstone scenarios
      
     -    Add a performance test and a correctness test for update-ref when
     -    many tombstones are present in a reftable.
     +    Add performance tests for update-ref when many tombstones are present
     +    in a reftable.
      
     -    The performance test (p1401) exercises two scenarios:
     +    The first test exercises the scenario where all refs are deleted
     +    (creating tombstones) and then re-created with the same names, which
     +    currently exhibits quadratic behavior.
      
     -     - All refs are deleted (creating tombstones) and then re-created
     -       with the same names, which currently exhibits quadratic behavior.
     -
     -     - An asymmetric variant where refs are deleted and then new,
     -       differently-named refs are created.  When the tombstones sort
     -       after the new refs, every create scans all tombstones, making
     -       this case even worse than re-creating the same refs.
     -
     -    The correctness test (t0610) verifies that refs deleted and then
     -    re-created with the same names are visible afterwards.
     +    The second test uses a separate repository with an asymmetric variant
     +    where refs are deleted and then new, differently-named refs are
     +    created.  When the tombstones sort after the new refs, every create
     +    scans all tombstones, making this case even worse than re-creating
     +    the same refs.
      
          Helped-by: Jeff King <peff@peff.net>
          Signed-off-by: Kristofer Karlsson <krka@spotify.com>
     @@ t/perf/p1401-ref-store-tombstones.sh (new)
      +'
      +
      +test_expect_success "setup asymmetric" '
     ++	git init --ref-format=reftable repo2 &&
     ++	blob=$(echo foo | git -C repo2 hash-object -w --stdin) &&
      +	for i in $(test_seq 8000)
      +	do
      +		printf "create refs/tags/old-%d %s\n" "$i" "$blob" ||
      +		return 1
     -+	done >repo/input-old &&
     -+	sed "s/old-/new-/" <repo/input-old >repo/input-new &&
     -+	git -C repo update-ref --stdin <repo/input-old &&
     -+	git -C repo for-each-ref --format="delete %(refname)" |
     -+	git -C repo update-ref --stdin
     ++	done >repo2/input-old &&
     ++	sed "s/old-/new-/" <repo2/input-old >repo2/input-new &&
     ++	git -C repo2 update-ref --stdin <repo2/input-old &&
     ++	git -C repo2 for-each-ref --format="delete %(refname)" |
     ++	git -C repo2 update-ref --stdin
      +'
      +
      +test_perf "create new refs after deleting differently-named refs" '
     -+	git -C repo update-ref --stdin <repo/input-new &&
     -+	git -C repo for-each-ref --format="delete %(refname)" |
     -+	git -C repo update-ref --stdin
     ++	git -C repo2 update-ref --stdin <repo2/input-new &&
     ++	git -C repo2 for-each-ref --format="delete %(refname)" refs/tags/ |
     ++	git -C repo2 update-ref --stdin
      +'
      +
      +test_done
     -
     - ## t/t0610-reftable-basics.sh ##
     -@@ t/t0610-reftable-basics.sh: test_expect_success 'writes do not persist peeled value for invalid tags' '
     - 	)
     - '
     - 
     -+test_expect_success 'delete and re-create refs with tombstones' '
     -+	test_when_finished "rm -rf repo" &&
     -+	git init repo &&
     -+	test_commit -C repo A &&
     -+	A=$(git -C repo rev-parse HEAD) &&
     -+	cat >input <<-EOF &&
     -+	create refs/tags/a $A
     -+	create refs/tags/b $A
     -+	create refs/tags/c $A
     -+	EOF
     -+	git -C repo update-ref --stdin <input &&
     -+
     -+	# delete all tags, leaving tombstones
     -+	git -C repo for-each-ref --format="delete %(refname)" refs/tags/ |
     -+	git -C repo update-ref --stdin &&
     -+
     -+	# re-create the same refs and verify they are visible
     -+	git -C repo update-ref --stdin <input &&
     -+	git -C repo tag -l >actual &&
     -+	test_line_count = 3 actual
     -+'
     -+
     - test_done
 2:  1459371d3a ! 2:  c13f15ddc2 reftable: fix quadratic behavior when re-creating deleted refs
     @@ Metadata
      Author: Kristofer Karlsson <krka@spotify.com>
      
       ## Commit message ##
     -    reftable: fix quadratic behavior when re-creating deleted refs
     +    reftable: fix quadratic behavior in the presence of tombstones
      
     -    When many refs are deleted and then re-created, update-ref exhibits
     -    quadratic behavior.  With 8000 refs deleted and re-created, the
     -    runtime is ~15s, quadrupling for each doubling of input size.
     +    When many tombstones are present in a reftable, operations that need
     +    to look up or iterate over refs exhibit quadratic behavior.  With
     +    8000 refs deleted and re-created, update-ref takes ~15s, quadrupling
     +    for each doubling of input size.
      
          The root cause is the merged iterator's suppress_deletions flag.
          When set, merged_iter_next_void() silently consumes tombstone records
     @@ Commit message
          prefix or refname comparisons) until after all tombstones have been
          scanned.
      
     -    This affects two code paths during ref creation:
     +    This affects any code path that seeks into a range containing
     +    tombstones, including:
      
           - refs_verify_refnames_available() seeks to "refs/tags/foo-1/" to
             check for D/F conflicts and must scan through all subsequent
     @@ Commit message
             found", because the merged iterator skips the matching tombstone
             and searches for the next live record.
      
     -    Fix this by removing suppress_deletions from the merged iterator and
     -    instead handling deletion records at each call site in the reftable
     -    backend, where prefix and refname bounds are available.  Tombstones
     -    are now returned to callers, which skip them after their existing
     -    bounds checks.  This allows iteration to terminate as soon as a
     -    tombstone past the relevant bound is encountered.
     +    Fix this by no longer setting suppress_deletions on the stack's
     +    merged table and instead handling deletion records at each call site
     +    in the reftable backend, where prefix and refname bounds are
     +    available.  Tombstones are now returned to callers, which skip them
     +    after their existing bounds checks.  This allows iteration to
     +    terminate as soon as a tombstone past the relevant bound is
     +    encountered.
     +
     +    The suppress_deletions flag and its logic in the merged iterator are
     +    retained for downstream users of the reftable library (e.g. libgit2).
      
          This also requires adding deletion checks to the log iteration paths,
          since suppress_deletions applied to both ref and log iterators.
     @@ refs/reftable-backend.c: static int reftable_be_fsck(struct ref_store *ref_store
       		case REFTABLE_REF_VAL2: {
       			struct object_id oid;
      
     - ## reftable/merged.c ##
     -@@ reftable/merged.c: struct merged_iter {
     - 	struct merged_subiter *subiters;
     - 	struct merged_iter_pqueue pq;
     - 	size_t subiters_len;
     --	int suppress_deletions;
     - 	ssize_t advance_index;
     - };
     - 
     -@@ reftable/merged.c: static int merged_iter_seek_void(void *it, struct reftable_record *want)
     - 
     - static int merged_iter_next_void(void *p, struct reftable_record *rec)
     - {
     --	struct merged_iter *mi = p;
     --	while (1) {
     --		int err = merged_iter_next_entry(mi, rec);
     --		if (err)
     --			return err;
     --		if (mi->suppress_deletions && reftable_record_is_deletion(rec))
     --			continue;
     --		return 0;
     --	}
     -+	return merged_iter_next_entry(p, rec);
     - }
     - 
     - static struct reftable_iterator_vtable merged_iter_vtable = {
     -@@ reftable/merged.c: int merged_table_init_iter(struct reftable_merged_table *mt,
     - 		goto out;
     - 	}
     - 	mi->advance_index = -1;
     --	mi->suppress_deletions = mt->suppress_deletions;
     - 	mi->subiters = subiters;
     - 	mi->subiters_len = mt->tables_len;
     - 
     -
     - ## reftable/merged.h ##
     -@@ reftable/merged.h: struct reftable_merged_table {
     - 	size_t tables_len;
     - 	enum reftable_hash hash_id;
     - 
     --	/* If unset, produce deletions. This is useful for compaction. For the
     --	 * full stack, deletions should be produced. */
     --	int suppress_deletions;
     --
     - 	uint64_t min;
     - 	uint64_t max;
     - };
     -
       ## reftable/stack.c ##
      @@ reftable/stack.c: static int reftable_stack_reload_once(struct reftable_stack *st,
       	/* Update the stack to point to the new tables. */

-- 
gitgitgadget
