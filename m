Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1717A33E7
	for <git@vger.kernel.org>; Sat,  6 Sep 2025 07:52:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757145124; cv=none; b=t+VH4IHSLugxpqFlrkYcFbayVMR5Xzu4KWo4ZikqkSCr+9sb6Zk1wf9tRAAs6ikFIR07Mq/ldt4i0ydp3HRAAm1w5WRq8KByHi0z68C21E1APDrFFcdcPG2zQ5ND1anfP6MxjEMhzEppRWptKO8ur52rQ5QZ6wlAGj35GSz1Rps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757145124; c=relaxed/simple;
	bh=mapNKpp3oP0jhvICBrsqCy9E/lcw9xY7hzCrtIiGDdM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=kLTcfQDXG93FPEeBVL5L2/bn9wrBocsukkFEt5O1E9GpsJi0SFBRDNJIuz9aXbZ1DRRokmYH6UEHUQUsrKX65PifhDtSDfpHveIMo7Ao11wgJ0zeRls6wREHvHLdCc3vLB8FIi6HHChV6XvJ2rwntsILdSc2Las2O9qLncXa3wg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EVyycIW9; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EVyycIW9"
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-329b76008c6so2254551a91.1
        for <git@vger.kernel.org>; Sat, 06 Sep 2025 00:52:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757145121; x=1757749921; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=xG2pxoM/qfMf3SqL35kHvkYiRdU0BMS7ed5ilq84Ol0=;
        b=EVyycIW9DwTvZpTDko1z/T3rsB7FkeMnvZpZOoCK1NAd30atbUIImRmmGsnmwgIC5/
         DTLZdBaqeLygvgsRlucDDvVA7R9gk/rysZL305PIYHSnTBEUZgkYHCz+v/LO05kXmES1
         JGUnFP7I8+l7ncaOSRvaHS9j7u9T+7PrD76+GTaKJgT2LdPnmRZiQEW3J8UGK1S3PJJe
         WYGb/Q98eX6rUQXqc8MkYOO2SWaoD5oIgAuzR+bu0NDLZE+QRjklLZF0BpqkMS3C4qeW
         UJUVakG3qzhguQOk+XR2pBEkRC/COivbfFuG+oh22jW0Ci4cQ3mkAKEUglekVjuVzoRC
         4MoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757145121; x=1757749921;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xG2pxoM/qfMf3SqL35kHvkYiRdU0BMS7ed5ilq84Ol0=;
        b=Ge7j0xDFZRH06u1zWCn5zpFz/JihEPIXDxmcTPLiDFUH31qDFvOS1vw0YgIiaODr2P
         0b3+dqdHfen4heKJbh+bx/F0346cVlURK60PQIBUzhqoWVqfz3Gy9kZM/a+UKR+ENaU+
         MbMp7zm5XmTU531RD2w6f73vJUjvPPIFmmWAsA2RlkGr1eIjo2Y0hs35KnicUIrLJUev
         U4XaaGYyPVYqDsTxTQyEpWI6lhCn/zKDqwkMO3dWpeMSSS08tlh9D52J/ctYQME3FOt5
         /JGXmhR3oQr2bgK6K9EFzp6jvrSUjBv+NMj7mh2tqjyxqpmuBmyBtAPiHklS8PhDvoel
         cSWw==
X-Gm-Message-State: AOJu0Yw2ri7jrm5cvgB9DkvUGINQRwwwBugM1QPVWvIuJYJu3NxaQyhw
	/BZ+uKi9tPIhdFd4Bb5QmKpx9GNl38+xMDvZCyf1kunevsAAjs6Zsvz+uvQ1BA==
X-Gm-Gg: ASbGnctjDWyZSVX8dBQ9SUeqGNXvBre4kuFioytsvmW74BTrsQhXJDC9Cw+rkxpT/s2
	KWSFOFLMV3KIvJym1cIIhQsYULSniTlAy1bjQllyspHrS6OVXkowJ/IY4Eprxab1ZDmS+8NxcaT
	IRJmENmSuIvjtzaoV4p7aSxdDlsIf9qujuCNgyG+aS3OnDzCvw/U5J4y4+fyS7GRAy5YUKpCr62
	4s5VyhC/ll7s2pSBNtYdLN9A+10DyDJy2cw7eCBVSw2gsrynIjWO2IwlHQlKb2xODz1XRV8DURn
	RGmIe42JnkQxXMIvAuyu+j6keLImlZw7B2mfiOo8EWxR2lFCgxRopbXPuhulWCO0nRPcIRh5HOA
	ZsHN2jdxiOuwNEugwUQMpDrXiNahpkw==
X-Google-Smtp-Source: AGHT+IG8OGUri2hdR2nEDnUNBKMEK8ZrLaehwg9bg0bGBAL1pgmaozsNq+U73SYF937xK9fUHOkORg==
X-Received: by 2002:a17:90b:1fcc:b0:32b:94a2:b0c9 with SMTP id 98e67ed59e1d1-32d43f045f7mr2214517a91.3.1757145120945;
        Sat, 06 Sep 2025 00:52:00 -0700 (PDT)
Received: from meet.. ([103.176.11.198])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-32bd182256bsm3540929a91.23.2025.09.06.00.51.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Sep 2025 00:52:00 -0700 (PDT)
From: Meet Soni <meetsoni3017@gmail.com>
To: git@vger.kernel.org
Cc: ps@pks.im,
	shejialuo@gmail.com,
	gitster@pobox.com,
	Meet Soni <meetsoni3017@gmail.com>
Subject: [GSoC][PATCH v2 0/5] Add refs optimize subcommand
Date: Sat,  6 Sep 2025 13:21:42 +0530
Message-Id: <20250906075147.1076656-1-meetsoni3017@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series introduces `git refs optimize` as a modern replacement for
`git pack-refs`, continuing the effort to consolidate commands
under the `git refs` namespace.

changes in v2:
- Updated documentation.
- moved `pack_refs_core()` from `builtin/pack-refs.c` to `pack-refs.c`.

Meet Soni (5):
  builtin/pack-refs: factor out core logic into a shared library
  doc: factor out common option
  builtin/refs: add optimize subcommand
  t0601: refactor tests to be shareable
  t: add test for git refs optimize subcommand

 Documentation/git-pack-refs.adoc     |  54 +---
 Documentation/git-refs.adoc          |  10 +
 Documentation/pack-refs-options.adoc |  52 ++++
 Makefile                             |   1 +
 builtin/pack-refs.c                  |  55 +---
 builtin/refs.c                       |  16 +
 meson.build                          |   1 +
 pack-refs.c                          |  56 ++++
 pack-refs.h                          |  23 ++
 t/meson.build                        |   3 +-
 t/pack-refs-tests.sh                 | 431 +++++++++++++++++++++++++++
 t/t0601-reffiles-pack-refs.sh        | 430 +-------------------------
 t/t1463-refs-optimize.sh             |  17 ++
 13 files changed, 616 insertions(+), 533 deletions(-)
 create mode 100644 Documentation/pack-refs-options.adoc
 create mode 100644 pack-refs.c
 create mode 100644 pack-refs.h
 create mode 100644 t/pack-refs-tests.sh
 create mode 100755 t/t1463-refs-optimize.sh

Range-diff against v1:
1:  0268933403 < -:  ---------- builtin/pack-refs: factor out core logic into a helper
-:  ---------- > 1:  67a9187b59 builtin/pack-refs: factor out core logic into a shared library
2:  ec14212c7b = 2:  422eaa0c8b doc: factor out common option
3:  d3a4d7cb67 ! 3:  067a2baa97 builtin/refs: add optimize subcommand
    @@ Documentation/git-refs.adoc: list::
      	linkgit:git-for-each-ref[1] and offers identical functionality.
      
     +optimize::
    -+        Pack references into a single file to improve repository performance
    -+        and reduce storage usage. This subcommand is an alias for
    -+        linkgit:git-pack-refs[1] and offers identical functionality.
    ++	Optimizes references to improve repository performance and reduce disk
    ++	usage. This subcommand is an alias for linkgit:git-pack-refs[1] and
    ++	offers identical functionality.
     +
      OPTIONS
      -------
4:  16fa3f5445 = 4:  640ebd9a4f t0601: refactor tests to be shareable
5:  22620613d9 = 5:  37ca586bb9 t: add test for git refs optimize subcommand

base-commit: 1fa68948c3d76328236cac73d2adf33c905bd8e3
-- 
2.34.1

