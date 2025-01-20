Received: from fout-a8-smtp.messagingengine.com (fout-a8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CB4A1E9B12
	for <git@vger.kernel.org>; Mon, 20 Jan 2025 16:17:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737389854; cv=none; b=YBm+KTA2h5coElgLXVqeKw9TJ6q0FwZdqYXgiL9sPCd2mCYI1MXjSms6NR5jXAsKA99W4nb7PfIfc/sPoEsqMvDhMZ344ZTk6d1WUcNesQ0qOI9ZBdZeSgKPWoO0bHTodC3HNokvvx/JKk8Joxmv/ww/HgMeYGQ3Iks7ARAP65E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737389854; c=relaxed/simple;
	bh=2fQJtX3NTdXO8OKKCNTdB67rFdW94l+9bC3gjTjh5CU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=jcuR0zVeYZwwO1NEYahY7ymiTJudnn5/KNqHrEyahXeawD79YGE9M2WkZUBWty/oE4P5ODxrZvmUFm2gdwlzCt3sYfPEr9mhCH47Z5Z4Mcvc00jplKssye7+XS2WsaiIcPk97HoLHSFbBhOvcEzRrzIFRnKIIELNIJ2NwkC3/mQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=aCXwLXEU; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=d6af6gKo; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="aCXwLXEU";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="d6af6gKo"
Received: from phl-compute-10.internal (phl-compute-10.phl.internal [10.202.2.50])
	by mailfout.phl.internal (Postfix) with ESMTP id 46F141380886;
	Mon, 20 Jan 2025 11:17:31 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-10.internal (MEProxy); Mon, 20 Jan 2025 11:17:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1737389851;
	 x=1737476251; bh=Z/Sm9Zlp0hVf15+pFN9ng9mhqTkLhnK31CaQcTBpJ9Q=; b=
	aCXwLXEUhnBPLbaN40bDUBEVU73vgJ/Y0X/r9m4qwH+rZ+HWUej7fGji8IF+Usm8
	7RNb9yhdrKILxVEl5RNjLfhFVB6Q4+rYsaZLPvbovH/4FSw/sL8/4TSCUcgFEfsm
	HnKdTYNV4xJbXhY2MtZnTKgf9NVFDne4fXl+e7yVcVvpawOC2SqqOtv7WxcO55XP
	T9LOx5evYCB/vNHzmThb0tj39aNKJ7sjxOyy96CTM67uLuVW5HZyAmO4OP50x39C
	5ivtUECLWc1URYmB7DkCTWy0q4otvoB4eWJGzpcUTXM29k+uDsPVveUQKsSS2alT
	2Ycz3wyKoJGycSNtDoDkqA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1737389851; x=
	1737476251; bh=Z/Sm9Zlp0hVf15+pFN9ng9mhqTkLhnK31CaQcTBpJ9Q=; b=d
	6af6gKo+uh0dTsrrxBl0Rp+niOo69nqZfQ2dvs0yOFtc2vekvWs9C+5U9SB3ThGM
	mbjbihm6GDt60G8W4Mm7lqs8dtvJx7bqFHrl805PkjOGy3XTTm8nihzaCqIoYWB8
	OH+LZKCX5MLq7Xk85dpY2SSSsGTlPwcx+3VwyIlSuhp65GgG+hSVRaXoU4MooMi+
	omzxMlajlnzIkuKsj1DGXl5XXjSpOuxdaHBetP2b8cummd7yOeh8P8xsdXtPHnyP
	E/UIzxMSYn4g+h7dEwKpeotgqUZfdcNnYeiUGWVhYu4ySmYU+NhMq2aMKJ5AYTiR
	Y7rW97ttZ/LsuP9ncMK4Q==
X-ME-Sender: <xms:G3eOZ0Qp9fYy6SZZlSJHoi6IOT9lKvmz2qXTMWQzR2UNVsqM41XqSQ>
    <xme:G3eOZxzGG7QF-SzHFhTXX0HjEmTkNWtciyy7hiQhlkpaLOZWR2MjDDtt2Lwn9aPIi
    gz1KLv2CCjo11USSQ>
X-ME-Received: <xmr:G3eOZx3aAIVBfP7avwH5aw0eY25o84QoL9ofqymkgIVG57fA3BdpMxI8qOXOf6wP0CzUB2aGkcIXksl4V7AP5zyGBwH6pk7dmH34B0BnlixjAg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudeiledgkedvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdej
    necuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrih
    hmqeenucggtffrrghtthgvrhhnpeffueeiudejvdekheeuvdekfeffiedvueelteekudeh
    jeetkeegvddugfdtgfeileenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmh
    grihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopedvpdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpd
    hrtghpthhtohepkhgrrhhthhhikhdrudekkeesghhmrghilhdrtghomh
X-ME-Proxy: <xmx:G3eOZ4BY8uL7JThLsNmkjX_9W_2QX1_mB8QUHWrk4_ce9gW_9gZvJQ>
    <xmx:G3eOZ9hy9i4FxMZUM-nupXSOpMCKFdPIihw661R0bxAA9nnW0hrDmA>
    <xmx:G3eOZ0qSIxr0hKBqz86DEfGgc3gN0ES-PsW4LxUG_koGdUXGdV3Xpw>
    <xmx:G3eOZwhXaZF2_uhzU7yEM7OXRx9yGTOg_HkXEhJBa3twvxBkNc382g>
    <xmx:G3eOZwsDHJ3WlmqYklfYBp3bcR1AxxTJzX_G6EHd8sSzqUOa7Sg5Oj6t>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 20 Jan 2025 11:17:30 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 358312d7 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 20 Jan 2025 16:17:28 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Mon, 20 Jan 2025 17:17:24 +0100
Subject: [PATCH v2 06/10] reftable/block: adapt header and footer size to
 return a `size_t`
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250120-b4-pks-reftable-sign-compare-v2-6-b4566d02e4a5@pks.im>
References: <20250120-b4-pks-reftable-sign-compare-v2-0-b4566d02e4a5@pks.im>
In-Reply-To: <20250120-b4-pks-reftable-sign-compare-v2-0-b4566d02e4a5@pks.im>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>
X-Mailer: b4 0.14.2

The functions `header_size()` and `footer_size()` return a positive
integer representing the size of the header and footer, respectively,
dependent on the version of the reftable format. Similar to the
preceding commit, these functions return a signed integer though, which
is nonsensical given that there is no way for these functions to return
negative.

Adapt the functions to return a `size_t` instead to fix a couple of sign
comparison warnings.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 reftable/block.c                    | 4 ++--
 reftable/block.h                    | 4 ++--
 t/unit-tests/t-reftable-readwrite.c | 2 +-
 3 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/reftable/block.c b/reftable/block.c
index 2380aabb2f..1275085257 100644
--- a/reftable/block.c
+++ b/reftable/block.c
@@ -15,7 +15,7 @@ license that can be found in the LICENSE file or at
 #include "system.h"
 #include <zlib.h>
 
-int header_size(int version)
+size_t header_size(int version)
 {
 	switch (version) {
 	case 1:
@@ -26,7 +26,7 @@ int header_size(int version)
 	abort();
 }
 
-int footer_size(int version)
+size_t footer_size(int version)
 {
 	switch (version) {
 	case 1:
diff --git a/reftable/block.h b/reftable/block.h
index 5f67ed74c5..bef2b8a4c5 100644
--- a/reftable/block.h
+++ b/reftable/block.h
@@ -137,10 +137,10 @@ void block_iter_reset(struct block_iter *it);
 void block_iter_close(struct block_iter *it);
 
 /* size of file header, depending on format version */
-int header_size(int version);
+size_t header_size(int version);
 
 /* size of file footer, depending on format version */
-int footer_size(int version);
+size_t footer_size(int version);
 
 /* returns a block to its source. */
 void reftable_block_done(struct reftable_block *ret);
diff --git a/t/unit-tests/t-reftable-readwrite.c b/t/unit-tests/t-reftable-readwrite.c
index 6b75a419b9..2e553154ea 100644
--- a/t/unit-tests/t-reftable-readwrite.c
+++ b/t/unit-tests/t-reftable-readwrite.c
@@ -643,7 +643,7 @@ static void t_write_empty_table(void)
 	check_int(err, ==, REFTABLE_EMPTY_TABLE_ERROR);
 	reftable_writer_free(w);
 
-	check_int(buf.len, ==, header_size(1) + footer_size(1));
+	check_uint(buf.len, ==, header_size(1) + footer_size(1));
 
 	block_source_from_buf(&source, &buf);
 

-- 
2.48.0.257.gd3603152ad.dirty

