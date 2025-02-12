Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9DD91DC985
	for <git@vger.kernel.org>; Wed, 12 Feb 2025 06:04:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739340269; cv=none; b=TfKv9pTsDaqPLjVPx0789Ca8fIa8pQjoOjw/HcfWWHuYqtDZiclHPCyoRqTZ4GN4GiHTLBAaYOK4QjeH7D5MUJQX0HwIM5GmCruJxoqxU/OFEA5UyLQ8W/8kn7rmXAQOlgLEaYNV06yCsjVjUDQXJDU4pBPKYzy2svubbTgvk8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739340269; c=relaxed/simple;
	bh=QNByOcUdFZnAZ8TZc41iTiLsty18rBHAlkbJ3e4FzFc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fg3WMOdGFSRzPdP8trTnmVKolZIhNRO3wLGCU3Fsmw18c+DD2Aov3A3jip0eFUxSMML4UfnY3rc7QeX/qTZqCpi62owLft63FSn0rTgKmn+/AUaJ1bk5HgDHSzdo+Ordae82jRIsTEeCcoNjh0kEBbWp8yQc6FigOBYc85+9JsQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WVx6x/Wm; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WVx6x/Wm"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-21fa56e1583so45530355ad.3
        for <git@vger.kernel.org>; Tue, 11 Feb 2025 22:04:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739340267; x=1739945067; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NXTf0IfX9hnobaFYqLlJZU9Qp6He9+xF3Kz27EhE2Kc=;
        b=WVx6x/WmA8Q7/Z70CrqYpncI0xVtnbz92OqGLCy31MHRAYxJIqVgGtWXl8o5qo5279
         zKyZYA7TKNkGdfpb/MyZnE5/0KHGO87ATGbfjL7WnEaH5FB3RzFctJ6diidbFXSUZVfj
         XG1HjCeCOtvLzOm1dYoTNuCuhFbuPtd0UdXqvBiQE7XbNzo2fK1Au1B3GWwfijmXeSuj
         jdXQDPUDQKCC+hvqmwtNEIXxk96vx7rCMVZEhXgnlpeXpLS4ALqVQu3g2pBL3miLxP0U
         /IRMn6Maz8s9g66GMoyWEV4ZGSjUvHamCqarwY3IBBR7ZqKRaydj7psH6nSTeKlHc8iy
         JeMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739340267; x=1739945067;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NXTf0IfX9hnobaFYqLlJZU9Qp6He9+xF3Kz27EhE2Kc=;
        b=CJ7XRZjW5OQ1OKAFdPMCMGU6F9+Si28DZlEVJLJCNC6qKN8CfyugpHCl8cVcPaeT9L
         /1upAjJVSxMprs6oqP9j53/Hd2YvXiD7GHV+vlDGL89ibTWHB4bmFN17mRO9tUdHI4bE
         lwfM4OYxiafXan3Ba16w6yyKPxuxsoybkGLWknADtVOtA9yVfzm6ceWhLVBO/iFUiH4r
         erKbADykfu5L4J2/3QPGJTc/udDA8cJExKyiehvhYKGowfrCXjozI+yg3GHAqk9ah3Nk
         zKudMrkGdIUUjIJ6FzuNZob+vcJhYRGlcUNUp2XXW+7H0n5W7+cFqKnmfC4aVHsdFfXg
         /4uQ==
X-Gm-Message-State: AOJu0YwjAfEqZuZ+Pa2Y2OhNlR9pQ/GyBgurOvp5O2lNlptYH8kaEBGk
	gZ5liR/AHO3Vicy0BYnkKX/QRFxXR4Kk7SxySPg6yI8WqOj8NVkT83q7Tw==
X-Gm-Gg: ASbGncvYJFKiYcXvM1xGHe3Is0B49lEuxVXe8CxeveBYTgZRFw1lx9W8E4drPLoa4Uh
	n3DWvP0mZkyP/bL4V5H0Xm1+n6MJTiYYkHS6LJAS35KCw07oXp21o4BQind1idL7zrUkR0693uF
	blDSViPfo45LgygmxtOeX5Qa1LdS5U5XSVR1V3nV+uAAceozW1qW8nN2oAsbeuMczD5tvQsgOiu
	CDnvyl8iz58rQ5YE1pFhke2klwXXGVjmMpPcABx9c6fiIHsOzYzk+E0TuDlk5iASaqTQ0tkqm1S
	x5E5jAjbO+98qsSST7F3VnwLtg==
X-Google-Smtp-Source: AGHT+IEfaDbO7A6SMloTj1Eo6olmDr8b6Wfrl4wlGf/TT49ksfHQPbQcUmcOSw0USurD1rLjLgC1JQ==
X-Received: by 2002:a05:6a20:1595:b0:1db:ddba:8795 with SMTP id adf61e73a8af0-1ee5c821917mr4334685637.36.1739340266903;
        Tue, 11 Feb 2025 22:04:26 -0800 (PST)
Received: from localhost.localdomain ([172.56.121.6])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-ad53f6e2633sm5747411a12.16.2025.02.11.22.04.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Feb 2025 22:04:26 -0800 (PST)
From: David Aguilar <davvid@gmail.com>
To: git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>,
	Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= <avarab@gmail.com>,
	Jeff King <peff@peff.net>,
	Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: [PATCH 5/6] xdiff: avoid signed vs. unsigned comparisons in xpatience.c
Date: Tue, 11 Feb 2025 22:04:17 -0800
Message-ID: <20250212060418.1645241-5-davvid@gmail.com>
X-Mailer: git-send-email 2.48.1.643.g32d702c6e8
In-Reply-To: <20250212060418.1645241-1-davvid@gmail.com>
References: <20250212060418.1645241-1-davvid@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The loop iteration variable is non-negative and used in comparisons
against a size_t value. Use size_t to eliminate the mismatch.

Signed-off-by: David Aguilar <davvid@gmail.com>
---
 xdiff/xpatience.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/xdiff/xpatience.c b/xdiff/xpatience.c
index b0ba421b28..82f663004e 100644
--- a/xdiff/xpatience.c
+++ b/xdiff/xpatience.c
@@ -20,8 +20,6 @@
  *
  */
 
-#define DISABLE_SIGN_COMPARE_WARNINGS
-
 #include "xinclude.h"
 
 /*
@@ -78,7 +76,7 @@ struct hashmap {
 
 static int is_anchor(xpparam_t const *xpp, const char *line)
 {
-	int i;
+	size_t i;
 	for (i = 0; i < xpp->anchors_nr; i++) {
 		if (!strncmp(line, xpp->anchors[i], strlen(xpp->anchors[i])))
 			return 1;
-- 
2.48.1.643.g61982db19f

