Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17EA28821
	for <git@vger.kernel.org>; Tue,  3 Jun 2025 01:46:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748915187; cv=none; b=cABYdlyLE0ejOwAuirkgBxTCK2SwXyNl2rsU66owypxuU+9LdUKiEKxtID5KLUNc6JSIao0ejO7eFq+Sq9g5qxsCb+N/+5ViLQOH32eCu0P+KDPt2Iy9xBaCxHs6btobgVzte+FITjl4M46GYM6pEpBra5gJkNRAJB4qqykPKnw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748915187; c=relaxed/simple;
	bh=JtkjUvwfnfC+frWG8ekTByj1UIMuhy+2/2c7AqUBJsY=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=QBBKGITbVOLamvpX9GQgU0gpRclPAUTTyPQPNL9kzDvdM54XPZjgN1l80qS056e+w7OCq4CjH/35geTG2cmpZP6YIUQ2/1DcM4a722Z4HzTgD7H4CyEY9ti9+AE6j2mKXRb5TBBgW/S81Xk8KW0IvSWSzaio0zsJ1A4dVWKQf9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IJySN/Yg; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IJySN/Yg"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-451d6ade159so16852075e9.1
        for <git@vger.kernel.org>; Mon, 02 Jun 2025 18:46:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748915183; x=1749519983; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Jc+QTbvl/Pwa6a6sQnspZhDPfo9bV8B9P72MUe0JGdQ=;
        b=IJySN/Yg0/06RojamdJQYdUKBBzQs1b3a4twvW0tgRntBuKWxfhJI4/+7VpqH7MPP8
         UrA1mQlovuyJdp7NbCZ6HIvZ6H5/aIeSr4GJvTgGkXTIJol6DRjQfmWvtP4jNtvcG8uG
         /5m2cx6dtL0Eq4ACm/CB0zJFVVz+ESEdZYAY5TSLB7LJ2aGSkKtP9DkFpwKpYpxPQeYl
         vMverR8F4mGl58Dw+ERZGr0XmD09DfsJ5/y4TzT8HYoWxsDIgCdM7qfZ2da+iqyDVNEX
         A7m3ax16/Q2pd9cuMHXML2fweeo36a7skeRQ07TlTuSDqkrPGNQiT8/broJsFymRsGBl
         u2Hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748915183; x=1749519983;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Jc+QTbvl/Pwa6a6sQnspZhDPfo9bV8B9P72MUe0JGdQ=;
        b=UsEnBwWhmTIX4mm0XlAReXK6so4rlvTtz+PTYk3gFqlGy9Nh96Zcn+qQ8g80GIl884
         GD4qHzcoPgnK2OhXw9/nDB4f7RI93MahqQ4gOr7e9Idj2ZN9npNptWuSKJ2RLykwhjAc
         0r32FyeH2+pB/yQUE6VctHeW7dqKjJJ5lpYOxQtvHNkXaauTs6l0L34EluffGhvuatnZ
         OAyXH7YjoF01tcCx9Xw7VwceGIWdAun5oT/L+6ZtGLzv8BL5n+lsAu2hHs4ydXRiAi1C
         ++wVTyxDqR2d96dwjWttW40BRdYFXTpONvTKYfbEde/7QJU9msWvmKpoUn16foNmYeI3
         7PNg==
X-Gm-Message-State: AOJu0YwtrsgezVlfrcgxu1IL1yl16vaej3X3Lkq8dyxKWOLr9+c8Ti4e
	S0yPThhmvMN9jYUZiBhVWOisBkh/RBCgIOLApO2PnncjRrlbLghV+kaUou+j6g==
X-Gm-Gg: ASbGncsf//d6AdCw3hEguhLCZjES2DWIEKf6jvHPSHe5WS/ustcxQeNrPZdb38dkwmI
	RqNTuOhdTHfy6DPIN4qM8/JRNX1UbI+gANB90MD7M1UFuysUB7cBnsM83PpAoi1zou6dzC0SSCt
	UfikKtd8CzITo/Ydg4m3KEiQiyprWjOTdoIUFLCx4q3MjJRaXAXE+JopjMvpQ1Bo19Ur9pzb0bY
	hC9S8Dx3nWZzMqkx3VjYBJE6ollVjT9wuyF/+cPV2dbZOQl/OnoOg/UR1IuApDOJjh0dbTV2RDN
	MwloNXiPROhJEprz+Hz3nj3p+2wfH1aSwLogaEZbrljEMxOQsVPc
X-Google-Smtp-Source: AGHT+IGT8DRR+Etnxt6hxSTaeM8c7cmtz84gOMgYcZO78hAFY8f+poqmVwJzy/6fakOiiaLPsMjIow==
X-Received: by 2002:a05:600c:1e0d:b0:439:86fb:7340 with SMTP id 5b1f17b1804b1-4511ee0e02dmr103171165e9.30.1748915182878;
        Mon, 02 Jun 2025 18:46:22 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-450d8013e0esm140644455e9.39.2025.06.02.18.46.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Jun 2025 18:46:22 -0700 (PDT)
Message-Id: <pull.1977.v3.git.git.1748915181113.gitgitgadget@gmail.com>
In-Reply-To: <pull.1977.v2.git.git.1748628846.gitgitgadget@gmail.com>
References: <pull.1977.v2.git.git.1748628846.gitgitgadget@gmail.com>
From: "Lidong Yan via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 03 Jun 2025 01:46:20 +0000
Subject: [PATCH v3] pack-bitmap: remove checks before bitmap_free
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
    Lidong Yan <502024330056@smail.nju.edu.cn>,
    Lidong Yan <502024330056@smail.nju.edu.cn>

From: Lidong Yan <502024330056@smail.nju.edu.cn>

In pack-bitmap.c:find_boundary_objects(), the roots_bitmap is only freed
if cascade_pseudo_merges_1() fails. Since cascade_pseudo_merges_1() only
use roots_bitmap as a mutable reference but not takes roots_bitmap's
ownership. Once cascade_pseudo_merges_1 succeed(), roots_bitmap leaks.
And this leak currently lacks a dedicated test to detect it.

To fix this leak, remove if cascade_pseudo_merges_1() succeed check and
always calling bitmap_free(roots_bitmap);

To trigger this leak, we need a pseudo-merge whose size is equal to
or smaller than roots_bitmap (which corresponds to the set of "haves"
commits in prepare_bitmap_walk()). To do this, we can create two
commits: A and B. Add A to the pseudo-merge list and perform a traversal
over the range A..B. In this scenario, the "haves" set will be {A},
and cascade_pseudo_merges_1() will succeed, thereby exposing the leak
due to the missing roots_bitmap cleanup.

Signed-off-by: Lidong Yan <502024330056@smail.nju.edu.cn>
---
    pack-bitmap: remove checks before bitmap_free
    
    In pack-bitmap.c:find_boundary_objects, remove cascade success check and
    always free roots_bitmap afterward to make static analysis tool works
    better.

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1977%2Fbrandb97%2Fremove-check-before-bitmap-free-v3
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1977/brandb97/remove-check-before-bitmap-free-v3
Pull-Request: https://github.com/git/git/pull/1977

Range-diff vs v2:

 1:  d7b7a0e29ec < -:  ----------- pack-bitmap: remove checks before bitmap_free
 2:  56b24d681cb ! 1:  151a7f5dc70 t5333: test memory leak when use pseudo-merge in boundary traversal
     @@ Metadata
      Author: Lidong Yan <502024330056@smail.nju.edu.cn>
      
       ## Commit message ##
     -    t5333: test memory leak when use pseudo-merge in boundary traversal
     +    pack-bitmap: remove checks before bitmap_free
      
          In pack-bitmap.c:find_boundary_objects(), the roots_bitmap is only freed
     -    if cascade_pseudo_merges_1() fails. Otherwise, it leaks, leading to
     -    a memory leak that currently lacks a dedicated test to detect it.
     +    if cascade_pseudo_merges_1() fails. Since cascade_pseudo_merges_1() only
     +    use roots_bitmap as a mutable reference but not takes roots_bitmap's
     +    ownership. Once cascade_pseudo_merges_1 succeed(), roots_bitmap leaks.
     +    And this leak currently lacks a dedicated test to detect it.
     +
     +    To fix this leak, remove if cascade_pseudo_merges_1() succeed check and
     +    always calling bitmap_free(roots_bitmap);
      
          To trigger this leak, we need a pseudo-merge whose size is equal to
          or smaller than roots_bitmap (which corresponds to the set of "haves"
          commits in prepare_bitmap_walk()). To do this, we can create two
          commits: A and B. Add A to the pseudo-merge list and perform a traversal
          over the range A..B. In this scenario, the "haves" set will be {A},
     -    and cascade_pseudo_merges_1() will succeed — thereby exposing the leak
     +    and cascade_pseudo_merges_1() will succeed, thereby exposing the leak
          due to the missing roots_bitmap cleanup.
      
          Signed-off-by: Lidong Yan <502024330056@smail.nju.edu.cn>
      
     + ## pack-bitmap.c ##
     +@@ pack-bitmap.c: static struct bitmap *find_boundary_objects(struct bitmap_index *bitmap_git,
     + 			bitmap_set(roots_bitmap, pos);
     + 		}
     + 
     +-		if (!cascade_pseudo_merges_1(bitmap_git, cb.base, roots_bitmap))
     +-			bitmap_free(roots_bitmap);
     ++		cascade_pseudo_merges_1(bitmap_git, cb.base, roots_bitmap);
     ++		bitmap_free(roots_bitmap);
     + 	}
     + 
     + 	/*
     +
       ## t/t5333-pseudo-merge-bitmaps.sh ##
      @@ t/t5333-pseudo-merge-bitmaps.sh: test_expect_success 'pseudo-merge closure' '
       	)
     @@ t/t5333-pseudo-merge-bitmaps.sh: test_expect_success 'pseudo-merge closure' '
      +		git config bitmapPseudoMerge.test.pattern refs/ &&
      +		git config bitmapPseudoMerge.test.threshold now &&
      +		git config bitmapPseudoMerge.test.stableThreshold now &&
     -+		export GIT_TEST_PACK_USE_BITMAP_BOUNDARY_TRAVERSAL=1 &&
     ++		GIT_TEST_PACK_USE_BITMAP_BOUNDARY_TRAVERSAL=1 &&
      +
      +		test_commit A &&
      +		git repack -adb &&


 pack-bitmap.c                   |  4 ++--
 t/t5333-pseudo-merge-bitmaps.sh | 20 ++++++++++++++++++++
 2 files changed, 22 insertions(+), 2 deletions(-)

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
index 56674db562f..454f8c7a817 100755
--- a/t/t5333-pseudo-merge-bitmaps.sh
+++ b/t/t5333-pseudo-merge-bitmaps.sh
@@ -445,4 +445,24 @@ test_expect_success 'pseudo-merge closure' '
 	)
 '
 
+test_expect_success 'use pseudo-merge in boundary traversal' '
+	git init pseudo-merge-boundary-traversal &&
+	(
+		cd pseudo-merge-boundary-traversal &&
+
+		git config bitmapPseudoMerge.test.pattern refs/ &&
+		git config bitmapPseudoMerge.test.threshold now &&
+		git config bitmapPseudoMerge.test.stableThreshold now &&
+		GIT_TEST_PACK_USE_BITMAP_BOUNDARY_TRAVERSAL=1 &&
+
+		test_commit A &&
+		git repack -adb &&
+		test_commit B &&
+
+		echo '1' >expect &&
+		git rev-list --count --use-bitmap-index HEAD~1..HEAD >actual &&
+		test_cmp expect actual
+	)
+'
+
 test_done

base-commit: 845c48a16a7f7b2c44d8cb137b16a4a1f0140229
-- 
gitgitgadget
