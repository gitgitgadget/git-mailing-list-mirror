Received: from fhigh-a5-smtp.messagingengine.com (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8876120D4E9
	for <git@vger.kernel.org>; Fri, 10 Jan 2025 11:32:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736508735; cv=none; b=eCTCQYc2hcw238UgvqmRQDeYbRwshYA7HtQ9pUzxqIcEOGNLhMcUEw5zeDZaUsczg97ZzAcr1vACX6nDQS/a/fu9hMZk/2KwRXKMrLVqjZY/CpU3lZPg+oKGluGusJBBTdVb0s6LUMS8gil5lBG0qLWI5OVcO61emDiJVjyuxiE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736508735; c=relaxed/simple;
	bh=ghWrse/FhTV33X00xHvgmCjBFlWzyEB6KSCRmTDQKwc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=rWD0vxD3o2rdhOYFU1We968Hb0i1wq6DG2R0gMIgYjKvfxeSH6lpPH3XuNRD8idjNCveEaNpinlqcLngkP1voX0E6/JMdndCPpZSbiZJket4SOHNdQMzARay6elRW1n8tsQZcugfABWVV755TGPJMv046g8e4oN0gTftw2TiAP4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=XSoQzBth; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=bAIlRbxz; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="XSoQzBth";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="bAIlRbxz"
Received: from phl-compute-02.internal (phl-compute-02.phl.internal [10.202.2.42])
	by mailfhigh.phl.internal (Postfix) with ESMTP id A26A511401A1;
	Fri, 10 Jan 2025 06:32:11 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Fri, 10 Jan 2025 06:32:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1736508731;
	 x=1736595131; bh=UNnGfgGf7tZwpczUFQXyQa9fnyCCAfZMw9aJVyVxYRQ=; b=
	XSoQzBth40SGe4pFq+H2px1fcrYLGepqJINouiwC5HFm0N41iwn+a0VRs1ewsMKY
	+/df9IiCZXsL7LEvND0fdWbQeqcW4ZVCvvQZceJ/6U2cBfk1KC9yLa+Xqr+RRYF8
	u2bm4a8IhnSZehR27QgGFT+Fu9OP4N9Qe7/x9f9MnptoBVNFXYTLfeHzIVTuvmy0
	rXLBSSkW+OIyWwKvz1hTViJi33mY+N7HbFBk7o3VbBMx861LjU7oM7dHvYJme2SB
	CPcD3d6AqRxyuYZfX6YslcWm762K6Q/fT4DI2PpTXAiltUTR/XVjREqwO4slGSz1
	Q3r3HZi14ym5n+lX35oXpA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1736508731; x=
	1736595131; bh=UNnGfgGf7tZwpczUFQXyQa9fnyCCAfZMw9aJVyVxYRQ=; b=b
	AIlRbxzU8tjcKhWDUOvrFkwM2TbJvT6/MpUiPn32kzoe3kvEi100yj7arklEfedr
	KrVb/VCwRiKUY5jTK60oUmzDC2aLMQZ+HPFNVg+oqQaOMfozg7YqDJAU1igLk/iQ
	nq6XmDmG3xYvzw+k9qMXUUQ6Orn7RS6wFa2fhp4kV90o9oXrtg6CIkJFzY4u5lUH
	2QYZQtkw0+UJvCh8sauJFhbelWBkeOswR6+x6qBfddZPsBE6ZZn/wfgNGeW6vwp3
	syi03qTLSeGeSYXFgJeiQkJqIUxxpUKaZP+JYJI75l+3ugIKZgPdDXLVqvgfiHyr
	CeFxhkR3JXIVJgje3XIyw==
X-ME-Sender: <xms:OwWBZ5Aoq5Mu32MjoEeNTWsmCTH5OKKxcrkavzea9SQjJ8FwFTm4uQ>
    <xme:OwWBZ3jBBzPqEWWvT2N0GRP4oXF6I4DcnjoP127pM5IaKyHjBT9SJVPdrXzJ6lXHj
    sFpdFyPTaWmGm1AsQ>
X-ME-Received: <xmr:OwWBZ0mIHxTkgd5m_gCzintbyFzH5h7hS65fUvkj7XEP1yaVGin9eZ0YzIpj-b0Payr4zw25aj8vV8H4aUSrUC99qoQnK9m3q2EbihvAhGbMaQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudegkedgvdelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdej
    necuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrih
    hmqeenucggtffrrghtthgvrhhnpeffueeiudejvdekheeuvdekfeffiedvueelteekudeh
    jeetkeegvddugfdtgfeileenucevlhhushhtvghrufhiiigvpedunecurfgrrhgrmhepmh
    grihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeegpdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopehpvghffhesphgvfhhfrdhnvghtpdhrtghpthhtoh
    epghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehgihhtshhtvghr
    sehpohgsohigrdgtohhmpdhrtghpthhtohepphhhihhllhhiphdrfihoohguseguuhhnvg
    hlmhdrohhrghdruhhk
X-ME-Proxy: <xmx:OwWBZzwJDhyvpvgp_T6f5uNvWv0K7_bOSCQfsl-CeYykk5O-Bv5_lQ>
    <xmx:OwWBZ-Sa2VUjmYwQMvNq5fpdJzL6JLuJZ6LZed3_EYHxhAzJWZlUaQ>
    <xmx:OwWBZ2Zn5hF2Q6sI_shkNqnxXfUbwq1jOIabTOXyeU0-8G-cqnZDEw>
    <xmx:OwWBZ_Q7pdjR935Gem1S1MtChxRBOhALB4-83mXaEfcPLvqGyaXreA>
    <xmx:OwWBZ0PVvhik8mop4zAnAYSILX8y-aULeNXFcQNcFTUzUqQp9N6yzPFQ>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 10 Jan 2025 06:32:10 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 5b306949 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 10 Jan 2025 11:32:09 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Fri, 10 Jan 2025 12:32:06 +0100
Subject: [PATCH v4 10/10] ci: remove stale code for Azure Pipelines
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250110-b4-pks-ci-fixes-v4-10-6e4613446080@pks.im>
References: <20250110-b4-pks-ci-fixes-v4-0-6e4613446080@pks.im>
In-Reply-To: <20250110-b4-pks-ci-fixes-v4-0-6e4613446080@pks.im>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>, 
 Phillip Wood <phillip.wood@dunelm.org.uk>
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
2.48.0.rc2.279.g1de40edade.dirty

