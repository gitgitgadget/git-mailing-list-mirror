Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A66A82F0683
	for <git@vger.kernel.org>; Thu, 18 Sep 2025 08:11:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758183112; cv=none; b=AmDl0sHNUAEU8JctaYIdErLt/B+UT2DrIjxlGwSYpjol9cduXzgGX1nYT52P8JS8qpaTxCTXyqunBvRbNPtYEBzxomOHT3mJPOykdYtfappR/9obt5a7AbWpEluo/PRRQMR1W46F6U2QmnpwcynNomD924W4KKTj1kKa64AGaXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758183112; c=relaxed/simple;
	bh=1GBlgl6IdrFqqD8ZJkZZ/To7zYM+WP15ShyhvgsB91c=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 In-Reply-To:References:To:Cc; b=Jv7vDMTMhoeNE+Gn8Fjid2N9vdE0S/STkb4hHxL/2JOB9WVAC/BwxBZgi+BWtYY74stuzozPVb5IRSLQcbIgEpKMVR+FknhhKAa0zMDF++gJEDVTs0xr45fS56wznPz93gYlQ3kEPChTyuPcbl18PWhIXXIAWD7Q4n9dLLYZhn0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AXLDTdtD; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AXLDTdtD"
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-b2350899a40so3302766b.3
        for <git@vger.kernel.org>; Thu, 18 Sep 2025 01:11:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758183109; x=1758787909; darn=vger.kernel.org;
        h=cc:to:references:in-reply-to:content-transfer-encoding:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6atqjbIOsiSIyPOjTgmcOKiSSa0z2dXMgn5+u3GrY3Y=;
        b=AXLDTdtDTGfiv2WQXcB6YQwumABugduHhEBZ2m/aV3y3Oukr+F72q/PYDOFPTej2uN
         qM86PyOkPDsNZsmXH0utmJPg7CQpkt6L070eXbY5UlxI9cjnK5Hs1fkVxId7LnlpjgGK
         tVX+H+kfqWKcP1FRv2qlfAk30sybbj+prRL+gb2x5unkR2bmBKQcG1YmLU+v6yqGpN5V
         XF014XsoUq/HXy8GwZG4ZTFeAWt9IJtNMMpoDO5dxdlL0sYGimDoae1Zc80Y761mWvFW
         cej86P4HsQCalXj8Hv/exl1hyD3xlDZft0PJGGZjsP81hFw+I+8P+cRsBICeW3DKGJiY
         50cQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758183109; x=1758787909;
        h=cc:to:references:in-reply-to:content-transfer-encoding:mime-version
         :message-id:date:subject:from:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=6atqjbIOsiSIyPOjTgmcOKiSSa0z2dXMgn5+u3GrY3Y=;
        b=lMutiT2gRf1mjDwEe9BRxtSLxaflelN5k4I8qzHczMO6gPPwvHT8a63txcJVETTYJl
         FtY537GiKkUdveG2hzvIN8PHqIGUOZmcuCy0m8jGSyF/PqUb9gQOtRXSInXL1rcFWDy7
         g79yeGHcOF9pBy0WsfpWoxMEx1hAC96dJv2vo1/aQ/PUQ8jmQfnfWCxnuLylSyVK4QTG
         EHe7LvMtpWK2JuBTYoqCAe9hDwSK4n6wihJ9unIbjJxyKamZwxIWY79t2OoGrOJTQ1fB
         vsyOZiBKi2zBRzW85PGb8KtLTSiu2OspA/hsIumwmwzfVTQXjgqA8H5A+onErKqIijwV
         nTHg==
X-Gm-Message-State: AOJu0YxvyfhusuVnf3IH6WCw+f09WHGS+7bGGfPDYItymd9vzJ/YC1Py
	dwOT7TM5M7m/L5PPFqHCnBCneb8I2kq0sjPCDNeclMOQlXiSQGJA4uyE
X-Gm-Gg: ASbGncvSW25BrtBm+49iGv7zBSZODvC7jdcQxyKRCWOEDuOQJFDIQfCv3vQFiwKkFCy
	Q8EWAvQbNTV9WDTRWv/zBZcNF/rznUkoqSr21fLaA99QAd+/MiDU9a8B0ZPtgERIuDkTTBznx/p
	0E2cnE/xAj1K2sRdDW6eSXHwBRO9IjYMpRrSXgEwPierDefJ2znpQKVAP8cFD8JzC7jUlFjEbNh
	AiC2+OxyoGzOxCBuMfxYvdny5wRGpgh6WMicLHg0HjhmJDXYoyxIrNATrx+h9yZe9GgCrY4XILf
	qxW8QhcV6z+SBMWKGTie54j/Phs7Fnu7Y05e3dVBC4TrbbFD+m9b1rxqJ2vfeJZBxPCRdIcZl+x
	1k0P+quCmxD/Kre51SNIfcKKH2+aZzpztr9BtdGGFF6ewvZY=
X-Google-Smtp-Source: AGHT+IGBXdb6hyj3Yw/rWSwbO5rAgoYmgyYgWxxUmo/dUuRBMv9DOGQaYszRKpqRy+SIKHQNzSWPdA==
X-Received: by 2002:a17:906:c156:b0:b07:b7c2:d7fc with SMTP id a640c23a62f3a-b1bb5e571cemr449189866b.6.1758183108650;
        Thu, 18 Sep 2025 01:11:48 -0700 (PDT)
Received: from [127.0.0.2] ([2a02:2455:8268:bc00:2802:b9c0:7d04:71e9])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b1fd2ce20f4sm139986566b.111.2025.09.18.01.11.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Sep 2025 01:11:48 -0700 (PDT)
From: Karthik Nayak <karthik.188@gmail.com>
Subject: [PATCH v3 0/8] refs/reftable: add consistency checks
Date: Thu, 18 Sep 2025 10:11:41 +0200
Message-Id: <20250918-228-reftable-introduce-consistency-checks-v3-0-271af03eb34d@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAL2+y2gC/5WNSw6DIBQAr2JYlwYBBbrqPZouFJ5KqtCANTXGu
 xftot26nPeZWVCEYCGiS7agAJON1rsE7JQh3VWuBWxNYkQJLYjIOaZU4gDNWNV92rkxePPSgLV
 30cYRnJ6x7kA/ImZCGTCK6YJzlHzP9Gbfe+t2T9ylex/mPT3l2/Rbkbk6UJlyTLCsZVNKoZpKw
 bUdKtuftR/QVpnoz6wIPWKmycwbVdZMMi6E+jev6/oBZv9GzjwBAAA=
X-Change-ID: 20250714-228-reftable-introduce-consistency-checks-379ded93c544
In-Reply-To: <20250819-228-reftable-introduce-consistency-checks-v1-0-8b8f6879fa9e@gmail.com>
References: <20250819-228-reftable-introduce-consistency-checks-v1-0-8b8f6879fa9e@gmail.com>
To: git@vger.kernel.org
Cc: ps@pks.im, gitster@pobox.com, shejialuo@gmail.com, 
 Karthik Nayak <karthik.188@gmail.com>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=5602; i=karthik.188@gmail.com;
 h=from:subject:message-id; bh=1GBlgl6IdrFqqD8ZJkZZ/To7zYM+WP15ShyhvgsB91c=;
 b=owJ4nAHtARL+kA0DAAoBPtWfJI5GjH8ByyZiAGjLvsI8tmTT/WyOyNZbYPC23a/bbSaxkby9u
 fKgr8KeF2VnPIkBswQAAQoAHRYhBFfOTH9jdXEPy2XGBj7VnySORox/BQJoy77CAAoJED7VnySO
 Rox/M3cL/j+TeS3exaIaaaUTBryRxHbnIbitK7JdsemIzUYAFS4eIBQf0psO7IAygDOrBXHVo67
 TP2WfG0wlk5YWfPqItI8QiyMkI+yPLM3I40Vw3metAjmzo2JDifXM7/t8bAFAWgW4Ue9U7OS7xP
 WSWrVinfWrlmLzEd9aQnIvSDLBpJbwEnhO3imD3yaDDylDqg4zQG+Kx8IQp13Vev1uS+Ijlq7nM
 w4Sov88OSxMe6+qJ4ud5dgu0bCsdZGNxSwwF05o/iUyiKHrrU1qeM60qT9ruiyDiVfMA6V+r4Uo
 kmp10wnrj/T+P4c/bcRJbMDxxFQuIpGwuPRrfga3gI9eJ+gliKmg52ibBoXcqt0yVjKVfySN+rT
 9HeiXTlBrAUjzPPJ3CPjjOzIR6Zz9nzM5jy2RZAfBHOhnYpZR4kDacdv8G28L3i3+/RMmdBzkx8
 DXnyGcIdDMKUSFlLF1kcUZpDHJr/Zrvf3RYbcNuFG486DCRVphuaYNvplaf00kQHkdJI6LRQ0b7
 fA=
X-Developer-Key: i=karthik.188@gmail.com; a=openpgp;
 fpr=57CE4C7F6375710FCB65C6063ED59F248E468C7F

The reference subsystems allows for adding backend specific consistency
checks. These checks are run as part of 'git refs verify'.

While the files backend has some consistency checks added, the reftable
backend currently has none. This series first tightens the reftable
backend to make it a little more strict and then also adds the required
infrastructure and some simple consistency checks.

Since the reftable backend is treated as a library within the Git
codebase, we don't want to spillover our internal fsck implementation
into the library. At the same time, the fsck checks need to access
internal structures of the reftable library which aren't exposed outside
the library.

So we solve this by adding a 'reftable/fsck.[ch]' which implements and
exposes a checker for the reftable library and returns specific errors
as defined by the library. We then add glue code within
'refs/reftable-backend.c' to map these errors to errors which Git's fsck
implementation would understand. This allows us to separate concerns.

We add the following consistency checks:

  1. Check for validating the reftable table name. This is treated as a
  warning since the reftable specification only suggests a table name
  but doesn't enforce it. Also there is a difference in the table name
  used in Git vs that in jGit.

  2. Check for checking additional files present in the reftable
  directory.

We tighten the reftable backend by raising a REFTABLE_FORMAT_ERROR error
when:

1. The 'tables.list' file doesn't have a trailing newline.
  2. Tables added to a reftable stack are not sequential.

---
Changes in v3:
- I took a long hiatus from this topic, mostly due to other priorities.
  This has been rebased on top of '92c87bdc40 (The eighth batch,
  2025-09-12)' since there were conflicts.
- Junio suggested that two of the consistency checks (trailing newlines,
  sequential update indices for tables in stack) should actually be
  checked during runtime. I have made that change in this version.
- I've cleaned up the code and modularized the 'reftable/fsck.c' code.
- Invalid table name emits a warning, since the reftable spec doesn't
  enforce it but only makes a suggestion.
- Broken down the commits to make it easier to review.
- Link to v2: https://lore.kernel.org/r/20250902-228-reftable-introduce-consistency-checks-v2-0-4f96b3834779@gmail.com

Changes in v2:
- Ensured that 'struct reftable_fsck_info' is passed around as a
  pointer, this provides a smaller footprint (pointer size vs struct
  size).
- Run FSCK checks for other worktrees too, even if one of them fails.
- Separate messaging for table name vs table check and add additional
  test.
- Use the relative path in messages used.
- Small style and typo fixes.
- Link to v1: https://lore.kernel.org/r/20250819-228-reftable-introduce-consistency-checks-v1-0-8b8f6879fa9e@gmail.com

---
 Documentation/fsck-msgids.adoc   |   9 ++--
 Makefile                         |   3 +-
 fsck.h                           |  40 +++++++-------
 meson.build                      |   1 +
 refs.c                           |   4 ++
 refs/debug.c                     |   1 -
 refs/files-backend.c             |   3 --
 refs/reftable-backend.c          |  59 ++++++++++++++++++---
 reftable/basics.c                |  28 ++++++----
 reftable/basics.h                |   7 +--
 reftable/fsck.c                  | 112 +++++++++++++++++++++++++++++++++++++++
 reftable/reftable-fsck.h         |  42 +++++++++++++++
 reftable/stack.c                 |  15 ++++--
 t/meson.build                    |   1 +
 t/t0614-reftable-fsck.sh         |  55 +++++++++++++++++++
 t/unit-tests/u-reftable-basics.c |  23 ++++++--
 t/unit-tests/u-reftable-stack.c  |  28 ++++++++++
 17 files changed, 378 insertions(+), 53 deletions(-)

Karthik Nayak (8):
      refs: remove unused headers
      refs: move consistency check  msg to generic layer
      reftable: check for trailing newline in 'tables.list'
      reftable: ensure tables in a stack use sequential update indices
      Documentation/fsck-msgids: remove duplicate msg id
      fsck: order 'fsck_msg_type' alphabetically
      reftable: add code to facilitate consistency checks
      refs/reftable: add fsck check for checking the table name

Range-diff versus v2:

1:  eea34c56f0 < -:  ---------- fsck: order 'fsck_msg_type' alphabetically
2:  dafcf618e9 < -:  ---------- refs/reftable: add fsck check for checking the table name
3:  20294ade9b < -:  ---------- refs/reftable: add fsck check for number of tables
4:  03c7979528 < -:  ---------- refs/reftable: add fsck check for trailing newline
5:  eb74502cd3 < -:  ---------- refs/reftable: add fsck check for incorrect update index
-:  ---------- > 1:  c9f39a04ca refs: remove unused headers
-:  ---------- > 2:  e1baf61a8a refs: move consistency check  msg to generic layer
-:  ---------- > 3:  88a2ae1171 reftable: check for trailing newline in 'tables.list'
-:  ---------- > 4:  2dd1750a9d reftable: ensure tables in a stack use sequential update indices
-:  ---------- > 5:  a7f6c52385 Documentation/fsck-msgids: remove duplicate msg id
-:  ---------- > 6:  873c21c73f fsck: order 'fsck_msg_type' alphabetically
-:  ---------- > 7:  cbaac94328 reftable: add code to facilitate consistency checks
-:  ---------- > 8:  e7fcc15608 refs/reftable: add fsck check for checking the table name


base-commit: a483264b01b977f3e65a4419103c21e6af7412a2
change-id: 20250714-228-reftable-introduce-consistency-checks-379ded93c544

Thanks
- Karthik

