Received: from fhigh-b5-smtp.messagingengine.com (fhigh-b5-smtp.messagingengine.com [202.12.124.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2233D26AF5
	for <git@vger.kernel.org>; Wed, 19 Feb 2025 13:14:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739970843; cv=none; b=ZPHhsH0St3ZKdCa8Y5a9zFEl8IMLTspjIuzd5zuP32pubyEBqD0lwJwU6Vlxw9xrhR7ymUCmlspT+xYfH2XxMaLzRm+EOR7SXj3QVlYf1uVhIzkx8Xq4r7NFWfxLEdsrNJqPKC8ex6LwH11xIfWsVo3q7nS2iL0UYGrdRMUYDHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739970843; c=relaxed/simple;
	bh=vUF7v2P62b00qmPSVbPwUQrBN2zUS3oJUtPBONQVQlU=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 In-Reply-To:References:To:Cc; b=X7ZEW8Lib5de5N/fWXS9r2eWT5t99aBIDvurqGI7dYIAEKQNzqaUFNVf4thSbleN4N8r3hq2RI50UgGEBaOw9oEC151EhgOgT2e9qR9PBdm4Jrp7fFrwL43eVudtItzSTzND8xCkNShzeTuUJdyAsaQX8x8StejSzfW2nI/sYiI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=G7n2dDQp; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=l5G9hGYm; arc=none smtp.client-ip=202.12.124.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="G7n2dDQp";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="l5G9hGYm"
Received: from phl-compute-02.internal (phl-compute-02.phl.internal [10.202.2.42])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 1DBBC2540149;
	Wed, 19 Feb 2025 08:14:00 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Wed, 19 Feb 2025 08:14:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1739970839;
	 x=1740057239; bh=CMwI5TOGqyNh88+jMCqpzzYTGOoKt/bfnkUSpJFYddU=; b=
	G7n2dDQpKKnvFSFBlZ2wdH5KlzjuXrdFemX9aZo8+9c7KuzPHDJvZjlwaNE25bhz
	jBm6Lrs/jlL0nwkXCqpWrRzMMp2pxhjBTfskyYvnBdex/41orTBjwDYpwR+JclVd
	z1UnMOqES73fayf+h6eK5kzpgMV8Hdme3iT3xUZtR5+k7tceT2mLGNW/RpZL0LDs
	uiWV7Eg5P+X17L39ekMndw2A12IZkfMOU8UVWBfIGefoK0g9BYHYD52DVJAMdLsp
	POqT1eondxmZ1tyVV9YjI9zuKPZmv6kVcgYOg8YDfRd0q5hkSj3qi0mDKEMTNCou
	JQO9NszJU78Ycd/kHATIDw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1739970839; x=
	1740057239; bh=CMwI5TOGqyNh88+jMCqpzzYTGOoKt/bfnkUSpJFYddU=; b=l
	5G9hGYmVCD/2UI68FkC+nibBzCbYdn9yo8DxfSBHSp1mgKJROcqefhjSjRQ0TFuv
	KzLPNkveYfexZga+vpAKvOdqxcijlddoTaUNr9wMsrQh2dh8JU0XsnoL9lGuxo7B
	IzkHxsvYV7bnavJSmyCQBxYqeIlTFI3j5YArXx2xyM2GPyKlHmfIOEUInyXl1pSQ
	1jujXCZ5/WdgSW6G4DEIF+bwox9DP0/hptzl2P+3yFSEeEG5CK7BxpNawTQ0zFN3
	S7vfYRp5lWe6YH+//bFRBUG07DbPhdcUwIQ9qKqpNah7fXYMpjaM4V7XUOhVGcW/
	e4McsA0OU+CeLJKW6M/Yw==
X-ME-Sender: <xms:F9m1ZzPJR6iBsVO_uRYMggSCDmHTA6_5Z8GfWsspI-tyE6L6qn3Elg>
    <xme:F9m1Z9-YTiIm1B7Y0sS2pEz1zGqzuPOYBITi1dhon1MF46oGW82ByfVipdaOu0nzT
    pUr-jz0FKFZK9xfEg>
X-ME-Received: <xmr:F9m1ZyTJw3_M9EVThD0aX5z0JuW1g0Jki_mpDqOdNsRmyXASh4fRMZEwRlBr-VDW900cJ69uxrYHh5H6z5gZjebsIPjpzlQCMx6NC8HOx-JqRGQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdeigeefgecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhufffkfggtgfgjghfvfevofesthejredtredt
    jeenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrd
    himheqnecuggftrfgrthhtvghrnhepffeikeevgfeftdfhtddtfeevteeugefguefhtedu
    teegffefgfelkeduvdeuteegnecuffhomhgrihhnpehgihhthhhusgdrtghomhdpkhgvrh
    hnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhf
    rhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepgedpmhhouggvpehsmhhtph
    houhhtpdhrtghpthhtohepjheitheskhgusghgrdhorhhgpdhrtghpthhtohepghhithhs
    thgvrhesphhosghogidrtghomhdprhgtphhtthhopehmihhrthhhrdhhihgtkhhfohhrug
    esghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdho
    rhhg
X-ME-Proxy: <xmx:F9m1Z3toJje2MnYQrt-1ViogfligekhwaA3NCptRk1Zn-oj8rvQuXw>
    <xmx:F9m1Z7fC4DRRU0hFijFBmmCo6j24whEfkshcf2UeLPpPtqhInl1PBQ>
    <xmx:F9m1Zz3uPSYpR3ZgRzqBWzbn2usuYM8skagJRIJowihAKyL_YAuO2A>
    <xmx:F9m1Z3_PQuXhKQ-jIfz7L6PQtb6h3nyNidVRk7l7F9RE76l1IpHLPQ>
    <xmx:F9m1Zy4vyT_jLtSJQlwIeGn3ROhvHKN-K1bDxujYMubERkQnQVeDgS8r>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 19 Feb 2025 08:13:58 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 5e013e34 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 19 Feb 2025 13:13:57 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Subject: [PATCH v2 00/10] meson: wire up bits and pieces from "contrib/"
Date: Wed, 19 Feb 2025 14:13:40 +0100
Message-Id: <20250219-b4-pks-meson-contrib-v2-0-1ba5d7fde0b9@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAATZtWcC/22NwQ6CMBBEf4Xs2TXtIqZ48j8MB0pX2Rha0pJGQ
 /h3K/Ho8U1m3qyQOAonuFQrRM6SJPgCdKhgGHv/YBRXGEhRo0id0Z5wfiacOAWPQ/BLFIuNa23
 dN06ZWkGZzpHv8tq1t67wKGkJ8b2/ZP1Nf0Jt/guzRoVDzc5RS5atuZbOUSbotm37AA3vPh+1A
 AAA
X-Change-ID: 20250206-b4-pks-meson-contrib-5d9b3a5d0830
In-Reply-To: <20250218-b4-pks-meson-contrib-v1-0-c3edd292beb8@pks.im>
References: <20250218-b4-pks-meson-contrib-v1-0-c3edd292beb8@pks.im>
To: git@vger.kernel.org
Cc: M Hickford <mirth.hickford@gmail.com>, 
 Junio C Hamano <gitster@pobox.com>, Johannes Sixt <j6t@kdbg.org>
X-Mailer: b4 0.14.2

Hi,

this patch series wires up a couple more bits and pieces, mostly from
"contrib/". Included are:

  - The "libsecret", "netrc", "osxkeychain" and "wincred" credential
    helpers.

  - The git-contact(1) script.

  - Coccinelle via a new "coccicheck" target that generates the semantic
    check.

Not a lot of stuff is missing after this small patch series, as far as I
am aware. Omissions that I know of include "git-gui", "sparse" and perf
tests.

This patch series supersedes Mirth's patch series at [1]. I have picked
the compilation fix for MSVC from that series and retained authorship,
but with an amended commit message. I've also forged the SOB -- Mirth,
please let me know whether you're okay with this.

Changes in v2:
  - Dropped the gitk-related parts. I have instead created a pull
    request for gitk at https://github.com/j6t/gitk/pull/8.
  - Link to v1: https://lore.kernel.org/r/20250218-b4-pks-meson-contrib-v1-0-c3edd292beb8@pks.im

Thanks!

Patrick

[1]: <pull.1859.git.1739471859.gitgitgadget@gmail.com>

---
M Hickford (1):
      contrib/credential: fix compilation of wincred helper with MSVC

Patrick Steinhardt (9):
      GIT-BUILD-OPTIONS: propagate project's source directory
      contrib/credential: fix "netrc" tests with out-of-tree builds
      contrib/credential: fix compiling "libsecret" helper
      contrib/credential: fix compilation of "osxkeychain" helper
      meson: wire up credential helpers
      meson: wire up git-contacts(1)
      meson: wire up static analysis via Coccinelle
      ci: fix propagating UTF-8 test locale in musl-based Meson job
      ci: exercise credential helpers

 .github/workflows/main.yml                         |  2 +-
 .gitlab-ci.yml                                     |  2 +-
 GIT-BUILD-OPTIONS.in                               |  3 +-
 Makefile                                           |  3 +-
 ci/install-dependencies.sh                         |  2 +-
 ci/lib.sh                                          | 10 ++-
 contrib/buildsystems/CMakeLists.txt                |  3 +-
 contrib/coccinelle/meson.build                     | 89 ++++++++++++++++++++++
 contrib/contacts/meson.build                       | 55 +++++++++++++
 .../libsecret/git-credential-libsecret.c           | 10 +--
 contrib/credential/libsecret/meson.build           |  9 +++
 contrib/credential/meson.build                     |  3 +
 contrib/credential/netrc/meson.build               | 20 +++++
 contrib/credential/netrc/t-git-credential-netrc.sh |  2 +-
 contrib/credential/netrc/test.pl                   |  7 +-
 .../osxkeychain/git-credential-osxkeychain.c       |  2 +-
 contrib/credential/osxkeychain/meson.build         |  9 +++
 .../credential/wincred/git-credential-wincred.c    |  2 +
 contrib/credential/wincred/meson.build             |  5 ++
 contrib/meson.build                                |  3 +
 meson.build                                        |  5 +-
 meson_options.txt                                  |  6 +-
 t/lib-gettext.sh                                   |  2 +-
 t/t7609-mergetool--lib.sh                          |  2 +-
 24 files changed, 229 insertions(+), 27 deletions(-)

Range-diff versus v1:

 1:  f038c1b6a45 =  1:  1cbc7a0a2e3 GIT-BUILD-OPTIONS: propagate project's source directory
 2:  493714b2599 =  2:  7b280db6c74 contrib/credential: fix "netrc" tests with out-of-tree builds
 3:  6ca34876222 =  3:  63932bfaca2 contrib/credential: fix compilation of wincred helper with MSVC
 4:  f8004e550e3 =  4:  6f8bdb62e00 contrib/credential: fix compiling "libsecret" helper
 5:  56eaee681fb =  5:  cd01c7cdb28 contrib/credential: fix compilation of "osxkeychain" helper
 6:  fb06e907359 =  6:  2827ed818cc meson: wire up credential helpers
 7:  1720a22498c =  7:  84d5d994674 meson: wire up git-contacts(1)
 8:  d35fe9c7f1f =  8:  9a1a44e9db8 meson: wire up static analysis via Coccinelle
 9:  f3756bea4d2 <  -:  ----------- gitk: extract script to build Gitk
10:  091def75331 <  -:  ----------- meson: wire up Gitk
11:  5a6adc0c756 =  9:  05b11300b60 ci: fix propagating UTF-8 test locale in musl-based Meson job
12:  fdf80deb16a = 10:  92fa0c76c2b ci: exercise credential helpers

---
base-commit: 03944513488db4a81fdb4c21c3b515e4cb260b05
change-id: 20250206-b4-pks-meson-contrib-5d9b3a5d0830

