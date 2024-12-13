Received: from fout-b5-smtp.messagingengine.com (fout-b5-smtp.messagingengine.com [202.12.124.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E04EE19992D
	for <git@vger.kernel.org>; Fri, 13 Dec 2024 08:49:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734079748; cv=none; b=MSsyaof32z+321ZgLk+lWBXjz+KKlS0exbuez+/i3fSFIFZGWye3tw7dCHt+YnOR7raMGnkbJQjAdMji9mc5nHzkNlHwL41oNAxE44V74dTqRq1hlsOWAkCCNK0R+aZA40PMa7xr4t4OHAz3CeqoUPOcBW14tOmk6qxa9y4Ln+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734079748; c=relaxed/simple;
	bh=mTXQNuyCoaoYsu+I/kFkOYn3x5LXLQZOO//xcwGTb2Q=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=cmCogqB1zrF/L5lT0zj0XSswY8iwxP3hynK5SbbHXxlS8kJmyCZEM7FxPRCy76uhRXEKJWruweUp2E3pkEVc+azIYW7dlyzJyOR3a/SpfoVBXfGW5J3z/EEN9QKSGoXdAaJYcwyG8H5I08DtSJtE4vCxtRIl7DBstlEdIG0dQUA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=GfWOlAMg; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=slTFBJqK; arc=none smtp.client-ip=202.12.124.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="GfWOlAMg";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="slTFBJqK"
Received: from phl-compute-12.internal (phl-compute-12.phl.internal [10.202.2.52])
	by mailfout.stl.internal (Postfix) with ESMTP id 9D82A1140202
	for <git@vger.kernel.org>; Fri, 13 Dec 2024 03:49:05 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-12.internal (MEProxy); Fri, 13 Dec 2024 03:49:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1734079745;
	 x=1734166145; bh=TxknLB0VlFXLKmia6MGrj/PX6qVQiPOAhyCvN6KSlUA=; b=
	GfWOlAMgLV6vYB66StqJQEgJt3ifmaCD5gYD5WclkQHDEyLj1wJC2HOnqAwdEqx6
	GY1cLi/QDHEcS+Qme3WIO0xp0EPiOdVdyOOXsfl/xdu6zGnPusEpxho3RSuPi2eY
	HlUzCGswy/RvWFEMQPqM3S+JbRppH+7rYfMdZZ/ztHsoslXbyLliYAMscVg6mjwZ
	MmQL1S1BZqfaIg4wMVsGKFkPMXyTA8/t40bOCJnqPi0tpNeqW+YVE6JrmiJzhqk8
	S1DZ8zdIdFgfZeboaDSI0Fn6n+aVq/M6kiLDPj1gTXY0Ao6FaJUzt60OMVW6u5C6
	x7k46H1x5l/60zJHNaY7IA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1734079745; x=
	1734166145; bh=TxknLB0VlFXLKmia6MGrj/PX6qVQiPOAhyCvN6KSlUA=; b=s
	lTFBJqKipxXjPhyyjvWRF+fiFunRt6LLoAvAJSp4m0dYGrImwI9bcCWjePVYzHq8
	q6m/+mWkJFCX+OXt7pEA23SKVs+MFyFwDJ62wHHv/7oVrImG7Lry1QK3/jqIJYae
	N/6kC0CJk+z+PfH2bYAQS2ceW+l+caAA3sH48EFPreCvuYNZka8zur6UulPcVsps
	/hIf56ZAos5sh4NDmQO0SYJK6hNW+FoDNXE+MrPCceNbNkq0jhXeXbblzhqi9jO+
	w8DYrvl8+6HSkk1ha7Xe84CGJTFnYDXpipUw0I6yORgKguhUDd/Uekj8yHYiIcoM
	eZOSDO+791glxVXduEKng==
X-ME-Sender: <xms:AfVbZ9Qwkk2GcDzsxHRHmFqdV0RGiPCuuw-knk_BC0Hi_5tJycXljw>
    <xme:AfVbZ2xeg4L_GaVDJTBMrqR3ogSjCn-KFrIvCQxrblfhcvKuA9LNlFXpXhnRi2QCI
    7JhdlL-ttCwKQ5JkQ>
X-ME-Received: <xmr:AfVbZy2UtEMnYF8Tq_iPWEbGERxFBKcN1FUyfARgfjonnBBkYBjjgeTpEwd9fTGi2bcykS6bfTjBS02iBdULBKw160aBz0x0DCEEvoqL8-HpgGQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrkeeigdduvdefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucgovfgvgihtqfhnlhihqd
    dqteefjeefqddtgeculdehtddmnecujfgurhephfffufggtgfgkfhfjgfvvefosehtjeer
    tdertdejnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesph
    hkshdrihhmqeenucggtffrrghtthgvrhhnpeeffeeliedvteehgfduheeuffehieehheej
    vdehkeelgefftdffveeileduieetkeenucffohhmrghinheptghonhhfrdhinhdprhgsrd
    hinhenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehp
    shesphhkshdrihhmpdhnsggprhgtphhtthhopedupdhmohguvgepshhmthhpohhuthdprh
    gtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:AfVbZ1DxYvV_XLMKF_XEkxrZus8rhSg8F79N1rIqarzS433zBtdOFQ>
    <xmx:AfVbZ2hj8nEh9JPysYLw5TfK4tzzDdPoVFc7n2ByN9ROnBzwpljWpA>
    <xmx:AfVbZ5pfSp4Y-XKjlV5MR9NmREChPuBMfA3_uYB3kxGlLhauul4KOw>
    <xmx:AfVbZxiiJFis2kPM2BYQr_R0L2nhxwbKSmaeX41WCyuSeQ34De2r3A>
    <xmx:AfVbZ6bWiMGUwlWgvzep3yUOKTS0sB5SfH4gq14ndo51DgsZd1TJeHDb>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Fri, 13 Dec 2024 03:49:04 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id a89201e1 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Fri, 13 Dec 2024 08:47:22 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Fri, 13 Dec 2024 09:48:30 +0100
Subject: [PATCH 01/10] meson: wire up support for AsciiDoctor
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241213-b4-pks-meson-docs-v1-1-0c7895952cd3@pks.im>
References: <20241213-b4-pks-meson-docs-v1-0-0c7895952cd3@pks.im>
In-Reply-To: <20241213-b4-pks-meson-docs-v1-0-0c7895952cd3@pks.im>
To: git@vger.kernel.org
Cc: 
X-Mailer: b4 0.14.2

While our Makefile supports both Asciidoc and AsciiDoctor, our Meson
build instructions only support the former. Wire up support for the
latter, as well.

Our Makefile always favors Asciidoc, but Meson will automatically figure
out which of both to use based on whether they are installed or not. To
keep compatibility with our Makefile it favors Asciidoc over Asciidoctor
in case both are available.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 Documentation/meson.build | 107 ++++++++++++++++++++++++++++++++++------------
 meson_options.txt         |   2 +
 2 files changed, 82 insertions(+), 27 deletions(-)

diff --git a/Documentation/meson.build b/Documentation/meson.build
index f2426ccaa30c29bd60b850eb0a9a4ab77c66a629..d62b0846d3f8ebc412f5fa9f775f037a3656093a 100644
--- a/Documentation/meson.build
+++ b/Documentation/meson.build
@@ -204,28 +204,85 @@ manpages = {
   'gitworkflows.txt' : 7,
 }
 
-asciidoc = find_program('asciidoc')
-git = find_program('git', required: false)
-xmlto = find_program('xmlto')
+docs_backend = get_option('docs_backend')
+if docs_backend == 'auto'
+  if find_program('asciidoc', required: false).found()
+    docs_backend = 'asciidoc'
+  elif find_program('asciidoctor', required: false).found()
+    docs_backend = 'asciidoctor'
+  else
+    error('Neither asciidoc nor asciidoctor were found.')
+  endif
+endif
 
-asciidoc_conf = custom_target(
-  command: [
-    shell,
-    meson.project_source_root() / 'GIT-VERSION-GEN',
-    meson.project_source_root(),
-    '@INPUT@',
-    '@OUTPUT@',
-  ],
-  input: meson.current_source_dir() / 'asciidoc.conf.in',
-  output: 'asciidoc.conf',
-  depends: [git_version_file],
-)
+if docs_backend == 'asciidoc'
+  asciidoc = find_program('asciidoc', required: true)
+  asciidoc_html = 'xhtml11'
+  asciidoc_docbook = 'docbook'
+  xmlto_extra = [ ]
 
-asciidoc_common_options = [
-  asciidoc,
-  '--conf-file=' + asciidoc_conf.full_path(),
-  '--attribute=build_dir=' + meson.current_build_dir(),
-]
+  asciidoc_conf = custom_target(
+    command: [
+      shell,
+      meson.project_source_root() / 'GIT-VERSION-GEN',
+      meson.project_source_root(),
+      '@INPUT@',
+      '@OUTPUT@',
+    ],
+    input: meson.current_source_dir() / 'asciidoc.conf.in',
+    output: 'asciidoc.conf',
+    depends: [git_version_file],
+  )
+
+  asciidoc_common_options = [
+    asciidoc,
+    '--conf-file=' + asciidoc_conf.full_path(),
+    '--attribute=build_dir=' + meson.current_build_dir(),
+  ]
+
+  documentation_deps = [
+    asciidoc_conf,
+  ]
+elif docs_backend == 'asciidoctor'
+  asciidoctor = find_program('asciidoctor', required: true)
+  asciidoc_html = 'xhtml5'
+  asciidoc_docbook = 'docbook5'
+  xmlto_extra = [
+    '--skip-validation',
+    '-x', meson.current_source_dir() / 'manpage.xsl',
+  ]
+
+  asciidoctor_extensions = custom_target(
+    command: [
+      shell,
+      meson.project_source_root() / 'GIT-VERSION-GEN',
+      meson.project_source_root(),
+      '@INPUT@',
+      '@OUTPUT@',
+    ],
+    input: meson.current_source_dir() / 'asciidoctor-extensions.rb.in',
+    output: 'asciidoctor-extensions.rb',
+    depends: [git_version_file],
+  )
+
+  asciidoc_common_options = [
+    asciidoctor,
+    '--attribute', 'compat-mode',
+    '--attribute', 'tabsize=8',
+    '--attribute', 'litdd=&#x2d;&#x2d;',
+    '--attribute', 'docinfo=shared',
+    '--attribute', 'build_dir=' + meson.current_build_dir(),
+    '--load-path', meson.current_build_dir(),
+    '--require', 'asciidoctor-extensions',
+  ]
+
+  documentation_deps = [
+    asciidoctor_extensions,
+  ]
+endif
+
+git = find_program('git', required: false)
+xmlto = find_program('xmlto')
 
 cmd_lists = [
   'cmds-ancillaryinterrogators.txt',
@@ -242,10 +299,6 @@ cmd_lists = [
   'cmds-foreignscminterface.txt',
 ]
 
-documentation_deps = [
-  asciidoc_conf,
-]
-
 documentation_deps += custom_target(
   command: [
     perl,
@@ -277,7 +330,7 @@ foreach manpage, category : manpages
   if get_option('docs').contains('man')
     manpage_xml_target = custom_target(
       command: asciidoc_common_options + [
-        '--backend=docbook',
+        '--backend=' + asciidoc_docbook,
         '--doctype=manpage',
         '--out-file=@OUTPUT@',
         meson.current_source_dir() / manpage,
@@ -300,7 +353,7 @@ foreach manpage, category : manpages
         manpage_xml_target,
         '-o',
         meson.current_build_dir(),
-      ],
+      ] + xmlto_extra,
       output: manpage_path,
       install: true,
       install_dir: get_option('mandir') / 'man' + category.to_string(),
@@ -310,7 +363,7 @@ foreach manpage, category : manpages
   if get_option('docs').contains('html') and category == 1
     custom_target(
       command: asciidoc_common_options + [
-        '--backend=xhtml11',
+        '--backend=' + asciidoc_html,
         '--doctype=manpage',
         '--out-file=@OUTPUT@',
         meson.current_source_dir() / manpage,
diff --git a/meson_options.txt b/meson_options.txt
index 32a72139bae870745d9131cc9086a4594826be91..0d8ba28de6da7d0ed2ac4bdef7efa967509ec898 100644
--- a/meson_options.txt
+++ b/meson_options.txt
@@ -73,6 +73,8 @@ option('docs', type: 'array', choices: ['man', 'html'], value: [],
   description: 'Which documenattion formats to build and install.')
 option('default_help_format', type: 'combo', choices: ['man', 'html'], value: 'man',
   description: 'Default format used when executing git-help(1).')
+option('docs_backend', type: 'combo', choices: ['asciidoc', 'asciidoctor', 'auto'], value: 'auto',
+  description: 'Which backend to use to generate documentation.')
 
 # Testing.
 option('tests', type: 'boolean', value: true,

-- 
2.47.1.668.gf74b3f243a.dirty

