Received: from avasout-ptp-001.plus.net (avasout-ptp-001.plus.net [84.93.230.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41927155C97
	for <git@vger.kernel.org>; Sun,  6 Apr 2025 19:42:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=84.93.230.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743968544; cv=none; b=a2+rcof+ClNXDa/MHMRz8tUUtStuqm0VazngQIbu32iuYQ/oFueSvV9aHLywtlhrkgePt7lqhrkqXXcV/owyALsO8g+u14fce3AKQk157kDmDwfjuJmeI7WDYb30TUinTLiDjPoDaKSWH48cWYYkIz7no3bNkDXpqh/TDwTtvT4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743968544; c=relaxed/simple;
	bh=4oZtVPkKwwvl4/kG3Pcwo/gIn6elwSpnxPM52qbEXxg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=S7iN0iG+oubWS85pj1f2oM16UyT9Z31yrx4mVf63tiec2vscLyUicFTMBnjobzVU315sCixhVQDwRreTecvZF49J0REcGEKHOE8S3UngZ7Rh2Aw0/Lxdu6GoYzuZuDGvOma3fgRQn56iXrMqsWeBKNiCbcZGSsOP5eARIWtOteo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ramsayjones.plus.com; spf=none smtp.mailfrom=ramsayjones.plus.com; dkim=pass (2048-bit key) header.d=plus.com header.i=@plus.com header.b=g2714YC4; arc=none smtp.client-ip=84.93.230.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ramsayjones.plus.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ramsayjones.plus.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=plus.com header.i=@plus.com header.b="g2714YC4"
Received: from localhost.localdomain ([80.189.83.109])
	by smtp with ESMTPA
	id 1VpUuYqwzbpaN1VpyupkLJ; Sun, 06 Apr 2025 20:39:22 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=plus.com; s=042019;
	t=1743968362; bh=mnSwRgfsuqwJWe3cxnQyOOlcRFjXhLi55yE0/tQoN7w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=g2714YC4MkwapUIhvZmoOHLSGwT3a8AzQHR67VMlRLmo9U6bnNtJfXHH3HNJJwaMm
	 pEn9iPH0jOZQPHtaW7C0qrkzcljrWIhTQEgkdXpkuUV2XBHF4/9tm4nlb7pOitcMQv
	 L4FryCxEZjdtnGZZGUU4E2j++uj0lYUXulBRpaUxVaExC0ATHTA+/xsvAU/ybFwXjs
	 0v23lpvc0tY201wXj7iW8oeEoMOOCO8N7LTKx2xElFon6VU/j+i1auskGyUifySlIw
	 0RUMYv+FLQHtXA2cfpv821Mc9Gujyfj7ZHR80RJ5R+NBPtUDUHVJmPWBXn6RVp/Epa
	 IELoGc/xxfFuw==
X-Clacks-Overhead: "GNU Terry Pratchett"
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.4 cv=frZ/Z04f c=1 sm=1 tr=0 ts=67f2d86a
 a=oM5NSl/Bl4BpjFr0C8iQlQ==:117 a=oM5NSl/Bl4BpjFr0C8iQlQ==:17 a=EBOSESyhAAAA:8
 a=UssqkuoP40Gt3Q7oBg4A:9 a=yJM6EZoI5SlJf8ks9Ge_:22
X-AUTH: ramsayjones@:2500
From: Ramsay Jones <ramsay@ramsayjones.plus.com>
To: GIT Mailing-list <git@vger.kernel.org>
Cc: Junio C Hamano <gitster@pobox.com>,
	Patrick Steinhardt <ps@pks.im>,
	Adam Dinwoodie <git@dinwoodie.org>,
	Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: [PATCH v2 02/13] Makefile: only set some BASIC_CFLAGS when RUNTIME_PREFIX is set
Date: Sun,  6 Apr 2025 20:38:28 +0100
Message-ID: <8df541634aedbba40d8b0fa57dbf9cb0e495f11b.1743859985.git.ramsay@ramsayjones.plus.com>
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
X-CMAE-Envelope: MS4xfAKImvLWS4A1A6icwVQHAEvGlv9dn7gt+aUKrQHqUb1DQE0paVoJOnBFpc2eRyylld0qLNVpdIL+d3kkSh4upQSVneLBoM+FLsgclDzs22vicXm5Hl6m
 r4Aga7sVUh83hVsQGW6VBYZwxviKHTtzFtB5jY3nDUJU4gWHl+iz6GIoK9mk47TfdbTxlxHVtjcteVep9pxl6bRLdP1Ah6+xgqg=

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

