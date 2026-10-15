Received: from fhigh-b3-smtp.messagingengine.com (fhigh-b3-smtp.messagingengine.com [202.12.124.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A70DA49F111
	for <git@vger.kernel.org>; Thu, 15 Oct 2026 06:57:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792047466; cv=none; b=ARZjJqfqU+e8vNVIH4qY5tMtDLU6bDNNK3PuHaYmqp7jTWkc3nLZSyeRvV0p+K9d8hXf3YR1dZPn8wjkSwPpGNzsT0zP4hn/cB7QfqsVK1BD590W8fIy52m5rAL2fy2/JQG3ptFLykBIPP22U3Q522F02fC+H+dJhaOA9ewGRAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792047466; c=relaxed/simple;
	bh=krjcGhQ0ghWqR8sHxbwsyFXqjsg09nRm/p0F3MhKIAA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=iH2gGVuQV/Nwdta5+j7LI3vL54reTn/uaYV3vymE1S3JBTuPdAuHLTAXXC76DdapQdW2NPcvbWhb9mWzqnLVIR1roSPuQjoKdYIvI/PLmfHmnRRlnDOEGn4iV6S2xHNHNa4rJTfzTIuml0xHfffIupQPAYqoIIw3OYUeScvnN0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Yv781XZj; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=huR4lwaH; arc=none smtp.client-ip=202.12.124.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Yv781XZj";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="huR4lwaH"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.stl.internal (Postfix) with ESMTP id B85A27A01B1
	for <git@vger.kernel.org>; Thu, 15 Oct 2026 02:57:37 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Thu, 15 Oct 2026 02:57:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1792047457;
	 x=1792133857; bh=1982burEPFJadcQkPHdq9dRPfDXwyNRtn6u63060MIc=; b=
	Yv781XZjJbnj3RfQc1LPhS2JGCsE/eDj4tOJlH+MgNTBG/4ToH476jq70LyTW90S
	BTgH6gJI/zzn3JjaXAYi85jFThVn5rn8daWkkZaUhUZkfqxSqkmmHgdfIRdABtxg
	jDRkEY/XfxxpBWp67Aa7a4xWAQ1JnoNs+X9cXmX1PCt783I/IMLnLeCBw3PNQ4JZ
	5opkFdakoQMP1Ec4aa5M8NV2AvQOfJrnbl7lS5rnrknqfAOFOiBQZrCrddQp6YPW
	DT77QdvVHSdl/7jq5A+Wzwmjmu6DNATe4JvBHQqg8j9jaEAT6AgSgrN0nFzObKBj
	Kd7yZqBT8viEZnRWwhyEGw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1792047457; x=
	1792133857; bh=1982burEPFJadcQkPHdq9dRPfDXwyNRtn6u63060MIc=; b=h
	uR4lwaHnxVZGibW4J06POH2dJrNxvztO7Gf//vRDSSr64AJ+1V0NB9NdRrDtOMtZ
	E8i7F/rUKF3XDBUZdI2kzxN/PAHBvVoadi9MhV1RWUi4QleCJkez9JSXntz/nGDI
	pzWt1z9z02uKwUt7ALjcZ/AURSJuNIdooLehoxWBr6g1zLy+c02qzG+nKMBaVasD
	aO4R/HZsOC/m5vPlxPBXLTbMvknsjuMN7QEE14ByM4DEx+2WuPKwM3GZObZZ+TGK
	PJrN6vr406TunI2c1nUV2YH9A8UYBGlrBCFfk3AXBED79x+50AguvFdGP5s7dS2c
	C+f5npG6R/jAuwXv1xp/A==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=sign d=pks.im a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1792047457; d=pks.im; mf=PHBzQHBrcy5pbT4=;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:p2cv0PGRD1/wBeDi/7nXA9NmqadhnVuKmwj/5YSJyMS2lCF
	sS4c7Nc1ZnlpT+a3SpzctPCs0k9qcmKLPvs575q07QFjYkeP06wFJBya5WV7HiTI
	YOZK9JmjLMn6rZsVB5ygxdspXXUByET5s7ZhZfhvWaVvjZHyNSwrNuM4e0Ds1JDi
	2lpXdEIz6RjwWcbb++J4GpNiheVlWFRtMzJKiYBIt7a7ZHGPQoH/fNYyaCzGxtjs
	ujFq7nUXqTpc5HKZql971PyfOD4v0hlbFtLAxRrOqsD8uLoFmA3xdqwuSIryhsn9
	+HqBTQxhS0rGsTAkgp4J7EOQaWdfNV6RaK4AvSw==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-transfer-encoding,content-type,date,feedback-id,
	from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:sZrE5NqGTu3y0rCHhy8MrTljmTTMDspeXu9nu0F60n0=:krjcGhQ0ghWqR8sHxbwsyFXqjsg09nRm/p0F3MhKIAA=;
X-ME-Sender: <xms:YXnQaujrVpc_6oHlv5oLRUvGTBmgR9ku8b8GWRfvMW4bSK-1Mb5-MQ>
    <xme:YXnQaisjRikA4LU3tQvBgSzdvi7m5G-DXSW_VHtIYtixE7wiJAxWpxYtl-E3Bda9k
    -HvFFZ98jh40vcdDyiUmb6pSg3dQzd-29kmi3XepdL32nMj-roHl6E>
X-ME-Received: <xmr:YXnQav713JRzAaOCsJVOaWFJNaTuBTN7PS9HKC3M0OOfHVawsr3cpr6S6DcnaOscbiLS0LM>
X-ME-Proxy-Cause: dmFkZTEtUvAGxsLJTUwND9VYUlYlcfzw4leHbfFICa9Zbzi8Ve0xk99hOMrC8JWgyMNjpL
    d8OU2RGTcaPEzrBKb4q0VSV6wqeZkD07LkmT9JDuWFN84fpWt5K8Q+GRvd1lcDDbz/LoOV
    kwt6oy4K98UcTaAIFJE2C70gLxy6yrO6zgASwulP2/gUH3qV0wZ6mPTL8dHHme0JzPWTgK
    HUq21r/Zut+zgaXkWH60B3u6v4T/jnwvKyPxQ7Rlghx4TlScz7P3jdjipOCLu+qNDnQzX3
    18xZCH1OxjLia46gLGM0s2D2lumAHp9sZQUiVmTTqNhG04DcMBQQ8yDrd85c+15nCEhKW4
    TqllXAU73fm5w6eEDhN6d5dFkXkb5/qITDPf0rJNIHNT3yWHZ6oZzWCJHzI2lgLIRnxuox
    bsSYYZdZ2fMcD1xJAQi0RerJgvcWUyVPRWfngU94h50RHQUoYRrHFnxqO+3vExIWLpaYhR
    IxSQQCkACy4+zGOZ3Ygy0XJwXbiFjEtYM7bx+iLUGvpXbi5/2gCIkPIw6lKsaNNE0XVzS3
    HyUV2x8orbE67iXA9mV4u7D9lq0hlBHph1j5YvluZX+zRCdrGryJZQHFaiYml8YJiofXGd
    +fA2fBB5/MuLII4M4+ix6WAjtq9tSOXSw28uvF/qZR/Rhwv3yN4KuHp5x9Ag
X-ME-Proxy: <xmx:YXnQauNgLNUMvnFkCa0El3uTdsMrc_D3LGSDXBNRw39VZZ9RaMt0qQ>
    <xmx:YXnQatsBqzSENdC-phhR4fP4Fj2XRtcklLyb7PAUkyrJ0001RPL4IA>
    <xmx:YXnQaharjj8-9KyDdHph80ExUs7DrT_tL5d9bD0fNvtNwkGPiA91aw>
    <xmx:YXnQavwSxRckN7fcHwwue--EmRmBTypd-8LLQdeS5VYPkHpchw3Iig>
    <xmx:YXnQamROeO_hyrTcmGr9DLdrvG0cOwAXuDbPtE_JwUQ6h-rOuDtTytb9>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 15 Oct 2026 02:57:36 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id c658aac4 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 15 Oct 2026 06:57:34 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Thu, 15 Oct 2026 08:57:17 +0200
Subject: [PATCH v4 8/8] ci: improve reftable test coverage
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261015-pks-ci-housekeeping-v4-8-c2c88f1b198e@pks.im>
References: <20261015-pks-ci-housekeeping-v4-0-c2c88f1b198e@pks.im>
In-Reply-To: <20261015-pks-ci-housekeeping-v4-0-c2c88f1b198e@pks.im>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>, 
 Todd Zullinger <tmz@pobox.com>, 
 =?utf-8?q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>, 
 Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
X-Mailer: b4 0.15.2

The "linux-reftable" job exercises Git with reftables as its default
backend. But this job is arguably redundant because we already have the
"linux-reftable-leaks" job that exercises reftables with the leak
sanitizer enabled, and it is unlikely that we will catch any extra bugs
with the leak sanitizer disabled.

One may thus be triggered to just drop the "linux-reftable" job in favor
of the leak-checking variant. But the latter disables a couple of other
tests that exercise git-p4, git-svn and other tools. Those tools may not
be an essential part of Git nowadays, but I don't quite feel comfortable
with reducing test coverage.

Instead, adapt the job to run reftables together with SHA256. which is
an area that we don't have test coverage for.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 .github/workflows/main.yml | 2 +-
 .gitlab-ci.yml             | 2 +-
 ci/run-build-and-tests.sh  | 6 +++++-
 3 files changed, 7 insertions(+), 3 deletions(-)

diff --git a/.github/workflows/main.yml b/.github/workflows/main.yml
index 47f174ed0e..fe8155772a 100644
--- a/.github/workflows/main.yml
+++ b/.github/workflows/main.yml
@@ -405,7 +405,7 @@ jobs:
         - jobname: linux-sha256
           image: ubuntu:rolling
           cc: clang
-        - jobname: linux-reftable
+        - jobname: linux-reftable-sha256
           image: ubuntu:rolling
           cc: clang
         - jobname: linux-feature-testbed
diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
index 3e2e6083cb..9b7698a003 100644
--- a/.gitlab-ci.yml
+++ b/.gitlab-ci.yml
@@ -39,7 +39,7 @@ test:linux:
       - jobname: linux-sha256
         image: ubuntu:rolling
         CC: clang
-      - jobname: linux-reftable
+      - jobname: linux-reftable-sha256
         image: ubuntu:rolling
         CC: clang
       - jobname: linux-feature-testbed
diff --git a/ci/run-build-and-tests.sh b/ci/run-build-and-tests.sh
index 611bf6e56d..1c549634e0 100755
--- a/ci/run-build-and-tests.sh
+++ b/ci/run-build-and-tests.sh
@@ -40,7 +40,11 @@ linux-feature-testbed)
 linux-sha256)
 	export GIT_TEST_DEFAULT_HASH=sha256
 	;;
-linux-reftable|linux-reftable-leaks|osx-reftable)
+linux-reftable-sha256)
+	export GIT_TEST_DEFAULT_HASH=sha256
+	export GIT_TEST_DEFAULT_REF_STORAGE_FORMAT=reftable
+	;;
+linux-reftable-leaks|osx-reftable)
 	export GIT_TEST_DEFAULT_REF_STORAGE_FORMAT=reftable
 	;;
 

-- 
2.56.0.212.g129ede20d9.dirty

