Received: from avasout-ptp-003.plus.net (avasout-ptp-003.plus.net [84.93.230.244])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 368E024BCE8
	for <git@vger.kernel.org>; Wed, 16 Apr 2025 23:20:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=84.93.230.244
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744845604; cv=none; b=XlIuZ3FyKhC91g3CnxLmPpGDx0ymRUN9CmQTZjRSx29i1RBIbNgWQ7DxIRc+I0cuA+sscTfEejATmmj5406oEJ3GOrSI7xZwHI+XX0AbZetsPGqfOy6mjaFmuvDISz4TGBM/7N/gWUGMU3VZViKKxGU2WByl1jbvgNg0b4aEZtM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744845604; c=relaxed/simple;
	bh=zS7i86CmT3CrBtSa8OBiaADBDHOAqd7BzmJUnCWT9kI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=L0U8KZuCTSPlLRtACxpTyoOsBWmI8yoAZdRE/oKddyGdmogdtRBGikV/e/dJuKyRWuL+xoyRf2HnP2AQsqNKvPzrl2eWEFuniCMwxKkG6xb1vERXTtLM1zfLrLmhLbGCxY+ja9GpCteJ+V+8aiA7ZbruNyZaMmCzEoPrcR6XOLQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ramsayjones.plus.com; spf=none smtp.mailfrom=ramsayjones.plus.com; dkim=pass (2048-bit key) header.d=plus.com header.i=@plus.com header.b=SMkN2EsG; arc=none smtp.client-ip=84.93.230.244
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ramsayjones.plus.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ramsayjones.plus.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=plus.com header.i=@plus.com header.b="SMkN2EsG"
Received: from localhost.localdomain ([80.189.83.109])
	by smtp with ESMTPA
	id 5C1quLy9hjZe55C2zu8KPz; Thu, 17 Apr 2025 00:20:01 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=plus.com; s=042019;
	t=1744845601; bh=YQnwBgfsuMWRYXEKjgIozYJq96VlRTiTV1hgXsoxbu4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=SMkN2EsGzvLtNiMV7OpUOR8bUW+bRfEWjPn2b3eik07MtH3g3LJYEcCWK+Gs11v1L
	 vOTzTVipYTrNScaJWTkE4MVacloHvElwIzTa0CWm/dlDmYmXYrmQily0S4JKwfMyco
	 VzYEO2vEZLzHzSUPmeHPu+mch18XrneRuvOYt/pOfORxMMAFEXJ6IfP2Hb0DqY7Ti2
	 VGh5xWEgnAlY5dLojjs06CWRMw+MfNH19EsXxbWKZ6H6o/i6IGLnnBXYhXWYIok68V
	 PeoM+7TdFp2Z/JHNzUciKGoLlmzXaOOfR2fuodaV771s4V1u6sGwRF+pzQoOFSz+yj
	 VDugUbNU80N+Q==
X-Clacks-Overhead: "GNU Terry Pratchett"
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.4 cv=UuDANPwB c=1 sm=1 tr=0 ts=68003b21
 a=oM5NSl/Bl4BpjFr0C8iQlQ==:117 a=oM5NSl/Bl4BpjFr0C8iQlQ==:17 a=EBOSESyhAAAA:8
 a=BBq10iSe0tsV5BCVkB8A:9 a=yJM6EZoI5SlJf8ks9Ge_:22
X-AUTH: ramsayjones@:2500
From: Ramsay Jones <ramsay@ramsayjones.plus.com>
To: GIT Mailing-list <git@vger.kernel.org>
Cc: Junio C Hamano <gitster@pobox.com>,
	Patrick Steinhardt <ps@pks.im>,
	Adam Dinwoodie <git@dinwoodie.org>,
	Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: [PATCH v3 11/13] config.mak.uname: add sysinfo() configuration for cygwin
Date: Thu, 17 Apr 2025 00:18:32 +0100
Message-ID: <20250416231835.2492562-12-ramsay@ramsayjones.plus.com>
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
X-CMAE-Envelope: MS4xfKcQSoaBRpRU57rF/4tU/aB1wqIhe45Mrttr3jFYnwNBQiu1R6w5cW/094Jb7OqJKSk3fNyrNsdNUFJ//Inkx8lrY1EhAIjF1ifdO6z7S+6Il2jWuxsv
 GBBp3UgG0cUgVr5WApek8Ltn8rC0ggVC479hrMOFz2C6353f0SWpuLQ9JptI4HQCKP0MUx3Arohh2y8P9eZBidX+157ibG2o0fI=

Although sysinfo() is a 'Linux only' function, cygwin provides an
implementation which appears to be functional. The assumption that
this function is Linux only is reflected in the way the HAVE_SYSINFO
build variable is handled by the Makefile and config.mak.uname.

Rework the setting of HAVE_SYSINFO in the Linux section of the system
specific config file, along with the corresponding setting of the
BASIC_CFLAGS in the Makefile. Add the setting of HAVE_SYSINFO to the
cygwin section of 'config.mak.uname'. While here, add a test for the
sysinfo() function to the autoconf build system.

Signed-off-by: Ramsay Jones <ramsay@ramsayjones.plus.com>
---
 Makefile         | 4 ++++
 config.mak.uname | 3 ++-
 configure.ac     | 8 ++++++++
 3 files changed, 14 insertions(+), 1 deletion(-)

diff --git a/Makefile b/Makefile
index 8fa4d2664e..ff89f2b81f 100644
--- a/Makefile
+++ b/Makefile
@@ -2168,6 +2168,10 @@ ifdef HAVE_SYNC_FILE_RANGE
 	BASIC_CFLAGS += -DHAVE_SYNC_FILE_RANGE
 endif
 
+ifdef HAVE_SYSINFO
+	BASIC_CFLAGS += -DHAVE_SYSINFO
+endif
+
 ifdef HAVE_BSD_SYSCTL
 	BASIC_CFLAGS += -DHAVE_BSD_SYSCTL
 endif
diff --git a/config.mak.uname b/config.mak.uname
index d058b34292..e7bd07cf6e 100644
--- a/config.mak.uname
+++ b/config.mak.uname
@@ -58,7 +58,7 @@ ifeq ($(uname_S),Linux)
 	HAVE_SYNC_FILE_RANGE = YesPlease
 	HAVE_GETDELIM = YesPlease
 	FREAD_READS_DIRECTORIES = UnfortunatelyYes
-	BASIC_CFLAGS += -DHAVE_SYSINFO
+	HAVE_SYSINFO = YesPlease
 	PROCFS_EXECUTABLE_PATH = /proc/self/exe
 	HAVE_PLATFORM_PROCINFO = YesPlease
 	COMPAT_OBJS += compat/linux/procinfo.o
@@ -253,6 +253,7 @@ ifeq ($(uname_O),Cygwin)
 	HAVE_GETDELIM = YesPlease
 	HAVE_CLOCK_GETTIME = YesPlease
 	HAVE_CLOCK_MONOTONIC = YesPlease
+	HAVE_SYSINFO = YesPlease
 	HAVE_ALLOCA_H = YesPlease
 	NEEDS_LIBICONV = YesPlease
 	NO_FAST_WORKING_DIRECTORY = UnfortunatelyYes
diff --git a/configure.ac b/configure.ac
index 5923edc44a..d7e0503f1e 100644
--- a/configure.ac
+++ b/configure.ac
@@ -1066,6 +1066,14 @@ AC_CHECK_LIB([iconv], [locale_charset],
        [AC_CHECK_LIB([charset], [locale_charset],
                      [CHARSET_LIB=-lcharset])])
 GIT_CONF_SUBST([CHARSET_LIB])
+
+#
+# Define HAVE_SYSINFO=YesPlease if sysinfo is available.
+GIT_CHECK_FUNC(sysinfo,
+	[HAVE_SYSINFO=YesPlease],
+	[HAVE_SYSINFO=])
+GIT_CONF_SUBST([HAVE_SYSINFO])
+
 #
 # Define HAVE_CLOCK_GETTIME=YesPlease if clock_gettime is available.
 GIT_CHECK_FUNC(clock_gettime,
-- 
2.49.0

