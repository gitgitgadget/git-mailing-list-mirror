Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A31881727
	for <git@vger.kernel.org>; Thu, 19 Dec 2024 15:55:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734623726; cv=none; b=Wr73QqIfbHo0gzQpy4IlQXOd0UbmdoPI+rUYEe5Q81uF2OqdUeT4ut4jwqfv8IReoeX/zqSWznWyWRxrP+irfMEQTCKvkhPKbULr7WAJET/KXFF3o64zpBOX9a5whziV5ZKR3pjwsq+84Et7PdtO8sxMmYwD7S+GX7j72VnzeHE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734623726; c=relaxed/simple;
	bh=8ASFdNjtSJ9it4apK9od9Su7redTgkuuPOl0cqtzurE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=oRQC9VzSF78LtM7ANUPcF6Ca3x5AJ5NB5CH0+J4c8cd3XmXrPobHaZjSRlvkLNXLn1kOUOXrUZHjTeNXIj/L1HQLFofd0b0AuhHxgpV+GYT6goxaPY3qp8pu/In9+4xrOPyN4aBBicoM1slAsWYZaK7K3BtjaMGoC7UZQ8JSzzI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=GDlvREvP; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=FO2PfuVK; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="GDlvREvP";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="FO2PfuVK"
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfout.phl.internal (Postfix) with ESMTP id 443F7138024C;
	Thu, 19 Dec 2024 10:55:23 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Thu, 19 Dec 2024 10:55:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1734623723;
	 x=1734710123; bh=16OlhAdG/mT3wE+RoJ0qEFfeh4n5IIb+M0LtHiH8S4A=; b=
	GDlvREvPCOt60uTvyDUbGm/Oapz60bXjWBewbP2dpxmgs7v7HEm6Dk5jLWDQSHgY
	SQeZDEGMmXT52sOCV2FHhaEi7RRTK9p3XzSp3UtUHNzzGp6LErp2kQprSO/d6ihu
	VBMiqXhrdVpPHi41zq70TXGKadp4RogF/AcfSxfvCgbVku+KZvXIAiaBA1479vdK
	ktFK4DyPNMC81Y5I9jp0LcbxYA8soGtmQbeGcnw+d8wiaKal2TRaQZ8/DWnqHDR+
	GXg6W6yV/Awf58P8/J2zvRk2nLyKZzOE5OxRG6aA7wq/LqrgMN7XOxKPxdigr5LS
	K7q3ehmsE5ejfao3/zcqhw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1734623723; x=
	1734710123; bh=16OlhAdG/mT3wE+RoJ0qEFfeh4n5IIb+M0LtHiH8S4A=; b=F
	O2PfuVKdW4w5b5Px2jIuMCglW3/nbA1xni0Jic8f+nP3gpPF69v0dVQE8u6WIu9u
	huMvW6dXp1bzdyU02UMxRT79ydb6ed4R3UiwxfFoNoI7wIpX+8MgwjGy170IgGi3
	wsX3d/5QM1KXVwy2P7lmHR//LKlzGinp2QaqbPyGJyyOe/qY+kFYXI6WaO+UWey2
	TtjFqx4I2/tqQXIGSQ/H+mrmgN8P7croWVG1u1WhljoH61H2eVWLtqyB6Pj0NOh1
	tSvHO0ixKZO10WAvAwAZGRTXNsouNKTpzLD0WRODYKgxVP+5s570P7bas6U5h2kf
	7gZ1yWw6+aNJLp1XL8Caw==
X-ME-Sender: <xms:60FkZwNThmevIWwPPyKhCWiYlyvKNTcZ25ScXQ353h9XgCBy3i-Q5Q>
    <xme:60FkZ28mgCt-APYJ3prqnnw6DV9zVm1ug8THwaAjh0ix2Aj7IwkT41cEovOm44kl-
    GussINuLLWkr4zUgA>
X-ME-Received: <xmr:60FkZ3RvzE91MgAqxk1dL_5VHxrISJfJecLCLJIWcQGIRvP4xIGRboWXmWSvEj8ORdDxQ0DI_B9lwEvTnhoeStdUXWbf5XFGDTKSy9eQyt1Ldcc>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddruddttddgkedtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpefhfffugg
    gtgffkfhgjvfevofesthejredtredtjeenucfhrhhomheprfgrthhrihgtkhcuufhtvghi
    nhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnhepffeuieduje
    dvkeehuedvkeefffeivdeuleetkeduheejteekgedvudfgtdfgieelnecuvehluhhsthgv
    rhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnh
    gspghrtghpthhtohepgedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithes
    vhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehgihhtshhtvghrsehpohgsoh
    igrdgtohhmpdhrtghpthhtohepshhpvggtthhrrghlsehgohhoghhlvgdrtghomhdprhgt
    phhtthhopehpvghffhesphgvfhhfrdhnvght
X-ME-Proxy: <xmx:60FkZ4sYAUJTi-yMyyGO3sr8gQj5Xy8GKYwTaUTajaVFFOWXWtjrTA>
    <xmx:60FkZ4cZ7HxT4udXHkgjw3QnueaKn5Kr3bt7lvn3HbV-ICKK1WMdjQ>
    <xmx:60FkZ83E0GpWC_JNPO8UhuEv2jsm5uZ2W2YtQZCvnoqE74cBsaULcA>
    <xmx:60FkZ8-KTbFhlyVO4j-Gy9mKjtDmvIlemlRqjHgq1l1TwcQxEg5h-g>
    <xmx:60FkZ34EEvpnNoFt5S5mHKDvD_YMaWip_TI5mYHtAIGOnDZhY-7X3f5A>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 19 Dec 2024 10:55:22 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 7cb7b100 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 19 Dec 2024 15:53:30 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Thu, 19 Dec 2024 16:53:37 +0100
Subject: [PATCH 2/2] GIT-VERSION-GEN: fix overriding GIT_BUILT_FROM_COMMIT
 and GIT_DATE
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241219-b4-pks-git-version-via-environment-v1-2-9393af058240@pks.im>
References: <20241219-b4-pks-git-version-via-environment-v1-0-9393af058240@pks.im>
In-Reply-To: <20241219-b4-pks-git-version-via-environment-v1-0-9393af058240@pks.im>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, 
 Kyle Lippincott <spectral@google.com>, Jeff King <peff@peff.net>
X-Mailer: b4 0.14.2

Same as with the preceding commit, neither GIT_BUILT_FROM_COMMIT nor
GIT_DATE can be overridden via the environment. Especially the latter is
of importance given that we set it in our own "Documentation/doc-diff"
script.

Make the values of both variables overridable.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 GIT-VERSION-GEN | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/GIT-VERSION-GEN b/GIT-VERSION-GEN
index 787c6cfd04f0a43d0c1c8a6690185d26ccf2fc2f..f8367f6d09ff2ada8868e575d6ec8f1f9b27534d 100755
--- a/GIT-VERSION-GEN
+++ b/GIT-VERSION-GEN
@@ -53,10 +53,18 @@ then
 else
 	VN="$DEF_VER"
 fi
-
 GIT_VERSION=$(expr "$VN" : v*'\(.*\)')
-GIT_BUILT_FROM_COMMIT=$(git -C "$SOURCE_DIR" rev-parse -q --verify HEAD 2>/dev/null)
-GIT_DATE=$(git -C "$SOURCE_DIR" show --quiet --format='%as' 2>/dev/null)
+
+if test -z "$GIT_BUILT_FROM_COMMIT"
+then
+    GIT_BUILT_FROM_COMMIT=$(git -C "$SOURCE_DIR" rev-parse -q --verify HEAD 2>/dev/null)
+fi
+
+if test -z "$GIT_DATE"
+then
+    GIT_DATE=$(git -C "$SOURCE_DIR" show --quiet --format='%as' 2>/dev/null)
+fi
+
 if test -z "$GIT_USER_AGENT"
 then
 	GIT_USER_AGENT="git/$GIT_VERSION"

-- 
2.47.0

