Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D16512EBD7
	for <git@vger.kernel.org>; Fri, 24 May 2024 16:39:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716568789; cv=none; b=t83wP1HCS1kKRmdC/Wtn+w1lcWDAwJKEGfvDYJAFH+qwm1FchZALKWuvze2r9suWpMV0j8knq7bK64WeFnQoAnA6NlJG1k+ft/kEVLezVFD31yzusONsfbipKdqS4uwRJqZPMSnViB7m5pAQD0rmLy+38g6Kb/n1ZdluS1ZyomQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716568789; c=relaxed/simple;
	bh=GZAzf+CJrpHANlJdHPLodRNvZEHa7pH3vdttWgflS8Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=c7EfK+zYRmfQooFynns8NBJPeaiDdR0gjBW3ssIsAHDGUcYPfmZkyH2IqAu5NRmGaPZ6Hq5+lIyrxNgx8lXrgh2sxf4HwvQcCMW2EB7Rgy9xNvUr2wNRIfrj7lH+PsiyCmT3Bzo7SKr3XLlpyYfP+cMHCrag/L+IaeQjfaA20T8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZHY07ONk; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZHY07ONk"
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-354c5b7fafaso3337358f8f.3
        for <git@vger.kernel.org>; Fri, 24 May 2024 09:39:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716568785; x=1717173585; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nM0Ko/8lLYsbzjRcmdqcc+dq/gDkTxDctIz35Xu8TG8=;
        b=ZHY07ONk7k/WQ89gPTXcfDjzG1v5zkXIZ8fI52JDxNiEzQlprESbsV2i7ofjzOlUgd
         j3/rn9oPYT84BjZsCRNPk7YzS4UM90qfjwDTbn0eqGKFBAfofNxay3aMq1qmcvCcp7BB
         Vjf5Qv9KCLubL1OgYSbebRgAQ71KPl5+J9sa9Sl4o+zYR+3ym59pbV+9t+hQfyUUU1yF
         hYz7jc6yPPzbfPI3NUW+lz73n4rOe3CDyGC4cpmHsdyzsFFuPsG7x6skSPmMyiAqIRsN
         ibEgT4LqbaqupxKXB4RCGI3X+KNJ4M0LDG8vEsyn4B8ybw6vn+BA2qnQG8TAa3pmehgg
         JL2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716568785; x=1717173585;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nM0Ko/8lLYsbzjRcmdqcc+dq/gDkTxDctIz35Xu8TG8=;
        b=eJrC6oH4IbRVTttW6h/TYQzWh6IjeMK6eij2xEXpbcs8bjH9XLcQA3iCdOUi/mcq7K
         EEzEB5pYu0h3rfICk4nq41lIG5bKv/i/EVulJ6PRA2H0N5OE2CdQ33G5qZbyky74DeRW
         x+9ZhyqsRsPCjWmnqzSKhFYarEp3pr2LTmHpGzFoqL+AyZzoZIKaXNtUUjnCwubMBZ1i
         ZNY+JF2CScOfyyvuuSPFu2Oxx+C20fmmgrF6ERQNPpIazv9P8C9VZNKTNZBAn7r96NcH
         V/TzXX3zkUndvCqrjim9gjRG524woENvVuYISP3Dezq9anbD9jF0B0E+30yn5KSXA7xb
         Jscg==
X-Gm-Message-State: AOJu0YwvmYeFh0dwrY2UCQniM2fL6BYig6ZjuW87/r9GoSvWW9AZkeU1
	ogHKPB3iNJleab2kNafaBBBjx9CGFhwi8gOT2t+nN1JgcW1gF6Xx4MBEOg==
X-Google-Smtp-Source: AGHT+IEAyRQW/K77ITz5adsLGIhKkfOEy0uqTBxsCxjGRR7Y+qwXFMjkcFkvnwfJPHbaEZmLAM/QbA==
X-Received: by 2002:a05:6000:1a44:b0:354:fbc2:5cf6 with SMTP id ffacd0b85a97d-35526c5a119mr1869239f8f.30.1716568785083;
        Fri, 24 May 2024 09:39:45 -0700 (PDT)
Received: from christian-Precision-5550.. (176-138-135-207.abo.bbox.fr. [176.138.135.207])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3557a1c9303sm1976282f8f.88.2024.05.24.09.39.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 May 2024 09:39:43 -0700 (PDT)
From: Christian Couder <christian.couder@gmail.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	John Cai <johncai86@gmail.com>,
	Patrick Steinhardt <ps@pks.im>,
	Christian Couder <christian.couder@gmail.com>,
	Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v3 2/3] pack-objects: use the missing action API
Date: Fri, 24 May 2024 18:39:25 +0200
Message-ID: <20240524163926.2019648-3-christian.couder@gmail.com>
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
`--missing=<missing-action>` option. Previous commits created an API
in "missing.{c,h}" to help supporting that option, but only
`git rev-list` has been using that API so far.

Let's make `git pack-objects` use it too.

This involves creating a new parse_missing_action_value_for_packing()
function in the missing action API as `git pack-objects` doesn't
support the MA_PRINT missing action and other commands using the API
in the future might not support it either.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 builtin/pack-objects.c | 37 ++++++++++++++-----------------------
 missing.c              | 17 +++++++++++++++++
 missing.h              |  8 ++++++++
 3 files changed, 39 insertions(+), 23 deletions(-)

diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index cd2396896d..fad16e0ce2 100644
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
 
@@ -3830,30 +3826,25 @@ static void show_object__ma_allow_promisor(struct object *obj, const char *name,
 static int option_parse_missing_action(const struct option *opt UNUSED,
 				       const char *arg, int unset)
 {
+	int res;
+	static show_object_fn const fn[] = {
+		[MA_ERROR] = show_object,
+		[MA_ALLOW_ANY] = show_object__ma_allow_any,
+		[MA_ALLOW_PROMISOR] = show_object__ma_allow_promisor,
+	};
+
 	assert(arg);
 	assert(!unset);
 
-	if (!strcmp(arg, "error")) {
-		arg_missing_action = MA_ERROR;
-		fn_show_object = show_object;
-		return 0;
-	}
-
-	if (!strcmp(arg, "allow-any")) {
-		arg_missing_action = MA_ALLOW_ANY;
-		fetch_if_missing = 0;
-		fn_show_object = show_object__ma_allow_any;
-		return 0;
-	}
+	res = parse_missing_action_value_for_packing(arg);
+	if (res < 0 || ARRAY_SIZE(fn) <= res)
+		die(_("invalid value for '%s': '%s'"), "--missing", arg);
 
-	if (!strcmp(arg, "allow-promisor")) {
-		arg_missing_action = MA_ALLOW_PROMISOR;
+	fn_show_object = fn[res];
+	arg_missing_action = res;
+	if (res != MA_ERROR)
 		fetch_if_missing = 0;
-		fn_show_object = show_object__ma_allow_promisor;
-		return 0;
-	}
 
-	die(_("invalid value for '%s': '%s'"), "--missing", arg);
 	return 0;
 }
 
diff --git a/missing.c b/missing.c
index ce3cf734a8..a0c2800d30 100644
--- a/missing.c
+++ b/missing.c
@@ -18,3 +18,20 @@ int parse_missing_action_value(const char *value)
 
 	return -1;
 }
+
+int parse_missing_action_value_for_packing(const char *value)
+{
+	int res = parse_missing_action_value(value);
+
+	if (res < 0)
+		return -1;
+
+	switch (res) {
+	case MA_ERROR:
+	case MA_ALLOW_ANY:
+	case MA_ALLOW_PROMISOR:
+		return res;
+	default:
+		return -2 - res;
+	}
+}
diff --git a/missing.h b/missing.h
index 1e378d6215..cdfd522852 100644
--- a/missing.h
+++ b/missing.h
@@ -14,4 +14,12 @@ enum missing_action {
 */
 int parse_missing_action_value(const char *value);
 
+/*
+  Return a 'res' with the following meaning:
+    0 <= res : an MA_FOO value that is OK for packing
+    -1 = res : parse_missing_action_value() failed
+    -1 > res : (2 - res) is an MA_FOO value which is unsuitable for packing
+ */
+int parse_missing_action_value_for_packing(const char *value);
+
 #endif /* MISSING_H */
-- 
2.45.1.219.gbac909a070

