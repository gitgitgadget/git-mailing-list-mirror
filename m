Received: from fout-b5-smtp.messagingengine.com (fout-b5-smtp.messagingengine.com [202.12.124.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E35561DEFF3
	for <git@vger.kernel.org>; Tue, 28 Jan 2025 08:41:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738053699; cv=none; b=ZuIau9pmooHzMYx4fRgYJNhLR+HY9LcSWuvgl3xotq+4IPRhvHX4Ku8+sIahkHfRUOnajSsX6FM3JevOWUjLvOK7gx/2Cer7/y/1ktxrp6qjvqz2C4L6qSNwRQrfUV+ZylphIWDAl0/ZhQ+gTBWdXp3s0Gx9cxHixONiv0p+OY4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738053699; c=relaxed/simple;
	bh=WkNRQ5OP8InFmb7RaZ1AgZ9Am+mQ+ESi1PLWumZBAEo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=RC1o71hpchXF8hPQO20c00b/P/0a6iSL1D6Mx5Hx0H2QeYL7JqydhWrRph9hhP+684P0xPiUq73Wk7cQOh8JGHVgtLDnOmIQnwDX9MSLAKEUjhnEUDMjB56vRciTWSzP30p5T4gp5tFCYOh75Y71Ogp7yZ6MM8NdiU0W3Ie/+7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=eIvzLDtB; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=gWeaGHot; arc=none smtp.client-ip=202.12.124.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="eIvzLDtB";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="gWeaGHot"
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfout.stl.internal (Postfix) with ESMTP id 0EDD11140147;
	Tue, 28 Jan 2025 03:41:37 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Tue, 28 Jan 2025 03:41:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1738053696;
	 x=1738140096; bh=EOpwSWjj8DXYLilpD/esfIidbFB2onV3Kcr5xCru00o=; b=
	eIvzLDtB/f4WgaUwPCUIThkVW5OVSuVbdcdcH6cPwbP0VaVaaPpUTqws6JRQmUkF
	URockx5/W8v7J3wo7WIiaHkCBK2C8EbkyxMsL8gKfI0m8nu+C1cAyw2hiets4Kxy
	5gS8kCcwPP5fYhoYIMMYnM+yb1tTeNIHWlZ1IA44rxOedHMN+AF/FR46vMfvins3
	wVabCsO0QR+xY499Xa4dZU8nc8KOBxAL6xH2pKkuEL4iGhqCwK4Jcb3sfBT5MRUq
	nL8367OAHKLYYsOtm8UEfUJvd5HoyK4jxwUi8c1RISXuL52wdJMEe4wgRL4d4AKB
	BT6DMrEYtW6hPn4KPxywWQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1738053696; x=
	1738140096; bh=EOpwSWjj8DXYLilpD/esfIidbFB2onV3Kcr5xCru00o=; b=g
	WeaGHotGN7H0ZVeQRxGXm1IRjamPHHvJyV6DLhsiIeuCRHH+4F+NevqlrVJmymPH
	/h9tpNIxQR/ABKUCHR0qtDDFcBRVjzZSlDaeCUhxIRAIkMD6+3S510u6AUyfU8gh
	5oQ4jPsoRDjBoXdQLCCNvsOcuxyYUYzG2uyublStrD++JXaeNwhwOtqAg9PYxSdl
	wvFViS/gUBCdtehTwac6Z93j1ss7a7HZ/O6zuX0yQCzZVspTvVDYKE49qIvXua40
	uCAlSlSjLas5TVLhBK09SifZXswSBswFrbjC+SgU/d3C3jSMbt3KXuZxfFptQ7/C
	GDBJwF3qLqGafDX1FjvlA==
X-ME-Sender: <xms:QJiYZ8toTZyJWBUyCdfsFp2iFkzSIwFXa9DKU3_dxq_UTS40-3GsYQ>
    <xme:QJiYZ5ccNgZ-4j8ZbgKv2_wzam3bR6yB4gVBqvK6yXmHlitPPikxAEoaQ2THAuk6W
    a2OeW0D8N3sQkjV5w>
X-ME-Received: <xmr:QJiYZ3wuTofJ4QUDhNCZcIJBjhDIsLyurUCArvfBdZSD6BxkOLcpAFEH6tpBRhBXUMqKOQKiITH_SI29_fDGx0SDzKXEM_mQgO35x-s9saA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudejgedgudehieehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertder
    tdejnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhksh
    drihhmqeenucggtffrrghtthgvrhhnpeffueeiudejvdekheeuvdekfeffiedvueelteek
    udehjeetkeegvddugfdtgfeileenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeefpdhmohgu
    vgepshhmthhpohhuthdprhgtphhtthhopehkrghrthhhihhkrddukeeksehgmhgrihhlrd
    gtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphht
    thhopehmvgesthhtrgihlhhorhhrrdgtohhm
X-ME-Proxy: <xmx:QJiYZ_OeQIGQJI9TJyRaBGQjnu2x37pIae5sSsDXWGho3er74RgN_A>
    <xmx:QJiYZ8_DmZUzINDbJFQUoSLPOnd4qrtKXH6oKS_aDaeAFLaxMUeY0g>
    <xmx:QJiYZ3X1Hl6JET8Pt4QVVU_VEyq1AiBkRmSQ0s-myi9s64ChAtn6KA>
    <xmx:QJiYZ1cyLxQ6iyuqXlRbvq5xOBPcVkuYjC-CQiUXPosbHanV8mHjhg>
    <xmx:QJiYZ7a0AmdE2G0cBYI7YD12DdXuHb6xszsR_V2GUli0VIRFxjCJLgN_>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 28 Jan 2025 03:41:35 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 6676bfcf (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 28 Jan 2025 08:41:34 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Tue, 28 Jan 2025 09:41:31 +0100
Subject: [PATCH v4 05/10] compat/zlib: provide `deflateBound()` shim
 centrally
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250128-b4-pks-compat-drop-uncompress2-v4-5-129bc36ae8f5@pks.im>
References: <20250128-b4-pks-compat-drop-uncompress2-v4-0-129bc36ae8f5@pks.im>
In-Reply-To: <20250128-b4-pks-compat-drop-uncompress2-v4-0-129bc36ae8f5@pks.im>
To: git@vger.kernel.org
Cc: Taylor Blau <me@ttaylorr.com>, Karthik Nayak <karthik.188@gmail.com>
X-Mailer: b4 0.14.2

The `deflateBound()` function has only been introduced with zlib 1.2.0.
When linking against a zlib version older than that we thus provide our
own compatibility shim. Move this shim into "compat/zlib.h" so that we
can adapt it based on whether or not we use zlib-ng in a subsequent
commit.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 compat/zlib-compat.h | 4 ++++
 git-zlib.c           | 4 ----
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/compat/zlib-compat.h b/compat/zlib-compat.h
index bc20b884ef..96a08811a9 100644
--- a/compat/zlib-compat.h
+++ b/compat/zlib-compat.h
@@ -3,4 +3,8 @@
 
 #include <zlib.h>
 
+#if defined(NO_DEFLATE_BOUND) || ZLIB_VERNUM < 0x1200
+# define deflateBound(c,s)  ((s) + (((s) + 7) >> 3) + (((s) + 63) >> 6) + 11)
+#endif
+
 #endif /* COMPAT_ZLIB_H */
diff --git a/git-zlib.c b/git-zlib.c
index d43bbeb6da..2e973320c2 100644
--- a/git-zlib.c
+++ b/git-zlib.c
@@ -147,10 +147,6 @@ int git_inflate(git_zstream *strm, int flush)
 	return status;
 }
 
-#if defined(NO_DEFLATE_BOUND) || ZLIB_VERNUM < 0x1200
-#define deflateBound(c,s)  ((s) + (((s) + 7) >> 3) + (((s) + 63) >> 6) + 11)
-#endif
-
 unsigned long git_deflate_bound(git_zstream *strm, unsigned long size)
 {
 	return deflateBound(&strm->z, size);

-- 
2.48.1.362.g079036d154.dirty

