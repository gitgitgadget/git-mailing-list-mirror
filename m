Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0306616D9DD
	for <git@vger.kernel.org>; Mon,  5 Aug 2024 23:59:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722902388; cv=none; b=u8Gu4kixrT5N916ccz0AP8AvS4IZyiLD1LaIyXTPadogCpz+sfrLqh0SXH3jSANKpv+Ad8qoil50aBuQK63p5qNulZ4n/x7jxyjsWDKirSvDDZUydrrt5z794vdqRr1ndLMLJZaHyMybJfN6lg//OK9zGSRoM1zcCnYHkC0ZkSY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722902388; c=relaxed/simple;
	bh=TVH9tsf8U9VGeArgAWptqZEG3yBI/ZSs5XJiJi7AZQI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=M2CkWeR+PfyjPK5/bRDimR8S7f/FJPOVZLgmrWfjNDzGzcO7JTrfWqx45Q6AWqvG8grHHiUN2ST2yH03n6/tkB+MESZ/XdPHTN+FoRQSR2cMJkC4kATWAfUJEMbYNjSrQsx1C9Ms3SKmMHNJxG+mnBvElu0CFzdycCgBrxwZxoU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dCAcwH1j; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dCAcwH1j"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-42803bbf842so691445e9.1
        for <git@vger.kernel.org>; Mon, 05 Aug 2024 16:59:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722902385; x=1723507185; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IRBPW2Bt/qQDLaxwdCcA7mM7s02N0BchEb9o1xhNhWQ=;
        b=dCAcwH1jr77kPJ7nM5P2b7dkORvRHjN4xDo7QhPCq16yJMtJc/o6A7CJq/DieS8qnk
         LEsceN+BMWELl184iMbeCgNQnb6yEEAbCWdbWKK6mU2ee1Zs5/dfhZ3DXp+9W+LNYvas
         CZF1QRQGkphu+0EOLqPni4oEqZc/iYbk+5hRONB1EKRbF9AWFm3kWQUMZQYoLg05+jPq
         iZ40Mtp8vOUe7RjXJswO8H/6JWVih5XW67C+X3/3wQjipSQjh9MhIyc4LbKODL3mMi0m
         +I47Y2f6ZysFCQrIPzA7AFW10Ihzj1cEotUNML0eFcLEBkpfcXK1LaeUr9Yeg4VcUxZU
         qPrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722902385; x=1723507185;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IRBPW2Bt/qQDLaxwdCcA7mM7s02N0BchEb9o1xhNhWQ=;
        b=jaaesPhsqMTPUPaOjq/2Yc5mEzM9dw18SC0nTVKAM1dZNikJyvnnnZg1mbNpU8maUa
         juSeHM8dLBqvl50VFc7OLMehmRZjt9c0X49Eh9tHmmDhBF4ki19NnTkxlZw/YFcKW3WO
         xVIY8cFspUSbzzAnwxrNxuGGGX2C8KF+vL2rZ5dEjcyuWG3Gzg7gXG+gsTi4ZnE4G1w4
         DsA7vP/ofD0MMkLhRx6gWfNpLlQBjrTSI39Nr7x26R5VFyu0HeInZ0yyIo4TiZMyz8jM
         8u3eO3YxVV+6URrvzuoCaX2IsN8Uc73LdHkPDm/5cscWwi72MT/IKYCpYLAG7byFFNmc
         dy5w==
X-Gm-Message-State: AOJu0YzhEY0JzqDkDbTNs7hQeeRvgbf8lvcNKHFlAlV5zoNn5uhCypn3
	sZWkaGlvHJiapkcNWqZa1t1JGxbRpy2l1L0oaMuPvx+kUdOzx/7VWXGuoa7g
X-Google-Smtp-Source: AGHT+IFZl3sPyUU1RgNpdqhQDHZyNrjmgr6lUP6eVsetCZu1+Z9kwfrEI9Xdxv9Hu3un3YPpiddKPA==
X-Received: by 2002:a05:600c:3504:b0:427:f196:c549 with SMTP id 5b1f17b1804b1-428e6b7e954mr125156225e9.23.1722902385013;
        Mon, 05 Aug 2024 16:59:45 -0700 (PDT)
Received: from abdobngad.. ([197.40.47.44])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-36bbd074583sm11219065f8f.108.2024.08.05.16.59.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Aug 2024 16:59:44 -0700 (PDT)
From: AbdAlRahman Gad <abdobngad@gmail.com>
To: git@vger.kernel.org
Cc: AbdAlRahman Gad <abdobngad@gmail.com>
Subject: [PATCH v4 2/8] [Newcomer] t7004: Do not lose exit status to pipe
Date: Tue,  6 Aug 2024 02:59:11 +0300
Message-ID: <20240805235917.190699-3-abdobngad@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240805235917.190699-1-abdobngad@gmail.com>
References: <20240805235917.190699-1-abdobngad@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Split "test-tool ... | sed" pipeline into two commands to avoid losing
exit status from test-tool.

Signed-off-by: AbdAlRahman Gad <abdobngad@gmail.com>
---
 t/t7004-tag.sh | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/t/t7004-tag.sh b/t/t7004-tag.sh
index 3100a4c219..1e31f39646 100755
--- a/t/t7004-tag.sh
+++ b/t/t7004-tag.sh
@@ -97,7 +97,8 @@ test_expect_success 'creating a tag with --create-reflog should create reflog' '
 	test_when_finished "git tag -d tag_with_reflog1" &&
 	git tag --create-reflog tag_with_reflog1 &&
 	git reflog exists refs/tags/tag_with_reflog1 &&
-	test-tool ref-store main for-each-reflog-ent refs/tags/tag_with_reflog1 | sed -e "s/^.*	//" >actual &&
+	test-tool ref-store main for-each-reflog-ent refs/tags/tag_with_reflog1 >actual.body &&
+	sed -e "s/^.*	//" actual.body >actual &&
 	test_cmp expected actual
 '
 
@@ -108,7 +109,8 @@ test_expect_success 'annotated tag with --create-reflog has correct message' '
 	test_when_finished "git tag -d tag_with_reflog2" &&
 	git tag -m "annotated tag" --create-reflog tag_with_reflog2 &&
 	git reflog exists refs/tags/tag_with_reflog2 &&
-	test-tool ref-store main for-each-reflog-ent refs/tags/tag_with_reflog2 | sed -e "s/^.*	//" >actual &&
+	test-tool ref-store main for-each-reflog-ent refs/tags/tag_with_reflog2 >actual.body &&
+	sed -e "s/^.*	//" actual.body >actual &&
 	test_cmp expected actual
 '
 
-- 
2.43.0

