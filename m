Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A91EE824A4
	for <git@vger.kernel.org>; Wed, 15 May 2024 13:25:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715779561; cv=none; b=ddOi0jiQ0KaYQ03sK7tPDd38kHBMm3dTbvi62cQ+rOahrfte5WLHRDj4XBiasRQ4zwHvFNEQexUsv8p80QGVlvKEgj42Ut10UNoN443KagvtuQMfv9+TK2vUvsNJqYa3mlfoq33viUQ5RrM92pMxcmER1PXWeRXDVo9Ts7SBoG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715779561; c=relaxed/simple;
	bh=KG0/oIlW41ni4yfiBN4yXwA7Xg7ZK1cOEIoxF5ejiFk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NGrucA55HDYjZ5mxsGPs8ep6rYfxk0BwRTonyE7kJv/jNEU2ZWF5CJkyIp8DChwKRkqjWRq48RJ5E2gp6OUHqJ/wGcVsMA0BQIisgzH62lKoEEaQ1yRDiDJDNOKMw3+kXD6bJu9JIbehizXoy3+17K/RVs9sYfMoZ1ZM1JFrLKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Tk4tzBQl; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Tk4tzBQl"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-420180b5897so23243035e9.3
        for <git@vger.kernel.org>; Wed, 15 May 2024 06:25:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715779557; x=1716384357; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XFtFCVfMlXMkA3jBFB2kvJWS+iqT35YBFqX/f36bGVw=;
        b=Tk4tzBQliEMSw/2byJ6/BGEuEbFPH4/KZzCNlFwjTNIiyQmmZWtWgL1BL9RYHc4z9A
         sSvkSfxXO0yaSvKvNpe5FSzDVcL+8JUwzDlHZ+yut/30F8KhlGgoJNevPP7A8Obyb3mi
         +n7Dp9wQeDqP6q5cdzGMnHercaYplI2iXB6jYEhBVWu0oyoR1eaj17o6KU8D/haVxr3i
         vsUNSCYEa37mvc5Hnb1DnZLsceLJZihK9reKvT03b7ug4Cmlf7opobd6MGCAyMMrAP24
         cMruhWrqPrHo22WdQXvQDPcnQi//6eeNDVYG2Zc2vqyhg0yn22xnDflHzrP0xxNlAd9/
         iwZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715779557; x=1716384357;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XFtFCVfMlXMkA3jBFB2kvJWS+iqT35YBFqX/f36bGVw=;
        b=ny/X8ebn2fWpdJ3OqYJ7OVg2eYwi+LZcnULwlA44HKqnBYlcQSoS7IYzhoxw06jpVZ
         V2KIUhj4hYJJLK3NcA+qBlGamSz90i0krnK4LUdQkxpSUJV6y+qU64+Sox6Yb+gSVvzs
         jc6F87mMiEm1lRcWyL7OAKllUmwH+p+nuR/x9NUA07fP4cSwYP1kZ8X11TGYiellWE3N
         PB2OAPUN1zFfdW0m1fsJPo0LzuA7z5REyRBYexIU2Vntfd/raHQMuV9GGiZGDb04Z+Sf
         kWtoNXS+0e2EpJMpZbTUBtXWaxd1ehrMlnpNXtepwLmRyCzoFt+IpWioEKhCVxG0B/bq
         eZGQ==
X-Gm-Message-State: AOJu0YyKameE7AYMw9XoyGh+ydJqW8VBdIUUGomJAy42aDpUnfKJdhM5
	QoIeizb/ygSAwYqVOXsLfJ/Kso+tzB/oKTdaCr9yQH6YBBneWqIPhO636g==
X-Google-Smtp-Source: AGHT+IGgSx+1jZx7C+wcgj8GnjsTaKPtj3EEDvejM945sdsPgRjM6jbpJ4296UNoWUX0kHgojirsIQ==
X-Received: by 2002:a05:600c:4744:b0:418:f991:8ad4 with SMTP id 5b1f17b1804b1-41fea93213dmr127015615e9.6.1715779557457;
        Wed, 15 May 2024 06:25:57 -0700 (PDT)
Received: from christian-Precision-5550.. (176-138-135-207.abo.bbox.fr. [176.138.135.207])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4201592e5f3sm117171695e9.43.2024.05.15.06.25.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 May 2024 06:25:57 -0700 (PDT)
From: Christian Couder <christian.couder@gmail.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	John Cai <johncai86@gmail.com>,
	Patrick Steinhardt <ps@pks.im>,
	Christian Couder <christian.couder@gmail.com>,
	Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v2 1/3] rev-list: refactor --missing=<missing-action>
Date: Wed, 15 May 2024 15:25:41 +0200
Message-ID: <20240515132543.851987-2-christian.couder@gmail.com>
X-Mailer: git-send-email 2.45.1.148.g0f5efb064b
In-Reply-To: <20240515132543.851987-1-christian.couder@gmail.com>
References: <20221012135114.294680-1-christian.couder@gmail.com>
 <20240515132543.851987-1-christian.couder@gmail.com>
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
index 0285db5630..e0ddcc2cbd 100644
--- a/Makefile
+++ b/Makefile
@@ -1062,6 +1062,7 @@ LIB_OBJS += merge-recursive.o
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
2.45.1.148.g0f5efb064b

