Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 579CC2DE6E1
	for <git@vger.kernel.org>; Thu,  3 Jul 2025 07:45:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751528723; cv=none; b=AS7+IyqjPENtQdVKSHzkXcV9aHIwJo6vdQcuOcF31iMMQR/kPLGsD6jUYIK4kAHejQTZGkE4P7TQSJO1ZR6AHC708IjgtUJuPup2sDfD3IeSjXMhTRM1l1fzNG3tXrD3BtRMaQBWruu3B8kkYrOfPRkvDlMdmmLkANMK6ZWNgaw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751528723; c=relaxed/simple;
	bh=sLk7EZ5IwUGQn34Rt30UsSX+HdgUKotYKN96mlyyNyM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=o4dcwkuoB43OLbU4tGXhcEwZraGH7Y/6KonN+l11SRhgvIfgRs/Zbql/b8/eTe7XtuYt4wHkSKeDzjpcq2jKQqLSaWj607j+fGRE4Vg3aRv2x8Aj5wz1Ik6ZIEiyUP0sPz9b8oG3N3Rbv+xZ6vL/YdqloKfQOKgIb4wNxEcek1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=W+eXxaHE; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="W+eXxaHE"
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-311d5fdf1f0so4415021a91.1
        for <git@vger.kernel.org>; Thu, 03 Jul 2025 00:45:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1751528720; x=1752133520; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rgd0TdpxrlWFhy1dpU4PLkitvMXg5zjr+BRMLN5ptwc=;
        b=W+eXxaHEfaYrteZajikON5EKmqSodrT3QxE9XlrjL171Yne9V7l2OuosFVHP0TnRU+
         lptAsOIE7SSGXWzS3dbXocIZqOWgIcYxFv8JlRJcZz4XH871aW5l5eaHURJC664dC1Sv
         13bl58jU8y29KOyQb6bY0le1wJt4U5eLNhbyuCGuLNAo8bq9wglf7nWEl4WpPwP3vDjq
         HlaMcOT1QiEDBVHOdTzMuRQaWNIEkOgWnt1R6GGDI9ZkT/SXxQyes7kfJyBnxpSm9XAQ
         P+RVX7FAGzooOx5pPv3cuXOrkT1DbaBqz4YXSPyUDCR3DGMBS0BRPSW+VbpMmcG3NJu7
         P9Tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751528720; x=1752133520;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rgd0TdpxrlWFhy1dpU4PLkitvMXg5zjr+BRMLN5ptwc=;
        b=CznxX7DZkqc4vVmetMKIng0BhdrqjLDNgirYg5UUpw7jk5PNeMYreXjgca7iAq4+w6
         MlayLkyACjlr6YADnsAxCPEvK9hf+JkvhijDuI4FWkhw5jzDacGMWlN/+6UZA4RF5ldS
         SYQunXk7Zkrl5XTBCJ9sPTk5mZ9YcUsq6fzJmFvhmE9ndUPnK80OsBN1IyJ6V1JLTD8w
         rvSnLAinkkHXWD7XBXCJi0E2sb/3TSKCAJBng3LszI7Zq4XyzJYU3eKCFInKO8aNuoJE
         P0DBGVwXfmq3hB4S4xii7MZN2i88yy+Vq7i3WJJpS7AHPPlFp0GMEbmT/9BcKNSm0/8l
         NJvg==
X-Gm-Message-State: AOJu0YxsKSgKJcMz5ZxRqpgg43zfKDSnLeNPhTNVNfNGsx2GRoe9JsCs
	wpAdHikSncar7vooMmvbvFuxdHulbBquEp9yeX4gQda3k3deV7yBVY6M+P2W3tTXtuM60lcoVFm
	oufy4ivU=
X-Gm-Gg: ASbGncvrjFLmGVpWPII+ydeTIpd8+riq6oL6KZRhiF+bXD4rZayJ0PZv/yAuXcZ+DJS
	njMT240p4eL0mvYNDjLzNq/j5Fwa49oW9a+GBUCnHRIqxm7bR/hTKK+wm6FCi9+pqw49qmgFxRA
	jbiJz1sQdFma1b8zPMrMZJitpJmjBEqttsuJhlzhAuwziohGSE5SRePS+IIEGOA6BYrDYlB1Ff9
	+3V8NkDXeex+R4xCsUxjjxAeRzU7lbwWJNFswRoRU0mvJ4ua/6X+lEL04DVuo6z4krq/PkJDdjK
	lTbSKHxCscsQTZR5h8EGdxZdYBuaUgmJCjDZT0GnCvV4AHJBx7Q0NDg/NIxYkRkKosGbRB4jFpr
	+mvG5ew4zJfpxkV75lzAcqU0VFN+cguo9OA==
X-Google-Smtp-Source: AGHT+IGHnqnnZRLMd9jKklvmaTErpObZDUFWAaUYMJ7IuSddp5Br1pYqggPBldJDN23jsWwu/8xWIg==
X-Received: by 2002:a17:90b:3cc5:b0:311:c939:c851 with SMTP id 98e67ed59e1d1-31a9d52bcbcmr3059871a91.4.1751528719972;
        Thu, 03 Jul 2025 00:45:19 -0700 (PDT)
Received: from LTY2K703JV.bytedance.net ([63.216.146.178])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-31a9ccf871csm1626979a91.24.2025.07.03.00.45.18
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 03 Jul 2025 00:45:19 -0700 (PDT)
From: Han Young <hanyang.tony@bytedance.com>
To: git@vger.kernel.org
Cc: Han Young <hanyang.tony@bytedance.com>
Subject: [PATCH v2] read-cache: report lock error when refreshing index
Date: Thu,  3 Jul 2025 15:45:02 +0800
Message-ID: <20250703074502.45593-1-hanyang.tony@bytedance.com>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250701115719.85226-1-hanyang.tony@bytedance.com>
References: <20250701115719.85226-1-hanyang.tony@bytedance.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In the repo_refresh_and_write_index of read-cache.c, we return -1 to
indicate that writing the index to disk failed.
However, callers do not use this information. Commands such as stash print
  "could not write index"
and then exit, which does not help to discover the exact problem.

We can let repo_hold_locked_index print the error message if the locking
failed.

Signed-off-by: Han Young <hanyang.tony@bytedance.com>
---
Changes since v1:
also check the "could not write index" error output

 read-cache.c     |  2 +-
 t/t3903-stash.sh | 18 ++++++------------
 2 files changed, 7 insertions(+), 13 deletions(-)

diff --git a/read-cache.c b/read-cache.c
index c0bb760ad..50e842bfa 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -1456,7 +1456,7 @@ int repo_refresh_and_write_index(struct repository *repo,
 	struct lock_file lock_file = LOCK_INIT;
 	int fd, ret = 0;
 
-	fd = repo_hold_locked_index(repo, &lock_file, 0);
+	fd = repo_hold_locked_index(repo, &lock_file, gentle ? 0 : LOCK_REPORT_ON_ERROR);
 	if (!gentle && fd < 0)
 		return -1;
 	if (refresh_index(repo->index, refresh_flags, pathspec, seen, header_msg))
diff --git a/t/t3903-stash.sh b/t/t3903-stash.sh
index c58ccb136..0bb4648e3 100755
--- a/t/t3903-stash.sh
+++ b/t/t3903-stash.sh
@@ -1672,11 +1672,9 @@ test_expect_success 'stash create reports a locked index' '
 		echo change >A.file &&
 		touch .git/index.lock &&
 
-		cat >expect <<-EOF &&
-		error: could not write index
-		EOF
 		test_must_fail git stash create 2>err &&
-		test_cmp expect err
+		test_grep "error: could not write index" err &&
+		test_grep "error: Unable to create '.*index.lock'" err
 	)
 '
 
@@ -1689,11 +1687,9 @@ test_expect_success 'stash push reports a locked index' '
 		echo change >A.file &&
 		touch .git/index.lock &&
 
-		cat >expect <<-EOF &&
-		error: could not write index
-		EOF
 		test_must_fail git stash push 2>err &&
-		test_cmp expect err
+		test_grep "error: could not write index" err &&
+		test_grep "error: Unable to create '.*index.lock'" err
 	)
 '
 
@@ -1707,11 +1703,9 @@ test_expect_success 'stash apply reports a locked index' '
 		git stash push &&
 		touch .git/index.lock &&
 
-		cat >expect <<-EOF &&
-		error: could not write index
-		EOF
 		test_must_fail git stash apply 2>err &&
-		test_cmp expect err
+		test_grep "error: could not write index" err &&
+		test_grep "error: Unable to create '.*index.lock'" err
 	)
 '
 
-- 
2.50.0

