Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEE7B3264E6
	for <git@vger.kernel.org>; Tue,  5 May 2026 10:33:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777977235; cv=none; b=lU3D1vORJ3c/z47fS6nek8U9GfbE7VsgO190E9KwavQmO7XuSIJnHLvS4MkmFZwcO4WcSLC93cBFlx3nm6GciwsYj5UVvaRPVq4KPzsbJ1Jky1I1OQLeyr/sBf9iWfU/7j6bSRxrKYQvIt8qJ3bJIJqlzSz1oIpARPFJy0Y9bQM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777977235; c=relaxed/simple;
	bh=tuFYEnskQzqMFesnyjMdUQALoLtXjEeeGZBwS2TIp3I=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Su/d5nt6JKuKRiFvWjSsM7UWO4UZADvgy+mymGhUAAM+f3MfQ1UkTFGvrU04J9xeQoZHjwKkFjDJQci8N/c1I4KzZ4P3QJQXSrn4C9MVC6jS7oxBHMVKh0dkGPH/95idyAU/t2yIcJwVNteIG9IhL9vBBjNRx2Sl5lTrLeXtlZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Kh+2WaiI; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Kh+2WaiI"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2b788a98557so41679585ad.2
        for <git@vger.kernel.org>; Tue, 05 May 2026 03:33:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777977234; x=1778582034; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=h9BmGeywZpmS8vnu8WlrRSI/5q/aegpI7huBSGKLTjI=;
        b=Kh+2WaiIhIoK3zJnaSp72lNkV1oKDxd+9PGmx4UVv0lsKHyhjgaFbm10nar+CJB4QX
         6uGUInUYDhiwHLKYlB4jHXA+DhQD4Y/8umWmn7mQwrwHPUaHXbNHuTDokLRPv2k/0t8r
         v39oi+eTWICtvK4pYpCO5Fbhfou4rQoBPesULPkmMen/P8fELGRIaezshi3dvYbxGLpz
         Ry94E7YkjhqZlXv+zfwRQOd/H9qJAv0tNtljyGGjiu6YuJTqjvAnY4pOy7Rxmfj4Ccyf
         Thp005xlsB/dqqCtL1UZkyYQuw3INWB/7ebJDeAM2d8NvjJAZpLxI8Ie2r/CaBushrhx
         tc+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777977234; x=1778582034;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=h9BmGeywZpmS8vnu8WlrRSI/5q/aegpI7huBSGKLTjI=;
        b=Dnza27+tqM7l8Y1+hbyCks492mgjMjlO0AX/6W8bz0IZgWvcT5fI2awLgn4wkrevS6
         KBayETuCQpoQdfMc/gpFI+Z4uyLaXWIve+dBv3BY8sYMz0xqmb4w1qJucEc03jLHJC7H
         Fn6EfOYMLmv0TXi1sBYTryD3me9t42X+R6HGYQk8bNV7Y4mPrMylLylmMTVEt+CVRMfp
         vpXls5KhkkGn6Lm7scqW4fbDT7+IwcJB6iYu+gxNs0DrjXSHPPysVGglEIVkhd7tn3gy
         UM1usO53SKzHhABrCLIYaM5M0Lks9T1ZCtxxEr+jSOiE0ZGe8tJkJaa/TChoo9cIsYlk
         B1tA==
X-Gm-Message-State: AOJu0Yy7NRd+QG2R1Bc8jQ6a8KR4D1i84N6eS8VDh3L0sHKmSAiGAQL7
	qSaKaYc7/efTES4vTQwir1zv/gT458xf76YRP/djr8+bPAgg7k/tmVBzBk5KOA==
X-Gm-Gg: AeBDiesk4oQwruIPHjQQafEJwgJI6MBLou43aLOeRzrb3UBhDcffLKC5JYCYGULLovY
	3Dxp0gfRrnTATJWl0RmZLfc6fkjHbxkoObSqHwNOnsFCSJszvxCXJV8Vg8tapPSww+xlj0pSBle
	yx89yNlLMOoqwWqMmpiGqd/EQ1AV8k58ZFG30vRPusjic3JD41Yxjnexna5jEBvfWD4kc3i6My+
	kQP4SYdJD/1meTVgqIMEHk3Vu5wT9HcFKKQiKraBPebsO1Exh+76Tq1kQuiZeAfGC66pGYeMboG
	X18l7oa0T5+zCs3gzyvmFarutGCUaKer3PlOPzcKcJfs9mz0olejoCxsJETCV1tWh26j+mW6DH5
	Dt63HlFaPgJE+V6rdhUcWkeXy6UJH0HoiiGRlTwZ6BAsqzFxLur8tkjKlSS6KSOn5qQ5/YfFzsz
	57fENOg69Ha0ZdaFlj1+S+U3FFg3mTRg9pB6PBpEnNPq5m59C1y4v96UmC
X-Received: by 2002:a17:903:32ca:b0:2b4:6367:7b86 with SMTP id d9443c01a7336-2b9f2839de7mr124544625ad.37.1777977233748;
        Tue, 05 May 2026 03:33:53 -0700 (PDT)
Received: from Pushkar.localdomain ([49.37.114.64])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b9cae0f67esm139031435ad.51.2026.05.05.03.33.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 May 2026 03:33:53 -0700 (PDT)
From: Pushkar Singh <pushkarkumarsingh1970@gmail.com>
To: git@vger.kernel.org
Cc: gitster@pobox.com,
	peff@peff.net,
	ps@pks.im,
	Pushkar Singh <pushkarkumarsingh1970@gmail.com>
Subject: [PATCH] stash: test show --include-untracked includes untracked files
Date: Tue,  5 May 2026 10:33:33 +0000
Message-ID: <20260505103332.43702-2-pushkarkumarsingh1970@gmail.com>
X-Mailer: git-send-email 2.53.0.582.gca1db8a0f7
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a test to verify that 'git stash show --include-untracked'
includes untracked files that were saved in the stash.

This ensures coverage for the third parent of stash commits,
which represents untracked files.

Signed-off-by: Pushkar Singh <pushkarkumarsingh1970@gmail.com>
---
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

