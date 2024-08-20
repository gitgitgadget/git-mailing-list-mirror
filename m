Received: from fhigh8-smtp.messagingengine.com (fhigh8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D89A1917E8
	for <git@vger.kernel.org>; Tue, 20 Aug 2024 14:02:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724162559; cv=none; b=GVRBLfXlH/ZD4ev8oI+dzOsCWNh4dAYroPqk3v5yX7iWXVJKfSzgeXwb1FhysRJteeC3UnQpapJIsMTxIzhwfF/FXEj/kDu8LnkXK34xwKqFUHrDktAbTGaO0z4ll1vPWUB4fSrbWzROSBVJW4lDvMHSuC2UetbqOAOXOe2XV1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724162559; c=relaxed/simple;
	bh=0s9stZIUFEqy1O4BrDrMEl1JN0YLptS3F01CKy5AB7k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OsQhPK4tU9Qy5ab26ZZa3niXZQvUW0UkkVli9T9qfMVs2qbL1PzK6MQtSWsLho5Yj7veMATBlXKK7LYHaJi2Klo4WzpVZ1GYeCMxjwWhEnYB5jtkBJ4s+znP5m3p3MoYwSLimtBDVuVa52137zhS6bKf+7KRrSF6qQcg0bGtNDM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Xu5W3sG5; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ZcY4x59e; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Xu5W3sG5";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ZcY4x59e"
Received: from phl-compute-01.internal (phl-compute-01.nyi.internal [10.202.2.41])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id BA54011518E6;
	Tue, 20 Aug 2024 10:02:36 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Tue, 20 Aug 2024 10:02:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1724162556; x=1724248956; bh=2f1eyZLiZo
	ksowgvb10q0NwD3A09shVs1Nx3Xe83JX8=; b=Xu5W3sG5Hvq2gu4Yk3qJm2U7EF
	+vMXnDhP6zPlB61cVUMBEu3j2NCndKaJyahW9+2ppiEhYr52vYaiN0t8v4vxt7Xf
	7LPuBbTB38pJJ0cjNeqwfbC/leOA46qOCZECTqQWmpz8eSrZayxLmodg9qSF6q3h
	tzOifqBpQ/z2T7ElFGvLiYi56sTq9sivyAnVT6PslNoiiSiIwE2jcnjR1rdlUNtl
	tkR8Os4CRhFQYJN2dh2AH6TFnp6t08jlRZ1SqKjDsxpvUVsyfExhHgxgmCycLUhz
	ERiFyoVpTcxkKZI5fkBs1KxT6J2EZGz8WOZdoTq2OxdpvPhgCyvZeBQvDm8Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1724162556; x=1724248956; bh=2f1eyZLiZoksowgvb10q0NwD3A09
	shVs1Nx3Xe83JX8=; b=ZcY4x59eVdP5CHUgc7sCfRg7I5DGt9MUIcL+SVU6sSnP
	yJVRchq00exuXTotGA3dFd5ziS73wmnj6x6gWYHF+ZNcy54ewaLp/bg5TdkbEENW
	xN21m6dg0Rb6cM6FAYQ3dY3Hc/9hQbpUzi4UybYqr0ADrktxKmnlin9ohi4SCfVm
	isckqPKWhj2l3OrMr0JGEQhkR/8MF6TT1xBkeq+Yy6feksKPJ4J8RNq9x6zrJ4hf
	u8XGvXB+MtZGb5psXxNw2S3uAVOG716b40dqtKcpQkq7q5S88zavHIzHgWKRzFH5
	fOqUEY6NgtKjIuN9iKaCCBnlL5eUMc21I/4H/ZKBYg==
X-ME-Sender: <xms:_KHEZkB2MQeq3Ca_xQnbjkPMsST0zZM20dwrrPQLORinp06JNNeY8Q>
    <xme:_KHEZmj1Qkt5Jl8myZQt8Zcx_gLl9HzoG1xkhBP1fp00XWm4Bi06vfkUGcRM9U_IN
    w7-ksBKvuSUMLCgkA>
X-ME-Received: <xmr:_KHEZnlFPpdBYDfIxjcT_c-pcsqk0c8CBHaaoOsy9RR753Nq-gDmEz-eaNw-9WpifH5Q3X8q8kKoOKkkvKywk-rvs3VmMogMZIh7EGpJQJ4xdiU5yA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrudduiedgjedtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefgueeg
    udfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgepudenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepledpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepshhtvggrughmohhnsehgohhoghhlvgdrtghomhdprh
    gtphhtthhopegvthhhohhmshhonhesvggufigrrhguthhhohhmshhonhdrtghomhdprhgt
    phhtthhopehphhhilhhlihhprdifohhougesughunhgvlhhmrdhorhhgrdhukhdprhgtph
    htthhopehsphgvtghtrhgrlhesghhoohhglhgvrdgtohhmpdhrtghpthhtoheprhhssggv
    tghkvghrsehnvgigsghrihgughgvrdgtohhmpdhrtghpthhtohepjhhohhgrnhhnvghsrd
    hstghhihhnuggvlhhinhesghhmgidruggvpdhrtghpthhtohepghhithhsthgvrhesphho
    sghogidrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpd
    hrtghpthhtoheplhdrshdrrhesfigvsgdruggv
X-ME-Proxy: <xmx:_KHEZqy2XZYHzhtrapx4XuYqEsoiCxpO2Oj0RFAY0qe_u3HuM0dy0A>
    <xmx:_KHEZpQT2QJWohRMe-SX_-C_yWIbAlWnDzgGdC9SSaGDLcjsHKilaA>
    <xmx:_KHEZlbqWiMbRZuZwQ6eea1h7jZY94m2HHwUS2lXJKmPo1-nShNjVw>
    <xmx:_KHEZiScJMrIT6qjqYfSLps4lHA3YONtJsqIjdDI5PaVqyJ6Q5G2iQ>
    <xmx:_KHEZm_aPUxnM8I4uvod1ZFBSzdU3Nm72tyk7Y52K-SGA6KS8ZXo7KK6>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 20 Aug 2024 10:02:34 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 539114be (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 20 Aug 2024 14:02:03 +0000 (UTC)
Date: Tue, 20 Aug 2024 16:02:33 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>,
	Junio C Hamano <gitster@pobox.com>,
	Kyle Lippincott <spectral@google.com>,
	Phillip Wood <phillip.wood@dunelm.org.uk>,
	Josh Steadmon <steadmon@google.com>, rsbecker@nexbridge.com,
	Edward Thomson <ethomson@edwardthomson.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH v6 08/13] Makefile: make hdr-check depend on generated headers
Message-ID: <77a03f8df70387cb54c01dcc8b43beed829ccda8.1724159966.git.ps@pks.im>
References: <cover.1722415748.git.ps@pks.im>
 <cover.1724159966.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1724159966.git.ps@pks.im>

The "hdr-check" Makefile target compiles each of our headers as a
standalone code unit to ensure that they are not missing any type
declarations and can be included standalone.

With the next commit we will wire up the clar unit testing framework,
which will have the effect that some headers start depending on
generated ones. While we could declare that dependency explicitly, it
does not really feel very maintainable in the future.

Instead, we do the same as in the preceding commit and have the objects
depend on all of our generated headers. While again overly broad, it is
easy to maintain and generating headers is not an expensive thing to do
anyway.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Makefile b/Makefile
index efd305ab358..8c4487dd0c6 100644
--- a/Makefile
+++ b/Makefile
@@ -3284,7 +3284,7 @@ HCC = $(HCO:hco=hcc)
 	@echo '#include "git-compat-util.h"' >$@
 	@echo '#include "$<"' >>$@
 
-$(HCO): %.hco: %.hcc FORCE
+$(HCO): %.hco: %.hcc $(GENERATED_H) FORCE
 	$(QUIET_HDR)$(CC) $(ALL_CFLAGS) -o /dev/null -c -xc $<
 
 .PHONY: hdr-check $(HCO)
-- 
2.46.0.164.g477ce5ccd6.dirty

