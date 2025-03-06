Received: from fhigh-b2-smtp.messagingengine.com (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D71CF20A5D1
	for <git@vger.kernel.org>; Thu,  6 Mar 2025 11:31:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741260700; cv=none; b=qm8p0NNZzEhueJ0L4fICoxo8JD72MM78VdLFs9n7YC2WK8kubQ63aFl23KNw4CM/qxjYmtQ9+jhXkZmPtVdI8uaGwi/B/waPvFsV6L4zeWIdeuIxRRJgJH9Ld8g3iIFs9OkBLqDR/arN7QNm3IfQvoOcUz/R1qNOeXuSn3ooQPs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741260700; c=relaxed/simple;
	bh=b8nGT2CYtmRt/oEdjtSljW0boCsNiW7dBKvSgIkSlew=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=si6gG8+E95jNq2kC/T3KZDM8Y6A1EH/XyL6QXHMAhXD2GtBp1qyLcrMvXFKDpqje/4RvhXvtOrI7QGG8XBTI1YyhysnZOJf6tiPtVJvQgMsll7JB82Fbw/tXBDYXAfls1e6p5xLn2eukI0OWa+s1oBmEew/Gwm0usIbV1ZpwTMc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=GYcLAY3P; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=CHBnuxlC; arc=none smtp.client-ip=202.12.124.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="GYcLAY3P";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="CHBnuxlC"
Received: from phl-compute-09.internal (phl-compute-09.phl.internal [10.202.2.49])
	by mailfhigh.stl.internal (Postfix) with ESMTP id AA51325400F6;
	Thu,  6 Mar 2025 06:31:37 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-09.internal (MEProxy); Thu, 06 Mar 2025 06:31:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to; s=fm1; t=1741260697; x=1741347097; bh=iMgqN/EKqD
	cPjlnVhoRqlrxkZFDBLOoYX0tMWc/rliw=; b=GYcLAY3Ph0Hcs6ik4xtzom0QOf
	CJu7tpuxfkFT/fA+BlfNuTNagwk7pcwuUDmy7673/DslaAy+qvQ57s/iwcQyLpEr
	SVeso5vv5bUbqBO4rpLbjr/l/UEgfnDBq6unF2RRWYVnXlBoz5bj4wOEiMkIM32v
	zDknChWkhrtcj3FUtxyhyJkk8dSyiCYRlWIWg56tckfuInt1Sz8a4PiBuXFzWlf9
	dMJy3HYFmmBG/YahcU5LEjt+bvTJ4gdtIbGk4Aa1tjYm+08qlEdgSMGzLGUl1JSm
	aDLUJfUDDcAutlDPexod//hZRRlDDNSkQPQItX8W7U5xGFaqdSvhaJo/+d2g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1741260697; x=1741347097; bh=iMgqN/EKqDcPjlnVhoRqlrxkZFDB
	LOoYX0tMWc/rliw=; b=CHBnuxlCLL9N/gZIjdCBZKVvErl8kAqDE4uoHOJQS3mZ
	BZyCDb2z0IegZU6X9CYxlKIyvU6S3nNUrycYIY45YMAz2esYOE0XK0XWRkIE2Zxv
	8KF0Wc75z+L+/lNsllVfTs3UTMKjUjvw0KnXEPsCh/Sl+S3lI+Jl6nfjDmoWeBh5
	U9qM/BQA94YEqacZvUV3kN/UNlKsDv21GpVRyZVeS7P9zoB5ehNSWgjzymgK+cgm
	CFLCuLgTriMVk90PcUuhLEuUxFQVz3lD/Rz7LpYcr848ppmfEy6eISd9dyw1SykA
	r3B1PuYfMRnc/ao9o/ewHu0nzBKamnr7ejh/KA194Q==
X-ME-Sender: <xms:mYfJZ349zpjVz_XsZtq9CmG4Oj345PAuVd2slaopv_oWM5HxuVsHwg>
    <xme:mYfJZ85-LZdmw0fcTCco40ySt81b-FDpzr6EhEiSNdQz3znQUH7AwOPWeuoe_EVAn
    lmKQUBKax2mYIDEpg>
X-ME-Received: <xmr:mYfJZ-dplL8Ki-gX22y1hStKwE5VtYUQQfRKYn7PdiDCQTum5jQhgPArd-o9U3SJrIz_QPhSRHOVqbm8vjpU9JnaCQ8DRi3O-J-piBTuVmhhNw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddutdejieehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephfffufggtgfgkffvvefosehtjeertdertdej
    necuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrih
    hmqeenucggtffrrghtthgvrhhnpeffteehgedufeeuueeliedtteehveehudeftdelffeg
    uedvudelueeihfelveethfenucffohhmrghinhepghhithhlrggsrdgtohhmpdhgihhthh
    husgdrtghomhenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhr
    ohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopedvpdhmohguvgepshhmthhpoh
    huthdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthht
    ohepjhhohhgrnhhnvghsrdhstghhihhnuggvlhhinhesghhmgidruggv
X-ME-Proxy: <xmx:mYfJZ4INLiF-YJDjaW51OT89CnuhH0YB6QNiOvoG2jKytG2NbEFPnQ>
    <xmx:mYfJZ7JQ2ux3GRDMJdJgUWFOBnTs2YItsxbGX-y6Gf27i0OSLW4N1g>
    <xmx:mYfJZxzkcj60bE4MfhA8JtaVT0xGSNHB7yjcVgUuSvzgPb1ZEv-k4g>
    <xmx:mYfJZ3LZSdTXwgnoHSD9zR8jYbmziLkgBnkkeOf1e3iHfSlT9YH4gQ>
    <xmx:mYfJZyUCyBT_dGHf6gBolHXLJWw9srMIGEMqGDxAs2i9hnUn1y4VGGK0>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 6 Mar 2025 06:31:36 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id ed45158a (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 6 Mar 2025 11:31:34 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Thu, 06 Mar 2025 12:31:29 +0100
Subject: [PATCH] ci: use Visual Studio for win+meson job on GitHub
 Workflows
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250306-b4-pks-ci-meson-vsenv-v1-1-a65fe860289f@pks.im>
X-B4-Tracking: v=1; b=H4sIAJCHyWcC/x3MQQqDMBBG4avIrDuQxiraq5QuqvOrgxhDBkJBc
 veGLr/FexcZksLo2VyUkNX0DBX3W0Pz9gkrWKWavPOda13P04PjbjwrH7AzcDaEzBiGyUk7Qrx
 QbWPCot//9/Uu5QfkhYovZwAAAA==
X-Change-ID: 20250306-b4-pks-ci-meson-vsenv-e88b0d39ed2d
To: git@vger.kernel.org
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-Mailer: b4 0.14.2

In 7304bd2bc39 (ci: wire up Visual Studio build with Meson, 2025-01-22)
we have wired up a new CI job that builds and tests Git with Meson on a
Windows machine. The expectation here was that this build uses the
Visual Studio toolchain to do so, and that is true on GitLab CI. But on
GitHub Workflows it is not the case because we've got GCC in our PATH,
and thus Meson favors that compiler toolchain over Visual Studio's.

Fix this by explicitly asking Meson to use the Visual Studio toolchain.
While this is only really required for GitHub Workflows, let's also pass
the flag in GitLab CI so that we don't implicitly assume the toolchain
that Meson is going to pick.

Reported-by: Johannes Schindelin <johannes.schindelin@gmx.de>
Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
Hi,

this patch addresses the issue reported by Johannes [1] where GitHub
Workflows doesn't use the Visual Studio toolchain in the win+Meson job
even though it should.

Builds for GitLab are at [2], GitHub at [3]. GitHub now uses the MSVC
toolchain as expected [4].

Thanks!

Patrick

[1]: <3e9ccffc7474698947bdcb6d49b5d0728deadd08.1741256780.git.gitgitgadget@gmail.com>
[2]: https://gitlab.com/gitlab-org/git/-/merge_requests/318
[3]: https://github.com/git/git/pull/1909
[4]: https://github.com/git/git/actions/runs/13697111615/job/38302001801?pr=1909#step:5:16
---
 .github/workflows/main.yml | 2 +-
 .gitlab-ci.yml             | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/.github/workflows/main.yml b/.github/workflows/main.yml
index 9959b61ece2..6a002485aeb 100644
--- a/.github/workflows/main.yml
+++ b/.github/workflows/main.yml
@@ -265,7 +265,7 @@ jobs:
       run: pip install meson ninja
     - name: Setup
       shell: pwsh
-      run: meson setup build -Dperl=disabled -Dcredential_helpers=wincred
+      run: meson setup build --vsenv -Dperl=disabled -Dcredential_helpers=wincred
     - name: Compile
       shell: pwsh
       run: meson compile -C build
diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
index 2805cdeecb6..4798b283745 100644
--- a/.gitlab-ci.yml
+++ b/.gitlab-ci.yml
@@ -164,7 +164,7 @@ build:msvc-meson:
   extends: .msvc-meson
   stage: build
   script:
-    - meson setup build -Dperl=disabled -Dbackend_max_links=1 -Dcredential_helpers=wincred
+    - meson setup build --vsenv -Dperl=disabled -Dbackend_max_links=1 -Dcredential_helpers=wincred
     - meson compile -C build
   artifacts:
     paths:

---
base-commit: e969bc875963a10890d61ba84eab3a460bd9e535
change-id: 20250306-b4-pks-ci-meson-vsenv-e88b0d39ed2d

