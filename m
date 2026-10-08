Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F2F84908C8
	for <git@vger.kernel.org>; Thu,  8 Oct 2026 10:01:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791453698; cv=none; b=IaMXXLkzPPQoA9O8CF79fL6t01O1AW0ulimEoo1pDlDWePN5p8AumKF/UyBAT1eMR29bP2gZN3b40F7+mqGwKNJU3uDaFbFTZ5hw5GWNQ0YH0eZQbmBSWS1tlaUgZnRzGCnb+Ph3GaXOVqbdjEzV7+4aUkWbgbh4getuUavHmCw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791453698; c=relaxed/simple;
	bh=AwzFfK55V9Rns9Neg9xadbAiIaFgARAMH54zXFDZiu0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=SRlMmoZ7S6tv27Ai6uveh1N3PqFGP1oZ3WgM1ovdmWriylVEKduPYL8XXN9nnqSH604xT8Wrw0XH9YdGX+wVoMEGR3k3fUPTX3UrM9SjujtaceF1OIh3Jb3G23o2dfNHfaP7239AsVqLte6TwNJvFlA8AFiowm+UGE/KT1Bha2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=ilaZwJgh; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=F9kSV+z6; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="ilaZwJgh";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="F9kSV+z6"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 1976314000FD
	for <git@vger.kernel.org>; Thu,  8 Oct 2026 06:01:36 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Thu, 08 Oct 2026 06:01:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1791453696;
	 x=1791540096; bh=UJvPcazj43phCwC/934DpEMNej6rhfHrjTo5gKsPLn0=; b=
	ilaZwJghz+3wRjNIjBxsK/UyKKLNmDUntYRjdFT596vDWqmX+GV4xeSVhf4eRdvx
	+VAq8Ub9SIyxA46zWwkWD+YKplKRgnJHBOIi42+Y6dr+VqTNRkPKg0cqPNRWmgwV
	4YNnzAZlA/Gp2OSCepxDLsw7ru1D4mup9Y5aLsVG2HWZ+ztnFVmA7TY0qZjfvVwc
	k6gsGTOinCsr5LVqfkzBxjdasVDXYw/0MJB5LKRxxJqrDkJ2q7NjVajbJV7ZU0VY
	v1R7CvJJ/vNjRtac7uw9yDfHAThNOgmiYV4nDgi5PUbDtJutHTw3K6OP3ZiQVt8+
	5au2+aSWO6G74dt0XEh/bA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1791453696; x=
	1791540096; bh=UJvPcazj43phCwC/934DpEMNej6rhfHrjTo5gKsPLn0=; b=F
	9kSV+z6ip1L5GgjJtgFCAhUjGYQb6VFlfNQzZZlDRdWZ9jX+YgUR1G9UbKFclSYW
	iyun4c2TVPVvnX/gWtPLXCqU/82Hen5wUptEHj/O03BGa4/NHzpLLNIbmqiMd5cM
	UDyTA+VnRwME9aAajII9BhINFIkv7BPTVsIu5zVqGFgqOffGjYnkL1PoUXtARnXm
	k88WXRcFyY+/6VQKzYOPofynOlQ1PUoaYpxwVY6+Wt2VD8f7D6C/QqUakHpP88/x
	iLYHWJhHyOAroTxAOZdDwY4G5IPCV4fiE/heFgSapvl9fUMXXJrsSayw+7/QjeEp
	xpHRvtMzQ6k+hWyKDStEQ==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=sign d=pks.im a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1791453696; d=pks.im; mf=PHBzQHBrcy5pbT4=;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:Z+48bX3fvZWUuypx9njzzObRvCmLYiy8gFW8TBukEYsxNtT
	wMhPuJCzY0DfHXKcNm+nOLzoilPiok+e5ajRyNlredt+wBusG041Z4VYOu0TtVPa
	7kcgg0/a1w1K0nhlI5lAXjUSBvkjeb+4TvWpUHX/odpqO7IFVz3VPHmE6x3w4cbj
	NcY4X/zU1hzwmj/GNg1uvwOaoU6okUrYQXIsinWB4u0Htl2d/wN68cvIrClqCw0J
	dRdDlJFIk8gHdcbMH49iP/GLAJuYNWgph3Chv5rkhZ7e1KGsRvvGn9FQIdOT4nya
	sIt9wc3S3rFEUeXe3tvjH2NJgxwco2D13hw7w/Q==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-transfer-encoding,content-type,date,feedback-id,
	from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:a8nUfL0li8vehPk3Qlx3P3lBX2KTUyLDFEeR96INsfc=:AwzFfK55V9Rns9Neg9xadbAiIaFgARAMH54zXFDZiu0=;
X-ME-Sender: <xms:_2nHasZkM62pTwij_tVWLjSE4Ssyoh32fPbathCVenG496IXtMLB4g>
    <xme:_2nHau3DxTdk_6cXUwzKuQHZrbHXaEXUdhJ0QWEnPvpsxjtJXQzfQfqa4r4uRx1AI
    nATr4WZYVGmPxm6E18Gl0q6ZanCDLYwNDqTFsoFOzUZvXrly4O00NM>
X-ME-Received: <xmr:_2nHakViNcaaQ4zKQqATyAsPx5fZj2ysZIvhQYs9d49YVBBmVG1gdQ>
X-ME-Proxy-Cause: dmFkZTFcPkAz1MwdF9G91Q2HHt/DMwRQeFnKx+x68D7GybYDQ/i0KpIs24O8mGC97InV5x
    l9pAW0ts/UU9KH515tlBDmv+WZ0+KYrQRh6xeKbZfQat2Qz+Sg1rXt3b5uJznUCyp0m8uY
    71BCRA4fNnv9oBdGpbiziYXhCQjhE8NT9KNX8KIfhb0V1qRTBvsVj704A31+Hni2pY1ggP
    a3q+zc2dU5mDDUUOQmy2j1zpr2bNPvsQxh6Ysa48mXJ+zQrThKKxZGkcT5LdtAIGkRdeOf
    ck2bD2X0g14DJXkT4iu1Awq0JBVy1rhu1vpE3BYH9j6MP3iwrywFfxgjL3LV3YpxuArGMY
    S4p9K8ctYaB8ITkOhRS7IWZ5fwZleKQ4806gCXId+8tEfB6mKvDLBY1/FA7xZ7Lf/dCo8Z
    YrQEir6Wkrr3kH4UwP3YHQBzeJ6yJ4aptI1GN22VhbAfTVl4ftFZopxqRmibEtqXX7U0iU
    Z4UZk4S0LHwkiRL+R8TN3WMZ6R+B/onyhOMSuPVdgXvouw6I/jKD3AAwgeMPjKINpW99lm
    YR0DrIw97psozgqYauSIFyqdCy+SEJy4dsLYo2n/2GAgROOnm77Hy3Egpgq1Y65xIoEhFJ
    ODcn81VST6PfMVH5KJeKenEX7NO6824+7Lf72Gj6Dyg9HjHzptpsT7GxM1MA
X-ME-Proxy: <xmx:_2nHagVZa7GfZKYcuJ4419pJ3IRQekobOhlkOc8QHz3eHt9aEFjF_Q>
    <xmx:AGrHarfgrM3oh-C6nVrXv59_NZYmOtNT92ZC9FPTEbEEyfMr6Ouegw>
    <xmx:AGrHahWZxcm9NJSudUKfyFYf7PivYqkTXO7Skm2tcfnfajktiC6EMw>
    <xmx:AGrHascV2jNNMSIsTvEsjT06o1wpSQkdJ0lzaB10fzzfVl2Nz0Hrqw>
    <xmx:AGrHall_xH75CA76L2m5Xg1EHqoo4XbedYBMU7Zls0DhR_AWOjCCEAeb>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 8 Oct 2026 06:01:35 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id a5747fff (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 8 Oct 2026 10:01:34 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Thu, 08 Oct 2026 12:01:21 +0200
Subject: [PATCH 3/8] ci: drop unused "linux-clang" logic
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261008-pks-ci-housekeeping-v1-3-baf015c589c0@pks.im>
References: <20261008-pks-ci-housekeeping-v1-0-baf015c589c0@pks.im>
In-Reply-To: <20261008-pks-ci-housekeeping-v1-0-baf015c589c0@pks.im>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
X-Mailer: b4 0.15.2

In d88d727143 (ci: drop linux-clang job, 2023-06-01) we have dropped the
"linux-clang" job because another job already uses Clang anyway. But we
forgot to also drop the logic in "ci/run-build-and-tests.sh", so we now
have some unused logic in there.

Drop it.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 ci/run-build-and-tests.sh | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/ci/run-build-and-tests.sh b/ci/run-build-and-tests.sh
index bc5058c917..23e87cbbd6 100755
--- a/ci/run-build-and-tests.sh
+++ b/ci/run-build-and-tests.sh
@@ -37,10 +37,6 @@ linux-TEST-vars)
 	export GIT_TEST_CHECKOUT_WORKERS=2
 	export GIT_TEST_PACK_USE_BITMAP_BOUNDARY_TRAVERSAL=1
 	;;
-linux-clang)
-	export NO_RUST=UnfortunatelyYes
-	export GIT_TEST_DEFAULT_HASH=sha1
-	;;
 linux-sha256)
 	export GIT_TEST_DEFAULT_HASH=sha256
 	;;

-- 
2.56.0.406.ga2d225a756.dirty

