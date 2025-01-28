Received: from fhigh-b5-smtp.messagingengine.com (fhigh-b5-smtp.messagingengine.com [202.12.124.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 033D01DF735
	for <git@vger.kernel.org>; Tue, 28 Jan 2025 08:28:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738052914; cv=none; b=eDvYnNHgYP72pJA1Iy3jxyqEzBI7Qk8n8JeodqIt9sC0SNSA4mu6Ia8mXhTpfjUpQpw33Ia+iVAuIyyVXmaYKH0wT9XRnfwat8CzaAsuTA6Ktb8FXi7hggU/AKXUCFYT8F2r0sPhszvNpsBhhGiCmdSssfghbje3B3bBQov1bQM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738052914; c=relaxed/simple;
	bh=rIi7S5FoYFvRO78WjmPPHNSL4D3MZckaTl1cMCbt9Ro=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=TWHcJyoOFY39zHz9PViwqHA2+yAIHjRHmUiJjf15SlMFqNqmRNHEtYE7g0n9dzd5CNW8BOIXNDdZjMN5z4Ty3N68FaG3bzur8tapiphfnPBMA3VU/SSMFvlWSdFEHYdL7hvTLOZnSiNreCz+o57F+sH0lYPqY3ZO/G0l2gmQil0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=pEEuMuYg; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=jgYCF6p8; arc=none smtp.client-ip=202.12.124.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="pEEuMuYg";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="jgYCF6p8"
Received: from phl-compute-11.internal (phl-compute-11.phl.internal [10.202.2.51])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 50EC3254024E;
	Tue, 28 Jan 2025 03:28:32 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-11.internal (MEProxy); Tue, 28 Jan 2025 03:28:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1738052912;
	 x=1738139312; bh=mA+A9+ANteqsdiATpcFASFN5uhj9YbjlWatlVje7gTU=; b=
	pEEuMuYgciH4a5cVBbh7Mh/lT+cvh/sxjqMoc8PI1kn605JGxrUBY422DI/Zumif
	R96lBQBpq5qG9J7OlfKGSEhyM50lsnCSDcZg/WdQOmLZxINjd4SlZBq4+jHVxAHj
	2BrXAr744xz2T9EgwNSGEGvY3eFCzsKdx6mhmPnv4qQ3lJrBeEiq1sXbw31/X+M2
	T0pBiEQOK1nLpsW7BlQwn2Y1ef2XMc8nO5TDBpRvsRpIL2THf/uzeY8MLjELc/IN
	oDS/MOcMkPjWzYDPLAYAufY326cu/kcDlfObjde80uw03QlhqZZc2juINavWDktl
	svUI1iJ9Ksoc4XC38EWS2A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1738052912; x=
	1738139312; bh=mA+A9+ANteqsdiATpcFASFN5uhj9YbjlWatlVje7gTU=; b=j
	gYCF6p8NniKeMJ5lctXbHlZYLZZ7QD4KIFRb/iyMyDOSckU7N/AoM/TNUD6KfxPM
	WtHRRXC8SuhpLgvNiTZvR06ODhRX5eMIcnq3NrPJz3ualc9hKtzuEwHECvQzYyPb
	TcAwTQpNUT7RjTlXWRD3hfovOjKLwBZQ3Ywe8mML5R+ncUVypCn57OTsBRhUluMB
	O+68WN0fk2KZgBnTBiSZbKlBj+jlDufCKd4dK7dalp1VsCmIQ7m+5MEgYEEGL3/U
	iFSWfKtiEcnBdtKAUuIZgZEw1U3xwwSQ6Ub4AY+smYvSLqKvXkneSC+7kdIOAA/+
	CdIQPOwGlw0VIr/z10mCg==
X-ME-Sender: <xms:MJWYZ515MrxOGudsuGhvow822kJrN-pKQ-Qur9YqjjclW_NYT9NDGA>
    <xme:MJWYZwHycgUnS9yJOi734myWxho5QAARaUvvC3LcV5F7OfL7kiWUr0pZsdvEaXpL8
    CcQM9988ayjo7d0kw>
X-ME-Received: <xmr:MJWYZ55IqoXB9ff42ef5ByHBL8cW7cC8Qrl0OdQkTWi6y22fxfoyuOtQ8t-Kf6KK2_v_cuKzoCmZJfSpcJD6JnmhKjg-XE1YgaCSrmRRo6k>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudejgedgudehiedvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertder
    tdejnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhksh
    drihhmqeenucggtffrrghtthgvrhhnpeffueeiudejvdekheeuvdekfeffiedvueelteek
    udehjeetkeegvddugfdtgfeileenucevlhhushhtvghrufhiiigvpeefnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeegpdhmohgu
    vgepshhmthhpohhuthdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhmpd
    hrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopegv
    thhhohhmshhonhesvggufigrrhguthhhohhmshhonhdrtghomhdprhgtphhtthhopehjlh
    htohgslhgvrhesghhmrghilhdrtghomh
X-ME-Proxy: <xmx:MJWYZ21LSiFdfXGuV-jLpGjNjV9zxsK_vz3mY0fsNYltf-9hjq6_uA>
    <xmx:MJWYZ8HPJTf3sDBLzm1MTsuut3f_A5Wb3_1j_2r3a5Yt5rD2XBv_mQ>
    <xmx:MJWYZ393k9j85PD2mJM9WkhDTZL6b4xfKxfFhaGhJzkEP6sT9pKoDA>
    <xmx:MJWYZ5mM13FHhI9VG_KsjGtd05aBL0QxEenRsdrNMpEsDZ1IOEcquQ>
    <xmx:MJWYZ4i1Kjs9ag4T8Rkk3MvF34aKqoQgyku4u3kvNWRvgfBnd4E7qoKr>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 28 Jan 2025 03:28:31 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id d9411ac5 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 28 Jan 2025 08:28:29 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Tue, 28 Jan 2025 09:28:18 +0100
Subject: [PATCH v2 17/20] compat/msvc: split out POSIX-related bits
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250128-pks-reftable-drop-git-compat-util-v2-17-c85c20336317@pks.im>
References: <20250128-pks-reftable-drop-git-compat-util-v2-0-c85c20336317@pks.im>
In-Reply-To: <20250128-pks-reftable-drop-git-compat-util-v2-0-c85c20336317@pks.im>
To: git@vger.kernel.org
Cc: Edward Thomson <ethomson@edwardthomson.com>, 
 Justin Tobler <jltobler@gmail.com>, Junio C Hamano <gitster@pobox.com>
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
index 38a774de39..8407efd262 100644
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

