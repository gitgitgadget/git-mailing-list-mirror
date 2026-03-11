Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1201F282F33
	for <git@vger.kernel.org>; Wed, 11 Mar 2026 14:16:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773238618; cv=none; b=qEGFQwgk4AvZPOlLm5qBJhsVOjMguJmJowXjGE9MLn90PACZeqCxI6XjNKP4USwup/CbrHrmekiJF9siml0G1GkOA4Vy2TAwjV0YtGaR86UVHAJaLVfYYGH5Ew/bOW/ZG04CaFjerdtS2wuN2xpyfSykR99F478XLJJaZWIrCX4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773238618; c=relaxed/simple;
	bh=v3EYGr7FY/qsl2kWRlNZZ3wFRUzXcBmygIjVoEVWSuQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ucmhd9gbtdUj0/uDNMkDtVOtztKrfy8/g9mdLpju6JG5yWQpD22gDk4ozPCuvdyrO23ahGxtDcbH2Oq3ARAaLjdBh63RhG189knf4khftksAZNPqHFs55KN5xjcgv7rAnvOEoBn592m7KZrJg3hfuvg1zVNrkz2tK+Pyoq0GDzM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LZ7Vvd9E; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LZ7Vvd9E"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4853c3c2fe7so21577005e9.0
        for <git@vger.kernel.org>; Wed, 11 Mar 2026 07:16:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773238615; x=1773843415; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=3KhD6xNVnzapY4B9yd3Gu9O1mv2hK3wBdZZpw+3u1No=;
        b=LZ7Vvd9EgJRB+egncZLt2nz8TOI30T2C9PaRYp4GyWm18zgxH6qtcRRNHjDBQOFxe9
         Pa9DR1LVjRLhZ0xEmLoPigfyu7C/YsD+yKnZD9DOiimMJIQlL5DE0nQtl0wlHQe/0Ets
         6ixbR2MV/t6UiEy6CePUtyFy3Q5Zf8OcvYMmJrQm6xWH23nGy+UxYBm1U87C9MpiznDU
         lhEZrRr3sbbbVe/D0oisEQX4oKOwMsH+F2X+rA0G9vky9GO9+TKsY+QFJKYn5iSN/y4k
         rZoiJBCWRRLLb9uZ+2JIc4rW3dqBr1RynJvKW90E4YDDQiSTBg/l4IahHH0PDOUgFBO2
         nxkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773238615; x=1773843415;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3KhD6xNVnzapY4B9yd3Gu9O1mv2hK3wBdZZpw+3u1No=;
        b=gwZAIH06C8Rd9deta6ooSnFOzDOTdeZTKC/OIupiMikbXoPTPfh451fgsXO/0mHFs5
         RTdSZRsk2WtKGA2djzrlfW01nDW4o4VqkHcjVyR5vg2AQY/XXhDHR3Fd8YUW8AyrVEAR
         kOfhSgwk06kbIMVh2/2+8V5A9rDjK4IrJ0zrXztBa7bwbfSDkpQYl5pxXLJO6tRRixj0
         8iO/mMyR1KJR80nlMkT7sAGQHJNT/LsD4SfpxRFtpKEyNr13VzOgwZDyYcT0S7D1sVQS
         lZvnizslVPrnhkskJZVrpDuh/Zm/emAa/WFjO+1s5pwDXx7shBdQvRAsh2ZOV81+QoUp
         sCZA==
X-Forwarded-Encrypted: i=1; AJvYcCVUGlPl9rSDyKxSGyvr+zEEksJ/AkK4GhIOSMQ+0jSnZ/8EWQ8khK/UDEQEJjE9zSiEe6U=@vger.kernel.org
X-Gm-Message-State: AOJu0YxlmqXxDWW/wfHa34269cKuXn8s/GcuEJnmhL3GbwupfEaKEBlu
	mcd4fEsIfdiYmVmX/IisjheMbaP6q+D1YHFXXKOf38Xx8zPq51u4Gh37
X-Gm-Gg: ATEYQzyS0JJekCwyyL6k0bqqurIfZtIcOIxVnBWmR6On55IJgTjpP0FfZYX2BerGf+7
	uPP/l1DLackPEVpr0GmkvB/OXfOtpPUN/NZ27ZaBg3fD3eeQwKxQCnakbsvWIqIiMQx28sr+/Tr
	pRm7omehbNScPijMAFHwsxbIv/ndgd8b00K2n9DlzO7yo392OazjWmbDz+1yyROp2K7Ujo/iAW1
	9TORypOatNTKCwgGp9Z2X//Jh1SKybtPUjFOtZySaW9Dj4MI42B7dLDoUZwUqV2mUHIiECjLyCw
	vNhBX8/WI/1yMTHaVOxKGMgwP2TtEmq8xXDNp2Ypp7ePGOKEKdrF1Tin1gHHSJC5vtRGs3pnpuU
	ak2WNs9HgrITW5j2jnQ2nBJkoow5TZPhKHdj9TV8rWcCP0nFViReS3sR3LtHcDH2TGlRRDNi3c2
	0lKkFs/vpiKoZV4N1EOjB6bmtVTcLg6mmX6CZrybdoNcfjTiYIqz2LlEitiXGDPVFBapl3osbqv
	Ocq8A==
X-Received: by 2002:a05:600c:1f10:b0:483:8062:b2f with SMTP id 5b1f17b1804b1-4854b0ae55amr52153535e9.6.1773238615067;
        Wed, 11 Mar 2026 07:16:55 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:1785:c801:9102:504:16e7:c44e? ([2a0a:ef40:1785:c801:9102:504:16e7:c44e])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48541b6f6b7sm199873935e9.9.2026.03.11.07.16.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Mar 2026 07:16:54 -0700 (PDT)
Message-ID: <1eb3b78c-5833-4fa9-83f6-237d4a3e78d3@gmail.com>
Date: Wed, 11 Mar 2026 14:16:53 +0000
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH] editorconfig: fix style not applying to subdirs anymore
To: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Cc: Phillip Wood <phillip.wood@dunelm.org.uk>
References: <20260311-b4-pks-editorconfig-fix-subdirs-v1-1-4938193ccd31@pks.im>
Content-Language: en-US
From: Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <20260311-b4-pks-editorconfig-fix-subdirs-v1-1-4938193ccd31@pks.im>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 11/03/2026 07:09, Patrick Steinhardt wrote:
> In 046e1117d5 (templates: add .gitattributes entry for sample hooks,
> 2026-02-13) we have added another pattern to our EditorConfig that sets
> the style for our hook templates. As our templates are located in
> "templates/hooks/", we explicitly specify that subdirectory as part of
> the globbing pattern.
> 
> This change causes files in other subdirectories, like for example
> "builtin/add.c", to not be configured properly anymore. This seems to
> stem from a subtlety in the EditorConfig specification [1]:
> 
>    If the glob contains a path separator (a / not inside square
>    brackets), then the glob is relative to the directory level of the
>    particular .editorconfig file itself. Otherwise the pattern may also
>    match at any level below the .editorconfig level.
> 
> What's interesting is that the _whole_ expression is considered to be
> the glob.

Ouch, I'd missed that, thanks for fixing it

> So when the expression used is for example "{*.c,foo/*.h}",
> then it will be considered a single glob, and because it contains a path
> separator we will now anchor "*.c" matches to the same directory as the
> ".editorconfig" file.
> 
> Fix this issue by splitting out the configuration for hook templates
> into a separate section. It leads to a tiny bit of duplication, but the
> alternative would be something like the following (note the "{,**/}"):
> 
>    [{{,**/}*.{c,h,sh,bash,perl,pl,pm,txt,adoc},config.mak.*,{,**/}Makefile,templates/hooks/*.sample}]
>    indent_style = tab
>    tab_width = 8
> 
> This starts to become somewhat hard to read, so the duplication feels
> like the better tradeoff.

Agreed

Thanks

Phillip

> [1]: https://spec.editorconfig.org/#glob-expressions
> 
> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
> Hi,
> 
> this fixes a small regression in our EditorConfig introduced in
> 046e1117d5 (templates: add .gitattributes entry for sample hooks,
> 2026-02-13). Thanks!
> 
> Patrick
> ---
>   .editorconfig | 6 +++++-
>   1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/.editorconfig b/.editorconfig
> index 6e4eaa8e95..82e121a417 100644
> --- a/.editorconfig
> +++ b/.editorconfig
> @@ -4,7 +4,11 @@ insert_final_newline = true
>   
>   # The settings for C (*.c and *.h) files are mirrored in .clang-format.  Keep
>   # them in sync.
> -[{*.{c,h,sh,bash,perl,pl,pm,txt,adoc},config.mak.*,Makefile,templates/hooks/*.sample}]
> +[{*.{c,h,sh,bash,perl,pl,pm,txt,adoc},config.mak.*,Makefile}]
> +indent_style = tab
> +tab_width = 8
> +
> +[templates/hooks/*.sample]
>   indent_style = tab
>   tab_width = 8
>   
> 
> ---
> base-commit: 7f19e4e1b6a3ad259e2ed66033e01e03b8b74c5e
> change-id: 20260311-b4-pks-editorconfig-fix-subdirs-981e6db389ec
> 
> 

