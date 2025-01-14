Received: from fout-a4-smtp.messagingengine.com (fout-a4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2ACAD229629
	for <git@vger.kernel.org>; Tue, 14 Jan 2025 11:56:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736855783; cv=none; b=a9kp27Oa5TIz3Yw/y7MiBtEKvPUwntDLUJnFQXrq/w9OLb3xJxEVGNuUOu0P0aQWaEBH5UwGxMpEev759cub/iInz3glLJSsjgozOi/Etto7MQQ5ueJhjyr7MogqwGrWsYluIQz4F9ohRyjsNCaIjB+h3uXKpRl4lBdMJa9cIF0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736855783; c=relaxed/simple;
	bh=hNlRZ5DSrQgBj6xo3lQv+te4RcCfQgl0dZdFkzDhCwA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=A9wb5lIMOWAQFS4eCk18WqF7SGYmq96USpphMUWix2Xr/pRV5gQKRUPOi4zOu5mGvTP0cYhFsmjxmL+No+P622un/NHvIBjaPKyDDfMJ/Pa66jOgojba6v4AOBfZ69Pe/2lnFyOcDbOpxpNDrlduSa2HBuPp5eWvltLFiPv89p8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=vZdQw9GW; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=dQxhutck; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="vZdQw9GW";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="dQxhutck"
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfout.phl.internal (Postfix) with ESMTP id 644751380214;
	Tue, 14 Jan 2025 06:56:21 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Tue, 14 Jan 2025 06:56:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1736855781;
	 x=1736942181; bh=BO0jNhl3ws4p7GWFz1ENpTowbP6Zga+LkLtSypSP6iw=; b=
	vZdQw9GWO+6uTvqMn5WWzIf3v4aJ7tynFOWEafh7cMbEEMWGgJ2dCtC13NJA6H3w
	16ZKuWTdWz7r4gvkXpfVnsgIBL41Q1m2fLYsVjcuoOcZZ0wAtz55aBkeMrrWKjVc
	LtRogMdtjiY1fvFjBlFvXWmqh0CM/PHbfuHnzZGxrL/gOoK3ElOjEInfRQkFb5IU
	XwJO/qyHy48dR5b+3bF1bwwqvzNmlMl5pig5s4G2jPw2pad8W25Dio2KIGnik+65
	PWFa5gHaPWq2V2gvpb1+Mx/6CQcTE+RPIeEPARcxG3pC89XPmskpvOAWCab4Jojv
	ciGwJJSc79Q+chusZEpdzg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1736855781; x=
	1736942181; bh=BO0jNhl3ws4p7GWFz1ENpTowbP6Zga+LkLtSypSP6iw=; b=d
	Qxhutck24Bm5KVNSEZtUSRy21FEM1yI+nez6W9a0neSkiC3r8yUukaXJiU7/qjIn
	H5xAF/M4+6RFwVCVb1iqiyM9iRfrII9By4zb6NCoAQLnRN+K/R5vNsZ1t0L9yWOp
	VoGBtDH83Z8CCC2O4avISBxV30V729fs5clXpOc16+B/iSLZGpR+EX+3IUq7DmIV
	ttWOyTKE7zmRjJvvg26GBHqpI6JqBnMVS0UJjexICE6NkC/sVXQcSNRWFXjfTs/T
	meqwglmWZSTfcMNgEycF0V5cWbEhPX0wY5sPFoygU8+9NoWY5Mgqe7ook6is2WNH
	RTlTTyrE9VQUyYyyV5gjg==
X-ME-Sender: <xms:5VCGZ7m4TgRyrFGolGfNWTuF2EF_rmt_8czAMf5I5fmf4kqQRDaTeA>
    <xme:5VCGZ-34_I_OZ2l4Vu-D0_wVH2AJmU1aXg129Ol7K0VrabO0mA9UsGl_8-Ei5PsUr
    wnS4mU4nyEJkx-Blw>
X-ME-Received: <xmr:5VCGZxpDN465WQs3-N1cFN6YAZuEPRZj46sZqVKCmpQ329NSo3WyTgVdfJySAjQqO3B7dz9-gVDvZzpTtXXavKH4wuEmynFs7SsQdepNZkfHQw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudehiedgfeefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdej
    necuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrih
    hmqeenucggtffrrghtthgvrhhnpeffueeiudejvdekheeuvdekfeffiedvueelteekudeh
    jeetkeegvddugfdtgfeileenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmh
    grihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeehpdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpd
    hrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomhdprhgtphhtthhopegvshgt
    hhifrghrthiisehgvghnthhoohdrohhrghdprhgtphhtthhopehmihhrthhhrdhhihgtkh
    hfohhrugesghhmrghilhdrtghomhdprhgtphhtthhopegvvhgrnhdrmhgrrhhtihhnsehg
    mhgrihhlrdgtohhm
X-ME-Proxy: <xmx:5VCGZzlarOA1fYEGXtaQxKZMmDRrZ9lKncRlcZ-uWM9Ych9GK1I9bA>
    <xmx:5VCGZ51kQVmda2t2NcqoioToVvPkAc8p8ZGFzLoACZtMCg1Y-ut2Ug>
    <xmx:5VCGZyuB3ygn525F5ed9oZI4wsyPJsEEmHmWoIfsvTjUnnQ-w2gQEw>
    <xmx:5VCGZ9UyeAWo7qLXZeHqRnKf2Xr4ZNmNKcYjvejbKbB6g8unJ41X3w>
    <xmx:5VCGZx8GWzg1HSVVYCE_c4RrKWaL599nkBlteCGdAs63lZf5ubXyB0Dk>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 14 Jan 2025 06:56:19 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id eeb6de27 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 14 Jan 2025 11:56:18 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Tue, 14 Jan 2025 12:56:16 +0100
Subject: [PATCH v2 06/11] meson: wire up generation of distribution archive
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250114-b4-pks-meson-additions-v2-6-8d7ec676cfd9@pks.im>
References: <20250114-b4-pks-meson-additions-v2-0-8d7ec676cfd9@pks.im>
In-Reply-To: <20250114-b4-pks-meson-additions-v2-0-8d7ec676cfd9@pks.im>
To: git@vger.kernel.org
Cc: Evan Martin <evan.martin@gmail.com>, 
 Eli Schwartz <eschwartz@gentoo.org>, Junio C Hamano <gitster@pobox.com>, 
 M Hickford <mirth.hickford@gmail.com>
X-Mailer: b4 0.14.2

Meson knows to generate distribution archives via `meson dist`. In
addition to generating the archive itself, this target also knows to
compile and execute tests from that archive, which helps to ensure that
the result is an adequate drop-in replacement for the versioned project.

While this already works as-is, one omission is that we don't propagate
the commit that this is built from into the resulting archive. This can
be fixed though by adding a distribution script that propagates the
version into the "version" file, which GIT-VERSION-GEN knows to read if
present.

Use GIT-VERSION-GEN to populate that file. As the script is executed in
the build directory, not in the directory where we generate the archive,
we have adapt it to honor the "MESON_DIST_ROOT" environment variable.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 GIT-VERSION-GEN |  4 ++++
 meson.build     | 12 ++++++++++++
 2 files changed, 16 insertions(+)

diff --git a/GIT-VERSION-GEN b/GIT-VERSION-GEN
index 9d201a98fd2766911544225c62159cbfe8dff5fe..f6764555ce6fd46ca4ddbaebb3b48809707e60f8 100755
--- a/GIT-VERSION-GEN
+++ b/GIT-VERSION-GEN
@@ -28,6 +28,10 @@ case "$2" in
 esac
 
 OUTPUT="$3"
+if test -n "$OUTPUT" && test -n "$MESON_DIST_ROOT"
+then
+    OUTPUT="$MESON_DIST_ROOT/$OUTPUT"
+fi
 
 # Protect us from reading Git version information outside of the Git directory
 # in case it is not a repository itself, but embedded in an unrelated
diff --git a/meson.build b/meson.build
index ab4f229436d3070de692a24c3a196a79d214b46f..5d074134195e5689d08da5597f0859d9623d014e 100644
--- a/meson.build
+++ b/meson.build
@@ -1947,6 +1947,18 @@ devenv.set('GIT_BUILD_DIR', meson.current_build_dir())
 devenv.prepend('PATH', meson.current_build_dir() / 'bin-wrappers')
 meson.add_devenv(devenv)
 
+# Generate the 'version' file in the distribution tarball. This is used via
+# `meson dist -C <builddir>` to populate the source archive with the Git
+# version that the archive is being generated from. GIT-VERSION-GEN knows to
+# pick up this file.
+meson.add_dist_script(
+  shell,
+  meson.current_source_dir() / 'GIT-VERSION-GEN',
+  meson.current_source_dir(),
+  '--format=@GIT_VERSION@',
+  'version',
+)
+
 summary({
   'curl': curl.found(),
   'expat': expat.found(),

-- 
2.48.0.257.gd3603152ad.dirty

