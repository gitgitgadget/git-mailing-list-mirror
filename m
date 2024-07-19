Received: from mail-oa1-f41.google.com (mail-oa1-f41.google.com [209.85.160.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1192364BA
	for <git@vger.kernel.org>; Fri, 19 Jul 2024 16:20:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721406043; cv=none; b=L8tk/wApf8mr94lBpnG4EzMQ7bK35A5sqT/mntlFy2cJ032ZlAcv4xiONCtOGxZTuTrUdCG2rxNUdWmLx9h29biCRTGt8J5bUObW/bxVmowYs6XzIbPo0sZdbWtJJqodh+3y3ZGjTzwy3Mk0uMQr+DJeHlU/ktqRP9C3YZpwnPY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721406043; c=relaxed/simple;
	bh=GszevnCUL7P/6zjcyTv5FY0cX/1zTj15pDiVwuUE/HM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cMCucTyuej8pK/BVUrtZA189ctntjrn8TDfCaJ8uV5qo/dWGXuR/8R9kgvi/r7WRg2OnJ6YW1EH+mZ9t1sF+vMGgpb0OJfN74n5qtbN3XK/W2sgnhyAkkiBJzmQOv15pk7b06nz03WekaQDi84pO5a7gasbHqGxYJHQo8CnzmE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VNtvjHIo; arc=none smtp.client-ip=209.85.160.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VNtvjHIo"
Received: by mail-oa1-f41.google.com with SMTP id 586e51a60fabf-25e3d388580so1068445fac.0
        for <git@vger.kernel.org>; Fri, 19 Jul 2024 09:20:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721406041; x=1722010841; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wH2LWMGlgqV4nGAIiQqD7vOJgs4z0pVuZI1iujP3JYs=;
        b=VNtvjHIohBzLwywp7rmM7UfODWU4CdnzQwzSP/SXLIYqUEM/7rscDUEba21rm2pnID
         tQMM1cMR/HsfF/UwbX/DkENradIw6IQBktrUw00Jwyy146AAZYil+Sg/zRTG6H+YKgWM
         X72ZcdWTyNtlcnNNPMuvovZLXQxc4oiibbsfvknJ4knpxn3Ph35adBlO5os21+miVAsq
         iSDRAycAjPytgtSXUCCSQBNmSVL65zYFbfSwCb+lSddMjfvQFP+ugTyOccaAT9ZLTruV
         8fqaQb6WLeRpnetf0tax+YA5qQvPOglu2LCpOOWgUGQ1CHxfgcj21+l9ENNi3/TsZJxi
         CgrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721406041; x=1722010841;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wH2LWMGlgqV4nGAIiQqD7vOJgs4z0pVuZI1iujP3JYs=;
        b=O60Ps4iyaBR7tYALTvTVYqBMNXbrphPDiFbSNiHihjTw6ihLWto5gv59nbCa4KM+mL
         4d94Ca9YN+Uvu4MLADbbNb850k863wefoRMpViWiD+K4LFQTL6SUVaE2M9sis+tbqHIk
         Soev2aTEZtJ9FGjdE9Xht+fUZwdplxeTwr7e4N8qb0oa7/UlQq49VnYwndqhhlR8w65P
         i071tYPKFuC/MP87yJwRbAojFeJZA9YL82y3Y+VyFkc+2H5CJyGuvK9JQT1J2HFw/0mQ
         GYSFPw7UTIz5Z5SRZgKLuBSnopzvU6C1WGBvRjnxoUXkfxqu0Sa39ZdinZcJ3tCq/HzW
         4Ykg==
X-Forwarded-Encrypted: i=1; AJvYcCVfEG5TGd5gX5RUzBZ738O34g2gPR9o16O3mlg3+u8/Zdobe9YHc99gqtNJti4AiS3CEZJjJfpPDQhV8PLblmw4Y46Z
X-Gm-Message-State: AOJu0YypCqV7MBxbzDgfM267P0HRmMa3qRCSZf9o1xl3OrvjFakMFa51
	fnbGy3ZoTIOmz0TkdKOV4GcDvozCZsNedWfVHkDZjoUC5RFj1ML+/CFs4A==
X-Google-Smtp-Source: AGHT+IGcmUCL8D0flE/ZZS4ozmF6QX5gnX8ZjFp2cRfYht2boL49jukt36U+qHQ90ea2njcg7mzKIw==
X-Received: by 2002:a05:6870:c05:b0:261:12a8:5b69 with SMTP id 586e51a60fabf-26112a88a8dmr1470787fac.18.1721406040680;
        Fri, 19 Jul 2024 09:20:40 -0700 (PDT)
Received: from ?IPV6:2600:1700:60ba:9810:2173:6d19:3a2d:9c4d? ([2600:1700:60ba:9810:2173:6d19:3a2d:9c4d])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70cff4913fasm1375135b3a.1.2024.07.19.09.20.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 19 Jul 2024 09:20:40 -0700 (PDT)
Message-ID: <861420aa-e423-4475-8eba-8ec5187c52d4@gmail.com>
Date: Fri, 19 Jul 2024 12:20:38 -0400
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] Fix background maintenance regression in Git 2.45.0
To: Junio C Hamano <gitster@pobox.com>
Cc: Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
 git@vger.kernel.org, Taylor Blau <me@ttaylorr.com>
References: <pull.1764.git.1721332546.gitgitgadget@gmail.com>
 <xmqqle1ynz18.fsf@gitster.g> <81c7bd02-0c2d-452f-800e-ca0d3853a941@gmail.com>
 <xmqq34o5l8j7.fsf@gitster.g>
Content-Language: en-US
From: Derrick Stolee <stolee@gmail.com>
In-Reply-To: <xmqq34o5l8j7.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/19/24 11:13 AM, Junio C Hamano wrote:
> Derrick Stolee <stolee@gmail.com> writes:
> 
>> On 7/18/24 5:57 PM, Junio C Hamano wrote:
>>> "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com> writes:
>>>
>>>> Here is an issue I noticed while exploring issues with my local copy of a
>>>> large monorepo. I was intending to show some engineers how nice the objects
>>>> were maintained by background maintenance, but saw hundreds of small
>>>> pack-files that were up to two months old. This time matched when I upgraded
>>>> to the microsoft/git fork that included the 2.45.0 release of Git.
>>> I almost said "wow, perfect timing on the -rc1 day", but then
>>> realized that this is not a regression during _this_ cycle, but a
>>> cycle ago.
>>
>> I almost waited until after the release, but I wanted to put the
>> information out there just in case you were interested in taking it
>> into 2.46.0 or were planning on a 2.45.3.
> 
> Yup, thanks but this is not exactly a repository breaking data
> corruption bug, and did not look ultra urgent.  Especially if we
> want to pursue a solution that helps both expiring stale packs
> better (which is what you are restoring) and making better delta
> chain selection (which may be what you are losing) at the same time,
> such a change could become a source of data corruption bug, so I'd
> prefer to see it started early in a cycle, rather as a last-minute
> "let's fix this too".

I agree with this assessment. The microsoft/git fork has taken the
revert as users of that fork have a higher chance of being affected.

Thanks,
-Stolee
