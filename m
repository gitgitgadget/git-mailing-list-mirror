Received: from mout.web.de (mout.web.de [212.227.17.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20D672F7AA7
	for <git@vger.kernel.org>; Sat,  6 Dec 2025 13:35:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765028151; cv=none; b=VtXQENRsQxwlDWpdKy1a+ZHeR7EzpCMlbRXixfViupHjF5MutDf7QFHh6zFyysaN7tKviOidh+KJRL5e8kPX1wK0ToZeMbDqvYRel9m9CVKW7I4iZR5cySvi2wfwlSHujVdkfJIex6O4rdE14S0OMRZwf4i/zeq0zwLZkbzcV34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765028151; c=relaxed/simple;
	bh=wNjVoENPYwH9CLW7j1Ob+gFwWjosPTkmjlCYeq4DpwY=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=npVK27tjVGlvlCuudwVbmBb5djBStpMkrQrOZBpaDIwtJf/Eh2Nn2VEVAh9V+Wj9VQmwjDVckwUH1eUSfmhxPv2IQY3j0dOOHaqS3/MUvMWZpzlBejr8sq+1wH6fHzrY2/kMgIM8DMLwPnRWMoOVxRMKzZBHCEGvjS5OS+vjvlI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b=ah2SuFot; arc=none smtp.client-ip=212.227.17.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b="ah2SuFot"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1765028139; x=1765632939; i=l.s.r@web.de;
	bh=gwNyi9IonEnK7EFwmU/BAQDOun+PsPtMKW0a4ju27PY=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:From:To:
	 Cc:References:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=ah2SuFotftjFMSEaseyBuQo/8F7wqIDh9UkJGacspSD8vIrLmcvHZmXHiuPCs1hq
	 /VJU9m2J0OehtjxGhQQ2+HljVIq3bMu9tbiaRkPIqAUOPyFlZS5fSBlqtQN4O8JRe
	 y3n9XG1q/A8D29KJ6fGjygjYTpcj2/9+J3E7w1BM8mPpC7AwoHQMtZu4GhYkzvLcW
	 JyhtgbV2Am99EZ+NT1bPzHrdsVzd2KV8xJaP/OiBm0YSxPXSAXEJ+Y3DLMmGbhYNR
	 uyu28gMNhzUaVdSCLrVnRMbnYp0F/4/ZLxAM6yYZZMcRzdCXIdX/awuJVbrpMnG5/
	 /UYByVifxyWRMdHLbA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.2.31] ([79.203.21.144]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MgANA-1vySe52vWA-00alEw; Sat, 06
 Dec 2025 14:35:39 +0100
Message-ID: <b0ed5848-ab28-4255-9933-b1d15ac9e13c@web.de>
Date: Sat, 6 Dec 2025 14:35:39 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH v2 5/5] compat: remove gitmkdtemp()
From: =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
To: Git List <git@vger.kernel.org>
Cc: Jeff King <peff@peff.net>, Chris Torek <chris.torek@gmail.com>,
 Junio C Hamano <gitster@pobox.com>
References: <784f495a-4b1a-4acf-96cd-599243ef9e27@web.de>
 <64e62623-b911-4ddd-a481-05191853c0a6@web.de>
Content-Language: en-US
In-Reply-To: <64e62623-b911-4ddd-a481-05191853c0a6@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:0bU+GPN0+5CLJ66LWecFn5wlWVOhMX7DqZt0/55oysR0ccQV+Wr
 YfeDyCRhcxCWWCVlWWO5vXmxGUEerLL4wFpa9OGFchlMq8DK+GyhTRB6mgILs3pfuTQSkfE
 HDqU1JqxLWFFLdfmtAqJ+pGvytnsbyjfn6+8YsbV1a9EscQbkfMcCzk4vqm/3BF72Z5fEnf
 rPtu5Kw3DpTlm2d/Z4aFQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:T4JoInmTnKc=;qk8phKUNLOeLlS2/uxpW30zv+os
 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

gitmkdtemp() has become a trivial wrapper around git_mkdtemp().  Remove
this now unnecessary layer of indirection.

Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
=2D--
Only tested with make.

 Makefile                            | 1 -
 compat/mkdtemp.c                    | 6 ------
 compat/posix.h                      | 3 +--
 contrib/buildsystems/CMakeLists.txt | 4 ----
 meson.build                         | 2 +-
 5 files changed, 2 insertions(+), 14 deletions(-)
 delete mode 100644 compat/mkdtemp.c

diff --git a/Makefile b/Makefile
index 237b56fc9d..8226aed443 100644
=2D-- a/Makefile
+++ b/Makefile
@@ -1919,7 +1919,6 @@ ifdef NO_SETENV
 endif
 ifdef NO_MKDTEMP
 	COMPAT_CFLAGS +=3D -DNO_MKDTEMP
-	COMPAT_OBJS +=3D compat/mkdtemp.o
 endif
 ifdef MKDIR_WO_TRAILING_SLASH
 	COMPAT_CFLAGS +=3D -DMKDIR_WO_TRAILING_SLASH
diff --git a/compat/mkdtemp.c b/compat/mkdtemp.c
deleted file mode 100644
index fcdd4e01e1..0000000000
=2D-- a/compat/mkdtemp.c
+++ /dev/null
@@ -1,6 +0,0 @@
-#include "../git-compat-util.h"
-
-char *gitmkdtemp(char *template)
-{
-	return git_mkdtemp(template);
-}
diff --git a/compat/posix.h b/compat/posix.h
index 067a00f33b..245386fa4a 100644
=2D-- a/compat/posix.h
+++ b/compat/posix.h
@@ -329,8 +329,7 @@ int gitsetenv(const char *, const char *, int);
 #endif
=20
 #ifdef NO_MKDTEMP
-#define mkdtemp gitmkdtemp
-char *gitmkdtemp(char *);
+#define mkdtemp git_mkdtemp
 #endif
=20
 #ifdef NO_UNSETENV
diff --git a/contrib/buildsystems/CMakeLists.txt b/contrib/buildsystems/CM=
akeLists.txt
index 479163ab5c..28877feb9d 100644
=2D-- a/contrib/buildsystems/CMakeLists.txt
+++ b/contrib/buildsystems/CMakeLists.txt
@@ -411,10 +411,6 @@ if(NOT HAVE_SETENV)
 	list(APPEND compat_SOURCES compat/setenv.c)
 endif()
=20
-if(NOT HAVE_MKDTEMP)
-	list(APPEND compat_SOURCES compat/mkdtemp.c)
-endif()
-
 if(NOT HAVE_PREAD)
 	list(APPEND compat_SOURCES compat/pread.c)
 endif()
diff --git a/meson.build b/meson.build
index f1b3615659..24c656681c 100644
=2D-- a/meson.build
+++ b/meson.build
@@ -1401,7 +1401,7 @@ checkfuncs =3D {
   'strlcpy' : ['strlcpy.c'],
   'strtoull' : [],
   'setenv' : ['setenv.c'],
-  'mkdtemp' : ['mkdtemp.c'],
+  'mkdtemp' : [],
   'initgroups' : [],
   'strtoumax' : ['strtoumax.c', 'strtoimax.c'],
   'pread' : ['pread.c'],
=2D-=20
2.52.0
