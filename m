Received: from fhigh-b7-smtp.messagingengine.com (fhigh-b7-smtp.messagingengine.com [202.12.124.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41BCB25395A
	for <git@vger.kernel.org>; Fri, 25 Apr 2025 14:11:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745590299; cv=none; b=fMbz21kmAU7J2Z3j/CiuLo/6Zu5Y3I546xf8FDbJ75rBGzmpncKvsWLr+dkfdwdLJNGaDsDrgEghvkWb7xJy7oNHoHVMTce5uK/slvvf3ZpkhT8WCfYsm1W7o/HoRYi6krjDqeMLPWRy9UaVZ75YNMdvsMtH+zlioXwEatJUAHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745590299; c=relaxed/simple;
	bh=g9joRVD5XTGuETwyNLefIzd6wIt/N0u79CFq53M+SMo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=QFPC+asG+6DOEJl9pG7frocbsEOopePPaH6GknZkH0w5Pi1FxAAHVU7lgmH1jl/MZxzAI9nSej24jhuKanZX8aEnrPBwNp3A8OQv6FTxK/IrOyU9JY34yA/oFz6bcbGLSUfBCBO6z4LE/V7LNom4V+i5ZO305HJrMv4ALJzJ+rI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=eTc51stf; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=k2a9QzZ7; arc=none smtp.client-ip=202.12.124.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="eTc51stf";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="k2a9QzZ7"
Received: from phl-compute-08.internal (phl-compute-08.phl.internal [10.202.2.48])
	by mailfhigh.stl.internal (Postfix) with ESMTP id ABF1F254010C;
	Fri, 25 Apr 2025 10:11:35 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-08.internal (MEProxy); Fri, 25 Apr 2025 10:11:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1745590295;
	 x=1745676695; bh=Nj2ylXZ/MnYe9sD4FZGaD2wJtfUUJsqYhHu1/yMpsns=; b=
	eTc51stfD8le2nuH8OTJ/XFcOLZlvP8Eb0p5+flijVE+ZfBh75wD2XkM/XVhyrBB
	S1umm68DOKticB1s3a2IUFbWmqXAkUaq0W1bXdKuyF0RsaO6AcG6yLgnPWJpvufU
	LOFkCf4rpnLp8NnJpwazuFQRf/2/+2nFvvd8dsNMGZHDqAb2iuGn7KzSXd1acQPX
	W5vNNjUtlnVIwZDVKVTamzoVSWtRFXFOi3efGYb9rTprAhmvZDk/yMOrVeQ/ZWyg
	U49A2rxg/vH7s2nsaHy1vpjTsnJsGcrZ2AU9Nx0Gyi7CpC3K9Ct4tXnjUXKyEYlH
	/hsWcGqZ9rfGSX7EyNJTwQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1745590295; x=
	1745676695; bh=Nj2ylXZ/MnYe9sD4FZGaD2wJtfUUJsqYhHu1/yMpsns=; b=k
	2a9QzZ7SusDKud4wMMw+y9gy5LJpNX0LEsMIEfwuCkfaN3c1aeQVKw5ZXLjwBGFQ
	yXlMr0cvweKCDSFFMfcfBnrcQlDY7wRk+HicoelQZ8o4kfu6rLd3gSJ2pm0Wk8D/
	4cYUu284jis/di0xzBksKXAgH8uoRZKfNXywSioZZ2no384HPiofkW6rq/eX7fJW
	e8oXW7GHXw7nBRTG2O42MxPSua8B3rKKqx4dE3SLSP9ZTthjaZVVgvNZaF/fona0
	DupWrxDkHMk7oqthdXlMzBUfQ3qyhLE+JJ691ciQcOISmV3rnUKPMRo2jCTpNiyR
	eAq5wGc6YpPUKkkKbYXlg==
X-ME-Sender: <xms:F5gLaMOqFfMWs_PvUa_tznGhrCsFg7XyCjNRgQcOIxInG_3leXCY9g>
    <xme:F5gLaC8DX8Wl4kgwF7B_B59B6NFjp_sXSx6x9goxHHqs1xyfy6qKapwV2LK-MSjcA
    RGd0mr5dA1jtNhUIQ>
X-ME-Received: <xmr:F5gLaDTtBA_Ajlkf53nLSQ_cEtGX1Gvnxfi17jpm8Yj8hJq80sAKIP9ZcneQPn5By_2Bdj6TbOg4iLEQQx0FmWAtYagPLm2Dsx1cR1ye>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvhedvheegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertder
    tdejnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhksh
    drihhmqeenucggtffrrghtthgvrhhnpeffueeiudejvdekheeuvdekfeffiedvueelteek
    udehjeetkeegvddugfdtgfeileenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeehpdhmohgu
    vgepshhmthhpohhuthdprhgtphhtthhopegvshgthhifrghrthiisehgvghnthhoohdroh
    hrghdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhmpdhrtghpthhtohep
    ghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehjlhhtohgslhgvrh
    esghhmrghilhdrtghomhdprhgtphhtthhopehpshdrrhgvphhorhhtsehgmhigrdhnvght
X-ME-Proxy: <xmx:F5gLaEsjCdv81smnsdXuH-9mJcQSyHIeiPp3zi8xG7BptsuulP7Qcg>
    <xmx:F5gLaEctAUiy_pIwi7G_3dRcyz6sBLHclK4SR7VUA4mRlym5ZqTH0g>
    <xmx:F5gLaI2tiIcYbaK0BCUILHJ74Dkw-wfw2REnXy7e_B7yWNfjRd04Vg>
    <xmx:F5gLaI8kuDeSSuIiA4a-8v0Gu_BvMYz2ktkw-sZ9VtbqAJkwfe2GhQ>
    <xmx:F5gLaI-0Bm708F_eSCKu6-MBATC2NqpVCq_Y9APfYRKGw51GCRhaMnPL>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 25 Apr 2025 10:11:34 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 6118ce3e (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Fri, 25 Apr 2025 14:11:31 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Fri, 25 Apr 2025 16:11:29 +0200
Subject: [PATCH v3 2/2] meson: prefer shell at "/bin/sh"
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250425-pks-meson-posix-shell-v3-2-01607a2e9334@pks.im>
References: <20250425-pks-meson-posix-shell-v3-0-01607a2e9334@pks.im>
In-Reply-To: <20250425-pks-meson-posix-shell-v3-0-01607a2e9334@pks.im>
To: git@vger.kernel.org
Cc: Peter Seiderer <ps.report@gmx.net>, Junio C Hamano <gitster@pobox.com>, 
 Eli Schwartz <eschwartz@gentoo.org>, Justin Tobler <jltobler@gmail.com>
X-Mailer: b4 0.14.2

Meson detects the path of the target shell via `find_program("sh")`,
which essentially does a lookup via `PATH`. This may easily lead to a
subtly-broken Git distribution when the build host has its shell in a
location that the target host doesn't know about.

Fix the issue by appending "/bin" to the custom program path, which
causes us to prefer "/bin/sh" over a `PATH`-based lookup. While
"/bin/sh" isn't standardized, this path tends to work alright on Linux
and BSD distributions. Furthermore, "/bin/sh" is also the path we pick
in our Makefile by default, which further demonstrates that this shell
fulfills our needs.

Note that we intentionally append, not prepend, to the custom program
path. This is because the program path can be configured by the user via
the `-Dsane_tool_path=` build option, which should take precedence over
any defaults we pick for the user.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 meson.build | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/meson.build b/meson.build
index a180c66ee69..6a90310a2ca 100644
--- a/meson.build
+++ b/meson.build
@@ -236,7 +236,11 @@ sed = find_program('sed', dirs: program_path, native: true)
 shell = find_program('sh', dirs: program_path, native: true)
 tar = find_program('tar', dirs: program_path, native: true)
 
-target_shell = find_program('sh', dirs: program_path, native: false)
+# Detect the target shell that is used by Git at runtime. Note that we prefer
+# "/bin/sh" over a PATH-based lookup, which provides a working shell on most
+# supported systems. This path is also the default shell path used by our
+# Makefile. This lookup can be overridden via `program_path`.
+target_shell = find_program('sh', dirs: program_path + [ '/bin' ], native: false)
 
 # Sanity-check that programs required for the build exist.
 foreach tool : ['cat', 'cut', 'grep', 'sort', 'tr', 'uname']

-- 
2.49.0.901.g37484f566f.dirty

