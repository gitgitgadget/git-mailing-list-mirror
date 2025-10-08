Received: from fout-b4-smtp.messagingengine.com (fout-b4-smtp.messagingengine.com [202.12.124.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A1CD1F3B9E
	for <git@vger.kernel.org>; Wed,  8 Oct 2025 06:27:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759904850; cv=none; b=FHulomil/fq2Oe/DSPtpeUQTlYpHDApoXPkgE1opqonpP68FUQaN59w7s82tsK1KxWuxjDhvo5WxJ6BXgICe5yBomxF7alW0MnCyaiOi1lHqnLPC2DWio5H+2GX1sJbRtXgMtxvhhyHdGb0BV+PsKVvgv+ISkz/UlsQ0YS2rZms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759904850; c=relaxed/simple;
	bh=X2rbnNy5UoAR3lckQc9eQAtHG+WN4+nrFqiOFrCW8R4=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=MfzFrimhmo2E42v6Ht9rPFKi0VhTn4tnZyxqFYHN0O1sOak0/SL/CfRMVTDlvVhkFQs2pYGjh1ovcyqb7SdikXKqpfOJg1A9uhe6UxtVJ0+OEEJm1syRCLEVGmTzOvugbbhACCe6xIeC/lqr+hIgT5CE++rwsaP960Cg0WehY7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=mhr4HC6B; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=fC09fKMG; arc=none smtp.client-ip=202.12.124.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="mhr4HC6B";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="fC09fKMG"
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfout.stl.internal (Postfix) with ESMTP id 736FB1D0015D;
	Wed,  8 Oct 2025 02:27:27 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-09.internal (MEProxy); Wed, 08 Oct 2025 02:27:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to; s=fm2; t=1759904847; x=1759991247; bh=Yry2yy71UR
	8A6jnrz9M7zsYM+hZQFVKvovtstd7C4C8=; b=mhr4HC6BZB6ncW68ld4diP6rpo
	NoO8X98/04LT7phLsqX9VyPX+WNCQHEAqSk4gJAnsOMr6tnknMFDMtsKb0SiGgAf
	n7RGXRIZtxgbiUm5/azmhvh4RFacQrss2GmoN90XDxJKmEwuLkrWPnXCORMElXAH
	DgLsHieYgSNkJAXkcgkbO8p6LoWs6l9487gQimDRvMggcrfjy4Assco+VzqxO0tQ
	SrGotWnU85vRzdIF6wS0K8HqMa0wySI1rR3e4IVXZfD90DQWEpgxXATNG64Ynhjj
	d15/WqjNkW0nGJPhuaPnrWMwe+AHvXc+4lkHHCfLLKfo8VbsMOPDfiqgizZQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1759904847; x=1759991247; bh=Yry2yy71UR8A6jnrz9M7zsYM+hZQ
	FVKvovtstd7C4C8=; b=fC09fKMG4wX0d6joa9PxYIpr8oL/U1/QxfPjkHt8MvtS
	9wK7pKUgWYfPHIc4//sRPa1crF/ybupknRgIIDCrQ1qHJzZl/EEmmswmojeag0wW
	5/YJWEpl8+R5RFe2XzTCJtqJnEN8bZS9FMsqH2ixByEYDsv197ZY2KC13ahORCY2
	WZLBeV1LE4JtADRNCXT+s2vZzmunFMZmN1frwhtdVppwS1aGQU1K2qngVMGmPggN
	rS4AfgRm5tUmXQE1FOs+jEd+l6E/FePEfeysuZuvE4LZ5/DSgXxhSXKWA1WDFzlb
	oLuoQg8vfnPOtmFcps558ghPy4WWw6CAS7SknowrrQ==
X-ME-Sender: <xms:TgTmaDmd-qMgQ1VpqxBSSCeH74vBI7k3fWcmmCeoAhuEPl1BvI-QbA>
    <xme:TgTmaF4i6-dl40XQ2SVzgt9-89obl9CHblW7xrYQF-P-nKdwksEVbUqVEEHLhx4GU
    BzoF8Dfa-3VgDkRwxtmE6LGHIryOoJ1Ce-XtDmf04eBoQc3yttLkg>
X-ME-Received: <xmr:TgTmaP3TMsa-Jkgf4G0lPrj-Vg_OnGQjfGFbyx8um_1NdhyJ_ErTyKTUbM950ADadoTYqtJUGb03C1M6DZB-KVf5dEcqpU8nNOYklZyq>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddutddvheekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffufffkgggtgffvvefosehtjeertdertdejnecuhfhrohhmpefrrghtrhhitghk
    ucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpe
    dvfeefgeevhffgtdevteehueejvefggfelvdfgudekveffueehkefhlefhlefgfeenucff
    ohhmrghinhepghhithhhuhgsrdgtohhmpdhkvghrnhgvlhdrohhrghenucevlhhushhtvg
    hrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhn
    sggprhgtphhtthhopeekpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehgihhtse
    hvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepvghrihgtshhunhhshhhinhgv
    sehgmhgrihhlrdgtohhmpdhrtghpthhtoheptghhrhhishdrthhorhgvkhesghhmrghilh
    drtghomhdprhgtphhtthhopegviigvkhhivghlnhgvfihrvghnsehgmhgrihhlrdgtohhm
    pdhrtghpthhtohepshgrnhgurghlshestghruhhsthihthhoohhthhhprghsthgvrdhnvg
    htpdhrtghpthhtohepkhgrrhhthhhikhdrudekkeesghhmrghilhdrtghomhdprhgtphht
    thhopehjohhhrghnnhgvshdrshgthhhinhguvghlihhnsehgmhigrdguvgdprhgtphhtth
    hopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:TgTmaIGuPlYVitb4PJlc-zZvLbcSMHviz_YU3TtReOUj42ByG-4yng>
    <xmx:TgTmaGjBou7FAHhyCQTRbAaV-mOdQxhp1OZcftbeIiOPTDsvN5by_w>
    <xmx:TgTmaDDHpzGaG-5LL_YB1CWzfvNdrINy0IBRDEI9fSL9jAhSdTTQbQ>
    <xmx:TgTmaARAaKRrqs7t7-YiQcJrpmekaxOeSCcB2VrBrfwO76WN63FKMQ>
    <xmx:TwTmaF7OXAZzZYmrzyUye415kcM9aOJR4e7jnVUYe6bR-2_oU0ENNEkl>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 8 Oct 2025 02:27:25 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 20ddd1ae (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Wed, 8 Oct 2025 06:27:23 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Subject: [PATCH v2 0/6] ci: improvements to our Rust infrastructure
Date: Wed, 08 Oct 2025 08:27:11 +0200
Message-Id: <20251008-b4-pks-ci-rust-v2-0-d556ee83c381@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAEAE5mgC/3WMyw6CMBBFf4XM2jHtWJ4r/8OwKDjKxAikg0RD+
 u9W9i7PvTlnA+UgrNBkGwReRWUaE9Ahg37w451RromBDOXWmBI7h/NDsRcML12wckRc+MrWBUO
 S5sA3ee/BS5t4EF2m8Nn7q/2tf1OrRYOn2uWGfMcl+3N6j/KENsb4BXVp+4ipAAAA
X-Change-ID: 20251007-b4-pks-ci-rust-8422e6a8196e
To: git@vger.kernel.org
Cc: Ezekiel Newren <ezekielnewren@gmail.com>, 
 "brian m. carlson" <sandals@crustytoothpaste.net>, 
 Karthik Nayak <karthik.188@gmail.com>, 
 Eric Sunshine <ericsunshine@gmail.com>, Junio C Hamano <gitster@pobox.com>, 
 Chris Torek <chris.torek@gmail.com>, 
 Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-Mailer: b4 0.14.3

Hi,

this small patch series introduces some improvements for our Rust
infrastructure. Most importantly, it introduces a couple of static
analysis checks to verify consistent formatting, use Clippy for linting
and to verify our minimum supported Rust version.

Furthermore, this series also introduces support for building with Rust
enabled on Windows.

The series is built on top of 45547b60ac (Merge branch 'master' of
https://github.com/j6t/gitk, 2025-10-05) with ps/rust-balloon at
e425c40aa0 (ci: enable Rust for breaking-changes jobs, 2025-10-02) and
ps/gitlab-ci-windows-improvements at 3c4925c3f5 (t8020: fix test failure
due to indeterministic tag sorting, 2025-10-02) merged into it.

Changes in v2:
  - Adjust comments for `encode_varint()` and `decode_varint()` based on
    brian's feedback.
  - Some small improvements to commit messages.
  - Not changed is the default column limit used by Rust. I think using
    the column limit of 100 used by the Rust ecosystem is sensible, but
    if there is a majority advocating for a limit of 80 I'll adapt this.
  - Link to v1: https://lore.kernel.org/r/20251007-b4-pks-ci-rust-v1-0-394502abe7ea@pks.im

Thanks!

Patrick

---
Patrick Steinhardt (6):
      ci: deduplicate calls to `apt-get update`
      ci: check formatting of our Rust code
      rust/varint: add safety comments
      ci: check for common Rust mistakes via Clippy
      ci: verify minimum supported Rust version
      rust: support for Windows

 .github/workflows/main.yml | 15 +++++++++++++++
 .gitlab-ci.yml             | 13 ++++++++++++-
 Cargo.toml                 |  1 +
 Makefile                   | 14 ++++++++++++--
 ci/install-dependencies.sh | 17 +++++++++++++----
 ci/run-rust-checks.sh      | 22 ++++++++++++++++++++++
 meson.build                |  4 ++++
 src/cargo-meson.sh         | 11 +++++++++--
 src/varint.rs              | 15 +++++++++++++++
 9 files changed, 103 insertions(+), 9 deletions(-)

Range-diff versus v1:

1:  26bd2c3713 ! 1:  fa3ba52997 ci: deduplicate calls to `apt-get update`
    @@ Commit message
         only required to perform job-specific tasks.
     
         In both steps we use `apt-get update` to update our repository sources.
    -    This is unecessary though: all platforms that use Aptitude would have
    +    This is unnecessary though: all platforms that use Aptitude would have
         already executed this command in the distro-specific step anyway.
     
         Drop the redundant calls.
2:  5116c20fd1 ! 2:  89e7b67d5c ci: check formatting of our Rust code
    @@ Commit message
         ci: check formatting of our Rust code
     
         Introduce a CI check that verifies that our Rust code is well-formatted.
    -    This check uses rustfmt(1), which is the de-facto standard in the Rust
    -    world.
    +    This check uses `cargo fmt`, which is a wrapper around rustfmt(1) that
    +    executes formatting for all Rust source files. rustfmt(1) itself is the
    +    de-facto standard for formatting code in the Rust ecosystem.
     
         The rustfmt(1) tool allows to tweak the final format in theory. In
         practice though, the Rust ecosystem has aligned on style "editions".
3:  5b4c3303b7 < -:  ---------- rust/varint: add safety comments
-:  ---------- > 3:  3c91ec55dc rust/varint: add safety comments
4:  68925b41c0 = 4:  481500d7b8 ci: check for common Rust mistakes via Clippy
5:  c3f0943066 = 5:  09e73796ec ci: verify minimum supported Rust version
6:  0f968950a8 = 6:  acd460fac5 rust: support for Windows

---
base-commit: 8c8e270f2aba359479c4c2b4ab3c62726e5dac9d
change-id: 20251007-b4-pks-ci-rust-8422e6a8196e

