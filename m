Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D69B17556
	for <git@vger.kernel.org>; Fri, 28 Jun 2024 02:47:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719542841; cv=none; b=oqKHCK6KrQxgxezPfVGPUz9XGLT8TYSaF/Zzd6iefyfKcEGU6oZVFNmF8n8q8D4oIrFfCMkHcZOnL1DX0SWLNxASxsZXIyrDquDEYhe6w8Ju6RPqSnKfoswktve4HTq46UYZ/cd15ExHoPR3JSCFB00kBVLc7Xq5uonDJV1hZjw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719542841; c=relaxed/simple;
	bh=JEUB10cVVW/BZUPfyXlQ1vm6V+yiV8+DIBDM/RSkXdc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=m/kwoPvAw1GJOLBSZAjgoKXjsCKm2tuBQa/nKeqtv2zA0Xm/o12oB07zGBEapnGiAsekCgGWjVAeW39DD42pmegFUPmvxlqXZcbJD8gDKgayEGpqFp7jChX7utiGAhr9KskoOG0GfEzyjFX2kMZrpoV10AsLq6VP+8U6mahLCoo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AKEWmvcq; arc=none smtp.client-ip=209.85.128.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AKEWmvcq"
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-632597a42b8so1433037b3.3
        for <git@vger.kernel.org>; Thu, 27 Jun 2024 19:47:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719542838; x=1720147638; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=K2lmA4CBQeb2bO1sBca3CP2jzegxfQjVhZNus+Z4OHU=;
        b=AKEWmvcqZm6nO9bpSstf0eMiNxFh52UIuvMZABW/prd3m0J2mehLZKxbkiSlD2eEN3
         /PKh2ry2PlLQVA/mxk8NlkPN9Qc66XhSVEmS1ci4QXNpiHhVjua4XJoplHEx3Bc6M8nW
         MXYApHfm6ZjS7vKWqBprO6XITMDYksRPU7WHG9uM6+Q5NJkkWWOG8tItV+nNN5B/jG8c
         ZhvToSSJkeWl9zxRyuXjxJuJLBj/5HuZ26MaL1zivham7mRI5460h+8yglU0KqS33URa
         +AfD1vC8GTjKarggvNBbhWSXWe57hIIpAnpD5jRB3v5wJtJbNPB+lSW5lNRrfPCQF7D1
         EcAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719542838; x=1720147638;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=K2lmA4CBQeb2bO1sBca3CP2jzegxfQjVhZNus+Z4OHU=;
        b=oIEGMvX6p92UiGLnrFuJ1MlDQdglqfGTfGiLidn8E32APtpiVoxoFtfFskTi8P/0e3
         haGb4KJanNtLeHcMtQEO0mNvx6HOsfS9iHyMkkiJCgeJwLU2ovJrN4SSgjAFsPh7cRSo
         //iI9eyPLrCGD5hZndzzkdOUm3ddVPzEbookKvdG/FACudNpN3sdOUDmiVMjyFtgXIhx
         eW4j945QU7i1FPtyFVXWMDE9cuwT1JMHqJyKL9xVzilp8ZDWD4+DzSeB2fAVO4h9rOS6
         9T4ntWC4RhFWvxl6GkPh5VhHZ/DBOBE92ska2G0dIYTce0aPPPBHGdNMi9aRtaWsXMJi
         UeAQ==
X-Forwarded-Encrypted: i=1; AJvYcCVSgJD2yv8zNRA44UNvWAtk3xzDVvLO+wCSF0yc/2obx8BFWtCrrAx4xAeUwNJXLxm9TCPilG/vjYAI1yDYA2vx8/F9
X-Gm-Message-State: AOJu0YwQvntQs9pCMopzpg9V1Z4d+qTaphCjkEVEI2+5Nsps/LlLukaD
	umMmTz/WWN+Ta+pL+47mc+tFYPA0QpRsmRyCXvrcA2Gt/tvQf74o
X-Google-Smtp-Source: AGHT+IEWUUQ4/Od/NWBdVLJaXaYCbwJ27zq7y3kyLqH2RtAhK2LynfhBgs4eSoE7kx6wDI8hwl39gQ==
X-Received: by 2002:a05:690c:f07:b0:64a:4db2:d7c6 with SMTP id 00721157ae682-64a4db2d92amr28644757b3.2.1719542838478;
        Thu, 27 Jun 2024 19:47:18 -0700 (PDT)
Received: from ?IPV6:2600:1700:60ba:9810:5cca:8078:1e70:3d3c? ([2600:1700:60ba:9810:5cca:8078:1e70:3d3c])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-64a9a331e33sm1892627b3.58.2024.06.27.19.47.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Jun 2024 19:47:18 -0700 (PDT)
Message-ID: <1b7f9579-e583-4393-8410-1bbbf882e70f@gmail.com>
Date: Thu, 27 Jun 2024 22:47:17 -0400
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/7] merge-ort: clearer propagation of
 failure-to-function from merge_submodule
To: Elijah Newren <newren@gmail.com>
Cc: Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
 git@vger.kernel.org, Taylor Blau <me@ttaylorr.com>,
 Eric Sunshine <sunshine@sunshineco.com>
References: <pull.1748.git.1718310307.gitgitgadget@gmail.com>
 <pull.1748.v2.git.1718766019.gitgitgadget@gmail.com>
 <2813a15b48b70ead7e3fd062d1b49baee665fc9d.1718766019.git.gitgitgadget@gmail.com>
 <63caecb4-19cd-4b6f-91f0-bd00df2ecb54@gmail.com>
 <CABPp-BHgd1Diqaiqc+a+UinHb947iwEx99cpVFqckUGXjmGVsQ@mail.gmail.com>
Content-Language: en-US
From: Derrick Stolee <stolee@gmail.com>
In-Reply-To: <CABPp-BHgd1Diqaiqc+a+UinHb947iwEx99cpVFqckUGXjmGVsQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 6/27/24 10:38 PM, Elijah Newren wrote:
> On Thu, Jun 27, 2024 at 7:12 PM Derrick Stolee <stolee@gmail.com> wrote:
>>
>> On 6/18/24 11:00 PM, Elijah Newren via GitGitGadget wrote:
>>> From: Elijah Newren <newren@gmail.com>
>>>
>>> The 'clean' member variable is somewhat of a tri-state (1 = clean, 0 =
>>> conflicted, -1 = failure-to-determine), but we often like to think of
>>> it as binary (ignoring the possibility of a negative value) and use
>>> constructs like '!clean' to reflect this.  However, these constructs
>>> can make codepaths more difficult to understand, unless we handle the
>>> negative case early and return pre-emptively; do that in
>>> handle_content_merge() to make the code a bit easier to read.
>>
>> This patch is correct and valuable.
>>
>> Would it be valuable to go a bit further and turn 'clean' into
>> an enum that reflects these states? Perhaps that would prevent
>> future changes from slipping into this mistake.
> 
> That may make sense to investigate, but I suspect it may be a bigger
> change and would recommend making such a clean up a separate series.
> 
> Also, I'm curious if it makes sense to finish off replacing recursive
> with ort first; as long as recursive exists, it has the same problem
> and in fact was the source of using a tri-state 'clean' variable and
> thus would need the same cleanup.  But if we replace recursive with
> ort (making explicit requests for 'recursive' be handled by 'ort', as
> originally designed and intended), that cuts the number of sites
> needing this cleanup in half.

Your fast response to this message means that I didn't see this when
I mentioned it in my closing of the review (in response to your
cover letter).

Reducing the size of the conversion would definitely be good to do,
and then you could also consider using the existing ll_merge_result
enum, though it technically has four states.

Thanks,
-Stolee
