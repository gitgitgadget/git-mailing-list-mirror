Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40EE1FC1F
	for <git@vger.kernel.org>; Wed, 19 Jun 2024 12:57:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718801863; cv=none; b=YwA8JeyEbf91M7Zp3Fx1XVk5/Hd0jATpOse2D0+RxrI7xVBWwZpPsIbedIrp91geJyV2+p+6I1HLvAC1YKAUaTja4Gsvi9w+8ObFnTb+5nh13q53vNVk1YQFTUfRbWizkg92cBLGP6iaYE2NsKSygl2LJXL55Fepfu0JLsiXWeM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718801863; c=relaxed/simple;
	bh=mhxrpmfvvpEVNK2ly9rHMfBtK6wjQ6392IqNZrbo+Fw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pysFlCWUmljt24040bJfzwrQigkuxyH6k9bUtAXvzTC3cXoOmigaXk9/e2jpnPcRRatKya7xJ7KQIXA62gersfRBA3aG3xxHWGLdwOn8DqjcvPaZXhKZZehWKwlAuy5tlNLD+ez+wKTo2SFF6sOQ/YarQW1HGprmCToJCZQhCjM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JuHM7Vup; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JuHM7Vup"
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-57d0699fd02so749781a12.0
        for <git@vger.kernel.org>; Wed, 19 Jun 2024 05:57:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718801858; x=1719406658; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UbHsfHHqoIRRDeIgQmITeHRt7jqfUAprlb53kaHMGPA=;
        b=JuHM7VuphTV1/QsqXORy3EAbD5pjfNbAaXoI0UN/Ckv/JCzWhS7gnDzAISg4/5CsOr
         iBegAknt4HqxFyBlQyH+vH3PJZ9AE6K1u77uz/4E1Zn8VMrETJvXOcwhx48jlRqAm7A2
         AtZ1fC2XFlf/eUNOlSKh/5/ICct6fuRr3MoMJVbSYV3HUTXSh81IslsBDmhBtlCIWpIA
         f1SqndvkqGDrS3+UikTrEbyftoWVPFjo2hj5uZraoEfeF1wGHz5KrH/2T2BBwE48VdZq
         U/VVBnZK5dxrOJ2LzfyXHL7ABy+Dmcmy21OzN7BnP0twW3aeETJkP74E745VRrktVIJW
         H6rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718801858; x=1719406658;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UbHsfHHqoIRRDeIgQmITeHRt7jqfUAprlb53kaHMGPA=;
        b=WfjMv8FOzCbXEZwg8miRsoXSGHhjcwp6CTFH/+Z48bwLPfodY+r0F6wDJLH1cYPkkO
         Ui9ExIJqo09JH/ByqtKpgrgY5vuvRZSmSLSJqmHWlJwPV0nbqQ37BZLQOZpKltoWGdrd
         hG/q7kt5dptwLBMTiFRJRJNKhx/m+32+x8rkekWj3RmD/+xZ86IxhV5bxaSSiOQDfg1O
         OuZ6MhX/KzeZFzmy01CjMRJDTSrHEp5CRblfYxyhsqnU4FsNuSKKznSzpA9Xm1GQjFWQ
         c6AuQwNAlktH6oQqPo2g7bJZkNe7YRbcrFJwbAd8lt91TjHTLrdY+YIHtPSHrzmRn+Hm
         FhFA==
X-Gm-Message-State: AOJu0Yx4VRNk8eo0Gl7Ky8c60w2RNe7CserOQDm41dTBKxXSsn0AAn6y
	a2pO1Nt5KQbylnlDlFhTr/J1Z6rKymS3YzK9UislTiVLyofPobWVIfamOQ==
X-Google-Smtp-Source: AGHT+IH9K/EExKMt8vrTrJEpvwZUFnWsqBv9HRivcEp3GIXr6xKwAp80vVzBAue5BVzdoVEi/kZvSw==
X-Received: by 2002:a50:d717:0:b0:57c:b810:1062 with SMTP id 4fb4d7f45d1cf-57d07e421admr1552960a12.13.1718801858058;
        Wed, 19 Jun 2024 05:57:38 -0700 (PDT)
Received: from christian-Precision-5550.. (176-138-135-207.abo.bbox.fr. [176.138.135.207])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-57cb72e95d7sm8334237a12.47.2024.06.19.05.57.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Jun 2024 05:57:36 -0700 (PDT)
From: Christian Couder <christian.couder@gmail.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	Patrick Steinhardt <ps@pks.im>,
	John Cai <johncai86@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Christian Couder <christian.couder@gmail.com>,
	Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH 2/3] version: refactor get_uname_info()
Date: Wed, 19 Jun 2024 14:57:07 +0200
Message-ID: <20240619125708.3719150-3-christian.couder@gmail.com>
X-Mailer: git-send-email 2.45.2.564.g3a7d533bde
In-Reply-To: <20240619125708.3719150-1-christian.couder@gmail.com>
References: <20240619125708.3719150-1-christian.couder@gmail.com>
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

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 builtin/bugreport.c | 13 ++-----------
 version.c           | 20 ++++++++++++++++++++
 version.h           |  7 +++++++
 3 files changed, 29 insertions(+), 11 deletions(-)

diff --git a/builtin/bugreport.c b/builtin/bugreport.c
index b3cc77af53..b24f876c41 100644
--- a/builtin/bugreport.c
+++ b/builtin/bugreport.c
@@ -11,10 +11,10 @@
 #include "diagnose.h"
 #include "object-file.h"
 #include "setup.h"
+#include "version.h"
 
 static void get_system_info(struct strbuf *sys_info)
 {
-	struct utsname uname_info;
 	char *shell = NULL;
 
 	/* get git version from native cmd */
@@ -23,16 +23,7 @@ static void get_system_info(struct strbuf *sys_info)
 
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
index 331ee6c372..10b9fa77d1 100644
--- a/version.c
+++ b/version.c
@@ -1,6 +1,7 @@
 #include "git-compat-util.h"
 #include "version.h"
 #include "strbuf.h"
+#include "gettext.h"
 
 const char git_version_string[] = GIT_VERSION;
 const char git_built_from_commit_string[] = GIT_BUILT_FROM_COMMIT;
@@ -41,3 +42,22 @@ const char *git_user_agent_sanitized(void)
 
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
2.45.2.563.g6aa460b3cb

