Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E2E33F8220
	for <git@vger.kernel.org>; Mon, 31 Aug 2026 12:29:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788179395; cv=none; b=DubF1JCiSk1DANXx3EQIf/op/B7PVlixQcOB8eGTlq5CgHt3LhRokJN5uoGNnQneCA86o4AhBwmayVb2OCgfmSdDhowbBoN86iOo/12Tg1JEqLxLPhFpsyX0v/u/SmtgWktupBX51EAnIoqUHjytnhyHQ0vkPhcr1vLxzC89t6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788179395; c=relaxed/simple;
	bh=1Kacie6ABVA8DdI3ZG/eMojAzdNta/jXaJxYSufzwtE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ISMp8iOwEeKylUJ+WXe5oWnqimtWPqSS1MUcqFWhuTbsLBnr0qfftXHsXuUJROb/ch5PI0KTvii0aXIaYTlFLTxS4twci/WtN8MCkGRMJGEJXtrff5bIgAI5+v9qYPR7ipdiiED0hGfQJSByFe30WUhuce1h4GXUJBjLgsUdhoM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZsO5n2Go; arc=none smtp.client-ip=209.85.219.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZsO5n2Go"
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-90e8535619bso13846506d6.2
        for <git@vger.kernel.org>; Mon, 31 Aug 2026 05:29:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788179393; x=1788784193; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=IU2YnxEmfP9ZaXyNuFN8cGfep0JiHDdEFZDLnaXMjFA=;
        b=ZsO5n2GoebRENUAcqe5T25F9VORl97Sz6QBotwy/0xi3plFIqaUA5AxsPLrhGkDf9C
         EZPdwyhRX315bFZOEfbN+YlndHx2lXS3FDzjk3OTKFwl5eJX6Sqyo/wDFa8CRwNiHpDP
         dNgfAkRgSQWuS5DHVWmmfyoSUyXq4UWAoK00hfigVO54mfiaufz5bThpmSLISo1CI6Wc
         sKONFai5KHRluX7fsYefv16IEO9R6BsM94hadR7+yrMLG543kZBBAmzQ2HhDEmVCCAvK
         nKC6FiyK8ak6qYXzsH5+Lla14KPeIDY4C92G1qyjVgMrRkJbvSsXMV9vIr3SKKO2lN2G
         0AHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788179393; x=1788784193;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=IU2YnxEmfP9ZaXyNuFN8cGfep0JiHDdEFZDLnaXMjFA=;
        b=kzTLwgfS70HY5E8DfCSkWS4vdFxsJ0Qe6WY8jSy65SDYfZ/D3oNNyQX2dWJAZfX5EN
         2EQDgM4/FBzh/UWoNCXctmpDUgdFpo5wOFKppu1vg0l+y9j88qCszGzpva/d4WB8BP2X
         7nVDXF/nR6bz2M4zsf8i2BadulY78BguMObZpdh5+/PzWp5LeGwAUZ1xRZ+NF3aXM31Y
         Scyk531n+jefwYcZA53Nf15SGmX1qGcoUC9ucyzw7iJoBwGhl1EiDJ9KYzHITkpbKcyr
         TYCfsjn8dkldV6o5Ld4OZMIuN1l5hqrr8xt10ZNhbcPwWdsgIS/bIFUfy+7afoUW+Dqb
         7vXg==
X-Gm-Message-State: AFuF++nSxVw5BcG+Uw0zkqUtlXjr77CHlvHnvVmSzH2/3W9lX3C2onKZ
	+ycNikHg8AovOO1b84Q24VzyHDf+D57bZ6yiEsrLNnnBpuMWe/Ov5x4j
X-Gm-Gg: AYBFou0Q9WdE5aWzyFvko7pJu8CFZk3sq3IFlcT82rn7QnLUukEGZw6QyYxQYuhMO0H
	rJd+h2UuPWYFGawf4osiSreFbTDqcnkv73wUmPI5EFF3/LiOu2ATJLQsaKGgMZvea3oy7/vto9K
	r73rEtRsZY9JLDVI/m1imxQ10XhKkfo6puX95wuyEGv1n8Z1lK7jzcLKj/4JedfWV493GGGnjFC
	Qj9IA1ci9eamPz8RepEpTeGWWz7UcvfWQZEPp15RVmi/aZI7uUpcdvivgdw95mUQeGw9frrlSFL
	oM5nWWmHocQZzFKBrHLvZxOQ0XW1n4V1U1TbcCQPxPGwOJue8GBYiuyMJjmij5c6D4Ud+h8Oy3S
	+YV1vjjc+Iklu/RbiOqlFLb0AwWjbW3dqb2CO8rrfuMHaVFF4SN6gUOtrvTQfOZwViTG+ttVBAH
	ifqWXVsVhbgA362KzI85oe5aBTYH6xx5ifMNxUSTFT+a6p541E/LkQuwM2KITFixuo5lzp9rXFT
	lS+Zg9S8SHn1tJb8JUnaPEh3BwrD9aVIUosycaJWflZBGHNPN57d8H9hXRZbqOY9syGUZ8mFcV4
	M6O2fRjbNA7/lEM=
X-Received: by 2002:a05:6214:226c:b0:90e:7fdb:8583 with SMTP id 6a1803df08f44-90e92923e63mr8293406d6.8.1788179393026;
        Mon, 31 Aug 2026 05:29:53 -0700 (PDT)
Received: from [192.168.1.109] ([136.61.86.144])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-90ce87695bfsm74457786d6.12.2026.08.31.05.29.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 31 Aug 2026 05:29:52 -0700 (PDT)
Message-ID: <4f9348a8-b71a-4583-8451-99ade6fced89@gmail.com>
Date: Mon, 31 Aug 2026 08:29:51 -0400
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/7] banned-die: create header for banning of functions
To: Elijah Newren <newren@gmail.com>,
 Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, gitster@pobox.com, Taylor Blau <ttaylorr@openai.com>
References: <pull.2178.git.1784131932489.gitgitgadget@gmail.com>
 <pull.2178.v2.git.1787684181.gitgitgadget@gmail.com>
 <84634717e2eca479026d1cdf39a089a8f61d131e.1787684181.git.gitgitgadget@gmail.com>
 <CABPp-BHtmjSqkgL+RL=nmd1VNqqZ6vDUhQxj0AnEzAHZxznoHw@mail.gmail.com>
Content-Language: en-US
From: Derrick Stolee <stolee@gmail.com>
In-Reply-To: <CABPp-BHtmjSqkgL+RL=nmd1VNqqZ6vDUhQxj0AnEzAHZxznoHw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 8/25/2026 6:14 PM, Elijah Newren wrote:
> On Tue, Aug 25, 2026 at 11:58 AM Derrick Stolee via GitGitGadget
> <gitgitgadget@gmail.com> wrote:
>>
> [...]
>> +#undef die
>> +#define die banned(die)
> 
> Shouldn't that be BANNED(die) to match all the other cases in the code
> (and avoid an obtuse "implicit declaration of function 'banned'"
> instead of the nicer "sorry_die_is_a_banned_function" message)?

Oops. Yes, a mistake during a rebase. 
>> +
>> +#endif /* BANNED_DIE_H */
>> diff --git a/trace2.c b/trace2.c
>> index c23c0a227b..1d0ed2db2b 100644
>> --- a/trace2.c
>> +++ b/trace2.c
>> @@ -17,6 +17,7 @@
>>  #include "trace2/tr2_tgt.h"
>>  #include "trace2/tr2_tls.h"
>>  #include "trace2/tr2_tmr.h"
>> +#include "banned-die.h"
>>
> 
> Is there a risk that future folks add new includes at the end of the
> list, then functions in them get added to banned-die.h, but are
> silently ignored because banned-die.h wasn't the last include?

There is a risk. The "must be last" part is documented in the
header, but maybe it should be in a comment here, too.

Thanks,
-Stolee

