Received: from fhigh-b3-smtp.messagingengine.com (fhigh-b3-smtp.messagingengine.com [202.12.124.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EF3446983E
	for <git@vger.kernel.org>; Thu, 15 Oct 2026 06:57:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792047459; cv=none; b=GDGFAfrsAuZXmo+HXIKmoOIMKDHuzMr67XQDUNF/uh5nctQk+vuXXtudcYkJEN87xVAhF0gDR5SxyhkMFQ+MqZJcf+k2MLnk5IryvdQrMG/izWl4ZpHKdVI4Ms0tQV/aJNbCheW21nRMivn3ertkJtYqisO0VPGwzbxUDtuw6vk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792047459; c=relaxed/simple;
	bh=/uSXuqH4oO8uS0lqlWqgrcej4oF5+C8hgGNW6OyLmrM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=YbToUGp8Vzvk3emgwzu6TjkSrFYbIoMuK1wqPBmUPBSYdQuw6L9HFc+G+eRJKiak20oYAPTG39hY3777bXIeKk3JJ0NjgxU4Titjl0FCD5RvcmYjskalopyeNjsQ6TOUQI4+FrwB8XryPP6nGjj8fgUXXI0I0MXwMAvxhMOfgL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=p9Q+qBhS; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=h0HecwV0; arc=none smtp.client-ip=202.12.124.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="p9Q+qBhS";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="h0HecwV0"
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfhigh.stl.internal (Postfix) with ESMTP id CFCC77A01AB
	for <git@vger.kernel.org>; Thu, 15 Oct 2026 02:57:31 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-09.internal (MEProxy); Thu, 15 Oct 2026 02:57:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1792047451;
	 x=1792133851; bh=bJuZtdK8P5w80Fi5i9ZRUP1wYcUwXO99yzQMMVoM3eQ=; b=
	p9Q+qBhSv+/WgFT659RtWerpn1eMIEDz1wIypwINBC9v6yvTJBHUYx+6sDeL+3xa
	wFLuwIpHeQAbewX/wW8FLeHDb0c0pyoh7cPUiztuMmQpLd6JwGRbeCMdOs7H221x
	FnnL6G4+lDVz7p7rwqA9DRmY2Y6lpLddI2ve6tMnL2/KafFK3HVwdbGczWzj64dm
	KXW6AmVtMoAgmBkIYJDVJ8QSxIlqzphuBpHVp72RaVFny5o476zh741t3BS3u9mD
	qi/ODk1W+AGiU8IkACWkYHnvr3amQ1fJvsmvqNdm9YTzhMeamK7oO8LbsU1WdA0b
	xj7Ul5m5F7O4PzasUaWtyQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1792047451; x=
	1792133851; bh=bJuZtdK8P5w80Fi5i9ZRUP1wYcUwXO99yzQMMVoM3eQ=; b=h
	0HecwV0V6CP5O6bQFoS4J6azczPreDHeCAzKCjzmuZQRpLBmZlUGxMxrm9+0wp8Q
	WYsi+4IiuA7OMPqwqreVzETVxs487vlK5SUdazd3jP0+2rq9xxsjzTCNUYdUaiAM
	LEJGOsJujEriObb4KVtoD5TwdYFRXB6xn+yL1chSgy/40jxREBfTJyOzX/dTZOJJ
	vF/6yeFwE73fezsrY1stuwRvYCrMGevJ6tnl/sWohMti8mitAJtJJO1UOnLI08Af
	7ooOD55/OAOuCNsWat0f/ykXZa7+vf70WurVscaRiJhK18Drbn1yVWMVqU7lyAeY
	ZsfDLJ6VOWiM7N1+Y3gYw==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=sign d=pks.im a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1792047451; d=pks.im; mf=PHBzQHBrcy5pbT4=;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:YKkZVYL/BE7YR7WVF0157HSaSLjseRJOE+a4Edhu9il4JhY
	GkzzzZNzHpyV3FN7hDr6WFYWqOIryGg7ZuMp3xNRlIZ/sDTlACZ+dkw6n6m4odFk
	890j+PlQyD2F/RywqnQwHMA7NKQrJGug/NVahx8icv6YLKNBb1k1VE0b5CZTXMXr
	eefUcRG7ufMMu9cBRGn2lZgmv2BQ6grAYACB9h1S9YwVuxjdZT35vob9YuOFV9Jl
	2FqZpIymMp/8lhchmOTL4U9bnGxb2ewLSyFALfAAJnyVufnlnhOLRiX9zV8nnicl
	TNw/Yvrk3xDel5caoSjEdcvtUEL1oYFPEdA2lyw==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-transfer-encoding,content-type,date,feedback-id,
	from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:WRrEP9r12WrX4O2vwQYfkM1d40pt2wzDUznKWX/dzJo=:/uSXuqH4oO8uS0lqlWqgrcej4oF5+C8hgGNW6OyLmrM=;
X-ME-Sender: <xms:W3nQaq-_sUhIHeia06KKZ2vgM1b_uiYSle0B5o3S0PXUTlioPccZ0Q>
    <xme:W3nQauYYqxT7oR8VQf5E6mOYa_miY4yNYe1eZZcmghuhiftr-NYUbgknu8y3Pr98T
    yeRHDpYh9WCJHMzB7fo-fmTR4nD4-k1krS6S_ujIFnCCC2l4wzN>
X-ME-Received: <xmr:W3nQap2YAzZywwY-HIn1bQbzUZYj8J9vy-GeTZgVqZRVf3cXgl-TRb5Berl6W7pSjbak814>
X-ME-Proxy-Cause: dmFkZTEtUvAGxsLJTUwND9VYUlYlcfzw4leHbfFICa9Zbzi8Ve0xk99hOMrC8JWgyMNjpL
    d8OU2RGTcaPEzrBKb4q0VSV6wqeZkD07LkmT9JDuWFN84fpWt5K8Q+GRvd1lcDDbz/LoOV
    kwt6oy4K98UcTaAIFJE2C70gLxy6yrO6zgASwulP2/gUH3qV0wZ6mPTL8dHHme0JzPWTgK
    HUq21r/Zut+zgaXkWH60B3u6v4T/jnwvKyPxQ7Rlghx4TlScz7P3jdjipOCLu+qNDnQzX3
    18xZCH1OxjLia46gLGM0s2D2lumAHp9sZQUiVmTTqNhG04DcMBQQ8yDrd85c+15nCEhKHu
    KZHGV5QRJkTp7Y5/W6LepDxJ7iRPl9CbEHoor6TUT1H/gp5qg3AemeW+Z0W7ZL4LDQWVqx
    kzpVIEeh+mIQfRX0VnKq6ccPgIskoV/uMll0sR9438rXPPl00GwNv5ndhlPDJbWjE4ubhO
    Z5YX3Mflqah7i5XHTKDyW8jxqkRCLoJ6FfORBR9u8IUGhfOHgZtAP6wYvfIFWGjdRJqqNN
    TrxIxj125mICO7s01U0ykPJTc+CfNslq5/im9gjjZEa2AWEqg17BoTMZRHgOGHw1vafvIm
    l7FNCfetHFmctbu/DUXs53pkI6yDPXns8HmYJFj3HygnRBlmovZH/XtCvnPg
X-ME-Proxy: <xmx:W3nQapZ4TvURgGTmSRQo3J6n_gs0QHzdXz988ymgZsxpbGTAQF6T5g>
    <xmx:W3nQahLrfZegM0wnwqL02UMYdvUVnp5C5wUZx95Vouc2Onu0WVPI6Q>
    <xmx:W3nQaoFhl4Hf5mCzhYzCnR9JuRoWxDkB6bbRM7cE-LRIP1SF_HVZ5g>
    <xmx:W3nQaovgAv4lR87dRYHAHH5W2wovffZwYFGm-t3lJ6s-Kx0buE6cNQ>
    <xmx:W3nQajsqF5SgiNy2KYtC3uBDRuetxEwiGMpknDyTc0YyDhosckP_wJJQ>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 15 Oct 2026 02:57:30 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id bcd972bb (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 15 Oct 2026 06:57:30 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Thu, 15 Oct 2026 08:57:15 +0200
Subject: [PATCH v4 6/8] ci: switch away from EOL'd Ubuntu version in
 linux-feature-testbed
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261015-pks-ci-housekeeping-v4-6-c2c88f1b198e@pks.im>
References: <20261015-pks-ci-housekeeping-v4-0-c2c88f1b198e@pks.im>
In-Reply-To: <20261015-pks-ci-housekeeping-v4-0-c2c88f1b198e@pks.im>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>, 
 Todd Zullinger <tmz@pobox.com>, 
 =?utf-8?q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>, 
 Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
X-Mailer: b4 0.15.2

The "linux-feature-testbed" job still uses Ubuntu 20.04, which is end of
life nowadays and starting to show some cracks. Switch it over to use
the "latest" tag instead so that we don't have to constantly update it
anymore.

Now arguably, this reduces test coverage for old versions of Ubuntu.
But "latest" at least points to the most up-to-date LTS release of
Ubuntu, compared to the "rolling" tag that uses the latest release
regardless of the LTS status. So while "latest" and "rolling" are the
same right now, that's not always the case.

Furthermore, we have other jobs that test with ancient versions of
Linux, like for example the one that uses AlmaLinux 8 (2021, originally
tracking RHEL 8 from 2019) or Debian 12 (2023).

Note that this also requires us to switch away from GCC 8, which is not
supported by Ubuntu 26.04 anymore. Instead we simply use the default
version of GCC.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 .github/workflows/main.yml | 4 +---
 .gitlab-ci.yml             | 4 +---
 2 files changed, 2 insertions(+), 6 deletions(-)

diff --git a/.github/workflows/main.yml b/.github/workflows/main.yml
index 60f262db39..47f174ed0e 100644
--- a/.github/workflows/main.yml
+++ b/.github/workflows/main.yml
@@ -409,9 +409,7 @@ jobs:
           image: ubuntu:rolling
           cc: clang
         - jobname: linux-feature-testbed
-          image: ubuntu:20.04
-          cc: gcc
-          cc_package: gcc-8
+          image: ubuntu:latest
         - jobname: linux-breaking-changes
           cc: gcc
           image: ubuntu:rolling
diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
index 726c1c1865..3e2e6083cb 100644
--- a/.gitlab-ci.yml
+++ b/.gitlab-ci.yml
@@ -43,9 +43,7 @@ test:linux:
         image: ubuntu:rolling
         CC: clang
       - jobname: linux-feature-testbed
-        image: ubuntu:20.04
-        CC: gcc
-        CC_PACKAGE: gcc-8
+        image: ubuntu:latest
       - jobname: linux-breaking-changes
         image: ubuntu:rolling
         CC: gcc

-- 
2.56.0.212.g129ede20d9.dirty

