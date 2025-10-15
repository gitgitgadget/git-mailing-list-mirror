Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD193218EA8
	for <git@vger.kernel.org>; Wed, 15 Oct 2025 21:18:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760563106; cv=none; b=YRIqrRM8iL673QtHX9+uajClIEl+9ug7x7P2hDKEjjzGQ6gINg5rWqBni1pBWiXXE7hJ7E7TpBxY622Dqm6KP2q3I51plUv+H+/C25aihrBTNuI1IKR9zS5Mu/XrPfpRZ8lO9anaOBdyNwBo13IRhI5f3N9oQ77SLPhOnuf5irs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760563106; c=relaxed/simple;
	bh=vkGAYCmNomCst1z3duhCnI2C6y9Pg+e1qRgbxrSbyhA=;
	h=Message-Id:From:Date:Subject:Content-Type:MIME-Version:To:Cc; b=CJEDzYJ7DsVQvg+cpumOD/ubFRqNG57Xf9zEpbBvm4UCSYa5A+hR7YZ1kWw22JUW2nh10CG0hO0yqFiFMBSQqFNVZNuWZlT3zrYr/OGCaumGJ6SfpSuVY0Xnumi+j2r5EI63vNJ7naE9vkGyNgRXSdQ4Nbn25GQ3xeONZ97OwIo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LOn4DVBF; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LOn4DVBF"
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-339e71ccf48so102864a91.3
        for <git@vger.kernel.org>; Wed, 15 Oct 2025 14:18:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760563104; x=1761167904; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=2pCbDlHPwNBW7Zt1vfem0dRLnBw+eA9+h+CEJbTkR74=;
        b=LOn4DVBF4cvSl/EzZ4uY6ykdo9adPngPGP0kH3XCJEDfFZwXzuXgi/PvhNtW34FM8Q
         MDUotfxV2tfM0f+KDHJwoE7rpGt2xJpcdYyNWHvQldscr9jCmiWDNzq8WAWVznL3FTKY
         XnNPK+WGaWHfkBVp6jiV+XwxPi6JwtgJEkannaqveRHy9iRHLnOCP7D9MR7sLhGMtcKj
         NfIIcnFiZafzZIGeyerV2CIUUFMLSvSvA91OsYSNt2fEnEozq+LnG17vd8hFGjCrP8HL
         5YQFE4A6p0H1YW0RoC+oKQSq45j30yb5LnUb9dQxZCMdj2GLNPvwPeaENz31iu5Qb9tF
         JHFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760563104; x=1761167904;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2pCbDlHPwNBW7Zt1vfem0dRLnBw+eA9+h+CEJbTkR74=;
        b=BOX1YvTPi5rVRiotUukRgyNayK8RAuXOoEE/HHEBhLgDwsvXWuYyv84Q9iU08wkMYB
         MEqFUyxsIpeWjq1e+UYBqNI7M92A9PtZsTuMv9cc1F9GU71q5t0kitMmF5FmLNkKP1eM
         SdN50aJZrmKkUrifId+QVnEoVkJO3pK/PTDPDoDnClOsB59g5/v4LrGZ8LaJe4vxp/dS
         L29rwdEMirIMCHbsbRwHQyRtZ2/vFPGCaCZqX3t01pHim40OQq4DqNw6cUI+VO10/FGh
         ZzbDo1Fxxf35PXDKltvJlvLGNpCa3+Ylcc1vhA7CXed3Pg3w1YgVj3ZAJvlKZ59wQSZf
         PpHg==
X-Gm-Message-State: AOJu0YywnQhHICTGFKH2DS5xZupzc3m/XhV+1xmUu+xLgmvpf/weZP0U
	/Ic3GlQKBABjTbB89wmZ1ZOY+wxyigkM8QcrcnHtlHNhsMGCduS8dTxmDliboA==
X-Gm-Gg: ASbGnctyYhMOTQgowtku++Zd42EYglJn7b7JufHxjTbQazB5TomnWXf/+8O8jeJoDsV
	FVFUXVcrpKr8jeT5gF9eEapy9xWADDq6+8d3reGmSwoWHM8LPhTXdXb5hKLNHfw+H37Y+PGNHa1
	GimGaLIZbi667Prc0kZEwz3M0+0B2PQn505GxvoBke6wJdVEE2OmUCjeWWGWPFnRTf5s5gzSvo8
	y1qTnhBsY9n5X8gydXCTP+A1dTn2Bj2Sk7VFnlgq2B4FAXZsNfhwkTJ5TKOwmlGR9A6bnk4Zkqo
	bndswejOQqjpI4n7pHHt4TtbKfN2bK4R9dpaqZwmOg3zcfg5tvxfKkAcW+u/gAFYIZKsYIT+e2W
	uifuiTDUuX8VWceQAMgWcPdyitRJb7JWRPjT9qsOuU+3w4EVEB1dB
X-Google-Smtp-Source: AGHT+IFIYwH4tdMjsZdAK0l2l2Uaa0cmJx3eXvoZ8YpoNsATl1DaWv4Rq6ppxX91DCCt0UbTgkSs6A==
X-Received: by 2002:a17:90b:3d85:b0:33b:6650:57c3 with SMTP id 98e67ed59e1d1-33b66505c71mr25550811a91.21.1760563103060;
        Wed, 15 Oct 2025 14:18:23 -0700 (PDT)
Received: from [127.0.0.1] ([13.83.161.23])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-33b9786e602sm3654402a91.11.2025.10.15.14.18.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Oct 2025 14:18:22 -0700 (PDT)
Message-Id: <pull.2070.git.git.1760563101.gitgitgadget@gmail.com>
From: "Ezekiel Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 15 Oct 2025 21:18:12 +0000
Subject: [PATCH 0/9] Xdiff cleanup part2
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
Cc: Ezekiel Newren <ezekielnewren@gmail.com>

Maintainer note: This patch series builds on top of en/xdiff-cleanup and
am/xdiff-hash-tweak (both of which are now in master).

The primary goal of this patch series is to convert every field's type in
xrecord_t and xdfile_t to be unambiguous, in preparation to make it more
Rust FFI friendly. Additionally the ha field in xrecord_t is split into
line_hash and minimal_perfect hash.

The order of some of the fields has changed as called out by the commit
messages.

Before:

typedef struct s_xrecord {
	char const *ptr;
	long size;
	unsigned long ha;
} xrecord_t;

typedef struct s_xdfile {
	xrecord_t *recs;
	long nrec;
	long dstart, dend;
	bool *changed;
	long *rindex;
	long nreff;
} xdfile_t;


After part 2

typedef struct s_xrecord {
	uint8_t const *ptr;
	size_t size;
	uint64_t line_hash;
	size_t minimal_perfect_hash;
} xrecord_t;

typedef struct s_xdfile {
	xrecord_t *recs;
	size_t nrec;
	bool *changed;
	size_t *reference_index;
	size_t nreff;
	ssize_t dstart, dend;
} xdfile_t;


Ezekiel Newren (9):
  xdiff: use ssize_t for dstart/dend, make them last in xdfile_t
  xdiff: make xrecord_t.ptr a uint8_t instead of char
  xdiff: use size_t for xrecord_t.size
  xdiff: use unambiguous types in xdl_hash_record()
  xdiff: split xrecord_t.ha into line_hash and minimal_perfect_hash
  xdiff: make xdfile_t.nrec a size_t instead of long
  xdiff: make xdfile_t.nreff a size_t instead of long
  xdiff: change rindex from long to size_t in xdfile_t
  xdiff: rename rindex -> reference_index

 xdiff-interface.c  |  2 +-
 xdiff/xdiffi.c     | 29 +++++++++++------------
 xdiff/xemit.c      | 28 +++++++++++-----------
 xdiff/xhistogram.c |  4 ++--
 xdiff/xmerge.c     | 30 ++++++++++++------------
 xdiff/xpatience.c  | 14 +++++------
 xdiff/xprepare.c   | 58 +++++++++++++++++++++++-----------------------
 xdiff/xtypes.h     | 15 ++++++------
 xdiff/xutils.c     | 32 ++++++++++++-------------
 xdiff/xutils.h     |  6 ++---
 10 files changed, 109 insertions(+), 109 deletions(-)


base-commit: 143f58ef7535f8f8a80d810768a18bdf3807de26
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-2070%2Fezekielnewren%2Fxdiff_cleanup_part2-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-2070/ezekielnewren/xdiff_cleanup_part2-v1
Pull-Request: https://github.com/git/git/pull/2070
-- 
gitgitgadget
