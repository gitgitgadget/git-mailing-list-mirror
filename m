Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A15128626E
	for <git@vger.kernel.org>; Fri, 24 May 2024 16:39:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716568787; cv=none; b=OIzfwmUv+0coYUE5pLWD0AQqSerrTT0wvNwclx8GxYc/95cwoXGK9N06HlUp0fXAMiyx4dMl327uYCaKNjZ+YPtx+xY2KCeJpFF1jrWRrvjFJ5PqyaCwKsm1edPIIIJ7byqfGHvGxNyxw5LK9Gf7h/jP7YTvWiOtqwKgZ9cHujo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716568787; c=relaxed/simple;
	bh=uSKgHaqeLMutexFIK2ExZ6KhEX03jeEb4HMlh3GQXhw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sY1lD2ElvlqE8v83AedBHnCikCkdBEfm2+mZeuaJyGUT0tTrShIokRW0uESX0cR0T6H4KbpDkHo8X2IKcNSFux7976ohtqKqLXeqJyMhd03vxhJrQ12gqs891M+PAB9S8K3EhmHkOUO1RMiU3AEXAphvfZcoMYbioqj7n2h2SyM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KKhDESAq; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KKhDESAq"
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-35507fc2600so993513f8f.0
        for <git@vger.kernel.org>; Fri, 24 May 2024 09:39:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716568783; x=1717173583; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hkQlpKsg8mxt6rqGwtL4iATbZCcFKpElu0eviD2o7eg=;
        b=KKhDESAqZRyad5bO1O502mQ4rwAkwdPG52PttHo2eDQYkxYFVil5ZLJkZJGR7hPu+Z
         yDt265VKCBeanD+Kn1gSDL1fuEIwQZtFMKPe7vowshsLx9QR538flFJSS5lNeuTyW0Ko
         /F1hqKqz9azluPC6Hc4eH+SV7a7BykBlJ+54btr+4YzrdU2Ks6uusY8bzC4YzNz4xOuz
         rK8s8QGwUmk58B+/g5QU4C5KwGcsfvhiSeLX0aymV2yspc01RlHB+Oy5K6OyrT+l+Q1M
         id4PxVIyu2XpLD4ygtv4QTRsuzQMR86d4JT5xsfRracMvd6RKHwBuu1jzuNHZ9/eYvlu
         X+2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716568783; x=1717173583;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hkQlpKsg8mxt6rqGwtL4iATbZCcFKpElu0eviD2o7eg=;
        b=wDrzHIywLf/mzKguYnFF22wo7Xzg+oj4gjRZRzTr7eRtPB/RdLCRpA2Q5tXR9esdpH
         zkFvFrGFGCp5bsHOnwN2axvI09pgsWmjgiiwyHa872wbHgIUg1Xh5rAE+Oyyb+IEX/9o
         l0QWuvCYdp1iJKPZD7llqwFPKrfcsDQJa6UC8ziwHzgyjaGTy3VxG8rR95BKf+wAK8CQ
         LKlmdNr66DNEmXfa41IkLYj5T+3mY/eyJEIXfsmoKYliQnNmNaGndq/KvXPHdv4tNKv8
         ryb61st3bfnj0oq3bLsgMKNho760PmyvTr152/iNpAMi8j2mm2xn0VnoOeVRIZWb+lCR
         3Z1A==
X-Gm-Message-State: AOJu0Yx3G1+sebR25AWqNVmcLwrP+bgX7TbUZvBy/VtMXEQE+Jg9oSZd
	eZBqL8rTgUatvosyklqCVOjbv4vwHDD2CXUXf8YQw8k19kq09Mzm/XkBkA==
X-Google-Smtp-Source: AGHT+IGREYIpFonWgcgqFmWuuMOSaxcuaPRkmLygPUG0YPxAnuAkuVniTBgjjOkyG9ys8mTH1Rel9Q==
X-Received: by 2002:a05:6000:d88:b0:354:f34c:646f with SMTP id ffacd0b85a97d-3552fe020afmr1916241f8f.58.1716568783470;
        Fri, 24 May 2024 09:39:43 -0700 (PDT)
Received: from christian-Precision-5550.. (176-138-135-207.abo.bbox.fr. [176.138.135.207])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3557a1c9303sm1976282f8f.88.2024.05.24.09.39.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 May 2024 09:39:42 -0700 (PDT)
From: Christian Couder <christian.couder@gmail.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	John Cai <johncai86@gmail.com>,
	Patrick Steinhardt <ps@pks.im>,
	Christian Couder <christian.couder@gmail.com>,
	Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v3 1/3] rev-list: refactor --missing=<missing-action>
Date: Fri, 24 May 2024 18:39:24 +0200
Message-ID: <20240524163926.2019648-2-christian.couder@gmail.com>
X-Mailer: git-send-email 2.45.1.219.gbac909a070
In-Reply-To: <20240524163926.2019648-1-christian.couder@gmail.com>
References: <20240418184043.2900955-1-christian.couder@gmail.com>
 <20240524163926.2019648-1-christian.couder@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Both `git rev-list` and `git pack-objects` support a
`--missing=<missing-action>` feature, but they currently don't share
any code for that.

Refactor the support for `--missing=<missing-action>` in
"builtin/rev-list.c" into new "missing.{c,h}" files. In a following
commit, that refactored code will be used in "builtin/pack-objects.c"
too.

In yet a following commit, we are going to add support for a similar
'missing-action' feature to another command, and we are also going to
reuse code from the new "missing.{c,h}" files.

As `enum missing_action` and parse_missing_action_value() are moved to
"missing.{c,h}", we need to modify the latter a bit, so that it stops
updating any global variable, but instead returns the parsed value or
-1 on error.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 Makefile           |  1 +
 builtin/rev-list.c | 43 ++++++++-----------------------------------
 missing.c          | 20 ++++++++++++++++++++
 missing.h          | 17 +++++++++++++++++
 4 files changed, 46 insertions(+), 35 deletions(-)
 create mode 100644 missing.c
 create mode 100644 missing.h

diff --git a/Makefile b/Makefile
index cf504963c2..870dea2e9d 100644
--- a/Makefile
+++ b/Makefile
@@ -1063,6 +1063,7 @@ LIB_OBJS += merge-recursive.o
 LIB_OBJS += merge.o
 LIB_OBJS += midx.o
 LIB_OBJS += midx-write.o
+LIB_OBJS += missing.o
 LIB_OBJS += name-hash.o
 LIB_OBJS += negotiator/default.o
 LIB_OBJS += negotiator/noop.o
diff --git a/builtin/rev-list.c b/builtin/rev-list.c
index 77803727e0..40aa770c47 100644
--- a/builtin/rev-list.c
+++ b/builtin/rev-list.c
@@ -20,6 +20,7 @@
 #include "reflog-walk.h"
 #include "oidset.h"
 #include "packfile.h"
+#include "missing.h"
 
 static const char rev_list_usage[] =
 "git rev-list [<options>] <commit>... [--] [<path>...]\n"
@@ -71,12 +72,6 @@ static struct oidset omitted_objects;
 static int arg_print_omitted; /* print objects omitted by filter */
 
 static struct oidset missing_objects;
-enum missing_action {
-	MA_ERROR = 0,    /* fail if any missing objects are encountered */
-	MA_ALLOW_ANY,    /* silently allow ALL missing objects */
-	MA_PRINT,        /* print ALL missing objects in special section */
-	MA_ALLOW_PROMISOR, /* silently allow all missing PROMISOR objects */
-};
 static enum missing_action arg_missing_action;
 
 /* display only the oid of each object encountered */
@@ -392,34 +387,6 @@ static void print_disk_usage(off_t size)
 	strbuf_release(&sb);
 }
 
-static inline int parse_missing_action_value(const char *value)
-{
-	if (!strcmp(value, "error")) {
-		arg_missing_action = MA_ERROR;
-		return 1;
-	}
-
-	if (!strcmp(value, "allow-any")) {
-		arg_missing_action = MA_ALLOW_ANY;
-		fetch_if_missing = 0;
-		return 1;
-	}
-
-	if (!strcmp(value, "print")) {
-		arg_missing_action = MA_PRINT;
-		fetch_if_missing = 0;
-		return 1;
-	}
-
-	if (!strcmp(value, "allow-promisor")) {
-		arg_missing_action = MA_ALLOW_PROMISOR;
-		fetch_if_missing = 0;
-		return 1;
-	}
-
-	return 0;
-}
-
 static int try_bitmap_count(struct rev_info *revs,
 			    int filter_provided_objects)
 {
@@ -569,10 +536,16 @@ int cmd_rev_list(int argc, const char **argv, const char *prefix)
 	for (i = 1; i < argc; i++) {
 		const char *arg = argv[i];
 		if (skip_prefix(arg, "--missing=", &arg)) {
+			int res;
 			if (revs.exclude_promisor_objects)
 				die(_("options '%s' and '%s' cannot be used together"), "--exclude-promisor-objects", "--missing");
-			if (parse_missing_action_value(arg))
+			res = parse_missing_action_value(arg);
+			if (res >= 0) {
+				if (res != MA_ERROR)
+					fetch_if_missing = 0;
+				arg_missing_action = res;
 				break;
+			}
 		}
 	}
 
diff --git a/missing.c b/missing.c
new file mode 100644
index 0000000000..ce3cf734a8
--- /dev/null
+++ b/missing.c
@@ -0,0 +1,20 @@
+#include "git-compat-util.h"
+#include "missing.h"
+#include "object-file.h"
+
+int parse_missing_action_value(const char *value)
+{
+	if (!strcmp(value, "error"))
+		return MA_ERROR;
+
+	if (!strcmp(value, "allow-any"))
+		return MA_ALLOW_ANY;
+
+	if (!strcmp(value, "print"))
+		return MA_PRINT;
+
+	if (!strcmp(value, "allow-promisor"))
+		return MA_ALLOW_PROMISOR;
+
+	return -1;
+}
diff --git a/missing.h b/missing.h
new file mode 100644
index 0000000000..1e378d6215
--- /dev/null
+++ b/missing.h
@@ -0,0 +1,17 @@
+#ifndef MISSING_H
+#define MISSING_H
+
+enum missing_action {
+	MA_ERROR = 0,      /* fail if any missing objects are encountered */
+	MA_ALLOW_ANY,      /* silently allow ALL missing objects */
+	MA_PRINT,          /* print ALL missing objects in special section */
+	MA_ALLOW_PROMISOR, /* silently allow all missing PROMISOR objects */
+};
+
+/*
+  Return an `enum missing_action` in case parsing is successful or -1
+  if parsing failed.
+*/
+int parse_missing_action_value(const char *value);
+
+#endif /* MISSING_H */
-- 
2.45.1.219.gbac909a070

