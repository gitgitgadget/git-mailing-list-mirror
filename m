Received: from mail-vs1-f47.google.com (mail-vs1-f47.google.com [209.85.217.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C14B0226D05
	for <git@vger.kernel.org>; Mon,  1 Jun 2026 16:13:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780330406; cv=none; b=PbxgRmbevoF3m5gO9Ji4aUUblG2HjJKawK21IKeJpcN+gmGYtHTMQGkQP5tyP+sCfdTNjXdWiEwiTaVncSWFnEMY8grnV0r+ofHbBXsivSWCLvgPKa00LRg1H8qefBe6UTQpUAccj4ICbb4bNDgKzjFNwggQtaWeRAOctiN+gN0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780330406; c=relaxed/simple;
	bh=FedJ5pRZXUGlgKZl2VThdWD3tF0EHsy6AzBNUF3kSvk=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=C3ABm+9I+uK4ebic5cWKLgzAdJ2zgII5M8UITIb7CCEF+iVirLPEtgVPowFnZZX6/oON2qIaYorAKhHWDm1g+y+5T5QW169qEjQIfzmtMTPT5Npg1fXg7mCXyCY9oOKsOznPl2HtfRL86LeFFau/OmjSfgoy2o98XEeLYRH+IZs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K8VVu0xr; arc=none smtp.client-ip=209.85.217.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K8VVu0xr"
Received: by mail-vs1-f47.google.com with SMTP id ada2fe7eead31-6c25b040555so2250187137.1
        for <git@vger.kernel.org>; Mon, 01 Jun 2026 09:13:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780330404; x=1780935204; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ijtbdvqzL62/8i9TVVWikZMRCduJzMHQs/TmlonlArk=;
        b=K8VVu0xrnPeP4w56qsFVWkp3e8KKIpswILpmHIrXk1Et+vryf6AjtQ4HgreybNSqmR
         pFj882VW2yLw1iGbbmwTaL6QCCz6fCfDBle5+CM1JmxtqxSe55r5sNDoaG5v7/CPJFYq
         pupMMjmuLaC+MpNTO+cTVKbl9plolx480xg8zMtwm6i7+XkUwiPNrZkQyoc0JcrMXbgu
         3NsU/DUjXQfNWb5/2X8BTF5Fi00riW8rHbonA73+WKxgRHYyEc+t4XHAl2OeKG6XyjDn
         kVYqi4b7/eNIYWJcn9+FNDWhcGxgRZIciRlf8xKePZPpN8p6KUwyMSIf7+1Ln8pY4sjU
         1A0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780330404; x=1780935204;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ijtbdvqzL62/8i9TVVWikZMRCduJzMHQs/TmlonlArk=;
        b=VMYLWgpS7PxruQIgJTPCPqZx6xyhB9k4ADibbK9XFLWsH970fQAIPNlIuK5DUzDWZ9
         rboE6ba1Txdd/HtkuX7iJ5dIB85XGVMK860qKXTPdi8Dhck0EEww90yGYLkY4qBS/wJ0
         5+QJxTTSIluRGD+3Mw1TyJzlAL72nJyqehYxDD8SHiOOO9+iSNsifJh0GzMxM2q5Uq9G
         Gh2oCuPLD6EceiMgol/Ezpxq0soSvD8VgH7Ph7KGTP/17yQTtH9Kkm+FbUKLPlvcjtP0
         WgEoQ5kMp22jxwOl7opzIohhJVkc6apy4h6bmtQuf28bZ8UOS4VHjlceBhd7UjYMXuzk
         zubw==
X-Gm-Message-State: AOJu0YxE5ib9Y4fqakXoLcv5BZ+0W12DYWqVCb0Qg0v4cTSwytaQGcMz
	YiN8iRI/rMjD2UF2ZUFIXib9tSRHE8zJBFD5O/x9AgbEDyXupAcVzL04GnKsRg==
X-Gm-Gg: Acq92OFfYMY8gaJ7FO3o951XYivnYek4b3wbAia7a1hwTmv+1Fjpb6P1WZJ1Lu/Kz2q
	fgOPuGEsbEV2ddFn3GQf+VNAzhOn4ys6cwpSZteyt45HVSdPyHyqdfFNaHgLG12sc0WjP3mK6S/
	THGQ5nt2b6R1rf+kvfLw5ZqlPFzwkB+yq8hXGouvIFyTcerM2WH+Sadn3cw8uwe5e3qpe3gfoHJ
	RtGUYBOU/Y9cfvI0LEMkJlUD3AQWJLxXXHbCyfFS6uReiga2p8vCS9zbJoMw+TmmnymzlM2GEG7
	wX9wX7wERu245Tl1lXucxn67wYqC1YtuMI90y0g6Yw4BMMMvlAPjaCk2ktWHZlCdcsqlJRfEwAX
	7iA97wLVfghyOb9gHE1NJjUQh4zIovtn5oI5OcAnHc5eFs4fccNqkBzsU30G6IQFsIskd6ilQLO
	BGSd4l/vjBX9VCh2ye6MVBAIOoV4fx2zxCMWljHNMMhPaM6i0D
X-Received: by 2002:a05:6102:9d0:b0:607:95f4:53b5 with SMTP id ada2fe7eead31-6c6771bb25cmr5323499137.4.1780330403504;
        Mon, 01 Jun 2026 09:13:23 -0700 (PDT)
Received: from [127.0.0.1] ([172.203.30.208])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-9156f657240sm134663985a.22.2026.06.01.09.13.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jun 2026 09:13:22 -0700 (PDT)
Message-Id: <pull.2131.v2.git.1780330402264.gitgitgadget@gmail.com>
In-Reply-To: <pull.2131.git.1780070763044.gitgitgadget@gmail.com>
References: <pull.2131.git.1780070763044.gitgitgadget@gmail.com>
From: "Arijit Banerjee via GitGitGadget" <gitgitgadget@gmail.com>
Date: Mon, 01 Jun 2026 16:13:21 +0000
Subject: [PATCH v2] index-pack: retain child bases in delta cache
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
Cc: =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason <avarab@gmail.com>,
    Junio C Hamano <gitster@pobox.com>,
    Derrick Stolee <stolee@gmail.com>,
    Arijit Banerjee <arijit91@gmail.com>,
    Arijit Banerjee <arijit@effectiveailabs.com>

From: Arijit Banerjee <arijit@effectiveailabs.com>

When resolving a delta whose result has children of its own,
index-pack adds the result to work_head, accounts its data in
base_cache_used, and calls prune_base_data(). It then immediately frees
that same data.

This bypasses the existing delta base cache policy and can force later
descendants to reconstruct the queued base again. Let the existing
delta_base_cache_limit pruning policy decide whether to keep or evict
the data instead.

This does not add a new cache or increase the cache limit. The object
data is already accounted in base_cache_used before prune_base_data()
runs, and the existing pruning and base cleanup paths still release it.

On a quiet Ubuntu 24.04 VM with 16 vCPUs, 32 GiB RAM, and local SSD,
direct index-pack timings on single-pack Linux fixtures improved as
follows:

  linux blobless: 69.17s -> 57.98s (16.2% faster), RSS flat
  linux full:     280.72s -> 236.32s (15.8% faster), RSS +1.9%

Five-repeat medians on public repositories also improved:

  git.git:  12.31s -> 10.70s (13.1% faster)
  libgit2:   3.35s ->  2.88s (14.0% faster)
  redis:     6.52s ->  5.64s (13.5% faster)
  cpython:  33.02s -> 31.44s (4.8% faster)

The standard p5302 perf test on a smaller git.git fixture was neutral:

  5302.9 index-pack default threads:
    11.21(38.07+1.33) -> 11.16(37.90+1.31), -0.4%

t/t5302-pack-index.sh passed, and GitGitGadget's linux-leaks CI also
exercised that test under SANITIZE=leak.

Signed-off-by: Arijit Banerjee <arijit@effectiveailabs.com>
---
    index-pack: retain child bases in delta cache
    
    Speed up the local pack indexing phase of clone/fetch for large
    delta-compressed packs by keeping reconstructed delta bases available
    for reuse when they are queued for later delta resolution.
    
    When index-pack reconstructs a child base and queues it for resolving
    descendant deltas, it currently frees that data immediately. This can
    force the same base to be reconstructed again. Instead, keep it in the
    existing delta base cache and let the existing delta_base_cache_limit
    policy decide whether to retain or evict it.
    
    This does not add a new cache or increase the cache limit. The object
    data is already accounted in base_cache_used, and prune_base_data() is
    already called at this point.
    
    Correctness:
    
     * t/t5302-pack-index.sh passed all 36 tests.
    
    Benchmarks on a quiet Ubuntu 24.04 VM, 16 vCPU, 32 GiB RAM, local SSD:
    
    pack baseline patched wall-time change RSS change linux blobless 69.17s
    57.98s 16.2% faster -0.0% linux full 280.72s 236.32s 15.8% faster +1.9%
    
    Five-repeat public-repo medians also improved: git.git 13.1%, libgit2
    14.0%, redis 13.5%, cpython 4.8%.
    
    Perf on the linux blobless pack showed the same direction under
    profiling: 76.64s baseline vs 61.09s patched, with similar RSS.

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-2131%2Farijit91%2Findex-pack-retain-child-base-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-2131/arijit91/index-pack-retain-child-base-v2
Pull-Request: https://github.com/gitgitgadget/git/pull/2131

Range-diff vs v1:

 1:  cafb1700be ! 1:  42eca38f51 index-pack: retain child bases in delta cache
     @@ Commit message
      
          When resolving a delta whose result has children of its own,
          index-pack adds the result to work_head, accounts its data in
     -    base_cache_used, and calls prune_base_data(). It then immediately
     -    frees that same data.
     +    base_cache_used, and calls prune_base_data(). It then immediately frees
     +    that same data.
      
          This bypasses the existing delta base cache policy and can force later
          descendants to reconstruct the queued base again. Let the existing
          delta_base_cache_limit pruning policy decide whether to keep or evict
          the data instead.
      
     +    This does not add a new cache or increase the cache limit. The object
     +    data is already accounted in base_cache_used before prune_base_data()
     +    runs, and the existing pruning and base cleanup paths still release it.
     +
     +    On a quiet Ubuntu 24.04 VM with 16 vCPUs, 32 GiB RAM, and local SSD,
     +    direct index-pack timings on single-pack Linux fixtures improved as
     +    follows:
     +
     +      linux blobless: 69.17s -> 57.98s (16.2% faster), RSS flat
     +      linux full:     280.72s -> 236.32s (15.8% faster), RSS +1.9%
     +
     +    Five-repeat medians on public repositories also improved:
     +
     +      git.git:  12.31s -> 10.70s (13.1% faster)
     +      libgit2:   3.35s ->  2.88s (14.0% faster)
     +      redis:     6.52s ->  5.64s (13.5% faster)
     +      cpython:  33.02s -> 31.44s (4.8% faster)
     +
     +    The standard p5302 perf test on a smaller git.git fixture was neutral:
     +
     +      5302.9 index-pack default threads:
     +        11.21(38.07+1.33) -> 11.16(37.90+1.31), -0.4%
     +
     +    t/t5302-pack-index.sh passed, and GitGitGadget's linux-leaks CI also
     +    exercised that test under SANITIZE=leak.
     +
          Signed-off-by: Arijit Banerjee <arijit@effectiveailabs.com>
      
       ## builtin/index-pack.c ##


 builtin/index-pack.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/builtin/index-pack.c b/builtin/index-pack.c
index cf0bd8280d..027c64b522 100644
--- a/builtin/index-pack.c
+++ b/builtin/index-pack.c
@@ -1212,7 +1212,6 @@ static void *threaded_second_pass(void *data)
 			list_add(&child->list, &work_head);
 			base_cache_used += child->size;
 			prune_base_data(NULL);
-			free_base_data(child);
 		} else if (child) {
 			/*
 			 * This child does not have its own children. It may be

base-commit: c69baaf57ba26cf117c2b6793802877f19738b0d
-- 
gitgitgadget
