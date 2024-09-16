Received: from fout6-smtp.messagingengine.com (fout6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E15C14F9D5
	for <git@vger.kernel.org>; Mon, 16 Sep 2024 12:28:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726489702; cv=none; b=Q0Jne/96UotwTekjTmatZKO/NeouRRmgoAKT4sgBt379ABHw9Y/72ElKhCndMwDnSMakc2kccrR2VieIm4rPupY4xdcRSEpqungYKG3ljstuz19KkszKGyvzgAHQGKXYTTLcQz9mPWDq+V4mW2YjJiYFXIM1ll0G+C9DT6FyIW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726489702; c=relaxed/simple;
	bh=iM+Sl8BVNyJWVXLNmLeAV7olR/MYgUpOeQhwpqrPAM4=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=kb+JzLq8zk6K8o9ufYDrLDIqvknBo/d2FbndFr7e6pSKVyML3VZcTh7Ks0cTSlfXTctY/RNbvFqCJ9rgferZB9/VYJeB9Sz/88W+U4FarxqIAPOR0qEdrpPRXHH0ZFBP6nAau3oT6fdD2Fliw3psaG9MnQYBKi9Ejw/aVOVKVIw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=VrtRsNN8; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=MWplDEgZ; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="VrtRsNN8";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="MWplDEgZ"
Received: from phl-compute-02.internal (phl-compute-02.phl.internal [10.202.2.42])
	by mailfout.phl.internal (Postfix) with ESMTP id 903EC13801E8;
	Mon, 16 Sep 2024 08:28:19 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Mon, 16 Sep 2024 08:28:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:message-id:mime-version:reply-to:subject:subject:to:to; s=fm1;
	 t=1726489699; x=1726576099; bh=jBbApbwkoEQNUa6t0IoemJu+4FnFL6sx
	VBCiJC9LvkM=; b=VrtRsNN8Yi1Q90ZZ/sMUSnZ2SHHIBzuCEfhJwZFasjZ6+H3l
	fmuAnLaChv+eTHH2iicFmok+Ufbe+F+NHQKgG1CQd7sqYTXlnqSwa7z7InQvW81h
	TPdsvqwQEYg+nnQAzreukSd7XaP96fUO392QPlI6jSZk5+QsPodNxSRlXMaVDQzL
	CzZT3JM5vQCdOuERAqwUCqn0vNn4oS7MC7b/F6szeHZoXj2yeJQpNAZWF6wwgaum
	gIXL2A8Ku6bD9Nf7OABKNvQqE5M5oGkMC1K50bj/Y92C0mfgyc0zY2TBxBnQbegS
	8VR41TwwyY5e5BtyBZHL5mHTj0AVmUj8wfTnyw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:message-id
	:mime-version:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1726489699; x=1726576099; bh=jBbApbwkoEQNUa6t0IoemJu+4FnFL6sxVBC
	iJC9LvkM=; b=MWplDEgZkc9gqRuOIPkU69D7XDMmyxB39TFAUsdXeoIWUDikeoi
	+nXwyt5RDj4k+DRp2eBPpgm6XXRH2XYLzVpi3tx8F3Za0en42fGffUKhZmlvbozs
	aJ1tWpm/YL/rB7y1ycSPIxKIjqS1w6x927vguyl/yR3FKgSL+x4Kzrdt2HghSZMC
	7Y8bP9xHyvcubkE5dv2v1fpNyxcrWlx0H0RftPL1UxLOjpbsxCuw/YVHrT3+hHKV
	TFY6IoJwBHpX8TrNsJqg3RtiQHVNa/VGSxf7KSrUhDbVHjcR4+x1Sw0zNWk76zPP
	LTGn6Q4Jay3kKTG/zVPVt5EAntwUAvMW8vg==
X-ME-Sender: <xms:YyToZu4ju1U51g800ncQaLGiTJjfkaRLHuwH-dOtHeJeqGMLgVKitw>
    <xme:YyToZn48VG4Qe-vH2IkdV8eCGtQAx_lJrkj8x02a0-gYAAbLSZpjFYTnrPmBWq7Iz
    DTV7AqigI7_t1Lc0Q>
X-ME-Received: <xmr:YyToZtdNv6dt4fBfmMyg_ldwI3S3H1TQYwMCxyfOR1Kz5lShOtWJX-NVnxXOVT5OpfjRUgBVz2r2wxN4VA90PU0vjG7Fw-9zdjm_rqi39t07c8TH>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrudekhedgheduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkgggtugesthdtredttddtvdenucfh
    rhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqne
    cuggftrfgrthhtvghrnhepieeuvdfhteetlefghfehtddvheelhfdtfffhhffgleejfedv
    teefveeltdeuiedvnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilh
    hfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepvddpmhhouggvpehsmhht
    phhouhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtph
    htthhopegvthhhohhmshhonhesvggufigrrhguthhhohhmshhonhdrtghomh
X-ME-Proxy: <xmx:YyToZrK6esUB5Q7SugbTzzJZJqsquelFjrPVWmCXWuB-vGMv-h-rUQ>
    <xmx:YyToZiIuWQ1U5isiju3Xeo0qlyYcJ6pSAuTIrSqGEwG_eqGPH6lbQw>
    <xmx:YyToZszMqVJcI6qo2uO0vRnImjpcNryXvrzfwuGLACmDtySf8qqe3A>
    <xmx:YyToZmIM-eZj2a4_P9EcdiJfOcljSIEBTegPg6ARbrehWyw7EsJrYQ>
    <xmx:YyToZpUd26FAoQjVsPerEqNjySvL7VebBmoeBPEGvpYhAlLPDUxliYtG>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 16 Sep 2024 08:28:18 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id b45f1cf4 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 16 Sep 2024 12:27:59 +0000 (UTC)
Date: Mon, 16 Sep 2024 14:28:15 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Edward Thomson <ethomson@edwardthomson.com>
Subject: [PATCH 00/22] reftable: handle allocation errors
Message-ID: <cover.1726489647.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

the reftable library provides pluggable allocators that can be switched
out via `reftable_set_alloc()`. These pluggable allocators are not
expected to behave like `xmalloc()` and friends -- in other words, they
are allowed to fail. This is done such that the reftable library can
truly behave like a library and let its callers handle such conditions.

It has been true since the inception of the reftable library that
allocations may fail. But regardless of that we do not have any error
handling for this scenario at all. Consequently, we can easily cause a
segfault when running into an out-of-memory situation.

While the easy solution would be to plug in `xmalloc()` and friends such
that we abort on these cases, that would contradict the very notion of
what this library should be. Most importantly, I want to soonish revive
the effort to implement a reftable backend in libgit2, and thus I have
to make sure that the reftable library (of which we are the canonical
upstream now) can be used in such contexts.

This patch series here is the first one in a set of series that will
detangle the reftable library from the rest of the Git codebase again so
that it becomes a true standalone library that other projects can use.

The series is based on top of ed155187b4 (Sync with Git 2.46.1,
2024-09-13) with the following two depedencies merged into it to avoid
conflicts:

  - cp/unit-test-reftable-stack at 2b14ced370 (t-reftable-stack: add
    test for stack iterators, 2024-09-08).

  - ps/reftable-exclude at adf7a0ceef (refs/reftable: wire up support
    for exclude patterns, 2024-09-09).

Thanks!

Patrick

Patrick Steinhardt (22):
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

 Makefile                            |   1 -
 refs/reftable-backend.c             |  39 ++++--
 reftable/basics.c                   |  87 +++++++++++++-
 reftable/basics.h                   |  13 +-
 reftable/block.c                    |  23 +++-
 reftable/block.h                    |   4 +-
 reftable/blocksource.c              |  25 +++-
 reftable/error.c                    |   2 +
 reftable/iter.c                     |  22 +++-
 reftable/iter.h                     |   2 +-
 reftable/merged.c                   |  84 ++++++++-----
 reftable/merged.h                   |   6 +-
 reftable/pq.c                       |   7 +-
 reftable/pq.h                       |   2 +-
 reftable/publicbasics.c             |  66 -----------
 reftable/reader.c                   |  68 ++++++++---
 reftable/reader.h                   |   6 +-
 reftable/record.c                   | 164 +++++++++++++++++++-------
 reftable/record.h                   |   6 +-
 reftable/reftable-basics.h          |  18 +++
 reftable/reftable-error.h           |   3 +
 reftable/reftable-malloc.h          |  18 ---
 reftable/reftable-merged.h          |   8 +-
 reftable/reftable-reader.h          |   8 +-
 reftable/reftable-stack.h           |   8 +-
 reftable/reftable-writer.h          |  12 +-
 reftable/stack.c                    | 177 ++++++++++++++++++++++------
 reftable/tree.c                     |  42 +++++--
 reftable/tree.h                     |  21 +++-
 reftable/writer.c                   | 150 +++++++++++++++--------
 t/helper/test-reftable.c            |  10 +-
 t/unit-tests/lib-reftable.c         |   8 +-
 t/unit-tests/t-reftable-basics.c    |  11 +-
 t/unit-tests/t-reftable-block.c     |  24 ++--
 t/unit-tests/t-reftable-merged.c    |  16 ++-
 t/unit-tests/t-reftable-readwrite.c |  61 ++++++----
 t/unit-tests/t-reftable-stack.c     |   4 +-
 t/unit-tests/t-reftable-tree.c      |  10 +-
 38 files changed, 848 insertions(+), 388 deletions(-)
 delete mode 100644 reftable/publicbasics.c
 create mode 100644 reftable/reftable-basics.h
 delete mode 100644 reftable/reftable-malloc.h


base-commit: 1755182f5a2e12ff27c230f34f0040a8afee58e4
-- 
2.46.0.551.gc5ee8f2d1c.dirty

