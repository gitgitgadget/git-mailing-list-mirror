Received: from fhigh-b7-smtp.messagingengine.com (fhigh-b7-smtp.messagingengine.com [202.12.124.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4CA4233D69
	for <git@vger.kernel.org>; Mon, 13 Jan 2025 08:34:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736757246; cv=none; b=tUctrYzwlLASloUo8Vbx8UPks9t+6rF+/TZu0YQxPplVeXdRvCv0RKexRCT+bJrD2LoxQwVKPDudiXAiBeKc+795pszrHVUZE2rQzgj5oPTSkcCBpqWelbNJes+zdbt6RTaHWeBPBdKbHWUic7GHIDkUo0oMNMXNJM2FxPdiGAY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736757246; c=relaxed/simple;
	bh=W+VFHoOUO+RRe7F8s14UIdnp/zEkTVdHI8vOShzRrSA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=mL8FXm23kCWFJHKYd9MGIgm30f7Uh9UXH0fp5FX9a5DCyc1MVVGtEFUDGXve/OL7tyNcsUDKLXJKEviAcS2tmihR6Qusq6EyW4XhQQF/StUIe4iYBawDcwJH7AgE1nVng2K5gwYTr9bq8iDfDH35MTr6Q8rc5gsktpyla6vzR9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=MnK65Ipi; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=iXOZm/N2; arc=none smtp.client-ip=202.12.124.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="MnK65Ipi";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="iXOZm/N2"
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfhigh.stl.internal (Postfix) with ESMTP id BD48C2540191;
	Mon, 13 Jan 2025 03:34:02 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Mon, 13 Jan 2025 03:34:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1736757242;
	 x=1736843642; bh=DEApv3Aa6ippS6UuHrYggXWOuZURAB4yzCQZcLDomeA=; b=
	MnK65IpiEWeaoR9l/tOmEo+D3jF0sa6cYifrjky5RS+23vieOu8JHlRfV8Cb/ogd
	x/4NZatmhvHOqKcSpReWcRx4SAj5z4y9Gj09r5vUzcOtBTl1HDTZEZZ5VfiKBkg/
	R5mBj9p0zLqptj+xpCtT+MTTHuL6TviJnjAaAjE7MU4F+KAAhGWIDzad8ellIG9r
	tmUAZXiGoVdwTQYQNi67X1ksETFjh83xL3h2t+kLPP4FzgdI4mTYLw2lQwOx9vcX
	mI+my4+2rJjnlxfUA2SlyGUeWE9nYkxo1tZNQoMwdpMs/DkwZdIakRnssQnzft9j
	AKg/kqXo+HvqR1Bl3umjPQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1736757242; x=
	1736843642; bh=DEApv3Aa6ippS6UuHrYggXWOuZURAB4yzCQZcLDomeA=; b=i
	XOZm/N2iYHmQchF+khabTL3P+gyIH4354ms1MfemJMsODL7PDzJCwdAlyXaixSwq
	ntXllFFReWetIvlKGHXb7YX65nI0soPjnFwQk4m05SvWtlszCX8Pr1Qt0JZx6A8W
	fMZMPjLdDr5KGJ611xdqPdAWsOTp2m2MKeYOKSprmWgKFShZwSCShbpNWZBwHwp6
	pgUIfxPglXpwsvkgoxhqYAdKdTlwvvh88qVbnM04sgtrMuw6fQ2YkCOPzfQSOwCh
	yVgrHAp2bVkeK/rmB2C5uF09XgDEg5Rp9wbamqJI03i7HpiMCIkLc5sOCPDOPTCa
	cEp+ncBaGabp8QR8bNWDQ==
X-ME-Sender: <xms:-s-EZ79uw3AD3acwpVwFKio4Opur3DNcMqLFJahTaTxuloa7jkDh4Q>
    <xme:-s-EZ3vdv5p8meEjyLf7ByMOJc7jolPvfAC8_8ggrTvLKerzXve3qF_veEFSAQ_af
    bhiImcjE70hYTJDvQ>
X-ME-Received: <xmr:-s-EZ5AnchMgOWndfut8VybR5TXfRIkfMPJE16AKTLky2aHtHmzNp8GmwTiUmP0mkEqACpOkjjg1pjwSvNdd00tyiDw9dlCJiMGwjPYDUMqN2COx>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudehfedguddulecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhfffugggtgffkfhgjvfevofesthejredtredt
    jeenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrd
    himheqnecuggftrfgrthhtvghrnhepffeuiedujedvkeehuedvkeefffeivdeuleetkedu
    heejteekgedvudfgtdfgieelnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpe
    hmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepfedpmhhouggv
    pehsmhhtphhouhhtpdhrtghpthhtohepvghvrghnrdhmrghrthhinhesghhmrghilhdrtg
    homhdprhgtphhtthhopegvshgthhifrghrthiisehgvghnthhoohdrohhrghdprhgtphht
    thhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:-s-EZ3ekyXR5wSJ6_0gpyrRYQ2kBBhaFhMtFhFq4BTfnLRXSXujr_w>
    <xmx:-s-EZwO1le9yUBHOZ0TqJ6Mfu8GzJFszW7r2kaq5iBJWB-j3CQtugw>
    <xmx:-s-EZ5lgCX1bL2kBsuUuU3h4xa09RU1rBjBPSJNajztZ-eQX4xeAdw>
    <xmx:-s-EZ6socdewa2HruaNJcdNwQeMoshePl9jsd0rZWVQXuABc96RwHQ>
    <xmx:-s-EZ1rg-dPixVlWG0K8uaXo5dSnjKfw3Cse7ePa_gMvw8MOnpnx85rX>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 13 Jan 2025 03:34:01 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id c8fde734 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 13 Jan 2025 08:34:00 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Mon, 13 Jan 2025 09:33:37 +0100
Subject: [PATCH 4/9] meson: wire up development environments
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250113-b4-pks-meson-additions-v1-4-97f6a93f691d@pks.im>
References: <20250113-b4-pks-meson-additions-v1-0-97f6a93f691d@pks.im>
In-Reply-To: <20250113-b4-pks-meson-additions-v1-0-97f6a93f691d@pks.im>
To: git@vger.kernel.org
Cc: Evan Martin <evan.martin@gmail.com>, 
 Eli Schwartz <eschwartz@gentoo.org>
X-Mailer: b4 0.14.2

The Meson build system is able to wire up development environments. The
intent is to make build artifacts of the project available. This is
typically used to export e.g. paths to linkable libraries, which isn't
all that interesting in our context given that we don't have an official
library interface.

But what we can use this mechanism for is to expose the built Git
executables as well as the build directory. This allows users to play
around with the built Git version in the devenv, and allows them to
execute our test scripts directly with the built distribution.

Wire up this feature, which can then be used via `meson devenv` in the
build directory.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 meson.build | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/meson.build b/meson.build
index e278ff207a7714fbb6b6cf8e1ec1fcca37360bd0..0b559215e4f105ac87bd580d755f88c32b7b36ca 100644
--- a/meson.build
+++ b/meson.build
@@ -1932,6 +1932,14 @@ configure_file(
   configuration: build_options_config,
 )
 
+# Development environments can be used via `meson devenv -C <builddir>`. This
+# allows you to execute test scripts directly with the built Git version and
+# puts the built version of Git in your PATH.
+devenv = environment()
+devenv.set('GIT_BUILD_DIR', meson.current_build_dir())
+devenv.prepend('PATH', meson.current_build_dir() / 'bin-wrappers')
+meson.add_devenv(devenv)
+
 summary({
   'curl': curl.found(),
   'expat': expat.found(),

-- 
2.48.0.257.gd3603152ad.dirty

