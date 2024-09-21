Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89DD6F9F8
	for <git@vger.kernel.org>; Sat, 21 Sep 2024 13:23:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726925019; cv=none; b=iU1Hno/BHW5h7P2/uxyQXlkUZixVMfLr8zBIGwbRf+kIghipr2ycs8JtvAf+uyaxfSqaKkMIVrgLoGHC1fr9JdVzuyUxkzdeypV0RHKTI7wKiRrwgHsJRGZQB/UiZzAq6qD/2NqjQ3mA92vZuiw9lUavVU8WMUvqom7Z/NvHXF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726925019; c=relaxed/simple;
	bh=de+NCz2DvCG0QDB/c9vBPbXwsOSF+I7cXCEzk6q/VsA=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=fzRRj0qHlwnGH7zF7SZMGMeT8sonoS+DCxBpSvPl4+1f6HEiWKTBOdjgndlg671Z6cH6fHAPOc1EsH/FVVPXUibi2h9GEbdvQ5eOZUxZSu8VF/T7LeWil9yn44k4ahCfcr/6JoO7jPhWAF29fTqznn7TonyAyG0xEFH9ZCbW0/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=k3ZL5UOy; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k3ZL5UOy"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-42cc43454d5so23120365e9.3
        for <git@vger.kernel.org>; Sat, 21 Sep 2024 06:23:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726925016; x=1727529816; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:reply-to:from:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=I8pnHWW/0kfVWWQSj8ulbCF5w9XAWh30IYeXm82xtuM=;
        b=k3ZL5UOydCdGyHDhMo+urMP/WyO8jTp7didMIkysI80I9QRJfyH0LV6b+zc9emZ68u
         ABeCNkqwUXBZB8Crurqh9/pNQV0BtueE7xnA8x/MdfSbkhwNXYZkkGcCMXclMHr8OaO2
         aczfZ68Ld4kIk3L5iWe2m5ifLaHj23aUaSk/qSlFqw2h/RPQxJi4lvjHCbZILaggymz+
         UNRU3p71lX0cCDfQVzPQsyBK9agls/hrotznjPBCA9FLL+H/aOvbIyuxP1eKcTGP8zuh
         PhEvVOTyXrNVFtZD3vGbYY+zNfip+/w4ihelZJK15wbrmNXerQDR+ncud8O8EufGHtrU
         YA9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726925016; x=1727529816;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:reply-to:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=I8pnHWW/0kfVWWQSj8ulbCF5w9XAWh30IYeXm82xtuM=;
        b=j9tgM0i04ulcKVzzC3GKrPStOfVmgCd4K8A4Z28C+xjKVuIE5D0nyJCJWiAc2ugYTN
         Dp4gb/aNrQoh9e81w1/oWGTxD9BVjYOeHi2sopN+VO2C1oPO+5P3B5rbsyNAh3OeYg64
         xPjYmp4pvKf2yKJJjerOfpPo/TOtt0kq/79qCrpEOwxxpBtZwXO9Wku1K91Y4lNFZlVO
         rGqtKWzToTM8IuyHFMHjgAMr/jRN2ONXqeIC+6FSd6HxPmbXRtg+ctnq1F7IS8CfWzaY
         i9OaJQLU3Z+1dQMlHZPgmqpXWeN6zZpWclwjnDIXCPDbyEAzEAz0u5+29P+n9p828Fk8
         tzLA==
X-Gm-Message-State: AOJu0YzXYx/1y3SmJhfdqYlYtlahD3ZtnHy8AzmeliawdNRYJm2OC3vK
	Er9UYdxtKhgT+VCCwt1luRdv/pyYMO4FKf7fgI66FBCG8pCjfSRi
X-Google-Smtp-Source: AGHT+IE83PUJycTowxGDgu4MZMx6N5XnH4qfF5po9KcfeZ8Xu2gET05CgcSHbnBCCIRKU0/cQquGYQ==
X-Received: by 2002:a05:600c:4e86:b0:426:6a53:e54f with SMTP id 5b1f17b1804b1-42e7adedcefmr41216225e9.33.1726925015625;
        Sat, 21 Sep 2024 06:23:35 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:6ba:6501:244f:f1e2:145d:427a? ([2a0a:ef40:6ba:6501:244f:f1e2:145d:427a])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42e7af898fasm50242145e9.15.2024.09.21.06.23.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 21 Sep 2024 06:23:34 -0700 (PDT)
Message-ID: <ae114c58-2a9b-415a-9f47-312e4d080492@gmail.com>
Date: Sat, 21 Sep 2024 14:23:34 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: phillip.wood123@gmail.com
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH] submodule status: propagate SIGPIPE
To: Junio C Hamano <gitster@pobox.com>,
 Phillip Wood via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Calvin Wan <calvinwan@google.com>,
 Matt Liberty <mliberty@precisioninno.com>,
 Phillip Wood <phillip.wood@dunelm.org.uk>
References: <pull.1799.git.1726837642511.gitgitgadget@gmail.com>
 <xmqqfrpuf5u7.fsf@gitster.g>
Content-Language: en-US
In-Reply-To: <xmqqfrpuf5u7.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Junio

On 20/09/2024 21:06, Junio C Hamano wrote:
> "Phillip Wood via GitGitGadget" <gitgitgadget@gmail.com> writes:
> 
>> diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
>> index a46ffd49b34..a8e497ef3c6 100644
>> --- a/builtin/submodule--helper.c
>> +++ b/builtin/submodule--helper.c
>> @@ -30,6 +30,7 @@
>>   #include "advice.h"
>>   #include "branch.h"
>>   #include "list-objects-filter-options.h"
>> +#include <signal.h>
> 
> Do we really need this?
> 
> As with any other Git built-in that relies on git-compat-util.h to
> handle such system-dependencies, direct inclusion of system headers
> like this is highly questionable.

Good point - I really need to figure out how to stop emacs' lsp mode 
automatically adding includes. I removed its "helpful" addition of 
<csignal> but forgot to remove <signal.h> as well.

Thanks

Phillip
