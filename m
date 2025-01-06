Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D811B1DD525
	for <git@vger.kernel.org>; Mon,  6 Jan 2025 11:17:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736162225; cv=none; b=b6gOE7HxoK+3OW5D/kzjt0zgoR6hoijdTkzKUeaXoQsDwv5+hLo3s/cmL5Fe10w8bl1GTfgH6HUvtkOFmftha/8Yy9ugpnpUYpSH4241+sH4syL0nymYcn/ZQYdNYmApcncgG76QemQzhe553nUDOp7N1iE/zS2udqLYkBnvALc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736162225; c=relaxed/simple;
	bh=G1jPa7P7T6TB45XoieFsgxr0j8yLEOJJZo63ewbJ3M4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=cQa1vKqv+x35NzqBfX1x99n29O2+QHAniCJHyNn1OqIBIRbmgtvsG6fIiMK2/tFFjpSEswbE4VpSAAJZXR67hODZKKCnHJUCxmWPlLPnPOAYV1OIPqkmZW8mrghEAddvqPJFFEhND3/ot22Jz45B3Wzh5YFTQHTHhVgBcuk254c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=ACrETiF0; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Vz/fgQfN; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="ACrETiF0";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Vz/fgQfN"
Received: from phl-compute-09.internal (phl-compute-09.phl.internal [10.202.2.49])
	by mailfout.phl.internal (Postfix) with ESMTP id 87AF413801B6;
	Mon,  6 Jan 2025 06:17:01 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-09.internal (MEProxy); Mon, 06 Jan 2025 06:17:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1736162221;
	 x=1736248621; bh=KyOeinV6oJzx1SRviha9PF63/S2bm6rWc2/2k4n1LGg=; b=
	ACrETiF0keg2tLCMCk8HPnLgAPNY2HNq8dyKJSsU1GaEKRanqRFNrOQ2OrKnukso
	4XEdPKcJPjHzdOpkgMnQmTXEWuY4OsnUCH1MCR5AoEWP7Ds4WHLkKLOJsLdOMe5c
	BISFa8dkBo+QqCBY2aVETdXnqzj/bodCC46Or+6z3ekXPLk0lo/JxBp05V7Yol8k
	uEsotgVpm2LBPXPzcVC8GWXVE4xRFxlV4CpRNeRHyFge125DolMitT00lzX3+I1f
	EXw4MCsOFBTLyi6WbdIH6+O9Jcx/NSqcMT7OkOkLZubrG5gxvSE9LK2na005Yr35
	bSfVcDuPRITBsheHhj/VjA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1736162221; x=
	1736248621; bh=KyOeinV6oJzx1SRviha9PF63/S2bm6rWc2/2k4n1LGg=; b=V
	z/fgQfNeY6LCknkfrNeeY5DoWjydRtsXuJv42eD0ciDMbpQN9qEgPUWcvURlIHdU
	eqsAplKm2/jwvKMAMl9BhYJHQ36/YGXNZmsVxkrzVtt4E/Q/skX7fa9X6rPOrfnm
	HrrlovEDPxdTD9e1izQpAHFH33DeyNjOadNNSqDHKXbs1i3Dtt5CaL7AV3/s/P7i
	cHuOCYUpQOLQFiHx1/98M8DuyyMe1GPM0nM5qGujFhqDhalkar/V007HTqal+qo0
	JzgYIuY22ELfjXVUg505iktx8NfGN+bxkc8iKKP2B0pAQQA/DXcTNxDUnKUoDgOy
	k0SOibFZ7AsjfougGFsPg==
X-ME-Sender: <xms:rbt7Z2ysSqwa_KzYO0CQ3dV-4mmVasK6TJaXKra97HIBoaKWoL4u4Q>
    <xme:rbt7ZySOOlZVFL_8s6qEd_Cl8qdIu52EewY72WATF43y2ihBuxS-5fW70LPwsueSE
    wZ05RsC13SJO8F2TQ>
X-ME-Received: <xmr:rbt7Z4U1M4v_gZ5GG0HNAIPHw6Yb0QxHamH0DVgX_f1PWlEocAyWGPrYVmbzY5aryv-mzC6VzTRawbhd0kMZNWfc3cU3AD5Pa7_B0daF2u98Pw>
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
X-ME-Proxy: <xmx:rbt7Z8izYjgGsq9YxAFCVYjlpQDQ8DDGw_AjUCHQfxDWPKv4B9NNwg>
    <xmx:rbt7Z4AAMBjzVH96J9d9TXsp9jTDpCr5hAAi1YAPBJXDG3SPMgSh7w>
    <xmx:rbt7Z9LSyWMBrbE8KRKm8o1W3R9JKwwQtHYiuwLBlovXtGzPNDL-Xg>
    <xmx:rbt7Z_AAjbiCUFJPtagcV9lxplTkWLcKp693brL-1wZIVnNyIu-2nw>
    <xmx:rbt7Z7MA9wLokwDlCrmSulK09scyt1TxoJkeVYnFwajpvIW41Nn265Bf>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 6 Jan 2025 06:17:00 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 1b42f77c (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 6 Jan 2025 11:16:59 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Mon, 06 Jan 2025 12:16:58 +0100
Subject: [PATCH v2 09/10] ci: use latest Ubuntu release
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250106-b4-pks-ci-fixes-v2-9-06ae540771b7@pks.im>
References: <20250106-b4-pks-ci-fixes-v2-0-06ae540771b7@pks.im>
In-Reply-To: <20250106-b4-pks-ci-fixes-v2-0-06ae540771b7@pks.im>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
X-Mailer: b4 0.14.2

Both GitHub Actions and GitLab CI use the "ubuntu:latest" tag as the
default image for most jobs. This tag is somewhat misleading though, as
it does not refer to the latest release of Ubuntu, but to the latest LTS
release thereof. But as we already have a couple of jobs exercising the
oldest LTS release of Ubuntu that Git still supports, it would make more
sense to test the oldest and youngest versions of Ubuntu.

Adapt these jobs to instead use the "ubuntu:rolling" tag, which refers
to the actual latest release, which currently is Ubuntu 24.10.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 .github/workflows/main.yml | 14 +++++++-------
 .gitlab-ci.yml             | 14 +++++++-------
 2 files changed, 14 insertions(+), 14 deletions(-)

diff --git a/.github/workflows/main.yml b/.github/workflows/main.yml
index b54da639a650682495994e3c7b137eab4e6cb3bf..b90381ae015edf9db5aa4b8c0ace9bb5c549c37b 100644
--- a/.github/workflows/main.yml
+++ b/.github/workflows/main.yml
@@ -314,10 +314,10 @@ jobs:
       matrix:
         vector:
         - jobname: linux-sha256
-          image: ubuntu:latest
+          image: ubuntu:rolling
           cc: clang
         - jobname: linux-reftable
-          image: ubuntu:latest
+          image: ubuntu:rolling
           cc: clang
         - jobname: linux-gcc
           image: ubuntu:20.04
@@ -328,19 +328,19 @@ jobs:
           cc: gcc
           cc_package: gcc-8
         - jobname: linux-gcc-default
-          image: ubuntu:latest
+          image: ubuntu:rolling
           cc: gcc
         - jobname: linux-leaks
-          image: ubuntu:latest
+          image: ubuntu:rolling
           cc: gcc
         - jobname: linux-reftable-leaks
-          image: ubuntu:latest
+          image: ubuntu:rolling
           cc: gcc
         - jobname: linux-asan-ubsan
-          image: ubuntu:latest
+          image: ubuntu:rolling
           cc: clang
         - jobname: linux-meson
-          image: ubuntu:latest
+          image: ubuntu:rolling
           cc: gcc
         - jobname: linux-musl
           image: alpine:latest
diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
index 29e9056dd5010f8843e42aeae8410973c825de54..8ed3ff5f0373d70b6f609dc5292dda2dd7fd8f88 100644
--- a/.gitlab-ci.yml
+++ b/.gitlab-ci.yml
@@ -37,10 +37,10 @@ test:linux:
   parallel:
     matrix:
       - jobname: linux-sha256
-        image: ubuntu:latest
+        image: ubuntu:rolling
         CC: clang
       - jobname: linux-reftable
-        image: ubuntu:latest
+        image: ubuntu:rolling
         CC: clang
       - jobname: linux-gcc
         image: ubuntu:20.04
@@ -51,16 +51,16 @@ test:linux:
         CC: gcc
         CC_PACKAGE: gcc-8
       - jobname: linux-gcc-default
-        image: ubuntu:latest
+        image: ubuntu:rolling
         CC: gcc
       - jobname: linux-leaks
-        image: ubuntu:latest
+        image: ubuntu:rolling
         CC: gcc
       - jobname: linux-reftable-leaks
-        image: ubuntu:latest
+        image: ubuntu:rolling
         CC: gcc
       - jobname: linux-asan-ubsan
-        image: ubuntu:latest
+        image: ubuntu:rolling
         CC: clang
       - jobname: pedantic
         image: fedora:latest
@@ -69,7 +69,7 @@ test:linux:
       - jobname: linux32
         image: i386/ubuntu:20.04
       - jobname: linux-meson
-        image: ubuntu:latest
+        image: ubuntu:rolling
         CC: gcc
   artifacts:
     paths:

-- 
2.48.0.rc1.245.gb3e6e7acbc.dirty

