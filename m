Received: from fhigh1-smtp.messagingengine.com (fhigh1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 279F31DB53C
	for <git@vger.kernel.org>; Wed,  4 Sep 2024 14:17:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725459427; cv=none; b=hOBDkASho+Kx6jVQN0kCJHzvuWpO98jCkuW6/WSB4CiUyJsG05yrs5gPpwzrOPXp28QBu9SdiBDXgj5XgGNLUvThab8DYcBVKKNmuf39yZYuiII7HllVIkdDpgdTIhynt2nLQZZBD09YfKwA69J39AmwWpCUhgSK03/Kxl0/9MY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725459427; c=relaxed/simple;
	bh=WJV7ZTffzxMTUUQZwfVQic13cfm+BlfrEvKBM9Q8Akg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mUisJqiph926TDC343ZyokaOsgnYZqvONXxsEhe28ZEPgfkjXtUw3hiCdoysKaO/bBcQlOsD4KCwCa8i8fuahASsrVhE1pbu/5k0e6PF9tWUXaMcOu+TusDyHz/YKrRAlYuLhRlTxV5OvLwrhjt5KvLFUApvNyf89IkkyGmQRkk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=RnGDa37Y; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=uF/WXhs5; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="RnGDa37Y";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="uF/WXhs5"
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 31497114020F;
	Wed,  4 Sep 2024 10:17:05 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Wed, 04 Sep 2024 10:17:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1725459425; x=1725545825; bh=u0M1X8O8Jp
	OdmDIbfBT2QXjGb60MbKWQqz0ekV13yXM=; b=RnGDa37Y04BowVY8yH7JDFXbi7
	gCbSY5VLYAG/FcEOWDmcA9wl2Lo0bKhKsgfKijCczDQGy0n6LXaqjs03+P85CvBw
	z+iWb45qFD6ZkqUN5rUbBx1krgqpsNvjUuzfh4w8v0ZUggjofbhtDqPzrW1uxuuO
	YOsROZ0Pai3QXxeTnjitbKKesJdJUpxlyzLbzw2Q/YgpTP5XuBj6/IP8+kVkVdrT
	MUPsdiBJhScJ6emAYyo8FqGoKzYp+l1BROiw7cWs2enklZhozRA3mDk6If+jeD3b
	s4u2QcPy72gudSOd1aKy9wbLAPh855X3eeIyhD45lwaWnSEmvGXCb97+IsIQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1725459425; x=1725545825; bh=u0M1X8O8JpOdmDIbfBT2QXjGb60M
	bKWQqz0ekV13yXM=; b=uF/WXhs52F/lDQIkYBrlu1uBEn0l66Acqt/On6axlV+o
	wyzpxPOspnypQDZUCg+2b+54Pq9HA9Lu1t4ZfwfbikZQmrRxwgamWGYBHyfOf0aD
	mE6rKhz54QIJSudA66WmGhJuZS9vr14vKQsL1MKvvwih54yrftW9opEXNku6trdO
	p9lB4WKG1VxPB9SKhuviDzllk27yQh9qdarLJ88Q7KtHJrbeMgX9NKWAwvtlwbH7
	LaIQxNnzHOFOghQ4ScR1P4919i4aXROcczrdS78bnfPvPf8nOnzXsgyAWQLQjRQZ
	uuPN34taUPzz0k9H6JWw/pYBVOBUYuJyDNQjo4H6Kg==
X-ME-Sender: <xms:4WvYZjexwTMkgjeWMGMtfB-6YE82id0j5joqmAIwRkt42qOsfhNr1g>
    <xme:4WvYZpP6WWeTJjcbqeqIM3C-c5I4jSxzoTnxE8R40ulbISvTI6sM4n5ErBz__vblP
    _mnp8blCI5q8HWGJA>
X-ME-Received: <xmr:4WvYZsgaVEnrugdTzh2AfNoSLLpyP-WoCdQZksljbjAcE-Fc0Qj8PAP1RD7SxKzcGatXJ24A3SBigPZfoXWak8THIOx4Oc5Z97kr52OrnGWF8kc>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrudehjedgjeegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhephfeigfdvffdvtdeuhfelgfelhefgfeevueetffdugfeh
    tefgveelhfeuueevuedvnecuffhomhgrihhnpehgihhthhhusgdrtghomhenucevlhhush
    htvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhm
    pdhnsggprhgtphhtthhopeelpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehrsh
    gsvggtkhgvrhesnhgvgigsrhhiughgvgdrtghomhdprhgtphhtthhopehsthgvrggumhho
    nhesghhoohhglhgvrdgtohhmpdhrtghpthhtoheplhdrshdrrhesfigvsgdruggvpdhrtg
    hpthhtohepshhpvggtthhrrghlsehgohhoghhlvgdrtghomhdprhgtphhtthhopehgihht
    shhtvghrsehpohgsohigrdgtohhmpdhrtghpthhtohepvghthhhomhhsohhnsegvugifrg
    hrughthhhomhhsohhnrdgtohhmpdhrtghpthhtohepphhhihhllhhiphdrfihoohgusegu
    uhhnvghlmhdrohhrghdruhhkpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlh
    drohhrghdprhgtphhtthhopehjohhhrghnnhgvshdrshgthhhinhguvghlihhnsehgmhig
    rdguvg
X-ME-Proxy: <xmx:4WvYZk-DIi4zIBDzJJZzFV4l81WKlJayV-EVoeDVPXpdLwZdTH02iQ>
    <xmx:4WvYZvumwnGXagUh0PmpTSjXLEJDMzFT_f1udgGHqWXTgSdYQ9m3_g>
    <xmx:4WvYZjE3MWyuIxLbGWz0E0K47YEu-Vsm81f9qHVfjntLZQBlOdoSUg>
    <xmx:4WvYZmMXVBrLr64f97NAmnQh1NVjNoVSppjMYeBZsYZtzMaPz53_cQ>
    <xmx:4WvYZtIVqzhoFYLJyVPeBRKdF2ZsBxgAaXMSHq83p7S40Z4Gvd_JsuOS>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 4 Sep 2024 10:17:03 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 351d7da1 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 4 Sep 2024 14:16:53 +0000 (UTC)
Date: Wed, 4 Sep 2024 16:16:59 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>,
	Junio C Hamano <gitster@pobox.com>,
	Kyle Lippincott <spectral@google.com>,
	Phillip Wood <phillip.wood@dunelm.org.uk>,
	Josh Steadmon <steadmon@google.com>, rsbecker@nexbridge.com,
	Edward Thomson <ethomson@edwardthomson.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH v8 06/14] clar: stop including `shellapi.h` unnecessarily
Message-ID: <c50e7a0ea68ba6fb4ef669403f79d3217d242f9f.1725459142.git.ps@pks.im>
References: <cover.1722415748.git.ps@pks.im>
 <cover.1725459142.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1725459142.git.ps@pks.im>

From: Johannes Schindelin <johannes.schindelin@gmx.de>

The `shellapi.h` header was included as of
https://github.com/clar-test/clar/commit/136e763211aa, to have
`SHFileOperation()` declared so that it could be called.

However, https://github.com/clar-test/clar/commit/5ce31b69b525 removed
that call, and therefore that `#include <shellapi.h>` is unnecessary.

It is also unwanted in Git because this project uses a subset of Git for
Windows' SDK in its CI builds that (for bandwidth reasons) excludes tons
of header files, including `shellapi.h`.

So let's remove it.

Note: Since the `windows.h` header would include `shellapi.h` anyway, we
also define `WIN32_LEAN_AND_MEAN` to avoid this and similar other
unnecessary includes before including `windows.h`.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 t/unit-tests/clar/clar.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/unit-tests/clar/clar.c b/t/unit-tests/clar/clar.c
index e2ebe551d38..cef0f023c24 100644
--- a/t/unit-tests/clar/clar.c
+++ b/t/unit-tests/clar/clar.c
@@ -19,9 +19,9 @@
 #include <sys/stat.h>
 
 #ifdef _WIN32
+#	define WIN32_LEAN_AND_MEAN
 #	include <windows.h>
 #	include <io.h>
-#	include <shellapi.h>
 #	include <direct.h>
 
 #	define _MAIN_CC __cdecl
-- 
2.46.0.519.g2e7b89e038.dirty

