Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FA3122A4EC
	for <git@vger.kernel.org>; Thu,  8 May 2025 08:24:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746692690; cv=none; b=cj308tdxSvivepUVdgrL4r4Buxh/m4swwS8t41150pXD3yxkDdb3L4/piJW30+4OtTxBWsCUVkvnOWMS2+lsChD7dgSQhymRKXlFHtetBA2YR71jkMaNcT9xCyWA0PUcdpErYoCHEEy8YWsZMPwW2MGCwDApMclX+YePO7lHOwk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746692690; c=relaxed/simple;
	bh=GlKCu27dSGCwsZFYlPuJ1uPXnWCBwVpjMwLhheKL3pA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=H5uOphN+MSta8Gfwsa4KusuTcrBmZYvOmzbqlLwYnwWcLpZQkZrNAlVQNDaO7V330D9PjuwwztbwC7E1ooWMRwIZ+LxII3BXx7Sb4i4iQOytScm1BA0nFiwm4yxoR02aPM0hvWhuYURLtIkLk1aAKbodSkUSovegNNcLiRqYSy4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c30bNiWK; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c30bNiWK"
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-7399a2dc13fso983458b3a.2
        for <git@vger.kernel.org>; Thu, 08 May 2025 01:24:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746692688; x=1747297488; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8CjOXCh1zOIqLGH09TPLYOHbjXE9GpRVqmvd2G4fxKI=;
        b=c30bNiWKNXN7LVGAnV9v9OiAsUxFzqC5oLYgPtcLeopzUhZD3R4bZkX01Vg+bHpiD4
         VY5KX+vejLDK54F/dqJEXUjK2i9yAMYjLUqJt4PR8m+UJwUOG/PTzvghNMwKYW4GvfjD
         /wYs5MasdWqE98FGHKxY9OPZjthFk+HoIoWNoFJxXA9SAwLPoLymaimDdKkbrohnpANr
         VBHUp8/77kBbsr4TH+gIMIuPTiLfqFAtQglRqWzY6HwplWGG0rlTaawWr1BPWInzFg/N
         8cXsua+hhOgePW1dv/nsCMzQtuuhnB2CZtsDr51buZxT1pRQKoVIIPvsBo3+bwlIcMgu
         ADUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746692688; x=1747297488;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8CjOXCh1zOIqLGH09TPLYOHbjXE9GpRVqmvd2G4fxKI=;
        b=kJLbb6ZyFoK8il55cBKMAs8FTvtmFRIqwJbjCPn5+A76TEZVYpjRn0D4SPXMdQlR2a
         C3mmbwQjoGWPYEO+fYr4EI+CQlqDaS/OgYQmttEWkXQXnH6qzL/+03nBJrN+NDURxGOV
         V3jZE+5T8aMGxxRqp2pWCdfYGPUYUf6Ijg9D2Udai/sywuEYAoyigw1RZuw4Q65QdsVG
         mHugcXQuUV2rHHUFfLxpcE05OeH3RTcThadYEQKT7lEgwHP4oMvc7pLOSp11RBSjuaXt
         YsiCKr5zH6YKDrhyhN06yw2CtxRdwzjGzxu1tJO/WMLBxQfVw86mDPMWxPXpzjtpVThi
         II/A==
X-Gm-Message-State: AOJu0YxRY3+5Hw2eCBScL0eq1EPwWXS5CSaF/oY6cxjaktT9VzUNS3Cz
	AFkqjWhLbQ2Gcbr/Z7+BqAqj2ZbfFFVeS/1xsHd6yqXpVJxa0ZrA+krNhg==
X-Gm-Gg: ASbGncuptuguwaW8gMFmwHvGQj8ad7jrTjcZsyAfiy63OblI/KcEhXnrHQSaH/lPnsj
	aS6wlxtF6nFN80WpIwVkImJrFtXsdGJd4Hc7NPHpVJ2KFKcVtG3R9VVrl6wD3wTmlMSiNEGuHtR
	H/yjVT02OLs/EqBR9vxxywAMDcCgXq0m1Bi7g/IUtZsEscEcs6ePKl6l3nrrUt1Xo/SAARwBSbk
	0LNoTJEoy3ZWewQupJ/fJdmmSNjRn8OjZ+YyBjj+gViwqUiA6hUu91pboaTmMfoSydeDCPi/peP
	ivGF4j2aCLMNcYxfP9RsNioPREUJkjsi/LPO7q7f4TweY67wMZjFRjfz4g==
X-Google-Smtp-Source: AGHT+IHtyj0X/8c/++OjpBsJsOfiexbuyknJEWutrlfBNaaYifqyRA8b/NRz8ebnJXTAfFSh1eUpHA==
X-Received: by 2002:a05:6a20:c791:b0:1f5:72eb:8b62 with SMTP id adf61e73a8af0-2148be01d42mr8893430637.20.1746692688252;
        Thu, 08 May 2025 01:24:48 -0700 (PDT)
Received: from localhost.localdomain ([2001:ee0:50da:6e40:c6b6:28e0:30d5:5a17])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-74058db91cfsm12555695b3a.48.2025.05.08.01.24.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 May 2025 01:24:47 -0700 (PDT)
From: =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= <congdanhqx@gmail.com>
To: git@vger.kernel.org
Cc: =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= <congdanhqx@gmail.com>,
	Patrick Steinhardt <ps@pks.im>
Subject: [PATCH v2] meson: allow customize perl installation path
Date: Thu,  8 May 2025 15:24:40 +0700
Message-ID: <a9d431944b6d94e0eb25535c061fc226a7fefa9e.1746692662.git.congdanhqx@gmail.com>
X-Mailer: git-send-email 2.49.0.395.g12beb8f557ceb
In-Reply-To: <80a2a6ce7c6b05323cf931cdc20d4decb6270002.1745507677.git.congdanhqx@gmail.com>
References: <80a2a6ce7c6b05323cf931cdc20d4decb6270002.1745507677.git.congdanhqx@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Some distros, notably Fedora, want to install non-core Perl libraries
into specific directory, namely /usr/share/perl5/vendor_perl.

The Makefile build system allows this by overriding perllibdir variable,
let's make meson works on par with our Makefile.

Signed-off-by: Đoàn Trần Công Danh <congdanhqx@gmail.com>
---
 meson.build                        | 9 +++++++--
 meson_options.txt                  | 4 ++++
 perl/FromCPAN/Mail/meson.build     | 2 +-
 perl/FromCPAN/meson.build          | 2 +-
 perl/Git/LoadCPAN/Mail/meson.build | 2 +-
 perl/Git/LoadCPAN/meson.build      | 2 +-
 perl/Git/SVN/Memoize/meson.build   | 2 +-
 perl/Git/SVN/meson.build           | 2 +-
 perl/Git/meson.build               | 2 +-
 perl/meson.build                   | 2 +-
 10 files changed, 19 insertions(+), 10 deletions(-)

diff --git a/meson.build b/meson.build
index efe2871c9dba1..5155aa726b20e 100644
--- a/meson.build
+++ b/meson.build
@@ -1825,14 +1825,19 @@ if perl_features_enabled
     perl_header_template = 'perl/header_templates/runtime_prefix.template.pl'
   endif
 
+  perllibdir = get_option('perllibdir')
+  if perllibdir == ''
+    perllibdir = get_option('datadir') / 'perl5'
+  endif
+
   perl_header = configure_file(
     input: perl_header_template,
     output: 'GIT-PERL-HEADER',
     configuration: {
       'GITEXECDIR_REL': get_option('libexecdir') / 'git-core',
-      'PERLLIBDIR_REL': get_option('datadir') / 'perl5',
+      'PERLLIBDIR_REL': perllibdir,
       'LOCALEDIR_REL': get_option('datadir') / 'locale',
-      'INSTLIBDIR': get_option('datadir') / 'perl5',
+      'INSTLIBDIR': perllibdir,
       'PATHSEP': pathsep,
     },
   )
diff --git a/meson_options.txt b/meson_options.txt
index 78d172a74019a..cc19918a7ccfa 100644
--- a/meson_options.txt
+++ b/meson_options.txt
@@ -1,3 +1,7 @@
+# Configuration for Git installation
+option('perllibdir', type: 'string', value: '',
+  description: 'Directory to install perl lib to. Defaults to <datadir>/perl5')
+
 # Configuration for how Git behaves at runtime.
 option('default_pager', type: 'string', value: 'less',
   description: 'Fall-back pager.')
diff --git a/perl/FromCPAN/Mail/meson.build b/perl/FromCPAN/Mail/meson.build
index b4ff2fc0b24c9..467507c5e690e 100644
--- a/perl/FromCPAN/Mail/meson.build
+++ b/perl/FromCPAN/Mail/meson.build
@@ -3,6 +3,6 @@ test_dependencies += custom_target(
   output: 'Address.pm',
   command: generate_perl_command,
   install: true,
-  install_dir: get_option('datadir') / 'perl5/FromCPAN/Mail',
+  install_dir: perllibdir / 'FromCPAN/Mail',
   depends: [git_version_file],
 )
diff --git a/perl/FromCPAN/meson.build b/perl/FromCPAN/meson.build
index 1f9ea6ce8e844..720c60283d89b 100644
--- a/perl/FromCPAN/meson.build
+++ b/perl/FromCPAN/meson.build
@@ -3,7 +3,7 @@ test_dependencies += custom_target(
   output: 'Error.pm',
   command: generate_perl_command,
   install: true,
-  install_dir: get_option('datadir') / 'perl5/FromCPAN',
+  install_dir: perllibdir / 'FromCPAN',
   depends: [git_version_file],
 )
 
diff --git a/perl/Git/LoadCPAN/Mail/meson.build b/perl/Git/LoadCPAN/Mail/meson.build
index 89cde56be8491..05a5770560d3d 100644
--- a/perl/Git/LoadCPAN/Mail/meson.build
+++ b/perl/Git/LoadCPAN/Mail/meson.build
@@ -3,6 +3,6 @@ test_dependencies += custom_target(
   output: 'Address.pm',
   command: generate_perl_command,
   install: true,
-  install_dir: get_option('datadir') / 'perl5/Git/LoadCPAN/Mail',
+  install_dir: perllibdir / 'Git/LoadCPAN/Mail',
   depends: [git_version_file],
 )
diff --git a/perl/Git/LoadCPAN/meson.build b/perl/Git/LoadCPAN/meson.build
index 1ee915c650517..b975d4972631d 100644
--- a/perl/Git/LoadCPAN/meson.build
+++ b/perl/Git/LoadCPAN/meson.build
@@ -3,7 +3,7 @@ test_dependencies += custom_target(
   output: 'Error.pm',
   command: generate_perl_command,
   install: true,
-  install_dir: get_option('datadir') / 'perl5/Git/LoadCPAN',
+  install_dir: perllibdir / 'Git/LoadCPAN',
   depends: [git_version_file],
 )
 
diff --git a/perl/Git/SVN/Memoize/meson.build b/perl/Git/SVN/Memoize/meson.build
index 233ec670d7de9..4c589b30c387a 100644
--- a/perl/Git/SVN/Memoize/meson.build
+++ b/perl/Git/SVN/Memoize/meson.build
@@ -3,6 +3,6 @@ test_dependencies += custom_target(
   output: 'YAML.pm',
   command: generate_perl_command,
   install: true,
-  install_dir: get_option('datadir') / 'perl5/Git/SVN',
+  install_dir: perllibdir / 'Git/SVN',
   depends: [git_version_file],
 )
diff --git a/perl/Git/SVN/meson.build b/perl/Git/SVN/meson.build
index 44abaf42b7cea..8858985fe8660 100644
--- a/perl/Git/SVN/meson.build
+++ b/perl/Git/SVN/meson.build
@@ -13,7 +13,7 @@ foreach source : [
     output: source,
     command: generate_perl_command,
     install: true,
-    install_dir: get_option('datadir') / 'perl5/Git/SVN',
+    install_dir: perllibdir / 'Git/SVN',
     depends: [git_version_file],
   )
 endforeach
diff --git a/perl/Git/meson.build b/perl/Git/meson.build
index b21fa5591e7e7..a61b7b1f4abf2 100644
--- a/perl/Git/meson.build
+++ b/perl/Git/meson.build
@@ -10,7 +10,7 @@ foreach source : [
     output: source,
     command: generate_perl_command,
     install: true,
-    install_dir: get_option('datadir') / 'perl5/Git',
+    install_dir: perllibdir / 'Git',
     depends: [git_version_file],
   )
 endforeach
diff --git a/perl/meson.build b/perl/meson.build
index 2d4ab1c4a986f..3c66b007eaad9 100644
--- a/perl/meson.build
+++ b/perl/meson.build
@@ -3,7 +3,7 @@ test_dependencies += custom_target(
   output: 'Git.pm',
   command: generate_perl_command,
   install: true,
-  install_dir: get_option('datadir') / 'perl5',
+  install_dir: perllibdir,
   depends: [git_version_file],
 )
 

Range-diff against v1:
1:  14e38695adbd6 ! 1:  a9d431944b6d9 meson: allow customize perl installation path
    @@ meson.build: if perl_features_enabled
      ## meson_options.txt ##
     @@
     +# Configuration for Git installation
    -+
     +option('perllibdir', type: 'string', value: '',
    -+  description: 'Directory to install perl lib to. Default to <datadir>/perl5')
    ++  description: 'Directory to install perl lib to. Defaults to <datadir>/perl5')
     +
      # Configuration for how Git behaves at runtime.
      option('default_pager', type: 'string', value: 'less',
