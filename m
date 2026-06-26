Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02EE13F6C3C
	for <git@vger.kernel.org>; Fri, 26 Jun 2026 14:32:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782484374; cv=none; b=X6z35Ac7heELvj4IM7CyQdoHawh2I9pq0jxj+xRZ5qVhtwoCYmydh9c3OZp8LwK4w6KZRkgJMMzEaEQckGHEC6rS7fPyNtmDtCbugcEwaw0RSgWNJxhOknFL/STSa5nsLbENogmMCwjSCpBbFK0T9Ed0UhfbPm4UjrgcVo7+w5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782484374; c=relaxed/simple;
	bh=uCDyax/WdNDngkNF9GHXxPfcZy84CjQ16Rv41qMpnYc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SSZG4sjwz4cFkGxdCZuF4bXm2k+zXRUPaUHyej6GB8BLuzdBTQC2dI3nyg/pwvMYE1i5mJkJ6IASoR+B+gYDQLohWgIlnL4D1ggVCehl00WDHvs1mL7QAxNTPGpALajhP+G3TsiKR+aCZrb8ZCTjJNSWZcOvY9l5/yL6NFzBrn4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=b6eD1AxL; arc=none smtp.client-ip=209.85.219.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b6eD1AxL"
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-8dedb44ed1fso9754046d6.1
        for <git@vger.kernel.org>; Fri, 26 Jun 2026 07:32:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782484372; x=1783089172; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=D+5nnWJYIHH2ULqKWz8QorEhgD8Fs7l84UHwf5snDaI=;
        b=b6eD1AxLzIydXq8ZyiMtzT1GJebmQM9IcrNf1GByMoAQYLbEeVQxidv2NjF2NgLNi3
         Vnpj0HpvGe3CPVRLmJlEVC6jVNO+hEbEuSjoSeYMpJ9k0zhDiKPhDhPSgm5Hn5Nn45T0
         cHWd7EfaNpWvY+lyl0xkyR99oQqG9JOFQJXVrXABxQVGVEIwgZ533afSo/+dcAqL61vn
         d+8Q9CzxWE4y2BzxfBW4th+E2fu3vdcyv1/trE8W0RvIZsB6bZvmhOUyIolmzKva7JnV
         HTrQV7fDGOsIzYszdDyhWomCaA3YFJ+0SArM5aCTVO/bs+2nIwNR5toQBVYKOIisaz64
         02UQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782484372; x=1783089172;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=D+5nnWJYIHH2ULqKWz8QorEhgD8Fs7l84UHwf5snDaI=;
        b=tAmVFcRdPM+NNdRTKAI3qZ4S6ktFEEbmHYuU7kXcxOoglcPu8c19rpo9xplkvI0+wM
         oYIAggwMXMafEKQtoecAa+Y1ETyVab++0Rwm4Y5qtns0xLNGftUXRBx5f1+AyhgpeOpk
         PrOPEWWm2NI1oZnTiAIaA8yWRT0sbR5v6MAK2DkFFlYS7sHB2xZB8JfTeZD2TPKcE5Ie
         1feuZLyUzquUzi1zrD3/tPMr2LuIDda97xikNTqLJUMxYrkB7w/cnnlyw5sP2yTGr2dy
         IMp2faP66LyToNTm6JYjPF7AKzpJgGs5UaC6lHNsJe83BBdrzRkrgAxErOUwBrDByisN
         ynlw==
X-Gm-Message-State: AOJu0YxAfFRnavmNUkH38hM3D2QM2ZgyV6OVLFZ9/BdeAHmQnXsJZsFI
	tMUf4ZbfkTPNT0KYDEQtmelB43LWJadtC5pxAReio7iYJ5CrSlqsLfUO
X-Gm-Gg: AfdE7cl4uV1EJRQqMQGlB0N0IK9jRFimOy5xAEWBaxNFqxykIg4DZlHTDTTUlsd9Vam
	FJ4yHvQosfjUzQk6Kvs+zLKmOZVgHDEkOf0ohXe9CEn7MLPdeMYn+r7lnw95hs1CYrqAcf9yENq
	sUK7vEdnuwUYFyEiEzq1ZNXqUkZxdMMDODboxuife+bwR8cmtjY5ZUvOywXYNU6xTaBuOQpAxxa
	JEBR8GfJj7Nbise+ajiLSaf6UpWY1vp2wCE3j4AQQX5SaC1FFeVqjlY+RDiwXpfBYUDjk4UsLd2
	f8W4s+QmMirkDbtXvLh03JzzD89QbQCKB5vfpk3db8e3rJrt0zdkzTiA8YYjUfUYYUgWhgZUSSx
	rfmz8yjWEePTUptyIG02dVilrp8A+jrRWe++OtMo/eHGe5eY1eXEPAprROfvbaqMeT787mMunuw
	8kDlr1CXZVBbDts13EEIgadjE6lUMqKcYhTT3O8KOsHz9/17xiTr1nWqkkV2/u638pUv8s
X-Received: by 2002:ac8:424f:0:b0:51a:7d5f:cfdb with SMTP id d75a77b69052e-51a7d5fd0eamr46459951cf.6.1782484371692;
        Fri, 26 Jun 2026 07:32:51 -0700 (PDT)
Received: from [192.168.1.109] ([136.61.86.144])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-51a51afc29csm97288021cf.27.2026.06.26.07.32.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 26 Jun 2026 07:32:51 -0700 (PDT)
Message-ID: <cb82cb80-291b-4a36-ae83-f308560c844b@gmail.com>
Date: Fri, 26 Jun 2026 10:32:50 -0400
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 7/8] commit-reach: terminate merge-base walk when one
 paint side is exhausted
To: Kristofer Karlsson <krka@spotify.com>,
 Kristofer Karlsson via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Elijah Newren <newren@gmail.com>
References: <pull.2149.v2.git.1782303254.gitgitgadget@gmail.com>
 <pull.2149.v3.git.1782479286.gitgitgadget@gmail.com>
 <f3572a8a89c74fad54a9e53be6f0e34daa2d50c2.1782479286.git.gitgitgadget@gmail.com>
 <CAL71e4N3RPHSrXscwYJUiLWc8-a172h+nE13yuUBRV7Uu3zGzw@mail.gmail.com>
Content-Language: en-US
From: Derrick Stolee <stolee@gmail.com>
In-Reply-To: <CAL71e4N3RPHSrXscwYJUiLWc8-a172h+nE13yuUBRV7Uu3zGzw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/26/2026 10:29 AM, Kristofer Karlsson wrote:
> On Fri, 26 Jun 2026 at 15:08, Kristofer Karlsson via GitGitGadget
> <gitgitgadget@gmail.com> wrote:
>>
>> From: Kristofer Karlsson <krka@spotify.com>
>>
>> -               if (min_generation && generation > last_gen)
>> +               if (generation > last_gen)
> 
> I have to note that I accidentally pushed this version before noticing
> that it now fails for a subset of commit-graph modes.
> Apologies for that - I will rework the logic here later
> to preserve the behavior better.

And do we catch this with a test case? I'm hoping that you discovered
this error through the test suite, even if you submitted the series a
little early. 
> I think (and hope) the rest of the patch series is in good shape though
> and addressed the previous feedback, so any partial new review
> feedback would still be appreciated.
Thanks for calling this out, as now I can avoid trying to understand
this change during my review.

Thanks,
-Stolee

