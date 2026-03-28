Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1C1732ED29
	for <git@vger.kernel.org>; Sat, 28 Mar 2026 20:03:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774728193; cv=none; b=g6YCbf9Soprq9GjpVFf+PVzVGGtBX5LYUFQvMQWvHQJ0qKC2Ke38+2Tqkf2inNMI4YRt1Jm6iS1dYdLBXMZqv/n+FqW/hbf7bHHT6Kb+CDHfvdDT0ALMKi4Tw9/Kx2uAcliaWCZuH70/zgotNbf+g5UXJvYqpwG+lLQ9J9sAJJE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774728193; c=relaxed/simple;
	bh=94cfhfeZIN3avbGG6ElWIin6GlJXNKithmLmUyQ9S6w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Uv9cdjy42S8HcPDRZvdPiE3DJy7jxu+xMBXBUwL+4Gb10fPGIxM29ATrlBSQTJ8LS65iGauoRbRgJRdMvGvuVNvi8+ImiDPws55Uvqg+l2DhyTuwlV1Qd4c+sMmqtzy0/m8PsjZ8dSmVA1EtJUHyR9Nte7+0eexI/g8b6+KpyAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PDcLd4G1; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PDcLd4G1"
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-356337f058aso1835730a91.2
        for <git@vger.kernel.org>; Sat, 28 Mar 2026 13:03:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774728192; x=1775332992; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RHDX4v2BQl6o2dE+61CtEn5M1ZcmHBvM1PpCvadLpHo=;
        b=PDcLd4G1IUawwh4ucTy9MlWrnXvBMAhgjLrUC3Vx+Lhwab7K7bQEGoFRXkbv+Yq9Xm
         2ZxjVe9szoAvQXaYrV17EF53Ar+CFROCkORYLqIfIMdhiMYTemsoPU9sPeXAHbED3Rpt
         Vb2NP7lmSPeypYEGMQ7JqJ6PZDS7ygAqeocb4f7Pq5yoSAExvj/zaEQUn1UIEE882CXa
         VV2C/se6eJdy0AHyiVvgZ1t85lkTkAbQwI5945pNXK/Dv4Osi1OvPyuKSdfjAqDCvvjZ
         w4wNYikxXW14B8L/n3vxjmiU99Rx8FZG9IYTtVklwTpld3vYVKmKbcke1d4T/AnlHNh+
         27Gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774728192; x=1775332992;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=RHDX4v2BQl6o2dE+61CtEn5M1ZcmHBvM1PpCvadLpHo=;
        b=V+5TQtchKNHPbRtxNiXiQjHCE+v4ht9dOqxUstDmMJL7PhJvWpySGIeguWM+3tfcZ+
         n0uE52ppDEmUdDxvZ4s82nB+l12Mc2UBgAA8fxg0UUfjdqC9kB6qgsiVyiuD4pTkHWzb
         lsh9ZZwemsL2BdgbRD6qdK5TMMMqLdgcFSAg720HwuYzSYhyMJZ8FKKV2NkBU2yjKf5j
         Kd7Gw7h6ejFa7cyBwfJZuOi3hpKGSB1/+ALxzNszJTbQx2GhOlZ76h8z3Kg0WAFSRtMe
         /i+rycdXdHktQLjAO3EtOD8d8jpuYzDLinEh4O7p/qUiWXTnrS7APCDZpmPYNHm8WmMz
         QS8g==
X-Gm-Message-State: AOJu0YzG/gf/7tQWK21JDaTSfI1bpcWHYMcMiwJ39I7DPRCrDJW28w7Z
	kNwJ7x5tQdyYvuoSZd4lAV2C/rCOLi4gu4IvKRF7AXTrO8NmIc1Qwd/n0jcoHPbf
X-Gm-Gg: ATEYQzyJ8FxshA6YMHEdpWTwZUGE3FWi5FC08gI0aLlLJvjFEOGHYuRUy5e2PdsgO88
	imlcRnPrNlcvTZ9XGKGvFNgKNK8MUSHi0Yg/XMyW+87TlknFBTKbytZHhLT0aEUAL0Mt4c9ZV3X
	mj9OSjTEAeyL+SwqXgKn40wHnlYqmvgGA2CjzrrhKcMk6YshmXMit/sMUpjE5VkemAb0RkGHxe/
	8oPZDYQOmkFauR60fzSi2JAe0henSKDU/233g5+uI7eQs+P0vkxxjG6PvihTaRMV7xwM+LmWhlY
	hTax6lC5+IeMkJ1M4SmpIk/GbVU9YmLpBJu5gWelOz7v2XDd7IbK1ctgXMqubtTXKeVp0wx07Xp
	HYXrj2PHB2iAwR6xJDebn+2yjOQxVt/DfhAaxSbZ/kE8y4IOpIX9X9gNZ89TPI0eM8iruLGWFXt
	nBwky2ulKCKS/HvRMIzp4PJMCV6CCjTnzX7Gxqz9cF0EWwuANJMocfSpP2sDzzxLjQrQQrMWxbP
	z0lVrtLsw==
X-Received: by 2002:a17:90b:3d4e:b0:359:83d3:27d3 with SMTP id 98e67ed59e1d1-35c2ff4fad4mr6669127a91.2.1774728191750;
        Sat, 28 Mar 2026 13:03:11 -0700 (PDT)
Received: from trieu2-huynh-trieuhpn-ubuntu24.bee-live.svc.cluster.local ([27.122.242.65])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c76917bb31asm2359786a12.23.2026.03.28.13.03.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Mar 2026 13:03:11 -0700 (PDT)
From: Trieu Huynh <vikingtc4@gmail.com>
To: git@vger.kernel.org
Cc: Trieu Huynh <vikingtc4@gmail.com>
Subject: [GSoC PATCH 03/16] t6411: avoid suppressing git's exit code
Date: Sun, 29 Mar 2026 05:02:42 +0900
Message-ID: <20260328200255.247759-4-vikingtc4@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260328200255.247759-1-vikingtc4@gmail.com>
References: <20260328200255.247759-1-vikingtc4@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Update t6411-merge-filemode.sh to redirect git-cmds output to
a temporary file instead of piping it directly to not hide the
exit code of git commands behind pipes, as a crash in git
might go unnoticed.

Signed-off-by: Trieu Huynh <vikingtc4@gmail.com>
---
 t/t6411-merge-filemode.sh | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/t/t6411-merge-filemode.sh b/t/t6411-merge-filemode.sh
index 6ae2489286..9fe4271555 100755
--- a/t/t6411-merge-filemode.sh
+++ b/t/t6411-merge-filemode.sh
@@ -27,7 +27,8 @@ do_one_mode () {
 	test_expect_success "resolve single mode change ($strategy, $us)" '
 		git checkout -f $us &&
 		git merge -s $strategy $them &&
-		git ls-files -s file1 | grep ^100755
+		git ls-files -s file1 >actual &&
+		test_grep "^100755" actual
 	'
 
 	test_expect_success FILEMODE "verify executable bit on file ($strategy, $us)" '
@@ -65,7 +66,8 @@ do_both_modes () {
 		test_must_fail git merge -s $strategy b2 &&
 		git ls-files -u >actual &&
 		test_cmp expect actual &&
-		git ls-files -s file2 | grep ^100755
+		git ls-files -s file2 >actual &&
+		test_grep "^100755" actual
 	'
 
 	test_expect_success FILEMODE "verify executable bit on file ($strategy)" '
-- 
2.43.0

