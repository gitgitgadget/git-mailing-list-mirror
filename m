Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59F511C2326
	for <git@vger.kernel.org>; Fri, 16 Aug 2024 17:55:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723830915; cv=none; b=NS9Hb30k2ELa45mEb40gDH+Na1nsLgHcS7J24DR9fWluxLNc/cc2OWjdgHtFX5hEGPUm23kPdMqiOvOCVWKLiddmV+H7R0upF5lU6+GmAjQwFIYuFMhImiVaV/jSKJDMDZZnA/RjL5bDSbFf0ZtYszxZ1ScKrFS+/Y/neYUhuhg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723830915; c=relaxed/simple;
	bh=F6Ll+kebVEWNfVCewmYyA3w1aLfK5yHdCCiWyt+qaQ0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lVrP87VSFJ9KF3SZ9fP/tL33dwbSRxUsFBqdYeX8bATDXcsBPxyolDtOb4b/yACofKatgajCvmupEZXxCmvkaf0kt/0S+xmymWrriVjmjM/M17jqEww5S4pX+wYKh0a6pT4bBKLSH0MUZ6dOFCxGDpZYNFz6B3Zslh90Tvh+BeE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=L2D4gDlc; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L2D4gDlc"
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-7a18ba4143bso1724230a12.2
        for <git@vger.kernel.org>; Fri, 16 Aug 2024 10:55:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723830913; x=1724435713; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Djhsm1ZWS+CvJVfKqGt3b/MT7c/o2mK2WpsPEkOb1sg=;
        b=L2D4gDlcBrQETqquFMXuqQQDbgpa/0+Xlcc09FLXhR500ohjj/8wn52jyKeS5yFe88
         z+yT0bVmRJ1+ba46N9oBHUAYNoRJRZP3HJrAgJPw5+sY2H1xLnsVeGj2xymXjjQUj6b+
         SxKmR4MFJbi79/ZLDMRWSXoNwzrXfhxqU1XnsvdwOx2FV1Dm2r4ktA1kjkW9QMmGVbLZ
         1bOFrKekPc7XxhzGPCzyCNISwtsjcOZHcZHPf0DR7gL05eR1DQ2po/vEfHu4qbuOaO4m
         5ayL3hMQjypwSatTL1AfRbBt/jVt040dmDlS2TcvYuI0ZndgpsotYez+pIUsggNyFKDQ
         8JLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723830913; x=1724435713;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Djhsm1ZWS+CvJVfKqGt3b/MT7c/o2mK2WpsPEkOb1sg=;
        b=Gx6asauIU57AgAj4+QMrku9+Efx9sIvPUIctDi9ow6DiAX7W2g9Y1GLkwnpoZ9beIg
         d6ak6BQmegPhaOFXiXGZJWd5X6d0v8L2TOVGz4FByzPHiGwmLYNod/KOMzbLvca8BzR9
         IAeXIWNPHc5aj6SgiN71ONbNsMGpwilRHrHiaydRtrezsOeFN7eT+jhKGI9GCM3s9fnj
         dY8cSjVQV8FEXtzhT/DI2E4G+KV959NAs2bPaJslc3CoWrTFmZi/lkcqI/8h6kvYTw+T
         Xyg/cR2Z4JSX6Wcjwg1ppgur+L7PJfVhdqzOhfGTNEZnNua7exMUuRdtTCDN3JfCd6jI
         n8YQ==
X-Gm-Message-State: AOJu0YyJ07HYqpv6XusWh4U9oTLWSe5ElNopZEJFSempn8++GzW1PvLw
	yM4cESdLmtyjAugdyhPFcEYlg0iSvprgzBZp9H5Gi47X5O+F+JavOB9afA==
X-Google-Smtp-Source: AGHT+IGLke90s2xN2qKzkELNqPsqRTTc6uHaC68wQSMg1gurINqflHkqo/vJ685uMmaok5iR53WnkQ==
X-Received: by 2002:a05:6a20:9f89:b0:1c4:230b:5ec7 with SMTP id adf61e73a8af0-1c904f89275mr4908861637.15.1723830912649;
        Fri, 16 Aug 2024 10:55:12 -0700 (PDT)
Received: from Ubuntu.. ([117.99.60.209])
        by smtp.googlemail.com with ESMTPSA id d2e1a72fcca58-7127af1e907sm2985600b3a.173.2024.08.16.10.55.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Aug 2024 10:55:11 -0700 (PDT)
From: Chandra Pratap <chandrapratap3519@gmail.com>
To: git@vger.kernel.org
Cc: Chandra Pratap <chandrapratap3519@gmail.com>,
	Patrick Steinhardt <ps@pks.im>,
	Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v2 07/11] t-reftable-block: use xstrfmt() instead of xstrdup()
Date: Fri, 16 Aug 2024 22:55:30 +0530
Message-ID: <20240816175414.5169-8-chandrapratap3519@gmail.com>
X-Mailer: git-send-email 2.45.GIT
In-Reply-To: <20240816175414.5169-1-chandrapratap3519@gmail.com>
References: <20240814121122.4642-1-chandrapratap3519@gmail.com>
 <20240816175414.5169-1-chandrapratap3519@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use xstrfmt() to assign a formatted string to a ref record's
refname instead of xstrdup(). This helps save the overhead of
a local 'char' buffer as well as makes the test more compact.

Mentored-by: Patrick Steinhardt <ps@pks.im>
Mentored-by: Christian Couder <chriscool@tuxfamily.org>
Signed-off-by: Chandra Pratap <chandrapratap3519@gmail.com>
---
 t/unit-tests/t-reftable-block.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/t/unit-tests/t-reftable-block.c b/t/unit-tests/t-reftable-block.c
index ad3d128ea7..81484bc646 100644
--- a/t/unit-tests/t-reftable-block.c
+++ b/t/unit-tests/t-reftable-block.c
@@ -44,10 +44,7 @@ static void t_block_read_write(void)
 	check_int(ret, ==, REFTABLE_API_ERROR);
 
 	for (i = 0; i < N; i++) {
-		char name[100];
-		snprintf(name, sizeof(name), "branch%02"PRIuMAX, (uintmax_t)i);
-
-		rec.u.ref.refname = xstrdup(name);
+		rec.u.ref.refname = xstrfmt("branch%02"PRIuMAX, (uintmax_t)i);
 		rec.u.ref.value_type = REFTABLE_REF_VAL1;
 		memset(rec.u.ref.value.val1, i, GIT_SHA1_RAWSZ);
 
-- 
2.45.GIT

