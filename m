Received: from fout-b8-smtp.messagingengine.com (fout-b8-smtp.messagingengine.com [202.12.124.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70F13243387
	for <git@vger.kernel.org>; Mon,  9 Feb 2026 16:56:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770656194; cv=none; b=UZeLthroVUzDqW994m6EVMl5kfjMuk6UmaHaDqkKb3VS2ozP5T5gbpKea4J/Pyebxk2xEA8sP8fgmAU3Sj07pCpLfw/aKeXpfUeFB6kzMmv4EhBkIJKc5rlfLZIRaLYZWVcbjJUm2shF+iqNhp55lIiwMugUqQvJhtvAXC8HOC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770656194; c=relaxed/simple;
	bh=g02JKKVNpA5SwJxx8SltnHVyesc0T7HFgV3JwPFeiYk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=KtX+TA0gTa7uULUQy1vFnU2Kk/nC0dZFFh7PvffZU4C9hvmYJZ34cGwxwSSxaryqy4Ih9XjKMvAmAu3V4yor23mIwiLj4W1lX4DsW3X68xSP52vUy6dPo7ve1xki+5Khk9tGNFVkMs/Ioq8mV1v89oXd61xcdvOAxQ8lp5efFX4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=prn1qP3S; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=jbzEb4Ma; arc=none smtp.client-ip=202.12.124.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="prn1qP3S";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="jbzEb4Ma"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.stl.internal (Postfix) with ESMTP id CCECD1D0013D
	for <git@vger.kernel.org>; Mon,  9 Feb 2026 11:56:33 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Mon, 09 Feb 2026 11:56:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1770656193;
	 x=1770742593; bh=/KFfpuQVSLAkDGxNIMMMUz6ZFXerBV4a8lwyRh1eJkg=; b=
	prn1qP3SE7/VT+UaomYkAas8WbT1TyJjpdnzTB/ETKXVpSa5pHrJb74XYNZxcbHo
	giSsuh+wsgDcMsOnI2ZLxmf8HNOhN2xVQy/6RnSnTx43DrIQ07yDHsK79CCwoWdC
	WyxOZBtO/tLfewF1PHLWUluqnLVBcFmYdGhJb5GinFJZ0ABEKn1n5avDmt0TwimD
	RGG3HYUfii8Fds0Flnzg2/CrzTzUfbfdq8125mZiFnLXJnFaEztIuUB4b4/AEz4Q
	JQ2YvidWhM9SubdMJn4NA17SjVA+tnXCabkBZekwQsocams626MySnUh4qhy98y0
	uwXjGnejQyns6N2wrmAFNg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1770656193; x=
	1770742593; bh=/KFfpuQVSLAkDGxNIMMMUz6ZFXerBV4a8lwyRh1eJkg=; b=j
	bzEb4Mai1W2Q7sx8/8wvLeObE9ViD3gMpht7fnaelxwh3ZNnCfFk006Q9kaf6gF0
	IlkRs6YgaCsVUkEVZBlUtv2DQ0E941x2d2o4vxu6jx1oUz9q6e+DbTEo48CViPOQ
	c8IXb5d2U4ZFA61gepVJrdLCMEF25a+L0XMrDdp9aAdLFvlKv58CRPHVvMfCfQVM
	KfSBjCOl7ZeA6xBx05sl9guPZBmPmj3n9tfKTJuhEySWeT73zLl2C3VZtfDYo+O2
	jDw7sYSdgk+PDE1kMsUlwgXQeNnWpqoTOaihaAKJxllw0xqQsqe57KH7IK6eamGg
	SShuTkHFgM74KgouTKVwQ==
X-ME-Sender: <xms:wRGKaa6waEsZmvrTIcCV15gvLFvx-xIzoaYpPtZvzElN6sqhV6Jo_Q>
    <xme:wRGKaa2iV5Wkb6RCpFQtolETOrIA8OBweuN5fZMNAhdi1-Tl4TTH-OGNqf8FcX8QL
    oYI5JBFbbRjCtwGxsCEbyH6CI6cs9DvivxcEIsNsR0sAk1xRdy7DA>
X-ME-Received: <xmr:wRGKafEcFsxxKIPYM-Xp_dh9YW2OqbNuN-Qkesq4erhJcsQeCeIcMsUHieFnQ0pmIyBSkKBh6QgVgBu8NIME9vbZFoVWWlsBC6j1cPM0x6I>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdduleejfeegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhfffugggtgffkfhgjvfevofesthejre
    dtredtjeenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehp
    khhsrdhimheqnecuggftrfgrthhtvghrnhepffeuiedujedvkeehuedvkeefffeivdeule
    etkeduheejteekgedvudfgtdfgieelnecuvehluhhsthgvrhfuihiivgeptdenucfrrghr
    rghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepuddpmh
    houggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdr
    ohhrgh
X-ME-Proxy: <xmx:wRGKacRZDNgxibwLOkvOEvY4GF_MAgfYokhkZ3XJ6yHWiU3KShmiBw>
    <xmx:wRGKaeBFvW_KDPLNGcdjLzd56nVQwp1xS_FI5Xh3wodBhq9gKAsmuQ>
    <xmx:wRGKaU3tiAyPmx5-xSNDLsVG-gy1Gy2C3-YjwcDoD93bA8Nv-1BR2A>
    <xmx:wRGKaUVBe_OYkz2HzsuXIiWOxf5SeSN5Z4cCZyI73ZFV0_Uey0baMQ>
    <xmx:wRGKaTaimoLmWKnNZGCLgQGMYfpTMA6OWAVmkfsgyxouwG6NSAvotXtF>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Mon, 9 Feb 2026 11:56:33 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 64af00a2 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Mon, 9 Feb 2026 16:56:32 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Mon, 09 Feb 2026 17:56:13 +0100
Subject: [PATCH 3/5] ci: make test slicing consistent across Meson/Make
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260209-b4-pks-ci-meson-improvements-v1-3-38444dec4874@pks.im>
References: <20260209-b4-pks-ci-meson-improvements-v1-0-38444dec4874@pks.im>
In-Reply-To: <20260209-b4-pks-ci-meson-improvements-v1-0-38444dec4874@pks.im>
To: git@vger.kernel.org
Cc: 
X-Mailer: b4 0.14.3

In the preceding commit we have adjusted test slicing to be one-based
when using the "ci/run-test-slice.sh" script. But we also have an
equivalent script for Meson that is still zero-based, which is of course
inconsistent.

Adapt the script to be one-based, as well, and adapt the GitHub workflow
accordingly. Note that GitLab doesn't yet use the script, so it does not
need to be adapted. This will change in the next commit though.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 .github/workflows/main.yml | 2 +-
 ci/run-test-slice-meson.sh | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/.github/workflows/main.yml b/.github/workflows/main.yml
index 2b175dc5c6..1b7a16e1f1 100644
--- a/.github/workflows/main.yml
+++ b/.github/workflows/main.yml
@@ -298,7 +298,7 @@ jobs:
         path: build
     - name: Test
       shell: pwsh
-      run: ci/run-test-slice-meson.sh build ${{matrix.nr}} 10
+      run: ci/run-test-slice-meson.sh build ${{matrix.nr + 1}} 10
     - name: print test failures
       if: failure() && env.FAILED_TEST_ARTIFACTS != ''
       shell: bash
diff --git a/ci/run-test-slice-meson.sh b/ci/run-test-slice-meson.sh
index 961c94fba0..a6df927ba5 100755
--- a/ci/run-test-slice-meson.sh
+++ b/ci/run-test-slice-meson.sh
@@ -9,5 +9,5 @@
 
 group "Run tests" \
 	meson test -C "$1" --no-rebuild --print-errorlogs \
-		--test-args="$GIT_TEST_OPTS" --slice "$((1+$2))/$3" ||
+		--test-args="$GIT_TEST_OPTS" --slice "$(($2))/$3" ||
 handle_failed_tests

-- 
2.53.0.295.g64333814d3.dirty

