Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC91924BD02
	for <git@vger.kernel.org>; Mon, 14 Jul 2025 13:27:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752499650; cv=none; b=Clqmuw5JFTvB8ST8Db89kqJn3YBnUOb3VX1H0w5ay5Gc+iAKdO0QvMYgNQWfM7rLV8GmheQYAsrHRz5Pf9UvvpoO0cUKXWviKRsI0+T8YzyP66I9JO4aCehknnYcr/+CrAviMBie79K0071fQgILaU/zE9qfE1hjH3pBSbkp8Po=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752499650; c=relaxed/simple;
	bh=VbLbGvm+PB3unTX3rlisYturvfB+j3opxessMsEPko4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MTCVnfu5ovVFRRalIkbXVadJUKwupcxSM45Dn0Lk2e57nzQ+Zbtnq1e2nn9MLEUMjDnEnoNGXdMhZivHs5Kw7+l8Ao6ZuxZGAPi0y9lxHSGRneW1b0atNO7retKE9KaY/I8+BYf+pCMe7LKklV9txzZDnW3cJ5aI4Rb1AFNJRI0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YLsNP+uo; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YLsNP+uo"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4560cdf235cso9549885e9.1
        for <git@vger.kernel.org>; Mon, 14 Jul 2025 06:27:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752499647; x=1753104447; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=le2QGaGzo0bSe4kbwhr/jCVyaZqfv5a/FTodEzgsr1o=;
        b=YLsNP+uoIbVAlzQgf3ZO6RtFtT7RmXIptTMcvH7uSIQwv72qsrIyguxpyIaaM7Jyse
         Ld7L31RO22wT+5u2d0mkPRkjUI6/o1KzAvZ1PWqrIkwKX8tsrt/qqH9KbndIce67KbSt
         m/VsjNEzzGPEX8Pump7L2QLua8D+AfPBaJ92q5k6dQ6PJkueIdtkMT+OXdbLWh9rOT6x
         xY1V1qDlfEm7R/T1ReOxSMoyNmAoPYfWD2QzIZTInvMjucBNAFjBqvCguKbWPsplXv2d
         s1KWn99BrlTD9t4SQPiQ4grlomnuzTn36rGQ2yHzwNVW6VmFHvbpJwBNLjSyj9/tYalg
         bMVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752499647; x=1753104447;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=le2QGaGzo0bSe4kbwhr/jCVyaZqfv5a/FTodEzgsr1o=;
        b=jlvbRMYnVDlyslZO3H1WSVm97KUpwz2C9Sr6PUtrCapTCPXNV23oiGqCnefYOm5It/
         Z8lY3hOfug7lXY0Yq7Sc7lUwfhOIZtKWAEESb+WIo21Rj8QtAztNwJXHhD+42jv5ULH/
         alcZnxAAX40M8Og1j/k5RgdaaQ9kDxD5cBigpwt8Z6d/VEThr1keLwD8Jj5hXie6l94j
         wk3kyBKXhdSZhgcLyldeLq8wGg9cnpgFPAF9ItYQLoQOJDc9m1l+5kdYszTH8JzCfuPh
         JNvFpYr2I6bjvByhSzFeAhrhl80W2LdUiaWvv07RYWIo+m0JZ0CsY4RIYpp06Gg/HszO
         YkDg==
X-Gm-Message-State: AOJu0Yy2kliHq/pcdM+cYLsfpNY6UNvGk3P96SFJwLCJSzR3tG70Iur/
	f9yJBNhzOazSvZ8LUsNpOmMBKoZE3pJ3d2F+G5LRc7j+RFWkPKhIIvYaGAqyJw==
X-Gm-Gg: ASbGncuDHqIb2AMvMWUmC7DMrPAoTVTe3YMEICmo9Oj9Qo/9+oqHtATSI/bk4y2vPiw
	sg2tUhTTXUKCjzBWEZqVEMnPoovL+anhXJMJOffH6LQAvZhogva/A9YjRTdiPRVnYs1wsJmhTKX
	2qG5OX5LjQB/FVkdqzVXMPU8xJ+aYvM0ljB7qWzubfRBaPu/JwxE7ljEwp9bwdZyIpdq+yptUbm
	2OIkeIwuomNXn0HYryVlhrEaY4UW2QocfyG23g1xrKqPu4GzMQVfgWYwMR6DPOkXzeq6iJDHa5U
	Ih+As58EsJSjURpk3jlbCRRYTo3pFo8uQ7z0QrRrBwKLIg8j+85x0Y5mSWcVjvHZif2t8kfoNgo
	FLShG7GEScLJm5HDPlSdABZnLlukIIH+LGScUYd6KA08e
X-Google-Smtp-Source: AGHT+IFDfDdmq+Lmly/N5lnKuCOYwyS3o6qo6pV5qxOvCnerqfMjIaExY6p3pP7VsukCgcHcQmguTQ==
X-Received: by 2002:adf:9d82:0:b0:3a4:dd02:f724 with SMTP id ffacd0b85a97d-3b5f18d2bd0mr9216438f8f.43.1752499647114;
        Mon, 14 Jul 2025 06:27:27 -0700 (PDT)
Received: from localhost.localdomain ([2a0a:ef40:7a5:4701:8cee:45ed:2bd5:e17c])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b5e8e0d867sm12616750f8f.61.2025.07.14.06.27.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Jul 2025 06:27:26 -0700 (PDT)
From: Phillip Wood <phillip.wood123@gmail.com>
To: git@vger.kernel.org
Cc: =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
	Phillip Wood <phillip.wood123@gmail.com>
Subject: [PATCH 3/3] strbuf: convert predicates to return bool
Date: Mon, 14 Jul 2025 14:27:02 +0100
Message-ID: <7eaf80420611aab498089a2bddead892330606b8.1752499610.git.phillip.wood@dunelm.org.uk>
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

Now that the string predicates defined in git-compat-util.h all
return bool let's convert the return type of the string predicates
in strbuf.{c,h} to match them.

Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
---
 strbuf.c | 28 ++++++++++++++--------------
 strbuf.h | 12 ++++++------
 2 files changed, 20 insertions(+), 20 deletions(-)

diff --git a/strbuf.c b/strbuf.c
index f30fdc69843..6c3851a7f84 100644
--- a/strbuf.c
+++ b/strbuf.c
@@ -8,55 +8,55 @@
 #include "utf8.h"
 #include "date.h"
 
-int starts_with(const char *str, const char *prefix)
+bool starts_with(const char *str, const char *prefix)
 {
 	for (; ; str++, prefix++)
 		if (!*prefix)
-			return 1;
+			return true;
 		else if (*str != *prefix)
-			return 0;
+			return false;
 }
 
-int istarts_with(const char *str, const char *prefix)
+bool istarts_with(const char *str, const char *prefix)
 {
 	for (; ; str++, prefix++)
 		if (!*prefix)
-			return 1;
+			return true;
 		else if (tolower(*str) != tolower(*prefix))
-			return 0;
+			return false;
 }
 
-int starts_with_mem(const char *str, size_t len, const char *prefix)
+bool starts_with_mem(const char *str, size_t len, const char *prefix)
 {
 	const char *end = str + len;
 	for (; ; str++, prefix++) {
 		if (!*prefix)
-			return 1;
+			return true;
 		else if (str == end || *str != *prefix)
-			return 0;
+			return false;
 	}
 }
 
-int skip_to_optional_arg_default(const char *str, const char *prefix,
+bool skip_to_optional_arg_default(const char *str, const char *prefix,
 				 const char **arg, const char *def)
 {
 	const char *p;
 
 	if (!skip_prefix(str, prefix, &p))
-		return 0;
+		return false;
 
 	if (!*p) {
 		if (arg)
 			*arg = def;
-		return 1;
+		return true;
 	}
 
 	if (*p != '=')
-		return 0;
+		return false;
 
 	if (arg)
 		*arg = p + 1;
-	return 1;
+	return true;
 }
 
 /*
diff --git a/strbuf.h b/strbuf.h
index 6362777c0a0..a580ac6084b 100644
--- a/strbuf.h
+++ b/strbuf.h
@@ -660,9 +660,9 @@ char *xstrvfmt(const char *fmt, va_list ap);
 __attribute__((format (printf, 1, 2)))
 char *xstrfmt(const char *fmt, ...);
 
-int starts_with(const char *str, const char *prefix);
-int istarts_with(const char *str, const char *prefix);
-int starts_with_mem(const char *str, size_t len, const char *prefix);
+bool starts_with(const char *str, const char *prefix);
+bool istarts_with(const char *str, const char *prefix);
+bool starts_with_mem(const char *str, size_t len, const char *prefix);
 
 /*
  * If the string "str" is the same as the string in "prefix", then the "arg"
@@ -678,16 +678,16 @@ int starts_with_mem(const char *str, size_t len, const char *prefix);
  * can be used instead of !strcmp(arg, "--key") and then
  * skip_prefix(arg, "--key=", &arg) to parse such an option.
  */
-int skip_to_optional_arg_default(const char *str, const char *prefix,
+bool skip_to_optional_arg_default(const char *str, const char *prefix,
 				 const char **arg, const char *def);
 
-static inline int skip_to_optional_arg(const char *str, const char *prefix,
+static inline bool skip_to_optional_arg(const char *str, const char *prefix,
 				       const char **arg)
 {
 	return skip_to_optional_arg_default(str, prefix, arg, "");
 }
 
-static inline int ends_with(const char *str, const char *suffix)
+static inline bool ends_with(const char *str, const char *suffix)
 {
 	size_t len;
 	return strip_suffix(str, suffix, &len);
-- 
2.49.0.897.gfad3eb7d210

