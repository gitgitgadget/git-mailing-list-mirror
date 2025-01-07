Received: from fout-a5-smtp.messagingengine.com (fout-a5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 755371E9B33
	for <git@vger.kernel.org>; Tue,  7 Jan 2025 12:30:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736253059; cv=none; b=Al7+2jgczVDING+AuZ9obMlGTfBjnGEqlqABRapo/Ocnq4VYsS6f+5cgCtIM6JnQb0Oi6Vh8YeasUmgzCmvfHSlDRsNAFFASxYn6eADVaY0LUTZwhqtqhFMVutfvSDJgIaI9rfsKwEmwv55M43vMlYL4z6GiEp3XcW5CuYOAavQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736253059; c=relaxed/simple;
	bh=C0kXd14tdNh+8BNpjH8s+KCeED16IX9F4AoXIgQhyns=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=L4tneusb2USZpHnHU2nOCdkSdtTZwQbT4AWfI1htoySYsMjtLqAuMEvJ79XX7IQkB+cM25X1uZTZmZuPKpuuEb892YnKA0kHFdhkZc8UCYhH8UhtokIlaC7kc+wv45zL5L/h1bHvghRYQa6U+mYpVV3YFnd6WA3CKsdMCedT2tE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=kTDAD1t4; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=HPdd2LsS; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="kTDAD1t4";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="HPdd2LsS"
Received: from phl-compute-09.internal (phl-compute-09.phl.internal [10.202.2.49])
	by mailfout.phl.internal (Postfix) with ESMTP id 7531A13802B8;
	Tue,  7 Jan 2025 07:30:54 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-09.internal (MEProxy); Tue, 07 Jan 2025 07:30:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1736253054;
	 x=1736339454; bh=G93ybn4njs+YzJYt3Ui15723ZMuJLM+1PFmip4yBuPs=; b=
	kTDAD1t4rjVHz/bgrLIPQSIJVpEGcp1GpkO9m6uC+27OsZFODP1RYQIKFxuNk4nS
	CuLpEz9vZ8251ObZvXd+sCrro/ir+1muKaL06phvJluc0oCeDHD59S2gBzssjx0p
	VvkTyAQ8xGuSqegMbiSe9aGfkncRO8l0x8N4ilRRIYuqqcM0IIHQZmh4TEZ6a7hN
	DAxo80azUoyPNsUte8uhcaSd/cexlrrlIx9Wo4M4Uz4qjgUHGnhHT0b6DHppJbFe
	nsPd0ropAv4WmldEopb6v6ySwBS10TpkKqROEBZI48m3ARq5zJUCPWNBHlQInXuV
	1SJlFCNXqZjhFKvUWP91Iw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1736253054; x=
	1736339454; bh=G93ybn4njs+YzJYt3Ui15723ZMuJLM+1PFmip4yBuPs=; b=H
	Pdd2LsS4eX2mWXMFwPRjgkm+caNFfEi5SJCtsgLH7F3pEMApxrvhppBrR/cZ8esW
	lYNfGoDPHLaqhQNxECAMyRWzhfY1XJiCTLVuGl6WHhE5fnyOTSysJVmi7Qsb2K47
	5hzNCmU0M/FX2x+8UuGCuddlZeYtV1azuYsh8GGGF4dRw1JdYvdC9OAOgw0Vq3OY
	rPdVG11cIwDvreSniGwMzIgGpOZWMK6HsbOdBiBENz+lu7tiJ0xAHiGIdS6TFwbW
	DHVHjsioTn8JC5SL5sbuL1fGgyd04hM6+J5KWEs0oiDW7xw8omLzVVtk1Aa2GHks
	w/+nZxHj51D2YDVeNW19Q==
X-ME-Sender: <xms:fh59ZxH6YGp8ECR5Yk2MdqpsnZzDJ0CwmRVaHiohrOSeYZ_oXcZ5sA>
    <xme:fh59Z2Xbl_mgE4h7NWCgZ4Wx2qpgTyVrxElyjE943-eboM3G-LG6IzBJy64Z5SER-
    whmNLMRqLr8KxnCvA>
X-ME-Received: <xmr:fh59ZzKAQYMZ35BVmRHL3zVSU3nyT_AAGFpINULKNmJnrNYQlo3DRuINA3hFGWWT9npYea5NI9qOrkUHHS_3mzbyJJJ1xLAjaHiqbbgkdRET_g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudegvddggedtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdej
    necuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrih
    hmqeenucggtffrrghtthgvrhhnpeffueeiudejvdekheeuvdekfeffiedvueelteekudeh
    jeetkeegvddugfdtgfeileenucevlhhushhtvghrufhiiigvpedunecurfgrrhgrmhepmh
    grihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeegpdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopehphhhilhhlihhprdifohhougesughunhgvlhhmrd
    horhhgrdhukhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhr
    tghpthhtohepghhithhsthgvrhesphhosghogidrtghomhdprhgtphhtthhopehpvghffh
    esphgvfhhfrdhnvght
X-ME-Proxy: <xmx:fh59Z3HtC4uU_cXS_UMDd2opTGtXzx0fE6DrNzxZuNhfrzWVFT4fnw>
    <xmx:fh59Z3Vj1wkukz07mfGf8JgzhzFI6kDx_rDRQDXcpYm1Wn8Lkspg_g>
    <xmx:fh59ZyMT01osDLgotN32JmFLeWUNXYJPFru8z6SxWrX8e462krCZIw>
    <xmx:fh59Z20p8r-f1JuqEdxBXERw8LJAiF5lElDRTuOjPuYj-8HTRQb_dQ>
    <xmx:fh59Z9yYpCoOkx-fA0AwAV5kUEafFA8iwp3aETUz8wrbhRqv0mTfJyYV>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 7 Jan 2025 07:30:53 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id c07dc959 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 7 Jan 2025 12:30:53 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Tue, 07 Jan 2025 13:30:52 +0100
Subject: [PATCH v3 10/10] ci: remove stale code for Azure Pipelines
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250107-b4-pks-ci-fixes-v3-10-546a0ebc8481@pks.im>
References: <20250107-b4-pks-ci-fixes-v3-0-546a0ebc8481@pks.im>
In-Reply-To: <20250107-b4-pks-ci-fixes-v3-0-546a0ebc8481@pks.im>
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
2.48.0.rc1.245.gb3e6e7acbc.dirty

