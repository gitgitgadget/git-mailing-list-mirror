Received: from fhigh-a1-smtp.messagingengine.com (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDE581F03CB
	for <git@vger.kernel.org>; Tue,  7 Jan 2025 12:30:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736253058; cv=none; b=D6tU6lQQ3eh4QI+4Vtb+pRXgoTmuar4L0vR9Rif+EKS9xvVKj/JfEx0MI9u/fMTtDDacSZvaNluI+yEf/lA0F4Nf4ZOsGftPlNSpfdyvZ1E0Cllo0FsDAod8IIzYfgnjMpZoABnNadQQzLtcmISO7DAWu0WGpuzielXrD5IoqY4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736253058; c=relaxed/simple;
	bh=LidPJI6V9UmFgwMJw9iM67Ikb83ruK0/SpwILWhwL/s=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=p6/kiK+ZPkFX/VAYLp9t+opsyGsY0fyZDSeHSIaQnmTS0pqpa3gc10KoKBWhvdJACpsrpmqy3Y20br21bjxosQwlkZWRJ7vL2tlYZ8pl3IieXnuGm7lQTaMGoNrQ5bXCW7bK1CVY7QdwUtoEqor9XJrXy89RpU+DxYLXYieUjZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=HLdyYPot; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=kYmcgoOn; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="HLdyYPot";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="kYmcgoOn"
Received: from phl-compute-02.internal (phl-compute-02.phl.internal [10.202.2.42])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 06D21114018F;
	Tue,  7 Jan 2025 07:30:53 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Tue, 07 Jan 2025 07:30:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1736253053;
	 x=1736339453; bh=xy8iUdpn3FdyTuKqG/1BpLHGxE9iZc8tfbGxMAfX/xI=; b=
	HLdyYPottRnlEKJDB8jaFYOgv87FjgLDw/THd9q4pScpew4vk/JpFVdqaHMZhF+S
	qcvXdY3sElv6KzJdr5SjyiOkdE8KsOx8u50kyJygQaRtfK0inHRutxz5+rVDf18y
	rpElKf5tEIOLBeNRDkMxT4xs5ovtiITy8SI+P7ZhE80Zeof/mkUiS+5zJ4eYJpAv
	TVK/xzwzTA0sgFFDpUjPD6jRKyJgxjMfxQ8QP/kJjG9j1Cl7e51sye4NskEjNAsl
	6FsmxCppCg1dBpl3f3MLjBNpUhMYju5UWdZ4AA/ydgqZ3lwqAoZvyp6Ug0Y7WGf/
	hGCxxZDSJu+3W2EvnJmY/g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1736253053; x=
	1736339453; bh=xy8iUdpn3FdyTuKqG/1BpLHGxE9iZc8tfbGxMAfX/xI=; b=k
	YmcgoOn65JcSdpiZRJdOnXjl6qK9pPi61gHB32yvVQwlYqs08tprShI/pKR/6vUx
	8nDx2+r1TSDn/1WRqoaeqMxPB1sNRxH+xuqDzYOlTgjdOT/IIOx1x67qh3Wi1j7h
	g6Qhfpgk+2X9ljLR97hHQcs1Mqq3ixh0aeuPUHD4TEdJU1znReRHKgJuuISHtMzQ
	ZUQ/KYVO2RTP0BATZEECqE5KzLmUAW2RhZv61+DX/fnP1K+j8Jl7twiy4KpjpGCS
	pdlVtvgNvCXQ+mDzzqgJWF/UGboEWLT//UU3+p/WUI/U57fhEf/HxT6+u2n1S9hf
	zDi0S7O/xJCEALyg4JzHw==
X-ME-Sender: <xms:fB59Z8KmaE2NKfjJw_GpPeyOtYvFCPIaAzgZNiSylbSlg0MHFBdngg>
    <xme:fB59Z8JoLzqLSQX0aQe8-NUt7w87l0Axd4bXKHwaMXJZH1Li6u7K7gmRZrqstD6Ln
    lQ6LXmxtomn2WwJyw>
X-ME-Received: <xmr:fB59Z8s-hiS4IMwfQdADC0UxfgaW80PD7wUnYtE6cGkhhukOoWvuyMDarlrjVMET73iCOxqa_fj2lOijSzekxhvps0aHE4QTkKyOcSLgdzxjbw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudegvddggedtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdej
    necuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrih
    hmqeenucggtffrrghtthgvrhhnpeffueeiudejvdekheeuvdekfeffiedvueelteekudeh
    jeetkeegvddugfdtgfeileenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmh
    grihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeegpdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopehpvghffhesphgvfhhfrdhnvghtpdhrtghpthhtoh
    epghhithhsthgvrhesphhosghogidrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdr
    khgvrhhnvghlrdhorhhgpdhrtghpthhtohepphhhihhllhhiphdrfihoohguseguuhhnvg
    hlmhdrohhrghdruhhk
X-ME-Proxy: <xmx:fB59Z5aKmlvM7HlFbclI25HSIg5eo3nBOVhfbsbfaILyXHaKm_25FA>
    <xmx:fB59ZzaK2-uvM9mfcvwFgCumrg2nrvCttxglWXmqm5G6O6jd72kLUQ>
    <xmx:fB59Z1D5VGlQOMf_JJk0D57Y2E2_76wTI2QT-HEOYCNR4uQnF3mAsg>
    <xmx:fB59Z5aYidmBPt6iJjO2ii-a5ua514kk70K07dMMYHjAudgmL0SZLA>
    <xmx:fB59ZyVkIQ0snXUeSw0gHlIpKj6F5-Sjkbq9ZiYv4g3BLdfwIx-kr0YW>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 7 Jan 2025 07:30:51 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id cc95298a (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 7 Jan 2025 12:30:50 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Tue, 07 Jan 2025 13:30:49 +0100
Subject: [PATCH v3 07/10] gitlab-ci: add linux32 job testing against i386
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250107-b4-pks-ci-fixes-v3-7-546a0ebc8481@pks.im>
References: <20250107-b4-pks-ci-fixes-v3-0-546a0ebc8481@pks.im>
In-Reply-To: <20250107-b4-pks-ci-fixes-v3-0-546a0ebc8481@pks.im>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>, 
 Phillip Wood <phillip.wood@dunelm.org.uk>
X-Mailer: b4 0.14.2

Add another job to GitLab CI that tests against the i386 architecture.
This job is equivalent to the same job in GitHub Workflows.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 .gitlab-ci.yml | 2 ++
 ci/lib.sh      | 2 +-
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
index 00bc727865031620752771af4a9030c7de1b73df..29e9056dd5010f8843e42aeae8410973c825de54 100644
--- a/.gitlab-ci.yml
+++ b/.gitlab-ci.yml
@@ -66,6 +66,8 @@ test:linux:
         image: fedora:latest
       - jobname: linux-musl
         image: alpine:latest
+      - jobname: linux32
+        image: i386/ubuntu:20.04
       - jobname: linux-meson
         image: ubuntu:latest
         CC: gcc
diff --git a/ci/lib.sh b/ci/lib.sh
index f8b68ab8a6546802756fd516ca15a2c97223da5f..2293849ada3b45873f80e4392ab93c65657d0f13 100755
--- a/ci/lib.sh
+++ b/ci/lib.sh
@@ -269,7 +269,7 @@ then
 		CI_OS_NAME=osx
 		JOBS=$(nproc)
 		;;
-	*,alpine:*|*,fedora:*|*,ubuntu:*)
+	*,alpine:*|*,fedora:*|*,ubuntu:*|*,i386/ubuntu:*)
 		CI_OS_NAME=linux
 		JOBS=$(nproc)
 		;;

-- 
2.48.0.rc1.245.gb3e6e7acbc.dirty

