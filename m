Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D6D7153BD6
	for <git@vger.kernel.org>; Mon, 29 Jan 2024 21:08:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706562508; cv=none; b=TwkHCNWQJ7Xu8wbPQ2Y8DdG+qvu5DhfVKr+C+1OsAoFgtGOmz1GGtj/muV0aEavAS9hADAEaSJYPZDgubpIYajyP094aikgQYeceoBuWrD2wkeIcb9IxGnRtOmI2VPFfRk4d5vU3/ZVHl7KSQK1hzju7r30v1ZCNdowil2LEJX0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706562508; c=relaxed/simple;
	bh=poNRftosEG1bX9/5oRKwO+fHOoX+rSTSqGjXMNrmD6o=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:References:
	 In-Reply-To:Content-Type; b=OIXh8fuQB16kFcIXpNBr8/rcUfzRA9FO96dj4v54VRlA5grj2yh/YLmQnRGGPBerwDlYUSi25wUEV2ZYg8vhOXx7qy3b5XfDgWbu+ekRIkeQBl+Kl1pSxNPinEgu/+3tos1TTIR3ximw4KoGGzDEJgZ+g+CWnqNs9EGraYlN0bc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=erZ37C1h; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="erZ37C1h"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-40ef6442d60so12468745e9.1
        for <git@vger.kernel.org>; Mon, 29 Jan 2024 13:08:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706562505; x=1707167305; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:references:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BZeOKSGXOQj4PpRlS8Ug5lD+TauIktOS0BFSdXBGJgo=;
        b=erZ37C1hB8o2BHOn60LvTiqpoY2iSQS7SkSuO7kIfbHmkdzNCjqefxweYe7sCiEdAF
         9ukmfktJvFHLSUnunrjJDfVpnYK/CzDRiL9dUeC4hHHlCwSypZzKgXRpBKAC/VZ7sSo8
         w2EwkSvhRYK8VpUtXKeqNtHloGvRInxu/vhr/oyjQrlUMy+jzPX2u9pOhE9JuenSF+AG
         8bBGtzbrEMRi55AyU8dSZDutsyEbyPgSazC2QGS+/JeOJMHVlxUxGEMUN009/ATt9oi8
         crBaeB9AgujvBFsCQ5UXngIZpSQlGzaBj7Hqu4QuQRiuBs8qqcgiE0V9V63A/zxtS4QB
         P/7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706562505; x=1707167305;
        h=content-transfer-encoding:in-reply-to:references:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BZeOKSGXOQj4PpRlS8Ug5lD+TauIktOS0BFSdXBGJgo=;
        b=H8IaNkdx+VaNucuuhgwUZq1khvjPM2HjZADMgElqyA6N3b97wVfciamqVb5MDzEznj
         74MzjYq4xdJrTYfulMUcAoVZD5RpSN9r6CTT//DAoWfTidJN5dJOoGyjmtfbzERvr4Vy
         kzCwsx3JEh8rpyky77p4MA7OKi22kSBYXedER/Za3ybPdn8/aISAoQ092Um2P50VBSz1
         Rqr9p8te7+MSECu1PrtK+c0a0FuaDhVKfK9DGZKkONPBc2gHrfJt4guSb8CF65kzcnmU
         WN+x0jc6Gic+8STeGJabjq5wb9rUUwEQCXvdUSlTiVwDJntjpLqGT+HJZLioIPxbSk5b
         Koow==
X-Gm-Message-State: AOJu0Yx0bpo+fnyyfYpHVIMja4cB9Oz4v0c09u0YbpSvcP5Lf1A0YiSH
	Lp6mtlb7ap92Ke/5W7UpUJEvzN5pGz2cElTMW+bOD99dZurklN09qn7FSwHF
X-Google-Smtp-Source: AGHT+IGTtxjtUomRpR0U8RMAx91jFXT6QUFXjw775WL1VxpFSSpA9m7Z40Z3tQF7aNPTaMUp1/PWAA==
X-Received: by 2002:a05:600c:444c:b0:40e:f157:e765 with SMTP id v12-20020a05600c444c00b0040ef157e765mr4619104wmn.0.1706562504582;
        Mon, 29 Jan 2024 13:08:24 -0800 (PST)
Received: from gmail.com (77.red-88-14-198.dynamicip.rima-tde.net. [88.14.198.77])
        by smtp.gmail.com with ESMTPSA id p37-20020a05600c1da500b0040eee4931c9sm7928192wms.48.2024.01.29.13.08.24
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 Jan 2024 13:08:24 -0800 (PST)
Message-ID: <4adfcba4-0f2b-44f5-a312-97f00f979435@gmail.com>
Date: Mon, 29 Jan 2024 22:08:23 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH 1/4] t0080: mark as leak-free
Content-Language: en-US
From: =?UTF-8?Q?Rub=C3=A9n_Justo?= <rjusto@gmail.com>
To: Git List <git@vger.kernel.org>
References: <45eb0748-6415-4e52-a54f-8d4e5ad57dde@gmail.com>
In-Reply-To: <45eb0748-6415-4e52-a54f-8d4e5ad57dde@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

This test is leak-free since it was added in e137fe3b29 (unit tests: add
TAP unit test framework, 2023-11-09)

Let's mark it as leak-free to make sure it stays that way (and to reduce
noise when looking for other leak-free scripts after we fix some leaks).

Signed-off-by: Rubén Justo <rjusto@gmail.com>
---
 t/t0080-unit-test-output.sh | 1 +
 1 file changed, 1 insertion(+)

diff --git a/t/t0080-unit-test-output.sh b/t/t0080-unit-test-output.sh
index 961b54b06c..6657c114a3 100755
--- a/t/t0080-unit-test-output.sh
+++ b/t/t0080-unit-test-output.sh
@@ -2,6 +2,7 @@
 
 test_description='Test the output of the unit test framework'
 
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success 'TAP output from unit tests' '
-- 
2.43.0
