Received: from mail-pl1-f194.google.com (mail-pl1-f194.google.com [209.85.214.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4081313AA31
	for <git@vger.kernel.org>; Sun,  9 Feb 2025 08:13:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739088833; cv=none; b=r6zmZZnlAV+/h59DW59lWL9rNT12LvJxM008J1NbZeorpqGxJEmkBgdAdfBaVevxCuHnYoMdsjFroRJOI61D2e5OIHOctlYcGAGZxvl5aKn3b9I803uLAiJLNJs3rRvERrWSNqwnwzeM2g94ma8wTa5MZEBTLxBxUaI4kZrUk48=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739088833; c=relaxed/simple;
	bh=XkOGQBM+b37ZYCSzbHktoPBtt3IizJglRneCGl7MfIM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WqFVjMBYkcF4iKvrMv2h5FKKN88fuFntYIH/J3T4wpHXF6UmEDMVDrk1peswtzWHltKh6IeTAsCsSdFpUwZdyksDXjbTSKoufhoUec6RaIbCCheZwJSn+Ze3Y6lIrtRefZxeoKzm5t3Hs+2eGceNxAer9ImArCOgygQsPY76nxY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NMT6gUrT; arc=none smtp.client-ip=209.85.214.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NMT6gUrT"
Received: by mail-pl1-f194.google.com with SMTP id d9443c01a7336-21f6022c2c3so22216495ad.0
        for <git@vger.kernel.org>; Sun, 09 Feb 2025 00:13:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739088831; x=1739693631; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Mh80cUZ8y13IDT9oSUrF9SwDfo3+8xCS4Vc83Wosju4=;
        b=NMT6gUrTz/pOtGZ/u6CO3HYyM3STvseO2ARLeg6ODYu86UlhyEghsii3pnwEbxIMgL
         galn5xzfv+i2IhctPJ9StLzwpbT355hUcX7LR1nF+JZtHFWej8GfcsGZ7H/F4mrDCeIh
         ngwXCKb0yNsLuzcVsRhKV/4z9QSbrH0iyBLP5F+8WrQyRrEdCN4ScSqMEd9SwO98890U
         TJCRZ+bWS1l2ZY04UMFC1KIQgdeNe73mRaWtmZC/OTc0xuswZJ/47jzLeeCQVf6HN1p+
         78b9myLqv71LMtc2MbHCzGybKpYXGInkQGBOEveD4MDmr0lVmnM55sa0JT7mezfGYvaB
         bXgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739088831; x=1739693631;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Mh80cUZ8y13IDT9oSUrF9SwDfo3+8xCS4Vc83Wosju4=;
        b=TaBEhPiRky9ie2SYZNsTPaRyZIToaSWAf25dbqQ6aiaKvaH9EHOCB5wiOnxyMQtudS
         i4nDT0iZVqFkm4+LU138NeaVNOKTZBWGwVbivm6KF+8kHM1SpLpZj5P6v4EN2gwrfsPj
         zVdkT0xX6dWEn/iYL6GjXzDZ9ZxJGxEtuyMZWCDxkzz49HJnnftA6qukcPUES7EF330S
         XzkgQPIq4mqeqsfTg5ikHYtYdD7x2AIylg+B05xPoY0nBYTwdL9qljCI73tQ5GKcPThh
         gMaYa/0Dc3qNoNWSEAsOF1kQ6cq4eZAFvXnw6Ux+3S2ZCq6C3+EjAAynFqbUnolaELK1
         oEDg==
X-Gm-Message-State: AOJu0YxMJ2BUgMWkNu+YLJG8Ne1JBwNJ31TdlBttn7UezZTpIh33R77Z
	EQS6ARjoSQFKIhwSO1dNX+Vsd7dzuRqWibbZkDN1R1LKWX0UD4Ah
X-Gm-Gg: ASbGnct2S6PLak5d3n2PkDxAhsGt0JstdXH7jQ44NjPzPzQHVaFLU494NvRIfFFw9eP
	yiREzlDT8n8H91iX35In3uLrbm2fXDY+vTZRip8DENgckUYx/KrsmK2It1eQmGDqC09wsiL80JU
	Yk1uzXnhPXAW5tLlv8q/kNrB2gNHnlo67Trh7kc3q3X1sS6qfwPxtHWcO+etetudx3Z1++XOFJQ
	GMRFt7FqK5M5gAzuAPurI6XAcNXgjwdgsKP6fUWyKde+pUJVbl0MdAXL+EnhfEWwrC7+cpOH7ge
	EIBMuAAjOzDneoLV7uPQfyXJ4FQ9QiqRnajTlQmrE7NfzjgHUzLVAA==
X-Google-Smtp-Source: AGHT+IGgUqVvQTab3iOJhD/0wqMQL7QHqCdB8swj6htRy0oItZ8welG838OnXRsCM05YnkLCukUGOg==
X-Received: by 2002:a05:6a20:6f06:b0:1ed:d780:feaf with SMTP id adf61e73a8af0-1ee05290924mr15776440637.6.1739088831479;
        Sun, 09 Feb 2025 00:13:51 -0800 (PST)
Received: from Ubuntu-ROG-Strix-G512LV.. ([103.116.72.131])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-730889e0c5fsm466308b3a.119.2025.02.09.00.13.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Feb 2025 00:13:51 -0800 (PST)
From: Zejun Zhao <jelly.zhao.42@gmail.com>
To: jelly.zhao.42@gmail.com
Cc: git@vger.kernel.org,
	gitster@pobox.com,
	newren@gmail.com,
	ps@pks.im
Subject: [GSOC][PATCH v2 6/6] apply: enable -Wsign-comparison checks
Date: Sun,  9 Feb 2025 08:12:16 +0000
Message-ID: <20250209081216.241350-7-jelly.zhao.42@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250209081216.241350-1-jelly.zhao.42@gmail.com>
References: <20250205014055.737190-1-jelly.zhao.42@gmail.com>
 <20250209081216.241350-1-jelly.zhao.42@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Remove the `#define DISABLE_SIGN_COMPARE_WARNINGS` header line.

Signed-off-by: Zejun Zhao <jelly.zhao.42@gmail.com>
---
 apply.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/apply.c b/apply.c
index 585f534732..51d0f4813f 100644
--- a/apply.c
+++ b/apply.c
@@ -8,7 +8,6 @@
  */
 
 #define USE_THE_REPOSITORY_VARIABLE
-#define DISABLE_SIGN_COMPARE_WARNINGS
 
 #include "git-compat-util.h"
 #include "abspath.h"
-- 
2.43.0

