Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAF3A283680
	for <git@vger.kernel.org>; Tue,  2 Sep 2025 10:47:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756810073; cv=none; b=at5wL/1qhN+I9AMxHVMjtmQyp3vIBOZsXuY1Aa/agRp5/aT+ZA3Zzt2UBIimyD92ntF+pgfLz5eSa71fuDeZCqku2Qu1M7ZVj8WSYosxW+riAvhkr3pFKbKv9UL541eG01xVkfXZ+Yr72froMMITrSJbEStSM3tJDmtbOtVEQ5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756810073; c=relaxed/simple;
	bh=wxaCtmaTFxhn4nnrVcZ3CFQl1zr9qqQRJV9wVjYf51k=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=IaxM/FsTmmsDL5pQsKxPur0SxB0/yX18nJjSvT4s7Ul2bJiXBF0oCPO8VvasTxGyZdL8vzi0m2OqJQGiskh2c3Pg6yqEvROESe3AZvTHKxlLRIQS2duPhGEQNyVRgTb0Wa102AjEllNZrnGH9dnruZf4XizeJb3cqdytAngHCf4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=CtoCtqsT; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=FgMAxqeu; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="CtoCtqsT";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="FgMAxqeu"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.phl.internal (Postfix) with ESMTP id AF9ED1400217
	for <git@vger.kernel.org>; Tue,  2 Sep 2025 06:47:50 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Tue, 02 Sep 2025 06:47:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to; s=fm1; t=1756810070; x=1756896470; bh=edJAW6GmhB
	pgOw75GZ33w7HcAqmYs+d15EYoEwasEDk=; b=CtoCtqsTWarPo2XhhOs6AY6R18
	pimnezfuIUnNSX5xpuDCI9aLg6NHN+oHdeDFYvRSPYiRVprvCPNqZw/7CxWv9z8i
	nS/suu3M38kyaWbqHeRinlilvXtWOekzg+3xw0ifGluhmYkT3IFgC/nqKkqyh+5d
	o6cCVUvSDYZiofVQbTUpHTtRCzyrNThBDPZUGwbP9bzdlXHfVrFpx4D4/w6+Hkon
	zurGLVFT0+BDO7RWzd8vVTVFuKakW7XmKYhk4q+uHDxOpHLP5sFmqBXCnum/z0M2
	L/w/pg2yXHfr1qmMKLAFq2Ao6/TRLMf5YzWkukYr4nPtxwESF7EKnLNZ47Dw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1756810070; x=1756896470; bh=edJAW6GmhBpgOw75GZ33w7HcAqmY
	s+d15EYoEwasEDk=; b=FgMAxqeuarRSMeGdi5pLdi/aO+ItR8A2ViqlN67eP7m8
	8dys+rniyBYXHQ5SqL9jdFr1YvvRLcl7HxdQG0KSltmECXh0cn5slbafAHRGQ6Kz
	yQAlUlKXLHY+jx8wjPPexA06tnW9Sqqaynqk5uMEadgJORxwAW1SYWjGKyqlvva6
	ixS7Zgml3OTWuPvgjJUTeHTSXSoHnbSmmMV0VanRa8aLbkp76tfSdY1+S32rvtYb
	c4J5uA8F+7w1feUS0gzNXwmtlI5iUSVi4LmZz4e01XwY6nQ/vccaWxjfGsB3sUnz
	jFrqEa83Fk8FKP/4x6vcYSn8kc7vaz/lN3kQgvtboA==
X-ME-Sender: <xms:Vsu2aLTci0lAUjGOONYIQ_tKntCksgxBW3TY8mZPINKLcTl-Cro4Xw>
    <xme:Vsu2aOwb6QKQTg1Ai7ST_YIsraQolPjglHaAEP24KOTmiDRdt6SU99mlJyG9RHSku
    NZ1I7D4F54CUwFdGw>
X-ME-Received: <xmr:Vsu2aKNsXHp0pJ-333-6k8LlxLkRkVJWRlwtw4L9ixWYcvN4n5AuThFbssR2hoNiiEGuHnzWT-NPyr2Wt57BNrxeNF9zTvLYgJEePFvgX9_b2g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddtiecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegrihhl
    ohhuthemuceftddtnecuogfvvgigthfqnhhlhidqqdetfeejfedqtdegucdlhedtmdenuc
    fjughrpefhfffugggtgffkvfevofesthejredtredtjeenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epvdegvdeljedvfeekteeijeehleeltdevgfetffffuedvtddvtdffieekhfevvdfgnecu
    ffhomhgrihhnpehgihhtlhgrsgdrtghomhenucevlhhushhtvghrufhiiigvpedtnecurf
    grrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopedu
    pdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvg
    hlrdhorhhg
X-ME-Proxy: <xmx:Vsu2aNOoXURL3NGHO4H_2Y2lRtSl228STDAKu2mNY5bhMfOBqjMWYg>
    <xmx:Vsu2aMRgvZ88J9YYIwlSJyiWbRHp_a_m1ApSc0pWd6BRbKPjHtzAQw>
    <xmx:Vsu2aPBUQWQB0z7UsOpu9vvCgjfVY-Q7wkPy5wxg0qBAagdFTul-4g>
    <xmx:Vsu2aLhp9Kf0u-hcmDmgvwi3O0_FQyWSemknNqHWnoqo_syb8wQhaw>
    <xmx:Vsu2aIKo4Igt6_Lfga8jh_pANxyO3z1EOfzl0fGmn0MfurlF7t6E9Gkv>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Tue, 2 Sep 2025 06:47:50 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 2fcc504e (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO)
	for <git@vger.kernel.org>;
	Tue, 2 Sep 2025 10:47:47 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Tue, 02 Sep 2025 12:47:41 +0200
Subject: [PATCH] gitlab-ci: disable realtime monitoring to unbreak Windows
 jobs
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250902-b4-pks-gitlab-ci-windows-defender-v1-1-fcb1f19321aa@pks.im>
X-B4-Tracking: v=1; b=H4sIAEzLtmgC/x3NQQqEMAxA0atI1hOodUT0KjKL2kQNSpVGrCDe3
 TLLt/n/BuUorNAVN0Q+RWULGeWnAD+7MDEKZYM1tjatsTh8cV8UJzlWN6AXTBJoS4rEIwfiiK6
 msiJnrG8ayJ098ijX/9H/nucFhu+O8HMAAAA=
X-Change-ID: 20250902-b4-pks-gitlab-ci-windows-defender-a5d13da02c77
To: git@vger.kernel.org
Cc: 
X-Mailer: b4 0.14.2

The GitLab CI runners using Windows machines have realtime monitoring
via Windows Defender enabled by default. This has just now started to
cause issues in our CI jobs using Microsoft Visual Studio:

    Program 'meson.exe' failed to run: Operation did not complete successfully because the file contains a virus or
    potentially unwanted softwareAt line:356 char:1
    + meson setup build --vsenv -Dperl=disabled -Dbackend_max_links=1 -Dcre ...
    + ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~.
    At line:356 char:1
    + meson setup build --vsenv -Dperl=disabled -Dbackend_max_links=1 -Dcre ...
    + ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
        + CategoryInfo          : ResourceUnavailable: (:) [], ApplicationFailedException
        + FullyQualifiedErrorId : NativeCommandFailed

The detected issue is more likely than not completely bogus, but it
breaks the jobs.

Fix the issue by disabling realtime monitoring. Besides unbreaking CI,
it also improves our build times a bit:

  - Building Git goes from 26 to 22 minutes.

  - Executing tests goes from ~1h for one slice of tests to ~30 minutes.

This is still painfully slow, but the issue here is that the Windows
runners on GitLab CI are quite underwhelming overall.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
Hi,

this patch fixes some issues that started to surface in our Windows
jobs. A CI run of these changes to demonstrate that this works as
intended can be found at [1].

Thanks!

Patrick

[1]: https://gitlab.com/gitlab-org/git/-/merge_requests/408
---
 .gitlab-ci.yml | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
index af10ebb59a..cf122e706f 100644
--- a/.gitlab-ci.yml
+++ b/.gitlab-ci.yml
@@ -119,6 +119,7 @@ build:mingw64:
   variables:
     NO_PERL: 1
   before_script:
+    - Set-MpPreference -DisableRealtimeMonitoring $true
     - ./ci/install-sdk.ps1 -directory "git-sdk"
   script:
     - git-sdk/usr/bin/bash.exe -l -c 'ci/make-test-artifacts.sh artifacts'
@@ -135,6 +136,7 @@ test:mingw64:
     - job: "build:mingw64"
       artifacts: true
   before_script:
+    - Set-MpPreference -DisableRealtimeMonitoring $true
     - git-sdk/usr/bin/bash.exe -l -c 'tar xf artifacts/artifacts.tar.gz'
     - New-Item -Path .git/info -ItemType Directory
     - New-Item .git/info/exclude -ItemType File -Value "/git-sdk"
@@ -148,6 +150,7 @@ test:mingw64:
   tags:
     - saas-windows-medium-amd64
   before_script:
+    - Set-MpPreference -DisableRealtimeMonitoring $true
     - choco install -y git meson ninja openssl
     - Import-Module $env:ChocolateyInstall\helpers\chocolateyProfile.psm1
     - refreshenv

---
base-commit: 6ad802182101d622e6a4132f48292ddfa79e2024
change-id: 20250902-b4-pks-gitlab-ci-windows-defender-a5d13da02c77

