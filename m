Received: from fhigh-b4-smtp.messagingengine.com (fhigh-b4-smtp.messagingengine.com [202.12.124.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C1981ACED3
	for <git@vger.kernel.org>; Thu, 16 Jan 2025 09:17:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737019046; cv=none; b=MOB1W/gkR2E7ACHoyBOteJF9a+LO9inoZe30WmgbQn1aFdFJ6N6cupV63/w4Zm3z9xmdQoG3/ndTCQ4zeZcoXokGmBhL8YGU6tidpbXhhpykJzjdCNrGAF/0AgeHs0aRMx/Yv+cSYgD/gtnXOqK0BuXHX5/T6ZMHfEy+EnoIc8A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737019046; c=relaxed/simple;
	bh=nM+05c/8sPuXpDZs/5aCHjJEbCm7cdMbXVWBqZGEQRM=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 In-Reply-To:References:To:Cc; b=CnY2FByOa1dVqIMJB0d72NPR67zSjDITtlYqaB+S7Hpx62vnqMLCmK3yfelvYdE7asNfuI+At69x/nmBVyPZ8PgFLnLF0Uc3lUg4KsaVP8t1apLTn2RFZjfYft9W1Kzx5/n3tHGkHKiG5+fVJDfHUBlpKpGHcCy7Q3XsBkvzj1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=sVAqIshM; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=UInZm7UR; arc=none smtp.client-ip=202.12.124.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="sVAqIshM";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="UInZm7UR"
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 660DC2540170;
	Thu, 16 Jan 2025 04:17:23 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Thu, 16 Jan 2025 04:17:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1737019043;
	 x=1737105443; bh=tkwysOKFQqsmB2tPz0v6f6qY2fBMGfxo+lTdvVfDne8=; b=
	sVAqIshMM9h8aYQAB6ZZjY/5nPj0RgAWSF92TbB2PjyXERF+255eQ7ckFnmicIhz
	Rv5JrY+qItr1peDNG5LZyFUV5jicv/oP/coQ1HPmR44dMGR8n3hH9eE4gWB/BGPD
	uzCH/V4nr4ag2V75NqVWNe9tGnorRjCoSbwQkupzQUYe3f582XXUx4OcRPQd/mrL
	HCD9zlgTUOR9XgnIxnbetWRYoIpRWQwYyjv8kwrQvf5BRKv1dP1HfCPAW/EibCVV
	cya8lHzFdkfi8xXvEQhNkybPP1LHZFLATesbMLevSpdn1YqCL7T7xEA5gVePfW4w
	XNUUV2IstF2j40Pdpv1d+g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1737019043; x=
	1737105443; bh=tkwysOKFQqsmB2tPz0v6f6qY2fBMGfxo+lTdvVfDne8=; b=U
	InZm7URA/9S3jA4OXjJ2cbP+wo/tQu4r5IxvmEdMtTZQwxabqyYLQ8kEQJYK4vwD
	oQSFUiINEQf+PvUy4PfNuN2BgQPQqWhtGERDEif2HLYdl6Pyahk+LPiTJ/cl7y7O
	CaMenCK8b2H+nwzA7P9BdYCO5O8oNBIXJyVtAV9XVCwMhxarAw1U/apSCB/wuZrP
	qsOxLABZUXOkPZuyQ1isjaBqMmRveCrHCCNgXtuo0T143AVae2wn7Z63aYc3E+Oj
	KJuA2w1ptnOOaqK8RKMwJ+V8871a/hSNBKnvfttAIVOmFzOELx2/zktQT3W3Qnjx
	OZiddyKq7d86GojR21p9g==
X-ME-Sender: <xms:os6IZ6_e6qTYNiJWSeF6bHq04LOrt8RcbmwoutZ1OxBdAWI8J-WJZw>
    <xme:os6IZ6smXI8GY9zGVm4xi2TTo27t8kG1sfk4Esv4wSpkVMVBjgM62RyHZ03TBPRMw
    Yz1z_1-wGJ_YcxIKg>
X-ME-Received: <xmr:os6IZwBx_rsrqBerAMq9ERjZMAD2FO1t5E-wdybFdravQrUfvGux5fIIw-fv2w8PX25rRnhjSyIus1v0S_WhKZHdOOjWiBN28VhEa4veKRAT7Zkopg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudeiuddgtdduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhephffufffkgggtgfgjfhfvvefosehtkeertdertdej
    necuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrih
    hmqeenucggtffrrghtthgvrhhnpeduudevjeffffegjeegheeiteeuffdtvdehleegfeef
    vedtgeetlefhkeevtedtheenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluh
    hsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhi
    mhdpnhgspghrtghpthhtohepfedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepmh
    gvsehtthgrhihlohhrrhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhn
    vghlrdhorhhgpdhrtghpthhtohepkhgrrhhthhhikhdrudekkeesghhmrghilhdrtghomh
X-ME-Proxy: <xmx:o86IZyeJvxWJ7MyZkRs7BzUHOUc-MXnd3tVq-nANinuQV6JugEHiZQ>
    <xmx:o86IZ_Mz_tUIp_oekV9-zQRetb_XZZvj65rNFwKpLQci8xgO2QisOw>
    <xmx:o86IZ8kM0571aMwmCGYII7H2OJ_UQNlRHLSjG421oqU-HZj2gLsiBg>
    <xmx:o86IZxuZQsef5RcWoLvLro89aAwnJ_RL3GAaSDoJ2Ab4BuVUJOnGOQ>
    <xmx:o86IZ4ri2iNX6-RSSwtOXuduNYw1vWfCaVoNrl8PO7zdOloQbcoMNH_u>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 16 Jan 2025 04:17:22 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 920457c8 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 16 Jan 2025 09:17:19 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Subject: [PATCH v3 00/10] compat/zlib: allow use of zlib-ng as backend
Date: Thu, 16 Jan 2025 10:17:13 +0100
Message-Id: <20250116-b4-pks-compat-drop-uncompress2-v3-0-f2af1f5c4a06@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAJnOiGcC/43NQQ6CMBCF4auQrh3TGVoVV97DuCh0lMZASYuNh
 nB3CwvjTpf/y+SbSUQOjqM4FpMInFx0vs9RbgrRtKa/MTibW5AkLREl1AqGe4TGd4MZwQY/wKN
 fKnCMBFzrCpXSVVOSyEier+65Pjhfcrcujj681n8Jl/VvOiFIqHbaSklk9sqe8vXWdWJxE31b6
 qdF2dqhMoT6wKXijzXP8xuAJwcnFQEAAA==
X-Change-ID: 20250110-b4-pks-compat-drop-uncompress2-eb5914459c32
In-Reply-To: <20250110-b4-pks-compat-drop-uncompress2-v1-0-965d0022a74d@pks.im>
References: <20250110-b4-pks-compat-drop-uncompress2-v1-0-965d0022a74d@pks.im>
To: git@vger.kernel.org
Cc: Taylor Blau <me@ttaylorr.com>, Karthik Nayak <karthik.188@gmail.com>
X-Mailer: b4 0.14.2

Hi,

I have recently started to play around with zlib-ng a bit, which is a
hard fork of the zlib library. It describes itself as zlib replacement
with optimizations for "next generation" systems. As such, it contains
several implementations of central algorithms using for example SSE2,
AVX2 and other vectorized CPU intrinsics that supposedly speed up in-
and deflating data.

And indeed, compiling Git against zlib-ng leads to a significant speedup
when reading objects. The following benchmark uses git-cat-file(1) with
`--batch --batch-all-objects` in the Git repository:

    Benchmark 1: zlib
      Time (mean ± σ):     52.085 s ±  0.141 s    [User: 51.500 s, System: 0.456 s]
      Range (min … max):   52.004 s … 52.335 s    5 runs

    Benchmark 2: zlib-ng
      Time (mean ± σ):     40.324 s ±  0.134 s    [User: 39.731 s, System: 0.490 s]
      Range (min … max):   40.135 s … 40.484 s    5 runs

    Summary
      zlib-ng ran
        1.29 ± 0.01 times faster than zlib

So we're looking at a ~25% speedup compared to zlib. This is of course
an extreme example, as it makes us read through all objects in the
repository. But regardless, it should be possible to see some sort of
speedup in most commands that end up accessing the object database.

This patch series refactors how we wire up zlib in our project by
introducing a new "compat/zlib.h" header function. This header is then
later extended to patch over the differences between zlib and zlib-ng,
which is mostly just that zlib-ng has a `zng_` prefix for each of its
symbols. Like this, we can support both libraries directly, and a new
Meson build options allows users to pick whichever backend they like.

In theory, these changes shouldn't be necessary because zlib-ng provides
a compatibility layer that make it directly compatible with zlib. But
most distros don't allow you to install zlib-ng with that layer is it
would mean that zlib would need to be replaced globally. Instead, they
typically only provide a version of zlib-ng that only has the `zng_`
prefixed symbols.

Given the observed speedup I do think that this is a worthwhile change
so that users (or especially hosting providers) can easily switch to
zlib-ng without impacting the rest of their system.

Changes in v2:
  - Wire up zlib-ng in our Makefile.
  - Exercise zlib-ng via CI by adapting our "linux-musl" job to use
    Meson and installing zlib-ng.
  - Link to v1: https://lore.kernel.org/r/20250110-b4-pks-compat-drop-uncompress2-v1-0-965d0022a74d@pks.im

Changes in v3:
  - Fix a couple of commit message typos.
  - Mention why we can safely drop "CC=gcc" when converting the musl job
    to use Meson.
  - Link to v2: https://lore.kernel.org/r/20250114-b4-pks-compat-drop-uncompress2-v2-0-614a2158e34e@pks.im

I've adjusted the series to be based on top of fbe8d3079d (Git 2.48,
2025-01-10) with ps/meson-weak-sha1-build at 6a0ee54f9a (meson: provide
a summary of configured backends, 2024-12-30) and ps/build-meson-fixes
at 4e517e68b5 (ci: wire up Visual Studio build with Meson, 2025-01-14)
merged into it. This matches what Junio has in his tree -- sorry for
screwing up the previous base!

Thanks!

Patrick

---
Patrick Steinhardt (10):
      compat: drop `uncompress2()` compatibility shim
      git-compat-util: drop `z_const` define
      compat: introduce new "zlib.h" header
      git-compat-util: move include of "compat/zlib.h" into "git-zlib.h"
      compat/zlib: provide `deflateBound()` shim centrally
      compat/zlib: provide stubs for `deflateSetHeader()`
      git-zlib: cast away potential constness of `next_in` pointer
      compat/zlib: allow use of zlib-ng as backend
      ci: switch linux-musl to use Meson
      ci: make "linux-musl" job use zlib-ng

 .github/workflows/main.yml |  2 +-
 .gitlab-ci.yml             |  2 +-
 Makefile                   | 21 +++++++---
 archive-tar.c              |  4 --
 archive.c                  |  1 +
 ci/install-dependencies.sh |  4 +-
 ci/lib.sh                  |  5 +--
 ci/run-build-and-tests.sh  |  3 +-
 compat/zlib-compat.h       | 47 +++++++++++++++++++++++
 compat/zlib-uncompress2.c  | 96 ----------------------------------------------
 config.c                   |  1 +
 csum-file.c                |  3 +-
 environment.c              |  1 +
 git-compat-util.h          | 12 ------
 git-zlib.c                 |  6 +--
 git-zlib.h                 |  2 +
 meson.build                | 24 +++++++++---
 meson_options.txt          |  4 ++
 reftable/block.c           |  1 -
 reftable/system.h          |  1 +
 20 files changed, 100 insertions(+), 140 deletions(-)

Range-diff versus v2:

 1:  39a0bb02f4 =  1:  1d2035f387 compat: drop `uncompress2()` compatibility shim
 2:  e4783c2e8d =  2:  967bcabebc git-compat-util: drop `z_const` define
 3:  e222910808 =  3:  1b003953e0 compat: introduce new "zlib.h" header
 4:  0af5406642 =  4:  231f734fe6 git-compat-util: move include of "compat/zlib.h" into "git-zlib.h"
 5:  0092d57c16 =  5:  3cde8de583 compat/zlib: provide `deflateBound()` shim centrally
 6:  8e602b5e91 !  6:  5e20458b72 compat/zlib: provide stubs for `deflateSetHeader()`
    @@ Metadata
      ## Commit message ##
         compat/zlib: provide stubs for `deflateSetHeader()`
     
    -    The function `deflateSetHeader()` has been introduce with zlib v1.2.2.1,
    +    The function `deflateSetHeader()` has been introduced with zlib v1.2.2.1,
         so we don't use it when linking against an older version of it. Refactor
         the code to instead provide a central stub via "compat/zlib.h" so that
         we can adapt it based on whether or not we use zlib-ng in a subsequent
 7:  937688fcf5 !  7:  4de4631970 git-zlib: cast away potential constness of `next_in` pointer
    @@ Metadata
      ## Commit message ##
         git-zlib: cast away potential constness of `next_in` pointer
     
    -    The `struct git_zstream::next_in` variable points to the input data that
    -    and is used in combination with `struct z_stream::next_in`. While that
    +    The `struct git_zstream::next_in` variable points to the input data and
    +    is used in combination with `struct z_stream::next_in`. While that
         latter field is not marked as a constant in zlib, it is marked as such
         in zlib-ng. This causes a couple of compiler errors when we try to
         assign these fields to one another due to mismatching constness.
 8:  a721b846f7 =  8:  77f28f0f7d compat/zlib: allow use of zlib-ng as backend
 9:  45fde7a7dd !  9:  6fefd3ab44 ci: switch linux-musl to use Meson
    @@ Commit message
         is the `GIT_TEST_UTF8_LOCALE` variable used in tests. Wire up a build
         option for it, which we set via a new "MESONFLAGS" environment variable.
     
    +    Note that we also drop the CC variable, which is set to "gcc". We
    +    already default to GCC when CC is unset in "ci/lib.sh", so this is not
    +    needed.
    +
         Signed-off-by: Patrick Steinhardt <ps@pks.im>
     
      ## .github/workflows/main.yml ##
    @@ ci/lib.sh: linux32)
     
      ## ci/run-build-and-tests.sh ##
     @@ ci/run-build-and-tests.sh: case "$jobname" in
    - 	group "Configure" meson setup build . \
    + 		--fatal-meson-warnings \
      		--warnlevel 2 --werror \
      		--wrap-mode nofallback \
     -		-Dfuzzers=true
10:  0aa66bf9c1 = 10:  15acea92a2 ci: make "linux-musl" job use zlib-ng

---
base-commit: cbdbb490357c16eaaa6528c1d550c513a632d196
change-id: 20250110-b4-pks-compat-drop-uncompress2-eb5914459c32

