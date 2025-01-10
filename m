Received: from fhigh-a5-smtp.messagingengine.com (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5328B202F87
	for <git@vger.kernel.org>; Fri, 10 Jan 2025 11:32:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736508732; cv=none; b=IYn/eu8QeCeoBE9ad6ZxIY9lfrfQSrhZOVO6bUVq/ZMo7tcPqHFm6jFSwK3nGGeuK1HuDXP2RGcwWfmSPFFKM2ycF44E26Jb1EhGIYgRDFlOWHz9edKSDkR02oLhUVwv8bAuM81Aorg2uyTVc0iCNGIQtxZHShNHs9rfdI+Fn0c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736508732; c=relaxed/simple;
	bh=Z9v7FV9val1Dknrq6cZNW1IERaZaME72DIqAuCdQFU4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=FHbY8uPZjTKCoOuxeRF0NzsRWnhiSD8kAQCKCQU5CSXUbh/99E5vlcRayHeAjqKenq9ucmITvDKvnMua+Z76lWu7NRoy9cI2RPcsX5WalbWjDeje5wPGdsbaHVGf6n8CSXhbYvK+MfAO6uPAvPa0IoCVArtEB+WOjzfgFT4iGmk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=r8pJMwzh; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=IFn3bGa1; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="r8pJMwzh";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="IFn3bGa1"
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 6286211401E4;
	Fri, 10 Jan 2025 06:32:10 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Fri, 10 Jan 2025 06:32:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1736508730;
	 x=1736595130; bh=smcIhZGUfoj6gzt8JD6fDtkOhmUKxgwmO3AlxpEGoB0=; b=
	r8pJMwzhNnSb4oYaIFjwPDjfqXY0HHSG2lO8mEDEeeicS7X6qhDppWHGl593yRDK
	P4bmH2axA+NgYdcAQrNc5tKE9YXm4KWJoRqZqK2ka+96IZDKw6V8Bp9tDbmiQU+U
	IgyhV9yILM8ndUY3C0M4GQXcNs53dIClqPsqdeOT4l7urbKnVcQMunqN74oC/fKh
	wcJgT7qIGoK8yg7HVrGQh5p4THriS3WuWoxJrfUS/nbcF5Zc+EGsiQgJYxjMO8ks
	f57nauyxEhy5TmumweheRJzW4v6gjSlALCgMaI4diSp4294HHj7sT9WJL17eNF2G
	DTSMIOmyIPI/jdOE36LQ4A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1736508730; x=
	1736595130; bh=smcIhZGUfoj6gzt8JD6fDtkOhmUKxgwmO3AlxpEGoB0=; b=I
	Fn3bGa1/HIb6JfXCdkwYsC62pOrPl6EFNYaL4bCm4eKxzmDLBFfaJQTdFbO3+eI0
	Hx1/FtoD4ISyAIJpkiK9h9A6w76K8hk3KtWG7kRJPrL0BFnCQqmtiPRTVKzYgu8m
	91aEpZhilVcnoomvsdeJSLt4kIR+MvFKqwqD3HTa10osWzgHJorNusqYFzMwV86E
	EgzZQSLhZrkWkpGhxQJkqOxx8BvacDNClxJ/VyFY8l62XroNNRe4NHAsO6vWwol9
	dQtRk6SJt5L8Rya+kc7sH1qFoC3u8xA4UF6wdb/k42+Qc3VGJo2JooxAZIl50B8U
	sGhUey1rACUuNDsEELxIA==
X-ME-Sender: <xms:OgWBZ_wzYDJnUXcGMEUfMSrjL8WS_Th4EdROf5PzqDSmLnAQ5FY7dQ>
    <xme:OgWBZ3Sm8J2i2PyN6T_D2zKHwCmYzV7iCJk6sPVslFsXQWydlIESlM8NqOsKhtGT7
    YUQe2SU7JSwP_9m7w>
X-ME-Received: <xmr:OgWBZ5VvU3eK-F_v9ipqsufcGjDabB_dCPLLmphh9pu2bk-RBBOS9czPRsEMHZFo76YBJ1UQo2ofHL_28-TYVoZAg3M_AP-9P_inm8-3KU0I7g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudegkedgvdelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdej
    necuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrih
    hmqeenucggtffrrghtthgvrhhnpeffueeiudejvdekheeuvdekfeffiedvueelteekudeh
    jeetkeegvddugfdtgfeileenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmh
    grihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeegpdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhmpdhrtg
    hpthhtohepphgvfhhfsehpvghffhdrnhgvthdprhgtphhtthhopehgihhtsehvghgvrhdr
    khgvrhhnvghlrdhorhhgpdhrtghpthhtohepphhhihhllhhiphdrfihoohguseguuhhnvg
    hlmhdrohhrghdruhhk
X-ME-Proxy: <xmx:OgWBZ5jMBR3MhyDYxuNYPMZcaouNPIF7_vViND8faglJ6GWVALKgBA>
    <xmx:OgWBZxBxrDm8jRb2wtRXV-JJntbqt8MkDygW7tItegv9t4bbyJCW1A>
    <xmx:OgWBZyIgpxdx35F1R59Z5_xQNu-wlC3UKS2zEdIuVhMK2Ti4FGLtPA>
    <xmx:OgWBZwDM_MaL9kfsyBVoeopO72-vXf6aWu7zICaaXeU57tBbfsDQhA>
    <xmx:OgWBZ8_aO3oWq-wAu3TKsFIhrc2Cdo1V5CZDdQ0610lvmentKzGVP126>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 10 Jan 2025 06:32:09 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 98ac55ea (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 10 Jan 2025 11:32:08 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Fri, 10 Jan 2025 12:32:05 +0100
Subject: [PATCH v4 09/10] ci: use latest Ubuntu release
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250110-b4-pks-ci-fixes-v4-9-6e4613446080@pks.im>
References: <20250110-b4-pks-ci-fixes-v4-0-6e4613446080@pks.im>
In-Reply-To: <20250110-b4-pks-ci-fixes-v4-0-6e4613446080@pks.im>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>, 
 Phillip Wood <phillip.wood@dunelm.org.uk>
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
2.48.0.rc2.279.g1de40edade.dirty

