Received: from fhigh-b7-smtp.messagingengine.com (fhigh-b7-smtp.messagingengine.com [202.12.124.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80D7A33B6FA
	for <git@vger.kernel.org>; Fri, 20 Feb 2026 10:15:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771582538; cv=none; b=iAV19BWDeOVvWCd/DbUQPiU2RiXTpnOMtOHDQu+TRzccuAY7XedwyOSOIJRfTtLgffhE9BhgtEDnTUwTlyeyisEMECgTmO2R/VT6RTDQkL/xosZ1C46F7qTW2wQaZThsPrd/w+xCO+qsPn/HcPRQFuMAoZdINF5T97dI/pWiSG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771582538; c=relaxed/simple;
	bh=9NdibecXQjMpne6QNSzEc4pzta0dEpM9s0JrIGuc+a8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=gvNTDiy/xxSTPikuFl4JgNXOLEgqqrRgmMtAYAlP8RXDo000TxJ2AWD8RHcVA/dflHX1TVB/e9nAG9w8FKkr5Y5bPhpAZ4ArqDVjMnfhmtIRecaQWi2C72XC8QoMYX/SGCvAU9NeLiXIds28AfRwUHQBYikmicg0bphxuUrw6/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=o3xSt42a; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=eQR0rlXb; arc=none smtp.client-ip=202.12.124.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="o3xSt42a";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="eQR0rlXb"
Received: from phl-compute-12.internal (phl-compute-12.internal [10.202.2.52])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 796047A01BB;
	Fri, 20 Feb 2026 05:15:36 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-12.internal (MEProxy); Fri, 20 Feb 2026 05:15:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1771582536;
	 x=1771668936; bh=ieTHVjDH5vm+nLT4pw2oXapZaJHkJwn7bmayOGjdyZY=; b=
	o3xSt42a3BMGkC4WCqXmoPxWaj7ZmlMtGbLBqZK3fwhJaE48HPyyvfZD5v/Unr6T
	2maYfGvN3lJ2/HaR5ZWujyqjYDqyNE/2bzRwoMj5/aE9GVAiRgU+7m5ijLEIRqpY
	Is4+QPxAE7OzIMzHFDgreGN/F0FNcIyO1h5kia/Cqjv1nkzInL6sTTYuMZVyxwyk
	V4IDB5MMXIh0OJdd1wNi0PLuD/giwPAI2esojfkTImPK7HTQZN62qntdBaFESHIo
	dxpVtjYoBv/Gmu5bWfpnWazvKw2bWvzSi0i7TUZdHHFvg7DtblfNrgJqBKQV/sgS
	1JBB0RvukaxW//wOBlVgXg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1771582536; x=
	1771668936; bh=ieTHVjDH5vm+nLT4pw2oXapZaJHkJwn7bmayOGjdyZY=; b=e
	QR0rlXb6dPZm8trSRAOIPtZtw+g4tLFIiVi1p5o0r/f5dilI1co1MMuLV1r/t/Pv
	baUaUucBBB0ESJq2btW051a7mCdyme3YIWwT4OXfCr3Wo9B8JckxCq8lbAM5s16v
	o0YiZoYp1E/A1CVWwjEuHhNNeI3vSpbeGWVMwCMjxa6l5TDnDXXPgWyZ8U0sAkwe
	IgNvVQcTOXPU5p4E/fEYzlKPsZb18qjSw6mMx4ZLJCxJJAj1A1P6UCQ8y5HhaUrb
	k+uPXCwYEjWc04cVyKwFEy/FVeonhS6tfyc4eTAucQJGlx1P6dC5b3UqZzeW2gbp
	EAbS/qrKwjCxnR0YGaTxA==
X-ME-Sender: <xms:SDSYacnNyIMWTf77RaV1ef2_lVcK_0KWe9Q6w0IIK7pwtCvxtgl7UA>
    <xme:SDSYaTQsgDp288_fkyf1g-9quh-WPGrUrRmbjDUNvTvVT2_odVzuxOwheYIEnpnOd
    xnR1KvRdgXCySFua83rRMwuPlqgeR9L5DNogKf2nz8rX_uvIsqhqg>
X-ME-Received: <xmr:SDSYaYCStxzW2Rm0IzwrKN9K9GofKAU4iDaB1Q-dGfWyFqVNz35CpE4mECuSVaObGbVBO7nIKZAEiSuy_mFIX7mZTUeKfF_2Gu2wvVC7kmlL>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvvdekudejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeffueeiudejvdekheeuvdekfeffiedvueelteekudehjeetkeegvddugfdtgfeileen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhmpdhnsggprhgtphhtthhopeefpdhmohguvgepshhmthhpohhuthdprhgtphht
    thhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepmhgvsehtth
    grhihlohhrrhdrtghomhdprhgtphhtthhopehsthholhgvvgesghhmrghilhdrtghomh
X-ME-Proxy: <xmx:SDSYaSTkkh54mZZ-xPGVEgjgXeVoilH42udJh2a7qEscWZJ_LdiemA>
    <xmx:SDSYaer2FPG-Gsxfrgv2zUwriurSmX_RQd_QVFoBYH-tsHKEIMUGaA>
    <xmx:SDSYaczeDBI9jQfXjw0NuAJg6p4aQd2T0jGHQt2f1QaevI246jaiMA>
    <xmx:SDSYabIuiflSfSADnQWnKT8rgoc0l8-mLVQ-6u_UsOSV7DyPvu0AtA>
    <xmx:SDSYaTtEy0zVLeMl3Yn3cuOpkNHeFz7os1kjN5hUzHpYumi0e9KgIzr3>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 20 Feb 2026 05:15:35 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 9a5b9aef (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 20 Feb 2026 10:15:34 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Fri, 20 Feb 2026 11:15:09 +0100
Subject: [PATCH 5/8] t5510: explicitly use "gc" strategy
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260220-b4-pks-maintenance-default-geometric-strategy-v1-5-faeb321ad13b@pks.im>
References: <20260220-b4-pks-maintenance-default-geometric-strategy-v1-0-faeb321ad13b@pks.im>
In-Reply-To: <20260220-b4-pks-maintenance-default-geometric-strategy-v1-0-faeb321ad13b@pks.im>
To: git@vger.kernel.org
Cc: Derrick Stolee <stolee@gmail.com>, Taylor Blau <me@ttaylorr.com>
X-Mailer: b4 0.14.3

One of the tests in t5510 wants to verify that auto-gc does not lock up
when fetching into a repository. Adapt it to explicitly pick the "gc"
strategy for auto-maintenance.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 t/t5510-fetch.sh | 1 +
 1 file changed, 1 insertion(+)

diff --git a/t/t5510-fetch.sh b/t/t5510-fetch.sh
index c69afb5a60..5dcb4b51a4 100755
--- a/t/t5510-fetch.sh
+++ b/t/t5510-fetch.sh
@@ -1321,6 +1321,7 @@ test_expect_success 'fetching with auto-gc does not lock up' '
 		git config fetch.unpackLimit 1 &&
 		git config gc.autoPackLimit 1 &&
 		git config gc.autoDetach false &&
+		git config maintenance.strategy gc &&
 		GIT_ASK_YESNO="$TRASH_DIRECTORY/askyesno" git fetch --verbose >fetch.out 2>&1 &&
 		test_grep "Auto packing the repository" fetch.out &&
 		! grep "Should I try again" fetch.out

-- 
2.53.0.414.gf7e9f6c205.dirty

