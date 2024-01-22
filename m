Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3260C39ACD
	for <git@vger.kernel.org>; Mon, 22 Jan 2024 08:52:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705913526; cv=none; b=Ck74cIzG6LmvuWDzIFCTmg/6k5VfKszU5xj4J0BJtOdKZLaONZgFeuE+FcEDlIjkqZNMduE+SczIwmGXkB39m7rpVvo1hiNIrfoZShA7tKLXb36GSigYPjM4SxBcIXnVue9N4W3lPWoXezyaygiG0PWsfz5qsQlFCO8tsRfyoU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705913526; c=relaxed/simple;
	bh=RDlXLgjmyDk4H8dtoV/gITDi7dwzQh4uY4wPHNM4HUQ=;
	h=Message-ID:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=POg4zJRVmYO9p8dCvU30ClJ0BKkFmQaH7GgZi7j2D7YZHfhb0rJw+4ogs8rOg20sOyABMUeR/f48VUsCa8LBgjwPXr91i2gxossTfedMUYzM47yddEvf/+2IVkFoWaam9/LQ2C2ogZ3kv1IHMd2mM3lQndnG9/+diywyk7DVxzw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YHeg8/Hq; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YHeg8/Hq"
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-33934567777so937227f8f.1
        for <git@vger.kernel.org>; Mon, 22 Jan 2024 00:52:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705913523; x=1706518323; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mkozd3Lgt1REvxVaC0GAXuLlZuqltdDy5Eq8HXf/kfg=;
        b=YHeg8/HqgIK0XcdtHbYdTUXmgWl8Z4+BVw5Y+39Whprx/TRfBZlj6AbQ+hJar9PtKQ
         G1whHUUFyf0d2UfSN9Ilvg2Rwo2Y0vPJY4DozJDt+L60Dnr6XlfEA1/ddG+/Y/kPlEkI
         svmrxtmFbHzvv/fgyTHn72mtJ0A2sqQNHpekT0POlTqd9+lqJlXE85ztoceh8MTKcwQt
         njtY907vwfSQPjvZdWzuoBqgZFG7gkN6TLNpphlHEAt/jzdS1jCvlVWRTkEKa9s+Jlzu
         2arzJ8NF7MaAj3t64lpJrYA3pzDdI8GYewGIGqeddNBPRZyPKYI1qdt80rKPXrMoOVrL
         y8vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705913523; x=1706518323;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mkozd3Lgt1REvxVaC0GAXuLlZuqltdDy5Eq8HXf/kfg=;
        b=GNTYXPbwZrX3rREQhFiP0fVfIUsadCVfDgKBUmxR25tq7EJWLWsE7IVIK8FH95lzyT
         YYIRGGGQ+NFc/PEfsXV32ivCjEpA4aTy8FUXBtmqEzUMWYR9b4evZl9DShD6ReKSYLLS
         d97gMB+CmO3wMxb/r60HRkX/sHh88SaB6jNkwFWIZMGafzTT3afDo9C4stznvPgaBdnf
         l/Bs1reRxRNu4qWK0LCGkyRoEnnvMoR69nDdrs0Q1I5yJv7ojz6iFVTVwZ/APPTbalSt
         hup+JX7L2LuoX40gEs3f4p06aXxfJLaazHoRMpR7hqfQUPzioc4jdbZDxCJ8TtO1ITCr
         +mKQ==
X-Gm-Message-State: AOJu0Yz3O811BIl7q3vcW5gF7Hh0riRXxq5xG4y+YazjfIKicPT9l5ll
	GdVyD1ds/RnKO/D2STVao6z/tA5neC9CzAsYSy6jhbcrSVukUAAyE2VFOzZU
X-Google-Smtp-Source: AGHT+IFxIpSy/V3L4ZyEgG9gg+K7ycPg4vtOmyaWjnTI3W7c2eS6auk5lc2ftq4SpkvbCaHB8NQGug==
X-Received: by 2002:a05:6000:184c:b0:339:20de:b0f2 with SMTP id c12-20020a056000184c00b0033920deb0f2mr3151716wri.93.1705913522299;
        Mon, 22 Jan 2024 00:52:02 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id a2-20020a5d5702000000b0033928aadde1sm5795169wrv.48.2024.01.22.00.52.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jan 2024 00:52:01 -0800 (PST)
Message-ID: <1ece724b1ca7f71542bfef42795fce798563ecde.1705913519.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1646.git.1705913519.gitgitgadget@gmail.com>
References: <pull.1646.git.1705913519.gitgitgadget@gmail.com>
From: "Mohit Marathe via GitGitGadget" <gitgitgadget@gmail.com>
Date: Mon, 22 Jan 2024 08:51:59 +0000
Subject: [PATCH 2/2] patch-id: replace `atoi()` with `strtol_i2()`
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
Cc: Mohit Marathe <mohitmarathe@proton.me>,
    Mohit Marathe <mohitmarathe23@gmail.com>

From: Mohit Marathe <mohitmarathe23@gmail.com>

The change is made to improve the error-handling capabilities
during the conversion of string representations to integers.
The `strtol_i2(` function offers a more robust mechanism for
converting strings to integers by providing enhanced error
detection. Unlike `atoi(`, `strtol_i2(` allows the code to
differentiate between a valid conversion and an invalid one,
offering better resilience against potential issues such as
reading hunk header of a corrupted patch.

Signed-off-by: Mohit Marathe <mohitmarathe@proton.me>
---
 builtin/patch-id.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/builtin/patch-id.c b/builtin/patch-id.c
index 3894d2b9706..6bfb263de5e 100644
--- a/builtin/patch-id.c
+++ b/builtin/patch-id.c
@@ -1,3 +1,4 @@
+#include "git-compat-util.h"
 #include "builtin.h"
 #include "config.h"
 #include "diff.h"
@@ -29,33 +30,32 @@ static int scan_hunk_header(const char *p, int *p_before, int *p_after)
 {
 	static const char digits[] = "0123456789";
 	const char *q, *r;
+	char *endp;
 	int n;
 
 	q = p + 4;
 	n = strspn(q, digits);
 	if (q[n] == ',') {
 		q += n + 1;
-		*p_before = atoi(q);
+		if (strtol_i2(q, 10, p_before, &endp) != 0)
+			return 0;
 		n = strspn(q, digits);
 	} else {
 		*p_before = 1;
 	}
 
-	if (n == 0 || q[n] != ' ' || q[n+1] != '+')
+	if (q[n] != ' ' || q[n+1] != '+')
 		return 0;
 
 	r = q + n + 2;
 	n = strspn(r, digits);
 	if (r[n] == ',') {
 		r += n + 1;
-		*p_after = atoi(r);
-		n = strspn(r, digits);
+		if (strtol_i2(r, 10, p_after, &endp) != 0)
+			return 0;
 	} else {
 		*p_after = 1;
 	}
-	if (n == 0)
-		return 0;
-
 	return 1;
 }
 
-- 
gitgitgadget
