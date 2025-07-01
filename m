Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3BD0270EAD
	for <git@vger.kernel.org>; Tue,  1 Jul 2025 10:00:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751364002; cv=none; b=DZ3mzsh7giEho41/IhclRyyJniIQan2Selv1KwdKAMShrBZaiZ2CCIJVI5XpwbKJKOPgnc3qVwPytLK9uAIgPuIHYO7HfseQ1zadOGxQKuac/dOjRkhoUdEIkdLGv+ru3l8sL5yajHhSKrCg7MXvbHpctjb2DN/5rC00AN3Wkbw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751364002; c=relaxed/simple;
	bh=xvOKRGAYl+kxxE+LKpP1xpGE4H0SW4UMs5E7TOU/gq4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Xrs4uxIkiq0TTrsoZnjUFN1WjGpQDNvTjSeTLGJvNaB9z/X4UmgG1OJKpvYR0+k4hwZFD3iG4CfSyCVOrHOWcg3N5cA5vW3FDN9Vn+duDKD5JOj7Bh3uig6JaMzjj4GPMShTnV8a5YN6LGeLuBlSfAT6f4DXc3VySgDWTiuwPdU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nAfSSMD5; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nAfSSMD5"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-450cb2ddd46so31205035e9.2
        for <git@vger.kernel.org>; Tue, 01 Jul 2025 03:00:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751363999; x=1751968799; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=TMA8FQ0D52VUSnyK8qljVJMbafXDGXgCO90bjXhdJe4=;
        b=nAfSSMD5eks04fAHY9RVEY35N4ZLFYzZk5h6ncuAOe2f1Iobafk5QJdJe2SWav3CL4
         LpYsUm4U0zuRRnL48nzUkcm7Dt1vlKPs8MsPIDO3KFi71EHBbc8zuqPy8yYrL4sbHbCu
         rGlbs1m/5lelx46Aygq3T6b9CqtaZZhHrrLkINEVy+OBUh03yDH8LiMUQtyk6YpOrJ0W
         IJLdxdCsUPdd+4oobGlfd0pha9D9kvpveOH7cKUn3Y5pYEkdY2IPwPFVXx7WNsBzlqvE
         ufz1IU58G18iuVqRWr/d62/Liwt7OwLDe/wDgOVUhrwHbdOCdEqBp65/tsdKAY+ZpSuy
         zicg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751363999; x=1751968799;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TMA8FQ0D52VUSnyK8qljVJMbafXDGXgCO90bjXhdJe4=;
        b=uzLsucMWfCFY4YF/6YhiSqnvc1As5QGdx4z2akr8txOtR7uSSafN9ksVjE+CCc3wNR
         vkQ0fgHf9AAHIYtB618KD8YZZScf3PxwaxqKUR3lpKWQYWJbiiUeOBDYIX6jFnO9IAG4
         XT5+QDtK780WSGSK3R2Ohjo8lauccvIzp8Oq+icLFKDs0TJ9yLOrku79pjsnAUh9U0PO
         r/36Ircrbwox5prW1eNJA2ACgCVKr2Zsjbe37ZeC8eWHL4L3guR7rXWXPXGzBdv4wTEh
         ijKy1TMU2qWwXjMnF5Z14zTlFDWJFr2Lo+vVECSJZEDz4lDxjjynkXWknNjWLwdEVbgY
         zrMw==
X-Gm-Message-State: AOJu0Yyp27zcxOc7O1ufSg51fTdFdXvXYoszjIkujvN+vYDV3Dj8d4J4
	hOb/usAPOEElQ8Yvg3T6/oPclot/nDd5aW7WNNzQpBPaHo8O8oLAqQLP
X-Gm-Gg: ASbGnctxo+SnT3re+Rq0b/WuSMp1DuwJqHsISMDxggy83/c7lFFQb2mKq9nxm5Uz2fq
	jD8l8W5QsvO8/rc2LwdPC+KooLvzQMFlea2DwRd5XGxAcKdArZyJLywk2IeYqR/9Zfy1KG+jJQk
	B8KX2U/Ei96qFhu1cN0TqKhd6HAd4MVH4yxibOm7FqzXs0iJVflhOtwjrtYbm6u3lgWuNBSLDmZ
	3es0+gCk9V59oodUi4WKOAMtbFoYTXm8g+nFRqB0q6IlCkr0cjub1GGlDR1/H/lGh6KoHBHunYH
	/iPrSaosX35j3lktwNh8MiKVaX+1HbkB5Wz3BUUHg8yiqeyiMKqAd87DgGcuGWoZJKEBpDhQpj3
	lPR/M7Bls+pTbNPXUstHZvdxOAKlICu8KWzGdpBb34PlxmeA=
X-Google-Smtp-Source: AGHT+IEoipZFimoNBiDhc1/4axfkwS552h+W+9sHMO01cPqmsLgh+C+piLIuDf1REtZEpI48PziaFQ==
X-Received: by 2002:a05:600c:1f94:b0:453:c39:d0c2 with SMTP id 5b1f17b1804b1-4538ee8562dmr170282735e9.24.1751363998945;
        Tue, 01 Jul 2025 02:59:58 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:700:a501:8515:f93a:c957:e0a3? ([2a0a:ef40:700:a501:8515:f93a:c957:e0a3])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-453b3542838sm10272225e9.1.2025.07.01.02.59.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 01 Jul 2025 02:59:58 -0700 (PDT)
Message-ID: <7686a5e0-23c3-4e3a-b5ea-3b8c80ba54fa@gmail.com>
Date: Tue, 1 Jul 2025 10:59:55 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 4/4] add-patch: add diff.context command line overrides
To: Junio C Hamano <gitster@pobox.com>,
 Leon Michalak via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,
 Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
 Eric Sunshine <sunshine@sunshineco.com>,
 Christian Couder <christian.couder@gmail.com>,
 Leon Michalak <leonmichalak6@gmail.com>
References: <pull.1915.v2.git.1746884789.gitgitgadget@gmail.com>
 <pull.1915.v3.git.1751128486.gitgitgadget@gmail.com>
 <b68c58b667c29c66433b4634ad44ee9ec5257e80.1751128487.git.gitgitgadget@gmail.com>
 <xmqqplel17s3.fsf@gitster.g>
Content-Language: en-US
From: Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <xmqqplel17s3.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 30/06/2025 18:03, Junio C Hamano wrote:
> "Leon Michalak via GitGitGadget" <gitgitgadget@gmail.com> writes:
> 
>> From: Leon Michalak <leonmichalak6@gmail.com>
>>
>> This patch compliments the previous commit, where builtins that use
>> add-patch infrastructure now respect diff.context and
>> diff.interHunkContext file configurations.
>>
>> In particular, this patch helps users who don't want to set persistent
>> context configurations or just want a way to override them on a one-time
>> basis, by allowing the relevant builtins to accept corresponding command
>> line options that override the file configurations.
>>
>> This mimics commands such as diff and log, which allow for both context
>> file configuration and command line overrides.
> 
> I skimmed the patch briefly.  I am not sure if it is a good idea to
> 
>   * add OPT_DIFF_*() macros to parse-options API, as its utility is
>     very narrow, and forces those who are learning parse-options API
>     to learn one more thing.

It means that we have consistent help for all the commands with these 
options which I think is valuable. We have a number of other macros that 
define options that are shared between commands and I think that works 
quite well.

> 
>   * validation of the value range to be duplicated for each and every
>     users of the new OPT_DIFF_*() macros.

Yes the validation is awkward. If we changed the OPT_DIFF_* to use a 
callback that rejected negative values that would reduce the duplication.

> but other than that, looked reasonable to me.

I've left a couple of comments on the tests but the code changes look 
reasonable to me too

Thanks

Phillip

