Received: from fhigh-b8-smtp.messagingengine.com (fhigh-b8-smtp.messagingengine.com [202.12.124.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E77371F4734
	for <git@vger.kernel.org>; Fri, 27 Dec 2024 14:00:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735308003; cv=none; b=oSwaMBpe/lHAM7Kicq3Jo7E9QFFNFk5lmkPMrONMD6VWU5m+16CHDC+MWVKvuLQtF93/Gje1nCUEF1IjljlDsbzQijT4TMOgABjR28qSQUW70SK6xQBl21qTEY+YnvdE1stA87yUYHZ0OkKuRYHTulrS20lJag3atenxz91CClc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735308003; c=relaxed/simple;
	bh=Xky0MIsmSYb9kT1S4ct+k8qmtdizUeYDvHtSBtotcoI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=gUDObcPYJEUdzsWapvrffVrs5Fp8bMWaxuGiasrSgAx9iPdID0kBPQHwTwkOg6V/Afx8bwpWsOM6Zjpy21W2D6IWP2wzeIHd7b96YNxatyF8LVJH9wmCK6rkdsAPHWvr0zq62DLIhW2hysk32WSqC3u9neN1n0W5l8JufdhFQ2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=CApBolm5; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=dY256LWk; arc=none smtp.client-ip=202.12.124.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="CApBolm5";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="dY256LWk"
Received: from phl-compute-11.internal (phl-compute-11.phl.internal [10.202.2.51])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 232EE2540185;
	Fri, 27 Dec 2024 09:00:01 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-11.internal (MEProxy); Fri, 27 Dec 2024 09:00:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1735308000;
	 x=1735394400; bh=jeoeGWhyM+NktE1zo0heZRue3FElxswEzMgp4gw/oQo=; b=
	CApBolm5L39MTocyfWAQ4ZsKz6+4BEorC/zcBq0UTJcofSu+Bry1/PUTYf8jG1qj
	yTYC8asjvRkgKVi1e7n6MDZMirr0D7vEaVFYaIfIfssGz12CyTn8wgKxlFuEnq8u
	pNpFpsvnpUjXCfbW+LPbIheGD7qBkKNxwKYAPkGZa8xXnlk1UKUqBAkfUowuuv6Y
	qd0yz6AOE3a/bGBO1Szs7l7yhPuTS9m2EYJQ+p6mm7RV2f1qXeghq3je8X1V827Q
	o0UkOO9bygI8YeYTPhOWGEpeDTCzyG6iCi3SMRTVBfvyL+k5j4Wu99aSOv88gIYb
	5orlZuLdU1v+R79Ko4qVPQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1735308000; x=
	1735394400; bh=jeoeGWhyM+NktE1zo0heZRue3FElxswEzMgp4gw/oQo=; b=d
	Y256LWkVIUvCVDNBDt3feq19/m7CGtPT9okibe4DLnjD8IA6wDoNDE6ATY7+wN7t
	TGnc8ZbqVWNraZJIXQPdriKdKOAubWmKej40zn+jTp9rrzxSVT8eUJtCj9N4ZJw+
	DV+hR+RsX3QQl1wKPQ9yxtiUy7vfKmujUPol6PYJsAPQf42Jzfmljvr59faF+V5e
	AbyktThCkoRvozjPxS9M2x8C0/p7RV52FS92/xGbiW+s2sRR8XGRiYusm3DrBkZF
	PvkrsXmaDz7C6UP3r2MmNcI0bMIKdRSnwLlfC/8DINw/htGG5i0SFVn8qqyxD1B3
	jiJV1tUOP4GnLQympUJNA==
X-ME-Sender: <xms:4LJuZ4-ikucWmaV7-xAHwFV6EjpnyFM8D3ZepZiE1VdpIqwpY5uvBw>
    <xme:4LJuZwvNRX3CCQiJ-c4SVtqGahZTak_2__ZrX-8oSGqpRa4hM6nB5ITuflDRpWOpf
    0ek8hapfj8sebp1_A>
X-ME-Received: <xmr:4LJuZ-CHdJRcFIwWZ8tL9DmcTj25mFNL_WGVk_qcuOuekPPH8Y5Z2H5yKUdHzNCjG7SGSC3eI7awqH0KaTXPCrqK9QrqE6xbNqywySEOGaAGuw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddruddvtddgheekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdej
    necuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrih
    hmqeenucggtffrrghtthgvrhhnpeeffeeliedvteehgfduheeuffehieehheejvdehkeel
    gefftdffveeileduieetkeenucffohhmrghinheptghonhhfrdhinhdprhgsrdhinhenuc
    evlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhk
    shdrihhmpdhnsggprhgtphhtthhopedvpdhmohguvgepshhmthhpohhuthdprhgtphhtth
    hopehtohhonhesihhothgtlhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgv
    rhhnvghlrdhorhhg
X-ME-Proxy: <xmx:4LJuZ4eGFK_PCkndWDexPGYsm9yWqD3uammQ2FrNvOUq94wUclZRfg>
    <xmx:4LJuZ9NVUk-nqOjN6AD2lbxQjiMj8M6dkBMn8UoIhTBobHOyCnq8gA>
    <xmx:4LJuZym5lFhAp5WnKGR2VK-0SHJllh4t-HUMT98ybqKxCY16bgOTXw>
    <xmx:4LJuZ_s9FwgLR6jFx97w_CSZmyoV5sv-Q7abHXJzpwXLPQdicgFEcA>
    <xmx:4LJuZ2YqNY53ce_u5paGLamZxgQ46AkaJp4daos0NMRUyclIkLRD_l3Y>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 27 Dec 2024 09:00:00 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id f84c8ba6 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 27 Dec 2024 13:57:55 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Fri, 27 Dec 2024 14:59:29 +0100
Subject: [PATCH v2 01/12] meson: wire up support for AsciiDoctor
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241227-b4-pks-meson-docs-v2-1-f61e63edbfa1@pks.im>
References: <20241227-b4-pks-meson-docs-v2-0-f61e63edbfa1@pks.im>
In-Reply-To: <20241227-b4-pks-meson-docs-v2-0-f61e63edbfa1@pks.im>
To: git@vger.kernel.org
Cc: Toon Claes <toon@iotcl.com>
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
 Documentation/meson.build | 110 ++++++++++++++++++++++++++++++++++------------
 meson_options.txt         |   2 +
 2 files changed, 84 insertions(+), 28 deletions(-)

diff --git a/Documentation/meson.build b/Documentation/meson.build
index fca3eab1f1360a5fdeda89c1766ab8cdb3267b89..acd6d86ec779e63230c88b7bff937aff330d2d4f 100644
--- a/Documentation/meson.build
+++ b/Documentation/meson.build
@@ -204,29 +204,87 @@ manpages = {
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
-  env: version_gen_environment,
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
+    env: version_gen_environment,
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
+    env: version_gen_environment,
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
@@ -243,10 +301,6 @@ cmd_lists = [
   'cmds-foreignscminterface.txt',
 ]
 
-documentation_deps = [
-  asciidoc_conf,
-]
-
 documentation_deps += custom_target(
   command: [
     perl,
@@ -278,7 +332,7 @@ foreach manpage, category : manpages
   if get_option('docs').contains('man')
     manpage_xml_target = custom_target(
       command: asciidoc_common_options + [
-        '--backend=docbook',
+        '--backend=' + asciidoc_docbook,
         '--doctype=manpage',
         '--out-file=@OUTPUT@',
         meson.current_source_dir() / manpage,
@@ -301,7 +355,7 @@ foreach manpage, category : manpages
         manpage_xml_target,
         '-o',
         meson.current_build_dir(),
-      ],
+      ] + xmlto_extra,
       output: manpage_path,
       install: true,
       install_dir: get_option('mandir') / 'man' + category.to_string(),
@@ -311,7 +365,7 @@ foreach manpage, category : manpages
   if get_option('docs').contains('html') and category == 1
     custom_target(
       command: asciidoc_common_options + [
-        '--backend=xhtml11',
+        '--backend=' + asciidoc_html,
         '--doctype=manpage',
         '--out-file=@OUTPUT@',
         meson.current_source_dir() / manpage,
diff --git a/meson_options.txt b/meson_options.txt
index 4be7eab39939178ae2ffde1ff9e78f83a1b482b2..f50bb40cdf6046529a0cea0a03a8cb696c3a6b18 100644
--- a/meson_options.txt
+++ b/meson_options.txt
@@ -85,6 +85,8 @@ option('docs', type: 'array', choices: ['man', 'html'], value: [],
   description: 'Which documenattion formats to build and install.')
 option('default_help_format', type: 'combo', choices: ['man', 'html'], value: 'man',
   description: 'Default format used when executing git-help(1).')
+option('docs_backend', type: 'combo', choices: ['asciidoc', 'asciidoctor', 'auto'], value: 'auto',
+  description: 'Which backend to use to generate documentation.')
 
 # Testing.
 option('tests', type: 'boolean', value: true,

-- 
2.48.0.rc0.311.gb6c66824c1.dirty

