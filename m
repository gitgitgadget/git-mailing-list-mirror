Received: from avasout-peh-003.plus.net (avasout-peh-003.plus.net [212.159.14.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FE2C2857F2
	for <git@vger.kernel.org>; Mon, 19 May 2025 16:29:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.159.14.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747672160; cv=none; b=kVlwocPRK3e5K21Sua4c6vN3oPz4lOMkxWONlLyU68crV772NymdffksdMz2ad4WFyH7q9Rf7wsIP6Kl6jmqC2jViNbKPQb9RIjKZ8/0ijcA7Uxv/VGL3SazVge716U04FHTx6/qP8Cy6P3ZMa5H0eIkMdCt8nYnekhTVj5w1FY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747672160; c=relaxed/simple;
	bh=BUXmKzduzbu2UILq1QbjV/LJ1hrEGvPjYPUhBQYqWPE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kBOy4MYgh7QNxrCQ4NURkLTQ7ivMiD2gnbNtvvpN/l02XyK2aP8g6tAIQkPTUKeMUTf2+YOkcEnMRO4hoT2Y5MHVqkEjNUeBRAhg5bbyAD+5+8KNYo0bFUICTLSy9y6/79/53F0o76iGIvA6dS1jJqhAuK9+Gw8sW8euKSRd4DE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ramsayjones.plus.com; spf=none smtp.mailfrom=ramsayjones.plus.com; dkim=pass (2048-bit key) header.d=plus.com header.i=@plus.com header.b=S1W4aEXR; arc=none smtp.client-ip=212.159.14.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ramsayjones.plus.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ramsayjones.plus.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=plus.com header.i=@plus.com header.b="S1W4aEXR"
Received: from localhost.localdomain ([80.189.83.109])
	by smtp with ESMTPA
	id H3J4um35fEe7cH3JhuD0Bb; Mon, 19 May 2025 17:26:17 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=plus.com; s=042019;
	t=1747671977; bh=hWU5GMfVM6uWvor4524qwh0o8AGP3IZDf8EmpG+xDpM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=S1W4aEXRLLqP2eo2TfBEjzPFK7G0X7RMkFGCHVnMM/sGaKS/EhoeyOhwM31ywXqBF
	 KSMdy8yNndFqZA+Frr/6hrbcrE2Cl+yx+qhao2nziHcUELF826LE5Gzw8oGRxtQZ/d
	 Ny991E2CBWOHsK1WXnIMrXGvJWFz8T93RVclmjyhka6M0hfiw6IM2KsIYDl0wzvZ+J
	 kVP4o4fYZqywE9YfqWAtEh7nIoYrS2PpXxW80q/i3td36Sa0BvBTaWkv1mDcbUb/QD
	 vIJ+uu1dZJulvnY1UEXV4J9anB4H/Y0jVfCCayCHh1cz3HueahfdHJY5qGSxwrXppC
	 WkqxvL0xQQjVA==
X-Clacks-Overhead: "GNU Terry Pratchett"
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.4 cv=BeN70at2 c=1 sm=1 tr=0 ts=682b5ba9
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
Subject: [PATCH v4 5/5] configure.ac: upgrade to a compilation check for sysinfo
Date: Mon, 19 May 2025 17:25:23 +0100
Message-ID: <20250519162523.1001478-6-ramsay@ramsayjones.plus.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250519162523.1001478-1-ramsay@ramsayjones.plus.com>
References: <20250516184843.1524925-1-ramsay@ramsayjones.plus.com>
 <20250519162523.1001478-1-ramsay@ramsayjones.plus.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4xfNiN3eLDC32pGap2yiX5TEO9HY3QhNEmyA1bWyba4e56b4xf6GxEAx0xY5I9bkS2eddDaUxe76WEwzrzsfA3qfIXtu62lBc2XZCdMl74BRKEgxjHZrK9
 /52zg4XXWa7EiVVxJSm4Jm1vvdqQXQRMxJ6uxQk2CepKBjngtMsWyy1vwUORWQaIGPaayv2L8M19om03E1WdmvoDmOTa11XElB4=

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

