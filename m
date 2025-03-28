Received: from fhigh-b2-smtp.messagingengine.com (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CAE8212FA1
	for <git@vger.kernel.org>; Fri, 28 Mar 2025 08:38:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743151129; cv=none; b=WjPSmsIaofvDb9V+Nn7zlED6alD9hRBPDcjoP5aKEXJEdF6CZCt/ScURAVPSL05Bpqapil+8uIzBHpEsMUa3ilcQ65KOp/cfoP87yItSldy3HRFJOob7jl4Vy2c4/3GkCDO869vhuHEmNk2ryH/+cgfab0A9yVWgBZsZrHzi+cM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743151129; c=relaxed/simple;
	bh=chVaoPlyut2l4weiZmt36VrLKkqYxppb8dZwWMJHKlg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=dIbCxhkOqyV8xKXU1+WtHciGHIljlmderOHjjvrBZBH4RvH7DJeouoQzPKUbzSoeGB+IXSqszEQ8yeFomv35jzNWrtPUKwLyyHz5hb1fmPWKyveO4WoErFZgDZ+0t+InNkkr7KAwwmgbFqzlbdXp9Z/Lu9KFgmhWesQMNoxB/EE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Pv0PY7fY; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=pMfYns/i; arc=none smtp.client-ip=202.12.124.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Pv0PY7fY";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="pMfYns/i"
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 4A9D025401B4;
	Fri, 28 Mar 2025 04:38:46 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Fri, 28 Mar 2025 04:38:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1743151126;
	 x=1743237526; bh=y+0SGKZlU5DD6aS2R3PLleGueA9fWlSiu2TPsSqL39o=; b=
	Pv0PY7fYsFGluCMAXYWox5cKzyriSfgqgasbzTV1eFye8IZfZrVkl68P2nkm5pzl
	GLW7J2dEVwEk9o4Gx8ljiLSagrl6c4cn1OBPjnMWLjm+v/coe4lYfLmTErE2djP8
	UtXNLKpl8Bpums3smU17a12DN2/SA3Usg59cOR5hnmr467/PL72yzKahrLpHsWrx
	bg8atyXgi4xSHFxXl7oRLk+JAvcLvquLAcDdazZrqQiTVlReU6z7TWfLjyhPIrVs
	p/LrsYuVvHxvRoTv7o4C9nP+PSJt67AwmpOvBNwMLCNY9xPjRI+lb9rzosNjxGbs
	2vUH2JWafTc1LBcq32UgGQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1743151126; x=
	1743237526; bh=y+0SGKZlU5DD6aS2R3PLleGueA9fWlSiu2TPsSqL39o=; b=p
	MfYns/iBnZYfX7y7SX0NFVpRY0bO4TJBExufMGpZdOXioCmXCHRXAIQlCFv87Sfj
	Y3vxLEO7ToarfVvjN0SRm2dN++r+ceGUqqkn01za1IPdkMAy9g/BUgA4drtJNCC3
	g43G5wJLQ4VrNXb2OQev7vowyXuf1KTKQdHGlx7NXONUVpwxuPnLroQKcnnBJ7kc
	F6CmpFGgYW11oCHleXuuBHYD0RHR86dBe33aZNtJHSkJCIwYB1x6Y9++SYwRXP5S
	ddt2ttAYfB9Xm+lUYjCgB7t95oAuG8+ZtzWZbVMc5Rb6x7zYR5KWAn7BE/rsAVK/
	Ew+yNCsAsd+n15a1sFP1w==
X-ME-Sender: <xms:FWDmZ65KwsUukOhLzf7h6u1LHn4OgJXkfVvYqd_tjNuOb57d-uJFjg>
    <xme:FWDmZz48MMe8io8ap1JTU5gGxNaRyrbPKyl2a0FE4uwWPUjosBdtm5Eu6Pdi-8_Fg
    TwWrCRDem9VII3M9Q>
X-ME-Received: <xmr:FWDmZ5eyMWrzkHXqoG-9do5RnnQC_I__cBV6sXaeSOWytb9ZGkVes5UMaJeWmdkbAS8uu6EBPZzQ1cBq7ZcdKEftxyQxPqVlQMQiCJk3mha8if0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddujedtkeefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertder
    tdejnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhksh
    drihhmqeenucggtffrrghtthgvrhhnpeffueeiudejvdekheeuvdekfeffiedvueelteek
    udehjeetkeegvddugfdtgfeileenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeeipdhmohgu
    vgepshhmthhpohhuthdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorh
    hgpdhrtghpthhtohepjhhohhgrnhhnvghsrdhstghhihhnuggvlhhinhesghhmgidruggv
    pdhrtghpthhtohepshgrmhesghgvnhhtohhordhorhhgpdhrtghpthhtohepthhgseguvg
    gsihgrnhdrohhrghdprhgtphhtthhopegvshgthhifrghrthiisehgvghnthhoohdrohhr
    ghdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:FWDmZ3IgtLdoH6fSg2bsUTcgW5ZnS1bAoi6oHWDPKCmMYuTT2GqPig>
    <xmx:FWDmZ-IANA7ELtyAWGtpR_RTLAzULVl_oLC23Bo_hCD4Kn0aKSdJIA>
    <xmx:FWDmZ4wILhKiEa17GYqFoa-eTOoHUc4kOvRPoOpeNh6t_RdYmt8P6A>
    <xmx:FWDmZyL99NTOP1SzJUer5sUQfKUQv_GfWMlYGK6XUjlM-KQjwLnG7A>
    <xmx:FmDmZ2-3L31J3cS6jBNgjbml6SzF5Myyon-aKJi-MA5jGA-XQvzIqXDz>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 28 Mar 2025 04:38:44 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 1a03cf8d (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 28 Mar 2025 08:38:41 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Fri, 28 Mar 2025 09:38:35 +0100
Subject: [PATCH 1/4] meson: fix handling of '-Dcurl=auto'
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250328-b4-pks-collect-build-fixes-v1-1-ead9deda3fbc@pks.im>
References: <20250328-b4-pks-collect-build-fixes-v1-0-ead9deda3fbc@pks.im>
In-Reply-To: <20250328-b4-pks-collect-build-fixes-v1-0-ead9deda3fbc@pks.im>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, Sam James <sam@gentoo.org>, 
 Eli Schwartz <eschwartz@gentoo.org>, Thorsten Glaser <tg@debian.org>, 
 Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-Mailer: b4 0.14.2

The "curl" option controls whether or not a couple of features that
depend on curl shall be included. Most importantly, these features
include the HTTP remote helpers, which are rather quintessential for a
well-functioning Git installation. So while the dependency can in theory
be dropped, most users wouldn't consider the resulting installation to
be fully functional.

The "curl" option is defined as a feature, which means that it can be
"enabled", "disabled" or "auto", which has the effect that the feature
will be enabled if the dependency itself has been found. While most of
the other features have "auto" as default value, the "curl" option is
set to "enabled" by default due to it being so important. Consequently,
autoconfiguration of Git will fail by default if the library cannot be
found.

There is a bug though with how we handle the option in case the user
overrides the feature with `meson setup -Dcurl=auto`: while we will try
to find the library in that case, we won't ever use it because we later
on check for `get_option('curl').enabled()` when deciding whether or not
we want to build dependent sources. But `enabled()` only returns true if
the option has the value "enabled", for "auto" it will return false.

Fix the issue by instead checking for `curl.found()`, which is only true
if the library has been found. And as we only try to find the library
when `get_option('curl')` returns "true" or "auto" this is exactly what
we want.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 meson.build | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/meson.build b/meson.build
index efe2871c9db..a8d1e63ccc6 100644
--- a/meson.build
+++ b/meson.build
@@ -1686,7 +1686,7 @@ bin_wrappers += executable('scalar',
   install_dir: get_option('libexecdir') / 'git-core',
 )
 
-if get_option('curl').enabled()
+if curl.found()
   libgit_curl = declare_dependency(
     sources: [
       'http.c',

-- 
2.49.0.472.ge94155a9ec.dirty

