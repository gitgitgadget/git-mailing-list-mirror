Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C4071FA24E
	for <git@vger.kernel.org>; Fri,  3 Jan 2025 14:47:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735915638; cv=none; b=dUOqG9uQE8Hwu/rmunrkbDziUpAN+79G0bpYhvbhmHwSLaGmOqfhXBuz5tarQf5LRSMnEfRc/I0bWPWWoH8X1PSl316f8WxUyFfNL5IFPSsjPRaXk4ai0bqU93ZcFyhDnzmHyGa3g95BDzxYGIB7IeziioVlW0l5Jb2OrKA6OEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735915638; c=relaxed/simple;
	bh=Sy9x2uRQOGhw34pM7H/T6FlmFGuXfG3ac/+z39jl6/g=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=YIP7W+civABaeWvR+P/5rSoNy6+DMtVMmKyaAU9qP5VpTdzr2XkdXYxBGgWTO19kKMc5w9Bk0PcoJVDD4nZyKM71iegTVhXpVC/lsrfWaEpWxN++aMflRjfXSD3PpkQ/Z7B333WXa2NdEV7rJO/AoXnEquzMSRIDLgQ0ehh2n1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=jqbOxq5T; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=tcNYJvqq; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="jqbOxq5T";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="tcNYJvqq"
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 8F843114017A
	for <git@vger.kernel.org>; Fri,  3 Jan 2025 09:47:15 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Fri, 03 Jan 2025 09:47:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1735915635;
	 x=1736002035; bh=bcDVEZTQSNn1yj5tPT96oo3OXMp6EK6q1zhc2+i1s10=; b=
	jqbOxq5Tk1F9DqkeD7HuMyzTK3l7/6AMZqudspA3SoqUfotQz4yefb+4e+ux83yP
	YXJzt4DoqzG0M7GuuASFyLM08bFHRFvooA1wxLE1MRwfVGSacC3h10ZtK15NWF16
	/I/JIbqV7RgVBIp+uX0mCciJVrzqSHKhp1JgqlZIc1kvNf+D6QsoARThseX4KgAT
	gSRKXJPQt06qY63QnYm3AHBuRYrtMDKSsat0i8WZBHzMKunGwdZeK/8iYwkom1z6
	tvRKBA82L9JgXA9VI24yq7QWps0niWPjfP2v2//5nGoGSzW70k8ZNNk5kNu/DR/x
	pEnrL4s/z7+f3Hl972OsGg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1735915635; x=
	1736002035; bh=bcDVEZTQSNn1yj5tPT96oo3OXMp6EK6q1zhc2+i1s10=; b=t
	cNYJvqqx6c+ki0gi3ES01l3ZGL7/8eoWpScYXBhLv1pcro54Zrm2+kO65yGknNdY
	rL2Bdqe4CSgk10J9dWat3czQkTP4QDMG924R0snsQY2LtvCjYO2fbC+m2kM5kTKP
	Se7RuJ4ELtyulzsBsD20eSpX+Q0GlaXbkyJA5otf0+C/U4YXbHlOnQAO9vQAtPbJ
	scf/fp00EQQRF8xzH4AVS0qD5B7HZzA1QGq7t03jVezqXlwDyoHGSIP+Kgm8Gofm
	IsvFaniwfPbV3CEJPtSqawRu4untccBMmnZLPhmgdk3dfarYbF0aFc+hReh4dbQH
	l2riGDTi4cj5YNj66j6+A==
X-ME-Sender: <xms:c_h3Zy0PvnlgO4AfvFBtGa29ASivtBg8dU3PLxJDaDU6oo830L0f4A>
    <xme:c_h3Z1EAAeMTvqX4a5AnSMC95Amrs-ju7jK2Lz3l3dfSmd3UVQFEPX5sfoEzsvhaz
    LlYbK7Sv-5T9J1XiQ>
X-ME-Received: <xmr:c_h3Z65Awg1583FS1eOTmYx9LzyPT_55tpf2dWtMImRqWA_S3TDivanQCVLpDiGwnbm5GJ56Z_bdYDS3PtuaZG-W3SlFfYT-XdzWNE6kAFQGcE4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudefgedgieekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpefhfffugg
    gtgffkfhgjvfevofesthejredtredtjeenucfhrhhomheprfgrthhrihgtkhcuufhtvghi
    nhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnhepffeuieduje
    dvkeehuedvkeefffeivdeuleetkeduheejteekgedvudfgtdfgieelnecuvehluhhsthgv
    rhfuihiivgepvdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnh
    gspghrtghpthhtohepuddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithes
    vhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:c_h3Zz1KHSuEWQ9omuaZ0td3qmVgSNR8PsjD1b7QIPItUex4Hq29QQ>
    <xmx:c_h3Z1Euqz6XKHo6xToZfCg5m-feLcARsISJbdXkSJgvKA2iA8X5Pg>
    <xmx:c_h3Z88aEux2Pt_n5RD2rPiTYtJpsLzD-INkLCBNTC6WznxvRlnt6A>
    <xmx:c_h3Z6n1PHNeysNJ8geMs1BzOrupgMALNNS7lTmkscU3LWuYd2Pcdw>
    <xmx:c_h3ZzOACnm5lyaXdbg3WB9sp7vK2_BUOE36QhyjQGDxVJFidFIm6MVT>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Fri, 3 Jan 2025 09:47:14 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 6d73591e (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Fri, 3 Jan 2025 14:47:10 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Fri, 03 Jan 2025 15:46:46 +0100
Subject: [PATCH 09/10] ci: use latest Ubuntu release
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250103-b4-pks-ci-fixes-v1-9-a9bb95dff833@pks.im>
References: <20250103-b4-pks-ci-fixes-v1-0-a9bb95dff833@pks.im>
In-Reply-To: <20250103-b4-pks-ci-fixes-v1-0-a9bb95dff833@pks.im>
To: git@vger.kernel.org
Cc: 
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
2.48.0.rc1.241.g6c04ab211c.dirty

