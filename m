Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B231B33A9E9
	for <git@vger.kernel.org>; Mon,  6 Jul 2026 13:35:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783344960; cv=none; b=kjzfD9oE2VIxKVP+phHcdxpoCPwAalIPaj3fal3qc7wpAUg2jLNyFPn86z7PJqYaMysBQDsnplvoKvt5sVDPcfCcrCv5Mv+XBD8LfIiJJVVnxNEHUGaUPJgTLMJlOpLCVDyzEH1hUnVaJ5CAQ4jI+eOPXYA7r1TgSp8gXFU4BZo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783344960; c=relaxed/simple;
	bh=XUvEI5bi/ci9WMRDhGzth6rFlO7S5r/axX/2O+3Gwtc=;
	h=Message-Id:From:Date:Subject:Content-Type:MIME-Version:To:Cc; b=EY0lr3PqgH8N8qlVU4qeNG/XyHKTUbHbK1KjCV++I5XkMMIgeimBaQb655N9W6ixqjok+bppCD9yuK6ePEqJWDSFDEw2OLzr9p34yTqszqA/GboZZBYJa3biTEenJbqVHth5lLRjQ+p7+VzvdjjzymgCtq/+ZPUUDx0OQZswUzk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mPXEhI08; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mPXEhI08"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2cc8bc9d222so13956505ad.1
        for <git@vger.kernel.org>; Mon, 06 Jul 2026 06:35:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783344959; x=1783949759; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=rOGUWQKjnYC3Y2ZKo9BV+KC2Cva/ppeMhRXSNZ9kQFc=;
        b=mPXEhI08O2UvN1JohQnI9YD/ukllHjQacMnNGTmUsNZ0ULU5+Pdc1oOOTKDJSVqsup
         3PgmhUXghXT3ByVdMuHTEyIfZaemCS6ntGtikVOJ3wi9gvtDKFSZeCGWXjH8G7ERfbDG
         nmChdjKirWnqbpYZlwIOfzqpu83w9kdSoHhXh3DEGFfpnHGGWQ1oGQRqB71GlcVktWI8
         iFDeImD7Vn8ZWwFdOAbgIleDHh8sX3zXYnpzGG30BT4JCJi7fYrMvybX1nO2FvxyxvYi
         hnyRoJPxeWjjhx6rmREJueTlPoS2nHffr0uz2T4C3QALNcBib6DmvOl71XmePXG3L6mQ
         gj8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783344959; x=1783949759;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rOGUWQKjnYC3Y2ZKo9BV+KC2Cva/ppeMhRXSNZ9kQFc=;
        b=fKIC5TtIQ9XEZRZY5M7QEyAOI6Shm63HslTlGximbMjOjc1Z9/TFKEykpj7Qy0J8oA
         9GBI2HLDXj+KnGK1zVM0sf5nv/WJjXrJh4Ut31c/eIYCez7AMtFSy6rj/v9TpUBS4RDg
         rxIw5T/dAjMPbGyx7MpT0+4nqN2XFnSxKCAnnqTSPihE49IYg16i6Z9GXBGASnSXGAiQ
         WYoPOIdaLX6E9mTFG9wewFf+1gJouwqodJQjRdNWn60tyS+c1AwNSzBRcVJMhINZFi9I
         HJ4R/UoCpX1uqJOkjKk2bHZggrhJxclMBBQs5g+YfR6T2To3UKqOonvZPA7lmAL8dTvd
         sICw==
X-Gm-Message-State: AOJu0YxRzNRAvMSqACqP+XcvtX/Ln9WkkYWd6qVqM4avEpykpH5obskc
	M6xiPjDQgzrKr24ongqFdPxTDCCjWMT1zRy+JgThocuPQ5phjgi1fm041G0vdA==
X-Gm-Gg: AfdE7cmsjz6XGe15ZSNwuFzuBWWO4vB6ui+IslCtmgQZcsz16wloydYsoqkpu+4k4Ev
	Iu06c+PWSzZN6YGqhIBmvEm7//d72gfeArbkU90kmY6uRtJjUb/bDvTrgAb9spx0GDuBw7K2NmU
	1AgQXIkjwIYgwBTc1LXcjGzXZBG7cP4my94kgc+c4aSa7ZrzJZqW2zLLZ7C5aVElRSDfR85plr0
	shZ5VOGTek6uUPoRw1f7Gmbbr6DYMHB27QCpafXkZprgr/ZlRnjj+8B9faKaZlocL39zItIV8cJ
	H/7WWK7CtGhup9Q6V1hMn6MOCz1R1CT3YzGQdd8ZCNjPJJI/wPUXKoOJlRXkPCW6bYkMq+2XlWK
	IPtgUih+tO5hQ+y9LTZ8IWKTFVmQqQgkNJuZ3jVdTs0HmV2rRY8U+0oewjP1Kx632r4Lc5O+I/J
	BARPuTOrwmiZ0+Pke2EybHVPc=
X-Received: by 2002:a17:902:ef44:b0:2c7:faae:ab15 with SMTP id d9443c01a7336-2ccbe40ea74mr6279005ad.10.1783344958862;
        Mon, 06 Jul 2026 06:35:58 -0700 (PDT)
Received: from [127.0.0.1] ([13.83.42.69])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2cad7894b20sm50784315ad.78.2026.07.06.06.35.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jul 2026 06:35:57 -0700 (PDT)
Message-Id: <pull.2166.git.1783344957.gitgitgadget@gmail.com>
From: "Kristofer Karlsson via GitGitGadget" <gitgitgadget@gmail.com>
Date: Mon, 06 Jul 2026 13:35:54 +0000
Subject: [PATCH 0/2] reftable: fix quadratic behavior when re-creating deleted refs
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
Cc: Kristofer Karlsson <krka@spotify.com>

This series fixes quadratic behavior in update-ref when many refs are
deleted (tombstoned) and then new refs are created with the reftable
backend.

The root cause is the merged iterator's suppress_deletions flag, which
silently consumes tombstone records in a tight internal loop. This prevents
higher-level code from checking iteration bounds until after all tombstones
have been scanned, making both refs_verify_refnames_available() and
reftable_backend_read_ref() O(n) per call in the presence of tombstones.

The fix removes suppress_deletions from the merged iterator and instead
handles deletion records at each call site in the reftable backend, where
prefix and refname bounds are available. This lets existing bounds checks
terminate iteration early when encountering tombstones past the relevant
bound.

The first patch adds tests for tombstone scenarios: a perf test (p1401)
exercising two patterns with 8000 refs, and a correctness test (t0610)
verifying that deleted-then-recreated refs are visible.

The second patch is the pure optimization. Both p1401 tests go from ~14s to
~0.2s with the fix.

Note that auto-compaction typically merges tombstones before they accumulate
to this degree, so the quadratic behavior may not show up in every workflow.
But the fix ensures correct time complexity regardless of compaction state,
and the change is fairly contained.

Previous discussion:
https://lore.kernel.org/git/20260701080014.GA3748390@coredump.intra.peff.net/

Kristofer Karlsson (2):
  t: add tests for ref tombstone scenarios
  reftable: fix quadratic behavior when re-creating deleted refs

 refs/reftable-backend.c              | 54 ++++++++++++++++++++++------
 reftable/merged.c                    | 12 +------
 reftable/merged.h                    |  4 ---
 reftable/stack.c                     |  1 -
 t/perf/p1401-ref-store-tombstones.sh | 44 +++++++++++++++++++++++
 t/t0610-reftable-basics.sh           | 22 ++++++++++++
 6 files changed, 110 insertions(+), 27 deletions(-)
 create mode 100755 t/perf/p1401-ref-store-tombstones.sh


base-commit: e9019fcafe0040228b8631c30f97ae1adb61bcdc
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-2166%2Fspkrka%2Freftable-tombstone-perf-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-2166/spkrka/reftable-tombstone-perf-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/2166
-- 
gitgitgadget
