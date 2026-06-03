Received: from mail-dy1-f170.google.com (mail-dy1-f170.google.com [74.125.82.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B012328E0
	for <git@vger.kernel.org>; Wed,  3 Jun 2026 00:05:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780445123; cv=none; b=KW3L4GkDI/Q6runom50r3ORIIop+c1xAuVSEYzZsBZkC6iXSL9peiu8Ph34K/e45FY06xPbG70NyPKUkCCoVUK9Cq4a/t011N+XUxprMhFBdmpcUQmpRcCCHQU7wIGDihd3qe+PkkDLu+xNPIat2SGDaWYMXq1N/u/MuhKgPanE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780445123; c=relaxed/simple;
	bh=r/Ofs9xAWQ7ejgfLl8KPS6M3VZzxmsVzj257eXuTgzg=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=qy/8vDtotMMbr6qDripQcxX5Z8EswzOI7gzDoQs4XkmAaBqujOhHOAgz2OOubm2APImszbp5PeGn/PVc+Ljtg19dNY3KJgKuGGgJMYi07HSC4IiDAJ9WDKk7ICDr+b7MoIfWfooOmmgj6h8cqkG35aFWUbKkcaheEK+jMLw9JcQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VSBGJTo4; arc=none smtp.client-ip=74.125.82.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VSBGJTo4"
Received: by mail-dy1-f170.google.com with SMTP id 5a478bee46e88-304d7f31215so5892906eec.1
        for <git@vger.kernel.org>; Tue, 02 Jun 2026 17:05:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780445121; x=1781049921; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=a7NVOFVFcluB/oqnuSao8moXbiI9IAz7C7277dagefU=;
        b=VSBGJTo4XPSkolHKyYQqjAV8b1ZL+JWDJ9nm/Krl38yjuWiMBjZv2jKWoh2CZwCB5S
         lTFAJqVTCZlRBATqlbvO7pOe/R9sH/5hZDgcAigBqv+gx2zuenLEjZOkr0e+p3ILHkcI
         Y2aOvxGYoJUl7gaaG2g7CQQ7dFGaGMI+sGRur9s03FOsfYslJU+Yc/j7ueKwCKavzdPF
         i06sfbYBqh1SJub6TmjYZNZNak/kH/fujXIBNsO7ly9dIsgUfMy00/9uV0inuxYGwAft
         fQs1gsFlBMtoQ5gnVMUd2d/PdjbFsQGVewVJeXBZPID3vivdhCUGBX9XGmZWesrcGMJD
         Wgsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780445121; x=1781049921;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=a7NVOFVFcluB/oqnuSao8moXbiI9IAz7C7277dagefU=;
        b=qrz8RTHTNXMitDp3iVPnALBDACy2/eSiE/GTXip+36wEOyM8VSWNkd284rs7RL9Fmx
         nTqSom5PE9QiK95Im3O0AJgNcVmcceEuphb+gillcIbW+nWhOrfqWcnkivMpztSMQg/b
         roDtVrjmL/P4XCuIXUxdlhZJYt+WUGDcjUUmi8N4W2FqYOy7N/bqecK6oHQ1IFYdEXko
         XqMv1+K84dkWwX3Ct1sL5oTJZNPvqr9FPbbNvyDBz7idHSYfCR9HSTV0TMohoWSgk5gZ
         5fly0ytw99lAcyWY50Ld3SDM2TeWxLCUJnvjm+Cr/SwdyB8RTw6F5dDAMr9Q3TeUt+cA
         cPDA==
X-Gm-Message-State: AOJu0Yx+Odq8ZGE7jIjYsf86uvsAiAExV/I+l73eP51sMgHPbm9jY1ob
	rIs4fdYbAm0kr07jKisyxQbuJiL4iE7u0smJo1Hz0I58rot8VMVtR6DAV545ew==
X-Gm-Gg: Acq92OHK8o+WsoE03KlOnnqHKAPl7yESQim5XN6m7bWXnP57eRNkOnLpxr3PqxsAZiE
	m0keufvKoJ+8dVc/zsgahTM7HQfajx6ylZZ+5T2s6FeZXMykXnxFujGRo7ECsj5fKCUNNYG42Pv
	4hnnv1xqknc2qDXFX+4gHmGEdwTZLsrS+Sap3/ODyLDBShZUM24lwfBWoGrJQrsT29SF6yZs1y0
	VmvLi77659m1SzrYDWDRSP2ZoIpfCl03wda2AH7j6PtQgVRyORCu1Zj76R2G1U91ofNi30KHTqa
	xOwfUVi3lokflzgvCCjZ1VXHGpg4i3rkwLwBcmDUMQ+/fHUFYRdYoH4qh5PeUdV4BFxIMlhISxF
	/afH/jhdNVD4I/sPR4cC5bV5Ojv+rroGyNmJb4pfNehWvh4P8WbsHKJGzYElB6RtAISVfP/KXDZ
	v56A9MuppCIgpCtEL9cS/mkL8bkJFLCrDJql30lA==
X-Received: by 2002:a05:7301:4b18:b0:2f5:5907:3a48 with SMTP id 5a478bee46e88-3074fa65f4dmr550516eec.1.1780445120588;
        Tue, 02 Jun 2026 17:05:20 -0700 (PDT)
Received: from [127.0.0.1] ([52.159.247.163])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3074db5610esm875244eec.4.2026.06.02.17.05.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jun 2026 17:05:19 -0700 (PDT)
Message-Id: <pull.2131.v3.git.1780445118653.gitgitgadget@gmail.com>
In-Reply-To: <pull.2131.v2.git.1780330402264.gitgitgadget@gmail.com>
References: <pull.2131.v2.git.1780330402264.gitgitgadget@gmail.com>
From: "Arijit Banerjee via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 03 Jun 2026 00:05:17 +0000
Subject: [PATCH v3] index-pack: retain child bases in delta cache
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
    Jeff King <peff@peff.net>,
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
runs. Once all direct children of a base have been dispatched, and no
thread is actively retaining that base for patch_delta(), release the
cached bytes. The base_data struct itself remains alive until the
existing children_remaining bookkeeping says the whole subtree is done.

On a quiet Ubuntu 24.04 VM with 16 vCPUs, 32 GiB RAM, and local SSD,
standard p5302-pack-index.sh runs improved as follows:

  libgit2:  3.17(11.49+0.60)  ->   2.69(10.52+0.28), 15.1% faster
  redis:    5.84(15.56+0.63)  ->   4.95(14.05+0.32), 15.2% faster
  git.git: 11.17(38.04+1.29)  ->   9.67(35.29+0.60), 13.4% faster
  cpython: 32.69(117.85+4.37) ->  28.60(109.25+1.91), 12.5% faster
  linux:  279.22(797.69+40.86) -> 236.34(723.13+19.02), 15.4% faster

The linux p5302 number is from a single repeat; the others are from the
default three repeats.

End-to-end local full-clone spot checks also improved:

  libgit2:  5.00s ->   4.54s, 9.2% faster
  redis:    8.75s ->   7.92s, 9.5% faster
  git.git: 25.04s ->  23.71s, 5.3% faster
  cpython: 56.72s ->  55.94s, 1.4% faster
  linux:  556.17s -> 523.83s, 5.8% faster

t/t5302-pack-index.sh passed, and GitGitGadget's linux-leaks CI also
exercised that test under SANITIZE=leak.

Signed-off-by: Arijit Banerjee <arijit@effectiveailabs.com>
---
    index-pack: retain child bases in delta cache
    
    Speed up the local index-pack phase used by clone/fetch for large
    delta-compressed packs.
    
    When index-pack reconstructs a child base and queues it for resolving
    descendant deltas, it currently frees that data immediately. This can
    force the same base to be reconstructed again. This patch keeps the data
    in the existing delta base cache instead of immediately freeing it.
    
    This does not add a new cache or increase the cache limit. The object
    data is already accounted in base_cache_used, and prune_base_data() is
    already called at this point.
    
    To keep the retained data lifetime precise, the patch also releases
    cached bytes once all direct children of a base have been dispatched and
    no thread is actively retaining that base for patch_delta(). The
    base_data struct itself still stays alive until the existing
    children_remaining bookkeeping says the whole subtree is done.
    
    Changes since v2:
    
     * Addressed Jeff King's review question by releasing cached base data
       after all direct children have been dispatched, while keeping the
       existing subtree bookkeeping intact.
     * Re-ran t/t5302-pack-index.sh, p5302-pack-index.sh, and end-to-end
       full clone spot checks with the precise-release version.
    
    Changes since v1:
    
     * Added benchmark results and leak-safety context to the commit
       message.
     * Included standard p5302-pack-index.sh perf-suite results.
    
    Correctness:
    
     * t/t5302-pack-index.sh passed.
     * GitGitGadget's linux-leaks CI exercises t5302-pack-index.sh under
       SANITIZE=leak.
    
    Benchmarks on a quiet Ubuntu 24.04 VM, 16 vCPU, 32 GiB RAM, local SSD:
    
    Standard p5302-pack-index.sh perf-suite results using
    GIT_PERF_LARGE_REPO=<repo> ./run HEAD~1 HEAD -- p5302-pack-index.sh:
    
    repo HEAD~1 HEAD wall-time change libgit2 3.17(11.49+0.60)
    2.69(10.52+0.28) 15.1% faster redis 5.84(15.56+0.63) 4.95(14.05+0.32)
    15.2% faster git.git 11.17(38.04+1.29) 9.67(35.29+0.60) 13.4% faster
    cpython 32.69(117.85+4.37) 28.60(109.25+1.91) 12.5% faster linux
    279.22(797.69+40.86) 236.34(723.13+19.02) 15.4% faster
    
    The linux p5302 row is from a single repeat; the others use the default
    three repeats. These timings isolate the index-pack phase affected by
    this patch.
    
    End-to-end local full-clone spot checks also showed wins, though these
    timings include both server-side pack-objects and client-side index-pack
    running concurrently over a local file:// transport, so they are not
    isolated index-pack timings.
    
    These runs used git clone --bare --no-local, dropped page cache before
    each clone, and used the matching build's bin-wrappers/git as the client
    plus the matching bin-wrappers/git-upload-pack via --upload-pack.
    
    repo baseline patched wall-time change libgit2 5.00s 4.54s 9.2% faster
    redis 8.75s 7.92s 9.5% faster git.git 25.04s 23.71s 5.3% faster cpython
    56.72s 55.94s 1.4% faster linux 556.17s 523.83s 5.8% faster

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-2131%2Farijit91%2Findex-pack-retain-child-base-v3
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-2131/arijit91/index-pack-retain-child-base-v3
Pull-Request: https://github.com/gitgitgadget/git/pull/2131

Range-diff vs v2:

 1:  42eca38f51 ! 1:  51967f9edf index-pack: retain child bases in delta cache
     @@ Commit message
      
          This does not add a new cache or increase the cache limit. The object
          data is already accounted in base_cache_used before prune_base_data()
     -    runs, and the existing pruning and base cleanup paths still release it.
     +    runs. Once all direct children of a base have been dispatched, and no
     +    thread is actively retaining that base for patch_delta(), release the
     +    cached bytes. The base_data struct itself remains alive until the
     +    existing children_remaining bookkeeping says the whole subtree is done.
      
          On a quiet Ubuntu 24.04 VM with 16 vCPUs, 32 GiB RAM, and local SSD,
     -    direct index-pack timings on single-pack Linux fixtures improved as
     -    follows:
     +    standard p5302-pack-index.sh runs improved as follows:
      
     -      linux blobless: 69.17s -> 57.98s (16.2% faster), RSS flat
     -      linux full:     280.72s -> 236.32s (15.8% faster), RSS +1.9%
     +      libgit2:  3.17(11.49+0.60)  ->   2.69(10.52+0.28), 15.1% faster
     +      redis:    5.84(15.56+0.63)  ->   4.95(14.05+0.32), 15.2% faster
     +      git.git: 11.17(38.04+1.29)  ->   9.67(35.29+0.60), 13.4% faster
     +      cpython: 32.69(117.85+4.37) ->  28.60(109.25+1.91), 12.5% faster
     +      linux:  279.22(797.69+40.86) -> 236.34(723.13+19.02), 15.4% faster
      
     -    Five-repeat medians on public repositories also improved:
     +    The linux p5302 number is from a single repeat; the others are from the
     +    default three repeats.
      
     -      git.git:  12.31s -> 10.70s (13.1% faster)
     -      libgit2:   3.35s ->  2.88s (14.0% faster)
     -      redis:     6.52s ->  5.64s (13.5% faster)
     -      cpython:  33.02s -> 31.44s (4.8% faster)
     +    End-to-end local full-clone spot checks also improved:
      
     -    The standard p5302 perf test on a smaller git.git fixture was neutral:
     -
     -      5302.9 index-pack default threads:
     -        11.21(38.07+1.33) -> 11.16(37.90+1.31), -0.4%
     +      libgit2:  5.00s ->   4.54s, 9.2% faster
     +      redis:    8.75s ->   7.92s, 9.5% faster
     +      git.git: 25.04s ->  23.71s, 5.3% faster
     +      cpython: 56.72s ->  55.94s, 1.4% faster
     +      linux:  556.17s -> 523.83s, 5.8% faster
      
          t/t5302-pack-index.sh passed, and GitGitGadget's linux-leaks CI also
          exercised that test under SANITIZE=leak.
     @@ Commit message
          Signed-off-by: Arijit Banerjee <arijit@effectiveailabs.com>
      
       ## builtin/index-pack.c ##
     +@@ builtin/index-pack.c: static void free_base_data(struct base_data *c)
     + 	}
     + }
     + 
     ++static int base_data_has_remaining_direct_children(struct base_data *c)
     ++{
     ++	return c->ref_first <= c->ref_last ||
     ++	       c->ofs_first <= c->ofs_last;
     ++}
     ++
     + static void prune_base_data(struct base_data *retain)
     + {
     + 	struct list_head *pos;
     +@@ builtin/index-pack.c: static void *threaded_second_pass(void *data)
     + 		}
     + 
     + 		work_lock();
     +-		if (parent)
     ++		if (parent) {
     + 			parent->retain_data--;
     ++			if (!parent->retain_data &&
     ++			    !base_data_has_remaining_direct_children(parent))
     ++				free_base_data(parent);
     ++		}
     + 
     + 		if (child && child->data) {
     + 			/*
      @@ builtin/index-pack.c: static void *threaded_second_pass(void *data)
       			list_add(&child->list, &work_head);
       			base_cache_used += child->size;


 builtin/index-pack.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/builtin/index-pack.c b/builtin/index-pack.c
index cf0bd8280d..00b4dff419 100644
--- a/builtin/index-pack.c
+++ b/builtin/index-pack.c
@@ -433,6 +433,12 @@ static void free_base_data(struct base_data *c)
 	}
 }
 
+static int base_data_has_remaining_direct_children(struct base_data *c)
+{
+	return c->ref_first <= c->ref_last ||
+	       c->ofs_first <= c->ofs_last;
+}
+
 static void prune_base_data(struct base_data *retain)
 {
 	struct list_head *pos;
@@ -1201,8 +1207,12 @@ static void *threaded_second_pass(void *data)
 		}
 
 		work_lock();
-		if (parent)
+		if (parent) {
 			parent->retain_data--;
+			if (!parent->retain_data &&
+			    !base_data_has_remaining_direct_children(parent))
+				free_base_data(parent);
+		}
 
 		if (child && child->data) {
 			/*
@@ -1212,7 +1222,6 @@ static void *threaded_second_pass(void *data)
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
