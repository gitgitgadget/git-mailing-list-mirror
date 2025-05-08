Received: from avasout-ptp-002.plus.net (avasout-ptp-002.plus.net [84.93.230.235])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EA2B1FCFDB
	for <git@vger.kernel.org>; Thu,  8 May 2025 16:49:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=84.93.230.235
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746722956; cv=none; b=RkyjB9KEtNycJ6K8X+aSckxOMqDU6i98R7Oc6Ujz1FJTwm19C7pVrd2hiZ0emId2LTzvkkuY+FTqa7943pNl8gagqRmG6i5F2H/l8gr1IJ8RlxYTz+UO8oafOwqplMeYO6NlC5YRV+7GRa+GoKo/sy+bZaxCAkKsNexF1ESdi9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746722956; c=relaxed/simple;
	bh=BUXmKzduzbu2UILq1QbjV/LJ1hrEGvPjYPUhBQYqWPE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Yu7rnhzMXQ/RygSa2qGlru35CNBLggDLTsE3mMEZB6Y0T1h2hkJdNLLOG+CLXYNkGzYXefUSeElpvqpsz4duIv4wf1vKW/VJK8cvogXS8kw7+Te6cXinaCHPtVxUba10wORzJouYKjfANgitunw0Q3Qf4Q5CLRcC6vDyvpDofoc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ramsayjones.plus.com; spf=none smtp.mailfrom=ramsayjones.plus.com; dkim=pass (2048-bit key) header.d=plus.com header.i=@plus.com header.b=KC/x0Gvh; arc=none smtp.client-ip=84.93.230.235
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ramsayjones.plus.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ramsayjones.plus.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=plus.com header.i=@plus.com header.b="KC/x0Gvh"
Received: from localhost.localdomain ([80.189.83.109])
	by smtp with ESMTPA
	id D4MzuXnvmeYyCD4NxuuAhM; Thu, 08 May 2025 17:46:13 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=plus.com; s=042019;
	t=1746722773; bh=hWU5GMfVM6uWvor4524qwh0o8AGP3IZDf8EmpG+xDpM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=KC/x0GvhU5ULs0ebhy7aHOMNY+ZCA3X0+adz/WaIJdmH7B4XxTNgb2Nr6T+r8BRE5
	 4tpiadZ1viOUrQB/2Bvbsyg75Y3j+mG1bd/2EbLWGyp55sYQVyJLm9uJ5b3O6blvRg
	 pKe8iM+ikFEue45DvhNq6WovK+E+migKWPI//yusxgx0HDuOaphnVTSvG5UUYB540m
	 wfrvHucPqE4RNh7qmFRSY7rZzvbh2iE29xRdUiQC4WDtd+uos0XVdBXZ4RleefJqqJ
	 7beeMC5PpVv79gsbWWjbSDY2uqu4pbp2xa2aBlMG/VHi6NNms/CFcRH9cTJLOieNKP
	 lIX8HP9Sc4mlw==
X-Clacks-Overhead: "GNU Terry Pratchett"
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.4 cv=ac7Cngot c=1 sm=1 tr=0 ts=681cdfd5
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
Subject: [PATCH 5/5] configure.ac: upgrade to a compilation check for sysinfo
Date: Thu,  8 May 2025 17:44:39 +0100
Message-ID: <20250508164443.1506440-6-ramsay@ramsayjones.plus.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250508164443.1506440-5-ramsay@ramsayjones.plus.com>
References: <20250508164443.1506440-1-ramsay@ramsayjones.plus.com>
 <20250508164443.1506440-2-ramsay@ramsayjones.plus.com>
 <20250508164443.1506440-3-ramsay@ramsayjones.plus.com>
 <20250508164443.1506440-4-ramsay@ramsayjones.plus.com>
 <20250508164443.1506440-5-ramsay@ramsayjones.plus.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4xfCJNJOEJuOZJc5aSpjWdhrn7tz+yo9N97+9F/gRyz77Waq8wDg0NP8X1CzpeLFY67W1DIGleetvKqo6iX85kq9poQtEjCIKKSES+lotyhAyYFfXDzqUt
 jFzlIspslV8QHfKIH6REx6TSAowtqlBTo6UubtHFHynP0kxC+hFHBLrlh5MA5THMsKGuOYw0L/ZxxABOCCkFNJsmR0HG23g7RmA=

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

