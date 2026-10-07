Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A9CE49B21F
	for <git@vger.kernel.org>; Wed,  7 Oct 2026 13:50:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791381059; cv=none; b=jHYbKnxdbY+EfdpbhjwSjHVyUohDHR2xmIAi0LQ8tlGmkvgNvMLgJJWrnesohi9SVqS0Zt11ZQzcvgMp2fTWBZdWa7cUk0uxlFPTTF255W/xj+HZxJiN9GITwqTpwemdO6+nrziCfMVlieC23QsdPW3TIq5dUpsxNaHbvpN3f3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791381059; c=relaxed/simple;
	bh=vS2hj9MGoy+va3sqJzI05yeAqW/OQ61UUnYhKhu2mL0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YktVxFBvl2373UFfYwySMcqYK9YiHPT5DcauLVmTW0o8UdIlTansIg5MMNOs7gRZbGi+RIajZPLbmaDbVgU8FzJz8A8XU57AZkfB0gL45W0RM6ErcXnrfbj15SOKjrf+sjCfaKzQN2LUSj12GrUCry+2rSp59IL07OqvPnpU3nk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mu66BX6g; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mu66BX6g"
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-3a813079a55so967288a91.0
        for <git@vger.kernel.org>; Wed, 07 Oct 2026 06:50:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791381047; x=1791985847; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=d9R7YS3vZrMjnuMVHLcmM6fHPd0EzluGLC5nOTSxXcg=;
        b=mu66BX6gX0nl+yf6Eb7pqBrAi7VmsAHkeSapqoCe5I/ZsccoaEZeLtgmeF4R66jy5l
         2fXvmyGiB8I3+V5mi9CAXeNIkpht2rN6Ppn+8E7DZ6FgN/YBG8KW8DjG1fOtXZ/7O8zt
         WZx/Wp3KF96+hGEIcJzCt5Wfrwo8VqGlNXp7LRS/MsZK4NWgNSwFo7MFZ5LROMQvrtNw
         T3SePGJcvdLM9JsO3lJLr5Sml3bBq89yPjFkx5pX5+y+i1dxol+brNOTYzGtHWNRLSEb
         DQaL41j+vocGQMgijUc10rQtz62jO19xuFka5cVTNRIkAKL2Eh/o2GC+R7JlAApeyawj
         mbnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791381047; x=1791985847;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=d9R7YS3vZrMjnuMVHLcmM6fHPd0EzluGLC5nOTSxXcg=;
        b=fdLuSXSaw5adtLpKTLPlm86dcLrU6wIQSA2hhBCQ3pMYYobsgCNxveOqHGPXZVBWgT
         NPTcrvy0TpaDOo9qXPuXqQQ1gmZmgXbUNF8e0u9S0mt8x8enZqGFaxPsNnsPSso0ZkfZ
         7cC2e84ad8AUxyL+B1XAQVdJSkkmjCw/4UeY1zt0vlmhS9ji7FhlIG/TTm7DywrwhzSZ
         GoWwovKaQ/DwmsoGjfYsr0+o2q2K1q8CwoUfnzeqWMbact0bWGVusKUOCXX4LWYQBvey
         PLz7A0nNRo1ZJzudkR/PbsmSZMQSMchNQGSsZuGNmWNcjFyLmFUM/EDp/3aswgqJMlYe
         nppg==
X-Gm-Message-State: AFq9FYLXzDs5o6Ffk206n1TU61uU8J2D8LCLpq5/fQGnjs/1kFDwocdw
	q5h7AH8AZ6kpa2WUSnXlm69m2SLX+rVHT3MPB08aPyysllE4+8lmyUzKb/Xi2Mf1NSFodA==
X-Gm-Gg: AYBFou0Re/WoBc6X7c5CBLF+yuVptjS6sUDyuzqs+429PkbT1bav9IMk3q5BWZ15l4c
	6bZCrD4/a2K+M/8kOayakU70J7udqX+KrXILk7piMrkWaa+fN6E+BhuE/KuC6q4XJ3GIythOZhu
	ZTDShBoFjMtZeUkvsh8GebGHuh+dRGJtG71u8UVTk7kueTSq39l86HrhHWnalcVxoIK5YY7cUVm
	MgTH+Mx9MYF2g0JDVJ8uKkbmt1QK/TDFD/9PQKPpNZQki8DfMs8H9ZNbSXH10Hd++npKUYsyytl
	01wVVsG6dw4NvPWRtVWCLD0W1FXh4myOgSDYTxOISCApGRLBvLacLW0Gn0b0pvSz5uON77EIEoW
	Ml4KaX/LB3jpF9RacfGozeL0SxwWHU6J7/ChnnUZy82w46Q5avKTaWz6WdLyZXKzSGG663KzhVZ
	bHxGqkqTfl9RY5u95tloK0ZP189PzP0VrWDLXf0drCEEoYhA4xx77bzCGtMfjq6iyXAEOnVNYId
	VScz8c=
X-Received: by 2002:a17:90b:3148:b0:3a7:a3c8:8f4a with SMTP id 98e67ed59e1d1-3a8a0e05131mr1428937a91.18.1791381045884;
        Wed, 07 Oct 2026 06:50:45 -0700 (PDT)
Received: from archlinux ([2409:40f4:314a:a1e2:9855:ada9:1db7:a1fd])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a8533abe0asm10577916a91.1.2026.10.07.06.50.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Oct 2026 06:50:45 -0700 (PDT)
Sender: Dilshad <hello.dilshad.in@gmail.com>
From: Muhammed Dilshad A <dilsheddilu123@gmail.com>
To: git@vger.kernel.org
Cc: ps@pks.im,
	Muhammed Dilshad A <dilsheddilu123@gmail.com>
Subject: [PATCH v2 1/3] test-mergesort: plug memory leaks in sort_stdin()
Date: Wed,  7 Oct 2026 19:20:23 +0530
Message-ID: <2a91f29982cf18ef6ee6770c671b33e042acd308.1791365181.git.dilsheddilu123@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <cover.1791365181.git.dilsheddilu123@gmail.com>
References: <20261007034205.32619-1-dilsheddilu123@gmail.com> <cover.1791365181.git.dilsheddilu123@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The sort_stdin() helper allocates an input buffer and a memory pool for
the list of lines, but returns without releasing either. Discard the
pool and release the strbuf after printing the sorted lines.

Add a test for the sort subcommand to t0071. The existing test only
exercises the test subcommand, leaving these leaks undetected by the
regular leak-sanitized test suite.

Signed-off-by: Muhammed Dilshad A <dilsheddilu123@gmail.com>
---
 t/helper/test-mergesort.c | 2 ++
 t/t0071-sort.sh           | 7 +++++++
 2 files changed, 9 insertions(+)

diff --git a/t/helper/test-mergesort.c b/t/helper/test-mergesort.c
index 791e128793..3b8c428b14 100644
--- a/t/helper/test-mergesort.c
+++ b/t/helper/test-mergesort.c
@@ -61,6 +61,8 @@ static int sort_stdin(void)
 		puts(lines->text);
 		lines = lines->next;
 	}
+	mem_pool_discard(&lines_pool, 0);
+	strbuf_release(&sb);
 	return 0;
 }
 
diff --git a/t/t0071-sort.sh b/t/t0071-sort.sh
index 2236a7e956..97890da29f 100755
--- a/t/t0071-sort.sh
+++ b/t/t0071-sort.sh
@@ -8,4 +8,11 @@ test_expect_success 'DEFINE_LIST_SORT_DEBUG' '
 	test-tool mergesort test
 '
 
+test_expect_success 'sort stdin' '
+	printf "%s\n" c a b >input &&
+	printf "%s\n" a b c >expect &&
+	test-tool mergesort sort <input >actual &&
+	test_cmp expect actual
+'
+
 test_done
-- 
2.55.0

