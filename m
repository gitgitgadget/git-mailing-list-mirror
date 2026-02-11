Received: from fout-b2-smtp.messagingengine.com (fout-b2-smtp.messagingengine.com [202.12.124.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D668369984
	for <git@vger.kernel.org>; Wed, 11 Feb 2026 10:35:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770806101; cv=none; b=sTiyCtEuOI12o1v3Fj3XzMx3dztDqSeYJcyzqO5CONOiyrVzvFZG7Zuww8w+Ae8OBqkd7/6Kr9smpR68s5XsYN5Bz0SV4jcMuwuB8Auhk1AFAWYEE8ohIooIvLPM8b3ZVg4RH3Sr0SO0kgjPFMHKHDmdr0gxdnSJfTySTSD3o14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770806101; c=relaxed/simple;
	bh=ZT6MofCoC23mz8aamkQ9U4BPDyDo3kArx9NT7zSFC6g=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=LQQm1Ybs9eaK0U22AEKY0WFuSKojAQsmXkJEzggM1Gh8epGjLn5jamIL+SgvT+cMu1Od8aMWLakVgMYV6uCu3L9DeRzHo1jTIr9rP0oNZ/DMs661lKiJ7n40BllPvW1W78S1iiQGtyLshMePTJPj0ANo0reDLUKMcpMSEZn5Uqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=NogT22vC; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=UKij9Aky; arc=none smtp.client-ip=202.12.124.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="NogT22vC";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="UKij9Aky"
Received: from phl-compute-12.internal (phl-compute-12.internal [10.202.2.52])
	by mailfout.stl.internal (Postfix) with ESMTP id A8D4F1D00248;
	Wed, 11 Feb 2026 05:34:59 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-12.internal (MEProxy); Wed, 11 Feb 2026 05:34:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1770806099;
	 x=1770892499; bh=SxN22F991JMlEPo1TzphusKRqjdR7+/Tsu75netySbE=; b=
	NogT22vCTD/ZZJEjW7ZZujzRw7pBsHyEO9c8rZ2+GhtliljR6dOQ1l4CGQpz2z6g
	902tKwTLoswgkedV48OcZiKcgujmRAi08wgOk7ywhbnrw8zTSSMhu8+N2NrUcXqB
	IB+I4LFOyWNJepJD43/G2BTUVKSQvxyC8yB/IruDMLtvXJIyTuApceZyJD8oeg0x
	eXwg1t+iESkpfsKL4BUYLal6ZZD6oUCk7XyIR3liJmVfUOWj7JIeT8Ffo64rmHUs
	P+KNJtGe6uaIX0Jg4pFu2STwzCWI4ksRWrA7y2fg0Po38t5OmwMfqUJ3qxlrQx0E
	mBtqGd0rCcFRZRS1LaHlEg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1770806099; x=
	1770892499; bh=SxN22F991JMlEPo1TzphusKRqjdR7+/Tsu75netySbE=; b=U
	Kij9AkybsWnwDOUWlSSkXJZB/KdOGZzDrDO9jmzlSYTTJedyNTyjmisqiBDDfjfT
	bJd5/6hxMQqwyuCQa2vlUMA4B5v6m9boXP+DiaXOJnlIlye1aksyu5Cn2gu4fteM
	USv9p9iaKKNIvxIX5Av0AQrYOF7dX6sQh4n70QBWmFWKmS8hGuiTDo3ng/Ft1g6j
	vB5W39rQvsk6YV5CboagbkDQxYNbMjc5kvW0V86vZL1erMKuvlbT+FcWVldO9FJX
	ek3Useq3GJNh1nY0T9bHjCbjZh6tTNkF4QWqMwbTRNqMPkWe9ZltC/SYb3OHEUQG
	Il+0eXZK0rkB98+RP9i3A==
X-ME-Sender: <xms:U1uMaZr5mUlsZ4_HsvjuXSpnFNsiTJisTHrkYEUqlus6Y1MgeTr-5Q>
    <xme:U1uMaSpj9rUf0f8kg3DerjAkSqkOeczYdgCNRaWiK6OokpzX-ZXmTkM8RWRCcMXnT
    FMhWJAEudw9BmcprudGtjYLds-FxkxjAd1-GZ-IJMIAvVXe9Npvnw>
X-ME-Received: <xmr:U1uMabMCohuN2p0wLQ9SUXiCq2QmHApmo5rYjlaxTgCQ_nkPSHoBuWkusTcKudt2ep8E_0mncJUjJQSK5L0SXenYKaDyPlIreCjWKqxwN22Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvtddvfedvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeffueeiudejvdekheeuvdekfeffiedvueelteekudehjeetkeegvddugfdtgfeileen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhmpdhnsggprhgtphhtthhopeegpdhmohguvgepshhmthhpohhuthdprhgtphht
    thhopehjlhhtohgslhgvrhesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtshhtvg
    hrsehpohgsohigrdgtohhmpdhrtghpthhtohepphgvfhhfsehpvghffhdrnhgvthdprhgt
    phhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:U1uMaTwGjOIiy1UAzY9HMROf8THwEPe6TtRpwDsmjMNin3OHe9UHdg>
    <xmx:U1uMaUvFybdmH2Cuir0IrqtR7TmVsFxotO09W7HNCGARBZF46ZHOzQ>
    <xmx:U1uMac6w5MF9KrmvtgzSuQa-0ou4XjrqijQLkxkmvLYSEV6VZPLeHw>
    <xmx:U1uMaTRvCy8kiNt-G6RbOq1TwqDDhT4CS2oC4babjsBcvH9iQFR72w>
    <xmx:U1uMaRLj06i_6cQRD6_P9juSwGIxW5xj2v4SiRn6MnUOshpEGEWKpBmU>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 11 Feb 2026 05:34:58 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id acc64139 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 11 Feb 2026 10:34:57 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Wed, 11 Feb 2026 11:34:33 +0100
Subject: [PATCH 7/7] gitlab-ci: handle failed tests on MSVC+Meson job
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260211-b4-pks-ci-meson-improvements-v1-7-cb167cc80b86@pks.im>
References: <20260211-b4-pks-ci-meson-improvements-v1-0-cb167cc80b86@pks.im>
In-Reply-To: <20260211-b4-pks-ci-meson-improvements-v1-0-cb167cc80b86@pks.im>
To: git@vger.kernel.org
Cc: Justin Tobler <jltobler@gmail.com>, Junio C Hamano <gitster@pobox.com>, 
 Jeff King <peff@peff.net>
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
2.53.0.295.g64333814d3.dirty

