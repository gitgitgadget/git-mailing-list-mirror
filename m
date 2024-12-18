Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B1F7487A5
	for <git@vger.kernel.org>; Wed, 18 Dec 2024 03:28:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734492489; cv=none; b=AmtnVK2Ap5zQdv7gMpXWvbE6qYzhKhd4cHcCT+EX8yh2LfqegD1ph3eIpJiQM3YnjzAjFEDWOz+/BptI9cE6nZtI3aFYoQLTlgMz470DRRAcT0qXAybJd8hrdzh4Uttdkq3YmhjhLWmyO/yc95Rb+PQ5BfXIDvXQKvGCSU5fiJ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734492489; c=relaxed/simple;
	bh=DaY2oHTAUFG44s38BLbnpbzsOTJhGyibIsL5lwi3c6U=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=tJAkiUBEmc7aNbd4J1qF/z/Wba4FOgOSj45NSdzv4QFxkLIMdwXvRmiJJKpiwUlFLwch8efu/ibFK4qTrmDrfOJaStycN3Chx5SoCRDSJA9LutdK1PvY9jB5tCMlw3g2ucl6jhK2j7KHMyNu7Zs6hOxc5+qpC1aBMS5ihMvhx6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Oz53MlZC; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Oz53MlZC"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-43625c4a50dso41728945e9.0
        for <git@vger.kernel.org>; Tue, 17 Dec 2024 19:28:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734492485; x=1735097285; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vvxD+9mb4hmNHCZ/Kesi3Ai0tEiyQEgquJojMO8SHcs=;
        b=Oz53MlZC/glT2K0ApufW/6TyQDazJ/7aQKpOryBc9WYD8NvC1awJd0eEPczARVrwYh
         ANWyg40rVAh3oYDbxtfGB2L0yRlIan7ZLZYWEbAqu/xCFZWXGa1wjX6qdW5LqlyI1C71
         /EZVfzTn9Yz+9dHl8ctZAC5+OeZ+QvAh4lrZ8QwPiVofvQvOdeBHvBeCAgUMjWAiQDBN
         /nMQbLIamiV3O283vDPZp2OS41E3Wj1tBlJ+HMRXyquCl2pZmKOjnHnAxaimPCvTnYWB
         3XZ1z51Z58XWwQ61woBchpRyh+J0PbppnJZKSzqVogJI18oHflQAm8po4UDO2A65UXDv
         XeZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734492485; x=1735097285;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vvxD+9mb4hmNHCZ/Kesi3Ai0tEiyQEgquJojMO8SHcs=;
        b=lS1j3S6waRPSGcnl9HEAkcLspQfT0HZyDQCBZaqQMjOsJLuFeh3EPWf8uUU1XIJkxX
         GBoavt1C5P0137X7ydiQ7SkpqIpyq4UV1qBdjCqbxVLQK9/d7SKc0xwmFpEXEXN/nJeA
         rr1+wDL308OvUGwth7ZUaz2LxA8t1YJQEHarYwEI5ygDAg8DKZt8oV/7lcBjTjSiC5Vi
         m83ugwyGQlA8sLysSvT/RHQTmqD4fenYb02j5gLbF8zqszLKyR17BpSxPDbjJS6EAbVS
         0x94+pn5o199rvO+VX4IbonDQvPqPhmnleARMIqmn+VjNNsbNXDzIUdbPGa5aTmip7vt
         7J1g==
X-Gm-Message-State: AOJu0YwSR+W6s6suU/c5/xoG/Jf29J+jeeqalas9IY7N8jrW+zhTwKtE
	DD0hIUrnVO8UjBnBrOBZCqPyz90iHAesSPCOeS5Fio1IrHmpux/Jdkpwnw==
X-Gm-Gg: ASbGncuxKV42nMQyzhCnj12/m94LEOFRquxEtM+em9diooekZ/VuQcHxZw2mDvI1m3H
	myKua3GEuPP2kV7DSAA7/5M3boFIDna3V+l3fN4OCZqpWwlBhBOxvtWRGLBAHwyLz4P0yFxKYUQ
	vnYUGcPV0+zEputUBeN6dzG4n+a00dojEfEXGWzF02RxgDHuBfgjjOUuW9OBeVk0PheLQDpydk8
	eJvEB9DCZj+lkuk4zUgLy4w55lOGp9W5M6MycSwo/kwuuwOmcfo49r/vg==
X-Google-Smtp-Source: AGHT+IE888IyH78l+6wUUsccTSEOzaDNpHh8VVLBmdJvDhVqDtgWGi0ItShpQm2CzizaAYryoGv3uw==
X-Received: by 2002:a5d:59ac:0:b0:385:f840:e613 with SMTP id ffacd0b85a97d-388e4db57a9mr908197f8f.51.1734492484766;
        Tue, 17 Dec 2024 19:28:04 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-388c8012105sm12659990f8f.16.2024.12.17.19.28.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Dec 2024 19:28:04 -0800 (PST)
Message-Id: <pull.1439.v3.git.git.1734492483383.gitgitgadget@gmail.com>
In-Reply-To: <pull.1439.v2.git.git.1674160131967.gitgitgadget@gmail.com>
References: <pull.1439.v2.git.git.1674160131967.gitgitgadget@gmail.com>
From: "AreaZR via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 18 Dec 2024 03:28:03 +0000
Subject: [PATCH v3] die: fix inconsistencies with usage header
Fcc: Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
To: git@vger.kernel.org
Cc: AreaZR <gfunni234@gmail.com>,
    Seija Kijin <doremylover123@gmail.com>

From: Seija Kijin <doremylover123@gmail.com>

The headers for the die and usage functions
have different parameter names or are missing
the "NORETURN" attribute

Signed-off-by: Seija Kijin <doremylover123@gmail.com>
---
    die: fix inconsistencies with header
    
    The headers for the die and usage functions have different parameter
    names or are missing the "NORETURN" attribute

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1439%2FAreaZR%2Fperror-v3
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1439/AreaZR/perror-v3
Pull-Request: https://github.com/git/git/pull/1439

Range-diff vs v2:

 1:  c3b436cea9d ! 1:  e02d5982a4f die: fix inconsistencies with usage header
     @@ Commit message
      
          Signed-off-by: Seija Kijin <doremylover123@gmail.com>
      
     - ## contrib/credential/osxkeychain/git-credential-osxkeychain.c ##
     -@@ contrib/credential/osxkeychain/git-credential-osxkeychain.c: static char *password;
     - static UInt16 port;
     - 
     - __attribute__((format (printf, 1, 2)))
     --static void die(const char *err, ...)
     -+static void NORETURN die(const char *err, ...)
     - {
     - 	char msg[4096];
     - 	va_list params;
     -
       ## contrib/credential/wincred/git-credential-wincred.c ##
      @@
     + 
       #define ARRAY_SIZE(x) (sizeof(x)/sizeof(x[0]))
       
     - __attribute__((format (printf, 1, 2)))
     +-__attribute__((format (printf, 1, 2)))
      -static void die(const char *err, ...)
     ++__attribute__((format (printf, 1, 2), __noreturn__))
      +static void NORETURN die(const char *err, ...)
       {
       	char msg[4096];


 contrib/credential/wincred/git-credential-wincred.c | 4 ++--
 usage.c                                             | 6 +++---
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/contrib/credential/wincred/git-credential-wincred.c b/contrib/credential/wincred/git-credential-wincred.c
index 4be0d58cd89..9e1b590d27b 100644
--- a/contrib/credential/wincred/git-credential-wincred.c
+++ b/contrib/credential/wincred/git-credential-wincred.c
@@ -12,8 +12,8 @@
 
 #define ARRAY_SIZE(x) (sizeof(x)/sizeof(x[0]))
 
-__attribute__((format (printf, 1, 2)))
-static void die(const char *err, ...)
+__attribute__((format (printf, 1, 2), __noreturn__))
+static void NORETURN die(const char *err, ...)
 {
 	char msg[4096];
 	va_list params;
diff --git a/usage.c b/usage.c
index 29a9725784a..991efe25a54 100644
--- a/usage.c
+++ b/usage.c
@@ -210,7 +210,7 @@ static const char *fmt_with_err(char *buf, int n, const char *fmt)
 	return buf;
 }
 
-void NORETURN die_errno(const char *fmt, ...)
+void NORETURN die_errno(const char *err, ...)
 {
 	char buf[1024];
 	va_list params;
@@ -221,8 +221,8 @@ void NORETURN die_errno(const char *fmt, ...)
 		exit(128);
 	}
 
-	va_start(params, fmt);
-	die_routine(fmt_with_err(buf, sizeof(buf), fmt), params);
+	va_start(params, err);
+	die_routine(fmt_with_err(buf, sizeof(buf), err), params);
 	va_end(params);
 }
 

base-commit: d882f382b3d939d90cfa58d17b17802338f05d66
-- 
gitgitgadget
