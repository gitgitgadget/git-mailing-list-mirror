Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B374B326945
	for <git@vger.kernel.org>; Mon, 16 Mar 2026 17:25:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773681909; cv=none; b=GJI+XcI2U9WtEP6hBB2oF5P5DUkQwVnxGXIHYVUL1tVVd3WfRvm6+qRin1SLg7go1EQpNpaKQKkNdxNFVQNuizY7WjNxETNUrMm95dqW6pgW5XcRaLsWlzx90pHzcAa7DQ9/cpNkbDozDtCOVZMPBMzm1QevvxPa45H97cphV24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773681909; c=relaxed/simple;
	bh=lmP2KdCd5QkaLtwdIdDmkhOashWzj0RxkH0W0aYg5V0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oZan4A37pSuxpjKsqHZZ5NsCcrT+u1Nktm8VBGoGDqUTgwCoWWPunSeG+TtLJ9tjIIZTzn/wNj8YC00XYPYvuyz0Wi6Bs52HteGCi4CLxyMhljRj9TE3zubPJ7LSt8CNNtHn3Wb8ZSU3BoTWCm6z0uywdYyChr8okbdGc5Y1eVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MKcDAowh; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MKcDAowh"
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-3591cc98871so2173158a91.3
        for <git@vger.kernel.org>; Mon, 16 Mar 2026 10:25:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773681908; x=1774286708; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=y+UQ+hSmiep/YKQQFjTvNrP/V4HkDhSvpdpzLLRh6Kc=;
        b=MKcDAowhQBBrD5/r7BqEV/KJRpA1q/SIF717QQDvtIZRx5BddUWKu/25WLjar0ClWU
         oJwEcdsFrhJYbcoFGFrZDCfU3NwizKsshdDjb3caUiz8m/rroVBGJDRE//WPdo933o8N
         aoYUKnYAdamZMEZ//jG48jntlcYg1Es8ekveC5+k1+hvFl+os/KVkvcy25kjbiEUnI44
         a1DzQF/HcZgean6MLmJzjw+TO6YQx801RBAwLNuVrqcmkmJeii7RUQE0hImHaxWqqHUi
         MtykfF6upvzHXNwpC0Cxg7lrHHAASeuo/9PhlkNjtlxXkI3D4CxFjGA91KsCqRmH1IXr
         jyiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773681908; x=1774286708;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=y+UQ+hSmiep/YKQQFjTvNrP/V4HkDhSvpdpzLLRh6Kc=;
        b=k6D11Jid4Wa2X8RkVJVqzjAfQ2xYmHH4wFVVI7pd953M+26StLOtemW43xscZm5M1K
         vtyyU5xJnFPP4T8dgfl7hWvjZdoonkUyn6g51Tec+cM11WSU60mkVGDa/s8okdf2S8cZ
         aFDtYPIN4Ks162waRqGqgJOSMav+ZDMKi6nsoNUsA3r43b7o+8ckgouv8oGbDi/LYo1u
         FgrJSZONv5sx+A95Qrwn2qMqcEz+V27gAbP6pMygSSokU3Od9DtpQIyaBodMuTEx3jtr
         m9qkPrKvYXNxjJdZuH1t+GtiJuYUZHlxLk++FvS+pDyxTe5+zXKDMvNDYlqUEljaSxDC
         RDHQ==
X-Gm-Message-State: AOJu0Yyi/+lIbkXAuK069XpNonF1BR8v9kIXpBftzTDxe8r9xcvJaCIS
	aS5Uv0voeCwlxpClUfT+a3ZZ/8vyV7y7gHmk6PEBa19i6TQbyCAwcF0QEAqixg==
X-Gm-Gg: ATEYQzztBEBBYi8LqSfTxinM92FAzVVgdOHScJ7/B4yS2JJOVO4aH0GT8wQWNTpiOH0
	uku2iZnRhj77lWQW1tinjjoMBBq6f1M5ZBnYfjHVL2O0Q4DtkfkmohT6tcTed2S8Sw+2MPmb78M
	BjI9b38qWTM9SuXr7seZ4FoONotBw91p5TXHsTJhhr4r1UnpacuUyZSTAIHpP7Rke2E7sA9fEFY
	QVAVhEQQyDzIuc/Q+9+CyxX0DWRwNsUGvgC6zvCaezHy1utrq+6UZ/u/3la5VP/o9fdnJbnHcmF
	lG0fU9iPKYDoDjjCVOLdVzn0bK08aSembmJy1qPzMwuBxwkcQUw5C0DQ0nNhTvqsgqtnW6jqZZ4
	5SimxPMMqI0QUQxCoUr2GWsOOeyyf8qC/aPXzUWlYnnzHGyRaYEUFBKKk07J6pOu+vHfs11xHfs
	MpGgi9h/f0LY/qc214cw+ykUK4J/HVC9dIMsAWHZ0/lWi6rgbcEEcSyO3qE6m/
X-Received: by 2002:a17:90b:5590:b0:35b:9cd5:232e with SMTP id 98e67ed59e1d1-35b9cd52712mr4691382a91.29.1773681907365;
        Mon, 16 Mar 2026 10:25:07 -0700 (PDT)
Received: from localhost.localdomain ([115.244.141.202])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35b9dc0187dsm1921621a91.4.2026.03.16.10.25.05
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 16 Mar 2026 10:25:06 -0700 (PDT)
From: PRASHANT S BISHT <prashantjee2025@gmail.com>
To: git@vger.kernel.org
Cc: gitster@pobox.com,
	PRASHANT S BISHT <prashantjee2025@gmail.com>
Subject: [PATCH v2] t4200: convert test -[df] checks to test_path_* helpers
Date: Mon, 16 Mar 2026 22:54:57 +0530
Message-ID: <20260316172457.38242-1-prashantjee2025@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260309173635.29683-1-prashantjee2025@gmail.com>
References: <20260309173635.29683-1-prashantjee2025@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replace old-style path existence checks in t4200-rerere.sh with
the appropriate test_path_* helper functions. These helpers provide
clearer diagnostic messages on failure than the raw shell test
builtin.

Signed-off-by: Prashant S Bisht <prashantjee2025@gmail.com>
---
 t/t4200-rerere.sh | 26 +++++++++++++-------------
 1 file changed, 13 insertions(+), 13 deletions(-)

diff --git a/t/t4200-rerere.sh b/t/t4200-rerere.sh
index 204325f4d5..1717f407c8 100755
--- a/t/t4200-rerere.sh
+++ b/t/t4200-rerere.sh
@@ -72,7 +72,7 @@ test_expect_success 'nothing recorded without rerere' '
 	rm -rf .git/rr-cache &&
 	git config rerere.enabled false &&
 	test_must_fail git merge first &&
-	! test -d .git/rr-cache
+	test_path_is_missing .git/rr-cache
 '
 
 test_expect_success 'activate rerere, old style (conflicting merge)' '
@@ -84,8 +84,8 @@ test_expect_success 'activate rerere, old style (conflicting merge)' '
 	sha1=$(sed "s/	.*//" .git/MERGE_RR) &&
 	rr=.git/rr-cache/$sha1 &&
 	grep "^=======\$" $rr/preimage &&
-	! test -f $rr/postimage &&
-	! test -f $rr/thisimage
+	test_path_is_missing $rr/postimage &&
+	test_path_is_missing $rr/thisimage
 '
 
 test_expect_success 'rerere.enabled works, too' '
@@ -110,8 +110,8 @@ test_expect_success 'set up rr-cache' '
 
 test_expect_success 'rr-cache looks sane' '
 	# no postimage or thisimage yet
-	! test -f $rr/postimage &&
-	! test -f $rr/thisimage &&
+	test_path_is_missing $rr/postimage &&
+	test_path_is_missing $rr/thisimage &&
 
 	# preimage has right number of lines
 	cnt=$(sed -ne "/^<<<<<<</,/^>>>>>>>/p" $rr/preimage | wc -l) &&
@@ -167,7 +167,7 @@ test_expect_success 'first postimage wins' '
 	git show first:a1 | sed "s/To die: t/To die! T/" >expect &&
 
 	git commit -q -a -m "prefer first over second" &&
-	test -f $rr/postimage &&
+	test_path_is_file $rr/postimage &&
 
 	oldmtimepost=$(test-tool chmtime --get -60 $rr/postimage) &&
 
@@ -190,14 +190,14 @@ test_expect_success 'rerere clear' '
 	mv $rr/postimage .git/post-saved &&
 	echo "$sha1	a1" | tr "\012" "\000" >.git/MERGE_RR &&
 	git rerere clear &&
-	! test -d $rr
+	test_path_is_missing $rr
 '
 
 test_expect_success 'leftover directory' '
 	git reset --hard &&
 	mkdir -p $rr &&
 	test_must_fail git merge first &&
-	test -f $rr/preimage
+	test_path_is_file $rr/preimage
 '
 
 test_expect_success 'missing preimage' '
@@ -205,7 +205,7 @@ test_expect_success 'missing preimage' '
 	mkdir -p $rr &&
 	cp .git/post-saved $rr/postimage &&
 	test_must_fail git merge first &&
-	test -f $rr/preimage
+	test_path_is_file $rr/preimage
 '
 
 test_expect_success 'set up for garbage collection tests' '
@@ -230,16 +230,16 @@ test_expect_success 'set up for garbage collection tests' '
 
 test_expect_success 'gc preserves young or recently used records' '
 	git rerere gc &&
-	test -f $rr/preimage &&
-	test -f $rr2/preimage
+	test_path_is_file $rr/preimage &&
+	test_path_is_file $rr2/preimage
 '
 
 test_expect_success 'old records rest in peace' '
 	test-tool chmtime =$just_over_60_days_ago $rr/postimage &&
 	test-tool chmtime =$just_over_15_days_ago $rr2/preimage &&
 	git rerere gc &&
-	! test -f $rr/preimage &&
-	! test -f $rr2/preimage
+	test_path_is_missing $rr/preimage &&
+	test_path_is_missing $rr2/preimage
 '
 
 rerere_gc_custom_expiry_test () {
-- 
2.50.1 (Apple Git-155)

