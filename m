Received: from fout-a7-smtp.messagingengine.com (fout-a7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 890FB29ACF6
	for <git@vger.kernel.org>; Tue,  8 Jul 2025 07:58:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751961488; cv=none; b=cVbsbt0hhdZ7erenl0lhYcbXVUFUDeckvcpIuf1O14bZf4SnA/JGekiRfzOn9b7IepxzdGWHkFf+TBwrTl2w0Bwj5L9TpOHoXd8QvczR0zO/oHvd+pHI96KxYDmyb8o3CD0bcBRMQz1Bj1imqeyOqFSj96LTQZEr4K70u9Zelig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751961488; c=relaxed/simple;
	bh=hJONLTwkSYfghEZjP/3q8QatzvNBhHPCPOPUiMQSzK8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Zbkg7QZZ0zZVRlACKsWEBYDeOtJsOdXqAOv97s0B5idLVlHM40+eONcSejpc7lITAEU5PHW5+M47TLQAtXc+OL+uB/xA79i6srgxIq08vg6dbqS1Mq+32jg+0hUQR8NOKJ0LfgHXTrcE4/nvvtnMiZq3Q0BgDycWszSxO+a5tMc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=w/9fESPw; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=mePbvn1X; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="w/9fESPw";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="mePbvn1X"
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfout.phl.internal (Postfix) with ESMTP id B9BD5EC0B5A;
	Tue,  8 Jul 2025 03:58:05 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Tue, 08 Jul 2025 03:58:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1751961485;
	 x=1752047885; bh=NK7aPe8TovAzBoHdAtKvmiHplZq4alhsiL/cmditjZg=; b=
	w/9fESPwHNcqNgs3VJev2cxwPz9yrK/iwoQ4PmTT/WfNIocDGon/HQe+WA7TmSwy
	njkXNRTUiole5EhdpdQoR12jhepkb7Mzt7sYBv0jrt/5avddHqXoq+HKWUCfJ2Fs
	nZL3s5ieds0uraYvqYyFio3OFOC8hUdWWLAtwNCbedkrpEijgiUENoxGuvUJFntI
	1Dc2hkec9dA632Oh7uvpxs3pHnYDiXHV/U+hPPCZ7aga86hF1YIcaWeZ/ndt0Ixo
	V1CXfQIPvxEzXF3VJEfOl6o5emHB0+W/+IX12mWtwOk78Pqq8n28yM9m60ZM3wC5
	DprxAOg0uZCrwtiFVdot9Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1751961485; x=
	1752047885; bh=NK7aPe8TovAzBoHdAtKvmiHplZq4alhsiL/cmditjZg=; b=m
	ePbvn1XmEiJg37DCtLJV3iPuX2sefHOt/HCN314fnkZD69APkgSn43zoIrJv0vU2
	QkyidVQfeWIgO1/0Uy5BJXdIaEQCCqB2zRy3wDcx5IngmHfP3fC6bSysFYwsT5Fa
	cIHecVvwT7rPeDj1IH2wp5yAnpTV8wedNGyKURCU8F1vKSsfb5fWZUpX+ufjAlvu
	vLmjYI+h2FdPn0HWWJWHXQ0tfkuFqJZrYlDJdMniSFG2w/L+e+MSSOkYnS6G6/rY
	EGeTKkm3UYa9f0QeouJs0gw3GDH4X4AvSOPgvbJwTU3q3sTdVfdb2rL8i3bCiux7
	dDOLcovQqG2BeWep6iXdw==
X-ME-Sender: <xms:jc9saPLqGdSsOWJqkFtAFsPQWLrIolh8BlOLA-4lenu4v9VlZwx64Q>
    <xme:jc9saD5ErHGRLw5OUvI9EqYPzeb7blHqjz1eWxG5ATHFSGyUBoKm2zrCkUBJqspyN
    KuAh01l4eofegw20Q>
X-ME-Received: <xmr:jc9saD3hAGg-O87_o4bxqwXhWh_cdn-6ipxun3lJuhwaEttBpZtjij1VmwmnZ7QWDIDlGitcrt4I_28rk__awk3X4pasRndkFq6a1jjIjjE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdefgedugecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhfffugggtgffkfhgjvfevofesthejredtredtjeenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epffeuiedujedvkeehuedvkeefffeivdeuleetkeduheejteekgedvudfgtdfgieelnecu
    vehluhhsthgvrhfuihiivgepudenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimhdpnhgspghrtghpthhtohepiedpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    oheprhgrmhhsrgihsehrrghmshgrhihjohhnvghsrdhplhhushdrtghomhdprhgtphhtth
    hopehpvghffhesphgvfhhfrdhnvghtpdhrtghpthhtohepvghstghhfigrrhhtiiesghgv
    nhhtohhordhorhhgpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomhdprh
    gtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepihhr
    vggttggrrdhkuhhnsehgmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:jc9saJcrAaunssG7BQvyBn1XpHaa-pLX_hRHJ4ySdyu-7cjguy43Iw>
    <xmx:jc9saJc9q_yBhNnVl81g2n-veRkqr9rKSkowPrFjhdkeIvbW8Ssu-w>
    <xmx:jc9saEy_thJhkCGOkcxe-G8PmXSf3fO-RHvkjbEX2c2_j5i_dYamSA>
    <xmx:jc9saI8pbfgr22ZfrCdfCwcG4nACiDBXHH1Fm_OZERXV_NXMqlM3lA>
    <xmx:jc9saArV0uvoXLMy9p5qaie0LKatB0BioCDIYs6YMBcaITtS10Mujo_n>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 8 Jul 2025 03:58:04 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 54a2e893 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Tue, 8 Jul 2025 07:58:03 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Tue, 08 Jul 2025 09:57:46 +0200
Subject: [PATCH v2 5/8] meson: fix lookup of shell on MINGW64
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250708-b4-pks-meson-cleanups-v2-5-94ac53cd4b95@pks.im>
References: <20250708-b4-pks-meson-cleanups-v2-0-94ac53cd4b95@pks.im>
In-Reply-To: <20250708-b4-pks-meson-cleanups-v2-0-94ac53cd4b95@pks.im>
To: git@vger.kernel.org
Cc: Ramsay Jones <ramsay@ramsayjones.plus.com>, irecca.kun@gmail.com, 
 Eli Schwartz <eschwartz@gentoo.org>, Jeff King <peff@peff.net>, 
 Junio C Hamano <gitster@pobox.com>
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
index 4f22d72641e..bef80b118a8 100644
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
2.50.0.195.g74e6fc65d0.dirty

