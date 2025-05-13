Received: from avasout-ptp-004.plus.net (avasout-ptp-004.plus.net [84.93.230.250])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40C1D2BFC7A
	for <git@vger.kernel.org>; Tue, 13 May 2025 19:21:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=84.93.230.250
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747164095; cv=none; b=UpLGEGkZvRCh+U253pZBIvsSqj6Cnxk1KYOmaxd077/wZHABKWtuOlpPGLSLx5s87OwF5ZseVw2dQFM2/bt3Hw2h+0ZyKtsKVmaoyiGHIBZApYgqaYU2GfBGR0mL3N8/gX5VYpFVXXAvM6JX0lrRhHcMqX+WZzfOtPSDDqaN4hI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747164095; c=relaxed/simple;
	bh=gBK3fxJ8Rfgu2evrONWFutRNrVzTjz1cg46uYxfLj7c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Uh9PGRWq2DsGQByGkLEOh5VjO3paRIdvg78NbZZt3gBNvvWWt5dho9zdzK/wqvZoRC5iqzDxK9fKDJ+7vzYnDgPeXcF/ar69iRXPBjwmDpRzEUvaDNsgLozu36jkXOdG4eSDQzAW1oJ1mv7oO0ssdaFxwuf+zikd+EaSSIXicTU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ramsayjones.plus.com; spf=none smtp.mailfrom=ramsayjones.plus.com; dkim=pass (2048-bit key) header.d=plus.com header.i=@plus.com header.b=UdObkRC8; arc=none smtp.client-ip=84.93.230.250
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ramsayjones.plus.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ramsayjones.plus.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=plus.com header.i=@plus.com header.b="UdObkRC8"
Received: from localhost.localdomain ([80.189.83.109])
	by smtp with ESMTPA
	id Ev8Rub969aTZGEv95uZHsH; Tue, 13 May 2025 20:18:33 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=plus.com; s=042019;
	t=1747163913; bh=seJGXXuaU9kXKee3toweNPBrzXlCTymhFPaCgpk5lmw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=UdObkRC82BQAOmEidHy2RXUyusMvHsRJHWH3cWO0R8C8si1ToSUOP5ZG2IiTJjIoL
	 D0nLWwcX0hr8DTyB71TFeaya4hO9laDuWeOXKaiCFcN1rXEXBEMk0dQa+HkuZZLus1
	 UBtTd0pw1RDn5ebiUX1QcQYnDPup4rDgMaJoPl9cUwP/B3mhYwo/xYNA3E6U/ZeY6q
	 3RJ2oi6MEMaORaKyQWLnI7ama1xa7WGyClWafCGIZFTlPZhrMiZjqZ5M8WiXxqLKMT
	 GI/qG44JkCYsCnmftKfa8oXewN6L3GZ0o7+NhyhP6h1AhVPosKscistcfq4l4/1f0e
	 IxbA03mf/MSxw==
X-Clacks-Overhead: "GNU Terry Pratchett"
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.4 cv=V9ne0vni c=1 sm=1 tr=0 ts=68239b09
 a=oM5NSl/Bl4BpjFr0C8iQlQ==:117 a=oM5NSl/Bl4BpjFr0C8iQlQ==:17 a=EBOSESyhAAAA:8
 a=PEHzl5tTKJwClwjWz-kA:9 a=yJM6EZoI5SlJf8ks9Ge_:22
X-AUTH: ramsayjones@:2500
From: Ramsay Jones <ramsay@ramsayjones.plus.com>
To: 'GIT Mailing-list ' <git@vger.kernel.org>
Cc: Ramsay Jones <ramsay@ramsayjones.plus.com>,
	Junio C Hamano <gitster@pobox.com>,
	Patrick Steinhardt <ps@pks.im>,
	Eli Schwartz <eschwartz@gentoo.org>,
	=?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= <congdanhqx@gmail.com>
Subject: [PATCH v2 5/5] configure.ac: upgrade to a compilation check for sysinfo
Date: Tue, 13 May 2025 20:17:26 +0100
Message-ID: <20250513191739.1513460-6-ramsay@ramsayjones.plus.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250513191739.1513460-1-ramsay@ramsayjones.plus.com>
References: <20250508164443.1506440-1-ramsay@ramsayjones.plus.com>
 <20250513191739.1513460-1-ramsay@ramsayjones.plus.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4xfLCF4J23Hx2DR/zVUfNojopoekj+bRVWtQXNIPoh36BHWuCLUWjcrnfgfCuI2b2tM/ZsNbEjjQXBahZ8ZSpz0XObQ5afOcGksgAQKfcEVtW7JUQTS+PU
 5GqywsIClIA0b46eDQyBuMT58B60srP2iTS7HHGzan3NPixkhfiODk4XJ+o7MsDyUBjM20UQHJyrs8u6SRq5upEs4eL11lacT1M=

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
that just the header, but it will fail (incorrectly set HAVE_SYSINFO)
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

