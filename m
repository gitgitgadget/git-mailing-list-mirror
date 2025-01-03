Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34AB81FA8DB
	for <git@vger.kernel.org>; Fri,  3 Jan 2025 14:47:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735915631; cv=none; b=Nar+5C2aqNChPxbgGwPvwKLPgY3J4lG+VJ6iPJ+5zLFNGprRY5VaLIh/MlBhaz6ioIUSQh/BRFUj2x8oE6cWxpXpLjD8dLfBczedwMQDIs/jtjEYEvcZPbO4ukCw0Z76QIYis1O4JaPhMPwP6uV6PbO2JCsKgpDvZwQYguKt5m8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735915631; c=relaxed/simple;
	bh=ghuyw6SYeYHbpzHzibb/6G6Xb9vwckZ6TOFdumvisKo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ohS+S6dNRdcvZMf/gyWSrt7U5CTzXFWtj56C79PeJX42UpH/9XuJjP3IMhzL8XQx8IHVVtYAzc/6UwtbGbwZWO36yTS2bmJHry68vye7RolKJesgViRa1AmmY6U9xfEXUGvcntWqAena6noJDDtvXbu4FvoZ2PDHcsfgGU+A4SM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=OWLUYbWF; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=hS/qSyA+; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="OWLUYbWF";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="hS/qSyA+"
Received: from phl-compute-10.internal (phl-compute-10.phl.internal [10.202.2.50])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 499071140161
	for <git@vger.kernel.org>; Fri,  3 Jan 2025 09:47:08 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-10.internal (MEProxy); Fri, 03 Jan 2025 09:47:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1735915628;
	 x=1736002028; bh=M1utMMxCkHLW5BeP2wWQdzyI/KTXFh+zs1jcqmqGxCk=; b=
	OWLUYbWF+U7O04cZL9MNYOAB4znBSIx6Dc+Z7Ju0AZPBgrF3FiDY2RvryG7mpkeD
	IviXHBVAFSKOCZkg1IAEGJyYBDR6iGicV2407ynoSteQ123Inbnhpc5diow/KPJY
	Sdy14kzku9dUGyv6Ak4wwGHnKoIyy2+L/kxAUUN2lZOKkZGz/zdhz7aLtGWd1e9/
	tsN8n0MBD6ZJy45vuNg/BNTlmGe3VU+NCEg0mS3pWLkzHMbrhZoNXH8yhFkSF76A
	Ve/Tx6t4EN+9Tp7AtPsLa4t3ivQDhpFqJiSiB/Du7D4Oaq8ZKSPcE8nUfb5tfi7Q
	VTLVi7M9A33Kf1GWdBPWwg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1735915628; x=
	1736002028; bh=M1utMMxCkHLW5BeP2wWQdzyI/KTXFh+zs1jcqmqGxCk=; b=h
	S/qSyA+1OY9lKP2RtVKGgLBTFn2kQaqh79Bng1MgThd/VAKeRBUw9OQZdsbeqJmg
	pzDAEt6D8sVAISaeUfhyC7A6/umqOHXT8kzHWvAykPxlnBW7wYeP0dQi1E4OVCUk
	jEo2wc3UZaVb6IYwmEteXTaFQZB6pDV9HR7lA+7pCjLFDwivLZpF2P3FlrHtp8tH
	bOf8Kp/h+NXtmJwp8hDm7ZoFOGKdT7V+C4Q153cuMa+yg5lSLdFzOqmdU1+KKLF0
	uLIjBba8Tc/TdTN65KWK9+AgXD708ENJ34y4FgX97QW6K90cwsiTvBnoBO1OnHm7
	5x0m9+wAlYBH5N9rYAp6g==
X-ME-Sender: <xms:bPh3Z75RI4cF1Ni1LkJLpk82BXIeMerIoA8A9BD4eAZEZfzUYhiHSQ>
    <xme:bPh3Zw6emKzv0OHDKXvBq501uhkX4m9h2JfqrOeNWLsk3Ap4tVwnIUTB3FNFsPlRW
    vKS6L_0r9asMGmb4w>
X-ME-Received: <xmr:bPh3Zyc4RGsGrOL62m8zB0XGimuRo3ck1BNth2zKsG7Xs4ZPWUi6_OmOL2aaBBfIBtjLK_quouwe-0y-Rdp-08dLiINaL-q61gk9ph0HN7CwRfM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudefgedgieekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpefhfffugg
    gtgffkfhgjvfevofesthejredtredtjeenucfhrhhomheprfgrthhrihgtkhcuufhtvghi
    nhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnhepffeuieduje
    dvkeehuedvkeefffeivdeuleetkeduheejteekgedvudfgtdfgieelnecuvehluhhsthgv
    rhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnh
    gspghrtghpthhtohepuddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithes
    vhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:bPh3Z8JeVtEm6jrjhy5sUjkCh4L3Gvm1VFst3NPlZjSoMrCHKntynQ>
    <xmx:bPh3Z_JoBI5oqR8XAMphu15-3uy3VQ6x4sdLywvuYPNAVAqvxVxBhw>
    <xmx:bPh3Z1y3KIoccE_UU8CTqA84JRo6sM4a_Bw22pKXBohmBp8w_L9Urg>
    <xmx:bPh3Z7JLgKtsOKlb3Kc95Kx5QwVT09zseBI7KSmpvvfrzPbqb-Mx7A>
    <xmx:bPh3Z1jAXewATqwmw3n-4IIp-z-SUAbmPeUXO_Hzk1YkWbfLV_On1eum>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Fri, 3 Jan 2025 09:47:07 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id f7761f64 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Fri, 3 Jan 2025 14:47:05 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Fri, 03 Jan 2025 15:46:40 +0100
Subject: [PATCH 03/10] github: adapt containerized jobs to be rootless
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250103-b4-pks-ci-fixes-v1-3-a9bb95dff833@pks.im>
References: <20250103-b4-pks-ci-fixes-v1-0-a9bb95dff833@pks.im>
In-Reply-To: <20250103-b4-pks-ci-fixes-v1-0-a9bb95dff833@pks.im>
To: git@vger.kernel.org
Cc: 
X-Mailer: b4 0.14.2

The containerized jobs in GitHub Actions run as root, giving them
special permissions to for example delete files even when the user
shouldn't be able to due to file permissions. This limitation keeps us
from using containerized jobs for most of our Ubuntu-based jobs as it
causes a number of tests to fail.

Adapt the jobs to create a separate user that executes the test suite.
This follows similar infrastructure that we already have in GitLab CI.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 .github/workflows/main.yml | 6 ++++--
 ci/install-dependencies.sh | 2 +-
 2 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/.github/workflows/main.yml b/.github/workflows/main.yml
index 900be9957a23fcaa64e1aefd0c8638c5f84b7997..b02f5873a540b458d38e7951b4ee3d5ca598ae23 100644
--- a/.github/workflows/main.yml
+++ b/.github/workflows/main.yml
@@ -371,10 +371,12 @@ jobs:
       run: apt -q update && apt -q -y install libc6-amd64 lib64stdc++6
     - uses: actions/checkout@v4
     - run: ci/install-dependencies.sh
-    - run: ci/run-build-and-tests.sh
+    - run: useradd builder --create-home
+    - run: chown -R builder .
+    - run: sudo --preserve-env --set-home --user=builder ci/run-build-and-tests.sh
     - name: print test failures
       if: failure() && env.FAILED_TEST_ARTIFACTS != ''
-      run: ci/print-test-failures.sh
+      run: sudo --preserve-env --set-home --user=builder ci/print-test-failures.sh
     - name: Upload failed tests' directories
       if: failure() && env.FAILED_TEST_ARTIFACTS != ''
       uses: actions/upload-artifact@v4
diff --git a/ci/install-dependencies.sh b/ci/install-dependencies.sh
index d1cb9fa8785388b3674fcea4dd682abc0725c968..ecb5b9d36c20d3e7e96148ac628a96c62642c308 100755
--- a/ci/install-dependencies.sh
+++ b/ci/install-dependencies.sh
@@ -31,7 +31,7 @@ alpine-*)
 	;;
 fedora-*|almalinux-*)
 	dnf -yq update >/dev/null &&
-	dnf -yq install make gcc findutils diffutils perl python3 gettext zlib-devel expat-devel openssl-devel curl-devel pcre2-devel >/dev/null
+	dnf -yq install shadow-utils sudo make gcc findutils diffutils perl python3 gettext zlib-devel expat-devel openssl-devel curl-devel pcre2-devel >/dev/null
 	;;
 ubuntu-*|ubuntu32-*|debian-*)
 	# Required so that apt doesn't wait for user input on certain packages.

-- 
2.48.0.rc1.241.g6c04ab211c.dirty

