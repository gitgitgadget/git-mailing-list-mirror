Received: from fhigh-b1-smtp.messagingengine.com (fhigh-b1-smtp.messagingengine.com [202.12.124.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E808231A55
	for <git@vger.kernel.org>; Mon, 17 Feb 2025 15:50:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739807429; cv=none; b=D9NzEj12g1HY+YG0dzez7Q+bNugbzjjCFbUiAX1milkmgWabH0N5VbAG9cGg2A1PSC3YyHrGCBXDenCgLd2tGKDYTPZ7JFTxL1w9fpPlZ9hddFEkaB+mu2SB6/oYotVHNa6dJ+s1BxzuQBKlXGmrFdfrMnRgTrMKTxYczjbU+iE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739807429; c=relaxed/simple;
	bh=QBcF6nYKvO55Attcc/PgxpnRG059Cp5q0sXBcZnM47U=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=QtxTfduVbnfv+UDUW9zMQlE7SzilsC0Qgwcmz6Y/ADY5WH5gaDKc1RT9OmgEeJ0kImeIb+mhKE8QJ5Vv9COa/KPsqXiSSiw2j/WuhLZ5/Kez+7UtCGNIURaNDIUvf7RNbNpMfaTEW//40C3Fnqv9ECAiYGRbxHYbft9rqVSvGaw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=e12DQorN; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=BMHsAk+w; arc=none smtp.client-ip=202.12.124.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="e12DQorN";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="BMHsAk+w"
Received: from phl-compute-09.internal (phl-compute-09.phl.internal [10.202.2.49])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 3EAA92540121;
	Mon, 17 Feb 2025 10:50:26 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-09.internal (MEProxy); Mon, 17 Feb 2025 10:50:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to; s=fm3; t=1739807426; x=1739893826; bh=V7Q+de9TCV
	iu63UnpNuDz52YVF5qVnItBGWT3chZMwg=; b=e12DQorNtmG8lrG4xFspVvNYzA
	VAltXr7jueDltM1BDYpwrS9/RTxombJFKxf5ecGxAEqjkAbiy033yWAmyDz6rW65
	AnkdEPMAh4eIsl1nrPenDhqW2gN+jvUB//D6fciOAF0w0xSlq9xgZZgfX/aRu4WE
	GI8XemwvMqcpZnybeCRqIdxTSu8CWPV21AjxiJtFFiBfq9N/u/+4xrZctbu4/Vuk
	HKuSUWrfetcvddnJQkAqxHlcL2v83jeEBCIKGyI2MM8Onunj8jmE4HrUsFtKqPAS
	0ZqP2tW6NU+A1XQAwyWrlY9ndzT7eUz5ng7EZKNRgkJeML3uMijpcUS1nN7Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1739807426; x=1739893826; bh=V7Q+de9TCViu63UnpNuDz52YVF5q
	VnItBGWT3chZMwg=; b=BMHsAk+wSVyBwoHJTmspXMrne+cKJMAVPzpyOEUqY9OB
	tGlI2M7Yp2tRnUj5Rl7LFNQXEkN3etnjyd0SVFRXAIM7YUVkHbojX20zf3ChcbEP
	AIWMD6cu2WGzreaqCTpgJjwtuRpAxQTStQzq0s98y3FrJH4xOU/lIGaEVBP+skVR
	/aC0JTX34G0332Hd3Ypm8PT1LeJsSREmCpMTsRU3OKJawMkw4BS0err8tGBri9Wg
	9ZSrx/6SzCxg6mJpAR1MMIWcX0mZ4IRSeLkVCNqBKYtoQWW8L1BXNNuds0ahS5hD
	S6JbB+EVeSBimaKwDc8rxarD5qDu/HD8W5t6xDpuEA==
X-ME-Sender: <xms:wVqzZwk7Jw-9NIGW-kOtGlFuhQHJTjsAJAOoAyPZtuTrr6jiYEZEew>
    <xme:wVqzZ_1UADUJhNkvTTIdWu8JRfeOFgF27i0M8u1W2oDONX1Nk1B1nLUzccbklmr5c
    e6zgELSFWUE5TVCqw>
X-ME-Received: <xmr:wVqzZ-rVG5SI1dhuv5YygBOh3tYR2oVHQWZ4wyuVLu8aEuNLYW6kp9T-hp5j22DCPJe0A87SzA3_6PR7Z1nLDCyeF5dCoYM6fPMllLwKCxhKiyg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdehkeekudcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhufffkfggtgfgvfevofesthekredtredtjeen
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepffelgefhjeefjedtueeffffgkeekjefhieffudegtdfg
    uedvgedtlefhjeeugeejnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepiedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepphgvfhhfsehpvghffhdrnhgvthdprhgtphhtthhope
    hgihhtshhtvghrsehpohgsohigrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhk
    vghrnhgvlhdrohhrghdprhgtphhtthhopehsrghnuggrlhhssegtrhhushhthihtohhoth
    hhphgrshhtvgdrnhgvthdprhgtphhtthhopehkrghrthhhihhkrddukeeksehgmhgrihhl
    rdgtohhmpdhrtghpthhtoheptghhrhhishgtohholhesthhugihfrghmihhlhidrohhrgh
X-ME-Proxy: <xmx:wVqzZ8m8pXaTn8ToXxQkDLuSdu0JSJxsID6eqGSbQlBdlFLZMdDJFQ>
    <xmx:wVqzZ-27vf_yWCNTTHWnW_UO1Ria0ia3Zcmz7vr6bq-A3kpnEzG40g>
    <xmx:wVqzZzuOAqBWhQE0xmhjuzUNfJeUvLe2927cwhkPU-AkzyO4FjkjUQ>
    <xmx:wVqzZ6Ui4SddmKYwoGWSZDnFeWbTarWJCb3BiwdB7J0II5dhWxxzew>
    <xmx:wlqzZ4p07fJnbA_AWfIOnSXL-AoBf2uIYEX9t70Kv8iqMkzo9d3FYj_u>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 17 Feb 2025 10:50:24 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id aaf11bd7 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 17 Feb 2025 15:50:22 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Subject: [PATCH 00/14] refs: batch refname availability checks
Date: Mon, 17 Feb 2025 16:50:14 +0100
Message-Id: <20250217-pks-update-ref-optimization-v1-0-a2b6d87a24af@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIALdas2cC/x2M0QpAQBAAf0X7bMtdHfEr8nDOYhOuuyORf7d5n
 JqZByIFpghN9kCgkyPvm4DKM3Cz3SZCHoRBF9oUWlXol4iHH2wiDDTi7hOvfNskHSrjqtpQWZL
 uQQ5eDL7+e9u97wdt6pBYbQAAAA==
X-Change-ID: 20250217-pks-update-ref-optimization-15c795e66e2b
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>, 
 "brian m. carlson" <sandals@crustytoothpaste.net>, 
 Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>, 
 Christian Couder <chriscool@tuxfamily.org>
X-Mailer: b4 0.14.2

Hi,

this patch series has been inspired by brian's report that the reftable
backend is significantly slower when writing many references compared to
the files backend. As explained in that thread, the underlying issue is
the design of tombstone references: when we first delete all references
in a repository and then recreate them, we still have all the tombstones
and thus we need to churn through all of them to figure out that they
have been deleted in the first place. The files backend does not have
this issue.

I consider the benchmark itself to be kind of broken, as it stems from
us deleting all refs and then recreating them. And if you pack refs in
between then the "reftable" backend outperforms the "files" backend.

But there are a couple of opportunities here anyway. While we cannot
make the underlying issue of tombstones being less efficient go away,
this has prompted me to have a deeper look at where we spend all the
time. There are three ideas in this series:

  - git-update-ref(1) performs ambiguity checks for any full-size object
    ID, which triggers a lot of reads. This is somewhat pointless though
    given that the manpage explicitly points out that the command is
    about object IDs, even though it does know to parse refs. But being
    part of plumbing, emitting the warning here does not make a ton of
    sense, and favoring object IDs over references in these cases is the
    obvious thing to do anyway.

  - For each ref "refs/heads/bar", we need to verify that neither
    "refs/heads" nor "refs" exists. This was repeated for every refname,
    but because most refnames use common prefixes this made us re-check
    a lot of prefixes. This is addressed by using a `strset` of already
    checked prefixes.

  - For each ref "refs/heads/bar", we need to verify that no ref
    "refs/heads/bar/*" exists. We always created a new ref iterator for
    this check, which requires us to discard all internal state and then
    recreate it. The reftable library has already been refactored though
    to have reseekable iterators, so we backfill this functionality to
    all the other iterators and then reuse the iterator.

With the (somewhat broken) benchmark we small speedup with the "files"
backend:

    Benchmark 1: update-ref (refformat = files, revision = master)
      Time (mean ± σ):     233.8 ms ±   1.4 ms    [User: 81.2 ms, System: 151.5 ms]
      Range (min … max):   232.2 ms … 236.0 ms    10 runs

    Benchmark 2: update-ref (refformat = files, revision = HEAD)
      Time (mean ± σ):     192.3 ms ±   1.5 ms    [User: 67.2 ms, System: 124.0 ms]
      Range (min … max):   190.1 ms … 194.2 ms    10 runs

    Summary
      update-ref (refformat = files, revision = HEAD) ran
        1.22 ± 0.01 times faster than update-ref (refformat = files, revision = master)

And a huge speedup with the "reftable" backend:

    Benchmark 1: update-ref (refformat = reftable, revision = master)
      Time (mean ± σ):     16.852 s ±  0.061 s    [User: 16.754 s, System: 0.059 s]
      Range (min … max):   16.785 s … 16.982 s    10 runs

    Benchmark 2: update-ref (refformat = reftable, revision = HEAD)
      Time (mean ± σ):      2.230 s ±  0.009 s    [User: 2.192 s, System: 0.029 s]
      Range (min … max):    2.215 s …  2.244 s    10 runs

    Summary
      update-ref (refformat = reftable, revision = HEAD) ran
        7.56 ± 0.04 times faster than update-ref (refformat = reftable, revision = master)

We're still not up to speed with the "files" backend, but considerably
better. Given that this is an extreme edge case and not reflective of
the general case I'm okay with this result for now.

But more importantly, this refactoring also has a positive effect when
updating references in a repository with preexisting refs, which I
consider to be the more realistic scenario. The following benchmark
creates 10k refs with 100k preexisting refs.

With the "files" backend we see a modest improvement:

    Benchmark 1: update-ref: create many refs (refformat = files, preexisting = 100000, new = 10000, revision = master)
      Time (mean ± σ):     470.1 ms ±   5.4 ms    [User: 104.5 ms, System: 363.1 ms]
      Range (min … max):   465.7 ms … 484.3 ms    10 runs

    Benchmark 2: update-ref: create many refs (refformat = files, preexisting = 100000, new = 10000, revision = HEAD)
      Time (mean ± σ):     407.8 ms ±   5.4 ms    [User: 66.0 ms, System: 340.0 ms]
      Range (min … max):   399.9 ms … 417.6 ms    10 runs

    Summary
      update-ref: create many refs (refformat = files, preexisting = 100000, new = 10000, revision = HEAD) ran
        1.15 ± 0.02 times faster than update-ref: create many refs (refformat = files, preexisting = 100000, new = 10000, revision = master)

But with the "reftable" backend we see an almost 5x improvement, where
it's now ~15x faster than the "files" backend:

    Benchmark 1: update-ref: create many refs (refformat = reftable, preexisting = 100000, new = 10000, revision = master)
      Time (mean ± σ):     153.9 ms ±   2.0 ms    [User: 96.5 ms, System: 56.6 ms]
      Range (min … max):   150.5 ms … 158.4 ms    18 runs

    Benchmark 2: update-ref: create many refs (refformat = reftable, preexisting = 100000, new = 10000, revision = HEAD)
      Time (mean ± σ):      32.2 ms ±   1.2 ms    [User: 27.6 ms, System: 4.3 ms]
      Range (min … max):    29.8 ms …  38.6 ms    71 runs

    Summary
      update-ref: create many refs (refformat = reftable, preexisting = 100000, new = 10000, revision = HEAD) ran
        4.78 ± 0.19 times faster than update-ref: create many refs (refformat = reftable, preexisting = 100000, new = 10000, revision = master)

The series is structured as follows:

  - Patches 1 to 4 implement the logic to skip ambiguity checks in
    git-update-ref(1).

  - Patch 5 and 6 introduce batched checks.

  - Patch 7 deduplicates the ref prefix checks.

  - Patch 8 to 14 implement the infrastructure to reseek iterators.

  - Patch 15 starts to reuse iterators for nested ref checks.

Thanks!

Patrick

[1]: <Z602dzQggtDdcgCX@tapette.crustytoothpaste.net>

---
Patrick Steinhardt (14):
      object-name: introduce `repo_get_oid_with_flags()`
      object-name: allow skipping ambiguity checks in `get_oid()` family
      builtin/update-ref: skip ambiguity checks when parsing object IDs
      refs: introduce function to batch refname availability checks
      refs/reftable: start using `refs_verify_refnames_available()`
      refs: stop re-verifying common prefixes for availability
      refs/iterator: separate lifecycle from iteration
      refs/iterator: provide infrastructure to re-seek iterators
      refs/iterator: implement seeking for merged iterators
      refs/iterator: implement seeking for reftable iterators
      refs/iterator: implement seeking for ref-cache iterators
      refs/iterator: implement seeking for `packed-ref` iterators
      refs/iterator: implement seeking for "files" iterators
      refs: reuse iterators when determining refname availability

 builtin/clone.c              |   2 +
 builtin/update-ref.c         |  12 ++-
 dir-iterator.c               |  24 +++---
 dir-iterator.h               |  13 +--
 hash.h                       |   1 +
 object-name.c                |  18 +++--
 object-name.h                |   6 ++
 refs.c                       | 186 ++++++++++++++++++++++++++-----------------
 refs.h                       |  12 +++
 refs/debug.c                 |  20 +++--
 refs/files-backend.c         |  52 ++++++------
 refs/iterator.c              | 145 +++++++++++++++++----------------
 refs/packed-backend.c        |  89 ++++++++++++---------
 refs/ref-cache.c             |  83 +++++++++++--------
 refs/refs-internal.h         |  54 ++++++++-----
 refs/reftable-backend.c      |  85 +++++++++++---------
 t/helper/test-dir-iterator.c |   1 +
 17 files changed, 471 insertions(+), 332 deletions(-)


---
base-commit: e2067b49ecaef9b7f51a17ce251f9207f72ef52d
change-id: 20250217-pks-update-ref-optimization-15c795e66e2b

