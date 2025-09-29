Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5E703074B7
	for <git@vger.kernel.org>; Mon, 29 Sep 2025 13:26:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759152370; cv=none; b=iF20dUjNw3QMV+S7tckyi9W4OQIJw50eji6jnv9TZM5CEm5vGAhEKurrtRE4bGib1PpFSDQkmAAMfLmr6+lAQYuIgpZvMssgdIwP5VOksAgQKrFKjDFYjDIxMlJDZsrPMeMs7LAYOFk7pc9cU/lM5ADNY011mOPkIDFXM3C+CoY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759152370; c=relaxed/simple;
	bh=yTdSep3+tJ1uG60OjqVIrPfi7jc9pbRL4ZqeF+7kntg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=D89NborDl1W85VQlxw+MfKDW+wulwLEvvfTr2+YlDR9+ESuvKgEE5xuoggqrPwZSpSYHZSishRt/piPOs/qs6IvlWObtd+WRsN4YrJZFzM7eh0fL0onK1OyrVaBNjZEnBfeawSpcAVnaiiqij6TzSZfvPaJ842kzNepR1S7hbnk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cTTnKIt/; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cTTnKIt/"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-46e3a50bc0fso29928495e9.3
        for <git@vger.kernel.org>; Mon, 29 Sep 2025 06:26:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759152367; x=1759757167; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5CMBIcZh7lWLAroqz5JYAjGz7Zz918Xvz/L7oSy8AYE=;
        b=cTTnKIt/Ctb2CgOCl+AGkLvMOQQLJzRIyW3cVG4mAOFpv46cJoH36xwdoEm/ZE6k54
         qrSt1XhImt4SXgUUgvTYamXa1goTjBAJof3W8IaGtmFZ3TqRQtN5Khzx0leEXBV3loyS
         wbKSvzb0yKrYjjiCMYpG5dGG6BsPU22hbAj7R9NwkZDp+fE3PWGNJyn1+p0g65WsV2RA
         b8TJdmQv7E318b1bhDBK9q3HTJwNJytkXOBsUFCb8fKao/s6Czu+TdfZJs5khmX66yWi
         HdEYj6GvdjG2tHHRpySXBw8phj7D9w6fkEzGY8GcQ+s8xMhsB7uBetCYZwVwo7qnjckn
         DYhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759152367; x=1759757167;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5CMBIcZh7lWLAroqz5JYAjGz7Zz918Xvz/L7oSy8AYE=;
        b=d24RnEIkhDDQ3uVfeDvPPsURg1bKNfFf6CxmF/x7VYgeiWnHsyD3hRz5fQYiKD8zCT
         JGXtyqU5d0ktz63Zz1SXH8x+slPP6E38s+/zVYEjZL3aQS3wS7HEuw0o8p2gfGjQI+3V
         a3a0mTzF7X3xKOMNrdDplAnPtGbmCPXzRh00WYwEcGNaK3NlcyPF1q4IYk9XP9c/qK1e
         0yh78N6NFdKWYF6KQPbOqdFMrYgfMe0rYiCYlHjohcS5wzCHpp2BPprW3XA7hG+nyefQ
         fmQLcyT6sXZh3kpgtVLboRVTGhJrCGGdwZDkt3gKRBYlWCS3kZ/DtKUAfVQ07bX45BOE
         MlQQ==
X-Forwarded-Encrypted: i=1; AJvYcCXsLyAtlwzm9Fv7j0fjIRBOwsScqSFivmht9Hgxy5rsObVs8Olc238ALS5i1UJIXsM81gY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy0VPnV60t4Qu/+VYsz0nj29KP/xVOkjaQxuxb76I1U09SLbciO
	LCvME2Yhyn6lvUoJ07kBqFDj1IhSTc1YJj9oyWAoTWJpOkkWXtpzBr2g
X-Gm-Gg: ASbGnctzJz2QLFG4M1gAhBA0y8BVAMUlcsKGVbGbe5JJNosUL484WCOgjD/V6vDtNu/
	VpcjJsgBL1xYnDnGekLhWq/SndfYXwEjmZLLoARq+huu5Bl7ry6Uxoq8vH7eEPbApyJHUUTT7QF
	aAkqIHue0Je9AuOcWs7SSzIj5HsShp2hM3xnTBIYUtSV1Dw/eXyR4XLRt0Gxkgt1OAqSZCXBHA7
	tbowszeEnesJk8DJvlGim8Oi9+Jro+ZRRIGYOS3I7fTf2RNmycgv9PMruDlm6HQj7dLxqB63Vxq
	eKmD5jU9vjLArGLti1Zi4/ydAAiEW5SikM1n536hY4LVUWacm2cCKiSCBUBY0jztIl+F0A2K+kc
	q+Dlrdq1xDujSccGpQmWXeWLdAg18xjIDieesrI1gfU31m+wvF/yZ3jIT9WqbAU4t5Qq8avmzdR
	clOQla
X-Google-Smtp-Source: AGHT+IGie7EHAMBVIi2EhTz/yvfF3yjW2nqYaswlbM8oLBdjKh4rsn6uHhIeugLmszcjPdIle77p7g==
X-Received: by 2002:a05:600c:871a:b0:46e:477a:f3dd with SMTP id 5b1f17b1804b1-46e477af5c1mr58632995e9.36.1759152366709;
        Mon, 29 Sep 2025 06:26:06 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:62a:101:8237:372f:a3d9:7aa3? ([2a0a:ef40:62a:101:8237:372f:a3d9:7aa3])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46e33b6da3dsm98042595e9.0.2025.09.29.06.26.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 Sep 2025 06:26:05 -0700 (PDT)
Message-ID: <5cceeaa7-d019-49c9-8849-78643788142e@gmail.com>
Date: Mon, 29 Sep 2025 14:26:10 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/3] po: fix escaped underscores in README.md
To: ionnss via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org
Cc: Chris Torek <chris.torek@gmail.com>, ions <zara.leonardo@gmail.com>
References: <pull.1977.v2.git.1758931659.gitgitgadget@gmail.com>
 <pull.1977.v3.git.1758945111.gitgitgadget@gmail.com>
 <d7810781fc3af1902c99cccbd50853dd630a0080.1758945111.git.gitgitgadget@gmail.com>
Content-Language: en-US
From: Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <d7810781fc3af1902c99cccbd50853dd630a0080.1758945111.git.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

As Junio has already said, you should drop this patch from this series 
as it is unrelated to the others and submit it separately (which I think 
you may have done already) Running

     git rebase --onto HEAD~3 HEAD~2

should do the trick

Thanks

Phillip

On 27/09/2025 04:51, ionnss via GitGitGadget wrote:
> From: ionnss <zara.leonardo@gmail.com>
> 
> Remove unnecessary backslashes from language code examples.
> The underscores in "ll\_CC" and "zh\_CN" don't need escaping
> in Markdown.
> 
> Signed-off-by: ionnss <zara.leonardo@gmail.com>
> ---
>   po/README.md | 6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/po/README.md b/po/README.md
> index ec08aa24ad..d7757bed4e 100644
> --- a/po/README.md
> +++ b/po/README.md
> @@ -13,9 +13,9 @@ We will use XX as an alias to refer to the language translation code in
>   the following paragraphs, for example we use "po/XX.po" to refer to the
>   translation file for a specific language. But this doesn't mean that
>   the language code has only two letters. The language code can be in one
> -of two forms: "ll" or "ll\_CC". Here "ll" is the ISO 639 two-letter
> +of two forms: "ll" or "ll_CC". Here "ll" is the ISO 639 two-letter
>   language code and "CC" is the ISO 3166 two-letter code for country names
> -and subdivisions. For example: "de" for German language code, "zh\_CN"
> +and subdivisions. For example: "de" for German language code, "zh_CN"
>   for Simplified Chinese language code.
>   
>   
> @@ -126,7 +126,7 @@ you add a translation for the first time by running:
>   make po-init PO_FILE=po/XX.po
>   ```
>   
> -where XX is the locale, e.g. "de", "is", "pt\_BR", "zh\_CN", etc.
> +where XX is the locale, e.g. "de", "is", "pt_BR", "zh_CN", etc.
>   
>   The newly generated message file "po/XX.po" is based on the core pot
>   file "po/git-core.pot", so it contains only a minimal set of messages

