Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA08115D5B6
	for <git@vger.kernel.org>; Wed, 20 Nov 2024 07:51:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732089106; cv=none; b=JeP/3Pe3xXtwKN2OOj7mI7U4eDF/7Z8bdt5a15dwsuMRaYZmu56RJRzpk0jpAvvrijJZ5chsyQemyLoHfBZarTK+zJaP7fETQv7bfUEVZsL0EhLOSgojvUeofsQ9CjLbM8N0bNBe/1bU9PPw5iWksjel5yVSHLYq8ZkDVsXDBw4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732089106; c=relaxed/simple;
	bh=c71CeUoruVP11Xp4dKNZYASowoqCCHK+/wRJc4hQHs8=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 In-Reply-To:References:To:Cc; b=CZp0oDi8EFLFmn4m8k/XiwZ6uNEcRv9otuwxFIgRYmKcWLDR+y/W+T3QyITU1Exw8/vPAbo/GKFVFbxohgm4bu/R+aZ1YoHnIxutD/KFdWsqPFduPknWwAwqIw8Kwj3kQZysHZDsebK80NQ9ztm+Y8TsRk1g+IJENPvEPelehXg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=yTaK9MB5; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Iewad5M2; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="yTaK9MB5";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Iewad5M2"
Received: from phl-compute-02.internal (phl-compute-02.phl.internal [10.202.2.42])
	by mailfhigh.phl.internal (Postfix) with ESMTP id CE5811140127;
	Wed, 20 Nov 2024 02:51:43 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Wed, 20 Nov 2024 02:51:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1732089103;
	 x=1732175503; bh=ifr7x4p0SsBPLi2a51/e/d4WmBNoS8lZBBTQB0fJanE=; b=
	yTaK9MB51tuxboJisVlNfVxb8qQqLv1jwjrp1mIZ+1fF6wzy5HWDfnTZU3C6R4Iz
	uRARihhyJ49e3T2tSUOnmyO1/UHRpY32vONqzRpKKFSaMeVp2eL5x3Jhzzw1mj2l
	WEWsX9h5d7NisUxNGAbI0ApqKChV8tWnCrjmuBk/e0VXxY2n23sKd0WFJr+nVZl1
	dwljAHms9i2My0D+EXoA/ifYqOFxKkHUQ9kWKtLSmVhS7rjQqQkehKyLC4izHQ3L
	DMwHrmhHEXILNz3wOfu/vBhjVmkq0wBj1YLQz/sGiU8mwweOi1eFhswO1/stmumH
	OvlgULMQ4LYhJkalmY+Txw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1732089103; x=
	1732175503; bh=ifr7x4p0SsBPLi2a51/e/d4WmBNoS8lZBBTQB0fJanE=; b=I
	ewad5M2xPWgh4/jPsTGQGsi8X9MeY5sKkaYys0gyO6OkEaZF2Knq5qVs7Lv5qXxF
	SjzwW84DsgtkluAxph903f/N0Q8hPbhBY+0XclC/6RZy01JQzUg8pKFUgRoqFdBl
	wGi9S75ZtiypVqmmhK7Fe3SZyHQ3lV2Ds2i3XBYTgg49HGHuXvrJ+EF9rD5Z3r3B
	i1f0Xl2R6/dexF7GREEjxX0mF0u8mkSYyjDhhrfKVF7R9KTbeE8V/9Wmtos0H1oX
	q/k09BcG7WweuUnqCcYrER1IZI5BaE5oPjtLFnWsKL4icDcnNHkEaCf2U3+4mpfG
	C5Vy6dFxT97OjQNdl+pRQ==
X-ME-Sender: <xms:D5U9Z-SHa3RTEW7DHhr1EIHqXmsK9Q6ROl4bOjqdoNb61tfrQe1sDw>
    <xme:D5U9ZzzQBXSL27lJjZywSyyahm3h-2ygW87BZFuLo44ql-uhfgYeN4kwfoQwEsuqU
    CS1S5RqtU6esWRvuQ>
X-ME-Received: <xmr:D5U9Z73pP5b1NlYhQcUv1KGw_TmGhoDRBYcqSJFCVQgMgez2ps-KycGOqTXpxx3Q2qx6tYFOJcU-CiWYZCqNonV56b7hF1qsv94Bi0958VdCTw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrfeefgdduuddtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhephffufffkgggtgfgjfhfvvefosehtkeertdertdej
    necuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrih
    hmqeenucggtffrrghtthgvrhhnpeduudevjeffffegjeegheeiteeuffdtvdehleegfeef
    vedtgeetlefhkeevtedtheenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluh
    hsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhi
    mhdpnhgspghrtghpthhtohepfedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepgh
    hithhsthgvrhesphhosghogidrtghomhdprhgtphhtthhopehkrghrthhhihhkrddukeek
    sehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdroh
    hrgh
X-ME-Proxy: <xmx:D5U9Z6C_VQqr8swxJI5x4DLuEPQg2I1lWPJe3wax9AX4t-Dx86ebOg>
    <xmx:D5U9Z3gbcBQt5QZ-ExvgON8FmEtxUyj96piribFCCp_ivbMuT2PKAg>
    <xmx:D5U9Z2oe8E-SrKOjksEdsrgguuL2x1Hi1XzFXX09fMmIgFoSNCsEkw>
    <xmx:D5U9Z6jA5SxdTVCf4pTtG_C45WpZ5NYerOC7YHzLE8WGaJIo7tgvXg>
    <xmx:D5U9Z0sn0pFcc2QY4IgEAdHLLplTjoHHdFZ4OPF_i2IgwPJhhhyMBr9R>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 20 Nov 2024 02:51:42 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 092f86c3 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 20 Nov 2024 07:50:51 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Subject: [PATCH v2 00/10] refs: optimize ref format migrations
Date: Wed, 20 Nov 2024 08:51:29 +0100
Message-Id: <20241120-pks-refs-optimize-migrations-v2-0-a233374b7452@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAAGVPWcC/42NSw6CQBBEr0J6bZsZQCGuvIdhMTANdAyfTJOJS
 ubutpzA5atUvdpBKDAJ3LIdAkUWXmaF/JRBN7p5IGSvDLnJS2tNjetTMFAvuKwbT/whnHgIbtO
 d4NWbjohK17YVqGLVJr8O/aNRHlm2JbyPt2h/6Z/iaNFg1fui6l1tqLjctX7mCZqU0hdcmHD+x
 QAAAA==
X-Change-ID: 20241108-pks-refs-optimize-migrations-6d0ceee4abb7
In-Reply-To: <20241108-pks-refs-optimize-migrations-v1-0-7fd37fa80e35@pks.im>
References: <20241108-pks-refs-optimize-migrations-v1-0-7fd37fa80e35@pks.im>
To: git@vger.kernel.org
Cc: karthik nayak <karthik.188@gmail.com>, 
 Junio C Hamano <gitster@pobox.com>
X-Mailer: b4 0.14.2

Hi,

I have recently learned that ref format migrations can take a
significant amount of time in the order of minutes when migrating
millions of refs. This is probably not entirely surprising: the initial
focus for the logic to migrate ref backends was mostly focussed on
getting the basic feature working, and I didn't yet invest any time into
optimizing the code path at all. But I was still mildly surprised that
the migration of a couple million refs was taking minutes to finish.

This patch series thus optimizes how we migrate ref formats. This is
mostly done by expanding upon the "initial transaction" semantics that
we already use for git-clone(1). These semantics allow us to assume that
the ref backend is completely empty and that there are no concurrent
writers, and thus we are free to perform certain optimizations that
wouldn't have otherwise been possible. On the one hand this allows us to
drop needless collision checks. On the other hand, it also allows us to
write regular refs directly into the "packed-refs" file when migrating
from the "reftable" backend to the "files" backend.

This leads to some significant speedups. Migrating 1 million refs from
"files" to "reftable":

    Benchmark 1: migrate files:reftable (refcount = 1000000, revision = origin/master)
      Time (mean ± σ):      4.580 s ±  0.062 s    [User: 1.818 s, System: 2.746 s]
      Range (min … max):    4.534 s …  4.743 s    10 runs

    Benchmark 2: migrate files:reftable (refcount = 1000000, revision = pks-refs-optimize-migrations)
      Time (mean ± σ):     767.7 ms ±   9.5 ms    [User: 629.2 ms, System: 126.1 ms]
      Range (min … max):   755.8 ms … 786.9 ms    10 runs

    Summary
      migrate files:reftable (refcount = 1000000, revision = pks-refs-optimize-migrations) ran
        5.97 ± 0.11 times faster than migrate files:reftable (refcount = 1000000, revision = origin/master)

And migrating from "reftable" to "files:

    Benchmark 1: migrate reftable:files (refcount = 1000000, revision = origin/master)
      Time (mean ± σ):     35.409 s ±  0.302 s    [User: 5.061 s, System: 29.244 s]
      Range (min … max):   35.055 s … 35.898 s    10 runs

    Benchmark 2: migrate reftable:files (refcount = 1000000, revision = pks-refs-optimize-migrations)
      Time (mean ± σ):     855.9 ms ±  61.5 ms    [User: 646.7 ms, System: 187.1 ms]
      Range (min … max):   830.0 ms … 1030.3 ms    10 runs

    Summary
      migrate reftable:files (refcount = 1000000, revision = pks-refs-optimize-migrations) ran
       41.37 ± 2.99 times faster than migrate reftable:files (refcount = 1000000, revision = origin/master)

Changes in v2:

  - Mention in the first commit message that the introduced flag will be
    used in a subsequent patch.
  - Link to v1: https://lore.kernel.org/r/20241108-pks-refs-optimize-migrations-v1-0-7fd37fa80e35@pks.im

Thanks!

Patrick

---
Patrick Steinhardt (10):
      refs: allow passing flags when setting up a transaction
      refs/files: move logic to commit initial transaction
      refs: introduce "initial" transaction flag
      refs/files: support symbolic and root refs in initial transaction
      refs: use "initial" transaction semantics to migrate refs
      refs: skip collision checks in initial transactions
      refs: don't normalize log messages with `REF_SKIP_CREATE_REFLOG`
      reftable/writer: optimize allocations by using a scratch buffer
      reftable/block: rename `block_writer::buf` variable
      reftable/block: optimize allocations by using scratch buffer

 branch.c                  |   2 +-
 builtin/clone.c           |   4 +-
 builtin/fast-import.c     |   4 +-
 builtin/fetch.c           |   4 +-
 builtin/receive-pack.c    |   4 +-
 builtin/replace.c         |   2 +-
 builtin/tag.c             |   2 +-
 builtin/update-ref.c      |   4 +-
 refs.c                    |  70 ++++++-------
 refs.h                    |  45 +++++----
 refs/debug.c              |  13 ---
 refs/files-backend.c      | 244 +++++++++++++++++++++++++---------------------
 refs/packed-backend.c     |   8 --
 refs/refs-internal.h      |   2 +-
 refs/reftable-backend.c   |  14 +--
 reftable/block.c          |  33 +++----
 reftable/block.h          |   9 +-
 reftable/writer.c         |  23 +++--
 reftable/writer.h         |   1 +
 sequencer.c               |   6 +-
 t/helper/test-ref-store.c |   2 +-
 t/t1460-refs-migrate.sh   |   2 +-
 walker.c                  |   2 +-
 23 files changed, 247 insertions(+), 253 deletions(-)

Range-diff versus v1:

 1:  059a17163a !  1:  167a262a0c refs: allow passing flags when setting up a transaction
    @@ Commit message
         refs: allow passing flags when setting up a transaction
     
         Allow passing flags when setting up a transaction such that the
    -    behaviour of the transaction itself can be altered. Adapt callers
    -    accordingly.
    +    behaviour of the transaction itself can be altered. This functionality
    +    will be used in a subsequent patch.
    +
    +    Adapt callers accordingly.
     
         Signed-off-by: Patrick Steinhardt <ps@pks.im>
     
 2:  2acf64db6b =  2:  39255cdeff refs/files: move logic to commit initial transaction
 3:  bac7ca1d80 =  3:  061950cf39 refs: introduce "initial" transaction flag
 4:  1101c9da75 =  4:  a559563c57 refs/files: support symbolic and root refs in initial transaction
 5:  75e769ec3e =  5:  8605fb50bc refs: use "initial" transaction semantics to migrate refs
 6:  a91fe4e2d5 =  6:  eb9cacdaa6 refs: skip collision checks in initial transactions
 7:  55901bd45f =  7:  6ac43c46b7 refs: don't normalize log messages with `REF_SKIP_CREATE_REFLOG`
 8:  d15006b445 =  8:  3b192c1e02 reftable/writer: optimize allocations by using a scratch buffer
 9:  4b5603743f =  9:  96cd8b8287 reftable/block: rename `block_writer::buf` variable
10:  4dd22bdbef = 10:  a36318ece6 reftable/block: optimize allocations by using scratch buffer

---
base-commit: facbe4f633e4ad31e641f64617bc88074c659959
change-id: 20241108-pks-refs-optimize-migrations-6d0ceee4abb7

