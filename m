Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D040C439006
	for <git@vger.kernel.org>; Mon, 13 Jul 2026 16:39:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783960797; cv=none; b=l8R4spXMTuYAJImP78UN1UsTvY593ziY2brH6HXoI7qF5iYs+6dm380pdwhrylUJxw30G1Iio02SvLYsgY+foo6IWdwrF185gr8Anz3FbZSLq1PLW1uQzT5hPOl11HBuymye1WBb4onW5SL7Ky9Qiv/lxuFOpWAGiQ9Q3KsrvYc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783960797; c=relaxed/simple;
	bh=sjgxKRthNhIVJh1hp3CusUttM1sa/opX6zd8UqLSVx0=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=dpsmYlakv4goWQxf2shMWDQ7NIw+xBAMP4OTHsHpnvMH9GeV0qjb7xI+BJuZxXWVMRoa9GJqtXTpccvjRrNhOvuu1WT+pLCzmXcfAyFpdkc3k0TZ7zf3fKF/uCTcyyjzTVqKQweBn+R47J11No48zdw2+2piIFmGsGI/7hvrYZo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P9K0NhS8; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P9K0NhS8"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-493c19bad03so30909645e9.2
        for <git@vger.kernel.org>; Mon, 13 Jul 2026 09:39:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783960793; x=1784565593; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:reply-to:cc:to:from:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=rUy9eNG8i8pbnsstLruukP7VNt05PUytnLscmHlguUA=;
        b=P9K0NhS86HEVM9RIVdPtB4gKCm0rwyObLuNl2Nw51bvXzHcTX29glLtEiPWGXCBbo1
         3nrcAypjbuk4ahcLbTSL7wjPCcqbGRJXorIDlM9l0Fg25+z84yJBI/RL9/PhBkaDrKUW
         +lsCkMOQv0sefeBrcwm732XPJ3j8+2ArccehDWm3gH5rUuUDVgLy0eVQEJiAwv4P40pa
         mugOqgbuz/62Pn3qbBueU/RuFrafbvv93JwHcp1bg7Me8NKgAGUC3s+7kcwTJE7SGCig
         8xGp6vI5SLzZK8qOYCRhp6oYQlWVBgNWG5n2R5IYCj/Cawz+aVIdnoQP2uTsRfZrfBtq
         aw5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783960793; x=1784565593;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:reply-to:cc:to:from:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=rUy9eNG8i8pbnsstLruukP7VNt05PUytnLscmHlguUA=;
        b=Nn7gjLhmXdmXRVchtkc4XOwNP2yY3HZZP+Pyyqfs2iweWfEvNgb4YooA/nXRFySu40
         zQoNsjZ1sgMnb43k9nLIOd1f36lNmJl/5buCbc4d383bkumc3CEXVxM2Wg8lOFqN4st2
         2CpIfiPDqu0F0UyhMLMVo0fmEfUdaODR9admNM4w/RoHgGz8KNXGRLFya2velVkuuyQs
         FDg5H0kMQbwfl4DmH7nXNemPYk1gHgommqfwr4UWADjl9GO7Qj5QiZi0jMcuh26z2jR8
         H2LjA2cVRp6ltM2+BH126vDImJ9OCcr1sFERl8x5W8vbMGuhi24kSm7SZH2LP7GoI/mo
         m0pg==
X-Forwarded-Encrypted: i=1; AHgh+Rqdq4EHlul8Ms6ZhxIL90s1MiousGoEmsgmHok3sIQkcv3MJp8Tsb2gSXAwZLVZ2y6CnnQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyhs+kdc+wptkFLL5YjGFwzkpFwXJsSmWZBlAsGkDgBfJDjqI+v
	waiBOgtRyqJtAXZWl/qXrYiau6jiRvFxcE/Z+mSspnCNZ1Euuep1J3ti
X-Gm-Gg: AfdE7clDEDDJ28/9TTdBAdjnGRhFhXaORkPz/MeCr6CWJhxd6eU4MwC3hyTgEAmL8+p
	gXD/L9DqCo0v3ucyXng1QDcLWGWf4wuEc4kJy0mTeA7pL5RRFsUvv+BI+Xh4dfrCeqrEaYguWvb
	nlli3yi+ZpJYjUq8RsnJIydO6XHarf6RJ3Pd6HDiHZVU7rMwNr2tvVm9D7gjBJASrerUpxmkn7g
	rHeZS+7xN/vlQcW73+TJ05KMIPOK3xE78hKyPqhi3IPUcSp6KyvPPjxLdAaMc/iVTOr3/Iu7+Du
	UKbJlorjJLIKMZ8D/o2r1xXDNN9CYrcWeRHaJ6vKHSNSxwViT/ah7/rxAX740zvCoQ1cfP7JaPw
	+TkJEl9BAwU/2Q5gYmWF/KCPbupvSy0irYYiJPwN/QRUZkQe3j8vGfOrwhliY5KYaptDjWW79a5
	q4/2veNhgGNobOMX9cC4a33GZVoHTi0WiW3HjBKAO5bjYNuc4jE2nMTAosHPuuOubEZgxXeWM1
X-Received: by 2002:a05:600c:4708:b0:492:67df:3dfa with SMTP id 5b1f17b1804b1-493f883a7ffmr100280125e9.34.1783960792894;
        Mon, 13 Jul 2026 09:39:52 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:69a:b801:79cf:bdf1:be6e:e3d6? ([2a0a:ef40:69a:b801:79cf:bdf1:be6e:e3d6])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4950873270esm7379055e9.6.2026.07.13.09.39.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Jul 2026 09:39:52 -0700 (PDT)
Message-ID: <279e6d69-191b-437a-b1b1-ecd879343f3d@gmail.com>
Date: Mon, 13 Jul 2026 17:39:56 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v18 5/7] branch: add --delete-merged <branch>
From: Phillip Wood <phillip.wood123@gmail.com>
To: Harald Nordgren <haraldnordgren@gmail.com>, phillip.wood@dunelm.org.uk
Cc: Harald Nordgren via GitGitGadget <gitgitgadget@gmail.com>,
 git@vger.kernel.org, Kristoffer Haugsbakk
 <kristofferhaugsbakk@fastmail.com>, Johannes Sixt <j6t@kdbg.org>
Reply-To: phillip.wood@dunelm.org.uk
References: <pull.2285.v17.git.git.1782113388.gitgitgadget@gmail.com>
 <pull.2285.v18.git.git.1782338106.gitgitgadget@gmail.com>
 <a84c555d99c98abcd4618833c14fa35b191fbda2.1782338106.git.gitgitgadget@gmail.com>
 <e35f1268-2518-4a44-9c7c-28ba13ca7b7b@gmail.com>
 <CAHwyqnU0ifHu0+GfMR9GqWKgFrTOyQn-FbUH0wTm_07nCa26tA@mail.gmail.com>
 <CAHwyqnWspUTSnqmkMyXtWuAnENDSzrRLhhUR=Ljtt1xer3tphA@mail.gmail.com>
 <5212d968-6121-466c-8225-36b4bad6b211@gmail.com>
Content-Language: en-US
In-Reply-To: <5212d968-6121-466c-8225-36b4bad6b211@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Harald

On 13/07/2026 16:39, Phillip Wood wrote:
> On 11/07/2026 20:36, Harald Nordgren wrote:
>>
>> Digging more into this, probably the most elegant solution is to
>> replace mainline with main, but then also do this:
>>
>>      git config branch.main.pushRemote origin
>>
>> This exposes something that I don't love about this feature,
> 
> by "this feature" do you mean "git branch --delete-merged"?
> 
>> which is
>> that when using a pushDefault (like we do in the tests with 'git
>> config remote.pushDefault fork') if not adding a special case for the
>> main/master branch (like 'git config branch.main.pushRemote origin'),
>> then it will get cleaned up as a forked branch.
> 
> Oh, so because the default push remote is not "origin" we need to 
> override that for the branches that we do push to "origin". That's a 
> pain, but even if we did add a special case for the default branch, it 
> would not protect other branches like "next" and "seen".

Thinking about this a bit more, rather than protecting branches where 
$branch@{push} == $branch@{upstream}, perhaps we should be protecting 
branches that are merged into their upstream but

     git push branch.$branch.remote $branch

would update $branch@{upstream}. So we'd apply the push refspec to the 
branch name, then apply the fetch refspec to that and check the result 
did not match the name of the upstream branch.

Does that make sense?

Thanks

Phillip

