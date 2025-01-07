Received: from fhigh-a1-smtp.messagingengine.com (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF3241E3DC4
	for <git@vger.kernel.org>; Tue,  7 Jan 2025 12:30:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736253055; cv=none; b=ZkoIFZjMbVtmUywVB4kNo9FtDxiwllCD72/oLEEzXOgY9MX2WLuGvfdkHMwM8KputWwt4EsMOKlbRmWzq+Mhmqb+W1vr8kVhosLV/VcGT4azHOFCk2vQk50AQh1DUfzwHCJuWMOrcTR8emyzIRYyC0OBGYhK7ghYdr0VhDvVHsY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736253055; c=relaxed/simple;
	bh=JOb5oLzyy/Ttl9juYQrAJN3u3SGjVPCI+PaeHIIj73M=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=V/7M81gLVUI1XO5wtVZv3M6ByBr6oy8Q69Nv3ATg9QbTkLiBgOLETDw1TfU4PCdeZMl/nngdMW8EPYv1PqO2wsJ8sw9yCTsAa3sFt0wojpTk5WAWu2btokTSMY4yWeQeDI8OwrZh9WA4tJu8EKUwhKqBfyVim0bdudL9f4kzciI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=kuqTbnNG; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=htOdpC77; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="kuqTbnNG";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="htOdpC77"
Received: from phl-compute-09.internal (phl-compute-09.phl.internal [10.202.2.49])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 802901140173;
	Tue,  7 Jan 2025 07:30:50 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-09.internal (MEProxy); Tue, 07 Jan 2025 07:30:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1736253050;
	 x=1736339450; bh=x9FpIJNmgfCygBCKPXhPIJcGPQTYL70d54C6j/lqx08=; b=
	kuqTbnNGVfDRH0y7LOJZUiAt304lMsaFclHKfB8EjV2ipaYdsZ6iajddKeNecBfh
	raA9XIe28fT8/tn/89ryqdCu0uchOk37Mld1PzZeMzFgvl+Yx64te3/lNhcW/QI/
	QCCJCtqMnsDJCEFOjJWbRdGSccOSaFR2eWrDxA5nkBCdadH9WkgwgQt2mM5NJRwC
	JzE7QmKau9AZBHnlR1QCgX2grUjokr7kFRQtGN6z3cYXtM3jezr16nTL0WuHHS0M
	tu7uayxaTbmL7tNIlXcXhpOCZ2PELP7mhrEh9gIrPcRjXkVdJHOuDJr6+vb4WK18
	e13H2WmKJO5mLLoPyo5xGQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1736253050; x=
	1736339450; bh=x9FpIJNmgfCygBCKPXhPIJcGPQTYL70d54C6j/lqx08=; b=h
	tOdpC77fGN4UhXmqzpOJ1HnCfyMgcCAOHncBD7hTgX3vNLVYJLDrVZsoX7H6ryJy
	wXlSRpIw72X2OuUhVl+sk3CV7J0JNZaMIxgR+CV6mU/JH7IcR3KLi0A20gctVM0u
	WotdRDqovHyGLhz4P9mq3/YOZIU7cYRIxv20XB4MmTn2Ts3qZ28d5uJBVjzosZBC
	41LlFblBsqfZh2hh2c9WZ0U+N3i1y2Q7FNq5rwgvR5snYZkISUwaP8fVkuzzGd6q
	+vGtQaeztw4/19+x3b0VdED985Q1NhqpTpT8+VKRtd8E16YBBxrIP3yQ2G/LdrSl
	GNMcUZIr/cxjdWSP1IKGQ==
X-ME-Sender: <xms:eh59Z1fSrPNQzFpeZvlU7rHGAQ27WtWNIdmTzREzOFiaRsP5P5FbHg>
    <xme:eh59ZzPVuaeRx7aGqVb-MBoDbF9yi5R0qRoE9qXOhZ8xL59peiHhxGAIGcjIJjR13
    7TAFYeuChC448LokA>
X-ME-Received: <xmr:eh59Z-jwDxz_6iOcl1jiqSZPNchiv0a4ZI5ezvvzfjKT0zL1oJmcu-pMI7E583gJCeu0M4PCMgCGfrp0dmW9EABIm0jEHPVrvPfCf8WtfsxFEg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudegvddggedtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdej
    necuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrih
    hmqeenucggtffrrghtthgvrhhnpeffueeiudejvdekheeuvdekfeffiedvueelteekudeh
    jeetkeegvddugfdtgfeileenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmh
    grihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeegpdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopehpvghffhesphgvfhhfrdhnvghtpdhrtghpthhtoh
    epghhithhsthgvrhesphhosghogidrtghomhdprhgtphhtthhopehphhhilhhlihhprdif
    ohhougesughunhgvlhhmrdhorhhgrdhukhdprhgtphhtthhopehgihhtsehvghgvrhdrkh
    gvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:eh59Z-9u_c8ls_w8eeVTXyFvV2uA2LueipZddedej4QgsVzZJPz-KQ>
    <xmx:eh59Zxu6KgP1960RcLiStKoaDoTPoXy44jCDfGwhmiPlrM__ipjGWQ>
    <xmx:eh59Z9EbMDixdCVbcZ_EFOnk-RgbmnqMtjPH8PyRrXtTbERXvZyp9g>
    <xmx:eh59Z4Mvw3rYeBQLkhO3Uh6IMLWkaN5ZUcy32S4lfTPykQDVUf4mDA>
    <xmx:eh59Z7ILjJ2OWaCHvkExnZX3WaB5dyq00hF3OhXGClLQI5UWWml-6kLv>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 7 Jan 2025 07:30:49 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 5855fefb (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 7 Jan 2025 12:30:47 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Tue, 07 Jan 2025 13:30:45 +0100
Subject: [PATCH v3 03/10] github: adapt containerized jobs to be rootless
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250107-b4-pks-ci-fixes-v3-3-546a0ebc8481@pks.im>
References: <20250107-b4-pks-ci-fixes-v3-0-546a0ebc8481@pks.im>
In-Reply-To: <20250107-b4-pks-ci-fixes-v3-0-546a0ebc8481@pks.im>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>, 
 Phillip Wood <phillip.wood@dunelm.org.uk>
X-Mailer: b4 0.14.2

The containerized jobs in GitHub Actions run as root, giving them
special permissions to for example delete files even when the user
shouldn't be able to due to file permissions. This limitation keeps us
from using containerized jobs for most of our Ubuntu-based jobs as it
causes a number of tests to fail.

Adapt the jobs to create a separate user that executes the test suite.
This follows similar infrastructure that we already have in GitLab CI.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 .github/workflows/main.yml | 6 ++++--
 ci/install-dependencies.sh | 2 +-
 2 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/.github/workflows/main.yml b/.github/workflows/main.yml
index 900be9957a23fcaa64e1aefd0c8638c5f84b7997..b02f5873a540b458d38e7951b4ee3d5ca598ae23 100644
--- a/.github/workflows/main.yml
+++ b/.github/workflows/main.yml
@@ -371,10 +371,12 @@ jobs:
       run: apt -q update && apt -q -y install libc6-amd64 lib64stdc++6
     - uses: actions/checkout@v4
     - run: ci/install-dependencies.sh
-    - run: ci/run-build-and-tests.sh
+    - run: useradd builder --create-home
+    - run: chown -R builder .
+    - run: sudo --preserve-env --set-home --user=builder ci/run-build-and-tests.sh
     - name: print test failures
       if: failure() && env.FAILED_TEST_ARTIFACTS != ''
-      run: ci/print-test-failures.sh
+      run: sudo --preserve-env --set-home --user=builder ci/print-test-failures.sh
     - name: Upload failed tests' directories
       if: failure() && env.FAILED_TEST_ARTIFACTS != ''
       uses: actions/upload-artifact@v4
diff --git a/ci/install-dependencies.sh b/ci/install-dependencies.sh
index d1cb9fa8785388b3674fcea4dd682abc0725c968..ecb5b9d36c20d3e7e96148ac628a96c62642c308 100755
--- a/ci/install-dependencies.sh
+++ b/ci/install-dependencies.sh
@@ -31,7 +31,7 @@ alpine-*)
 	;;
 fedora-*|almalinux-*)
 	dnf -yq update >/dev/null &&
-	dnf -yq install make gcc findutils diffutils perl python3 gettext zlib-devel expat-devel openssl-devel curl-devel pcre2-devel >/dev/null
+	dnf -yq install shadow-utils sudo make gcc findutils diffutils perl python3 gettext zlib-devel expat-devel openssl-devel curl-devel pcre2-devel >/dev/null
 	;;
 ubuntu-*|ubuntu32-*|debian-*)
 	# Required so that apt doesn't wait for user input on certain packages.

-- 
2.48.0.rc1.245.gb3e6e7acbc.dirty

