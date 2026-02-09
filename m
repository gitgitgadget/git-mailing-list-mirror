Received: from fhigh-b7-smtp.messagingengine.com (fhigh-b7-smtp.messagingengine.com [202.12.124.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E4942248A3
	for <git@vger.kernel.org>; Mon,  9 Feb 2026 16:56:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770656199; cv=none; b=pmJS2Mqlvja7B4Nl+Xksxk6X7mqlMhjqMNE2l9C3zQ3bGFZh8MUvWTaCakDXfr94YUv0ZFW5PHkK818CkJzBcOTqYjU6rYzgeTuKD9JFrpVbzxZ8bnFgA2kZPmkntw4CcJ32kfRwaPbS2spJYimu4i2s1u5iH4YAGnSmN0ar7SM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770656199; c=relaxed/simple;
	bh=ZT6MofCoC23mz8aamkQ9U4BPDyDo3kArx9NT7zSFC6g=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=OuHs+SAsj18Cd3WAKyOzJMr4Hp3rDGt8PBdizjpgLr+0CbyUCWdWcjZj9b+xJ8BF/f/3mddPSu5erIvWC+M3/pLBn/RLMcLjMkudw99QvB/XCRClZIwvhFReVlMQK0a4dSbSChD3QuUCiKmDeSzHteDgSh0QIB0SaK7mbeUjP8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=JY2ixo5Y; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=fXbI8bhX; arc=none smtp.client-ip=202.12.124.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="JY2ixo5Y";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="fXbI8bhX"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.stl.internal (Postfix) with ESMTP id B176A7A0010
	for <git@vger.kernel.org>; Mon,  9 Feb 2026 11:56:38 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Mon, 09 Feb 2026 11:56:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1770656198;
	 x=1770742598; bh=SxN22F991JMlEPo1TzphusKRqjdR7+/Tsu75netySbE=; b=
	JY2ixo5YqMfwRkqn2lQw6+0sVk6QnXTnIwrZszMfYlqQBcrJE8UB1pwuK4tkGcq6
	KMXKrSXL+Kbvu/ofMjdI1W8xRp6NCc294+N86YZCWF2+EVERpiPEbKkKWBmQKxRY
	RNXvYbFV4KjtZROWrHNAfZDjyPW4aMrFMYzdghL7UkHi67nR4a6CDzyVJIuF0DNe
	ZOo1FdiPqkCxRsNqMVnamGlyXxsUfKVNmQPjJUAI55LBkQvPaF4pp+e+THwSyRg1
	X7awVegMtfKcKGIxw93H0ub5uz/OTV6i4aEty7ixfwceVj160TyR2Cx9jaZ+bQSn
	YgGVxEvbx50mSPySGrjtpg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1770656198; x=
	1770742598; bh=SxN22F991JMlEPo1TzphusKRqjdR7+/Tsu75netySbE=; b=f
	XbI8bhXWrcnFgAaRVThXH3G6Zb2gKh2prB6TpntktV8RclsZH429q/3KKczAIj1Q
	aRVuu/yRbKpjRKdg6P87spLMKASz4JzG1SVmklOylySJE6+4tDSKBEbHxITc/gGd
	tPy8r0nxITaBBEu6LsO4zPgceo3pMm/pXGq3bsZFNlFV8p6vI4mbjklTNXcEmOvR
	HU38xpsIEnUzhEc/pQDK+Pxk+GWUYUPXG+NVu3flPKNaTWmsTJrtXAx0kmGhatJq
	q5oprtodELsiuQJUIn+D6DVVNsnJKncNWNO+qcW1H0438AGTk7XbinOgUgp9gdpO
	W+kU04zjkADVoVNgKHhBQ==
X-ME-Sender: <xms:xhGKaetSTqGWyAzxIHlW5PJa3HocHVA5ARGvyExv-fJPPdbD0tbnKw>
    <xme:xhGKaaaEHO6DEjYzXZbyDrSDrdrho7NtRNTIUlD8PNoCKSXcrK46Ey8Eoeqxo8pNt
    qg2_8fUDNxUo_iCHypeWbJhxgO4QZzBpVnw0IDPqlyiBn-hvLmbhg>
X-ME-Received: <xmr:xhGKafYJfLogib8yuFzg4UVeyyUDMIK2podyTNWxcx1jDOIjiSLY8DNM--67rd5ELmqoM8q7ukqfXhqXvYQNKuDTJxriwWbkc7eruySPyqQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdduleejfeegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhfffugggtgffkfhgjvfevofesthejre
    dtredtjeenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehp
    khhsrdhimheqnecuggftrfgrthhtvghrnhepffeuiedujedvkeehuedvkeefffeivdeule
    etkeduheejteekgedvudfgtdfgieelnecuvehluhhsthgvrhfuihiivgeptdenucfrrghr
    rghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepuddpmh
    houggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdr
    ohhrgh
X-ME-Proxy: <xmx:xhGKaeXCAMNyGitRUOqC60_x2E1VxFS9IMG8SGXYpCNPMEvPAZ9v3Q>
    <xmx:xhGKae2urZj2RfdSuPvOYk3bi9GxXPK4y7imSr0Boipgy0JJQS07mw>
    <xmx:xhGKadZVQ5cRq8CNaqM3u9XGn_tgO9NhJD4fMuiiTJcPWsRFBoFydA>
    <xmx:xhGKaZrZEKt1RlHdI0CLa_XU6NCyFrRsxV_L1sE0A9PtFhXh3D0H9w>
    <xmx:xhGKaZeVbxahlPmk8mEVFnlf73dsJ6Y_GI9SGu72HLlUPHbD833k7120>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Mon, 9 Feb 2026 11:56:37 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 050b8cbf (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Mon, 9 Feb 2026 16:56:37 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Mon, 09 Feb 2026 17:56:15 +0100
Subject: [PATCH 5/5] gitlab-ci: handle failed tests on MSVC+Meson job
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260209-b4-pks-ci-meson-improvements-v1-5-38444dec4874@pks.im>
References: <20260209-b4-pks-ci-meson-improvements-v1-0-38444dec4874@pks.im>
In-Reply-To: <20260209-b4-pks-ci-meson-improvements-v1-0-38444dec4874@pks.im>
To: git@vger.kernel.org
Cc: 
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

