Received: from fout-a5-smtp.messagingengine.com (fout-a5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 754521E0DD1
	for <git@vger.kernel.org>; Tue,  7 Jan 2025 12:30:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736253059; cv=none; b=JC0VtEVi5Irm32wCg87tYpX/KjRix2IfaHSw3hw9Bkja+kOzo8xEiwFhNU6cptDHzL4v1AFKbhWfBBAwnvPmCn2XDamQ7M0/GbOAjhJ2T+cBQOGLUr0/+30vjbTrAPajhcoicwkhuRnhCMtqFgozX+o1zpBBhRDt0q4YK5he4KM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736253059; c=relaxed/simple;
	bh=G1jPa7P7T6TB45XoieFsgxr0j8yLEOJJZo63ewbJ3M4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ONbqNPBbKvp1+vcRlOS4oz0y3A7AXdj81WamsEu+nV//wXUJJqUPoq1oWhPCCX5cI4h97vSbCcOLoeEM5BWg4RxqSsF4exOAdSkXyjaORtIB2GsbwQRYoRZZmglrT3DF1nrGQt0zIjw5R7ZLCGOMzi/6dVNgJipoSA6Ra0/Gv9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=gPPIRGJz; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=X1xH1vqo; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="gPPIRGJz";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="X1xH1vqo"
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfout.phl.internal (Postfix) with ESMTP id 4747113802B2;
	Tue,  7 Jan 2025 07:30:54 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Tue, 07 Jan 2025 07:30:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1736253054;
	 x=1736339454; bh=KyOeinV6oJzx1SRviha9PF63/S2bm6rWc2/2k4n1LGg=; b=
	gPPIRGJzFJLcDDIVuD+S/1W1frcN5zA8q45NMQA3ogMk4sWI9mIOs1SM9whndFIM
	LjNB34/PUECUSJtthXKefnuP0o/AHnz7Yeyfhm27KpvO6sB3Y+W3rXJOKJUx5gtV
	bEpzQz1JDCQTQE/sio2O+huvuc+QucU7W55r738H7VnqzrFDj2cmSDfoBl4OaQpq
	ey5XXDT7c/zTkpSla6blxAL1xSPfBa8yJxqhlDmxiqNnf2ROGhFUyVfAaL7V8jd2
	VLq2kxQvy32Bw2+VyF+hUFrpKvdZQ8VXbiktSswUBqsEQUJ0L3yFq/m03ffAG7rv
	5rjyOnkUPGSYLOAiPhr+Xw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1736253054; x=
	1736339454; bh=KyOeinV6oJzx1SRviha9PF63/S2bm6rWc2/2k4n1LGg=; b=X
	1xH1vqoiX69AJ1hfiUn+1Ol8oDv931q1HTxseI4pa5Z6TVzIQZz/WT8Dn0M8B63Y
	/aG7n0qg/pvz2SRZSt7gUG+QO+XntIvBIJSulj9CCaTHFByYKxx1sn6i3u57hiEn
	A5Q0+7rrEDlqzRaA8/UpOaF294GpA0BOm0IXhwNnkyRKMKbQUoCWXt6U7p231IM/
	bVfaRpu9pteaP8CFCYleCo36xpR1mjzR+KOdboqiQmTvir3mGaQRFDIwAm+tiiTf
	upRYZIy3FYgg/M65zbNKoyek89d14L1XyjBDOzIxiY9TxJRtP/Q4DZUwi+MG55Yg
	VkpBeGf3iY0eVhpU+1jRg==
X-ME-Sender: <xms:fh59Z3bu1rUbD1Z6oi0Ktr2ETrYunALrnTEL01T3DH4oqqw2cwYUkw>
    <xme:fh59Z2aof_ctWBIik-KLG96i7MktgB4WhXzS68sRSNVATfRdGBtVAitdfJpDN05yT
    ekJiLRjek0slGMGhA>
X-ME-Received: <xmr:fh59Z5-vDrz6GDi5lmyYh4PkOSQwEPevdEfTpjHsKYlOde0PABOcOOcxglWdYzzDfkFo9ORyndizk5m44L360N_mLC1ok6fGnCZrM2UnyqPD6A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudegvddggedtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdej
    necuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrih
    hmqeenucggtffrrghtthgvrhhnpeffueeiudejvdekheeuvdekfeffiedvueelteekudeh
    jeetkeegvddugfdtgfeileenucevlhhushhtvghrufhiiigvpedvnecurfgrrhgrmhepmh
    grihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeegpdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpd
    hrtghpthhtohepphgvfhhfsehpvghffhdrnhgvthdprhgtphhtthhopehgihhtshhtvghr
    sehpohgsohigrdgtohhmpdhrtghpthhtohepphhhihhllhhiphdrfihoohguseguuhhnvg
    hlmhdrohhrghdruhhk
X-ME-Proxy: <xmx:fh59Z9oMgVG9rXWPlYPVl3calXhVUQ0nNsg5u_hI_NxQTfg7h4y4Qw>
    <xmx:fh59ZyoZusbGFhaOlVNiPU5ocY2_OieDYkgy9FyviT_yGAjGc9_Cqw>
    <xmx:fh59ZzQPd--jdpb3S4WxuKZMVrKwy6lUf5mMi6AprgH6xZjMwnMYEg>
    <xmx:fh59Z6rC53tdIcOHz3Ds6GQLSBfAlADbAyEHYCx1U6_f6hBAjwvBUA>
    <xmx:fh59Z7k8S_gAmRL9wqJmgqzzEjLZJxiIG9DVjHQxRCmxfT2maMuZviuG>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 7 Jan 2025 07:30:53 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id bb06f7e1 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 7 Jan 2025 12:30:52 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Tue, 07 Jan 2025 13:30:51 +0100
Subject: [PATCH v3 09/10] ci: use latest Ubuntu release
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250107-b4-pks-ci-fixes-v3-9-546a0ebc8481@pks.im>
References: <20250107-b4-pks-ci-fixes-v3-0-546a0ebc8481@pks.im>
In-Reply-To: <20250107-b4-pks-ci-fixes-v3-0-546a0ebc8481@pks.im>
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
2.48.0.rc1.245.gb3e6e7acbc.dirty

