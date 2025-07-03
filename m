Received: from fhigh-b7-smtp.messagingengine.com (fhigh-b7-smtp.messagingengine.com [202.12.124.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BE282D94B7
	for <git@vger.kernel.org>; Thu,  3 Jul 2025 09:30:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751535030; cv=none; b=SqbiWUoMXOzqSYDSYJHf7+8TRAdgwS+ufQ+Db6Qmdf2xBNw/lqJ41Kce8inLI6KEo0u9Wm3xLZi0ujRc3//6KN4edYh04eYffBA7sSS6RgoKdpvQsQ2vMZvMx4ajmPer1VVb/X5rey9Fd1nGQZqp1i82kWmUltpgNMLFvFo6wo8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751535030; c=relaxed/simple;
	bh=hJONLTwkSYfghEZjP/3q8QatzvNBhHPCPOPUiMQSzK8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=G4q+QmA9Iq93oxYwOGQ6N16C9ZTgMVS3OoJVwRjlgew+9C/pwQKKGAjbYm5HwnnxLiHa4UYaSFD0EMHNw07FSO7QOkRST34KABThrJcJ2XCTomuqNyQ4G6sbiMKwx49LDzdZXsYmL7T5/BklrZjEailNUjEBKmmzl01D0+4e68A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=PAc2fzCC; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ek4eY/4F; arc=none smtp.client-ip=202.12.124.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="PAc2fzCC";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ek4eY/4F"
Received: from phl-compute-09.internal (phl-compute-09.phl.internal [10.202.2.49])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 274187A0268;
	Thu,  3 Jul 2025 05:30:28 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-09.internal (MEProxy); Thu, 03 Jul 2025 05:30:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1751535028;
	 x=1751621428; bh=NK7aPe8TovAzBoHdAtKvmiHplZq4alhsiL/cmditjZg=; b=
	PAc2fzCC7jw9eAE0ZVL/34vo0wIob/XtlA6v/NGlZxSA8ZXqQhB+E8QhxuW2jLqv
	8Ea2eupHTMg+Fp/DbtHGSlaljLta1ZstyQ/SbM0wbTvw9r2j7yO4a54ziMCj0e3+
	AOzu7noFg6VEpz3AJE4FJWHktPm3rGpPdEvuP7yBnyhzEkJ8KbV1Kk0w4MRqIROA
	vvFCU+uMlHJJHulvus2upAkrXKg6dji1BsvIWwROMWJf1gIau82eT4r0VetlR9nZ
	Ib2bvv7S+u0B3dxeYatnwkY2YMLzrGq3cxgkP5k9V2GFfmZCMh1g2wQ7C9omfXIU
	Suea/7weiPQpH6pZ7QN4BA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1751535028; x=
	1751621428; bh=NK7aPe8TovAzBoHdAtKvmiHplZq4alhsiL/cmditjZg=; b=e
	k4eY/4FZz4UBNOpjZs9Mbsp24W+rAaocSq5c3J1iETSB/B2/EbYr9R2IM6NRs4Cq
	miPPlE2wR9y+HXyXXzQ+K3fHZQNKv6KWMhFR+/fSX4027W4+Tt1yG5+UuWR3sdKl
	cxv8F1127OfHjRJH7Cu/W9SZhlcNYLWswWH+i/y7WkHbq6jHJkBr6ML7HdYzh8sx
	tQmi0XfS4w4ZN10igsa1Of1L9iZPBCgGUbQ/qEE7PBgYJr3nzzAArTXllhkY38XH
	xcAOGEw3V7xtsp32s+GztZ2fFAeDsoY5pczWWvP8WD8Dk2Kj6lej4etwP5twiF9R
	x4MnPes9MtJUkrnTWMh0A==
X-ME-Sender: <xms:s01maKYurJheOwsOpAFeJG5WhY7rCyZJYhipNz4JQf6bt1PQ2VDrXQ>
    <xme:s01maNYcN_DCRpPnZa_9L1QVRZ9CWYvVsTO6MZHsySQEHiJZhZxoCubXb7WPtkuvL
    WeAYXLo7ymndP8vug>
X-ME-Received: <xmr:s01maE_jB-zgQ2fxrt7iduo5jdzhZjjSZTEWHE29S-b22u7mDoOB2igjgwfZfO-WCAwZzmYUns98ntJGZklwEL0bLs6E9HzyWqH8adcNxA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdduleelvdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhfffugggtgffkfhgjvfevofesthejredtredtjeenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epffeuiedujedvkeehuedvkeefffeivdeuleetkeduheejteekgedvudfgtdfgieelnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimhdpnhgspghrtghpthhtohepgedpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehrrghmshgrhi
    esrhgrmhhsrgihjhhonhgvshdrphhluhhsrdgtohhmpdhrtghpthhtohepihhrvggttggr
    rdhkuhhnsehgmhgrihhlrdgtohhmpdhrtghpthhtohepvghstghhfigrrhhtiiesghgvnh
    htohhordhorhhg
X-ME-Proxy: <xmx:s01maMouTOl_VOD4X895KoFSYGuhj8NNsP35jFToDWr2j4bG6sDlfg>
    <xmx:s01maFos9VF7_TLp09M086Ta1CrmAXKWMI7O97Rq0X3H7wCE659FTg>
    <xmx:s01maKRaG5tiHdvNKLyiVf8RhnERRFckZxeDjVT8K8izj3flUi5v9A>
    <xmx:s01maFqB4tfkKBIFaTL-zTc4I52Vf5cjIO8vtUFyB0k84gvXbweCUg>
    <xmx:s01maJ0Lkyx-LxRtU1bk-AzOINK6IYf-FNDyUODL1ZU-bSQSaiH1q5FB>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 3 Jul 2025 05:30:26 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id c81ace71 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Thu, 3 Jul 2025 09:30:26 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Thu, 03 Jul 2025 11:28:47 +0200
Subject: [PATCH 5/8] meson: fix lookup of shell on MINGW64
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250703-b4-pks-meson-cleanups-v1-5-2804c2932abe@pks.im>
References: <20250703-b4-pks-meson-cleanups-v1-0-2804c2932abe@pks.im>
In-Reply-To: <20250703-b4-pks-meson-cleanups-v1-0-2804c2932abe@pks.im>
To: git@vger.kernel.org
Cc: Ramsay Jones <ramsay@ramsayjones.plus.com>, irecca.kun@gmail.com, 
 Eli Schwartz <eschwartz@gentoo.org>
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

