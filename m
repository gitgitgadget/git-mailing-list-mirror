Received: from fout-a5-smtp.messagingengine.com (fout-a5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13978200130
	for <git@vger.kernel.org>; Mon, 27 Jan 2025 13:04:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737983072; cv=none; b=fFwnrWm50jMRrN2A7ypEiwltdM4njSREGWlWKg8LIKR22OPun/z90o2FD4ZkqvTLBFre1tTkQdtJ42S8vIRSBkZA5quDXkQL6I/aGX2tAMLHh9B9D7ttsfQkoC9/c8dOh2FtEwzAb9j8tGrrUEMQL3DagggIQv4l+39azIQAHDI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737983072; c=relaxed/simple;
	bh=EnaLw+NLNmnlMJN23Isi1K/JhgAg7qp4GARB5M/TpGg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=CTsWmviOEgCnI4MOV7Rw+48lk2XkXM5NV8W3Poip+QKqxjhz/o5G3NEODk3e+ucsmQYP8d+lOiloHxgfClOaOo3l95HVkYduDOasX+hbJNVkPkntf+kov5kag+GGK8V0i7qrrNfIMSif3gVDDSUju1IIK2nmT4PwGn9SyJ742/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Mwts0sq3; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=egd6tzZM; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Mwts0sq3";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="egd6tzZM"
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfout.phl.internal (Postfix) with ESMTP id 4019E13801C4;
	Mon, 27 Jan 2025 08:04:30 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Mon, 27 Jan 2025 08:04:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1737983070;
	 x=1738069470; bh=odlaHGn4S/YL9fx5ULUZ2Ifb22LuPqxkrEIvVpC872Q=; b=
	Mwts0sq3SOrQR4axP5NHpaFamVBXYx+rLnaRpeNkTg5ZzSIOg4zCZWr5ZyWgDzfC
	ja+09PBCI1hco7g8HCjYdiNVKMrAjXOn966tIA7GzWOfEzsvc+V6Da2SC/jeIImB
	9Q4f2F8jx8lGOqQoaxUw7T6tuKkhKEU95xZPaHa7Zww/QRbsJ/SDKPwHQj337VpV
	cGsHKPOFshQUlQ10LDqq2tYlyD/Ff7eTO3WzyKxoopHr1d7284Wv0kmp0wBrwB/4
	+JpwUHytYrOfQI4m5BTvmG0yCgyWrG8RArv6drkgTE5PfJVBwVyE/FjIhaE4uAPS
	cEFOpvyzfK6rrc7B8r0stg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1737983070; x=
	1738069470; bh=odlaHGn4S/YL9fx5ULUZ2Ifb22LuPqxkrEIvVpC872Q=; b=e
	gd6tzZM4OTn7zVridMYHjqnhfzaOMAKdv6u85aJ0PfSM+ecCQJMrsyPeccmswcW/
	MhyAnd9KF2ORk09CtXBi2fatbYVu83EpUMN0pl5jXIuczW1InExiWbTCLOER3UON
	CNv0V87gNu0uAWRiVJj6Ux677XOryYDKxEZQUpsng7oeln1DjMdqqp7moMDVuine
	HPUJvbAedFnfWH0l6HVNQ+tGM7wYrehtbfF8G4QPo9aNsuipKS7OktIQSgEtmkq6
	c2NT7XgXGKL/MQGqlrh4hNG2+SfNQOmPCP2+DAiJlqjAM03F7uvED/NynSFy+PBm
	jcEFrEA5nNZTnGftlqQ6g==
X-ME-Sender: <xms:XoSXZ5Xg76kodywFHs1cPZcEuP0WMbBcKdBIBMISOC0omptyuopoHQ>
    <xme:XoSXZ5mZOmYQssMYePPraRVJh7bISkPgZJz6mSXtU4OWH3yWGkLtkLSWllhq8tLsm
    N60BLuGo2v1igwC-Q>
X-ME-Received: <xmr:XoSXZ1Y0X2s8xAudEJpR3UDxa-yvTe3-dhF8GCAK81a5JDUNBPn93zscna5W7wJmofIuAAlu-PcE5MwgKrxh5X4iemXwMO3w15K7SK1_LxWY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudejgedgudefvdegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertder
    tdejnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhksh
    drihhmqeenucggtffrrghtthgvrhhnpeffueeiudejvdekheeuvdekfeffiedvueelteek
    udehjeetkeegvddugfdtgfeileenucevlhhushhtvghrufhiiigvpeefnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopedvpdhmohgu
    vgepshhmthhpohhuthdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorh
    hgpdhrtghpthhtohepvghthhhomhhsohhnsegvugifrghrughthhhomhhsohhnrdgtohhm
X-ME-Proxy: <xmx:XoSXZ8X4uViZ_mcjrFVbGP17-MPzQPTwMsHEti7nz1StFLaA-XB4LQ>
    <xmx:XoSXZzmuj0QZx6QLu0ZiXVFxPWhoMF2A_24dW0kkCWzNKEfrjih-Pw>
    <xmx:XoSXZ5cAJ9NPgxqNwYrSehU2RhlT-ZfVN-2LR5TYDi1Ofm1irgcEZg>
    <xmx:XoSXZ9F79OG3nudf-0Hvb4eQEHI3IpypbiWcwF0x2NYlHxp49QN9EQ>
    <xmx:XoSXZ4zpwmVk8YIF4A76Mv2eyMz-WByZTyX0HEpPMlIqw7s8bXjZx5JX>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 27 Jan 2025 08:04:29 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id d571247e (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 27 Jan 2025 13:04:27 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Mon, 27 Jan 2025 14:04:24 +0100
Subject: [PATCH 16/19] compat/msvc: split out POSIX-related bits
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250127-pks-reftable-drop-git-compat-util-v1-16-6e280a564877@pks.im>
References: <20250127-pks-reftable-drop-git-compat-util-v1-0-6e280a564877@pks.im>
In-Reply-To: <20250127-pks-reftable-drop-git-compat-util-v1-0-6e280a564877@pks.im>
To: git@vger.kernel.org
Cc: Edward Thomson <ethomson@edwardthomson.com>
X-Mailer: b4 0.14.2

Split out the POSIX-related bits from "compat/msvc.h". This is in
preparation for splitting up "git-compat-utils.h" into a header that
provides POSIX-compatibility and a header that provides common wrappers
used by the Git project.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 compat/{msvc.c => msvc/compat-util.c} | 0
 compat/msvc/compat-util.h             | 7 +++++++
 compat/{msvc.h => msvc/posix.h}       | 8 ++++----
 config.mak.uname                      | 4 ++--
 meson.build                           | 4 +++-
 5 files changed, 16 insertions(+), 7 deletions(-)

diff --git a/compat/msvc.c b/compat/msvc/compat-util.c
similarity index 100%
rename from compat/msvc.c
rename to compat/msvc/compat-util.c
diff --git a/compat/msvc/compat-util.h b/compat/msvc/compat-util.h
new file mode 100644
index 0000000000..e409e9910c
--- /dev/null
+++ b/compat/msvc/compat-util.h
@@ -0,0 +1,7 @@
+#ifndef COMPAT_MSVC_COMPAT_UTIL_H
+#define COMPAT_MSVC_COMPAT_UTIL_H
+
+#include "compat/msvc/posix.h"
+#include "compat/mingw/compat-util.h"
+
+#endif /* COMPAT_MSVC_COMPAT_UTIL_H */
diff --git a/compat/msvc.h b/compat/msvc/posix.h
similarity index 86%
rename from compat/msvc.h
rename to compat/msvc/posix.h
index df39978f4f..47062293cb 100644
--- a/compat/msvc.h
+++ b/compat/msvc/posix.h
@@ -1,5 +1,5 @@
-#ifndef __MSVC__HEAD
-#define __MSVC__HEAD
+#ifndef COMPAT_MSVC_POSIX_H
+#define COMPAT_MSVC_POSIX_H
 
 #include <direct.h>
 #include <process.h>
@@ -28,6 +28,6 @@ typedef int sigset_t;
 /* open for reading, writing, or both (not in fcntl.h) */
 #define O_ACCMODE     (_O_RDONLY | _O_WRONLY | _O_RDWR)
 
-#include "compat/mingw/compat-util.h"
+#include "compat/mingw/posix.h"
 
-#endif
+#endif /* COMPAT_MSVC_POSIX_H */
diff --git a/config.mak.uname b/config.mak.uname
index cc4152e87e..dbd05adb5d 100644
--- a/config.mak.uname
+++ b/config.mak.uname
@@ -495,7 +495,7 @@ endif
 	AR = compat/vcbuild/scripts/lib.pl
 	CFLAGS =
 	BASIC_CFLAGS = -nologo -I. -Icompat/vcbuild/include -DWIN32 -D_CONSOLE -DHAVE_STRING_H -D_CRT_SECURE_NO_WARNINGS -D_CRT_NONSTDC_NO_DEPRECATE
-	COMPAT_OBJS = compat/msvc.o compat/winansi.o \
+	COMPAT_OBJS = compat/msvc/compat-util.o compat/winansi.o \
 		compat/win32/flush.o \
 		compat/win32/path-utils.o \
 		compat/win32/pthread.o compat/win32/syslog.o \
@@ -541,7 +541,7 @@ endif
 
 	EXTRA_PROGRAMS += headless-git$X
 
-compat/msvc.o: compat/msvc.c compat/mingw/compat-util.c GIT-CFLAGS
+compat/msvc/compat-util.o: compat/msvc/compat-util.c compat/mingw/compat-util.c GIT-CFLAGS
 endif
 ifeq ($(uname_S),Interix)
 	NO_INITGROUPS = YesPlease
diff --git a/meson.build b/meson.build
index 32eb0a86d5..e8abf798f5 100644
--- a/meson.build
+++ b/meson.build
@@ -1054,7 +1054,6 @@ if host_machine.system() == 'cygwin'
   ]
 elif host_machine.system() == 'windows'
   libgit_sources += [
-    'compat/mingw/compat-util.c',
     'compat/winansi.c',
     'compat/win32/flush.c',
     'compat/win32/path-utils.c',
@@ -1081,6 +1080,9 @@ elif host_machine.system() == 'windows'
   libgit_include_directories += 'compat/win32'
   if compiler.get_id() == 'msvc'
     libgit_include_directories += 'compat/vcbuild/include'
+    libgit_sources += 'compat/msvc/compat-util.c'
+  else
+    libgit_sources += 'compat/mingw/compat-util.c'
   endif
 endif
 

-- 
2.48.1.362.g079036d154.dirty

