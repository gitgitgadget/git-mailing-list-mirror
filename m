Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D849B6F067
	for <git@vger.kernel.org>; Mon,  8 Jul 2024 09:23:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720430616; cv=none; b=Ttx6W9ZsLWIdfqTFM9S/uigWC7vHdveToZeHLEvIiOutlX9cvJFt+NN7MZrlvUgVq/bQ/63Qorc31v46SgRGXJb+SQ4Re8k+rskci1ImtsoOTXt0IggpgvH2kGr76l0mJg8+7px8qxXbkKMvl7V9FFXO0uP0kDJZDP/eBC1s8p4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720430616; c=relaxed/simple;
	bh=ShaXCRJFUbB+ItEYBkd5/a90Y/kuoPbJFa+gDF5CtXw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Nhb9Jxb0iYYXrZndWlNOaAyswhXEWzE6lyL8h5R8nCnfZXxauxeI/X6HQ7G9cT/HMOwI2j6NKIpkRPrrf+ksHdoFFVm+HCzDDOhWEA+lOLCWY7Rq7yvr7csOkhLAo4/x0xrjrOBiafzYI/gy3/8mg0i8ZLxC1JjOd9YGwfaUXAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T4uzu7mk; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T4uzu7mk"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4266bb98b4aso4066885e9.3
        for <git@vger.kernel.org>; Mon, 08 Jul 2024 02:23:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720430613; x=1721035413; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cjtC9NY8+SlWOLskgKymhAmQ7oMn5OK4giKmRPuFLoM=;
        b=T4uzu7mk9yiUnvqT3sGgo3dcMNgM1ZqBrq1jFgMkFMlFo/Pf1zgkiILSlpQ0riSNxV
         5I1QLL9sVdZHXKYvMzu6aTx2TXZn6jG+/OVPfHDa8B20cVMCFdVyN5PZPyDHdWdAZMBJ
         IG7k5946oiyDfKL/yOVe2ulryFAEUiz9xR7wE8D7FLMOtBL3s2DB5Dx2PRATScJMqp6I
         LnqMALT7+sk+V227FK4sBD8QzdDz5UZ6GteLEmi1NGJIw0yXOgD3MGqbOZtTObSXeXqg
         qGyW/QfZnFCmsqcj6Vw1/tH/iGujGAB+sUKkkZgOfSPh72kl4HEVKZbMv8MQ9oITsM8P
         Zkig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720430613; x=1721035413;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cjtC9NY8+SlWOLskgKymhAmQ7oMn5OK4giKmRPuFLoM=;
        b=l6vuKenSK1E3mltGwgBblVMQZTnYvQp+cz26UCpWlAMBxT6CmsE/oN9ZzzbCZ517Az
         5LG9dPa1uBfmxn8lF1R2ff5E+/nQLK1lBRWEAWbJKg6Fte/qMbXmGcRLzyTo0C/MPNBX
         x06N4jIG0GK1ReeaGrbTP7lFvuLDiNfdvLtEw5w9PIq93dLvBv66UMGQ4aFnRqjfLADb
         IKSzDrH2tApkK8uaRhmnCTxdkq7NWz8HBUJMz+bNjQrlz2u/UOx4MPhIhuaEawNTFhub
         hUjzx6XKEEH1eZlnw8+3B9r+NeznVAqOYcCzTicFxvLPTqyaEd+BX67iEQ8w//8QW0VF
         nKng==
X-Gm-Message-State: AOJu0Ywl/Be0qr3yFYE6mKuxB3lWjFm8tYOaS/gpe0aTb0iPLu8uBJOF
	m9s4ZoE3nmYiLDC3emS8vDIID3F9J8c00xbKBa9Kn4oqItdemzbs
X-Google-Smtp-Source: AGHT+IEajYs8JZWT/1XxNu0ZP9xvKIkg4eCbnR1fAlGCKxOowsWu3tqGXyAwJc6Eadd98rFPIvIpPw==
X-Received: by 2002:a05:600c:424a:b0:426:5b76:13bd with SMTP id 5b1f17b1804b1-4265b7614b4mr64623355e9.38.1720430613059;
        Mon, 08 Jul 2024 02:23:33 -0700 (PDT)
Received: from laptop.fritz.box ([2a02:2455:826e:4900:1d0d:3d35:3ae6:ef05])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4264a1d5116sm158259935e9.10.2024.07.08.02.23.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jul 2024 02:23:32 -0700 (PDT)
From: Karthik Nayak <karthik.188@gmail.com>
To: karthik.188@gmail.com
Cc: git@vger.kernel.org,
	jltobler@gmail.com,
	chriscool@tuxfamily.org
Subject: [PATCH 5/8] clang-format: avoid braces on simple single-statement bodies
Date: Mon,  8 Jul 2024 11:23:13 +0200
Message-ID: <20240708092317.267915-6-karthik.188@gmail.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240708092317.267915-1-karthik.188@gmail.com>
References: <20240708092317.267915-1-karthik.188@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Set the 'RemoveBracesLLVM' to 'true' which ensures that we avoid curly
braces for single-statement bodies in conditional blocks.

Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
---
 .clang-format | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/.clang-format b/.clang-format
index 914254a29b..1a5f0c9046 100644
--- a/.clang-format
+++ b/.clang-format
@@ -117,6 +117,11 @@ IndentWrappedFunctionNames: false
 # int *a;
 PointerAlignment: Right
 
+# Remove optional braces of control statements (if, else, for, and while)
+# according to the LLVM coding style
+# This avoids braces on simple single-statement bodies of statements.
+RemoveBracesLLVM: true
+
 # Don't insert a space after a cast
 # x = (int32)y;    not    x = (int32) y;
 SpaceAfterCStyleCast: false
-- 
2.45.1

