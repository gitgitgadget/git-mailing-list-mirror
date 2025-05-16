Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0B251A0BE1
	for <git@vger.kernel.org>; Fri, 16 May 2025 14:55:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747407337; cv=none; b=Bv2lD5JnhD6hAg2zEUCD2wh2ezPDDNNaSuKlLZxej+4AjFz2noUhPsBE6LOXIVlsRNaCJh3TZvs3wwyxlsRn0ZNYFow7ABN0XRcNSL1BbGRi1rce9rcGuysDuDfVA0M+CgtM4n6XRy8FZU8kXG8gzAgyoKsI3uqkTk+cSlYw4mI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747407337; c=relaxed/simple;
	bh=jjlfhbilG0Eu3Um3+8EOVBVQUq8OQARXHGZ6xYdzd4I=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=YBtcLQKTym+/t21kT+1Q8dt9Qnv1V3/VxMmHTwfPeqXzGvgBO94pf7/ix4aSNPdx+c4LtMzkcIFOxVL/ED5HYowvl3N+lKRk81Bw9okOgaFe1OGtN9c/qkw0YwYhFo3gLM9XoCSjTPy3BOAamUWeIHTsC3acgRbKLydC3F3kN+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fo8UqOD2; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fo8UqOD2"
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-3a363ccac20so311483f8f.2
        for <git@vger.kernel.org>; Fri, 16 May 2025 07:55:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747407333; x=1748012133; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=x64x4zjwhSoEOkFUFzukV+LW4RTFRfRPRSGdWUFuZCs=;
        b=fo8UqOD2m7qGc4x3kI5/4CHRLDulRXziQPeWhvD0+TUR6Z+UtBpZGYqFONpnqD54eW
         XOcQ0d0xOG1WlQtCAbgFHk6NF1O4Ln36CWM8zHlpqvxZy9qj0rsNIpGoC3uCoPOWdjJd
         kjAeIks4biSLao8mb5BBTQ4JpHmmob1q0cRpd5HThzDIAswimP1plf1Y6H0kNC1C/AKU
         aLMBu1xVPTtT7AEjXmuTcVxj0eKp2v/+2Jve79t3esPyDETqggkC5JOfvUMSKtdD2MjG
         Q43VPQ1+3Htlfn9NbYgTEjNwpYgjTPx9Syc7VMJ38wKx3h3/lLDzylpE7uttluHyMopF
         /fzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747407333; x=1748012133;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=x64x4zjwhSoEOkFUFzukV+LW4RTFRfRPRSGdWUFuZCs=;
        b=OjoZD7RvZWb5hB8WSIY/WVn/To1FMKDwISjf30Rtgw6ZifrlvsPhnM0dQmL4ni9gEp
         +w+67RVP2Zoxcxw6e1KATC3vcUDXsctWG8YXdNLFkDPLO2uAXbbaKwHmYTMcwBYENC3M
         X8BVU/5hE30V9QO3gWlt4mRPqq3XdeJZoyzGwl1L6nIPr6szEFQmnM3SFTOPU6mE30iQ
         hdFq64T4URoH7gDUda9idm2Ic++lJuGAXSHHx3b+yugMW9U9KEFceGCGC1Gqxw8VlisL
         z0ycrkP/xzDp5ujYkbrk+lwuAoPxKmuh2D3SCLzXGDB2ikNvcn25RtVK4M5UgpE8dvO0
         weVg==
X-Gm-Message-State: AOJu0Yz0/hilf7omU92ZtUMKBueDICdhUO7xgDZUhmiuaHPwbuZDut8g
	C4pu/5U7g2WFOybjDcAYWmMTYlQKFrvRuCYV8KWWJeoczpLzsFEaUtSKjpGsQw==
X-Gm-Gg: ASbGnctjR2e7HJmYkE6Sww4vP0pyfeyYMAljLVkXvI5NTuO6LIolFgYXHY0A65Is/E0
	nrHIKeFaRjmKST13cQ3TjolbHF7WjEy5v9ck+Db6lpHBpwhncW3D5UebZFW3QELgB/bbDVPe2yB
	98fcrAKv6UKhmRAVn8HyiJ9HP1ibP7g8oiEp6JqMrC5vuqch5ZYUq5FMgOcSLqk34BpQGbzFNdk
	nMxHgSasVjPDWrKL6KtI2EIoMICzxizTdaTExuO16bWIozl+n0ohItMB18IBp1x6grGokAFggsY
	bFqtHbx0gkq1yKbGNzGZlaUjp47ScxF47f1krUPMmMriTvK2cqRU
X-Google-Smtp-Source: AGHT+IEA6fio8sz0aLXt5OprYZFktYYU2bc63vaehqbF3GgJBRuCB2kJb0Nvv/KrGVBzQfmzpDqyDQ==
X-Received: by 2002:a5d:59ab:0:b0:3a2:2ea9:4378 with SMTP id ffacd0b85a97d-3a35c83a1fcmr3823369f8f.31.1747407332432;
        Fri, 16 May 2025 07:55:32 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a35ca8d035sm3129320f8f.97.2025.05.16.07.55.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 May 2025 07:55:31 -0700 (PDT)
Message-Id: <pull.1914.v2.git.1747407330.gitgitgadget@gmail.com>
In-Reply-To: <pull.1914.git.1746579320.gitgitgadget@gmail.com>
References: <pull.1914.git.1746579320.gitgitgadget@gmail.com>
From: "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 16 May 2025 14:55:26 +0000
Subject: [PATCH v2 0/4] Integrate the sparse index with 'git apply' and interactive add, checkout,
 and reset
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
Cc: gitster@pobox.com,
    newren@gmail.com,
    Phillip Wood <phillip.wood123@gmail.com>,
    Derrick Stolee <stolee@gmail.com>

The sparse index helps make some Git commands faster when using
sparse-checkout in cone mode. However, not all code paths are aware that the
index can have non-blob entries, so we are careful about rolling this
feature out gradually. The cost of this rollout is that some commands are
slower with the sparse index as they need to expand a sparse index into a
full index in memory, which requires parsing tree objects to construct the
full path list.

This patch series focuses on the 'git add -p' command, which is slow with
the sparse index for a couple of reasons, handled in the first two patches:

 1. 'git add -p' uses 'git apply' as a subcommand and 'git apply' needs
    integration with the sparse index. Luckily, we just need to add the repo
    setting and appropriate tests to confirm it behaves as expected.
 2. The interactive modes of 'git add' ('-p' and '-i') leave cmd_add()
    before the code that sets the repo setting to allow for a sparse index.
    Patch 2 fixes this and adds appropriate tests to confirm the behavior in
    a sparse-checkout.
 3. The interactive mode of 'git reset' leaves cmd_reset() before the code
    that sets the repo setting to allow for the sparse index.

A third patch adds a performance test to p2000-sparse-operations.sh to
confirm that we are getting the performance improvement we expect:

  Test                                      BASE  PATCH 1      PATCH 2      PATCH 3
  -------------------------------------------------------------------------------------
  2000.118: ... git add -p (full-v3)        0.79  0.79  +0.0%  0.82  +3.8%  0.82  +3.8%
  2000.119: ... git add -p (full-v4)        0.74  0.76  +2.7%  0.74  +0.0%  0.76  +2.7%
  2000.120: ... git add -p (sparse-v3)      1.94  1.28 -34.0%  0.07 -96.4%  0.07 -96.4%
  2000.121: ... git add -p (sparse-v4)      1.93  1.28 -33.7%  0.06 -96.9%  0.06 -96.9%
  2000.122: ... git checkout -p (full-v3)   1.18  1.18  +0.0%  1.18  +0.0%  1.19  +0.8%
  2000.123: ... git checkout -p (full-v4)   1.10  1.12  +1.8%  1.11  +0.9%  1.11  +0.9%
  2000.124: ... git checkout -p (sparse-v3) 1.31  0.11 -91.6%  0.11 -91.6%  0.11 -91.6%
  2000.125: ... git checkout -p (sparse-v4) 1.29  0.11 -91.5%  0.11 -91.5%  0.11 -91.5%
  2000.126: ... git reset -p (full-v3)      0.81  0.80  -1.2%  0.83  +2.5%  0.83  +2.5%
  2000.127: ... git reset -p (full-v4)      0.78  0.77  -1.3%  0.77  -1.3%  0.78  +0.0%
  2000.128: ... git reset -p (sparse-v3)    1.58  0.92 -41.8%  0.91 -42.4%  0.07 -95.6%
  2000.129: ... git reset -p (sparse-v4)    1.58  0.92 -41.8%  0.92 -41.8%  0.07 -95.6%



Updates in v2
=============

Thanks for the careful review from Elijah and the pointer from Phillip, we
have these changes:

 1. The tests no longer have different expansion behaviors for 'git add -p'
    and 'git add -i' due to partially-expanded indexes on disk.
 2. We now test 'git checkout -p' and 'git reset -p'.
 3. 'git reset -p' needed some changes to the builtin (similar to 'git add')
    to be fast.

Thanks, -Stolee

Derrick Stolee (4):
  apply: integrate with the sparse index
  git add: make -p/-i aware of sparse index
  reset: integrate sparse index with --patch
  p2000: add performance test for patch-mode commands

 builtin/add.c                            |   7 +-
 builtin/apply.c                          |   7 +-
 builtin/reset.c                          |   6 +-
 t/perf/p2000-sparse-operations.sh        |   3 +
 t/t1092-sparse-checkout-compatibility.sh | 151 +++++++++++++++++++++++
 5 files changed, 167 insertions(+), 7 deletions(-)


base-commit: 6c0bd1fc70efaf053abe4e57c976afdc72d15377
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1914%2Fderrickstolee%2Fapply-sparse-index-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1914/derrickstolee/apply-sparse-index-v2
Pull-Request: https://github.com/gitgitgadget/git/pull/1914

Range-diff vs v1:

 1:  0e6e199cd19 ! 1:  1adf81ecb2c apply: integrate with the sparse index
     @@ t/t1092-sparse-checkout-compatibility.sh: test_expect_success 'sparse-index is n
      +
      +	# Expands when using --index.
      +	ensure_expanded apply --index ../patch-outside &&
     ++
     ++	# Does not when index is partially expanded.
     ++	git -C sparse-index reset --hard &&
     ++	ensure_not_expanded apply --cached ../patch-outside &&
     ++
     ++	# Try again with a reset and collapsed index.
      +	git -C sparse-index reset --hard &&
     ++	git -C sparse-index sparse-checkout reapply &&
      +
     -+	# Does not expand when using --cached.
     -+	ensure_not_expanded apply --cached ../patch-outside
     ++	# Expands when index is collapsed.
     ++	ensure_expanded apply --cached ../patch-outside
      +'
      +
       test_expect_success 'advice.sparseIndexExpanded' '
 2:  63caae87634 ! 2:  0a2752721d0 git add: make -p/-i aware of sparse index
     @@ Commit message
      
          It turns out that control flows out of cmd_add() in the interactive
          cases before the lines that confirm that the builtin is integrated with
     -    the sparse index. We need to move that earlier to ensure it prevents a
     -    full index expansion on read.
     +    the sparse index.
      
     -    Add more test cases that confirm that these interactive add options work
     -    with the sparse index. One interesting aspect here is that the '-i'
     -    option avoids expanding the sparse index when a sparse directory exists
     -    on disk while the '-p' option does hit the ensure_full_index() method.
     -    This leaves some room for improvement, but this case should be atypical
     -    as users should remain within their sparse-checkout.
     +    Moving that integration point earlier in cmd_add() allows 'git add -p'
     +    and 'git add -p' to operate without expanding a sparse index to a full
     +    one.
     +
     +    Add test cases that confirm that these interactive add options work with
     +    the sparse index.
      
          Signed-off-by: Derrick Stolee <stolee@gmail.com>
      
     @@ t/t1092-sparse-checkout-compatibility.sh: test_expect_success 'add, commit, chec
       	init_repos &&
       
      @@ t/t1092-sparse-checkout-compatibility.sh: test_expect_success 'sparse-index is not expanded: git apply' '
     - 	ensure_not_expanded apply --cached ../patch-outside
     + 	ensure_expanded apply --cached ../patch-outside
       '
       
      +test_expect_success 'sparse-index is not expanded: git add -p' '
     @@ t/t1092-sparse-checkout-compatibility.sh: test_expect_success 'sparse-index is n
      +	git -C sparse-index reset &&
      +	ensure_not_expanded add -i <in &&
      +
     ++	# -p does expand when edits are outside sparse checkout.
      +	mkdir -p sparse-index/folder1 &&
      +	echo "new content" >sparse-index/folder1/a &&
     -+
     -+	# -p does expand when edits are outside sparse checkout.
      +	test_write_lines y n y >in &&
      +	ensure_expanded add -p <in &&
      +
     -+	# but -i does not expand.
     -+	git -C sparse-index reset &&
     ++	# Fully reset the index.
     ++	git -C sparse-index reset --hard &&
     ++	git -C sparse-index sparse-checkout reapply &&
     ++
     ++	# -i does expand when edits are outside sparse checkout.
     ++	mkdir -p sparse-index/folder1 &&
     ++	echo "new content" >sparse-index/folder1/a &&
      +	test_write_lines u 2 3 "" q >in &&
     -+	ensure_not_expanded add -i <in
     ++	ensure_expanded add -i <in
      +'
      +
       test_expect_success 'advice.sparseIndexExpanded' '
 -:  ----------- > 3:  d1482a29d8f reset: integrate sparse index with --patch
 3:  7a777281626 ! 4:  a50c57f7628 p2000: add performance test for 'git add -p'
     @@ Metadata
      Author: Derrick Stolee <dstolee@microsoft.com>
      
       ## Commit message ##
     -    p2000: add performance test for 'git add -p'
     +    p2000: add performance test for patch-mode commands
      
     -    The previous two changes contributed performance improvements to 'git
     -    apply' and 'git add -p' when using a sparse index. Add a performance
     -    test to demonstrate this (and to help validate that performance remains
     -    good in the future).
     +    The previous three changes contributed performance improvements to 'git
     +    apply', 'git add -p', and 'git reset -p' when using a sparse index. The
     +    improvement to 'git apply' also improved 'git checkout -p'. Add
     +    performance tests to demonstrate this (and to help validate that
     +    performance remains good in the future).
      
          In the truncated test output below, we see that the full checkout
          performance changes within noise expectations, but the sparse index
     -    cases improve 33% and then 96%.
     -
     -                          HEAD~3     HEAD~2         HEAD~1
     -    ---------------------------------------------------------
     -    2000.118: (full-v3)     0.80   0.84 +5.0%     0.84  +5.0%
     -    2000.119: (full-v4)     0.76   0.79 +3.9%     0.80  +5.3%
     -    2000.120: (sparse-v3)   2.09   1.39 -33.5%    0.07 -96.7%
     -    2000.121: (sparse-v4)   2.09   1.39 -33.5%    0.07 -96.7%
     +    cases improve 33% and then 96% for 'git add -p' and 41% and then 95% for
     +    'git reset -p'. 'git checkout -p' improves immediatley by 91% because it
     +    does not need any change to its builtin.
     +
     +      Test                                    HEAD~4  HEAD~3       HEAD~2       HEAD~1
     +      -------------------------------------------------------------------------------------
     +      2000.118: ... git add -p (full-v3)        0.79  0.79  +0.0%  0.82  +3.8%  0.82  +3.8%
     +      2000.119: ... git add -p (full-v4)        0.74  0.76  +2.7%  0.74  +0.0%  0.76  +2.7%
     +      2000.120: ... git add -p (sparse-v3)      1.94  1.28 -34.0%  0.07 -96.4%  0.07 -96.4%
     +      2000.121: ... git add -p (sparse-v4)      1.93  1.28 -33.7%  0.06 -96.9%  0.06 -96.9%
     +      2000.122: ... git checkout -p (full-v3)   1.18  1.18  +0.0%  1.18  +0.0%  1.19  +0.8%
     +      2000.123: ... git checkout -p (full-v4)   1.10  1.12  +1.8%  1.11  +0.9%  1.11  +0.9%
     +      2000.124: ... git checkout -p (sparse-v3) 1.31  0.11 -91.6%  0.11 -91.6%  0.11 -91.6%
     +      2000.125: ... git checkout -p (sparse-v4) 1.29  0.11 -91.5%  0.11 -91.5%  0.11 -91.5%
     +      2000.126: ... git reset -p (full-v3)      0.81  0.80  -1.2%  0.83  +2.5%  0.83  +2.5%
     +      2000.127: ... git reset -p (full-v4)      0.78  0.77  -1.3%  0.77  -1.3%  0.78  +0.0%
     +      2000.128: ... git reset -p (sparse-v3)    1.58  0.92 -41.8%  0.91 -42.4%  0.07 -95.6%
     +      2000.129: ... git reset -p (sparse-v4)    1.58  0.92 -41.8%  0.92 -41.8%  0.07 -95.6%
      
          It is worth noting that if our test was more involved and had multiple
          hunks to evaluate, then the time spent in 'git apply' would dominate due
     @@ t/perf/p2000-sparse-operations.sh: test_perf_on_all git diff-tree HEAD
       test_perf_on_all "git worktree add ../temp && git worktree remove ../temp"
       test_perf_on_all git check-attr -a -- $SPARSE_CONE/a
      +test_perf_on_all 'echo >>a && test_write_lines y | git add -p'
     ++test_perf_on_all 'test_write_lines y y y | git checkout --patch -'
     ++test_perf_on_all 'echo >>a && git add a && test_write_lines y | git reset --patch'
       
       test_done

-- 
gitgitgadget
