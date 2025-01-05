Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59484849C
	for <git@vger.kernel.org>; Sun,  5 Jan 2025 13:47:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736084826; cv=none; b=dTRU1XQuGhhQl8eRsAPIxTYO46jTwZVthSEOCCWXq2C/6xVZ4mIYe+mUTYH3fBs/vADlcxlFYOV78eohMmy0v1J1CrsqedJNY1HSWCIyJjHdeFieNvsjSyuhmSAdA5IZFkmNwltsvRyELw3TPagHcyx+v3ShjWYOubWrpuXG4iw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736084826; c=relaxed/simple;
	bh=8dYz6wVzJaiaKXMaNmIVDZ+hqHY53Ryf1Ql1oj/EDrY=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=TUFX6gq2J2MWleRo7PjAciLeGa9IVATDOQIwaShtbdfNC8XcrTg5i12RLkdMho6ItxFJM/p3AqbeeKwKRjIjMRWVthF9DpUn9mpu/cduWEY8HhqrpwV1a+o6R+TMQBT69LRRM6yvZWKFamnh68qtxbnbvO8afGAnm0uLOXYByYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hr9knu/l; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hr9knu/l"
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-2ee989553c1so19244698a91.3
        for <git@vger.kernel.org>; Sun, 05 Jan 2025 05:47:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736084824; x=1736689624; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zHJT304b51+yBeiv1K698cUlgDgtTZVIIls/jJxHZDM=;
        b=hr9knu/l60PIJIGgrxIdcIAXjsuzizenfdSs7CsuzG6jyr+k4tiCwARvC4Po3IWO/I
         Dn6DptakawBcx/jxXv1eMhwjaPogGsCviRRtEbI8OH3SZjm3eX/NE7y+T7ZB6b9Nux7Z
         fWp0JeqCgobASxLR4FRxRFRr0RdfykFgPRSAlhLazY3WaN3ZwXjcap1VrD5ReA/0gnL7
         Jiv17P6e+8vMH2F68B5GwQIHOkw4Zf4aLPUVs2NLqR3X5wzeBU/i947xnS1eH8AR7EOI
         0AADqPA90NVWaFZNnvfPLaHrqu59sfioec5oO08UGDtbUdEIGrYmG+08Ryl996XKL1wx
         qHvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736084824; x=1736689624;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zHJT304b51+yBeiv1K698cUlgDgtTZVIIls/jJxHZDM=;
        b=rkFxGHYHoyrYyhCSHMcoxX5KtSM3n2z1E42TNuzq7RFHQV7hHyn7EVQesihSMAKO37
         N4vrvlS2Q/AmphehRV4vL8/3xa2zPmByCb35k5CckrGb7KhkUgvnAVY5mNlauFXIjRJa
         JNznX7u/ChKX2keWAmZW02GFgdwSiWT8j397ZeAVeeV+zXb3mVIgbK3JAGvGoLJMWkSz
         BbzvSK8vcAtSFL/e4q6wwiA7CuZQlAjQrM+k9KifIFa5Z2PoikPoUKD5rtK1LH9ACfab
         8z/201X8086Swbc/WRCFRK6Yy9g1ZY1RX6bmzisGwWnb+M/zmRPD/1gQDL3xxkSpeag9
         yUCA==
X-Gm-Message-State: AOJu0YzsMv2IhVb/XbPUJkT6ofaGwuRkSjZn9lWoWrsPMgu8lJqD+vSv
	yMD42KdNbB4LY40hchQ40PlNSnyVhCNdjAOwnpVIN9piRiLmaObn5KqADQ==
X-Gm-Gg: ASbGnct8VoYCk73T2FtqMAxWNlIxnOqI445KbRYli/IaZXEyNbxqO/c46txyl9VVcbY
	fsOd+q4Dw4meiI1cAOUMIeazK8m7tnTAatlfk5dh8xjONV7FreypofzGg/K/JrIEKCzkRaEwD9S
	ca1xBd+/QwLDJJPPaQzVo+taAAxUyveH51FA1CUGoijHX95Giv8GpAQi2VQhnv1CGYtKYHnlbCz
	pA0s/TgL/ep2/1WpDmLiPSDpfQ66G7zB+w=
X-Google-Smtp-Source: AGHT+IFuazS2XMAIQyMb+kDSc6/gaIAxZ4JUVecx5cfqAmfpeuEv984K37hlbHPkOS824RhPsc1/gQ==
X-Received: by 2002:a17:90a:c2c6:b0:2ea:3d2e:a0d7 with SMTP id 98e67ed59e1d1-2f452e227ddmr89714295a91.15.1736084823734;
        Sun, 05 Jan 2025 05:47:03 -0800 (PST)
Received: from localhost ([2604:5040:11:69e::e973])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-219dc9f738asm270517155ad.205.2025.01.05.05.47.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Jan 2025 05:47:03 -0800 (PST)
Date: Sun, 5 Jan 2025 21:46:58 +0800
From: shejialuo <shejialuo@gmail.com>
To: git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>, Karthik Nayak <karthik.188@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH 00/10] add more ref consistency checks
Message-ID: <Z3qNUizvHJLgMx1y@ArchLinux>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi all:

This patch mainly does the following three things:

1. Add some extra checks which I have ignored in the previous patches
   for files-backend in
2. Add ref checks for packed-backend.
   1. Check whether the type of "packed-refs" is correct.
   2. Check whether the syntax of "packed-refs" is correct by using the
      rules from "packed-backend.c::create_snapshot" and
      "packed-backend.c::next_record".
   3. Check whether the pointed object exists and whether the
      "packed-refs" file is sorted.
3. Call "git refs verify" for "git-fsck(1)".

Although I am not mentored by Patrick and Karthik in this patch. I'd
like to add "Mentored-by" filed for them due to the reason that I
continue my GSoC work.

Thanks,
Jialuo

shejialuo (10):
  files-backend: add object check for regular ref
  builtin/refs.h: get worktrees without reading head info
  packed-backend: check whether the "packed-refs" is regular
  packed-backend: add "packed-refs" header consistency check
  packed-backend: check whether the refname contains NULL binaries
  packed-backend: add "packed-refs" entry consistency check
  packed-backend: create "fsck_packed_ref_entry" to store parsing info
  packed-backend: add check for object consistency
  packed-backend: check whether the "packed-refs" is sorted
  builtin/fsck: add `git refs verify` child process

 Documentation/fsck-msgids.txt |  22 ++
 builtin/fsck.c                |  28 +++
 builtin/refs.c                |   2 +-
 fsck.h                        |   8 +
 refs/files-backend.c          |  54 ++++-
 refs/packed-backend.c         | 413 +++++++++++++++++++++++++++++++++-
 t/t0602-reffiles-fsck.sh      | 209 +++++++++++++++++
 worktree.c                    |   5 +
 worktree.h                    |   6 +
 9 files changed, 723 insertions(+), 24 deletions(-)

-- 
2.47.1

