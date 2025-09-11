Received: from fout-b1-smtp.messagingengine.com (fout-b1-smtp.messagingengine.com [202.12.124.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B13262EA174
	for <git@vger.kernel.org>; Thu, 11 Sep 2025 09:16:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757582189; cv=none; b=aiRg0grnazH6HcZIGPER3BT2ABwtcNxTFzxw6haA9S9cEX4lGzkWHRHA0mR5kjNsPY4BdAEzulYaC8juiuHABHC1L/hm0LTCGTulxm4uSBR7K/llsXAjalB5dTSBwjsKC0SxBy+Bbfz9ZyAgxwO9Qk24apzxAGfvy90dise2isg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757582189; c=relaxed/simple;
	bh=/SkzMg2+cXHvVbo/tk/VFRtsnps6bXmdQgnbY9SKEk8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=SDPKifUkzmjVUZuDdhJAFBqQZTErCYYLlL4DwHrx/YcyJuLo221R7AET3B61pf84osNQhvRpWNGrDKScuo0KvuR5jpjMm4XYUv2bYm228s/kUZenjgrQrbKm8fCMfLKLOHWSANEHwpy+rGLFx621050UUajVPZjngrv8/7psA94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=qJRJy+GQ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=UG4ZPWgC; arc=none smtp.client-ip=202.12.124.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="qJRJy+GQ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="UG4ZPWgC"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.stl.internal (Postfix) with ESMTP id A54E31D00117;
	Thu, 11 Sep 2025 05:16:26 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Thu, 11 Sep 2025 05:16:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1757582186;
	 x=1757668586; bh=VJxwnrXswsTqNrDaTTRnBABH8IwoE7RwJx9ptH/ztqA=; b=
	qJRJy+GQxAxjz56v08FEE4ySoc3PlEnCXcNZgTlGm5PjJ8BF2U+XpAufdwVJUk/V
	PDRTP4OI9gbzV/aEEacm+Zw+g5Zt12IiEnchO1SWH7QuLweuo2KGDB6HxX9ahRh1
	lPu8kBwXmCmkxVP/7Juy9mnkwrU2n5cno8Zn1HVo1Sfzim4VSiYYGV4RyTgX7CcH
	Z2os6aphK94V+t3Th39YW1ijwOMl7W11nLqT4IxEYwmBR8X/DkayVWtkUf/6nlji
	eLHQ4q7AfDTephsqxI3YetOyC5U/zUklSEGB0afAWR5EJXVTg7WmylZ3dHXbuzdq
	JDPl8ywyuFhFsba9yg0TDw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1757582186; x=
	1757668586; bh=VJxwnrXswsTqNrDaTTRnBABH8IwoE7RwJx9ptH/ztqA=; b=U
	G4ZPWgCcCoy/28W0fG3hINmr66icDMpAnlsfu0qFPG84cOJ9fLidYpRcNJ7L9RpT
	aET+fsdc4nm1b/BsMAu+VvWyBtLP+tpCRko2p8/9TYuj8Isz/O+ObyF3v7PSUlr/
	U+qwBNnmucueHV+Iv3Ry+TtDTrrkaCQaQM/C6Ll22rVQnO164W6U/HHgqs0lKdaE
	KHU7QY5rGcirVU5zyY02QWeirIgtgGsniK9l2HqfqI00DLg3FKpVrU/dC6JHuuqm
	UqzNZwTdPt3oBnT4EPZJ0lNE3/1TsuYMwryZbuNJajw+YoZOeeZ15ZG/xAM4zalK
	p1sG0GID+OBD5ZOWqbVhA==
X-ME-Sender: <xms:apPCaIrc4V7R5n5TKV0o66_kBx4n7jLYPVqfyVn2HsVcZIPld3CzfA>
    <xme:apPCaO3Yz4HPfJaHwGl5V-5Spd1MP3Yl7nlq--O8K2AtaOW45Hy1Fd3CZtNjAFDeS
    Lz5f0Cf1oJ2SyVx2g>
X-ME-Received: <xmr:apPCaPCTuqrGmFgb3bz7QYX7x8-iRjbFEmZE2Ye_uYdwTTGqNcQqPzMZc5s5_QSK1nj8EkxL-yCF7ibe8L1q0Qp3rT4r7-HNf4RDrRr99Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvheejlecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecunecujfgurhephfffufggtgfgkfhfjgfvvefosehtkeertd
    ertdejnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhk
    shdrihhmqeenucggtffrrghtthgvrhhnpeefhfeugeelheefjeektdffhedvhfdvteefgf
    dtudffudevveetgeeuuedtkefhgeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgr
    mhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopedvpdhmoh
    guvgepshhmthhpohhuthdprhgtphhtthhopehsiigvuggvrhdruggvvhesghhmrghilhdr
    tghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:apPCaOcaYb0SCQtikWVEJvqNXp4bR8rdOCRV19XbbTrVb1_lBB1Yrw>
    <xmx:apPCaMjpD50Z8uFXlt0eFJmE_EeH4dt535LoLKXBp3Q97q_zmyM4mg>
    <xmx:apPCaOrsxPtK_f40HtzBrykQZybN2L2PHGMJiJq5BBAsssPzAmm9OQ>
    <xmx:apPCaEETPSVPjkxusUCnkEBie2SwxWYKywxU8DTaw3j2AyciT_3Ppg>
    <xmx:apPCaP6hP2UwwAarjVRLrQ2Na1BC14e61A4hlM5_ZlNaqRDyc_QOrzjx>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 11 Sep 2025 05:16:25 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 71214b4a (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Thu, 11 Sep 2025 09:16:24 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Thu, 11 Sep 2025 11:16:08 +0200
Subject: [PATCH 3/3] ci: don't compile whole project when testing docs with
 Meson
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250911-b4-pks-meson-docs-target-v1-3-a92c666ecef9@pks.im>
References: <20250911-b4-pks-meson-docs-target-v1-0-a92c666ecef9@pks.im>
In-Reply-To: <20250911-b4-pks-meson-docs-target-v1-0-a92c666ecef9@pks.im>
To: git@vger.kernel.org
Cc: =?utf-8?q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
X-Mailer: b4 0.14.2

Our "documentation" CI jobs, unsurprisingly, performs a couple of tests
on our documentation. The job knows to not only test the documentation
generated by our Makefile, but also by Meson.

In the latter case with Meson we end up building the whole project,
including all of the binaries. This is of course quite excessive and a
waste of compute cycles, as we don't care about these binaries at all.

Fix this by using the new "docs" target that we introduced in the
preceding commit.

Reported-by: SZEDER Gábor <szeder.dev@gmail.com>
Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 ci/test-documentation.sh | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/ci/test-documentation.sh b/ci/test-documentation.sh
index 49f87f50fd..5e4fd8fbd7 100755
--- a/ci/test-documentation.sh
+++ b/ci/test-documentation.sh
@@ -48,13 +48,13 @@ check_unignored_build_artifacts
 
 # Build docs with Meson and AsciiDoc
 meson setup build-asciidoc -Ddocs=html,man -Ddocs_backend=asciidoc
-meson compile -C build-asciidoc
+meson compile -C build-asciidoc docs
 check_docs build-asciidoc AsciiDoc
 rm -rf build-asciidoc
 
 # Build docs with Meson and AsciiDoctor
 meson setup build-asciidoctor -Ddocs=html,man -Ddocs_backend=asciidoctor
-meson compile -C build-asciidoctor
+meson compile -C build-asciidoctor docs
 check_docs build-asciidoctor Asciidoctor
 rm -rf build-asciidoctor
 

-- 
2.51.0.450.g87641ccf93.dirty

