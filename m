Received: from fout-a5-smtp.messagingengine.com (fout-a5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80E851E0DE2
	for <git@vger.kernel.org>; Tue,  7 Jan 2025 12:30:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736253057; cv=none; b=HAvARkPHYZLsgjSVJ8++thyqQiRTzrCCVX/ZhZwX4WbbicLfo/JMLIz5Wj9PIjsHau/4Tx3bRjJ405ZoFEFlKXcBRNK0gRq/izDw6kNLlckTFJjQq0RIK5Q5D9tbEo0Ag0289aoIfPtaA4gm8Wc2CXrQ4K3+TDTiKmfQeA81PyU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736253057; c=relaxed/simple;
	bh=iXUBghgz+jqbZeF0ZZx009F8BYBVHP+9neCovN2CvvI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Ol9e6T5JVcaQYltMKJpIFxWQ1V7qAVnk7p57efx2F0NnGDVyOXZgmv2rcif2sNv0yddCvIp3Gl4j7HWrZML042xJtDSiNHqDUI+YpNYePBmltYBch7fR2qxKy25PIgyA5jLmgno4ogmTBjWVSpeZhLNfxT7OGwru/FI+kUwtYrY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=apAeYUGZ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Z57Quv/R; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="apAeYUGZ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Z57Quv/R"
Received: from phl-compute-09.internal (phl-compute-09.phl.internal [10.202.2.49])
	by mailfout.phl.internal (Postfix) with ESMTP id 774DB13802BF;
	Tue,  7 Jan 2025 07:30:50 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-09.internal (MEProxy); Tue, 07 Jan 2025 07:30:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1736253050;
	 x=1736339450; bh=TXisYeudCbnuQitwymqpMqWl6wW3MJ+qGP3Juusa0jQ=; b=
	apAeYUGZdNWHh0URAmsxRj9W7x9HfKKE+ntmePJVJbwcIkQukRZoUyU85uiHPibf
	iifCHHfGm++chS3HUtvKFK6b89/7mCfygPbHOQoettUOa5XOilWCmE3OuyEwmAr3
	JETHVncZHsLcSmaCPsMTqyA1ESOE+sHL45bj8x3/YUFlMotO4SG6JfQDN/OW66xZ
	RJ9KObDO4LhaCrmbQV1n35vHqmhgxluIlK4ARYEn2qPpFe8o/aWwFH0hzYKc8AZg
	j1hPVhwDJ7XMdHSLt04aWnd1PNxspvgoSavMiyDPTinv+mq7S7vZFRoOxyhdc7+f
	XQN0IQfeSxSFTWZAHcfFOw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1736253050; x=
	1736339450; bh=TXisYeudCbnuQitwymqpMqWl6wW3MJ+qGP3Juusa0jQ=; b=Z
	57Quv/RVBIfmaVFmvARqGndKWK7u/LY+6bAJtdMigTJkH0NpV0ct3+G9PiLqXbQ/
	HO0qXptJGCNuqo8fqZJmyW6BaRtHoUi60U1iGQ/1nwioiasSBogtvCbhIcDf9JZv
	Yy3fW7Qyl503cN5BJ0axDOXgohqFDa1uFWxwB8wayTFx179PqY6xeSFvROnmTUH4
	7fvQl6nxiw5rBBEhSGYKOh+ifUbPviWnpuw230ll64O6tZuT2S5MYxvHcGSHlPeD
	VB87Wz9ILoX1yyaYVLUfVxhAqzbodUtMz6mzv/R1uvprVut5UiDNcg0A08QIw4Fc
	vsuQrBOS8gxUseZ/e1b/w==
X-ME-Sender: <xms:eh59Z7VXwds7h5OomZ5BR7MzQnfEB9tCxu3RPaIMqNbKyj-3uUoQSQ>
    <xme:eh59ZzkS8V46hh84Z8vSJyjficeLHno7wAjQHZW0Qc5mfl8j-eZFJKgVqzpmtn_Fg
    TtqOuvR0R2iSd8tSg>
X-ME-Received: <xmr:eh59Z3ZQ8DTzFk7XgtdF5a9LQoeDAHHargBwUnVhaYUoMnP4VPRsZGaN2lxwz0J9HKWmtnP0tZJtraqQC7hhhMgciSGxtT3pafSX8sEJde-bmA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudegvddggedtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdej
    necuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrih
    hmqeenucggtffrrghtthgvrhhnpeekvdeufedujefhudehudekfeekvedtvdduvdefvefh
    ffeuvddtkeffvddttedtkeenucffohhmrghinhepkhgvrhhnvghlrdhorhhgpdhvvggtth
    horhdrtggtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhho
    mhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepgedpmhhouggvpehsmhhtphhouh
    htpdhrtghpthhtohepphgvfhhfsehpvghffhdrnhgvthdprhgtphhtthhopehgihhtsehv
    ghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepphhhihhllhhiphdrfihoohguse
    guuhhnvghlmhdrohhrghdruhhkpdhrtghpthhtohepghhithhsthgvrhesphhosghogidr
    tghomh
X-ME-Proxy: <xmx:eh59Z2WyRzhbQFosAzkGBXpotWGm1JvlJxJ5AO8IDuVF28FPmH-kzg>
    <xmx:eh59Z1l3Lah769Y-JR-C_jQE6yh7mORUcIKtJYXRzwrnuRVbWaIQ5A>
    <xmx:eh59ZzdjiClXofpDy3WRWp1mfKYfDOisTpTdTQOxkzmGXbTw7jBfMA>
    <xmx:eh59Z_E5h9NkLz1tbzrkVJn-d5_BsK5RK6CY6T2PJpcCWJ3JL1V20Q>
    <xmx:eh59Z-C1MaUfvvjXitJy7hdMsIGEqlkxv_zGHYIcnCeGGK4g-obCGNQO>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 7 Jan 2025 07:30:49 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id faf217cd (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 7 Jan 2025 12:30:48 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Tue, 07 Jan 2025 13:30:46 +0100
Subject: [PATCH v3 04/10] github: convert all Linux jobs to be
 containerized
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250107-b4-pks-ci-fixes-v3-4-546a0ebc8481@pks.im>
References: <20250107-b4-pks-ci-fixes-v3-0-546a0ebc8481@pks.im>
In-Reply-To: <20250107-b4-pks-ci-fixes-v3-0-546a0ebc8481@pks.im>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>, 
 Phillip Wood <phillip.wood@dunelm.org.uk>
X-Mailer: b4 0.14.2

We have split the CI jobs in GitHub Workflows into two categories:

  - Those running on a machine pool directly.

  - Those running in a container on the machine pool.

The latter is more flexible because it allows us to freely pick whatever
container image we want to use for a specific job, while the former only
allows us to pick from a handful of different distros. The containerized
jobs do not have any significant downsides to the best of my knowledge:

  - They aren't significantly slower to start up. A quick comparison by
    Peff shows that the difference is mostly lost in the noise:

            job             |  old | new
        --------------------|------|------
        linux-TEST-vars      11m30s 10m54s
        linux-asan-ubsan     30m26s 31m14s
        linux-gcc             9m47s 10m6s
        linux-gcc-default     9m47s  9m41s
        linux-leaks          25m50s 25m21s
        linux-meson          10m36s 10m41s
        linux-reftable       10m25s 10m23s
        linux-reftable-leaks 27m18s 27m28s
        linux-sha256          9m54s 10m31s

    Some jobs are a bit faster, some are a bit slower, but there does
    not seem to be any significant change.

  - Containerized jobs run as root, which keeps a couple of tests from
    running. This has been addressed in the preceding commit though,
    where we now use setpriv(1) to run tests as a separate user.

  - GitHub injects a Node binary into containerized jobs, which is
    dynamically linked. This has led to some issues in the past [1], but
    only for our 32 bit jobs. The issues have since been resolved.

Overall there seem to be no downsides, but the upside is that we have
more control over the exact image that these jobs use. Convert the Linux
jobs accordingly.

[1]: https://lore.kernel.org/git/20240912094841.GD589828@coredump.intra.peff.net/

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 .github/workflows/main.yml | 68 ++++++++++++++++++++++++++--------------------
 1 file changed, 39 insertions(+), 29 deletions(-)

diff --git a/.github/workflows/main.yml b/.github/workflows/main.yml
index b02f5873a540b458d38e7951b4ee3d5ca598ae23..8e5847da4fab009ad699c18e1a5a336a8b45c3ed 100644
--- a/.github/workflows/main.yml
+++ b/.github/workflows/main.yml
@@ -259,20 +259,6 @@ jobs:
       fail-fast: false
       matrix:
         vector:
-          - jobname: linux-sha256
-            cc: clang
-            pool: ubuntu-latest
-          - jobname: linux-reftable
-            cc: clang
-            pool: ubuntu-latest
-          - jobname: linux-gcc
-            cc: gcc
-            cc_package: gcc-8
-            pool: ubuntu-20.04
-          - jobname: linux-TEST-vars
-            cc: gcc
-            cc_package: gcc-8
-            pool: ubuntu-20.04
           - jobname: osx-clang
             cc: clang
             pool: macos-13
@@ -285,21 +271,6 @@ jobs:
           - jobname: osx-meson
             cc: clang
             pool: macos-13
-          - jobname: linux-gcc-default
-            cc: gcc
-            pool: ubuntu-latest
-          - jobname: linux-leaks
-            cc: gcc
-            pool: ubuntu-latest
-          - jobname: linux-reftable-leaks
-            cc: gcc
-            pool: ubuntu-latest
-          - jobname: linux-asan-ubsan
-            cc: clang
-            pool: ubuntu-latest
-          - jobname: linux-meson
-            cc: gcc
-            pool: ubuntu-latest
     env:
       CC: ${{matrix.vector.cc}}
       CC_PACKAGE: ${{matrix.vector.cc_package}}
@@ -342,6 +313,44 @@ jobs:
       fail-fast: false
       matrix:
         vector:
+        - jobname: linux-sha256
+          image: ubuntu:latest
+          cc: clang
+          distro: ubuntu-latest
+        - jobname: linux-reftable
+          image: ubuntu:latest
+          cc: clang
+          distro: ubuntu-latest
+        - jobname: linux-gcc
+          image: ubuntu:20.04
+          cc: gcc
+          cc_package: gcc-8
+          distro: ubuntu-20.04
+        - jobname: linux-TEST-vars
+          image: ubuntu:20.04
+          cc: gcc
+          cc_package: gcc-8
+          distro: ubuntu-20.04
+        - jobname: linux-gcc-default
+          image: ubuntu:latest
+          cc: gcc
+          distro: ubuntu-latest
+        - jobname: linux-leaks
+          image: ubuntu:latest
+          cc: gcc
+          distro: ubuntu-latest
+        - jobname: linux-reftable-leaks
+          image: ubuntu:latest
+          cc: gcc
+          distro: ubuntu-latest
+        - jobname: linux-asan-ubsan
+          image: ubuntu:latest
+          cc: clang
+          distro: ubuntu-latest
+        - jobname: linux-meson
+          image: ubuntu:latest
+          cc: gcc
+          distro: ubuntu-latest
         - jobname: linux-musl
           image: alpine
           distro: alpine-latest
@@ -363,6 +372,7 @@ jobs:
     env:
       jobname: ${{matrix.vector.jobname}}
       distro: ${{matrix.vector.distro}}
+      CC: ${{matrix.vector.cc}}
     runs-on: ubuntu-latest
     container: ${{matrix.vector.image}}
     steps:

-- 
2.48.0.rc1.245.gb3e6e7acbc.dirty

