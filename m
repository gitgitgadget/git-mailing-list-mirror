Received: from fout-a4-smtp.messagingengine.com (fout-a4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98C1026B946
	for <git@vger.kernel.org>; Wed,  9 Jul 2025 06:23:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752042240; cv=none; b=itDXVSZ0R2d0qEvFiOGKfNPUcZfx7qgWyY41P+h+eFYm+SgW1rTrmF0DtSwJ88eBX5+03QgQ9DUI9Yc9lYg0Hxx27n1GmGjJAiGoeVYI0t5IuJADzPAVX2x666j+E9xW6l9TSEhYFTB59CCa6WtqEWu1CVMDBkyHG4irwamloGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752042240; c=relaxed/simple;
	bh=UiMAf0/KV3dPXpqHDpGs4bI3y93Z4/DXl/leP0ONvuI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=h3/tMu5q1YJ99VnCr7wXx3fzmTGKeXg7JnF878qthhF4h9ZcqyFYgcKcd2T1KCTKqC9JvFQHTRq23fkk81xbZhFQghHYlJVQ6+787Y9xgpMhve13vXh+mugni/Z8DYS/lMgjUOZmfQqQakle4y5efB5cr/jFrQgNI69ScKa0RXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=RT1ociup; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=SP1YpVuR; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="RT1ociup";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="SP1YpVuR"
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfout.phl.internal (Postfix) with ESMTP id AB592EC02A5;
	Wed,  9 Jul 2025 02:23:57 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Wed, 09 Jul 2025 02:23:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1752042237;
	 x=1752128637; bh=X5MlD3EB4mle0hNK/5WWOOjRJdAqR1J9RhSiX3Jyv0c=; b=
	RT1ociuppTcVMpowLTs8fC6kQcsfwvGzMTCOn6W2ZG2+omYK1b3Ap5f7GxBU0TSR
	ngjBSaESvDkKPO6zos3sUklZyBezMeDwq9BBtzrd7zYboAWVgCZi/t0U9YG5A9vD
	BmbeKaHs3jYYDDUU1Un0s9egvFkK8+msOoFkBCJD8/F7dCfru0ZDNj5S7T+Btfm0
	PpwIa/QVtvQgdPLxoz+NJ0jx2mcnbq8gYdrJ1FgTD4vl7uUG9xISYO1SJsGYeQGh
	qtmiTEzd6EvIvj2L15y6cOs1tM7buTBf0CSuDo+LbGwhRPTHRTEs/U7CFkeyanVo
	6V+Pv1wscnjPupcLuqOWSg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1752042237; x=
	1752128637; bh=X5MlD3EB4mle0hNK/5WWOOjRJdAqR1J9RhSiX3Jyv0c=; b=S
	P1YpVuRkmYilki7VQFLZnAhagux7V9HS9HfD7u+kaE6/gj7V+UEWGYAURc19T1Gv
	7MWyB8brVgFD0IOeqd0YSE7XsLNHT/LseiixgUIEatuArxBl3WFwysWRq2GRXE0W
	QhD3aiB9DU5Ppu05fTc+hW93xZbK2f/3+zuB/V8X3hYrWnx09PO2lrWrpDcacmMV
	z/fN7woRHfhenUuJ0fZccn58M3ubT1uNwlkXNoyZ6clg9kkHGOluwqwSy07o8+KR
	kuq2pwEfecEm2R0/Ubi9Al+cyox+NQFP/lyKWI4uzkBv8LdTeWKs+xHD4yaw1tn9
	Oy/djcueLv989nGh9IR7w==
X-ME-Sender: <xms:_QpuaHlbRtdrQG09c-pJpKAr1KTkbZogAxQg-ZxWglxcXv41SqlnQw>
    <xme:_QpuaOp8ZGj0WRb-c2GGn1YOUWN-VuOrZxQleutUU1CppWi7BoUXGJ0-ZSqybjY_t
    gricJScLGTucq5kjw>
X-ME-Received: <xmr:_QpuaGvLCCGnRnxPCQ1yDAL7ikDLzP_ckJtyPo1a5AivIBJCMdDruTkprw6lvzpGGBKtitIwcRFKX1zhtFyjl38YLAfP5U9tDdSkB9mXV283rQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdefieekfecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhfffugggtgffkfhgjvfevofesthejredtredtjeenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epffeuiedujedvkeehuedvkeefffeivdeuleetkeduheejteekgedvudfgtdfgieelnecu
    vehluhhsthgvrhfuihiivgepudenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimhdpnhgspghrtghpthhtohepjedpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepghhithhsthgvrhesphhosghogidrtghomhdprhgtphhtthhopehjlhhtohgslhgvrh
    esghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdho
    rhhgpdhrtghpthhtohepphgvfhhfsehpvghffhdrnhgvthdprhgtphhtthhopegvshgthh
    ifrghrthiisehgvghnthhoohdrohhrghdprhgtphhtthhopehirhgvtggtrgdrkhhunhes
    ghhmrghilhdrtghomhdprhgtphhtthhopehrrghmshgrhiesrhgrmhhsrgihjhhonhgvsh
    drphhluhhsrdgtohhm
X-ME-Proxy: <xmx:_QpuaDEa_7sDQ2pOLk685I48H60m0qiBmA4qA_ORfaL0elbxkXr56A>
    <xmx:_QpuaPYnu24eMQ--ZAR4evreli_vCc3tGE-pIzphKrzq_TinqotOpQ>
    <xmx:_QpuaLXF6wm9FF7NGKjTgYtIWVx0-Oxv7eFleZ0YKWbp1917zbpUsg>
    <xmx:_QpuaNnpyLpr2J8WwGHwMvi_9EdFa3GTxv8CgjTgUI_NWAAgb8B6rA>
    <xmx:_QpuaGcjOvZdi-4lMd7EET1WZB9v5E7zpsoLyvT3q1uuEN-68iYEITW4>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 9 Jul 2025 02:23:56 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 21bc744c (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Wed, 9 Jul 2025 06:23:55 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Wed, 09 Jul 2025 08:23:39 +0200
Subject: [PATCH v3 5/8] meson: fix lookup of shell on MINGW64
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250709-b4-pks-meson-cleanups-v3-5-29ab15b9ab85@pks.im>
References: <20250709-b4-pks-meson-cleanups-v3-0-29ab15b9ab85@pks.im>
In-Reply-To: <20250709-b4-pks-meson-cleanups-v3-0-29ab15b9ab85@pks.im>
To: git@vger.kernel.org
Cc: Ramsay Jones <ramsay@ramsayjones.plus.com>, irecca.kun@gmail.com, 
 Eli Schwartz <eschwartz@gentoo.org>, Jeff King <peff@peff.net>, 
 Junio C Hamano <gitster@pobox.com>, Justin Tobler <jltobler@gmail.com>
X-Mailer: b4 0.14.2

In 4cba20fbdc6 (meson: prefer shell at "/bin/sh", 2025-04-25) we have
addressed an issue where the shell path embedded into Git was looked up
via PATH, which easily led to unportable shell paths other than the
usual "/bin/sh" location. The fix was to simply add '/bin' to the search
path explicitly, which made us prefer that directory over the PATH-based
lookup.

This fix causes issues on MINGW64 though, which uses Windows-style
paths. "/bin" is not an absolute Windows-style path, but Meson expects
the directories to be absolute. This leads to the following error:

    meson.build:248:15: ERROR: Search directory /bin is not an absolute path.

Fix this by instead searching for both '/bin/sh' and 'sh', which also
causes us to prefer '/bin/sh' over a PATH-based lookup. Meson does
accept that path alright on MINGW64, even though it's not an absolute
Windows-style path, either.

Furthermore, this continues to work alright with cross-files, as well,
in case one wants to explicitly override the shell path:

    $ meson setup build
    ...
      Runtime executable paths
        perl       : /nix/store/gy10hw004rl2xfbfq41vnw0yb1w8rvbl-perl-5.40.0/bin/perl
        python     : /nix/store/sd81bvmch7njdpwx3lkjslixcbj5mivz-python3-3.13.4/bin/python3
        shell      : /bin/sh

    $ cat >cross.ini <<-EOF
    [binaries]
    sh = '/nix/store/94lg0shvsfc845zy8gnflvpqxxiyijbz-bash-interactive-5.2p37/bin/bash'
    EOF

    $ meson setup build --cross-file=cross.ini --wipe
    ...
      Runtime executable paths
        perl       : /nix/store/gy10hw004rl2xfbfq41vnw0yb1w8rvbl-perl-5.40.0/bin/perl
        python     : /nix/store/sd81bvmch7njdpwx3lkjslixcbj5mivz-python3-3.13.4/bin/python3
        shell      : /nix/store/94lg0shvsfc845zy8gnflvpqxxiyijbz-bash-interactive-5.2p37/bin/bash

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 meson.build | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/meson.build b/meson.build
index 29d076bbaac..02d73188537 100644
--- a/meson.build
+++ b/meson.build
@@ -245,7 +245,7 @@ time = find_program('time', dirs: program_path, required: get_option('benchmarks
 # "/bin/sh" over a PATH-based lookup, which provides a working shell on most
 # supported systems. This path is also the default shell path used by our
 # Makefile. This lookup can be overridden via `program_path`.
-target_shell = find_program('sh', dirs: program_path + [ '/bin' ], native: false)
+target_shell = find_program('/bin/sh', 'sh', dirs: program_path, native: false)
 
 # Sanity-check that programs required for the build exist.
 foreach tool : ['cat', 'cut', 'grep', 'sort', 'tr', 'uname']

-- 
2.50.1.327.g047016eb4a.dirty

