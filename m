Received: from fhigh-a5-smtp.messagingengine.com (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D78C20B7ED
	for <git@vger.kernel.org>; Fri, 10 Jan 2025 11:32:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736508729; cv=none; b=nJBF5OK0RwlbBuy/EGISJxFujgN0rmqFoxY3SNy7k4ay8hElVJo5C1PzfJ/FKP7j1ViwAsqEb5QTKrlLN624CwjXVEjlJfxEQxCrAGYYKB2gz8Q5Ctuo0Eo3Bb0BafV+UeNOcYGZ2PoBTkpI7T8VfphuZqOEUWPQSVMv8IuAy2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736508729; c=relaxed/simple;
	bh=rcOn6QQAi9ksQJ7iYZ7f+Wha7jsDrX54VVSXwiLCIOo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=SROYayHTmdE6mo13qVGWh4VGsaDV2B26Swi9fRj7WtLugorqLgxcX59mVk3G6jiHO1XA+9QjE+N2T33tILP6tFHXM/+wOKH57Pua/MTipJfRiDlwYTB7qzQ1uynpKrL/z4Z0ecw/xgSb5E8jRi9AFK5lYFDkfOgs2XX0TweA0U0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=mPTh/sXW; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=oLTZwoPo; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="mPTh/sXW";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="oLTZwoPo"
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 69AE511401C7;
	Fri, 10 Jan 2025 06:32:05 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Fri, 10 Jan 2025 06:32:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1736508725;
	 x=1736595125; bh=oU81E4vjU9mWIYi+R0YGvjIz6GzOlima36++Vwa/mYA=; b=
	mPTh/sXW5/ElOmBr9w/xEYnae04R71+9KwJ3GT5RvuermJgRDsisRvtw1frZBO6/
	aN9gXyX55NqpM7ucJDR14ccUIzg7HrPR37p7YkDjCXjJiDcnZ9hLQkFkjfiD5zg7
	aNr2RKEILWeGWnDlLd2q4Or+OXIFlfUUlP78X2eD1MaX1bh+Ptw2mGnbvaLF2qbZ
	T/kpiPaL2JSQRDMfZFZrh+sf7HDe5o9/OVEj3/WZSbBlq6/P38lyI0BBQYwRnwCR
	CQ4V8BjBvijaF+Zglk3u9mZ+T+EELAtP/0Qu3np76jACLxE9HkYC/NmA7+qTwx1w
	YgkotwVYWHAnn4zvPOtinw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1736508725; x=
	1736595125; bh=oU81E4vjU9mWIYi+R0YGvjIz6GzOlima36++Vwa/mYA=; b=o
	LTZwoPo4PZhQVvvCo9yHkeZK4vujuzB8DSFGpVgalnVFW0chrUKzcvUmFpMdRYr6
	CpJWogRYbfOMCYfWGJysp58TQw/3MiX6nbBxY95md2rpuEVRAWSt2DT1mrsOTlUI
	VoVlYGL9/JGVTRLCsP/ke+OAgxOWfAGXc28pIFZ6w8VHZfNEVrff8vENGKlkThnw
	V+qjGnjI/9anQy7YtwbKBWUynhKf//DsQtI/aUkdErMYdax/Pcha9nUzK6FkuZ7I
	ch4C9sEhl6H93CLcW2POL/AECzQLo1NG7f7Tmg7WKtiRjgsrKCeBRMMbis5HLPH5
	cg0YR2Z69cG/jtaGGn0Eg==
X-ME-Sender: <xms:NQWBZ8ZHLeL2e6SjUJWJGQtp6cDnGFXE-sg_n3auARTXunlMaQPobQ>
    <xme:NQWBZ3aPQSIT6EuW70GGd4Tz8LmIZ4MQq_YMNZe2oSMh8bQbgeqevuot1trKoHcwc
    QBH6V8XyFcfkvKbhA>
X-ME-Received: <xmr:NQWBZ29x9gghTNTT7dh86kxvz-gPh4uvfS5TXuGZv0UxGpGtuOh8cUMVm9JIqtWvWvU7ZMyOULmPZ6SDp9rlu_WhKDZlr30de894maaA373L_Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudegkedgvdelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdej
    necuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrih
    hmqeenucggtffrrghtthgvrhhnpeffueeiudejvdekheeuvdekfeffiedvueelteekudeh
    jeetkeegvddugfdtgfeileenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmh
    grihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeegpdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopehpvghffhesphgvfhhfrdhnvghtpdhrtghpthhtoh
    epghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehgihhtshhtvghr
    sehpohgsohigrdgtohhmpdhrtghpthhtohepphhhihhllhhiphdrfihoohguseguuhhnvg
    hlmhdrohhrghdruhhk
X-ME-Proxy: <xmx:NQWBZ2pyD1TyaNbRspVY24zPHTJOaLbYXdPIuh9oQ9bXLzOuqAQkHA>
    <xmx:NQWBZ3q3Wk2prow_9AUnSB6Zb_4g06sLGg7aS1cOR-u3ZHZ0mSWA0w>
    <xmx:NQWBZ0RX1uHGFEq-j6KR9FHcgL_4gdNY5n42xU5InxW09ctFSGJz3w>
    <xmx:NQWBZ3rR95ec1k8s7HQ6DSM1mgTqC1xDN4LjAsiG_f7vcWz6yCSLNQ>
    <xmx:NQWBZ4lVoOOj_o3zHxaShuqW1JKdQiMsV6UmQW1V_F298d9Bmu-b3dN3>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 10 Jan 2025 06:32:04 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id d9d03fa3 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 10 Jan 2025 11:32:02 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Fri, 10 Jan 2025 12:31:59 +0100
Subject: [PATCH v4 03/10] github: adapt containerized jobs to be rootless
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250110-b4-pks-ci-fixes-v4-3-6e4613446080@pks.im>
References: <20250110-b4-pks-ci-fixes-v4-0-6e4613446080@pks.im>
In-Reply-To: <20250110-b4-pks-ci-fixes-v4-0-6e4613446080@pks.im>
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
2.48.0.rc2.279.g1de40edade.dirty

