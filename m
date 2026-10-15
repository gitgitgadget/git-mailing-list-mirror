Received: from fout-b5-smtp.messagingengine.com (fout-b5-smtp.messagingengine.com [202.12.124.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B35F0427F9C
	for <git@vger.kernel.org>; Thu, 15 Oct 2026 06:57:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792047461; cv=none; b=A7i187NR9+zI0wpU+HHkua1ubzRqdm5QjEnbgRmUkvY7a6VlXPOP+0pdbqkPavqaPWoarB/SnFJGqjFPpbGFgztBT2f4oMpxYBB2nbbPqHKp9R03bKS49DuzG0cw+ueCIh10WifYCuUqfxQwAwHSYAEsOm3+S4x8Z4kiZLRw1oY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792047461; c=relaxed/simple;
	bh=7mlERE066nWjwU1P47dd3zAdqDqfqrLX1/0HxkYb+kA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=JTsLkUYcKLUSu2eV0KoISeI1Uh1rMEtXsl95SA9TKXZqEZzta2nz4VS8VkbTUqg4iiXa9+e3JOj/W79PjaBrrTa6U9w1jK54R9n6agqZ1Sk/IhGavxEPVA5ObHFWpNLQV78Rd1VLQUiJp36WAra3oeZYCVfRtXxB3IBSWHf4r78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=N4ltIklv; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ltzUA8rD; arc=none smtp.client-ip=202.12.124.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="N4ltIklv";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ltzUA8rD"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.stl.internal (Postfix) with ESMTP id E58C81D00132
	for <git@vger.kernel.org>; Thu, 15 Oct 2026 02:57:29 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Thu, 15 Oct 2026 02:57:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1792047449;
	 x=1792133849; bh=QDPAwsrvRmFwTwnttqhGpi8RwfmfDe7ZffaQAQeCNEI=; b=
	N4ltIklveVGCaqiC9U1DKFBNdkWbOYLrX8B2yj4fcwypylti9DPD0Od8xMsJYPwy
	FGIJphTFeFP1bQZI8znT/dVplvR/va26YAUb9UzHGD8lwp9+9gMtdqx2rQacM0LT
	K6KkQEnGvGd1OhCEuCH6YvtHTJYOUyl5Dc+PaQlChVtYgKPnhl0dtgMn0+WdqMOs
	F1NSOMaHD5gNp3OX2H1RyE5pjiGkNWrER6kOoe6ABpUhZHkfku/jE40w8ZL0NQ7T
	nfM/kQBwNrNBlKE7h1umoKnaOVJ4T0yDbIiTIwc53lTEG5E2x/Rp3XiuCYpgbj+4
	i6PawDWC3E7rZDKMXMK+AA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1792047449; x=
	1792133849; bh=QDPAwsrvRmFwTwnttqhGpi8RwfmfDe7ZffaQAQeCNEI=; b=l
	tzUA8rDfPv6slPAJ8K7l0gHj7ZBe4CB3Yh5eqw3OLwSdsjktHJKAuuo7CEr4R50/
	ASFoJtawzy2MQI8OLPU7jonScyFoRjk4XRKeoExhzRbAxf7sPeaQCThjQI1RqCiv
	W4kmlLx33MENcX13w5UqMk9C7ol6q9kL17gvSsD1aXw54R18uoKR3RU3LR+Zgy7J
	C26bzEzxAoCgA9LI6c984g3RZ/yxyBJqOJwKBgdeFcK9RGa2e8BqATENJkjGA7fj
	SV7aPP704Yngpdm2lIqJK8bRoYuJGkv6/QEdbTdYQviLa+3GZcdehLIvo/5K33AO
	23vA/GseWXy2YnOGCiQXg==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=sign d=pks.im a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1792047449; d=pks.im; mf=PHBzQHBrcy5pbT4=;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:tnqDEKOYyE6o/fYkMb0mDkveBuJRtpSiULvWJ4m4Cx0799p
	vm/QwFKfk0Csroy4tPIVAYKcZYcJwVhpM7USE1VbO/tiuuHmelWXdTvrjiOEBaPi
	wgoWdXwSpBkdlvX+tZhyVzekvUWoqKNKfhRWCUFkC7a9rTEVHtS0u85tkiZlppx4
	5a9PwWtxEnkCCDVwQ/B5mf+mLXmQJ2M6iD2EQqADCpmk1yZbltrwGrUDBusjgOEH
	PndY6K131ob71+wXRH7Q61zTJqJuQcScxKdrRtzaz0NSM6k539RPdNlrG3S+xI3j
	MfzIg2BNw+Aq95ZTGTVrE9r98bA5gBkjlZcWPUg==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-transfer-encoding,content-type,date,feedback-id,
	from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:yL93i6meWIkErStrmD7Sl4BUJcOcof3vXu1z0FNG8AY=:7mlERE066nWjwU1P47dd3zAdqDqfqrLX1/0HxkYb+kA=;
X-ME-Sender: <xms:WXnQaomEGGZwyaxug7EOkfwfu3pqNC1YZQCGLqXn5DFkUpAWzkKGrw>
    <xme:WXnQarjFQHP6Ly88yRRswOt2-eFtxqhlGlDX39dJZv0iER3fugr9gJDiVQoGQvwVg
    yzmNpN5UIMReLQ0-Qsb4yOjyGd39KFIFAPV9K7-iNEt-_GyX_ENGNQ>
X-ME-Received: <xmr:WXnQagfammKnD4zVomzTB_wcENy56nDs9CJEhGMB88Uz20qvSvpPk22JRkH8C_dCO76FjB0>
X-ME-Proxy-Cause: dmFkZTEtUvAGxsLJTUwND9VYUlYlcfzw4leHbfFICa9Zbzi8Ve0xk99hOMrC8JWgyMNjpL
    d8OU2RGTcaPEzrBKb4q0VSV6wqeZkD07LkmT9JDuWFN84fpWt5K8Q+GRvd1lcDDbz/LoOV
    kwt6oy4K98UcTaAIFJE2C70gLxy6yrO6zgASwulP2/gUH3qV0wZ6mPTL8dHHme0JzPWTgK
    HUq21r/Zut+zgaXkWH60B3u6v4T/jnwvKyPxQ7Rlghx4TlScz7P3jdjipOCLu+qNDnQzX3
    18xZCH1OxjLia46gLGM0s2D2lumAHp9sZQUiVmTTqNhG04DcMBQQ8yDrd85c+15nCEhKUx
    lfwELo9OrpFlLHpvkUTTAlH6d5IfZx7mMKlA3NVAOJvnVL/zXCmFAhhroFxxyJflkJ2Zx2
    8MdS27RwJpvORQsGt3iz72JjBYxFmtumehY4SpIDiCCA5lcwf8uQy6he3Vzo7nfxcaBK5D
    btO8JhKdor0yIF0Nx6D0rfXMvKuViAkSt5ut5zjnLY8MrLBufoVMpQNEIVYXhqK8OgRxSQ
    abLwwsfDzUAeSw+yqfW7JyMvqGtgPE17qXgBWwsRgVof+ywcUXbFiS1Vge3byBdD6KtX+v
    BwnTjrA7AA6HlyaUpwNws5BXxHJ2lCiF2lssvI6kcPokKBYgjgV/K7h5yIDg
X-ME-Proxy: <xmx:WXnQariOMhCD4b-hZveVkD871j7lZSMF8uLZAO91PGAdNS5h-Hj7UA>
    <xmx:WXnQaozj1dlf-FfCIlU6e2brYmj3A1W8zCLnF8_RQhZxYxG1k3tOtA>
    <xmx:WXnQanPJwabc6HMjUARtl_9S6k7Zvi8UqHVoqPGDoMmw36Fw9UNvuA>
    <xmx:WXnQapWOjJleD1f_quv2QGyIvfWzngNf4N1NhngWagXUolH4Aw9tEQ>
    <xmx:WXnQanWkTnHs83G_qgISj3CXb2_POFY-AFrpEr7G3yyGRq1toaIdu3Na>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 15 Oct 2026 02:57:27 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 0addc990 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 15 Oct 2026 06:57:27 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Thu, 15 Oct 2026 08:57:14 +0200
Subject: [PATCH v4 5/8] ci: rename linux-TEST-vars job
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261015-pks-ci-housekeeping-v4-5-c2c88f1b198e@pks.im>
References: <20261015-pks-ci-housekeeping-v4-0-c2c88f1b198e@pks.im>
In-Reply-To: <20261015-pks-ci-housekeeping-v4-0-c2c88f1b198e@pks.im>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>, 
 Todd Zullinger <tmz@pobox.com>, 
 =?utf-8?q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>, 
 Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
X-Mailer: b4 0.15.2

The "linux-TEST-vars" job exercises Git with a bunch of non-default
options enabled. The name of that job makes you want to cry though due
to the weird upper-casing and because it doesn't really tell you what it
even intends to do.

Rename the job to "linux-feature-testbed" instead.

Helped-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 .github/workflows/main.yml | 2 +-
 .gitlab-ci.yml             | 2 +-
 ci/run-build-and-tests.sh  | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/.github/workflows/main.yml b/.github/workflows/main.yml
index 6d1e37c8f1..60f262db39 100644
--- a/.github/workflows/main.yml
+++ b/.github/workflows/main.yml
@@ -408,7 +408,7 @@ jobs:
         - jobname: linux-reftable
           image: ubuntu:rolling
           cc: clang
-        - jobname: linux-TEST-vars
+        - jobname: linux-feature-testbed
           image: ubuntu:20.04
           cc: gcc
           cc_package: gcc-8
diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
index 7d972f0c8b..726c1c1865 100644
--- a/.gitlab-ci.yml
+++ b/.gitlab-ci.yml
@@ -42,7 +42,7 @@ test:linux:
       - jobname: linux-reftable
         image: ubuntu:rolling
         CC: clang
-      - jobname: linux-TEST-vars
+      - jobname: linux-feature-testbed
         image: ubuntu:20.04
         CC: gcc
         CC_PACKAGE: gcc-8
diff --git a/ci/run-build-and-tests.sh b/ci/run-build-and-tests.sh
index 23e87cbbd6..611bf6e56d 100755
--- a/ci/run-build-and-tests.sh
+++ b/ci/run-build-and-tests.sh
@@ -22,7 +22,7 @@ fedora-breaking-changes-meson|linux-breaking-changes)
 	export WITH_BREAKING_CHANGES=YesPlease
 	MESONFLAGS="$MESONFLAGS -Dbreaking_changes=true"
 	;;
-linux-TEST-vars)
+linux-feature-testbed)
 	export OPENSSL_SHA1_UNSAFE=YesPlease
 	export GIT_TEST_SPLIT_INDEX=yes
 	export GIT_TEST_FULL_IN_PACK_ARRAY=true

-- 
2.56.0.212.g129ede20d9.dirty

