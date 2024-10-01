Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01CD163B9
	for <git@vger.kernel.org>; Tue,  1 Oct 2024 13:20:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727788805; cv=none; b=cvvwPyYgfY1WWRE0ZTevT/OExOwTlfXjUNaf4eODK+xXegOS+XNV5X4f7qkSJCY07QbMVotzwAk71MTVzqeGrHc5AHoX9+syS/Z115Uie0W1+fiJnj9iphELbOPowmtIiIGU/soZAqA1u4QaEIVXyWxuFlQa5s7eDv581g16YFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727788805; c=relaxed/simple;
	bh=PfaBAnGBKrWJ7megSO78w8ncTWPdS8NrQ1nGjh6EZSw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LJ9jy0xyGeHaGIVpfp32eikA3yKLnrzm7rhqD6ruSl9fKtZ8RRpzEvDsF2VcBs6HqdQsaKMgShrApP8Slk+ODwe6L2AdXzDGlc8c4AFArxbn0qf5NGkeUf7uro8fTeEm9JQY5l3cWXYQSxKPryG1JiKqDRKGox5MEPBoxxnYEl8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SwK7e1S/; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SwK7e1S/"
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-2e078d28fe9so4008636a91.2
        for <git@vger.kernel.org>; Tue, 01 Oct 2024 06:20:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727788803; x=1728393603; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=pOiH25WBWzatYmPgI3CMa5beVMDFoA9FljLyMHvrGnc=;
        b=SwK7e1S/K62JXwudSmtoLP1If1LnD+g2SMsP+qijqAMBQA5xVvgb551OaoewSAV0Y+
         T9W94cNA50gSL1TXEKXkSJEvFTkqZizrqzeh2U7605/uE6aazRFZg3CpI6De+HhK7UL8
         60NL3WwYBE3pqNVZPCPc4hYJzGRb9HkiE4pV16hhOzXKIxkT17o9SL4oYb50tFangGcS
         VAKZEApuhxK35x1rxj9+zclBJgrjJN5fLooY6iObq0wByCRrCNyUysC11CFzC+sLHoQd
         B2gTTt2N2rMEKPppBw/DbURb5PGiwTmQz4+ngR10XOU4BrHOtLQ2iNQJ5By8QRk1Nh2g
         uDQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727788803; x=1728393603;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pOiH25WBWzatYmPgI3CMa5beVMDFoA9FljLyMHvrGnc=;
        b=jkNeQsB+fRv2J7s15RGAnleWHtxS0mNuV1ybcp0dBy3ebERAPQBi8LwWIHoCkV4nT1
         p2DWILka0t1Cu8sfKbtnRG5JvIsjcxayoV0x0OQ9VRpx6YSGqYLePRTJ1iLz+aLF104U
         V9JhPcAO5AEO3WwHf6PUt+718gIYhFEzhDrq0jTwizi0/RlE1MYwE9Z9RyONvbukKiIO
         fSYdefn67JyQ1OP4LiO2dwP1J74zZIKDO8xubk2rF+dDCCP1mAsYfrbC1CYxXcNm5MB/
         VyBAUJXak/PVHRhH+jGGmaHorwMvbgCDy0F5yVMFxqaKJUjZwV9zsCpoKI9NVoBNBb9u
         0UWw==
X-Gm-Message-State: AOJu0YzdiOJ3ZfmwJ0TVgJw96luwZyHAbNGULlxTFRwC7ODBEuQaB9PV
	YFFyRnum3ZAjDMUEbD/Rfd7IUI9VHoJMAiewF4n/N347QqjyqcKz67nfYA==
X-Google-Smtp-Source: AGHT+IGL8FTQ+SYvd1GLeyhtKJK6v41zXOd4YU6hm/JGKf3mox3JkkuFVcdPqsGucnnm17cPNF7a0w==
X-Received: by 2002:a17:90b:3607:b0:2e0:899d:c8a0 with SMTP id 98e67ed59e1d1-2e0b899cc5dmr16683439a91.8.1727788803026;
        Tue, 01 Oct 2024 06:20:03 -0700 (PDT)
Received: from ?IPV6:2600:1700:60ba:9810:f0c7:be19:c0b9:ffdb? ([2600:1700:60ba:9810:f0c7:be19:c0b9:ffdb])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e0b6e22cc7sm10089848a91.50.2024.10.01.06.20.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 01 Oct 2024 06:20:02 -0700 (PDT)
Message-ID: <8ebebcd5-4ddb-4c1e-9bf8-4e9a79944e2b@gmail.com>
Date: Tue, 1 Oct 2024 09:20:01 -0400
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] read-cache: free threaded memory pool
To: Patrick Steinhardt <ps@pks.im>,
 Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, gitster@pobox.com, peff@peff.net
References: <pull.1801.git.1727696424.gitgitgadget@gmail.com>
 <9a45b15ea4b9864cd3cff066ecd9281c4539d5f7.1727696424.git.gitgitgadget@gmail.com>
 <ZvqaTqegJxow1x-b@pks.im>
Content-Language: en-US
From: Derrick Stolee <stolee@gmail.com>
In-Reply-To: <ZvqaTqegJxow1x-b@pks.im>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/30/24 8:32 AM, Patrick Steinhardt wrote:
> On Mon, Sep 30, 2024 at 11:40:23AM +0000, Derrick Stolee via GitGitGadget wrote:
>> From: Derrick Stolee <stolee@gmail.com>
>>
>> In load_cache_entries_threaded(), each thread is allocated its own
> 
> s/allocated/allocating/

You're right that the wording is awkward but I'm not thrilled with the
suggested alternative.

Perhaps "each thread allocates its own"

>> memory pool. This pool needs to be cleaned up while closing the threads
>> down, or it will be leaked.

> Okay. We move over the contents of the pool, but forgot to free the pool
> itself. As far as I can see the pool is always allocated and only used
> in two functions, both of which assume that it is allocated. So I wonder
> why it is allocated in the first place instead of making it a direct
> member of `struct load_cache_entries_thread_data`.

I took a look at what it would take to replace the pointer with an inline
struct but found complications with situations such as the find_mem_pool()
method. While we could replace some of the logic to recognize the new
type, the existing logic seems to depend on using the NULL pointer as an
indicator that the pool should be lazily initialized.

If we were to pull the struct inline, we would either need another boolean
to indicate initialization or lose lazy initialization.

I'm leaning towards the simpler leak fix over the disruption of that
change.

Thanks,
-Stolee

