Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91EFE153BD6
	for <git@vger.kernel.org>; Mon, 29 Jan 2024 21:08:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706562512; cv=none; b=CwteHM9N3t8sVo8vGPkBJcDdB0bd6nah7rHrLSvOHOIOCBLN2aROUa0ISUOceAKkE1jgpZWUB5j6DS6arP4TvfzIFXNa4Y8wkPBXtMzqQ9TKJNc23wXEDV7U3rlMT4bUMhisM4wK+evzmA98rAyXZbQCqL+t8Zz29/wW9Skxi/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706562512; c=relaxed/simple;
	bh=P138CkIR7IQl5pjzihTJRVUmbbu3owgB2lVhaRIli0w=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:References:
	 In-Reply-To:Content-Type; b=fy+k1zOHeWIMRACIFdeOhuErubvz6cqLVR6R9HseqH1kOSTz3CEKzz99rV6dL32xryc9wnZmJ72AvzoO1zinBgVTIM838DmaU4ZT1NUTkXXTiAhlItugVzHj2JhfCFFrkF/S3fxCMDzTciWtaXqlXV3cmJdv/s6ooWzi8yWJJFI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Gg9yCJSR; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Gg9yCJSR"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-40e80046246so17657375e9.1
        for <git@vger.kernel.org>; Mon, 29 Jan 2024 13:08:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706562509; x=1707167309; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:references:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1he35j0iHkkDz2QiI1sEXGjam7vSE7oNWnUdcAwWemw=;
        b=Gg9yCJSRzw5Um/NjbtNa1BP41J6zWFcwSHFhYVxAa9eL8q3MZDklctdBJddVtn8wcX
         kuVWu6EB2jp7vNxpFrpWoEGZNeODch88OYNM6JfzRbQQk4pveXtWliym2uloRkjlnLSS
         B7uN5gO/WY1aNXDQQhrug0l1y1OeAS/L9FtIRXg1VswCwpQxDOV//cKggFgn1wy4drXu
         x4YD9IUk1rBMTRjKdn4mKx34gL+4rbS/pJaEN7XzqOfbjsGn9edmYRvNSFk5AMe5HaYl
         3Vu5BpF2KEuv544iY+WF7Rl9YOuKuXFKfc6pOHkpIKtzGYwSUaUy7nIOLIo59E7JM9rh
         8GaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706562509; x=1707167309;
        h=content-transfer-encoding:in-reply-to:references:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1he35j0iHkkDz2QiI1sEXGjam7vSE7oNWnUdcAwWemw=;
        b=SjIeIxgUkVsfn+M4gqeX485Uawl2ueDMn6Euh2Q7u94ALNJVN5sXNSyFsWn7vLZugf
         GwPzEmea/sIJ2AcMGjMppCedxSh2o5Gug1EUcxO6DmUIjGBBk1IxBMKCr572HCdAF8ZY
         UEJZgceraZkE2j4BYqaDO4bxS5jTUq9Ceo2BXPjArdqWgWGALYATdL3ItU9AS3y8EfZS
         WcszeOpbkXdzp686oCr4kkbod7u8rO4wXuI0I++rpkmL4bHsMMFkkH6k1QMHW8IUZzcP
         6613HOmhhqBj9kt2oeg7ekTm753V6QzXk890XM6FD3hu/5Uj+E2r6jvvDowSMl6MFtrG
         SA3Q==
X-Gm-Message-State: AOJu0YxDPHPGNX2yVj/qMOaezvurklxqdZEvzsWQAi9DbhPl/U9HI40T
	SIPld8k4aEAjv6ZIZ5yabWRQKWjNhisBcQU36MN31MUOLSb0ehV53PvLHXLW
X-Google-Smtp-Source: AGHT+IGhxIJkQiNulLMZGFO9eOZFc9DDV+IdUCzuXCy7duufGNddlXsGwiGv38Wvxs6wSIdcUWPfLw==
X-Received: by 2002:a05:600c:3b92:b0:40e:f972:9901 with SMTP id n18-20020a05600c3b9200b0040ef9729901mr2621015wms.4.1706562508828;
        Mon, 29 Jan 2024 13:08:28 -0800 (PST)
Received: from gmail.com (77.red-88-14-198.dynamicip.rima-tde.net. [88.14.198.77])
        by smtp.gmail.com with ESMTPSA id p37-20020a05600c1da500b0040eee4931c9sm7928192wms.48.2024.01.29.13.08.27
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 Jan 2024 13:08:28 -0800 (PST)
Message-ID: <c5b2f1ba-6a10-40ae-a2f4-07bd9060d42f@gmail.com>
Date: Mon, 29 Jan 2024 22:08:27 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH 2/4] t5332: mark as leak-free
Content-Language: en-US
From: =?UTF-8?Q?Rub=C3=A9n_Justo?= <rjusto@gmail.com>
To: Git List <git@vger.kernel.org>
References: <45eb0748-6415-4e52-a54f-8d4e5ad57dde@gmail.com>
In-Reply-To: <45eb0748-6415-4e52-a54f-8d4e5ad57dde@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

This test is leak-free since it was added in af626ac0e0 (pack-bitmap:
enable reuse from all bitmapped packs, 2023-12-14).

Let's mark it as leak-free to make sure it stays that way (and to reduce
noise when looking for other leak-free scripts after we fix some leaks).

Signed-off-by: Rubén Justo <rjusto@gmail.com>
---
 t/t5332-multi-pack-reuse.sh | 1 +
 1 file changed, 1 insertion(+)

diff --git a/t/t5332-multi-pack-reuse.sh b/t/t5332-multi-pack-reuse.sh
index 2ba788b042..99145327a6 100755
--- a/t/t5332-multi-pack-reuse.sh
+++ b/t/t5332-multi-pack-reuse.sh
@@ -2,6 +2,7 @@
 
 test_description='pack-objects multi-pack reuse'
 
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 . "$TEST_DIRECTORY"/lib-bitmap.sh
 
-- 
2.43.0
