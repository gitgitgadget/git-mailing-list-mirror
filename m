Received: from avasout-ptp-003.plus.net (avasout-ptp-003.plus.net [84.93.230.244])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA4F324BD00
	for <git@vger.kernel.org>; Wed, 16 Apr 2025 23:19:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=84.93.230.244
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744845569; cv=none; b=CYi5H2aLOOdG7DSwF0nH05g8kRtt9op2pR4eL7dOPfzQeNbgEWzRqrs6feB2bgsd1g7HS7DW3J91bilIcQYlDxP6RVxkyCKvAOnHWfqbbQS7q3aJ0+7hHLfxow8t6XbX1n8gyWBnLMxX6AQuUC3o0KCOmhvR3vHAewgdqLsZ51s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744845569; c=relaxed/simple;
	bh=bW/j7rKgYhirA3eLLuJkFjLSgCAypFp8g5mp1rmzIgM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=b454+MBvwdycoKz9jrSUZHZ6/fl54dbPXpyokzOMvCKKJr8l+bmLxcXAnJkmNsRviO+qajRvqL2qk6tFcLuMcLCeRO1uq5XgNdG1928R9Wpl70dGLLD2y7LNskSBkKELdEoXLKcYI8JOqR5GXQQf5iFVGJ3wLrYLcBUIOJbTgso=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ramsayjones.plus.com; spf=none smtp.mailfrom=ramsayjones.plus.com; dkim=pass (2048-bit key) header.d=plus.com header.i=@plus.com header.b=CrnPyyTL; arc=none smtp.client-ip=84.93.230.244
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ramsayjones.plus.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ramsayjones.plus.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=plus.com header.i=@plus.com header.b="CrnPyyTL"
Received: from localhost.localdomain ([80.189.83.109])
	by smtp with ESMTPA
	id 5C1quLy9hjZe55C2Qu8KPI; Thu, 17 Apr 2025 00:19:26 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=plus.com; s=042019;
	t=1744845566; bh=3n50cZYJlZz6WMT7x1eU8mzOm0zp4CHQZUs4o4EFlfw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=CrnPyyTLbvdMafIMMEh7zeQKiKAmcH6/Ohr9EZ7VFfaQP+toXUeInvWVh4boh27L5
	 gi5p1oHnFhHZ8OsIwXIjddF08uStgnU9gRDIuUpClboLhzkG1LEHNIr5q9tgSEDRKw
	 4Gbg3M1PpEZv3+4/jMnVNnx5J8pldCZLavUYJnaqXFLRzsDGhf/a6WDK+1IQVX2DMT
	 sX6WpiGx3RSc6bU7nbAWmv7nxUgn+9+s+0CWMc5tJpdpRavY6my0tTTfCIHWa8xqOd
	 y4z1Eut/LvQKrXMWqrXEmQ6vcLsFmp5GBUA5wX4CbbdL6YKE7EUIxLIezaS5u346Kl
	 rokYhIe8E5Avg==
X-Clacks-Overhead: "GNU Terry Pratchett"
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.4 cv=UuDANPwB c=1 sm=1 tr=0 ts=68003afe
 a=oM5NSl/Bl4BpjFr0C8iQlQ==:117 a=oM5NSl/Bl4BpjFr0C8iQlQ==:17 a=EBOSESyhAAAA:8
 a=Vy2chUuRFShQgWdV_nEA:9 a=yJM6EZoI5SlJf8ks9Ge_:22
X-AUTH: ramsayjones@:2500
From: Ramsay Jones <ramsay@ramsayjones.plus.com>
To: GIT Mailing-list <git@vger.kernel.org>
Cc: Junio C Hamano <gitster@pobox.com>,
	Patrick Steinhardt <ps@pks.im>,
	Adam Dinwoodie <git@dinwoodie.org>,
	Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: [PATCH v3 03/13] meson.build: only set build variables for non-default values
Date: Thu, 17 Apr 2025 00:18:24 +0100
Message-ID: <20250416231835.2492562-4-ramsay@ramsayjones.plus.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250416231835.2492562-1-ramsay@ramsayjones.plus.com>
References: <cover.1743859985.git.ramsay@ramsayjones.plus.com>
 <20250416231835.2492562-1-ramsay@ramsayjones.plus.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4xfArNOIIO7kvRz8Upkmr4KdGpI3AELEIoaaG+9qPBlbiub28fQICX8Mo3mMlGtVe26wLQGQb6niPs/d0aXIi6BljStI+SD6zAUWVml+H5BhEDZ0g0pPV0
 vFrYRkIhLCDU59Vz3ca7dqw6du83rLfr89IKgg1V0LAHpSH5krCFv59WNiMUX8q1FEqtincBiAo7KoplbR/dzNDOOLe3+McR3K0=

Some preprocessor -Defines have defaults set in the source code when
they have not been provided to the C compiler. In this case, there is
no need to pass them on the command-line, unless the build requires a
non-standard value.

The build variables for DEFAULT_EDITOR and DEFAULT_PAGER have appropriate
defaults ('vi' and 'less') set in the code. Add the preprocessor -Defines
to the 'libgit_c_args' only if the values set with the corresponding
'options' are different to these standard values.

Also, the 'git-var' documentation contains some conditional text which
documents the chosen compiled in value, which would not read well for
the standard values. Similar to the above, only add the corresponding
'-a' attribute arguments to the 'asciidoc_common_options' variable, if
the values set in the 'options' are different to these standard values.

Signed-off-by: Ramsay Jones <ramsay@ramsayjones.plus.com>
---
 Documentation/meson.build | 20 ++++++++++++++++++++
 meson.build               | 13 +++++++++++--
 2 files changed, 31 insertions(+), 2 deletions(-)

diff --git a/Documentation/meson.build b/Documentation/meson.build
index 594546d68b..1642b6e2a3 100644
--- a/Documentation/meson.build
+++ b/Documentation/meson.build
@@ -242,6 +242,16 @@ if docs_backend == 'asciidoc'
     '--attribute=build_dir=' + meson.current_build_dir(),
   ]
 
+  pager_opt = get_option('default_pager')
+  if pager_opt != '' and pager_opt != 'less'
+    asciidoc_common_options += '-agit-default-pager=' + pager_opt
+  endif
+
+  editor_opt = get_option('default_editor')
+  if editor_opt != '' and editor_opt != 'vi'
+    asciidoc_common_options += '-agit-default-editor=' + editor_opt
+  endif
+
   documentation_deps = [
     asciidoc_conf,
   ]
@@ -279,6 +289,16 @@ elif docs_backend == 'asciidoctor'
     '--require', 'asciidoctor-extensions',
   ]
 
+  pager_opt = get_option('default_pager')
+  if pager_opt != '' and pager_opt != 'less'
+    asciidoc_common_options += '-agit-default-pager=' + pager_opt
+  endif
+
+  editor_opt = get_option('default_editor')
+  if editor_opt != '' and editor_opt != 'vi'
+    asciidoc_common_options += '-agit-default-editor=' + editor_opt
+  endif
+
   documentation_deps = [
     asciidoctor_extensions,
   ]
diff --git a/meson.build b/meson.build
index 88a29fd043..efd0bd3319 100644
--- a/meson.build
+++ b/meson.build
@@ -693,10 +693,8 @@ endif
 # These variables are used for building libgit.a.
 libgit_c_args = [
   '-DBINDIR="' + get_option('bindir') + '"',
-  '-DDEFAULT_EDITOR="' + get_option('default_editor') + '"',
   '-DDEFAULT_GIT_TEMPLATE_DIR="' + get_option('datadir') / 'git-core/templates' + '"',
   '-DDEFAULT_HELP_FORMAT="' + get_option('default_help_format') + '"',
-  '-DDEFAULT_PAGER="' + get_option('default_pager') + '"',
   '-DETC_GITATTRIBUTES="' + get_option('gitattributes') + '"',
   '-DETC_GITCONFIG="' + get_option('gitconfig') + '"',
   '-DFALLBACK_RUNTIME_PREFIX="' + get_option('prefix') + '"',
@@ -708,6 +706,17 @@ libgit_c_args = [
   '-DPAGER_ENV="' + get_option('pager_environment') + '"',
   '-DSHELL_PATH="' + fs.as_posix(shell.full_path()) + '"',
 ]
+
+editor_opt = get_option('default_editor')
+if editor_opt != '' and editor_opt != 'vi'
+  libgit_c_args += '-DDEFAULT_EDITOR="' + editor_opt + '"'
+endif
+
+pager_opt = get_option('default_pager')
+if pager_opt != '' and pager_opt != 'less'
+  libgit_c_args += '-DDEFAULT_PAGER="' + pager_opt + '"'
+endif
+
 libgit_include_directories = [ '.' ]
 libgit_dependencies = [ ]
 
-- 
2.49.0

