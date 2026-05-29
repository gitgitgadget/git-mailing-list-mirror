Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0828B330650
	for <git@vger.kernel.org>; Fri, 29 May 2026 16:06:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780070767; cv=none; b=ilhPHkoRkDus573UoWsJuy6Umoc6rjDHcHYspnzL9G6b1T4QLx+vdTYXcnSJNOW8+45eKTGR9pgnfUNh87b6kwHm6K5r3O3uUlr7gXVSEnyjhEe8zf3sP62JcdRAHlF73hVsPo7gvLI1es35UKeA8g4kqMjj58yGamOVRVYuKO4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780070767; c=relaxed/simple;
	bh=Ug/cE1nZjgpoXfz0a3eSRiz1KJA6v9jzDeJyMEvDIvg=;
	h=Message-Id:From:Date:Subject:Content-Type:MIME-Version:To:Cc; b=Jffo6ID3/iUcxuyYlk39gGc4aFMTg9DJIIDAcekjabvRedVKovFAcWL8I4QL9qalKlGjYRTAAe/n2DSjQDp0Qbc57sy+3r6UMCURVTur9GlWEp6RUR0ETM97KJIU0dvkFShrjVkMQbxPaUNA1QtsasoZ8ZdD/tshzzA0NX8f6So=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PFNcG8sB; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PFNcG8sB"
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-8419ab3a297so2443706b3a.2
        for <git@vger.kernel.org>; Fri, 29 May 2026 09:06:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780070765; x=1780675565; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=dHizE1Fuqmb62Qi660JTl9iEb9ui0iOAai+iiyV/mJA=;
        b=PFNcG8sBGk+gcYM+cJSH5yk4PzTizKwTsrvNDhAUeOlcM/EhOEtMyOM+ZTOXR+z8uG
         7H6fwYDNwlmT/I2lA8mshKMaIHSzRc1hn3u669giDw4khkFPyjx11vf7gZBg0RkjWZIS
         ao/Oc2errGhjnQDpkeDVgqNbH8z3O6PuRi9p+AIAbUeInLJ+m31T7VB56BlACeul/rwr
         ZJt80231J/6eAMPkQTjjbmtl90yHgYYTA7wvWwoOCmXGlbzCfrFqHVzLbhYdEI06t63N
         9DLlk8k2RcP5UcR2rcmVaspaiYqbpDm1aDm8Sqqbk6QkWwyrPExujDJep3NmSAR3wL8i
         Glrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780070765; x=1780675565;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dHizE1Fuqmb62Qi660JTl9iEb9ui0iOAai+iiyV/mJA=;
        b=gr8H4fQp1wmvjRdRv3HqMHsa6H0F4CdXdWEdX0muKsp7Xswx0QAL3+wyvgXV2HBVrd
         uwKZmIfpKpt0iudkBpc0z4nuVNRSDO4HOcEyNS7gXJ1GyW1jIzQS3uFDXWOZvq+ff47d
         uKJmLrxINB0PgJ42WV8M+w5fl/ozQptZpF2s5A5M2xmm9jv77eyp/xE16Sqhm31LG5UX
         3N81V6tH7fmMHQJbZlPIeqjv5hsEoyzJfGAdFl+d/bHrpuM5G8gnRglA1N7IRJNw+F+c
         b1AlaA0TDZZRtm4YTalY+uB9Tg9zLq+VB9IiHvgOjPt2GEKxfd+8oLGHjnfR1GyDCToz
         viMw==
X-Gm-Message-State: AOJu0YzchCwlCQIndWECXzlOOQiMbBSQjClpCGefKIZBzdhjd17xPug4
	RyOfghWJxRBA7+3y9QHKpLdz2q/rH8ZDAeDtky8KKUo7z0HgoFJ3KZL8cCIGsg==
X-Gm-Gg: Acq92OFmC4F6btNTEs8lQyB4MO2DBca2MoiBxJJHLXcpa/Ppio81cfvcvkSSg8oY2B4
	ItVqFgKEm9k/dIJLReRx+neZ3YRt3Hhy97rX40GJ2FMis75b+gCvQhnZKlGq0c4JicGktbzvY0y
	GHHe8glypUq00FOWDc1RIIFkuZAWTG55Rtmv/qgwThq6rWI3C9fJmEkFaBCO8Ulfu1aSKT+NGtI
	oER/LKHAhmjP8EkgIcSHrtoNSxmjxiHtrabnJymPi9XdkiFozRwnHDDOpaeW4k4GGrC25BV/bY5
	gSDqvVN1VepELh2f856DMTodegDRdZObJHB2OEhs8CP/61jlHImfrWoMR1xc/3YmJSv/hvTjzIn
	kdgRsH4GhDTTH5MilT7i5jXIllZI2ZeGJBoHBE6pNGcjPIG8otdRFtCj+4inuwCrKeXkrHeE2FH
	Vzp2AuKW2XdRTMcxpg3LiXHsNotLNPk+MqKsI7
X-Received: by 2002:a05:6a00:3386:b0:841:d095:fcd7 with SMTP id d2e1a72fcca58-8422544231cmr130991b3a.30.1780070764964;
        Fri, 29 May 2026 09:06:04 -0700 (PDT)
Received: from [127.0.0.1] ([172.190.85.16])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8421f537e53sm918229b3a.6.2026.05.29.09.06.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 May 2026 09:06:04 -0700 (PDT)
Message-Id: <pull.2131.git.1780070763044.gitgitgadget@gmail.com>
From: "Arijit Banerjee via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 29 May 2026 16:06:02 +0000
Subject: [PATCH] index-pack: retain child bases in delta cache
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
base_cache_used, and calls prune_base_data(). It then immediately
frees that same data.

This bypasses the existing delta base cache policy and can force later
descendants to reconstruct the queued base again. Let the existing
delta_base_cache_limit pruning policy decide whether to keep or evict
the data instead.

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

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-2131%2Farijit91%2Findex-pack-retain-child-base-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-2131/arijit91/index-pack-retain-child-base-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/2131

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
