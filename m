Received: from fout-a3-smtp.messagingengine.com (fout-a3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4A5D1FAC25
	for <git@vger.kernel.org>; Fri,  3 Jan 2025 14:47:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735915631; cv=none; b=J6DJk94CmNHwWq2i6AzpZFgRPL6YtXGaYPB0twUV5TJkxR9SGXX68B1OSS29cgDuvlGSpR8HGFUpz1RdMlmB0baNoGPsuSHq4zaaCkPOp1Z4Atn4Km/lUh2BNxctjAvNJYblmBzJtaRBcX0osImG9hmfyNaz2Dg2fEFwcis8pZ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735915631; c=relaxed/simple;
	bh=xUjOITySQWqaOqf6sRQ90cBGXWhHHhX3NoFqnLcWMsU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Ixc9WGSA/cyrtX8SZIasQIVbu7KccJJznwZNfHl8EX58S1FMVaAqmBhKQAQkHzXoow0qcLhoxnI9a6cTWx6P7KN5NmG1j+WhYQPVyNc3joI54EY2CzNLTSPc9JKG4IfHLYpV93L5hN0uR/ghhFhXu+IVc+xUGs6N3Swgz1K53NY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=OD/IM5wY; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=lPQjEEq1; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="OD/IM5wY";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="lPQjEEq1"
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfout.phl.internal (Postfix) with ESMTP id DDD0C13802FB
	for <git@vger.kernel.org>; Fri,  3 Jan 2025 09:47:08 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Fri, 03 Jan 2025 09:47:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1735915628;
	 x=1736002028; bh=TVqmqhbXbytaRtxSolA9amfRVnJZ1u0XvkUzzE+ceVQ=; b=
	OD/IM5wYo4YWrMN3iPkWGM22QRLmW5zIR3ttpnDt9DvTaIV99cO0ECBiLWRjn1rv
	re17AglA5oJ5SxlkngpnPrpKfGqzQRSC/RNPKVZY6hjeHYfsA/j5h2zq/nW7lqUd
	HrZMWitbb39LPQX4QnWIRSXflG1CoA6btovaTyKXps5wiTYQFXfde2vj5iAX58j4
	Y+RaM6axSp4oAFbxyXGqyAUhtwf50G/o2vuI/fh78Svy5zqDB/CLnuOO7Ggb6AOJ
	IJTWd7Vwh0EdlrSjNkA3V/tMb5kug+66iq95QuikVEH5Gu6TDUGEO3WlSbPMo5Xp
	PjVTr7nYKl4fJSpm9YAzDg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1735915628; x=
	1736002028; bh=TVqmqhbXbytaRtxSolA9amfRVnJZ1u0XvkUzzE+ceVQ=; b=l
	PQjEEq1k6Uyz/R81XoYJjYqWRvZ9qBBT8pXjiwjt1cpk1HKaAvIjHv4hzz0LQS76
	h1CmyqiPod/VNIXNR7ujzyaeuiOrFl25kj3WJ1iI0/nUvf/bIDielabUClrxZCpF
	EEtcCAEciVpxpqgsYcouSPH7FzkNAHudapFDSfkRQjgajV734LqpJrfMNtVlsG/T
	FbpgA9YkpIMDE9g7XT7Sd22fHYlcVHLqajmEp2wAtfZnGQwj2HMx+/UjTOMaBjKE
	xFTZTjUSHFvPiPSMcdNzLtFmhfdhpFtDUi6l8IJ3WVNtf0x+3VaP42DzDQmM76F1
	ilZnxv38W3RWeXIkHUQXA==
X-ME-Sender: <xms:bPh3Z_RNtm9AHYHGqy2TmRk0Eyy9QaRetKgeeg3ndXFhMSeFFS-I_A>
    <xme:bPh3ZwyFjhf8jdg_O_GP4Z79iTKEzXAdwz4klTwAlk6ZxJxHle8p9HGupdlY1So5B
    lFJmtXFA0FbB9Ihzw>
X-ME-Received: <xmr:bPh3Z03Gpxmv2gIUAU0kpYLyc57gzUN9yRvBvbtsUZFokU1vYY1VbdHm1Lq1QLGaTkXasOYPuvhskV1lBBOF4vJjdQa6DTD3u9WfvVfEoRjoHWM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudefgedgieekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucgovfgvgihtqfhnlhihqd
    dqteefjeefqddtgeculdehtddmnecujfgurhephfffufggtgfgkfhfjgfvvefosehtjeer
    tdertdejnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesph
    hkshdrihhmqeenucggtffrrghtthgvrhhnpeeggefglefgkeehvdegffelffekkeehudff
    fedvheegieegudehudekleeivedtgfenucffohhmrghinhepvhgvtghtohhrrdgttgenuc
    evlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhk
    shdrihhmpdhnsggprhgtphhtthhopedupdhmohguvgepshhmthhpohhuthdprhgtphhtth
    hopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:bPh3Z_AIeIKRuSuWmPNp-koXl0q-YOlL4mcjbmdS2vyOnWx48AnpBA>
    <xmx:bPh3Z4gyp_6EdM8cK-wRQsNH1zS7lWl02cimI-u1D82Q_HatkUbYAA>
    <xmx:bPh3ZzpQ3aqKk1eyB3Ku1PAsPgi2vrrLxp1RJCMBUehwgNjkG9oSLA>
    <xmx:bPh3ZzjWZEpW2WjmSc79mle-COWm9Rla-TaLLl5LgURP9Sdcru5oWQ>
    <xmx:bPh3Z0ZCDdUPz32BT5ZJKi8i9RJ9But1RUdfHjH8mokRTxtLxEJeYspY>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Fri, 3 Jan 2025 09:47:08 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id b73b9691 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Fri, 3 Jan 2025 14:47:06 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Fri, 03 Jan 2025 15:46:41 +0100
Subject: [PATCH 04/10] github: convert all Linux jobs to be containerized
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250103-b4-pks-ci-fixes-v1-4-a9bb95dff833@pks.im>
References: <20250103-b4-pks-ci-fixes-v1-0-a9bb95dff833@pks.im>
In-Reply-To: <20250103-b4-pks-ci-fixes-v1-0-a9bb95dff833@pks.im>
To: git@vger.kernel.org
Cc: 
X-Mailer: b4 0.14.2

We have split the CI jobs in GitHub Workflows into two categories:

  - Those running on a machine pool directly.

  - Those running in a container on the machine pool.

The latter is more flexible because it allows us to freely pick whatever
container image we want to use for a specific job, while the former only
allows us to pick from a handful of different distros. The containerized
jobs shouldn't cause a significant slowdown, either, so they do not have
any significant upside to the best of my knowlegde. The only upside that
they did have before the preceding commit is that they run as a non-root
user, but that has been addressed now.

Convert all Linux jobs to be containerized for additional flexibility.

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
2.48.0.rc1.241.g6c04ab211c.dirty

