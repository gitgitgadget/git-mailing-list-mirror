Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07BED1EBFE6
	for <git@vger.kernel.org>; Thu, 30 Jan 2025 14:44:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738248264; cv=none; b=meiXPtFO9GDsnLuOw+hl4bGBUyP9cKjtvx4YIJq6XDCMKv1RiOnJjvZSNV2sph9Dvu5jz4st3Bnfp1eYj6CG7uYFV65yTDh72KOR7qqBaX/9ymD36McYUjYDYfRNIfCKcay8c90y5yKqyQ+LaMiwQ5+9xHCoHABBLNb5hA8Jxbo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738248264; c=relaxed/simple;
	bh=2OwugQwWEOo0sABALL1aqT5jCo8XPdhzwmyVvP/XlNk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ZhMBzqhUBSZIn/dxRByiKn5MO+e5XqMlj8SDanOW8tve0ffizIdC+SZXA1HP2iLdo2r5jW2HOrnpAjX0HxFxDjuf8Q1JqaM4lQzOKmoC4I6NgWiMkUbwubHhCfojyaDzt8acvHBMJXMXca/khJ5LtrzdjHkPF8Q/pHZJ8oX586A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=erxHGN97; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=lXRFWwbY; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="erxHGN97";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="lXRFWwbY"
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 1934311400E1;
	Thu, 30 Jan 2025 09:44:22 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Thu, 30 Jan 2025 09:44:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1738248262;
	 x=1738334662; bh=XdM7u/BgsxMzFUb72ZQhr4zRNztnViQv6tuZvmDM6D4=; b=
	erxHGN973YMCb7YNvUMBnKb+Ipn7RgG3w5P7PzJPq6fJ5mOO0mxtO/s16ZWkbnMB
	YsFMdxjPkNCStO20goRjJyVeC3CNimi5tq6sDG3uX3xTmS5OxEx5lf0xMqQOLAfv
	smeqSPhOriw2AR9CGiaIEIznC1kYoHSP0MgwYXHUmz5HgTlSk0dMY5KiIoDp+3ar
	aqmG/Oi9McOe3rkQF4pl3/EtkP2RiyI9L44cTrWmztgE09w5pCr6i12Qf7/UBDIT
	Rt6Wnrh/c4VOrr8ETXOIHPXol5m1Or2xfnrj2rV3rwxHV7T9k/Bbqi/zuv3OROtg
	ZepydabkXqe6kyG2HuEOLA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1738248262; x=
	1738334662; bh=XdM7u/BgsxMzFUb72ZQhr4zRNztnViQv6tuZvmDM6D4=; b=l
	XRFWwbYcaXYxEOhkDd/nDVnZPOEEmjE1cX9vIdsRqOa6EHrCNeLiCrBjuvDWbzNP
	nZjpZYr/iPMTGRq//b2hFzthwxWyQNB7dHJ0tvUeEs57M7jElYv2FFc+Q+68IxD6
	uqs2hw7+X9zHmOqUdpmIYH4D504nfC9VUieMaveCZZLtqdYwJMkIpgNelEpt5m4D
	5De7NF4IHbazbYazldZr+KY5lU65W6wjTVJrKXiXsJPXa0ung5zkdLQOoZ8VOHZ0
	3Vki4Sm6VPJu4W5YAvWs4ivkvz6Ydh6Lf4GYEHHpV8czcyMz3bl1FBefsfy/VDtE
	govWxLOzLTRsK3Ne02lLg==
X-ME-Sender: <xms:RZCbZyN_SVNGnMflQ3Q_1V5QvvdiyVczkxFhXfRY2EsAKWaEs2-BZQ>
    <xme:RZCbZw-wvlRMvvkcGvWtN2dvfPLSw160kGcvtzr-X9tfrccxTVPWz36iFLDlrT2pT
    ayMso-9UBFdgLpUjA>
X-ME-Received: <xmr:RZCbZ5TIkq5S37BPTvyhGd-S-zsVi7LaY6qsE92cPQzghIiaBsEwliwKRut_OQfs59h47YddjYCnbqVXE68k_rYO5URq1146uvinQgBzZ6Kf>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdeitdelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdej
    necuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrih
    hmqeenucggtffrrghtthgvrhhnpeffueeiudejvdekheeuvdekfeffiedvueelteekudeh
    jeetkeegvddugfdtgfeileenucevlhhushhtvghrufhiiigvpedunecurfgrrhgrmhepmh
    grihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopedvpdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpd
    hrtghpthhtohepjhhlthhosghlvghrsehgmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:RZCbZyvLB7pjKprIRcooanYtZGM0Hkvu3jNcHrgNAikEiOI_TtMZrQ>
    <xmx:RpCbZ6fnwQclrM7zi23xz56HA_jHOQ5FDRGZCpZVaEhKbmsmIg97Fw>
    <xmx:RpCbZ21IimR3uf9FWQKQ8Mk5pOHISb_hXMgQtqVEE0fz8TdgxoToNg>
    <xmx:RpCbZ-9VDMmgPCMz0O-jY6QHVGbDz31yzVOhbB-SnGSfJrTcyBNPEA>
    <xmx:RpCbZ7qizV8g9M7HB2FSEisaWMdtKb-fsP1P01LZL3OVnGtpnNv895Eo>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 30 Jan 2025 09:44:21 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 6c34759b (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 30 Jan 2025 14:44:20 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Thu, 30 Jan 2025 15:44:05 +0100
Subject: [PATCH v2 13/13] gitlab-ci: restrict maximum number of link jobs
 on Windows
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250130-b4-pks-meson-improvements-v2-13-2f05581ffb44@pks.im>
References: <20250130-b4-pks-meson-improvements-v2-0-2f05581ffb44@pks.im>
In-Reply-To: <20250130-b4-pks-meson-improvements-v2-0-2f05581ffb44@pks.im>
To: git@vger.kernel.org
Cc: Justin Tobler <jltobler@gmail.com>
X-Mailer: b4 0.14.2

The hosted Windows runners on GitLab.com only have 7.5GB of RAM. Given
that "link.exe" provided by Microsoft Visual Studio is multi-threaded by
itself already and thus quite memory hungry this can quickly lead to
memory starvation, out-of-memory situations and thus failed CI jobs.

Fix the issue by limiting the number of concurrent linker jobs. The same
issue hasn't been observed on GitHub Actions yet, probably because it
got more than twice the amount of RAM with 16GB.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 .gitlab-ci.yml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
index 4976e18a05..7e1cecc6a7 100644
--- a/.gitlab-ci.yml
+++ b/.gitlab-ci.yml
@@ -169,7 +169,7 @@ build:msvc-meson:
   extends: .msvc-meson
   stage: build
   script:
-    - meson setup build -Dperl=disabled
+    - meson setup build -Dperl=disabled -Dbackend_max_links=1
     - meson compile -C build
   artifacts:
     paths:

-- 
2.48.1.468.gbf5f394be8.dirty

