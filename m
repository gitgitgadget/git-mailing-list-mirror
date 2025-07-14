Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BE7319AD48
	for <git@vger.kernel.org>; Mon, 14 Jul 2025 13:27:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752499649; cv=none; b=koQ8d1bzK1JwHPYLueQwKagwdzozoM2J5Fw+orkGuVfOzRTkKeEA79uSm1qjjb0JSUwVE06yxtjHw7dCL4I57x4mg1zzl65h5278Uj2tMUxf8Ne5G7M0kXmZBYG6QyxuPzsMf4XDk64HpUUNWAjDvuEhJ+qIX4tz/Ho7+Q6gZS0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752499649; c=relaxed/simple;
	bh=82JzcfEKMyPuj0o4htb8z/eHkVIXWj6XCi+UIuN5qJk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=f/cNC7ABo6MI/wHGXx3hG6eSYVHexnW3B88D+f2OS+jjHoG5tKzdeS4Hf2vCrp+larQdK8tXWislwZd3GJSPDGtU1bq5BLHwyiQgXHJBLpTPEPz4sEFgf1uuWdd6PfAA/xkYH5KYEsVUiyw5pe1/cC0mpgTPzmlE3FoMFuYAt94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Jdokhz3d; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Jdokhz3d"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-451d41e1ad1so29732645e9.1
        for <git@vger.kernel.org>; Mon, 14 Jul 2025 06:27:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752499646; x=1753104446; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ksESnWSI+ueX72mmMFAROT6No+8jiXNM/AR8h42fwIs=;
        b=Jdokhz3dzoE5j74a61AFgb/fH3Kxzgggp7p6PITdL2m5snT+nRtw4dyxTz/41gewzj
         gwWwlXqchWpLcaTkfNbp5nIkeE21adjQlErg0B5+DuylxJ9g4LAUJ4JuneA5MikzaXVX
         KFow+6bnJT/cRGIvLBmayfX7btgmyEIFAkdY++M0YJhkdqSNxbQ6OkUEP7LqjxWJkr2M
         XRxp7ECZ1ViNJ/R5oDJHp699G2r/rJlaeTFspuJDFB+vqnIU43oCbNAJXRE53f/o3UYO
         E6V1CPn5SXyLyxdfZS0u6GvzX+T4uGI1cwVXltdys0xShMYaB8gZ6oq6kaPoPN6492Ta
         5A1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752499646; x=1753104446;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ksESnWSI+ueX72mmMFAROT6No+8jiXNM/AR8h42fwIs=;
        b=gUl6iR5AUMVpxsyYNI4Vovrc2pwZqSNz8i4/pmmDof5meoZ752wVz+DrJcsmIVGBD0
         QYCLMuROhDcmB4EUzvlyaAU6k4tLuhbtOiUv3vFqefMa27gBOwOCU5h3MDqiecQn9SQP
         7wZtoErc1prmqTyuxAsKWk67vO5zdKN/Mp6h6yP/vli1jE9rC3NvTL5Ukt/x6qpWrKVY
         /T3YqPuzEU9cWljT+6KGP3E17ykR1NUwlj78NV2bRQjInpk6ZI4KyPaplc6MZT7TsY04
         dA07wWNu7MatWaSoQCe+XInOOW7QTDSIpYE3Sh3l7t7brq1CXM0r9gn724O0qv1v7sdW
         p/aw==
X-Gm-Message-State: AOJu0YxIWpg+sqIla1aq08QaPkX6z34HbK8i1p1gWnIklifXIgTiRxDM
	x6jGpljaLSC4if5I3KSOxVJ4J4QS9iW3so+aYGE/H3fEWFbaoY/JlkAryM1Wyw==
X-Gm-Gg: ASbGncseJ9HLha5qKOSWuraBWi/kFurzYkLHx8FloV+M+ZoUAMkHyZzoqRU2KHCm0jb
	LHUqA1kXvYcerLTAXy8+qeje0llvFOysVg6iHWFDzc+87QvJlVIA4wiih5GN0mQ6Uz/SqnnjM3Q
	4enWXvv4b1MBpw5DKNXaT7kHDN1DGEzRDmTsBoohSrMxaFYN/pzJR9NqhwEFmxuHIcOUwIqhq50
	jqLke3aEiWYNFSboK1V6j3mWvAnEgRP0XkdajzswitshgVTC8G7Nv3JE2ElvkKvqmyXa6a978cT
	asY1ILrx22Yx0vVSrJ6CnUdU8CzKQtRPDTBzy8vtqkNpeKnhgBzGjhwvTVTN95TAOwFgWn0TmFu
	UTarw4kB/OQLzOBcxbh5ACDEo5XVe7g0749zYKtNhWcH8
X-Google-Smtp-Source: AGHT+IG8oHwawtJPkRWOxrMsRGXyaDxKyU7rAkcimQCvX9u+FUIjz8jKhpJESxviy50BU6/BkfsZJg==
X-Received: by 2002:a05:6000:401e:b0:3a5:26eb:b4af with SMTP id ffacd0b85a97d-3b5f353066amr7594035f8f.18.1752499646176;
        Mon, 14 Jul 2025 06:27:26 -0700 (PDT)
Received: from localhost.localdomain ([2a0a:ef40:7a5:4701:8cee:45ed:2bd5:e17c])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b5e8e0d867sm12616750f8f.61.2025.07.14.06.27.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Jul 2025 06:27:25 -0700 (PDT)
From: Phillip Wood <phillip.wood123@gmail.com>
To: git@vger.kernel.org
Cc: =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
	Phillip Wood <phillip.wood123@gmail.com>
Subject: [PATCH 2/3] git-compat-util: convert string predicates to return bool
Date: Mon, 14 Jul 2025 14:27:01 +0100
Message-ID: <a0f9182aa20d0f956072a3d185a2d1288f1bd842.1752499610.git.phillip.wood@dunelm.org.uk>
X-Mailer: git-send-email 2.49.0.897.gfad3eb7d210
In-Reply-To: <cover.1752499610.git.phillip.wood@dunelm.org.uk>
References: <cover.1752499610.git.phillip.wood@dunelm.org.uk>
Reply-To: Phillip Wood <phillip.wood@dunelm.org.uk>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Phillip Wood <phillip.wood@dunelm.org.uk>

Since 8277dbe987 (git-compat-util: convert skip_{prefix,suffix}{,_mem}
to bool, 2023-12-16) a number of our sting predicates have been
returning bool instead of int. Now we've declared that experiment
a success lets convert the return type the case independent
skip_iprefix() and skip_iprefix_mem() functions to match the return
type of their case dependent equivalents. Returning bool instead of
int makes it clear that these functions are predicates.

Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
---
 git-compat-util.h | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/git-compat-util.h b/git-compat-util.h
index 5bd69ec0403..9408f463e31 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -897,35 +897,35 @@ static inline size_t xsize_t(off_t len)
  * is done via tolower(), so it is strictly ASCII (no multi-byte characters or
  * locale-specific conversions).
  */
-static inline int skip_iprefix(const char *str, const char *prefix,
+static inline bool skip_iprefix(const char *str, const char *prefix,
 			       const char **out)
 {
 	do {
 		if (!*prefix) {
 			*out = str;
-			return 1;
+			return true;
 		}
 	} while (tolower(*str++) == tolower(*prefix++));
-	return 0;
+	return false;
 }
 
 /*
  * Like skip_prefix_mem, but compare case-insensitively. Note that the
  * comparison is done via tolower(), so it is strictly ASCII (no multi-byte
  * characters or locale-specific conversions).
  */
-static inline int skip_iprefix_mem(const char *buf, size_t len,
+static inline bool skip_iprefix_mem(const char *buf, size_t len,
 				   const char *prefix,
 				   const char **out, size_t *outlen)
 {
 	do {
 		if (!*prefix) {
 			*out = buf;
 			*outlen = len;
-			return 1;
+			return true;
 		}
 	} while (len-- > 0 && tolower(*buf++) == tolower(*prefix++));
-	return 0;
+	return false;
 }
 
 static inline int strtoul_ui(char const *s, int base, unsigned int *result)
-- 
2.49.0.897.gfad3eb7d210

