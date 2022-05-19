Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4ACDC433EF
	for <git@archiver.kernel.org>; Thu, 19 May 2022 17:53:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243477AbiESRxp (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 19 May 2022 13:53:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243574AbiESRx2 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 19 May 2022 13:53:28 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E0F820E
        for <git@vger.kernel.org>; Thu, 19 May 2022 10:52:42 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id j25so8230466wrc.9
        for <git@vger.kernel.org>; Thu, 19 May 2022 10:52:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=+d9ueZVxgPS7MGceLJz3X+PhY8DmVnxxI8LbKpkEpkc=;
        b=IaxTHMTieSlIBNfyTmbT5ZvL/YqBGnQiurh+OTdk4zU1dg2SnVPQDusecDmMUv694/
         /oYri0l/EtutQI5vik9wr7CzjXuXtzxPgB9yk+Zh7D0O3YmrCpWcWzivFaePaAD0Wmjk
         pNG2dLxJS/PiiMYLl0JYE7aG9O4leJ1K3zh1bkgXjppAXsERvhxHjqtxPVcHLcvoO88F
         lv6tyNSe0R/S5mv2xd9ajzzk2s1M+4xR86hZqo8Ii5qcBHjvyNFQdckl4IRVpsqET7rR
         JLHty1R5kaxsWRxvkwuZ9n1+z6gTAGDXGS65ugrMl5qJCa6ZAGp//0ILqHkX4vmtxYrn
         WvNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=+d9ueZVxgPS7MGceLJz3X+PhY8DmVnxxI8LbKpkEpkc=;
        b=7EjAWhvbijgIz3KjYsFmmfQx55WX85bSMZeOWvKym2chtl1EQX0hzfgU/gDccHRUld
         45dL2am7EKojEVF/G1qVtHUBjRVDJaVZAka+kFkRxQOFHJcuRCoNIhBQx8/9FNkHY192
         kyAMyIRNkL6ybAk8qhxokl5bG9pjOCr9Wrsg7Pv+V63L0wq+hTxQTmDG01cnhhBU+QUT
         NWjE4cGeEGznFyhqOpQWntbcXP5PsTtSfp85YctPUqYLx/CO4NMekyR5piraXQVR9tpt
         ZRHOtAZQ8gLHyPAuhFWhaomn+2RyW8kLPj2Wb6YtfZEcoWrOzJNfTcYYl6oOaaIR74SS
         W4Pw==
X-Gm-Message-State: AOAM5330XHvjNrLmpdnBM27Z592GmXRpkUi8YawGmVx7e+7uj+aC41Rq
        Xbqv6AuY40sTF4gOAUH9Ly367ISecBI=
X-Google-Smtp-Source: ABdhPJwe/ahUTgrk3kS/EH++JI1scYpBRxOmP+e7Agq8JMHRvVh1mbL8Eo3LYfNGL/rkpLcw8ijUHQ==
X-Received: by 2002:adf:f682:0:b0:20d:116f:2e05 with SMTP id v2-20020adff682000000b0020d116f2e05mr5094200wrp.169.1652982760285;
        Thu, 19 May 2022 10:52:40 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id q6-20020a1cf306000000b00397243d3dbcsm154703wmq.31.2022.05.19.10.52.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 May 2022 10:52:39 -0700 (PDT)
Message-Id: <pull.1208.v2.git.1652982758.gitgitgadget@gmail.com>
In-Reply-To: <pull.1208.git.1652724693.gitgitgadget@gmail.com>
References: <pull.1208.git.1652724693.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 19 May 2022 17:52:28 +0000
Subject: [PATCH v2 00/10] Sparse index: integrate with sparse-checkout
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, vdye@github.com, shaoxuan.yuan02@gmail.com,
        Derrick Stolee <derrickstolee@github.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This series is based on ds/sparse-colon-path.

This series integrates the 'git sparse-checkout' builtin with the sparse
index. This is the last integration that we fast-tracked into the
microsoft/git fork. After this, we have no work in flight that would
conflict with a Google Summer of Code project in this area.

The tricky part about the sparse-checkout builtin is that we actually do
need to expand the index when growing the sparse-checkout boundary. The
trick is to expand it only as far as we need it, and then ensure that we
collapse any removed directories before the command completes.

To do this, we introduce a concept of a "partially expanded" index. In fact,
we break the boolean sparse_index member into an enum with three states:

 * COMPLETELY_FULL (0): No sparse directories exist.

 * COMPLETELY_SPARSE (1): Sparse directories may exist. Files outside the
   sparse-checkout cone are reduced to sparse directory entries whenever
   possible.

 * PARTIALLY_SPARSE (2): Sparse directories may exist. Some file entries
   outside the sparse-checkout cone may exist. Running convert_to_sparse()
   may further reduce those files to sparse directory entries.

Most of the patches in this series focus on introducing this enum and
carefully converting previous uses of the boolean to use the enum. Some
additional work is required to refactor ensure_full_index() into a new
expand_to_pattern_list() method, as they are doing essentially the same
thing, but with different scopes.

The result is improved performance on the sparse-checkout builtin as
demonstrated in a new p2000-sparse-operations.sh performance test:


Test HEAD~1 HEAD
================

2000.24: git sparse-checkout ... (sparse-v3) 2.14(1.55+0.58) 1.57(1.03+0.53)
-26.6% 2000.25: git sparse-checkout ... (sparse-v4) 2.20(1.62+0.57)
1.58(0.98+0.59) -28.2%

The improvement here is less dramatic because the operation is dominated by
writing and deleting a lot of files in the worktree. A repeated no-op
operation such as git sparse-checkout set $SPARSE_CONE would show a greater
improvement, but is less interesting since it could gain that improvement
without satisfying the "hard" parts of this builtin.

I specifically chose how to update the tests in t1092 and p2000 to avoid
conflicts with Victoria's 'git stash' work.


Updates in v2
=============

 * Typo fixes.
 * Two patches are added to the start to (a) refactor existing sparse index
   content tests, and (b) add new sparse index content tests with additional
   scenarios.
 * Use NOT_MATCHED directly instead of implicitly allowing UNDECIDED when
   matching in cone mode.

Thanks, -Stolee

Derrick Stolee (10):
  t1092: refactor 'sparse-index contents' test
  t1092: stress test 'git sparse-checkout set'
  sparse-index: create expand_to_pattern_list()
  sparse-index: introduce partially-sparse indexes
  cache-tree: implement cache_tree_find_path()
  sparse-checkout: --no-sparse-index needs a full index
  sparse-index: partially expand directories
  sparse-index: complete partial expansion
  p2000: add test for 'git sparse-checkout [add|set]'
  sparse-checkout: integrate with sparse index

 builtin/sparse-checkout.c                |   8 +-
 cache-tree.c                             |  24 +++++
 cache-tree.h                             |   2 +
 cache.h                                  |  32 ++++--
 read-cache.c                             |   6 +-
 sparse-index.c                           | 126 ++++++++++++++++++++---
 sparse-index.h                           |  14 +++
 t/perf/p2000-sparse-operations.sh        |   1 +
 t/t1092-sparse-checkout-compatibility.sh |  95 +++++++++++++----
 unpack-trees.c                           |   4 +
 10 files changed, 265 insertions(+), 47 deletions(-)


base-commit: 124b05b23005437fa5fb91863bde2a8f5840e164
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1208%2Fderrickstolee%2Fsparse-index%2Fsparse-checkout-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1208/derrickstolee/sparse-index/sparse-checkout-v2
Pull-Request: https://github.com/gitgitgadget/git/pull/1208

Range-diff vs v1:

  -:  ----------- >  1:  f2960747ed8 t1092: refactor 'sparse-index contents' test
  -:  ----------- >  2:  5030eeecf4f t1092: stress test 'git sparse-checkout set'
  1:  f1194d56d33 !  3:  d15338573e5 sparse-index: create expand_to_pattern_list()
     @@ sparse-index.c: static int add_path_to_index(const struct object_id *oid,
       
      -void ensure_full_index(struct index_state *istate)
      +void expand_to_pattern_list(struct index_state *istate,
     -+			      struct pattern_list *pl)
     ++			    struct pattern_list *pl)
       {
       	int i;
       	struct index_state *full;
  2:  d394d0e20e8 =  4:  269c206c331 sparse-index: introduce partially-sparse indexes
  3:  c0e81be97aa =  5:  c977001c033 cache-tree: implement cache_tree_find_path()
  4:  d1fb2e0e0d3 =  6:  e42463de0d2 sparse-checkout: --no-sparse-index needs a full index
  5:  5c7546ab070 !  7:  346c56bf256 sparse-index: partially expand directories
     @@ sparse-index.c: static int add_path_to_index(const struct object_id *oid,
      -	ce = make_cache_entry(istate, mode, oid, base->buf, 0, 0);
      +		/*
      +		 * The path "{base}{path}/" is a sparse directory. Create the correct
     -+		 * name for inserting the entry into the idnex.
     ++		 * name for inserting the entry into the index.
      +		 */
      +		strbuf_setlen(base, base->len - 1);
      +	} else {
  6:  eba63cc12af !  8:  ed640e3645b sparse-index: complete partial expansion
     @@ sparse-index.c: void expand_to_pattern_list(struct index_state *istate,
      +		if (pl &&
      +		    path_matches_pattern_list(ce->name, ce->ce_namelen,
      +					      NULL, &dtype,
     -+					      pl, istate) <= 0) {
     ++					      pl, istate) == NOT_MATCHED) {
      +			set_index_entry(full, full->cache_nr++, ce);
      +			continue;
      +		}
  7:  2804326c8bb =  9:  089ab086f58 p2000: add test for 'git sparse-checkout [add|set]'
  8:  b8a349c6dee = 10:  ad9ed6973d5 sparse-checkout: integrate with sparse index

-- 
gitgitgadget
