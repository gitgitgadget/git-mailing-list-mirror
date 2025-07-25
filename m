Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 723C54A3C
	for <git@vger.kernel.org>; Fri, 25 Jul 2025 21:27:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753478873; cv=none; b=DJn+DaeHCbp0epZsERenDAQhaT9owHjSRcIIve+YMdMREtt4B8xpTIx6rbppqY7hYvBNVqgz82JZ7E2fZdn4Y1p9cEEg/9jYZidxqFLmIlMn7VCQtr/ZsmTSzvJLUVU8YNyQxbqO/ckAvOccSOmYdbraxMiQKbUKWnPYq2nYfC4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753478873; c=relaxed/simple;
	bh=a6mJJlc+mEyt/EeH5+hlq4UQZs48uIvm0Ay27ju1o8M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ng4We/8cd4YHsuqTHQQhAvPHUDSbwcRJ0OtPUf83SfaAJ2yha2p0vol+1tkZJG+zt+skGHCHSSBh4eQ+ZulUWZf26MZAQ8cZa9wzojQwybJGFmR8o9xPqUzsKTzpqTc/avY4J/6MKdoJ2GqowuvrnfS61WHVHwa5ZHSQGW469uw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aqXwbV7I; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aqXwbV7I"
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-748e81d37a7so1843411b3a.1
        for <git@vger.kernel.org>; Fri, 25 Jul 2025 14:27:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753478872; x=1754083672; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=RbiXgYrMiJkJhlxLfqRzw+TPFFh0CaJ1tMlwVYwzNQs=;
        b=aqXwbV7IskYLlrOe1swkWt/7VMCnTB8jjHg2fpSN7rTLL9bgsafxCIauV/EJxS+bdL
         6ouIfwXl0XU69sQP2/A0JYZa52tin0PDliqLU+/WlbE9YVrEiR1bacqb3LTYvtBvAFcL
         Gb3Tw2Z7fOuhO+mCziKhlqATnzVVfboqyufy88LxF9ihaz9Zu6QGZn89mvf4D9wPMTbe
         pttt6jp2LhYdPHLY02PArmmmgmnELRbPvJYPzNvo1+7fzFPB55DutLbqE2hTbxadHlYw
         0POlx+2O5J7t/dHRh4R1ObCYUdHor01QI5UJGduhlGiLI9agQ7TVZ8+hJjZbvfmNq8MA
         Yv4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753478872; x=1754083672;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RbiXgYrMiJkJhlxLfqRzw+TPFFh0CaJ1tMlwVYwzNQs=;
        b=RZoR1djTFMQN5GsmzHLb4mk29e61q7wTDvLXsXxISz4FsNdm3jhKnDJbJH5euAy3a2
         AKSDF8TknH5PjjUa/YVtPVPvS+x5vNqYbUCHQCjftjekWROLB635gJ4O4mnImIcCxn1T
         dI0JzJwIogRnxPEGP65QXmxk5hUUJDoO6xWpVYWl/h+OE5AAtHsdst2FTKcMqqrcsbNg
         CarBdC0vh9noDsQwHrX7KfsIO3Ilus3a0CHNweK1OY5I/q/GqWocferTAbSzPebiyIWu
         eBH46r+JygnAdofWthO863wN7WZZ7mOd8trwjl9AgwC1HzAsGYozl5ByNvWfUKYUiezF
         DnoQ==
X-Gm-Message-State: AOJu0YwBLOBhuwZUF01pwfr5P4d/ahNmxGSE2Q7Ep684RnQS6VYEeTwg
	tiq3BbZACoG2KaD/aTxDe4XdLaVt9J+V4RM2MRczhM/2ryh/Ub2TjcoG
X-Gm-Gg: ASbGncudJn4/0L3N1LKoq75fAgtTRbtZnbcIcEoN1h2Y2CwAJIWA+IKRusltHC0XF6S
	0bKKOrFcmQcC153c1cm+hwNOx+pqvnr7+33aEc05SP9EzzSN5M5YJ6osUSjFTxGfGLZ+jlojIeP
	JZ0AIRLYFtXY6N9K6l406KVqupmC7ixhphGrwlOOyUQt3Y5jAQ5gWEwMPyzJ2/rdgP69GBzl1QI
	G+uk5NHYWNuSUAbF7y9bIazgjfinUvRrct2+73QijejT7JY2q/I7JUbM39oKObMyyvh1yIsc+Lg
	GxU1spSPG0YRnVfGu51WMq0AyS1MtYhAyda6l4UZ463DFS3I+nAPSsH/LFLntdOUTPiegFxtGLU
	eHGfV2DeH56ER5eGt2UnYOxLUKTreW1LNPeSrO7a2nLHom3MJi6rmnS+iWNRvsJ8VQ2vK
X-Google-Smtp-Source: AGHT+IGysC25/0AFRaxdkB6+xHPGs1CBjZKsPSKlgk/T3R+OYYicmymycJKsDZg6WD5NewGZiIxE5Q==
X-Received: by 2002:a05:6a00:1790:b0:748:323f:ba21 with SMTP id d2e1a72fcca58-7633636aa99mr4812958b3a.1.1753478871590;
        Fri, 25 Jul 2025 14:27:51 -0700 (PDT)
Received: from ?IPV6:2600:100f:b06e:4b24:a34d:6d4a:f5e1:7b6? ([2600:100f:b06e:4b24:a34d:6d4a:f5e1:7b6])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7640b8adf44sm433475b3a.120.2025.07.25.14.27.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 25 Jul 2025 14:27:51 -0700 (PDT)
Message-ID: <d30839d8-35a2-4670-8f0e-663cf8fbee3c@gmail.com>
Date: Fri, 25 Jul 2025 13:27:49 -0800
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [ANN] git-phoenix - repository recovery tool
To: Christian Couder <christian.couder@gmail.com>
Cc: git@vger.kernel.org, Jakub Narebski <jnareb@gmail.com>
References: <f4b40536-346f-45a1-84ee-99b1200c022b@gmail.com>
 <CAP8UFD10KuuM8Xu5YDxDf+rzN5r0TxgOw=do94dPO51hOCyE1w@mail.gmail.com>
 <fe5d1d5e-15fe-4d00-96c4-d5a4a3b568c5@gmail.com>
 <CAP8UFD19rjmOYR2KZ6qBM2zWMaNJknSdwbOijMRVn-RQoejezA@mail.gmail.com>
Content-Language: en-US
From: Daniil Iaitskov <dyaitskov@gmail.com>
In-Reply-To: <CAP8UFD19rjmOYR2KZ6qBM2zWMaNJknSdwbOijMRVn-RQoejezA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 7/25/25 11:01, Christian Couder wrote:
> On Fri, Jul 25, 2025 at 8:40 PM Daniil Iaitskov <dyaitskov@gmail.com> wrote:
>>
>> On 7/25/25 10:12, Christian Couder wrote:
> 
>>> Thanks for creating it. It doesn't seem to have a license, which might
>>> prevent some of us from using it, though.
>>
>> License is specified in project file (BSD3):
>> https://github.com/yaitskov/git-phoenix/blob/9a88c55fd45f28d4e1865df3ac746b409474eaf7/git-phoenix.cabal#L135
> 
> Ok, I just saw that GitHub didn't display the license information at
> the top of your repository page, and then only took a look at the
> README where I couldn't find any license information.
> 
> It seems that you need to add a file named LICENSE (or LICENSE.txt,
> LICENSE.md) with the full text of your chosen license in the root
> directory of your repository for GitHub to automatically detect and
> display it. I could help people find that information and be more
> confident that they can use it.

Thanks for feedback.
After getting familiar with content of a few BSD3 license files
I was able to commit mine.


> 
>> The tool is also published on hackage under BSD3:
>> https://hackage.haskell.org/package/git-phoenix-0.0.2
>>
>> I don't see much difference between open source licenses and picked BSD3
>> just because it is popular here.
>>
>> What license would like to see?
> 
> It's your choice and I don't have any say in it, but I am happy that
> it is open source :-)
> 
> Thanks.

