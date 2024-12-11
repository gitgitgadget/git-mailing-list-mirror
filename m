Received: from fhigh-b1-smtp.messagingengine.com (fhigh-b1-smtp.messagingengine.com [202.12.124.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85E3F239BD7
	for <git@vger.kernel.org>; Wed, 11 Dec 2024 10:53:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733914394; cv=none; b=rklto00Z1p1+9m9eZ2AL0qrUXuIdCdpHiEZh7eDhoUGAZ2PlknfSlp9yFHRF724/NEmWNRWwwHMJpBwu/6MXaC2Dd70vvQVMMmTuf4BwahqSQWik4pylOrXxUL0Y+uo757PlKt7uOWt1X+LKb2bXZH/G3pZpAOAbdvFPptTU2Xs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733914394; c=relaxed/simple;
	bh=gveQlHLUNGmCdXDLl0ZYDhznxQsxrODScgrls3njzss=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=omG+zJ6t95g/3jsI/lZrjvcJGPGhngkGnyDn6MK9ejdvlQOkTWO1V+gFHcM9h8UdclyfMLkUj7N/kaR0p73BVrRsjjyMhRSN2YYyJbtDhyxDU2tEstPPedgkdtHxwdCokPF8Q/1XI0vNPSq1IH3IM7iILTSpcpgzArncrVgfcws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Rws3nFes; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Qi+BSL1a; arc=none smtp.client-ip=202.12.124.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Rws3nFes";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Qi+BSL1a"
Received: from phl-compute-11.internal (phl-compute-11.phl.internal [10.202.2.51])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 4C8C72540212
	for <git@vger.kernel.org>; Wed, 11 Dec 2024 05:53:10 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-11.internal (MEProxy); Wed, 11 Dec 2024 05:53:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to; s=fm1; t=1733914390; x=1734000790; bh=D/RYs2vhZQ
	GjVLuiK42lMOVzLeWZduaeuXvUqm3quXc=; b=Rws3nFesqYnJV/KbUc7Kmtyptg
	RSb7Ax6W3wD/CYGXRXU+O2pKcvtcDZ86Ajg5tcCEs+3CdKf3SDMh0BskgV+FbCkh
	1kF3VNZ7BzOOj1tgUMMCq2ss33GcdpUscO77lYllVokDX1JQhQm7Jzy8Hp0WuBu7
	qJnDbefdYZMmjJLtKDhIXBdZObt2SZpD+kT1NJgpRDwtTGtlyz49YRw5ZxKEmC78
	wEy9hk5HXNsTirb8BQgcYJV6hsp7sWoQchbAXE7B0V++uxlWzohAjqw3SM+ZhI0n
	PLkz6+EF8jbsJnm9nzh7vbM9Y7Sdi5iRpuowc0qFBLEJ5ermVv94aZsCvopA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1733914390; x=1734000790; bh=D/RYs2vhZQGjVLuiK42lMOVzLeWZ
	duaeuXvUqm3quXc=; b=Qi+BSL1adW3cjDqwgLfF6sYoyA2iyVVccLsttZqY+Wjc
	qrFpQz+6bfRLxX1rJzuuSa0HJZF/QSUALyeB2MBMcWByV0IjZrkBUh5d8CwmoFru
	thDfqAQuThZ7YekbHKd3PW/lezCAj0QY8B3MQZH3Gdwnuw/0Qqy2IsZzWJvhBOTn
	gnS/eKwCiPX6dLnbOG7+G4RLSZlNLwpTpj3hmNG8TYJa1mSa6HjNUIfbSJxo/5Zd
	Wf6HkAyZphc73tzoExrju3Ju063MIkxK644m1TMr9dWckF0fOepBQXHgMU0cHwi9
	nCI6VUTOjQ5GDilDsQLQMF8R/8FvuqGuQjLyeFRu6Q==
X-ME-Sender: <xms:FW9ZZ29JAJ_aE0TMO-FeUIs4tweVuXY1kta-hJtWrznBdRsFZg7GBg>
    <xme:FW9ZZ2saYzH0V97eMvCQwcJ9dQaFAMJTd8dIaC8gRv35BBFTBAX563kCLQu16OkGE
    cVa4HZ3luObmRF54Q>
X-ME-Received: <xmr:FW9ZZ8C58iyTfd3JDw-DMqXdF0qrYNeo7gwJbCtB8gfK3dyanEIePJSRQRLb0XCQZxk_OLfxBzUONvpsI6mJRVtv8Y6RIdkYvk4KgMATen5_2g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrkedtgddvudcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecunecujfgurhephffufffkgg
    gtgffvvefosehtjeertdertdejnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgr
    rhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpeevueegkedtteeige
    ejueehuedugfevleefveehueehgfetffffvefhuefhueekveenucevlhhushhtvghrufhi
    iigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprh
    gtphhtthhopedupdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehgihhtsehvghgv
    rhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:FW9ZZ-cCHzgzRdOynHWupi0oxWaU9xWH8Ndgf4jVWa72o_0edXrbpw>
    <xmx:FW9ZZ7OKB_1m02876LT6Fzu9nxO2AaVsYkX1eaKvTlwUncrKFtCnpg>
    <xmx:FW9ZZ4l8vRr9IfncnwLbFGMh_8__IE6JNlFU6AzM6Dj9vBrFLkYFAA>
    <xmx:FW9ZZ9uteq8LUhhjmAFvRgOg7PJ5_5g0a7_H4gAh-Si-2ir0J-o-yQ>
    <xmx:Fm9ZZx3khn7v25gVvApxaYtUFybeqci9ILgXZzJIqwhgv6aMB22D9bYi>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Wed, 11 Dec 2024 05:53:09 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 7b5b2948 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Wed, 11 Dec 2024 10:51:32 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Subject: [PATCH 0/8] ci: wire up support for Meson
Date: Wed, 11 Dec 2024 11:52:31 +0100
Message-Id: <20241211-pks-meson-ci-v1-0-28d18b494374@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAO9uWWcC/x3MQQqAIBBA0avErBtQsaCuEi2yxhoiDQciEO+et
 HyL/zMIJSaBscmQ6GHhGCp028B6LGEn5K0ajDJWazPgfQpeJDHgyugWTVb1nfGOoCZ3Is/vv5v
 mUj6rTL6aXgAAAA==
X-Change-ID: 20241129-pks-meson-ci-ba1e40652fbe
To: git@vger.kernel.org
Cc: 
X-Mailer: b4 0.14.2

Hi,

this small patch series wires up Meson into our CI systems. The intent
is to ensure that it does not regress in functionality as the Git code
base evolves.

To help with keeping it up-to-date, both Meson and our Makefiles learn
to detect missing or superseded test files in "t/meson.build". This
should give users an early notification in case they have to add a newly
added or removed test to these build instructions. Overall I think that
this shouldn't be too much of a burden given that adding a new test is
trivial.

One gap that still exists is newly added code files. Due to many sources
being added to the build conditionally it's hard to have generic checks
for these. So I refrain from doing so in this series -- the build would
already fail anyway when we're missing code, so at least we will know
that something is up.

The series is built on top of caacdb5dfd (The fifteenth batch,
2024-12-10) with ps/build at 904339edbd (Introduce support for the Meson
build system, 2024-12-06) and cw/worktree-extension at 2037ca85ad
(worktree: refactor `repair_worktree_after_gitdir_move()`, 2024-11-29)
merged into it.

Thanks!

Patrick

---
Patrick Steinhardt (8):
      ci/lib: support custom output directories when creating test artifacts
      Makefile: drop -DSUPPRESS_ANNOTATED_LEAKS
      t/unit-tests: rename clar-based unit tests to have a common prefix
      meson: detect missing tests at configure time
      Makefile: detect missing Meson tests
      t: fix out-of-tree tests for some git-p4 tests
      t: introduce compatibility options to clar-based tests
      ci: wire up Meson builds

 .github/workflows/main.yml                  |  7 ++++
 .gitlab-ci.yml                              |  9 ++++++
 Makefile                                    |  5 ++-
 ci/install-dependencies.sh                  |  7 ++++
 ci/lib.sh                                   | 14 ++++----
 ci/print-test-failures.sh                   |  2 +-
 ci/run-build-and-tests.sh                   | 31 ++++++++++++++----
 meson.build                                 |  1 -
 parse-options.h                             | 12 +++++++
 t/Makefile                                  | 18 ++++++++++-
 t/meson.build                               | 40 +++++++++++++++++++++--
 t/t9835-git-p4-metadata-encoding-python2.sh | 48 ++++++++++++++-------------
 t/t9836-git-p4-metadata-encoding-python3.sh | 50 ++++++++++++++---------------
 t/unit-tests/generate-clar-decls.sh         |  5 ++-
 t/unit-tests/{ctype.c => u-ctype.c}         |  0
 t/unit-tests/{strvec.c => u-strvec.c}       |  0
 t/unit-tests/unit-test.c                    | 19 ++++++++++-
 17 files changed, 196 insertions(+), 72 deletions(-)


---
base-commit: 2fcbf72f13e8ce3bf1cda9a689f392f8f6e5c65d
change-id: 20241129-pks-meson-ci-ba1e40652fbe

