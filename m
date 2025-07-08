Received: from fout-a7-smtp.messagingengine.com (fout-a7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24AA629B23E
	for <git@vger.kernel.org>; Tue,  8 Jul 2025 07:58:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751961494; cv=none; b=QrHscU7Q4KBR62RiIgrDK/OSaGbyEsj65UPHIMwV+bqueQL4TWqktPUL4HpQSYCIPWL9xFXmrTezVezU/xqHBwnBnrJ2bWeZA2Qe4nHiEw6xI4CoJO6KdRXAdOcajY1c/TgqNgAJNog7Mjo6UAbjjFLNXAyvyOExgWNZzuAgxWs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751961494; c=relaxed/simple;
	bh=p4RIjIIag34ZnXpMBK0x9rHPWi8Pc0ODL/WsAkwt6Eo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=C1ycIqIk9RFn1ulFBIRuo0c5UqMM08hX7Qt02MCOW8r+OGFdYOV9tgoYt9FegYk4IXf/nxPfhtBHDXZiSGtMuTDBIl7TAI8he9W8QgAqcJ7i6SxbF1LqGMeDE+MpM/eBoPI9APQ8vervmauL1MDAzozI06n9nYJCQLzLcggFyWk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=hOj7PSRK; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=YNpKJG2K; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="hOj7PSRK";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="YNpKJG2K"
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfout.phl.internal (Postfix) with ESMTP id 4DE1AEC0B5A;
	Tue,  8 Jul 2025 03:58:12 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Tue, 08 Jul 2025 03:58:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1751961492;
	 x=1752047892; bh=iwFiOFiFOxxZx/2xZ85jZV7r34RW0lbAvDFfc7V8yZU=; b=
	hOj7PSRKpwwiynwAYqerFMzejW23dlthZtNd16sU41tQLumoLazRwibUqiB2jbpC
	Mbmy5Hrs/NzlwAk46WwwNigtJzFNoyD6FanHRGRBx0/jeECRBWPobfYvhYMJ8qIC
	xiZwHj3vG8MWTLzjasyjX/CN/GqIz9051hKKOg3ljdbopW1NwaLqdppOHw6wf/9m
	WJWA3Mip0X23n91URp1QspFxmQivYEGrpM1DCvZNFUNbd2i8249dHJtdi9/QUPg4
	Kn5SMI87H0bfO43cMDWl6qItAxTBrSlMLm/4UzPjluw0tWyt7Ub3rVPAUy2vrJfv
	yVvwd/wNHk/1hKixsDtThw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1751961492; x=
	1752047892; bh=iwFiOFiFOxxZx/2xZ85jZV7r34RW0lbAvDFfc7V8yZU=; b=Y
	NpKJG2KSV/Wa9Rw3fOts5GLyuz3wtlcJaPCLv+J5GV8oHE8MFJo6YpqRfm2sIEIZ
	o2s9VaZAHc+iyYI1pN+zKldpyIeAO4K5PZ/aOyx4JaA/fqHvpJ77LihnxVPb+boQ
	xtdm5yCmN7Wj23ROXqb3j6jMf9yXnWfWMqij5UjyJpvLHh9+U37/x7Xx8PwRVRuT
	Bqq9JSWZDNMFjefxkRENG02PNwUJVqUTGBFd0D8iePEAsTpQWbvgDeI+P57hmz1R
	4TKj4WruSnf+5AeN/kfdotu+G/AJCsvulPpRHIKtHdp4bfmaQkWvoAF7NKxR2mTy
	KOiaezoS2S2DL6fqsR+EQ==
X-ME-Sender: <xms:lM9saB4_6GD_2hF3rXhmqwP9LSrPvD-Rfie94U-FECAso9KkMOvgew>
    <xme:lM9saPqitYVzz2vaYv89r2YZQhb9r9fDBhXb1rRZEr9oN3ZQjfyPpGfjEy8YFEBEq
    bKLiISqFLm8vJ1SEA>
X-ME-Received: <xmr:lM9saEkfa7iuaIMDB-160NREk73vuEwPzIqyz060Q6ZirWyjr-dYT8tyXsybG4hdpoi-qAcTBa3j6k9uuAM0gt3YOReucx2oKDgiXv-1SN8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdefgedugecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhfffugggtgffkfhgjvfevofesthejredtredtjeenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epudekjefgleekfeefgfejueehieffvdffledtfeegiedukeehtdffueeivefffefgnecu
    ffhomhgrihhnpehgihhthhhusgdrtghomhdpmhgvshhonhgsuhhilhgurdgtohhmnecuve
    hluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhs
    rdhimhdpnhgspghrtghpthhtohepiedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtoh
    epphgvfhhfsehpvghffhdrnhgvthdprhgtphhtthhopehirhgvtggtrgdrkhhunhesghhm
    rghilhdrtghomhdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhmpdhrtg
    hpthhtohepvghstghhfigrrhhtiiesghgvnhhtohhordhorhhgpdhrtghpthhtoheprhgr
    mhhsrgihsehrrghmshgrhihjohhnvghsrdhplhhushdrtghomhdprhgtphhtthhopehgih
    htsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:lM9saLNeDPf_zB67tTdSXHb1k5XyGnYwa6DWtYh2eNTEdmCP8ilqfQ>
    <xmx:lM9saIMoK9MLFEXudvgZcEL77KsCvlvEqlDzYiHqLrq-A44JKRCBLw>
    <xmx:lM9saMjNzY0NKXH7pwrpAzakd_GIlbNvktGpDxrWDtQOUJwwsWE6Tg>
    <xmx:lM9saFu8kfpppS0G3DZjfYjgb2txDRt9SArSGceQ7r978QTzn7DWcw>
    <xmx:lM9saErC1-MPZuyEL320yRlMGWei_n3OmrzVEFC5d18iMDpidr2RJ1-x>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 8 Jul 2025 03:58:11 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 48a156a6 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Tue, 8 Jul 2025 07:58:10 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Tue, 08 Jul 2025 09:57:48 +0200
Subject: [PATCH v2 7/8] meson: update subproject wrappers
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250708-b4-pks-meson-cleanups-v2-7-94ac53cd4b95@pks.im>
References: <20250708-b4-pks-meson-cleanups-v2-0-94ac53cd4b95@pks.im>
In-Reply-To: <20250708-b4-pks-meson-cleanups-v2-0-94ac53cd4b95@pks.im>
To: git@vger.kernel.org
Cc: Ramsay Jones <ramsay@ramsayjones.plus.com>, irecca.kun@gmail.com, 
 Eli Schwartz <eschwartz@gentoo.org>, Jeff King <peff@peff.net>, 
 Junio C Hamano <gitster@pobox.com>
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
2.50.0.195.g74e6fc65d0.dirty

