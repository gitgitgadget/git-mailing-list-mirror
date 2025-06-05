Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29E5F1A38E4
	for <git@vger.kernel.org>; Thu,  5 Jun 2025 15:53:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749138826; cv=none; b=Ims136Kmibg2bhsINXU2rdpeAZK6vPGnlDXMecM2koJjZsgu1Z5dGPoGy0hEwiCd9M3wigW+aBoVly7Acd+pOcGYzbkKK6GB1rvadInek8LgV9jTHvmOz7PxC/OhiGkphQIjYPHnppwBUPLwtHhq0KFpyormCA2wfivVv2BOgwo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749138826; c=relaxed/simple;
	bh=4KEX9Zvxjb+kfGxKwwQlqXGZNJu69rzyuHQ/nexCR3Y=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=f+ayP5Y8uQNzCYeyCOt5cE6cHZUo4xyXxiEx+zqL5cY1xaZ9yvC/+YT4jUvw0bJhzFMKgb+0dJmiREiFWI6ZPRxQbjc3mRpSftHPJGr2ZqtqNhl+zyn57Ytr6HcTJGEZjSQoNufqkAlOhQSn6UydI8ZMJw1eknOH+piZPR5EWek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZOoK2N4g; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZOoK2N4g"
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-3a507e88b0aso1096443f8f.1
        for <git@vger.kernel.org>; Thu, 05 Jun 2025 08:53:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749138822; x=1749743622; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=djCS5O9lZrmDvETb56radbYnD4NxPsAGtcm3Hw3RMoE=;
        b=ZOoK2N4g7Ibz6adT7fDoU23w4w71xleiAzWgOW3Sq+SQarb3zl4jLQoR5nEENebDtr
         5oLqpxTX4DSDAt+gPiuFH39C052hqVuBm/5tlWLddp4/ilNNtyBaz8JCSTdqNrKMwMKo
         q0ThIIeUhRBCOIJROfgniTk0F9JhgrZJX9uJgtD+NE5wYBeZIDrfitTvNXpkWDNiIcaI
         LfkaMUUNnzqxxa3idoA4MvQxuRRS4hyQl7+WIKilAVCLg1UqScr8VDZub5xAZHJEBQD5
         BxowFSp9aS3oNpshgLfm+z9U/sV3Py/lpffAyU5TADAIwiN/QS2V8Nzym8bbAQ4VQdXA
         kYOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749138822; x=1749743622;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=djCS5O9lZrmDvETb56radbYnD4NxPsAGtcm3Hw3RMoE=;
        b=Bx3GuszOxaPMcKrqcDY1qRAgkKgpx2a1T8Z0Y31GcjRhslWXeEC2vyYyvjoFBKhmYv
         UiZflwHAVLHCYQxpaPjmJ1FUSwXg+6vQ31wnDm47pJMJ2fmOOebUZXgnomB8TTt5QhnP
         +roJiYYj39gSez6uRzX9N+SqSEyrPZFwxzGiLE9aReNPB3HQOZBbmmPzdSIxGK280VCC
         WcTcHD4hd4h0RztpHUtmDJdNuH1RLhTK6iL9Q7JOpxIyy80Q15Ea9iJDXZ5GacqanTAq
         svrPPT7GNe0ToLqyryMGx99CMH77YUxGU3bN9HDyVN3ipdGiDQDhigMKOm7HZ12AnMbE
         ywjQ==
X-Gm-Message-State: AOJu0YwdshEsC21mRw7fC/GjEfG4RwjrA8UTtGTDXq/uisqP8yq0yjBe
	4XQW6uVXr9jQs0HzJUsEk5W91SEqVQlqFO6QoIbz8UC9fkfeYl6Rp7n8SFZx6w==
X-Gm-Gg: ASbGncvO7Er1oyUK97FfdyTsd1agtwp2Z1IIKzPBRuleGZsbNSsV9IckDO4hZxm2J0Y
	BHJhdjiQeNXFME4PZ8mjGa9RzLMp6zm4kVwzrzM8ah0wZEPQlogCy4zc2apH4mi2vroNzg5Xb2K
	FfCu16TdOoTvQF+uIAlI1MzEX35q+oq0mC777IdVpxC5qHGl9D+mL1z/Blgim4EHOq5R4G7Jaiy
	ZQNbl1HSUqLWk5CnELfgsTqVROIiOXwnLgbvm0nT3LH2rEwrVaP1JwDhy54y/n/TvU+NxigKt0j
	T6vH8A+yZkbPOe+7ghI68BqhHF20HG1rN2OA/i7IgGXGASSqjvRC
X-Google-Smtp-Source: AGHT+IEuqA7FxC32TyTIUCycidEND9UogmPEwg+gNHy1iwVsDvmPA3I2N+SVI30XXBDKn9EYypKA0w==
X-Received: by 2002:a5d:64e2:0:b0:3a4:e6c6:b8bf with SMTP id ffacd0b85a97d-3a51d978963mr6495780f8f.52.1749138821829;
        Thu, 05 Jun 2025 08:53:41 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-451fb177afcsm23255795e9.9.2025.06.05.08.53.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Jun 2025 08:53:41 -0700 (PDT)
Message-Id: <pull.1977.v6.git.git.1749138820241.gitgitgadget@gmail.com>
In-Reply-To: <pull.1977.v5.git.git.1749104667618.gitgitgadget@gmail.com>
References: <pull.1977.v5.git.git.1749104667618.gitgitgadget@gmail.com>
From: "Lidong Yan via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 05 Jun 2025 15:53:39 +0000
Subject: [PATCH v6] pack-bitmap: remove checks before bitmap_free
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
Cc: Patrick Steinhardt <ps@pks.im>,
    Eric Sunshine <sunshine@sunshineco.com>,
    Taylor Blau <me@ttaylorr.com>,
    Lidong Yan <502024330056@smail.nju.edu.cn>,
    Lidong Yan <502024330056@smail.nju.edu.cn>

From: Lidong Yan <502024330056@smail.nju.edu.cn>

In pack-bitmap.c:find_boundary_objects(), the roots_bitmap is only freed
if cascade_pseudo_merges_1() fails. Since cascade_pseudo_merges_1() only
use roots_bitmap as a mutable reference but not takes roots_bitmap's
ownership. Once cascade_pseudo_merges_1() succeeds, roots_bitmap leaks.
And this leak currently lacks a dedicated test to detect it.

To fix this leak, remove if cascade_pseudo_merges_1() succeed check and
always calling bitmap_free(roots_bitmap);

To trigger this leak, we need roots_bitmap that contains at least one
pseudo merge. So that we can use pseudo merge bitmap when we compute roots
reachable bitmap. Here we create two commits: first A then B. Add A
to the pseudo-merge and perform a traversal over the range A..B.
In this scenario, the "haves" set will be {A}, and cascade_pseudo_merges_1
will succeed, thereby exposing the leak due to the missing roots_bitmap
cleanup.

Signed-off-by: Lidong Yan <502024330056@smail.nju.edu.cn>
---
    pack-bitmap: remove checks before bitmap_free
    
    In pack-bitmap.c:find_boundary_objects, remove cascade success check and
    always free roots_bitmap afterward to make static analysis tool works
    better.

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1977%2Fbrandb97%2Fremove-check-before-bitmap-free-v6
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1977/brandb97/remove-check-before-bitmap-free-v6
Pull-Request: https://github.com/git/git/pull/1977

Range-diff vs v5:

 1:  4bc90c83a40 ! 1:  43cdce190dc pack-bitmap: remove checks before bitmap_free
     @@ Commit message
          In pack-bitmap.c:find_boundary_objects(), the roots_bitmap is only freed
          if cascade_pseudo_merges_1() fails. Since cascade_pseudo_merges_1() only
          use roots_bitmap as a mutable reference but not takes roots_bitmap's
     -    ownership. Once cascade_pseudo_merges_1 succeed(), roots_bitmap leaks.
     +    ownership. Once cascade_pseudo_merges_1() succeeds, roots_bitmap leaks.
          And this leak currently lacks a dedicated test to detect it.
      
          To fix this leak, remove if cascade_pseudo_merges_1() succeed check and
          always calling bitmap_free(roots_bitmap);
      
     -    To trigger this leak, we need roots_bitmap contains at least one pseudo
     -    merge. So that we can use pseudo merge bitmap when we compute roots
     +    To trigger this leak, we need roots_bitmap that contains at least one
     +    pseudo merge. So that we can use pseudo merge bitmap when we compute roots
          reachable bitmap. Here we create two commits: first A then B. Add A
          to the pseudo-merge and perform a traversal over the range A..B.
          In this scenario, the "haves" set will be {A}, and cascade_pseudo_merges_1


 pack-bitmap.c                   |  4 ++--
 t/t5333-pseudo-merge-bitmaps.sh | 17 +++++++++++++++++
 2 files changed, 19 insertions(+), 2 deletions(-)

diff --git a/pack-bitmap.c b/pack-bitmap.c
index ac6d62b980c..8727f316de9 100644
--- a/pack-bitmap.c
+++ b/pack-bitmap.c
@@ -1363,8 +1363,8 @@ static struct bitmap *find_boundary_objects(struct bitmap_index *bitmap_git,
 			bitmap_set(roots_bitmap, pos);
 		}
 
-		if (!cascade_pseudo_merges_1(bitmap_git, cb.base, roots_bitmap))
-			bitmap_free(roots_bitmap);
+		cascade_pseudo_merges_1(bitmap_git, cb.base, roots_bitmap);
+		bitmap_free(roots_bitmap);
 	}
 
 	/*
diff --git a/t/t5333-pseudo-merge-bitmaps.sh b/t/t5333-pseudo-merge-bitmaps.sh
index 56674db562f..ba5ae6a00c9 100755
--- a/t/t5333-pseudo-merge-bitmaps.sh
+++ b/t/t5333-pseudo-merge-bitmaps.sh
@@ -445,4 +445,21 @@ test_expect_success 'pseudo-merge closure' '
 	)
 '
 
+test_expect_success 'use pseudo-merge in boundary traversal' '
+	git init pseudo-merge-boundary-traversal &&
+	(
+		cd pseudo-merge-boundary-traversal &&
+
+		git config bitmapPseudoMerge.test.pattern refs/ &&
+		git config pack.useBitmapBoundaryTraversal true &&
+
+		test_commit A &&
+		git repack -adb &&
+		test_commit B &&
+
+		nr=$(git rev-list --count --use-bitmap-index HEAD~1..HEAD) &&
+		test 1 -eq "$nr"
+	)
+'
+
 test_done

base-commit: 845c48a16a7f7b2c44d8cb137b16a4a1f0140229
-- 
gitgitgadget
