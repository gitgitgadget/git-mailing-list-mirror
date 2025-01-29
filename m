Received: from fout-a8-smtp.messagingengine.com (fout-a8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA4F719924E
	for <git@vger.kernel.org>; Wed, 29 Jan 2025 07:12:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738134733; cv=none; b=aYSoH6pVeAu4NOvNTD/f2tRDvRY2wGhEQzUgfOmVOW8lbk2EPSNYCLfmQixrXUiQ1wBzBma6lApaDrjcLV4vRr8Oj7z4UHAJ736hwVyGUymciAHKBZYLVDV3Wz25R5w/fQZKoNqV28nHMV1xu9e65bvVnLaQsHmyLKpOj0LUgKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738134733; c=relaxed/simple;
	bh=2wzW2SOxtAF9Bj3c+5WMGjh0oQCv3wYTEYSrE4YY1vk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=GgCQG646kyePLfT0pIGYx0zU7gqaUkrSR2l8kho+NF8rUlngzb7ETcN50Nf+awtuhKwGfjIjWThGghumqAp9WcFzuzr4fyXWCeowaAdoTRz2gy0eXPyLkfglAQvzUMBoulgSFPGwDetJmj1Q+v/kCdyQZ5tdPZHW4YkhJlprFrQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Vyv0sgDv; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=hzHuq5Ns; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Vyv0sgDv";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="hzHuq5Ns"
Received: from phl-compute-09.internal (phl-compute-09.phl.internal [10.202.2.49])
	by mailfout.phl.internal (Postfix) with ESMTP id 1AEB113801EB
	for <git@vger.kernel.org>; Wed, 29 Jan 2025 02:12:10 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-09.internal (MEProxy); Wed, 29 Jan 2025 02:12:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1738134730;
	 x=1738221130; bh=cHBnwmwb+7jilz3It8Nb8rup6RIBrEYaeBU8qlpTQ2A=; b=
	Vyv0sgDvdWQYm94PdmaD1Nm4MGP5ESHFG00PWPB3Hk0H4KcF5Deu3j5t405w+B/8
	F3ZZ9Ew6/dXl5+On8HQqc4QIYC8LOtYBfosOy/5TsdjsbOlsLU+GdEbGlU/JM+tB
	m6lUcDZBBZ0Xr0q3gE7HMW2PRqumXhny4DUM3WTGn8czSTzkde2aWkvxcyw0bF1V
	ms9CjFz7AS5GL4RO+8WIRrlQS6mSGvdE95ZW8JNQCfF+JEJlwzuvlWELf5RVRHKt
	aqmLu7XrS4PbSuayVZU/lFab4vyKhUscdNqcyCD4A1MMBWJqGzZQWIC/3tihgi26
	jVgHc29tGxNNqyH40hPFDA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1738134730; x=
	1738221130; bh=cHBnwmwb+7jilz3It8Nb8rup6RIBrEYaeBU8qlpTQ2A=; b=h
	zHuq5NsUkBfYZf3vySUUnnlYoBS820Celbx1yilYxe4vp2GuGruO10OUL+jrrDqR
	zUEoHOdNzMu65TcS9n2GXgJPTHivuQAMdWRcIvec4gihG27/IYroz2QlkiessIbt
	8HYlyinGgG36rTQsQTv3Ebs0jXNjwq6e8+QVZTBpIp0Vw77e29AYse0FXDPAP3fL
	ABZRxgQPxjACT+YyidQn12fJRJ7PfVYCfMuOpigkC4kCmenuPYjWCvkLPK3LNILA
	/Rv0zfBpAsTw/rT8r7kN4yCKSQOzdGcXEN6wktsvkp2iC+pYu4CLqNI7S0Mm7JD+
	6S13ejlx70Wbky4aVtbdQ==
X-ME-Sender: <xms:ydSZZ-cu3xelC9EaxrVPW34w6xjyLrNYbv9HnYHtFf4jE3kGy-v-Ng>
    <xme:ydSZZ4OeFIXFMLDeFQGta4537JulMHzr4FSUde6Lk91_1MLE5rEVJS4BR73QkgxWY
    C_o7RB0h5_3MyykQg>
X-ME-Received: <xmr:ydSZZ_iHVeKPX33WfT2odQ7sLKJBaQYkA5Gqp4UneSqVUIWbdqiva50zgJ2cgGrHNdiSeBDA_GOhPgQ_O7fElyT5Ai6Rq0T_IwMFI2aXUV0k5fL8Iw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvfeeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpefhfffugg
    gtgffkfhgjvfevofesthejredtredtjeenucfhrhhomheprfgrthhrihgtkhcuufhtvghi
    nhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnhepffeuieduje
    dvkeehuedvkeefffeivdeuleetkeduheejteekgedvudfgtdfgieelnecuvehluhhsthgv
    rhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnh
    gspghrtghpthhtohepuddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithes
    vhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:ydSZZ78gF-RVFlUM3XASt0MmAplsBCBBRruJPe2YfIqMbf-38QHgHg>
    <xmx:ydSZZ6tPnPPU6zcOqwELO9Jvc0fGuRgcYjVfcpF8FvKHFmjLDypDAg>
    <xmx:ydSZZyEqrGWzhwMuMiKb0QwopYfTyJz-9vG4tGc8v4qtH0l5B5E-iQ>
    <xmx:ydSZZ5MnMd8J5J1dO2LC6OVeW3gIUxE-OkCrog3SfEVZmKxyTjfyRg>
    <xmx:ytSZZ_XkQzw7aQ4Uwqk7WkEi6pSW53pGIy1WkbQDS6HDQkphPnVKuJkk>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Wed, 29 Jan 2025 02:12:09 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id d1002598 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Wed, 29 Jan 2025 07:12:08 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Wed, 29 Jan 2025 08:11:59 +0100
Subject: [PATCH 06/11] meson: drop separate version library
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250129-b4-pks-meson-improvements-v1-6-ab709f0be12c@pks.im>
References: <20250129-b4-pks-meson-improvements-v1-0-ab709f0be12c@pks.im>
In-Reply-To: <20250129-b4-pks-meson-improvements-v1-0-ab709f0be12c@pks.im>
To: git@vger.kernel.org
Cc: 
X-Mailer: b4 0.14.2

When building `libgit.a` we link it against a `libgit_version.a` library
that contains the version information that we inject at build time. The
intent of this is to avoid rebuilding all of `libgit.a` whenever the
version changes. But that wouldn't happen in the first place, as we know
to just rebuild the files that depend on the generated "version-def.h"
file.

This is an artifact of an earlier version of the Meson build infra that
didn't ultimately land. We didn't yet have "version-def.h", and instead
injected the version via preprocessor directives. And here we would have
rebuilt all of `libgit.a` indeed in case the version changes, because
the preprocessor directive applied to all files.

Stop building the separate library and instead add "version-def.h" to
the list of source files directly.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 meson.build | 21 +++++----------------
 1 file changed, 5 insertions(+), 16 deletions(-)

diff --git a/meson.build b/meson.build
index e022235815..1e1e478d17 100644
--- a/meson.build
+++ b/meson.build
@@ -462,6 +462,7 @@ libgit_sources = [
   'userdiff.c',
   'utf8.c',
   'varint.c',
+  'version.c',
   'versioncmp.c',
   'walker.c',
   'wildmatch.c',
@@ -1505,26 +1506,14 @@ version_def_h = custom_target(
   depends: [git_version_file],
   env: version_gen_environment,
 )
-
-# Build a separate library for "version.c" so that we do not have to rebuild
-# everything when the current Git commit changes.
-libgit_version_library = static_library('git-version',
-  sources: [
-    'version.c',
-    version_def_h,
-  ],
-  c_args: libgit_c_args + [
-    '-DGIT_VERSION_H="' + version_def_h.full_path() + '"',
-  ],
-  dependencies: libgit_dependencies,
-  include_directories: libgit_include_directories,
-)
+libgit_sources += version_def_h
 
 libgit = declare_dependency(
   link_with: static_library('git',
     sources: libgit_sources,
-    c_args: libgit_c_args,
-    link_with: libgit_version_library,
+    c_args: libgit_c_args + [
+      '-DGIT_VERSION_H="' + version_def_h.full_path() + '"',
+    ],
     dependencies: libgit_dependencies,
     include_directories: libgit_include_directories,
   ),

-- 
2.48.1.362.g079036d154.dirty

