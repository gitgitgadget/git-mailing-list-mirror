Received: from mail-io1-f51.google.com (mail-io1-f51.google.com [209.85.166.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E072224B1B
	for <git@vger.kernel.org>; Fri, 19 Sep 2025 15:16:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758294997; cv=none; b=dwN1GjQpUSmSVxQjHferCLfchK9XM1kWLVI4hpX0UinNLVCfXKyKPyEiK9+gMUOPihHVJfwH40eCV7oKeZGBZISgD9H+D+g24LLCuUwXiV+OaV6BT7Y8BrNl3guiZv6N1cZcQwjuWm/Qj1dCQ3I/PfKOClbsGyHmU5YUf2fCBKQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758294997; c=relaxed/simple;
	bh=p1esVzPjkk5RWgnFrnKouqSajlW0ZUn8efOFxdmQDBA=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:MIME-Version:
	 Content-Type:To:Cc; b=Atexpsrg05/NYvZRrC2VsbfCcdbLS6zESjQ4xHGkw01w36jiWPTorrfI1f9OF7PTG3evrDK/c1BIABhRcteFQnnI2xrYNRfAwiFJMPyQEtv6Rz9B7gOsud4NkNNFcmhumoadHi72zOj4kZiaoKSJc13N+uXJStMjXNcnFBH0Czk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bDxPSVae; arc=none smtp.client-ip=209.85.166.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bDxPSVae"
Received: by mail-io1-f51.google.com with SMTP id ca18e2360f4ac-893630dba34so89594839f.1
        for <git@vger.kernel.org>; Fri, 19 Sep 2025 08:16:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758294994; x=1758899794; darn=vger.kernel.org;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=E6KAmGwiFvHzKaspv6yrJ8BlrBfEC5kIaHhCL+OLh5Q=;
        b=bDxPSVaebq6StobFhbgO6z9SybH/Q+RveZO+4cNWhmlia8BId1UHU8xgO+mXg6YR9C
         cTPsS9/8mY9aSZUMXmn9O8ZhMblNN1GId5RUh3zYVx1q2CpFttJ3wMSfi6TobyyhkbfS
         qW8Cc4CKvHkoiW4s1TtAMwzQcp9PbO301vI2QQoUbK3kt6yG8krRHYZWKNR80+cNb4MK
         Mmwrk5EEBYkUAKTB7GIbhE3TMUvRsLwVli4b+TXqqX2e1S2lGHylX39o5NLFXTnGV+No
         8tV28ZCN4Jc0X+mfYfNHAgXMfdQ+lrmx1iDilTcry+fvX6U2095SWqUHtbwWoHk8CUz0
         REfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758294994; x=1758899794;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=E6KAmGwiFvHzKaspv6yrJ8BlrBfEC5kIaHhCL+OLh5Q=;
        b=k3iVsI7dDAllBfvtvW/vXOgtJ7EkD2iGw08tkbZvDClgPcjN+Ys1GHvYlMJxD6cAQY
         T2PXzuiNCeCC74nY6AnjFir/7C5U4gTahagEhasGrwkhE1IWlJmfGen7UWeZCscV4CtQ
         8YGz3iCemDGe0BYZ5a97bzYlkG3NwRB8YxW8I+eLW8qc+ZmVm+IvSTqfdh5aJOwlFiKB
         cAijBf45g0hV88kz7jJA5fpg82UsMU2uRI2iho8qGFibUt+ViaQxcXFyFyv1g2LqHqdQ
         PRDDNqSB5IOHYcYsCB8Y/GZXXn7GEMJotr0I3gABUK8ZGi1ss9l+5feYnaDnfdGQFp3M
         NlsQ==
X-Gm-Message-State: AOJu0YyjbLbBRDldARPe0nzrEZcrQHapUwz401L9MqZigbLwCIEM+Kri
	+XYjOOG867aKhcaadFEMEO+5zuSZuZAkCvVE7rkT/yOuRVYkfJX/dHg9QI6jgg==
X-Gm-Gg: ASbGncvV2icM0QIniRJW2BRYsi4H+OX+1KdiLKSRclWqzhSM+eWZiFSUflVmVtcIexv
	N6WOG/MuToohoSYRIKLAYqfu0nwDvrKuJAmjl8BnyYmE7ruLYwTrVesDIMErg5XuvVhX7xRW8ld
	Nl9hvGCm6gRk+FTs7iUhb4CYifOh1mebfDXod59a4/MR0FoXbz7Rwx7b9KO9RkNWb1CVlmFROYo
	DWvzF3+a4jbc9nF65zPgJPF1xcr2LG2Kcf1EVvqqW5QFVGw8XWIqBSltE8zsE/HDvbnPcneDeO1
	82h9AXkKcoNaNKp3lIub/49LLrOIaE3LpVkseIwDGHxGfXKx+KoUBO8o89bBPWgQBK4PgzZ1RIX
	chqTHOlGBM009cb3PdW8aNnKqvA==
X-Google-Smtp-Source: AGHT+IGKvGGVBEtf9FJUYQCbzr/IdNvW5MHEXSmNDu+2R10OwlxJRm2iRGEbMGg1ks8oHd9DE6pZyg==
X-Received: by 2002:a05:6e02:168f:b0:414:117d:3186 with SMTP id e9e14a558f8ab-4248178d076mr53802545ab.13.1758294993949;
        Fri, 19 Sep 2025 08:16:33 -0700 (PDT)
Received: from [127.0.0.1] ([135.232.200.65])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-4248a975078sm1583345ab.17.2025.09.19.08.16.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Sep 2025 08:16:33 -0700 (PDT)
Message-Id: <pull.2048.v3.git.git.1758294992.gitgitgadget@gmail.com>
In-Reply-To: <pull.2048.v2.git.git.1758239789.gitgitgadget@gmail.com>
References: <pull.2048.v2.git.git.1758239789.gitgitgadget@gmail.com>
From: "Ezekiel Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 19 Sep 2025 15:16:22 +0000
Subject: [PATCH v3 00/10] Cleanup xdfile_t and xrecord_t in xdiff.
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc: Sent
To: git@vger.kernel.org
Cc: Elijah Newren <newren@gmail.com>,
    Phillip Wood <phillip.wood123@gmail.com>,
    Ben Knoble <ben.knoble@gmail.com>,
    Ezekiel Newren <ezekielnewren@gmail.com>

Changes since v2.

 * No patch changes, just resending to get patch 9 to show up on the mailing
   list.
 * A few tweaks to the cover letter.

Changes since v1, to address review feedback.

 * Only include the clean up patches; The remaining patches will be split
   into a separate series.
 * Commit message clarifications.
 * Minor style cleanups.
 * Performance impacts included in commit message of patch 8.


Relevant part of the original cover letter follows:
===================================================

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


===

Ezekiel Newren (10):
  xdiff: delete static forward declarations in xprepare
  xdiff: delete local variables and initialize/free xdfile_t directly
  xdiff: delete unnecessary fields from xrecord_t and xdfile_t
  xdiff: delete xdl_get_rec() in xemit
  xdiff: delete struct diffdata_t
  xdiff: delete redundant array xdfile_t.ha
  xdiff: delete fields ha, line, size in xdlclass_t in favor of an
    xrecord_t
  xdiff: delete chastore from xdfile_t
  xdiff: delete rchg aliasing
  xdiff: treat xdfile_t.rchg like an enum

 xdiff/xdiff.h      |   4 +
 xdiff/xdiffi.c     | 101 ++++++++---------
 xdiff/xdiffi.h     |  11 +-
 xdiff/xemit.c      |  38 +++----
 xdiff/xhistogram.c |  10 +-
 xdiff/xmerge.c     |  56 +++++-----
 xdiff/xpatience.c  |  18 ++--
 xdiff/xprepare.c   | 262 +++++++++++++++++----------------------------
 xdiff/xtypes.h     |   7 +-
 xdiff/xutils.c     |  12 +--
 10 files changed, 212 insertions(+), 307 deletions(-)


base-commit: c44beea485f0f2feaf460e2ac87fdd5608d63cf0
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-2048%2Fezekielnewren%2Fuse_rust_types_in_xdiff-v3
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-2048/ezekielnewren/use_rust_types_in_xdiff-v3
Pull-Request: https://github.com/git/git/pull/2048

Range-diff vs v2:

  1:  784cffcef5 =  1:  784cffcef5 xdiff: delete static forward declarations in xprepare
  2:  b79157e64f =  2:  b79157e64f xdiff: delete local variables and initialize/free xdfile_t directly
  3:  2e8de5be03 =  3:  2e8de5be03 xdiff: delete unnecessary fields from xrecord_t and xdfile_t
  4:  ddfee67e06 =  4:  ddfee67e06 xdiff: delete xdl_get_rec() in xemit
  5:  807ce3e5aa =  5:  807ce3e5aa xdiff: delete struct diffdata_t
  6:  0bacb1191d =  6:  0bacb1191d xdiff: delete redundant array xdfile_t.ha
  7:  e1e94107c9 =  7:  e1e94107c9 xdiff: delete fields ha, line, size in xdlclass_t in favor of an xrecord_t
  8:  fae26d2a04 =  8:  fae26d2a04 xdiff: delete chastore from xdfile_t
  9:  fd54135560 =  9:  fd54135560 xdiff: delete rchg aliasing
 10:  9a5ac3c488 = 10:  1e404c3290 xdiff: treat xdfile_t.rchg like an enum

-- 
gitgitgadget
