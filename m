Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE8F7400DF4
	for <git@vger.kernel.org>; Tue, 19 May 2026 16:12:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779207157; cv=none; b=VS5ssYPnaDyJW6RK5HpSgf2LWlj3k6ys/TNqKCI3MOlQL5RKJXOyEs/3RMJZNM4LJTr29l2yNPBRV9jLT+5zbBo1fu8s/jxt483LvdjeXyeCYa/atIXDH7bddQpjvhI93df8SDIA7NgrVklOIQef9eh/JYeoxAZQWkSUGx5GfdY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779207157; c=relaxed/simple;
	bh=weHMWDgCwXghrJRxmmcYHuFfb3bD4b1ts/hZoOrZXpw=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=etZECMvj0R6l1+aVUxJSscSP9mFb/SBpxzRI6WALabqbJmVPicyLrDbr0ssFIqD3W+byN7JPU1Su4kw4peFJWHIpDRfnvMzmvEZmOEkMIT7hpOmruIhsfHKsBs9x5wE75fXgfog5aAnrNNTgjjMHr+s1EyigasM6gJ3hs4YR0Zs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b=KLK1vLvm; arc=none smtp.client-ip=209.85.128.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b="KLK1vLvm"
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-7bd4c61765dso33704237b3.3
        for <git@vger.kernel.org>; Tue, 19 May 2026 09:12:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr.com; s=google; t=1779207154; x=1779811954; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JbB0kqdNtxkVIbD2e/Isdc5v515A6sM5RVBVh5eSxiY=;
        b=KLK1vLvmESwQ82DynjYVbydvmQta9G6TjJunzG6NQVwJe7QFcswpHi0y2akSdh8hfu
         1Ht/pQVydtxNqXLy6YLpzQ15UF+Q4EK3lu4OEpF8I+L9ph5Hu94bOhq97DVcH5UAKVrx
         8iXMZpTbEbw7FegCHTTYmILPBmzkmJ++ZU7urrDcIPOyuQPcxjQz0iCII7YRA8J7MyXi
         RnDnfnnl1Sv+yKv/L4T52oeRa+582rFzURDLJhEfM4zsMXjtKEf/COOKdWgJG9Wc7mee
         Glzp74Lv7EfQupOD7tNfF1j0GLCrMcouFo8gzvjYIEVJUBOpk5kIfID4psBFMwFvLy6V
         5NnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779207154; x=1779811954;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JbB0kqdNtxkVIbD2e/Isdc5v515A6sM5RVBVh5eSxiY=;
        b=dslOZD7jpbtvR9M6CAVCMazNP1vIo2Et/dUZ33G97gvXA01LUn1xu8XclDSVOlYYKg
         dEV29c/xnln2ymbu78NzTFIpQBg4yw3DpEuU0MTnltrJgTsfQV74T95JDAOsA8RdATkE
         c53678PEU28vY7L/hkSvCz6jrke1XF29pGR13i34bfeqyPDnJus1FJetSkDVHm9t2pYn
         GJ226utVhD6Ou1P24DqY/g3DJz52AoDWcYeqk6y2GVy1X84hxaiDyz9BhqvfRwBEwNgq
         QC+Ddvgq39LKjWe0iAKDlAJhv8ciZkTC9jlZPlY/dlytUsD1hyJzho0sqtmy3/lhwcy5
         nRVw==
X-Gm-Message-State: AOJu0YyISJBXn5uL3Iz6ACJCiU0F8P6XxpNeO+J+TUnqtv49E2w2EGCv
	aULFxKPoh3Xp0mOUG6gO7j1O6h3GQPIEHQIqcQ6yRmSW9+uw4uMKJWg9/LfAbOvkjieLQEDxTy5
	MTHWFYFOHwA==
X-Gm-Gg: Acq92OEOBl1PTpyAAL7gW+eE0fff/u4srCPDPFV2S78PuMk1pAqJGZaXHsF6i42qofS
	NKUyeU4dGNL6Ye9WzjWys0k/7jUr0hNO5zWeWHYWjzwgABc1zEzpyzf9QP+ocZz8+yB0d3Z2M4V
	NHMkFcGWLgfuFmlCTnD3KOr6g2tIz0jXE1ktaEcrEyBvQcU0UJNY/bAicpku2b76eVvjFsjpMjA
	UzKLnUofpUm+YItNKI8UWFOSWAezpuvpPxXL/e0BuLaLS55cTx2Od6scpCpefrQCyUaqcMeKJ60
	vid1kmTaScFuyGlF1/nGyRFLnhML8g7F3c2PpIs6UqZGnNmwULKWKFGLLJBznCW2wVdsHJ4B35r
	46nxYuu2M54CelOMk7jxZLuT8VU3a9IZsd2iVuSdkRixgNzrHefd2oDHL4o3SKm0jlXFMGA0Dm/
	RbWd0J2/rscl5fx5wZVfhHvuE58WvTy9FJeAGLGNnI/y6ICNJfsOruD8yZUbB3g7RP+qjwsB6RG
	oSNAMzuUZTqP8hQMROefkkDWgh/OTnVppHs/viXv7JnYczRp7DUr33FIoWsbm9Il3BrBA+kCBiB
	GTsVnW6jDAi26+z1a43AKR6wkiA=
X-Received: by 2002:a05:690c:ed5:b0:7bd:4a12:f08b with SMTP id 00721157ae682-7c959b9161dmr217993967b3.3.1779207154526;
        Tue, 19 May 2026 09:12:34 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7cc9d18dcddsm38706817b3.49.2026.05.19.09.12.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 May 2026 09:12:34 -0700 (PDT)
Date: Tue, 19 May 2026 12:12:33 -0400
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Elijah Newren <newren@gmail.com>, Derrick Stolee <stolee@gmail.com>
Subject: [PATCH 0/8] pack-bitmap-write: speed up bitmap generation
Message-ID: <cover.1779207127.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

Note to the maintainer:

 * This series is based on 'tb/pseudo-merge-bugfixes', with
   'ps/clang-w-glibc-2.43-and-_Generic' merged in. I suggest queueing it
   as 'tb/bitmap-build-performance'.

   The latter merge is only to avoid the current Clang/glibc 2.43 CI
   breakage, and is unrelated to the bitmap changes themselves.

This series improves the performance of reachability bitmap generation,
focusing on very large repositories and the penalty to generate
pseudo-merge reachability bitmaps.

The first few patches address hot paths in the ordinary bitmap build:

 - pass object positions into `fill_bitmap_tree()` so callers can avoid
   redundant lookups,

 - check subtree bits before recursing, which avoids many no-op
   `fill_bitmap_tree()` calls,

 - reuse already-stored selected bitmaps when `fill_bitmap_commit()`
   reaches a selected ancestor, and

 - add a small direct-mapped cache from object IDs to bitmap positions
   to avoid repeated pack/MIDX lookups while filling bitmaps.

On the large repository that I have been using to benchmark these
changes (~4.8M commits and ~57M total objects), the no-pseudo-merge
bitmap generation case drops **from ~612.5 seconds to ~294.1 seconds**.

The next patch sorts selected bitmaps before choosing XOR offsets. This
does not change bitmap selection/coverage, but in the same repository it
shrinks the generated bitmap file **from ~635.5 MiB to ~176.4 MiB** by
putting related ancestor/descendant bitmaps close enough together for
the XOR search window to find them.

The final two patches focus on pseudo-merge bitmaps. The existing code
feeds pseudo-merges into the same maximal-commit selection machinery as
ordinary selected commits. That machinery works well for real history,
but not pseudo-merges.

Instead, this series builds ordinary selected bitmaps first, then builds
pseudo-merge bitmaps afterwards. The later pseudo-merge fill can still
reuse stored selected ancestor bitmaps, and can also reuse an existing
on-disk pseudo-merge bitmap when the parent set matches.

With the coarse pseudo-merge configuration used for testing:

    [bitmapPseudoMerge "all"]
        pattern=refs/
        threshold=now
        stableSize=10000000
        maxMerges=8

, the optimized no-pseudo-merge case takes ~294.1 seconds, while the
**pseudo-merge case takes ~328.4 seconds**. Before the final change, the
same pseudo-merge configuration took ~575.0 seconds.

On our testing repository, it is faster at the end of this series to
generate bitmaps with pseudo-merges (~328 seconds as above) than it is
to generate bitmaps without pseudo-merges at the start of this series
(~612 seconds).

Thanks in advance for your review!

Taylor Blau (8):
  pack-bitmap: pass object position to `fill_bitmap_tree()`
  pack-bitmap: check subtree bits before recursing
  pack-bitmap: reuse stored selected bitmaps
  pack-bitmap: consolidate `find_object_pos()` success path
  pack-bitmap: cache object positions during fill
  pack-bitmap: sort bitmaps before XORing
  pack-bitmap: remember pseudo-merge parents
  pack-bitmap: build pseudo-merge bitmaps after regular bitmaps

 pack-bitmap-write.c | 431 +++++++++++++++++++++++++++++++++++++-------
 pack-bitmap.h       |   7 +
 2 files changed, 377 insertions(+), 61 deletions(-)


base-commit: c3d7ca7d982efc3a848fd85f34e867cfc0a99479
-- 
2.54.0.rc1.84.g30ce254312c
