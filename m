Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7E6A1BD03B
	for <git@vger.kernel.org>; Tue,  6 Aug 2024 08:44:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722933850; cv=none; b=cOOdYlWMETRStC/UfTX1MEF54RIxE/HZkAY2vRfN5iO+vqMSqZ/ogVjI/7BZ35/nigjoimoK2RZac7zxLkRhIixmmLkwVf0xVmTfql/vnnvnQX/sxYmCpRaoJMIi38IMv3I7to6qGBKGC/gvmU1lXaRaxeLDOI4iCSFEPayufso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722933850; c=relaxed/simple;
	bh=DJuqahaUx/s18WWbHPWO4pmrp7w8+XXVOl0w71jcQ/Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=icceJgcPaP340XW7tbHhjR//ndwuFj7yPgpcnOTIXPsnAqvPkMca3wrtm5eRPPd+61rMQbj25Lw8+waEw6v14mThUBx5q3l954cQB1V1X1qM76I0WTMRhLJkVTeneVcRg7Wk3IpsGOaMNe5heRDmRWk8hbN9pUUjXTQR/3CopKQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bPMBSLUQ; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bPMBSLUQ"
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-5ba43b433beso344705a12.1
        for <git@vger.kernel.org>; Tue, 06 Aug 2024 01:44:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722933847; x=1723538647; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/Qo+I0wwsWk67doUD7vVNZxHCSrWKMedoql7i4oea/g=;
        b=bPMBSLUQGZnbKhXaTQJ5+xsm0yt92s+MY83zGQQyetGZkHeYLqMk4t9VPiL5XLVkiD
         Dv3m5Bb7FtXIK1ZrKphgE8GaKCoGovRNsaUDoHUm7O40mLXuzltzIAs+yHnOvdF/FK4N
         l3VDqRW05uOKRwq6U+aKsuSEdpvNT/tAWX6oJOorWrVIy373lJloNOzcirF//DWP+F3w
         fskzItKpsEHivGHDsWuQ7gc4//tXfiXXjdCMGaVp96utedccKRWKefNOOzCndyedKEP0
         HhKQN2Fb4qEm5YRDEfVsI0o3+VTQjpvexf8S0X3+xObqd+rpz97LrEbtynNS+PgjvnqO
         gvmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722933847; x=1723538647;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/Qo+I0wwsWk67doUD7vVNZxHCSrWKMedoql7i4oea/g=;
        b=fra6UoGOTACF7dUt/qqbQJmftxzi8syiVdL6h1QvtbJBT29JZJj2SDhI8qAj5OLHBA
         MfUZDTMA07Kosl41HlqKIuO5G612qv5S5BGTvpzRoxnWyCFS+v6c7VNuqnV7wkqEo61Z
         SAcgFv2xpVgwgWq7UzW3PBeosfP1Vv4BNyOK/XR2kAD9Ywm2BqUoJrtnFYXR8s0eER0k
         SROc+ZCZagYwqSS8M9WOG1X0ESUYJU/zLUXzhAqAkS7IUzw/+lM8OC733X1Ih6jJsPWi
         Nul3wrrykIP/D2+i4FuFNEgcUulBSsXTEuzJeXiWew5U7q82ZzrGPJPTj6F2zeW69X5B
         76WQ==
X-Gm-Message-State: AOJu0YwkdDJ+Y36311Yd1Z38lrG2JQQbonjB7WQJkvjnrkKC0f+DZyd7
	neUeJ8lkhyeyoMbsSfT0aAt5nHWcd3aGS0itWZ0q1KeG8Qgn0pnEzuM9JsfW
X-Google-Smtp-Source: AGHT+IFEzj2YanUiGjkPQuOSJrJPhjOYBCqfp0sKQFvN9El+8SOnDDBqRSNJ8JjSOTzZZNmv2WlryQ==
X-Received: by 2002:a17:906:cae2:b0:a7a:a30b:7b95 with SMTP id a640c23a62f3a-a7dc4fdf40emr1026679966b.2.1722933846631;
        Tue, 06 Aug 2024 01:44:06 -0700 (PDT)
Received: from [192.168.1.6] ([197.40.163.172])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a7dc9c0cc4fsm531985266b.77.2024.08.06.01.44.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 06 Aug 2024 01:44:06 -0700 (PDT)
Message-ID: <749fcee3-5bb1-49ff-b476-6bb75f4b92f8@gmail.com>
Date: Tue, 6 Aug 2024 11:44:04 +0300
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 0/8] t7004: Modernize the style
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
References: <20240805235917.190699-1-abdobngad@gmail.com>
 <xmqqzfpqzdgk.fsf@gitster.g>
Content-Language: en-US
From: AbdAlRahman Gad <abdobngad@gmail.com>
In-Reply-To: <xmqqzfpqzdgk.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 8/6/24 03:45, Junio C Hamano wrote:
> AbdAlRahman Gad <abdobngad@gmail.com> writes:
> 
>> AbdAlRahman Gad (8):
>>    [Newcomer] t7004: Remove space after redirect operators
>>    [Newcomer] t7004: Do not lose exit status to pipe
>>    [Newcomer] t7004: One command per line
>>    [Newcomer] t7004: Do not prepare things outside test_expect_success
>>    [Newcomer] t7004: Use indented here-doc
>>    [Newcomer] t7004: Description on the same line as test_expect_success
>>    [Newcomer] t7004: Description and test body seperated with backslash
>>    [Newcomer] t7004: Use single quotes instead of double quotes
> 
> As you can see from "git shortlog --no-merges --since=6.months", we
> do not capitalize the first word of the title description of each
> patch.
> 
> Also, I haven't looked at the individual patches, it seems the patch
> is somewhoat whitespace damaged.
> 
>      $ git am -s ./+ag8-v4
>      Applying: t7004: remove space after redirect operators
>      .git/rebase-apply/patch:169: indent with spaces.
>              git checkout stable &&
>      .git/rebase-apply/patch:193: indent with spaces.
>              git tag v4.0
>      warning: 2 lines add whitespace errors.
>      Applying: t7004: do not lose exit status to pipe
>      Applying: t7004: one command per line
>      Applying: t7004: do not prepare things outside test_expect_success
>      .git/rebase-apply/patch:1188: indent with spaces.
>              git tag v4.0
>      warning: 1 line adds whitespace errors.
>      Applying: t7004: use indented here-doc
>      Applying: t7004: description on the same line as test_expect_success
>      Applying: t7004: test description and test body seperated with backslash
>      Applying: t7004: use single quotes instead of double quotes
>      .git/rebase-apply/patch:133: indent with spaces.
>              git tag v4.0
>      warning: 1 line adds whitespace errors.
> 

Thanks! I'll fix that and send a v5.
