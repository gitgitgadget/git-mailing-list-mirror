Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4DE925BAD3
	for <git@vger.kernel.org>; Fri, 28 Feb 2025 09:26:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740734812; cv=none; b=kV5YJwvgLTn2vGiJWro3Qpm6HNQq+R2CDOwfps4mTY7R9U8t8gw96CZ3RmqwfBcBDpng8+LgwUFyA6AtuCgx126r0F3xCe68PqOaASov6RnIOtL2VOzI6efEcM7rtfDAQGf4NEU5EHbWK8HMwHeZ6NHrLLdwYhvF2J361A+EupI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740734812; c=relaxed/simple;
	bh=wn72Sj+VPZfuFEGAWlg6BSgYIphD7lGi+01TWQ37DSU=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 In-Reply-To:References:To:Cc; b=VbbF9tn7F9hsJLp82fqz8/hRpliLET3eroW4vL33iuCNuNltVuTaTIZHLqU+qHGyGkGlGrewQw2gZd15tPBMQ0vQqJ7BQMqnpM4xIql3bJh7zClQ2iJ9dSGWkDGfDM8+2jZh5EYYf6I7zR34BVwZXP8Q4wmTXuEh3Uh3QnL6on0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=jGceI91n; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=x6VyLX5d; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="jGceI91n";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="x6VyLX5d"
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 7D91711403CF;
	Fri, 28 Feb 2025 04:26:48 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Fri, 28 Feb 2025 04:26:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1740734808;
	 x=1740821208; bh=Ww/xrwvX9jup8MeucPlXFTMRQRnu1ua6ky4EsQmWc+I=; b=
	jGceI91nbXUyXmY8EocxpNedmyM3kfFAJt9khTZue5bIjvURQld7Im/7N5xeBf7c
	zJXhbFXJLYfdXoWU296xszs9m2is4v0ze3LUqRgn19jY68cF+MkdJ7pMQxh6s9D7
	fjbsWPB/omIIVVk6KVJ7w5jvkvtNoINKcqATGO3cPvaeMe3t8aUgIlFtX6ZhOBZl
	+Oj0A97/talwcFThGiENvcusAksIISfD1d1lM9m6Y7WyoGAa1Mc3VRjcom9H0Y2G
	EMPFiYvibLVT+S7W5EsAdSlZNOTDQDbQR1d399Ut/7eiRZeMAnwaaDi/SXV5b6lp
	p4Q0Th2voTkdUcU5tToTLQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1740734808; x=
	1740821208; bh=Ww/xrwvX9jup8MeucPlXFTMRQRnu1ua6ky4EsQmWc+I=; b=x
	6VyLX5dYCoGbpNYJefJEl4Q27bp95i4hcTuydnACWFPi++6Pj+8ku0ldP49wCVCO
	2/6WSD0HsX02RbJ/p1vmOyaN+PDyegb2QiCGsH+wTS/SmQNFqHpsqMzRGIw9UibD
	YJPh9996wF7Wf9Xnn+V2C6jryoRPMSNmx5j69MpuHRQIXIkIQ8U8TIh8TnaGpiAw
	xii8O/+ckwO32lLlFWulTzuSEH2hcCRAU5v0caLBdOGSpX0/hz0bEj/NlZFJ8Chl
	KJvXp1aujXDemkaICk9/gjk/+yfe8++NOCosUURWd/WoB1pNZ6rdmFHgafRpYt0C
	BnCyj8wfYgre0zbRfnMnQ==
X-ME-Sender: <xms:V4HBZ_y16NyEkO0QahrcKA7arkomLGrv6tuqZga6pepLbGIftM5cTg>
    <xme:V4HBZ3QA3LZql0_idmAgvyxqL--skGM-QHYovkEWJxtZAI5BiBHfLisYwydqqY1GQ
    k_gBAcuJiBoRaEGyg>
X-ME-Received: <xmr:V4HBZ5XBZH7MUihDLaEjZMjkQVEOU8tEDm1izyBYzYONZ-XOXtdYLXjRu1M-tz3mxSmExZRJ6WabcLMlzRPGNXqCAbVVKIalRAAz1OmzMrR_ceQO>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdeltddtfecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhufffkfggtgfgjghfvfevofesthekredtredt
    jeenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrd
    himheqnecuggftrfgrthhtvghrnhepudduveejffffgeejgeehieetuefftddvheelgeef
    feevtdegteelhfekveettdehnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlh
    hushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdr
    ihhmpdhnsggprhgtphhtthhopeejpdhmohguvgepshhmthhpohhuthdprhgtphhtthhope
    hpvghffhesphgvfhhfrdhnvghtpdhrtghpthhtoheptghhrhhishgtohholhesthhugihf
    rghmihhlhidrohhrghdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhmpd
    hrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehk
    rghrthhhihhkrddukeeksehgmhgrihhlrdgtohhmpdhrtghpthhtohepshhhvghjihgrlh
    huohesghhmrghilhdrtghomhdprhgtphhtthhopehsrghnuggrlhhssegtrhhushhthiht
    ohhothhhphgrshhtvgdrnhgvth
X-ME-Proxy: <xmx:V4HBZ5i2EUeWv21pxlhdX9DJhgZnj52D7Ccn4xbZMZ_kDNYp6MPdNg>
    <xmx:V4HBZxAT-4w5AQAyWWNpw12MIvOsxvcMgWS4pcBbkvb9STIZvkQurA>
    <xmx:V4HBZyIaro2bW89Wkv5eV3w_sXd1K_TudLE0HHfjTzpMTgDt11ndyQ>
    <xmx:V4HBZwA-kcTrR3dZ2SVZgjV_3ZXH12Z1D-mERmK-iu6vnATRp0ZeIQ>
    <xmx:WIHBZ7CP1sySI5H3ffJr-mKzN3QTjok1Nj2pdJIG992mho28brvurH50>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 28 Feb 2025 04:26:46 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 252d9b7f (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 28 Feb 2025 09:26:43 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Subject: [PATCH v4 00/16] refs: batch refname availability checks
Date: Fri, 28 Feb 2025 10:26:37 +0100
Message-Id: <20250228-pks-update-ref-optimization-v4-0-6425c04268b5@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAE2BwWcC/43NTQ6CMBAF4KuQrq2BgbbgynsYFwUGmRh+QitRC
 Xd3YGFwQ1y+yXvfTMLhQOjEKZjEgCM56loOySEQRW3bG0oqOQsIQYUQGdnfnXz0pfUoB6xk13t
 q6G0972SkCpMp1BohFyz03KDnql+unGtyvhte67MxWq7/uWMkQ2kh12VqLCS2OnP7SI1Y0BG2U
 LYPAUOoM40GIMwBfqB4A4Hah2KGjClinZqitEZ9oXmeP8Zyh2pVAQAA
X-Change-ID: 20250217-pks-update-ref-optimization-15c795e66e2b
In-Reply-To: <20250217-pks-update-ref-optimization-v1-0-a2b6d87a24af@pks.im>
References: <20250217-pks-update-ref-optimization-v1-0-a2b6d87a24af@pks.im>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>, 
 "brian m. carlson" <sandals@crustytoothpaste.net>, 
 Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>, 
 shejialuo <shejialuo@gmail.com>, Christian Couder <chriscool@tuxfamily.org>
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

With the (somewhat broken) benchmark we see a small speedup with the
"files" backend:

    Benchmark 1: update-ref (refformat = files, revision = master)
      Time (mean ± σ):     234.4 ms ±   1.9 ms    [User: 75.6 ms, System: 157.2 ms]
      Range (min … max):   232.2 ms … 236.9 ms    10 runs

    Benchmark 2: update-ref (refformat = files, revision = HEAD)
      Time (mean ± σ):     184.2 ms ±   2.0 ms    [User: 62.8 ms, System: 119.9 ms]
      Range (min … max):   181.1 ms … 187.0 ms    10 runs

    Summary
      update-ref (refformat = files, revision = HEAD) ran
        1.27 ± 0.02 times faster than update-ref (refformat = files, revision = master)

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
      Time (mean ± σ):     478.4 ms ±  11.9 ms    [User: 96.7 ms, System: 379.6 ms]
      Range (min … max):   465.4 ms … 496.6 ms    10 runs

    Benchmark 2: update-ref: create many refs (refformat = files, preexisting = 100000, new = 10000, revision = HEAD)
      Time (mean ± σ):     388.5 ms ±  10.3 ms    [User: 52.0 ms, System: 333.8 ms]
      Range (min … max):   376.5 ms … 403.1 ms    10 runs

    Summary
      update-ref: create many refs (refformat = files, preexisting = 100000, new = 10000, revision = HEAD) ran
        1.23 ± 0.04 times faster than update-ref: create many refs (refformat = files, preexisting = 100000, new = 10000, revision = master)

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

  - Patch 5 to 8 introduce batched checks.

  - Patch 9 deduplicates the ref prefix checks.

  - Patch 10 to 16 implement the infrastructure to reseek iterators.

  - Patch 17 starts to reuse iterators for nested ref checks.

Changes in v2:
  - Point out why we also have to touch up the `dir_iterator`.
  - Fix up the comment explaining `ITER_DONE`.
  - Fix up comments that show usage patterns of the ref and dir iterator
    interfaces.
  - Start batching availability checks in the "files" backend, as well.
  - Improve the commit message that drops the ambiguity check so that we
    also point to 25fba78d36b (cat-file: disable object/refname
    ambiguity check for batch mode, 2013-07-12).
  - Link to v1: https://lore.kernel.org/r/20250217-pks-update-ref-optimization-v1-0-a2b6d87a24af@pks.im

Changes in v3:
  - Fix one case where we didn't skip ambiguity checks in
    git-update-ref(1).
  - Document better that only the prefix can change on reseeking
    iterators. Other internal state will remain the same.
  - Fix a memory leak in the ref-cache iterator.
  - Don't ignore errors returned by `packed_ref_iterator_seek()`.
  - Link to v2: https://lore.kernel.org/r/20250219-pks-update-ref-optimization-v2-0-e696e7220b22@pks.im

Changes in v4:
  - A couple of clarifications in the commit message that disabled
    ambiguity warnings.
  - Link to v3: https://lore.kernel.org/r/20250225-pks-update-ref-optimization-v3-0-77c3687cda75@pks.im

Thanks!

Patrick

[1]: <Z602dzQggtDdcgCX@tapette.crustytoothpaste.net>

---
Patrick Steinhardt (16):
      object-name: introduce `repo_get_oid_with_flags()`
      object-name: allow skipping ambiguity checks in `get_oid()` family
      builtin/update-ref: skip ambiguity checks when parsing object IDs
      refs: introduce function to batch refname availability checks
      refs/reftable: batch refname availability checks
      refs/files: batch refname availability checks for normal transactions
      refs/files: batch refname availability checks for initial transactions
      refs: stop re-verifying common prefixes for availability
      refs/iterator: separate lifecycle from iteration
      refs/iterator: provide infrastructure to re-seek iterators
      refs/iterator: implement seeking for merged iterators
      refs/iterator: implement seeking for reftable iterators
      refs/iterator: implement seeking for ref-cache iterators
      refs/iterator: implement seeking for packed-ref iterators
      refs/iterator: implement seeking for files iterators
      refs: reuse iterators when determining refname availability

 builtin/clone.c              |   2 +
 builtin/update-ref.c         |  15 ++--
 dir-iterator.c               |  24 +++---
 dir-iterator.h               |  11 +--
 hash.h                       |   1 +
 iterator.h                   |   2 +-
 object-name.c                |  18 +++--
 object-name.h                |   6 ++
 refs.c                       | 186 ++++++++++++++++++++++++++-----------------
 refs.h                       |  12 +++
 refs/debug.c                 |  20 +++--
 refs/files-backend.c         | 117 +++++++++++++++++----------
 refs/iterator.c              | 145 +++++++++++++++++----------------
 refs/packed-backend.c        |  92 ++++++++++++---------
 refs/ref-cache.c             |  88 ++++++++++++--------
 refs/refs-internal.h         |  53 +++++++-----
 refs/reftable-backend.c      |  85 +++++++++++---------
 t/helper/test-dir-iterator.c |   1 +
 18 files changed, 528 insertions(+), 350 deletions(-)

Range-diff versus v3:

 1:  9fa53bcfcc4 =  1:  9b4f39fb07f object-name: introduce `repo_get_oid_with_flags()`
 2:  5f5d7fe8f2f =  2:  dbd0e3d3da5 object-name: allow skipping ambiguity checks in `get_oid()` family
 3:  0feb7829db9 !  3:  63587d1c6ee builtin/update-ref: skip ambiguity checks when parsing object IDs
    @@ Commit message
         object ID to update a specific reference to. These object IDs get parsed
         via `repo_get_oid()`, which not only handles plain object IDs, but also
         those that have a suffix like "~" or "^2". More surprisingly though, it
    -    even knows to resolve references, despite the fact that its manpage does
    -    not mention this fact even once.
    +    even knows to resolve arbitrary revisions, despite the fact that its
    +    manpage does not mention this fact even once.
     
         One consequence of this is that we also check for ambiguous references:
         when parsing a full object ID where the DWIM mechanism would also cause
         us to resolve it as a branch, we'd end up printing a warning. While this
         check makes sense to have in general, it is arguably less useful in the
    -    context of git-update-ref(1). This is out of two reasons:
    +    context of git-update-ref(1). This is due to multiple reasons:
     
           - The manpage is explicitly structured around object IDs. So if we see
             a fully blown object ID, the intent should be quite clear in
    @@ Commit message
             would generally use in interactive workflows. As such, the warning
             will likely not be visible to anybody in the first place.
     
    +      - Users can and should use the fully-qualified refname in case there
    +        is any potential for ambiguity. And given that this command is part
    +        of our plumbing layer, one should always try to be as defensive as
    +        possible and use fully-qualified refnames.
    +
         Furthermore, this check can be quite expensive when updating lots of
         references via `--stdin`, because we try to read multiple references per
         object ID that we parse according to the DWIM rules. This effect can be
    @@ Commit message
         batch mode, 2013-07-12).
     
         Disable the warning in git-update-ref(1), which provides a significant
    -    speedup with both backends. The following benchmark creates 10000 new
    -    references with a 100000 preexisting refs with the "files" backend:
    +    speedup with both backends. The user-visible outcome is unchanged even
    +    when ambiguity exists, except that we don't show the warning anymore.
    +
    +    The following benchmark creates 10000 new references with a 100000
    +    preexisting refs with the "files" backend:
     
             Benchmark 1: update-ref: create many refs (refformat = files, preexisting = 100000, new = 10000, revision = HEAD~)
               Time (mean ± σ):     467.3 ms ±   5.1 ms    [User: 100.0 ms, System: 365.1 ms]
 4:  4202541a160 =  4:  0f964bfc3af refs: introduce function to batch refname availability checks
 5:  e1ff37d766b =  5:  59c5f21a17d refs/reftable: batch refname availability checks
 6:  90363250575 =  6:  395d008b3c8 refs/files: batch refname availability checks for normal transactions
 7:  a019888cd65 =  7:  a8e33c64ece refs/files: batch refname availability checks for initial transactions
 8:  dab106f4530 =  8:  15b3cdae4ee refs: stop re-verifying common prefixes for availability
 9:  dc03794e974 =  9:  0f6901fe637 refs/iterator: separate lifecycle from iteration
10:  c3eb4ecb35f = 10:  c4a9ae51590 refs/iterator: provide infrastructure to re-seek iterators
11:  a0b626e3fd6 = 11:  d9398eb9f48 refs/iterator: implement seeking for merged iterators
12:  e0fe9998d7f = 12:  b653eb7f663 refs/iterator: implement seeking for reftable iterators
13:  84f6d1fc512 = 13:  6a616d0e328 refs/iterator: implement seeking for ref-cache iterators
14:  4ccc5a7c6e3 = 14:  747188e9b81 refs/iterator: implement seeking for packed-ref iterators
15:  7b25a9033d9 = 15:  ebda415ae47 refs/iterator: implement seeking for files iterators
16:  9688d6bc5cf = 16:  80e50011c28 refs: reuse iterators when determining refname availability

---
base-commit: e2067b49ecaef9b7f51a17ce251f9207f72ef52d
change-id: 20250217-pks-update-ref-optimization-15c795e66e2b

