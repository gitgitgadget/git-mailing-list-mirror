Received: from avasout-peh-003.plus.net (avasout-peh-003.plus.net [212.159.14.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41C63F9E8
	for <git@vger.kernel.org>; Sat, 15 Mar 2025 02:48:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.159.14.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742006938; cv=none; b=PPjA4DXzi5xte+migdZ8po1kgYVxHIXJMoSoDZiNtxH5j3K/m8U30n9BM3cbM3ZDYl0WOQTi/84e/kq/51AYaAIHWDAaygYuXLQq64gvpHTSPjT5me7c1cRtaV081yrVnnH48Cl+mcl0wbdBDl1SiXByJOzmdgFvxEr/6737XTY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742006938; c=relaxed/simple;
	bh=5oCpXrNwQE/F1s0fYdugcuHjjdlsUH8hlFtVY732XAw=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=LJVBC7UKHdDvRquZULvjF7RILyEMaStlRe+SbH3WsYZbWY0uvQyOZu2q0/tePJtT7Dh8e9l7UGhxIhoTr/1EgGNr9Mu3HBryCLOv8RyF4oWe99W3kFqtaHBCHUhwJ9FWIvSYd/v05P2Tef23io0+PkTIY5/qmNEDhdLU67sM9zI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ramsayjones.plus.com; spf=none smtp.mailfrom=ramsayjones.plus.com; dkim=pass (2048-bit key) header.d=plus.com header.i=@plus.com header.b=SStYe9gh; arc=none smtp.client-ip=212.159.14.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ramsayjones.plus.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ramsayjones.plus.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=plus.com header.i=@plus.com header.b="SStYe9gh"
Received: from [10.0.2.15] ([80.189.83.109])
	by smtp with ESMTPA
	id tHa2tGN0jvxWAtHa3teQCP; Sat, 15 Mar 2025 02:48:55 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=plus.com; s=042019;
	t=1742006935; bh=S1WoaTkJIgo0thKCJsURAR5c8nT8Bk170pV6YSTBVEs=;
	h=Date:To:Cc:From:Subject;
	b=SStYe9ghH9YeQGEd6ZxSqi0HIAAge+H+uWyGGECtlt03Q4I/WnzjUjzFiwC3Embat
	 2X1FGUf+JhimJpDgX5ZssRZE7F9hlrXmfvMvSnf5M5fJw6mFtMgIZA8vmNdjSngHKR
	 lg5Ujzv/HNf8LLoj8IwQEQLjPCmyf65P9Xoj56fCKBKB74BYp+TRKaWLQTzBSECfIz
	 Zs8zoqSxC1B/TF3gF8+sHLd08aHGwzyL39KAvdC1+NDY27+eg4t3e/uAYnTp12s1Vk
	 /gEfJH18rFZYLtD8J27C7XJJHgnLqEG0IlCOnIfQGCz1Lx1xeN05XvrhZk6+YV6n6V
	 /l8GSKHdvdLuA==
X-Clacks-Overhead: "GNU Terry Pratchett"
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.4 cv=QbDFvdbv c=1 sm=1 tr=0 ts=67d4ea97
 a=oM5NSl/Bl4BpjFr0C8iQlQ==:117 a=oM5NSl/Bl4BpjFr0C8iQlQ==:17
 a=IkcTkHD0fZMA:10 a=EBOSESyhAAAA:8 a=BBq10iSe0tsV5BCVkB8A:9 a=QEXdDO2ut3YA:10
 a=yJM6EZoI5SlJf8ks9Ge_:22
X-AUTH: ramsayjones@:2500
Message-ID: <13072bf7-c710-47e1-9996-f886e9029f02@ramsayjones.plus.com>
Date: Sat, 15 Mar 2025 02:48:54 +0000
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Junio C Hamano <gitster@pobox.com>
Cc: GIT Mailing-list <git@vger.kernel.org>, Patrick Steinhardt <ps@pks.im>,
 Adam Dinwoodie <git@dinwoodie.org>
From: Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: [PATCH 10/12] config.mak.uname: add sysinfo() configuration for
 cygwin
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4xfOwE8vCr4tKxVlb/dnScerGmBvvvInMutPJMirDtos/DvTgqBYAAuOlBWYWenZIs4yXuqNmAGJNQ8F2iZwrVMTZdUeW/gCginUokeDKhVj6gQUeN7cKs
 63DqJ2zpPR0b821eYSW08fZStX91lvq3g+ABIhxrHY5wShC24tQ2TesHdV3Afk4FgFXw3NU2yQqDQUxSt3g/pHrLWn3SBw6pOD4=


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
