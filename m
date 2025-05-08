Received: from avasout-ptp-002.plus.net (avasout-ptp-002.plus.net [84.93.230.235])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 488FC20CCC3
	for <git@vger.kernel.org>; Thu,  8 May 2025 16:48:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=84.93.230.235
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746722940; cv=none; b=ZO1OzmVX5U89QROhFswkxjITe/DO2L8U4vXTjEzFiZbHeLzfKEo1ZtvuxUsh3GMzJHTsj2ZniyYfVSqMQcH1widYKKBks2J1MFiCpUjn92etejlh+HpjvrmF0/unpgSuAMl5Hko5yQS6ir1tG2jsOrJytAgeNfqpjvYp+5mO2VA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746722940; c=relaxed/simple;
	bh=HQkdK3ajA5uY3XCeNTYBUkBz3emoCXPYneIAAow/rtQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZJEyAcNC0ShVZ/eaIddKM8WIQBQs3omo1UoC2wN3UXPSRYEAjoqTo5nlJNAwHGkpX/Sn6nS9EgVMSXMcIcN2usG82BwqNqIw31u+V+yLe2i4L1oQWQiqG7u9zT1eRcocm4cVWZeMgyBQOKekbzM0iajj2hkdN/QtnbZZEHcNCAg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ramsayjones.plus.com; spf=none smtp.mailfrom=ramsayjones.plus.com; dkim=pass (2048-bit key) header.d=plus.com header.i=@plus.com header.b=XQmqgL71; arc=none smtp.client-ip=84.93.230.235
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ramsayjones.plus.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ramsayjones.plus.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=plus.com header.i=@plus.com header.b="XQmqgL71"
Received: from localhost.localdomain ([80.189.83.109])
	by smtp with ESMTPA
	id D4MzuXnvmeYyCD4NiuuAhA; Thu, 08 May 2025 17:45:58 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=plus.com; s=042019;
	t=1746722758; bh=umAUgsWjetEWmz/Npy0MSGeJdyMM9xtwHCc7Rvw/n2Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=XQmqgL71e4eoRe8pyoNbGk6CUtD1FnCYXfuNEFwaI7qynJvzIeSkd087Nm87fCnuX
	 j5yOgdYJbrG/vkQEM47B5Q2oOB+gphYi+6bNMovi2+rGkg7nLysMAGIDitQSBY417U
	 6DhA321RpFsTk7c+lZzTJ/95oqg6n7hEmJ/CmQJngfyFzfNZOBDMx90GwN0/Vo0uzw
	 Ygi2Kqy5mG4F4aYPbPHFEBi5dsAvq1FKkszsPfohdZufxZ73NwcN889yrCwMHYD0sS
	 iF3OneX3/p94AggOyWNeEfBoColSyC3LxO+zCAfNYARP/MQXSUQ48uJ1kihHyhpPfn
	 D3zIm4jDpX7Bg==
X-Clacks-Overhead: "GNU Terry Pratchett"
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.4 cv=ac7Cngot c=1 sm=1 tr=0 ts=681cdfc6
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
Subject: [PATCH 3/5] meson: correct path to system config/attribute files
Date: Thu,  8 May 2025 17:44:37 +0100
Message-ID: <20250508164443.1506440-4-ramsay@ramsayjones.plus.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250508164443.1506440-3-ramsay@ramsayjones.plus.com>
References: <20250508164443.1506440-1-ramsay@ramsayjones.plus.com>
 <20250508164443.1506440-2-ramsay@ramsayjones.plus.com>
 <20250508164443.1506440-3-ramsay@ramsayjones.plus.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4xfE6suwTCR2aCOtDl862FGW/sNc6XaRIQj2GtVdM61r9Efou6jFUNG4cP4SD6tl7SQxtXCN5I1nEE7Jlzx5IlHIp/jpvijlOlBwEToidsMjspXkGJKl5Z
 mtOcGOFWBMrqKvq+S5Ebjt0zv+mQmsskOnOmtpse6622lnpF73pIFutARQxLXaN9aG0I7+s5bOTxmxIo74a9aH2KDrv8mX0Eh8U=

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
 meson.build       | 14 ++++++++++++--
 meson_options.txt |  4 ++--
 2 files changed, 14 insertions(+), 4 deletions(-)

diff --git a/meson.build b/meson.build
index 48f31157a0..106cb17612 100644
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
@@ -769,6 +767,18 @@ libgit_c_args = [
   '-DSHELL_PATH="' + fs.as_posix(target_shell.full_path()) + '"',
 ]
 
+system_attributes = get_option('gitattributes')
+if system_attributes != ''
+  libgit_c_args += '-DETC_GITATTRIBUTES="' + system_attributes + '"'
+else
+  libgit_c_args += '-DETC_GITATTRIBUTES="' + get_option('sysconfdir') + '/gitattributes"'
+endif
+system_config = get_option('gitconfig')
+if system_config != ''
+  libgit_c_args += '-DETC_GITCONFIG="' + system_config + '"'
+else
+  libgit_c_args += '-DETC_GITCONFIG="' + get_option('sysconfdir') + '/gitconfig"'
+endif
 editor_opt = get_option('default_editor')
 if editor_opt != '' and editor_opt != 'vi'
   libgit_c_args += '-DDEFAULT_EDITOR="' + editor_opt + '"'
diff --git a/meson_options.txt b/meson_options.txt
index 8547c0eb47..4d78d4c7ac 100644
--- a/meson_options.txt
+++ b/meson_options.txt
@@ -3,9 +3,9 @@ option('default_pager', type: 'string', value: 'less',
   description: 'Fall-back pager.')
 option('default_editor', type: 'string', value: 'vi',
   description: 'Fall-back editor.')
-option('gitconfig', type: 'string', value: '/etc/gitconfig',
+option('gitconfig', type: 'string',
   description: 'Path to the global git configuration file.')
-option('gitattributes', type: 'string', value: '/etc/gitattributes',
+option('gitattributes', type: 'string',
   description: 'Path to the global git attributes file.')
 option('pager_environment', type: 'string', value: 'LESS=FRX LV=-c',
   description: 'Environment used when spawning the pager')
-- 
2.49.0

