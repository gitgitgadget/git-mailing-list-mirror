Received: from fhigh-a5-smtp.messagingengine.com (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67CC426CE04
	for <git@vger.kernel.org>; Wed,  9 Jul 2025 06:24:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752042247; cv=none; b=JqTHdYu6SaW8NpBiu4VeehxkpmMlYqtsRNwLFM9Q1Fn2W+4aSv8eeRk+0kLBOsZ8FyJ0h03zfa4PI5tZGKi+R5NSLjqq2mX44zhbf+2uS+UzSc+Le+sjIJ/QJ2LzDUegypA/DYBuwq2rJtOvFg5tpWP4Vv4/VV5KXkECCUxqPwU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752042247; c=relaxed/simple;
	bh=+7yCAI9QEZs+vE0kJMmGCFnZz3IG06vk4ZX7gQNwfTc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=rd/M0UyBMKS1/zMHAhBazB5ilK7D9fWrBqwbdGqswVjxCWrBA5DsRN0OP3TVTT6kUBpqgtQ4e1Dr29oh8vl5eAJQyPteeOHyUWmzVImwGjfmzRyLUhBaOP8QJEY271f7GKD2yKZrTj4cxjsz44zm/blmrZItD+jwQfZ0BH8TSM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=y3bRwaLt; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=bTJsUB18; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="y3bRwaLt";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="bTJsUB18"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 997DF1400254;
	Wed,  9 Jul 2025 02:24:04 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Wed, 09 Jul 2025 02:24:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1752042244;
	 x=1752128644; bh=T0gnestzZ7d8+xUQeS7V1NIRxzGy1yVn+hWFPaBjfd4=; b=
	y3bRwaLtc+GdaZONEC+CPzMJNssaTrxr/O/Q8UIgZ6i7zKJnOjPsVl5UcyCydhDh
	kjd+nSVAkh7CoIIWvRuUKU1WdM11DW3JqKi2HnvzgYpoSF/rMwi0svGAB4nt/bc7
	CRfQJP3pSb3jXuASsG81DF9wZr1slaX7Pj7cbhROzosibBcoJiyMB+AnyXi5k9y4
	1iYOWGAxtxdqO/5cTSBbrq1b6z0q2UMPCu/ViQT1GUwh7lQIoLsusS495fTVXgk9
	cWSZUBa3MBgl6LIo52U4fJK89VURKQqRdWSpd/yh8nUnrtD/+9k3orxg8U2SirlK
	Ysaa7uFT7p/EN4zX9cDKVQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1752042244; x=
	1752128644; bh=T0gnestzZ7d8+xUQeS7V1NIRxzGy1yVn+hWFPaBjfd4=; b=b
	TJsUB18R5o5QgYtnOEdq1DPc9l6cVkZrotKPye13RewZ5E6S0vsSPIk/OdW5SaxR
	S7xD8NG9YU3PUKk4Miq5AGfYOUmksODXirp9k9MnYs5r/cANKk860uw4D6zt1YL8
	+5RoET/hEOyVkgK48XUUt5C0CfiiK0nEJWY+/T8mv7VqelAvJS0qwwFwnOkAoUvz
	/LDWIB1XTtxZ9hLvfsokpqdrfrPTHNZv9cy4lChBleK6zVO1fW/Tg3OxkHZLBWzZ
	gA8s30s8P7q8bJbmQmNlvLKMFp7DdYyDDMzWRIm5RQlzyB6fXjjpVO1y9/hhYsJY
	v84wDasFtz3z8g0icfjjQ==
X-ME-Sender: <xms:BAtuaB6JRIcCkgpA9TIGZsv1JmxnKKBZNZEfBmW5JMRJY010e_-R9w>
    <xme:BAtuaCsqvN5h0UvCGrg1UJjezostw9tDiaoNTKazIFfVSxoUkdoSzUnf9jfKYuCQj
    P4JPciJ8T-ipbLt7A>
X-ME-Received: <xmr:BAtuaBj28V_3y_gzPVsSa_nSzZAjTN_FbBfXojvUZbnMmcHiKN9WRDev1Ave6y_4my3ucOGQOeUeWNxaDhFWN9er0QKSNuL7wfZIrTHOJQk3KQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdefieekfecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhfffugggtgffkfhgjvfevofesthejredtredtjeenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epudekjefgleekfeefgfejueehieffvdffledtfeegiedukeehtdffueeivefffefgnecu
    ffhomhgrihhnpehgihhthhhusgdrtghomhdpmhgvshhonhgsuhhilhgurdgtohhmnecuve
    hluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhs
    rdhimhdpnhgspghrtghpthhtohepjedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtoh
    epjhhlthhosghlvghrsehgmhgrihhlrdgtohhmpdhrtghpthhtoheprhgrmhhsrgihsehr
    rghmshgrhihjohhnvghsrdhplhhushdrtghomhdprhgtphhtthhopehirhgvtggtrgdrkh
    hunhesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghl
    rdhorhhgpdhrtghpthhtohepphgvfhhfsehpvghffhdrnhgvthdprhgtphhtthhopehgih
    htshhtvghrsehpohgsohigrdgtohhmpdhrtghpthhtohepvghstghhfigrrhhtiiesghgv
    nhhtohhordhorhhg
X-ME-Proxy: <xmx:BAtuaNqzGV9OrZBOOwXtHGDVDE22v2_gUZAq2rP7V6vVTbJpxVsijA>
    <xmx:BAtuaOtq6Pw_52c6Mk-rU6tv89bTU7YahautD2oyOkLm2IcA4aGmCw>
    <xmx:BAtuaAZmNW3pzJE_9SLOUVkhGqUokQo4K_WeyoQvwbJQ2EaEN1CEXQ>
    <xmx:BAtuaFby1i-TXFeCny3PC7Iilxksen2IPBXLFExW5WnqjrqHSZj3nw>
    <xmx:BAtuaLByCgGcflpjEjUcTdGL4x1LvJeGGYLBYg-8Nz2dbSd1TjHLeYLn>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 9 Jul 2025 02:24:03 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 513e35c8 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Wed, 9 Jul 2025 06:24:02 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Wed, 09 Jul 2025 08:23:41 +0200
Subject: [PATCH v3 7/8] meson: update subproject wrappers
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250709-b4-pks-meson-cleanups-v3-7-29ab15b9ab85@pks.im>
References: <20250709-b4-pks-meson-cleanups-v3-0-29ab15b9ab85@pks.im>
In-Reply-To: <20250709-b4-pks-meson-cleanups-v3-0-29ab15b9ab85@pks.im>
To: git@vger.kernel.org
Cc: Ramsay Jones <ramsay@ramsayjones.plus.com>, irecca.kun@gmail.com, 
 Eli Schwartz <eschwartz@gentoo.org>, Jeff King <peff@peff.net>, 
 Junio C Hamano <gitster@pobox.com>, Justin Tobler <jltobler@gmail.com>
X-Mailer: b4 0.14.2

Update subproject wrappers to newer versions by executing `meson wrap
update` in the project's root directory

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 subprojects/expat.wrap | 18 +++++++++---------
 subprojects/pcre2.wrap | 18 +++++++++---------
 2 files changed, 18 insertions(+), 18 deletions(-)

diff --git a/subprojects/expat.wrap b/subprojects/expat.wrap
index 2e0427dcfd1..0e9292f97bf 100644
--- a/subprojects/expat.wrap
+++ b/subprojects/expat.wrap
@@ -1,13 +1,13 @@
 [wrap-file]
-directory = expat-2.6.3
-source_url = https://github.com/libexpat/libexpat/releases/download/R_2_6_3/expat-2.6.3.tar.xz
-source_filename = expat-2.6.3.tar.bz2
-source_hash = 274db254a6979bde5aad404763a704956940e465843f2a9bd9ed7af22e2c0efc
-patch_filename = expat_2.6.3-1_patch.zip
-patch_url = https://wrapdb.mesonbuild.com/v2/expat_2.6.3-1/get_patch
-patch_hash = cf017fbe105e31428b2768360bd9be39094df4e948a1e8d1c54b6f7c76460cb1
-source_fallback_url = https://github.com/mesonbuild/wrapdb/releases/download/expat_2.6.3-1/expat-2.6.3.tar.bz2
-wrapdb_version = 2.6.3-1
+directory = expat-2.7.1
+source_url = https://github.com/libexpat/libexpat/releases/download/R_2_7_1/expat-2.7.1.tar.xz
+source_filename = expat-2.7.1.tar.bz2
+source_hash = 354552544b8f99012e5062f7d570ec77f14b412a3ff5c7d8d0dae62c0d217c30
+patch_filename = expat_2.7.1-1_patch.zip
+patch_url = https://wrapdb.mesonbuild.com/v2/expat_2.7.1-1/get_patch
+patch_hash = fe28cbbc427a7c9787d08b969ad54d19f59d8dd18294b4a18651cecfc789d4ef
+source_fallback_url = https://github.com/mesonbuild/wrapdb/releases/download/expat_2.7.1-1/expat-2.7.1.tar.bz2
+wrapdb_version = 2.7.1-1
 
 [provide]
 expat = expat_dep
diff --git a/subprojects/pcre2.wrap b/subprojects/pcre2.wrap
index 7e184472543..f45c968e2f3 100644
--- a/subprojects/pcre2.wrap
+++ b/subprojects/pcre2.wrap
@@ -1,13 +1,13 @@
 [wrap-file]
-directory = pcre2-10.44
-source_url = https://github.com/PCRE2Project/pcre2/releases/download/pcre2-10.44/pcre2-10.44.tar.bz2
-source_filename = pcre2-10.44.tar.bz2
-source_hash = d34f02e113cf7193a1ebf2770d3ac527088d485d4e047ed10e5d217c6ef5de96
-patch_filename = pcre2_10.44-2_patch.zip
-patch_url = https://wrapdb.mesonbuild.com/v2/pcre2_10.44-2/get_patch
-patch_hash = 4336d422ee9043847e5e10dbbbd01940d4c9e5027f31ccdc33a7898a1ca94009
-source_fallback_url = https://github.com/mesonbuild/wrapdb/releases/download/pcre2_10.44-2/pcre2-10.44.tar.bz2
-wrapdb_version = 10.44-2
+directory = pcre2-10.45
+source_url = https://github.com/PCRE2Project/pcre2/releases/download/pcre2-10.45/pcre2-10.45.tar.bz2
+source_filename = pcre2-10.45.tar.bz2
+source_hash = 21547f3516120c75597e5b30a992e27a592a31950b5140e7b8bfde3f192033c4
+patch_filename = pcre2_10.45-2_patch.zip
+patch_url = https://wrapdb.mesonbuild.com/v2/pcre2_10.45-2/get_patch
+patch_hash = 7c6f34b703708652a404f9dc2769c67658c437b6043573295fa3428a9b7a6807
+source_fallback_url = https://github.com/mesonbuild/wrapdb/releases/download/pcre2_10.45-2/pcre2-10.45.tar.bz2
+wrapdb_version = 10.45-2
 
 [provide]
 libpcre2-8 = libpcre2_8

-- 
2.50.1.327.g047016eb4a.dirty

