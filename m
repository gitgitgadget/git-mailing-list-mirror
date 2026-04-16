Received: from fhigh-b8-smtp.messagingengine.com (fhigh-b8-smtp.messagingengine.com [202.12.124.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EA63390202
	for <git@vger.kernel.org>; Thu, 16 Apr 2026 11:20:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776338410; cv=none; b=lQ0onYCOSQrXwjLTorAAjf+Ouj4iGg/cKV5AV0NmAkm21qACDexpBDIB9+De9I2BvR1hVoD+OvpNYzpvDuyUyVR5oHgr3M5h+szeT294/5dTGmnaT50S2G+HOOKwzFEjeUJM7Pocy6vRFzyFHoD6iLh8+QY9ulisYQY1oigjxhw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776338410; c=relaxed/simple;
	bh=szcnxfo8q9aLdaWi90uJfx/R6EkuxTEKWziHRX1dnyI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Fg5i5Jj5PPSYlomI8HyBjRdY9yfeU0ijvXfIcqubbIYDp7Ui+Q/GYkvJdaOphWWUCOZRQ6Xiog/WvIBNZRMCxVyj9b13Ou2RcC2Gq6N7l/wyIOZCo75qR0gYkLbg6eUi1jJB4FfxidylUs//g5pl8vCZAZyb0Vuylj+eH8aDYSo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=lry+Uuh4; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=jQa3e0CQ; arc=none smtp.client-ip=202.12.124.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="lry+Uuh4";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="jQa3e0CQ"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 2D1227A0272;
	Thu, 16 Apr 2026 07:20:09 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Thu, 16 Apr 2026 07:20:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1776338409;
	 x=1776424809; bh=/Ez5O9tWl0/Rhe4Saz9TFIzKJd780EhKv/f5xDwHXq0=; b=
	lry+Uuh4hmWw1XbxjUpB0aZMazWOwMaT9yuBbYqiVoHnvpwns/Y2UPEum2P1N9qI
	n3oJ/GFT9voUq4xtzRIWhnc2JqBMvSmUAa4n6Ex4ChUXlsDZC/cgIrts+KhCchyF
	BgMH/u3AcUaSwirotQVXYIWGftoYt0l1YD4N783t0zIZeOdnKO/lNaavZxN5/1nL
	dL4EEphrdqFQVVY2uvLuciIQM6+LEzqlDQ/CiVJW4o9g13uorpeqylrVzMHuiZoT
	lvXTFbOavPAcR+FMRDyp6NpCFM7zlWLEwcX/rsItvbEnUx+ZV/OdOIGxkOHCfZeC
	DbA87HpM7dWyQNn251lqjQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1776338409; x=
	1776424809; bh=/Ez5O9tWl0/Rhe4Saz9TFIzKJd780EhKv/f5xDwHXq0=; b=j
	Qa3e0CQVOkAKxnQ5DNT7P4EJqVv+dyzMPWJVw+AeLEqISfShc4FXDHY+NLE1yWpc
	BtvqjxGC71gH0WwU2i5vDWJfsw3l/twG893B2agaIEfqiFL6dQH/zETsG/YOGfnN
	7ObsEyK90pvnYD9FUgSwyUyqFIua9kxEA421lJrvpiUMGerDZrtw/X/BIIleT72k
	Xz7ZEk/K32KjLdQWZOyq35zMSmHPpqX30GNgLnlwWUXM1LavWIcV1B9ceP60NJ3W
	gnzDnqwOJ32zHOQkHk14gZekalovDNyxmekIeyB/um0zjq1t7V5ub+dr0Aqpbcle
	QJG6NEg1U+JGc9wW4rbtA==
X-ME-Sender: <xms:6MXgaczRtjH66awWemj_qTCKw175YY_g9_TEE5vAzdNVtlLwBf2Sqg>
    <xme:6MXgaXuTNm1OviejmJcjxKiNjMhvwKi7a7WWaHLKdmv8KV1B42NoS_qXCQG4agrsG
    EXjkAIncsf_bvEkav0UULIZyoy2D_-JxVWy49CcQNvr5iBnHfz_cg>
X-ME-Received: <xmr:6MXgabtVn1zecsQ1nhDUoBOrWSu9S7Lqgt_SUC5h5-ny2x9s_vKMdqwtXlWSajal5jlLHL30bN4267wMf-CWhoe4cXJMhwnpFPvDqkWIkg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdegieekiecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecunecujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertd
    ertdejnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhk
    shdrihhmqeenucggtffrrghtthgvrhhnpeffueeiudejvdekheeuvdekfeffiedvueelte
    ekudehjeetkeegvddugfdtgfeileenucevlhhushhtvghrufhiiigvpeegnecurfgrrhgr
    mhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeefpdhmoh
    guvgepshhmthhpohhuthdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
    pdhrtghpthhtohepphgvfhhfsehpvghffhdrnhgvthdprhgtphhtthhopehgihhtsehvgh
    gvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:6MXgaUMGDLLrgl_sZKMXFCY-vzB41dl7Vv3pG65Ri9Vw_Ui01mE5tQ>
    <xmx:6MXgaR1Y5OadJflOy6xPZngd13ZuZJJSuiobhg1YMCDQATDBFHpFaA>
    <xmx:6MXgaYMTseEuVxrw9wIgaCrmJ6KwpVO2kgmhf9Tdt9SIcV7u6YBGmw>
    <xmx:6MXgaZ0KhDQHjuFsNdsRPFPvnVqng5T8BBiv9qSjkkY-TK7w-XJxPQ>
    <xmx:6cXgaacx8PPzXvmBL0CRK-8w0aXK0WnZl803yuUO1H3a7vawSCvzW4ch>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 16 Apr 2026 07:20:08 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id ec4f25ba (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 16 Apr 2026 11:20:07 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Thu, 16 Apr 2026 13:19:28 +0200
Subject: [PATCH v3 11/12] t9902: fix use of `read` with `set -e`
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260416-b4-pks-tests-with-set-e-v3-11-7a90e5dccadd@pks.im>
References: <20260416-b4-pks-tests-with-set-e-v3-0-7a90e5dccadd@pks.im>
In-Reply-To: <20260416-b4-pks-tests-with-set-e-v3-0-7a90e5dccadd@pks.im>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
X-Mailer: b4 0.15.1

In t9902 we're using the `read` builtin to read some values into a
variable. This is done by using `-d ""`, which cause us to read until
the end of the heredoc. There is a gotcha though: when the delimiter
isn't found at all, then the read builtin will return an error. This
hasn't been an issue until now as we didn't run with `set -e`, but
that'll change in a subsequent commit.

Prepare for this change by silencing the error.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 t/t9902-completion.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/t9902-completion.sh b/t/t9902-completion.sh
index 2f9a597ec7..e3a7df7691 100755
--- a/t/t9902-completion.sh
+++ b/t/t9902-completion.sh
@@ -590,7 +590,7 @@ test_expect_success '__gitcomp - doesnt fail because of invalid variable name' '
 	__gitcomp "$invalid_variable_name"
 '
 
-read -r -d "" refs <<-\EOF
+read -r -d "" refs <<-\EOF || :
 main
 maint
 next

-- 
2.54.0.rc2.529.gd9106f7525.dirty

