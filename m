Received: from fout-b1-smtp.messagingengine.com (fout-b1-smtp.messagingengine.com [202.12.124.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E6FB37B40A
	for <git@vger.kernel.org>; Fri, 19 Jun 2026 11:28:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781868500; cv=none; b=jsbRISlrN0TDHdpp4Q7UhHcEIy3zxoMcAPjj7HJsrV6MMXrJkPF4jrIxYee9sG5G6wvIMINbLL2hj95pnr82Qrvk6dL0PEpwkrO5OT5K8bDAHqZRhS/2G8pAZug9YgUPXdlwkBkp7tDb0r8mXiQg2aIiGsvQkJy09tJh5aoJPE4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781868500; c=relaxed/simple;
	bh=83mypYXbhzgkqMlcrWfQcvme5RNy6RUlMii4riiGipk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=HAnljwhmb/LDK00/2FPi0LuzGCEmP02amS7LDoOjXFXpMBooglN58hyVficE2gIvDESGZn1NprwP386n7GbI98fhZtpo12DiFOGddmSwsRseea19VnzEiJ33+SV6I7jvNICXGIclBrcfwg2kPSIJaGHIEJ9PIGKGhOacIEidrB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=axzwszXn; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=MJzCqP5y; arc=none smtp.client-ip=202.12.124.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="axzwszXn";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="MJzCqP5y"
Received: from phl-compute-12.internal (phl-compute-12.internal [10.202.2.52])
	by mailfout.stl.internal (Postfix) with ESMTP id D24961D0015B;
	Fri, 19 Jun 2026 07:28:18 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-12.internal (MEProxy); Fri, 19 Jun 2026 07:28:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1781868498;
	 x=1781954898; bh=Pu/5fHitCXCAthqqEcDl4HhLLdhm1AXYueJVsqgazKg=; b=
	axzwszXnOhq1+Bp2F4BHwf6Xhdv46uQ5DFR6BwvgKpdrkjWtDg+eJOzISr+BmOiN
	EA5VEad0yoB2Td8xioD24gDcp8n4tcxO0E+DxuZNpD0BVledBkT+e4aDLk8lfvRh
	wdOCocLFIjriZem5qa3331c1RaLePVnEc2uGOk3sWaRQ/G896QS7TGXOI3SD4jF/
	KiGckCs3TsJaDFcQTm7ugNlPuKxa/Rw1Xy35EYa+Gm4gV6OpGkklht5MS/xSxr2R
	Bb1ou1rTiKyHVBCEax3v8LOikRuU+H2C+uFfSkfMtUVpieQhzRHhhL68MxykC0Cr
	htTk4V5YM0eh3m6tNIDqTA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1781868498; x=
	1781954898; bh=Pu/5fHitCXCAthqqEcDl4HhLLdhm1AXYueJVsqgazKg=; b=M
	JzCqP5y9DcuxMACq8hskdDlmUKPhAp7LemIy1aImqHqpA+zMsNWpuHvIpBtH1mBl
	zDlyA5TSQ/v3HMApJG+PEf+j+XRloeEDzSSmFnM0T5L5Onjetj00QW4GJbKwSKhz
	3fDcevreQ9rzkEhXG0zZnDjmtT9TDFQ8v1cn/G/SKRJvUx4yWSVr9H7kr11nJENi
	V1puwLRVrk9fNb0keQjleHt9j10wBI/lYXq6BMFl8SabTpKVXvP1L7YhMCQIjvPp
	K2Ecv2TyRSLbeiGGfBPQ16nPU9RyXQrxnGK3mjOYvus+fWI5b7mGL1CgAq9W5L0V
	h3sGGpPNidqRcPSXKljKQ==
X-ME-Sender: <xms:0ic1auxPtmU_9Qry-jpgN4ZGxK1a1l4S6t-uY6ct35PGtOOxi6EMxQ>
    <xme:0ic1ahTQLNP62VKg9Fy_hrhwEW4Y3PIgf1WUGlPl1euy0VJDwf0uvqTkznsRuFiIz
    d87_JN0qcp_Zv74lkxeDoM_oqokNU1dCMNidp48VVbBmp36gloX5w>
X-ME-Received: <xmr:0ic1alWeYMW_B5SpIplXYFE7WqRTMtk2HXvwS-PdVjOk3EehLQfCuaXumRZ0qgbVf3vsxiD2eMMJH2KiThp3EiFJue45_Drfo87Fy75CnBE>
X-ME-Proxy-Cause: dmFkZTEde8rkG7Ow/YQajJOxpUKYHnTWdG0AUznTDLiHmSMbSqWzB/6nKIAIdk1nkTwS0K
    C8jTqdNp1V7h/KMFCwexCiiwcxkUoPM3XGMXsNXnEqixWMufecGwaAXNpfHOfwmwhgziKB
    gEME1JUhRUF4zEWjEcolbPL4SS80OZZVhDQXhaESCZsPSITOIFAzr9mdv/wwDKbMEUglz6
    Lrw5108LV8TWN60J1S3iQg3WXtzla3Zx7Q2iJ+qofdJhYzq3vyVO5Ie87s6Y7SykEWxrmz
    /vmzMKfUyKVDBOQcXezzDDbfTiNE3Vevxi8qzYGVvv3v5UE9OxNTzNX4wxQEWsT+cwQAHj
    b2gxzGzusAKVvKlgYC+9XKboZOdM8BuYcvIM8BmcPObU2FAf4tDBfNsWAIUlvx+hkT76Dx
    eVlNn4Ly4mCswx0ze6RcGSEZxAMpD8En/7Psm2qG5gUs0aEsqS+iIGI/mzDEa5iRZeYJCx
    UNQq5HVaWpkD5yujX/6BGx5+1RrypSRGgaj3Jkv0zd5chk4PSrVtvPaXWf0cn73O+SHD28
    z+mrOIefOVhOLnU6YPhKU5Uu67GsXli81kCUl7NAcVM7ZatlHF7IfEHffVSrZpZucrsskt
    TkXMEMQ3+ZKaktSN/G2JkfcsuSeMNKh8pXCfV/YpK1lyIyBmLbpzcy0D5Zyw
X-ME-Proxy: <xmx:0ic1ajbW313pVuFnFavSjmw-7jQ6h4dQdWzk9REK3iLJ2Gpu2OtLzw>
    <xmx:0ic1ar3uyw3kJPEMnVewi2dG-8zCGGDiCYo2UCJZ0_3i7nsx5tIidg>
    <xmx:0ic1aljCJGM8jJhw5xxnW0ohW1M8bBma07yVJ6WFuQiY7mC4wBpS4g>
    <xmx:0ic1avbiTD5j7jeu5zYehlTbTO8dV6zkdJA4q0QEdfnvgwVckWkBYg>
    <xmx:0ic1apYjJ5qzlQhlfx3NuVb_qOvDIIvY2mjnjVFLHJqhP5w12jjVCCxx>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 19 Jun 2026 07:28:17 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 67dd75b0 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 19 Jun 2026 11:28:17 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Fri, 19 Jun 2026 13:27:54 +0200
Subject: [PATCH v4 06/10] repository: free main reference database
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260619-b4-pks-refs-avoid-chdir-notify-reparent-v4-6-a6472be7acc4@pks.im>
References: <20260619-b4-pks-refs-avoid-chdir-notify-reparent-v4-0-a6472be7acc4@pks.im>
In-Reply-To: <20260619-b4-pks-refs-avoid-chdir-notify-reparent-v4-0-a6472be7acc4@pks.im>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>, Jeff King <peff@peff.net>, 
 Justin Tobler <jltobler@gmail.com>
X-Mailer: b4 0.15.2

While we release worktree and submodule reference databases when
clearing a repository, we don't ever release the main reference
database. This memory leak went unnoticed because its pointer is
kept alive by the "chdir_notify" subsystem.

Fix the memory leak.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 repository.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/repository.c b/repository.c
index 187dd471c4..e2b5c6712b 100644
--- a/repository.c
+++ b/repository.c
@@ -421,6 +421,11 @@ void repo_clear(struct repository *repo)
 		FREE_AND_NULL(repo->remote_state);
 	}
 
+	if (repo->refs_private) {
+		ref_store_release(repo->refs_private);
+		FREE_AND_NULL(repo->refs_private);
+	}
+
 	strmap_for_each_entry(&repo->submodule_ref_stores, &iter, e)
 		ref_store_release(e->value);
 	strmap_clear(&repo->submodule_ref_stores, 1);

-- 
2.55.0.rc1.722.g2b3ac350e6.dirty

