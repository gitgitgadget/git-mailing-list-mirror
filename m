Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9E7019D07D
	for <git@vger.kernel.org>; Wed,  2 Oct 2024 10:55:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727866530; cv=none; b=iHcBlKkcIlgeTcReKW/Amb+m1ARDrzXlIonyR/WtfnFqoCDXEwpHKQL5PDO/uR9LtLdoX/LC1LpEflkY4LgEP4MQN+UwFofs6Gp3ZXXxeQQzg53ROYAuDC3RPUNGdKaioc3Pgr9kVqhKKuFboUXhfj/lse1pfwe61jFzSXMjxfk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727866530; c=relaxed/simple;
	bh=xp40fqVsx1QClLUUaIp9CmE3cTxLCbJGsJ+7tgo4U0k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Tpr4KB/Uiy53GFaHiYAI0P7t2YEPpGleFQ+ECceIxvGRGg7khdhmfJTPLkffWWJXmo9rkGAotIAq5lqGwS/v61NFyvrb1pXij1zbDRJq/+hInwoAJEaERpMt9HVEqTV5Y7eOQpOsSq8LgiL+DdWPdNFfZLPm87sxz7nEzSwv4QY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=e0+/rWna; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=NFR7koSa; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="e0+/rWna";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="NFR7koSa"
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfout.phl.internal (Postfix) with ESMTP id D06EF13805F8;
	Wed,  2 Oct 2024 06:55:27 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Wed, 02 Oct 2024 06:55:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1727866527; x=1727952927; bh=9471dLFGnx
	uLo8pEW1jROJ78aKCjuHusEtNVBnZqV+I=; b=e0+/rWnaUwkTxM17tbfu5eBVy4
	7Y5D4/wzGkx3dAJFkzhawRSs5j9B6Ma+tqXzQmI17uYA8cii4wwPObibdsXz7f3K
	QrvvyVDwV9QjiPFNwnXaJzTws7ryKAB7RX/qP9fYHMM1h+D0oUfiBlnhnfhIy/IM
	TZu5qKSoW21mvTBD4kqTOoSk/rRyQLkJp+YZFW8N3CCo1ZNz7P4lMXiUwwbL5zeU
	Hpf56wpMSiPV+hKOy6Ogtct0zmTu4HsTGR1q0IwR6+TPtFblOX508qUmN0LO3Yzy
	9q/Lt5pH3Lhx53edqmPz9jKY7+cgXyUe7S9EynPsdnlhAQfegzeI3VEyiGrA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1727866527; x=1727952927; bh=9471dLFGnxuLo8pEW1jROJ78aKCj
	uHusEtNVBnZqV+I=; b=NFR7koSa6C+6ZIVH+iELMq3E8k1Dn/nK2bRs5WGPNpSa
	F+1jpfXIob607Hxg8znp1bLAeeln0DmcyE8TteJhNiQXxfimT1weJ5YYvjQaM6X1
	ZyiQ+flaNGjOOdEdK1fUBpVAwnlbyIhhsbJ9ugpgYuQ+NMpNRE2G/RgKiZ+eqAzb
	b/cwDiFFHAHYiLlSCHEjJpCqFKexacuX0fjJf6mQeAs7iCO3cXvS2ZH9BJ9xHIoX
	vGFk3UdwysIl/L2YGyWGcHaJupXAMn2ozCTm/gtRLPRYbsN9nd9o2Zogd5+KdLHh
	K4yhLSz0DQjdng7UnwvYARz0wWBQU4L/ciRT3ZSbVw==
X-ME-Sender: <xms:nyb9ZlkT1D29hnVbm2lHpHvNwYRBpeMnF3EpYxDSsr2IOuQ6q3t0Wg>
    <xme:nyb9Zg1PsCiXW0owLSTCsLHMszSIqJrYafsrZZBvwMpvB1JLG90SciW_YOVqkKq-m
    QLSrFVJtPMN_Rwv-A>
X-ME-Received: <xmr:nyb9Zrquc9fOz2ePUtS9CElCioJdRk-JDZBDC3W3XMMAe4NW_0we9QW0GpPb6cHRuEMjapLNNaBSczTR6yo8314OAH63qL--5C1nlLgr1Kh6luqx>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdduledgfedtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefgueeg
    udfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepgedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepvghthhhomhhsohhnsegvugifrghrughthhhomhhsoh
    hnrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgt
    phhtthhopehlrdhsrdhrseifvggsrdguvgdprhgtphhtthhopehgihhtshhtvghrsehpoh
    gsohigrdgtohhm
X-ME-Proxy: <xmx:nyb9Zlntl0_l0EQqpP0DOUo-DlbCJLUwiBakVm8iziddWPigoUwong>
    <xmx:nyb9Zj3JPZs0pHBTuKn69CeW9SwQEWirjbYx1CeCQZ6MvEX5mQLrSw>
    <xmx:nyb9ZksZPoeqvptg1HaEtGc9vcLRUsaZquaJlWriN8GQfcGsN-kv1A>
    <xmx:nyb9ZnW46y3aZT8A-Ado5tVtKzWRGfxoLVxSCroBMfl8-X8vAI4tBA>
    <xmx:nyb9ZuQAzvts8BSRnvplWC6_5rK_rSn8eaGrdy00BCs7qblfqLHCOHyw>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 2 Oct 2024 06:55:26 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 1a9f0e53 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 2 Oct 2024 10:54:34 +0000 (UTC)
Date: Wed, 2 Oct 2024 12:55:22 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Edward Thomson <ethomson@edwardthomson.com>,
	Junio C Hamano <gitster@pobox.com>,
	=?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Subject: [PATCH v5 00/25] reftable: handle allocation errors
Message-ID: <cover.1727866394.git.ps@pks.im>
References: <cover.1726489647.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1726489647.git.ps@pks.im>

Hi,

this is the fifth version of this patch series that converts the
reftable library to start handling allocation errors. This is done such
that the reftable library can truly behave like a library and let its
callers handle such conditions.

Changes compared to v4:

  - `#undef` standard allocators before banning them.

  - Explain why we don't ban `FREE_AND_NULL()` and related as well as
    `xmalloc()` and related.

Thanks!

Patrick

Patrick Steinhardt (25):
  reftable/error: introduce out-of-memory error code
  reftable/basics: merge "publicbasics" into "basics"
  reftable: introduce `reftable_strdup()`
  reftable/basics: handle allocation failures in `reftable_calloc()`
  reftable/basics: handle allocation failures in `parse_names()`
  reftable/record: handle allocation failures on copy
  reftable/record: handle allocation failures when decoding records
  reftable/writer: handle allocation failures in `writer_index_hash()`
  reftable/writer: handle allocation failures in `reftable_new_writer()`
  reftable/merged: handle allocation failures in
    `merged_table_init_iter()`
  reftable/reader: handle allocation failures for unindexed reader
  reftable/reader: handle allocation failures in `reader_init_iter()`
  reftable/stack: handle allocation failures on reload
  reftable/stack: handle allocation failures in `reftable_new_stack()`
  reftable/stack: handle allocation failures in `stack_compact_range()`
  reftable/stack: handle allocation failures in auto compaction
  reftable/iter: handle allocation failures when creating indexed table
    iter
  reftable/blocksource: handle allocation failures
  reftable/block: handle allocation failures
  reftable/pq: handle allocation failures when adding entries
  reftable/tree: handle allocation failures
  reftable: handle trivial allocation failures
  reftable: fix calls to free(3P)
  reftable: introduce `REFTABLE_FREE_AND_NULL()`
  reftable/basics: ban standard allocator functions

 Makefile                            |   1 -
 refs/reftable-backend.c             |  39 ++++--
 reftable/basics.c                   |  93 +++++++++++++-
 reftable/basics.h                   |  28 ++++-
 reftable/block.c                    |  29 ++++-
 reftable/block.h                    |   4 +-
 reftable/blocksource.c              |  25 +++-
 reftable/error.c                    |   2 +
 reftable/iter.c                     |  22 +++-
 reftable/iter.h                     |   2 +-
 reftable/merged.c                   |  84 ++++++++-----
 reftable/merged.h                   |   6 +-
 reftable/pq.c                       |   9 +-
 reftable/pq.h                       |   2 +-
 reftable/publicbasics.c             |  66 ----------
 reftable/reader.c                   |  70 ++++++++---
 reftable/reader.h                   |   6 +-
 reftable/record.c                   | 174 +++++++++++++++++++-------
 reftable/record.h                   |   6 +-
 reftable/reftable-basics.h          |  18 +++
 reftable/reftable-error.h           |   3 +
 reftable/reftable-malloc.h          |  18 ---
 reftable/reftable-merged.h          |   8 +-
 reftable/reftable-reader.h          |   8 +-
 reftable/reftable-stack.h           |   8 +-
 reftable/reftable-writer.h          |  12 +-
 reftable/stack.c                    | 187 +++++++++++++++++++++-------
 reftable/tree.c                     |  42 +++++--
 reftable/tree.h                     |  21 +++-
 reftable/writer.c                   | 154 +++++++++++++++--------
 t/helper/test-reftable.c            |  10 +-
 t/unit-tests/lib-reftable.c         |   8 +-
 t/unit-tests/t-reftable-basics.c    |  11 +-
 t/unit-tests/t-reftable-block.c     |  24 ++--
 t/unit-tests/t-reftable-merged.c    |  16 ++-
 t/unit-tests/t-reftable-readwrite.c |  65 ++++++----
 t/unit-tests/t-reftable-stack.c     |   6 +-
 t/unit-tests/t-reftable-tree.c      |  10 +-
 38 files changed, 890 insertions(+), 407 deletions(-)
 delete mode 100644 reftable/publicbasics.c
 create mode 100644 reftable/reftable-basics.h
 delete mode 100644 reftable/reftable-malloc.h

Range-diff against v4:
 1:  94eaef3ae5 =  1:  94eaef3ae5 reftable/error: introduce out-of-memory error code
 2:  fe55051cb7 =  2:  fe55051cb7 reftable/basics: merge "publicbasics" into "basics"
 3:  b1a10d41d3 =  3:  b1a10d41d3 reftable: introduce `reftable_strdup()`
 4:  fd9141e985 =  4:  fd9141e985 reftable/basics: handle allocation failures in `reftable_calloc()`
 5:  bdfddbebce =  5:  bdfddbebce reftable/basics: handle allocation failures in `parse_names()`
 6:  756a32c285 =  6:  756a32c285 reftable/record: handle allocation failures on copy
 7:  ca64971e7b =  7:  ca64971e7b reftable/record: handle allocation failures when decoding records
 8:  fc2f113cba =  8:  fc2f113cba reftable/writer: handle allocation failures in `writer_index_hash()`
 9:  0ed99e0bdf =  9:  0ed99e0bdf reftable/writer: handle allocation failures in `reftable_new_writer()`
10:  8dfbfd9286 = 10:  8dfbfd9286 reftable/merged: handle allocation failures in `merged_table_init_iter()`
11:  7b592a6c6b = 11:  7b592a6c6b reftable/reader: handle allocation failures for unindexed reader
12:  ceed838265 = 12:  ceed838265 reftable/reader: handle allocation failures in `reader_init_iter()`
13:  1e997a5766 = 13:  1e997a5766 reftable/stack: handle allocation failures on reload
14:  40d4d81378 = 14:  40d4d81378 reftable/stack: handle allocation failures in `reftable_new_stack()`
15:  6aaae4baa6 = 15:  6aaae4baa6 reftable/stack: handle allocation failures in `stack_compact_range()`
16:  103a59ef0a = 16:  103a59ef0a reftable/stack: handle allocation failures in auto compaction
17:  6799d299fe = 17:  6799d299fe reftable/iter: handle allocation failures when creating indexed table iter
18:  c7e54d71d7 = 18:  c7e54d71d7 reftable/blocksource: handle allocation failures
19:  92d39b9021 = 19:  92d39b9021 reftable/block: handle allocation failures
20:  3416004e0d = 20:  3416004e0d reftable/pq: handle allocation failures when adding entries
21:  a363930488 = 21:  a363930488 reftable/tree: handle allocation failures
22:  28661500ff = 22:  28661500ff reftable: handle trivial allocation failures
23:  228cc81263 = 23:  228cc81263 reftable: fix calls to free(3P)
24:  1c66f6ef8d = 24:  1c66f6ef8d reftable: introduce `REFTABLE_FREE_AND_NULL()`
25:  764961e6f0 ! 25:  bc80f1e726 reftable/basics: ban standard allocator functions
    @@ Commit message
         Introduce a couple of macros that ban the standard allocators, similar
         to how we do it in "banned.h".
     
    +    Note that we do not ban the following two classes of functions:
    +
    +      - Macros like `FREE_AND_NULL()` or `REALLOC_ARRAY()`. As those expand
    +        to code that contains already-banned functions we'd get a compiler
    +        error even without banning those macros explicitly.
    +
    +      - Git-specific allocators like `xmalloc()` and friends. The primary
    +        reason is that there are simply too many of them, so we're rather
    +        aiming for best effort here. Furthermore, the eventual goal is to
    +        make them unavailable in the reftable library place by not pulling
    +        them in via "git-compat-utils.h" anymore.
    +
         Signed-off-by: Patrick Steinhardt <ps@pks.im>
     
      ## reftable/basics.c ##
    @@ reftable/basics.h: char *reftable_strdup(const char *str);
      
     +#ifndef REFTABLE_ALLOW_BANNED_ALLOCATORS
     +# define REFTABLE_BANNED(func) use_reftable_##func##_instead
    ++# undef malloc
     +# define malloc(sz) REFTABLE_BANNED(malloc)
    ++# undef realloc
     +# define realloc(ptr, sz) REFTABLE_BANNED(realloc)
    ++# undef free
     +# define free(ptr) REFTABLE_BANNED(free)
    ++# undef calloc
     +# define calloc(nelem, elsize) REFTABLE_BANNED(calloc)
    ++# undef strdup
     +# define strdup(str) REFTABLE_BANNED(strdup)
     +#endif
     +
-- 
2.47.0.rc0.dirty

