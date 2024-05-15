Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8F0585959
	for <git@vger.kernel.org>; Wed, 15 May 2024 13:26:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715779563; cv=none; b=bG9Z9JSoslNSjC6ymkRDcbhxNWdm+cmIpBgTL/s1UJkaeguPwnNGCkrecFatUwR/eabjtfBhc2d91r++EPZygUKxZ8Dy5ROW5HeGJdw3mOOSvK5n99KPlaJW+lUIcWbRROVrjz4jBWZ6PqkCG3mN4u7YM/6IOulFwRvN9JaIS8A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715779563; c=relaxed/simple;
	bh=8nN/fE2FtKpcrq9oD8RiDbzkezPbsmM/6LDkMaESHMc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PxXeerN+tCICt5n1qpS30LAYXqRaQ7etc2IS08eWygHet+faXBXYH8dm10UYQgGABzpyD/LCBZp/YzBwlq4O6hgMMMpdh5vvwL+MH/gpBCZByv2C+DoIsKrBnDorrz3yqGp131nKVbdAl4hjz3HOfVHaTb5ooTsdXXEV/6ARKv0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eFcUFXQb; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eFcUFXQb"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-41ffad2426eso51965475e9.3
        for <git@vger.kernel.org>; Wed, 15 May 2024 06:26:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715779559; x=1716384359; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=T0hmo/p0VAGo1p4QnVSIM0GabAIbA3aaLJ5QyA1Viqg=;
        b=eFcUFXQbh8YJLEO/WKzniyG2CaW1sLwR4AEHAeG6FN01OaKbgrV0v3GpzvDT9aQrTQ
         vs4SZbTDfFnibjbimvUgxiuCl10XIHYBp0JbY6YpoK6PbWHqWC1NQsssp9INHiKSxnhD
         /xeX0vD2V7quHXxaDfvpLnl3/6abm6FN4fntLJePCe8nm1dDAPAMGu7QSpn0Ig95cCDE
         H5ZBmx0TV6d4MBz5b6VQrFBuEDny9D45yNLW51XBhvUYpv2n+zjgeymg28GwK96y64/A
         jDAEnnog+oWPjnJrqvLLXJ4T2fdZU73FTjux80FcFHHvbKO/do9FxuRleLH0rcnKgie9
         Lgfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715779559; x=1716384359;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=T0hmo/p0VAGo1p4QnVSIM0GabAIbA3aaLJ5QyA1Viqg=;
        b=kaMeQq7GKjMfa6ASIHiNmf6xd5oW4pbhNpab7jvN7LBpwlRvzlsCeZNxJVn6MRtBN5
         vIscHkKeuVW20pYnFwIQ7xOjXuNGJI1S6MQ0mbhsIH0K8CVXs4pDVrFHsOs7l9XwZqKv
         jmEabg+arzQysjahzb/u+cDH9Sqv/jpPlup5iH4EoWXHF20jigpdosh0B+EnGATxQEzP
         skspRAPsSTyIHypAiuZDCjdcNWutaQnJBCht31QwWH4tP8hzO/Ahoc5lZAT/m1BKM/JE
         WCLXnn8CYdYCpuSSfrVt0TQo4s+2VTelMmsqr4a11T8ndGtfqGH2x5WQs5vGsq/bcbq5
         KMQQ==
X-Gm-Message-State: AOJu0YxpT/zw0U/tpaahEKoZI5mdCs8X4bqeQKiSfK27lPTkCoE7HZFI
	QCDTyJ8HU4DIkYCf6njAlz2TDaS1oAZYy1XcecoX1Z7kc2UkMaQu9p0uJA==
X-Google-Smtp-Source: AGHT+IGOfrlEN91KJHnEBhS6tTzF8I8NYSSScTpEtJWt326yxXAQFCBAfH0tgFaWAu4hWeYKfSuvFA==
X-Received: by 2002:a05:600c:1c0e:b0:41c:503:9ae4 with SMTP id 5b1f17b1804b1-41feac55e4dmr150265315e9.25.1715779559281;
        Wed, 15 May 2024 06:25:59 -0700 (PDT)
Received: from christian-Precision-5550.. (176-138-135-207.abo.bbox.fr. [176.138.135.207])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4201592e5f3sm117171695e9.43.2024.05.15.06.25.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 May 2024 06:25:57 -0700 (PDT)
From: Christian Couder <christian.couder@gmail.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	John Cai <johncai86@gmail.com>,
	Patrick Steinhardt <ps@pks.im>,
	Christian Couder <christian.couder@gmail.com>,
	Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v2 2/3] pack-objects: use the missing action API
Date: Wed, 15 May 2024 15:25:42 +0200
Message-ID: <20240515132543.851987-3-christian.couder@gmail.com>
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
`--missing=<missing-action>` option. Previous commits created an API
in "missing.{c,h}" to help supporting that option, but only
`git rev-list` has been using that API so far.

Let's make `git pack-objects` use it too.

This involves creating a new show_object_fn_from_action() function to
set the `fn_show_object` variable independently from parsing the
missing action, which is now performed by the
parse_missing_action_value() API function.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 builtin/pack-objects.c | 48 ++++++++++++++++++++++--------------------
 1 file changed, 25 insertions(+), 23 deletions(-)

diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index baf0090fc8..55d08c686d 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -39,6 +39,7 @@
 #include "promisor-remote.h"
 #include "pack-mtimes.h"
 #include "parse-options.h"
+#include "missing.h"
 
 /*
  * Objects we are going to pack are collected in the `to_pack` structure.
@@ -250,11 +251,6 @@ static unsigned long window_memory_limit = 0;
 
 static struct string_list uri_protocols = STRING_LIST_INIT_NODUP;
 
-enum missing_action {
-	MA_ERROR = 0,      /* fail if any missing objects are encountered */
-	MA_ALLOW_ANY,      /* silently allow ALL missing objects */
-	MA_ALLOW_PROMISOR, /* silently allow all missing PROMISOR objects */
-};
 static enum missing_action arg_missing_action;
 static show_object_fn fn_show_object;
 
@@ -3826,33 +3822,39 @@ static void show_object__ma_allow_promisor(struct object *obj, const char *name,
 	show_object(obj, name, data);
 }
 
+static show_object_fn show_object_fn_from_action(enum missing_action action)
+{
+	switch (action) {
+	case MA_ERROR:
+		return show_object;
+	case MA_ALLOW_ANY:
+		return show_object__ma_allow_any;
+	case MA_ALLOW_PROMISOR:
+		return show_object__ma_allow_promisor;
+	default:
+		BUG("invalid missing action %d", action);
+	}
+}
+
 static int option_parse_missing_action(const struct option *opt UNUSED,
 				       const char *arg, int unset)
 {
+	int res;
+
 	assert(arg);
 	assert(!unset);
 
-	if (!strcmp(arg, "error")) {
-		arg_missing_action = MA_ERROR;
-		fn_show_object = show_object;
-		return 0;
-	}
+	res = parse_missing_action_value(arg);
+	if (res < 0 || (res != MA_ERROR &&
+			res != MA_ALLOW_ANY &&
+			res != MA_ALLOW_PROMISOR))
+		die(_("invalid value for '%s': '%s'"), "--missing", arg);
 
-	if (!strcmp(arg, "allow-any")) {
-		arg_missing_action = MA_ALLOW_ANY;
+	if (res != MA_ERROR)
 		fetch_if_missing = 0;
-		fn_show_object = show_object__ma_allow_any;
-		return 0;
-	}
-
-	if (!strcmp(arg, "allow-promisor")) {
-		arg_missing_action = MA_ALLOW_PROMISOR;
-		fetch_if_missing = 0;
-		fn_show_object = show_object__ma_allow_promisor;
-		return 0;
-	}
+	arg_missing_action = res;
+	fn_show_object = show_object_fn_from_action(arg_missing_action);
 
-	die(_("invalid value for '%s': '%s'"), "--missing", arg);
 	return 0;
 }
 
-- 
2.45.1.148.g0f5efb064b

