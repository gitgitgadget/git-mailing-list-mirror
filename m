Received: from fout-b8-smtp.messagingengine.com (fout-b8-smtp.messagingengine.com [202.12.124.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3CDC233D9F
	for <git@vger.kernel.org>; Mon, 13 Jan 2025 08:34:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736757246; cv=none; b=duUzlO3Rfn+jOHdtDg0vXLEMsqvHsPY6Pv8WxM0ejsl0id8yA5F53TElgfgMbQYQLuAbTqWdPnYqD1oQtlTTb6GLsG7xvtJWi7JG6aZ3KkUYN81F2ppNQ8UJnu5O2f82cHw7uo6sgOSGZ8qbOYFoSGLct4l7ELggGAYXIjVhj7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736757246; c=relaxed/simple;
	bh=3YeJFig2P33DViIlP75fmV0deVT8jf7CEZJ/2REuAqE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=kvAEidzWWWuTykSZFWMKG/J6URbzfdI4dEaOEothskh0lpnkwu456aJaXWV9+sEhgJue00YcwVblI8mFTX9aC5qrC0ilcxSfbGeSEZwroGiG/eFXMxvQnbmOGpmr6S0/Jy1y+WMzkDm0n+Vqx5f+Zn+0PHUeLf6C9DudzhuEeb0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=H/K4t595; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=XvucEmyW; arc=none smtp.client-ip=202.12.124.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="H/K4t595";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="XvucEmyW"
Received: from phl-compute-08.internal (phl-compute-08.phl.internal [10.202.2.48])
	by mailfout.stl.internal (Postfix) with ESMTP id 19EE51140146;
	Mon, 13 Jan 2025 03:34:04 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-08.internal (MEProxy); Mon, 13 Jan 2025 03:34:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1736757243;
	 x=1736843643; bh=wxH4C9UoPNS3Ntoc5IWVDbLhRGUV6ASH7dfCEJzBncs=; b=
	H/K4t595iljLCJelGgWOdEALnVYOZim+NHTEXE+/6o8yaAOr2PKjHlPDJY8Ws8YC
	GACghJ1IXoRNlMtszptJgWoGTbRt8SM9l+JzUpYDSFRMWfzAtGS9ZQCQC8+OVgQq
	vM9hLTQjokZ5ig7oT/n5wCdB1brP0ObeQUNeWC6ORBJdbOCBgzz6lMUBnRF4mT0e
	hw73s4g6yMh8AVp0q9RJY8474k9ig0QdT9AfvY4fAbDX8akAONFQk/dF5xTnycKt
	/Jskk/au+NY62QEZCnYzIWWXQO+j1HvhMoPUBZJhnSB7ah0Dy/4VKt5iTyWkvN4+
	/zHDEhK9QeJ84WAwitXOYQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1736757243; x=
	1736843643; bh=wxH4C9UoPNS3Ntoc5IWVDbLhRGUV6ASH7dfCEJzBncs=; b=X
	vucEmyWxTVkjvH9oaBn0sO5EkdDV7rHxyasHRr2GwZzLhEkr+LH+Qd3EDldJeCeO
	rFcYDo91br7Tg0JyvRQDm9UvDmgnZRnyehrtoWsFxIUQMvj8BMFs2izPgovnOp3R
	/oEF8/hzl3uwbCU8CuUMrEONahCNmvRPZ++AGjY13OScL/NQQCKda6NrdWvBpc6h
	CaoJufXzc0E3wgUwbT4A2+Gn1VWHNj5FWOfGp78Ive9hbgwi3tjiFavD7Jp1X/fX
	7LzHumwUjfRXBcWEEmqpGq7ZsUqYX+dreoZk/HFtJoSb6sebhagGy3jFV8fGM97z
	rp/j1f7J1LCzsWLyq22Ww==
X-ME-Sender: <xms:-8-EZ2S2DD7TFIeNJkWW6IM00Nq6Y85OG5KZZRXan3JsnPW8IMnp0A>
    <xme:-8-EZ7ycbfv9BVtcUsub-46erR72pqPerC5FYd-itcH6JZAH5CJ_zxJ3c0ga4NasC
    F-VY0AAmKu3VJ0Meg>
X-ME-Received: <xmr:-8-EZz38LAVmmRYtDeiElpu5SVprB-QmezxNV8_oBxPCNi4QovZ1DKIdRniRMietzYG47vJ2XJNWP2vS5rRZA606vi-1Vpso3cekHwYb_fCtHWkc>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudehfedguddulecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhfffugggtgffkfhgjvfevofesthejredtredt
    jeenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrd
    himheqnecuggftrfgrthhtvghrnhepffeuiedujedvkeehuedvkeefffeivdeuleetkedu
    heejteekgedvudfgtdfgieelnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpe
    hmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepfedpmhhouggv
    pehsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
    dprhgtphhtthhopegvvhgrnhdrmhgrrhhtihhnsehgmhgrihhlrdgtohhmpdhrtghpthht
    ohepvghstghhfigrrhhtiiesghgvnhhtohhordhorhhg
X-ME-Proxy: <xmx:-8-EZyCg5VFxcijCm9a7BR58AEVpBRYCEB1GsKArPMjUkflo0sYLTg>
    <xmx:-8-EZ_ixZcYYC0rKnp73dAIFI-e3YxbEmc33Kr3FzgIcodTEw4p99Q>
    <xmx:-8-EZ-oyuHhlwtldC7_HK6J2ZaMmkgHZXw28kA-DZuImbvcIoL6yVQ>
    <xmx:-8-EZyh7gTKVZEhY8sgTc5tGii4mTwk2u9aKKTl1VCnorw1Bp-Zcig>
    <xmx:-8-EZ8tL2I6cz5J-vQJJJuJQWxegj9m36FP0xc4HAXR4I82tDOSk5C7F>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 13 Jan 2025 03:34:02 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 8736ad66 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 13 Jan 2025 08:34:01 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Mon, 13 Jan 2025 09:33:38 +0100
Subject: [PATCH 5/9] meson: wire up generation of distribution archive
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250113-b4-pks-meson-additions-v1-5-97f6a93f691d@pks.im>
References: <20250113-b4-pks-meson-additions-v1-0-97f6a93f691d@pks.im>
In-Reply-To: <20250113-b4-pks-meson-additions-v1-0-97f6a93f691d@pks.im>
To: git@vger.kernel.org
Cc: Evan Martin <evan.martin@gmail.com>, 
 Eli Schwartz <eschwartz@gentoo.org>
X-Mailer: b4 0.14.2

Meson knows to generate distribution archives via `meson dist`. Despite
generating the archive itself, this target also knows to compile and
execute tests from that archive, which helps to ensure that the result
is an adequate drop-in replacement for the versioned project.

While this already works as-is, one omission is that we don't propagate
the commit that this is built from into the resulting archive. This can
be fixed though by adding a distribution script that propagates the
version into the "version" file, which GIT-VERSION-GEN knows to read if
present.

Use GIT-VERSION-GEN itself to populate that file. There are two smallish
gotchas:

  - The script is executed in the build directory, not in the directory
    where we generate the archive. The target directory is propagated
    via the "MESON_DIST_ROOT" environment variable, but because we don't
    use a shell to execute GIT-VERSION-GEN we cannot populate the envvar
    into its arguments. We thus adapt GIT-VERSION-GEN to handle this for
    us.

  - We use the "GIT-VERSION-FILE.in" template to generate the version,
    which contains a "GIT_VERSION=" prefix that we need to strip after
    reading the "version" file. We could avoid this extra logic if we
    used a template that only had the `@GIT_VERSION@` placeholder, but
    it would require us to add one more template file.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 GIT-VERSION-GEN |  7 ++++++-
 meson.build     | 12 ++++++++++++
 2 files changed, 18 insertions(+), 1 deletion(-)

diff --git a/GIT-VERSION-GEN b/GIT-VERSION-GEN
index 95d7d41d233450774a6580c0de332e7b8f69eb4e..1f0fb4098da392511f02a34cdcc84f3889771001 100755
--- a/GIT-VERSION-GEN
+++ b/GIT-VERSION-GEN
@@ -19,6 +19,11 @@ then
 	exit 1
 fi
 
+if test -n "$OUTPUT" && test -n "$MESON_DIST_ROOT"
+then
+    OUTPUT="$MESON_DIST_ROOT/$OUTPUT"
+fi
+
 DEF_VER=$(cat "$SOURCE_DIR"/GIT-VERSION)
 
 # Protect us from reading Git version information outside of the Git directory
@@ -33,7 +38,7 @@ then
 	# then try git-describe, then default.
 	if test -f "$SOURCE_DIR"/version
 	then
-		VN=$(cat "$SOURCE_DIR"/version) || VN="$DEF_VER"
+		VN=$(cat "$SOURCE_DIR"/version) && VN=${VN#GIT_VERSION=} || VN="$DEF_VER"
 	elif {
 			test -d "$SOURCE_DIR/.git" ||
 			test -d "${GIT_DIR:-.git}" ||
diff --git a/meson.build b/meson.build
index 0b559215e4f105ac87bd580d755f88c32b7b36ca..771bdded484a0c0e8638e7c6555e3f4e09e64025 100644
--- a/meson.build
+++ b/meson.build
@@ -1940,6 +1940,18 @@ devenv.set('GIT_BUILD_DIR', meson.current_build_dir())
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
+  meson.current_source_dir() / 'GIT-VERSION-FILE.in',
+  'version',
+)
+
 summary({
   'curl': curl.found(),
   'expat': expat.found(),

-- 
2.48.0.257.gd3603152ad.dirty

