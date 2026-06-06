Received: from mail-dy1-f182.google.com (mail-dy1-f182.google.com [74.125.82.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 234B63BB4A
	for <git@vger.kernel.org>; Sat,  6 Jun 2026 19:01:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780772481; cv=none; b=d71grw44GeHIGMRLfAv8nYrque8c41e6ixpPyCqNtubgonj8l+ToFc/p7yV24h5QEXnmzVKhLrMY5nbkb3Jur/ahhBaU41YAYKTiDdcmfgzhDyhX+T/7q8U7vFDTPOP0Mnz3sI+eVhQAUsieG+A8psw6DohDmuFDIZV/e9XnER8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780772481; c=relaxed/simple;
	bh=hoOYwwOCxOvl9n3pkS4YCtOJCLD73t/Ywsy+FOX/aoM=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:MIME-Version:
	 Content-Type:To:Cc; b=BZAMBa4UwcTa/m1mLdGL4yONNRD6KH1YGBf8LyzwoaO2ZuRrZzaVKiGV3PZJsVQARYRSXDoXl+lx7oW2XUSJjnDsuaNa7YkmFyF1VlPUtkxnJugOwSqGmlCg+y+pL1dUvWungv3t85QazIH/w7zcP5uuOHrnqDPmjMkpK0QtVOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bugsGRqq; arc=none smtp.client-ip=74.125.82.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bugsGRqq"
Received: by mail-dy1-f182.google.com with SMTP id 5a478bee46e88-3074adb8fcaso3838391eec.0
        for <git@vger.kernel.org>; Sat, 06 Jun 2026 12:01:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780772479; x=1781377279; darn=vger.kernel.org;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rmEHueG1DJlgwpNrt3Fpjq0uLNGFV8S7SRbvd+hyqHI=;
        b=bugsGRqqohJuQIxhgI3FPpvtlEUJIpSGl5TZAEFR/t34ZajXwnlxANnGGX6v0I8oiQ
         g8GToolgkJNEk7lhPzjcr3ICXBeTI3ocF9GmZ4eJP5Q5nlWFJEdsjNfZKd0nb8XyWaN2
         sTO29U2D50ozQpPUF30RlsC3EMlqBHaeQ+loXSKx2GhO5mdVZ5Js6+VQugCkcp7CY6Q+
         IqpwzgeLL27s+CfFQ0ggnGMVLNhH2WwgSBtHXVFngXtvpcpWI7AA7NPVWneOjoZucv1v
         k23czv2AriQQt0NdsIzMbCwaNmxfkW9ybL3QpnKUpLZ3e5zlE1p0rmQJJ7sVwI9bz9Ry
         1pUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780772479; x=1781377279;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=rmEHueG1DJlgwpNrt3Fpjq0uLNGFV8S7SRbvd+hyqHI=;
        b=aH7ZMwEf7ftAgpnF/J6sUv4sHefUV6Cjj1w1Zufvtn5fCzOym3yDZ1zXe+mG570Ygn
         wKB8lR9BcYOCMfpW7i6axCRPvlftEK+S0c3+RvbmplnyXFWS1ymPbiOJ1s9f1v0ZcJPp
         iEe4KyOhCR4SY42PPVCKMURqLOhMdrsjAZwaQutDr+VQu95eQ2MSOKOEg/o5V/Tboi1K
         f1eQplQuG9IJvi5RJhta59MqbM6j/69+Qb1hEQPRSAqbwqIpbgyDXU4peq2yPT9ILkTv
         jxsodM7ZV41hLDdtCnswKqzK5R/53tv1PIc0GHQSjpwjvKKhpGkkJIcOYy9Cd2XBagOF
         M+2A==
X-Gm-Message-State: AOJu0Yz44DyrKOECviAf/vYKG5+GexqYNna5dGngFk2fld5eEgUQlt46
	u0AKfE4uIJMFNtvA5NiidKsBf81gFYNdpAcTnBtRJFkSbYOumRuohVK9n0eP1w==
X-Gm-Gg: Acq92OHsX9m3cN4Ma2ChVM/pOPP4bCt+i5E2qsTsJae7TK9DS+jT6tMq5D9vEravCyP
	XQDkBBPdger4y7SajPrLiBUJur7Aqqmm+WE3lUr6M+sNr6slihr336Vy4NE/1eG7jkXmggjg2jc
	sqSrjzw7Kd4iVU3fMXp6MVA9Qmfn53+8QP5xPWGib/dJr/nQ5og3yaSEqWZQ0Y1NztxdqCG/lN+
	6/8JiHA4RMiI1Ho8/jT1h8ostdNOAgCuZYEv7V/uENvkGZzlysX9q/Gb5vvtbdWZfQCOmPdgqOh
	1but1cG+jaRjA7RZ7XMLGH0RgK5qVOg3h7p4LxthT3XQPzLtDPI7lBuh4uFzpnxhYKWK15ZnBhf
	a7b+/JvP1mHTkNCaE1NwmvTJ0DFlmgv1uCM4dhd0oe7LgU9UBY4S6y18NFbzaXT+zsJucfZ9ORX
	hphDjO4F9otLcKUp49aemsVfxVbgV7iOpXr2ciYg==
X-Received: by 2002:a05:7300:7314:b0:304:641b:12fd with SMTP id 5a478bee46e88-3077b22b54cmr5935127eec.27.1780772479102;
        Sat, 06 Jun 2026 12:01:19 -0700 (PDT)
Received: from [127.0.0.1] ([20.168.117.154])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3074dea9226sm11461793eec.19.2026.06.06.12.01.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Jun 2026 12:01:18 -0700 (PDT)
Message-Id: <pull.2140.v2.git.1780772477.gitgitgadget@gmail.com>
In-Reply-To: <pull.2140.git.1780757885582.gitgitgadget@gmail.com>
References: <pull.2140.git.1780757885582.gitgitgadget@gmail.com>
From: "Kristofer Karlsson via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sat, 06 Jun 2026 19:01:14 +0000
Subject: [PATCH v2 0/2] prio-queue: fold lazy_queue into prio_queue for automatic get+put fusion
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
Cc: =?UTF-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
    Kristofer Karlsson <krka@spotify.com>,
    Kristofer Karlsson <krka@spotify.com>

Rene's lazy_queue wrapper in describe.c was a clever optimization -- by
deferring the get, a following put becomes a simple replace, avoiding a full
remove-rebalance-insert cycle.

It turns out this pattern is so common in git's traversal code that it makes
sense to fold it into prio_queue itself. Gets and puts are interleaved in
virtually every commit walk, so the fusion is essentially always a win.

This is mostly a code simplification -- three callers had independently
reimplemented the same optimization, and they all collapse to plain get+put
now. The 3-6% speedup on traversal-heavy workloads is a nice bonus.

More details and benchmark numbers in the commit message. Benchmarks were
run on next which includes kk/commit-reach-optim -- those results represent
the more realistic end state.

Related to but independent of the cascade sift-down work in
kk/prio-queue-cascade-sift -- the two can land in either order.

Changes since v1:

 * Added a second commit that renames .nr to .nr_internal so that direct
   access from outside prio-queue.c is a compile error. Verified that after
   the rename, only prio-queue.c references nr_internal.

 * Added prio_queue_for_each() macro for callers that need to walk all
   elements (describe.c, show-branch.c, commit-reach.c, revision.c,
   negotiator/skipping.c).

 * Converted remaining .nr loop conditions to use
   prio_queue_get()/prio_queue_peek() as the loop condition, or
   prio_queue_size() where get/peek isn't suitable.

 * Fixed several callers missed in v1 (object-name.c, fetch-pack.c,
   path-walk.c, pack-bitmap-write.c, negotiator/default.c,
   negotiator/skipping.c, revision.c, builtin/last-modified.c).

Kristofer Karlsson (2):
  prio-queue: fold lazy_queue into prio_queue for automatic get+put
    fusion
  prio-queue: rename .nr to .nr_internal to prevent direct access

 builtin/describe.c          | 70 ++++++++-------------------------
 builtin/last-modified.c     |  7 ++--
 builtin/show-branch.c       | 24 +++++-------
 commit-reach.c              | 24 ++++++------
 commit.c                    | 11 +-----
 fetch-pack.c                |  4 +-
 negotiator/default.c        |  4 +-
 negotiator/skipping.c       | 12 +++---
 object-name.c               |  2 +-
 pack-bitmap-write.c         | 10 ++---
 path-walk.c                 |  8 ++--
 prio-queue.c                | 77 ++++++++++++++++++++-----------------
 prio-queue.h                | 19 +++++----
 revision.c                  | 16 ++++----
 t/unit-tests/u-prio-queue.c |  6 +--
 walker.c                    |  4 +-
 16 files changed, 129 insertions(+), 169 deletions(-)


base-commit: 9ac3f193c05c2237e2b14ebaa1149e9fc8a1abe0
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-2140%2Fspkrka%2Flazy-prio-queue-pr-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-2140/spkrka/lazy-prio-queue-pr-v2
Pull-Request: https://github.com/gitgitgadget/git/pull/2140

Range-diff vs v1:

 1:  29af24445e = 1:  29af24445e prio-queue: fold lazy_queue into prio_queue for automatic get+put fusion
 -:  ---------- > 2:  bb8b0f78f1 prio-queue: rename .nr to .nr_internal to prevent direct access

-- 
gitgitgadget
