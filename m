Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DAC5B672
	for <git@vger.kernel.org>; Sat, 15 Feb 2025 15:51:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739634711; cv=none; b=no9Feed/PMRBe+SlEc8ngX+hDb6JOq8Ol1sjw2d8CP0Vqx4u2p3oM9sEZYyqSYUEzleHKgHqXMjpCRLoDliT/1M8QUlaKF6vvKRdZf+b9SUMIc0gzOTQJAdmPRMQ5oCrr9fgAgaiH45s3bZFIep/pUEHIFZygkyjgvvoBQnLpho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739634711; c=relaxed/simple;
	bh=42i8PUdjyKs+NSwGtLcbj9v39QXr3Du2dpk4eqznw+0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JRFevWP46lF+27I7Y0qrkxgG8ZfOvdMIkl713iblBExNz0NyM4RMnVXo8DZuoxYPtcGWTS//MWWYdgE+t2h10VJM0ah0eHSZ+5XMhMacWnmBTDVILA52Dv7um+cI7WObg3hrPLeOdL1EbbEURIn7V+tbT+hCKOqHQi64o9y0m/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LCL+kGLU; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LCL+kGLU"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-220f048c038so29051245ad.2
        for <git@vger.kernel.org>; Sat, 15 Feb 2025 07:51:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739634709; x=1740239509; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ST9UH+tJO/KD1eiPpPYLssoj13nQqfVGYdBzpY/GozQ=;
        b=LCL+kGLU3lyNAelyD2awuMWvCR6RrbXaygP5dKgNcN3UqB2kBdYuwAF+qhv+T5vxpQ
         95iq0YuBTKbn39nc4ausrnSEw/G/INOKAb0FCAf1svGA0Cih8qgYppHoHxrX6NKhCHor
         4HZr3wDRlXxKXxg/AUJrmueGrUKKnnfevdReHOjpQKCrHdVUskvUkdEwsGImxYhc5DMz
         Nl8+qI/RGYDKKRftBE/2XOqKCkFwM37N3hHl7fHnnEX7LTuDCjzd8JTiG/cLB+2aDncY
         mRDyHo7Vr34Fo/OzvRFPUqj73c+633EVD7FKXtE4/bqU3rrEf7vjpHcl+lH+EcRXz9Eo
         tUtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739634709; x=1740239509;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ST9UH+tJO/KD1eiPpPYLssoj13nQqfVGYdBzpY/GozQ=;
        b=iObxdHJB+pdqjFXxp5g8mAfXOdBc4IckZoX+oiCu/x+jxHIfsV3PPYnAXiWd6x0tKL
         vkRJZUK09agY4rxWT1MZIFqAavDL7drVfrl1YSUKTyCKQCl02FyEm1HfWfZUq6STVZki
         KIbbrd5R4fYMQymsTu3X8rKNVTtvPH5SH1qr9lVVVphFzxph8ONgmIqN69hAHWjLC1aA
         1D0Z0f+PWjwpMbRvjTBndRuuZ4f1WOiBA9zwLzn5eRApLGujyq9kefhrFMf+KFNSgny8
         FS8ONcF8pjZSYLM5XzJNB5GItCxgl+twr34/dvSB1fzu37cB9z4XmbfKFXErH/95v0Uy
         ijwQ==
X-Forwarded-Encrypted: i=1; AJvYcCUzI2RxMA723KT1GI2AugJqYOuGQTNARgR4eNH0I+T778J+dPrcAO4zD6GeJ9s7+p3FWNc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzPvRMYq9GxuslO9vv7Rbt4tCbtIv21CgrCMkwdqA5TBlOd7f4X
	iNYZzoKWtNqw3WKKVmbJvNrMHzR0J7eUwM0OHQ0O/x2c9yMz6Ge9
X-Gm-Gg: ASbGncvL/wyD5w8k9XfAHHLh0319/ET59FrrRuC6WVRWoIJXUsEQwrzSZvlMOoskmeH
	yD5y53HQQYrLgHR3J7pin6uXH7Me3O6+3YJf+gb6T/zePMHT7O4krBVn5wC3xA2k25EOm2M2VQF
	tUCxnmPV2HUmffOrrmpKo880SOccrMEf1cL35QX/pe5KtJyigLZbg3dJTLK8s/bLcbp5VLzicX3
	oKPLs/aiVAju8OpP6QbGS9IEgHwvxSMXp40q/ItEQ8NYdJASVgBgGTcDLmpLI01WoTad2a8x63+
	vE+kPlMgh6mucy/p7k3itc0Dqa0QV312oIwWufJZ
X-Google-Smtp-Source: AGHT+IGAAjJby4V9mj/NPYxJZbV+BkdmjxKhnOheT1HhJRA+WBmDGKmUGCpy5ip7Dtn6WHOBxWkmNg==
X-Received: by 2002:a17:902:fc4e:b0:220:ecf7:4b5c with SMTP id d9443c01a7336-22103f16d99mr56805365ad.14.1739634708864;
        Sat, 15 Feb 2025 07:51:48 -0800 (PST)
Received: from archlinux.plaksha.edu.in ([182.75.25.162])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-220d559089asm45024285ad.241.2025.02.15.07.51.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 Feb 2025 07:51:48 -0800 (PST)
From: Usman Akinyemi <usmanakinyemi202@gmail.com>
To: christian.couder@gmail.com,
	gitster@pobox.com
Cc: Johannes.Schindelin@gmx.de,
	git@vger.kernel.org,
	johncai86@gmail.com,
	me@ttaylorr.com,
	phillip.wood@dunelm.org.uk,
	ps@pks.im,
	rsbecker@nexbridge.com,
	sunshine@sunshineco.com,
	Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v6 3/6] version: refactor get_uname_info()
Date: Sat, 15 Feb 2025 21:20:49 +0530
Message-ID: <20250215155130.1756934-4-usmanakinyemi202@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250215155130.1756934-1-usmanakinyemi202@gmail.com>
References: <20250214123734.1403120-1-usmanakinyemi202@gmail.com>
 <20250215155130.1756934-1-usmanakinyemi202@gmail.com>
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

Mentored-by: Christian Couder <chriscool@tuxfamily.org>
Signed-off-by: Usman Akinyemi <usmanakinyemi202@gmail.com>
---
 builtin/bugreport.c | 13 ++-----------
 version.c           | 20 ++++++++++++++++++++
 version.h           |  7 +++++++
 3 files changed, 29 insertions(+), 11 deletions(-)

diff --git a/builtin/bugreport.c b/builtin/bugreport.c
index 7c2df035c9..5e13d532a8 100644
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
+	get_uname_info(sys_info);
 
 	strbuf_addstr(sys_info, _("compiler info: "));
 	get_compiler_info(sys_info);
diff --git a/version.c b/version.c
index 60df71fd0e..3ec8b8243d 100644
--- a/version.c
+++ b/version.c
@@ -3,6 +3,7 @@
 #include "version-def.h"
 #include "strbuf.h"
 #include "sane-ctype.h"
+#include "gettext.h"
 
 const char git_version_string[] = GIT_VERSION;
 const char git_built_from_commit_string[] = GIT_BUILT_FROM_COMMIT;
@@ -47,3 +48,22 @@ const char *git_user_agent_sanitized(void)
 
 	return agent;
 }
+
+int get_uname_info(struct strbuf *buf)
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
+	strbuf_addf(buf, "%s %s %s %s\n",
+		    uname_info.sysname,
+		    uname_info.release,
+		    uname_info.version,
+		    uname_info.machine);
+	return 0;
+}
diff --git a/version.h b/version.h
index 7c62e80577..afe3dbbab7 100644
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
+int get_uname_info(struct strbuf *buf);
+
 #endif /* VERSION_H */
-- 
2.48.1

