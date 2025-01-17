Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C49C11FCCEB
	for <git@vger.kernel.org>; Fri, 17 Jan 2025 10:46:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737110818; cv=none; b=IKCeQyv0ANbMF6ZZLqtE9qa5aRK1QUenacFmKe57Xo+ql4yNUecR/Ef5HG9VJCQ/vuz1lG59Q8cAqIf/8Mi8Hb4EWretkYfKXb/OnJj+sifs5oZtgeMXQBGC+6ZsfQ5mb0F/7Rfj2mDKx5blXfmit7r6aEVcrQxgKIrlUNivMEE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737110818; c=relaxed/simple;
	bh=QnqlKGrccODNLeIcH6fq7yvva2SfFRsZTjppQIBuaz4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oPA5xotmG7bBJ8vGzPawjKZJUp6J5UbuUrWlP6bZwgiWx1IvUmVuALIpnVbInygoabkj/uBWOLC08jS31tIroJLmwfiAqxlEMvEjydrhvQSyETdB6Bp7rd59b5kqidrVyn2ZYAM4es1tQHeSsYjWK6fwKLrsWw/egXx1xqGdkdU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GMGCYF1t; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GMGCYF1t"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-21c2f1b610dso20490485ad.0
        for <git@vger.kernel.org>; Fri, 17 Jan 2025 02:46:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737110814; x=1737715614; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LEOiK4Qu/cYqt0+j+Km/in7JQgblkIao7pkSH7kiHRI=;
        b=GMGCYF1tc8gGTa0hqJTybmu6fQpXBozAlkjNMCJI76dJC9x9QrVNZH0WWB44Q9Tg0l
         HIXms0vIuHmYe2dJdPDmLsW0UT1fiwMgYcAB9kxfMZUevdk2Fp5KcyepIXmcHbdneHsG
         LqmpEraV7/2QrAtlHh1W6OJ6GjlT3mJFIS2lkXJ0WMxIqtFcdBaeLuNNRppIJM4liPqX
         xqzGY1Uu/l5idNKOr3D+oiboWMG800KjPB3ql1m36QxMKB6q8d1lM0VWKmM6FFnCpTgw
         pY24zn5sp6IcwzMGkiuRZr4eTQEWqTWTBFnjOhVFeWAUfKLGCgSXHGJsPIBF+pNqIUwB
         alKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737110814; x=1737715614;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LEOiK4Qu/cYqt0+j+Km/in7JQgblkIao7pkSH7kiHRI=;
        b=ZomouY45XumpXsKfO6JXAJltU7hFmAv+6gJieCoXBQuBiBgviR+1A27ji5dPIgte5o
         oi4iJf4bEDd77shORtKkURzjecPErnN2OwbU/EQf1NFqwVD8cs0n9xUe5/klVKLtPXx3
         QnLwCyOa9mRdj3WsnS4fMqiV8Hu7kpmepIniBX1Tv3dCarBTnbcsvJpkDg4P9sETkujC
         70ldt9rxvCYBM6a/gSnJzGkyr91ujLD+NqV8RS+xfuyMfrbYYzYJzcpkTW+Z8Feksd7g
         zYc7g4tEghdDwCZbzXbQQ5t7KiMZUe2ufYlVRzSbpZMWggXFQPXW67RXVhFPe6x+bBSM
         BGwA==
X-Gm-Message-State: AOJu0YzUdwYA3wU5h1IY6imRkeRTL2WO+Cj+Wrf9pGrrn22Zs19xxXp2
	+F8lCztnq6QzyLNchyel26ZVXREot++1j5IncFEN+Sw5ICvDQDC1pzSM9cD/Zvk=
X-Gm-Gg: ASbGncuwaS2GEPaC2KpaFBM/Q89SI2XFWxM2NS1pC6N3Nq80g/Ojx8ixyU1J1Xpmw2a
	5EW/86sWR2vuEoajAZDvQ8GAarN1CqWIy+9/xtaPPdAKvObOXul+eIdD441exRBe654LI8W3zrj
	Vmi/j8hes6Eu47nnK3yPb8WWrY8N8Jc/on+aN/kSSIuJn3ERY2MLwPQMHsXZDLHhmsIjFAm1zP2
	pCy8MGtaZW1KSr+gPJgiE1qT5X/hF8ctrXFXw3ee1jD8BjzgXOnoAuVTUobpiGYlHHC7/B/kKBb
	WxGnIg==
X-Google-Smtp-Source: AGHT+IF7xp6Zcxoffs7Rq/xSufSB5QJmlzR63BofzH3c+Qq+qPxIe8PPkM6MDCd6NvedOmBxSQsA2Q==
X-Received: by 2002:a05:6a20:394b:b0:1e1:d22d:cf38 with SMTP id adf61e73a8af0-1eb214f0f61mr3326169637.21.1737110813808;
        Fri, 17 Jan 2025 02:46:53 -0800 (PST)
Received: from archlinux.plaksha.edu.in ([202.164.41.66])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72daba48eb8sm1574985b3a.136.2025.01.17.02.46.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jan 2025 02:46:53 -0800 (PST)
From: Usman Akinyemi <usmanakinyemi202@gmail.com>
To: git@vger.kernel.org,
	christian.couder@gmail.com
Cc: gitster@pobox.com,
	ps@pks.im,
	johncai86@gmail.com,
	Johannes.Schindelin@gmx.de,
	me@ttaylorr.com,
	phillip.wood@dunelm.org.uk,
	sunshine@sunshineco.com,
	rsbecker@nexbridge.com,
	Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v2 2/6] version: refactor get_uname_info()
Date: Fri, 17 Jan 2025 16:16:14 +0530
Message-ID: <20250117104639.65608-3-usmanakinyemi202@gmail.com>
X-Mailer: git-send-email 2.48.0
In-Reply-To: <20250117104639.65608-1-usmanakinyemi202@gmail.com>
References: <20250106103713.1452035-1-usmanakinyemi202@gmail.com>
 <20250117104639.65608-1-usmanakinyemi202@gmail.com>
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
index 78f025c808..96f474c8e6 100644
--- a/version.c
+++ b/version.c
@@ -2,6 +2,7 @@
 #include "version.h"
 #include "version-def.h"
 #include "strbuf.h"
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

