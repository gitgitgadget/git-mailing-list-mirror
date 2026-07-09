Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22B3E351C30
	for <git@vger.kernel.org>; Thu,  9 Jul 2026 15:03:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783609387; cv=none; b=EDm7k+yIBIqfZ4hTB0PwU8Q68g/S+zSUVcaksmP/GYMrtZJyuGbtzslGXHzRZ5m9U91cDAKh1uu28jwQyFKj2fC2Xv0H7FwFj/phTNHxBfof989/W2NieIDzcb4wKjKGLEmGkN/NKSUr4VWTK+6m2BTojNOPipRKxup3ns7iduA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783609387; c=relaxed/simple;
	bh=7oVWjVhQZ9cbZEwP/jlmvfHtg4pddHi2Ee5GJgh2SlE=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=O9OOSiaPL/p+52ASQiWEb5xEVo1yPFXizH8Mmq3hEvyIg+N2HbGg8BZjLeumeSgM8V5UHK3vNBfrzWprw4b+uGDQx7/Fd9eK3q6BqGClRWLJLRoCk0dlp2yAyMGZY2BdXGMT4OeMvv6YcwvW7cZsaYJJYZoNh+wVCR10zMzVYeA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=D2oOYcNh; arc=none smtp.client-ip=209.85.219.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D2oOYcNh"
Received: by mail-qv1-f41.google.com with SMTP id 6a1803df08f44-8f1a8e914a9so15381716d6.1
        for <git@vger.kernel.org>; Thu, 09 Jul 2026 08:03:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783609385; x=1784214185; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=4MlbwsmAK/BEVu00vp2JKbeYbE0i/SXEROMMn/xLarE=;
        b=D2oOYcNhDdU80j8vL1OINyKv1fmSuwBa1HKBQqDTTujulYJ6McxlaSO+iUFk5qdpDv
         ojN3qJpiCG8zC3h2UQzBlPXX8MnX9SQiVydM7szJG3GzrUF0zYJEt04OC4Fg38kieeAR
         5jI1zCVZcPgfq/XttreWcs6Av7/9AheDwo9fvHmHmkFuC2I7mlaBxl9wDJtEri52blXj
         0/zZvn5wMfybCq/itBOfyQggY7ExOVuTyHQYy3stKOWZiW9CSKF+DGqjrLa7Qx+oLL11
         MIEQ8Aip+VDD5JNWwrXAMdGcK8HVSEJtL3aswwbBwIQe8BuQ4IhEgvQi7eYZU1L83341
         EJ2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783609385; x=1784214185;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=4MlbwsmAK/BEVu00vp2JKbeYbE0i/SXEROMMn/xLarE=;
        b=VsEgDdM1DhyD9Om1VuCZOwcxSeHsVx1O6BNWXap3Rip8PbdGBoI/jKa5iFiCjwzsLR
         kUwS4uvhVGwYU7n7a7IvSORAo/nM8+RD/KZpia+ASasfJd1PVDE7UrfOPTXMEmrW6GxP
         M5x62QQNfTIR/JxIlZ1TPeoC2KK5ESkMEW7gZ6I2zM+g9vwFVHn2Wi3zGIbO/omF7i6u
         +idYaQai7IvaSNlo9edwKcsXvDY8D268VjolntQK5f8cIiVmhybllykdxwU9pOTOQXpI
         3ZSW25uIzQtQCYJuh052vUvueYDvQ43XmrYbbqlgu+VZoJ2TyCM6YC5bdu4flUM01qOf
         sZlA==
X-Gm-Message-State: AOJu0YxxSper91CxR/BA/zuZMNb/v4x51rGJuWmW49yAhL1CTYQyi4P3
	6f6b9pz06/0ZuTOJTUqloBRFaNoGVbSW+rVlqnT3pKzJN7Zd9nfdLBMqQRAvzw==
X-Gm-Gg: AfdE7ckFL9Bry5nWZSf8C/0ySVOhJJeOSeum0sH1HdnqjCCkjopm5Jd/quqtaiWRc23
	ydN/AcKRf1U84vpmGM3YZS1nJrM5e/QmfiR+dzmvyH4zflVJC8cpJMCGZdcrsKplhlx58gEsgyS
	qPw5MTahe6JhLh+e2t6DiyV2r3wVTf04hibouaUsvFBr4bmoFZ02DWN+qZ+EqmQSYVmhuWednD3
	rO2p8HO32k0KzjHSsbTshtXfKNAJFLYAVlO3sHnScxJK0iRy1bocOZz/TjkvLA+pkiR/fM/vw0k
	XhRoBLm+Am+nF0mJbAdIxqvNvtO/Z6liLA6vZd306VFl50G31sCPnhfPbyyWs54+AjPWYecOmUH
	9N3xzJD3gTMfMlbMPXUmslxi3mpZiVDTxNTtdp5M3dZfmLlN5PNFWTCVCnIEUwYpTgDXRZ9IIUU
	2vEGSWGiYRZ8rqQfgvndX7TTq5xQ==
X-Received: by 2002:a05:6214:408:b0:8e9:d24:c21f with SMTP id 6a1803df08f44-8fec08ce49cmr85691736d6.14.1783609384446;
        Thu, 09 Jul 2026 08:03:04 -0700 (PDT)
Received: from [127.0.0.1] ([4.236.159.145])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8ffd50e10f4sm19511856d6.1.2026.07.09.08.03.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jul 2026 08:03:03 -0700 (PDT)
Message-Id: <pull.2170.v2.git.1783609382.gitgitgadget@gmail.com>
In-Reply-To: <pull.2170.git.1783418384.gitgitgadget@gmail.com>
References: <pull.2170.git.1783418384.gitgitgadget@gmail.com>
From: "Kristofer Karlsson via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 09 Jul 2026 15:02:59 +0000
Subject: [PATCH v2 0/2] commit-graph: fix topo_levels slab propagation regression
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
Cc: Taylor Blau <me@ttaylorr.com>,
    Kristofer Karlsson <krka@spotify.com>,
    Patrick Steinhardt <ps@pks.im>,
    Kristofer Karlsson <krka@spotify.com>

When fetch.writeCommitGraph is enabled (or git maintenance runs after
fetch), an incremental commit-graph write computes generation numbers for
the newly added commits. For commits already in the graph, their topo levels
should be read from the existing layers, making the DFS proportional to the
number of new commits.

199d452758 (commit-graph: return the prepared commit graph from
prepare_commit_graph(), 2025-09-04), part of the ps/commit-graph-via-source
series [1], refactored the loop that propagates the topo_levels slab to each
layer of the commit-graph chain. The original code used a single variable
that advanced through the chain:

while (g) {
    g->topo_levels = &topo_levels;
    g = g->base_graph;
}


The refactored code introduced a separate iteration variable but did not
update the loop body to match:

for (struct commit_graph *chain = g; chain; chain = chain->base_graph)
    g->topo_levels = &topo_levels;


This always assigns to the topmost layer instead of the current one. Commits
from lower layers appear to have no generation numbers, so the DFS re-walks
the entire ancestry.

On a repo with a multi-layer split commit-graph, an incremental commit-graph
write triggered by git fetch drops from ~3.5 seconds to ~0.2 seconds after
the fix.

[1]
https://lore.kernel.org/git/aMNTELw0Wk8jWoPc@nand.local/T/#mb55b5f0e1ccf82d969ac1d8144c56ecf87b833e8

Changes since v1:

 * Fixed wrong commit title and date in the reference (Junio, Taylor).
 * use test_expect_failure with the correct assertion instead of a # BUG
   comment (Taylor).
 * Simplified commit messages.

Kristofer Karlsson (2):
  commit-graph: add trace2 instrumentation for generation DFS
  commit-graph: propagate topo_levels slab to all chain layers

 commit-graph.c                |  7 ++++++-
 t/t5324-split-commit-graph.sh | 24 ++++++++++++++++++++++++
 2 files changed, 30 insertions(+), 1 deletion(-)


base-commit: f85a7e662054a7b0d9070e432508831afa214b47
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-2170%2Fspkrka%2Fkrka%2Ffix-topo-levels-slab-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-2170/spkrka/krka/fix-topo-levels-slab-v2
Pull-Request: https://github.com/gitgitgadget/git/pull/2170

Range-diff vs v1:

 1:  b865c2bcff ! 1:  100efa22a9 commit-graph: add trace2 instrumentation for generation DFS
     @@ Metadata
       ## Commit message ##
          commit-graph: add trace2 instrumentation for generation DFS
      
     -    Add a step counter and trace2_data_intmax call to
     -    compute_reachable_generation_numbers() to make the cost of
     -    the generation number DFS observable.  This exposes a
     -    regression introduced in 199d452758 (commit-graph: fix
     -    "filling in" topological levels, 2025-04-07) where
     -    incremental commit-graph writes re-walk the entire commit
     -    ancestry instead of reading topo levels from lower graph
     -    layers.
     +    Count the number of steps taken in
     +    compute_reachable_generation_numbers() and expose it via
     +    trace2 to make it easier to detect performance regressions.
      
     -    Add a test that demonstrates the problem: with a two-layer
     -    split commit-graph, writing a new incremental layer for a
     -    commit whose parent is in the base layer walks all the way
     -    down to the root (7 steps for 5 base commits) instead of
     -    reading the existing topo level and stopping immediately
     -    (1 step).
     +    Add a failing test for such a regression, introduced in
     +    199d452758 (commit-graph: return the prepared commit graph
     +    from `prepare_commit_graph()`, 2025-09-04), where incremental
     +    commit-graph writes do not see existing generation numbers
     +    from lower graph layers and fall back to walking the full
     +    ancestry.
      
          Signed-off-by: Kristofer Karlsson <krka@spotify.com>
      
     @@ t/t5324-split-commit-graph.sh: test_expect_success 'write generation data chunk
       	)
       '
       
     -+test_expect_success 'incremental write reads topo levels from all layers' '
     ++test_expect_failure 'incremental write reads topo levels from all layers' '
      +	git init topo-from-lower &&
      +	(
      +		cd topo-from-lower &&
     @@ t/t5324-split-commit-graph.sh: test_expect_success 'write generation data chunk
      +		GIT_TRACE2_EVENT="$(pwd)/trace.txt" \
      +			git commit-graph write --reachable --split=no-merge &&
      +
     -+		# BUG: topo levels from lower graph layers are not
     -+		# propagated, so the DFS re-walks from base-3 down to
     -+		# the root (7 steps) instead of reading topo levels
     -+		# from the existing graph (1 step).
     -+		test_trace2_data commit-graph generation-dfs-steps 7 <trace.txt
     ++		test_trace2_data commit-graph generation-dfs-steps 1 <trace.txt
      +	)
      +'
      +
 2:  f9c1482a76 ! 2:  679dd2e392 commit-graph: propagate topo_levels slab to all chain layers
     @@ Metadata
       ## Commit message ##
          commit-graph: propagate topo_levels slab to all chain layers
      
     -    Fix a regression introduced in 199d452758 (commit-graph: fix
     -    "filling in" topological levels, 2025-04-07) where the loop
     -    propagating the topo_levels slab to each layer of the
     -    commit-graph chain always assigned to `g->topo_levels`
     -    (the topmost layer) instead of `chain->topo_levels` (the
     -    current iteration variable).
     +    The topo_levels slab is only propagated to the topmost graph
     +    layer instead of all layers in the chain.  Commits from lower
     +    layers appear to have no generation numbers, so the DFS
     +    re-walks the entire ancestry.
      
     -    This meant only the topmost layer had its topo_levels pointer
     -    set.  When compute_reachable_generation_numbers() ran for an
     -    incremental write, commits parsed from lower layers had their
     -    topo levels left at zero in the slab, since
     -    fill_commit_graph_info() could not store them without the
     -    pointer.  The DFS then re-walked the entire commit ancestry
     -    instead of stopping at commits with known levels.
     -
     -    On a repository with 2.78M commits and a multi-layer split
     -    commit-graph, this caused a single incremental commit-graph
     -    write to spend ~3.7 seconds in the generation DFS instead of
     -    microseconds.
     +    Fix by making topo_levels visible to all layers, not just
     +    the first one.
      
          Signed-off-by: Kristofer Karlsson <krka@spotify.com>
      
     @@ commit-graph.c: int write_commit_graph(struct odb_source *source,
       		ctx.changed_paths = 1;
      
       ## t/t5324-split-commit-graph.sh ##
     -@@ t/t5324-split-commit-graph.sh: test_expect_success 'incremental write reads topo levels from all layers' '
     - 		GIT_TRACE2_EVENT="$(pwd)/trace.txt" \
     - 			git commit-graph write --reachable --split=no-merge &&
     - 
     --		# BUG: topo levels from lower graph layers are not
     --		# propagated, so the DFS re-walks from base-3 down to
     --		# the root (7 steps) instead of reading topo levels
     --		# from the existing graph (1 step).
     --		test_trace2_data commit-graph generation-dfs-steps 7 <trace.txt
     -+		test_trace2_data commit-graph generation-dfs-steps 1 <trace.txt
     +@@ t/t5324-split-commit-graph.sh: test_expect_success 'write generation data chunk when commit-graph chain is repl
       	)
       '
       
     +-test_expect_failure 'incremental write reads topo levels from all layers' '
     ++test_expect_success 'incremental write reads topo levels from all layers' '
     + 	git init topo-from-lower &&
     + 	(
     + 		cd topo-from-lower &&

-- 
gitgitgadget
