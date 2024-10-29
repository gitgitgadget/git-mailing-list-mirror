Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3BEA194ACA
	for <git@vger.kernel.org>; Tue, 29 Oct 2024 15:43:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730216602; cv=none; b=QIsvCVt7Q/UcKzvKdg1uP+8L/iPRt9S/KWbkvI13NDLI/pVtnPY1+rAI3ZBQoZftgWN6aSGZw1nll4vMkhjb3jCorISXCgFbr4MGzcKTPoUMUioNvByK28rdt5i+AzsaFCm6niYgGKrxvEsI0qxvHVgqHNFYNkhAdfC1j+J6wnE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730216602; c=relaxed/simple;
	bh=pEoTyHclaseTeLxDE4ko2eaFaFdzviJBk25/O56M/ko=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=qshIQ4NsJ+wnzpZMCtJyMXW8IZCKO3mr7+hLgf6njSRHL//H2O427qBjKQzxqndeG0l+pO6LopPCCN7hV8lL3nL8zZMk2bt3l8ic4CtS4zxTHKiipmKGBZzSKWcZxuzdFTIFqN2nSQkruyqBrbkJx1eiPKeY1HfmgGxX6H1FAho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KanDPxuK; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KanDPxuK"
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-37d49ffaba6so3953884f8f.0
        for <git@vger.kernel.org>; Tue, 29 Oct 2024 08:43:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730216599; x=1730821399; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:reply-to:from:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=pdALx6zZwWetaKlfO561WD9WHZCnO2pd2GmdjW7d4vs=;
        b=KanDPxuKCXtvuqludd4ndAakBNyGEAVgkFrsy1frMjylnu/ytFSFs1V/M9ahZPeCi5
         NyJZEfWz4WaAEa/HPpOYTgRv7L6FdoT7/ouQWGRSatDO1QeBElbcHNutcMuES4slW/LZ
         uRGNkjS6f3BJzZxUdbKllbFx2e0GrI9ls1p/JiApGgiGe4t45xSM3rlRDFr+/Id/ILyE
         fHGfM+EZ8V6AWhHf0huXrC6JUE9R8Mmb3UyVdpVAJkdXTuzHLXbnG26vu+cSJLiyDsEO
         piHw4Wf5uUciDdYL8vHvLvztyfi7w9C6hEwVYO+skYGYzgqRNMNQvcd1KAIWbDlurKZH
         MT6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730216599; x=1730821399;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:reply-to:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pdALx6zZwWetaKlfO561WD9WHZCnO2pd2GmdjW7d4vs=;
        b=dV+tllq/o5T88lHL+AbM0NIKi+sJdRXgwVvBPq4yVvLNDaAbHzGiMY/0FaMZNq472I
         0cXQ1FZKg/tIimPN0qAYtHwcVkyn9UQGB8qjIlNCHoqjGA8Zhlz8jSvtAkn3IRy0xv2m
         88+/kjOmB+0gAMhd8baiEPApzWKseIKkKqs4g2vC6rFI5YKXb31v1SN4hf1sU8WoFQzC
         9sfUqSZ7JIEJf/UzEU/7/NKCuUrYwg/ZsX7encAtz9wAgkX1N8QhjnWed5nvL4mkzUr4
         3RhXBuQZN5KMJOFnD8UmplPgIIe4r2RQ4Fb0evZ2SZgyVPiBUSO7E+Tfapo2r7MlHpyV
         jVPg==
X-Forwarded-Encrypted: i=1; AJvYcCW+uUsgbofOG0gttxXY5PJGZEobRSF/dtBHRLx/B6a/bhoR2P0jUKhfTS8fLe/gLzg3Xgw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwHEwB+56GGt0vW+D/vao7obRSW6RGyv2AUmNvsBM/7H81mWL6P
	R50oFZaqRYsJy0slWVUgOKgbe+185dsFl8mzzArR2NZ3XbwwJr5NXH99Dg==
X-Google-Smtp-Source: AGHT+IFim+2LxhCrVBcVOdpVX/XQ2wj/hDQUMVaStk4e9vQUb4H2jvzIfZ4H28cO2JQEwyGQS3D6hA==
X-Received: by 2002:a5d:6388:0:b0:374:c059:f2c5 with SMTP id ffacd0b85a97d-381b7076de7mr78365f8f.22.1730216598950;
        Tue, 29 Oct 2024 08:43:18 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:6ac:1101:589c:aac1:dc59:c13a? ([2a0a:ef40:6ac:1101:589c:aac1:dc59:c13a])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38058b4ad08sm12855766f8f.64.2024.10.29.08.43.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 29 Oct 2024 08:43:18 -0700 (PDT)
Message-ID: <aeec08e2-29da-4e5e-8a73-7ed7e3a79177@gmail.com>
Date: Tue, 29 Oct 2024 15:43:17 +0000
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: phillip.wood123@gmail.com
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v2 3/5] worktree: add tests for worktrees with relative
 paths
To: Caleb White <cdwhite3@pm.me>, phillip.wood@dunelm.org.uk,
 git@vger.kernel.org
Cc: Taylor Blau <me@ttaylorr.com>, Junio C Hamano <gitster@pobox.com>,
 Eric Sunshine <sunshine@sunshineco.com>
References: <20241028-wt_relative_options-v2-0-33a5021bd7bb@pm.me>
 <20241028-wt_relative_options-v2-3-33a5021bd7bb@pm.me>
 <985646c7-8a16-4014-a379-644408157934@gmail.com>
 <D58DMTM9YPBE.8L5WT8ZNG1CU@pm.me>
Content-Language: en-US
In-Reply-To: <D58DMTM9YPBE.8L5WT8ZNG1CU@pm.me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 29/10/2024 14:58, Caleb White wrote:
> On Tue Oct 29, 2024 at 9:52 AM CDT, Phillip Wood wrote:
>> Hi Caleb
>>
>> On 28/10/2024 19:09, Caleb White wrote:
>>> This patch expands the test coverage by adding cases that specifically
>>> handle relative paths. These tests verify correct behavior in a variety
>>> of operations, including: adding, listing, pruning, moving, and
>>> repairing worktrees with relative paths configured.
>>>
>>> This also adds a test case for reinitializing a repository that has
>>> relative worktrees.
>>
>> It's nice to see new tests being added. If they were added with the code
>> changes they test that would help reader understand the changes being
>> made I think.
> 
> I had received feedback that the original patch was too large, so I
> was trying to split it up into smaller, more digestible pieces. 

One way to do that would be to convert the "add", "move" and "repair" 
subcommands in separate patches changing option handling and appropriate 
tests in each one rather than changing all subcommands and their tests 
at once.

Best Wishes

Phillip

I could
> go either way so it's really what the reviewers would prefer.
> 
> Best,
> Caleb
> 

