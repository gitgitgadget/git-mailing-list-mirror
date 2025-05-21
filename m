Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7D913C38
	for <git@vger.kernel.org>; Wed, 21 May 2025 08:35:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747816557; cv=none; b=GUyFN9AtItY0ajKq7qgjPHJiJ7M96S+ufxNgdBCAcncfRdu99cXjtUeBnF1v+VN8UCm6C5yfg04/KeO4O2b/h+0+49w28UWVC0hcZU9OrCpDu6Eyx/vafSs1UBUCkul35918Z2Y6E9jMQsZgO9QEnjGwgG3KmkPjJNldomTtheo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747816557; c=relaxed/simple;
	bh=va0Zz/8vddD+GoZUZX8Fxx4h/xvWcc3QRyf2FO/K0XA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=J5ZsJGH+tcA15GTssog07p/57L0mBE9dyb8HYeXxgcTRGYpcGENo6Ac/cm1TFA1Ze0GB1wDMOn3cKKa6m3QqtwbgjGMkGXhy9i3JbHikSN1Qs7Vd0HtQxF8jvR5N0pTFVDT63XydCI5qvpmJtxFRk1xOZ4duVNx7Xg1LH5eqqIM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=lIWfKKVH; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="lIWfKKVH"
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-879d2e419b9so5625047a12.2
        for <git@vger.kernel.org>; Wed, 21 May 2025 01:35:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1747816553; x=1748421353; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qDPggQa81AjzTlUsmRN7Lo/e+MZSEpOnCHHiPb1sRP4=;
        b=lIWfKKVHWOdCY90kdTYCKGADpOGCFoP+IGXk9jc0WjgrhgvW0Ig5KA5BcZZ8nmv/Gw
         sjbIcIcTToYn0mBLT0AibJKESBWiYng5De6yyO/w9dQQGaZpqMOGWflQikn9kNFlqXT3
         XubjmKQSbfxoBjwch1V4VIQ3Kjf3vdL4FP61T4yBY9CzHqQk+TWZ8efCBxlkDnXb9BNC
         Kl5REH2JKeMHLC9BnyWr5K8X2dFJVrxuqt20D2Cy30jo/ihMG+xPuJxcmHojGMlAeE6U
         tiB80qSiNXmZ52rdNXparonH45BE+3O3p2LstixvFRCma/8QsfLXId0CjFTu/cowwhyW
         Cyvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747816553; x=1748421353;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qDPggQa81AjzTlUsmRN7Lo/e+MZSEpOnCHHiPb1sRP4=;
        b=XZ6ZTDDYKeZ+iEhZfrb9KfD5uIEt5p52/WSm/blevA/WfT/JdcmZNHhG+g5tRI6aBN
         x3p0x92J+Q5DvIOhb0Z4pyGn4/1fO0FJTrAMbBu1Xy4qt97ZTMptfTB8g0XUFSCNLYwf
         Y6NYOUmQ1GvVN29IZ2u7IR/W0db+7fpiUBhmmUxsbKSY15GbtL1wMxT1iAovTcrGJ6H4
         yL7UtNyRlyiP9G5a8RtkJ4nld2ceVaZ5rlfcOlAIkz4/M5qOuh0HSbJuvhhu2/4O8Kig
         0JZ8985E5ZLBRi1w2kcypnK6QAerO2auRlOvAVm1VdsunTEOteQki4MkU/lHVhr2/SX1
         wAJg==
X-Gm-Message-State: AOJu0YwsAQge8iZAagGSvDI1t6UdHMd1Cm/4D1LC5NSnPgiJkjnkRfI4
	f5kQ5EslwDb5UnMPo27wah7tY6KeKT4pySO+O+6IShsraXQcR3eX7ijSBDLVHbXH/NhA9NVGIWE
	p6/r7
X-Gm-Gg: ASbGnctNdzD5HPtBN5soHO7xwCeKbWhKUlWaE7wMW6w7OisFI/kh9Jqzdjo0A84J9mS
	0HBFxp29SFbyokC4h+Dy36FT73m87irPZ3+ax0rH+kHHz5JM8DJePIYJgVvmOHeTQ0e6Qprps/S
	/Cs5j5KTn2Rx5poQfaVaHrgAxFeJI5v6X0SeKrZ7SZk5V1lL1+ul9wErugtEAWwQGDv6c45e5ya
	EAeuftkH11vsVfdpCfaO/stKRB+XlfJu7iccNXLnJkZUkzcj0q0NhiAjG7VQ/lHc3kmMxJEglbe
	zxN1TlgQiYbWKk+1T1rjRJcdKe4IeDOLja7Nv/ssfqPeza92QLjy8p7gMVURl1rU90H0lYHJtEI
	l9BND2YH4
X-Google-Smtp-Source: AGHT+IH7RDhpfvOeDhNDWXkfMgc8b76Bf6dVMk3CX6r2BeRI689RWGhtmsH9wA6yv2wrH8fnBXLxhA==
X-Received: by 2002:a17:903:1988:b0:22e:6cc6:cf77 with SMTP id d9443c01a7336-231d45d938cmr298744595ad.53.1747816553168;
        Wed, 21 May 2025 01:35:53 -0700 (PDT)
Received: from localhost.localdomain ([63.216.146.178])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-231f04e75bdsm78308495ad.216.2025.05.21.01.35.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 May 2025 01:35:52 -0700 (PDT)
From: Han Young <hanyang.tony@bytedance.com>
To: git@vger.kernel.org
Cc: Han Young <hanyang.tony@bytedance.com>
Subject: [PATCH 1/2] read-cache: report lock error when refreshing index
Date: Wed, 21 May 2025 16:35:20 +0800
Message-ID: <20250521083521.6552-2-hanyang.tony@bytedance.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250521083521.6552-1-hanyang.tony@bytedance.com>
References: <20250521083521.6552-1-hanyang.tony@bytedance.com>
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
 read-cache.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/read-cache.c b/read-cache.c
index 73f83a7e7a..874f87d040 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -1485,7 +1485,7 @@ int repo_refresh_and_write_index(struct repository *repo,
 	struct lock_file lock_file = LOCK_INIT;
 	int fd, ret = 0;
 
-	fd = repo_hold_locked_index(repo, &lock_file, 0);
+	fd = repo_hold_locked_index(repo, &lock_file, gentle ? 0 : LOCK_REPORT_ON_ERROR);
 	if (!gentle && fd < 0)
 		return -1;
 	if (refresh_index(repo->index, refresh_flags, pathspec, seen, header_msg))
-- 
2.48.1

