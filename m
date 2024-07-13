Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3797613A25B
	for <git@vger.kernel.org>; Sat, 13 Jul 2024 13:45:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720878327; cv=none; b=LgGUGnhEqmEqk14ZPHFp3gMSb+1QbjgpADMOrD/8xyizOyoEc9fa2e7YK4bcUjl6oY/e4Jz6nQx6vWe2XGbECv+KNCwzOt2C+aTa4U4HoFiQIWda+BhoUFt1Mi42BeJbOoF2jPLl0xwDShmEyY1QXGU+SqM7fnL3TpiRKtP0x14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720878327; c=relaxed/simple;
	bh=mGKp73t1gDNv5XhEYpbWC9ylOVN74pdxUlMqwbrFvRs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KVzU+iSOxl2wMTM0dr8VV5aTnTl120MZ7PL8xmAzO8SrbXA8KpGmrmko228LnX+iMM6E7kQ2V0b9QTLsUyFzZT5X9lkXsmydE3id7kqUigQ21KPPj+51yGGVgQHVfDOTEfwwKcV2VimNBtStQKrw16lP4RlJIqqRSS0tJILdLFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MfGU+66W; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MfGU+66W"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4277a5ed48bso20910165e9.2
        for <git@vger.kernel.org>; Sat, 13 Jul 2024 06:45:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720878324; x=1721483124; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QEj4J1duXKauf+ZuSbER3cN37XrHK4JaDZdLoIf88LY=;
        b=MfGU+66WfsLZc3Q8vz9+mWJLCk077pGW0H4y8l4RG1q2Z2xySJppu3/3EkS1UBWNHN
         4/RTLOg8sZ/kQ2CcogBQA8ooaBn+Lu8BzCHAu7JmFJBNNo+jhF2yOmK4kalpRRYQnWrm
         4+YtWjwQUVhPIpzESpVhQg1l8j7WO/YH2mc9+Bnr6y7myFIwCg5pY6xvfmyNXUYuKsur
         WNl3/uSIiwEQASeVGT4VsC3of1r0M5fTiFBWg3i9C4wZDvWMSCxyOItiVfxbKCKSDPCa
         Yp8Q/lk6NjkvnQAb7juOtb+cpDJWXU4CH7i2VM/iOGnxtiIhd1VeLqNEJeWkcZ+IUmvS
         xKpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720878324; x=1721483124;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QEj4J1duXKauf+ZuSbER3cN37XrHK4JaDZdLoIf88LY=;
        b=fkx5WFhJGN/ZBGYT+Anapp5z5vRePu2rrixOH04vyMhFBe/hpylmyR4Q6i728W/Xc9
         NrIGrU12Z5xHhi85n7QcEoWOZzoWMu8db8+kbbKMMiXFGtXsBjQ1yE73zATDCHzOS7og
         YH1Q80uFyn9c4Yq2HfzJrOCBwO4YWxqblCixMieWt8ZXRwXKEj2X8IpBW9Tv3IuMwE+X
         wVBBVRS9GoMtW9jk5RDqv6KZTm2rufCIo8qcfOXkjh6EEDkK7KV3AVcoVEVALhiceemC
         Gr4GXNnHeHNbKmSWEGHCSDGUtWFuq9auvORd+0ZnXNEOReWTESsCFam3D0INh4FQREaU
         ZXMw==
X-Forwarded-Encrypted: i=1; AJvYcCV5vFwLQDrK/VbMkW0NyNrAGpLSTDI92bj43QCaluAP+K2LBAlc/Bzbn7W4s8u5PXj0sDMLgkX/IRA6dJqlKzINFEum
X-Gm-Message-State: AOJu0YwV8K74G9tJPio72NiKXuIVFuUtLYD9BolZ6SgpkdsG7EzomIrC
	pJacekwCol/YyK3QuDpO8GFeZ54wIv+dMuoz33X4PrK7ifh9Cc6yRFbrBNwK
X-Google-Smtp-Source: AGHT+IGhTj8fD0tUqpbWVKpXLHMpHAaTfvk8DSlizobxXavTQOIlMnBqJMbBIjrR5PUQB/RHK59s5g==
X-Received: by 2002:a5d:47ac:0:b0:367:9769:35a5 with SMTP id ffacd0b85a97d-367cea4606bmr12888552f8f.7.1720878324479;
        Sat, 13 Jul 2024 06:45:24 -0700 (PDT)
Received: from laptop.fritz.box ([2a02:2455:826e:4900:cb20:918b:a998:e5da])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3680dab3bd8sm1440325f8f.13.2024.07.13.06.45.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 13 Jul 2024 06:45:24 -0700 (PDT)
From: Karthik Nayak <karthik.188@gmail.com>
To: karthik.188@gmail.com
Cc: chriscool@tuxfamily.org,
	git@vger.kernel.org,
	jltobler@gmail.com,
	phillip.wood123@gmail.com
Subject: [PATCH v3 3/8] clang-format: ensure files end with newlines
Date: Sat, 13 Jul 2024 15:45:13 +0200
Message-ID: <20240713134518.773053-4-karthik.188@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240713134518.773053-1-karthik.188@gmail.com>
References: <20240711083043.1732288-1-karthik.188@gmail.com>
 <20240713134518.773053-1-karthik.188@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

All our source files end with a newline, let's formalize in
'.clang-format'.

Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
---
 .clang-format | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/.clang-format b/.clang-format
index 803b274dd5..4c9751a9db 100644
--- a/.clang-format
+++ b/.clang-format
@@ -106,6 +106,9 @@ IndentCaseLabels: false
 # #endif
 IndentPPDirectives: AfterHash
 
+# Insert a newline at end of file if missing
+InsertNewlineAtEOF: true
+
 # Don't indent a function definition or declaration if it is wrapped after the
 # type
 IndentWrappedFunctionNames: false
-- 
2.45.2

