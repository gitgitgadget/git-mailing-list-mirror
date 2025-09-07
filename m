Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 716BE2AE97
	for <git@vger.kernel.org>; Sun,  7 Sep 2025 19:45:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757274325; cv=none; b=Y2qh+QpkMB8a+qJrk3MmgcAKbQ+wCEYyXVgDwXhpaZqCoLg0+UdxC2eKYj8ouSSgy3Vg0i+uUL3DMXkmkD1Kf4tbTFL7lKeY1nUaPrGrAKTTSMDVsM4CJJPZj2RySA9HZNZyT8Dn/OtZpD6FA7obNvgyzDkmPMUGilNuBRKzvvU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757274325; c=relaxed/simple;
	bh=P1Fx8HctSolhQ8fsownyYkEb8ioRWaoEEa24685u444=;
	h=Message-Id:From:Date:Subject:Content-Type:MIME-Version:To:Cc; b=WPdZkKCIY6IrMr1qdHK4b8W7x7O0Q6kQu6cv9BHuy5lFE7OLkSOejsjTqtKvlGwZJkcP0CVA7lTnvE8Hprp1hP83uELsppqpA2KdjOjaZz0CNQIeHfNbhLbjTya4NqqnJdWL3XA690vHSIvtGIQspDxyz1YeyW3fSEvqiYr3A9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c1v01lLy; arc=none smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c1v01lLy"
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-4b109c58e29so42745981cf.3
        for <git@vger.kernel.org>; Sun, 07 Sep 2025 12:45:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757274322; x=1757879122; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=p6l8gWVVmVEamWXyi1h9r8C7Sr8cFsHZ7JZmgexdcSs=;
        b=c1v01lLyJ6U/HhDjQaDmTh3wTHgdFJPxxEzpZDWNHfePKetHEG/5pMGBsdeQjv1/qb
         FD2IDDDSywMksgU2KORtwHoajdKWW5y/hB12upMoVsZItz1mtHYWL9HtKqtW2Tr0dRmt
         kP0662KPB5YSt9YfKSqmNki5pHY9wm+zoc8hE9LZ1BjQpTVemRAF3NvS4faUxiEwJpB3
         51ROwLsQ1KEGY0+AZknV5jn+d7NDzPbqLg74EkuuyEM4SOy3IVT/BKmNJaDGgFgNruzY
         k/NqkvvcGSd5iKT6/ww8fxW4eHmz7olRD/Kdk61xxJfLarYBKBWYmWURKYI0pm2ix5mI
         kKQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757274322; x=1757879122;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=p6l8gWVVmVEamWXyi1h9r8C7Sr8cFsHZ7JZmgexdcSs=;
        b=wSyF8i8z8/reK/SM286Hc/9+YuOZ1Id2StcJ9MFPk6UBp19U8i0C9l+viZ1StjuvkY
         uPuyuN2JmWvLYWCHS39bTcBtXlEbXWvBKvJ5Ke++HMlR3EbdyLHxBaYk21vRODUFpG3p
         MtgLTOE1gcEfx48NUorAAXT8CWYIZmXaqTwCp0AhI9jS3bOhePR9xyMSxdqIOxRKB8O2
         v4MfV2EEhkxq+JQFUSeGfECWrTchUwlpQ89PMGHW/dKEcuQRypC/SxiXwDGh/NAefwRj
         yA8lFHnxGLfz+npH2oz84KQGmTUW/kJMrhsR9HVUTkf12uoVezJt4yhzCBq6idAx7Ill
         LjjQ==
X-Gm-Message-State: AOJu0YyPXQw5Pw8PoSHfWc+ip6jP5jSaacYqFj2E4YzKC2q8/InWlOdr
	lHrwwgb+YljOdYVXhYoMN9iP7Qwz8uzDm58fBsP4Fz13hBud5Z/PvMQmgujlWpYG
X-Gm-Gg: ASbGncsDZms8s6FT0FMtVVoXcduJBmtVBj3LI5TaRZOJsKth2g3yDNDdt/4Mf1s+NUp
	X1vFw6cDrcLvQh23FDipnyZUBqneZkH6laBVZm2UumzBbm12KbrXsFM+KLf+4DlxK9a2d4hFVzd
	aFvmKNItLucSFMziXBy0bpD4SfRzkP3W5Bxx2ZQQ/WYppAdjZBfi+FELtPvyV8QhO9iqEFVgH8h
	nwqxN7rabl2EC5dBy9mZvuCYEoJoxMGfmUuJ6W56DVbRcM/3oUqyGGGkqD9xN4RyDUsDZsmOIYm
	T93FvnvhFVBJWw0q6sSi23vajQUlPXCSEswgKfr6fFdWAL3jK4ws+2o9VP2yd2v+EnuDqIktTjL
	xvOBU66mXv/5hyT1vimvjyv0=
X-Google-Smtp-Source: AGHT+IGrYYt+9+wbdHxrQjBkBz1YYG26PSrWNikR5tJHQNOhi1B87jJ5gNsaKRIa4EHz0Xz+aOK9Pg==
X-Received: by 2002:ac8:7f56:0:b0:4b2:fcf4:44c9 with SMTP id d75a77b69052e-4b5f846701amr62566691cf.60.1757274321691;
        Sun, 07 Sep 2025 12:45:21 -0700 (PDT)
Received: from [127.0.0.1] ([20.161.28.97])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-80aab3b671dsm902358085a.46.2025.09.07.12.45.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Sep 2025 12:45:21 -0700 (PDT)
Message-Id: <pull.2048.git.git.1757274320.gitgitgadget@gmail.com>
From: "Ezekiel Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sun, 07 Sep 2025 19:45:03 +0000
Subject: [PATCH 00/17] Use rust types in xdiff.
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

This patch series involves ZERO Rust code and toolchains, which avoids the
debate about Rust's portability and timeline. Instead, it shows how Git can
immediately benefit from Rust's design choices without using it at all. The
rationale for using Rust types on the C and Rust side is addressed in the
commit that creates compat/rust_types.h.

This patch series has 2 parts:

 * Patches 1-9: Clean up xdiff, this can be merged without part 2.
 * Patches 10-17: Define Rust types in compat/rust_types.h and then start
   refactoring xdiff with Rust types. This depends on part 1.

The cleanup in this patch series makes the structs xrecord_t and xdfile_t
Rust FFI friendly. My opinion is that part 1 should be merged soon, while
part 2 can be discussed further.

Before:

typedef struct s_xrecord {
	struct s_xrecord *next;
	char const *ptr;
	long size;
	unsigned long ha;
} xrecord_t;

typedef struct s_xdfile {
	chastore_t rcha;
	long nrec;
	unsigned int hbits;
	xrecord_t **rhash;
	long dstart, dend;
	xrecord_t **recs;
	char *rchg;
	long *rindex;
	long nreff;
	unsigned long *ha;
} xdfile_t;


After cleanup:

typedef struct s_xrecord {
	char const *ptr;
	long size;
	unsigned long ha;
} xrecord_t;

typedef struct s_xdfile {
	xrecord_t *recs;
	long nrec;
	long dstart, dend;
	char *rchg;
	long *rindex;
	long nreff;
} xdfile_t;


After using Rust types:

typedef struct s_xrecord {
	u8 const *ptr;
	usize size;
	u64 line_hash;
	usize minimal_perfect_hash;
} xrecord_t;

typedef struct s_xdfile {
	xrecord_t *recs;
	usize nrec;
	i32 dstart, dend;
	u8 *rchg;
	usize *rindex;
	usize nreff;
} xdfile_t;


Ezekiel Newren (17):
  xdiff: delete static forward declarations in xprepare
  xdiff: delete local variables and initialize/free xdfile_t directly
  xdiff: delete unnecessary fields from xrecord_t and xdfile_t
  xdiff: delete xdl_get_rec() in xemit
  xdiff: delete struct diffdata_t
  xdiff: delete redundant array xdfile_t.ha
  xdiff: delete fields ha, line, size in xdlclass_t in favor of an
    xrecord_t
  xdiff: delete chastore from xdfile_t, view with --color-words
  xdiff: treat xdfile_t.rchg like an enum
  compat/rust_types.h: define rust primitive types
  xdiff: include compat/rust_types.h
  xdiff: make xrecord_t.ptr a u8 instead of char
  xdiff: make xrecord_t.size a usize instead of long
  xdiff: split xrecord_t.ha into line_hash and minimal_perfect_hash
  xdiff: make xdfile_t.nrec a usize instead of long
  xdiff: make xdfile_t.nreff a usize instead of long
  xdiff: change the types of dstart, dend, rchg, and rindex in xdfile_t

 compat/rust_types.h |  28 +++++
 xdiff/xdiff.h       |   4 +
 xdiff/xdiffi.c      | 118 ++++++++----------
 xdiff/xdiffi.h      |  11 +-
 xdiff/xemit.c       |  52 +++-----
 xdiff/xhistogram.c  |  14 +--
 xdiff/xinclude.h    |   1 +
 xdiff/xmacros.h     |   2 +-
 xdiff/xmerge.c      |  66 +++++-----
 xdiff/xpatience.c   |  28 ++---
 xdiff/xprepare.c    | 289 +++++++++++++++++---------------------------
 xdiff/xtypes.h      |  26 ++--
 xdiff/xutils.c      |  12 +-
 13 files changed, 293 insertions(+), 358 deletions(-)
 create mode 100644 compat/rust_types.h


base-commit: 16bd9f20a403117f2e0d9bcda6c6e621d3763e77
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-2048%2Fezekielnewren%2Fuse_rust_types_in_xdiff-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-2048/ezekielnewren/use_rust_types_in_xdiff-v1
Pull-Request: https://github.com/git/git/pull/2048
-- 
gitgitgadget
