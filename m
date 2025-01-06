Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB3961482E8
	for <git@vger.kernel.org>; Mon,  6 Jan 2025 11:16:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736162222; cv=none; b=io+b01UVHjOWOCm+QpttjwXdpTmvTn32u4cottaz60MqWadT55xJMUlLbni7oJuSLIIhj71gSxjNitmMqmO88TbklaaqdHutPU32c6VU+0Pr6OJzcmlfG67DstskSgfCuvy5Ts2QWsnbTFM2nJ/wOTXvEV9j/waal9P600zceJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736162222; c=relaxed/simple;
	bh=JOb5oLzyy/Ttl9juYQrAJN3u3SGjVPCI+PaeHIIj73M=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=GTvvg/TOJIS5ZKM4+qrzvFJ0t1JZn6cy5k1gizRAOs2cv9mJGhqboS/8fq26PW00QncKiPKuhmkrwrEvTBbAbmlvBBxTUS6CRmqYE8G1ZPSgKvXmeIhLeHxQCyBnF7U7+k71ptjSOWF4njhJlw0jZH7f+OouLCK8bo/uwuarDyM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=qBwxjITv; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=VYkrihNm; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="qBwxjITv";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="VYkrihNm"
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfout.phl.internal (Postfix) with ESMTP id 510FE1380946;
	Mon,  6 Jan 2025 06:16:56 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Mon, 06 Jan 2025 06:16:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1736162216;
	 x=1736248616; bh=x9FpIJNmgfCygBCKPXhPIJcGPQTYL70d54C6j/lqx08=; b=
	qBwxjITvpe7IWjVEDE/k3M6M0+NquA5mvSsYzHyvbkaINYsWPF3e5LmAcRuHEpc4
	hXFTUMfyNQjbU0ePiXlUgYnHnojgLROYolscjNtxgh83iQhXEgtnfQIOmZoqFL/Z
	+PmlENV64KfVbj9VylMAQMmHencJcORfG/yH0XJHJYzS0LME4fq39ju8ROQ5mm0y
	fFrTKtWFNIxHbotux8WBv043isWhdbF74M+Cu6WKloF2lHn9bbPFobSdrzOwmfPz
	LlPLF17eb8HQbmpL1mXj47iR3WDG4A3asFAJ7vhCHgMNRcCD977Ol8bgikl4bBKY
	qxlDv5Il1ruAIHKqqfsMCw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1736162216; x=
	1736248616; bh=x9FpIJNmgfCygBCKPXhPIJcGPQTYL70d54C6j/lqx08=; b=V
	YkrihNmOh1Wyk/ZDICOmwLDJxIuiepxTGJrBRj4mhKOKneKwUULDxIdZDMbsx8z9
	c5bZ3i5jy9VL8bpnKb7pYqpfjbOalLVmi98EJGwwRte6cm1HmzYv4DaMcwVE9qGk
	fvcWVNRJJ7WkvXYFbTEU+3Np9TiFrIkwnLszFeV8IDcxRzgqSbNVmUFKbNmF2XDL
	DIf2/uYKxyQk9Ymh6awb4AanwElm7elRKYx4W8iVsoDnpiq8CCGugjkvcvJLJK7N
	K5Bg7z/P7I6MUQ58POyLlmg8j3+p+mxEVhPO2pssTHr/JvFF00BkKWGO+uamkpj7
	Tkr49JQQh96ay9ZsDCKvw==
X-ME-Sender: <xms:qLt7ZzBbLrKnB6pN8IAAHQLT3fW0L4u1Uco6RySerRAV2ERjM3AF2Q>
    <xme:qLt7Z5gP4HtzzcsFs8VHyTPtWrk7UoLN7viO3rwvFQJt93UAY45EPHay6Jdy0Wg5e
    QOB9KXAeabFqqKcRA>
X-ME-Received: <xmr:qLt7Z-mL6TMLD26arPujgP8lloGjlLd8QDJ6t_Fgm4AqmhKY5YFHoo98ZgZSbhuU8vqTP63SjIgh_0e0Vzrxw6ogOF20OeMrnDZHc1PRc-_-0A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudegtddgvdeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpefhfffugg
    gtgffkfhgjvfevofesthejredtredtjeenucfhrhhomheprfgrthhrihgtkhcuufhtvghi
    nhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnhepffeuieduje
    dvkeehuedvkeefffeivdeuleetkeduheejteekgedvudfgtdfgieelnecuvehluhhsthgv
    rhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnh
    gspghrtghpthhtohepfedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepphgvfhhf
    sehpvghffhdrnhgvthdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorh
    hgpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:qLt7Z1xU0zsPeXEHBZhDutV8bgo_0gP0a7OIlcOSbUqghsgcRtjpHQ>
    <xmx:qLt7Z4RX2R80gHNVosCqX5kqKt1wwoooZB75bOetEgqDkGekF1miJA>
    <xmx:qLt7Z4Z3wXo375h81V8ENdpv9MI1x2Z0ybYMZMZcvJF8DlgAnVXKPQ>
    <xmx:qLt7Z5TZ5-szq1qfwjIZhoXVXIK-tjcMt0qaQhmRog9FUq5vU2lQ_Q>
    <xmx:qLt7Z-cHM2J2ljo0p_gMmbke4KKuhZs-hQagkARj6m6IalNvBprFoik8>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 6 Jan 2025 06:16:55 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 88897562 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 6 Jan 2025 11:16:54 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Mon, 06 Jan 2025 12:16:52 +0100
Subject: [PATCH v2 03/10] github: adapt containerized jobs to be rootless
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250106-b4-pks-ci-fixes-v2-3-06ae540771b7@pks.im>
References: <20250106-b4-pks-ci-fixes-v2-0-06ae540771b7@pks.im>
In-Reply-To: <20250106-b4-pks-ci-fixes-v2-0-06ae540771b7@pks.im>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
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

