Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C64433232
	for <git@vger.kernel.org>; Sun, 21 Apr 2024 10:27:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713695238; cv=none; b=srvMA41raT5SXPRcD6ew6Gv2wGKYCwli2yAojolV8ndJdJDGDFlG4906tjwDtUHL/QeEpsZvaAEyp6+jGNGXGKkPdWcOLtwcTjZOy/RsYWtQUWEZ9vSujKBZntjlBhaApKd+UFsVREdzfBTePK0MEz4kljfcmmcEiJdRwz5PTZ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713695238; c=relaxed/simple;
	bh=Bx/e1YSgVBgEp+9a3/OF/iL+4FfG4owtwI8o7Lwef9E=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:References:
	 In-Reply-To:Content-Type; b=b4O80mqCY3Eo5zTx8NUFDZa/nB60BbxXyRmrnsKMUX5IsdrJfc+5g16bgzVmNTVo6mwQip2nk4/zJuoGBwXV32qusIlzRyuDeNA81WlDNZJ1oAyeDcZqwvA+35wscn1pG7MSAI0k/WoMRpgNjWiuV7R3u509mx3x3T1r0N6kgyo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=USxn5kiH; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="USxn5kiH"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-41550858cabso24590515e9.2
        for <git@vger.kernel.org>; Sun, 21 Apr 2024 03:27:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713695235; x=1714300035; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :to:from:subject:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vealx12/tXi5ecAQA2l3XhkAR11Ifid72P5fgiHwlUY=;
        b=USxn5kiHR9gWMJeeB8+L/gQmJ+uYXBjxg91xVUHHUxE5nBBoOLtaWgPR+ztKJgsl3u
         haelJlKdT1t78zgbS0s7KP9uhnpxdPS6SC3nmlZyDh+oohC5sADjA0GldV2RVFv/GBRx
         I/hh4o2V0tX8OOPvZIU8tZa8TSs7MnjaM/MJ6BVaucvLjjMzxFedenikDswDUdvdJjm5
         pUwSXG9yAM/bsA5dyx1AwSDZTOWbDUXlYh8d0GPfK4kEZjaxfCLtGLv2AkmDOvSw1EaQ
         FrxzipCTrXMDDoW5hsWG9BadzLHOqp5lkGpqx+pxxa01aT0wuuM19zLPjZp+Hk01yPGF
         NkGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713695235; x=1714300035;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vealx12/tXi5ecAQA2l3XhkAR11Ifid72P5fgiHwlUY=;
        b=auhOxpbS30fp9Gwx14R7ppwk7Sa4UenFtiGovssT1P3kv1nV842sZvRVWOUKrqCG1P
         h5ajqoM4gIf8PNcjbGcg/CufFBI+e83nix/RwIU+MndGpdM59JBR3gw6i0RsTY+Q2LeP
         0ko7BBXDfRq3E4ru+7YfIC0XtqN1zBqky72ixypGUwlPO/q6ayO149bFUZQwP9vcGfgI
         Tjyr/dBsS+SmEAoIne3FrRCvYFEu5y3SxdqVAI7jS1yEVqF0ZaeM9XyEmHbKrHiZx0Ul
         vkQwqxU98ZR7+uJr5fZvtfpSH34NAsjGq+HBqa8avxmS+UM3N44R9mjDMYruE9IcPioE
         AHDQ==
X-Gm-Message-State: AOJu0Yw44HvvndlUrIQwCdW0pHjSBGAkOOELayATi7dAyHkg45u7O9+e
	nENjpj1MCqpXyovUO9gN8oxCC3so8wjyyoRcIZwsG4uZziCvDw6RL5hmxA==
X-Google-Smtp-Source: AGHT+IGBv66tmmrasjiRM//I66LU4ZApI78HNTXNeCP/B3W+9pLKu5lTwOIeu/4zRSlZ9pennCSuyQ==
X-Received: by 2002:a05:600c:4e92:b0:418:f991:713f with SMTP id f18-20020a05600c4e9200b00418f991713fmr4698061wmq.23.1713695234978;
        Sun, 21 Apr 2024 03:27:14 -0700 (PDT)
Received: from gmail.com (145.red-88-13-173.dynamicip.rima-tde.net. [88.13.173.145])
        by smtp.gmail.com with ESMTPSA id r14-20020a05600c458e00b00417e5b71188sm12872021wmo.34.2024.04.21.03.27.12
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 21 Apr 2024 03:27:14 -0700 (PDT)
Message-ID: <88b119aa-c1c2-435a-baaa-9422388bf0ec@gmail.com>
Date: Sun, 21 Apr 2024 12:27:06 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH 2/4] add-interactive: plug a leak in get_untracked_files
From: =?UTF-8?Q?Rub=C3=A9n_Justo?= <rjusto@gmail.com>
To: Git List <git@vger.kernel.org>
References: <b7b2d0d2-245e-440f-a7cc-fa0df1ce73ad@gmail.com>
Content-Language: en-US
In-Reply-To: <b7b2d0d2-245e-440f-a7cc-fa0df1ce73ad@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Plug a leak we have since ab1e1cccaf (built-in add -i: re-implement
`add-untracked` in C, 2019-11-29).

This leak can be triggered with:

	$ echo a | git add -i

As a curiosity, we have a somewhat similar function in builtin/stash.c,
which correctly frees the memory.

Signed-off-by: Rubén Justo <rjusto@gmail.com>
---
 add-interactive.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/add-interactive.c b/add-interactive.c
index 6bf87e7ae7..e17602b5e4 100644
--- a/add-interactive.c
+++ b/add-interactive.c
@@ -865,6 +865,7 @@ static int get_untracked_files(struct repository *r,
 	}
 
 	strbuf_release(&buf);
+	dir_clear(&dir);
 	return 0;
 }
 
-- 
2.45.0.rc0.4.g08f77eb516
