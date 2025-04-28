Received: from fhigh-a4-smtp.messagingengine.com (fhigh-a4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1331A3211
	for <git@vger.kernel.org>; Mon, 28 Apr 2025 07:30:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745825458; cv=none; b=skJj00MycOYT7ce8ThbL6jdNkhxc5x+7DWqwBhJeeZiH9iZFlK+Dt8GkTvqSSKzF/GSbnZ0gxTeclMdhPiQJW+J3PET6CAVSeGiNXrmw/ZRcl7QMGv4/4Y2MpaHMBcK4uPrq4uCGjj9g2FA/wgaywJ3LPdEkDjZMS2TCG+buyiw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745825458; c=relaxed/simple;
	bh=545J3K5pbVH+YT9nWsJ9XFilliuky7wgd5Cdnb3dMhw=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 In-Reply-To:References:To:Cc; b=TQ6SifI0B7dcJ0B0yY8GsFfThOOLo5gZSx/C2ve/4peP8Tc9PYCTIFq6fy0ww9ctWyZNyAsJ7wOxXe9o/gjSbnUOf7cd9P63K4MCa3tOlh3EY+NGGFmVxKosKQxb9xnqwiY5xXDBwu4+d8hsrf5899QnWc3X0d/YeYN61PaDXuU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Cob5lUq4; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=R14F0Ztm; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Cob5lUq4";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="R14F0Ztm"
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 04AF711400BB;
	Mon, 28 Apr 2025 03:30:55 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Mon, 28 Apr 2025 03:30:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1745825455;
	 x=1745911855; bh=SL534IrmHvxHzSQCwTTw4ZR2KuPvKYYLZyhAz0rODN0=; b=
	Cob5lUq4v0ndru9Bi5VA7TuHASM514Nd1K6lQrREtBUHjq9N/chn/HNkG1wGpGLf
	SoFT+Y1jUeIW39nylIziX2fb7P4iIOlfIMbpcr8JcUHAHFmIof3Y1s7X06Irts1U
	lXUSCLArbVD1HR3fu6Vf5aSUv1ATNAjCcCg9ywbD6ij/s4iCQZZzkKzoKVJOsyYm
	ZPywqRN1ERUOWPxqLxwvP9ENhOPs4XEto4FHTL/CeytkJsgKitxeVpFXdoxQZhQk
	+Qjno/sa3i/cbFddJuXj94+/Lt521/9knbIt6tOSDuIuH1WjlYONajjP5jaJqLSj
	fFBSVjnYNZu9/CQZ0C2QkQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1745825455; x=
	1745911855; bh=SL534IrmHvxHzSQCwTTw4ZR2KuPvKYYLZyhAz0rODN0=; b=R
	14F0ZtmZd62Y1j3232Nx6MnQ8hzk8vFhx4CkcgMxKPDQfIN1OxN5tKp0TB3hPVC+
	j3XxcQ29H6oN+W3tlgtXd1XTq5uWxFW4Jm+6uGiNNbSPX1ssl6b7K9FSCk/l995h
	XmIk0t0Iiw9ejZV8SZr9xcmYfpv/AvXI0J2artc+0pseb7vKSZKlcKlBREPrWVoL
	wZcXJuH/Z5zhiro4IPAiwTQ2SKykg3OOVLCJ1d32W9nsa1PYSOKjipWt47Y0z1q3
	isp/D64n62u6ulenACODpD87F5B+7l2F4ae3ye2HqRGSHRnvhhzYBiLmdxukUZVN
	WlTudP5HZLXUSa4+GMjWw==
X-ME-Sender: <xms:ri4PaKx4ZsMKtBYx2R59JKOTiwIRhVhZleEUdmIUARE3H2p1MOvC6g>
    <xme:ri4PaGQFkvFuaA12EcrlMxNFuTzBdklyhn9aU0rqtATnaFz-VDpx-ANelCf9YKU_I
    b_JJty3wVZ9_i5Gyg>
X-ME-Received: <xmr:ri4PaMV7lLNTE6rL8SxNuwsAPbki1fZ93w2HdSKJO3hoERbffo5dXcmdRCmv7EOCWZj2eQ00Oue61joWEWLOD3tbe6SL8JF76_BaV4jLQvV9>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddviedtfeehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephffufffkgggtgfgjfhfvvefosehtjeertder
    tdejnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhksh
    drihhmqeenucggtffrrghtthgvrhhnpeetueeuhefhhfeitdeuhedttdeikeeftdduhedt
    heefhfegffevgeegtdfhheeuvdenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuve
    hluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhs
    rdhimhdpnhgspghrtghpthhtohepgedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtoh
    epghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopegthhhrihhstgho
    ohhlsehtuhigfhgrmhhilhihrdhorhhgpdhrtghpthhtohepghhithhsthgvrhesphhosg
    hogidrtghomhdprhgtphhtthhopehtohhonhesihhothgtlhdrtghomh
X-ME-Proxy: <xmx:ri4PaAgd6xG7Z8jBY3W58QaZedx9CDDePjACx3RKx-cIOkBKUcDu3g>
    <xmx:ri4PaMBQ1MzYKDKzBh_OOUBjYCcW3B0XZUTaST_WA51nj_4OZ-ACmQ>
    <xmx:ri4PaBJ-2Wjqs1LTu3BHnoBx4jjsM5WLhfhD6wTKMbbofkblpZeofg>
    <xmx:ri4PaDBrFFPOAPSivTrIn-YqXo8_IPfQzvcltRt3_UuL0lmu05Z3PQ>
    <xmx:ri4PaFkhzwg-Lzn9xhgpu6j0g6-cUnfsAnbQT5KBPsqYR4rz3mks74Cs>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 28 Apr 2025 03:30:53 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 7ce6892e (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Mon, 28 Apr 2025 07:30:51 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Subject: [PATCH v5 0/5] meson: wire up support for benchmarks
Date: Mon, 28 Apr 2025 09:30:45 +0200
Message-Id: <20250428-pks-meson-benchmarks-v5-0-5010dd014d1d@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAKUuD2gC/3XP3WrDMAwF4Fcpvp6HLVu226u+R9mF4jiLGfnBL
 qGl5N2nlkFbWC7PQfqEbqKmklMVh91NlLTkmqeRA37sROxp/E4yt5wFKEBlIMj5p8oh1WmUTRp
 jP1DhgkJHETu3t84LXp1L6vLlwZ6+OPe5nqdyfVxZ9L39A43+H1y0VLIBiimg047Mkcc+8yDu2
 gJPwWq7IQALyhrvVVCknX8TzIsAsCEYFjxR60JD0XXtm2BfBdwQLAuuCXtEVAjx+cW6rr+CmSL
 IewEAAA==
X-Change-ID: 20250328-pks-meson-benchmarks-a8fac5f69467
In-Reply-To: <20250331-pks-meson-benchmarks-v1-0-b2ace85616a3@pks.im>
References: <20250331-pks-meson-benchmarks-v1-0-b2ace85616a3@pks.im>
To: git@vger.kernel.org
Cc: Toon Claes <toon@iotcl.com>, Junio C Hamano <gitster@pobox.com>, 
 Christian Couder <chriscool@tuxfamily.org>
X-Mailer: b4 0.14.2

Hi,

this small patch series implements support for running our benchmarks in
"t/perf" via Meson. The series does not aim to replace "t/perf/run",
which is more fully-featured and allows running benchmarks against
multiple different trees. Instead, this series only allows running the
benchmarks against the current tree. Users are thus expected to continue
using "t/perf/run" for more advanced usecases.

Changes in v2:
  - Adapt "aggregate.perl" to use a "/usr/bin/env perl" shebang.
  - Link to v1: https://lore.kernel.org/r/20250331-pks-meson-benchmarks-v1-0-b2ace85616a3@pks.im

Changes in v3:
  - Document how to run benchmarks in "meson.build".
  - Expand the message for the commit that enables out-of-tree
    benchmarking.
  - Link to v2: https://lore.kernel.org/r/20250414-pks-meson-benchmarks-v2-0-04377080a167@pks.im

Changes in v4:
  - The patch series was rebased on top of f65182a99e5 (The ninth batch,
    2025-04-24). This is due to a conflict with ps/test-wo-perl-prereq.
  - Introduce a 'benchmarks' option. This allows developers to require
    benchmarks as desired. By default, we auto-detect whether the host
    system has all dependencies available and enable or disable them
    accordingly.
  - Report whether or not benchmarks are enabled via `summary()`.
  - Our benchmarks depend on Perl, so add this dependency accordingly.
  - Link to v3: https://lore.kernel.org/r/20250422-pks-meson-benchmarks-v3-0-7aad68bac6fd@pks.im

Changes in v5:
  - Clarify that benchmarks are not run in parallel by default.
  - Link to v4: https://lore.kernel.org/r/20250425-pks-meson-benchmarks-v4-0-6b89555052c3@pks.im

Thanks!

Patrick

---
Patrick Steinhardt (5):
      t/perf: fix benchmarks with alternate repo formats
      t/perf: use configured PERL_PATH
      t/perf: fix benchmarks with out-of-tree builds
      meson: wire up benchmarks
      meson: wire up benchmarking options

 meson.build           | 22 ++++++++++-----
 meson_options.txt     |  8 ++++++
 t/meson.build         | 77 +++++++++++++++++++++++++++++++++++++++++++++++++++
 t/perf/aggregate.perl |  2 +-
 t/perf/perf-lib.sh    | 32 ++++++++++++++++++---
 t/perf/run            |  4 +--
 6 files changed, 131 insertions(+), 14 deletions(-)

Range-diff versus v4:

1:  bc19180b174 = 1:  03181f601f2 t/perf: fix benchmarks with alternate repo formats
2:  3e128c09333 = 2:  afb2fe1ce63 t/perf: use configured PERL_PATH
3:  f7adc20d14c = 3:  a61e43c6cfb t/perf: fix benchmarks with out-of-tree builds
4:  8b3ea380503 ! 4:  e51b46296ed meson: wire up benchmarks
    @@ meson.build
      #      # Execute single test interactively such that features like `debug ()` work.
      #      $ meson test -i --test-args='-ix' t1400-update-ref
      #
    +-#   Test execution is parallelized by default and scales with the number of
    +-#   processor cores available. You can change the number of processes by passing
    +-#   the `-jN` flag to `meson test`.
     +#      # Execute all benchmarks.
     +#      $ meson test -i --benchmark
     +#
     +#      # Execute single benchmark.
     +#      $ meson test -i --benchmark p0000-*
     +#
    - #   Test execution is parallelized by default and scales with the number of
    - #   processor cores available. You can change the number of processes by passing
    - #   the `-jN` flag to `meson test`.
    ++#   Test execution (but not benchmark execution) is parallelized by default and
    ++#   scales with the number of processor cores available. You can change the
    ++#   number of processes by passing the `-jN` flag to `meson test`.
    + #
    + # 4. Install the Git distribution. Again, this can be done via Meson, Ninja or
    + #    Samurai:
     @@ meson.build: git = find_program('git', dirs: program_path, native: true, required: false)
      sed = find_program('sed', dirs: program_path, native: true)
      shell = find_program('sh', dirs: program_path, native: true)
5:  a0b06cc7017 = 5:  20f9dd86d66 meson: wire up benchmarking options

---
base-commit: f65182a99e545d2f2bc22e6c1c2da192133b16a3
change-id: 20250328-pks-meson-benchmarks-a8fac5f69467

