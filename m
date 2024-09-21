Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 008B8170A3E
	for <git@vger.kernel.org>; Sat, 21 Sep 2024 15:09:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726931347; cv=none; b=LqF+Ei3o3nb5NGHTzCzuc5sp+LlO32jSm0OPAoD3aN+4Uw3lABSLHQ8u6AIMZCAYkl5gQ/X5I41g5kfffIcej7S7PLOE+5SSZPlXc1l33T9uIYs5dqm9m+o/V+ynl6PNVlmoyVNXmc7dXMXF6jnN7lyBAuzeKK5ARXaksz11wvA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726931347; c=relaxed/simple;
	bh=p5V4eot5G0i9me+k7ZDD/KBgsanB3RRbsEAHC0ubjqU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=dVSwEbPh/RwYVxW3j/tvWV102mlp+pf6tHm7yICbuus46+mLRaf7VtAAFg6MBnEioKF2aoPDe/DRbHFl4SbC+vTF3yryooidDrui1vHHgs8OhWkPbTL8WQF00Myj7N+EwUMBY+4eot3THo6uEP3XSKk+ciPdBuq5rZJNqBixRLE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Xp4KK8d2; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Xp4KK8d2"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2057c6c57b5so18970585ad.1
        for <git@vger.kernel.org>; Sat, 21 Sep 2024 08:09:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726931345; x=1727536145; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Km7Yv6mjcNmpi8UM3NeHHRefFmLftrEytuDa2at/sgA=;
        b=Xp4KK8d2MEmBcA1dIoLHcfzxpKzsVtNcXjk/LYv/+9qRlR4FWt7eimIIaBT0mlpVQP
         BCExhMCfe5U7ivJoZK9w5ailj5YqbudEyw6Puhj/PD0BzEigSwYwgwwhZ7QQMwH7ZQd8
         fBd5iheBNuUZRS23PWDSel+ZiNov0s7ua6oMxj3w2nr+58y3jl3aijPdAfANcKx4m3Nh
         3y413sTwhOgBZmflddKcxTRZ3qCA1wvK5aRuZfs05CBA42UEg/DmCuNP+jqWK0znjOkG
         nt/c/YcSOjjms+BvbZTdth40FcX4yGjR4BJ9jULuYlE1OnYKL3OkBMFCn4XGylNdrlUs
         xe6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726931345; x=1727536145;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Km7Yv6mjcNmpi8UM3NeHHRefFmLftrEytuDa2at/sgA=;
        b=XDJt05Lca+V+sIIzs/p3FoefSVMoat+ee7trQIqIYmqOv0fEu3K1IhAgr3N5UGYY65
         7U2tyf9H5GWM9+9mHFetCnbFQl4As/wv9gRtdgIhOLC9odybKD+O5NkHk8dyEErxl84b
         phUiGk69d3Y10CFf4xyVnK9AUjI8GY279bgr6Uda1/DcTj9VJ+8ctp08T2km/7BmWTuL
         u2lFL3SrIm047q/1Wh0FN48i9R5QPBRFYVE8k++B7p9DZ3ozwM3NKlyOnzdYCQPO/+O6
         OpteOvwINyyPjzD0Qf2beiSXgc2AAbHinjOzgd4ZsUw59xMoEtCJVxtBQeJVVg0K3aCI
         g70Q==
X-Gm-Message-State: AOJu0Yy9Z68hftnIDOGnZ3gnePFRpYTlmuAVNyuoAm85HqRj+OzANgdT
	YgISQU4rIgUSDUh0QBzBWQlg74SIM+VT+smmv72E9p1Wq+OpXgZrOEdkAQ==
X-Google-Smtp-Source: AGHT+IHHBkhywAY4IJ6UmV6+592nGS22cY9kssu5O0bm4tG61DDiXOLLzmZGJX4iIgtHhQDBdtuepg==
X-Received: by 2002:a17:903:22c4:b0:206:b1fa:ccb0 with SMTP id d9443c01a7336-208cb911f8amr135732565ad.25.1726931344882;
        Sat, 21 Sep 2024 08:09:04 -0700 (PDT)
Received: from localhost.localdomain ([175.112.156.113])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-207946d169csm109218755ad.138.2024.09.21.08.09.03
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sat, 21 Sep 2024 08:09:04 -0700 (PDT)
From: Ruffalo Lavoisier <ruffalolavoisier@gmail.com>
X-Google-Original-From: Ruffalo Lavoisier <RuffaloLavoisier@gmail.com>
To: git@vger.kernel.org
Cc: Ruffalo Lavoisier <RuffaloLavoisier@gmail.com>,
	Stephan Beyer <s-beyer@gmx.net>,
	Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>
Subject: [PATCH] am: fix condition check on fseek
Date: Sun, 22 Sep 2024 00:08:55 +0900
Message-ID: <20240921150855.31574-1-RuffaloLavoisier@gmail.com>
X-Mailer: git-send-email 2.46.1
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

if fseek() is success, return value is 0

Signed-off-by: Ruffalo Lavoisier <RuffaloLavoisier@gmail.com>
---
 builtin/am.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/builtin/am.c b/builtin/am.c
index d8875ad402..a7727fd4ea 100644
--- a/builtin/am.c
+++ b/builtin/am.c
@@ -589,7 +589,7 @@ static int is_mail(FILE *fp)
 	regex_t regex;
 	int ret = 1;
 
-	if (fseek(fp, 0L, SEEK_SET))
+	if (!fseek(fp, 0L, SEEK_SET))
 		die_errno(_("fseek failed"));
 
 	if (regcomp(&regex, header_regex, REG_NOSUB | REG_EXTENDED))
-- 
2.46.1

