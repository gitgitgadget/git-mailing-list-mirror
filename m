Received: from fout-a7-smtp.messagingengine.com (fout-a7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66FC02F1FFE
	for <git@vger.kernel.org>; Thu, 19 Feb 2026 06:25:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771482353; cv=none; b=OR2MQ3eCREHR4yjtD1674Unk4rW+Uh+Rkjl6mDy2frTXTK5JS7dBKqyFInftyFFuVqyRc2bxPHxT9UQwQb4MK29o2DUUAALq/693SlRx1n/IKRnhreaiZddflMY0ouM6L6FxpMO1lDve5sw42BVWelAAG/VBBL9dTsAMEAIbOwI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771482353; c=relaxed/simple;
	bh=ptz/OvTYYsn3f9Av1i8GJJxNFD7JYcOiKgHK5TdWfGk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=UXGACwB0K3ud0TP0GazKJU1Qe9Ia4B56KJWlE5v0RmDEtOGB6l3C5n4xa3Wn9dCx7Pmgg1Ur0wvJAHFNpt067wIfkBLiq6mW20izYZgiJMQCzwv95sywq4RTLL9FNQx94nvGyu7CWd68VuXZxIP6REYq19bkVH4YTJZduAw8ygI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=CJnwi4wv; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=X7vBqLb8; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="CJnwi4wv";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="X7vBqLb8"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.phl.internal (Postfix) with ESMTP id BB65EEC0040;
	Thu, 19 Feb 2026 01:25:51 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Thu, 19 Feb 2026 01:25:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1771482351;
	 x=1771568751; bh=9EYKjDKdZ1DiwLjUkYTUjDo5FUwLovej6TkgdpznHUI=; b=
	CJnwi4wvla/sgcLb3TFlW0WlND9r3a0EcL4+DV75FxU/QN2eaOeCcFaBDBbVGwZG
	C0g6Zh5WxE5Wtj5DC1gtvd49ihq6vXwE7V9/oBffxJTJtZlYE70gD3kAqg/uI0lE
	gd4l169901hmzaUfQHJ01WsmitkHJPuW2z9q3Fj+lpG+L2eKgZ7S7X4c2awtdYKy
	5icJRlmSxqkV9aurwNbZv0NaUfrq99hqMHel+C5qVi69feV92K1ASSUXV39BoHWK
	4FxRzihPoAK14wwDzLjxXGW1W36PLUdPATRi94JDyGzdKmEFQBDE5ihLK6eIXEIh
	MReGIwknhUNWuCib9QLcIw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1771482351; x=
	1771568751; bh=9EYKjDKdZ1DiwLjUkYTUjDo5FUwLovej6TkgdpznHUI=; b=X
	7vBqLb832NY6iPy+LqS0z1yNFauatvsta10y3xGcp6ZSlLh8hpQmRcad5A/sJQBw
	HbMOhH6k7i7IfM+e3ShhaorHiqSPLWTP1LAr+Z5RFzkLyD8+FRrWHpZSrJd39lAX
	hkjHA2Mgzm96B65WukABNDn1RufQycwar1wbCAt7q3nRh1PcY6IIpEB3KQMEb/Xg
	tVEr/KCCfmfnFEiMQSP66wKyjliGMWril5gVzUbYjqmiekzsOSGyM2ZPM03ePEgG
	ATDiH9ZKKZ9xqAiO7EFM9Qv9dXg6H79cTftGZz1QiB34WNkD1KowW1o3R7nfbmGk
	hJqilVZ2n4ztbXnyqQnAw==
X-ME-Sender: <xms:76yWafjtm8uXipMpr5IYxoIvyf9hy15uQqM-ErbkkXa2SymKyuFr0A>
    <xme:76yWaS4J_lTDVG3UNjYH6MlJ5H55S7ZAyxyuH-_SeUdz9rVIoabarSBSsA41NSRWf
    ZvATj1luy-21CZqXRK7-UrB-PpNa-sFG-QTFNgumoDF0i1_8c9TYQ>
X-ME-Received: <xmr:76yWaXbP42mDhGLSZWl1zb5qbA1JLsvhvXkCU6UaIvvOegrn9UFqoZEkY6tbgDxdunVqfjv9XFpsIRAv__1oheT4rXaGKycJ0wgDlHxB_w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvvdegjeelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeffueeiudejvdekheeuvdekfeffiedvueelteekudehjeetkeegvddugfdtgfeileen
    ucevlhhushhtvghrufhiiigvpeeinecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhmpdhnsggprhgtphhtthhopeehpdhmohguvgepshhmthhpohhuthdprhgtphht
    thhopehpvghffhesphgvfhhfrdhnvghtpdhrtghpthhtohepjhhlthhosghlvghrsehgmh
    grihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdp
    rhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhmpdhrtghpthhtohepjhhohh
    grnhhnvghsrdhstghhihhnuggvlhhinhesghhmgidruggv
X-ME-Proxy: <xmx:76yWaX6DzNxI0bmJci4_YGFvJr6YT7l1be3BjhttZtVa1fKaUuBKbw>
    <xmx:76yWaaDtdHKXTx77jgI-bDBmZmkzgUf1bXn5W7opQwXeIelS1kBfjA>
    <xmx:76yWaddGw5wj-qUit7sRNddx0fgBiWFJ7v7_UpSKh_Y7V2qKm_YYQg>
    <xmx:76yWaZKbN0dScjWwlZghiaOQGrnqTbrBGBoic3jX6Nx0ghGE6jKj0Q>
    <xmx:76yWafV2rD5uiUxSEOBgHIIcASi2obeoSoSEEqvYTmNlSBtO8NgrpwRI>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 19 Feb 2026 01:25:50 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 70b3d07a (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 19 Feb 2026 06:25:49 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Thu, 19 Feb 2026 07:25:33 +0100
Subject: [PATCH v2 7/7] gitlab-ci: handle failed tests on MSVC+Meson job
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260219-b4-pks-ci-meson-improvements-v2-7-6047b8307ab2@pks.im>
References: <20260219-b4-pks-ci-meson-improvements-v2-0-6047b8307ab2@pks.im>
In-Reply-To: <20260219-b4-pks-ci-meson-improvements-v2-0-6047b8307ab2@pks.im>
To: git@vger.kernel.org
Cc: Justin Tobler <jltobler@gmail.com>, Junio C Hamano <gitster@pobox.com>, 
 Jeff King <peff@peff.net>, Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-Mailer: b4 0.14.3

The MSVC+Meson job does not currently have any logic to print failing
tests, nor does it upload the failed test artifacts. Backfill this logic
to make help debugging efforts in case any of its jobs has failed.

GitHub already knows to do this, so we don't need an equivalent change
over there.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 .gitlab-ci.yml | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
index 04857b479d..71b8a6e642 100644
--- a/.gitlab-ci.yml
+++ b/.gitlab-ci.yml
@@ -157,6 +157,8 @@ test:mingw64:
   parallel: 10
 
 .msvc-meson:
+  variables:
+    TEST_OUTPUT_DIRECTORY: "C:/Git-Test"
   tags:
     - saas-windows-medium-amd64
   before_script:
@@ -164,12 +166,13 @@ test:mingw64:
     - choco install -y git meson ninja rust-ms
     - Import-Module $env:ChocolateyInstall\helpers\chocolateyProfile.psm1
     - refreshenv
+    - New-Item -Path $env:TEST_OUTPUT_DIRECTORY -ItemType Directory
 
 build:msvc-meson:
   extends: .msvc-meson
   stage: build
   script:
-    - meson setup build --vsenv -Dperl=disabled -Dbackend_max_links=1 -Dcredential_helpers=wincred
+    - meson setup build --vsenv -Dperl=disabled -Dbackend_max_links=1 -Dcredential_helpers=wincred -Dtest_output_directory="$TEST_OUTPUT_DIRECTORY"
     - meson compile -C build
   artifacts:
     paths:
@@ -185,10 +188,19 @@ test:msvc-meson:
   script:
     - |
       & "C:/Program Files/Git/usr/bin/bash.exe" -l -c 'ci/run-test-slice-meson.sh build $CI_NODE_INDEX $CI_NODE_TOTAL'
+  after_script:
+    - |
+      if ($env:CI_JOB_STATUS -ne "success") {
+        & "C:/Program Files/Git/usr/bin/bash.exe" -l -c 'ci/print-test-failures.sh'
+        Move-Item -Path "$env:TEST_OUTPUT_DIRECTORY/failed-test-artifacts" -Destination t/
+      }
   parallel: 10
   artifacts:
+    paths:
+      - t/failed-test-artifacts
     reports:
       junit: build/meson-logs/testlog.junit.xml
+    when: on_failure
 
 test:fuzz-smoke-tests:
   image: ubuntu:latest

-- 
2.53.0.414.gf7e9f6c205.dirty

