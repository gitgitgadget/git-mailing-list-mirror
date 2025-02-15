Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88637B672
	for <git@vger.kernel.org>; Sat, 15 Feb 2025 15:51:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739634715; cv=none; b=msyEPcIzaCXVO68sX/+PI2tfMjcq9p38h6AFSk6icdkyQZKNMr2+tix4RbJNI+b0oPeJ7RW8MGAI+6zGDrPCRQql8iyVX3hpzk5lT093/KjuNJAwyHiG7ftH8npSyQzLA7E/I2KD5h3ATY/arqqCAuID99DoWR9aOSlGH9V6ZwQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739634715; c=relaxed/simple;
	bh=HVeukTMHNYer7qqxUJZvhIb+1eODx9LL40SC14YRDMY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RsD5+Z94stPJUxR/lWU1SGpTGrW/kv0GzSLXlRbM58xwyaBRdLVHzwUYCe6ecltceccA7qzvXxz69rxHisrkEoF/hzsw4y7dNqpoiahZ7JCD7ezdeIBO34FIY52j25FhSMkD6m+MTiDdHRo39R8kK80fjc/Ml7keoLEXl9pp5QA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mxuvXUsP; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mxuvXUsP"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-220d398bea9so42971715ad.3
        for <git@vger.kernel.org>; Sat, 15 Feb 2025 07:51:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739634713; x=1740239513; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BRekefwQgvdyI8vQ9EmJX5ETxl+wxhoojclqV8SCL8k=;
        b=mxuvXUsP/Wi60xZ31VnLRseNodI4k24gwyKWBSgNO8QebJllUdOVQs8W3m+JNeobPK
         U986uZVNJnrlB601K/0iPZMmvHysajcH+srZ3QMpEzc3Bs2FzpsrzyHzG9c2WxIADoal
         bKDVD3hCK9Gj7pffwQ7otFYaO7Xo7WTY892OlzlFL28uAT5mASjqVdb8aWcV2+bg0q2A
         +f85BlDnvle+rLICuZyUwbhg9C6f83aSSgGFQUdxdEIUziSmeRY3KWCY4g1qeC5WtabC
         g8X1vjC7FBcH9q4/LKSbdzZfQd9BJMLnFAS2mYv88iRi5R8M09affalJqWPlPonhI2ol
         TYqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739634713; x=1740239513;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BRekefwQgvdyI8vQ9EmJX5ETxl+wxhoojclqV8SCL8k=;
        b=vsoKmo9FxHuzX9IDyNqFHWK1ZT+p3Xccol3JGrQa7tv5bA01jmcdxKR3BvlXy2XJt4
         NNMF7z8Nu2VldF9oIGzW0IQX5CQYC0bzlD0thqTttUn+mcMnH96Z8e3D5fS/n3i6VbZ8
         jvIllTZm1w/9MeGg0qsNyeAK7CW0sruZ4k83GiFWnV/PyC42T+riYokMZPWcam80l57G
         mFkf3td3ezu3vbUF/SW52MlDxOyyPoEzhvQhSUIgPLpiTWXQLPwhAAsXsCYLNm2NRG2a
         2LFML1AX1I8w/DZc2vikRtU2XqJEwe5QPfRBsPiylflibzVwOv0hCVHlP81uS1jxazeE
         JRug==
X-Forwarded-Encrypted: i=1; AJvYcCXe/jxeA5aFLYj4XhL/Oj4QZv06l1L0OSLo6EQjgEXCQKnqmi6XIbCIBoMsCH53f95xYFg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxSLR47FmWDP7UiOAWgtwG6sTUQ/zqrRET6t48/mYfVmyHTlejm
	yEp4kHZSiz5bZ69ULhB6Mq5TT2EEb3nqz6i0uMU0zyWqvjItNVNa
X-Gm-Gg: ASbGncvRhsHE1Yx65kSDbIjMY/0g22YBGXHtOE/3MIcq9mPmg6YgrsXt1iDe3g0XYWm
	Gt151W+/Ww9HI6s4mkpjZ2xnVGY94svY8sblMXLjpNaNjiNkvhpDkhxsYT6nOoP7HQmePSOqp72
	/faSkCXGggW6ofEvF8nnVuDniCz/xEoc2/bG/t9oZCdP0wz8/XGpEod74by7IRgdVZXP4TpjJ/2
	YVfjH6NigjvIu3l1xEWvnUAQkvNib1DjBc8/9Bpk4rKtQdMNQBuB29ulCx9B1/Tdreofu4f6Ewe
	NJa60sx+cSvf/4PhMmOWAuBW4f8dfsx98t2I0C54
X-Google-Smtp-Source: AGHT+IGJN6wHqiovDq1/vyetYvFH64a/mIVW9N3L2s0cB8mNHvPfbLNbOVdVwpBJ3kpxmQjAK83Bxw==
X-Received: by 2002:a17:902:e88a:b0:220:bf1d:41e9 with SMTP id d9443c01a7336-2210405f21fmr56334325ad.23.1739634712817;
        Sat, 15 Feb 2025 07:51:52 -0800 (PST)
Received: from archlinux.plaksha.edu.in ([182.75.25.162])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-220d559089asm45024285ad.241.2025.02.15.07.51.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 Feb 2025 07:51:52 -0800 (PST)
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
Subject: [PATCH v6 4/6] version: extend get_uname_info() to hide system details
Date: Sat, 15 Feb 2025 21:20:50 +0530
Message-ID: <20250215155130.1756934-5-usmanakinyemi202@gmail.com>
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

