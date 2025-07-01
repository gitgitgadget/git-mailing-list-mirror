Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE81972601
	for <git@vger.kernel.org>; Tue,  1 Jul 2025 05:32:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751347934; cv=none; b=TlJdDvyvGZb7m09eIEO0b2NFTvYxRv8h+W76+Ms50gzUT0R2+HDp7XBsESc/SHUq41lOLbQ/UTNkNPWLyPZyPdaCmkFwbX0K8yCsA8CwkciPS677bpLGSvhl4UdwVICIv2ZiJydcGNjqq+mzc/rsb2Tme7xaLVKGdYZayH+4Zc8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751347934; c=relaxed/simple;
	bh=M3ZygtR+tLeUMHUe4y1PEM07LNWz7BaXiGjvNTBwXj4=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=g+VzoLB9md9QNZhAanXE6mkNKdNznM/ohDm7ZX6pPFIeylC9BTg6f1UT6YCb1pJNpNwHGPUNdZPKTmV1wouiGprIv0OH5dx/jYeHGCPz8lK6RieKoLwpqCOEasHvXC97qBUrVB9JRWi2U3AfCpG45QKn6sXOvNlsnO6MVx7iAGQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WbnOF+NN; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WbnOF+NN"
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-3a54700a463so3100617f8f.1
        for <git@vger.kernel.org>; Mon, 30 Jun 2025 22:32:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751347931; x=1751952731; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SUOzY29rPrb66dueQ0jq1NXSGjejRXdOcTgKvOLl6mY=;
        b=WbnOF+NNzkGI9NDCUM4sbloh9oar6fmbRZJlKvBRLOYlOwDB3zk5YyUToW3fdpnDWY
         BIp+5gapCzlpMRvaO9b62hHk4+s0iNbblH5MYowIJ5Pe/JDmq2k4HFIFvJYrjl3muO31
         UpxKjbAosDxHbCKXUbfckAX2cn/2KdePCriJMTC0vqj2K5kPNEo+4WIDeeDt9zrvY6nC
         JBmZ3X99UYkzppJZb/6NLPpPSgBMuqkUtWj2nlf8/aIU2feub28U+a4HHV7+VrD+phzP
         t1LJAx60j3uVoDeNPLXbBmfrJz+74HMNjshbzacEH1gjKCpqt1BliZj41SknRAAJqBXj
         3Cyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751347931; x=1751952731;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SUOzY29rPrb66dueQ0jq1NXSGjejRXdOcTgKvOLl6mY=;
        b=LUok6zL9g/9Kt5RqhOOmErWEnjtv5WdlVa9pv4bM7yv7/PyjzMysMlO4hjOqvf3+IA
         f8OFNZuc+dgHwi+RDbaUJjXY5Vivqw1EaKJkiDCycJ1bpllSp4+YfVejR113hDZ/A22l
         +m5g+9NiPFpsP/nEN7EwJ1ubRiKJybzJ+Oehkb/QroJSciZlKaQY/kpCyqSPji/Lm5Yb
         BqB4M9+Ow+M4iX0rsJkgDxvTtzkDAXIORD7ZFILdDFskZrZkwukbgxSJmqdhaXKUvG2O
         23k+NZ2z1xsJiUmjhVHaXHNfp80t7cGz77OqatmRJDVUP0TKde8b+2KJdoQwRhaL042s
         63qQ==
X-Gm-Message-State: AOJu0Ywx5tZs1mG9HW2X4bo1EchtuoYpzJHCrHLVq/+OSFdzy1+JFi4T
	He+1QpvYQ0OKtpYoLOFLJP+/CvCXR7GHBTyD/LSnJrW69mZLbqChNsMESWPtCg==
X-Gm-Gg: ASbGnctPPzeK2JLV5kPbvs461s4qeQswP4hYngockPERBBgw2acu67ItVR7SV+5j+Xm
	qBh07y8uF66ByTwj6JUXqSJtbZRx8E+oBww9zGCO8gEkqMVlSwPVo3XRdHozjgZtsFS/DfGPt7X
	XAhCvtCKjulzcqq83ioizoqs/k0V1tkH3F7MYzrQvpCiy1MKZpc4Ft1qGYQ9azGuuW7uds6rHzZ
	kvRi75dVeSc+kSChEXykKsib81XUCQBhWYrcNmvq/GNJjz42hlEdchOaC6oTOIbOl0Du3bsw+2/
	Pps5+0bvnTNa8iRSmAtz7DfR6aJCaqIP15cKJxteIKNs/y9+4XJwxwtxbWTV86g=
X-Google-Smtp-Source: AGHT+IHtNCPj412XvoN044AY4L1J1uAI35TWW+6aKjNG07fCrufHUI7t8K6vkpRNoXlyGIeG3CY/Ww==
X-Received: by 2002:a05:6000:144a:b0:3a5:8934:4959 with SMTP id ffacd0b85a97d-3af10d3574fmr1737660f8f.27.1751347930664;
        Mon, 30 Jun 2025 22:32:10 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4538a4235cbsm156367155e9.38.2025.06.30.22.32.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Jun 2025 22:32:10 -0700 (PDT)
Message-Id: <pull.1962.v6.git.git.1751347929.gitgitgadget@gmail.com>
In-Reply-To: <pull.1962.v5.git.git.1748920444.gitgitgadget@gmail.com>
References: <pull.1962.v5.git.git.1748920444.gitgitgadget@gmail.com>
From: "Lidong Yan via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 01 Jul 2025 05:32:06 +0000
Subject: [PATCH v6 0/3] pack-bitmap: fix memory leak if load_bitmap failed
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
Cc: Jeff King <peff@peff.net>,
    Taylor Blau <me@ttaylorr.com>,
    Lidong Yan <502024330056@smail.nju.edu.cn>

Since it seems this patch has been inactive for some time, I have revised
the comments according to Taylor's feedback and submitted a new version.

This patch prevents pack-bitmap.c:load_bitmap() from nulling
bitmap_git->bitmap when loading failed. Thus eliminates memory leak. This
patch also add a test case in t5310 which use clang leak sanitizer to detect
whether leak happens when loading failed.

Lidong Yan (2):
  pack-bitmap: reword comments in test_bitmap_commits()
  pack-bitmap: add load corrupt bitmap test

Taylor Blau (1):
  pack-bitmap: fix memory leak if load_bitmap() failed

 pack-bitmap.c           | 88 ++++++++++++++++++++++++++++++-----------
 pack-bitmap.h           |  1 +
 t/helper/test-bitmap.c  |  8 ++++
 t/t5310-pack-bitmaps.sh | 30 ++++++++++++++
 4 files changed, 103 insertions(+), 24 deletions(-)


base-commit: f0135a9047ca37d4d117dcf21f7e3e89fad85d00
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1962%2Fbrandb97%2Ffix-pack-bitmap-leak-v6
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1962/brandb97/fix-pack-bitmap-leak-v6
Pull-Request: https://github.com/git/git/pull/1962

Range-diff vs v5:

 1:  9ce2135df2a ! 1:  3d70e14e415 pack-bitmap: fix memory leak if load_bitmap() failed
     @@ Commit message
              });
      
          , but won't since load_bitmap() already called kh_destroy_oid_map() and
     -    NULL'd the "bitmaps" pointer from within its "failed" label.
     -
     -    So I think if you got part of the way through loading bitmap entries and
     -    then failed, you would leak all of the previous entries that you were
     -    able to load successfully.
     +    NULL'd the "bitmaps" pointer from within its "failed" label. Thus if you
     +    got part of the way through loading bitmap entries and then failed, you
     +    would leak all of the previous entries that you were able to load
     +    successfully.
      
          The solution is to remove the error handling code in load_bitmap(), because
          its caller will always call free_bitmap_index() in case of an error.
 2:  a75d0a3cc7f ! 2:  6a082930ea3 pack-bitmap: reword comments in test_bitmap_commits()
     @@ Metadata
       ## Commit message ##
          pack-bitmap: reword comments in test_bitmap_commits()
      
     -    In pack-bitmap.c:test_bitmap_commits(), it comments
     -
     -        /*
     -         * As this function is only used to print bitmap selected
     -         * commits, we don't have to read the commit table.
     -         */
     -
     -    This suggests that we can avoid reading the commit table altogether.
     -    However, this comment is misleading. The reason we load bitmap entries here
     -    is because test_bitmap_commits() needs to print the commit IDs from the
     +    The comment in pack-bitmap.c:test_bitmap_commits(), suggests that
     +    we can avoid reading the commit table altogether. However, this
     +    comment is misleading. The reason we load bitmap entries here is
     +    because test_bitmap_commits() needs to print the commit IDs from the
          bitmap, and we must read the bitmap entries to obtain those commit IDs.
          So reword this comment.
      
     @@ pack-bitmap.c: int test_bitmap_commits(struct repository *r)
       	/*
      -	 * As this function is only used to print bitmap selected
      -	 * commits, we don't have to read the commit table.
     -+	 * Since this function needs to print bitmap selected
     ++	 * Since this function needs to print the bitmapped
      +	 * commits, bypass the commit lookup table (if one exists)
      +	 * by forcing the bitmap to eagerly load its entries.
       	 */
 3:  05140e2171d ! 3:  c1b5d030133 pack-bitmap: add load corrupt bitmap test
     @@ Metadata
       ## Commit message ##
          pack-bitmap: add load corrupt bitmap test
      
     -    This patch add test_bitmap_list_commits_offset() in patch-bitmap.c,
     -    a new test helper command `test-tool bitmap list-commits-offset`,
     -    and a `load corrupt bitmap` test case in t5310.
     -
     -    The `load corrupt bitmap` test case intentionally corrupt the
     -    "xor_offset" field of the first entry. And the newly added helper
     -    can help to find position of "xor_offset" in bitmap file.
     +    t5310 lacks a test to ensure git works correctly when commit bitmap
     +    data is corrupted. So this patch add test helper in pack-bitmap.c to
     +    list each commit bitmap position in bitmap file and `load corrupt bitmap`
     +    test case in t/t5310 to corrupt a commit bitmap before loading it.
      
          Signed-off-by: Lidong Yan <502024330056@smail.nju.edu.cn>
      

-- 
gitgitgadget
