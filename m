Received: from fhigh-a5-smtp.messagingengine.com (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DC52347FD1
	for <git@vger.kernel.org>; Mon, 16 Mar 2026 10:08:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773655707; cv=none; b=Zse3R5HdnvR2eFTZ5BCZFABmDS+0HF8VqxoPswv0YJCdxpD05Ms6XvV1yEnHe3V5DDNhHOy8BiKk1kQebf3wz6Wum0URTaGVxDLZgCJI0G65p+SNIgxIwQhWX4/7PMFvSE/66yvufqWWi4d7PiR1RTomBe9sh41MoHk4MhHCBgc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773655707; c=relaxed/simple;
	bh=ZTJ5uVMB5tUOJTfCv/vZIOydimgAE/bnEuUKdZEvUl8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=R7ktofFSounrK10ZEaCSSRXvOTYhRFXuHfBdqBVa2OhKB4jI/HS+gk5u1y+zOhi5McSZsIIlLTomjJlviZDi1XnnXa2ThXWjbFowIKnOwBrbwfLYbFWPxvjpGpUU2dB4+eL4ge93R6S/YiWDZTtTv86/9CdfqHOvm1UVpkZYxf0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=biT58/wm; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=wWR+8Sw3; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="biT58/wm";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="wWR+8Sw3"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.phl.internal (Postfix) with ESMTP id D0E48140019F;
	Mon, 16 Mar 2026 06:08:25 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Mon, 16 Mar 2026 06:08:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1773655705;
	 x=1773742105; bh=4LEPWQtf17EtKp1zNQpjEGhWXWK0ltZjIOmQLQgTysU=; b=
	biT58/wmSe5sUpFulqkiofWvzZDPJvnKVt85CwMQHeP642qz/UiuZSu6hbPMnCNY
	dz04MW5S3t77EEnd4OipmI+xfrBVjbDInqjNdSICh+Z9mVO3UE7pRLDXktNISA+/
	NGKR8ctb5+OJFiiQUltnGwx1mLfTo/v7+/1PYE8UEusEnbPH0Xhcdlc8/zsPNHnm
	7Pn+TWFUqORLWThY0UujouScrI1JFyAu/7pQtGA1/+uxfUDSDlD3EVYfdnZ/dtXa
	PfnyZGcZuEvorPhpzW3SIBmLxGTdTTG/QcP01KGnY7YPjjmDFmCJWgW2ujDcWkve
	WDGtPSCp8hZbq4pP/fOdFA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1773655705; x=
	1773742105; bh=4LEPWQtf17EtKp1zNQpjEGhWXWK0ltZjIOmQLQgTysU=; b=w
	WR+8Sw3uAz0hsgZOCW30QwfPEHz+NAD5KdLkJ2Diob+wLl3hf3fsSrzQRVIzq8lc
	p24zGj8TPEYG8aEAMCQNUIo5W6yimozFJR1JEyUiz20+qWxsRZdV2ir1A686BQtL
	onziBU2ZGaApLc5N9iWkbujLuaciw5rRAbP+Hp76UixcsHTD5iWrLHqMQ+L30CtH
	DzTAc5NHYkFTlZENMZYPDGkDc7zGxsO6PXN8wFs11eeyaJrGnnkV50znSeZRN9GL
	ynrROJWfxhv3YkYyn3jNZUFgo5OKe08uF9YZCcfCZ6Nit27ygUL3nXP0ch16abK6
	5sll8FLlSMpEOIpQ/T8Ng==
X-ME-Sender: <xms:mda3abSmZu_0YrpsAiEa8uFjsyMLPDP6GkZp7bcAh8ssy08rBz2v6Q>
    <xme:mda3aanAisfQmqe3tL0XTO9BaNGMrgmX9hzWFIIO40sUBtdQ2w3NY87UbenuNB0bo
    ZgwWKay5JEIl2ZyosxHOPJmMbiWNZcU5eG2U_xA0y5oeWYmPMggvSc>
X-ME-Received: <xmr:mda3abQTOXbT-Jwy5Fkhy00NE-RW8wePAUqkIdkeHJFJtLfnaBnd19UKB56PaJ9f-O0QmzhaZ8wFlWP6vDxw5LXQjCDXJpupmIb12MZqdlQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvleekuddtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeffueeiudejvdekheeuvdekfeffiedvueelteekudehjeetkeegvddugfdtgfeileen
    ucevlhhushhtvghrufhiiigvpedunecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhmpdhnsggprhgtphhtthhopeegpdhmohguvgepshhmthhpohhuthdprhgtphht
    thhopehsiigvuggvrhdruggvvhesghhmrghilhdrtghomhdprhgtphhtthhopehphhhilh
    hlihhprdifohhougesughunhgvlhhmrdhorhhgrdhukhdprhgtphhtthhopehgihhtshht
    vghrsehpohgsohigrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlh
    drohhrgh
X-ME-Proxy: <xmx:mda3aYNphy6ke-2RArdgsfIjDGA9vplucKu7-uDLhidZaGH5Oldylw>
    <xmx:mda3aUWyIt8szBBaxkXMN8rL_ImpFEVkhAuF3LtTcfAiKQj_Qtv7Dw>
    <xmx:mda3affLuHZ1XgFXPd1_UTKeZr34k0jaMsQgHT3QzekloFQNy2eYog>
    <xmx:mda3aQtVtXAccqea2svpN8pN7tb_4PyQfCgUqIuU3jLyxDCLrQCq1g>
    <xmx:mda3aYOvWNEe87kkvgEYb2T10e1KkOL1NA6xX6n_4yMXYsIc9amkGvgb>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 16 Mar 2026 06:08:24 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id f7cc7d3b (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 16 Mar 2026 10:08:24 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Mon, 16 Mar 2026 11:08:01 +0100
Subject: [PATCH v2 6/8] git-compat-util.h: move warning infra to prepare
 for PCHs
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260316-b4-pks-build-infra-improvements-v2-6-4b2c2c0c0425@pks.im>
References: <20260316-b4-pks-build-infra-improvements-v2-0-4b2c2c0c0425@pks.im>
In-Reply-To: <20260316-b4-pks-build-infra-improvements-v2-0-4b2c2c0c0425@pks.im>
To: git@vger.kernel.org
Cc: =?utf-8?q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>, 
 Junio C Hamano <gitster@pobox.com>, 
 Phillip Wood <phillip.wood@dunelm.org.uk>
X-Mailer: b4 0.14.3

The "git-compat-util.h" header is supposed to be the first header
included by every code compilation unit. As such, a subsequent commit
will start to precompile this header to speed up compilation of Git.

This will cause an issue though with the way that we have set up the
"-Wsign-compare" warnings. It is expected that any compilation unit that
fails with that compiler warning sets `DISABLE_SIGN_COMPARE_WARNINGS`
before including "git-compat-util.h". If so, we'll disable the warning
right away via a compiler pragma.

But with precompiled headers we do not know ahead of time whether the
code unit wants to disable those warnings, and thus we'll have to
precompile the header without defining `DISABLE_SIGN_COMPARE_WARNINGS`.
But as the pragma statement is wrapped by our include guards, the second
include of that file will not have the desired effect of disabling the
warnings anymore.

We could fix this issue by declaring a new macro that compilation units
are expected to invoke after having included the file. In retrospect,
that would have been the better way to handle this as it allows for
more flexibility: we could for example toggle the warning for specific
code blocks, only. But changing this now would require a bunch of
changes, and the churn feels excessive for what we gain.

Instead, prepare for the precompiled headers by moving the code outside
of the include guards.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 git-compat-util.h | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/git-compat-util.h b/git-compat-util.h
index bebcf9f698..4b4ea2498f 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -34,10 +34,6 @@ struct strbuf;
 #  define DISABLE_WARNING(warning)
 #endif
 
-#ifdef DISABLE_SIGN_COMPARE_WARNINGS
-DISABLE_WARNING(-Wsign-compare)
-#endif
-
 #undef FLEX_ARRAY
 #define FLEX_ARRAY /* empty - weather balloon to require C99 FAM */
 
@@ -1099,3 +1095,7 @@ extern int not_supposed_to_survive;
 #endif /* CHECK_ASSERTION_SIDE_EFFECTS */
 
 #endif
+
+#ifdef DISABLE_SIGN_COMPARE_WARNINGS
+DISABLE_WARNING(-Wsign-compare)
+#endif

-- 
2.53.0.959.g497ff81fa9.dirty

