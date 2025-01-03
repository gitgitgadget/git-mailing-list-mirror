Received: from fout-a3-smtp.messagingengine.com (fout-a3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3345F1FAC25
	for <git@vger.kernel.org>; Fri,  3 Jan 2025 14:47:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735915638; cv=none; b=i4Q7Msp8dm7XqgrrvIFCE5p3WLpA0AbRTMYrK21AEKUfVJVHaO8LeQGCYnZchHkSuXXK3mBt5k13pEFk87+Nnlbw4b/EFvKDEcsEOfC/PfmaHGbJTEVONw0iuAnRw6QfPCDFkHnsvhMNTvpWKpW1sh8KmnTAQdOf3G+FT1NXpyY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735915638; c=relaxed/simple;
	bh=0rSKFF3iAy52o81GngynxsGjGl8RJIHZIAuCsssqeLM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=PehX8k6dpFrFHlZXvTM9f3W/s+F06gzfjnRcJt50KyRylHA6eeqfMU/A4BGeZ0uwblkNcO53yGNAdLxPhbbYEE1K6J0a5T/sW0fQGPQ5mZCPn0Tu7UjCckrOsRwvId70AynnwiYt4ueOLoq0d3+ExhjjHofyeitLTYQLb4rzYxg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=F4dzZJna; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=w/g/+A1N; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="F4dzZJna";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="w/g/+A1N"
Received: from phl-compute-11.internal (phl-compute-11.phl.internal [10.202.2.51])
	by mailfout.phl.internal (Postfix) with ESMTP id 7968F138052E
	for <git@vger.kernel.org>; Fri,  3 Jan 2025 09:47:16 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-11.internal (MEProxy); Fri, 03 Jan 2025 09:47:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1735915636;
	 x=1736002036; bh=7uH+QxDgqjIsbI5W0WODNMawlRG9o2VBXVxCmmjmmeM=; b=
	F4dzZJnaFbnTf+eMHM4mVV5C0GJk1Od6dGeBgEvRKtKwlwjTgaQ4UX30dHUJB1jt
	1Ba6PFiOPnG5bQfxmpmmEqfTGiIme+TsdfyKyf4imgcWBtYwoSWW5F0yJf6VnT8t
	q7EenDeSbSWSoXAkKSGHPga7iiOSG59zOgNuXBN0fJmue5yc+tb8/a8pWI2I4hWa
	X/hJ6+IlK0xTzwckXjCfuuZayY7UqLAICHIJyfir5d2QfeN6wWURouTWq13/ryjB
	RfiaKCrJvgAUKAWn4P/vuBOKdXxt8qgUI0oUUwgwq9kF0dWVCTmg0MQ2bxvUlOx7
	TIVjrNFwTPD2B1c/HVjnUQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1735915636; x=
	1736002036; bh=7uH+QxDgqjIsbI5W0WODNMawlRG9o2VBXVxCmmjmmeM=; b=w
	/g/+A1NDpbYYvtRbSHUqu8pUnXQYGo+zv4b6ki1MjT/qthXbDzmRk1bT6MhNo0Pq
	pDtU+FcEqk0dvgBUaH8T+thZ1py5Hf8W3R4dE73YsKECpzCuUSfjlgWCSl5NeizF
	rHpHjqtU58nV0FSSIX4stOGOxqLY0jZnATjAxHIMDshYIitEHQ7aevZHIgHVgup5
	wNep06LJqQX25fTOC0XoLWaIxSuvvFVHe5tF5Jzf/W2nzd+g33FidmJW9ll4ACMs
	UWG+QHGD8n4vvqMIi94VHFu+JRQx7v+GvXWMKv6aU9iETfHedbGYKHZ7QVZyuQG2
	ssK2ZshYBdOK7tnkpc/DA==
X-ME-Sender: <xms:dPh3Z_RICIduWpB5ofpzzrkv0nmY_ji79peEhmAdMJmqYpUHf66qKw>
    <xme:dPh3Zwxk-BDTiaAuM5Pi1rk9z65clIkqUFEEdA8eIDzZ8GzjKIcwKqoOOBU440ckQ
    AW78WR1YBGEO8BSTw>
X-ME-Received: <xmr:dPh3Z025Ff5uOlClQAoxFawe0ZTRxp54YVtOg8BBPcvUJQuS4LBpi1d-7R2KHW1qVtcFQ-K_ViQMsM_rb-re-LODjqKnDRpJcqBAdw3F81Ot1fA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudefgedgieekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpefhfffugg
    gtgffkfhgjvfevofesthejredtredtjeenucfhrhhomheprfgrthhrihgtkhcuufhtvghi
    nhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnhepffeuieduje
    dvkeehuedvkeefffeivdeuleetkeduheejteekgedvudfgtdfgieelnecuvehluhhsthgv
    rhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnh
    gspghrtghpthhtohepuddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithes
    vhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:dPh3Z_B_mpEyOCKlTzOckq5jZTSiGYPeiISTYu5utvDv9J1T_f0Fgg>
    <xmx:dPh3Z4jdPRvCTtgl2AQrTHBGBQaejcfWvHEJ0IPE2MqkcZULKzKKvA>
    <xmx:dPh3ZzofpthODBdQ4_cxEuY1GSkG5W0K2vXP5o8I6xW7vKqNVeMYXg>
    <xmx:dPh3Zzj53gYgE_LWn3Ii2oytabhkns1sc0eXtd5Fw5Kg_JaJOrUU5A>
    <xmx:dPh3Z0aZZ2PUXjeTPLxCsV8UdQ9CWIqoIXjpF89coLSrDnbykxAvaei8>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Fri, 3 Jan 2025 09:47:15 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 1a569235 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Fri, 3 Jan 2025 14:47:11 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Fri, 03 Jan 2025 15:46:47 +0100
Subject: [PATCH 10/10] ci: remove stale code for Azure Pipelines
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250103-b4-pks-ci-fixes-v1-10-a9bb95dff833@pks.im>
References: <20250103-b4-pks-ci-fixes-v1-0-a9bb95dff833@pks.im>
In-Reply-To: <20250103-b4-pks-ci-fixes-v1-0-a9bb95dff833@pks.im>
To: git@vger.kernel.org
Cc: 
X-Mailer: b4 0.14.2

Support for Azure Pipelines has been retired in 6081d3898f (ci: retire
the Azure Pipelines definition, 2020-04-11) in favor of GitHub Actions.
Our CI library still has some infrastructure left for Azure though that
is now unused. Remove it.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 ci/lib.sh                 | 21 +--------------------
 ci/print-test-failures.sh |  5 -----
 2 files changed, 1 insertion(+), 25 deletions(-)

diff --git a/ci/lib.sh b/ci/lib.sh
index 77a4aabdb8fb416c1733f02d02145b6bc0849998..4003354f16c048b969c0bb4340d2ee2777767300 100755
--- a/ci/lib.sh
+++ b/ci/lib.sh
@@ -206,26 +206,7 @@ export TERM=${TERM:-dumb}
 # Clear MAKEFLAGS that may come from the outside world.
 export MAKEFLAGS=
 
-if test -n "$SYSTEM_COLLECTIONURI" || test -n "$SYSTEM_TASKDEFINITIONSURI"
-then
-	CI_TYPE=azure-pipelines
-	# We are running in Azure Pipelines
-	CI_BRANCH="$BUILD_SOURCEBRANCH"
-	CI_COMMIT="$BUILD_SOURCEVERSION"
-	CI_JOB_ID="$BUILD_BUILDID"
-	CI_JOB_NUMBER="$BUILD_BUILDNUMBER"
-	CI_OS_NAME="$(echo "$AGENT_OS" | tr A-Z a-z)"
-	test darwin != "$CI_OS_NAME" || CI_OS_NAME=osx
-	CI_REPO_SLUG="$(expr "$BUILD_REPOSITORY_URI" : '.*/\([^/]*/[^/]*\)$')"
-	CC="${CC:-gcc}"
-
-	# use a subdirectory of the cache dir (because the file share is shared
-	# among *all* phases)
-	cache_dir="$HOME/test-cache/$SYSTEM_PHASENAME"
-
-	GIT_TEST_OPTS="--write-junit-xml"
-	JOBS=10
-elif test true = "$GITHUB_ACTIONS"
+if test true = "$GITHUB_ACTIONS"
 then
 	CI_TYPE=github-actions
 	CI_BRANCH="$GITHUB_REF"
diff --git a/ci/print-test-failures.sh b/ci/print-test-failures.sh
index 655687dd827e5b3e4d4879803b0d4499e7751380..dc910e51609cd7344b1ad03fdb4e820e47ad3a88 100755
--- a/ci/print-test-failures.sh
+++ b/ci/print-test-failures.sh
@@ -39,11 +39,6 @@ do
 		test_name="${test_name##*/}"
 		trash_dir="trash directory.$test_name"
 		case "$CI_TYPE" in
-		azure-pipelines)
-			mkdir -p failed-test-artifacts
-			mv "$trash_dir" failed-test-artifacts
-			continue
-			;;
 		github-actions)
 			mkdir -p failed-test-artifacts
 			echo "FAILED_TEST_ARTIFACTS=${TEST_OUTPUT_DIRECTORY:t}/failed-test-artifacts" >>$GITHUB_ENV

-- 
2.48.0.rc1.241.g6c04ab211c.dirty

