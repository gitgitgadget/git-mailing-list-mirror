Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD0D617AD6D
	for <git@vger.kernel.org>; Thu, 18 Apr 2024 18:41:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713465666; cv=none; b=hAa+ZEv2+KakF3Tq3LGXeNqM2xKXWvDI0ji7/2HX4oqo4LUr2vCcb4BcVLQtgTUsDWCiM11m24pCI5SNm7CMEDr1Svr7ugr+WNgGjTvU6nYTOuZjRNKu9f8un7qGuPrOV+k/Pebh2qwvbZjTc1bc6WMpkR3fVBBjUQxSO5mNnv0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713465666; c=relaxed/simple;
	bh=eJiIdjd6VUFH7PtnH1HmEzX+CDrSqTqhklS3Yy+QoYc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OMTv6UUgcDcx6O6ytxuG09D26zymJGE/E+mRGrWEO4CJQNNpm7FWU/w8Lejr7EdzG6QRMpgDDytIex5jqMNg0U7N7S2m4RDEgvbfCZcFuGuElGK4D4Z3nmEkEmjTjEKRolGof7mY8rAFqQkcvMXpEHHesz6b0AjiKShqgJneeSA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K8hg/x8m; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K8hg/x8m"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-415515178ceso9261235e9.0
        for <git@vger.kernel.org>; Thu, 18 Apr 2024 11:41:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713465662; x=1714070462; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=laVV1Obq0tF6Jin7XzdFzBf2EBgBpO+6tCHi5aSP1wA=;
        b=K8hg/x8mou2B/jQk2y6DkZ3227p7vilJdD0iqTB4LuHpCgcAlY60EbG2it4a+WJwGm
         2SRqHLL1rpIBSwK2aLRiYTz+hsex14uebmi5Nanutn3cADdovNJFFbr154TzMZTytHcD
         Yr+Sr0908pdcOKGh+ANctPSOVKsupUvxE99ZngaQ1YFrSMXHPIZ9q3ut8jgyoTrdnvel
         IPhxrqyh4bna+SbDIGMaot4X74pxwfZT+aVhLeY50U6iL7NagZoxQ9b+A90ZEW37FV6h
         WgZLs/e1SqFtsc3aqz1P47mxTmpQxQlc9h5JTWZikgL0VNDfFPrjK6kdso5FdR9jPUpd
         J7Hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713465662; x=1714070462;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=laVV1Obq0tF6Jin7XzdFzBf2EBgBpO+6tCHi5aSP1wA=;
        b=uEVoQigRp5klUf89Uyn0N1aKjef8vXq35CuPqpemF8sWR4mc6FQs2rS/PRGszUTQjL
         2WxS0ukDplz5N/yuh50Pf8Cc4frC1+vGqLMPGjpd3vMrtLwLBR+EsjnIFXz1YoS/FEOj
         2aNe1LBLQiQmGvoHUBTdIu5vNPD06D/zhTIWNX2kYJizEVbbIPy1h+sRbuatGzgoEZ/q
         +oFe00xHFS9ukc88kkMK4aUxKVbUO6vlh+p4euu/fXDzZtLaz8xGPkoDYHXg+qATls5+
         s+rQGimJYo1Wmr4sZajnUIFt66MDL8DApnBwnTrnUAowwtjYD9IE1i+YKU4nyHAIU9EN
         2GAw==
X-Gm-Message-State: AOJu0YwiZ6chwQt0SD7lPXQo68Lu/Fxg3WTPD6kA5lUejW3Ls9tJpVUb
	JoV5QArSOuDaXXBnBdm77wJl28lhDoceyoK0f1K6JmMgehOFksGLYBnAVw==
X-Google-Smtp-Source: AGHT+IEln2OpZmzPbS9EY+UUjSR1pwIRWYbqe2SYnEmUZzy4XVFW0AIpjr/V+d/Rp/PlZtacSB9fjw==
X-Received: by 2002:a7b:c5c5:0:b0:418:a786:3760 with SMTP id n5-20020a7bc5c5000000b00418a7863760mr2473675wmk.15.1713465661984;
        Thu, 18 Apr 2024 11:41:01 -0700 (PDT)
Received: from christian-Precision-5550.. (176-138-135-207.abo.bbox.fr. [176.138.135.207])
        by smtp.gmail.com with ESMTPSA id t13-20020a05600c450d00b00417f700eaeasm3653670wmo.22.2024.04.18.11.41.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Apr 2024 11:41:01 -0700 (PDT)
From: Christian Couder <christian.couder@gmail.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	John Cai <johncai86@gmail.com>,
	Patrick Steinhardt <ps@pks.im>,
	Christian Couder <christian.couder@gmail.com>,
	Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH 1/4] rev-list: refactor --missing=<missing-action>
Date: Thu, 18 Apr 2024 20:40:40 +0200
Message-ID: <20240418184043.2900955-2-christian.couder@gmail.com>
X-Mailer: git-send-email 2.44.0.655.g111bceeb19
In-Reply-To: <20240418184043.2900955-1-christian.couder@gmail.com>
References: <20240418184043.2900955-1-christian.couder@gmail.com>
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

In a following commit, we are going to add support for a similar
'missing-action' feature to another command. To avoid duplicating
similar code, let's start refactoring the rev-list code for this
feature into new "missing.{c,h}" files.

For now, this refactoring is about moving code from
"builtin/rev-list.c" into new "missing.{c,h}" files. But in a
following commit, that refactored code will be used in
`git pack-objects` too.

As `enum missing_action` and parse_missing_action_value() are moved to
"missing.{c,h}", we need to modify the later a bit, so that it stops
updating a global variable, but instead returns either -1 on error or
the parsed value otherwise.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 Makefile           |  1 +
 builtin/rev-list.c | 41 ++++++-----------------------------------
 missing.c          | 26 ++++++++++++++++++++++++++
 missing.h          | 18 ++++++++++++++++++
 4 files changed, 51 insertions(+), 35 deletions(-)
 create mode 100644 missing.c
 create mode 100644 missing.h

diff --git a/Makefile b/Makefile
index 1e31acc72e..75583a71a0 100644
--- a/Makefile
+++ b/Makefile
@@ -1076,6 +1076,7 @@ LIB_OBJS += merge-recursive.o
 LIB_OBJS += merge.o
 LIB_OBJS += midx.o
 LIB_OBJS += midx-write.o
+LIB_OBJS += missing.o
 LIB_OBJS += name-hash.o
 LIB_OBJS += negotiator/default.o
 LIB_OBJS += negotiator/noop.o
diff --git a/builtin/rev-list.c b/builtin/rev-list.c
index 77803727e0..f71cc5ebe1 100644
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
@@ -569,10 +536,14 @@ int cmd_rev_list(int argc, const char **argv, const char *prefix)
 	for (i = 1; i < argc; i++) {
 		const char *arg = argv[i];
 		if (skip_prefix(arg, "--missing=", &arg)) {
+			int res;
 			if (revs.exclude_promisor_objects)
 				die(_("options '%s' and '%s' cannot be used together"), "--exclude-promisor-objects", "--missing");
-			if (parse_missing_action_value(arg))
+			res = parse_missing_action_value(arg);
+			if (res >= 0) {
+				arg_missing_action = res;
 				break;
+			}
 		}
 	}
 
diff --git a/missing.c b/missing.c
new file mode 100644
index 0000000000..83e0c5e584
--- /dev/null
+++ b/missing.c
@@ -0,0 +1,26 @@
+#include "git-compat-util.h"
+#include "missing.h"
+#include "object-file.h"
+
+int parse_missing_action_value(const char *value)
+{
+	if (!strcmp(value, "error"))
+		return MA_ERROR;
+
+	if (!strcmp(value, "allow-any")) {
+		fetch_if_missing = 0;
+		return MA_ALLOW_ANY;
+	}
+
+	if (!strcmp(value, "print")) {
+		fetch_if_missing = 0;
+		return MA_PRINT;
+	}
+
+	if (!strcmp(value, "allow-promisor")) {
+		fetch_if_missing = 0;
+		return MA_ALLOW_PROMISOR;
+	}
+
+	return -1;
+}
diff --git a/missing.h b/missing.h
new file mode 100644
index 0000000000..c8261dfe55
--- /dev/null
+++ b/missing.h
@@ -0,0 +1,18 @@
+#ifndef MISSING_H
+#define MISSING_H
+
+enum missing_action {
+	MA_ERROR = 0,    /* fail if any missing objects are encountered */
+	MA_ALLOW_ANY,    /* silently allow ALL missing objects */
+	MA_PRINT,        /* print ALL missing objects in special section */
+	MA_ALLOW_PROMISOR, /* silently allow all missing PROMISOR objects */
+};
+
+/*
+  Return an `enum missing_action` in case parsing is successful or -1
+  if parsing failed. Also sets the fetch_if_missing global variable
+  from "object-file.h".
+ */
+int parse_missing_action_value(const char *value);
+
+#endif /* MISSING_H */
-- 
2.44.0.655.g111bceeb19

