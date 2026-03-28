Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB1F129AB1A
	for <git@vger.kernel.org>; Sat, 28 Mar 2026 20:03:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774728210; cv=none; b=P7VGmnPY0cMKBpTZp+JDmzH/xnH9mLvKGPklHDrmuzdxDVhc+ljbsOWWzOL3isuHxkqHI/KX75M41LY39uaU9xXubiZ78WUU28OSpwjnf4iIA0j+v/YbmmZBE5d9UmpgxOutQgyC/u8f0xzDY6UqFQWkCopmRcSDzBZjc3ZiO9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774728210; c=relaxed/simple;
	bh=reYn+JFnRmjvuXEUtJFBHTQT/l7OGzs7fosk/9tG9W8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=E3EBKIfSWz7NbtAWKvpO+gnPQdgkDxOCDtkHTIFXszLX8xa5ibgyGiTUtiHbBp7q1ijJ04dUetBPyOcas+B/GhnM8lvOHZe0tCq5uVWWkO11B6mtRnBgynCIZ/XrM/czYWYAdh7Bl/WurDW76EnFCygX8Lve4vub7+5C3xIZwYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ecGTBoAS; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ecGTBoAS"
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-82c20b9f989so1508072b3a.0
        for <git@vger.kernel.org>; Sat, 28 Mar 2026 13:03:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774728207; x=1775333007; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=v+1HRntHkz7oltI4fbg4X2CaZG9ALawPuDosb/5/oBg=;
        b=ecGTBoASfp/nxuLGP9mPvcRO1RiZYAyQhVgTWRj5GAUby+/B2Y1xIqPbsM4Z9Q+N+c
         uuJC2EG1/+BvsUWx3wH+fbOWJj7+QpyjAJshOQsg15n6dsJFg0yHbcEAe1YlnV+IFoh3
         L6barl3qIwO57bEtgBiFf6zT5vJJwolUshlQLz9USj++WsliDKyp3bljZ6co+TPHaqV4
         0P1iJYiznX1JPhhlrsQY3z6JH3lBWTmrybr29MdX5WBnzEHom3g+R7q5EkVyJPh38QGy
         xWVR7u4opiENMgKjgS3rOI/PepdsGeXtXgTc+NjbJCgvCQzqnfQGUtOmpR/05DqQakIQ
         kHOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774728207; x=1775333007;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=v+1HRntHkz7oltI4fbg4X2CaZG9ALawPuDosb/5/oBg=;
        b=a645jUnAiW7T0wa3HkULLmQ1+uOQ0c/Z6dLC9Ynv9fP9L2pgvIuPuF/zVRhSwINwHZ
         keJnjzATXOqwTo8YHsVUZ84D/MJUXlBQqMehucNd1/axpt1w7xj/4jNMGdxxraNbFB/x
         DxX2irRmJwL1mgp4Tj45KHeyDmuDB9wYRJzO64gmGTBPWn2o/aKl+rmLinzDq0hlcZA0
         8AYe/xPS2EoxR3TQ6B4snZI1iSFqJUWcMYpb1zddjcA2V5jQdP1OYOWIUI0YVV7/M6Up
         SN2OKqte7U5jYtvvHhwOCtltEwgmFTf/+dhXpKW+484+/Wqv1vky7uLjBjFJZps/Tv0V
         hvKQ==
X-Gm-Message-State: AOJu0YzGXFTYypUkfHuxGOojGILvjCbAPKGZD2PnhIZj9ShsDic9mQ9M
	h/iFgIy5yj3Vo3W9gALtob4XlBEEHxD7FrQEl0/To8K6HQM7gXbv4s67xy77oYfI
X-Gm-Gg: ATEYQzwtVfewe7idOPKlaVDJm6iJ1ZB8tR9a4ukkZ7f/g2KAdgIlDzYIhJlesUzd8tl
	ldIboa4O80X44ftr/3U399D8boRToLut6176IPy36Pbdh54RWKzEHVcaVLNjuVew1gstXDBNEOJ
	Znmw9J2lgdfTHctmOSjJGMs0v9WiT8ilOKpJJtoratfOJQ8vE58yGRs/86Cbg4K0ckK2L3EuuPn
	dkl5TWnqDdXcNHao/CnF7T2z7CA4jIKGFYmEChgZmdRH/4IMy3AeTXR6lTenMyMt/fMRYtGTt2m
	+FH+nEzmfrLCqIF5NrgbR2IyYd0YItzzBPTYidfQlSgoJ5tYTbc4RuhcdOCwmRLrDP7CIUGknAo
	J4TDO8F2MjvRrazb8RibUp8byFY1mBcrO5EXVFuA3uHb0t5/SB1kTDdzlmHdEe90fF/Hl+2t71B
	A+VKKMwZUAbGX9+tM1eoE3SOLHxCH4lceX/btvRJMdt6yPxw54NvAKP5FjY1M0OYguSDU7VjkZ3
	H4zkUTpVQ==
X-Received: by 2002:a05:6a20:1589:b0:38e:87b7:5f88 with SMTP id adf61e73a8af0-39c878b5adfmr7276897637.27.1774728206754;
        Sat, 28 Mar 2026 13:03:26 -0700 (PDT)
Received: from trieu2-huynh-trieuhpn-ubuntu24.bee-live.svc.cluster.local ([27.122.242.65])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c76917bb31asm2359786a12.23.2026.03.28.13.03.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Mar 2026 13:03:26 -0700 (PDT)
From: Trieu Huynh <vikingtc4@gmail.com>
To: git@vger.kernel.org
Cc: Trieu Huynh <vikingtc4@gmail.com>
Subject: [GSoC PATCH 13/16] t3412: avoid suppressing git's exit code
Date: Sun, 29 Mar 2026 05:02:52 +0900
Message-ID: <20260328200255.247759-14-vikingtc4@gmail.com>
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

Update t3412-rebase-root.sh to redirect git-cmds output to a
temporary file instead of piping it directly to not hide the
exit code of git commands behind pipes, as a crash in git
might go unnoticed.

Signed-off-by: Trieu Huynh <vikingtc4@gmail.com>
---
 t/t3412-rebase-root.sh | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/t/t3412-rebase-root.sh b/t/t3412-rebase-root.sh
index 58371d8a54..f56163a73e 100755
--- a/t/t3412-rebase-root.sh
+++ b/t/t3412-rebase-root.sh
@@ -171,7 +171,8 @@ test_expect_success 'set up a conflict' '
 test_expect_success 'rebase --root with conflict (first part)' '
 	git checkout -b conflict1 other &&
 	test_must_fail git rebase --root --onto main &&
-	git ls-files -u | grep "B$"
+	git ls-files -u >actual &&
+	test_grep "B$" actual
 '
 
 test_expect_success 'fix the conflict' '
@@ -198,7 +199,8 @@ test_expect_success 'rebase --root with conflict (second part)' '
 test_expect_success 'rebase -i --root with conflict (first part)' '
 	git checkout -b conflict2 other &&
 	test_must_fail git rebase -i --root --onto main &&
-	git ls-files -u | grep "B$"
+	git ls-files -u >actual &&
+	test_grep "B$" actual
 '
 
 test_expect_success 'fix the conflict' '
-- 
2.43.0

