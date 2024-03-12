Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63BED79B65
	for <git@vger.kernel.org>; Tue, 12 Mar 2024 15:50:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710258634; cv=none; b=rGnEqNsDbCkpi1nFiiJW9pvm46+xXFGuEtlj8qXF1XJ5o71uHw8/lyHB2Ygc/DywW2TWIMAVAtlKjLgisGuI/yGgDV9wjWsW2ERaMtSJL/y8RhBfheTLDTghG8YDXTfU+sIXDgoTtuUQU1rdRF3lEgIEdSmAcyRablw8BQPIfEQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710258634; c=relaxed/simple;
	bh=9sx1EqrpxWHak7rYBDTUC+yvYt67kp2xC2gF6X6K2VE=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=sRKWdrAZnIjBiiMK7r4GKkOswT71Ny0/eVtqF1BQdvlapXa+Rm99q6wfMGc13nQ3uYCoFEa8UMC6JSip44PNZsVCeJ+tzeftdIW3/ZkgxTbAUyK8st8b25C0FozWkGEg8mdT/STl1QzcBxlHsI1BFihFu7jToYu5wqZJTW9CsG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PH8lQUot; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PH8lQUot"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-413e63dfe16so1022795e9.0
        for <git@vger.kernel.org>; Tue, 12 Mar 2024 08:50:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710258631; x=1710863431; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:reply-to:references:cc:to
         :content-language:subject:from:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=CcoyKUX7mibw7/I1jP5xqwsohnLEiW6L9bXCFgR10zU=;
        b=PH8lQUotFLDi0dA3zUpp0gzK1by28AgQtFNYCKI0BmU1rouL0LFKceoOqV7Lg5dlPw
         NIceR343vsAgkE+6Zq0o5k94SCd5/hL4ORh9d0xFRdyCPlTm6XfTm/mZKeGNkDhBsrcS
         Nbj4gsA6iMwOLEBNhzGVio/X8wpR/TFB9zQl+D2xYTodB3ZSU+r0aOjMtIL0bzJVpMJX
         uMPo1yqGcSPenmpbqSPn3/OfVBThyy4AuHp6/WiATnQDhl76ONZwi7TuKZ5MRXKCeUyo
         Be/7AOvvZ/a7B6WUK4XxRKZHxixihCKCpiIzdsshfMV+YmXE99qot16M0raAcoILXh5T
         DdUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710258631; x=1710863431;
        h=content-transfer-encoding:in-reply-to:reply-to:references:cc:to
         :content-language:subject:from:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CcoyKUX7mibw7/I1jP5xqwsohnLEiW6L9bXCFgR10zU=;
        b=sDWIwjDLqGJDjfTm1nQjMEr816YbGiuznkiBf2ZdQctgJwRPqIcd1/CVpYnlfpquyG
         s6NPB0HlfCH1z12TiZeL/cMjIzMXK9rj62LhC0tTvnMcMJSOneaNLRq9D+mKn2h2e2tU
         XgwzkvaIYGe94NNLNfp6WwUNMAKmrcC0G0nV9PwGgM9VRjnJUUg9xUxRt3eMdCvkUL55
         PKL44Pd8zTgCCAa1uCXU9wMWgFL42UW3tljTCMg2ZBzNcwcjw0KB5Yy6hlwWA1Nk1wJw
         b9adpUGpa7+qsF/1B2M/2SQM1krD9h7QzXsVlpd5l8xJz5YqYIqLhoSMeszuJtWz1Oqi
         5oAQ==
X-Forwarded-Encrypted: i=1; AJvYcCX1hWMGwmG4CfqdtU93HWVJ3+eN9jR2bRMlUBl0id3FP2XMTqnxKxa+YV3On0etqWjmNq0nJzRcBSOQbWjgyl6DISkd
X-Gm-Message-State: AOJu0YzUJh8F9h/zV3EjQhXiwe5p80YL+9bKa4wG3oW4bHUDvlXsbrTJ
	cj79g9KuURdqBoD4p297h408LZ/ug9z9j7q3rSvEkSsBREOz3QqN
X-Google-Smtp-Source: AGHT+IFWqOksl3SmnQaeBOsZDE1fsHhx/gnHEBbvZwjRNppFWc4byf+/EBAym5SOFJNq2xuIiaBQ3Q==
X-Received: by 2002:a05:600c:4f4b:b0:413:42d9:19f4 with SMTP id m11-20020a05600c4f4b00b0041342d919f4mr388038wmq.39.1710258631498;
        Tue, 12 Mar 2024 08:50:31 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:6a5:fd01:2d60:4cd4:e8ec:b443? ([2a0a:ef40:6a5:fd01:2d60:4cd4:e8ec:b443])
        by smtp.gmail.com with ESMTPSA id v13-20020a05600c444d00b00413101235b0sm12853196wmn.2.2024.03.12.08.50.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Mar 2024 08:50:31 -0700 (PDT)
Message-ID: <21c3904b-b533-4c6c-9f62-ca75c084ffca@gmail.com>
Date: Tue, 12 Mar 2024 15:50:28 +0000
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Phillip Wood <phillip.wood123@gmail.com>
Subject: Re: [PATCH 4/4] checkout: cleanup --conflict=<style> parsing
Content-Language: en-US
To: Junio C Hamano <gitster@pobox.com>
Cc: Phillip Wood via GitGitGadget <gitgitgadget@gmail.com>,
 git@vger.kernel.org, Phillip Wood <phillip.wood@dunelm.org.uk>
References: <pull.1684.git.1709907270.gitgitgadget@gmail.com>
 <317bb7a70d023278087f4370b843d7f28f9ee2f6.1709907271.git.gitgitgadget@gmail.com>
 <xmqq1q8khf8t.fsf@gitster.g> <f0c88900-63d3-46ed-9cb8-fc7c3fc07c28@gmail.com>
 <xmqqcys0sm22.fsf@gitster.g>
Reply-To: phillip.wood@dunelm.org.uk
In-Reply-To: <xmqqcys0sm22.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/03/2024 17:41, Junio C Hamano wrote:
> phillip.wood123@gmail.com writes:
> 
>> On 08/03/2024 16:15, Junio C Hamano wrote:
>>> "Phillip Wood via GitGitGadget" <gitgitgadget@gmail.com> writes:
>>> parse_conflict_style_name() that takes a name and returns
>>> conflict_style enumeration constant would not risk such a confusion,
>>> I guess.
>>
>> Can I just check if you mean that we should convert XDL_MERGE_DIFF3
>> and friends to be an enum, or are you happy to leave them as
>> pre-processor constants and have parse_conflict_style_name() return an
>> int?
> 
> The latter.  I was only wondering what the good name for the new
> function was and did not mean to imply that we want conversions from
> C preprocessor macros to enums.

Thanks

Phillip
