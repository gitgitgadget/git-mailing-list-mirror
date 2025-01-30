Received: from fout-a3-smtp.messagingengine.com (fout-a3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A08B1E9916
	for <git@vger.kernel.org>; Thu, 30 Jan 2025 14:44:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738248258; cv=none; b=FdSEVkaWSKhsIijtttWSiDpbBoOSw4LC2MLsnTVVqJry/+65IquB9UzKRF5C5QPxvP+Df/oR+clf1RJBOw69DHFnUFoRDotTG72tyTguDlPUiiZNWdTJGyYdmAdmCPjW8zQeieMshnDwkBFHs0Z+4kIae9E74AoPfgRcLwX6EUw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738248258; c=relaxed/simple;
	bh=TXVQR4vsZsUM+AJq0Vx2V9OIVqUHX/vuH4qy/Hom3lQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=t/MLk+EgIxS8sKt3f89WPNwATJ0ttDM55U6Dvv5hrxS0Fwm5PWczxESjtQvqNlG2lzQTCJPGRy1GBjDryJxYnYXjqnNTxO1Hd9s4md85fwMZkYT8JfuFFIev5m7fzagh7NkTws2MCCoD2LjH6ewwVi64cLn1C+EvrYnGQFVx96A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=p4GHtj3d; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=mbiZ0gTw; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="p4GHtj3d";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="mbiZ0gTw"
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfout.phl.internal (Postfix) with ESMTP id 5BD3B1380137;
	Thu, 30 Jan 2025 09:44:15 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Thu, 30 Jan 2025 09:44:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1738248255;
	 x=1738334655; bh=du+zEON5gfjLLSEgtgqIngK+Zfp1drXV81j/cMGPTZU=; b=
	p4GHtj3dAki/4Gd64trzuwr485jmxIUnb3uytFXtZJ4VZ0pWA7cVnQdJGn82mV4o
	WKjV451/bLeJb/Es0v9VF5bquJ8LBNSspvc+xcnJ5Mf/+S8UcVyhB7odDzt/gMC7
	YZhha+ZZgsNKJPhfPV2xc9gDEMK0lH3BmksjpWtWBW/kr2BUeB522d+ldnHmosOZ
	uQP2Dom8Lg1g5+sk7+8RWaeJdtGnA4fykJZvVxzMlBhelTknq8OhFXfpX68U6WIb
	520RVQaJFQH6ao+OYZM8iBRsON0S/GJqNoTvUsypicLvZ5NUTa5By7jiFE/dzWch
	fiYdj/743z9z/tbvc9Rvsw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1738248255; x=
	1738334655; bh=du+zEON5gfjLLSEgtgqIngK+Zfp1drXV81j/cMGPTZU=; b=m
	biZ0gTwcoos+L35oyH9qGMJ31pFFhvI9XLtKQvjmhAypIS8w08slvpE8s/XSHmxk
	eDZyWrKe4Q7VaTKPwBY6+E/ojNreHudOsBl9l1f2rkkwp6rMcCRc4J/cPzi9Y0Ye
	LK+zvX2D0zb8DyuQ4Wc6D0h+zDJo7FyCqUdHCKXLRdECH7dPWPlkgy62aKKZ5ZH/
	5s0gpWDY1Pj8PT+rrHWrRFPZDM+fn9hK2CL+0UGxMq/Dd0gXsdjZJ7ZMHa9q+oWz
	iB6ZxTsnS4PZW42cy2rdeOKeo387qk4ygdCpEaP1kmT3QxUdm+IY/iZWssZmX2/4
	ibtENq2kri5A0LCMQPmFw==
X-ME-Sender: <xms:P5CbZx2pZfGFXuZc4TU9Yhi2n6mfzVvIMg8iyeB5oPW641P08Scx7w>
    <xme:P5CbZ4Er63I2ZwDvZ42b58OyXUPxkxeBMBpFPDwWUarUcA41CUSPWJod-axPrBjn0
    uTfh4p5dLlYIQN7jQ>
X-ME-Received: <xmr:P5CbZx7Egydlk_3bBahmUxTV86BPgIwckJtI8ysV1tBGFcarN0xVWc7et7STyUZ2ElDgRPwYgVCQmtX1-QPPcSjnzy768M0Q7GwmxBohksWf>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdeitdekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdej
    necuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrih
    hmqeenucggtffrrghtthgvrhhnpeffueeiudejvdekheeuvdekfeffiedvueelteekudeh
    jeetkeegvddugfdtgfeileenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmh
    grihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopedvpdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpd
    hrtghpthhtohepjhhlthhosghlvghrsehgmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:P5CbZ-3g2EneSIvRheoj8CF2BXgiW6abCuMKJ-3FPHAaF1hMGaUz-w>
    <xmx:P5CbZ0F3LGgnTHe11ZUb_nP0tTiwoGgwGZZSikj6w-CENnjRWD9luQ>
    <xmx:P5CbZ__I5RxZHAgZ3vRNum4kN4so2bcfC5pvHK1yNeu2HJ7jl6QtfA>
    <xmx:P5CbZxlAHaD7HiZYQ3FNforH9vshNmMITqkkqX6kmG3MgHRK3kBcow>
    <xmx:P5CbZ5TL_GNVav8LMMBcn91w2-iniE3WcIfPfDFFxiEQNf9MqaLK6Wq1>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 30 Jan 2025 09:44:14 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 6ce02770 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 30 Jan 2025 14:44:13 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Thu, 30 Jan 2025 15:43:58 +0100
Subject: [PATCH v2 06/13] meson: stop linking libcurl into all executables
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250130-b4-pks-meson-improvements-v2-6-2f05581ffb44@pks.im>
References: <20250130-b4-pks-meson-improvements-v2-0-2f05581ffb44@pks.im>
In-Reply-To: <20250130-b4-pks-meson-improvements-v2-0-2f05581ffb44@pks.im>
To: git@vger.kernel.org
Cc: Justin Tobler <jltobler@gmail.com>
X-Mailer: b4 0.14.2

We set up libcurl via the `libgit_dependencies` variable, which gets
propagated into every user of the `libgit` dependency. This is not
necessary though, as most of our executables aren't even supposed to
link against libcurl.

Fix this by only propagating include directories as a libgit dependency
and propagating the full curl dependency via `libgit_curl`.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 meson.build | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/meson.build b/meson.build
index 820008f6de..4b641095a1 100644
--- a/meson.build
+++ b/meson.build
@@ -927,7 +927,9 @@ if curl.found()
     use_curl_for_imap_send = true
   endif
 
-  libgit_dependencies += curl
+  # Most executables don't have to link against libcurl, but we still need its
+  # include directories so that we can resolve LIBCURL_VERSION in "help.c".
+  libgit_dependencies += curl.partial_dependency(includes: true)
   libgit_c_args += '-DCURL_DISABLE_TYPECHECK'
   build_options_config.set('NO_CURL', '')
 else
@@ -1663,7 +1665,7 @@ if get_option('curl').enabled()
       'http.c',
       'http-walker.c',
     ],
-    dependencies: [libgit_commonmain],
+    dependencies: [libgit_commonmain, curl],
   )
 
   test_dependencies += executable('git-remote-http',

-- 
2.48.1.468.gbf5f394be8.dirty

