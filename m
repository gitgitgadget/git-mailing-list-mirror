Received: from avasout-ptp-001.plus.net (avasout-ptp-001.plus.net [84.93.230.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DCBE70814
	for <git@vger.kernel.org>; Sun,  6 Apr 2025 19:42:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=84.93.230.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743968551; cv=none; b=SHGgkmeK+HZgl1Pcb8sVaYjrhM+R9cXTj6bO5qK5lw7WFmMDqw3Aqh7OM3QzDZScLCroOhaunXwVygoIJ1F1rQO+uNAjUQHalikQVXVPCTLrOHaSRQ5OvCEB/Sfb5KufUZlD1joE9JeJSbXVkifmaStt/QBFvdFqYVcc5vRknDk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743968551; c=relaxed/simple;
	bh=bW/j7rKgYhirA3eLLuJkFjLSgCAypFp8g5mp1rmzIgM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tF5XJ1fzmejITs/M4t+G1EsHQfbnAPUrcNhoNDcfihQ03lfNRpATeIASkC7Z3bmkPmvlESD9YN7EBAOilGH/n8042OQ81bIw/59fJXOXMUUwWQOZW8JbbKJFNI7tSBXH9sNPCadYQlVPghF5fYey8p8yXKEtHSOU4h92vyjsn6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ramsayjones.plus.com; spf=none smtp.mailfrom=ramsayjones.plus.com; dkim=pass (2048-bit key) header.d=plus.com header.i=@plus.com header.b=aEXhkOT4; arc=none smtp.client-ip=84.93.230.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ramsayjones.plus.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ramsayjones.plus.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=plus.com header.i=@plus.com header.b="aEXhkOT4"
Received: from localhost.localdomain ([80.189.83.109])
	by smtp with ESMTPA
	id 1VpUuYqwzbpaN1Vq5upkLP; Sun, 06 Apr 2025 20:39:29 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=plus.com; s=042019;
	t=1743968369; bh=3n50cZYJlZz6WMT7x1eU8mzOm0zp4CHQZUs4o4EFlfw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=aEXhkOT4jXALzCM4LhvDGQk4F75mT5k41dRdFsBHQD6y/yjBBeMyJWrjAgyN25JHZ
	 iZdlhiFnkQsYHD+BvpL9XnGkNPtepmG9GJa9VQL46XpFOMSvGsRdIa9uPU1dGZin/f
	 xQm/ZxnlEt1SacTkoUm4G+yjuAlZJxh+l98EAbvCRelTJQBqYVJghws5bmEywlMiA2
	 HEp/D+ZtjzNMU+VP+eyGig9+SlTGJyqcpEJajqJMSOHetbvTByKxbKzMUlILAlfMGX
	 ViY8Ro8fDQDxgIiPNcd32rKJxDeskeKBrdBv1S/E4o2xpIz15MG3IxDC57sFrdxdP2
	 0uO81s50dx39A==
X-Clacks-Overhead: "GNU Terry Pratchett"
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.4 cv=frZ/Z04f c=1 sm=1 tr=0 ts=67f2d871
 a=oM5NSl/Bl4BpjFr0C8iQlQ==:117 a=oM5NSl/Bl4BpjFr0C8iQlQ==:17 a=EBOSESyhAAAA:8
 a=Vy2chUuRFShQgWdV_nEA:9 a=yJM6EZoI5SlJf8ks9Ge_:22
X-AUTH: ramsayjones@:2500
From: Ramsay Jones <ramsay@ramsayjones.plus.com>
To: GIT Mailing-list <git@vger.kernel.org>
Cc: Junio C Hamano <gitster@pobox.com>,
	Patrick Steinhardt <ps@pks.im>,
	Adam Dinwoodie <git@dinwoodie.org>,
	Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: [PATCH v2 03/13] meson.build: only set build variables for non-default values
Date: Sun,  6 Apr 2025 20:38:29 +0100
Message-ID: <280363cd569a8c6e870107eb219597b42911fed2.1743859985.git.ramsay@ramsayjones.plus.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <cover.1743859985.git.ramsay@ramsayjones.plus.com>
References: <1c04882b-e518-4272-bd18-ab918774e424@ramsayjones.plus.com> <cover.1743859985.git.ramsay@ramsayjones.plus.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4xfBDleLQZGLW7hhaOdRK6WstxkAn5KKjeU36+9zObc/z+VmVaLeC6qGSOF6gbP29Uce6jsI180wAJ/L1RFx6sOzsKxBo/KuGFW7rrrG7iBH7au4Yuyv9p
 VgNll/JxIisE2S3A79WQ9myLFEy1PB4efCQGG7NgsXuMmWdjgBk6HIRI7g7SO6MPAyOw5ZkwHoMWZNnOOXwqfNQlfXJlH35rAAs=

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

