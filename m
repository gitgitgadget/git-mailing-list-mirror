Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com [209.85.219.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 169C3249E5
	for <git@vger.kernel.org>; Fri, 22 Nov 2024 19:08:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732302492; cv=none; b=g4naUjKXum16ZG5lVZXzYeh9YxhRf6FjlSN6ebCZjXqOmsxQBvyvZMmrVQIIhTcyz+ad2ibC5tYcLTQQw5RjOhqrGKDkIYDAL4aM0iXqfcsJrzt5EupkRxx1mZpyjxr/rriEH3qohs+czYMSnCU0kAYtS/9xCkyu82P527WGDow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732302492; c=relaxed/simple;
	bh=ri+DeckF55DGRBww/pSe8WMFQAWkvxMSXyJGZjHsas8=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=kotlqQYIAPakQwtVxSUV4hKHSUpTM3ycjFa1t9v5b3nCZuOxXAvg/7+dD4YCY/0jczyrXxRLS2TA93qakxDdVfWOefr5Az0F7vgxnJJ6gXZZra64PX9l39/ZlGLD1G1Po3pwspJhQfR82p1mxxxibAadt0df9m130UPwMedLFqo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HuExbkN8; arc=none smtp.client-ip=209.85.219.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HuExbkN8"
Received: by mail-qv1-f52.google.com with SMTP id 6a1803df08f44-6d42b87aceaso31964316d6.0
        for <git@vger.kernel.org>; Fri, 22 Nov 2024 11:08:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732302490; x=1732907290; darn=vger.kernel.org;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SXjUPW+x9WEmydpNfXc5jwTNlU38YPms/FdHWQQKoZw=;
        b=HuExbkN8FtZfvl3CCeDTcIPkEtn5vaq2Btgf3tJj9cLiqe0l/ElrK/fU1gt1LMenPO
         2ejx21HeOLzpGGTlgo6msn8Wn32723eRc/OSN+XAHTAYC7sICh6tVX9Rmov0QXbt6rmO
         PkkcIKC8hQF6D/6b7I8uTeNbTekiOo8pOydJEabd+ajf9yQVdqUfZnsYRHnEATftnrCp
         h458cTnOl11MVqGF8xJHLlEG5YyV4cRNoCTIXw6mn1Bu3FwXC0UpST88aDP0mb4YeFUs
         7y8yjlFqWpadU2rgUGS5LfCWhqG2GmpVNWTLcCfhwgQrNfosHHECLWJudk3gIrUaD9YM
         Eoxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732302490; x=1732907290;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SXjUPW+x9WEmydpNfXc5jwTNlU38YPms/FdHWQQKoZw=;
        b=B2VOEB6S2Jrljn8x1asbOTSo7dOCDRaSTLqrnweaBK7ToE+4XKuSpuexCFTy4ygIMm
         AxUmXexAYv/DujHYSzSouXp/z8UiqLaSJJHXVenLxrC4lroKlh+nYF28pUmItMRF0SuV
         bYZOrMLXUat4FWnb0xqLW6pDSrJopMt3iSlEH74nVjAsP66N3PFCOiNSKFc0Hbu6uT+C
         Oz+6EaF62FG91E4v3khG0KA6BQxWfIJnjtWOrccJhTUT2GIkmH1WepwFujECmeaDH3Eh
         pLP/K8L+YNfmrW0CTq0+T9xSqTbepkzuiKulsyh9hNypLLCbSQHUT46y8Cvcut1QbHez
         Loiw==
X-Gm-Message-State: AOJu0YwJTsgKedHFZvSaYBvPBHvW++2fETQ1f/okpw+49hw9o8J0WJ76
	WNnNpfNjwHaMEn6X862vKLrGOULOZW0vfxcSNoFPk7+XDFTROpLU
X-Gm-Gg: ASbGnctbwb57D/xe7a5ZWQcn8UzunSIRR78ulXdeUBdv8oUs/omZVcA5mv+MY7tCvgw
	nOEWjiFRZ/sTTTieDrBJ6DeT8a6cTL70wuMfL9DOMPymBfoJ3mTVISnJqaYRl1Hsh++Ual2PDfT
	df8ZLSiiRxMoXoXMNtm0dkZ0S73+WpCVCIkXW2QZYq2Gmm8P02c9KYdqYHxV8wjQJGKeTU+oeWF
	PHlPxZvUyRaP2uXV9rFDhF6affCq8PIfp6Ps1zsX8GU5ccJw1Gyw6ISVCMgARlMUHCAvTWsUKCx
	iBqL8pEjH7kwBds0HMqGbYunLdoL9AUNg6zrZHHb7XnWqYenPw==
X-Google-Smtp-Source: AGHT+IEVlEs5VoKBXLCdAPmid1q1ti/3z2dv0Ih7D2qNBqPUKYxtMiVoCCdvSTBAlGU6mVyP7FhT4Q==
X-Received: by 2002:a05:6214:508e:b0:6d4:1238:4bc0 with SMTP id 6a1803df08f44-6d450eebb30mr57102966d6.14.1732302489910;
        Fri, 22 Nov 2024 11:08:09 -0800 (PST)
Received: from ?IPv6:2606:6d00:15:40f8:689a:b10f:19f5:4246? ([2606:6d00:15:40f8:689a:b10f:19f5:4246])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6d451a9a9edsm13016596d6.53.2024.11.22.11.08.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 22 Nov 2024 11:08:09 -0800 (PST)
Subject: Re: [PATCH 4/5] git-mergetool--lib.sh: add error message for unknown
 tool variant
To: Junio C Hamano <gitster@pobox.com>,
 Philippe Blain via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Seth House <seth@eseth.com>,
 David Aguilar <davvid@gmail.com>, Johannes Sixt <j6t@kdbg.org>
References: <pull.1827.git.1731459128.gitgitgadget@gmail.com>
 <74b83caa1e5c1a63248dd4dcbaf2cf450f9cf32d.1731459128.git.gitgitgadget@gmail.com>
 <xmqqr07f28ow.fsf@gitster.g>
From: Philippe Blain <levraiphilippeblain@gmail.com>
Message-ID: <506f944b-033a-07ad-2c46-581eeb9799ef@gmail.com>
Date: Fri, 22 Nov 2024 14:08:08 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.11; rv:78.0)
 Gecko/20100101 Thunderbird/78.14.0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <xmqqr07f28ow.fsf@gitster.g>
Content-Type: text/plain; charset=utf-8
Content-Language: fr
Content-Transfer-Encoding: 8bit

Le 2024-11-12 à 21:01, Junio C Hamano a écrit :
> "Philippe Blain via GitGitGadget" <gitgitgadget@gmail.com> writes:
> 
>> From: Philippe Blain <levraiphilippeblain@gmail.com>
>>
>> In setup_tool, we check if the given tool is a known variant of a tool,
>> and quietly return with an error if not. This leads to the following
>> invocation quietly failing:
>>
>> 	git mergetool --tool=vimdiff4
>>
>> Add an error message before returning in this case.
> 
> Makes sense, but ...
> 
>> Signed-off-by: Philippe Blain <levraiphilippeblain@gmail.com>
>> ---
>>  git-mergetool--lib.sh | 1 +
>>  1 file changed, 1 insertion(+)
>>
>> diff --git a/git-mergetool--lib.sh b/git-mergetool--lib.sh
>> index f4786afc63f..9a00fabba27 100644
>> --- a/git-mergetool--lib.sh
>> +++ b/git-mergetool--lib.sh
>> @@ -263,6 +263,7 @@ setup_tool () {
>>  
>>  	if ! list_tool_variants | grep -q "^$tool$"
>>  	then
>> +		echo "error: unknown ${tool%[0-9]} variant '$tool'" >&2
> 
> ... I do not understand why you strip a single digit from the end.
> 
>     git mergetool --tool=nvimdiff4
> 
> says 'nvimdiff4' is not known as a variant of 'nvimdiff', but
> wouldn't it still be a variant of 'vimdiff'?  Of course,
> 
>     git mergetool --tool=nvimdiff48
> 
> gets a vastly different error message ;-)
> 
> Saying
> 
> 	echo >&2 "error: unknown variant '$tool'"
> 
> may be sufficient, perhaps?  I dunno.

the stripping of the last digit is just because I copied from 
the 'if' a few lines above, where we source "$MERGE_TOOLS_DIR/${tool%[0-9]}".
In MERGE_TOOLS_DIR we have 'nvimdiff' and 'gvimdiff' that simply source vimdiff,
so this works. But I agree that we can simplify the error message, I'll do that.
