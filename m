Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A18417BD6
	for <git@vger.kernel.org>; Thu, 27 Mar 2025 12:43:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743079434; cv=none; b=mMyBjkLp1dEyw8vEgwhHTsS1gJUf7Lnt3NbCovu8aSRc0hjIw6UBcucqvhRE2YY38eBZb/l4oPrZ+NMywMyCmcJ5D8R+7w+GLJFsFWxp+X9W9YyM0Yjm+5W1aW5v/2IcnmnGHnuIbNxxY+L7Dzr8fltuC3X3C9yjPcarexG0qUk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743079434; c=relaxed/simple;
	bh=lbwDoXVESzKmAWUjMlEQAzfeO/snUPurCzfAozkDDCc=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=g98O0mpAHVRofwa5ZA1yGVE/fj/iO0a8CtlOwe2FADR8ZyEfvrxsYx3R+MaJPQZ8lMnI61SkOvADqMomwUqdyn15dj8k198X7H62VaQ8cK/DYFW95srNai3ENseJylhObHLF9hTwEP18UuxOcfjU6H0Myb0c0ELAziWtisIb1WA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Zxki9VRz; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Zxki9VRz"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-43bb6b0b898so9455785e9.1
        for <git@vger.kernel.org>; Thu, 27 Mar 2025 05:43:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743079431; x=1743684231; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ssepNjpt1gIo/B6jXx2UNiYIu84QPKv2e8v+4zsiEcc=;
        b=Zxki9VRzDqekHwP/As36mquobO8uT3RvDPFUN984dW7K5vA9qL6KpRWANLEdtyRQiA
         zZ4LrdMLLatiNlhVypMarLWYqbloWi7l1+6WbAPF4Eeioz/ESTUzv/PFYNMurOTGf8Fg
         6YntKNXd4M0OJz0j5eaAvwMTASbzrBWORCth5C6Luoq086u0VA3K4AskIaAucnbFdBjk
         FulULRykciduwUmTlYDC4dv870a4CD9Jvxcd4DUJmdezmFAseM/AVUxk81AL25tPbMIh
         YO1mQcDzRZc3X0PJlvi2NgpuxAs3Z5Tf/p2qE6azkkJwnYBxRWQ8HQlHfCNLK7hOUuYl
         AAUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743079431; x=1743684231;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ssepNjpt1gIo/B6jXx2UNiYIu84QPKv2e8v+4zsiEcc=;
        b=XlJo/rpfa1h/P4UYIzHfijWn+0JYOdhIklVMxAPq1HWkAATEG3k/PMU+7rdmG29/uM
         bMWJsnkHHxqOQfEQH3t6hXm1/hVycdI1wtkGVYqAPDXy02TZWhbX+U2SA4ipaTjR47PY
         vZzfBz43zUEYHOLDLIvl92QHxHQtnoACbJkG5xKhSSdOR5/LL+fRZw5ZG6GMh7zhK3xz
         pjrxN4t14w8wPLp/GXiyYL6KYvGzMi+EVc5NVUAQqIJe9UbFMeU13dy6hzJDmZQAy5EK
         YMIGTQH8zsxA9KAYelmwHuYalzaLQBb+C2/ZpxhhKficgVRlRl/mOp6rmIiCX7YrZyel
         sTHQ==
X-Gm-Message-State: AOJu0YwDKULC3Djm75Z0CsKXM6sW3fqqal/TQixSN69EwjqqddNSt9HI
	btqYcJsuh02wuUl/xFfYtgUBIIkptM5HtCPJASIsW8AXDu6zWogSmweQhA==
X-Gm-Gg: ASbGncsavf2qYrPoXum9s81s2qFxxblPVmuYPwtlYHMZvIj4IJ+pQyabvA2N4hKWwwp
	FvJHNGDjYEocHee+DvXbDFPWtggcg++EXiDTVf/LLFktauoHk6qrWmCAzlt2ZiOI8/23qbMWNsj
	1M8Y+F+CJuZmT3mc8bwbh9U4i9+CMzs/219Up05A4sHilatN93fQ22NtFLbJPo3B38eS5M29rE4
	CQgQFOItIbbfI6v9L0mHU/j6SdtYsddDjgYl0Jl0KZq8/uVWc9JPj2TK+r8TD7j8TWrUvJKNIIO
	qhN9xSwoG6Ac9vKkbyn8hoahRPinwsNWiiBMSk4EvKSPgA==
X-Google-Smtp-Source: AGHT+IEeoK5GaEgRisIKKMYy00w5OvEnF7DyHWaQfKeRvS9yvbbDu40H4kQQ86PTzPEn1UTfPENU9g==
X-Received: by 2002:a05:600c:3ac6:b0:43d:412e:8a81 with SMTP id 5b1f17b1804b1-43d85097855mr29075915e9.28.1743079431153;
        Thu, 27 Mar 2025 05:43:51 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43d82f15585sm36131725e9.24.2025.03.27.05.43.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Mar 2025 05:43:50 -0700 (PDT)
Message-Id: <b5e98d5e144f4b3a2771a421690b4b729dc1b7ae.1743079429.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1888.git.1743079429.gitgitgadget@gmail.com>
References: <pull.1888.git.1743079429.gitgitgadget@gmail.com>
From: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 27 Mar 2025 12:43:46 +0000
Subject: [PATCH 1/4] cat_one_file(): make it easy to see that the `size`
 variable is initialized
Fcc: Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
To: git@vger.kernel.org
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>,
    Johannes Schindelin <johannes.schindelin@gmx.de>

From: Johannes Schindelin <johannes.schindelin@gmx.de>

The large `switch` statement makes it a bit impractical to reason about
the code.

One of the code paths can technically lead to using `size` without being
initialized: if the `t` case is taken and the type name is set to the
empty string, we would actually leave `size` unintialized right until we
use it.

Practically, this cannot happen because the
`do_oid_object_info_extended()` function is expected to always populate
the `type_name` if asked for. However, it is quite unnecessary to leave
the code as unwieldy to reason about: Just initialize the variable to 0
and be done with it.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 builtin/cat-file.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/builtin/cat-file.c b/builtin/cat-file.c
index b13561cf73b..128c901fa8e 100644
--- a/builtin/cat-file.c
+++ b/builtin/cat-file.c
@@ -104,7 +104,7 @@ static int cat_one_file(int opt, const char *exp_type, const char *obj_name,
 	struct object_id oid;
 	enum object_type type;
 	char *buf;
-	unsigned long size;
+	unsigned long size = 0;
 	struct object_context obj_context = {0};
 	struct object_info oi = OBJECT_INFO_INIT;
 	struct strbuf sb = STRBUF_INIT;
-- 
gitgitgadget

