Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6D552E7623
	for <git@vger.kernel.org>; Sat, 16 May 2026 18:34:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778956478; cv=none; b=VPmIS9KPSNxvz7cgfEcNfsCTIGD0cpqDwFYcQ3SSJdbpEH6tMNwbjutsfv1LZaAIUZD4PYSWgYaDfHoEBmkgcQOJei12G2qFknySCagvMdCTUxa4kA48RF8dYxjoZ9T7WQ5D+vJXj/dbMyOyo+su/uTKX1BYQ8TrFmgXAcoinvg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778956478; c=relaxed/simple;
	bh=KPnDJOcSItAxciZGFqEOE97FMivOy5tqtWzl3r9+4MU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CVYevuU7GtdDM0IjMMXDkgNy8SHKe3P9BJSgekfM2yk5CeMZtUOOoajiFbGIH9RqDVfy49ROTWEhum4aMtpqMrV1XjhW/RBW97T2r0+au83jWXMz/BvkRG+ms1ZnylEVUzc3Mn8UgJ+3O2tZjsjd+N1jWmbiaxx5ijE/Gyv4Zhc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G3R2weOA; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G3R2weOA"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2ba856db1c0so7738705ad.3
        for <git@vger.kernel.org>; Sat, 16 May 2026 11:34:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778956476; x=1779561276; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e7hLzo+gg46Mo9NOQHrI6DpnLc2Rq7hpFj5A+PyXAis=;
        b=G3R2weOAGTSw+hC4cZZW79+Nq5Ucw85d/UgebZzcGaQXwRtRcJipar6NEd/UsGheWa
         knk5LNqM0vBGR4LRDMbPrzKQ/ZcZq51xqVjR280t19dMTFGM8DyIzQe9xLM0ZJe3wLjx
         8e+pwttMGMEGGgF/Q+B/GZoovN0r6DZrUwY1g3UIxlp/KVMuJ9O6PRIqm3YnzueOW1Rl
         IW5mQpqCGTqR2AccIMM9cNvpXzZmE5rDmBc/pN9LRBJy1uvO0MhSYLCA6y6NFyYnWHc3
         ijKrHkDUMT5PptmfSRdsImESoHJPj/e19ycQHJXkpWv84xzXybwRnGuP2rz1XRuQ3Mqc
         0odg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778956476; x=1779561276;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=e7hLzo+gg46Mo9NOQHrI6DpnLc2Rq7hpFj5A+PyXAis=;
        b=Mde8Y1X+Qm8ZsLr9Ep7qsZq54tuVbV9Ip4vn28OEHKITAwIgvlleyIfb09pIxp/taK
         Zjp+EmRZC+DXHBf2RiMep45aHTPloFbZZOjHbnQnwfB/t0zh3pmjTJ+6JkeTHMhWU2kA
         hEvOGcWFfhcNXOEKxCGuQZaOrO4cQyP795eRzv7CCJvHDxrrRinUuTmNZoitClNMj69C
         xyWbHZI31ztUsjBZykT+GO6ANQmLcRxKGpDty2ZL4a0xnZr9HAY2+kjV1jBd3dJks6v2
         P6KvDj0cgyymTM9fmmf6RgDQjZB0eMWoINoV6JnTKNiqd6XWpoqcB8grCu3O4MeNou95
         NMFw==
X-Gm-Message-State: AOJu0YyGrrqB2Uf2/3y/Lqn+qT+e1oefFbMM5pqnpRiDgP5EyTdqZuJF
	FjDU/1K8iaOayT+B1T6UHlKWefEhoIDHu6kDCrU08ofnJsrke3sVlKjL
X-Gm-Gg: Acq92OGdLasSGuGndcUl6Vu/4pr1tnW3ff308DqTnofugZ3jb4hkLN5ZRzYFEq1LQXM
	T6rzfhy5SO1kzcXb6nide/VEbv5nQcYPNFn0FYLNKN8sGjubbmPRds2N6DWIxDuVjWPxUuUbq6A
	aF8N32K4/LOK1RMCsy5B8h3C6RDf3laWbb0UWYmTdqRJA2diiLslD0CW6GZcO9tagHw2YLSW7ws
	KEiXvurA0GSSTOZoF6vSjiVQfNmFoIvwjPTSTVueN5A54lC+fF0KKTeYfFvsiTTJpjb6sJGIVFd
	rVlK5cB0PnFs5Rj4yvKUX4eNjVI6UBygX1/s7etOMsqAGn6UrzucEVwlKqlP3wrBGsbok2ul8fx
	U1X+txQ7V2cYrdfqy4XQb9i0NPa+V2t5FpezPS68Zr7B6GlIvZ3vE6bIb15AecEiFINX2ZItVzP
	g4cmdJJSfqbU/yR0kueodz9KDKWOmtkjEk9cXwK4KqQoDzoMbmRZazU3fzbWc=
X-Received: by 2002:a17:902:9690:b0:2b2:81aa:f6c3 with SMTP id d9443c01a7336-2bd7e8a91b6mr73027565ad.29.1778956476106;
        Sat, 16 May 2026 11:34:36 -0700 (PDT)
Received: from Pushkar.localdomain ([42.110.173.201])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2bd5cfe492asm102190695ad.48.2026.05.16.11.34.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 May 2026 11:34:35 -0700 (PDT)
From: Pushkar Singh <pushkarkumarsingh1970@gmail.com>
To: pushkarkumarsingh1970@gmail.com
Cc: git@vger.kernel.org,
	gitster@pobox.com,
	peff@peff.net,
	ps@pks.im
Subject: [PATCH v2] stash: add coverage for show --include-untracked
Date: Sat, 16 May 2026 18:33:48 +0000
Message-ID: <20260516183347.4323-2-pushkarkumarsingh1970@gmail.com>
X-Mailer: git-send-email 2.53.0.582.gca1db8a0f7
In-Reply-To: <20260505103332.43702-2-pushkarkumarsingh1970@gmail.com>
References: <20260505103332.43702-2-pushkarkumarsingh1970@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a test for 'git stash show --include-untracked' to
cover the case where untracked files saved in the stash
are included in the output.

While stash creation and restoration of untracked files
are already tested, there is currently no explicit test
covering the output behavior of 'stash show
--include-untracked'.

Signed-off-by: Pushkar Singh <pushkarkumarsingh1970@gmail.com>
---
Changes in v2:
  - Clarify in the commit message that the patch fills a gap
    in existing test coverage for 'stash show
    --include-untracked'

 t/t3903-stash.sh | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/t/t3903-stash.sh b/t/t3903-stash.sh
index 70879941c2..d4867536b9 100755
--- a/t/t3903-stash.sh
+++ b/t/t3903-stash.sh
@@ -1790,4 +1790,21 @@ test_expect_success 'stash.index=false overridden by --index' '
 	test_cmp expect file
 '
 
+test_expect_success 'stash show --include-untracked includes untracked files' '
+	git reset --hard &&
+
+	echo tracked >tracked &&
+	git add tracked &&
+	git commit -m "base" &&
+
+	echo change >>tracked &&
+	echo untracked >untracked &&
+
+	git stash push --include-untracked &&
+	test_path_is_missing untracked &&
+
+	git stash show --include-untracked >actual &&
+	test_grep "untracked" actual
+'
+
 test_done
-- 
2.53.0.582.gca1db8a0f7

