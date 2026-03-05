Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F6AE39FCC8
	for <git@vger.kernel.org>; Thu,  5 Mar 2026 12:54:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772715273; cv=none; b=pJLxRuTxMeACwVs/ZWZqm0ZIFpib/R9UTgCViYeJZ0RhDTIRN99tSgdhIV8e1SFIDi6qAECFJcAnmuQUeCDJJJnvhRjeZMyV428RBntzhaReBEFSxEi+XMTW9fI39U+5Xs2CRwblAAmoc3pM6WrbsYJXeF8M9h7/11ag/8JXE+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772715273; c=relaxed/simple;
	bh=KPaay3zOtBE2+vHwU6Th8yw2WNX6+W1407oC/+A07k4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=W8C5cAmthey3FmheLmrCFczwId0zNcVseYit0cnxvJhZmA4ylYyIxF0Yfa3E1MbFHbPy1PJoabVYnl4m5ZFV+aDlwMsl1LIJsuhKvqcjeifvBn7RT1hUYn49WogpmL4ZTCCKxDThenS1z9yJxpnyG1grW4pBdc6Q3/QfvlslCOk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LVryFJLZ; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LVryFJLZ"
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-82748095963so4131034b3a.2
        for <git@vger.kernel.org>; Thu, 05 Mar 2026 04:54:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772715271; x=1773320071; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bheFZ/T8q8CojwuEIJvulCetcv/fIQqEDFCzyx2NMkQ=;
        b=LVryFJLZ6frWLKBw1+KGq3SsX49KnIKz7f/Kt9Zxn1LKGh/IFJSG2mIF4V/rp1WTU8
         ZDOl+uwiwdW3BCMOwjRPVXkP20KUjUcoYr6aXfuXXJZQuYuP0clEZc4uhPoMxpPXWMJq
         cmIomJzc7qkh1dtWn92c2qSWcDD6RV0EhlGh9A8Fiwhb8keWsyM0EL7FQXSoz17Jmvsi
         PLUfjsHohOn+moD7hx+FgYj8QSvNWsfEY+RWkWcUsc5ZF8DVRC5GtHQecxYI/mwVaUgQ
         vgZTDYRcXCT1JERFuWNKNm32WymLzk+yWqeqHN8Wh9ySraQ455l8AbckHbdgWkdqiFEe
         1/Eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772715271; x=1773320071;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=bheFZ/T8q8CojwuEIJvulCetcv/fIQqEDFCzyx2NMkQ=;
        b=p66rH0dUxDEuu/y3iVEloK8PIhOy79e85kh0/w5kEsPTMQYbsdSA7hjSxrHFvP0LyG
         fByH1YQEEVs/XGRXh6xOTPRdKaXAX2DjFxeV0JBCJNx5c7GAkUwpBUcK32is0VD85uBB
         vM7pyb+sgCJa9ySaGb+tGHormzoUvfrYzfZoOK+vk9mIAAweIo9OytodwaEtwF2Y1hZI
         prJ00BBdlOMkGBRGQp9CPofkvQEhrZYNtXMj2MUUkXFrqW7vOA9Pfm8c8wGx0X5J8VB9
         VhiRL4Qp76thvCLCrdeWr7eTVA5+EdH+fJkwNA+JiwTCOBgD2q5wko3YULfUCKm4Z93p
         omoQ==
X-Gm-Message-State: AOJu0YydSF0W+66EuVuPfQUBd0qysh1JsRVYMQ5LlKAFvM+f64cTUbrG
	Yq314/mfPAW4IK2n0K6scGe3+EBzkJZhn0RJlNiDHDJrfb2PbgBayiyl
X-Gm-Gg: ATEYQzyhzQpDuPFqLs3pyH7GKYGo+8XKsfLuGHBbZeOLjw8ivym52z/nMvpBFAv6KuP
	2U7g6f78nsNKNY0y+7gjvmjFU+HWEY0OPJI0Uxnor01jELqd9nDfA7+xllOP9wrtnCgsDcFvXfC
	wa6Lj1TDtVRmCCjG3Jle2zRpO3AFCw4leERB7Kfl7HOW014TJSrjo6YiH22EAU7XeL9Jz5OFAPu
	bIGjPujmlHGpygRcS+On/qwq0mwaWA7b1zACu3+bYHOV+ideNti7Xpi8krmClWbA44IJY6+yJDZ
	0rlirzeMTclj6fifdZLGTheM5FI52iibzIORPOrycZkG0ELNo/liqfmztFdQBdOfQcShTEJBjpI
	LXcB28UYQ2rtaI/Hx/uMDKxj5gQKlnQyfMNuypr1JzrouRp4Le6g0LJwujnQRrLm7nHszAfy6Ol
	SqxPTntw9XtWyTc4jsZVjVyaaNRU5qq447XOkfNYosDXpDEWXrxV2XtgiUGJTM6tKsrBrLrSQIk
	BpkEc9+p+fhEI1rSgOw6xkuwTG9hoL+
X-Received: by 2002:a05:6a21:730b:b0:34e:be9b:b67f with SMTP id adf61e73a8af0-3982e1b07c2mr4906320637.49.1772715271453;
        Thu, 05 Mar 2026 04:54:31 -0800 (PST)
Received: from jayatheerth ([2405:201:c005:b959:7d42:d207:de10:1218])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c738b823b76sm2578190a12.9.2026.03.05.04.54.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Mar 2026 04:54:31 -0800 (PST)
From: K Jayatheerth <jayatheerthkulkarni2005@gmail.com>
To: jayatheerthkulkarni2005@gmail.com
Cc: git@vger.kernel.org
Subject: [PATCH v3 1/3] path: remove unused header
Date: Thu,  5 Mar 2026 18:23:30 +0530
Message-ID: <20260305125332.27600-2-jayatheerthkulkarni2005@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260305125332.27600-1-jayatheerthkulkarni2005@gmail.com>
References: <20260304130502.8475-1-jayatheerthkulkarni2005@gmail.com>
 <20260305125332.27600-1-jayatheerthkulkarni2005@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The "environment.h" header is included in "path.c", but none of the
functions or macros it provides are used in this file.

Signed-off-by: K Jayatheerth <jayatheerthkulkarni2005@gmail.com>
---
 path.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/path.c b/path.c
index d726537622..f613d8bbd1 100644
--- a/path.c
+++ b/path.c
@@ -4,7 +4,6 @@
 
 #include "git-compat-util.h"
 #include "abspath.h"
-#include "environment.h"
 #include "gettext.h"
 #include "repository.h"
 #include "strbuf.h"
-- 
2.53.0

