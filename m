Received: from fhigh-a1-smtp.messagingengine.com (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C36FE258CC0
	for <git@vger.kernel.org>; Wed, 26 Feb 2025 08:22:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740558151; cv=none; b=J6sFhU0axTfujIYJE00/l58yZEttj3fQoArnYCxNYD5h5+cmXHrKT6O5btWgxBWW+jlVxMg3K+v8mPyC4yM8PQT4rMKXorC58sW4RokHgXE7NacYKvC4DFSHF4rpLGhhkSMMvVhXIb90JYMdEsOZDoN1uMdtiTeCX9+WG316a88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740558151; c=relaxed/simple;
	bh=U+zj3IS0h8kcyi3yyqg4nU8QUgo1dgK+2uh1XcD1LTY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=DoOc2ihJ8IVa65yo5szwCzLmHirLs1X3JHtODTFNKdD3rxfg7Mgq16f44CDDI6UGBX3pRCgSky0JSb95doMSlcutgyU9Vy52OP8j8d8Ew5JlPEFWoB3iM2b7Ydh0JvfDeaJQTAgYoVVocBk0820ptV8JmhuGdfauhCNkIdT5lIc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=oXMv+hps; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=mS+tD+yA; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="oXMv+hps";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="mS+tD+yA"
Received: from phl-compute-09.internal (phl-compute-09.phl.internal [10.202.2.49])
	by mailfhigh.phl.internal (Postfix) with ESMTP id E3C3A1140172;
	Wed, 26 Feb 2025 03:22:27 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-09.internal (MEProxy); Wed, 26 Feb 2025 03:22:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1740558147;
	 x=1740644547; bh=aoypmvh3stjWKVbFyYJJqj7s1rc0fNfY1j1/BpgrUkY=; b=
	oXMv+hpsGE9PRMJNRHOvp1t//puQXv7T3nbGw7cGbWUDgzIZp+19qXOeRSgjJPGW
	OMSNg6+pe6BKXY1KZKJ0NMA8VdajaM+dZjOI+GySdVBpu3QfMnhXczvJ80PTEHva
	3fsfyUHdlvb2y+IywxzrWo0NgWsxHarG3PQeD/jnDMx3+QeAQMF95tbg/7E4Iyht
	SmzaE8US89qTjvmVFoNyTn2JQlfGQSxyrz5Q9wSQqwKRWBUfpRpVj6wwyKDl8o2o
	jcU+YKCZiNQYSPO13WNOxhEwRIyrn/W+DcqHCyKatsPqWgThnb+nDAA1sp/9tAcn
	wkhHtbQESRn1gG9MjJq35Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1740558147; x=
	1740644547; bh=aoypmvh3stjWKVbFyYJJqj7s1rc0fNfY1j1/BpgrUkY=; b=m
	S+tD+yANTIjINs7oFZHbNFSkIHSxL8J2RkzPT1uKOhrNIHTm5F9M8HRPM/Ccrld5
	SwtBWWEkquXqmUnxfMwU+OsPajV79VIklVnvjOxkVzQlWi5Ljigr8Y28jAaFAovZ
	TUBpYv/s4nhEaYOfYCZ7o3/bqffka9DTIj1mnutWpz+i0X3iO1ORMJLKJlFOJMQV
	Gs5FSmAGy9yX5n5dsP+UhW1vVyRGXPsnw1C6sOSQVRZ9z3O2L6/TQ8EsodIFuCTp
	IE0LxIof+mlXLfEMpiNVGOL96PCn4qyo+en0Y0TqB5SA8Zjq1lV5Sm85CsU/srvv
	23fOTR/1NEcgutVmOaOjQ==
X-ME-Sender: <xms:Q8--Z8mL0y1rrW2sJ0wx1RvxillhAfxlTx_uMqDfqwrgDG9vVezZjg>
    <xme:Q8--Z7026wUgzp6w75DReDkM06lhJyNNA7VTjtVEhWDxAykHQamjPvJcNdjN67i_g
    HlNtNuuxQRPK8LI0A>
X-ME-Received: <xmr:Q8--Z6p08Cv67PBAo0TMQQcom5iAmXTYte2rH27pfJQt7Ms3DJnj2l5AvJtWjkUg8o_uwgsHrCmXSWNMi0onG_5jZAwnCnf1vnmVjlg2N_EUuPlq>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdekgedtlecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhfffugggtgffkfhgjvfevofesthejredtredt
    jeenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrd
    himheqnecuggftrfgrthhtvghrnhepffeuiedujedvkeehuedvkeefffeivdeuleetkedu
    heejteekgedvudfgtdfgieelnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpe
    hmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepgedpmhhouggv
    pehsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
    dprhgtphhtthhopehjlhhtohgslhgvrhesghhmrghilhdrtghomhdprhgtphhtthhopeht
    ohhonhesihhothgtlhdrtghomhdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrd
    gtohhm
X-ME-Proxy: <xmx:Q8--Z4nUzfs4oenwJ7qVh24euy5B-HKI9-t9WP0gaBLfVy0pBJAZ_g>
    <xmx:Q8--Z61YJhydO_jfE2J2LX1F828GUFx0Gj2EtTzf5gMAD_G-ggL1iA>
    <xmx:Q8--Z_vLYbYobefX4FUf6Qqpt0_kNHQO3WJrlrItTpe3eTg5PHzN2g>
    <xmx:Q8--Z2Xt6Kz8xm1Ob0eAdeXLaJeqv0FY4n8l_QslxO9GXeJggRek5Q>
    <xmx:Q8--Z9TjAlW_RvE47h7lNMAjsaAipXGEELwiWjcHVlLRR6nROWodzKtu>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 26 Feb 2025 03:22:26 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id dae1bc92 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 26 Feb 2025 08:22:25 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Wed, 26 Feb 2025 09:22:17 +0100
Subject: [PATCH v3 07/13] meson: drop separate version library
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250226-b4-pks-meson-improvements-v3-7-60c77cf673ae@pks.im>
References: <20250226-b4-pks-meson-improvements-v3-0-60c77cf673ae@pks.im>
In-Reply-To: <20250226-b4-pks-meson-improvements-v3-0-60c77cf673ae@pks.im>
To: git@vger.kernel.org
Cc: Justin Tobler <jltobler@gmail.com>, Toon Claes <toon@iotcl.com>, 
 Junio C Hamano <gitster@pobox.com>
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
index 39d15ee6cb8..c8df19804ae 100644
--- a/meson.build
+++ b/meson.build
@@ -478,6 +478,7 @@ libgit_sources = [
   'userdiff.c',
   'utf8.c',
   'varint.c',
+  'version.c',
   'versioncmp.c',
   'walker.c',
   'wildmatch.c',
@@ -1542,26 +1543,14 @@ version_def_h = custom_target(
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
2.48.1.741.g8a9f3a5cdc.dirty

