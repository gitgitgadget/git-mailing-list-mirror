Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B8444D8B6
	for <git@vger.kernel.org>; Mon,  8 Jul 2024 09:23:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720430613; cv=none; b=ICjTUcsLFlUqlwJHNmbkcVyQGklfbJaoJVgmlAiZcPWV2SBoZpOw8suT2P+zsaavu+iqs+riEZk2empSuxfoDlFnwHbAad6hRc7ynJm8nmFxRhMTyAeSFP/XWCBL3SVg8pf8UhDe08/fKb1c7v6TRanlQOtDUoiTL3q3NtWQspo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720430613; c=relaxed/simple;
	bh=rYLSmW92LWpGMgOgvTXGMYv9BXgMYJjw8OEXTDbrCZA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CtTxo5PzQYuJZp+2abd1PJO1iFGfGiSUFozgusm3NOAiQJIlf1su+ibA5je1ZetBsixIqc7P8GqiY2ufTPjMNd9VTARPUF3+8bmdfubeXGUvSAOLXG4pk7i8t4fPT8YMnlUic1d8eg3pd3J9sPxXAtLW1El91pm+8W397FSC6xk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SdEFcTjI; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SdEFcTjI"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4265ff0c86eso11026395e9.3
        for <git@vger.kernel.org>; Mon, 08 Jul 2024 02:23:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720430610; x=1721035410; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KgCNkYwb6YHIDARQWCtaR6yrWUTjYfwaSb3ScX0X54Y=;
        b=SdEFcTjIeET0iGusCXbjuvn0wRaR57BYoZqePJjR03xWIPxNTPrtPNT6MyMHiNg5q3
         9I/Dt/MLvSxGSQ3V8JeViw6ew3fNVlfXRJ3wGyY/YbSZWCUimUcYHZUxzZCdvmE982QV
         O2Ikn8tsMFnkdfTCqG4OO9rKZzEKnwpgKwyg0qJXqNdvHdVx1zlSaXBbWbo50L/WSGU0
         6facEcr8C0u7lJfc4keIBhunymuygGw6+BlpO5rCiPqmTj3YRiUWMFOwC7WIrucBRfsb
         SgcHa+QDOvri3fRKAQylZDq2zXJ9vEdemUAXYRd6ktKV04J07NsAI+XXz/eWthPNTQWz
         1xJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720430610; x=1721035410;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KgCNkYwb6YHIDARQWCtaR6yrWUTjYfwaSb3ScX0X54Y=;
        b=mMRObckKqoDX1UcuPTA1Vu3md/XpPbqbaOIiK3kGuHKOv8bR3toibSMx+hvtoqsbK/
         GQR8CnRilbWMEgkOeJrXT/+Oj3/7zt8sdx44Tlnj4KHkRJCGlzxBKNdn9E/YA6zfs978
         hDsuAQC6W9SKlaqTX8PHC+2ee7qlsAjWkly+4ZOElw+DKTKm6UulNBgyhb/217IereJ3
         hECH052r9qDaGqEqQpSsng5xpxvjUI3o87sVqQ3+cCfuD4tz+h66gpUdXBjfzP02gwzu
         HeRbge0X9kO9jKy4N1Rzn1Syv9+vPTuJZULFqvbl//vrb2aGZdxzIsCaA9yBOYofcT+5
         w/Pw==
X-Gm-Message-State: AOJu0YwAwJC3Vtk3MfgU5V0FPIn7Xi3KNCeSTovTqrHAfSJLcFozvvwe
	QTH3i3OOtsOQUe/aaO9cqQtwkj+Zl53swLMKpD4CLt80SlUwm9B8UNeSOm8A
X-Google-Smtp-Source: AGHT+IGAyItnfFlmXtHrTuic38VzBt6w9GbjDLx6rL40+2JHSfK5G5JAaaKuZDA2x28A1ogaOL9Z9g==
X-Received: by 2002:a05:600c:a69d:b0:426:5f02:7b05 with SMTP id 5b1f17b1804b1-4265f027ba1mr40978215e9.2.1720430610374;
        Mon, 08 Jul 2024 02:23:30 -0700 (PDT)
Received: from laptop.fritz.box ([2a02:2455:826e:4900:1d0d:3d35:3ae6:ef05])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4264a1d5116sm158259935e9.10.2024.07.08.02.23.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jul 2024 02:23:29 -0700 (PDT)
From: Karthik Nayak <karthik.188@gmail.com>
To: karthik.188@gmail.com
Cc: git@vger.kernel.org,
	jltobler@gmail.com,
	chriscool@tuxfamily.org
Subject: [PATCH 2/8] clang-format: avoid spacing around bitfield colon
Date: Mon,  8 Jul 2024 11:23:10 +0200
Message-ID: <20240708092317.267915-3-karthik.188@gmail.com>
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

The spacing around colons is currently not standardized and as such we
have the following practices in our code base:
- Spacing around the colon `int bf : 1`: 146 instances
- No spacing around the colon `int bf:1`: 148 instances
- Spacing before the colon `int bf :1`: 6 instances
- Spacing after the colon `int bf: 1`: 12 instances

Let's formalize this by picking the most followed pattern and add the
corresponding style to '.clang-format'.

Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
---
 .clang-format | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/.clang-format b/.clang-format
index 5e128519bf..803b274dd5 100644
--- a/.clang-format
+++ b/.clang-format
@@ -72,6 +72,10 @@ AlwaysBreakAfterReturnType: None
 BinPackArguments: true
 BinPackParameters: true
 
+# Add no space around the bit field
+# unsigned bf:2;
+BitFieldColonSpacing: None
+
 # Attach braces to surrounding context except break before braces on function
 # definitions.
 # void foo()
-- 
2.45.1

