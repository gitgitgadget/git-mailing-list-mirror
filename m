Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 198461DD889
	for <git@vger.kernel.org>; Mon,  6 Jan 2025 11:17:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736162226; cv=none; b=KuXHgWwbZgkoE/BcQRtwIIQ9Lp5gMeWsm848UCz6BtSPV5V9bttlNDiwlCr0N11nbh9TjsrMWMHNroSfmbQvyrOYil6yZeM70docqaJ6K9IY8v8p7HilcQUGgmMxmLwdb6ZzIF3bQdQyioS5eenD4iYonAsO7ygLxo+lW/BkyWc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736162226; c=relaxed/simple;
	bh=C0kXd14tdNh+8BNpjH8s+KCeED16IX9F4AoXIgQhyns=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=RS8jMagD88jgscYCXN5g3URsp1DmTQQoKRWj7NlmdM/nZLIocvjA2XX+FZS+UJCmSGqpOIUKq1nG5VwFTDTPrjYjtcNsvVn+cM/1C96Ztlh/8D9y3uZQNhNSAh66O753yYPg3yIaWW9SfdeUMHbUzMkJ+RjZjyLI3l0yGOltDis=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=S84yzwPW; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ANKZhvCB; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="S84yzwPW";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ANKZhvCB"
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfout.phl.internal (Postfix) with ESMTP id 9CE6D138091A;
	Mon,  6 Jan 2025 06:17:02 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Mon, 06 Jan 2025 06:17:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1736162222;
	 x=1736248622; bh=G93ybn4njs+YzJYt3Ui15723ZMuJLM+1PFmip4yBuPs=; b=
	S84yzwPWk1GmH1ktVHBMMF/0LOakFZFQlHQ3zwCXu7t+WYYZwTyxVcYx6mQy57BR
	2xxluOiID8i7QZfZeFXQBO1m0pPqzo3AWjMYQFfcC2FA3Ly5U+FHgeY1K8/HhTvY
	9yPHXjXifxzA2DQ4WEaKa3I00u14Qqwvp66O4mxaJEq+rgpYNM94WWYN5I9jJsWt
	fasrOPokCrz5WqiQDxIm2gUgLFTGWPECg0MLmn9ualaJbI8dOnrLdCp56SO4YIVM
	2TwxulRhEo37El4gfJ2fAGta/IXlanmiW8RuGItizcSbZLL7sQgtB4WQOJEmGQhh
	Lz7Dei7Z/iUkSAyCZzlLYg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1736162222; x=
	1736248622; bh=G93ybn4njs+YzJYt3Ui15723ZMuJLM+1PFmip4yBuPs=; b=A
	NKZhvCBbzHypr5dHI30I71b14mk1xgyWNnqlby8twrsK0afPtoTYekTXpvGR3Snn
	K1uLxpQxHfe5+9SzpROFY2zaXsoc+BfSY+IEXDpv3kNORn9eLHgcUaD30u1kk5tx
	TS9gzwBQ4v67J0raob873HAdqJP/aDDmOZHakDKhXjLdKbyTKIEgd07NILZksQLn
	+ceZ8A/Pa69Y8TYw/dMxWYw39KxT4owxYtJ2Aq/qfdDCm2Iyf7vJuEjcTG4I8A/v
	ObEVKa98ZusIE99cfgpB9AKIfu/5ajRQ3ZWll5T8U0qB9ozPlwAcuiVled4K5Oj9
	rUHj1erTNnIAgN9VU4m7g==
X-ME-Sender: <xms:rrt7Z-Diq7TCDv2EavnAqVa-kPMiioElYsZnTFlhPjviLMManW7IZw>
    <xme:rrt7Z4j1eglGJ-pjQ3K8KrTAQ8JrVG5Wn2dmnpQyh62K5Gaq1NP22xVvhJCfhGe9I
    gNU5bfThaw0Dnny2w>
X-ME-Received: <xmr:rrt7ZxkTs8JqXwyn0zHQU1tgi4Loq3wF8ixa0kDgxqQ0XJZcbx46u0T0UIF-ZuzJbtTy68ZCZipK3s9FVhyH3OoQ3TdPG1dk7OqI_cTZ7bGLeg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudegtddgvdeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpefhfffugg
    gtgffkfhgjvfevofesthejredtredtjeenucfhrhhomheprfgrthhrihgtkhcuufhtvghi
    nhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnhepffeuieduje
    dvkeehuedvkeefffeivdeuleetkeduheejteekgedvudfgtdfgieelnecuvehluhhsthgv
    rhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnh
    gspghrtghpthhtohepfedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithhs
    thgvrhesphhosghogidrtghomhdprhgtphhtthhopehpvghffhesphgvfhhfrdhnvghtpd
    hrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:rrt7Z8wDV1fjTsuhC8xgPmbI46vKYEzcyzzR48ZOUV66gYWwEiF1tg>
    <xmx:rrt7ZzSqyQEKERv-a8hglAbdkeCDlSjH_HqerE6ztzZCWDcTmXGbpw>
    <xmx:rrt7Z3bMnnLA6DYEdcNXiOB73U1gcLTCfDkr4WrIyY4vd_KrBF9s9A>
    <xmx:rrt7Z8SjtLxGHt0syvju8cbnw8580Bo_nAUuLDGn0kLOz3sIDCdFzg>
    <xmx:rrt7Z9cKLCSKh7Esh6rft4E5R5Zk7-U2Hx8HgC-_qJi-eFAkKLUkhGbV>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 6 Jan 2025 06:17:01 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id eeb9c26e (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 6 Jan 2025 11:17:00 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Mon, 06 Jan 2025 12:16:59 +0100
Subject: [PATCH v2 10/10] ci: remove stale code for Azure Pipelines
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250106-b4-pks-ci-fixes-v2-10-06ae540771b7@pks.im>
References: <20250106-b4-pks-ci-fixes-v2-0-06ae540771b7@pks.im>
In-Reply-To: <20250106-b4-pks-ci-fixes-v2-0-06ae540771b7@pks.im>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
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

