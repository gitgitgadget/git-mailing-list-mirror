Received: from fhigh-b5-smtp.messagingengine.com (fhigh-b5-smtp.messagingengine.com [202.12.124.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABE4018B476
	for <git@vger.kernel.org>; Tue, 28 Jan 2025 08:41:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738053697; cv=none; b=NKw23j8/7MBuENYUFm8SJAk1BNHdD0ztnvAyjzO/UMrrrgVnKjTtXUq9KMR+DrLPAVAjQK2cFYce5JvV6X6lcJl8HG4V8MSuuk0EhCE53lEZLiIQy+X5ylpMh+lI5biQK6OG79iDfyAGo7R/GBzlAV2pCr29W+KLkt1h3OlrRoU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738053697; c=relaxed/simple;
	bh=Bkzz3vXk5JwBSp7lwkOUNOEjS+ngvJ7Pj6mrjG9ISGs=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 In-Reply-To:References:To:Cc; b=J9CFYraKIJi1jtFCTjMBtMpN5L2z6mxqIk+uk5vagZlqGzluTBUKqDWPoV5NQrZtkfNZNYG8bow4wM5yHQK+RT7qTTJdDtOdaVZm6awFpxohbu7j+wyX7m8xntVfD5gHN3jJ6s1dTRPw2hp6lDa+64cSlp2SSygNx5ErthdaoT8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=aAQR5QbH; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=VZztiv86; arc=none smtp.client-ip=202.12.124.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="aAQR5QbH";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="VZztiv86"
Received: from phl-compute-12.internal (phl-compute-12.phl.internal [10.202.2.52])
	by mailfhigh.stl.internal (Postfix) with ESMTP id C0F8925401D1;
	Tue, 28 Jan 2025 03:41:33 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-12.internal (MEProxy); Tue, 28 Jan 2025 03:41:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1738053693;
	 x=1738140093; bh=mLRH/aEDQedX20xm+v6r82bH4clswoeFisOMajYHqb0=; b=
	aAQR5QbHI7CtwZbcxlQ830R/avj9FWoHfOwn/rbUZO/CV1FYXPrBUsL+ULf7YSiU
	QmbZUv1D6s6p+j5TdzpzRMuS63kCEY+/UyKmqeAazBnu4uRUNzeQTwJSjkKeDRXi
	enoXcUR//emQAEOeciJOb6FFmCVKd5i72CM3iuO5X6HQbmZbRO6TxCo9rdtwDs6M
	GCKoKOLbCeslOr1RhoplD5xUEjGNsJYAvDTEMBVjpvSlSTxtOCaweLh9IF2sdsCT
	yllJZYb0xFrd/7r7RSgNzYYmn1Ig8sE7xSoVf1GOIY21EYPu1r5FsVejHgMLI+bI
	eLPizK/J9qViKCCNa/lywA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1738053693; x=
	1738140093; bh=mLRH/aEDQedX20xm+v6r82bH4clswoeFisOMajYHqb0=; b=V
	Zztiv86TNxnwCBHU/diQmDzmCX8kPuj7t1IoxTnopsOJD8fkJ1s0M9rE3Cyin4UH
	ddc3mu96vi6iuzXBkNJGUbNI6OGcJ15/9vNcgFi58SRgwD4IpfAateyNDAHYjhKp
	EKjxAiCEHvjgZO5EsMD17QvdKTbgZOm9jHYWCsLANT5goeSqCtyxZ0IoiWBOjEae
	P+iea+shXLtWN1TDO6cWksdaogyh63EV3NYx/FR3vj3TN2lxgXozDUXwnYTC0IQk
	qAot/iy/QjLXt57W4j7TQmmbd1Q0cZPAtVlWcbjPcv2J0W+g6RNU3oC4S/EHwYX4
	bst6qQRM9IVs0tmbyIiNw==
X-ME-Sender: <xms:PZiYZ9_pvpl5eIs8VeNGbcqeRWUToeS5tuAzd-xkbhCnV_rg3NTeyw>
    <xme:PZiYZxsK8j-W-JOFtBvcgb2uqnucOX3MisS0VFFsZuHIALb9U-8moFPho2yQmhpIr
    qcq2Is1HNFq9WpjeA>
X-ME-Received: <xmr:PZiYZ7DnZmFO731Ami2V2X9ZTUwU744rJje8fUI6LOXNl-f05ejF-bOQl0A2LyTswVcAgY7gnAIozeKn-7B0tXo6mgoyNJ5OGZfQfKv0d7I>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudejgedgudehieegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephffufffkgggtgfgjfhfvvefosehtkeertder
    tdejnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhksh
    drihhmqeenucggtffrrghtthgvrhhnpeduudevjeffffegjeegheeiteeuffdtvdehleeg
    feefvedtgeetlefhkeevtedtheenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuve
    hluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhs
    rdhimhdpnhgspghrtghpthhtohepfedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtoh
    epghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehkrghrthhhihhk
    rddukeeksehgmhgrihhlrdgtohhmpdhrtghpthhtohepmhgvsehtthgrhihlohhrrhdrtg
    homh
X-ME-Proxy: <xmx:PZiYZxcyHGhdI8WDu5Kyd71DCphfIZbdbd4kFrpwRU0VOIPut3wxIw>
    <xmx:PZiYZyPCeQS_pB6nf3L1dpXugin7MqTR64BshGG9dRss6bFYwzyy3Q>
    <xmx:PZiYZzm3bR8YDeuKSRQneLdi6-ciKDDDBWqp4SZzx9y4mTl5sYYYyw>
    <xmx:PZiYZ8vKfb0Tm_ITAZv5sdM7X_LBzTikIkFnezHAW06ed_aPLz67Pg>
    <xmx:PZiYZ_pq1vldaoQgOj3O_IE1R25NLObq5lcqdTYJY8q4_OO_qVEk8IqE>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 28 Jan 2025 03:41:32 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 87b2c433 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 28 Jan 2025 08:41:29 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Subject: [PATCH v4 00/10] compat/zlib: allow use of zlib-ng as backend
Date: Tue, 28 Jan 2025 09:41:26 +0100
Message-Id: <20250128-b4-pks-compat-drop-uncompress2-v4-0-129bc36ae8f5@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIADaYmGcC/43NQQ6CMBCF4auQrh3TDlMUV97DuCi0SGOkpMVGQ
 7i7hYXBFS7/l8k3IwvGWxPYKRuZN9EG67oUtMtY3aruZsDq1Aw5Si4Eh4qgvweo3aNXA2jvenh
 2c3kTAoKpZCmIZFnnyBKS5sa+lgeXa+rWhsH59/Ivinn9m44COJSF1JwjqgPpc7re2web3Yhri
 zYtTFYhSKGQR5OT+bHytVVsWnmyGlSNaGRNihdfa5qmDx6UmYNhAQAA
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

Changes in v4:
  - Add a comment explaining why we can stub out `deflateSetHeader()`.
  - Add a comment explaining why we have to cast away constness with
    zlib-ng's `next_in` field.
  - Link to v3: https://lore.kernel.org/r/20250116-b4-pks-compat-drop-uncompress2-v3-0-f2af1f5c4a06@pks.im

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
 compat/zlib-compat.h       | 53 +++++++++++++++++++++++++
 compat/zlib-uncompress2.c  | 96 ----------------------------------------------
 config.c                   |  1 +
 csum-file.c                |  3 +-
 environment.c              |  1 +
 git-compat-util.h          | 12 ------
 git-zlib.c                 |  7 +---
 git-zlib.h                 |  2 +
 meson.build                | 24 +++++++++---
 meson_options.txt          |  4 ++
 reftable/block.c           |  1 -
 reftable/system.h          |  1 +
 20 files changed, 107 insertions(+), 140 deletions(-)

Range-diff versus v3:

 1:  00984b07b9 =  1:  fcfcf1ed81 compat: drop `uncompress2()` compatibility shim
 2:  de7bf8bf15 =  2:  b483553549 git-compat-util: drop `z_const` define
 3:  1aea050dae =  3:  f4f23ad8bc compat: introduce new "zlib.h" header
 4:  40229f1c0a =  4:  14f6055809 git-compat-util: move include of "compat/zlib.h" into "git-zlib.h"
 5:  230d23877f =  5:  acb5212ed3 compat/zlib: provide `deflateBound()` shim centrally
 6:  05e0757235 !  6:  918cf3eb0d compat/zlib: provide stubs for `deflateSetHeader()`
    @@ compat/zlib-compat.h
      # define deflateBound(c,s)  ((s) + (((s) + 7) >> 3) + (((s) + 63) >> 6) + 11)
      #endif
      
    ++/*
    ++ * zlib only gained support for setting up the gzip header in v1.2.2.1. In
    ++ * Git we only set the header to make archives reproducible across different
    ++ * operating systems, so it's fine to simply make this a no-op when using a
    ++ * zlib version that doesn't support this yet.
    ++ */
     +#if ZLIB_VERNUM < 0x1221
     +struct gz_header_s {
     +	int os;
 7:  b10e6f35d7 !  7:  4047b9226a git-zlib: cast away potential constness of `next_in` pointer
    @@ git-zlib.c: static void zlib_post_call(git_zstream *s)
      	s->total_out = s->z.total_out;
      	s->total_in = s->z.total_in;
     -	s->next_in = s->z.next_in;
    ++	/* zlib-ng marks `next_in` as `const`, so we have to cast it away. */
     +	s->next_in = (unsigned char *) s->z.next_in;
      	s->next_out = s->z.next_out;
      	s->avail_in -= bytes_consumed;
 8:  6149885889 !  8:  d8f5c87d71 compat/zlib: allow use of zlib-ng as backend
    @@ compat/zlib-compat.h
     -#endif
     +# define z_stream zng_stream
     +#define gz_header_s zng_gz_header_s
    - 
    --#if ZLIB_VERNUM < 0x1221
    ++
     +# define crc32(crc, buf, len) zng_crc32(crc, buf, len)
     +
     +# define inflate(strm, bits) zng_inflate(strm, bits)
    @@ compat/zlib-compat.h
     +# if defined(NO_DEFLATE_BOUND) || ZLIB_VERNUM < 0x1200
     +#  define deflateBound(c,s)  ((s) + (((s) + 7) >> 3) + (((s) + 63) >> 6) + 11)
     +# endif
    -+
    + 
    + /*
    +  * zlib only gained support for setting up the gzip header in v1.2.2.1. In
    +@@
    +  * operating systems, so it's fine to simply make this a no-op when using a
    +  * zlib version that doesn't support this yet.
    +  */
    +-#if ZLIB_VERNUM < 0x1221
     +# if ZLIB_VERNUM < 0x1221
      struct gz_header_s {
      	int os;
 9:  f663af4332 =  9:  87fbc86f47 ci: switch linux-musl to use Meson
10:  376c05fe77 = 10:  f3ea4c5a81 ci: make "linux-musl" job use zlib-ng

---
base-commit: cbdbb490357c16eaaa6528c1d550c513a632d196
change-id: 20250110-b4-pks-compat-drop-uncompress2-eb5914459c32

