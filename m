Received: from mail-ot1-f53.google.com (mail-ot1-f53.google.com [209.85.210.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12A9F1F946
	for <git@vger.kernel.org>; Fri, 12 Jul 2024 05:51:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720763493; cv=none; b=kAueshzO1fJrAD1YwuMwu6ke2SfLGwomki8Y/6xDCeH0FcHz0hBvMSkD1YjF2x0jalZdspW01WvOdKuIhLUbTPogDB6thSlbuO2xkEsQcUX9EkwEtMSBoUNKcxJzrRMp8uu74K3c/Xy3rpZRGAywBJTD9Sh6mk1fZ0JRmIqY/eQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720763493; c=relaxed/simple;
	bh=30AJPbiIwqfNc7C6hDVXdA/qfAfUj/zihzMob8vv6Xs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=F8yyqGBXMBuCSplJwxfN7p/O/nExuwgkUUFuh6pUwcXtU9pmcHYFYt2ez4azH152sM/+b7aAA44+Cg+LfXh0EfrGUnj68HDp9cLQmcI+KgSCt8mDbsxvT+Bt0h+UuIfda+zxiSnBhWeatZSaRU3rasA+ucQ3OdF4JYcYM7nVCps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Lw2Dy5f7; arc=none smtp.client-ip=209.85.210.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Lw2Dy5f7"
Received: by mail-ot1-f53.google.com with SMTP id 46e09a7af769-708b273b437so676176a34.0
        for <git@vger.kernel.org>; Thu, 11 Jul 2024 22:51:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720763490; x=1721368290; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GQneeaCpYC1UQtQb8/kuvrITYshgjp5Gi0xSFoVZduc=;
        b=Lw2Dy5f7qujpZjcF+WzlwF0jLNWIPQaQIRKW/nRWtId60ndvSCGQH2R1Cj8Jzkm2lG
         nTFWZqTrbODp7RRTPfd6WIh0iyWQVw0xYUnlqgdzdb4zG2qR6Rqxyw3Hd9Q9M2ot9J+S
         mZUHma8m4TbwtkvyI6iYRz1guTeenKGUUjXIuLmId4J5UG5Cli7LV3UC3bah+K8TUAWy
         TGiLxFO0qtrBmpTYYvDzoye1cBgSh0wWbH9hmndgBHdyVc6ZF1+wRV5ePYaC2Ft0JsCp
         Nz3+IDALJHaDdHGYuD23x4z9Ik/wesCBt+IAPcFUnRucxx1jCOQ2YEIWybEkcW7nwznM
         lHiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720763490; x=1721368290;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GQneeaCpYC1UQtQb8/kuvrITYshgjp5Gi0xSFoVZduc=;
        b=eXxyVi7ckbCtqMFxD2otevZDkMcxKkIhwLhaJvbTuaaGvxRrSCSBTtLokmfRtRy5pT
         sf0Ji8H3Bwbmh0apx3WKXS/CgQpHXHXN5yASVpbGEQ3G/kZyxjDlTd+MMdxnkOMuq7B5
         JGO8FjuL16Ko9aNQQWVen77u/kUpxnREzNA0YiJc6Rnc9CpmqPvcI/iH3MioYtKRxbrx
         1KPw8bma5jT8+2depIAPgbTIa3hPrINsPKW5tIKhR1tC3YIAg7F5e84OepA2W4+utGds
         vBr7EdejtAUGHRN/kSCyGhdOS264B2NUuWBQdeD2/mqjQQxIYcGBIV5QGtRfBUCJSAtZ
         GjAg==
X-Gm-Message-State: AOJu0YwUsfKUWCbxkW3xb1wCkatZOlbm/U7vl7HUavmA0E428UZled9Y
	Th8C4zcdmp/u6QOmTZnlC4UJdrtSLYPyQgF0jY1noho6FhZNjUeL4JDrFQ==
X-Google-Smtp-Source: AGHT+IFVJ36EPGwOYiUcJo9C5s0NG5TwV65tRN4duHCBjIrGSoKRBSqDs93BxiKxQH14XtlJYOe88w==
X-Received: by 2002:a05:6830:1e84:b0:703:78b3:841 with SMTP id 46e09a7af769-70378b309f0mr10347858a34.13.1720763490362;
        Thu, 11 Jul 2024 22:51:30 -0700 (PDT)
Received: from Ubuntu.. ([117.96.148.106])
        by smtp.googlemail.com with ESMTPSA id d2e1a72fcca58-70b4397f475sm6604651b3a.150.2024.07.11.22.51.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jul 2024 22:51:29 -0700 (PDT)
From: Chandra Pratap <chandrapratap3519@gmail.com>
To: git@vger.kernel.org
Cc: karthik.188@gmail.com,
	chriscool@tuxfamily.org
Subject: [PATCH v4 6/7] t-reftable-merged: use reftable_ref_record_equal to compare ref records
Date: Fri, 12 Jul 2024 11:09:02 +0530
Message-ID: <20240712055041.6476-7-chandrapratap3519@gmail.com>
X-Mailer: git-send-email 2.45.GIT
In-Reply-To: <20240712055041.6476-1-chandrapratap3519@gmail.com>
References: <20240711040854.4602-1-chandrapratap3519@gmail.com>
 <20240712055041.6476-1-chandrapratap3519@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In the test t_merged_single_record() defined in t-reftable-merged.c,
the 'input' and 'expected' ref records are checked for equality
by comparing their update indices. It is very much possible for
two different ref records to have the same update indices. Use
reftable_ref_record_equal() instead for a stronger check.

Mentored-by: Patrick Steinhardt <ps@pks.im>
Mentored-by: Christian Couder <chriscool@tuxfamily.org>
Signed-off-by: Chandra Pratap <chandrapratap3519@gmail.com>
---
 t/unit-tests/t-reftable-merged.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/unit-tests/t-reftable-merged.c b/t/unit-tests/t-reftable-merged.c
index 065b359200..9f9275f871 100644
--- a/t/unit-tests/t-reftable-merged.c
+++ b/t/unit-tests/t-reftable-merged.c
@@ -158,7 +158,7 @@ static void t_merged_single_record(void)
 
 	err = reftable_iterator_next_ref(&it, &ref);
 	check(!err);
-	check_int(ref.update_index, ==, 2);
+	check(reftable_ref_record_equal(&r2[0], &ref, GIT_SHA1_RAWSZ));
 	reftable_ref_record_release(&ref);
 	reftable_iterator_destroy(&it);
 	readers_destroy(readers, 3);
-- 
2.45.GIT

