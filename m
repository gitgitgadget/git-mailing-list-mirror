Received: from sender3-op-o12.zoho.com (sender3-op-o12.zoho.com [136.143.184.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7048E2F8BCB
	for <git@vger.kernel.org>; Wed, 19 Nov 2025 21:11:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.184.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763586719; cv=pass; b=Vx/vrYBCkJ/lyFXxcIumr0Tf6sntagMnBeENgXVXJAs9jcUY0VgTdlkzafGDwvhX82DOZZeTXVlTQhbcIUbERtM93O8M5Skhoonos310Yzo/LO3tRbdjep4v8uFVaTA5BvVMU/EpVQIlRsNZ4wPdO6zP/QYIZ0QLfsxXeJop9mc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763586719; c=relaxed/simple;
	bh=5G4bIAG759li2YxkpVhzIZJ7DyvpfIm9OYAeNsPGSbU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dpfx768X7SmLrt9nc7IyOVMVP6DQcdH/Xh2UBA3mGIlr/jSKrB1UuHFbwOyLdQImGIg9+rroH57REEYTjJ/5+Jg5aB3uFL/UvUZkGxkUFCmRI9O2waKWhsrW2d98vK4yo1qFr93dEk8vu6tsglBrqnZvgW2L64kkwHPcySVbdY0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.ratiu@collabora.com header.b=DZQ8DAuq; arc=pass smtp.client-ip=136.143.184.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.ratiu@collabora.com header.b="DZQ8DAuq"
ARC-Seal: i=1; a=rsa-sha256; t=1763586698; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=aNGKQAOFMFyExgv3vH0gZx+oCiXZgeLn/IJrw8ZqYA1XJ6ljNYPISAX4urA+IWLMyjVaA2ZX/h4oNghPErste/abFzQD5Y8Z37RiHGhyRLS/PnvZoYmsVqu+t0OWGjsSHtta2X0bSR+d2tJa3fArHBOS6/zG4aC2vi5vzWADPUs=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1763586698; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=UXmggd6Z4wQF3z22sI1Dc5uwpEqfNMebWUPLDtQcztE=; 
	b=bjKTp7f8/V9XFmmrHWAuBKv9u887M4slSQCJkVj29a3AJDGeGi9Aa4+b1mHdLALkVuKjLlYe1w6XHCKe0r0vd36Qyj7MgzUqEPeBLNmVhkzM9RaBtQ0UgMJroyF2OU+VFCnY7VJVuMSP8a1Y98M5O/bZ10zhAcCohGfa9gckBsk=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=adrian.ratiu@collabora.com;
	dmarc=pass header.from=<adrian.ratiu@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1763586698;
	s=zohomail; d=collabora.com; i=adrian.ratiu@collabora.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=UXmggd6Z4wQF3z22sI1Dc5uwpEqfNMebWUPLDtQcztE=;
	b=DZQ8DAuqcT7APwIP980vm9xBLDvk7TCKpuLN4qK2LFJCMRAAHIsLJ8KGWGXRlYi+
	OY5t9G8rQH+7kfXctezwdEllivqgLbqnFz42DY/a457iFVR13wQvdcwo8pvofQeOZ0d
	ikfDL8uatKJZWwi9pKlqHGDdnXaiSK7OvdYrDdSA=
Received: by mx.zohomail.com with SMTPS id 1763586696224521.324175167342;
	Wed, 19 Nov 2025 13:11:36 -0800 (PST)
From: Adrian Ratiu <adrian.ratiu@collabora.com>
To: git@vger.kernel.org
Cc: Emily Shaffer <emilyshaffer@google.com>,
	Rodrigo Damazio Bovendorp <rdamazio@google.com>,
	Jeff King <peff@peff.net>,
	Junio C Hamano <gitster@pobox.com>,
	Aaron Schrab <aaron@schrab.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Patrick Steinhardt <ps@pks.im>,
	Josh Steadmon <steadmon@google.com>,
	Ben Knoble <ben.knoble@gmail.com>,
	Phillip Wood <phillip.wood123@gmail.com>,
	Adrian Ratiu <adrian.ratiu@collabora.com>
Subject: [PATCH v5 7/7] meson/Makefile: allow setting submodule encoding at build time
Date: Wed, 19 Nov 2025 23:10:30 +0200
Message-ID: <20251119211030.2008441-8-adrian.ratiu@collabora.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251119211030.2008441-1-adrian.ratiu@collabora.com>
References: <20250816213642.3517822-1-adrian.ratiu@collabora.com>
 <20251119211030.2008441-1-adrian.ratiu@collabora.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

Some users find it difficult to distribute repo config changes for
enabling extensions.submoduleEncoding, or to enable it by passing
the config via cmdline, so we add a build-time option which can
enable the extension for convenience.

It is still disabled by default and the build-time default is
overridden by the repo-specific configs.

Signed-off-by: Adrian Ratiu <adrian.ratiu@collabora.com>
---
 Documentation/config/extensions.adoc |  2 ++
 Makefile                             |  5 +++++
 configure.ac                         | 23 +++++++++++++++++++++++
 meson.build                          |  4 ++++
 meson_options.txt                    |  2 ++
 setup.c                              |  8 ++++++++
 6 files changed, 44 insertions(+)

diff --git a/Documentation/config/extensions.adoc b/Documentation/config/extensions.adoc
index 4861d01894..436f7fb52e 100644
--- a/Documentation/config/extensions.adoc
+++ b/Documentation/config/extensions.adoc
@@ -78,6 +78,8 @@ submoduleEncoding:::
 	conflicts due to nested gitdirs, case insensitivity or other issues.
 	When enabled, the submodule.<name>.gitdir config is always set for
 	all submodules and is the single point of authority for gitdir paths.
+	Can also be enabled via the submodule-encoding build option. The repo
+	config takes precedence over the build-time default.
 
 worktreeConfig:::
 	If enabled, then worktrees will load config settings from the
diff --git a/Makefile b/Makefile
index 7e0f77e298..4c7bf75c68 100644
--- a/Makefile
+++ b/Makefile
@@ -2344,6 +2344,11 @@ ifdef INCLUDE_LIBGIT_RS
 	BASIC_CFLAGS += -fvisibility=hidden
 endif
 
+ifdef SUBMODULE_ENCODING_BY_DEFAULT
+	# Set submoduleEncoding extension default specified at build time
+	BASIC_CFLAGS += -DSUBMODULE_ENCODING_BY_DEFAULT=$(SUBMODULE_ENCODING_BY_DEFAULT)
+endif
+
 ifeq ($(TCLTK_PATH),)
 NO_TCLTK = NoThanks
 endif
diff --git a/configure.ac b/configure.ac
index cfb50112bf..202b1e309b 100644
--- a/configure.ac
+++ b/configure.ac
@@ -229,6 +229,29 @@ AC_ARG_ENABLE([cssmin],
   GIT_CONF_SUBST([CSSMIN])
 ])
 
+# Define option to enable the submodule encoding extension by default
+AC_ARG_ENABLE([submodule-encoding],
+ [AS_HELP_STRING([--enable-submodule-encoding],
+  [Enable the submoduleEncoding extension by default at build time.]
+  [--disable-submodule-encoding will keep the current default (disabled).])],
+[
+case "$enableval" in
+  yes) SUBMODULE_ENCODING_BY_DEFAULT=1
+       AC_MSG_NOTICE([Submodule encoding will be enabled by default.])
+       ;;
+  no)  SUBMODULE_ENCODING_BY_DEFAULT=0
+       AC_MSG_NOTICE([Submodule encoding will not be enabled by default.])
+       ;;
+  *)   AC_MSG_ERROR([--enable-submodule-encoding takes yes or no.])
+       ;;
+esac
+],
+[
+  SUBMODULE_ENCODING_BY_DEFAULT=0
+])
+
+GIT_CONF_SUBST([SUBMODULE_ENCODING_BY_DEFAULT])
+
 ## Site configuration (override autodetection)
 ## --with-PACKAGE[=ARG] and --without-PACKAGE
 AC_MSG_NOTICE([CHECKS for site configuration])
diff --git a/meson.build b/meson.build
index 1f95a06edb..992d433efd 100644
--- a/meson.build
+++ b/meson.build
@@ -945,6 +945,10 @@ else
   build_options_config.set('NO_PERL_CPAN_FALLBACKS', '')
 endif
 
+submodule_encoding_by_default = get_option('submodule-encoding').to_int()
+libgit_c_args += '-DSUBMODULE_ENCODING_BY_DEFAULT=' + submodule_encoding_by_default.to_string()
+build_options_config.set('SUBMODULE_ENCODING_BY_DEFAULT', submodule_encoding_by_default)
+
 zlib_backend = get_option('zlib_backend')
 if zlib_backend in ['auto', 'zlib-ng']
   zlib_ng = dependency('zlib-ng', required: zlib_backend == 'zlib-ng')
diff --git a/meson_options.txt b/meson_options.txt
index e0be260ae1..d9d569a166 100644
--- a/meson_options.txt
+++ b/meson_options.txt
@@ -21,6 +21,8 @@ option('runtime_prefix', type: 'boolean', value: false,
   description: 'Resolve ancillary tooling and support files relative to the location of the runtime binary instead of hard-coding them into the binary.')
 option('sane_tool_path', type: 'array', value: [],
   description: 'An array of paths to pick up tools from in case the normal tools are broken or lacking.')
+option('submodule-encoding', type: 'boolean', value: false,
+  description: 'Enable submoduleEncoding extension by default at build time.')
 
 # Build information compiled into Git and other parts like documentation.
 option('build_date', type: 'string', value: '',
diff --git a/setup.c b/setup.c
index bf6e815105..de2d4e7238 100644
--- a/setup.c
+++ b/setup.c
@@ -1747,6 +1747,14 @@ const char *setup_git_directory_gently(int *nongit_ok)
 	 */
 	repo_config_clear(the_repository);
 
+	/*
+	 * Set build-time default for submodule encoding.
+	 * This can be overridden by the repository's config.
+	 */
+#ifdef SUBMODULE_ENCODING_BY_DEFAULT
+	repo_fmt.submodule_encoding = SUBMODULE_ENCODING_BY_DEFAULT;
+#endif
+
 	/*
 	 * Let's assume that we are in a git repository.
 	 * If it turns out later that we are somewhere else, the value will be
-- 
2.51.0

