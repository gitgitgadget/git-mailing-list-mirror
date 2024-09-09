Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A8F71B1500
	for <git@vger.kernel.org>; Mon,  9 Sep 2024 09:13:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725873194; cv=none; b=PVFzDYL2tkF1phUQR/JrAzPuReR/UnFP0U/HKWomDpaQz4Xd2X7/5Q/rGC1xxr5Hralu4KMjpnYZ5BtFEXwAfLU9fozlJyu5uZ0u/sD9CU2qG1mETOE2oa79lJUm/7lZUyR+EaDfxS0JsqTFN7lFiVxgj/yLhZkEgK4TAjo+Okw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725873194; c=relaxed/simple;
	bh=DbHH6HyuhbGIuv1YGk0oEvxnGsfbb6j4izVS09p2gaQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sLyZ2l9Ywr7MGMbkR8PftcFDJuSZ446juLvtl3mmGW1GI59w346xzHTFJXf+zItCQwplCM0m59wKb5OUrmQLKJYD/xwGqU7wGJtl7iLYOHW89UJfGeWWUuV1/oAFUCW5oJMBvOjElUsH17A7vxcOHubzwZhKmxquMPRG8n4zojI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aJeSg4ev; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aJeSg4ev"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-42cb58d810eso4797555e9.0
        for <git@vger.kernel.org>; Mon, 09 Sep 2024 02:13:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725873192; x=1726477992; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=lvOCMJC98q1pbjHcyk5WYwFt1gx4LD5fAr7a1pkGY2o=;
        b=aJeSg4evz7J3uZcYTV4yiHNEeEfGFWm7fO94VkmYSqX4t2QwWh8FCiWYvzW4YXowc5
         lUrndX3OP4DfL07/QJO809q2QzIxC8p1NonoEC8SFDf44rZvSzc6ToX+MUEY4yna2mRz
         29uV8HeJ4MyUgSBg7rUz0HrBPzwobBZKdI4EcqOU7YmXEl+BrZvOWHI6nYcIAyLtx+oE
         1tE66Ae9OFBow700q44dn5ab4uBzQDRB/DzeA4rGTPPLPrJQo17Yro9j9QqEiociOSS6
         U9auAm+TXEg3Dmp4A7t/mXqEhaRPk44xSyImRK4JjXpl8vemjo1LkM0N4ONfohty1zv4
         LoyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725873192; x=1726477992;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lvOCMJC98q1pbjHcyk5WYwFt1gx4LD5fAr7a1pkGY2o=;
        b=deLuPG5xgPMZVtLua/fiar8nMeDGGbhqWJnPFzuxHT/rSMMBwyB4n2L17gVx9Ln6bv
         x1AHpWGlRfKHrR4QmX7TvYxrYENj55tKqlw9iFFXQlC/G7WAhfzSFRkojWq92LAFvR1L
         UECumOKn7U/57a6DMUOKM+ZqpZ2urAkUNSmjifraiIolkjc9elygK6OLYbWfXK/9uW0X
         qMM7YWoYAhP6ofogwkE09QZWPt/rtHno4U+d1m60ECGFKOIy/Calh59lvBXB7IQYgtFM
         Q9IAEozuz2YklKzwuEXF1OqQynnfB89VLVs6hlC4AHaoSdlchUMhXL/9/RSPxEZiar8d
         yS0g==
X-Gm-Message-State: AOJu0YyDglDCE+bpMo9kfYret9q0heE8YlO4x9TBvVgITK+3P+S/ZcGi
	OX6IYbdBg2D1s0c4mf4jGcM3R7WhQ8pBXhkhmlsINhRwKSzbYYd6
X-Google-Smtp-Source: AGHT+IGSmxKRK/ao2c50qJ//lof/O2yOQXaTuDCi+OJBr9Xf8Nnoq/hhBC5j6mtfy+zZpHjsjxlL1Q==
X-Received: by 2002:a05:600c:5111:b0:42c:b377:3f55 with SMTP id 5b1f17b1804b1-42cb3774148mr21753145e9.3.1725873190638;
        Mon, 09 Sep 2024 02:13:10 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:6d3:8001:7151:e3a9:f71b:e7d9? ([2a0a:ef40:6d3:8001:7151:e3a9:f71b:e7d9])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42cb1b172c7sm56777225e9.35.2024.09.09.02.13.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Sep 2024 02:13:10 -0700 (PDT)
Message-ID: <125aab1b-d017-45c1-b93c-ee43fef9bd71@gmail.com>
Date: Mon, 9 Sep 2024 10:13:07 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: Re*: What's cooking draft as of 2024-09-06 late night
To: Shubham Kanodia <shubham.kanodia10@gmail.com>,
 Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Derrick Stolee <stolee@gmail.com>
References: <xmqq7cboyq9s.fsf@gitster.g>
 <899eb2c2-bb18-4666-98d8-9255dedfac53@gmail.com>
 <xmqq8qw3xvob.fsf_-_@gitster.g>
 <CAG=Um+0X3Umt-2TQ-BGeefqdGxfVoy2Ug0tGKLycrX=_pj=oJw@mail.gmail.com>
From: Phillip Wood <phillip.wood123@gmail.com>
Content-Language: en-US
In-Reply-To: <CAG=Um+0X3Umt-2TQ-BGeefqdGxfVoy2Ug0tGKLycrX=_pj=oJw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Shubham

On 07/09/2024 20:33, Shubham Kanodia wrote:
> 
> I agree — there are rarely reasons to keep a different fetch behavior
> for prefetch vs. fetch all, and `skipFetchAll` should
> do the trick for most use cases. My original goal was to restrict refs
> anyway, I don't work with multiple remotes either.
> 
> I'd have perhaps expected these properties to be documented (or at
> least referenced) in the documentation for `git-fetch`.
> The only place `skipFetchAll` is currently documented is in this large
> master list of configs that are easy to miss —
> https://git-scm.com/docs/git-config.

We could perhaps expand the documentation of `git fetch --all` to 
mention skipFetchAll

> If there's a consensus, I'll switch to submitting a patch for
> `prefetchref` instead.

I think that would be a useful addition. Given the names of the existing 
refspec variables end '.fetch' and '.push' I'd be tempted to call it 
'remote.<remote>.prefetch'.

Best Wishes

Phillip
