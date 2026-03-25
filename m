Received: from mail-wm1-f68.google.com (mail-wm1-f68.google.com [209.85.128.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43C7A3D3336
	for <git@vger.kernel.org>; Wed, 25 Mar 2026 11:52:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774439536; cv=none; b=BuVgUdwCgzMRef566BjYXVvfIeq8qVjhBIvfcWMb6SWnFXUMNq4IWGH/jM/yOIw8378PPhNO9jkM1iBUpeh06NtzKG8vaOJCnRVppBiBZVG71RjW2dKCQcOLZZsqwiQnaIw6dQppcqf8wNI2m9iltTNZ5eRJNOKX6QYOlkmLhrc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774439536; c=relaxed/simple;
	bh=pWr5/PMo48q6urTN85OfslWm0clAHT5D/jw/0cB4VxI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=fE3hmm51M0aL2iDr6WxzdbBw/RQf/WZFib14bMoNur2IcyyUKQZD5kqJljIpiYZptCA6HyeaiOLRV3fxxF5O0/r/esuvZrVEYhMWC44N95ojl2Kz445/cmZoY09eTD1yRjtdGBzD4Dc6aNlvBeqlYba2DgmDqXLsbXj2Lb55GrU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bgOxkIpe; arc=none smtp.client-ip=209.85.128.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bgOxkIpe"
Received: by mail-wm1-f68.google.com with SMTP id 5b1f17b1804b1-4852a9c6309so44436845e9.0
        for <git@vger.kernel.org>; Wed, 25 Mar 2026 04:52:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774439532; x=1775044332; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wcJGC0t55WG6Jay9XxY2Khzmswvk1BrrfcbnT4t2lGU=;
        b=bgOxkIpeQ6CkEwRo5TI4BG4FW6x0I4Z7OPyipFh3ZTb+hNHtFdJcs/4QkYnwpQ/Sgu
         sqXPUIK8exnhr5RKxaEqc9Uy4LZSaQK32aV7/o+dOWrkb/G5Yjq2fY7elZAXbklYjbuz
         OaGfibj1k2QTZAiKWoOVzxwdOKmXA7aV97Aj9BuiUjEw58gJjjO2K8aWBBdvzQT73b06
         wkMMxesHlQBNOB2O6tDjESToDl2ewjCva3A2nyPVZJ1n7vIW5sBgODtbwLwLSe0z7FBJ
         ao6EThURp/ZECgHM3hBnwUiuDDO09YjrbG875QrrD43loXrMqdKez+7IsATFQRVAtucc
         xsYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774439532; x=1775044332;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=wcJGC0t55WG6Jay9XxY2Khzmswvk1BrrfcbnT4t2lGU=;
        b=fetoNuItLPznDUUJlbA/ivlP+xi87ENTJPK8sYKTb4xV+d7dhGdIXq+4TFDry7vdiE
         GDE5dqdHPz4uHQZ3gSYJ02f0JHbOBNgb717bWBJ389OaCo1e4vPpVrelSkdxt8DzTbmZ
         f+/KzqzNGDPg/vk0wsHOiA1MZ1EG76H7Bn9SGVnUar93SnNO06U+f+5CnOL/rd8iLiLE
         XlSDXEBffypwxFpmifOSKbedhyz5lPGJvrM6R5CEL7h8/eZXaLwE3A93G5gYA5wUbEA1
         j4vXeuePT1VxWUtlWasWs3lbPINieYwthy1n6bBCwqOWPHhmP/lDqH4FlZE7iWmYkFKO
         U7Gg==
X-Gm-Message-State: AOJu0YxNO13Ow9qPuD7j6lt7kfjJTrA9QXhY7H4Al8txrG/i5c4ZTir7
	f1tL7FzzJcMBvjsWqMYbNfGml9Zdh0pfBYtR/DwmOjJ5bI1SZxYxKtN2VoQ4MGXZjfI=
X-Gm-Gg: ATEYQzxuxBTyj/QE6NMTAXWyiB381UXOYbmo6JYMveCyKbEEb28M40XKzz2gM9sj/w2
	MMEqPUa2gShkhH/E+Qvbd0twLBYPGJclsJSq2qRVqgpg3eNtRbCygU/W1PtZduH6sohFbnZmFLR
	dM4mNbT4NGwVBD+K8GpqmhLpJLIJELmHv+pbSRR4E4Wub3b5gO96BZh+8siEnZ0bIxWsSQkPtLX
	1/sLubPjUyzDBBgY/Gppg++Lzzh8AHTlixlohaCYgb3gsmIbno8dQgd6WmE8iEaVY4TVKtD55F/
	j9zOrs5pgk2pb2YfZVieQR6vBqXb/ttAuv7j4E7nfVsTnAGheiD2mKiyDrSkie9DmXB68itPlgv
	95+vSYbFPCWoJhtcppwNDjU9uBstviG8hSTeBjgXjBBp/kqF+jkANfKAoHCQvlSjilqyHXnOJ7k
	7dilOz3e7yauDcoJCv7awO3VXFuLla7g3lnvQmD01wD+JevaEnNf5DNpXQ2hqxlMlJ+54lyhY2x
	GiyqNldiXiiF3Gh
X-Received: by 2002:a05:600c:4da5:b0:485:3ae8:2231 with SMTP id 5b1f17b1804b1-48716092864mr24730845e9.30.1774439532179;
        Wed, 25 Mar 2026 04:52:12 -0700 (PDT)
Received: from macbook.. ([88.130.184.197])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-487116939b8sm192389865e9.3.2026.03.25.04.52.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Mar 2026 04:52:11 -0700 (PDT)
From: Mahi Kassa <mahlet.takassa@gmail.com>
To: git@vger.kernel.org
Cc: gitster@pobox.com,
	lucasseikioshiro@gmail.com,
	jltobler@gmail.com,
	stolee@gmail.com,
	Mahi Kassa <mahlet.takassa@gmail.com>
Subject: [PATCH v4 1/2] repo: factor repo usage strings into shared macros
Date: Wed, 25 Mar 2026 12:51:47 +0100
Message-Id: <20260325115148.101867-1-mahlet.takassa@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260323152937.257406-1-
  mahlet.takassa@gmail.com>
References: <20260323152937.257406-1-
  mahlet.takassa@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Factor the "git repo info" and "git repo structure" usage
strings into shared macros so they can be reused in multiple
usage arrays.

This is a preparatory refactoring for subsequent changes to
subcommand-specific help output.

Signed-off-by: Mahi Kassa <mahlet.takassa@gmail.com>

---
v4:
- split the preparatory macro refactoring into its own patch
 builtin/repo.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/builtin/repo.c b/builtin/repo.c
index 55f9b9095c..b5146499d0 100644
--- a/builtin/repo.c
+++ b/builtin/repo.c
@@ -20,11 +20,17 @@
 #include "tree-walk.h"
 #include "utf8.h"
 
+#define REPO_INFO_USAGE \
+	"git repo info [--format=(lines|nul) | -z] [--all | <key>...]", \
+	"git repo info --keys [--format=(lines|nul) | -z]"
+
+#define REPO_STRUCTURE_USAGE \
+	"git repo structure [--format=(table|lines|nul) | -z]"
+
 static const char *const repo_usage[] = {
-	"git repo info [--format=(lines|nul) | -z] [--all | <key>...]",
-	"git repo info --keys [--format=(lines|nul) | -z]",
-	"git repo structure [--format=(table|lines|nul) | -z]",
-	NULL
+	REPO_INFO_USAGE,
+	REPO_STRUCTURE_USAGE,
+	NULL,
 };
 
 typedef int get_value_fn(struct repository *repo, struct strbuf *buf);
-- 
2.34.1

