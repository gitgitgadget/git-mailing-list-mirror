Received: from fout-b2-smtp.messagingengine.com (fout-b2-smtp.messagingengine.com [202.12.124.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91DFC212B39
	for <git@vger.kernel.org>; Fri, 28 Mar 2025 08:38:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743151129; cv=none; b=rOJo40upsSVJQpn1mazzF26SL7qwBzFeM9iTH7uHa3xoWQ4tYww4B9281NB/k5HHDj2UPkBXWr3S6XAX2GFQqsOP63ChvpHBba7abfkjF3cX0mfIT65bEyZpUZhplD5iS6WwbvctlmDZncFMS0TtvgPQVdSiT6fIqPFHB3uB+bg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743151129; c=relaxed/simple;
	bh=TrNgkcaVzWXmV+Tuzsf7QZ4NDMp0OOVwxFDaTsY43jM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=TYhQ0inTEM27Hc/sMbivRhJzmRyC5n06n3ckERmlGYq/qRr+SLwXF03FwYRzeX6BspwIO0GBRbK3shhjSWF4yGR+7vBRjRrBQdDl7PzUDdkmeSiuMhPSBpuFWMZzKMV0W+V3D3UmM8at+YRPGpR7oCp2ZWbQR5i4GLtRqnjhV3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=WjUXSL/C; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=XxMcxOJS; arc=none smtp.client-ip=202.12.124.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="WjUXSL/C";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="XxMcxOJS"
Received: from phl-compute-09.internal (phl-compute-09.phl.internal [10.202.2.49])
	by mailfout.stl.internal (Postfix) with ESMTP id 6259011401E1;
	Fri, 28 Mar 2025 04:38:46 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-09.internal (MEProxy); Fri, 28 Mar 2025 04:38:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1743151126;
	 x=1743237526; bh=vELvFE236sl50D7Yt1DH2r3BaibQjQc5w+x1Q5MACYo=; b=
	WjUXSL/CfysDpNq20L348jKtiYlB2BMvRT4cRlGcxfAuNwbGbo7GkxQB5BAb8jbx
	3Kq4dEueajBaM5FckYTWISvYXhRsNiSjZDtZ84d/jx/gX42Mgq4iU0wQZnuNEJV+
	orN/wUEjht1nb89LOk+JgAwbFsWIXnsc+wV3hnakXBK0bFwdJ96x9vLKcCRrIBD3
	wFjFuVquQTB7HvydbavlDmo7OY2+Ds7sbSPhZtLyCn4YiMq56uz1mMyibp2a/Kme
	Kogo0UE64SrYvHSKGRTO2o6+Ycx3e1A5+B2I87BnVmpc5Um1tO1hA5R/tXhceEXT
	6dHjJB1zdbtk0FzNtOHVpQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1743151126; x=
	1743237526; bh=vELvFE236sl50D7Yt1DH2r3BaibQjQc5w+x1Q5MACYo=; b=X
	xMcxOJSacmqu6GsVAzntOgYyb9zIR8xEG14hEtbnlYeTsuOul7pS2cX8KxDA31En
	0D19qSn/AO8ZeHsXbjwV663R+UKZIv4ByUD/9BOA2f8aH6uDMHO1IRq3pJUAq8nr
	x4+l1Z5Jcvfyq/v/ST/gjd9P6YRa9w2ngI+oRnougmkWJSd4WHgHq1wYMXrWv5Ia
	IGqPshBPU/BvoPSmfsJ0d6UZgd9aG0Uacr6pc6UCTSvdQceSTjXIA2qfL0WJMjEX
	9HzPDDCaWIPNlglsxX9EppIY+oasnj9XZ9/5ZMmpOUaMrcPbFQRrK2TWn9Qjjepu
	3IGWST16tg8Ro6ZLTNXrQ==
X-ME-Sender: <xms:FmDmZ3zZu5gAGK16Ewx5pHudm-tupA7Je8wplBWjbrej9EQx83oodg>
    <xme:FmDmZ_QdpxsaHxmFs5qXbdYaSesurXIBpxMsS_FWtJy5G-eUFSFv25n1MylD5ofz0
    0dyTTfJn91B01l5fw>
X-ME-Received: <xmr:FmDmZxVRYRfjqiYuq8TaNbNyCSbvc53_S2QXCKn8ygWPxVg2sT_wPcLsPubqHK79Z76NDZbiSDWCtYDQYztMi5yGAOW82QJQwZj9ruj-OeyzZSg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddujedtkeefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertder
    tdejnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhksh
    drihhmqeenucggtffrrghtthgvrhhnpeffueeiudejvdekheeuvdekfeffiedvueelteek
    udehjeetkeegvddugfdtgfeileenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeeipdhmohgu
    vgepshhmthhpohhuthdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorh
    hgpdhrtghpthhtohepshgrmhesghgvnhhtohhordhorhhgpdhrtghpthhtohepjhhohhgr
    nhhnvghsrdhstghhihhnuggvlhhinhesghhmgidruggvpdhrtghpthhtohepghhithhsth
    gvrhesphhosghogidrtghomhdprhgtphhtthhopehtghesuggvsghirghnrdhorhhgpdhr
    tghpthhtohepvghstghhfigrrhhtiiesghgvnhhtohhordhorhhg
X-ME-Proxy: <xmx:FmDmZxjQh51RHtLCm3zmBZO-d3VyM7DJShsvtcLp10iwJ0RoYr6ZqA>
    <xmx:FmDmZ5DuLPq1jPUW6iD9u7iasM9mR-oBnW1GFBcmvS0ys4lbTN0pcw>
    <xmx:FmDmZ6KPHTGj4Er9BpPTxoqqlQvVvwha9FnOyWYu8K5NUnhXlzK1UA>
    <xmx:FmDmZ4BFl9CkdF6cY1rI33hvP1wtUdmSOz0lhOxRagnOK5G-Eft8ZA>
    <xmx:FmDmZ72VAvdcCF4wP5mXgGiOzJdMtmyZEDIia9b0udQn27Gx_r2GZpr8>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 28 Mar 2025 04:38:44 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 33cc001a (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 28 Mar 2025 08:38:42 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Fri, 28 Mar 2025 09:38:36 +0100
Subject: [PATCH 2/4] gitweb: fix generation of "gitweb.js"
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250328-b4-pks-collect-build-fixes-v1-2-ead9deda3fbc@pks.im>
References: <20250328-b4-pks-collect-build-fixes-v1-0-ead9deda3fbc@pks.im>
In-Reply-To: <20250328-b4-pks-collect-build-fixes-v1-0-ead9deda3fbc@pks.im>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, Sam James <sam@gentoo.org>, 
 Eli Schwartz <eschwartz@gentoo.org>, Thorsten Glaser <tg@debian.org>, 
 Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-Mailer: b4 0.14.2

In 19d8fe7da65 (Makefile: extract script to generate gitweb.js,
2024-12-06) we have extracted the logic to build "gitweb.js" into a
separate script. As part of that the rules that builds the script
has gained a new dependency on that script.

This refactoring is broken though because we use "$^" to determine
the set of JavaScript files that need to be concatenated, and this
implicit variable now also contains the build script itself. As a
result, the build script ends up ni the generated "gitweb.js" file,
which is wrong.

Fix the issue by filtering out non-JavaScript files.

Based-on-patch-by: Thorsten Glaser <tg@debian.org>
Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 gitweb/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/gitweb/Makefile b/gitweb/Makefile
index d5748e93594..26a683d4421 100644
--- a/gitweb/Makefile
+++ b/gitweb/Makefile
@@ -118,7 +118,7 @@ $(MAK_DIR_GITWEB)gitweb.cgi: $(MAK_DIR_GITWEB)gitweb.perl
 $(MAK_DIR_GITWEB)static/gitweb.js: $(MAK_DIR_GITWEB)generate-gitweb-js.sh
 $(MAK_DIR_GITWEB)static/gitweb.js: $(addprefix $(MAK_DIR_GITWEB),$(GITWEB_JSLIB_FILES))
 	$(QUIET_GEN)$(RM) $@ $@+ && \
-	$(MAK_DIR_GITWEB)generate-gitweb-js.sh $@+ $^ && \
+	$(MAK_DIR_GITWEB)generate-gitweb-js.sh $@+ $(filter %.js,$^) && \
 	mv $@+ $@
 
 ### Installation rules

-- 
2.49.0.472.ge94155a9ec.dirty

