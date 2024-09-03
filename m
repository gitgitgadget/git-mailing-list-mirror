Received: from pfhigh7-smtp.messagingengine.com (fhigh7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF17E1AD249
	for <git@vger.kernel.org>; Tue,  3 Sep 2024 09:14:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725354897; cv=none; b=aU2BRiNa9jWsCGUcbLBmu0hXfiCaPDGNvNsySs77vdoMVD6Nm/TsYkrhPJhzIymbRDyZp/0lSRrqAJ9clNcJi9YBmVH3M9QAlw6z8rzfO4PZE0C3N6oE5qcaqPNHttzWJvWoH4c8Mo0Xpmkv0VIQPAWxnsHBsf4cxI8zZwj1gvk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725354897; c=relaxed/simple;
	bh=elt6OztjLWNA785lG+uQt+uYcY3TvhS3V6bCtJDMj6o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BBeiNyCdYcnUoT8glRdEzHYpLBvceCGvCtybwYUHkSyERHGLV/HVDi9p4bl2EEtUvw5hJKyiklcT0sNRFADWmsX1u3bLH381GW3JpgD+zyDG/mQd2ko9rLkIevTw1TzeQTTkIqdNgMZt7B2230h69HoosXXdyikdbUsdEL4Mvx8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=jJ6a3/mq; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=K3SrAjfT; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="jJ6a3/mq";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="K3SrAjfT"
Received: from phl-compute-02.internal (phl-compute-02.phl.internal [10.202.2.42])
	by mailfhigh.phl.internal (Postfix) with ESMTP id F3A9711402E3;
	Tue,  3 Sep 2024 05:14:54 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Tue, 03 Sep 2024 05:14:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1725354894; x=1725441294; bh=ZE5XUuGZ46
	Crv+NZ1+Ywoca9QPuQ/dphbASL7tc8nM0=; b=jJ6a3/mqJ53lIQLqgVf6TlYMle
	NR2CdnJLAsQHPE6Di2IlH5AA+fUY+yLxZaBn+IAZ0TcHd4oayfUQu07PH8GelF6G
	WB4ZXf3Cg6cH3ppxPf4q7FKo6QpnzynX0Fr/xCT+BLloQ+lzp030lXt2LP+lxa78
	S7qhFz0f3morU/Y3lOnDO0+tEiwlF5VZe0QkRBEWQKH46t0kUhIpEJmonx9B1ZGq
	XzStTn9B5H7oh8kWSaau6/Ij8sOJ06VRpPKkSIqus2hm6wps8j3Ux+scWk64g/MX
	A0cCYfuNE2jEgdQ2qOQjRZVdNfK6lwvcocPrMMVGghAR7GADqV2His7s3ZIA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1725354894; x=1725441294; bh=ZE5XUuGZ46Crv+NZ1+Ywoca9QPuQ
	/dphbASL7tc8nM0=; b=K3SrAjfTPEAXvCnAIMnKeuBOK18h2pf/b3C/z1Xr/ZmH
	vx/bCYbVf4iTwUSNrwnP4XC/A6DJxKg6h4TgGVRCuPTIG+P1nsNCSqpASYuP++2z
	i4Pcqk5dz2cV8FJYXagwb7v8UTHS88WvvKnO2MBsr5gN5tqs/I8aZGgrNgkliiKk
	j+fqM6sGaBqq8o5Ye8encINyAlTBuPilBtuyhWoMBSx3DvGNQcDnmBQ7E7cThpfk
	mgvObK80l7kftjjW8qjd5boWi/nOFv516sLME7tSoxxkEUVcPwDCUNeeibJgLLB3
	Ae/bVKGV80MQbePdawumBIPpQt4msy2GeiereAd/sg==
X-ME-Sender: <xms:jtPWZg_NQ96xHvr71sIs0omkJifisnDEbDo9CGxNfFWDoeU1p8wiEw>
    <xme:jtPWZovl4-C6Tli4c3orFQTz_DRItiqgmien2sna0CPbNj8QPD3MlRF7au7DDmQMl
    oZ3K-hPzSLAv5SFoQ>
X-ME-Received: <xmr:jtPWZmD2x54-zsGsKZsRPYfWSaQBc6vNoijuXS-v08VQplf4nREVSHOw9z2pyxUc4eLvfJKuM9-QlZzV6CJnCIc9UbeepdThOsI9Tickwt4CCQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrudehhedguddvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhephfeigfdvffdvtdeuhfelgfelhefgfeevueetffdugfeh
    tefgveelhfeuueevuedvnecuffhomhgrihhnpehgihhthhhusgdrtghomhenucevlhhush
    htvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhm
    pdhnsggprhgtphhtthhopeelpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehrsh
    gsvggtkhgvrhesnhgvgigsrhhiughgvgdrtghomhdprhgtphhtthhopehlrdhsrdhrseif
    vggsrdguvgdprhgtphhtthhopehsphgvtghtrhgrlhesghhoohhglhgvrdgtohhmpdhrtg
    hpthhtohepphhhihhllhhiphdrfihoohguseguuhhnvghlmhdrohhrghdruhhkpdhrtghp
    thhtohepvghthhhomhhsohhnsegvugifrghrughthhhomhhsohhnrdgtohhmpdhrtghpth
    htohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehsthgvrggu
    mhhonhesghhoohhglhgvrdgtohhmpdhrtghpthhtohepjhhohhgrnhhnvghsrdhstghhih
    hnuggvlhhinhesghhmgidruggvpdhrtghpthhtohepghhithhsthgvrhesphhosghogidr
    tghomh
X-ME-Proxy: <xmx:jtPWZgeT4eeNX__qRmzoeiQjl2dQpqfu6NayhsYFU5t1aYY-Unk5pw>
    <xmx:jtPWZlOo2z2PG692Pe3EqRjy-RGNoG8WThGel8D1G7yU18mH6QnKQg>
    <xmx:jtPWZqnZK1cspKOUUaphyG5RngPGc6Iwg6sJ3k4QG5dxgCIhDUGRMA>
    <xmx:jtPWZnsUoysDDsn50uUXYWtJAo1WYTD-fUp4ADG_KlchJFxiTpl23g>
    <xmx:jtPWZoqDrf8-8V6mEkImhpngGVUI0wc_c0c5W8p4HPjsKo5hKpOWzoAL>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 3 Sep 2024 05:14:53 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 66d175a5 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 3 Sep 2024 09:14:46 +0000 (UTC)
Date: Tue, 3 Sep 2024 11:14:51 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>,
	Junio C Hamano <gitster@pobox.com>,
	Kyle Lippincott <spectral@google.com>,
	Phillip Wood <phillip.wood@dunelm.org.uk>,
	Josh Steadmon <steadmon@google.com>, rsbecker@nexbridge.com,
	Edward Thomson <ethomson@edwardthomson.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH v7 06/14] clar: stop including `shellapi.h` unnecessarily
Message-ID: <c50e7a0ea68ba6fb4ef669403f79d3217d242f9f.1725349234.git.ps@pks.im>
References: <cover.1722415748.git.ps@pks.im>
 <cover.1725349234.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1725349234.git.ps@pks.im>

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
2.46.0.421.g159f2d50e7.dirty

