Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B241263F49
	for <git@vger.kernel.org>; Fri, 14 Feb 2025 12:37:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739536680; cv=none; b=iYoJhv2KeI2X0OfuC4DOXjJ6sJfF1uxyHY5j3k5g/pt4v8qevVe+iRiSfEUoyKKjSv52XuPjBiM8qcX7UU83iZH+LrWRFbz6XDszEvL2kabe4EP8khuHGqy0NxsGCE1D0CXAin0djzWgW96w60mEsAWXme5HxtZcBHUyFAAZPQA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739536680; c=relaxed/simple;
	bh=HVeukTMHNYer7qqxUJZvhIb+1eODx9LL40SC14YRDMY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ug1F0t1CEJrQkJuZjJ7KYL5bFA6lB4ALNV7ghi2wYLf21QO10A3kwp3wKDNoMgyyLhoPoRBFgdit10jUfpq1I7R+/KzHEWercLamWOw2aqc+T0r9gN7UDBXyiiLt2IMifKpz0B094hAkxZaSOpW6BC3R7m++hR4orktOcd/1f3A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EoZ5WM+k; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EoZ5WM+k"
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-2fa4493a695so2959632a91.0
        for <git@vger.kernel.org>; Fri, 14 Feb 2025 04:37:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739536678; x=1740141478; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BRekefwQgvdyI8vQ9EmJX5ETxl+wxhoojclqV8SCL8k=;
        b=EoZ5WM+keK6bZBWv5jJNb61D9Jhdh4hxP+SEyBGnMlu8tNZ1ffI5OTaaUGjD0AMw6m
         JTFbY2gytqIRfypt9S/9U1cqKVWdBRhygFp7Kf59iCNAYlIK4ILHuIC5QEmdURh4y+Y2
         5MnE9XP54OJe/NY8unBMsd0oZ+Xge3CuPI0G5/poXZvFfZDwFvy9SgaRn/Mz6gGQQW5G
         IKWPfGZvDmZZ07Kiq8Bzr9sB01B+oINdcPi2yk9VkWxD7wVu5eQ0zDQ7Rz7fc0Ji35xs
         rVpMVqYLVD8FSC59ipsAd2ET/8+DsffZEy0n2IXdcy6UVGNdpUtiHoNC5dwAiXgrP5WX
         Relw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739536678; x=1740141478;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BRekefwQgvdyI8vQ9EmJX5ETxl+wxhoojclqV8SCL8k=;
        b=bxMhDKD/tF7hVVZfJ7HsPP5E+nBSofVAmvZbKwsH98kB/3fcckyBab7caBuJVZRBST
         So0w466w7P0bF9GYMHjQr4J/C8yY+F+XoYNKvar3+CdL2q2COmhHh2J5TOllV4e3Ys8Q
         ft7+BbuBHqtaGF4o5pns0KNbhoflnAREcBoUgcorVnS1GKUu+G8TQopg+T99ny4DzlKh
         omdormdd1OaU9vF5b0JCZ+Bx/U3W+g7HNmOy334PmaiGiqhVEO2wIq101jNu35l4rEuT
         ftscecbP/fpXdenFY64H4qoEosoWEvy2f2hgK5Xv0HJA9bDJHrdMD0IWyGUKvfZmZijy
         +tZA==
X-Forwarded-Encrypted: i=1; AJvYcCUIKNTWnkUgUfsa2RDrATfIQZFgMKQVcSWznV7pWEzW8UtjtZwGCQGg2dNVdhLpXW6VYjY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy5rOrMXHDCHOO8+BfThUD7QzZsWpKUXsYrvI9WA5MQIC65ranq
	Qfh+m+bBSxRYJUALELUr44zLTIwds+UkYlx86IYSCv6D63MEy1xi
X-Gm-Gg: ASbGncuajxHo5UH3WLX7AT6/I3Y4XHVhZpeCj9nfth3HZZwAjYDZDhf8K/U7d0B8yyJ
	fBRxz97kbdiCA0igt8CIrLsUFtAX6XjvRJraGeY4xOvw5oKgngxhXfWMigM9z9BIrwAcvGC1j5J
	nbUTfZKWVnFSwaYDRrdBLEBeXDk3KHW7xChiW4q15JegG68khdvPk29rpv24LSyLGQB9yfcisov
	IZ9wOk347kpEeGtXns191UQ1a8VreL5MateJ00oknDfYI3G3/mYpF9n+5mvSwrpkDkENYEry9kt
	Qvd4vXMnEaQJkNiphwNYdnMFDZQuWSR4w3gYx93k
X-Google-Smtp-Source: AGHT+IFGXwUcB0PEOCFA4HbcHxi5f2EcLRmiVnLsJvGLmFKknAP4B4DdHNDbi/HKJ3A7ZknVnFaCLw==
X-Received: by 2002:a17:90b:1d8e:b0:2ee:f440:53ed with SMTP id 98e67ed59e1d1-2fc0f0e4798mr9766756a91.31.1739536677798;
        Fri, 14 Feb 2025 04:37:57 -0800 (PST)
Received: from archlinux.plaksha.edu.in ([182.75.25.162])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-220d545d09esm27814775ad.112.2025.02.14.04.37.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Feb 2025 04:37:57 -0800 (PST)
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
Subject: [PATCH v5 4/6] version: extend get_uname_info() to hide system details
Date: Fri, 14 Feb 2025 18:06:14 +0530
Message-ID: <20250214123734.1403120-5-usmanakinyemi202@gmail.com>
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

Currently, get_uname_info() function provides the full OS information.
In a following commit, we will need it to provide only the OS name.

Let's extend it to accept a "full" flag that makes it switch between
providing full OS information and providing only the OS name.

We may need to refactor this function in the future if an
`osVersion.format` is added.

Mentored-by: Christian Couder <chriscool@tuxfamily.org>
Signed-off-by: Usman Akinyemi <usmanakinyemi202@gmail.com>
---
 builtin/bugreport.c |  2 +-
 version.c           | 16 +++++++++-------
 version.h           |  2 +-
 3 files changed, 11 insertions(+), 9 deletions(-)

diff --git a/builtin/bugreport.c b/builtin/bugreport.c
index 5e13d532a8..e3288a86c8 100644
--- a/builtin/bugreport.c
+++ b/builtin/bugreport.c
@@ -24,7 +24,7 @@ static void get_system_info(struct strbuf *sys_info)
 
 	/* system call for other version info */
 	strbuf_addstr(sys_info, "uname: ");
-	get_uname_info(sys_info);
+	get_uname_info(sys_info, 1);
 
 	strbuf_addstr(sys_info, _("compiler info: "));
 	get_compiler_info(sys_info);
diff --git a/version.c b/version.c
index 3ec8b8243d..d95221a72a 100644
--- a/version.c
+++ b/version.c
@@ -49,7 +49,7 @@ const char *git_user_agent_sanitized(void)
 	return agent;
 }
 
-int get_uname_info(struct strbuf *buf)
+int get_uname_info(struct strbuf *buf, unsigned int full)
 {
 	struct utsname uname_info;
 
@@ -59,11 +59,13 @@ int get_uname_info(struct strbuf *buf)
 			    errno);
 		return -1;
 	}
-
-	strbuf_addf(buf, "%s %s %s %s\n",
-		    uname_info.sysname,
-		    uname_info.release,
-		    uname_info.version,
-		    uname_info.machine);
+	if (full)
+		strbuf_addf(buf, "%s %s %s %s\n",
+			    uname_info.sysname,
+			    uname_info.release,
+			    uname_info.version,
+			    uname_info.machine);
+	else
+	     strbuf_addf(buf, "%s\n", uname_info.sysname);
 	return 0;
 }
diff --git a/version.h b/version.h
index afe3dbbab7..5eb586c0bd 100644
--- a/version.h
+++ b/version.h
@@ -12,6 +12,6 @@ const char *git_user_agent_sanitized(void);
   Return -1 and put an error message into 'buf' in case of uname()
   error. Return 0 and put uname info into 'buf' otherwise.
 */
-int get_uname_info(struct strbuf *buf);
+int get_uname_info(struct strbuf *buf, unsigned int full);
 
 #endif /* VERSION_H */
-- 
2.48.1

