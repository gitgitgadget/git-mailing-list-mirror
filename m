Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A01892F1FEA
	for <git@vger.kernel.org>; Wed, 16 Jul 2025 09:39:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752658767; cv=none; b=lnrvR6oiFDWX4DYUwZuK3+kQWRrIjS7dy9bbsX5iJfnIibm46y/b+FYJJV47KieJ1FKXFDHRAhCm+9xNtl6Gx35ULzmMEw9KR9dn52nxhzPv1ykHYa70SUQMVx1Ek5QCMNaw9e0HxQKYguGYQjwZAUZxgrJFH71fu9kl7l/YokY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752658767; c=relaxed/simple;
	bh=VbLbGvm+PB3unTX3rlisYturvfB+j3opxessMsEPko4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=vGR5u/in0kG5XJC81mhebRKkLmOfOWIhCB1x+Qiupg//giCfyqzSVSltrE4DPwFJhZdUrlK/xVu+1uhPTbsq74dojqL09ynzWQlYOhqraGGE82H1rWuXzSwUAUaA01a5RI9yctyUsshXqcyUawVHKDYW1ndZpLhtXXcM1BAG7ZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kNPKOnec; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kNPKOnec"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-455b002833bso17175335e9.0
        for <git@vger.kernel.org>; Wed, 16 Jul 2025 02:39:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752658764; x=1753263564; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=le2QGaGzo0bSe4kbwhr/jCVyaZqfv5a/FTodEzgsr1o=;
        b=kNPKOnec/azZ7CgIoRwdngfhpDUCZ+yhF5Dlm0ntefiv0ahYHcryfH7kJop6uKsvIR
         8u13AkBi+431fMyOhI6h0qje/W+Nw8SxZ7wKV04SvkEoI9zjEI1L2iIEWkKGtNKNaUEP
         hV7jsv77UPez+3HhN8/Q8CgR0azNR/hxAOM0lmQNZMZB/QystXK+mBipO8oEoldPKISe
         S8gHpxrt1yZFY6KxGeJkSXHdDO7dOoET3xzm6M5VRiqzlkc/H39SQJQ5eBlQmVGhdFkn
         AqJwSI1L5xeHoyeIYEkSCxBU3VYqgzFt039+turJbtCypxe828IgQyjIT/MytJQvgfRj
         7OBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752658764; x=1753263564;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=le2QGaGzo0bSe4kbwhr/jCVyaZqfv5a/FTodEzgsr1o=;
        b=sMHYX+cAKoN/mwh5EEhzTiC17ImtrvZZzzEAZPE7aHLNFQ/6ZXCVm0kW8I2MRx4myh
         +xFDtVleR2NUU1XT5H6rMFnz1TtcFwC3y9Qppsrds+YlgFmwSyhzS9JdfFurXG5NWPbT
         +zAvXUOG+Ym0ej+UHRf+N0nBqMYmvI84kzvXirRYM9doSyaN/id46WZwmkJti5eVh+wk
         cmd8GCB+eK4LN4cJPiCab/nyCQqwAL8sg88H7Z1MGByAGTOn9LyPoptS2sf0mVwKB/gM
         lUBbG+CIIrAcQSAXunch7bX7Nu1w9vYDxtna2XDBUhT5/hJOvHiVpcALwTFR3YdUVDts
         v7GA==
X-Gm-Message-State: AOJu0Yy8RgmgiuHh7YOQ86ftxpRjHcnb6yKS/Dqy2oP1mMxbABD8hl7B
	R0v5eGeMcFrsjPuyHPxdJCWZx+H0P0pzPitSEKsgZ/ypDZK5ZicgdwXsNaizAw==
X-Gm-Gg: ASbGncvm0XUhOeOGqx3NwzxxZTP1LdskByoam8h3hRIByQHdC5pRbdeOikb9h9QzBCs
	zl1zPsMUsHKZntv9gZSHYozDQhHbUPAgITK/U3C87K7IarVVu4JDNcnuzaWzdfpnyGJ01V/COBl
	hOgp+eq6UU4nCOpO2OMOpHuq98bMglHmSTsXhJP0dHX6T/b/oV008G6CShphQPAb+U5U1Pi7jry
	zU4/ctGReOJanSyVfWpNRFc11Qmfa/t1CgQnl/jA8mlvA22Y1ZkI87EirAtz0BpkA1MjS4L5L1b
	gUaUCZgD8JEjp43by0PIeuDPXbpLasZIQgLuA3oAqpnibOhNxIredtdysLCxGB+xNst8Mh1X7jc
	5EOSdI5Y8xF8jR5CSzHPbp5jpH+1Kz7fIV2ZV8ARJSBSm
X-Google-Smtp-Source: AGHT+IEv5I5RdCHnH9c276hkCiaosgfp1S3gR1rOxc8y2Yw9Z+eUQNlMKlnmT+VldzkXl6rHdjPnXQ==
X-Received: by 2002:a05:600c:820f:b0:43c:ec0a:ddfd with SMTP id 5b1f17b1804b1-4562ed57638mr16088235e9.6.1752658763607;
        Wed, 16 Jul 2025 02:39:23 -0700 (PDT)
Received: from localhost.localdomain ([2a0a:ef40:7a5:4701:8cee:45ed:2bd5:e17c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4562e802ae4sm15592015e9.13.2025.07.16.02.39.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Jul 2025 02:39:23 -0700 (PDT)
From: Phillip Wood <phillip.wood123@gmail.com>
To: git@vger.kernel.org
Cc: =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
	"Brian M . Carlson" <sandals@crustytoothpaste.net>,
	Elijah Newren <newren@gmail.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Jeff King <peff@peff.net>,
	Phillip Wood <phillip.wood123@gmail.com>
Subject: [PATCH v3 3/3] strbuf: convert predicates to return bool
Date: Wed, 16 Jul 2025 10:38:30 +0100
Message-ID: <80e5cd3b9df80cbda58630cae20ff7ca44793d8f.1752658700.git.phillip.wood@dunelm.org.uk>
X-Mailer: git-send-email 2.49.0.897.gfad3eb7d210
In-Reply-To: <cover.1752658700.git.phillip.wood@dunelm.org.uk>
References: <cover.1752499610.git.phillip.wood@dunelm.org.uk> <cover.1752658700.git.phillip.wood@dunelm.org.uk>
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

