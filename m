Received: from fout-b4-smtp.messagingengine.com (fout-b4-smtp.messagingengine.com [202.12.124.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24B4C645
	for <git@vger.kernel.org>; Wed, 12 Mar 2025 14:29:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741789743; cv=none; b=Q/B0z7Fx+ZRXwNnf1RVmaBeampDoQrMPJmnUB58oZBGbIM8QnminThEtkN6bLliUVTFaINwozSdsQ07GIgCvzqxQdPkypVUYI5CbzeWrJlKUp/U1B4Vcdze6Lml5Uunz/xVeWRm8J2pXBm9RhxfeawfL/u8d0K3ZUL02h9j9rJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741789743; c=relaxed/simple;
	bh=lpH5+JUMy/itG+65SYu0u+sn1B0Zy/q+Gu8aNq01l+Y=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=DJ9JoNfYXgGH9lZvjdhN9lGcuG2hOiygCy3sJErOsRyeHPieZBkU+3acjmodoawZoVHK4dwikgdQhzDmu9OcpXkZ3KGWjHq3FQWocVfDwqa4bHP7dqv9lo3doG0CGlfsHt7NTG7CQnTSb5dXB/4QtWi6I1uIkfHMSIm4HcGYxcE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=QNSJGO4K; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=bcqEkHQa; arc=none smtp.client-ip=202.12.124.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="QNSJGO4K";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="bcqEkHQa"
Received: from phl-compute-11.internal (phl-compute-11.phl.internal [10.202.2.51])
	by mailfout.stl.internal (Postfix) with ESMTP id 3E972114025D
	for <git@vger.kernel.org>; Wed, 12 Mar 2025 10:29:00 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-11.internal (MEProxy); Wed, 12 Mar 2025 10:29:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to; s=fm1; t=1741789740; x=1741876140; bh=22DvvJj1M5
	pRZfadBmKUu0UnaP5YdjU4fEJhw2eEr0M=; b=QNSJGO4KGlY1n1Oeo0EOIje28S
	3qA2YNuf640iHLKMgb9SeI1SjFFlSQDCguU1BmoznA7dD0OjEfx/ERBvzGwWix67
	dT/A9CyN42MljzJ9sW+9ppeYv7kGjvrvpERb5VGNwYhPILwu6TDns1OmHZLlVmyV
	p1j6QekLJHRgPnoTZau7BGqlRltdMA7OXVE0uZ/q3S5762wVfw2US5fnjrXqn2oN
	d0FcX7aJyilHREgnJa6r/GsTl3Psg+wI2W0Yed24rIialHrXI8ogQcYw8GT7+jw5
	+gSijhW0uR6MaC7saPMlNdkNAf7ERwv/ubLlszH/X3wXhJlKNWxNM9340ZYg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1741789740; x=1741876140; bh=22DvvJj1M5pRZfadBmKUu0UnaP5Y
	djU4fEJhw2eEr0M=; b=bcqEkHQa247LSHr/h8oGkxb/xIPgxxWwEnEzBQ/ggFlL
	jwS/R+JnE8hRxMt/Rq6SCV74LVhdNDfs5BE0mtCFppksQzSBTXQCDBLe+Gzd6I3p
	pF3LUTqMuJIfIC3TzckywO1zytHnTUu0Dycksm5lvL4B1dv9mw4i88i0F9pDZdIx
	nYYKODGUsbxRU9pE4GhlCoBqtvA/21i5ZprH6U1jJhK+FhPxFP0d+Jkc3Ay+Zz5L
	yfRToOAvSCYm7k3oPmQveTxhJXf4HH7Kt5HlbrJZvD3+AONd8+NDxtXB7//jsErL
	sAhdPvHVUaP6DrHY8Lg9k87r4xu7adp1vbRMee03bA==
X-ME-Sender: <xms:K5rRZ_dKW9k06S_BL2rhXGWfUowO6sW4cV0AyzHRky21GxSGDrZmeg>
    <xme:K5rRZ1Px4iZ2AhuzdIk7-N9kqHjS-qirL81s6-NkdD4Tkw3poEJct15oxmWnyMzzf
    lJE4ZwR_gi3I5O5Fg>
X-ME-Received: <xmr:K5rRZ4iqVd3dhMQ49Cu5JcHjJ09IIvSWxJeQtJP7QmuS-wt7xiFfFTHDvoAiGuzDVO0vaIKw1BkwZs3sLO3xUEllnJP_92yE5al2uVycbM7UbRkaLQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdduvdehfeduucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpefhff
    fugggtgffkvfevofesthejredtredtjeenucfhrhhomheprfgrthhrihgtkhcuufhtvghi
    nhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnhepiefgiedtff
    ffvddvueehheejheehleduudfhheekkeeggefgueffheevgeetjeefnecuvehluhhsthgv
    rhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnh
    gspghrtghpthhtohepuddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithes
    vhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:K5rRZw84856ToHoA18oVQ0I7CHXXqcU6RjB4bdTM6A3ztp2vQz-qMA>
    <xmx:K5rRZ7scBB5XrjpQh0TkcEVuCr8lKmj0C3nqYVi477WAg6aT501AxQ>
    <xmx:K5rRZ_HZ2qAmX8TQzhVgVhfE1kg7ZBJNZ6DDH2MvtltUKMIKUI46Sw>
    <xmx:K5rRZyPjxnddtDrQk1dREsx1cLomX-Jhnt0xVO-9Cx9zRFrjtSF01A>
    <xmx:LJrRZ0WWrRNSRNcUGKY5gz4kO0Wb43e7IdSt8xQlnVCGv9uYVm3YetVx>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Wed, 12 Mar 2025 10:28:59 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id c6903a74 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Wed, 12 Mar 2025 14:28:56 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Wed, 12 Mar 2025 15:28:54 +0100
Subject: [PATCH] ci: perform build and smoke tests for Meson docs
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250312-b4-pks-ci-meson-docs-v1-1-5e7cf7ac959a@pks.im>
X-B4-Tracking: v=1; b=H4sIACWa0WcC/x3MTQqAIBBA4avErBtQ+4OuEi3SxhoiDQciCO+et
 PwW770glJgExuqFRDcLx1Cg6wrcvoSNkNdiMMp0qtEGbYvXIegYT5IYcI1OUHurle0HsuShpFc
 iz8+/neacPxiQnjZmAAAA
X-Change-ID: 20250312-b4-pks-ci-meson-docs-1fb10b67ebef
To: git@vger.kernel.org
Cc: 
X-Mailer: b4 0.14.2

Our "documentation" CI job performs a couple of tests against our
documentation. Part of these tests is to check whether documentation
builds at all and whether it spits out the expected set of files. We
don't yet have such a test for Meson, which means that we wouldn't
notice at all if building the documentation were to break. As a result,
breakages as fixed by 87eccc3a81d (meson: fix building technical and
howto docs, 2025-03-02) are easy to go unnoticed.

Address this test gap by starting to build both manpages and HTML sites
as part of the CI job.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
Hi,

this single patch expands our "documentation" CI job to also start
building Meson documentation.

Thanks!

Patrick
---
 ci/test-documentation.sh | 27 +++++++++++++++++++++------
 1 file changed, 21 insertions(+), 6 deletions(-)

diff --git a/ci/test-documentation.sh b/ci/test-documentation.sh
index 6c018b673e0..49f87f50fd7 100755
--- a/ci/test-documentation.sh
+++ b/ci/test-documentation.sh
@@ -15,6 +15,13 @@ filter_log () {
 	    "$1"
 }
 
+check_docs () {
+	test -s "$1"/Documentation/git.html &&
+	test -s "$1"/Documentation/git.xml &&
+	test -s "$1"/Documentation/git.1 &&
+	grep "<meta name=\"generator\" content=\"$2 " "$1"/Documentation/git.html
+}
+
 make check-builtins
 make check-docs
 
@@ -23,10 +30,7 @@ make doc > >(tee stdout.log) 2> >(tee stderr.raw >&2)
 cat stderr.raw
 filter_log stderr.raw >stderr.log
 test ! -s stderr.log
-test -s Documentation/git.html
-test -s Documentation/git.xml
-test -s Documentation/git.1
-grep '<meta name="generator" content="AsciiDoc ' Documentation/git.html
+check_docs . AsciiDoc
 
 rm -f stdout.log stderr.log stderr.raw
 check_unignored_build_artifacts
@@ -37,10 +41,21 @@ make USE_ASCIIDOCTOR=1 doc > >(tee stdout.log) 2> >(tee stderr.raw >&2)
 cat stderr.raw
 filter_log stderr.raw >stderr.log
 test ! -s stderr.log
-test -s Documentation/git.html
-grep '<meta name="generator" content="Asciidoctor ' Documentation/git.html
+check_docs . Asciidoctor
 
 rm -f stdout.log stderr.log stderr.raw
 check_unignored_build_artifacts
 
+# Build docs with Meson and AsciiDoc
+meson setup build-asciidoc -Ddocs=html,man -Ddocs_backend=asciidoc
+meson compile -C build-asciidoc
+check_docs build-asciidoc AsciiDoc
+rm -rf build-asciidoc
+
+# Build docs with Meson and AsciiDoctor
+meson setup build-asciidoctor -Ddocs=html,man -Ddocs_backend=asciidoctor
+meson compile -C build-asciidoctor
+check_docs build-asciidoctor Asciidoctor
+rm -rf build-asciidoctor
+
 save_good_tree

---
base-commit: 87a0bdbf0f72b7561f3cd50636eee33dcb7dbcc3
change-id: 20250312-b4-pks-ci-meson-docs-1fb10b67ebef

