Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DC68157A48
	for <git@vger.kernel.org>; Fri, 25 Apr 2025 05:47:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745560073; cv=none; b=jjwhoO49vxkqtRiQtrosXcjanRKAO6yKU/ogpG0upAJ4rbgD5GZsrZRuqIS97lognNIFj9QAOVckWPEwfTlRQj8RiXPwDUQTGlZwG+eCI9t7Luo7D2fN21oa4IBPxbQVfgF3Js6rQn0FBpxkEFjo0D6jxB6HIDppREkyujGe/hI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745560073; c=relaxed/simple;
	bh=Bjk7uAilTp04MzKdaZ1uqU5x2nPdwwYfDrKTzXgzAwM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=MMRHorbzTMpexMXahzKjsXMs1syf17HoMKJZR/aI9alG+vr/rt3NSWhDMNoYsgDDD98nU7OrjnQxuJlN2gSqRpyL1muEYhU9jaPVrzTwgljrOnQPAZN18g8IGd84/21BKScVFscWkSxY5E2xgN2Jl+S0b9HiYgf69CujlXLt3N8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Wx/iYOlj; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=vI/h1QWf; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Wx/iYOlj";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="vI/h1QWf"
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfhigh.phl.internal (Postfix) with ESMTP id B597611401BD;
	Fri, 25 Apr 2025 01:47:50 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Fri, 25 Apr 2025 01:47:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1745560070;
	 x=1745646470; bh=WyuvzPygi42bwSYKFiZhcEdq53sQTY/sZcf/8+U4tl4=; b=
	Wx/iYOljKsXDjxJ1otVS/rTbof6WALO7Rlu7ptXX9zVUWD0Y3E+/qnEkYzrH/wPU
	nsV/LB95xyK9QhAxw10ACbt8rsrowQWZMto8J+bZ639SYkOeRNON4ZFB7ZNZjzmJ
	KbNJQ7lPOTvNRYWSpw6FvqtTBW73hjlgMQgdRdYTTQCfYyU3TXT8F01j4csDtFK7
	l/dvOq8s/dXJeIJXNETEdcH5WiEwABNDI+aZR0bttI29omAuazfzKsKHKABFxHJy
	zPIS81xK6hk50c41AqKe2DmjjXiyIrpX+VJ4ZoDUZTUi4FcZuTVr6d3toUZ0k9Ve
	oaZyIdAjbwxNAKKqEQyLig==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1745560070; x=
	1745646470; bh=WyuvzPygi42bwSYKFiZhcEdq53sQTY/sZcf/8+U4tl4=; b=v
	I/h1QWfAsU9LVESEpSPJt8PRLB1MD8W64oMSPv00/g2VvyDALoaIH/mfbzPnF/J2
	G0tbKwFY005tP15rmRIzvCbP93PJZ4fJhX005VmxJcF8UZVJtsX/T1J7l1RCKOfs
	mAqv7uwG3UgXg+PCL5n4xVTOvdbdtfvReb4s/IQhBNq6WqsQXUw8HD/ueQfCBEx8
	OhQ6o23Of/ezTTrdwV+HZy9ju/G5mQQh6u5lW4SpRyjlSEXpRNgYRM2AmiqzYIj6
	J7lfS36khAG3PBK7Ndk9SvnxE/6xbWi42asTnYbWF+6Vd41sCOdsX7PUMYIPll+C
	Dd8J93+6r4dARSXjEFTAA==
X-ME-Sender: <xms:BiILaKj4fPukBv9c9UjR_D5btZ4iDXps9LIul-QF4bNZQA6QnbcHgA>
    <xme:BiILaLDrco60pHLnX2zofQip-bbVXZnyJRSSHPAM_4ls2qmvI-bVkLhZJgUzrbiTV
    6ImkDBj8mCnUaUnZg>
X-ME-Received: <xmr:BiILaCHSTsT5-AmFOe-6-BMylKANbKSTK3oaas7hzFmYFx4OyssZVPtL-ndVZsY0orjJNDztPXFkZtLW6Ld6pNLgaeETBgFNhtp4D7k1>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvheduheegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertder
    tdejnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhksh
    drihhmqeenucggtffrrghtthgvrhhnpeffueeiudejvdekheeuvdekfeffiedvueelteek
    udehjeetkeegvddugfdtgfeileenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeehpdhmohgu
    vgepshhmthhpohhuthdprhgtphhtthhopehpshdrrhgvphhorhhtsehgmhigrdhnvghtpd
    hrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomhdprhgtphhtthhopegvshgt
    hhifrghrthiisehgvghnthhoohdrohhrghdprhgtphhtthhopehjlhhtohgslhgvrhesgh
    hmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:BiILaDSKqP83yUqkeZ0yiFuPoTgvKK7saV1liWSQTATbRrkYjsyVeA>
    <xmx:BiILaHxUIQPeiRmh49ozvJzTYDsH0vVKSpARQrNsygyMvzNm1eEVZw>
    <xmx:BiILaB79TjJydLFnZozZhLymz7pQAPSvHdTCnylLwc508lKJrhTNMw>
    <xmx:BiILaExLUDEZUAJvkuQ-0KPWNLxvDjM-W3fTFRrwmnlbaG4t7gmjig>
    <xmx:BiILaLC5vQGJcN-7fFmj1CrifEaNJoS2KOAJB5TrPaiCi-_WGZbOIPIJ>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 25 Apr 2025 01:47:49 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 585d6aef (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Fri, 25 Apr 2025 05:47:48 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Fri, 25 Apr 2025 07:47:45 +0200
Subject: [PATCH v2 2/2] meson: prefer POSIX-specified shell path
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250425-pks-meson-posix-shell-v2-2-fddc6123511b@pks.im>
References: <20250425-pks-meson-posix-shell-v2-0-fddc6123511b@pks.im>
In-Reply-To: <20250425-pks-meson-posix-shell-v2-0-fddc6123511b@pks.im>
To: git@vger.kernel.org
Cc: Peter Seiderer <ps.report@gmx.net>, Junio C Hamano <gitster@pobox.com>, 
 Eli Schwartz <eschwartz@gentoo.org>, Justin Tobler <jltobler@gmail.com>
X-Mailer: b4 0.14.2

Meson detects the path of the target shell via `find_program("sh")`,
which essentially does a lookup via `PATH`. This may easily lead to a
subtly-broken Git distribution when the build host has its shell in a
non-standard location that the target host doesn't know about.

Fix the issue by appending "/bin" to the custom program path, which
causes us to prefer "/bin/sh" over a `PATH` lookup. As this location is
specified by POSIX this should make us pick a better default shell path
on all POSIX-compliant systems.

Note that we intentionally append, not prepend, to the custom program
path. This is because the program path can be configured by the user via
the `-Dsane_tool_path=` build option, which should take precedence over
any defaults we pick for the user.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 meson.build | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/meson.build b/meson.build
index a180c66ee69..c0d0982b00f 100644
--- a/meson.build
+++ b/meson.build
@@ -236,7 +236,10 @@ sed = find_program('sed', dirs: program_path, native: true)
 shell = find_program('sh', dirs: program_path, native: true)
 tar = find_program('tar', dirs: program_path, native: true)
 
-target_shell = find_program('sh', dirs: program_path, native: false)
+# Detect the target shell that is used by Git at runtime. Note that we prefer
+# '/bin/sh' over a PATH-based lookup given that '/bin/sh' is the location
+# specified by POSIX. This lookup can be overridden via `program_path`.
+target_shell = find_program('sh', dirs: program_path + [ '/bin' ], native: false)
 
 # Sanity-check that programs required for the build exist.
 foreach tool : ['cat', 'cut', 'grep', 'sort', 'tr', 'uname']

-- 
2.49.0.967.g6a0df3ecc3.dirty

