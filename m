Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E36A7208A7
	for <git@vger.kernel.org>; Wed, 13 Nov 2024 14:49:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731509371; cv=none; b=KhyCZ48c2Y6BnghWHy9r9Zr6xp1oN4p+wFn5QAN0O4InNu5MuORsyjxAxbNmnRN1mlY+EBvb2DD2YyDf6GULmK1fWp9d0PT1fYsTVwWfnb0fn9V5rwOjQ+OpMKzymBwL4N9TONHJS0I4M5vz7271QxWeGgG0PK/kj4lqxSgAcVU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731509371; c=relaxed/simple;
	bh=MLzMweU4BXUkyeGlXVK8VIuR7MygYQF9VFzf5HGAcdM=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=NpJ5k0rePun/tgBTWn9jGelUOuxWARPECtwfwWKEUaod8ShsQK7yT6ULpd9sZ4oESaEQnVZr5qo9HrRPcyPV3FncYiYtsAbmU90p4j56It+Ir91ws9BaCbozEh7IpQZHnbs2xb2aQO85w9hZfjmj0mVgL3umqasau/N++unEP3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XOssWuqz; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XOssWuqz"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-43162cf1eaaso87080755e9.0
        for <git@vger.kernel.org>; Wed, 13 Nov 2024 06:49:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731509365; x=1732114165; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:reply-to:from:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=d06f6F8XAU02D189S5LQ46M/KBWwSBLDROH5iJolYXE=;
        b=XOssWuqzJ/LEyW/RBtw25YCNP85q9XDmeMmfe4jNPzIn76sW07YQf6HCMRBKjHAswO
         eBt/UleNo0rP898Sx0b0/yD/oafXtFbIvtr4soCoTlMr4MfyJGEvDRLkqoF/tesu0YPP
         Q7gLBxLqosjzh+1Kz1WxvPATsCxOBNAlw0Mk/mEe6ZLIvS6c18z469f/NMM0u0Y+/657
         HCtQAp98FvBFCa+MLq1W/rJ2YxclYSfHAxDSft/Y6kSgHCnmCA5LT6kL5yAYBJCQ7mF+
         EQoaRozhkjMzRkKeIW6y3WPIgUihCTOA822j7cbklL5Pxxoe8NhIIztkMxJS7iGYUgIC
         5T9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731509365; x=1732114165;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:reply-to:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=d06f6F8XAU02D189S5LQ46M/KBWwSBLDROH5iJolYXE=;
        b=s8+erKy+y2C/vHtzi9eMkHAFXvol/RCARgFzKZ0qs9Lb7ZxSSzy3QCQEPvDpzyuUST
         AzM18gPB5+2b0/Fq1izZvscUpkZHufMtHq/8wKavRUzeUYs3SGSHoMN9fi2qhd9Uf4a1
         oGQfxXQO+5phR4+XEgCmuq00lk3r0U/wYuX2NIuWg3+ZjbkdrDnyl2RtYJ8WIRnvsNuX
         b4kbzXg6QtNNqC7W8zH5QKEnFOzcQar5phLiyY9oKiUcm39zUFgf6OT1QHjFSu8py6Jv
         OPybkBcUSWx7meAbxI5pF4F62TZBaMiMpp9luNDCvwFcGSYmhXv/sDRbi/dCkJBbyXT8
         IGxg==
X-Gm-Message-State: AOJu0YxtOwaJgzCDtxiD2UWxLmU6YsZ1D3QjodxQlpdhxbCkf8Xlt6bk
	1Xoa/knIrLqMfJYgZXfbC0WnO2bXyFTKUvhziOTjKsnQz9PjIBe7
X-Google-Smtp-Source: AGHT+IE7T9IrQN/b39bHqImov7ICauSHQ3lrlqzim0M/ajfzoM9nowXTMCSHpcKlun6d9LseaQyUlw==
X-Received: by 2002:a05:6000:1564:b0:37d:4376:6e1d with SMTP id ffacd0b85a97d-381f1884855mr22063988f8f.41.1731509364953;
        Wed, 13 Nov 2024 06:49:24 -0800 (PST)
Received: from ?IPV6:2a0a:ef40:6a8:b801:610:d596:f87c:e591? ([2a0a:ef40:6a8:b801:610:d596:f87c:e591])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-381ed7d2c0fsm19114254f8f.0.2024.11.13.06.49.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Nov 2024 06:49:24 -0800 (PST)
Message-ID: <711b59d7-e649-4031-8924-a16fb632b4d4@gmail.com>
Date: Wed, 13 Nov 2024 14:49:25 +0000
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: phillip.wood123@gmail.com
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v2 3/3] sequencer: comment commit messages properly
To: Junio C Hamano <gitster@pobox.com>, kristofferhaugsbakk@fastmail.com
Cc: git@vger.kernel.org, Kristoffer Haugsbakk <code@khaugsbakk.name>,
 stolee@gmail.com, me@ttaylorr.com, Phillip Wood <phillip.wood@dunelm.org.uk>
References: <5267b9a9c8cc5cc66979117dc4c1e4d7329e2a03.1729704370.git.code@khaugsbakk.name>
 <cover.1731406513.git.code@khaugsbakk.name>
 <86b4b485e0b3ef023a5d559f437eae22f2fd458f.1731406513.git.code@khaugsbakk.name>
 <xmqqpln02bee.fsf@gitster.g>
Content-Language: en-US
In-Reply-To: <xmqqpln02bee.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 13/11/2024 01:03, Junio C Hamano wrote:
> kristofferhaugsbakk@fastmail.com writes:
> 
>> From: Kristoffer Haugsbakk <code@khaugsbakk.name>
>>
> 
> Describe what happens when a custom comment string is used without
> the fixed code in this space.

It would also be helpful to explain how to trigger the bug [1]

If I remember correctly it was Taylor who first noticed this [2]. If so 
we should credit him with a "Reported-by:" trailer.

>> Co-authored-by: Phillip Wood <phillip.wood@dunelm.org.uk>

It seems odd to me to have a "Co-authored-by:" trailer without a 
corresponding "Signed-off-by:" If someone has contributed enough to 
deserve "Co-authored-by:" then they should be signing off the code they 
have contributed. In this case I'd be happy with "Helped-by:" instead 
but feel free to add my "Signed-off-by:" if you want to keep 
"Co-authored-by:".

Best Wishes

Phillip

[1] 
https://lore.kernel.org/git/cfa466b8-a87d-4b5d-b330-6c660897de48@gmail.com/
[2]https://lore.kernel.org/git/ZxlEJ+44M8z03VOj@nand.local/

>> Signed-off-by: Kristoffer Haugsbakk <code@khaugsbakk.name>
>> ---
> 
>> +test_expect_success 'conflicting fixup -C after fixup with custom comment string' '
>> +	test_config core.commentString COMMENT &&
>> +	test_when_finished "test_might_fail git rebase --abort" &&
>> +	git checkout --detach A3 &&
>> +	test_must_fail env FAKE_LINES="1 fixup 2 fixup_-C 4" git rebase -i A &&
>> +	echo resolved >A &&
>> +	git add A &&
>> +	FAKE_COMMIT_AMEND=edited git rebase --continue &&
>> +	test_commit_message HEAD <<-\EOF
>> +	A3
>> +
>> +	edited
>> +	EOF
>> +'
> 
> Doing so would allow readers to imagine more easily how this test
> would catch breakages when the code is not fixed (or broken again).
> 
> Thanks.

