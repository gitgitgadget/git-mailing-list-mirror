Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 991783E9587
	for <git@vger.kernel.org>; Wed,  4 Feb 2026 11:08:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770203317; cv=none; b=oQNqvtUmoOJEOPHpTAKmvpkP2e8slKcNCFZJobl3FtUhLIOItUy3zi8iXtZS50eTFuiH0ffEKX8SzM0Rdz2PLQRJ3CfmM48JAGiwUb85cyxEXA9qM+hPQwWGhxMVMeKYtWvxsktd/pJQlIIdOo0P5RDoDdrQOr/6qMKcVcO4EXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770203317; c=relaxed/simple;
	bh=MENyIw2TrBQkfyp/EDiDzBNDo0k7U9F5znyrZO53TH8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PgUg3qd8imeLSBhM/I4hSaoQHRJ5+FDb4FQ4yVjlYdHiuUOp31+UayykaooLB/+UBvnJS3sUt8M+B4NT0nFA8n/6Y4blBkjCI5uEJR2f7SY40sRKDkHzXWWLZ4B/GAROkcXbKwGezd/0lTH3hsvs26LoZAK6xWg438WzYXw0vZs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JAGxu8v1; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JAGxu8v1"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4806bf39419so4353625e9.1
        for <git@vger.kernel.org>; Wed, 04 Feb 2026 03:08:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770203316; x=1770808116; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=POIkR2Dcq88ObL7qqekeBd0HNesRuzQGRbkuJqybX+c=;
        b=JAGxu8v1C4Krxvm+J+M/Dj/bzs9xMeazJ3Yii8tK4vTXK57xr5pgQp13jM5zgHJWzA
         q/dbJGCY2DFDFOdLTm+UGcNCBQiSQjp8MIyH9jzI3VBG+1kK0s9W47o3toWFoHJAp0qB
         L+fKZxPYLRahmEtfNVgNH+ge0eYi+0fcnoWiACSj1oWy2aZM8LrIW3J4cxPO9ioLv1ds
         UMYcGZcsMHwAALW3xYiXreO2tjURNsuxx+dckgKfKpFEy08Ud5FmAD3HDEibPaVCZimj
         rl/KGjLOrcbMVizTIQ7HQWsvAEr/kDOXvF34aNMGcEc9s+ATvSkhNG5ymdMyTzeglMHD
         tsag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770203316; x=1770808116;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=POIkR2Dcq88ObL7qqekeBd0HNesRuzQGRbkuJqybX+c=;
        b=fELKkqwHsLmU8NOFdoCvqv7TccJg3trG9mBInRFUdddnyjYGhBLsemdAEp7vH/nTqV
         /0C2FlxyFGBgqm1EgcrVoT+PUzHiCpTJCGZAY0onvm/pZlAw8fn2ArFEn88dHNZpmM72
         DasdtZhROZiCwiUKUK9DcYuDg/Z7XTljZC7t2j23Tbqq7sxGcYREqfCs9wW7oRTQF0ks
         +OgtC+8c4QrCHIc7MngTauJjRyzorugiZBDBA6xnCW3OXG4JSwL3BBPm30bhsqp44aq4
         90iU/r/dE8BCbzVEB/76/6IGL7oE8Y2Qd+tLyAPd1pU/0SZlpuZEV+z2ld+FF/7o1CYH
         StIw==
X-Gm-Message-State: AOJu0YxZCMuoJQiV+K+oQbDv+OmTej7eKzuD4bJPpOQGx18u7Q0lSbRA
	nJk8L7mGuOfo3REc4J+LhKgbKsBl0V7yZhUP1BXqqusNAnhFMbeI2/gIfaeEzw==
X-Gm-Gg: AZuq6aJSs2DQ9MajqIA2QpyHsKw8d70E6+a1TPnOoeYXrdVzXkTs1/U8p+ezzx2yVvk
	dgpx/uVudk0+9JmlNejIUAZtUbKL+nsAzNCRQHUnzKHWmM4sjGTqLZR6vQR3Z4tKTnyHKYpgEi4
	tdEaOnZUEplCMjFRzrSy+d6vNbwebGXNeHvFcMSGILGuj/zPbZCb1ijH/njWv7kHEA0rCC5q30i
	hbER4eR8Du59W+k6MSWtWVhvsozgEAyg4CIUs2acV+kOuEE+eF836LjMJBatkSX2tRYc1Whbuf8
	gGZ5+9c8L6lAUszRBGLI91lp/ZR2Bm3mHX5gSPNq+OWuFg2zQj0EfiNfT0YIdc7ObInLGRYy3Wy
	pQDrsddc5TRrqeRf7Icm5/HccJTz2mwlDMcZsTSQWFfTZA4FOvl7ubfbTkqsXVqEAjiOSiFIGT1
	neQz67EWSsMEC1QuX8BuDJOuNTpNUdKjY0EA9/FY3K1ehCeRqntG7Y+azNUHuaKXcVYhimEtsvz
	MJJJTlcCtUuGuBMSAQjjGlNxf0=
X-Received: by 2002:a05:6000:400a:b0:432:5a4e:c023 with SMTP id ffacd0b85a97d-43617c431ccmr3893258f8f.13.1770203315199;
        Wed, 04 Feb 2026 03:08:35 -0800 (PST)
Received: from christian--20230123--2G7D3 ([62.35.114.108])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-436180640f2sm5340096f8f.39.2026.02.04.03.08.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Feb 2026 03:08:34 -0800 (PST)
From: Christian Couder <christian.couder@gmail.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	Patrick Steinhardt <ps@pks.im>,
	Taylor Blau <me@ttaylorr.com>,
	Karthik Nayak <karthik.188@gmail.com>,
	Elijah Newren <newren@gmail.com>,
	=?UTF-8?q?Jean-No=C3=ABl=20Avila?= <avila.jn@gmail.com>,
	Christian Couder <christian.couder@gmail.com>,
	Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v2 1/8] promisor-remote: refactor initialising field lists
Date: Wed,  4 Feb 2026 12:08:06 +0100
Message-ID: <20260204110818.2919273-2-christian.couder@gmail.com>
X-Mailer: git-send-email 2.53.0.rc2.10.g12663a1c75.dirty
In-Reply-To: <20260204110818.2919273-1-christian.couder@gmail.com>
References: <20251223111113.47473-1-christian.couder@gmail.com>
 <20260204110818.2919273-1-christian.couder@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In "promisor-remote.c", the fields_sent() and fields_checked()
functions serve similar purposes and contain a small amount of
duplicated code.

As we are going to add a similar function in a following commit,
let's refactor this common code into a new initialize_fields_list()
function.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 promisor-remote.c | 28 ++++++++++++++--------------
 1 file changed, 14 insertions(+), 14 deletions(-)

diff --git a/promisor-remote.c b/promisor-remote.c
index 77ebf537e2..5d8151cedb 100644
--- a/promisor-remote.c
+++ b/promisor-remote.c
@@ -375,18 +375,24 @@ static char *fields_from_config(struct string_list *fields_list, const char *con
 	return fields;
 }
 
+static struct string_list *initialize_fields_list(struct string_list *fields_list, int *initialized,
+						  const char *config_key)
+{
+	if (!*initialized) {
+		fields_list->cmp = strcasecmp;
+		fields_from_config(fields_list, config_key);
+		*initialized = 1;
+	}
+
+	return fields_list;
+}
+
 static struct string_list *fields_sent(void)
 {
 	static struct string_list fields_list = STRING_LIST_INIT_NODUP;
 	static int initialized;
 
-	if (!initialized) {
-		fields_list.cmp = strcasecmp;
-		fields_from_config(&fields_list, "promisor.sendFields");
-		initialized = 1;
-	}
-
-	return &fields_list;
+	return initialize_fields_list(&fields_list, &initialized, "promisor.sendFields");
 }
 
 static struct string_list *fields_checked(void)
@@ -394,13 +400,7 @@ static struct string_list *fields_checked(void)
 	static struct string_list fields_list = STRING_LIST_INIT_NODUP;
 	static int initialized;
 
-	if (!initialized) {
-		fields_list.cmp = strcasecmp;
-		fields_from_config(&fields_list, "promisor.checkFields");
-		initialized = 1;
-	}
-
-	return &fields_list;
+	return initialize_fields_list(&fields_list, &initialized, "promisor.checkFields");
 }
 
 /*
-- 
2.53.0.rc2.10.g12663a1c75.dirty

