Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76C8120ADFF
	for <git@vger.kernel.org>; Fri, 10 Jan 2025 11:32:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736508728; cv=none; b=TIhOraiLZFZJMinkjilgHTRdHaFKI8wH3oQb7OzRcOEwodeFYGlbvuLAUcOWaMepcebyR6UFrgFJ2QkpBY0WtLqzHfRcqaRSbxu1Q7DYQpRZFyr0dORD+h6h3lsJb/nbsVMaYnv0DiEr91P5Rry9At5Ae+CK1XvARGgEixuq/6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736508728; c=relaxed/simple;
	bh=kWlnfK7pp07EH/cLMWcarrilgu0+ceR0uSlScefDUcI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=sAq/SQHMskFrTAV2NYU3yR0Dl8yYS/ugOo8YPLtQrYE/VahSblJHqtOvB8C+37iKh5s1e0YGPZKJRhC43hFVo8jwW3oEnezTQ+nAFgPjP7CF1gL6EaIf+qCaWLlFm1Dv32jYKWHu9Tys2IKj++szjQRvmMoWIkrsbC+cU65h08Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=SwiGF+YF; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Ef+9JcTj; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="SwiGF+YF";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Ef+9JcTj"
Received: from phl-compute-12.internal (phl-compute-12.phl.internal [10.202.2.52])
	by mailfout.phl.internal (Postfix) with ESMTP id 918AD1380C92;
	Fri, 10 Jan 2025 06:32:05 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-12.internal (MEProxy); Fri, 10 Jan 2025 06:32:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1736508725;
	 x=1736595125; bh=bQT56Ppy/NuGzR/tjTxvkhfeMCjU/x5QMBohq7BQdA0=; b=
	SwiGF+YF5hp2QDC61rOP9E2I8sezmsghWbyZDD7tqmZXqy4IM3KSN/zu7YuTdo+F
	cWNkQzMwTkypcNmVXbrUsR4E3bEdXr0+yvSAPgGqRABOywNqfcbQzqLXEc6qiCDV
	54p+xjolMnZQGYPc2WaMNZhFOSpHklXXEVsmYsoWwGM6AJDnLzUsu7/NhCYiL4XA
	5i9dSSYwlRlGF6ZGiZEwDBdGRMDfScPNJfE9mXJ6CS/yY3OzQAChknN7QjPQD+PD
	iJn1vbvENMuezASt1OcZyPtYdVeIkW4rPZfuPYgL1l+jblSlkgMayEhIByi987uH
	jj6RHCGM9TRwx8bGsOq8Pw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1736508725; x=
	1736595125; bh=bQT56Ppy/NuGzR/tjTxvkhfeMCjU/x5QMBohq7BQdA0=; b=E
	f+9JcTjms9ZQCYtxviQtjGxjvA02JfU5CpGkJTsyjPNxEMk7tZjmZdFj5bXo6wG8
	2/7ZOohsS1s+DQDnpzDejAQb7J+ymkdkCpyKLNbNIkdiiYS3pTEGy5u+7aG32eEN
	ecgOyNADmCH2oH8IpOQXuiWwrRpT+ak3mrmQtnutg+THB/xqU013a53G/JTW46CF
	wDgNr1tBp0dkQd5Oot2oJWCEKx5sXfOXM33Wyc6KUnDG5tnscxrJCIj59iZvXk0A
	G7pebcQRG+6NVTD4jhRVzgosHagDV3ixX+I8oQ73HZFTjGfUwf1AUlgNTtqjL/Me
	XgHAMsndLLDtzD7f13QNw==
X-ME-Sender: <xms:NQWBZ4UGuJ6YiRQ0hK9hfn-DS3qpaCcRRKHI7rxNNWzTvNqKJIODQQ>
    <xme:NQWBZ8lgyIqTLjrkFEJa3EqAKp9BLn_yXH5ueeDL695gLsYhxBVAi5x1ZAmn2GDw2
    9bhSFXRF49hZ9Ncrg>
X-ME-Received: <xmr:NQWBZ8Yj8pyX4TRONXh8qoCjuOafBohShdteyDlDP-2dGhVCk221dPEI7_4zcWYjst8ptP44LTVyyzqKaFHENHxoAFBlOLzgtZTlvmF4N0ZA7w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudegkedgvdekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdej
    necuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrih
    hmqeenucggtffrrghtthgvrhhnpeekvdeufedujefhudehudekfeekvedtvdduvdefvefh
    ffeuvddtkeffvddttedtkeenucffohhmrghinhepkhgvrhhnvghlrdhorhhgpdhvvggtth
    horhdrtggtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhho
    mhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepgedpmhhouggvpehsmhhtphhouh
    htpdhrtghpthhtohepphgvfhhfsehpvghffhdrnhgvthdprhgtphhtthhopehgihhtsehv
    ghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepghhithhsthgvrhesphhosghogi
    drtghomhdprhgtphhtthhopehphhhilhhlihhprdifohhougesughunhgvlhhmrdhorhhg
    rdhukh
X-ME-Proxy: <xmx:NQWBZ3WLqFIxL3WvIyF7KYUG07ytd0qk6DVchwhxNiAUb_rJWj0sDQ>
    <xmx:NQWBZylDLuG4feUKrSy0YTR_Ayz1JmR0lBy5d0h0FQO5Vp8do_fMGA>
    <xmx:NQWBZ8cKvGkc9TdWqxXFxQosaMqswV0UeKjGsaWPAWB7SVW6YXWgPg>
    <xmx:NQWBZ0Hy0OpJ5CMv42nzZinO5qiWr1guyHKqz4aTBtKRCvt3mqRLOQ>
    <xmx:NQWBZzAovMK5ylOQi5GikbXNk2m4kZTkPixyrg6-NCuQdKiNVKvVMwhh>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 10 Jan 2025 06:32:04 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 931e8a88 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 10 Jan 2025 11:32:03 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Fri, 10 Jan 2025 12:32:00 +0100
Subject: [PATCH v4 04/10] github: convert all Linux jobs to be
 containerized
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250110-b4-pks-ci-fixes-v4-4-6e4613446080@pks.im>
References: <20250110-b4-pks-ci-fixes-v4-0-6e4613446080@pks.im>
In-Reply-To: <20250110-b4-pks-ci-fixes-v4-0-6e4613446080@pks.im>
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
2.48.0.rc2.279.g1de40edade.dirty

