Received: from fhigh-a1-smtp.messagingengine.com (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C8BB1E1DE6
	for <git@vger.kernel.org>; Wed, 26 Feb 2025 08:22:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740558149; cv=none; b=V3G+Tdh14NJZZwO90wpMdwy9DCjWh8LssjDIx+Kqio5KuR7c4H0lGX3pMMU7+LKBhU4tkYErYhYbTIqEl40ISaVonqhVk3rr3TyYuzggJbrf9slHmlAVrftyVcZlwKaktRQi1bRplBjW2Rg0mpzJqXAZNJG04NA9zzkMyycmE1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740558149; c=relaxed/simple;
	bh=AbFJUDrQ/dMPnNA4WLEF3GVDqYvGgG6SYyorl0MywlQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=EAJNEk/k0jGmRPgNQuimOpRsKW+Ro1JzGk4gzalxwHbpWRBWV4kc+GqjO3yrXAv32NJLrQfJwzDRAGn2GCqNGuVgDNEDKyfZ5uZ814BL/P6OSUYXGk3d6Q6bckuUhbi2JoI1mlwudNfJD9BJu1fwclZEacdc+FelpvZrkpzPhQ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=cz06C+C2; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=djobQ99+; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="cz06C+C2";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="djobQ99+"
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 65241114016D;
	Wed, 26 Feb 2025 03:22:26 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Wed, 26 Feb 2025 03:22:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1740558146;
	 x=1740644546; bh=/jRos6dh9ZOHDsDYhHA+L9CyFlhqcIZPddzM0tu+xsM=; b=
	cz06C+C2KdigIoIC6Pray9LTPqXr/Tcn7tR6wrOZ85F/Z/lYg/t29zhxDnLal1t0
	Et6SKWn2BUM6vQ5/jV81i7RADPMu3dlqGDX+l6SvjIgeZmjLN9wuSzgsCZqDlMqH
	nW9xLExFM0PzH/75grgVr/eG39pb2//AC/D09cYAuQLxJFBtB01so0AwlI+xgR3H
	Gcgn+zNsansnfvHbU8YL+RtlndKcR7NJRLlJpYO77M8gEvfVTD222WR3J7LRrerc
	dk9vpc8oJqEMoDUSKl8eglkZNgSIK8zSkG9ObrC1+IX5mpcguvakM4ohumvIfLH3
	oH3YyTnIRZatr8emIuye7w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1740558146; x=
	1740644546; bh=/jRos6dh9ZOHDsDYhHA+L9CyFlhqcIZPddzM0tu+xsM=; b=d
	jobQ99+iMvQZ4ZvsU1VEIhn7+I1f6Gs4W8h2+MVM2b2T6YtNtoJIutzAUMNjs5VQ
	30mcZBQtQy9dVPEywUyED9jrGaxVNyTrqcKKT+pdOJkGQ9wf1WmxzDJF6x4fxhQN
	RvIvhxT8YYq8uAoaZvXRlM63YVMM76IKYIQJsogj5iDn5ztHi3mDwx7MtQnRpGxW
	MyGynvqCqKCm3yEupVxDwn+I3CmcqTO9rzhju2rCMBkL55a+10LC+sYeADJhdg3Z
	OUBlyrN+iSkqpQ27bxOtdaDo70z27nJMde97bVabK6YihCUugJy1j8zTtOZyg0CW
	tACSYOjqNw3UPsyTIqqnQ==
X-ME-Sender: <xms:Qs--Z7anlWvmcrmHZFh45MmqqjgeICfZOysmV_PR1VJdVR79JOjk0w>
    <xme:Qs--Z6YIJPvnEs-csQvDJOu9AqeFAgpORhfSAgr76iksUcz7JAHFCMZCa9iJY84TA
    IGRgxtcU5zK3L18Wg>
X-ME-Received: <xmr:Qs--Z98qhTKfFkbNGy_iQnev25zu5nnESmDjonKrtyWOl7KBmNNqW8gbVcysgasYBkNvDFDXwMhmyK3A7Bg0EhgCK2CRazoNDHkC04IFGeFNwN5P>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdekgedtlecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhfffugggtgffkfhgjvfevofesthejredtredt
    jeenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrd
    himheqnecuggftrfgrthhtvghrnhepffeuiedujedvkeehuedvkeefffeivdeuleetkedu
    heejteekgedvudfgtdfgieelnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpe
    hmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepgedpmhhouggv
    pehsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
    dprhgtphhtthhopehjlhhtohgslhgvrhesghhmrghilhdrtghomhdprhgtphhtthhopehg
    ihhtshhtvghrsehpohgsohigrdgtohhmpdhrtghpthhtohepthhoohhnsehiohhttghlrd
    gtohhm
X-ME-Proxy: <xmx:Qs--ZxoHr1Mbp_oty-j1hvaeAcWSA8kv-EX_qWotYzXaVe56BL_pdw>
    <xmx:Qs--Z2omIzbZjIJWyVOPtPrEOfztC5MI9E_MppqPgqrWJfyDxWcuow>
    <xmx:Qs--Z3QzGXiivsApJCAPwl9a4Naadj4Kj68El9oPXRw6fzppAgTv_Q>
    <xmx:Qs--Z-qxgkB23GQmuhhyhSkmWtMA3OQaTgKcbSx9WGySZNj4wdQ7YQ>
    <xmx:Qs--Z_nTHN8XdOLO3gEhJ4WUSkUQLT8RG_aSXJovNpgk3XT0i6dr-4N8>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 26 Feb 2025 03:22:25 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id ef8766c3 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 26 Feb 2025 08:22:23 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Wed, 26 Feb 2025 09:22:14 +0100
Subject: [PATCH v3 04/13] meson: simplify use of the common-main library
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250226-b4-pks-meson-improvements-v3-4-60c77cf673ae@pks.im>
References: <20250226-b4-pks-meson-improvements-v3-0-60c77cf673ae@pks.im>
In-Reply-To: <20250226-b4-pks-meson-improvements-v3-0-60c77cf673ae@pks.im>
To: git@vger.kernel.org
Cc: Justin Tobler <jltobler@gmail.com>, Toon Claes <toon@iotcl.com>, 
 Junio C Hamano <gitster@pobox.com>
X-Mailer: b4 0.14.2

The "common-main.c" file is used by multiple executables. In order to
make it easy to set it up we have created a separate library that these
executables can link against. All of these executables also want to link
against `libgit.a` though, which makes it necessary to specify both of
these as dependencies for every executable.

Simplify this a bit by declaring the library as a source dependency:
instead of creating a static library, we now instead compile the common
set of files into each executable separately.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 meson.build          | 39 +++++++++++++++++++--------------------
 oss-fuzz/meson.build |  2 +-
 t/helper/meson.build |  4 ++--
 t/meson.build        |  4 ++--
 4 files changed, 24 insertions(+), 25 deletions(-)

diff --git a/meson.build b/meson.build
index a124101a73a..7236c163374 100644
--- a/meson.build
+++ b/meson.build
@@ -1604,15 +1604,14 @@ if host_machine.system() == 'windows'
     error('Unsupported compiler ' + compiler.get_id())
   endif
 endif
-common_main_library = static_library('common-main',
-  sources: common_main_sources,
-  c_args: libgit_c_args,
-  dependencies: libgit_dependencies,
-  include_directories: libgit_include_directories,
-)
-common_main = declare_dependency(
-  link_with: common_main_library,
+
+libgit_commonmain = declare_dependency(
+  link_with: static_library('common-main',
+    sources: common_main_sources,
+    dependencies: [ libgit ],
+  ),
   link_args: common_main_link_args,
+  dependencies: [ libgit ],
 )
 
 bin_wrappers = [ ]
@@ -1620,7 +1619,7 @@ test_dependencies = [ ]
 
 git = executable('git',
   sources: builtin_sources + 'git.c',
-  dependencies: [libgit, common_main],
+  dependencies: [libgit_commonmain],
   install: true,
   install_dir: get_option('libexecdir') / 'git-core',
 )
@@ -1628,35 +1627,35 @@ bin_wrappers += git
 
 test_dependencies += executable('git-daemon',
   sources: 'daemon.c',
-  dependencies: [libgit, common_main],
+  dependencies: [libgit_commonmain],
   install: true,
   install_dir: get_option('libexecdir') / 'git-core',
 )
 
 test_dependencies += executable('git-sh-i18n--envsubst',
   sources: 'sh-i18n--envsubst.c',
-  dependencies: [libgit, common_main],
+  dependencies: [libgit_commonmain],
   install: true,
   install_dir: get_option('libexecdir') / 'git-core',
 )
 
 bin_wrappers += executable('git-shell',
   sources: 'shell.c',
-  dependencies: [libgit, common_main],
+  dependencies: [libgit_commonmain],
   install: true,
   install_dir: get_option('libexecdir') / 'git-core',
 )
 
 test_dependencies += executable('git-http-backend',
   sources: 'http-backend.c',
-  dependencies: [libgit, common_main],
+  dependencies: [libgit_commonmain],
   install: true,
   install_dir: get_option('libexecdir') / 'git-core',
 )
 
 bin_wrappers += executable('scalar',
   sources: 'scalar.c',
-  dependencies: [libgit, common_main],
+  dependencies: [libgit_commonmain],
   install: true,
   install_dir: get_option('libexecdir') / 'git-core',
 )
@@ -1669,7 +1668,7 @@ if get_option('curl').enabled()
 
   git_remote_http = executable('git-remote-http',
     sources: curl_sources + 'remote-curl.c',
-    dependencies: [libgit, common_main],
+    dependencies: [libgit_commonmain],
     install: true,
     install_dir: get_option('libexecdir') / 'git-core',
   )
@@ -1677,7 +1676,7 @@ if get_option('curl').enabled()
 
   test_dependencies += executable('git-http-fetch',
     sources: curl_sources + 'http-fetch.c',
-    dependencies: [libgit, common_main],
+    dependencies: [libgit_commonmain],
     install: true,
     install_dir: get_option('libexecdir') / 'git-core',
   )
@@ -1685,7 +1684,7 @@ if get_option('curl').enabled()
   if expat.found()
     test_dependencies += executable('git-http-push',
       sources: curl_sources + 'http-push.c',
-      dependencies: [libgit, common_main],
+      dependencies: [libgit_commonmain],
       install: true,
       install_dir: get_option('libexecdir') / 'git-core',
     )
@@ -1694,7 +1693,7 @@ if get_option('curl').enabled()
   foreach alias : [ 'git-remote-https', 'git-remote-ftp', 'git-remote-ftps' ]
     test_dependencies += executable(alias,
       objects: git_remote_http.extract_all_objects(recursive: false),
-      dependencies: [libgit, common_main],
+      dependencies: [libgit_commonmain],
     )
 
     install_symlink(alias + executable_suffix,
@@ -1711,7 +1710,7 @@ endif
 
 test_dependencies += executable('git-imap-send',
   sources: imap_send_sources,
-  dependencies: [libgit, common_main],
+  dependencies: [libgit_commonmain],
   install: true,
   install_dir: get_option('libexecdir') / 'git-core',
 )
@@ -1719,7 +1718,7 @@ test_dependencies += executable('git-imap-send',
 foreach alias : [ 'git-receive-pack', 'git-upload-archive', 'git-upload-pack' ]
   bin_wrappers += executable(alias,
     objects: git.extract_all_objects(recursive: false),
-    dependencies: [libgit, common_main],
+    dependencies: [libgit_commonmain],
   )
 
   install_symlink(alias + executable_suffix,
diff --git a/oss-fuzz/meson.build b/oss-fuzz/meson.build
index ed796655016..878afd8426f 100644
--- a/oss-fuzz/meson.build
+++ b/oss-fuzz/meson.build
@@ -15,6 +15,6 @@ foreach fuzz_program : fuzz_programs
       'dummy-cmd-main.c',
       fuzz_program,
     ],
-    dependencies: [libgit, common_main],
+    dependencies: [libgit_commonmain],
   )
 endforeach
diff --git a/t/helper/meson.build b/t/helper/meson.build
index f502d1aaa36..ae01b3fc45d 100644
--- a/t/helper/meson.build
+++ b/t/helper/meson.build
@@ -79,14 +79,14 @@ test_tool_sources = [
 
 test_tool = executable('test-tool',
   sources: test_tool_sources,
-  dependencies: [libgit, common_main],
+  dependencies: [libgit_commonmain],
 )
 bin_wrappers += test_tool
 test_dependencies += test_tool
 
 test_fake_ssh = executable('test-fake-ssh',
   sources: 'test-fake-ssh.c',
-  dependencies: [libgit, common_main],
+  dependencies: [libgit_commonmain],
 )
 bin_wrappers += test_fake_ssh
 test_dependencies += test_fake_ssh
diff --git a/t/meson.build b/t/meson.build
index 35f25ca4a1d..dae50601fec 100644
--- a/t/meson.build
+++ b/t/meson.build
@@ -39,7 +39,7 @@ clar_sources += custom_target(
 
 clar_unit_tests = executable('unit-tests',
   sources: clar_sources + clar_test_suites,
-  dependencies: [libgit, common_main],
+  dependencies: [libgit_commonmain],
 )
 test('unit-tests', clar_unit_tests)
 
@@ -72,7 +72,7 @@ foreach unit_test_program : unit_test_programs
       'unit-tests/lib-reftable.c',
       unit_test_program,
     ],
-    dependencies: [libgit, common_main],
+    dependencies: [libgit_commonmain],
   )
   test(unit_test_name, unit_test,
     workdir: meson.current_source_dir(),

-- 
2.48.1.741.g8a9f3a5cdc.dirty

