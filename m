Received: from mail-pz2-f43.google.com (mail-pz2-f43.google.com [74.125.228.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76E96423E87
	for <git@vger.kernel.org>; Mon, 14 Sep 2026 09:47:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789379281; cv=none; b=S+WcLBx0bFuxkguwtpdFhxPi9nkIDHQFCq64cFNB4iKwOjqaGaqOLtUOxICEVDGU3fxb/c4lqwHawnnbqJx3/k8Ijvxun1sRssI1fUo7pzHcBpb02CQSd8JdMkgMrxxk5WH9z1JUZy6hANhQyd3RGx219AU7Zt0Bbe+XhtL1lP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789379281; c=relaxed/simple;
	bh=nlEQuLbt/KmdO8CUVi8E+dBx9+PR6ujwY8QFlV7zC68=;
	h=Message-Id:From:Date:Subject:Content-Type:MIME-Version:To:Cc; b=F9emMSf+IPclr7M3dWsX3Gc0V0IXWWLtbB6LuWG676llS4EqWMRl6YWm+bcdDCiubMM8uD+eeDJpRDlppJWihYYKcWTdi0LnwLpmzvHEqnL57JFcTsvfshRriARnN9FZcnF1cvTFIxx5kplM6B7zB3EILeAO+Bu7b/GHVy3z3+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ArD86ziK; arc=none smtp.client-ip=74.125.228.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ArD86ziK"
Received: by mail-pz2-f43.google.com with SMTP id d2e1a72fcca58-85469e211a0so1564535b3a.1
        for <git@vger.kernel.org>; Mon, 14 Sep 2026 02:47:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789379279; x=1789984079; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=j43bv1CVmiqKsDyyZ+xHCkHe02yZd5oVCPWQ/NnL6JE=;
        b=ArD86ziKx58UZYDwz1A+X2tw4GM1LZtQG4w6GmsiuUcVN0J4b1anRrX7M7E7QiG5/r
         /yCKg21FRr454IB8L7NhpiOg6X04sllxbjso7hqaWW+2YSnZ4WyoJ1uZIo8sWOmsxr1A
         pUt8MwFiMWn7FsPMl3Q56SDug47Qe6BzD6jlBK5ddPHlJSXiph73KhrISd82HDrBR1+P
         rhLmhCFjV3SeP5MhYYKgFAbveFad2ODhnLg1JesGDp2eCRJjHDnJC9N5De3fyRKy0egc
         RNEaHp1TiPX57avU8+CpHCQ9h5u3ZiSJvyMXy4sAb06jKKbNnIPRgmlHWt+qMA7ZpfXE
         EKJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789379279; x=1789984079;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=j43bv1CVmiqKsDyyZ+xHCkHe02yZd5oVCPWQ/NnL6JE=;
        b=BpjuN7IrPxyIp1PHwUGE+Jc3xubvVuSuSLgn89pHPEfwJwNJAAoaobIF8ShdYR+VJJ
         l/zuzEGq4U4CDll3TkxvZ6gC4qmTVovO1sdBv7JZJ+m4YuWdFYYUHR6fu48w/A8zHvbv
         wZVNPK+vkPLOSE5Jm4qG0x+UC679Xpy8oHOyvE1G2X3i0NDBYjMHU7iS8aqyxJCUHB7i
         eAjzkjRDFjsBzd6ip+v+GXG0OJkhyduNythqZNAnncKDLhJhGHnE/gKAzEdyD2QS9J/N
         9qw6bE1vhZGdnysWzgC5iZpfuER8WSjJbqksGMAJY5/yDcwM1IuLqB3I1WrtjpUrZ3eR
         74Qw==
X-Gm-Message-State: AFuF++lZAzO/2kXVOy99MJl0pnRBi2ODS+AhwFQDK9dDewVRuAC73876
	XOmKPZwV36Ay1D728z8/O1weEO5DanOcR15qZTzvm05i5jz3igg1nsD39k9W4Q==
X-Gm-Gg: AYBFou2KlpsIZXy/RsZn49cJ4+/w+k3yj2r2Ku9/x6Btr+ARSw5dN1PUPxSq7laBhQv
	+mI7J0uPZHNE59eygT0FkLjXRjHHzLBQet/D5+g9HxeArUAFX19oXZnhA5qTLf6f/19Agv1Wwc2
	frcQSovjKCe419n9Ud5dASa5Q596qeSbCFl9QEIv2QqbbWJ7QaRmJjxNbZLJaDYwohYewtnvekK
	JZLL1CobN4Gd1hnHddAxYwli/pcFp0WoEs2d4neISIymgcJLUhxRvIAb2ZZVknhOZdfSxPYUGbs
	kbSQwfDeDhY7e8l0SgnveP/pXbrL1sTSbmbA93y4OVRuYVM6/3+A9arn/6tUkMWUQxjTe5M34yB
	J5fFFk/k0J3alHIvxbXZwxqQgmnPfc8PluZjaBzeCFEQkfZ3UclxQ7xCehkq/Fq879zA8CjI68N
	WOR0nYFclOndACxQkj4RfzENWN8c/tVhG1lxyyFrraU+OW5f+Uu/oipgtgwsESx37i9tMAP/F7T
	0fz
X-Received: by 2002:a05:6a21:7009:b0:3c4:46ca:334b with SMTP id adf61e73a8af0-3db4043dd86mr4274591637.9.1789379278514;
        Mon, 14 Sep 2026 02:47:58 -0700 (PDT)
Received: from [127.0.0.1] ([172.184.209.178])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-14365bb6ba0sm23653390c88.15.2026.09.14.02.47.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Sep 2026 02:47:57 -0700 (PDT)
Message-Id: <pull.2211.git.1789379276.gitgitgadget@gmail.com>
From: "Kristofer Karlsson via GitGitGadget" <gitgitgadget@gmail.com>
Date: Mon, 14 Sep 2026 09:47:54 +0000
Subject: [PATCH 0/2] connected: add incremental connectivity check
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

This series adds an incremental mode for the connectivity check, gated
behind transfer.connectivityCheck=incremental (no expected changes unless
you opt in).

The intent is to solve the problem of the connectivity check slowing down as
the number of reachable objects from the boundary grows.

It relates to the RFC I sent out earlier:

[RFC] check_connected: toward incoming-proportional cost
https://lore.kernel.org/git/CAL71e4Nf=-zCrfN7ghEVGq11irajJhtdxYZgKe0Ycux0qs1ZvQ@mail.gmail.com/



Design
======

The verifier runs inside the same rev-list subprocess that check_connected()
already spawns, triggered by a new internal flag --verify-trees-incremental.
After get_revision() collects the incoming commits, the verifier processes
them in topological order (ancestors before descendants).

The idea is to keep a set of trusted objects, shared across the incoming
commits, that grows over time. We visit the new/untrusted commit trees and
do a comparison walk over the trees of their parents. Entries discovered on
the trusted parent side are remembered as trusted, which lets later
verification skip matching objects and avoid descending into unchanged
subtrees.

More algorithmic details are in
Documentation/technical/connectivity-check.adoc.


Benchmarks
==========

I'll just mention a short summary here, to avoid repeating what's already in
the commit message. The incremental mode is faster than the full mode when
there are few commits to verify and when the active object tree is large. In
the happy case, the work tracks the changed paths and their comparison trees
rather than the full reachable object closure, which substantially reduces
the dependence on total repository size. I've seen speedups up to around 20x
for the synthetic perf tests.

Running against a large real-world repo (3.4 GB boundary closure), the
numbers are more dramatic. All timings use rev-list directly with --not
HEADN, isolating the tree verification cost from the boundary-finding cost:

commits    full  incr.  speedup   full RSS  incr. RSS
      1    1.9s  0.01s    190x      3.4 GB     14 MB
     10    1.9s  0.04s     48x      3.4 GB    125 MB
    100    1.9s  0.37s      5x      3.4 GB    1.1 GB


The full mode takes ~1.9s regardless of commit count because it is dominated
by walking the boundary closure. Incremental scales with the number of
incoming commits and the paths they touch. Memory follows the same pattern:
incremental uses a fraction of the full mode's RSS for small pushes,
converging only when many commits are verified.

There are also regression cases in the synthetic fixtures. With long
incoming histories, the extra parent-tree scans accumulate; in the synthetic
fixture incremental is about 1.5x slower at 10000 commits. Per-commit
changes have less impact than expected: even when every directory is
touched, incremental remains competitive; bypassing the object cache for
tree reads likely helps here.

I cannot establish how common these regression cases are. In the cases I
have tested, however, the regression has remained modest; I have not been
able to provoke a substantially larger slowdown. My feeling is that this is
an acceptable tradeoff behind the opt-in config, since the target case
(small pushes to large repos) sees the largest speedup, while the regression
appears with long incoming histories.

A safety net for this regression could be to dynamically disable the
incremental mode if the number of incoming commits is too large, but this is
left out of the initial version to avoid overly speculative code.

Deepening fetches currently fall back to the full check because the full
check omits --not --all for deepening -- there is no existing-reference
boundary at which the walk can stop. An incremental approach is possible
here too -- using the old shallow roots as the trusted boundary and walking
the deepened ancestry forward -- but that is a separate change and left for
future work. Deepening is also less common than regular fetch and
receive-pack, where the speedup matters most.


Test coverage
=============

Most correctness cases in t5412-connectivity-check.sh are run in both full
and incremental modes to check semantic equivalence. Selected cases
additionally assert trace2 tree/blob counts for the incremental mode, to
verify that unchanged portions of the object graph are actually skipped. It
covers:

 * Corruption detection: missing blobs, missing trees, type mismatches,
   malformed trees (unparseable, mid-tree corruption)
 * Tree optimization: trace2 assertions confirm unchanged subtrees are
   skipped, subtree moves, merge parent boundaries
 * Root commits (no parents -- verifies full tree closure)
 * Partial clones: missing promised blobs, missing promised trees,
   verification of local commits
 * Replacement objects (with and without GIT_NO_REPLACE_OBJECTS)
 * Shallow boundaries
 * Deepening fetches (falls back to full check)
 * Integration: real push, fetch, and clone

Most tests call git rev-list directly with the appropriate flags;
integration tests exercise the full check_connected() path through push,
fetch, and clone.


Alternatives considered
=======================

My first prototype ran the verifier in-process inside connected.c. This
required a second rev-list subprocess just for boundary finding, _nofetch
variants of several object-reading functions to prevent lazy fetches in
partial clones, explicit shallow-file plumbing, and careful avoidance of
die() in all code paths reachable from the verifier. The result worked but
was fragile and touched many files.

Moving the verifier into the rev-list subprocess eliminated all of those
problems: in partial clones the existing --exclude-promisor-objects handling
already disables lazy fetching, die() is isolated by the process boundary,
shallow and replacement semantics are established before the verifier runs,
and error routing comes for free via stderr.

So while I liked the idea of being less reliant on checking within a
subprocess, making that work ended up being a lot more complex.


Next steps
==========

This series only addresses tree verification; the other significant cost is
finding the commit boundary, especially for repos with many refs. I already
have some prototypes for optimizing that too, and if this ends up landing,
that would be something I would start polishing up.

Thanks, Kristofer

Kristofer Karlsson (2):
  Documentation: describe connectivity checking
  connected: add incremental connectivity check via rev-list

 Documentation/config/transfer.adoc            |  20 +
 Documentation/rev-list-options.adoc           |   6 +
 .../technical/connectivity-check.adoc         | 243 +++++++
 Makefile                                      |   1 +
 builtin/rev-list.c                            |  18 +
 connected.c                                   |  24 +
 meson.build                                   |   1 +
 t/meson.build                                 |   1 +
 ...enerate-repo-p5412-connectivity-check.perl |  44 ++
 t/perf/p5412-connectivity-check.sh            |  92 +++
 t/t5412-connectivity-check.sh                 | 655 ++++++++++++++++++
 tree-verify.c                                 | 306 ++++++++
 tree-verify.h                                 |  15 +
 13 files changed, 1426 insertions(+)
 create mode 100644 Documentation/technical/connectivity-check.adoc
 create mode 100644 t/perf/generate-repo-p5412-connectivity-check.perl
 create mode 100755 t/perf/p5412-connectivity-check.sh
 create mode 100755 t/t5412-connectivity-check.sh
 create mode 100644 tree-verify.c
 create mode 100644 tree-verify.h


base-commit: 47ce80527c56f462cb97db4ca8125342204d3783
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-2211%2Fspkrka%2Ftree-diff-connectivity-v1-clean-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-2211/spkrka/tree-diff-connectivity-v1-clean-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/2211
-- 
gitgitgadget
