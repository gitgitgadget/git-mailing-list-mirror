Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D521636DA1D
	for <git@vger.kernel.org>; Thu,  9 Jul 2026 16:49:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783615784; cv=none; b=mJFs2T4WT/p7Oh4W8WL8YC4O+5T+UR5CpmNig28gITfwiSddZnWKBpmf8cuE2q7UCSOEr7X9uEqgm4x4ER6kMXnVx4btR99qpQnuiC5m5wb9aW7Qg98lhC8WADWaWLeHdtLvAQpx3ioqjNhHM86/FIyugkm3KmPoGpp8qMEjiF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783615784; c=relaxed/simple;
	bh=sgTjeqf35g24qeoenP9TC0DRvyLAoGjFExh7X65/vqc=;
	h=Message-Id:From:Date:Subject:Content-Type:MIME-Version:To:Cc; b=oHHMANC4pqzoULTA6Xdz6TGrOtguCJb6sbhQDhppp3Ejt7QT0U+cySw3AEByCVUTw4vrb6nPV0aCf1c2TYY7W/s1QuEo3vpusGlD7rb6fJLeVtWTnXy8uTVaNlNdL8hpzFGB9I+o+t2XkGRZ9ebRFLKCMg3eS9vmQfOripH21t0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WoU1b1yh; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WoU1b1yh"
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-84864b41100so499578b3a.3
        for <git@vger.kernel.org>; Thu, 09 Jul 2026 09:49:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783615782; x=1784220582; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=SoVJqXhh60zPLjNCArvbr9UkfhlLrnm9iEuvPxCcbMs=;
        b=WoU1b1yhMdODFTZIajRmIbwjFiyQONhHMjheOSp4G7xNlD5pnpK/ReL6tCFCLGQLZq
         5eUbA8HdrP5Pa8yNlyFQy3RgkZ3HtVzSAkE1tlyjISZaas7ZR6Zmzk724sKjxxUSwfEM
         xQ+o8Uq6StC8Sek1/umuL8pvqcbL45+iofRJwSgGDw8LISuExRUpv7VfQ+4Aws965TFM
         fi7jmo/zwdMz/fC3KA8uz+DmWMeFwbarelsky3PyN8qi1JWnhUXMVHk1Tet8hvW8AbD4
         c4qjDTp/ih9aa4aMC8ahguy4hCZjhxEuWqjZxuVNanVbvguEW+/Tr8d/VSl95X/m8rLn
         GRZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783615782; x=1784220582;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=SoVJqXhh60zPLjNCArvbr9UkfhlLrnm9iEuvPxCcbMs=;
        b=DBd/R6U2x/Nk0VwhdC9UeJtCIp1KmyR1MaVNWcUOFUg68fp2xIfCU/RjPuTGwREw/Z
         syXf5Lt1TIer9vlF4DbDeR1JZ+avJW6jGIxxv/830zSY769XsLyLxE7lBMZgo4t1ziV3
         UDS0gcRj68lMws6yepuBuKGkRfwSxON3Iet47DB+WkdGLvhLoPzo7+3bLV8cT9lpfPBE
         UFmbE0DECvoNTYvmeWistdz5SQShzjaJBBtsoZeah2ZxNPPYaStteIQOitypFQRcAoNo
         wXei0irH5CRIqF5TjAi0ha0d3brUupJoI06Aw8OmP1sULIfDAo0ZUTwgsAEwPHvbI71O
         JOMA==
X-Gm-Message-State: AOJu0Yxy0ACaa5PJF+wo7bGJ0oYDg56EtU9DWeBZc9FIs1YEG3OqhvuK
	J5WUIbQRgnrZ4soSG+IKjhKs5lhKbacYf+QhL4oLfLtNhRPxUp14mdS6FgoBWA==
X-Gm-Gg: AfdE7cmCfs6lXRDVo0xxt3kyI4alIfp7pExbPTmHiphEWexPr+5i4Th2KuIYWfx3028
	8xP9ai7ALKSerCOQVZh0ognGQwKo99G7cZaWsRePDhj3q9xvrsZTHlEfmx81ctYB1/ues+MoCdk
	SjycJ5IXnnk9ddPphIBybvIBFdobQE4ArdBs5Jzu25mvuR5J8SC4sJ8QGhDYDDuY42PZi6UkoVf
	CzrIf5dEmop54+7iMiv+B9Bi3rcxL8pZbDae0vBnQsmLK5zI10exY5+nWMcC1auD36byucKolKE
	/V+Gpp+xHBuZkIEvI8JaJ1V9BloOIsSMQGtj26TZGfAmCFOcuhP9rQjCCCSeCR6xS5PgdS83YR7
	kDusFARA/sltMu/TW/zWmvha+X/x01duuKf8FyWJnVD+JlhLYPrRFmv3/gQi4PYKXIzsjv5wQVj
	qbztQJMUPZ1WhJ4g0=
X-Received: by 2002:a05:6a21:1bc3:b0:3c0:9c19:658a with SMTP id adf61e73a8af0-3c0bcfea23fmr9276976637.68.1783615782172;
        Thu, 09 Jul 2026 09:49:42 -0700 (PDT)
Received: from [127.0.0.1] ([68.220.59.115])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-31174892711sm33942484eec.13.2026.07.09.09.49.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jul 2026 09:49:41 -0700 (PDT)
Message-Id: <pull.2175.git.1783615780.gitgitgadget@gmail.com>
From: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 09 Jul 2026 16:49:27 +0000
Subject: [PATCH 00/12] Next size_t stop: pack-objects/delta
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
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>

This patch series continues the effort to stop using unsigned long where
size_t should have been used in the first place. This makes a difference on
64-bit Windows, where unsigned long is 32-bit.

With these fixes, the pack-objects machinery works as intended on 64-bit
Windows (and any other 64-bit platform where unsigned long isn't 64-bit).

Johannes Schindelin (12):
  diff-delta: widen `struct delta_index`' size fields to `size_t`
  delta: widen `create_delta_index()` parameter to `size_t`
  pack-objects: widen delta-cache accounting to `size_t`
  pack-objects: widen `free_unpacked()` return to `size_t`
  pack-objects: widen `mem_usage` and `try_delta()`'s out-param to
    `size_t`
  delta: widen `create_delta()` and `diff_delta()` to `size_t`
  packfile, git-zlib: widen `use_pack()` and zstream avail fields to
    `size_t`
  archive-zip: widen `zlib_deflate_raw()`'s maxsize local to `size_t`
  diff: widen `deflate_it()`'s bound local from int to `size_t`
  http-push: widen `start_put()`'s size local from `ssize_t` to `size_t`
  t/helper/test-pack-deltas: widen `do_compress()`'s maxsize local to
    `size_t`
  git-zlib: widen `git_deflate_bound()` to `size_t`

 archive-zip.c               |  2 +-
 builtin/fast-import.c       |  6 ++++--
 builtin/pack-objects.c      | 30 ++++++++++++++++--------------
 delta.h                     | 12 ++++++------
 diff-delta.c                | 12 ++++++------
 diff.c                      |  6 ++++--
 git-zlib.c                  | 16 ++++++++++++++--
 git-zlib.h                  |  6 +++---
 http-push.c                 |  2 +-
 pack-check.c                |  4 ++--
 packfile.c                  |  4 ++--
 packfile.h                  |  3 ++-
 t/helper/test-delta.c       |  2 +-
 t/helper/test-pack-deltas.c |  7 ++++---
 14 files changed, 66 insertions(+), 46 deletions(-)


base-commit: f85a7e662054a7b0d9070e432508831afa214b47
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-2175%2Fdscho%2Fsize-t%2Fpack-objects-delta-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-2175/dscho/size-t/pack-objects-delta-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/2175
-- 
gitgitgadget
