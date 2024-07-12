Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EB2F17107F
	for <git@vger.kernel.org>; Fri, 12 Jul 2024 15:24:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720797882; cv=none; b=Hl5AhHVep/q5veFf50e3cwL+Em9EaGJtwpRbv0r0pHC46seWUDF6GupzAAceh8uj9W/8FYbjwqiL7UZU58FzLyi5OE/43d8aW3JUQrqaiwuel+XyL9r9UiJ5iJGN6NZj1UfuuR24+9i8XvOR8qoURkQDdWbV9+FfAsve2nh0ayg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720797882; c=relaxed/simple;
	bh=DKaw8ALMvMXUAN2Io7NtzPsRT8twjGNBUdLW3O5zeEI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=t4mbosyszeHZ+tyma44ymqfYWeVodfl/jE0zqHNlCX5KmsdEUwkXnbv4/UVAjLJo6nynfLc47O7f8eMGU3cwmLyFpB9oKTUFGopETcHtVOTDv8GLTIKABugiZZReKOmXTxQe+i0oK1uZJNzvV4tda7b67wUUljHypxD3darMYAI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BFv7sboT; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BFv7sboT"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4266dc7591fso14961585e9.0
        for <git@vger.kernel.org>; Fri, 12 Jul 2024 08:24:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720797879; x=1721402679; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=fqShiiNIZw/RVC0oFJvWRV8MvsMsHDUUcz2dHqRLtMw=;
        b=BFv7sboTKFF2W1KpJbySs6HwPhSUfzZWF8ZNPXXOjToOzKN6uh+3UhKAHX9fxB1CdM
         zcaJqq1WkKEcwpkPWYwCasvMxpvlYIpOFfq+B30km2B4FG8Ge7IF8YoebmjEwOQbBXC4
         cYsj9DpSvxVqI5xKSbbfdDWcY5g8KTFkb0U3WTIqcjgEn83yJzDZYlBgU8lwWE1QuABn
         zzRK8t65CtOlUaLYE2LbklkkTitQb6yoBzbRDGk3HF7iSZQzrCxviHaqh0PWApk/PKAN
         ULohUYc1fANLvsphP9GH0lX5juj6tx7+zorruM5ASMBnhvSHpzXfNZhhBx+w6BnQ5+KX
         bWDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720797879; x=1721402679;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fqShiiNIZw/RVC0oFJvWRV8MvsMsHDUUcz2dHqRLtMw=;
        b=RJN5EydVPKumlHfcPCTCZRYtbfyBFcvqGB7qpDecgrPcaHSTf5IFWVLBv+P4iKr3H8
         HJwiRLLjrjyxg2bqWummV8dVBTYTdL5yqzpW+jr7zvYJTEARmoIIB8PtSijBt61WHXFq
         Say6YIdminyCCvJ6d7a+l2+EUsyvY1eEJ6X4beStVCw5Vogcl2zI/8RCekGjrXWej++0
         ZhyLqKiQWX8s2ISStnF57Vkyns3C48JUjbXb3wh/7DoVAwC275maplJqdAJZZZwdS4p9
         1r344XpcqbGU8UsJKwOpDxch15kmqi/ZVSFZp6+2yqQzFti13O51uj86w1asZg3nkw0O
         hqGA==
X-Gm-Message-State: AOJu0Yzj+qP/8JtP1P+GWpP+RxijcNSQRYYVhdEobxMpWliicGponVEz
	mvdheW30HPCPfpAjm8RkaGBz8OhdZyJM037Gb/X9oRpjR6weda3P
X-Google-Smtp-Source: AGHT+IFqAnYkw3ppfcEqkXxFgsiCRa4HVHdud+j4PcqcPLVOdQXBbaLJMO6Gljdf6gBAFFl0A+B6dA==
X-Received: by 2002:a05:600c:4342:b0:425:5f0e:bb69 with SMTP id 5b1f17b1804b1-426708f0ff6mr82747725e9.38.1720797878764;
        Fri, 12 Jul 2024 08:24:38 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:600:8501:575d:f6b:be83:bc74? ([2a0a:ef40:600:8501:575d:f6b:be83:bc74])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4279f2d7c9csm26524705e9.48.2024.07.12.08.24.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 12 Jul 2024 08:24:38 -0700 (PDT)
Message-ID: <12830e1d-598d-4e7d-abd6-3349800e277a@gmail.com>
Date: Fri, 12 Jul 2024 16:24:34 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH 5/8] clang-format: avoid braces on simple single-statement
 bodies
To: Karthik Nayak <karthik.188@gmail.com>, Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, jltobler@gmail.com, chriscool@tuxfamily.org
References: <20240708092317.267915-1-karthik.188@gmail.com>
 <20240708092317.267915-6-karthik.188@gmail.com> <xmqqle2bj0dl.fsf@gitster.g>
 <CAOLa=ZSb_S7X7pdFPp0r5bfNc3o95mGe5pU+rC1T_yM89NRqCw@mail.gmail.com>
From: Phillip Wood <phillip.wood123@gmail.com>
Content-Language: en-US
In-Reply-To: <CAOLa=ZSb_S7X7pdFPp0r5bfNc3o95mGe5pU+rC1T_yM89NRqCw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Karthik

On 08/07/2024 21:25, Karthik Nayak wrote:
> Junio C Hamano <gitster@pobox.com> writes:
> 
>> Karthik Nayak <karthik.188@gmail.com> writes:
>>
>>> Set the 'RemoveBracesLLVM' to 'true' which ensures that we avoid curly
>>> braces for single-statement bodies in conditional blocks.
>>
>> Hmph, two warnings in its documentation [*] sound ominous, especially
>> the second one that says:
>>
>>      Warning
>>
>>      Setting this option to true could lead to incorrect code
>>      formatting due to clang-format’s lack of complete semantic
>>      information. As such, extra care should be taken to review code
>>      changes made by this option.
>>
>> which implies it may not necessarily a good idea to add to
>> automation without telling contributors that they may get hit with a
>> false positive (or incorrect rewrite).
> 
> Agreed on this one. I'm a bit skeptical to be honest too. I think I
> should have added information about the warning in the commit too. I
> will for next round. Overall, this also contributes to the reason why I
> decided these CI jobs need to be allowed to fail.

I'm a bit confused - what does "allowed to fail" mean? We don't have any 
automated requirements on the CI passing. We don't want to train 
contributors to routinely ignore CI failures but if they don't get a 
notification that this job failed how do they know to correct the 
formatting?

>> Reading from the examples in that documentation page, it was unclear
>> how it would handle if/else if/.../else cascade where not all branches
>> are multi-statement blocks, e.g.,
>>
>> 	if (A) {
>> 		do_A_thing();
>> 	} else if (B) {
>> 		do_B_thing();
>> 	} else {
>> 		do_C_things();
>> 		do_other_things();
>> 	}
>>
>> but looking around I am getting a feeling that the tool would do the
>> right thing, i.e., to match our preference that is to use {braces}
>> around all branches, if I am not mistaken.
>>
> 
> Yup, that was my understanding and what I could see from some quick
> trials that I did too.
> 
> It would be a great win to have this though, because it is one of the
> things that always get me.

Yes, having the formatting automated would be really helpful. It is a 
shame the documentation doesn't really explain what the issue is (i.e. 
when does it generate invalid code) so we don't know how likely we are 
to be affected by it.

Best Wishes

Phillip

>>
>> [Reference]
>>
>>   * https://releases.llvm.org/16.0.0/tools/clang/docs/ClangFormatStyleOptions.html#:~:text=RemoveBracesLLVM
>>
>>> +# Remove optional braces of control statements (if, else, for, and while)
>>> +# according to the LLVM coding style
>>> +# This avoids braces on simple single-statement bodies of statements.
>>
>> "... but keeps braces if one side of if/else if/.../else cascade has
>> multi-statement body."
>>
> 
> Makes sense, will add.
> 
>>> +RemoveBracesLLVM: true
> 
> Overall I must say, I'd be okay if this patch is also dropped from this
> series.
