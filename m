Received: from avasout-peh-003.plus.net (avasout-peh-003.plus.net [212.159.14.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DBA7F9E8
	for <git@vger.kernel.org>; Sat, 15 Mar 2025 02:49:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.159.14.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742006987; cv=none; b=EW2XuEmqK6Z/imoDfEk7rUu4s6hq5eZ9uK9lnkru/z0TfIqJzv9nq4FKbNpZ8bk+uGAw0ff9+YAwprP1ouDV+4fkgCXoTUl++FrPO1xmMcPmk6aG7QH+7+flQNKOtMuVwSoo5NfRVvUqUWwt/PvAFJMEImkWLx21LkMITGAWlK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742006987; c=relaxed/simple;
	bh=LmrNXdXX2i6/CoclEAvT4WDlMtLJtNLLCRamPs1SYmw=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=uI5mgdt5v4J//6RE6dWZ1nmC//Kn3dWUfNuQq36qoc+6ZOxlQa5WsjB2EoRUOK4MWKCB04RqKISg/x897Fzlwi99UmaGIfbkl77ALgDz//oA0WlgGuG0YdDJntCTdhECta2PW+ihgkWXfqZKeFO9Ra2EQsVtIlxxocYKjzOiSqU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ramsayjones.plus.com; spf=none smtp.mailfrom=ramsayjones.plus.com; dkim=pass (2048-bit key) header.d=plus.com header.i=@plus.com header.b=c9rWPpUV; arc=none smtp.client-ip=212.159.14.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ramsayjones.plus.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ramsayjones.plus.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=plus.com header.i=@plus.com header.b="c9rWPpUV"
Received: from [10.0.2.15] ([80.189.83.109])
	by smtp with ESMTPA
	id tHXvtGMpBvxWAtHXwteQBh; Sat, 15 Mar 2025 02:46:45 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=plus.com; s=042019;
	t=1742006805; bh=OxbwKqpgHgtPwvOTCtbz3Z4KvCrTEOuCAYfnxhCSsss=;
	h=Date:To:Cc:From:Subject;
	b=c9rWPpUVhkF1jisEMkdGFv1dUzCwdE7tfLDX4H1BFnzghRWiojXS5cGCquZre2FQg
	 ZRnIUslrTigV3PLgQgEWZd8glxKOokcN3CVeEusixkCumHBib2zHRNhd/fomSUmY80
	 OerckAyqfMM7hX0Ttiq2x2o4bV7jhlu6lFl8F+rq7rS/AXSMRfsV+20fDytsHzRtYk
	 PmA1ctNJFfq0iDfh1VebiBf7DAKc9MT31s87AGQ4RTxRT/roWB+/druYgC2x13lIfK
	 I7pI2R90fAWIIFLoodrHzEKlrsLzqBubbAGpyEA0n6i5M009hwf96AsekW4v76bqpS
	 KZZ3IbM3v66VQ==
X-Clacks-Overhead: "GNU Terry Pratchett"
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.4 cv=QbDFvdbv c=1 sm=1 tr=0 ts=67d4ea15
 a=oM5NSl/Bl4BpjFr0C8iQlQ==:117 a=oM5NSl/Bl4BpjFr0C8iQlQ==:17
 a=IkcTkHD0fZMA:10 a=EBOSESyhAAAA:8 a=UssqkuoP40Gt3Q7oBg4A:9 a=QEXdDO2ut3YA:10
 a=yJM6EZoI5SlJf8ks9Ge_:22
X-AUTH: ramsayjones@:2500
Message-ID: <ac4b7eda-1eba-4a6d-890f-49cbfb681da9@ramsayjones.plus.com>
Date: Sat, 15 Mar 2025 02:46:42 +0000
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
 Patrick Steinhardt <ps@pks.im>
From: Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: [PATCH 02/12] Makefile: only set some BASIC_CFLAGS when
 RUNTIME_PREFIX is set
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4xfHh80TfnQFCexYKxpHTwKCFkoB8nKzqbHY313jBuBFWU9K/comvhJ2NkZp+Vl7NMF9+04QPFqR6L6+N7fb5rbX6FbXnXbp1LS48AJUG5ZYWDk3moaSDA
 MJYF6g6liYGW57nDTK5bLpw3xl4Znicf4zngmRqgDzLvn1UvgO/3Ei0lE4kLcER/bPnO5WKi725yAaTcMdc6PXaI70UhQKfwRpQ=


Several build variables only have any meaning when the RUNTIME_PREFIX
variable has been set. In particular, the following build variables are
otherwise ignored:

    HAVE_BSD_KERN_PROC_SYSCTL
    PROCFS_EXECUTABLE_PATH
    HAVE_NS_GET_EXECUTABLE_PATH
    HAVE_ZOS_GET_EXECUTABLE_PATH
    HAVE_WPGMPTR

Make setting BASIC_CFLAGS, for each of these variables, conditional on
the RUNTIME_PREFIX being defined.

Signed-off-by: Ramsay Jones <ramsay@ramsayjones.plus.com>
---
 Makefile | 38 +++++++++++++++++++++-----------------
 1 file changed, 21 insertions(+), 17 deletions(-)

diff --git a/Makefile b/Makefile
index 7315507381..818dde32a9 100644
--- a/Makefile
+++ b/Makefile
@@ -2179,10 +2179,6 @@ ifdef HAVE_BSD_SYSCTL
 	BASIC_CFLAGS += -DHAVE_BSD_SYSCTL
 endif
 
-ifdef HAVE_BSD_KERN_PROC_SYSCTL
-	BASIC_CFLAGS += -DHAVE_BSD_KERN_PROC_SYSCTL
-endif
-
 ifdef HAVE_GETDELIM
 	BASIC_CFLAGS += -DHAVE_GETDELIM
 endif
@@ -2213,25 +2209,33 @@ ifneq ($(findstring openssl,$(CSPRNG_METHOD)),)
 	EXTLIBS += -lcrypto -lssl
 endif
 
-ifneq ($(PROCFS_EXECUTABLE_PATH),)
-	procfs_executable_path_SQ = $(subst ','\'',$(PROCFS_EXECUTABLE_PATH))
-	BASIC_CFLAGS += '-DPROCFS_EXECUTABLE_PATH="$(procfs_executable_path_SQ)"'
-endif
-
 ifndef HAVE_PLATFORM_PROCINFO
 	COMPAT_OBJS += compat/stub/procinfo.o
 endif
 
-ifdef HAVE_NS_GET_EXECUTABLE_PATH
-	BASIC_CFLAGS += -DHAVE_NS_GET_EXECUTABLE_PATH
-endif
+ifdef RUNTIME_PREFIX
 
-ifdef HAVE_ZOS_GET_EXECUTABLE_PATH
-        BASIC_CFLAGS += -DHAVE_ZOS_GET_EXECUTABLE_PATH
-endif
+        ifdef HAVE_BSD_KERN_PROC_SYSCTL
+		BASIC_CFLAGS += -DHAVE_BSD_KERN_PROC_SYSCTL
+        endif
+
+        ifneq ($(PROCFS_EXECUTABLE_PATH),)
+		pep_SQ = $(subst ','\'',$(PROCFS_EXECUTABLE_PATH))
+		BASIC_CFLAGS += '-DPROCFS_EXECUTABLE_PATH="$(pep_SQ)"'
+        endif
+
+        ifdef HAVE_NS_GET_EXECUTABLE_PATH
+		BASIC_CFLAGS += -DHAVE_NS_GET_EXECUTABLE_PATH
+        endif
+
+        ifdef HAVE_ZOS_GET_EXECUTABLE_PATH
+		BASIC_CFLAGS += -DHAVE_ZOS_GET_EXECUTABLE_PATH
+        endif
+
+        ifdef HAVE_WPGMPTR
+		BASIC_CFLAGS += -DHAVE_WPGMPTR
+        endif
 
-ifdef HAVE_WPGMPTR
-	BASIC_CFLAGS += -DHAVE_WPGMPTR
 endif
 
 ifdef FILENO_IS_A_MACRO
-- 
2.49.0
