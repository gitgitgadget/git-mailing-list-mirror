Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D0A42CCDB
	for <git@vger.kernel.org>; Sun, 25 May 2025 02:43:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748140989; cv=none; b=uEWvMrOSf6IR0uIBiJx7DdKT48RJTlROT94tl/OgjSsetz0G6MaldzS/EvofRk7B97+b9lT/I2K7eufVSyfmerPYi2OGq/lfUOi29ZDOggH8bC9Pyi/rKSV3ObX7pPc+3wvUut3YYotaCWQNUZtCcBlDokQZwCyqb0rI4LBZ0V0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748140989; c=relaxed/simple;
	bh=2che5DasQZJHufC5AUe2xOwDPTuD8Y/kz1HXq3Kx534=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=hsMGJKh6Zq9Zx4WKmT8W9uaf4R/tGE3oFSXXPib6T8k+Be7trmNjPv6Id4wIu3IuyuJOyg7i25XE9SKlB1FU78loi94h3lQRx6yameO7cwfiOIOceLxkCZCJ9thpCpfD9JCXS4uIAEf39GKkGXwU8RoUZkrGfwMmSm/UVioyIkU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EEON4fGC; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EEON4fGC"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-442ccf0e1b3so16301795e9.3
        for <git@vger.kernel.org>; Sat, 24 May 2025 19:43:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748140985; x=1748745785; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2BAB9TtnW5lFlrvp9c8YmiwGarQD9To36W8vCNbuIQk=;
        b=EEON4fGCQlR35RBtcaz1s0T0uCycrgXGb3rcaldCTENzq1Vunn8yvEV4AuXcyuKf6L
         r9bVleJCANaQBtSawkrLGSqEgMDALfRsjEc/LvSS7HgkgH032w89btCpa/WZ4tf8SpRt
         2E2ic8uOGsdVtteDBOqSa8ZlvivheM+0oyh8b6QxfutBeQMBQfWezDBg1XHntkn4uHBG
         5lYrg0HcxKJgBrvPHt3mu4G6FMwhEhiXQybU44GdYBleo3Ro4Nhbbv26ehl8j0Hv/XwO
         mGFBT2YnHXZM7sqjiMx5FR0wmYMIGB1WVVCgZ9v6DiGVMDzRDDt5Wka9aLZ5pZvwUkmI
         ZQtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748140985; x=1748745785;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2BAB9TtnW5lFlrvp9c8YmiwGarQD9To36W8vCNbuIQk=;
        b=gUB3qu84BXW6o4ryQ1rqq3rNhhLJobhNxQ2m+o6fwSckYthkhglT+W9L2CMqCq7D8c
         xs3ElMHLbFJxtKVV2Ssh5nT98oNZokGCvukYCBe5sp9xBJBimL8xPL9cAB4jKOszqLLw
         f/cBoNt+b8w4AiGsSoMjmyL4hNHKQbmstBAtkdhh4k+A/ZWNkqoT8gdnU8x0nBXl7ITq
         bkybVa7wfkGtmEWmiqykH7ZJqwncRhj77bUXMi+wdNB7E2QSOTd8kLC8PCTlAUkp/pu/
         0gwBlZhPV6HIzzK7o0ohgHXH+XTv5faDvW6SCk2lVetZK0Zk/g2am6iHVVT7OrpLiVwN
         qUow==
X-Gm-Message-State: AOJu0YybgZSiXKDUqAXMxJN7Kmuip+AEMaFftyeIhk43hTVYpbNoCPoe
	VkBjAmx1DyJ1s2t3K/6qUd5fa+wdKa9j2zQyFfFhlDc9g5nWGicsuoO+vQ63Rw==
X-Gm-Gg: ASbGncvwTdO2SQJ5gYVHCrZmvMMZPUttVwX/1zkZk6ivhQnnceJAm2QOseg6TlGjKF5
	X8VIpr/E0e5E4NUQqTJWIJEdcbI6QiqHjegq8OFhF+93sTEt7F0FStAVC7HH/Gfz2cgzQPWnqXA
	kDA5jZzcnoS0h2mJ6c+jSEK1tVC//ARjp0rIeJrZmiqhzt9THmcJ3gu00Lhi/ab5xytGZMJR81a
	s7j2HtcNJYLZ9Wco9u0wx8uj6ZKneewM8Oh5ZP6mq1zWvQA1fL5bmtla36vdE1d/ZwEjGktm2J5
	Kl8jZy+D5gkGxzholcmSJKrJNGWGWMBCBsW54saSBtNFQNknqWQc
X-Google-Smtp-Source: AGHT+IHpYN5Z+lRQv7hwrRjqewLZng+f9y9qiGpO0or0BsC/IEOiO3JtktaK+lymQPX428XDjGW7Yw==
X-Received: by 2002:a05:600c:1d0d:b0:43c:f44c:72a6 with SMTP id 5b1f17b1804b1-44c9160702fmr42309355e9.2.1748140985187;
        Sat, 24 May 2025 19:43:05 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a4ce65342fsm3162561f8f.6.2025.05.24.19.43.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 May 2025 19:43:04 -0700 (PDT)
Message-Id: <b6b3a83a22486d0c104c494d1950fdaa2f2a658c.1748140983.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1962.v4.git.git.1748140983.gitgitgadget@gmail.com>
References: <pull.1962.v3.git.git.1748138764.gitgitgadget@gmail.com>
	<pull.1962.v4.git.git.1748140983.gitgitgadget@gmail.com>
From: "Taylor Blau via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sun, 25 May 2025 02:43:02 +0000
Subject: [PATCH v4 1/2] pack-bitmap: fix memory leak if load_bitmap() failed
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
    Lidong Yan <502024330056@smail.nju.edu.cn>,
    Taylor Blau <me@ttaylorr.com>

From: Taylor Blau <me@ttaylorr.com>

After going through the "failed" label, load_bitmap() will return -1,
and its caller (either prepare_bitmap_walk() or prepare_bitmap_git())
will then call free_bitmap_index().

That function would have done:

    struct stored_bitmap *sb;
    kh_foreach_value(b->bitmaps, sb {
      ewah_pool_free(sb->root);
      free(sb);
    });

, but won't since load_bitmap() already called kh_destroy_oid_map() and
NULL'd the "bitmaps" pointer from within its "failed" label.

So I think if you got part of the way through loading bitmap entries and
then failed, you would leak all of the previous entries that you were
able to load successfully.

The solution is to remove the error handling code in load_bitmap(), because
its caller will always call free_bitmap_index() in case of an error.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 pack-bitmap.c | 21 ++++-----------------
 1 file changed, 4 insertions(+), 17 deletions(-)

diff --git a/pack-bitmap.c b/pack-bitmap.c
index ac6d62b980c5..fd19c2255163 100644
--- a/pack-bitmap.c
+++ b/pack-bitmap.c
@@ -630,41 +630,28 @@ static int load_bitmap(struct repository *r, struct bitmap_index *bitmap_git,
 	bitmap_git->ext_index.positions = kh_init_oid_pos();
 
 	if (load_reverse_index(r, bitmap_git))
-		goto failed;
+		return -1;
 
 	if (!(bitmap_git->commits = read_bitmap_1(bitmap_git)) ||
 		!(bitmap_git->trees = read_bitmap_1(bitmap_git)) ||
 		!(bitmap_git->blobs = read_bitmap_1(bitmap_git)) ||
 		!(bitmap_git->tags = read_bitmap_1(bitmap_git)))
-		goto failed;
+		return -1;
 
 	if (!bitmap_git->table_lookup && load_bitmap_entries_v1(bitmap_git) < 0)
-		goto failed;
+		return -1;
 
 	if (bitmap_git->base) {
 		if (!bitmap_is_midx(bitmap_git))
 			BUG("non-MIDX bitmap has non-NULL base bitmap index");
 		if (load_bitmap(r, bitmap_git->base, 1) < 0)
-			goto failed;
+			return -1;
 	}
 
 	if (!recursing)
 		load_all_type_bitmaps(bitmap_git);
 
 	return 0;
-
-failed:
-	munmap(bitmap_git->map, bitmap_git->map_size);
-	bitmap_git->map = NULL;
-	bitmap_git->map_size = 0;
-
-	kh_destroy_oid_map(bitmap_git->bitmaps);
-	bitmap_git->bitmaps = NULL;
-
-	kh_destroy_oid_pos(bitmap_git->ext_index.positions);
-	bitmap_git->ext_index.positions = NULL;
-
-	return -1;
 }
 
 static int open_pack_bitmap(struct repository *r,
-- 
gitgitgadget

