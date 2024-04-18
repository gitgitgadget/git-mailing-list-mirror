Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04F8617F368
	for <git@vger.kernel.org>; Thu, 18 Apr 2024 18:41:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713465672; cv=none; b=nL/1b6UetH65pC6suWFlrkQbtnXnEXaR55PMFXAnz4pz3gOboFr4CsqD8kAHtJqneQPS6Z+05jO8vLatZpF41G2Gq8+AyOYyouIPk8hqqYYHyEfZyJQSJpa/nw7Ds/4tHy5aA1keXhseVoLAoCTPRaN7sPyRlpWO/OpXn/Gv8ws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713465672; c=relaxed/simple;
	bh=GrxpEZn5oa0WRpRH5PGeXf4gM1LINqYAM0llRAx9gzo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ESdVw3ztOy9xPcprVNmNJegpZ3hUBBtm85qSFHV7MNeW6oH0IpPkkzllZ/nq4Xn7dF/tcuqn/MUouZ9uWxJI6r3xKZFHyJrDAp69GKayznS0GAzD+8CM4BEJRLYEc8Kjs1PsDdmXhyRmHCoc6Jp/T0rzzoxRZNIc4IE6lLS/QYU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SmuHifsd; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SmuHifsd"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-41551639550so8501495e9.2
        for <git@vger.kernel.org>; Thu, 18 Apr 2024 11:41:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713465666; x=1714070466; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JfT+Xik2XFEjtCC9S6h6GeC1tDKIph1cZGJdH65ojQI=;
        b=SmuHifsdxxqpT+UEmKdCd5yL57GdF4A65MTO/yZAjpdOGWPPFzHTWDmVbBFBIUYDK6
         ueSafG2Vxx8Une62tdXSfbLJ86j8n6vn1f+2+HofXT51FL57sVttjfteAm7CGzKr00YW
         GicOMoLr4RDOPLdW1jBv65u7T/l1pWr1Mao2LS66pIDH3/l/Uv5jOiGg9uWET/4BKSzT
         KdXohVknGxWSUIh7nknS+Pl1FZRaX8oBM3JMvd+xX1eTMp4aYTqa9WBJDA53pNFA+Fdf
         JbCjCllQJOqa9Orpq6ye4aXxVIIYJt82h31ETJKdveSazqpAiBvhKRjkAhkym8j1O0Bj
         +KEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713465666; x=1714070466;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JfT+Xik2XFEjtCC9S6h6GeC1tDKIph1cZGJdH65ojQI=;
        b=Lu8/HxGy8/oW6D+7bGT//NVPCNdY7vNtjtQcDZu6LRn/ve6y0MYiZ9A4kmKvD84hHA
         T8bumspK6F/mK8WodKJrxvs/fa54rhA5RPlFncQbymiSsCbcSWQdB71CBwdiGm6J2Q+Q
         fBw4SEoxWr0fO3DGYUgL8AVegqieXroUOsFqN5CCYlKcA4fKhWGA1C+FexMhlqhy8H3q
         zs6brwgaXKi1ipqliMMpr722jOs6d123TSErbutjlxtc3eicqOHZSqstgB+qtGgnoNKD
         yYEu3WhGv5uzZuot/GdNFgZFeffrAJge9ffJa2pVNUmCALTkqaZc1ea572Y9mmOwuVeC
         VQKg==
X-Gm-Message-State: AOJu0YxcWjUsVJARYU4CDjLjraNL6VjT81cpWb4C2sohr+noanhMt0hd
	NRCpb6ZiKkaBuW5gy3mt2+6jI29s3hIMo/RYF0ERKEXdo+P48JnloFdQ3w==
X-Google-Smtp-Source: AGHT+IGSbhdbGylApE1YHCGTEXIDy3ID8Qlc/gxma/54doa9bai4yDgvAulePpeXlcYqkUjR6uL5Yg==
X-Received: by 2002:a05:600c:3b12:b0:418:c021:33ae with SMTP id m18-20020a05600c3b1200b00418c02133aemr3016046wms.19.1713465666154;
        Thu, 18 Apr 2024 11:41:06 -0700 (PDT)
Received: from christian-Precision-5550.. (176-138-135-207.abo.bbox.fr. [176.138.135.207])
        by smtp.gmail.com with ESMTPSA id t13-20020a05600c450d00b00417f700eaeasm3653670wmo.22.2024.04.18.11.41.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Apr 2024 11:41:04 -0700 (PDT)
From: Christian Couder <christian.couder@gmail.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	John Cai <johncai86@gmail.com>,
	Patrick Steinhardt <ps@pks.im>,
	Christian Couder <christian.couder@gmail.com>,
	Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH 3/4] pack-objects: use the missing action API
Date: Thu, 18 Apr 2024 20:40:42 +0200
Message-ID: <20240418184043.2900955-4-christian.couder@gmail.com>
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
 builtin/pack-objects.c | 46 ++++++++++++++++++++----------------------
 1 file changed, 22 insertions(+), 24 deletions(-)

diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index baf0090fc8..bce586b9a6 100644
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
 
@@ -3826,33 +3822,35 @@ static void show_object__ma_allow_promisor(struct object *obj, const char *name,
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
-
-	if (!strcmp(arg, "allow-any")) {
-		arg_missing_action = MA_ALLOW_ANY;
-		fetch_if_missing = 0;
-		fn_show_object = show_object__ma_allow_any;
-		return 0;
-	}
+	res = parse_missing_action_value(arg, 0);
+	if (res < 0)
+		die(_("invalid value for '%s': '%s'"), "--missing", arg);
 
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
2.44.0.655.g111bceeb19

