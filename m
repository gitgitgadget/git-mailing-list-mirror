Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 297D21A6836
	for <git@vger.kernel.org>; Thu, 21 May 2026 09:46:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779356784; cv=none; b=Jf3ApzD0ihGju/w43jTRv8FojPQfVnsQMqz8LPxzw58guftF5RqIEiiHxZNW3qKF00yOo1KkeUWF+vqkzeLqapWlPmNRwvXgVQs1kEjEOZsMNLa7Yuj1zMe+bIscybi7vtM+zBdr218YFZ/xxX7DL387A2/wxkuSFjYC/aVM+ao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779356784; c=relaxed/simple;
	bh=kwtZ17R7QYkC00iZxDDEgnF0dfJ1scmpRYUGY6bGKkI=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=QasHmzLc0b8iP2YsXfPcGXIcXUDFhBPEf70o8Hqfaw25iQ53Hkm7+1+paUIBfYRVw7ee2yth20uszJiKvSzKtY0+00kXcG2+8b5IWxdxQeLdnyGfBJ+fFKHbpSJwbrcYf5s6Ui3++1hflRFskktOfdtqQDWsew3CEQBmAI9sjUw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Cyf6pEx+; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Cyf6pEx+"
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-44509921fbcso3753809f8f.3
        for <git@vger.kernel.org>; Thu, 21 May 2026 02:46:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779356781; x=1779961581; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:reply-to:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Q63WGPx/JyvDPRCtwnx8Fgd8aQtQF6Pjaefc0aV5IlI=;
        b=Cyf6pEx+zLDgSHhsJwzWMT0mgYt/KtGy6N9uQ03+DhbDW3zgPaRrJMD1fjbpA3Fud8
         xyFDiLKMw9PZ9o/DU1hOrglZCenzc+hmnPluWM4Q8uETGZTttBV2wEbFO86drQU5/U+z
         yMxyzl8IVVuyVzu2gcJ+6FY8ZWoNsF/8sSj5ADwxdrBomJjW8EPvg0c+6FcwG6zS2Uf2
         pYRY+e1uEh1E3/3kiW6UsCQsSX762/rrJwIlAtuV7xwnpJPTqEgYUUd+jezxFXiQXJWD
         HaNYBBm0H33wPYs/WdoxhsnArHaGv2irxLDR765eqFHZU9uqqeFkoTOELtE6/X2z39B0
         6GEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779356781; x=1779961581;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:reply-to:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Q63WGPx/JyvDPRCtwnx8Fgd8aQtQF6Pjaefc0aV5IlI=;
        b=ORj4uhZaRTZrQWFZp5CMfBSX1Ciwr88yHoLjSHiUrJ4gzU00DX4ETCj71U2VJSapSR
         Q3J7MMpRhAoZZIZjY4gHbrfz/y6iLMIPAAf2u56GXFLZ6uM5B8GBy0bxfjSK/dqMXAQp
         kRdxyaOnG1ZnBhawM9bgLNVHbF6ALLXYu8yN68YqWuYpl72BLSxTpgS7XuZVtk1BZxo1
         pgAJtg0cdUDcJU/mQrrcDxkoY2l3Fj08LvSdK2vsPFYdVVqdxrizNX+NkR0AfDV7mRD4
         B4WHr7IOrAw0G1/4ACqk0DTlAtF8p2fUzP/R0E51Wf0Bun2ndnXmfB35yuEtcHP49WHg
         cN2g==
X-Forwarded-Encrypted: i=1; AFNElJ/GNA6B9JqhpJO9s0UIptUSo1LhOO5z/J1uqro7oU6+sYx9c7LAHnZCkii8vmA9d6olbBU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwYIsb2a7me3v0qM7MlMCroqxxC9dxMf6PQ7MBJuXkc8LOX741h
	rmp4PofWOsq2JuwSWUlSvv2m/5FVkTlRlULbRCkWuePzjA+IYOUtQVOc
X-Gm-Gg: Acq92OHcTYwOcBs718NkAEWWDzOx/iBypoo4wgZIYTQP4XbvE9qDht14si2xRQnIlrf
	8iXB7B7ZDR88tPwBPiaqiCOp10L1D8mOg3MGVBONvxkj/IGsUg55zslbWNPstY39HMYKdGyca89
	JzN4oJbJzWVLriMhymuyatKjl+itcdFRejKsLXdzeT8qd463zU9T6tUUTAe38OfnnU69thTWfRO
	2hWiM3M/fU3OYeL1syTyD6/Y1onPtA+w5SVBUgJb3eTDsb2b4LP4ibkntFC7t5xdsNfHi8U/E1h
	mXCBbUNG6WKNZBrCdNj/vw9+NB6MuNVG9RqayTA99lpC3gngEGMRQeXsLVxVCPwBy6klKIPquIt
	7beRe2EBh8HV6muWYltyWKBSHfl6yB1p1fp1P5CvVMTkcvBRABmC9TwUIthBXzNJ+RxGvHx9HM8
	jvL8RTmKUvWN+TD++LhgKwDInGdN0kut9kpCdbcQyJnwUD9iybmsiQHd3fNRS/JSuMfVhfQLJdO
	xI=
X-Received: by 2002:a05:6000:2dc5:b0:43d:7bc9:9b2c with SMTP id ffacd0b85a97d-45ea38b509cmr3504068f8f.17.1779356781271;
        Thu, 21 May 2026 02:46:21 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:638:c001:a103:efc2:6ce:f580? ([2a0a:ef40:638:c001:a103:efc2:6ce:f580])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45eaa93ce5fsm1493267f8f.33.2026.05.21.02.46.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 May 2026 02:46:20 -0700 (PDT)
Message-ID: <f1d15d08-6fee-479f-8ed0-34efd256d8dc@gmail.com>
Date: Thu, 21 May 2026 10:46:17 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v9 3/5] branch: add --prune-merged <remote>
From: Phillip Wood <phillip.wood123@gmail.com>
To: Harald Nordgren via GitGitGadget <gitgitgadget@gmail.com>,
 git@vger.kernel.org
Cc: Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
 Johannes Sixt <j6t@kdbg.org>, Harald Nordgren <haraldnordgren@gmail.com>
References: <pull.2285.v8.git.git.1778605658.gitgitgadget@gmail.com>
 <pull.2285.v9.git.git.1778700883.gitgitgadget@gmail.com>
 <f87e96e99d64c48bd92afecf3a6a819d36e56f6c.1778700883.git.gitgitgadget@gmail.com>
 <6501a3d5-a5ec-421b-8526-ee7d4ae5ea98@gmail.com>
Content-Language: en-US
In-Reply-To: <6501a3d5-a5ec-421b-8526-ee7d4ae5ea98@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Harald

A couple more thoughts ...

On 18/05/2026 16:27, Phillip Wood wrote:
> On 13/05/2026 20:34, Harald Nordgren via GitGitGadget wrote:
>> From: Harald Nordgren <haraldnordgren@gmail.com>
>>
>> Delete the local branches that --forked <remote> would list, but
>> only those whose tip is reachable from their configured upstream
>> remote-tracking branch (branch.<name>.merge): the work has already
>> landed on the upstream it tracks, so the local copy is no longer
>> needed.

While we want to clean up topic branches, we want to avoid cleaning up 
branches like "master" which follow an upstream branch and therefore 
look like they've been merged straight after they've been pulled. So I 
think as well as checking that the local branch is merged into its 
upstream branch, we want to check that the local branch is not pushed to 
the upstream branch i.e. that branch@{upstream} != branch@{push}. That 
should also avoid deleting newly created topic branches that match their 
upstream (I think that's probably less likely to happen in practice as 
I'd expect the branch to be checked out and therefore protected against 
deletion).

Also as this is a destructive operation (there is no way to restore a 
deleted branch and its reflog) it would be good to have a --dry-run option.

Thanks

Phillip

