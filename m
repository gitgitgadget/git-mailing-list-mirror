Received: from fhigh-a5-smtp.messagingengine.com (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3EF226C385
	for <git@vger.kernel.org>; Wed,  9 Jul 2025 06:23:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752042236; cv=none; b=KaXTbZ9SdfsMTKgT/2sJlOjEr3fImp+rZ3jNKiJ81IQDE90N83v5uhscvMxIITDsiWRBVRvaY4Z7eKnXGPm6G9nYANjyiiQgt31GKXN14D0uzkl93ESV9rJWri70Zs50yOova+KYIa0qCUv6YqPhIgPi/dFR1yqqrxgm1rMbq1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752042236; c=relaxed/simple;
	bh=IpDi8UPNDY+gYUZJDGDy/hJ//524fHpEsGioK39uQp8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=lEn6J+tyU0U1s4jobpLUHgAK3wFsBcwefxNmkbKPJFgC5TMfKxoB6uEkcMTNovh2X6BtAiGXABt0AoI0kAuxTcfUh+xoGoR2VO71CsdjALUBmPVcWO48St8MJLDu7LINALIlE81OvMnSDuwO5Ojhg2/6c5XGaAK759Yi1B7ytcI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=ru19Ew14; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=kIt+Hfee; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="ru19Ew14";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="kIt+Hfee"
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 2AF82140025B;
	Wed,  9 Jul 2025 02:23:54 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Wed, 09 Jul 2025 02:23:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1752042234;
	 x=1752128634; bh=6//5Rx9Ef7PzhiRhEQHDxW9lgRx92XAp7ldp1+v32ZI=; b=
	ru19Ew14IdLbk2Ln8UCJc69ZhxBK0trpiFZ+bo7767ORDKQiS5UPpeMnYGeeGu7e
	5MMTFAhxm1lQ503/wjv4R9/Qkyb6kavjBYZUK2gjFWWxdNX0Y+NcZaF0lvLviAht
	hvSVE4j+D8NF9ErH3myYyGhfaM1P85shHYVO/Rhb+koznzlsYjJDgRpqe8jVCSAC
	NoAfLcjETOZGUiv5W2tiNjWTyGiYgP5vscZsJJimMWKbwJ5KVMqlMkBalI6XAY9U
	BFvneDC1psmfklV1XQGHeOtBqi724yj/M/lPZyVxFwImx8SdcTKbXNFRbuYVFr2E
	zPkwJCYHe9rXXkT5jMJ3sQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1752042234; x=
	1752128634; bh=6//5Rx9Ef7PzhiRhEQHDxW9lgRx92XAp7ldp1+v32ZI=; b=k
	It+Hfeega+jmyzzRM+PhNWkCCwYSVvQs4PU0yO72Jdm92tFwOJFTF37STOSZS3Sm
	XL4uiAVJ7H2VZXtG1Lz0PAvGUlPq2p0WIz46pZN680CKEdyHJbnmuiTsXscrG5n/
	wcs4lkOdhzOjKMK45nprY40fOFCk34iEOVroy47SbspvTl0PWsbLjQeM/17r+d6T
	7PLyB3ArJWWQHASN693C44PrLLlm+071BSxUWWhNLPahQTHyQXxr4dk2MHB8e6cZ
	blH6tVZ5m75YXpFjWsDBauK3UEQOyXYu7m+8azZ0Bys/ZhC2gbudOBwD0VopZs9a
	VZ6+D1bEYFRltlgnFu7vw==
X-ME-Sender: <xms:-gpuaFNOLnj47SBrcDnryOO1vJdN_hf1hjllQx7qSlrbRxlTk0OtHA>
    <xme:-gpuaLy_Tjwhxgshl2-2AjRSxHcu5Or0nJdMfXthd3S-r3ZWIPIvuWwbD7ZIXCCvR
    73q6MneK-yO0Sw1Dw>
X-ME-Received: <xmr:-gpuaNXqZ4lYK0LO76rGLAS8ZemsypP4-6mNawwGFHzD822mrmbTC8ECktzOqHd_kNSQOKJFMJdsoIVJY4jGCmYWw5pmtT4PKPGe_739RnBqxg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdefieekfecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhfffugggtgffkfhgjvfevofesthejredtredtjeenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epffeuiedujedvkeehuedvkeefffeivdeuleetkeduheejteekgedvudfgtdfgieelnecu
    vehluhhsthgvrhfuihiivgepvdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimhdpnhgspghrtghpthhtohepjedpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepphgvfhhfsehpvghffhdrnhgvthdprhgtphhtthhopehgihhtshhtvghrsehpohgsoh
    igrdgtohhmpdhrtghpthhtohepihhrvggttggrrdhkuhhnsehgmhgrihhlrdgtohhmpdhr
    tghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehrrg
    hmshgrhiesrhgrmhhsrgihjhhonhgvshdrphhluhhsrdgtohhmpdhrtghpthhtohepvghs
    tghhfigrrhhtiiesghgvnhhtohhordhorhhgpdhrtghpthhtohepjhhlthhosghlvghrse
    hgmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:-gpuaFO2cIT36HIp8djMPRFq9nG0OhUGkD_wghxj3T09LAhm4uNrDA>
    <xmx:-gpuaHAuuUSTdkbsdDAqZ6tzcvRTEdG58JWXmUkABCPzjaeEmCjGKg>
    <xmx:-gpuaKcjXiWG1yWp5ViLUM3I6LJIVeaUvORHu5vdcK8LhFjnAmWAIg>
    <xmx:-gpuaONV-qGd1rdUZ_HOBhH2xLsOOk-MnuY4cN_SBqnVEMfBWpX8rA>
    <xmx:-gpuaMlsTlbBV3bw_LdkPyEDnNOoJSMO3flEcHbdZBPa9y6Boehv0sBa>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 9 Jul 2025 02:23:52 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 8d6837d5 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Wed, 9 Jul 2025 06:23:52 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Wed, 09 Jul 2025 08:23:38 +0200
Subject: [PATCH v3 4/8] meson: clean up unnecessary variables
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250709-b4-pks-meson-cleanups-v3-4-29ab15b9ab85@pks.im>
References: <20250709-b4-pks-meson-cleanups-v3-0-29ab15b9ab85@pks.im>
In-Reply-To: <20250709-b4-pks-meson-cleanups-v3-0-29ab15b9ab85@pks.im>
To: git@vger.kernel.org
Cc: Ramsay Jones <ramsay@ramsayjones.plus.com>, irecca.kun@gmail.com, 
 Eli Schwartz <eschwartz@gentoo.org>, Jeff King <peff@peff.net>, 
 Junio C Hamano <gitster@pobox.com>, Justin Tobler <jltobler@gmail.com>
X-Mailer: b4 0.14.2

The `manpage_target` variable isn't used at all, and the `manpage_path`
variable is only used in a single location. Remove the former variable
and inline the latter.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 Documentation/meson.build | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/Documentation/meson.build b/Documentation/meson.build
index 2fe1a1369d4..4404c623f00 100644
--- a/Documentation/meson.build
+++ b/Documentation/meson.build
@@ -375,8 +375,7 @@ foreach manpage, category : manpages
       output: fs.stem(manpage) + '.xml',
     )
 
-    manpage_path = fs.stem(manpage) + '.' + category.to_string()
-    manpage_target = custom_target(
+    custom_target(
       command: [
         xmlto,
         '-m', '@INPUT0@',
@@ -392,7 +391,7 @@ foreach manpage, category : manpages
         'manpage-normal.xsl',
         'manpage-bold-literal.xsl',
       ],
-      output: manpage_path,
+      output: fs.stem(manpage) + '.' + category.to_string(),
       install: true,
       install_dir: get_option('mandir') / 'man' + category.to_string(),
     )

-- 
2.50.1.327.g047016eb4a.dirty

