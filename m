Received: from avasout-ptp-002.plus.net (avasout-ptp-002.plus.net [84.93.230.235])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C1CF1C8638
	for <git@vger.kernel.org>; Fri, 16 May 2025 18:49:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=84.93.230.235
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747421365; cv=none; b=XqXcqkwzXY2OnfZHGfQs8EcCcTHseBUrHBtB33qY44mRlr9KCf7zAEs6OOyF127H97P9+91ncdyLMtcmgyC6YT0mF6vqXlfIyhym73J44YUK7kP16ueEXs5ypPW0EveIRAAsNDi2GACnUFSA/ndCZn7TSUdUYMPD5ucTCY+CqhM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747421365; c=relaxed/simple;
	bh=d3+YfWYfujkGaTu3ul/VF+UMOIE9gDgi8C8qMDtQvCM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZApw4ZWstJmTIckio1to1lxRoWLYpW+3ScboCJLdft3u6+eWk1FsA+bzf8Jnguo2Lsl72p3sjl88+mSb3Xt4+8ZmiLYaGuIk82MVxdDtYGQPtc0kUDdJAlR9arkgPhaATvigGfxAT9p2wyFoEVhCM7ZqPwAlwXB0gKGENzBL3+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ramsayjones.plus.com; spf=none smtp.mailfrom=ramsayjones.plus.com; dkim=pass (2048-bit key) header.d=plus.com header.i=@plus.com header.b=nj71xZTm; arc=none smtp.client-ip=84.93.230.235
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ramsayjones.plus.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ramsayjones.plus.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=plus.com header.i=@plus.com header.b="nj71xZTm"
Received: from localhost.localdomain ([80.189.83.109])
	by smtp with ESMTPA
	id G071uFdJgJGekG07VuP0hh; Fri, 16 May 2025 19:49:22 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=plus.com; s=042019;
	t=1747421362; bh=JK+jQ5vC4FqUOdSTkcTh79MbLw/TXmDKbLVJj4Wh8LQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=nj71xZTmnejV/EqzuqUw14XkNQcKDo7RUpQKxFjxjXSZ2CbUtJtQcMYFATIyoLK1f
	 utrlvW+vjy6Hl7tMdvQS5pEsSy/BpRj+utryO/YjVre3Iua7/I67C+AMlcW4nR++Ux
	 JzlAcRYFCTkUAG/BdZJoLuL6JtWErvJyIYt1PJkmbs9c/EIj6BaQmeQRzYMBEYBj4Z
	 2+xkAt8AyrqkNrgsXt9Xg8JYOrq3VLYWJmxdSQMU+R+vDMbN1dmoj6qljywB2BR7bC
	 53nAAWKiQvQMYMnXkx8XhvsVPN+qVu2Rtrxea58KjQSejcNe7afcns2gULrtKPmRZl
	 UiMBm1XxONqCA==
X-Clacks-Overhead: "GNU Terry Pratchett"
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.4 cv=FoOm/Hrq c=1 sm=1 tr=0 ts=682788b2
 a=oM5NSl/Bl4BpjFr0C8iQlQ==:117 a=oM5NSl/Bl4BpjFr0C8iQlQ==:17 a=EBOSESyhAAAA:8
 a=Bf_rgq-1Vori9GIeTrYA:9 a=NQ49dVRg0HB7jjQIFhAn:22 a=yJM6EZoI5SlJf8ks9Ge_:22
X-AUTH: ramsayjones@:2500
From: Ramsay Jones <ramsay@ramsayjones.plus.com>
To: GIT Mailing-list <git@vger.kernel.org>
Cc: Ramsay Jones <ramsay@ramsayjones.plus.com>,
	Junio C Hamano <gitster@pobox.com>,
	Patrick Steinhardt <ps@pks.im>,
	Eli Schwartz <eschwartz@gentoo.org>,
	=?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= <congdanhqx@gmail.com>
Subject: [PATCH v3 3/5] meson: correct path to system config/attribute files
Date: Fri, 16 May 2025 19:48:41 +0100
Message-ID: <20250516184843.1524925-4-ramsay@ramsayjones.plus.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250516184843.1524925-1-ramsay@ramsayjones.plus.com>
References: <20250513191739.1513460-1-ramsay@ramsayjones.plus.com>
 <20250516184843.1524925-1-ramsay@ramsayjones.plus.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4xfC4LssCN1vL5OZ1Pq8ij5WTzJfk2WDnnVe9ai3BPhDoc+vs/eJr7iPlSP5y/+q+figDFcrne7+6gFH5S8mGsL/7w+1XTcrdUqygS0pHHvssfZgh8Zr29
 ESGxSbGEkltZEPoZWMRlSUwypu5I3xCYEN1TA+Jys5hFF0ey4GM5AlJc+AI+afkoVhRVh3Foznp+PaXTDb1FA2Vc4JkQrltnwXA=

The path to the system-wide config and attributes files are not being
set correctly in the meson build. Unless explicitly overridden on the
command line during setup, the 'gitconfig' and 'gitattributes' options
are defaulting to absolute paths in the '/etc' system directory. This
is only appropriate if the <prefix> is set specifically to '/usr'.

The directory in which these files are placed is generally referred to
as the 'system configuration directory' or 'sysconfdir' for short. When
the prefix is '/usr' then the sysconfdir is usually set to '/etc', but
any other value for prefix results in the relative directory value 'etc'
instead. (eg if prefix is '/usr/local', then the 'etc' relative value
results in a system configuration directory of '/usr/local/etc'). When
setting the 'sysconfdir' builtin option value, the meson system uses
exactly this algorithm, so we can use get_option('sysconfdir') directly
when setting the (non-overridden) build variables.

In order to allow for overriding from the command line, remove the
default values specified for the 'gitconfig' and 'gitattributes' options
in the 'meson_options.txt' file. This allows the user to specify any
pathname for those options, while being able to test for the unset
(empty) value. An absolute pathname will be used unchanged and a relative
pathname will be appended to '<prefix>/'. These values are then used to
set the 'ETC_GITCONFIG' and 'ETC_GITATTRIBUTES' build variables which are,
in turn, passed to the compiler as '-D' arguments.

When the 'gitconfig' or 'gitattributes' options are not used, then use
the built-in 'sysconfdir' and set the ETC_GITCONFIG build variable to
the string "<sysconfdir>/gitconfig". Similarly, set ETC_ATTRIBUTES to
"<sysconfdir>/gitattributes".

Signed-off-by: Ramsay Jones <ramsay@ramsayjones.plus.com>
---
 meson.build       | 16 ++++++++++++++--
 meson_options.txt |  8 ++++----
 2 files changed, 18 insertions(+), 6 deletions(-)

diff --git a/meson.build b/meson.build
index 48f31157a0..8e8f228a37 100644
--- a/meson.build
+++ b/meson.build
@@ -757,8 +757,6 @@ endif
 libgit_c_args = [
   '-DBINDIR="' + get_option('bindir') + '"',
   '-DDEFAULT_GIT_TEMPLATE_DIR="' + get_option('datadir') / 'git-core/templates' + '"',
-  '-DETC_GITATTRIBUTES="' + get_option('gitattributes') + '"',
-  '-DETC_GITCONFIG="' + get_option('gitconfig') + '"',
   '-DFALLBACK_RUNTIME_PREFIX="' + get_option('prefix') + '"',
   '-DGIT_HOST_CPU="' + host_machine.cpu_family() + '"',
   '-DGIT_HTML_PATH="' + get_option('datadir') / 'doc/git-doc"',
@@ -769,6 +767,20 @@ libgit_c_args = [
   '-DSHELL_PATH="' + fs.as_posix(target_shell.full_path()) + '"',
 ]
 
+system_attributes = get_option('gitattributes')
+if system_attributes != ''
+  libgit_c_args += '-DETC_GITATTRIBUTES="' + system_attributes + '"'
+else
+  libgit_c_args += '-DETC_GITATTRIBUTES="' + get_option('sysconfdir') / 'gitattributes"'
+endif
+
+system_config = get_option('gitconfig')
+if system_config != ''
+  libgit_c_args += '-DETC_GITCONFIG="' + system_config + '"'
+else
+  libgit_c_args += '-DETC_GITCONFIG="' + get_option('sysconfdir') / 'gitconfig"'
+endif
+
 editor_opt = get_option('default_editor')
 if editor_opt != '' and editor_opt != 'vi'
   libgit_c_args += '-DDEFAULT_EDITOR="' + editor_opt + '"'
diff --git a/meson_options.txt b/meson_options.txt
index 8547c0eb47..7a4b896f7e 100644
--- a/meson_options.txt
+++ b/meson_options.txt
@@ -3,10 +3,10 @@ option('default_pager', type: 'string', value: 'less',
   description: 'Fall-back pager.')
 option('default_editor', type: 'string', value: 'vi',
   description: 'Fall-back editor.')
-option('gitconfig', type: 'string', value: '/etc/gitconfig',
-  description: 'Path to the global git configuration file.')
-option('gitattributes', type: 'string', value: '/etc/gitattributes',
-  description: 'Path to the global git attributes file.')
+option('gitconfig', type: 'string', # default 'etc/gitconfig'
+  description: 'Path to the global git configuration file. (default: etc/gitconfig)')
+option('gitattributes', type: 'string', # default 'etc/gitattributes'
+  description: 'Path to the global git attributes file. (default: etc/gitattributes)')
 option('pager_environment', type: 'string', value: 'LESS=FRX LV=-c',
   description: 'Environment used when spawning the pager')
 option('perl_cpan_fallback', type: 'boolean', value: true,
-- 
2.49.0

