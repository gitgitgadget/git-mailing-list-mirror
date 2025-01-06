Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19D1E1DB52D
	for <git@vger.kernel.org>; Mon,  6 Jan 2025 10:37:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736159851; cv=none; b=OUyFg5vZ0uvLiHKmDEQYi9guGHSxVVBlsle+67aPmUz2q+MTUyAvkdQURVUORnEx9HOLciGC3phLVsSBeg1k9BerppXjrQfhsWZeS/FeqzlVyy5m86mKBnO0GfXgtTYxDQgYyxC0NlDNJWXYcC6JF1a6JzFdkWEj3VBSQ2wmSH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736159851; c=relaxed/simple;
	bh=g40B3DR0M0J2sP/tV3hKBzYJ6uc9cHlZCoD+3TYH/uA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qSWTzWrf4A0AkLKBgt0EWycOlLmzSpJGES6ZItZYDk4E7uPxWVgCzBwRGChmcZwrpzGo/QgxMPZl19OrDa8njaPE80E7VTC96Zr8xzg9kyCVQiKOHpfoZNHl+5VqZ0Licifrx4CG6RqvpT+EexR/MT1g+iXDTd9WZR9DpXGfR/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kAmvAqfZ; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kAmvAqfZ"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2162c0f6a39so210229995ad.0
        for <git@vger.kernel.org>; Mon, 06 Jan 2025 02:37:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736159847; x=1736764647; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Q9vbB+06M/1oU/3N4LcGfrVa7O23n4wo+0GDEC8nRgE=;
        b=kAmvAqfZLipU8gcTD4pArRUD9ZpsYuEOYItYuJVRe02W/j4DlA5Hkyhihn01ie5JlL
         +MgQ2fiPMEaVTrdVPVX8WsM/PRN3KUGlIomxrFJ2H7UV3iN0vWugmh7WBp/PJk0rA2pk
         bJ5RTWWw2u+DrancpQ9ztRHesByDXfXE2aC6BjkqkbgvrH1zrAeCjgWe+kAROep+SDNr
         tO6+Ys6r5H40zn/YO5zFC7kqyx1YLADnPmdWcy3M1rSqS9MiKB/YFZyjjuMmIw+nAwDk
         JbX3agOlC8GKuE0up0ahyo3RpUvzz6obYwPdsNyUB3DWTI9Pfx/2VV7Lee3uFX91afph
         aVQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736159847; x=1736764647;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Q9vbB+06M/1oU/3N4LcGfrVa7O23n4wo+0GDEC8nRgE=;
        b=t5xyKJYl0i7vfG/oJWeEpvVhdD291MZaj4eITezfe3nVJqBQp0Nys1yWZeIjWNdNrG
         9lRIbveZaM7e8C6DJGFq/9IJ4Iwii5cnIr3vse66zxk9iUGDuIxGBss6u8q+LTvYqT+A
         vL8p3nW9uOudFdUTI0vffyDbAM1yCKakvZzTkBQNsqHcD4DuI5Gv59EBBxq6jmmKOGxG
         h5+538NAkyZo8KDphPqvfYUxkuwNLfvCSIhO8l3FFwY2+iS9fzQm3tyrZK3PkiM0HY98
         CgcxbD+A/hlTl0uRsfBlIwjO1qZZyCUXfY6DQxu6xVqsMWveFEl9a64gJTsnOLeHLitP
         Eftg==
X-Gm-Message-State: AOJu0YyDlASt/Fd6gafaNxZ0wyqysHxk4cJf9iyHkd59G2Wfip21mamK
	DkS461xZNkEJzP0A0AfVIMYCiaYga77vk+x3YXuYR0BqrdXNPcp7w/meSj0+v+k=
X-Gm-Gg: ASbGncsZ4T5Mud5jjxiyk5sYc1akOvXU2FGpD0nrIa1Dbj7zQPSUpbsSJtfav3VtWSQ
	tunt2K6zi0rhgIWx01BqcjcKEraS51qFXFqmQU1NqL7zMrQURmyaGQCHt3H1ai99uSiHUlmAu9b
	JDwH47vNtXFvIBpo6gOKK7L18aB+b4kUuCb0JeMVazyI4roCC5rpJtmxJpPDi2FDKFehA8RvxyH
	rS1UBmspPiTsCNrunPEf8Bs1EFjFVY31zR6TFtmcCIHbYL95DvLkqlFjFaiP/CIdOIxqK+XI2cx
	D/Q3BA==
X-Google-Smtp-Source: AGHT+IE/lJoc8y3ywZ9VuAqViR4+JULfiESbGeSOVFWDX+kXRop/KiGOhiiIHoP3/hIbUd7GI9HRjw==
X-Received: by 2002:a05:6a20:3d86:b0:1e1:fbab:1f18 with SMTP id adf61e73a8af0-1e5c7002694mr97216553637.23.1736159847079;
        Mon, 06 Jan 2025 02:37:27 -0800 (PST)
Received: from archlinux.plaksha.edu.in ([202.164.41.66])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-842b85f00f9sm28774281a12.43.2025.01.06.02.37.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jan 2025 02:37:26 -0800 (PST)
From: Usman Akinyemi <usmanakinyemi202@gmail.com>
To: git@vger.kernel.org,
	christian.couder@gmail.com
Cc: gitster@pobox.com,
	ps@pks.im,
	johncai86@gmail.com,
	Johannes.Schindelin@gmx.de,
	me@ttaylorr.com,
	phillip.wood@dunelm.org.uk,
	Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH 2/4] version: refactor get_uname_info()
Date: Mon,  6 Jan 2025 16:00:50 +0530
Message-ID: <20250106103713.1452035-3-usmanakinyemi202@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250106103713.1452035-1-usmanakinyemi202@gmail.com>
References: <20250106103713.1452035-1-usmanakinyemi202@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Some code from "builtin/bugreport.c" uses uname(2) to get system
information.

Let's refactor this code into a new get_uname_info() function, so
that we can reuse it in a following commit.

We may need to refactor this function in the future if an
`osVersion.format` config option is added, but for now we only
need it to accept a "full" flag that makes it switch between providing
full OS information and providing only the OS name. The mode
providing only the OS name is needed in a following commit.

Mentored-by: Christian Couder <chriscool@tuxfamily.org>
Signed-off-by: Usman Akinyemi <usmanakinyemi202@gmail.com>
---
 builtin/bugreport.c | 13 ++-----------
 version.c           | 23 +++++++++++++++++++++++
 version.h           |  7 +++++++
 3 files changed, 32 insertions(+), 11 deletions(-)

diff --git a/builtin/bugreport.c b/builtin/bugreport.c
index 7c2df035c9..e3288a86c8 100644
--- a/builtin/bugreport.c
+++ b/builtin/bugreport.c
@@ -12,10 +12,10 @@
 #include "diagnose.h"
 #include "object-file.h"
 #include "setup.h"
+#include "version.h"
 
 static void get_system_info(struct strbuf *sys_info)
 {
-	struct utsname uname_info;
 	char *shell = NULL;
 
 	/* get git version from native cmd */
@@ -24,16 +24,7 @@ static void get_system_info(struct strbuf *sys_info)
 
 	/* system call for other version info */
 	strbuf_addstr(sys_info, "uname: ");
-	if (uname(&uname_info))
-		strbuf_addf(sys_info, _("uname() failed with error '%s' (%d)\n"),
-			    strerror(errno),
-			    errno);
-	else
-		strbuf_addf(sys_info, "%s %s %s %s\n",
-			    uname_info.sysname,
-			    uname_info.release,
-			    uname_info.version,
-			    uname_info.machine);
+	get_uname_info(sys_info, 1);
 
 	strbuf_addstr(sys_info, _("compiler info: "));
 	get_compiler_info(sys_info);
diff --git a/version.c b/version.c
index 78f025c808..44ffc4dd57 100644
--- a/version.c
+++ b/version.c
@@ -2,6 +2,7 @@
 #include "version.h"
 #include "version-def.h"
 #include "strbuf.h"
+#include "gettext.h"
 
 const char git_version_string[] = GIT_VERSION;
 const char git_built_from_commit_string[] = GIT_BUILT_FROM_COMMIT;
@@ -47,3 +48,25 @@ const char *git_user_agent_sanitized(void)
 
 	return agent;
 }
+
+int get_uname_info(struct strbuf *buf, unsigned int full)
+{
+	struct utsname uname_info;
+
+	if (uname(&uname_info)) {
+		strbuf_addf(buf, _("uname() failed with error '%s' (%d)\n"),
+			    strerror(errno),
+			    errno);
+		return -1;
+	}
+
+	if (full)
+		strbuf_addf(buf, "%s %s %s %s\n",
+			    uname_info.sysname,
+			    uname_info.release,
+			    uname_info.version,
+			    uname_info.machine);
+	else
+		strbuf_addf(buf, "%s\n", uname_info.sysname);
+	return 0;
+}
diff --git a/version.h b/version.h
index 7c62e80577..5eb586c0bd 100644
--- a/version.h
+++ b/version.h
@@ -7,4 +7,11 @@ extern const char git_built_from_commit_string[];
 const char *git_user_agent(void);
 const char *git_user_agent_sanitized(void);
 
+/*
+  Try to get information about the system using uname(2).
+  Return -1 and put an error message into 'buf' in case of uname()
+  error. Return 0 and put uname info into 'buf' otherwise.
+*/
+int get_uname_info(struct strbuf *buf, unsigned int full);
+
 #endif /* VERSION_H */
-- 
2.47.1

