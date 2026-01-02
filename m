Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0989F1EB9FA
	for <git@vger.kernel.org>; Fri,  2 Jan 2026 18:52:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767379948; cv=none; b=lFazMOZCZ/1vqYE7k7EiWSAlFmvDi9lzr0WPE83ZIi2HTXLV1GWCNbvt9ehfoLxgpu77NLQQBOaiwFogKn76gcl9X9wbtLz7f+tom7oU4n4hW1E6ZRAVsD37jRWcXcPb3yfsjrgZhZITOtQxj5LQIij+xKzOgP/tJEh1M29AJ30=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767379948; c=relaxed/simple;
	bh=3mHHPSGusAlD3WK8aZVxuun8d03uHip8K8Hhurrn1iY=;
	h=Message-Id:From:Date:Subject:Content-Type:MIME-Version:To:Cc; b=QtWbCIBUrJvXAhTHuiYv1IbOXd5tXf2U/ABs7YbWaJoNn5XglpMJS8g+R+Yd0pGL32t7GGgGs8aIdwGWb0Of+f2z27AgN1jRcyUbv9fRknlTCCRGbRqL/n/4uCzBf3DI1/kCwPqk82YIGR0O1rKPOmoSyPSMLiE1GlhImyXJbEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fXwtEafm; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fXwtEafm"
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-c2dc870e194so4727291a12.2
        for <git@vger.kernel.org>; Fri, 02 Jan 2026 10:52:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767379946; x=1767984746; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=u5tKSCq9b5LYGeNmCqic4RRV5DXw9Go7DUnLgd5dldc=;
        b=fXwtEafmcAAoTssza/V+Lu6f1VlhmB9CB6X//9XRiY0Ja3hbbS0+2cZ9sCUW/DOMT3
         NuyM6lmiEmxE6iNFf51J6B2lR6Q03ibTAI2AJqobvf+g1V8v0JFtnlyA0lqzHycKiPbl
         nZHLpnBCW5ApZ1Rc14VXQpOSPn2CEmiohW9krQueLyzEOb4ytv3RcMFybJ6WWNIsEr+N
         mKNPXb0QOXay89vIMJecThXi2LzRPoRDZAQ40yqmah/nTG/TsmideLapbolYH5STwRMv
         0qSfrRqRHlJU9BVyhBSeteFgoeUsAWC2DMPl96dFqR7KK1RBKZ3wGaSWX+Z+WrqDBI3t
         vVdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767379946; x=1767984746;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=u5tKSCq9b5LYGeNmCqic4RRV5DXw9Go7DUnLgd5dldc=;
        b=qa9pbGBGcNGOG5mmwgn/+Jvh3wcwbLjCcy7BOhXejZR/kDp+m7YmHNZaVdcRRpR/py
         9K9NrmHCl0W7CLk0ZIopr1Uv/Fy8MrLRgtX6JcdFIRKjWuX2Kc1uhOo4MlC7BbmUzGIn
         Dx0b2vxJ2oeGMx4aiz2RMRnBq2mc/L4bFh7e4LKWpGVNIJLg2Occn6xc8pqK+qdo4Bh+
         VIiNg1N8dg9b+OUt2t/2kbJEKmlQ8Yz2S7hKgJ3Xnu8KM6ON1U6VguR/4nk9LjbdY2WM
         G6ctCM7j8pssOI9ZRq89CmjVTHsLJk+90rIqjy9+jWUf4Kt61I1qHhMkO64DtUizJQbG
         V7HQ==
X-Gm-Message-State: AOJu0Yxv7arNvlLmEFVFKLrpAbaJrpOOFQVkbA0a4xNZV6lKG+G1FvJo
	RhhJay2jHz5orqZM0cJfkDkX0vhx8pEiGsddht5wrG5GQz6aaFfVuoffQRYSHA==
X-Gm-Gg: AY/fxX5c6Ygz1hpydAx4DyrmQffFxSfI67oGc//6rjPGWat5iXFVmQR3NM8hQ5NqwNl
	Hn8gcTVLRAdvfAlnGyN4tc4GnN3rVlwkHmoym0GYECH6Juwc5Ufbpko8HMDcIaBjcxOidGXAAUu
	d5SQmzkJC5gK5VD6Sq2dqppcNhc4qe+4CYEXO+fasOGegWVEauyoKuggdX7Hr6OWGL4t/P8YWNk
	KJf53T+aqBNNi9NPNV6uK+r3kgoaYBYgRx0cS6llN9qorKILL5H/40cpi9LnlkBeKZTsI4t44C1
	mCTD34oEFzRxb2Y4B0Uy/CGWXYwARAGaU+Yn1bhXC5UCwGYMrWAWNAtltBPNNemZkwScqmlnYyS
	uAzJDDjv4uS2qDIoc0CsHPP30G/6OYpu76iUOwYtsIAF0WMqkzgeqU23CieKZqPoe3nDhC5iujt
	oxkN1gPNmPApPjbw+yUXvKCCm+
X-Google-Smtp-Source: AGHT+IEqiywduzDeUB1fR+g5c+Cr8ZxO5OvUjdIrKCGJg7mE9yH1fXDLpKMFnQ2i9qOrSiUifcNW/g==
X-Received: by 2002:a05:7301:9a83:b0:2ab:8ef5:df2 with SMTP id 5a478bee46e88-2b05ec97f3emr23310333eec.35.1767379945685;
        Fri, 02 Jan 2026 10:52:25 -0800 (PST)
Received: from [127.0.0.1] ([57.151.128.130])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2b140c42de6sm1540509eec.19.2026.01.02.10.52.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Jan 2026 10:52:25 -0800 (PST)
Message-Id: <pull.2156.git.git.1767379944.gitgitgadget@gmail.com>
From: "Ezekiel Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 02 Jan 2026 18:52:14 +0000
Subject: [PATCH 00/10] Xdiff cleanup part 3
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

Patch series summary:

 * patch 1: Introduce the ivec type
 * patch 2: Create the function xdl_do_classic_diff()
 * patches 3-4: generic cleanup
 * patches 5-8: convert from dstart/dend (in xdfile_t) to
   delta_start/delta_end (in xdfenv_t)
 * patches 9-10: move xdl_cleanup_records(), and related, from xprepare.c to
   xdiffi.c

Things that will be addressed in future patch series:

 * Make xdl_cleanup_records() easier to read
 * convert recs/nrec into an ivec
 * convert changed to an ivec
 * remove reference_index/nreff from xdfile_t and turn it into an ivec
 * splitting minimal_perfect_hash out as its own ivec
 * improve the performance of the classifier and parsing/hashing lines

=== before this patch series typedef struct s_xdfile { xrecord_t *recs;
size_t nrec; ptrdiff_t dstart, dend; bool *changed; size_t *reference_index;
size_t nreff; } xdfile_t;

typedef struct s_xdfenv { xdfile_t xdf1, xdf2; } xdfenv_t;

=== after this patch series typedef struct s_xdfile { xrecord_t *recs;
size_t nrec; bool *changed; size_t *reference_index; size_t nreff; }
xdfile_t;

typedef struct s_xdfenv { xdfile_t xdf1, xdf2; size_t delta_start,
delta_end; size_t mph_size; } xdfenv_t;

Ezekiel Newren (10):
  ivec: introduce the C side of ivec
  xdiff: make classic diff explicit by creating xdl_do_classic_diff()
  xdiff: don't waste time guessing the number of lines
  xdiff: let patience and histogram benefit from xdl_trim_ends()
  xdiff: use xdfenv_t in xdl_trim_ends() and xdl_cleanup_records()
  xdiff: cleanup xdl_trim_ends()
  xdiff: replace xdfile_t.dstart with xdfenv_t.delta_start
  xdiff: replace xdfile_t.dend with xdfenv_t.delta_end
  xdiff: remove dependence on xdlclassifier from xdl_cleanup_records()
  xdiff: move xdl_cleanup_records() from xprepare.c to xdiffi.c

 Makefile           |   1 +
 compat/ivec.c      | 113 ++++++++++++++++++
 compat/ivec.h      |  52 +++++++++
 meson.build        |   1 +
 xdiff/xdiffi.c     | 221 +++++++++++++++++++++++++++++++++---
 xdiff/xdiffi.h     |   1 +
 xdiff/xhistogram.c |   7 +-
 xdiff/xpatience.c  |   7 +-
 xdiff/xprepare.c   | 277 ++++++++-------------------------------------
 xdiff/xtypes.h     |   3 +-
 xdiff/xutils.c     |  20 ----
 xdiff/xutils.h     |   1 -
 12 files changed, 432 insertions(+), 272 deletions(-)
 create mode 100644 compat/ivec.c
 create mode 100644 compat/ivec.h


base-commit: 66ce5f8e8872f0183bb137911c52b07f1f242d13
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-2156%2Fezekielnewren%2Fxdiff-cleanup-3-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-2156/ezekielnewren/xdiff-cleanup-3-v1
Pull-Request: https://github.com/git/git/pull/2156
-- 
gitgitgadget
