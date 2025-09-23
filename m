Received: from fhigh-b2-smtp.messagingengine.com (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61630320CA4
	for <git@vger.kernel.org>; Tue, 23 Sep 2025 09:45:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758620745; cv=none; b=fKVh2yuHwj2/Ug9koN7ZFjm4Ox9QK8T5CP4pV1POQEDTHpekB4gi0Kzjdk9vKJLgGK8F7CVoNBD8iU51a83JUeF3pQg0ijOfrvMsl7QELzCtu0YhTo55zoS47DUeTb9xUxRb09Ac124YdJeiA9ojl0XY/Kv9pzy1DPlqlSo3PoQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758620745; c=relaxed/simple;
	bh=W84kpKIHU6yT4Fi4gqBAppok4eC8HlooCzEopi/iZg4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=A3hXbz6rFVsrF8TzMCg56M/j+kz8zhTyclDLHWj10m8B44TP6hoEdnZR7uAJuS+qRLS1OL8IwqBFpybUW8MQOcAXcv7VIVRSgEOaBD6NBNGzapAXDZmRzFVlLHRT1IZFDqaVuom0dRSWsk8ifitGj6rhNosCiIhN7iSoojG9T0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=gkG4uvX5; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Xof9OcAc; arc=none smtp.client-ip=202.12.124.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="gkG4uvX5";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Xof9OcAc"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 2D5147A02C4;
	Tue, 23 Sep 2025 05:45:43 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Tue, 23 Sep 2025 05:45:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1758620743;
	 x=1758707143; bh=oxEMBOtQC5sRKtkorojDu0/Rcmu9NhLvkEvYPtmoKTA=; b=
	gkG4uvX5WhjxWZeKDEsE6dode+KoY6KXklZ6tJwJQ9U9irZycdOvVNWTgKWCbTkv
	zZEUeCHL4CudUZjzYXFb5K/qCji6DBAbDZ2igvWhcwrggM75rtIecmZNqeBIPHcz
	jS7qpPOTnpszyKXtp0UuKqxoGPU3G9gH1qERSI+gmrYXh9kTYFalXj1kUGzrN1v/
	O6CHbrsNgoo2XgFxVjVMhTX2aax1S5fE6ffnmeFH1RPv0qIv5hAWvzR+PIlSaAvy
	2VF90yIupfntUahtmrd3XGgk4NUw6Dco0XeH+3WIzjZujqfjjKG43o8nEyqM9pYJ
	NH/r2Sc876BGvwrykKkyKQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1758620743; x=
	1758707143; bh=oxEMBOtQC5sRKtkorojDu0/Rcmu9NhLvkEvYPtmoKTA=; b=X
	of9OcAcIkWuJl47B1X4IezmxW+SSIfp1tQ2P8IGIhJF3J02IW3uItg2NsO2ZW8yV
	+ghBVpxMdGmX24i9TRReWV5047oiQ5I2/8KA7iIVbU476FkiTqcxGXOgxf91JBky
	KoTjm1jIPWhd2emarmtXf9EmsC9klKG3DgInpVCbWto+Cd3TSbHG7WGlZtta/vbz
	fHYDsaWq0T2Mm9WVE3WIxDZrbvbzBxg1HCrY7Fw/Pd9Rd1eSEAvj6cLl377hajAu
	4u7/PutS0anEQXJtaxXyHwEkOYf8PxOcsIg0KHCZv/lOR/Sde++GRqEWRJnmhU2f
	e98i6zj5CnNbIC5R+H0bA==
X-ME-Sender: <xms:RmzSaGgzMyUeygO0khzU4hS9v9ZQIrUEUhI97lahCFqFfl4hT1q17A>
    <xme:RmzSaHfGhp4Ot6FzJRUlJyLqtf8y3GBijRpwswqG-cjD3f7_-hRMh2AyK1bAjFgnX
    WV4NPKIukdyle3xGGCWdaPGRgD0dk13i9RM9E5Z2xTfmE6p5ErR>
X-ME-Received: <xmr:RmzSaN3aSB4T-46y3SfcE2FAg6mYwld2ZcesEpwYvTQ6OoHgdB1dr6hRC1q_sPvtiMyd8CYzeRV2ksSlxJirdJwd7c_CCrnXj0pLVxAJlzTu>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdeitdegtdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhfffugggtgffkfhgjvfevofesthejredtredtjeenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epffeuiedujedvkeehuedvkeefffeivdeuleetkeduheejteekgedvudfgtdfgieelnecu
    vehluhhsthgvrhfuihiivgepudenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimhdpnhgspghrtghpthhtohepudeipdhmohguvgepshhmthhpohhuthdprhgtphht
    thhopegsvghnrdhknhhosghlvgesghhmrghilhdrtghomhdprhgtphhtthhopehpihgvrh
    hrvgdqvghmmhgrnhhuvghlrdhprghtrhihsegvmhgsvggtohhsmhdrtghomhdprhgtphht
    thhopehkrhhishhtohhffhgvrhhhrghughhssggrkhhksehfrghsthhmrghilhdrtghomh
    dprhgtphhtthhopehjohhhrghnnhgvshdrshgthhhinhguvghlihhnsehgmhigrdguvgdp
    rhgtphhtthhopehphhhilhhlihhprdifohhougduvdefsehgmhgrihhlrdgtohhmpdhrtg
    hpthhtoheptggssedvheeisghithdrohhrghdprhgtphhtthhopehgihhtsehvghgvrhdr
    khgvrhhnvghlrdhorhhgpdhrtghpthhtoheptghonhhtrggttheshhgrtghkthhivhhish
    drmhgvpdhrtghpthhtohepshgrnhgurghlshestghruhhsthihthhoohhthhhprghsthgv
    rdhnvght
X-ME-Proxy: <xmx:RmzSaLqN9Rkt_7v2XTNUUL35Q9R0Ijg-E2m3uKwKopq8UGoPsGxGtQ>
    <xmx:RmzSaNh-BbnkG13DfgqfX2ZtBa_Aslm5-P_bx1S5ZgXbN-5ncGdy6w>
    <xmx:RmzSaHlxIKo-MRdojpcEU1bvOC9OnjldInx_IIlOr4ydXNouPN3HQQ>
    <xmx:RmzSaGqOoDO0JvZkFiP_Xw6SlydgBBebsK4xQyXdNwEmqd39vxJiYw>
    <xmx:R2zSaKOoMb792Ufg2SkfaIrQMpyPJf-vTJfciS8awooKrWnLXdYyBnV8>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 23 Sep 2025 05:45:40 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id b2158359 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Tue, 23 Sep 2025 09:45:38 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Tue, 23 Sep 2025 11:45:23 +0200
Subject: [PATCH v6 4/9] help: report on whether or not Rust is enabled
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250923-b4-pks-rust-breaking-change-v6-4-59076fee486a@pks.im>
References: <20250923-b4-pks-rust-breaking-change-v6-0-59076fee486a@pks.im>
In-Reply-To: <20250923-b4-pks-rust-breaking-change-v6-0-59076fee486a@pks.im>
To: git@vger.kernel.org
Cc: "Haelwenn (lanodan) Monnier" <contact@hacktivis.me>, 
 "brian m. carlson" <sandals@crustytoothpaste.net>, 
 Ben Knoble <ben.knoble@gmail.com>, Christian Brabandt <cb@256bit.org>, 
 Collin Funk <collin.funk1@gmail.com>, Eli Schwartz <eschwartz@gentoo.org>, 
 Elijah Newren <newren@gmail.com>, Ezekiel Newren <ezekielnewren@gmail.com>, 
 Johannes Schindelin <Johannes.Schindelin@gmx.de>, 
 Junio C Hamano <gitster@pobox.com>, 
 Phillip Wood <phillip.wood123@gmail.com>, 
 Pierre-Emmanuel Patry <pierre-emmanuel.patry@embecosm.com>, 
 Sam James <sam@gentoo.org>, Taylor Blau <me@ttaylorr.com>, 
 Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>
X-Mailer: b4 0.14.2

We're about to introduce support for Rust into the core of Git, where
some (trivial) subsystems are converted to Rust. These subsystems will
also retain a C implementation though as Rust is not yet mandatory.
Consequently, it now becomes possible for a Git version to have bugs
that are specific to whether or not it is built with Rust support
overall.

Expose information about whether or not Git was built with Rust via our
build info. This means that both `git version --build-options`, but also
`git bugreport` will now expose that bit of information. Hopefully, this
should make it easier for us to discover any Rust-specific issues.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 help.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/help.c b/help.c
index bb20498cfd..5854dd4a7e 100644
--- a/help.c
+++ b/help.c
@@ -791,6 +791,12 @@ void get_version_info(struct strbuf *buf, int show_build_options)
 		strbuf_addf(buf, "shell-path: %s\n", SHELL_PATH);
 		/* NEEDSWORK: also save and output GIT-BUILD_OPTIONS? */
 
+#if defined WITH_RUST
+		strbuf_addstr(buf, "rust: enabled\n");
+#else
+		strbuf_addstr(buf, "rust: disabled\n");
+#endif
+
 		if (fsmonitor_ipc__is_supported())
 			strbuf_addstr(buf, "feature: fsmonitor--daemon\n");
 #if defined LIBCURL_VERSION

-- 
2.51.0.536.g15c5d4f767.dirty

