Received: from fhigh-b3-smtp.messagingengine.com (fhigh-b3-smtp.messagingengine.com [202.12.124.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6705B2DE711
	for <git@vger.kernel.org>; Thu, 11 Sep 2025 09:16:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757582181; cv=none; b=Es+PsRAoDSU7h/c/mutPETmL2mxydlP+ve1q72V+40a5z97OBiPTMW2520kDlNl11yAL1EwzR07yna+c9CPf1iM8XBx5onbLErSblp9Ois2jqv34KuCG86KHUFDti8kGaO3b5jmAlT109jipmrOTQCYqzB5GdaXHPrwd+UjzRbE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757582181; c=relaxed/simple;
	bh=uMfJ/lAJKFu6kK+qwGXSU5FYLqdpVSEhi11Ewn3k/yQ=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=hff+YigdPqPHELhj7BRDkEs8hLp6O8+TKacm6hjt7X8FMIa6SqrX1iB0PyjFCKwRqO3w+PPndXEgKCpPWebu6epa0iOvFe1JKPX6sJGu20R6T8TSs36jTCigYb3N88XvYyu+dhgUr/SCHMCru98oRxfdhlb8AKeP8XI71TfM/+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=LLx4QWU4; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=g1QRJUn2; arc=none smtp.client-ip=202.12.124.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="LLx4QWU4";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="g1QRJUn2"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 2DB587A0068;
	Thu, 11 Sep 2025 05:16:18 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Thu, 11 Sep 2025 05:16:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to; s=fm1; t=1757582178; x=1757668578; bh=6sYZBjjOqa
	lJeS/Mcsaf2oauAFPvUGPKBgd/37dUvXE=; b=LLx4QWU4U2NRKeAQcVUuFXFH3O
	3Pg74QBXuaj9R3zmgd9eVSfLBBhcRZ9h1zauExm6R9U9Wpu9GhzjH9ZjAHPNm20E
	hUiCXkuUL2DOhRpb7jOSdR5Nbioy8ADIdNCUTx5/sWRawkS6Nxniwkxe9Cih5/Ib
	Jzv/veLXa5LstvDhyRAhFMEjXpAKno09G4GRUjWs1Byri/Pn/IpQ3mamPmLIf33V
	BxNbipJTawzxfUhPLccK8ooAdVIEET5EdRFGEfwxWdnp9f6j1Gdl+mVaWBUeyMQg
	l5TgyDEbX4/dih+Q9MbZaxt9YPhz74dzwgUqCeKK9vmKAOaCQmrZNFFC1JzQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1757582178; x=1757668578; bh=6sYZBjjOqalJeS/Mcsaf2oauAFPv
	UGPKBgd/37dUvXE=; b=g1QRJUn24CvGurk5d5UAb2AzbkUOPUsNOIbQDV8qkCcx
	yjf7zi7IyCi3DPZ8VwVqNr3jl4s2wR8l5faSnERbwLRVOhL1a4EjXr97oKLZ06x5
	bFqs2yRNjV3z8uyQGLaBfa5M2BISZMUyTe5gciFpEj0k7+D1QRLffnNWQGWFYLrv
	4ZBvQYAf0XDamlTfBNK9bMwpwkBA8u7HitCriitombsCeGicQsplcSb0PT2ggZtS
	mXjuwJVo6iLMdFQot8cJklISKTui6FBVYFuutb+FTlJFGw0s44iI4uveh8SAmErJ
	zaHiOd8aU8iBez1zJKS8ZF5CUr9tud8vVqNxDx0qPg==
X-ME-Sender: <xms:YZPCaDot2UFhtN3bEA8EhXHQvmh2kjkJhRL_PA2MH40DtuspvfM36A>
    <xme:YZPCaN1T21mgZEsLDBALjgd6HGmE4_E_lcy55Mvb1OjDAy1rQb_w-7A2OB2dSShAo
    ISL-vbecqqXkGiKAQ>
X-ME-Received: <xmr:YZPCaCCMUW1h70Q1ZGE9z9RkZVaAxeBVtQTc2YTF8AHyKk7t5dh9PxD-M3Ubul2iy4mbU-4D76wf_B_T9aSOQsr7yUGFnS5anRjlSSDWSg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvheejkecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecunecujfgurhephffufffkgggtgffvvefosehtkeertdertd
    ejnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdr
    ihhmqeenucggtffrrghtthgvrhhnpeffleeghfejfeejtdeufeffgfekkeejhfeiffduge
    dtgfeuvdegtdelhfejueegjeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhep
    mhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopedvpdhmohguvg
    epshhmthhpohhuthdprhgtphhtthhopehsiigvuggvrhdruggvvhesghhmrghilhdrtgho
    mhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:YZPCaFfn46ZwcDtT5PzVY6mIACnk6xLxwkqzEY2qGCzovFnRhUV9vw>
    <xmx:YZPCaHiVrSRtbm782B4aWebh-wEj6zhaoyRSKBBdFI71LRLK7-orHQ>
    <xmx:YZPCaNomZ0hvTLuhUKJ5vPDdBZv-Cd-GZ3cLJct3oiqeyVKygIZQ8Q>
    <xmx:YZPCaHFenQ8SHEQObe9FEd0_JTRD3NEUYunD_MD9DF15uNYTECJEEw>
    <xmx:YpPCaK596FgH1OmunYWluA4lprGY_YcFrwTL1pRQl6mElnkqCTTN9cAZ>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 11 Sep 2025 05:16:17 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 3b2dac7b (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Thu, 11 Sep 2025 09:16:15 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Subject: [PATCH 0/3] ci: don't compile whole project when testing docs with
 Meson
Date: Thu, 11 Sep 2025 11:16:05 +0200
Message-Id: <20250911-b4-pks-meson-docs-target-v1-0-a92c666ecef9@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAFWTwmgC/x3MQQqAIBBA0avErBtIyaiuEi0sxxoiDSciiO6et
 HyL/x8QSkwCffFAoouFY8hQZQHzasNCyC4bdKVN1SmFU43HJriTxIAuzoKnTQudaBrXWq2orSc
 POT8Seb7/9TC+7wcXsn8GagAAAA==
X-Change-ID: 20250911-b4-pks-meson-docs-target-56d8a21e84bf
To: git@vger.kernel.org
Cc: =?utf-8?q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
X-Mailer: b4 0.14.2

Hi,

these two patches introduce a new "docs" alias into Meson and use it in
our "documentation" CI jobs so that we stop compiling all of Git only to
verify the generated manpages. This fixes the issue reported by Gábor in
[1].

Thanks!

Patrick

[1]: <aLCf0UaTxy5Nxpv/@szeder.dev>

---
Patrick Steinhardt (3):
      meson: introduce a "docs" alias to compile documentation only
      meson: print docs backend as part of the summary
      ci: don't compile whole project when testing docs with Meson

 Documentation/howto/meson.build     |  4 ++--
 Documentation/meson.build           |  8 ++++----
 Documentation/technical/meson.build |  4 ++--
 ci/test-documentation.sh            |  4 ++--
 contrib/contacts/meson.build        |  4 ++--
 contrib/subtree/meson.build         |  4 ++--
 meson.build                         | 10 ++++++++++
 7 files changed, 24 insertions(+), 14 deletions(-)


---
base-commit: ab427cd991100e94792fce124b0934135abdea4b
change-id: 20250911-b4-pks-meson-docs-target-56d8a21e84bf

