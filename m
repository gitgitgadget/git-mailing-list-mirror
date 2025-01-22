Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCC00212D68
	for <git@vger.kernel.org>; Wed, 22 Jan 2025 12:05:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737547557; cv=none; b=VFuzr6sIXfik9amfzK8rgADg2Nc9L4x1AQ9i4QaFKO5cD3km9nbRqRvLpp1SSJTv3v99/Mp6QE0wt+P+8HYb969DOSq0F1WbseZ4CsKrQIEh24BfwO865KH8I+Dj2jEatyArr+71/Qfi43sV135DEBx/XbssXRf7Y1xNhpzPmiA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737547557; c=relaxed/simple;
	bh=UBFTHgn1IOr8SWTf+6qljlNV9IbsMwPcISTxkLd98M8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=USW5m8LeBssGeC190FsO7P/3gLZkQ7zEZFJrr1MrI+/XgEy9/T1I0fZHkyYFdyrKXky8YFkkEy9qeBgP3uncfLQZQNYO0IO1gL5eiOq/0G1hjuvWpvmXs0tpRLb3qj3VPp0G4mzaLOlLuXXZvO6DSslSzq/oBrdYoRzA0PUCj5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=RgEgMTFP; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=tAa5kAkb; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="RgEgMTFP";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="tAa5kAkb"
Received: from phl-compute-08.internal (phl-compute-08.phl.internal [10.202.2.48])
	by mailfhigh.phl.internal (Postfix) with ESMTP id CADDA11400B4;
	Wed, 22 Jan 2025 07:05:54 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-08.internal (MEProxy); Wed, 22 Jan 2025 07:05:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1737547554;
	 x=1737633954; bh=i4fZHWMKJFnfwetqkkLFeLMM1jDSTxDt4+6zS29l0jU=; b=
	RgEgMTFPfOpaD20FaDNlZP/5X8H17Cwi25471ED3xp2d31ihCo7s07GfOiy24G7M
	54+B/RWK5YdeEmunGZcN+d0dmfHTJOPKHmOJ8q0T22wgq/Gu4nVKPgi2251CVp0d
	/DgwfV2y49SFHIDj9Od+k5o1dMqCKj7ZxKWc/HTgzly0z5AbVp2Oqv045LGDOpDX
	F0ZB9aLJEfMW0xfXhzdamHW/ypJfeLZXIZS3o57rvDWwStn/LNQ27Os/b2RprdDH
	MYvfJJsQ5hE1HWcCTgGybuN123ZgoZmdTu87kmCeXOwL7Ig6XjJag0CUkjjGYxF0
	iM5WMUKHaVpaj0y0c7y+AA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1737547554; x=
	1737633954; bh=i4fZHWMKJFnfwetqkkLFeLMM1jDSTxDt4+6zS29l0jU=; b=t
	Aa5kAkbCPNnrgnyzutenUa4HGGzwTIEwnz5VPsuJw7nqIYhBuYy2QlXiKChP0+iJ
	/lDwObgIUS02TFeqZfJ6GmJLnuO2OLbTGTFZbDSPqD0JmeHOeuY5nzHy0vXTv2Hp
	B1Lohd48M+p4OgpmFjB7PXyvlkk087IslKjyHfdmtYzC9a6i2d71098EjvUrpmhg
	5msyAYaI1tMFhluiL+4i/Dy4C7B+qWNKhSRTaOy2l0t7/yRIDQ4i+B6B9wvuf+i9
	AFS5WKEPyeGaB+2F3EZKqzETcTceMq4s8IQTXDbIvH0yCZW02iipboyJHrOMDPB7
	OcsmWbkuEOmNiL4y+1VJw==
X-ME-Sender: <xms:It-QZ0_SNBBL-5-j_De9GwhMIRzpJcMB0dC7wFzxZXnrdwYCIHCsMw>
    <xme:It-QZ8uhOgZ-FGsJGpGKZNPlissYeVycSGJ6tdpj4pHP8SI1ZsVQ-hWjIlBujoQUo
    qZazHDAW9Me0ip4YA>
X-ME-Received: <xmr:It-QZ6Cd13x29ctJn3i4UfEP0KUdjYi9cQboB5Xzq3BMe7Nj4lqOx1aCg6pPbp3cEhShBuRZBpvojdP74pwduzN63yyCUeo_ui5u0HeVur6N7xI>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudejfedgudeiudcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhfffugggtgffkfhgjvfevofesthejredtredt
    jeenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrd
    himheqnecuggftrfgrthhtvghrnhepffeuiedujedvkeehuedvkeefffeivdeuleetkedu
    heejteekgedvudfgtdfgieelnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpe
    hmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepiedpmhhouggv
    pehsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
    dprhgtphhtthhopegvshgthhifrghrthiisehgvghnthhoohdrohhrghdprhgtphhtthho
    pegvvhgrnhdrmhgrrhhtihhnsehgmhgrihhlrdgtohhmpdhrtghpthhtohepthhoohhnse
    hiohhttghlrdgtohhmpdhrtghpthhtohepmhhirhhthhdrhhhitghkfhhorhgusehgmhgr
    ihhlrdgtohhmpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:It-QZ0dJzzMuxeUzNMR1LuAvVk4s74vc2HEyuuUi9ACrmZ2q0Acy8A>
    <xmx:It-QZ5PBz6a9Qg6qhc09YVRItZ2AjnX9pBBPcvvh9__L6UzkWKoC_g>
    <xmx:It-QZ-kZyhw0RBWgjhiYBqVZrfyF6DfZDytKMqgBdf3aZdAVdwtWGg>
    <xmx:It-QZ7vvvTj2o1iFo_FvCzXRcmGZExr7bm0O8oryn8OvcWYdz7Hm3A>
    <xmx:It-QZ1BpRx6KGdcrxq3Sbyw9yH4cg2muawnjcheisZprB3Ffch0ChKxH>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 22 Jan 2025 07:05:53 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id e6d33031 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 22 Jan 2025 12:05:50 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Wed, 22 Jan 2025 13:05:46 +0100
Subject: [PATCH v3 03/11] meson: populate project version via
 GIT-VERSION-GEN
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250122-b4-pks-meson-additions-v3-3-5a51eb5d3dcd@pks.im>
References: <20250122-b4-pks-meson-additions-v3-0-5a51eb5d3dcd@pks.im>
In-Reply-To: <20250122-b4-pks-meson-additions-v3-0-5a51eb5d3dcd@pks.im>
To: git@vger.kernel.org
Cc: Evan Martin <evan.martin@gmail.com>, 
 Eli Schwartz <eschwartz@gentoo.org>, Junio C Hamano <gitster@pobox.com>, 
 M Hickford <mirth.hickford@gmail.com>, Toon Claes <toon@iotcl.com>
X-Mailer: b4 0.14.2

The Git version for Meson is currently wired up manually. It can thus
grow (and already has grown) stale quite easily, as having multiple
sources of truth is never a good idea. This issue is mostly of cosmetic
nature as we don't use the project version anywhere, and instead use the
GIT-VERSION-GEN script to propagate the correct version into our build.
But it is somewhat puzzling when `meson setup` announces to build an old
Git release.

There are a couple of alternatives for how to solve this:

  - We can keep the version undefined, but this makes Meson output
    "undefined" for the version, as well.

  - We can use GIT-VERSION-GEN to generate the version for us. At the
    point of configuring the project we haven't yet figured out host
    details though, and thus we didn't yet set up the shell environment.
    While not an issue for Unix-based systems, this would be an issue in
    Windows, where the shell typically gets provided via Git for Windows
    and thus requires some special setup.

  - We can pull the default version out of GIT-VERSION-GEN and move it
    into its own file. This likely requires some adjustments for scripts
    that bump the version, but allows Meson to read the version from
    that file trivially.

Pick the second option and use GIT-VERSION-GEN as it gives us the most
accurate version. In order to fix the bootstrapping issue on Windows
systems we simply set the version to 'unknown' in case no shell was
found. As the version is only of cosmetic value this isn't really much
of an issue.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 meson.build | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/meson.build b/meson.build
index 7361eb2eaa..213998986e 100644
--- a/meson.build
+++ b/meson.build
@@ -170,7 +170,14 @@
 
 project('git', 'c',
   meson_version: '>=0.61.0',
-  version: 'v2.47.GIT',
+  # The version is only of cosmetic nature, so if we cannot find a shell yet we
+  # simply don't set up a version at all. This may be the case for example on
+  # Windows systems, where we first have to bootstrap the host environment.
+  version: find_program('sh', required: false).found() ? run_command(
+    'GIT-VERSION-GEN', meson.current_source_dir(), '--format=@GIT_VERSION@',
+    capture: true,
+    check: true,
+  ).stdout().strip() : 'unknown',
 )
 
 fs = import('fs')

-- 
2.48.1.321.gbf1f004a4a.dirty

