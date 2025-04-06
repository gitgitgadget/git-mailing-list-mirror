Received: from avasout-ptp-001.plus.net (avasout-ptp-001.plus.net [84.93.230.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19AAD191F68
	for <git@vger.kernel.org>; Sun,  6 Apr 2025 19:40:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=84.93.230.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743968407; cv=none; b=Lp4/ow9rFLpnWEwc6RKyROEZa1paAt2wJoGEEFtnIZ2PrJ8F8kxl03VtgOX6GyimvleAC/etblOT93+SHQltypBt8UBpCJSOS3bI32NU95hUUBCfVwNmsnr7t+/XlkBFzvX+ZAYGKguKrVxnF7D1MUhadCrxqH5FBVRHAaUph94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743968407; c=relaxed/simple;
	bh=TjKhsMhJ1mexEcrV4NXpsRIo8NuJjR9DlutFZJ8egmg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KCXLmJwET7PQsyWNOXcGfKqH87qUNpu4HTqsO17qwvrM1klrft1jaTvMZFq1Yw9zyyXv/M5k/T7S1rzaSUV36WXZGYXGqFttPEypyMHT3m0MtgmeeOufar5C0uQOXMt2wSNGWcvz9/EuZhp6k3veZu6rDX35F/KDJFPxwIW/OTU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ramsayjones.plus.com; spf=none smtp.mailfrom=ramsayjones.plus.com; dkim=pass (2048-bit key) header.d=plus.com header.i=@plus.com header.b=ZAqqXoVP; arc=none smtp.client-ip=84.93.230.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ramsayjones.plus.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ramsayjones.plus.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=plus.com header.i=@plus.com header.b="ZAqqXoVP"
Received: from localhost.localdomain ([80.189.83.109])
	by smtp with ESMTPA
	id 1VpUuYqwzbpaN1VqeupkMG; Sun, 06 Apr 2025 20:40:04 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=plus.com; s=042019;
	t=1743968404; bh=fZqzkJ7jir9z0JVgHVQmrL/BwOPHWTAvL0dQT+xE1n4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ZAqqXoVP9pzr3wpen4ocgn3zOTZj1nUGou4muUrQBQyBOMR+2rCxV9VUJmuJJ9xQo
	 xzp59AaN4ViOHSXjRGmJ+qVse0OkbWbiD1hNZPpf3g+ckkYYgiSf8RvnH0DQe885vS
	 E7wWU0RukHNDYF7wANoe8XZMhsa2+7cArekkhfOe+nHPpeM/hhOf/zO6Hk8INh9y/+
	 XU4mkHhqcY4JD+XqSqDNdlq5prwdzaUa5d8s2Ej3ZCS/zVP3Et4vXw0doJ8R/gKpTj
	 sD0/QeMnxiStLJpPn5hUcgJ82YrdrQzqgVVYV9mC5I9hxxi6SegNV+ClHdXBHY4Y85
	 sdhclk8No7o4w==
X-Clacks-Overhead: "GNU Terry Pratchett"
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.4 cv=frZ/Z04f c=1 sm=1 tr=0 ts=67f2d894
 a=oM5NSl/Bl4BpjFr0C8iQlQ==:117 a=oM5NSl/Bl4BpjFr0C8iQlQ==:17 a=EBOSESyhAAAA:8
 a=BBq10iSe0tsV5BCVkB8A:9 a=yJM6EZoI5SlJf8ks9Ge_:22
X-AUTH: ramsayjones@:2500
From: Ramsay Jones <ramsay@ramsayjones.plus.com>
To: GIT Mailing-list <git@vger.kernel.org>
Cc: Junio C Hamano <gitster@pobox.com>,
	Patrick Steinhardt <ps@pks.im>,
	Adam Dinwoodie <git@dinwoodie.org>,
	Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: [PATCH v2 11/13] config.mak.uname: add sysinfo() configuration for cygwin
Date: Sun,  6 Apr 2025 20:38:37 +0100
Message-ID: <e45b9df3a43d0f862f1703a3af84c2a796e708f4.1743859985.git.ramsay@ramsayjones.plus.com>
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
X-CMAE-Envelope: MS4xfEz8tdwNfGRG8zvXNpNtG4Kcm9SjKt2HfQstFwgoiDYEuAESk8/2fi3SWuAYxmIUZWAXa62BWQQWhnFJQp7PtkYzHPBlCeA3eDA1YhQlPhSPdVRirnGx
 jMqVaYPVK1bQDxb35mkaO3U9y7rSn0N/Lazc1FDNt5DGKShAJ/hEcbNVRZD1dUCCq6Xh8+d3X0NaB+CJU2CoJJPbP5L25CPeh8I=

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
index 942550fb9e..0e29341056 100644
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
 	HAVE_CLOCK_GETTIME=YesPlease
 	HAVE_CLOCK_MONOTONIC=YesPlease
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

