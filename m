Received: from mail-dl1-f51.google.com (mail-dl1-f51.google.com [74.125.82.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE5A713D53C
	for <git@vger.kernel.org>; Tue, 28 Apr 2026 04:05:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777349130; cv=none; b=JgKiJM2YrSeC2iKfEKRtmHml/YO8NiuplJaVvYp0ABa3B0LF8bo8Fxq4EELU8YAwercmoeRQgijASASLPYSeErjvT03s7+LmiO9D8AUBcPvDu4PDeORkYpYYY9204ZFz5dyfL2m/PJGgEy4sjvUV5nVWQqK3q51N6x/zHFRoGJ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777349130; c=relaxed/simple;
	bh=AcJi+CDP+HU9lnuKECyoRl9QiuKjH8Lf3GCW+S2nIh8=;
	h=Message-Id:From:Date:Subject:Content-Type:MIME-Version:To:Cc; b=KgeFHHgiV9nEu2J891Jd5DhBrCIM7NCpy72g5mqB6bxjU92dAFmztcL/lVc10b2pVCES5S8zi5CydC7FHLqZ2jmFHRM6b8McahJGFlS+He1B7z3x2PXYvvaRQAlpar4S/o6mJP1UYGPumtEDV/ZFnEMYpLsBGKZgguEy5rwVW0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AGrAXlj6; arc=none smtp.client-ip=74.125.82.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AGrAXlj6"
Received: by mail-dl1-f51.google.com with SMTP id a92af1059eb24-12c565dd3a7so1985144c88.1
        for <git@vger.kernel.org>; Mon, 27 Apr 2026 21:05:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777349128; x=1777953928; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=tS02I0Bp0JZ8+mVtY7lV3xr1T9JeM8gw4cJyA5fNG4s=;
        b=AGrAXlj6PpPRv8Xx5y14mgS4UQpyF4zamEr5RVWZjvUU0yXkaYQN+0ckRpH3oHSsCZ
         XamUahn2ybURuSmX0TgPPJBWsd975uR0DplWbY7E+izHYe1UFadqCz95YgR+HdQHlG0g
         O7+DREYG/CmyANCtfickDm128u50p8qR5nQnuzlECwZP99Do3BpcPxJBCVucCtOyLJjk
         y3TY+gFzLSo3734ulOCxqlhjlXr+r5cOU7yWJKFSCrc+Vhnn9L+jVsj+BXJamgCR9W1q
         sW3YGw8i6jMdtO2nZouYg6DUE9W+Jb3A0s1LSYgDF0VUKzX1VEkAMl7G/+0byoo27htH
         I+bA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777349128; x=1777953928;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tS02I0Bp0JZ8+mVtY7lV3xr1T9JeM8gw4cJyA5fNG4s=;
        b=JQmifvVfY6VB7k3m25JuNeEpGP+B6S1ultmBnCPg1/N3Oo1odXEApbzMwwSRVKhA+f
         KwpAikISaQQ9j/Ph6ISQ1QjFcOFOiFkhA5n7R5EDCNb2wwLTW5P8OBhzqagOFKy8Rhjx
         3ZVINiwn2Z6jSM3LSoY3rC8U+VxIMEwvt/YBs5YwOlkfVBqxrG3B4ixfnJfB8/z8IFp2
         zIjyKpMImZpkEg1U+9VHewVDT2d9DLL2TSLHIuk6Gr4IkH8uAxAHVFVaMtgqHounBxDp
         LNenUDp/iEPfoGClcjWsmAaHRhgjNhiaSoP2goMvmtyP/iofx/Hwo6SdXkuBECpse9DN
         GaLQ==
X-Gm-Message-State: AOJu0YyW0O9etwAp9qKfauy9HltH4YKb59fp4MtOWjOiuGn245Bz+vZu
	kh3Ni+E+rAUePVh52P4m/7uzbf+CxBvb5kVJotbQRJtfyzfO9xnDEcUQazDoGQ==
X-Gm-Gg: AeBDietj2JfUDq7t69Co1aOaBtq949cXaaL9leu9R1D5VJgAZy8wSTs85cxgjsnYQue
	tNAVZ+dgdqCRX5i1Rh/hYZwdSp+UiY4LxAMIfvu5AVUzoPbpVnTl/m78PdtDi/aWGlPjsmrsrCp
	QQZaSUNx0OvqgB3EPVe0fEV4g6d8q6lTwhPdI7SVucTDytmbJWscwtwsAP8R+aNGOZaMfCeVuIM
	MggaH0DKZ2lrU+xxS2lXdGm7wITbkr5eqgnoQqHRCBOevm3EI8Gm9NUfhix6ctfQFcpY6rSXm4A
	X4X3478bx8MieofMAOaFp/uDciKOhaWn2/Zw+DrBCcdIcQP8TL+RXzynLNBPynp4omC+66KblmX
	O+Y3Y86kT0anirh+tC6xw7Mtjb4HP4S3Vre3CNaOmZFtV6vQZkHsNo0MNv6uBpvEBTmE3IDTDdh
	B5n8iGHfLK/AyrJlb+iVkWx8ZKANdexCijT+5tkM3qfgx7ZZc=
X-Received: by 2002:a05:7022:fe06:b0:12d:de3f:d843 with SMTP id a92af1059eb24-12dde3fdca2mr293005c88.38.1777349128154;
        Mon, 27 Apr 2026 21:05:28 -0700 (PDT)
Received: from [127.0.0.1] ([128.24.167.68])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-12ddd9a60f3sm1745168c88.10.2026.04.27.21.05.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Apr 2026 21:05:27 -0700 (PDT)
Message-Id: <pull.2094.git.1777349126.gitgitgadget@gmail.com>
From: "Michael Montalbo via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 28 Apr 2026 04:05:23 +0000
Subject: [PATCH 0/3] line-log: integrate -L with the standard log output pipeline
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
Cc: Michael Montalbo <mmontalbo@gmail.com>

Since its introduction, git log -L has short-circuited from
log_tree_commit() into its own output function, bypassing log_tree_diff()
and log_tree_diff_flush(). This skips no_free save/restore,
always_show_header, diff_free() cleanup, and means that pickaxe (-S, -G,
--find-object) and --diff-filter cannot suppress commits whose pairs are all
filtered out, because show_log() runs before diffcore_std().

This series restructures the flow so that -L goes through the same
log_tree_diff() -> log_tree_diff_flush() path as normal single-parent and
merge diffs, then uses that to enable several non-patch diff formats.

Patch 1: revision: move -L setup before output_format-to-diff derivation

Preparatory reorder in setup_revisions(). The -L block sets a default
DIFF_FORMAT_PATCH when no format is requested; move it before the derivation
of revs->diff from output_format so the default is visible to that check. No
behavior change on its own.

Patch 2: line-log: integrate -L output with the standard log-tree pipeline

Rename line_log_print() to line_log_queue_pairs(), stripping it down to only
queue pre-computed filepairs. log_tree_diff_flush() handles show_log(),
diffcore_std(), and diff_flush(). This fixes pickaxe and --diff-filter
suppression, and aligns the commit/diff separator with the rest of log
output. Also rejects --full-diff, which is meaningless when filepairs are
pre-computed.

Patch 3: line-log: allow non-patch diff formats with -L

Expand the allowlist to accept --raw, --name-only, --name-status, and
--summary. These only read filepair metadata already set by the line-log
machinery. Diff stat formats (--stat, --numstat, --shortstat, --dirstat)
remain blocked because they call compute_diffstat() on full blob content and
would show whole-file statistics rather than range-scoped ones.

Michael Montalbo (3):
  revision: move -L setup before output_format-to-diff derivation
  line-log: integrate -L output with the standard log-tree pipeline
  line-log: allow non-patch diff formats with -L

 Documentation/line-range-options.adoc         | 10 +-
 line-log.c                                    | 30 ++----
 line-log.h                                    |  2 +-
 log-tree.c                                    |  9 +-
 revision.c                                    | 25 +++--
 t/t4211-line-log.sh                           | 99 ++++++++++++++++---
 t/t4211/sha1/expect.parallel-change-f-to-main |  1 -
 .../sha256/expect.parallel-change-f-to-main   |  1 -
 8 files changed, 120 insertions(+), 57 deletions(-)


base-commit: 9f223ef1c026d91c7ac68cc0211bde255dda6199
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-2094%2Fmmontalbo%2Fmm%2Fline-log-use-log-tree-diff-flush-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-2094/mmontalbo/mm/line-log-use-log-tree-diff-flush-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/2094
-- 
gitgitgadget
