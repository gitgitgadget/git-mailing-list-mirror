Received: from avasout-ptp-002.plus.net (avasout-ptp-002.plus.net [84.93.230.235])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A86C726B974
	for <git@vger.kernel.org>; Fri, 16 May 2025 18:49:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=84.93.230.235
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747421377; cv=none; b=NSbZw4KK9ykbY7gPx/2nVGlk4HLg0BkcoC1rji77GCmShpDkzCX+kdT/12bn35PSvdhuGMOSMf46syuOZpuQnq/bE4NKaRL4PesI1DFzbTsyDlDxFleHKNvXs8MaGVOuReoXOMA1xR1mpIYQ7XNzwO1LDF/dPkKCJk00KDq6qyE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747421377; c=relaxed/simple;
	bh=BUXmKzduzbu2UILq1QbjV/LJ1hrEGvPjYPUhBQYqWPE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=seWdixOUuspV+5A3dAc404QSnE6BoQ7le6zBG+an/7wrw3qJtIZMvkfYDSdScGhr+Zxr0r5jUA6GaTELE2k09Cw5uQ8kvMLYbWJ00Ovnh2unmLsIeAsGueVUxCyjcnkWFp2b3Az+3lJhT+6x9WjkDswr0X3dww8Rm+aeX+iCWFM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ramsayjones.plus.com; spf=none smtp.mailfrom=ramsayjones.plus.com; dkim=pass (2048-bit key) header.d=plus.com header.i=@plus.com header.b=J2YDI+l2; arc=none smtp.client-ip=84.93.230.235
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ramsayjones.plus.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ramsayjones.plus.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=plus.com header.i=@plus.com header.b="J2YDI+l2"
Received: from localhost.localdomain ([80.189.83.109])
	by smtp with ESMTPA
	id G071uFdJgJGekG07iuP0hw; Fri, 16 May 2025 19:49:35 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=plus.com; s=042019;
	t=1747421375; bh=hWU5GMfVM6uWvor4524qwh0o8AGP3IZDf8EmpG+xDpM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=J2YDI+l2OynW/K9t8W9T3z3PAUgI64nbxRX6lPWqkE6yuvqzZ4uMetd3JYrWXzcbH
	 cSDqCLylp7gQFnwg9XynOKFy3oQMk0LPI9jg6fbbHc7DhyW0ga2wKe2ZR0b8Ot8dIi
	 SM7GL6ppNaRGuXEbgLw4h7xRBi0XGBr0SW6BGEkE57OI8a+JcHjJfnSxwijMncQ0Ls
	 8S/uK19aQFp3RnYNtGFyqHBGNLobkI6V/Nq8n2rKUGVDLFMweeCiBXCDBWg+IhId4S
	 HtLr2i7PmjiVXrFK/DacjlBStZ0JXEvZhAbLNTBgJM85ESB1oqBVB+Pg9YYXDI5ACe
	 0LuN5l1OZQoKA==
X-Clacks-Overhead: "GNU Terry Pratchett"
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.4 cv=FoOm/Hrq c=1 sm=1 tr=0 ts=682788bf
 a=oM5NSl/Bl4BpjFr0C8iQlQ==:117 a=oM5NSl/Bl4BpjFr0C8iQlQ==:17 a=EBOSESyhAAAA:8
 a=PEHzl5tTKJwClwjWz-kA:9 a=yJM6EZoI5SlJf8ks9Ge_:22
X-AUTH: ramsayjones@:2500
From: Ramsay Jones <ramsay@ramsayjones.plus.com>
To: GIT Mailing-list <git@vger.kernel.org>
Cc: Ramsay Jones <ramsay@ramsayjones.plus.com>,
	Junio C Hamano <gitster@pobox.com>,
	Patrick Steinhardt <ps@pks.im>,
	Eli Schwartz <eschwartz@gentoo.org>,
	=?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= <congdanhqx@gmail.com>
Subject: [PATCH v3 5/5] configure.ac: upgrade to a compilation check for sysinfo
Date: Fri, 16 May 2025 19:48:43 +0100
Message-ID: <20250516184843.1524925-6-ramsay@ramsayjones.plus.com>
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
X-CMAE-Envelope: MS4xfN2KL7RDt58zVUUdEkYD65UhrQ22RP+NtPVLsqNIeJRXz1MN9CRnf31O90Etx4xZebCBhL/1XTZX87QKX/+kQLzFnpU7ATJwME6eClrzUkHg1UKQFDRn
 F9XYN/QCVKsK+AmR98SmfP+xVvq56cIGEu7ysSHUIpiv5g1DhamLl9S8QiQm1PXZDZrpgla1G7i4RPLdTtmw1k2ZUiYjaIddt98=

Commit f5e3c6c57d ("meson: do a full usage-based compile check for
sysinfo", 2025-04-25) updated the 'sysinfo()' check, as part of the
meson build, due to the failure of the check on Solaris. Prior to
that commit, the meson build only checked the availability of the
'<sys/sysinfo.h>' header file. On Solaris, both the header and the
'sysinfo()' function exist, but are completely unrelated to the same
function on Linux (and cygwin).

Commit 50dec7c566 ("config.mak.uname: add sysinfo() configuration for
cygwin", 2025-04-17) added a similar 'sysinfo()' check to the autoconf
build. This check looked for the 'sysinfo()' function itself, rather
than just the header, but it will fail (incorrectly set HAVE_SYSINFO)
for the same reason.

In order to correctly identify the 'sysinfo()' function we require as
part of 'git-gc' (used in the 'total_ram() function), we also upgrade
to a compilation check, in a similar way to the meson commit. Note that
since commit c9a51775a3 ("builtin/gc.c: correct RAM calculation when
using sysinfo", 2025-04-17) both the 'totalram' and 'mem_unit' fields
of the 'struct sysinfo' are used, so the new check includes both of
those fields in the compile check.

Signed-off-by: Ramsay Jones <ramsay@ramsayjones.plus.com>
---
 configure.ac | 25 ++++++++++++++++++++++---
 1 file changed, 22 insertions(+), 3 deletions(-)

diff --git a/configure.ac b/configure.ac
index d7e0503f1e..f6caab919a 100644
--- a/configure.ac
+++ b/configure.ac
@@ -1069,9 +1069,28 @@ GIT_CONF_SUBST([CHARSET_LIB])
 
 #
 # Define HAVE_SYSINFO=YesPlease if sysinfo is available.
-GIT_CHECK_FUNC(sysinfo,
-	[HAVE_SYSINFO=YesPlease],
-	[HAVE_SYSINFO=])
+#
+AC_DEFUN([HAVE_SYSINFO_SRC], [
+AC_LANG_PROGRAM([[
+#include <stdint.h>
+#include <sys/sysinfo.h>
+]], [[
+struct sysinfo si;
+uint64_t t = 0;
+if (!sysinfo(&si)) {
+	t = si.totalram;
+	if (si.mem_unit > 1)
+		t *= (uint64_t)si.mem_unit;
+}
+return t;
+]])])
+
+AC_MSG_CHECKING([for sysinfo])
+AC_COMPILE_IFELSE([HAVE_SYSINFO_SRC],
+	[AC_MSG_RESULT([yes])
+	HAVE_SYSINFO=YesPlease],
+	[AC_MSG_RESULT([no])
+	HAVE_SYSINFO=])
 GIT_CONF_SUBST([HAVE_SYSINFO])
 
 #
-- 
2.49.0

