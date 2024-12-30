Received: from fout-b4-smtp.messagingengine.com (fout-b4-smtp.messagingengine.com [202.12.124.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E45E225948F
	for <git@vger.kernel.org>; Mon, 30 Dec 2024 14:24:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735568653; cv=none; b=Y2kkAWrX2/uZsxIXG/k+iCTvvTiovd8jJUywmJCHJZn3Zl2lXPgI6FtxY4iyjt8wpRSGJzEdrEES9lzHEy8orJWUmlqvforAyFSXkYZNfP8847Ys04dE2Q+Qcc5+8pfZbUC8PeITzmduHUSdgbklztwbXCCcDPJejE90rCIcGvE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735568653; c=relaxed/simple;
	bh=TfYT2ab9VW9uOISfzxty3nES834hz9TUes6Pp8aYaIg=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=Ct1yCqAv8DR9zq6THjj6Fg2yD9Tyd3tigyEP6+qvbzlAWbLI1sN38jBrXcMqLfWRwZoxuVtFaNdab5lGPrNfYD25+RVccJ0uEeEsXMq/Q1G3HJ0Vm4r+8kIyg9axenTCcrgN7M2fboTmCCBTzsjo7eXte2cLHn6NOdoKIq8Vzis=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=CHEIzlsi; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=QLo4ovIH; arc=none smtp.client-ip=202.12.124.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="CHEIzlsi";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="QLo4ovIH"
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfout.stl.internal (Postfix) with ESMTP id 00D271140100;
	Mon, 30 Dec 2024 09:24:09 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Mon, 30 Dec 2024 09:24:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to; s=fm2; t=1735568649; x=1735655049; bh=AR5RiCIucn
	k/rHdm1b2Ed4sVRmie34t+wyniEEwQmmc=; b=CHEIzlsidpdj5CdGOCd7z70psj
	BiaZyUP2Eyeqgc2v6e4/NZY8Iec5eOjJ6rxZ9dTXBSun35psJXdvP9NicTJnF42c
	hK4+57qmgAFtUUFesZwt4pLdOuOsim0pviNURL8DfLgTq9YGKpgGsg0df+HFacWd
	d5hD8xEUpYSg7rIfqG9bvcda9D1s/vUhEKETF3vbLpLbHGq43bzl6yrqosSOM7U+
	lUzkCdDYy3iBgTZ7EdbQVb2R3OEBpw8UaAUqTef4fbYJi7Nb0nounoADhgaX9vTv
	xm0vlzg1V7xO7njnfvUZQygpRlq3FZNshTyLJHjUm+czJAX4JVtZ/7C8JP3g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1735568649; x=1735655049; bh=AR5RiCIucnk/rHdm1b2Ed4sVRmie
	34t+wyniEEwQmmc=; b=QLo4ovIHgN4/IVbldAX8zMBk+UcKmScbqjV5tU5T/Lub
	LPBoEMyk+151F00OdrF7dpTx+/0naDMgOD89dY1LidhLlSoXL3ZgLMp5nAAjT45a
	b/kDV7/r+IA0S0/CA370yeCjOdkJi3h7VtH2Xdi3V3sFmQxPaDE4bvAKrQ9mdGdH
	S7WTuqvtJDWobOQy49JMQ/1ktfcMCoaunfiCaYguEdnmQ9bPskzNDycC5d7Ut8ES
	dut3xiRUtBYCL4Etq+rLr0L77fAAhF7Iw6LgLQp0jWGD+oRVSX+EvYJUavJoxBOH
	p9wFSuJKfapdo+rLOWe0TlbH9X64l2n45YSOUgbbCg==
X-ME-Sender: <xms:Ca1yZxGbWyrzzPvMRYQp6i9zTI8LTF1vRLqLUVrGyGYkpQTUz19-gg>
    <xme:Ca1yZ2Vo9E-RpwcgMCLRBLdMNaxjdZpl2g2PijcCPfaxRUUrKFq8fXaO-JFAFWtzm
    MeY77eXx9qkVvjx6A>
X-ME-Received: <xmr:Ca1yZzKJV2tdnDuUD_io0WSz1ui41lDl1c5nZCpLoXm49zEUEPlGezsbFd8aRkA8nTB-Gd4Xn-ZUnlg7UH8NT8YBjhcTZqxG3QV0FyUnRI_3r9me>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddruddviedgieegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpefhufffkf
    ggtgfgvfevofesthejredtredtjeenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhh
    rghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnhepveeugeektdetie
    egjeeuheeuudfgveelfeevheeuhefgteffffevhfeuhfeukeevnecuvehluhhsthgvrhfu
    ihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspg
    hrtghpthhtohepfedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithhsthgv
    rhesphhosghogidrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrd
    horhhgpdhrtghpthhtohepmhgvsehtthgrhihlohhrrhdrtghomh
X-ME-Proxy: <xmx:Ca1yZ3HCg3RFFdMcfO4UpP9VJlszX-zOnoG36_fPLCj_oD-4gh4d8g>
    <xmx:Ca1yZ3UUO3e_BUgBDxjokUqRJ9iJvrfFAucG44A1fmhD3FFJpph4oQ>
    <xmx:Ca1yZyNwS6vDaGAVGytmpd2VS0_PRY2zpIQgfrfeLom1MDPH5HrNIQ>
    <xmx:Ca1yZ23Cv-KCaSX8qYi-raWuJdL3pejsA83syF1eKF8vJLDp6WiYNA>
    <xmx:Ca1yZySXFscgt4zbWYoDMRA_iyjPtMpgLHQia6W-9RzzhxYN_PH9Z6eh>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 30 Dec 2024 09:24:08 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 765b57fc (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 30 Dec 2024 14:24:05 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Subject: [PATCH 00/10] Fix segfaults when using the unsafe SHA1 backend
Date: Mon, 30 Dec 2024 15:24:00 +0100
Message-Id: <20241230-pks-meson-sha1-unsafe-v1-0-efb276e171f5@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAACtcmcC/x3MwQpAQBRG4VfRXbs1M4i8iiwmftxkaG6k5N1Nl
 t/inIcUUaDUZg9FXKKyhwSbZzQsPsxgGZPJGVdaVxg+VuUNugfWxVs+g/oJbIqhbqrGlQAotUf
 EJPf/7fr3/QCpJZjYZwAAAA==
X-Change-ID: 20241230-pks-meson-sha1-unsafe-03c785824eee
To: git@vger.kernel.org
Cc: Taylor Blau <me@ttaylorr.com>, Junio C Hamano <gitster@pobox.com>
X-Mailer: b4 0.14.2

Hi,

this patch series fixes two segfaults when using the unsafe SHA1
backend. The segfaults are caused by us mixing safe and unsafe variants
of the API. As such, it only surfaces when actually building Git with an
unsafe backend that is different from the safe one.

I noticed those errors while wiring up the build option in the Meson
build system. As such, this patch series doesn't only fix the segfaults,
but also includes patches for the Meson infrastructure and is structured
as follows:

  - Patches 1 and 2 fix the segfaults.

  - Patch 3 makes the segfaults visible via our CI.

  - Patches 4 to 10 wire up the build infrastructure in Meson.

Given that we're close to the release of Git v2.48 I'd be fine with
merging just the first three patches. I can then re-send the Meson stuff
early in the next development cycle.

Thanks!

Patrick

---
Patrick Steinhardt (10):
      bulk-checkin: fix segfault with unsafe SHA1 backend
      builtin/fast-import: fix segfault with unsafe SHA1 backend
      ci: exercise unsafe OpenSSL backend
      meson: consistenlty spell 'CommonCrypto'
      meson: deduplicate access to SHA1/SHA256 backend options
      meson: require SecurityFramework when it's used as SHA1 backend
      meson: simplify conditions for HTTPS and SHA1 dependencies
      meson: add missing dots for build options
      meson: wire up unsafe SHA1 backend
      meson: provide a summary of configured backends

 builtin/fast-import.c     |  2 +-
 bulk-checkin.c            |  2 +-
 ci/run-build-and-tests.sh |  1 +
 meson.build               | 51 ++++++++++++++++++++++++++++++++++++-----------
 meson_options.txt         |  8 +++++---
 5 files changed, 47 insertions(+), 17 deletions(-)


---
base-commit: 306ab352f4e98f6809ce52fc4e5d63fb947d0635
change-id: 20241230-pks-meson-sha1-unsafe-03c785824eee

