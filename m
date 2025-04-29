Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6ADFB23D2A3
	for <git@vger.kernel.org>; Tue, 29 Apr 2025 15:47:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745941668; cv=none; b=lirb7c0Qlt3G9t+TUXktcuLwjmsLxhe/6VrnGuQY7qKKxrHcazgDLmDwnYgRf9pyCZXCpNjcLMrGf3CurreRRUnBZKWo9qt33yc5vS3J/2Vy9mcE6tuP3YHQCRr7tAnBSz5MDhapjyW4anx/xVgKIQOPogNzV1Mg98U7MuCfXaQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745941668; c=relaxed/simple;
	bh=4Tl1KdnBapSAulVZB9DgOoMTYv3wjVf/WNaUeymsLKk=;
	h=Message-Id:From:Date:Subject:Content-Type:MIME-Version:To:Cc; b=CYvVV8w4YaN4xVLCDDfZ9TLKXB9qip3mPfqijnjUH4rJ15zJNlk/HCPa9yCdLy439sBHfjBsli9x2oy9Wf71QICgkUjtM9LL2UBH4ii+a/HIxIFiO4zkyLE2JR/nBKvL0j1qhB+pI80J31Y/v/HCWe1q8eX+V4wt8vtwVo4pEc0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iyvux2BW; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iyvux2BW"
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-39ac9aea656so7150052f8f.3
        for <git@vger.kernel.org>; Tue, 29 Apr 2025 08:47:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745941664; x=1746546464; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Np7/PSW28sQ9U1V77OZQc3bTmBBjKY0+v6ur+mzYNIg=;
        b=iyvux2BWHM8IfDcRh+6m+Otzhkc/wptHgh0dOgxbY5VPCMzisMao4E8Y5ciX2MHgNA
         rbeYZPWa2os+m0o67CXUNBC1hnO03knm/Ca/xhyvC/B7NWSt3jWEGeslDAwh+2VM/3Rt
         OjihHF/KkykJVoMfyHM2BS1Xj6YqZVH3LswBeuDaHzwpTmdIsimqssFrkvJfiLG6fTFI
         2wVELJtDX01pCoXhBPvx7SvJjOxF4hnVJkvZSbj60W2vevPucelvsQUrwC/JnPfdVQDA
         0aFM5uTPNHT6vH9JdTniCbB1dw0ZelSWCWcop34W2mH4/B/Ikc/vM/wEBsHoAt3hEAwp
         6g0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745941664; x=1746546464;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Np7/PSW28sQ9U1V77OZQc3bTmBBjKY0+v6ur+mzYNIg=;
        b=d+CSQeLOXpYb/RRg9hfKK8Tbb0KLcEhs90ryhQ8JuXhOCB9d7UCWom4NuCGXc4NE18
         mYw25/hkcPxV1xX3D3lfIjOmmsiKUhgzLYmFgKt/qdeuRyrxKkr64RRuy1IxKUVgdBDR
         kF9XXmS4KWAGegkPaZoGH5qMjulPDMKv0BXeZovwYl/NASIuRg4folG8TaT9hFGmQDCv
         jWs/1zndMF8Sb7NKAlNY7xE0LQ9OLTRh8TOZDqNdnZAQOSSfPaixufdDGA3IZ5zzNBIP
         h3hJRLDtqkVAKiVw8fafa9Hd3kyylBrGcayVq2BhUaR7vmhK2pxWebjVQht2xWkYB6K4
         zVzQ==
X-Gm-Message-State: AOJu0YxxQ/VOduNOzuSx8X1ae2ay6k89tq3xMxnYdGoeehtfEqQ16Kwt
	gCIw+mDrrHvQ6xiJjL+4AxVOOIq7p1ITTQZ0mp2tS80KsSE1vWZBAXUm8Q==
X-Gm-Gg: ASbGncs7BLY8XPRWjAeniGBxHjVTwr846Wg+aHVVQ5OGagTc68NChvgHYTSzdZaNq27
	jtKrfOO+XyA5f8BP90FpPPS6URyFJ08367xDb44lIpLqw6Mo98CdkvQT9Vp0+yZUnk42KNfv9b2
	InAfd1OA6yEEgOG3B0E+UNL2fH6mLBrInbIofnCGNnEMmz1hwGm4NvFrBMQcGSkziYUZR37fVC9
	9yn1EvTlor4/EmzXyrqHxraZ9Evb//TkOQWi5dB7CnWywCXkuCLiyu3ITz7fSlRTpDSjkmKHcDB
	PEqJ5DXYn6QqpeEs7Zy+/e9LisO+Q2dnGig5rSUZYw==
X-Google-Smtp-Source: AGHT+IE5JD6G0jU3ndcWNs3DsrzK4L0FXhzylqm5BM2b94ITwvO8p+eUF1RKpCHf0sy3K9ivaTV+gA==
X-Received: by 2002:a05:6000:40c9:b0:3a0:830a:3d63 with SMTP id ffacd0b85a97d-3a0890a518fmr4422210f8f.9.1745941664187;
        Tue, 29 Apr 2025 08:47:44 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a073e5da02sm14391448f8f.93.2025.04.29.08.47.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Apr 2025 08:47:43 -0700 (PDT)
Message-Id: <pull.1911.git.1745941663160.gitgitgadget@gmail.com>
From: "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 29 Apr 2025 15:47:43 +0000
Subject: [PATCH] hashmap: ensure hashmaps are reusable after hashmap_clear()
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
Cc: Elijah Newren <newren@gmail.com>,
    Elijah Newren <newren@gmail.com>

From: Elijah Newren <newren@gmail.com>

In the series merged at bf0a430f70b5 (Merge branch 'en/strmap',
2020-11-21), strmap was built on top of hashmap and hashmap was extended
in a few ways to support strmap and be more generally useful.  One of
the extensions was that hashmap_partial_clear() was introduced to allow
reuse of the hashmap without freeing the table.  Peff believed that it
also made sense to introduce a hashmap_clear() which freed everything
while allowing reuse.

I added hashmap_clear(), but in doing so, overlooked the fact that for
a hashmap to be reusable, it needs a defined cmpfn and data (the
HASHMAP_INIT macro requires these fields as parameters, for example).
So, if we want the hashmap to be reusable, we shouldn't zero out those
fields.  We probably also shouldn't zero out do_count_items.  (We could
zero out grow_at and shrink_at, but whether we zero those or not is
irrelevant as they'll be automatically updated whenever a new entry is
inserted.)

Since clearing is associated with freeing map->table, and the only thing
required for consistency after freeing map->table is zeroing tablesize
and private_size, let's only zero those fields out.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
    hashmap: ensure hashmaps are reusable after hashmap_clear()
    
    Ran into a NULL pointer dereference of cmpfn a few months ago when
    trying to reuse one of {strmap, strset, strintmap} (don't remember which
    one) after calling the relevant ${TYPE}_clear() variant, and tracked the
    NULL pointer back to hashmap_clear(). Turned out to not be relevant to
    those patches because I ended up not needing to reuse the map after all,
    but I kept a note to myself to send in a fix.
    
    I was surprised this wasn't a bug we were already hitting somewhere, but
    I looked through the codebase and it appears that the only time we
    attempt to reuse a hashmap after clearing is when we specifically use
    hashmap_partial_clear(). So, this is just a latent bug waiting as a trap
    for someone.

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1911%2Fnewren%2Ffix-hashmap-clear-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1911/newren/fix-hashmap-clear-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/1911

 hashmap.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/hashmap.c b/hashmap.c
index ee45ef00852..a711377853f 100644
--- a/hashmap.c
+++ b/hashmap.c
@@ -205,8 +205,9 @@ void hashmap_clear_(struct hashmap *map, ssize_t entry_offset)
 		return;
 	if (entry_offset >= 0)  /* called by hashmap_clear_and_free */
 		free_individual_entries(map, entry_offset);
-	free(map->table);
-	memset(map, 0, sizeof(*map));
+	FREE_AND_NULL(map->table);
+	map->tablesize = 0;
+	map->private_size = 0;
 }
 
 struct hashmap_entry *hashmap_get(const struct hashmap *map,

base-commit: f65182a99e545d2f2bc22e6c1c2da192133b16a3
-- 
gitgitgadget
