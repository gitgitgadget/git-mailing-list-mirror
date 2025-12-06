Received: from mail-yx1-f48.google.com (mail-yx1-f48.google.com [74.125.224.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F625CA5A
	for <git@vger.kernel.org>; Sat,  6 Dec 2025 20:31:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765053068; cv=none; b=Hl9efvPIcXEHpYSNfLdL3ZbYPRegKC1MeU+/6ErJKgxT4F7jA0bu6B+QyPrkTqAOoSmwi3f5k/p8EUPt3D1acBw42u5BI1IPdQ13nGLTzLn6CqzdOFKVs6SgkiJdTlxfsvulL1WQgpfhNScKwhHIQ8hQbKj6WFy9ug4jOi+K43I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765053068; c=relaxed/simple;
	bh=h9wFGX2i+XRf3sHV3bE8peh7ByB7PP62JdC+xB1C9xE=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=CwetfZyBlecZLeoWENWFQ5CZE82WVrD9K4liGFzV/JOl33mH1+OIBqu/ot+BQD4F3KPRBuePXsucEA9fJTEEVIIeoMY2Jr3ULK/ZayY84SmuSSmpCmMNMY9ARP1V2yEdQYxQn/s+WA4USq79oyz5nCjh72UG7kIWQdyFCj1QnYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b=WVkfIaQs; arc=none smtp.client-ip=74.125.224.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b="WVkfIaQs"
Received: by mail-yx1-f48.google.com with SMTP id 956f58d0204a3-64308342458so2951756d50.0
        for <git@vger.kernel.org>; Sat, 06 Dec 2025 12:31:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr.com; s=google; t=1765053059; x=1765657859; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ACXcOUGUgqWnDdN7SjAcKHIM75qE8aAQtDSSHgevjKc=;
        b=WVkfIaQs4ejnZtZv86y3gRPXqw4+hMVJBPcWqpHRi37oxYFvv9JhuU7GCvtTGKvzLs
         skSZzesTF0c5S9r7iZ4/j/vz1jErscuSp+V8DjfQKWWx+7k1DumiS/n/IRR1GpSYQ2Nu
         ULKPvvHO4TJZqK3kyyC7bKwUnA6dvFP+/VLFD6at6j96ECnpmocceX20VAAsn9ev44vu
         XLqtuAKOuUjfBXFfeXvgfrND2IR/8hiBhhCzXsyBChKpwFR/zjXzOt+l42RhgIezT5IG
         F4KAu4KZSssiqhFbsoFAeu0lruqO86w0lhy6UvnU2esI61rZjB0F+bs+pq/pZBCgVFoZ
         /+aA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765053059; x=1765657859;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ACXcOUGUgqWnDdN7SjAcKHIM75qE8aAQtDSSHgevjKc=;
        b=h51/zb0Rqiuk19mG2blFRjvsq9i5beB0zKt3+YyOlNeeAndzADiHZPChNNL0Nq4OoJ
         K1cfTbvzgpB8efZrsIRGTLEnja+4BiP9w9AxQlPwVhiRkD9ZW4E+LUtiquz+XCMYUrJI
         4gR8EMTCzkl6K0hwFSAWJr++UvnXv5xU7vk35D3xkrKSML8K7Pb2aZW4P+x9MFBlpB2z
         rt+bzjzXJMwHWDz95MkmPGBh16VoQcgwxRf1gAzE7zorOsIQ2HGtUBKYN73MQqCeieOS
         1+s97P8LWFWQjtFq0hqMixC6HuIbXw8ionG9yLekw+eEtRnFb6s4ULF8XEtSKAzv50c/
         ajKg==
X-Gm-Message-State: AOJu0Yy+nav3EU2PtQUhIdlvYt2AfLr8YDp8sbSgNNb418WrHW85dUYL
	62r2F1eWJGKnaPj7ctQsw+EoB1e+yZhCvtkp1nYSavru66PXaiRE+laMFiEp1wxjIWhBPef793K
	MCRIzkfI=
X-Gm-Gg: ASbGnctCFokgP8u/wfZDGJnHEGY2jHvmCjAthIn0QuMTdTfPCj1Hw10BZR/qMjVjshh
	KkuFOtJefZYlOPqn5N5HfxTRoowyNyAkgXJtTSxUdEW5Bi15qUh13Q2ArIW+ZlU0mO5wJVbrQt+
	mH4MT5KLmmdeiBO+NgVKCeY7CzWMAkO4ltWccS3qNFthyIOxuRE8sfpgaJItE/kNQZzPbmPTYYD
	nRHwjCQI2kKcY0LKelodZ25oX/JaoSexi74nuu1xczYlATmAneoffnUxkW0XwcDoDTuej0LSxJW
	/0M+Vv6iH1FFbGP+c2960qJB5gCcv8IryVPooJtRxwevo39frVKLWlCvFFESrCA68qAhyQ8JGDf
	PkjzQdpbqkMFG5IROyciMVWu/g1QutcEnFPO7CQbRboFhT1BUszp9ZRTG95VFbkIhzV7gIOnIJR
	VhfZRmM01kPN02WhZw3nUP9UQhJUASCQ9FtXLpMGOwORnNEiW8HDIYD5FmQmy4RsKY2sgdYlwAg
	iiqtV8pR6G2G6FCuA==
X-Google-Smtp-Source: AGHT+IHtvWD4uDwZYq1+i7NPGy5REUL9mh746izWcCgxppDQ3SA3f8MgQbIhuhDY8/MDrQ+NkNOGCg==
X-Received: by 2002:a53:bad0:0:b0:641:f5bc:6966 with SMTP id 956f58d0204a3-6444e7f0f17mr2029180d50.82.1765053059027;
        Sat, 06 Dec 2025 12:30:59 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with UTF8SMTPSA id 00721157ae682-78c1b790577sm30347447b3.47.2025.12.06.12.30.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Dec 2025 12:30:58 -0800 (PST)
Date: Sat, 6 Dec 2025 15:30:57 -0500
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Elijah Newren <newren@gmail.com>, Jeff King <peff@peff.net>,
	Junio C Hamano <gitster@pobox.com>, Patrick Steinhardt <ps@pks.im>
Subject: [PATCH 00/17] midx: incremental MIDX/bitmap layer compaction
Message-ID: <cover.1765053054.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

Note to the maintainer:

 * This series is the spiritual successor to my earlier series queued
   as 'tb/incremental-midx-part-3.1', but is based on 'master'
   (currently f0ef5b6d9bc (The fifth batch, 2025-11-30) at the time of
   writing). I suggest queueing as 'tb/incremental-midx-part-3.2'.

OVERVIEW
========

This series implements the second of three major components for an
incremental MIDX/bitmap-based repacking strategy. Those components
are:

 1. Refactoring code out of builtin/repack.c into individual
    compilation units outside of the builtin directory.

 2. (this series) Implementing MIDX layer compaction, i.e. the ability
    to take an contiguous sequence of MIDX layers in an existing MIDX
    chain and replace them with a single layer representing the union
    of objects/packs among the compacted layers.

 3. An incremental repacking strategy that, unlike our current
    '--geometric' approach, does not require periodic all-into-one
    repacks.

BACKGROUND
==========

I'll briefly discuss that repacking strategy here in order to provide
some context on why MIDX layer compaction is important. When doing a
--geometric repack today, any update to the MIDX and/or its .bitmap
requires a full rewrite. For most repositories this is not such a big
deal, but in large monorepos these costs can add up significantly over
time.

To deal with this, incremental MIDXs (and corresponding support for
reachability bitmaps) were introduced as a way to append updates to
the end of a MIDX chain without having to rewrite anything.

Of course, growing a MIDX chain infinitely without ever shrinking it
would be pointless. So any repacking strategy which leverages
incremental MIDXs must take some action which encourages the MIDX
chain to avoid growing too large.

The strategy that I will share in the forthcoming topic related to
this effort does (roughly) the following:

 1. Repack all non-MIDX'd packs geometrically, optionally including
    any packs in the most recent MIDX layer iff it has more than some
    threshold of packs.

 2. Write out a new MIDX layer which is the result of the previous
    step, adding it onto the end of the chain (or replacing the
    previous end, depending on whether the pack threshold condition
    was met).

 3. Perform a compaction pass, combining adjacent MIDX layers to
    restore a geometric progression on object count among MIDX layers
    in the chain.

(As an aside, this description is not the most efficient way to
implement this behavior, and so the actual implementation varies
slightly, though achieves the same effect.)

This strategy encourages MIDX chains where older layers have fewer,
larger packs, and newer layers have a greater number of smaller packs.
The compaction pass prevents the MIDX chain from ever growing too
large. (In my simulation[1], even a large number of simulated pushes
yields a MIDX chain which is consistently fewer than ~10 or so layers
long.)

COMPACTION
==========

MIDX compaction works by producing a new MIDX layer which is the
logical union of any contiguous sequence within the existing MIDX
chain. Importantly, the packs/objects from those layers within the
compaction range have their order preserved. That means that the
pseudo-pack order of the compacted layer is guaranteed to be the same
as the concatenated pseudo-pack order across all layers in the
compaction range.

As a result, we can reuse any selected bitmaps within the compaction
range verbatim. More importantly, any bitmaps belonging to layers
which are descendants of the compacted one do not need to permute any
existing bitmaps in order for them to be valid post-compaction.

This allows us to cheaply combine parts of the MIDX chain without
needing to do any work outside of the combine layers, which is
essential in the above-described repacking strategy.

THIS SERIES
===========

This series implements MIDX compaction, and is organized roughly as
follows:

 * The first two patches are stray code clean-up and minor refactoring
   changes that I made while writing this series.

 * The next three patches clean up the SYNOPSIS for in the manual page
   for git-multi-pack-index(1), and removes the builtin from the list
   of known failures in t0450.

 * The next patch is a typofix, and the one following that is a
   preemptive bugfix.

 * The eighth patch is a code refactoring patch that makes the
   argument list for midx-write.c::write_midx_internal() easier to
   reason about.

 * The ninth patch relaxes a MIDX constraint that forces all packs
   within a layer to be sorted lexicographically.

 * The remaining patches prepare for and introduce MIDX compaction.

The test coverage in the new t5335-compact-multi-pack-index.sh is
fairly sparse in my opinion, though most of the interesting behavior
is already exercised via t5319 and t5334. If others have ideas on how
to improve test coverage here, please let me know!

This series is somewhat lengthy, though the individual changes are
relatively small for the most part, so I am hoping that they aren't
too bad to review.

Thanks in advance for your review!

[1]: https://gist.github.com/ttaylorr/7ac0305f130197744f3583096c8198a1

Taylor Blau (17):
  midx: mark `get_midx_checksum()` arguments as const
  midx: split `get_midx_checksum()` by adding `get_midx_hash()`
  builtin/multi-pack-index.c: make '--progress' a common option
  git-multi-pack-index(1): remove non-existent incompatibility
  git-multi-pack-index(1): align SYNOPSIS with 'git multi-pack-index -h'
  t/t5319-multi-pack-index.sh: fix copy-and-paste error in t5319.39
  midx-write.c: don't use `pack_perm` when assigning `bitmap_pos`
  midx-write.c: introduce `struct write_midx_opts`
  midx: do not require packs to be sorted in lexicographic order
  git-compat-util.h: introduce `u32_add()`
  midx-write.c: introduce `midx_pack_perm()` helper
  midx-write.c: extract `fill_pack_from_midx()`
  midx-write.c: enumerate `pack_int_id` values directly
  midx-write.c: factor fanout layering from `compute_sorted_entries()`
  t/helper/test-read-midx.c: plug memory leak when selecting layer
  midx: implement MIDX compaction
  midx: enable reachability bitmaps during MIDX compaction

 Documentation/git-multi-pack-index.adoc |  24 +-
 builtin/multi-pack-index.c              |  84 ++++-
 git-compat-util.h                       |   8 +
 midx-write.c                            | 463 ++++++++++++++++++------
 midx.c                                  |  36 +-
 midx.h                                  |   9 +-
 pack-bitmap.c                           |   9 +-
 pack-revindex.c                         |   4 +-
 t/helper/test-read-midx.c               |  21 +-
 t/meson.build                           |   1 +
 t/t0450/adoc-help-mismatches            |   1 -
 t/t5319-multi-pack-index.sh             |   7 +-
 t/t5335-compact-multi-pack-index.sh     | 218 +++++++++++
 13 files changed, 737 insertions(+), 148 deletions(-)
 create mode 100755 t/t5335-compact-multi-pack-index.sh


base-commit: f0ef5b6d9bcc258e4cbef93839d1b7465d5212b9
-- 
2.52.0.171.gd6a4e6b6955
