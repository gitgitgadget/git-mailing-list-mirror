Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7D512B9BC
	for <git@vger.kernel.org>; Fri, 24 Jan 2025 12:22:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737721358; cv=none; b=f5gqtYljixKCIOEtrbS0qhw+Nsw+quaZ/V6Kk9q5SkFZCzqIYN/Cl4xR+QTkm7JYd2yk/pqAHmJLaDKCupzslewFit86jLVG3GSqUl60UljHW3tnqudOMV00TD/AkILBI7b1cvMfK/tBbVbeDSax0izQ4vVLigXRb7u4QCC7lys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737721358; c=relaxed/simple;
	bh=nG+qvdg4zuJA/fdlNbXmCUGkknIbiKdjV3AFe6URszU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FGqyAPaIib+RwQpSJhPSw3Q1/PPGEyYGXmv1ctqAoGZI0IDx4D2nGiWLEE5Um8unPds+yTUune0WKK3Y++yUC31A6o9jjJLfJ8ROc5QrN7YzMfCD9N7a190P7HJZSLs/qHVftVb2XVPN7Vl2cA4lTOtmQeter7/dVgUjnKx38y0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G+HyUb52; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G+HyUb52"
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-2ee51f8c47dso2993965a91.1
        for <git@vger.kernel.org>; Fri, 24 Jan 2025 04:22:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737721356; x=1738326156; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=szEYN8zQnG0gcSCUnmFPnsB3EmNA3yUNBw/rUjb9PM4=;
        b=G+HyUb52wV/ML7Xd0X8FuoCtyryD70OS+BEAomcQNgt6HNqODqe0L1+LwdMOyRsp8A
         wQfKOwbE/gEzypGzHLFsn0fCAkbHOjTCzk1+5IU82ncgnKBywO4z40fNtTQZdnXGneEr
         DsT1sasyqe9R84MBhp74fPoJ3gWvkpvf7VMp91JP3Fxg1RobIymLBqGyOvTV+gGwFBxv
         5NMOapHO8ObUtpdlQymZtnT95RUldRMxLmmT/lZMKpXRHmiGzF06GnQlBr3ZWQ2wKIqc
         qX+kMrRy0fwYowcu/31sd1b/2IsLxhtEwm2VcaJHl0sNrJWGuexDEIL2I0EGtrXWE8sb
         /l8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737721356; x=1738326156;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=szEYN8zQnG0gcSCUnmFPnsB3EmNA3yUNBw/rUjb9PM4=;
        b=gIvWVJwuC8pCnjYQWd35ZjTwKoyanBK/7/4mIdxAaGy/wJm4eHTW0fNZUQgb20Gaip
         i8BJDN+aR8/rCAYK4mIQzM4TlSvkrdOx8OvLp1kHoF3866fxPBSC0mNznlyOAXZhmKuJ
         WB+HFWxFK2Dm7QH5akCAZerOi7HTrz47TLbnH0JKVBclpyGegtaY1JKMlMGB0B0G9oTM
         GkEZt9oT5+ZUH0d3GtZoBMt9RNwZRxIzYMHw8VyC4eDOZmVLhaugVPDCSVsEyTOIfx8q
         lD0MykmJkSLXW79RPq2armkqPv62CET5naI6zb1P5j6lPHYfB12L4Natbsi9DMQOKzEi
         RZBA==
X-Gm-Message-State: AOJu0Yznn+KuzQegqDcTic9vN9dcrT8atymeg8LtFNMRPrCg+mZGyxw2
	VRW3kWJEOJ5sepFZFtAiXwaJh364KU08dLE4nEJqnbZJ/ryosQ3H0uzD+XPDr6M=
X-Gm-Gg: ASbGncu62v+RE1uqAR3BOV7BK+MVsrdVjeagob47yYed45OoLekgAGLww0zGopp6dDe
	5cWJHgKirdb+NGIddhQGTUvKD/aaqJX8olECtZc2mXUUcYRXR3WgeSn6vBGdvr+6m4V+7bH8HeW
	6fmlLm/M8H8MEFdR38XTwiXDJVXEU3i9uzAYqkAWflgFMdBGF5SNYOEcQ0uuPuyS7EMF/iguntG
	sEs4Yk5d6nG58vworcDjfYe/qjKvvgTgaLrPV+kTh0fS0SEkozObEJs5TaM6QN2rDcdYxqQvRDq
	ib03t/sPSR2yn3y6j1jB5+W5sUJjww==
X-Google-Smtp-Source: AGHT+IFgti9GL++v18Vuu5aSMXNX5Q+w15RTp21Q322vV8b77QrKdcyY4Wfn3GaDW0zxCZHGS/9tuw==
X-Received: by 2002:a17:90b:524b:b0:2ee:a583:e616 with SMTP id 98e67ed59e1d1-2f782c8fd41mr45239351a91.9.1737721355736;
        Fri, 24 Jan 2025 04:22:35 -0800 (PST)
Received: from archlinux.plaksha.edu.in ([182.75.25.162])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2f7ffb1dc56sm1685056a91.49.2025.01.24.04.22.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jan 2025 04:22:35 -0800 (PST)
From: Usman Akinyemi <usmanakinyemi202@gmail.com>
To: git@vger.kernel.org,
	christian.couder@gmail.com
Cc: gitster@pobox.com,
	ps@pks.im,
	johncai86@gmail.com,
	Johannes.Schindelin@gmx.de,
	me@ttaylorr.com,
	phillip.wood@dunelm.org.uk,
	rsbecker@nexbridge.com,
	sunshine@sunshineco.com,
	Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v3 3/6] version: refactor get_uname_info()
Date: Fri, 24 Jan 2025 17:51:38 +0530
Message-ID: <20250124122217.250925-4-usmanakinyemi202@gmail.com>
X-Mailer: git-send-email 2.48.0
In-Reply-To: <20250124122217.250925-1-usmanakinyemi202@gmail.com>
References: <20250117104639.65608-1-usmanakinyemi202@gmail.com>
 <20250124122217.250925-1-usmanakinyemi202@gmail.com>
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
2.48.0

