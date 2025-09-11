Received: from fhigh-b3-smtp.messagingengine.com (fhigh-b3-smtp.messagingengine.com [202.12.124.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDB672EA15B
	for <git@vger.kernel.org>; Thu, 11 Sep 2025 09:16:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757582186; cv=none; b=PqY8iYA7VujAh3p0bcCxIXrOTxac2KWBNJZv9pcWFjCzXce62fuA4Y0K+aocVFkzqYT+1kgEI2ToyA6ySiDc4WSOsQ9/9mi8GdOMcAziqMOprh4oqB/P2GO/HCWTyZPVFVgmv6xr61ETn30b9adt2gtLkpSNr4n0byb+hQ4eRN0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757582186; c=relaxed/simple;
	bh=34UwevPzNf8MFtLwHQZ8wwUKoSJv58d81S+LcQeRyHo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=D8BAiDUi6TlGzUyIW6s6BouCmwPoy07fxGugRlunWT6I4/dhWdhfufANT+qO9mX3iid/MaP8qeBlDBlEKIGD0+IqIRtJgQG3iKXnWVTvG5wPjzgj0pncV2Suob0m9/St+DrQdMZmGgu8qZ9xkbTho40vZoCawzgF7lW03P7L9hs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=oHyiTA0/; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=KP8ATn4p; arc=none smtp.client-ip=202.12.124.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="oHyiTA0/";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="KP8ATn4p"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 8537E7A01B8;
	Thu, 11 Sep 2025 05:16:23 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Thu, 11 Sep 2025 05:16:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1757582183;
	 x=1757668583; bh=sI3GuIYAZiLHkI8iaWdY/hRLZOqtOdzkq1i/D2+0Qcs=; b=
	oHyiTA0/IqagpcmJ29tjwqbHV5s2gsLrvLWjjlTi8UEDK/WBiP/N1akPXPaCT4mU
	bTO62X4L4M95ZPIc5yEFR+E5hO70zTokmWiAzmK7jr2OUx5GrWGwdG0f83TJ7lho
	NahX57bBk1ztNJZUcOwYhj6wHcsC/MEiHgeQNeBc6B1SFJppICO1XrnT0ZGtDBV2
	UFv3bnmbVIIX0fEH05oYsG0+i+zcDubyrY96S5ArNKuoaBtnP0wyUAv5NnItdt5I
	yHSdRyTnRsmxKDji2fM/JKv6aGWVJPb6/Eirtaj4SSu67JVrFKHQaqWa5QKInO1n
	giZABNxMW++CkZwmtcxhyg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1757582183; x=
	1757668583; bh=sI3GuIYAZiLHkI8iaWdY/hRLZOqtOdzkq1i/D2+0Qcs=; b=K
	P8ATn4pFwvOX0/+/bc7eyshnVdeEKJBfd6gtxvL2P9aWZnKFD9OT92EfJveVTO/P
	zGMmvIi4AHO3c1nKTt7S8ELp0duf9QuwUv/FEUHrgA2u7RuU08y0q7UrcmES6Cz9
	hjrH/wxoImjbkB4niJGXI3d3LpAByZnItKpFN2MJmB7pIneQ0PCMrlIaTlTg33HP
	1mzQasbLhPNA3KUAzA4OblSfAWUEyib64hh7/ekSWehj9LUr0hLn6NOi6IlnEgrJ
	T2iXd1aj0cfB+NUYM9FJ7Csm+695cRghRGk3m7OCB/bHt3ug2G27Ux0dP7AKn8e3
	QkSvHQHQ2CxYu4Xek/FgQ==
X-ME-Sender: <xms:Z5PCaI6RmP2lhehzx49pZSpzdEjtWkKZu8JpJQTYCrr3Z7hRS1wlPw>
    <xme:Z5PCaKGD7JPGVL3klZhN2IC43AQ8jSUMHBlkQMBAtCsKmrTA1AeXfbxNK-yPmuxVG
    baipH1bjrOmUjr8ag>
X-ME-Received: <xmr:Z5PCaJT6PJgpYCeSTHz4DrIgyUM0GB58ijf32Np4ZwdWLA6c80gFa-vp-3gk5UBVejMLcJCjgO63w6ETf0XUeO2lisDaOxxQET5Y4KTuhg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvheejkecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecunecujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertd
    ertdejnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhk
    shdrihhmqeenucggtffrrghtthgvrhhnpeffueeiudejvdekheeuvdekfeffiedvueelte
    ekudehjeetkeegvddugfdtgfeileenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgr
    mhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopedvpdhmoh
    guvgepshhmthhpohhuthdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdho
    rhhgpdhrtghpthhtohepshiivgguvghrrdguvghvsehgmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:Z5PCaLsmTt3ZsJZ3pApM4OdRNx7A_bzMBp5D_FLXY4r19SNw7zg_UA>
    <xmx:Z5PCaAxrDu0ovow5v1-YEeOeVwV820nazPL4YyyDIeJeFFUV_vtNug>
    <xmx:Z5PCaN4O9dWmCCsq8Mrs5fr0HM8fatT_TsV4IUdanZSUtkcIQGsHDg>
    <xmx:Z5PCaCXALC-_e_xynzKaOxagQGwqgCf6RPMaHuuLili0WZsN_gDuaA>
    <xmx:Z5PCaEIHu-eGi-L2cOYc63WWF1o_X9fwzdV9KK6hJt934AYWcQ5XIVOg>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 11 Sep 2025 05:16:22 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 7a42aafd (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Thu, 11 Sep 2025 09:16:21 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Thu, 11 Sep 2025 11:16:07 +0200
Subject: [PATCH 2/3] meson: print docs backend as part of the summary
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250911-b4-pks-meson-docs-target-v1-2-a92c666ecef9@pks.im>
References: <20250911-b4-pks-meson-docs-target-v1-0-a92c666ecef9@pks.im>
In-Reply-To: <20250911-b4-pks-meson-docs-target-v1-0-a92c666ecef9@pks.im>
To: git@vger.kernel.org
Cc: =?utf-8?q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
X-Mailer: b4 0.14.2

Our documentation can be built with either Asciidoc or Asciidoctor as
backend. When Meson is configured to build documentation, then it will
automatically detect which of these tools is available and use them.
It's not obvious to the user though which of these backends is used
unless the user explicitly asks for one backend via `-Ddocs_backend=`.

Improve the status quo by printing the docs backend as part of the
"backends" summary.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 meson.build | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/meson.build b/meson.build
index 40b2a2dc54..4a504fc26d 100644
--- a/meson.build
+++ b/meson.build
@@ -2103,6 +2103,8 @@ subdir('bin-wrappers')
 if get_option('docs') != []
   doc_targets = []
   subdir('Documentation')
+else
+  docs_backend = 'none'
 endif
 
 subdir('contrib')
@@ -2251,6 +2253,7 @@ summary({
 
 summary({
   'csprng': csprng_backend,
+  'docs': docs_backend,
   'https': https_backend,
   'sha1': sha1_backend,
   'sha1_unsafe': sha1_unsafe_backend,

-- 
2.51.0.450.g87641ccf93.dirty

