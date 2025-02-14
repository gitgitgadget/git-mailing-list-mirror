Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DBF5263F23
	for <git@vger.kernel.org>; Fri, 14 Feb 2025 12:37:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739536675; cv=none; b=l2Me27bS5kDVT2xeQoF/HV/gEUodt0HrmX8rxOVSY+4VZApF6j6a9aSUneX56ZZneviIMv2iVsaO9MkazmYD+oUPGyrgfDdTYwoAeKCYQJHjYposS1zfnITefmhEDI9op1PmaQWgiuf37my18Co+TzNs9WsNmp2RK6ouyU2jHgw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739536675; c=relaxed/simple;
	bh=42i8PUdjyKs+NSwGtLcbj9v39QXr3Du2dpk4eqznw+0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PKS5IABkqxRdu3VtOqQUFsAcHEwM0ZVyU40xuni3zKAqoA4uc5wwuqE49MwqiCDkCQVVQXp9tzgDZgr+qdPV863eoAoV6Z1Iqu8v9FJu+dlix5kX7AMZPUqXrAFRgJ3dsGsHXcl7SR0CJ5DQ0OGp9X6XiRn0tMc8hiN0ixHRkag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SYCePan+; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SYCePan+"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-219f8263ae0so33322495ad.0
        for <git@vger.kernel.org>; Fri, 14 Feb 2025 04:37:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739536673; x=1740141473; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ST9UH+tJO/KD1eiPpPYLssoj13nQqfVGYdBzpY/GozQ=;
        b=SYCePan+HYMypEattmEetFPSsRrEJZpgc9a9n9UVM4J78ebyv5rkI3uhW6NSvPbdgl
         83ziCDK2onUY9Zb94peYv6tbHWCVWrrLiDlnUJKGtra7OBsx0GAe2VuXlKe9j+RibgN2
         E9i79fIkU06R+UXDXupe4N/nVwG/d6DwVwwKapGPd4G41814+IOy1xyJqzrovZWg6wX1
         1BNrxKVNqZRHd8I39PWCiQc/JWS666Gp/krhvSF45HBS5iU2zjPnUbEIF6D2oxLkzVyc
         OG+8uHuXMotenfm4mp7solimEnh9nJ7FUnrQ366uOdsR4DtFcjHBCbk6DoOnd9fkjdMW
         85rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739536673; x=1740141473;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ST9UH+tJO/KD1eiPpPYLssoj13nQqfVGYdBzpY/GozQ=;
        b=DNGKSNE1nUmgEFSZ6EqIXKtvalaLBuZ1CBKrpaZV7ajfTrBIhK5EiQo2SQDHP99RiS
         P70lPIyQL3rsEdndt3JzLLP6N9qACLb5UoK+Jy9d7uipBK6aVH/+PXb9tZQT+gbz5Rsa
         Fijukbt6tLP8WIcPZJ/WZZg+Av6ov6OUkx9H1hKFLVvhjQSaueE6n35k610Ejo1NLfmi
         f8QuHBcnykVUe1d4w1Hkpy0/Cvko79332TOJL9Zb/xntXqsGcSWTFNm/UWhPaMDha1en
         fEO2EWEuM7nl5dMKpqze/lcnA0y+45oxHiWPThNqVcBD0BM9ymUu07+7WOP4nhHeYNnk
         nghQ==
X-Forwarded-Encrypted: i=1; AJvYcCWMbHV/t5eY6Ant+zA7ggC27Gw4LVPlFw30bMzGVmZTlE3/7W8la866ulw0ILjwsLqHFiw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyMnnkpUM0gLhYyZYyd/RHJESNR2znaE2rXS2BZAhiUv6cVxHpl
	pyZaq5MFu/CCjh0gI0eD7UsPU0uObxn8RvaSKtZolvrlNOpZOe8B
X-Gm-Gg: ASbGncvE07Ld7trxmDMiNL7T9dtvNOtSmOAt61y33JqvuEWNKlSe9eiQ8uqJEhFVsst
	3Ape8zYg/zZPXgjt2HIUu6HNPCqoc3KXQc+kgvDKJQbj3BaxN79aIEsKijz6xwzyzzMlFGr/u4w
	ROYwDevN/VNI25kvM8/QChJ55gu9Pqxxo+sy6Icwv3oixb52fehibIOSdya+o0U5/DaWZGshDOg
	jrxxkJpZvaXwd46w0PL34FmUkq5XoFDHIcnbIGiAAvzSVeh6luQCTbezpDFr7YEDT7VbNut8eRd
	BwOOm37BFegI4jWWGIgFBj32AaPTBrOGwfZtUmi8
X-Google-Smtp-Source: AGHT+IHkwkzIx8pcCSLAHTO4BNhhuJuK1PPDOfgbOIjM48czG1NLzt5a246xc4Mrd/4wpsq9z4lr9Q==
X-Received: by 2002:a17:902:f54a:b0:21f:6dca:6932 with SMTP id d9443c01a7336-220bbc7f9bamr191186955ad.43.1739536673417;
        Fri, 14 Feb 2025 04:37:53 -0800 (PST)
Received: from archlinux.plaksha.edu.in ([182.75.25.162])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-220d545d09esm27814775ad.112.2025.02.14.04.37.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Feb 2025 04:37:53 -0800 (PST)
From: Usman Akinyemi <usmanakinyemi202@gmail.com>
To: christian.couder@gmail.com,
	git@vger.kernel.org
Cc: Johannes.Schindelin@gmx.de,
	gitster@pobox.com,
	johncai86@gmail.com,
	me@ttaylorr.com,
	phillip.wood@dunelm.org.uk,
	ps@pks.im,
	rsbecker@nexbridge.com,
	sunshine@sunshineco.com,
	Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v5 3/6] version: refactor get_uname_info()
Date: Fri, 14 Feb 2025 18:06:13 +0530
Message-ID: <20250214123734.1403120-4-usmanakinyemi202@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250214123734.1403120-1-usmanakinyemi202@gmail.com>
References: <20250205185246.111447-1-usmanakinyemi202@gmail.com>
 <20250214123734.1403120-1-usmanakinyemi202@gmail.com>
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

