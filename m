Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C55F2F1FFE
	for <git@vger.kernel.org>; Thu, 19 Feb 2026 06:25:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771482345; cv=none; b=fSytqFv7yPFBqt8Gd1KU8v+WtJ1uiTPP7aXQC9ujnObnwDhw/Ybk+XI9Auw/YGU0v3164EoEzevQALVX2K4C1+1MJmUOkb2/8iv/YhB2L2mKzp2fP/GuGmxCaIk+MyOwicxMjJbogtMIZMDBUZ4N80Wv7nTiztvuik/X5TdQZj4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771482345; c=relaxed/simple;
	bh=NL28WMxNrUWYXGuPyaXBhXnl242dKsbZVHHOjrn4hpE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=KHaj5YYFEFrk3KYTrAA5GVK0eEfeVrXxYqeIly7iWY59PUS1oKr/+2+zftyypjRH7rf7V5PcNHKp9Q0MzKqUKT1sYfOp7cEkNPq0s2uRyE9jyN/Tzm6PGBcas7z7XQx47mLzjDEdLAgzG0M85nM50habjaZHCNac1Pj3l3FjkLY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=FybmtvLk; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Qt2Ec6Fw; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="FybmtvLk";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Qt2Ec6Fw"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 8C42E1400081;
	Thu, 19 Feb 2026 01:25:43 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Thu, 19 Feb 2026 01:25:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1771482343;
	 x=1771568743; bh=vLEbpAEeykRzDPjFxou3KSQJpiUwholqXvkiilzO/4g=; b=
	FybmtvLk9P+suthtvXnXs7BMQmV9WgGMJtqZinFr/uvc1sEVJD0D1Ultv+8D2APD
	sV/z50EUGqgqORHhuCT8scuWBxnIqHUlxtoeydm8pAcV1H5CHkQUvnlIXKdWGh7h
	m6RFLRNkroe79DajhNIyc6KokCurRWGU4W8Qk8V7VV5yPswWMHE3YpAS06tbLDvR
	PYQCwTiDExYsbl8nzwBB1b/s52n3o/+2huy+pRwkKz8Fy1WMPB0xl597SrB1yFVT
	lan6vmZzSlILs2VKPQhae4C2sDqhs7TNh1LQ+u92rGUmBURD7nr7XNyCsYq1oGsV
	YBpsma2m3EyPLsbFXTh96A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1771482343; x=
	1771568743; bh=vLEbpAEeykRzDPjFxou3KSQJpiUwholqXvkiilzO/4g=; b=Q
	t2Ec6Fwk0aLIwdlC/1SSKvhACgAtzhiPXHeKe8iRa3GbEIKrm/YmxKBBHf1UD1a4
	xtm50q1mHB2kAWRdZbGWrViMX6BgZg/TRs5BxPXlkMTgQeLm5zPZoUatX4xxFaiF
	DLVU0z2fdhE/A/CpGAGag6RfcKRefhicNuxIZD9TEPExaWk4+vJVDSzgF0Srrt3X
	/W9kD7/7R5LubHUStKWeCJohq1y4UcWpnpV3Zn3f71ZezdH+vr4MJLaf201Jm4Do
	EbIOrl82OpUzaVo9TDivILeDeEeeOTUT+fbgpk+FejSYR8+hpimii/FdpGBmwM1D
	U/xWIKJ4k7YTANNV9cz0g==
X-ME-Sender: <xms:56yWaQpmbiRSSnNvRokwGpb8LOyx9aTlGh24Hz7lLDbOAj8zn2Vhzg>
    <xme:56yWadhUE4vLL7GfoRX2Et_YWJ6yjl260eHC2TXHkagOoNCBltPUvzt4Z99eJBCtS
    -gfB-OBgxefs0d49dJ1M3HvugWYYIHajyCTOCSZd86v39YIq9giBPw>
X-ME-Received: <xmr:56yWadjCp79dFHWLHiSdwjT5QEo2Y5R2Ir9NXSxl3LSYGtuNO86MhZnpnnHOJJfYf-M9HkBd7L4bRZLDx7DJ7qGHsaCUQoKS-Wv14dZqFQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvvdegjeelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeffueeiudejvdekheeuvdekfeffiedvueelteekudehjeetkeegvddugfdtgfeileen
    ucevlhhushhtvghrufhiiigvpeefnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhmpdhnsggprhgtphhtthhopeehpdhmohguvgepshhmthhpohhuthdprhgtphht
    thhopehjlhhtohgslhgvrhesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtshhtvg
    hrsehpohgsohigrdgtohhmpdhrtghpthhtohepjhhohhgrnhhnvghsrdhstghhihhnuggv
    lhhinhesghhmgidruggvpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdroh
    hrghdprhgtphhtthhopehpvghffhesphgvfhhfrdhnvght
X-ME-Proxy: <xmx:56yWaTgwPcjThJUa0PcRg19PIjfbaaZUyZxeYzjdq7EG3Yqom6g9GQ>
    <xmx:56yWadKUFXSOU8pxodFPHk09wNlZI4Xj5VobWV3HiSWF4-LltndSOQ>
    <xmx:56yWaSFjeSJgkZR8p2I8BgP_gQPkU0Iekda9yzisGfYEl2dllg7L1A>
    <xmx:56yWaRQjZBOnn5iJIRWGweVJue-3Sp1CD8A7uqtT7imJ-b88Oz2Uhg>
    <xmx:56yWae9P6xm1KcgfBfMyAFbecnuaoYXlX1MPHtLDnKG4wqcpwGs6zgW4>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 19 Feb 2026 01:25:42 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 6fa144a6 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 19 Feb 2026 06:25:41 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Thu, 19 Feb 2026 07:25:30 +0100
Subject: [PATCH v2 4/7] github: fix Meson tests not executing at all
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260219-b4-pks-ci-meson-improvements-v2-4-6047b8307ab2@pks.im>
References: <20260219-b4-pks-ci-meson-improvements-v2-0-6047b8307ab2@pks.im>
In-Reply-To: <20260219-b4-pks-ci-meson-improvements-v2-0-6047b8307ab2@pks.im>
To: git@vger.kernel.org
Cc: Justin Tobler <jltobler@gmail.com>, Junio C Hamano <gitster@pobox.com>, 
 Jeff King <peff@peff.net>, Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-Mailer: b4 0.14.3

While the win+Meson test jobs run in GitHub workflows, the shell script
that is supposed to run the jobs is seemingly not running at all. All
that the CI job prints is the following:

  Run ci/run-test-slice-meson.sh build 1 10
    ci/run-test-slice-meson.sh build 1 10
    shell: C:\Program Files\PowerShell\7\pwsh.EXE -command ". '{0}'"
    env:
      DEVELOPER: 1

The step is currently defined to use PowerShell, and of course it
doesn't know how to execute POSIX shell scripts. What's surprising
though is that this step doesn't even lead to a CI failure.

Fix the issue by using Bash instead of PowerShell, as we do in other
steps that execute shell scripts.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 .github/workflows/main.yml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/.github/workflows/main.yml b/.github/workflows/main.yml
index ec1a660981..a011d8d0f9 100644
--- a/.github/workflows/main.yml
+++ b/.github/workflows/main.yml
@@ -297,7 +297,7 @@ jobs:
         name: windows-meson-artifacts
         path: build
     - name: Test
-      shell: pwsh
+      shell: bash
       run: ci/run-test-slice-meson.sh build ${{matrix.nr}} 10
     - name: print test failures
       if: failure() && env.FAILED_TEST_ARTIFACTS != ''

-- 
2.53.0.414.gf7e9f6c205.dirty

