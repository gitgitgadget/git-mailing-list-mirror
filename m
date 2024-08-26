Received: from mail-ot1-f65.google.com (mail-ot1-f65.google.com [209.85.210.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8998F192D6F
	for <git@vger.kernel.org>; Mon, 26 Aug 2024 15:56:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724687810; cv=none; b=RgwjgfS4NPNEcGMuPg7uU74AaD1OLF8V45pwRDC2AUV9pGx/moBQLUekWjnKtm1jF6Ob5oMqVL6Y7L8KtBaawanKT6329qWAlTYBmxlwSQghuvHIv15ES0zRtfKc2XakBZO6J7l1VkwebeJOPvJ6sYeoP8TTBN3Zzw1vDRnslng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724687810; c=relaxed/simple;
	bh=w0MhBcT8vlzIw9SCvHY5NCG3DipX9DhBj8vSiGnKDus=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=F0y5qwjPDPvlmBtnT5QQQZYizZxWY9OTgiGl9vBCTqRtjKjQUy4v+i9eR0EZThuIo5sGFTg/C+0VZISfehMgd/LJsJ+uoA5ShdMnaT6YFIE5nTH4jwc2ZK+wtHkyhldOCxMcm4uwRtcQ9SvFXwGBApXu6gmp3yZakk5iGx+Tl+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TKbfd4OI; arc=none smtp.client-ip=209.85.210.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TKbfd4OI"
Received: by mail-ot1-f65.google.com with SMTP id 46e09a7af769-709428a9469so4286698a34.3
        for <git@vger.kernel.org>; Mon, 26 Aug 2024 08:56:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724687808; x=1725292608; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=CTE2SCNY8eH2jny/Wzv4Xgf07h0ZPoZV1lNOQrkRgk0=;
        b=TKbfd4OI3hbx0ZV8YLQdMmYspvDi2g3C21uuja/upAGqcgDogDNHo/sauCGJQZxT84
         p0wM2Xx6415emBI4HNRrFmOZqx4akKnBh3GZWMdspS1AHNLIHFrl6a0Vn7DBc1nQa6fE
         rVQlWFjo1J+xdd5e0LAAaAtlrvz8D/9cOCQPWH330Zq+O4r8KzUDlXCb/jGxmlWBqEUD
         4SbwRh2e9HyNBNcTb6wJAEaupj+E1ApG/UStqGelgtjmZLV63lk44z0QHv+EqHoFRiyv
         j85hVdveh9xgiI8bpMbiezle7Vdq34aObEB0b2n74l2ZjucKFB5Ye0YoAyCUjg8xyZA5
         MzDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724687808; x=1725292608;
        h=content-transfer-encoding:in-reply-to:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CTE2SCNY8eH2jny/Wzv4Xgf07h0ZPoZV1lNOQrkRgk0=;
        b=o7UHtThPfeFrYu8Xfk4T2frS76yC+8Snc0Z07mXnMMlJse0/afu6txWyXESSxyvg4A
         uKDZG/zF3ogHtvEh5Ww4kI0pJW3UgItoRnaBXqCF/GNszP1VTUFbQxE8/PGetDsOXVw+
         oIM9C3i2pCySlY1oXOIDWZSFJd2tEr15ikzEyngLrccOtXg/UmJt41owJ+jlBZ20L3wZ
         cSAqAvxm+B/zcaSSkPcPyp22kcY7l+VJegtxjD2QYFzOZ+k6JLGGLvSjrfyNfK15epy/
         zDPAvWViK14il5fOpe87YOJOAOQg/u1t3ZH6o1GLgFPbpN8tchubmy7Rt3dGXWDNywo2
         HVug==
X-Gm-Message-State: AOJu0Yy2K4aHXvZ1rw3gTwGcXPxPBFM1/XgthUKq1GZ0LgbSInAnD9MG
	NbJqMxm29NLXIlsS3nWNj8j1VQ21hICeN1qwn5471JZ5bhEpkyQk
X-Google-Smtp-Source: AGHT+IEoFWvUqh86CcIinYknd/MjL7E+4u7BzmBoFrirWUqgqKjdpvnQaFyGjV59W2mdunXJ7TgMZA==
X-Received: by 2002:a05:6808:3a1a:b0:3d9:384a:3674 with SMTP id 5614622812f47-3de2a8d732bmr12866363b6e.33.1724687808440;
        Mon, 26 Aug 2024 08:56:48 -0700 (PDT)
Received: from [127.0.0.1] ([103.156.242.194])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7cd9acdae4csm7800257a12.40.2024.08.26.08.56.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 Aug 2024 08:56:48 -0700 (PDT)
From: Celeste Liu <coelacanthushex@gmail.com>
X-Google-Original-From: Celeste Liu <CoelacanthusHex@gmail.com>
Message-ID: <8c1c031b-4f36-4825-93ef-408c50b0ee2f@gmail.com>
Date: Mon, 26 Aug 2024 23:56:44 +0800
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] doc: replace 3 dash with correct 2 dash in git-config(1)
Content-Language: en-GB-large
To: Junio C Hamano <gitster@pobox.com>, Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
References: <20240822172042.54065-1-CoelacanthusHex@gmail.com>
 <Zsgh4LacdOt8N69o@tanuki> <6c9f666e-12ad-4b67-a44a-3111686454f3@gmail.com>
 <ZswfgYsZrzY6kc1E@tanuki> <xmqqa5gznwf9.fsf@gitster.g>
In-Reply-To: <xmqqa5gznwf9.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2024-08-26 23:19, Junio C Hamano wrote:

> Patrick Steinhardt <ps@pks.im> writes:
> 
>>>> There's one more thing I noticed: the synopsis for `git config get` says
>>>> `--regrexp=<regexp>`, which is clearly wrong. As you're already at it,
>>>> would you mind including a second patch that corrects this?
>>>
>>> I couldn't find this typo. Did I miss something? If something missed, please 
>>> tell me. I will include it in v3.
>>> v2 has been sent.
>>
>> It's in line 13 in Documentation/git-config.txt. Seeing that your v2 is
> 
> Ahhhh.  You weren't saying "regexp is misspelt as regrexp".  You're
> right.  I too missed it.

Ohhhhh. I missed it.
A comment which include typo and point out a typo led my brain to wrong way.

And is there need a new patch to fix this? Or you will fix it directly?

> 
> The synopsis should lose "=<regexp>" part, as the option does not
> take any arguments.
> 
> Thanks.

