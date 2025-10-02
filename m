Received: from fout-b7-smtp.messagingengine.com (fout-b7-smtp.messagingengine.com [202.12.124.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B45C30CB42
	for <git@vger.kernel.org>; Thu,  2 Oct 2025 11:04:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759403092; cv=none; b=Fuy7bxg2shl8QI9SfKQ0sFlr+DFiJ5zFFDhCtNwcoUncqbO4AOHlFEoJlOVvPdeyNfcAj/+K2KEGpS8baLLP4TxtYnR2rUOGFb0rnwSTFEiVmfn+w9yDPS/IkJGmTezFh+o0fLq2hOeUKqkQLJYDS3nzVBRc0VqbL1S4PAPKNvQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759403092; c=relaxed/simple;
	bh=uVZOhA9KhisRAlBLs32LwRtJlTDf5zmFlnE91eM8ZFQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=jNn72x1gvdYo6NM1Wy7sLNMSA/Zyj11JdgiKek+RZQ//Czx5DFmbj7aCK2Xsmu673jADnCC/WRsWYpwW8ErfKeQhrVjMN2GRX/+bRFhfQpOFJ8qMMxRnsVxitIfQVam3lxqgpXx7FO7Piesc815RFhl4QqreMLth6kz6wHuf0uQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=XK5pP2P/; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=rkxsosdR; arc=none smtp.client-ip=202.12.124.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="XK5pP2P/";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="rkxsosdR"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.stl.internal (Postfix) with ESMTP id D32151D0018C;
	Thu,  2 Oct 2025 07:04:49 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-03.internal (MEProxy); Thu, 02 Oct 2025 07:04:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1759403089;
	 x=1759489489; bh=/J2byL2Xt1DZXDgm9HZguKLNQ7AIYe48fJLM6NOpVKQ=; b=
	XK5pP2P/fv8ggC4APFNWoyzdCA4mSWoi7vA7tOyAb2BZ+MICSqcwbpEVeENL/EHi
	D4anUIH4D0rx/UXN2lM+nr4kxPaTlTAnFW7Fuk/FRmyCaOUIrelG1h0DS4E0G2oP
	N/AaMJtsh5GaQ696j+chPW+NzdBoJdubMhxU7bp046ehGLSgTJ+qfSkCPwj6WsV9
	xL07GIbjw3UYuacvdRPX63fnfi84zMZjKrdiC6gAzsQKOwiX6KDqJUjEuM9NamFW
	LS5n4ISFe2CugqqqfP5P8sO23mJMzDP/J9q3xDIV4LyNgWOF8v1NfHKWa+ytaz/Y
	KfE6l8KuCqXEzQkBri/poA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1759403089; x=
	1759489489; bh=/J2byL2Xt1DZXDgm9HZguKLNQ7AIYe48fJLM6NOpVKQ=; b=r
	kxsosdRwyQj0IW99U2B5hwOgMqogyYD/WIxPscaB6O+PW/b3Vc9A80a+ge6lOdqw
	MjkftOMCoQCVzvU/odf2B6B1ubPAo2x/eJisTd0GoVTBcbwaBtT/YnQ1ltWPcA2j
	fUz0I3NNzTXg9dG3ZjF3GwtmfQ3TnQLwCwlAnhWDLFlYXf/DTDqmWMSsmOUfppL0
	uog+aC4YgeKHGr51KJ/C2laevmsp0OYPFBcHa040TYmNUuBmCUOtQ2PoMtrThEAy
	GDD0KQiKrFEheK8eQz6WtPiMOpGpHBQERnHBF1M8YgrW7BVFuu33Urp/EWEYX6Zu
	8lDa9mIB9PaKcUVVgSWXA==
X-ME-Sender: <xms:UVzeaHe73d75Rc8Am8hbT-S8DRxIdx8s9eL0hHkC0B9MLq8DyFa1-w>
    <xme:UVzeaDNbHffEQPiDsCvqxEBJUHkET5aCWveZfCVnWX30IWLINjAOlBQrTio7XwOVP
    KxILs_X_nz7WHL9kQxCjcjwUAUNPWqRgdr_JE5yTTOrv00keSE30Q>
X-ME-Received: <xmr:UVzeaOKcvBirTsTXbNhrUgGqyZLx1rWuFIn7AqzvI3tX5A5_lnlP3g3l1PbkC9K8oYsle1E24jY6-ZY7vLpv6jHrOqbieFpQZfiT8gTh-Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdekheekhecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhfffugggtgffkfhgjvfevofesthejredtredtjeenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epffeuiedujedvkeehuedvkeefffeivdeuleetkeduheejteekgedvudfgtdfgieelnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimhdpnhgspghrtghpthhtohepvddpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehtohhonhesih
    hothgtlhdrtghomh
X-ME-Proxy: <xmx:UVzeaEEhdMEpp1E72ST7by4bIJZ7kIJxuXqL5piffPnmDJcFLpwJcA>
    <xmx:UVzeaGQMBaSz9ge1z9VGWBumBUqQrJIYTvTo8YMKCBkfkqHpBguS6w>
    <xmx:UVzeaAEKECFe4mLRNUN8AgHVGZaR9SSxxMUMnN2Pb5JvQK9iL51QmA>
    <xmx:UVzeaC_bUW9idEWgKn59pFvQukVi_Z_0tGbn77cs0DGCLlw2jB9Ozg>
    <xmx:UVzeaC3R4Lkxxiod82DkzMJTlYvjd59HKA_O2522V04EFrEuKNyDSL2j>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 2 Oct 2025 07:04:48 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 418dc128 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Thu, 2 Oct 2025 11:04:47 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Thu, 02 Oct 2025 13:04:36 +0200
Subject: [PATCH 1/5] gitlab-ci: dedup instructions to disable realtime
 monitoring
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251002-pks-gitlab-ci-windows-improvements-v1-1-6a8b6b45d728@pks.im>
References: <20251002-pks-gitlab-ci-windows-improvements-v1-0-6a8b6b45d728@pks.im>
In-Reply-To: <20251002-pks-gitlab-ci-windows-improvements-v1-0-6a8b6b45d728@pks.im>
To: git@vger.kernel.org
Cc: Toon Claes <toon@iotcl.com>
X-Mailer: b4 0.14.2

The instruction to disable realtime monitoring are shared across all of
our Windows-based jobs. Deduplicate it so that we can more readily
iterate on it.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 .gitlab-ci.yml | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
index cf122e706f..552c033fb0 100644
--- a/.gitlab-ci.yml
+++ b/.gitlab-ci.yml
@@ -112,6 +112,9 @@ test:osx:
       - t/failed-test-artifacts
     when: on_failure
 
+.windows_before_script: &windows_before_script
+  - Set-MpPreference -DisableRealtimeMonitoring $true
+
 build:mingw64:
   stage: build
   tags:
@@ -119,7 +122,7 @@ build:mingw64:
   variables:
     NO_PERL: 1
   before_script:
-    - Set-MpPreference -DisableRealtimeMonitoring $true
+    - *windows_before_script
     - ./ci/install-sdk.ps1 -directory "git-sdk"
   script:
     - git-sdk/usr/bin/bash.exe -l -c 'ci/make-test-artifacts.sh artifacts'
@@ -136,7 +139,7 @@ test:mingw64:
     - job: "build:mingw64"
       artifacts: true
   before_script:
-    - Set-MpPreference -DisableRealtimeMonitoring $true
+    - *windows_before_script
     - git-sdk/usr/bin/bash.exe -l -c 'tar xf artifacts/artifacts.tar.gz'
     - New-Item -Path .git/info -ItemType Directory
     - New-Item .git/info/exclude -ItemType File -Value "/git-sdk"
@@ -150,7 +153,7 @@ test:mingw64:
   tags:
     - saas-windows-medium-amd64
   before_script:
-    - Set-MpPreference -DisableRealtimeMonitoring $true
+    - *windows_before_script
     - choco install -y git meson ninja openssl
     - Import-Module $env:ChocolateyInstall\helpers\chocolateyProfile.psm1
     - refreshenv

-- 
2.51.0.700.g236ee7b076.dirty

