Received: from fhigh-a4-smtp.messagingengine.com (fhigh-a4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9083376479
	for <git@vger.kernel.org>; Thu,  4 Jun 2026 10:07:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780567661; cv=none; b=fOKgqUKQE9hS3SYVpN0nQjf6sIRAum1QkQwjCs/PyxT1L9wLPExKz4RMrnUguZNWqt1G2zfxOfpHu8lRkZWVNKXNd0zYNwSwAuWxkSDQZ3tUKU3rCXVLogrIQxAgNZKZamqB+Le00wXD+oyv1hA+TSBGvVqrv8MLpUYfyy0RBJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780567661; c=relaxed/simple;
	bh=VLYf7+JqM8Ml5OB4la8fxlM04FkIonhq617rBZrgimY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=g77dFWFFYhZZxdKfVKih0w2huxCB9hA6tKfs2RofvYPVGTN5W58KHaHO/VFjS0B9Ti0PpA0RzBbHIDz+ceQB+dse5tZO6u7YcLXCxIuzFjSp4yRi+E8CfvQOpRvxXuGfaiABfC2fACC0ZFCdRm4AToE58u07uh9SySAhVooC+4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=mN+rEmXi; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=K6aVRIMn; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="mN+rEmXi";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="K6aVRIMn"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 386BA14000FB;
	Thu,  4 Jun 2026 06:07:39 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Thu, 04 Jun 2026 06:07:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1780567659;
	 x=1780654059; bh=8k5KfYzzJ/IZNcmF9nZIyWml0WbEjWpIq7/q9QheURM=; b=
	mN+rEmXikqzjqgJ41BHS0Ne7kMk9JXCOifowrs57RTuYQ2/nExnXmVXJNthsqbno
	UvNmyKzEON1Du6onPXEbtaGRec1iUvXAUFmrzrf63iFGr1ZBH+lwTpdXpooDgpv2
	HgyDOBB1dDb2H/e5+xwYp4mX4siz3yKRNSyz9TXC2eDWSFEfGIW9qfJ6f9rIBCv4
	UezVJmJjZ9So8bQVs0mdjfQQAHp95XKhFzLjqsBzDMz9a5BS6PletEVfQBOXmSOG
	76h5yE0rrVZ3yjLO3yjyFx3mwT/MArQZZvdiMJ59wLXFY/Kh5BVi1SG2lzL8JNPt
	9MCVRPLHIdO/A5kUsXgzDg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1780567659; x=
	1780654059; bh=8k5KfYzzJ/IZNcmF9nZIyWml0WbEjWpIq7/q9QheURM=; b=K
	6aVRIMncquUD63TLjJFOp92I3w8sVT1DGZAw1kFKtD1hGFjqKF8BQHt7BPPgaiMO
	tj3pnRd0EUH2Zl4ELZk1u2FBmS8a2u58KAIL5uzWS6LPQ8pWChHNFJToqTO+FVJU
	WdYkVApRP2MHkUFEGZDOtx4WbBk7IJgxPuX2r3kuJyDOzaoFAzZfCXZeJG4N8Doy
	IkbdrQcq2S/8rWiAKhEBnhyPxp8psnv/UHtjAVNAU2XuMHzB7rj6Md2anh8qvndp
	eOqJyGdeKZF/v9THFER831pcH5wy/rxGfwu3oMU3XkAoZwr7jFR1HmRoUSSpGwh8
	t0AIfzLFhSvfU01jLa52Q==
X-ME-Sender: <xms:a04halIUwG5hE3NVVP_bTwRpIIAV60dEM_ioUol1V3TpzO8Tgc08Lg>
    <xme:a04haolKdEMTmmepP6NQrkndfmjMcw_5Cw-Aup6jC_r70DWOCeOERI4cGXfTCp6SF
    uB2uVJqOL2WpD0daQnjwLVHaNquIppuJtzP1bBey4stXwN6m9M44Q>
X-ME-Received: <xmr:a04harHaROwZK-J-8e9-WD4xp1Mg9Xmcq2EdCwm0LQlMM6fNmYzXtSHgsAdwYHpTDfFb-3EzPJcI2J6OXeSEneu87vJE7yuGYlPCnswiznw>
X-ME-Proxy-Cause: dmFkZTGv5qh6JYHKMmSdC9Vg9XCXprVKsY1xOcnzE3jyfnm4yvnelY5rvB9nbMlVloNG2y
    D2M6/VfexMFC+bgl3RIdKr6bOuYBoCaPxza/bIrizu6KTFiaDadxZ0XavR/D0Oc1S+vsEb
    5c83gPh5yVEfk9YddSLrOwE1YUFHILOnaD46S4P87rWiMQP8C+3T3N73ksApOfrSWYC5PT
    J6mh9RG+v/Kjxho/nHOhFRGH52GxxfHZ+0NS9gwjx4pqiDPfGZvYyA0Yrq0E8FcxAe7Ctg
    xlGCvdupeyDVnCZy30lGCeF3To1QTUAuzJILrbotr9NN8oFjvWmTkxXhiWLe9fSCQJocRi
    vEqHP5iyahCo+CAoVY8dBYT/Dslggek2o4jiY2b6/OFwSS66x1NBHldxtSfu10cbf4H50f
    CKbeH0/2BxKvLpzaWMaKQxgymTLvNe78JhTAiVEUECd2p43jyI3VIuGh7IVTbFpMD91+Jo
    icI8jRQkuNvn28FRNDo5YooTzbqJ8U68E+QyGUFtcxP/zU1XNXnOf5NupO+Ybxi6wX9hln
    Eu8abkO6UBrLVEWcnirWW33p5CQurKHtOWCE9ZpLYXUEapL5C5378BfxIpxtAzacm/TuqT
    ibcRTQlFlwITKXHtK5m89sgllAjmlN4jaMjn2Dv5mhUjnsFtyh+wSvAOUQ4Q
X-ME-Proxy: <xmx:a04hagGnwneXD5XebVl6ZXWG0IXxGQAOjC9CafPQ1ZCt5ADeSt-mDw>
    <xmx:a04hagN9OR1xIx1t-ITezkX85UrDzpRQpe-BW-JaTfS1viEI1AHSkA>
    <xmx:a04hanFtIPv9O0UAnntKYtFJW5QKhM51eNTMrFoZ9npSO5l5ZHzoDA>
    <xmx:a04havMoIV-VcBb0ZzRnObrSZtljCFiusGbsxTCDXg_oDi7EcRsa4g>
    <xmx:a04hanX7TyYD4d-DT0HxQtQayvWBN_lyLIW9ufA14BZwi-TPxDXxa8nt>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 4 Jun 2026 06:07:38 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 50aa343f (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 4 Jun 2026 10:07:37 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Thu, 04 Jun 2026 12:07:31 +0200
Subject: [PATCH v3 1/8] gitlab-ci: rearrange Linux jobs to match GitHub's
 order
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260604-pks-t7527-fix-tap-output-v3-1-7d766ed481e4@pks.im>
References: <20260604-pks-t7527-fix-tap-output-v3-0-7d766ed481e4@pks.im>
In-Reply-To: <20260604-pks-t7527-fix-tap-output-v3-0-7d766ed481e4@pks.im>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
X-Mailer: b4 0.15.2

Rearrange the order of Linux jobs that we have defined in GitLab CI so
that it matches the order on GitHub's side. This makes it easier to
compare whether the list of jobs actually matches on both sides.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 .gitlab-ci.yml | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
index e0b9a0d82b..8cb41baa14 100644
--- a/.gitlab-ci.yml
+++ b/.gitlab-ci.yml
@@ -42,15 +42,15 @@ test:linux:
       - jobname: linux-reftable
         image: ubuntu:rolling
         CC: clang
+      - jobname: linux-TEST-vars
+        image: ubuntu:20.04
+        CC: gcc
+        CC_PACKAGE: gcc-8
       - jobname: linux-breaking-changes
         image: ubuntu:20.04
         CC: gcc
       - jobname: fedora-breaking-changes-meson
         image: fedora:latest
-      - jobname: linux-TEST-vars
-        image: ubuntu:20.04
-        CC: gcc
-        CC_PACKAGE: gcc-8
       - jobname: linux-leaks
         image: ubuntu:rolling
         CC: gcc
@@ -60,13 +60,14 @@ test:linux:
       - jobname: linux-asan-ubsan
         image: ubuntu:rolling
         CC: clang
+      - jobname: linux-meson
+        image: ubuntu:rolling
+        CC: gcc
       - jobname: linux-musl-meson
         image: alpine:latest
+        # Supported until 2025-04-02.
       - jobname: linux32
         image: i386/ubuntu:20.04
-      - jobname: linux-meson
-        image: ubuntu:rolling
-        CC: gcc
   artifacts:
     paths:
       - t/failed-test-artifacts

-- 
2.54.0.1064.gd145956f57.dirty

